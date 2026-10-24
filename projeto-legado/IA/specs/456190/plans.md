# Plano de Execução — Req. 456190

**Referência:** specs.md
**Zona:** Legado

## 1. Abordagem técnica

**Descoberta central que define a abordagem:** o código já é interface-based no ponto exato onde o requisito precisa agir. `TTefCitelNCR` e `TTefCitel` (`libTefCitel\untTefCitelNCR.pas`/`untTefCitel.pas`) implementam `ITefCitel`, `ISubjectTEFCitel` e `ITefCitelV2` (`untInterfaceTefCitel.pas`), e são instanciadas por uma única função fábrica:

```pascal
// libTefCitel\untFuncoesLibTefCitel.pas
function fCriarTefCitel(const AstrPath, AstrOpcao: String): ITefCitel; stdcall;
begin
  if AstrOpcao = OPCAO_CLISITEF then Result := TTefCitel.Create
  else if AstrOpcao = OPCAO_NCR then Result := TTefCitelNCR.Create ;
  Result.pSetPath(AstrPath);
end;
```

Tudo acima dessa fábrica (`untTefCitelTransacaoFactory.pas`, `untTefCitelOperacoes.pas`, `untTObserverTefAdapter.pas`, `untTefModalidadeImpl.pas` — inclusive toda a lógica de Banrisul/parcelamento) só enxerga `ITefCitel`/`ISubjectTEFCitel`, nunca o tipo concreto. Isso permite a substituição pedida — "AUTCOM continua chamando as mesmas funções da interface e usando o mesmo observer" — sem tocar em nenhuma dessas camadas.

**Lado servidor (AUTCOM — alteração mínima, concentrada no external `libTefCitel`):**
1. Nova classe `TTefCitelDvc` (`libTefCitel\untTefCitelDvc.pas`), implementando as três mesmas interfaces (`ITefCitel`, `ISubjectTEFCitel`, `ITefCitelV2`). Cada método (`fPassarCartao`, `fFinalizarTransacao`, `pInfo21`, `pInfo30`, `pinfo34`, `pInfo30DebitoPreDatado`, `pInfo30DebitoParcelado`, `pInfo30DebitoCredito1Minuto`, `fCancelaTransacaoTerminal`, `fReimpressao`, `pSair`, `fObtemDadoPinPadDireto`, `pSetPath`, `fVerificaPresencaPinPad`, `fObtemVersao`, `AddInfo`, `fInfoPixCadastro`, `pEnviarQrCode`, `pLimpaQrCode`, `fConfiguraTefCitel`, `fTraduzirErro`) é serializado e enviado como chamada RPC pela DVC para a estação, que executa contra a instância real. `fConsultaTransacoesPendentesTerminal` **não é usada pelo projeto** (confirmado pelo usuário) — implementar como `not supported`/stub, sem esforço de serialização de `TUniClientDataSet`.
2. Os callbacks `AntesPassarCartao`/`DepoisPassarCartao`/`DepoisFinalizarTransacao`/`AntesCancelarTransacao`/`DepoisCancelarTransacao`/`AntesReimpressao`/`DepoisReimpressao`/`SucessoTefCartao` (ponteiros `of object`) ficam armazenados localmente em `TTefCitelDvc`, exatamente como hoje em `TTefCitelNCR`/`TTefCitel` — nunca trafegam pela rede. Quando a instância real (rodando na estação) precisa invocá-los, envia um "sinal de hook" pela DVC (ex.: `hook_antes_passar_cartao`) e aguarda a resposta síncrona (o booleano de retorno) antes de prosseguir.
3. O mecanismo de Observer (`ISubjectTEFCitel.NotificaObservers`) é replicado: a instância real na estação notifica um observer local que serializa `AtualizaTefCitel(Resposta: IRetornoTEFCitel)` pela DVC; `TTefCitelDvc` recebe e repassa aos observers registrados no lado AUTCOM (o mesmo `untTObserverTefAdapter.pas` de sempre).
4. **Único ponto de decisão:** `fCriarTefCitel` ganha um novo branch — quando `CFG_TEFDVC = S`, retorna `TTefCitelDvc.Create` independente de `AstrOpcao` (NCR/CliSiTef); esse valor viaja dentro do payload RPC para a estação saber qual `ITefCitel` real instanciar lá (reaproveitando a própria `fCriarTefCitel`, já compartilhada). Quando `CFG_TEFDVC = N`, comportamento idêntico ao atual (RN05).
5. Atualização de DLL (RF10): `untTefCitelDvcAtualizacao.pas` (external), executado no startup do AUTCOM, calcula hash de `scope.zip`/`sitef.zip` (diretório do `autcom.exe`), compara com a versão informada pela estação via DVC, e transmite o `.zip` em base64 fragmentado se diferente.

**Lado estação (novo):**
1. Plugin DVC cliente (COM DLL, `IWTSPlugin`), adaptado de `DVC/src/client/TefDvcPluginImpl.pas`, carregado pelo client RDP (mstsc/TSPlus) na estação. É **thin**: só repassa bytes entre o canal DVC e um named pipe local.
2. Novo Windows Service (`Vcl.SvcMgr`, gerenciado pelo SCM, ciclo de vida independente da sessão RDP) que:
   - Escuta o named pipe local para chamadas RPC vindas do AUTCOM.
   - Um **roteador de mensagens**: para cada chamada, resolve/cria a instância real (`TTefCitelNCR`/`TTefCitel`) via a **mesma `fCriarTefCitel`** (reaproveitada do external, sem duplicar lógica de escolha NCR/CliSiTef), invoca o método pedido, e devolve o resultado.
   - Registra um observer local na instância real que serializa cada `AtualizaTefCitel` e envia pela DVC de volta ao AUTCOM.
   - Responde aos "sinais de hook" (`AntesPassarCartao`, etc.) perguntando ao AUTCOM em tempo real quando a instância real precisa desses callbacks.
   - Toda a lógica de negócio (Banrisul, parcelamento, laço de polling de 200ms contra `ScopeStatus`/`ContinuaFuncaoSiTefInterativo`) roda **localmente aqui**, contra a DLL física real — só as transições de estado relevantes (pedido de modalidade, parcelas, valor, finalização) cruzam a rede; o polling em si não.
   - Mantém fila local em arquivo para o caso de queda de canal — reenvia quando o DVC reconectar (RF07/RN03), sem acesso direto ao MySQL.
   - Recebe e aplica atualizações de DLL (RF10/RF11), com trava para não interromper transação ativa e reinício/recarga pós-update.
3. Scripts de registro do plugin (regsvr32/HKCU, base `DVC/register-client.ps1`) + instalação do serviço via SCM — dentro do escopo do requisito.

