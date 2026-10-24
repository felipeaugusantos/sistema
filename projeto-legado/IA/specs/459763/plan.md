# Req. 459763 — Plano técnico

Zona: **Moderna** (`padra_atualizado/Services/`) — dot-notation, sem Hungarian nos tipos novos,
interfaces onde já existem. `Services.Core.*` é infra comum aos 38 serviços: toda alteração ali
é **aditiva**.

## Units impactadas

| Unit | Zona | O que muda |
|------|------|-----------|
| `Services/Core/Services.Core.Utils.pas` | Moderna / infra comum | `fJsonAndamento` ganha `ANumero`, `ATotalEtapas` com default 0; chaves omitidas quando 0 |
| `Services/Core/Services.Core.Worker.pas` | Moderna / infra comum | `TWorkerTaskProgress` ganha estado de sequência; nova sobrecarga de `pDefinirEtapa`; `fColher`, `pGravarAndamento` e `pAmostrarAndamento` passam os dois valores adiante |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Giro.pas` | Moderna | Catálogo das 8 etapas; `TCotacaoGiroEtapa` ganha os dois parâmetros; as 11 chamadas de `pEtapa` viram etapa numerada ou detalhe |
| `Services/Core/suprimento/services/types/Suprimento.Services.Cotacao.Types.pas` | Moderna | Novo `TCotacaoGiroEtapaDTO`; `TCotacaoGiroAndamento` remodelado com `Nullable*` |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Consulta.pas` | Moderna | Monta o novo corpo, com as regras por status (RN03–RN07) |
| `Services/Core/suprimento/services/Suprimento.Services.Workers.pas` | Moderna | Callback do giro repassa numero/totalEtapas ao porta-valores |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Notificacao.pas` | Moderna | Lê `COT_DESCRI` e monta o texto nomeado |

Nenhuma alteração de schema. Nenhum `.dpr` novo, nenhuma unit nova — o `.dproj` não precisa
ser tocado.

---

## Sequência

### Fase 1 — Infra de sequência de etapas (`Services.Core.*`)

Aditivo, para não mudar a forma do `_STATUS` de `FSATSK` e `FNATSK` (RN08).

**1.1 `Services.Core.Utils.pas` — `fJsonAndamento`**

```pascal
function fJsonAndamento(const AEtapa: String; APosicao, ATotal: Int64;
                        ANumero: Integer = 0; ATotalEtapas: Integer = 0): String;
```

`numero` e `totalEtapas` entram no objeto **apenas** quando `> 0`. Mesma decisão já tomada para
`progresso`: omitir é mais honesto que publicar zero, que quem lê leria como valor real.

**1.2 `Services.Core.Worker.pas` — `TWorkerTaskProgress`**

Dois campos de classe novos, `FNumero` e `FTotalEtapas`, sob o mesmo `FLock`.

O ponto crítico é **qual método mexe neles**:

| Método | Mexe em `FNumero` / `FTotalEtapas`? | Por quê |
|--------|--------------------------------------|---------|
| `pDefinirEtapa(AEtapa)` — usado pelos ganchos do legado | **Não** | É por aqui que entra a mensagem arbitrária do motor. Zerar o número aqui apagaria a posição na sequência a cada mensagem do `fCalculaGiroEstoque` (RN01) |
| `pDefinirEtapa(AEtapa, APosicao, ATotal)` | **Não** | Mesmo motivo |
| `pDefinirEtapa(AEtapa, ANumero, ATotalEtapas, APosicao, ATotal)` — **nova** | Sim | É a única porta que declara sequência |
| `pDefinirProgresso(APosicao, ATotal)` | Não | Só números |
| `pLimpar` | Sim, zera | Fim da tarefa |

A guarda de "texto igual não suja" tem de passar a considerar os dois campos novos, senão uma
etapa numerada com o mesmo texto da anterior não seria publicada.

`fColher` ganha `out ANumero, ATotalEtapas: Integer`. É `out` e não campo de record porque o
método já tem essa forma e mudar para record obrigaria a mexer em `pAmostrarAndamento` sem ganho.

**1.3 `pGravarAndamento` e `pAmostrarAndamento`**

Repassam os dois valores. Nenhuma gravação extra: entram no mesmo `UPDATE` da amostragem de 3 s
(RN10). A colheita final de `pAmostrarAndamento:1805` já cobre a última etapa — é ela que garante
`numero = 8` no `CONCLUIDO`.

### Fase 2 — Catálogo de etapas do giro (`Cotacao.Giro.pas`)

**2.1 O catálogo**

```pascal
type
  { Etapas NUMERADAS do giro. O enum e o catalogo andam juntos de proposito: o numero e
    Ord(etapa)+1 e o total sai de High(), entao acrescentar etapa nova move o total sozinho
    (RN02). Nao existe literal 8 no codigo.

    Mensagem que NAO esta aqui - inclusive toda mensagem do motor legado, que chega pelos
    ganchos VS_OnMensagemAguarde e TfrmGravando.OnMensagemAguarde - atualiza apenas a
    descricao e PRESERVA o numero corrente. Ver a secao 3 do requisito. }
  TCotacaoGiroEtapaSeq = (cgeAbrirRascunho,
                          cgeValidarFiltros,
                          cgePrepararCalculo,
                          cgeCalcularGiro,
                          cgeCopiarResultado,
                          cgeConverterEmbalagem,
                          cgeAbrirItens,
                          cgeGravarItens);

