DELIMITER $$

USE `AUTCOM`$$

DROP PROCEDURE IF EXISTS `Insert_Contabilidade_CRC`$$

CREATE DEFINER=`routines`@`localhost` PROCEDURE `Insert_Contabilidade_CRC`()
BEGIN
  DECLARE fim INT DEFAULT FALSE;
  # VARIAVEL DE SCAPE
   DECLARE vCODEMP VARCHAR (150);
  # VARIAVEL PARA RECEBER O VALOR DO CURSOR
   DECLARE curl CURSOR FOR
  SELECT
    EMP_CODEMP
  FROM
    CADEMP;
  #DECLARAÇÃO DO CURSOR
   DECLARE CONTINUE HANDLER FOR NOT FOUND # EXCEPTION DO CURSOR.
   SET fim = TRUE;
  # ABRE O CURSOR.
#=======================================================================================================================
# GRAVA A LOG_ROTNOT
#=======================================================================================================================
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1 @R_SQLSTATE = RETURNED_SQLSTATE,
    @M_TEXT = MESSAGE_TEXT;
    SELECT
      CONCAT(
        @R_SQLSTATE,
        '-',
        @M_TEXT,
        '-',
        @LOCAL_PROC,
        ' ',
        @PONTO_PROC
      );
    INSERT INTO LOG_ROTNOT
    VALUES
      (
        CONCAT(
          @R_SQLSTATE,
          '-',
          @M_TEXT,
          '-',
          @LOCAL_PROC,
          ' ',
          @PONTO_PROC
        ),
        CURRENT_DATE,
        CURRENT_TIME
      );
    UPDATE
      LOGNOT
    SET
      LOG_HORFIN = NOW(),
      LOG_EXECUT = 'N'
    WHERE LOG_DESCRI = 'Insert_Contabilidade_CRC'
      AND LOG_HORINI = @HORLOG;
    SET @ERROR = 'S';
  END;
  #=======================================================================================================================
   SET @ERROR = 'N';
  SET @LOCAL_PROC = 'Insert_Contabilidade_CRC';
  SET @PONTO_PROC = '';
  #=======================================================================================================================
# GRAVA A LOGNOT
#=======================================================================================================================
   SET @HORLOG = NOW();
  INSERT INTO LOGNOT (
    LOG_DESCRI,
    LOG_VERSAO,
    LOG_HORINI
  )
  VALUES
    (
      'Insert_Contabilidade_CRC',
      '1.0',
      @HORLOG
    );
  #=======================================================================================================================
   OPEN curl;
  #abre o loop
   READ_LOOP :
  LOOP
    #pega proximo valor do cursor
     FETCH curl INTO vCODEMP;
/*
    SET @DTAOCO = (SELECT  MAX(DTAOCO) FROM (SELECT MAX(IFNULL(LOG_DTAOCO, "1900-01-01")) DTAOCO FROM CONLOG WHERE LOG_TIPLAN = 'CRC' AND LOG_EMPLAN = vCODEMP
      UNION  SELECT MAX(IFNULL(CON_DTALAN, "1900-01-01")) DTAOCO FROM LANCON WHERE CON_TIPLAN = 'CRC'         AND CON_EMPLAN = vCODEMP) TMP);
    
    SET @DTAREF = (SELECT MAX(FEC_DTAREF) FROM FECFIN WHERE FEC_CODEMP = vCODEMP);
*/

