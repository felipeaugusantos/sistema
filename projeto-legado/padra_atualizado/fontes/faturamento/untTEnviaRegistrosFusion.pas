unit untTEnviaRegistrosFusion;

interface

uses
  Data.DB,
  System.Classes,
  System.SysUtils,
  System.StrUtils,
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  Uni,
  CRAccess,
  untUtilMonitor,
//  untLegenda,
  Vcl.ExtCtrls,
  UniClientDataSet,
  untFuncoesSimples,
{$ENDIF LINUX}
  untFuncoesGenerica,
  System.Generics.Collections,
  System.DateUtils;

const
  spIdMonitorEnviaRegFusion           = 'MONITOR_ENVIA_REG_FUSION_%s';
  spIdInactivityMonitorEnviaRegFusion = 'TESTE_INATIVIDADE_ENVIA_REG_FUSION_%s';
  spEnviaRegMonitorExeName              = 'EnviaRegistrosFusion.exe';
  spTimeLimitMonitorEnviaRegFusion    = 30;
  spAttemptsLockMonitorEnviaRegFusion = 30;

  { *** PADRÃO *** }
  sqlCamposAEnviar                    = 'SELECT F.AUTOINCREM SEQGER, CONCAT(FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP) AS DOCERP, ' +
                                        '  FGO_NUMDOC AS NUMDOC, FGO_ESPDOC AS ESPDOC, ' +
                                        '  FGO_CODEMP AS EMPDOC, FGO_CODCLI AS CODCLI, CLI_NOMCLI, ' +
                                        '  CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) AS DOCUMENTO, ' +
                                        '  CONCAT(FGO_CODVEN ,"-", V.OPE_NOMOPE) AS NOMVEN, CLI_EMAIL_, CLI_EMAIL2, ' +
                                        '  CLI_EMAIL3, CLI_C_G_C_, CLI_DTACAD, CLI_ULTCOM, FGO_DTAENT AS DTAEMI, ' +
                                        '  FGO_CODFPG AS CODFPG, FGO_DTAFAT AS DTAFAT, FGO_HORENT AS HORENT, ' +
                                        '  FGO_VLRCON AS VLRCON, FGO_PESLIQ AS PESLIQ, CLI_ENDERE, CLI_ENDNUM, ' +
                                        '  CLI_ENDCOM, ' +

                                        '  IF(TR.TRA_CODTRA IS NULL,  ' +
                                        '     IFNULL(EC.ETC_ENDENT, EC2.ETC_ENDENT), ' +
                                        '     TR.TRA_ENDERE) AS ETC_ENDENT,  ' +

                                        '  IF(TR.TRA_CODTRA IS NULL,  ' +
                                        '     IFNULL(EC.ETC_CEPENT, EC2.ETC_CEPENT), ' +
                                        '     TR.TRA_C_E_P_ ) AS ETC_CEPENT, ' +

                                        '  IF(TR.TRA_CODTRA IS NULL,  ' +
                                        '     IFNULL(EC.ETC_BAIENT, EC2.ETC_BAIENT), ' +
                                        '     TR.TRA_BAIRRO) AS ETC_BAIENT, ' +

                                        '  IF(TR.TRA_CODTRA IS NULL,  ' +
                                        '     IFNULL(CD.CID_NOMCID, CD2.CID_NOMCID), ' +
                                        '     CTR.CID_NOMCID) AS CID_NOMCID, ' +

                                        '  IF(TR.TRA_CODTRA IS NULL,  ' +
                                        '     IFNULL(CD.CID_ESTADO, CD2.CID_ESTADO), ' +
                                        '     CTR.CID_ESTADO) AS CID_ESTADO, ' +

                                        '  IFNULL(EC.AUTOINCREM, EC2.AUTOINCREM) AS CODENDERE, ' +
                                        '  IFNULL(EC.ETC_ENDFAT, IFNULL(EC2.ETC_ENDFAT, "N")) AS ENDFAT, ' +
                                        '  IFNULL(CD.CID_COIBGE, CD2.CID_COIBGE) AS CID_COIBGE, ' +
                                        '  SUBSTRING_INDEX(IFNULL(EC.ETC_ENDENT, EC2.ETC_ENDENT), ",", 1) AS ENDERECO, ' +
                                        '  SUBSTRING_INDEX(IFNULL(EC.ETC_ENDENT, EC2.ETC_ENDENT), ",", -1) AS NROENDER, ' +
                                        '  IFNULL(EC.ETC_REFENT, EC2.ETC_REFENT) AS ETC_REFENT, ' +
                                        '  IFNULL(EC.ETC_TELENT, EC2.ETC_TELENT) AS ETC_TELENT, ' +
                                        '  IF(FGO_NUMFAT <> "", FGO_NUMFAT, FDO_NUMFAT) AS NUMFAT, ' +
                                        '  IF(FGO_TIPFAT <> "", FGO_TIPFAT, FDO_TIPFAT) AS TIPFAT, ' +
                                        '  IF(FGO_EMPFAT <> "", FGO_EMPFAT, IF(FDO_EMPFAT <> "", FDO_EMPFAT, ' +
                                        '    IF(FGO_ENT_CD = "S", FGO_EMP_CD, FDO_EMPITE))) AS EMPFAT, ' +
                                        '  IF(FGO_SERIE_ <> "", FGO_SERIE_, FDO_SERIE_) AS SERFAT, ' +
                                        '  FDO_CLAFIS, FDO_EMPITE AS FDO_EMPITE, IF(FGO_EMPEXP <> "", FGO_EMPEXP, FDO_EMPITE) EMPEXP, ' +
                                        '  SUM((((D.ITE_EXPALT / 100) * (D.ITE_EXPLAR / 100) * (D.ITE_EXPPRO / 100)) * FD.FDO_QTDITE)) AS CUBAGEM, ATI_DESATI, ' +
                                        '  IFNULL((SELECT SUM(IF(ADT_TIPLAN = "C", ADT_VALLAN, -ADT_VALLAN)) ' +
                                        '          FROM ADTCLI ' +
                                        '          WHERE ADT_NUMDOC = F.FGO_NUMDOC ' +
                                        '            AND ADT_ESPDOC = F.FGO_ESPDOC ' +
                                        '            AND ADT_CODEMP = F.FGO_CODEMP), 0) VALADT, ' +
                                        '  FGO_CONPAG, FGO_NUMROM NUMROM, FGO_EMPROM EMPROM ' ;

  sqlInnerAEnviar                     = 'INNER JOIN EXTGOR E ON F.AUTOINCREM = E.FGO_SEQFGO ' +
                                        'INNER JOIN FATDOR FD ON F.AUTOINCREM = FD.FDO_SEQGER ' +
                                        'INNER JOIN CADCLI C ON F.FGO_CODCLI = C.CLI_CODCLI ' +
                                        'INNER JOIN CADOPE V ON F.FGO_CODVEN = V.OPE_CODOPE ' +
                                        'LEFT JOIN AUXGOR A ON F.AUTOINCREM = A.AUX_SEQGER ' +
                                        'LEFT JOIN ENTCLI EC ON A.AUX_ENTGER = EC.AUTOINCREM ' +
                                        'LEFT JOIN ENTCLI EC2 ON F.FGO_CODCLI = EC2.ETC_CODCLI ' +
                                        '                    AND EC2.ETC_SEQIND = ' +
                                        '                         (SELECT MIN(ETC_SEQIND) ' +
                                        '                          FROM ENTCLI EC3 ' +
                                        '                          WHERE EC3.ETC_CODCLI = F.FGO_CODCLI) ' +
                                        'LEFT JOIN CADCID CD ON EC.ETC_CIDENT = CD.CID_CODCID ' +
                                        'LEFT JOIN CADCID CD2 ON EC2.ETC_CIDENT = CD2.CID_CODCID ' +
                                        'LEFT JOIN CADITE I ON I.ITE_CODITE = FDO_CODITE ' +
                                        'LEFT JOIN DESSIT D ON D.ITE_CODITE = I.ITE_CODITE ' +
                                        'LEFT JOIN CADATI ON CLI_CODATI = ATI_CODATI ' +
                                        'LEFT JOIN CADTRA TR ON E.FGO_TRARDP = TR.TRA_CODTRA AND TR.TRA_INTFUS = "S" ' +
                                        'LEFT JOIN CADCID CTR ON TR.TRA_CODCID = CTR.CID_CODCID ';

  sqlCondicaoAEnviar                  = 'WHERE E.FGO_INTFUS = "N" ' +
                                        '  AND FGO_ESPDOC = "PD" ' +
                                        '  AND FGO_LIBERA > 0 ' +
                                        '  AND FGO_LIBCOM = 1 ' +
                                        '  AND (SELECT FDO_ENTRET FROM EXTDOR WHERE FDO_SEQFDO = FD.AUTOINCREM) = "E" ' +
                                        '  AND FGO_ENTFUT = "N" ' +
                                        '  AND LOCATE(FDO_CLAFIS, CONCAT(:CLAVEN, "5910_6910_5152_5409_")) > 0 ' +
                                        '  AND FGO_JAFATU = :JAFATU ' +
                                        '  AND FGO_EMPEXP = :EMPEXP ' +
                                        '  AND NOT EXISTS ( ' +
                                        '      SELECT FGO.AUTOINCREM ' +
                                        '      FROM FATGOR FGO ' +
                                        '      JOIN EXTGOR EGO ON EGO.FGO_SEQFGO = FGO.AUTOINCREM ' +
                                        '      JOIN FATDOR FDO ON FDO.FDO_SEQGER = FGO.AUTOINCREM ' +
                                        '      WHERE FGO.FGO_NUMDOC = F.FGO_NUMDOC ' +
                                        '        AND FGO.FGO_ESPDOC = F.FGO_ESPDOC ' +
                                        '        AND FGO.FGO_CODEMP = F.FGO_CODEMP ' +
                                        '        AND EGO.FGO_EMP_TE IS NULL ' +
                                        '        AND FGO.FGO_ENT_CD = "N" ' +
                                        '        AND IFNULL(FDO.FDO_EMPITE, FDO.FDO_CODEMP) <> FDO.FDO_CODEMP ' +
                                        '        AND FGO.FGO_JAFATU = 0) ' +
                                        '  AND NOT EXISTS (' +
                                        '      SELECT R.AUTOINCREM ' +
                                        '      FROM ROMGERX R ' +
                                        '      WHERE R.GER_NUMDOC = F.FGO_NUMDOC ' +
                                        '        AND R.GER_ESPDOC = F.FGO_ESPDOC ' +
                                        '        AND R.GER_CODEMP = F.FGO_CODEMP) ' +
                                        '  AND ( EXISTS ( ' +
                                        '        SELECT TRA_CODTRA ' +
                                        '        FROM CADTRA ' +
                                        '        WHERE TRA_CODTRA = FGO_CODTRA ' +
                                        '          AND TRA_INTFUS = "S") '+

                                        '        OR '+

                                        '        EXISTS ('+
                                        '        SELECT TRA_CODTRA ' +
                                        '        FROM CADTRA ' +
                                        '        WHERE TRA_CODTRA = FGO_TRARDP ' +
                                        '          AND TRA_INTFUS = "S") '+
                                        '       ) '+

                                        '  <<COND_EXP4>> '+
                                        '  <<COND_LBFUMA>> ';

  { *** SELECT *** }

  sqlVeiculosAEnviar                  = 'SELECT V.AUTOINCREM, VEI_PLAVEI, VEI_ANOVEI, ' +
                                        '  CONCAT(MAR_DESMAR, " ", MOD_DESMOD) AS DESCRICAO ' +
                                        'FROM CADVEI V ' +
                                        'INNER JOIN MARVEI MA ON V.VEI_CODMAR = MA.MAR_CODMAR ' +
                                        'INNER JOIN MODVEI MD ON V.VEI_CODMOD = MD.MOD_CODMOD ' +
                                        'WHERE VEI_STATUS = "A" ' +
                                        '  AND VEI_INTFUS = "N" ';

  sqlMotoristasAjudantesAEnviar       = 'SELECT AUTOINCREM, MOT_NOMMOT AS NOME, MOT_CPFMOT AS NUMCPF, MOT_CODMOT AS CODIGO, "Motorista" AS TIPO ' +
                                        'FROM CADMOT ' +
                                        'WHERE MOT_STATUS = "A" ' +
                                        '  AND MOT_INTFUS = "N" '+

                                        ' UNION ALL '+

                                        'SELECT AUTOINCREM, AJU_NOMAJU AS NOME, "11111111111" AS NUMCPF, AJU_CODAJU AS CODIGO, "Ajudante" AS TIPO ' +
                                        'FROM CADAJU ' +
                                        'WHERE AJU_STATUS = "A" ' +
                                        '  AND AJU_INTFUS = "N" ';

  sqlPedidosAEnviar                   = sqlCamposAEnviar +
                                        'FROM FATGOR F ' +
                                        sqlInnerAEnviar +
                                        sqlCondicaoAEnviar +
                                        'GROUP BY F.AUTOINCREM ';

  sqlItensPedido                      = 'SELECT FDO_CODITE, FDO_QTDITE, FDO_UNITAR, FDO_TOTITE, ITE_DESITE, UNI_SIGUNI ' +
                                        'FROM FATDOR ' +
                                        'INNER JOIN CADITE ON FDO_CODITE = ITE_CODITE ' +
                                        'LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ' +
                                        'WHERE FDO_SEQGER = :SEQGER ';

  sqlRomaneioCancelado                = 'SELECT FUS_NUMROM, FUS_EMPROM, FUS_DTAINC, FUS_HRAINC ' +
                                        'FROM TARFUS ' +
                                        'WHERE FUS_EVENTO = "C" ' +
                                        '  AND IFNULL(FUS_NUMDOC, "") = "" ' +
                                        '  AND FUS_DTALEI IS NULL ' +
                                        '  AND FUS_EMPTAR = :CODEMP ';

  sqlPedidosRomaneioCancelado         = 'SELECT CONCAT(GER_NUMDOC, GER_ESPDOC, GER_CODEMP) AS DOCERP, ' +
                                        '  IF(FGO_EMPFAT <> "", FGO_EMPFAT, IF(FDO_EMPFAT <> "", FDO_EMPFAT, ' +
                                        '     IF(FGO_ENT_CD = "S", FGO_EMP_CD, IF(FDO_EMPITE <> "", FDO_EMPITE, GER_EMPROM)))) AS CODFIL ' +
                                        'FROM TARFUS ' +
                                        'INNER JOIN DEL_ROMGERX ON FUS_NUMROM = GER_NUMROM AND FUS_EMPROM = GER_EMPROM ' +
                                        'LEFT JOIN FATGOR F ON GER_NUMDOC = FGO_NUMDOC AND GER_ESPDOC = FGO_ESPDOC AND GER_CODEMP = FGO_CODEMP ' +
                                        'INNER JOIN EXTGOR ON F.AUTOINCREM = FGO_SEQFGO ' +
                                        'INNER JOIN FATDOR ON F.AUTOINCREM = FDO_SEQGER ' +
                                        'WHERE FUS_EVENTO = "C" ' +
                                        '  AND IFNULL(FUS_NUMDOC, "") = "" ' +
                                        '  AND FUS_DTALEI IS NULL ' +
                                        '  AND FUS_NUMROM = :NUMROM ' +
                                        '  AND FUS_EMPROM = :EMPROM ';

  sqlPedidosCancelados                = sqlCamposAEnviar +
                                        '  , FGO_NUMROM NUMROM, FGO_EMPROM EMPROM ' +
                                        'FROM TARFUS ' +
                                        'INNER JOIN DEL_FATGOR F ON FUS_NUMDOC = F.FGO_NUMDOC ' +
                                        '                       AND FUS_ESPDOC = F.FGO_ESPDOC ' +
                                        '                       AND FUS_EMPDOC = F.FGO_CODEMP ' +
                                        'INNER JOIN DEL_EXTGOR E ON F.AUTOINCREM = E.FGO_SEQFGO ' +
                                        'INNER JOIN DEL_FATDOR FD ON F.AUTOINCREM = FD.FDO_SEQGER ' +
                                        'INNER JOIN CADCLI C ON F.FGO_CODCLI = C.CLI_CODCLI ' +
                                        'INNER JOIN CADOPE V ON F.FGO_CODVEN = V.OPE_CODOPE ' +
                                        'LEFT JOIN DEL_AUXGOR A ON F.AUTOINCREM = A.AUX_SEQGER ' +
                                        'LEFT JOIN ENTCLI EC ON A.AUX_ENTGER = EC.AUTOINCREM ' +
                                        'LEFT JOIN ENTCLI EC2 ON F.FGO_CODCLI = EC2.ETC_CODCLI ' +
                                        '                    AND EC2.ETC_SEQIND = ' +
                                        '                         (SELECT MIN(ETC_SEQIND) ' +
                                        '                          FROM ENTCLI EC3 ' +
                                        '                          WHERE EC3.ETC_CODCLI = F.FGO_CODCLI) ' +
                                        'LEFT JOIN CADCID CD ON EC.ETC_CIDENT = CD.CID_CODCID ' +
                                        'LEFT JOIN CADCID CD2 ON EC2.ETC_CIDENT = CD2.CID_CODCID ' +
                                        'LEFT JOIN CADITE I ON I.ITE_CODITE = FDO_CODITE ' +
                                        'LEFT JOIN DESSIT D ON D.ITE_CODITE = I.ITE_CODITE ' +
                                        'LEFT JOIN CADATI ON CLI_CODATI = ATI_CODATI ' +
                                        'LEFT JOIN CADTRA TR ON E.FGO_TRARDP = TR.TRA_CODTRA AND TR.TRA_INTFUS = "S" ' +
                                        'LEFT JOIN CADCID CTR ON TR.TRA_CODCID = CTR.CID_CODCID '+
                                        'WHERE FUS_EVENTO = "C" ' +
                                        '  AND IFNULL(FUS_NUMROM, "") = "" ' +
                                        '  AND FUS_EMPTAR = :CODEMP ' +
                                        '  AND FUS_DTALEI IS NULL ' +
                                        'GROUP BY F.AUTOINCREM ';

  sqlPedidosBaixados                  = sqlCamposAEnviar +
                                        '  , FGO_NUMROM NUMROM, FGO_EMPROM EMPROM ' +
                                        'FROM TARFUS ' +
                                        'INNER JOIN FATGOR F ON FUS_NUMDOC = F.FGO_NUMDOC ' +
                                        '                   AND FUS_ESPDOC = F.FGO_ESPDOC ' +
                                        '                   AND FUS_EMPDOC = F.FGO_CODEMP ' +
                                        sqlInnerAEnviar +
                                        'WHERE FUS_EVENTO = "B" ' +
                                        //'  AND FUS_EMPTAR = :CODEMP ' +
                                        '  AND FUS_DTALEI IS NULL ' +
                                        'GROUP BY F.AUTOINCREM ';

  sqlPedidosAlterados                 = sqlCamposAEnviar +
                                        '  , FGO_NUMROM NUMROM, FGO_EMPROM EMPROM ' +
                                        'FROM TARFUS ' +
                                        'INNER JOIN FATGOR F ON FUS_NUMDOC = F.FGO_NUMDOC ' +
                                        '                   AND FUS_ESPDOC = F.FGO_ESPDOC ' +
                                        '                   AND FUS_EMPDOC = F.FGO_CODEMP ' +
                                        sqlInnerAEnviar +
                                        'WHERE FUS_EVENTO = "A" ' +
                                        '  AND FUS_EMPTAR = :CODEMP ' +
                                        '  AND FUS_DTALEI IS NULL ' +
                                        'GROUP BY F.AUTOINCREM ';

  sqlPedidosAlteradosParaReprocessamento = sqlCamposAEnviar +
                                           '  , FGO_NUMROM NUMROM, FGO_EMPROM EMPROM ' +
                                           'FROM TARFUS ' +
                                           'INNER JOIN FATGOR F ON FUS_NUMDOC = F.FGO_NUMDOC ' +
                                           '                   AND FUS_ESPDOC = F.FGO_ESPDOC ' +
                                           '                   AND FUS_EMPDOC = F.FGO_CODEMP ' +
                                           sqlInnerAEnviar +
                                           'WHERE FUS_EVENTO = "P" ' +
                                           '  AND FUS_EMPTAR = :CODEMP ' +
                                           '  AND FUS_DTALEI IS NULL ' +
                                           'GROUP BY F.AUTOINCREM ';

  sqlInclusaoPDRomaneio               = sqlCamposAEnviar +
                                        '  , FGO_NUMROM NUMROM, FGO_EMPROM EMPROM ' +
                                        'FROM TARFUS ' +
                                        'INNER JOIN FATGOR F ON FUS_NUMDOC = F.FGO_NUMDOC ' +
                                        '                   AND FUS_ESPDOC = F.FGO_ESPDOC ' +
                                        '                   AND FUS_EMPDOC = F.FGO_CODEMP ' +
                                        sqlInnerAEnviar +
                                        'WHERE FUS_EVENTO = "I" ' +
                                        '  AND FUS_EMPTAR = :CODEMP ' +
                                        '  AND FUS_DTALEI IS NULL ' +
                                        'GROUP BY F.AUTOINCREM ';

  sqlExclusaoPDRomaneio               = sqlCamposAEnviar +
                                        '  , FUS_NUMROM NUMROM, FUS_EMPROM EMPROM ' +
                                        'FROM TARFUS ' +
                                        'INNER JOIN FATGOR F ON FUS_NUMDOC = F.FGO_NUMDOC ' +
                                        '                   AND FUS_ESPDOC = F.FGO_ESPDOC ' +
                                        '                   AND FUS_EMPDOC = F.FGO_CODEMP ' +
                                        sqlInnerAEnviar +
                                        'WHERE FUS_EVENTO = "E" ' +
                                        '  AND FUS_EMPTAR = :CODEMP ' +
                                        '  AND FUS_DTALEI IS NULL ' +
                                        'GROUP BY F.AUTOINCREM ';

  sqlRomaneioFinalizado               = ' SELECT '+
                                        '   FUS_NUMROM, '+
                                        '   FUS_EMPROM, '+
                                        '   GER_CODMOT, '+
                                        '   CADVEI.AUTOINCREM AS CODVEI, '+
                                        '   MOT_NOMMOT, '+
                                        '   MOT_CPFMOT '+
                                        ' FROM '+
                                        '   TARFUS '+
                                        ' INNER JOIN ROMGERX '+
                                        '    ON FUS_NUMROM = GER_NUMROM '+
                                        '   AND FUS_EMPROM = GER_EMPROM '+
                                        ' INNER JOIN CADMOT '+
                                        '    ON GER_CODMOT = MOT_CODMOT '+
                                        ' INNER JOIN CADVEI '+
                                        '    ON GER_PLAVEI = VEI_PLAVEI '+
                                        ' WHERE FUS_EVENTO = "F" ' +
                                        '   AND FUS_EMPTAR = :CODEMP ' +
                                        '   AND FUS_DTALEI IS NULL ';

  { *** UPDATE *** }
  sqlAtualizaIntFusVeiculos           = 'UPDATE CADVEI ' +
                                        'SET VEI_INTFUS = "S" ' +
                                        'WHERE AUTOINCREM IN (%s)';

  sqlAtualizaIntFusMotoristas         = 'UPDATE CADMOT ' +
                                        'SET MOT_INTFUS = "S" ' +
                                        'WHERE MOT_CODMOT IN (%s)';

  sqlAtualizaIntFusAjudantes          = 'UPDATE CADAJU ' +
                                        'SET AJU_INTFUS = "S" ' +
                                        'WHERE AJU_CODAJU IN (%s)';

  sqlAtualizaIntFusPedidosEnvio       = 'UPDATE '+
                                        '  EXTGOR E ' +
                                        'INNER JOIN FATGOR F '+
                                        '  ON E.FGO_SEQFGO = F.AUTOINCREM ' +
                                        'SET '+
                                        '   E.FGO_INTFUS = "%s", ' +
                                        '   E.FGO_ENVFUS = :DTAENV ' +
                                        'WHERE '+
                                        '   FGO_NUMDOC = "%s" AND '+
                                        '   FGO_ESPDOC = "%s" AND '+
                                        '   FGO_CODEMP = "%s" ';

  sqlAtualizaIntFusPedidos            = 'UPDATE '+
                                        '  EXTGOR E ' +
                                        'INNER JOIN FATGOR F '+
                                        '  ON E.FGO_SEQFGO = F.AUTOINCREM ' +
                                        'SET '+
                                        '   E.FGO_INTFUS = "%s" ' +
                                        'WHERE '+
                                        '   FGO_NUMDOC = "%s" AND '+
                                        '   FGO_ESPDOC = "%s" AND '+
                                        '   FGO_CODEMP = "%s" ';

  sqlAtualizaTarefasPD                = 'UPDATE '+
                                       '   TARFUS ' +
                                        'SET '+
                                        '  FUS_DTALEI = CURRENT_DATE(), ' +
                                        '  FUS_HRALEI = CURRENT_TIME()  ' +
                                        'WHERE '+
                                        '   FUS_NUMDOC = "%s" AND '+
                                        '   FUS_ESPDOC = "%s" AND '+
                                        '   FUS_EMPDOC = "%s" AND '+
                                        '  FUS_DTALEI IS NULL ';

  sqlAtualizaTarefasRom               = 'UPDATE TARFUS ' +
                                        'SET FUS_DTALEI = CURRENT_DATE(), ' +
                                        '    FUS_HRALEI = CURRENT_TIME() ' +
                                        'WHERE FUS_EVENTO = :EVENTO '+
                                        '  AND FUS_NUMROM = :NUMROM ' +
                                        '  AND FUS_EMPROM = :EMPROM ' +
                                        '  AND FUS_DTALEI IS NULL ';

  CHAR_ESPECIAL                       = '#<>|*ªº°&"''%$¨@!?§={}[]´`^~¹²³£¢Ø¡';

