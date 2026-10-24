# Perfilar serviço Delphi/Linux — achar gargalo sem adivinhar

Vale para qualquer serviço em `/ServicosCitel/` — Faturamento Automático, gatilhos, PIX,
fulfillment. O método não é específico de rotina: hoje é um robô, amanhã é outro.

Script pronto: [`perfilar.sh`](perfilar.sh) — `./perfilar.sh FaturamentoAutomatico 30`.
Ele faz o que está descrito abaixo e **recusa** rodar quando alguma pré-condição falha.

---

## 1. A pergunta que vem antes de todas

**O processo está queimando CPU ou está esperando?**

Errar isso custa dias. `perf` só enxerga quem está *em CPU*: uma thread parada 15 segundos
num timeout de conexão simplesmente não aparece no perfil. Perfilar um processo que está
bloqueado devolve um relatório bonito e irrelevante.

A triagem é barata — amostrar o tempo de CPU do processo, um segundo por vez:

```bash
PID=$(pgrep -f NomeDoServico | head -1)
prev=$(awk '{print $14+$15}' /proc/$PID/stat)
for i in $(seq 60); do sleep 1
  cur=$(awk '{print $14+$15}' /proc/$PID/stat); echo "$(date +%T) cpu=+$((cur-prev))"; prev=$cur
done
```

O valor é em *ticks* por segundo. `getconf CLK_TCK` dá quantos ticks valem um segundo de CPU —
normalmente 100. Então:

| Leitura | Significa |
|---|---|
| `+100` sustentado | um núcleo inteiro ocupado — **caminho CPU** |
| `+200`, `+400` | duas, quatro threads em CPU |
| `+0` a `+20` | está **esperando** — caminho espera |

> No `/proc/PID/stat` os campos 14 e 15 são `utime` e `stime`. O campo 2 é o nome do
> executável e **pode conter espaço e parênteses**, o que quebra a contagem por `awk`. O
> script corta até o último `)` antes de contar; no comando manual acima isso não morde
> porque os nomes dos serviços não têm espaço.

---

## 2. Pré-requisito: o binário precisa ter símbolos

Perfil de binário *stripped* sai só com endereços hexadecimais e não serve para nada.

```bash
file /proc/$PID/exe
```

Tem que aparecer `not stripped`, e de preferência `with debug_info`. Isso é decisão de
**build**, não de investigação: se produção sobe sem símbolos, quando o problema aparecer
não vai dar para investigar. Ou se mantém os símbolos no binário, ou se arquiva a cópia
não-stripped de cada release.

Se só tiver endereço na mão e nenhum símbolo, existe a skill `delphi-av-analyze`, que resolve
endereço → `arquivo.pas:linha` a partir do DWARF. Mas é remendo; o certo é ter símbolo.

---

## 3. As três armadilhas — todas já custaram tempo aqui

### 3.1 O binário em memória não é o do disco

```bash
file /proc/$PID/exe    # NAO pode dizer "(deleted)"
```

Quando aparece `(deleted)`, o arquivo foi substituído e o processo continua rodando o
anterior. Já se concluiu que uma correção "não teve efeito" medindo o binário velho.
**Depois de subir, matar o processo ocioso** para o supervisor recarregar.

### 3.2 Poucas amostras não é perfil

O cabeçalho do relatório traz a linha `# Samples:`. A conta:

```
amostras esperadas = frequência × duração × fração do tempo em CPU
```

A 99 Hz por 30 s, um processo ocupado dá ~3.000 amostras. **149 amostras** significa que ele
esteve em CPU 1,5 s dos 30 — e um perfil montado sobre isso descreve o nada. Já foi lido como
"o gargalo sumiu".

Confira `# Samples:` **antes** de interpretar qualquer percentual.

### 3.3 Ausência de dado não é evidência

Tabela vazia em `performance_schema` pode significar "não houve erro" ou "a instrumentação
está desligada" — e as duas se parecem. Vale para SYN descartado por fila de listen cheia:
o servidor não conta o que nunca chegou até ele. Antes de concluir "está tudo limpo",
confirme que o contador estava mesmo ligado.

---

## 4. Caminho CPU — o perfil

```bash
perf record -F 99 -g -p $PID -o /tmp/perf.data -- sleep 30

# onde esta a CPU, sem acumular filhos
perf report -i /tmp/perf.data --stdio --no-children --sort symbol -g none

# quem chama a funcao mais cara
perf report -i /tmp/perf.data --stdio --no-children -S <simbolo> -g graph,0.5,caller
```

