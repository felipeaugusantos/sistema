# Especificação — Req. 441681

**Título:** Robô de geração de links de pagamento a partir da fila MOVLNK
**Objetivo:** criar o serviço Linux `Geracao.Link.Pagamento`, que consome a fila `MOVLNK` gravada pelo WebService e gera a cobrança (cartão, PIX ou Pagar.me) do pedido pelo mesmo caminho do Autcom, para que as travas e os robôs de recebimento existentes continuem valendo.
**Zona:** Moderna (`padra_atualizado/Services/`), reaproveitando rotinas legadas já compiladas no Linux
**Data:** 06/10/2026
**Cliente de origem:** DEVIA BRASIL (DEGA) — integração Mercos
**Requisitos relacionados:** 441670 e 441676 (WebService, r486450 — gravam a fila), 417872 (origem: PIX automático da Mercos)

## 1. Contexto / problema atual

Pedidos da Mercos entram pelo WebService direto na FATGOR/FATDOR. Com `CFG_USALNK = 'S'`, o WebService não gera mais o link/PIX: grava um registro na `MOVLNK` com o tipo de link (`MLK_TIPLNK`) e o valor (`MLK_VALLNK`). Ninguém consome essa fila hoje.

Como o Autcom faz para um pedido digitado (medido no código da .150, r498296):

| Tipo | Geração | Amarração com o pedido | Quem processa o pagamento |
|---|---|---|---|
| Cartão (FIS, CIE, VND, CRP, RED, IPG) | chama o adquirente na hora e grava a SITCOB (`TLinkPagamentoCitelModel.fNovaTransacao`) | `EXTGOR.FGO_SITNIT` / `FGO_SITMID` / `FGO_TIPREC` | `Services/Link.Pagamento` |
| PIX | chama o provedor e grava a MOVPIX (`TFatVendaBase.GerarCobrancaPixAVista`) | `EXTGOR.FGO_TX_PIX` / `FGO_EMPPIX` (`TPixDao.AtualizaExtGorPedidos`) | `Consulta.Pagamentos.Pix` (monitor) |
| Pagar.me (PME) | **não gera na hora**: marca `EXTGOR.FGO_TIPREC = 'PME'` e `FATGOR.FGO_LIBERA = 0` | pela chave do pedido (`CBE_NUMDOC/ESPDOC/CODEMP`) | `Services/Cobranca.Eletronica` gera o link, grava a COBELT e libera o pedido no pagamento |

A notificação do Pagar.me (e-mail/SMS/WhatsApp) é feita pelo `EnviaEmailBoletoMonitor` (`TEmailAutController.pDisparosCobrancaEletronica`, modelo 039) a partir da COBELT com `FGO_TIPREC = 'PMEE'` — não pelo robô.

## 2. Módulos e entidades envolvidos

- Módulos: faturamento (pedido), financeiro (link de pagamento, PIX, cobrança eletrônica).
- Serviços: novo `Services/Geracao.Link.Pagamento`; alteração em `Services/Cobranca.Eletronica`.
- Tabelas:
  - `MOVLNK` (PK `AUTOINCREM` varchar(20), gerado pelo WebService) — fila.
  - `MOVLNK_LOGERR` (PK `AUTOINCREM` bigint auto_increment) — nova, log de erro.
  - `SITCOB` (PK `SIT_NUMNIT` + `SIT_MERCID`), `MOVPIX` (PK `AUTOINCREM`), `COBELT` (PK `AUTOINCREM`) — ganham o campo de rastreio.
  - `FATGOR` (PK `AUTOINCREM`) / `EXTGOR` (`FGO_SEQFGO` = `FATGOR.AUTOINCREM`) — amarração e trava.
  - `CFGSIS` — `CFG_USALNK`, `CFG_USAPIX`, `CFG_CHAPIX`, `CFG_PMEHAB`, `CFG_LINKPG`.

## 3. Requisitos funcionais

