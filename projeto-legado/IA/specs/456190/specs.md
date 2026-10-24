# Especificação — Req. 456190

**Título:** Migração de TEF/PinPad do AUTCOM (servidor) para serviço Windows local via RDP DVC
**Objetivo:** Tirar a comunicação física TEF/PinPad (Scope/NCR, SiTef Express/CliSiTef e Pix via PinPad) de dentro do AUTCOM/servidor e executá-la em um serviço Windows na estação do caixa, comunicando com o AUTCOM via RDP Dynamic Virtual Channel (DVC), eliminando a dependência do redirecionamento de porta COM (TSPlus/RDP).
**Zona:** Legado
**Data:** 2026-08-19

## 1. Contexto / problema atual

Hoje as estações de caixa conectam ao AUTCOM (rodando no servidor) via TSPlus/RDP, com redirecionamento de porta COM até o pinpad físico conectado na estação. Esse redirecionamento é instável: qualquer oscilação de rede derruba a porta redirecionada, e a recuperação só acontece reiniciando toda a sessão RDP do operador — interrompendo o caixa.

Causa raiz já investigada e confirmada (não repetir a investigação): o RDP Shortpath/Multitransport (transporte UDP secundário, mais agressivo por padrão no Windows 11 24H2) quebra o handoff de canais/redirecionamentos de terceiros. Forçar TCP puro mitiga o sintoma, mas é decisão de infraestrutura (GPO), fora do escopo deste requisito, e não elimina a fragilidade estrutural de depender de porta COM redirecionada por uma sessão remota.

A solução proposta remove essa dependência: a comunicação física com o pinpad passa a ocorrer localmente, na própria estação, via um serviço Windows. O AUTCOM (servidor) troca apenas mensagens de texto (comando/status) com esse serviço através de um canal RDP Dynamic Virtual Channel (DVC), que sobrevive independentemente de redirecionamento de porta COM.

## 2. Módulos e entidades envolvidos

- **Módulos:** `tef` (UI/orquestração), `libTefCitel` (acesso físico de baixo nível), `PinPad` (captura CPF/CNPJ e QR-Code Pix), `cadastros` (config de terminal), `configuracoes` (parâmetros de sistema).
- **Units atuais (zona Legado):**
  - `fontes\tef\TefCitel\untTefCitelOperacoes.pas` — tela do operador (crédito à vista/parcelado loja/parcelado administradora/débito/pix)
  - `fontes\tef\TefCitel\untTefCitelTransacaoFactory.pas` — fábrica de modalidade (`TEFCIT`: `OPCAO_NCR` / `OPCAO_CLISITEF`)
  - `fontes\tef\TefCitel\untTefCitelTransacaoScope.pas`, `untTefCitelTransacaoSitefExp.pas` — implementações atuais por modalidade
  - `fontes\tef\TefCitel\untTObserverTefAdapter.pas` — Observer que traduz status de transação (`IObserverTEFCitel`)
  - `fontes\tef\TefCitel\untTPixTefBridgeAutcom.pas` — ponte Pix/TEF
  - `fontes\resumodecaixa\untRcxDigCartoesController.pas` — chama a tela do operador (`fChamaTelaDeOperacoes`)
  - `libTefCitel\untScopeNCR.pas`, `untTefCitelNCR.pas` — abre porta COM diretamente (`AbrePINPad`), fala com `scopeapi.dll` (~40 funções resolvidas via `LoadLibrary`/`GetProcAddress`, helper `NcrFunctionDetect`)
  - `libTefCitel\untTefCitel.pas` — wrapper de `CliSiTef32I.dll` (SiTef Express), config `padra_atualizado\CliSiTef.ini` (`[PinPadCompartilhado] Porta=`)
  - `libTefCitel\untInterfaceTefCitel.pas` — define `ITefCitel`, `ISubjectTEFCitel`, `IObserverTEFCitel`, `ITefCitelV2` — **fronteira de substituição usada por este requisito** (RF06)
  - `libTefCitel\untFuncoesLibTefCitel.pas` — `fCriarTefCitel(AstrPath, AstrOpcao): ITefCitel`, fábrica única de instância (`TTefCitelNCR`/`TTefCitel`), reaproveitada tanto no lado AUTCOM (decisão `CFG_TEFDVC`) quanto no serviço da estação (instanciação da `ITefCitel` real)
  - Ambas as classes (`TTefCitelNCR`, `TTefCitel`) implementam `ITefCitel`/`ISubjectTEFCitel`/`ITefCitelV2` — `fConsultaTransacoesPendentesTerminal` (retorna `TUniClientDataSet`) **não é usada pelo projeto** (confirmado pelo usuário), fica fora do escopo de serialização
  - `PinPad\PinPad.Interfaces.pas`, `PinPad.Classes.PinPadFactory.pas`, `PinPad.Classes.Scope.pas`, `PinPad.Classes.Gertec.pas` — captura direta CPF/CNPJ e envio QR-Code Pix (já é external de raiz: `^/PinPad`)
  - `fontes\cadastros\untCadCfgTerminalTef.pas` — cadastro de porta COM por terminal (`TFC_PINPOR`, `TFC_COMTEF`)
  - `fontes\configuracoes\untCfgRepositorio.pas` — registro de parâmetros de sistema (grupo `LIBTEF`)
- **Tabelas/entidades:** `TEFCFG` (chave: terminal/empresa; campos `TFC_PINPOR`, `TFC_COMTEF`, `TFC_NUM_IP`), parâmetros de sistema `CFG_TEFCIT` (existente) e novo `CFG_TEFDVC`.
- **Componentes de terceiro:** `scopeapi.dll` (Scope/NCR), `CliSiTef32I.dll` (SiTef Express/Software Express) — ambos hoje carregados via `LoadLibrary`/`GetProcAddress` dentro do processo `autcom.exe`.
- **Protótipos técnicos de referência:** `DVC/` (base oficial — canal `"TefCitelCh"`, mais maduro) e `PrototipoDVC/` (mais antigo, canal `"CITELTEF"`, histórico).

## 3. Requisitos funcionais

- RF01 — Criar parâmetro de sistema `CFG_TEFDVC` (Sim/Não, grupo `LIBTEF`, default `N`) que ativa/desativa a nova arquitetura DVC.
- RF02 — Com `CFG_TEFDVC = N` (default), manter o funcionamento atual sem alteração de comportamento (Scope/NCR e SiTef Express executados dentro do `autcom.exe`/servidor).
- RF03 — Com `CFG_TEFDVC = S`, o AUTCOM delega a execução física da transação TEF (Scope/NCR ou SiTef Express, conforme `CFG_TEFCIT`) ao serviço Windows local da estação, comunicando via canal RDP DVC.
- RF04 — Criar serviço Windows (gerenciado pelo SCM) na estação, hospedando a lógica de acesso físico ao pinpad: Scope/NCR, SiTef Express/CliSiTef e Pix (`PinPad.Classes.Scope`/`.Gertec`).
- RF05 — Criar plugin cliente DVC (COM, `IWTSPlugin`) carregado pelo client RDP (mstsc/TSPlus) na estação, atuando como relay entre o canal DVC e um named pipe local conectado ao serviço Windows.
- RF06 — A substituição de transporte ocorre na fronteira da interface `ITefCitel`/`ISubjectTEFCitel`/`ITefCitelV2` (já implementada hoje por `TTefCitelNCR`/`TTefCitel`, instanciadas por `fCriarTefCitel`). Com `CFG_TEFDVC = S`, uma nova classe `TTefCitelDvc` (mesmas três interfaces) substitui a instância local: cada método da interface (`fPassarCartao`, `pInfo21`, `pInfo30*`, `pinfo34`, `fFinalizarTransacao`, etc.) é enviado como chamada RPC via DVC para a estação, que executa contra a instância real (`TTefCitelNCR`/`TTefCitel`, sem alteração). O fluxo é multi-etapas (modalidade → dado específico de parcelamento/data → valor → finalizar, incluindo o desvio de menu do débito Banrisul) — não uma mensagem única "dispare e esqueça". A UI (`untTefCitelOperacoes.pas`), a fábrica de modalidade (`untTefCitelTransacaoFactory.pas`), o Observer (`untTObserverTefAdapter.pas`) e a lógica de menus (`untTefModalidadeImpl.pas`, inclusive Banrisul) **não mudam**.
- RF07 — Se o canal DVC cair durante uma transação em andamento no pinpad, o serviço local conclui a transação sozinho, persiste o resultado em fila local (arquivo) e reenvia ao AUTCOM assim que o canal for restabelecido — sem gravação direta em banco pelo serviço local.
- RF08 — A configuração de porta COM por terminal continua centralizada (`TEFCFG.TFC_PINPOR`/`TFC_COMTEF`), consultada pelo serviço local no bootstrap via canal DVC.
- RF09 — Unificar `libTefCitel` (mais todo o código novo deste requisito: transporte DVC, repository DVC, serviço da estação, plugin cliente) em um módulo SVN compartilhado de raiz (external, análogo a `^/PinPad → PinPad/`), reutilizável pelas demais versões mantidas do AUTCOM (ex.: 74.111, 72).
- RF10 — Implementar atualização remota das DLLs de terceiro (Scope e SiTef): no startup do AUTCOM, comparar hash de `scope.zip`/`sitef.zip` (entregues pela equipe de deploy no diretório do `autcom.exe`) com a versão instalada no serviço da estação (consultada via DVC); se diferente, transmitir o `.zip` em base64, fragmentado, pelo próprio canal DVC.
- RF11 — A atualização de DLL (RF10) não deve ocorrer com transação TEF em andamento na estação — deve ser adiada até a estação ficar ociosa (mesma trava `LCKATC` que hoje serializa uso do TEF).

## 4. Regras de negócio

- RN01 — A modalidade de execução física (Scope/NCR vs SiTef Express) continua decidida por `CFG_TEFCIT`, agora resolvida dentro do serviço da estação quando `CFG_TEFDVC = S`.
- RN02 — Um único serviço/canal DVC/pinpad por estação física, mesmo havendo múltiplas sessões RDP/TSPlus abertas na mesma máquina — a serialização de transações concorrentes já é garantida hoje pela trava `LCKATC` no lado AUTCOM.
- RN03 — Resultado de transação finalizada localmente (canal caído) deve ser reenviado ao AUTCOM de forma idempotente ao reconectar — não pode gerar duplicidade de gravação em `MovTef`/`EspelhoTEF`.
- RN04 — Atualização remota de DLL (RF10/RF11) é sempre iniciada pelo AUTCOM (detecta mudança local do `.zip` e empurra ao serviço) — nunca pela estação sozinha.
- RN05 — Enquanto `CFG_TEFDVC = N` for o default, a arquitetura atual (Scope/SiTef direto no servidor) permanece funcional e inalterada — nenhuma modalidade existente é removida por este requisito.

## 5. Requisitos técnicos / não-funcionais

- Nenhuma alteração nas transações de banco existentes (`MovTef`, `EspelhoTEF`) — o novo transporte é transparente à camada de persistência, que continua sendo feita apenas pelo AUTCOM.
- Auditoria: sem alteração — seguem os mesmos pontos de gravação já existentes.
- Fiscal/financeiro: sem alteração de regra — requisito é de transporte/infraestrutura, não de cálculo financeiro.
- Segurança: o canal DVC precisa de validação mínima de autenticação/autorização antes de produção — os protótipos atuais (`DVC/`, `PrototipoDVC/`) não implementam isso (ver risco).
- Compatibilidade: a unificação via SVN external (RF09) precisa ser coordenada com as versões 74.111 e 72 antes de qualquer ativação de `CFG_TEFDVC = S` em produção.

## 6. Critérios de aceitação

- [ ] Com `CFG_TEFDVC = N`, comportamento idêntico ao atual em Scope/NCR e SiTef Express (regressão zero).
- [ ] Com `CFG_TEFDVC = S`, transação de crédito à vista/parcelado loja/parcelado administradora/débito é processada corretamente com o serviço rodando na estação e o pinpad físico, sem uso de redirecionamento de porta COM do TSPlus.
- [x] Fluxo Pix **pela via do TEF** (`ITefCitel.pEnviarQrCode`) funciona via serviço local
  quando `CFG_TEFDVC = S` — o PNG do QR viaja em base64 e é carregado no pinpad pela estação
  (2026-09-12).
