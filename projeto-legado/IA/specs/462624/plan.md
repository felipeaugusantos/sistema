# Req. 462624 — Plano de implementação

> **Para quem executar:** as etapas usam checkbox (`- [ ]`). Cada tarefa termina num estado
> compilável e conferível. **Não há commit por tarefa:** a entrega é um commit só, no fim, com token
> do DelphAI e primeira linha `Req. 462624`.

**Objetivo:** tornar `enviarEmail`, `destinatarios` e `opcoes` decisões por fornecedor no
`POST /cotacao/exportacao/gerar`, e fazer o motivo real da falha de e-mail chegar ao consumidor em
vez do texto genérico de fila.

**Arquitetura:** duas frentes num commit. A frente A muda o DTO do corpo e os quatro pontos que o
consomem, incluindo a guarda de travessia do download, que lê o corpo depois de gravado. A frente B
sobe o contrato da `IGatIme` para a versão 3, acrescentando `out AstrMotivo` às duas fronteiras
(gravar e processar), e preenche esse motivo em cada camada que hoje falha calada.

**Stack:** Delphi Seattle, DMVCFramework, UniDAC, MySQL. Serviço Linux compilado por PAServer.

**Spec:** [`IA/specs/462624/spec.md`](spec.md) — ler junto. O plano argumenta a partir dela.

---

## Restrições globais

- **Zona.** `Services/` e `Core/` são zona moderna: dot-notation, sem húngaro nos nomes novos de
  classe, arquitetura Controller → Service → Repository. `fontes/genericos`, `fontes/util`,
  `fontes/libGatIme` são zona legado: manter húngaro (`AstrMotivo`, `LblnEnviado`), prefixos `p`/`f`,
  e **não refatorar em volta**.
- **Encoding é por arquivo, não por pasta.** Rodar `file <arquivo>` antes de escrever e conferir
  `svn diff | wc -l` depois. `untFuncoesGenerica` é cp1252; `untFuncoesSimples` é UTF-8 com BOM. O
  hook `delphi-encoding.ps1` cobre `.pas`/`.inc`, **não cobre `.sql`** — nos casos de teste, acento
  exige troca em bytes.
- **Nada de Python reescrevendo `.pas`**: converte EOL e infla o diff de 200 para 2.000 linhas sem
  sintoma. Usar a ferramenta de edição.
- **Proibições do pre-commit** que este trabalho tangencia: `StrToFloat(`, `.SetFocus`, `Now`/`NOW()`
  (usar `fNow()`), `Application.CreateForm`. Nenhuma se aplica ao que vamos escrever, mas o hook
  bloqueia o commit inteiro se escapar.
- **`const` em parâmetro que o método não altera**; `out` só onde o método realmente devolve.
- **Comentário na implementação, não na declaração.** Na declaração, só o que a assinatura não diz.
- **Compilação Linux é do usuário.** Não disparar `msbuild`. Ao fim de cada fase, pedir a compilação
  e aguardar.
- **Base da suíte de testes:** `2_30_BELAT_TC` em `10.0.0.35:53307` (MySQL 8.0). Os clientes rodam
  5.7 — teste verde não prova que roda no cliente.

---

## Mapa de arquivos

| Arquivo | Responsabilidade após a mudança |
|---------|--------------------------------|
| `fontes/genericos/GatilhosImediatos.Interfaces.pas` | Contrato `IGatIme` v3 — as duas assinaturas com `out AstrMotivo` |
| `fontes/util/untProcessaGatilhosImediatos.pas` | Motivo nasce aqui: `fEnviarEmail`, `fExecutaClienteEmail` e `fExecutarGatilho` param de sair calados |
| `fontes/libGatIme/fontes/GatilhosImediatos.Classes.pas` | `TGatIme` implementa a v3 e devolve o texto do `except` |
| `fontes/genericos/untDllGatIme.pas` | Wrapper: motivo nas próprias guardas, `fLibGatImeDisponivel`, carregamento deixa de ser mudo |
| `fontes/util/untGatilhosInformacao.pas` | Dois chamadores existentes acompanham a assinatura nova |
| `Services/Core/suprimento/services/types/Suprimento.Services.Cotacao.Types.pas` | Nasce `TCotacaoExportacaoFornecedorParams`; `GerarParams` e `ValidarParams` mudam |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Exportacao.pas` | Opções e destinatários por item; mensagem com motivo e desfecho |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Consulta.pas` | Guarda de travessia do download lê objeto |
| `Services/Core/suprimento/services/Suprimento.Services.Workers.pas` | Pré-voo confere a libGatIme |
| `Services/Suprimento.Services.API/Source/api/controller/api.controller.cotacao.pas` | Validações de formato e Swagger |
| `fontes/genericos/untTypesSistema.pas` | Declara `ECotacaoExportacaoEnvioIndisponivel`, como as duas exceções irmãs |
| `Services/Core/Services.Core.Worker.pas` | Elo novo na cadeia que reconstrói a exceção do lado do controller |
| `Services/Suprimento.Services.API/Scripts/testes/casos/*.sql` | Casos reescritos e casos novos |
| `Services/Suprimento.Services.API/Target/Linux/Test_Cases/cotacao/GerarExportacaoTest.inc` | Registro dos casos |

---

## Por que não há ciclo vermelho-verde por tarefa

O CLAUDE.md fixa que teste-primeiro não se aplica em nenhuma das duas zonas. Aqui a razão é
concreta: o teste desta suíte é um registro em tabela (`.sql`) mais um `[TestCase]` no `.inc`, e ele
só roda depois que o binário é **compilado para Linux pelo usuário** e o runner é disparado. Não
existe ciclo de segundos.

A substituição: cada tarefa termina numa **verificação estática conferível na hora** — compila o que
dá para compilar no Windows, confere assinatura contra chamadores por `grep`, confere o diff. As
tarefas de teste vêm depois, em bloco, e a validação de verdade é a Fase 4.

---

## Fase 1 — Contrato da libGatIme

A frente B inteira depende disto, e a frente A não depende de nada daqui. Fase 1 primeiro porque a
Fase 2 vai chamar as assinaturas novas.

