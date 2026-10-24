unit OrdemProducaoIndustrial.TSQLOrdProdIndustrial;

interface

uses classes, SysUtils;

  Type TSQLOrdProdIndustrial = class

    private

      FComQtd: Boolean;
      FConCom: boolean;

    public

      property blnComQtd: boolean read FComQtd write FComQtd;
      property blnConCom: boolean read FConCom write FConCom;

      function fRetornaSQLOrdPro: String;
      function fRetornaSQLComponenteItem: String;
      function fRetornaSQLAutoIncremOrdPro: String;
      function fRetornaSQLFiltroDiferenteDaAtual: String;
      function fSQLCabecalhoImpr: String;
      function fRetornaSQLComponenteB: String;

      constructor create;

  end;

implementation

function TSQLOrdProdIndustrial.fRetornaSQLAutoIncremOrdPro: String;
begin
  Result:= 'SELECT AUTOINCREM FROM ORDGER WHERE ORD_CODORD = :CODORD AND ORD_DTACAD = :DTACAD';
end;

function TSQLOrdProdIndustrial.fRetornaSQLComponenteB: String;
begin
  Result:= 'SELECT * FROM CADITE WHERE ITE_CODITB = :CODITE';
end;

function TSQLOrdProdIndustrial.fRetornaSQLComponenteItem: String;
begin
  Result:= 'SELECT ITE_CODITB, ITE_COMPNA, ITE_COMPNB FROM CADITE WHERE ITE_CODITE = :CODITE';
end;

function TSQLOrdProdIndustrial.fRetornaSQLFiltroDiferenteDaAtual: String;
begin
  Result:= 'AND AUTOINCREM <> :ID';
end;

function TSQLOrdProdIndustrial.fRetornaSQLOrdPro: String;
CONST
  strTamCodIte = '7';
