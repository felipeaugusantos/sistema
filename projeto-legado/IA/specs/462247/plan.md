# Plano de Execução — Req. 462247

**Referência:** spec.md
**Zona:** `Contabilidade/` (View legado VCL / Classes com estilo dot-notation)
**Situação:** implementado em 20-21/09/2026. Defeitos 1-4 compilados; 5-7 pendentes de recompilação e validação.

## 1. Abordagem técnica

### Defeito 1 — a trava

Guardar o `CON_TIPLAN` do registro carregado em um campo do form (`strTipLanOriginal`), capturado no mesmo ponto em que `intRegAlt` já é capturado, e recusar o caminho `intAltera = 1` quando o tipo em tela divergir.

A trava fica **entre** o diálogo "Alterar / Incluir Novo / Cancelar" e o bloco `If (not blnCancelarOperacao) and ((intAltera=1) Or (intAltera=2))`. Nessa posição:

- nenhuma transação foi aberta ainda (`fStartTransaction` vem depois), então o `Exit` não deixa estado pendente;
- o `Exit` cai no `Finally FreeAndNil(qryInsert)` que já envolve o bloco, igual aos `Exit` que já existem ali;
- a tela permanece preenchida — o usuário confirma de novo e escolhe "Incluir Novo".

Alternativa avaliada e descartada: ler `qryParCon.FieldByName('CON_TIPLAN')` no momento da confirmação, em vez de guardar no load. **Não é confiável** — o próprio código existente (`fValidaSAI_ENT` e `fValidaCPC`) repõe o cursor com `qryParCon.RecNo := intRegAlt` antes de ler `CON_SEQPAR`, admitindo que o cursor pode ter saído do registro. Capturar junto com `intRegAlt` é o idioma que o arquivo já usa.

### Defeito 2 — a captura do snapshot

Mover a captura do valor anterior de `DoBeforePost` para `DoBeforeEdit`, onde `Value` ainda é o valor original vindo do banco. Evidências que sustentam o ponto de captura, conferidas no fonte da RTL (`Studio/17.0/source/data/Data.DB.pas`):

- `procedure DoBeforeEdit; virtual;` — linha 2721, o override é válido;
- `TDataSet.Edit` chama `DoBeforeEdit` **antes** de `SetState(dsEdit)` e depois de `CheckBrowseMode` — o buffer ativo ainda tem o registro original;
- `TDataSet.Edit` sai cedo `if not (State in [dsEdit, dsInsert])` — não há captura dupla se `Edit` for chamado duas vezes;
- `if FRecordCount = 0 then Insert` — em dataset vazio, `Edit` vira `Insert` e `DoBeforeEdit` não dispara; o Post cai em `dsInsert` e o caminho INC segue intacto.

`DoBeforePost` deixa de sobrescrever o snapshot bom e mantém `OldValue` apenas como fallback (`if FSnapshotAntes.Count = 0`).

A correção é na classe, não na tela: beneficia todos os forms que usam `fCriaQueryContabilidade` sobre query com JOIN — `ExclusaoLanctoContabil`, `HistoricoPadrao`, `LancamentoSaldos`, `LancamentosLotesContabeis`, `ManutencaoLancamentoContabil`, `PlanoContabil`, `TipoDePlanoDeContaContabil`, `FechamentoDiaMes`.

### Defeito 3 — cada limite enunciado uma vez só

Duas colunas tinham a regra de tamanho duplicada, e as duas já haviam divergido. Trocar os literais pelo valor certo em cada ponto resolveria o sintoma e deixaria a armadilha montada para a próxima vez — o desenho adotado é uma constante por coluna, referenciada por todos os pontos que a aplicam.

**`VALANT`/`VALATU`** — constante nova `CTamMaxValor = 512` na `interface` de `Contabilidade.Classes.LogAjc`, ao lado de `CTamMaxIncDoc`, usada nos três pontos. A largura real no banco é `varchar(512)`, confirmada pelo solicitante — por isso o limite da **gravação sobe** para 512, em vez de o limite da **comparação descer** para 250.

