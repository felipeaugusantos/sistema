unit OrdemProducaoIndustrial.TEtiquetaProdutoAcabado;

interface

uses
  UniClientDataSet,
  Classes,
  SysUtils,
  Data.Db,
  System.Variants,
  System.MaskUtils,

  OrdemProducaoIndustrial.TCdsEtiquetaProdutoAcabado,
  OrdemProducaoIndustrial.TEtiquetaProdutoAcabadoFields;

  type
    TEtiquetaProdutoAcabado = class
    private
      FCdsEtiquetas : TCdsEtiquetaProdutoAcabado;
      FNumeroLote   : String;
      FQuantidadeAmostras: String;

    public

      function fRetornaNumeroLoteFormatado: string;
      function fRetornaNumeroLoteRastreamentoFormatado(strCodigoProduto: String): string;
      function fRetornaSequencialEtiquetaFormatado(i: Integer; quantidadeEtiqueta: double): string;
      function fRetornaQuantidadeAmostrasSQL : string;

      procedure pAdicionaItensCdsEtiquetas(dtsOrigem : TDataSet);
      function fSqlItens: String;

      constructor Create;
      destructor Destroy; override;

      property cdsEtiquetas          : TCdsEtiquetaProdutoAcabado read FCdsEtiquetas       write FCdsEtiquetas;
      property strNumeroLote         : string                     read FNumeroLote         write FNumeroLote;
      property strQuantidadeAmostras : string                     read FQuantidadeAmostras write FQuantidadeAmostras;
  end;


implementation

uses
  OrdemProducaoIndustrial.Constantes;

{ TEtiquetaProdutoAcabado }

constructor TEtiquetaProdutoAcabado.Create;
begin
  FCdsEtiquetas := TCdsEtiquetaProdutoAcabado.Create(nil);
  FNumeroLote   := '';
  FQuantidadeAmostras := '';
end;

destructor TEtiquetaProdutoAcabado.Destroy;
begin
  FreeAndNil(FCdsEtiquetas);
  inherited;
end;

function TEtiquetaProdutoAcabado.fRetornaNumeroLoteFormatado : string;
begin
  Result := FormatMaskText(TMascaraOrdemProducaoIndustrial.MASCARA_NUMERO_LOTE, FNumeroLote);
end;

function TEtiquetaProdutoAcabado.fRetornaNumeroLoteRastreamentoFormatado(strCodigoProduto : String) : string;
begin
  Result := strCodigoProduto + FormatMaskText(TMascaraOrdemProducaoIndustrial.MASCARA_LOTE_RASTREAMENTO, FNumeroLote);
end;

function TEtiquetaProdutoAcabado.fRetornaQuantidadeAmostrasSQL: string;
begin
  Result := IntToStr(StrToIntDef(FQuantidadeAmostras,0));
end;

function TEtiquetaProdutoAcabado.fRetornaSequencialEtiquetaFormatado(i : Integer; quantidadeEtiqueta : double) : string;
begin
  Result := IntToStr(i)+'/'+FloatToStr(quantidadeEtiqueta);
end;


procedure TEtiquetaProdutoAcabado.pAdicionaItensCdsEtiquetas(dtsOrigem: TDataSet);
var
  i : integer;