- [ ] ~~Fluxo Pix pela via `IPinPadCitel`~~ — **FORA DO ESCOPO deste requisito por decisão do
  Rafael em 2026-09-12: vai para um requisito próprio.** Abrange `PinPad.Classes.Scope` e
  `PinPad.Classes.Gertec` (captura de CPF/CNPJ e a limpeza do visor por `pLimpaQrCodeInterno`),
  que hoje não têm nenhuma referência em `libTefCitel\`. Enquanto o requisito novo não sair,
  terminal **Gertec** não exibe QR no pinpad com `CFG_TEFDVC = S`, e em terminal **Scope** o
  envio funciona mas a limpeza do visor não. O levantamento está na seção "QR-Code Pix" de
  `IA\rules\tef-dvc.md` — ler antes de abrir o requisito novo, para não refazer a
  investigação.
- [ ] Queda do canal DVC durante transação em andamento não perde o resultado: serviço finaliza, guarda localmente e sincroniza ao reconectar, sem duplicidade.
- [ ] Atualização de `scope.zip`/`sitef.zip` no diretório do `autcom.exe` resulta em atualização das DLLs na estação no próximo startup do AUTCOM, sem interromper transação em andamento.
- [ ] Estação sem mudança nos `.zip` não sofre nenhuma ação de atualização (idempotência por hash).
- [ ] `libTefCitel` (+ código novo deste requisito) disponível como módulo SVN external de raiz, referenciável por outras versões do AUTCOM.

## 7. Fora de escopo

- Decisão de infraestrutura sobre desabilitar UDP via GPO nos clientes RDP (tratada fora do código, pela diretoria/infra).
- Migração efetiva de outras versões do AUTCOM (74.111, 72) para consumir o novo external — este requisito só prepara a estrutura compartilhável.
- Qualquer alteração de regra fiscal/financeira das transações de cartão.
- Reescrita da tela `untTefCitelOperacoes.pas` (UI do operador) além do necessário para plugar a nova modalidade.

## 8. Dependências e riscos

- Dependência de decisão de infraestrutura (GPO UDP) fora do código.
- Necessário hardware físico (pinpad) em homologação — sem mock possível para o binário de terceiro.
- Reestruturação SVN (external de raiz) já concluída para esta versão (2026-08-19) — a extensão para as demais versões mantidas (74.111, 72, …) é sequencial, só ocorre após a conclusão desta.
- Transferência de `.zip` binário pelo canal DVC (exceção à regra "só texto") aumenta a superfície de protocolo — precisa de fragmentação e checksum por fragmento.

---

## 9. Fase 3.5 — Vários AUTCOM na mesma estação, um pinpad só (2026-09-03)

Extensão do requisito, levantada e desenhada com o Rafael em 2026-09-03, antes da entrada em
produção. Substituiu uma primeira versão desta seção, escrita no mesmo dia sobre a premissa errada de
que a multiplicidade vinha de **sessões TS** — a infraestrutura esclareceu que é sempre **uma sessão
TS por estação**, com vários `autcom.exe` dentro dela.

### 9.1 Premissas (confirmadas com a infra em 2026-09-03)

- O operador de caixa usa **uma única sessão TS**, gerenciada pelo TSPlus.
- Dentro dela ele abre **vários `autcom.exe`** — comportamento normal de deploy, não exceção.
- Esses AUTCOM podem ser de **empresas diferentes**, compartilhando o **mesmo pinpad físico**.
- A trava `LCKATC` (`fLockUnlockTefCitel`, `untTefCitelUtil.pas`) serializa o uso do TEF entre eles e
  funciona hoje na arquitetura clássica. O operador **pode removê-la manualmente** pelo relatório de
  travas, e faz isso quando um AUTCOM trava.
- Quando um AUTCOM trava, o operador fecha a sessão TS (que fica desconectada por ~100 minutos até o
  Windows/TSPlus derrubá-la) e abre outra. Transação TEF deixada pendente nesse processo é aceitável.

Que o problema de vários AUTCOM por pinpad já é conhecido pela equipe está no próprio código: a
mensagem de `fValidouPinPad` diz *"Verificar se o leitor de cartão com fio [PINPAD] não está sendo
usado por outro Autcom nessa sessão"*.

### 9.2 Problemas na arquitetura DVC

**(P1) O segundo AUTCOM trava no login.** `WTSVirtualChannelOpenEx` é chamado por processo
(`untTefCitelDvcTransporte.pas:367`), então N AUTCOM abrem N canais DVC, o plugin recebe N
`OnNewChannelConnection` e tenta N conexões em `127.0.0.1:47991`. Mas
`untTefEstacaoTcpTransporte.pas:253` faz `listen(..., 1)` e `pLoopServidor` só chama o próximo
`accept()` depois que o socket atual fecha. O `connect()` do segundo AUTCOM **tem sucesso** (o kernel
aceita no backlog) e o plugin se dá por conectado, mas o serviço nunca lê aqueles bytes. Como
`pIniciaTefCitel` faz três RPCs obrigatórios em todo login (`fConfiguraTefCitel`, `fValidouPinPad`,
`fObtemVersao` — `untTefCitelUtil.pas:824` e seguintes) e `fChamaRpc` espera `INFINITE` por desenho
do subsistema, o segundo AUTCOM **trava no próprio login, sem mensagem**.

**(P2) Instância única mistura a configuração entre empresas.** O serviço mantém uma
`FRealInstance` chaveada por `opcao`+`path`. `fConfiguraTefCitel` grava loja/filial/PDV/porta a partir
de `strCodigoLoja`/`strNumTerminal`, então o login do segundo AUTCOM sobrescreve a configuração do
primeiro e uma transação do primeiro sairia com a loja do segundo. Pior: em
`untTefCitelNCR.pas:658`, o `if not blnSomenteCarregarLib` protege **apenas** o `AbreSessaoTEF` — toda
a mutação de configuração acontece antes dele, mesmo no modo "só carregar a lib". E
`pAtualizaContexto` (`untTefEstacaoRoteadorMensagens.pas:948`) aplica `AddInfo` e
`pSetDadosAdicionaisTefTra` na instância a **cada** chamada, de qualquer método.

**(P3) Pendência de confirmação de um PID contaminando a transação de outro.** Se o AUTCOM A deixou
uma transação sem `fFinalizarTransacao` e o operador remove a trava `LCKATC` para seguir no AUTCOM B,
a confirmação/desfazimento seguinte fica ambígua no Scope/SiTef. Segundo o Rafael, esse tipo de
situação acontece com frequência em deploy: os operadores abrem vários AUTCOM e às vezes se perdem
entre eles.

### 9.3 Restrições do código de terceiro (não contornáveis — units off-limits)

Levantadas por leitura de código em 2026-09-03. São o motivo de o desenho ser o que é:

- **`untScopeNCR.pas`, linha 474 (seção `interface`, antes do `implementation` na 536):**
  `FintSinc`, `FstrEmpresa`, `FstrFilial`, `FstrPdv`, `FintComPort`, `FstrMsgPinPad` e `FsppPinPad`
  são **variáveis globais de unit**, não campos de `TTefCitelNCR` (o prefixo `F` engana). A
  configuração efetiva do Scope é, portanto, **uma só por processo do serviço**.
- **Os destrutores das duas classes zeram os ponteiros globais das DLLs.**
  `TTefCitelNCR.Destroy` (`untTefCitelNCR.pas:341`) chama `UnLoadDLLFunctions`, que anula os ~40
  ponteiros `Scope*` de `untScopeNCR.pas`; `TTefCitel.Destroy` faz `FreeLibrary` e anula
  `xConfiguraIntSiTefInterativoEx`, `xIniciaFuncaoSiTefInterativo`, `xObtemVersao`,
  `xObtemDadoPinPadDiretoEx`. **Destruir uma instância cega todas as outras.**
- `CliSiTef32I.dll` e `scopeapi.dll` mantêm sessão e configuração **por processo**, não por instância.
- No CliSiTef o estado de objeto é melhor isolado (`recCartao`/`recInfoReq` são campos de instância,
  `untTefCitel.pas:40-41`), e `fConfiguraTefCitel` **ignora** `blnSomenteCarregarLib` por completo.
- `FConfigurado` (`untTefCitel.pas:35`) é escrito e **nunca lido** — flag morto, não bloqueia nada.
- No caminho do login, `fValidouPinPad` sai na primeira linha quando a trava está tomada
  (`if fSomenteCarregarLib then Exit`) e também para `OPCAO_NCR`. Logo, o login de um AUTCOM com o
  TEF em uso por outro não toca o **pinpad**.
  ⚠️ **Conclusão perigosa, refutada em campo em 2026-09-08:** não tocar o pinpad não quer dizer não
  interferir. O login não mexe no pinpad, mas **confirma a transação pendente do outro AUTCOM** pelo
  item abaixo. Ler os dois juntos.
- **`fConfiguraTefCitel` nativo carrega um confirm embutido** (2026-09-08). Com
  `blnSomenteCarregarLib = False`, `untTefCitelNCR.pas:618` termina em **`FechaSessaoTEF(1, 1)`**
  (linha 685) = `SCO_CONFIRMA_TEF` com `bForcar = 1`; a guarda de `untScopeNCR.pas:890` passa pelo
  `bForcar` e o confirm cai sobre a pendência da sessão global — a de outro AUTCOM. O
  `AbreSessaoTEF(True)` da linha 663 não protege: ele sai fora quando `INI_SESSAO` já está setado
  (`untScopeNCR.pas:1025`). E a linha 688 (`FintSinc := 0`) está **fora** do
  `if not blnSomenteCarregarLib`, então apaga `INI_SESSAO`/`INI_COMUNIC` mesmo no caminho
  "só carregar a lib".
  Comprovado: AUTCOM A (term. 003, pid 71824) autorizou o `Controle 09804893005` às 08:17:51 sem
  finalizar; o login do AUTCOM B (term. 004, pid 86276) às 08:18:40 confirmou a transação do A.
  Login do B em **1,25 s** contra **4,4 s** o do A — a diferença é o `AbreSCOPE` que não rodou.
  No mundo de um AUTCOM por processo a linha 685 é limpeza legítima de sobra de execução travada
  (o caso RN09, já aceito); sob DVC ela vira interferência. É a restrição que motivou a RF17 item 4.
- **Um único slot de pendência por processo** (levantado em 2026-09-04, depois de a confirmação
  cruzada acontecer em campo). `FechaSessaoTEF(SCO_CONFIRMA_TEF)` **não recebe identificador de
  transação**: confirma o que estiver pendente na sessão global. É chamado por `fFinalizarTransacao`
  (`untTefCitelNCR.pas:980`), por `fVerificaPresencaPinPad` (`:2013` — uma *verificação de presença*
  confirma pendência alheia) e por `AbreSCOPE` com `_Desligou = True` (`untScopeNCR.pas:867`).
  Somando às globais de unit acima, **dois AUTCOM não conseguem manter pendências TEF independentes
  no mesmo processo do serviço** — não há como endereçar "a transação do AUTCOM A".
  Detalhe correlato: `AbreSCOPE` só chama `ScopeOpen` quando `(FintSinc and INI_COMUNIC) = 0`
  (`untScopeNCR.pas:852`), então a sessão Scope permanece aberta com os dados do **primeiro** AUTCOM
  que configurou; reaplicar `fConfiguraTefCitel` reescreve as globais mas não reabre a sessão.
  (O `numTerminal` da transação acompanha a reaplicação — confirmado em campo em 2026-09-04 — mas a
  **sessão** continua sendo uma só.)
  Esta é a restrição que derrubou o desenho original da RF17 item 2.

### 9.4 Requisitos funcionais

- RF12 — O serviço da estação deve atender **múltiplas conexões simultâneas**, uma por `autcom.exe`.
  A chegada de um AUTCOM novo não pode bloquear os existentes, nem ser bloqueada por eles.
- RF13 — Toda `chamada` e `hook_resposta` carrega no `contexto` a identidade do AUTCOM de origem:
  `pid` (`GetCurrentProcessId`) e `sessao` (`ProcessIdToSessionId`, apenas informativo no log — todos
  os AUTCOM rodam na mesma sessão do mesmo servidor, então o PID já é único entre eles).
- RF14 — Roteamento por natureza da mensagem: `resposta` de RPC sempre volta pela **conexão que
  originou a chamada**; `evento` (Observer) e `hook` vão pela conexão da **thread de despacho
  corrente**, com a conexão do dono do pinpad como fallback.
- RF15 — **Uma instância `ITefCitel` por PID**, em dicionário, criada sob demanda. Substitui a
  `FRealInstance` única.
- RF16 — **Serialização do pinpad.** Métodos que tocam o pinpad (`fPassarCartao`,
  `fCancelaTransacaoTerminal`, `fReimpressao`, `fConfiguraTefCitel` com
  `blnSomenteCarregarLib = False`, `fVerificaPresencaPinPad`, `fObtemDadoPinPadDireto`,
  `pEnviarQrCode`, `pLimpaQrCode`, `pInfo*`, `pSair`) passam pela sequência de aquisição da RF17. Os
  demais (`fConfiguraTefCitel` com `blnSomenteCarregarLib = True`, `fObtemVersao`, `fTraduzirErro`,
  `pRetornaLog`, `fInfoPixCadastro`) são atendidos direto, na instância do próprio PID.
- RF17 — **Sequência de aquisição do pinpad** pelo PID X:
  1. transação **em voo** de outro PID → erro explícito e log com o PID detentor (single-flight já
     existente);
  2. outro PID **ainda conectado** com transação **pendente de confirmação** → **recusa** a chamada
     do X, com erro explícito nomeando o PID e o terminal detentor, e log. Não orfana e não reaplica
     configuração (RF19). *Desenho anterior — orfanar o detentor e seguir — foi abandonado em
     2026-09-04: com um slot único de pendência por processo (9.3), a transação do X resolve a
     pendência do detentor de qualquer jeito, então tomar o pinpad dele nunca é seguro;*
  3. **impressão digital** de configuração diferente da aplicada → reaplica `fConfiguraTefCitel` do X
     e atualiza a impressão digital corrente; igual → pula (RF20);
  4. **`fConfiguraTefCitel` do login não pode ser recusado** — o AUTCOM precisa subir com o TEF
     habilitado. Quando os itens 1 ou 2 valerem, o login é **adiado**: o serviço guarda os argumentos
     em `FstrCfg*`, **não chama a DLL nativa**, deixa a impressão digital corrente intacta (ela é do
     detentor, e é verdade) e responde `0`. A configuração real entra na primeira chamada de pinpad,
     pelo item 3 — que, enquanto o detentor não resolver, é recusada pelo item 2. *Motivo em 9.3: o
     `fConfiguraTefCitel` nativo termina em `FechaSessaoTEF(SCO_CONFIRMA_TEF, forçado)` e
     confirmaria a transação pendente do detentor. Acrescentado em 2026-09-08 — a RF16 já exigia que
     o login passasse por esta sequência, mas a implementação o havia deixado de fora de
     `fMetodoUsaPinpad`;*
  5. executa o método na instância do X.
- RF18 — **Orfanar, nunca destruir — e só na desconexão.** Uma sessão sai do dicionário de ativas e
  vai para a lista de órfãs quando **a conexão daquele AUTCOM cai**, mantendo o objeto vivo. Não há
  reconexão do lado AUTCOM (`untTefCitelDvc.pas`, `pOnDesconectado`, apenas falha as chamadas
  pendentes; o canal WTS é aberto uma única vez no construtor do transporte), então quem volta chega
  como conexão nova e refaz o `fConfiguraTefCitel` do login. Órfãs só são destruídas quando não
  houver **nenhuma sessão ativa nem thread de despacho** — único momento em que anular os ponteiros
  globais das DLLs não cega ninguém (9.3). **Sessão de AUTCOM vivo nunca é orfanada** (RF19).
- RF19 — **Vivo bloqueia; ido libera.** O critério para o pinpad poder ser tomado é a **conexão TCP**
  daquele AUTCOM, e não a trava `LCKATC` — que é por empresa e, portanto, não protege AUTCOM de
  empresas diferentes (brecha achada em campo em 2026-09-04, com a pendência do AUTCOM A sendo
  resolvida pela transação do AUTCOM B).
  - **Conexão aberta** = AUTCOM vivo. A pendência dele é legítima, o outro é recusado, e o operador
    conclui naquele AUTCOM ou o encerra.
  - **Conexão caída** = AUTCOM foi embora (fechado ou morto pelo gerenciador de tarefas). A sessão já
    foi orfanada na desconexão (RF18) e o outro AUTCOM segue normalmente.

  Não existe marca de "pendência abandonada" por PID: um AUTCOM encerrado volta com PID novo, e a
  marca seria inalcançável. O serviço é o único ponto do sistema que enxerga todos os AUTCOM da
  estação independentemente de empresa — é onde essa proteção pode de fato ser cumprida.
- RF20 — **Impressão digital de configuração**: `opcao` + `path` + `strEnderecoIp` +
  `strCodigoLoja` + `strNumTerminal` + `strParametrosAdicionais`. A reaplicação de
  `fConfiguraTefCitel` na troca de PID só ocorre quando a impressão digital muda — dois AUTCOM da
  mesma empresa e mesmo terminal alternam com custo zero.
- RF21 — A fila local (RF07) grava o PID de destino de cada item; o reenvio entrega somente itens do
  PID daquela conexão, e itens de PID abandonado são descartados com log.
- RF22 — Toda decisão relevante vai para o log do serviço: aquisição do pinpad (PID, empresa/terminal,
  decisão), orfanamento (PID, empresa/terminal, documento pendente), recusa por pendência abandonada,
  reaplicação ou skip de configuração, e descarte de itens de fila.

### 9.5 Regras de negócio

- RN06 — **"Transação ativa"** = **em voo** (chamada dentro da DLL nativa) **ou pendente de
  confirmação**. Decisão do Rafael, 2026-09-03.
  **Só o `fPassarCartao` gera pendência, e só quando devolve retorno** (revisto duas vezes em
  2026-09-08). O critério não é "devolveu retorno", é **"devolveu retorno deixando a sessão
  aberta"** — comparando os três métodos no nativo:

  | Método | No sucesso | Pendência? |
  |---|---|---|
  | `fPassarCartao` (`untTefCitelNCR.pas:1834`) | `Result := FRetorno`, **sem** `FechaSessaoTEF` | **sim** — o AUTCOM confirma depois com `fFinalizarTransacao` |
  | `fCancelaTransacaoTerminal` (`:576`) | `FechaSessaoTEF(SCO_CONFIRMA_TEF)` e **só então** `Result := FRetorno` | não — já confirmado |
  | `fReimpressao` | idem cancelamento | não |

  É por isso que `TfrmTefCitelAdministracao` chama `fCancelamentoNormal` e **nunca** chama
  `fFinalizarTransacao` — a unit inteira não tem uma referência ao método. Não há o que confirmar.

  Sem retorno a marca **não é tocada** — nem posta, nem limpada; limpar quebraria o fluxo de
  múltiplos cartões, onde o nativo pula o `DESFAZ` de propósito porque o cartão anterior continua
  pendente (`FblnMultCartoes`, `:1781`/`:1813`).

  *Histórico das duas revisões, ambas comprovadas em campo em 2026-09-08:* a marca era posta pelo
  **nome do método**; como o AUTCOM não chama `fFinalizarTransacao` depois de uma negativa, ela
  ficava presa em `True` e bloqueava o outro terminal (1ª revisão, critério passou a ser o retorno).
  Depois, um **cancelamento bem-sucedido** no AUTCOM A travou o B às 10:33:58 até o A fechar — o
  cancelamento devolve retorno mas já se confirmou sozinho (2ª revisão, `fCancelaTransacaoTerminal`
  saiu da marcação).
- RN07 — **Nunca misturar transação TEF entre PIDs, mesmo de empresas iguais** (decisão do Rafael,
  2026-09-03). Se alguém remover a trava `LCKATC`, a proteção passa a ser do serviço local. A
  `LCKATC` também **não cobre AUTCOM de empresas diferentes** — nesse caso o serviço é a única
  proteção existente, não a segunda linha (RF19).
- RN08 — Orfanar, nunca destruir enquanto houver instância ativa (RF18). Não é preferência de estilo:
  os destrutores anulam ponteiros globais compartilhados (9.3).
- RN09 — A transação de um AUTCOM encerrado **fica pendente no servidor do TEF** e é resolvida pela
  rotina de pendências. **Ressalva provada em campo (2026-09-04):** com um slot único de pendência
  por processo (9.3), não há garantia de que ela permaneça pendente — a próxima transação ou
  confirmação de outro AUTCOM pode resolvê-la. Isso é a perda já aceita pelo Rafael em 2026-09-03
  ("não tem importância se alguma transação TEF ficar pendente, pois isso já ocorre caso o autcom
  trave") e não é regressão em relação ao comportamento atual. É exatamente por não haver como
  impedir isso que a RF19 barra o caso do AUTCOM **vivo**, que é o evitável.
- RN10 — O plugin cliente DVC continua sendo relay burro de bytes: nenhuma lógica de PID, posse ou
  protocolo entra nele.
- RN12 — **`CFG_TEFDVC` é por empresa, e precisa ser igual em todas as empresas que compartilham a
  mesma estação/pinpad.** O parâmetro é registrado com default `N`
  (`untCfgRepositorio.pas`, `pAdicionarConfiguracao('CFG_TEFDVC', ..., 'N', 'LIBTEF', False)`) e
  `fCfgSis('TEFDVC')` resolve contra `VS_strCodEmp` — a lista de parâmetros com empresa alternativa
  (`VS_ArrCfgSisDes`) só é preenchida em contexto de faturamento e não alcança este.
  Consequência de misturar: o AUTCOM da empresa com `S` fala com o serviço da estação pelo canal
  DVC, enquanto o da empresa com `N` abre a **porta COM redirecionada direto do servidor** (modo
  clássico). São dois mecanismos disputando o mesmo pinpad físico, e nenhum dos dois enxerga o
  outro — nem a trava `LCKATC`, nem a serialização do serviço da estação. É pior que qualquer um
  dos dois modos isolado.
  Achado em 2026-09-04, ao investigar por que um teste de dois AUTCOM não gerava `con=2`: o
  segundo AUTCOM estava numa empresa com `CFG_TEFDVC = N` e por isso nunca criou `TTefCitelDvc`.
  Sintoma de diagnóstico: o `TefCitelDvcTransporte.log` (arquivo único, compartilhado pelos
  AUTCOM do servidor) mostra apenas UM conjunto de threads, com `seq` começando em 1.
- RN11 — `pid`/`sessao` são identidade para correlação e isolamento, **não** credencial: qualquer
  processo local ainda pode conectar no socket e declarar o PID que quiser. O risco de
  autenticação do canal continua o da seção 5.

### 9.6 Critérios de aceitação

- [ ] Dois ou mais AUTCOM abertos na mesma sessão TS, todos com `CFG_TEFDVC = S`, concluem o login
      sem travar (hoje o segundo trava mudo — P1).
- [ ] AUTCOM A e AUTCOM B de **empresas diferentes**: transação em cada um sai com a loja/terminal
      corretos (hoje o segundo login sobrescreveria a configuração do primeiro — P2).
- [ ] Fluxo normal alternando A → B → A, com `LCKATC` respeitada e todas as transações finalizadas:
      **nenhum** orfanamento, e nenhuma reconfiguração quando A e B são da mesma empresa/terminal.
- [ ] AUTCOM A com transação pendente de confirmação, trava `LCKATC` removida manualmente, cartão
      passado no AUTCOM B: instância do A orfanada com log, transação do B íntegra, pendência do A
      permanece no servidor TEF.
- [ ] `fFinalizarTransacao` tardio do AUTCOM A, depois do orfanamento: recusado com erro explícito e
      registrado em log; a transação do B não é afetada.
- [ ] Resultado do AUTCOM A na fila local e outro AUTCOM conectando: a resposta do A não é entregue a
      ele (log de descarte por PID).
- [ ] `CFG_TEFDVC = N`: comportamento inalterado (regressão zero).

### 9.7 Premissa a validar em campo

Que o RDP DVC aceita **várias instâncias simultâneas do mesmo canal na mesma sessão** — é o
comportamento padrão do protocolo, e é o que sustenta a RF12. É a primeira coisa a confirmar no teste
do Passo 3; se não valer, o desenho da multi-conexão precisa ser revisto antes de seguir.

### 9.8 Fora de escopo desta fase

- Impedir que o operador remova a trava `LCKATC` — o relatório de travas continua como está; esta
  fase trata a consequência, não o gesto.
- Corrigir as globais de unit de `untScopeNCR.pas` ou os destrutores das classes nativas — units
  off-limits; o desenho contorna, não conserta.
- Autenticação/autorização do canal DVC (RN11).
## 10. Fase 5 — Estabilidade sob oscilação de comunicação (2026-09-09)

Levantada em debate com o Rafael em 2026-09-09, a partir de uma dúvida sobre fechar e reabrir a
sessão TS com transação pendente. **É o pilar central do requisito** (definição do Rafael na mesma
sessão): garantir a estabilidade do TEF mesmo com oscilação de comunicação. As fases anteriores
fizeram o TEF rodar na estação; esta faz ele sobreviver à rede.

### 10.1 O que a Fase 3.5 deixou aberto

Tudo abaixo foi provado por leitura de código em 2026-09-09, não é hipótese:

- **A queda de RDP fecha o canal DVC de verdade.** `TTefCitelDvcCanalCallback.OnClose` → `Destroy`
  → `pFechaConexaoJaTravada` derruba o socket; na volta, `OnNewChannelConnection` cria callback e
  socket novos. O plugin reconecta o socket transparentemente (`untTefCitelDvcPluginImpl.pas:442`),
  mas isso só vale para queda do socket — não para queda da sessão RDP.
- **A estação descarta estado que não devia.** `pOnDesconectado` orfana a sessão na queda da
  conexão, e `fGaranteSessao` **nunca consulta `FlstOrfas`** — o AUTCOM que volta com o mesmo PID
  recebe sessão nova e perde `FblnTransacaoPendenteConfirmacao` e a digital de configuração
  (`FstrCfg*`). O próprio log do `pOrfanaSessao` justifica a perda com *"o mesmo já acontece quando
  o autcom trava"*, justificativa que pressupõe um AUTCOM que foi embora — e na oscilação ele não
  foi.
- **O AUTCOM registra CANCELADA numa transação aprovada.** `TTefCitelDvc.pOnDesconectado` marca
  `ErroCanal` em todas as chamadas pendentes; o `fChamaRpc` estoura
  (`untTefCitelDvc.pas:999`) e o `finally` de `fPassaCartao` grava **`TRANSACAO_CANCELADA`** no
  TEFTRA (`untTefCitelUtil.pas:2189`), porque `Result` ficou nil. A adquirente aprovou.
- **O re-login do próprio AUTCOM confirma a própria pendência.** `fOutroAutcomDetemPinpad` isenta o
  próprio PID (`untTefEstacaoRoteadorMensagens.pas:1833`), então o `fConfiguraTefCitel` do re-login
  cai no `FechaSessaoTEF(1, 1)` embutido e atropela a pendência que ele mesmo deixou.
- **Frequência.** Em cliente com oscilação de internet este é o caso **comum**, não a exceção
  (Rafael, 2026-09-09) — e nele o `autcom.exe` **sempre** sobrevive, porque é disconnect e nunca
  logoff. O caso "mesmo PID volta" deixa de ser exceção e passa a ser a regra.

### 10.2 Os dois casos, e o que cada um deve fazer

Delimitação do Rafael, 2026-09-09:

| Caso | Estado | Desfecho exigido |
|---|---|---|
| **1 — oscilação** | PID igual, serviço igual, só o DVC caiu e voltou | **Roda até o fim**: transação confirmada ou desfeita, venda registrada. Sem operador, sem mensagem, sem pendência |
| **2 — AUTCOM travado** | operador abriu outro AUTCOM | Transação do travado **fica pendente** (RN09, inalterada); instância do travado **destruída** na estação; o novo trabalha. **O travado não segura o pinpad** |

### 10.3 Requisitos funcionais

- RF23 — **Identidade de processo nas duas pontas.** O `contexto` passa a carregar
  `inicioProcesso` (creation time do próprio processo, via `GetProcessTimes`) além de `pid`. O par
  `(pid, inicioProcesso)` identifica a instância do processo sem estado inventado e muda sozinho
  quando o `autcom.exe` reinicia — é o que protege contra reuso de PID no servidor. Simetricamente,
  o serviço da estação passa a ter identidade de instância própria, informada ao AUTCOM (RF29).
- RF24 — **Sessão desanexada.** `pOnDesconectado` deixa de orfanar. A sessão permanece em
  `FdictSessoes` sem conexão associada, preservando `FblnTransacaoPendenteConfirmacao`, a digital de
  configuração e a própria `ITefCitel`. `fGaranteSessao` reata quando `(pid, inicioProcesso)` batem;
  se o `inicioProcesso` não bate, é processo novo — a sessão anterior é orfanada e nasce uma nova.
  **Não há prazo de desanexação:** a sessão só sai por identidade nova, processo morto ou tomada
  autorizada pelo operador.
- RF25 — **Reconexão do canal no lado AUTCOM, e a chamada que continua esperando.**
  `TTefCitelDvcTransporte` passa a reabrir o canal em laço quando ele morre (mesmo formato do
  `pLoopConectorELeitura` que o plugin já usa do outro lado do link), guardando o nome do canal em
  campo. `pNotificaDesconexao` deixa de significar morte permanente: não marca mais `ErroCanal` nas
  chamadas pendentes, só registra log e sinaliza "reconectando" para a tela. **A chamada continua
  esperando** — comportamento correto pela regra do `IA\rules\tef-dvc.md`, porque a transação real
  está viva na estação e vai responder. É esta mudança, e só ela, que faz a venda se recuperar
  dentro da chamada original, sem segundo caminho de gravação para tornar idempotente.
- RF26 — **Frame `reata`, primeiro de cada conexão nova.** Carrega `pid`, `inicioProcesso`,
  identidade da instância do serviço conhecida pelo AUTCOM e os **ids das chamadas pendentes**. A
  estação responde, por id: `emVoo`, `naFila` ou `desconhecido`. Resolve três coisas:
  1. a estação passa a conhecer a identidade **no accept** — o gatilho da fila local (RF21) deixa de
     depender de uma chamada nova, fechando o furo registrado no Passo 8;
  2. id `desconhecido` falha a chamada **na hora**, com motivo, em vez de esperar para sempre;
  3. a identidade chega sem depender do `contexto` de uma chamada.
  Exige um campo novo na estação: hoje ela guarda `FblnTransacaoEmAndamento` e
  `FdwPidTransacaoEmAndamento`, mas não o `id` em voo — passa a guardar.
- RF27 — **Sonda de vivacidade, sob demanda.** Quando um AUTCOM disputa o pinpad e o detentor tem
  conexão viva, a estação manda um hook de vivacidade. Como `pTrataHook` despacha via
  `TThread.Queue(nil, ...)`, o corpo roda na **thread principal** do AUTCOM: um AUTCOM travado nunca
  drena essa fila e nunca responde, enquanto um AUTCOM saudável responde **mesmo dentro de um
  `fPassarCartao`**, porque o `fChamaRpc` bombeia `CheckSynchronize`/`ProcessMessages` no laço de
  espera. É discriminador exato entre travado e saudável, e não custa tráfego periódico — só é
  perguntado quando alguém disputa.
- RF28 — **Destruição ordenada da órfã no login seguinte.** O `pColetaOrfasSeOcioso` hoje exige
  nenhuma thread de despacho **e** `FdictSessoes.Count = 0`; a segunda condição nunca vale no caso 2,
  porque a sessão do AUTCOM novo já entrou no dicionário. Mantém-se a condição que protege de verdade
  (nenhuma thread de despacho — sem operação ativa, não há global compartilhado em uso, que é o
  motivo da RN08) e **descarta-se a contagem de sessões**; a órfã é destruída **no caminho do login do
  AUTCOM novo, antes de tocar a DLL**, de forma ordenada em vez de depender de uma janela de
  ociosidade que nunca chega.
- RF29 — **Reinício do serviço da estação.** Ao subir, o serviço **varre o diretório da fila local e
  descarta o que encontrar, com log e contagem** — por definição é de instância anterior, e entregar
  aquela resposta faria o AUTCOM registrar uma venda que ele não consegue mais confirmar (o
  `fFinalizarTransacao` iria para uma instância cuja sessão Scope não sabe daquela transação). E a
  resposta do `reata` carrega a identidade da instância: se mudou, o AUTCOM não recebe
  `desconhecido` genérico, recebe **"o serviço da estação reiniciou"**, falha a chamada pendente com
  esse motivo, **refaz o processo de TEF por inteiro** e direciona o operador ao relatório de TEF
  para conferir pendência não confirmada.
- RF30 — **Saída explícita do operador.** A tela do TEF ganha "cancelar espera", que falha a chamada
  **localmente**. A transação segue na estação e vira pendência (RN09). É a única forma honesta de
  encerrar: o AUTCOM não pode afirmar que a transação falhou, apenas que desistiu de esperar. Sem
  isso a espera é infinita quando a estação não volta (serviço parado, estação desligada).

### 10.4 Regras de negócio

- RN13 — **Só a conexão atual do detentor é isenta das guardas.** `fOutroAutcomDetemPinpad` e
  `fSessaoVivaComPendencia` param de comparar PID e passam a comparar identidade **e conexão**: uma
  conexão anterior do mesmo PID não é isenta. É isto que impede o re-login do próprio AUTCOM de
  confirmar a pendência que ele mesmo deixou.
- RN14 — **A sonda tem prazo; a transação não.** O prazo da sonda de vivacidade (RF27) não viola a
  regra do `IA\rules\tef-dvc.md`, porque não incide sobre chamada de pinpad: o estouro da sonda não
  cancela, não aborta e não repete nada — decide apenas quem fica com o pinpad **a seguir**. A
  transação do detentor continua rodando na estação em qualquer desfecho da sonda.
- RN15 — **Um AUTCOM nunca derruba outro AUTCOM.** O AUTCOM que disputa o pinpad apenas **relata
  fatos verificáveis** (o processo do detentor não existe mais); quem decide é a estação, e o veto
  dela é a sonda, que o requisitante não tem como falsificar nem contornar. Nenhum caminho do
  desenho mata processo alheio. Se o detentor está saudável, ele responde e o requisitante é
  recusado **independentemente do que o operador faça com a LCKATC** — o que é uma mudança de
  comportamento em relação a hoje, na direção segura, e é o propósito da RF19.
- RN16 — **Tomada do pinpad de AUTCOM travado exige confirmação humana.** A estação nunca toma o
  pinpad sozinha no caso "travado": ela habilita, e o operador confirma na tela do AUTCOM que
  chegou. O motivo é um falso positivo conhecido — o `record.md` registra que uma closure de hook
  pode ficar atrás de um `fMensagem` **modal** na fila FIFO, então um AUTCOM saudável esperando o
  operador clicar pode não responder a sonda no prazo. Com o humano no circuito, um falso positivo
  não quebra a transação do detentor em silêncio. Processo **morto** (não travado) dispensa
  confirmação, porque ali não há ambiguidade.
- RN17 — **A estação continua sem acesso a banco.** A vivacidade do detentor é resolvida por
  processo (`OpenProcess` + `inicioProcesso`) e não por `LCK_CON_ID`, porque quem consulta é o
  AUTCOM que chegou — que roda no **mesmo servidor** que o detentor (*"Todos rodam no MESMO
  servidor, entao o PID e unico entre eles"*) e já tem banco. A decisão do levantamento de o serviço
  não tocar MySQL fica intacta.

### 10.5 Revisões de regras das fases anteriores

Nenhum texto anterior foi apagado. Cada regra abaixo permanece como está e ganha a ressalva:

- **RF17 item 4 — revisto em 2026-09-09.** A guarda passa a valer também para conexão anterior do
  mesmo PID (RN13). O login adiado deixa de isentar o próprio PID quando a pendência veio de uma
  conexão que já caiu.
- **RF18 — revisto em 2026-09-09.** O princípio fica: orfanar nunca destrói na hora, e a coleta
  respeita a ausência de thread de despacho (RN08). **O gatilho muda:** sai *"a conexão caiu"* e
  entram identidade diferente no mesmo PID, processo morto confirmado pelo AUTCOM que chegou, ou
  tomada autorizada pelo operador. Ganha o estado intermediário **desanexada** (RF24), que não é
  lista nova — é a sessão saber qual é sua conexão atual, ou `nil`.
- **RF19 — revisto em 2026-09-09.** Volta a alcançar a pendência que a oscilação fazia desaparecer,
  porque a sessão desanexada preserva o flag. O motivo pelo qual a revisão de 2026-09-04 removeu a
  marca de pendência abandonada (*"um AUTCOM encerrado volta com PID novo, e a marca seria
  inalcançável"*) deixa de valer para a oscilação, onde o PID **não** muda; continua valendo para
  AUTCOM encerrado de verdade.
  **Ressalva contra leitura errada:** a soma de RF19 com RF24 poderia sugerir que o AUTCOM novo do
  caso 2 fica bloqueado para sempre, já que a sessão desanexada do travado continua em
  `FdictSessoes` com a pendência. Não fica: é exatamente para isso que existe o fluxo de disputa
  (RF27/RN16). A sonda não é respondida, o operador confirma, a sessão do travado é **orfanada** e
  aí a pendência sai do alcance do `fSessaoVivaComPendencia` — o AUTCOM novo passa. O bloqueio da
  RF19 só é permanente enquanto o detentor **responde**, isto é, enquanto está saudável.
- **RF21 — revisto em 2026-09-09.** Não é retrabalho: muda o ponto de chamada. O gatilho da drenagem
  sai de `pAtualizaContexto` e vai para o `reata` (RF26), voltando a acontecer no accept com o PID já
  conhecido. `fMarcaFilaLocalReenviada` continua servindo. O descarte por idade
  (`TEF_ESTACAO_FILA_VALIDADE_MINUTOS`) continua, mas muda de papel: deixa de ser o destino provável
  dos itens e volta a ser higiene. **Soma-se a ele** a varredura de subida do serviço (RF29), que
  descarta na subida o que ficou de uma instância anterior do processo.

  > Reescrito em 2026-09-10 (item 5 do Passo 8). A frase era *"Some a varredura de subida do
  > serviço (RF29)"*, que lê igualmente como **somar** e como **sumir** — e decidia metade do
  > Passo 7. Na época foi resolvida por evidência (a varredura existe e rodou em campo em 10/09,
  > 10:25–10:31), não pelo texto. O sentido correto é **somar**.
- **RF25 parte 2 e RF30 — REVISTOS em 2026-09-09, e saem de escopo (decisão do Rafael).**
  A chamada pendente **não** passa a esperar a reconexão. Em vez disso: quando a conexão de um
  AUTCOM com **transação em voo** cai, a **estação aborta** a transação chamando `pSair` na
  instância real, no mesmo instante da queda; o AUTCOM continua estourando com `ErroCanal` e
  mostrando a mensagem que já mostra hoje, e **o operador tenta de novo do zero**. Com isso o
  `TRN CANCEL` que o `fPassaCartao` grava na TEFTRA passa a ser **verdadeiro** em vez de um chute —
  o defeito registrado em 10.1 se resolve por tornar o valor correto, não por mudar o valor.
  Sai de escopo: o `fChamaRpc` que espera (RF25 parte 2) e o "cancelar espera" (RF30).

  **Por que é seguro** (conferido no nativo em 2026-09-09): `pSair` **não** chama `FechaSessaoTEF`.
  Ele apenas faz `FintContinua := -1` (`untTefCitelNCR.pas`), e essa flag é lida num callback que a
  DLL do Scope consulta **enquanto coleta** — o comentário do próprio código diz *"pega a tecla 9 da
  aplicação"*. Equivale ao operador apertar cancelar no pinpad, pelo caminho nativo normal: não
  confirma nem desfaz nada por conta própria.

  **Proteção por construção:** o laço só consulta a flag enquanto `iRet = SCO_TRN_EM_ANDAMENTO`.
  Passada a coleta, a transação vai para autorização e a flag **não é mais lida**. Logo **não existe
  o risco de abortar uma transação já autorizada.**

  **Por que a estação e não o AUTCOM:** ela sabe da queda no instante em que ela acontece; o AUTCOM
  só poderia mandar o `pSair` depois de o canal voltar — 23 s na medição de campo das 11:27.
  Abortar imediatamente maximiza a chance de a flag ser lida antes de a transação sair da coleta. E
  não exige mexer na DLL do AUTCOM.

  **Resíduo aceito:** se a queda pegar a transação **já fora da coleta** (autorizando ou
  autorizada), o aborto chega tarde e é ignorado — a transação termina e o desfecho é o de hoje
  (aprovada na adquirente, registrada como `TRN CANCEL` no AUTCOM, pendência no servidor do TEF pela
  RN09). A janela é estreita porque a autorização dura poucos segundos, contra uma coleta que dura o
  tempo do operador. Fechar essa janela exigiria a RF25 parte 2, que foi deliberadamente descartada.

  **Alternativa descartada, e ela ficou mais barata do que era:** a bateria de campo das 11:27
  mostrou que o lado da estação de "continuar a transação" **já funciona** — com a `FConexaoAtual`
  (Passo 3), todos os eventos do pinpad e a própria resposta atravessaram a reconexão e chegaram
  pela conexão nova. Faltava apenas o `fChamaRpc` não desistir. Ainda assim o Rafael escolheu o
  aborto, por simplicidade do processo: retentativa em vez de continuação. Registrado porque a
  alternativa está a poucas linhas de distância se a operação pedir.
- **RF17 item 5b — escopo esclarecido em 2026-09-09.** O item cobria o `pSair` de **outro**
  AUTCOM (respondido como no-op, para não atropelar quem detém o pinpad). O caso do **mesmo**
  AUTCOM não tinha guarda e não passa a ter: `fOutroAutcomDetemPinpad` isenta o próprio pid e
  `pSair` não é método de transação, então o single-flight também não o barra. Observado em campo
  em 2026-09-09 às 10:43:18 — o `pSair` encerrou a sessão no pinpad e a transação em voo do próprio
  AUTCOM voltou "SEM retorno".
  **Decisão do Rafael, 2026-09-09: manter, tratando como cancelamento explícito e deliberado do
  operador.** O `pSair` vem de `TfrmTefCitelOperacoes.pEncerrar`, que é o operador fechando a tela
  do TEF: barrar o prenderia ali, e sair é justamente a intenção dele. Se o cartão já tinha sido
  autorizado, a transação fica pendente no servidor do TEF (RN09).
  O que faltava era rastro: a estação passou a **logar** a relação causal (RF22), porque sem ela o
  arquivo mostra o `pSair` com sucesso e, separado, a transação voltando sem retorno, sem nada
  ligando um ao outro. Nenhuma mudança de comportamento.
- **RN09 — mantida sem alteração.** A pendência do AUTCOM encerrado ou tomado continua sendo perda
  aceita, com a ressalva do slot único (9.3) como está escrita. A Fase 5 **não** promove a pendência
  a fato da estação nem interrompe o AUTCOM novo: o caso 2 exige que o AUTCOM novo trabalhe, e que o
  travado não segure o pinpad (Rafael, 2026-09-09). O que a Fase 5 tira da RN09 é o caso 1, que
  nunca deveria ter caído nela.

- **RF27 — precisado em 2026-09-09, na implementação (Passo 6).** O texto fica; o alcance da
  disputa é mais estreito do que ele sugere, por três razões que só ficaram claras no código:
  1. **A disputa só vale contra o detentor por PENDÊNCIA de confirmação, não contra transação em
     voo.** Tomar o pinpad significa orfanar a sessão do detentor, e a RN08 proíbe destruir
     instância com thread de despacho rodando. O argumento decisivo, porém, é que "em voo" é
     transitório: se a conexão do detentor cai, a estação aborta a transação dele com `pSair` em
     milissegundos (RF25 pt.2 revista). Não existe detentor em voo permanente para disputar.
  2. **Só os três métodos de transação disparam disputa** (`fPassarCartao`,
     `fCancelaTransacaoTerminal`, `fReimpressao`). A sonda custa até 5 s e pode acabar em pergunta
     ao operador; um `pInfo21` da Modalidade Dinâmica roda dezenas de vezes por venda e o operador
     nem sabe que ele existe.
  3. **O login continua adiado, sem sonda** (RF17 item 4 inalterado). A disputa acontece na
     primeira chamada de pinpad — o momento em que o operador de fato quis usar o TEF, e portanto
     o momento certo de perguntar.

  Ganha também um requisito de compatibilidade que não estava previsto: o AUTCOM declara
  `suportaDisputa` no contexto, e a estação só devolve a recusa contestável a quem declarou.
  Serviço e `libTefCitel.dll` são implantados separadamente, então a versão de um não diz nada
  sobre a do outro — sem a marca, um serviço novo devolveria "contestável" a um AUTCOM antigo, que
  leria como sucesso vazio e deixaria o operador sem mensagem nenhuma.

  E a confirmação da RN16 sai por **callback registrado pelo host** (`pSetConfirmaTomadaPinpadTef`,
  novo export da `libTefCitel.dll`), não por diálogo dentro da DLL: a `libTefCitel.dll` não linka
  `libFuncoes` e não enxerga o `fMensagem` do projeto. Decisão do Rafael, com o preço aceito de o
  `autcom.exe` passar a mudar junto com o serviço e a DLL.

- **RF27 — A SONDA POR HOOK SAIU DE ESCOPO em 2026-09-09, 17:28.** Implementada, testada em campo
  e descartada no mesmo dia. O motivo não é prazo mal calibrado: é que **a disputa só acontece
  contra o detentor por pendência, e um AUTCOM com pendência está por definição fora de qualquer
  chamada de TEF** — parado esperando o operador confirmar ou desfazer. O argumento que sustentava
  a sonda ("responde mesmo dentro de um `fPassarCartao`, porque o `fChamaRpc` bombeia
  `CheckSynchronize`") é verdadeiro e irrelevante: o único caso que chega à sonda é o caso em que
  ele não está dentro de chamada nenhuma. Em campo, um AUTCOM saudável esperando o operador ficou
  5 s mudo e foi classificado como travado (o transporte dele ACKou o quadro em 22 ms).

  **No lugar:** quem responde "está travado?" é o **Windows**, por `IsHungAppWindow` — a mesma API
  do "Não Está Respondendo" — consultado pelo AUTCOM **requisitante**, que já verifica o processo
  do detentor pela RN17 e roda no mesmo servidor. Três degraus: processo morto → tomada
  automática; processo vivo e respondendo → **recusa sem perguntar nada ao operador**; processo
  vivo e travado → pergunta ao operador.

- **RN14 — sai de escopo junto com a sonda.** Não há mais prazo nenhum incidindo sobre o detentor.

- **RN15 — revista em 2026-09-09, 17:28.** O texto dizia que *"o veto é a sonda, que o
  requisitante não tem como falsificar nem contornar"*. Sem sonda, o veto passa a depender do
  relato do requisitante, e a trava real vira a **confirmação humana** (RN16), somada às duas
  guardas que a estação ainda faz sozinha: o veredito só vale se o par (pid, inicioProcesso) bater
  com o detentor daquele instante, e "morto" só é aceito com a conexão caída. Na direção que
  importa o comportamento melhorou: um detentor respondendo é recusado **sem incomodar ninguém**.

- **RF17 item 4 — defeito corrigido em 2026-09-09, 17:28 (erro 64004).** O login adiado nunca era
  aplicado quando os dois AUTCOM eram da **mesma empresa e mesmo terminal**: a reaplicação de
  `pGarantePinpadConfigurado` era decidida só pela impressão digital, que nesse caso é idêntica.
  A impressão digital responde "a DLL está configurada assim?" — um fato de **processo**; o login
  é também um fato de **instância**, porque é o `fConfiguraTefCitel` que monta o estado dentro da
  `ITefCitel` daquela sessão. A sessão ganhou `FblnCfgAplicadaNaInstancia` e a saída antecipada
  passa a exigir as duas condições.

- **RN13 — NÃO implementada, pendente de rediscussão (2026-09-09).** Ela pede que
  `fOutroAutcomDetemPinpad` e `fSessaoVivaComPendencia` isentem só a conexão atual, com o objetivo
  de que *"o re-login do próprio AUTCOM não confirme a pendência que ele mesmo deixou"*. Duas
  objeções: hoje ela é **inócua** (`FdictSessoes` é indexado por PID, `fGaranteSessao` reata por
  identidade e PID reusado orfana a sessão anterior — não existem duas conexões concorrentes do
  mesmo PID), e pela letra ela **colide com o caso 1**, onde o AUTCOM volta com o mesmo processo e
  confirmar a própria pendência é o desfecho exigido — validado em campo em 15:51.

- **PASSO 6 ENCERRADO em 2026-09-10.** Quatro baterias de campo (07:23, 07:41, 08:36 e a do
  `CFG_TEFDVC = N`). Cinco dos oito casos do roteiro validados, mais o single-flight nos dois
  sentidos. **Os três casos da pergunta ao operador não foram validados e, por decisão do Rafael,
  não serão simulados** — exigem um AUTCOM travado de verdade (processo vivo, janela que não
  responde). O `pSetConfirmaTomadaPinpadTef` e o `VS_funcConfirmaTomadaPinpadTef` seguem com **zero
  execuções**; o log desse caminho foi reforçado em três pontos para que a produção faça o papel do
  teste. Isto está dito aqui para que ninguém leia "Passo 6 encerrado" como "Passo 6 inteiramente
  provado".

  **Incógnita registrada como incógnita:** a reaplicação do login chama
  `FechaSessaoTEF(SCO_CONFIRMA_TEF, forçado)` e, pela teoria da própria RF17 item 4, deveria ter
  resolvido a pendência do detentor morto. Não resolveu — ela ficou pendente no relatório, que por
  acaso é o desfecho desejado. Mecanismo não compreendido, código nativo fora de alcance.

- **RF28 — PRECISADA em 2026-09-10, na implementação (Passo 7).** O texto dizia para descartar a
  contagem de sessões e coletar "no caminho do login do AUTCOM novo, antes de tocar a DLL". Duas
  correções de mecanismo:

  **1. Como estava, seria um no-op.** A guarda que sobra depois de tirar `FdictSessoes.Count = 0`
  é `FdictSessaoPorThread.Count > 0 → Exit`, e o `pAtualizaContexto` registra a **própria** thread
  de despacho nesse dicionário antes de o método rodar. A thread do login se veria ocupada. A guarda
  passou a **ignorar a própria thread** e a coletar só órfãs que **nenhuma** thread referencia.

  **2. "No caminho do login" era largo demais.** Anular os ponteiros globais sem reconfigurar em
  seguida deixa os ~22 `fMetodo*` que não passam por `pGarantePinpadConfigurado` caindo neles — o
  mecanismo do AV de 09/09. A coleta ficou **colada imediatamente antes** do `fConfiguraTefCitel`,
  que chama `fLoadDLLFunctions` incondicionalmente (`untTefCitelNCR.pas:649`), nos dois pontos que
  configuram: `fMetodoFConfiguraTefCitel` (ramo **não** adiado) e a reaplicação de
  `pGarantePinpadConfigurado`. No ramo adiado **não** se coleta: existe detentor vivo e não vai
  haver reconfiguração.

  Decisão do Rafael em 2026-09-10, sobre o receio de a coleta cegar instância ativa. Descartadas:
  desalocar sem disparar o unload (a chamada está no destrutor de unit intocável, guardada por campo
  privado sem setter) e repovoar do roteador (os globais moram **dentro** da `libTefCitel.dll`; o
  `.exe` teria uma segunda cópia).

- **RF29 — metade JÁ ERA LETRA MORTA, precisado em 2026-09-10.** *"Falha a chamada pendente com
  esse motivo"* não tem sujeito: desde que a RF25 parte 2 saiu de escopo (09/09), as chamadas
  pendentes estouram com `ErroCanal` na queda, muito antes de o `reata` chegar. O que ficou é
  refazer o TEF e apontar o relatório — e o momento mudou: **o re-login acontece na próxima
  chamada, não no `reata`**, porque no `reata` pode não haver observer registrado e o aviso iria
  para `0 observer(es)`. Os argumentos do login passaram a ser guardados no `TTefCitelDvc`, o que
  evitou um segundo export novo na DLL.

- **RF29 — LACUNA DE GATILHO, achada em 2026-09-10.** O gatilho escolhido (a resposta do `reata`)
  só existe quando o **canal DVC** cai. Mas o plugin **reconecta o socket sozinho e nunca toca no
  canal** (`pLoopConectorELeitura`, `untTefCitelDvcPluginImpl.pas:375`), então **um reinício puro do
  serviço não é detectado**: o AUTCOM não manda `reata` e a instância não é comparada. O re-login
  automático só ocorre se houver oscilação de TS **depois** do reinício — que é o que o roteiro de
  teste precisou forçar.

  **Não é silencioso:** a instância nova tem `FstrConfigAplicada = ''`, então a primeira chamada cai
  no ramo de `pGarantePinpadConfigurado` que levanta erro com mensagem acionável (*"Saia e entre
  novamente na rotina de TEF do AUTCOM para refazer o login"*) — exatamente o que o comentário
  daquele ramo já antecipava que a RF29 viria automatizar. Duas saídas propostas (mover o gatilho
  para o caminho da chamada normal, ou o plugin fechar o canal ao reconectar o socket), **decisão
  pendente do Rafael**, registrada no `PONTO DE PARADA` do `tasks.md`.

### 10.6 Premissas

- **P1 (Rafael, 2026-09-09) — destruir a instância do AUTCOM travado antes do login do AUTCOM novo
  impede que esse login confirme a pendência alheia.** Afirmada pelo Rafael com certeza; é
  comportamento do Scope, não verificável no código deste repositório. Registrada como premissa e
  não como fato de código, pelo mesmo critério com que as outras premissas de terceiro estão
  registradas aqui — e porque quatro premissas sobre código de terceiro já caíram neste requisito. A
  evidência de campo de 2026-09-08 mostra o login do AUTCOM B confirmando a transação do A **com a
  sessão do A ainda aberta** (`INI_SESSAO` já setado, `untScopeNCR.pas:1025`); com a instância do A
  destruída antes, o `AbreSCOPE` do B roda do zero.
- **P2 — o `autcom.exe` sobrevive à oscilação com o mesmo PID.** Disconnect não é logoff; o TSPlus
  mantém a sessão desconectada (premissa 9.1 fala em ~100 min).

### 10.7 Premissa a validar em campo antes do código (spike)

**Depois de uma reconexão de sessão TSPlus, o processo do servidor consegue reabrir o canal com
`WTSVirtualChannelOpen` e trafegar?** Metade já está provada pelo código atual — o lado cliente
recebe um `OnNewChannelConnection` novo a cada reconexão. Falta o lado servidor.

Sonda mais barata: um app de console no servidor que abre o canal, lê em laço e reabre em caso de
erro real, logando cada tentativa; desconectar a sessão, reconectar, verificar se a abertura seguinte
vale e se um round-trip completa. **Não** precisa de `autcom.exe`, nem de pinpad, nem de transação.

Critério de sucesso: após a reconexão, `WTSVirtualChannelOpen` devolve handle válido e um round-trip
completa.

**Plano B se falhar:** a abordagem escolhida (recuperação dentro da chamada original) cai inteira, e
o desenho volta para a alternativa descartada em 10.8 — a estação empurra e o AUTCOM completa fora da
chamada, com todo o custo de idempotência que isso traz. Explicitado aqui para que a spec não seja
escrita sobre a quinta premissa não verificada.

### 10.8 Alternativas descartadas

- **A estação empurra e o AUTCOM completa fora da chamada.** O `fChamaRpc` falharia como hoje, mas
  gravando "indeterminada" em vez de CANCELADA; na volta do canal o resultado chegaria como evento
  assíncrono e o AUTCOM completaria a gravação fora do fluxo da venda. Descartada porque a venda já
  foi abandonada e gravar por fora cria um **segundo caminho de gravação**, que é onde nascem
  duplicidade e venda registrada sem o operador saber — o oposto do que a RN03 pede. Fica como plano
  B do spike (10.7).
- **Pull por chave de negócio.** No login o AUTCOM perguntaria à estação o desfecho das transações
  que deixou `TRANSACAO_INICIADA` no TEFTRA. Cobriria até AUTCOM morto, mas exige histórico
  consultável na estação e está fora do envelope escolhido (Rafael, 2026-09-09: cobrir a oscilação
  de TS, não a morte do processo nem o reboot da estação).
- **Ping-pong periódico sobre o canal DVC.** Descartado por dois motivos: não responde nada na
  janela que interessa (durante a oscilação o canal está caído, e o ping falha igual para AUTCOM
  morto e para AUTCOM vivo esperando); e `WTSVirtualChannelWrite` aborta o `WTSVirtualChannelRead`
  pendente — causa raiz do quadro perdido de 2026-09-04 — então um ping periódico tornaria essa
  exposição permanente, inclusive durante transação. O que ficou da ideia é a sonda **sob demanda**
  (RF27).
- **Prazo de desanexação.** Era o instrumento errado (intuição do Rafael, 2026-09-09): a pergunta
  certa não é "quanto tempo esperar" e sim "o processo ainda existe / ainda responde". Substituído por
  identidade + sonda.
- **`LCK_CON_ID` da LCKATC como sinal de vivacidade.** O campo é o `CONNECTION_ID()` do MySQL
  (`fGetConnectionID`), então a morte do processo derruba a conexão e o id desaparece do process
  list — o banco já mantém o heartbeat de graça. Descartado porque `OpenProcess` no mesmo servidor é
  mais direto e não depende do banco; e porque a chave da LCKATC depende de `TIPTER`
  (`fRetornaChaveLockTefCitel`, `untTefCitelUtil.pas:447`): em `TIPTER = 3` a chave inclui
  `VS_strCodEmp`, então dois AUTCOM de empresas diferentes usam chaves **diferentes** e a trava não
  serializa — que é justamente o cenário da premissa 9.1 e o motivo de a RF19 existir.
- **O AUTCOM derrubar o processo do AUTCOM zumbi (`TerminateProcess`).** Recusado pelo Rafael em
  2026-09-09: não se pode depender de um processo derrubar outro. Substituído pela sonda + confirmação
  humana (RN15, RN16), que tira o pinpad do travado sem tocar no processo dele — exatamente como o
  operador já faz hoje removendo a trava.
- **Resolver o abort de escrita 996 (thread única dona do handle) junto.** Deliberadamente fora: são
  dois problemas, e misturar impediria a validação de campo de isolar qual mudança causou o quê. O
  laço de reconexão da RF25 é o lugar natural para isso depois.

### 10.9 Critérios de aceitação

- [ ] **Spike da reabertura do canal aprovado** (10.7) — pré-requisito, não caso de teste
- [ ] Oscilação de TS durante `fPassarCartao`: venda registrada normalmente, transação confirmada,
      **sem pendência e sem mensagem ao operador**
- [ ] Oscilação com A em voo e B de outra empresa: B recusado durante toda a oscilação; A recupera e
      conclui
- [ ] A travado + B pedindo o pinpad: `IsHungAppWindow` muda, operador confirma, B assume, **A não é
      morto** e a transação de A fica pendente. **NÃO VALIDADO, e por decisão não será simulado**
      (Rafael, 2026-09-10): exige um AUTCOM travado de verdade. Implementado e com o log reforçado
      para que a produção faça o papel do teste; o `pSetConfirmaTomadaPinpadTef` segue com zero
      execuções
- [x] A saudável em transação + B pedindo: o requisitante consulta a janela, B recusado — **VALIDADO
      2026-09-10 07:25 e 08:43** (nos dois sentidos). A variante **"nem removendo a LCKATC o B
      consegue"** não foi exercitada
- [x] A morto pelo gerenciador de tarefas: B assume **sem** confirmação do operador — **VALIDADO
      2026-09-10 07:44** (`pid=98392 ja TERMINOU (codigo de saida 99)`), com orfanamento,
      reaplicação do login adiado, venda do B concluída, e a transação do A **pendente** no
      relatório do TEF
- [x] Serviço reiniciado: fila varrida com log, `reata` informa instância nova, AUTCOM refaz o TEF e
      aponta o operador ao relatório de pendências — **VALIDADO em 2026-09-10 14:57–14:59**:
      `pVarreFilaNaSubida: 1 item(ns) ... 1 descartado(s)`, depois `SERVICO REINICIOU`, re-login com
      retorno 0, aviso ao operador e a venda concluída (`Controle 09005273015`). A parte "falha a
      chamada pendente" saiu por não ter sujeito — ver a revisão da RF29 em §10.5
- [ ] "Cancelar espera" pelo operador: chamada falha localmente e a transação vira pendência na
      estação
- [ ] Falso positivo do modal: A saudável com `fMensagem` modal à frente da fila — operador **não**
      confirma e A segue intacto. **NÃO VALIDADO**, mesmo motivo do caso do travado. O log traz uma
      linha antes de perguntar ao operador que existe justamente para este caso, quando nenhuma
      linha vem depois dela
- [ ] Re-login do próprio AUTCOM após oscilação **não** confirma a própria pendência. **RN13 NÃO
      IMPLEMENTADA — pendente de rediscussão:** pela letra, colide com o caso da oscilação, onde
      confirmar a própria pendência é o desfecho exigido
- [ ] TEFTRA deixa de registrar `TRANSACAO_CANCELADA` em transação aprovada
- [x] `CFG_TEFDVC = N`: regressão zero — **VALIDADO 2026-09-10**. Exercita a blindagem do import
      novo, que é registrada incondicionalmente

### 10.10 Fora de escopo desta fase

- Recuperação quando o `autcom.exe` morre (logoff, travamento, gerenciador) — continua RN09
- Recuperação quando o serviço da estação ou a estação reiniciam **com transação em voo** — a
  transação morre com o processo; RF29 trata o aviso, não a recuperação
- Correlação por chave de negócio (TEFTRA) e histórico consultável na estação
- `TerminateProcess` em AUTCOM alheio, sob qualquer forma
- Thread única dona do handle / abort de escrita 996
- Acesso a banco pelo serviço da estação
### 10.11 Passo 8 — log operável, instrumentação e retenção de sessão (2026-09-10)

O Passo 8 nasceu como *"consolidar o log (RF22)"* e recebeu, ao longo da validação do Passo 7,
três itens que o campo produziu. As três decisões de rumo são do Rafael, em 2026-09-10.

**Estado: implementado, sem nenhuma validação em campo.** Roteiro de validação no `tasks.md`.

#### RF22 — o log passa a ser operável

Os três processos (autcom, serviço da estação, plugin do cliente RDP) têm log próprio, e nenhum
dos três tinha **rotação, limite de tamanho ou chave de desligar**. O do autcom registra por
quadro: ~100 linhas por transação de cartão, da ordem de 3 MB/dia numa estação movimentada, em
`%TEMP%` — candidato à Limpeza de Disco, que pode apagar justamente a evidência que se quer
guardar. O do plugin tinha ainda a falta de identificação que o do autcom tinha antes de 10/09:
**um arquivo para os dois canais DVC da sessão, sem pid nem id de canal**.

- **Nível por linha:** `0` desligado, `1` normal, `2` diagnóstico. Uma linha é gravada quando o
  nível dela é menor ou igual ao configurado. Toda chamada de log que existia antes continua em
  `1`, **menos as que registram por quadro ou por leitura** — essas foram para `2`, e são elas
  que produziam o volume.
- **Configuração:** `TefCitelDvcLog.ini`, seção `[Log]`, ao lado de **cada** binário. Chaves
  `Nivel`, `TamanhoMaxMB` (default 10), `Arquivos` (default 3, contando o atual) e `Pasta`
  (vazio = padrão do processo). **Criado com os defaults e um comentário por chave se não
  existir**, com `CREATE_NEW`, para o suporte encontrar o arquivo pronto em vez de ter que saber
  inventar o nome. Na estação o serviço e o plugin compartilham o arquivo, porque o pacote de
  instalação é uma pasta única e flat.
- **Lido uma vez por processo** e mantido em cache: alterar exige reiniciar o processo. Ler o
  `.ini` a cada linha poria uma abertura de arquivo extra no caminho de toda chamada TEF, e este
  subsistema já teve corrupção de heap por chamada concorrente intensa de log ("Bug 6").
- **Rotação** por tamanho: `.log` → `.1.log` → `.2.log`, descartando o mais antigo. Teto de
  `TamanhoMaxMB × Arquivos` por pasta de log. O tamanho é conferido a cada 64 linhas (excedente
  máximo de ~13 KB sobre o limite) e pelo caminho, não pelo handle — o handle do log é aberto só
  com `FILE_APPEND_DATA` e `GetFileSize` exige direito de leitura.
- **A rotação é best effort, e isso é deliberado.** A seção crítica serializa as threads de um
  processo, não processos diferentes — e os **dois** autcom.exe de uma sessão TS gravam no mesmo
  arquivo (é por isso que existe o `pid=` no prefixo). Uma renomeação que falhe deixa o arquivo
  passar do teto por algumas linhas; nenhum caso perde linha gravada nem corrompe arquivo, o que
  não justificaria um mutex nomeado entre processos.
- **Onde cada log grava.** Serviço: ao lado do `.exe` (roda como LocalSystem, cujo `%TEMP%` não é
  encontrável de fora — medido em campo em 2026-08-24). Plugin: **saiu de `%TEMP%`** para a pasta
  de instalação, ao lado do log do serviço, com volta automática para `%TEMP%` se ela não for
  gravável. Autcom: **continua em `%TEMP%`**, porque ali o log separa por usuário/sessão e num
  servidor TS isso é desejado — juntar todas as sessões num arquivo só seria pior. Quem quiser
  tirar de `%TEMP%` usa a chave `Pasta`.
- **Identificação:** o log do plugin passa a carregar `[pid=N canal=N]`, com id sequencial de
  canal por processo.
- **Fora da letra da RF22, autorizado pelo Rafael:** o plugin e o serviço ainda montavam o
  carimbo de tempo com `FormatDateTime` e **nenhum dos dois tinha seção crítica**. O lado autcom
  abandonou `FormatDateTime` em 2026-08-28 depois de dois `EAccessViolation` em campo, ambos
  dentro de `FormatDateTime`/`DateTimeToString` e ambos lendo o mesmo endereço fixo — locale
  global da RTL não thread-safe nesta versão do Delphi. Os dois processos também são multithread.
  Os três agora montam o carimbo por `GetLocalTime` e serializam.

> **O núcleo do log está triplicado de propósito**, uma cópia por projeto, pela mesma razão já
> aceita para o `fCrc32`: os três `.dproj` têm search path diferente e não compartilham unit.
> Vale a mesma regra — **mudança num precisa ser replicada nos três na mesma sessão**, senão eles
> passam a se comportar diferente com o mesmo `.ini`. No lado estação as duas funções de log do
> projeto (roteador e transporte TCP) passaram a dividir um núcleo único, em
> `libTefCitel\Estacao\untTefEstacaoLog.pas`: elas gravam no **mesmo arquivo** e antes não
> tinham lock nenhum entre si.

#### A margem do ACK: o que está medido, e o que NÃO está

**Observado até 1,03× do orçamento, em amostra de três reconexões** (10/09, 14:53–15:00: 9,0 /
9,1 / 9,7 s contra um orçamento de 5 × 2 s ≈ 10 s, consumindo 4 das 5 retransmissões). A frase
é essa, e não *"a margem é de 1,03×"*: **esta margem foi declarada errada três vezes neste
requisito** — 2× (09/09, amostra de 5 s), 1,5× (10/09 10:45, amostra de 6,5 s) e 1,03× — sempre
por generalizar amostra pequena. Sem causa conhecida, o número é observação, não propriedade.

O que está explicado: a perda do **primeiro** quadro (colisão com a expiração da leitura —
escrito `.930`, leitura expirou `.960`). O que **não** está: o atraso das retransmissões. As
cópias sempre chegam **juntas, em 2 ms** — não é latência por quadro, é a leitura que fica
retida.

**Decisão do Rafael: instrumentar antes de mexer.** O orçamento de retransmissão **não foi
alterado** — sem causa conhecida, escolher um número novo é repetir o método que já errou três
vezes. Em `Nivel=2` o log passa a permitir cruzar: duração de **cada** leitura do canal e
**quantas escritas nossas** ocorreram durante ela; ms decorridos desde a 1ª escrita do quadro em
cada retransmissão; ms totais e escritas no intervalo quando o ACK chega.

**A hipótese a confirmar ou refutar** já estava num comentário de `pLoopLeitura` desde
2026-09-04: leitura e escrita compartilham o estado overlapped do **mesmo** handle, e toda
escrita aborta a leitura em curso com `ERROR_IO_INCOMPLETE` (996) — bateu 13 de 13 vezes naquele
log. Se isso vale durante a espera do ACK, **cada retransmissão de 2 em 2 s aborta a leitura que
traria o próprio ACK**, e o quadro só é lido quando as escritas param: explicaria tanto o atraso
proporcional ao número de tentativas quanto as cópias chegando juntas. **Se confirmar, o
conserto não é aumentar o orçamento** — é a thread única dona do handle (leitura com timeout
curto e fila FIFO de escrita drenada no mesmo laço, como o `pLoopEscritaWorker` do plugin já
faz), que segue como decisão pendente.

#### Retenção de sessão desanexada — revisão da RF24 e da RF28

**O fato medido:** 11 sessões no dicionário com **um** autcom ativo (10/09, 14:53). Sessão de
autcom que fecha **normalmente** nunca sai do `FdictSessoes`: a RF24 a deixa `DESANEXADA`
esperando o mesmo processo voltar, e a RF28 coleta **órfãs**, não desanexadas. Só volta a 1 quando
o serviço reinicia.

**Não é defeito de correção**, e isso foi conferido no código, não estimado: o `fGaranteSessao`
valida o par (pid, `inicioProcesso`) e orfana a sessão velha quando o Windows recicla o número
(RF23) — nenhum autcom herda loja/terminal de outro. É crescimento de memória não limitado no
pior caso.

**Decisão do Rafael: coletar por idade.** Passado `TEF_ESTACAO_DESANEXADA_MAX_MS` sem o processo
voltar, a sessão vai para o caminho de orfanamento de sempre e passa a ser coletada pela RF28. O
prazo é de **30 minutos**, escolha por **ordem de grandeza** e não por medição: uma oscilação de
TS foi medida em 47–53 s do início da queda ao `reata` completo, duas ordens de grandeza abaixo,
e um operador que fecha e reabre em menos de meia hora ganha o reatamento de graça — que é o
propósito da RF24. Errar para o lado do prazo maior não custa nada além de memória.

**Não é timeout sobre chamada de pinpad** e não viola a regra do topo de `IA\rules\tef-dvc.md`:
é prazo de retenção de um objeto de sessão, sem transação em curso por definição — desanexada
significa sem conexão.

> **A segunda metade desta mudança merece leitura atenta, e é o único ponto do Passo 8 que mexe em
> guarda validada.** A guarda do caminho ocioso do `fColetaOrfas` era `FdictSessoes.Count > 0` e
> passou a contar sessões **ANEXADAS**. Sem isso o resto não resolveria nada: **uma** desanexada
> no dicionário já fazia `Count > 0` e bloqueava a coleta inteira — era isso que mantinha as 11
> sessões de pé. Por que continua seguro: o método só destrói o que está em `FlstOrfas`, e
> desanexada **fresca** não está lá (quem a põe é a coleta por idade, e só depois do prazo);
> sessão sem `FConexaoAtual` não pode estar despachando, porque despacho roda na thread de uma
> conexão; e a guarda que protege de verdade (`LlstEmUso`/`LintOutrasThreads`, RN08) está intacta.
> **O conjunto do que pode ser destruído não mudou — mudou quando o caminho ocioso desiste.**
> `FdictSessoes.Count` deixou de significar *"alguém ativo"* no dia em que a RF24 passou a deixar
> sessão desanexada no dicionário: a guarda não mudou, o significado do que ela media mudou
> debaixo dela. É a terceira guarda do mesmo método a cair por esse motivo neste requisito.

#### RF29 — segundo detector, no caminho da chamada normal

**A lacuna, achada em 10/09 ao montar o roteiro do teste de re-login:** o plugin reconecta o
socket sozinho (`pLoopConectorELeitura`) e **nunca toca no canal DVC**. Num reinício **puro** do
serviço o canal não cai, o `fReconectaCanal` do autcom não dispara, **nenhum `reata` é enviado**
e a troca de instância nunca é comparada. O gatilho que a RF29 escolheu — a resposta do `reata`
— só existe quando o **canal** cai, isto é, numa oscilação de TS.

**Não é silencioso hoje:** a primeira chamada cai no ramo de `pGarantePinpadConfigurado` que
levanta erro com mensagem acionável (*"Saia e entre novamente na rotina de TEF do AUTCOM para
refazer o login"*).

**Decisão do Rafael: mover o gatilho para o caminho da chamada normal.** A alternativa avaliada
(o plugin fechar o canal DVC ao reconectar o socket) custaria os **47–53 s de reatamento** a cada
reinício de serviço.

- A estação marca essa recusa específica com `motivo="loginNecessario"` no envelope de resposta
  — mesmo mecanismo já estabelecido para a recusa contestável — por meio de uma classe própria
  (`ETefEstacaoLoginNecessario`), para o autcom **reconhecer sem comparar texto de mensagem**.
- O `fChamaRpc` do autcom captura, refaz o login e **repete a chamada uma vez**. Se a repetição
  voltar igual, a exceção sobe com a mensagem acionável e o operador refaz — o comportamento de
  antes, preservado.
- O re-login **reusa o `pRefazTefSeServicoReiniciou`**, ligando a mesma flag que a resposta do
  `reata` liga: são **dois detectores para o mesmo desfecho, não duas implementações**. Todas as
  guardas daquele método valem — a própria chamada de login não se reaplica, não há
  reentrância, sem argumentos guardados ele só registra e sai, e um re-login que falhe não
  derruba a chamada real.
- **Compatível nos dois sentidos:** o campo `motivo` só vai quando existe, então serviço antigo
  com DLL nova, e DLL antiga com serviço novo, se comportam como antes.


---

## 11. Fase 6 — Atualização de arquivos na estação (2026-09-15)

Fecha o RF10/RF11/RN04, que nasceram na seção 3 e ficaram explicitamente adiados
("ainda **não desenhada** — fica pra sessão futura", `record.md`). O escopo cresceu:
não é só DLL de terceiro, são **três famílias de arquivo**.

### 11.1 Requisitos funcionais

- **RF30** — Com `CFG_TEFDVC = 'S'`, na carga do AUTCOM, atualizar as DLLs do Scope e do
  CliSiTef na estação a partir de `tef_scope.zip` e `tef_clisitef.zip`, quando existirem no
  diretório do `autcom.exe`. O conteúdo do `.zip` é extraído no diretório onde o
  `TefEstacaoService.exe` está instalado.
- **RF31** — Mesmo gatilho e mesmo destino para `TefEstacaoService.zip`: atualização do
  próprio serviço da estação. O `.zip` é um envelope genérico — sempre traz o `.exe`, e pode
  trazer qualquer arquivo dependente novo. A rotina extrai o que vier, sem lista fixa.
- **RF32** — Mesmo gatilho para `scope.ini`, `CliSiTef.ini` e `CONFITLS.ini`, de modo que
  alteração feita pela equipe de suporte se reflita na estação. Cobre também o **bootstrap**:
  no primeiro uso com `CFG_TEFDVC = 'S'` a estação ainda não tem esses arquivos.
- **RF33** — Origem dos `.ini`:
  - `CFG_TEFCIT = 'T'` → `scope.ini`, sempre do diretório do `autcom.exe`.
  - `CFG_TEFCIT = 'S'` → `CliSiTef.ini` e `CONFITLS.ini`, pela cascata do
    `fDiretorioPorTerminal`: `CFG_PTTFCT` em branco → diretório do `autcom.exe`;
    `CFG_PTTFCT` preenchida → `<CFG_PTTFCT>\<TFC_NUMTER>\`; subpasta ou arquivo
    inexistente → cai para o diretório do `autcom.exe`, registrando em log de onde veio.
- **RF34** — Ao gravar os `.ini` na estação, reescrever as chaves de caminho para o diretório
  onde o `TefEstacaoService.exe` está instalado:

  | Arquivo | Seção | Chave |
  |---|---|---|
  | `scope.ini` | `[SCOPEAPI]` | `ArqControlPath`, `ArqTracePath` |
  | `CliSiTef.ini` | `[CliSiTef]` | `DiretorioTrace` |
  | `CliSiTef.ini` | `[SalvaEstado]` | `DiretorioBase` |
  | `CONFITLS.ini` | — | nenhuma; cópia pura |

- **RF35** — Controle por hash SHA-256 por pacote: transferir e aplicar **somente** quando o
  arquivo de origem tiver mudado.
- **RF36** — A atualização roda na carga do `autcom.exe`, dentro de `pIniciaTefCitel`, **antes**
  do login (`fConfiguraTefCitel`), com tela de progresso. Vir antes do login é requisito, não
  detalhe: estação com DLL quebrada precisa poder ser consertada pela própria atualização.
- **RF37** — A aplicação exige estação **ociosa** e nunca interrompe transação em voo nem
  transação pendente de confirmação, inclusive com mais de um AUTCOM aberto na mesma estação.
- **RF38** — Atualização só em cópia de produção: se o caminho do `autcom.exe` contiver o
  fragmento `HOM` (sem diferenciar maiúscula de minúscula), nada é atualizado.

### 11.2 Regras de negócio

- **RN17** — A verdade sobre o que está instalado é a **estação**, não o banco nem o servidor.
  Os hashes aplicados vivem num arquivo de versão ao lado do `TefEstacaoService.exe`. Estação
  reinstalada, HD trocado ou pasta apagada volta a divergir sozinha e se reinstala.
- **RN18** — O hash guardado é o do arquivo **de origem**, antes do ajuste de caminho. Hash do
  resultado obrigaria o AUTCOM a reproduzir o ajuste só para decidir se precisa enviar.
- **RN19** — O arquivo de versão guarda também o diretório do serviço no momento da aplicação.
  Se ele divergir, os três `.ini` são reescritos **mesmo com hash igual** — serviço reinstalado
  em outra pasta mantém o hash e perde o caminho.
- **RN20** — Transferir e aplicar são etapas separadas. A transferência para a área de preparo
  não toca nenhum arquivo em uso e acontece **sempre** que o hash divergir, independente de a
  estação estar ocupada. Só a troca de arquivos e o reinício exigem ociosidade.
- **RN21** — Ociosidade são três condições, todas já existentes e já exercitadas em campo:
  `FdictConexaoPorThread.Count = 0` (despacho dentro da DLL nativa),
  `fSessaoVivaComPendencia = nil` (pendente de confirmação) e
  `fOutroAutcomDetemPinpad = False` (posse do pinpad entre chamadas).
- **RN22** — A aplicação acontece na **subida** do serviço, nunca com ele de pé. Na subida
  nenhuma DLL do Scope/CliSiTef foi carregada — `libTefCitel.dll` entra por `delayed` e as
  nativas só no login — então não há arquivo travado e não há nada a descarregar. Aplicar com
  o serviço rodando exigiria `UnLoadDLLFunctions`, assinatura de três AVs desta migração.
- **RN23** — A atualização **nunca** derruba o AUTCOM, nunca impede a carga e nunca desabilita
  o TEF por conta própria. A única exceção é o serviço não voltar depois do reinício, caso em
  que o TEF não funcionaria de todo modo.
- **RN24** — Um `.ini` é reescrito **textualmente, linha a linha**, nunca por `TIniFile`.
  `TMemIniFile.UpdateFile` descarta comentário e reordena seção, e o `CliSiTef.ini` real tem
  comentários escritos pelo suporte.
- **RN25** — Todo arquivo viaja como base64 do **binário**, inclusive os `.ini`. São
  Windows-1252 com acentuação e o transporte é JSON em UTF-8; mandar como texto convidaria
  transcodificação no caminho. Mesmo caminho já usado pelo PNG do QR.
- **RN26** — O teto de 60 s de espera pelo serviço voltar **não viola** a regra do topo do
  `IA\rules\tef-dvc.md`. Não há pinpad envolvido: a ociosidade foi condição para chegar ali, e
  o que se espera é o SCM subir um processo. Mesma natureza do teto de 10 s do
  `pParaComSeguranca`.

### 11.3 Critérios de aceitação

1. Nada mudou → nenhuma tela, nenhuma transferência, carga no tempo de sempre.
2. Só `.ini` mudou → transferido, caminhos ajustados e **comentários preservados** no arquivo
   gravado na estação.
3. `tef_scope.zip` novo → DLLs trocadas na subida do serviço; login funciona depois.
4. `TefEstacaoService.zip` novo → `.exe` trocado; o `.old` é apagado na subida seguinte.
5. Dois AUTCOM subindo ao mesmo tempo → só um transfere; o segundo enxerga o pacote já
   preparado pelo hash e não reenvia nada.
6. Segundo AUTCOM sobe no meio de uma transação do primeiro → aplicação recusada, carga segue
   normal, transação não é interrompida.
7. Transação pendente de confirmação na estação → aplicação recusada; o pendente segue pendente.
8. Caminho do `autcom.exe` contendo `HOM` → nada acontece, e o log registra o motivo.
9. `.zip` corrompido → recusado na conferência de hash; nada aplicado; estação segue funcionando.
10. `.exe` novo que não sobe → relançador restaura o `.old` e o serviço volta na versão anterior.
11. Serviço movido de pasta → os três `.ini` são reescritos mesmo com hash igual.
12. `CFG_PTTFCT` preenchida, exercitando subpasta do terminal existente e inexistente.
13. Primeiro uso com `CFG_TEFDVC = 'S'` → bootstrap dos três `.ini` na estação.

### 11.4 Fora de escopo desta fase

- `TefCitelDvcPlugin.dll` — carregado dentro do `mstsc.exe` da estação enquanto a sessão RDP
  existir, portanto travado. Continua sendo atualizado pelo instalador/suporte.
- Instalação inicial da estação (serviço, registro do plugin, primeira carga das DLLs do TEF):
  é o instalador, não esta rotina.

### 11.5 Revisão de 2026-09-15 — quem aplica é um executável à parte

Durante a implementação do Passo 3, um binário de verificação contendo a combinação "trocar
executável + extrair `.zip` sobre diretório de programa + parar/subir serviço" foi **bloqueado
pelo antivírus da máquina de desenvolvimento**. Decisão do Rafael no mesmo dia: extrair esse
comportamento para um executável separado.

- **RN27** — Quem **aplica** a atualização é o `TefEstacaoAtualizador.exe`, nunca o
  `TefEstacaoService.exe`. O serviço faz apenas a metade benigna: recebe pelo canal, confere o
  SHA-256, guarda em `_Preparo\` e decide a ociosidade. **Why:** o modo de falha. Antivírus que
  barre o serviço deixa a loja **sem TEF** — ele é processo vital; antivírus que barre o
  atualizador só interrompe a atualização, e o TEF continua funcionando. Efeito colateral
  desejado: o binário do serviço volta a ter o mesmo perfil de comportamento que já passou por
  todas as baterias de campo.
- **RN28** — O atualizador é lançado **pelo serviço**, como processo destacado, e só depois de o
  serviço ter decidido que a estação está ociosa (RN21). A decisão de segurança não sai de onde
  está — o atualizador chega depois dela, e nunca a reavalia.
- **RN29** — Com o serviço parado, **todos** os arquivos são trocados no mesmo lugar, inclusive o
  `TefEstacaoService.exe`. Cai o caso especial da RN22 em que o `.exe` era o único trocado antes
  do reinício: ele existia só porque executável em uso não pode ser sobrescrito, e com o serviço
  parado isso deixa de valer. A RN22 continua valendo no que importa — nada é aplicado com DLL
  nativa carregada.
- **RN30** — Cada um atualiza o outro. O `TefEstacaoAtualizador.exe` que vier dentro do
  `TefEstacaoService.zip` é **adiado** quando o atualizador está rodando (ele é o processo em
  uso) e aplicado na rodada seguinte, quando quem roda é o serviço.
- **RN31** — Atualizador ausente ou bloqueado **não** é falha do TEF: o serviço registra em log
  que a instalação está incompleta, o preparo continua onde está, e o TEF segue funcionando. Essa
  linha de log é obrigatória — sem ela o sintoma é apenas "a atualização não acontece", e o
  suporte procura no lugar errado.

**Critério de aceitação novo:**

14. Renomear o `TefEstacaoAtualizador.exe` para simular bloqueio → o serviço loga a instalação
    incompleta, nada é aplicado e o TEF continua operando normalmente.

**Recomendação que está fora do código:** a solução de raiz para heurística de antivírus é
**assinar digitalmente** os binários da estação. Vale levar para quem cuida do pacote de
instalação.

### 11.6 Revisão de 2026-09-15 — só estação configurada para TEF

Observação do Rafael ao revisar o Passo 4, que corrigiu um defeito antes de ele existir: o TEF
não carrega na abertura do processo. Ele carrega **depois do login do operador**, na
inicialização do `TfrmPrincipal`, e só quando `CFG_TEFCIT` está em `'T'`/`'S'` e o terminal tem
linha na tabela de terminal.

```
TfrmPrincipal (já depois do login do operador)
  └─ pVerificaTEFCitel              ← só If (VS_blnTefCitel), de CFG_TEFCIT
       └─ fChamaTelaGravando(fIniciarTefCitel, ...)
            └─ pIniciaTefCitel
                 ├─ pCarregaDadosTerminalPorTipTer(qryTefTra)
                 ├─ fCriarTefCitel
                 └─ if not qryTefTra.IsEmpty then fConfiguraTefCitel
