# Especificação — Req. 470760

**Título:** Geração contábil parcial com pendências de erro (tabela CONPEN)
**Objetivo:** Acabar com o "tudo ou nada" da Geração de Movimento: gerar os documentos sem erro, guardar os com erro numa tabela de pendências, permitir reprocessar só esses e tratar as pendências nos fechamentos.
**Zona:** Moderna (`Contabilidade/`, external `^/Contabilidade`)
**Data:** 20/10/2026
**Cliente de origem:** AMARELINHA (489-0). Substitui o Req. 470568 (baixado como "atendido pelo 470760").

## 1. Contexto / problema atual

Em CONTABILIDADE > EXPORTAÇÃO / GERAÇÃO DE DADOS > GERAÇÃO DE MOVIMENTO (INTERNO AUTCOM), a geração roda em duas passadas: pré-validação (`fEfetivarLancamentos(True)`) e gravação (`fEfetivarLancamentos(False)`). Um único erro em qualquer documento, tipo ou empresa faz a pré-validação devolver falso; a tela de Inconsistências (`TfrmErrosContabil`) é exibida e **nada** é gravado na `LANCON`. Os erros vivem só em memória (dataset de `fCriarDataSetErros`) e se perdem ao fechar a tela.

O robô contábil (`MonitorContabil`) já grava só os documentos sem erro (`fEfetuaLancamentosPreValidacao` + `fTemErroModoRobo`) e já reprocessa por lista de documentos (`TParametrosConsulta.arrIncDoc` → `TTrataIncDocContabil`, aplicado no `fCarregaDados` e no `fDeletaLanCon`). A tela não usa nenhum dos dois.

## 2. Módulos e entidades envolvidos

- Módulo: Contabilidade (compilado no `autcom.exe` e no `MonitorContabil.exe`).
- Telas (menu): Geração de Movimento (`TfrmGerLanCon`), Fechamento Contábil (`TfrmFechamentoContabil`), Fechamento Contábil Diário/Mensal (`TfrmIncluiFechamentoDiaMes` / `TFechamentoContabilDiaMes`).
- Tabelas: `LANCON` (lançamentos, `CON_INCDOC` = chave do documento, `CON_TABELA`), **`CONPEN` (nova)**.

### Tabela nova `CONPEN` — pendências da geração contábil

| Campo | Tipo | Nulo | Observação |
|---|---|---|---|
| `AUTOINCREM` | bigint(20) auto_increment | não | PK |
| `PEN_CODEMP` | char(3) | não | empresa do lançamento |
| `PEN_TIPLAN` | char(3) | não | tipo marcado na tela (CTR, CTP, ENT…) |
| `PEN_SIGLA` | varchar(20) | não | sigla do gerador que deu o erro (ENTADT, SES, CTR_ADT_CC…); separa as chaves dos tipos irmãos no reprocesso |
| `PEN_TIPERR` | char(3) | não | tipo do erro (`ERR_TIPLAN`), usado pelo "Documento de origem" |
| `PEN_TABELA` | varchar(20) | não | tabela de origem do documento (desambigua SEQGER MOVGER × NOTGER) |
| `PEN_CHVDOC` | varchar(100) | não | chave do documento (`TChaveDocInterprete`, = `LANCON.CON_INCDOC`) |
| `PEN_DTALAN` | date | não | data contábil do documento |
| `PEN_MOTIVO` | text | sim | motivo do erro |
| `PEN_HISTOR` | text | sim | histórico |
| `PEN_DESVAL` | varchar(50) | sim | descrição do valor |
| `PEN_NATOPE` | varchar(50) | sim | natureza / CFOP |
| `PEN_ORIPLA` | varchar(100) | sim | origem (Portador, Cliente/Fornecedor…) |
| `PEN_PLANCO` | varchar(50) | sim | plano de contas |
| `PEN_CODOPE` | char(3) | não | operador que gerou |
| `PEN_DTAGER` | datetime | não | data/hora da geração (`fNow()`) |