SELECT MAX(A.FEC_DTAREF) AS DTAREF, (SELECT FEC_PROCES FROM FECFIN B WHERE B.FEC_CODEMP = A.FEC_CODEMP AND B.FEC_DTAREF = MAX(A.FEC_DTAREF)) AS PROCES FROM FECFIN A WHERE FEC_CODEMP = vCODEMP 
INTO @DTAREF , @PROCES ;      
SET @DTAOCO =  ADDDATE(LAST_DAY(SUBDATE(@DTAREF, INTERVAL 1 MONTH)), INTERVAL 1 DAY);
   
    #SELECT @DTAOCO, @DTAREF;
    
    IF LOCATE('CRC', @PROCES) = 0 THEN  
    
    INSERT CONLOG (
      LOG_TIPLAN,
      LOG_EMPLAN,
      LOG_TABELA,
      LOG_PROCES,
      LOG_INCDOC,
      LOG_MODLAN,
      LOG_STATUS,
      LOG_DTAOCO,
      LOG_DTALAN
    )
    SELECT DISTINCT
      "CRC",
      CTR.CTR_CODEMP,
      "CADREC",
      0,
      CTR.AUTOINCREM,
      1,
      NULL,
      @DTAREF,
      CTR.CTR_DTACAD
    FROM
      CADREC CTR
      JOIN CADPOR
        ON POR_CODPOR = CTR_CODPOR
    WHERE CTR_ESPDOC = "CC"
      AND CTR.CTR_VALORI < 0.0
      AND CTR.CTR_SEQBAI = 0
      AND CTR.CTR_DTACAD BETWEEN IFNULL(@DTAOCO , @DTAREF ) AND @DTAREF
      AND CTR.CTR_CODEMP = vCODEMP
      AND IFNULL(CADPOR.POR_EXPAUT, "S") = "S"
      AND CTR.AUTOINCREM NOT IN (
      SELECT LOG_INCDOC FROM CONLOG WHERE LOG_TIPLAN='CRC' AND  LOG_DTALAN BETWEEN  @DTAOCO AND @DTAREF AND LOG_EMPLAN = vCODEMP)
    UNION ALL
    SELECT DISTINCT
      "CRC",
      CTR.CTR_CODEMP,
      "CADREC",
      0,
      CTR.AUTOINCREM,
      1,
      NULL,
      @DTAREF,
      CTR.CTR_DTACAD
    FROM
      DEL_CADREC CTR
      JOIN CADPOR
        ON POR_CODPOR = CTR_CODPOR
    WHERE CTR_ESPDOC = "CC"
      AND CTR.CTR_VALORI < 0.0
      AND CTR.CTR_SEQBAI = 0
      AND CTR.CTR_DTACAD BETWEEN IFNULL(@DTAOCO , @DTAREF ) AND @DTAREF
      AND CTR.CTR_CODEMP = vCODEMP
      AND IFNULL(CADPOR.POR_EXPAUT, "S") = "S"
      AND CTR.AUTOINCREM NOT IN (
      SELECT LOG_INCDOC FROM CONLOG WHERE LOG_TIPLAN='CRC' AND  LOG_DTALAN BETWEEN  @DTAOCO AND @DTAREF AND LOG_EMPLAN = vCODEMP)
    UNION ALL
    SELECT DISTINCT
      "CRC",
      CTR.CTR_CODEMP,
      "DUPAGR",
      0,
      CTR.AUTOINCREM,
      1,
      NULL,
      @DTAREF,
      CTR.CTR_DTACAD
    FROM
      DUPAGR CTR
      JOIN CADPOR
        ON POR_CODPOR = CTR_CODPOR
    WHERE CTR_ESPDOC = "CC"
      AND CTR.CTR_VALORI < 0.0
      AND CTR.CTR_SEQBAI = 0
      AND CTR.CTR_DTACAD BETWEEN IFNULL(@DTAOCO , @DTAREF ) AND @DTAREF
      AND CTR.CTR_CODEMP = vCODEMP
      AND IFNULL(CADPOR.POR_EXPAUT, "S") = "S"
      AND CTR.AUTOINCREM NOT IN (
      SELECT LOG_INCDOC FROM CONLOG WHERE LOG_TIPLAN='CRC' AND  LOG_DTALAN BETWEEN  @DTAOCO AND @DTAREF AND LOG_EMPLAN = vCODEMP);

     	    IF LAST_DAY(@DTAREF) = @DTAREF THEN

	       UPDATE FECFIN SET FEC_PROCES = CONCAT(FEC_PROCES, '_CRC') WHERE FEC_CODEMP = vCODEMP AND FEC_DTAREF = @DTAREF; 
	    
	    END IF;  
	    
    END IF;      
    
    IF fim
    THEN LEAVE read_loop;
    END IF;
  END LOOP;
  #fecha cursor
   CLOSE curl;
  #=======================================================================================================================
# FECHA O ARQUIVO DE LOG
#=======================================================================================================================
   IF (@ERROR = 'N')
  THEN
  UPDATE
    LOGNOT
  SET
    LOG_HORFIN = NOW(),
    LOG_EXECUT = 'S'
  WHERE LOG_DESCRI = 'Insert_Contabilidade_CRC'
    AND LOG_HORINI = @HORLOG;
  END IF;
  #=======================================================================================================================
 END$$

DELIMITER ;