type
  TTypeEnvioFusion = (tpVeiculos, tpMotoristasAjudantes, tpPedidos, tpRomaneioCancelado,
    tpPedidoCancelado, tpPedidoBaixado, tpPedidoAlterado, tpExclusaoPDRomaneio,
    tpInclusaoPDRomaneio, tpPedidoAlteradoParaReprocessamento, tpRomaneioFinalizado);

  TEnviaRegistrosFusion = class sealed(TInterfacedObject,
    {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX})
  private
    FParam: TTypeEnvioFusion;
    FClaVen: String;
    FFusEPD: Integer;

    class var FLastProcessamento: TDateTime;

    procedure pEnviaVeiculos;
    procedure pEnviaMotoristasAjudantes;
    procedure pEnviaPedidos(ATipoEnvio: TTypeEnvioFusion; ASQL: String);
    procedure pEnviaCancelamentoRomaneio;
    procedure pEnviaStatusRomaneioFinalizado;

    procedure pAtualizaEnvioVeiculos(ARetorno: String);
    procedure pAtualizaEnvioMotoristasAjudantes(ARetorno, ATipo: String);
    procedure pAtualizaEnvioPedidos(ARetorno, AStatus: String; ADataEnvio: TDateTime = 0);
    procedure pAtualizaEnvioTarefas(ARetorno: String); overload;
    procedure pAtualizaEnvioTarefas(ANumRom, AEmpRom, AEvento: String); overload;
  protected
    constructor Create(AParam: TTypeEnvioFusion); overload;
  public
    procedure pExecute;
    procedure pExecuteAll;
    function fExecute: TResultExecute;

    destructor Destroy; Override;

    class function New(AParam: TTypeEnvioFusion):
      {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX}; overload;
    class function New:
      {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX}; overload;
  end;