const
  CEtapasGiro: array[TCotacaoGiroEtapaSeq] of String = (
    'Abrindo o rascunho...',
    'Validando filtros...',
    'Preparando o calculo do giro...',
    'Calculando giro de estoque...',
    'Copiando o resultado...',
    'Convertendo embalagens...',
    'Abrindo os itens do rascunho...',
    'Gravando os itens no rascunho...');

  CTotalEtapasGiro = Ord(High(TCotacaoGiroEtapaSeq)) + 1;
```

Os textos são **os mesmos de hoje**, caractere por caractere: eles já aparecem no log
(`WriteLog('[cotacao-giro] ' + ...)`) e mudá-los quebraria a leitura de log de produção sem
motivo.

**2.2 A assinatura do callback**

```pascal
TCotacaoGiroEtapa = reference to procedure(const AEtapa: String;
                                          ANumero, ATotalEtapas: Integer;
                                          APosicao, ATotal: Integer);
```

`ANumero = 0` significa "detalhe da etapa corrente, não mexa no número".

**2.3 Os helpers locais**

`fCalcular` e `fGerar` têm cada um o seu `pEtapa` local hoje. Passam a ter dois:

```pascal
procedure pEtapa(AEtapa: TCotacaoGiroEtapaSeq; APosicao: Integer = 0; ATotal: Integer = 0);
procedure pDetalhe(const AstrTexto: String; APosicao: Integer = 0; ATotal: Integer = 0);
```

`pEtapa` resolve texto e número pelo catálogo; `pDetalhe` publica com número zero. Ambos
mantêm o `WriteLog` atual.

> **Restrição de Delphi a respeitar:** procedure local dentro de método de classe **genérica**
> é E2570 — mas nem `TCotacaoGiroExecutor` nem `TCotacaoGiroGravador` são genéricas, então as
> procedures locais continuam válidas. Vale lembrar porque a memória do projeto registra esse
> erro em outro contexto.

**2.4 Reclassificação das 11 chamadas**

| Linha atual | Passa a ser |
|-------------|-------------|
| `Giro.pas:899` `'Abrindo o rascunho...'` | `pEtapa(cgeAbrirRascunho)` |
| `Giro.pas:705` `'Validando filtros...'` | `pEtapa(cgeValidarFiltros)` |
| `Giro.pas:712` `'Preparando o calculo...'` | `pEtapa(cgePrepararCalculo)` |
| `Giro.pas:723` `'Calculando giro de estoque...'` | `pEtapa(cgeCalcularGiro)` |
| `Giro.pas:756` `'Copiando o resultado...'` | `pEtapa(cgeCopiarResultado)` |
| `Giro.pas:767` `'Convertendo embalagens...'` | `pEtapa(cgeConverterEmbalagem)` |
| `Giro.pas:784` `'Giro calculado.'` | `pDetalhe(..., Result, Result)` |
| `Giro.pas:918` `'O giro nao retornou itens...'` | `pDetalhe(...)` |
| `Giro.pas:930` `'Abrindo os itens do rascunho...'` | `pEtapa(cgeAbrirItens)` |
| `Giro.pas:945` `'Gravando os itens no rascunho...'` | `pEtapa(cgeGravarItens)` |
| `Giro.pas:970` `'Itens gravados no rascunho.'` | `pDetalhe(..., Result, Result)` |

O comentário de `Giro.pas:942` — "SEM total de propósito, para o consumidor não desenhar barra
parada em 0%" — continua valendo e a etapa 8 continua sendo anunciada sem total.

**2.5 `Suprimento.Services.Workers.pas`**

O callback anônimo passa a repassar os dois valores para a nova sobrecarga quando
`ANumero > 0`, e para a sobrecarga sem número quando `ANumero = 0`.

### Fase 3 — DTO de resposta (`Cotacao.Types.pas`)

`uses` ganha `MVCFramework.Nullables`.

**3.1 `TCotacaoGiroProgresso`** — sem mudança de campos. Passa a ser `nil` quando a etapa não
tem medição (RN07), em vez de instância zerada. O comentário atual da classe, que justifica
instanciar sempre, tem de ser **reescrito**, não apagado: a justificativa mudou.

**3.2 `TCotacaoGiroEtapaDTO`** — nova:

```pascal
TCotacaoGiroEtapaDTO = class
  ...
