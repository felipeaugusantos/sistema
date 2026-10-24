# Depurar Access Violation em serviço Delphi/Linux

Método para achar a origem de um AV nos serviços Linux. Escrito depois de duas investigações — um
`SIGSEGV` no `GatilhosInformacao` em 10/09/2026 e o robô de PIX em 22/09/2026 —, as duas terminando
na mesma causa: variável local de tipo classe que o compilador não inicializa.

Leia o **Princípio** e o **Passo 0** antes de qualquer outra coisa. Eles decidem se você gasta vinte
minutos ou dois dias.

## O princípio

A pergunta não é *"como resolvo este endereço"*. É *"qual ferramenta responde este crash"*.

Endereço resolvido diz **onde** o processo parou. Não diz **por quê**. Na classe de bug mais comum em
Delphi — ponteiro não inicializado, uso após free — **não há nada de errado com o endereço**: o
programa saltou exatamente para onde o lixo mandou. Resolver o endereço entrega o sintoma e esconde a
causa.

## O sintoma e por que ele engana

O que chega ao log é isto:

```
Exception EAccessViolation in module <unknown> at 0000000000000000.
Access violation at address 0000000000000000, accessing address 0000000000000000.
Runtime error 217 at 000000000047E154
```

Não tem unit, não tem linha, e o `Runtime error 217` é o mesmo endereço para qualquer exceção não
tratada — não é diagnóstico. Pior: **a ordem das linhas no arquivo não é a ordem causal**. Em Delphi o
`finally` roda durante o desempilhamento, então operações de limpeza aparecem *antes* da linha do erro.
Ver um `DELETE` de lock imediatamente acima do AV não significa que o lock causou nada.

### Sintomas que enganam

Boa parte do que chama a atenção no log é consequência, e virar fio condutor custa horas:

| No log | O que realmente é |
|---|---|
| `accessing address 0000000000000018` com `AllocateRaiseFrame` / `_RaiseAtExcept` na pilha | RTL falhando ao montar o frame da exceção. **Consequência, nunca causa** |
| `Runtime error 217` repetido N vezes | exceção dentro do handler de exceção — cascata |
| `Runtime error 231` | exceção não tratada — diz que morreu, não por quê |
| `module <unknown> at 0000000000000000` | chamada indireta por ponteiro nulo |
| `address` igual ao `accessing address` | falha no fetch da instrução — saltou para não-código |
| endereço fora de `.text`, em `.data.rel.ro` | saltou para dentro de VMT/RTTI — ponteiro de classe inválido |

### Onde o processo estava executando

| Endereço de execução | Significa |
|---|---|
| `0000000000000000` | executando **no** endereço zero — salto para ponteiro de função nulo |
| `0x00007Fxxxxxxxxxx` | dentro de uma biblioteca compartilhada, região de `mmap` |
| baixo (`0x4xxxxx`, `0x1xxxxxx`) | dentro do próprio executável |

E o `accessing address` é o que foi desreferenciado. **Os dois zeros juntos discriminam a causa**, e
isso decide o que caçar:

| `at` | `accessing` | Causa |
|---|---|---|
| `0` | `0` | ponteiro de **função** nulo — variável procedural de `GetProcAddress` que voltou nil |
| dentro do chamador | `0` | método chamado sobre **interface ou objeto** nil |

No primeiro caso o salto é para lugar nenhum e não há o que procurar no fonte do chamador: procure quem
deveria ter preenchido o ponteiro — inclusive fora do código, ver a armadilha do `.deployproj`. No
segundo, o fonte do chamador é exatamente onde olhar.

## A pergunta que mais economiza tempo: "mas funciona no Windows"

Quando a rotina roda no autcom há anos e dá AV no Linux, o instinto é acusar a plataforma. É o instinto
errado, e ele custa horas.

A regra da linguagem é a mesma nos dois lados: **o compilador Delphi nunca inicializa variável local de
tipo classe, em nenhuma plataforma.** Só zera tipos gerenciados — `string`, interface, array dinâmico,
variant. O que muda é a chance de o defeito se manifestar:

> **32 bits não inicializa com nil.** Se o bug "só aparece em 64 bits", ele está **latente** em 32, não
> ausente: frames menores deixam aquela posição de pilha zerada com mais frequência. Qualquer mudança
> em função chamada antes desloca o resíduo e o AV aparece — longe da alteração.

É isso que explica o "funciona há anos e quebrou agora sem ninguém mexer nessa rotina". Ninguém mexeu
nela; mexeram em quem roda antes.

Somado a isto: o projeto não liga `{$R+}` nem `{$Q+}`, então não há rede em runtime; e no Windows o
madExcept ainda reportava no ponto do erro, enquanto no Linux o `SIGSEGV` chega cru e tarde.

A frase a guardar: **"funciona no Windows" não é evidência de que a rotina está correta.** É o ambiente
onde ela tem maior chance de parecer correta.

## Passo 0 — dá para rodar valgrind no host? (obrigatório)

**Faça esta pergunta antes de abrir binário, antes de ler fonte, antes de resolver endereço.**

```
         Tenho acesso ao host Linux?
              /              \
           sim                nao
            |                  |
      CAMINHO A           CAMINHO B
      valgrind            so o log
   (resolve na 1a         (escada de
    execucao)              diagnostico)
```

Não pule porque "o log já tem os endereços". Ter endereço não é motivo para resolver endereço. Em
22/09/2026 esta pergunta não foi feita, e ela valia a investigação inteira: quando finalmente rodou, o
valgrind deu a causa na primeira execução.

## Caminho A — `valgrind`

É o que fecha o caso de variável não inicializada, porque acusa **a leitura** do lixo, no ponto em que
ela acontece. O gdb mostra onde o processo caiu, que costuma ser longe: o AV estoura no `Locate`, e o
defeito foi o `Assigned` lá atrás.

```sh
valgrind ./<Servico> <os mesmos parametros do monitor>
```

Sem argumento nenhum já serve — o `memcheck` é o padrão. Em log grande, vale acrescentar:

```sh
valgrind --leak-check=no --error-limit=no ./<Servico> <parametros> 2>&1 | tee vg.log
```

`--leak-check=no` cala o relatório de vazamento, que aqui é ruído; `--error-limit=no` impede o valgrind
de parar após 1000 erros. Mesmo cuidado do Caminho B: `cd` na pasta da versão, porque os caminhos
relativos continuam valendo.

**Pré-requisito: executável e `.so` compilados em Debug.** Aqui a exigência é mais dura que a do gdb —
no backtrace dá para trabalhar com meia pilha resolvida; no valgrind, sem símbolo na biblioteca o
relatório aponta para a `.so` e não para a linha, que é justamente o que se foi buscar.

**Regra de ouro: a PRIMEIRA mensagem em ordem cronológica é a causa.** Todo AV, `Runtime error` e
mensagem de valgrind que vem depois é cascata. Ler o log de trás para frente inverte o diagnóstico.

| Procure | Significa |
|---|---|
| `Conditional jump ... depends on uninitialised value(s)` | variável lida antes de receber valor — **comece por aqui** |
| `Use of uninitialised value of size 8` | ponteiro não inicializado |
| `Invalid read/write of size N` | acesso fora de bloco válido |
| `Address ... is N bytes inside a block of size M free'd` | uso após free — traz as duas pilhas |
| `Address ... is on thread N's stack` | saltou para a pilha, executando dados |
| `Unrecognised instruction` / SIGILL | confirma execução de não-código |

Filtro quando o log é enorme:

```sh
grep -nE 'Invalid (read|write|free)|uninitialised|Mismatched|is on thread|Process terminating' vg.log
```

Custo: o programa roda ordens de grandeza mais devagar. Em processo de vida curta — o filho lançado
pelo monitor — não atrapalha; num serviço de vida longa, atrapalha.

## Caminho B — só o log

Do passo mais barato ao mais caro.

### 1. Ler o log do filho, não o do monitor