`fLimitarTexto250` foi renomeada para `fLimitarTextoValor`: o nome antigo carregava o número, e seria mentira no instante em que a constante mudasse.

**`INCDOC`** — a constante `CTamMaxIncDoc = 128` já existia e já estava correta; faltava o gravador em lote usá-la, em vez do `Copy(..., 1, 20)` inline. Largura real no banco: 128, confirmada pelo solicitante. Uma linha.

Com isso os dois gravadores da LOGAJC passam a concordar em todas as colunas. Os outros sete limites (`CODEMP`, `CODOPE`, `TABELA`, `TIPAJU`, `COLUNA`, `NOMFRM`, `SEQAJU`) continuam como literais duplicados nos dois arquivos, mas hoje **concordam** — ficaram registrados na seção 7 do `spec.md` em vez de entrar aqui.

### Defeito 4 — sonda própria, sob demanda, na conexão certa, com cache

Três mudanças que se sustentam uma na outra.

**Sonda própria do módulo.** `fSondarTabelaContabil` entra em `Contabilidade.Funcoes`, o helper do módulo, com o enum `TSondaTabela = (staExiste, staNaoExiste, staFalhou)`. A Contabilidade é external e não pode ficar refém de `fTabelaExiste`, que mora no Core de Faturamento do autcom e muda entre versões.

Os **três** estados são o ponto, não um detalhe. `fTabelaExiste` tem dois, porque colapsa qualquer falha em `False` — e é daí que nasce o defeito: quem recebe `False` não sabe se a tabela não existe ou se a conexão piscou, e acaba tratando acidente como decisão.

A sonda consulta `INFORMATION_SCHEMA.TABLES` com `TABLE_SCHEMA = DATABASE()` em vez de dar `SELECT` na tabela alvo. Assim tabela ausente devolve conjunto vazio, não exceção, e sobra exceção só para falha de verdade — conexão caída, timeout, permissão. É o que permite separar os três estados sem depender de código de erro do servidor. Mesmo idioma que `fObterCamposChavePK` já usa na unit da auditoria.

**Resolução sob demanda.** O campo `FblnLogAjc` sai; entra `fLogAjcDisponivel`, resolvido em `Self.Connection` — a mesma conexão passada a `TLogAjc.pGravarLote`. No construtor era impossível acertar: `fCriaQueryContabilidade` só atribui a `Connection` depois do `Create`.

**Cache que só guarda o que é conclusivo.** Dicionário protegido por `TCriticalSection`, criado na `initialization` e liberado na `finalization` — o idioma que a própria unit já usa para as chaves primárias.

Chave por **identidade lógica do banco**, `Server + Port + Database`, não pelo ponteiro da conexão: conexão liberada e endereço reaproveitado devolveria a resposta do banco errado. Como efeito colateral bom, duas conexões para o mesmo banco compartilham a sondagem. (O cache de PK da mesma unit ignora a conexão inteiramente — chaveia só pelo nome da tabela. Mesma fragilidade em base multi-banco; não corrigi por estar fora do escopo.)

`staExiste` e `staNaoExiste` entram no cache e ficam. `staFalhou` **não entra**: a auditoria fica suspensa naquela operação e tenta de novo na seguinte. Guardar uma falha é literalmente o defeito original.

Com a sonda conclusiva, o TTL que a versão anterior deste plano previa deixou de ser necessário — não há mais resposta ambígua para revalidar. Saem `System.DateUtils`, o record `TInfoLogAjc` e a constante de janela; o cache vira `TDictionary<String, Boolean>`.

Consequência a registrar: se a LOGAJC for **criada com o sistema aberto** (script de atualização), a negativa guardada só cai no próximo start. Aceitável e igual ao comportamento anterior; o cache de PK da mesma unit tem a mesma característica.

