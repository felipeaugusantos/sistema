# Req. 460229 — Plano de implementação

> **Para quem executa:** as tarefas usam `- [ ]` para acompanhamento. Cada uma termina em algo
> verificável sozinho.

**Objetivo:** tornar visível o estado real de entrega dos gatilhos de informação nos clientes em
modo fila, destravar a fila quando ela para, e devolver a uma pessoa a decisão de quem entra no
modo fila.

**Arquitetura:** todo o trabalho mora no `GatilhosInformacaoMonitor` — o único artefato que não
linka `fontes/` (4 units, 9 MB) e por isso é barato de implantar. **Nada é implantado no robô nem
na `libGatIme.so`.** A proteção contra disparo de mensagem velha é o corte de 20 h da Tarefa 8, do
lado de quem provoca a drenagem.

**Spec:** `IA\specs\460229\spec.md` — leia junto. A investigação está em `record.md`.

## Adaptações a este projeto

**Não há TDD, e não é omissão.** O `CLAUDE.md` determina: teste-primeiro não se aplica na zona
legada (sem infraestrutura) nem na moderna (por divisão de papel), e *"nunca escrever 'escrever os
testes' como tarefa de quem implementa"*. Não existe projeto de teste para o `MonitorarGatilhos`.

Portanto cada tarefa entrega **o contrato e o roteiro de validação manual**. Onde couber caso de
teste automatizado, ele está marcado como **[ANALISTA]** e não é tarefa daqui.

**Compilação e implantação são do usuário.** Nada neste plano dispara `msbuild` nem escreve no
servidor Linux. Onde for preciso compilar ou implantar, a tarefa **para** e pede.

## Restrições globais

- **O binário no ar não tem a guarda de 24 h**, e não vai ter (ver *Verificação de ABI* abaixo).
  O corte de 20 h da Tarefa 8 é a **única** proteção contra disparar mensagem velha ao cliente
  final. Não relaxar esse valor sem trocar a proteção de lugar.
- **Zona:** `padra_atualizado/Services/` é Zona Moderna pelo `CLAUDE.md`, mas o
  `MonitorarGatilhos/untGatilhos.pas` é escrito em estilo próprio (funções livres, `TQuery` com
  `AddSQL` fluente, sem interfaces). **Seguir o estilo do arquivo**, não o guia da zona.
- **Travas do pre-commit:** nada de `Now()` — usar `fNow()`. Sem `StrToFloat`. Sem
  `FOREIGN_KEY_CHECKS`.
- **Commit:** primeira linha `Req. 460229`, token do DelphAI obrigatório.
- **Encoding:** `untGatilhos.pas` está em cp1252 com acentos (`ValidarConfiguracoes` tem
  `'Gatilhos de Informação…'`). Conferir antes e depois de cada edição — ver
  `feedback-edit-latin1-via-hook`.
- **Base central:** `SRVWEBSERVICES9.CITELSOFTWARE.COM.BR:47800`, banco `GATILHOS_INFORMACAO`. O
  monitor já se conecta lá em três pontos.

## Estrutura de arquivos

| Arquivo | Responsabilidade |
|---|---|
| `MonitorarGatilhos/untGatilhos.pas` | tudo do monitor — modo, reconciliação, destravamento |
| `Scripts/460229_robo_e_divergencia.sql` | DDL das duas tabelas novas na base central |

Uma tabela nova por responsabilidade, ambas na base central:

- `gatilhos_informacao_robo` — **exceções** de versão: quem está fixado numa pasta que não é a
  default. Substitui o `libgatime_clients.txt` e a ideia de "modo".
- `gatilhos_informacao_divergencia` — o que a reconciliação apurou, por cliente e por dia.

---

## Verificação de ABI — **concluída em 06/09/2026, resultado registrado**

A atualização da `libGatIme.so` estava planejada para trazer `fValidaDisparo` (guarda de 24 h). A
verificação de compatibilidade **reprovou o caminho**, e ele saiu do escopo. Fica registrado aqui
porque o resultado é o que justifica o corte de 20 h da Tarefa 8.

O que foi conferido entre a revisão implantada (~r476904, 02/06/2026) e a HEAD:

| Item | Resultado |
|---|---|
| Lista de exports do `GatIme.dpr` | **idêntica** — `pIniciarConexaoThreadGatIme`, `pFinalizarConexaoThreadGatIme`, `fCarregarDll` |
| `untDllGatImeParametros.pas` (layout do record) | **sem mudança** |
| `IGatIme` (vtable) | **mudou** |

```pascal
- function fMonitorar: {$IFDEF LINUX}Boolean{$ELSE}IMonitorProcedure{$ENDIF LINUX};
+ function fMonitorar(AstrFluxo: String = ''): {$IFDEF LINUX}Boolean{$ELSE}IMonitorProcedure{$ENDIF LINUX};
```