### Tarefa 1: Contrato `IGatIme` v3

**Arquivos:**
- Modificar: `padra_atualizado/fontes/genericos/GatilhosImediatos.Interfaces.pas`

**Interfaces:**
- Produz: as duas assinaturas que as tarefas 2, 3, 4 e 6 implementam e chamam.

- [ ] **Passo 1: subir a versão do contrato e documentar a linha nova**

Em `GATIME_CONTRATO_VERSAO`, o valor passa de `2` para `3`, e o bloco de comentário ganha a linha
da versão — ele é o histórico do contrato e é onde alguém vai olhar para descobrir o que a `.so`
precisa ter:

```pascal
      1 - contrato historico: fMonitorar + fGravarGatilhoImediato
      2 - Req. 455094: acrescenta fGravarGatilhoObtendoId e fProcessarGatilho
      3 - Req. 462624: os dois metodos passam a devolver o motivo da falha em out

  ...
  GATIME_CONTRATO_VERSAO = 3;
```

- [ ] **Passo 2: acrescentar `out AstrMotivo` às duas assinaturas**

```pascal
    { AstrMotivo devolve o texto da falha quando o resultado nao e sucesso, e vazio quando e.
      Nao substitui o log: o motivo continua indo para o LOGERR, aqui ele volta para quem chamou. }
    function fGravarGatilhoObtendoId(RecGatilhoImediato: TRecGatilhoImediato;
                                     out AstrIdGatilho: String;
                                     out AstrMotivo: String): Boolean;

    { tpTentarNovamente = outro processo detem o registro; tpNaoEnviado = gatilho de
      WhatsApp, canal que so sai pelo robo. AstrMotivo detalha o desfecho em texto. }
    function fProcessarGatilho(const AstrIdGatilho: String;
                               out AstrMotivo: String): TResultEnvio;
```

- [ ] **Passo 3: conferir quem quebra**

Rodar:
```
grep -rn "fGravarGatilhoObtendoId\|fProcessarGatilho" padra_atualizado --include=*.pas | grep -v __history
```
Esperado: seis arquivos. `Suprimento.Services.Cotacao.Exportacao.pas` (tarefa 6),
`untGatilhosInformacao.pas` (tarefa 5), `GatilhosImediatos.Classes.pas` (tarefa 3),
`untDllGatIme.pas` (tarefa 4), `untProcessaGatilhosImediatos.pas` (tarefa 2) e a própria interface.
Se aparecer um sétimo, ele entra no plano antes de seguir.

---

### Tarefa 2: O motivo nasce onde a falha acontece

**Arquivos:**
- Modificar: `padra_atualizado/fontes/util/untProcessaGatilhosImediatos.pas`

**Interfaces:**
- Produz: `fExecutarGatilho(const AAutInc: String; out AstrMotivo: String): TResultEnvio`, que a
  tarefa 3 chama.

- [ ] **Passo 1: `fEnviarEmail` devolve motivo**

A declaração privada (l. 82) e a implementação (l. 849) ganham `out AstrMotivo: String`. Os `Exit`
mudos passam a dizer por quê — este é o ponto onde mora a configuração incompleta do operador:

```pascal
    AstrMotivo := EmptyStr;
    ...
    if not fDadosPreenchidos then
    begin
      { Falta e-mail, porta, servidor, limite de arquivos ou senha no cadastro do operador de
        envio. E o caso que o usuario resolve sozinho - desde que saiba que e ele. }
      AstrMotivo := Format('Configuracao de e-mail incompleta para o operador "%s". ' +
                           'Verifique o cadastro do Operador, aba e-Mail, e a configuracao ' +
                           'CFG_PRVEMA - Provedores de e-mail.',
                           [DadosEnviaGatilhoEmail.operador.codigoOperador]);
      Exit;
    end;
```

Ao final, sucesso zera o motivo e falha sem texto ganha um genérico honesto — "não sei por quê" é
melhor que "ficou pendente", que afirma o que não aconteceu:

```pascal
    if Result and fEmptyStr(AstrMotivo) then
      AstrMotivo := EmptyStr
    else if (not Result) and fEmptyStr(AstrMotivo) then
      AstrMotivo := 'O servidor de e-mail recusou a mensagem e nao informou a causa.';
```

- [ ] **Passo 2: `fExecutaClienteEmail` devolve motivo**

Declaração e implementação (l. 1133) ganham `out AstrMotivo: String`. Os quatro `Exit` mudos
ganham texto; os dois primeiros são estado normal e não erro, e o texto tem de refletir isso:

```pascal
  AstrMotivo := EmptyStr;
  ...
  if LQryEmail.IsEmpty then
  begin
    AstrMotivo := Format('O gatilho %s nao existe mais na fila.', [AAutInc]);
    Exit;
  end;

  if fTipoObjeto(LQryEmail.FieldByName('GAT_INFJSN').AsString) in
     [typeTDadosEnviaGatilhoWhatsapp, typeTDadosEnviaGatilhoSms] then
  begin
    AstrMotivo := 'Este gatilho nao e de e-mail.';
    Exit;
  end;
  ...
      if (LQryEmail.FieldByName('GAT_BUCKET').AsString = 'N') and
         (not fEmptyStr(LQryEmail.FieldByName('GAT_PATARQ').AsString)) And
         (not FileExists(LQryEmail.FieldByName('GAT_PATARQ').AsString)) then
      begin
        AstrMotivo := Format('O anexo "%s" nao foi encontrado no disco do servidor.',
                             [LQryEmail.FieldByName('GAT_PATARQ').AsString]);
        Exit;
      end;
```

E os dois `Exit(tpTentarNovamente)` de recuperação de anexo:

```pascal
        if not blnResult then
        begin
          AstrMotivo := 'O anexo nao pode ser recuperado nesta tentativa.';
          Exit(tpTentarNovamente);
        end;
```

A chamada a `fEnviarEmail` repassa o `out`.

- [ ] **Passo 3: `fExecutarGatilho` acumula o motivo junto com o desfecho**