Índices: `(PEN_CODEMP, PEN_TIPLAN, PEN_DTALAN)` e `(PEN_CHVDOC, PEN_TABELA)`. Sem FK. O script é cadastrado pelo programador no Editor de DDL do Diário (`scrger`), não por código.

### Coluna nova `CONCHK.CHK_REPROC`

`char(1) NOT NULL DEFAULT 'N'`. `'S'` = o dia teve reprocesso de documentos com erro para aquele tipo e empresa. Uma geração normal posterior apaga e recria as linhas do check list, e a marca volta a `'N'`. A tela do Check List mostra a coluna "Reproc." em cada tipo.

Sem a `CONPEN` ou sem a `CHK_REPROC` no banco, a tela segue no comportamento anterior (a opção nova não aparece; a coluna "Reproc." não aparece).

## 3. Requisitos funcionais

- **RF01** — Na Geração, havendo erro na pré-validação, exibir: *"Durante a Geração do(s) Movimento(s), foi(ram) identificado(s) Registro(s) com ERRO(S) que impedem a sua geração. Gostaria de visualizar o(s) Registro(s)?"* (Sim/Não).
  - **Não** → operação abortada (nada gravado, nem `LANCON` nem `CONPEN`).
  - **Sim** → abre a tela de erros atual; ao **Sair**: *"Os registros com erro não serão gerados e ficarão pendentes para correção. Deseja gerar os registros que não apresentam erros?"* (Sim/Não). Texto alterado pelo programador em 21/10/2026; o do requisito era "Pré-validação dos registros que não apresentam erros concluída, deseja efetuar a geração?". Sim → gera os documentos sem erro e grava os com erro na `CONPEN`. Não → aborta.
- **RF02** — Nova opção na Geração: **"Somente Lançamentos com Erro"**, desmarcada por padrão.
- **RF03** — Com RF02 marcada, aparece o botão **"Lançamentos com Erro"** na barra inferior; desmarcada, o botão some.
- **RF04** — O botão abre a tela de pendências com os registros da `CONPEN` filtrados pela empresa (ou raiz do CNPJ), período e tipos marcados, com exportação Excel e "Documento de origem" idênticos à tela atual.
- **RF05** — Ao Sair da tela de pendências: *"Aviso: Efetuar a geração dos lançamentos?"* (Sim/Não). Sim → reprocessa **somente** os documentos listados.
  - Todos gerados: *"Todos os lançamentos que apresentavam erros foram gerados com sucesso"*.
  - Restaram erros: *"Nem todos os lançamentos que apresentavam erros foram corrigidos. Deseja visualizá-los?"* (Sim/Não); Sim → tela com os que ainda têm erro; ao Sair, a pergunta de RF01 ("Pré-validação dos registros que não apresentam erros concluída, deseja efetuar a geração?"): Sim gera os corrigidos, Não aborta.
- **RF06** — Fechamento Contábil Diário/Mensal: havendo pendência na empresa com `PEN_DTALAN` ≤ data do fechamento, exibir *"Existem lançamentos com erros que devem ser corrigidos. Deseja Visualizar esses lançamentos?"* (Sim/Não). Sim → tela de pendências (empresa e período). Em qualquer resposta o fechamento **segue** normalmente.
- **RF07** — Fechamento Contábil: havendo pendência na empresa com `PEN_DTALAN` ≤ data final do fechamento, exibir *"Existem lançamentos com erros, que devem ser corrigidos e gerados para que o Fechamento Contábil seja realizado. Deseja visualizar os lançamentos pendentes de correção?"* (Sim/Não). Sim → tela de pendências; o fechamento **não** é executado em nenhuma das respostas.

## 4. Regras de negócio