`TDllGatime.fMonitorarGatilhosImediatos` chama `DllGatIme.fMonitorar(AstrFluxo)` em
`untDllGatIme.pas:143` — **é o caminho da drenagem**. O executável de 02/06 tem o wrapper compilado
dentro dele chamando `fMonitorar` sem argumento; a `.so` nova espera uma `String`. Trocar só a lib
mataria o processo filho.

*O nome do lock também mudou para `MONITOR_GATILHOS_IMEDIATOS_OPERACIONAL_%s`, mas para esse caso já
existe o bloco de compatibilidade `IdMonitorGatilhosImediatos_OLD`. Para a assinatura, não.*

*A quebra está na vtable, e o nome do export não a denuncia: quem conferisse só a lista de exports
concluiria que era seguro.*

---

## Tarefas

### Tarefa 3: criar as tabelas na base central — **CONCLUIDA**

**Arquivos:** `padra_atualizado/Services/GatilhosInformacao/Scripts/460229_robo_e_divergencia.sql`

Duas tabelas: `gatilhos_informacao_robo` (exceções de versão) e `gatilhos_informacao_divergencia`
(o que a reconciliação apurou). O script traz o racional de cada coluna — não repetir aqui.

Três coisas que custaram uma correção e valem para o próximo script nesta base:

- **`utf8mb4`, não `latin1`.** Esta base não segue a convenção do banco do ERP. Todas as
  `gatilhos_informacao*` são `utf8mb4_0900_ai_ci`; `latin1` daria *Illegal mix of collations* ao
  cruzar com elas.
- **`servidor VARCHAR(255)`**, a largura das tabelas vizinhas.
- **ASCII puro no arquivo.** `.sql` fica fora do hook de encoding, e acento ali corrompe sem sintoma.

### Tarefa 4: versionar o robo por pasta — **CONCLUIDA**

**Arquivos:** `MonitorarGatilhos/untGatilhos.pas`

O que entrou:

- `fConectar(servidor, porta, banco)` — ponto unico de conexao para o codigo novo. As credenciais
  cifradas foram copiadas em bytes do `pUpdateGatilhoStatus`; digita-las corromperia o literal.
- `fConectarCentral` — o wrapper da base da Citel.
- `fPastaRoboDoCliente(conn, servidor, empresa)` — le a `gatilhos_informacao_robo`. Sem linha,
  devolve `PASTA_DEFAULT`. Qualquer falha tambem: deixar de disparar por indisponibilidade da
  central e pior que disparar pela versao corrente.
- `PASTA_DEFAULT`, do parametro `--pasta_default=`, com fallback `robo_libgatime`.
- A escolha do executavel virou `<pasta>/GatilhosInformacao`, e o log diz `(default)` ou `(FIXADO)`.

O que saiu, por ter ficado sem consumidor: `fServidorUsaLibGatIme`, `pCarregarListaLibGatIme`,
`fArquivoLibGatImeClients`, `GetClienteConsomeGatilhosImediatos`, `gLibGatImeServidores` e
`DIAS_JANELA_LIBGATIME`. O `libgatime_clients.txt` deixou de ser lido — nao ha mais Tarefa de
aposentadoria separada.

### Tarefa 5: reorganizar o servidor em pastas — **[USUARIO]**

- [ ] **Passo 1: criar as pastas e mover os binarios**

```bash
cd /ServicosCitel/GatilhosInformacaoEnviar
mkdir -p robo_velho robo_libgatime
cp GatilhosInformacao              robo_velho/GatilhosInformacao
cp GatilhosInformacao_LibGatIme    robo_libgatime/GatilhosInformacao
cp libGatIme.so                    robo_libgatime/libGatIme.so
chmod +x robo_velho/GatilhosInformacao robo_libgatime/GatilhosInformacao
```

`cp`, nao `mv`: os originais ficam como rollback ate o primeiro ciclo validar.

- [ ] **Passo 2: conferir o que cada pasta precisa ao lado**

O `robo_libgatime` carrega a `libGatIme.so` por caminho relativo. Conferir tambem `.fr3`, `.png` e
`libmysqlclient.so` — o que o processo filho abrir por caminho relativo tem de estar na pasta dele.

- [ ] **Passo 3: subir o monitor novo e observar um ciclo**

Esperado no log: `Robo default: robo_libgatime`, e um `Robo escolhido para <cliente>: robo_libgatime
(default)` por disparo. Nenhum `(FIXADO)`, porque a tabela esta vazia.

- [ ] **Passo 4: exercitar a reversao, que e o que nao existia**