O monitor e o filho escrevem em arquivos diferentes. A saída agregada do monitor mostra o AV mas não o
que veio antes. O arquivo do filho fica no diretório por cliente e por execução:

```
/ServicosCitel/<Servico>/logs/<SERVIDOR>/<AAAAMMDD_HHMMSS>_<empresa>.log
```

O próprio monitor loga a linha de comando exata com que lançou o filho — é de lá que se copia para
reproduzir à mão:

```sh
grep INICIANDO logs/monitor_AAAAMMDD.log | grep <CLIENTE> | tail -1
```

Rodar o filho à mão a partir dessa linha, **de dentro da pasta da versão dele** (o `cd` importa: ele
resolve `.fr3`, `.png`, `libmysqlclient.so` e `opcoes.ini` por caminho relativo).

**Nas Services API o formato é outro**, e o sintoma externo esconde o AV por completo:

```
{"classname":"Exception","message":"Connection Closed Gracefully."}   HTTP 500
```

Isso é o **worker filho morrendo no meio da tarefa** — a mensagem descreve só a conexão do pai com o
filho caindo. O log a ler é o do worker, no diretório de deploy:

```
logs/TWorkersManager.<empresa>.worker.<porta>.log
```

O `<Servico>.00.dmvcframework.log` registra a exceção do pai e não ajuda.

### 2. `--logssql`

Mostra cada SQL preparada. Serve para dois fins: saber onde o fluxo parou, e — mais útil — saber que
ele **não** chegou a lugar nenhum. Ausência de SQL numa janela de tempo é informação.

Duas conclusões fáceis e erradas para evitar:

- **Se a DLL abrisse a própria conexão**, o log do executável não mostraria as queries dela. Nos
  `Services` isso não acontece porque a `.so` reaproveita o `objConnectionsManager` já criado, e o hook
  do trace faz `WriteLog(sql, True)` com `AForceLog = True` — `Writeln` incondicional no stdout
  compartilhado. Confirmar isso **antes** de descartar o silêncio como cegueira de instrumentação.
- **A flag pode não ter chegado ao filho.** Nos workers o `--logssql` não era herdado: os dois pontos
  de spawn em `Services.Core.Worker.pas` repassavam só `--logsactive`. Foi corrigido, mas confira.

### 3. Procurar handler cego por `IFDEF`

Antes de partir para o gdb, vale grepar o caminho por `except` que só fala no Windows:

```pascal
Except
  On E: Exception Do
  Begin
  {$IFNDEF LINUX}
    pMensagensErro(E.Message, '[...]');
  {$ENDIF LINUX}
  End;                    { no Linux: bloco vazio, engole e devolve nil }
End;
```

Esse padrão transforma uma exceção com mensagem num `Result` não atribuído, e o AV aparece depois, longe
da causa. Achar um desses e fazê-lo gravar pode encerrar a investigação sem debugger.

Saber **para onde** cada handler grava é parte do método:

| Rotina | Destino |
|---|---|
| `WriteLog` / `WriteError` | stdout do processo, e o arquivo de `--output` se houver |
| `pGravarErro` | tabela `LOGERR` do banco do cliente |
| `pLog` do monitor | `logs/monitor_AAAAMMDD.log` |

Um caminho onde **nenhum** desses falou é caminho sem handler — e isso já localiza o trecho.

### 4. `gdb` com backtrace

```sh
gdb -batch -ex run -ex bt --args ./<Servico> <os mesmos parametros do monitor>
```

Funciona em processo de vida curta, que é onde `/proc/<pid>/maps` não dá tempo. A profundidade da pilha
sozinha já elimina hipóteses: seis quadros dentro da `.so` descartam "falhou ao carregar" e "estourou ao
liberar a interface" de uma vez.

Ruído esperado, que não é problema:

- `Unable to init server: Could not connect: Connection refused` — GTK não achando display. Aparece em
  toda execução headless, inclusive nas que funcionam.
- `Detaching after vfork from child process` — o serviço faz `ShellExecute`.
- `Missing separate debuginfo for libcrypto.so / libssl.so` — não é preciso instalar.

