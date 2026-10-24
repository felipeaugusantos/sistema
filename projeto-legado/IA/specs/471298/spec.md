# Especificação — Req. 471298

**Título:** Aposentar o `PrepareQueryFinalSQL` — bind de parâmetro do UniDAC no Linux
**Objetivo:** Tirar o contorno que troca os `:params` pelo valor no texto do SQL, agora que o UniDAC do servidor de build foi corrigido, e proteger essa correção, que vive fora do SVN.
**Zona:** Moderna (`Services/Core`, `Services/Core/financeiro`, `MonitorarGatilhos`) + Legado (`fontes/genericos`, `fontes/editorRelatorios`, `fontes/util/EditorEtiquetas`, `fontes/faturamento`, `fontes/Core`)
**Versão:** `02.30.74.150` (Services Linux saem dela)
**Envolvidos:** João Catarino
**Data:** 2026-10-20

## 1. Contexto e porquê

O levantamento é o `IA/know/unidac_linux_bind_offset.md`: causa, correção, spike e inventário. Não se refaz a entrevista.

Resumo: no Linux, o `TMySQLCommand.PlaceParamValues` do UniDAC 8.1.3 (`C:\componentes\Rio\Instalacoes\UniDAC\Source\UniProviders\MySQL\MyClassesUni.pas`) recortava o SQL contando caracteres, sobre posições guardadas em bytes, e um patch local de 13/06/2025 comia o espaço antes de todo parâmetro (`WHERE8500`). O `PrepareQueryFinalSQL` (r425706, 24/06/2025) contornava os dois trocando os parâmetros por texto. O componente foi corrigido no Req. 467007 (função `SQLFragment`, spike 7 PASS / 0 FAIL, API do frete validada).

Com o componente corrigido, o contorno só traz custo:

- troca `:NOME` por `Replace` de texto, inclusive dentro de literal e de comentário;
- esvazia o `Params`, então a query não reabre com outros valores e quem procura o parâmetro depois não o acha (motivo do ramo `IFDEF LINUX` do `untGeraFR3`);
- espalha `{$IFDEF LINUX}` por 11 arquivos.

### O que a rotina faz (conferido no código em 20/10/2026)

`Services.Core.Connection.UniDac.pas:1378`, e cópia idêntica em `MonitorarGatilhos\untDBUtils.pas:151`:

1. `fTiraCaracEspeciaisSQL` no SQL inteiro, mesmo sem parâmetro: NBSP vira espaço e `Ç`/`Ã`/`Í` maiúsculos perdem o acento ("illegal mix of collations");
2. troca cada `:NOME` pelo valor formatado por `ParamValueToStr` (`AppendValueToSQL`), em ordem decrescente de nome;
3. com isso, o `Params` fica vazio.

Só o item 1 pode ter dependente legítimo: SQL vindo de cadastro.

## 2. Decisões

| Decisão | Por quê | Quem |
|---|---|---|
| O editor de relatórios troca as 3 chamadas por `fTiraCaracEspeciaisSQL` | o SQL vem do `CADREL` (texto do usuário); `:1377`/`:1406` abrem o SQL do relatório e `:10674` monta o recordset a partir dele (`strSQLAux`) | João (plano de 19/10) + conferido 20/10 |
| As outras 13 chamadas saem sem substituto | SQL montado em código, sem literal com `Ç`/`Ã`/`Í` maiúsculo ou NBSP (ver §3) | conferido 20/10 |
| A rotina sai, com os dois overloads, e a cópia do monitor também, com o `ParamValueToStr` e o `fTiraCaracEspeciaisSQL` locais | `ParamValueToStr` é privado nos dois arquivos e só a rotina o usa; no monitor, o `fTiraCaracEspeciaisSQL` local também | conferido 20/10 |
| O `know` é commitado junto, com status "removido" e o inventário virando histórico | o porquê da remoção fica nele, e não em comentário no fonte | João |
| Proteção da correção: o João versiona a pasta inteira do componente; o `ci.py` ganha um check que reprova o build se um `MyClassesUni.dcu` no caminho não tiver `SQLFragment` | os dois defeitos estão no `MyClassesUni.pas` (o do Devart já no original de 2020; o `TrimRight` é o patch local de 2025), e há outros fontes alterados no componente (`CRBase64`, `DASQLMonitor`, `DBAccess`, `Uni`), por isso a pasta inteira. A suíte não cobre os robôs, e o defeito só do Devart (acento antes do parâmetro) pode passar verde nela | João, 20/10 |
| Ramo `IFDEF LINUX` do `untGeraFR3:6588-6604` **fica**; só o comentário é corrigido | vira fallback para quando o parâmetro não for achado. O comentário diz que o `pOpenQueryRelatorio` chama o `PrepareQueryFinalSQL`, o que deixa de ser verdade | João, 20/10 |