**Sobrecarga para o gravador em lote.** `TGravacaoEmLote` grava a LOGAJC por FireDAC (`FDDatabase: TFDConnection`), então a sonda ganha uma segunda assinatura. O SQL fica numa constante única, `CSQLSondaTabelaContabil` — o que muda entre as duas é só o DAC, e duplicar o texto reconstruiria em escala menor a divergência do defeito 3.

`FireDAC.Comp.Client` entra na `uses` de interface de `Contabilidade.Funcoes`. Não é dependência nova de fato: essa unit já usa `Contabilidade.Classes.TGravacaoEmLote` na interface, que por sua vez usa FireDAC — o grafo de compilação já continha isso. E como Delphi não reexporta `uses` de interface, nenhum consumidor de `Contabilidade.Funcoes` passa a enxergar identificadores FireDAC.

No `TGravacaoEmLote`, `TSondaTabela` **não pode** aparecer na interface: `Contabilidade.Funcoes` já usa essa unit na própria interface, e referenciar de volta fecharia um ciclo de interface — erro de compilação. Por isso o tri-estado fica como par de `Boolean` nos campos (`FblnLOGAJC` = existe, `FblnLogAjcSondado` = resposta conclusiva) e o enum vive só dentro de `pResolverLogAjc`, na implementação, onde `Contabilidade.Funcoes` já estava na `uses`.

`pResolverLogAjc` é chamado no construtor (depois de `pConfiguraConexao`, que já deixou a `FDDatabase` conectada) e de novo em `pGravarLogAjc` quando a primeira sondagem não foi conclusiva. Sem essa segunda tentativa, uma falha transitória na criação do objeto faria o lote inteiro deixar de auditar em silêncio — o mesmo defeito que motivou o requisito.

Efeito de a sondagem falhar no meio de uma operação: `DoBeforeEdit` não tira o retrato e `DoBeforePost` cai no fallback de `OldValue` que já existia. Degrada para o comportamento anterior, não quebra.

### Defeito 5 — cancelar no `finally`, não nos handlers

O problema não é *qual* exceção estoura, é que **o caminho de saída pelo handler genérico não devolve a query ao estado de navegação**. Consertar handler por handler deixaria descobertos o terceiro caminho (uma exceção levantada de dentro do próprio handler) e o quarto (um `Exit` que alguém acrescente amanhã naquelas cem linhas).

Bancada (CA15b) delimitou o alcance: o `DataController.Cancel` do handler `EUniError` **alcança** o dataset, então falha no próprio `Post` já estava coberta. O vazamento é só pelo `On E: Exception` — e como `EUniError` descende de `EDatabaseError` e é capturada antes, o que vaza é exceção que não é de banco. Encaixa nos dois gatilhos do defeito 7.

Por isso o cancelamento vai no `finally` que já existe ali para o `TLogAjcOpContext.EndContext` — um ponto só, cobrindo todo escape:

```pascal
If qryParCon.State In [dsEdit, dsInsert] Then
  qryParCon.Cancel;
```

A condição de estado não é defensividade solta: no caminho de sucesso a query está em browse quando chega no `finally`, e se `pCarregaParCon` (última linha do `try`) falhar, ela pode estar em `dsInactive`. `Cancel` fora de edição levanta exceção — dentro de um `finally`, mascararia a exceção original.

O `Cancel` não interfere na auditoria: `DoBeforeCancel` não é sobrescrito, e o snapshot que o `DoBeforeEdit` tirou é descartado no próximo `Edit` (que começa com `pLimparSnapshot`) ou substituído no próximo `Delete`. Foi essa decisão, tomada no defeito 2, que deixa o cancelamento seguro aqui.

**Nota de ordem entre as correções:** com o defeito 2 corrigido, esse `Post` implícito passaria a **gerar** LOGAJC — o retrato foi tirado lá atrás, no `Edit`. Ou seja, sem o defeito 5 corrigido junto, a auditoria consertada registraria fielmente uma gravação que não deveria ter acontecido.

### Defeitos 6 e 7 — toda escrita em PARCON pela query auditada

