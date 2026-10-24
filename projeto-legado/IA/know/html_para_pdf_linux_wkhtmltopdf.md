# HTML para PDF no Linux — a dependência que não está no repositório

`fHtmlToPdf` não é código: é um `system()` para um binário externo. Nada no repositório declara essa
dependência, nenhum build falha sem ela, e o erro que ela produz não diz o que está faltando.

Levantado em 23/09/2026, resolvendo o `wkhtmltopdf: command not found` no `srvwebservices-gatilho1`.

## O que a função realmente faz

`Services.Core.Utils.pas`, `{$IFDEF LINUX}`:

```pascal
Cmd := Format('wkhtmltopdf ... "%s" "%s"', [HtmlFile, PdfFile]);
Ret := libc_system(PAnsiChar(AnsiString(Cmd)));
if Ret <> 0 then
  raise Exception.Create('Erro ao executar wkhtmltopdf');
```

Chamada por **nome**, sem caminho absoluto e sem checar existência. Quando o binário não está no
`PATH`, o `sh` devolve **127** e sobe a exceção acima — que diz "erro ao executar" para um caso em
que nada foi executado. **A mensagem não distingue ausência de binário de falha de renderização**, e
é por isso que o diagnóstico custa caro: o log parece problema de conteúdo.

## Quem realmente chega até lá

O único caminho até `fHtmlToPdf` é `fGerarPdfLinksWhatsappBase64`
(`fontes/whatsapp/untGeraPdfLinksWhatsapp.pas`), e o alcance é bem mais estreito do que o nome
"gerar PDF" sugere. Três filtros em série, todos em `untProcessaGatilhosImediatos`:

1. **Só WhatsApp.** A rotina sai por `Exit` quando o tipo é `typeTDadosEnviaGatilhoEmail` ou
   `typeTDadosEnviaGatilhoSms`. O caminho de e-mail anexa os arquivos direto e, quando passa do
   limite `TAMANX`, fatia em vários e-mails — **nunca funde em PDF, nunca usa wkhtmltopdf**.
2. **Só com número preenchido.** `Exit` se `GAT_NUMWPP` estiver vazio.
3. **Só com 2 ou mais anexos.** Com um anexo só, `blnArquivosProntos := True` e o binário não é
   chamado. É a fusão de múltiplos anexos num `ARQUIVOS.pdf` que o exige.

O outro ponto de chamada, `untThreadEnviaSMS.fCriarArquivoPdfUnico`, tem `raise` no ramo
`{$IFDEF LINUX}` — nunca chega ao binário no Linux.

E a unit do PDF é partida por `{$IFDEF LINUX}`: **no Windows o mesmo
`fGerarPdfLinksWhatsappBase64` renderiza por FastReport**, lendo o layout de `LAYFR3`, e não toca no
wkhtmltopdf. Só a compilação Linux depende do binário externo. Testar no autcom desktop não
exercita nada disso.

## O build precisa ser o com Qt patcheado

Há dois wkhtmltopdf no mundo, com o mesmo nome:

| Origem | Comportamento |
|---|---|
| Pacote de distribuição, ligado ao Qt de sistema | **exige X** — só roda sob `xvfb-run` |
| RPM oficial `wkhtmltox` (GitHub `wkhtmltopdf/packaging`) | Qt patcheado, **headless por construção** |

O `fHtmlToPdf` chama `wkhtmltopdf` direto, sem `xvfb-run`. Logo **só o segundo serve** — instalar o
da distribuição e acrescentar Xvfb é resolver o problema errado. O `wkhtmltopdf -V` denuncia qual
está instalado: o certo responde `0.12.6.1 (with patched qt)`.

O projeto upstream está arquivado e congelado em `0.12.6.1`; não há versão nova para esperar.

## A armadilha do PATH

O RPM instala em **`/usr/local/bin/`**, não em `/usr/bin/`. Isso produz um segundo
`command not found` *depois* de a instalação ter dado certo — inclusive para o root — e o sintoma é
idêntico ao original, o que faz parecer que a instalação falhou.

Pior no contexto do robô: `libc_system` abre um `/bin/sh` que herda o `PATH` **do processo**, e
daemon iniciado por systemd ou por script de init costuma ter `PATH` enxuto. Daí o symlink não ser
cosmético:

```bash
ln -sf /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf
```

Para inspecionar o ambiente real do robô, e não o do seu shell, ler `/proc/<pid>/environ` do
processo do robô trocando os separadores nulos por quebra de linha, e filtrar por `PATH=`.

**E o processo em execução herda o ambiente de quando subiu** — instalar não conserta o robô que já
está rodando. Reiniciar faz parte do procedimento.

## Onde está o script

Na pasta de distribuição do robô, `WEBSERVICE_CITEL\GatilhosImediatos (Mensageria)` no
`citel-fileserve`, arquivo `wkhtmltopdf.sh`, ao lado do `gatilhos.sh` que sobe o robô. Validado em
Oracle Linux Server 9.7.

Ele **não é versionado**. Servidor reprovisionado sem alguém lembrar de rodá-lo volta ao estado de
hoje — este documento é o que sobra para encurtar o diagnóstico da próxima vez.

Script destinado a Linux editado no Windows precisa sair em **LF**. A primeira versão gravada na
pasta foi em CRLF, e aí o shebang carrega um CR no fim: o kernel procura um interpretador que não
existe e responde `bad interpreter: no such file or directory`, erro que não menciona o caractere
invisível. Conferir com `file arquivo.sh` antes de publicar — o vizinho `gatilhos.sh` é ASCII/LF.

## O container do Suprimento não precisa disso — hoje

O container que roda REPOR+ e Suprimento API (`oraclelinux:8.10`, montado pelo `<runCmds>` de
`ReporMais/citel/appPastaCompra/pom.xml`) carrega a mesma `libGatIme` e **também não instala
wkhtmltopdf** — mas isso não o quebra, porque ele nunca chega ao binário.

A exportação de cotação monta o `TRecGatilhoImediato` com `EmptyStr` no campo `NumeroWhatsapp` e os
destinatários em `Email` (`Suprimento.Services.Cotacao.Exportacao.pas`). Sem número de WhatsApp, o
filtro 2 da seção anterior barra antes do PDF. **O Suprimento só manda e-mail.**

O que torna isso frágil é que a proteção está no *dado*, não no código: basta alguém passar um
número de WhatsApp nesse mesmo `Create` — e mandar 2 ou mais anexos — para o container cair no
`command not found`, com a mesma mensagem enganosa. Se o Suprimento ganhar envio por WhatsApp, o
`<runCmds>` precisa do wkhtmltopdf **antes** disso ir para o cliente, com o asset `almalinux8` em vez
do `almalinux9` e instalado na receita, não na mão — instalação manual em container morre no
próximo build da imagem.
