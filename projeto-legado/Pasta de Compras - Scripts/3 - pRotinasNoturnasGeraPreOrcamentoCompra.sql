DELIMITER $$


DROP PROCEDURE IF EXISTS `pRotinasNoturnasGeraPreOrcamentoCompra`$$

CREATE DEFINER=`dbacitel`@`localhost` PROCEDURE `pRotinasNoturnasGeraPreOrcamentoCompra`()
BEGIN
#######################################################################################################################
# Procedure......: Procedure para geração de pré-orcamento                                                            #     
# Autor..........: Willian                                                                                            #     
# Data...........: 29/05/2019                                                                                         #     
# Versao.........: 6.0                                                                                                #     
# Alteração......: 2.0 Adicionado Criticidade e Nivel de Giro + Criticidade                                           #     
# Alteração......: 3.0 filtrar empresas PAR_TIPEMP <> 4                                                               #     
# Alteração......: 4.0 utilizar CADITE.ITE_DIAFOR se maior que zero no lugar de PRA_DIAENT - 07/10/2021               #
# Alteração......: 5.0 Adicionado o PRE_EMBALA                                                                        #
# Alteração......: 6.0 Adicionado o ITE_ATIPCP req 256968                                                            #
#######################################################################################################################
#=======================================================================================================================
# ETAPA 01 - CRIACAO DO ARQUIVO DE LOG
#=======================================================================================================================
SET @HORLOG = NOW();
INSERT INTO LOGNOT( LOG_DESCRI, LOG_VERSAO, LOG_HORINI ) VALUES( 'PRE_ORCAMENTO_COMPRA', '4.0', @HORLOG );
#=======================================================================================================================
CALL pCriaTemporariaParEmp;
CALL pInicializaMesesGiro;
SET @TIPABF = (SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = 'CFG_TIPABF' AND SIS_CODEMP = (SELECT PRO_CODEMP FROM PROCOD WHERE PRO_NOMARQ = 'MOVGER')); 
SET @FRMPCM = (SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = 'CFG_FRMPCM' AND SIS_CODEMP = (SELECT PRO_CODEMP FROM PROCOD WHERE PRO_NOMARQ = 'MOVGER')); 
SET @DIAPAS = (SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = 'CFG_DIAPAS' AND SIS_CODEMP = (SELECT PRO_CODEMP FROM PROCOD WHERE PRO_NOMARQ = 'MOVGER')); 
SET @CST_SUBSTITUICAO = '010_110_210_310_410_510_610_710_810_060_160_260_360_460_560_660_760_860_070_170_270_370_470_570_670_770_030_130_230_330_430_530_630_730_';
DROP TABLE IF EXISTS PRE_ORCAMENTO;
DELETE FROM GPREOR;
CREATE TABLE PRE_ORCAMENTO
SELECT 
  @EMBALA :=  IFNULL(fRetEmbalagemFornecedor(FOR_CODFOR, C.ITE_CODITE), C.ITE_EMBALA) AS PRE_EMBALA,  
  G.ITE_CODITE AS PRE_CODITE,
  G.ITE_CODEMP AS PRE_CODEMP,
    EMP_SIGLA_ AS PRE_SIGEMP,
  C.ITE_CODSIM AS PRE_CODSIM,   
  C.ITE_CODFOR AS PRE_CODFOR,
  
  @VMES00:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO00, @MES00) AS PRE_VMES00,
  @VMES01:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO01, @MES01) AS PRE_VMES01,
  @VMES02:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO02, @MES02) AS PRE_VMES02,
  @VMES03:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO03, @MES03) AS PRE_VMES03,
  @VMES04:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO04, @MES04) AS PRE_VMES04,
  @VMES05:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO05, @MES05) AS PRE_VMES05,
  @VMES06:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO06, @MES06) AS PRE_VMES06,
  @VMES07:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO07, @MES07) AS PRE_VMES07,
  @VMES08:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO08, @MES08) AS PRE_VMES08,
  @VMES09:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO09, @MES09) AS PRE_VMES09,
  @VMES10:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO10, @MES10) AS PRE_VMES10,
  @VMES11:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO11, @MES11) AS PRE_VMES11,
  @VMES12:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO12, @MES12) AS PRE_VMES12,
   
  @TIPEMP := IF(PAR_ORIITE = 'N' AND PAR_TIPEMP = 2 AND (SELECT COUNT(*) FROM AUTFOR WHERE AUT_CODEMP = G.ITE_CODEMP AND AUT_CODFOR = C.ITE_CODFOR) = 1, 1, PAR_TIPEMP) AS PRE_TIPEMP,
  FOR_COMPRA   AS PRE_COMPRA,
  
  CASE @TIPEMP 
    WHEN 1 THEN "Autônoma" 
    WHEN 2 THEN "Satélite" 
    WHEN 3 THEN "HUB" 
  END        AS PRE_DESTIP,  
  
  IF(@TIPEMP = 2, PAR_EMPHUB, PAR_CODEMP) AS PRE_EMPHUB,
  BAN_DESBAN AS PRE_DESBAN,
  BAN_CODBAN AS PRE_CODBAN,
  
  PRA_VALMIN AS PRE_VALMIN, 
  ITE_MLTVEN AS PRE_MLTVEN, 
  ITE_MLTCOM AS PRE_MLTCOM,
  @PRA_DIAENT := IFNULL(IF(@DIAPAS = 2 AND IFNULL(C.ITE_DIAFOR, 0) > 0, C.ITE_DIAFOR, PRA_DIAENT), 0) AS PRE_DIAENT, -- "F - PRAZO ENTREGA",
  ITE_ESTMIN AS PRE_ESTMIN, -- "G - ESTOQUE MÍNIMO CADASTRO",     
  ITE_ESTMAX AS PRE_ESTMAX, -- "G - ESTOQUE MÍNIMO CADASTRO",     
  
  G.ITE_NIVGIR AS PRE_NIVGIR,
  G.ITE_NIVCRI AS PRE_NIVCRI,  
  @DIAABA:=IF(PAR_DIAGER = 'G', IF(PRA_DIACOM > 0, PRA_DIACOM, PAR_DIAMAG),
             IF(PAR_DIAGER = 'C', CASE G.ITE_NIVCRI 
                                   WHEN "X" THEN PAR_DIAMNX
                                   WHEN "Y" THEN PAR_DIAMNY
                                   WHEN "Z" THEN PAR_DIAMNZ
                                  END,                     
                               
             IF(PAR_DIAGER = 'AC', CASE CONCAT(ITE_NIVGIR, G.ITE_NIVCRI)
                                    WHEN "AX" THEN PAR_DIAMAX
                                    WHEN "AY" THEN PAR_DIAMAY
                                    WHEN "AZ" THEN PAR_DIAMAZ
                                    WHEN "BX" THEN PAR_DIAMBX
                                    WHEN "BY" THEN PAR_DIAMBY
                                    WHEN "BZ" THEN PAR_DIAMBZ
                                    WHEN "CX" THEN PAR_DIAMCX
                                    WHEN "CY" THEN PAR_DIAMCY
                                    WHEN "CZ" THEN PAR_DIAMCZ
                                   END,      
             IF(IFNULL(fCfgPastaCompra('CFG_DIAABC','001'),'N') = 'S',
                                   CASE G.ITE_NIVGIR 
                                    WHEN "A" THEN  IF(PRA_DIACOM > 0, PRA_DIACOM, PAR_DIAMAA)
                                    WHEN "B" THEN  IF(PRA_DIACOM > 0, PRA_DIACOM, PAR_DIAMAB)
                                    WHEN "C" THEN  IF(PRA_DIACOM > 0, PRA_DIACOM, PAR_DIAMAC)
                                    END,
                                    CASE G.ITE_NIVGIR 
                                     WHEN "A" THEN PAR_DIAMAA
                                     WHEN "B" THEN PAR_DIAMAB
                                     WHEN "C" THEN PAR_DIAMAC
                                    END  )))) AS PRE_DIAABA, --  "B2 - DIAS ABAST. MÁX",
  
  PAR_PONPED AS PRE_PONPED, -- "F3 - UTILIZA PP",
  
  @DIAS_PONPED:=IF(PAR_PONPED = 'G', PAR_PONGER,
                  IF(PAR_PONPED = 'C', CASE G.ITE_NIVCRI
                                        WHEN "X" THEN PAR_PONNIX
                                        WHEN "Y" THEN PAR_PONNIY
                                        WHEN "Z" THEN PAR_PONNIZ
                                       END,  
                                                                       
                  IF(PAR_PONPED = 'AC', CASE CONCAT(ITE_NIVGIR, G.ITE_NIVCRI)
                                         WHEN "AX" THEN PAR_PONNAX
                                         WHEN "AY" THEN PAR_PONNAY
                                         WHEN "AZ" THEN PAR_PONNAZ
                                         WHEN "BX" THEN PAR_PONNBX
                                         WHEN "BY" THEN PAR_PONNBY
                                         WHEN "BZ" THEN PAR_PONNBZ
                                         WHEN "CX" THEN PAR_PONNCX
                                         WHEN "CY" THEN PAR_PONNCY
                                         WHEN "CZ" THEN PAR_PONNCZ
                                        END,  
                   CASE G.ITE_NIVGIR 
                     WHEN "A" THEN PAR_PONNIA
                     WHEN "B" THEN PAR_PONNIB
                     WHEN "C" THEN PAR_PONNIC
                   END))) AS PRE_PONGER, -- "B3 - DIAS PONTO PEDIDO EMPRESA",
  
  
  
    
  @DIAMAX:=(@DIAABA + @PRA_DIAENT) AS PRE_DIAMAX, -- "H - DIAS MÁXIMO",
  
  @MEDIA_MENSAL:=fMediaGiroSaida(G.ITE_CODITE, G.ITE_CODEMP, PAR_MESGIR, PAR_DESMAI) AS PRE_MEDMEN, -- "I - MÉDIA VENDA MENSAL (MESES)",    
  
  @MEDIA_DIARIA:=IFNULL(GIR_QTDSAI / PAR_DIAGIR, 0) AS PRE_MEDDIA, -- " MÉDIA VENDA DIÁRIA (DIAS CORRIDOS)",  
    
  @VENDA_DIA  := CAST(IF(PAR_USAMES = 'S', @MEDIA_MENSAL / 30, @MEDIA_DIARIA) AS DECIMAL(20, 10)) AS PRE_VENDIA, 
  @PRE_MEDMES := CAST(IF(PAR_USAMES = 'S', @MEDIA_MENSAL, @MEDIA_DIARIA * 30) AS DECIMAL(20, 10)) AS PRE_MEDMES, 
  PAR_USAMES AS PRE_USAMES,
  PAR_MESGIR AS PRE_MESGIR,
  PAR_DIAGIR AS PRE_DIAGIR,
  
  -- QUANTIDADE DE ESTOQUE PARA OS DIAS MÁXIMO DE ACORDO COM A MÉDIA DE VENDAS
  @SALMAX:=(CEIL(IF(@VENDA_DIA * @DIAMAX <  ITE_ESTMIN, ITE_ESTMIN, @VENDA_DIA * @DIAMAX) / ITE_MLTVEN) * ITE_MLTVEN) AS PRE_MAXCAL, -- "J - ESTOQUE MÁXIMO",  
  
  @DIASPP:=(@PRA_DIAENT + @DIAS_PONPED) AS PRE_DIAPON, -- "K - DIAS PP",
  -- QUANTIDADE DE ESTOQUE PARA OS DIAS DE PONTO DE PEDIDO DE ACORDO COM A MÉDIA DE VENDAS
  @QTD_PP:=(CEIL(IF(@DIASPP * @VENDA_DIA < ITE_ESTMIN, ITE_ESTMIN, @DIASPP * @VENDA_DIA) / ITE_MLTVEN) * ITE_MLTVEN) AS PRE_QESTPP, -- "L - QUANTIDADE ESTOQUE PP",
  
  @SALDIS:=(G.ITE_SALDOS + IFNULL(ITE_QTEF_A, 0) + IFNULL(ITE_QTEF_F, 0) - IFNULL(G.ITE_SALREG, 0) - IFNULL(G.ITE_SALREP, 0)) AS PRE_ESTDIS, --  "M - ESTOQUE DISPONÍVEL", -- CFG_CALSAL ?? #200047
  -- @SALDIS:=(G.ITE_SALDOS + IFNULL(ITE_QTEF_A, 0) + IFNULL(ITE_QTEF_F, 0) + IFNULL(ITE_QTEF_P, 0) - IFNULL(G.ITE_SALREG, 0) - IFNULL(G.ITE_SALREP, 0)) AS PRE_ESTDIS, --  "M - ESTOQUE DISPONÍVEL", -- CFG_CALSAL ??
  -- @SALDIS:=(G.ITE_SALDOS + IFNULL(ITE_QTEF_A, 0) + IFNULL(ITE_QTEF_F, 0) + IFNULL(ITE_QTEF_P, 0) - IFNULL(G.ITE_SALR_G, 0) - IFNULL(G.ITE_SALR_V, 0) - IFNULL(G.ITE_SALR_F, 0)) AS PRE_ESTDIS, --  "M - ESTOQUE DISPONÍVEL", -- CFG_CALSAL ??
  
  @PEDCOM:=IFNULL((SELECT SUM((PCD_QTDITE - PCD_QTDBAI) * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA)) FROM PCMDET 
                   INNER JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED AND PCG_CODEMP = PCD_CODEMP AND PCG_ESPDOC = PCD_ESPDOC
                   WHERE PCD_NUMCTN = 0 AND PCD_ESPDOC = "PD" AND PCD_CODITE = G.ITE_CODITE AND IFNULL(PCG_EMPDES, PCG_CODEMP) = G.ITE_CODEMP AND PCD_BAIXAD = 0
                         AND ((PAR_SUGGAR = 'S') OR
                              (IFNULL(PCG_DOCORI, "") = "") OR               
                              (IFNULL(                                           
                                 (SELECT COUNT(1) FROM MOVGAE 
                                  WHERE 
                                        SUBSTRING(PCD_DOCORI,1,12) = GAE_NUMENV 
                                    AND SUBSTRING(PCD_DOCORI,13,2) = GAE_ESPENV 
                                    AND PCD_CODEMP = GAE_EMPENV), 0) = 0))), 0) AS PRE_PEDCOM, -- 'N - PEDIDO COMPRA EM ABERTO',