A regra do solicitante — *tudo que altera PARCON precisa ser auditado na LOGAJC* — dá o critério. Duas condições têm de valer juntas: a query precisa ser `TUniQueryAuditoria` (via `fCriaQueryContabilidade`) **e** a gravação precisa passar por `Edit`/`Append`/`Delete` + `Post`. `ExecSQL` fica proibido para DML em PARCON: os hooks de auditoria são eventos de dataset e `ExecSQL` passa por baixo deles. Faltar qualquer uma das duas produz escrita silenciosa.

| Rotina | Faltava | Correção |
|---|---|---|
| `pAtualizaMd5` | a query auditada | troca `fCriaQuery` por `fCriaQueryContabilidade`; `Edit`/`Post` já estavam certos |
| `pAtualizaVigenciaNull` | as duas | `fCriaQueryContabilidade` + `SELECT` / `Edit` / `Post` no lugar do `UPDATE ... ExecSQL` |
| `pDeletarParametro` | o `Edit`/`Delete` | `SELECT` + laço de `Delete` no lugar do `DELETE ... ExecSQL` |

Detalhe de compilação que dita a forma: a variável local continua declarada `TUniQuery` mesmo recebendo `fCriaQueryContabilidade`. `pSetarFiltroEmpresa` recebe `var TUniQuery`, e parâmetro `var` em Delphi exige tipo exato — declarar `TUniQueryAuditoria` não compilaria. O objeto é `TUniQueryAuditoria` em tempo de execução e os métodos virtuais disparam normalmente. É o mesmo arranjo que a `qryParCon` já usava desde sempre.

O preenchimento de MD5 do `FormCreate` ganhou `TLogAjcOpContext.BeginContext`/`EndContext` em volta do laço: é **uma** operação que toca N registros, não N operações, e um `SEQAJU` só deixa isso legível na consulta.

`pDeletarParametro` passou a usar o mesmo formato de `pDeletarContasDesmem` e `pDeletarDadosDoComplemento` — que já estavam certos. Era só o pai que saía por fora.

**Defeito 7 — os dois gatilhos.** Não causam gravação indevida (a rede do defeito 5 cobre isso), mas provocam a falha e o erro cru:

- `edtCmpDebito` sem seleção grava string vazia. Não é default inventado: o primeiro item da lista é literalmente `''`, então "nada selecionado" e "complemento vazio" são o mesmo valor. O `ItemIndex` vira -1 porque `pCarregarComboDeComplementos` faz `Items.Clear` e nada o reposiciona.
- Vigência ganhou crítica de data válida junto das outras validações de tela, **antes** de qualquer `Edit` — com `TryStrToDate`, mensagem própria e `Exit`. `fPreencheuVigencia`/`fPreencheuVigenciaFinal` só testam se há texto.

## 2. Arquivos impactados

| Arquivo | Ação |
|---|---|
| `Contabilidade/View/Contabilidade.View.ParametrosContabilizacao.pas` | alterar — 5 pontos (defeito 1), cancelamento no `finally` (defeito 5), 3 rotinas de escrita em PARCON (defeito 6), 2 guardas (defeito 7) |
| `Contabilidade/Classes/Contabilidade.Classes.UniQueryAuditoria.pas` | alterar — 3 pontos (defeito 2), `fNormalizarValor` (defeito 3), campo `FblnLogAjc` substituído por resolvedor + cache global (defeito 4) |
| `Contabilidade/Classes/Contabilidade.Classes.LogAjc.pas` | alterar — constante nova, função renomeada, 2 chamadas (defeito 3) |
| `Contabilidade/Classes/Contabilidade.Classes.TGravacaoEmLote.pas` | alterar — 3 truncamentos inline (`VALANT`, `VALATU`, `INCDOC`) + `Contabilidade.Classes.LogAjc` na `uses` de implementação (defeito 3) |
| `Contabilidade/Outros/Contabilidade.Funcoes.pas` | alterar — enum `TSondaTabela` e função `fSondarTabelaContabil`, ambos aditivos (defeito 4) |

