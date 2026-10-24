# Plano de Execução — Req. 468951

**Referência:** spec.md
**Zona:** Legado (fontes\ e Packages\Principal, estilo VCL/FMX existente)

## 1. Abordagem técnica

A decisão "baixar agora ou depois" fica no modelo (`TaEntregue.Romaneios.Classes`), não na tela:

- `TFoto` / `TAssinatura` ganham o modo adiado. O construtor só guarda a URL quando `CFG_IMGDEM = 'S'`. O download passa para um método `CarregaArquivo` (idempotente: não baixa de novo se já tem stream). No modo N, o construtor chama o mesmo método, mantendo o comportamento atual.
- `TDocumento` ganha `ImagensCarregadas: Boolean` (verdadeiro quando todas as imagens com URL válida têm stream).
- A tela, no modo S:
  - `CarregaBotaoFotos`/`CarregaBotaoAssinaturas` mostram o ícone pela **quantidade** e pulam a montagem das miniaturas sem stream (o `Continue` atual já cobre isso).
  - `BaixarImagensSobDemanda(AImagem, AIndiceInicial, AIndiceFinal)` é chamada no clique da linha (`fraGridDocumentosLinhaimgDocsAssinaturasClick`) e no do cabeçalho (`imgDocsFotosClick`, quando vai expandir). Ela atua só para os ícones de fotos e de assinaturas. Para cada documento com `not ImagensCarregadas`, percorre fotos e assinaturas chamando `CarregaArquivo`, avançando a barra (`pStepStatusGravacao`) a cada imagem. Depois limpa `layDocsFotos` e remonta as miniaturas da linha (`CarregaBotaoFotos`/`CarregaBotaoAssinaturas`). Em seguida a expansão existente segue.
  - O laço de download ficou na tela, e não num `CarregaArquivosImagens` do modelo, para a barra avançar por imagem sem callback na interface.

Leitura da configuração: `fCfgSis('IMGDEM')` no modelo (como `CarregaImagens` faz com `CRGFOT`) e `objFuncoes.fCfgSis('IMGDEM', varString)` na tela.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untCfgRepositorio | `padra_atualizado\fontes\configuracoes\untCfgRepositorio.pas` | alterar: `CFG_IMGDEM` após `CFG_CRGFOT` (declaração ~L21907 e editor `rdgSimNao_S_N` ~L7738, mesma ordem) |
| TaEntregue.Romaneios.Interfaces | `padra_atualizado\fontes\faturamento\TaEntregue.Romaneios.Interfaces.pas` | alterar: métodos novos no fim de `IFoto`, `IAssinatura` e `IDocumento` |
| TaEntregue.Romaneios.Classes | `padra_atualizado\fontes\faturamento\TaEntregue.Romaneios.Classes.pas` | alterar: `TFoto`, `TAssinatura` (construtor + `CarregaArquivo`, sem vazamento) e `TDocumento` (`CarregaArquivosImagens`, `ImagensCarregadas`) |
| Principal.View.FMXPainelEntregas | `padra_atualizado\Packages\Principal\View\source\Principal.View.FMXPainelEntregas.pas` | alterar: download sob demanda no clique da linha e do cabeçalho, com aguarde |

## 3. Sequência de implementação

1. Lock das 4 units na `.150` (`_locks\379.48.2.30.74.150\`).
2. `untCfgRepositorio`: configuração nova.
3. Interfaces → classes (`TFoto`, `TAssinatura`, `TDocumento`).
4. Painel: clique da linha, clique do cabeçalho, aguarde.
5. Conferir encoding e CRLF dos 4 arquivos (`fonte_delphi.py conferir`).
6. Validação do usuário na `.150` (Parada 3), com o roteiro da Parada 2.
7. Porte para a `.150.100` (`fonte_delphi.py aplicar --comparar`), conferindo antes por `svn diff` os trechos divergentes do painel.
8. Medição no banco do cliente (`--profile casa`): fotos e assinaturas por entrega → downloads evitados na abertura.

## 4. Conformidade com padrões do projeto

- Zona Legado: manter o estilo de cada arquivo (o painel usa `L`/`A` sem Hungarian e as classes, o estilo próprio). Sem refatorar além do necessário.
- Chamadas: `fCfgSis`, `pStepStatusGravacao`. Nada de `Now`, `.SetFocus`, `StrToFloat`, `Application.CreateForm` nem `ShowMessage`.
- Pre-commit: sem componentes proibidos (nenhum componente novo em `.fmx`/`.dfm`).
- Comentário só para o porquê (download adiado, idempotência), sem repetir o código.

## 5. Estratégia de testes

- Sem infraestrutura de teste nesta zona: validação manual pelo roteiro da Parada 2.
- Casos: CA01 a CA06 da spec.

## 6. Riscos e mitigação

- Interface alterada, BPL e exe descasados → métodos só no fim das interfaces; consideração de baixa avisa para distribuir os dois juntos.
- Remontagem das miniaturas no clique duplicando controles → `CarregaBotaoFotos` limpava `layDocsAssinaturas` no lugar de `layDocsFotos` (defeito anterior). Corrigido neste requisito por exigência do DelphAI (rodada 2), com o OK do usuário. Assim `CarregaBotaoFotos`/`CarregaBotaoAssinaturas` limpam cada um o próprio quadro antes de remontar.
- Divergências do painel entre `.150` e `.150.100` (filtro "exceto", reordenação) → porte por trecho, não patch cego.