implementation

uses
  untFusionVeiculo, untFusionMotoristaAjudante, untFusionEntregaServico, untFusionEntregaServicoItens,
  untFusionCarga, untFusionIntegWS, untConstantes, untFusionAtualizaCarga;

{ TEnviaRegistrosFusion }

constructor TEnviaRegistrosFusion.Create(AParam: TTypeEnvioFusion);
begin
  FParam := AParam;
  FClaVen := fTransform(fCfgSis('CLAVEN'), 4);
  FFusEPD := 1; //fCfgSis('FUSEPD', varInteger);
end;

destructor TEnviaRegistrosFusion.Destroy;
begin

  inherited;
end;

function TEnviaRegistrosFusion.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  pExecute;
end;

class function TEnviaRegistrosFusion.New: {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX};
begin
  Result := TEnviaRegistrosFusion.Create;
end;

class function TEnviaRegistrosFusion.New(AParam: TTypeEnvioFusion): {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX};
begin
  Result := TEnviaRegistrosFusion.Create(AParam);
end;

procedure TEnviaRegistrosFusion.pAtualizaEnvioMotoristasAjudantes(ARetorno, ATipo: String);
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  if (fEmptyStr(ARetorno)) then
    Exit;

  LQry := fCriaQuery();

  try
    LQry.SQL.Text := Format(IIF(ATipo = 'Motorista', sqlAtualizaIntFusMotoristas, sqlAtualizaIntFusAjudantes), [ARetorno]);
    LQry.ExecSQL();
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFusion.pAtualizaEnvioPedidos(ARetorno, AStatus: String; ADataEnvio: TDateTime = 0);
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  arrDocs: TArray<String>;
  intCont: Integer;
  strNumDoc,
  strEspDoc,
  strCodEmp: String;
