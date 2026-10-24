# Especificação — Req. 466694

**Título:** Importação de NF-e (Movimentação de Itens) falha silenciosamente com XML versão 2.00
**Objetivo:** Permitir a importação de XML de NF-e de layout antigo (2.00), tratando tags inexistentes naquela versão, e informar erro claro quando uma tag obrigatória da versão estiver ausente.
**Zona:** Legado (`padra_atualizado/fontes/movimentacaoitens/`)
**Data:** 05/10/2026

## 1. Contexto / problema atual
- Solicitante/contato: Kleyton. Ticket Zendesk: https://citelsoftware.zendesk.com/agent/tickets/1695965
- Menu: Principal > Movimentação de Itens > Importação de Nota Fiscal Eletrônica.
- O cliente importa uma NF-e emitida pelo sistema anterior (para devolução). O sistema não localiza os itens, não importa e não exibe erro.
- **Causa:** o XML é versão **2.00** (`<infNFe versao="2.00">`). Na `<ide>` não existem `idDest`, `indPres` e `indFinal`. Em `TNFeXml.fGetIde` (`untEntNfeXml.pas`), `fGetValorXml` devolve `''` quando a tag não existe (não lança exceção). Atribuir `''` aos campos `Integer` `B11A_IDDEST`, `B25B_INDPRES` e `B25B_INDFINAL` gera erro de conversão de Variant. O `Except` de `fGetIde` faz apenas `Result := False`, sem `pIncluiErro` — falha silenciosa.
- Problema adicional: `StrToIntDef(versao, 0)` retorna 0 para "2.00" (não é inteiro), inviabilizando a decisão por versão.

## 2. Módulos e entidades envolvidos
- Módulo: movimentação de itens — importação de NF-e XML.
- Unit: `padra_atualizado/fontes/movimentacaoitens/untEntNfeXml.pas` (`TNFeXml.fGetIde`, rotina de leitura que preenche `nodInfNFe`/`fltVersaoXml`).
- Campos: `B11A_IDDEST`, `B25B_INDPRES`, `B25B_INDFINAL` (Integer, record/tabela GERELE).
- `fGetValorXml`: `padra_atualizado/fontes/genericos/untFuncoes.pas`.

### Dados para simulação
- Caminho: `\\CITEL-FILESERVE\AUTDBF\ALVESHOMECEN\01.10.2026`
- XML (chave 35140461143632000107550010001817671006925604): https://bucket.citelsoftware.com.br/DIARIO_CITEL_AUTDBF_466694-35140461143632000107550010001817671006925604.xml
- Cópia local: `C:\Users\danilo.stefaneli\Desktop\Nova pasta (4)\35140461143632000107550010001817671006925604.xml`
- Screenshot: https://bucket.citelsoftware.com.br/DIARIO_CITEL_AUTDBF_466694-Screenshot_273.png

## 3. Requisitos funcionais
- RF01 — XML versão 2.00 (sem `idDest`/`indPres`/`indFinal`) deve ser importado normalmente.
- RF02 — Se uma tag que a versão do XML deveria ter estiver ausente, exibir/registrar erro via `pIncluiErro` e interromper a nota.
- RF03 — A versão do XML deve ser lida como número decimal (ex.: "2.00", "3.10", "4.00").

## 4. Regras de negócio
- RN01 — `idDest`: obrigatória a partir da versão **4.00**.
- RN02 — `indPres` e `indFinal`: obrigatórias a partir da versão **3.10**.
- RN03 — Tag ausente em versão anterior à exigida: assume 0 e segue (sem erro).
- RN04 — Tag ausente em versão que a exige: `pIncluiErro('Nota ' + B08_NNF + ': XML invalido. Estrutura do arquivo incompativel (sem "<tag>").')` e `Exit(False)`.
- RN05 — Efeito do valor 0: consultas existentes usam `B25B_INDPRES IN (1, 5)`, que continuam funcionando.

## 5. Requisitos técnicos / não-funcionais
- Arquivo em cp1252 (Latin-1), CRLF: edição apenas via Python.
- Usar `fStrToFloat` (não `StrToFloat`/`StrToFloatDef`); `fStrToFloatDef` não está definida no código.
- Usar `fExistNode` antes de ler a tag (não depender de exceção).

## 6. Critérios de aceitação
- [ ] O XML anexado (versão 2.00) é importado e os itens são carregados.
- [ ] XML 4.00 sem `idDest` exibe o erro com a tag citada.
- [ ] XML 3.10+ sem `indPres`/`indFinal` exibe o erro com a tag citada.
- [ ] XML 3.10 sem `idDest` importa normalmente (`idDest` só é exigida na 4.00).
- [ ] XML 4.00 completo continua importando como antes.

## 7. Fora de escopo
- Outras tags de layouts antigos além das três tratadas (qualquer outra divergência na importação do XML 2.00 será tratada em item separado, se surgir).

## 8. Dependências e riscos
- Outras tags ausentes na 2.00 podem causar novos erros após esta correção — validar o fluxo completo com o XML anexado.
- O `Except` de `fGetIde` continua silencioso para outros erros (pendente decidir incluir `pIncluiErro` com `E.Message`).
