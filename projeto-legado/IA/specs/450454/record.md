# Req. 450454 — Etiqueta de Despacho Unificada (EDUNIF)

**Chave:** `450454` — requisito original da EDUNIF, commitado em `r484839` (20/07/2026).
A pasta `IA/specs/450454/` só foi criada em 25/09/2026, na sessão da variante A5 da Shopee;
não existe registro escrito do desenvolvimento original.

---

## 25/09/2026 — Shopee passou a mandar folha A5 em `^GFA`

### Sintoma

Cliente **VIPASA** (`VIPASA_PROD_CLOUD_BR36`, `10.0.1.221:60369`, schema `AUTCOM`), ao imprimir
etiqueta unificada de um pedido Shopee, recebia:

```
FALHA NO PROCESSADOR DO MARKETPLACE
O processador do marketplace SHP_ nao conseguiu unificar a etiqueta (retornou vazio).
Verifique o arquivo ZPL original e o BMP da DANFE.
```

Amostra:
`padra_atualizado\MarketPlace\260925044E7E6P\Etiqueta de envio.txt` (117.723 bytes).

### Causa

`TProcessadorShopee.fProcessar` chamava **só** `TCodecZ64.fExtrairBitmap`, que exige `~DGR:` e
`:Z64:`. O arquivo não tem nenhum dos dois — tem um único `^GFA,249270,249270,210`. O extrator
saía no primeiro `Pos`, `fProcessar` devolvia `''`, e o orquestrador
(`Marketplace.EtiquetaDespachoUnificada.pas:166`) exibia a caixa acima.

As duas validações anteriores do orquestrador (`NFE_LAYUNI` configurado e BMP da DANFE gerado)
haviam passado — por isso a mensagem foi a do processador e não outra. Isso é diagnóstico útil:
**qual** das mensagens aparece já localiza o estágio.

### O que a amostra revelou

Decodificando o `^GFA` (script Python descartável, ver *Metodologia* abaixo):

| | Variante conhecida | Variante nova |
|---|---|---|
| Codificação | `~DGR:...:Z64:` (deflate + base64) | `^GFA` (hex + RLE) |
| Dimensão | 816 × 1218 retrato | **1680 × 1187 paisagem** = A5 a 8 dpmm |
| DANFE embutida | rodapé, a partir de Y≈1006 | **coluna direita**, x=838..1677 |

O layout novo é de duas colunas: à esquerda a etiqueta do carrier (destinatário, QR, código de
rota `BA2-2`/`LBA-27`, coleta, remetente) e à direita uma DANFE simplificada completa e legível.
A coluna esquerda ainda traz, no rodapé, o mesmo bloco *DANFE SIMPLIFICADO – ETIQUETA*
redundante da variante antiga.

Medidas da amostra, todas confirmadas por varredura de pixel:

- borda esquerda da caixa da DANFE: **x=838** (traço vertical contínuo de 588 px)
- traço vertical mais longo da coluna da etiqueta: **129 px** (a caixa preta do código de rota)
- régua horizontal que fecha a etiqueta: **y=1002..1006**, 830 de 830 px escuros
- conteúdo útil da coluna esquerda: x=0..829, y=2..1141

### Hipótese descartada

A primeira leitura foi *"é só trocar o codec"*. Não é. As constantes da unit foram calibradas no
formato retrato: `LINHAS_INFERIORES_A_CORTAR = 212` corta o rodapé de um bitmap de 1218 linhas e
aqui não removeria nada de útil, e espremer 1680 px em 800 é 48% em X — o comentário do
`CodecGFA` já registra que 65% destrói logo e texto. Trocar só o extrator entregaria uma etiqueta
ilegível em vez de uma mensagem de erro, o que é pior.

### Caminho descartado (pode voltar à mesa)

A Shopee **já entrega** etiqueta + DANFE simplificada legível na mesma folha A5. Se o cliente
imprimir em A5, a EDUNIF não tem o que acrescentar nesse marketplace e o trabalho todo fica
desnecessário. Ficou descartado porque a VIPASA imprime em **4×6 perfurado** — decisão do João
em 25/09/2026. Se outro cliente Shopee aparecer imprimindo A5, reabrir.

