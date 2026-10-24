/*
# TABELA DE CONFIGURAÇÃO DA PASTA DE COMPRAS 
*/
CREATE TABLE `CFG_PASTACOMPRA` (                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
          `SIS_CODEMP` CHAR(3) NOT NULL DEFAULT '',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
          `SIS_CODCFG` VARCHAR(20) CHARACTER SET UTF8 NOT NULL DEFAULT '',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
          `SIS_DESCRI` VARCHAR(255) CHARACTER SET UTF8 DEFAULT NULL,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
          `SIS_VALCFG` VARCHAR(255) CHARACTER SET UTF8 DEFAULT NULL,
          `SIS_REQUIS` VARCHAR(20) CHARACTER SET UTF8 DEFAULT NULL,
          `SIS_COMENT` VARCHAR(500) CHARACTER SET UTF8 DEFAULT NULL,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
          PRIMARY KEY (`SIS_CODEMP`,`SIS_CODCFG`),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
          KEY `IDX_CFG_PASTACOMPRA_01` (`SIS_VALCFG`),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
          CONSTRAINT `FK_CFG_PASTACOMPRA_01` FOREIGN KEY (`SIS_CODEMP`) REFERENCES `CADEMP` (`EMP_CODEMP`)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
        ) ENGINE=INNODB DEFAULT CHARSET=LATIN1;
        
DELIMITER $$
/*
# FUNÇÃO PARA RETORNO DOS VALORES DA TABELA DE CONFIGURAÇÃO
*/
USE `autcom`$$

DROP FUNCTION IF EXISTS `fCfgPastaCompra`$$

CREATE DEFINER=`dbacitel`@`localhost` FUNCTION `fCfgPastaCompra`(strCodCfg VARCHAR(10), strCodEmp VARCHAR(3)) RETURNS TEXT CHARSET latin1
    DETERMINISTIC
BEGIN
  IF LEFT(strCodCfg, 4) = 'CFG_' THEN
     RETURN (SELECT SIS_VALCFG FROM CFG_PASTACOMPRA WHERE SIS_CODCFG = strCodCfg AND SIS_CODEMP = strCodEmp);
  ELSE  
     RETURN (SELECT SIS_VALCFG FROM CFG_PASTACOMPRA WHERE SIS_CODCFG = CONCAT('CFG_', strCodCfg) AND SIS_CODEMP = strCodEmp);
  END IF;
END$$

DELIMITER ;



