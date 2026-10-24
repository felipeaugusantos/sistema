# Plano de Execução — Req. 466227

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica
Porte da correção da r451543 (`74.150.45`): na chamada de `fRetAutoIncrem` dentro de `fGeraInventarioDivergentes`, trocar o intervalo `qryFiltroMapDet.RecordCount -1` por `qryFiltroMapDet.RecordCount +1`. A reserva passa a cobrir todas as linhas do lote, e o contador `PROINC` do MAPDET deixa de coincidir com o último ID já gravado. Não se escreve correção nova (duas correções para o mesmo defeito gerariam comportamento diferente por cliente).

## 2. Arquivos impactados
| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untMapaDeInventarioParaColetores.pas | padra_atualizado/fontes/Util_DLL/OpeRefProd/ | alterar (linha ~839, `-1` → `+1`) |

Versões: `74.111` e `74.111.188` confirmadas com o defeito; `74.150.45` já corrigida (r451543). Demais versões do `vepeal` do requisito a verificar na Fase 1.

## 3. Sequência de implementação
1. Consultar o `vepeal` do 466227 e verificar, por `svn cat`/`svn diff` entre URLs (sem checkout), o estado da linha em cada versão afetada.
2. Conferir o diff da r451543 (`svn diff -c 451543`) para confirmar que a única mudança é a linha do intervalo.
3. Para cada versão com `-1`: `python .claude\scripts\fonte_delphi.py conferir <arquivo>`, depois alterar via `fonte_delphi.py` (preserva cp1252 e CRLF).
4. Conferir por `svn diff` que o diff contém só a linha alterada e que o resultado é idêntico ao da r451543.
5. Compilar a DLL `libOpeRefProd` e validar manualmente (seção 5).

## 4. Conformidade com padrões do projeto
- Zona Legado: manter o estilo existente; sem refatoração proativa.
- Sem componentes ou chamadas proibidas introduzidos (alteração de um literal numérico).
- Não incluir número de requisito em identificadores; se houver comentário, curto, com `Req. 466227`.
- Encoding: cp1252 + CRLF preservados; validar ausência de `EF BF BD`.
- Pre-commit: nenhuma regra afetada.

## 5. Estratégia de testes
- Não há suíte DUnit para esta rotina; validação manual na tela ÚTIL > OPERAÇÕES REFERENTES A PRODUTOS > BALANÇO DE ESTOQUE POR AJUSTE > MAPA DE INVENTÁRIOS PARA COLETORES.
- Casos:
  1. Mapa com 2 ou mais itens divergentes: "Recontar divergências do mapa", informar operador; confirmar sucesso.
  2. Repetir logo em seguida, sem fechar o Autcom (antes da correção, a segunda tentativa colide).
  3. Recontar vários mapas em sequência na mesma sessão.
  4. Conferir em MAPDET: IDs sem colisão, `MPD_NUMCON`, operador e `MPD_STATUS = 'N'` corretos.
- Teste prévio recomendado (antes de implementar): repetir a operação sem fechar o Autcom para confirmar ou descartar a causa; se continuar falhando na mesma sessão, reabrir a análise.

## 6. Riscos e mitigação
- Contador `PROINC` do MAPDET avança 1 ID a mais por lote → buraco inofensivo na sequência.
- Outras versões podem ter divergências na rotina → comparar a mesma rotina por `svn diff` entre URLs antes de alterar.
- `RecordCount` de query parcialmente carregada poderia subestimar o lote → não observado (lotes de 13 a 190 linhas); fora de escopo, relatar se aparecer.
- Hipótese de estado de variável/query sujo entre operações → verificada pelo teste do item 5.
