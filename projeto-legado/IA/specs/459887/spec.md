# Integração contínua — substituir o TestExecute por uma CI em Python

> Requisito 459887. Levantado em 2026-08-27 sem número, sob o slug `integracao-continua`; pasta renomeada em 2026-09-02, quando o número saiu.

## Problema

O `TestExecute.exe` (Delphi, `padra_atualizado/Services/TestExecute/`) é hoje o build server do projeto: a cada 6 h ele detecta revisões novas no SVN, faz update, compila quatro `.groupproj` via `bds.exe`, empacota com WinRAR e publica em `\\10.0.0.205`, onde runners `.sh` sobem as APIs e rodam as suítes.

Quatro problemas concretos, todos observados em 2026-08-26/27:

1. **O ciclo trava e não se recupera.** Uma falha de link no `AutcomTinta` aborta a execução inteira. Faturamento, Financeiro, Suprimento e os deploys não acontecem, e ninguém é avisado.
2. **Não há retomada.** Falhou no projeto 47 de 104? A execução seguinte recomeça do 1.
3. **Tempo.** Cada etapa é precedida de `CleanTempDir`, que apaga o diretório de unidades compartilhado. Nada é reaproveitado. Um ciclo com build completo passa de duas horas — chegou a `TintaGeneral` (35º de 91) em cerca de uma hora.
4. **Trabalho duplicado.** `Shared.Functions` está nos quatro groupprojs e é recompilado do zero **quatro vezes** por ciclo; `NFe`, duas.

Não há visibilidade: o andamento vive num `TMemo` na máquina, e o `build.log` é sobrescrito a cada projeto — o log do Tintas desaparece assim que o Faturamento começa.

## O que se quer

- **Confiança:** o ciclo não para por falha isolada e recuperável.
- **Tempo:** deixar de recompilar o que não mudou.
- **Retomada:** saber até onde foi e continuar dali após a correção.
- **Controle:** escolher quais projetos compilar e em que modo.
- **Acompanhamento:** ver o andamento sem olhar a tela da máquina.
- **Linguagem:** Python, aposentando o Delphi neste papel.

## Decisões

| Decisão | Escolha | Por quê |
|---|---|---|
| Escopo | Substituir o ciclo inteiro, em fases | Meia migração deixa dois donos do mesmo processo |
| Lista de projetos | Dos `.groupproj` + `ci.ini` para ajustes | O groupproj já é mantido pelo time e carrega a ordem; projeto novo entra sozinho |
| Execução | CLI + Agendador do Windows + tela web | Sobrevive a reboot, não depende de janela aberta, cada peça testável isolada |
| Política de falha | Para na dependência, segue no resto | Uma DLL de marca não pode derrubar a noite; uma base derrubada só produziria erro em cascata |
| Ferramenta | Ferramenta própria, não CI de mercado | A parte difícil é específica (ordem, `.lnk`, deploy samba); o que o Jenkins daria de brinde é a parte fácil em Python |
| Tentativas | 2 por projeto | O erro do `.lnk` passa na segunda; mais que isso mascara problema real |
| Configuração | `.ini` via `configparser` | Biblioteca padrão, aceita comentários, e o repositório já usa `.ini` nos runners |

## Arquitetura

Em `padra_atualizado/Services/_ci/` (o underscore mantém a pasta no topo da listagem, como em `_monitor`):

```
_ci/
  ci.py       CLI e orquestracao
  projetos.py      le .groupproj + ci.ini -> lista ordenada e deduplicada
  compilador.py    invoca msbuild, interpreta exit code, aplica retry
  estado.py        grava e le o andamento
  painel.py        servidor web que le o estado
  ci.ini      modo por projeto, exclusoes, quais sao base
  execucoes/       uma execucao por arquivo + atual.json
  logs/            um log por projeto por execucao
  LEIAME.txt
```

Fluxo:

```
ci.py --ciclo
  -> projetos.py   le os 4 .groupproj (ordem e conteudo)
                   le ci.ini    (modo, exclusoes, base/folha)
                   devolve [(projeto, modo, e_base), ...] deduplicado
  -> por projeto:  compilador.py  -> msbuild -> exit code + log proprio
                   estado.py      -> grava APOS CADA PROJETO
  -> fim:          execucoes/<data>_r<rev>.json com o retrato completo

painel.py (processo separado) -> le o estado -> http://localhost:8778
```

