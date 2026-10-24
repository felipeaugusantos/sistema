# Plano de Execução — Req. 441681

**Referência:** spec.md
**Zona:** Moderna (`padra_atualizado/Services/`)

## 1. Abordagem técnica

Daemon novo no padrão do `Link.Pagamento` (laço único sobre as empresas, `TTaskMonitor`, trava global em `LCKATC`). A regra de geração **não é reescrita**: cada tipo chama a rotina legada que o Autcom e os endpoints já usam no Linux. O robô só orquestra fila → rotina existente → rastreio → status.

```
TTaskMonitor.pExecuteAll
  └ para cada empresa com CFG_USALNK = 'S'
      pDefinirEmpresa / pIniciarVariaveis
      pDevolverErrosParaFila           (E -> P, por tempo e tentativas)
      para cada MOVLNK 'P' da empresa
        fCarregarPedido                (FATGOR/EXTGOR; RN02/RN03)
        case MLK_TIPLNK
          PIX            -> pGerarPix
          FIS..IPG       -> pGerarLinkCartao
          PME            -> pMarcarPagarMe
        pMarcarGerado | pRegistrarErro (MOVLNK_LOGERR)
```

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `Services.Processa.Geracao.Link.Pagamento` — `TProcessarGeracaoLinkPagamento` (`ITaskMonitorProcedure`), wrapper `fProcessarGeracaoLinkPagamento` | `Services/Geracao.Link.Pagamento/Source/` | criar |
| `GeracaoLinkPagamento.Service` — empresas, fila, as três rotas, rastreio, log | `Services/Geracao.Link.Pagamento/Source/` | criar |
| `ProcessaGeracaoLinkPagamento.dpr` / `.dproj` / `.deployproj` / `.res` | `Services/Geracao.Link.Pagamento/Target/Linux/` | criar |
| `Services.groupproj` — `Projects`, `Target` (Make/Clean) e `CallTarget` | `Services/` | alterar |
| `CobrancaEletronica.Classe.pas` — `TCobrancaEletronica.pGravar` preenche `CBE_AUTLNK` | `Services/Cobranca.Eletronica/Source/CobrancaEletronica/classes/` | alterar |
| `untCfgRepositorio.pas` — `CFG_USALNK` no grupo LINK DE PAGAMENTO (lista + editor Sim/Não, mesma posição) | `fontes/configuracoes/` | alterar |
| Script DDL (MOVLNK, MOVLNK_LOGERR, colunas `*_AUTLNK`, `DEL_`, **`LOGMPX`**) | `AutPas\citel-devRequisito\441681\ddl-441681.sql` / Diário | criar |

Rotinas reaproveitadas (sem alteração):

| Rotina | Local |
|---|---|
| `TFatVendaBase.GerarCobrancaPixAVista` | `fontes/faturamento/Faturamento.Classes.TFatVendaBase.pas:64615` |
| `TPixDao.AtualizaExtGorPedidos` | `fontes/financeiro/pix/untTPixDao.pas` |
| `fVerificaEnviaLinkPagtoOnline` / `fEnviaLinkPagtoOnline` / `fNotificaCliente` | `fontes/financeiro/gerais/pagamento.online/untPgtOnlineUtil.pas:182 / :92 / :452` |
| Sequência de referência do cartão | `Services/Core/faturamento/services/Faturamento.Services.Pedido.pas:1305-1440` (`TPedidoService.fGerarLinkPagamento`) |
| Laço de empresas / trava | `fontes/financeiro/gerais/pagamento.online/api.esitef/untLinkPagamentoCitelRetorno.pas:338-488, 1206-1294` |
| Uses do `.dpr` | `Services/Citeldesk/Target/Linux/ProcessaCiteldesk.dpr` |

## 3. Sequência de implementação

1. Aplicar o DDL na base de desenvolvimento (`10.0.0.35:47306/AUTCOM_379_48_02_30`) — pelo usuário.
2. Criar a estrutura do projeto (`Source/`, `Target/Linux/`) copiando `.dproj`/`.deployproj` do `Link.Pagamento` (define, saída `..\..\..\bin`, `opcoes.ini`) e o uses do `Citeldesk`; compilar vazio para Linux.
3. `GeracaoLinkPagamento.Service`: empresas (`CFG_USALNK`), leitura da fila, devolução de erros, log em `MOVLNK_LOGERR`, status.
4. Rota PIX (RF03) + `MPX_AUTLNK` por `MPX_TX_ID_`/`MPX_CODEMP`.
5. Rota cartão (RF04) + `SIT_AUTLNK` pelo `FGO_SITNIT`/`FGO_SITMID` gravados na EXTGOR.
6. Rota Pagar.me (RF05).
7. `Cobranca.Eletronica`: `CBE_AUTLNK` (RF07).
8. Registrar no `Services.groupproj`; compilar os dois projetos para Linux.
9. Validação manual com o roteiro da seção 5.

## 4. Conformidade com padrões do projeto

