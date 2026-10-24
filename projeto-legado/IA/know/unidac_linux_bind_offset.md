# UniDAC no Linux — bind de parâmetro em offset errado

**Status:** causa encontrada e **corrigida no fonte do UniDAC em 19/10/2026** (Req. 467007) — ver
[A causa](#a-causa) e [A correção](#a-correção). Caso levantado em 08/09/2026.
**Contorno histórico:** `PrepareQueryFinalSQL`, que inlinava os `:params` no `SQL.Text` antes do
`Open`/`ExecSQL` e esvaziava `Params`. **Removido no Req. 471298** (20/10/2026): os parâmetros vão
pelo bind normal do UniDAC — ver [O que foi feito com o contorno](#o-que-foi-feito-com-o-contorno).
Desde então só o componente corrigido protege contra o defeito, e o `ci.py` recusa build sem ele —
ver [Proteção](#proteção-da-correção).

## O sintoma

Quando o bind fica a cargo do UniDAC no Linux, a substituição do parâmetro pode **consumir o
caractere seguinte** — no caso observado, a vírgula que separa argumentos de função.

SQL como está gravado no `CADREL.REL_DEFSQL` do relatório 538892:

```sql
SET @UTIMES := f_Rel_QtdDiaUtil(:DTAINI, :DTAFIN, VS_STRCODEMP);
```

O que o servidor recebeu (`mysql.general_log`, thread 149160, 08/09/2026 16:45:36):

```sql
SET @UTIMES := f_Rel_QtdDiaUtil('2026-09-08' '2026-09-08' '001');
```

Os três valores estão certos e na ordem certa. **As duas vírgulas sumiram.** MySQL concatena
literais adjacentes, então lê um único argumento `'2026-09-082026-09-08001'` e responde:

```
#42000 Incorrect number of arguments for FUNCTION AUTCOM.f_Rel_QtdDiaUtil; expected 3, got 1
```

O erro acusa a função, o que manda quem investiga para o lado errado: a função e a chamada estão
ambas corretas. Só o texto que chegou ao servidor é que não.

## Como reproduzir

| | |
|---|---|
| Cliente | `GRUPO_MARCIUS_LJ001(MATRIZ)_002_003_004`, `GRUPOMARCIUS-001.DDNS.NET:47658`, base `AUTCOM` |
| Relatório | `538892`, `REL_DESTIN = 'Card  Dashboard'` |
| Gatilho | `GATINF = 000001`, empresa `001` |
| Função | `f_Rel_QtdDiaUtil(pDTAINI date, pDTAFIN date, pCODEMP char(3))`, criada em 25/08/2026 |

```
cd /ServicosCitel/GatilhosInformacaoEnviar/robo_novo
./GatilhosInformacao -e001 -f -TL=1 NUMIP=GRUPOMARCIUS-001.DDNS.NET PORTA=47658 NOMBAN=AUTCOM \
  "GRUPO_MARCIUS_LJ001(MATRIZ)_002_003_004" GATINF=000001 --logsactive --logssql
```

A query da worker **não aparece** no `--logssql`: a conexão dela nasce do `BeginThreadConnection` e
não recebe o hook de log. Para vê-la, `general_log` no servidor do cliente:

```sql
SET GLOBAL log_output = 'TABLE';
TRUNCATE TABLE mysql.general_log;
SET GLOBAL general_log = ON;
-- roda o gatilho
SET GLOBAL general_log = OFF;

SELECT event_time, thread_id, CONVERT(argument USING utf8mb4)
FROM   mysql.general_log
WHERE  CONVERT(argument USING utf8mb4) LIKE '%f_Rel_QtdDiaUtil%'
ORDER  BY event_time;
```

É produção. Ligar, rodar e desligar.

## Por que só apareceu agora

Situação de 08/09/2026, antes da correção. O caminho síncrono do editor de relatórios passava por
`pOpenQuery` (`untInterfaceRelatorio.pas`), que no Linux chamava `PrepareQueryFinalSQL` antes do
`Open` — e o bug ficava invisível. O caminho com thread (`fExecutaThread` →
`TThreadRelatorio.Execute`) ia direto ao `FDados.Open`, sem preparar. Com o componente corrigido, os
dois caminhos usam o bind do UniDAC.

```
sincrono   -> pOpenQuery      -> PrepareQueryFinalSQL -> Open      OK
com thread -> fExecutaThread  -> FDados.Open                       bind do UniDAC -> quebra
```

Esse segundo ramo nunca tinha rodado no Linux: dependia de `blnConexaoIndependente = True`, que
estava forçado a `False` em vários pontos, e onde não estava um AV no `TSafeThread` matava antes.
Ver o histórico em `IA/specs/460229/record.md`.

## A causa

Medida em 19/10/2026 (Req. 467007) no fonte que **todo build Linux usa**: o Delphi Rio existe só no
servidor Windows de build, e todos os devs e robôs compilam com `C:\componentes\Rio` — UniDAC 8.1.3
(`Instalacoes\UniDAC\Source\UniProviders\MySQL\MyClassesUni.pas`). Dois defeitos somados em
`TMySQLCommand.PlaceParamValues`, a rotina que monta o SQL com os valores quando o statement não é
preparado:

1. **Bug original do UniDAC.** Sem `UseUnicode`, o `ParseSQL` monta o SQL num `AnsiStringBuilder`
   e guarda a posição de cada parâmetro em **bytes**. No ramo UTF-8 — só o Linux entra nele
   (`Dac.inc`: `{$IFDEF LINUX} {$DEFINE IS_UTF8}`) — o `PlaceParamValues` recorta a **string**
   com essas posições, contando **caracteres**. No Linux a `AnsiString` é UTF-8
   (`DefaultSystemCodePage = 65001`, medido): cada acento antes de um parâmetro desloca o recorte
   em um caractere — sobra o `?` e some o caractere seguinte (a vírgula do relatório 538892).
2. **Patch local de 13/06/2025** (não é do Devart; o original está em
   `Instalacoes\UniDAC\unidac81src.zip`). Tratou o sintoma do item 1 com `TrimRight` e remoção do
   `?` sobrando. O `TrimRight` apaga **todo espaço e quebra de linha antes de qualquer
   parâmetro**: `WHERE ⏎ :N` vira `WHERE8500`. Foi o erro do frete por faixa de faturamento
   (Req. 467007), e é por isso que só quebrava com valor sem aspas depois de palavra-chave.

O `PrepareQueryFinalSQL` nasceu 11 dias depois do patch (r425706, 24/06/2025) para contornar os dois.

## A correção

`PlaceParamValues` passa a recortar na mesma unidade em que as posições foram contadas — bytes da
`AnsiString` sem `UseUnicode`, caracteres da string com `UseUnicode` — por uma função local
`SQLFragment`; o `TrimRight` e a remoção do `?` saem. O ramo do Windows não muda. Há um comentário
no próprio fonte explicando.

- Backup do arquivo com o patch de 2025: `AUTPAS\citel-devRequisito\467007\unidac_backup\`.
- **Prova:** `AUTPAS\citel-devRequisito\467007\spike_unidac_linux\` — console Linux só com UniDAC,
  sem `PrepareQueryFinalSQL`, 6 casos (palavra-chave + quebra de linha, acento antes de params com
  vírgula, comentário `--`, controle, acento ida e volta, a consulta real da faixa). Compila com
  `ci.py --dproj <caminho>\SpikeUniDacLinux.dproj` e roda com `SPK_HOST SPK_PORT SPK_DB SPK_USER
  SPK_PASS` no ambiente. Resultado em 19/10/2026: **antes 4 PASS / 3 FAIL, depois 7 PASS / 0 FAIL**.

### Onde o compilador pega o `MyClassesUni` — e por que a correção pode não entrar

O compilador **não recompila** unit de biblioteca quando acha um `.dcu` dela no caminho — nem com
`-B`. Medido em 19/10/2026: com o `.pas` corrigido, IDE e `ci.py` seguiram linkando `.dcu` antigos.
A ordem em que ele procura (o primeiro que achar ganha):

| Local | Quem grava | Quem usa |
|---|---|---|
| pasta de saída do projeto (`Services\tmp`, `...\temp`, `...\Linux64\Release`) | o build do projeto | o próprio projeto |
| `C:\Program Files (x86)\Embarcadero\Studio\20.0\lib\Linux64\release` | pacote `Shared.Functions` em Release pela IDE (`DCC_DcuOutput=$(BDSLIB)\$(Platform)\release`) | **todo** build pela IDE |
| `C:\Program Files (x86)\Embarcadero\Studio\20.0\lib\linux64\debug` | `Shared.Functions` em Debug | build com debug DCUs / símbolos de debug |
| `C:\Linux64\release` | `Shared.Functions` pelo `ci.py` (`$(BDSLIB)` vazio vira `\Linux64\release`) | **todo** build pelo `ci.py` |
| `C:\Componentes\Rio\Instalacoes\UniDAC\Lib\Linux64` | instalação do UniDAC (original Devart era de 2020) | quem não achou antes |
| `C:\Componentes\Rio\Instalacoes\UniDAC\Source` | — (fonte) | só quando nenhum `.dcu` foi achado |

Em 19-20/10/2026: `Lib\Linux64` recebeu o `.dcu`/`.o` corrigido (compilado contra o próprio
`Lib\Linux64`; original de 2020 em `AUTPAS\citel-devRequisito\467007\unidac_backup\Lib_Linux64_2020`),
e os antigos com o patch foram apagados de `lib\Linux64\release`, `lib\linux64\debug`,
`C:\Linux64\release` e `Services\tmp`. O próximo build do `Shared.Functions` pelo `ci.py` já
regravou `C:\Linux64\release` corrigido. API compilada pela IDE e rodando: os 5 cenários do frete
batem com o Autcom, inclusive a faixa que dava `WHERE8500`.

## Proteção da correção

**`C:\componentes` não é versionado.** Se o UniDAC for reinstalado, ou um `.dcu` velho sobrar numa
pasta de saída, o defeito volta calado — e desde o Req. 471298 não há mais contorno no código.

- **`ci.py` recusa o build** (Req. 471298, `Services\TestExecute\_ci\unidac.py`): antes de qualquer
  modo (`--ciclo`, `--projeto`, `--dproj`, `--retomar`), procura o `MyClassesUni.dcu` em toda pasta de
  `Services`, nos locais fixos da tabela acima e confere o próprio `MyClassesUni.pas`; qualquer um
  existente sem `SQLFragment` faz o `ci.py` sair com `RECUSADO` e a lista. Num upgrade do UniDAC a
  recusa vem mesmo que o Devart tenha corrigido — de propósito, para reconferir.
- **Cópia do componente:** o João fez cópia integral da pasta em 20/10/2026; versioná-la está fora do
  Req. 471298. Além do `MyClassesUni.pas`, há outros fontes diferentes do `unidac81src.zip`
  (`CRBase64`, `DASQLMonitor`, `DBAccess`, `Uni`), não investigados.
- **O UniDAC também vive dentro de pacote.** As APIs (`FaturamentoServicesAPI`, `FinanceiroServicesAPI`)
  compilam com runtime packages `shared.functions;NFe`, e o `bplNFe.so` traz o `MyClassesUni`
  embutido (o nome aparece 18 vezes no `.so`; no executável, 3). Com runtime package, a unit que o
  pacote contém é usada a partir dele, então o bind da API provavelmente é o do pacote — não medido
  (20/10/2026). Um `bplNFe.so` antigo copiado de outra pasta traz o
  defeito de volta mesmo com a API recompilada: no deploy, o pacote tem de ser do mesmo build.
- **Build pela IDE não passa pelo `ci.py`.** Conferir à mão (zero em qualquer `.dcu` existente =
  versão sem a correção — apagar e recompilar):

```bash
for f in "/c/Program Files (x86)/Embarcadero/Studio/20.0/lib/linux64/"{release,debug}/MyClassesUni.dcu \
         /c/Linux64/release/MyClassesUni.dcu /c/Componentes/Rio/Instalacoes/UniDAC/Lib/Linux64/MyClassesUni.dcu; do
  [ -f "$f" ] && echo "$(grep -a -c SQLFragment "$f") $f"; done
```

Pasta de saída de projeto com `MyClassesUni.dcu` anterior a 19/10/2026 (cópias de trabalho de cada
dev, robôs fora do `Services`) também guarda a versão velha: apagar o `.dcu`/`.o` dela uma vez.

## O que foi feito com o contorno

Req. 471298, 20/10/2026. Inventário levantado em 19/10/2026 por `svn blame`; as linhas são as de
antes da remoção. Todas as chamadas existiam pelo bind quebrado.

A rotina fazia três coisas: `fTiraCaracEspeciaisSQL` no SQL inteiro (NBSP e `Ç`/`Ã`/`Í` maiúsculos,
por "illegal mix of collations"), troca de cada `:NOME` pelo valor por `Replace` de texto, e com isso
`Params` vazio. Só a primeira tinha dependente legítimo: o editor de relatórios, cujo SQL vem do
`CADREL`, digitado pelo usuário. Conferido que as outras não dependiam dela: SQL montado em código,
sem `Ç`/`Ã`/`Í` maiúsculo nem NBSP (`fSQLDespacho`, SQL da `LAYETI`, constantes do monitor); e o
`TZClient` não recebe SQL do `CADREL` (o `FDadosOrig` do `untGeraFR3` é o `FQueryDados`, `TUniQuery`
aberto por `pOpenQueryRelatorio`).

| Onde | Desde | Origem | Destino |
|---|---|---|---|
| `Services\Core\Services.Core.Connection.UniDac.pas` (a rotina, 2 overloads, `ParamValueToStr`) | r425706, 24/06/2025 | — | removida |
| `fontes\util\EditorEtiquetas\untEditorFast.pas:7749` | r424535, 16/06/2025 | etiquetas no Linux | removida |
| `fontes\util\EditorEtiquetas\untImprimeEtiquetas.pas:2298` | r424535 | idem | removida |
| `fontes\util\EditorEtiquetas\untEditorFastImpressao.pas:708` | r426127, 26/06/2025 | idem | removida |
| `fontes\editorRelatorios\untInterfaceRelatorio.pas:10674` | r432949, 15/08/2025 | recordsets do relatório | só `fTiraCaracEspeciaisSQL` |
| `fontes\editorRelatorios\untInterfaceRelatorio.pas:1377` (`pOpenQueryRelatorio`) | r435157, 02/09/2025 | relatório; tem retry de collation | só `fTiraCaracEspeciaisSQL` |
| `fontes\editorRelatorios\untInterfaceRelatorio.pas:1406` (`pExecuteQueryRelatorio`) | r435207 | idem | só `fTiraCaracEspeciaisSQL` |
| `fontes\faturamento\untTFatReservaSaldo.pas:2630` | r454494, 23/01/2026 | saldo reservado | removida |
| `Services\GatilhosInformacao\...\MonitorarGatilhos\untDBUtils.pas:381` e `:420` | r465695, Req. 434297 | **cópia própria da rotina** (`:151`), em todo `ExecSQL`/`Open` do monitor | removidas, com a cópia, o `ParamValueToStr` e o `fTiraCaracEspeciaisSQL` locais |
| `fontes\Core\Faturamento.Connections.Functions.pas:440` | r470632, Req. 437860 | SELECT por chave | removida |
| `fontes\genericos\untZClient.pas:335` | r474083, Req. 439800 | **todo `TZClient`** aberto no Linux | removida |
| `Services\Core\financeiro\services\Financeiro.Services.ParcelamentoCartao.pas:56` | r489401, Req. 454627 | faixa de parcelamento | removida |
| `...\Financeiro.Services.Cobranca.Duplicatas.pas:102` | r489401, Req. 454627 | filtro de duplicatas | removida |
| `...\Financeiro.Services.Cobranca.Baixa.pas:544` | r491104, Req. 454631 | idem, na baixa | removida |
| `...\Financeiro.Services.Cobranca.Estorno.pas:130` e `:145` | r493240, Req. 458943 | estorno | removidas |

**Efeito colateral que ficou: `untGeraFR3.pas`, ramo `{$IFDEF LINUX}` em ~6588.** Ao montar o
cabeçalho do relatório, quando a query de dados não tem o parâmetro do filtro, o ramo busca o valor
no grid de parâmetros da tela (`fGetValorParametro` → `fRetRowDado`). Existia porque a rotina
esvaziava o `Params`; sem ela, o `FindParam` acha o parâmetro e o ramo deixa de rodar no caso
comum. Mantido como fallback por decisão do João; só o comentário foi corrigido.
