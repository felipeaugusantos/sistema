# Especificação — Req. 446492

**Título:** Incluir vendas não encontradas na Conciliação/Baixa de Recebíveis Mercado Livre
**Objetivo:** permitir que o operador gere o lançamento de cartão (MOVCAR) das vendas do relatório do Mercado Livre que não existem no ERP, direto da tela de conciliação, para concluir a baixa.
**Zona:** Legado (`libCartoes`, `padra_atualizado/fontes`)
**Data:** 08/10/2026
**Cliente de origem:** Duarte Peças (release em uso `.150.45.63`) — entrega até 28/10/2026
**Versões:** `.150`, `.150.100`, `.150.45` (todas principais)

## 1. Contexto / problema atual

Menu: PRINCIPAL > CONTROLE FINANCEIRO > CONTROLE DE RECEBÍVEIS MARKET PLACE > CONCILIAÇÃO/BAIXA DE RECEBÍVEIS > CONCILIAÇÃO/BAIXA DE RECEBÍVEIS MERCADO LIVRE (`mnuConciliaoMercadoLivre`, menu dinâmico da `libCartoes`).

Em troca de sistema (onboarding), o relatório do Mercado Livre traz vendas Fulfillment/Crossdocking que nunca foram importadas no ERP. A conciliação as marca como inconsistência e **bloqueia a baixa** (`btnConfirmarBaixa` desabilitado). Hoje o operador precisa incluir cada lançamento de cartão à mão, pela Manutenção de Cartões, digitando os dados que já estão no relatório.

Medido na base da Duarte (08/10/2026): 990 vendas distintas não encontradas (25/05 a 15/06/2026), empresa 101, em 10 conciliações; `CFG_MERCAR` da empresa 101 = `99998_` (POS MERCADO LIVRE 1x CRÉDITO).

Nenhum marketplace (ML, Amazon, B2W, Shopee, Magalu) nem a `libCentralizado` tem recurso equivalente hoje.

## 2. Módulos e entidades envolvidos

- Módulos: financeiro / cartões; `libCartoes` (Mercado Livre e Centralizado); ligação lib → Autcom.
- Units:
  - `libCartoes/libCartoesMercadoLivre/recebiveis/views/untMercadoLivreBaixaRecebiveisMkt.pas` (`TfrmMercadoLivreBaixaRecebiveisMkt`)
  - `libCartoes/libCartoesMercadoLivre/recebiveis/untConciliaRecebiveisMercadoLivre.pas` (`TConcilaRecebiveisMercadoLivre`, detecção das inconsistências)
  - `libCartoes/libCentralizado/interfaces/` (interface lib → Autcom)
  - `libCartoesProjetos-v2/trunk/Autcom/untTLibCartoesAutcom.pas` (`TILibCartoesAutcom`)
  - `padra_atualizado/fontes/financeiro/cartoes/untCadMovCartoes.pas` (`TfrmCadMovCartoes`)
- Tabelas:
  - `MER_MLPGTO` — relatório importado; PK (`MER_CODAUT`, `MER_CODEST`, `MER_DTAPAG`, `MER_NUMPAR`, `MER_STATUS`, `MER_TIPPAG`, `MER_TIPREG`)
  - `REL_CONCAR` / `REL_CONITE` — cabeçalho e itens da conciliação; inconsistências com `REL_TIPREG = 'INCONSISTENCIA'` (não guarda `MER_ORD_ID`)
  - `MOVCAR` — lançamento de cartão; chave `AUTOINCREM` por empresa
  - `CFGSIS` — `SIS_CODCFG = 'CFG_MERCAR'`, valor em `SIS_VALCFG` por empresa, cartões separados por `_`

## 3. Requisitos funcionais

- **RF01 — Botão na conciliação.** Botão **[Incluir Vendas Não Encontradas]** no painel de inconsistências (`pnlInconsistencias`), visível somente quando:
  - a conciliação carregada tiver ao menos uma inconsistência dos tipos "Vendas não encontradas nos lançamentos do sistema" ou "Registro do arquivo não encontrado nos lançamentos do sistema"; **e**
  - o Autcom que carregou a biblioteca implementar a interface nova (RN09).
- **RF02 — Tela de seleção.** Lista **um pedido por linha** com ID da venda, Valor Bruto, Taxa, Frete e Valor Líquido.
- **RF03 — Seleção.** Marcar e desmarcar individualmente, selecionar várias linhas de uma vez, **Marcar todos**, **Desmarcar todos** e **Confirmar**.
- **RF04 — Inclusão.** Ao confirmar, para cada **ID de envio** (agrupando os pedidos marcados) o sistema abre a Manutenção de Cartões do Autcom **pré-preenchida** (RN03 a RN06). O operador escolhe o cliente e grava.
- **RF05 — Sequência.** As manutenções abrem uma após a outra. Se o operador cancelar uma, o sistema pergunta se segue para a próxima ou interrompe.
- **RF06 — Resumo e recarga.** Ao fim, mostra o resumo (gravadas, canceladas, puladas por já existir lançamento) e recarrega a conciliação do período, para as vendas gravadas saírem das inconsistências.

