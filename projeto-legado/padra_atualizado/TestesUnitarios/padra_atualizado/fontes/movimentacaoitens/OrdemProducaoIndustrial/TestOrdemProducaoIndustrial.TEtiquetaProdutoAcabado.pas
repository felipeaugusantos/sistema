unit TestOrdemProducaoIndustrial.TEtiquetaProdutoAcabado;

interface

uses
  TestFramework, System.MaskUtils, System.Variants,

  OrdemProducaoIndustrial.TEtiquetaProdutoAcabado,
  Classes, SysUtils,
  OrdemProducaoIndustrial.TEtiquetaProdutoAcabadoFields,
  TestOrdemProducaoIndustrial.Dados.TCdsItensEtiquetaProdutoAcabado,
  UniClientDataSet,
  Data.Db;

type
  TestTEtiquetaProdutoAcabado = class(TTestCase)
  strict private
    FEtiquetaProdutoAcabado: TEtiquetaProdutoAcabado;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestfRetornaNumeroLoteFormatado;
    procedure TestfRetornaNumeroLoteRastreamentoFormatado;
    procedure TestfRetornaSequencialEtiquetaFormatado;
    procedure TestfRetornaQuantidadeAmostrasSQL;
    procedure TestfRetornaQuantidadeAmostrasSQLQauntidadeVazia;
    procedure TestpAdicionaItensCdsEtiquetas;
    procedure TestfSqlItens;
  end;

implementation

procedure TestTEtiquetaProdutoAcabado.SetUp;
begin
  FEtiquetaProdutoAcabado := TEtiquetaProdutoAcabado.Create;
  FEtiquetaProdutoAcabado.strNumeroLote := '010120001';
end;

procedure TestTEtiquetaProdutoAcabado.TearDown;
begin
  FEtiquetaProdutoAcabado.Free;
  FEtiquetaProdutoAcabado := nil;
end;

procedure TestTEtiquetaProdutoAcabado.TestfRetornaNumeroLoteFormatado;
var
  ReturnValue: string;
begin
  ReturnValue := FEtiquetaProdutoAcabado.fRetornaNumeroLoteFormatado;
  CheckEqualsString('010120-001', ReturnValue);
end;

procedure TestTEtiquetaProdutoAcabado.TestfRetornaNumeroLoteRastreamentoFormatado;
var
  ReturnValue: string;
  strCodigoProduto: string;
begin
  strCodigoProduto := '00001';
  ReturnValue := FEtiquetaProdutoAcabado.fRetornaNumeroLoteRastreamentoFormatado(strCodigoProduto);
  CheckEqualsString('00001010120001', ReturnValue);
end;

procedure TestTEtiquetaProdutoAcabado.TestfRetornaSequencialEtiquetaFormatado;
var
  ReturnValue: string;
  quantidadeEtiqueta: Double;
  i: Integer;
begin
  i := 1;
  quantidadeEtiqueta := 10;
  ReturnValue := FEtiquetaProdutoAcabado.fRetornaSequencialEtiquetaFormatado(i, quantidadeEtiqueta);
  CheckEqualsString('1/10', ReturnValue);
end;

procedure TestTEtiquetaProdutoAcabado.TestfRetornaQuantidadeAmostrasSQL;
var
  ReturnValue: string;
begin
  FEtiquetaProdutoAcabado.strQuantidadeAmostras := '1';
  ReturnValue := FEtiquetaProdutoAcabado.fRetornaQuantidadeAmostrasSQL;
  CheckEqualsString('1', ReturnValue);
end;

procedure TestTEtiquetaProdutoAcabado.TestfRetornaQuantidadeAmostrasSQLQauntidadeVazia;
var
  ReturnValue: string;
begin
  FEtiquetaProdutoAcabado.strQuantidadeAmostras := '';
  ReturnValue := FEtiquetaProdutoAcabado.fRetornaQuantidadeAmostrasSQL;
  CheckEqualsString('0', ReturnValue);
end;

procedure TestTEtiquetaProdutoAcabado.TestpAdicionaItensCdsEtiquetas;
var
  cdsOrigem   : TCdsItensEtiquetaProdutoAcabado;
  ReturnValue : Boolean;
