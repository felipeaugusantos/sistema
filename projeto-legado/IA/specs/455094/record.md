# Req. 455094 — retrospectiva

Documento único do requisito, consolidado entre sessões. O que está aqui é a **jornada**: o que se
tentou, o que caiu, e por que as decisões ficaram como ficaram. O contrato está no `spec.md`, o
passo a passo no `plan.md`, o texto de entrega no `analysis.md`.

---

## A semana perdida, e o que a causou

Entre 08 e 14/09/2026 o requisito ficou parado numa `Access violation` no envio de e-mail a partir
do `Suprimento.Services.API` em Linux. **A causa era credencial recusada pelo Google**, e a resposta
do servidor — `Username and Password not accepted / BadCredentials` — estava na tabela `LOGERR` o
tempo todo.

O sintoma visível era uma AV. A AV é o que o Indy faz **depois** de a autenticação ser recusada. Como
ela aparecia no log da tarefa e a resposta do servidor ia para outra tabela, a investigação inteira
foi conduzida contra o sintoma.

**Sete hipóteses caíram, todas medidas:**

| Hipótese | Como caiu |
|---|---|
| Porta errada (587 vs 465) | Testadas as duas; a recusa é idêntica |
| STARTTLS vs SSL implícito | Testados os dois; a recusa é idêntica |
| Symlink `libcrypto.so.10` ausente | Criado; inerte — o binário nunca pede esse nome no `DT_NEEDED` |
| `IdOpenSSLSetLibPath` não chamado | Acrescentado; não muda nada. Revertido |
| `CFG_MODSSL` em `sslmUnassigned` | Trocado para `sslmClient`; não muda nada. Revertido |
| `CFG_TLSSSL` em versão antiga | Trocado para `sslvTLSv1_2` e depois `sslvSSLv23`; não muda nada |
| OpenSSL 1.1 incompatível com o Indy do Seattle | `ldd` mostrou que quem **falha** carrega o par 1.0 limpo e quem **funciona** está misturado |

**E uma armadilha metodológica, que é a lição principal.** O argumento que sustentou a semana era
*"o robô de gatilhos envia e-mail em Linux, então o caminho funciona"*. O fato é verdadeiro e a
inferência é falsa por dois motivos somados: o robô roda **outro binário** (a cópia dentro da
`libGatIme.so`) e **outra máquina** (`srvwebservicesbr9`, não `srvPrg1`). A comparação variava duas
coisas ao mesmo tempo e nunca controlou nenhuma.

O teste que resolveu foi trivial e demorou dez minutos: rodar o **autcom no Windows** apontado para a
**mesma base**, processando a **mesma linha** da fila. Falhou igual — o que eliminou plataforma,
OpenSSL e ambiente de uma vez, e deixou só configuração e dados.

> **Para a próxima vez:** quando "funciona ali e não aqui" for o argumento, listar **todas** as
> variáveis que diferem antes de formular hipótese. Se forem duas ou mais, a comparação não prova
> nada — e o esforço certo é construir um teste que varie uma só.

**E um viés meu que apareceu três vezes:** reportei conclusão a partir de leitura prematura. O build
da `.so` "não existia" (estava em andamento); o `LOGERR` "não tinha erro" (as linhas ainda não tinham
sido gravadas); e a partir disso afirmei que SSL implícito estourava antes de autenticar, o que era
falso. Em ambiente assíncrono, ausência de registro não é evidência — é impaciência.

---

## Por que o envio mudou de dono

A investigação expôs algo maior que o defeito: **a cotação era o único ponto do sistema que mandava
e-mail sem passar pela libGatIme**. Ao portar a tela para o serviço Linux, o envio direto veio junto,
e com ele uma pilha SMTP inteira — Indy, OpenSSL, credencial — para dentro de um serviço que nunca a
tinha exercitado.

A decisão de 14/09 foi devolver o envio à dona. As RN19 a RN24 do `spec.md` registram o contrato; o
que **não** cabia lá e fica aqui é o caminho até elas:

**A primeira proposta foi uma interface separada** (`IGatImeSincrono` + `Supports`) para detectar
`.so` desatualizada. Foi recusada com o argumento certo — *"excesso de engenharia para resolver
somente um caso; se fosse uma solução genérica eu concordaria"* — e a alternativa que saiu dali,
**versão de contrato conferida no carregamento**, é melhor: cobre método ausente, comportamento
alterado e parâmetro ressignificado, e protege os seis consumidores em vez de uma chamada.

**A trava ia se apoiar na revisão de SVN**, e não podia: o `rev.inc` da libGatIme está parado em
`456514` desde fevereiro de 2026 porque nenhum `PreBuildEvent` o regenera. Pior, revisão não serviria
nem estando fresca — ela descreve a cópia de trabalho no momento do build, não o código, e com sete
cópias do repositório uma `.so` pode ter revisão alta sem ter a mudança.

**Consertar o `rev.inc` chegou a ser planejado e foi retirado com o custo medido:** dois `.dproj`,
uma mudança de versionamento e uma dependência de build nova (`SubWCRev`) numa biblioteca de seis
consumidores, para corrigir um defeito de diagnóstico. Não compensa dentro deste requisito.

**A drenagem do robô de gatilhos** foi removida depois de uma conversa que mudou o desenho duas vezes.
A primeira recomendação minha foi devolver uma drenagem filtrada — reflexo conservador. A pergunta
*"por que ainda precisa da drenagem se agora é síncrono?"* derrubou isso: o que a drenagem
compensava era o envio adiado, e o envio deixou de ser adiado. O `DestravarFilas` do monitor, que
subia o robô só para cair naquela drenagem, saiu junto — deixando no lugar um comentário que explica
o que havia ali e em que revisão recuperá-lo.

---

## Seis defeitos encontrados ao executar, não ao ler

Todos apareceram **depois** de o caminho estar no ar, e nenhum foi pego por revisão de código:

1. **`.so` não carregada** — o passo de `pCarregaFuncoesDllGatilhoImediatos` estava escrito no plano e
   foi pulado. Sintoma: AV em `0x0` e `Runtime error 217`, processo morto.
2. **`TDllGatime.Create` sem guarda** — chamava o ponteiro de `GetProcAddress` sem conferir. Defeito
   que já existia; biblioteca ausente matava o processo em vez de degradar.
3. **Guarda de canal por "não enviado" em vez de "tem destino"** — num gatilho só de e-mail a coluna
   de WhatsApp é nula **por natureza**, então o ramo de WhatsApp rodava à toa e abortava o
   processamento antes do e-mail.
4. **Anexo chegando como `.xlsx.pdf`** — título ia com extensão e o código acrescenta outra derivada
   do tipo; e o `fGetTipoArquivo` não conhecia `.xlsx`, caindo no default `tpaPDF`. **Este trecho foi
   lido três vezes e o defeito só apareceu quando alguém abriu a caixa de entrada.**
5. **Deploy apontando para outro ramo** — o `.dproj` e o `.deployproj` buscavam a `libGatIme.so` e as
   quatro OpenSSL em `379.48.2.30.74.150_DESENV`.
6. **`tpaExcelX` alcançando `case` sem cobertura** — acrescentar valor a enum não quebra compilação.
   Foi preciso varrer à mão; o de `untThreadEnviaSMS` alcança o valor novo e foi coberto.

> O item 4 é o argumento de por que o critério 30 exige a mensagem chegando, e não se contenta com a
> linha correta na fila.

---

## Estado da base de teste — e o que a sanitização apaga

A sanitização mascara `OPE_E_MAIL` e `OPE_EMALOG` mas **não toca em `OPE_PRVSEN`**. É o inverso do
desejável: o endereço some e a senha sobrevive. Foi assim que a credencial antiga do `MC1` pôde ser
recuperada em 14/09 — e é por isso que **três** itens precisam de exceção no
`05_MASCARAR_CONTATO.sql`:

1. `OPE_E_MAIL` / `OPE_EMALOG` do operador de teste
2. `CFG_CLICHP` e `CFG_CLIPFX` da empresa 022 (bucket) — ver `c:\tmp\455094_email\03_...`
3. o endereço da conta de teste criada em 14/09

**A senha entra pela tela do autcom, nunca por SQL.** A tela codifica: 16 caracteres de senha de app
viram 19 no `OPE_PRVSEN`. Valor cru colado no banco produz senha que o próprio sistema não lê, e o
sintoma é **indistinguível** de credencial errada.

---

## 15/09 — o caso 53 reprovou três vezes, e as três valeram

O `TEST_EXPORTACAO_EMAIL_ENVIADO_01` é o único caso da suíte que exercita o caminho completo. Ele
reprovou em três rodadas seguidas, por três causas diferentes, e **nenhuma delas era ruído**.

**Primeira: a flag no arquivo errado.** O caso falhava com `Não é permitido enviar e-mail nesse banco
de dados!`. A trava lê `fArqIni(0, 'GERAL', 'FORCAR_ENVIO_EMAIL', '')`, e o ambiente de teste tem
`CONF_BD=./opcoes_teste.ini` no `opcoes.ini` — o redirecionamento faz o `fArqIni` tirar **tudo** do
arquivo apontado, inclusive a seção `[GERAL]`. A flag tinha de ir no `opcoes_teste.ini`. Na pasta da
API funcionava no `opcoes.ini` porque lá não há redirecionamento, e foi isso que me induziu ao erro.

O pré-requisito acabou no `suprimento_test_runner.sh`, que já monta o `opcoes.ini` do zero a cada
rodada — assim ele é versionado e viaja com o repositório, o que nenhum dos dois `.ini` faz.

**Segunda: uma regressão minha, de véspera.** A guarda de destino que eu acrescentei em 14/09 —
canal só roda se tiver para onde mandar — pulava a **marcação** junto com o envio. E o
`pMarcaGatImeEnviado` só fecha a linha quando os três canais têm data, então gatilho só de e-mail
ficaria em `GAT_LIBENV = 'S'` para sempre. A mensagem do teste foi exata:
`GAT_LIBENV is [S] when [N] expected`. Virou a RN26.

**Terceira: a expectativa do próprio caso.** Eu havia declarado `GAT_D_EWPP` e `GAT_D_ESMS` nulos —
escrevendo a afirmação contra o defeito, não contra o comportamento correto. Corrigido o código, o
caso passou a acusar a si mesmo.

> **A lição é sobre o que fazer quando um caso novo reprova.** Na primeira reprovação eu propus
> *simplificar o caso para não depender do envio*. Se tivesse feito isso, os três problemas teriam
> passado — inclusive a regressão, que é de código e estava a caminho de produção. Reprovação de caso
> recém-escrito parece ruído e quase nunca é; o impulso de afrouxar a afirmação é o que transforma
> teste em enfeite.

## Achados registrados, fora do escopo

- **`fGetLock` de `untFuncoesSimples`** devolve `True` sem ler o retorno do `GET_LOCK`, que é 0 no
  timeout. Usado pelo autcom para decidir qual estação responde pelo robô do SFA e na importação de
  CTe. Não corrigido porque mudaria comportamento em produção.
- **Informação de versão dos binários não é confiável**: o `rev.inc` da libGatIme parado desde
  fevereiro, e **24 dos 56** `.dproj` Linux sem `svn_rev.bat` no `PreBuildEvent` — como o
  `svn_rev.inc` é um arquivo só, compartilhado, esses 24 carregam a versão do último projeto
  compilado na máquina.
- **Configuração do provedor Gmail**: o Gmail em `587` com `PRV_SSLSAI = 'N'` usa STARTTLS e autentica; `465`
  com `'S'` usa SSL implícito. `PRV_SSLSAI` escolhe entre os dois, não liga e desliga TLS.
