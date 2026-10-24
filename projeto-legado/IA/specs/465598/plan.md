# Plano de Execução — Req. 465598

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Alteração localizada em SQL embutido (`.SQL.Text :=` com `ParamByName()`), na unit de cadastro de lote, sem mudança de assinatura, parâmetros, colunas ou fluxo VCL:

1. Em `fRetSQLDocEnd` (função local de `TCadLot.fSQLMovimentos`), no ramo `fCfgSis('SPCDEN', varBoolean)`, acrescentar `AND FGO_DCENUM IS NOT NULL` imediatamente antes de `AND FGO_DCENUM = <tabela>.DET_NUMDOC`. Orienta o otimizador a usar o `IDX_EXTGOR_70`, que é esparso (22 de ~1,78 milhão de linhas preenchidas).
2. Em `fSQLMovimentos`, montar o `EXISTS` de `ENDERE` com `SELECT 1` (sem `STRAIGHT_JOIN`) **apenas quando `fCfgSis('SPCDEN', varBoolean)` é verdadeiro**, liberando o MySQL para iniciar o join pela FATDOR (índice por item). Com `SPCDEN` desligada, o texto continua `SELECT STRAIGHT_JOIN 1`, como hoje. Implementação: o trecho `STRAIGHT_JOIN ` passa a ser concatenado condicionalmente (ex.: `If fCfgSis('SPCDEN', varBoolean) Then ... Else ...`), seguindo o estilo de concatenação já usado na rotina; avaliar guardar o resultado de `fCfgSis` em uma variável local para não consultar a configuração duas vezes (já é consultada em `fRetSQLDocEnd`), com nome no padrão da unit.

Ambas só mudam texto de SQL; o resultado lógico é o mesmo (INNER JOIN independe da ordem; a igualdade já descartava NULL).

3. Em `untCfgSistemaValidar.pas`, criar `class function TValidarConfiguracoes.fValidaSPCDEN: Boolean`, modelada em `fValidaDASWEB`:
   - declarar na classe, junto de `fValidaDASWEB` (linha ~287);
   - implementar logo após `fValidaDASWEB` (linha ~7670), com a função local `fTriggerExiste(strTabela, strTrigger)` **duplicada** da `fValidaDASWEB` (consulta em `INFORMATION_SCHEMA.TRIGGERS` por `TRIGGER_SCHEMA = DATABASE()`, `TRIGGER_NAME` e `EVENT_OBJECT_TABLE`, com `ParamByName()`, `try/except` com `pMensagensErro` e `FreeAndNil` da query);
   - ler o valor com `fFindCfg('CFG_SPCDEN')` / `cdsCfgSis.FieldByName('SIS_VALCFG')` (default `'N'`);
   - se `'S'` e faltar `BI_EXTGOR_DOCEND` ou `BU_EXTGOR_DOCEND` em `EXTGOR`, mostrar `fMensagem('ATENÇÃO!', ..., ['&Ok'])` e retornar `False`; senão `True`;
   - incluir `If (Not fValidaSPCDEN()) Then Exit;` na cadeia, logo após o bloco de `fValidaDASWEB` (linha ~10468).
   `fValidaDASWEB` não é alterada.

4. Em `untCfgSistema.pas`, criar `procedure TfrmCfgSistema.pAdicionarHintCFG_SPCDEN`, modelada em `pAdicionarHintCFG_LIBEQP` (linha ~10262):
   - declarar na classe junto dos demais hints (bloco ~422–436) e implementar ao lado dos outros;
   - `If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_SPCDEN' Then Exit;`, `mmoInfoCfgSis.Clear`, `pnlInfoCfgSis.Height` ajustada ao texto, `Visible := True`, `Font.Color := clRed`, `Font.Height := 16`, `Lines.Add(...)` por linha (triggers `BI_EXTGOR_DOCEND` / `BU_EXTGOR_DOCEND`, campos `FGO_DCE*` e o UPDATE dos documentos existentes — texto sugerido na spec RN06) e o `Lines[0] := Lines[0] + ''` do padrão;
   - chamar `pAdicionarHintCFG_SPCDEN;` na sequência dos demais hints (bloco ~9250–9279, após `pAdicionarHintCFG_LIBEQP`/`LIBAJU`).

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untCadLote.pas | padra_atualizado\fontes\cadastros\untCadLote.pas | alterar |
| untCfgSistemaValidar.pas | padra_atualizado\fontes\configuracoes\untCfgSistemaValidar.pas | alterar (declaração, `fValidaSPCDEN` e chamada na cadeia) |
| untCfgSistema.pas | padra_atualizado\fontes\configuracoes\untCfgSistema.pas | alterar (declaração, `pAdicionarHintCFG_SPCDEN` e chamada junto dos demais hints) |

