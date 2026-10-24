# Plano — Req. 471298

Cópia de trabalho: `AUTPAS\379.48.2.30.74.150`. Linhas conferidas em 20/10/2026; conferir de novo antes de editar.

## Regras de execução

- Fontes com acento: só `.claude\scripts\fonte_delphi.py` (`conferir` / `substituir`). Conferir o encoding **por arquivo** antes.
- Compilar Services: `padra_atualizado\Services\TestExecute\_ci\ci.py --projeto <Nome>`, um por vez, conferindo `build.trava` antes.
- **Antes de cada build**, rodar o check de `SQLFragment` do `know` nos `MyClassesUni.dcu`. Zero em qualquer `.dcu` existente: parar e avisar o João (`C:\componentes` e Program Files são dele).
- Entre o envio ao DelphAI e o commit, não compilar nem editar a cópia.
- No SVN: `add` sim, commit não.

## 1. Retirada — editor de relatórios (troca pela limpeza)

`fontes\editorRelatorios\untInterfaceRelatorio.pas`. O `fTiraCaracEspeciaisSQL` (`Services.Core.Utils`) já chega pelo `services.core.uses.inc` no Linux.

| Linha | Hoje | Passa a |
|---|---|---|
| `:1377` `pOpenQueryRelatorio` | `PrepareQueryFinalSQL(AQuery)` | `AQuery.SQL.Text := fTiraCaracEspeciaisSQL(AQuery.SQL.Text)` |
| `:1406` `pExecuteQueryRelatorio` | idem | idem |
| `:10674` recordset `SET @x := (SELECT…)` | `PrepareQueryFinalSQL(...qryInfo)` | idem, sobre o `qryInfo` |

O retry de "illegal mix of collations" das duas primeiras fica como está. Comentário curto na implementação dizendo por que a limpeza existe (SQL do `CADREL`, texto do usuário). O porquê da remoção do resto fica no `know`.

`untGeraFR3.pas:6588-6604`: o código fica (fallback, decisão do João). Só o comentário de `:6590` muda: sai a menção ao `PrepareQueryFinalSQL`; passa a dizer que o ramo cobre o parâmetro não achado na query, buscando o valor no grid (`CADVAL.VAL_ULTVAL`).

## 2. Retirada — chamadas sem substituto

Tirar a chamada e o `{$IFDEF LINUX}`/`{$ENDIF}` que só existia para ela. Onde o `IFDEF` cerca mais coisa, tirar só a linha.

| Arquivo | Linha |
|---|---|
| `fontes\genericos\untZClient.pas` | `:335` |
| `fontes\Core\Faturamento.Connections.Functions.pas` | `:440` |
| `fontes\faturamento\untTFatReservaSaldo.pas` | `:2630` |
| `fontes\util\EditorEtiquetas\untImprimeEtiquetas.pas` | `:2298` |
| `fontes\util\EditorEtiquetas\untEditorFastImpressao.pas` | `:708` |
| `fontes\util\EditorEtiquetas\untEditorFast.pas` | `:7749` |
| `Services\Core\financeiro\services\Financeiro.Services.ParcelamentoCartao.pas` | `:56` |
| `...\Financeiro.Services.Cobranca.Estorno.pas` | `:130`, `:145` |
| `...\Financeiro.Services.Cobranca.Duplicatas.pas` | `:102` |
| `...\Financeiro.Services.Cobranca.Baixa.pas` | `:544` |
| `Services\GatilhosInformacao\Target\Linux\MonitorarGatilhos\untDBUtils.pas` | `:381`, `:420` |

Depois de cada arquivo, conferir se ficou `uses` órfão (ex.: unit incluída só pela rotina).

## 3. Retirada — as rotinas

- `Services.Core.Connection.UniDac.pas`: declarações `:203-204`, implementações `:1361` e `:1378` (com o comentário novo) e `ParamValueToStr` (`:443`, privado, sem outro usuário). Conferir se `TDictionary`/`TComparer`/`TArray` ficam sem uso no `uses`.
- `MonitorarGatilhos\untDBUtils.pas`: `PrepareQueryFinalSQL` (`:151`), `ParamValueToStr` (`:99`) e `fTiraCaracEspeciaisSQL` local (`:92`), os três só usados entre si.
- `MonitorarGatilhos\CLAUDE.md` `:91` e `:113`: reescrever. O `ParamByName` passa a ser bind normal do UniDAC; `SetParam` só tem overload `string` (o valor vai entre aspas e o MySQL converte).

