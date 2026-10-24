# Especificação — Req. 468951

**Título:** Lentidão do Painel de Entregas ao abrir os documentos da entrega
**Objetivo:** permitir, por configuração, que as fotos e assinaturas de cada documento sejam baixadas do bucket só quando o usuário abrir aquele documento, em vez de todas ao abrir a lista.
**Zona:** Legado
**Data:** 16/10/2026
**Versões:** 02.30.74.150 e 02.74.150.100 (cliente Casa Nova Ferramentas em 379.48.2.30.74.150.100.17)

## 1. Contexto / problema atual

PRINCIPAL > PAINEL DE ENTREGAS, ícone de documentos na linha da entrega. Antes de exibir a lista, para **cada** documento, o painel executa `TDocumento.CarregaImagens`, que cria um `TFoto` por linha de `ROMFOT` e um `TAssinatura` por linha de `ROMASS`. **Os dois construtores já baixam o arquivo** (`TBucketCitel.Instance.fGetFile`). São requisições HTTPS sequenciais, uma por imagem, na thread principal e com `TIdHTTP` novo a cada chamada. Com ~21 documentos por entrega são dezenas de downloads antes da lista aparecer: de 1 a 2 minutos com o painel congelado.

As miniaturas só ficam visíveis quando o usuário clica no ícone de fotos ou de assinaturas da linha (`fraGridDocumentosLinhaimgDocsAssinaturasClick` → `ExpandeLinha`/`TrocarLayoutLinha`) ou no ícone do cabeçalho (`imgDocsFotosClick` → `ExpandeTodasLinhas`). Os metadados (quantidade e URL) vêm de consulta própria em `ROMFOT`/`ROMASS`, separada do download.

A configuração existente `CFG_CRGFOT` liga ou desliga só as fotos, e de uma vez. As assinaturas são baixadas sempre.

Defeito no caminho, corrigido junto (decisão do usuário, Parada 1): na família .150, `TFoto.Create` e `TAssinatura.Create` criam um `TBytesStream` e sobrescrevem a referência logo em seguida, o que deixa um objeto vazado por imagem.

## 2. Módulos e entidades envolvidos

- Módulo: faturamento / Tá Entregue (romaneios)
- Units:
  - `padra_atualizado\fontes\configuracoes\untCfgRepositorio.pas`
  - `padra_atualizado\fontes\faturamento\TaEntregue.Romaneios.Interfaces.pas`
  - `padra_atualizado\fontes\faturamento\TaEntregue.Romaneios.Classes.pas`
  - `padra_atualizado\Packages\Principal\View\source\Principal.View.FMXPainelEntregas.pas`
- Tabelas (só leitura, sem DDL): `ROMFOT` (`FOT_SEQGER`, `FOT_URLFOT`, `FOT_BASE64`), `ROMASS` (`ASS_SEQGER`, `ASS_URLFOT`, `ASS_BASE64`), `CFGSIS` (`SIS_CODCFG`/`SIS_VALCFG`, onde a configuração nova é gravada pelo repositório)

## 3. Requisitos funcionais

- RF01 — Configuração nova `CFG_IMGDEM`, grupo "APP ENTREGA", tipo Sim/Não, padrão **N**: *"Painel de entregas: baixar fotos e assinaturas somente ao abrir cada documento?"*.
- RF02 — Com `CFG_IMGDEM = 'N'`, o comportamento é idêntico ao atual, inclusive o momento dos downloads.
- RF03 — Com `CFG_IMGDEM = 'S'`, abrir os documentos da entrega lê os metadados de fotos e assinaturas sem baixar nenhum arquivo. Os ícones de fotos e de assinaturas aparecem conforme a quantidade, sem miniaturas montadas.
- RF04 — Com `CFG_IMGDEM = 'S'`, no clique do ícone de fotos ou de assinaturas de uma linha cujas imagens ainda não foram baixadas: exibir o aguarde, baixar as fotos e assinaturas **daquele documento**, montar as miniaturas e só então expandir a linha. Clique seguinte no mesmo documento não baixa de novo.
- RF05 — Com `CFG_IMGDEM = 'S'`, o ícone do cabeçalho (expandir todas) baixa as imagens de todos os documentos ainda não baixados, com aguarde e contador "documento X de N", e então expande.
- RF06 — O aguarde usa a barra de progresso do próprio painel (`pStepStatusGravacao(pgbStatus, ...)`), atualizada a cada imagem: "Aguarde... baixando imagens do documento".

