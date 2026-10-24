DELIMITER $$

DROP PROCEDURE IF EXISTS `pRotinasNoturnasRecalculoGiroSaidaDias`$$

CREATE DEFINER=`dbacitel`@`localhost` PROCEDURE `pRotinasNoturnasRecalculoGiroSaidaDias`()
    COMMENT 'Recalculo Giro Saida Dias'
BEGIN

#######################################################################################################################
# Procedure......: Procedure para Calculo do Giro de Saida                                                            #     
# Autor..........: Laércio                                                                                            #     
# Data...........: 29/05/2019                                                                                         #     
# Versao.........: 1.0                                                                                                #     
#######################################################################################################################
#=======================================================================================================================
# ETAPA 01 - CRIACAO DO ARQUIVO DE LOG
#=======================================================================================================================
SET @HORLOG = NOW();
INSERT INTO LOGNOT( LOG_DESCRI, LOG_VERSAO, LOG_HORINI ) VALUES( 'CALCULO_GIRO_SAIDA_DIAS', '1.0', @HORLOG );
#=======================================================================================================================
#=======================================================================================================================
# ETAPA 02 - DEFINICAO DOS PARAMETROS.
#=======================================================================================================================
CALL pCriaTemporariaParEmp;
SET @@SQL_MODE='';
SET @@SQL_LOG_BIN=0;
SET @@max_heap_table_size = 1073741824; -- 1G
SET @@tmp_table_size      = 1073741824; -- 1G
SET @CODEMP = ( SELECT PRO_CODEMP FROM PROCOD WHERE PRO_NOMARQ = 'MOVGER' );
#=======================================================================================================================
SET @CLAGIR = (SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = 'CFG_CLAGIR' AND SIS_CODEMP = @CODEMP );
SET @CLAGIR = fTransform(@CLAGIR, 4, '_');
#=======================================================================================================================
SET @ESPGIR = (SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = 'CFG_ESPGIR' AND SIS_CODEMP = @CODEMP );
SET @ESPGIR = fTransform(@ESPGIR, 2, '_');
#=======================================================================================================================
SET @CFLGIR = (SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = 'CFG_CFLGIR' AND SIS_CODEMP = @CODEMP );
#=======================================================================================================================
DROP TABLE IF EXISTS GIRO_SAIDA_DIAS;
CREATE TABLE GIRO_SAIDA_DIAS(
  GIR_CODITE CHAR(7),
  GIR_CODEMP CHAR(3),
  GIR_DIAGIR INT,
  GIR_QTDSAI DECIMAL (14, 4),
  KEY GIRO_SAIDA_DIAS_INDICE (GIR_CODITE, GIR_CODEMP, GIR_DIAGIR)
) ENGINE = HEAP DEFAULT CHARSET = LATIN1;
INSERT INTO GIRO_SAIDA_DIAS   
  SELECT SQL_NO_CACHE
    DET_CODITE,    
    DET_CODEMP,
    PAR_DIAGIR,
    SUM(IF(LEFT( DET_CLAFIS, 1 ) < 5, -1, 1) *
        IF(A.ITE_CNV_ML > 0, 
           IF( DET_ESPDOC = 'ML', ROUND( DET_QTDITE / A.ITE_CNV_ML, 4 ), ROUND( DET_QTDITE, 4 )),
           DET_QTDITE )) 
     - IF(PAR_DIAGIR >= 6 AND PAR_DESMAI = 'S', 
            MAX(IF(LEFT( DET_CLAFIS, 1 ) < 5, -1, 1) *
                         IF(A.ITE_CNV_ML > 0, 
                         IF( DET_ESPDOC = 'ML', ROUND( DET_QTDITE / A.ITE_CNV_ML, 4 ), ROUND( DET_QTDITE, 4 )),
                         DET_QTDITE )) +
            MIN(IF(LEFT( DET_CLAFIS, 1 ) < 5, -1, 1) *
                        IF(A.ITE_CNV_ML > 0, 
                        IF( DET_ESPDOC = 'ML', ROUND( DET_QTDITE / A.ITE_CNV_ML, 4 ), ROUND( DET_QTDITE, 4 )),
                        DET_QTDITE ))                         
      , 0) AS DET_QTDITE
  FROM 
    MOVDET
  JOIN ITEGER B ON DET_CODITE = B.ITE_CODITE AND DET_CODEMP = B.ITE_CODEMP
  JOIN CADITE A ON DET_CODITE = A.ITE_CODITE
  INNER JOIN PAREMP   ON PAR_CODEMP   = B.ITE_CODEMP AND PAR_CODITE = B.ITE_CODITE
  WHERE 
    PAR_USAMES = 'N'                                                                                  AND
    DET_FILKAR = 0                                                                                    AND
    DET_DTAENT BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL PAR_DIAGIR DAY) AND DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)  AND
    ( LOCATE( DET_CLAFIS, @CLAGIR ) > 0 OR ( DET_ESPDOC = 'ML' AND IFNULL( DET_TIPFAT,'' ) <> 'AJ') ) AND
    ( LOCATE( DET_ESPDOC, @ESPGIR ) > 0 OR ( DET_ESPDOC = 'ML' AND IFNULL( DET_TIPFAT,'' ) <> 'AJ') ) AND
    IF( @CFLGIR = 'S', TRUE, DET_CODCLI NOT IN ( SELECT IFNULL( EMP_CLIFIL, '' ) FROM CADEMP)) 

  GROUP BY
    DET_CODITE, DET_CODEMP;
UPDATE LOGNOT SET LOG_HORFIN = NOW(), LOG_EXECUT = 'S' WHERE LOG_DESCRI = 'CALCULO_GIRO_SAIDA_DIAS' AND LOG_HORINI = @HORLOG;
END$$

DELIMITER ;