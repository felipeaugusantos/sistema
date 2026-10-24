# Plano de Execução — Req. 470760

**Referência:** spec.md
**Zona:** Moderna (`Contabilidade/`)

## 1. Abordagem técnica

Reaproveitar os dois mecanismos que o robô já tem — pular documento com erro na gravação e filtrar a geração por lista de documentos (`arrIncDoc`) — e ligá-los à tela por parâmetro novo em `TParametrosConsulta`, que o robô nunca preenche. Toda leitura e escrita da `CONPEN` fica numa classe única (repositório), consumida pela Geração e pelos dois fechamentos.

Fluxo da Geração:

1. Pré-validação como hoje (`fEfetivarLancamentos(True)`), agora com empresa e data contábil em cada erro.
2. Com erro: perguntas do RF01. Confirmado → segunda passada (`fEfetivarLancamentos(False)`) com a lista de documentos com erro (chave + tabela) em `recParCon`; `pInsertLanCon`/gravação em lote e `TGeradorContabil` descartam esses documentos.
3. Fim da segunda passada: repositório substitui as pendências do escopo (empresa × tipo × período) pelos erros `EE` da pré-validação.
4. Modo "somente com erro": monta `arrIncDoc` a partir da `CONPEN` (filtro da tela) — o `fCarregaDados` e o `fDeletaLanCon` passam a atuar só nesses documentos; o escopo de substituição da `CONPEN` é a própria lista.

### Mudanças sobre o plano aprovado (20/10/2026)

- **Sem unit nova.** Todas as units do módulo estão listadas no `autcom.dpr` de cada versão, sem caminho de busca: unit nova obrigaria a mexer no `.dpr` das seis principais. `TPendenciaContabil` foi para `Contabilidade.Classes.TListaValidacoesContabeis.pas`; `.dpr` nenhum muda.
- **Reprocesso documento a documento** (analista): `TParametrosConsulta` ganha `blnReprocessaErros`, `lstDocExcluir` e `lstDocReprocesso`; `TDadosAbertura` ganha `blnReprocessaErros` e `lstDocExcluir`. No reprocesso: exclusão de LANCON por `CON_INCDOC|CON_TABELA`, check list e LOTINC do período intocados, lista vazia nunca roda a sigla.
- **Sigla original no erro** (`ERR_SIGLA`/`PEN_SIGLA`): `strTipLan` é normalizado durante a geração (ENTADT vira ENT).
- **ADT, AJI, TCC**: coluna do filtro com a composição da chave, só no reprocesso. **TCC**: o rateio agrupado (`fCarregaDadosCadRecValorAgrupado`) não é filtrado no reprocesso.
- **CMV**: fora do modo por documento (tudo ou nada por empresa).
- **Check list**: `CONCHK.CHK_REPROC` + `TProcessaCheckList.pMarcarReprocesso` + coluna "Reproc." na tela.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| Interfaces | `Contabilidade/Interfaces/Contabilidade.Interfaces.pas` | alterar — `TContaErro` (+empresa, +data), `TParametrosConsulta` (+lista de documentos a excluir) |
| Funções | `Contabilidade/Outros/Contabilidade.Funcoes.pas` | alterar — `fCriarDataSetErros` (+`ERR_CODEMP`, `ERR_DTALAN`) |
| Validação | `Contabilidade/Classes/Contabilidade.Classes.TValidaContasContabeis.pas` | alterar — `pAddErro` grava os campos novos |
| Gerador | `Contabilidade/Classes/Contabilidade.Classes.TGerLanCon.pas` | alterar — `pAdicionarErro` (empresa/data), descarte de documento com erro na gravação |
| Gerador CTP | `Contabilidade/Classes/Contabilidade.Classes.TGeradorContabil.pas` | alterar — descarte por documento em `pGravarDadosImportacao` |
| Lista de validações | `Contabilidade/Classes/Contabilidade.Classes.TListaValidacoesContabeis.pas` | alterar se o merge descartar os campos novos |
| Pendências | `Contabilidade/Classes/Contabilidade.Classes.TListaValidacoesContabeis.pas` | alterar — classe `TPendenciaContabil`: listar, substituir escopo, existe até data |
| Abertura CTP | `Contabilidade/Classes/Contabilidade.Classes.TDadosAbertura.pas` | alterar — campos do reprocesso |
| ADT / AJI / TCC | `Contabilidade/Classes/Contabilidade.Classes.TLanConADT.pas`, `...TLanConAJI.pas`, `...TLanConTCC.pas` | alterar — coluna do filtro no reprocesso |
| CTR | `Contabilidade/Classes/Contabilidade.Classes.TLanConCTR.pas` | alterar — check list e LOTINC fora do reprocesso |
| Check list | `Contabilidade/Classes/Contabilidade.Classes.CheckListImportacao.pas`, `Contabilidade/View/Contabilidade.View.CheckListImportacao.pas` | alterar — `CHK_REPROC` e coluna "Reproc." |
| Geração | `Contabilidade/View/Contabilidade.View.GeracaoLancamentoContabil.pas/.dfm` | alterar — checkbox, botão, fluxo RF01/RF05 |
| Tela de erros | `Contabilidade/View/Contabilidade.View.ErrosContabeis.pas` | alterar — `pExibir` (sem refatorar) |
| Fechamento Contábil | `Contabilidade/View/Contabilidade.View.FechamentoContabil.pas` | alterar — bloqueio em `btnGerarClick`, antes da confirmação de raiz do CNPJ |
| Fechamento Diário/Mensal | `Contabilidade/View/Contabilidade.View.FechamentoDiaMesIncluir.pas` | alterar — aviso antes de "Confirma o fechamento do dia…" |
| External | `svn:externals` da `.150.100.12` | alterar — `^/Contabilidade@<rev do commit>` |
| DDL | Diário, Editor de DDL | cadastrar `CONPEN` (pelo programador) |

