# Plano de Execução — Req. 465663

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Alteração localizada em duas units da zona Legado, mantendo o estilo existente (Hungarian, cadeia fluent de `TRecTransfEstoqueDevolucao`, SQL via `SQL.Add` com `ParamByName`). Sem refatoração adicional.

1. `fExecutar` ganha a coluna `ORIGEM_DOC` nos dois SELECTs atuais e um terceiro SELECT (NOTGER) ligado por `UNION ALL`.
2. A classe expõe o valor por um método fluent com parâmetro `out`.
3. O form guarda o valor em um campo, ao lado de `FstrAutIncVenda`.
4. `fCarregaClienteConsumidor` escolhe a tabela do `FROM` por whitelist.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untRecTransfEstoqueDevolucao.pas | padra_atualizado/fontes/movimentacaoitens/ | alterar |
| untRecTransfEstoque.pas | padra_atualizado/fontes/movimentacaoitens/ | alterar |
| untEfetivaMovimentoFiscal.pas | padra_atualizado/fontes/movimentacaoitens/ | sem alteração (só valida o efeito) |

## 3. Sequência de implementação

1. **untRecTransfEstoqueDevolucao.pas — declaração**
   - Campo privado `FOrigemDoc: String`.
   - Método público `fOrigemDocumento(out ATabelaOrigemDocDev: String): TRecTransfEstoqueDevolucao;` e sua implementação (`Result := Self; ATabelaOrigemDocDev := FOrigemDoc;`).
2. **untRecTransfEstoqueDevolucao.pas — `fExecutar`**
   - Ramo 1 (`NFEDEV`/`NFESAI` em MOVGER): acrescentar `,'MOVGER' ORIGEM_DOC` como última coluna.
   - Ramo 2 (`NFEENT` em MOVGER): acrescentar `,'MOVGER' ORIGEM_DOC` como última coluna.
   - Ramo 3 (novo), após o `GROUP BY` do ramo 2 e com `UNION ALL`:
     - colunas na mesma ordem do ramo 1: `NFEDEV.AUTOINCREM`, `NFESAI.AUTOINCREM`, `NFESAI.GER_CODEMP`, `NFESAI.GER_NUMDOC`, `NFESAI.GER_ESPDOC` e `'NOTGER' ORIGEM_DOC`;
     - `MOVGER NFEDEV`, `CADEMP EMPDEV`, `MOVDET` com `LOCATE(MOVDET.DET_CLAFIS, :CFOP)`;
     - `JOIN NOTGER NFEENT` e `LEFT JOIN NOTGER NFESAI` (mesmas condições do ramo 1);
     - `WHERE NFEDEV.AUTOINCREM = :AUTOINCREM` e `GROUP BY NFEDEV.AUTOINCREM, NFESAI.AUTOINCREM`.
   - Trocar também o `UNION` existente entre os ramos 1 e 2 por `UNION ALL`, de modo que os três ramos usem o mesmo conector, e que o `ORDER BY` e o `LIMIT 1` finais continuem valendo para o conjunto inteiro.
   - Após o `Open`, `FOrigemDoc := FqryDataSet.FieldByName('ORIGEM_DOC').AsString;`.
3. **untRecTransfEstoque.pas — campo e reset**
   - Declarar `FstrOrigemDoc: String;` na seção private, ao lado de `FstrAutIncVenda`.
   - Em `pPreparaFlagsDevolucao`: `FstrOrigemDoc := '';` junto dos demais resets.
   - Na cadeia fluent: acrescentar `.fOrigemDocumento(FstrOrigemDoc)` após `.fAutoincrementoVenda(FstrAutIncVenda)` (o ponto e vírgula passa para o novo último elemento).
4. **untRecTransfEstoque.pas — `fCarregaClienteConsumidor`**
   - Assinatura (declaração e implementação): `fCarregaClienteConsumidor(AAutInc, ATabelaOrigemDocDev: String): Boolean`.
   - `FROM`: `NOTGER` se `SameText(ATabelaOrigemDocDev, 'NOTGER')`, senão `MOVGER`. Nenhum valor recebido é concatenado no SQL.
   - Resto da query (`ParamByName('AUTOINCREM')`) sem mudança.
5. **untRecTransfEstoque.pas — chamada**
   - No bloco `With cdsConsulta, recTotais`: `fCarregaClienteConsumidor(FstrAutIncVenda, FstrOrigemDoc);`
6. **Edição e validação de encoding**
   - Todas as alterações nos `.pas` via um único script Python em cp1252 com `newline=''`.
   - Conferir que o arquivo decodifica em cp1252, que não há `\xef\xbf\xbd` e que o diff contém só as mudanças previstas.

## 4. Conformidade com padrões do projeto

- Zona Legado: Hungarian (`FstrOrigemDoc`, prefixo `A` em parâmetro), prefixo `f` em funções fluent, estilo `SQL.Add` da unit.
- Identificadores sem número de requisito.
- Sem `Now`, `StrToFloat`, `.SetFocus`, `ActiveControl :=`, `Application.CreateForm`; sem componentes proibidos.
- SQL com parâmetros; a escolha da tabela é por comparação com valores fixos.
- Comentário curto no fonte nos pontos não óbvios (por que a tabela de origem é necessária, por causa da colisão de AUTOINCREM entre MOVGER e NOTGER), com referência `Verificar Nota N - Req. 465663` e explicação completa no relatório de análise (`resumoAnaliseRequisito`).

## 5. Estratégia de testes

Não há suite DUnit para essas units. Validação manual e por consulta:

- **SQL:** executar o SELECT final (3 ramos) no banco em modo leitura para `AUTOINCREM = 00100000001324782100`; esperado `GER_SAIDA_ = 00100000000005845001` e `ORIGEM_DOC = 'NOTGER'` (já validado individualmente para o ramo novo).
- **Regressão MOVGER:** devolução com origem em MOVGER continua reconhecida, com `ORIGEM_DOC = 'MOVGER'`.
- **Cliente consumidor:** devolução com origem em NOTGER e cliente consumidor carrega SGS COMERCIO DE PECAS LTDA (e não o cliente da MOVGER com o mesmo AUTOINCREM).
- **Sem venda encontrada:** sem erro e comportamento atual mantido.
- **untEfetivaMovimentoFiscal:** compila e reconhece a devolução com origem NOTGER.

## 6. Riscos e mitigação

- Colisão de AUTOINCREM entre MOVGER e NOTGER → o `ORIGEM_DOC` guia a tabela; padrão MOVGER quando vazio.
- União posicional de colunas → `ORIGEM_DOC` sempre a última, nos três SELECTs.
- Prioridade entre ramos pela ordem numérica de `GER_SAIDA_` → mantida por decisão; documentar.
- Corrupção de acentos por ferramenta de edição → editar só via Python em cp1252 e validar o diff.
- Lista de CFOP → o ramo novo usa `:CFOP` (`VS_strClaDev + VS_strClaDVC`), não o literal do exemplo.

## 7. Replicação nas demais cópias

Após validar na 74.150.45, aplicar a mesma correção em 379.48.2.30.74.150.100, 379.48.2.30.74.150 e 74.Fechadas\74.150.45.Fechadas\379.48.2.30.74.150.45.67 (units nos mesmos caminhos `padra_atualizado/fontes/movimentacaoitens/`). Antes de aplicar, comparar as units com as da 74.150.45, pois podem divergir. Detalhamento na Fase 4 de `tasks.md`.