Critério: grep de `PrepareQueryFinalSQL` em `padra_atualizado` sem nenhum resultado (`*.pas`, `*.inc`, `*.dpr`, `*.md`, fora `__history`).

## 4. Compilar

Check de `SQLFragment` antes de cada build. As APIs e os projetos de teste vão por `--projeto`; os robôs que só estão no `Services.groupproj` (`FatImpressao`, `SaldoReservadoService`, `GatilhosInformacao`, `ProcessaObrarium`, `GatilhosInformacaoMonitor`) vão por `--dproj <caminho relativo a Services>`. Ordem e o que cada um cobre:

| Projeto | Cobre |
|---|---|
| `FaturamentoServicesAPI` | `Services.Core.Connection.UniDac`, `untZClient`, `Faturamento.Connections.Functions`, `untTFatReservaSaldo` |
| `FinanceiroServicesAPI` | as 4 units do Financeiro, `untEditorFastImpressao` |
| `FatImpressao` | etiquetas (3 units) |
| `SaldoReservadoService` | saldo reservado |
| `GatilhosInformacao` | editor de relatórios (`untInterfaceRelatorio`) |
| `ProcessaObrarium` | `untGeraFR3` (único `.dpr` dos Services que o compila) |
| `GatilhosInformacaoMonitor` | cópia do monitor |
| testes: `FaturamentoServicesTEST`, `FinanceiroServicesTEST` | suítes |

`autcom.exe` (Windows) pelo João: as chamadas estão em `IFDEF LINUX`, mas `untZClient`/editor/etiquetas são compartilhados.

## 5. Retestar no Linux, sem o contorno

Antes de usar o spike (`citel-devRequisito\467007\spike_unidac_linux\`) como molde, conferir se ele cobre o caso.

| Área | Como |
|---|---|
| Faturamento (`Faturamento.Connections.Functions`, `TZClient`, reserva) | suíte `FaturamentoServicesTEST` inteira em `/dados/FaturamentoServicesTEST` (porta 31415 livre, `cmp` dos binários) |
| Financeiro (parcelamento, estorno, baixa) | suíte `FinanceiroServicesTEST` |
| Financeiro — duplicatas | não está no `.dpr` de teste: chamada manual ao endpoint com filtro, conferindo no `general_log` |
| `TZClient` | parâmetro string com aspas/acento, data e número; conferir no `general_log` o SQL que chegou |
| Etiquetas | impressão de etiqueta de despacho pelo `FatImpressao` (layout `LAYETI`) |
| Relatórios | relatório com acento antes de `f(:A, :B, :C)` (molde do 538892) pelo `GatilhosInformacao`, em base de teste; e um relatório com `SET @x := (SELECT …)` |
| Saldo reservado | um ciclo do `SaldoReservadoService` com pedido que reserve |
| Monitor de gatilhos | um ciclo do `GatilhosInformacaoMonitor` sem erro de SQL |

Erro aqui é sinal de `.dcu` antigo antes de ser sinal de código: conferir o `SQLFragment` primeiro.

## 6. Proteção da correção do UniDAC

- Versionar a pasta inteira do componente: João.
- Check no `ci.py`: antes de compilar cada projeto, procurar `MyClassesUni.dcu` nos locais da tabela do `know` (pasta de saída do projeto, `lib\linux64\release|debug` do Program Files, `C:\Linux64\release`, `UniDAC\Lib\Linux64`) e reprovar, com mensagem que aponte o `know`, se algum existente não tiver `SQLFragment`. Ler o `compilador.py`/`ci.py` para achar o ponto comum aos três modos; seguir o estilo do módulo; documentar no `LEIAME.txt`.
- Provar o check nos dois sentidos: passa com o estado atual; reprova com um `.dcu` sem `SQLFragment` posto numa pasta de saída descartável (nunca mexer em `C:\componentes` ou Program Files).

## 7. Documentação

- `IA\know\unidac_linux_bind_offset.md`: status "removido (Req. 471298)", inventário vira histórico, incluir o ponto do `untGeraFR3`, registrar a proteção escolhida.
- Memória `autpas-req-pendente-aposentar-preparequeryfinalsql`: atualizar para o número e, ao fim, encerrar.