## 3. Sequência de implementação

1. `TContaErro` + dataset de erros + `pAddErro` + `pAdicionarErro` com empresa e data contábil.
2. Repositório `CONPEN` (interface + classe) e registro nos `.dpr`.
3. Descarte por documento na segunda passada (`TGerLanCon`) e no `TGeradorContabil`.
4. Fluxo novo da Geração (RF01), gravação da `CONPEN` por escopo.
5. Checkbox, botão e modo "somente com erro" (RF02–RF05).
6. Tela de pendências reaproveitando `TfrmErrosContabil`.
7. Fechamento Contábil (RF07) e Diário/Mensal (RF06).
8. Conferir robô contábil (mesmas entradas, mesma saída).
9. Mover a revisão fixa do external na `.150.100.12`.

## 4. Conformidade com padrões do projeto

- Zona Moderna: unit nova em dot-notation, interface com GUID, injeção pelo construtor; units existentes mantêm o estilo em que estão.
- Componentes: `TBitBtnLocked` (`BitBtnLockedIncrem`), `TCheckBox`.
- Chamadas: `fNow()`, `fMensagem()`, `pSetFocus()`, `pCriarForm()`, `ParamByName()`, `fStartTransaction`/`fCommit`/`fRollBack`.
- Pre-commit: sem componentes/chamadas/SQL proibidos; sem `FillType = ftBrush`/`Outline` em `.dfm`.
- Encoding: `fonte_delphi.py conferir` antes de tocar; `substituir` para arquivo com acento.

## 5. Estratégia de testes

- Em `Contabilidade/` os casos de teste são escritos por **analista humano**; a lista a cobrir é a seção 6 da spec.
- Validação manual pelo programador (Parada 3), com fotografia da `LANCON` do período antes/depois (aprendizado 469760).

## 6. Riscos e mitigação

- Robô contábil compartilha as classes → parâmetro novo vazio = caminho de hoje; conferir geração do robô antes/depois.
- SEQGER ambíguo → chave + tabela em todo filtro/remoção.
- Data contábil indisponível em erro precoce → ler do documento de origem; confirmar por tipo na Parada 2.
- `fDeletaLanCon` apaga o período inteiro → no modo "somente com erro", garantir `arrIncDoc` preenchido antes de qualquer delete; lista vazia = não gerar (RN09).
- Cliente sem a `CONPEN` → script no Diário antes da liberação.
