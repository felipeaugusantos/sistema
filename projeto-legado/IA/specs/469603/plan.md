# Plano de Execução — Req. 469603

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica
Alteração pontual na chamada de `fGravaCadPag` em `TEntImpNFSe.fConfirmaImportacao`: substituir o `0` da posição de `dtaDtaDoc` (4º valor após `fltMulSuj`) por `FDtaDoc` e comentar os 10 parâmetros finais (`fltMulSuj` … `AIncCadFis`).

## 2. Arquivos impactados
| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untEntImpNFSe.pas | padra_atualizado/fontes/movimentacaoitens/ (74.150.45, 74.150.100, 74.150) | alterar |
| untCadPag.pas | padra_atualizado/fontes/financeiro/contasapagar/ | nenhuma (somente conferência da assinatura) |

## 3. Sequência de implementação
1. Conferir em cada cópia a assinatura de `fGravaCadPag` (`fltMulSuj, strAutIncPix, fltGrvOri, dtaDtaDoc, ADtaLiberacao, AHorLiberacao, AOpeLiberacao, AUsaMca, strGnreChaveDeApuracao, AIncCadFis, strQrCode`) e a existência de `FDtaDoc`.
2. Aplicar a alteração via Python (cp1252, `newline=''`), validando os 10 valores esperados antes de gravar.
3. Validar encoding (decodifica em cp1252, sem `\xef\xbf\xbd`) e diff.

## 4. Conformidade com padrões do projeto
- Zona Legado: Hungarian preservado; nenhum identificador novo.
- Sem componentes/chamadas/SQL proibidos.

## 5. Estratégia de testes
- Sem suite DUnit para este fluxo; validação manual da importação de NFS-e conferindo `CADPAG.CTP_DTADOC`.
- Casos: importação normal; data alterada na grid; múltiplas parcelas; título antigo com data nula.

## 6. Riscos e mitigação
- Posição de parâmetro diferente entre versões → conferência da assinatura e asserção dos valores no script.
- `FIS_DTAENT` ≠ data de emissão em algum município → validar layout com a análise fiscal.
