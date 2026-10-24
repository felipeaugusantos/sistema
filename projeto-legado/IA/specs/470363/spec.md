# Especificação — Req. 470363

**Título:** TEF DVC — transação pendente sem aviso ao operador quando a confirmação não chega à estação
**Objetivo:** quando a confirmação do cartão não puder ser feita (canal DVC fora, ou serviço da estação reiniciado desde a transação), avisar o operador na hora e manter a TEFTRA `PENDENTE`, sem erro técnico na tela e sem LOGERR. Junto: quadro corrompido não derruba mais o canal.
**Zona:** Legado (`padra_atualizado\fontes\`) + `libTefCitel` (external único das 5 versões)
**Data:** 15/10/2026
**Cliente de origem:** Avenida Acessórios (.72.458, r498707) — Zendesk 1714292

## 1. Contexto / problema atual

Fechamento da venda: **FATURAMENTO > RESUMO DE CAIXA > Confirmar** → `fConfirmaCartoesTEF` → `fFinalizaCartao` → `objTefCitel.fFinalizarTransacao`. Nesse ponto a venda e a MOVCAR já estão gravadas.

Medido no banco da Avenida (produção, só leitura):

| Data | Terminal | Cenário | TEFTRA | Scope | MOVCAR | LOGERR |
|---|---|---|---|---|---|---|
| 14/10 11:00:12 | 001 (CAIXA) | PC do caixa reiniciou; serviço da estação morreu | `PENDENTE`, sem INCDOC | pendente, resolvida na virada | correta (2 × 83,01) | 13417 "Canal TEF DVC nao esta conectado." |
| 15/10 10:51:55 | 002 (CAIXA2) | queda de RDP 10:52:12 (erro 233), serviço vivo; canal reaberto 10:53:09 | `PENDENTE`, sem INCDOC/SEQCON | **confirmada** pelo `fPassarCartao` seguinte (10:59:02) | correta (16,75, NSU e Controle 10508392019) | 13422 "Canal TEF DVC nao esta conectado." |

Mecanismo:
- `fChamaRpcUmaVez` → `fEnviaEnvelope` → `TTefCitelDvcTransporte.fEnviaUmFragmento` levanta `ETefCitelDvcTransporte` quando o canal está fora (ou cai aguardando o ACK de entrega). Os handlers de `fFinalizarTransacao`/`fPassarCartao` só capturam `ETefCitelDvcCanal` → a exceção sobe.
- `fFinalizaCartao` captura: `fRollBack` + `pMensagensErro` (mensagem técnica + LOGERR). `pGravaTransacaoFinalizada` não roda → TEFTRA fica `PENDENTE`. Esse é o único registro honesto, porque na hora não se sabe o desfecho no Scope.
- Converter a exceção em `ETefCitelDvcCanal` **sozinho** pioraria: `fFinalizarTransacao` é procedure sem retorno, `pNotificaCanalCaiu` iria para 0 observers (o `RemoveObserver` já ocorreu) e `fFinalizaCartao` seguiria para `pGravaTransacaoFinalizada`, marcando `EFETUADA PDV` com o Scope pendente.
- Cenário do texto do requisito (PC reinicia, conector reconecta, operador conclui): a instância nova da estação recusa o `fFinalizarTransacao` com `loginNecessario` (`pGarantePinpadConfigurado`, `untTefEstacaoRoteadorMensagens.pas`); o autcom liga `FintServicoReiniciou`, refaz o login (`pRefazTefSeServicoReiniciou`), **guarda** o aviso de reinício para a próxima tela (0 observers) e repete a finalização na instância nova, que responde ok sem conhecer a transação → `fFinalizaCartao` grava `EFETUADA PDV` com o Scope pendente (confirmado no fonte na Parada 2). A anotação da `instanciaServico` na carga (`fAtuConsulta`) **não** é necessária para este caminho.
- Item 2 do anexo: 14/10 09:09:14, resposta do `pInfo30` e evento no mesmo ms → CRC inválido + buffer desalinhado → o canal foi derrubado e reaberto → a estação abortou a venda no pinpad ("Transacao cancelada"). LOGERR 13416.

## 2. Módulos e entidades envolvidos
- Módulos: TEF DVC (`libTefCitel`), faturamento (fechamento da venda).
- Units: `libTefCitel\untTefCitelDvc.pas`, `libTefCitel\untTefCitelDvcTransporte.pas`, `libTefCitel\untInterfaceTefCitel.pas`, `padra_atualizado\fontes\tef\TefCitel\untTefCitelUtil.pas`.
- Tabelas: `TEFTRA` (PK `AUTOINCREM`; `TFT_STATUS`, `TFT_INCDOC`, `TFT_TABELA`, `TFT_SEQCON`, `TFT_CONTRO`), `MOVCAR` (somente conferência), `LOGERR` (não deve mais receber esses casos).

## 3. Requisitos funcionais
- RF01 — Falha de **envio** no canal (`ETefCitelDvcTransporte` vinda de `fEnviaEnvelope`) é tratada como queda de canal (`ETefCitelDvcCanal`) em `fChamaRpcUmaVez`, para cair nos tratamentos existentes de `fPassarCartao`, `fCancelaTransacaoTerminal`, `fReimpressao` e `fFinalizarTransacao`.
- RF02 — `pInfo21`/`pInfo30` (aninhados em `fPassarCartao`) apenas registram a queda no log do DVC; não sobem exceção nem avisam: o `fPassarCartao` que os envolve já avisa.
- RF03 — `fFinalizarTransacao` não sobe exceção por queda de canal: registra "confirmação não realizada" e executa `FDepoisFinalizarTransacao` (libera a LCKATC).
- RF04 — `fFinalizarTransacao` chamada depois de detectado reinício do serviço da estação (desde a transação) também resulta em "confirmação não realizada".
- RF05 — Interface nova, separada de `ITefCitel` e com GUID, implementada só por `TTefCitelDvc`, pela qual o autcom consulta se a última finalização foi realizada.
- RF06 — `fFinalizaCartao`: com confirmação não realizada, exibe `fMensagem` com o texto da RN01, **não** chama `pGravaTransacaoFinalizada` (TEFTRA fica `PENDENTE`) e não grava LOGERR. O restante do fechamento da venda segue como hoje.
- RF09 — Reenvio automático da confirmação que não chegou por queda de canal (RN06); `ITefCitelFinalizacao.fUltimaFinalizacaoSeraReenviada` diz ao autcom qual aviso mostrar; `pDescreveFinalizacaoPendente` passa valor e Controle para a RN08. Validado em 16/10: R$ 1,00 reenviada antes do cartão seguinte; desfazimento do segundo cartão não desfez a primeira (conferido no site do TEF).
- RF10 — Autoconfirmação (`fAutoConfirmarTransacaoTef`, `PENCNF = S`; .150/.150.45/.150.100/.111 e releases): confirmação não realizada CONTINUA contando como autoconfirmada (grava como sempre). Na queda, a DLL reenvia antes da próxima operação; no reinício do serviço, aviso na hora: "A confirmação do cartão de R$ <valor> (Controle <controle>) não chegou ao TEF da estação (o serviço de TEF foi reiniciado) e ficou PENDENTE no TEF." Revisto em 16/10: devolver "não confirmado" fazia o Resumo de Caixa estornar o cartão depois de gravar o recebimento (defeito antigo, requisito próprio).
- RF11 — Pix pelo Scope (`TPixTefBridgeAutcom.fIniciarTransacaoPix`): confirmação não realizada = segue como sucesso (o Pix foi pago, nunca desfazer), sem `pGravaTransacaoFinalizada` (TEFTRA `PENDENTE`) e com o aviso da RN07/RN01, entregue pela fila da thread principal (a ponte roda em TTask). Incluído em 16/10 por decisão do usuário.
- RF12 — A DLL anota, por documento, a geração da sessão Scope na aprovação (`fPassarCartao`); geração diferente na finalização = não realizada, mesmo que o re-login tenha sido feito por outra chamada (ex.: a autoconfirmação).
- RF08 — Quadro com CRC inválido ou tamanho fora do limite no lado autcom: descartar o acumulado e aguardar o próximo início válido, **sem derrubar o canal**; o reenvio por ACK recupera o quadro.

## 4. Regras de negócio
- RN01 — Texto do aviso (aprovado em 15/10):
  > A confirmação do cartão não chegou ao TEF da estação (o serviço de TEF foi reiniciado). O faturamento foi concluído, mas a transação de R$ <valor> (Controle <controle>) ficou PENDENTE no TEF.
  (Texto de 15/10 revisto em 16/10: vale para o reinício detectado na própria finalização; a queda de canal usa a RN07.)
- RN02 — Confirmação não realizada ⇒ TEFTRA permanece `PENDENTE`. Nunca marcar `EFETUADA PDV` sem a resposta da estação.
- RN03 — TEF clássico (`CFG_TEFDVC = N`) e Pix: comportamento inalterado. A interface nova não é implementada por `TTefCitelNCR`/`TTefCitel` → o autcom segue o caminho atual.
- RN04 — O aviso do caso da finalização sai uma vez só: o aviso genérico de reinício continua guardado para a tela seguinte, e o autcom novo o descarta ao consultar `ITefCitelFinalizacao` (ele mostra o próprio). Autcom sem o porte (versões que pegam a `libTefCitel` nova pelo external `^/libTefCitel` — medido em 16/10: 14 usam o HEAD, 6 sem porte: .72/.111/.150.CONFE, .111.192, .150.100.C, .150.116) continua com o aviso genérico, que é o único que ele tem.
- RN05 — Nenhum timeout sobre o pinpad nem espera pela volta do canal na finalização.
- RN06 — Queda de canal com o serviço vivo (decisão 16/10, achado do teste CA01): a sessão Scope da estação é uma só e confirmar/desfazer vale para tudo o que está aberto nela — sem reenvio, o cartão seguinte resolvia a pendente por tabela, e um desfazimento desfaria a venda anterior já faturada. A DLL guarda a confirmação e a **reenvia antes da próxima chamada ao TEF** (`pReenviaFinalizacaoPendente`, sem re-login). Serviço reiniciado (`loginNecessario`): descarta. A TEFTRA continua `PENDENTE` (aceito pelo usuário em 16/10).
- RN06a — Apontamentos do DelphAI (16/10): (a) confirmação guardada não é sobrescrita por desfazimento — confirmar vence; (b) se o reenvio não puder sair (canal ainda fora), a chamada corrente não segue (`ETefCitelDvcCanal`): nenhuma transação nova entra na sessão Scope antes da confirmação pendente; (c) reenvio protegido por flag atômica. Na finalização, o aviso genérico de reinício é sempre guardado e só é descartado se ainda for o mesmo.
- RN07 — Texto do aviso na queda de canal (simplificado em 16/10 — não promete o reenvio, que pode falhar se o serviço reiniciou junto; ação no site do TEF é responsabilidade do operador):
  > A confirmação do cartão não chegou ao TEF da estação (a conexão caiu). O faturamento foi concluído, mas a transação de R$ <valor> (Controle <controle>) ficou PENDENTE no TEF.
  No reinício do serviço detectado na própria finalização vale a RN01.
- RN08 — Reenvio descartado (serviço reiniciou): no lugar do aviso genérico de reinício, antes da próxima operação:
  > A confirmação do cartão de R$ <valor> (Controle <controle>) não pôde ser reenviada: o serviço de TEF da estação foi reiniciado. O faturamento foi concluído, mas a transação ficou PENDENTE no TEF.

## 5. Requisitos técnicos / não-funcionais
- `IA\rules\tef-dvc.md`: nenhum teto sobre a chamada TEF; o formato do quadro não muda (o lado da estação não é alterado); `TThread.Queue` com dados já extraídos.
- Contrato EXE ↔ DLL: nada novo no meio de `ITefCitel`; interface nova com GUID próprio; `autcom.exe` + `libTefCitel.dll` saem juntos; `TefEstacaoService` não muda.
- Aviso por `fMensagem` na thread principal (o `fFinalizaCartao` roda nela); nunca `raise`; sem log novo além do log do DVC existente.
- Encoding: `.pas` com acento só por `.claude\scripts\fonte_delphi.py`.

## 6. Critérios de aceitação
- [ ] CA01 — Queda de RDP entre a aprovação e a confirmação: aparece o aviso da RN07; o log do DVC mostra `pReenviaFinalizacaoPendente: confirmacao reenviada com sucesso` antes do próximo `fPassarCartao`; TEFTRA `PENDENTE`; MOVCAR correta; nenhum LOGERR; LCKATC liberada (o próximo cartão passa).
- [ ] CA02 — PC do caixa reiniciado antes da confirmação, autcom reconectado na mesma tela: o operador conclui e vê o aviso da RN01 na hora; TEFTRA `PENDENTE`; nenhum LOGERR.
- [ ] CA03 — Venda normal (débito, crédito, parcelado, 2 cartões): comportamento idêntico ao atual; TEFTRA `EFETUADA PDV` com INCDOC.
- [ ] CA04 — Queda de canal durante `fPassarCartao`: aviso existente "A comunicação com o TEF caiu…"; nenhum LOGERR; LCKATC liberada.
- [ ] CA05 — Quadro corrompido: o log do DVC registra o descarte; o canal não é fechado; a transação em curso segue.
- [ ] CA06 — TEF clássico: nenhuma mudança.

## 7. Fora de escopo
- Item 3 do anexo (logon duplicado / `SCO_POS_JA_LOGADO`): `untScopeNCR.pas`/`untTefCitelNCR.pas` travadas pelo Req. 418470.
- Atualizar a TEFTRA automaticamente quando o Scope confirmar depois (recusado ao DelphAI 3 vezes, decisão do usuário 16/10) (caso CAIXA2 de 15/10).
- Causa raiz do quadro corrompido (remontagem em `fProcessaChunkWts`): depende do log em nível diagnóstico do CAIXA.
- Anotar a `instanciaServico` da carga (`fAtuConsulta`) como instância conhecida (decisão 15/10, Parada 2: a recusa `loginNecessario` já cobre a finalização; anotar na carga daria falso reinício depois da atualização automática da estação).
- Re-login que também falha (ex.: "Logon duplicado" do Scope, LOGERR 13420): segue como hoje — exceção, `pMensagensErro` e LOGERR (decisão 15/10, Parada 2).
- Access violation de 14/10 11:04/11:05 no CAIXA2 (`untFatConfOrcamentos`): outro defeito.

## 8. Dependências e riscos
- RF08: dois quadros colados podem ser descartados juntos; o reenvio por ACK cobre, com ~2 s de atraso.
- RF04: detecção pelo `loginNecessario` (finalização) ou pela resposta do `reata` (reconexões a partir da 2ª); os dois passam por `pRefazTefSeServicoReiniciou`, que é onde a finalização sabe que houve re-login.
- Commit da `libTefCitel` pela cópia .150: há alteração pendente do 418470 em `untScopeNCR.pas`/`untTefCitelNCR.pas` — commitar só as units deste requisito.