Declaração pública (l. 156) e implementação ganham `out AstrMotivo: String`. O
`pAcumularResultado` interno passa a receber também o texto, seguindo a mesma regra que ele já
aplica ao enum — o pior canal é quem dita:

```pascal
  procedure pAcumularResultado(const AResultadoCanal: TResultEnvio;
                               const AstrMotivoCanal: String);
  begin
    if (Result = tpNaoEnviado) or (AResultadoCanal = tpEnviadoErro) then
    begin
      Result     := AResultadoCanal;
      AstrMotivo := AstrMotivoCanal;
    end;
  end;
```

O `Exit(tpTentarNovamente)` do `GET_LOCK` negado ganha texto próprio — este é o **único** desfecho
em que dizer "vai sair depois" é verdade:

```pascal
  if not fAdquireLockNomeado(LstrLock) then
  begin
    AstrMotivo := 'Outro processo esta enviando este gatilho agora. ' +
                  'O robo conclui o envio na proxima varredura.';
    Exit(tpTentarNovamente);
  end;
```

O canal de WhatsApp e o de SMS passam `EmptyStr` como motivo: esta entrega trata e-mail, e inventar
texto para canais não exercitados seria afirmar o que não foi verificado.

- [ ] **Passo 4: conferir que nada ficou sem repasse**

Rodar:
```
grep -n "fEnviarEmail(\|fExecutaClienteEmail(\|fExecutarGatilho(" padra_atualizado/fontes/util/untProcessaGatilhosImediatos.pas
```
Esperado: toda chamada com o argumento novo. O compilador do Delphi acusa o resto na Fase 4, mas o
`grep` pega antes de mandar compilar.

---

### Tarefa 3: `TGatIme` implementa a v3

**Arquivos:**
- Modificar: `padra_atualizado/fontes/libGatIme/fontes/GatilhosImediatos.Classes.pas`

**Interfaces:**
- Consome: assinaturas da tarefa 1; `fExecutarGatilho` da tarefa 2.
- Produz: a implementação que a `.so` exporta.

- [ ] **Passo 1: `fProcessarGatilho` devolve o texto do `except`**

O `except` de l. 165 hoje só grava no log. Passa a devolver — e o comentário que explica por que o
`try/except` existe continua valendo, com uma frase a mais:

```pascal
function TGatIme.fProcessarGatilho(const AstrIdGatilho: String;
  out AstrMotivo: String): TResultEnvio;
...
begin
  Result     := tpNaoEnviado;
  AstrMotivo := EmptyStr;
  ...
      Result := LGatIme.fExecutarGatilho(AstrIdGatilho, AstrMotivo);
  ...
  except
    on e: Exception do
    begin
      pGravarErro(True, 'TGatIme.fProcessarGatilho: ' + e.Message);
      { O log continua, porque ele e o registro forense. O out e o que chega a quem pediu o
        envio - ate 17/09/2026 essa era a unica copia, e ela morria aqui. }
      AstrMotivo := e.Message;
      Result     := tpEnviadoErro;
    end;
  end;
```

- [ ] **Passo 2: `fGravarGatilhoObtendoId` devolve motivo**

O `Exit` de destino ausente é a única saída calada dele:

```pascal
function TGatIme.fGravarGatilhoObtendoId(RecGatilhoImediato: TRecGatilhoImediato;
  out AstrIdGatilho: String; out AstrMotivo: String): Boolean;
Begin
  Result        := False;
  AstrIdGatilho := EmptyStr;
  AstrMotivo    := EmptyStr;
  ...
  if (fEmptyStr(RecGatilhoImediato.NumeroWhatsapp)) And (fEmptyStr(RecGatilhoImediato.Email)) then
  begin
    AstrMotivo := 'O gatilho nao tem destinatario: nem e-mail, nem numero de WhatsApp.';
    Exit;
  end;
```

- [ ] **Passo 3: o encaminhador antigo continua**

`fGravarGatilhoImediato` segue existindo para os seis consumidores que não querem o id — agora ele
descarta as duas saídas:

```pascal
function TGatIme.fGravarGatilhoImediato(RecGatilhoImediato: TRecGatilhoImediato): Boolean;
var
  LstrId    : String;
  LstrMotivo: String;
begin
  Result := fGravarGatilhoObtendoId(RecGatilhoImediato, LstrId, LstrMotivo);
end;
```

---

### Tarefa 4: Wrapper — motivo nas guardas, disponibilidade e fim do silêncio

**Arquivos:**
- Modificar: `padra_atualizado/fontes/genericos/untDllGatIme.pas`

**Interfaces:**
- Produz: `fLibGatImeDisponivel(out AstrMotivo: String): Boolean`, que a tarefa 9 chama; e as duas
  assinaturas com `out`, que a tarefa 6 chama.

Esta é a tarefa que alcança o caso confirmado do Wagner.

- [ ] **Passo 1: `IDllGatime` e `TDllGatime` acompanham a v3**

As duas assinaturas mudam na interface e na classe. As guardas, que hoje saem mudas, passam a
nomear o que houve:

```pascal
function TDllGatime.fGravarGatilhoObtendoId(const RecGatilhoImediato: TRecGatilhoImediato;
  out AstrIdGatilho: String; out AstrMotivo: String): Boolean;
begin
  AstrIdGatilho := EmptyStr;

  if not fLibGatImeDisponivel(AstrMotivo) then
    Exit(False);

  Result := DllGatIme.fGravarGatilhoObtendoId(RecGatilhoImediato, AstrIdGatilho, AstrMotivo);
end;

function TDllGatime.fProcessarGatilho(const AstrIdGatilho: String;
  out AstrMotivo: String): TResultEnvio;
begin
  { A guarda de Assigned e a mesma do fMonitorarGatilhosImediatos, pelo mesmo motivo que o
    comentario de la registra. A de versao e o que impede chamar metodo que a .so nao tem:
    o salto iria alem do fim da vtable, sem levantar excecao. }
  if not fLibGatImeDisponivel(AstrMotivo) then
    Exit(tpNaoEnviado);

  Result := DllGatIme.fProcessarGatilho(AstrIdGatilho, AstrMotivo);
end;
```

- [ ] **Passo 2: `fLibGatImeDisponivel`**