- Zona Moderna: dot-notation nas units, sem Hungarian nas classes novas, `const` em parâmetro não alterado.
- Daemon, não endpoint: `IA/rules/services-workers.md` não se aplica (não há worker filho), mas o `.dpr` **não** pode chamar `pLoadLibTintaMaquina`.
- Chamadas: `fNow()` (nunca `Now`), `fStrToFloat`, `ParamByName` em todo SQL, `fStartTransaction`/`fCommit`/`fRollBack` com `raise` após rollback.
- Projeto: units novas entram pelo `.dpr`; `.dproj` só para opções de compilação/deploy.
- Pre-commit: sem `FOREIGN_KEY_CHECKS` no script; `Req. 441681` + token DelphAI.
- Encoding: units novas em cp1252/CRLF; `CobrancaEletronica.Classe.pas` conferido com `fonte_delphi.py conferir` antes de editar.

## 5. Estratégia de testes

Robô não é endpoint: sem suíte REST. Validação manual na base de desenvolvimento, inserindo registros `MOVLNK` à mão sobre pedidos reais:

| Caso | Preparação | Esperado |
|---|---|---|
| CA01 | `CFG_USALNK = 'N'` | registro segue `P` |
| CA02 | PIX, chave de homologação | `G`, MOVPIX + `MPX_AUTLNK`, EXTGOR `FGO_TX_PIX` |
| CA03 | `CFG_LINKPG = 3`, condição Cielo | `G`, SITCOB `NOV` + `SIT_AUTLNK`, edição do pedido bloqueada no Autcom |
| CA04 | `CFG_PMEHAB = 'S'`, condição Pagar.me | `G`, `FGO_TIPREC = 'PME'`, `FGO_LIBERA = 0`; COBELT com `CBE_AUTLNK` |
| CA05/06 | `CFG_CHAPIX` vazia | `E`, log, volta a `P` após o tempo, para em `-maxtentativas` |
| CA07 | pedido já com `FGO_TX_PIX` | `G` sem nova cobrança |
| CA08 | pagar um PIX gerado pelo robô | MOVPIX `CONCLUIDA`, adiantamento, pedido liberado |
| CA09 | 002/009 ativo no WhatsApp, com e sem "enviar documento" | `GATIME_WPPEMA` gravado e enviado, PDF anexo quando o modelo pede |

## 6. Riscos e mitigação

- Uses herdado arrasta dependência que não compila ou carrega tinta → compilar no passo 2 e conferir que não há `pLoadLibTintaMaquina`.
- Provedor real em desenvolvimento → só credencial de homologação; sem ela, validar até a chamada e registrar o erro esperado (CA05).
- Link criado no provedor e falha na gravação local → RN02 (idempotência pelo vínculo da EXTGOR) e transação local; pode sobrar cobrança órfã no provedor, como no Autcom.
- `MOVLNK` sem DDL oficial → o script cria a tabela (sem `IF NOT EXISTS`, regra do script de banco: se existir, o erro é a resposta); registrar no Editor de DDL do Diário.

## 7. Desvios durante a implementação (07/10/2026)

O que mudou em relação ao plano, e por quê. A narrativa completa vai para o `record.md`.

| Ponto | Plano | Como ficou | Motivo |
|---|---|---|---|
| Base do `.dpr` | uses do `Citeldesk` | uses do `Citeldesk` + `untReformaTributariaTipos/Calculo` (r498564) + `Faturamento.Services.Pedido`/`.Types`/`.Cache` | `Citeldesk` não está no `Services.groupproj`; Req. 462649 exigiu as units da reforma; o PDF do 002/009 no Linux depende do gerador registrado por `Faturamento.Services.Pedido` |
| Pacotes | estático | `UsePackages` com `shared.functions;NFe` e search path `$(BDSLIB)\$(Platform)\<cfg>`, como o `FaturamentoServicesAPI.dproj` | F2051/F2063: units da libNfe em `.dcu` do pacote compiladas contra outra versão |
| Saída | `..\..\Bin` (herdado) | `Services\bin` e `Services\tmp` em todas as configurações | pedido do Rafael |
| Deploy | do `Citeldesk` | + `libIntegracaoPixCitel.so`, `libGatIme.so`, `libssl.so`, `libcrypto.so`, `bplShared.Functions.so`; pacotes de `$(BDS)\Redist\Linux64` | sem eles PIX e notificação não rodam; a `bin` tinha pacotes velhos. A IDE regrava o `.deployproj` ao salvar: conferir antes do commit |
| `libGatIme` | — | `pCarregaFuncoesDllGatilhoImediatos` após conectar (`Services.Processa.Geracao.Link.Pagamento`) | sem ela a notificação salta para o endereço 0 (AV em `TDllGatime.fGravarGatilhoImediato`) |
| Link de cartão ativo | `FGO_SITNIT` aponta para SITCOB | + `FGO_TIPREC` de fornecedor de link (`fEhLinkPagamentoCitel`) | o "desvincular" do Autcom limpa o TIPREC e mantém o SITNIT |
| Notificação de cartão | `NOV`→`ENE` só no retorno falso | também na exceção | link sem notificação precisa aparecer para reenvio |
| Disparo do PIX | fora do escopo | gatilho **002/009** nos canais ativos, PDF conforme o modelo (RF10) | decisão do Rafael, 07/10 |
| DDL | sem LOGMPX | `ALTER TABLE LOGMPX ADD MPX_AUTLNK` | `TLogMpx.GravaLogMpx` copia todas as colunas da MOVPIX para a LOGMPX |
