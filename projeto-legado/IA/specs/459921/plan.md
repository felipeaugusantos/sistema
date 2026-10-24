# Plano de Execução — Req. 459921

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Adicionar um novo membro ao enum `TDestinoRel` e seu rótulo em `ArrDestino`; criar a unit geradora `untGeraArquivoSaida` (espelhando `TGeraTXT`/`TGeraCSV`), que percorre o dataset do resultado (`FGeraGR3.qryDados[0]`) e grava um arquivo por registro, atualizando o `frmGravando` arquivo-a-arquivo; despachar o novo destino em `TGeraFR3.fExecutaRelatorio` via novo método `fExportaArquivoSaida`; incluir controles de encoding (`REL_ENCARQ`) e sanitização (`REL_SANARQ`) no cadastro (`untCadRelatorios`); resolver a pasta de destino pelo filtro `REL_PASSAI` ou, quando desligado, por seletor de pasta na tela (padrão da saída PDF).

Fluxo em runtime (reutilizado): `cklDestin` (cadastro) grava `REL_DESTIN` → `pMontaDestinos`/`fGetDestinoRel` selecionam o destino → `fExecutaRelatorio` despacha por `Case desDestino`.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untFuncEditorRel | padra_atualizado/fontes/editorRelatorios/untFuncEditorRel.pas | alterar |
| untGeraArquivoSaida | padra_atualizado/fontes/editorRelatorios/untGeraArquivoSaida.pas | criar |
| untGeraFR3 | padra_atualizado/fontes/editorRelatorios/untGeraFR3.pas | alterar |
| untInterfaceRelatorio | padra_atualizado/fontes/editorRelatorios/untInterfaceRelatorio.pas | alterar |
| untCadRelatorios (.pas) | padra_atualizado/fontes/editorRelatorios/untCadRelatorios.pas | alterar |
| untCadRelatorios (.dfm) | padra_atualizado/fontes/editorRelatorios/untCadRelatorios.dfm | alterar |
| libEditorRelatorios (.dpr) | padra_atualizado/fontes/editorRelatorios/libEditorRelatorios.dpr | alterar |
| CADREL (schema) | banco MySQL (externo ao repo) | criar colunas REL_ENCARQ, REL_SANARQ |

## 3. Sequência de implementação

1. **Enum + rótulo** (`untFuncEditorRel.pas`): adicionar `desArquivoSaida` ao final de `TDestinoRel`; ajustar o limite superior do array `ArrDestino: Array[desVideo..desArquivoSaida]`; incluir o rótulo `'Arquivo Saída'`.
2. **Unit geradora** (`untGeraArquivoSaida.pas`, criar): classe `TGeraArquivoSaida` com:
   - propriedade `objGeraGR3: TGeraFR3`;
   - método público `fGeraArquivos(strPasta; ...): Boolean` que cria/usa `TfrmGravando` (via `pCriarFormularios`), seta `pgbStatus.Properties.Max := RecordCount` e o rótulo, e executa o laço em callback (`fExecutarAcao`);
   - validação das colunas `ARQUIVO_NOME`/`ARQUIVO_CONTEUDO` antes do laço;
   - por registro: resolver nome (sanitizar conforme `REL_SANARQ`), pular nome vazio (contabilizando), gravar conteúdo no encoding de `REL_ENCARQ`, sobrescrevendo; atualizar `lblGravando` com o nome e avançar a barra;
   - ao fim: contagem de gerados/pulados.
3. **Despacho + export** (`untGeraFR3.pas`):
   - novo método `fExportaArquivoSaida(strPasta; blnExibirMensagem): String` (modelado em `fExportaArquivoTXT`/`fExportaArquivoXML`): `fCriaDiretorio`, instanciar `TGeraArquivoSaida`, chamar `fGeraArquivos`, mensagens/`pGravaLogPaf`;
   - novo braço `desArquivoSaida:` no `Case desDestino Of`;
   - resolução da pasta: se `strPasta` vazio (REL_PASSAI desligado), solicitar pasta na tela antes de gerar (padrão do braço `desPDF`).