begin
  Result := '/* untOrdProIndustrial.fSQLOrdPro */';
  Result := Result + 'SELECT SQL_NO_CACHE        ';
  Result := Result + '  D.*,                     ';
  Result := Result + '  0.0000 AS QTDPRO_NOV, ';
  Result := Result + '  G.ORD_CODORD,            ';
  Result := Result + '  G.ORD_DTACAD,            ';
  Result := Result + '  CAST(" " AS CHAR(100)) AS DESITE, ';
  Result := Result + '  CAST(" " AS CHAR(06))  AS SIGUNI, ';
  Result := Result + '  CAST(" " AS CHAR(30))  AS DESUNI, ';
  Result := Result + '  CAST(" " AS CHAR(30))  AS DESMAR, ';
  Result := Result + '  0.000000 AS PESLIT,      ';
  Result := Result + '  0.000000 AS PESREA,      ';
  Result := Result + '  0.000000 AS PESACA,      ';
  Result := Result + '  0.000000 AS VOLACA,      ';
  Result := Result + '  0.000000 AS PESUNI,      ';
  Result := Result + '  0.000000 AS VOLUNI,      ';
  Result := Result + '  "   "    AS ORDITE,      ';
  Result := Result + '  "  "     AS KILLIT,      ';
  Result := Result + '  CAST(" " AS CHAR(30))  AS CODBAR, ';
  Result := Result + '  REPEAT(" ",20) AS NUMLOT,';
  Result := Result + '  "S" AS SITFRA,           '; // Campo Utilizado para controlar a situaçao das quantidades francionadas dos itens da composiçao quando (CFG_COMFRA = "?")
  Result := Result + '  0.000000 AS QTDPED,      '; //Campos Utilizados em : untAgruPedOrdProInd
  Result := Result + '  0.0000   AS QTDRST,      '; //Campos Utilizados em : untAgruPedOrdProInd
  Result := Result + '  0.000000 AS SALDOS,      ';
  Result := Result + '  0.000000 AS SUGEST,      ';
  Result := Result + '  0.000000 AS ESTUTI,      '; // Quantidade do estoque considerado no momento do agrupamento da ordem de produção (fAgrLot = true)
  Result := Result + '  CAST(" " AS CHAR('+strTamCodIte+'))  AS ITE_CODPAG, ';
  Result := Result + '  CAST(" " AS CHAR(04))  AS ITE_CODCOR, ';
  Result := Result + '  ORD_FORMUL,              ';
  Result := Result + '  ORD_CODCOR AS CODCOR,    ';
  Result := Result + '  COR_DESCOR AS DESCOR,    ';
  Result := Result + '  ORD_CODOPE AS CODOPE,    ';
  Result := Result + '  ITE_REFERE,              ';
  Result := Result + '  ORD_OPEFOR,              ';
  Result := Result + '  0.000000 AS QTDBAI,      ';
  Result := Result + '  0.000000 AS CUSTO_PLA,   '; // Custo total do produto acabado (planejado)
  Result := Result + '  0.000000 AS CUSTO_ENV,   '; // Custo total do produto acabado (Envasado), considerando quantidades envasadas e correçoes;
  Result := Result + '  G.ORD_DTAVAL AS DTAVAL,  ';
  Result := Result + '  Q.OPE_NOMOPE AS NOMQUI,  ';
  Result := Result + '  E.OPE_NOMOPE AS NOMENC,  ';
  Result := Result + '  L.OPE_NOMOPE AS NOMLIM,  ';
  Result := Result + '  U.OPE_NOMOPE AS NOMQUA,  ';
  Result := Result + '  G.ORD_CODQUI AS CODQUI,  ';
  Result := Result + '  G.ORD_CODENC AS CODENC,  ';
  Result := Result + '  G.ORD_CODLIM AS CODLIM,  ';
  Result := Result + '  G.ORD_CODQUA AS CODQUA,  ';
  Result := Result + '  GCO_CODCOM   AS CODCOM,  ';
  Result := Result + '  GCO_DESCOM   AS DESCOM,  ';
  Result := Result + '  0.000000 AS MLTVEN,       ';
  Result := Result + '  0.0000 AS ESTOQUE_MAXIMO, ';
  Result := Result + '  0.0000 AS ESTOQUE_MINIMO, ';
  Result := Result + '  0.0000 AS ESTOQUE_FISICO, ';
  Result := Result + '  0.0000 AS ESTOQUE_DISPONIVEL,  ';
  Result := Result + '  G.ORD_OBSPRO AS OBSPRC, ';
  Result := Result + '  0 AS SUGMAX,            '; // sugestão da capacidade máxima para produção
  Result := Result + '  ORD_UQDMAX AS UQDMAX,   ';
  Result := Result + '  I.ITE_REAEND,           ';
  Result := Result + '  I.ITE_CODITE AS CODITE, ';
  Result := Result + '  I.ITE_DESITE AS DESITE, ';

  If blnConCom Then
  Begin
    Result := Result + '  CAST((SELECT GROUP_CONCAT(DISTINCT FDO_COMPLE SEPARATOR "  ") ' +
                       '  FROM EXTDOR ' +
                       '  LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = FDO_SEQFDO ' +
                        '  WHERE FDO_SEQOPI = G.AUTOINCREM) AS CHAR(60)) AS COMPLE, ';
  End
  Else
    Result := Result + ' CAST("" AS CHAR(1)) AS COMPLE, ';

  Result := Result + '  (SELECT GROUP_CONCAT(DISTINCT FDO_NUMDOC SEPARATOR "  ")  ' +
                     '  FROM EXTDOR ' +
                     '  LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = FDO_SEQFDO ' +
                     '  WHERE FDO_SEQOPI = G.AUTOINCREM) AS GRUPED,  ';

  Result := Result + ' (SELECT IF(COUNT(0) > 0 , "S", "N") FROM LOCITE ';
  Result := Result + ' WHERE LCI_CODITE = I.ITE_CODITE AND             ';
  Result := Result + '       LCI_CODEMP = G.ORD_CODEMP) AS MAPEAD      ';
  Result := Result + ',  I.ITE_CEREPI AS CEREPI ';
  Result := Result + 'FROM ORDDET D              ';
  Result := Result + 'INNER JOIN ORDGER G ON G.AUTOINCREM = D.ORD_SEQGER ';
  Result := Result + 'INNER JOIN CADITE I ON I.ITE_CODITE = D.ORD_CODITE ';
  Result := Result + 'LEFT  JOIN CADCOR C ON C.COR_CODCOR = G.ORD_CODCOR ';

  Result := Result + 'LEFT JOIN CADOPE Q ON Q.OPE_CODOPE = G.ORD_CODQUI ';
  Result := Result + 'LEFT JOIN CADOPE E ON E.OPE_CODOPE = G.ORD_CODENC ';
  Result := Result + 'LEFT JOIN CADOPE L ON L.OPE_CODOPE = G.ORD_CODLIM ';
  Result := Result + 'LEFT JOIN CADOPE U ON U.OPE_CODOPE = G.ORD_CODQUA ';
  Result := Result + 'LEFT JOIN GERCOM   ON GCO_CODCOM   = I.ITE_CODCOM ';

  Result := Result + 'WHERE                          ';
  Result := Result + '   D.ORD_SEQGER = :SEQGER  AND ';
  Result := Result + '   I.ITE_ITEATI = "S"          ';
  If blnComQtd Then
    Result := Result + ' AND D.ORD_QTDPRO > 0  ';

