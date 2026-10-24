-- ============================================================================
-- Req. 458948 - percentual de juros de parcelamento por faixa de valor
-- ============================================================================
-- A FXCASA nasceu no Req. 454627 com escopo GLOBAL (sem FAI_CODEMP). O
-- percentual acompanha esse escopo: vale para todas as empresas da instancia.
--
-- Isso e diferente da CFG_JURATR, que e por empresa e hoje assume sete valores
-- distintos entre as 35 empresas da base de desenvolvimento. Colocar o
-- percentual aqui torna a politica de juros de parcelamento unica para toda a
-- instancia - decisao registrada no levantamento, nao efeito colateral.
--
-- NULO POR PADRAO, de proposito: as faixas ja cadastradas continuam validas sem
-- intervencao nenhuma, e o endpoint devolve a tabela com juros zero ate alguem
-- preencher o percentual (spec.md, regra R5). Nao usar NOT NULL nem DEFAULT 0 -
-- ambos apagariam a diferenca entre "sem juros" e "ainda nao cadastrado".
--
-- DECIMAL(5,2) comporta ate 999,99%.
-- ============================================================================

ALTER TABLE FXCASA
  ADD COLUMN FAI_PERJUR DECIMAL(5,2) DEFAULT NULL AFTER FAI_QTDPAR;

-- ----------------------------------------------------------------------------
-- Conferencia
-- ----------------------------------------------------------------------------
-- Esperado: uma linha, Type = decimal(5,2), Null = YES, Default = NULL
SHOW COLUMNS FROM FXCASA LIKE 'FAI_PERJUR';

-- Esperado: as faixas que ja existiam, todas com FAI_PERJUR nulo
SELECT AUTOINCREM, FAI_VALINI, FAI_VALFIN, FAI_QTDPAR, FAI_PERJUR
  FROM FXCASA
 ORDER BY FAI_VALINI;