- RF01 — O robô processa, a cada ciclo, todas as empresas com `CFG_USALNK = 'S'` (restritas a `EMPRESAS_NESTE_SERVIDOR` quando existir), no padrão do `Link.Pagamento`: um processo, uma trava global em `LCKATC`.
- RF02 — Entram na fila os registros com `MLK_STATUS = 'P'` da empresa (`MLK_CODEMP`), em ordem de cadastro.
- RF03 — Tipo `PIX`: gera a cobrança por `TFatVendaBase.GerarCobrancaPixAVista(codcli, MLK_VALLNK, 'PIX de pedido no valor de R$<valor> para o cliente: <codcli>', 'PEDIDO')` — o mesmo texto e caminho que o WebService usava antes da fila — e amarra o pedido com `TPixDao.AtualizaExtGorPedidos(empresa, txid, autoincrem do pedido)`.
- RF04 — Tipos `FIS`, `CIE`, `VND`, `CRP`, `RED`, `IPG`: gera o link pelo mesmo caminho do endpoint `POST /pedido/{doc}/{esp}/{emp}/link-pagamento` (`fVerificaEnviaLinkPagtoOnline` → `fEnviaLinkPagtoOnline` → `fNotificaCliente`), que grava a SITCOB, amarra `EXTGOR.FGO_SITNIT` e notifica o cliente conforme `CFG_SAILNK`.
- RF05 — Tipo `PME`: marca o pedido como o Autcom marca — `EXTGOR.FGO_TIPREC = 'PME'` e `FATGOR.FGO_LIBERA = 0` — sem alterar `FGO_LIBCOM`. A geração do link fica com o `Cobranca.Eletronica`.
- RF06 — Gravado com sucesso: preenche o campo de rastreio da tabela gerada (`SIT_AUTLNK`, `MPX_AUTLNK`) com `MOVLNK.AUTOINCREM` e atualiza `MLK_STATUS = 'G'`, `MLK_DTAPRO`.
- RF07 — `Cobranca.Eletronica`, ao gravar a COBELT de um pedido, preenche `CBE_AUTLNK` com o `AUTOINCREM` do registro `MOVLNK` do pedido (mesma empresa, número e espécie, tipo `PME`, o mais recente); sem registro, fica `NULL`.
- RF08 — Erro em qualquer etapa: grava em `MOVLNK_LOGERR`, atualiza `MLK_STATUS = 'E'`, `MLK_DTAPRO` e soma 1 em `MLK_QTDTEN`.
- RF10 — PIX gerado e amarrado: dispara o gatilho **002/009** ("Inclusão/Alteração do Pedido - Pix") com o QR Code/link Citel e o txid, pelas mesmas rotinas do Autcom (`fDisparaWhatsappAutomatico`, `fDisparaEmailAutomatico`, `fDisparaSMSAutomatico`, como em `untFuncFat.pEnviarSMSPedido`/`pEnviarEmailPedido`), **somente nos canais em que o 002/009 está ativo** na empresa. O 002/001 nunca é disparado pelo robô (é de outro microsserviço). O PDF do pedido vai quando o modelo pede (`MOD_ENVDOC = 'S'`). Decisão do Rafael em 07/10/2026.
- RF11 — O script deste requisito **não vai pelo Diário**: a equipe do WebService o executa nos clientes (decisão do Rafael, 08/10/2026). Por isso o robô só sobe com MOVLNK, MOVLNK_LOGERR, `SIT_AUTLNK`, `MPX_AUTLNK`, `LOGMPX.MPX_AUTLNK` e `CBE_AUTLNK` criados (as `DEL_` não são conferidas): faltando algo, escreve no console, grava na LOGERR e encerra o processo (código 1), sem pegar a trava.
- RF12 — Pelo mesmo motivo, o `Cobranca.Eletronica` só grava `CBE_AUTLNK` quando a coluna e a MOVLNK existem; sem elas, grava a COBELT exatamente como antes do requisito.
- RF13 — `MOVLNK.MLK_CELULA` (`ALTER TABLE`: a MOVLNK já existe no script da equipe do WebService), gravada pela origem — o Citel Sales — quando o cliente informa um celular diferente do cadastro. **Vazia: tudo como antes.** Preenchida (o robô guarda só os dígitos), o WhatsApp vai para esse número: PIX pelo `strCelularEnv` do gatilho 002/009; cartão por `fNotificaCliente` com forma `'W'` e destinatário (forma de envio `W` na SITCOB, independente da `CFG_SAILNK`); Pagar.me pela `COBPME.COB_NUMWPP` (fila e contato vazios → fila do gatilho 039), que o `EnviaEmailBoletoMonitor` lê. Sem a COBPME (Req. 434183), o número é ignorado e fica um aviso na `MOVLNK_LOGERR`, sem bloquear.
- RF09 — A cada ciclo, registros `E` com `MLK_DTAPRO` mais antigo que `-minutosreprocessar` (padrão 30) e `MLK_QTDTEN` menor que `-maxtentativas` (padrão 5) voltam para `P`.