O painel apenas **lê**. A tela nunca derruba o build, e o build não sabe que a tela existe.

## Estado e retomada

Um arquivo por execução em `execucoes/`, mais `atual.json` apontando para a corrente. Isso dá histórico sem banco: dá para responder "quando o TintaGeneral compilou pela última vez" lendo arquivos.

Gravado **após cada projeto**, para que reboot no projeto 47 não custe os 46 anteriores:

```json
{
  "inicio": "2026-08-27T15:47:03",
  "revisao": 491549,
  "gatilho": "ciclo",
  "situacao": "em_andamento",
  "projetos": [
    {"proj": "Lib/autcomtinta/Linux/AutcomTinta.dproj",
     "modo": "build", "base": true, "status": "ok",
     "segundos": 212, "tentativas": 2,
     "nota": "1a tentativa: E2597 no input files"}
  ]
}
```

Estados por projeto: `pendente`, `ok`, `falhou`, `pulado` (excluído no `.ini`), `bloqueado` (não tentado porque uma base do grupo falhou).

**A retomada avisa quando a revisão divergiu.** Se a working copy estiver à frente da execução parada, `--retomar` alerta antes de continuar: os projetos já compilados são de uma revisão e os seguintes seriam de outra.

A CI **não** faz `svn update -r` para revisão anterior. Reverter a working copy é destrutivo e afeta o trabalho de quem estiver na máquina — a decisão é do operador. Quando o aviso aparecer, as opções são fazer o update à mão (se quiser mesmo a revisão antiga) ou rodar `--ciclo`, que é o certo depois de corrigir código.

**Update para o HEAD, sim** — decisão do usuário em 2026-08-31, com conferência antes e depois. Ver a seção *SVN update* adiante.

Distinção entre os dois comandos:

- `--retomar` — nada mudou no código: falha de ambiente, máquina reiniciada, `.lnk` intermitente, execução cancelada.
- `--ciclo` — execução nova na revisão atual. **É o caminho certo depois de corrigir código**, porque a correção é uma revisão nova.

## Execução de um projeto

```
msbuild <projeto.dproj> /t:Build|/t:Make /p:Config=Release /p:Platform=Linux64
        /nologo /v:minimal /flp:LogFile=logs/<execucao>/<projeto>.log;Verbosity=normal
```

Um log **por projeto**, contra o `build.log` único e sobrescrito de hoje.

Retry de 2 tentativas. Entre elas a CI apaga o `.so` de saída, para que um artefato meio escrito não confunda a segunda. Quando a primeira falha e a segunda passa, isso fica registrado em `nota` — falha intermitente que se cura sozinha continua sendo sintoma, e desaparece do radar se ninguém anotar.

## `build` ou `make` — o cache compartilhado da `tmp`

**Decisão (2026-08-28): o padrão é `build`. `make` é exceção declarada, hoje só para o grupo `tintas`.**

Os 104 projetos gravam `.dcu`/`.o` na **mesma** `Services\tmp` e cada um compila com seus próprios defines. Um `make` reaproveita o artefato que outro projeto deixou e compila contra a interface errada.

Não é teoria. O `FinanceiroServicesAPI` falhou com `untFuncBancarias.pas(60): error E2003: Undeclared identifier: 'fGetConfigBanco'`. O fonte está correto: a função existe em `untFuncoesGenerica` sob `{$IF not Defined(LINUX) or Defined(BOLETOS)}`, e o Financeiro **define** `BOLETOS`. O que estava na `tmp` era o `untFuncoesGenerica.dcu` gerado pelo Suprimento, que compila **sem** `BOLETOS`. Mesmo projeto, mesmo fonte, em `build`: passa em 238s.

**O erro de compilação é o desfecho bom.** O ruim é o `.dcu` errado ter interface *compatível* — aí não há erro, e um trecho de código simplesmente não entra no binário, em silêncio. Foi esse risco que decidiu o padrão, não o custo do build.

Onde `make` continua valendo, e por quê:

- As **90 DLLs de tinta** compilam todas apenas com `RELEASE` — defines idênticos entre si, o cache não mente. São o grosso do ciclo, e é onde o ganho de tempo importa.
- O `AutcomTinta` acrescenta `AUTCOMTINTA`, mas esse define **não aparece em nenhum `{$IFDEF}` de `.pas`**: é inerte no fonte e não deforma os `.dcu`. Ainda assim fica em `[build]`, pelo erro de link (anexo).
- `Shared.Functions` está em `[build]` por um motivo que não é óbvio: é o **primeiro** do grupo `tintas`, e a `tmp` chega nele com o que o **último grupo do ciclo anterior** deixou. Com `make`, todo ciclo começaria sujo.

Precedência: `[build]` (projeto) > `[make]` (grupo ou projeto) > `modo_padrao`. Projeto novo entra como `build` — o padrão seguro.

Isto é o que o `CleanTempDir` do `TestExecute` existia para evitar, por outro caminho: limpar tudo entre etapas. A alternativa estrutural — **saída de `.dcu` por grupo**, editando os `.dproj` — elimina a classe inteira e liberaria `make` em todo lugar. Ficou de fora agora por exigir tocar em 104 `.dproj`; é a candidata natural se o ciclo completo se mostrar lento demais.

## Configuração de compilação — `Debug` x `Release`

**Achado em 2026-08-29, corrigido:** o `FinanceiroServicesAPI` e o `FinanceiroServicesTEST` estavam sendo **compilados e publicados em `Debug`**.

A causa é a diferença de invocação. O `TestExecute` chama `bds.exe -ns -sd "<proj>" -b` — **sem dizer qual configuração** —, então usa o padrão gravado em cada `.dproj`. Esse padrão era `Debug` nos dois projetos do Financeiro e `Release` nos de Faturamento e Suprimento. A CI, que passa `/p:Config=Release` explicitamente, produzia um binário diferente do que era publicado: 77 MB contra 325,7 MB.

Ninguém decidiu isso — alguém salvou o `.dproj` com `Debug` ativo e ficou. As consequências eram reais: os testes do Financeiro rodavam contra binário com verificação de faixa, asserções e símbolos de depuração, que **pode se comportar de forma diferente** do Release; e 325 MB atravessavam o SMB toda madrugada em vez de 77.

**Correção (decisão do usuário):** padronizar em `Release`. Alterado nos dois `.dproj`:

```xml
<Config Condition="'$(Config)'==''">Debug</Config>
->
<Config Condition="'$(Config)'==''">Release</Config>
```

Verificado: compilando **sem** `/p:Config`, o `FinanceiroServicesTEST` saiu de 88,2 MB para 26,0 MB. O `TestExecute` passa a publicar Release sem precisar de nenhuma alteração nele.

> **A próxima execução muda o binário testado.** Um teste do Financeiro que hoje passa apoiado em asserção ou verificação de faixa pode se comportar de outro jeito. Se algo quebrar no Financeiro logo após esta mudança, olhar aqui primeiro.

Consequência operacional que vale para sempre: **rodar a CI deixa binário `Release` no `bin`**. Publicar sem recompilar publica o que a CI deixou, não o que o `TestExecute` construiria.

## SVN update

**Decisão do usuário em 2026-08-31: a CI faz o update, conferindo conflitos antes de começar.** Implementado em `atualizar.py`, atrás da flag `--atualizar` — sem ela o `ci.py` não toca na working copy, porque update automático numa execução manual seria surpresa para quem está trabalhando na máquina. A flag é para o agendamento da Fase 2.

**Conferir depois é tão necessário quanto antes:** o `svn update` termina com código 0 **mesmo deixando arquivos em conflito**. Quem olhasse só o código de saída começaria a compilar em cima de fonte com marcador de conflito no meio. Usa `--accept postpone` — conflito fica marcado, nunca resolvido automaticamente; escolher um lado sozinho é pior que parar.

| Impede o update | Não impede |
|---|---|
| Arquivo já em conflito | Modificação local — o merge resolve a maioria, e o que não resolver vira conflito, que a conferência de depois pega |
| Arquivo versionado que sumiu do disco | Arquivo agendado para adição — os próprios arquivos da CI ficam em `A` por semanas |
| Caminho obstruído | |

O estado é lido de `svn status --xml`, não da saída de texto: o conflito de árvore aparece na sétima coluna do texto — posicional, frágil e variável entre versões do cliente —, enquanto no XML é atributo nomeado.