begin
  if (fEmptyStr(ARetorno)) then
    Exit;

  LQry := fCriaQuery();

  try
    arrDocs := ARetorno.Split([',']);
    for intCont := 0 to Length(arrDocs)-1 do
    begin
      strNumDoc := Trim(Copy(arrDocs[intCont], 0, 12));
      strEspDoc := Trim(Copy(arrDocs[intCont], 13, 2));
      strCodEmp := Trim(Copy(arrDocs[intCont], 15, 3));

      if (ADataEnvio > 0) then
      begin
        LQry.SQL.Text := Format(sqlAtualizaIntFusPedidosEnvio, [AStatus, strNumDoc, UpperCase(strEspDoc), strCodEmp]);
        LQry.ParamByName('DTAENV').AsDateTime := ADataEnvio;
        LQry.ExecSQL();
      end
      else
      begin
        LQry.SQL.Text := Format(sqlAtualizaIntFusPedidos, [AStatus, strNumDoc, UpperCase(strEspDoc), strCodEmp]);
        LQry.ExecSQL();
      end;

    end;
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFusion.pAtualizaEnvioTarefas(ARetorno: String);
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  arrDocs: TArray<String>;
  intCont: Integer;
  strNumDoc,
  strEspDoc,
  strCodEmp: String;