```

- **RN32** — A atualização só acontece em estação **configurada para TEF**. Isso tem duas
  barreiras, de propósito: a chamada fica **dentro do `if not qryTefTra.IsEmpty`** do
  `pIniciaTefCitel` — só ali se sabe que este terminal tem TEF — e a DLL recusa por conta própria
  quando `CFG_TEFCIT` não é `'T'` nem `'S'`, pelo mesmo raciocínio do RF38. **Why:** fora dessa
  guarda o objeto TEF existe mas o terminal não usa TEF, e falar com a estação ali custaria até
  30 s em **todo login** de um terminal que nem tem pinpad.
- **RN33** — A rotina continua vindo **antes do login do TEF** (`fConfiguraTefCitel`), que é o
  que permite consertar estação com DLL quebrada pela própria atualização. Consequência aceita
  (decisão do Rafael): com o serviço da estação parado, a carga espera até 30 s na consulta e
  mais 30 s no login. É o caso em que o operador já vai acionar o suporte de qualquer forma.
- **RN34** — A tela de progresso é a que **já existe**: `fIniciarTefCitel` recebe um
  `TcxProgressBar` e a rotina inteira já roda dentro de `fChamaTelaGravando`. Não abrir
  `TfrmGravando` próprio — seria uma segunda janela modal por cima da tela de carga.

**Também vale saber:** como o `objTefCitel` é anulado no logoff, a verificação re-roda a **cada
login de operador**, não uma vez por boot. Quando nada diverge o custo é uma ida de RPC (~95 ms).

## 12. Fase 6.1 — Canal DVC dedicado à atualização (2026-09-16)

Nasce de uma medição de campo: o pacote de 9,7 MB leva **154 s** para chegar à estação, tempo que
o operador espera parado na tela de carga. Inviável para produção.

**O diagnóstico, que descarta o ajuste óbvio.** O payload vai em base64 (~13 MB) fragmentado em
1400 bytes, com envio **sequencial ACK-gated**: ~9.300 idas e voltas × ~16 ms ≈ 150 s. É limitado
por latência, e o caminho de envio não tem desperdício. Aumentar
`TEF_DVC_TAMANHO_MAX_FRAGMENTO` não serve: ele não é valor de tuning, é o conserto de 2026-08-31,
e o teto físico de um chunk é ~1604 bytes — ganho máximo ~14%, ao custo de mexer numa constante
compartilhada com o caminho da transação.

**O que a PoC `DVC_v2` mostrou** (`relatorio-teste-viabilidade-dvc.md`): matriz de 1 byte a 1 MiB,
baterias de 20, 1.000 e 10.000 repetições, **mais de 105.000 idas e voltas sem uma única
divergência**. O RTT é praticamente constante (~158 ms) de 1 byte até 100 KiB; 256 KiB = 175 ms;
1 MiB = 366 ms. **O custo é por mensagem, não por byte.**

**E o que ela mostrou sem querer, que é o que sustenta esta fase.** A PoC faz remontagem
multi-chunk e não falha nunca — o que parece contradizer o achado de 31/08. Não contradiz: a causa
registrada em `untTefCitelDvcTransporte.pas:301` é *"WTSVirtualChannelWrite abortando o
WTSVirtualChannelRead pendente"*. **A perda nunca foi do tamanho; é da concorrência.** A
fragmentação em 1400 é mitigação — com mensagem de um chunk só, a leitura abortada perde um quadro
pequeno que o ACK/retry recupera. A PoC é serializada e sozinha no canal, e por isso 1 MiB passa.

Daí o desenho: **um canal só para a atualização**, onde nada mais escreve.

### 12.1 Requisitos funcionais

- **RF39** — Canal DVC dedicado **`TefCitelUpd`**, servido por um plug-in próprio, `TefCitelDvcUpdate.dll`,
  registrado como AddIn adicional no cliente RDP pela mesma mecânica do `register-plugin.ps1`
  (chave em `HKCU:\Software\Microsoft\Terminal Server Client\Default\AddIns\<canal>`). O
  `TefCitelDvcPlugin.dll` **não é recompilado nem alterado**.
- **RF40** — Pelo canal novo trafega **somente o payload das partes do pacote**. O controle
  (`fAtuConsulta`, `pAtuAbre`, `fAtuFecha`, `fAtuAplica`) continua no `TefCitelCh`, sem alteração.
- **RF41** — O payload continua **em base64** (decisão do Rafael, 2026-09-16). O canal novo muda o
  tamanho da mensagem e o caminho, não a codificação.
- **RF42** — Envio em blocos de **256 KiB**, request/response serializado, uma resposta por bloco.
  O tamanho é constante nomeada, ajustável sem mexer no protocolo.
- **RF43** — A `TefCitelDvcUpdate.dll` **não escreve em disco**: repassa cada bloco para uma
  segunda porta local do `TefEstacaoService` (constante nomeada, ao lado da 47991 atual), com
  enquadramento trivial (tamanho + bytes). O
  serviço grava em `_Preparo` pelo mesmo `FAtualizacao.pParte` de hoje e **continua sendo o único
  dono da pasta**.
- **RF44** — Ao chegar o pacote **completo** no destino, validar o **checksum** antes de promover
  o `.parcial` (decisão do Rafael, 2026-09-16). **Quem valida e promove continua sendo o
  `fAtuFecha`, no canal de controle, exatamente como hoje** — o caminho rápido entrega bytes e
  nada mais; ele nunca promove `.parcial` por conta própria. Não se inventa hash novo nem se
  duplica a conferência.
- **RF45** — **Fallback obrigatório**: canal indisponível por qualquer motivo — DLL ausente,
  antivírus, cliente RDP antigo, serviço sem a porta nova — cai no `pAtuParte` de hoje,
  registrando o motivo no log. Estação sem a DLL nova atualiza exatamente como hoje.
- **RF46** — A transferência **continua no mesmo ponto do fluxo**: síncrona, na carga do TEF,
  com a mesma tela de progresso. Esta fase não muda quando nem onde ela roda.

### 12.2 Regras de negócio

- **RN35** — O canal de volume é aberto **sob demanda** e fechado ao fim da transferência. Não
  fica aberto durante a operação normal da estação.
- **RN36** — **Não se replica CRC, ACK nem dedup** no canal novo. A resposta de cada bloco é a
  confirmação daquele bloco; a garantia ponta a ponta é o checksum do RF44. Transferência
  corrompida ou truncada descarta o `.parcial` e repete — repetir passou a custar ~9 s.
- **RN37** — O canal de volume **nunca** carrega método de transação. Se algum dia precisar, é
  outra decisão, com outra bateria.
- **RN38** — Falha no canal de volume **nunca** derruba a carga do TEF, pela mesma RN23: a
  atualização é um adicional na carga, nunca um motivo para ela falhar.

### 12.3 Critérios de aceitação

Entregável de quem implementa é esta lista; os casos são escritos pelo analista.

1. Pacote de ~9,7 MB transferido pelo canal novo em **menos de 20 s** (alvo ~9 s), contra os 154 s
   medidos em 2026-09-16.
2. `fAtuFecha` confere o mesmo sha256 que confere hoje, e o pacote aplica com **todos** os
   arquivos gravados.
3. Estação **sem** a `TefCitelDvcUpdate.dll` registrada: a atualização acontece pelo caminho de
   hoje, e o log diz por que caiu no fallback.
4. Serviço **sem** a porta de volume (versão anterior): mesmo fallback, mesmo registro.
5. Canal de volume derrubado no meio da transferência: o `.parcial` é descartado, a carga do TEF
   **não** falha (RN38), e a carga seguinte refaz a transferência.
6. Pacote corrompido em trânsito: barrado pelo checksum do RF44, não aplicado.
7. Uma transação de cartão completa normalmente **depois** de uma atualização pelo canal novo —
   verificando que o canal de transação não foi afetado.
8. Nenhuma linha nova de `quadro duplicado descartado`, `sem ACK` ou perda no `TefCitelCh` durante
   e depois da transferência.

### 12.4 Fora de escopo

- Tirar a transferência do caminho bloqueante do login (RF46 fixa que ela fica onde está).
- Granularidade por arquivo em vez do `.zip` monolítico.
- Usar o canal novo para qualquer coisa que não seja a atualização (RN37).
- Qualquer alteração em protocolo de quadro, ACK, dedup ou nas duas units de transporte atuais.

### 12.5 Dependências e riscos

- **Escrita num canal DVC abortando leitura pendente em OUTRO canal** — não está provado nem
  desmentido; a PoC roda sozinha. Mitigado por a transferência acontecer na carga do TEF, antes de
  o operador transacionar, e pelo checksum do RF44. **É o item que a primeira bateria tem que
  olhar** (critério 7 e 8).
- **Antivírus na DLL nova** — mesma preocupação que fez o atualizador virar executável à parte
  (decisão do Rafael, 2026-09-15). Se o AV barrar, o fallback do RF45 mantém a estação atualizando.
- **Dois plug-ins DVC registrados** na mesma máquina cliente — mais uma chave de AddIn e mais um
  binário para o suporte acompanhar.

---

## 13. Fase 7 — Instalador da estação (2026-09-19)

Até aqui a estação era preparada à mão, com os `.ps1` de `libTefCitel\Estacao\install\` e uma
sequência que só quem escreveu o requisito conhece. Esta fase entrega um **instalador atendido**
que o suporte roda na estação, com tela, e que deixa "o básico funcionando" para o primeiro login
do autcom trazer o resto.

**Decisões fechadas em 2026-09-19:** tecnologia **Inno Setup**; a estação **pode ter vários
usuários Windows**; instalação **atendida, com tela** (silenciosa é secundária); **exclusão no
Defender sim**, **assinatura digital e detecção de AV de terceiro não agora**.

### 13.1 A fronteira — o que o instalador entrega e o que não entrega

| O instalador entrega | Quem entrega o resto |
|---|---|
| `TefEstacaoService.exe` instalado no SCM, rodando, start automático | — |
| `TefEstacaoAtualizador.exe` na pasta (não é serviço, não é iniciado) | — |
| Os dois plug-ins de canal registrados | — |
| Pasta na exclusão do Defender | — |
| (opcional) UDP do RDP desabilitado no cliente | — |
| — | **DLLs do Scope e do CliSiTef**: chegam na 1ª carga do autcom (Fase 6) |
| — | **`scope.ini`, `CliSiTef.ini`, `CONFITLS.ini`**: idem, já com os caminhos ajustados |
| **`libTefCitel.dll`** como **semente** (`onlyifdoesntexist`) — ver §13.10 | a versão definitiva, na 1ª carga, pelo pacote `libtefcitel` |

O instalador é **pequeno de propósito**. Tudo que muda de versão com frequência viaja pelo canal,
não pelo setup — foi para isso que a Fase 6 existiu. Consequência para o suporte: uma estação com
o instalador de seis meses atrás fica em dia sozinha no primeiro login.

### 13.2 Requisitos funcionais

- **RF47** — Entrega única: um `setup.exe` gerado pelo Inno Setup, que **carrega dentro de si as
  duas bitness** dos plug-ins de canal e grava em disco apenas a que casar com o cliente RDP
  daquela máquina. Conteúdo do pacote:

  | Arquivo | Bitness | Obrigatório | Se faltar |
  |---|---|---|---|
  | `TefEstacaoService.exe` | Win32 | **sim** | instalação aborta |
  | `TefEstacaoAtualizador.exe` | Win32 | **sim** | instala, mas a estação nunca se atualiza — RN31 |
  | `borlndmm.dll` | Win32 | **sim** | **o serviço não sobe** — ver RN47 |
  | `TefCitelDvcPlugin.dll` | **Win32 e Win64** | **sim** (a que casar) | instalação aborta |
  | `TefCitelDvcUpdate.dll` | **Win32 e Win64** | não | atualização cai no caminho lento (RF45) |
  | `libTefCitel.dll` | Win32 | **sim, como semente** | impasse de bootstrap se a RF63 não estiver no serviço — §13.10 |

- **RF47.1** — Os binários vêm **sempre da saída `Release` da IDE**, por caminho relativo ao
  `.iss`, e o `setup.exe` é gerado na **própria pasta `install`**, ao lado do script. Não existe
  cópia manual de binário para dentro do pacote: o que a IDE gerou é o que vai.
- **RF48** — Pasta de instalação **única e flat**, default `C:\Tef_Citel`, alterável no
  assistente. Nada de subpasta por bitness, por componente ou por versão (RN46).
- **RF49** — O serviço é instalado por `TefEstacaoService.exe /install /silent`, configurado com
  **start automático** e **recuperação** (`restart/5000`, três tentativas), e iniciado ao fim.
- **RF50** — Reinstalação sobre instalação existente: o instalador para o `TefEstacaoService` e
  **espera o processo sair** antes de copiar — parar pelo SCM não basta, executável em uso não
  pode ser sobrescrito.
- **RF51** — O instalador **decide sozinho a bitness** do cliente RDP e mostra a decisão no
  assistente, num combo já preenchido com o motivo ao lado ("TSPlus detectado"), que o técnico
  pode trocar. Ordem de decisão, parando na primeira que responder: **TSPlus instalado → Win32**;
  **SO de 32 bits → Win32**; caso contrário **Win64**.
- **RF52** — O registro do plug-in é gravado no hive **do usuário da sessão interativa**, não no
  do instalador (RN42):
  `HKEY_USERS\<SID>\Software\Microsoft\Terminal Server Client\Default\AddIns\TefCitelCh\Name = <pasta>\TefCitelDvcPlugin.dll`.
  `TefCitelCh` é obrigatório; `TefCitelUpd` (canal de volume) é opcional e só é criado se a DLL
  estiver na pasta.
- **RF53** — O instalador cria uma **tarefa agendada oculta com gatilho "ao logon de qualquer
  usuário"**, sem elevação, que grava as mesmas chaves no `HKCU` de quem entrar. É a camada que
  cobre o **usuário N** e que repara registro apagado ou perfil recriado.
- **RF54** — Opção **"Adicionar a pasta às exclusões do Defender"**, **marcada por padrão**.
  Exclui **a pasta**, não os dois `.exe` — o atualizador escreve em `_Preparo` e troca arquivos
  ali dentro, que é exatamente o comportamento que a heurística observa.
- **RF55** — Opção **"Desabilitar o UDP do cliente RDP"**, **desmarcada por padrão** (o processo
  é feito pelo servidor). Quando marcada, grava
  `HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client\fClientDisableUDP = 1`
  (DWORD).
- **RF56** — **Sem trava de sistema operacional, mas preparado para ela**: `MinVersion=0`, e uma
  função única `fVersaoSuportada` chamada em `InitializeSetup` concentra a política. Hoje ela
  sempre devolve permitido e registra a versão no log; abaixo de 6.1 (Windows 7) acrescenta um
  aviso que o técnico confirma e segue.
- **RF57** — A **tela final** diz três coisas, todas obrigatórias: (1) **feche e reabra a sessão
  RDP**, e **não é preciso logoff nem reiniciar o Windows**; (2) **o que ainda vai acontecer
  sozinho** — no primeiro login do autcom com `CFG_TEFDVC = 'S'` os arquivos do TEF e os `.ini`
  são transferidos e aplicados, e a estação reinicia o serviço uma vez; (3) **para qual usuário
  Windows o plug-in já está registrado**, e que **os demais serão registrados sozinhos no próximo
  logon deles**.
- **RF58** — Log próprio do Inno (`/LOG`), copiado ao fim para `<pasta>\instalacao.log`, junto dos
  logs do serviço — onde o suporte já procura. Códigos de saída: `0` instalado; `1` erro fatal;
  `2` instalado, precisa reconectar a sessão RDP; `5` cancelado pelo usuário.
- **RF59** — **Desinstalação** na ordem inversa: parar o serviço e esperar o processo sair;
  `/uninstall /silent`; **remover a tarefa agendada primeiro** e só então apagar
  `TefCitelCh`/`TefCitelUpd` do hive do usuário interativo; remover a exclusão do Defender;
  remover `fClientDisableUDP` **se** o instalador o criou; apagar os arquivos que copiou.

### 13.3 Regras de negócio

- **RN39** — O instalador **não** instala nada que mude de versão com frequência. DLLs do Scope e
  do CliSiTef, os três `.ini` e a `libTefCitel.dll` chegam pela Fase 6, na primeira carga.
- **RN40** — O instalador **não mexe no firewall**. Os dois listeners da estação fazem `bind` em
  `127.0.0.1` (`untTefEstacaoTcpTransporte.pas:915`, `untTefEstacaoUpdateListener.pas:162`);
  ninguém de fora da máquina os alcança, por construção. Está escrito aqui porque "instalou
  serviço, logo precisa de exceção no firewall" é o reflexo de quem revisa.
- **RN41** — **Nunca registrar as duas bitness ao mesmo tempo.** O nome é a chave, não existem
  duas `TefCitelCh` — e apontar a chave para a DLL da bitness errada é justamente o modo de falha
  que a RF51 evita.
- **RN42** — O instalador **nunca grava em `HKCU` direto**, e **não aposta em HKLM**. O setup roda
  elevado: se o técnico elevar com uma conta de administrador diferente da do operador, o `HKCU`
  do setup é o da conta que elevou, a chave nasce no hive errado **sem erro nenhum** e o TEF não
  sobe depois de reconectar — o modo de falha mais caro possível, porque parece sucesso. E HKLM
  não substitui: a documentação de registro de plug-in DVC lista **uma única** raiz, e é
  `HKEY_CURRENT_USER`. Ver `plans.md` §12.2.
- **RN43** — **Nenhum passo do instalador pode deixar a máquina pior do que a encontrou.** Em
  particular, **nada de `reg load` de perfil deslogado**: hive montado e não descarregado impede
  o logon daquele usuário. Ver §13.6.
- **RN44** — Só é **fatal** o que impede o TEF de funcionar. Defender (RF54), UDP (RF55) e
  detecção de bitness (RF51) **registram e seguem**; cópia, serviço, chave `TefCitelCh` e tarefa
  de logon abortam. Uma estação sem Defender é caso normal, não erro — abortar ali deixaria a
  loja sem TEF por causa de uma otimização.
- **RN45** — **O desinstalador não apaga o que não trouxe.** `TefEstacaoVersao.ini`, os `.log`,
  `_Preparo`, `_Falhou` e tudo que chegou pelo canal **ficam na pasta**; são evidência de campo.
  A pasta sobrevive com esse conteúdo e o Inno não a remove por não estar vazia — comportamento
  desejado, documentado aqui para não parecer defeito. O hive dos **demais** usuários também fica
  como está: a chave órfã aponta para uma DLL que não existe mais e o cliente RDP a ignora.
- **RN47** — O `borlndmm.dll` **não é acessório**: o `TefEstacaoService.dpr` tem `ShareMem` como
  primeira unit (o `fCriarTefCitel` é importado de `libTefCitel.dll` e strings cruzam essa
  fronteira), e sem essa DLL ao lado **o serviço não sobe**. É **uma só, Win32**, e vem da mesma
  cópia que o autcom usa (`padra_atualizado\`) — o atualizador declara no próprio `.dpr` que não
  usa `ShareMem`, e os dois plug-ins, inclusive o Win64, também não. Por isso não há questão de
  bitness aqui.
- **RN46** — A pasta instalada é **flat**, e isso não é preferência estética: o `pExtraiZip` da
  atualização **ignora entrada de zip com subpasta**, de propósito. Instalar em layout com
  subpastas quebraria a Fase 6 em silêncio.

### 13.4 Critérios de aceitação

Entregável de quem implementa é esta lista; os casos são escritos pelo analista.

1. Máquina limpa, primeira instalação atendida: ao fim, `TefEstacaoService` está **rodando**, com
   start automático e recuperação configurada, e a pasta tem exatamente os arquivos da RF47 —
   **uma** bitness de cada plug-in.
2. Reconectada a sessão RDP, o autcom com `CFG_TEFDVC = 'S'` **abre o canal** e o TEF carrega —
   sem a mensagem de canal ausente que a correção de 19/09 introduziu.
3. Na mesma carga, os arquivos do TEF e os três `.ini` chegam pela Fase 6 e o serviço reinicia uma
   vez, **sem intervenção** — a fronteira da §13.1 se provando.
4. **Teste obrigatório do usuário N:** instalar logado como A; fazer **logon como N**; conferir a
   chave em `HKCU` do N; abrir o RDP pelo atalho e **passar um cartão**. Conferir apenas que a
   tarefa foi criada **não prova nada**.
5. Instalação elevada com **credencial de outro administrador**: a chave nasce no hive do usuário
   da sessão interativa, não no do administrador que elevou (RN42).
6. Reinstalação sobre instalação existente com o serviço **rodando**: para, espera o processo
   sair, sobrescreve e sobe — sem erro de arquivo em uso (RF50).
7. Máquina com **TSPlus**: o assistente propõe **Win32** com o motivo na tela, e a chave aponta
   para a DLL de 32 bits (RF51, RN41).
8. Máquina **sem Defender** ou com PowerShell ausente: a exclusão falha, o log registra, e a
   instalação **termina com sucesso** (RN44).
9. Desinstalação: serviço removido, tarefa removida **antes** da chave, chaves do usuário
   interativo apagadas, e `TefEstacaoVersao.ini`, `.log`, `_Preparo` e `_Falhou` **continuam na
   pasta** (RN45).
10. `instalacao.log` na pasta ao fim de uma instalação bem-sucedida e de uma abortada, com o motivo
    legível em ambas (RF58).

### 13.5 Fora de escopo desta fase

- ~~**Assinatura digital do `setup.exe` e dos binários.**~~ **ENTROU EM ESCOPO em 2026-09-20 — ver §13.9.** O texto abaixo fica como registro do que valia até 19/09:
  - **Assinatura digital do `setup.exe` e dos binários.** Fica registrado que a detecção do
  `TefEstacaoAtualizador.exe` pelo Bitdefender em 17/09 (`ATC.SuspiciousBehavior...`, sem ação
  tomada) continua de pé, e que a exclusão no Defender **não cobre AV de terceiro**.
- **Detecção de antivírus de terceiro** e criação de exclusão neles.
- **Instalação silenciosa em massa por GPO** — os parâmetros existem, o desenho de distribuição
  não.
- **Auto-atualização do instalador pelo canal** — quem atualiza os binários da estação é a Fase 6.
- **Qualquer alteração em código Delphi.** Esta fase é `.iss` e nada mais.

### 13.6 Cobertura de usuários — o que fica de fora, por decisão

| Quem | Coberto por | Quando |
|---|---|---|
| Quem está na sessão em que o suporte instalou | RF52 | imediato |
| **Usuário N**, e qualquer um que logue depois | RF53 | no logon dele, antes de clicar no atalho do RDP |
| Perfil recriado, registro apagado | RF53 | no logon seguinte |
| **Usuário logado que nunca mais faz logon** | **ninguém** | — |

A última linha é decisão consciente. Troca rápida de usuário, ou sessão desconectada e depois
reconectada, **não** gera evento de logon e portanto não dispara a RF53. Seria coberto varrendo os
SIDs já presentes em `HKEY_USERS` na hora da instalação — escrita comum, sem risco —, e ficou de
fora por ser cenário improvável nesta operação.

> **Sintoma, se algum dia acontecer:** a estação tem TEF para uns usuários e não para outros, e o
> afetado volta a funcionar sozinho depois de um logoff/logon. O remédio de campo é exatamente
> esse, e é o que o suporte deve tentar **antes** de reinstalar.

**Fechado em 2026-09-19, não é mais dúvida:** sempre há alguém logado na estação quando o suporte
instala (o acesso é remoto), então o `WTSGetActiveConsoleSessionId` da RF52 não cai no caso
"nenhuma sessão". O instalador ainda trata esse retorno, mas como **erro a relatar**, não como
caminho esperado.

### 13.7 Dependências, riscos e pontos em aberto

**Nenhum deles exige mexer numa máquina antes de implementar.** O que era o ponto bloqueante —
provar o HKLM — deixou de existir com a correção da `plans.md` §12.2.

1. **Nome do valor do UDP** (RF55) — confirmar `fClientDisableUDP`. Fecha na primeira instalação
   de teste, marcando a opção e conferindo o registro depois.
2. **Onde o `setup.exe` é construído.** O Inno Setup precisa estar instalado em alguma máquina e o
   `.iss` precisa entrar no SVN. Falta decidir se a compilação do setup entra em algum
   `.groupproj` ou fica manual, como o build da IDE.
3. **Versionamento do instalador** para o Adicionar/Remover Programas. Proposto: a mesma revisão
   do SVN que o `rev.inc` já carrega.
4. **A tarefa agendada e o antivírus.** Criar tarefa de logon é, por si, comportamento que algumas
   heurísticas observam. Não é o mesmo peso do `TefEstacaoAtualizador.exe` — aqui é `reg.exe`, não
   um binário nosso —, mas é candidato a aparecer no primeiro teste em máquina com AV de terceiro.
5. **A heurística de bitness vai errar em alguma loja.** Quando errar, o sintoma é o canal não
   abrir — hoje já com a mensagem certa na tela do autcom, desde o conserto de 19/09 (C.8).

### 13.8 Correções ao contrato, feitas na implementação (2026-09-20)

O `.iss` foi escrito e **compila limpo** no Inno Setup 6.4.2. Três itens do contrato não
sobreviveram ao encontro com a ferramenta, e um quarto está em aberto. Ficam aqui em vez de serem
corrigidos em silêncio no texto acima.

**1. RF56 — `MinVersion=0` não existe mais.** O Inno Setup 6.4 **recusa compilar** com
`MinVersion` abaixo de 6.1: ele próprio não roda em Windows anterior ao 7. Não há perda real —
6.1 é exatamente o piso do canal DVC, que a própria `plans.md` §12.8 já apontava como *o* limite
do requisito. O que a RF56 de fato queria — política de versão num lugar só, fácil de apertar
depois — continua valendo e mora em `fVersaoSuportada`. **A linha da tabela de pisos que dizia
"Inno Setup (runtime gerado) → Windows 2000" era verdade do Inno 5, não do 6.**

**2. RF58 — os códigos de saída são os nativos do Inno.** `1`, `2`, `3`, `5` e `6` são reservados
pelo Inno com significados próprios, e `2` em particular é "cancelado antes de instalar" — colide
de frente com o "instalado, precisa reconectar" do desenho. Somado a isso: **reconectar é sempre
necessário** depois de uma instalação bem-sucedida, então aquele código não distinguiria nada de
nada. Fica valendo `0` = instalado, os demais como o Inno os define, e o "reconecte" dito na tela
final e no `instalacao.log`.

**3. RF52 — o SID é achado em `HKEY_USERS`, não pelo `LookupAccountName`.** O Pascal Script do
Inno não marshalla SID binário, e a conversão exigiria três APIs a mais. O caminho usado é casar o
nome vindo do `WTSQuerySessionInformation` contra `Volatile Environment\USERNAME` de cada SID já
presente em `HKEY_USERS`. **É estritamente mais forte que o desenho:** o `LookupAccountName`
devolveria um SID válido mesmo com o hive descarregado, e gravar nesse SID não criaria nada útil;
achar o SID dentro de `HKEY_USERS` **prova** que o hive está carregado, que é a condição de que a
gravação depende. Há ainda um caminho de reserva por `SESSIONNAME = Console`, para o caso de a
leitura do nome não responder.

**4. RF53 — a tarefa de logon vai piscar uma janela de console, e isso precisa de decisão.** A
tarefa executa um `.cmd` com os `reg add` (um `.cmd` em vez de dois `reg.exe` porque são dois
canais e duas tarefas seriam dois disparos no logon). **Tarefa de logon executando programa de
console mostra a janela por uma fração de segundo** — o desenho prometia "oculta, sem janela de
console piscando no logon do caixa", e isso não se cumpre como está. As saídas conhecidas:

| Saída | Custo |
|---|---|
| **Aceitar o flash** (é o que está implementado) | o caixa vê um piscar no logon |
| Rodar via `wscript.exe` + `.vbs` com janela oculta | um `.vbs` que escreve no registro a cada logon é a forma exata do que heurística de antivírus procura — pior que o flash, num requisito que já tem problema de AV |
| **Um switch `/registraplugin` no `TefEstacaoService.exe`** | ~20 linhas de Delphi, mas **nenhum binário novo**: o exe já está na pasta, já está na exclusão do Defender, e é subsistema GUI (Vcl.SvcMgr) — **não abre console nenhum**. Custo: abre a fronteira "esta fase não mexe em Delphi" (§13.5) |

A terceira é a melhor tecnicamente e é a única que cumpre o desenho. **Fica para decisão do
Rafael**, porque muda o escopo que a §13.5 fixou.

**5. ~~Pendência de build: só existe o `TefCitelDvcUpdate.dll` de Win64.~~** **RESOLVIDA em
2026-09-20** — as seis pastas `Release` estão preenchidas, incluindo
`UpdatePlugin\Win32\Release`. O instalador passou a se montar a partir delas (RF47.1) e as duas
bitness do canal de volume entram no pacote.

### 13.9 Assinatura digital — entra em escopo (2026-09-20)

A §13.5 dizia, com a decisão de 19/09, que assinatura digital ficava de fora. **O Rafael reabriu
em 20/09**, e a §13.5 passa a valer para tudo menos este tema. O que era ponto 1 daquela lista
está agora aqui.

- **RF60** — Todo `.exe` e `.dll` que o instalador leva é **assinado antes de entrar no
  `setup.exe`**, e o `setup.exe` e o **desinstalador** são assinados depois. Assinatura
  **SHA-256 com carimbo de tempo RFC3161** — o carimbo é o que faz a assinatura continuar válida
  depois de o certificado expirar.
- **RF61** — A compilação do instalador é feita pelo **`build-setup.cmd`**, não pelo `ISCC.exe`
  direto. Chamar o compilador na mão produz um instalador **sem assinatura e sem aviso**, porque
  o parâmetro que registra o assinador fica de fora.
- **RF62** — Existe um modo **`/semassinar`**, para bancada. Ele é explícito no comando e anuncia
  na tela o que produziu; não é o default e não serve para publicar.

- **RN48** — **A senha do certificado nunca entra no repositório.** Ela chega pela variável de
  ambiente `CITEL_ASSINA_SENHA`; sem ela o build para com mensagem, em vez de gerar um pacote
  não assinado.
- **RN49** — **O `borlndmm.dll` não é assinado por nós.** Já vem assinado pela Embarcadero e é
  compartilhado com o autcom; reassinar trocaria a assinatura do fabricante pela nossa num
  arquivo que não é do requisito.
- **RN50** — Assinar **reescreve o arquivo de origem em disco**. É aceitável porque as pastas
  `Release` não são versionadas e a IDE as regenera — mas está escrito aqui porque explica o
  hash daqueles binários mudar sem ninguém ter recompilado.

**Critérios de aceitação, somados aos da §13.4:**

11. `build-setup.cmd` **sem** `CITEL_ASSINA_SENHA` definida → para com mensagem clara e **não**
    gera instalador.
12. `build-setup.cmd` com a senha correta → os seis binários, o desinstalador e o `setup.exe`
    saem assinados; o `borlndmm.dll` mantém a assinatura da Embarcadero.
13. `signtool verify /pa /v` no `setup.exe` publicado: cadeia válida **e carimbo de tempo
    presente**.
14. Numa estação, o diálogo de elevação do `setup.exe` mostra o **editor verificado**, não
    "Editor desconhecido".

**Ainda não feito, e é o que falta para fechar:** nada foi assinado com o certificado real. O
`mycert.pfx` tem senha e ela não foi fornecida — toda a cadeia foi validada com um certificado
descartável. Ver `plans.md` §12.16.

### 13.10 O impasse de bootstrap do `libTefCitel.dll` (campo, 2026-09-20)

Primeira instalação numa estação limpa de verdade. O instalador fez tudo certo — serviço rodando,
canais registrados no hive do usuário interativo, tarefa criada, Defender excluído, canal DVC
aberto pelo AUTCOM. E então o TEF não subiu.

**O sintoma apontava para o lugar errado.** O AUTCOM mostrou *"Não foi possível falar com o
serviço de TEF da estação"*, e a leitura natural foi falha do atualizador. O atualizador nunca
chegou a rodar.

**O que aconteceu.** `pAtualizaContexto` roda em toda chamada e criava a sessão
**incondicionalmente**, e criar sessão significa `fCriarTefCitel` — um
`external 'libTefCitel.dll' delayed`. Numa estação recém-instalada essa DLL **não existe**: por
desenho ela chega na primeira carga, pelo pacote `libtefcitel`. Quem pede esse pacote é o
`fAtuConsulta`. Então o `fAtuConsulta` morria com `External exception C06D007E` — o código que o
Delphi levanta quando o delay-load não acha o módulo — **antes de chegar no próprio handler**, e a
única chamada capaz de trazer a DLL precisava dela.

**A estação não saía sozinha desse estado.** É defeito de bootstrap, não de atualização.

**Por que nunca apareceu antes:** até a Fase 7 o `libTefCitel.dll` era copiado à mão no preparo da
estação. O instalador é a primeira coisa que cria uma estação de verdade vazia — ele não causou o
defeito, ele o revelou.

#### O conserto, em duas partes

- **RF63** — Os cinco métodos da Fase 6 (`fAtuConsulta`, `pAtuAbre`, `pAtuParte`, `fAtuFecha`,
  `fAtuAplica`) são servidos **sem instanciar a `ITefCitel`**. Eles são operação de disco e de
  SCM; nenhum deles toca a DLL nativa. Mesmo espírito do `fSessaoDoPid` que o `reata` já usava:
  mensagem que só pergunta não pode ter como efeito colateral carregar a DLL nativa.
- **RF64** — O instalador leva o `libTefCitel.dll` como **semente**, `onlyifdoesntexist`. A versão
  definitiva continua sendo a que a Fase 6 envia na primeira carga — a que o AUTCOM está rodando
  naquele momento. A semente só poupa uma transferência e um reinício de serviço na primeira
  carga; com a RF63 a estação já funcionaria sem ela.

- **RN51** — **A estação tem de ser capaz de se reparar sozinha.** Nenhum caminho de atualização
  pode depender de um artefato que só a própria atualização entrega. Se um método novo da
  atualização vier a precisar da `ITefCitel`, ele **não** entra na lista da RF63 — e aí a
  dependência volta, de propósito e documentada.

**Atualização da §13.1:** a linha *"`libTefCitel.dll`: chega na 1ª carga"* passa a ser *"semente
no instalador, versão definitiva na 1ª carga"*. A fronteira do resto não muda: DLLs do
Scope/CliSiTef e os três `.ini` continuam chegando só pela Fase 6.

**Critérios de aceitação, somados aos da §13.4:**

15. Estação limpa, **sem** `libTefCitel.dll` na pasta (apagá-la depois de instalar, para testar a
    RF63 isolada da RF64): o `fAtuConsulta` responde, a Fase 6 entrega a DLL, e o TEF sobe na
    mesma carga.
16. Estação limpa com o instalador completo: o TEF sobe **sem** nenhuma linha de
    `External exception C06D007E` no `TefEstacaoService.log`.
17. Reinstalar sobre estação que já recebeu a DLL pela Fase 6: o `onlyifdoesntexist` **não**
    substitui a que está lá.

### 13.11 Dois ajustes do primeiro teste bem-sucedido (2026-09-20)

A estação subiu: instalador correto, canal DVC aberto, Fase 6 entregando o `scope.ini` para
`C:\Tef_Citel\` e o Scope carregando na estação. O erro que apareceu — `ScopeSrv off-line` —
era real e esperado (a máquina de teste não tem a VPN). Dois defeitos ficaram expostos.

#### Reinstalação por cima abortava

- **RF65** — Reinstalar sobre uma instalação existente **não pode chamar `/install` de novo**. O
  SCM devolve `ERROR_SERVICE_EXISTS` (1073) e o `Vcl.SvcMgr` mostra o erro numa **caixa
  própria**, apesar do `/silent` — que só cala a mensagem de sucesso. O técnico via um diálogo
  de erro do executável do serviço no meio da instalação.
- **RN52** — Reinstalar por cima é **caminho normal**, não exceção: é assim que a estação recebe
  versão nova. Quando o serviço já existe, o instalador apenas **reaponta o `binPath`** (a
  reinstalação pode ter ido para outra pasta) e reaplica a configuração.

#### O `libTefCitelErro.log` vinha da máquina errada

Quando o TEF falha, o operador tem a opção **"Ver libTefCitelErro.log"**. O AUTCOM lia esse
arquivo de `CFG_PTTFCT\<TFC_NUMTER>` ou da pasta do `autcom.exe` — **dois caminhos do
servidor**.

Com `CFG_TEFDVC = 'S'` quem carrega a DLL do TEF é o serviço **da estação**, e é lá, ao lado
dela, que o arquivo é escrito (`pLogError`, em `untTefCitelNCR`). O operador via um arquivo de
outra máquina, velho, ou nenhum — exatamente quando precisa do motivo real.

- **RF66** — Com TEF DVC, o conteúdo do `libTefCitelErro.log` exibido ao operador vem **da
  estação**, por RPC (`fConteudoLogErro`, novo na `ITefCitel`). Sem DVC nada muda.
- **RN53** — Se o canal não responder, a tela **degrada com o motivo** em vez de propagar a
  exceção. Esta já é a tela de erro do TEF; deixar uma exceção subir daqui trocaria informação
  incompleta por um diálogo do madExcept — mesma lição de C.8 e C.9.

**Critérios de aceitação, somados aos anteriores:**

18. Reinstalar por cima, com o serviço instalado: conclui **sem nenhum diálogo de erro**, e o
    `binPath` do SCM aponta para a pasta escolhida nesta instalação.
19. Com TEF DVC, forçar um erro na estação e clicar em **"Ver libTefCitelErro.log"**: o conteúdo
    exibido é o da **estação**, e confere com o arquivo da pasta do serviço.
20. Mesmo caso com o serviço da estação parado: mensagem dizendo que o arquivo fica na estação e
    que o suporte deve ser acionado — **sem** madExcept.
### 13.12 A tela não pode ficar na etapa anterior (2026-09-20)

Com a atualização concluída, a tela de carga seguia mostrando **"Estação do TEF atualizada."**
durante todo o `fConfiguraTefCitel` — que é a próxima coisa a acontecer e pode demorar bastante
quando o servidor do TEF não responde (VPN fora do ar, `ScopeSrv` parado, IP errado no
`scope.ini`).

Efeito prático: operador e suporte leem *"atualizada"* durante uma espera que não tem nada a ver
com a atualização, e o chamado chega como *"travou atualizando a estação"* — mandando o suporte
procurar defeito na Fase 6 quando o problema é de comunicação com o TEF.

- **RF67** — Terminada a atualização e **antes** do `fConfiguraTefCitel`, a tela de carga passa
  a mostrar **"Aguarde, comunicando com o servidor TEF..."**. Só no caminho DVC: fora dele não
  houve etapa de atualização e não há texto velho a corrigir.
- **RN54** — A mensagem **não mexe na barra de progresso** — ela continua onde a atualização a
  deixou. Trocar só o texto é o que distingue "outra etapa" de "recomeçou do zero" aos olhos de
  quem está esperando.

**Critério de aceitação:**

21. Estação sem comunicação com o servidor do TEF: durante a espera a tela mostra
    **"Aguarde, comunicando com o servidor TEF..."**, e não a mensagem da atualização.
### 13.13 A escrituração de versão não é prova (campo, 2026-09-20)

Teste **V.15**, executado pelo Rafael: apagar o `libTefCitel.dll` da pasta da estação e subir o
AUTCOM. **A estação não se reparou.** O `fAtuConsulta` respondeu (a RF63 funcionou), mas o
AUTCOM não reenviou a DLL e o `fConfiguraTefCitel` voltou ao `External exception C06D007E`.

**Causa:** `fHashAplicado` lia apenas o `TefEstacaoVersao.ini`. Com o arquivo fora do disco, o
ini seguia declarando o pacote como aplicado, o AUTCOM concluía *"estação em dia"* e nunca
reenviava. Sem saída a não ser reinstalar.

É o impasse de bootstrap por outra porta, e contraria a **RN51**, escrita no mesmo dia. E não é
cenário de laboratório: o **C.6/C.7** já registrou antivírus levando o
`TefEstacaoAtualizador.exe` — levar esta DLL é a mesma classe de evento, ao lado de gravação que
falhou depois de marcada e de pasta mexida à mão.

- **RF68** — Quando a estação declara um pacote como **aplicado** ou **preparado**, a declaração
  é **conferida contra o disco**. Arquivo ausente → responde vazio, que em todo o arquivo de
  versão significa *"nunca"* — e o AUTCOM reenvia na carga seguinte, sem protocolo novo e sem
  nenhum caso especial do outro lado.
- **RN55** — A conferência é possível quando **um arquivo responde pelo pacote**: no `_Preparo`
  isso vale para **todos** (cada pacote é um arquivo só, inclusive os `.zip`, expandidos apenas
  na aplicação); no **aplicado** vale para os de arquivo único — `libtefcitel` e os três
  `.ini`. Para um `.zip` já aplicado, que virou um conjunto de arquivos soltos, o
  comportamento fica como estava: não há nome único que responda por ele e conferir barato não dá.

**Critério de aceitação:**

22. **V.15 refeito:** apagar o `libTefCitel.dll` da estação e subir o AUTCOM. A carga reenvia o
    pacote, a estação aplica, e o TEF sobe — **sem reinstalar**. O log da estação traz a linha
    `o pacote "libtefcitel" consta como aplicado, mas ... NAO esta no disco`.
### 13.14 O certificado é autoassinado — o que isso muda (2026-09-21)

O instalador assinado foi gerado com a senha do `mycert.pfx`. **O mecanismo funciona:** sete
arquivos assinados em **SHA-256** e **carimbados** (cadeia do carimbo DigiCert verificada), e o
`libTefCitel.dll`/`borlndmm.dll` corretamente intocados.

**Mas o certificado é autoassinado:**

`
Issued to: Citel Software      Issued by: Citel Software      (Subject = Issuer)
Valido de 10/06/2025 ate 10/06/2045   RSA 2048   EKU: Assinatura do Codigo
signtool verify /pa /v -> "A certificate chain processed, but terminated in a
                           root certificate which is not trusted by the trust provider."
