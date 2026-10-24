# Tarefas — Req. 468951

**Referência:** spec.md, plan.md

## Fase 1 — Análise / preparação
- [x] Localizar o download (construtores de `TFoto`/`TAssinatura`) e o fluxo do painel
- [x] Regra 7: nenhuma versão tem download sob demanda
- [x] Versão do cliente: 379.48.2.30.74.150.100.17
- [x] Parada 2: roteiro de validação aprovado
- [x] Locks das 4 units na `.150`
- [x] `untCfgRepositorio.pas` atualizada para r500382 (Req. 470219), junto com as 3 units do mesmo commit

## Fase 2 — Implementação (.150)
- [x] `untCfgRepositorio.pas`: `CFG_IMGDEM` (declaração + editor Sim/Não, mesma ordem)
- [x] `TaEntregue.Romaneios.Interfaces.pas`: `CarregaArquivo`/`ArquivoCarregado` no fim de `IFoto` e `IAssinatura`; `ImagensCarregadas` no fim de `IDocumento`
- [x] `TaEntregue.Romaneios.Classes.pas`: `TFoto`/`TAssinatura` com `CarregaArquivo` e sem vazamento de `TBytesStream`
- [x] `TaEntregue.Romaneios.Classes.pas`: `TDocumento.ImagensCarregadas`. O download fica na tela (`BaixarImagensSobDemanda`) para a barra avançar por imagem, sem `CarregaArquivosImagens` no modelo
- [x] `Principal.View.FMXPainelEntregas.pas`: download no clique da linha, com aguarde
- [x] `Principal.View.FMXPainelEntregas.pas`: download no clique do cabeçalho, com contador
- [x] `fonte_delphi.py conferir` nos 4 arquivos (encoding, CRLF)

## Fase 3 — Testes
- [x] Você: compilar `autcom.exe` e o pacote `Principal.View` na `.150` (compilado na IDE; o script parou em `F2063` por memória)
- [x] Você: validar CA01 a CA06 (Parada 3): todos ok em 16/10/2026, base `2_30_74_TA_ENTREGUE`, empresa 001, romaneio 006423 (31 docs, 62 fotos + 62 assinaturas). Abertura: 2 min 30 s com `CFG_IMGDEM = N`, 3,5 s com `S`; 6 s para as fotos de 1 documento no clique
- [x] Porte para a `.150.100` (após atualizar as 4 units do Req. 470219 para r500374): linhas alteradas idênticas às da `.150`
- [x] Medição no banco do cliente (`--profile casa`): 61 entregas com imagem, média de 20,5 downloads por abertura (máx. 110), ~2,9 por documento

## Fase 4 — Revisão e commit
- [x] Code review do diff: Sonar apontou complexidade 15 e 2 `OR` em `BaixarImagensSobDemanda`. O método foi dividido (`DeveBaixarImagensSobDemanda`, `BaixarArquivosDocumento`, `ObterFrameDocumento`) nas duas versões, sem mudar o comportamento
- [x] DelphAI, rodada 2: o defeito anterior em `CarregaBotaoFotos` (limpava `layDocsAssinaturas` no lugar de `layDocsFotos`) reprova pela regra do DelphAI. Escopo ampliado com o OK do usuário: corrigido nas duas versões e removido o laço de contorno de `BaixarImagensSobDemanda`
- [x] Você: recompilar a `.150` e repetir CA01/CA03/CA04
- [x] Commit da `.150`: r500687 (com `IA\specs\468951`)
- [x] DelphAI `.150.100`: 3 apontamentos procedentes, corrigidos nas duas versões. Cabeçalho Obs → Fotos/Assinaturas passa a baixar; Esc, Voltar e fechar ficam bloqueados durante o download (`FBaixandoImagens`); falha de download vai para o registro de erros (`objFuncoes.GravarLogErro`)
- [ ] Você: recompilar a `.150`, testar cabeçalho Obs → Fotos e Esc/fechar durante o "Aguarde", e repetir CA03
- [ ] Você: DelphAI e commit nas duas versões (2º commit da `.150`)
- [ ] Você: gate DelphAI e token
- [ ] Você: commit com `Req. 468951` na primeira linha + token
- [ ] Consideração de baixa (avisar: BPL e exe juntos)
