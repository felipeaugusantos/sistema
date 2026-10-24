DELIMITER $$

USE `AUTCOM`$$

DROP FUNCTION IF EXISTS `fDataPedidoCompraMaisAntigoGlobal`$$

CREATE DEFINER=`dbacitel`@`localhost` FUNCTION `fDataPedidoCompraMaisAntigoGlobal`(strCodIte VARCHAR(10), strCodEmp CHAR(3)) RETURNS DATE
BEGIN 

    RETURN  CAST((SELECT 
                      MIN(PCG_DTAPED) 
                   FROM PCMDET 
                   INNER JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED AND PCG_CODEMP = PCD_CODEMP AND PCG_ESPDOC = PCD_ESPDOC
                   
                   INNER JOIN PAREMP ON PAR_CODEMP = IFNULL(PCG_EMPDES, PCG_CODEMP) AND PAR_CODITE = PCD_CODITE
                   INNER JOIN CADITE C ON C.ITE_CODITE = PCD_CODITE
                   LEFT JOIN AUTFOR ON IFNULL(PCG_EMPDES, PCG_CODEMP) = AUT_CODEMP AND ITE_CODFOR = AUT_CODFOR
                   WHERE IF(PAR_ORIITE = 'N' AND PAR_TIPEMP = 2 AND AUT_CODFOR IS NOT NULL, PAR_CODEMP , PAR_EMPGRU) = strCodEmp 
                     AND PCD_NUMCTN = 0 AND PCD_ESPDOC = "PD" AND PCD_CODITE = strCodite AND PCD_BAIXAD = 0
                     AND ((PAR_SUGGAR = 'S') OR
                              (IFNULL(PCG_DOCORI, "") = "") OR               
                              (IFNULL(                                           
                                 (SELECT COUNT(1) FROM MOVGAE 
                                  WHERE 
                                        SUBSTRING(PCD_DOCORI,1,12) = GAE_NUMENV 
                                    AND SUBSTRING(PCD_DOCORI,13,2) = GAE_ESPENV 
                                    AND PCD_CODEMP = GAE_EMPENV), 0) = 0))) AS DATE);
END$$

DELIMITER ;