published
  property numero: NullableInt32 ...
  property totalEtapas: NullableInt32 ...
  property descricao: NullableString ...
  property progresso: TCotacaoGiroProgresso ...   // nil = etapa sem medicao
end;
```

`numero` e `totalEtapas` são `NullableInt32` e não `Integer` porque uma tarefa que rodou contra
base sem a coluna `_STATUS` (CA13) não tem sequência publicada — e `0 de 0` seria mentira.

**3.3 `TCotacaoGiroAndamento`** — remodelada:

| Propriedade | Antes | Depois |
|-------------|-------|--------|
| `status` | `String` | `String` (sem mudança — sempre presente) |
| `etapa` | `String` | `TCotacaoGiroEtapaDTO`, `nil` em `PENDENTE` |
| `progresso` | `TCotacaoGiroProgresso` na raiz | **removida da raiz**, vive dentro de `etapa` |
| `dataInicio` / `dataFim` | `String` | `NullableString` |
| `qtdItensGerados` | `Integer` | `NullableInt32` |
| `mensagem` | `String` | `NullableString` |

Destrutor libera `Fetapa` (que libera o `progresso` dele). Construtor **não** instancia `Fetapa`:
`PENDENTE` é o estado inicial e nele a etapa é `nil`.

Os atributos `MVCSwagJsonSchemaField` acompanham; o texto de cada um passa a descrever o
comportamento novo.

### Fase 4 — Montagem da resposta (`Cotacao.Consulta.pas`)

`pPreencherProgresso` deixa de mutar o andamento direto e passa a devolver o
`TCotacaoGiroEtapaDTO` lido do `SST_STATUS` — ou `nil` quando o JSON está vazio/ilegível.
Continua tolerando JSON inválido devolvendo ausência, nunca exceção (RN09).

`fConsultar` aplica as regras por status:

```
PENDENTE     -> etapa := nil;  datas/qtd/mensagem := null
PROCESSANDO  -> etapa := lida do _STATUS;  qtd/mensagem := null
CONCLUIDO    -> etapa := lida do _STATUS;
                mensagem := etapa.descricao (fallback: constante);
                etapa.descricao := null;  FreeAndNil(etapa.progresso);
                qtd := _RESULT ->> itens
ERRO         -> etapa := lida do _STATUS (descricao e progresso INTACTOS);
                mensagem := _RESULT (texto puro);  qtd := null
