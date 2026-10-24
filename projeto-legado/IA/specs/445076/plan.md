# Plano de Execução — Req. 445076

**Referência:** spec.md
**Zona:** Legado (`libCartoes/`)

## 1. Abordagem técnica

1. **`TIndiceBuscaCartao`** (nova classe em `libCentralizado`): um índice por combinação de chave usada nas buscas.
   - **Dicionário de entrada:** `chave → "RecNo|AutoIncremento"` do primeiro registro da chave, na ordem do índice corrente.
   - **Encadeamento:** `FProximo[RecNo]` liga os demais registros da mesma chave.
   - **`Localizar`:** confere a assinatura do dataset (`IndexFieldNames|Filter|Filtered|RecordCount`) e, se mudou, recarrega. Depois posiciona pelo `RecNo`, confere o `AUTOINCREM` (se divergir, recarrega uma vez) e a chave (se não bater, segue o encadeamento).
2. **Conciliações (Cielo, PagSeguro, RedeCard)**: 12 índices por conciliação (6 em `cdsBaiCar`, 6 em `cdsBaixad`), criados em `CarregaIndicesBusca` e liberados em `DestroiDicionariosBusca` / `Destroy`. Cada `Locate` de `fBuscaCartao` / `fBuscaCartaoBaixado` virou `If FIdx<...>.Localizar([...]) Then Result := True;`, mantendo condições e ordem.
3. **Caches**: dicionários de classe em `TLibCartoesFuncoes`, carregados na primeira chamada, e lista de campos do `LOGMCA` em variáveis de unit.
4. **Telas de baixa**: reordenação do `AfterScroll` em `pAbreConciliacao` e liga/desliga em `btnConfigurarGridClick`.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|---|---|---|
| untTIndiceBuscaCartao | `libCartoes/libCentralizado/classes/untTIndiceBuscaCartao.pas` | criar |
| untTLibCartoesFuncoes | `libCartoes/libCentralizado/genericos/untTLibCartoesFuncoes.pas` | alterar — caches `RetornaNomeFornecedor/Portador/CentroDeCustos/Empresa/Operador`, `DestroiDicionariosCache`, `pProcessMessages` público |
| untLibCartoesLogMca | `libCartoes/libCentralizado/genericos/untLibCartoesLogMca.pas` | alterar — `GeraListaDeCamposLOGMCA` (campos em cache), data do executável em cache |
| untLibCartoesInterfacesTipos | `libCartoes/libCentralizado/interfaces/untLibCartoesInterfacesTipos.pas` | alterar — `TDictionaryBuscaCartao` (ver tasks: hoje sem uso) |
| untCieloConciliacaoCartoes | `libCartoes/libCartoesCielo/concilicacao/untCieloConciliacaoCartoes.pas` | alterar — índices, `AUTOINC` no `cdsBaixad`, `lstDtaCad` ordenada |
| untConciliacaoCielo | `libCartoes/libCartoesCielo/concilicacao/untConciliacaoCielo.pas` | alterar — `CarregaIndicesBusca` nos 2 fluxos |
| untCieloBaixaCartoes | `libCartoes/libCartoesCielo/concilicacao/views/untCieloBaixaCartoes.pas` | alterar — `AfterScroll`, `pProcessMessages` |
| untCieloExports | `libCartoes/libCartoesCielo/genericos/untCieloExports.pas` | alterar — `DestroiDicionariosCache` |
| libCartoesCielo.dpr | `libCartoes/libCartoesCielo/libCartoesCielo.dpr` | alterar — `uses` da unit nova |
| untPagSeguroConciliacaoCartoes | `libCartoes/libCartoesPagSeguro/conciliacao/untPagSeguroConciliacaoCartoes.pas` | alterar — índices; `BuscaCartao*PorIDTransacao` movidas para a classe base |
| untConciliacaoPagSeguro | `libCartoes/libCartoesPagSeguro/conciliacao/untConciliacaoPagSeguro.pas` | alterar — `CarregaIndicesBusca`; remoção das buscas por ID locais |
| untConciliacaoPagSeguroApi | `libCartoes/libCartoesPagSeguro/conciliacao/untConciliacaoPagSeguroApi.pas` | alterar — `CarregaIndicesBusca` |
| untPagSeguroBaixaCartoes | `libCartoes/libCartoesPagSeguro/conciliacao/views/untPagSeguroBaixaCartoes.pas` | alterar — `AfterScroll`, `pProcessMessages` |
| untPagSeguroExports | `libCartoes/libCartoesPagSeguro/genericos/untPagSeguroExports.pas` | alterar — `DestroiDicionariosCache` |
| libCartoesPagSeguro.dpr | `libCartoes/libCartoesPagSeguro/libCartoesPagSeguro.dpr` | alterar — `uses` da unit nova |
| untRedeCardConciliacaoCartoes | `libCartoes/libCartoesRedeCard/conciliacao/untRedeCardConciliacaoCartoes.pas` | alterar — índices, `AUTOINC`, `lstDtaCad` |
| untConciliacaoRedeCard / untConciliacaoRedeCardAPI | `libCartoes/libCartoesRedeCard/conciliacao/` | alterar — `CarregaIndicesBusca` |
| untRedeCardBaixaCartoes | `libCartoes/libCartoesRedeCard/conciliacao/views/untRedeCardBaixaCartoes.pas` | alterar — `AfterScroll`, `pProcessMessages` |
| untRedeCardExports | `libCartoes/libCartoesRedeCard/genericos/untRedeCardExports.pas` | alterar — `DestroiDicionariosCache` |
| libCartoesRedeCard.dpr | `libCartoes/libCartoesRedeCard/libCartoesRedeCard.dpr` | alterar — `uses` da unit nova |
| Telas de baixa (11) | `views/unt<Op>BaixaCartoes.pas` de Banrisul, FiservBin, Equals, Getnet, Granito, Mobbuy, Safrapay, Sicredi, Sipag, Stone, Yapay | alterar — `pAbreConciliacao` e `btnConfigurarGridClick` |