IFNULL((SELECT SUM(((PCD_QTDITE - PCD_QTDBAI) * ROUND(PCD_UNITAR * 
          ((1 - IFNULL(PCD_DESUNI, 0)/ 100) * 
         (1 - IFNULL(PCD_DESUN2, 0)/ 100)), 2)) * (1 + PCD_PERIPI / 100) + IFNULL(PCD_TOTSUB, 0) - IFNULL(PCD_SUBBAI, 0)) FROM PCMDET 
                   INNER JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED AND PCG_CODEMP = PCD_CODEMP AND PCG_ESPDOC = PCD_ESPDOC
                   WHERE PCD_NUMCTN = 0 AND PCD_ESPDOC = "PD" AND PCD_CODITE = G.ITE_CODITE AND IFNULL(PCG_EMPDES, PCG_CODEMP) = G.ITE_CODEMP AND PCD_BAIXAD = 0
                         AND ((PAR_SUGGAR = 'S') OR
                              (IFNULL(PCG_DOCORI, "") = "") OR               
                              (IFNULL(                                           
                                 (SELECT COUNT(1) FROM MOVGAE 
                                  WHERE 
                                        SUBSTRING(PCD_DOCORI,1,12) = GAE_NUMENV 
                                    AND SUBSTRING(PCD_DOCORI,13,2) = GAE_ESPENV 
                                    AND PCD_CODEMP = GAE_EMPENV), 0) = 0))), 0) AS PRE_VALCOM, -- VALOR DA PENDENCIA