## 4. Regras de negócio

- RN01 — `CFG_USALNK = 'N'` na empresa: o robô não lê a fila daquela empresa; os registros ficam como estão.
- RN02 — **Idempotência:** antes de gerar, conferir se o pedido já está amarrado (`FGO_SITNIT`, `FGO_TX_PIX` ou `FGO_TIPREC` de link preenchidos). Se já estiver, marcar `G` sem gerar outro link — cobre a volta de `E` para `P` depois de uma geração que chegou ao provedor.
- RN03 — Pedido inexistente, cancelado (`FGO_MOTBAI` preenchido) ou com espécie diferente de `PD`: erro de negócio, vai para `E` com a descrição; não chama provedor.
- RN04 — Tipo desconhecido em `MLK_TIPLNK`: erro de negócio, `E`.
- RN05 — As validações de configuração e de condição de pagamento continuam sendo as das rotinas do Autcom (`fVerificaEnviaLinkPagtoOnline`, `CFG_CHAPIX`, `CFG_PMEHAB` + `CND_COBPME`). Reprovou: erro de negócio com a mensagem da rotina.
- RN06 — Gravação local (amarração, campo de rastreio, status da fila) em transação (`fStartTransaction` / `fCommit` / `fRollBack`); a chamada ao provedor fica fora dela, como no Autcom.
- RN07 — Passou de `-maxtentativas`: fica em `E` definitivamente; reprocessar exige ação manual (voltar `MLK_STATUS` para `P` e zerar `MLK_QTDTEN`).

## 5. Requisitos técnicos / não-funcionais

- Daemon Linux no padrão de `Services/` (DMVCFramework não é necessário: não expõe endpoint). Conexão por `opcoes.ini` (`[BANCO] NUMIP/NOMBAN/PORTA`), `TTaskMonitor`, `pDefinirEmpresa` / `pDefinirUsuario` por empresa.
- O `.dpr` não pode carregar as bibliotecas de tinta (`pLoadLibTintaMaquina`): uses no modelo do `Citeldesk/Target/Linux/ProcessaCiteldesk.dpr`, que já liga `TFatVendaBase` e `untPgtOnlineApi` sem tinta.
- `fNow()` em toda data gravada; SQL só com parâmetros.
- Parâmetros de linha de comando: `-minutosreprocessar=<n>` (padrão 30), `-maxtentativas=<n>` (padrão 5), `-f` (forçar liberação da trava), `--logsactive`.
- Script de banco entregue ao fim (MySQL 5.7, sem `FOREIGN_KEY_CHECKS`), com criação condicional da `MOVLNK` — hoje ela não existe em nenhum script do Diário nem na base de desenvolvimento.

## 6. Critérios de aceitação