begin
  LQry := fCriaQuery();

  try
    arrDocs := ARetorno.Split([',']);
    for intCont := 0 to Length(arrDocs)-1 do
    begin
      strNumDoc := Trim(Copy(arrDocs[intCont], 0, 12));
      strEspDoc := Trim(Copy(arrDocs[intCont], 13, 2));
      strCodEmp := Trim(Copy(arrDocs[intCont], 15, 3));

      LQry.SQL.Text := Format(sqlAtualizaTarefasPD, [strNumDoc, UpperCase(strEspDoc), strCodEmp]);
      LQry.ExecSQL();
    end;
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFusion.pAtualizaEnvioTarefas(ANumRom, AEmpRom, AEvento: String);
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQry := fCriaQuery();

  try
    LQry.SQL.Text := sqlAtualizaTarefasRom;
    LQry.ParamByName('NUMROM').AsString := ANumRom;
    LQry.ParamByName('EMPROM').AsString := AEmpRom;
    LQry.ParamByName('EVENTO').AsString := AEvento;
    LQry.ExecSQL();
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFusion.pAtualizaEnvioVeiculos(ARetorno: String);
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  if (fEmptyStr(ARetorno)) then
    Exit;

  LQry := fCriaQuery();

  try
    LQry.SQL.Text := Format(sqlAtualizaIntFusVeiculos, [ARetorno]);
    LQry.ExecSQL();
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFusion.pEnviaCancelamentoRomaneio;
var
  LRetorno: String;
  LPedidos: String;
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LQryPed: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LobjCarga: TFusionCarga;
  LobjPedido: TFusionPedidosCarga;