begin
  For i := 1 To Trunc(dtsOrigem.FieldByName(TEtiquetaProdutoAcabadoFields.QUANTIDADE_ETIQUETAS).AsFloat) Do
  Begin
    FCdsEtiquetas.Insert;

    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_PRODUTO ).AsString                     := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_PRODUTO ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DATA_BAIXA ).AsString                         := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.DATA_BAIXA ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_ACABADO ).AsString          := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_ACABADO ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_CADASTRO_PRODUTO ).AsString         := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_CADASTRO_PRODUTO ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_SIMPLES_CADASTRO_PRODUTO ).AsString := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_SIMPLES_CADASTRO_PRODUTO ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COR ).AsString                                := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.COR ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_BARRAS ).AsString                      := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_BARRAS ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_FABRICA ).AsString                     := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_FABRICA ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.NUMERO_LOTE ).AsString                        := fRetornaNumeroLoteFormatado;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.LOTE_RASTREAMENTO ).AsString                  := fRetornaNumeroLoteRastreamentoFormatado(dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_PRODUTO ).AsString);
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DATA_VALIDADE ).AsString                      := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.DATA_VALIDADE ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.VALIDADE_PRODUTO ).AsDateTime                 := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.VALIDADE_PRODUTO ).AsDateTime;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.PRAZO_VALIDADE ).AsInteger                    := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.PRAZO_VALIDADE ).AsInteger;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DATA_CADASTRO ).AsString                      := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.DATA_CADASTRO ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.ORDDET_AUTOINCREM ).AsString                  := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.ORDDET_AUTOINCREM ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.REFERENCIA ).AsString                         := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.REFERENCIA ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.LOCALIZACAO_FISICA ).AsString                 := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.LOCALIZACAO_FISICA ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.SIGLA_UNIDADE ).AsString                      := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.SIGLA_UNIDADE ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_UNIDADE ).AsString                  := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_UNIDADE ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_RESUMIDA_UNIDADE ).AsString         := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_RESUMIDA_UNIDADE ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_UNIDADE ).AsString         := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_UNIDADE ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_GRUPO ).AsString           := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_GRUPO ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_BARRAS_EMBALAGEM ).AsString            := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_BARRAS_EMBALAGEM ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.SIGLA_ETIQUETA_GRUPO ).AsString               := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.SIGLA_ETIQUETA_GRUPO ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_LINHA ).AsString           := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_LINHA ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.QUANTIDADE_EMBALAGEM ).AsFloat                := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.QUANTIDADE_EMBALAGEM ).AsFloat;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_MARCA ).AsString                    := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_MARCA ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_CLIENTE ).AsString                     := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_CLIENTE ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.NOME_CLIENTE ).AsString                       := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.NOME_CLIENTE ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.NUMERO_DOCUMENTO ).AsString                   := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.NUMERO_DOCUMENTO ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DATA_PREVISAO ).AsString                      := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.DATA_PREVISAO ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.PESO_BRUTO ).AsFloat                          := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.PESO_BRUTO ).AsFloat;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.PESO_LIQUIDO ).AsFloat                        := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.PESO_LIQUIDO ).AsFloat;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_PRINCIPAL ).AsString        := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_PRINCIPAL ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_DILUENTE ).AsString         := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_DILUENTE ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.REFENCIA_PRODUTO_B ).AsString                 := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.REFENCIA_PRODUTO_B ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.REFENCIA_PRODUTO_DILUENTE ).AsString          := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.REFENCIA_PRODUTO_DILUENTE ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.APLICACAO_PRODUTO ).AsString                  := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.APLICACAO_PRODUTO ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.RELACAO_CATALISE ).AsString                   := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.RELACAO_CATALISE ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.VOLUME_PRODUTO_PRINCIPAL ).AsString           := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.VOLUME_PRODUTO_PRINCIPAL ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.VOLUME_PRODUTO_B ).AsString                   := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.VOLUME_PRODUTO_B ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_FABRICANTE ).AsString               := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_FABRICANTE ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.LAYOUT ).AsString                             := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.LAYOUT ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_01 ).AsString                     := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_01 ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_02 ).AsString                     := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_02 ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_03 ).AsString                     := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_03 ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_04 ).AsString                     := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_04 ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_05 ).AsString                     := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_05 ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_06 ).AsString                     := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_06 ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_07 ).AsString                     := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_07 ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_08 ).AsString                     := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_08 ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_09 ).AsString                     := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_09 ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_10 ).AsString                     := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_10 ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.SEQUENCIAL_COMPLETO ).AsString                := fRetornaSequencialEtiquetaFormatado(i, dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.QUANTIDADE_ETIQUETAS ).AsFloat);
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.SEQUENCIAL ).AsInteger                        := i;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.OBSERVACAO ).AsString                         := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.OBSERVACAO ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTOITEM ).AsString                    := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTOITEM ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPOS ).AsString                             := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.COMPOS ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.ITESAC ).AsString                             := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.ITESAC ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.PAISOR ).AsString                             := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.PAISOR ).AsString;
    FCdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.VALIDA ).AsString                             := dtsOrigem.FieldByName( TEtiquetaProdutoAcabadoFields.VALIDA ).AsString;

    FCdsEtiquetas.Post;
  End;
end;

