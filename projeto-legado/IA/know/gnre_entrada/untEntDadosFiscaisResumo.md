# untEntDadosFiscaisResumo — botões de guia

> Escopo **parcial**: só os quatro botões de guia (GNRE ST, GNRE Tributada, TCIF, TS) e o que a
> unit faz com os objetos `TGnre`. A tela de resumo da entrada de mercadorias tem mais de 6 mil linhas
> e pertence à rotina de entrada; o restante não está mapeado aqui.

## Responsabilidade

Tela de resumo/confirmação da entrada de mercadorias (`TfrmEntDadosFiscaisResumo`). Na rotina de
GNRE, é o ponto onde as guias são digitadas **durante** a entrada e gravadas na confirmação.

## Caminho

`padra_atualizado/fontes/movimentacaoitens/untEntDadosFiscaisResumo.pas` + `.dfm` — encoding cp1252.

## Comportamento

**Criação da tela:**

| Objeto | Tipo inicial | Observação |
|--------|--------------|------------|
| `objGnreST` | `tcGnreST` | Vira `tcGnrePadrao` quando `CFG_GNRTEM` está desligada |
| `objGnreTributado` | `tcGnreTributado` | Só alcançável com `CFG_GNRTEM` |
| `objGnreTCIF` | `tcTCIF` | Botão visível só com `CFG_SUFRAM` |
| `objGnreTS` | `tcTS` | Botão visível só com `CFG_SUFRAM` |

Sem `CFG_GNRTEM`: botão Tributada some, a tela encolhe (largura 1050) e o botão ST passa a se chamar
`[F3]GNRE`. Empresa DARE troca os textos dos botões (`fTrocaNomeGNRE`).

Ao montar a tela, se o documento é de fornecedor, `objGnreST.strCodFor` recebe `CFG_FORGNE` (aviso se
o fornecedor não existe) e `strForDoc` recebe o fornecedor da nota.

**Botões** — os quatro fazem o mesmo, cada um com o seu objeto:

```
objGnreX.pTelaGnre(<nota tem XML: recNotEle.strAutInc preenchido>, fCfgSis('FORGNE'));
objGnreX.fAtualizaValorGnre;
```

Ou seja: monta os itens a partir de `TMP_ENTMER`, abre `TfrmEntGNRE` e grava o valor por item de
volta em `TMP_ENTMER`. Nada é gravado em `CADGNR`/`GNRTCI`/`GNR_TS` nesse momento.

TCIF e TS saem sem fazer nada se o botão estiver invisível (atalho de teclado com Suframa desligado).

**Confirmação da entrada:**

1. Antes de gravar, `FblnComNFE` dos quatro objetos recebe se a nota tem XML.
2. Se `ENT_PREGNR = 'S'` (prévia marcada na importação) e o valor da guia ST está zerado,
   `objGnreST.pVerificaPrevia` pergunta e abre a tela.
3. Na cadeia de gravação da entrada, após `fAtualizaPedidoDevolucao`, rodam em sequência
   `objGnreST`, `objGnreTributado`, `objGnreTCIF`, `objGnreTS` `.fGravaGnre(...)` com nota, espécie,
   série, fornecedor, operador, nome do form, "imprimir CP" (`chkImprCp`), data do documento e
   `strAutIncCadFis`. Guia com valor zero sai sem gravar. Qualquer `False` interrompe a cadeia.

**Espelho da nota:** `objGnreST` alimenta o espelho (`frmRelEspNotaEnt.objGnre`) e a variável `@GNRE`
do relatório (valor, fornecedor, vencimento).

## Quando os botões ficam ocultos

| Situação | Botões ocultos |
|----------|----------------|
| `CFG_GNRTEM` desligada | Tributada |
| `CFG_SUFRAM` desligada | TCIF, TS |
| Devolução ou XML de devolução emitida pelo fornecedor | ST, Tributada |
| Acesso via retorno de consignação | ST, Tributada, TCIF, TS |

## Configurações que impactam esta parte da unit

| Código CFGSIS | Efeito |
|---------------|--------|
| `GNRTEM` | Mostra o botão Tributada; define se o botão ST usa `tcGnreST` ou `tcGnrePadrao` |
| `SUFRAM` | Mostra TCIF e TS |
| `FORGNE` | Fornecedor sugerido da guia |

## Métodos

| Método | Tipo | O que faz | Efeito colateral |
|--------|------|-----------|------------------|
| `btnGnreSTClick` | evento | Tela e valores da guia ST/Padrão | Grava `TMP_ENTMER` |
| `btnGnreTributClick` | evento | Tela e valores da guia Tributada | Grava `TMP_ENTMER` |
| `btnTCIFClick` | evento | Tela e valores da TCIF (só se visível) | Grava `TMP_ENTMER` |
| `btnTSClick` | evento | Tela e valores da TS (só se visível) | Grava `TMP_ENTMER` |
| `mnuGnreSTClick` / `mnuGnreTributadoClick` | evento | Atalhos de menu para os botões | — |
| `FormKeyDown` | evento | F3 → ST (Alt+F3 é conversão M³), F2 → Tributada, F1 → TCIF, Alt+F1 → TS | — |

## Tela associada (.dfm)

| Componente | Caption | Disparo |
|------------|---------|---------|
| `btnGnreST` | `[F3]GNRE Prod. ST` (`[F3]GNRE` sem `GNRTEM`) | `btnGnreSTClick` |
| `btnGnreTribut` | `[F2]GNRE Prod. Tribut.` | `btnGnreTributClick` |
| `btnTCIF` | `[F1]TCIF` | `btnTCIFClick` |
| `btnTS` | `[Alt+F1]TS` | `btnTSClick` |

## Pontos de atenção

- O F2 chama `btnGnreTribut.Click` mesmo com o botão oculto; o handler não confere visibilidade (TCIF
  e TS conferem). Com `GNRTEM` desligada, F2 abre a tela de guia Tributada. A confirmar se o
  `TBitBtnLocked` bloqueia o `Click` de botão invisível.
- `fGravaGnre` é chamado com `blnDelCadGnre` padrão (`True`): apaga e regrava a guia do documento
  na mesma origem.
- Os valores digitados na tela da guia ficam em `TMP_ENTMER` até a confirmação; abandonar a entrada
  descarta a guia.

## Alterações documentadas

| Data | Requisito/Revisão | O que mudou |
|------|-------------------|-------------|
| 2026-10-16 | Mapeamento parcial (botões de guia), base r500183 | Documentação inicial dos quatro botões e do ciclo de vida dos objetos `TGnre`; sem alteração de código |