Função de unit, não método — a tarefa 9 precisa perguntar **sem** instanciar, e é justamente o
`Create` que grava erro no log:

```pascal
{ Responde se a biblioteca esta utilizavel NESTE processo, sem carregar nada e sem instanciar o
  wrapper. AstrMotivo traz o que falta quando devolve False. }
function fLibGatImeDisponivel(out AstrMotivo: String): Boolean;
```

Implementação, com `IFDEF` porque no Windows os símbolos são externos com `delayed` e a pergunta
não tem a mesma forma:

```pascal
function fLibGatImeDisponivel(out AstrMotivo: String): Boolean;
{$IFDEF LINUX}
var
  LintVersaoSO: Integer;
begin
  AstrMotivo := EmptyStr;

  if HandleDllGatilhosImediatos = 0 then
  begin
    AstrMotivo := Format('A biblioteca libGatIme.so nao foi carregada. Confira se ela esta na ' +
                         'pasta do executavel (%s).',
                         [ExtractFilePath(Application.ExeName)]);
    Exit(False);
  end;

  if (not Assigned(fCarregarDllGatIme)) or (not Assigned(fContratoVersaoGatImeSO)) then
  begin
    AstrMotivo := 'A libGatIme.so carregada e anterior ao Req. 455094 e nao expoe os simbolos ' +
                  'necessarios. Atualize a biblioteca.';
    Exit(False);
  end;

  LintVersaoSO := fContratoVersaoGatImeSO;
  if LintVersaoSO < GATIME_CONTRATO_VERSAO then
  begin
    AstrMotivo := Format('A libGatIme.so implementa o contrato versao %d, e este servico exige %d. ' +
                         'Atualize a biblioteca.', [LintVersaoSO, GATIME_CONTRATO_VERSAO]);
    Exit(False);
  end;

  Result := True;
end;
{$ELSE}
begin
  { No Windows os simbolos sao externos com delayed: a ausencia so aparece na chamada, e o host
    e o autcom, que carrega a DLL junto com o executavel. A pergunta nao se aplica. }
  AstrMotivo := EmptyStr;
  Result     := True;
end;
{$ENDIF LINUX}
```

- [ ] **Passo 3: o carregamento deixa de ser mudo**

`pCarregaFuncoesDllGatilhoImediatos` (l. 231) passa a registrar quando falha. Vale para os três
hosts Linux que a chamam:

```pascal
procedure pCarregaFuncoesDllGatilhoImediatos;
begin
  if HandleDllGatilhosImediatos = 0 then
    HandleDllGatilhosImediatos := RetornarDllGatilhosImediatos;

  If (HandleDllGatilhosImediatos = 0) Then
  begin
    { Ate 17/09/2026 este Exit era calado, e a primeira noticia do problema era o pGravarErro do
      Create, ja dentro de uma exportacao. No ambiente do Req. 462624 isso custou seis horas e
      dois operadores antes de alguem reclamar. Quem sobe o servico ve no primeiro log. }
    pGravarErro(True, Format('pCarregaFuncoesDllGatilhoImediatos: libGatIme.so nao encontrada ' +
                             'em "%s". Gatilhos imediatos e envio de e-mail ficam indisponiveis ' +
                             'neste processo.',
                             [ExtractFilePath(Application.ExeName)]));
    Exit;
  end;

  fCarregarDllGatIme := GetProcAddress(HandleDllGatilhosImediatos, PChar('fCarregarDll'));
  fContratoVersaoGatImeSO := GetProcAddress(HandleDllGatilhosImediatos, PChar('fContratoVersaoGatIme'));

  if not Assigned(fCarregarDllGatIme) then
    pGravarErro(True, 'pCarregaFuncoesDllGatilhoImediatos: a libGatIme.so carregada nao expoe ' +
                      'fCarregarDll - biblioteca anterior ao Req. 455094.');
end;
```

- [ ] **Passo 4: conferir o encoding**

`untDllGatIme.pas` tem acentuação. Rodar `file` antes e `svn diff | wc -l` depois; diff que explode
de dezenas para centenas de linhas é conversão de EOL, não a edição.

---

### Tarefa 5: Os dois chamadores do robô de gatilhos

**Arquivos:**
- Modificar: `padra_atualizado/fontes/util/untGatilhosInformacao.pas:814` e `:877`

Não estavam na spec — apareceram no `grep` da tarefa 1. Sem eles, a Fase 1 não compila.

- [ ] **Passo 1: declarar a variável e repassar**

Nos dois blocos, o padrão é o mesmo. O motivo não é ignorado: quem processa gatilho de informação
também se beneficia de saber por que não saiu.

```pascal
var
  LstrIdGatilho: String;
  LstrMotivo   : String;
...
  if LGatIme.fGravarGatilhoObtendoId(TRecGatilhoImediato.Create(...), LstrIdGatilho, LstrMotivo) then
  begin
    if LGatIme.fProcessarGatilho(LstrIdGatilho, LstrMotivo) <> tpEnviadoOK then
      pLog('Gatilho ' + LstrIdGatilho + ' nao enviado: ' + LstrMotivo);
  end
  else
    pLog('Gatilho nao gravado: ' + LstrMotivo);
```

Conferir como aquela unit registra log — se não houver `pLog` ali, usar `pGravarErro(True, ...)`,
que é o que o resto do arquivo usa. **Não inventar função de log.**

- [ ] **Passo 2: fim da fase — pedir a compilação**

Pedir ao usuário a compilação Linux do `Services.groupproj` (ou ao menos da `libGatIme` e do
`SuprimentoServicesAPI`) e do `autcom.groupproj` no Windows. Aguardar. Erro de assinatura aparece
aqui, não depois.

---

## Fase 2 — Contrato REST

### Tarefa 6: DTO do corpo

**Arquivos:**
- Modificar: `Services/Core/suprimento/services/types/Suprimento.Services.Cotacao.Types.pas:826-851`

**Interfaces:**
- Produz: `TCotacaoExportacaoFornecedorParams` com `codigo`, `enviarEmail`, `destinatarios`,
  `opcoes`; e `TCotacaoExportacaoGerarParams.fornecedores:
  TObjectList<TCotacaoExportacaoFornecedorParams>`. As tarefas 7, 9 e 10 consomem.

