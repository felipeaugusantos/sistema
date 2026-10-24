unit untAtualizaOcorrenciasCRM;

interface

uses
{$IFDEF LINUX}
  DBClient,
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  Uni,
  untfuncoesSimples,
  untConstantes,
  UniClientDataSet,
  cxProgressBar,
  untTypesSistema,
{$ENDIF LINUX}
  System.Classes,
  System.strUtils,
  untTypesCRM,
  untIFuncoesCRM;

{*******************************************}
{* HISTORICO DAS OCORRENCIAS               *}
{****************************************AC*}

const
  sqlItensPendentesReqCompra       = 'SELECT SQL_NO_CACHE                     '+
                                     '  PRQ_CODITE, PRQ_QTDITE, ITE_DESITE,   '+
                                     '  PRQ_EMPREQ                            '+
                                     '  FROM PREPRQ                           '+
                                     '  JOIN CADITE ON ITE_CODITE = PRQ_CODITE'+
                                     ' WHERE PRQ_NUMDOC = :NUMDOC             '+
                                     '   AND PRQ_ESPDOC = :ESPDOC             '+
                                     '   AND PRQ_EMPDOC = :CODEMP             '+
                                     '   AND PRQ_CODREQ IS NULL               ';

  sqlItensPendentesPDTransferencia = 'SELECT SQL_NO_CACHE                     '+
                                     '  PRE_EMPORI, PRE_QTDITE, PRE_CODITE,   '+
                                     '  ITE_DESITE                            '+
                                     '  FROM PREPTE                           '+
                                     '  JOIN CADITE ON ITE_CODITE = PRE_CODITE'+
                                     ' WHERE PRE_DOCABS = :NUMDOC             '+
                                     '   AND PRE_ESPABS = :ESPDOC             '+
                                     '   AND PRE_EMPABS = :CODEMP             '+
                                     '   AND PRE_NUMDOC IS NULL               '+
                                     'UNION ALL                               '+
                                     'SELECT                                  '+
                                     '  P.PRE_EMPORI, P.PRE_QTDITE,           '+
                                     '  P.PRE_CODITE, I.ITE_DESITE            '+
                                     '  FROM REQVEN R                         '+
                                     '  JOIN PREPTE P ON P.AUTOINCREM = R.SEQ_PREPTE'+
                                     '  JOIN MOVRCD M ON M.AUTOINCREM = R.SEQ_MOVRCD'+
                                     '  JOIN CADITE I ON I.ITE_CODITE = P.PRE_CODITE'+
                                     ' WHERE M.RCD_DOCPDV = :NUMDOC           '+
                                     '   AND M.RCD_ESPPDV = :ESPDOC           '+
                                     '   AND M.RCD_EMPPDV = :CODEMP           '+
                                     '   AND P.PRE_NUMDOC IS NULL             ';

  sqlItensReqCompraGerada          = 'SELECT SQL_NO_CACHE                     '+
                                     '  PRQ_CODREQ, PRQ_EMPREQ                '+
                                     '  FROM PREPRQ                           '+
                                     '  JOIN CADITE ON ITE_CODITE = PRQ_CODITE'+
                                     ' WHERE PRQ_NUMDOC = :NUMDOC             '+
                                     '   AND PRQ_ESPDOC = :ESPDOC             '+
                                     '   AND PRQ_EMPDOC = :CODEMP             '+
                                     '   AND IFNULL(PRQ_CODREQ, "") <> ""     '+
                                     ' GROUP BY PRQ_CODREQ, PRQ_EMPREQ        ';

  sqlItensPDTransfereciaGerado     = 'SELECT SQL_NO_CACHE                     '+
                                     '  PRE_EMPORI, PRE_QTDITE, PRE_CODITE,   '+
                                     '  PRE_DOCABS, PRE_ESPABS, PRE_EMPABS,   '+
                                     '  ITE_DESITE                            '+
                                     '  FROM PREPTE                           '+
                                     '  JOIN CADITE ON ITE_CODITE = PRE_CODITE'+
                                     ' WHERE PRE_NUMDOC = :NUMDOC             '+
                                     '   AND PRE_ESPDOC = :ESPDOC             '+
                                     '   AND PRE_EMPDOC = :CODEMP             '+
                                     'UNION ALL                               '+
                                     'SELECT                                  '+
                                     '  P.PRE_EMPORI, P.PRE_QTDITE,           '+
                                     '  PRE_CODITE, M.RCD_DOCPDV AS PRE_DOCABS,'+
                                     '  M.RCD_ESPPDV AS PRE_ESPABS,           '+
                                     '  M.RCD_EMPPDV AS PRE_EMPABS,           '+
                                     '  I.ITE_DESITE                          '+
                                     '  FROM REQVEN R                         '+
                                     '  JOIN PREPTE P ON P.AUTOINCREM = R.SEQ_PREPTE'+
                                     '  JOIN MOVRCD M ON M.AUTOINCREM = R.SEQ_MOVRCD'+
                                     '  JOIN CADITE I ON I.ITE_CODITE = P.PRE_CODITE'+
                                     ' WHERE P.PRE_NUMDOC = :NUMDOC           '+
                                     '   AND P.PRE_ESPDOC = :ESPDOC           '+
                                     '   AND P.PRE_EMPDOC = :CODEMP           ';

  sqlItensAguardandoPedidoCompra   = 'SELECT SQL_NO_CACHE                     '+
                                     '  RCD_CODITE, RCD_DESITE, RCD_CODEMP,   '+
                                     '  RCD_QTDITE, RCD_CODIGO                '+
                                     '  FROM MOVRCD                           '+
                                     ' WHERE RCD_DOCPDV = :NUMDOC             '+
                                     '   AND RCD_ESPPDV = :ESPDOC             '+
                                     '   AND RCD_EMPPDV = :CODEMP             '+
                                     '   AND RCD_ATETRA = 0                   '+
                                     '   AND RCD_SEQPCD IS NULL               ';

  sqlItensAguardandoTransferencia  = 'SELECT SQL_NO_CACHE                     '+
                                     '  PRE_EMPDOC, PRE_NUMDOC, PRE_ESPDOC    '+
                                     '  FROM PREPTE                           '+
                                     '  JOIN FATGOR F ON F.FGO_NUMDOC = PRE_NUMDOC'+
                                     '               AND F.FGO_ESPDOC = PRE_ESPDOC'+
                                     '               AND F.FGO_CODEMP = PRE_EMPDOC'+
                                     '  JOIN CADITE ON ITE_CODITE = PRE_CODITE'+
                                     ' WHERE PRE_DOCABS = :NUMDOC             '+
                                     '   AND PRE_ESPABS = :ESPDOC             '+
                                     '   AND PRE_EMPABS = :CODEMP             '+
                                     '   AND F.FGO_JAFATU = 0                 '+
                                     ' GROUP BY PRE_EMPDOC, PRE_NUMDOC, PRE_ESPDOC '+
                                     'UNION ALL                               '+
                                     'SELECT                                  '+
                                     '  P.PRE_EMPDOC,P.PRE_NUMDOC,P.PRE_ESPDOC'+
                                     '  FROM REQVEN R                         '+
                                     '  JOIN PREPTE P ON P.AUTOINCREM = R.SEQ_PREPTE'+
                                     '  JOIN MOVRCD M ON M.AUTOINCREM = R.SEQ_MOVRCD'+
                                     '  JOIN FATGOR F ON F.FGO_NUMDOC = P.PRE_NUMDOC'+
                                     '               AND F.FGO_ESPDOC = P.PRE_ESPDOC'+
                                     '               AND F.FGO_CODEMP = P.PRE_EMPDOC'+
                                     '  JOIN CADITE I ON I.ITE_CODITE = P.PRE_CODITE'+
                                     ' WHERE M.RCD_DOCPDV = :NUMDOC           '+
                                     '   AND M.RCD_ESPPDV = :ESPDOC           '+
                                     '   AND M.RCD_EMPPDV = :CODEMP           '+
                                     '   AND F.FGO_JAFATU = 0                 '+
                                     ' GROUP BY P.PRE_EMPDOC,P.PRE_NUMDOC,P.PRE_ESPDOC';

  sqlRequisicoesAtendidaPedCompra  = 'SELECT SQL_NO_CACHE                     '+
                                     '  M.RCD_DOCPDV,M.RCD_ESPPDV,M.RCD_EMPPDV'+
                                     '  FROM PCMDET P                         '+
                                     '  JOIN MOVRCD M ON M.RCD_SEQPCD = P.AUTOINCREM'+
                                     ' WHERE P.PCD_NUMPED = :NUMDOC           '+
                                     '   AND P.PCD_ESPDOC = :ESPDOC           '+
                                     '   AND P.PCD_CODEMP = :CODEMP           '+
                                     '   AND IFNULL(M.RCD_DOCPDV, "") <> ""   '+
                                     ' GROUP BY M.RCD_DOCPDV, M.RCD_ESPPDV,   '+
                                     '   M.RCD_EMPPDV                         ';

  sqlItensCompraEfetuada           = 'SELECT SQL_NO_CACHE                     '+
                                     '  P.PCD_CODITE,P.PCD_DESITE,P.PCD_QTDITE,'+
                                     '  CONCAT(P.PCD_CODFOR, "-", C.FOR_NOMFAN)'+
                                     '    AS FORNECEDOR                       '+
                                     '  FROM PCMDET P                         '+
                                     '  JOIN MOVRCD M ON M.RCD_SEQPCD = P.AUTOINCREM'+
                                     '  JOIN CADFOR C ON C.FOR_CODFOR = P.PCD_CODFOR'+
                                     ' WHERE M.RCD_DOCPDV = :NUMDOC           '+
                                     '   AND M.RCD_ESPPDV = :ESPDOC           '+
                                     '   AND M.RCD_EMPPDV = :CODEMP           '+
                                     '   AND P.PCD_NUMPED = :NUMPED           '+
                                     '   AND P.PCD_ESPDOC = :ESPPED           '+
                                     '   AND P.PCD_CODEMP = :EMPPED           '+
                                     ' GROUP BY P.AUTOINCREM                  ';

  sqlItensTransferenciaFaturados   = 'SELECT SQL_NO_CACHE                           '+
                                     '  D.DET_CODEMP, D.DET_QTDITE, D.DET_CODITE,   '+
                                     '  P.PRE_DOCABS, P.PRE_ESPABS, P.PRE_EMPABS,   '+
                                     '  I.ITE_DESITE, D.DET_NUMDOC, D.DET_ESPDOC,   '+
                                     '  G.GER_SERIE_                                '+
                                     '  FROM MOVDET D                               '+
                                     '  JOIN MOVGER G ON D.DET_SEQGER = G.AUTOINCREM'+
                                     '  JOIN PREPTE P ON D.DET_NUM_PD = P.PRE_NUMDOC'+
                                     '               AND D.DET_ESP_PD = P.PRE_ESPDOC'+
                                     '               AND D.DET_EMP_PD = P.PRE_EMPDOC'+
                                     '               AND D.DET_CODITE = P.PRE_CODITE'+
                                     '  JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE'+
                                     ' WHERE D.DET_NUMDOC = :NUMDOC                 '+
                                     '   AND D.DET_ESPDOC = :ESPDOC                 '+
                                     '   AND D.DET_CODEMP = :CODEMP                 '+
                                     'UNION ALL                                     '+
                                     'SELECT                                        '+
                                     '  D.DET_CODEMP, D.DET_QTDITE, D.DET_CODITE,   '+
                                     '  M.RCD_DOCPDV AS PRE_DOCABS,                 '+
                                     '  M.RCD_ESPPDV AS PRE_ESPABS,                 '+
                                     '  M.RCD_EMPPDV AS PRE_EMPABS,                 '+
                                     '  I.ITE_DESITE, D.DET_NUMDOC, D.DET_ESPDOC,   '+
                                     '  G.GER_SERIE_                                '+
                                     '  FROM MOVDET D                               '+
                                     '  JOIN MOVGER G ON D.DET_SEQGER = G.AUTOINCREM'+
                                     '  JOIN PREPTE P ON D.DET_NUM_PD = P.PRE_NUMDOC'+
                                     '               AND D.DET_ESP_PD = P.PRE_ESPDOC'+
                                     '               AND D.DET_EMP_PD = P.PRE_EMPDOC'+
                                     '               AND D.DET_CODITE = P.PRE_CODITE'+
                                     '  JOIN REQVEN R ON P.AUTOINCREM = R.SEQ_PREPTE'+
                                     '  JOIN MOVRCD M ON M.AUTOINCREM = R.SEQ_MOVRCD'+
                                     '  JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE'+
                                     ' WHERE D.DET_NUMDOC = :NUMDOC                 '+
                                     '   AND D.DET_ESPDOC = :ESPDOC                 '+
                                     '   AND D.DET_CODEMP = :CODEMP                 ';

  sqlPedidoTransferenciaBaixado    = 'SELECT SQL_NO_CACHE                     '+
                                     '  P.PRE_DOCABS, P.PRE_ESPABS, P.PRE_EMPABS'+
                                     '  FROM PREPTE P                         '+
                                     ' WHERE P.PRE_NUMDOC = :NUMDOC           '+
                                     '   AND P.PRE_ESPDOC = :ESPDOC           '+
                                     '   AND P.PRE_EMPDOC = :CODEMP           '+
                                     'UNION ALL                               '+
                                     'SELECT                                  '+
                                     '  M.RCD_DOCPDV AS PRE_DOCABS,           '+
                                     '  M.RCD_ESPPDV AS PRE_ESPABS,           '+
                                     '  M.RCD_EMPPDV AS PRE_EMPABS            '+
                                     '  FROM REQVEN R                         '+
                                     '  JOIN PREPTE P ON P.AUTOINCREM = R.SEQ_PREPTE'+
                                     '  JOIN MOVRCD M ON M.AUTOINCREM = R.SEQ_MOVRCD'+
                                     ' WHERE P.PRE_NUMDOC = :NUMDOC           '+
                                     '   AND P.PRE_ESPDOC = :ESPDOC           '+
                                     '   AND P.PRE_EMPDOC = :CODEMP           ';

  sqlDocsDeTransferenciaAgEntrega  = 'SELECT SQL_NO_CACHE                     '+
                                     '  D.DET_CODEMP, D.DET_NUMDOC,           '+
                                     '  D.DET_ESPDOC, G.GER_SERIE_            '+
                                     '  FROM MOVDET D                         '+
                                     '  JOIN MOVGER G ON D.DET_SEQGER = G.AUTOINCREM'+
                                     '  JOIN PREPTE P ON D.DET_NUM_PD = P.PRE_NUMDOC'+
                                     '               AND D.DET_ESP_PD = P.PRE_ESPDOC'+
                                     '               AND D.DET_EMP_PD = P.PRE_EMPDOC'+
                                     '               AND D.DET_CODITE = P.PRE_CODITE'+
                                     '  JOIN FATGOR F ON F.FGO_NUMDOC = P.PRE_NUMDOC'+
                                     '               AND F.FGO_ESPDOC = P.PRE_ESPDOC'+
                                     '               AND F.FGO_CODEMP = P.PRE_EMPDOC'+
                                     '  JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(   '+
                                     '      LPAD(IFNULL(F.FGO_NUMFAT,""),12,"0"),   '+
                                     '      LPAD(IFNULL(F.FGO_TIPFAT,""),2," "),    '+
                                     '      LPAD(TRIM(IFNULL(F.FGO_EMPFAT,"")),3,"0"))'+
                                     ' WHERE P.PRE_DOCABS = :NUMDOC           '+
                                     '   AND P.PRE_ESPABS = :ESPDOC           '+
                                     '   AND P.PRE_EMPABS = :CODEMP           '+
                                     '   AND D.DET_DOCDEV IS NULL             '+
                                     '   AND PD.PCD_BAIXAD = 0                '+
                                     ' GROUP BY D.DET_CODEMP, D.DET_NUMDOC,   '+
                                     '   D.DET_ESPDOC, G.GER_SERIE_           '+
                                     'UNION ALL                               '+
                                     'SELECT                                  '+
                                     '  D.DET_CODEMP, D.DET_NUMDOC,           '+
                                     '  D.DET_ESPDOC, G.GER_SERIE_            '+
                                     '  FROM MOVDET D                         '+
                                     '  JOIN MOVGER G ON D.DET_SEQGER = G.AUTOINCREM'+
                                     '  JOIN PREPTE P ON D.DET_NUM_PD = P.PRE_NUMDOC'+
                                     '               AND D.DET_ESP_PD = P.PRE_ESPDOC'+
                                     '               AND D.DET_EMP_PD = P.PRE_EMPDOC'+
                                     '               AND D.DET_CODITE = P.PRE_CODITE'+
                                     '  JOIN REQVEN R ON P.AUTOINCREM = R.SEQ_PREPTE'+
                                     '  JOIN MOVRCD M ON M.AUTOINCREM = R.SEQ_MOVRCD'+
                                     '  JOIN FATGOR F ON F.FGO_NUMDOC = P.PRE_NUMDOC'+
                                     '               AND F.FGO_ESPDOC = P.PRE_ESPDOC'+
                                     '               AND F.FGO_CODEMP = P.PRE_EMPDOC'+
                                     '  JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(   '+
                                     '      LPAD(IFNULL(F.FGO_NUMFAT,""),12,"0"),   '+
                                     '      LPAD(IFNULL(F.FGO_TIPFAT,""),2," "),    '+
                                     '      LPAD(TRIM(IFNULL(F.FGO_EMPFAT,"")),3,"0"))'+
                                     '  JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE'+
                                     ' WHERE M.RCD_DOCPDV = :NUMDOC           '+
                                     '   AND M.RCD_ESPPDV = :ESPDOC           '+
                                     '   AND M.RCD_EMPPDV = :CODEMP           '+
                                     '   AND D.DET_DOCDEV IS NULL             '+
                                     '   AND PD.PCD_BAIXAD = 0                '+
                                     ' GROUP BY D.DET_CODEMP, D.DET_NUMDOC,   '+
                                     '   D.DET_ESPDOC, G.GER_SERIE_           ';

  sqlDocsDeCompraAgEntrega         = 'SELECT SQL_NO_CACHE                     '+
                                     '  CONCAT(PC.PCD_NUMPED,"-",PC.PCD_ESPDOC,'+
                                     '         "-",PC.PCD_CODEMP) AS DOCUMENTO,'+
                                     '  CONCAT(PC.PCD_CODFOR,"-",F.FOR_NOMFAN)'+
                                     '         AS FORNECEDOR                  '+
                                     '  FROM MOVRCD RD                        '+
                                     '  JOIN PCMDET PC ON RD.RCD_SEQPCD = PC.AUTOINCREM'+
                                     '  JOIN CADFOR F ON PC.PCD_CODFOR = F.FOR_CODFOR'+
                                     ' LEFT                                   '+
                                     '  JOIN PEDELE PD ON PD.PEL_NUMDOC = PC.PCD_NUMPED'+
                                     '                AND PD.PEL_ESPDOC = PC.PCD_ESPDOC'+
                                     '                AND PD.PEL_CODEMP = PC.PCD_CODEMP'+
                                     ' LEFT                                   '+
                                     '  JOIN GERELE GE ON GE.AUTOINCREM = PD.PEL_SEQELE'+
                                     ' LEFT                                   '+
                                     '  JOIN DIGELE DI ON GE.GER_IDEDIG = DI.DIG_IDEDIG'+
                                     '                AND GE.GER_CODEMP = DI.DIG_CODEMP'+
                                     ' WHERE RD.RCD_DOCPDV = :NUMDOC          '+
                                     '   AND RD.RCD_ESPPDV = :ESPDOC          '+
                                     '   AND RD.RCD_EMPPDV = :CODEMP          '+
                                     '   AND DI.AUTOINCREM IS NULL            '+
                                     '   AND GE.GER_DTACON IS NULL            '+
                                     ' GROUP BY PC.PCD_NUMPED, PC.PCD_ESPDOC, '+
                                     '   PC.PCD_CODEMP                        ';

  sqlDocsDeCompraAgEntregaDepois   = ' SELECT                                                   '+
                                     '   SQL_NO_CACHE CONCAT(                                   '+
                                     '     PC.PCD_NUMPED,                                       '+
                                     '     "-",                                                 '+
                                     '     PC.PCD_ESPDOC,                                       '+
                                     '     "-",                                                 '+
                                     '     PC.PCD_CODEMP                                        '+
                                     '   ) AS DOCUMENTO,                                        '+
                                     '   CONCAT(PC.PCD_CODFOR, "-", F.FOR_NOMFAN) AS FORNECEDOR '+
                                     ' FROM                                                     '+
                                     '   MOVRCD RD                                              '+
                                     '   JOIN PCMDET PC                                         '+
                                     '     ON RD.RCD_SEQPCD = PC.AUTOINCREM                     '+
                                     '   LEFT JOIN BAIREQ BR                                    '+
                                     '     ON BR.BAI_AUTREQ = RD.AUTOINCREM                     '+
                                     '   JOIN CADFOR F                                          '+
                                     '     ON PC.PCD_CODFOR = F.FOR_CODFOR                      '+
                                     '   LEFT JOIN MOVDET MD                                    '+
                                     '     ON MD.AUTOINCREM = BR.BAI_AUTDET                     '+
                                     '   LEFT JOIN AGEDOC AD                                    '+
                                     '     ON AD.ADC_NUMDOC = MD.DET_NUMDOC                     '+
                                     '     AND AD.ADC_ESPDOC = MD.DET_ESPDOC                    '+
                                     '     AND AD.ADC_CODEMP = MD.DET_CODEMP                    '+
                                     '     AND AD.ADC_CODFOR = MD.DET_CODFOR                    '+
                                     '   LEFT JOIN AGEREC AR                                    '+
                                     '     ON AD.ADC_SEQGER = AR.AUTOINCREM                     '+
                                     ' WHERE RCD_DOCPDV = :NUMDOC                               '+
                                     '   AND RCD_ESPPDV = :ESPDOC                               '+
                                     '   AND RCD_EMPPDV = :CODEMP                               '+
                                     '   AND (                                                  '+
                                     '     (IFNULL(BR.BAI_AUTPED, "") = "")                     '+
                                     '     OR (IFNULL(AR.ARC_STATUS, "AG") = "AG")              '+
                                     '   )                                                      '+
                                     '   AND (IFNULL(MD.DET_DTAENT, "") = "")                   '+
                                     ' GROUP BY PC.PCD_NUMPED,                                  '+
                                     '   PC.PCD_ESPDOC,                                         '+
                                     '   PC.PCD_CODEMP;                                         ';

  sqlPedidoPreNota                 = 'SELECT SQL_NO_CACHE                     '+
                                     '  M.RCD_DOCPDV,M.RCD_ESPPDV,M.RCD_EMPPDV,'+
                                     '  G.B08_NNF, G.B07_SERIE                '+
                                     '  FROM PCMDET P                         '+
                                     '  JOIN MOVRCD M ON M.RCD_SEQPCD = P.AUTOINCREM'+
                                     '  JOIN PEDELE D ON D.PEL_NUMDOC = P.PCD_NUMPED'+
                                     '               AND D.PEL_ESPDOC = P.PCD_ESPDOC'+
                                     '               AND D.PEL_CODEMP = P.PCD_CODEMP'+
                                     '  JOIN GERELE G ON G.AUTOINCREM = D.PEL_SEQELE'+
                                     '  JOIN DETELE E ON E.DET_SEQGER = G.AUTOINCREM'+
                                     '               AND E.DET_CODITE = P.PCD_CODITE'+
                                     ' WHERE P.PCD_NUMPED = :NUMDOC           '+
                                     '   AND P.PCD_ESPDOC = :ESPDOC           '+
                                     '   AND P.PCD_CODEMP = :CODEMP           '+
                                     ' GROUP BY M.RCD_DOCPDV, M.RCD_ESPPDV,   '+
                                     '   M.RCD_EMPPDV                         ';

  sqlDocumentosAgConferencia       = 'SELECT SQL_NO_CACHE                     '+
                                     '  CONCAT(PC.PCD_NUMPED,"-",PC.PCD_ESPDOC,'+
                                     '         "-",PC.PCD_CODEMP) AS PEDIDO,  '+
                                     '  CONCAT(GE.B08_NNF,"-", GE.B07_SERIE)  '+
                                     '         AS NOTAFISCAL,                 '+
                                     '  CONCAT(PC.PCD_CODFOR,"-",F.FOR_NOMFAN)'+
                                     '         AS FORNECEDOR                  '+
                                     '  FROM MOVRCD RD                        '+
                                     '  JOIN PCMDET PC ON RD.RCD_SEQPCD = PC.AUTOINCREM'+
                                     '  JOIN CADFOR F ON PC.PCD_CODFOR = F.FOR_CODFOR'+
                                     '  JOIN PEDELE PE ON PE.PEL_NUMDOC = PC.PCD_NUMPED'+
                                     '                AND PE.PEL_ESPDOC = PC.PCD_ESPDOC'+
                                     '                AND PE.PEL_CODEMP = PC.PCD_CODEMP'+
                                     '  JOIN GERELE GE ON GE.AUTOINCREM = PE.PEL_SEQELE'+
                                     ' WHERE RCD_DOCPDV = :NUMDOC             '+
                                     '   AND RCD_ESPPDV = :ESPDOC             '+
                                     '   AND RCD_EMPPDV = :CODEMP             '+
                                     '   AND GE.GER_DTACON IS NULL            '+
                                     ' GROUP BY PC.PCD_NUMPED, PC.PCD_ESPDOC, '+
                                     '   PC.PCD_CODEMP, GE.B08_NNF,           '+
                                     '   GE.B07_SERIE                         ';

  sqlAgEntradaMercadoria           = 'SELECT CONCAT(PD.PCD_NUMPED,"-",PD.PCD_ESPDOC,'+
                                     '              "-",PD.PCD_CODEMP) AS PEDIDO,'+
                                     '  CONCAT(GE.B08_NNF,"-", GE.B07_SERIE) AS NOTAFISCAL,'+
                                     '  CONCAT(PD.PCD_CODFOR,"-",F.FOR_NOMFAN) AS FORNECEDOR'+
                                     '  FROM MOVRCD RD                        '+
                                     '  JOIN PCMDET PD ON RD.RCD_SEQPCD = PD.AUTOINCREM'+
                                     '  JOIN CADFOR F  ON PD.PCD_CODFOR = F.FOR_CODFOR'+
                                     '  JOIN PEDELE PE ON PE.PEL_NUMDOC = PD.PCD_NUMPED'+
                                     '                AND PE.PEL_ESPDOC = PD.PCD_ESPDOC'+
                                     '                AND PE.PEL_CODEMP = PD.PCD_CODEMP'+
                                     '  JOIN GERELE GE ON GE.AUTOINCREM = PE.PEL_SEQELE'+
                                     ' LEFT                                   '+
                                     '  JOIN MOVDET MD ON MD.DET_NUMDOC = IF(IFNULL(TRIM(PD.PCD_DOCEMI), "") <> "", PD.PCD_DOCEMI, GE.B08_NNF)'+
                                     '                AND MD.DET_ESPDOC = IF(IFNULL(TRIM(PD.PCD_ESPEMI), "") <> "", PD.PCD_ESPEMI, "NF")'+
                                     '                AND MD.DET_EMPCOM = PD.PCD_CODEMP'+
                                     '                AND MD.DET_PEDCOM = PD.PCD_NUMPED'+
                                     ' WHERE RD.RCD_DOCPDV = :NUMDOC          '+
                                     '   AND RD.RCD_ESPPDV = :ESPDOC          '+
                                     '   AND RD.RCD_EMPPDV = :CODEMP          '+
                                     '   AND IFNULL(GE.GER_DTACON, "") <> ""  '+
                                     '   AND MD.AUTOINCREM IS NULL            '+
                                     'GROUP BY PD.PCD_NUMPED,PD.PCD_ESPDOC,   '+
                                     '  PD.PCD_CODEMP,GE.B08_NNF,GE.B07_SERIE '+
                                     'UNION ALL                               '+
                                     'SELECT CONCAT(PD.PCD_NUMPED,"-",PD.PCD_ESPDOC,'+
                                     '              "-",PD.PCD_CODEMP) AS PEDIDO,'+
                                     '  CONCAT(FG.FGO_NUMFAT,"-",FG.FGO_SERIE_) AS NOTAFISCAL,'+
                                     '  CONCAT(PD.PCD_CODFOR,"-",F.FOR_NOMFAN) AS FORNECEDOR'+
                                     '  FROM EXTGOR ET                        '+
                                     '  JOIN FATGOR FG ON ET.FGO_SEQFGO = FG.AUTOINCREM'+
                                     '  JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT('+
                                     '        LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),'+
                                     '        LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "),'+
                                     '        LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))'+
                                     '  JOIN CADFOR F  ON PD.PCD_CODFOR = F.FOR_CODFOR'+
                                     ' LEFT                                   '+
                                     '  JOIN MOVDET MD ON MD.DET_NUMDOC = FG.FGO_NUMFAT'+
                                     '                AND MD.DET_ESPDOC = FG.FGO_TIPFAT'+
                                     '                AND MD.DET_EMPCOM = FG.FGO_EMPFAT'+
                                     '                AND MD.DET_PEDCOM = PD.PCD_NUMPED'+
                                     '                AND MD.DET_CODITE = PD.PCD_CODITE'+
                                     ' WHERE ET.FGO_NMPDAB = :NUMDOC          '+
                                     '   AND ET.FGO_ESPDAB = :ESPDOC          '+
                                     '   AND ET.FGO_EMPDAB = :CODEMP          '+
                                     '   AND PD.PCD_BAIXAD = TRUE             '+
                                     '   AND MD.AUTOINCREM IS NULL            '+
                                     'GROUP BY PD.PCD_NUMPED,PD.PCD_ESPDOC,PD.PCD_CODEMP,'+
                                     '  FG.FGO_NUMFAT, FG.FGO_SERIE_          '+
                                     'UNION ALL                               '+
                                     'SELECT CONCAT(PD.PCD_NUMPED,"-",PD.PCD_ESPDOC,'+
                                     '              "-",PD.PCD_CODEMP) AS PEDIDO,'+
                                     '  CONCAT(FG.FGO_NUMFAT,"-",FG.FGO_SERIE_) AS NOTAFISCAL,'+
                                     '  CONCAT(PD.PCD_CODFOR,"-",F.FOR_NOMFAN) AS FORNECEDOR'+
                                     '  FROM REQVEN                           '+
                                     '  JOIN PREPTE ON PREPTE.AUTOINCREM = SEQ_PREPTE'+
                                     '  JOIN MOVRCD RD ON RD.AUTOINCREM = SEQ_MOVRCD'+
                                     '  JOIN FATGOR FG ON FGO_NUMDOC = PRE_NUMDOC'+
                                     '                AND FGO_ESPDOC = PRE_ESPDOC'+
                                     '                AND FGO_CODEMP = PRE_EMPDOC'+
                                     '  JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT('+
                                     '        LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),'+
                                     '        LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "),'+
                                     '        LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))'+
                                     '  JOIN CADFOR F  ON PD.PCD_CODFOR = F.FOR_CODFOR'+
                                     ' LEFT                                   '+
                                     '  JOIN MOVDET MD ON MD.DET_NUMDOC = FG.FGO_NUMFAT'+
                                     '                AND MD.DET_ESPDOC = FG.FGO_TIPFAT'+
                                     '                AND MD.DET_EMPCOM = FG.FGO_EMPFAT'+
                                     '                AND MD.DET_PEDCOM = PD.PCD_NUMPED'+
                                     '                AND MD.DET_CODITE = PD.PCD_CODITE'+
                                     ' WHERE RD.RCD_DOCPDV = :NUMDOC          '+
                                     '   AND RD.RCD_ESPPDV = :ESPDOC          '+
                                     '   AND RD.RCD_EMPPDV = :CODEMP          '+
                                     '   AND PD.PCD_BAIXAD = TRUE             '+
                                     '   AND MD.AUTOINCREM IS NULL            '+
                                     'GROUP BY PD.PCD_NUMPED,PD.PCD_ESPDOC,PD.PCD_CODEMP,'+
                                     '  FG.FGO_NUMFAT, FG.FGO_SERIE_          ';

  sqlEntradaMercadoria             = 'SELECT RD.RCD_DOCPDV AS PEDVEN, RD.RCD_ESPPDV AS ESPVEN,'+
                                     '  RD.RCD_EMPPDV AS EMPVEN, PC.PCD_NUMPED AS PEDCOM,'+
                                     '  PC.PCD_ESPDOC AS ESPCOM, PC.PCD_CODEMP AS EMPCOM,'+
                                     '  MD.DET_SERIE_                         '+
                                     '  FROM MOVRCD RD                        '+
                                     '  JOIN PCMDET PC ON RD.RCD_SEQPCD = PC.AUTOINCREM'+
                                     '  JOIN PEDELE PD ON PD.PEL_NUMDOC = PC.PCD_NUMPED'+
                                     '                AND PD.PEL_ESPDOC = PC.PCD_ESPDOC'+
                                     '                AND PD.PEL_CODEMP = PC.PCD_CODEMP'+
                                     '  JOIN GERELE GE ON GE.AUTOINCREM = PD.PEL_SEQELE'+
                                     '  JOIN MOVDET MD ON MD.DET_NUMDOC = IF(IFNULL(TRIM(PC.PCD_DOCEMI), "") <> "", PC.PCD_DOCEMI, GE.B08_NNF)'+
                                     '                AND MD.DET_ESPDOC = IF(IFNULL(TRIM(PC.PCD_ESPEMI), "") <> "", PC.PCD_ESPEMI, "NF")'+
                                     '                AND MD.DET_EMPCOM = PC.PCD_CODEMP'+
                                     '                AND MD.DET_PEDCOM = PC.PCD_NUMPED'+
                                     '                AND MD.DET_CODITE = PC.PCD_CODITE'+
                                     ' WHERE MD.DET_NUMDOC = :NUMDOC          '+
                                     '   AND MD.DET_ESPDOC = :ESPDOC          '+
                                     '   AND MD.DET_CODEMP = :CODEMP          '+
                                     ' GROUP BY RD.RCD_DOCPDV, RD.RCD_ESPPDV, '+
                                     '   RD.RCD_EMPPDV                        '+
                                     'UNION ALL                               '+
                                     'SELECT ET.FGO_NMPDAB AS PEDVEN, ET.FGO_ESPDAB AS ESPVEN,'+
                                     '  ET.FGO_EMPDAB AS EMPVEN, PD.PCD_NUMPED AS PEDCOM,'+
                                     '  PD.PCD_ESPDOC AS ESPCOM, PD.PCD_CODEMP AS EMPCOM,'+
                                     '  MD.DET_SERIE_                         '+
                                     '  FROM EXTGOR ET                        '+
                                     '  JOIN FATGOR FG ON ET.FGO_SEQFGO = FG.AUTOINCREM'+
                                     '  JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT('+
                                     '        LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),'+
                                     '        LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "),'+
                                     '        LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))'+
                                     '  JOIN MOVDET MD ON MD.DET_NUMDOC = FG.FGO_NUMFAT'+
                                     '                AND MD.DET_ESPDOC = FG.FGO_TIPFAT'+
                                     '                AND MD.DET_EMPCOM = FG.FGO_EMPFAT'+
                                     '                AND MD.DET_PEDCOM = PD.PCD_NUMPED'+
                                     '                AND MD.DET_CODITE = PD.PCD_CODITE'+
                                     ' WHERE MD.DET_NUMDOC = :NUMDOC          '+
                                     '   AND MD.DET_ESPDOC = :ESPDOC          '+
                                     '   AND MD.DET_CODEMP = :CODEMP          '+
                                     ' GROUP BY ET.FGO_NMPDAB, ET.FGO_ESPDAB, '+
                                     '   ET.FGO_EMPDAB                        '+
                                     'UNION ALL                               '+
                                     'SELECT RD.RCD_DOCPDV AS PEDVEN, RD.RCD_ESPPDV AS ESPVEN,'+
                                     '  RD.RCD_EMPPDV AS EMPVEN, PD.PCD_NUMPED AS PEDCOM,'+
                                     '  PD.PCD_ESPDOC AS ESPCOM, PD.PCD_CODEMP AS EMPCOM,'+
                                     '  MD.DET_SERIE_                         '+
                                     '  FROM REQVEN                           '+
                                     '  JOIN PREPTE ON PREPTE.AUTOINCREM = SEQ_PREPTE'+
                                     '  JOIN MOVRCD RD ON RD.AUTOINCREM = SEQ_MOVRCD'+
                                     '  JOIN FATGOR FG ON FGO_NUMDOC = PRE_NUMDOC'+
                                     '                AND FGO_ESPDOC = PRE_ESPDOC'+
                                     '                AND FGO_CODEMP = PRE_EMPDOC'+
                                     '  JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT('+
                                     '        LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),'+
                                     '        LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "),'+
                                     '        LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))'+
                                     '  JOIN MOVDET MD ON MD.DET_NUMDOC = FG.FGO_NUMFAT'+
                                     '                AND MD.DET_ESPDOC = FG.FGO_TIPFAT'+
                                     '                AND MD.DET_EMPCOM = FG.FGO_EMPFAT'+
                                     '                AND MD.DET_PEDCOM = PD.PCD_NUMPED'+
                                     '                AND MD.DET_CODITE = PD.PCD_CODITE'+
                                     ' WHERE MD.DET_NUMDOC = :NUMDOC          '+
                                     '   AND MD.DET_ESPDOC = :ESPDOC          '+
                                     '   AND MD.DET_CODEMP = :CODEMP          '+
                                     ' GROUP BY RD.RCD_DOCPDV, RD.RCD_ESPPDV, '+
                                     '   RD.RCD_EMPPDV                        ';

  sqlDocumentosAgEnderecamento     = 'SELECT SQL_NO_CACHE PEDIDO, NOTAFISCAL, '+
                                     '  FORNECEDOR                            '+
                                     '  FROM                                  '+
                                     '    (SELECT IF((PD.PCD_BAIXAD = 0 AND   '+
                                     '                IFNULL(GE.GER_DTACON, "") <> "")'+
                                     '            	OR (IFNULL(EG.FGO_DOCEND, "") <> ""), "N", "S") AS BAIEND,'+
                                     '       CONCAT(PD.PCD_NUMPED,"-",PD.PCD_ESPDOC,'+
                                     '              "-",PD.PCD_CODEMP) AS PEDIDO,'+
                                     '       CONCAT(GE.B08_NNF,"-", GE.B07_SERIE) AS NOTAFISCAL,'+
                                     '       CONCAT(PD.PCD_CODFOR,"-",F.FOR_NOMFAN) AS FORNECEDOR'+
                                     '      FROM MOVRCD RD                    '+
                                     '      JOIN PCMDET PD ON RD.RCD_SEQPCD = PD.AUTOINCREM'+
                                     '      JOIN CADFOR F  ON PD.PCD_CODFOR = F.FOR_CODFOR '+
                                     '      JOIN PEDELE PE ON PE.PEL_NUMDOC = PD.PCD_NUMPED'+
                                     '                    AND PE.PEL_ESPDOC = PD.PCD_ESPDOC'+
                                     '                    AND PE.PEL_CODEMP = PD.PCD_CODEMP'+
                                     '      JOIN GERELE GE ON GE.AUTOINCREM = PE.PEL_SEQELE'+
                                     '      JOIN MOVDET MD ON MD.DET_NUMDOC = IF(IFNULL(TRIM(PD.PCD_DOCEMI), "") <> "", PD.PCD_DOCEMI, GE.B08_NNF)'+
                                     '                    AND MD.DET_ESPDOC = IF(IFNULL(TRIM(PD.PCD_ESPEMI), "") <> "", PD.PCD_ESPEMI, "NF")'+
                                     '                    AND MD.DET_EMPCOM = PD.PCD_CODEMP'+
                                     '                    AND MD.DET_PEDCOM = PD.PCD_NUMPED'+
                                     '                    AND MD.DET_CODITE = PD.PCD_CODITE'+
                                     '     LEFT                               '+
                                     '      JOIN EXTGOR EG ON EG.FGO_DOCEND = CONCAT( '+
                                     '        LPAD(IFNULL(MD.DET_NUMDOC,""),12,"0"),  '+
                                     '        LPAD(IFNULL(MD.DET_ESPDOC,""), 2,"0"),  '+
                                     '        RPAD(TRIM(IFNULL(MD.DET_SERIE_,"")),3," "),'+
                                     '        LPAD(TRIM(IFNULL(MD.DET_CODEMP,"")),3,"0"),'+
                                     '        LPAD(TRIM(IFNULL(MD.DET_CODFOR,"")),8,"0"),'+
                                     '        TRIM(IFNULL(MD.DET_TIP_FC, " ")))       '+
                                     '     WHERE RD.RCD_DOCPDV = :NUMDOC      '+
                                     '       AND RD.RCD_ESPPDV = :ESPDOC      '+
                                     '       AND RD.RCD_EMPPDV = :CODEMP      '+
                                     '    ) TMP                               '+
                                     '  WHERE TMP.BAIEND = "N"                '+
                                     ' GROUP BY TMP.NOTAFISCAL, TMP.PEDIDO    '+
                                     '  UNION ALL                             '+
                                     ' SELECT CONCAT(PD.PCD_NUMPED,"-",PD.PCD_ESPDOC,'+
                                     '              "-",PD.PCD_CODEMP) AS PEDIDO,'+
                                     '  CONCAT(MD.DET_NUMDOC, "-", MD.DET_SERIE_) AS NOTAFISCAL,'+
                                     '  CONCAT(PD.PCD_CODFOR,"-",F.FOR_NOMFAN) AS FORNECEDOR'+
                                     '    FROM EXTGOR ET                      '+
                                     '    JOIN FATGOR FG ON ET.FGO_SEQFGO = FG.AUTOINCREM'+
                                     '    JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(   '+
                                     '        LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),  '+
                                     '        LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "),   '+
                                     '        LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))'+
                                     '    JOIN CADFOR F  ON PD.PCD_CODFOR = F.FOR_CODFOR '+
                                     '    JOIN MOVDET MD ON MD.DET_NUMDOC = FG.FGO_NUMFAT'+
                                     '                  AND MD.DET_ESPDOC = FG.FGO_TIPFAT'+
                                     '                  AND MD.DET_EMPCOM = FG.FGO_EMPFAT'+
                                     '                  AND MD.DET_PEDCOM = PD.PCD_NUMPED'+
                                     '                  AND MD.DET_CODITE = PD.PCD_CODITE'+
                                     '    JOIN EXTGOR EG ON EG.FGO_DOCEND = CONCAT(   '+
                                     '        LPAD(IFNULL(MD.DET_NUMDOC,""),12,"0"),  '+
                                     '        LPAD(IFNULL(MD.DET_ESPDOC,""), 2,"0"),  '+
                                     '        RPAD(TRIM(IFNULL(MD.DET_SERIE_,"")),3," "),'+
                                     '        LPAD(TRIM(IFNULL(MD.DET_CODEMP,"")),3,"0"),'+
                                     '        LPAD(TRIM(IFNULL(MD.DET_CODFOR,"")),8,"0"),'+
                                     '        TRIM(IFNULL(MD.DET_TIP_FC, " ")))       '+
                                     '   WHERE ET.FGO_NMPDAB = :NUMDOC        '+
                                     '     AND ET.FGO_ESPDAB = :ESPDOC        '+
                                     '     AND ET.FGO_EMPDAB = :CODEMP        '+
                                     ' GROUP BY MD.DET_NUMDOC, MD.DET_SERIE_, '+
                                     '   PD.PCD_NUMPED, PD.PCD_ESPDOC, PD.PCD_CODEMP'+
                                     '  UNION ALL                             '+
                                     '  SELECT CONCAT(PD.PCD_NUMPED,"-",PD.PCD_ESPDOC,'+
                                     '              "-",PD.PCD_CODEMP) AS PEDIDO,'+
                                     '  CONCAT(MD.DET_NUMDOC, "-", MD.DET_SERIE_) AS NOTAFISCAL,'+
                                     '  CONCAT(PD.PCD_CODFOR,"-",F.FOR_NOMFAN) AS FORNECEDOR'+
                                     '    FROM REQVEN                         '+
                                     '    INNER JOIN PREPTE                   '+
                                     '      ON PREPTE.AUTOINCREM = SEQ_PREPTE '+
                                     '    INNER JOIN MOVRCD                   '+
                                     '      ON MOVRCD.AUTOINCREM = SEQ_MOVRCD '+
                                     '    INNER JOIN FATGOR FG                '+
                                     '      ON FGO_NUMDOC = PRE_NUMDOC        '+
                                     '      AND FGO_ESPDOC = PRE_ESPDOC       '+
                                     '      AND FGO_CODEMP = PRE_EMPDOC       '+
                                     '    JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(   '+
                                     '        LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),  '+
                                     '        LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "),   '+
                                     '        LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))'+
                                     '    JOIN CADFOR F  ON PD.PCD_CODFOR = F.FOR_CODFOR '+
                                     '    JOIN MOVDET MD ON MD.DET_NUMDOC = FG.FGO_NUMFAT'+
                                     '                  AND MD.DET_ESPDOC = FG.FGO_TIPFAT'+
                                     '                  AND MD.DET_EMPCOM = FG.FGO_EMPFAT'+
                                     '                  AND MD.DET_PEDCOM = PD.PCD_NUMPED'+
                                     '                  AND MD.DET_CODITE = PD.PCD_CODITE'+
                                     '    JOIN EXTGOR EG ON EG.FGO_DOCEND = CONCAT(   '+
                                     '        LPAD(IFNULL(MD.DET_NUMDOC,""),12,"0"),  '+
                                     '        LPAD(IFNULL(MD.DET_ESPDOC,""), 2,"0"),  '+
                                     '        RPAD(TRIM(IFNULL(MD.DET_SERIE_,"")),3," "),'+
                                     '        LPAD(TRIM(IFNULL(MD.DET_CODEMP,"")),3,"0"),'+
                                     '        LPAD(TRIM(IFNULL(MD.DET_CODFOR,"")),8,"0"),'+
                                     '        TRIM(IFNULL(MD.DET_TIP_FC, " ")))       '+
                                     '  WHERE RCD_DOCPDV = :NUMDOC            '+
                                     '    AND RCD_ESPPDV = :ESPDOC            '+
                                     '    AND RCD_EMPPDV = :CODEMP            '+
                                     ' GROUP BY MD.DET_NUMDOC, MD.DET_SERIE_, '+
                                     '   PD.PCD_NUMPED, PD.PCD_ESPDOC, PD.PCD_CODEMP';

  sqlEnderecamentoFinalizado       = 'SELECT SQL_NO_CACHE PEDIDO, NOTAFISCAL, '+
                                     '  FORNECEDOR, PEDVEN, ESPVEN, EMPVEN    '+
                                     '  FROM                                  '+
                                     '    (SELECT IF((PD.PCD_BAIXAD = 0 AND   '+
                                     '                IFNULL(GE.GER_DTACON, "") <> "")'+
                                     '            	OR (IFNULL(EG.FGO_DOCEND, "") <> ""), "N", "S") AS BAIEND,'+
                                     '       CONCAT(PD.PCD_NUMPED,"-",PD.PCD_ESPDOC,'+
                                     '              "-",PD.PCD_CODEMP) AS PEDIDO,'+
                                     '       CONCAT(GE.B08_NNF,"-", GE.B07_SERIE) AS NOTAFISCAL,'+
                                     '       CONCAT(PD.PCD_CODFOR,"-",F.FOR_NOMFAN) AS FORNECEDOR,'+
                                     '       RD.RCD_DOCPDV AS PEDVEN,         '+
                                     '       RD.RCD_ESPPDV AS ESPVEN,         '+
                                     '       RD.RCD_EMPPDV AS EMPVEN          '+
                                     '      FROM MOVRCD RD                    '+
                                     '      JOIN PCMDET PD ON RD.RCD_SEQPCD = PD.AUTOINCREM'+
                                     '      JOIN CADFOR F  ON PD.PCD_CODFOR = F.FOR_CODFOR '+
                                     '      JOIN PEDELE PE ON PE.PEL_NUMDOC = PD.PCD_NUMPED'+
                                     '                    AND PE.PEL_ESPDOC = PD.PCD_ESPDOC'+
                                     '                    AND PE.PEL_CODEMP = PD.PCD_CODEMP'+
                                     '      JOIN GERELE GE ON GE.AUTOINCREM = PE.PEL_SEQELE'+
                                     '      JOIN MOVDET MD ON MD.DET_NUMDOC = IF(IFNULL(TRIM(PD.PCD_DOCEMI), "") <> "", PD.PCD_DOCEMI, GE.B08_NNF)'+
                                     '                    AND MD.DET_ESPDOC = IF(IFNULL(TRIM(PD.PCD_ESPEMI), "") <> "", PD.PCD_ESPEMI, "NF")'+
                                     '                    AND MD.DET_EMPCOM = PD.PCD_CODEMP'+
                                     '                    AND MD.DET_PEDCOM = PD.PCD_NUMPED'+
                                     '                    AND MD.DET_CODITE = PD.PCD_CODITE'+
                                     '     LEFT                               '+
                                     '      JOIN EXTGOR EG ON EG.FGO_DOCEND = CONCAT( '+
                                     '        LPAD(IFNULL(MD.DET_NUMDOC,""),12,"0"),  '+
                                     '        LPAD(IFNULL(MD.DET_ESPDOC,""), 2,"0"),  '+
                                     '        RPAD(TRIM(IFNULL(MD.DET_SERIE_,"")),3," "),'+
                                     '        LPAD(TRIM(IFNULL(MD.DET_CODEMP,"")),3,"0"),'+
                                     '        LPAD(TRIM(IFNULL(MD.DET_CODFOR,"")),8,"0"),'+
                                     '        TRIM(IFNULL(MD.DET_TIP_FC, " ")))       '+
                                     '     WHERE MD.DET_NUMDOC = :NUMDOC      '+
                                     '       AND MD.DET_ESPDOC = :ESPDOC      '+
                                     '       AND MD.DET_CODEMP = :CODEMP      '+
                                     '    ) TMP                               '+
                                     '  WHERE TMP.BAIEND = "S"                '+
                                     ' GROUP BY TMP.NOTAFISCAL, TMP.PEDIDO,   '+
                                     '   TMP.PEDVEN, TMP.ESPVEN, TMP.EMPVEN   '+
                                     '  UNION ALL                             '+
                                     ' SELECT CONCAT(PD.PCD_NUMPED,"-",PD.PCD_ESPDOC,'+
                                     '              "-",PD.PCD_CODEMP) AS PEDIDO,'+
                                     '  CONCAT(MD.DET_NUMDOC, "-", MD.DET_SERIE_) AS NOTAFISCAL,'+
                                     '  CONCAT(PD.PCD_CODFOR,"-",F.FOR_NOMFAN) AS FORNECEDOR,'+
                                     '  ET.FGO_NMPDAB AS PEDVEN,              '+
                                     '  ET.FGO_ESPDAB AS ESPVEN,              '+
                                     '  ET.FGO_EMPDAB AS EMPVEN               '+
                                     '    FROM EXTGOR ET                      '+
                                     '    JOIN FATGOR FG ON ET.FGO_SEQFGO = FG.AUTOINCREM'+
                                     '    JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(   '+
                                     '        LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),  '+
                                     '        LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "),   '+
                                     '        LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))'+
                                     '    JOIN CADFOR F  ON PD.PCD_CODFOR = F.FOR_CODFOR '+
                                     '    JOIN MOVDET MD ON MD.DET_NUMDOC = FG.FGO_NUMFAT'+
                                     '                  AND MD.DET_ESPDOC = FG.FGO_TIPFAT'+
                                     '                  AND MD.DET_EMPCOM = FG.FGO_EMPFAT'+
                                     '                  AND MD.DET_PEDCOM = PD.PCD_NUMPED'+
                                     '                  AND MD.DET_CODITE = PD.PCD_CODITE'+
                                     '   LEFT                                 '+
                                     '    JOIN EXTGOR EG ON EG.FGO_DOCEND = CONCAT(   '+
                                     '        LPAD(IFNULL(MD.DET_NUMDOC,""),12,"0"),  '+
                                     '        LPAD(IFNULL(MD.DET_ESPDOC,""), 2,"0"),  '+
                                     '        RPAD(TRIM(IFNULL(MD.DET_SERIE_,"")),3," "),'+
                                     '        LPAD(TRIM(IFNULL(MD.DET_CODEMP,"")),3,"0"),'+
                                     '        LPAD(TRIM(IFNULL(MD.DET_CODFOR,"")),8,"0"),'+
                                     '        TRIM(IFNULL(MD.DET_TIP_FC, " ")))       '+
                                     '   WHERE MD.DET_NUMDOC = :NUMDOC        '+
                                     '     AND MD.DET_ESPDOC = :ESPDOC        '+
                                     '     AND MD.DET_CODEMP = :CODEMP        '+
                                     '     AND PD.PCD_BAIXAD = TRUE           '+
                                     '     AND EG.FGO_DOCEND IS NULL          '+
                                     ' GROUP BY MD.DET_NUMDOC, MD.DET_SERIE_, '+
                                     '   PD.PCD_NUMPED, PD.PCD_ESPDOC, PD.PCD_CODEMP,'+
                                     '   ET.FGO_NMPDAB, ET.FGO_ESPDAB, ET.FGO_EMPDAB'+
                                     '  UNION ALL                             '+
                                     '  SELECT CONCAT(PD.PCD_NUMPED,"-",PD.PCD_ESPDOC,'+
                                     '              "-",PD.PCD_CODEMP) AS PEDIDO,'+
                                     '  CONCAT(MD.DET_NUMDOC, "-", MD.DET_SERIE_) AS NOTAFISCAL,'+
                                     '  CONCAT(PD.PCD_CODFOR,"-",F.FOR_NOMFAN) AS FORNECEDOR,'+
                                     '  RCD_DOCPDV AS PEDVEN,                 '+
                                     '  RCD_ESPPDV AS ESPVEN,                 '+
                                     '  RCD_EMPPDV AS EMPVEN                  '+
                                     '    FROM REQVEN                         '+
                                     '    INNER JOIN PREPTE                   '+
                                     '      ON PREPTE.AUTOINCREM = SEQ_PREPTE '+
                                     '    INNER JOIN MOVRCD                   '+
                                     '      ON MOVRCD.AUTOINCREM = SEQ_MOVRCD '+
                                     '    INNER JOIN FATGOR FG                '+
                                     '      ON FGO_NUMDOC = PRE_NUMDOC        '+
                                     '      AND FGO_ESPDOC = PRE_ESPDOC       '+
                                     '      AND FGO_CODEMP = PRE_EMPDOC       '+
                                     '    JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(   '+
                                     '        LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),  '+
                                     '        LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "),   '+
                                     '        LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))'+
                                     '    JOIN CADFOR F  ON PD.PCD_CODFOR = F.FOR_CODFOR '+
                                     '    JOIN MOVDET MD ON MD.DET_NUMDOC = FG.FGO_NUMFAT'+
                                     '                  AND MD.DET_ESPDOC = FG.FGO_TIPFAT'+
                                     '                  AND MD.DET_EMPCOM = FG.FGO_EMPFAT'+
                                     '                  AND MD.DET_PEDCOM = PD.PCD_NUMPED'+
                                     '                  AND MD.DET_CODITE = PD.PCD_CODITE'+
                                     '    JOIN EXTGOR EG ON EG.FGO_DOCEND = CONCAT(   '+
                                     '        LPAD(IFNULL(MD.DET_NUMDOC,""),12,"0"),  '+
                                     '        LPAD(IFNULL(MD.DET_ESPDOC,""), 2,"0"),  '+
                                     '        RPAD(TRIM(IFNULL(MD.DET_SERIE_,"")),3," "),'+
                                     '        LPAD(TRIM(IFNULL(MD.DET_CODEMP,"")),3,"0"),'+
                                     '        LPAD(TRIM(IFNULL(MD.DET_CODFOR,"")),8,"0"),'+
                                     '        TRIM(IFNULL(MD.DET_TIP_FC, " ")))       '+
                                     '   WHERE MD.DET_NUMDOC = :NUMDOC        '+
                                     '     AND MD.DET_ESPDOC = :ESPDOC        '+
                                     '     AND MD.DET_CODEMP = :CODEMP        '+
                                     '     AND PD.PCD_BAIXAD = TRUE           '+
                                     '     AND EG.FGO_DOCEND IS NULL          '+
                                     ' GROUP BY MD.DET_NUMDOC, MD.DET_SERIE_, '+
                                     '   PD.PCD_NUMPED, PD.PCD_ESPDOC, PD.PCD_CODEMP,'+
                                     '   RCD_DOCPDV, RCD_ESPPDV, RCD_EMPPDV   ';

  sqlPedidoPossuiItensParaEntregar = 'SELECT SQL_NO_CACHE COUNT(1) AS QTDE    '+
                                     '  FROM FATGOR FG                        '+
                                     '  JOIN FATDOR FD ON FD.FDO_NUMDOC = FG.FGO_NUMDOC'+
                                     '                AND FD.FDO_ESPDOC = FG.FGO_ESPDOC'+
                                     '                AND FD.FDO_CODEMP = FG.FGO_CODEMP'+
                                     '                AND FD.FDO_CODCLI = FG.FGO_CODCLI'+
                                     '  JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO'+
                                     '                AND ED.FDO_ENTRET = "E"         '+
                                     ' WHERE FG.FGO_NUMDOC = :NUMDOC                  '+
                                     '   AND FG.FGO_ESPDOC = :ESPDOC                  '+
                                     '   AND FG.FGO_CODEMP = :CODEMP                  ';

  sqlPedidoPelaNotaFiscal          = 'SELECT SQL_NO_CACHE FGO_NUMDOC, FGO_ESPDOC,'+
                                     '  FGO_CODEMP                            '+
                                     '  FROM FATGOR                           '+
                                     '  WHERE FGO_NUMFAT = :NUMDOC            '+
                                     '    AND FGO_TIPFAT = :ESPDOC            '+
                                     '    AND FGO_EMPFAT = :CODEMP            ';

  sqlDeleteMovOcoCRM              = 'DELETE FROM MOVOCO                       '+
                                    ' WHERE OCO_CODOCO = :CODOCO              '+
                                    '   AND OCO_CODEMP = :CODEMP              ';

  sqlUpdateMovOcoCrm              = 'UPDATE MOVOCO SET OCO_ALTFRM = :ALTFRM   '+
                                    ' WHERE OCO_CODOCO = :CODOCO              '+
                                    '   AND OCO_CODEMP = :CODEMP              ';

  sqlBackupMovOcoCRM              = 'SELECT * FROM MOVOCO                     '+
                                    ' WHERE OCO_NUMDOC = :NUMDOC              '+
                                    '   AND OCO_ESPDOC = :ESPDOC              '+
                                    '   AND OCO_CODEMP = :CODEMP              ';

  sqlBackupHisOcoCRM              = 'SELECT * FROM HISOCO                     '+
                                    ' WHERE HIS_CODOCO = :CODOCO              '+
                                    '   AND HIS_CODEMP = :CODEMP              ';

Type
  TDocumentoCRM = record
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodCli: String;
  end;

  TDadosOcorrencia = record
    CodOco: String;
    CodEmp: String;
    CodCli: String;
    Tip_FC: String;
  end;

  TAtuOcoCrm = class(TComponent, IAtuOcoCrm)
  private
    FLoteOcorrencia : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    FAutInc: String;
    FCodOco: String;
    FDtaInc: TDateTime;
    FHorInc: TDateTime;
    FDtaAge: TDateTime;
    FHorAge: TDateTime;
    FDtaCon: TDateTime;
    FHorCon: TDateTime;
    FOpeHis: String; // Operador que fez a ocorrencia
    FCodOpe: String; // Operador de destino da ocorrencia
    FDescri: String;
    FInfAdc: String;
    FDadosOcorrenciaInterna: TDadosOcorrencia;

    //informacoes usadas pelo faturamento
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FCodCli: String;
    FCodPro: String;
    FNumOrc: String;
    FEspOrc: String;
    FEmpFat: String;
    FAcaFat: TAcaoFatCRM;
    FAcaTrg: TTriggerCRMItem;
    FNumRom: String;
    FCodMot: String;
    FCodTra: String;
    FDHBaix: String;
    FNomRec: String;
    FCpfCli: String;
    FParcel: String;
    FCodFaz: String;

    //informacoes usadas pela devolucao de produtos
    FNumDev: String;
    FSeqGer: String;
    FGerCol: String; //Gerar Coleta
    FcdsDev: {$IFDEF LINUX} TClientDataSet {$ELSE } TUniClientDataSet {$ENDIF LINUX};

    //informacoes impressoes de etiquetas de clientes
    FCliVen: String;
    FCliPriVen : String; //Cliente que ja foi gerada uma ocorrencia e nao pode ser repitido.
    ArrCliImpEti: array of string;
    FCodToc: String;
    FCodCoc: String;

    qryHisOco: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    qryAutDev: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};

    //Parametros internos da procedure pInsereOcorrenciaEmergencial
    FArrayOperadores: {$IFDEF LINUX} TStringArray {$ELSE } Array Of String {$ENDIF LINUX};
    FOcorrencia,
    FEmpresa: String;
    FCodSit : String;
    FTip_Fc: String;
    FCodLad: String;
    FCodAca: String;
    FPrevis: String;
    FProtoc: String;
    FCodGoc: String;
    FDesGoc: String;
    FDesCoc: String;
    FDesToc: String;
    FNomCli: String;
    FDesSit: String;
    FNomOpe_Ori,
    FNomOpe_Des: String;
    FCodCliAnt: String;
    FSeqLag: String;
    FArqDev: String;
    FBlnEnvUsu: Boolean;
    FBlnEnvCli: Boolean;
    FEmailDesci: String;
    FEmailCli: String;
    FEmailUsu: String;
    FFoneCli: String;
    FGerandoNovoPedido: Boolean;

    FMensagemCancelamento: String;
    FDocumentosCancelamento: String;

    FReabreOcorrencia: Boolean;

    FResultadoNovaOcorrencia: Boolean;
    FResultadoHistoricoOcorrencia: Boolean;

    blnOrcamentoTransformadoEmPedido: Boolean;
    FBlnMsgMultiplosDestinatarios: Boolean;
    FstrOperadoresDestino: String;
    FBlnAtualizarCliente: Boolean;
    FblnImpSfa: Boolean;
    FblnRecarregarOcoGravarMsg :Boolean;
    FNomForm: String;
    FMotFinOco: String;
    FDesMotFin: String;
    FblnCriarAgendamento: Boolean;
    FEmpOri: String;
    FBlnVendaDesmembrada: Boolean;
    FblnAdGarantia: Boolean;
    FblnEmerge: Boolean;
    FAssunt: String;
    FCodTea: String;
    FDesTea: String;
    FblnPDGeradoDesmembramento: Boolean;
    FblnAgrPed: Boolean;

    FFulFillment : Boolean;
    FBlnDocHer: Boolean;
    FblnFinalizarOcoParcial: Boolean;
    FFinalizaOcorrenciaPdOriginal: Boolean;

    FCodIte,
    FDesIte: String;
    FQtdIte: Double;
    FGravarOcorrenciasEmLote: Boolean;

    function fOperadorAutomatico(const ACodOpe : String) : Boolean;
    function fExisteOrcamentoHisOcoCrm(strNumDoc, strEspDoc, strCodCli, strCodEmp: String): Boolean;

    function fRetornaCodigoOcorrencia(strNumDoc,strEspDoc,strCodCli,strCodEmp,
      strNumRom: String; strNumOrc: String = ''; strEspOrc: String = ''; strParcel: String = '';
      strCodToc: String = ''): String;

    function fRetornaCodigoOcorrenciaInterna(strNumDoc,strEspDoc,strCodCli,strCodEmp,
      strNumRom: String; strNumOrc: String = ''; strEspOrc: String = ''; strParcel: String = '';
      strCodToc: String = ''): String;


    procedure pProcessaPedidoAgReqCompra;
    procedure pProcessaRequisicaoCompraGerada;
    procedure pProcessaRequisicaoCompraNegada;
    procedure pProcessaRequisicaoCompraDesvinculada;
    procedure pProcessaPedidoAgCompra;
    procedure pProcessaCompraEfetuada;
    procedure pProcessaPedidoAgPDTransferencia;
    procedure pProcessaPDTransferenciaGerado;
    procedure pProcessaPedidoAgTransferencia;
    procedure pProcessaPDTransferenciaFaturado;
    procedure pProcessaPDTransferenciaBaixado;
    procedure pProcessaPedidoAgEntrega;
    procedure pProcessaMovimentacaoPreNota;
    procedure pProcessaPedidoAgEntrada;
    procedure pProcessaEntradaMercadoria;
    procedure pProcessaPedidoAgConferencia;
    procedure pProcessaRegistroOcorrenciaStatus;
    procedure pProcessaPedidoAgEnderecamento;
    procedure pProcessaEnderecamentoFinalizado;
    procedure pProcessaFatOrcamentoPedido;
    procedure pProcessaFatVendaOrcamentoPedido;
    procedure pProcessaFatOrcamentoPedidoFaturado;
    procedure pProcessaOrcamentoPedidoFaturado(const blnClienteAlterado: Boolean);
    procedure pProcessaTransfOrEmPdFaturado(const blnClienteAlterado: Boolean);
    procedure pProcessaFatOrcamentoPedidoEnderecado;
    procedure pProcessaFatRomaneioInclusao;
    procedure pProcessaFatRomaneioExclusao;
    procedure pProcessaRegistroOcorrenciaRomaneio;
    procedure pProcessaFatRomaneioBaixa;
    procedure pPreencheArrCliImpEti;
    procedure pAdicionaNumeroADNoHistoricoDaOcorrencia;
    procedure pProcessaAlteracaoCliente;
    procedure pProcessaAlteracaoClientePedido;
    procedure pProcessaAlteracaoClienteOrcamento;
    procedure pProcessaBaixaPedidoNaoEntregue;
    procedure pProcessaSeparacaoImpressa;
    procedure pProcessaRegavacaoPedidoOrcamento(const strEspDocV: String);
    procedure pProcessaInclusaoOcorrenciaPedidoOrcamento;
    procedure pProcessaConfirmacaoDocumento;
    procedure pProcessaAlteracaoTemperaturaAntend;
    procedure pProcessaFaturamentoPedidoAgrupado;
    procedure pProcessaCancelamentoDocumento;
    procedure pProcessaReaberturaDocumentoFaturado;

    function fFinalizaOcorrencia : Boolean;
    function fQuantidadeClientes: Integer;
    function fExisteClienteArrCliImpEti(strCliente: String): Boolean;
    function fInserirOcorrenciaEmergencialInterna({$IFNDEF LINUX} cxProgress : TCxProgressBar{$ENDIF LINUX}):Boolean;
    procedure pProcessaFatNFExpedida;
    procedure pProcessaConferenciaPedido;
    procedure pProcessaDevolucao;
    procedure pProcessaLiberacaoPedido;
    procedure pEnviarMensagemDestinatatio(const strOpeDest, strTituloMensagem, strMensagem: String);

    function fFinalizaOcorrenciaNaBaixaDoRomaneio: Boolean;
    function fOcorrenciaFinalizada(const ACodOco: String): Boolean;
    function fCancelamentoVendaComPedido(const ACodOco: String): Boolean;
    function fRetornaCodSit(const blnInclusao: Boolean; const strEspDocParam: String = ''; const strEspOrcParam: String = ''): String;
    procedure pExecutarAposProcessamentoOco;
    procedure pPreencheOcorrenciaOrcamento;
    procedure pPreencheOcorrenciaPedido;
    procedure pCriaAgendamentoOcorrencia;
    procedure pAtlzAgendamentoOcorrencia(const strAutInc: String);
    procedure pProcessaRetAgendamentoOco;
    procedure pAtualizarCategoriaCRMProspecto;
    procedure pGravarLogAlteraCategoria(Const strAutInc, strStaPro, strCatAnt, strCatAtu: String);

    function fRetornaDocOrig(strOcoEmpDoc, strOcoNumDoc, strOcoEspDoc: String): TDocumentoCRM;
    function fRetornaDocOrigMovDet(strOcoEmpDoc, strOcoNumDoc, strOcoEspDoc: String): TDocumentoCRM;
    function fRetornaDocOrigFatGor(strOcoEmpDoc, strOcoNumDoc, strOcoEspDoc: String): TDocumentoCRM;
    function fRetornaCodTocTipDoc(aStrEspDoc: String): String;
    function fRetornaCodOcorrenciaFinalizacao: String;
    function fPedidoGeradoAPartirPedido: Boolean;

    function getDtaAge: TDateTime;
    function getHorAge: TDateTime;
    procedure setDtaAge(const Value: TDateTime);
    procedure setHorAge(const Value: TDateTime);
    function getEmpFat: String;
    procedure setEmpFat(const Value: String);
    function GetCodSit: String;
    procedure SetCodSit(const Value: String);
    procedure SetTip_Fc(const Value: String);
    function GetTip_Fc: String;
    procedure SetCodLad(const Value: String);
    function GetCodLad: String;
    function getDocumentosCancelamento: String;
    procedure setDocumentosCancelamento(const Value: String);
    function getReabreOcorrencia: Boolean;
    procedure setReabreOcorrencia(const Value: Boolean);
    function getPrevis: String;
    procedure SetPrevis(const Value: String);
    function getProtocolo: String;
    procedure SetProtocolo(const Value: String);
    function getNomOpeDes: String;
    function getNomOpeOri: String;
    procedure SetOpeDes(const Value: String);
    procedure SetOpeOri(const Value: String);
    function getCodGoc: String;
    function getDesCoc: String;
    function getDesGoc: String;
    function getDesToc: String;
    procedure SetCodGoc(const Value: String);
    procedure SetDesCoc(const Value: String);
    procedure SetDesGoc(const Value: String);
    procedure SetDesToc(const Value: String);
    function getDesSit: String;
    procedure SetDesSit(const Value: String);

    function fEnviarMensagemOperador(Const strCodOpe: String): Boolean;
    function getCliAnt: String;
    procedure SetCliAnt(const Value: String);
    function getBlnMltOpe: Boolean;
    procedure SetBlnMltOpe(const Value: Boolean);
    function getStrMltOpe: String;
    procedure SetStrmltOpe(const Value: String);
    function getAutInc: String;
    procedure setAutInc(const Value: String);
    function getSeqLag: String;
    procedure SetSeqLag(const Value: String);
    function getArqDev: String;
    procedure SetArqDev(const Value: String);
    function getEnvCli: Boolean;
    function getEnvUsu: Boolean;
    procedure SetEnvCli(const Value: Boolean);
    procedure SetEnvUsu(const Value: Boolean);
    function getMailDe: String;
    procedure SetMailDe(const Value: String);
    function getMailCli: String;
    function getMailUsu: String;
    procedure SetMailCli(const Value: String);
    procedure SetMailUsu(const Value: String);
    function getNomCli: String;
    procedure SetNomCli(const Value: String);
    function getblnImpSfa: Boolean;
    procedure SetblnImpSfa(const Value: Boolean);
    procedure SetNomFrm(const Value: String);
    function getNomFrm: String;
    function getEmpOri: String;
    procedure SetEmpOri(const Value: String);
    function getblnAdeGar: Boolean;
    procedure SetblnAdeGar(const Value: Boolean);
    function GetblnEmerge: Boolean;
    procedure SetblnEmerge(const Value: Boolean);
    function GetAssunt: String;
    procedure SetAssunt(const Value: String);
    function GetCodTea: String;
    function GetDesTea: String;
    procedure SetCodTea(const Value: String);
    procedure SetDesTea(const Value: String);
    function GetblnPd_Dsm: Boolean;
    procedure SetblnPd_Dsm(const Value: Boolean);
    function GetblnAgrp: Boolean;
    procedure SetblnAgrp(const Value: Boolean);
    function GetblnDocHer: Boolean;
    procedure SetblnDocHer(const Value: Boolean);
    function GetCodFaz: String;
    procedure SetCodFaz(const Value: String);
    function GetBlnFinParc: Boolean;
    procedure SetBlnFinParc(const Value: Boolean);
    function fRetEmpCfg: String;
    function fCarregaCodToc(strCodEmpDoc: String): Boolean;
    class function fEmpresaUsaCRM(strCodEmpDoc: String): Boolean;
    procedure pIncluirOcorrenciaGarantia;
    function getCodPro: String;
    procedure SetCodPro(const Value: String);
    function getFoneCli: String;
    procedure SetFoneCli(const Value: String);
  protected
    function getCodOco: String;
    function getDtaInc: TDateTime;
    function getHorInc: TDateTime;
    function getDtaCon: TDateTime;
    function getHorCon: TDateTime;
    function getOpeHis: String;
    function getCodOpe: String;
    function getDescri: String;
    function getInfAdc: String;

    //informacoes usadas pelo faturamento
    function getNumDoc: String;
    function getEspDoc: String;
    function getCodEmp: String;
    function getCodCli: String;
    function getNumOrc: String;
    function getEspOrc: String;
    function getAcaFat: TAcaoFatCRM;
    function getNumRom: String;
    function getCodMot: String;
    function getCodTra: String;
    function getDHBaix: String;
    function getNomRec: String;
    function getCpfCli: String;

    //informacoes usadas pela devolucao de produtos
    function getNumDev: String;
    function getGerCol: String;
    function getSeqGer: String;
    function getCdsDev: {$IFDEF LINUX} TClientDataSet {$ELSE } TUniClientDataSet {$ENDIF LINUX};

    //informacoes impressoes de etiquetas de clientes
    function getCliVen: String;
    function getCodToc: String;
    function getCodCoc: String;
    function getCliPriVen: String;
    function getCodAca: String;
    function getMensagemCancelamento: String;


    procedure setCodOco(const Value: String);
    procedure setDtaInc(const Value: TDateTime);
    procedure setHorInc(const Value: TDateTime);
    procedure setDtaCon(const Value: TDateTime);
    procedure setHorCon(const Value: TDateTime);
    procedure setOpeHis(const Value: String);
    procedure setCodOpe(const Value: String);
    procedure setDescri(const Value: String);
    procedure setInfAdc(const Value: String);

    //informacoes usadas pelo faturamento
    procedure setNumDoc(const Value: String);
    procedure setEspDoc(const Value: String);
    procedure setCodEmp(const Value: String);
    procedure setCodCli(const Value: String);
    procedure setNumOrc(const Value: String);
    procedure setEspOrc(const Value: String);
    procedure setAcaFat(const Value: TAcaoFatCRM);
    procedure setNumRom(const Value: String);
    procedure setCodMot(const Value: String);
    procedure setCodTra(const Value: String);
    procedure setDHBaix(const Value: String);
    procedure setNomRec(const Value: String);
    procedure setCpfCli(const Value: String);

    //informacoes usadas pela devolucao de produtos
    procedure setNumDev(const Value: String);
    procedure setGerCol(const Value: String);
    procedure setSeqGer(const Value: String);
    procedure setCdsDev(const Value: {$IFDEF LINUX} TClientDataSet {$ELSE } TUniClientDataSet {$ENDIF LINUX});

    //informacoes impressoes de etiquetas de clientes
    procedure setCliVen(const Value: String);
    procedure setCodToc(const Value: String);
    procedure setCodCoc(const Value: String);
    procedure setCliPriVen(const Value: String);
    procedure setCodAca(const Value: String);

    function fObtemDadosPedidoOrcamento(Const aStrCodEmp, aStrEspDoc, aStrNumDoc: String): Boolean;
    function fRetornaSQLOcorrencia(Const strTip_Fc: String = 'C'): String;
    function fRetornaDescriHeranca: String;
    function fVerificaConfigTipoOcorrencia: Boolean;
    function fEncerrarOcorrenciaGarantia(pstrNumDoc, pstrEspDoc, pstrCodCli, pstrCodEmp: String; pAcaoFatCRM: TAcaoFatCRM): Boolean;
    function fRetornaCodigoOcorrenciaGarantiaAD(pstrNumDoc, pstrEspDoc, pstrCodCli, pstrCodEmp: String): String;
    function fSQLBindParameters(qryDados: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX}): String;
  public

    Constructor Create(AOwner: TComponent); reintroduce; overload;
    Destructor Destroy; override;

    class procedure pAtualizaOcorrenciaFinanceiro(strNumDup, strEspDoc,
                      strCodEmp, strCodCli, strParcel, strCodOpe, strCpfCli: String;
                      finAcaFat: TAcaoFatCRM; blnEncerrar: Boolean = False; blnReabre: Boolean = False;
                      blnExcluir: Boolean = False;
                      strMsgFinaliza: String = '';
                      fltVlrBx: Double = 0);

    procedure pInsereNovaOcorrencia; overload;
    procedure pInsereNovaOcorrencia(const blnOrigemRecorrencia: Boolean); overload;
    procedure pInsereHistoricoOcorrencia;
    function  fExisteOcorrenciaEmAbertoParaCliente: Boolean;
    function fRetornarEmpresaMovimentacaoOcorrencia : String;
    procedure pAtualizaOcorrencia(ACodCli: String = '');
    procedure pAtualizaOcorrenciaInterna(ACodCli: String);
    procedure pProcessaFatOcorrenciasCRM;
    procedure pInsereAutorizacaoDevolucao;
    procedure pInsereAutorizacaoDevolucaoProdutos;
    procedure pInserirOcorrenciaEmergencial(Var ArrayOperadores:
      {$IFDEF LINUX} TStringArray {$ELSE } Array Of String {$ENDIF LINUX};
      strOcorrencia, strEmpresa: String);
    procedure pInsereClientesImpressaoEtiquetas;
    function  fDadosConsumidor: String;
    procedure pProcessaFinanceiro(blnEncerrar: Boolean; blnExcluir: Boolean; strMsgFinaliza: String = '';
      fltVlrBx: Double = 0);

    function fGravouNovaOcorrencia: Boolean;
    function fGravouHistoricoOcorrencia: Boolean;
    procedure pFinalizaOcorrencia(const strObsFinaliza: String; strOpeFin: String = ''; ACodCli: String = '');
    function fObtemDadosDocumentoOcorrencia(Const aStrCodEmp: String;
      Const aStrEspDoc: String; Const aStrNumDoc: String): Boolean;
    procedure pCarregaOcorrencia(const strTip_Fc: String; const strCodOco: String; const strCodEmp: String);
    procedure pCarregaOcorrenciaCliente(const strCodEmp, strEspDoc, strNumDoc, strCodCli: String);
    procedure pGravarMensagemOperadorOcorrencia(Const tpAcao: TTipoOperacaoOcorrencia; const strCodOco: String; const strCodEmp: String; const strTip_Fc: String);
    procedure pReabreOcorrencia(const strCodOco, strCodEmp, strDescricao, strCodCoc, strCodToc: string; strCodOpe: String = '');
    procedure pLimpar;

    property strAutInc: String Read getAutInc Write setAutInc;
    property strCodOco: String Read getCodOco Write setCodOco;
    property strDtaInc: TDateTime Read getDtaInc Write setDtaInc;
    property strHorInc: TDateTime Read getHorInc Write setHorInc;
    property strDtaAge: TDateTime Read getDtaAge Write setDtaAge;
    property strHorAge: TDateTime Read getHorAge Write setHorAge;
    property strDtaCon: TDateTime Read getDtaCon Write setDtaCon;
    property strHorCon: TDateTime Read getHorCon Write setHorCon;
    property strOpeHis: String Read getOpeHis Write setOpeHis;
    property strCodOpe: String Read getCodOpe Write setCodOpe;
    property strDescri: String Read getDescri Write setDescri;
    property strInfAdc: String Read getInfAdc Write setInfAdc;
    property strCodSit: String Read GetCodSit Write SetCodSit;
    property strTip_Fc: String Read GetTip_Fc Write SetTip_Fc;
    property strCodLad: String Read GetCodLad Write SetCodLad;
    property strCodFaz: String read GetCodFaz write SetCodFaz;

    //informacoes usadas pelo faturamento
    property strNumDoc: String read getNumDoc write SetNumDoc;
    property strEspDoc: String read getEspDoc write SetEspDoc;
    property strCodEmp: String read getCodEmp write SetCodEmp;
    property strCodCli: String read getCodCli write SetCodCli;
    property strCodPro: String read getCodPro write SetCodPro;
    property strNomCli: String read getNomCli write SetNomCli;
    property strNumOrc: String read getNumOrc write SetNumOrc;
    property strEspOrc: String read getEspOrc write SetEspOrc;
    property strEmpFat: String read getEmpFat write setEmpFat;
    property afcAcaFat: TAcaoFatCRM read getAcaFat write setAcaFat;
    property strNumRom: String read getNumRom write setNumRom;
    property strCodMot: String read getCodMot write setCodMot;
    property strCodTra: String read getCodTra write setCodTra;
    property strDHBaix: String read getDHBaix write setDHBaix;
    property strNomRec: String read getNomRec write setNomRec;
    property strCpfCli: String read getCpfCli write setCpfCli;

    //informacoes usadas pela devolucao de produtos
    property strNumDev: String read getNumDev write setNumDev;
    property strGerCol: String read getGerCol write setGerCol;
    property strSeqGer: String read getSeqGer write setSeqGer;
    property cdsCdsDev: {$IFDEF LINUX} TClientDataSet {$ELSE } TUniClientDataSet {$ENDIF LINUX} read getCdsDev write setCdsDev;

    //informacoes impressoes de etiquetas de clientes
    property strCliVen: String read getCliVen write setCliVen;
    property strCodToc: String read getCodToc write setCodToc;
    property strCodCoc: String read getCodCoc write setCodCoc;
    property strCliPriVen: String read getCliPriVen write setCliPriVen;

    // informacoes usadas pelo financeiro
    property strParcel: String read FParcel write FParcel;

    property strCodAca: String read getCodAca write setCodAca;
    property strMensagemCancelamento: String read getMensagemCancelamento;
    property strDocumentosCancelamento: String read getDocumentosCancelamento write setDocumentosCancelamento;

    property blnReabreOcorrencia: Boolean read getReabreOcorrencia write setReabreOcorrencia;
    property strPrevis: String read getPrevis write SetPrevis;
    property strProtocolo: String read getProtocolo write SetProtocolo;
    property strNomOpe_Ori: String read getNomOpeOri write SetOpeOri;
    property strNomOpe_Des: String read getNomOpeDes write SetOpeDes;
    property strCodGoc: String read getCodGoc write SetCodGoc;
    property strDesGoc: String read getDesGoc write SetDesGoc;
    property strDesCoc: String read getDesCoc write SetDesCoc;
    property strDesToc: String read getDesToc write SetDesToc;
    property strDesSit: String read getDesSit write SetDesSit;
    property strCodCliAnt: String read getCliAnt write SetCliAnt;
    property BlnMsgMultiplosDestinatarios: Boolean read  getBlnMltOpe write SetBlnMltOpe;
    property strOperadoresDestino: String read getStrMltOpe write SetStrmltOpe;
    property strSeqLag: String read getSeqLag write SetSeqLag;
    property strArqDev: String read getArqDev write SetArqDev;
    property blnEnvCli: Boolean read getEnvCli write SetEnvCli;
    property blnEnvUsu: Boolean read getEnvUsu write SetEnvUsu;
    property strEmailDesci: String read getMailDe write SetMailDe;
    property strEmailCli : String read getMailCli write SetMailCli;
    property strEmailUsu : String read getMailUsu write SetMailUsu;
    property strFoneCli : String read getFoneCli write SetFoneCli;
    property blnImpSfa: Boolean read getblnImpSfa write SetblnImpSfa;
    property strNomFrm: String read getNomFrm write SetNomFrm;
    property strEmpOri: String read getEmpOri write SetEmpOri;
    property blnAdGarantia: Boolean read getblnAdeGar write SetblnAdeGar;
    property blnEmerge: Boolean read GetblnEmerge write SetblnEmerge;
    property strAssunto: String read GetAssunt write SetAssunt;
    property strCodTea: String read GetCodTea write SetCodTea;
    property strDesTea: String read GetDesTea write SetDesTea;
    property blnPDGeradoDesmembramento: Boolean read GetblnPd_Dsm write SetblnPd_Dsm;
    property blnAgrupamentoPedidos: Boolean read GetblnAgrp write SetblnAgrp;
    property blnDocumentoHeranca: Boolean read GetblnDocHer write SetblnDocHer;
    property blnFinalizarOcoParcial: Boolean read GetBlnFinParc write SetBlnFinParc;
    property strCodIte: String read FCodIte write FCodIte;
    property strDesIte: String read FDesIte write FDesIte;
    property dobQtdIte: Double read FQtdIte write FQtdIte;
    property blnGravarOcorrenciasEmLote : Boolean read FGravarOcorrenciasEmLote write FGravarOcorrenciasEmLote;
    property GerandoNovoPedido: Boolean read FGerandoNovoPedido write FGerandoNovoPedido;

    procedure SetFulFillment(const AFulFillment : Boolean);
    procedure SetFinalizaOcorrenciaPdOriginal(const Value: Boolean);
    procedure pGravarLoteOcorrencias(const blnValidar : Boolean);
  End;

  TUpdateOccurrenceCRM = class sealed(TInterfacedObject, IUpdateOccurrenceCRM)
  protected
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FCodCli: String;
    FEspOrc: String;
    FNumOrc: String;
    FEmpFat: String;
    FCodOpe: String;
    FDescri: String;
    FInfAdc: String;
    FAcaFat: TAcaoFatCRM;
    FAtuOcoCRM: TAtuOcoCrm;
    FblnImpSfa: Boolean;
    FstrNomFrm: String;
    FTip_Fc: String;
    FNumRom: String;
    FCodMot: String;
    FCodTra: String;

    FNomCli,
    FCodIte,
    FDesIte: String;

    FQtdIte: Double;
  protected
    constructor Create;
  public
    function NumDoc(const AValue: String): IUpdateOccurrenceCRM;
    function EspDoc(const AValue: String): IUpdateOccurrenceCRM;
    function CodEmp(const AValue: String): IUpdateOccurrenceCRM;
    function CodCli(const AValue: String): IUpdateOccurrenceCRM;
    function NumOrc(const AValue: String): IUpdateOccurrenceCRM;
    function EspOrc(const AValue: String): IUpdateOccurrenceCRM;
    function EmpFat(const AValue: String): IUpdateOccurrenceCRM;
    function CodOpe(const AValue: String): IUpdateOccurrenceCRM;
    function Descri(const AValue: String): IUpdateOccurrenceCRM;
    function InfAdc(const AValue: String): IUpdateOccurrenceCRM;
    function AcaFat(const AValue: TAcaoFatCRM): IUpdateOccurrenceCRM;
    function strNomFrm(const AValue: String): IUpdateOccurrenceCRM;
    function Tip_Fc(const AValue: String): IUpdateOccurrenceCRM;
    function NumRom(const AValue: String): IUpdateOccurrenceCRM;
    function CodMot(const AValue: String): IUpdateOccurrenceCRM;
    function CodTra(const AValue: String): IUpdateOccurrenceCRM;
    function CodIte(const AValue: String): IUpdateOccurrenceCRM;
    function DesIte(const AValue: String): IUpdateOccurrenceCRM;
    function QtdIte(const AValue: Double): IUpdateOccurrenceCRM;
    function NomCli(const AValue: String): IUpdateOccurrenceCRM;

    destructor Destroy; override;

    procedure pRun;
    function blnImpSfa(const AValue: Boolean) : IUpdateOccurrenceCRM;

    class function New: IUpdateOccurrenceCRM;
  end;

  TInvokerUpdateOcurrenceCRM = class sealed(TInterfacedObject, IInvokerUpdateOcurrenceCRM)
  protected
    FCommandList: TInterfaceList;

    constructor Create;
  public
    destructor Destroy; Override;

    procedure pAdd(ACommand: IUpdateOccurrenceCRM);
    procedure pRun;

    class function New: IInvokerUpdateOcurrenceCRM;
  end;

  TDeleteOccurrenceCRM = class sealed(TInterfacedObject, IDeleteOccurrenceCRM)
  protected
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FstrNomFrm: String;

    constructor Create;
  public
    function NumDoc(const AValue: String): IDeleteOccurrenceCRM;
    function EspDoc(const AValue: String): IDeleteOccurrenceCRM;
    function CodEmp(const AValue: String): IDeleteOccurrenceCRM;
    function NomFrm(const AValue: String): IDeleteOccurrenceCRM;

    procedure pDelete;

    class function New: IDeleteOccurrenceCRM;
  end;

  TCategoriaCrm = class(TInterfacedObject, ICategoriaCrm)
  private
    FAutInc: String;
    FCodCat: String;
    FDescri: String;

    function strAutInc(const AValue: String): ICategoriaCrm;
    function strCodCat(const AValue: String): ICategoriaCrm;
    function strDescri(const AValue: String): ICategoriaCrm;

    function GetAutInc: String;
    function GetCodCat: String;
    function GetDescri: String;

    procedure SetAutInc(const AValue: String);
    procedure SetCodCat(const AValue: String);
    procedure SetDescri(const AValue: String);
  public
    constructor Create;
    destructor Destroy; override;

    class function fNew: ICategoriaCrm;
    class function fInserirCategoriaCRM(const strDescri: String): String;
    class procedure pInserirCategoriasProspectoPadraoCRM;
    function fAtualizarCategoriaProspecto(const strCatAtu: String; strCodPro: String): Boolean;
    procedure pAtualizarCadastroProspectoPeloCompl(strCodCoc: String; strCodPro: String);

    property AutInc: String read GetAutInc write SetAutInc;
    property CodCat: String read GetCodCat write SetCodCat;
    property Descri: String read GetDescri write SetDescri;
  End;

  TLogCatProspecto = class(TInterfacedObject, ILogCatProspecto)
  private
    FAutInc: String;
    FSeqPro: String;
    FDtaAlt: TDateTime;
    FHraAlt: TDateTime;
    FOpeAlt: String;
    FCatAnt: String;
    FCatAtu: String;
    FCodMot: String;
    FStaPro: String;
    FEmpDoc: String;
    FEspDoc: String;
    FNumDoc: String;

    function strAutInc(const AValue: String): ILogCatProspecto;
    function strSeqPro(const AValue: String): ILogCatProspecto;
    function strDtaAlt(const AValue: TDateTime): ILogCatProspecto;
    function strHraAlt(const AValue: TDateTime): ILogCatProspecto;
    function strOpeAlt(const AValue: String): ILogCatProspecto;
    function strCatAnt(const AValue: String): ILogCatProspecto;
    function strCatAtu(const AValue: String): ILogCatProspecto;
    function strCodMot(const AValue: String): ILogCatProspecto;
    function strStaPro(const AValue: String): ILogCatProspecto;
    function strEmpDoc(const AValue: String): ILogCatProspecto;
    function strEspDoc(const AValue: String): ILogCatProspecto;
    function strNumDoc(const AValue: String): ILogCatProspecto;

    function GetAutInc: String;
    function GetSeqPro: String;
    function GetDtaAlt: TDateTime;
    function GetHraAlt: TDateTime;
    function GetOpeAlt: String;
    function GetCatAnt: String;
    function GetCatAtu: String;
    function GetCodMot: String;
    function GetStaPro: String;
    function GetEmpDoc: String;
    function GetEspDoc: String;
    function GetNumDoc: String;

    procedure SetAutInc(const AValue: String);
    procedure SetSeqPro(const AValue: String);
    procedure SetDtaAlt(const AValue: TDateTime);
    procedure SetHraAlt(const AValue: TDateTime);
    procedure SetOpeAlt(const AValue: String);
    procedure SetCatAnt(const AValue: String);
    procedure SetCatAtu(const AValue: String);
    procedure SetCodMot(const AValue: String);
    procedure SetStaPro(const AValue: String);
    procedure SetEmpDoc(const AValue: String);
    procedure SetEspDoc(const AValue: String);
    procedure SetNumDoc(const AValue: String);

    procedure pRemoverLogCat(const strCatRem: String);
  public
    constructor Create;
    destructor Destroy; override;

    procedure pGravaLogAlteracaoCategoria;
    procedure pRemoverLogCatOportunidade;
    procedure pRemoverLogCatVenda;
    class function fNew: ILogCatProspecto;
    
    property AutInc: String read GetAutInc write SetAutInc;
    property SeqPro: String read GetSeqPro write SetSeqPro;
    property DtaAlt: TDateTime read GetDtaAlt write SetDtaAlt;
    property HraAlt: TDateTime read GetHraAlt write SetHraAlt;
    property OpeAlt: String read GetOpeAlt write SetOpeAlt;
    property CatAnt: String read GetCatAnt write SetCatAnt;
    property CatAtu: String read GetCatAtu write SetCatAtu;
    property CodMot: String read GetCodMot write SetCodMot;
    property StaPro: String read GetStaPro write SetStaPro;
    property EmpDoc: String read GetEmpDoc write SetEmpDoc;
    property EspDoc: String read GetEspDoc write SetEspDoc;
    property NumDoc: String read GetNumDoc write SetNumDoc;
  End;

  TLogAltMovOco = class(TInterfacedObject, ILogAltMovOco)
  private
    FAutInc: String;
    FCodOco: String;
    FDescri: String;
    FNomFrm: String;
    FCodCli: String;
    FCliAnt: String;

    function GetAutInc: String;
    function GetCodOco: String;
    function GetCliAnt: String;
    function GetCodCli: String;
    function GetDescri: String;
    function GetNomFrm: String;
  public
    constructor Create;
    destructor Destroy; override;

    class function fNew: ILogAltMovOco;
    procedure pGravarLogAlteracaoCliente;

    function strCodOco(const AValue: String): ILogAltMovOco;
    function strDescri(const AValue: String): ILogAltMovOco;
    function strNomFrm(const AValue: String): ILogAltMovOco;
    function strCodCli(const AValue: String): ILogAltMovOco;
    function strCliAnt(const AValue: String): ILogAltMovOco;

    property AutInc: String read GetAutInc;
    property CodOco: String read GetCodOco;
    property Descri: String read GetDescri;
    property NomFrm: String read GetNomFrm;
    property CodCli: String read GetCodCli;
    property CliAnt: String read GetCliAnt;
  End;

implementation

uses
  {$IFNDEF LINUX}
  Forms, untFuncoesGenerica, untGravando, untProximoCodigo,
  {$ENDIF LINUX}
  SysUtils, Variants, Data.DB, System.DateUtils,
  UntMsgInterna;

{ TAtuOcoCrm }

constructor TAtuOcoCrm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGravarOcorrenciasEmLote := False;
  FLoteOcorrencia := fCriaQuery;
  pLimpar;
end;

destructor TAtuOcoCrm.Destroy;
begin
{$IFNDEF LINUX}
  FreeAndNil(FLoteOcorrencia);
{$ENDIF LINUX}
  inherited;
end;

function TAtuOcoCrm.fRetEmpCfg: String;
begin
  Result := IIF(FCodEmp <> VS_strCodEmp, FCodEmp, VS_strCodEmp);
end;

function TAtuOcoCrm.fCancelamentoVendaComPedido(const ACodOco: String): Boolean;
  var strOcoEspDoc: String;
begin
  Result := (Pos(afcDocumentoCancelado.fGetDescricao() , strDescri) > 0);
  If (Result) Then
  Begin
    strOcoEspDoc := fCampoTabela('OCO_ESPDOC', 'MOVOCO', ['OCO_CODOCO', 'OCO_CODEMP'], [ACodOco, FCodEmp]);
    Result := (Pos(strOcoEspDoc, 'PD_OR_') > 0);
  End;
end;

function TAtuOcoCrm.fDadosConsumidor: String;
var
  strDadosConsumidor: String;
  strPrefixo: String;
  strTabela: String;
begin
  strDadosConsumidor := '';
  If (Pos(FEspDoc, 'PD_OR_') > 0) Then
  Begin
    strPrefixo := 'FGO_';
    strTabela  := 'FATGOR';
  End
  Else
  If (Pos(FEspDoc, 'NF_IF_FF') > 0) Then
  Begin
    strPrefixo := 'GER_';
    strTabela  := 'MOVGER';
  End;
  If (Not fEmptyStr(strTabela)) And
     (fClienteConsumidor(fCampoTabela('CLI_NOMCLI','CADCLI',['CLI_CODCLI'],[FCodCli]))) And
     (Not fEmptyStr(fCampoTabela(strPrefixo+'NOMCON',strTabela,[strPrefixo+'NUMDOC', strPrefixo+'ESPDOC', strPrefixo+'CODEMP'],[FNumDoc, FEspDoc, FCodEmp]))) And
     (Pos(FEspDoc, 'PD_OR_NF_IF_FF') > 0) Then
  Begin
    //Nome
    strDadosConsumidor := 'Cliente : '+(fCampoTabela(strPrefixo+'NOMCON',strTabela,[strPrefixo+'NUMDOC', strPrefixo+'ESPDOC', strPrefixo+'CODEMP'],[FNumDoc, FEspDoc, FCodEmp]));
    //Endereço
    If (Not fEmptyStr(fCampoTabela(strPrefixo+'ENDCON',strTabela,[strPrefixo+'NUMDOC', strPrefixo+'ESPDOC', strPrefixo+'CODEMP'],[FNumDoc, FEspDoc, FCodEmp]))) Then
      strDadosConsumidor := strDadosConsumidor + '<<csq>>Endereço : '+(fCampoTabela(strPrefixo+'ENDCON',strTabela,[strPrefixo+'NUMDOC', strPrefixo+'ESPDOC', strPrefixo+'CODEMP'],[FNumDoc, FEspDoc, FCodEmp]));
    //Bairro
    If (Not fEmptyStr(fCampoTabela(strPrefixo+'BAICON',strTabela,[strPrefixo+'NUMDOC', strPrefixo+'ESPDOC', strPrefixo+'CODEMP'],[FNumDoc, FEspDoc, FCodEmp]))) Then
      strDadosConsumidor := strDadosConsumidor + '<<csq>>Bairro : '+(fCampoTabela(strPrefixo+'BAICON',strTabela,[strPrefixo+'NUMDOC', strPrefixo+'ESPDOC', strPrefixo+'CODEMP'],[FNumDoc, FEspDoc, FCodEmp]));        //Cidade
    //Cidade
    If (Not fEmptyStr(fCampoTabela(strPrefixo+'CIDCON',strTabela,[strPrefixo+'NUMDOC', strPrefixo+'ESPDOC', strPrefixo+'CODEMP'],[FNumDoc, FEspDoc, FCodEmp]))) Then
    Begin
      strDadosConsumidor := strDadosConsumidor + '<<csq>>Cidade : '+
                            fCampoTabela('CID_NOMCID','CADCID',['CID_CODCID'],
                                         [(fCampoTabela(strPrefixo+'CIDCON',strTabela,[strPrefixo+'NUMDOC', strPrefixo+'ESPDOC', strPrefixo+'CODEMP'],[FNumDoc, FEspDoc, FCodEmp]))]
                                        );
      //UF
      If (Not fEmptyStr(fCampoTabela('CID_ESTADO','CADCID',['CID_CODCID'],[(fCampoTabela(strPrefixo+'CIDCON',strTabela,[strPrefixo+'NUMDOC', strPrefixo+'ESPDOC', strPrefixo+'CODEMP'],[FNumDoc, FEspDoc, FCodEmp]))]))) Then
        strDadosConsumidor := strDadosConsumidor + ' - '+(fCampoTabela('CID_ESTADO','CADCID',['CID_CODCID'],[(fCampoTabela(strPrefixo+'CIDCON',strTabela,[strPrefixo+'NUMDOC', strPrefixo+'ESPDOC', strPrefixo+'CODEMP'],[FNumDoc, FEspDoc, FCodEmp]))]));
    End;
    //CPF/CNPJ
    If (Not fEmptyStr(fCampoTabela(strPrefixo+'CGCCON',strTabela,[strPrefixo+'NUMDOC', strPrefixo+'ESPDOC', strPrefixo+'CODEMP'],[FNumDoc, FEspDoc, FCodEmp]))) Then
    Begin
      If (fCampoTabela(strPrefixo+'CGCCPF',strTabela,[strPrefixo+'NUMDOC', strPrefixo+'ESPDOC', strPrefixo+'CODEMP'],[FNumDoc, FEspDoc, FCodEmp]) = '1') Then
        strDadosConsumidor := strDadosConsumidor + '<<csq>>CNPJ : '
      Else
        strDadosConsumidor := strDadosConsumidor + '<<csq>>CPF : ';

      strDadosConsumidor := strDadosConsumidor + fFormataCpfCgc( (fCampoTabela(strPrefixo+'CGCCON',strTabela,[strPrefixo+'NUMDOC', strPrefixo+'ESPDOC', strPrefixo+'CODEMP'],[FNumDoc, FEspDoc, FCodEmp])) {$IFNDEF LINUX}, fSetaPais{$ENDIF LINUX} );
    End;
    strDadosConsumidor := strDadosConsumidor + '<<csq>>';
  End;
  Result := strDadosConsumidor;
end;

function TAtuOcoCrm.fExisteClienteArrCliImpEti(strCliente: String): Boolean;
var
  intCont: Integer;
begin
  Result := False;
  for intCont := 0 to Length(ArrCliImpEti) - 1 do
  begin
    if ArrCliImpEti[intCont] = strCliente then
      Result := True;
  end;  
end;

function TAtuOcoCrm.fExisteOcorrenciaEmAbertoParaCliente: Boolean;
var
  qryConsulta: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  try
    qryConsulta := fCriaQuery();
    with qryConsulta, sql do
    begin
      Close;
      Clear;
      Add('SELECT 1 FROM MOVOCO MOV');
      Add('JOIN CADTOC TOC ON TOC.TOC_CODTOC = MOV.OCO_CODTOC');
      Add('WHERE TRUE');
      Add('AND TOC.TOC_CODTOC = :CODTOC');
      Add('AND MOV.OCO_CODCLI = :CODCLI');
      Add('AND MOV.OCO_DTACON IS NULL');
      ParamByName('CODTOC').AsString   := strCodToc;
      ParamByName('CODCLI').AsString   := strCodCli;
      Open;
      Result := Not isEmpty;
    end;
  finally
{$IFNDEF LINUX}
    FreeAndNil(qryConsulta);
{$ENDIF LINUX}
  end;
end;

function TAtuOcoCrm.fExisteOrcamentoHisOcoCrm(strNumDoc, strEspDoc, strCodCli,
  strCodEmp: String): Boolean;
var
  qryConsulta: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  try
    qryConsulta := fCriaQuery();
    with qryConsulta do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT SQL_NO_CACHE OCO_NUMDOC ');
      SQL.Add('  FROM MOVOCO ');
      SQL.Add(' INNER JOIN HISOCO ON HIS_CODOCO = OCO_CODOCO ');
      SQL.Add(' WHERE HIS_NUMDOC = :NUMDOC ');
      SQL.Add('   AND HIS_ESPDOC = :ESPDOC ');
      SQL.Add('   AND HIS_CODEMP = :CODEMP ');
      SQL.Add('   AND OCO_CODCLI = :CODCLI ');
      SQL.Add('   AND OCO_TIP_FC = :TIP_FC ');
      SQL.Add('   AND COALESCE(OCO_DTACON,0) <= 0      ');
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('TIP_FC').AsString := IIF(fEmptyStr(strTip_Fc), 'C', strTip_Fc);
      Open;
      Result := FieldByName('OCO_NUMDOC').AsString <> '';
    end;
  finally
{$IFNDEF LINUX}
    FreeAndNil(qryConsulta);
{$ENDIF LINUX}
  end;
end;

function TAtuOcoCrm.fFinalizaOcorrencia: Boolean;
begin

  Result := True;

  If (Not (FAcaFat = afcPedidoFaturadoParcial)) And (Not fFinalizaOcorrenciaNaBaixaDoRomaneio()) Then
    Exit;

  If (FAcaFat = afcPedidoFaturadoParcial) And FblnFinalizarOcoParcial Then
    Exit(True);

  If (FFulFillment) Then
    Exit;

  Result := False;

end;

function TAtuOcoCrm.fFinalizaOcorrenciaNaBaixaDoRomaneio: Boolean;
var
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  Result := fCfgSis('FINROM', varBoolean) And (FAcaFat = afcPedidoFaturado);

  If Result And FFinalizaOcorrenciaPdOriginal Then
    Result := False;

  If Result Then
  Begin
    qryAux := fCriaQuery();

    Try
      qryAux.SQL.Add(sqlPedidoPossuiItensParaEntregar);
      qryAux.ParamByName('NUMDOC').AsString := FNumOrc;
      qryAux.ParamByName('ESPDOC').AsString := FEspOrc;
      qryAux.ParamByName('CODEMP').AsString := FCodEmp;
      qryAux.Open();

      Result := qryAux.FieldByName('QTDE').AsInteger > 0;
    Finally
      qryAux.Close();
{$IFNDEF LINUX}
      FreeAndNil(qryAux);
{$ENDIF LINUX}
    End;
  End;
end;

function TAtuOcoCrm.fQuantidadeClientes: Integer;
var
  intCont: Integer;
  strCliente: String;
  strLinha: String;
begin
  intCont  := 0;
  strLinha := FCliVen;
  while Length(strLinha) > 0 do
  begin
    strCliente := Copy(strLinha,1,Pos('_',strLinha) - 1);
    strLinha   := Copy(strLinha,Pos('_',strLinha) + 1, Length(strLinha));
    if not fEmptyStr(strCliente) then
      intCont := intCont + 1;
  end;
  Result := intCont;  
end;

function TAtuOcoCrm.getCdsDev: {$IFDEF LINUX} TClientDataSet {$ELSE } TUniClientDataSet {$ENDIF LINUX};
begin
  Result := FCdsDev;
end;

function TAtuOcoCrm.getCliAnt: String;
begin
  Result := FCodCliAnt;
end;

function TAtuOcoCrm.getCliPriVen: String;
begin
  Result := FCliPriVen;
end;

function TAtuOcoCrm.getCliVen: String;
begin
  Result := FCliVen;
end;

function TAtuOcoCrm.getCodAca: String;
begin
  Result := FCodAca;
end;

function TAtuOcoCrm.getCodCli: String;
begin
  Result := FCodCli;
end;

function TAtuOcoCrm.getCodCoc: String;
begin
  Result := FCodCoc;
end;

function TAtuOcoCrm.getCodEmp: String;
begin
  Result := FCodEmp;
end;

function TAtuOcoCrm.GetCodFaz: String;
begin
  Result := FCodFaz;
end;

function TAtuOcoCrm.getCodGoc: String;
begin
  Result := FCodGoc;
end;

function TAtuOcoCrm.GetCodLad: String;
begin
  Result := FCodLad;
end;

function TAtuOcoCrm.getCodMot: String;
begin
  Result := FCodMot;
end;

function TAtuOcoCrm.getCodOco: String;
begin
  Result := FCodOco;
end;

function TAtuOcoCrm.getCodOpe: String;
begin
  Result := FCodOpe;
end;

function TAtuOcoCrm.getCodPro: String;
begin
  Result := FCodPro;
end;

function TAtuOcoCrm.GetCodSit: String;
begin
  Result := FCodSit;
end;

function TAtuOcoCrm.GetCodTea: String;
begin
  Result := FCodTea;
end;

function TAtuOcoCrm.getCodToc: String;
begin
  Result := FCodToc;
end;

function TAtuOcoCrm.getCodTra: String;
begin
  Result := FCodTra;
end;

function TAtuOcoCrm.getCpfCli: String;
begin
  Result := FCpfCli;
end;

function TAtuOcoCrm.getDesCoc: String;
begin
  Result := FDesCoc;
end;

function TAtuOcoCrm.getDescri: String;
begin
  Result := FDescri;
end;

function TAtuOcoCrm.getDesGoc: String;
begin
  Result := FDesGoc;
end;

function TAtuOcoCrm.getDesSit: String;
begin
  Result := FDesSit;
end;

function TAtuOcoCrm.GetDesTea: String;
begin
  Result := FDesTea;
end;

function TAtuOcoCrm.getDesToc: String;
begin
  Result := FDesToc;
end;

function TAtuOcoCrm.getInfAdc: String;
begin
  Result := FInfAdc;
end;

function TAtuOcoCrm.getMailCli: String;
begin
  Result := FEmailCli;
end;

function TAtuOcoCrm.getMailDe: String;
begin
  Result := FEmailDesci;
end;

function TAtuOcoCrm.getMailUsu: String;
begin
  Result := FEmailUsu;
end;

function TAtuOcoCrm.getMensagemCancelamento: String;
begin
  Result := FMensagemCancelamento;
end;

function TAtuOcoCrm.getDHBaix: String;
begin
  Result := FDHBaix;
end;

function TAtuOcoCrm.getDocumentosCancelamento: String;
begin
  Result := FDocumentosCancelamento;
end;

function TAtuOcoCrm.getNomCli: String;
begin
  Result := FNomCli;
end;

function TAtuOcoCrm.getNomFrm: String;
begin
  Result := FNomForm;
end;

function TAtuOcoCrm.getNomOpeDes: String;
begin
  Result := FNomOpe_Des;
end;

function TAtuOcoCrm.getNomOpeOri: String;
begin
  Result := FNomOpe_Ori;
end;

function TAtuOcoCrm.getNomRec: String;
begin
  Result := FNomRec;
end;

function TAtuOcoCrm.getDtaAge: TDateTime;
begin
  Result := FDtaAge;
end;

function TAtuOcoCrm.getDtaCon: TDateTime;
begin
  Result := FDtaCon;
end;

function TAtuOcoCrm.getDtaInc: TDateTime;
begin
  Result := FDtaInc;
end;

function TAtuOcoCrm.getEmpFat: String;
begin
  Result := FEmpFat;
end;

function TAtuOcoCrm.getEmpOri: String;
begin
  Result := FEmpOri;
end;

function TAtuOcoCrm.getEnvCli: Boolean;
begin
  Result := FBlnEnvCli;
end;

function TAtuOcoCrm.getEnvUsu: Boolean;
begin
  Result := FBlnEnvUsu;
end;

function TAtuOcoCrm.getEspDoc: String;
begin
  Result := FEspDoc;
end;

function TAtuOcoCrm.getEspOrc: String;
begin
  Result := FEspOrc;
end;

function TAtuOcoCrm.getFoneCli: String;
begin
  Result := FFoneCli;
end;

function TAtuOcoCrm.getAcaFat: TAcaoFatCRM;
begin
  Result := FAcaFat;
end;

function TAtuOcoCrm.getArqDev: String;
begin
  Result := FArqDev;
end;

function TAtuOcoCrm.GetAssunt: String;
begin
  Result := FAssunt;
end;

function TAtuOcoCrm.getAutInc: String;
begin
  Result := FAutInc;
end;

function TAtuOcoCrm.getblnAdeGar: Boolean;
begin
  Result := blnAdGarantia;
end;

function TAtuOcoCrm.GetblnAgrp: Boolean;
begin
  Result := FblnAgrPed;
end;

function TAtuOcoCrm.GetblnDocHer: Boolean;
begin
  Result := FBlnDocHer;
end;

function TAtuOcoCrm.GetblnEmerge: Boolean;
begin
  Result := FblnEmerge;
end;

function TAtuOcoCrm.GetBlnFinParc: Boolean;
begin
  Result := FblnFinalizarOcoParcial;
end;

function TAtuOcoCrm.getblnImpSfa: Boolean;
begin
  Result := FblnImpSfa;
end;

function TAtuOcoCrm.getBlnMltOpe: Boolean;
begin
  Result := FBlnMsgMultiplosDestinatarios;
end;

function TAtuOcoCrm.GetblnPd_Dsm: Boolean;
begin
  Result := FblnPDGeradoDesmembramento;
end;

function TAtuOcoCrm.getHorAge: TDateTime;
begin
  Result := FHorAge;
end;

function TAtuOcoCrm.getHorCon: TDateTime;
begin
  Result := FHorCon;
end;

function TAtuOcoCrm.getHorInc: TDateTime;
begin
  Result := FHorInc;
end;

function TAtuOcoCrm.getNumDev: String;
begin
  Result := FNumDev;
end;

function TAtuOcoCrm.getGerCol: String;
begin
  Result := FGerCol;
end;

function TAtuOcoCrm.getNumDoc: String;
begin
  Result := FNumDoc;
end;

function TAtuOcoCrm.getNumOrc: String;
begin
  Result := FNumOrc;
end;

function TAtuOcoCrm.getNumRom: String;
begin
  Result := FNumRom;
end;

function TAtuOcoCrm.getOpeHis: String;
begin
  Result := FOpeHis;
end;

function TAtuOcoCrm.getPrevis: String;
begin
  Result := FPrevis;
end;

function TAtuOcoCrm.getProtocolo: String;
begin
  Result := FProtoc;
end;

function TAtuOcoCrm.getReabreOcorrencia: Boolean;
begin
  Result := FReabreOcorrencia;
end;

{function TAtuOcoCrm.getQtdIte: Double;
begin
  Result := FQtdIte;
end;}

function TAtuOcoCrm.getSeqGer: String;
begin
  Result := FSeqGer;
end;

function TAtuOcoCrm.getSeqLag: String;
begin
  Result := FSeqLag;
end;

function TAtuOcoCrm.getStrMltOpe: String;
begin
  Result := FstrOperadoresDestino;
end;

function TAtuOcoCrm.GetTip_Fc: String;
begin
  Result := FTip_Fc;
end;

procedure TAtuOcoCrm.pAdicionaNumeroADNoHistoricoDaOcorrencia;
var
  qryUpd: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  Try
    qryUpd := fCriaQuery();
    With qryUpd Do
    Begin
      //Update no historico da ocorrencia
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE HISOCO ');
      SQL.Add('    SET HIS_DESCRI = CONCAT(:NUMADE,"<<csq>>",HIS_DESCRI) ');
      SQL.Add('  WHERE HIS_CODOCO = :CODOCO ');
      SQL.Add('    AND HIS_CODEMP = :CODEMP ');
      SQL.Add('  ORDER BY HIS_DTAINC DESC, HIS_HORINC DESC ');
      SQL.Add('  LIMIT 1                    ');

      ParamByName('CODOCO').AsString := FCodOco;
      ParamByName('CODEMP').AsString := FCodEmp;
      ParamByName('NUMADE').AsString := IIF(FblnAdGarantia, 'Número AD Garantia : ', 'Número AD : ') + FNumDev;
      ExecSQL;

      //Update na ocorrencia da ocorrencia
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE MOVOCO ');
      SQL.Add('    SET OCO_DESCRI = CONCAT(:NUMADE,"<<csq>>",OCO_DESCRI) ');
      SQL.Add('  WHERE OCO_CODOCO = :CODOCO ');
      SQL.Add('    AND OCO_CODEMP = :CODEMP ');

      ParamByName('CODOCO').AsString := FCodOco;
      ParamByName('CODEMP').AsString := FCodEmp;
      ParamByName('NUMADE').AsString := 'Número AD : ' + FNumDev;
      ExecSQL;
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryUpd);
{$ENDIF LINUX}
  End;
end;

procedure TAtuOcoCrm.pAtualizaOcorrencia(ACodCli: String = '');
var
  LClienteProspecto: String;
begin
  LClienteProspecto := '';

  If Not fEmptyStr(ACodCli) Then
    LClienteProspecto := ACodCli
  Else
  Begin
    If (FTip_Fc = 'P') And (Not fEmptyStr(FCodPro)) Then
      LClienteProspecto := FCodPro
    Else If (Not fEmptyStr(FCodCli)) and (Not FBlnAtualizarCliente) and (Not FFulFillment) Then
    Begin
      LClienteProspecto := FCodCli;
    End;
  End;

  pAtualizaOcorrenciaInterna(LClienteProspecto);
end;

procedure TAtuOcoCrm.pAtualizaOcorrenciaInterna(ACodCli: String);
begin
  qryHisOco := Nil;
  Try
    qryHisOco := fCriaQuery();

    qryHisOco.Close;
    qryHisOco.SQL.Clear;
    qryHisOco.SQL.Add('UPDATE MOVOCO ');
    qryHisOco.SQL.Add('   SET OCO_DTAAGE = :DTAAGE, ');
    qryHisOco.SQL.Add('       OCO_HORAGE = :HORAGE, ');

    If Not fEmptyStr(FCodToc) Then
      qryHisOco.SQL.Add('       OCO_CODTOC = :CODTOC, ');

    if FDtaCon > 0 then
      qryHisOco.SQL.Add('       OCO_DTACON = :DTACON, ')
    else if (fCancelamentoVendaComPedido(strCodOco)) Or ((FDtaCon = 0) And (FReabreOcorrencia)) then
      qryHisOco.SQL.Add('       OCO_DTACON = NULL, ');

    if FHorCon > 0 then
      qryHisOco.SQL.Add('       OCO_HORCON = :HORCON, ')
    else if (fCancelamentoVendaComPedido(strCodOco)) Or ((FHorCon = 0)  And (FReabreOcorrencia)) then
      qryHisOco.SQL.Add('       OCO_HORCON = NULL, ');

    qryHisOco.SQL.Add('       OCO_OPEOCO = :OPEOCO, ');
    qryHisOco.SQL.Add('       OCO_CODOPE = :CODOPE, ');
    qryHisOco.SQL.Add('       OCO_DESCRI = CONCAT(:DESCRI,"<<csq>>","<<csq>>",OCO_DESCRI), ');
    qryHisOco.SQL.Add('       OCO_CODSIT = :CODSIT, ');

    If Not fEmptyStr(FCpfCli) Then
      qryHisOco.SQL.Add('       OCO_C_P_F_ = :C_P_F_, ');

    qryHisOco.SQL.Add('       OCO_CODCOC = :CODCOC,  ');
    //Campos da auditoria
    qryHisOco.SQL.Add('       OCO_USUALA = :USUALA, ');
    qryHisOco.SQL.Add('       OCO_DTAALA = :DTAALA, ');
    qryHisOco.SQL.Add('       OCO_HORALA = :HORALA, ');
    qryHisOco.SQL.Add('       OCO_ALTFRM = :ALTFRM, ');
    qryHisOco.SQL.Add('       OCO_ACAFAT = :ACAFAT, ');
    qryHisOco.SQL.Add('       OCO_EMERGE = :EMERGE, ');
    qryHisOco.SQL.Add('       OCO_ASSUNT = :ASSUNT, ');
    qryHisOco.SQL.Add('       OCO_CODTEA = :CODTEA  ');

    If (FTip_Fc = 'C') And (Not fEmptyStr(FCodCli)) And (FBlnAtualizarCliente) Then
    Begin
      qryHisOco.SQL.Add('      ,OCO_CODCLI = :CODCLI_ATU  ');
    End;

    qryHisOco.SQL.Add(' WHERE OCO_CODOCO = :CODOCO  ');
    qryHisOco.SQL.Add('   AND OCO_CODEMP = :CODEMP  ');

    If (Not fEmptyStr(ACodCli)) Then
      qryHisOco.SQL.Add('   AND OCO_CODCLI = :CODCLI  ');

    if FDtaCon > 0 then
      qryHisOco.ParamByName('DTACON').AsDateTime := FDtaCon;

    if FHorCon > 0 then
      qryHisOco.ParamByName('HORCON').AsDateTime := FHorCon;

    if FDtaAge = 0 then
    begin
      qryHisOco.ParamByName('DTAAGE').Clear;
      qryHisOco.ParamByName('HORAGE').Clear;
    end
    Else
    Begin
      qryHisOco.ParamByName('DTAAGE').AsDateTime := FDtaAge;
      qryHisOco.ParamByName('HORAGE').AsDateTime := FHorAge;
    End;

    qryHisOco.ParamByName('OPEOCO').AsString   := FOpeHis;
    qryHisOco.ParamByName('CODOPE').AsString   := FCodOpe;
    qryHisOco.ParamByName('DESCRI').AsString   := FDescri + '<<csq>>' + AnsiReplaceStr(FInfAdc, #13#10, '<<csq>>');
    qryHisOco.ParamByName('CODOCO').AsString   := FCodOco;

    If Not fEmptyStr(FCodToc) Then
      qryHisOco.ParamByName('CODTOC').AsString   := FCodToc;

    If (FTip_Fc = 'C') And (Not fEmptyStr(FCodCli)) And (FBlnAtualizarCliente) Then
    Begin
      qryHisOco.ParamByName('CODCLI_ATU').AsString  := FCodCli;
    End;

    If (Not fEmptyStr(ACodCli)) Then
      qryHisOco.ParamByName('CODCLI').AsString := ACodCli;

    If fEmptyStr(FCodSit) Then
      qryHisOco.ParamByName('CODSIT').Clear
    Else
      qryHisOco.ParamByName('CODSIT').AsString := FCodSit;

    If Not fEmptyStr(FCpfCli) Then
      qryHisOco.ParamByName('C_P_F_').AsString := FCpfCli;

    qryHisOco.ParamByName('CODEMP').AsString   := IIF(FBlnVendaDesmembrada, FEmpOri, FCodEmp);

    If fEmptyStr(FCodCoc) Then
      qryHisOco.ParamByName('CODCOC').Clear
    Else
      qryHisOco.ParamByName('CODCOC').AsString := FCodCoc;
    //Campos da auditoria
    qryHisOco.ParamByName('USUALA').AsString   := FOpeHis;
    qryHisOco.ParamByName('DTAALA').AsDate     := VS_Date;
    qryHisOco.ParamByName('HORALA').AsTime     := fTime();

    qryHisOco.ParamByName('ALTFRM').AsString   := FNomForm;
    qryHisOco.ParamByName('ACAFAT').AsString   := FAcaFat.fGetDescricao();
    qryHisOco.ParamByName('EMERGE').AsString   := IIF(FblnEmerge, 'S', 'N');
    qryHisOco.ParamByName('ASSUNT').AsString   := FAssunt;

    If fEmptyStr(FCodTea) Then
      qryHisOco.ParamByName('CODTEA').Clear
    Else
      qryHisOco.ParamByName('CODTEA').AsString := FCodTea;

    If (FGravarOcorrenciasEmLote) Then
    Begin
      FLoteOcorrencia.SQL.Add(fSQLBindParameters(qryHisOco) + ';');
      pGravarLoteOcorrencias(True);
    End
    Else
      qryHisOco.ExecSQL;

  Finally

    If (fCancelamentoVendaComPedido(strCodOco)) Or
       (Not fEmptyStr(FDocumentosCancelamento)) Then
    Begin
      FblnRecarregarOcoGravarMsg := False;
      If fEmptyStr(FDocumentosCancelamento) Then
      Begin
        FDocumentosCancelamento := FDocumentosCancelamento +
                                   fCampoTabela('OCO_NUMDOC', 'MOVOCO', ['OCO_CODOCO', 'OCO_CODEMP'], [strCodOco, FCodEmp])+'-'+
                                   fCampoTabela('OCO_ESPDOC', 'MOVOCO', ['OCO_CODOCO', 'OCO_CODEMP'], [strCodOco, FCodEmp])+'-'+
                                   fCampoTabela('OCO_CODEMP', 'MOVOCO', ['OCO_CODOCO', 'OCO_CODEMP'], [strCodOco, FCodEmp])+'.'+#13;
        FMensagemCancelamento := 'O Documento: '+FNumDoc+'-'+FEspDoc+' foi originado a partir do documento: '+#13+
                                 FDocumentosCancelamento+#13+
                                 'Os Pedidos possuem movimentação pelo CRM, permitido apenas realizar a baixa.';
      End
      Else
      Begin
        FMensagemCancelamento := 'O Documento: '+FNumDoc+'-'+FEspDoc+' foi originado a partir do(s) documento(s): '+#13+
                                 FDocumentosCancelamento+#13+
                                 'O Pedido possui movimentação pelo CRM, permitido apenas realizar a baixa.';
      End;
    End;

    pGravarMensagemOperadorOcorrencia(tpAlteracao, FCodOco, FCodEmp, FTip_Fc);

{$IFNDEF LINUX}
    If Assigned(qryHisOco) Then
      FreeAndNil(qryHisOco);
{$ENDIF LINUX}

  End;
end;

class procedure TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(strNumDup, strEspDoc,
      strCodEmp, strCodCli, strParcel, strCodOpe, strCpfCli: String;
      finAcaFat: TAcaoFatCRM; blnEncerrar: Boolean = False; blnReabre: Boolean = False;
      blnExcluir: Boolean = False; strMsgFinaliza: String = '';
      fltVlrBx: Double = 0);
var
  objOcoCrm: TAtuOcoCrm;
begin
  If (Not fEmpresaUsaCRM(strCodEmp)) Then
    Exit;

  objOcoCrm := TAtuOcoCrm.Create(nil);
  objOcoCrm.strNumDoc := strNumDup;
  objOcoCrm.strEspDoc := strEspDoc;
  objOcoCrm.strCodEmp := strCodEmp;
  objOcoCrm.strCodCli := strCodCli;
  objOcoCrm.strCodOpe := strCodOpe;
  objOcoCrm.afcAcaFat := finAcaFat;
  objOcoCrm.strCpfCli := strCpfCli;
  objOcoCrm.strParcel := strParcel;
  objOcoCrm.FReabreOcorrencia := blnReabre;

  objOcoCrm.pProcessaFinanceiro(blnEncerrar, blnExcluir, strMsgFinaliza, fltVlrBx);

  FreeAndNil(objOcoCrm);
end;

procedure TAtuOcoCrm.pFinalizaOcorrencia(const strObsFinaliza: String; strOpeFin: String = ''; ACodCli: String = '');
begin
  If fEmptyStr(FCodOco) Then
    Exit;

  strDescri := IfThen(Not fEmptyStr(strObsFinaliza), strObsFinaliza + '<<csq>>', '') + 'Finalizando a Ocorrência.';

  If Not fEmptyStr(FMotFinOco) Then
    strDescri := strDescri +'<<csq>>Motivo: ' + FMotFinOco + ' - ' + FDesMotFin  +'<<csq>>';

  strOpeHis := strLoginUsuarioLogado;
  FDtaInc := VS_Date;
  FHorInc := fRetHoraServidor();
  FDtaCon := FDtaInc;
  FHorCon := FHorInc;
  If fEmptyStr(strOpeFin) then
    strCodOpe := strLoginUsuarioLogado
  Else
    strCodOpe := strOpeFin;

  strDescri := strDescri + '<<csq>>Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) +
                           '<<csq>>' + DateToStr(VS_Date) + ' ' + TimeToStr(fTime()) + ' - ' + fRetNomeOperador(strCodOpe);

  pInsereHistoricoOcorrencia;
  strDtaCon := VS_Date;
  strHorCon := fRetHoraServidor;
  pAtualizaOcorrencia(ACodCli);
end;

function TAtuOcoCrm.fRetornaSQLOcorrencia(Const strTip_Fc: String = 'C'): String;
var
  sqlOcorrenciaCRM: String;
Begin
  sqlOcorrenciaCRM := 'SELECT MOVOCO.*,                         '+
                      '       OPEDES.OPE_NOMOPE AS NOMOPE_DES,  '+
                      '       OPEORI.OPE_NOMOPE AS NOMOPE_ORI,  '+
                      '       GOC_CODGOC,                       '+
                      '       GOC_DESGOC,                       '+
                      '       COC_DESCOC,                       '+
                      '       TOC_DESTOC,                       '+
                      '       SIT_DESSIT,                       '+
                      '       (CASE WHEN OCO_TIP_FC = "C" THEN CLIENTE.CLI_NOMCLI    '+
                      '             WHEN OCO_TIP_FC = "P" THEN PROSPECTO.PRO_NOMCLI  '+
                      '             WHEN OCO_TIP_FC = "F" THEN FORNECEDOR.FOR_NOMFOR '+
                      '       END) AS CLI_NOMCLI,                                    '+
                      '       TEA_DESCRI                                             '+
                      ' FROM MOVOCO                                                     '+
                      ' INNER JOIN CADOPE AS OPEORI ON (OPEORI.OPE_CODOPE = OCO_OPEOCO) ' +
                      ' INNER JOIN CADOPE AS OPEDES ON (OPEDES.OPE_CODOPE = OCO_CODOPE) ' +
                      ' INNER JOIN CADTOC ON (TOC_CODTOC = OCO_CODTOC) ' +
                      ' INNER JOIN CADGOC ON (GOC_CODGOC = TOC_CODGOC) ' +
                      ' LEFT  JOIN CADCOC ON (COC_CODCOC = OCO_CODCOC) ' +
                      ' LEFT  JOIN SITOCO ON (SIT_CODSIT = OCO_CODSIT AND OCO_CODTOC = SIT_CODTOC) ' +
                      ' LEFT JOIN (SELECT CLI_CODCLI,                  ' +
                      '                   CLI_NOMCLI                   ' +
                      '            FROM CADCLI                         ' +
                      '            LEFT JOIN CLICON ON CLI_C_G_C_ = CON_C_P_F_ ) AS CLIENTE ON ( CLIENTE.CLI_CODCLI = OCO_CODCLI AND OCO_TIP_FC = "C" ) '+
                      ' LEFT JOIN (SELECT PRO_CODPRO, '+
                      '                   PRO_NOMCLI  '+
                      '            FROM PROSPE ) AS PROSPECTO ON ( PROSPECTO.PRO_CODPRO = OCO_CODCLI AND OCO_TIP_FC = "P" ) '+
                      ' LEFT JOIN (SELECT FOR_CODFOR, '+
                      '                   FOR_NOMFOR  '+
                      '            FROM CADFOR) AS FORNECEDOR ON ( FORNECEDOR.FOR_CODFOR = OCO_CODCLI AND OCO_TIP_FC = "F" )'+
                      ' LEFT JOIN CADTEA ON (OCO_CODTEA = TEA_CODIGO) ' +
                      ' WHERE OCO_CODEMP = :CODEMP              ' +
                      '   AND OCO_CODOCO = :CODOCO              ' ;

  If Not fEmptyStr(strTip_Fc) Then
    sqlOcorrenciaCRM := sqlOcorrenciaCRM + ' AND OCO_TIP_FC = :TIP_FC';

  Result :=  sqlOcorrenciaCRM;
End;

procedure TAtuOcoCrm.pCarregaOcorrenciaCliente(const strCodEmp, strEspDoc, strNumDoc, strCodCli: String);
var
  strCodOco: String;
Begin
  strCodOco := fRetornaCodigoOcorrencia(strNumDoc,strEspDoc,strCodCli,strCodEmp,'');
  pCarregaOcorrencia('C', strCodOco, strCodEmp);
End;

procedure TAtuOcoCrm.pCarregaOcorrencia(const strTip_Fc: String; const strCodOco: String; const strCodEmp: String);
var
  qryOco: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qryOco := fCriaQuery;
  Try
    qryOco.Close;
    qryOco.SQL.Clear;
    qryOco.SQL.Add(fRetornaSQLOcorrencia(strTip_Fc));
    qryOco.ParamByName('CODOCO').AsString := strCodOco;
    qryOco.ParamByName('CODEMP').AsString := strCodEmp;

    {$IFDEF LINUX}
    If qryOco.FindParam('TIP_FC') <> Nil Then
      qryOco.ParamByName('TIP_FC').AsString := strTip_Fc;
    {$ELSE }
    If qryOco.Params.FindParam('TIP_FC') <> Nil Then
      qryOco.ParamByName('TIP_FC').AsString := strTip_Fc;
    {$ENDIF LINUX}

    qryOco.Open;
    If Not(qryOco.IsEmpty) Then
    Begin
      FInfAdc := EmptyStr;

      FAutInc := qryOco.FieldByName('AUTOINCREM').AsString;
      FCodOco := qryOco.FieldByName('OCO_CODOCO').AsString;
      FDtaInc := qryOco.FieldByName('OCO_DTAINC').AsDateTime;
      FHorInc := qryOco.FieldByName('OCO_HORINC').AsDateTime;
      FDtaAge := qryOco.FieldByName('OCO_DTAAGE').AsDateTime;
      FHorAge := qryOco.FieldByName('OCO_HORAGE').AsDateTime;
      FDtaCon := qryOco.FieldByName('OCO_DTACON').AsDateTime;
      FHorCon := qryOco.FieldByName('OCO_HORCON').AsDateTime;
      FNumDoc := qryOco.FieldByName('OCO_NUMDOC').AsString;
      FEspDoc := qryOco.FieldByName('OCO_ESPDOC').AsString;
      FCodEmp := qryOco.FieldByName('OCO_CODEMP').AsString;
      FCodCli := qryOco.FieldByName('OCO_CODCLI').AsString;
      FParcel := qryOco.FieldByName('OCO_PARCEL').AsString;
      FCodToc := qryOco.FieldByName('OCO_CODTOC').AsString;
      FCodCoc := qryOco.FieldByName('OCO_CODCOC').AsString;
      FCodSit := qryOco.FieldByName('OCO_CODSIT').AsString;
      FTip_Fc := qryOco.FieldByName('OCO_TIP_FC').AsString;
      FCodAca := qryOco.FieldByName('OCO_CODACA').AsString;
      FProtoc := qryOco.FieldByName('OCO_PROTOC').AsString;
      FCodOpe := qryOco.FieldByName('OCO_CODOPE').AsString;
      FOpeHis := qryOco.FieldByName('OCO_OPEOCO').AsString;
      FDescri := qryOco.FieldByName('OCO_DESCRI').AsString;
      FCodGoc     := qryOco.FieldByName('GOC_CODGOC').AsString;
      FNomCli     := qryOco.FieldByName('CLI_NOMCLI').AsString;
      FNomOpe_Ori := qryOco.FieldByName('NOMOPE_ORI').AsString;
      FNomOpe_Des := qryOco.FieldByName('NOMOPE_DES').AsString;
      FDesGoc     := qryOco.FieldByName('GOC_DESGOC').AsString;
      FDesCoc     := qryOco.FieldByName('COC_DESCOC').AsString;
      FDesToc     := qryOco.FieldByName('TOC_DESTOC').AsString;
      FDesToc     := qryOco.FieldByName('TOC_DESTOC').AsString;
      FDesSit     := qryOco.FieldByName('SIT_DESSIT').AsString;
      FAssunt     := qryOco.FieldByName('OCO_ASSUNT').AsString;
      FCodTea     := qryOco.FieldByName('OCO_CODTEA').AsString;
      FDesTea     := qryOco.FieldByName('TEA_DESCRI').AsString;
      FblnAgrPed  := qryOco.FieldByName('OCO_DOCAGR').AsString = 'S';
    End;

  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryOco);
{$ENDIF LINUX}
  End;
end;

function TAtuOcoCrm.fEncerrarOcorrenciaGarantia(pstrNumDoc, pstrEspDoc, pstrCodCli,
  pstrCodEmp: String; pAcaoFatCRM: TAcaoFatCRM): Boolean;
Var
  lQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  lSql: String;
begin
  Result := False;

  if fEmptyStr(strCodOco) then
    Exit(False);

  if Not (pAcaoFatCRM in [afcGarantiaAndamentoPendLibCrd..afcGarantiaAndamentoPendEnvCli_Confirmacao]) then
    Exit(False)

  else if (pAcaoFatCRM in [afcGarantiaCredito, afcGarantiaCancelada, afcGarantiaReposicaoItemConcluida]) then
    Exit(True);

  lSql :=        ' SELECT D.AUTOINCREM, ';
  lSql := lSql + '        D.GAD_QTDREQ, ';
  lSql := lSql + '        D.GAD_QTDDEV, ';
  lSql := lSql + '        D.GAD_QTDPRE, ';
  lSql := lSql + '        D.GAD_REPOST, ';
  lSql := lSql + '        D.GAD_SCREDI ';
  lSql := lSql + ' FROM MOVDET D2 ';
  lSql := lSql + ' JOIN MOVGRC C ON C.GRC_SEQDET = D2.AUTOINCREM AND C.GRC_OPCDOC IN ("DV","GA","OE","NE") ';
  lSql := lSql + ' JOIN MOVGAD D ON C.GRC_SEQGAD = D.AUTOINCREM ';
  lSql := lSql + ' WHERE     D2.DET_NUMDOC = :NUMENT ';
  lSql := lSql + '       AND D2.DET_CODEMP = :CODEMP ';
  lSql := lSql + '       AND D2.DET_CODCLI = :CODCLI ';
  lSql := lSql + '       AND D2.DET_ESPDOC = :ESPDOC ';

  lQry := fCriaQuery();
  Try
    lQry.Close;
    lQry.SQL.Clear;
    lQry.SQL.Add(lSql);
    lqry.ParamByName('NUMENT').AsString := pstrNumDoc;
    lqry.ParamByName('CODEMP').AsString := pstrCodEmp;
    lqry.ParamByName('CODCLI').AsString := pstrCodCli;
    lqry.ParamByName('ESPDOC').AsString := pstrEspDoc;
    lQry.Open;
    if lQry.IsEmpty then
      Exit;
    lQry.First;
    While Not lQry.Eof do
    begin
      if lQry.FieldByName('GAD_SCREDI').AsInteger = 2 then
        Result := True
      else
      begin
        Result :=
          (lQry.FieldByName('GAD_QTDREQ').AsFloat -
            (lQry.FieldByName('GAD_QTDDEV').AsFloat +
              lQry.FieldByName('GAD_QTDPRE').AsFloat)) <= 0;
      end;

      if Not Result then
        Break;

      lQry.Next;
    end;
  Finally
    {$IFNDEF LINUX}
    lQry.Free;
    {$ENDIF LINUX}
  End;
end;

function TAtuOcoCrm.fEnviarMensagemOperador(Const strCodOpe: String): Boolean;
  Var
    strMsgCrm : String;
begin
  strMsgCrm := fCampoTabela('OPE_MSGCRM', 'CADOPE', ['OPE_CODOPE'], [strCodOpe], False);
  Result := (strMsgCrm = 'S');
end;

procedure TAtuOcoCrm.pEnviarMensagemDestinatatio(const strOpeDest, strTituloMensagem, strMensagem: String);
var
  msgMensagem : TMsgInterna;
Begin
  If FOpeHis = strOpeDest Then
    Exit;

  If Not(fEnviarMensagemOperador(strOpeDest)) Then
    Exit;

  msgMensagem := TMsgInterna.Create(Self);
  Try
    msgMensagem.fEnviaMensagem(strTituloMensagem,
                               strMensagem,
                               FOpeHis,
                               strOpeDest,
                               'N',
                               '');
  Finally
    FreeAndNil(msgMensagem);
  End;
End;

procedure TAtuOcoCrm.pExecutarAposProcessamentoOco;
Begin
  pAtualizarCategoriaCRMProspecto;
End;

procedure TAtuOcoCrm.pAtualizarCategoriaCRMProspecto;
var
  strCodPro: String;
  strCodCliPro: String;
  qryProspe: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  strCatAnt, strCatAtu: String;
  blnCategoriaAtualizada: Boolean;
begin
  blnCategoriaAtualizada := False;

  If strTip_FC = 'F' Then
    Exit;

  If strTip_FC = 'C' Then
    strCodPro := fCampoTabela('PRO_CODPRO', 'PROSPE', ['PRO_CODCLI'], [FCodCli])
  Else
    strCodPro := FCodCli;

  If fEmptyStr(strCodPro) Then
    Exit;

  qryProspe := fCriaQuery;
  Try
    qryProspe.SQL.Add('SELECT * FROM PROSPE WHERE PRO_CODPRO = :PRO_CODPRO');
    qryProspe.ParamByName('PRO_CODPRO').AsString := strCodPro;
    qryProspe.Open;

    If qryProspe.IsEmpty Then
      Exit;

    strCodCliPro := qryProspe.FieldByName('PRO_CODCLI').AsString;
    IF fEmptystr(strCodCliPro) Then
    Begin
      strCodCliPro := fCfgSis('CONCRM', varString);
    End;

    strCatAnt := qryProspe.FieldByName('PRO_CRMCAT').AsString;

    Case FAcaFat Of
      afcOrcamento             : Begin
                                   If qryProspe.FieldByName('PRO_CRMCAT').AsString = fCfgSis('CATPRO') Then
                                   Begin
                                     pGravarLogAlteraCategoria(qryProspe.FieldByName('AUTOINCREM').AsString,
                                                               qryProspe.FieldByName('PRO_STAPRO').AsString,
                                                               qryProspe.FieldByName('PRO_CRMCAT').AsString,
                                                               fCfgSis('CATLEA'));

                                     strCatAnt := fCfgSis('CATLEA', varString);
                                   End;

                                   strCatAtu := fCfgSis('CATOPO', varString);
                                   blnCategoriaAtualizada := TCategoriaCrm.fNew
                                                                          .fAtualizarCategoriaProspecto(strCatAtu, strCodPro);
                                 End;
      afcOrcamentoFaturado,
      afcPedidoFaturado        : Begin
                                   strCatAtu := fCfgSis('CATVND', varString);
                                   blnCategoriaAtualizada := TCategoriaCrm.fNew
                                                                          .fAtualizarCategoriaProspecto(strCatAtu, strCodPro);
                                 End;

      afcBaixaPedidoNaoEntregue: Begin
                                   strCatAtu := fCfgSis('CATLEA', varString);
                                   If (strTip_FC = 'P') And
                                      (Not fExisteOrcamentoPendente(strCodCliPro, FNumDoc, strCodPro)) And
                                      (Not fExistePedidoPendente(strCodCliPro, FNumDoc, strCodPro)) Then
                                   Begin
                                     blnCategoriaAtualizada := TCategoriaCrm.fNew
                                                                            .fAtualizarCategoriaProspecto(strCatAtu, strCodPro);
                                   End
                                   Else
                                   If (strTip_FC = 'C') And
                                      (Not fExisteOrcamentoPendente(FCodCli, FNumDoc, strCodPro)) And
                                      (Not fExistePedidoPendente(FCodCli, FNumDoc, strCodPro)) Then
                                   Begin
                                     blnCategoriaAtualizada := TCategoriaCrm.fNew
                                                                            .fAtualizarCategoriaProspecto(strCatAtu, strCodPro);
                                   End;

                                   TLogCatProspecto.fNew
                                                   .strEmpDoc(FCodEmp)
                                                   .strEspDoc(FEspDoc)
                                                   .strNumDoc(FNumDoc)
                                                   .pRemoverLogCatOportunidade;
                                 End;
        afcDocumentoCancelado :  Begin
                                   strCatAtu := fCfgSis('CATOPO', varString);
                                   blnCategoriaAtualizada := TCategoriaCrm.fNew
                                                                          .fAtualizarCategoriaProspecto(strCatAtu, strCodPro);

                                   TLogCatProspecto.fNew
                                                   .strEmpDoc(FCodEmp)
                                                   .strEspDoc(FEspDoc)
                                                   .strNumDoc(FNumDoc)
                                                   .pRemoverLogCatVenda;

                                 End;
    End;

    If blnCategoriaAtualizada Then
    Begin
      pGravarLogAlteraCategoria(qryProspe.FieldByName('AUTOINCREM').AsString,
                                qryProspe.FieldByName('PRO_STAPRO').AsString,
                                strCatAnt, strCatAtu);
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryProspe);
{$ENDIF LINUX}
  End;
end;

procedure TAtuOcoCrm.pGravarLogAlteraCategoria(Const strAutInc, strStaPro, strCatAnt, strCatAtu: String);
begin
  TLogCatProspecto.fNew
                  .strSeqPro(strAutInc)
                  .strCatAnt(strCatAnt)
                  .strCatAtu(strCatAtu)
                  .strStaPro(strStaPro)
                  .strEmpDoc(FCodEmp)
                  .strEspDoc(FEspDoc)
                  .strNumDoc(FNumDoc)
                  .strCodMot(FCodMot)
                  .pGravaLogAlteracaoCategoria;
end;

procedure TAtuOcoCrm.pGravarLoteOcorrencias(const blnValidar : Boolean);
begin
  If FLoteOcorrencia.SQL.Count = 0 Then
    Exit;
  If (blnValidar) Then
  Begin
    If (FLoteOcorrencia.SQL.Count < 100) Then
      Exit;
  End;
  FLoteOcorrencia.ExecSQL;
  FLoteOcorrencia.SQL.Clear;
end;

procedure TAtuOcoCrm.pGravarMensagemOperadorOcorrencia(Const tpAcao: TTipoOperacaoOcorrencia; const strCodOco: String; const strCodEmp: String; const strTip_Fc: String);
Var
  stlMensagem : TStringList;
  strTituloMensagem: String;
  strAux: String;
  intPos: Integer;
  strCodOpeAux: String;
Begin
  If ((Not blnOrcamentoTransformadoEmPedido) And (FblnRecarregarOcoGravarMsg)) Then
    pCarregaOcorrencia(strTip_Fc,
                       strCodOco,
                       strCodEmp);

  stlMensagem := TStringList.Create;
  strTituloMensagem := EmptyStr;
  Try
    Case tpAcao Of
      tpInclusao  : strTituloMensagem := 'INCLUSÃO DE OCORRÊNCIA';
      tpAlteracao : strTituloMensagem := 'ALTERAÇÃO DE OCORRÊNCIA';
    End;

    stlMensagem.Add(strTituloMensagem);
    stlMensagem.Add('Data/Hora Ocorrência: ' + DateTimeToStr(FDtaInc) + ' ' + FormatDateTime('hh:mm:ss', FHorInc));
    stlMensagem.Add('Cliente: ' + FCodCli + ' - ' + FNomCli);
    stlMensagem.Add('Operador Remetente: ' + FOpeHis + ' - ' + FNomOpe_Ori);
    stlMensagem.Add('Dados da Ocorrência: ' );
    stlMensagem.Add('  Grupo: ' + FCodGoc + ' - ' + FDesGoc);
    If Not fEmptyStr(FCodCoc) Then
      stlMensagem.Add('  Complemento: ' + FCodCoc + ' - ' + FDesCoc);
    If Not fEmptyStr(FCodSit) Then
      stlMensagem.Add('  Situação: ' + FCodSit + ' - ' + FDesSit);
    stlMensagem.Add('  Tipo: ' + FCodToc + ' - ' + FDesToc);
    FDescri := AnsiReplaceStr(FDescri, '<<csq>>',  #13#10);
    stlMensagem.Add('  Descrição: ' + FDescri);
    stlMensagem.Add('  Protocolo: ' + FProtoc);

    If FBlnMsgMultiplosDestinatarios Then
    Begin
      strAux := FstrOperadoresDestino;
      repeat
        intPos := Pos(',', strAux);
        If intPos > 0 Then
        Begin
          strCodOpeAux := Copy(strAux, 0, intPos-1);
          strAux := Trim(Copy(strAux, intPos +1, Length(strAux)));
        End
        Else
        Begin
          strCodOpeAux := Copy(strAux, 0, Length(strAux));
          strAux := EmptyStr;
        End;

        pEnviarMensagemDestinatatio(strCodOpeAux, strTituloMensagem, stlMensagem.Text);

      until (strAux = EmptyStr);
    End
    Else
      pEnviarMensagemDestinatatio(FCodOpe, strTituloMensagem, stlMensagem.Text);

  Finally
    FreeAndNil(stlMensagem);
  End;
End;

procedure TAtuOcoCrm.pInsereAutorizacaoDevolucao;
begin
  try
    qryAutDev := fCriaQuery();

    qryAutDev.Close;
    qryAutDev.SQL.Clear;
    qryAutDev.SQL.Add('INSERT INTO ADEGER ');
    qryAutDev.SQL.Add('(                  ');
    qryAutDev.SQL.Add('  GER_CODADE,      ');
    qryAutDev.SQL.Add('  GER_CODOCO,      ');
    qryAutDev.SQL.Add('  GER_CODEMP,      ');
    qryAutDev.SQL.Add('  GER_GERCOL,      ');
    qryAutDev.SQL.Add('  AUTOINCREM       ');
    qryAutDev.SQL.Add(') VALUES (         ');
    qryAutDev.SQL.Add('  :CODADE,         ');
    qryAutDev.SQL.Add('  :CODOCO,         ');
    qryAutDev.SQL.Add('  :CODEMP,         ');
    qryAutDev.SQL.Add('  :GERCOL,         ');
    qryAutDev.SQL.Add('  :AUTOIN)         ');

    strNumDev := fAtualizaProCod('ADEGER', 'GER_CODADE');
    strSeqGer := fRetAutoIncrem('ADEGER', VS_strCodEmp);

    qryAutDev.ParamByName('CODADE').AsString := FNumDev;
    qryAutDev.ParamByName('CODOCO').AsString := FCodOco;
    qryAutDev.ParamByName('CODEMP').AsString := FCodEmp;
    qryAutDev.ParamByName('GERCOL').AsString := FGerCol;
    qryAutDev.ParamByName('AUTOIN').AsString := FSeqGer;
    qryAutDev.ExecSQL;
    qryAutDev.Close;

    pInsereAutorizacaoDevolucaoProdutos;
  finally
{$IFNDEF LINUX}
    FreeAndNil(qryAutDev);
{$ENDIF LINUX}
  end;

end;

procedure TAtuOcoCrm.pInsereAutorizacaoDevolucaoProdutos;
  procedure pLimparParametros;
  begin
    qryAutDev.ParamByName('CODADE').Value   := null;
    qryAutDev.ParamByName('CODITE').Value   := null;
    qryAutDev.ParamByName('CODMOT').Value   := null;
    qryAutDev.ParamByName('QTDDEV').Value   := null;
    qryAutDev.ParamByName('UNIDEV').Value   := null;    
    qryAutDev.ParamByName('CODEMP').Value   := null;
    qryAutDev.ParamByName('AUTOIN').Value   := null;
    qryAutDev.ParamByName('SEQGER').Value   := null;
    qryAutDev.ParamByName('NUMDOC').Value   := null;
    qryAutDev.ParamByName('ESPDOC').Value   := null;
    qryAutDev.ParamByName('DTAMOV').Value   := null;
    qryAutDev.ParamByName('FORCLI').Value   := null;
    qryAutDev.ParamByName('TIP_FC').Value   := null;
    qryAutDev.ParamByName('SERIE_').Value   := null;
    qryAutDev.ParamByName('GARANT').Value   := null;
  end;
var
  blnTemItemGarantia: Boolean;
begin
  FblnAdGarantia := False;
  blnTemItemGarantia := False;
  Try
    qryAutDev := fCriaQuery();

    If not fEmptyStr(FNumDev) Then
    Begin
      qryAutDev.Close;
      qryAutDev.SQL.Clear;
      qryAutDev.SQL.Add('DELETE FROM ADEDET ');
      qryAutDev.SQL.Add(' WHERE DET_CODADE = :CODADE ');
      qryAutDev.SQL.Add('   AND DET_CODEMP = :CODEMP ');
      qryAutDev.ParamByName('CODADE').AsString := FNumDev;
      qryAutDev.ParamByName('CODEMP').AsString := FCodEmp;
      qryAutDev.ExecSQL;
    End;

    qryAutDev.Close;
    qryAutDev.SQL.Clear;
    qryAutDev.SQL.Add('INSERT INTO ADEDET ');
    qryAutDev.SQL.Add('(                  ');
    qryAutDev.SQL.Add('  DET_CODADE,      ');
    qryAutDev.SQL.Add('  DET_CODITE,      ');
    qryAutDev.SQL.Add('  DET_CODMOT,      ');
    qryAutDev.SQL.Add('  DET_QTDDEV,      ');
    qryAutDev.SQL.Add('  DET_UNIDEV,      ');
    qryAutDev.SQL.Add('  DET_CODEMP,      ');
    qryAutDev.SQL.Add('  AUTOINCREM,      ');
    qryAutDev.SQL.Add('  DET_SEQGER,      ');
    qryAutDev.SQL.Add('  DET_NUMDOC,      ');
    qryAutDev.SQL.Add('  DET_ESPDOC,      ');
    qryAutDev.SQL.Add('  DET_DTAMOV,      ');
    qryAutDev.SQL.Add('  DET_QTDORI,      ');
    qryAutDev.SQL.Add('  DET_FORCLI,      ');
    qryAutDev.SQL.Add('  DET_TIP_FC,      ');
    qryAutDev.SQL.Add('  DET_SERIE_,      ');
    qryAutDev.SQL.Add('  DET_GARANT,      ');
    qryAutDev.SQL.Add('  DET_SEQORI       ');
    qryAutDev.SQL.Add(') VALUES (         ');
    qryAutDev.SQL.Add('  :CODADE,         ');
    qryAutDev.SQL.Add('  :CODITE,         ');
    qryAutDev.SQL.Add('  :CODMOT,         ');
    qryAutDev.SQL.Add('  :QTDDEV,         ');
    qryAutDev.SQL.Add('  :UNIDEV,         ');
    qryAutDev.SQL.Add('  :CODEMP,         ');
    qryAutDev.SQL.Add('  :AUTOIN,         ');
    qryAutDev.SQL.Add('  :SEQGER,         ');
    qryAutDev.SQL.Add('  :NUMDOC,         ');
    qryAutDev.SQL.Add('  :ESPDOC,         ');
    qryAutDev.SQL.Add('  :DTAMOV,         ');
    qryAutDev.SQL.Add('  :QTDORI,         ');
    qryAutDev.SQL.Add('  :FORCLI,         ');
    qryAutDev.SQL.Add('  :TIP_FC,         ');
    qryAutDev.SQL.Add('  :SERIE_,         ');
    qryAutDev.SQL.Add('  :GARANT,         ');
    qryAutDev.SQL.Add('  :SEQORI          ');
    qryAutDev.SQL.Add(')                  ');

    FCdsDev.First;
    While Not FCdsDev.Eof Do
    Begin
      pLimparParametros;

      qryAutDev.ParamByName('CODADE').AsString := FNumDev;
      qryAutDev.ParamByName('CODITE').AsString := FCdsDev.FieldByName('CODITE').AsString;
      qryAutDev.ParamByName('CODMOT').AsString := FCdsDev.FieldByName('CODMOT').AsString;
      qryAutDev.ParamByName('QTDDEV').AsFloat  := FCdsDev.FieldByName('QTDITE').AsFloat;
      qryAutDev.ParamByName('UNIDEV').AsFloat  := FCdsDev.FieldByName('UNITAR').AsFloat;
      qryAutDev.ParamByName('CODEMP').AsString := FCodEmp;
      qryAutDev.ParamByName('AUTOIN').AsString := fRetAutoIncrem('ADEDET', VS_strCodEmp);
      qryAutDev.ParamByName('SEQGER').AsString := FSeqGer;

      If not fEmptyStr(FCdsDev.FieldByName('NUMDOC').AsString) Then
        qryAutDev.ParamByName('NUMDOC').AsString := FCdsDev.FieldByName('NUMDOC').AsString;

      If not fEmptyStr(FCdsDev.FieldByName('ESPDOC').AsString) Then
        qryAutDev.ParamByName('ESPDOC').AsString := FCdsDev.FieldByName('ESPDOC').AsString;

      If FCdsDev.FieldByName('DTAULT').AsDateTime > 0 Then
        qryAutDev.ParamByName('DTAMOV').AsDateTime := FCdsDev.FieldByName('DTAULT').AsDateTime;

      If not fEmptyStr(FCdsDev.FieldByName('FORCLI').AsString) Then
        qryAutDev.ParamByName('FORCLI').AsString := FCdsDev.FieldByName('FORCLI').AsString;

      If not fEmptyStr(FCdsDev.FieldByName('TIP_FC').AsString) Then
        qryAutDev.ParamByName('TIP_FC').AsString := FCdsDev.FieldByName('TIP_FC').AsString;

      If not fEmptyStr(FCdsDev.FieldByName('SERIE_').AsString) Then
        qryAutDev.ParamByName('SERIE_').AsString := FCdsDev.FieldByName('SERIE_').AsString
      Else
        qryAutDev.ParamByName('SERIE_').AsString := '';

      qryAutDev.ParamByName('QTDORI').AsFloat  := FCdsDev.FieldByName('QTDORI').AsFloat;
      qryAutDev.ParamByName('GARANT').AsString := FCdsDev.FieldByName('GARANT').AsString;
      qryAutDev.ParamByName('SEQORI').AsString := FCdsDev.FieldByName('SEQORI').AsString;

      qryAutDev.ExecSQL;


      If Not(blnTemItemGarantia) Then
        blnTemItemGarantia := FCdsDev.FieldByName('GARANT').AsString = 'S';


      qryAutDev.Close;

      FCdsDev.Next;
    End;

    FblnAdGarantia := blnTemItemGarantia;

    pAdicionaNumeroADNoHistoricoDaOcorrencia;

{$IFNDEF LINUX}
    if (not fInTransaction) then
      fMensagem('INFORMAÇÃO!', 'Autorização de devolução nº : ' + FNumDev + ' gravada com sucesso !',['&Ok']);
{$ENDIF LINUX}

  finally
{$IFNDEF LINUX}
    FreeAndNil(qryAutDev);
{$ENDIF LINUX}
  end;
end;

procedure TAtuOcoCrm.pInsereClientesImpressaoEtiquetas;
var
  intCont: Integer;
begin
  SetLength(ArrCliImpEti,fQuantidadeClientes);
  pPreencheArrCliImpEti;
  for intCont := 0 to Length(ArrCliImpEti) - 1 do
  begin
    if not fEmptyStr(ArrCliImpEti[intCont]) then
    begin
      strCodCli := ArrCliImpEti[intCont];
      pInsereNovaOcorrencia;
      pInsereHistoricoOcorrencia;
    end;
  end;
end;

procedure TAtuOcoCrm.pInsereHistoricoOcorrencia;
var
  blnComita: Boolean;
begin
  If fEmptyStr(FCodOco) Then
      Exit;

  qryHisOco := Nil;
  try
    FResultadoHistoricoOcorrencia := False;

    blnComita := false;
    if not fInTransaction then
    begin
      fStartTransaction;
      blnComita := true;
    end;

    try
      qryHisOco := fCriaQuery();

      qryHisOco.Close;
      qryHisOco.SQL.Clear;
      qryHisOco.SQL.Add('INSERT INTO HISOCO ');
      qryHisOco.SQL.Add('(                  ');
      qryHisOco.SQL.Add('  HIS_CODHIS,      ');
      qryHisOco.SQL.Add('  HIS_CODOCO,      ');
      qryHisOco.SQL.Add('  HIS_DTAINC,      ');
      qryHisOco.SQL.Add('  HIS_HORINC,      ');
      qryHisOco.SQL.Add('  HIS_DTAAGE,      ');
      qryHisOco.SQL.Add('  HIS_HORAGE,      ');
      qryHisOco.SQL.Add('  HIS_DTACON,      ');
      qryHisOco.SQL.Add('  HIS_HORCON,      ');
      qryHisOco.SQL.Add('  HIS_OPEHIS,      ');
      qryHisOco.SQL.Add('  HIS_CODOPE,      ');
      qryHisOco.SQL.Add('  HIS_CODEMP,      ');
      qryHisOco.SQL.Add('  HIS_DESCRI,      ');
      qryHisOco.SQL.Add('  HIS_NUMDOC,      ');
      qryHisOco.SQL.Add('  HIS_ESPDOC,      ');
      qryHisOco.SQL.Add('  HIS_NUMROM,      ');
      qryHisOco.SQL.Add('  HIS_CODCOC,      ');
      qryHisOco.SQL.Add('  HIS_CODTOC,      ');
      qryHisOco.SQL.Add('  HIS_CODSIT,      ');
      qryHisOco.SQL.Add('  HIS_EMPFAT,      ');
      qryHisOco.SQL.Add('  AUTOINCREM,      ');
      qryHisOco.SQL.Add('  HIS_SEQLAG,      ');
      qryHisOco.SQL.Add('  HIS_PARCEL,      ');
      qryHisOco.SQL.Add('  HIS_CODTEA       ');
      qryHisOco.SQL.Add(') VALUES (         ');
      qryHisOco.SQL.Add('  :CODHIS,         ');
      qryHisOco.SQL.Add('  :CODOCO,         ');
      qryHisOco.SQL.Add('  :DTAINC,         ');
      qryHisOco.SQL.Add('  :HORINC,         ');
      qryHisOco.SQL.Add('  :DTAAGE,         ');
      qryHisOco.SQL.Add('  :HORAGE,         ');
      qryHisOco.SQL.Add('  :DTACON,         ');
      qryHisOco.SQL.Add('  :HORCON,         ');
      qryHisOco.SQL.Add('  :OPEHIS,         ');
      qryHisOco.SQL.Add('  :CODOPE,         ');
      qryHisOco.SQL.Add('  :CODEMP,         ');
      qryHisOco.SQL.Add('  :DESCRI,         ');
      qryHisOco.SQL.Add('  :NUMDOC,         ');
      qryHisOco.SQL.Add('  :ESPDOC,         ');
      qryHisOco.SQL.Add('  :NUMROM,         ');
      qryHisOco.SQL.Add('  :CODCOC,         ');
      qryHisOco.SQL.Add('  :CODTOC,         ');
      qryHisOco.SQL.Add('  :CODSIT,         ');
      qryHisOco.SQL.Add('  :EMPFAT,         ');
      qryHisOco.SQL.Add('  :AUTOIN,         ');
      qryHisOco.SQL.Add('  :SEQLAG,         ');
      qryHisOco.SQL.Add('  :PARCEL,         ');
      qryHisOco.SQL.Add('  :CODTEA          ');
      qryHisOco.SQL.Add('  )                ');

      qryHisOco.ParamByName('CODHIS').AsString   := fGetProximoCodigoEmTransacao('HISOCO', 'HIS_CODHIS');
      qryHisOco.ParamByName('CODOCO').AsString   := FCodOco;
      qryHisOco.ParamByName('DTAINC').AsDateTime := FDtaInc;
      qryHisOco.ParamByName('HORINC').AsDateTime := FHorInc;
      qryHisOco.ParamByName('DTAAGE').AsDateTime := FDtaAge;
      qryHisOco.ParamByName('HORAGE').AsDateTime := FHorAge;

      if FDtaCon > 0 then
        qryHisOco.ParamByName('DTACON').AsDateTime := FDtaCon
      else
        qryHisOco.ParamByName('DTACON').Clear;
      if FHorCon > 0 then
        qryHisOco.ParamByName('HORCON').AsDateTime := FHorCon
      else
        qryHisOco.ParamByName('HORCON').Clear;
      qryHisOco.ParamByName('OPEHIS').AsString   := FOpeHis;
      qryHisOco.ParamByName('CODOPE').AsString   := FCodOpe;
      qryHisOco.ParamByName('DESCRI').AsString   := FDescri + '<<csq>>' + AnsiReplaceStr(FInfAdc, #13#10, '<<csq>>');
      qryHisOco.ParamByName('CODEMP').AsString   := fRetornarEmpresaMovimentacaoOcorrencia;

      if fEmptyStr(FNumDoc) then
        qryHisOco.ParamByName('NUMDOC').Clear
      else
        qryHisOco.ParamByName('NUMDOC').AsString := FNumDoc;
      if fEmptyStr(FEspDoc) then
        qryHisOco.ParamByName('ESPDOC').Clear
      else
        qryHisOco.ParamByName('ESPDOC').AsString := FEspDoc;
      if fEmptyStr(FNumRom) then
        qryHisOco.ParamByName('NUMROM').Clear
      else
        qryHisOco.ParamByName('NUMROM').AsString := FNumRom;

      If fEmptyStr(FCodCoc) Then
        qryHisOco.ParamByName('CODCOC').Clear
      Else
        qryHisOco.ParamByName('CODCOC').AsString := FCodCoc;

      If fEmptyStr(FCodSit) Then
        qryHisOco.ParamByName('CODSIT').Clear
      Else
        qryHisOco.ParamByName('CODSIT').AsString := FCodSit;

      If fEmptyStr(FEmpFat) Then
        qryHisOco.ParamByName('EMPFAT').Clear
      Else
        qryHisOco.ParamByName('EMPFAT').AsString := FEmpFat;

      If fEmptyStr(FParcel) Then
        qryHisOco.ParamByName('PARCEL').Clear
      Else
        qryHisOco.ParamByName('PARCEL').AsString := FParcel;

      If fEmptyStr(FCodToc) then
      Begin
        If (Not fEmptyStr(FParcel)) And (Not fEmptyStr(fCfgSis('OCOFIN', varString, fRetEmpCfg))) Then
          FCodToc := fCfgSis('OCOFIN', varString, fRetEmpCfg)
        Else
          FCodToc := IIF(FEspDoc = 'OR',
                         fCfgSis('VENORC', varString, fRetEmpCfg),
                         fCfgSis('VENPED', varString, fRetEmpCfg));
      End;

      qryHisOco.ParamByName('CODTOC').AsString := FCodToc;

      qryHisOco.ParamByName('AUTOIN').AsString   := fRetAutoIncrem('HISOCO', VS_strCodEmp);
      If FCodLad <> '' then
        qryHisOco.ParamByName('SEQLAG').AsString   := FCodLad
      Else
      qryHisOco.ParamByName('SEQLAG').Value   := Null;

      If fEmptyStr(FCodTea) Then
        qryHisOco.ParamByName('CODTEA').Clear
      Else
        qryHisOco.ParamByName('CODTEA').AsString := FCodTea;

      If (FGravarOcorrenciasEmLote) Then
      Begin
        FLoteOcorrencia.SQL.Add(fSQLBindParameters(qryHisOco) + ';');
        pGravarLoteOcorrencias(True);
      End
      Else
        qryHisOco.ExecSQL;

      if blnComita then
        fCommit;

      qryHisOco.Close;

      FResultadoHistoricoOcorrencia := True;
    except
      on E: Exception do
      begin
        if blnComita then
        begin
          fRollBack;
        {$IFDEF LINUX}
          WriteError('[TAtuOcoCrm.pInsereHistoricoOcorrencia] - ' +
            E.ClassName + ': ' + E.Message);
        {$ELSE }
          pMensagensErro(E.Message, '[TAtuOcoCrm.pInsereHistoricoOcorrencia]');
        {$ENDIF LINUX}
        end;

        raise;
      end;
    end;
  finally
  {$IFNDEF LINUX}
    if Assigned(qryHisOco) then
      FreeAndNil(qryHisOco);
  {$ENDIF LINUX}
  end;
end;

procedure TAtuOcoCrm.pInsereNovaOcorrencia(const blnOrigemRecorrencia: Boolean);
var
  qryInsert: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  Try
    qryInsert := fCriaQuery();

    qryInsert.Close;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add('INSERT INTO MOVOCO ');
    qryInsert.SQL.Add('(                  ');
    qryInsert.SQL.Add('  OCO_CODOCO,      ');
    qryInsert.SQL.Add('  OCO_CODTOC,      ');
    qryInsert.SQL.Add('  OCO_CODCLI,      ');
    qryInsert.SQL.Add('  OCO_DTAINC,      ');
    qryInsert.SQL.Add('  OCO_HORINC,      ');
    qryInsert.SQL.Add('  OCO_DTAAGE,      ');
    qryInsert.SQL.Add('  OCO_HORAGE,      ');
    qryInsert.SQL.Add('  OCO_DTACON,      ');
    qryInsert.SQL.Add('  OCO_HORCON,      ');
    qryInsert.SQL.Add('  OCO_OPEOCO,      ');
    qryInsert.SQL.Add('  OCO_CODOPE,      ');
    qryInsert.SQL.Add('  OCO_DESCRI,      ');
    qryInsert.SQL.Add('  OCO_CODEMP,      ');
    qryInsert.SQL.Add('  OCO_NUMDOC,      ');
    qryInsert.SQL.Add('  OCO_ESPDOC,      ');
    qryInsert.SQL.Add('  OCO_PROTOC,      ');
    qryInsert.SQL.Add('  OCO_CODCOC,      ');
    qryInsert.SQL.Add('  OCO_EMERGE,      ');
    if not fEmptyStr(FTip_Fc) Then
      qryInsert.SQL.Add('  OCO_TIP_FC,    ');
    If Not fEmptyStr(FCodAca) Then
      qryInsert.SQL.Add('  OCO_CODACA,    ');
    If Not fEmptyStr(FParcel) Then
      qryInsert.SQL.Add('   OCO_PARCEL,   ');
    qryInsert.SQL.Add('  OCO_USUINA,      ');
    qryInsert.SQL.Add('  OCO_DTAINA,      ');
    qryInsert.SQL.Add('  OCO_HORINA,      ');
    qryInsert.SQL.Add('  OCO_CODSIT,      ');
    qryInsert.SQL.Add('  OCO_C_P_F_,      ');
    qryInsert.SQL.Add('  AUTOINCREM,      ');
    If Not fEmptyStr(FSeqLag) Then
      qryInsert.SQL.Add('  OCO_SEQLAG ,   ');

    qryInsert.SQL.Add('  OCO_DTAAGO,      ');
    qryInsert.SQL.Add('  OCO_HORAGO,      ');
    qryInsert.SQL.Add('  OCO_NOMFRM,      ');
    qryInsert.SQL.Add('  OCO_ACAFAT       ');

    if fCampoExiste('MOVOCO', 'OCO_DOCAGR', True) then
      qryInsert.SQL.Add('  ,OCO_DOCAGR       ');

    qryInsert.SQL.Add(') VALUES (         ');
    qryInsert.SQL.Add('  :CODOCO,         ');
    qryInsert.SQL.Add('  :CODTOC,         ');
    qryInsert.SQL.Add('  :CODCLI,         ');
    qryInsert.SQL.Add('  :DTAINC,         ');
    qryInsert.SQL.Add('  :HORINC,         ');
    qryInsert.SQL.Add('  :DTAAGE,         ');
    qryInsert.SQL.Add('  :HORAGE,         ');
    qryInsert.SQL.Add('  :DTACON,         ');
    qryInsert.SQL.Add('  :HORCON,         ');
    qryInsert.SQL.Add('  :OPEOCO,         ');
    qryInsert.SQL.Add('  :CODOPE,         ');
    qryInsert.SQL.Add('  :DESCRI,         ');
    qryInsert.SQL.Add('  :CODEMP,         ');
    qryInsert.SQL.Add('  :NUMDOC,         ');
    qryInsert.SQL.Add('  :ESPDOC,         ');
    qryInsert.SQL.Add('  :PROTOC,         ');
    qryInsert.SQL.Add('  :CODCOC,         ');
    qryInsert.SQL.Add('  :EMERGE,         ');
    if not fEmptyStr(FTip_Fc) Then
      qryInsert.SQL.Add('  :TIP_FC,       ');
    If Not fEmptyStr(FCodAca) Then
      qryInsert.SQL.Add('  :CODACA,       ');
    If Not fEmptyStr(FParcel) Then
      qryInsert.SQL.Add('   :PARCEL,      ');
    qryInsert.SQL.Add('  :USUINA,         ');
    qryInsert.SQL.Add('  :DTAINA,         ');
    qryInsert.SQL.Add('  :HORINA,         ');
    qryInsert.SQL.Add('  :CODSIT,         ');
    qryInsert.SQL.Add('  :C_P_F_,         ');
    qryInsert.SQL.Add('  :AUTOIN,         ');
    If Not fEmptyStr(FSeqLag) Then
      qryInsert.SQL.Add(' :SEQLAG,        ');

    qryInsert.SQL.Add('  :DTAAGO,         ');
    qryInsert.SQL.Add('  :HORAGO,         ');
    qryInsert.SQL.Add('  :NOMFRM,         ');
    qryInsert.SQL.Add('  :ACAFAT          ');

    if fCampoExiste('MOVOCO', 'OCO_DOCAGR', True) then
      qryInsert.SQL.Add('  ,:DOCAGR          ');

    qryInsert.SQL.Add('  )                ');

    qryInsert.ParamByName('CODOCO').AsString := FCodOco;
    qryInsert.ParamByName('TIP_FC').AsString := FTip_Fc;
    If Not fEmptyStr(FCodAca) Then
      qryInsert.ParamByName('CODACA').AsString := FCodAca;
    If Not fEmptyStr(FParcel) Then
      qryInsert.ParamByName('PARCEL').AsString := FParcel;

    qryInsert.ParamByName('CODTOC').AsString   := FCodToc;
    qryInsert.ParamByName('CODCLI').AsString   := FCodCli;
    qryInsert.ParamByName('DTAINC').AsDateTime := FDtaInc;
    qryInsert.ParamByName('HORINC').AsDateTime := FHorInc;
    qryInsert.ParamByName('DTAAGE').AsDateTime := FDtaAge;
    qryInsert.ParamByName('HORAGE').AsDateTime := FHorAge;
    qryInsert.ParamByName('OPEOCO').AsString   := strLoginUsuarioLogado;
    qryInsert.ParamByName('CODOPE').AsString   := FCodOpe;
    qryInsert.ParamByName('DESCRI').AsString   := FDescri + '<<csq>>' + AnsiReplaceStr(FInfAdc, #13#10, '<<csq>>');
    qryInsert.ParamByName('CODEMP').AsString   := FCodEmp;
    qryInsert.ParamByName('NUMDOC').AsString   := FNumDoc;
    qryInsert.ParamByName('ESPDOC').AsString   := FEspDoc;
    qryInsert.ParamByName('PROTOC').AsString   := FormatDateTime('yyyymmdd',FDtaInc) +
                                                  FormatDateTime('hhmmss',FHorInc)   +
                                                  FCodOco;
    If fEmptyStr(FCodCoc) Then
      qryInsert.ParamByName('CODCOC').Clear
    Else
      qryInsert.ParamByName('CODCOC').AsString := FCodCoc;

    If fEmptyStr(FCodSit) Then
      qryInsert.ParamByName('CODSIT').Clear
    Else
      qryInsert.ParamByName('CODSIT').AsString := FCodSit;

    If fEmptyStr(FCpfCli) Then
      qryInsert.ParamByName('C_P_F_').Clear
    Else
      qryInsert.ParamByName('C_P_F_').AsString := FCpfCli;

    qryInsert.ParamByName('EMERGE').AsString   := 'N';
    qryInsert.ParamByName('USUINA').AsString   := strLoginUsuarioLogado;
    qryInsert.ParamByName('DTAINA').AsDate     := VS_Date;
    qryInsert.ParamByName('HORINA').AsTime     := fTime();
    qryInsert.ParamByName('AUTOIN').AsString   := FAutInc;
    qryInsert.ParamByName('DTAAGO').AsDateTime := FDtaAge;
    qryInsert.ParamByName('HORAGO').AsDateTime := FHorAge;
    If Not fEmptyStr(FSeqLag) Then
      qryInsert.ParamByName('SEQLAG').AsString   := FSeqLag;
    qryInsert.ParamByName('NOMFRM').AsString := FNomForm;
    qryInsert.ParamByName('ACAFAT').AsString := FAcaFat.fGetDescricao();

    if fCampoExiste('MOVOCO', 'OCO_DOCAGR', True) then
      qryInsert.ParamByName('DOCAGR').AsString := IIF(FblnAgrPed, 'S', 'N');

    qryInsert.ExecSQL;

    If blnOrigemRecorrencia Then
    Begin
      FDescri := FDescri + ' - Gerado automaticamente';
      pInsereHistoricoOcorrencia;
    End;

  Finally
    qryInsert.Close;
{$IFNDEF LINUX}
    FreeAndNil(qryInsert);
{$ENDIF LINUX}
  End;
end;

procedure TAtuOcoCrm.pLimpar;
begin
  FCodOco := '';
  FDtaInc := 0;
  FHorInc := 0;
  FDtaAge := 0;
  FHorAge := 0;
  FDtaCon := 0;
  FHorCon := 0;
  FOpeHis := ''; // Operador que fez a ocorrencia
  FCodOpe := ''; // Operador de destino da ocorrencia
  FDescri := '';
  FInfAdc := '';

  //informacoes usadas pelo Faturamento
  FNumDoc := '';
  FEspDoc := '';
  FCodEmp := '';
  FCodCli := '';
  FCodPro := '';
  FNumOrc := '';
  FEspOrc := '';
  FAcaFat := afcNenhum;
  FNumRom := '';
  FCodMot := '';
  FCodTra := '';
  FDHBaix := '';
  FNomRec := '';

  //informacoes usadas pela devolucao de produtos
  FNumDev := '';
  FGerCol := '';
  FCdsDev := nil;
  FSeqGer := '';

  //informacao usada pela impressao de etiquetas do cliente
  FCliVen := '';
  FCodToc := '';
  FCodCoc := '';
  SetLength(ArrCliImpEti,0);
  FCliPriVen := '';

  FMensagemCancelamento := '';
  FDocumentosCancelamento := '';
  blnOrcamentoTransformadoEmPedido := False;
  FReabreOcorrencia := False;

  FResultadoNovaOcorrencia := False;
  FResultadoHistoricoOcorrencia := False;
  FBlnAtualizarCliente := False;
  FblnImpSfa := False;
  FblnRecarregarOcoGravarMsg := True;
  FBlnVendaDesmembrada := False;
  FEmpOri := EmptyStr;

  FFulFillment := False;
  FblnAgrPed := False;
  FblnFinalizarOcoParcial := False;
  FFinalizaOcorrenciaPdOriginal := False;
  FGerandoNovoPedido := False;
end;

procedure TAtuOcoCrm.setCdsDev(const Value: {$IFDEF LINUX} TClientDataSet {$ELSE } TUniClientDataSet {$ENDIF LINUX});
begin
  If FCdsDev <> Value Then
    FCdsDev := Value;
end;

procedure TAtuOcoCrm.SetCliAnt(const Value: String);
begin
  If (FCodCliAnt <> Value) Then
    FCodCliAnt := Value;
end;

procedure TAtuOcoCrm.setCliPriVen(const Value: String);
begin
  If (FCliPriVen <> Value) Then
    FCliPriVen := Value;
end;

procedure TAtuOcoCrm.setCliVen(const Value: String);
begin
  If (FCliVen <> Value) Then
    FCliVen := Value;
end;

procedure TAtuOcoCrm.setCodAca(const Value: String);
begin
  If (FCodAca <> Value) Then
    FCodAca := Value;
end;

procedure TAtuOcoCrm.setCodCli(const Value: String);
begin
  If (FCodCli <> Value) Then
    FCodCli := Value;
end;

procedure TAtuOcoCrm.setCodCoc(const Value: String);
begin
  If (FCodCoc <> Value) Then
    FCodCoc := Value;
end;

procedure TAtuOcoCrm.setCodEmp(const Value: String);
begin
  If (FCodEmp <> Value) Then
    FCodEmp := Value;
end;

procedure TAtuOcoCrm.SetCodFaz(const Value: String);
begin
  FCodFaz := Value;
end;

procedure TAtuOcoCrm.SetCodGoc(const Value: String);
begin
  FCodGoc := Value;
end;

procedure TAtuOcoCrm.SetCodLad(const Value: String);
begin
  If (FCodLad <> Value) Then
    FCodLad := Value;
end;

procedure TAtuOcoCrm.setCodMot(const Value: String);
begin
  If (FCodMot <> Value) Then
    FCodMot := Value;
end;

procedure TAtuOcoCrm.setCodOco(const Value: String);
begin
  If (FCodOco <> Value) Then
    FCodOco := Value;
end;

procedure TAtuOcoCrm.setCodOpe(const Value: String);
begin
  If (FCodOpe <> Value) Then
    FCodOpe := Value;
end;

procedure TAtuOcoCrm.SetCodPro(const Value: String);
begin
  If (FCodPro <> Value) Then
    FCodPro := Value;
end;

procedure TAtuOcoCrm.SetCodSit(const Value: String);
begin
  FCodSit := Value;
end;

procedure TAtuOcoCrm.SetCodTea(const Value: String);
begin
  FCodTea := Value;

  If Not fEmptyStr(FCodTea) Then
    FDesTea := fCampoTabela('TEA_DESCRI', 'CADTEA', ['TEA_CODIGO'], [FCodTea]);
end;

procedure TAtuOcoCrm.setCodToc(const Value: String);
begin
  If (FCodToc <> Value) Then
    FCodToc := Value;
end;

procedure TAtuOcoCrm.setCodTra(const Value: String);
begin
  If (FCodTra <> Value) Then
    FCodTra := Value;
end;

procedure TAtuOcoCrm.setCpfCli(const Value: String);
begin
  If (FCpfCli <> Value) then
    FCpfCli := Value;
end;

procedure TAtuOcoCrm.SetDesCoc(const Value: String);
begin
  FDesCoc := Value;
end;

procedure TAtuOcoCrm.setDescri(const Value: String);
begin
  If (FDescri <> Value) Then
    FDescri := Value;
end;

procedure TAtuOcoCrm.SetDesGoc(const Value: String);
begin
  FDesGoc := Value;
end;

procedure TAtuOcoCrm.SetDesSit(const Value: String);
begin
  FDesSit := Value;
end;

procedure TAtuOcoCrm.SetDesTea(const Value: String);
begin
  FDesTea := Value;
end;

procedure TAtuOcoCrm.SetDesToc(const Value: String);
begin
  FDesToc := Value;
end;

procedure TAtuOcoCrm.setInfAdc(const Value: String);
begin
  If (FInfAdc <> Value) Then
    FInfAdc := Value;
end;

procedure TAtuOcoCrm.SetMailCli(const Value: String);
begin
  FEmailCli := Value;
end;

procedure TAtuOcoCrm.SetMailDe(const Value: String);
begin
  FEmailDesci := Value;
end;

procedure TAtuOcoCrm.SetMailUsu(const Value: String);
begin
  FEmailUsu := Value;
end;

procedure TAtuOcoCrm.SetNomCli(const Value: String);
begin
  FNomCli := Value;
end;

procedure TAtuOcoCrm.SetNomFrm(const Value: String);
begin
  FNomForm := Value;
end;

procedure TAtuOcoCrm.setDHBaix(const Value: String);
begin
  If (FDHBaix <> Value) Then
    FDHBaix := Value;
end;

procedure TAtuOcoCrm.setDocumentosCancelamento(const Value: String);
begin
  If (FDocumentosCancelamento <> Value) Then
    FDocumentosCancelamento := Value;
end;

procedure TAtuOcoCrm.setNomRec(const Value: String);
begin
  If (FNomRec <> Value) Then
    FNomRec := Value;
end;

procedure TAtuOcoCrm.setDtaAge(const Value: TDateTime);
begin
  If (FDtaAge <> Value) Then
    FDtaAge := Value;
end;

procedure TAtuOcoCrm.setDtaCon(const Value: TDateTime);
begin
  If (FDtaCon <> Value) Then
    FDtaCon := Value;
end;

procedure TAtuOcoCrm.setDtaInc(const Value: TDateTime);
begin
  If (FDtaInc <> Value) Then
    FDtaInc := Value;
end;

procedure TAtuOcoCrm.setEmpFat(const Value: String);
begin
  If (FEmpFat <> Value) Then
    FEmpFat := Value;
end;

procedure TAtuOcoCrm.SetEmpOri(const Value: String);
begin
  FEmpOri := Value;
end;

procedure TAtuOcoCrm.SetEnvCli(const Value: Boolean);
begin
  FBlnEnvCli := Value;
end;

procedure TAtuOcoCrm.SetEnvUsu(const Value: Boolean);
begin
  FBlnEnvUsu := Value;
end;

procedure TAtuOcoCrm.setEspDoc(const Value: String);
begin
  If (FEspDoc <> Value) Then
    FEspDoc := Value;
end;

procedure TAtuOcoCrm.setEspOrc(const Value: String);
begin
  If (FEspOrc <> Value) Then
    FEspOrc := Value;
end;

procedure TAtuOcoCrm.SetFulFillment(const AFulFillment: Boolean);
begin
  FFulFillment := AFulFillment;
end;

procedure TAtuOcoCrm.SetFinalizaOcorrenciaPdOriginal(const Value: Boolean);
begin
  FFinalizaOcorrenciaPdOriginal := Value;
end;

procedure TAtuOcoCrm.SetFoneCli(const Value: String);
begin
  If FFoneCli <> Value Then
    FFoneCli := Value;
end;

procedure TAtuOcoCrm.setAcaFat(const Value: TAcaoFatCRM);
begin
  If (FAcaFat <> Value) Then
    FAcaFat := Value;
end;

procedure TAtuOcoCrm.SetArqDev(const Value: String);
begin
  FArqDev := Value;
end;

procedure TAtuOcoCrm.SetAssunt(const Value: String);
begin
  FAssunt := Value;
end;

procedure TAtuOcoCrm.setAutInc(const Value: String);
begin
  FAutInc := Value;
end;

procedure TAtuOcoCrm.SetBlnMltOpe(const Value: Boolean);
begin
  If (FBlnMsgMultiplosDestinatarios <> Value) Then
    FBlnMsgMultiplosDestinatarios := Value;
end;

procedure TAtuOcoCrm.SetblnPd_Dsm(const Value: Boolean);
begin
  FblnPDGeradoDesmembramento := Value;
end;

procedure TAtuOcoCrm.setHorAge(const Value: TDateTime);
begin
  If (FHorAge <> Value) Then
    FHorAge := Value;
end;

procedure TAtuOcoCrm.setHorCon(const Value: TDateTime);
begin
  If (FHorCon <> Value) Then
    FHorCon := Value;
end;

procedure TAtuOcoCrm.setHorInc(const Value: TDateTime);
begin
  If (FHorInc <> Value) Then
    FHorInc := Value;
end;

procedure TAtuOcoCrm.SetblnAdeGar(const Value: Boolean);
begin
  FblnAdGarantia := Value;
end;

procedure TAtuOcoCrm.SetblnAgrp(const Value: Boolean);
begin
  FblnAgrPed := Value;
end;

procedure TAtuOcoCrm.SetblnDocHer(const Value: Boolean);
begin
  FBlnDocHer := Value;
end;

procedure TAtuOcoCrm.SetblnEmerge(const Value: Boolean);
begin
  FblnEmerge := Value;
end;

procedure TAtuOcoCrm.SetBlnFinParc(const Value: Boolean);
begin
  FblnFinalizarOcoParcial := Value;
end;

procedure TAtuOcoCrm.SetblnImpSfa(const Value: Boolean);
begin
  FblnImpSfa := Value;
end;

procedure TAtuOcoCrm.setNumDev(const Value: String);
begin
  If (FNumDev <> Value) Then
    FNumDev := Value;
end;

procedure TAtuOcoCrm.setGerCol(const Value: String);
begin
  If (FGerCol <> Value) Then
    FGerCol := Value;
end;

procedure TAtuOcoCrm.setNumDoc(const Value: String);
begin
  If (FNumDoc <> Value) Then
    FNumDoc := Value;
end;

procedure TAtuOcoCrm.setNumOrc(const Value: String);
begin
  If (FNumOrc <> Value) Then
    FNumOrc := Value;
end;

procedure TAtuOcoCrm.setNumRom(const Value: String);
begin
  If (FNumRom <> Value) Then
    FNumRom := Value;
end;

procedure TAtuOcoCrm.SetOpeDes(const Value: String);
begin
  FNomOpe_Des := Value;
end;

procedure TAtuOcoCrm.setOpeHis(const Value: String);
begin
  If (FOpeHis <> Value) Then
    FOpeHis := Value;
end;

procedure TAtuOcoCrm.SetOpeOri(const Value: String);
begin
  FNomOpe_Ori := Value;
end;

procedure TAtuOcoCrm.SetPrevis(const Value: String);
begin
  FPrevis := Value;
end;

procedure TAtuOcoCrm.SetProtocolo(const Value: String);
begin
  FProtoc := Value;
end;

procedure TAtuOcoCrm.setReabreOcorrencia(const Value: Boolean);
begin
  If (FReabreOcorrencia <> Value) Then
    FReabreOcorrencia := Value;
end;

{procedure TAtuOcoCrm.setQtdIte(const Value: Double);
begin
  If (FQtdIte <> Value) Then
    FQtdIte := Value;
end;}

procedure TAtuOcoCrm.setSeqGer(const Value: String);
begin
  If (FSeqGer <> Value) Then
    FSeqGer := Value;
end;

procedure TAtuOcoCrm.SetSeqLag(const Value: String);
begin
  FSeqLag  := Value;
end;

procedure TAtuOcoCrm.SetStrmltOpe(const Value: String);
begin
  If (FstrOperadoresDestino <> Value) Then
    FstrOperadoresDestino := Value;
end;

procedure TAtuOcoCrm.SetTip_Fc(const Value: String);
begin
  FTip_Fc := Value;
end;

procedure TAtuOcoCrm.pInsereNovaOcorrencia;
var
  blnComita: Boolean;
  blnCadFazenda : Boolean;
  LCliNome: String;
  LCliEmail: String;
  LCliFone: String;
begin
  blnCadFazenda := fCfgSis('CADFAZ', varBoolean, fRetEmpCfg);
  qryHisOco := Nil;
  try
    FResultadoNovaOcorrencia := False;

    blnComita := false;

    if (not fInTransaction) then
    begin
      fStartTransaction;
      blnComita := true;
    end;

    try
      qryHisOco := fCriaQuery();

      qryHisOco.Close;
      qryHisOco.SQL.Clear;
      qryHisOco.SQL.Add('INSERT INTO MOVOCO ');
      qryHisOco.SQL.Add('(                  ');
      qryHisOco.SQL.Add('  OCO_CODOCO,      ');
      qryHisOco.SQL.Add('  OCO_CODTOC,      ');
      qryHisOco.SQL.Add('  OCO_CODCLI,      ');
      qryHisOco.SQL.Add('  OCO_DTAINC,      ');
      qryHisOco.SQL.Add('  OCO_HORINC,      ');
      qryHisOco.SQL.Add('  OCO_DTAAGE,      ');
      qryHisOco.SQL.Add('  OCO_HORAGE,      ');
      qryHisOco.SQL.Add('  OCO_DTACON,      ');
      qryHisOco.SQL.Add('  OCO_HORCON,      ');
      qryHisOco.SQL.Add('  OCO_OPEOCO,      ');
      qryHisOco.SQL.Add('  OCO_CODOPE,      ');
      qryHisOco.SQL.Add('  OCO_DESCRI,      ');
      qryHisOco.SQL.Add('  OCO_CODEMP,      ');
      qryHisOco.SQL.Add('  OCO_NUMDOC,      ');
      qryHisOco.SQL.Add('  OCO_ESPDOC,      ');
      qryHisOco.SQL.Add('  OCO_PROTOC,      ');
      qryHisOco.SQL.Add('  OCO_CODCOC,      ');
      qryHisOco.SQL.Add('  OCO_EMERGE,      ');
      if not fEmptyStr(FTip_Fc) Then
        qryHisOco.SQL.Add('  OCO_TIP_FC,    ');
      If Not fEmptyStr(FCodAca) Then
        qryHisOco.SQL.Add('  OCO_CODACA,    ');
      If Not fEmptyStr(FParcel) Then
        qryHisOco.SQL.Add('   OCO_PARCEL,   ');
      //campos da auditoria
      qryHisOco.SQL.Add('  OCO_USUINA,      ');
      qryHisOco.SQL.Add('  OCO_DTAINA,      ');
      qryHisOco.SQL.Add('  OCO_HORINA,      ');
      qryHisOco.SQL.Add('  OCO_CODSIT,      ');
      qryHisOco.SQL.Add('  OCO_C_P_F_,      ');
      qryHisOco.SQL.Add('  AUTOINCREM,      ');
      qryHisOco.SQL.Add('  OCO_DTAAGO,      ');
      qryHisOco.SQL.Add('  OCO_HORAGO,      ');
      qryHisOco.SQL.Add('  OCO_ACAFAT,      ');
      qryHisOco.SQL.Add('  OCO_NOMFRM       ');

      if fCampoExiste('MOVOCO', 'OCO_DOCAGR', True) then
        qryHisOco.SQL.Add('  ,OCO_DOCAGR       ');

      qryHisOco.SQL.Add(') VALUES (         ');
      qryHisOco.SQL.Add('  :CODOCO,         ');
      qryHisOco.SQL.Add('  :CODTOC,         ');
      qryHisOco.SQL.Add('  :CODCLI,         ');
      qryHisOco.SQL.Add('  :DTAINC,         ');
      qryHisOco.SQL.Add('  :HORINC,         ');
      qryHisOco.SQL.Add('  :DTAAGE,         ');
      qryHisOco.SQL.Add('  :HORAGE,         ');
      qryHisOco.SQL.Add('  :DTACON,         ');
      qryHisOco.SQL.Add('  :HORCON,         ');
      qryHisOco.SQL.Add('  :OPEOCO,         ');
      qryHisOco.SQL.Add('  :CODOPE,         ');
      qryHisOco.SQL.Add('  :DESCRI,         ');
      qryHisOco.SQL.Add('  :CODEMP,         ');
      qryHisOco.SQL.Add('  :NUMDOC,         ');
      qryHisOco.SQL.Add('  :ESPDOC,         ');
      qryHisOco.SQL.Add('  :PROTOC,         ');
      qryHisOco.SQL.Add('  :CODCOC,         ');
      qryHisOco.SQL.Add('  :EMERGE,         ');
      if not fEmptyStr(FTip_Fc) Then
        qryHisOco.SQL.Add('  :TIP_FC,       ');
      If Not fEmptyStr(FCodAca) Then
        qryHisOco.SQL.Add('  :CODACA,       ');
      If Not fEmptyStr(FParcel) Then
        qryHisOco.SQL.Add('   :PARCEL,      ');
      //campos da auditoria
      qryHisOco.SQL.Add('  :USUINA,         ');
      qryHisOco.SQL.Add('  :DTAINA,         ');
      qryHisOco.SQL.Add('  :HORINA,         ');
      qryHisOco.SQL.Add('  :CODSIT,         ');
      qryHisOco.SQL.Add('  :C_P_F_,         ');
      qryHisOco.SQL.Add('  :AUTOIN,         ');
      qryHisOco.SQL.Add('  :DTAAGO,         ');
      qryHisOco.SQL.Add('  :HORAGO,         ');
      qryHisOco.SQL.Add('  :ACAFAT,         ');
      qryHisOco.SQL.Add('  :NOMFRM          ');

      if fCampoExiste('MOVOCO', 'OCO_DOCAGR', True) then
        qryHisOco.SQL.Add('  ,:DOCAGR          ');

      qryHisOco.SQL.Add('  )                ');

      strCodOco := fGetProximoCodigoEmTransacao('MOVOCO', 'OCO_CODOCO');
      strDtaInc := VS_Date;
      strHorInc := fRetHoraServidor();
      strDtaAge := IIF((strDtaAge = 0), strDtaInc, strDtaAge);
      strHorAge := IIF((strHorAge = 0), strHorInc, strHorAge);

      If SameText(strTip_FC, 'P') Then
      Begin
        LCliNome  := iif(fEmptyStr(FNomCli), fRetNomCliente(FCodCli), FNomCli);
        LCliEmail := FEmailCli;
        LCliFone  := FFoneCli;
      End
      Else
      Begin
        LCliNome  := fRetNomCliente(FCodCli);
        LCliEmail := fRetornaEmailsCliente(FCodCli);
        LCliFone  := fRetornaTelefonesCliente(FCodCli);
      End;

      strOpeHis := strLoginUsuarioLogado;
      if fEmptyStr(FDescri) Then
        strDescri := IIF((Not fEmptyStr(FParcel)), FAcaFat.fGetDescricao(),
                     'NOVO ' + FAcaFat.fGetDescricao() + ' CRIADO.') + '<<csq>>'  +
                     'Número Documento : ' + FNumDoc + '<<csq>>' +
                     'Espécie          : ' + FEspDoc + '<<csq>>' +
                     'Empresa          : ' + FCodEmp + '<<csq>>'+
                     '<<csq>>' +
                     'Cliente          : ' + FCodCli + '-' + LCliNome + '<<csq>>'+
                     'Telefones        : ' + LCliFone +  '<<csq>>'+
                     'E-Mail           : ' + LCliEmail +  '<<csq>>'+

                     IIF((blnCadFazenda) And (Not fEmptyStr(FCodFaz)),
                     'Fazenda          : ' + FCodFaz + '-' + fCampoTabela('FAZ_NOMFAZ', 'CADFAZ', ['FAZ_CODFAZ'], [FCodFaz], False) + '<<csq>>', '')+

                     '<<csq>>' +
                     IIF((Not fEmptyStr(FParcel)),'Parcela          : ' + FParcel + '<<csq>>','') +
                      fDadosConsumidor+
                     '<<csq>>' +
                     'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                     DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc)  + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe);
      If fCfgSis('SEGCND', varBoolean, fRetEmpCfg) or fCfgSis('HABENT', varBoolean, fRetEmpCfg) Then
        If Not fEmptyStr(FPrevis) Then
          strDescri := strDescri + '<<csq>>' +  'Data de Previsão do Documento : ' + FPrevis +  '<<csq>>';

      strDescri := strDescri + IIF(FblnAgrPed,
                                   '<<csq>>' + 'Documento originado a partir de agrupamento de pedidos' +  '<<csq>>',
                                   '');

      qryHisOco.ParamByName('CODOCO').AsString   := FCodOco;

      If (fEmptyStr(FCodToc)) And (Not fCarregaCodToc(fRetEmpCfg)) Then
        Raise Exception.Create('Não foi possível inserir uma nova ocorrência no CRM para o documento. '+
                               'Defina o tipo de ocorrência nas configurações da empresa ' + fRetEmpCfg + '.');

      if not fEmptyStr(FTip_Fc) Then
        qryHisOco.ParamByName('TIP_FC').AsString := FTip_Fc;
      If Not fEmptyStr(FCodAca) Then
        qryHisOco.ParamByName('CODACA').AsString := FCodAca;
      If Not fEmptyStr(FParcel) Then
        qryHisOco.ParamByName('PARCEL').AsString := FParcel;

      qryHisOco.ParamByName('CODTOC').AsString := FCodToc;
      If (FTip_Fc = 'P') And (Not fEmptyStr(FCodPro)) Then
        qryHisOco.ParamByName('CODCLI').AsString := FCodPro
      Else
        qryHisOco.ParamByName('CODCLI').AsString := FCodCli;
      qryHisOco.ParamByName('DTAINC').AsDateTime := FDtaInc;
      qryHisOco.ParamByName('HORINC').AsDateTime := FHorInc;
      qryHisOco.ParamByName('DTAAGE').AsDateTime := FDtaAge;
      qryHisOco.ParamByName('HORAGE').AsDateTime := FHorAge;
      if FDtaCon > 0 then
        qryHisOco.ParamByName('DTACON').AsDateTime := FDtaCon
      else
        qryHisOco.ParamByName('DTACON').Clear;
      if FHorCon > 0 then
        qryHisOco.ParamByName('HORCON').AsDateTime := FHorCon
      else
        qryHisOco.ParamByName('HORCON').Clear;
      qryHisOco.ParamByName('OPEOCO').AsString   := strLoginUsuarioLogado;
      qryHisOco.ParamByName('CODOPE').AsString   := FCodOpe;
      qryHisOco.ParamByName('DESCRI').AsString   := FDescri + '<<csq>>' + AnsiReplaceStr(FInfAdc, #13#10, '<<csq>>');
      qryHisOco.ParamByName('CODEMP').AsString   := FCodEmp;
      qryHisOco.ParamByName('NUMDOC').AsString   := FNumDoc;
      qryHisOco.ParamByName('ESPDOC').AsString   := FEspDoc;
      qryHisOco.ParamByName('PROTOC').AsString   := FormatDateTime('yyyymmdd',FDtaInc) +
                                                    FormatDateTime('hhmmss',FHorInc)   +
                                                    FCodOco;
      If fEmptyStr(FCodCoc) Then
        qryHisOco.ParamByName('CODCOC').Clear
      Else
        qryHisOco.ParamByName('CODCOC').AsString := FCodCoc;

      If fEmptyStr(FCodSit) Then
        qryHisOco.ParamByName('CODSIT').Clear
      Else
        qryHisOco.ParamByName('CODSIT').AsString := FCodSit;

      If fEmptyStr(FCpfCli) Then
        qryHisOco.ParamByName('C_P_F_').Clear
      Else
        qryHisOco.ParamByName('C_P_F_').AsString := FCpfCli;

      qryHisOco.ParamByName('EMERGE').AsString   := IIF(FblnEmerge, 'S', 'N');

      //campos da auditoria
      qryHisOco.ParamByName('USUINA').AsString   := strLoginUsuarioLogado;
      qryHisOco.ParamByName('DTAINA').AsDate     := VS_Date;
      qryHisOco.ParamByName('HORINA').AsTime     := fTime();
      qryHisOco.ParamByName('AUTOIN').AsString   := fRetAutoIncrem('MOVOCO', VS_strCodEmp);
      qryHisOco.ParamByName('DTAAGO').AsDateTime := FDtaAge;
      qryHisOco.ParamByName('HORAGO').AsDateTime := FHorAge;
      qryHisOco.ParamByName('NOMFRM').AsString   := FNomForm;
      qryHisOco.ParamByName('ACAFAT').AsString   := FAcaFat.fGetDescricao();

      if fCampoExiste('MOVOCO', 'OCO_DOCAGR', True) then
        qryHisOco.ParamByName('DOCAGR').AsString   := IIF(FblnAgrPed, 'S', 'N');

      qryHisOco.ExecSQL;

      if blnComita then
        fCommit;

      qryHisOco.Close;

      pGravarMensagemOperadorOcorrencia(tpInclusao, FCodOco, FCodEmp, FTip_Fc);

      FResultadoNovaOcorrencia := True;
    except
      on E: Exception do
      begin
        if blnComita then
        begin
          fRollBack;
        {$IFDEF LINUX}
          WriteError('[TAtuOcoCrm.pInsereNovaOcorrencia] - ' +
            E.ClassName +  ': ' + E.Message);
        {$ELSE }
          pMensagensErro(E.Message, '[TAtuOcoCrm.pInsereNovaOcorrencia]');
        {$ENDIF LINUX}
        end;

        raise;
      end;
    end;
  finally
{$IFNDEF LINUX}
    if Assigned(qryHisOco) then
      FreeAndNil(qryHisOco);
{$ENDIF LINUX}
  end;
end;

function TAtuOcoCrm.fCarregaCodToc(strCodEmpDoc: String): Boolean;
  Var
    strOcoDmp: String;
    strOcoFin: String;
begin
  strOcoDmp := fCfgSis('OCODMP', varString, strCodEmpDoc);
  strOcoFin := fCfgSis('OCOFIN', varString, strCodEmpDoc);

  If (FAcaFat = afcPedidoCorte) And (Not fEmptyStr(strOcoDmp)) Then
    FCodToc := strOcoDmp
  Else If (Not fEmptyStr(FParcel)) And (Not fEmptyStr(strOcoFin)) Then
    FCodToc := strOcoFin
  Else
    FCodToc := IIF(FEspDoc = 'OR', fCfgSis('VENORC', varString, strCodEmpDoc),
      fCfgSis('VENPED', varString, strCodEmpDoc));

  Result := (Not fEmptyStr(FCodToc));
end;

class function TAtuOcoCrm.fEmpresaUsaCRM(strCodEmpDoc: String): Boolean;
begin
  Result := fCfgSis('UTICRM', varBoolean, strCodEmpDoc);
end;

procedure TAtuOcoCrm.pInserirOcorrenciaEmergencial(Var ArrayOperadores:
  {$IFDEF LINUX} TStringArray {$ELSE } Array Of String {$ENDIF LINUX};
  strOcorrencia, strEmpresa: String);
Begin
  FArrayOperadores := {$IFDEF LINUX} ArrayOperadores {$ELSE } @ArrayOperadores {$ENDIF LINUX};
  FOcorrencia      := strOcorrencia;
  FEmpresa         := strEmpresa;

{$IFDEF LINUX}
  fInserirOcorrenciaEmergencialInterna;
{$ELSE }
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fInserirOcorrenciaEmergencialInterna;
    frmGravando.lblGravando.Caption := 'Aguarde, gerando ocorrência emergencial...';
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
{$ENDIF LINUX}
End;

function TAtuOcoCrm.fInserirOcorrenciaEmergencialInterna({$IFNDEF LINUX} cxProgress : TCxProgressBar{$ENDIF LINUX}):Boolean;
var
  qryOcoEme: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  intCont: Integer;
begin
  Result := True;
  Try
    qryOcoEme := fCriaQuery();

    qryOcoEme.Close;
    qryOcoEme.SQL.Clear;
    qryOcoEme.SQL.Add(' DELETE FROM OCOEME ');
    qryOcoEme.SQL.Add('  WHERE EME_CODOCO = :CODOCO');
    qryOcoEme.SQL.Add('    AND EME_CODEMP = :CODEMP');
    qryOcoEme.ParamByName('CODOCO').AsString := FOcorrencia;
    qryOcoEme.ParamByName('CODEMP').AsString := FEmpresa;
    qryOcoEme.ExecSQL;

    qryOcoEme.Close;
    qryOcoEme.SQL.Clear;
    qryOcoEme.SQL.Add(' INSERT INTO OCOEME ');
    qryOcoEme.SQL.Add(' (                  ');
    qryOcoEme.SQL.Add('   EME_CODOCO, ');
    qryOcoEme.SQL.Add('   EME_CODEMP, ');
    qryOcoEme.SQL.Add('   EME_CODOPE, ');
    qryOcoEme.SQL.Add('   AUTOINCREM  ');
    qryOcoEme.SQL.Add(' ) VALUES (    ');
    qryOcoEme.SQL.Add('   :CODOCO,    ');
    qryOcoEme.SQL.Add('   :CODEMP,    ');
    qryOcoEme.SQL.Add('   :CODOPE,    ');
    qryOcoEme.SQL.Add('   :AUTOIN)    ');

  {$IFNDEF LINUX}
    cxProgress.Properties.Max := Length(FArrayOperadores) - 1;
  {$ENDIF LINUX}

    For intCont := 0 To Length(FArrayOperadores) - 1 Do
    Begin
      qryOcoEme.ParamByName('CODOCO').AsString := FOcorrencia;
      qryOcoEme.ParamByName('CODEMP').AsString := FEmpresa;
      qryOcoEme.ParamByName('CODOPE').AsString := FArrayOperadores[intCont];
      qryOcoEme.ParamByName('AUTOIN').AsString := fRetAutoIncrem('OCOEME', VS_strCodEmp);
      qryOcoEme.ExecSQL;

    {$IFNDEF LINUX}
      cxProgress.Position := intCont;
      Application.ProcessMessages;
    {$ENDIF LINUX}
    End;

  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryOcoEme);
{$ENDIF LINUX}
  End;
end;

function TAtuOcoCrm.fObtemDadosDocumentoOcorrencia(const aStrCodEmp, aStrEspDoc,
  aStrNumDoc: String): Boolean;
begin
  Result := False;

  Case AnsiIndexStr(aStrEspDoc, [ 'OR', 'PD'] ) of
    0,
    1  : Result :=  fObtemDadosPedidoOrcamento(aStrCodEmp, aStrEspDoc, aStrNumDoc)
  End;
end;

function TAtuOcoCrm.fObtemDadosPedidoOrcamento(const aStrCodEmp, aStrEspDoc,
  aStrNumDoc: String): Boolean;
const
  strSQL = 'SELECT FGO_PREVIS ' +
             'FROM FATGOR ' +
           'WHERE FGO_CODEMP = :CODEMP ' +
           '  AND FGO_ESPDOC = :ESPDOC ' +
           '  AND FGO_NUMDOC = :NUMDOC ';
var
  qryConsulta: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  Result := True;

  If Not fCfgSis('SEGCND', varBoolean) and Not fCfgSis('HABENT', varBoolean) Then
    Exit;

  qryConsulta := fCriaQuery;
  Try
  {$IFNDEF LINUX}
    qryConsulta.DisableControls;
  {$ENDIF LINUX}
    Try
      qryConsulta.SQL.Add(strSQL);
      qryConsulta.ParamByName('CODEMP').AsString := aStrCodEmp;
      qryConsulta.ParamByName('ESPDOC').AsString := aStrEspDoc;
      qryConsulta.ParamByName('NUMDOC').AsString := aStrNumDoc;
      qryConsulta.Open;
      If Not(qryConsulta.IsEmpty) Then
      Begin
        FPrevis := DateTimeToStr(qryConsulta.FieldByName('FGO_PREVIS').AsDateTime);
      End;
    Except
      Raise;
    End;
  Finally
    qryConsulta.Close;
{$IFNDEF LINUX}
    FreeAndNil(qryConsulta);
{$ENDIF LINUX}
  End;
end;

function TAtuOcoCrm.fOcorrenciaFinalizada(const ACodOco: String): Boolean;
begin
  Result := (fCampoTabela('OCO_DTACON', 'MOVOCO', ['OCO_CODOCO', 'OCO_CODEMP'], [ACodOco, FCodEmp]) > 0);
end;

procedure TAtuOcoCrm.pPreencheArrCliImpEti;
var
  intIndex: Integer;
  strCliente: String;
  strLinha: String;
begin
  strLinha := FCliVen;
  for intIndex := 0 to Length(ArrCliImpEti) - 1 do
  begin
    strCliente := Copy(strLinha,1,Pos('_',strLinha) - 1);
    strLinha   := Copy(strLinha,Pos('_',strLinha) + 1, Length(strLinha));
    if not fEmptyStr(strCliente) then
      if (not fExisteClienteArrCliImpEti(strCliente)) And (strCliente <> FCliPriVen) then
        ArrCliImpEti[intIndex] := strCliente;
  end;  
end;

function TAtuOcoCrm.fVerificaConfigTipoOcorrencia: Boolean;
begin
  Result := False;

  If (Not fEmptyStr(fCfgSis('VENORC', varString, fRetEmpCfg))) Or
     (Not fEmptyStr(fCfgSis('VENPED', varString, fRetEmpCfg))) Then
    Result := True;
end;

procedure TAtuOcoCrm.pProcessaFatOcorrenciasCRM;
begin
  If ((FAcaFat = afcBaixaPedidoNaoEntregue) And (VS_strHabilitarCRM)) Or
     ((FAcaFat <> afcBaixaPedidoNaoEntregue) And
      (FAcaFat <> afcAlteracaoCliente)) Then
  Begin
    If Not fVerificaConfigTipoOcorrencia Then
      Exit;
  End;

  Case FAcaFat Of
    afcExpedicao                  : pProcessaFatNFExpedida();
    afcPedidoAgReqCompra          : pProcessaPedidoAgReqCompra();
    afcPedidoReqCompraGerada      : pProcessaRequisicaoCompraGerada();
    afcPedidoAgCompra             : pProcessaPedidoAgCompra();
    afcReqCompraNaoVaiComprar,
    afcReqCompraPossuiEstoque     : pProcessaRequisicaoCompraNegada();
    afcReqCompraDesvinculada      : pProcessaRequisicaoCompraDesvinculada;
    afcCompraEfetuada             : pProcessaCompraEfetuada();
    afcPedidoAgPDTransferencia    : pProcessaPedidoAgPDTransferencia();
    afcPDTransferenciaGerado      : pProcessaPDTransferenciaGerado();
    afcPedidoAgTransferencia      : pProcessaPedidoAgTransferencia();
    afcPDTransferenciaFaturado    : pProcessaPDTransferenciaFaturado();
    afcPDTransferenciaBaixado     : pProcessaPDTransferenciaBaixado();
    afcPedidoAgEntrega            : pProcessaPedidoAgEntrega();
    afcPedidoCancelaPreNota,
    afcPedidoInclusaoPreNota,
    afcPedidoPreNotaConferida     : pProcessaMovimentacaoPreNota();
    afcPedidoCPAgConferencia      : pProcessaPedidoAgConferencia();
    afcPedidoAgEntrada            : pProcessaPedidoAgEntrada();
    afcPedidoEntradaMercadoria    : pProcessaEntradaMercadoria();
    afcNotaEntAgEnderecamento     : pProcessaPedidoAgEnderecamento();
    afcEnderecamentoFinalizado    : pProcessaEnderecamentoFinalizado();
    afcPedidoConferido            : pProcessaConferenciaPedido();
    afcPedidoLiberado,
    afcPedidoLiberacaoCancelado,
    afcPedidoNegado               : pProcessaLiberacaoPedido();
    afcOrcamento,
    afcPedido,
    afcPedidoCorte                : pProcessaFatOrcamentoPedido();
    afcOrcamentoEmPedido,
    afcOrcamentoFaturado,
    afcPedidoFaturadoParcial,
    afcPedidoFaturado             : pProcessaFatOrcamentoPedidoFaturado();
    afcRomaneioInclusao,
    afcRomaneioAtivacao,
    afcRomaneioAlteracao          : pProcessaFatRomaneioInclusao();
    afcRomaneioExclusao           : pProcessaFatRomaneioExclusao();
    afcRegistroOcorrenciaRomaneio : pProcessaRegistroOcorrenciaRomaneio();
    afcRomaneioBaixa,
    afcRomaneioCancelamento       : pProcessaFatRomaneioBaixa();
    afcDevolucao                  : pProcessaDevolucao();
    afcPedidoEnderecado           : pProcessaFatOrcamentoPedidoEnderecado();
    afcVendaOrcamento,
    afcVendaPedido                : pProcessaFatVendaOrcamentoPedido();
    afcPedidoAgRomaneio,
    afcExtornoSeparacao,
    afcPedidoAgSeparacao,
    afcPedidoAgFaturamento,
    afcItemDesvinculadoReqCompra,
    afcPedidoAgMovimentoFiscal,
    afcItemDesvinculadoPDTransf   : pProcessaRegistroOcorrenciaStatus();
    afcAlteracaoCliente           : pProcessaAlteracaoCliente();
    afcBaixaPedidoNaoEntregue     : pProcessaBaixaPedidoNaoEntregue;
    afcSeparacaoImpressa          : pProcessaSeparacaoImpressa;
    afcConfirmacaoDocumento       : pProcessaConfirmacaoDocumento;
    afcAlteracaoTemperaturaAtend  : pProcessaAlteracaoTemperaturaAntend;
    afcFaturaPedidoAgrupado       : pProcessaFaturamentoPedidoAgrupado;
    afcDocumentoCancelado         : pProcessaCancelamentoDocumento;
    afcReabrirDocumentoFaturado   : pProcessaReaberturaDocumentoFaturado;

    {$Region 'Ações Garantia - Recebimento Cliente'}
    afcGarantiaAndamentoPendLibCrd,
    afcGarantiaAndamentoPendEnvCli,
    afcGarantiaCancelada,
    afcGarantiaCredito,
    afcGarantiaReposicaoItemConcluida,
    afcGarantiaAndamentoPendLibCrd_Confirmacao,
    afcGarantiaAndamentoPendEnvCli_Confirmacao: pIncluirOcorrenciaGarantia;
    {$EndRegion 'Ações Garantia - Recebimento Cliente'}
  End;

  pExecutarAposProcessamentoOco;
end;

function TAtuOcoCrm.fRetornaCodigoOcorrencia(strNumDoc,strEspDoc,strCodCli,strCodEmp,strNumRom: String; strNumOrc: String = '';
                                             strEspOrc: String = ''; strParcel: String = ''; strCodToc: String = ''): String;
Begin
  Result := fRetornaCodigoOcorrenciaInterna(strNumDoc,strEspDoc,strCodCli,strCodEmp,strNumRom,
                        strNumOrc, strEspOrc, strParcel, strCodToc);

  If fEmptyStr(Result) Then
    Result := fRetornaCodigoOcorrenciaInterna(strNumDoc,strEspDoc,'',strCodEmp,strNumRom,
                        strNumOrc, strEspOrc, strParcel, strCodToc);
End;

function TAtuOcoCrm.fSQLBindParameters(qryDados: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX}): String;
  Var
    intCnt : Integer;
begin
  Result := fTiraEnter(qryDados.SQL.Text);
  For intCnt := 0 To qryDados.ParamCount-1 Do
  Begin
    If qryDados.Params[intCnt].IsNull Then
      Result := ReplaceStr(Result, ':' + qryDados.Params[intCnt].Name, 'NULL')
    Else
    Begin
      Case qryDados.Params[intCnt].DataType Of
        ftDateTime:
          Result := ReplaceStr(Result, ':' + qryDados.Params[intCnt].Name, QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', qryDados.Params[intCnt].AsDateTime)));
        ftDate:
          Result := ReplaceStr(Result, ':' + qryDados.Params[intCnt].Name, QuotedStr(FormatDateTime('yyyy-mm-dd', qryDados.Params[intCnt].AsDate)));
        ftFloat:
          Result := ReplaceStr(Result, ':' + qryDados.Params[intCnt].Name, AnsiReplaceStr(FloatToStrF(qryDados.Params[intCnt].AsFloat, ffFixed, 12, 2), ',', '.'));
        ftInteger:
          Result := ReplaceStr(Result, ':' + qryDados.Params[intCnt].Name, qryDados.Params[intCnt].AsString);
        Else
          Result := ReplaceStr(Result, ':' + qryDados.Params[intCnt].Name, QuotedStr(qryDados.Params[intCnt].AsString));
      End;
    End;
  End;
end;

function TAtuOcoCrm.fRetornaCodigoOcorrenciaGarantiaAD(pstrNumDoc, pstrEspDoc, pstrCodCli,
  pstrCodEmp: String): String;
Var
  lSql: String;
  lQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  lblnAD: Boolean;
begin
  Result := EmptyStr;
  lblnAD :=  fEmptyStr(pstrEspDoc);

  if lblnAD then
  begin
    lSql :=        ' SELECT DISTINCT A.GER_CODADE, A.GER_CODEMP, A.GER_CODOCO ';
    lSql := lSql + ' FROM ADEGER A ';
    lSql := lSql + ' JOIN ADEDET AD ON AD.DET_CODADE = A.GER_CODADE AND AD.DET_GARANT = "S" ';
    lSql := lSql + ' WHERE TRUE AND A.GER_CODADE = :PNUMDOC AND A.GER_CODEMP = :PCODEMP ';
  end
  else
  begin
    lSql :=        ' SELECT DISTINCT G.GER_NUMDOC, G.GER_ESPDOC, G.GER_CODEMP, A.GER_CODOCO ';
    lSql := lSql + ' FROM MOVGER G ';
    lSql := lSql + ' JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM ';
    lSql := lSql + ' JOIN MOVGRC C ON C.GRC_SEQDET = D.AUTOINCREM AND C.GRC_OPCDOC IN ("DV","GA","OE","NE") ';
    lSql := lSql + ' JOIN ADEGER A ON A.GER_DOCDEV = G.GER_NUMDOC AND A.GER_ESPDEV = G.GER_ESPDOC  AND A.GER_EMPDEV = G.GER_CODEMP ';
    lSql := lSql + ' JOIN ADEDET AD ON AD.DET_CODADE = A.GER_CODADE AND AD.DET_GARANT = "S" ';
    lSql := lSql + ' WHERE TRUE AND G.GER_NUMDOC = :PNUMDOC AND G.GER_ESPDOC = :PESPDOC AND G.GER_CODEMP = :PCODEMP AND G.GER_CODCLI = :PCODCLI ';
  end;

  lQry := fCriaQuery;
  Try
    lQry.Close;
    lQry.SQL.Clear;
    lQry.Sql.Add(lSql);
    lQry.ParamByName('PNUMDOC').AsString := pstrNumDoc;
    lQry.ParamByName('PCODEMP').AsString := pstrCodEmp;

    if Not lblnAD then
    begin
      lQry.ParamByName('PCODCLI').AsString := pstrCodCli;
      lQry.ParamByName('PESPDOC').AsString := pstrEspDoc;
    end;

    lQry.Open;
    if lQry.Isempty then
      Exit;

    Result := lQry.FieldByName('GER_CODOCO').AsString;
  Finally
   {$IFNDEF LINUX}
    lQry.Free;
   {$ENDIF}
  End;

end;

function TAtuOcoCrm.fRetornaCodigoOcorrenciaInterna(strNumDoc,strEspDoc,strCodCli,strCodEmp,strNumRom: String; strNumOrc: String = '';
                                             strEspOrc: String = ''; strParcel: String = ''; strCodToc: String = ''): String;
var
  qryConsulta: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  Result := '';

  FDadosOcorrenciaInterna.CodOco := EmptyStr;
  FDadosOcorrenciaInterna.CodEmp := EmptyStr;
  FDadosOcorrenciaInterna.CodCli := EmptyStr;
  FDadosOcorrenciaInterna.Tip_FC := EmptyStr;

  try
    qryConsulta := fCriaQuery();

    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT SQL_NO_CACHE OCO_CODOCO, OCO_CODEMP, OCO_CODCLI, OCO_TIP_FC ');
    qryConsulta.SQL.Add('  FROM MOVOCO ');
    qryConsulta.SQL.Add(' INNER JOIN HISOCO ON HIS_CODOCO = OCO_CODOCO ');
    qryConsulta.SQL.Add(' WHERE '+IIF(fEmptyStr(strNumOrc), 'HIS_NUMDOC', 'OCO_NUMDOC')+' = :NUMDOC ');
    qryConsulta.SQL.Add('   AND '+IIF(fEmptyStr(strEspOrc), 'HIS_ESPDOC', 'OCO_ESPDOC')+' = :ESPDOC ');
    qryConsulta.SQL.Add('   AND HIS_CODEMP = :CODEMP ');
    If Not fEmptyStr(strParcel) Then
      qryConsulta.SQL.Add('   AND OCO_PARCEL = :PARCEL ');
    If Not fEmptyStr(strCodCli) Then
      qryConsulta.SQL.Add('   AND OCO_CODCLI = :CODCLI ');

    If Not fEmptyStr(strNumRom) Then
      qryConsulta.SQL.Add('   AND HIS_NUMROM = :NUMROM ');

    If Not fEmptyStr(strCodToc) Then
      qryConsulta.SQL.Add('   AND OCO_CODTOC = :CODTOC ');


    qryConsulta.SQL.Add('ORDER BY OCO_CODOCO DESC');

    qryConsulta.ParamByName('NUMDOC').AsString := IIF(fEmptyStr(strNumOrc), strNumDoc, strNumOrc);
    qryConsulta.ParamByName('ESPDOC').AsString := IIF(fEmptyStr(strEspOrc), strEspDoc, strEspOrc);
    If Not fEmptyStr(strCodCli) Then
      qryConsulta.ParamByName('CODClI').AsString := strCodCli;
    qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;
    If Not fEmptyStr(strNumRom) Then
      qryConsulta.ParamByName('NUMROM').AsString := strNumRom;
    If Not fEmptyStr(strParcel) Then
      qryConsulta.ParamByName('PARCEL').AsString := strParcel;
    If Not fEmptyStr(strCodToc) Then
      qryConsulta.ParamByName('CODTOC').AsString := strCodToc;

    qryConsulta.Open;

    If Not qryConsulta.IsEmpty Then
    Begin
      Result := qryConsulta.FieldByName('OCO_CODOCO').AsString;

      FDadosOcorrenciaInterna.CodOco := qryConsulta.FieldByName('OCO_CODOCO').AsString;
      FDadosOcorrenciaInterna.CodEmp := qryConsulta.FieldByName('OCO_CODEMP').AsString;
      FDadosOcorrenciaInterna.CodCli := qryConsulta.FieldByName('OCO_CODCLI').AsString;
      FDadosOcorrenciaInterna.Tip_FC := qryConsulta.FieldByName('OCO_TIP_FC').AsString;
    End;


  finally
{$IFNDEF LINUX}
    FreeAndNil(qryConsulta);
{$ENDIF LINUX}
  end;
end;

function TAtuOcoCrm.fRetornaCodOcorrenciaFinalizacao: String;
begin
   Result := EmptyStr;

   If fEmptyStr(FEspOrc) Then
   Begin
     Result := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,'');
   End
   Else
   Begin
     Result := fRetornaCodigoOcorrencia(FNumOrc,FEspOrc,FCodCli,FCodEmp,'');

     If fEmptyStr(Result) Then
       Result := fRetornaCodigoOcorrencia(FNumOrc,FEspOrc,FCodCli,FEmpOri,'')
   End;
end;

function TAtuOcoCrm.fRetornarEmpresaMovimentacaoOcorrencia: String;
begin
  Result := fCampoTabela('OCO_CODEMP', 'MOVOCO', ['OCO_CODOCO','OCO_CODEMP'], [FCodOco, FCodEmp]);

  if Not fEmptyStr(Result) then
    Exit;

  Result := fCampoTabela('OCO_CODEMP', 'MOVOCO', ['OCO_CODOCO'], [FCodOco]);

  if Not fEmptyStr(Result) then
    Exit;

  Result := FCodEmp;
end;

function TAtuOcoCrm.fRetornaCodSit(const blnInclusao: Boolean; const strEspDocParam: String = ''; const strEspOrcParam: String = ''): String;
begin
  If FblnImpSfa Then
  Begin
    FAcaTrg := IIF(blnInclusao, tciInclusaoPedOrcIntegracao, tciAlteracaoPedOrcIntegracao);
    Result  := FAcaTrg.fGetSituacao;
  End
  Else
    Result := FAcaFat.fGetSituacao(strEspDocParam, strEspOrcParam);
end;

procedure TAtuOcoCrm.pAtlzAgendamentoOcorrencia(const strAutInc: String);
const
  SQLUpdate = 'UPDATE AGENDA SET AGE_CODOPE = :AGE_CODOPE, ' +
              '                  AGE_DTACOM = :AGE_DTACOM, ' +
              '                  AGE_HORCOM = :AGE_HORCOM, ' +
              '                  AGE_DESCRI = :AGE_DESCRI  ' +
              '  WHERE AUTOINCREM = :AUTOINC';

var
  qry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qry := fCriaQuery;
  Try
    qry.SQL.Add(SQLUpdate);
    qry.ParamByName('AUTOINC').AsString := strAutInc;
    qry.ParamByName('AGE_CODOPE').AsString   := strOpeHis;
    qry.ParamByName('AGE_DESCRI').AsString   := strDescri;
    qry.ParamByName('AGE_DTACOM').AsDateTime := strDtaAge;
    qry.ParamByName('AGE_HORCOM').AsDateTime := strHorAge;
    qry.ExecSQL;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(qry);
  {$ENDIF LINUX}
  End;
End;

procedure TAtuOcoCrm.pProcessaRetAgendamentoOco;
const
  SQLSelect = 'SELECT AUTOINCREM FROM AGENDA         ' +
              '  WHERE AGE_CODEMP = :AGE_CODEMP AND  ' +
              '        AGE_TITULO = "Retornar contato ao Cliente"  AND ' +
              '        AGE_BAIXAD = "N" AND          ' +
              '        AGE_CODOCO = :AGE_CODOCO      ' ;

var
  qry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qry := fCriaQuery;
  Try
    qry.SQL.Add(SQLSelect);
    qry.ParamByName('AGE_CODEMP').AsString   := VS_strCodEmp;
    qry.ParamByName('AGE_CODOCO').AsString   := strCodOco;
    qry.ExecSQL;

    If qry.IsEmpty Then
      pCriaAgendamentoOcorrencia
    Else
    Begin
      pAtlzAgendamentoOcorrencia(qry.FieldByName('AUTOINCREM').AsString);
    End;

  Finally
  {$IFNDEF LINUX}
    FreeAndNil(qry);
  {$ENDIF LINUX}
  End;
End;

procedure TAtuOcoCrm.pCriaAgendamentoOcorrencia;
const
  SQLInsert = 'INSERT INTO AGENDA(AUTOINCREM, AGE_CODOPE, AGE_DTACOM, AGE_HORCOM, AGE_CODEMP, AGE_TITULO, AGE_DESCRI, AGE_BAIXAD, AGE_CODOCO)' +
              'VALUES(:AUTOINCREM, :AGE_CODOPE, :AGE_DTACOM, :AGE_HORCOM, :AGE_CODEMP, :AGE_TITULO, :AGE_DESCRI, :AGE_BAIXAD, :AGE_CODOCO)';

var
  qry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qry := fCriaQuery;
  Try
    qry.SQL.Add(SQLInsert);
    qry.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('AGENDA', VS_strCodEmp);
    qry.ParamByName('AGE_CODOPE').AsString := strOpeHis;
    qry.ParamByName('AGE_DTACOM').AsDateTime := strDtaAge;
    qry.ParamByName('AGE_HORCOM').AsDateTime := strHorAge;
    qry.ParamByName('AGE_CODEMP').AsString := VS_strCodEmp;
    qry.ParamByName('AGE_TITULO').AsString := 'Retornar contato ao Cliente';
    qry.ParamByName('AGE_DESCRI').AsString := strDescri;
    qry.ParamByName('AGE_BAIXAD').AsString := 'N';
    qry.ParamByName('AGE_CODOCO').AsString := strCodOco;
    qry.ExecSQL;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(qry);
  {$ENDIF LINUX}
  End;
end;

procedure TAtuOcoCrm.pPreencheOcorrenciaOrcamento;
begin
  FblnCriarAgendamento := (strDtaAge > 0);
  strDtaAge := IIF((strDtaAge = 0), strDtaInc, strDtaAge);
  strHorAge := IIF((strHorAge = 0), strHorInc, strHorAge);

  If FBlnDocHer Then
  Begin
    strDescri := fRetornaDescriHeranca;
  End;
end;

procedure TAtuOcoCrm.pPreencheOcorrenciaPedido;
begin
  strDtaAge := strDtaInc;
  strHorAge := strHorInc;

  If FBlnDocHer Then
  Begin
    strDescri := fRetornaDescriHeranca;
  End;
end;

procedure TAtuOcoCrm.pProcessaInclusaoOcorrenciaPedidoOrcamento;
begin
  FCodSit :=  fRetornaCodSit(True, FEspDoc, IIF(blnOrcamentoTransformadoEmPedido, '', FEspOrc));

  pInsereNovaOcorrencia;
  pInsereHistoricoOcorrencia;
end;

procedure TAtuOcoCrm.pProcessaReaberturaDocumentoFaturado;
begin
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc, FEspDoc, FCodCli, FCodEmp, '');

  If Not fEmptyStr(strCodOco) Then
    pReabreOcorrencia(strCodOco,
                      FCodEmp,
                      'Reabertura de ocorrência por cancelamento de documento',
                      '',
                      FCodToc);
end;

procedure TAtuOcoCrm.pProcessaRegavacaoPedidoOrcamento(const strEspDocV: String);
begin
  FCodSit :=  fRetornaCodSit(True, FEspDoc, IIF(blnOrcamentoTransformadoEmPedido, '', FEspOrc));
  strCodOco := fRetornaCodigoOcorrencia(IIF(fEmptyStr(FNumOrc),FNumDoc,FNumOrc),strEspDocV,FCodCli,FCodEmp,'');
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := IIF((strDtaAge = 0), strDtaInc, strDtaAge);
  strHorAge := IIF((strHorAge = 0), strHorInc, strHorAge);

  strOpeHis := strLoginUsuarioLogado;
  strDescri := FAcaFat.fGetDescricao() + ' - REGRAVADO' + '<<csq>>' +
               'Número Documento : ' + FNumDoc   + '<<csq>>' +
               'Espécie          : ' + FEspDoc   + '<<csq>>' +
               'Empresa          : ' + FCodEmp   + '<<csq>>' +
                fDadosConsumidor+
               '<<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe);
  If fCfgSis('SEGCND', varBoolean) Or fCfgSis('HABENT', varBoolean)  Then
    If Not fEmptyStr(FPrevis) Then
      strDescri := strDescri + '<<csq>>' + 'Data de Previsão do Documento : ' + FPrevis +  '<<csq>>';

  pInsereHistoricoOcorrencia;
  pAtualizaOcorrencia;
end;

procedure TAtuOcoCrm.pProcessaFatOrcamentoPedido;
Var
  strEspDocV : String;
begin
  strEspDocV := IIF(fEmptyStr(FEspOrc) Or blnOrcamentoTransformadoEmPedido, FEspDoc, FEspOrc);
  fObtemDadosDocumentoOcorrencia(FCodEmp, FEspDoc, FNumDoc);
  FblnCriarAgendamento := False;

  If (FEspDoc = 'OR') Then
    pPreencheOcorrenciaOrcamento
  Else
    pPreencheOcorrenciaPedido;

  If (Not fExisteOrcamentoHisOcoCrm(IIF(fEmptyStr(FNumOrc),FNumDoc,FNumOrc),
                                    strEspDocV,
                                    IIF((FTip_Fc = 'P') And (Not fEmptyStr(FCodPro)), FCodPro,FCodCli),
                                    FCodEmp))
      Or blnOrcamentoTransformadoEmPedido
      Or FblnPDGeradoDesmembramento
      Or FblnAgrPed
      Or FBlnDocHer
      Or fPedidoGeradoAPartirPedido
      Or FGerandoNovoPedido Then
    pProcessaInclusaoOcorrenciaPedidoOrcamento
  Else
    pProcessaRegavacaoPedidoOrcamento(strEspDocV);

  If FblnCriarAgendamento Then
  Begin
    pProcessaRetAgendamentoOco;
  End;

  blnOrcamentoTransformadoEmPedido := False;

end;

procedure TAtuOcoCrm.pProcessaFinanceiro(blnEncerrar: Boolean; blnExcluir: Boolean;
  strMsgFinaliza: String = ''; fltVlrBx: Double = 0);
Begin
  FCodSit   := FAcaFat.fGetSituacao();
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc, strEspDoc, FCodCli, FCodEmp, '', '', '', FParcel);

  If (blnEncerrar Or blnExcluir) And  fEmptyStr(strCodOco) Then
    Exit;

  If blnExcluir Then
  Begin
    TDeleteOccurrenceCRM.New()
        .NumDoc(strNumDoc)
        .EspDoc(strEspDoc)
        .CodEmp(strCodEmp)
        .NomFrm('[TAtuOcoCrm.pProcessaFinanceiro]')
        .pDelete();
  End
  Else
  If fEmptyStr(strCodOco) Then
  Begin
    pInsereNovaOcorrencia;
    pInsereHistoricoOcorrencia;
  End
  Else
  Begin
    strDtaInc := VS_Date;
    strHorInc := fRetHoraServidor();
    strDtaAge := strDtaInc;
    strHorAge := strHorInc;

    If blnEncerrar Then
    Begin
      strDtaCon := fNow;
      strHorCon := fNow;
    End;

    strOpeHis := strLoginUsuarioLogado;
    strDescri := FAcaFat.fGetDescricao() + '<<csq>>' + 'Número Documento : ' + FNumDoc +
      '<<csq>>' + 'Espécie          : ' + FEspDoc + '<<csq>>' +
      'Empresa          : ' + FCodEmp + '<<csq>>' +
      'Parcela          : ' + FParcel + '<<csq>>';

    If fltVlrBx > 0 Then
      strDescri := strDescri + 'Valor            : ' + FormatFloat('#,##0.00', fltVlrBx)  + '<<csq>>' ;

    strDescri := strDescri + fDadosConsumidor +
      '<<csq>>' + 'Operador Origem : ' + fRetNomeOperador
      (strLoginUsuarioLogado) + '<<csq>>' + DateToStr(strDtaInc) + ' ' +
      TimeToStr(strHorInc) + ' - ' + FCodOpe + ' - ' +
      fRetNomeOperador(FCodOpe);

    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  end;
end;

procedure TAtuOcoCrm.pProcessaFatOrcamentoPedidoEnderecado;
begin
  FCodSit := FAcaFat.fGetSituacao();

  strDtaCon := fNow;
  strHorCon := fNow;
  strCodOco := fRetornaCodigoOcorrencia(FNumOrc,FEspOrc,FCodCli,FCodEmp,'');
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;
  strOpeHis := strLoginUsuarioLogado;
  strDescri := 'Documento de Endereçamento - Baixa de Endereçamento <<csq>>' +
               'Número Documento : ' + FNumDoc + '<<csq>>' +
               'Espécie          : ' + FEspDoc + '<<csq>>' +
               'Empresa          : ' + FCodEmp + '<<csq>>' +
               'Data Faturamento : ' + DateToStr(strDtaInc)  + '<<csq>>' +
               'Vendedor         : ' + FCodOpe ;

  strDescri := strDescri + '<<csq>><<csq>>Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                           DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe);

  If Not fEmptyStr(FCodOco) Then
  begin
    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  end;
end;


procedure TAtuOcoCrm.pProcessaTransfOrEmPdFaturado(const blnClienteAlterado: Boolean);
var
  strCodOcoDocAnt,
  strCodOcoDocNew,
  strDescriAux: String;
  strCodCliAux: String;
  blnFinalizar: Boolean;
  strNumDocAnt,
  strEspDocAnt: String;
begin
  blnFinalizar := False;

  If (Not (FAcaFat = afcPedidoFaturadoParcial)) And
     (Not fFinalizaOcorrenciaNaBaixaDoRomaneio()) Then
  Begin
    strDtaCon := fNow;
    strHorCon := fNow;
    blnFinalizar := True;
  End;

  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;
  strOpeHis := strLoginUsuarioLogado;
  strDescri := IIF(blnClienteAlterado,  FAcaFat.fGetDescricao() + ' COM ALTERAÇÃO DE CLIENTE', FAcaFat.fGetDescricao());
  strDescri := strDescri + ' :' + FNumOrc + '<<csq>>' +
               'Número Documento : ' + FNumDoc + '<<csq>>' +
               'Espécie          : ' + FEspDoc + '<<csq>>' +
               'Empresa          : ' + IIF(fEmptyStr(FEmpFat), FCodEmp, FEmpFat) + '<<csq>>' +
               'Data Faturamento : ' + DateToStr(strDtaInc)  + '<<csq>>' +
               'Vendedor         : ' + FCodOpe ;

  strCodOco :=  fRetornaCodOcorrenciaFinalizacao;

  If (FAcaFat = afcPedidoFaturadoParcial) Then
    strDescri := strDescri + '<<csq>>***FATURAMENTO PARCIAL';

  If ((fEmptyStr(FCodToc)) and (FEspOrc = 'OR')) Then
    strCodToc := fCfgSis('VENORC', varString);

  FCodSit := FAcaFat.fGetSituacao(FEspDoc);

  If blnClienteAlterado Then
  Begin
    FblnRecarregarOcoGravarMsg := False;
    { Dados da ocorrencia atual}
    strCodOcoDocAnt := fRetornaCodigoOcorrencia(FNumOrc,FEspOrc,FCodCliAnt,FCodEmp,'');
    strCodOcoDocNew := FCodOco;
    strCodCliAux := FCodCli;
    strNumDocAnt := FNumDoc;
    strEspDocAnt := FEspDoc;

    strDescri := strDescri + '<<csq>>' +
                 'Novo Cliente     : ' + FCodCli + '<<csq>>' +
                 'Cliente Original : ' + FCodCliAnt;
    strDescriAux := strDescri;

    { Carrega dados da ocorrencia para finalizacao}
    pCarregaOcorrencia(strTip_Fc,
                       strCodOcoDocAnt,
                       strCodEmp);

    strDescri := strDescriAux;
    FCodSit := FAcaFat.fGetSituacao(strEspDocAnt, FEspDoc);
  End;

  strDescri := strDescri + '<<csq>><<csq>>Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                           DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe);


  strDtaCon := IIF(blnFinalizar, fNow, 0);
  strHorCon := IIF(blnFinalizar, fNow, 0);
  FBlnVendaDesmembrada := (FCodEmp <> FEmpOri);

  pFinalizaOcorrencia(strDescri, '', FDadosOcorrenciaInterna.CodCli);
  FBlnVendaDesmembrada :=  False;

  If blnClienteAlterado Then
  Begin
    strCodCli := strCodCliAux;
    strDescri := strDescriAux;
    strCodOco := strCodOcoDocAnt;
    strNumDoc := strNumDocAnt;
    strEspDoc := strEspDocAnt;
  End;

  If SameText(FTip_Fc, 'P') Then
    FTip_Fc   := 'C';

  FCodSit := FAcaFat.fGetSituacao(FEspDoc);
  strCodToc := fCfgSis('VENPED', varString);
  afcAcaFat := afcPedido;
  strDescri := 'PEDIDO CRIADO A PARTIR DE ORÇAMENTO: ' + '<<csq>>' +
               'Número Documento : ' + FNumDoc + '<<csq>>' +
               'Espécie          : ' + FEspDoc + '<<csq>>' +
               'Empresa          : ' + IIF(fEmptyStr(FEmpFat), FCodEmp, FEmpFat) + '<<csq>>' +
               'Orçamento Origem : ' + FNumOrc + ' - ' + FCodEmp + '<<csq>>';
  strDescri := strDescri + '<<csq>><<csq>>Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe);
  strDtaCon := 0;
  strHorCon := 0;
  strCodEmp := IIF(fEmptyStr(FEmpFat), FCodEmp, FEmpFat);
  pProcessaFatOrcamentoPedido();
End;


procedure TAtuOcoCrm.pIncluirOcorrenciaGarantia;
var
  lblnEncerrarOco: Boolean;
  lstrCodToc,
  lstrCodSitAux: String;
  lblnPermiteEncerrarAtm,
  lblnGarantiaEncerrada,
  lblnOcorrenciaEncerrada,
  lblnOcorrenciaAD: boolean;
  lstlDescri: TStringList;
  lstrNumGarantia: String;

begin

  lblnPermiteEncerrarAtm := fCfgSis('FOCOGA', varString) = 'S';
  lstrCodToc := fCfgSis('VENDEV', varString);
  FCodToc := lstrCodToc;

  lstrNumGarantia := 'Número da Garantia:' + FNumDoc + '<<csq>>';

  lstlDescri := TStringList.Create;
  Try
    lstlDescri.Clear;
    lstlDescri.NameValueSeparator := '=';
    lstlDescri.Text := FDescri;

    lblnOcorrenciaAD := False;
    if fEmptystr(strCodOco) then
    begin
      if lstlDescri.IndexOfName('CODADE') >= 0 then
      begin
        strCodOco :=
          fRetornaCodigoOcorrenciaGarantiaAD(lstlDescri.Values['CODADE'],
                                             '',
                                             FCodCli,
                                             FCodEmp);
      end
      else
      begin
        strCodOco :=
          fRetornaCodigoOcorrenciaGarantiaAD(FNumDoc,
                                             FEspDoc,
                                             FCodCli,
                                             FCodEmp);
      end;

      if fEmptystr(strCodOco) then
      begin
        strCodOco := fRetornaCodigoOcorrencia(FNumDoc,   //strNumDoc
                                              FEspDoc, //strEspDoc
                                              FCodCli,   //strCodCli
                                              FCodEmp,   //strCodEmp
                                              '',        //stgNumRom
                                              '',        //strNumOrc
                                              '',        //strEspOrc
                                              '',        //strparcel);
                                              FCodToc);  //strCodToc

      end
      else
        lblnOcorrenciaAD := True;
    end;

    If fEmptyStr(strCodOco) then
      Exit;

    lblnOcorrenciaEncerrada := fOcorrenciaFinalizada(strCodOco);
    If lblnOcorrenciaEncerrada And Not (FAcaFat = afcGarantiaCancelada) Then
      Exit;

    lblnGarantiaEncerrada := fEncerrarOcorrenciaGarantia(FNumDoc, FEspDoc, FCodCli, FCodEmp, FAcaFat);

    if Not fEmptyStr(strCodOco) then
      pCarregaOcorrencia('C', strCodOco, FCodEmp);

    strCodSit := FAcaFat.fGetSituacao();
    lstrCodSitAux := strCodSit;

    If fEmptyStr(strCodOco) And
         fEmptyStr(strCodSit) And
           (Not lblnOcorrenciaAD) Then
      Exit;

    strDtaInc := VS_Date;
    strHorInc := fRetHoraServidor();
    strDtaAge := VS_Date;
    strHorAge := strHorInc;

    if lblnPermiteEncerrarAtm And
         lblnGarantiaEncerrada And
           Not (lblnOcorrenciaAD And (FAcaFat = afcGarantiaCancelada)) then
    begin
      lblnEncerrarOco := True;
      strDtaCon := strDtaInc;
      strHorCon := strHorInc;
    end
    else
    begin
      lblnEncerrarOco := False;
      strDtaCon := 0;
      strHorCon := 0;
    end;

    strOpeHis := FAcaFat.fGetOperador(FNumDoc, FEspDoc, FCodEmp);

    if FAcaFat = afcGarantiaAndamentoPendEnvCli_Confirmacao then
      FDescri := afcGarantiaReposicaoItemConcluida.fGetDescricao

    else if FAcaFat = afcGarantiaAndamentoPendLibCrd_Confirmacao then
      FDescri := afcGarantiaCredito.fGetDescricao

    else
      FDescri :=   FAcaFat.fGetDescricao();

    FDescri := FDescri + '<<csq>>' + '<<csq>>' + lstrNumGarantia;

    if FAcaFat in [afcGarantiaAndamentoPendLibCrd_Confirmacao,
                   afcGarantiaAndamentoPendEnvCli_Confirmacao] then
    begin
      FDescri := FDescri +
                 Format('Item: %0:s-%1:s Quantidade: %2:s',
                        [FCodIte,    //0
                         FDesIte,    //1
                         FormatFloat('#0',FQtdIte)]); //2

      FDescri := FDescri +'<<csq>>';

      if FAcaFat = afcGarantiaAndamentoPendEnvCli_Confirmacao then
        strCodSit := afcGarantiaReposicaoItemConcluida.fGetSituacao()
      else if FAcaFat = afcGarantiaAndamentoPendLibCrd_Confirmacao then
        strCodSit := afcGarantiaCredito.fGetSituacao();

      if lblnGarantiaEncerrada then
        lstrCodSitAux := strCodSit;
    end;

    if lstlDescri.IndexOfName('DESCRI') >= 0 then
      FDescri := FDescri + lstlDescri.Values['DESCRI'] + '<<csq>>';

    FDescri := FDescri +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' +
               FCodOpe + ' - ' + fRetNomeOperador(FCodOpe) + '<<csq>>';

    if FCodToc <> lstrCodToc then
      FCodToc := lstrCodToc;

    pInsereHistoricoOcorrencia;
    strCodSit := lstrCodSitAux;

    if Not lblnOcorrenciaEncerrada then
      pAtualizaOcorrencia;

    if lblnEncerrarOco then
    begin
      if FCodToc <> lstrCodToc then
        FCodToc := lstrCodToc;
      If (FAcaFat = afcGarantiaCancelada) then
        pFinalizaOcorrencia(FAcaFat.fGetDescricao)
      else
        pFinalizaOcorrencia('Ocorrência encerrada.');
    end;
  Finally
    lstlDescri.Free;
  End;
end;

procedure TAtuOcoCrm.pProcessaOrcamentoPedidoFaturado(const blnClienteAlterado: Boolean);
var
  strCodOcoDocAnt,
  strCodOcoDocNew,
  strDescriAux: String;
  strCodCliDocNew: String;
  blnFinalizar: Boolean;
  strCodTocAnt: String;
  strEspDocDocNew: String;
  strCodCliAntDoc: String;
  strNumDocNew : String;
  strEspDocNew : String;
begin
  FCodSit := FAcaFat.fGetSituacao(FEspDoc, FEspOrc);
  blnFinalizar := False;

  If (fFinalizaOcorrencia) Then
  Begin
    strDtaCon := fNow;
    strHorCon := fNow;
    blnFinalizar := True;
  End;

  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;
  strOpeHis := strLoginUsuarioLogado;
  strDescri := IIF(blnClienteAlterado,  FAcaFat.fGetDescricao() + ' COM ALTERAÇÃO DE CLIENTE', FAcaFat.fGetDescricao());
  strDescri := strDescri + ' :' + FNumOrc + '<<csq>>' +
               'Número Documento : ' + FNumDoc + '<<csq>>' +
               'Espécie          : ' + FEspDoc + '<<csq>>' +
               'Empresa          : ' + IIF(fEmptyStr(FEmpFat), FCodEmp, FEmpFat) + '<<csq>>' +
               'Data Faturamento : ' + DateToStr(strDtaInc)  + '<<csq>>' +
               'Vendedor         : ' + FCodOpe ;

  strCodOco := IIF(fEmptyStr(FEspOrc),
                   fRetornaCodigoOcorrencia(FNumDoc,FEspDoc, FCodCli,FCodEmp,''),
                   fRetornaCodigoOcorrencia(FNumOrc,FEspOrc, FCodCli,FCodEmp,''));


  If fEmptyStr(strCodOco) And
     (Not fEmptyStr(FEmpOri)) And
     (FCodEmp <> FEmpOri) Then
  Begin
    strCodOco := fRetornaCodigoOcorrencia(FNumOrc,FEspOrc,FCodCli,FEmpOri,'');
    FBlnVendaDesmembrada := (FCodEmp <> FEmpOri);
  End;

  If (FAcaFat = afcPedidoFaturadoParcial) Then
    strDescri := strDescri + '<<csq>>***FATURAMENTO PARCIAL';

  { Dados da ocorrencia atual}
  If blnClienteAlterado Then
  Begin
    strCodOcoDocAnt := fRetornaCodigoOcorrencia(FNumOrc,FEspOrc,FCodCliAnt,FCodEmp,'');
    strCodOcoDocNew := FCodOco;
    strCodCliDocNew := FCodCli;
    strCodCliAntDoc := FCodCliAnt;
    strNumDocNew := FNumDoc;
    strEspDocNew := FEspDoc;

    strDescri := strDescri + '<<csq>>' +
                 'Novo Cliente     : ' + FCodCli + '<<csq>>' +
                 'Cliente Original : ' + FCodCliAnt;
    strDescriAux := strDescri;
  End;

  strDescri := strDescri + '<<csq>><<csq>>Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                           DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe);

  If Not fEmptyStr(FCodOco) Then
  begin
    If blnClienteAlterado Then
    Begin
      FblnRecarregarOcoGravarMsg := False;

      { Carrega dados para finalização da ocorrência anterior}
      pCarregaOcorrencia(strTip_Fc,
                         strCodOcoDocAnt,
                         strCodEmp);

      strDescri := strDescriAux;
      FCodSit := FAcaFat.fGetSituacao(strEspDocDocNew, FEspDoc);
      strDtaCon := IIF(blnFinalizar, fNow, 0);
      strHorCon := IIF(blnFinalizar, fNow, 0);

      strCodCli := strCodCliDocNew;
      strDtaInc := VS_Date;
      strHorInc := fRetHoraServidor();
      pInsereHistoricoOcorrencia;
      pAtualizaOcorrencia;

      { Retorna aos dados do documento processado }
      strCodOco := strCodOcoDocNew;
      strNumDoc := strNumDocNew;
      strEspDoc := strEspDocNew;
      FblnRecarregarOcoGravarMsg := True;
    End
    Else
    Begin
      strCodTocAnt := strCodToc;
      FblnRecarregarOcoGravarMsg := False;
      If (Pos(FEspOrc, 'OR_PD_') > 0) Then
        strCodToc := IIF(FEspOrc = 'OR',fCfgSis('VENORC', varString),fCfgSis('VENPED', varString));
      pInsereHistoricoOcorrencia;
      pAtualizaOcorrencia;

      strCodToc := strCodTocAnt;
    End;
  End;
End;


procedure TAtuOcoCrm.pProcessaFatOrcamentoPedidoFaturado;
var
  blnClienteAlterado: Boolean;
begin
  blnOrcamentoTransformadoEmPedido := (FAcaFat = afcOrcamentoEmPedido);
  blnClienteAlterado := ((FCodCli <> FCodCliAnt) and (Not fEmptyStr(FCodCliAnt)));

  If blnOrcamentoTransformadoEmPedido Then
    pProcessaTransfOrEmPdFaturado(blnClienteAlterado)
  Else
    pProcessaOrcamentoPedidoFaturado(blnClienteAlterado);
end;

procedure TAtuOcoCrm.pProcessaFatNFExpedida;
begin
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,'');
  strDtaInc := VS_Date;
  strHorInc := fTime();
  strDtaAge := VS_Date;
  strHorAge := fTime();
  strOpeHis := strLoginUsuarioLogado;
  strCodSit := FAcaFat.fGetSituacao();
  strDescri := FAcaFat.fGetDescricao() + ' :' + FNumOrc + '<<csq>><<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) +
               '<<csq>>' + DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe);

  If Not fEmptyStr(FCodOco) Then
  begin
    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  end;

  If (fCfgSis('FINOEX', varBoolean)) And (Not fCfgSis('UTIROM', varBoolean)) Then
  Begin
    pFinalizaOcorrencia('Encerramento automático da ocorrência');
  End;

end;

//Faturamento tipo 4;
procedure TAtuOcoCrm.pProcessaConferenciaPedido;
begin
  strCodSit := FAcaFat.fGetSituacao();
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,'');
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;
  strOpeHis := strLoginUsuarioLogado;
  strDescri := FAcaFat.fGetDescricao() + ' :' + FNumOrc + '<<csq>><<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) +
               '<<csq>>' + DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe);

  If Not fEmptyStr(FCodOco) Then
  begin
    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  end;
end;

function TAtuOcoCrm.fRetornaDescriHeranca: String;
begin
  Result := IIF((Not fEmptyStr(FParcel)), FAcaFat.fGetDescricao(),
               'NOVO ' + FAcaFat.fGetDescricao() + ' CRIADO A PARTIR DE HERANÇA') + '<<csq>>'  +
               'Número Documento : ' + FNumDoc + '<<csq>>' +
               'Espécie          : ' + FEspDoc + '<<csq>>' +
               'Empresa          : ' + FCodEmp + '<<csq>>'+
               '<<csq>>' +
               'Cliente          : ' + FCodCli + '-' + fRetNomCliente(FCodCli) + '<<csq>>'+
               'Telefones        : ' + fRetornaTelefonesCliente(FCodCli) +  '<<csq>>'+
               'E-Mail           : ' + fRetornaEmailsCliente(FCodCli) +  '<<csq>>'+
               '<<csq>>' +
               IIF((Not fEmptyStr(FParcel)),'Parcela          : ' + FParcel + '<<csq>>','') +
                fDadosConsumidor+
               '<<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc)  + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe);
end;

function TAtuOcoCrm.fRetornaDocOrig(strOcoEmpDoc, strOcoNumDoc, strOcoEspDoc: String): TDocumentoCRM;
Begin

  Result := fRetornaDocOrigFatGor(strOcoEmpDoc, strOcoNumDoc, strOcoEspDoc);

  If fEmptyStr(Result.strNumDoc) Then
    Result := fRetornaDocOrigMovDet(strOcoEmpDoc, strOcoNumDoc, strOcoEspDoc);
end;

function TAtuOcoCrm.fRetornaDocOrigMovDet(strOcoEmpDoc, strOcoNumDoc, strOcoEspDoc: String): TDocumentoCRM;
var
  strSQL: String;
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
Begin
  strSQL := 'SELECT DET_CODCLI,                 ' +
            '       DET_CODEMP,                 ' +
            '       DET_ESPDOC,                 ' +
            '       DET_NUMDOC                  ' +
            '  FROM MOVDET                      ' +
            '  WHERE DET_CODEMP = :EMPFAT AND   ' +
            '        DET_ESPDOC = :TIPFAT AND   ' +
            '        DET_NUMDOC = :NUMFAT       ' ;
  qryAux := fCriaQuery();
  Try
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('EMPFAT').AsString := strOcoEmpDoc;
    qryAux.ParamByName('TIPFAT').AsString := strOcoEspDoc;
    qryAux.ParamByName('NUMFAT').AsString := strOcoNumDoc;
    qryAux.Open();

    If Not qryAux.IsEmpty() Then
    Begin
      Result.strCodCli := qryAux.FieldByName('DET_CODCLI').AsString;
      Result.strCodEmp := qryAux.FieldByName('DET_CODEMP').AsString;
      Result.strEspDoc := qryAux.FieldByName('DET_ESPDOC').AsString;
      Result.strNumDoc := qryAux.FieldByName('DET_NUMDOC').AsString;
    End
    Else
    Begin
      Result.strCodEmp := strOcoEmpDoc;
      Result.strEspDoc := strOcoEspDoc;
      Result.strNumDoc := strOcoNumDoc;
    End;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(qryAux);
  {$ENDIF LINUX}
  End;
end;

function TAtuOcoCrm.fRetornaDocOrigFatGor(strOcoEmpDoc, strOcoNumDoc, strOcoEspDoc: String): TDocumentoCRM;
var
  strSQL: String;
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
Begin
  strSQL := 'SELECT FGO_CODCLI,                 ' +
            '       FGO_CODEMP,                 ' +
            '       FGO_ESPDOC,                 ' +
            '       FGO_NUMDOC                  ' +
            '  FROM FATGOR                      ' +
            '  WHERE FGO_EMPFAT = :EMPFAT AND   ' +
            '        FGO_TIPFAT = :TIPFAT AND   ' +
            '        FGO_NUMFAT = :NUMFAT       ' ;
  qryAux := fCriaQuery();
  Try
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('EMPFAT').AsString := strOcoEmpDoc;
    qryAux.ParamByName('TIPFAT').AsString := strOcoEspDoc;
    qryAux.ParamByName('NUMFAT').AsString := strOcoNumDoc;
    qryAux.Open();

    If Not qryAux.IsEmpty() Then
    Begin
      Result.strCodCli := qryAux.FieldByName('FGO_CODCLI').AsString;
      Result.strCodEmp := qryAux.FieldByName('FGO_CODEMP').AsString;
      Result.strEspDoc := qryAux.FieldByName('FGO_ESPDOC').AsString;
      Result.strNumDoc := qryAux.FieldByName('FGO_NUMDOC').AsString;
    End;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(qryAux);
  {$ENDIF LINUX}
  End;
end;

function TAtuOcoCrm.fRetornaCodTocTipDoc(aStrEspDoc: String): String;
Begin
  Case AnsiIndexStr(aStrEspDoc, [ 'OR', 'PD', 'FF'] ) of
    0  : Result := fCfgSis('VENORC', varString);
    1  : Result := fCfgSis('VENPED', varString);
    2  : Result := fCfgSis('VENVN_', varString);
  End;
End;

procedure TAtuOcoCrm.pProcessaConfirmacaoDocumento;
var
  documentoDocOri: TDocumentoCRM;
  strCodTocDocOri: String;
begin
  strCodSit := FAcaFat.fGetSituacao();

  If fEmptyStr(strCodSit) Then
    Exit;

  documentoDocOri := fRetornaDocOrig(FCodEmp, FNumOrc, FEspOrc);
  strCodTocDocOri := fRetornaCodTocTipDoc(documentoDocOri.strEspDoc);

  strCodOco := fRetornaCodigoOcorrencia(documentoDocOri.strNumDoc,
                                        documentoDocOri.strEspDoc,
                                        documentoDocOri.strCodCli,
                                        documentoDocOri.strCodEmp,
                                        '', '', '', '', strCodTocDocOri);

  If fEmptyStr(strCodOco) Or (fEmptyStr(documentoDocOri.strNumDoc)) Then
    Exit;

  strDtaInc := VS_Date;
  strHorInc := fTime();
  strDtaAge := VS_Date;
  strHorAge := fTime();
  strOpeHis := strLoginUsuarioLogado;
  strCodToc := fCfgSis('TOCCNF', varString);

  strDescri := FAcaFat.fGetDescricao() + '<<csq>><<csq>>' +
               'Documento Confirmado :' + FNumOrc + '-' + FEspOrc + '<<csq>>' +
               'Número Documento     :' + FNumDoc + '<<csq>>' +
               'Espécie              :' + FEspDoc + '<<csq>>' +
               'Empresa              :' + FCodEmp + '<<csq>>' +
               'Data Faturamento     :' + DateToStr(strDtaInc) + '<<csq>>' +
               'Vendedor             :' + FCodOpe + '-' + fRetNomeOperador(FCodOpe) + '<<csq>><<csq>>' +

               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) +
               '<<csq>>' + DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe);

  pInsereHistoricoOcorrencia;

end;

procedure TAtuOcoCrm.pProcessaLiberacaoPedido;
begin
  strCodSit := FAcaFat.fGetSituacao();
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,'');
  strDtaInc := VS_Date;
  strHorInc := fTime();
  strDtaAge := VS_Date;
  strHorAge := fTime();
  strOpeHis := strLoginUsuarioLogado;
  strDescri := FAcaFat.fGetDescricao() + ' :' + FNumDoc + '-' + FEspDoc + '-' + FCodEmp + '<<csq>><<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) +
               '<<csq>>' + DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe);

  If Not fEmptyStr(FCodOco) Then
  begin
    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  end;
end;

procedure TAtuOcoCrm.pProcessaMovimentacaoPreNota;
var
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  strPedCom: String;
  strEspCom: String;
  strEmpCom: String;
begin
  qryAux := fCriaQuery();
  Try
    qryAux.SQL.Add(sqlPedidoPreNota);
    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;
    qryAux.Open();

    If qryAux.IsEmpty() Then
      Exit;

    strPedCom := FNumDoc;
    strEspCom := FEspDoc;
    strEmpCom := FCodEmp;

    While (Not qryAux.Eof) Do
    Begin
      FNumDoc := qryAux.FieldByName('RCD_DOCPDV').AsString;
      FEspDoc := qryAux.FieldByName('RCD_ESPPDV').AsString;
      FCodEmp := qryAux.FieldByName('RCD_EMPPDV').AsString;

      strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);

      If fEmptyStr(strCodOco) Or
        fOcorrenciaFinalizada(strCodOco) Then
      Begin
        qryAux.Next();
        Continue;
      End;

      strCodSit := FAcaFat.fGetSituacao();
      strDtaInc := VS_Date;
      strHorInc := fRetHoraServidor();
      strDtaAge := VS_Date;
      strHorAge := strHorInc;
      strDtaCon := 0;
      strHorCon := 0;

      strOpeHis := strLoginUsuarioLogado;
      strDescri := FAcaFat.fGetDescricao() + '<<csq>>' + '<<csq>>' +
                   'Nota Fiscal: ' + Concat(qryAux.FieldByName('B08_NNF').AsString, '-',
                                           qryAux.FieldByName('B07_SERIE').AsString) + '<<csq>>' +
                   'Pedido     : ' + strPedCom + '<<csq>>' +
                   'Espécie    : ' + strEspCom + '<<csq>>' +
                   'Empresa    : ' + strEmpCom + '<<csq>>' + '<<csq>>' +
                   'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                   DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' +
                   FCodOpe + ' - ' + fRetNomeOperador(FCodOpe) + '<<csq>>';

      pInsereHistoricoOcorrencia;
      pAtualizaOcorrencia;

      qryAux.Next();
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryAux);
{$ENDIF LINUX}
  End;
end;

procedure TAtuOcoCrm.pProcessaPDTransferenciaBaixado;
var
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  strPedTra: String;
  strEspTra: String;
  strEmpTra: String;
begin
  qryAux := fCriaQuery();
  Try
    qryAux.SQL.Add(sqlPedidoTransferenciaBaixado);
    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;
    qryAux.Open();

    If qryAux.IsEmpty() Then
      Exit;

    strPedTra := FNumDoc;
    strEspTra := FEspDoc;
    strEmpTra := FCodEmp;

    FNumDoc := qryAux.FieldByName('PRE_DOCABS').AsString;
    FEspDoc := qryAux.FieldByName('PRE_ESPABS').AsString;
    FCodEmp := qryAux.FieldByName('PRE_EMPABS').AsString;

    strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);

    If fEmptyStr(strCodOco) Or
      fOcorrenciaFinalizada(strCodOco) Then
    Begin
      Exit
    End;

    strCodSit := FAcaFat.fGetSituacao();
    strDtaInc := VS_Date;
    strHorInc := fRetHoraServidor();
    strDtaAge := VS_Date;
    strHorAge := strHorInc;
    strDtaCon := 0;
    strHorCon := 0;

    strOpeHis := strLoginUsuarioLogado;
    strDescri := FAcaFat.fGetDescricao() + '<<csq>>' + '<<csq>>' +
                 'Pedido     : ' + strPedTra + '<<csq>>' +
                 'Espécie    : ' + strEspTra + '<<csq>>' +
                 'Empresa    : ' + strEmpTra + '<<csq>>' + '<<csq>>' +
                 'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                 DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' +
                 FCodOpe + ' - ' + fRetNomeOperador(FCodOpe) + '<<csq>>';

    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryAux);
{$ENDIF LINUX}
  End;
end;

procedure TAtuOcoCrm.pProcessaPDTransferenciaFaturado;
var
  strItens: String;
  strNumFat: String;
  strTipFat: String;
  strEmpFat: String;
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qryAux := fCriaQuery();

  Try
    strItens := '';

    qryAux.SQL.Add(sqlItensTransferenciaFaturados);
    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;
    qryAux.Open();

    If qryAux.IsEmpty() Then
      Exit;

    strNumFat := FNumDoc;
    strTipFat := FEspDoc;
    strEmpFat := FCodEmp;

    FNumDoc := qryAux.FieldByName('PRE_DOCABS').AsString;
    FEspDoc := qryAux.FieldByName('PRE_ESPABS').AsString;
    FCodEmp := qryAux.FieldByName('PRE_EMPABS').AsString;

    strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);

    If fEmptyStr(strCodOco) Or
      fOcorrenciaFinalizada(strCodOco) Then
    Begin
      Exit;
    End;

    strCodSit := FAcaFat.fGetSituacao();
    strDtaInc := VS_Date;
    strHorInc := fRetHoraServidor();
    strDtaAge := VS_Date;
    strHorAge := strHorInc;
    strDtaCon := 0;
    strHorCon := 0;

    While Not qryAux.Eof Do
    Begin
      strItens := strItens + '| ' + fPadC(qryAux.FieldByName('DET_CODITE').AsString, fTamCodIte + 1) +
        ' | ' + fPadR(qryAux.FieldByName('ITE_DESITE').AsString, 33) +
        ' | ' + fPadL(FloatToStrF(qryAux.FieldByName('DET_QTDITE').AsFloat, ffFixed, 13, 2), 13) +
        ' |' + '<<csq>>' ;

      qryAux.Next();
    End;

    if fTamCodIte = 5 then
      strInfAdc := 'Itens faturados: ' + '<<csq>>' +
                   '--------------------------------------------------------------' + '<<csq>>' +
                   '| Código | Descrição                         |    Quantidade |' + '<<csq>>' +
                   '--------------------------------------------------------------' + '<<csq>>' +
                   strItens +
                   '--------------------------------------------------------------'
    else
      strInfAdc := 'Itens faturados: ' + '<<csq>>' +
                   '----------------------------------------------------------------' + '<<csq>>' +
                   '|  Código  | Descrição                         |    Quantidade |' + '<<csq>>' +
                   '----------------------------------------------------------------' + '<<csq>>' +
                   strItens +
                   '----------------------------------------------------------------';

    strOpeHis := strLoginUsuarioLogado;
    strDescri := FAcaFat.fGetDescricao() + '<<csq>>' +
                 'Número Documento : ' + strNumFat + '<<csq>>' +
                 'Espécie          : ' + strTipFat + '<<csq>>' +
                 'Empresa          : ' + strEmpFat + '<<csq>><<csq>>' +
                 'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                 DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' +
                 FCodOpe + ' - ' + fRetNomeOperador(FCodOpe) + '<<csq>>';

    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryAux);
{$ENDIF LINUX}
  End;
end;

procedure TAtuOcoCrm.pProcessaPDTransferenciaGerado;
var
  strItens: String;
  strDocTra: String;
  strEspTra: String;
  strEmpTra: String;
  strOperador: String;
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qryAux := fCriaQuery();

  Try
    strItens := '';

    qryAux.SQL.Add(sqlItensPDTransfereciaGerado);
    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;
    qryAux.Open();

    If qryAux.IsEmpty() Then
      Exit;

    strDocTra := FNumDoc;
    strEspTra := FEspDoc;
    strEmpTra := FCodEmp;

    FNumDoc := qryAux.FieldByName('PRE_DOCABS').AsString;
    FEspDoc := qryAux.FieldByName('PRE_ESPABS').AsString;
    FCodEmp := qryAux.FieldByName('PRE_EMPABS').AsString;

    strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);

    If fEmptyStr(strCodOco) Or
      fOcorrenciaFinalizada(strCodOco) Then
    Begin
      Exit;
    End;

    strCodSit := FAcaFat.fGetSituacao();
    strDtaInc := VS_Date;
    strHorInc := fRetHoraServidor();
    strDtaAge := VS_Date;
    strHorAge := strHorInc;
    strDtaCon := 0;
    strHorCon := 0;

    While Not qryAux.Eof Do
    Begin
      strItens := strItens + '| ' + fPadC(qryAux.FieldByName('PRE_CODITE').AsString, fTamCodIte + 1) +
        ' | ' + fPadR(qryAux.FieldByName('ITE_DESITE').AsString, 33) +
        ' | ' + fPadL(FloatToStrF(qryAux.FieldByName('PRE_QTDITE').AsFloat, ffFixed, 13, 2), 13) +
        ' |' + '<<csq>>' ;

      qryAux.Next();
    End;
    if fTamCodIte = 5 then
    begin

    strInfAdc := 'Itens aguardando transferência: ' + '<<csq>>' +
                 '--------------------------------------------------------------' + '<<csq>>' +
                 '| Código | Descrição                         |    Quantidade |' + '<<csq>>' +
                 '--------------------------------------------------------------' + '<<csq>>' +
                 strItens +
                 '--------------------------------------------------------------';
    end
    else
    begin
      strInfAdc := 'Itens aguardando transferência: ' + '<<csq>>' +
                 '--------------------------------------------------------------' + '<<csq>>' +
                 '|  Código  | Descrição                         |    Quantidade |' + '<<csq>>' +
                 '--------------------------------------------------------------' + '<<csq>>' +
                 strItens +
                 '--------------------------------------------------------------';
    end;


    strOperador := FAcaFat.fGetOperador(FNumDoc, FEspDoc, FCodEmp);

    strOpeHis := strOperador;

    strDescri := FAcaFat.fGetDescricao() + '<<csq>>' +
                 'Número Documento : ' + strDocTra + '<<csq>>' +
                 'Espécie          : ' + strEspTra + '<<csq>>' +
                 'Empresa          : ' + strEmpTra + '<<csq>><<csq>>' +
                 'Operador Origem : ' + fRetNomeOperador(strOperador) + '<<csq>>' +
                 DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' +
                 strOperador + ' - ' + fRetNomeOperador(strOperador) + '<<csq>>';

    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryAux);
{$ENDIF LINUX}
  End;
end;

procedure TAtuOcoCrm.pProcessaPedidoAgCompra;
var
  strInformacao: String;
  strItens: String;
  strNumReq: String;
  strEmpReq: String;
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  strOperador: String;

  procedure pAddInformacao(const strCodReq, strEmpReq: String);
  begin
    if fTamCodIte = 5 then
      strInformacao := strInformacao +
                       'Requisição de Compra: ' + strCodReq + '-' + strEmpReq + '<<csq>>' +
                       '--------------------------------------------------------------' + '<<csq>>' +
                       '| Código | Descrição                         |    Quantidade |' + '<<csq>>' +
                       '--------------------------------------------------------------' + '<<csq>>' +
                       strItens +
                       '--------------------------------------------------------------' + '<<csq>>' + '<<csq>>'
    else
      strInformacao := strInformacao +
                       'Requisição de Compra: ' + strCodReq + '-' + strEmpReq + '<<csq>>' +
                       '----------------------------------------------------------------' + '<<csq>>' +
                       '|  Código  | Descrição                         |    Quantidade |' + '<<csq>>' +
                       '----------------------------------------------------------------' + '<<csq>>' +
                       strItens +
                       '----------------------------------------------------------------' + '<<csq>>' + '<<csq>>'
  end;
begin
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);

  If fEmptyStr(strCodOco) Or
    fOcorrenciaFinalizada(strCodOco) Then
  Begin
    Exit;
  End;

  strCodSit := FAcaFat.fGetSituacao();
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;
  strDtaCon := 0;
  strHorCon := 0;

  qryAux := fCriaQuery();

  Try
    strItens   := '';
    strNumReq := '';
    strEmpReq := '';
    strInformacao := '';

    qryAux.SQL.Add(sqlItensAguardandoPedidoCompra);
    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;
    qryAux.Open();

    While Not qryAux.Eof Do
    Begin
      If (Concat(strNumReq, strEmpReq) <>
          Concat(qryAux.FieldByName('RCD_CODIGO').AsString,
                 qryAux.FieldByName('RCD_CODEMP').AsString)) Then
      Begin
        If (Not fEmptyStr(strNumReq)) Then
          pAddInformacao(qryAux.FieldByName('RCD_CODIGO').AsString,
                         qryAux.FieldByName('RCD_CODEMP').AsString);

        strNumReq := qryAux.FieldByName('RCD_CODIGO').AsString;
        strEmpReq := qryAux.FieldByName('RCD_CODEMP').AsString;
        strItens := '';
      End;

      strItens := strItens + '| ' + fPadC(qryAux.FieldByName('RCD_CODITE').AsString, ftamCodIte + 1) +
        ' | ' + fPadR(qryAux.FieldByName('RCD_DESITE').AsString, 33) +
        ' | ' + fPadL(FloatToStrF(qryAux.FieldByName('RCD_QTDITE').AsFloat, ffFixed, 13, 2), 13) +
        ' |' + '<<csq>>' ;

      qryAux.Next();
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryAux);
{$ENDIF LINUX}
  End;

  If (Not fEmptyStr(strNumReq)) Then
    pAddInformacao(strNumReq, strEmpReq);

  strInfAdc := strInformacao;

  strOperador := FAcaFat.fGetOperador(FNumDoc, FEspDoc, FCodEmp);

  strOpeHis := strOperador;
  strDescri := FAcaFat.fGetDescricao() + '<<csq>>' + '<<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strOperador) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' +
               strOperador + ' - ' + fRetNomeOperador(strOperador) + '<<csq>>';

  pInsereHistoricoOcorrencia;
  pAtualizaOcorrencia;
end;

procedure TAtuOcoCrm.pProcessaPedidoAgConferencia;
var
  strNotasComp: String;
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);

  If fEmptyStr(strCodOco) Or
    fOcorrenciaFinalizada(strCodOco) Then
  Begin
    Exit;
  End;

  strCodSit := FAcaFat.fGetSituacao();
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;
  strDtaCon := 0;
  strHorCon := 0;

  qryAux := fCriaQuery();

  Try
    strNotasComp   := '';

    qryAux.SQL.Add(sqlDocumentosAgConferencia);
    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;
    qryAux.Open();

    While Not qryAux.Eof Do
    Begin
      strNotasComp := strNotasComp + '| ' + fPadR(qryAux.FieldByName('PEDIDO').AsString, 19) +
        ' | ' + fPadR(qryAux.FieldByName('NOTAFISCAL').AsString, 16) +
        ' | ' + fPadR(qryAux.FieldByName('FORNECEDOR').AsString, 35) +
        ' |' + '<<csq>>' ;

      qryAux.Next();
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryAux);
{$ENDIF LINUX}
  End;

  If (Not fEmptyStr(strNotasComp)) Then
    strInfAdc := 'Documento(s) aguardando conferência: ' + '<<csq>>' +
                 '--------------------------------------------------------------------------------' + '<<csq>>' +
                 '| Pedido de Compra    | Nota Fiscal      | Fornecedor                          |' + '<<csq>>' +
                 '--------------------------------------------------------------------------------' + '<<csq>>' +
                 strNotasComp +
                 '--------------------------------------------------------------------------------' + '<<csq>>';

  strOpeHis := strLoginUsuarioLogado;
  strDescri := FAcaFat.fGetDescricao() + '<<csq>>' + '<<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' +
               FCodOpe + ' - ' + fRetNomeOperador(FCodOpe) + '<<csq>>';

  pInsereHistoricoOcorrencia;
  pAtualizaOcorrencia;
end;

procedure TAtuOcoCrm.pProcessaPedidoAgEnderecamento;
var
  strNotas: String;
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);

  If fEmptyStr(strCodOco) Or
    fOcorrenciaFinalizada(strCodOco) Then
  Begin
    Exit;
  End;

  strCodSit := FAcaFat.fGetSituacao();
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;
  strDtaCon := 0;
  strHorCon := 0;

  qryAux := fCriaQuery();

  Try
    strNotas   := '';

    qryAux.SQL.Add(sqlDocumentosAgEnderecamento);
    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;
    qryAux.Open();

    While Not qryAux.Eof Do
    Begin
      strNotas := strNotas + '| ' + fPadR(qryAux.FieldByName('PEDIDO').AsString,19)  +
        ' | ' + fPadR(qryAux.FieldByName('NOTAFISCAL').AsString, 16) +
        ' | ' + fPadR(qryAux.FieldByName('FORNECEDOR').AsString, 35) +
        ' |' + '<<csq>>' ;

      qryAux.Next();
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryAux);
{$ENDIF LINUX}
  End;

  If (Not fEmptyStr(strNotas)) Then
    strInfAdc := 'Documento(s) aguardando endereçamento: ' + '<<csq>>' +
                 '--------------------------------------------------------------------------------' + '<<csq>>' +
                 '| Pedido              | Nota Fiscal      | Fornecedor                          |' + '<<csq>>' +
                 '--------------------------------------------------------------------------------' + '<<csq>>' +
                 strNotas +
                 '--------------------------------------------------------------------------------' + '<<csq>>';

  strOpeHis := strLoginUsuarioLogado;
  strDescri := FAcaFat.fGetDescricao() + '<<csq>>' + '<<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' +
               FCodOpe + ' - ' + fRetNomeOperador(FCodOpe) + '<<csq>>';

  pInsereHistoricoOcorrencia;
  pAtualizaOcorrencia;
end;

procedure TAtuOcoCrm.pProcessaPedidoAgEntrada;
var
  strNotas: String;
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);

  If fEmptyStr(strCodOco) Or
    fOcorrenciaFinalizada(strCodOco) Then
  Begin
    Exit;
  End;

  strCodSit := FAcaFat.fGetSituacao();
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;
  strDtaCon := 0;
  strHorCon := 0;

  qryAux := fCriaQuery();

  Try
    strNotas   := '';

    qryAux.SQL.Add(sqlAgEntradaMercadoria);
    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;
    qryAux.Open();

    While Not qryAux.Eof Do
    Begin
      strNotas := strNotas + '| ' + qryAux.FieldByName('PEDIDO').AsString +
        ' | ' + fPadR(qryAux.FieldByName('NOTAFISCAL').AsString, 16) +
        ' | ' + fPadR(qryAux.FieldByName('FORNECEDOR').AsString, 35) +
        ' |' + '<<csq>>' ;

      qryAux.Next();
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryAux);
{$ENDIF LINUX}
  End;

  If (Not fEmptyStr(strNotas)) Then
    strInfAdc := 'Documento(s) aguardando entrada: ' + '<<csq>>' +
                 '--------------------------------------------------------------------------------' + '<<csq>>' +
                 '| Pedido              | Nota Fiscal      | Fornecedor                          |' + '<<csq>>' +
                 '--------------------------------------------------------------------------------' + '<<csq>>' +
                 strNotas +
                 '--------------------------------------------------------------------------------' + '<<csq>>';

  strOpeHis := strLoginUsuarioLogado;
  strDescri := FAcaFat.fGetDescricao() + '<<csq>>' + '<<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' +
               FCodOpe + ' - ' + fRetNomeOperador(FCodOpe) + '<<csq>>';

  pInsereHistoricoOcorrencia;
  pAtualizaOcorrencia;
end;

procedure TAtuOcoCrm.pProcessaPedidoAgEntrega;
var
  strNotasTransf: String;
  strNotasComp: String;
  strInformacoes: String;
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);

  If fEmptyStr(strCodOco) Or
    fOcorrenciaFinalizada(strCodOco) Then
  Begin
    Exit;
  End;

  strCodSit := FAcaFat.fGetSituacao();
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;
  strDtaCon := 0;
  strHorCon := 0;

  qryAux := fCriaQuery();

  Try
    strNotasTransf := '';
    strNotasComp   := '';

    qryAux.SQL.Add(sqlDocsDeTransferenciaAgEntrega);
    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;
    qryAux.Open();

    While Not qryAux.Eof Do
    Begin
      strNotasTransf := strNotasTransf + '| ' + qryAux.FieldByName('DET_NUMDOC').AsString +
        ' | ' + fPadR(qryAux.FieldByName('GER_SERIE_').AsString, 05) +
        ' | ' + fPadR(qryAux.FieldByName('DET_ESPDOC').AsString, 07) +
        ' | ' + fPadR(qryAux.FieldByName('DET_CODEMP').AsString, 07) +
        ' |' + '<<csq>>' ;

      qryAux.Next();
    End;

    qryAux.Close();
    qryAux.SQL.Clear();

    If (fCfgSis('TIPPNT') = 'D') Then
      qryAux.SQL.Add(sqlDocsDeCompraAgEntregaDepois)
    Else
      qryAux.SQL.Add(sqlDocsDeCompraAgEntrega);

    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;
    qryAux.Open();

    While Not qryAux.Eof Do
    Begin
      strNotasComp := strNotasComp + '| ' + qryAux.FieldByName('DOCUMENTO').AsString +
        ' | ' + fPadR(qryAux.FieldByName('FORNECEDOR').AsString, 35) +
        ' |' + '<<csq>>' ;

      qryAux.Next();
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryAux);
{$ENDIF LINUX}
  End;

  strInformacoes := '';

  If (Not fEmptyStr(strNotasTransf)) Then
  Begin
    strInformacoes := strInformacoes +
                      'Documentos de transferência: ' + '<<csq>>' +
                      '--------------------------------------------' + '<<csq>>' +
                      '| Documento    | Série | Espécie | Empresa |' + '<<csq>>' +
                      '--------------------------------------------' + '<<csq>>' +
                      strNotasTransf +
                      '--------------------------------------------' + '<<csq>>';
  End;

  If (Not fEmptyStr(strNotasComp)) Then
  Begin
    strInformacoes := strInformacoes + IIF((Not fEmptyStr(strInformacoes)), '<<csq>>', '') +
                      'Documentos de compra: ' + '<<csq>>' +
                      '-------------------------------------------------------------' + '<<csq>>' +
                      '| Documento           | Fornecedor                          |' + '<<csq>>' +
                      '-------------------------------------------------------------' + '<<csq>>' +
                      strNotasComp +
                      '-------------------------------------------------------------' + '<<csq>>';
  End;

  strInfAdc := strInformacoes;

  strOpeHis := strLoginUsuarioLogado;
  strDescri := FAcaFat.fGetDescricao() + '<<csq>>' + '<<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' +
               FCodOpe + ' - ' + fRetNomeOperador(FCodOpe) + '<<csq>>';

  pInsereHistoricoOcorrencia;
  pAtualizaOcorrencia;
end;

function TAtuOcoCrm.fOperadorAutomatico(const ACodOpe : String) : Boolean;
begin
  Result := True;
  If (ACodOpe = 'AUT') Then
    Exit;
  If (ACodOpe = '999') Then
    Exit;
  Result := False;
end;

function TAtuOcoCrm.fPedidoGeradoAPartirPedido: Boolean;
begin
  Result := (FEspDoc = 'PD') And
            (FEspDoc = FEspOrc) And
            (FEspOrc <> EmptyStr) And
            (FNumDoc <> FNumOrc) And
            (FNumOrc <> EmptyStr);
end;

procedure TAtuOcoCrm.pProcessaRegistroOcorrenciaStatus;
var
  strOperador: String;
begin
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,'');

  If fEmptyStr(strCodOco) Or
    fOcorrenciaFinalizada(strCodOco) Then
  Begin
    Exit;
  End;

  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;

  strOperador := FAcaFat.fGetOperador(FNumDoc, FEspDoc, FCodEmp);

  strOpeHis := strOperador;
  strCodSit := fRetornaCodSit(False);
  strDescri := FAcaFat.fGetDescricao() + '<<csq>><<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strOperador) +
               '<<csq>>' + DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) +
               ' - ' + strOperador + ' - ' + fRetNomeOperador(strOperador) + '<<csq>>';

  If (Not fEmptyStr(strOperador)) And (fOperadorAutomatico(strCodOpe)) Then
    strCodOpe := strOperador;

  If Not fEmptyStr(FCodOco) Then
  begin
    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  end;
end;

procedure TAtuOcoCrm.pProcessaPedidoAgPDTransferencia;
var
  strItens: String;
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  strOperador: String;
begin
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);

  If fEmptyStr(strCodOco) Or
    fOcorrenciaFinalizada(strCodOco) Then
  Begin
    Exit;
  End;

  strCodSit := FAcaFat.fGetSituacao();
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;
  strDtaCon := 0;
  strHorCon := 0;

  qryAux := fCriaQuery();

  Try
    strItens := '';

    qryAux.SQL.Add(sqlItensPendentesPDTransferencia);
    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;
    qryAux.Open();

    While Not qryAux.Eof Do
    Begin
      strItens := strItens + '| ' + fPadR(qryAux.FieldByName('PRE_EMPORI').AsString, 7) +
        ' | ' + fPadC(qryAux.FieldByName('PRE_CODITE').AsString, 06) +
        ' | ' + fPadR(qryAux.FieldByName('ITE_DESITE').AsString, 33) +
        ' | ' + fPadL(FloatToStrF(qryAux.FieldByName('PRE_QTDITE').AsFloat, ffFixed, 13, 2), 13) +
        ' |' + '<<csq>>' ;

      qryAux.Next();
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryAux);
{$ENDIF LINUX}
  End;

  strInfAdc := 'Itens aguardando pedido de transferência: ' + '<<csq>>' +
               '------------------------------------------------------------------------' + '<<csq>>' +
               '| Empresa | Código | Descrição                         |    Quantidade |' + '<<csq>>' +
               '------------------------------------------------------------------------' + '<<csq>>' +
               strItens +
               '------------------------------------------------------------------------' + '<<csq>>';

  strOperador := FAcaFat.fGetOperador(FNumDoc, FEspDoc, FCodEmp);

  strOpeHis := strOperador;
  strDescri := FAcaFat.fGetDescricao() + '<<csq>>' + '<<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strOperador) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' +
               strOperador + ' - ' + fRetNomeOperador(strOperador) + '<<csq>>';

  pInsereHistoricoOcorrencia;
  pAtualizaOcorrencia;
end;

procedure TAtuOcoCrm.pProcessaPedidoAgReqCompra;
var
  strItens: String;
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  strOperador: String;
begin
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);

  If fEmptyStr(strCodOco) Or
    fOcorrenciaFinalizada(strCodOco) Then
  Begin
    Exit;
  End;

  strCodSit := FAcaFat.fGetSituacao();
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;
  strDtaCon := 0;
  strHorCon := 0;

  qryAux := fCriaQuery();

  Try
    strItens := '';

    qryAux.SQL.Add(sqlItensPendentesReqCompra);
    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;
    qryAux.Open();

    While Not qryAux.Eof Do
    Begin
      strItens := strItens + '| ' + fPadR(qryAux.FieldByName('PRQ_EMPREQ').AsString, 7) +
        ' | ' + fPadC(qryAux.FieldByName('PRQ_CODITE').AsString, 06) +
        ' | ' + fPadR(qryAux.FieldByName('ITE_DESITE').AsString, 33) +
        ' | ' + fPadL(FloatToStrF(qryAux.FieldByName('PRQ_QTDITE').AsFloat, ffFixed, 13, 2), 13) +
        ' |' + '<<csq>>' ;

      qryAux.Next();
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryAux);
{$ENDIF LINUX}
  End;

  strInfAdc := 'Itens aguardando requisição de compra: ' + '<<csq>>' +
               '------------------------------------------------------------------------' + '<<csq>>' +
               '| Empresa | Código | Descrição                         |    Quantidade |' + '<<csq>>' +
               '------------------------------------------------------------------------' + '<<csq>>' +
               strItens +
               '------------------------------------------------------------------------' + '<<csq>>';

  strOperador := FAcaFat.fGetOperador(FNumDoc, FEspDoc, FCodEmp);

  strOpeHis := strOperador;
  strDescri := FAcaFat.fGetDescricao() + '<<csq>>' + '<<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strOperador) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' +
               strOperador + ' - ' + fRetNomeOperador(strOperador) + '<<csq>>';

  pInsereHistoricoOcorrencia;
  pAtualizaOcorrencia;
end;

procedure TAtuOcoCrm.pProcessaPedidoAgTransferencia;
var
  strPedidos: String;
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  strOperador: String;
begin
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);

  If fEmptyStr(strCodOco) Or
    fOcorrenciaFinalizada(strCodOco) Then
  Begin
    Exit;
  End;

  strCodSit := FAcaFat.fGetSituacao();
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;
  strDtaCon := 0;
  strHorCon := 0;

  qryAux := fCriaQuery();

  Try
    strPedidos := '';

    qryAux.SQL.Add(sqlItensAguardandoTransferencia);
    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;
    qryAux.Open();

    While Not qryAux.Eof Do
    Begin
      strPedidos := strPedidos + '| ' + qryAux.FieldByName('PRE_NUMDOC').AsString +
        ' | ' + fPadR(qryAux.FieldByName('PRE_ESPDOC').AsString, 07) +
        ' | ' + fPadR(qryAux.FieldByName('PRE_EMPDOC').AsString, 07) +
        ' |' + '<<csq>>' ;

      qryAux.Next();
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryAux);
{$ENDIF LINUX}
  End;

  strInfAdc := 'Documentos aguardando transferência:' + '<<csq>>' +
               '------------------------------------' + '<<csq>>' +
               '| Documento    | Espécie | Empresa |' + '<<csq>>' +
               '------------------------------------' + '<<csq>>' +
               strPedidos +
               '------------------------------------' + '<<csq>>';

  strOperador := FAcaFat.fGetOperador(FNumDoc, FEspDoc, FCodEmp);

  strOpeHis := strOperador;
  strDescri := FAcaFat.fGetDescricao() + '<<csq>>' + '<<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strOperador) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' +
               strOperador + ' - ' + fRetNomeOperador(strOperador) + '<<csq>>';

  pInsereHistoricoOcorrencia;
  pAtualizaOcorrencia;
end;

procedure TAtuOcoCrm.pProcessaAlteracaoCliente;
var
  tpEspDoc: TEspDoc;
begin
  tpEspDoc := fStrToTEspDoc(IIF((Pos(FEspDoc,'OR_PD_') = 0) or (FEspOrc = 'OR'), FEspOrc, FEspDoc));

  FBlnAtualizarCliente := True;

  Case tpEspDoc of
    tpOrcamento : pProcessaAlteracaoClienteOrcamento;
    tpPedido    : pProcessaAlteracaoClientePedido;
  End;

  FBlnAtualizarCliente := False;
end;

procedure TAtuOcoCrm.pProcessaAlteracaoClienteOrcamento;
Var
  strEspDocV : String;
  strNumDocV : String;
  strCodTocAnt: String;
  strCodOcoAnt: String;
  strNumDocAnt: String;
  strEspDocAnt: String;
  strCodSitAnt: String;
begin
  strNumDocAnt := FNumDoc;
  strEspDocAnt := FEspDoc;
  strCodSitAnt := FCodSit;
  strCodTocAnt := FCodToc;
  strCodOcoAnt := FCodOco;

  strEspDocV := IIF((Pos(FEspDoc,'OR_PD_') = 0) or (FEspOrc = 'OR'), FEspOrc, FEspDoc);
  strNumDocV := IIF((Pos(FEspDoc,'OR_PD_') = 0) or (fEmptyStr(FNumDoc)), FNumOrc, FNumDoc);

  FNumDoc := strNumDocV;
  FEspDoc := strEspDocV;
  FCodSit := FAcaFat.fGetSituacao(IIF(Pos(FEspDoc,'OR_PD_') = 0, FEspOrc, FEspDoc), IIF(blnOrcamentoTransformadoEmPedido, '', FEspOrc));
  strCodOco := fRetornaCodigoOcorrencia(strNumDocV,strEspDocV,FCodCliAnt,FCodEmp,'');

  If fEmptyStr(strCodOco) Then
    Exit;

  If (Pos(strEspDocV, 'OR_PD_') > 0) Then
    strCodToc := IIF(strEspDocV = 'OR',fCfgSis('VENORC', varString),fCfgSis('VENPED', varString));
  fObtemDadosDocumentoOcorrencia(FCodEmp, strEspDocV, FNumDoc);

  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := IIF((strDtaAge = 0), strDtaInc, strDtaAge);
  strHorAge := IIF((strHorAge = 0), strHorInc, strHorAge);
  strOpeHis := strLoginUsuarioLogado;
  strDescri := FAcaFat.fGetDescricao() + '<<csq>>' +
               'Número Documento : ' + FNumDoc    + '<<csq>>' +
               'Espécie          : ' + FEspDoc    + '<<csq>>' +
               'Empresa          : ' + FCodEmp    + '<<csq>>' +
               'Cliente Atual    : ' + FCodCli    + '<<csq>>' +
               'Cliente Anterior : ' + FCodCliAnt + '<<csq>>' +
                fDadosConsumidor+
               '<<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe);

  If blnOrcamentoTransformadoEmPedido Then
  Begin
    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  End
  Else
  Begin
    strDtaCon := fNow;
    strHorCon := fNow;
    pFinalizaOcorrencia(strDescri);
  End;

  FCodToc := strCodTocAnt;
  FCodOco := strCodOcoAnt;
  FNumDoc := strNumDocAnt;
  FEspDoc := strEspDocAnt;
end;

procedure TAtuOcoCrm.pProcessaAlteracaoClientePedido;
Var
  strEspDocV : String;
  strNumDocV : String;
  strCodTocAnt: String;
  strCodOcoAnt: String;
  strNumDocAnt: String;
  strEspDocAnt: String;
  strCodSitAnt: String;
begin
  strNumDocAnt := FNumDoc;
  strEspDocAnt := FEspDoc;
  strCodSitAnt := FCodSit;
  strCodTocAnt := FCodToc;
  strCodOcoAnt := FCodOco;

  strEspDocV := IIF(Pos(FEspDoc,'OR_PD_') = 0, FEspOrc, FEspDoc);
  strNumDocV := IIF((Pos(FEspDoc,'OR_PD_') = 0) or (fEmptyStr(FNumDoc)), FNumOrc, FNumDoc);

  FCodSit := FAcaFat.fGetSituacao(strEspDocV, IIF(blnOrcamentoTransformadoEmPedido, '', FEspOrc));
  FNumDoc := strNumDocV;
  FEspDoc := strEspDocV;
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,strEspDocV,FCodCliAnt,FCodEmp,'');

  If fEmptyStr(strCodOco) Then
    Exit;

  fObtemDadosDocumentoOcorrencia(FCodEmp, strEspDocV, FNumDoc);

  If (Pos(strEspDocV, 'OR_PD_') > 0) Then
    strCodToc := IIF(strEspDocV = 'OR',fCfgSis('VENORC', varString),fCfgSis('VENPED', varString));

  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := strDtaInc;
  strHorAge := strHorInc;

  If (strTip_FC <> 'P') Then
  Begin
    strDtaCon := fNow;
    strHorCon := fNow;
  End;

  strOpeHis := strLoginUsuarioLogado;
  strDescri := FAcaFat.fGetDescricao() + '<<csq>>' +
               'Número Documento : ' + FNumDoc    + '<<csq>>' +
               'Espécie          : ' + FEspDoc    + '<<csq>>' +
               'Empresa          : ' + FCodEmp    + '<<csq>>' +
               'Cliente Atual    : ' + FCodCli    + '<<csq>>' +
               'Cliente Anterior : ' + FCodCliAnt + '<<csq>>' +
                fDadosConsumidor+
               '<<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe);

  pInsereHistoricoOcorrencia;
  pAtualizaOcorrencia;

  FCodToc := strCodTocAnt;
  FCodOco := strCodOcoAnt;
  FNumDoc := strNumDocAnt;
  FEspDoc := strEspDocAnt;

end;

procedure TAtuOcoCrm.pProcessaAlteracaoTemperaturaAntend;
begin
  If fEmptyStr(strCodOco) Then
    Exit;

  strDtaInc := VS_Date;
  strHorInc := fTime();
  strDtaAge := VS_Date;
  strHorAge := fTime();
  strOpeHis := strLoginUsuarioLogado;
  strDescri := FAcaFat.fGetDescricao() + '<<csq>><<csq>>' +
               'Temperatura Atendimento:' + FCodTea + ' - ' + FDesTea  + '<<csq>>' + '<<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) +
               '<<csq>>' + DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe);

  pInsereHistoricoOcorrencia;
  pAtualizaOcorrencia;
end;

procedure TAtuOcoCrm.pProcessaBaixaPedidoNaoEntregue;
begin
  strDescri := EmptyStr;
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := strDtaInc;
  strHorAge := strHorInc;
  strDtaCon := strDtaInc;
  strHorCon := strHorInc;
  strOpeHis := strLoginUsuarioLogado;
  strCodOpe := strLoginUsuarioLogado;
  strDescri := 'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) +   '<<csq>>' +
               DateToStr(VS_Date) + ' ' + TimeToStr(fRetHoraServidor) + ' - ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
               IfThen(Not fEmptyStr(strDescri), strDescri + '<<csq>>', '') + 'Finalizando a Ocorrência.';


  pInsereHistoricoOcorrencia;
  pAtualizaOcorrencia;
end;

procedure TAtuOcoCrm.pProcessaCancelamentoDocumento;
begin
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,'');
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strOpeHis := strLoginUsuarioLogado;
  strDtaAge := strDtaInc;
  strHorAge := strHorInc;
  strDtaCon := VS_Date;
  strHorCon := fNow;
  If Pos(strEspDoc, 'PD') > 0 Then
    strCodToc := fCfgSis('PEDCAN', varString)
  Else
    strCodToc := fCfgSis('VENCAN', varString);

  strDescri := afcDocumentoCancelado.fGetDescricao() + '<<csq>>' +
               'FINALIZANDO OCORRÊNCIA.' + '<<csq>><<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                DateToStr(VS_Date) + ' ' + TimeToStr(fNow) + ' - ' + strCodOpe + ' - ' + fRetNomeOperador(strCodOpe);

  If (Not fEmptyStr(strCodOco)) Then
  Begin
    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  End;
end;

procedure TAtuOcoCrm.pProcessaCompraEfetuada;
var
  strItens: String;
  strNumPed: String;
  strEspPed: String;
  strEmpPed: String;
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  qryGen: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qryAux := fCriaQuery();
  qryGen := fCriaQuery();

  Try
    qryGen.SQL.Add(sqlRequisicoesAtendidaPedCompra);
    qryGen.ParamByName('NUMDOC').AsString := FNumDoc;
    qryGen.ParamByName('ESPDOC').AsString := FEspDoc;
    qryGen.ParamByName('CODEMP').AsString := FCodEmp;
    qryGen.Open();

    If qryGen.IsEmpty() Then
      Exit;

    strNumPed := FNumDoc;
    strEspPed := FEspDoc;
    strEmpPed := FCodEmp;

    While (Not qryGen.Eof) Do
    Begin
      FNumDoc := qryGen.FieldByName('RCD_DOCPDV').AsString;
      FEspDoc := qryGen.FieldByName('RCD_ESPPDV').AsString;
      FCodEmp := qryGen.FieldByName('RCD_EMPPDV').AsString;

      strItens := '';

      qryAux.Close();
      qryAux.SQL.Clear();
      qryAux.SQL.Add(sqlItensCompraEfetuada);
      qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
      qryAux.ParamByName('CODEMP').AsString := FCodEmp;
      qryAux.ParamByName('NUMPED').AsString := strNumPed;
      qryAux.ParamByName('ESPPED').AsString := strEspPed;
      qryAux.ParamByName('EMPPED').AsString := strEmpPed;
      qryAux.Open();

      strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);

      If fEmptyStr(strCodOco) Or
        fOcorrenciaFinalizada(strCodOco) Then
      Begin
        qryGen.Next();
        Continue;
      End;

      strCodSit := FAcaFat.fGetSituacao();
      strDtaInc := VS_Date;
      strHorInc := fRetHoraServidor();
      strDtaAge := VS_Date;
      strHorAge := strHorInc;
      strDtaCon := 0;
      strHorCon := 0;

      While Not qryAux.Eof Do
      Begin
        strItens := strItens + '| ' + fPadC(qryAux.FieldByName('PCD_CODITE').AsString, 06) +
          ' | ' + fPadR(qryAux.FieldByName('PCD_DESITE').AsString, 33) +
          ' | ' + fPadL(FloatToStrF(qryAux.FieldByName('PCD_QTDITE').AsFloat, ffFixed, 13, 2), 13) +
          ' |' + '<<csq>>' ;

        qryAux.Next();
      End;

      strInfAdc := 'Itens comprados: ' + '<<csq>>' +
                   '--------------------------------------------------------------' + '<<csq>>' +
                   '| Código | Descrição                         |    Quantidade |' + '<<csq>>' +
                   '--------------------------------------------------------------' + '<<csq>>' +
                   strItens +
                   '--------------------------------------------------------------';

      strOpeHis := strLoginUsuarioLogado;
      strDescri := FAcaFat.fGetDescricao() + '<<csq>>' +
                   'Número Pedido : ' + strNumPed + '<<csq>>' +
                   'Espécie       : ' + FEspDoc + '<<csq>>' +
                   'Empresa       : ' + strEmpPed + '<<csq>>' +
                   'Fornecedor    : ' + qryAux.FieldByName('FORNECEDOR').AsString + '<<csq>><<csq>>' +
                   'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                   DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' +
                   FCodOpe + ' - ' + fRetNomeOperador(FCodOpe) + '<<csq>>';

      pInsereHistoricoOcorrencia;
      pAtualizaOcorrencia;

      qryGen.Next();
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryAux);
    FreeAndNil(qryGen);
{$ENDIF LINUX}
  End;
end;

procedure TAtuOcoCrm.pProcessaRegistroOcorrenciaRomaneio;
var
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  strAux: String;
begin
  qryAux := fCriaQuery();

  Try
    qryAux.SQL.Add(sqlPedidoPelaNotaFiscal);
    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;
    qryAux.Open();

    If qryAux.IsEmpty Then
      Exit;

    strCodOco := fRetornaCodigoOcorrencia(qryAux.FieldByName('FGO_NUMDOC').AsString,
                                          qryAux.FieldByName('FGO_ESPDOC').AsString,
                                          FCodCli,
                                          qryAux.FieldByName('FGO_CODEMP').AsString,
                                          FNumRom,
                                          FNumOrc,
                                          FEspOrc);

    If fEmptyStr(strCodOco) Or
      fOcorrenciaFinalizada(strCodOco) Then
    Begin
      Exit;
    End;

    strCodSit := FAcaFat.fGetSituacao();
    strDtaInc := VS_Date;
    strHorInc := fRetHoraServidor();
    strDtaAge := VS_Date;
    strHorAge := strHorInc;
    strDtaCon := 0;
    strHorCon := 0;

    strOpeHis := strLoginUsuarioLogado;

    strAux := FAcaFat.fGetDescricao() + '<<csq>><<csq>>' +
              strDescri;
    strDescri := strAux;

    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryAux);
{$ENDIF LINUX}
  End;
end;

procedure TAtuOcoCrm.pProcessaRequisicaoCompraGerada;
var
  strRequisicoes: String;
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);

  If fEmptyStr(strCodOco) Or
    fOcorrenciaFinalizada(strCodOco) Then
  Begin
    Exit;
  End;

  strCodSit := FAcaFat.fGetSituacao();
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;
  strDtaCon := 0;
  strHorCon := 0;

  qryAux := fCriaQuery();

  Try
    strRequisicoes := '';

    qryAux.SQL.Add(sqlItensReqCompraGerada);
    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;
    qryAux.Open();

    While Not qryAux.Eof Do
    Begin
      strRequisicoes := strRequisicoes + '| ' + qryAux.FieldByName('PRQ_CODREQ').AsString +
        ' | ' + fPadR(qryAux.FieldByName('PRQ_EMPREQ').AsString, 07) +
        ' |' + '<<csq>>' ;

      qryAux.Next();
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryAux);
{$ENDIF LINUX}
  End;

  strInfAdc := 'Requisições geradas: ' + '<<csq>>' +
               '--------------------' + '<<csq>>' +
               '| Número | Empresa |' + '<<csq>>' +
               '--------------------' + '<<csq>>' +
               strRequisicoes +
               '--------------------' + '<<csq>>';

  strOpeHis := FAcaFat.fGetOperador(FNumDoc, FEspDoc, FCodEmp);
  strDescri := FAcaFat.fGetDescricao() + '<<csq>>' + '<<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' +
               FCodOpe + ' - ' + fRetNomeOperador(FCodOpe) + '<<csq>>';

  pInsereHistoricoOcorrencia;
  pAtualizaOcorrencia;
end;

procedure TAtuOcoCrm.pProcessaRequisicaoCompraNegada;
begin

  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;

  If (FAcaFat = afcRomaneioBaixa) Then
  Begin
    strDtaCon := VS_Date;
    strHorCon := fTime();
    strCodSit := FAcaFat.fGetSituacao();
  End
  Else
  Begin
    strDtaCon := 0;
    strHorCon := 0;
  End;

  strOpeHis := FAcaFat.fGetOperador(FNumDoc, FEspDoc, FCodEmp);
  strDescri := FAcaFat.fGetDescricao() + '<<csq>>' + FDescri;

  If Not fEmptyStr(FCodOco) Then
  begin
    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  end;

end;

procedure TAtuOcoCrm.pProcessaSeparacaoImpressa;
begin
  FDtaInc := VS_Date;
  FHorInc := fRetHoraServidor();
  FDtaAge := strDtaInc;
  FHorAge := strHorInc;
  strOpeHis := strLoginUsuarioLogado;
  FDtaCon := 0;
  FHorCon := 0;
  FCodSit := afcSeparacaoImpressa.fGetSituacao();
  FDescri := afcSeparacaoImpressa.fGetDescricao() + '.' + '<<csq>><<csq>>' +
                                 'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                                  DateToStr(VS_Date) + ' ' + TimeToStr(fNow) + ' - ' + strCodOpe + ' - ' + fRetNomeOperador(strCodOpe);
  pInsereHistoricoOcorrencia;
  pAtualizaOcorrencia;
end;

procedure TAtuOcoCrm.pReabreOcorrencia(const strCodOco, strCodEmp, strDescricao, strCodCoc, strCodToc: string; strCodOpe: String = '');
begin
  FReabreOcorrencia := True;
  FCodOco := strCodOco;
  FDtaInc := VS_Date;
  FHorInc := fRetHoraServidor();
  FDtaAge := FDtaInc;
  FHorAge := FHorInc;
  FDtaCon := 0;
  FHorCon := 0;
  FOpeHis := strLoginUsuarioLogado;
  FCodOpe := IIF(fEmptyStr(strCodOpe), strLoginUsuarioLogado, strCodOpe);
  FDescri := strDescricao;
  FCodEmp := strCodEmp;
  FCodCoc := strCodCoc;
  FCodToc := strCodToc;

  pInsereHistoricoOcorrencia;
  pAtualizaOcorrencia;
end;

procedure TAtuOcoCrm.pProcessaRequisicaoCompraDesvinculada;
begin
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);

  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;

  strDtaCon := 0;
  strHorCon := 0;

  strOpeHis := FAcaFat.fGetOperador(FNumDoc, FEspDoc, FCodEmp);
  strDescri := FAcaFat.fGetDescricao() + ' ' + FDescri;

  If Not fEmptyStr(FCodOco) Then
  begin
    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  end;
end;

procedure TAtuOcoCrm.pProcessaFatRomaneioBaixa;
begin
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;

  If (FAcaFat = afcRomaneioBaixa) Then
  Begin
    strDtaCon := VS_Date;
    strHorCon := fTime();
    strCodSit := FAcaFat.fGetSituacao();
  End
  Else
  Begin
    strDtaCon := 0;
    strHorCon := 0;
  End;

  strOpeHis := strLoginUsuarioLogado;
  strDescri := FAcaFat.fGetDescricao() + '<<csq>>' +
               'Número Romaneio  : ' + FNumRom + '<<csq>>' +
               'Empresa          : ' + FCodEmp + '<<csq>>' +
               IIF(fEmptyStr(FDHBaix, True), '', 'Data/Hora        : ' + FDHBaix + '<<csq>>') +
               IIF(fEmptyStr(FNomRec), '', 'Recebido Por     : ' + FNomRec + '<<csq>>') +
               'Número Documento : ' + FNumDoc + '<<csq>>' +
               'Espécie          : ' + FEspDoc + '<<csq>><<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe);

  If Not fEmptyStr(FCodOco) Then
  begin
    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  end;
end;

procedure TAtuOcoCrm.pProcessaFatRomaneioExclusao;
begin
  strCodSit := FAcaFat.fGetSituacao();
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,'',FNumOrc,FEspOrc);
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;
  strOpeHis := strLoginUsuarioLogado;
  strDescri := FAcaFat.fGetDescricao() + '<<csq>>' +
               'Número Romaneio  : ' + FNumRom + '<<csq>>' +
               'Empresa          : ' + FCodEmp + '<<csq>>' +
               'Data             : ' + DateToStr(FDtaInc) + '<<csq>>' +
               'Número Documento : ' + FNumDoc + '<<csq>>' +
               'Espécie          : ' + FEspDoc + '<<csq>><<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' +
               FCodOpe + ' - ' + fRetNomeOperador(FCodOpe) + '<<csq>>';

  If Not fEmptyStr(FCodOco) Then
  begin
    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  end;
end;

procedure TAtuOcoCrm.pProcessaDevolucao;
Begin
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;
  strDtaCon := 0;
  strHorCon := 0;

  strOpeHis := strLoginUsuarioLogado;
  strDescri := FAcaFat.fGetDescricao() + '<<csq>>' +
               'Reabertura de ocorrência por devolução de mercadorias ' +'<<csq>>' +
               'Documento       : ' + FNumDoc + '-' + FEspDoc + '<<csq>>' +
               'Empresa         : ' + FCodEmp + '<<csq>><<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe);

  If Not fEmptyStr(FCodOco) Then
  begin
    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  end;
End;

procedure TAtuOcoCrm.pProcessaEnderecamentoFinalizado;
var
  strNotas: String;
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qryAux := fCriaQuery();
  Try
    qryAux.SQL.Add(sqlEnderecamentoFinalizado);
    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;
    qryAux.Open();

    If qryAux.IsEmpty() Then
      Exit;

    strNotas   := '';

    While (Not qryAux.Eof) Do
    Begin
      FNumDoc := qryAux.FieldByName('PEDVEN').AsString;
      FEspDoc := qryAux.FieldByName('ESPVEN').AsString;
      FCodEmp := qryAux.FieldByName('EMPVEN').AsString;

      strNotas := strNotas + '| ' + qryAux.FieldByName('PEDIDO').AsString +
        ' | ' + fPadR(qryAux.FieldByName('NOTAFISCAL').AsString, 16) +
        ' | ' + fPadR(qryAux.FieldByName('FORNECEDOR').AsString, 35) +
        ' |' + '<<csq>>' ;

      qryAux.Next();

      If ((Concat(FNumDoc, FEspDoc, FCodEmp) <>
           Concat(qryAux.FieldByName('PEDVEN').AsString,
                  qryAux.FieldByName('ESPVEN').AsString,
                  qryAux.FieldByName('EMPVEN').AsString)) Or
          (qryAux.Eof)) Then
      Begin
        strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);

        If fEmptyStr(strCodOco) Or
          fOcorrenciaFinalizada(strCodOco) Then
        Begin
          qryAux.Next();
          Continue;
        End;

        strCodSit := FAcaFat.fGetSituacao();
        strDtaInc := VS_Date;
        strHorInc := fRetHoraServidor();
        strDtaAge := VS_Date;
        strHorAge := strHorInc;
        strDtaCon := 0;
        strHorCon := 0;

        If (Not fEmptyStr(strNotas)) Then
          strInfAdc := 'Documento(s) endereçado(s): ' + '<<csq>>' +
                       '--------------------------------------------------------------------------------' + '<<csq>>' +
                       '| Pedido              | Nota Fiscal      | Fornecedor                          |' + '<<csq>>' +
                       '--------------------------------------------------------------------------------' + '<<csq>>' +
                       strNotas +
                       '--------------------------------------------------------------------------------' + '<<csq>>';

        strOpeHis := strLoginUsuarioLogado;
        strDescri := FAcaFat.fGetDescricao() + '<<csq>>' + '<<csq>>' +
                     'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                     DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' +
                     FCodOpe + ' - ' + fRetNomeOperador(FCodOpe) + '<<csq>>';

        pInsereHistoricoOcorrencia;
        pAtualizaOcorrencia;

        strNotas   := '';
      End;
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryAux);
{$ENDIF LINUX}
  End;
end;

procedure TAtuOcoCrm.pProcessaEntradaMercadoria;
var
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  strNumNot: String;
begin
  qryAux := fCriaQuery();
  Try
    qryAux.SQL.Add(sqlEntradaMercadoria);
    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;
    qryAux.Open();

    If qryAux.IsEmpty() Then
      Exit;

    strNumNot := FNumDoc;

    While (Not qryAux.Eof) Do
    Begin
      FNumDoc := qryAux.FieldByName('PEDVEN').AsString;
      FEspDoc := qryAux.FieldByName('ESPVEN').AsString;
      FCodEmp := qryAux.FieldByName('EMPVEN').AsString;

      strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,FNumRom,FNumOrc,FEspOrc);

      If fEmptyStr(strCodOco) Or
        fOcorrenciaFinalizada(strCodOco) Then
      Begin
        qryAux.Next();
        Continue;
      End;

      strCodSit := FAcaFat.fGetSituacao();
      strDtaInc := VS_Date;
      strHorInc := fRetHoraServidor();
      strDtaAge := VS_Date;
      strHorAge := strHorInc;
      strDtaCon := 0;
      strHorCon := 0;

      strOpeHis := strLoginUsuarioLogado;
      strDescri := FAcaFat.fGetDescricao() + '<<csq>>' + '<<csq>>' +
                   'Nota Fiscal: ' + Concat(strNumNot, '-',
                                            qryAux.FieldByName('DET_SERIE_').AsString) + '<<csq>>' +
                   'Pedido     : ' + qryAux.FieldByName('PEDCOM').AsString + '<<csq>>' +
                   'Espécie    : ' + qryAux.FieldByName('ESPCOM').AsString + '<<csq>>' +
                   'Empresa    : ' + qryAux.FieldByName('EMPCOM').AsString + '<<csq>>' + '<<csq>>' +
                   'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                   DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' +
                   FCodOpe + ' - ' + fRetNomeOperador(FCodOpe) + '<<csq>>';

      pInsereHistoricoOcorrencia;
      pAtualizaOcorrencia;

      qryAux.Next();
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryAux);
{$ENDIF LINUX}
  End;
end;

procedure TAtuOcoCrm.pProcessaFatRomaneioInclusao;
begin
  strCodSit := FAcaFat.fGetSituacao();
  strCodOco := fRetornaCodigoOcorrencia(FNumDoc,FEspDoc,FCodCli,FCodEmp,'',FNumOrc,FEspOrc);
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;
  strOpeHis := strLoginUsuarioLogado;
  strDescri := FAcaFat.fGetDescricao() + '<<csq>>' +
               'Número Romaneio  : ' + FNumRom + '<<csq>>' +
               'Empresa          : ' + FCodEmp + '<<csq>>' +
               'Data             : ' + DateToStr(FDtaInc) + '<<csq>>' +
               'Motorista        : ' + fRetNomeMotorista(FCodMot) + '<<csq>>' +
               'Transportadora   : ' + fRetNomTransportadora(FCodTra) + '<<csq>>' +
               'Número Documento : ' + FNumDoc + '<<csq>>' +
               'Espécie          : ' + FEspDoc + '<<csq>><<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe);

  If Not fEmptyStr(FCodOco) Then
  begin
    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  end;
end;

procedure TAtuOcoCrm.pProcessaFaturamentoPedidoAgrupado;
var
  strEspDocAgrp: String;
  strNumDocAgrp: String;
  strEmpDocAgrp: String;
begin
  strEspDocAgrp := FEspDoc;
  strNumDocAgrp := FNumDoc;
  strEmpDocAgrp := FCodEmp;
  strCodOco := fRetornaCodigoOcorrencia(FNumOrc,FEspOrc,FCodCli,FCodEmp,'');
  pCarregaOcorrencia(strTip_Fc,
                     strCodOco,
                     FCodEmp);

  If fEmptyStr(strCodOco) Or
    fOcorrenciaFinalizada(strCodOco) Then
  Begin
    Exit;
  End;

  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;
  strOpeHis := strLoginUsuarioLogado;
  strCodOpe := strLoginUsuarioLogado;
  strDescri := FAcaFat.fGetDescricao() + '<<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe) + '<<csq>>';

  FMotFinOco := 'Agrupamento em novo documento';
  FDesMotFin := strNumDocAgrp + '-' +strEspDocAgrp;
  If Not fEmptyStr(FCodOco) Then
  begin
    pFinalizaOcorrencia(strDescri);
  end;
end;

procedure TAtuOcoCrm.pProcessaFatVendaOrcamentoPedido;
begin
  strCodOco := fRetornaCodigoOcorrencia(FNumOrc,FEspOrc,FCodCli,FCodEmp,'');
  strDtaInc := VS_Date;
  strHorInc := fRetHoraServidor();
  strDtaAge := VS_Date;
  strHorAge := strHorInc;
  strOpeHis := strLoginUsuarioLogado;
  strDescri := FAcaFat.fGetDescricao() + '<<csq>>' +
               'NOVO DOCUMENTO CRIADO.' + '<<csq>>' +
               'Número Documento : ' + FNumDoc + '<<csq>>' +
               'Espécie          : ' + FEspDoc + '<<csq>>' +
               'Empresa          : ' + FCodEmp + '<<csq>><<csq>>' +
               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
               DateToStr(strDtaInc) + ' ' + TimeToStr(strHorInc) + ' - ' + FCodOpe + ' - ' + fRetNomeOperador(FCodOpe);

  If Not fEmptyStr(FCodOco) Then
  begin
    pInsereHistoricoOcorrencia;
    pAtualizaOcorrencia;
  end;
end;

function TAtuOcoCrm.fGravouNovaOcorrencia: Boolean;
begin
  Result := FResultadoNovaOcorrencia;
end;

function TAtuOcoCrm.fGravouHistoricoOcorrencia: Boolean;
begin
  Result := FResultadoHistoricoOcorrencia;
end;

{ TTriggerCRM }
function TUpdateOccurrenceCRM.CodCli(const AValue: String): IUpdateOccurrenceCRM;
begin
  FCodCli := AValue;
  Result := Self;
end;

function TUpdateOccurrenceCRM.CodEmp(const AValue: String): IUpdateOccurrenceCRM;
begin
  FCodEmp := AValue;
  Result := Self;
end;

function TUpdateOccurrenceCRM.CodIte(
  const AValue: String): IUpdateOccurrenceCRM;
begin
  Result := Self;
  FCodIte := AValue;
end;

function TUpdateOccurrenceCRM.CodMot(
  const AValue: String): IUpdateOccurrenceCRM;
begin
  FCodMot := AValue;
  Result := Self;
end;

function TUpdateOccurrenceCRM.CodOpe(
  const AValue: String): IUpdateOccurrenceCRM;
begin
  FCodOpe := AValue;
  Result := Self;
end;

function TUpdateOccurrenceCRM.CodTra(
  const AValue: String): IUpdateOccurrenceCRM;
begin
  FCodTra := AValue;
  Result := Self;
end;

constructor TUpdateOccurrenceCRM.Create;
begin
  FNumDoc := '';
  FEspDoc := '';
  FCodEmp := '';
  FCodCli := '';
  FEspOrc := '';
  FNumOrc := '';
  FDescri := '';
  FInfAdc := '';
  FCodOpe := strLoginUsuarioLogado;
  FAcaFat := afcNenhum;
  FNumRom := '';
  FCodMot := '';
  FCodTra := '';

  FAtuOcoCRM := TAtuOcoCrm.Create(Nil);
end;

function TUpdateOccurrenceCRM.Descri(
  const AValue: String): IUpdateOccurrenceCRM;
begin
  FDescri := AValue;
  Result := Self;
end;

function TUpdateOccurrenceCRM.DesIte(
  const AValue: String): IUpdateOccurrenceCRM;
begin
  Result := Self;
  FDesIte := AValue;
end;

destructor TUpdateOccurrenceCRM.Destroy;
begin
  FreeAndNil(FAtuOcoCRM);
  inherited;
end;

function TUpdateOccurrenceCRM.EmpFat(
  const AValue: String): IUpdateOccurrenceCRM;
begin
  FEmpFat := AValue;
  Result := Self;
end;

function TUpdateOccurrenceCRM.EspDoc(const AValue: String): IUpdateOccurrenceCRM;
begin
  FEspDoc := AValue;
  Result := Self;
end;

function TUpdateOccurrenceCRM.EspOrc(
  const AValue: String): IUpdateOccurrenceCRM;
begin
  FEspOrc := AValue;
  Result := Self;
end;

function TUpdateOccurrenceCRM.blnImpSfa(
  const AValue: Boolean): IUpdateOccurrenceCRM;
begin
  FblnImpSfa := AValue;
  Result := Self;
end;

function TUpdateOccurrenceCRM.InfAdc(const AValue: String): IUpdateOccurrenceCRM;
begin
  FInfAdc := AValue;
  Result := Self;
end;

class function TUpdateOccurrenceCRM.New: IUpdateOccurrenceCRM;
begin
  Result := TUpdateOccurrenceCRM.Create();
end;

function TUpdateOccurrenceCRM.NomCli(
  const AValue: String): IUpdateOccurrenceCRM;
begin
  Result := Self;
  FNomCli := AValue;
end;

function TUpdateOccurrenceCRM.NumDoc(const AValue: String): IUpdateOccurrenceCRM;
begin
  FNumDoc := AValue;
  Result := Self;
end;

function TUpdateOccurrenceCRM.NumOrc(
  const AValue: String): IUpdateOccurrenceCRM;
begin
  FNumOrc := AValue;
  Result := Self;
end;

function TUpdateOccurrenceCRM.NumRom(
  const AValue: String): IUpdateOccurrenceCRM;
begin
  FNumRom := AValue;
  Result := Self;
end;

procedure TUpdateOccurrenceCRM.pRun;
begin
  FAtuOcoCRM.strNumDoc := FNumDoc;
  FAtuOcoCRM.strEspDoc := FEspDoc;
  FAtuOcoCRM.strCodEmp := FCodEmp;
  FAtuOcoCRM.strCodCli := FCodCli;
  FAtuOcoCRM.strNumOrc := FNumOrc;
  FAtuOcoCRM.strEspOrc := FEspOrc;
  FAtuOcoCRM.strEmpFat := FEmpFat;
  FAtuOcoCRM.strCodOpe := FCodOpe;
  FAtuOcoCRM.afcAcaFat := FAcaFat;
  FAtuOcoCRM.strDescri := FDescri;
  FAtuOcoCRM.strInfAdc := FInfAdc;
  FAtuOcoCRM.blnImpSfa := FblnImpSfa;
  FAtuOcoCRM.strNomFrm := FstrNomFrm;
  FAtuOcoCRM.strTip_Fc := FTip_Fc;
  FAtuOcoCRM.strNumRom := FNumRom;
  FAtuOcoCRM.strCodMot := FCodMot;
  FAtuOcoCRM.strCodTra := FCodTra;
  FAtuOcoCRM.strCodIte := FCodIte;
  FAtuOcoCRM.strDesIte := FDesIte;
  FAtuOcoCRM.dobQtdIte := FQtdIte;
  FAtuOcoCRM.strNomCli := FNomCli;
  FAtuOcoCRM.pProcessaFatOcorrenciasCRM();
end;

function TUpdateOccurrenceCRM.QtdIte(
  const AValue: Double): IUpdateOccurrenceCRM;
begin
  Result := Self;
  FQtdIte := AValue;
end;

function TUpdateOccurrenceCRM.strNomFrm(
  const AValue: String): IUpdateOccurrenceCRM;
begin
  FstrNomFrm := AValue;
  Result := Self;
end;

function TUpdateOccurrenceCRM.Tip_Fc(
  const AValue: String): IUpdateOccurrenceCRM;
begin
  FTip_Fc := AValue;
  Result := Self;
end;

function TUpdateOccurrenceCRM.AcaFat(const AValue: TAcaoFatCRM): IUpdateOccurrenceCRM;
begin
  FAcaFat := AValue;
  Result := Self;
end;

{ TInvokerUpdateOcurrenceCRM }

constructor TInvokerUpdateOcurrenceCRM.Create;
begin
  FCommandList := TInterfaceList.Create();
end;

destructor TInvokerUpdateOcurrenceCRM.Destroy;
begin
  FCommandList.Clear();
  FCommandList.Free();
  inherited;
end;

class function TInvokerUpdateOcurrenceCRM.New: IInvokerUpdateOcurrenceCRM;
begin
  Result := TInvokerUpdateOcurrenceCRM.Create();
end;

procedure TInvokerUpdateOcurrenceCRM.pAdd(ACommand: IUpdateOccurrenceCRM);
begin
  FCommandList.Add(ACommand);
end;

procedure TInvokerUpdateOcurrenceCRM.pRun;
var
  LIdx: Integer;
begin
  For LIdx := 0 To Pred(FCommandList.Count) Do
    IUpdateOccurrenceCRM(
      FCommandList[LIdx]
    ).pRun();
end;

{ TDeleteOccurrenceCRM }

function TDeleteOccurrenceCRM.CodEmp(
  const AValue: String): IDeleteOccurrenceCRM;
begin
  FCodEmp := AValue;
  Result := Self;
end;

constructor TDeleteOccurrenceCRM.Create;
begin
  FCodEmp := '';
  FNumDoc := '';
  FEspDoc := '';
end;

function TDeleteOccurrenceCRM.EspDoc(
  const AValue: String): IDeleteOccurrenceCRM;
begin
  FEspDoc := AValue;
  Result := Self;
end;

class function TDeleteOccurrenceCRM.New: IDeleteOccurrenceCRM;
begin
  Result := TDeleteOccurrenceCRM.Create();
end;

function TDeleteOccurrenceCRM.NomFrm(
  const AValue: String): IDeleteOccurrenceCRM;
begin
  FstrNomFrm := AValue;
  Result := Self;
end;

function TDeleteOccurrenceCRM.NumDoc(
  const AValue: String): IDeleteOccurrenceCRM;
begin
  FNumDoc := AValue;
  Result := Self;
end;

procedure TDeleteOccurrenceCRM.pDelete;
var
  LQryOco: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LQryHis: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LDelOco: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LUpdOco: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQryOco := fCriaQuery();
  LQryHis := fCriaQuery();
  LDelOco := fCriaQuery();
  LUpdOco := fCriaQuery();

  Try
    LQryOco.SQL.Add(sqlBackupMovOcoCRM);
    LQryOco.ParamByName('NUMDOC').AsString := FNumDoc;
    LQryOco.ParamByName('ESPDOC').AsString := FEspDoc;
    LQryOco.ParamByName('CODEMP').AsString := FCodEmp;
    LQryOco.Open();

    If LQryOco.IsEmpty Then
      Exit;

    LQryHis.SQL.Add(sqlBackupHisOcoCRM);
    LUpdOco.SQL.Add(sqlUpdateMovOcoCrm);
    LDelOco.SQL.Add(sqlDeleteMovOcoCRM);

    While (Not LQryOco.Eof) Do
    Begin
      LQryHis.Close();
      LQryHis.ParamByName('CODOCO').AsString := LQryOco.FieldByName('OCO_CODOCO').AsString;
      LQryHis.ParamByName('CODEMP').AsString := LQryOco.FieldByName('OCO_CODEMP').AsString;
      LQryHis.Open();

      While (Not LQryHis.Eof) Do
      Begin
        fVerificaIntegridade('', 'HISOCO', LQryHis);

        LQryHis.Next();
      End;

      LUpdOco.Close();
      LUpdOco.ParamByName('CODOCO').AsString := LQryOco.FieldByName('OCO_CODOCO').AsString;
      LUpdOco.ParamByName('CODEMP').AsString := LQryOco.FieldByName('OCO_CODEMP').AsString;
      LUpdOco.ParamByName('ALTFRM').AsString := FstrNomFrm;
      LUpdOco.ExecSQL();

      fVerificaIntegridade('', 'MOVOCO', LQryOco);

      LDelOco.Close();
      LDelOco.ParamByName('CODOCO').AsString := LQryOco.FieldByName('OCO_CODOCO').AsString;
      LDelOco.ParamByName('CODEMP').AsString := LQryOco.FieldByName('OCO_CODEMP').AsString;
      LDelOco.ExecSQL();

      LQryOco.Next();
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(LQryOco);
    FreeAndNil(LQryHis);
    FreeAndNil(LDelOco);
    FreeAndNIl(LUpdOco);
{$ENDIF LINUX}
  End;
end;

{ TLogCatProspecto }

constructor TLogCatProspecto.Create;
begin
  inherited Create;
end;

destructor TLogCatProspecto.Destroy;
begin

  inherited;
end;

class function TLogCatProspecto.fNew: ILogCatProspecto;
begin
  Result := TLogCatProspecto.Create;
end;

procedure TLogCatProspecto.pRemoverLogCat(const strCatRem: String);
var
  qry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
const
  SQLDelete = 'DELETE FROM LOGCAT             ' +
              'WHERE LOG_EMPDOC = :LOG_EMPDOC ' +
              '  AND LOG_ESPDOC = :LOG_ESPDOC ' +
              '  AND LOG_NUMDOC = :LOG_NUMDOC ' +
              '  AND LOG_CATATU = :LOG_CATATU ';

begin
  qry := fCriaQuery;
  Try
    {$IFNDEF LINUX}
    qry.DisableControls;
    {$ENDIF LINUX}
    qry.SQL.Add(SQLDelete);

    qry.ParamByName('LOG_EMPDOC').AsString := FEmpDoc;
    qry.ParamByName('LOG_ESPDOC').AsString := FEspDoc;
    qry.ParamByName('LOG_NUMDOC').AsString := FNumDoc;
    qry.ParamByName('LOG_CATATU').AsString := strCatRem;

    qry.ExecSQL;

  Finally
  {$IFNDEF LINUX}
    FreeAndNil(qry);
  {$ENDIF LINUX}
  End;
end;

procedure TLogCatProspecto.pRemoverLogCatOportunidade;
Begin
  pRemoverLogCat(fCfgSis('CATOPO', varString));
End;

procedure TLogCatProspecto.pRemoverLogCatVenda;
Begin
  pRemoverLogCat(fCfgSis('CATVND', varString));
End;

function TLogCatProspecto.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TLogCatProspecto.GetCatAnt: String;
begin
  Result := FCatAnt;
end;

function TLogCatProspecto.GetCatAtu: String;
begin
  Result := FCatAtu;
end;

function TLogCatProspecto.GetCodMot: String;
begin
  Result := FCodMot;
end;

function TLogCatProspecto.GetDtaAlt: TDateTime;
begin
  Result := FDtaAlt;
end;

function TLogCatProspecto.GetEmpDoc: String;
begin
  Result := FEmpDoc;
end;

function TLogCatProspecto.GetEspDoc: String;
begin
  Result := FEspDoc;
end;

function TLogCatProspecto.GetHraAlt: TDateTime;
begin
  Result := FHraAlt;
end;

function TLogCatProspecto.GetNumDoc: String;
begin
  Result := FNumDoc;
end;

function TLogCatProspecto.GetOpeAlt: String;
begin
  Result := FOpeAlt;
end;

function TLogCatProspecto.GetSeqPro: String;
begin
  Result := FSeqPro;
end;

function TLogCatProspecto.GetStaPro: String;
begin
  Result := FStaPro;
end;

procedure TLogCatProspecto.SetAutInc(const AValue: String);
begin
  FAutInc := AValue;
end;

procedure TLogCatProspecto.SetCatAnt(const AValue: String);
begin
  FCatAnt := AValue;
end;

procedure TLogCatProspecto.SetCatAtu(const AValue: String);
begin
  FCatAtu := AValue;
end;

procedure TLogCatProspecto.SetCodMot(const AValue: String);
begin
  FCodMot := AValue;
end;

procedure TLogCatProspecto.SetDtaAlt(const AValue: TDateTime);
begin
  FDtaAlt := AValue;
end;

procedure TLogCatProspecto.SetEmpDoc(const AValue: String);
begin
  FEmpDoc := AValue;
end;

procedure TLogCatProspecto.SetEspDoc(const AValue: String);
begin
  FEspDoc := AValue;
end;

procedure TLogCatProspecto.SetHraAlt(const AValue: TDateTime);
begin
  FHraAlt := AValue;
end;

procedure TLogCatProspecto.SetNumDoc(const AValue: String);
begin
  FNumDoc := AValue;
end;

procedure TLogCatProspecto.SetOpeAlt(const AValue: String);
begin
  FOpeAlt := AValue;
end;

procedure TLogCatProspecto.SetSeqPro(const AValue: String);
begin
  FSeqPro := AValue;
end;

procedure TLogCatProspecto.SetStaPro(const AValue: String);
begin
  FStaPro := AValue;
end;

function TLogCatProspecto.strAutInc(const AValue: String): ILogCatProspecto;
begin
  FAutInc := AValue;
  Result := Self;
end;

function TLogCatProspecto.strCatAnt(const AValue: String): ILogCatProspecto;
begin
  FCatAnt := AValue;
  Result := Self;
end;

function TLogCatProspecto.strCatAtu(const AValue: String): ILogCatProspecto;
begin
  FCatAtu := AValue;
  Result := Self;
end;

function TLogCatProspecto.strCodMot(const AValue: String): ILogCatProspecto;
begin
  FCodMot := AValue;
  Result := Self;
end;

function TLogCatProspecto.strDtaAlt(const AValue: TDateTime): ILogCatProspecto;
begin
  FDtaAlt := AValue;
  Result := Self;
end;

function TLogCatProspecto.strEmpDoc(const AValue: String): ILogCatProspecto;
begin
  FEmpDoc := AValue;
  Result := Self;
end;

function TLogCatProspecto.strEspDoc(const AValue: String): ILogCatProspecto;
begin
  FEspDoc := AValue;
  Result := Self;
end;

function TLogCatProspecto.strHraAlt(const AValue: TDateTime): ILogCatProspecto;
begin
  FHraAlt := AValue;
  Result := Self;
end;

function TLogCatProspecto.strNumDoc(const AValue: String): ILogCatProspecto;
begin
  FNumDoc := AValue;
  Result := Self;
end;

function TLogCatProspecto.strOpeAlt(const AValue: String): ILogCatProspecto;
begin
  FOpeAlt := AValue;
  Result := Self;
end;

function TLogCatProspecto.strSeqPro(const AValue: String): ILogCatProspecto;
begin
  FSeqPro := AValue;
  Result := Self;
end;

function TLogCatProspecto.strStaPro(const AValue: String): ILogCatProspecto;
begin
  FStaPro := AValue;
  Result := Self;
end;

procedure TLogCatProspecto.pGravaLogAlteracaoCategoria;
const
  SQLInsert = 'INSERT INTO LOGCAT(AUTOINCREM, LOG_SEQPRO, LOG_DTAALT,     ' +
              '                   LOG_HORALT, LOG_OPEALT, LOG_CATANT,     ' +
              '                   LOG_CATATU, LOG_CODMOT, LOG_STAPRO,     ' +
              '                   LOG_EMPDOC, LOG_ESPDOC, LOG_NUMDOC     )' +
              '           VALUES(:AUTOINCREM, :LOG_SEQPRO, :LOG_DTAALT,   ' +
              '                  :LOG_HORALT, :LOG_OPEALT, :LOG_CATANT,   ' +
              '                  :LOG_CATATU, :LOG_CODMOT, :LOG_STAPRO,   ' +
              '                  :LOG_EMPDOC, :LOG_ESPDOC, :LOG_NUMDOC   )';
var
  qry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qry := fCriaQuery;
  Try
    qry.SQL.Add(SQLInsert);

    FAutInc := fRetAutoIncrem('LOGCAT', VS_strCodEmp);
    FOpeAlt := IIF(fEmptyStr(FOpeAlt), strLoginUsuarioLogado, FOpeAlt);

    qry.ParamByName('AUTOINCREM').AsString := FAutInc;
    qry.ParamByName('LOG_SEQPRO').AsString := FSeqPro;
    qry.ParamByName('LOG_DTAALT').AsDateTime := VS_Date;
    qry.ParamByName('LOG_HORALT').AsDateTime := fNow;
    qry.ParamByName('LOG_OPEALT').AsString := FOpeAlt;
    qry.ParamByName('LOG_CATANT').AsString := FCatAnt;
    qry.ParamByName('LOG_CATATU').AsString := IIF(FEmptyStr(FCatAtu), FCatAnt, FCatAtu);
    If fEmptyStr(FCodMot) Then
      qry.ParamByName('LOG_CODMOT').Clear
    Else
      qry.ParamByName('LOG_CODMOT').AsString := FCodMot;

    If fEmptyStr(FStaPro) Then
      qry.ParamByName('LOG_STAPRO').Clear
    Else
      qry.ParamByName('LOG_STAPRO').AsString := FStaPro;

    If fEmptyStr(FEmpDoc) Then
      qry.ParamByName('LOG_EMPDOC').Clear
    Else
      qry.ParamByName('LOG_EMPDOC').AsString := FEmpDoc;

    If fEmptyStr(FEspDoc) Then
      qry.ParamByName('LOG_ESPDOC').Clear
    Else
      qry.ParamByName('LOG_ESPDOC').AsString := FEspDoc;

    If fEmptyStr(FNumDoc) Then
      qry.ParamByName('LOG_NUMDOC').Clear
    Else
      qry.ParamByName('LOG_NUMDOC').AsString := FNumDoc;

    qry.ExecSQL;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(qry);
  {$ENDIF LINUX}
  End;

end;

{ TCategoriaCrm }

constructor TCategoriaCrm.Create;
begin

end;

destructor TCategoriaCrm.Destroy;
begin


  inherited;
end;

class function TCategoriaCrm.fInserirCategoriaCRM(const strDescri: String): String;
Var
  strSQL: String;
  strAutInc: String;
  strCodCat: String;
  qryInsert:  {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  Result := EmptyStr;
  strSQL := 'INSERT INTO CRMCAT(AUTOINCREM, CAT_CODIGO, CAT_DESCRI)' +
            '            VALUES(:AUTINC, :CODIGO, :DESCRI)';
  qryInsert := fCriaQuery;
  Try
    qryInsert.Close;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(strSQL);

    strAutInc := fRetAutoIncrem('CRMCAT', VS_strCodEmp);
    strCodCat := fAtualizaProCod('CRMCAT', 'CAT_CODIGO');

    qryInsert.ParamByName('AUTINC').AsString := strAutInc;
    qryInsert.ParamByName('CODIGO').AsString := strCodCat;
    qryInsert.ParamByName('DESCRI').AsString := strDescri;
    qryInsert.ExecSQL;

    Result := strCodCat;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(qryInsert);
  {$ENDIF LINUX}
  End;
end;

class function TCategoriaCrm.fNew: ICategoriaCrm;
begin
  Result := TCategoriaCrm.Create;
end;

function TCategoriaCrm.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TCategoriaCrm.GetCodCat: String;
begin
  Result := FCodCat;
end;

function TCategoriaCrm.GetDescri: String;
begin
  Result := FDescri;
end;

procedure TCategoriaCrm.pAtualizarCadastroProspectoPeloCompl(strCodCoc,
  strCodPro: String);
var
  blnAtuCatLead: Boolean;
  strCatCrmPro: String;
begin
  If (Not fEmptyStr(strCodCoc)) Then
  Begin
    blnAtuCatLead := (fCampoTabela('COC_ALTLEA', 'CADCOC', ['COC_CODCOC'], [strCodCoc]) = 'S');
    If blnAtuCatLead Then
    Begin
      strCatCrmPro := fCfgSis('CATLEA', varString);

      fAtualizarCategoriaProspecto(strCatCrmPro, strCodPro);
    End;
  End;
end;

function TCategoriaCrm.fAtualizarCategoriaProspecto(const strCatAtu: String;
  strCodPro: String): Boolean;
var
  qryUpdate: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
Begin
  qryUpdate := fCriaQuery;
  Try
    qryUpdate.Close;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(' UPDATE PROSPE ');
    qryUpdate.SQL.Add('   SET PRO_CRMCAT = :PRO_CRMCAT ');
    qryUpdate.SQL.Add(' WHERE PRO_CODPRO = :PRO_CODPRO ');
    qryUpdate.ParamByName('PRO_CODPRO').AsString := strCodPro;
    qryUpdate.ParamByName('PRO_CRMCAT').AsString := strCatAtu;
    qryUpdate.ExecSQL;
    Result := True;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryUpdate);
{$ENDIF LINUX}
  End;
End;

class procedure TCategoriaCrm.pInserirCategoriasProspectoPadraoCRM;
var
  strCodigo: String;
begin

  If fEmptyStr( fCfgSis('CATPRO', varString)) Then
  Begin
    strCodigo := fInserirCategoriaCRM('CATEGORIA PROSPECTO');
    fAtuCfgSis('CATPRO', strCodigo)
  End;

  If fEmptyStr( fCfgSis('CATLEA', varString)) Then
  Begin
    strCodigo := fInserirCategoriaCRM('CATEGORIA LEAD');
    fAtuCfgSis('CATLEA', strCodigo)
  End;

  If fEmptyStr( fCfgSis('CATOPO', varString)) Then
  Begin
    strCodigo := fInserirCategoriaCRM('CATEGORIA OPORTUNIDADE');
    fAtuCfgSis('CATOPO', strCodigo)
  End;

  If fEmptyStr( fCfgSis('CATVND', varString)) Then
  Begin
    strCodigo := fInserirCategoriaCRM('CATEGORIA VENDA');
    fAtuCfgSis('CATVND', strCodigo)
  End;
end;

procedure TCategoriaCrm.SetAutInc(const AValue: String);
begin
  FAutInc := AValue;
end;

procedure TCategoriaCrm.SetCodCat(const AValue: String);
begin
  FCodCat := AValue;
end;

procedure TCategoriaCrm.SetDescri(const AValue: String);
begin
  FDescri := AValue;
end;

function TCategoriaCrm.strAutInc(const AValue: String): ICategoriaCrm;
begin
  FAutInc := AValue;
  Result := Self;
end;

function TCategoriaCrm.strCodCat(const AValue: String): ICategoriaCrm;
begin
  FCodCat := AValue;
  Result := Self;
end;

function TCategoriaCrm.strDescri(const AValue: String): ICategoriaCrm;
begin
  FDescri := AValue;
  Result := Self;
end;

{ TLogAltMovOco }

constructor TLogAltMovOco.Create;
begin

end;

destructor TLogAltMovOco.Destroy;
begin

  inherited;
end;

class function TLogAltMovOco.fNew: ILogAltMovOco;
begin
  Result := TLogAltMovOco.Create;
end;

function TLogAltMovOco.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TLogAltMovOco.GetCliAnt: String;
begin
  Result := FCliAnt;
end;

function TLogAltMovOco.GetCodCli: String;
begin
  Result := FCodCli;
end;

function TLogAltMovOco.GetCodOco: String;
begin
  Result := FCodOco;
end;

function TLogAltMovOco.GetDescri: String;
begin
  Result := FDescri;
end;

function TLogAltMovOco.GetNomFrm: String;
begin
  Result := FNomFrm;
end;

procedure TLogAltMovOco.pGravarLogAlteracaoCliente;
var
  qryInsert: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
Begin
  qryInsert := fCriaQuery;
  Try
    qryInsert.Close;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(' INSERT INTO ');
    qryInsert.SQL.Add('   LOGCRM(AUTOINCREM, LOG_CODOCO, LOG_CODEMP,   ');
    qryInsert.SQL.Add('          LOG_CODCLI, LOG_CLIANT, LOG_DESCRI,   ');
    qryInsert.SQL.Add('          LOG_DTAINC, LOG_HORINC, LOG_CODOPE)   ');
    qryInsert.SQL.Add('   VALUES(:AUTOINCREM, :LOG_CODOCO, :LOG_CODEMP,');
    qryInsert.SQL.Add('          :LOG_CODCLI, :LOG_CLIANT, :LOG_DESCRI,');
    qryInsert.SQL.Add('          :LOG_DTAINC, :LOG_HORINC, :LOG_CODOPE)');

    FAutInc := fRetAutoIncrem('LOGCRM', VS_strCodEmp);
    qryInsert.ParamByName('AUTOINCREM').AsString := FAutInc;
    qryInsert.ParamByName('LOG_CODOCO').AsString := FCodOco;
    qryInsert.ParamByName('LOG_CODEMP').AsString := VS_strCodEmp;
    qryInsert.ParamByName('LOG_CODCLI').AsString := FCodCli;
    qryInsert.ParamByName('LOG_CLIANT').AsString := FCliAnt;
    qryInsert.ParamByName('LOG_DESCRI').AsString := FDescri;
    qryInsert.ParamByName('LOG_DTAINC').AsDateTime := VS_Date;
    qryInsert.ParamByName('LOG_HORINC').AsDateTime := fNow;
    qryInsert.ParamByName('LOG_CODOPE').AsString := strLoginUsuarioLogado;
    qryInsert.ExecSQL;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryInsert);
{$ENDIF LINUX}
  End;
end;

function TLogAltMovOco.strCliAnt(const AValue: String): ILogAltMovOco;
begin
  Result := Self;
  FCliAnt := AValue;

end;

function TLogAltMovOco.strCodCli(const AValue: String): ILogAltMovOco;
begin
  Result := Self;
  FCodCli := AValue;
end;

function TLogAltMovOco.strCodOco(const AValue: String): ILogAltMovOco;
begin
  Result := Self;
  FCodOco := AValue;
end;

function TLogAltMovOco.strDescri(const AValue: String): ILogAltMovOco;
begin
  Result := Self;
  FDescri := AValue;
end;

function TLogAltMovOco.strNomFrm(const AValue: String): ILogAltMovOco;
begin
  Result := Self;
  FNomFrm := AValue;
end;

end.