CREATE TABLE `EMPPAR` (
  `AUTOINCREM` char(20) NOT NULL,
  `PAR_CODEMP` char(3) NOT NULL,
  `PAR_DIAGER` char(1) DEFAULT 'G',
  `PAR_DIAGIR` int(11) DEFAULT NULL,
  `PAR_DIAMAA` int(11) DEFAULT NULL,
  `PAR_DIAMAB` int(11) DEFAULT NULL,
  `PAR_DIAMAC` int(11) DEFAULT NULL,
  `PAR_DIAMAG` int(11) DEFAULT NULL,
  `PAR_DIAMIN` int(11) DEFAULT NULL,
  `PAR_EMPHUB` char(3) DEFAULT NULL,
  `PAR_FATMAX` decimal(12,4) DEFAULT NULL,
  `PAR_MESGIR` int(11) DEFAULT NULL,
  `PAR_PONGER` int(11) DEFAULT NULL,
  `PAR_PONNIA` int(11) DEFAULT NULL,
  `PAR_PONNIB` int(11) DEFAULT NULL,
  `PAR_PONNIC` int(11) DEFAULT NULL,
  `PAR_PONPED` char(1) DEFAULT 'G',
  `PAR_SUGGAR` char(1) DEFAULT NULL,
  `PAR_TIPEMP` int(2) DEFAULT NULL,
  `PAR_USAMES` char(1) DEFAULT 'S',
  `PAR_DESMAI` char(1) DEFAULT 'N',
  PRIMARY KEY (`AUTOINCREM`),
  UNIQUE KEY `IDX_EMPPAR_01` (`PAR_CODEMP`),
  KEY `FK_EMPPAR_03` (`PAR_EMPHUB`),
  CONSTRAINT `FK_EMPPAR_02` FOREIGN KEY (`PAR_CODEMP`) REFERENCES `CADEMP` (`EMP_CODEMP`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EMPPAR_03` FOREIGN KEY (`PAR_EMPHUB`) REFERENCES `CADEMP` (`EMP_CODEMP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


SET @CODEMP = ( SELECT PRO_CODEMP FROM PROCOD LIMIT 1 ); 

INSERT INTO PROINC (AUTOINCREM, PRO_AUTINC, PRO_NOMARQ) VALUES('00100000000000001001','1','EMPPAR');
INSERT INTO PROCOD (PRO_NOMARQ, PRO_CODSEQ, PRO_TAMCOD, PRO_CODAUT, AUTOINCREM, PRO_CODEMP) VALUES('EMPPAR','000001','6','N',fRetAutoIncrem('PROCOD', @CODEMP),@CODEMP);

INSERT INTO EMPPAR (
  AUTOINCREM,
  PAR_CODEMP,
  PAR_DIAGER,
  PAR_DIAGIR,
  PAR_DIAMAA,
  PAR_DIAMAB,
  PAR_DIAMAC,
  PAR_DIAMAG,
  PAR_DIAMIN,
  PAR_EMPHUB,
  PAR_FATMAX,
  PAR_MESGIR,
  PAR_PONGER,
  PAR_PONNIA,
  PAR_PONNIB,
  PAR_PONNIC,
  PAR_PONPED,
  PAR_SUGGAR,
  PAR_TIPEMP,
  PAR_USAMES,
  PAR_DESMAI
)

  (
  SELECT
    fRetAutoIncrem('EMPPAR', @CODEMP),
    EMP_CODEMP,
    'G',
    NULL,
    '42',
    '40',
    '38',
    '45',
    '35',
    NULL,
    '2.5000',
    '6',
    '45',
    '26',
    '24',
    '22',
    'N',
    'N',
    '1',
    'S',
    'S'
    FROM CADEMP
  );


SELECT * FROM EMPPAR;
#---------------------------------------------------------------------------------------------------------------

CREATE TABLE `EMPPRA` (
  `AUTOINCREM` char(20) NOT NULL,
  `PRA_CODEMP` char(3) NOT NULL,
  `PRA_CODFOR` varchar(8) NOT NULL,
  `PRA_DIAENT` int(11) DEFAULT NULL,
  `PRA_VALMIN` decimal(12,2) DEFAULT NULL,
  `PRA_DIACOM` int(11) DEFAULT '0',
  PRIMARY KEY (`AUTOINCREM`),
  UNIQUE KEY `IDX_EMPPRA_02` (`PRA_CODFOR`,`PRA_CODEMP`),
  KEY `FK_EMPPRA_02` (`PRA_CODEMP`),
  CONSTRAINT `FK_EMPPRA_02` FOREIGN KEY (`PRA_CODEMP`) REFERENCES `CADEMP` (`EMP_CODEMP`),
  CONSTRAINT `FK_EMPPRA_03` FOREIGN KEY (`PRA_CODFOR`) REFERENCES `CADFOR` (`FOR_CODFOR`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
#---------------------------------------------------------------------------------------------------------------
ALTER TABLE EMPPRA ADD PRA_DIACOM INT DEFAULT 0;
ALTER TABLE DEL_EMPPRA ADD PRA_DIACOM INT DEFAULT 0;
ALTER TABLE EMPPRA ADD PRA_MINQTD DECIMAL(12,4) DEFAULT NULL;
ALTER TABLE EMPPRA ADD PRA_MINMET DECIMAL(12,4) DEFAULT NULL;
ALTER TABLE EMPPRA ADD PRA_MINLIT DECIMAL(12,4) DEFAULT NULL;
ALTER TABLE EMPPRA ADD PRA_MINPES DECIMAL(12,4) DEFAULT NULL;
ALTER TABLE DEL_EMPPRA ADD PRA_MINQTD DECIMAL(12,4) DEFAULT NULL;
ALTER TABLE DEL_EMPPRA ADD PRA_MINMET DECIMAL(12,4) DEFAULT NULL;
ALTER TABLE DEL_EMPPRA ADD PRA_MINLIT DECIMAL(12,4) DEFAULT NULL;
ALTER TABLE DEL_EMPPRA ADD PRA_MINPES DECIMAL(12,4) DEFAULT NULL;
#---------------------------------------------------------------------------------------------------------------

SET @AUT=0;
INSERT INTO EMPPRA    (AUTOINCREM, PRA_CODEMP, PRA_CODFOR, PRA_DIAENT, PRA_VALMIN, PRA_DIACOM)  
SELECT CONCAT('999',RIGHT(CONCAT('00000000000000000000',@AUT:=@AUT+1,'001'),17)) AUTOINCREM,
       EMP_CODEMP PRA_CODEMP,
       FOR_CODFOR PRA_CODFOR,
       0 PRA_DIAENT,
       0.00 PRA_VALMIN,
       0 PRA_DIACOM
FROM CADFOR CROSS JOIN CADEMP
             LEFT JOIN EMPPRA ON PRA_CODEMP = EMP_CODEMP
                             AND PRA_CODFOR = FOR_CODFOR
WHERE PRA_CODFOR IS NULL;


#---------------------------------------------------------------------------------------------------------------
CREATE TABLE `PRE_CODSIM_ORCAMENTO` (
  `PRE_CODSIM` VARCHAR(6) DEFAULT NULL,
  KEY `IDX_CODSIM_ORCAMENTO_01` (`PRE_CODSIM`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
#---------------------------------------------------------------------------------------------------------------
CREATE TABLE `GIRO_SAIDA_DIAS` (
  `GIR_CODITE` char(7) DEFAULT NULL,
  `GIR_CODEMP` char(3) DEFAULT NULL,
  `GIR_DIAGIR` int(11) DEFAULT NULL,
  `GIR_QTDSAI` decimal(14,4) DEFAULT NULL,
  KEY `GIRO_SAIDA_DIAS_INDICE` (`GIR_CODITE`,`GIR_CODEMP`,`GIR_DIAGIR`)
) ENGINE=MEMORY DEFAULT CHARSET=latin1;
#---------------------------------------------------------------------------------------------------------------
CREATE TABLE `PRE_SIMILARES` (
  `PRE_CODITE` VARCHAR(5) NOT NULL DEFAULT '',
  `PRE_CODEMP` CHAR(3) NOT NULL DEFAULT '',
  `PRE_SIGEMP` VARCHAR(5) DEFAULT NULL,
  `PRE_CODSIM` VARCHAR(6) DEFAULT NULL,
  `PRE_CODFOR` VARCHAR(8) DEFAULT NULL,
  `PRE_VMES00` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES01` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES02` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES03` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES04` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES05` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES06` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES07` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES08` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES09` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES10` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES11` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES12` DECIMAL(14,2) DEFAULT NULL,
  `PRE_TIPEMP` INT(11) DEFAULT NULL,
  `PRE_COMPRA` CHAR(3) DEFAULT NULL,
  `PRE_DESTIP` VARCHAR(8) CHARACTER SET utf8 DEFAULT NULL,
  `PRE_EMPHUB` VARCHAR(3) DEFAULT NULL,
  `PRE_DESBAN` VARCHAR(70) DEFAULT NULL,
  `PRE_CODBAN` CHAR(3),
  `PRE_VALMIN` DECIMAL(12,2) DEFAULT NULL,
  `PRE_MLTVEN` DECIMAL(12,4) DEFAULT NULL,
  `PRE_MLTCOM` DECIMAL(12,4) DEFAULT NULL,
  `PRE_DIAENT` BIGINT(11) NOT NULL DEFAULT '0',
  `PRE_ESTMIN` DECIMAL(14,3) DEFAULT NULL,
  `PRE_ESTMAX` DECIMAL(14,3) DEFAULT NULL,
  `PRE_NIVGIR` CHAR(1) DEFAULT NULL,
  `PRE_DIAABA` INT(11) NOT NULL DEFAULT '0',
  `PRE_PONPED` CHAR(1) DEFAULT 'G',
  `PRE_PONGER` INT(11) NOT NULL DEFAULT '0',
  `PRE_DIAMAX` BIGINT(21) DEFAULT NULL,
  `PRE_MEDMEN` DECIMAL(14,2) DEFAULT NULL,
  `PRE_MEDDIA` DECIMAL(18,8) NOT NULL DEFAULT '0.00000000',
  `PRE_VENDIA` DECIMAL(20,10) DEFAULT NULL,
  `PRE_MEDMES` DECIMAL(20,10) DEFAULT NULL,
  `PRE_USAMES` CHAR(1) DEFAULT 'S',
  `PRE_MESGIR` INT(11) DEFAULT NULL,
  `PRE_DIAGIR` INT(11) DEFAULT NULL,
  `PRE_MAXCAL` DOUBLE(21,4) DEFAULT NULL,
  `PRE_DIAPON` BIGINT(21) DEFAULT NULL,
  `PRE_QESTPP` DOUBLE(21,4) DEFAULT NULL,
  `PRE_ESTDIS` DECIMAL(19,3) DEFAULT NULL,
  `PRE_PEDCOM` DECIMAL(55,12) NOT NULL DEFAULT '0.000000000000',
  `PRE_VALCOM` DECIMAL(65,14) NOT NULL DEFAULT '0.00000000000000',
  `PRE_QTDCOM` BIGINT(21) NOT NULL DEFAULT '0',
  `PRE_ANTIGO` DATE DEFAULT NULL,
  `PRE_ESTTOT` DECIMAL(65,30) DEFAULT NULL,
  `DIAS_ESTOQUE` DECIMAL(65,30) DEFAULT NULL,
  `DIAS_ESTOQUE_PENDENCIA` DOUBLE DEFAULT NULL,
  `PRE_MEDME3` DECIMAL(14,2) DEFAULT NULL,
  `POSICAO` INT(1) NOT NULL DEFAULT '0',
  `RUPTURA` INT(1) NOT NULL DEFAULT '0',
  `PRE_ESTDES` DOUBLE DEFAULT NULL,
  `PRE_NECCOM` DOUBLE(19,2) DEFAULT NULL,
  `PRE_NECAJU` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_NECPRI` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_QTDITE` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_COMPEN` INT(1) NOT NULL DEFAULT '0',
  `DESUNI` DECIMAL(65,30) DEFAULT NULL,
  `PRE_PERDES` DECIMAL(6,2) NOT NULL DEFAULT '0.00',
  `PRE_UNILIQ` DECIMAL(11,2) DEFAULT NULL,
  `PRE_VALUNI` DECIMAL(12,4) DEFAULT NULL,
  `PRE_IPIENT` DECIMAL(12,2) NOT NULL DEFAULT '0.00',
  `PRE_TOTITE` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_TOTIPI` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_PERSUB` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_BASSUB` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_TOTSUB` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_BASICM` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_ALQICM` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_VALICM` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_VALTOT` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_VALNET` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_TIPFOR` VARCHAR(3) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `PRE_ABF_CODSIT` VARCHAR(3) DEFAULT NULL,
  `PRE_ABF_BASICM` DECIMAL(12,2) DEFAULT NULL,
  `PRE_ABF_BASRET` DECIMAL(12,3) DEFAULT NULL,
  `PRE_ABF_IVA_ST` DECIMAL(12,4) DEFAULT NULL,
  `PRE_ABF_ALQRET` DECIMAL(12,2) DEFAULT NULL,
  `PRE_ABF_ALQICM` DECIMAL(12,2) DEFAULT NULL,
  KEY `IDX_PRE_SIMILARES_01` (`PRE_CODSIM`,`PRE_CODFOR`,`PRE_CODEMP`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
#---------------------------------------------------------------------------------------------------------------
CREATE TABLE `PRE_ORCAMENTO` (
  `PRE_CODITE` VARCHAR(5) NOT NULL DEFAULT '',
  `PRE_CODEMP` CHAR(3) NOT NULL DEFAULT '',
  `PRE_SIGEMP` VARCHAR(5) DEFAULT NULL,
  `PRE_CODSIM` VARCHAR(6) DEFAULT NULL,
  `PRE_CODFOR` VARCHAR(8) DEFAULT NULL,
  `PRE_VMES00` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES01` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES02` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES03` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES04` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES05` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES06` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES07` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES08` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES09` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES10` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES11` DECIMAL(14,2) DEFAULT NULL,
  `PRE_VMES12` DECIMAL(14,2) DEFAULT NULL,
  `PRE_TIPEMP` INT(11) DEFAULT NULL,
  `PRE_COMPRA` CHAR(3) DEFAULT NULL,
  `PRE_DESTIP` VARCHAR(8) CHARACTER SET utf8 DEFAULT NULL,
  `PRE_EMPHUB` VARCHAR(3) DEFAULT NULL,
  `PRE_DESBAN` VARCHAR(70) DEFAULT NULL,
  `PRE_CODBAN` CHAR(3),
  `PRE_VALMIN` DECIMAL(12,2) DEFAULT NULL,
  `PRE_MLTVEN` DECIMAL(12,4) DEFAULT NULL,
  `PRE_MLTCOM` DECIMAL(12,4) DEFAULT NULL,
  `PRE_DIAENT` INT(11) DEFAULT NULL,
  `PRE_ESTMIN` DECIMAL(14,3) DEFAULT NULL,
  `PRE_ESTMAX` DECIMAL(14,3) DEFAULT NULL,
  `PRE_NIVGIR` CHAR(1) DEFAULT NULL,
  `PRE_DIAABA` INT(11) DEFAULT NULL,
  `PRE_PONPED` CHAR(1) DEFAULT 'G',
  `PRE_PONGER` INT(11) DEFAULT NULL,
  `PRE_DIAMAX` DOUBLE DEFAULT NULL,
  `PRE_MEDMEN` DECIMAL(14,2) DEFAULT NULL,
  `PRE_MEDDIA` DECIMAL(18,8) NOT NULL DEFAULT '0.00000000',
  `PRE_VENDIA` DECIMAL(20,10) DEFAULT NULL,
  `PRE_MEDMES` DECIMAL(20,10) DEFAULT NULL,
  `PRE_USAMES` CHAR(1) DEFAULT 'S',
  `PRE_MESGIR` INT(11) DEFAULT NULL,
  `PRE_DIAGIR` INT(11) DEFAULT NULL,
  `PRE_MAXCAL` DOUBLE(21,4) DEFAULT NULL,
  `PRE_DIAPON` DOUBLE DEFAULT NULL,
  `PRE_QESTPP` DOUBLE(21,4) DEFAULT NULL,
  `PRE_ESTDIS` DECIMAL(20,4) DEFAULT NULL,
  `PRE_PEDCOM` DECIMAL(55,12) NOT NULL DEFAULT '0.000000000000',
  `PRE_VALCOM` DECIMAL(65,14) NOT NULL DEFAULT '0.00000000000000',
  `PRE_QTDCOM` BIGINT(21) NOT NULL DEFAULT '0',
  `PRE_ANTIGO` DATE DEFAULT NULL,
  `PRE_ESTTOT` DOUBLE DEFAULT NULL,
  `DIAS_ESTOQUE` DOUBLE DEFAULT NULL,
  `DIAS_ESTOQUE_PENDENCIA` DOUBLE DEFAULT NULL,
  `PRE_MEDME3` DECIMAL(14,2) DEFAULT NULL,
  `POSICAO` INT(1) NOT NULL DEFAULT '0',
  `RUPTURA` INT(1) NOT NULL DEFAULT '0',
  `PRE_ESTDES` LONGTEXT CHARACTER SET utf8,
  `PRE_NECCOM` DOUBLE(19,2) DEFAULT NULL,
  `PRE_NECAJU` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_NECPRI` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_QTDITE` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_COMPEN` INT(1) NOT NULL DEFAULT '0',
  `DESUNI` DECIMAL(65,30) DEFAULT NULL,
  `PRE_PERDES` DECIMAL(6,2) NOT NULL DEFAULT '0.00',
  `PRE_UNILIQ` DECIMAL(11,2) DEFAULT NULL,
  `PRE_VALUNI` DECIMAL(12,4) DEFAULT NULL,
  `PRE_IPIENT` DECIMAL(12,2) NOT NULL DEFAULT '0.00',
  `PRE_TOTITE` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_TOTIPI` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_PERSUB` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_BASSUB` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_TOTSUB` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_BASICM` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_ALQICM` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_VALICM` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_VALTOT` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_VALNET` DECIMAL(14,2) NOT NULL DEFAULT '0.00',
  `PRE_TIPFOR` VARCHAR(3) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `PRE_ABF_CODSIT` VARCHAR(3) DEFAULT NULL,
  `PRE_ABF_BASICM` DECIMAL(12,2) DEFAULT NULL,
  `PRE_ABF_BASRET` DECIMAL(12,3) DEFAULT NULL,
  `PRE_ABF_IVA_ST` DECIMAL(12,4) DEFAULT NULL,
  `PRE_ABF_ALQRET` DECIMAL(12,2) DEFAULT NULL,
  `PRE_ABF_ALQICM` DECIMAL(12,2) DEFAULT NULL,
  `PRE_PERFCP` DECIMAL(12,2) DEFAULT NULL,
  `PRE_SUBFCP` INT(1) NOT NULL DEFAULT '0',
  `VALIDOS` INT(1) DEFAULT NULL,
  KEY `IDX_PRE_ORCAMENTO_07` (`VALIDOS`),
  KEY `IDX_PRE_ORCAMENTO_01` (`PRE_CODFOR`,`PRE_CODEMP`,`PRE_CODITE`),
  KEY `IDX_PRE_ORCAMENTO_02` (`PRE_CODEMP`,`PRE_CODITE`,`PRE_CODFOR`),
  KEY `IDX_PRE_ORCAMENTO_03` (`PRE_TIPEMP`,`PRE_EMPHUB`,`PRE_CODFOR`),
  KEY `IDX_PRE_ORCAMENTO_04` (`PRE_CODFOR`,`PRE_MESGIR`),
  KEY `IDX_PRE_ORCAMENTO_05` (`PRE_COMPRA`,`PRE_CODFOR`,`PRE_CODEMP`),
  KEY `IDX_PRE_ORCAMENTO_06` (`PRE_EMPHUB`,`PRE_CODITE`,`PRE_CODFOR`,`PRE_TIPEMP`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
#---------------------------------------------------------------------------------------------------------------
SET GLOBAL log_bin_trust_function_creators = 1;
#---------------------------------------------------------------------------------------------------------------
DELIMITER $$

#DROP FUNCTION IF EXISTS `fRetFornecedorCNVCUS`$$

CREATE DEFINER=`dbacitel`@`localhost` FUNCTION `fRetFornecedorCNVCUS`(strCodFor CHAR(8), strCodIte CHAR(8) ) RETURNS DOUBLE
    DETERMINISTIC
BEGIN
      
  RETURN (SELECT 
      IF(IFNULL(FX.ITE_CNVCUS, 0) = 0, 1, FX.ITE_CNVCUS) AS ITE_CNVCUS
      
    FROM ITEFOR FX

    INNER JOIN TABPRE ON TAB_CODTAB = FX.ITE_CODTAB AND TAB_ATICMP = "S"

    WHERE
      FX.ITE_CODFOR = strCodFor AND     
      FX.ITE_CODITE = strCodIte AND     
      (IFNULL(FX.ITE_CNVCUS, 0) <> 0) AND IFNULL(FX.ITE_UNICOM, "") <> "");
  
END$$

DELIMITER ;

DELIMITER $$
#---------------------------------------------------------------------------------------------------------------
#DROP FUNCTION IF EXISTS `fRetFornecedorUNICOM`$$

CREATE DEFINER=`dbacitel`@`localhost` FUNCTION `fRetFornecedorUNICOM`(strCodFor CHAR(8), strCodIte CHAR(8) ) RETURNS DOUBLE
    DETERMINISTIC
BEGIN
      
  RETURN (SELECT 
      IFNULL(FX.ITE_UNICOM, "") AS ITE_UNICOM
      
    FROM ITEFOR FX

    INNER JOIN TABPRE ON TAB_CODTAB = FX.ITE_CODTAB AND TAB_ATICMP = "S"

    WHERE
      FX.ITE_CODFOR = strCodFor AND     
      FX.ITE_CODITE = strCodIte AND     
      (IFNULL(FX.ITE_CNVCUS, 0) <> 0) AND IFNULL(FX.ITE_UNICOM, "") <> "");
  
END$$

DELIMITER ;
#---------------------------------------------------------------------------------------------------------------
DELIMITER $$

#DROP FUNCTION IF EXISTS `fRetEmbalagemFornecedor`$$

CREATE DEFINER=`dbacitel`@`localhost` FUNCTION `fRetEmbalagemFornecedor`(strCodFor CHAR(8), strCodIte CHAR(8) ) RETURNS DOUBLE
    DETERMINISTIC
BEGIN
      
  RETURN (SELECT BAR_EMBALA
  FROM ITEBAR
 WHERE BAR_CODITE = strCodIte
   AND BAR_CODFOR = strCodFor
 ORDER BY BAR_COMPRA DESC
 LIMIT 1);

END$$

DELIMITER ;

#---------------------------------------------------------------------------------------------------------------
DELIMITER $$

# DROP FUNCTION IF EXISTS `fRetEmpresasUsamPrecoMatriz`$$

CREATE DEFINER=`dbacitel`@`localhost` FUNCTION `fRetEmpresasUsamPrecoMatriz`(strCodEmp CHAR(3)) RETURNS TEXT CHARSET latin1
BEGIN
      DECLARE strEmpresas TEXT;
      DECLARE blnSomenteMatriz INT;
       
      SET blnSomenteMatriz := (fCfgSis('REPPRC', strCodEmp) = '1');
      SET strEmpresas = CONCAT(strCodEmp, '_');
    
      IF ((fCfgSis('EMPGER', strCodEmp) = 'S') AND blnSomenteMatriz) OR (NOT blnSomenteMatriz) THEN
       
         SET strEmpresas  = CONCAT(strEmpresas, IFNULL((SELECT GROUP_CONCAT(EMP_CODEMP SEPARATOR "_") 
                                                        FROM CADEMP 
                                                        WHERE 
                                                             EMP_CODEMP <> strCodEmp 
                                                          AND EMP_PREMAT = "S"
                                                          
                                                         AND IF(fCfgSis('INFMAT', strCodEmp) = 'S', EMP_CODMAT = strCodEmp, TRUE)), "")); 
      END IF;
       
      RETURN strEmpresas;
    END$$

DELIMITER ;
#---------------------------------------------------------------------------------------------------------------
DELIMITER $$

# DROP PROCEDURE IF EXISTS `pInicializaMesesGiro`$$

CREATE DEFINER=`dbacitel`@`localhost` PROCEDURE `pInicializaMesesGiro`()
BEGIN
-- SET @DATA_ATUAL = DATE_ADD(CURRENT_DATE, INTERVAL 1 DAY);
SET @DATA_ATUAL = CURRENT_DATE;
SET @DATA01 = DATE_SUB(@DATA_ATUAL, INTERVAL 1 MONTH);
SET @DATA02 = DATE_SUB(@DATA01, INTERVAL 1 MONTH);
SET @DATA03 = DATE_SUB(@DATA02, INTERVAL 1 MONTH);
SET @DATA04 = DATE_SUB(@DATA03, INTERVAL 1 MONTH);
SET @DATA05 = DATE_SUB(@DATA04, INTERVAL 1 MONTH);
SET @DATA06 = DATE_SUB(@DATA05, INTERVAL 1 MONTH);
SET @DATA07 = DATE_SUB(@DATA06, INTERVAL 1 MONTH);
SET @DATA08 = DATE_SUB(@DATA07, INTERVAL 1 MONTH);
SET @DATA09 = DATE_SUB(@DATA08, INTERVAL 1 MONTH);
SET @DATA10 = DATE_SUB(@DATA09, INTERVAL 1 MONTH);
SET @DATA11 = DATE_SUB(@DATA10, INTERVAL 1 MONTH);
SET @DATA12 = DATE_SUB(@DATA11, INTERVAL 1 MONTH);
SET @MES00 = MONTH(@DATA_ATUAL);
SET @MES01 = MONTH(@DATA01);
SET @MES02 = MONTH(@DATA02);
SET @MES03 = MONTH(@DATA03);
SET @MES04 = MONTH(@DATA04);
SET @MES05 = MONTH(@DATA05);
SET @MES06 = MONTH(@DATA06);
SET @MES07 = MONTH(@DATA07);
SET @MES08 = MONTH(@DATA08);
SET @MES09 = MONTH(@DATA09);
SET @MES10 = MONTH(@DATA10);
SET @MES11 = MONTH(@DATA11);
SET @MES12 = MONTH(@DATA12);
SET @ANO00 = CAST(YEAR(@DATA_ATUAL) AS CHAR(4));
SET @ANO01 = CAST(YEAR(@DATA01) AS CHAR(4));
SET @ANO02 = CAST(YEAR(@DATA02) AS CHAR(4));
SET @ANO03 = CAST(YEAR(@DATA03) AS CHAR(4));
SET @ANO04 = CAST(YEAR(@DATA04) AS CHAR(4));
SET @ANO05 = CAST(YEAR(@DATA05) AS CHAR(4));
SET @ANO06 = CAST(YEAR(@DATA06) AS CHAR(4));
SET @ANO07 = CAST(YEAR(@DATA07) AS CHAR(4));
SET @ANO08 = CAST(YEAR(@DATA08) AS CHAR(4));
SET @ANO09 = CAST(YEAR(@DATA09) AS CHAR(4));
SET @ANO10 = CAST(YEAR(@DATA10) AS CHAR(4));
SET @ANO11 = CAST(YEAR(@DATA11) AS CHAR(4));
SET @ANO12 = CAST(YEAR(@DATA12) AS CHAR(4));
    END$$

DELIMITER ;
#---------------------------------------------------------------------------------------------------------------
DELIMITER $$

# DROP FUNCTION IF EXISTS `fGiroSaida`$$

CREATE DEFINER=`dbacitel`@`localhost` FUNCTION `fGiroSaida`(strCodIte VARCHAR(10), strCodEmp CHAR(3), strAno CHAR(4), intMes INT) RETURNS DECIMAL(14,2)
BEGIN
      RETURN IFNULL((SELECT CASE intMes 
                       WHEN 01 THEN GIR_QSAI01
                       WHEN 02 THEN GIR_QSAI02
                       WHEN 03 THEN GIR_QSAI03
                       WHEN 04 THEN GIR_QSAI04
                       WHEN 05 THEN GIR_QSAI05
                       WHEN 06 THEN GIR_QSAI06
                       WHEN 07 THEN GIR_QSAI07
                       WHEN 08 THEN GIR_QSAI08
                       WHEN 09 THEN GIR_QSAI09
                       WHEN 10 THEN GIR_QSAI10
                       WHEN 11 THEN GIR_QSAI11
                       WHEN 12 THEN GIR_QSAI12
                     END  
              FROM GIRITE WHERE GIR_CODEMP = strCodEmp AND GIR_CODITE = strCodIte AND GIR_A_N_O_ = strAno), 0.00);
    END$$

DELIMITER ;
#---------------------------------------------------------------------------------------------------------------
DELIMITER $$

# DROP FUNCTION IF EXISTS `fcalculaSubstituicaoCompra`$$

CREATE DEFINER=`dbacitel`@`localhost` FUNCTION `fcalculaSubstituicaoCompra`(fltTotIte FLOAT, fltValIpi FLOAT, ABF_BASRET FLOAT, ABF_IVA_ST FLOAT, ABF_ALQRET FLOAT, ABF_BASICM FLOAT, ABF_ALQICM FLOAT, ABF_CODSIT CHAR(3)) RETURNS FLOAT
BEGIN
      DECLARE Result FLOAT;
      DECLARE fltBaseST FLOAT;
      DECLARE fltPartePositiva FLOAT;
      DECLARE fltBasIcm FLOAT; 
      DECLARE fltValIcm FLOAT;     
      DECLARE fltParteNegativa FLOAT;
     
      SET @BASSUB = 0;   
      SET @BASICM = 0;
      SET @ALQICM = 0;
      SET @VALICM = 0;       
      
      SET fltValIpi  = IFNULL(fltValIpi,  0);
      SET ABF_BASRET = IFNULL(ABF_BASRET, 0);
      SET ABF_IVA_ST = IFNULL(ABF_IVA_ST, 0);
      SET ABF_ALQRET = IFNULL(ABF_ALQRET, 0);
      SET ABF_BASICM = IFNULL(ABF_BASICM, 0);
      SET ABF_ALQICM = IFNULL(ABF_ALQICM, 0);
      SET ABF_CODSIT = IFNULL(ABF_CODSIT, 0);      
        
      IF LOCATE(ABF_CODSIT, @CST_SUBSTITUICAO) THEN
        SET fltBaseST := fltTotIte;
        
        IF (@FRMPCM = '1') THEN
          SET fltBaseST = fltBaseST + fltValIpi;
        END IF;  
        SET fltBaseST = ROUND(fltBaseST * ABF_BASRET / 100, 2);
        SET fltBaseST = ROUND(fltBaseST * ABF_IVA_ST, 2);
        SET fltPartePositiva = ROUND(fltBaseST * ABF_ALQRET / 100, 2);
        SET fltBasIcm = ROUND(fltTotIte * ABF_BASICM / 100, 2);
        
        SET fltValIcm = ROUND(fltBasIcm * ABF_ALQICM / 100, 2);
        
        SET fltParteNegativa = fltValIcm;
        SET Result = fltPartePositiva - fltParteNegativa;
        
        IF Result <= 0 THEN
          SET Result = 0;
          
        ELSE 
          SET @BASSUB = fltBaseST;   
          SET @BASICM = fltBasIcm;
          SET @ALQICM = ABF_ALQICM;
          SET @VALICM = fltValIcm;       
        END IF;
      
    ELSE
      SET Result = 0;
    END IF;  
    
    RETURN Result;
END$$

DELIMITER ;
#---------------------------------------------------------------------------------------------------------------
DELIMITER $$

# DROP FUNCTION IF EXISTS `fMediaGiroSaida`$$

CREATE DEFINER=`dbacitel`@`localhost` FUNCTION `fMediaGiroSaida`(strCodIte VARCHAR(10), strCodEmp CHAR(3), intMesGiro INT, strDesMai CHAR) RETURNS DECIMAL(14,2)
BEGIN
  IF (strDesMai = 'S') AND (intMesGiro > 3) THEN

      RETURN IFNULL(CASE intMesGiro
                  
                    WHEN 06 THEN (fGiroSaida(strCodIte, strCodEmp, @ANO01, @MES01) + fGiroSaida(strCodIte, strCodEmp, @ANO02, @MES02) + fGiroSaida(strCodIte, strCodEmp, @ANO03, @MES03) +
                                  fGiroSaida(strCodIte, strCodEmp, @ANO04, @MES04) + fGiroSaida(strCodIte, strCodEmp, @ANO05, @MES05) + fGiroSaida(strCodIte, strCodEmp, @ANO06, @MES06)
                                  - GREATEST(fGiroSaida(strCodIte, strCodEmp, @ANO01, @MES01), fGiroSaida(strCodIte, strCodEmp, @ANO02, @MES02), fGiroSaida(strCodIte, strCodEmp, @ANO03, @MES03),
                                             fGiroSaida(strCodIte, strCodEmp, @ANO04, @MES04), fGiroSaida(strCodIte, strCodEmp, @ANO05, @MES05), fGiroSaida(strCodIte, strCodEmp, @ANO06, @MES06))
                                  - LEAST(fGiroSaida(strCodIte, strCodEmp, @ANO01, @MES01), fGiroSaida(strCodIte, strCodEmp, @ANO02, @MES02), fGiroSaida(strCodIte, strCodEmp, @ANO03, @MES03),
                                             fGiroSaida(strCodIte, strCodEmp, @ANO04, @MES04), fGiroSaida(strCodIte, strCodEmp, @ANO05, @MES05), fGiroSaida(strCodIte, strCodEmp, @ANO06, @MES06))                                             
                                  
                                  )  / 4
                    WHEN 12 THEN (fGiroSaida(strCodIte, strCodEmp, @ANO01, @MES01) + fGiroSaida(strCodIte, strCodEmp, @ANO02, @MES02) + fGiroSaida(strCodIte, strCodEmp, @ANO03, @MES03) +
                                  fGiroSaida(strCodIte, strCodEmp, @ANO04, @MES04) + fGiroSaida(strCodIte, strCodEmp, @ANO05, @MES05) + fGiroSaida(strCodIte, strCodEmp, @ANO06, @MES06) +
                                  fGiroSaida(strCodIte, strCodEmp, @ANO07, @MES07) + fGiroSaida(strCodIte, strCodEmp, @ANO08, @MES08) + fGiroSaida(strCodIte, strCodEmp, @ANO09, @MES09) +
                                  fGiroSaida(strCodIte, strCodEmp, @ANO10, @MES10) + fGiroSaida(strCodIte, strCodEmp, @ANO11, @MES11) + fGiroSaida(strCodIte, strCodEmp, @ANO12, @MES12)
                                  
                                  - GREATEST(fGiroSaida(strCodIte, strCodEmp, @ANO01, @MES01), fGiroSaida(strCodIte, strCodEmp, @ANO02, @MES02), fGiroSaida(strCodIte, strCodEmp, @ANO03, @MES03) +
                                             fGiroSaida(strCodIte, strCodEmp, @ANO04, @MES04), fGiroSaida(strCodIte, strCodEmp, @ANO05, @MES05), fGiroSaida(strCodIte, strCodEmp, @ANO06, @MES06) +
                                             fGiroSaida(strCodIte, strCodEmp, @ANO07, @MES07), fGiroSaida(strCodIte, strCodEmp, @ANO08, @MES08), fGiroSaida(strCodIte, strCodEmp, @ANO09, @MES09) +
                                             fGiroSaida(strCodIte, strCodEmp, @ANO10, @MES10), fGiroSaida(strCodIte, strCodEmp, @ANO11, @MES11), fGiroSaida(strCodIte, strCodEmp, @ANO12, @MES12))

                                  - LEAST(fGiroSaida(strCodIte, strCodEmp, @ANO01, @MES01), fGiroSaida(strCodIte, strCodEmp, @ANO02, @MES02), fGiroSaida(strCodIte, strCodEmp, @ANO03, @MES03) +
                                          fGiroSaida(strCodIte, strCodEmp, @ANO04, @MES04), fGiroSaida(strCodIte, strCodEmp, @ANO05, @MES05), fGiroSaida(strCodIte, strCodEmp, @ANO06, @MES06) +
                                          fGiroSaida(strCodIte, strCodEmp, @ANO07, @MES07), fGiroSaida(strCodIte, strCodEmp, @ANO08, @MES08), fGiroSaida(strCodIte, strCodEmp, @ANO09, @MES09) +
                                          fGiroSaida(strCodIte, strCodEmp, @ANO10, @MES10), fGiroSaida(strCodIte, strCodEmp, @ANO11, @MES11), fGiroSaida(strCodIte, strCodEmp, @ANO12, @MES12))

                                  ) / 10
                    
                    END, 0);
  
  ELSE

      RETURN IFNULL(CASE intMesGiro
                    WHEN 03 THEN (fGiroSaida(strCodIte, strCodEmp, @ANO01, @MES01) + fGiroSaida(strCodIte, strCodEmp, @ANO02, @MES02) + fGiroSaida(strCodIte, strCodEmp, @ANO03, @MES03)) / 3
                    WHEN 06 THEN (fGiroSaida(strCodIte, strCodEmp, @ANO01, @MES01) + fGiroSaida(strCodIte, strCodEmp, @ANO02, @MES02) + fGiroSaida(strCodIte, strCodEmp, @ANO03, @MES03) +
                                  fGiroSaida(strCodIte, strCodEmp, @ANO04, @MES04) + fGiroSaida(strCodIte, strCodEmp, @ANO05, @MES05) + fGiroSaida(strCodIte, strCodEmp, @ANO06, @MES06)) / 6
                    WHEN 12 THEN (fGiroSaida(strCodIte, strCodEmp, @ANO01, @MES01) + fGiroSaida(strCodIte, strCodEmp, @ANO02, @MES02) + fGiroSaida(strCodIte, strCodEmp, @ANO03, @MES03) +
                                  fGiroSaida(strCodIte, strCodEmp, @ANO04, @MES04) + fGiroSaida(strCodIte, strCodEmp, @ANO05, @MES05) + fGiroSaida(strCodIte, strCodEmp, @ANO06, @MES06) +
                                  fGiroSaida(strCodIte, strCodEmp, @ANO07, @MES07) + fGiroSaida(strCodIte, strCodEmp, @ANO08, @MES08) + fGiroSaida(strCodIte, strCodEmp, @ANO09, @MES09) +
                                  fGiroSaida(strCodIte, strCodEmp, @ANO10, @MES10) + fGiroSaida(strCodIte, strCodEmp, @ANO11, @MES11) + fGiroSaida(strCodIte, strCodEmp, @ANO12, @MES12)) / 12
                    
                    END, 0); 
                    
       RETURN 0;                    
                    
  END IF;
                    
    END$$

DELIMITER ;
#---------------------------------------------------------------------------------------------------------------



/*
-- OS PROCEDIMENTOS ABAIXO DEVEM SER ADICIONADOS ÀS ROTINAS NOTURNAS E DEVEM SER EXECUTADOS APÓS AS 24:00 HORAS, E DEVEM SER EXECUTADOS NA SEQUENCIA ABAIXO:

CALL pRotinasNoturnasRecalculoGiroSaida;          -- ESSA ROTINA JÁ RODA NO CLIENTE, ACERTAR A ORDEM DAS ROTINAS

CALL pRotinasNoturnasRecalculoGiroSaidaDias;

CALL pCalculaEstoqueMaxMin;               -- ESSA ROTINA JÁ RODA NO CLIENTE, ACERTAR A ORDEM DAS ROTINAS

CALL pRotinasNoturnasGeraPreOrcamentoCompra;
*/


/*

	CALL pRotinasNoturnasRecalculoGiroSaida;          -- ESSA ROTINA JÁ RODA NO CLIENTE, ACERTAR A ORDEM DAS ROTINAS

	CALL pRotinasNoturnasRecalculoGiroSaidaDias;

	# INCLUIR ESTAS PROCEDURES DENTRO DA PROCEDURE DE SCRIPTDIVERSOS DAS ROTINAS NOTURNAS
	SET @LOCAL_PROC = 'pAtualizaSaldoPedidoCompra';
	CALL pAtualizaSaldoPedidoCompra;

    IF LOCATE('2',(SELECT GROUP_CONCAT(SIS_VALCFG) FROM CFGSIS WHERE SIS_CODCFG = 'CFG_TIPPAS'))  THEN
         SET @LOCAL_PROC = 'pRotinasNoturnasGeraPreOrcamentoCompraGlobal';
         CALL pRotinasNoturnasGeraPreOrcamentoCompraGlobal; 
     ELSE 
         SET @LOCAL_PROC = 'pRotinasNoturnasGeraPreOrcamentoCompra';
         CALL `pRotinasNoturnasGeraPreOrcamentoCompra`();   
     END IF;
        
       
*/

