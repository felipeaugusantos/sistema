unit Expedicao.TSQLSeparadorLocalSeparacao;

interface

uses
  Classes,
  SysUtils,
  StrUtils,

  Expedicao.TManutencaoSeparadoresPorLocalConstantes;

  Type

    ISQLSeparadorLocalSeparacao = Interface
      ['{7BC3F194-423A-4ACA-B703-2EEDEA144E04}']

      function fRetornaSQLItens( strCodigoEmpresa : String ) : String;
      function fRetornaSQLLocaisSeparacao( strCodigoEmpresa : String ): string;
      function fRetornaSQLUpdateLocalSeparacao( strCodigoEmpresa : String ): string;

    end;

    TSQLSeparadorLocalSeparacaoPorItem = class(TInterfacedPersistent, ISQLSeparadorLocalSeparacao)
    public
      function fRetornaSQLItens( strCodigoEmpresa : String ) : String;
      function fRetornaSQLLocaisSeparacao( strCodigoEmpresa : String ): string;
      function fRetornaSQLUpdateLocalSeparacao( strCodigoEmpresa : String ): string;
    end;

    TSQLSeparadorLocalSeparacaoPorLocalizacaoFisica = class(TInterfacedPersistent, ISQLSeparadorLocalSeparacao)
    public
      function fRetornaSQLItens( strCodigoEmpresa : String ) : String;
      function fRetornaSQLLocaisSeparacao( strCodigoEmpresa : String ): string;
      function fRetornaSQLUpdateLocalSeparacao( strCodigoEmpresa : String ): string;
    end;

implementation

{ TSQLSeparadorLocalSeparacaoPorItem }

function TSQLSeparadorLocalSeparacaoPorItem.fRetornaSQLItens( strCodigoEmpresa : String ): String;
var
  stlSQL : TStringList;