IFNULL((SELECT COUNT(DISTINCT PCMGER.AUTOINCREM) FROM PCMDET 
                   INNER JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED AND PCG_CODEMP = PCD_CODEMP AND PCG_ESPDOC = PCD_ESPDOC
                   WHERE PCD_NUMCTN = 0 AND PCD_ESPDOC = "PD" AND PCD_CODITE = G.ITE_CODITE AND IFNULL(PCG_EMPDES, PCG_CODEMP) = G.ITE_CODEMP AND PCD_BAIXAD = 0
                         AND ((PAR_SUGGAR = 'S') OR
                              (IFNULL(PCG_DOCORI, "") = "") OR               
                              (IFNULL(                                           
                                 (SELECT COUNT(1) FROM MOVGAE 
                                  WHERE 
                                        SUBSTRING(PCD_DOCORI,1,12) = GAE_NUMENV 
                                    AND SUBSTRING(PCD_DOCORI,13,2) = GAE_ESPENV 
                                    AND PCD_CODEMP = GAE_EMPENV), 0) = 0))), 0) AS PRE_QTDCOM,  
                                        
  CAST((SELECT MIN(PCG_DTAPED) FROM PCMDET 
                   INNER JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED AND PCG_CODEMP = PCD_CODEMP AND PCG_ESPDOC = PCD_ESPDOC
                   WHERE PCD_NUMCTN = 0 AND PCD_ESPDOC = "PD" AND PCD_CODITE = G.ITE_CODITE AND IFNULL(PCG_EMPDES, PCG_CODEMP) = G.ITE_CODEMP AND PCD_BAIXAD = 0
                         AND ((PAR_SUGGAR = 'S') OR
                              (IFNULL(PCG_DOCORI, "") = "") OR               
                              (IFNULL(                                           
                                 (SELECT COUNT(1) FROM MOVGAE 
                                  WHERE 
                                        SUBSTRING(PCD_DOCORI,1,12) = GAE_NUMENV 
                                    AND SUBSTRING(PCD_DOCORI,13,2) = GAE_ESPENV 
                                    AND PCD_CODEMP = GAE_EMPENV), 0) = 0))) AS DATE) AS PRE_ANTIGO,                                        
                                                             
  @SALTOT:=(@SALDIS + @PEDCOM) AS PRE_ESTTOT, -- "O - ESTOQUE TOTAL",
  
  --  COLUNAS NOVAS ---- 
  IF(@VENDA_DIA = 0, NULL, @SALDIS / @VENDA_DIA) AS DIAS_ESTOQUE,
  IF(@VENDA_DIA = 0, NULL, @SALTOT / @VENDA_DIA) AS DIAS_ESTOQUE_PENDENCIA,
  @MEDIA_MENSAL_3 := fMediaGiroSaida(G.ITE_CODITE, G.ITE_CODEMP, 3, 'N') AS PRE_MEDME3, -- MÉDIA VENDA MENSAL DOS ULTIMOS 3 MESES",                 
 
  @POSICAO := IF(@MEDIA_MENSAL_3 < 1, 0, 1) AS POSICAO,
  IF(@POSICAO = 0, 0, IF(@SALDIS <= 0, 1, 0)) AS RUPTURA, 
  -- -----------------------------------------------------------
  
  @SALDES:=(IF(PAR_PONPED <> 'N', IF(@SALTOT <= @QTD_PP, @SALMAX, 0), @SALMAX)) AS PRE_ESTDES, -- "P - ESTOQUE DESEJADO",
  
  @NECCOM:=ROUND(IF(@TIPEMP = 3, 
                 IF(@SALDES = 0,
                   IF(ROUND(@SALTOT, 2) > ROUND(@SALMAX, 2), @SALMAX - @SALTOT,  0), -- NEGATIVO 
                      @SALDES - @SALTOT), 
                   IF(ROUND(@SALDES, 2) < ROUND(@SALTOT, 2),
                      0, 
                      @SALDES - @SALTOT)                            -- NEGATIVO 
                    ), 2) AS PRE_NECCOM, -- "Q - NECESSIDADE DE COMPRA"
                    
  CAST(0 AS DECIMAL(14, 2)) AS PRE_NECAJU, -- NECESSIDADE AJUSTADA
  CAST(0 AS DECIMAL(14, 2)) AS PRE_NECPRI, -- NECESSIDADE AJUSTADA DO HUB 
  
  CAST(0 AS DECIMAL(14, 2)) AS PRE_QTDITE,
  
  0 AS PRE_COMPEN,
  
  @PERDES:=(1 - (
             (1 - (IFNULL(G.ITE_DESF01, 0)/ 100)) *
             (1 - (IFNULL(G.ITE_DESF02, 0)/ 100)) *
             (1 - (IFNULL(G.ITE_DESF03, 0)/ 100)) *
             (1 - (IFNULL(G.ITE_DESF04, 0)/ 100)) *
             (1 - (IFNULL(G.ITE_DESF05, 0)/ 100)) *
             (1 - (IFNULL(G.ITE_DESF06, 0)/ 100)))) * 100 AS DESUNI,
             
  CAST(0 AS DECIMAL(6,2)) AS PRE_PERDES,             
             
  @VALUNI:= ROUND(CAST((G.ITE_PRECOM * (1 - @PERDES/100)) AS DECIMAL(12,4)), 2) AS PRE_UNILIQ,
  CAST(@VALUNI AS DECIMAL (12,4)) AS PRE_VALUNI,
 
  IFNULL(G.ITE_IPIENT, 0) AS PRE_IPIENT,
  
  CAST(0 AS DECIMAL(14, 2)) AS PRE_TOTITE,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_TOTIPI,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_PERSUB,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_BASSUB,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_TOTSUB,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_TOTDAR,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_BASICM,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_ALQICM,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_VALICM,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_VALTOT,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_VALNET,
  
  @TIPFOR:=IF((FOR_I_E_S_= "") OR (FOR_CGCCPF <> 1), 
               'PEF', -- PESSOA FISICA (PF OU PJ SEM INSC. ESTADUAL)
               IF(FOR_MATREV = 'I', 
                 'PEJ', -- //PEJ - PESSOA JURIDICA (INDUSTRIA)
                 'PER')) AS PRE_TIPFOR,  -- //PER - PESSOA JURIDICA (DISTRIBUICAO/REVENDA/COMERCIALIZACAO)
                          
  CASE @TIPFOR 
    WHEN 'PEF' THEN ABF_CODSIT_ENT_PEF
    WHEN 'PEJ' THEN ABF_CODSIT_ENT_PEJ
    WHEN 'PER' THEN ABF_CODSIT_ENT_PER
  END AS PRE_ABF_CODSIT,
  
  CASE @TIPFOR 
    WHEN 'PEF' THEN ABF_BASICM_ENT_PEF
    WHEN 'PEJ' THEN ABF_BASICM_ENT_PEJ
    WHEN 'PER' THEN ABF_BASICM_ENT_PER
  END AS PRE_ABF_BASICM,
  
  CASE @TIPFOR 
    WHEN 'PEF' THEN ABF_BASRET_ENT_PEF
    WHEN 'PEJ' THEN ABF_BASRET_ENT_PEJ
    WHEN 'PER' THEN ABF_BASRET_ENT_PER
  END AS PRE_ABF_BASRET,
    
  CASE @TIPFOR 
    WHEN 'PEF' THEN ABF_IVA_ST_ENT_PEF
    WHEN 'PEJ' THEN ABF_IVA_ST_ENT_PEJ
    WHEN 'PER' THEN ABF_IVA_ST_ENT_PER
  END AS PRE_ABF_IVA_ST,
    
  CASE @TIPFOR 
    WHEN 'PEF' THEN ABF_ALQRET_ENT_PEF
    WHEN 'PEJ' THEN ABF_ALQRET_ENT_PEJ
    WHEN 'PER' THEN ABF_ALQRET_ENT_PER
  END AS PRE_ABF_ALQRET,
  
  CASE @TIPFOR 
    WHEN 'PEF' THEN ABF_ALQICM_ENT_PEF
    WHEN 'PEJ' THEN ABF_ALQICM_ENT_PEJ
    WHEN 'PER' THEN ABF_ALQICM_ENT_PER
  END AS PRE_ABF_ALQICM,
  
  @PERFCP := CASE @TIPFOR 
    WHEN 'PEF' THEN ABF_ALQFCP_ENT_PEF
    WHEN 'PEJ' THEN ABF_ALQFCP_ENT_PEJ
    WHEN 'PER' THEN ABF_ALQFCP_ENT_PER
  END AS PRE_PERFCP,
  
  
  0 AS PRE_SUBFCP, 
  
  (@TIPEMP = 3) OR (@NECCOM <> 0) AS VALIDOS,
  0 AS MARDES,
  CURDATE() AS PRE_DTAGER   
  
