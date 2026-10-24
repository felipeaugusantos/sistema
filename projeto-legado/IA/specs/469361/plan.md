# Plano de Execução — Req. 469361

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica
Novo método público `TfrmEntDigMultiLojasNovo.pAutoLarguraBandas` que atribui `Width := 0` a todas as bandas de
`cxgItensView`, devolvendo a largura automática. É chamado nos dois pontos que alteram a visibilidade das colunas depois da
restauração do layout (`FormShow` e `TCdsDigMultLoja.pAjustaConfigs`). Código legado: mantém o estilo existente da unit,
sem refatoração.

## 2. Arquivos impactados
| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untEntDigMultiLojasNovo.pas | padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/ | alterar (declaração, `pAutoLarguraBandas`, chamada no fim do `FormShow`) |
| untCdsDigMultLoja.pas | padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/ | alterar (chamada no fim de `pAjustaConfigs`) |

| untEntDigMultiLojasNovo.dfm | padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/ | alterar (item `mnuRestaurarPadrao` no `popFuncoes`) |
| untCfgGrid.pas | padra_atualizado/fontes/genericos/ | alterar (`TCfgGrid.pAjustaColunas`: ignorar coluna sem título) |

Working copies: 74.150.45, 74.150, 74.150.100.

## 3. Sequência de implementação
1. Declarar `pAutoLarguraBandas` na seção `public` de `TfrmEntDigMultiLojasNovo`.
2. Implementar o método (laço sobre `cxgItensView.Bands`, `Width := 0`) com comentário curto + `Verificar Nota 1 - Req. 469361`.
3. Chamar no fim de `FormShow`, depois das alterações de `Visible` das colunas.
4. Chamar no fim de `TCdsDigMultLoja.pAjustaConfigs`.
5. Reativar `pRestaurarPadrao` (declaração e implementação) e criar `mnuRestaurarPadrao` no `popFuncoes` (.pas e .dfm), com
   handler `mnuRestaurarPadraoClick` que pede confirmação (`fMensagem`) antes de chamar `pRestaurarPadrao`.
6. O item `mnuRestaurarPadrao` fica sempre visível (sem teste de `blnCotacao`): vale para pedido de compra e cotação.
7. Em `TCfgGrid.pAjustaColunas`, no ramo `FOperacaoNova = False`, listar só coluna com `Caption` ou `AlternateCaption`.
8. Em `TCdsDigMultLoja.pRestauraPadrao` (ramo ancorado), guardar a instância anterior e chamar `Release` depois de recriar
   e ancorar (Nota 2).
9. Em `TCdsDigMultLoja.pApagaConfiguracoes`, filtrar o DELETE de `CFGPDC` por `CFG_NOMGRI` (mesma condição de salvar/carregar)
   e liberar a query em `try/finally`.
10. Mover `strEmpCalc := FOpcGir.strEmpCal` para `TCdsDigMultLoja.pCriaDigMultiLojas` (Nota 3).
11. Replicar nas demais working copies e conferir `svn diff`.

## 4. Conformidade com padrões do projeto
- Zona Legado: nomes no padrão da unit (prefixo `p` para procedure, `int` para inteiro local).
- Sem componentes ou chamadas proibidas pelo pre-commit; sem alteração em `.dfm`.
- Encoding cp1252/CRLF preservado (edição via Python; checagem de `\xef\xbf\xbd`).
- Comentário curto no fonte com referência de nota; explicação completa na seção "Notas referenciadas" do .md de análise.

## 5. Estratégia de testes
- Sem suíte automatizada para esta tela; validação manual.
- Casos: tela ancorada com configuração salva; janela; maximizada; "Restaurar padrão"; operador sem configuração salva.
  Em todos, rolar até o fim e conferir que a última coluna visível aparece.
- "Restaurar Padrão": visível no pedido de compra e na cotação; confirmação Sim/Não; restaurar ancorado e em janela, nos dois modos.
- "Configura Colunas": sem linhas em branco; conferir também outra tela que use `TCfgGrid`.

## 6. Riscos e mitigação
- Risco: remover uma das chamadas reintroduz o problema → mitigação: Nota 1 no fonte e no .md explica a necessidade.
- Risco: ordem entre `RestoreFromIniFile` e as chamadas variar por fluxo → mitigação: chamada nos dois pontos (idempotente).
- Risco: `untCfgGrid.pas` é compartilhada → mitigação: o filtro iguala o ramo existente ao ramo `FOperacaoNova = True`, que já
  ignorava coluna sem título.
- Risco: restauração recria o form no clique do próprio form → mitigação: `Release` adiado (nunca `Free`/`pFreeAndNil` na hora).