begin
  cdsOrigem := TCdsItensEtiquetaProdutoAcabado.Create(nil);
  try
    cdsOrigem.pAlimentaItens;
    FEtiquetaProdutoAcabado.pAdicionaItensCdsEtiquetas(cdsOrigem);
    ReturnValue := FEtiquetaProdutoAcabado.cdsEtiquetas.RecordCount = 2;

    if ReturnValue then
    begin
      FEtiquetaProdutoAcabado.cdsEtiquetas.First;

      while not FEtiquetaProdutoAcabado.cdsEtiquetas.Eof do
      begin

        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_PRODUTO ).AsString              = '00001');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_ACABADO ).AsString   = 'Descricao Produto Acabado');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_CADASTRO_PRODUTO ).AsString  = 'Descricao Produto');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_SIMPLES_CADASTRO_PRODUTO ).AsString  = 'Descricao Simples Produto');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COR ).AsString                         = 'Cor');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DATA_BAIXA ).AsString                  = '10/10/2020');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_BARRAS ).AsString               = '00001A');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_FABRICA ).AsString              = '00001B');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DATA_VALIDADE ).AsString               = '10/10/2021');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.VALIDADE_PRODUTO ).AsDateTime          = StrToDate('10/10/2022'));
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.PRAZO_VALIDADE ).AsInteger             = 12);
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DATA_CADASTRO ).AsString               = '01/10/2020');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.ORDDET_AUTOINCREM ).AsString           = '00000000000000000001');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.REFERENCIA ).AsString                  = 'Referencia');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.LOCALIZACAO_FISICA ).AsString          = 'Localização Física');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.SIGLA_UNIDADE ).AsString               = 'UN');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_UNIDADE ).AsString           = 'Unidade');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_RESUMIDA_UNIDADE ).AsString  = 'Unidade Resumida');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_UNIDADE ).AsString  = 'Unidade Etiqueta');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_GRUPO ).AsString    = 'Grupo Etiqueta');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_BARRAS_EMBALAGEM ). AsString    = '00001C');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.SIGLA_ETIQUETA_GRUPO ).AsString        = 'GP');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_LINHA ).AsString    = 'Descricao Linha');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.QUANTIDADE_EMBALAGEM ).AsFloat         = 1);
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_MARCA ).AsString             = 'Descricao Marca');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_CLIENTE ).AsString              = '00000001');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.NOME_CLIENTE ).AsString                = 'Nome Cliente');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.NUMERO_DOCUMENTO ).AsString            = '000000000001');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DATA_PREVISAO ).AsString               = '09/10/2020');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.PESO_BRUTO ).AsFloat                   = 20);
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.PESO_LIQUIDO ).AsFloat                 = 15);
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_PRINCIPAL ).AsString = 'Descricao Prouto Principal');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_DILUENTE ).AsString  = 'Descricao Prouto Diluente');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.REFENCIA_PRODUTO_B ).AsString          = 'REFERENCIA PRODUTO B');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.REFENCIA_PRODUTO_DILUENTE ).AsString   = 'REFERENCIA PRODUTO DILUENTE');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.APLICACAO_PRODUTO ).AsString           = 'APLICACAO PRODUTO');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.RELACAO_CATALISE ).AsString            = '1');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.VOLUME_PRODUTO_PRINCIPAL ).AsString    = '1200');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.VOLUME_PRODUTO_B ).AsString            = '1250');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_FABRICANTE ).AsString        = 'Descricao Fabricante');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.LAYOUT ).AsString                      = '01');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_01 ).AsString              = 'Complemento 01');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_02 ).AsString              = 'Complemento 02');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_03 ).AsString              = 'Complemento 03');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_04 ).AsString              = 'Complemento 04');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_05 ).AsString              = 'Complemento 05');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_06 ).AsString              = 'Complemento 06');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_07 ).AsString              = 'Complemento 07');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_08 ).AsString              = 'Complemento 08');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_09 ).AsString              = 'Complemento 09');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_10 ).AsString              = 'Complemento 10');
        ReturnValue := ReturnValue and (FEtiquetaProdutoAcabado.cdsEtiquetas.FieldByName( TEtiquetaProdutoAcabadoFields.OBSERVACAO ).AsString                  = 'Observacao livre OPI');

        FEtiquetaProdutoAcabado.cdsEtiquetas.Next;

      end;

    end;

    CheckTrue(ReturnValue);

  finally
    FreeAndNil(cdsOrigem);
  end;


end;

procedure TestTEtiquetaProdutoAcabado.TestfSqlItens;
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
  ReturnValue: string;
  sql : TStringList;