O defeito 5 não acrescenta arquivo: é uma alteração no `btnConfirmarClick` da View já listada acima.

Nenhum `.dpr`/`.dproj` tocado. `LeftStr`, `sLineBreak`, `fEmptyStr` e `fMensagem` já eram usados na View. `Contabilidade.Classes.LogAjc` já estava na `uses` de implementação de `UniQueryAuditoria`; a única inclusão nova de unit é em `TGravacaoEmLote`, e expõe apenas `TLogAjc`, `CTamMaxIncDoc` e `CTamMaxValor` — Delphi não reexporta a `uses` de interface da unit incluída, então nada de UniDAC entra no escopo de um arquivo FireDAC.

## 3. Sequência de implementação

### `Contabilidade.Classes.UniQueryAuditoria.pas`

1. Declarar `procedure DoBeforeEdit; override;` na seção `protected`, antes de `DoBeforePost` (linha 34).
2. Implementar `DoBeforeEdit` logo antes de `DoBeforePost` (linha 292):
   ```pascal
   procedure TUniQueryAuditoria.DoBeforeEdit;
   begin
     // Captura o snapshot no inicio da edicao, quando Value ainda traz o valor original
     // vindo do banco. Evita depender de OldValue no DoBeforePost: em query com JOIN ou
     // coluna calculada o OldValue nao devolve o valor anterior, o fallback assume o valor
     // NOVO e o diff do DoAfterPost fica vazio -- nada era gravado na LOGAJC.
     pLimparSnapshot;

     if FLogar and FblnLogAjc then
       pCapturarSnapshot(False);

     inherited DoBeforeEdit;
   end;
   ```
3. Em `DoBeforePost` (linha 312), trocar `pCapturarSnapshot(True)` incondicional pelo fallback:
   ```pascal
   if FEstadoAntes = dsEdit then
   begin
     // snapshot ja veio do DoBeforeEdit; OldValue fica apenas como fallback
     if FSnapshotAntes.Count = 0 then
       pCapturarSnapshot(True);
   end
   else if FEstadoAntes = dsInsert then
     pLimparSnapshot;
   ```

### `Contabilidade.View.ParametrosContabilizacao.pas`

4. Declarar `strTipLanOriginal : String;` junto de `strSeqPar` (linha 253).
5. Inicializar `strTipLanOriginal := '';` no `FormCreate`, junto de `strSeqPar := ''` e `intRegAlt := 0` (linha 2264).
6. Capturar em `pCarregarDadosEmTela`, logo após `edtTipLan.ItemIndex := fGetIndexTipLan(...)` (linha 4135):
   ```pascal
   strTipLanOriginal := qryParCon.FieldByName('CON_TIPLAN').AsString;
   ```
7. Zerar em `pLimparTela`, junto de `edtTipLan.ItemIndex := -1` (linha 4669).
8. Inserir a trava em `btnConfirmarClick`, entre o `End;` do diálogo e o `If (not blnCancelarOperacao)...` (linhas 744–760).

### Defeito 3 — unificação do limite

9. `Contabilidade.Classes.LogAjc.pas`, seção `const` da `interface`: declarar `CTamMaxValor = 512` ao lado de `CTamMaxIncDoc`, com o comentário explicando por que os dois pontos têm de usar a mesma constante.
10. `Contabilidade.Classes.LogAjc.pas`: renomear `fLimitarTexto250` para `fLimitarTextoValor` (declaração, implementação e as duas chamadas em `pAtribuirParametrosInsert`), trocando o literal `250` por `CTamMaxValor`.
11. `Contabilidade.Classes.UniQueryAuditoria.pas`, `fNormalizarValor`: trocar os dois literais `512` por `CTamMaxValor`, com uma linha apontando para a constante.
12. `Contabilidade.Classes.TGravacaoEmLote.pas`: acrescentar `Contabilidade.Classes.LogAjc` à `uses` de implementação e trocar os dois `Copy(..., 1, 250)` de `VALANT`/`VALATU` por `CTamMaxValor`.
13. `Contabilidade.Classes.TGravacaoEmLote.pas:1136`: trocar o `Copy(..., 1, 20)` de `INCDOC` por `CTamMaxIncDoc`.
14. Conferir que não sobrou literal: `grep "fLimitarTexto250\|, 1, 250)\|, 1, 20)\|> 512\|, 1, 512)"` em `Contabilidade/Classes/` deve vir vazio.
15. Conferir os dois gravadores da LOGAJC lado a lado: todas as colunas devem usar o mesmo limite.