## 4. Regras de negócio

- RN01 — `CFG_CRGFOT = 'N'` continua desligando as fotos em qualquer modo. `CFG_IMGDEM` só muda **quando** se baixa, e não **o que** se baixa.
- RN02 — Falha no download de uma imagem (bucket fora do ar, tempo esgotado, URL inválida): o documento abre com as que vieram, sem mensagem ao operador (como hoje). O documento **não** fica marcado como baixado, e o próximo clique tenta de novo.
- RN03 — Imagem com `FOT_URLFOT`/`ASS_URLFOT` inválida segue a regra atual (`fURLValida` falso → sem stream, ignorada na montagem).
- RN04 — Recarregar a lista de documentos (reordenação, atualização automática, nova abertura) recria os objetos. No modo S, as imagens voltam a ser baixadas só sob demanda.

## 5. Requisitos técnicos / não-funcionais

- Sem DDL: a configuração vive em `CFGSIS`, criada pelo repositório (`pAdicionarConfiguracao`).
- A interface (`IFoto`/`IAssinatura`/`IDocumento`) ganha método novo, **no fim da declaração**. O pacote `Principal.View` e o `autcom.exe` precisam ser compilados e distribuídos juntos.
- Fontes em Windows-1252: alteração com acento só por `.claude\scripts\fonte_delphi.py`.
- Sem log novo e sem exceção ao operador (aviso, se houver, por `fMensagem`).
- Corrigir o vazamento de `TBytesStream` em `TFoto.Create`/`TAssinatura.Create` (família .150).

## 6. Critérios de aceitação

- [ ] CA01 — `CFG_IMGDEM = N`: abrir os documentos de uma entrega com fotos e assinaturas se comporta exatamente como hoje (miniaturas prontas ao expandir, tempo equivalente).
- [ ] CA02 — `CFG_IMGDEM = S`: a lista de documentos abre sem esperar downloads, com os ícones de fotos/assinaturas presentes nos documentos que os têm.
- [ ] CA03 — `CFG_IMGDEM = S`: clicar no ícone de fotos de um documento mostra o aguarde, baixa só as imagens dele e exibe as miniaturas. Clicar de novo não baixa outra vez. O visualizador abre ao clicar na miniatura.
- [ ] CA04 — `CFG_IMGDEM = S`: o ícone do cabeçalho baixa as imagens restantes com contador e expande todas as linhas.
- [ ] CA05 — `CFG_IMGDEM = S` com o bucket inacessível: o documento abre sem as imagens e sem erro na tela. Restabelecido o acesso, um novo clique baixa as imagens.
- [ ] CA06 — `CFG_CRGFOT = N` com `CFG_IMGDEM = S`: nenhuma foto é baixada nem exibida, e as assinaturas são baixadas sob demanda.

## 7. Fora de escopo

- App Tá Entregue e a API dele (a parte do texto do atendimento sobre o payload da API).
- Versões principais fora do `vepeal` (.150.45, .111, .72), que têm o mesmo comportamento.
- `ProcessarDocumento` recarregar imagens e ocorrências quando o documento tem 0 fotos (relatado, não alterado).
- Paralelizar downloads ou reaproveitar a conexão HTTP em `TBucketCitel.fGetFile`.

## 8. Dependências e riscos

- Interface alterada → `Principal.View` (BPL) e `autcom.exe` descasados quebram o painel. Distribuir juntos e registrar na consideração de baixa.
- No modo S, o custo passa para o clique. Documento com muitas fotos ainda espera, mas só o dele.
- Cliente na release .150.100.17: a melhoria entra na principal .150.100 e chega a ele na próxima atualização (não há release com ela ainda).