```sql
INSERT INTO gatilhos_informacao_robo (servidor, empresa, pasta, fixado_em, fixado_por, motivo)
VALUES ('GRUPO_MARCIUS_LJ001(MATRIZ)_002_003_004', '001', 'robo_velho', NOW(), 'joao.catarino',
        'Req. 459428 - enfileiramento falha no share UNC');
```

No ciclo seguinte o log deve dizer `robo_velho (FIXADO)`, e o MARCIUS volta a enviar direto.
**E o teste do mecanismo e o conserto de um chamado ao mesmo tempo.**

### Tarefa 7: reconciliação agregada — o alarme

**Arquivos:** modificar `MonitorarGatilhos/untGatilhos.pas`

**Consome:** `fClienteEmModoFila` (Tarefa 4).

- [ ] **Passo 1: a consulta no banco do cliente**

```pascal
{ Uma ida so ao banco do cliente. O EXISTS e semi-join: para no primeiro acerto e nao
  multiplica a linha da fila pelos homonimos - o BELATINTAS tem 389 gatilhos com a mesma
  descricao, e um JOIN inflaria a contagem por 389. O filtro de data e o que deixa o
  indice IDX_GATIME_WPPEMA_01 agir; sem ele a tabela nao tem expurgo e a varredura sai
  cara. }
const
  SQL_DIVERGENCIA =
    'SELECT '                                                                        +
    '  (SELECT COUNT(*) FROM GATINF '                                                +
    '     WHERE GAT_STATUS = "A" AND DATE(GAT_ULTENV) = :DTA) AS CARIMBADOS, '       +
    '  (SELECT COUNT(*) FROM GATIME_WPPEMA w '                                       +
    '     WHERE w.GAT_DTAOCO = :DTA '                                                +
    '       AND EXISTS (SELECT 1 FROM GATINF g '                                     +
    '                    WHERE g.GAT_DESCRI = w.GAT_ASSUNT)) AS ENFILEIRADOS, '      +
    '  (SELECT COUNT(*) FROM GATIME_WPPEMA w '                                       +
    '     WHERE w.GAT_DTAOCO = :DTA '                                                +
    '       AND EXISTS (SELECT 1 FROM GATINF g '                                     +
    '                    WHERE g.GAT_DESCRI = w.GAT_ASSUNT) '                        +
    '       AND (w.GAT_D_EWPP IS NOT NULL OR w.GAT_D_EEMA IS NOT NULL)) AS ENTREGUES ';
```

- [ ] **Passo 2: gravar na central** com `ON DUPLICATE KEY UPDATE` que atualiza os contadores e
      `ultima_deteccao`, mas **preserva `primeira_deteccao`**:

```sql
INSERT INTO gatilhos_informacao_divergencia
  (servidor, empresa, data_ref, carimbados, enfileirados, entregues,
   nao_identificados, primeira_deteccao, ultima_deteccao)
VALUES (:SERVIDOR, :EMPRESA, :DTA, :CAR, :ENF, :ENT, :NID, :AGORA, :AGORA)
ON DUPLICATE KEY UPDATE
  carimbados = VALUES(carimbados), enfileirados = VALUES(enfileirados),
  entregues  = VALUES(entregues),  nao_identificados = VALUES(nao_identificados),
  ultima_deteccao = VALUES(ultima_deteccao);
```

- [ ] **Passo 3: chamar** de `TAtualizarStatus.UpdateStatus`, **somente** quando
      `fClienteEmModoFila` for `True` — cliente síncrono não tem linha na fila por definição, e
      verificá-lo geraria 69 falsos positivos no primeiro dia.

- [ ] **Passo 4: validar** — **[USUÁRIO]**, contra os três clientes conhecidos:

| Cliente | Esperado |
|---|---|
| MINAS BOMBAS | `carimbados = enfileirados`, `entregues` menor até a drenagem |
| MARCIUS | `carimbados > 0`, `enfileirados = 0` — divergência gritante |
| BELATINTAS | `carimbados ≈ 392`, `enfileirados ≈ 3` |
| qualquer síncrono | nenhuma linha gravada |

- [ ] **Passo 5: commit.**

### Tarefa 8: reconciliação linha a linha — o detalhe

Publica, por gatilho, enfileirado quando e entregue quando. O que não casar vai para
`nao_identificados` e **aparece como tal** — nunca é inferido.

**Arquivos:** modificar `MonitorarGatilhos/untGatilhos.pas`

- [ ] **Passo 1:** consulta por `(GAT_CODEMP, GAT_ASSUNT, destino, janela)`, com o destino vindo de
      `GAT_NUMWPP`/`GAT_EMAIL_` contra `OPE_NUMWPP`/`OPE_E_MAIL` do operador de destino do gatilho.
- [ ] **Passo 2:** o que resolver vai para `gatilhos_informacao_status.ultima_mensagem` no formato
      `enfileirado dd/mm hh:nn - entregue dd/mm hh:nn`; o que não resolver soma em
      `nao_identificados` e **não escreve** nada em `ultima_mensagem`.
