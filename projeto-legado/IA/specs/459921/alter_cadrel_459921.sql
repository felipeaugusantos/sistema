-- Req. 459921 - Novo tipo de saida "Arquivo Saida" no editor de relatorios
-- Colunas novas na CADREL (aplicar via processo de atualizacao de banco).
-- MySQL 5.7. NAO usar FOREIGN_KEY_CHECKS.

-- Codificacao/modo do arquivo gerado: 'UTF-8' | 'UTF-8 BOM' | 'ANSI' | 'UTF-16' | 'Base64'
-- ('Base64' = conteudo em base64 decodificado para binario cru, ex.: PDF)
ALTER TABLE CADREL
  ADD COLUMN REL_ENCARQ VARCHAR(10) NOT NULL DEFAULT 'UTF-8';

-- Sanitizar nome do arquivo (remover caracteres invalidos): 'S' | 'N'
ALTER TABLE CADREL
  ADD COLUMN REL_SANARQ CHAR(1) NOT NULL DEFAULT 'N';

-- Ajuda do editor (AJUREL): nomes fixos das colunas obrigatorias do destino "Arquivo Saida".
-- Proximos codigos apos o ultimo do PREPARA_ANTES (000089). INSERT IGNORE = idempotente/re-executavel.
INSERT IGNORE INTO AJUREL (AUTOINCREM, REL_CODAJU, REL_DESCRI, REL_TIPAJU, REL_NUMABA, REL_TXTAJU, REL_DESABA, REL_PREABA)
VALUES('00100000000000090001','000090','ARQUIVO_NOME','VARIÁVEIS',4,'Coluna obrigatória no SELECT quando o destino é \'Arquivo Saída\'.\r\nDefine o nome (com extensão) de cada arquivo gerado - um arquivo por registro do resultado.\r\nExemplo: SELECT CONCAT(NFE_ACESSO, \'.xml\') AS ARQUIVO_NOME, NFE_ARQXML AS ARQUIVO_CONTEUDO FROM XMLNFE','ARQUIVO SAÍDA','N');

INSERT IGNORE INTO AJUREL (AUTOINCREM, REL_CODAJU, REL_DESCRI, REL_TIPAJU, REL_NUMABA, REL_TXTAJU, REL_DESABA, REL_PREABA)
VALUES('00100000000000091001','000091','ARQUIVO_CONTEUDO','VARIÁVEIS',4,'Coluna obrigatória no SELECT quando o destino é \'Arquivo Saída\'.\r\nDefine o conteúdo gravado em cada arquivo.\r\nGravado conforme a Codificação escolhida no cadastro do relatório (UTF-8, UTF-8 BOM, ANSI ou UTF-16).\r\nSe a Codificação for \'Base64\', o conteúdo é tratado como texto base64 e decodificado para binário (ex.: PDF) - NÃO usar FROM_BASE64 no SQL.','ARQUIVO SAÍDA','N');