## 3. Sequência de implementação

1. Criar `TIndiceBuscaCartao` (com conferência de `AUTOINCREM` e recarga por assinatura).
2. Cielo: índices, `CarregaIndicesBusca` nos fluxos, `AUTOINC` em `cdsBaixad`, restaurar os `IndexFieldNames` do SVN.
3. Caches em `TLibCartoesFuncoes` e `untLibCartoesLogMca`; `DestroiDicionariosCache` nas exports.
4. Telas de baixa: `AfterScroll` e `pProcessMessages`.
5. Portar para PagSeguro (incluindo buscas por ID de transação e o fluxo API) e RedeCard (arquivo e API).
6. Replicar o ajuste de `AfterScroll` nas 11 telas de baixa restantes.

## 4. Conformidade com padrões do projeto

- Zona Legado: prefixos `F`/`L`/`A` como no código vizinho; sem refatoração além do escopo.
- Sem componentes, chamadas ou SQL proibidos pelo pre-commit. Nenhum `Now`, `StrToFloat`, `.SetFocus` direto (usado `pSetFocus`) ou `Application.CreateForm`.
- SQL novo só com campo literal (`MOVCAR.AUTOINCREM AS AUTOINC`); sem concatenação de valor de usuário.
- Fontes em cp1252 / CRLF, conferidos com `.claude\scripts\fonte_delphi.py conferir --base`.

## 5. Estratégia de testes

- A `libCartoes` não tem suíte DUnit: validação manual, comparando com a versão anterior.
- Massa: `MOVCAR` da BELA TINTAS (`MCA_DTAREC >= '2026-09-11'`, `MCA_CHACON LIKE 'RED%'`), exportada em `Documents\AutPas\citel-devRequisito\445076\`, com `UPDATE` de estorno equivalente a `untEstornaCartoes.pas`.
- Casos:
  - conciliação Cielo, PagSeguro (arquivo/API) e RedeCard (arquivo/API) com o mesmo resultado da versão anterior;
  - ajuste de parcela com `BAIDEB` ligado;
  - configuração do grid na tela de baixa.

## 6. Riscos e mitigação

- Posições do dataset mudarem no meio da conciliação → assinatura + conferência de `AUTOINCREM` + recarga (RN02/RN03).
- Registros com chave repetida → encadeamento por `RecNo`, na ordem do índice, igual ao `Locate`.
- Dataset recriado com a mesma quantidade de registros → `CarregaIndicesBusca` recria os índices após cada `pFiltraCartoes*`, e a conferência de chave e `AUTOINCREM` cobre o resto.