## 3. Riscos investigados (20/10/2026)

- **`TZClient` levando SQL do `CADREL`:** não leva. O `FDadosOrig` do `untGeraFR3` recebe o `FQueryDados` (`untInterfaceRelatorio:12061`), `TUniQuery` criado por `fCriaQuery` (`:2540`) e aberto por `pOpenQueryRelatorio` (`:11610`). Os `TZClient` do editor só rodam SQL de código (metadado e `fSQLHorizo`, que monta estrutura). Retirar a chamada do `untZClient:335` não leva junto limpeza de relatório.
- **Etiquetas:** `untDespacho.pas` (`fSQLDespacho`) não tem `Ç`/`Ã`/`Í` nem NBSP em cp1252, e só lê `CFG_IMPPAG` do cadastro. O SQL da `LAYETI` (`untEditorFastImpressao:708`) é fixo.
- **Monitor de gatilhos:** SQL em constantes; nenhum literal sensível nos fontes.

## 4. Critérios de aceitação

1. Nenhuma referência a `PrepareQueryFinalSQL` em `*.pas`/`*.inc`/`*.dpr` de `padra_atualizado` (fora `__history`).
2. O editor de relatórios aplica `fTiraCaracEspeciaisSQL` nos 3 pontos, e o retry de collation do `pOpenQueryRelatorio`/`pExecuteQueryRelatorio` continua.
3. Compilam pelo `ci.py`, com o `MyClassesUni.dcu` corrigido conferido antes: `FaturamentoServicesAPI`, `FinanceiroServicesAPI`, `FatImpressao`, `SaldoReservadoService`, `GatilhosInformacao`, `GatilhosInformacaoMonitor`. O autcom.exe compila (João).
4. No Linux, sem o contorno:
   - suítes do Faturamento e do Financeiro verdes;
   - etiqueta impressa pelo `FatImpressao`;
   - relatório com acento antes de parâmetros separados por vírgula (caso do 538892) devolve dados;
   - saldo reservado processa;
   - monitor de gatilhos roda um ciclo sem erro de SQL;
   - parâmetro de string com aspas, data e número, abertos por `TZClient`, chegam corretos ao servidor.
5. O `CLAUDE.md` do `MonitorarGatilhos` (`:91`, `:113`) deixa de descrever a troca de parâmetro por texto.
6. O `ci.py` reprova o build quando um `MyClassesUni.dcu` no caminho de busca não tem `SQLFragment`, em `--ciclo`, `--projeto` e `--dproj`.
7. O comentário do `untGeraFR3:6590` descreve o ramo como fallback, sem citar o `PrepareQueryFinalSQL`.

## 5. Limites conhecidos

- Build pela IDE não passa pelo `ci.py`: depende do `grep -c SQLFragment` descrito no `know`.
- O check reprova também num upgrade do UniDAC que corrija o defeito de outro jeito. É intencional: obriga a reconferir.

## 6. Fora de escopo

- Versionar a pasta do componente (João).
- Investigar os outros fontes alterados do UniDAC (`CRBase64`, `DASQLMonitor`, `DBAccess`, `Uni`).

- Corrigir o `.dcu` antigo nas pastas de saída das cópias de trabalho de cada dev (o `know` já orienta).
- Mudar o comportamento do retry de collation do editor de relatórios.