function TEtiquetaProdutoAcabado.fSqlItens: String;
Const
  VOLUME_PRINCIPAL = '  CASE WHEN (SELECT SUM(IF(UNI_KILLIT="K", '+
                                             ' IF(ORD_PESREA > 0, ((ORD_QTDPRO * UNI_PESLIT) / ORD_PESREA),0), '+
                                             '  ORD_QTDPRO * UNI_PESLIT ))FROM ORDDET DD '+
                                                                   ' INNER JOIN CADITE ON ITE_CODITE = DD.ORD_CODITE '+
                                                                   ' INNER JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI '+
                                                                   ' INNER JOIN ORDGER O ON O.AUTOINCREM = ORD_SEQGER '+
                                                                   ' WHERE ORD_SEQGER = ORDGER.AUTOINCREM GROUP BY DD.ORD_SEQGER) > 0 THEN '+
                                             ' CAST( (SELECT SUM(IF(UNI_KILLIT="K", '+
                                             '   IF(ORD_PESREA > 0, ((ORD_QTDPRO * UNI_PESLIT) / ORD_PESREA),0), '+
                                             '   ORD_QTDPRO * UNI_PESLIT ))FROM ORDDET DD '+
                                             '                       INNER JOIN CADITE ON ITE_CODITE = DD.ORD_CODITE '+
                                             '                       INNER JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI '+
                                             '                       INNER JOIN ORDGER O ON O.AUTOINCREM = ORD_SEQGER '+
                                             '        WHERE ORD_SEQGER = ORDGER.AUTOINCREM GROUP BY DD.ORD_SEQGER) AS DECIMAL(15,2)) END AS '+ TEtiquetaProdutoAcabadoFields.VOLUME_PRODUTO_PRINCIPAL;
  VOLUME_B = '  CASE WHEN (SELECT SUM(IF(UNI_KILLIT="K", '+
                                     ' IF(ORD_PESREA > 0, ((ORD_QTDPRO * UNI_PESLIT) / ORD_PESREA),0), '+
                                     '  ORD_QTDPRO * UNI_PESLIT )) FROM ORDDET DD '+
                                                           ' INNER JOIN CADITE ON ITE_CODITE = DD.ORD_CODITE '+
                                                           ' INNER JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI '+
                                                           ' INNER JOIN ORDGER O ON O.AUTOINCREM = ORD_SEQGER '+
                                                           ' WHERE ORD_SEQGER = ORDGER.ORD_SEQCPN GROUP BY DD.ORD_SEQGER) > 0 THEN '+
                                     ' CAST( (SELECT SUM(IF(UNI_KILLIT="K", '+
                                     '   IF(ORD_PESREA > 0, ((ORD_QTDPRO * UNI_PESLIT) / ORD_PESREA),0), '+
                                     '   ORD_QTDPRO * UNI_PESLIT )) FROM ORDDET DD '+
                                     '                        INNER JOIN CADITE ON ITE_CODITE = DD.ORD_CODITE '+
                                     '                        INNER JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI '+
                                     '                        INNER JOIN ORDGER O ON O.AUTOINCREM = ORD_SEQGER '+
                                     '               WHERE ORD_SEQGER = ORDGER.ORD_SEQCPN GROUP BY DD.ORD_SEQGER) AS DECIMAL(15,2)) END AS '+ TEtiquetaProdutoAcabadoFields.VOLUME_PRODUTO_B;

var
  sql : TStringList;