FROM
  ITEGER G       
INNER JOIN CADITE C ON C.ITE_CODITE = G.ITE_CODITE
INNER JOIN PAREMP   ON PAR_CODEMP   = G.ITE_CODEMP AND PAR_CODITE = G.ITE_CODITE
INNER JOIN EMPPRA   ON PRA_CODEMP   = G.ITE_CODEMP AND PRA_CODFOR = C.ITE_CODFOR
LEFT JOIN GIRO_SAIDA_DIAS ON GIR_CODITE = G.ITE_CODITE AND GIR_CODEMP = G.ITE_CODEMP AND GIR_DIAGIR = PAR_DIAGIR
INNER JOIN CADFOR ON FOR_CODFOR = C.ITE_CODFOR
INNER JOIN CADEMP ON EMP_CODEMP = G.ITE_CODEMP
LEFT  JOIN EMPBAN ON BAN_CODBAN = EMP_CODBAN
LEFT  JOIN CADCID ON CID_CODCID = FOR_CODCID
LEFT  JOIN ABFICM ON ABF_CODABF = IF(@TIPABF='1', C.ITE_CODABF, G.ITE_CODABF) 
                 AND ABF_ESTADO = CID_ESTADO  
                 
WHERE 
  C.ITE_ITEATI = 'S' AND C.ITE_ATICOM = 'S' AND  PAR_TIPEMP <> 4 ;  -- VER SE É POR EMPRESA
 
CREATE INDEX IDX_PRE_ORCAMENTO_07 ON PRE_ORCAMENTO(VALIDOS);
-- DELETE FROM PRE_ORCAMENTO WHERE VALIDOS = 0;
 
CREATE INDEX IDX_PRE_ORCAMENTO_01 ON PRE_ORCAMENTO(PRE_CODFOR, PRE_CODEMP, PRE_CODITE);
CREATE INDEX IDX_PRE_ORCAMENTO_02 ON PRE_ORCAMENTO(PRE_CODEMP, PRE_CODITE, PRE_CODFOR);
CREATE INDEX IDX_PRE_ORCAMENTO_03 ON PRE_ORCAMENTO(PRE_TIPEMP, PRE_EMPHUB, PRE_CODFOR);
CREATE INDEX IDX_PRE_ORCAMENTO_04 ON PRE_ORCAMENTO(PRE_CODFOR, PRE_MESGIR);
CREATE INDEX IDX_PRE_ORCAMENTO_05 ON PRE_ORCAMENTO(PRE_COMPRA, PRE_CODFOR, PRE_CODEMP);
CREATE INDEX IDX_PRE_ORCAMENTO_06 ON PRE_ORCAMENTO(PRE_EMPHUB, PRE_CODITE, PRE_CODFOR, PRE_TIPEMP);
UPDATE PRE_ORCAMENTO SET PRE_ESTDES = IF(PRE_PONPED <> "N", IF(PRE_ESTTOT <= PRE_QESTPP, PRE_MAXCAL, 0), PRE_MAXCAL)
WHERE PRE_ESTDES = 0;
UPDATE PRE_ORCAMENTO
SET PRE_NECCOM = ROUND(IF(PRE_TIPEMP = 3, 
                 IF(PRE_ESTDES = 0,
                   IF(PRE_ESTTOT > PRE_MAXCAL, PRE_MAXCAL - PRE_ESTTOT,  0), 
                      PRE_ESTDES - PRE_ESTTOT), 
                   IF(PRE_ESTDES < PRE_ESTTOT, 
                      0, 
                      PRE_ESTDES - PRE_ESTTOT)                            
                    ), 2) ; 
                    
