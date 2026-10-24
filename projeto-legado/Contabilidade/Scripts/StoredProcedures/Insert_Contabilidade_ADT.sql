DELIMITER $$

DROP PROCEDURE IF EXISTS `Insert_Contabilidade_ADT` $$

CREATE PROCEDURE `Insert_Contabilidade_ADT` () 
BEGIN
  INSERT CONLOG (
    LOG_TIPLAN,
    LOG_EMPLAN,
    LOG_TABELA,
    LOG_PROCES,
    LOG_INCDOC,
    LOG_MODLAN,
    LOG_STATUS
  ) 
  SELECT DISTINCT 
    "ADT",
    ADT.ADT_CODEMP,
    "ADTCLI",
    0,
    ADT.AUTOINCREM,
    1,
    NULL 
  FROM
    ADTCLI ADT 
  WHERE ADT_DTALAN = CURRENT_DATE 
    AND (
      (ADT_TIPLAN = "C") 
      OR (
        (ADT_TIPLAN = "D") 
        AND (ADT_ESTORN = "S")
      )
    ) 
  UNION
  ALL 
  SELECT DISTINCT 
    "ADT",
    ADT.ADT_CODEMP,
    "ADTCLI",
    0,
    ADT.AUTOINCREM,
    2,
    NULL 
  FROM
    DEL_ADTCLI ADT 
  WHERE ADT.DTADEL = CURRENT_DATE 
    AND (
      (ADT_TIPLAN = "C") 
      OR (
        (ADT_TIPLAN = "D") 
        AND (ADT_ESTORN = "S")
      )
    )  ;
END $$
  
DELIMITER ;