Begin
  sql := TStringList.Create;
  try
    sql.Add('/* TEtiquetaProdutoAcabado.fSqlItens */'                                                                                                          );
    sql.Add('SELECT SQL_NO_CACHE DISTINCT'                                                                                                                     );
    sql.Add('  IF(D.ORD_IMPETI = "N" AND ORD_QTDPRO > 0, "S", "N") AS                         '+ TEtiquetaProdutoAcabadoFields.MARCA_DESMARCA +','             );
    sql.Add('  D.ORD_CODITE   AS                                                              '+ TEtiquetaProdutoAcabadoFields.CODIGO_PRODUTO +','             );
    sql.Add('  ORD_QTDPRO     AS                                                              '+ TEtiquetaProdutoAcabadoFields.QUANTIDADE_PRODUZIDA +','       );
    sql.Add('  ORD_DTACAD     AS                                                              '+ TEtiquetaProdutoAcabadoFields.DATA_CADASTRO +','              );
    sql.Add('  DATE_FORMAT(ORD_DTAVAL, "%m/%Y") AS                                            '+ TEtiquetaProdutoAcabadoFields.DATA_VALIDADE +','              );
    sql.Add('  IF(IFNULL(I.ITE_PRAVAL,0) = 0'                                                                                                                  );
    sql.Add('     , ORD_DTAVAL'                                                                                                                                );
    sql.Add('     , DATE_ADD(IFNULL(ORD_DTABAI, ORD_DTAPRE), INTERVAL I.ITE_PRAVAL MONTH)) AS '+ TEtiquetaProdutoAcabadoFields.VALIDADE_PRODUTO +','           );
    sql.Add('  I.ITE_PRAVAL AS PRAVAL,'                                                                                                                        );
    sql.Add('  ORD_QTDPRO + '  + fRetornaQuantidadeAmostrasSQL + ' AS                         '+ TEtiquetaProdutoAcabadoFields.QUANTIDADE_ETIQUETAS +','       );
    sql.Add('  I.ITE_DESITE AS                                                                '+ TEtiquetaProdutoAcabadoFields.DESCRICAO_CADASTRO_PRODUTO +',' );
    sql.Add('  I.ITE_DESSIM AS                                                                '+ TEtiquetaProdutoAcabadoFields.DESCRICAO_SIMPLES_CADASTRO_PRODUTO +',' );
    sql.Add('  ORD_DTABAI  AS                                                                 '+ TEtiquetaProdutoAcabadoFields.DATA_BAIXA +','                 );
    sql.Add('  CONCAT(IFNULL(GRU_DETLIN, ""), " ",'                                                                                                            );
    sql.Add('         IFNULL(GRU_DETGRU, ""), " ",'                                                                                                            );
    sql.Add('         IFNULL(UNI_DETUNI, "")) AS                                              '+ TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_ACABADO +','  );
    sql.Add('  I.ITE_CODBAR     AS                                                            '+ TEtiquetaProdutoAcabadoFields.CODIGO_BARRAS +','              );
    sql.Add('  I.ITE_CODFAB     AS                                                            '+ TEtiquetaProdutoAcabadoFields.CODIGO_FABRICA +','             );
    sql.Add('  UNI_SIGUNI     AS                                                              '+ TEtiquetaProdutoAcabadoFields.SIGLA_UNIDADE +','              );
    sql.Add('  UNI_DETUNI     AS                                                              '+ TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_UNIDADE +',' );
    sql.Add('  UNI_PESLIT     AS                                                              '+ TEtiquetaProdutoAcabadoFields.PESO_LITRO +','                 );
    sql.Add('  D.AUTOINCREM   AS                                                              '+ TEtiquetaProdutoAcabadoFields.ORDDET_AUTOINCREM +','          );
    sql.Add('  D.ORD_IMPETI   AS                                                              '+ TEtiquetaProdutoAcabadoFields.ETIQUETA_IMPRESSA +','          );
    sql.Add('  (UNI_PESLIT * ORD_QTDPRO) AS                                                   '+ TEtiquetaProdutoAcabadoFields.VOLUME +','                     );
    sql.Add('  I.ITE_REFERE AS                                                                '+ TEtiquetaProdutoAcabadoFields.REFERENCIA +','                 );
    sql.Add('  G.ITE_LOCFIS AS                                                                '+ TEtiquetaProdutoAcabadoFields.LOCALIZACAO_FISICA +','         );
    sql.Add('  UNI_SIGUNI AS                                                                  '+ TEtiquetaProdutoAcabadoFields.SIGLA_UNIDADE +','              );
    sql.Add('  UNI_DESUNI AS                                                                  '+ TEtiquetaProdutoAcabadoFields.DESCRICAO_UNIDADE +','          );
    sql.Add('  UNI_DREUNI AS                                                                  '+ TEtiquetaProdutoAcabadoFields.DESCRICAO_RESUMIDA_UNIDADE +',' );
    sql.Add('  UNI_DETUNI AS                                                                  '+ TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_UNIDADE +',' );
    sql.Add('  GRU_DETGRU AS                                                                  '+ TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_GRUPO +','   );
    sql.Add('  GRU_DETLIN AS                                                                  '+ TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_LINHA +','   );
    sql.Add('  I.ITE_BAREMB AS                                                                '+ TEtiquetaProdutoAcabadoFields.CODIGO_BARRAS_EMBALAGEM +','    );
    sql.Add('  GRU_SGETGR AS                                                                  '+ TEtiquetaProdutoAcabadoFields.SIGLA_ETIQUETA_GRUPO +','       );
    sql.Add('  BAR_EMBALA AS                                                                  '+ TEtiquetaProdutoAcabadoFields.QUANTIDADE_EMBALAGEM +','       );
    sql.Add('  MAR_DESMAR AS                                                                  '+ TEtiquetaProdutoAcabadoFields.DESCRICAO_MARCA +','            );
    sql.Add('  ETI_COMP01 AS                                                                  '+ TEtiquetaProdutoAcabadoFields.COMPLEMENTO_01 +','             );
    sql.Add('  ETI_COMP02 AS                                                                  '+ TEtiquetaProdutoAcabadoFields.COMPLEMENTO_02 +','             );
    sql.Add('  ETI_COMP03 AS                                                                  '+ TEtiquetaProdutoAcabadoFields.COMPLEMENTO_03 +','             );
    sql.Add('  ETI_COMP04 AS                                                                  '+ TEtiquetaProdutoAcabadoFields.COMPLEMENTO_04 +','             );
    sql.Add('  ETI_COMP05 AS                                                                  '+ TEtiquetaProdutoAcabadoFields.COMPLEMENTO_05 +','             );
    sql.Add('  ETI_COMP06 AS                                                                  '+ TEtiquetaProdutoAcabadoFields.COMPLEMENTO_06 +','             );
    sql.Add('  ETI_COMP07 AS                                                                  '+ TEtiquetaProdutoAcabadoFields.COMPLEMENTO_07 +','             );
    sql.Add('  ETI_COMP08 AS                                                                  '+ TEtiquetaProdutoAcabadoFields.COMPLEMENTO_08 +','             );
    sql.Add('  ETI_COMP09 AS                                                                  '+ TEtiquetaProdutoAcabadoFields.COMPLEMENTO_09 +','             );
    sql.Add('  ETI_COMP10 AS                                                                  '+ TEtiquetaProdutoAcabadoFields.COMPLEMENTO_10 +','             );
    sql.Add('  FDO_CODCLI AS                                                                  '+ TEtiquetaProdutoAcabadoFields.CODIGO_CLIENTE +','             );
    sql.Add('  CLI_NOMCLI AS                                                                  '+ TEtiquetaProdutoAcabadoFields.NOME_CLIENTE +','               );
    sql.Add('  FDO_NUMDOC AS                                                                  '+ TEtiquetaProdutoAcabadoFields.NUMERO_DOCUMENTO +','           );
    sql.Add('  ORD_DTAPRE AS                                                                  '+ TEtiquetaProdutoAcabadoFields.DATA_PREVISAO +','              );
    sql.Add('  I.ITE_PESOIT AS                                                                '+ TEtiquetaProdutoAcabadoFields.PESO_BRUTO +','                 );
    sql.Add('  I.ITE_PESLIQ AS                                                                '+ TEtiquetaProdutoAcabadoFields.PESO_LIQUIDO +','               );
    sql.Add(' (SELECT I.ITE_DESITE FROM  CADITE I WHERE I.ITE_CODITE = CI.ITE_CODITB) AS      '+ TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_PRINCIPAL +',');
    sql.Add(' (SELECT I.ITE_DESITE FROM  CADITE I WHERE I.ITE_CODITE = CI.ITE_CODITD) AS      '+ TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_DILUENTE +',' );
    sql.Add(' CB.ITE_REFERE AS                                                                '+ TEtiquetaProdutoAcabadoFields.REFENCIA_PRODUTO_B +',' );
    sql.Add(' CD.ITE_REFERE AS                                                                '+ TEtiquetaProdutoAcabadoFields.REFENCIA_PRODUTO_DILUENTE +',' );
    sql.Add(' CI.ITE_APLICA AS                                                                '+ TEtiquetaProdutoAcabadoFields.APLICACAO_PRODUTO +',' );
    sql.Add(' CASE WHEN CI.ITE_VALCAT > 0 THEN CONCAT(CI.ITE_VALCAT, ":1") END AS             '+ TEtiquetaProdutoAcabadoFields.RELACAO_CATALISE +',' );
    sql.Add(VOLUME_PRINCIPAL                                                                                                                    +',');
    sql.Add(VOLUME_B                                                                                                                            +',');
    sql.Add('  I.ITE_DESFAB AS                                                                '+ TEtiquetaProdutoAcabadoFields.DESCRICAO_FABRICANTE +','       );
    sql.Add('  (SELECT COUNT(0) FROM LAYITE WHERE LAY_CODITE = D.ORD_CODITE) AS               '+ TEtiquetaProdutoAcabadoFields.QUANTIDADE_LAYOUT +','          );
    sql.Add('  "" AS                                                                          '+ TEtiquetaProdutoAcabadoFields.LAYOUT +','                     );
    sql.Add('  COR_DETCOR AS                                                                  '+ TEtiquetaProdutoAcabadoFields.COR +','                        );
    sql.Add('  FDO_COMPLE AS                                                                  '+ TEtiquetaProdutoAcabadoFields.COMPLEMENTOITEM +','            );
    sql.Add('  CAST("" AS CHAR(30)) AS                                                        '+ TEtiquetaProdutoAcabadoFields.OBSERVACAO +','                 );
    sql.Add('  I.ITE_VALIDA AS                                                                '+ TEtiquetaProdutoAcabadoFields.VALIDA +','                     );
    sql.Add('  I.ITE_ITESAC AS                                                                '+ TEtiquetaProdutoAcabadoFields.ITESAC +','                     );
    sql.Add('  I.ITE_COMPOS AS                                                                '+ TEtiquetaProdutoAcabadoFields.COMPOS +','                     );
    sql.Add('  I.ITE_PAISOR AS                                                                '+ TEtiquetaProdutoAcabadoFields.PAISOR                          );

    sql.Add('FROM'                                                                                                                                             );
    sql.Add('  ORDDET D'                                                                                                                                       );
    sql.Add('  INNER JOIN CADITE I ON I.ITE_CODITE = D.ORD_CODITE'                                                                                             );
    sql.Add('  INNER JOIN CADCOR   ON I.ITE_CODCOR = COR_CODCOR'                                                                                               );
    sql.Add('  INNER JOIN CADGRU   ON I.ITE_CODGRU = GRU_CODGRU'                                                                                               );
    sql.Add('  INNER JOIN CADUNI   ON I.ITE_CODUNI = UNI_CODUNI'                                                                                               );
    sql.Add('  INNER JOIN ORDGER   ON ORDGER.AUTOINCREM = D.ORD_SEQGER'                                                                                        );
    sql.Add('  INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE'                                                                                             );
    sql.Add('                     AND G.ITE_CODEMP = ORD_CODEMP'                                                                                               );
    sql.Add('  LEFT  JOIN CADMAR   ON   MAR_CODMAR = I.ITE_CODMAR'                                                                                             );
    sql.Add('  LEFT  JOIN EXTDOR   ON   FDO_SEQOPI = ORDGER.AUTOINCREM'                                                                                        );
    sql.Add('  LEFT  JOIN FATDOR   ON   FATDOR.AUTOINCREM = FDO_SEQFDO'                                                                                        );
    sql.Add('  LEFT  JOIN CADCLI   ON   CLI_CODCLI = FDO_CODCLI'                                                                                               );
    sql.Add('  LEFT  JOIN ITEBAR   ON   BAR_CODITE = I.ITE_CODITE AND BAR_COMPRA = 1'                                                                          );
    sql.Add('  LEFT  JOIN COMETI   ON   ETI_CODITE = I.ITE_CODITE'                                                                                             );
    sql.Add('  INNER JOIN CADITE CI ON CI.ITE_CODITE = ORDGER.ORD_CODITE'                                                                                      );
    sql.Add('  LEFT JOIN CADITE CB  ON CI.ITE_CODITB = CB.ITE_CODITE'                                                                                          );
    sql.Add('  LEFT JOIN CADITE CD  ON CI.ITE_CODITD = CD.ITE_CODITE'                                                                                          );
    sql.Add(' WHERE'                                                                                                                                           );
    sql.Add('   D.ORD_SEQGER = :AUTINC'                                                                                                                        );

    Result := sql.Text;
  finally
    FreeAndNil(sql);
  end;
End;

end.