DROP TABLE IF EXISTS PRE_SATELITES;
CREATE TABLE PRE_SATELITES
SELECT 
  PRE_CODITE AS SAT_CODITE, 
  PRE_EMPHUB AS SAT_EMPHUB, 
  SUM(PRE_NECCOM) AS SAT_NECCOM,
  SUM(PRE_ESTTOT) AS SAT_ESTTOT
FROM 
  PRE_ORCAMENTO
GROUP BY 
  PRE_CODITE, PRE_EMPHUB;
  
-- SELECT * FROM PRE_SATELITES;  
  
CREATE INDEX IDX_PRE_SATELITES_01 ON PRE_SATELITES(SAT_CODITE, SAT_EMPHUB);
UPDATE PRE_ORCAMENTO 
INNER JOIN PRE_SATELITES ON SAT_CODITE = PRE_CODITE AND SAT_EMPHUB = PRE_CODEMP
SET
  PRE_NECAJU = @QTDITE:=IF(SAT_NECCOM > 0, CEIL(SAT_NECCOM / PRE_MLTCOM) * PRE_MLTCOM, SAT_NECCOM),
  PRE_COMPEN = IF(SAT_ESTTOT <= @QTDITE, 1, 0),
  PRE_QTDITE = @QTDITE:=IF(@QTDITE > 0, @QTDITE, 0),
  PRE_TOTITE = @TOTITE:=ROUND(PRE_UNILIQ * @QTDITE, 2),
  PRE_TOTIPI = @TOTIPI:=ROUND(@TOTITE * (PRE_IPIENT/100), 2),
  PRE_VALNET = @TOTITE,
  PRE_TOTSUB = @TOTSUB:=fcalculaSubstituicaoCompra(@TOTITE, @TOTIPI, PRE_ABF_BASRET, PRE_ABF_IVA_ST, PRE_ABF_ALQRET, PRE_ABF_BASICM, PRE_ABF_ALQICM, PRE_ABF_CODSIT),
  PRE_VALTOT = @TOTITE + @TOTIPI + @TOTSUB,
  PRE_BASSUB = @BASSUB,
  PRE_BASICM = @BASICM,
  PRE_ALQICM = @ALQICM,
  PRE_VALICM = @VALICM
WHERE
  PRE_TIPEMP IN (1, 3); -- HUB OU AUTONOMA
  
UPDATE PRE_ORCAMENTO 
INNER JOIN PRE_SATELITES ON SAT_CODITE = PRE_CODITE AND SAT_EMPHUB = PRE_EMPHUB
SET
  PRE_NECPRI = SAT_NECCOM;
  
-- DELETE FROM PRE_ORCAMENTO WHERE PRE_NECPRI <= 0;
DROP TABLE IF EXISTS PRE_CODSIM_ORCAMENTO; 
CREATE TABLE PRE_CODSIM_ORCAMENTO 
SELECT DISTINCT PRE_CODSIM FROM PRE_ORCAMENTO WHERE PRE_CODSIM IS NOT NULL; 
CREATE INDEX IDX_CODSIM_ORCAMENTO_01 ON PRE_CODSIM_ORCAMENTO(PRE_CODSIM);
 
/* 
 DELETE FROM PRE_ORCAMENTO WHERE (PRE_NECCOM <= 0 AND PRE_NECAJU <= 0 AND PRE_TIPEMP <> 2)  -- 2 = SATELITE
                               OR 
                               ((IFNULL((SELECT SAT_NECCOM FROM PRE_SATELITES WHERE SAT_CODITE = PRE_CODITE AND SAT_EMPHUB = PRE_EMPHUB), 0) <= 0) AND PRE_TIPEMP = 2);
*/                            
-- CRIAÇÃO DOS SIMILARES -------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS PRE_SIMILARES;
CREATE TABLE PRE_SIMILARES
SELECT 
  @EMBALA :=  IFNULL(fRetEmbalagemFornecedor(FOR_CODFOR, C.ITE_CODITE), C.ITE_EMBALA) AS PRE_EMBALA,  
  G.ITE_CODITE AS PRE_CODITE,
  G.ITE_CODEMP AS PRE_CODEMP,
    EMP_SIGLA_ AS PRE_SIGEMP,
  
  C.ITE_CODSIM AS PRE_CODSIM, 
  C.ITE_CODFOR AS PRE_CODFOR,
  
  @MES00:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO00, @MES00) AS PRE_VMES00,
  @MES01:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO01, @MES01) AS PRE_VMES01,
  @MES02:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO02, @MES02) AS PRE_VMES02,
  @MES03:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO03, @MES03) AS PRE_VMES03,
  @MES04:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO04, @MES04) AS PRE_VMES04,
  @MES05:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO05, @MES05) AS PRE_VMES05,
  @MES06:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO06, @MES06) AS PRE_VMES06,
  @MES07:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO07, @MES07) AS PRE_VMES07,
  @MES08:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO08, @MES08) AS PRE_VMES08,
  @MES09:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO09, @MES09) AS PRE_VMES09,
  @MES10:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO10, @MES10) AS PRE_VMES10,
  @MES11:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO11, @MES11) AS PRE_VMES11,
  @MES12:=fGiroSaida(G.ITE_CODITE, G.ITE_CODEMP , @ANO12, @MES12) AS PRE_VMES12,
   
  @TIPEMP := IF(PAR_ORIITE = 'N' AND PAR_TIPEMP = 2 AND (SELECT COUNT(*) FROM AUTFOR WHERE AUT_CODEMP = G.ITE_CODEMP AND AUT_CODFOR = C.ITE_CODFOR) = 1, 1, PAR_TIPEMP) AS PRE_TIPEMP,
  FOR_COMPRA   AS PRE_COMPRA,
  
  CASE @TIPEMP 
    WHEN 1 THEN "Autônoma" 
    WHEN 2 THEN "Satélite" 
    WHEN 3 THEN "HUB" 
  END        AS PRE_DESTIP,  
  
  IF(@TIPEMP = 2, PAR_EMPHUB, PAR_CODEMP) AS PRE_EMPHUB,
  BAN_DESBAN AS PRE_DESBAN,
  BAN_CODBAN AS PRE_CODBAN,
  
  PRA_VALMIN AS PRE_VALMIN, 
  ITE_MLTVEN AS PRE_MLTVEN, 
  ITE_MLTCOM AS PRE_MLTCOM,
  @PRA_DIAENT := IFNULL(IF(@DIAPAS = 2 AND IFNULL(C.ITE_DIAFOR, 0) > 0, C.ITE_DIAFOR, PRA_DIAENT), 0) AS PRE_DIAENT, -- "F - PRAZO ENTREGA",
  ITE_ESTMIN AS PRE_ESTMIN, -- "G - ESTOQUE MÍNIMO CADASTRO",     
  ITE_ESTMAX AS PRE_ESTMAX, -- "G - ESTOQUE MÍNIMO CADASTRO",     
  
  G.ITE_NIVGIR AS PRE_NIVGIR,
           