### 5. Símbolos: só a configuração Debug emite

Se o backtrace vem com `??`, o binário não tem tabela de símbolo:

```sh
file libGatIme.so
```

| Saída | Consequência |
|---|---|
| `with debug_info, not stripped` | resolve até `arquivo.pas:linha` |
| `not stripped` sem `debug_info` | só nome de função |
| `stripped` | **pare** — nada resolve, peça rebuild |

Cuidado: `pyelftools` reporta `has_dwarf_info() == True` só por causa de `.eh_frame`. Confirme que existe
seção `.debug_info` de verdade antes de prometer linha.

Isso é **configuração de build, não deploy**. Nos `.dproj`:

```xml
<!-- Cfg_1 = Debug -->
<DCC_DebugInfoInExe>true</DCC_DebugInfoInExe>
<DCC_Optimize>false</DCC_Optimize>

<!-- Cfg_2 = Release -->
<DCC_DebugInformation>0</DCC_DebugInformation>
<DCC_LocalDebugSymbols>false</DCC_LocalDebugSymbols>
```

É o `DCC_DebugInfoInExe` que põe DWARF no binário.

Pela IDE: Project Options → Building → Delphi Compiler → Compiling → Debug information `True`, Local
symbols `True`, Optimization `False`; Linking → Include remote debug symbols `True`.

Use **Build**, não Compile — `Services/tmp` é cache de `.dcu`/`.o` compartilhado entre projetos, e a
unit alterada pode não entrar.

Compilar **só o projeto que contém o trecho suspeito**, plataforma Linux64. O executável e a `.so` são
projetos separados: dá para ter símbolo num e não no outro, e a pilha resolve pela metade. Devolver o
binário de Release à produção depois.

| Situação | Modo |
|---|---|
| O diagnóstico é uma linha de log que você acrescentou | **Release** — a linha sai igual, e o binário validado é o que fica |
| O diagnóstico é o backtrace | **Debug**, só no projeto do trecho suspeito |
| O diagnóstico é o `valgrind` | **Debug** no executável **e** na `.so` — sem os dois o relatório não chega à linha |

Debug desliga otimização e muda o leiaute da pilha. Em bug de memória não inicializada isso pode fazer o
AV mudar de lugar ou desaparecer — o que também é informação, mas não conclui nada.

### 6. Resolver o endereço no ELF

Só quando não há host para rodar valgrind nem gdb. A bifurcação que decide se dá para resolver:

| `file` diz | Tipo | Endereço do log |
|---|---|---|
| `LSB executable` | ET_EXEC, não-PIE, base fixa `0x400000` | **resolve direto**, sem base |
| `LSB shared object` | ET_DYN, `mmap` com ASLR | precisa da base de carga |

Regra prática: valor baixo (`0000000001A2B3C4`) é executável, resolve já. Valor `0x00007Fxx…` é `.so`.

A base da `.so` muda a cada execução. Capture **na mesma execução, antes do crash**:

```sh
grep -i <nomelib> /proc/$(pgrep -f <robo>)/maps | head -1
```

A primeira coluna da primeira linha é a base. Depois, `offset = endereco_do_log - base`. Alternativa:
rodar com ASLR desligado, `setarch -R ./<robo>`.

**Não tente adivinhar a base.** Varrer bases page-alinhadas validando contra `.symtab` não discrimina:
medido em `libIntegracaoPixCitel.so` (40314 funções, `.text` denso) deu **2042 candidatas**, e entre elas
sempre há alguma com nome sugestivo. Isso não é evidência — é ruído com aparência de achado.

Dois endereços do mesmo log ajudam a confirmar que são do mesmo módulo, não a achar a base: a diferença
entre eles e os 12 bits baixos são invariantes sob ASLR. Se dois logs distintos mostram a mesma diferença
e os mesmos 12 bits baixos, **é o mesmo ponto de código na mesma build** — útil para provar que um
rebuild não entrou no binário.