`--no-children` é importante: sem ele, tudo aparece pendurado em `main` e o relatório não
distingue quem gasta de quem apenas chama.

Se o call graph sair truncado ou vazio, o binário provavelmente foi compilado sem frame
pointer. Alternativa: `--call-graph dwarf` no `record` — mais pesado, mas reconstrói a pilha
pelo DWARF.

### Como ler — a lição que quase passou batido

Percentual de função não é percentual de causa. Exemplo real desta base:

```
16.30%  u_strFromUTF8WithSub_60          <- conversao UTF-8 -> UTF-16 (ICU)
 16.17%  |
   2.35%  --System::Utf8ToUnicode -> InternalGetPropInfo -> FindPropInfo
     1.48%    --GetPropValue <- fMontaServicos <- pDesmembrarMatrizItens
```

A leitura errada é "ICU está a 16%, e ICU é a busca RTTI por nome, logo o gargalo é RTTI".

A leitura certa: **dos 16,30 pontos, só 2,35 passam por RTTI.** Os outros ~13,8% têm outro
dono, que nem aparece nesse recorte porque a árvore só expandiu um ramo.

**Regra:** ao olhar um ramo, some os percentuais dos filhos e compare com o total do pai. Se
não fecharem, existe chamador fora do recorte — e ele pode ser o verdadeiro dono. Rode o
`-S <simbolo> -g graph,0.5,caller` sobre a função cara para ver **todos** os chamadores, não
um ramo só.

---

## 5. Caminho espera — quem está bloqueado, e em quê

```bash
for t in /proc/$PID/task/*; do
  echo "$(basename $t)  $(cat $t/wchan 2>/dev/null)"
done
```

| `wchan` | Leitura |
|---|---|
| `futex_wait_queue_me` | esperando lock ou outra thread |
| `hrtimer_nanosleep` | `Sleep()` no código |
| `sk_wait_data`, `poll_schedule_timeout` | esperando banco ou rede responder |
| vazio / `0` | está rodando — não deveria cair aqui |

Espera de banco pede as ferramentas do banco: `sys.innodb_lock_waits`,
`performance_schema.data_locks`, `SHOW GLOBAL STATUS LIKE 'Connections'` em duas leituras
espaçadas para ter taxa. E do lado do sistema, `ss -ltn` e
`netstat -s | grep -Ei 'listen|overflow|SYN'` — fila de listen cheia derruba SYN sem o MySQL
tomar conhecimento.

---

## 6. A terceira fonte: as mensagens do próprio log

`perf` responde *onde foi a CPU*. `wchan` responde *em que está bloqueado*. Nenhum dos dois
responde **onde foi o relógio** — e essa costuma ser a primeira pergunta.

Quem responde isso é a linha do tempo do próprio log: as mensagens `Aguarde...`, emitidas por
`pInfoStatusGravacao`, com o carimbo de hora que toda linha já carrega. Subtraindo horários
consecutivos aparece o buraco.

Isso é permanente e não custa nada. Quando um trecho longo não tem mensagem nenhuma no meio,
**a correção é acrescentar mensagem ali**, com texto de gente — não criar contador, cronômetro
ou mecanismo de instrumentação novo. Foi assim que se localizaram quatro buracos de ~2,5 s na
gravação da venda.

Regra prática: buraco de mais de ~1 s entre duas mensagens é lugar que pede mensagem no meio.

---

## 7. Ordem de trabalho

1. Triar: CPU ou espera? (`/proc/PID/stat`)
2. Conferir o binário: `(deleted)`? sem símbolo?
3. Se CPU → `perf`, conferindo `# Samples:` antes de ler percentual
4. Se espera → `wchan` + ferramentas de banco/rede
5. Em qualquer caso → linha do tempo dos `Aguarde...` para saber *entre quais etapas*
6. Só então formular hipótese — e anotar junto o comando que a sustenta

O passo 6 é o que separa investigação de palpite. O padrão de erro mais caro registrado aqui
foi *pegar um sinal parcial e construir uma história em volta dele*.

---

## Origem

Método extraído da investigação de lentidão do Faturamento Automático (04-05/09/2026), cujo
registro completo — com o que foi medido, as hipóteses refutadas e por quê — está em
`IA/specs/lentidao-faturamento-automatico/record.md`.