**HEAD dá no mesmo que o `update -r` do TestExecute.** Vale registrar porque a primeira versão desta seção afirmava o contrário: o `RunTests` sem argumento pega `LRevisions[High(LRevisions)]`, a revisão **mais nova** da faixa `<última testada+1>:HEAD` — não percorre uma a uma. Mesmo conteúdo em disco.

A diferença está no **número**, não no conteúdo: o `svn log` da faixa lista só revisões que tocaram aquele caminho, então a mais nova delas pode ficar abaixo do HEAD global se houver commits em outra parte do repositório. **Consequência para a Fase 4:** ao cruzar execução da CI com resultado de teste por número de revisão, os dois lados podem rotular o mesmo código com números diferentes.

`--atualizar` com `--retomar` é recusado: o `--retomar` continua na revisão da execução parada, e atualizar traria código novo, que é outra revisão.

A trava de concorrência (`trava.py`) cobre o update **e** a compilação: atualizar a working copy com outro build lendo os fontes é tão ruim quanto dois builds simultâneos.

### O update é na raiz, não na subárvore

**Descoberto em 2026-08-31, na primeira execução real.** Atualizar apenas `padra_atualizado\Services` parecia economia óbvia — é o que a CI compila. É errado, e o sintoma aparece longe da causa.

O `svn_rev.bat` roda o `SubWCRev` apontando para a **raiz** do projeto, e o `$WCRANGE$` só devolve um número único quando a cópia inteira está na mesma revisão. Misturada, devolve `min:max`. E o teste faz:

```pascal
// api.core.test.utils.pas:489
LQuery.FieldByName('test_last_revision').AsInteger := StrToIntDef(SVN_UPDATE_RANGE, 0);
```

`StrToIntDef` num intervalo devolve **zero** — e o caso perde a revisão em que passou pela última vez, que é exatamente o dado que responde *"desde quando isso está quebrado"*.

Medido: a raiz ficou em `492022:492216`, e **634 dos 638 casos** do faturamento executados naquele dia gravaram revisão 0. Na véspera, com o `TestExecute` atualizando a raiz, foram 262 casos com revisão válida e nenhum zero.

Correção: `preparar()` sobe para a raiz sozinho (`svn info` → `wcroot-abspath`) e, depois do update, roda `svnversion` e **avisa** se a cópia ficou misturada. O aviso importa tanto quanto a correção — nada impede que a mistura volte por outro caminho, e sem ele ninguém liga revisão 0 no banco a um update parcial dias antes.

## Classificação base/folha

Explícita no `ci.ini`, com comentário. Não inferida por posição.

| Base — falha para o grupo | Motivo |
|---|---|
| `Shared.Functions` | os quatro grupos dependem |
| `NFe` | Faturamento e Financeiro dependem |
| `api.rest` | Faturamento depende |
| `AutcomTinta` | compartilha units com as 89 marcas |
| `*ServicesAPI` | o `*ServicesTEST` do mesmo domínio depende |

| Folha — falha e segue | Quantidade |
|---|---|
| DLLs de marca (`TintaXxx`) | 89 |
| `*ServicesTEST` | 3 |

## Fases

**Fase 1 — compilar.** Estado, retomada, retry, deduplicação, logs por projeto. O `TestExecute` segue vivo cuidando de SVN, deploy e ciclo; a CI é chamada à mão e comparada com ele. Valida a parte difícil sem risco.

Comandos:

```
ci.py --ciclo                  compila tudo, na ordem, deduplicado
ci.py --retomar                continua a execucao parada, na revisao dela
ci.py --grupo tintas           so um grupo
ci.py --projeto AutcomTinta    so um, para investigar
ci.py --desde TintaGeneral     do projeto X em diante
```

**Fase 2 — tela e agendamento.** `painel.py` e o Agendador do Windows disparando na sessão do usuário (precisa da conta com Delphi licenciado e acesso ao compartilhamento — não SYSTEM). A CI passa a rodar sozinha.

> **O ciclo completo custa ~35 min** (medido em 2026-08-28, r491601: 104/104 ok, nenhuma segunda tentativa). Isso muda a premissa do agendamento: cabe **de hora em hora**, não só de madrugada. O gargalo são os 15 `build` — os três de API custam ~270s cada e sozinhos são metade do ciclo; as 89 tintas em `make` levam 7s cada.

