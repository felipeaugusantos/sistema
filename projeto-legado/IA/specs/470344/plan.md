# Plano de Execução — Req. 470344

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica
Backport da r434316 (Req. 398922). `TfrmAltNumLote` herda de `TfrmPaiSimples`. A mudança fica em `pRetornaTables`, que passa a carregar as regras `REJEITA_TABELA = 1` de `CONFIG_ALTNUMLOT` em uma `TStringList` e filtrar os nomes de tabela com `MatchesMask` antes de preencher `cdsTables`. Como `pRetornaFields` percorre só `cdsTables`, as tabelas rejeitadas deixam de gerar UPDATE.

## 2. Arquivos impactados
| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untAltNumLote.pas | padra_atualizado/fontes/util/operacoesrefitens/untAltNumLote.pas | alterar (`uses` da implementação + `pRetornaTables` + `qryFields := nil` em `pRetornaFields`) |
| libOpeRefProd.dpr | padra_atualizado/fontes/Util_DLL/OpeRefProd/libOpeRefProd.dpr | sem alteração |

## 3. Sequência de implementação
1. Adicionar `System.Masks` ao `uses` da **implementação** (ao lado de `StrUtils`); o `uses` da interface não muda.
2. Reescrever `pRetornaTables` (iniciar `qryTables`/`qryConfig`/`lstRegras` em `nil` e criá-los dentro do `try`, carregar regras, filtrar com `MatchesMask`, manter exclusão de `TMP_*` e `LOGDOR`, `DisableControls`/`EnableControls`).
2a. `pRetornaFields`: inicializar `qryFields := nil;` antes do `Try` (evita Access Violation no `finally` se `fCriaQuery` falhar).
3. Gravar em cp1252, CRLF, sem BOM, por script Python (nunca pela ferramenta `Edit`).
4. Validar encoding e `svn diff` (somente as duas mudanças).
5. Replicar o mesmo arquivo na 74.111.191.
6. Entregar ao cliente o `INSERT` de `LOGLLC_*` (RN01 do spec.md).

## 4. Conformidade com padrões do projeto
- Zona Legado: Hungarian style e prefixos mantidos nos nomes já existentes. Os nomes novos (`qryConfig`, `lstRegras`, `TableName`, `Ignorar`) vieram da r434316, sem número de requisito.
- Chamadas: sem `.SetFocus`, `StrToFloat`, `Now`, `ActiveControl :=` nem `Application.CreateForm`.
- SQL: fixo, sem concatenação de entrada do usuário.
- Pre-commit: sem componentes ou chamadas proibidas.
- Ponto de atenção: `fCriaQuery` é chamado sem dono; as queries são liberadas em `finally`.

## 5. Estratégia de testes
- Não há suite DUnit para `untAltNumLote`; validação manual.
- Casos:
  - Regra `LOGLLC_*` cadastrada: alteração do cenário (empresa 003, item 11546, `LC-11546` → `LC-11546+`) sem erro.
  - Tabela `LOGLLC_*` ausente de `cdsTables` e `cdsFields`.
  - Sem regras de rejeição: lista de tabelas idêntica à anterior.
  - Tabela comum com `xxxxNUMLOT` (ex.: `ESPDET`) atualizada normalmente.
  - Coluna `REJEITA_TABELA` inexistente: comportamento documentado (a tela falha).

## 6. Riscos e mitigação
- Coluna ausente no banco → confirmar na base de teste antes de liberar, ou proteger o código com `try/except` caso o solicitante queira.
- Regra sem cadastro no cliente → o erro persiste; enviar o `INSERT` junto com a entrega.
- Máscara muito ampla → cadastrar apenas `LOGLLC_*`.
- Corrupção de acentos por salvar em UTF-8 → edição só por Python em cp1252.