## 4. Regras de negócio

- **RN01 — Configuração em branco.** Se `CFG_MERCAR` da empresa estiver vazia ao confirmar, não abre nenhuma manutenção e mostra, por `fMensagem`: "Não foi possível gerar os lançamentos. Por favor, defina o Cartão Padrão para Conciliação nas Configurações do Sistema."
- **RN02 — Agrupamento.** Um lançamento de cartão por **ID de envio** (`MER_SHP_ID`). Envio com vários pedidos gera **uma parcela por pedido** (A, B, ...), na ordem em que vierem no dataset da conciliação.
- **RN03 — Valores por parcela.** Cada parcela recebe os valores do seu pedido, como já mapeados no dataset da conciliação: bruto → valor, taxa da conciliação → taxa, frete → `MCA_FREMKT`, cupom → `MCA_CUPMKT`, ID do pedido → `MCA_ORDEID`. O valor total do lançamento é a soma das parcelas.
- **RN04 — Identificação.** `MCA_NUMNSU`/`MCA_NUMCCD` = ID de envio, o mesmo em todas as parcelas. `MCA_ORDEID` é **obrigatório**: lançamento sem ele deixa de casar nas conciliações seguintes (precedente: Req. 431060).
- **RN05 — Datas e empresa.** Data da venda = data da transação; data de crédito = data de pagamento do relatório. Empresa = a empresa filtrada na conciliação.
- **RN06 — Maquininha.** Registro do tipo "Registro do arquivo não encontrado..." gera sempre **uma parcela**, porque o ML libera tudo de uma vez.
- **RN07 — Cartão.**
  - Com um único cartão em `CFG_MERCAR` da empresa, a manutenção já abre com ele preenchido.
  - Com vários, o operador escolhe.
  - Na gravação, nesse modo, o cartão precisa pertencer a `CFG_MERCAR` da empresa do lançamento; se não pertencer, a gravação é barrada com aviso (`fMensagem`).
- **RN08 — Duplicidade.** Antes de abrir a manutenção de um envio, verifica se já existe `MOVCAR` com aquele pedido (`MCA_ORDEID`) ou envio (`MCA_NUMNSU`/`MCA_NUMCCD`) nos cartões da `CFG_MERCAR`. Se existir, pula e conta como "pulada" no resumo.
- **RN09 — Compatibilidade.** O método novo fica numa **interface separada**, com GUID próprio, e não altera a `ILibCartoesWrapper` existente. A tela detecta com `Supports`; se o Autcom não a implementa, o botão não aparece e a tela funciona como hoje.
- **RN10 — Cliente.** Escolhido pelo operador no cadastro, na própria Manutenção de Cartões.
- **RN11 — Direito de acesso.** Nenhum direito novo: valem os controles de inclusão da Manutenção de Cartões.

### Regras fechadas durante a implementação (08/10/2026)

- **RN12 — Parcelas B, C...** A Manutenção de Cartões abre uma vez por envio, com a parcela A. Ao gravar, as demais parcelas são incluídas automaticamente na mesma transação, copiando da A cliente, cartão, empresa, duplicata e NSU; cada uma recebe os valores e o `MCA_ORDEID` do seu pedido.
- **RN13 — Crédito no movimento bancário.** A inclusão lança um **crédito** no **portador de débito do cartão**, uma vez por parcela, porque a baixa da conciliação vai lançar o débito nesse portador. Portador e plano seguem a precedência da baixa do ML: `CONPOR.CON_PORDEB`/`CON_CTADEB` da empresa, quando existe a linha; senão `CADCAR.CAR_PORBAD`/`CAR_CTABAD`. A janela de portador e plano **não** abre.
- **RN14 — Cartão sem portador de débito.** O lançamento é incluído **sem** o crédito, e o operador é avisado: "Não será lançado o crédito no portador de débito, pois o cartão <código> não possui portador de débito configurado."
- **RN15 — Número da duplicata.** Vem preenchido por `fRetSequencialMovCar('MOVCAR', empresa)`, a sequência de duplicata de cartão usada pelo faturamento. Se o operador cancelar, o número fica sem uso.
- **RN16 — Pedido.** O ID do pedido vem do arquivo importado (`MER_MLPGTO.MER_ORD_ID`, por `MER_CODAUT = REL_CODAUT` e `MER_SHP_ID = REL_NUMNSU`). Se não houver, usa `REL_CODAUT`. Na Duarte, os dois coincidem.
- **RN17 — Empresa.** É a `REL_CODEMP` da linha da conciliação, que é a empresa filtrada.
- **RN18 — Contrato lib → Autcom (após o DelphAI, 08/10/2026).** JSON com `CODEMP`, `NUMNSU` e `PARCELAS[ORDEID, VALBRU, VALFRE, VALCUP, VALLIQ, DTATRA, DTAVEN]`, com as datas em `yyyy-mm-dd`, que não depende do separador de data do Windows. O Autcom valida todas as chaves e os tipos antes de abrir a tela. JSON inválido, ou envio com mais de 26 pedidos (parcelas A a Z), gera aviso, e a tela não abre.
- **RN19 — Falha nas parcelas B, C...** A transação é desfeita, o operador é avisado e a Manutenção de Cartões fecha. A venda conta como não gravada, e a biblioteca pergunta se segue para a próxima.