**Fase 3 — SVN e deploy.** A CI detecta revisão nova, empacota (`zipfile` da biblioteca padrão, dispensando o WinRAR) e publica em `\\10.0.0.205`.

**O `TestExecute` é removido aqui** — decisão do usuário em 2026-08-28: não é só parar de usar, é apagar o projeto Delphi (`TestExecute.dpr`, `.dproj`, `.res`, `untTestExecute.pas`, `.dfm`, `Test.Utils.pas`) do SVN. Só depois de a CI estar validada rodando sozinha; a Fase 3 é o gatilho, não a Fase 1.

Duas consequências a tratar no mesmo movimento, para não ficarem órfãs:

- A pasta `Services\TestExecute\` passa a abrigar apenas `_ci` e `_monitor`, duas ferramentas Python, com o nome de um programa que não existe mais. **Renomear a pasta aqui** — é o único momento barato, porque o `svn mv` sai junto com a remoção.
- Conferir o que mais referencia o `TestExecute.exe` antes de apagar: agendamentos, atalhos, documentação da equipe e o `rev.inc`/`revision.tmpl` que hoje vivem nessa pasta.

### Empacotamento — validado em 2026-08-31

As quatro listas foram transcritas do `untTestExecute.pas` para o `deploy.ini` e conferidas contra o que está publicado: **126 de 126 arquivos idênticos**, em nome e tamanho, nos quatro pacotes. Comparação feita com `bin` e share saídos do mesmo `TestExecute` (30/08 19:46–20:05).

Comparar builds de datas diferentes **não** serve como validação: numa primeira tentativa, 61 dos 91 arquivos do `auttin` divergiam, com deltas de exatamente 4096 bytes — alinhamento de seção entre dois builds do mesmo fonte, não diferença de conteúdo. O alvo da comparação tem de ser o mesmo build.

Detalhe descoberto no caminho: **o lado Linux descompacta e apaga o `.zip`**. Não há zip publicado para comparar; o alvo são os arquivos soltos na pasta de destino.

Três peculiaridades do original, preservadas de propósito — não "corrigir":

- O `auttin.zip` vai para a pasta do **Faturamento**, não para uma de tintas.
- O Suprimento é o único que **não** leva `LogoBoletos.zip`.
- O `DeployFaturamentoTests` lista `ConsultarPagamentosPixService` duas vezes; o empacotador deduplica em silêncio.

**Divergência encontrada e resolvida na origem.** A pasta do Financeiro no share tinha `ConsultarPagamentosPixService` e `libIntegracaoPixCitel.so` atualizados a cada deploy, mas nenhum dos dois estava no `DeployFinanceiroTests` — eram publicados por fora da lista. O usuário acrescentou os dois ao `DeployFinanceiroTests` em 2026-08-31 e o `deploy.ini` acompanhou. Nova conferência: **128 de 128 idênticos**.

Vale registrar o método, porque é o que dá valor à Fase 3 antes mesmo de ela publicar: comparar o pacote que a CI *montaria* com o que está publicado revela o que o processo atual faz sem estar escrito. Aqui a correção certa foi no `TestExecute`, não no `deploy.ini` — alinhar a origem em vez de replicar o desvio.

**Fase 4 — acompanhar os testes.** Integrar o `_monitor` existente: compilação e resultado das suítes na mesma linha do tempo, ligados pela revisão.

> **Fases 2 e 4 unificadas — decisão do usuário em 2026-08-31.** Não haverá `painel.py` separado: o `_monitor`, que já está no ar em 8777 e já tem servidor, CSS e layout de cards, ganhou uma seção de compilação. Duas telas contariam metade da história cada uma.
>
> **Frequência do agendamento: a cada 6 horas**, o mesmo ritmo do `TestExecute` hoje (`IncMinute(..., 360)`). Com 35 min de ciclo sobra folga larga, e ninguém precisa reaprender o ritmo.
>
> O painel lê os `execucoes\*.json` **importando `estado` e `andamento` da própria CI**, em vez de reimplementar o formato — uma fonte de verdade só. Acoplamento de mão única e somente leitura. A leitura concorrente é segura porque `estado.gravar` usa `os.replace`, que é atômico.
>
> **A seção de compilação não depende do banco.** Vem de arquivo local, então quando o MySQL cai a página perde os testes mas continua mostrando o build. Verificado simulando a queda: o placar `104/104` aparece junto com o aviso de banco fora do ar.

## Fora de escopo

Deliberadamente ausentes, por não atenderem nenhuma dor levantada:

- Notificação por e-mail ou Teams
- Autenticação na tela
- Gráficos históricos
- **Paralelismo (`msbuild /m`)** — enquanto o diretório de unidades for compartilhado, compilar em paralelo é pedir para reencontrar contaminação cruzada. Só faz sentido depois de isolar a saída por projeto.

## Critérios de aceitação — Fase 1

1. Compila os 104 projetos distintos na ordem declarada pelos groupprojs, sem repetir `Shared.Functions` nem `NFe`.
2. Estado gravado após cada projeto; matar o processo no meio e rodar `--retomar` continua do projeto seguinte, sem refazer os anteriores.
3. Falha em projeto folha marca e continua; falha em projeto base interrompe o grupo e segue para o próximo.
4. Cada projeto tem log próprio, preservado ao fim da execução.
5. Falha na primeira tentativa e sucesso na segunda ficam registrados em `nota`.
6. `--retomar` avisa quando a revisão do SVN está à frente da execução parada.
7. `--projeto` e `--grupo` compilam apenas o alvo, sem tocar no estado da execução em andamento.

## Anexo — o erro de link intermitente

Investigado nesta sessão e **ainda sem correção**. A CI convive com ele via retry; a causa raiz é trabalho separado.

**Sintoma:** `[DCC Error] E2597 ld-linux.exe: fatal error: no input files`, seguido de `F2588 Linker error code: 1`, no `AutcomTinta`. Some ao recompilar.

**O que está confirmado:** o `dcclinux64` passa a lista de objetos ao `ld` por arquivo de resposta — `@..\..\..\bin\auttin\AutcomTinta.lnk` (a linha de comando do linker está nos logs do MSBuild). O erro "no input files" significa que o `ld` processou esse `@arquivo` e terminou sem nenhum objeto de entrada.

Capturado em build **bem-sucedido** (2026-08-27, 11:33): o arquivo é criado com 60.964 bytes, consumido pelo linker e apagado pelo compilador ao terminar — 18 segundos de vida.

**O que NÃO está confirmado, ao contrário do que esta seção afirmou até 2026-08-28:** que o `.lnk` esteja *ausente* no momento da falha. Isso nunca foi observado — foi inferido do texto do erro. Ausente, vazio, ou presente citando `.o` que sumiram são três causas diferentes, todas compatíveis com "no input files", e a segunda tentativa apaga o rastro antes de qualquer um poder olhar. **Nenhuma hipótese nova deve ser formulada antes de capturar uma falha real.**

**Hipóteses descartadas nesta investigação:**

- *Modo make não gera os `.o`* — refutada: numa falha com `-B`, 309 `.o` foram gerados, incluindo `AutcomTinta.o`, e o link falhou mesmo assim.
- *Resíduo no `tmp` compartilhado* — o teste com `tmp` vazio pareceu confirmar, mas mudou duas variáveis ao mesmo tempo (grupo x projeto isolado). Não se sustenta.
- *Estado da instância do `bds.exe`* — refutada: o MSBuild, sem IDE, reproduz o mesmo erro.
- *Arquivos travados abortando o `CleanTempDir`* — refutada: teste de lock em amostra deu zero travados, e a limpeza manual de 2248 arquivos não teve nenhuma falha.

- *Interferência do antivírus por causa da extensão `.lnk`* — refutada em 2026-08-28. A máquina é protegida pelo **Bitdefender Endpoint Security 8.26** (o Defender está parado). Teste: 600 gravações de 60 KB na própria `Services\bin\auttin`, alternando `.lnk` e `.txt` para que variação de carga atingisse as duas igualmente, medindo a leitura logo após fechar a escrita. Resultado: **zero falhas nas duas**, com latências indistinguíveis (`.lnk` p95 = 0,58 ms contra `.txt` p95 = 0,63 ms). Nenhuma menção à árvore de build nos logs do Bitdefender.

  *Ressalva:* o teste grava e lê no mesmo processo, e o caso real é entre processos (`dcclinux64` grava, `ld-linux.exe` lê). O que ele refuta é o motivo de suspeitar do `.lnk` — tratamento especial da extensão —, não toda forma concebível de interferência.

### Causa provável encontrada em 2026-08-31 — o inchaço da `tmp`

Depois de cinco hipóteses refutadas, a sexta veio de medição, não de raciocínio.

| `.o` na `Services\tmp` | Tentativas | Resultado |
|---|---|---|
| 309 (27/08) | — | passou |
| 1.470 (28/08) | — | passou |
| **2.255** (31/08) | **4 seguidas** | **falhou todas** |
| **0** (após limpeza) | 1 | **ok em 57s** |

O erro havia **deixado de ser intermitente**: quatro tentativas consecutivas falharam com 4.408 arquivos na pasta (614 MB). Apagados todos, o mesmo projeto linkou de primeira. O limiar está entre 1.470 e 2.255.

**O que isso explica**, e nada antes explicava: por que o `CleanTempDir` do `TestExecute` "resolvia" sem ninguém entender o mecanismo; por que "compilar de novo" às vezes funcionava — dependia de ter havido limpeza no intervalo; por que piorava com o tempo, já que os 104 projetos despejam na mesma pasta; e por que atingia justamente o `AutcomTinta`, maior consumidor do `tmp` e primeiro `build` do ciclo.

**Ressalvas honestas.** Um sucesso isolado contra um bug historicamente intermitente não é prova definitiva — a força do resultado vem de suceder imediatamente após quatro falhas seguidas. E **o mecanismo continua desconhecido**: sabe-se que correlaciona, não *por quê*.

**Limitação da instrumentação, descoberta no mesmo dia:** o retrato forense é tirado *depois* que o MSBuild termina, e num build bem-sucedido o `.lnk` também é apagado ao final. Então `response file: AUSENTE` no retrato **não distingue** "nunca foi criado" de "foi criado, usado e limpo". Fechar o mecanismo exige observar a pasta *durante* o link.

**Correção estrutural indicada:** saída de `.dcu` por grupo nos `.dproj` — elimina a classe inteira, e é a mesma correção que resolveria o cache envenenado. Continua pendente.

**Paliativo implementado no mesmo dia** — `_ci\limpeza.py`, ligado por `[geral] limpar_tmp = ciclo` no `ci.ini`:

- apaga os artefatos da `tmp` no início de **todo ciclo cheio**, e o custo é baixo porque o padrão já é `build`, que recompila tudo de qualquer forma. Quem paga é o grupo em `[make]`: as 90 tintas fazem uma compilação cheia na primeira vez de cada ciclo;
- **não roda em compilação avulsa** (`--projeto`, `--grupo`, `--desde`) — quem usa esses filtros está investigando, e apagar a `tmp` apagaria justamente a evidência. **Nem em `--retomar`**, que continua na mesma revisão e deve aproveitar o que já compilou;
- apaga **por lista de extensão** (`.o .dcu .dcuil .rsm .drc .map .lnk`), nunca a pasta inteira: o que não for artefato de build fica, e a CI diz o que ficou. Arquivo travado por outro processo é reportado e a faxina segue — parar por causa de um handle aberto trocaria um problema raro por um frequente;
- desligada (`--sem-faxina` ou `limpar_tmp` fora de `ciclo`), a CI ainda **avisa** ao passar de `aviso_tmp` arquivos `.o`, com o número medido na mensagem.

Coberto por 17 testes em `testes\test_limpeza.py` e 6 em `test_ci.py`, todos em pasta temporária.

**Instrumentação instalada (2026-08-28)** — `compilador.capturar_forense`. A cada tentativa que falha, a CI grava `logs\<projeto>.falha<N>.txt` com o estado naquele instante: se o `.lnk` existia e com que tamanho, quantos `.o` ele cita que não estão em disco, e quantos `.o`/`.dcu` havia no `tmp` compartilhado; e preserva uma cópia do próprio `.lnk` quando ele existe. Custo zero quando o build passa. Os três finais possíveis distinguem as três causas listadas acima — a próxima ocorrência decide qual é.

**Correção paliativa já aplicada** em `untTestExecute.pas`, ainda não commitada: `try/except` por arquivo no `CleanTempDir`, para que um arquivo problemático não aborte a limpeza inteira em silêncio.
