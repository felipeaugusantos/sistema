DELIMITER $$

DROP PROCEDURE IF EXISTS `Insert_Contabilidade_CHQ`$$

CREATE PROCEDURE `Insert_Contabilidade_CHQ` () 
BEGIN
  SET @CHQ_DEFINITIVA = 
  (SELECT 
    COUNT(*) 
  FROM
    PARCON 
  WHERE CON_TIPLAN = 'CHQ' 
    AND CON_DESVAL = 'Vr.Cheque Dev.Definitiva') ;
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
    "CHQ",
    CHQ_CODEMP,
    "CADCHQ",
    0,
    C.AUTOINCREM,
    1,
    NULL 
  FROM
    CADCHQ C 
  WHERE CHQ_DTADEP = CURRENT_DATE 
    AND IF(
      @CHQ_DEFINITIVA = 0,
      TRUE,
      (IFNULL(CHQ_DEVDEF, 0) = 0)
    ) 
    UNION
    ALL 
    SELECT DISTINCT 
      "CHQ",
      CHQ_CODEMP,
      "CADCHQ",
      0,
      C.AUTOINCREM,
      1,
      NULL 
    FROM
      CADCHQ C 
    WHERE CHQ_DTADP2 = CURRENT_DATE 
      AND IF(
        @CHQ_DEFINITIVA = 0,
        TRUE,
        (IFNULL(CHQ_DEVDEF, 0) = 0)
      ) 
      UNION
      ALL 
      SELECT DISTINCT 
        "CHQ",
        CHQ_CODEMP,
        "CADCHQ",
        0,
        C.AUTOINCREM,
        1,
        NULL 
      FROM
        CADCHQ C 
      WHERE CHQ_DTADEV = CURRENT_DATE 
        AND IF(
          @CHQ_DEFINITIVA = 0,
          TRUE,
          (IFNULL(CHQ_DEVDEF, 0) = 0)
        ) 
        UNION
        ALL 
        SELECT DISTINCT 
          "CHQ",
          CHQ_CODEMP,
          "CADCHQ",
          0,
          C.AUTOINCREM,
          1,
          NULL 
        FROM
          CADCHQ C 
        WHERE CHQ_DTADV2 = CURRENT_DATE 
          AND IF(
            @CHQ_DEFINITIVA = 0,
            TRUE,
            (IFNULL(CHQ_DEVDEF, 0) = 0)
          ) 
          UNION
          ALL 
          SELECT DISTINCT 
            "CHQ",
            CHQ_CODEMP,
            "CADCHQ",
            0,
            C.AUTOINCREM,
            1,
            NULL 
          FROM
            CADCHQ C 
          WHERE CHQ_DTADEV = CURRENT_DATE 
            AND IFNULL(CHQ_DEVDEF, 0) = 1 
            AND IF(@CHQ_DEFINITIVA = 1, TRUE, FALSE) 
            UNION
            ALL 
            SELECT DISTINCT 
              "CHQ",
              CHQ_CODEMP,
              "CADCHQ",
              0,
              C.AUTOINCREM,
              1,
              NULL 
            FROM
              CADCHQ C 
            WHERE CHQ_DTADV2 = CURRENT_DATE 
              AND IFNULL(CHQ_DEVDEF, 0) = 1 
              AND IF(@CHQ_DEFINITIVA = 1, TRUE, FALSE) 
              UNION
              ALL 
              SELECT DISTINCT 
                "CHQ",
                CHQ_CODEMP,
                "CADCHQ",
                0,
                C.AUTOINCREM,
                2,
                NULL 
              FROM
                DEL_CADCHQ C 
              WHERE C.DTADEL = CURRENT_DATE 
                AND IFNULL(CHQ_DEVDEF, 0) = 1 
                AND IF(@CHQ_DEFINITIVA = 1, TRUE, FALSE) 
                UNION
                ALL 
                SELECT DISTINCT 
                  "CHQ",
                  CHQ_CODEMP,
                  "CADCHQ",
                  0,
                  C.AUTOINCREM,
                  2,
                  NULL 
                FROM
                  DEL_CADCHQ C 
                WHERE C.DTADEL = CURRENT_DATE 
                  AND IF(
                    @CHQ_DEFINITIVA = 0,
                    TRUE,
                    (IFNULL(CHQ_DEVDEF, 0) = 0)
                  ) 
                  UNION
                  ALL 
                  SELECT DISTINCT 
                    "CHQ",
                    C.CHQ_CODEMP,
                    "CADCHQ",
                    0,
                    C.AUTOINCREM,
                    2,
                    NULL 
                  FROM
                    LOGCHQ LC 
                    JOIN CADCHQ C 
                      ON C.CHQ_CODBCO = LC.CHQ_CODBCO 
                      AND C.CHQ_NUMAGE = LC.CHQ_NUMAGE 
                      AND C.CHQ_CONCOR = LC.CHQ_CONCOR 
                      AND C.CHQ_NUMCHQ = LC.CHQ_NUMCHQ 
                      AND C.CHQ_CODEMP = LC.CHQ_CODEMP 
                  WHERE CHQ_HISLOG LIKE '%ESTORNO%' 
                    AND CHQ_DTALOG = CURRENT_DATE ;
END $$

DELIMITER ;