### Decisão de projeto

Duas variantes dentro do mesmo `TProcessadorShopee` — o registry é `prefixo → factory`, um por
prefixo, então `SHP_` continua com um processador só.

**Discriminação por codificação, não por dimensão.** Tenta `TCodecZ64`; se não decodificar, tenta
`TCodecGFA`; se nenhum dos dois, devolve vazio como antes. É o sinal mais barato e não depende de
nenhuma medida. O caminho Z64 em produção não foi tocado — o corpo antigo virou
`pRecortarVarianteRetrato`, com a constante 212 intacta.

**Recorte por conteúdo, não por constante.** Esta é a decisão que importa e a que não deve ser
desfeita: a Shopee já mudou o layout uma vez sem avisar, e medida gravada no fonte envelhece na
próxima. As duas regras são frações da dimensão, não posições:

| Regra | Limiar | Nesta amostra |
|---|---|---|
| Coluna da borda da DANFE | 1ª coluna após 40% da largura com traço vertical contínuo ≥ 40% da altura | x=838 → recorta em 832 (byte) |
| Régua do rodapé | última linha do terço inferior com ≥ 95% da largura escura | y=1002 |

O limiar de 40% fica no meio de uma separação de 4,5× entre sinal (588) e ruído (129).

**Ordem importa, e é armadilha.** O recorte lateral vem **antes** do vertical: a régua do rodapé
tem a largura da coluna da etiqueta, não a da folha. Medida nos 1680 px inteiros ela dá 49% e não
alcança o limiar de 95% — passaria despercebida.

**Degradar para "não corta".** Cada regra devolve zero quando não acha o que procura, e aí o
recorte correspondente não acontece. Errar para menos deixa a etiqueta feia; errar para mais
decepa informação do carrier.

**Gate de paisagem.** O recorte lateral só roda quando `Width > Height`. Um `^GFA` em retrato
seria um terceiro layout ainda não visto, e nele a coluna direita não existe.

### Resultado simulado

`1680×1187` → recorte `832×1002` → `pCompactarWhitespace(6)` remove 105 linhas → `832×897` →
NN para `800×600`. Fatores: **96,2% em X, 66,9% em Y**. Inspeção visual do resultado: texto,
QR e Code128 legíveis.

**Risco não resolvido:** a distorção de proporção é de 1,44:1, então os módulos do QR saem
retangulares. Os leitores costumam tolerar, mas isso **só se confirma com bipagem real**. Se
reprovar, a saída é preservar a proporção — aplicar 66,9% também em X (832 → 557 px, centrado
nos 800), trocando margem branca por módulo quadrado. É mudança de uma conta, não de arquitetura.

### Mensagem de erro

O relato chegou como "não unificou" e a investigação começou do zero. A mensagem do orquestrador
passou a listar quais marcadores de bitmap existem no ZPL (`~DGR`, `:Z64:`, `^GFA`), o caminho do
arquivo e o do BMP. Da próxima vez que a Shopee — ou qualquer outro — trocar a codificação, o
primeiro print de tela já diz o que mudou.

### Comentários corrigidos

- Cabeçalho de `...Shopee.pas` afirmava *"Shopee entrega bitmap opaco (formato Z64 dentro de
  ~DG)"* — virou meia verdade e foi reescrito com as duas variantes.
- `...IProcessador.pas` documentava `fPrecisaDanfe` como *"False se já vem embutida (Shopee -
  bitmap opaco)"*. Era **falso**: `TProcessadorShopee.fPrecisaDanfe` retorna `True`, assim como
  MercadoLivre e TikTok. Nenhum implementador devolve `False` hoje.

### Estado da entrega

Compilado e executado em 25/09/2026 contra a amostra 260925044E7E6P. O autcom gerou
`Etiqueta de envio.unificada.txt` (16.534 bytes, contra 117.723 do original).

Conferência do ZPL gerado, decodificando os dois Z64 de volta:

| | Esperado | Gerado |
|---|---|---|
| Folha | `^PW800` `^LL1200` | confere |
| `MKT.GRF` | 800 × 600 | 60.000 bytes / 100 bpr = 800 × 600 |
| `DANFE.GRF` | 800 × 575 | 57.500 bytes / 100 bpr = 800 × 575 |
| Âncoras | `^FO0,0` e `^FO0,620` | conferem |

O bitmap do marketplace gerado pelo Delphi diverge da simulação Python em 4,2% dos pixels, mas a
**tinta total difere só 0,48%** e nenhum deslocamento global de ±1 px melhora o alinhamento: é
jitter de arredondamento nas bordas do texto, porque o NN do `fRedimensionarBits` e o do PIL
escolhem o pixel de origem de forma diferente. Não é perda de conteúdo.

**Medida que ninguém tinha feito:** a DANFE que o NFeImpressao renderiza para esta empresa sai
**799 × 575**, e o espaço entre `^FO0,620` e `^LL1200` é de 580 dots. Cabe com **5 dots de
folga**. Nenhum processador redimensiona a DANFE — se o layout `NFE_LAYUNI` de algum cliente for
um pouco mais alto, ela é cortada pela impressora em silêncio, sem mensagem nenhuma. Vale uma
validação explícita se aparecer relato de DANFE truncada.

**Impresso e bipado em 25/09/2026: leitura de QR e Code128 100% funcional.** Era o único risco
que a conferência de arquivo não cobria — os módulos saem retangulares por causa da distorção de
1,44:1 (96,2% em X contra 66,9% em Y), e os leitores toleraram.

Fica registrado o plano B, caso uma variante futura comprima mais e reprove na bipagem:
preservar a proporção aplicando o fator de Y também em X (832 → 557 px, centrado nos 800),
trocando margem branca por módulo quadrado. É mudança de uma conta em `pRedimensionarBitmapNN`,
não de arquitetura. **Não foi preciso** nesta variante.

Só existe **uma** amostra da variante A5. Se houver uma terceira em circulação, ela não está
coberta — mas agora falha com mensagem que identifica o formato.

### Porte para as outras versões (25/09/2026)

| Cópia | Revisão |
|---|---|
| `379.48.2.30.74.150` | r496872 |
| `379.48.2.30.74.150.45` | r496880 |
| `379.48.2.30.74.150.100` | r496881 |
| `379.48.2.30.74.111` | r496882 |
| `379.48.2.30.74.150.45.68` | r496883 |

Nas quatro portadas o diff do orquestrador ficou idêntico ao do `150` (+22 −1), e
`Shopee.pas` / `IProcessador.pas` são byte a byte o mesmo arquivo.

**O token do DelphAI não é reaproveitável entre commits.** A primeira tentativa de commitar o
`150.45` com o texto do r496872 foi barrada pelo pre-commit: *"Token expirado (272 segundos
atras). Realize um novo code review."* A validade é de ordem de minutos, então reusar mensagem de
commit anterior nunca passa — o gate exige revisão fresca por commit, independentemente do ramo.
Os quatro acima só entraram porque o hook foi liberado pontualmente. O payload do token, aliás,
carrega o **URL do ramo** revisado (base64 com usuário, URL, GUID da sessão, timestamp e
requisito), então um token do `150` também descreveria o ramo errado nas outras.

A mensagem foi reaplicada byte a byte via `svn commit --encoding UTF-8 -F`, inclusive o **BOM
literal** (`U+FEFF`) que o DelphAI grava antes de `Req. 450454` — é o `?` que aparece no
`svn log`. O `-F` preserva o BOM, verificado comparando os cinco `<msg>` do `svn log --xml`.

**Os dois primeiros copiam-se inteiros; o orquestrador não.** Ele divergiu entre as cópias, e o
que há nelas e não há no `150` são correções que valem para cá:

| Cópia | Tem que o `150` não tem |
|---|---|
| `150.100` | `try/finally` que apaga o BMP temporário — sem isso `%TEMP%\autcom` acumula ~100 KB por pedido |
| `150.45`, `150.45.68` | lê e grava o ZPL em `TEncoding.UTF8` pareado com o `^CI28`, em vez de ANSI |
| `111`, `150.45`, `150.45.68` | chamam `pMensagensErro`; o `150` chama `pMensagemErro` |

Copiar o orquestrador inteiro apagaria as duas primeiras. A região que a correção toca — da
chamada `fProcessar` até o `Exit` — é byte a byte igual em todas, então os dois hunks aplicam
limpos; é assim que tem de ser feito da próxima vez.

**Armadilha que custou uma rodada:** o hunk da declaração usava `intTamLayoutUnif: Integer;` como
âncora de fim mas substituía só a linha anterior, então a original sobrava e a declaração saía
**duplicada** — Delphi recusa com *identifier redeclared*. Não apareceu em nenhuma verificação de
conteúdo, porque as duas linhas são idênticas e a região comparada batia. Apareceu no **tamanho do
diff**: +23 em vez dos +22 do `150`. Comparar a contagem do diff contra a referência é o que pegou.

**Fora do porte:** `111.173` não tem EDUNIF nenhuma — zero units, zero entradas no `autcom.dpr`,
zero chamadas em `untMarketPlace.pas`. É ramo fechado (r487275) e ali não é aplicar correção, é
portar a feature inteira. `150_DESENV` e `150_TEST` têm a feature e ficaram intactas.

### 26/09/2026 — ML e Shopee retrato quebrados no `150.45` e `150.45.68`

Relato: no cliente rodando `150.45.68` a unificação falhava; no `74.150` a mesma operação
funcionava. Amostra `2609274XGTSHDJ`.

**A mensagem de diagnóstico criada no dia anterior resolveu o caso sozinha.** Ela dizia
*"Bitmaps encontrados no ZPL: `:Z64:`"* — sem listar `~DGR`. Mas o arquivo começa, no byte 0, com
`~DGR:DEMO.GRF,124236,102,:Z64:`. Se `:Z64:` é achado e `~DGR:` não, a string lida não é o
arquivo: faltam os primeiros bytes.

**Causa:** `TFile.ReadAllText(..., TEncoding.UTF8)` descarta os **3 bytes iniciais** (tamanho do
preâmbulo UTF-8) mesmo quando não há BOM. Sobra `R:DEMO.GRF,...`, `TCodecZ64.fExtrairBitmap` sai
no `Pos('~DGR:') = 0` e `fProcessar` devolve vazio. `TEncoding.ANSI` tem preâmbulo vazio — daí o
`150` nunca ter falhado. `Shopee.pas` e `CodecZ64.pas` são byte a byte idênticos nas duas cópias;
a única diferença funcional eram as duas linhas de encoding.

**Por que passou na validação de 25/09.** A variante A5 começa com `^XA^GFA,`; perder o `^XA` é
inofensivo, porque o processador remonta o ZPL do zero e só precisa de `^GFA,`. Era a única
amostra testada. As outras quatro — dois ML e dois Shopee retrato — começam com `~DGR:` e todas
morriam.

| Amostra | Início | Perdendo 3 bytes |
|---|---|---|
| `260716RJVT9Y7Y` (ML) | `~DGR:D` | falha |
| `2607180KQWTEW6` (ML) | `~DGR:D` | falha |
| `26092624MREVKC` | `~DGR:D` | falha |
| `2609274XGTSHDJ` | `~DGR:D` | falha |
| `260925044E7E6P` (A5) | `^XA^GF` | passa |

**Correção:** as duas linhas de volta para `TEncoding.ANSI` em `150.45` e `150.45.68`, com
comentário nomeando a armadilha. A varredura cobriu só as cópias locais e concluiu que nenhuma
outra usava UTF-8 — **errado**: em 15/10 o `150.45.66`, `.67`, `.69`, `.70` e `.71` ainda tinham
UTF-8 (ver a seção de 15/10). O padrão não aparece em outro ponto da pasta `MarketPlace`. Na gravação valia o espelho do
problema: `WriteAllText` com UTF-8 emite o BOM antes do `^XA`.