### Defeito 4 — sonda própria e resolução sob demanda

16. `Contabilidade.Funcoes.pas`, seção `type` da `interface`: declarar `TSondaTabela = (staExiste, staNaoExiste, staFalhou)` com o comentário explicando por que são três estados.
17. `Contabilidade.Funcoes.pas`, `interface`: declarar `fSondarTabelaContabil(const AstrTabela: String; const AConexao: TUniConnection): TSondaTabela`, junto de `fGetSQLInsertLogAjc`.
18. `Contabilidade.Funcoes.pas`, implementação: sonda via `INFORMATION_SCHEMA.TABLES` com `ParamByName`, `try/finally` na query e `except` devolvendo `staFalhou`.
19. `UniQueryAuditoria.pas`: remover o campo `FblnLogAjc` e declarar, na seção privada, `fChaveConexao`, `fLogAjcExisteNaConexao` (ambas `class function ... static`) e `fLogAjcDisponivel`.
20. `UniQueryAuditoria.pas`: constante `CTabelaLogAjc` e globais `GCacheLogAjc: TDictionary<String, Boolean>` / `GCacheLockLogAjc`.
21. Implementar as três funções antes do construtor; `staFalhou` sai por `Exit(False)` **sem** gravar no cache.
22. Remover a linha `FblnLogAjc := fTabelaExiste('LOGAJC');` do construtor.
23. Trocar os cinco pontos de uso de `FblnLogAjc` por `fLogAjcDisponivel` (3 em `if FLogar and ...`, 2 em `if not ...`).
24. Criar e liberar o cache novo na `initialization` / `finalization`, ao lado do cache de PK.
25. Conferir que não sobrou referência a `FblnLogAjc` nem a `fTabelaExiste` na unit de auditoria.
26. `Contabilidade.Funcoes.pas`: extrair o SQL para `CSQLSondaTabelaContabil`, marcar a assinatura existente como `overload` e acrescentar a sobrecarga para `TFDConnection`; `FireDAC.Comp.Client` na `uses` de interface.
27. `TGravacaoEmLote.pas`: campo `FblnLogAjcSondado` e método `pResolverLogAjc` na seção privada.
28. `TGravacaoEmLote.pas`: no construtor, trocar `FblnLOGAJC := fTabelaExiste('LOGAJC')` por `pResolverLogAjc` — **sem** tocar na linha vizinha do `LANDET`, que fica para outro requisito por decisão do solicitante.
29. `TGravacaoEmLote.pas`, `pGravarLogAjc`: sondar de novo quando a resposta do construtor não foi conclusiva, antes do `if not FblnLOGAJC then exit`.

### Defeito 5 — rede de segurança contra gravação atrasada

30. `Contabilidade.View.ParametrosContabilizacao.pas`, `btnConfirmarClick`: no `finally` que já existe para o `TLogAjcOpContext.EndContext` (linha 969), cancelar a query se ela tiver ficado em edição:
    ```pascal
    If qryParCon.State In [dsEdit, dsInsert] Then
      qryParCon.Cancel;
    ```
31. Comentário no ponto explicando o mecanismo — é uma linha que parece supérflua e que alguém removeria numa limpeza.

## 4. Desvios em relação à análise original do DelphAI

Três, todos verificados contra o código antes de aplicar.