begin
  LQry := fCriaQuery();
  LQryPed := fCriaQuery();

  try
    LQryPed.SQL.Text := sqlPedidosRomaneioCancelado;

    LQry.SQL.Text := sqlRomaneioCancelado;
    LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQry.Open();

    while not LQry.Eof do
    begin
      LobjCarga := TFusionCarga.Create;

      try
        LobjCarga.codigo_erp := LQry.FieldByName('FUS_NUMROM').AsString;
        LobjCarga.dt_cancel := FormatDateTime('yyyy-mm-dd', LQry.FieldByName('FUS_DTAINC').AsDateTime) + ' '
            + FormatDateTime('hh:nn:ss', LQry.FieldByName('FUS_HRAINC').AsDateTime);

        LQryPed.Close;
        LQryPed.ParamByName('NUMROM').AsString := LQry.FieldByName('FUS_NUMROM').AsString;
        LQryPed.ParamByName('EMPROM').AsString := LQry.FieldByName('FUS_EMPROM').AsString;
        LQryPed.Open;

        LPedidos := '';

        while not LQryPed.Eof do
        begin
          LobjPedido := TFusionPedidosCarga.Create;
          LobjPedido.id := LQryPed.FieldByName('DOCERP').AsString;
          LobjPedido.filial := LQryPed.FieldByName('CODFIL').AsString;

          if (not fEmptyStr(LPedidos)) then
            LPedidos := LPedidos + ',' + LQryPed.FieldByName('DOCERP').AsString
          else
            LPedidos := LPedidos + LQryPed.FieldByName('DOCERP').AsString;

          SetLength(LobjCarga.arrPedidos, Length(LobjCarga.arrPedidos) + 1);
          LobjCarga.arrPedidos[Length(LobjCarga.arrPedidos) - 1] := LobjPedido;

          LQryPed.Next;
        end;

        LRetorno := TFusionIntegWS.New.fCancelarCarga(LobjCarga).fRetornoSucesso;

        if (not fEmptyStr(LRetorno)) then
        begin
          pAtualizaEnvioTarefas(LQry.FieldByName('FUS_NUMROM').AsString,
                                LQry.FieldByName('FUS_EMPROM').AsString,
                                'C');

          pAtualizaEnvioPedidos(LPedidos, 'E');
        end;
      finally
        LobjCarga.Free;
      end;

      LQry.Next();
    end;
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
    FreeAndNil(LQryPed);
{$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFusion.pEnviaMotoristasAjudantes;
var
  LCont: Integer;
  LRetorno: String;
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LobjMotoristaAjudante: TFusionMotoristaAjudante;
  LarrMotoristasAjudantes: Array of TFusionMotoristaAjudante;
begin
  LQry := fCriaQuery();

  try
    LQry.SQL.Add(sqlMotoristasAjudantesAEnviar);
    LQry.Open();

    if LQry.IsEmpty then
      Exit;

    LCont := 0;

    while not LQry.Eof do
    begin
      LCont := LCont + 1;
      LobjMotoristaAjudante := TFusionMotoristaAjudante.Create;

      LobjMotoristaAjudante.seq_id := LQry.FieldByName('CODIGO').AsString;
      LobjMotoristaAjudante.codigo_erp := LQry.FieldByName('CODIGO').AsString + Copy(LQry.FieldByName('TIPO').AsString,1,1); //	Codigo do Motorista ou Ajudante no sistema ERP.
      LobjMotoristaAjudante.nome := fTiraCaracEspeciais(LQry.FieldByName('NOME').AsString, False, False, False, False, False, False, False, CHAR_ESPECIAL);
      LobjMotoristaAjudante.cpf := LQry.FieldByName('NUMCPF').AsString;
      LobjMotoristaAjudante.tipo := LQry.FieldByName('TIPO').AsString; // ** Motorista ou Ajudante

      SetLength(LarrMotoristasAjudantes, Length(LarrMotoristasAjudantes) + 1);
      LarrMotoristasAjudantes[Length(LarrMotoristasAjudantes) - 1] := LobjMotoristaAjudante;

      if (LCont mod 10 = 0) or (LQry.RecNo = LQry.RecordCount) then
      begin
        LRetorno := TFusionIntegWS.New.fEnviar(LarrMotoristasAjudantes).fRetornoSucesso;

        pAtualizaEnvioMotoristasAjudantes(LRetorno, LQry.FieldByName('TIPO').AsString);

        LCont := 0;

        for LobjMotoristaAjudante in LarrMotoristasAjudantes do
          LobjMotoristaAjudante.Free;

        SetLength(LarrMotoristasAjudantes, 0);
      end;

      LQry.Next;
    end;
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFusion.pEnviaPedidos(ATipoEnvio: TTypeEnvioFusion; ASQL: String);
var
  LCont: Integer;
  LRetorno: String;
  LStatusPD: String;
  LOpenedTransaction: Boolean;
  LAtualizaTarefasFusion: Boolean;
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LQryItens: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LobjPedido: TFusionEntregaServico;
  LobjProduto: TFusionEntregaServicoItens;
  LarrPedidos: Array of TFusionEntregaServico;
begin
  ASQL := AnsiReplaceStr(ASQL, '<<COND_EXP4>>', IIF(((fCfgSis('TIPEXP', varInteger) = 4) and not (fCfgSis('LBFUMA', varBoolean))),
                                                    ' AND E.FGO_DTLBEX IS NOT NULL '+
                                                    ' AND E.FGO_DOCEND IS NULL ',
                                                    EmptyStr));

  ASQL := AnsiReplaceStr(ASQL, '<<COND_LBFUMA>>', IIF(fCfgSis('LBFUMA', varBoolean),
                                                      ' AND E.FGO_LIBFUS = "S" ',
                                                      EmptyStr));

  LQry := fCriaQuery();
  LQryItens := fCriaQuery();

  try
    if (ATipoEnvio = tpPedidoCancelado) then
      LQryItens.SQL.Add(StringReplace(sqlItensPedido, 'FATDOR', 'DEL_FATDOR', [rfReplaceAll]))
    else
      LQryItens.SQL.Add(sqlItensPedido);

    LOpenedTransaction := fInTransaction();

    try
      LQry.SQL.Add(ASQL);
      if ATipoEnvio <> tpPedidoBaixado then      
        LQry.ParamByName(IIF(ATipoEnvio = tpPedidos, 'EMPEXP', 'CODEMP')).AsString := VS_strCodEmp;

      if ATipoEnvio = tpPedidos then
      begin
        LQry.ParamByName('CLAVEN').AsString := FClaVen;
        LQry.ParamByName('JAFATU').AsInteger := (FFusEPD - 1);
      end;

      LQry.Open();

      if LQry.IsEmpty then
        Exit;

      LCont := 0;
      LAtualizaTarefasFusion := ATipoEnvio in [tpPedidoCancelado, tpPedidoBaixado, tpPedidoAlterado, tpExclusaoPDRomaneio, tpInclusaoPDRomaneio, tpPedidoAlteradoParaReprocessamento];

      if (not LOpenedTransaction) then
        fStartTransaction();

      while not LQry.Eof do
      begin
        if (Pos(LQry.FieldByName('FDO_CLAFIS').AsString, '5152_5409_') <= 0) and
           (fStatusCndPag(LQry.FieldByName('FGO_CONPAG').AsString) = A_VISTA) and
           (LQry.FieldByName('VALADT').AsFloat <= 0) and
           (ATipoEnvio = tpPedidos) then
        begin
          LQry.Next;
          Continue;
        end;

        if fDocumentoTravado('FATGOR',
                             LQry.FieldByName('NUMDOC').AsString,
                             LQry.FieldByName('ESPDOC').AsString,
                             LQry.FieldByName('EMPDOC').AsString,
                             LQry.FieldByName('CODCLI').AsString) then
        begin
          LQry.Next;
          Continue;
        end;

        LCont := LCont + 1;
        LobjPedido := TFusionEntregaServico.Create;

        LobjPedido.nf := LQry.FieldByName('NUMFAT').AsString; //	numero da nota fiscal
        LobjPedido.serie := LQry.FieldByName('SERFAT').AsString; //	codigo da serie da nota fiscal(nao obrig)
        LobjPedido.tipo := LQry.FieldByName('TIPFAT').AsString; // da nota fiscal(nao obrig)
        LobjPedido.ent_ou_serv := 'Entrega'; // Se for Entrega ou Serviço
        LobjPedido.pedido_erp := LQry.FieldByName('DOCERP').AsString; // codigo do pedido no seu sistem(ERP)
        LobjPedido.forma_pgto := LQry.FieldByName('CODFPG').AsString;
        LobjPedido.status := '1'; //	status 1 são normalmente para  coletas. 9 canceladas
        LobjPedido.obs := ''; // Caso for um endereço alternativo, pode-se colocar nesse campo @CEP, sendo o cep no formatao 00000-000
        LobjPedido.num_ped_conf := LQry.FieldByName('DOCERP').AsString;

        {carga: preenchido par incluir PD no romaneio / 0 para retirar de um romaneio / em branco enquanto não pertence a um romaneio}
        {podeformarcarga: S - pode formar carga / N - não pode formar carga (PD cancelado ou baixado)}

        LStatusPD := 'E';

        case ATipoEnvio of
          tpPedidos:
            begin
              LobjPedido.carga := '';
              LobjPedido.podeformarcarga := 'S'; // S pode formar carga
            end;
          tpPedidoCancelado:
            begin
              LobjPedido.carga := IIF(fEmptyStr(LQry.FieldByName('NUMROM').AsString), '', '0');
              LobjPedido.podeformarcarga := 'N'; // N para não incluir em novo romaneio
              LobjPedido.status := '9';
            end;
          tpPedidoBaixado:
            begin
              LobjPedido.carga := IIF(fEmptyStr(LQry.FieldByName('NUMROM').AsString), '', '0');
              LobjPedido.podeformarcarga := 'N'; // N para não incluir em novo romaneio
            end;
          tpPedidoAlterado:
            begin
              LobjPedido.carga := LQry.FieldByName('NUMROM').AsString;
              LobjPedido.podeformarcarga := IIF(fEmptyStr(LQry.FieldByName('NUMROM').AsString), 'S', 'N');

              LStatusPD := IIF(not fEmptyStr(LQry.FieldByName('NUMROM').AsString), 'R', 'E');
            end;
          tpPedidoAlteradoParaReprocessamento:
            begin
              LobjPedido.carga := IIF(fEmptyStr(LQry.FieldByName('NUMROM').AsString), '', '0');
              LobjPedido.podeformarcarga := 'N';

              LStatusPD := 'N';
            end;
          tpExclusaoPDRomaneio:
            begin
              LobjPedido.carga := '0'; // 0 para remover de um romaneio
              LobjPedido.podeformarcarga := 'S'; // S para permitir incluir em um novo romaneio pela Fusion
            end;
          tpInclusaoPDRomaneio:
            begin
              LobjPedido.carga := LQry.FieldByName('NUMROM').AsString;
              LobjPedido.podeformarcarga := 'N'; // N pois é sendo incluido em um romaneio e assim não poderá ser incluido em outro
              LStatusPD := 'R';
            end;
        end;

        LobjPedido.cubagem := FormatFloat('#0.00', LQry.FieldByName('CUBAGEM').AsFloat).Replace(FormatSettings.DecimalSeparator, '.'); //	Sim, mas não precisa ser metro cubico obrigatoriamente. Pode ser qualquer unidade que voce pode trabalhar.
        LobjPedido.valor := FormatFloat('#0.00', LQry.FieldByName('VLRCON').AsFloat).Replace(FormatSettings.DecimalSeparator, '.'); //	Sim, caso não exista pode passar zero.
        LobjPedido.peso := FormatFloat('#0.00', LQry.FieldByName('PESLIQ').AsFloat).Replace(FormatSettings.DecimalSeparator, '.');
        LobjPedido.valor_st :=	'0';
        LobjPedido.empresa_fat := LQry.FieldByName('EMPFAT').AsString; //	filial da fatura no ERP
        LobjPedido.empresa_log := LQry.FieldByName('EMPEXP').AsString; //	filial da logistica no ERP. onde será enviado os produtos.
        LobjPedido.empresa_digit := LQry.FieldByName('EMPDOC').AsString; //	filial da digitação no ERP.
        LobjPedido.pedido_orig := LQry.FieldByName('DOCERP').AsString; //	codigo do pedido do ERP

        LobjPedido.dt_list_nf :=
          StrToDateTime(FormatDateTime('dd/mm/yyyy', LQry.FieldByName('DTAEMI').AsDateTime) +' '
            +FormatDateTime('hh:nn:ss', LQry.FieldByName('HORENT').AsDateTime)); //	será a data da coleta.

        LobjPedido.nf_cod_rota_erp := ''; //	Necessário?
        LobjPedido.nf_descricao_rota := ''; //	Necessário?
        LobjPedido.descr_cliente := fTiraCaracEspeciais(LQry.FieldByName('CLI_NOMCLI').AsString, False, False, False, False, False, False, False, CHAR_ESPECIAL); //	descrição do cliente.
        LobjPedido.cnpj_cliente :=	fTiraCaracEspeciaisPonto(LQry.FieldByName('CLI_C_G_C_').AsString); //	sim, pode colocar o cpf
        LobjPedido.end_cliente := fTiraCaracEspeciais(LQry.FieldByName('ETC_ENDENT').AsString, False, False, False, False, False, False, False, CHAR_ESPECIAL); // endereço
        LobjPedido.bairro_cliente :=	fTiraCaracEspeciais(LQry.FieldByName('ETC_BAIENT').AsString, False, False, False, False, False, False, False, CHAR_ESPECIAL); // bairro
        LobjPedido.num_end_cliente := '';
        LobjPedido.uf_cliente :=	LQry.FieldByName('CID_ESTADO').AsString; // uf do endereço do cliente
        LobjPedido.cidade_cliente :=	fTiraCaracEspeciais(LQry.FieldByName('CID_NOMCID').AsString, False, False, False, False, False, False, False, CHAR_ESPECIAL); // cidade do cliente
        LobjPedido.cep_cliente := LQry.FieldByName('ETC_CEPENT').AsString; //	cep do cliente
        LobjPedido.email1_cliente :=	LQry.FieldByName('CLI_EMAIL_').AsString; // email do cliente
        LobjPedido.email2_cliente :=	LQry.FieldByName('CLI_EMAIL2').AsString; // email do cliente
        LobjPedido.email3_cliente :=	LQry.FieldByName('CLI_EMAIL3').AsString; // email do cliente
        LobjPedido.tel1_cliente :=	LQry.FieldByName('ETC_TELENT').AsString;	// telefone do cliente
        LobjPedido.tel2_cliente :=	''; // telefone do cliente
        LobjPedido.tel3_cliente :=	''; // telefone do cliente
        LobjPedido.vlr_credito_cliente := '0'; // Necessário?
        LobjPedido.data_cadastro_cliente := LQry.FieldByName('CLI_DTACAD').AsDateTime;
        LobjPedido.saldo_disp_cliente :=	'0'; // Necessário?
        LobjPedido.vlr_tits_vencido_cliente :=	'0';
        LobjPedido.vlr_tits_vencer_cliente :=	'0';
        LobjPedido.status_cred_cliente := 'C';
        LobjPedido.codigo_cliente :=	LQry.FieldByName('CODCLI').AsString; //	É o codigo do cliente no erp
        LobjPedido.cod_segmento :=	LQry.FieldByName('ATI_DESATI').AsString; // Necessário?
        LobjPedido.descr_segmento :=	''; // Necessário?
        LobjPedido.filial_padrao := LQry.FieldByName('EMPDOC').AsString;
        LobjPedido.data_ult_compra := LQry.FieldByName('CLI_ULTCOM').AsDateTime;
        LobjPedido.forma_pgto_cliente :=	'0'; // Necessário?
        LobjPedido.retem_icms_cliente :=	'N';
        LobjPedido.permite_retira_cliente :=	'N';
        LobjPedido.rede_loja_cliente := LQry.FieldByName('EMPDOC').AsString; // Necessário?
        LobjPedido.vendedor_erp :=	LQry.FieldByName('NOMVEN').AsString;
        LobjPedido.praca_cod_erp := '1';
        LobjPedido.praca_descricao := 'PADRAO';
        LobjPedido.rota_cod_erp := '1';
        LobjPedido.rota_descricao := 'PADRAO';

        LobjPedido.data_pedido :=
          StrToDateTime(FormatDateTime('dd/mm/yyyy', LQry.FieldByName('DTAEMI').AsDateTime) +' '
            +FormatDateTime('hh:nn:ss', LQry.FieldByName('HORENT').AsDateTime)); // data do processamento do pedido.


        if (LQry.FieldByName('ENDFAT').AsString = 'S') then
          LobjPedido.codigo_endereco_alt := '0'
        else
          LobjPedido.codigo_endereco_alt := LQry.FieldByName('CODENDERE').AsString;

        LQryItens.Close;
        LQryItens.ParamByName('SEQGER').AsString := LQry.FieldByName('SEQGER').AsString;
        LQryItens.Open;

        SetLength(LobjPedido.arrProdutos, 0);

        while not LQryItens.Eof do
        begin
          LobjProduto := TFusionEntregaServicoItens.Create;

          LobjProduto.cod_produto_erp := LQryItens.FieldByName('FDO_CODITE').AsString;
          LobjProduto.descricao	:= StringReplace(fTiraCaracEspeciais(LQryItens.FieldByName('ITE_DESITE').AsString, False, False, False, False, False, False, False, CHAR_ESPECIAL), '"', '', [rfReplaceAll]);
          LobjProduto.qtd := FormatFloat('#0.00', LQryItens.FieldByName('FDO_QTDITE').AsFloat).Replace(FormatSettings.DecimalSeparator, '.');
          LobjProduto.preco := FormatFloat('#0.00', LQryItens.FieldByName('FDO_UNITAR').AsFloat).Replace(FormatSettings.DecimalSeparator, '.');
          LobjProduto.subtotal := FormatFloat('#0.00', LQryItens.FieldByName('FDO_TOTITE').AsFloat).Replace(FormatSettings.DecimalSeparator, '.');
          LobjProduto.unidade := LQryItens.FieldByName('UNI_SIGUNI').AsString;

          SetLength(LobjPedido.arrProdutos, Length(LobjPedido.arrProdutos) + 1);
          LobjPedido.arrProdutos[Length(LobjPedido.arrProdutos) - 1] := LobjProduto;

          LQryItens.Next;
        end;

        SetLength(LarrPedidos, Length(LarrPedidos) + 1);
        LarrPedidos[Length(LarrPedidos) - 1] := LobjPedido;

        if (LCont mod 5 = 0) or (LQry.RecNo = LQry.RecordCount) then
        begin
          LRetorno := TFusionIntegWS.New.fEnviar(LarrPedidos).fRetornoSucesso;
          LRetorno := AnsiReplaceStr(LRetorno, '"', '');
          pAtualizaEnvioPedidos(LRetorno, LStatusPD, IIF((ATipoEnvio = tpPedidos), VS_Date + fTime(), 0));

          if LAtualizaTarefasFusion then
            pAtualizaEnvioTarefas(LRetorno);

          LCont := 0;

          for LobjPedido in LarrPedidos do
            LobjPedido.Free;

          SetLength(LarrPedidos, 0);
        end;

        LQry.Next;
      end;

      if (not LOpenedTransaction) then
        fCommit();
    except on E: Exception do
    begin
        if (not LOpenedTransaction) then
          fRollBack();
        raise;
      end;
    end;
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
    FreeAndNil(LQryItens);
{$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFusion.pEnviaStatusRomaneioFinalizado;
var
  FusionAtualizaCarga: TFusionAtualizaCarga;
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  blnCargaAtualizada: Boolean;
begin
  LQry := fCriaQuery;
  FusionAtualizaCarga := TFusionAtualizaCarga.Create;
  try
    LQry.Close;
    LQry.SQL.Text := sqlRomaneioFinalizado;
    LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQry.Open;

    while not LQry.Eof do
    begin
      FusionAtualizaCarga.carga.codigo_erp := LQry.FieldByName('FUS_NUMROM').AsString;
      FusionAtualizaCarga.carga.status := 'FINALIZADO';
      FusionAtualizaCarga.carga.codmotorista := LQry.FieldByName('GER_CODMOT').AsString;
      FusionAtualizaCarga.carga.codveiculo := LQry.FieldByName('CODVEI').AsString;
      FusionAtualizaCarga.motorista.nome := LQry.FieldByName('MOT_NOMMOT').AsString;
      FusionAtualizaCarga.motorista.cpf := LQry.FieldByName('MOT_CPFMOT').AsString;
      FusionAtualizaCarga.motorista.tipo := 'MOTORISTA';
      FusionAtualizaCarga.veiculo.tipo_combustivel := 'GASOLINA';

      blnCargaAtualizada := (TFusionIntegWS.New.fAtualizaCarga(FusionAtualizaCarga).fRetornoSucesso.ToLower = 'true');
      if blnCargaAtualizada then
        pAtualizaEnvioTarefas(LQry.FieldByName('FUS_NUMROM').AsString, LQry.FieldByName('FUS_EMPROM').AsString, 'F');

      LQry.Next;
    end;
  finally
    FreeAndNil(FusionAtualizaCarga);
    {$IFNDEF LINUX}
    FreeAndNil(LQry);
    {$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFusion.pEnviaVeiculos;
var
  LCont: Integer;
  LRetorno: String;
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LobjVeiculo: TFusionVeiculo;
  LarrVeiculos: Array of TFusionVeiculo;
begin
  LQry := fCriaQuery();

  try
    LQry.SQL.Add(sqlVeiculosAEnviar);
    LQry.Open();

    if LQry.IsEmpty then
      ExiT;

    LCont := 0;

    while not LQry.Eof do
    begin
      LCont := LCont + 1;
      LobjVeiculo := TFusionVeiculo.Create;

      LobjVeiculo.codigo_erp :=	LQry.FieldByName('AUTOINCREM').AsString; //	código do veiculo no erp
      LobjVeiculo.placa	:= LQry.FieldByName('VEI_PLAVEI').AsString; // placa do veiculo
      LobjVeiculo.descricao	:= fTiraCaracEspeciais(LQry.FieldByName('DESCRICAO').AsString, False, False, False, False, False, False, False, CHAR_ESPECIAL); //	descricao do veiculo
      LobjVeiculo.modelo :=	fTiraCaracEspeciais(LQry.FieldByName('DESCRICAO').AsString, False, False, False, False, False, False, False, CHAR_ESPECIAL); //	modelo do veiculo
      LobjVeiculo.anoModelo := LQry.FieldByName('VEI_ANOVEI').AsString; //	ano do modelo do veiculo
      LobjVeiculo.anoFabricacao :=	LQry.FieldByName('VEI_ANOVEI').AsString; //	ano fabricado
      LobjVeiculo.status_inicial :=	'Livre'; // normalmente é vindo com padrão, que o status é Livre

      SetLength(LarrVeiculos, Length(LarrVeiculos) + 1);
      LarrVeiculos[Length(LarrVeiculos) - 1] := LobjVeiculo;

      if (LCont mod 10 = 0) or (LQry.RecNo = LQry.RecordCount) then
      begin
        LRetorno := TFusionIntegWS.New.fEnviar(LarrVeiculos).fRetornoSucesso;
        pAtualizaEnvioVeiculos(LRetorno);

        LCont := 0;

        for LobjVeiculo in LarrVeiculos do
          LobjVeiculo.Free;

        SetLength(LarrVeiculos, 0);
      end;

      LQry.Next;
    end;
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFusion.pExecute;
begin
  case FParam of
    tpVeiculos: pEnviaVeiculos;
    tpMotoristasAjudantes: pEnviaMotoristasAjudantes;
    tpPedidos: pEnviaPedidos(tpPedidos, sqlPedidosAEnviar);
    tpRomaneioCancelado: pEnviaCancelamentoRomaneio;
    tpPedidoCancelado: pEnviaPedidos(tpPedidoCancelado, sqlPedidosCancelados);
    tpPedidoBaixado: pEnviaPedidos(tpPedidoBaixado, sqlPedidosBaixados);
    tpPedidoAlterado: pEnviaPedidos(tpPedidoAlterado, sqlPedidosAlterados);
    tpPedidoAlteradoParaReprocessamento: pEnviaPedidos(tpPedidoAlteradoParaReprocessamento, sqlPedidosAlteradosParaReprocessamento);
    tpExclusaoPDRomaneio: pEnviaPedidos(tpExclusaoPDRomaneio, sqlExclusaoPDRomaneio);
    tpInclusaoPDRomaneio: pEnviaPedidos(tpInclusaoPDRomaneio, sqlInclusaoPDRomaneio);
    tpRomaneioFinalizado: pEnviaStatusRomaneioFinalizado;
  end;
end;

procedure TEnviaRegistrosFusion.pExecuteAll;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LTempoReprocessar: Integer;
begin
  if (not fCfgSis('FUSUSA', varBoolean)) then
    Exit;

  if (fEmptyStr(fCfgSis('FUSUSR', varString)) or fEmptyStr(fCfgSis('FUSSEN', varString))) then
    Exit;

  FClaVen := fTransform(fCfgSis('CLAVEN'), 4);
  FFusEPD := 1; // fCfgSis('FUSEPD', varInteger);

  try
    LTempoReprocessar := fCfgSis('FUSINT', VarInteger);
  except
    LTempoReprocessar := 10;
  end;

  if MinutesBetween(VS_Date + fTime(True), FLastProcessamento) <= LTempoReprocessar then
    Exit;

  FLastProcessamento := VS_Date + fTime(True);
  LQry := fCriaQuery();

  try
    { *** Envia Veículos *** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFusion.New(tpVeiculos).pExecute();

    { *** Envia Motoristas *** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFusion.New(tpMotoristasAjudantes).pExecute();

    { *** Envia Pedidos *** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFusion.New(tpPedidos).pExecute();

    { *** Envia Romaneio cancelado *** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFusion.New(tpRomaneioCancelado).pExecute();

    { *** Envia Pedidos cancelados *** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFusion.New(tpPedidoCancelado).pExecute();

    { *** Envia Pedidos baixados *** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFusion.New(tpPedidoBaixado).pExecute();

    { *** Envia Pedidos alterados *** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFusion.New(tpPedidoAlterado).pExecute();

    { *** Envia Pedidos alterados para reprocessamento*** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFusion.New(tpPedidoAlteradoParaReprocessamento).pExecute();

    { *** Envia Pedidos incluídos Romaneio *** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFusion.New(tpInclusaoPDRomaneio).pExecute();

    { *** Envia Pedidos removidos de Romaneio *** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFusion.New(tpExclusaoPDRomaneio).pExecute();

    { *** Envia status romaneio FINALIZADO *** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFusion.New(tpRomaneioFinalizado).pExecute();

  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

end.