**Erro de método, que é o que vale registrar.** Em 25/09 a divergência ANSI/UTF-8 foi analisada e
arquivada como "latente, não consertar". A análise de que o ANSI não corrompe acento estava
certa — mas a pergunta foi feita pela metade: avaliei o que adotar UTF-8 *traria* e nunca o que
ele já *custava* nas cópias que o usavam. A evidência de que o UTF-8 não comprava nada (amostras
ASCII puro, sem `^FD`) estava na mão e deveria ter puxado a pergunta inversa.

### Arquivos

```
padra_atualizado/fontes/MarketPlace/EtiquetaDespachoUnificada/
  Marketplace.EtiquetaDespachoUnificada.Shopee.pas        reescrita (164 → 387 linhas)
  Marketplace.EtiquetaDespachoUnificada.pas               mensagem de falha com diagnóstico
  Marketplace.EtiquetaDespachoUnificada.IProcessador.pas  comentário de fPrecisaDanfe corrigido
```

Nada no `.dpr`, nada no registry, nada no `ParserZPL`. Removida a constante morta
`DANFE_ALTURA_MAX`, que nunca foi usada.

### Metodologia

Decodificar o ZPL em Python (Pillow) e comparar com a API do Labelary é muito mais rápido que
rebuildar o autcom para cada hipótese — ver a memória `metodologia-debug-codec-zpl-python-labelary`.
Nesta sessão o decodificador de `^GFA` e a simulação do pipeline inteiro (recorte → compactação →
NN) rodaram antes de escrever uma linha de Pascal, e os números bateram exatamente com o que o
Delphi deve produzir. Os scripts são descartáveis e não foram versionados.

Detalhe do RLE que continua valendo: linha cheia **auto-termina** sem `,`/`!`/`:` explícito —
memória `zpl-gfa-rle-auto-terminate`.

### Pendência de organização

A pasta foi criada como `450454` porque é o requisito original da EDUNIF. Se o cliente abriu
número novo para esta falha, renomear — e aí `450454` vira a mãe e esta passa a `<novo>`, com a
convenção `-B` reservada para continuação de requisito que tenha pasta própria (ver
`456948-B` e `460534-B`).

---

## 06/10/2026 — VIPASA: DANFE da etiqueta cortava itens

Alteração **de configuração do cliente**, não de código: o `IMPNFE.NFE_LAYUNI` da VIPASA. Nada
foi commitado.

### Sintoma

Relato de que "só cabem 3 itens" na DANFE da etiqueta unificada. Na amostra (NF 1.240.312,
empresa 001, pedido `MLB_SHML48151040194`) a nota tem **5 itens** e a etiqueta mostrava 4 — o
quinto sumia sem aviso. O rodapé também já cortava a última linha do DIFAL.

### Causa

O layout é uma página FastReport de **100 × 72 mm de altura fixa** (`PaperHeight=72`), que a 8
dpmm dá os 800 × 576 dots medidos em 25/09. O que não cabe na página vai para uma página 2 que a
etiqueta não usa. Orçamento vertical, em unidades do FR:

| Banda | Altura |
|---|---|
| Cabeçalho (número/série, chave, barcode) | 64,3 |
| Emitente/destinatário (`CEmitente`, esticável) | 67,4 |
| Rodapé "DADOS ADICIONAIS" (`memObs` = OBS inteiro) | 85,7 |
| Sobra para itens (12,0 cada) | ≈ 55 → 4 itens |

O rodapé imprime `<InformacoesAdicionais."OBS">`, que é `infAdFisco` + `infCpl`: vendedor,
digitador, cond. pag., pedido e-commerce, forma de pagamento, CBS/IBS, IBPT e DIFAL.

### Decisão

A cliente aceitou (via Patricia, 06/10) **deixar só o número do pedido do e-commerce**. Resolvido
inteiramente no layout, sem release:

- rodapé de 85,7 para 13,2; sai o título; uma linha em negrito com traço superior;
- `memObsOnBeforePrint` no script do FR3 recorta de `PEDIDO E-COMMERCE:` até quebra de linha, `;`,
  `|` ou espaço. **Sem o rótulo, imprime o OBS inteiro** — errar mostrando a mais, nunca sumir com
  o pedido.