| Desvio | Motivo |
|---|---|
| `pLimparSnapshot;` incondicional no início do `DoBeforeEdit` | O fallback do `DoBeforePost` testa `FSnapshotAntes.Count = 0`. Sem a limpeza, um snapshot remanescente de outra operação (um `DoBeforeDelete` anterior — `DoAfterDelete` não limpa a lista) satisfaria `Count > 0` e seria usado como "valor anterior" do registro errado. Com a limpeza, o teste significa exatamente "o `DoBeforeEdit` não capturou". |
| `strTipLanOriginal := '';` em `pLimparTela` (não previsto na análise) | `blnAltera` nunca volta a `False` após um salvamento bem-sucedido — `pLimparTela` é chamado mas não mexe na flag. Sem o reset, um parâmetro novo digitado logo após uma gravação compararia o tipo novo contra o tipo do registro anterior e poderia bloquear indevidamente. `pLimparTela` também roda no topo do `pCarregarDadosEmTela`, antes da captura, então o carregamento segue correto. |
| `(edtTipLan.ItemIndex >= 0)` acrescentado à condição da trava | Defensivo. `edtTipLan.Items[-1]` levantaria exceção. Na prática o índice já é válido nesse ponto (a linha 737 do original o desreferencia antes), mas a guarda é barata. |

## 5. Estratégia de teste

Validação **manual**. Esta tela é VCL desktop — não há suíte automatizada que a alcance, e os casos de teste da zona moderna são escritos por analista humano (CLAUDE.md, seção Testes).

A entrega de quem implementa é o contrato e a **lista de casos a cobrir** — os critérios de aceitação CA01 a CA07 do `spec.md`, reproduzidos como roteiro no `tasks.md` fase 3.

Ponto de atenção na regressão: o `DoBeforeEdit` alcança **oito outros forms** do módulo Contabilidade. O CA06 existe para isso — não basta validar a tela de Parâmetros.

## 6. Riscos

| Risco | Mitigação |
|---|---|
| Não foi possível provar que `OldValue` falha especificamente neste JOIN — a UniDAC está só como `.dcu` (sem `MemDS.pas`/`Uni.pas` na árvore nem no Studio\17.0) | A correção independe do modo de falha: se `OldValue` levanta exceção (o `except` cai em `Value`) ou se devolve silenciosamente o valor novo, os dois casos produzem `LvalorAnt = LvalorAtu`. Capturar no `Edit` contorna ambos. O breakpoint em `DoAfterPost` sugerido pela análise continua valendo como confirmação. |
| Snapshot passa a ser tirado em toda edição, mesmo nas que o usuário cancela | Custo é um `TStringList` do tamanho do `Fields.Count`, só quando `FLogar and FblnLogAjc`. O `pLimparSnapshot` garante que nada vaze para a operação seguinte. |
| Com o diff funcionando, todo `ALT` passa a gravar também `CON_DTAHRA` (reatribuído com `fNow()` a cada gravação) | Comportamento correto e esperado — apenas uma linha extra de LOGAJC por alteração. Registrar na conferência do CA04 para não ser lido como defeito. |
| `TGravacaoEmLote` recebeu unit nova na `uses` — é a alteração com maior chance de acusar algo na compilação | A inclusão expõe só três identificadores (`TLogAjc`, `CTamMaxIncDoc`, `CTamMaxValor`), e Delphi não reexporta a `uses` de interface da unit incluída, então UniDAC não entra no escopo deste arquivo FireDAC. Varredura por colisão de nome de `CTamMaxValor` no projeto inteiro: nenhuma. Ainda assim é o ponto a olhar primeiro se a compilação reclamar. |
| Instalação com `LOG_VALANT`/`LOG_VALATU` mais estreitos que 512 passaria a receber texto maior | A largura de 512 foi confirmada pelo solicitante no banco desta base. Em MySQL fora do modo estrito o excesso seria truncado em silêncio (volta ao sintoma original, sem piorar); em modo estrito viraria erro na gravação — e, pelo acoplamento do item 6 da seção "outros erros silenciosos" do spec, derrubaria a gravação do dado. Conferir a largura antes de subir a correção para outras bases. |
| Não compilado | Fase 2 do `tasks.md`. |