G.ITE_NIVCRI AS PRE_NIVCRI,  
  @DIAABA:=IF(PAR_DIAGER = 'G', IF(PRA_DIACOM > 0, PRA_DIACOM, PAR_DIAMAG),
             IF(PAR_DIAGER = 'C', CASE G.ITE_NIVCRI 
                                   WHEN "X" THEN PAR_DIAMNX
                                   WHEN "Y" THEN PAR_DIAMNY
                                   WHEN "Z" THEN PAR_DIAMNZ
                                  END,                     
                               
             IF(PAR_DIAGER = 'AC', CASE CONCAT(ITE_NIVGIR, G.ITE_NIVCRI)
                                    WHEN "AX" THEN PAR_DIAMAX
                                    WHEN "AY" THEN PAR_DIAMAY
                                    WHEN "AZ" THEN PAR_DIAMAZ
                                    WHEN "BX" THEN PAR_DIAMBX
                                    WHEN "BY" THEN PAR_DIAMBY
                                    WHEN "BZ" THEN PAR_DIAMBZ
                                    WHEN "CX" THEN PAR_DIAMCX
                                    WHEN "CY" THEN PAR_DIAMCY
                                    WHEN "CZ" THEN PAR_DIAMCZ
                                   END,      
             IF(IFNULL(fCfgPastaCompra('CFG_DIAABC','001'),'N') = 'S',
                                   CASE G.ITE_NIVGIR 
                                    WHEN "A" THEN  IF(PRA_DIACOM > 0, PRA_DIACOM, PAR_DIAMAA)
                                    WHEN "B" THEN  IF(PRA_DIACOM > 0, PRA_DIACOM, PAR_DIAMAB)
                                    WHEN "C" THEN  IF(PRA_DIACOM > 0, PRA_DIACOM, PAR_DIAMAC)
                                    END,
                                    CASE G.ITE_NIVGIR 
                                     WHEN "A" THEN PAR_DIAMAA
                                     WHEN "B" THEN PAR_DIAMAB
                                     WHEN "C" THEN PAR_DIAMAC
                                    END  )))) AS PRE_DIAABA,  --  "B2 - DIAS ABAST. MÁX",
  
  PAR_PONPED AS PRE_PONPED, -- "F3 - UTILIZA PP",
  
  @DIAS_PONPED:=IF(PAR_PONPED = 'G', PAR_PONGER,
                  IF(PAR_PONPED = 'C', CASE G.ITE_NIVCRI
                                        WHEN "X" THEN PAR_PONNIX
                                        WHEN "Y" THEN PAR_PONNIY
                                        WHEN "Z" THEN PAR_PONNIZ
                                       END,  
                                                                       
                  IF(PAR_PONPED = 'AC', CASE CONCAT(ITE_NIVGIR, G.ITE_NIVCRI)
                                         WHEN "AX" THEN PAR_PONNAX
                                         WHEN "AY" THEN PAR_PONNAY
                                         WHEN "AZ" THEN PAR_PONNAZ
                                         WHEN "BX" THEN PAR_PONNBX
                                         WHEN "BY" THEN PAR_PONNBY
                                         WHEN "BZ" THEN PAR_PONNBZ
                                         WHEN "CX" THEN PAR_PONNCX
                                         WHEN "CY" THEN PAR_PONNCY
                                         WHEN "CZ" THEN PAR_PONNCZ
                                        END,  
                   CASE G.ITE_NIVGIR 
                     WHEN "A" THEN PAR_PONNIA
                     WHEN "B" THEN PAR_PONNIB
                     WHEN "C" THEN PAR_PONNIC
                   END))) AS PRE_PONGER, -- "B3 - DIAS PONTO PEDIDO EMPRESA",
  
  
  @DIAMAX:=(@DIAABA + @PRA_DIAENT) AS PRE_DIAMAX, -- "H - DIAS MÁXIMO",
  
  @MEDIA_MENSAL:=fMediaGiroSaida(G.ITE_CODITE, G.ITE_CODEMP, PAR_MESGIR, PAR_DESMAI) AS PRE_MEDMEN, -- "I - MÉDIA VENDA MENSAL (MESES)",    
    
  @MEDIA_DIARIA:=IFNULL(GIR_QTDSAI / PAR_DIAGIR, 0) AS PRE_MEDDIA, -- " MÉDIA VENDA DIÁRIA (DIAS CORRIDOS)",  
    
  @VENDA_DIA  := CAST(IF(PAR_USAMES = 'S', @MEDIA_MENSAL / 30, @MEDIA_DIARIA) AS DECIMAL(20, 10)) AS PRE_VENDIA, 
  @PRE_MEDMES := CAST(IF(PAR_USAMES = 'S', @MEDIA_MENSAL, @MEDIA_DIARIA * 30) AS DECIMAL(20, 10)) AS PRE_MEDMES, 
  
  PAR_USAMES AS PRE_USAMES,
  PAR_MESGIR AS PRE_MESGIR,
  PAR_DIAGIR AS PRE_DIAGIR,
  
  -- QUANTIDADE DE ESTOQUE PARA OS DIAS MÁXIMO DE ACORDO COM A MÉDIA DE VENDAS
  @SALMAX:=(CEIL(IF(@VENDA_DIA * @DIAMAX <  ITE_ESTMIN, ITE_ESTMIN, @VENDA_DIA * @DIAMAX) / ITE_MLTVEN) * ITE_MLTVEN) AS PRE_MAXCAL, -- "J - ESTOQUE MÁXIMO",  
  
  @DIASPP:=(@PRA_DIAENT + @DIAS_PONPED) AS PRE_DIAPON, -- "K - DIAS PP",
  -- QUANTIDADE DE ESTOQUE PARA OS DIAS DE PONTO DE PEDIDO DE ACORDO COM A MÉDIA DE VENDAS
  @QTD_PP:=(CEIL(IF(@DIASPP * @VENDA_DIA < ITE_ESTMIN, ITE_ESTMIN, @DIASPP * @VENDA_DIA) / ITE_MLTVEN) * ITE_MLTVEN) AS PRE_QESTPP, -- "L - QUANTIDADE ESTOQUE PP",
  
  @SALDIS:=(G.ITE_SALDOS + IFNULL(ITE_QTEF_A, 0) + IFNULL(ITE_QTEF_F, 0) - IFNULL(G.ITE_SALREG, 0) - IFNULL(G.ITE_SALREP, 0)) AS PRE_ESTDIS, --  "M - ESTOQUE DISPONÍVEL", -- CFG_CALSAL ?? #200047
  -- @SALDIS:=(G.ITE_SALDOS + IFNULL(ITE_QTEF_A, 0) + IFNULL(ITE_QTEF_F, 0) + IFNULL(ITE_QTEF_P, 0) - IFNULL(G.ITE_SALREG, 0) - IFNULL(G.ITE_SALREP, 0)) AS PRE_ESTDIS, --  "M - ESTOQUE DISPONÍVEL", -- CFG_CALSAL ??
  -- @SALDIS:=(G.ITE_SALDOS + IFNULL(ITE_QTEF_A, 0) + IFNULL(ITE_QTEF_F, 0) + IFNULL(ITE_QTEF_P, 0) - IFNULL(G.ITE_SALR_G, 0) - IFNULL(G.ITE_SALR_V, 0) - IFNULL(G.ITE_SALR_F, 0)) AS PRE_ESTDIS, --  "M - ESTOQUE DISPONÍVEL", -- CFG_CALSAL ??
  
  @PEDCOM:=IFNULL((SELECT SUM((PCD_QTDITE - PCD_QTDBAI) * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA)) FROM PCMDET 
                   INNER JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED AND PCG_CODEMP = PCD_CODEMP AND PCG_ESPDOC = PCD_ESPDOC
                   WHERE PCD_NUMCTN = 0 AND PCD_ESPDOC = "PD" AND PCD_CODITE = G.ITE_CODITE AND IFNULL(PCG_EMPDES, PCG_CODEMP) = G.ITE_CODEMP AND PCD_BAIXAD = 0
                         AND ((PAR_SUGGAR = 'S') OR
                              (IFNULL(PCG_DOCORI, "") = "") OR               
                              (IFNULL(                                           
                                 (SELECT COUNT(1) FROM MOVGAE 
                                  WHERE 
                                        SUBSTRING(PCD_DOCORI,1,12) = GAE_NUMENV 
                                    AND SUBSTRING(PCD_DOCORI,13,2) = GAE_ESPENV 
                                    AND PCD_CODEMP = GAE_EMPENV), 0) = 0))), 0) AS PRE_PEDCOM, -- 'N - PEDIDO COMPRA EM ABERTO',