- **RN01** — A `CONPEN` guarda só **erros** (`ERR_STATUS = 'EE'`); advertências (`'GC'`) não entram.
- **RN02** — Identidade de um documento = `PEN_CHVDOC` + `PEN_TABELA` (+ `PEN_CODEMP`). Nunca filtrar ou excluir só pela chave: SEQGER se repete entre MOVGER e NOTGER (aprendizado 469760).
- **RN03** — A `CONPEN` só é escrita quando a geração **roda até o fim** (operador confirmou). Abortar não grava nada.
- **RN04** — Toda geração concluída **substitui** as pendências do seu escopo pelos erros restantes: escopo normal = empresa × tipo × período gerados; escopo "somente com erro" = os documentos reprocessados. Documento corrigido sai da tabela; documento que continua com erro tem o registro regravado.
- **RN05** — Data da pendência = data contábil do documento (a que iria para `CON_DTALAN`), não o período digitado.
- **RN06** — Fechamentos consideram pendências com `PEN_DTALAN` ≤ data do fechamento, na(s) empresa(s) do fechamento (respeitando a raiz do CNPJ quando a tela a usa).
- **RN07** — Na pré-validação, um documento com erro em **qualquer** de suas linhas (crédito, débito, valores) fica inteiro fora da gravação.
- **RN08** — Robô contábil: comportamento inalterado. Não lê nem grava `CONPEN`; os desvios novos só se ativam por parâmetro que apenas a tela preenche.
- **RN09** — Modo "somente com erro" sem pendências no filtro: avisar com `fMensagem` e não gerar.
- **RN10** — Reprocesso **documento a documento** (decisão do analista, 20/10/2026): só os documentos pendentes são apagados e regerados; o resto do período não é tocado. O check list do período não é refeito; só os dias dos documentos reprocessados ganham `CHK_REPROC = 'S'`. Lotes contábeis (`LOTINC`) só dos documentos reprocessados.
- **RN11** — Adiantamento de Cliente, Ajuste de ICMS e Transitória Cheque/Cartão: no reprocesso, o filtro da geração usa a mesma composição da chave gravada no lançamento (pedido+espécie+empresa; nota+espécie+empresa; número com o 4º caractere `C`/`M`). O robô continua filtrando como hoje.
- **RN12** — CMV é "tudo ou nada": agrupado por CFOP no período, sem chave por documento. Com erro, o CMV da empresa não é gravado naquela geração; no reprocesso, o CMV da empresa é regerado inteiro no período.
- **RN13** — Erro sem chave de documento (ou de fora dos geradores) mantém o comportamento anterior: nada é gravado e a tela de inconsistências aparece.
- **RN14** — No reprocesso, a pendência só sai da `CONPEN` quando o documento ganhou `LANCON` (chave + tabela) ou voltou com erro (regravado); o CMV sai quando o CMV da empresa foi regerado. Documento que o reprocesso não localizou continua pendente, e o operador recebe: *"Os lançamentos foram gerados, mas N documento(s) pendente(s) não foi(ram) localizado(s) no reprocesso e continua(m) pendente(s). Para atualizá-lo(s), gere o período normalmente."* A geração normal do período continua substituindo o escopo inteiro (DelphAI, 21/10/2026).
- **RN16** — **A geração sem empresa informada (todas as empresas) é uso real e não pode mudar de comportamento** (Rafael, 21/10/2026). O recurso novo vale também sem empresa: a pendência grava a empresa **do documento** (`CODEMP` da consulta de cada gerador; no Contas a Pagar, a empresa do título), e não a da tela; o reprocesso sem empresa junta os pendentes de todas as empresas numa execução por sigla; a substituição da `CONPEN` sem empresa abrange todas as empresas do período. Com empresa informada, a pendência leva a empresa da tela, como antes.
- **RN15** — Agrupamento do Contas a Receber (AGR) e do Contas a Pagar (AGP): no reprocesso, o filtro e a exclusão usam chave + tabela, porque o título (`CADREC`/`CADPAG`) e a duplicata agrupadora (`DUPAGR`/`DUPAGP`) têm contadores próprios.

## 5. Requisitos técnicos / não-funcionais