A leitura do ELF se faz com `pyelftools`, sem precisar de WSL, objdump ou binutils. O
`resolver_enderecos.py` ao lado deste documento faz o essencial — símbolo mais próximo, offset,
e `arquivo.pas:linha` pelo DWARF:

```sh
uv run --quiet --with pyelftools python resolver_enderecos.py <binario> 0xADDR1 0xADDR2 ...
```

Ele recebe o endereço **já relativo ao arquivo** — para `.so`, subtraia a base de carga antes.
O aviso `(FORA do tamanho do símbolo)` na saída é o que mais vale: significa que o endereço não
está dentro daquela função, e sim em terra de ninguém depois dela. É o sinal de VMT, PLT ou dados,
e manda seguir para a análise de seção abaixo, que o script não faz.

**Endereço fora de `.text` não é beco sem saída.** Descubra a seção e o símbolo de dados que o contém:

| Seção | Significa |
|---|---|
| `.data.rel.ro` | VMT / RTTI. Símbolo `_ZTVN...E` = vtable daquela classe — **dá o nome da classe envolvida** |
| `PT_LOAD` com `flags=6` (RW, sem X) | o processo tentou **executar dados** |
| `.text` sem símbolo próximo | PLT trampoline ou código inline |

Slots de VMT aparecem **zerados** no arquivo: são preenchidos por relocação no load. Para ver o alvo real,
procure em `.rela.dyn` a entrada com `r_offset == endereco_do_slot` e leia `r_addend`. Slot sem relocação
é genuinamente nulo.

Interpretação dos símbolos:

| Prefixo | Origem |
|---|---|
| `Sysinit::`, `System::` | RTL Delphi |
| `_ZTVN4Data2Db...E` | vtable de classe `Data.DB` |
| `Crhttp::`, `Crvio::` | UniDAC / Devart |
| `__init_record_<Unit>` | lista as units linkadas, em ordem de inicialização |

Limitações: função inline pode apontar para o caller; com `-O2`/`-O3` a linha não bate; binário acima de
500 MB demora a parsear.

## Antes de ler qualquer `.pas`: confirme QUAL cópia

Este projeto tem units homônimas em várias árvores — `untFuncoesSimples.pas` existe em **oito** lugares,
com código diferente. Ler a cópia errada produz a conclusão "o código está correto" e manda a
investigação inteira para o buraco. Aconteceu em 22/09/2026 e custou horas: a cópia lida tinha a mesma
função declarada como `IQuery` — interface, que o compilador zera —, portanto sem o defeito.

**Fonte de verdade: a cláusula `uses` do `.dpr`.**

```sh
grep -i "<nomedaunit>" <projeto>.dpr
```

**O DWARF não serve para isso.** O Delphi grava só o basename em `DW_AT_name`, e `DW_AT_comp_dir` é `"."`.

Depois de achar a cópia certa, confira se as outras têm o mesmo defeito — costuma ser sistêmico.

## O padrão de bug: variável não inicializada

É a causa mais frequente de AV que aparece **só no Linux**. O gatilho é sempre o mesmo — `Assigned` sobre
variável de tipo classe que nunca foi atribuída lê o que sobrou na pilha —, mas o estrago depende de
**onde o `Assigned` está**, e são três formatos.

### Formato 1 — `Assigned` guardando o `Free`

```pascal
var
  objAlgum: TAlgumaClasse;      { local, sem inicializacao }
begin
  try
    if not fCondicao then
      Exit;                     { pula a atribuicao }
    ...
    objAlgum := fCria(...);     { unica atribuicao, depois do Exit }
  finally
    if Assigned(objAlgum) then  { le lixo de pilha }
      FreeAndNil(objAlgum);     { Free em endereco invalido }
  end;
end;
```

Quebra na limpeza. Pior que o AV: rodar o **destrutor** sobre lixo é corrupção de heap silenciosa, que
pode não crashar na hora e estragar outra coisa depois.

### Formato 2 — `Assigned` guardando a **criação**

Mais traiçoeiro: o código **acredita que já criou** e usa o lixo como se fosse objeto vivo.