begin
  sql := TStringList.Create;
  try
    ReturnValue := FEtiquetaProdutoAcabado.fSqlItens;

    sql.Add('/* TEtiquetaProdutoAcabado.fSqlItens */'                                                 );
    sql.Add('SELECT SQL_NO_CACHE DISTINCT'                                                            );
    sql.Add('  IF(D.ORD_IMPETI = "N" AND ORD_QTDPRO > 0, "S", "N") AS                         MARDES,');
    sql.Add('  D.ORD_CODITE   AS                                                              CODITE,');
    sql.Add('  ORD_QTDPRO     AS                                                              QTDPRO,');
    sql.Add('  ORD_DTACAD     AS                                                              DTACAD,');
    sql.Add('  DATE_FORMAT(ORD_DTAVAL, "%m/%Y") AS                                            DTAVAL,');
    sql.Add('  IF(IFNULL(I.ITE_PRAVAL,0) = 0'                                                         );
    sql.Add('     , ORD_DTAVAL'                                                                       );
    sql.Add('     , DATE_ADD(IFNULL(ORD_DTABAI, ORD_DTAPRE), INTERVAL I.ITE_PRAVAL MONTH)) AS VALITE,');
    sql.Add('  I.ITE_PRAVAL AS PRAVAL,'                                                               );
    sql.Add('  ORD_QTDPRO + 0 AS                         QTDETI,'                                     );
    sql.Add('  I.ITE_DESITE AS                                                                DESCRI,');
    sql.Add('  I.ITE_DESSIM AS                                                                DESSPF,');
    sql.Add('  ORD_DTABAI  AS                                                                 DTABAI,');
    sql.Add('  CONCAT(IFNULL(GRU_DETLIN, ""), " ",'                                                   );
    sql.Add('         IFNULL(GRU_DETGRU, ""), " ",'                                                   );
    sql.Add('         IFNULL(UNI_DETUNI, "")) AS                                              DESITE,');
    sql.Add('  I.ITE_CODBAR     AS                                                            CODBAR,');
    sql.Add('  I.ITE_CODFAB     AS                                                            CODFAB,');
    sql.Add('  UNI_SIGUNI     AS                                                              SIGUNI,');
    sql.Add('  UNI_DETUNI     AS                                                              DETUNI,');
    sql.Add('  UNI_PESLIT     AS                                                              PESLIT,');
    sql.Add('  D.AUTOINCREM   AS                                                              AUTOIN,');
    sql.Add('  D.ORD_IMPETI   AS                                                              IMPETI,');
    sql.Add('  (UNI_PESLIT * ORD_QTDPRO) AS                                                   VOLUME,');
    sql.Add('  I.ITE_REFERE AS                                                                REFERE,');
    sql.Add('  G.ITE_LOCFIS AS                                                                LOCFIS,');
    sql.Add('  UNI_SIGUNI AS                                                                  SIGUNI,');
    sql.Add('  UNI_DESUNI AS                                                                  DESUNI,');
    sql.Add('  UNI_DREUNI AS                                                                  DREUNI,');
    sql.Add('  UNI_DETUNI AS                                                                  DETUNI,');
    sql.Add('  GRU_DETGRU AS                                                                  DETGRU,');
    sql.Add('  GRU_DETLIN AS                                                                  DETLIN,');
    sql.Add('  I.ITE_BAREMB AS                                                                BAREMB,');
    sql.Add('  GRU_SGETGR AS                                                                  SGETGR,');
    sql.Add('  BAR_EMBALA AS                                                                  EMBALA,');
    sql.Add('  MAR_DESMAR AS                                                                  DESMAR,');
    sql.Add('  ETI_COMP01 AS                                                                  COMP01,');
    sql.Add('  ETI_COMP02 AS                                                                  COMP02,');
    sql.Add('  ETI_COMP03 AS                                                                  COMP03,');
    sql.Add('  ETI_COMP04 AS                                                                  COMP04,');
    sql.Add('  ETI_COMP05 AS                                                                  COMP05,');
    sql.Add('  ETI_COMP06 AS                                                                  COMP06,');
    sql.Add('  ETI_COMP07 AS                                                                  COMP07,');
    sql.Add('  ETI_COMP08 AS                                                                  COMP08,');
    sql.Add('  ETI_COMP09 AS                                                                  COMP09,');
    sql.Add('  ETI_COMP10 AS                                                                  COMP10,');
    sql.Add('  FDO_CODCLI AS                                                                  CODCLI,');
    sql.Add('  CLI_NOMCLI AS                                                                  NOMCLI,');
    sql.Add('  FDO_NUMDOC AS                                                                  NUMDOC,');
    sql.Add('  ORD_DTAPRE AS                                                                  DTAPRE,');
    sql.Add('  I.ITE_PESOIT AS                                                                PESOIT,');
    sql.Add('  I.ITE_PESLIQ AS                                                                PESLIQ,');
    sql.Add(' (SELECT I.ITE_DESITE FROM  CADITE I WHERE I.ITE_CODITE = CI.ITE_CODITB) AS      DESPRI,');
    sql.Add(' (SELECT I.ITE_DESITE FROM  CADITE I WHERE I.ITE_CODITE = CI.ITE_CODITD) AS      DESDIL,');
    sql.Add(' CB.ITE_REFERE AS                                                                REFERB,');
    sql.Add(' CD.ITE_REFERE AS                                                                REFERD,');
    sql.Add(' CI.ITE_APLICA AS                                                                APLICA,');
    sql.Add(' CASE WHEN CI.ITE_VALCAT > 0 THEN CONCAT(CI.ITE_VALCAT, ":1") END AS             RELCAT,');
    sql.Add(VOLUME_PRINCIPAL                                                                      +',');
    sql.Add(VOLUME_B                                                                              +',');
    sql.Add('  I.ITE_DESFAB AS                                                                DESFAB,');
    sql.Add('  (SELECT COUNT(0) FROM LAYITE WHERE LAY_CODITE = D.ORD_CODITE) AS               QTDLAY,');
    sql.Add('  "" AS                                                                          LAYOUT,');
    sql.Add('  COR_DETCOR AS                                                                  DESCOR,' );
    sql.Add('  FDO_COMPLE AS                                                                  COMPLE,');
    sql.Add('  CAST("" AS CHAR(30)) AS                                                        OBSOPI' );
    sql.Add('FROM'                                                                                    );
    sql.Add('  ORDDET D'                                                                              );
    sql.Add('  INNER JOIN CADITE I ON I.ITE_CODITE = D.ORD_CODITE'                                    );
    sql.Add('  INNER JOIN CADCOR   ON I.ITE_CODCOR = COR_CODCOR'                                      );
    sql.Add('  INNER JOIN CADGRU   ON I.ITE_CODGRU = GRU_CODGRU'                                      );
    sql.Add('  INNER JOIN CADUNI   ON I.ITE_CODUNI = UNI_CODUNI'                                      );
    sql.Add('  INNER JOIN ORDGER   ON ORDGER.AUTOINCREM = D.ORD_SEQGER'                               );
    sql.Add('  INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE'                                    );
    sql.Add('                     AND G.ITE_CODEMP = ORD_CODEMP'                                      );
    sql.Add('  LEFT  JOIN CADMAR   ON   MAR_CODMAR = I.ITE_CODMAR'                                    );
    sql.Add('  LEFT  JOIN EXTDOR   ON   FDO_SEQOPI = ORDGER.AUTOINCREM'                               );
    sql.Add('  LEFT  JOIN FATDOR   ON   FATDOR.AUTOINCREM = FDO_SEQFDO'                               );
    sql.Add('  LEFT  JOIN CADCLI   ON   CLI_CODCLI = FDO_CODCLI'                                      );
    sql.Add('  LEFT  JOIN ITEBAR   ON   BAR_CODITE = I.ITE_CODITE AND BAR_COMPRA = 1'                 );
    sql.Add('  LEFT  JOIN COMETI   ON   ETI_CODITE = I.ITE_CODITE'                                    );
    sql.Add('  INNER JOIN CADITE CI ON CI.ITE_CODITE = ORDGER.ORD_CODITE'                             );
    sql.Add('  LEFT JOIN CADITE CB  ON CI.ITE_CODITB = CB.ITE_CODITE'                                 );
    sql.Add('  LEFT JOIN CADITE CD  ON CI.ITE_CODITD = CD.ITE_CODITE'                                 );
    sql.Add(' WHERE'                                                                                  );
    sql.Add('   D.ORD_SEQGER = :AUTINC'                                                               );

    CheckEqualsString(sql.Text, ReturnValue);
  finally
    FreeAndNil(sql);
  end;
end;

initialization
  RegisterTest(TestTEtiquetaProdutoAcabado.Suite);

end.