- [ ] **Passo 3:** pendência anterior à janela grava `ultima_mensagem` = `fora da janela` —
      critério 6. Nunca some, nunca vira "resolvido".
- [ ] **Passo 4: validar** — **[USUÁRIO]** — no BELATINTAS os 3 do C22 resolvem; no MINAS BOMBAS
      os 8 resolvem com o atraso visível.
- [ ] **Passo 5: commit.**

### Tarefa 9: destravamento

- [ ] **Passo 1:** detectar linha nossa pendente e recente

```sql
SELECT COUNT(*) AS PENDENTES FROM GATIME_WPPEMA w
WHERE w.GAT_DTAOCO >= CURRENT_DATE - INTERVAL 1 DAY
  AND w.GAT_LIBENV = "S"
  AND (w.GAT_D_EWPP IS NULL OR w.GAT_D_EEMA IS NULL)
  AND EXISTS (SELECT 1 FROM GATINF g WHERE g.GAT_DESCRI = w.GAT_ASSUNT)
  AND TIMESTAMPDIFF(HOUR, TIMESTAMP(w.GAT_DTAOCO, w.GAT_HOROCO), NOW()) < 20
```

**O corte de 20 h é a única proteção contra disparar mensagem velha.** O binário no ar não tem
`fValidaDisparo` — a verificação de ABI mostrou que ele não pode receber essa guarda sem atualizar
o robô junto. Provocar drenagem num cliente com fila acumulada dispararia boleto de semanas atrás
ao cliente final. A trava fica do lado de quem provoca, já que quem executa não a tem.

*Não relaxar esse valor. Se um dia a `.so` for atualizada e passar a ter a guarda de 24 h, o corte
aqui deve continuar menor que ela — senão o monitor sobe o robô só para vê-lo recusar o envio.*

- [ ] **Passo 2:** havendo pendente e `ExisteGatilhosInformacaoExecutando` falso, chamar
      `ExecutarGatilhosInformacao` para aquele cliente. Sem gatilho vencido, o `pExecuteAll` vai
      direto ao `pProcessarGatilhosImediatos` e drena.
- [ ] **Passo 3:** guardar em `TDictionary<string, TDateTime>` na instância — molde do `FDicExec`
      que o `TAtualizarStatus` já usa — o último destravamento por cliente, e não repetir dentro de
      10 minutos. Critério 4: **uma** subida, não uma por ciclo.

Este é o único estado em memória do desenho, e é aceitável porque perdê-lo custa **uma subida a
mais**, nunca uma mensagem. Todo o resto é derivado do banco a cada ciclo — ver as regras de estado
no spec.

- [ ] **Passo 4: validar** — **[USUÁRIO]** — no MINAS BOMBAS, após as 18:15: a fila deve drenar em
      minutos, e não às 07:30 do dia seguinte. Conferir `GAT_H_EEMA` na `GATIME_WPPEMA`.
- [ ] **Passo 5: commit.**

## Casos de teste — **[ANALISTA]**

Não há projeto de teste para o `MonitorarGatilhos`, e criar um está fora do escopo deste requisito.
A lista abaixo é o que precisaria ser coberto, e é entregável desta implementação — não subproduto:

1. Cliente em `SINCRONO` não gera linha em `gatilhos_informacao_divergencia`.
2. Cliente em `FILA` com `carimbados > enfileirados` gera divergência no mesmo dia.
3. Cliente em `FILA` com `carimbados = enfileirados = entregues` não gera divergência.
4. Divergência repetida entre ciclos preserva `primeira_deteccao` e move `ultima_deteccao`.
5. Cliente com capacidade detectada e fora do conjunto entra como `CANDIDATO` e **não** muda de modo.
6. `fClienteEmModoFila` devolve `False` quando a base central está inacessível.
7. Linha pendente com mais de 20 h não provoca destravamento.
8. Dois ciclos seguidos com a mesma pendência provocam **uma** subida do robô.

## Riscos

**O binário no ar não é o fonte que se lê.** Build de ~r476904 (02/06/2026), HEAD em r493393. A
frase `"Gatilho enviado com sucesso!"` está no binário e em nenhum fonte do ramo. Toda afirmação
deste plano sobre o robô ou a `.so` foi conferida contra o binário ou contra dado de produção.

**Mensagem velha depende de uma trava só.** O corte de 20 h da Tarefa 9 não tem rede de segurança
atrás dele: o binário no ar não recusa disparo atrasado. Erro nesse cálculo chega ao cliente final
do cliente.

**A carga inicial pode não bater.** Se a Tarefa 5 produzir contagem diferente do log do dia
anterior, a detecção não é determinística e o desenho do portão precisa ser revisto antes de
seguir.