```pascal
if not Assigned(qryGenReq) then   { lixo <> nil -> pula a criacao }
  qryGenReq := fCriaQuery;        { nunca executa }
...
qryGenReq.Locate(...)             { chamada sobre ponteiro invalido -> salta para a pilha }
```

Caso real: `fVerificaIntegridade` em `untFuncoesSimples.pas`, corrigido em 22/09/2026 (Req. 463542,
r496327) com `qryGenReq := Nil;` no início do corpo, antes do `Try`.

### Formato 3 — variável no escopo pai, `Assigned` em rotina aninhada

O agravante do caso acima, e o que o torna invisível:

```pascal
function <pai>
  var qryGenReq: TUniQuery;                    { declarada AQUI }
    function fRequeridoNatTabDel               { aninhada }
      if not Assigned(qryGenReq) then ...      { lida AQUI }
  begin
    qryGenReq := Nil;                          { o conserto vai AQUI }
```

Declaração, leitura e conserto em três lugares distintos da mesma unit. Qualquer varredura ancorada em
"local declarada na mesma rotina do `Assigned`" erra por construção, e o `{$WARN}` de variável
possivelmente não inicializada também não pega, porque a variável é do escopo externo.

E há um segundo defeito embutido: quando a rotina aninhada **nunca é chamada**, o `finally` do pai roda
`FreeAndNil` sobre o lixo assim mesmo. No caso do PIX isso acontecia em **toda exclusão de registro**.

### Checklist de ponteiro lixo

Crash errático, ou salto para endereço sem sentido? Cheque **nesta ordem**, antes de qualquer teoria
elaborada:

1. Variável local de tipo classe usada com `Assigned` sem `:= nil` antes.
2. `FreeAndNil(X)` em `finally` sobre variável que pode nunca ter sido atribuída.
3. Objeto liberado em módulo diferente do que alocou — exe e `.so` têm heaps separados.

**Sinal barato:** o mesmo trecho com a variável declarada como **interface** (`IQuery`) não tem o defeito,
porque interface o compilador zera. Se duas cópias da unit divergem só nisso, achou.

### O que a varredura alcança

O conserto é sempre **inicializar com `nil` no começo da rotina que declara**. O `if Assigned` fica
redundante no formato 1 — `FreeAndNil(nil)` é seguro —, mas mantê-lo não custa.

Medido em 23/09/2026 sobre as units que compilam para Linux:

```
blocos  try ... finally  com  if Assigned(X) then Free(X)                586
destes, com a atribuicao alcancavel so depois de um Exit                  35   em 22 units
"if not Assigned(X) then X := ..." sobre local da propria rotina           1
```

Os 35 são triagem por expressão regular, não defeito confirmado. E o `1` do formato 2 **não significa que
só existe um** — significa que a busca não alcança o formato 3, que é onde o caso real estava. Para os
formatos 2 e 3 não há substituto para ler a rotina.

**Unit compartilhada é por cópia, não por referência.** O conserto do `qryGenReq` teve de ir para oito
cópias do `untFuncoesSimples.pas` — `fontes/genericos`, `Monitors/Shared`, `Monitors/MonitorPitStop`,
`Services/consumoRestApi/Target/Windows`, `iMendesIntegra`, mais as dos externals `Autcomtinta`, `Auttin`
e `IntegracaoPixCitel`. Consertar num lugar só deixa sete vivos.

## Armadilhas que custam tempo

**O ponteiro nil pode vir de falha de deploy, não de código.** Em 15/09/2026 o AV em `untRelFrx.pas:116`
tinha `fRetornaNomeTinta` nil porque `auttin/` nunca havia sido incluída no `.deployproj` do serviço — a
biblioteca não chegava ao servidor, o `GetProcAddress` devolvia nil e o salto ia para `0x0`. O código
estava correto. Ao achar ponteiro de `GetProcAddress` nil, conferir **antes** se o arquivo está lá e se o
`.deployproj` o leva. A guarda `if Assigned(<ponteiro>)` com log continua valendo, porque transforma um AV
mudo numa linha que nomeia o que faltou.