- [ ] **Passo 1: a classe nova, antes do `GerarParams`**

```pascal
  { Um item do array "fornecedores" do POST. Ate o Req. 462624 o array era de string e as tres
    decisoes - enviar, para quem, com quais colunas - valiam para o lote inteiro. }
  TCotacaoExportacaoFornecedorParams = class
  private
    Fcodigo: String;
    FenviarEmail: Boolean;
    Fdestinatarios: TArray<String>;
    Fopcoes: TCotacaoExportacaoOpcoes;
  public
    constructor Create;
    destructor Destroy; override;
  published
    [MVCSwagJsonSchemaField(stString, 'codigo', 'Codigo do fornecedor. Gera um arquivo. Vazio e recusado com 400', True, False)]
    property codigo: String read Fcodigo write Fcodigo;

    [MVCSwagJsonSchemaField(stBoolean, 'enviarEmail', 'Enviar a planilha deste fornecedor aos destinatarios deste item', False, False)]
    property enviarEmail: Boolean read FenviarEmail write FenviarEmail;

    [MVCSwagJsonSchemaField(stArray, 'destinatarios', 'Enderecos deste fornecedor. Nao ha consulta ao cadastro: vazio com enviarEmail verdadeiro falha so este fornecedor', False, False)]
    property destinatarios: TArray<String> read Fdestinatarios write Fdestinatarios;

    [MVCSwagJsonSchemaField(stObject, 'opcoes', 'Opcoes de conteudo da planilha deste fornecedor. Omitido vale como todas falsas', False, False)]
    property opcoes: TCotacaoExportacaoOpcoes read Fopcoes write Fopcoes;
  end;
```

Construtor e destrutor seguem o que o `GerarParams` já faz com `opcoes` — instanciar sempre, pelo
motivo que o comentário de l. 1661 registra:

```pascal
constructor TCotacaoExportacaoFornecedorParams.Create;
begin
  inherited Create;
  Fopcoes := TCotacaoExportacaoOpcoes.Create;
end;

destructor TCotacaoExportacaoFornecedorParams.Destroy;
begin
  FreeAndNil(Fopcoes);
  inherited Destroy;
end;
```

- [ ] **Passo 2: `GerarParams` perde três campos e troca o tipo do quarto**

```pascal
  TCotacaoExportacaoGerarParams = class
  private
    FsequencialCotacao: String;
    Ffornecedores: TObjectList<TCotacaoExportacaoFornecedorParams>;
  public
    constructor Create;
    destructor Destroy; override;
  published
    [MVCSwagJsonSchemaField(stString, 'sequencialCotacao', 'AUTOINCREM da capa da cotacao em COTGER. Tabela oficial, nao o rascunho COTGER_RES', True, False)]
    property sequencialCotacao: String read FsequencialCotacao write FsequencialCotacao;

    [MVCListOf(TCotacaoExportacaoFornecedorParams)]
    [MVCSwagJsonSchemaField(stArray, 'fornecedores', 'Um objeto por fornecedor, com envio, destinatarios e opcoes proprios. Lista vazia e recusada com 400', True, False)]
    property fornecedores: TObjectList<TCotacaoExportacaoFornecedorParams> read Ffornecedores write Ffornecedores;
  end;
```

Construtor cria a lista com posse (`Create(True)`), como o `GerarResult` já faz; destrutor a libera.
O `Fopcoes` de raiz **sai** dos dois.

- [ ] **Passo 3: `ValidarParams` ganha o campo do pré-voo**

```pascal
    [MVCSwagJsonSchemaField(stBoolean, 'algumEnvioPedido', 'Verdadeiro quando ao menos um item pediu envio por e-mail. O pre-voo so confere a libGatIme nesse caso', False, False)]
    property algumEnvioPedido: Boolean read FalgumEnvioPedido write FalgumEnvioPedido;
```

O comentário de bloco daquela classe diz que ela "não olha opções nem destinatários". Ele continua
verdadeiro e ganha a frase que explica o campo novo — **não** apagar o comentário: ele registra a
decisão de arquitetura que impede alguém de mandar o corpo inteiro para o pré-voo.

---

### Tarefa 7: Geração por item

**Arquivos:**
- Modificar: `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Exportacao.pas`

**Interfaces:**
- Consome: `TCotacaoExportacaoFornecedorParams` (tarefa 6); `fProcessarGatilho` e
  `fGravarGatilhoObtendoId` com `out` (tarefa 4).

- [ ] **Passo 1: `fMontarRecord` recebe o item**

A assinatura troca `AParams: TCotacaoExportacaoGerarParams` por
`AItem: TCotacaoExportacaoFornecedorParams`, e `AstrCodFor` some — o código está no item. As dez
atribuições passam a ler `AItem.opcoes`. O comentário sobre atribuição por nome continua: ele
explica por que o record não é montado posicionalmente, e isso não mudou.

`fGerarDeUmFornecedor` idem: recebe o item e usa `AItem.opcoes.embalagemCompra` e
`AItem.opcoes.exportarSemPreco` na chamada a `fExportarPlanilhaFornecedor`.

- [ ] **Passo 2: destinatário vem do item, sem fallback**

Em `pEnviarDeUmFornecedor`, o bloco de l. 218-225 inteiro é substituído. O comentário atual explica
a precedência sobre o cadastro — essa regra deixou de existir, então o comentário sai junto e dá
lugar ao que vale agora:

```pascal
  { Sem consulta a cadastro: o array do item e a lista final. Quem monta o request resolve o
    contato - Req. 462624, RN01. }
  if Length(AItem.destinatarios) = 0 then
  begin
    AFornecedor.mensagem := 'Envio pedido sem destinatario informado para este fornecedor.';
    Exit;
  end;

  LstrDestino := String.Join(';', AItem.destinatarios);
```

- [ ] **Passo 3: remover `fEmailDoCadastro`**

Some a implementação (l. 190-204) e a declaração. Rodar
`grep -rn "fEmailDoCadastro" padra_atualizado` e confirmar zero ocorrências.