```

A ordem no `CONCLUIDO` importa: ler a descrição para `mensagem` **antes** de anulá-la.

O `FindField(_STATUS)` atual permanece — a coluna pode não existir em base não migrada, e
ausência significa "sem andamento publicado", não erro.

Constante de fallback da `mensagem` do `CONCLUIDO`: `'Itens gravados no rascunho.'`, o mesmo
texto que a etapa 8 publica. É fallback e não fonte primária de propósito — ler do `_STATUS`
mantém uma só origem para o texto.

### Fase 5 — Aviso nomeado (`Cotacao.Notificacao.pas`)

Novo privado `fNomeDaCotacao(const AstrSeqRascunho: String): String`:

```sql
SELECT COT_DESCRI FROM COTGER_RES WHERE AUTOINCREM = :SEQ
```

`ParamByName`, nunca concatenação. Devolve vazio em qualquer falha, registrando `WriteLog` —
falhar em ler o nome não pode custar o aviso (RN11).

`pNotificarConclusao` monta:

```pascal
if LstrNome.Trim.IsEmpty then
  { textos atuais, sem o trecho de "..." }
else
  { textos nomeados da secao 6 do spec }
```

Quatro literais, todos com acento, todos **Windows-1252** — o hook de encoding garante.

Sem transação nova: a leitura do nome acontece **antes** do `pGravar`, que já tem transação
própria (RN09 do requisito original do giro).

### Fase 6 — Build e verificação

**Build, nunca Compile.** `Services.Core.Worker.pas` e `Services.Core.Utils.pas` são
compartilhadas pelos 38 serviços através da `Services/tmp`, e `Compile` reaproveita `.dcu` de
outro projeto com defines diferentes. Registrado na memória do projeto como causa raiz de falha
já vivida.

Ordem: `SuprimentoServicesAPI` primeiro (é o alvo), depois um serviço que **não** foi tocado
mas usa a mesma infra — `FaturamentoServicesAPI` — para provar que a alteração aditiva em
`Services.Core.*` não quebrou ninguém.

---

## Decisões e o que foi descartado

| Decisão | Alternativa descartada | Por quê |
|---------|------------------------|---------|
| Catálogo fixo de 8 etapas | Contador incremental que conta também as mensagens do motor | `numero` passaria de `totalEtapas`; imprevisibilidade é o que o requisito quer eliminar |
| Total derivado de `High()` | Constante `8` escrita à mão | Etapa nova acrescentada sem atualizar o literal daria `9 de 8` calado |
| `Nullable*` do DMVCFramework | Serializador customizado registrado | `MVCSerializeNulls = True` já é o padrão e `TryNullableToJSON` já faz o trabalho; registrar serializador seria trabalho para obter o comportamento que já existe |
| Estado de sequência dentro do `TWorkerTaskProgress` | Número resolvido na `Consulta`, por lookup do texto | A `Consulta` só vê o último texto; mensagem do motor não está no catálogo e o lookup falharia justamente no caso comum |
| ~~`mensagem` do `CONCLUIDO` lida do `_STATUS`~~ — **revertida em 03/09/2026** | Constante `CGiroConcluido`, e `numero` forçado ao total | **A decisão original estava errada.** Justificava-se com "não duplicar estado", mas o `_STATUS` atrasa em relação ao `_DTAFIN` (RN13 do spec) e a leitura perde a corrida. Teste ao vivo devolveu `mensagem: "Gravando os itens no rascunho..."` e depois `numero: 7` de 8 na primeira resposta `CONCLUIDO` — exatamente a resposta que o consumidor mais vê. Nem build, nem suíte, nem leitura de código pegariam isso |
| Nome da cotação lido no `Notificacao` | Nome carregado no `pNotifyFinish` e passado por parâmetro | O `pNotifyFinish` já monta 7 argumentos; e `pNotificarConclusao` é chamado de **dois** lugares (`pNotifyFinish` e `pEncerrarOrfas`), que teriam de ler o nome cada um |
| Chaves novas omitidas quando zero no `_STATUS` | Sempre presentes | `FSATSK` e `FNATSK` usam o mesmo `fJsonAndamento` (RN08) |

## Ponto fechado — versionamento do endpoint não é necessário

A quebra de contrato do `GET` chegou a ser tratada como risco de publicação. **Resolvido em
03/09/2026:** o REPOR+ ainda está implementando a integração e não há consumidor na forma antiga
(spec §8). Não há janela de incompatibilidade, o endpoint não ganha versão e a Fase 4 fica como
está — a forma nova substitui a antiga direto.

Sem pontos abertos. O plano pode ser executado inteiro.