Cópia 74.150.45: `FGO_DCENUM = ...` na linha ~5009 e `STRAIGHT_JOIN` na linha ~5037. Nenhum `.dpr`, `.dproj` ou DFM é tocado.

## 3. Sequência de implementação

1. Confirmar o encoding real da unit (esperado Windows-1252/cp1252, CRLF) lendo com Python.
2. Aplicar as alterações via Python (`io.open(..., encoding='cp1252', newline='')`), preservando o alinhamento/estilo das linhas vizinhas (`Result := Result + '...';`): inserir o `IS NOT NULL` e tornar o `STRAIGHT_JOIN` condicional a `SPCDEN`. Não usar a ferramenta `Edit`.
3. Validar: decodifica em cp1252 sem erro e não contém `\xef\xbf\xbd`.
4. Conferir o diff: somente as linhas de SQL da rotina (a nova do `IS NOT NULL` e a do `EXISTS`, que ganha a condição de `SPCDEN`).
5. Validar no banco (somente SELECT/EXPLAIN): EXPLAIN e tempo do SELECT final em MOVDET e NOTDET, empresa 004 / item 37596 / `:DTABAL` 2026-09-23, com ramo `SPCDEN` ligado e desligado.
6. Comparar o resultado (linhas e `ENDERE`) com o da versão original nos dois ramos.
7. Confirmar o encoding de `untCfgSistemaValidar.pas` (cp1252; os acentos do fonte aparecem corrompidos se lido como UTF-8) e as linhas de `fValidaDASWEB` (declaração ~287, implementação ~7622, chamada na cadeia ~10468).
8. Implementar `fValidaSPCDEN` via Python em cp1252 (declaração, implementação e chamada na cadeia), seguindo o estilo de `fValidaDASWEB`; mensagens com acento gravadas em cp1252.
9. Validar o encoding e o diff de `untCfgSistemaValidar.pas` (só declaração, implementação e chamada).
10. Confirmar o encoding de `untCfgSistema.pas` (cp1252) e as linhas de referência (declaração ~429, implementação de `pAdicionarHintCFG_LIBEQP` ~10262, chamada ~9268).
11. Implementar `pAdicionarHintCFG_SPCDEN` via Python em cp1252 (declaração, implementação e chamada), com o texto aprovado do hint; validar encoding e diff (só essas três inserções).
12. Conferir visualmente na tela de configurações (selecionar `CFG_SPCDEN` e outra configuração): altura do painel suficiente para as linhas, sem texto cortado.
13. Validar a lógica de existência das triggers por SELECT em `INFORMATION_SCHEMA.TRIGGERS` (somente leitura) nas bases disponíveis: com e sem as triggers.

## 4. Conformidade com padrões do projeto

- Zona Legado: sem refatoração; mantém estilo existente (concatenação `Result := Result + ...`, `ParamByName` nos chamadores).
- Componentes: nenhum componente novo ou proibido.
- Chamadas: nenhuma chamada proibida (`Now`, `StrToFloat`, `.SetFocus`, `ActiveControl :=`, `Application.CreateForm`).
- SQL: sem valor de usuário concatenado; o trecho novo é literal, e `strTabela` já era concatenado e só recebe `MOVDET`/`NOTDET`.
- Identificadores: nenhum novo (sem número de requisito em nomes).
- Pre-commit: sem componentes/chamadas/SQL proibidos; sem DFM alterado (sem `FillType`/`Outline`).
- Encoding: alteração só via Python em cp1252 (ver passos 2 e 8), nas duas units.
- Validação: usar `fMensagem` (não `ShowMessage`/`MessageDlg`), `fCriaQuery` para a query, `ParamByName()` e `try/except` com liberação da query, como em `fValidaDASWEB`. A função local `fTriggerExiste` é duplicada por decisão de escopo (não refatorar `fValidaDASWEB`).
- Hint: `pAdicionarHintCFG_SPCDEN` segue o nome e o corpo de `pAdicionarHintCFG_LIBEQP` (prefixo `p`, `pAdicionarHintCFG_<CFG>`); texto em `Lines.Add` (sem componente ou chamada nova), acentos gravados em cp1252.
- Nomes novos no padrão da unit: `fValidaSPCDEN` (prefixo `f`, `fValida<CFG>`), variável de valor da configuração como `strSPCDEN` (Hungarian, igual a `strDASWEB`), sem número de requisito.

## 5. Estratégia de testes