- [ ] **Passo 4: a mensagem passa a dizer motivo e desfecho**

O bloco de l. 276-292 muda de forma. As duas chamadas devolvem motivo, e o texto final depende do
desfecho — a promessa de retentativa só sai quando é verdade:

```pascal
var
  LstrMotivo : String;
  LResultado : TResultEnvio;
...
  LGatIme := TDllGatime.fNew;

  if not LGatIme.fGravarGatilhoObtendoId(TRecGatilhoImediato.Create(...), LstrIdGatilho, LstrMotivo) then
  begin
    { NAO ficou pendente: sem linha na fila, nao ha o que o robo pegar. Afirmar pendencia aqui
      manda o usuario esperar por algo que nunca acontece - Req. 462624, RN07. }
    AFornecedor.mensagem := 'A planilha foi gerada, mas o e-mail nao foi enfileirado: ' +
                            LstrMotivo + ' Corrija e reexporte.';
    Exit;
  end;

  LResultado := LGatIme.fProcessarGatilho(LstrIdGatilho, LstrMotivo);
  AFornecedor.emailEnviado := LResultado = tpEnviadoOK;

  if not AFornecedor.emailEnviado then
  begin
    if LResultado = tpTentarNovamente then
      AFornecedor.mensagem := 'A planilha foi gerada. O e-mail ficou pendente na fila: ' +
                              LstrMotivo
    else
      { pMarcaEnvioEmail carimba GAT_D_EEMA tambem no erro, e o laco do robo so processa canal
        com data nula: marcado, ninguem mais pega esta linha. }
      AFornecedor.mensagem := 'A planilha foi gerada, mas o e-mail nao foi enviado: ' +
                              LstrMotivo + ' Corrija e reexporte.';
    Exit;
  end;
```

O comentário de bloco de l. 250-259, que enuncia a RN24 do 455094, **é corrigido, não apagado**: a
decisão de delegar à libGatIme continua valendo e precisa sobreviver; o que muda é a frase sobre
pendência. Substituir o parágrafo do `emailEnviado` por um que aponte para a RN07 do 462624.

- [ ] **Passo 5: o laço de `fGerar` itera objetos**

`LintTotal := AParams.fornecedores.Count`; o item vira `AParams.fornecedores[LintIdx]`;
`LFornecedor.codigoFornecedor := LItem.codigo`; e a condição de envio passa a ser
`LItem.enviarEmail and LFornecedor.arquivoGerado`.

---

### Tarefa 8: Guarda de travessia do download

**Arquivos:**
- Modificar: `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Consulta.pas:849-855`

Sem esta tarefa, todo download passa a responder 404.

- [ ] **Passo 1: ler `codigo` do objeto**

```pascal
    for LItem in LArr do
    begin
      { Item de objeto desde o Req. 462624. O LItem.Value de um TJSONObject devolve string vazia,
        e a comparacao passaria a nunca casar - 404 em download legitimo. }
      if not (LItem is TJSONObject) then
        Continue;

      if SameText(TJSONObject(LItem).GetValue<String>('codigo', '').Trim, ACodFornecedor.Trim) then
        Exit(True);
    end;
```

- [ ] **Passo 2: conferir se há outro leitor do mesmo JSON**

```
grep -rn "GetValue<TJSONArray>('fornecedores'" padra_atualizado/Services
```
Esperado: duas ocorrências em `Consulta.pas` (l. 681 e l. 849). **A de l. 681 lê o `SST_RESULT`, não
o `SST_PARAMS`** — é a lista da resposta, que não muda de forma. Conferir isso lendo o contexto
antes de alterar; alterar a errada quebra o GET de andamento.

---

### Tarefa 9: Controller

**Arquivos:**
- Modificar: `Services/Suprimento.Services.API/Source/api/controller/api.controller.cotacao.pas:358-440`

- [ ] **Passo 1: validações de formato**

A de lista vazia continua, com a mensagem atual. Duas novas, no mesmo bloco e com o mesmo estilo de
justificativa:

```pascal
      if LParams.fornecedores.Count = 0 then
        raise EInvalidParams.Create(
          'Informe ao menos um fornecedor em "fornecedores". A exportacao gera um arquivo por ' +
          'fornecedor e nao assume a cotacao inteira.');

      LlstCodigos := TStringList.Create;
      try
        LlstCodigos.CaseSensitive := False;
        LlstCodigos.Sorted        := True;
        LlstCodigos.Duplicates    := dupError;

        for LItem in LParams.fornecedores do
        begin
          if LItem.codigo.Trim.IsEmpty then
            raise EInvalidParams.Create('Ha item em "fornecedores" sem o campo "codigo".');

          { O arquivo e nomeado por processamento + fornecedor: repetido sobrescreveria o arquivo
            do primeiro, e o download nao teria como devolver os dois. }
          if LlstCodigos.IndexOf(LItem.codigo.Trim) >= 0 then
            raise EInvalidParams.CreateFmt(
              'O fornecedor "%s" aparece mais de uma vez em "fornecedores".', [LItem.codigo.Trim]);

          LlstCodigos.Add(LItem.codigo.Trim);
        end;
      finally
        LlstCodigos.Free;
      end;
```

- [ ] **Passo 2: alimentar o pré-voo**

```pascal
        LValidar.algumEnvioPedido := False;
        for LItem in LParams.fornecedores do
          if LItem.enviarEmail then
          begin
            LValidar.algumEnvioPedido := True;
            Break;
          end;
```

- [ ] **Passo 3: 503 na lista de exceções da action**

```pascal
    on e: ECotacaoExportacaoEnvioIndisponivel do
      Self.RenderStatusMessage(HTTP_STATUS.ServiceUnavailable, e.Message,
                               'TCotacaoController.GerarExportacao');
```

**A classe não nasce onde parece.** As duas irmãs
(`ECotacaoExportacaoEmAndamento`, `ECotacaoExportacaoTetoAtingido`) são **apelidos** em
`Suprimento.Services.Cotacao.Types.pas:37-38` — as classes vivem em `untTypesSistema.pas`, que é
onde o `Services.Core.Worker` também enxerga. São três edições, e pular qualquer uma faz o 503
voltar como 500:

1. Declarar `ECotacaoExportacaoEnvioIndisponivel` em `fontes/genericos/untTypesSistema.pas`, ao lado
   das outras duas.
2. Apelidar em `Suprimento.Services.Cotacao.Types.pas`, seguindo a forma vizinha:
   `ECotacaoExportacaoEnvioIndisponivel = untTypesSistema.ECotacaoExportacaoEnvioIndisponivel;`
3. Acrescentar o elo na cadeia de `Services.Core.Worker.pas:1206-1213`:
   ```pascal
     else if LErrorClass = 'ECotacaoExportacaoEnvioIndisponivel' then raise ECotacaoExportacaoEnvioIndisponivel.Create(Result)
   ```
   O `else raise Exception.Create(Result)` da última linha é o que transforma classe fora da cadeia
   em 500 genérico.

Ao mexer em `untTypesSistema.pas`, conferir antes se o nome já existe: aquela unit é pré-requisito
de todos os projetos e nome repetido é resolvido pela ordem do `uses`, sem warning.

- [ ] **Passo 4: Swagger**

`[MVCSwagResponses(HTTP_STATUS.ServiceUnavailable, 'Envio de e-mail indisponivel neste servidor')]`
na action. Só fato verificado — nada de exemplo ou default inventado.

---

### Tarefa 10: Pré-voo confere a libGatIme

**Arquivos:**
- Modificar: `Services/Core/suprimento/services/Suprimento.Services.Workers.pas:230-280`

**Interfaces:**
- Consome: `fLibGatImeDisponivel` (tarefa 4); `algumEnvioPedido` (tarefa 6).

- [ ] **Passo 1: a conferência, depois das cinco que já existem**

Última da fila de propósito: as outras cinco são sobre a cotação e o operador, e recusar por
ambiente antes de saber se a cotação existe daria 503 para um pedido que era 400.

```pascal
    { Conferido AQUI e nao no controller: e o processo filho que carrega a .so, e e este que a
      tarefa vai usar. Perguntar no processo HTTP responderia por outro processo.

      So quando alguem pediu envio: lote que so gera arquivo nao depende da biblioteca, e recusa-lo
      seria negar trabalho que roda perfeitamente - Req. 462624, RN13. }
    if LParams.algumEnvioPedido and (not fLibGatImeDisponivel(LstrMotivo)) then
      raise ECotacaoExportacaoEnvioIndisponivel.CreateFmt(
        'O envio de e-mail esta indisponivel neste servidor: %s', [LstrMotivo]);
```

- [ ] **Passo 2: fim da fase — pedir a compilação**

Pedir a compilação Linux do `SuprimentoServicesAPI` e aguardar antes de escrever os testes. Caso de
teste escrito contra binário que não compila não prova nada.

---

## Fase 3 — Testes

Os casos 49 a 54 mandam o corpo antigo e vão reprovar em bloco. Cada caso é **três artefatos**: o
`.sql` em `Scripts/testes/casos/`, o `[TestCase]` no `.inc` e o método Delphi. O `.sql` não é coberto
pelo hook de encoding — acento ali exige troca em bytes.

### Tarefa 11: Reescrever os casos existentes

**Arquivos:**
- Modificar: `Scripts/testes/casos/0049_*.sql` a `0054_*.sql`

- [ ] **Passo 1: converter o `request` dos seis**

Exemplo, caso 50:

```json
{"sequencialCotacao":"02200000000000150022","fornecedores":[{"codigo":"00000672","opcoes":{"todosOsItens":true}},{"codigo":"28001426","opcoes":{"todosOsItens":true}},{"codigo":"28001427","opcoes":{"todosOsItens":true}}]}
```

- [ ] **Passo 2: o caso 54 perde a premissa e precisa de premissa nova**

O cabeçalho dele diz, em letras claras, que **não** manda `destinatarios` de propósito, para que o
motor use o `FOR_EMAPED` do cadastro — e é assim que ele prova que a planilha do fornecedor A vai
para o endereço de A. Com a RN01 esse caminho deixou de existir.

O caso continua valendo, com outra mecânica: cada item manda o **seu** `destinatarios`, com o sufixo
do próprio código (`teste.api.citel+00000672@gmail.com`), e o assert continua casando `GAT_EMAIL_`
com o código dentro de `GAT_NOMARQ`. O que ele prova passa a ser: a API não embaralha os
destinatários entre os itens.

O `sql_before` que reescreve `FOR_EMAPED` **sai** — não há mais leitura de cadastro, e deixá-lo
sugeriria que ainda há.

Reescrever o cabeçalho inteiro do arquivo. Cabeçalho que descreve mecânica que não existe mais é
pior que cabeçalho nenhum.

- [ ] **Passo 3: o caso 52 muda de significado**

Ele prova degradação com destinatário inválido (`"sem-arroba-invalido"`). Continua válido, mas agora
o array vive no item. Conferir se a mensagem esperada mudou: com a RN02, destinatário **vazio** dá
"Envio pedido sem destinatario informado"; destinatário **inválido** continua caindo em "Fornecedor
sem e-mail valido para envio", que vem do `pCriarArrayAnexosEDestinatarios`. São dois casos
distintos — o 52 cobre o inválido, e o vazio é caso novo na tarefa 12.

### Tarefa 12: Casos novos

**Arquivos:**
- Criar: `0055_TEST_EXPORTACAO_FORNECEDOR_DUPLICADO_400_01.sql`
- Criar: `0056_TEST_EXPORTACAO_CODIGO_VAZIO_400_01.sql`
- Criar: `0057_TEST_EXPORTACAO_ENVIO_MISTO_01.sql`
- Criar: `0058_TEST_EXPORTACAO_OPCOES_POR_FORNECEDOR_01.sql`
- Criar: `0059_TEST_EXPORTACAO_ENVIO_SEM_DESTINATARIO_ITEM_01.sql`
- Modificar: `Target/Linux/Test_Cases/cotacao/GerarExportacaoTest.inc`

