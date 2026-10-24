DELIMITER $$

USE `AUTCOM`$$

DROP FUNCTION IF EXISTS `fGiroSaidaGlobal`$$

CREATE DEFINER=`dbacitel`@`localhost` FUNCTION `fGiroSaidaGlobal`(strCodIte VARCHAR(10), strCodEmp CHAR(3), strAno CHAR(4), intMes INT) RETURNS DECIMAL(14,2)
BEGIN
      RETURN IFNULL((SELECT CASE intMes 
                       WHEN 01 THEN SUM(IFNULL(GIR_QSAI01, 0))
                       WHEN 02 THEN SUM(IFNULL(GIR_QSAI02, 0))
                       WHEN 03 THEN SUM(IFNULL(GIR_QSAI03, 0))
                       WHEN 04 THEN SUM(IFNULL(GIR_QSAI04, 0))
                       WHEN 05 THEN SUM(IFNULL(GIR_QSAI05, 0))
                       WHEN 06 THEN SUM(IFNULL(GIR_QSAI06, 0))
                       WHEN 07 THEN SUM(IFNULL(GIR_QSAI07, 0))
                       WHEN 08 THEN SUM(IFNULL(GIR_QSAI08, 0))
                       WHEN 09 THEN SUM(IFNULL(GIR_QSAI09, 0))
                       WHEN 10 THEN SUM(IFNULL(GIR_QSAI10, 0))
                       WHEN 11 THEN SUM(IFNULL(GIR_QSAI11, 0))
                       WHEN 12 THEN SUM(IFNULL(GIR_QSAI12, 0))
                     END  
              FROM GIRITE 
              INNER JOIN PAREMP ON GIR_CODEMP = PAR_CODEMP AND GIR_CODITE = PAR_CODITE
              INNER JOIN CADITE C ON C.ITE_CODITE = GIR_CODITE
              LEFT JOIN AUTFOR ON GIR_CODEMP = AUT_CODEMP AND ITE_CODFOR = AUT_CODFOR
              WHERE IF(PAR_ORIITE = 'N' AND PAR_TIPEMP = 2 AND AUT_CODFOR IS NOT NULL, PAR_CODEMP , PAR_EMPGRU) = strCodEmp 
               AND GIR_CODITE = strCodIte AND GIR_A_N_O_ = strAno), 0.00);
    END$$

DELIMITER ;