- Suite: nenhuma suite do projeto cobre esta rotina (as existentes são tributárias — `AutcomTestesClientes` —, REST e `TESTES_AUTOMATIZADOS`). Ressalva registrada.
- Evidência por consulta direta ao banco (somente leitura):
  - EXPLAIN antes/depois, `SPCDEN` ligada e desligada.
  - Tempo de execução antes/depois (item 37596, empresa 004).
  - Comparação de resultado (linhas e `ENDERE`) entre a versão original e a nova, para MOVDET e NOTDET.
- Validação SPCDEN (sem suite DUnit aplicável; verificação manual e por SELECT): `CFG_SPCDEN = 'S'` sem triggers (bloqueia), com as duas triggers (passa), com só uma delas (bloqueia), `CFG_SPCDEN = 'N'` (passa sem consultar triggers).
- Casos a cobrir: item sem movimentos sem lote (0 linhas); item com movimentos sem lote e documento endereçado (`ENDERE = 'S'`); item com movimentos sem lote e documento não endereçado (`ENDERE = 'N'`); `DET_DTAENT` nulo (`DOCSEMDATA = 'S'`).

## 6. Riscos e mitigação

- Dependência da trigger de `FGO_DCENUM` → o resultado não muda se o vínculo mudar (a igualdade exige valor); a remoção do `STRAIGHT_JOIN` com `SPCDEN` ligada evita plano ruim.
- `STRAIGHT_JOIN` mantido com `SPCDEN` desligada → plano hoje equivalente ao sem a dica; fica como está por escolha de escopo.
- Medições pontuais (uma execução, item com poucos movimentos) → repetir em item com muitos movimentos sem lote antes de concluir ganho.
- Bloqueio em bases com `SPCDEN = 'S'` sem triggers (ex.: AUTCOM consultada, empresas 001 e 004, sem triggers em `EXTGOR`) → confirmar com a Citel/DBA a existência das triggers em produção antes de liberar; a validação segue o comportamento de `fValidaDASWEB` (roda sempre que o valor é `'S'`).
- Nomes das triggers e da tabela `EXTGOR` não constam nos fontes → confirmar antes de implementar.
- Lista de campos do hint assumida (`FGO_DCE*`) e UPDATE inexistente nos fontes → confirmar os campos com quem mantém as triggers; o hint apenas informa a necessidade do UPDATE.
- Altura do painel do hint insuficiente para o texto → ajustar `pnlInfoCfgSis.Height` (referências: 50 para 2 linhas, 100–120 para mais) e conferir na tela.
- Função `fTriggerExiste` duplicada → aceito por escopo; pode ser extraída depois.
- Outras cópias do fonte continuam com o problema → propagar em passo à parte via `citel-applyPatch`.
- Corrupção de acentos por salvar a unit em UTF-8 → edição só via Python em cp1252 e validação de bytes.

## 7. Propagação para outras cópias

Escopo: cópias que possuem a configuração `SPCDEN` — 74.111, 74.150 e 74.150.100. A 72 não possui (fora). Mesmas alterações da 74.150.45, aplicadas via Python em cp1252 em cada cópia:

| Cópia | untCadLote | untCfgSistemaValidar | untCfgSistema |
|-------|-----------|----------------------|---------------|
| 74.150 | `IS NOT NULL` (~5210) + `STRAIGHT_JOIN` condicional (~5238) | `fValidaSPCDEN` (decl. ~292, impl. após ~8124, chamada após ~11142) | hint (modelo `pAdicionarHintCFG_LIBEQP`, decl. ~456, impl. ~2564, chamada ~9863) |
| 74.150.100 | `IS NOT NULL` (~5141) + `STRAIGHT_JOIN` condicional (~5169) | `fValidaSPCDEN` (decl. ~291, impl. após ~7855, chamada após ~10874) | hint (modelo `pAdicionarHintCFG_LIBEQP`, decl. ~456, impl. ~2549, chamada ~9848) |
| 74.111 | só `IS NOT NULL` (~4386); sem `STRAIGHT_JOIN` (SQL diferente) | `fValidaSPCDEN` (decl. ~278, impl. após ~6601, chamada após ~8993) | hint sem `LIBEQP` na cópia: usar como modelo outro hint existente (ex.: `pAdicionarHintCFG_ZFMDES`, ~981) ou copiar da 74.150.45 |

- Linhas aproximadas; localizar por nome antes de editar.
- O `if` da SPCDEN já existe nas três; nenhuma inclusão de `if` necessária.
- Conferir em cada cópia o encoding (cp1252) e o diff; a 74.111 exige EXPLAIN do SELECT próprio antes de alterar.