- [ ] CA01 — `CFG_USALNK = 'N'`: registro `P` da empresa permanece `P`; nada é gerado.
- [x] CA02 — PIX: registro `P` vira `G`; MOVPIX criada com `MPX_CRIADO = 'PEDIDO'`, status ativo e `MPX_AUTLNK` preenchido; `EXTGOR.FGO_TX_PIX`/`FGO_EMPPIX` do pedido apontam para o txid. — ok 07/10 (PD 843 e 848, empresa 543)
- [x] CA03 — Cartão (Cielo): registro vira `G`; SITCOB com `SIT_STATUS = 'NOV'` e `SIT_AUTLNK` preenchido; `EXTGOR.FGO_SITNIT` aponta para o link; Autcom bloqueia a edição do pedido com a mensagem de link associado. — ok 07/10 (PD 891/890, Cielo, empresa 543); notificação WhatsApp ok após carga da libGatIme
- [ ] CA04 — Pagar.me: registro vira `G`; `FGO_TIPREC = 'PME'`, `FGO_LIBERA = 0`; após o ciclo do `Cobranca.Eletronica`, COBELT criada com `CBE_AUTLNK` = `MOVLNK.AUTOINCREM`.
- [x] CA05 — Erro (ex.: `CFG_CHAPIX` vazia): registro vira `E`, `MLK_QTDTEN = 1`, linha em `MOVLNK_LOGERR` com a mensagem. — ok 07/10 (erro real do LOGMPX sem MPX_AUTLNK)
- [x] CA06 — Registro `E` volta para `P` após `-minutosreprocessar`, e não volta após atingir `-maxtentativas`. — ok 07/10 (-minutosreprocessar=1 -maxtentativas=2: E→P→E, parou em 2)
- [x] CA09 — PIX com 002/009 ativo no WhatsApp: disparo gravado em `GATIME_WPPEMA` com o QR Code/link; com o 009 inativo em todos os canais, nenhum disparo (e nunca 002/001). — ok 07/10 (WhatsApp, com e sem PDF; PDF exigiu trocar o logo PNG do layout 000183 da 543 por JPEG)
- [x] CA07 — Pedido já amarrado: registro vira `G` sem segunda cobrança no provedor. — ok 07/10 (PD 843: G sem 2ª MOVPIX nem 2º disparo)
- [ ] CA08 — Pedido com link gerado pelo robô é processado no pagamento pelos robôs existentes (Link.Pagamento / Consulta.Pagamentos.Pix / Cobranca.Eletronica) como um pedido digitado no Autcom. — PIX ok 07/10 (PD 848: CONCLUIDA, adiantamento R$ 3,00, pedido liberado; pagamento simulado pelo Autcom); cartão e Pagar.me pendentes
- [x] CA10 — `MLK_CELULA` preenchida (com máscara, ex. `(11) 9xxxx-xxxx`): nas três rotas o WhatsApp chega no número informado, não no do cadastro; Pagar.me com `COB_NUMWPP` gravado. Vazia: comportamento de CA02/CA03/CA04. — ok 09/10, empresa 543, cadastro 16992199514, informado 16992602222: Cielo `...013`/`...014` (PD 884/883, `SIT_ENVIAD = W`; o 014 com máscara), PIX `...015`/`...016` (PD 858/853, `GAT_NUMWPP` = cadastro / informado), Pagar.me `...017`/`...018` (PD 882/876; COBPME só no 018, `COB_NUMWPP = 16992602222`, fila vazia; COBELT com `CBE_AUTLNK`). Sem linha na `MOVLNK_LOGERR`. Antes: robô sem a coluna não subiu (LOGERR 4233/4234).

## 7. Fora de escopo

- Alterações no WebService (feitas nos requisitos 441670 e 441676).
- Fila de WhatsApp do Pagar.me (`COBPME`) com fila/contato resolvidos: a rotina do Autcom que a grava não tem implementação Linux, e ele também a pula no faturador automático; o monitor resolve o contato. O robô só grava a COBPME para levar o celular da `MLK_CELULA` (RF13), com fila e contato vazios.
- Gatilho 002/001 (Inclusão do Pedido): é de outro microsserviço; o robô só dispara o 002/009.
- Tela no Autcom para consultar a fila ou o log.
- Agrupamento de pedidos (AGR/SITDOC).

## 8. Dependências e riscos

- Cartão e PIX chamam o provedor real: testar só com credencial de homologação.
- O `.dpr` herda a lista grande de units do `Citeldesk`; compilar para Linux cedo.
- O `Cobranca.Eletronica` é por empresa (`-e`) e só pega pedido com `FGO_LIBERA = 0` e `FGO_LIBCOM > 0`: pedido do WebService sem liberação comercial espera por ela, como no Autcom.
- Instalação: o robô novo precisa ser implantado e agendado no servidor do cliente (deployproj + serviço).