IFNULL((SELECT SUM(((PCD_QTDITE - PCD_QTDBAI) * ROUND(PCD_UNITAR * 
          ((1 - IFNULL(PCD_DESUNI, 0)/ 100) * 
         (1 - IFNULL(PCD_DESUN2, 0)/ 100)), 2)) * (1 + PCD_PERIPI / 100) + IFNULL(PCD_TOTSUB, 0) - IFNULL(PCD_SUBBAI, 0)) FROM PCMDET 
                   INNER JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED AND PCG_CODEMP = PCD_CODEMP AND PCG_ESPDOC = PCD_ESPDOC
                   WHERE PCD_NUMCTN = 0 AND PCD_ESPDOC = "PD" AND PCD_CODITE = G.ITE_CODITE AND IFNULL(PCG_EMPDES, PCG_CODEMP) = G.ITE_CODEMP AND PCD_BAIXAD = 0
                         AND ((PAR_SUGGAR = 'S') OR
                              (IFNULL(PCG_DOCORI, "") = "") OR               
                              (IFNULL(                                           
                                 (SELECT COUNT(1) FROM MOVGAE 
                                  WHERE 
                                        SUBSTRING(PCD_DOCORI,1,12) = GAE_NUMENV 
                                    AND SUBSTRING(PCD_DOCORI,13,2) = GAE_ESPENV 
                                    AND PCD_CODEMP = GAE_EMPENV), 0) = 0))), 0) AS PRE_VALCOM, -- VALOR DA PENDENCIA