## 5. Requisitos técnicos / não-funcionais

- A gravação do `MOVCAR` (autoincremento, transação, auditoria/log) é a da própria Manutenção de Cartões; a biblioteca não insere `MOVCAR` diretamente.
- Os dados da venda cruzam a fronteira DLL → Autcom como String (JSON), mesmo padrão das chamadas atuais da interface.
- Avisos ao operador por `fMensagem`, nunca `Raise`. Nenhum log novo de diagnóstico.
- Datas gravadas por `fNow()`; consultas com `ParamByName`; `pSetFocus`; `pCriarFormularios`.
- Fontes cp1252 com acento: alterar só por `.claude\scripts\fonte_delphi.py`.

## 6. Critérios de aceitação

- [ ] Conciliação sem inconsistências: o botão não aparece e a baixa funciona como hoje.
- [ ] Conciliação com vendas não encontradas: o botão aparece e lista um pedido por linha com ID, bruto, taxa, frete e líquido.
- [ ] Marcar e desmarcar individual, seleção múltipla, Marcar todos e Desmarcar todos funcionam.
- [ ] Uma venda: a Manutenção de Cartões abre pré-preenchida (empresa, valores, NSU, ORDEID, datas, cartão único); o operador escolhe o cliente e grava.
- [ ] Envio com dois pedidos: um lançamento com parcelas A e B, cada uma com os valores e o `MCA_ORDEID` do seu pedido.
- [ ] Registro de maquininha: lançamento com uma parcela.
- [ ] `CFG_MERCAR` com vários cartões: o cartão não vem preenchido; um cartão fora da configuração é barrado na gravação.
- [ ] `CFG_MERCAR` em branco: a mensagem do RN01 aparece e nada é aberto.
- [ ] Cancelar no meio: o sistema pergunta se segue ou interrompe, e respeita a escolha.
- [ ] Venda que já tem lançamento: é pulada e aparece no resumo.
- [ ] Após a sequência, o resumo aparece, a conciliação é recarregada e as vendas gravadas saem das inconsistências e casam na conciliação.
- [ ] Autcom sem a interface nova: a tela abre e funciona como hoje, sem o botão.
- [ ] Manutenção de Cartões aberta pelo menu (fora deste fluxo): comportamento inalterado.

## 7. Fora de escopo

- Porte para `libCartoesProjetos/producao`. O cliente recebe ao atualizar para a última `.150.45`.
- Inclusão automática do `MOVCAR` sem passar pela Manutenção de Cartões.
- Outros marketplaces (Amazon, B2W, Shopee, Magalu...).
- Correção do `TILibCartoesAutcom.fIIncluirCartaoVenda` existente, que declara `AAutoincremCartao` e usa `AAutoincremExtratoVenda` dentro do `{$IF Declared}`. Fica registrado como defeito à parte.

## 8. Dependências e riscos

- **Repositórios:** `libCartoesProjetos-v2/trunk/libCartoes` e `.../trunk/Autcom` (compartilhados pelas três versões) e `padra_atualizado` de cada versão (`untCadMovCartoes.pas` × 3).
- **Conflito:** caique.reboucas alterou `untConciliaRecebiveisMercadoLivre.pas` nos Reqs. 466823/467374 (semana de 06/10/2026). Atualizar antes e manter a alteração pequena.
- **`MER_ORD_ID` por linha:** `REL_CONITE` não o guarda. Usar o dataset da conciliação; se não estiver lá, buscar em `MER_MLPGTO`.
- **Volume:** 990 envios na Duarte, uma manutenção por envio. É uma escolha de produto, feita conscientemente.
