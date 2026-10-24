# Especificação — Req. 469603

**Título:** CTP_DTADOC não preenchido na importação de NFS-e
**Objetivo:** gravar a data do documento (`CTP_DTADOC`) no CADPAG gerado pela importação de NFS-e (EntImportaNFSe).
**Zona:** Legado
**Data:** 2026-10-13

## 1. Contexto / problema atual
Em `TEntImpNFSe.fConfirmaImportacao` (`untEntImpNFSe.pas`), a chamada a `fGravaCadPag` passa `0` posicionalmente no parâmetro `dtaDtaDoc`. Em `untCadPag.pas` (`fGravaCadPag`, ~linhas 826-829), `dtaDtaDoc = 0` grava `CTP_DTADOC = Null`. O título gerado fica sem data do documento.

## 2. Módulos e entidades envolvidos
- Módulo: movimentacaoitens (importação NFS-e) → financeiro/contasapagar (CADPAG)
- Units: `padra_atualizado/fontes/movimentacaoitens/untEntImpNFSe.pas` (alterar); `padra_atualizado/fontes/financeiro/contasapagar/untCadPag.pas` (somente leitura)
- Tabela: CADPAG, campo `CTP_DTADOC`

## 3. Requisitos funcionais
- RF01 — Passar `FDtaDoc` ao parâmetro `dtaDtaDoc` de `fGravaCadPag` em `fConfirmaImportacao`.
- RF02 — Comentar os parâmetros finais da chamada (de `fltMulSuj` a `AIncCadFis`) para identificar cada um.

## 4. Regras de negócio
- RN01 — `FDtaDoc` vem de `FIS_DTAENT` do XML (~linha 2464), já é a "Data do Documento" no CADFIS e é sincronizado com a coluna `DTADOC` da grid (`pEnviaDados`/`pAtualizaDados`); alteração do usuário na tela chega ao CADPAG.
- RN02 — Todas as parcelas do loop gravam a mesma data do documento.
- RN03 — Títulos antigos com `CTP_DTADOC` nulo continuam funcionando (`untCadPag.pas` usa `CTP_CODCAD` como alternativa).

## 5. Requisitos técnicos / não-funcionais
- Arquivo em cp1252/CRLF: edição apenas via Python com encoding explícito.
- Sem alteração de assinatura ou lógica de `fGravaCadPag`.

## 6. Critérios de aceitação
- [ ] Importação de NFS-e gera CADPAG com `CTP_DTADOC` = data do documento.
- [ ] Data alterada na grid antes de confirmar é a gravada.
- [ ] Todas as parcelas gravam `CTP_DTADOC`.
- [ ] Demais chamadores de `fGravaCadPag` não são afetados.

## 7. Fora de escopo
- Alterar `untCadPag.pas`; corrigir títulos já gerados com `CTP_DTADOC` nulo.

## 8. Dependências e riscos
- Confirmar que `FIS_DTAENT` do layout XML do município corresponde à data de emissão da NFS-e.
- Aplicar em 74.150.45, 74.150.100 e 74.150 (não há quarto diretório).