- Transação: a gravação da `CONPEN` de um escopo (delete + insert) numa transação própria (`fStartTransaction`/`fCommit`/`fRollBack`), depois da gravação da `LANCON` do mesmo escopo.
- Encoding: units do módulo têm acento — alteração por `fonte_delphi.py`, preservando cp1252/CRLF.
- Pre-commit: sem `TButton`/`TBitBtn` (usar `TBitBtnLocked`), sem `Now` (usar `fNow()`), sem `.SetFocus` direto, sem `Application.CreateForm`, SQL só com `ParamByName`.
- Versões: módulo sem revisão fixa nas principais `.72`, `.111`, `.111.CONFE`, `.150`, `.150.45`, `.150.100` (todas recebem no próximo build, e precisam do script da `CONPEN`); `.150.100.12` tem o external fixado em r499779 → mover para a revisão do commit (traz junto Req. 454031 e 456839).

## 6. Critérios de aceitação

- [ ] Geração de período com 1 documento com erro e N sem erro: pergunta RF01 → Sim → tela → Sair → Sim: `LANCON` com os N, `CONPEN` com as linhas de erro do documento.
- [ ] Mesmo cenário respondendo **Não** na primeira pergunta: `LANCON` e `CONPEN` inalteradas.
- [ ] Mesmo cenário respondendo Não na pergunta pós-tela: `LANCON` e `CONPEN` inalteradas.
- [ ] Período sem erro: fluxo idêntico ao atual.
- [ ] "Somente Lançamentos com Erro" desmarcada por padrão; botão visível só com ela marcada.
- [ ] Botão lista apenas pendências da empresa/período/tipos selecionados; Excel e Documento de origem funcionam.
- [ ] Corrigido o cadastro e reprocessado: mensagem "Todos os lançamentos…", documento na `LANCON`, linha removida da `CONPEN`, **demais lançamentos do período intactos**.
- [ ] Reprocessado sem corrigir: mensagem "Nem todos…", pendência continua.
- [ ] Geração normal posterior do período com o documento corrigido também remove a pendência.
- [ ] Contas a Pagar (CTP/PCP) com um título com erro: gera os demais títulos e grava a pendência.
- [ ] Documento de entrada e nota fiscal com o mesmo SEQGER: um corrigido não remove a pendência do outro.
- [ ] Fechamento Diário/Mensal com pendência até a data: aviso; fechamento conclui nas duas respostas.
- [ ] Fechamento Contábil com pendência até a data final: mensagem; não fecha nas duas respostas. Sem pendência: fecha como hoje.
- [ ] Pendência com data posterior ao fechamento não bloqueia nem avisa.
- [ ] Robô contábil gera como antes (mesmos lançamentos e erros em `CONLGD`).
- [ ] Reprocesso de 1 documento: os demais lançamentos do dia ficam idênticos (mesmo `AUTOINCREM`), o check list do período mantém a "Ult.Geração" e só o dia do documento ganha "Reproc.".
- [ ] Reprocesso em Adiantamento, Ajuste de ICMS e Transitória: o lançamento do documento corrigido aparece, e o de outro documento do mesmo período não é apagado.
- [ ] CMV com erro: os demais tipos geram e o CMV da empresa não é gravado; reprocesso regera o CMV.

## 7. Fora de escopo

- Tela `TfrmFechamentoContabilMes` (não está em menu).
- `.72.352_AMARELINHA` (Contabilidade fixada em r488352).
- Robô contábil gravar/limpar `CONPEN`.
- Refatorar `TfrmErrosContabil` (herda de `TForm`; existente, mantido).
- Advertências na `CONPEN`.

## 8. Dependências e riscos

- Script da `CONPEN` cadastrado no Diário antes da liberação; cliente sem a tabela quebra a geração → a classe de acesso deve ser a única a tocar a tabela.
- Classes compartilhadas com o robô (`TGerLanCon`, `TListaValidacoesContabeis`, dataset de erros).
- Erro que impede montar o lançamento: data contábil precisa vir do documento de origem — confirmar por tipo na Parada 2.
- CTP/PCP (`TGeradorContabil`) hoje não pula documento: implementação própria.
