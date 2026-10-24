# Plano de Execução — Req. 463062

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

`fBaixaPedidosAtendidosDepoisDaEntrada` já monta `qryEntMer` com os campos fiscais corretos (`DET_NUMDOC`, `DET_CODEMP`, `DET_CODFOR`, `DET_ESPDOC`, `DET_SERIE_`) e calcula `strAutEle`. Em vez de chamar a versão curta `fBaixaPedidos(oleItensPedidos, cdsPedidos)` — que descarta esses dados usando variáveis locais nunca inicializadas — a função passa a chamar `fBaixaPedidosEmbalagem` diretamente, repassando os campos já disponíveis. Não é necessário criar overload nem alterar a assinatura de `fBaixaPedidosAtendidosDepoisDaEntrada`, `pEfetiva` ou qualquer chamador externo.

Reparo de dados: `UPDATE` controlado em `PCMDET` para as 20 linhas do pedido `019000010338`, executado via `citel-conectarBanco` em modo `--master` (preview obrigatório, aprovação explícita antes da etapa de confirmação).

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untPcmGer.pas` | `padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas` | alterar (função `fBaixaPedidosAtendidosDepoisDaEntrada`, linha ~15064) |

Nenhum outro arquivo Delphi é alterado. O reparo de dados não é um arquivo de código — é uma execução SQL controlada, documentada em `tasks.md`.

## 3. Sequência de implementação

1. Em `fBaixaPedidosAtendidosDepoisDaEntrada` ([untPcmGer.pas](../../padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas)), declarar `objEmbala: TEntEmbalagens` local e inicializar `objEmbala := Nil`.
2. Substituir:
   ```pascal
   If blnBaiPed Then
     Result := fBaixaPedidos(oleItensPedidos, cdsPedidos);
   ```
   por:
   ```pascal
   If blnBaiPed Then
     Result := fBaixaPedidosEmbalagem(oleItensPedidos, cdsPedidos,
                                      qryEntMer.FieldByName('DET_NUMDOC').AsString,
                                      qryEntMer.FieldByName('DET_ESPDOC').AsString,
                                      qryEntMer.FieldByName('DET_CODEMP').AsString,
                                      qryEntMer.FieldByName('DET_CODFOR').AsString,
                                      qryEntMer.FieldByName('DET_SERIE_').AsString,
                                      strAutEle,
                                      objEmbala,
                                      True);
   ```
   (`qryEntMer` está posicionada no primeiro registro desde o `Open` em `pCriaEntmer` e não é navegada em nenhum outro ponto da função — os campos lidos são os mesmos que `fCarregaAutoIncremNotaFiscal` já lê antes, na mesma linha.)
3. Compilar e conferir que a assinatura de `fBaixaPedidosEmbalagem` (que já existe e é usada por `fBaixaPedidos` e outros pontos) não precisa de nenhuma alteração.
4. Validar manualmente com o roteiro descrito em `tasks.md` (Fase 3).
5. Reparo retroativo dos dados do pedido `019000010338` via `citel-conectarBanco --master` (preview, aprovação, confirmação) — ver `tasks.md` para o SQL exato.

## 4. Conformidade com padrões do projeto

- Zona Legado: manter Hungarian style, prefixos `f`/`p`, sem introduzir interfaces ou refatoração além do necessário.
- Nenhum componente proibido, `SetFocus` direto, `StrToFloat`, `Now()`, concatenação SQL ou `Application.CreateForm` envolvidos nesta mudança.
- `ParamByName()` já é usado corretamente em `fBaixaPcmDet`/`fBaixaPcmGer` — não alterado.
- A alteração não mexe em `.dpr`/`.dproj` (nenhuma unit nova).

## 5. Estratégia de testes

- Zona Legado sem infraestrutura de teste automatizado — validação manual.
- Roteiro (Fase 3 de `tasks.md`): simular ou reprocessar uma entrada de NF com a efetivação do movimento fiscal em duas etapas (`fConferenciaDepoisDaEntrada`) ativa, conferir os campos gravados em `PCMDET` e o SQL registrado no log de auditoria (`LOGREP_ARQUIV_*`) da semana.

## 6. Riscos e mitigação

- **Regressão em outros fluxos que chamam `fBaixaPedidosAtendidosDepoisDaEntrada`** → mitigação: a mudança só enriquece os parâmetros passados para `fBaixaPedidosEmbalagem`, que já é a implementação real usada por `fBaixaPedidos`; comportamento para `blnEntradaDeMercadorias=True` e itens sem NF vinculada (`strAutEle` vazio) permanece equivalente, pois `fAtualizaDadosPcmDet` já trata `strAutEle` vazio.
- **Reparo de dados atingir linhas indevidas** → mitigação: usar o modo `--master` da `citel-conectarBanco`, que exige preview (linhas casadas/mudariam), teto de linhas e aprovação explícita antes de confirmar.
- **`TRetornoFornecedor.pBaixarPedidos` não corrigido** → risco aceito, documentado em spec.md como fora de escopo (dado vazio por desenho, não pelo mesmo defeito).