4. **Validação de pasta** (`untInterfaceRelatorio.pas`): incluir `desArquivoSaida` nos conjuntos de `fValidaDado` (linhas ~11817 e ~11830) para tornar o caminho obrigatório/validado quando `REL_PASSAI='S'`.
5. **Cadastro** (`untCadRelatorios.pas` / `.dfm`):
   - `.dfm`: `TDBComboBoxFocus` para `REL_ENCARQ` (Style `csDropDownList`) e `TDBCheckBox` para `REL_SANARQ` (`ValueChecked='S'`/`ValueUnchecked='N'`); atualizar o caption do checkbox `REL_PASSAI` para incluir "Arquivo Saída";
   - `.pas`: popular os itens do combo de encoding; definir defaults na inclusão (`REL_ENCARQ` = UTF-8, `REL_SANARQ='N'`), como já feito para outros campos.
6. **Projeto** (`libEditorRelatorios.dpr`): adicionar `untGeraArquivoSaida` à cláusula `uses` (editar apenas o `.dpr`).
7. **Banco (externo):** criar `REL_ENCARQ` e `REL_SANARQ` em `CADREL` via processo de atualização de banco da Citel.

## 4. Conformidade com padrões do projeto

- **Zona Legado:** Hungarian obrigatório (`str/bln/int/obj/qry…`, `F`/`A`/`p`/`f`); herança/estruturas existentes preservadas; sem refatoração proativa.
- **Componentes:** `TDBComboBoxFocus` e `TDBCheckBox` (como no cadastro atual); reuso de `TfrmGravando`. Proibidos: `TButton`/`TBitBtn` (usar `TBitBtnLocked` se necessário), `TDBGrid`, `TClientDataSet`/`TDataSetProvider`, `dxSkin*`, `frxSmartMemo`.
- **Chamadas:** `pCriarFormularios` (não `Application.CreateForm`); `fNow()` se precisar de data; `pSetFocus` se focar componente; `fMensagem`/`pMensagemOk` para mensagens; sem `StrToFloat`/`StrToFloatDef`; datasets já abertos (sem SQL novo por concatenação); gravação com `TEncoding` correto.
- **Pre-commit:** sem componentes/chamadas/SQL proibidos; `.dfm` sem `FillType = ftBrush` e sem `Outline =`.

## 5. Estratégia de testes

- **Suite:** `padra_atualizado/TestesUnitarios/` (subpasta `padra_atualizado/`).
- **Casos a cobrir:**
  - Sanitização de nome (`REL_SANARQ='S'` remove inválidos; `='N'` mantém).
  - Bytes gerados por encoding (UTF-8 sem BOM, UTF-8 com BOM, ANSI/1252, UTF-16 LE) — verificar BOM/sequência.
  - 1 registro → 1 arquivo; contagem final correta.
  - Coluna obrigatória ausente → erro, nenhum arquivo.
  - `ARQUIVO_NOME` vazio → registro pulado e reportado.
  - Sobrescrita de arquivo existente.
  - Resultado vazio → aviso, nenhum arquivo.
- Gravação em disco testada com pasta temporária; funções puras de sanitização/seleção de encoding isoladas para teste direto.

## 6. Riscos e mitigação

- Extensão de `TDestinoRel` altera `High()` → **mitigação:** ajustar o limite de `ArrDestino`; conjuntos de gráficos usam membros explícitos (revisar na compilação).
- Encoding escolhido × encoding real do dado → **mitigação:** default UTF-8; documentar no cadastro que a escolha é do responsável pelo relatório.
- Conteúdo grande (LONGTEXT/BLOB) → **mitigação:** ler o campo de forma que não trunque; testar com XML de NF-e real.
- Colunas CADREL fora do repo → **mitigação:** coordenar o deploy do schema antes de liberar; tratar ausência das colunas de forma defensiva.