begin
  stlSQL := TStringList.Create();
  try
    stlSQL.Add('SELECT'                                                                                     );
    stlSQL.Add('  LOTDOR.AUTOINCREM AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_CHAVE+','           );
    stlSQL.Add('  LSE_CODIGO AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_CODIGO_LOCAL_SEPARACAO+',' );
    stlSQL.Add('  FDO_CODITE AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_CODIGO_PRODUTO+','         );
    stlSQL.Add('  ITE_DESITE AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_DESCRICAO_PRODUTO+','      );
    stlSQL.Add('  ITE_LOCFIS AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_LOCALIZACAO_FISICA+','     );
    stlSQL.Add('  LDO_QTDITE AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_QUANTIDADE                 );
    stlSQL.Add('FROM'                                                                                       );
    stlSQL.Add('  FATDOR'                                                                                   );
    stlSQL.Add('  INNER JOIN LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM'                                      );
    stlSQL.Add('  INNER JOIN ITEGER ON ITEGER.ITE_CODITE = FDO_CODITE'                                      );
    stlSQL.Add('									 AND ITE_CODEMP = '+QuotedStr( strCodigoEmpresa )                         );
    stlSQL.Add('  INNER JOIN CADLSE ON LSE_CODIGO = ITE_CODLSE'                                             );
    stlSQL.Add('  INNER JOIN CADOPE ON OPE_CODOPE = LDO_CODSEP'                                             );
    stlSQL.Add('  INNER JOIN CADITE ON CADITE.ITE_CODITE = FDO_CODITE'                                      );

    stlSQL.Add('WHERE FDO_SEQGER = :'+TManutencaoSeparadoresPorLocalConstantes.PARAMETRO_AUTOINCREM_FATGOR  );

    Result := stlSQL.Text;
  finally
    FreeAndNil(stlSQL);
  end;
end;


function TSQLSeparadorLocalSeparacaoPorItem.fRetornaSQLLocaisSeparacao( strCodigoEmpresa : String ): string;
var
  stlSQL : TStringList;
begin
  stlSQL := TStringList.Create();
  try
    stlSQL.Add('SELECT'                                                                                                                                  );
    stlSQL.Add('  LSE_CODIGO AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_CODIGO_LOCAL_SEPARACAO+','                                             );
    stlSQL.Add('  LSE_DESCRI AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_LOCAL_SEPARACAO+','                                                    );
    stlSQL.Add('  CONCAT(OPE_CODOPE,"-", OPE_NOMOPE) AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARADOR_ATUAL+','                            );
    stlSQL.Add('  "" AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARADOR_NOVO+','                                                             );
    stlSQL.Add('  "" AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_DESCRICAO_SEPARADOR_NOVO+','                                                   );
    stlSQL.Add('  (SUM( (LDO_SEPCOL = "S") OR (IFNULL(FDO_QTDSEP,0) > 0) ) > 0) AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARACAO_INICIADA  );
    stlSQL.Add('FROM'                                                                                                                                   );
    stlSQL.Add('  FATDOR'                                                                                                                               );
    stlSQL.Add('  INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM'                                                                                  );
    stlSQL.Add('  INNER JOIN LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM'                                                                                  );
    stlSQL.Add('  INNER JOIN ITEGER ON ITE_CODITE = FDO_CODITE'                                                                                         );
    stlSQL.Add('									 AND ITE_CODEMP = '+QuotedStr( strCodigoEmpresa )                                                                     );
    stlSQL.Add('  INNER JOIN CADLSE ON LSE_CODIGO = ITE_CODLSE'                                                                                         );
    stlSQL.Add('  INNER JOIN CADOPE ON OPE_CODOPE = LDO_CODSEP'                                                                                         );
    stlSQL.Add('WHERE FDO_SEQGER = :'+TManutencaoSeparadoresPorLocalConstantes.PARAMETRO_AUTOINCREM_FATGOR                                              );
    stlSQL.Add('GROUP BY LSE_CODIGO'                                                                                                                    );

    Result := stlSQL.Text;
  finally
    FreeAndNil(stlSQL);
  end;
end;


function TSQLSeparadorLocalSeparacaoPorItem.fRetornaSQLUpdateLocalSeparacao( strCodigoEmpresa : String ): string;
var
  stlSQL : TStringList;
begin
  stlSQL := TStringList.Create();
  try
    stlSQL.Add('UPDATE'                                                                                         );
    stlSQL.Add('  FATDOR'                                                                                       );
    stlSQL.Add('  INNER JOIN LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM'                                          );
    stlSQL.Add('  INNER JOIN ITEGER ON ITE_CODITE = FDO_CODITE'                                                 );
    stlSQL.Add('									 AND ITE_CODEMP = '+QuotedStr( strCodigoEmpresa )                             );
    stlSQL.Add('SET LDO_CODSEP = :'+TManutencaoSeparadoresPorLocalConstantes.PARAMETRO_CODIGO_SEPARADOR_NOVO    );
    stlSQL.Add('WHERE FDO_SEQGER = :'+TManutencaoSeparadoresPorLocalConstantes.PARAMETRO_AUTOINCREM_FATGOR      );
    stlSQL.Add('  AND ITE_CODLSE = :'+TManutencaoSeparadoresPorLocalConstantes.PARAMETRO_CODIGO_LOCAL_SEPARACAO );

    Result := stlSQL.Text;
  finally
    FreeAndNil(stlSQL);
  end;

end;

{ TSQLSeparadorLocalSeparacaoPorLocalizacaoFisica }

function TSQLSeparadorLocalSeparacaoPorLocalizacaoFisica.fRetornaSQLItens( strCodigoEmpresa : String ): String;
var
  stlSQL : TStringList;
begin
  stlSQL := TStringList.Create();
  try
    stlSQL.Add('SELECT'                                                                                     );
    stlSQL.Add('  LOTDOR.AUTOINCREM AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_CHAVE+','           );
    stlSQL.Add('  LSE_CODIGO AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_CODIGO_LOCAL_SEPARACAO+',' );
    stlSQL.Add('  FDO_CODITE AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_CODIGO_PRODUTO+','         );
    stlSQL.Add('  ITE_DESITE AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_DESCRICAO_PRODUTO+','      );
    stlSQL.Add('  LOT_LOCFIS AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_LOCALIZACAO_FISICA+','     );
    stlSQL.Add('  LDO_QTDITE AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_QUANTIDADE                 );
    stlSQL.Add('FROM'                                                                                       );
    stlSQL.Add('  FATDOR'                                                                                   );
    stlSQL.Add('  INNER JOIN LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM'                                      );
    stlSQL.Add('  INNER JOIN CADLOT ON LOT_NUMLOT = LDO_NUMLOT'                                             );
    stlSQL.Add('									 AND LOT_CODITE = FDO_CODITE'                                             );
    stlSQL.Add('									 AND LOT_CODEMP = '+QuotedStr( strCodigoEmpresa )                         );
    stlSQL.Add('  INNER JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS'                                             );
    stlSQL.Add('                   AND LOC_CODEMP = LOT_CODEMP'                                             );
    stlSQL.Add('  INNER JOIN CADLSE ON LSE_CODIGO = LOC_CODLSE'                                             );
    stlSQL.Add('  INNER JOIN CADOPE ON OPE_CODOPE = LDO_CODSEP'                                             );
    stlSQL.Add('  INNER JOIN CADITE ON ITE_CODITE = FDO_CODITE'                                             );
    stlSQL.Add('WHERE FDO_SEQGER = :'+TManutencaoSeparadoresPorLocalConstantes.PARAMETRO_AUTOINCREM_FATGOR  );

    Result := stlSQL.Text;
  finally
    FreeAndNil(stlSQL);
  end;
end;

function TSQLSeparadorLocalSeparacaoPorLocalizacaoFisica.fRetornaSQLLocaisSeparacao( strCodigoEmpresa : String ): string;
var
  stlSQL : TStringList;
begin
  stlSQL := TStringList.Create();
  try
    stlSQL.Add('SELECT'                                                                                                                                 );
    stlSQL.Add('  LSE_CODIGO AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_CODIGO_LOCAL_SEPARACAO+','                                             );
    stlSQL.Add('  LSE_DESCRI AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_LOCAL_SEPARACAO+','                                                    );
    stlSQL.Add('  CONCAT(OPE_CODOPE,"-", OPE_NOMOPE) AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARADOR_ATUAL+','                            );
    stlSQL.Add('  "" AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARADOR_NOVO+','                                                             );
    stlSQL.Add('  "" AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_DESCRICAO_SEPARADOR_NOVO+','                                                   );
    stlSQL.Add('  (SUM( (LDO_SEPCOL = "S") OR (IFNULL(FDO_QTDSEP,0) > 0) ) > 0) AS '+TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARACAO_INICIADA  );
    stlSQL.Add('FROM'                                                                                                                                   );
    stlSQL.Add('  FATDOR'                                                                                                                               );
    stlSQL.Add('  INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM'                                                                                  );
    stlSQL.Add('  INNER JOIN LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM'                                                                                  );
    stlSQL.Add('  INNER JOIN CADLOT ON LOT_NUMLOT = LDO_NUMLOT'                                                                                         );
    stlSQL.Add('									 AND LOT_CODITE = FDO_CODITE'                                                                                         );
    stlSQL.Add('									 AND LOT_CODEMP = '+QuotedStr( strCodigoEmpresa )                                                                     );
    stlSQL.Add('  INNER JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS'                                                                                         );
    stlSQL.Add('                   AND LOC_CODEMP = LOT_CODEMP'                                                                                         );
    stlSQL.Add('  INNER JOIN CADLSE ON LSE_CODIGO = LOC_CODLSE'                                                                                         );
    stlSQL.Add('  INNER JOIN CADOPE ON OPE_CODOPE = LDO_CODSEP'                                                                                         );
    stlSQL.Add('WHERE FDO_SEQGER = :'+TManutencaoSeparadoresPorLocalConstantes.PARAMETRO_AUTOINCREM_FATGOR                                              );
    stlSQL.Add('GROUP BY LSE_CODIGO'                                                                                                                    );

    Result := stlSQL.Text;
  finally
    FreeAndNil(stlSQL);
  end;
end;

function TSQLSeparadorLocalSeparacaoPorLocalizacaoFisica.fRetornaSQLUpdateLocalSeparacao( strCodigoEmpresa : String ): string;
var
  stlSQL : TStringList;
begin
  stlSQL := TStringList.Create();
  try
    stlSQL.Add('UPDATE'                                                                                         );
    stlSQL.Add('  FATDOR'                                                                                       );
    stlSQL.Add('  INNER JOIN LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM'                                          );
    stlSQL.Add('  INNER JOIN CADLOT ON LOT_NUMLOT = LDO_NUMLOT'                                                 );
    stlSQL.Add('									 AND LOT_CODITE = FDO_CODITE'                                                 );
    stlSQL.Add('									 AND LOT_CODEMP = '+QuotedStr( strCodigoEmpresa )                             );
    stlSQL.Add('  INNER JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS'                                                 );
    stlSQL.Add('                   AND LOC_CODEMP = LOT_CODEMP'                                                 );
    stlSQL.Add('SET LDO_CODSEP = :'+TManutencaoSeparadoresPorLocalConstantes.PARAMETRO_CODIGO_SEPARADOR_NOVO    );
    stlSQL.Add('WHERE FDO_SEQGER = :'+TManutencaoSeparadoresPorLocalConstantes.PARAMETRO_AUTOINCREM_FATGOR      );
    stlSQL.Add('  AND LOC_CODLSE = :'+TManutencaoSeparadoresPorLocalConstantes.PARAMETRO_CODIGO_LOCAL_SEPARACAO );

    Result := stlSQL.Text;
  finally
    FreeAndNil(stlSQL);
  end;

end;

end.