**Unificação via SVN external (RF09) — já concluída para esta versão:**
- `^/libTefCitel → libTefCitel/` (raiz), no mesmo padrão do `^/PinPad → PinPad/`.
- Contém: todas as units hoje movidas (`untTefCitelNCR.pas`, `untTefCitel.pas`, `untScopeNCR.pas`, `untInterfaceTefCitel.pas`, `untFuncoesLibTefCitel.pas`, etc. — **sem alteração de lógica**), mais a nova `TTefCitelDvc`, o transporte DVC, o serviço Windows da estação e o plugin cliente.
- **Não entra no external:** `fontes\tef\TefCitel\` (UI, fábrica de modalidade, Observer, regras Banrisul de menu) e o registro do parâmetro `CFG_TEFDVC` — permanecem locais a cada versão do AUTCOM.
- Extensão do external às demais versões (74.111, 72, …) é sequencial, após a conclusão desta (decisão do usuário, 2026-08-19).

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|---|---|---|
| `libTefCitel` (todo o conteúdo atual) | `libTefCitel\` (raiz, external) | já movido (Fase 0, 2026-08-19) — sem alteração de lógica |
| Nova implementação `ITefCitel` via DVC | `libTefCitel\untTefCitelDvc.pas` | criar |
| Transporte DVC (framing/JSON) | `libTefCitel\untTefCitelDvcTransporte.pas` | criar |
| Fábrica de instância `ITefCitel` | `libTefCitel\untFuncoesLibTefCitel.pas` | alterar (1 branch novo: `CFG_TEFDVC = S` → `TTefCitelDvc.Create`) |
| Atualização remota de DLL (lado AUTCOM) | `libTefCitel\untTefCitelDvcAtualizacao.pas` | criar |
| Serviço Windows da estação (host + roteador de mensagens) | `libTefCitel\Estacao\TefEstacaoService.dpr` | criar |
| Roteador de mensagens / instanciação da `ITefCitel` real | `libTefCitel\Estacao\untTefEstacaoRoteadorMensagens.pas` | criar |
| Atualização de DLL (lado estação) | `libTefCitel\Estacao\untTefEstacaoAtualizacaoDll.pas` | criar |
| Plugin cliente DVC | `libTefCitel\Estacao\ClientPlugin\*.pas` | criar (adaptado de `DVC/src/client`) |
| Scripts de instalação | `libTefCitel\Estacao\install\*.ps1` | criar (adaptado de `DVC/*.ps1`) |
| Registro de parâmetro de sistema | `fontes\configuracoes\untCfgRepositorio.pas` | alterar (`CFG_TEFDVC`) |
| `fontes\tef\TefCitel\untTefCitelTransacaoFactory.pas`, `untTefCitelOperacoes.pas`, `untTObserverTefAdapter.pas`, `untTefModalidadeImpl.pas` | — | **sem alteração** — só enxergam `ITefCitel`/`ISubjectTEFCitel` |
| `libTefCitel\untTefCitelNCR.pas`, `untTefCitel.pas` | — | **sem alteração** — rodam fisicamente no serviço da estação, contra a DLL real |
| Projeto AUTCOM | `padra_atualizado\autcom.dproj` | já ajustado (Fase 0) — search path `..\libTefCitel` |
| Grupo de build | `padra_atualizado\autcom.groupproj` | alterar (avaliar incluir `TefEstacaoService`/plugin no build agrupado, como já ocorre com Monitors) |

## 3. Sequência de implementação

1. Definir o protocolo RPC sobre DVC: envelope `{v, id, tipo, dados}`, com `tipo` em `rpc_chamada`/`rpc_resposta` (um por método de `ITefCitel`/`ITefCitelV2`), `rpc_evento` (Observer — `AtualizaTefCitel`) e `rpc_hook` (callbacks `Antes*`/`Depois*`, estação → AUTCOM, síncrono).
2. Portar o transporte DVC (framing por tamanho + JSON) do protótipo `DVC/` para `libTefCitel\untTefCitelDvcTransporte.pas`, sem lógica de negócio.
3. Implementar `TTefCitelDvc` (`libTefCitel\untTefCitelDvc.pas`) — implementação de `ITefCitel`/`ISubjectTEFCitel`/`ITefCitelV2` que serializa cada método como chamada RPC; armazena callbacks `Antes*`/`Depois*` localmente; mantém lista de Observers local.
4. Adicionar branch em `untFuncoesLibTefCitel.fCriarTefCitel`: `CFG_TEFDVC = S` → `TTefCitelDvc.Create`.
5. Adicionar `CFG_TEFDVC` em `untCfgRepositorio.pas` (grupo `LIBTEF`, default `N`).
6. Criar o Windows Service na estação (`TefEstacaoService.dpr`) com o roteador de mensagens (`untTefEstacaoRoteadorMensagens.pas`), que reaproveita a mesma `fCriarTefCitel` para instanciar `TTefCitelNCR`/`TTefCitel` reais e executar os métodos pedidos — sem duplicar lógica de negócio.
7. Implementar fila local de reenvio (RF07) e bootstrap de configuração (porta COM via DVC) no serviço da estação.
8. Adaptar/gerar o plugin cliente DVC (COM) a partir do protótipo `DVC/`, com IPC (named pipe) para o serviço.
9. Scripts de instalação (registro do plugin + instalação do serviço).
10. Validação manual fim a fim — Scope/NCR, SiTef Express, Pix e o fluxo Banrisul (débito com sub-wizard de modalidade), com `CFG_TEFDVC = S` e `= N`.
11. Implementar verificação de hash/versão + protocolo de fragmentação base64 sobre o canal DVC (RF10).
12. Implementar recepção/extração/versionamento no serviço da estação, com trava para não interromper transação em andamento (RF11) e reinício pós-update.
13. Teste manual: simular troca de `.zip` no diretório do AUTCOM e validar atualização ponta a ponta sem impacto em transação ativa.
14. Rollout controlado, com fallback por terminal via `CFG_TEFDVC`.

## 4. Conformidade com padrões do projeto

- Zona Legado: Hungarian style obrigatório em todo o código novo (`libTefCitel`, serviço da estação); prefixo `unt` em units; sem interfaces obrigatórias fora do que já existe (`IObserverTEFCitel`, `IWTSPlugin`).
- SQL: `ParamByName()` em qualquer acesso a `TEFCFG`/config; nenhuma concatenação de string.
- `fNow()` em qualquer gravação (fila local de reenvio, log de atualização de DLL) — exceção de TTL de cache em memória não se aplica aqui, pois há persistência em arquivo.
- Sem `TButton`/`TBitBtn`/`TDBGrid`/`TClientDataSet` em qualquer tela nova ou alterada.
- `.SetFocus` direto proibido — usar `pSetFocus`; `Application.CreateForm` proibido — usar `pCriarForm`/`pCriarFormularios` (já usado por `fChamaTelaDeOperacoes`).
- Edição do `.dproj` do AUTCOM limitada à opção de search path (compilador) — nunca para alterar o conjunto de units, que segue via `.dpr`.
- Pre-commit: sem `FOREIGN_KEY_CHECKS`, sem `FillType`/`Outline` em `.dfm` novos/alterados.

## 5. Estratégia de testes

- Zona Legado — **sem infraestrutura de teste automatizado**. Não propor TDD nem teste-primeiro.
- Entregável do implementador: contrato do protocolo DVC (comando/status/atualização) + lista de casos a cobrir (= critérios de aceitação de specs.md, seção 6).
- Validação por roteiro manual com pinpad físico, cobrindo:
  - As duas modalidades (Scope/NCR e SiTef Express) com `CFG_TEFDVC = S` e `= N`.
  - Fluxo Pix via PinPad.
  - Queda de canal DVC durante transação em andamento.
  - Atualização remota de DLL (com e sem transação ativa).

## 6. Riscos e mitigação

| Risco | Mitigação |
|---|---|
| Decisão de infraestrutura (GPO UDP) fora do controle do código | Acompanhar decisão da diretoria; `CFG_TEFDVC` permite adiar ativação até infraestrutura estar pronta |
| ~~`CliSiTef32I.dll` é componente de terceiro — possível restrição de licenciamento/homologação para rodar fora do processo AUTCOM~~ | **Descartado** (2026-08-19): a arquitetura equivale a rodar o TEF em um `autcom.exe` na máquina local, mesmo modelo já usado por clientes sem TS/RDP — não há mudança de contexto de licenciamento da DLL |
| Necessário hardware real (pinpad) em homologação, sem mock possível | Planejar janela de teste com equipamento físico antes do rollout |
| Duas modalidades + Pix aumentam a superfície de teste manual | Roteiro de teste único cobrindo as três combinações, executado a cada ciclo de homologação |
| Canal DVC sem autenticação/autorização nos protótipos atuais | Adicionar validação mínima (ex.: token/whitelist de estação) antes de expor em produção |
| Transferência de `.zip` binário pelo canal DVC (exceção à regra "só texto") | Fragmentação com checksum por fragmento; reenvio de fragmento corrompido sem reiniciar a transferência inteira |
| Reestruturação SVN afeta múltiplas versões do AUTCOM (74.111, 72) fora desta cópia de trabalho | Decisão (2026-08-19): as demais versões só serão ajustadas após a conclusão desta (379.48.2.30.74.150) — sequencial, não paralelo. `CFG_TEFDVC = S` não deve ser ativado em produção nas outras versões antes desse ajuste |
| **Antivírus/EDR das estações quarentena `TefEstacaoService.exe`/`TefCitelDvcPlugin.dll`** — confirmado em teste manual (2026-08-20, Rafael): executável novo sem assinatura digital, se registrando como serviço Windows, foi excluído pelo AV da máquina de teste (padrão clássico de heurística de EPP, não bug do serviço). **Produto identificado nesta sessão: Bitdefender Endpoint Security Tools** (Windows Defender confirmado em `AMRunningMode: Not running` — passivo, cedendo lugar ao Bitdefender; `Get-WinEvent` do log do Defender veio vazio, não é ele). Mesmo produto que já havia aparecido na investigação anterior do canal DVC (removido de uma estação de teste na época). Provável em qualquer estação de produção com Bitdefender corporativo na primeira instalação | Curto prazo (por estação/teste): restaurar da quarentena no console do Bitdefender (GravityZone Control Center, se gerenciado centralmente) + exclusão de política para a pasta de instalação — **não só antimalware clássico**: se o GravityZone tiver HyperDetect/Advanced Threat Control (camada comportamental), precisa de exclusão separada, já que "executável novo se registrando como serviço" é o tipo de padrão que ATC costuma pegar mesmo com exclusão de assinatura feita. Rollout: (1) assinatura de código (code signing) do `.exe`/`.dll` no build de produção; (2) exclusão de política Bitdefender coordenada com o time de infraestrutura para a pasta de instalação em todas as estações — mesmo tipo de coordenação corporativa já pendente para o GPO de UDP do RDP Shortpath. **Evidência coletada (2026-08-20)**: console local do Bitdefender Endpoint Security Tools (aba Quarentena) mostra 3 quarentenas sucessivas do mesmo arquivo (`C:\TEF_Citel\TefEstacaoService.exe`, 11:42/14:31/14:50), detecção `Gen:Illusion.Slingshot.PowerShell.@V0@ae3IEM@U.10.2010101` — prefixo `Gen:` = heurística/comportamental, não assinatura de malware conhecido; reforça a hipótese de falso positivo pelo padrão "executável novo se registrando como serviço via SCM". UI local restrita a Sumário/Eventos/Quarentena (sem aba de Exclusões) confirma agente gerenciado centralmente via GravityZone — exclusão só é possível pela política central, não localmente. **Em aberto (2026-08-20):** Rafael vai solicitar à infra a exclusão (caminho + nome da detecção acima), incluindo camada HyperDetect/ATC se separada |

## 7. Redesenho da comunicação plugin↔estação: processo relay de sessão (2026-08-27)

> **SUPERADO em 2026-08-28** — o processo relay de sessão descrito nesta seção foi implementado, testado, e depois **removido**: o hop relay→`TefEstacaoService.exe` (named pipe `TefCitelCh`) sofreu exatamente a mesma trava sem fim que esta seção documenta para o hop antigo plugin→serviço, provando que o problema é do named pipe em si, não de cruzar sessão. Arquitetura final (Rafael, 2026-08-28): plugin conecta **direto** em `TefEstacaoService.exe` via socket TCP loopback — sem relay, sem named pipe nenhum nessa cadeia. Ver `tasks.md`, seção "DECISÃO FINAL DE ARQUITETURA (Rafael, 2026-08-28)" para o raciocínio completo. Esta seção 7 fica só como registro histórico de uma etapa intermediária da investigação — **não descreve a arquitetura atual**.

**Achado que motiva esta mudança** (trilha completa da investigação em `tasks.md`, seção "Retomado em 2026-08-24" em diante): a escrita/leitura no pipe local `TefCitelCh`, entre o plugin (`TefCitelDvcPlugin.dll`, roda dentro do `mstsc.exe`) e o `TefEstacaoService.exe` (Windows Service, sessão 0/LocalSystem), trava de forma genuína e recorrente (minutos, sem teto observado). Eliminado sistematicamente, um por um, com evidência de campo: nossas próprias threads (`FthrEscritaWorker`) vs. a thread de callback nativa do canal DVC (ambas travam igual — não é "de quem é a thread"); Bitdefender, Windows Defender, sensor MDE, USB Redirector TS, RDP Shortpath/UDP (todos descartados, trava idêntica sem eles). Três testes controlados triangularam a causa:

| Cliente | Servidor | Resultado |
|---|---|---|
| Processo externo qualquer (testado com PowerShell) | `TefEstacaoService.exe` (sessão 0/LocalSystem) | Rápido (dezenas de ms) |
| `mstsc.exe` | pipe anônimo/nomeado, mesma sessão (sem sessão 0) | Rápido (0 ms) |
| `mstsc.exe` | `TefEstacaoService.exe` (sessão 0/LocalSystem) | Trava (minutos, sempre) |

Nenhum fator isolado explica — só a combinação exata "`mstsc.exe` como cliente, cruzando pra sessão 0" trava. Causa raiz exata (por que o `mstsc.exe` especificamente sofre isso) não identificada — provavelmente algo interno do framework de canal DVC/RDP do Windows nessa combinação, fora do nosso controle. Memória compartilhada foi cogitada e descartada (ver `tasks.md`) — a sincronização cross-sessão exigiria os mesmos objetos `Global\` (Event/Mutex) sujeitos, em princípio, à mesma categoria de travamento, além de superfície de segurança maior (parsing manual de buffer bruto em vez de framing já validado).

**Desenho proposto:** um processo auxiliar novo — **relay de sessão** (nome de trabalho: `TefCitelDvcRelay.exe`) — rodando na **mesma sessão interativa** do `mstsc.exe` (não como serviço), fazendo ponte entre o plugin e o `TefEstacaoService.exe`:

```
autcom.exe --(canal DVC)--> TefCitelDvcPlugin.dll (dentro do mstsc.exe)
                                    |
                          (pipe NOVO, mesma sessao — rapido, ja provado)
                                    v
                          TefCitelDvcRelay.exe (processo comum, mesma sessao)
                                    |
                     (pipe TefCitelCh, cruza p/ sessao 0 — rapido quando
                      NAO e o mstsc.exe do lado cliente, ja provado)
                                    v
                          TefEstacaoService.exe (sessao 0/LocalSystem)
```

Dois saltos, cada um comprovado rápido pelos próprios testes desta investigação — nenhum salto novo, não testado.

**Pontos do desenho, para revisão do Rafael antes de implementar:**

1. **`TefEstacaoService.exe` não muda nada** — continua servindo `TefCitelCh` exatamente como hoje; do ponto de vista dele, o relay é só mais um cliente comum (o mesmo papel que o plugin tinha antes).
2. **Nome do pipe novo** (plugin ↔ relay, mesma sessão): proposta `\\.\pipe\TefCitelChRelay` — a decidir.
3. **Como o relay inicia** — duas opções, com recomendação:
   - **(a) Recomendada: o próprio plugin inicia o relay sob demanda.** Ao conectar (`OnNewChannelConnection`), o plugin tenta abrir `TefCitelChRelay`; se não existir (`ERROR_FILE_NOT_FOUND`), sobe o `TefCitelDvcRelay.exe` via `CreateProcess` (mesma sessão do `mstsc.exe` — criar processo na própria sessão é uma operação comum, não tem relação com o problema que estamos evitando) e tenta de novo. O relay, uma vez de pé, continua rodando independente do ciclo de vida de uma conexão específica (não é filho preso ao `mstsc.exe` — sobrevive a reconexões do canal DVC). Vantagem: **não precisa de item de instalação extra** — mantém a pasta única flat já estabelecida para o pacote da estação (ver `install-service.ps1`/`register-plugin.ps1`), sem Tarefa Agendada nem chave de Registro pra configurar em cada estação.
   - **(b) Alternativa: Tarefa Agendada disparada "ao fazer logon".** Mecanismo padrão do Windows pra isso, mas exige mais um item de instalação/configuração por estação (script de registro da tarefa, mais uma coisa pra desinstalar depois).

   **Decidido (2026-08-27, Rafael): opção (a).** O plugin inicia o relay sob demanda via `CreateProcess`, sem item de instalação adicional.
4. **Design interno do relay** — reaproveitar padrões já existentes no projeto em vez de inventar:
   - Lado servidor (aceita o plugin em `TefCitelChRelay`): mesmo formato de `untTefEstacaoPipeTransporte.pas` (`TTefEstacaoPipeTransporte`) — loop de aceitar conexão, sem framing extra (relay puro de bytes, o framing por tamanho já viaja dentro dos bytes, montado/desmontado nas pontas reais, mesma lógica do plugin de hoje).
   - Lado cliente (conecta em `TefCitelCh` de verdade): dado que já temos evidência de que esse salto é rápido quando quem inicia **não** é o `mstsc.exe`, não precisa repetir toda a engenharia de "abandonar geração"/worker dedicado feita para o plugin — um cliente síncrono simples deve bastar aqui. A decidir se reaproveita mesmo assim por consistência ou simplifica.
5. **Escopo do plugin dentro do `mstsc.exe` diminui**: ele deixa de falar com `TefCitelCh` diretamente — passa a falar só com `TefCitelChRelay` (mesma sessão, já provado rápido). Boa parte do `FthrEscritaWorker`/lógica de geração abandonada pode ser simplificada ou até removida, já que o cenário que a motivou (escrita presa por minutos) deixa de acontecer nesse novo salto — a avaliar durante a implementação, sem pressa de decidir agora.

**Ainda não implementado.** Abre trabalho de código novo (unit(s) do relay, `.dpr`, ajuste no plugin pra apontar pro pipe novo e subir o relay sob demanda) — tratar como grupo novo de tarefas no `tasks.md` quando o desenho acima estiver validado.

---

## 8. Vários AUTCOM na mesma estação, um pinpad só — plano técnico (2026-09-03)

Contrato: `specs.md`, seção 9. Backup byte-a-byte do estado anterior em
`c:\Users\rafael.bizio\Documents\Autpas\_backup_456190_2026-09-03\` (revisão base 490909, com
`_sha256.txt` para conferência de encoding).

### 8.1 Abordagem escolhida e alternativas descartadas

**Escolhida — multi-conexão no serviço + uma instância `ITefCitel` por PID + serialização do
pinpad.** A identidade do AUTCOM viaja no `contexto`; cada PID tem sua instância; o recurso disputado
passa a ser o pinpad físico, não a instância.

Descartadas, com motivo registrado para não serem retomadas por engano:

- **Preempção da conexão** (manter `listen(1)` e fechar a anterior quando chega uma nova). Com dois
  AUTCOM vivos, os dois canais reconectam em laço (`pLoopConectorELeitura`, retentativa a cada
  segundo, sem backoff) e ficam se derrubando. Só funcionaria com protocolo dentro do plugin, que por
  decisão de 2026-08-28 é relay burro de bytes dentro do `mstsc.exe`.
- **Canal DVC sob demanda no AUTCOM.** Mudaria o ciclo de vida de `objTefCitel`/`pIniciaTefCitel`
  (que hoje configura no login) e criaria abre/fecha de canal por transação.
- **Manter instância única com "posse" trocando de dono.** Era o desenho da primeira versão desta
  seção. Cai por P2 (`specs.md` 9.2): a configuração é global por processo, então uma instância só
  não isola empresas — e o `fFinalizarTransacao` de um AUTCOM cairia na transação de outro.
- **Destruir a instância na troca de PID.** Cai pela restrição de 9.3: os destrutores anulam os
  ponteiros globais das DLLs e cegam as outras instâncias. Agravante: com referência local forte no
  despacho, o `Destroy` pode acontecer atrasado e cair no meio da transação de outro AUTCOM.
  Substituído por orfanamento com coleta no ocioso (RF18).

### 8.2 Lado AUTCOM — `libTefCitel\untTefCitelDvc.pas`

- Campos `FdwPid`/`FdwSessao`, preenchidos no `Create` com `GetCurrentProcessId` e
  `ProcessIdToSessionId`.
- `fJsonContexto` passa a emitir `pid` e `sessao`. Como `contexto` já viaja em `pEnviaEnvelope`, os
  dois tipos que partem do AUTCOM (`chamada` e `hook_resposta`) ganham a identidade sem mais nada.
- Compatível para trás: uma estação em versão antiga ignora os campos novos.
- Nenhuma alteração no protocolo de quadro binário (v2) — só no JSON do payload.

### 8.3 Transporte da estação — `libTefCitel\Estacao\untTefEstacaoTcpTransporte.pas`

Todo o estado de protocolo por conexão está hoje em campos da classe do transporte. Extrair para uma
classe de conexão é o que viabiliza a multi-conexão:

**`TTefEstacaoConexao` (nova)** — recebe, migrados sem mudança de lógica: `FsckCliente`,
`FcsEscrita`, `FarrBuffer`, `FintProximoMessageId`, `FdwUltimoIdRecebido`, `FcsAcks`,
`FdictAcksPendentes`, `FarrPayloadFragmentado`, `FwProximoFragmentoEsperado`, `FblnConectado`, e os
métodos `pEnviaFrame`, `pEnviaUmFragmento`, `pEnviaFrameBruto`, `pEnviaAck`, `fMontaFrame`,
`pAcumulaBytesRecebidos`, `pExtraiFramesDisponiveis`, `pNotificaDesconexao`, mais o laço de leitura
(`pLoopLeitura`, extraído da metade interna do atual `pLoopServidor`). Campo novo `FdwPid`,
preenchido na **primeira chamada recebida** — no `accept()` a identidade ainda é desconhecida.

**`TTefEstacaoTcpTransporte`** — fica com `FsckOuvinte`, a thread de `accept()` (`pLoopAceitador`),
`FlstConexoes: TObjectList<TTefEstacaoConexao>` protegida por `FcsConexoes`, e `FblnParar`. `listen`
sobe de `1` para `8`. Cada `accept()` cria uma conexão e sobe a thread de leitura dela; ao sair do
laço, a conexão sai da lista e é liberada.

**Callbacks** ganham a conexão como primeiro parâmetro:

```pascal
TprocTefEstacaoFrameRecebido = procedure(AConexao: TTefEstacaoConexao; const AbytFrame: TBytes) of object;
TprocTefEstacaoConectado     = procedure(AConexao: TTefEstacaoConexao) of object;
TprocTefEstacaoDesconectado  = procedure(AConexao: TTefEstacaoConexao) of object;
```

Contadores de `messageId` e dedup continuam **por conexão** — que é o que o protocolo v2 já
pressupõe, porque o par do outro lado também reinicia a cada canal novo. O lock que cobre "atribuir
messageId + escrever" (corrida corrigida em 2026-09-02) passa a ser por conexão, o que preserva
exatamente a garantia: a ordem só precisa valer dentro de um mesmo socket.

**Regra do subsistema (`IA\rules\tef-dvc.md`):** nenhum timeout novo no caminho de uma chamada TEF.
`accept()` e as threads de leitura não têm teto; os tempos existentes continuam sendo o
`TEF_ESTACAO_ACK_TIMEOUT_MS` e o `TEF_ESTACAO_TIMEOUT_HOOK_MS`.

### 8.4 Roteador — `libTefCitel\Estacao\untTefEstacaoRoteadorMensagens.pas`

**Sessão por AUTCOM.** `FRealInstance`/`FstrOpcaoAtual`/`FstrPathAtual` saem; entra:

```pascal
TTefEstacaoSessaoAutcom = class
  FdwPid: DWORD;
  FConexao: TTefEstacaoConexao;
  FTefCitel: ITefCitel;
  FObserver: IObserverTEFCitel;
  FstrOpcao, FstrPath: String;
  FstrArgsConfig: String;            { impressao digital, RF20 }
  FrecUltimaConfig: ...;             { argumentos do ultimo fConfiguraTefCitel, para reaplicar }
  FblnTransacaoPendenteConfirmacao: Boolean;
  FblnPendenciaAbandonada: Boolean;  { RF19 }
end;

FcsSessoes: TCriticalSection;
FdictSessoes: TObjectDictionary<DWORD, TTefEstacaoSessaoAutcom>;
FlstOrfas: TList<ITefCitel>;         { RF18 }
```

**Estado do pinpad**, sob `FcsPinpad`:

```pascal
FdwPidPinpadEmVoo: DWORD;       { 0 = ocioso; substitui/complementa FblnTransacaoEmAndamento }
FstrConfigAplicada: String;     { impressao digital atualmente na DLL }
```

**Roteamento de saída (RF14).** `fConexaoDeSaida` consulta `FdictConexaoPorThread` pela thread
corrente e cai na conexão do dono do pinpad quando não houver despacho em curso. Aplicado a
`pEnviaEvento` e `pEnviaHook`. `pEnviaResposta`/`pEnviaRespostaErro`/`pEnviaOuEnfileira` passam a
receber a conexão **de origem da chamada**. O mapa thread→conexão funciona porque observer e hooks
`Antes*` são disparados pela instância nativa dentro da chamada, na mesma thread de despacho
(`pDespachaChamadaEmThreadPropria` já cria uma thread por chamada desde 2026-08-28).

**`pAtualizaContexto`** deixa de agir sobre uma instância global: passa a agir sobre a sessão do PID
da chamada. É o que elimina a contaminação de `AddInfo`/`pSetDadosAdicionaisTefTra` entre AUTCOM.

**`fAdquirePinpad(ASessao, AstrMetodo)`** implementa a sequência da RF17, sob `FcsPinpad`. Só é
chamada para os métodos que tocam o pinpad (lista na RF16). Registra tudo em log (RF22).

**`pOrfanaSessao(ASessao)`** (RF18, revisto em 2026-09-04): retira do `FdictSessoes` e move para
`FlstOrfas` — **sem** liberar. Chamada **só na desconexão**; sessão de AUTCOM vivo nunca é orfanada.
A coleta das órfãs acontece em `pColetaOrfasSeOcioso`, quando não há sessão ativa nem thread de
despacho.

**Referência local forte** em `fDespachaMetodo` e em todo `fMetodo*`: `LTefCitel := ASessao.FTefCitel`
no início, uso da local dali em diante. Com orfanamento isso deixa de ser proteção contra `Destroy`
prematuro e vira proteção contra a sessão sair do dicionário no meio da chamada — continua
necessário.

**Geração de observer**: cada sessão tem o seu; `pEnviaEvento` descarta evento de sessão que já saiu
do dicionário. Espelha a rede de segurança por geração que o lado AUTCOM ganhou em 2026-09-03.

### 8.5 Fila local — `libTefCitel\Estacao\untTefEstacaoFilaLocal.pas`

- `pEnviaOuEnfileira` grava `pidDestino` junto do envelope.
- `pReenviaFilaLocal` passa a receber a conexão e filtrar por PID. Deixa de ser chamada em
  `pOnConectado` (no `accept()` o PID ainda é desconhecido) e passa a ser disparada quando o PID da
  conexão fica conhecido, na primeira chamada.
- Itens de PID marcado como pendência abandonada são descartados com log e contagem (RF21).

### 8.6 Sequência de implementação

Ordem escolhida para manter o projeto compilável e verificável em cada passo:

1. `contexto.pid`/`sessao` no lado AUTCOM — isolado, compatível para trás.
2. Refactor do transporte extraindo `TTefEstacaoConexao`, **ainda com uma conexão só**: comportamento
   idêntico ao atual, verificável antes de mudar semântica.
3. `listen(8)` + `accept()` em laço + thread por conexão. **Validar em campo a premissa 9.7** (várias
   instâncias do mesmo canal DVC na mesma sessão) antes de seguir.
4. Mapa thread→conexão e roteamento de `resposta`/`evento`/`hook` (RF14).
5. Sessão por PID: `FdictSessoes`, `pAtualizaContexto` por sessão, instância por PID (RF15).
6. Serialização do pinpad: classificação dos métodos, `fAdquirePinpad`, impressão digital de
   configuração e skip (RF16/RF17/RF20). Nesta etapa ainda **sem** orfanamento — só log da decisão.
7. Orfanamento na desconexão com coleta no ocioso (RF18) e recusa por pendência de AUTCOM vivo
   (RF19). *Revisto em 2026-09-04: a marca de pendência abandonada foi removida — ver RF19.*
8. Fila local por PID (RF21).
9. Revisão, consolidação do log (RF22) e nova seção em `IA\rules\tef-dvc.md`.

### 8.7 Conformidade com padrões do projeto

Zona Legado (`libTefCitel`): Hungarian style, prefixos `F`/`A`/`p`/`f`, `try/finally` em todo objeto
alocado manualmente, nenhuma variável global de unit para estado mutável compartilhado no código
novo. Sem `TBitBtn`/`TDBGrid`/`StrToFloat`/`Now()` — nada disso cabe aqui (o serviço não tem UI).
Arquivos `.pas` em Windows-1252 + CRLF, conforme `.editorconfig`.

**Encoding (armadilha recorrente, ver `record.md`):** o hook `.claude/hooks/delphi-encoding.ps1` não
dispara na extensão VSCode. Depois de **cada** edição em `.pas`, escanear os bytes ≥ 0x80 e comparar
com o backup (`sha256sum -c _sha256.txt` na pasta de backup identifica o arquivo alterado). Correção
sempre via `ReadAllBytes`/`WriteAllBytes`, nunca via Edit.

### 8.8 Riscos e mitigação

| Risco | Mitigação |
|---|---|
| A premissa de várias instâncias do mesmo canal DVC na mesma sessão pode não valer | Validada isoladamente no Passo 3, antes de qualquer coisa depender dela |
| O refactor do transporte mexe em código que custou duas semanas de investigação | Passo 2 isolado, sem mudança de semântica, verificado antes de habilitar multi-conexão |
| Destrutor de instância nativa cegando as outras | Orfanamento com coleta só no ocioso (RF18); nenhuma `ITefCitel` é liberada enquanto houver sessão ativa |
| Órfãs acumulando memória | Objetos pequenos; coleta a cada momento em que o dicionário de sessões fica vazio; contagem no log |
| Custo de reconfiguração na alternância entre AUTCOM | Impressão digital (RF20): mesma empresa/terminal → skip; custo só quando a configuração muda de verdade, que é quando ela é obrigatória |
| Reintroduzir timeout artificial no caminho da chamada TEF | `IA\rules\tef-dvc.md` carregada antes de qualquer `WaitFor`; nenhum tempo novo neste escopo |
| Corromper acentuação de `.pas` por encoding | Backup com `_sha256.txt` + verificação de bytes altos após cada edição |
## 9. Estabilidade sob oscilação de comunicação — plano técnico (2026-09-09)

Contrato: `specs.md`, seção 10. Abordagem escolhida: **recuperação dentro da chamada original**
(alternativas descartadas em `specs.md` 10.8).

**Nada começa antes do spike de 10.7.** Se a reabertura do canal não funcionar no TSPlus real, este
plano inteiro é substituído pelo plano B.

### 9.1 Lado AUTCOM — `libTefCitel\untTefCitelDvcTransporte.pas`

O núcleo da fase. Hoje `pAbreCanal(AstrCanal)` é chamado uma única vez no construtor e o
`pLoopLeitura` faz `pNotificaDesconexao` + `Break` no primeiro erro real de leitura (`:695`).

- Guardar o nome do canal em campo (hoje só existe como parâmetro do construtor).
- Envolver o laço de leitura num **laço externo de reconexão**: abre → lê até erro real → fecha →
  intervalo de retentativa → reabre. Espelhar `pLoopConectorELeitura` do plugin
  (`Estacao\ClientPlugin\untTefCitelDvcPluginImpl.pas`), que já faz exatamente isso do outro lado do
  mesmo link — mesmo formato, mesma ausência de timeout artificial.
- `fEhErroDeTimeoutLeitura` continua distinguindo timeout de erro real; só o erro real entra no
  caminho de reconexão.
- Zerar por conexão o que é estado de protocolo (`FdwUltimoIdRecebido`, `FdictIdsAceitos`,
  `FqueIdsAceitos`, `FarrPayloadFragmentado`, `FwProximoFragmentoEsperado`, `FintProximoMessageId`),
  como já acontece hoje a cada canal novo — o par do lado estação também reinicia do zero por
  conexão.
- `pNotificaDesconexao` deixa de ser terminal: registra log, sinaliza "reconectando" e **não**
  dispara mais o caminho que mata as chamadas pendentes.

### 9.2 Lado AUTCOM — `libTefCitel\untTefCitelDvc.pas`

- `pOnDesconectado` **para de marcar `ErroCanal`** nas chamadas de `FdictChamadas`. Passa a registrar
  log e a notificar a tela. As chamadas seguem esperando no `fChamaRpc` (RF25).
- `fChamaRpc`: o `ErroCanal` deixa de ser o motivo normal de saída. Continuam existindo duas saídas —
  resposta recebida, e desistência explícita do operador (RF30). O bombeamento
  `CheckSynchronize`/`Application.ProcessMessages` da thread principal não muda: é ele que mantém a
  tela viva durante a espera e que faz a sonda de vivacidade ser respondida.
- **Identidade (RF23):** `fJsonContexto` (`:799`) ganha `inicioProcesso`, obtido uma vez no
  construtor via `GetProcessTimes(GetCurrentProcess, ...)`. `FdwPid` e `FdwSessao` continuam como
  estão.
- **Frame `reata` (RF26):** enviado como primeiro frame de cada conexão nova, disparado pelo
  transporte ao reconectar. Carrega `pid`, `inicioProcesso`, a identidade de instância do serviço
  que o AUTCOM viu por último e os ids de `FdictChamadas`. Ao receber a resposta:
  - `emVoo` / `naFila` → nada a fazer, a chamada continua esperando (o item da fila chega em seguida);
  - `desconhecido` → falha **aquela** chamada na hora, com motivo;
  - instância do serviço diferente da conhecida → falha todas as pendentes com
    *"o serviço da estação reiniciou"*, e sinaliza ao AUTCOM que o TEF precisa ser refeito (RF29).
- **Desistência do operador (RF30):** método novo para falhar as chamadas pendentes localmente, a ser
  acionado pela tela do TEF. Não envia nada à estação — a transação lá segue e vira pendência.

### 9.3 Estação — `libTefCitel\Estacao\untTefEstacaoRoteadorMensagens.pas`

- **Identidade na sessão (RF23/RF24):** `TTefEstacaoSessaoAutcom` ganha `FdwInicioProcesso`.
  `fGaranteSessao` passa a validar o par: `FdictSessoes` continua indexado por PID, mas
  `inicioProcesso` diferente significa processo novo — orfana a anterior e cria uma nova.
- **Sessão desanexada (RF24):** a sessão passa a saber sua conexão atual (ou `nil`).
  `pOnDesconectado` deixa de chamar `pOrfanaSessao`: apenas desanexa, mantendo o log e a liberação
  dos hooks daquela conexão com o default seguro (que continua igual, inclusive o filtro por conexão
  de 2026-09-04).
- **Id em voo (RF26):** a sessão passa a guardar o `id` da chamada de transação em andamento, além
  de `FblnTransacaoEmAndamento`/`FdwPidTransacaoEmAndamento`, para o `reata` poder responder
  `emVoo`.
- **Tratamento do `reata`:** novo tipo de envelope, tratado antes de qualquer despacho. Reata a
  sessão por identidade, responde o estado de cada id consultando o id em voo e a fila local, informa
  a identidade da instância do serviço, e **dispara a drenagem da fila** (`pReenviaFilaLocal`) — que é
  onde o gatilho do Passo 8 passa a morar (RF21 revisto). `fMarcaFilaLocalReenviada` continua sendo o
  test-and-set de uma drenagem por conexão.
- **Sonda de vivacidade (RF27):** hook novo, mandado pela estação quando alguém disputa o pinpad e o
  detentor tem conexão viva. Reusa a infraestrutura de `fEnviaHookEAguarda` com prazo próprio, curto —
  e `RN14` explica no código por que esse prazo não viola a regra do `tef-dvc.md`.
- **Guardas por identidade e conexão (RN13):** `fOutroAutcomDetemPinpad` e
  `fSessaoVivaComPendencia` param de isentar por PID e passam a isentar só a **conexão atual** do
  requisitante. É o conserto do caminho em que o re-login do próprio AUTCOM confirma a própria
  pendência.
- **Fluxo de disputa (RF27/RN15/RN16)**, na ordem:
  1. detentor com conexão viva e sonda respondida → **recusa** o requisitante, fim;
  2. conexão viva e sonda sem resposta no prazo → devolve ao requisitante "detentor não responde",
     para ele pedir confirmação ao operador;
  3. conexão caída → o requisitante verifica o processo do detentor (`OpenProcess` +
     `inicioProcesso`) e relata; processo morto → tomada **automática**; processo vivo → espera, e
     tomada só com confirmação do operador.
  A estação nunca aceita "o detentor está morto" sem o relato ser sobre fato verificável, e nunca
  toma o pinpad sozinha no caso "travado".
- **Coleta ordenada da órfã (RF28):** `pColetaOrfasSeOcioso` perde a condição `FdictSessoes.Count = 0`
  e mantém a de nenhuma thread de despacho. A coleta passa a ser chamada também no caminho do login
  (`fMetodoFConfiguraTefCitel`), **antes** de tocar a DLL nativa — é o ponto que a premissa P1
  depende.
- **Varredura de subida (RF29):** no construtor, depois de criar a fila, descartar tudo o que houver
  nela com log e contagem. Identidade de instância do serviço gerada aqui.

### 9.4 Estação — `libTefCitel\Estacao\untTefEstacaoTcpTransporte.pas`

Mudança pequena: nada de novo no protocolo de frame. `TTefEstacaoConexao` já tem `dwPid` e
`blnFilaLocalReenviada` (Passo 8); ganha o `inicioProcesso` pelo mesmo motivo e com o mesmo dono — é
o roteador que preenche, o transporte não olha.

### 9.5 Estação — `libTefCitel\Estacao\untTefEstacaoFilaLocal.pas`

Praticamente intacta. O Passo 8 já entregou PID no nome, filtro e descarte por idade. Só ganha o
método de varredura total usado na subida (RF29). O descarte por idade continua, como higiene.

### 9.6 AUTCOM — `padra_atualizado\fontes\tef\TefCitel\`

- `untTefCitelUtil.pas` — `pIniciaTefCitel` e o fluxo de re-login: tratar o sinal de "serviço
  reiniciou" (RF29) refazendo o TEF e direcionando ao relatório de pendências. `fPassaCartao`
  (`:2167`) deixa de registrar `TRANSACAO_CANCELADA` quando o motivo é desistência de espera, e não
  chega mais a esse ramo por queda de canal, porque a chamada não estoura mais ali.
- Tela do TEF — o "cancelar espera" (RF30) e o aviso de "reconectando" durante a oscilação.

### 9.7 Sequência de implementação

1. **Spike do canal** (`specs.md` 10.7). Nada abaixo começa antes.
2. Identidade `inicioProcesso` nas duas pontas — isolado, compatível para trás (ausente = 0).
3. Reconexão no `untTefCitelDvcTransporte`, ainda sem mexer no `ErroCanal`: verificável sozinho, o
   canal volta e a chamada seguinte funciona.
4. Frame `reata` + id em voo na estação + gatilho da fila migrado para ele. Passo 8 fecha aqui.
5. ~~`ErroCanal` deixa de matar a chamada pendente + "cancelar espera".~~ **Substituído em
   2026-09-09** (decisão do Rafael, `specs.md` 10.5): a estação **aborta** a transação em voo com
   `pSair` no `pOnDesconectado`, e o operador tenta de novo. O `ErroCanal` fica como está. Só o
   serviço muda; a DLL do AUTCOM não é tocada.
6. Sessão desanexada, reata por identidade, guardas por conexão (RN13).
7. Sonda de vivacidade + fluxo de disputa + confirmação do operador.
8. Coleta ordenada da órfã no login (RF28) e varredura de subida (RF29).
9. Revisão, log consolidado, nova seção na `IA\rules\tef-dvc.md` (só depois de validado em campo).

### 9.8 Conformidade com padrões do projeto

Zona legado nos dois lados (`libTefCitel\`, `padra_atualizado\fontes\`): Hungarian obrigatório,
prefixos `p`/`f`, `unt` nas units novas, sem refatoração proativa. Encoding latin-1/CRLF nos `.pas`.
`System.SysUtils.Now` qualificado em timestamp de log e de controle local — nunca `Now` nu.
`fNow()` não se aplica: nada aqui grava dado de negócio ou auditoria.

### 9.9 Riscos e mitigação

| Risco | Mitigação |
|---|---|
| Canal não reabre no TSPlus real | Spike antes de tudo (10.7); plano B definido |
| Premissa P1 (destruir antes do login) não se confirmar em campo | É premissa do Rafael, não fato de código; sai no primeiro teste do caso 2, e o passo 8 da sequência é isolado |
| Falso positivo da sonda (modal à frente da fila FIFO) | Confirmação humana obrigatória no caso "travado" (RN16) |
| Espera infinita se a estação nunca voltar | "Cancelar espera" (RF30) e `desconhecido` no `reata` |
| Chamada que espera para sempre virar trava de caixa | O bombeamento da thread principal mantém a tela viva; a tela mostra "reconectando" e oferece a saída |
| Reconexão em laço mascarar problema real de canal | Log de cada tentativa, e a contagem entra no log consolidado (RF22) |
## 10. Passo 8 da Fase 5 — arquivos impactados (2026-09-10)

**Uma unit nova e seis alteradas.** Nenhum arquivo em `padra_atualizado\` foi tocado — o
`autcom.exe` **não precisa de rebuild neste passo**, e é a primeira vez desde o Passo 6 que isso
acontece.

| Arquivo | Zona | O que muda |
|---|---|---|
| `libTefCitel\Estacao\untTefEstacaoLog.pas` | Legado | **NOVA.** Núcleo do log do lado estação: nível, `.ini`, rotação, `GetLocalTime`, seção crítica |
| `libTefCitel\Estacao\TefEstacaoService.dpr` | — | `uses` da unit nova (só o `.dpr`; a IDE sincroniza o `.dproj`) |
| `libTefCitel\Estacao\untTefEstacaoRoteadorMensagens.pas` | Legado | `pLogaEstacao` delega; `TEF_ESTACAO_DESANEXADA_MAX_MS`; `FdwTickDesanexada`; `fOrfanaDesanexadasVencidas`; guarda do `fColetaOrfas` por sessões anexadas; `ETefEstacaoLoginNecessario` e `motivo` em `pEnviaRespostaErro` |
| `libTefCitel\Estacao\untTefEstacaoTcpTransporte.pas` | Legado | `pLogaTcpEstacao` delega |
| `libTefCitel\Estacao\ClientPlugin\untTefCitelDvcPluginImpl.pas` | Legado | Núcleo de log próprio; `FintIdCanal` + `pLog`/`pLogDiag`; três linhas por quadro em nível 2 |
| `libTefCitel\untTefCitelDvcTransporte.pas` | Legado | Núcleo de log; `FintSeqEscritas`; instrumentação de leitura e de espera do ACK; oito linhas por quadro em nível 2 |
| `libTefCitel\untTefCitelDvc.pas` | Legado | `ETefCitelDvcLoginNecessario`; reconhecimento do `motivo`; ramo de re-login e repetição em `fChamaRpc`; comentário do veredito corrigido |

**Sequência usada, e não foi a ordem da agenda.** O item 4 (log) veio **antes** do item 1
(instrumentação), porque a instrumentação precisa de linha por leitura do canal — que em uso
normal acontece a cada poucos segundos — e sem o gate de nível ela seria inutilizável em
produção. O item 4 era pré-requisito, não item paralelo.

1. `untTefEstacaoLog.pas` + delegação nas duas funções do serviço + `.dpr`
2. Núcleo de log no plugin + `[pid canal]` + rebaixamento das linhas por quadro
3. Núcleo de log no transporte do autcom + rebaixamento
4. Instrumentação da leitura e do ACK (item 1)
5. `loginNecessario` nos dois lados (item 3)
6. Retenção de sessão desanexada + guarda da coleta (item 2)
7. Documentação (item 5)

**Build:** os quatro binários saem por `msbuild` sem a IDE — `libTefCitel.dproj` (Debug/Win32,
que grava direto em `..\padra_atualizado\`), `TefEstacaoService.dproj` (Debug/Win32) e
`TefCitelDvcPlugin.dproj` (Debug/Win32 **e** Win64). Compilaram limpo; o único aviso é o
`W1002 DELAYED` pré-existente no roteador.

**Testes:** zona Legado, sem infraestrutura de teste automatizado — validação manual, com
roteiro descrito. A entrega de quem implementa é o **contrato e a lista de casos a cobrir**; a
escrita formal dos casos é do analista. Roteiro priorizado no `PONTO DE PARADA` do `tasks.md` e
critérios na §10.11 do `specs.md`.


---

## 11. Fase 6 — Atualização de arquivos na estação: plano técnico (2026-09-15)

Contrato em `specs.md` §11. Esta seção é o **como**.

### 11.1 Onde o código mora, e por quê

| Unit | Lado | Papel |
|---|---|---|
| `libTefCitel\untTefCitelDvcAtualizacao.pas` | **nova** — roda dentro do `autcom.exe`, via `libTefCitel.dll` | Descobre os pacotes no disco do servidor, calcula SHA-256, conversa com a estação, fragmenta e envia |
| `libTefCitel\Estacao\untTefEstacaoAtualizacao.pas` | **nova** — no `TefEstacaoService.exe` | Recebe, confere hash, guarda em preparo, aplica na subida, reinicia |

A parte pesada fica na DLL de propósito — é o que este requisito vem fazendo desde a Fase 1, e
reduz o que precisa passar pela IDE para gerar `autcom.exe`. O que **não** pode sair do
`autcom.exe` é a tela: `TfrmGravando` é VCL com DevExpress e depende de `Application.MainForm`,
mesmo motivo já registrado para o `fGerarQrCodeImagemPinPad`.

O progresso volta por **callback registrado pelo host**, padrão do `pSetConfirmaTomadaPinpadTef`
— com o mesmo `try/except` para o caso de `libTefCitel.dll` anterior a esta fase.

### 11.2 Protocolo: métodos novos, tipo de quadro nenhum

Reuso de `tipo = "chamada"`, que já traz id, ACK, deduplicação, despacho em thread própria,
`reata` e fila local. Um tipo de quadro paralelo reimplementaria tudo isso.

| Método | O que faz |
|---|---|
| `fAtuConsulta` | Devolve diretório do serviço, hashes **aplicados**, hashes **preparados** e ociosidade |
| `pAtuAbre` | Abre recepção de um pacote: nome, hash de origem, tamanho |
| `pAtuParte` | Um pedaço em base64, com número de sequência |
| `fAtuFecha` | Confere o hash do recebido e move para o preparo |
| `fAtuAplica` | Se ociosa, marca pendente e reinicia. Devolve `{aplicado, reiniciando}` |

**Três integrações que precisam ser explícitas, ou isto quebra:**

1. Esses métodos rodam **antes** do `fConfiguraTefCitel`, então a sessão chega com
   `FblnCfgRecebida = False`. A recusa de `pGarantePinpadConfigurado` virou **incondicional** em
   11/09 e barraria a atualização inteira. Precisa de isenção nomeada — e comentada, porque
   apertar aquela guarda foi conserto de campo e quem ler depois precisa saber que a isenção é
   deliberada.
2. `fMetodoUsaPinpad` e `fMetodoDeTransacao` retornam `False` para os cinco.
3. Nenhum deles marca pendência — a regra de 08/09 diz que só o `fPassarCartao` marca.

### 11.3 Tamanho do pedaço

O fragmento físico de 1400 bytes é teto do chunk WTS, mas o **ACK é por quadro lógico**, e o
`IWTSVirtualChannel.Write` mediu 0 ms em centenas de amostras. A leitura do QR (5.991 bytes,
7 fragmentos, 95 ms) indica custo de ~95 ms de ida-e-volta de ACK, quase independente do tamanho.

Logo, quadro lógico grande amortiza o ACK: **256 KB de base64 por `pAtuParte`** (≈192 KB
binário), em constante ajustável. Pacote de 4 MB vira ~22 idas, não ~3.000. O
`TEF_DVC_TAMANHO_MAX_FRAME` de 16 MB já cobre, e o comentário dele já citava o RF10.

**Medir na primeira bateria antes de fechar a constante.** E não confundir com lentidão de
transferência a retenção de ~10 s do canal, que só acontece no primeiro diálogo de um canal
recém-aberto (achado de 12/09) — que é exatamente o que a atualização será.

### 11.4 Arquivo de versão na estação

Gravado pelo serviço, ao lado do `TefEstacaoService.exe`:

```ini
[Aplicado]
scope=<sha256 do tef_scope.zip de origem>
clisitef=<sha256>
servico=<sha256>
scope.ini=<sha256 do original, antes do ajuste de path>
clisitef.ini=<sha256 do original>
confitls.ini=<sha256 do original>

[Preparado]
servico=<sha256>          ; recebido, ainda não aplicado

[Contexto]
DirServico=C:\TEF_Citel\
DataUltimaAplicacao=...
```

`[Preparado]` é o que resolve dois AUTCOM subindo juntos: o `fAtuConsulta` devolve aplicado
**e** preparado, e o segundo vê o mesmo hash já lá e não envia nada. Sem isso, dois operadores
abrindo o sistema ao mesmo tempo duplicam a transferência inteira.

**Layout em disco, no diretório do serviço** — mesmo idioma do `FilaTef` e do `TempQr`, e
pela mesma razão: pasta de trabalho do próprio serviço, nunca `%TEMP%`, que para um processo
rodando como LocalSystem é candidato a Limpeza de Disco.

| Caminho | Conteúdo |
|---|---|
| `TefEstacaoVersao.ini` | O arquivo de versão acima |
| `_Preparo\` | Pacotes recebidos e conferidos, aguardando a subida |
| `_Falhou\` | Preparo que não pôde ser aplicado, guardado para diagnóstico |
| `TefEstacaoService.exe.old` | Versão anterior, apagada na subida seguinte; é o alvo do rollback |

### 11.5 Sequência na carga (lado AUTCOM, dentro de `pIniciaTefCitel`)

Logo depois do `fCriarTefCitel`:

1. Fragmento `HOM` no caminho do `autcom.exe`, sem diferenciar caixa → loga e sai. Antes de tudo.
2. `CFG_TEFDVC` diferente de `S` → sai.
3. `fAtuConsulta`. **Não respondeu → loga e segue.** Não duplicar mensagem: se o serviço está
   parado, o `fConfiguraTefCitel` logo abaixo já tem, desde 12/09, a mensagem que nomeia o
   serviço da estação.
4. Nada diverge → segue sem tela. É o caso de todo dia.
5. Diverge → abre o `TfrmGravando` e envia só os pacotes divergentes.
6. `fAtuAplica`.
7. Recusado por ocupação → fecha a tela, loga, **segue a carga normalmente**; fica preparado.
8. Aplicado com reinício → aguarda o serviço voltar, consultando a cada segundo, teto de 60 s
   (justificativa em `specs.md` RN26).

### 11.6 Aplicação e reinício (lado estação)

`fAtuAplica` faz pouco:

1. Confere as três condições de ociosidade (RN21). Falhou → responde recusando.
2. Renomeia o `TefEstacaoService.exe` em uso para `.old` e grava o novo. **Só o exe** — NTFS
   permite renomear executável em uso, não sobrescrever, e só ele precisa estar no lugar antes
   de o processo morrer.
3. Marca `[Pendente]` no arquivo de versão.
4. **Responde ao AUTCOM.** Antes de qualquer coisa que mate o canal.
5. Dispara o relançador e chama `pParaComSeguranca`.

Na subida, antes de o roteador existir: apaga o `.old`, extrai os zips sobre o diretório, grava
os `.ini` já ajustados, atualiza `[Aplicado]`, limpa o preparo.

**O relançador** é um `.cmd` escrito na hora pelo próprio serviço e executado destacado — assim
não há binário extra para distribuir, que foi a razão de descartar um `TefEstacaoUpdater.exe`.
Ele espera o serviço parar, faz `sc start`, **confere se subiu**, e se não subiu restaura o
`.old` sobre o exe e sobe de novo. É o único ponto do desenho onde uma atualização ruim deixaria
a estação sem TEF até alguém ir até lá; o rollback custa quatro linhas.

### 11.7 Ajuste de path: na estação, e textual

Quem reescreve é quem conhece o destino — o AUTCOM manda o arquivo **intacto**, o que também
mantém o hash de origem coerente (RN18). Chaves na tabela do RF34.

A reescrita percorre as linhas, acompanha em que seção está, e quando a linha começa com a chave
alvo troca só o que vem depois do sinal de igual. Preserva comentário, ordem e espaçamento (RN24).

Duas guardas menores, das que só aparecem quando falham: `ExtractFileName` em todo nome recebido
— o campo vem da rede, e um nome com `..\` gravaria fora da pasta, mesma razão já registrada
para o QR — e um `.zip` que contenha o próprio arquivo de versão tem essa entrada ignorada.

### 11.8 Degradação

| Falha | Desfecho |
|---|---|
| Consulta não responde | Loga e segue; o login já tem a mensagem certa |
| Hash não bate no destino | Estação descarta o preparo; AUTCOM loga e segue com o instalado |
| Estação ocupada | Fica preparado; a próxima carga aplica em segundos |
| Extração falha na subida | Move o preparo para `_Falhou\` e **sobe assim mesmo** |
| Arquivo do zip travado | Loga o nome e continua com os outros; não aborta o pacote |
| Exe novo não sobe | Relançador restaura o `.old` |
| Serviço não volta em 60 s | Mensagem nomeando o serviço da estação + TEF desabilitado |

### 11.9 Arquivos impactados

**Novos (2):**

| Arquivo | Conteúdo |
|---|---|
| `libTefCitel\untTefCitelDvcAtualizacao.pas` | Descoberta, hash, envio, espera pelo serviço |
| `libTefCitel\Estacao\untTefEstacaoAtualizacao.pas` | Recepção, preparo, aplicação na subida, relançador |

**Alterados (6):**

| Arquivo | Alteração |
|---|---|
| `libTefCitel\libTefCitel.dpr` | Unit nova + exports `pAtualizaEstacaoTef`, `pSetProgressoAtualizacaoTef` |
| `libTefCitel\untTefCitelDvc.pas` | Expor o caminho de RPC para a unit nova |
| `libTefCitel\Estacao\untTefEstacaoRoteadorMensagens.pas` | Os cinco métodos, isenção do `pGarantePinpadConfigurado`, consulta de ociosidade |
| `libTefCitel\Estacao\untTefEstacaoServiceMain.pas` | Aplicar o preparo na subida, apagar o `.old` |
| `libTefCitel\Estacao\TefEstacaoService.dpr` | Unit nova |
| `padra_atualizado\fontes\tef\TefCitel\untTefCitelUtil.pas` | Chamada em `pIniciaTefCitel`, tela e callback de progresso |

Duas consequências: o `autcom.exe` volta a precisar da IDE — e vale relembrar o achado de 11/09,
que IDE e `msbuild` não produzem o mesmo binário aqui. E o acoplamento de versão volta:
`autcom.exe` novo com `libTefCitel.dll` antiga não tem os exports novos, então os dois entram
com o mesmo `try/except` do `pSetConfirmaTomadaPinpadTef`, degradando para "não atualiza" em vez
de derrubar o login.

### 11.10 Conformidade

Zona legado dos dois lados (`libTefCitel\`, `padra_atualizado\fontes\`): Hungarian obrigatório,
prefixos `p`/`f`/`F`/`A`, `fNow()` em qualquer gravação persistida (data de aplicação no arquivo
de versão, log), `pCriarForm`/`pCriarFormularios` para a tela, nada de `TBitBtn`/`TButton`.
`System.Hash` (`THashSHA2`) e `System.Zip` (`TZipFile`) já são usados no projeto.

### 11.11 Testes

Zona legado, sem infraestrutura de teste automatizado. A entrega de quem implementa é o
**contrato** (§11.2 acima) **e a lista de casos a cobrir** — os 13 critérios de aceitação da
§11.3 do `specs.md`. A escrita formal dos casos é do analista; a validação é bateria de campo
com roteiro.

### 11.12 Achados da implementação (Passos 0, 1 e 2 — 2026-09-15)

Três coisas que o plano dizia de um jeito e a implementação mostrou ser outro. Ficam aqui
porque as três são do tipo que alguém "conserta" de volta sem saber por que estavam assim.

**1. O nome do arquivo no `_Preparo\` não vem da rede — nem sanitizado.** O plano mandava
passar `ExtractFileName` no nome recebido, pela mesma razão já registrada para o QR do Pix. Na
implementação ficou melhor: o pacote é um **conjunto fechado de seis valores**, e
`fNomeNoPreparo` deriva o nome local do pacote, não do campo que veio no RPC. Valor fora da
lista é recusado. O nome de arquivo declarado sobrevive só no log. Não há `..\..\algo.exe` a
filtrar porque nenhum byte vindo do canal chega ao sistema de arquivos — a classe inteira de
problema deixa de existir em vez de ser tratada.

**2. `THashSHA2.GetHashStringFromFile` não existe no Delphi Seattle.** Entrou em versão
posterior. `fSha256DeArquivo` faz o hash em blocos de 64 KB com `THashSHA2.Create`/`Update` —
o que também evita carregar um pacote de vários MB inteiro na memória do serviço só para
hashear. O harness confere o resultado do laço contra um hash de uma tacada só, então um erro
no bloqueio apareceria como divergência.

**3. O `TefEstacaoVersao.ini` é gravado em `TEncoding.ANSI`, e isso não é descuido.** Com
`TEncoding.UTF8` o `TMemIniFile.UpdateFile` grava **BOM**, e o `GetPrivateProfileString` do
Windows — que é o que está por trás do `TIniFile` — não entende BOM: a primeira seção some.
Flagrado pelo harness do Passo 1, onde `fHashPreparado` lia o valor certo e um `TIniFile` lia
vazio do **mesmo arquivo**. Importa porque esse `.ini` é material de diagnóstico do suporte e
tem que abrir em qualquer ferramenta comum do Windows. ANSI também é coerente com o resto da
pilha: Scope e CliSiTef são ANSI, e um caminho que não coubesse na codepage da estação também
não funcionaria nas DLLs nativas.

**E um item que o Passo 3 herdou.** Recepção abortada por exceção (parte fora de ordem,
estouro do tamanho declarado) deixa o `.parcial` em disco — o stream é fechado, o arquivo
fica. É limitado a um por pacote e sobrescrito na retentativa, mas
`pAplicaPreparoNaSubida` **tem** que ignorar `.parcial` e apagar os que encontrar: tratar um
deles como pacote pronto aplicaria um zip truncado, e é o único caminho por onde um arquivo
sem conferência de hash chegaria ao diretório do serviço.

### 11.13 Achados da implementação (Passo 3 — 2026-09-15)

Quatro correções ao plano, uma delas grave, e um achado de ambiente que custou tempo.

**1. `Count = 0` nunca seria verdade — a atualização recusaria SEMPRE.** O plano mandava exigir
`FdictConexaoPorThread.Count = 0`. Mas `pDespachaChamadaEmThreadPropria` registra **toda**
chamada despachada nesse dicionário, inclusive o próprio `fAtuAplica` que está perguntando.
`fEstacaoOciosa` desconta a thread corrente (`ContainsKey(GetCurrentThreadId)`). Sem o desconto
não haveria erro nenhum no log — só um "estação ocupada" eterno, e a fase inteira pareceria
implementada e não funcionaria.

**2. A isenção em `pGarantePinpadConfigurado` não precisou existir — e o comentário virou o
entregável.** O plano assumiu que a guarda era uma lista de bloqueio. `fMetodoUsaPinpad` e
`fMetodoDeTransacao` são **listas de permissão**: método ausente já fica de fora, e a guarda
sequer é chamada. O que entrou foi um parágrafo no comentário de `fMetodoUsaPinpad` dizendo que
a ausência dos cinco é deliberada — porque num allowlist a ausência é indistinguível de
esquecimento, e quem um dia acrescentar um deles ali quebra a atualização sem sintoma que aponte
para lá.

**3. O gatilho do reinício mora no `finally` da thread anônima, não no `fAtuAplica`.** Duas
ordens exigem isso: a resposta ao autcom só sai depois que `fDespachaMetodo` retorna (quem envia
é `pTrataChamada`), e `pParaComSeguranca` espera `FdictConexaoPorThread` chegar a zero — com o
gatilho dentro do método, o serviço esperaria **por si mesmo** até estourar o teto de 10 s. O
custo é uma leitura de boolean por chamada despachada.

**4. Um `.exe` ruim entraria em laço, e o plano não previa.** Se o binário novo não sobe, o
relançador restaura o `.old`; o autcom, na carga seguinte, vê o hash ainda divergente e reenvia;
falha de novo. Para sempre. O conserto tem três peças: o relançador deixa o binário reprovado
como `.reprovado`, `pAplicaPreparoNaSubida` reconhece esse sinal e grava o hash em `[Falhou]`, e
`fPreparaTrocaDoExe` recusa pacote que esteja lá. Só um pacote **diferente** volta a ser aceito.
Um pacote novo que suba com sucesso limpa a marca dele.

**5. Só o `.exe` é trocado antes do reinício, e isso é imposição do sistema operacional.** Na
subida, quem está rodando é ele — não pode se sobrescrever. Todo o resto do `.zip` fica para
`pAplicaPreparoNaSubida`. A ordem dentro de `fPreparaTrocaDoExe` também não é arbitrária: grava
o novo com nome temporário, **depois** renomeia o atual para `.old` e o temporário para o nome
final. Queda de energia no meio deixa no pior caso um `.novo` sobrando — o `ImagePath` do
serviço nunca aponta para arquivo inexistente.

**O achado de ambiente.** O harness que exercita a aplicação foi **bloqueado pelo antivírus
desta máquina** ("Acesso negado" / "arquivo já está sendo usado"), e só ele: os binários do
produto compilam e rodam. A causa é a combinação num mesmo executável de apagar árvore de
diretório, criar arquivo `.exe` e renomear o original, mais manipulação de `.zip` — assinatura
de ransomware. Isoladas, nenhuma dessas operações é bloqueada (testado A/B). A verificação foi
feita em dois binários separados, e o roteiro de campo deve prever que **a estação pode precisar
de exclusão de antivírus para o `TefEstacaoService.exe`** — esta migração já teve triagem de
Bitdefender/Defender/MDE antes, por outro motivo.

### 11.14 Reescrita do Passo 3 — o atualizador à parte (2026-09-15)

Contrato em `specs.md` §11.5 (RN27–RN31). O que mudou no código.

**Projeto novo:** `libTefCitel\Estacao\Atualizador\TefEstacaoAtualizador.dpr` +
`untTefEstacaoAplicacao.pas`. Console, sem VCL, sem `ShareMem` (não exporta nada e não troca
string com DLL). Não é registrado no SCM: quem o lança é o serviço.

**Unit nova:** `libTefCitel\untTefCitelAtuComum.pas` — todas as constantes `TEF_ATU_*`, **sem
nenhum `uses`**. Elas nasceram em `untTefCitelComum`, que puxa `untInterfaceTefCitel` e daí
UniDAC; o atualizador precisa ficar leve, e não só por tamanho: um binário pequeno, de propósito
único e sem meio mundo de biblioteca dentro é mais fácil de analisar, assinar e liberar numa
exceção de antivírus. Com isso `untTefCitelComum.pas` voltou **byte a byte** ao estado
pré-Fase 6.

**O que saiu do serviço:** `fPreparaTrocaDoExe`, `pDisparaRelancador`, `pEscreveRelancador`,
`pExtraiZip`, `pMoveParaFalhou`, `fTratouReprovacao`, `pAplicaPreparoNaSubida`. O
`untTefEstacaoServiceMain.pas` voltou ao original — não aplica nada na subida. O binário do
serviço encolheu de **2.620.500 para 2.477.896 bytes**.

**O que entrou no serviço:** `fDisparaAtualizador`, que faz `CreateProcess` do irmão e nada mais.

**Três complicações que sumiram com a mudança:**

1. **O caso especial do `.exe`.** Com o serviço parado, o atualizador troca tudo no mesmo lugar.
   A dança "grava `.novo` → renomeia o atual para `.old` → renomeia `.novo`" deixou de ser
   necessária: virou uma cópia comum, mais o `.old` guardado só como rede de segurança.
2. **O `.cmd` gerado em tempo de execução**, que era a heurística mais barulhenta de todas. O
   atualizador fala com o SCM pela API (`OpenSCManager`/`ControlService`/`StartService`), sem
   `cmd.exe` e sem script no disco.
3. **O sinal `.reprovado` atravessando o reinício.** O atualizador vê a falha na hora, reverte
   ele mesmo e grava `[Falhou]` — não precisa deixar recado para a subida seguinte ler.

**O que NÃO mudou, de propósito:** a decisão de ociosidade continua no serviço (RN28), porque só
ele enxerga sessões, pinpad e pendências. O atualizador chega depois da decisão e nunca a
reavalia. E o gatilho continua no `finally` da thread anônima, pelas duas razões de ordem da
§11.13 — a resposta precisa sair antes, e a thread precisa sair do `FdictConexaoPorThread`.

**Uma coisa que o desenho anterior não tinha:** um mutex nomeado (`Global\...`) no atualizador.
Dois atualizadores simultâneos trocariam arquivos um por cima do outro. Não deveria acontecer —
o serviço só lança um — mas "não deveria" não é garantia e o custo de garantir é uma linha.

**Pendência de projeto:** o `TefEstacaoAtualizador.dproj` **ainda não existe**. Pela regra do
`CLAUDE.md` o `.dpr` é a fonte de verdade e a IDE gera o `.dproj` ao abrir o projeto pela
primeira vez — e este requisito exige build pela IDE para o que vai a campo de qualquer forma
(achado de 11/09: IDE e `msbuild` não produzem o mesmo binário aqui). Até lá o atualizador é
compilável por `dcc32` com o search path de `libTefCitel\Estacao` e `libTefCitel`.

**Verificação:** `pAplicaPacotes` é público de propósito — é a parte que não depende do SCM, e
por isso a única exercitável fora de uma estação de verdade. 22 conferências passam: aplicação
completa com `.zip` + `.ini` + `.parcial` + pacote do serviço, o atualizador adiando a si mesmo,
o comentário do `.ini` preservado, o pacote reprovado recusado e mandado para `_Falhou`, e o
preparo vazio. As 16 do Passo 1 continuam passando contra a unit reescrita.

### 11.15 Achados da implementação (Passo 4 — 2026-09-15)

**1. A trava de homologação mudou de lado — foi para a DLL.** O plano punha o `HOM` no
`pIniciaTefCitel`. Está em `fAtualizaEstacaoTef`, dentro da `libTefCitel.dll`, porque é o ponto
que não dá para contornar por esquecimento de quem chama. `ParamStr(0)` dentro de uma DLL devolve
o executável do **processo hospedeiro**, então o caminho conferido é mesmo o do `autcom.exe`. O
Passo 5 não repete a checagem.

**2. Os exports entraram aqui, não no Passo 5.** `fAtualizaEstacaoTefDll` e
`pSetProgressoAtualizacaoTef` são a face pública da DLL e completam o entregável do Passo 4 — sem
eles não há o que o `autcom.exe` chame. Conferidos no binário: os quatro exports estão em
`padra_atualizado\libTefCitel.dll`.

**3. `fSha256DeArquivo` subiu para `untTefCitelAtuComum`.** Os **três** projetos precisam do mesmo
número: o autcom calcula o hash de origem, a estação confere o que recebeu, o atualizador decide
o que aplicar. Duas implementações do mesmo hash seria a forma mais fácil de discordarem em
silêncio. A unit ganhou `System.SysUtils/Classes/Hash` — RTL apenas, continua sem UniDAC.

**4. O teto de espera dobrou, de 60 s para 120 s, e tem conta por trás.** Enquanto o serviço está
parado, **cada** tentativa de consulta pode custar até os ~30 s do teto de entrega do transporte
(o ciclo de ACK do `fChamaRpcUmaVez`, que só desiste com prova de que o pedido não chegou). Com
60 s caberiam duas tentativas; com 120 s cabem quatro, e o serviço normalmente volta na primeira
ou na segunda.

**5. Três acessores de JSON ficaram locais.** Os de `untTefCitelDvc.pas` são da seção de
implementação e não atravessam a fronteira da unit; os do lado estação vivem em outro projeto.
São dez linhas cada, e mover qualquer um dos dois de onde está mexeria em código já validado em
campo por uma razão que não justifica.

**6. `fDescreveOrigens` é público, e não só para teste.** Devolve o que esta máquina mandaria e de
onde tirou cada arquivo. É a parte que não depende do canal — logo a única exercitável sem uma
estação de verdade — e "de onde veio este `.ini`?" é pergunta de suporte: com `CFG_PTTFCT`
preenchida a resposta depende da cascata do RF33, e adivinhar custa mais que perguntar ao próprio
código.

**Verificação (17 conferências, todas passam):** `CFG_TEFCIT = 'T'` manda só o `scope.ini`;
`'S'` manda `CliSiTef.ini` + `CONFITLS.ini`; com `CFG_PTTFCT` preenchida o `CliSiTef.ini` vem da
pasta do terminal e o `CONFITLS.ini`, que não está lá, **cai para a raiz** (a queda parcial do
RF33); subpasta inexistente cai inteira; o hash de origem confere contra um cálculo independente
e é diferente do hash do arquivo da raiz — o que prova que pegou o arquivo certo; `.zip` ausente
ou de zero bytes não entra.

### 11.16 Correção do ponto de chamada (2026-09-15)

Contrato em `specs.md` §11.6 (RN32–RN34). Duas mudanças, as duas vindas da observação do Rafael
de que o TEF só carrega depois do login do operador.

**1. A chamada vai para dentro do `if not qryTefTra.IsEmpty`.** O plano a punha logo após o
`fCriarTefCitel`, que fica **fora** dessa guarda. Num terminal sem linha de TEF o objeto é criado
assim mesmo, e a rotina falaria com a estação em todo login — até 30 s por tentativa se não
houver serviço lá. Segunda barreira dentro do `fAtualizaEstacaoTef`: `CFG_TEFCIT` fora de
`'T'`/`'S'` sai com "nada a fazer" e registra o motivo, pelo mesmo raciocínio do `HOM`.

**2. A tela de progresso já existia.** `fIniciarTefCitel(pgbProgresso: TcxProgressBar)` recebe a
barra, e `pVerificaTEFCitel` já envolve tudo em `fChamaTelaGravando`. O `TfrmGravando` que o
plano mandava abrir seria uma segunda janela modal por cima da tela de carga. O Passo 5 encolheu:
basta ligar o callback de progresso ao `pgbProgresso`/`pInfoStatusGravacao` que a rotina já usa.

### 11.17 Reparo de encoding em dois fontes (2026-09-15)

Achado pelo Rafael ao revisar, e **não** é da Fase 6: a corrupção é de **12/09**, da sessão que
acrescentou o tratamento de "serviço parado na carga". Ficou três dias sem ninguém ver.

| Arquivo | Linhas corrompidas |
|---|---|
| `padra_atualizado\fontes\tef\TefCitel\untTefCitelUtil.pas` | 81 |
| `Services\Faturamento.Services.API\Target\Linux\FaturamentoServicesAPI.dpr` | 1 |

**A assinatura:** bytes `EF BF BD` — o U+FFFD gravado cru num arquivo latin1. "Módulo" virou
"M\<FFFD\>dulo". É leitura como UTF-8 seguida de regravação. As adições de 12/09 estavam
**corretas** em latin1; só a acentuação pré-existente foi destruída.

**Por que não foi `svn revert`:** o `untTefCitelUtil.pas` tinha **181 linhas de alteração real**
junto da corrupção, e o `.dpr` tinha a correção de caminho do `untInterfaceTefCitel` que este
requisito fez ao tirar a `libTefCitel` de dentro de `fontes\`. Reverter jogaria fora as duas
coisas. O reparo restaurou **só os acentos**, casando cada linha corrompida com a linha
equivalente da base do SVN pela forma normalizada — 82 linhas, todas com par único, zero ambíguas.

**As provas que fecham o reparo:** reparado × corrompido ignorando acentuação dá **idêntico** (as
181 linhas de alteração real não foram tocadas); reparado × base ignorando acentuação dá as
**mesmas 181 linhas** de antes; e as 85 linhas acentuadas do arquivo estão **todas dentro de
literal ou comentário**, então o reparo não pode mudar a análise sintática.

**Varredura da árvore inteira:** `libTefCitel` (todo o código novo desta fase) está **limpa**. Os
outros acertos — `autban\banrisul 240p\untExpArqRemBanrisul240.pas` e os fontes de terceiro do
DMVCFramework — estão **sem modificação local** e já corrompidos na revisão **commitada**: é
estado do repositório, não desta máquina, e fica fora do escopo desta fase.

### 11.18 Achados da implementação (Passo 5 — 2026-09-15)

**1. `untTefCitelUtil.pas` compila também para LINUX — e isso quase passou.** Os serviços
(`FaturamentoServicesAPI.dpr` entre eles) incluem esta unit. O ponto de chamada já ficou
protegido por acaso, dentro do `{$ELSE}` do `{$IFDEF LINUX}` de `pIniciaTefCitel` — mas
`fAtualizaEstacaoNaCarga` **não estava**, e referencia `fAtualizaEstacaoTefDll`, que só é
declarado dentro de `{$IFNDEF LINUX}`. Quebraria o build dos serviços Linux. O bloco inteiro
(constantes, variável, callback e função) foi envolvido em `{$IFNDEF LINUX}`. Diretivas
conferidas: 28 aberturas para 28 `{$ENDIF}`, profundidade final zero.

**2. Os `TEF_ATU_RET_*` são espelhados, não compartilhados.** `untTefCitelAtuComum` resolveria
isso por unit, e o `autcom.dproj` até tem a `libTefCitel` no search path — mas a unit teria de
resolver **também no caminho Linux** dos serviços, que a referenciam por caminho explícito no
`.dpr`. Arrastar mais uma unit para lá por causa de cinco constantes seria arriscar o build dos
serviços para ganhar pouco. Mesma decisão já tomada para o tipo do callback.

**3. Uma variável de unit, e o porquê.** `VprocStatusCargaTef` existe porque o callback atravessa
a fronteira da DLL e precisa ser `stdcall` simples, sem `of object` para carregar instância — o
mesmo motivo do `VS_funcConfirmaTomadaPinpadTef` do outro lado. O `CLAUDE.md` trata variável
global de unit como violação real na zona legado, e a isenção aqui é essa: ela é **atribuída e
limpa dentro de `fAtualizaEstacaoNaCarga`**, num `try/finally`, e essa chamada é síncrona. Não é
estado vivendo entre chamadas.

**4. A barra de progresso é devolvida ao estado que a rotina espera.** `pStatusCargaTefCitel` usa
o `Max` da barra para medir a transferência de um pacote; ao voltar, `fIniciarTefCitel` refaz
`Max := intQtdMax` e `Position := 1`, senão o `pStepStatusGravacao` logo abaixo passaria a contar
sobre um máximo que não é mais o dele.

**PENDENTE — o `autcom.exe` NÃO foi compilado.** O `msbuild` para nesse projeto por pacote de
projeto ausente (`faturamento.impostos.interfaces`), que só a IDE resolve; a tentativa de compilar
só a unit com `dcc32` esbarrou em `.inc` de terceiro que exige defines de configuração do
projeto. **A verificação de compilação do Passo 5 fica com a IDE** — o que este requisito já
exige de qualquer forma para o binário de campo (achado de 11/09). O que foi conferido aqui:
diretivas balanceadas, encoding e CRLF preservados, zero corrupção, e o lado DLL (que compila)
limpo.

## Plano — Fase 6.1: canal DVC dedicado à atualização (2026-09-16)

**Objetivo:** transferir o pacote de atualização por um canal DVC próprio, em blocos grandes, para
derrubar os 154 s medidos em campo para menos de 20 s, sem tocar em nada validado.

**Spec:** `IA\specs\456190\specs.md`, seção 12 — RF39–RF46, RN35–RN38. O plano argumenta a partir
dela; quem executar lê as duas.

**Arquitetura:** canal `TefCitelUpd`, servido por um plug-in DVC próprio (`TefCitelDvcUpdate.dll`)
que só repassa bytes para uma segunda porta local do `TefEstacaoService`. O serviço grava em
`_Preparo` pelo mesmo `FAtualizacao.pParte` de hoje. Controle e checksum continuam no `TefCitelCh`.

### Restrições globais — valem para TODAS as tarefas

- **Não tocar**: `TefCitelDvcPlugin.dll` (nem recompilar), `untTefCitelDvcTransporte.pas`,
  `untTefEstacaoTcpTransporte.pas` (exceto a adição isolada da Tarefa 2), protocolo de quadro,
  ACK, dedup, e os consertos validados em 16/09.
- **Sem TDD e sem "escrever testes" como tarefa.** Nesta zona não há infraestrutura de teste
  (CLAUDE.md). Quem implementa entrega o **contrato e a lista de casos**; os casos são escritos
  pelo analista. A validação é manual, na estação, com o roteiro da Tarefa 6.
- **Sem commit por tarefa.** O commit do requisito é único, no fim, com `Req. 456190` na primeira
  linha e token do DelphAI. A cada tarefa concluída: **backup** com
  `_backups\backup-req.ps1 -Req 456190 -Marco "<tarefa>"`.
- **Encoding**: as units são latin1/CRLF. O hook de encoding não dispara nesta extensão — editar
  por substituição byte-exata e conferir com `file` depois.
- **msbuild sobrescreve binário da working copy** (o `<DCC_ExeOutput>` do `.dproj` ganha do `/p:`).
  Guardar hash antes, conferir e restaurar depois.
- **Zona legado**: Hungarian obrigatório, prefixo `p`/`f` em métodos, `F` em campos, `L` em locais.
  Seguir o estilo das units vizinhas.
- **Nenhuma tarefa é validável isoladamente em estação.** As Tarefas 1–4 só produzem efeito
  observável juntas. A verificação por tarefa é **compilação limpa + inspeção**; a validação de
  comportamento é a Tarefa 6. Isso é consequência da zona, não descuido do plano.

### Constantes novas (valores definitivos, usar exatamente estes)

| Constante | Valor | Unit |
|---|---|---|
| `TEF_UPD_CANAL` | `'TefCitelUpd'` | `untTefCitelAtuComum.pas` |
| `TEF_UPD_PORTA` | `47992` | `untTefCitelAtuComum.pas` |
| `TEF_ATU_TAMANHO_BLOCO_RAPIDO` | `256 * 1024` | `untTefCitelAtuComum.pas` |
| `TEF_UPD_TIMEOUT_BLOCO_MS` | `30000` | `untTefCitelAtuComum.pas` |

**Enquadramento do canal rápido** (idêntico nos três pontos — autcom, plug-in, serviço):

```
[4 bytes tamanho little-endian][N bytes JSON UTF-8]
```

Pedido: `{"pacote":"scope","seq":0,"conteudoBase64":"..."}`
Resposta: `{"ok":true}` ou `{"ok":false,"erro":"<motivo>"}`

O bloco é de **256 KiB lidos do arquivo**, que viram ~341 KiB de base64 no fio — dentro da faixa
que a PoC validou (1 MiB aprovado em 1.000 repetições). São ~38 blocos para 9,7 MB.

---

### Tarefa 1 — Plug-in `TefCitelDvcUpdate.dll`

**Arquivos:**
- Criar: `libTefCitel\Estacao\UpdatePlugin\TefCitelDvcUpdate.dpr`
- Criar: `libTefCitel\Estacao\UpdatePlugin\untTefCitelDvcUpdateImpl.pas`
- Criar: `libTefCitel\Estacao\UpdatePlugin\TefCitelDvcUpdate.dproj` (pela IDE)
- Ler antes: `libTefCitel\Estacao\ClientPlugin\untTefCitelDvcPluginImpl.pas` (padrão a espelhar) e
  `DVC_v2\src\client\TefDvcPluginImpl.pas` (a PoC)

**Interfaces produzidas:** DLL com `VirtualChannelGetInstance`, `DllRegisterServer`,
`DllUnregisterServer` — mesmos exports do plug-in atual, registrada por `regsvr32`.

- [ ] **Passo 1** — Copiar a estrutura de `untTefCitelDvcPluginImpl.pas`: `IWTSPlugin`,
      `IWTSListenerCallback`, `IWTSVirtualChannelCallback`. As interfaces e GUIDs já estão
      prontas em `DVC_v2\src\common\TefDvcApi.pas` — reaproveitar de lá, sem redeclarar.
- [ ] **Passo 2** — `CreateListener` com `TEF_UPD_CANAL`. Uma única diferença conceitual em
      relação ao plug-in atual: **este não tem loop de escrita nem fila**. É estritamente
      request/response — `OnDataReceived` chega, repassa, devolve a resposta pelo mesmo canal.
      É essa serialização que torna o bloco grande seguro (ver seção 12 da spec).
- [ ] **Passo 3** — Em `OnDataReceived`: abrir socket para `127.0.0.1:TEF_UPD_PORTA`, escrever o
      buffer recebido **sem reencapsular** (o enquadramento já vem pronto do autcom), ler a
      resposta e devolvê-la com `FChannel.Write`. Socket aberto na primeira mensagem e mantido
      até `OnClose` — abrir por bloco custaria um connect a cada 341 KiB.
- [ ] **Passo 4** — Falha ao conectar ou escrever: responder `{"ok":false,"erro":"..."}` pelo
      canal. **Nunca** levantar exceção para fora do `OnDataReceived` — derrubaria o plug-in
      dentro do `mstsc.exe` do cliente.
- [ ] **Passo 5** — Log próprio em arquivo, no padrão do `pLogArquivo` do plug-in atual, com nome
      distinto (`TefCitelDvcUpdate.log`). Não compartilhar arquivo com o plug-in existente.
- [ ] **Passo 6** — `DllRegisterServer`/`DllUnregisterServer` escrevendo a chave
      `Software\Microsoft\Terminal Server Client\Default\AddIns\TefCitelUpd` em
      `HKEY_CURRENT_USER`, espelhando o que o `.dpr` atual faz para o canal dele.
- [ ] **Passo 7** — Compilar Win32 **e** Win64 (o plug-in atual tem as duas; o `mstsc` do cliente
      decide qual carrega). Verificar: compila sem erro nas duas plataformas.
- [ ] **Passo 8** — Backup do marco.

---

### Tarefa 2 — Porta de volume no `TefEstacaoService`

**Arquivos:**
- Criar: `libTefCitel\Estacao\untTefEstacaoUpdateListener.pas`
- Modificar: `libTefCitel\Estacao\untTefEstacaoServiceMain.pas` (subir/descer o listener novo)
- Modificar: `libTefCitel\Estacao\TefEstacaoService.dpr` (cláusula `uses`)

**Interfaces consumidas:** `TTefEstacaoAtualizacao.pParte(const AstrPacote: String;
const AintSeq: Integer; const AstrBase64: String)` — já existe, `untTefEstacaoAtualizacao.pas:120`.

**Interfaces produzidas:**

```pascal
TTefEstacaoUpdateListener = class
public
  constructor Create(AAtualizacao: TTefEstacaoAtualizacao);
  destructor Destroy; override;
  procedure pInicia;   // bind/listen em 127.0.0.1:TEF_UPD_PORTA
  procedure pPara;
end;
```

- [ ] **Passo 1** — Listener novo, **em unit própria**, sem encostar em
      `untTefEstacaoTcpTransporte.pas`. Motivo: aquela unit é o transporte validado; misturar o
      caminho rápido nela apaga a fronteira que a restrição global protege.
- [ ] **Passo 2** — Socket bloqueante simples, `listen(1)`, **uma conexão por vez**. Não replicar
      a máquina de múltiplas conexões da 47991: aqui só existe um remetente (a DLL de volume) e
      só durante a atualização.
- [ ] **Passo 3** — Laço: ler 4 bytes de tamanho, ler N bytes de JSON, chamar
      `FAtualizacao.pParte(pacote, seq, conteudoBase64)` dentro de `try/except`, responder
      `{"ok":true}` ou `{"ok":false,"erro":E.Message}` com o mesmo enquadramento.
- [ ] **Passo 4** — Recusar tamanho fora de `[1, 2*1024*1024]` fechando a conexão, com log. É a
      mesma defesa que o `LintTamanhoFrame invalido` do transporte atual faz.
- [ ] **Passo 5** — Subir no `ServiceStart` e descer no `ServiceStop`, ao lado do transporte
      atual. **Não** entrar no `pParaComSeguranca`: não há despacho de pinpad aqui.
- [ ] **Passo 6** — Log pelo `pLogaEstacao` já existente, prefixo `UPD:` para separar do
      `TCP[con=`. Logar `porta ouvindo`, `bloco seq=N aceito (N bytes)` e as falhas — o log é a
      única evidência de que o caminho rápido atuou.
- [ ] **Passo 7** — Compilar `TefEstacaoService.dproj`. Verificar: compila limpo; o único aviso
      esperado é o `W1002 DELAYED` pré-existente.
- [ ] **Passo 8** — Backup do marco.

---

### Tarefa 3 — Transporte de volume no autcom

**Arquivos:**
- Criar: `libTefCitel\untTefCitelDvcUpdateTransporte.pas`
- Modificar: `libTefCitel\untTefCitelAtuComum.pas` (as quatro constantes da tabela acima)
- Modificar: `libTefCitel\libTefCitel.dpr` (cláusula `uses`)

**Interfaces produzidas:**

```pascal
TTefCitelDvcUpdateTransporte = class
public
  constructor Create;
  destructor Destroy; override;
  { Abre TEF_UPD_CANAL. False = indisponivel; AstrMotivo diz por que.
    Nao levanta excecao: indisponibilidade e caminho normal (RF45). }
  function fAbre(out AstrMotivo: String): Boolean;
  { Envia um bloco e espera a resposta. False = recusado/falhou. }
  function fEnviaBloco(const AstrPacote: String; const AintSeq: Integer;
    const AstrBase64: String; out AstrErro: String): Boolean;
  procedure pFecha;
end;
```

- [ ] **Passo 1** — `fAbre`: `WTSVirtualChannelOpenEx(WTS_CURRENT_SESSION, TEF_UPD_CANAL,
      WTS_CHANNEL_OPTION_DYNAMIC)`. Handle zero → `Result := False` e `AstrMotivo` com o
      `GetLastError`. **Nada de exceção** — estação sem a DLL é caso esperado, não erro.
- [ ] **Passo 2** — `fEnviaBloco`: montar o enquadramento, `WTSVirtualChannelWrite`, depois ler a
      resposta com o laço de remontagem multi-chunk (`CHANNEL_FLAG_FIRST`/`CHANNEL_FLAG_LAST`) —
      **copiar o laço da PoC**, `DVC_v2\src\server\TefDvcServer.dpr:62-89`, que é o código que já
      passou por 105.000 idas e voltas.
- [ ] **Passo 3** — Serialização estrita: `fEnviaBloco` escreve e só então lê. **Uma thread só,
      nenhuma escrita concorrente neste canal** — é a condição que torna o bloco grande seguro
      (seção 12 da spec: a perda de 31/08 é concorrência, não tamanho). Documentar isso no
      cabeçalho da unit, porque é a premissa que sustenta o desenho inteiro.
- [ ] **Passo 4** — Teto de `TEF_UPD_TIMEOUT_BLOCO_MS` na leitura da resposta. **Não viola
      `IA\rules\tef-dvc.md`**: não há pinpad neste canal e a RN37 proíbe que haja — é o mesmo
      raciocínio já aceito para o ACK de transporte. Registrar essa justificativa no comentário,
      como as outras exceções da regra já fazem.
- [ ] **Passo 5** — **Não implementar CRC, ACK nem dedup próprios** (RN36). A resposta de cada
      bloco é a confirmação daquele bloco; a garantia ponta a ponta é o sha256 do `fAtuFecha`, que
      já existe. Se a tentação de "só um CRCzinho" aparecer, ela é o começo de um segundo
      protocolo de quadro — e manter dois é exatamente o que esta fase evita.
- [ ] **Passo 6** — `pFecha` no `finally` de quem usa; `Destroy` fecha se ainda estiver aberto.
- [ ] **Passo 7** — Compilar `libTefCitel.dproj`. Verificar: compila limpo.
- [ ] **Passo 8** — Backup do marco.

---

### Tarefa 4 — Caminho rápido com fallback em `fEnviaPacote`

**Arquivos:**
- Modificar: `libTefCitel\untTefCitelDvcAtualizacao.pas:272-318` (o laço de `pAtuParte`)

**Interfaces consumidas:** `TTefCitelDvcUpdateTransporte` (Tarefa 3).

O `pAtuAbre` (linha 288) e o `fAtuFecha` (linha 319) **ficam exatamente como estão** — é o
`fAtuFecha` que confere o sha256 e promove o `.parcial` (RF44). Só o miolo muda.

- [ ] **Passo 1** — Antes do laço, tentar `fAbre`. Falhou → logar o motivo e seguir pelo laço de
      hoje, sem alterar nada nele. Este é o RF45, e é o passo que garante que estação sem a DLL
      nova continua atualizando.
- [ ] **Passo 2** — Abriu → mesmo laço de leitura do arquivo, mas com
      `TEF_ATU_TAMANHO_BLOCO_RAPIDO` no lugar de `TEF_ATU_TAMANHO_PARTE`, e `fEnviaBloco` no
      lugar do `fChamaRpcAtualizacao('pAtuParte', ...)`. O `seq` continua sequencial a partir de
      0 — a guarda de ordem do `pParte` não muda.
- [ ] **Passo 3** — `fEnviaBloco` devolveu False **no meio da transferência**: fechar o canal,
      logar, e **reiniciar o pacote do zero pelo caminho lento**, do `pAtuAbre`. Não tentar
      emendar: o `.parcial` já tem bytes do caminho rápido e a recepção anterior precisa ser
      descartada — o serviço já sabe fazer isso quando chega um `pAtuAbre` novo
      (`"Recepcao anterior do pacote ... DESCARTADA"`, visto no log de 16/09).
- [ ] **Passo 4** — `pProgresso` continua sendo chamado a cada bloco, com os mesmos argumentos.
      A tela de carga não muda (RF46) — só anda mais rápido.
- [ ] **Passo 5** — `pFecha` em `finally`, cobrindo também o caminho de exceção. Conferir que
      **nenhuma exceção do canal rápido escapa** de `fAtualizaEstacaoTef` (RN38/RN23): o `except`
      que já existe no fim da função cobre, mas o caminho novo tem que passar por ele — falha na
      atualização nunca pode derrubar a carga do TEF.
- [ ] **Passo 6** — Log explícito de qual caminho foi usado, uma linha por pacote:
      `"Atualizacao: pacote X enviado pelo canal RAPIDO (N blocos, N ms)"` ou
      `"... pelo caminho LENTO (motivo: ...)"`. Sem isso não há como saber, num log de campo, se
      o caminho rápido atuou — foi exatamente o que custou tempo na leitura de 16/09.
- [ ] **Passo 7** — Compilar. Verificar: compila limpo.
- [ ] **Passo 8** — Backup do marco.

---

### Tarefa 5 — Instalação e registro

**Arquivos:**
- Modificar: `libTefCitel\Estacao\install\register-plugin.ps1`
- Modificar: `libTefCitel\Estacao\install\unregister-plugin.ps1`
- Modificar: `libTefCitel\Estacao\install\install-service.ps1`

- [ ] **Passo 1** — `register-plugin.ps1` passa a registrar as **duas** DLLs. A de volume
      (`TefCitelDvcUpdate.dll`) é **opcional**: ausente → aviso e segue, sem falhar o registro do
      plug-in principal. O RF45 garante que a estação funciona sem ela.
- [ ] **Passo 2** — `unregister-plugin.ps1` remove as duas chaves, tolerando a ausência de
      qualquer uma.
- [ ] **Passo 3** — `install-service.ps1` passa a copiar a DLL nova junto, mantendo a pasta
      **única e flat** que o `pExtraiZip` exige (ele ignora entrada com subpasta).
- [ ] **Passo 4** — Verificar em máquina de teste: `regsvr32` das duas, conferir as duas chaves em
      `HKCU:\Software\Microsoft\Terminal Server Client\Default\AddIns\`, e `regsvr32 /u` limpando
      as duas.
- [ ] **Passo 5** — Backup do marco.

---

### Tarefa 6 — Projetos, contrato de validação e bateria

**Arquivos:**
- Modificar: o groupproj que compila o `libTefCitel` — incluir `TefCitelDvcUpdate.dproj` Win32 e
  Win64
- Criar: seção de roteiro no `IA\specs\456190\record.md`

- [ ] **Passo 1** — Registrar o projeto novo no groupproj. Pela regra do CLAUDE.md, editar o
      `.dpr` para units e deixar a IDE sincronizar o `.dproj`; o groupproj é a fonte de verdade
      do que compila.
- [ ] **Passo 2** — **Entregável de quem implementa:** a lista de casos da seção 12.3 da spec,
      com o que olhar em cada log. Os casos são escritos pelo analista; o que sai daqui é o
      contrato. Transcrever os 8 critérios com a linha de log correspondente a cada um.
- [ ] **Passo 3** — Roteiro da bateria, nesta ordem:
      1. Estação **sem** a DLL nova → confirmar `"caminho LENTO (motivo: ...)"` e atualização
         normal. É o fallback, e é o que protege produção.
      2. Estação **com** a DLL nova → confirmar `"canal RAPIDO"`, medir o tempo, comparar com os
         154 s.
      3. `fAtuFecha` conferindo o mesmo sha256, pacote aplicado com todos os arquivos.
      4. **Uma transação de cartão completa logo depois** — critério 7 da spec, o risco que não
         dá para eliminar no papel.
      5. Conferir no `TefCitelDvcTransporte.log` que **não** apareceu nada novo de
         `quadro duplicado descartado` nem `sem ACK` durante e depois da transferência —
         critério 8, a prova de que o canal de transação não foi afetado.
- [ ] **Passo 4** — Backup do marco.

---

### Ordem e dependências

Tarefas 1, 2 e 3 são independentes entre si e podem ser feitas em qualquer ordem. A 4 depende da
3. A 5 depende da 1. A 6 depende de todas. **Nada é observável em estação antes da 4 estar
pronta** — ver a última restrição global.

---

## 12. Fase 7 — Instalador da estação: plano técnico (2026-09-19)

Contrato em `specs.md` §13. **Nenhuma linha de Delphi muda nesta fase** — a entrega é um `.iss`,
estimado em **450–600 linhas**, mais a decisão de onde ele é compilado.

### 12.1 Quatro achados do fonte que moldaram o desenho

Levantados antes de desenhar. Cada um elimina uma complicação que o desenho teria tido.

**1. O registro do plug-in é UM valor de registro — `regsvr32` é dispensável.**
`DllRegisterServer` (`libTefCitel\Estacao\ClientPlugin\TefCitelDvcPlugin.dpr:63`) não registra
CLSID, não registra type library, não faz nada de COM. Escreve exatamente isto:

```
HKCU\Software\Microsoft\Terminal Server Client\Default\AddIns\TefCitelCh
    Name = <caminho completo da DLL>
```

E o `TefCitelDvcUpdate.dll` faz o mesmo em `...\AddIns\TefCitelUpd`. **Consequência:** o Inno
escreve esses valores direto. Sai o `regsvr32` do caminho — um processo a menos que o antivírus
olha torto, um código de erro a menos para traduzir, e a liberdade de escolher a raiz do registro,
que é o item seguinte.

**2. Os dois listeners são só loopback — não há regra de firewall.**
`untTefEstacaoTcpTransporte.pas:915` e `untTefEstacaoUpdateListener.pas:162` fazem `bind` em
`127.0.0.1`. Virou RN40 justamente para sobreviver à revisão.

**3. O cliente TSPlus é de 32 bits.** Nesta máquina o `TSPLClient.dll` está em
`C:\Program Files (x86)\Connection Client\RDP6\`. Cliente de 32 bits carrega **DLL de 32 bits** —
o que derruba o default `Win64` dos `.ps1` atuais (certo para o `mstsc` moderno, errado para
TSPlus). Bitness deixou de ser detalhe de linha de comando e virou decisão do instalador (§12.5).

**4. Windows 7 RTM tem PowerShell 2.0**, onde `Add-MpPreference` não existe. Um instalador
apoiado nos `.ps1` atuais não cumpriria o piso pedido — foi o **argumento decisivo pelo Inno
Setup**, cujo runtime não depende de PowerShell nem de .NET.

### 12.2 Por que HKLM não serve — e a pista que enganou

A primeira leitura foi que o multiusuário se resolveria gravando em HKLM, porque nesta máquina
existe isto:

```
HKLM\...\Terminal Server Client\Default\AddIns
    webauthn    -> C:\Windows\System32\webauthn.dll      <- plug-in DVC do proprio Windows
    TSPLClient  -> C:\Program Files (x86)\...\TSPLClient.dll
```

**Era indício, não prova, e a documentação diz o contrário.** A página oficial de registro de
plug-in DVC lista **uma única** raiz:

> *"Writing the plug-in entry to the following location in the registry on the computer where the
> Remote Desktop Connection (RDC) client process is started:*
> **HKEY_CURRENT_USER**\Software\Microsoft\Terminal Server Client\Default\AddIns\\*unique plug-in name*"

Fonte: <https://learn.microsoft.com/en-us/windows/win32/termserv/dvc-plug-in-registration>

HKLM não aparece em nenhum ponto do texto. As duas entradas acima podem estar sendo carregadas por
outro caminho — o `IMsTscAdvancedSettings::put_PluginDlls` do controle ActiveX, que a mesma página
descreve como método alternativo e que um cliente próprio (o do TSPlus) usaria com naturalidade.

**Não repetir essa hipótese.** E fica a lição de método: presença de chave no registro prova que
alguém escreveu ali, nunca que o consumidor lê dali.

O **segundo** motivo para não gravar `HKCU` direto é independente deste e sobrevive a ele: o setup
roda elevado, e o `HKCU` do setup é o da conta que elevou (RN42). Por isso o §12.6 existe.

### 12.3 Estrutura do `.iss`

Arquivo novo: `libTefCitel\Estacao\install\TefCitelEstacao.iss`, ao lado dos `.ps1` que ele
substitui na prática (os `.ps1` **ficam**, são a ferramenta de bancada de quem desenvolve).

| Seção | Conteúdo |
|---|---|
| `[Setup]` | `AppName`, `AppVersion` (§12.13 ponto 3), `DefaultDirName={sd}\Tef_Citel`, `PrivilegesRequired=admin`, `MinVersion=6.1` (ver §12.15), `OutputDir=.`, `OutputBaseFilename=TefCitelEstacaoSetup`, `Uninstallable=yes` |
| `[Files]` | os da RF47, todos por caminho **relativo** à saída `Release` da IDE; as DLLs de plug-in com `Check: fEscolheuWin32` / `fEscolheuWin64`. O `borlndmm.dll` é o único que vem de fora da árvore da estação (`{#Repo}\padra_atualizado\`) |
| `[Tasks]` | `defender` (marcada por padrão), `udprdp` (desmarcada) |
| `[Run]` / `[UninstallRun]` | `/install /silent`, `sc config`, `sc failure`, `schtasks /create`, `Start-Service`; os inversos na desinstalação |
| `[Registry]` | **só** o `fClientDisableUDP`, com `uninsdeletevalue`. As chaves de plug-in **não** entram aqui — vão pelo `[Code]`, porque a raiz é calculada (§12.6) |
| `[Code]` | o grosso: importação de `wtsapi32.dll`/`advapi32.dll`, `fVersaoSuportada`, heurística de bitness, página de bitness, resolução do SID, gravação, tela final, cópia do log |

### 12.4 Sequência da instalação

O que é **fatal** (aborta e desfaz) e o que é **aviso** (registra e segue) está decidido item a
item, pelo critério da RN44 — só aborta o que impede o TEF de funcionar.

| # | Passo | Falha é |
|---|---|---|
| 1 | Exigir elevação (`PrivilegesRequired=admin`, o Inno pede sozinho) | fatal |
| 2 | Detectar versão do Windows e registrar no log (`fVersaoSuportada`) | **aviso** |
| 3 | Detectar bitness do cliente RDP (§12.5) | **aviso** — cai no default e deixa escolher |
| 4 | Se já houver instalação: parar o `TefEstacaoService` e **esperar o processo sair** | fatal |
| 5 | Copiar os arquivos para a pasta | fatal |
| 6 | `TefEstacaoService.exe /install /silent` | fatal |
| 7 | `sc config start= auto` + `sc failure restart/5000 ×3` | fatal |
| 8a | Resolver o usuário da sessão interativa e gravar no hive dele (§12.6.1) | `TefCitelCh` fatal, `TefCitelUpd` **aviso** |
| 8b | Criar a tarefa de logon (§12.6.2) | **fatal** — sem ela a estação fica com TEF só para quem estava logado na instalação |
| 9 | Exclusão no Defender (§12.7) | **aviso** |
| 10 | UDP do RDP, se marcado (§12.7) | **aviso** |
| 11 | `Start-Service` | fatal |
| 12 | Tela final (RF57) e cópia do log para `<pasta>\instalacao.log` | — |

**O passo 4 tem uma armadilha já resolvida neste requisito:** executável em uso não pode ser
sobrescrito, e esperar o `STOPPED` do SCM **não basta**. É preciso esperar o **processo sair** —
exatamente o que o `TefEstacaoAtualizador.exe` já faz e está medido ("processo do serviço saiu
0 ms depois do SCM dizer STOPPED", em toda bateria). O instalador repete essa espera, com teto e
mensagem própria.

### 12.5 Bitness — como o instalador decide

Ordem, parando na primeira que responder:

1. **TSPlus instalado?** Existe `HKLM\...\AddIns\TSPLClient`, **ou** o arquivo em
   `%ProgramFiles(x86)%\Connection Client\RDP6\TSPLClient.dll`? → **Win32**.
2. **SO de 32 bits?** (`not IsWin64`) → **Win32**.
3. Nenhuma das anteriores → **Win64** (o `mstsc` de `System32` em Windows x64).

O resultado aparece numa página do assistente como combo já preenchido, com o motivo ao lado
("TSPlus detectado"), e o técnico pode trocar. A heurística **vai** errar em alguma loja; quando
errar, o sintoma é o canal não abrir — hoje já com a mensagem certa na tela do autcom, desde o
conserto de 19/09. **Nunca registrar as duas** (RN41): o nome é a chave.

### 12.6 Registro por usuário — duas camadas

Dois problemas (§12.2): o registro é **por usuário**, e o instalador roda **elevado**. São dois
mecanismos com papéis diferentes — um resolve **agora**, o outro **daqui para frente**.

#### 12.6.1 Agora: gravar no hive de quem está logado

```
WTSGetActiveConsoleSessionId()                               -> id da sessao interativa
WTSQuerySessionInformation(..., WTSUserName)                 -> nome do usuario logado
LookupAccountName()                                          -> SID dele
HKEY_USERS\<SID>\Software\Microsoft\Terminal Server Client\Default\AddIns\TefCitelCh
    Name = <pasta>\TefCitelDvcPlugin.dll
```

Funciona **sem montar hive nenhum**: o de quem está logado já está carregado, e é por isso que a
`HKEY_USERS` o enxerga. Duas chamadas Win32 documentadas, disponíveis desde o Windows XP/2003,
importadas na seção `[Code]` com `external 'WTSGetActiveConsoleSessionId@kernel32.dll stdcall'` e
`'WTSQuerySessionInformationW@wtsapi32.dll stdcall'`.

Quando a conta que elevou **é** a do operador, os dois caminhos levam ao mesmo lugar; o código não
distingue os casos, sempre resolve o SID e grava lá.

**Efeito prático: logoff nunca é necessário.** Depois da instalação basta **reconectar a sessão
RDP** — que já era obrigatório de qualquer forma, porque o cliente RDP só lê o registro ao
iniciar. Isso é metade da RF57.

#### 12.6.2 Todos os outros: tarefa de logon

Cenário real: o suporte acessa a estação por acesso remoto, instala na sessão de quem está logado,
fecha e vai embora. A mesma máquina tem o **usuário A** e o **usuário N**, e quando o N entrar ele
**não** pode ter de rodar o instalador de novo.

O N entra por aqui, e com folga: ele **loga no Windows e só depois clica no atalho do RDP** na
área de trabalho. A tarefa dispara no logon; entre ela e o clique há segundos ou minutos.

```
schtasks /create /tn "CitelTefRegistraPlugin" /sc onlogon /rl limited /f ^
  /tr "reg add \"HKCU\Software\Microsoft\Terminal Server Client\Default\AddIns\TefCitelCh\" ^
       /v Name /t REG_SZ /d \"C:\Tef_Citel\TefCitelDvcPlugin.dll\" /f"
```

Por que assim, e não de outro jeito:

- **Roda como o usuário que logou**, então o `HKCU` é sempre o certo — inclusive quando o
  instalador foi elevado por outra conta;
- **Auto-reparável**: usuário novo, perfil recriado, alguém que limpou o registro — no próximo
  logon está de volta, sem chamado;
- **Não precisa de binário novo.** É `reg.exe`, que existe desde o Windows 2000. Um executável
  próprio seria mais uma superfície para o antivírus, num requisito que já tem esse problema;
- **Oculta**, sem janela de console piscando no logon do caixa — que é o que uma entrada em
  `HKLM\...\Run` daria;
- **`/rl limited`**: não pede nem usa elevação, porque gravar no próprio `HKCU` não precisa.

O `TefCitelUpd` entra nas duas camadas e segue opcional nas duas: se a DLL não estiver na pasta, a
chave simplesmente não é criada em lugar nenhum.

### 12.7 Defender e UDP

**Exclusão no Defender**, em ordem de preferência:
`powershell -Command "Add-MpPreference -ExclusionPath '<pasta>'"` — existe do Windows 8/2012 em
diante com o Defender ativo; se o comando falhar ou o PowerShell não existir (Windows 7),
**registra no log e segue**. Nunca aborta (RN44). Exclui **a pasta**, não os dois `.exe`.

**UDP do RDP** — a chave `HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client` já
existe nesta máquina com outras políticas de USB, então é terreno conhecido. O desinstalador
remove **apenas o valor**, nunca a chave, e só se foi ele quem o criou — marca gravada no próprio
registro do desinstalador. Falta confirmar o nome `fClientDisableUDP` numa estação (§12.13).

### 12.8 Piso de sistema operacional

`MinVersion=0`; `fVersaoSuportada` em `InitializeSetup` concentra a política e hoje sempre devolve
permitido. Transformar isso em trava depois é mudar o `Result` de uma função, num lugar só.

O que **de fato** limita o piso, e vale estar escrito para o dia em que alguém perguntar:

| Componente | Piso real |
|---|---|
| Canal DVC (`WTSVirtualChannelOpenEx` dinâmico) | Windows 7 / RDP 7.0 |
| Serviço Windows, `sc.exe`, registro | Windows 2000 |
| `Add-MpPreference` | Windows 8 / Defender ativo — degrada com aviso |
| Inno Setup (runtime gerado) | Windows 2000 |

**O canal DVC é o piso**, e ele bate com o Windows 7 citado. Não é coincidência — é o mesmo limite.

### 12.9 Desinstalação

Ordem inversa, com a regra da RN45. O ponto que **não pode ser trocado de lugar**: remover a
tarefa agendada **antes** de apagar a chave, senão o próximo logon recria o que o passo seguinte
acabou de apagar.

1. Parar o serviço e esperar o processo sair;
2. `TefEstacaoService.exe /uninstall /silent`;
3. `schtasks /delete /tn CitelTefRegistraPlugin /f` e **depois** apagar `TefCitelCh`/`TefCitelUpd`
   do hive do usuário interativo (o que a instalação alcançou diretamente). **O hive dos demais
   fica como está** — montar perfil na desinstalação para limpar isso traria de volta, na saída, o
   risco que a RN43 deliberadamente não corre;
4. `Remove-MpPreference`, em modo avisa-e-segue;
5. Remover `fClientDisableUDP` **se** o instalador o criou;
6. Apagar os arquivos que o instalador copiou.

### 12.10 Layout em disco

```
C:\Tef_Citel\
    TefEstacaoService.exe
    TefEstacaoAtualizador.exe
    borlndmm.dll                   (ShareMem do servico - sem ela ele nao sobe)
    TefCitelDvcPlugin.dll          (a bitness escolhida)
    TefCitelDvcUpdate.dll          (idem, se aplicável)
    unins000.exe / unins000.dat    (Inno Setup)
    instalacao.log                 (o log desta instalação, copiado para cá)
    --- criados em tempo de execução, não pelo instalador ---
    libTefCitel.dll                (1ª carga do autcom)
    scope.ini, CliSiTef.ini, CONFITLS.ini
    DLLs do Scope / CliSiTef
    TefEstacaoVersao.ini
    _Preparo\  _Falhou\
    *.log
```

### 12.11 Arquivos impactados

- **Criar:** `libTefCitel\Estacao\install\TefCitelEstacao.iss`
- **Criar:** `libTefCitel\Estacao\install\README-instalador.md` — como gerar o `setup.exe`, de
  onde vêm os binários das duas bitness, e o que conferir antes de publicar
- **Manter como estão:** `register-plugin.ps1`, `unregister-plugin.ps1`, `install-service.ps1` —
  continuam sendo a ferramenta de bancada; o instalador **não** os chama
- **Nenhum `.pas`, `.dpr`, `.dproj` ou `.groupproj` muda** — salvo a decisão do §12.13 ponto 2, se
  a compilação do setup entrar num groupproj

### 12.12 Conformidade com padrões do projeto

O `.iss` é Pascal Script, não Object Pascal do projeto — a convenção húngara e os prefixos `p`/`f`
das units **não** se aplicam mecanicamente. Ainda assim, as funções do `[Code]` usam `f`/`p` e
nomes em português (`fVersaoSuportada`, `fResolveSidSessaoInterativa`, `pGravaChavePlugin`) pela
mesma razão de sempre: quem vai manter isso é quem mantém o resto. Textos de tela e de log em
português, como no restante do requisito.

### 12.13 Pontos em aberto

Repetidos do `specs.md` §13.7 por serem decisões de implementação. **Nenhum bloqueia começar.**

1. **Nome do valor do UDP** — confirmar `fClientDisableUDP` na primeira instalação de teste.
2. ~~**Onde o `setup.exe` é construído.**~~ **DECIDIDO em 2026-09-20:** `OutputDir=.`, o
   `setup.exe` nasce na própria pasta `install`, ao lado do `.iss`. As origens dos binários são
   relativas e apontam para a saída **`Release`** da IDE. Fica em aberto só se a compilação do
   setup entra em algum `.groupproj` ou segue manual, como o build da IDE.
3. **Versão do setup** para o Adicionar/Remover Programas — proposto: a mesma revisão do SVN que o
   `rev.inc` já carrega.
4. **A tarefa agendada e o antivírus** — candidata a aparecer no primeiro teste em máquina com AV
   de terceiro.

### 12.14 Adiado conscientemente, e por quê

Duas coisas foram consideradas e ficaram de fora. Ficam registradas porque são exatamente as
perguntas que quem revisar o desenho vai refazer.

**1. Varrer os SIDs já carregados em `HKEY_USERS`.** Cobriria o usuário logado que **não vai logar
de novo** — troca rápida de usuário, ou sessão desconectada e reconectada, que não gera evento de
logon. Não tem risco nenhum (escrita comum em hive já montado). Adiado por ser improvável nesta
operação; o sintoma e o remédio de campo estão no `specs.md` §13.6.

**2. `reg load` do `NTUSER.DAT` de perfis deslogados.** Uma versão anterior deste desenho montava
o hive de cada perfil do `ProfileList` para registrar todos na hora da instalação. A justificativa
era uma corrida entre a tarefa de logon e o cliente RDP — *"se o cliente RDP estiver no Startup
dele, pode ler o registro antes de a tarefa gravar"*. **A premissa do Startup era minha, não do
campo**: o fluxo real é o usuário logar e **depois clicar num atalho**, e a tarefa ganha com
sobra.

E o preço era alto: `reg load` sem o `reg unload` correspondente **impede o logon daquele
usuário** — era o único passo do instalador capaz de deixar a máquina pior do que a encontrou.
Risco concreto contra cenário hipotético é troca ruim. **Não deve voltar sem que o cenário
apareça de verdade** (RN43).

### 12.15 Achados da implementação (2026-09-20)

O `.iss` foi escrito e **compila limpo** no Inno Setup 6.4.2 (o único aviso restante é
deliberado — ver abaixo). O que a compilação ensinou, na ordem em que apareceu:

**1. `MinVersion=0` não compila.** O Inno 6.4 rejeita: *"Minimum version specified by MinVersion
must be at least 6.1 otherwise Setup will never run."* O runtime do Inno 6 não roda abaixo do
Windows 7 — a linha da tabela do §12.8 que dizia "Inno Setup (runtime gerado) → Windows 2000" era
verdade do Inno 5. Ficou `MinVersion=6.1`, que **coincide com o piso do canal DVC**, e a política
de versão segue morando em `fVersaoSuportada`.

O compilador ainda recomenda `6.1sp1`; ficou em `6.1` de propósito, porque o piso é o Windows 7
inclusive RTM.

**2. Linha começando com `[` dentro de `[Code]` é lida como tag de seção.** O Inno olha o primeiro
caractere não-branco da linha, então uma continuação de `Format(...)` indentada que começasse com
o colchete do array abortava a compilação com "Invalid section tag" — a 300 linhas do erro real.
Duas chamadas precisaram ser requebradas. **Vale para quem for editar o arquivo:** nunca deixar o
`[` do array abrir uma linha.

**3. `GetTickCount` não é função nativa do Inno.** Precisa de `external` — está declarada junto
das demais importações do `kernel32`.

**4. `FileCopy` foi renomeada para `CopyFile`** no Inno 6.4 (funciona, mas emite hint).

**5. Desvio no §12.6.1, e é um upgrade.** O `LookupAccountName` do desenho saiu. O Pascal Script
não marshalla SID binário, e a conversão pediria três APIs a mais. O caminho implementado casa o
nome vindo do `WTSQuerySessionInformation` contra `Volatile Environment\USERNAME` de cada SID já
presente em `HKEY_USERS`, com reserva por `SESSIONNAME = Console`.

É **estritamente mais forte**: o `LookupAccountName` devolveria SID válido mesmo com o hive
descarregado, e gravar ali não criaria nada útil. Achar o SID dentro de `HKEY_USERS` **prova hive
carregado** — que é a condição de que a gravação depende. O desenho pedia a API certa pelo motivo
certo; a implementação chegou ao mesmo alvo por um caminho que também verifica a precondição.

**6. A página de bitness é de rádio, não combo.** `CreateInputOptionPage` com duas opções
exclusivas e o motivo da detecção no subtítulo. Mesma informação, mesma possibilidade de troca,
menos código.

**7. A RN45 do UDP saiu de graça, por um `Check`.** `fPrecisaGravarUdp` devolve False quando a
política já está em 1; nesse caso o Inno não processa a entrada e, não a processando, **não
registra o `uninsdeletevalue`** — a desinstalação não apaga o que o instalador não colocou. A
"marca no registro do próprio desinstalador" que o desenho previa não foi necessária.

**8. A janela de console da tarefa de logon não foi resolvida** — ver `specs.md` §13.8 item 4. É
o único ponto do desenho que a implementação não cumpre, e a saída boa (switch `/registraplugin`
no `TefEstacaoService.exe`, que é subsistema GUI e não abre console) depende de decisão sobre a
fronteira "sem Delphi" da §13.5.

**O que a compilação NÃO prova.** Ela valida a sintaxe e a tipagem de todo o `[Code]` — foi ela
que pegou os itens 2, 3 e 4. **Não** exercita nada em tempo de execução: as chamadas ao WTS, ao
SCM, o `schtasks`, o `Add-MpPreference` e a resolução do SID só se provam numa instalação de
verdade, que é o Passo 10 do `tasks.md`.

### 12.16 Assinatura digital — diagnóstico do assinador e a solução (2026-09-20)

Contrato em `specs.md` §13.9. O Rafael pediu para descobrir por que a pasta `Assinador` dele não
funcionava e, funcionando, incorporá-la ao instalador.

#### Por que o `Assinador` não assinava — três camadas, na ordem em que aparecem

A pasta tem `Assinador.exe` (34 MB), `LEIA-ME.txt`, e uma subpasta `Certificado` com
`mycert.pfx`, `capicom.dll` e `signtool.exe`. O `Assinador.exe` varre uma pasta e manda o
`signtool` assinar cada `.exe`/`.dll`/`.bpl`.

Rodando numa pasta de teste, ele terminava com **código 0** e gravava
`RELARQSEMASS.TXT` dizendo `(PRECISA ASSINAR)` — ou seja, ele *sabia* que falhou, mas não dizia
por quê e não devolvia erro. Chamando o `signtool` daquela pasta diretamente, o motivo apareceu:

```
SignTool Error: Signtool requires CAPICOM version 2.1.0.1 or higher.
```

**Camada 1 — CAPICOM.** Aquele `signtool.exe` é a versão **5.2.3790.1830**, do SDK do **Windows
Server 2003**, e depende do CAPICOM registrado como COM. O `capicom.dll` está na pasta, e nesta
máquina o CAPICOM até está registrado — **mas só na visão de 64 bits** (`HKLM\SOFTWARE\Classes`),
e o signtool é de 32 bits, então procura no `Wow6432Node` e não acha. O CAPICOM foi aposentado
pela Microsoft por questões de segurança; registrá-lo de novo numa máquina de build não é caminho.

**Camada 2 — SHA-1.** Mesmo com o CAPICOM resolvido, aquele signtool só produz assinatura SHA-1.
Não tem `/fd` nem `/tr`. O Windows moderno não aceita SHA-1 para arquivo assinado hoje, então o
esforço não compraria nada.

**Camada 3, e é a que bloqueia de verdade — a senha.** Trocando o signtool antigo pelo do
Windows 10 SDK numa **cópia** da pasta, o `Assinador.exe` continuou falhando. Chamando o signtool
novo direto:

```
SignTool Error: The specified PFX password is not correct.
```

O `mycert.pfx` tem senha, e nem o `Assinador.exe` nem a linha de comando a fornecem. **Essa é a
causa raiz**; as outras duas apareceriam em seguida.

#### O que foi feito em vez de consertar o `Assinador`

O `Assinador.exe` é um laço sobre uma pasta chamando `signtool`. O Inno Setup já faz exatamente
isso, no momento certo do build e arquivo por arquivo, com `SignTool=` e a flag `signonce`. Então
a integração é **nativa do Inno**, e não um `.exe` de 34 MB pendurado no build:

| Arquivo novo | Papel |
|---|---|
| `assinar-arquivo.cmd` | assina UM arquivo. É o que o Inno chama, uma vez por arquivo, uma vez para o `setup.exe` e uma para o desinstalador |
| `build-setup.cmd` | o ponto de entrada do build. Resolve ISCC e signtool, registra o assinador via `/Scitel=...`, e confere a assinatura do setup ao fim |

No `.iss`: `SignTool=citel`, `SignedUninstaller=yes`, `signonce` em cada `Source` — tudo dentro de
`#ifndef SemAssinatura`, para o modo bancada continuar existindo.

**`signonce` e não `sign`:** ele pula arquivo já assinado, o que protege o `borlndmm.dll` da
Embarcadero. Por clareza, o `borlndmm` também não leva a flag.

#### Comportamento confirmado em teste

Validado ponta a ponta com um **certificado autoassinado descartável**, criado e apagado do
repositório de certificados na hora, e com os seis binários de `Release` salvos antes e
restaurados depois (hashes conferidos um a um):

- os **seis** binários foram assinados, o `uninst.e32.tmp` e o `setup.exe` também;
- o `borlndmm.dll` **não** apareceu na lista — a exclusão funciona;
- `Status = UnknownError` apenas por a raiz do certificado de teste não ser confiável; a
  assinatura e o **carimbo de tempo** estavam presentes.

**O Inno assina o arquivo NA ORIGEM, não uma cópia temporária.** As linhas de log nomeiam
`...\Release\TefEstacaoService.exe`, e o hash do arquivo em disco muda. Como aquelas pastas não
são versionadas e a IDE as regenera, é inofensivo — mas precisa estar escrito (RN50).

#### Quatro armadilhas do `cmd` que os dois `.cmd` evitam de propósito

Cada uma custou um build que falhava sem dizer por quê. Estão comentadas no cabeçalho do
`assinar-arquivo.cmd` porque quem editar aquilo vai reintroduzi-las:

1. **`%ProgramFiles(x86)%` dentro de bloco `if (...)`.** Num bloco entre parênteses o cmd expande
   as variáveis **antes** de reavaliar a estrutura, então o `)` de `(x86)` **no valor** fecha o
   bloco e o resto vira comando solto — `\Windows foi inesperado neste momento`. Aspas não
   protegem. Por isso os dois arquivos usam `if ... goto` e sub-rotina, sem blocos.
2. **Padrão de `findstr` terminando em barra invertida.** `/c:"\x64\"` nunca casa: o `\"` final
   vira aspas literais no parsing de argumentos. É `/c:"\x64"`.
3. **`dir /b /s` não aceita curinga no meio do caminho** — só recursão a partir do nome do
   arquivo. Daí a listagem inteira e o `findstr` escolhendo a arquitetura.
4. **`EnableDelayedExpansion` não é usado**, de propósito: uma senha que contenha `!` seria comida
   pela expansão atrasada.

#### O que falta

**A senha do `mycert.pfx`.** Nada foi assinado com o certificado real. Com ela, é uma linha:
`set CITEL_ASSINA_SENHA=...` e `build-setup.cmd`.

Junto disso, três coisas só se sabem quando o certificado abrir: se **está válido ou expirado**,
qual o **nome do titular** que vai aparecer no diálogo de elevação, e se a cadeia dele é confiável
numa estação de loja.

### 12.17 Primeira instalação em campo: o impasse de bootstrap (2026-09-20)

Contrato em `specs.md` §13.10. Registro do que os logs disseram e de como se chegou lá, porque o
sintoma apontava para outro componente.

#### O que os logs entregaram

`TefEstacaoService.log`, três linhas que resolvem o caso:

```
Frame "chamada" recebido: metodo="fAtuConsulta".
Instanciando ITefCitel real para o pid=143284 (opcao="T", path="")...
Metodo "fAtuConsulta" (id=1) lancou excecao: External exception C06D007E
```

`C06D007E` não é um código genérico: é o que o Delphi levanta quando um `external ... delayed`
**não acha o módulo** (`0xC06D007F` seria "não achou a função"). O módulo é o `libTefCitel.dll`, e
o `conferencia.txt` da mesma estação confirma que ele não estava na pasta.

Doze segundos depois, `fConfiguraTefCitel` falhou pelo mesmo motivo — e foi esse que produziu a
mensagem na tela do operador. A degradação de 19/09 funcionou: AVISO, não madExcept.

#### A cadeia

`pDespachaChamadaEmThreadPropria` → `pAtualizaContexto` → `fGaranteSessao` → `fCriarTefCitel`
(`untTefEstacaoRoteadorMensagens.pas:2081`, o `external 'libTefCitel.dll' delayed`).

`pAtualizaContexto` rodava para **todo** método, e `fGaranteSessao` criava a `ITefCitel` real
antes do despacho. Os cinco handlers da Fase 6 (`fMetodoFAtuConsulta` e irmãos) **não referenciam
sessão nem `ITefCitel`** — são `FAtualizacao` puro, disco e SCM. A sessão era criada à toa, e era
a criação que matava a chamada.

O código chegou perto de ver isso: o comentário longo em `fMetodoUsaPinpad` explica que os cinco
rodam **antes** do `fConfiguraTefCitel` e por isso não podem exigir pinpad configurado. Faltou o
passo seguinte — eles também não podem exigir a **instância**, porque a instância exige a DLL.

#### O conserto no roteador

Um predicado irmão do `fMetodoUsaPinpad`, na mesma linguagem de desenho:

- `fMetodoDispensaTefCitel(const AstrMetodo: String): Boolean` — lista dos cinco;
- `pAtualizaContexto` passou a receber `const AstrMetodo: String` e **sai antes** de
  `fGaranteSessao` quando o predicado responde True;
- o ponto de chamada já tinha `LstrMetodo` em escopo — nenhum encanamento novo.

**Por que sair cedo é seguro, verificado antes de escrever:**

- nenhum dos cinco handlers usa `fSessaoDaThread` nem `fTefDaThread`;
- todos os usos de `fSessaoDaThread` **depois** do despacho estão dentro de ramos
  `if LstrMetodo = 'fPassarCartao'` / `'fFinalizarTransacao'`, que os cinco nunca alcançam;
- `fSessaoDaThread` devolve `nil` sem levantar; quem levanta é `fTefDaThread`, que eles não
  chamam;
- o reenvio da fila local fica **acima** da saída, de propósito: é por conexão e não depende de
  sessão.

Não há timeout novo e o protocolo de quadro não foi tocado — as duas coisas que
`IA\rules\tef-dvc.md` protege.

#### A semente no instalador

`libTefCitel.dll` de `padra_atualizado\`, com `onlyifdoesntexist uninsneveruninstall` e **sem**
flag de assinatura (é binário do AUTCOM, não da estação — mesmo tratamento do `borlndmm.dll`).

Não conflita com a decisão de `untTefCitelDvcAtualizacao.pas:240`, que manda a DLL **do AUTCOM que
está rodando** para servidor e estação nunca divergirem: a semente é substituída na primeira carga
se o hash diferir. Ela só evita que a primeira carga precise transferir a DLL e reiniciar o
serviço.

#### Verificação feita, e o que ela não cobre

Compilado com **saída redirecionada** para o scratchpad
(`msbuild /p:DCC_ExeOutput=... /p:DCC_DcuOutput=...`), Release/Win32: **0 erros**, só o
`W1002 DELAYED is specific to a platform` que já existia. A primeira tentativa pegou um erro real
meu — parâmetro na ordem errada na implementação (`E2037`) — que só a compilação acharia.

O redirecionamento não é detalhe: a §12.8 desta pasta e a regra de 11/09 registram que **IDE e
msbuild não produzem o mesmo binário**, e o `Win32\Release\TefEstacaoService.exe` é o que o
instalador empacota. Ele ficou **intocado** (2.739.200 bytes, 09:01); a saída do msbuild deu
2.741.248, no scratchpad.

**Consequência operacional:** o conserto do roteador **ainda não está em nenhum setup**. Precisa
de rebuild do `TefEstacaoService.exe` pela IDE e de um `build-setup.cmd` depois dele.

### 12.18 Os dois ajustes de 2026-09-20 (tarde) — o que foi tocado

Contrato em `specs.md` §13.11.

#### 1. `/install` só quando o serviço não existe

`fInstalaServico`, no `.iss`, passou a chamar `fServicoExiste` primeiro — que reaproveita o
`fAbreServico` já existente, o único lugar que distingue `ERROR_SERVICE_DOES_NOT_EXIST` (1060)
de erro de verdade. Serviço presente: pula o `/install` e roda
`sc config <nome> binPath= "<novo caminho>"`. Ausente: caminho de antes, intacto.

O `binPath` não é detalhe: sem ele, reinstalar numa pasta diferente deixaria o SCM apontando
para a pasta antiga — e o serviço subiria do lugar errado, sem erro nenhum.

#### 2. `fConteudoLogErro` — um RPC novo, nos dois lados na mesma sessão

Seis units, porque é método de interface:

| Unit | O que entrou |
|---|---|
| `untInterfaceTefCitel.pas` | `function fConteudoLogErro: String` na `ITefCitel` |
| `untTefCitel.pas` | lê o próprio `FPathDLL + TEFCitelErro_Log` |
| `untTefCitelNCR.pas` | idem |
| `untTefCitelDvc.pas` | vira `fChamaRpc('fConteudoLogErro', ...)` |
| `Estacao\untTefEstacaoRoteadorMensagens.pas` | despacho + `fMetodoFConteudoLogErro` |
| `padra_atualizado\...\untTefCitelUtil.pas` | ramo DVC em `pMensagemLogErroTef` |

As implementações locais leem **o mesmo caminho que usam para gravar** — se os dois divergirem, o
operador passa a ver um arquivo que não é o que acabou de ser escrito.

`fConteudoLogErro` **não** entra em `fMetodoUsaPinpad`, de propósito: ele pode ser pedido
justamente quando a configuração do pinpad falhou, que é quando o operador mais precisa do log.

Nenhum timeout novo e nenhuma mudança no layout de quadro — as duas coisas que
`IA\rules\tef-dvc.md` protege. O método novo foi espelhado nos dois lados **na mesma sessão**,
como aquela regra exige de qualquer mudança de protocolo.

#### Verificação, e o que ela não alcança

Compilados com saída redirecionada, Release: `libTefCitel.dll` (0 erros), 
`TefEstacaoService.exe` (0 erros, só o `W1002 DELAYED` de sempre) e os dois plug-ins Win64.

**O `untTefCitelUtil.pas` não foi compilado** — ele só compila dentro do `autcom.exe`, que
por sua vez só compila na IDE (pacote `faturamento.impostos.interfaces`). O ramo novo de
`pMensagemLogErroTef` é a única parte desta sessão sem verificação de compilador.

#### Erro meu, registrado para não se repetir

`DCC_DllOutput` **não** redirecionou a saída dos dois plug-ins: o `msbuild` gravou por cima de
`ClientPlugin\Win64\Release\TefCitelDvcPlugin.dll` e
`UpdatePlugin\Win64\Release\TefCitelDvcUpdate.dll`, que eram builds da IDE. O fonte deles não
mudou, então o código é o mesmo — mas o **toolchain** é outro, e a regra de 11/09 registra que
IDE e `msbuild` não produzem o mesmo artefato.

O backup do requisito **não cobre isso**: ele varre as pastas `Debug`, não `Release`, então
não havia cópia para restaurar. Remédio: recompilar os dois na IDE — o que vai acontecer de
qualquer forma, porque `libTefCitel.dll` e `TefEstacaoService.exe` precisam de rebuild nesta
mesma leva.

Para a próxima: `DCC_DllOutput` não é o nome que o `.dproj` destes projetos honra. Antes de
usar redirecionamento como rede de segurança, **conferir o mtime do artefato depois do build** —
foi assim que isto apareceu.
### 12.19 A mensagem de espera antes do `fConfiguraTefCitel` (2026-09-20)

Contrato em `specs.md` §13.12. Uma linha de código e um comentário; o que importa é **onde**.

`untTefCitelUtil.pas`, em `pIniciaTefCitel`, logo após o bloco da atualização e imediatamente
antes de `fLockUnlockTefCitel(True, ...)` — que é a última coisa antes do `fConfiguraTefCitel`.

`AprocStatus('Aguarde, comunicando com o servidor TEF...', 0, 0)`, com `Assigned` antes.

**`AintTotal = 0` é a parte que não é óbvia.** Em `TfrmPrincipal.pStatusCargaTefCitel`
(`untPrincipal.pas`), `AintTotal <= 0` cai no ramo que chama `pStepStatusGravacao` e
`pProcessMessages` e **sai** — troca o texto e repinta, sem tocar em `Max` nem em
`Position`. Qualquer valor positivo entraria no ramo que mexe na barra, e a barra deve continuar
onde a atualização a deixou (RN54). O `pProcessMessages` daquele ramo é o que garante que o
texto novo apareça **antes** da chamada bloqueante.

`AprocStatus` já é usado duas linhas acima, no `fAtualizaEstacaoNaCarga` — mesmo escopo,
nenhum encanamento novo.

**Sem verificação de compilador**, pelo mesmo motivo do ramo de `pMensagemLogErroTef`: esta unit
só compila dentro do `autcom.exe`, que só compila na IDE.
### 12.20 Conferir a escrituração contra o disco (2026-09-20)

Contrato em `specs.md` §13.13. Um arquivo: `Estacao\untTefEstacaoAtualizacao.pas`.

Helper novo `fArquivoQueProva(AstrPacote, AblnAplicado)`, que devolve **o arquivo que prova** a
declaração — ou vazio quando não dá para provar com um arquivo só. Ele reaproveita o
`fNomeNoPreparo` que já existia, de modo que o mapeamento pacote→arquivo continua num lugar só.

| Seção | Alcance | Por quê |
|---|---|---|
| `preparado` | **todos** os pacotes | no `_Preparo` cada pacote é um arquivo só, inclusive os `.zip` |
| `aplicado` | só os de arquivo único | um `.zip` aplicado virou vários arquivos soltos na pasta do serviço |

`fHashAplicado` e `fHashPreparado` passaram a conferir e a **responder vazio** quando o
arquivo não está lá, registrando a linha no log da estação com a sugestão de suspeitar de
antivírus quando se repetir.

**Por que vazio, e não um campo novo no protocolo:** vazio já significa *"nunca"* em todo o
arquivo de versão, e é assim que o lado AUTCOM já decide reenviar. Nenhuma mudança de protocolo,
nenhum caso especial do outro lado — e a compatibilidade com um AUTCOM mais antigo fica de graça.

**Não há risco de laço de reenvio:** o pacote que a estação nunca recebeu já tem hash vazio, então
a conferência nem chega a rodar; e um reenvio que aplique resolve a ausência. Se o reenvio também
falhar, a tentativa se repete **uma vez por carga**, que é exatamente o comportamento desejado de
auto-reparação.

**Verificação:** compilados `TefEstacaoService.exe` e `TefEstacaoAtualizador.exe` — os dois
usam esta unit — em Release/Win32, 0 erros. Desta vez o redirecionamento foi **conferido pelo
mtime** dos artefatos em `Release` depois do build: os dois ficaram intocados. É a correção de
método que o §12.18 pediu.
### 12.21 O switch `/registraplugin` (2026-09-21)

Contrato em `specs.md` §13.15. Quatro arquivos.

| Arquivo | O que entrou |
|---|---|
| `untTefCitelAtuComum.pas` | `TEF_ATU_CHAVE_ADDIN`, `TEF_ATU_CANAL_TEF`, `TEF_ATU_DLL_PLUGIN`, `TEF_ATU_DLL_PLUGIN_UPD` |
| `Estacao\untTefEstacaoRegistroPlugin.pas` | **novo** — `fPediuRegistrarPlugin` e `fRegistraPluginDoUsuario` |
| `Estacao\TefEstacaoService.dpr` | a unit no `uses` e o `if ... then Halt(...)` antes do `Application.Initialize` |
| `install\TefCitelEstacao.iss` | a ação da tarefa; saiu o `fEscreveCmdDaTarefa` |

**Onde as constantes foram parar, e por quê.** `untTefCitelAtuComum.pas` já é a casa desse tipo
de literal e já documenta a convenção de duplicação deliberada (`TEF_UPD_CANAL`, o nome do
serviço). Os plug-ins continuam declarando os mesmos literais nos `.dpr` deles e o instalador no
`[Code]` — são `.dproj` diferentes e não vale search-path entre eles. **Mudar num lugar exige
mudar nos outros na mesma sessão**, como já vale para o `fCrc32`.

**A detecção do switch mora na unit, não no `.dpr`.** A primeira versão usava
`FindCmdLineSwitch` direto no `.dpr` e não compilou — `E2003`, porque aquele `uses` não
tem `System.SysUtils`. Em vez de acrescentar a unit lá, o teste virou `fPediuRegistrarPlugin`:
o nome do switch fica num lugar só e o `.dpr` continua enxuto.

**A pasta vem de `ParamStr(0)`, nunca fixa:** a instalação pode não estar em `C:\Tef_Citel`, e
a tarefa não teria como saber disso de outro jeito.

#### Verificação

Compilado Release/Win32 com saída redirecionada — 0 erros, e o `Release` conferido por mtime
como intocado.

O binário recém-compilado foi **executado**, três vezes:

| Teste | Esperado | Obtido |
|---|---|---|
| pasta **sem** `TefCitelDvcPlugin.dll` | código 2, nada gravado | ✔ código 2, chave não criada |
| pasta **com** as duas DLLs | código 0, duas chaves | ✔ código 0, e o caminho gravado é o da própria pasta do exe |
| `-REGISTRAPLUGIN` (maiúsculas, hífen) | código 0 | ✔ |

As duas chaves criadas no teste foram **removidas** em seguida — o `AddIns` do usuário voltou
exatamente ao que era (`Netlink 3`, `Netlink 3 Dyn`, `RDPDR`).

E o aspeamento do `/tr`, que é a parte fácil de errar, foi provado criando uma tarefa
descartável com gatilho em 2099 (nunca dispara) e lendo o que ficou registrado:

`
Execute  : ["C:\Tef_Citel\TefEstacaoService.exe"]
Arguments: [/registraplugin]
`

Tarefa apagada em seguida.

**O que nenhum desses testes cobre:** se a janela de console realmente some. Isso só se vê no
logon de um usuário de verdade — é o **V.4**, e agora ele tem uma pergunta a mais a responder.
### 12.22 Detectar o antivírus de terceiro (2026-09-21)

Contrato em `specs.md` §13.16. Um arquivo: `install\TefCitelEstacao.iss`.

`fAntivirusDeTerceiro` + `pFalhouExclusaoDefender`, que passa a ser o único ponto de saída de
fracasso do `pExcluiNoDefender`. A tentativa do `Add-MpPreference` **continua acontecendo**
mesmo havendo AV de terceiro — em algumas configurações o Defender aceita a exclusão em modo
passivo, e nesse caso ela vale. Só o **fracasso** muda de texto.

#### A primeira implementação estava errada, e errada em silêncio

Foi por COM: `SWbemLocator` → `ExecQuery` → `ItemIndex(i)`. Compila, e **não funciona**:
medido em 2026-09-21, `ItemIndex` devolve **nulo**. O acesso à propriedade levantava exceção, o
`except` engolia e a função devolvia vazio — ou seja, a detecção nunca aconteceria e ninguém
descobriria, porque o resultado é indistinguível de "não há AV de terceiro".

Trocado por **PowerShell escrevendo num arquivo**, que dá para conferir de fora. O `try/catch`
do lado do PowerShell é o que cobre o Windows Server, onde o namespace não existe.

#### Verificação

Além da compilação, a **linha de comando gerada foi reconstruída e executada**:

- contra `root\SecurityCenter2` nesta máquina (Server 2022): exit 1, arquivo **não** criado →
  função devolve vazio → mensagem genérica. É o caminho gracioso da RN60, provado;
- a mesma linha trocando só o namespace por um que existe: exit 0, arquivo escrito com o conteúdo
  certo. Prova o aspeamento, que é a parte fácil de errar — e de fato houve um erro no caminho:
  quatro apóstrofos onde precisavam ser três, em volta do `LstrArq`.

**O que não foi verificado:** o texto real numa máquina com Bitdefender. Isso só se vê na próxima
instalação em estação com AV corporativo — onde, aliás, ele deve aparecer na tela final junto dos
demais avisos.
### 12.23 A tarefa por XML (2026-09-21)

Contrato em `specs.md` §13.17. `fCriaTarefaDeLogon` reescrita no `.iss`.

**Primário:** monta o XML em `{tmp}`, grava com `SaveStringsToUTF8File` e chama
`schtasks /create /tn <nome> /xml <arquivo> /f`.

**Reserva:** se o `/xml` devolver diferente de 0, tenta
`/sc onlogon /ru "BUILTIN\Users" /rl limited`. O log diz **qual das duas** criou a tarefa — sem
isso, um dia alguém leria "tarefa criada" sem saber por qual caminho, e as duas não têm as mesmas
garantias.

A reserva existe porque **não foi possível testar o caminho primário nesta máquina**: criar tarefa
com principal de grupo exige elevação, que a sessão do Claude Code não tem. Em vez de apostar numa
forma só, o instalador tenta a melhor e registra o que aconteceu.

#### O que foi verificado

- o `.iss` compila;
- **o XML foi reconstruído exatamente como o Inno vai gerá-lo e validado como XML**:
  `GroupId = S-1-5-32-545`, `RunLevel = LeastPrivilege`, `Actions Context = Author` casando
  com `Principal id = Author`, `LogonTrigger` **sem** `UserId`, `Command` e `Arguments`
  separados, e `DisallowStartIfOnBatteries = false`.

#### O que NÃO foi verificado, e é o que o próximo teste responde

Se o `schtasks` aceita este XML — encoding, esquema, tudo. Se recusar, o log dirá
`schtasks /xml devolveu N - tentando a forma por parametro` e a reserva assume.
### 12.24 O `schtasks /xml` e o encoding — e a instrumentação que faltava (2026-09-21)

A instalação das 17:34 falhou nas **duas** tentativas de criar a tarefa, ambas com código 1, e o
log só tinha o número. **O motivo estava na saída do `schtasks`, que eu descartava** — custou uma
ida e volta ao campo para descobrir algo que o próprio comando já dizia. Duas correções.

#### 1. O encoding do XML

Medido nesta máquina, com o mesmo XML em quatro codificações:

| Forma | Resultado |
|---|---|
| UTF-8 **com** BOM (o que o `SaveStringsToUTF8File` grava) | `ERRO: O XML está mal construído. (1,2)::sintaxe de documento incorreta` — bate no BOM |
| UTF-8 sem BOM, declarando `encoding="UTF-8"` | `(1,40)::não é possível alternar codificação` |
| UTF-16LE com BOM, declarando `UTF-16` | **ÊXITO** |
| **ASCII, sem atributo `encoding`** | **ÊXITO** |

O Inno não tem helper para gravar UTF-16, e o XML é ASCII puro — então a saída é a quarta linha:
declaração `<?xml version="1.0"?>` **sem `encoding`**, gravada com `SaveStringsToFile` (ANSI).

O XML com o principal de grupo foi testado aqui e **passou pelo parser**: parou em
`ERRO: Acesso negado`, que é elevação — e o instalador roda elevado. É o quanto dá para provar
sem ser administrador nesta máquina.

#### 2. `fRodaSchtasks` — a saída vai para o log

Toda chamada ao `schtasks` passa a ir por `cmd /C ""<exe>" <params> > "<arq>" 2>&1"`, e cada
linha da saída entra no `instalacao.log` com o prefixo `schtasks:`. A forma com aspas
**externas** em volta de tudo é a única que aceita caminho com espaço no executável **e**
redirecionamento na mesma linha — validada aqui antes de entrar.

**Lição, e ela vale além deste ponto:** quando o instalador chama um programa externo cujo
resultado é fatal, engolir a saída dele troca um diagnóstico de dez segundos por uma viagem à
estação.
### 12.25 TefLog e o sufixo da estação (2026-09-21)

Contrato em `specs.md` §13.19. Um arquivo: `libTefCitel\untTefCitelDvcTransporte.pas`.

- constante `TEF_LOG_PASTA_PADRAO = 'TefLog'`;
- `fNomeEstacaoDvc` — `CLIENTNAME`, descartando `"Console"`, caindo em `COMPUTERNAME`,
  sanitizado para `[A-Za-z0-9_-]` e truncado em 32 caracteres (o nome entra num caminho que tem
  `MAX_PATH`);
- `pCarregaConfigLogDvc` monta a pasta e faz `ForceDirectories`, com queda para `%TEMP%`;
- o nome do arquivo passa a ser `ChangeFileExt(base,'') + '_' + estação + ext`.

**A rotação acompanha sozinha:** ela deriva os `.1`/`.2` de `FstrLogArquivo`, não da
constante — nada a mudar lá.

**Efeito colateral benigno no lado estação:** a mesma `libTefCitel.dll` roda no
`TefEstacaoService.exe`. Se algum dia uma linha de log do transporte sair de lá, ela cria
`C:\Tef_Citel\TefLog\`, e como o serviço roda em sessão 0 sem `CLIENTNAME`, o sufixo vira o
nome da própria estação — que é o certo.

#### `DCC_DllOutput` NÃO redireciona nestes projetos — confirmado pela segunda vez

Compilei a DLL com `/p:DCC_DllOutput=<scratchpad>` e o artefato foi para
`libTefCitel\Win32\Release\libTefCitel.dll` **do mesmo jeito** — exatamente como aconteceu com os
dois plug-ins em 20/09 (§12.18). **`DCC_ExeOutput` funciona; `DCC_DllOutput` não.**

Consequência desta vez: a saída de projeto `libTefCitel\Win32\Release\libTefCitel.dll` foi
substituída por um artefato de `msbuild`. O `padra_atualizado\libTefCitel.dll` — que é o que o
AUTCOM carrega e o que a Fase 6 envia — **ficou intocado**, conferido por mtime.

**Regra para a próxima vez:** para projeto de DLL, não existe redirecionamento — compilar só
quando o overwrite for aceitável, e **conferir o mtime do artefato depois**, nunca confiar no
parâmetro.
### 12.26 `LogPath` e o banco de teste do `fAjustaCaminhosIni` (2026-09-21)

Contrato em `specs.md` §13.20. Um arquivo: `Estacao\untTefEstacaoAtualizacao.pas`.

O modelo existente é uma tabela de `(seção, chave)` com `blnAchou`, e um segundo laço que
**cria** o que não apareceu. Nenhuma das duas coisas serve para o `LogPath`: ele casa por nome em
qualquer seção, pode ser ajustado **mais de uma vez**, e não pode ser criado.

Campo novo `blnQualquerSecao` no `TdtoChaveIni`, e três pontos mudam:

| Ponto | Antes | Agora |
|---|---|---|
| `if blnAchou then Continue` | pula a chave já ajustada | só pula se **não** for de qualquer seção — senão o segundo grupo nunca seria ajustado |
| teste de seção | obrigatório | pulado quando é de qualquer seção |
| laço de criação | cria o que faltou | **pula** as de qualquer seção |

Mais o log com o nome do grupo (RN66).

#### O banco de teste, e o susto que ele deu

Como a tag ainda não existe no `scope.ini` de verdade, o código nasce **dormente** — um erro aqui
só apareceria em produção, meses depois. Por isso compilei um programa de console que chama
`fAjustaCaminhosIni` com um `scope.ini` sintético.

**A primeira execução mostrou o `LogPath` intacto nos três grupos** — parecia bug no patch. Não
era: o `dcc32` usou os `.dcu` que ficam **ao lado dos fontes** em `libTefCitel\Estacao`, e o
`-B` não os refez. O sinal estava na própria saída do compilador: **"56 lines"**, que é só o
`.dpr`. Recompilando a partir de cópias dos `.pas` numa pasta limpa foram **1874 linhas**, e o
resultado saiu certo.

**Regra:** ao compilar um teste avulso contra estas units, conferir a contagem de linhas do
`dcc32`. Se vier só o tamanho do `.dpr`, os units vieram de `.dcu` velho e o teste não está
testando nada.

#### O que o teste provou

Com `LogPath` em três grupos: os três apontados para `C:\Tef_Citel`, o espaçamento de
`LogPath = valor` preservado, `logpath` em minúsculas casando, `; LogPath=...` comentado
**intacto**, e as chaves vizinhas sem alteração.

Com `scope.ini` **sem** `LogPath` — que é o arquivo de hoje: volta idêntico, **sem** a chave ser
acrescentada. É o comportamento que garante que preparar para o futuro não muda o presente.
### 12.27 Remoção do `TefCitelAutcomTeftra.log` (2026-09-21)

Contrato em `specs.md` §13.21. Um arquivo: `untTefCitelUtil.pas`. **34 linhas a menos**: as
**13 chamadas** de `pLogaDiagnosticoTeftra`, o bloco da procedure com o comentário de origem (20
linhas) e a linha em branco que o seguia.

Conferido antes de remover que **nenhuma chamada era a única instrução de um bloco** — todas
estavam ao lado de outras em `begin/end`, `try/finally` ou ramos de `if`, então nenhum bloco
ficou vazio.

**Verificação estrutural**, já que esta unit não compila fora do `autcom.exe`: contagem de
`begin`/`end` antes e depois deu **-1 begin e -2 end**. Parece desequilíbrio e não é — a
procedure removida tinha `begin` … `try/except end;` … `end;`, ou seja **um `begin` e dois
`end`**. O delta está exato.

`System.IOUtils` **continua necessário** no `uses`: o `TFile` era usado só ali (agora 0
ocorrências), mas o `TPath` segue com 5.

**Sem verificação de compilador**, pelo mesmo motivo de sempre nesta unit — ela só compila dentro
do `autcom.exe`, que só compila na IDE.
### 12.28 Parar de criar chave ausente (2026-09-22)

Contrato em `specs.md` §13.22. `Estacao\untTefEstacaoAtualizacao.pas`.

O laço de criação virou **laço de aviso**. Com isso `fFimDaSecao` e `pInsereLinha` ficaram sem
uso e foram removidas (1.404 caracteres), junto com a variável `LintFim`. A chave de qualquer
seção não rende aviso: ausência ali é o caso normal enquanto o parâmetro não existir, e avisar em
toda carga seria ruído.

#### Verificado com o arquivo real da loja

O banco de teste rodou sobre o `scope_autcom.ini` que o Rafael mandou. O `diff` entre origem e
saída deu **exatamente quatro linhas**, todas de caminho:

`
ArqControlPath   C:\Users\...\padra_atualizado  ->  C:\TEF_Citel
LogPath  (x3)    C:\Users\...\padra_atualizado  ->  C:\TEF_Citel
`

**36 linhas na origem, 36 na saída** — nada acrescentado, nada removido. E `ArqTracePath` não
aparece na saída.

`TefEstacaoService.exe` e `TefEstacaoAtualizador.exe` compilam com 0 erros; `Release`
conferido por mtime como intocado.