`

Consequências, e elas separam o que a assinatura entrega do que não entrega:

| O que a assinatura **dá** hoje | O que ela **não dá** |
|---|---|
| Prova de integridade — arquivo adulterado deixa de validar | **Editor verificado no UAC**: segue "Editor desconhecido" |
| Autoria identificável **onde a raiz Citel for confiável** | **Reputação para antivírus e SmartScreen** — que foi a motivação original, pelo Bitdefender ter detectado o `TefEstacaoAtualizador.exe` em 17/09 |
| Carimbo de tempo válido — a assinatura sobrevive ao vencimento do certificado | — |

- **RN56** — Assinatura com certificado autoassinado **não substitui** certificado de CA pública
  para efeito de antivírus e SmartScreen. Registrar isso evita que alguém conclua, mais adiante,
  que "já está assinado, então o AV não deveria barrar".

**Critérios 13 e 14: NÃO atendidos.** O 13 pede cadeia válida; o 14 pede editor verificado no
diálogo de elevação. Os dois dependem da procedência do certificado, não do build.

**Três caminhos, e a escolha é de negócio:**

1. **Certificado de CA pública** (OV ou EV). É o único que dá reputação para AV/SmartScreen; o EV
   dá reputação imediata. Fecha 13 e 14 sem tocar em uma linha do que já existe — basta apontar
   `CITEL_ASSINA_PFX` para o novo `.pfx`.
2. **Manter o autoassinado e distribuir a raiz Citel** às estações (GPO ou pelo próprio
   instalador). Dá "editor verificado" **dentro da rede da loja** e nada de reputação para AV.
3. **Aceitar como está** — integridade e autoria, sem os outros dois efeitos.

#### DECISÃO (Rafael, 2026-09-21): opção 3, por enquanto

Fica o certificado autoassinado. O build não muda em nada — o `build-setup.cmd` continua como
está, e trocar para um certificado de CA pública, no dia em que houver, é só apontar
`CITEL_ASSINA_PFX` para o novo `.pfx`.

Os critérios 13 e 14 são reescritos para o que a decisão de fato compromete, em vez de ficarem
como pendência permanente:

- **Critério 13 (revisto)** — o `setup.exe` publicado tem assinatura **SHA-256 com carimbo de
  tempo válido**, e o `signtool verify /pa` para na cadeia do signatário por ela ser
  autoassinada. **Atendido em 2026-09-21.**
- **Critério 14 (revisto)** — o diálogo de elevação mostrando **"Editor desconhecido" é o
  comportamento ESPERADO** enquanto valer a opção 3. **Não é defeito e não deve ser reportado
  como tal** em teste de campo.

**O que a decisão NÃO muda:** o **C.7** (atualizador bloqueado pelo antivírus) continua valendo
exatamente como antes. Assinatura autoassinada não dá reputação — ver RN56 —, então o risco de AV
segue igual ao de 17/09.
### 13.15 A tarefa de logon deixa de piscar console (2026-09-21)

Fecha o item 4 da §13.8, que estava em aberto desde a implementação.

A tarefa `CitelTefRegistraPlugin` executava um `.cmd` com `reg.exe`. Os dois são
**subsistema CONSOLE**, e a tarefa roda na sessão interativa do usuário — o Windows abria uma
janela de console, um lampejo na cara do caixa **a cada logon**. O desenho prometia o contrário:
"oculta, sem janela de console piscando no logon do caixa" foi um dos argumentos que descartaram
`HKLM\...\Run`.

- **RF53 (revisto)** — A ação da tarefa passa a ser
  `"<pasta>\TefEstacaoService.exe" /registraplugin`. Esse executável é **subsistema GUI**
  (`Vcl.SvcMgr`) e não abre console nenhum. O switch registra o plug-in no `HKCU` de quem
  logou e sai, **antes** de `Application.Initialize` — sem VCL, sem SCM, sem janela.
- **RN57** — O diagnóstico do switch é o **código de saída**, que o Agendador guarda em
  `LastTaskResult`: `0` registrado, `2` plug-in ausente na pasta, `3` falha ao gravar no
  `HKCU`. **Não há log em arquivo, de propósito:** isso roda como usuário comum, e a pasta da
  estação nasce com `Users` apenas em leitura — tentar gravar log ali falharia em toda execução
  e só geraria ruído.
- **RN58** — A alternativa `wscript.exe` + `.vbs` com janela oculta fica **descartada**: um
  `.vbs` que escreve no registro a cada logon é a forma exata do que heurística de antivírus
  procura, e o **C.7** segue em aberto. O switch não acrescenta binário nenhum — o executável já
  está na pasta e já está na exclusão do Defender.

**Critério de aceitação:**

23. No logon do **usuário N** (que é o V.4), o plug-in é registrado **sem nenhuma janela piscando
    na tela**, e a tarefa mostra `LastTaskResult = 0`.
### 13.16 A exclusão do Defender não alcança a frota (campo, 2026-09-21)

O `Add-MpPreference` devolveu 1 na estação de 21/09. **Motivo confirmado pelo Rafael: a máquina
tem Bitdefender corporativo.** Quando um antivírus de terceiro se registra no Security Center, o
Windows Defender entra em modo passivo ou desligado — e `Add-MpPreference` falha.

**A consequência é maior que o aviso.** A RF54 — a opção "adicionar a pasta às exclusões do
Defender", **marcada por padrão** — foi desenhada como a mitigação de antivírus do instalador. Mas
o antivírus que de fato incomoda esta operação é o **Bitdefender GravityZone**: foi ele que
detectou o `TefEstacaoAtualizador.exe` como `ATC.SuspiciousBehavior...` em 17/09, e é o que
está na frota. Ou seja:

> **Onde o problema de AV existe, a exclusão do instalador não funciona. Onde ela funciona, o
> problema não existe.**

- **RN59** — A exclusão do Windows Defender **não é mitigação de antivírus para esta operação**.
  A mitigação real do **C.7** é uma **exclusão de `C:\Tef_Citel` na política do GravityZone**,
  feita centralmente pela infraestrutura. O instalador **não pode** fazer isso e não deve dar a
  entender que faz.

**O que isso muda no C.7:** ele deixa de ser "testar se o AV bloqueia o atualizador" e passa a
ser, em ordem: **(1)** pedir à infra a exclusão na política do GravityZone; **(2)** confirmar que
ela chegou na estação; **(3)** só então testar o atualizador. Sem o passo 1, o teste mede o AV sem
exclusão — que é uma informação diferente, e pior.

**O que NÃO muda:** a RF54 continua útil em estação sem AV corporativo, e a degradação da RN44
funcionou exatamente como projetada — avisou e seguiu, a instalação terminou.
#### Detecção de antivírus de terceiro — só para a mensagem (decisão do Rafael, 2026-09-21)

A §13.5 tinha deixado "detecção de antivírus de terceiro" fora de escopo. Reaberto **apenas para
a mensagem**: o instalador continua sem tentar criar exclusão em AV de terceiro — isso é política
central (RN59).

- **RF69** — Quando a exclusão do Defender falhar, o instalador consulta
  `root\SecurityCenter2\AntiVirusProduct` e, havendo antivírus de terceiro, troca o aviso
  genérico por instrução: nomeia o antivírus, diz que **é esperado e não é falha da instalação**, e
  manda pedir à infraestrutura a exclusão da pasta na política dele.
- **RN60** — A detecção **nunca** pode atrapalhar a instalação. O namespace
  `root\SecurityCenter2` **não existe no Windows Server**; nesse caso, e em qualquer outra
  falha, a função devolve vazio e a mensagem cai no texto genérico de antes.
### 13.17 A tarefa rodava como quem instalou (campo, 2026-09-21)

**O V.4 finalmente foi exercitado, e reprovou.** O usuário N logou na estação e o AUTCOM deu
**erro 31** — a mesma assinatura do C.8, "não existe canal DVC nesta sessão".

**O diagnóstico apontava para o lado errado**, e essa é a parte que vale guardar. A tarefa
registrou `LastTaskResult = 0`: do ponto de vista do Agendador, deu tudo certo. O que o
`conferir-instalacao.ps1` mostrou:

`
disparador: QUALQUER usuario (sem UserId) - correto    <- o gatilho estava certo
executa como . rafael.bizio   LogonType: Interactive   <- o principal, nao
ultimo run . 21/09/2026 17:12:07  resultado: 0
`

O `schtasks /sc onlogon` sem principal cria o **gatilho** para qualquer usuário — mas mantém o
**principal** de quem criou a tarefa. Então, no logon do usuário N, a tarefa disparou, rodou como
`rafael.bizio` e **reescreveu a chave no HKCU dele de novo**. O usuário N nunca teve o plug-in.

E os logs confirmam por outro caminho: no `TefCitelDvcPlugin.log` **não há nenhum
`Listener "TefCitelCh" criado`** para a sessão nova. O plug-in nunca foi carregado — o que
descarta transporte (UDP e afins), porque o cliente RDP lê o HKCU e carrega o plug-in **antes** de
qualquer negociação de transporte.

- **RF53 (revisto de novo)** — A tarefa é criada por **XML**, com o principal sendo o **grupo
  Usuários pelo SID `S-1-5-32-545`** e `LogonTrigger` sem `UserId`. Assim o Agendador roda a
  tarefa **no contexto do membro que disparou o gatilho**, que é o único jeito de o `HKCU` ser o
  do usuário que acabou de logar.
- **RN61** — `LastTaskResult = 0` **não prova** que o plug-in foi registrado para o usuário
  certo: prova apenas que o processo terminou bem, em algum contexto. A prova é a chave no
  `HKCU` **daquele** usuário, e é por isso que o critério 4 exige rodar o coletor logado como
  ele.

**Três coisas vêm de graça com o XML, e duas delas importam:**

- **`DisallowStartIfOnBatteries`** — o `schtasks` cria isso como **true** por padrão. Numa
  estação que seja notebook, no primeiro logon fora da tomada a tarefa **não rodaria**. O XML põe
  `false`;
- o grupo entra por **SID**, que não depende do idioma do Windows (`Users` / `Usuários`);
- `Hidden` e `ExecutionTimeLimit`, que a forma por parâmetro não alcança.

**Critério de aceitação 23 (revisto):** no logon do usuário N, o coletor rodado **como ele** mostra
a chave no `HKCU` dele, a tarefa mostra `executa como` o **grupo**, e nenhuma janela pisca.
### 13.18 V.4 validado — a cadeia da RF53 fecha (2026-09-21)

Instalado como um usuário, logon feito como **outro**: a tarefa registrou o plug-in no `HKCU`
dele sozinha, o cliente RDP carregou o plug-in, o canal abriu, o TEF subiu e **um cartão passou**.

Sequência medida, sem intervenção entre os passos:

`
17:55:22  Listener "TefCitelCh" criado           <- plug-in carregou na sessao do usuario N
17:56:24  fConfiguraTefCitel retornou 0          <- TEF subiu para ele
17:57:10  fPassarCartao ... com sucesso
17:57:15  fFinalizarTransacao ... com sucesso
`

**Criterios 4 e 23: atendidos.** Com isso, as duas camadas da §13.6 estao provadas em campo — a
imediata (RF52, o usuario da sessao interativa) e a de logon (RF53, todos os demais).

- **RN62** — O relatorio de conferencia rodado por **usuario comum** nao enxerga a tarefa
  agendada. Isso **nao** e ausencia da tarefa, e o coletor passou a dizer isso com todas as
  letras: a versao anterior escrevia "NAO EXISTE" no mesmo relatorio que provava o criterio 4, e
  em campo isso levaria alguem a reinstalar sem motivo.
### 13.19 O log do transporte sai do %TEMP% (2026-09-21)

Pedido do Rafael. O `TefCitelDvcTransporte.log` — o log de diagnóstico do canal DVC, do lado
AUTCOM — era gravado no `%TEMP%` do processo. Isso separa por sessão, mas espalha o arquivo por
perfis de usuário, e o `%TEMP%` é candidato a Limpeza de Disco: na prática o suporte precisava
descobrir **em qual** `%TEMP%` procurar.

- **RF70** — O log passa a ser gravado em **`<pasta do autcom.exe>\TefLog`**, criada sozinha na
  primeira linha de log de cada processo.
- **RF71** — O nome do arquivo leva o **nome da ESTAÇÃO** como sufixo:
  `TefCitelDvcTransporte_<NOMEDAESTACAO>.log`. Sem isso, tirando o log do `%TEMP%` **todas** as
  estações passariam a gravar no mesmo arquivo, um AUTCOM sobrescreveria a rotação do outro, e o
  log deixaria de responder *"o que aconteceu naquela estação"* — que é a única pergunta que ele
  existe para responder.
- **RN63** — O nome da estação vem de **`CLIENTNAME`**, que o Terminal Services define na sessão
  com o nome do cliente RDP. **Não é `COMPUTERNAME`**: esse devolveria o nome do TS, igual para
  todos, e não separaria nada. Sem `CLIENTNAME` — AUTCOM rodando direto no console, sem RDP — cai
  em `COMPUTERNAME`, e aí ele está certo: nesse caso a estação **é** aquela máquina.
- **RN64** — Se a pasta `TefLog` não puder ser criada, o log **volta para o `%TEMP%`** em vez de
  deixar de existir. A pasta do AUTCOM pode ser somente leitura para o operador — é a mesma razão
  pela qual a criação do `TefCitelDvcLog.ini` já era "best effort". Perder o diagnóstico para
  ganhar organização seria troca ruim.

A chave `Pasta=` do `TefCitelDvcLog.ini` continua valendo e sobrepõe o default; o comentário
dentro do arquivo foi reescrito para descrever o novo comportamento.

**Critério de aceitação:**

24. Depois de uma carga com TEF DVC, existe `<pasta do autcom>\TefLog\TefCitelDvcTransporte_<nome
    da estação>.log`, e o nome no sufixo é o da **máquina do operador**, não o do servidor TS.
    Com duas estações diferentes, dois arquivos.
### 13.20 `LogPath` — chave de caminho que vale em qualquer grupo (2026-09-21)

O `scope.ini` vai ganhar parâmetros novos, e alguns são de caminho. O primeiro é o **`LogPath`**,
que deve receber o mesmo tratamento do `ArqControlPath` — apontar para o diretório do serviço na
estação — **com uma diferença: ele pode aparecer em vários grupos**.

- **RF72** — O `LogPath` é ajustado **em todos os grupos do `scope.ini` onde aparecer**, para o
  diretório do serviço da estação, exatamente como o `ArqControlPath`.
- **RN65** — Chave de caminho que vale em qualquer seção **nunca é criada quando falta**. A tabela
  do RF34 cria a chave ausente porque sabe em qual seção ela mora — isso é conserto de arquivo de
  origem velho. Aqui não há seção declarada: escolher um grupo por conta própria mudaria o
  comportamento do Scope. **Ausência é o caso normal** enquanto o parâmetro não existir.
- **RN66** — O ajuste dessas chaves é **registrado no log com o nome do grupo**. Nas chaves de seção
  fixa isso seria ruído — elas estão declaradas na tabela. Aqui o grupo não é conhecido de antemão,
  e saber **em qual** grupo o caminho foi trocado é a única forma de o suporte conferir o resultado.

**Critério de aceitação:**

25. `scope.ini` com `LogPath` em três grupos diferentes: os três são apontados para o diretório
    da estação, preservando o espaçamento em volta do `=`, sem tocar em `LogPath` comentado nem
    em chaves vizinhas. E um `scope.ini` **sem** `LogPath` volta idêntico, sem a chave ser
    acrescentada.
### 13.21 Remoção da instrumentação `TefCitelAutcomTeftra.log` (2026-09-21)

Instrumentação temporária criada em 31/08–02/09 para uma trava intermitente numa venda com 2+
cartões, presa no último cartão sem gerar o TEFTRA. A suspeita era `fRetAutoIncrem('TEFTRA', ...)`
segurando lock de banco. **Não reproduziu**, e o próprio comentário dela já dizia: *"Remover quando
a causa raiz for confirmada e corrigida"*.

- **RF73** — A `pLogaDiagnosticoTeftra` e as 13 chamadas dela saem do
  `untTefCitelUtil.pas`. O arquivo `%TEMP%\TefCitelAutcomTeftra.log` deixa de ser gerado.

**O que isso encerra, e o que não:** encerra a instrumentação. **A causa raiz da trava de 31/08
continua sem confirmação** — ela nunca reproduziu depois de 02/09. Se voltar, a evidência terá de
ser montada de novo; o histórico está no `record.md` daquela data.
### 13.22 O `.ini` da estação é o da loja com os caminhos corrigidos, e nada mais (2026-09-22)

Em campo, comparando origem e destino lado a lado pela primeira vez, apareceu no
`scope.ini` da estação uma `ArqTracePath=C:\TEF_Citel` que **não existe** no arquivo da loja.

Não era regressão: era o **RF34** funcionando como escrito desde a Fase 6 — chave de caminho
declarada na tabela e ausente no arquivo era **acrescentada**, com a justificativa de que ausência
é "sintoma de arquivo de origem velho". O log anunciou, como projetado.

**O problema é de coerência.** A **RN65**, escrita para o `LogPath` em 21/09, diz o oposto:
chave de caminho **nunca** é criada, porque "inventar um grupo mudaria o comportamento do Scope por
conta própria". O que separava as duas regras era só a chave ter ou não seção declarada — critério
de implementação da tabela, não razão de negócio.

- **RF34 (revisto)** — Chave de caminho declarada e **ausente** no arquivo de origem **não é mais
  acrescentada**. O ajuste reescreve o valor **onde a chave aparece**, em qualquer pacote.
- **RN65 (generalizada)** — **O `.ini` da estação é o `.ini` da loja com os caminhos
  corrigidos, e nada mais.** O que a loja não declarou, a estação não ganha. Se o Scope precisa de
  uma chave, quem decide isso é o arquivo de origem, no diretório do `autcom.exe` — que é onde o
  suporte já mexe.
- **RN67** — **O aviso permanece.** Chave declarada e ausente continua sendo sintoma de arquivo de
  origem velho, e isso era metade do valor do código antigo. Agora o log diz que a chave não existe
  e **que não foi acrescentada**, apontando o arquivo de origem como o lugar de corrigir.

**Critério de aceitação:**

26. O `scope.ini` que chega à estação difere do da loja **apenas** nas linhas de caminho, com o
    **mesmo número de linhas**. Nenhuma chave e nenhuma seção acrescentadas.

### 13.23 Lista consolidada dos critérios de aceitação — entrega para os testes

**Esta é a lista única.** Os critérios nasceram espalhados por dez seções, na ordem em que os temas
apareceram, e três foram reescritos no caminho. Aqui estão todos, com **o estado real de cada um**
em 2026-09-22 e o ponto onde o contrato está descrito.

Pelo CLAUDE.md, o entregável de quem implementa é **o contrato e a lista de casos a cobrir** — os
casos de teste são escritos pelo analista. É isto que esta seção entrega.

**Legenda.** **OK** = exercitado em campo, com evidência em log. **PARCIAL** = parte foi
exercitada, e a coluna diz o que falta. **PENDENTE** = nunca exercitado. **REVISTO** = o critério
mudou de conteúdo; a linha explica.

#### Instalação

| # | Critério | §  | Estado |
|---|---|---|---|
| 1 | Máquina limpa: `TefEstacaoService` **rodando**, start automático, recuperação configurada, e **uma** bitness de cada plug-in na pasta | 13.4 | **OK** |
| 2 | Reconectada a sessão RDP, o AUTCOM com `CFG_TEFDVC='S'` **abre o canal** e o TEF carrega | 13.4 | **OK** — `fConfiguraTefCitel retornou 0` |
| 3 | Na mesma carga, DLLs do Scope/CliSiTef e os três `.ini` chegam pela Fase 6 e o serviço reinicia uma vez, **sem intervenção** | 13.4 | **OK** |
| 5 | Instalação elevada com **credencial de outro administrador**: a chave nasce no hive do usuário da sessão interativa, não no de quem elevou | 13.4 | **PENDENTE** — nunca exercitado. É o modo de falha mais caro do instalador, porque **parece sucesso** |
| 6 | Reinstalação sobre instalação existente com o serviço **rodando**: para, espera o processo sair, sobrescreve e sobe | 13.4 | **OK** |
| 7 | Máquina com **TSPlus**: o assistente propõe **Win32** com o motivo na tela, e a chave aponta para a DLL de 32 bits | 13.4 | **PENDENTE** — nenhuma máquina de teste tinha TSPlus |
| 10 | `instalacao.log` na pasta ao fim de uma instalação bem-sucedida **e** de uma abortada, com o motivo legível | 13.4 | **OK** — a instalação abortada de 21/09 17:34 gerou log com o motivo |
| 18 | Reinstalar por cima **sem nenhum diálogo de erro**, e o `binPath` do SCM apontando para a pasta desta instalação | 13.11 | **PARCIAL** — o diálogo sumiu; o `binPath` nunca foi conferido |

#### Cobertura de usuários

| # | Critério | §  | Estado |
|---|---|---|---|
| 4 | **Usuário N:** instalar como A, **logar como N**, conferir a chave no `HKCU` **dele**, abrir o RDP pelo atalho e **passar um cartão** | 13.4 | **OK** — 21/09, `gislene.nemoto`, com cartão |
| 23 | No logon do usuário N o plug-in é registrado **sem nenhuma janela piscando**, e a tarefa mostra `LastTaskResult = 0` | 13.15 | **PARCIAL** — a chave foi provada; **a ausência da janela não foi observada nem reportada** |

#### Antivírus e Defender

| # | Critério | §  | Estado |
|---|---|---|---|
| 8 | Máquina **sem Defender** ou com PowerShell ausente: a exclusão falha, o log registra, e a instalação **termina com sucesso** | 13.4 | **OK** — Bitdefender corporativo, 21/09 |
| — | Estação com AV de terceiro: a tela final **nomeia o antivírus** e manda pedir a exclusão à infra | 13.16 | **OK** — `Bitdefender Endpoint Security Tools Anti-malware` |

#### Assinatura digital

| # | Critério | §  | Estado |
|---|---|---|---|
| 11 | `build-setup.cmd` **sem** `CITEL_ASSINA_SENHA`: para com mensagem clara e **não** gera instalador | 13.9 | **PENDENTE** — o teste que fiz estava errado (o `set VAR=` do CMD gravava um espaço), então o guarda nunca foi de fato exercitado |
| 12 | Com a senha correta: os seis binários, o desinstalador e o `setup.exe` saem assinados; o `borlndmm.dll` mantém a assinatura da Embarcadero | 13.9 | **OK** |
| 13 | **REVISTO** — o `setup.exe` tem assinatura **SHA-256 com carimbo de tempo válido**; o `signtool verify /pa` para na cadeia por ela ser **autoassinada** | 13.14 | **OK** na forma revista |
| 14 | **REVISTO** — **"Editor desconhecido" no UAC é o comportamento ESPERADO** enquanto valer a opção 3. **Não é defeito e não deve ser reportado como tal** | 13.14 | **N/A por decisão** |

#### Atualização e auto-reparação

| # | Critério | §  | Estado |
|---|---|---|---|
| 15 | Estação **sem** `libTefCitel.dll` na pasta: o `fAtuConsulta` responde, a Fase 6 entrega a DLL e o TEF sobe na mesma carga | 13.10 | **OK** |
| 16 | Estação limpa com o instalador completo: o TEF sobe **sem nenhuma** linha de `External exception C06D007E` | 13.10 | **OK** |
| 17 | Reinstalar sobre estação que já recebeu a DLL pela Fase 6: o `onlyifdoesntexist` **não** substitui a que está lá | 13.10 | **PENDENTE** |
| 22 | Apagar o `libTefCitel.dll` e subir o AUTCOM: a carga reenvia, aplica e o TEF sobe — **sem reinstalar**. O log traz `consta como aplicado, mas ... NAO esta no disco` | 13.13 | **OK** — reparação completa em 12 s |
| 25 | `scope.ini` com `LogPath` em três grupos: os três apontados, espaçamento preservado, `LogPath` comentado intacto. E um `scope.ini` **sem** a tag volta **idêntico** | 13.20 | **OK** — campo + banco de teste |
| 26 | O `scope.ini` que chega à estação difere do da loja **apenas** nas linhas de caminho, com o **mesmo número de linhas** | 13.22 | **OK** |

#### Diagnóstico e mensagens ao operador

| # | Critério | §  | Estado |
|---|---|---|---|
| 19 | Com TEF DVC, clicar em **"Ver libTefCitelErro.log"**: o conteúdo é o **da estação** e confere com o arquivo da pasta do serviço | 13.11 | **OK** |
| 20 | Mesmo caso com o serviço da estação **parado**: mensagem dizendo que o arquivo fica na estação, **sem madExcept** | 13.11 | **PENDENTE** |
| 21 | Estação sem comunicação com o servidor do TEF: durante a espera a tela mostra **"Aguarde, comunicando com o servidor TEF..."**, e não a mensagem da atualização | 13.12 | **OK** |
| 24 | Existe `<pasta do autcom>\TefLog\TefCitelDvcTransporte_<estação>.log`, com o nome da **máquina do operador** no sufixo. Com duas estações, dois arquivos | 13.19 | **PARCIAL** — um arquivo, com o nome certo da estação; **duas estações simultâneas não foram testadas** |

#### Desinstalação

| # | Critério | §  | Estado |
|---|---|---|---|
| 9 | Serviço removido, tarefa removida **antes** da chave, chaves do usuário interativo apagadas, e `TefEstacaoVersao.ini`, `.log`, `_Preparo` e `_Falhou` **continuam na pasta** | 13.4 | **PARCIAL** — serviço, chaves e arquivos conferidos. Faltam **a remoção da tarefa** e **`_Preparo`/`_Falhou`**, porque o coletor rodou sem elevação |

---

#### Resumo honesto para quem vai testar

**19 de 26 exercitados em campo.** O que falta, em ordem do que eu testaria primeiro:

1. **#5 — instalação elevada por outro administrador.** É o modo de falha mais caro que o
   instalador tem, porque **parece sucesso**: a chave nasce no hive errado, sem erro nenhum, e o
   TEF só não sobe depois de reconectar.
2. **#9 e #23 — os dois pedaços que dependem de rodar o coletor elevado** e de olhar a tela no
   instante do logon.
3. **#20 — a degradação com o serviço parado.** É o caminho que existe justamente para o operador
   não ver um madExcept.
4. **#7 e #17** — dependem de ambiente (TSPlus) e de sequência específica.
5. **#11** — o guarda da senha; meu teste anterior estava errado e não vale.

**Nenhum dos pendentes é bloqueante para começar os testes** — são casos que não apareceram nas
baterias de desenvolvimento, não defeitos conhecidos.