- [ ] **Passo 1: os dois 400**

Mesma forma dos casos 37 e 38, que já cobrem recusa de formato. Conferir a **ordem** das validações:
o `.inc` documenta que operador é validado antes do corpo, e os casos novos precisam respeitar isso
no que esperam.

- [ ] **Passo 2: envio misto (critério 2)**

Dois fornecedores, um com `enviarEmail: true` e destinatário próprio, outro com `false`. Assert:
`TAREFA_ARQUIVOS=2`, `TAREFA_ENVIADOS=1`, e **uma** linha em `GATIME_WPPEMA`. É o caso que só existe
por causa deste requisito — nenhum outro prova que o envio é decidido por item.

- [ ] **Passo 3: opções distintas (critério 3)**

Dois fornecedores com `opcoes` diferentes. O assert de banco não enxerga o conteúdo da planilha — é
a limitação que o `.inc` já registra. Este caso afirma o que dá para afirmar do banco:
`quantidadeItens` diferente entre os dois, usando `todosOsItens` ligado num e desligado no outro. A
conferência visual das colunas entra no `ROTEIRO_MANUAL.md`.

- [ ] **Passo 4: envio pedido sem destinatário (critério 5)**

Dois fornecedores, ambos com `enviarEmail: true`, um sem `destinatarios`. Assert: os dois arquivos
gerados, `TAREFA_ENVIADOS=1`, e a mensagem do que falhou nomeando a falta do destinatário. Prova a
RN02 e, junto, o critério 13.

- [ ] **Passo 5: registrar no `.inc`**

Um `[TestCase]` por caso novo, e atualizar o cabeçalho do arquivo — ele descreve hoje que o 53 e o
54 usam caminhos distintos de destinatário, e isso deixou de ser verdade.

- [ ] **Passo 6: `999_CONFERENCIA.sql` e `validar_casos.py`**

Rodar `python validar_casos.py` e conferir que os casos novos aparecem. O
`conferir_casos.py` exige `svn update` antes — cópia atrasada gera divergência falsa.

### Tarefa 13: O que não vira caso automatizado

- [ ] **Passo 1: registrar no `ROTEIRO_MANUAL.md`**

Três coisas não cabem na suíte e precisam de roteiro escrito:

- **Critério 9 e 10** (libGatIme indisponível): exige renomear a `.so` no servidor. Não é algo que o
  runner faça, e automatizar isso derrubaria o envio dos outros casos da mesma rodada.
- **Critério 12** (`VS_PermitidoEnviarEmail`): depende de flag de ambiente.
- **Critério 3**, parte visual: quais colunas saíram em cada planilha.

- [ ] **Passo 2: o caso de credencial de SMTP**

A seção 9 da spec marca como **não confirmado** se o erro de credencial escapa como exceção. O
roteiro manual registra como verificar: derrubar a senha do operador de envio na base de teste,
exportar com envio, e conferir se `mensagem` traz o texto do Google ou o genérico. **Confirmar antes
de afirmar qualquer coisa na baixa do requisito.**

---

## Fase 4 — Validação

### Tarefa 14: Rodar e conferir

- [ ] **Passo 1: compilação**

Pedir ao usuário: `Services.groupproj` para Linux e `autcom.groupproj` no Windows. A `libGatIme`
precisa ir junto — o portão de versão recusa a `.so` v2 e o serviço passaria a recusar todo envio
com 503, que é o comportamento certo mas não é o que queremos em teste.

- [ ] **Passo 2: provisionar e rodar a suíte**

A suíte é provisionada por cópia para o share `c_linux` = `/dados`; `TestExecute.exe` não é
versionado, então commit não atualiza o CI que estiver rodando.

- [ ] **Passo 3: conferir os catorze critérios**

Percorrer a seção 8 da spec um a um e anotar qual caso cobre cada um. Critério sem caso é lacuna, e
lacuna vai declarada na baixa — não some no encurtamento.

- [ ] **Passo 4: conferir o diff antes do DelphAI**

`svn diff | wc -l` por arquivo. Número que não bate com o tamanho da edição é EOL convertido.
Conferir contra `svn cat`.

- [ ] **Passo 5: commit**

Primeira linha `Req. 462624`, token do DelphAI na mensagem. Um commit só. O campo de análise do
DelphAI corta em 65.535 caracteres sem avisar — gerar versão derivada se o texto passar disso.

---

## Autorrevisão

**Cobertura da spec.** RF01-RF05 → tarefas 6, 7, 9. RF06 → tarefas 1-4, 7. RF07 → tarefas 9, 10.
RN01 → tarefa 7 passo 2 e 3. RN02 → tarefa 7 passo 2, caso da tarefa 12 passo 4. RN03, RN04 → tarefa
9. RN05 → tarefa 6 (construtor instancia `opcoes`). RN06 → tarefa 8. RN07, RN08 → tarefa 7 passo 4.
RN09 → tarefa 1. RN10 → tarefas 3 e 4. RN11 → tarefas 2, 3, 4. RN12 → nenhuma tarefa toca
`TEnvioEmail`, que é o cumprimento. RN13 → tarefas 4 passo 2 e 3, 10. Critérios 1-14 → fases 3 e 4.

**Achado que a spec não previa:** `untGatilhosInformacao.pas` tem dois chamadores das assinaturas
que mudam. Virou tarefa 5. Sem ela a Fase 1 não compila.

**Consistência de nomes.** `fLibGatImeDisponivel(out AstrMotivo)` é o mesmo nome na tarefa 4 que
define e nas tarefas 4 e 10 que chamam. `algumEnvioPedido` é o mesmo na tarefa 6 que declara e na 9
que preenche e na 10 que lê. `ECotacaoExportacaoEnvioIndisponivel` é o mesmo nas tarefas 9 e 10.
`TCotacaoExportacaoFornecedorParams` é o mesmo nas tarefas 6, 7 e 9.

**Ponto que o executor precisa conferir e não presumir:** na tarefa 8, quais das duas leituras de
`fornecedores` em `Consulta.pas` é a do `SST_PARAMS`. Alterar a errada quebra o GET de andamento em
vez de consertar o download.