IFNULL((SELECT COUNT(DISTINCT PCMGER.AUTOINCREM) FROM PCMDET 
                   INNER JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED AND PCG_CODEMP = PCD_CODEMP AND PCG_ESPDOC = PCD_ESPDOC
                   WHERE PCD_NUMCTN = 0 AND PCD_ESPDOC = "PD" AND PCD_CODITE = G.ITE_CODITE AND IFNULL(PCG_EMPDES, PCG_CODEMP) = G.ITE_CODEMP AND PCD_BAIXAD = 0
                         AND ((PAR_SUGGAR = 'S') OR
                              (IFNULL(PCG_DOCORI, "") = "") OR               
                              (IFNULL(                                           
                                 (SELECT COUNT(1) FROM MOVGAE 
                                  WHERE 
                                        SUBSTRING(PCD_DOCORI,1,12) = GAE_NUMENV 
                                    AND SUBSTRING(PCD_DOCORI,13,2) = GAE_ESPENV 
                                    AND PCD_CODEMP = GAE_EMPENV), 0) = 0))), 0) AS PRE_QTDCOM,  
                                        
  CAST((SELECT MIN(PCG_DTAPED) FROM PCMDET 
                   INNER JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED AND PCG_CODEMP = PCD_CODEMP AND PCG_ESPDOC = PCD_ESPDOC
                   WHERE PCD_NUMCTN = 0 AND PCD_ESPDOC = "PD" AND PCD_CODITE = G.ITE_CODITE AND IFNULL(PCG_EMPDES, PCG_CODEMP) = G.ITE_CODEMP AND PCD_BAIXAD = 0
                         AND ((PAR_SUGGAR = 'S') OR
                              (IFNULL(PCG_DOCORI, "") = "") OR               
                              (IFNULL(                                           
                                 (SELECT COUNT(1) FROM MOVGAE 
                                  WHERE 
                                        SUBSTRING(PCD_DOCORI,1,12) = GAE_NUMENV 
                                    AND SUBSTRING(PCD_DOCORI,13,2) = GAE_ESPENV 
                                    AND PCD_CODEMP = GAE_EMPENV), 0) = 0))) AS DATE) AS PRE_ANTIGO,                                        
                                          
                   
  @SALTOT:=(@SALDIS + @PEDCOM) AS PRE_ESTTOT, -- "O - ESTOQUE TOTAL",
  
  --  COLUNAS NOVAS ---- 
  IF(@VENDA_DIA = 0, NULL, @SALDIS / @VENDA_DIA) AS DIAS_ESTOQUE,
  IF(@VENDA_DIA = 0, NULL, @SALTOT / @VENDA_DIA) AS DIAS_ESTOQUE_PENDENCIA,
  @MEDIA_MENSAL_3 := fMediaGiroSaida(G.ITE_CODITE, G.ITE_CODEMP, 3, 'N') AS PRE_MEDME3, -- MÉDIA VENDA MENSAL DOS ULTIMOS 3 MESES",                 
 
  @POSICAO := IF(@MEDIA_MENSAL_3 < 1, 0, 1) AS POSICAO,
  IF(@POSICAO = 0, 0, IF(@SALDIS <= 0, 1, 0)) AS RUPTURA, 
  -- -----------------------------------------------------------
  
  @SALDES:=(IF(PAR_PONPED <> 'N', IF(@SALTOT <= @QTD_PP, @SALMAX, 0), @SALMAX)) AS PRE_ESTDES, -- "P - ESTOQUE DESEJADO",
               
  @NECCOM:=ROUND(IF(@TIPEMP = 3, 
                 IF(@SALDES = 0,
                   IF(@SALTOT > @SALMAX, @SALMAX - @SALTOT,  0), -- NEGATIVO 
                      @SALDES - @SALTOT), 
                   IF(@SALDES < @SALTOT, 
                      0, 
                      @SALDES - @SALTOT)                            -- NEGATIVO 
                    ), 2) AS PRE_NECCOM, -- "Q - NECESSIDADE DE COMPRA"
                    
  CAST(0 AS DECIMAL(14, 2)) AS PRE_NECAJU, -- NECESSIDADE AJUSTADA
  CAST(0 AS DECIMAL(14, 2)) AS PRE_NECPRI, -- NECESSIDADE AJUSTADA DO HUB 
  
  CAST(0 AS DECIMAL(14, 2)) AS PRE_QTDITE,
  
  0 AS PRE_COMPEN,
    
  @PERDES:=(1 - (
             (1 - (IFNULL(G.ITE_DESF01, 0)/ 100)) *
             (1 - (IFNULL(G.ITE_DESF02, 0)/ 100)) *
             (1 - (IFNULL(G.ITE_DESF03, 0)/ 100)) *
             (1 - (IFNULL(G.ITE_DESF04, 0)/ 100)) *
             (1 - (IFNULL(G.ITE_DESF05, 0)/ 100)) *
             (1 - (IFNULL(G.ITE_DESF06, 0)/ 100)))) * 100 AS DESUNI,
             
  CAST(0 AS DECIMAL(6,2)) AS PRE_PERDES,             
             
  @VALUNI:= ROUND(CAST((G.ITE_PRECOM * (1 - @PERDES/100)) AS DECIMAL(12,4)), 2) AS PRE_UNILIQ,
  CAST(@VALUNI AS DECIMAL (12,4)) AS PRE_VALUNI,
 
  IFNULL(G.ITE_IPIENT, 0) AS PRE_IPIENT,
  
  CAST(0 AS DECIMAL(14, 2)) AS PRE_TOTITE,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_TOTIPI,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_PERSUB,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_BASSUB,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_TOTSUB,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_TOTDAR,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_BASICM,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_ALQICM,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_VALICM,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_VALTOT,
  CAST(0 AS DECIMAL(14, 2)) AS PRE_VALNET,
  
  @TIPFOR:=IF((FOR_I_E_S_= "") OR (FOR_CGCCPF <> 1), 
               'PEF', -- PESSOA FISICA (PF OU PJ SEM INSC. ESTADUAL)
               IF(FOR_MATREV = 'I', 
                 'PEJ', -- //PEJ - PESSOA JURIDICA (INDUSTRIA)
                 'PER')) AS PRE_TIPFOR,  -- //PER - PESSOA JURIDICA (DISTRIBUICAO/REVENDA/COMERCIALIZACAO)
                          
  CASE @TIPFOR 
    WHEN 'PEF' THEN ABF_CODSIT_ENT_PEF
    WHEN 'PEJ' THEN ABF_CODSIT_ENT_PEJ
    WHEN 'PER' THEN ABF_CODSIT_ENT_PER
  END AS PRE_ABF_CODSIT,
  
  CASE @TIPFOR 
    WHEN 'PEF' THEN ABF_BASICM_ENT_PEF
    WHEN 'PEJ' THEN ABF_BASICM_ENT_PEJ
    WHEN 'PER' THEN ABF_BASICM_ENT_PER
  END AS PRE_ABF_BASICM,
  
  CASE @TIPFOR 
    WHEN 'PEF' THEN ABF_BASRET_ENT_PEF
    WHEN 'PEJ' THEN ABF_BASRET_ENT_PEJ
    WHEN 'PER' THEN ABF_BASRET_ENT_PER
  END AS PRE_ABF_BASRET,
    
  CASE @TIPFOR 
    WHEN 'PEF' THEN ABF_IVA_ST_ENT_PEF
    WHEN 'PEJ' THEN ABF_IVA_ST_ENT_PEJ
    WHEN 'PER' THEN ABF_IVA_ST_ENT_PER
  END AS PRE_ABF_IVA_ST,
    
  CASE @TIPFOR 
    WHEN 'PEF' THEN ABF_ALQRET_ENT_PEF
    WHEN 'PEJ' THEN ABF_ALQRET_ENT_PEJ
    WHEN 'PER' THEN ABF_ALQRET_ENT_PER
  END AS PRE_ABF_ALQRET,
  
  CASE @TIPFOR 
    WHEN 'PEF' THEN ABF_ALQICM_ENT_PEF
    WHEN 'PEJ' THEN ABF_ALQICM_ENT_PEJ
    WHEN 'PER' THEN ABF_ALQICM_ENT_PER
  END AS PRE_ABF_ALQICM,
  
  
  @PERFCP :=  CASE @TIPFOR 
    WHEN 'PEF' THEN ABF_ALQFCP_ENT_PEF
    WHEN 'PEJ' THEN ABF_ALQFCP_ENT_PEJ
    WHEN 'PER' THEN ABF_ALQFCP_ENT_PER
  END AS PRE_PERFCP,
  0 AS PRE_SUBFCP,
  0 AS MARDES,
  CURDATE() AS PRE_DTAGER
  
FROM
  ITEGER G       
INNER JOIN CADITE C ON C.ITE_CODITE = G.ITE_CODITE
INNER JOIN PRE_CODSIM_ORCAMENTO S ON S.PRE_CODSIM = C.ITE_CODSIM
INNER JOIN PAREMP   ON PAR_CODEMP   = G.ITE_CODEMP AND PAR_CODITE = G.ITE_CODITE
INNER JOIN EMPPRA   ON PRA_CODEMP   = G.ITE_CODEMP AND PRA_CODFOR = C.ITE_CODFOR
LEFT JOIN GIRO_SAIDA_DIAS ON GIR_CODITE = G.ITE_CODITE AND GIR_CODEMP = G.ITE_CODEMP AND GIR_DIAGIR = PAR_DIAGIR
INNER JOIN CADFOR ON FOR_CODFOR = C.ITE_CODFOR
INNER JOIN CADEMP ON EMP_CODEMP = G.ITE_CODEMP
LEFT  JOIN EMPBAN ON BAN_CODBAN = EMP_CODBAN
LEFT  JOIN CADCID ON CID_CODCID = FOR_CODCID
LEFT  JOIN ABFICM ON ABF_CODABF = IF(@TIPABF='1', C.ITE_CODABF, G.ITE_CODABF) 
                 AND ABF_ESTADO = CID_ESTADO  
                 
WHERE 
  C.ITE_ITEATI = 'S' AND C.ITE_ATICOM = 'S' AND PAR_TIPEMP <> 4 ;  -- VER SE É POR EMPRESA
 
  
CREATE INDEX IDX_PRE_SIMILARES_01 ON PRE_SIMILARES(PRE_CODSIM, PRE_CODFOR, PRE_CODEMP);
UPDATE LOGNOT SET LOG_HORFIN = NOW(), LOG_EXECUT = 'S' WHERE LOG_DESCRI = 'PRE_ORCAMENTO_COMPRA' AND LOG_HORINI = @HORLOG;
    END$$

DELIMITER ;