Teto novo: ≈ 127 de área de itens → **10 itens**. Nota com 11 ou mais continua perdendo os
excedentes **em silêncio** — limitação aberta; o aviso "+N itens" foi oferecido e não feito.

O rótulo `PEDIDO E-COMMERCE:` é o mesmo nas notas Shopee (`SHP_...`), conferido nas NFs 1.244.896 e
1.244.900; o layout é um só para todos os marketplaces.

**Armadilha de leitura:** o XML guardado em `XMLNFE` **não** tem separador entre os blocos do
`infCpl` (`...HUBPEDIDO E-COMMERCE: MLB_...CARTAOVlr.CBS...`), mas o OBS que chega ao FastReport
tem quebra de linha. Por isso o recorte funciona. Quem for analisar pelo XML vai achar que não
funcionaria.

### Verificação

Executado no autcom local apontado para a base da VIPASA, NF **1.244.200** (8 itens, pedido
`MLB_SHML48185638532`): saíram os 8 itens e só `PEDIDO E-COMMERCE: MLB_SHML48185638532` no
rodapé. Conferido pelo PNG gerado, **não** por etiqueta impressa e bipada — a parte do marketplace
não mudou.

A NF 1.240.312 não serviu para o teste: a reimpressão não gera a pasta, provavelmente porque o ML
não fornece mais a etiqueta de envio já despachado (hipótese, o erro do hub não foi lido). Detalhe:
no ML aquele pedido é **um** item ("Kit 5 Brocas"), desmembrado em 5 na nota.

### Estado

| Empresa | Layout |
|---|---|
| 001 | novo, testado na NF 1.244.200 |
| 002, 003 | novo, importado em 06/10 — não testado por etiqueta |

Conferido no banco após a importação: as três com `NFE_LAYUNI` de 9.706 bytes e MD5 `8239a4c2…`,
demais colunas iguais ao backup, 21 linhas na tabela.

Backup do cliente: tabela `IMPNFE_BKP_20261006` (21 linhas, assinatura de todas as colunas igual
à `IMPNFE` antes da troca). Os dois layouts estão versionados ao lado deste arquivo, em
`vipasa-layuni/`: `layuni_vipasa_pedido.fr3` (novo, MD5 `8239a4c2…`) e `layuni_vipasa_original.fr3`
(MD5 `5ff1517e…`, o das três empresas antes da troca). Os `.fr3` guardam os bytes exatos do banco:
o script original tem `Saída` em cp1252 dentro de um XML que se declara UTF-8 — não regravar por
editor.

A pasta da etiqueta é `MarketPlace\<FGO_NUMPOK sem prefixo>` **ao lado do `autcom.exe` que
baixou** — não existe em outra estação.

---

## 15/10/2026 — COLOMARTI: o mesmo UTF-8, num ramo que a correção não alcançou

### Sintoma

Cliente **COLOMARTI** (`COLOMARTI_PROD_CLOUD_BR34`, `10.0.1.2:60469`, schema `AUTCOM`), empresa
002, ao imprimir etiqueta Shopee: *"O processador do marketplace SHP_ nao conseguiu unificar a
etiqueta (retornou vazio). Verifique o arquivo ZPL original e o BMP da DANFE."* A atendente
(Patricia) relatou que na 003 não acontecia.

A mensagem é a **antiga**, sem a lista de bitmaps — sinal de ramo anterior a 25/09.

### Causa