end;

function TSQLOrdProdIndustrial.fSQLCabecalhoImpr: String;
begin
  Result := '/* untOrdProIndustrial.fSQLCabecalhoImpr */ ';

  Result := Result + ' SELECT SQL_NO_CACHE ';

  Result := Result + ' G.AUTOINCREM AS AUTINC, ';
  Result := Result + '   FGO_NUMDOC AS NUMDOC, ';
  Result := Result + '   FGO_ESPDOC AS ESPDOC, ';
  Result := Result + '   ORD_PESREA AS PESREA, ';
  Result := Result + '   ORD_CODITE AS CODITE, ';
  Result := Result + '   ORD_CODCOR AS CODCOR, ';
  Result := Result + '   COR_DESCOR AS DESCOR, ';
  Result := Result + ' I.ITE_DESITE AS DESITE, ';
  Result := Result + ' I.ITE_REFERE AS REFERE, ';
  Result := Result + '   ORD_CODORD AS CODORD, ';
  Result := Result + '   ORD_CODBAR AS CODBAR, ';
  Result := Result + '   ORD_DTACAD AS DTACAD, ';
  Result := Result + '   ORD_HORCAD AS HORCAD, ';
  Result := Result + ' I.ITE_CODFAB AS CODFAB, ';
  Result := Result + '   ORD_DTAPRE AS DTAPRE, ';
  Result := Result + '   ORD_DTABAI AS DTABAI, ';
  Result := Result + ' G.AUTOINCREM AS AUTOIN, ';
  Result := Result + '   ORD_OBSERV AS OBSERV, ';
  Result := Result + ' G.ORD_OBSPRO AS OBSPRC, ';
  Result := Result + ' DATE_FORMAT(G.ORD_DTAVAL, "%m/%Y") AS DTAVAL, ';
  Result := Result + ' ORD_LOTEOP AS LOTEOP, ';

  Result := Result + '   CONCAT(IFNULL(GRU_DETLIN, ""), " ", ';
  Result := Result + '          IFNULL(GRU_DETGRU, ""), " ", ';
  Result := Result + '          IFNULL(COR_DETCOR, ""), " ", ';
  Result := Result + '          IFNULL(UNI_DETUNI, "")) AS DESETI,  ';

  Result := Result + '   CONCAT("OP-", ORD_CODORD, " ", DATE_FORMAT(ORD_DTACAD,"%d/%m/%y")) AS NUMOPE, ';
  Result := Result + '   CONCAT(DATE_FORMAT(ORD_DTACAD,"%d%m%y"), ORD_CODORD) AS NUMLOT,  ';
  Result := Result + '   ORD_QTDPAR AS QTDPAR, ';
  Result := Result + '   CONCAT(FATGOR.FGO_NUMDOC, "-", FATGOR.FGO_ESPDOC, "-", FATGOR.FGO_CODEMP) AS NUMRES, ';

  Result := Result + '   IFNULL((SELECT SUM(EST_ESTUTI) FROM ORDEST WHERE EST_SEQGER = G.AUTOINCREM),0) AS ESTUTI, ';

  Result := Result + ' IF(G.ORD_SEQCPN IS NULL, "", CONCAT(I.ITE_CODITB," - ",B.ITE_DESITE)) AS DESITE_B, ';
  Result := Result + ' CONCAT(I.ITE_CODITD," - ",D.ITE_DESITE) AS DESITE_DILUENTE, ';
  Result := Result + ' O.OPE_NOMOPE AS NOMOPE, ';
  Result := Result + ' IF(G.ORD_SEQCPN IS NULL, "", B.ITE_REFERE) AS ITE_REFERE_B, ';
  Result := Result + ' D.ITE_REFERE AS ITE_REFERE_DILUENTE, ';
  Result := Result + ' I.ITE_APLICA AS ITE_APLICACAO, ';
  Result := Result + ' I.ITE_VALCAT AS RELACAO_CATALISE,';
  Result := Result + ' (SELECT CONCAT(DATE_FORMAT(ORD_DTACAD,"%d%m%y"), "-", ORD_CODORD) AS NUMLOT ';
  Result := Result + '    FROM ORDGER                                                              ';
  Result := Result + '   WHERE ORD_CODITE = G.ORD_CODITE                                           ';
  Result := Result + '     AND ORD_CODEMP = G.ORD_CODEMP                                           ';
  Result := Result + '     AND ORD_DTACAD <= G.ORD_DTACAD                                          ';
  Result := Result + '     AND IF(ORD_DTACAD = G.ORD_DTACAD, ORD_HORCAD < G.ORD_HORCAD, TRUE)      ';
  Result := Result + '   ORDER BY ORD_DTACAD DESC, ORD_HORCAD DESC LIMIT 1) AS ULTLOT,             ';
  Result := Result + ' DATE_FORMAT(ORD_DTAPRE, "%d/%m/%Y") AS DTAPRV ';
  Result := Result + ' FROM ';

  Result := Result + '   ORDGER G ';

  Result := Result + ' INNER JOIN CADITE I ON ITE_CODITE = ORD_CODITE ';
  Result := Result + ' INNER JOIN CADGRU ON GRU_CODGRU = I.ITE_CODGRU ';
  Result := Result + ' INNER JOIN CADCOR ON COR_CODCOR = ORD_CODCOR ';
  Result := Result + ' INNER JOIN CADUNI ON UNI_CODUNI = I.ITE_CODUNI ';
  Result := Result + ' LEFT JOIN EXTGOR ON EXTGOR.FGO_ORDIND = G.AUTOINCREM      ';
  Result := Result + ' LEFT JOIN FATGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';
  Result := Result + ' LEFT JOIN CADITE B ON I.ITE_CODITB = B.ITE_CODITE ';
  Result := Result + ' LEFT JOIN CADITE D ON I.ITE_CODITD = D.ITE_CODITE ';
  Result := Result + ' LEFT JOIN CADOPE O ON O.OPE_CODOPE = ORD_CODOPE ';

  Result := Result + ' WHERE    ';
  Result := Result + '   G.AUTOINCREM = :AUTINC ';

end;

constructor TSQLOrdProdIndustrial.create;
begin
  FComQtd:= False;
end;


end.