**`SIGSEGV` não roda `finally`.** Sinal mata o processo sem desempilhar, então nada que dependa de
`finally` acontece: lock não é solto, arquivo temporário não é apagado, conexão não é fechada. Um AV numa
rotina que roda sob lock deixa o lock preso — e o próximo ciclo pode sair calado por não conseguir
adquiri-lo. **O primeiro sintoma que se investiga costuma ser esse efeito colateral, não a causa.**

**Endereço ímpar em `Self` é lixo, não objeto.** Objeto Delphi nunca fica em endereço não alinhado. Um
`Self=0x7fffce182715` num `TObject.Free` significa que se está liberando um ponteiro que nunca foi objeto.

**ASLR muda o endereço entre execuções.** `0x7FE45300…` numa rodada e `0x7FA29EFE…` na seguinte é a mesma
falha em base diferente. Comparar endereços absolutos de rodadas distintas não diz nada.

**`strings` não acha literal de Delphi.** `string` é `UnicodeString`, gravada em UTF-16 no binário. O
`strings` padrão varre ASCII de 8 bits e pula bytes intercalados com zero. Precisa de `-el`:

```sh
strings -el libGatIme.so | grep -c 'meu literal novo'
```

É o jeito de confirmar que o binário em produção contém a edição que você acabou de fazer. Sempre com um
literal de controle que já existia antes, para não confundir "não achei" com "método errado".

**E `strings` pode simplesmente não existir na máquina.** Nas estações Windows daqui ele não está no PATH,
e o erro não é óbvio: o comando falha e o pipe devolve zero, que se lê como "o literal não está no
binário". Sem literal de controle, a conclusão errada passa. Alternativa sem depender de binutils:

```python
alvo = open('libGatIme.so', 'rb').read()
print(alvo.count('meu literal novo'.encode('utf-16-le')))
```

## Red flags — pare e volte ao Passo 0

- "O log já tem os endereços, vou resolver" → perguntou do valgrind?
- "Achei um símbolo que faz sentido entre os candidatos de base" → coincidência
- "Li a unit e o código está correto" → conferiu no `.dpr` se é essa a cópia linkada?
- "O `0x18` é o fio condutor" → é o RTL, veja a tabela de sintomas que enganam
- "Vou instrumentar para descobrir onde" → instrumentar é para **confirmar**, não para descobrir
- "Funciona no Windows, o problema é o Linux" → 32 bits esconde, não corrige

## Checklist

1. **Passo 0:** dá para rodar `valgrind` no host? Se sim, pare de ler e rode.
2. A rotina funciona no Windows? Então suspeite de variável não inicializada antes da plataforma.
3. Antes de ler `.pas`: confirmar **qual cópia** da unit está linkada, pelo `uses` do `.dpr`.
4. Log do **filho**, não do monitor. Nas Services API, `"Connection Closed Gracefully."` é o filho
   morrendo — ler `logs/TWorkersManager.<empresa>.worker.<porta>.log`.
5. Reproduzir à mão, com `cd` na pasta da versão, `--logsactive --logssql`.
6. Antes de concluir "não fez nada": confirmar que o hook de SQL alcança o trecho e que a flag foi
   herdada pelo filho.
7. Grepar o caminho por `except` cego em `{$IFNDEF LINUX}`. Fazer falar.
8. Descobrir para onde cada handler grava, e olhar todos — stdout, `LOGERR`, log do monitor.
9. `gdb -batch -ex run -ex bt`. A profundidade da pilha já descarta hipóteses.
10. `??` na pilha → `file` no binário → recompilar **só aquele projeto** em Debug, com **Build**.
11. `at 0` **e** `accessing 0` → ponteiro de função nulo. Conferir o `.deployproj` antes do fonte.
12. Resolver endereço no ELF só em último caso — e **nunca** adivinhando a base da `.so`.
13. Ao validar a edição em produção: `strings -el`, com literal de controle — e conferir que o `strings`
    existe na máquina.
14. Depois de cada AV, conferir lock preso — o `finally` não rodou.