O título da janela trazia o build `492597`. Na `LOGACE` (`LOG_VERSVN`) ele é o **`150.45.66`**,
rodado de `C:\Autcom_Colomarti_Homologacao\`; a outra pasta do cliente,
`C:\Autcom_Colomarti\`, roda o `111.186`. Nesse ramo o orquestrador lia e gravava o ZPL com
`TEncoding.UTF8` — a mesma armadilha de 26/09, que só tinha sido corrigida no `150.45` e no
`150.45.68` (r497108). A etiqueta Shopee da COLOMARTI é Z64 retrato (`~DGR:` no byte 0, 816 × 1218),
então perdia os 3 bytes e o extrator desistia.

**Corrigido no r500259** (Req. 450454): merge do r497108 no `150.45.66`, sem conflito.

### Por que a 003 não falhava — não era versão

A primeira hipótese foi versão diferente por empresa. Cruzando `MNUACE` (menus *Expedição* e
*Etiquetas > Despacho de Mercadorias*) com `LOGACE` pelo `CON_ID`, nos 7 dias anteriores: a 003
abre o `150.45.66` **mais** que a 002 (1.259 acessos na Expedição contra 211). O que protege a 003 é
a configuração — `CFG_EDUNIF` = `TIKTOK_`, sem `SHP_`; a Shopee nem passa pelo processador. A 001
tem `CFG_EDUNIF` vazio e roda quase só o `111.186`.

Na hora da investigação o `CFG_EDUNIF` da 002 já estava **vazio** e o `CFGSIS_LOG` não tinha
registro da mudança: foi desligado para destravar a operação. Quem testar com a config vazia não
passa pela unificação — o fluxo vai direto ao aviso de fila de impressão e parece que "funcionou".

### Ramos `150.45.x` em 15/10 (conferido no servidor SVN)

| Ramo | Leitura do ZPL | Shopee `^GFA` (A5) |
|---|---|---|
| .66 | UTF8 → ANSI no r500259 | não |
| .67 | **UTF8** | não |
| .68 | ANSI | sim |
| .69 | **UTF8** | não |
| .70 | **UTF8** | não |
| .71 | **UTF8** | sim |
| .72 | ANSI | sim |

O .69, o .70 e o .71 nasceram depois de 26/09 e mesmo assim têm UTF-8 — vieram de base anterior à
correção. **Qualquer cliente neles quebra ML e Shopee retrato.** Não corrigidos nesta sessão. O
`.66` continua sem a variante A5: se a COLOMARTI receber `^GFA`, a falha volta.

### Verificação

Autcom local do `150.45.66` apontado para a BR34, empresa 002, com `fMarketplaceUnificarAtivo`
forçado a `True` para `SHP_` (o cliente estava com a config desligada; trava revertida depois,
nada dela foi commitado).

- **Exe antigo / simulação Python:** NF 60026, cliente 00533962, pedido `SHP_261016PV2DC1CG` — a
  leitura UTF-8 deixa `R:DEMO.GRF,...`, `Pos('~DGR:') = 0`, falha.
- **Exe com o r500259:** NF **60036**, cliente **00534014**, pedido `SHP_261016Q3V47A8Q` — gerou
  `Etiqueta de envio.unificada.txt` (16.582 bytes, sem BOM, `^XA`/`^CI28`, 800 × 1200: etiqueta
  800 × 600, divisor em y=610, DANFE 800 × 575). Decodificado de volta: etiqueta completa e DANFE
  com NF, chave, item e `PEDIDO E-COMMERCE`.

Conferido pela decodificação local da saída, **não** pelo Labelary (etiqueta com dados pessoais do
comprador; o envio foi bloqueado) nem por impressão física (fila `frmImpEtiDespacho_Shopee` não
cadastrada para o operador de teste).

### Estado

- Passado à atendente para a equipe do cliente trocar a cópia de homologação pelo build novo.
- Depois disso, religar `SHP_` no `CFG_EDUNIF` da 002.
- Pendente: .67, .69, .70 e .71 com UTF-8; levantar na `LOGACE` quais clientes rodam esses ramos.

### Atalho para a próxima vez

A mensagem **sem** "Bitmaps encontrados no ZPL" já diz que o ramo é anterior a 25/09. Do título da
janela tire o build e procure-o na `LOGACE` (`LOG_SVNREV` → `LOG_VERSVN`); depois `svn cat` do
orquestrador nesse ramo e procure `TEncoding.UTF8`. O endereço do banco do cliente sai da
`gatilhos_informacao` (profile `gatilhos_central`).
