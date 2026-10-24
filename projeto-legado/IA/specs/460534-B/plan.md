# Contexto de execução no LOGERR dos robôs Linux — Plano de Implementação

**Goal:** Todo erro gravado em `LOGERR` por processo Linux passa a trazer, no `LOG_RELERR`, quem executava — binário, módulo, máquina, banco, empresa, operador — e o que estava sendo processado — rota REST, task de worker, gatilho ou daemon, com o payload de entrada mascarado e truncado.

**Architecture:** Uma unit nova em `Services/Core` monta o bloco de texto. `TDBUtils` ganha um `class var` de ponteiro de função **só no ramo `{$IFDEF LINUX}`**, atribuído no `initialization` de `Services.Core.Connection.Manager` — mesmo mecanismo dos outros vinte `class var` que já existem ali. `pGravarLogErr` prefixa o `strRelatorio` com o retorno desse ponteiro. Os quatro entry points (REST, worker, monitor, gatilho) publicam origem e payload numa `threadvar`.

**Tech Stack:** Delphi / Object Pascal, alvo Linux via PAServer; DMVCFramework (middleware REST); UniDAC; MySQL.

**Spec:** `IA\specs\460534-B\spec.md` — ler junto. O plano argumenta a partir dela.

---

## Global Constraints

Valem para **todas** as tarefas. Violação de qualquer uma reprova a tarefa.

- **Zona Moderna** (`padra_atualizado/Services/`): dot-notation nas units, sem Hungarian style. Locais com prefixo `L`, parâmetros com `A` — é a convenção real do `Services/Core`.
- **Zona Legado** (`padra_atualizado/fontes/genericos/untDBUtils.pas`): manter o estilo existente do arquivo. Não refatorar em volta.
- **`const` em todo parâmetro que o método não altera.**
- **Nada de `Now()`, `Now`, `nOw()`** — trava do pre-commit SVN. Ver a constraint de relógio abaixo.
- **Não usar** `TBitBtn`, `TButton`, `TClientDataSet`, `TDataSetProvider`, `TDBGrid`, `dxSkin*`, `.SetFocus`, `StrToFloat(`, `StrToFloatDef(`, `Application.CreateForm(`.
- **Encoding:** `.pas` deste projeto é Windows-1252 (cp1252) com CRLF. O hook `.claude/hooks/delphi-encoding.ps1` cobre `.pas`/`.dfm`/`.dpr`/`.inc`. **Não escrever acento em comentário de código novo** — o `Services/Core` já é ASCII puro nos comentários; seguir isso elimina a classe inteira de problema.
- **Arquivo novo exige `svn add`.**
- **Commit é gated:** primeira linha `Req. ####` e token do DelphAI obrigatório. Este trabalho ainda não tem número de requisito — **não commitar** sem ele.
- **Nenhuma alteração de schema.** Nenhuma coluna nova em `LOGERR`.
- **Nenhum acesso a banco** dentro da montagem do contexto. Sem `fCampoTabela`, `fTabelaExiste`, `fCfgSis`, query ou abertura de conexão.
- **Nenhuma exceção escapa** da montagem do contexto. `try/except` que engole e devolve `''`.
- **Relógio:** usar `Services.Core.Utils.fGetDate + Services.Core.Utils.fTime(True)`. O `True` é obrigatório — sem ele, `fTime` cai em `untHorarioSistema.GetTime(VS_strCodEmp, LConn)` ([Services.Core.Utils.pas:939-953](../../padra_atualizado/Services/Core/Services.Core.Utils.pas)), que lê configuração pela conexão e viola a constraint anterior. Com `True`, é `Time()` puro.
- **Preferir acessor a global.** `fGetDate`, `fGetEmpresaLogada` ([Services.Core.Settings.pas:1706](../../padra_atualizado/Services/Core/Services.Core.Settings.pas)) e `fGetUsuarioLogado` (`:1701`) em vez de `VS_Date`, `VS_strCodEmp` e `strLoginUsuarioLogado` direto. Mesmo valor, sem depender de saber em qual unit cada global é declarada.
- **Tetos:** payload 8192 caracteres, bloco 12288. `Length` em Delphi conta caracteres UTF-16, não bytes — os números são caracteres, e o texto de corte deve dizer isso.

---

## Estrutura de arquivos

| Arquivo | Responsabilidade | Ação |
|---------|------------------|------|
| `padra_atualizado/Services/Core/Services.Core.ContextoExecucao.pas` | Monta o bloco. Guarda `threadvar` de origem/payload/início. Mascara e trunca. É a única unit que conhece o formato do bloco | **Criar** |
| `padra_atualizado/fontes/genericos/untDBUtils.pas` | Declara o `class var` e prefixa o `strRelatorio` | Modificar (`:32-40` e `:576-600`) |
| `padra_atualizado/Services/Core/Services.Core.Connection.Manager.pas` | Atribui o `class var` no `initialization` | Modificar (`:5822-5845`) |
| `padra_atualizado/Services/Core/api/core/api.core.middleware.pas` | Publica origem e payload da requisição REST | Modificar (`:49-80`) |
| `padra_atualizado/Services/Core/Services.Core.Worker.pas` | Publica origem e payload da task | Modificar (`:2110-2130`) |
| `padra_atualizado/Services/Core/Services.Core.Task.Monitor.pas` | Publica origem e argumentos do daemon | Modificar (`:101-125`) |
| `padra_atualizado/Services/GatilhosInformacao/Target/Linux/MonitorarGatilhos/untGatilhos.pas` | Publica origem do gatilho | Modificar (`:30`) |

A unit nova concentra formato, máscara e truncamento num lugar só. Os seis consumidores só chamam `pDefinirOrigem` / `pLimparOrigem` — nenhum deles sabe como o bloco é escrito. Mudar o formato depois é mexer em um arquivo.

---

## Ordem e dependência

Tarefa 1 entrega a unit sem consumidor. Tarefa 2 liga no `pGravarLogErr` e já produz resultado visível — a camada ambiente aparece em todo erro Linux, sem tocar em nenhum entry point. As tarefas 3 a 6 são **independentes entre si** e podem ser feitas em qualquer ordem, ou em paralelo: cada uma acrescenta a `Origem` de um entry point e nenhuma depende do que a outra faz.

---

### Task 1: Unit de contexto de execução

**Files:**
- Create: `padra_atualizado/Services/Core/Services.Core.ContextoExecucao.pas`

**Interfaces:**
- Consumes: `Services.Core.Utils` (`GetComputerNetName`, `GetCurrentProcessId`, `GetCurrentThreadId`, `fGetDate`, `fTime`); `Services.Core.Settings` (`fGetEmpresaLogada`, `fGetUsuarioLogado`); `Services.Core.Connection.Manager` (`TConnectionsManager.ConnectionParams`)
- Produces:
  - `procedure pDefinirOrigem(const AOrigem: string; const APayload: string = '');`
  - `procedure pLimparOrigem;`
  - `function fMontarContextoExecucao: string;`

- [ ] **Step 1: Criar o arquivo com a interface**

```pascal
unit Services.Core.ContextoExecucao;

{ Contexto anexado ao LOG_RELERR de todo erro gravado em processo Linux.
  Contrato, decisoes e criterios: IA\specs\460534-B\spec.md }

interface

{ Publica o que so o entry point sabe. O payload e mascarado e truncado aqui
  dentro - quem chama passa o texto cru. }
procedure pDefinirOrigem(const AOrigem: string; const APayload: string = '');

{ Obrigatorio no finally do entry point: threadvar de tipo gerenciado nao e
  finalizada pela RTL na saida da thread nesta base - ver untProximoCodigo.pas
  linha 958. Sem esta chamada a string fica presa na thread do pool. }
procedure pLimparOrigem;

{ Bloco pronto para prefixar o LOG_RELERR. Devolve '' quando a montagem falha:
  erro ao montar contexto nao pode apagar o erro original. }
function fMontarContextoExecucao: string;

implementation
```

- [ ] **Step 2: Escrever o `uses`, as constantes e o estado**

```pascal
uses
  System.SysUtils,
  System.StrUtils,
  System.Classes,
  System.RegularExpressions,
  Services.Core.Utils,
  Services.Core.Settings,
  Services.Core.Connection.Manager;

const
  CLimitePayload = 8192;
  CLimiteBloco   = 12288;

  { Nome de chave, nao valor. A comparacao e por conteudo do nome, sem
    diferenciar maiusculas: "X-Auth-Token" casa por conter "token". }
  CChavesSensiveis: array[0..10] of string = (
    'senha', 'password', 'pwd', 'pass', 'token', 'authorization',
    'secret', 'apikey', 'api_key', 'bearer', 'client_secret');

threadvar
  FOrigem  : string;
  FPayload : string;
  FInicio  : TDateTime;

var
  { Lido uma vez na primeira montagem. GetComputerNetName e
    ShellExecute('hostname'), que forka um processo - caro dentro de um handler
    de erro, e o nome da maquina nao muda durante a vida do processo. }
  GHost : string;
```

- [ ] **Step 3: Escrever a máscara**

```pascal
function fMascarar(const ATexto: string): string;
  var
    LChave : string;
begin
  Result := ATexto;

  for LChave in CChavesSensiveis do
  begin
    { JSON: "qualquerCoisaChaveQualquerCoisa" : <valor>, onde <valor> e string
      entre aspas com escape, ou literal ate a proxima virgula/fecha. }
    Result := TRegEx.Replace(Result,
      '("[^"]*' + LChave + '[^"]*"\s*:\s*)("(?:[^"\\]|\\.)*"|[^,}\]\s]+)',
      '$1"***"', [roIgnoreCase]);

    { Query string e header: chave=valor ate & ou ; }
    Result := TRegEx.Replace(Result,
      '([?&;]\s*[^=&;]*' + LChave + '[^=&;]*\s*=)([^&;]*)',
      '$1***', [roIgnoreCase]);
  end;
end;
```

- [ ] **Step 4: Escrever o truncamento**

```pascal
function fTruncar(const ATexto: string; const ALimite: Integer): string;
begin
  if (Length(ATexto) <= ALimite) then
    Exit(ATexto);

  Result := Copy(ATexto, 1, ALimite) + sLineBreak +
            Format('[TRUNCADO EM %d CARACTERES - ORIGINAL %d]',
                   [ALimite, Length(ATexto)]);
end;
```

- [ ] **Step 5: Escrever `pDefinirOrigem` e `pLimparOrigem`**

```pascal
procedure pDefinirOrigem(const AOrigem: string; const APayload: string = '');
begin
  try
    FOrigem := AOrigem;
    FInicio := fGetDate + fTime(True);

    if (APayload.Trim.IsEmpty) then
      FPayload := ''
    else
      FPayload := fTruncar(fMascarar(APayload), CLimitePayload);
  except
    { Publicar contexto nao pode derrubar a requisicao que ele descreve. }
    FOrigem  := AOrigem;
    FPayload := '';
  end;
end;

procedure pLimparOrigem;
begin
  FOrigem  := '';
  FPayload := '';
  FInicio  := 0;
end;
```

Atenção ao `except` do `pDefinirOrigem`: ele mantém a `FOrigem`, que é texto controlado pelo chamador, e descarta só o `FPayload`, que é a parte que pode quebrar o `TRegEx`. Perder o payload é aceitável; perder a origem não, e derrubar a requisição muito menos.

- [ ] **Step 6: Escrever `fMontarContextoExecucao`**

```pascal
function fMontarContextoExecucao: string;
  var
    LTexto  : TStringBuilder;
    LArgs   : string;
    LIndice : Integer;
begin
  Result := '';

  try
    if (GHost.IsEmpty) then
      GHost := GetComputerNetName;

    LArgs := '';
    for LIndice := 1 to ParamCount do
      LArgs := LArgs + IfThen(LArgs.IsEmpty, '', ' ') + ParamStr(LIndice);

    LTexto := TStringBuilder.Create;
    try
      LTexto.AppendLine('========== CONTEXTO DE EXECUCAO ==========');
      LTexto.AppendLine('Executavel : ' + ExtractFileName(ParamStr(0)) +
                        ' (' + ParamStr(0) + ')');
      LTexto.AppendLine('Modulo     : ' +
                        ExtractFileName(System.SysUtils.GetModuleName(HInstance)));

      if (not LArgs.IsEmpty) then
        LTexto.AppendLine('Argumentos : ' + LArgs);

      LTexto.AppendLine('Host       : ' + GHost);
      LTexto.AppendLine('PID/Thread : ' + IntToStr(GetCurrentProcessId) +
                        ' / ' + IntToStr(GetCurrentThreadId));

      { Password do mesmo record NAO entra - regra 3 da spec. }
      LTexto.AppendLine('Banco      : ' +
        TConnectionsManager.ConnectionParams.Server + ':' +
        IntToStr(TConnectionsManager.ConnectionParams.Port) + '/' +
        TConnectionsManager.ConnectionParams.Database +
        ' (usuario: ' + TConnectionsManager.ConnectionParams.UserName + ')');

      LTexto.AppendLine('Empresa    : ' + fGetEmpresaLogada);
      LTexto.AppendLine('Operador   : ' + fGetUsuarioLogado);

      if (not FOrigem.IsEmpty) then
        LTexto.AppendLine('Origem     : ' + FOrigem);

      if (FInicio > 0) then
        LTexto.AppendLine('Inicio     : ' +
                          FormatDateTime('yyyy-mm-dd hh:nn:ss', FInicio));

      if (not FPayload.IsEmpty) then
        LTexto.AppendLine('Payload    : ' + FPayload);

      LTexto.AppendLine('==========================================');

      Result := fTruncar(LTexto.ToString, CLimiteBloco);
    finally
      FreeAndNil(LTexto);
    end;
  except
    { Regra 2 da spec. Silencio proposital: relancar aqui apagaria o erro que
      esta sendo logado, que e o que interessa. }
    Result := '';
  end;
end;

end.
```

- [ ] **Step 7: Registrar no SVN**

```bash
svn add padra_atualizado/Services/Core/Services.Core.ContextoExecucao.pas
```

- [ ] **Step 8: Compilar**

Abrir `padra_atualizado/Services/Services.groupproj`, selecionar `FaturamentoServicesAPI`, alvo Linux 64, e **Build** — não Compile.

**Build, nunca Compile, e isto não é preciosismo:** os 38 serviços compartilham a pasta `Services/tmp` de `.dcu`/`.o`. Compile reaproveita artefato gerado por outro projeto, que pode ter sido compilado com defines diferentes — já houve caso de o Financeiro falhar por reusar `.dcu` do Suprimento.

Esperado: compila. A unit ainda não é referenciada por ninguém — para ela entrar no build, adicioná-la temporariamente ao `uses` do `.dpr`, ou aguardar a Task 2, que a referencia de verdade. Preferir a segunda: menos churn no `.dpr`.

---

### Task 2: Ligar o contexto ao `pGravarLogErr`

Esta é a tarefa que produz o primeiro resultado observável: a camada ambiente passa a aparecer em **todo** erro Linux, sem que nenhum entry point tenha sido tocado.

**Files:**
- Modify: `padra_atualizado/fontes/genericos/untDBUtils.pas` (`:32-40`, `:576-600`)
- Modify: `padra_atualizado/Services/Core/Services.Core.Connection.Manager.pas` (`:5822-5845`)

**Interfaces:**
- Consumes: `Services.Core.ContextoExecucao.fMontarContextoExecucao` (Task 1)
- Produces: `TDBUtils.fGetContextoExecucao: function: String;` — existe **apenas** sob `{$IFDEF LINUX}`

- [ ] **Step 1: Declarar o `class var` em `untDBUtils`**

No bloco `{$IFDEF LINUX}` das `class var` de `TDBUtils`, que hoje termina em `fGetCampoTabela` (`untDBUtils.pas:34`), acrescentar como última linha do ramo:

```pascal
    class var fGetContextoExecucao: function: String;
```

Declarar **só** neste ramo. O ramo `{$ELSE}`, do Windows, não recebe o campo — assim é impossível, e não apenas improvável, que o comportamento no desktop mude.

- [ ] **Step 2: Consumir no `pGravarLogErr`**

Em `untDBUtils.pas:576`, dentro de `TDBUtils.pGravarLogErr`, trocar o trecho que grava o `LOG_RELERR`:

```pascal
      FieldByName('LOG_DESCRI').AsString   := strMensagemErro;
      If Not fEmptyStr(strRelatorio) Then
        FieldByName('LOG_RELERR').AsString   := strRelatorio;
```

por:

```pascal
      FieldByName('LOG_DESCRI').AsString   := strMensagemErro;

      strRelatorioFinal := strRelatorio;
     {$IFDEF LINUX}
      { O contexto vem ANTES do relatorio do chamador: quem abre o LOGERR
        precisa saber qual binario e qual chamada antes de ler o detalhe.
        O TFaturamentoAutomatico ja preenche o strRelatorio e os dois convivem. }
      If Assigned(fGetContextoExecucao) Then
      Begin
        strContexto := fGetContextoExecucao();
        If Not fEmptyStr(strContexto) Then
          strRelatorioFinal := strContexto + strRelatorioFinal;
      End;
     {$ENDIF}

      If Not fEmptyStr(strRelatorioFinal) Then
        FieldByName('LOG_RELERR').AsString := strRelatorioFinal;
```

Declarar as duas locais no `Var` do método, junto de `qryLogErr`:

```pascal
  Var
    qryLogErr: TUniQuery;
    strRelatorioFinal: String;
   {$IFDEF LINUX}
    strContexto: String;
   {$ENDIF}
```

Este arquivo é Zona Legado: Hungarian style (`str`), `If`/`Then`/`Begin`/`End` capitalizados, `Var` antes do `begin`. Seguir o que já está no arquivo, não o estilo do `Services/Core`.

- [ ] **Step 3: Atribuir no bootstrap Linux**

Em `Services.Core.Connection.Manager.pas`, no `initialization` que começa na linha 5822, acrescentar após a última atribuição de `TDBUtils` (`TDBUtils.WriteIniFile`, `:5844`):

```pascal
  TDBUtils.fGetContextoExecucao := Services.Core.ContextoExecucao.fMontarContextoExecucao;
```

E acrescentar `Services.Core.ContextoExecucao` ao `uses` da **implementation** desta unit — nunca da interface. `Services.Core.ContextoExecucao` usa `Services.Core.Connection.Manager` na sua própria implementation; referência circular entre implementations é legal em Delphi, entre interfaces não é.

É esta referência que linka a unit nova no binário. Por isso não é preciso tocar em `services.core.uses.inc` nem em nenhum `.dpr`.

- [ ] **Step 4: Build**

`Services.groupproj` → `FaturamentoServicesAPI` → Linux 64 → **Build**.

Esperado: compila sem erro. Se acusar referência circular, conferir se o `uses` do Step 3 foi parar na interface.

- [ ] **Step 5: Build de um segundo serviço, para provar que não quebrou ninguém**

`Services.groupproj` → `SuprimentoServicesAPI` → Linux 64 → **Build**.

Esperado: compila. Serve para pegar cedo qualquer serviço que não linke a unit nova.

- [ ] **Step 6: Build do desktop**

`padra_atualizado/autcom.groupproj` → `autcom` → Win32 → **Build**.

Esperado: compila. Como o `class var` não existe no ramo `{$ELSE}`, qualquer uso acidental fora do `{$IFDEF LINUX}` aparece aqui como erro de compilação — é para isso que a declaração foi restringida.

- [ ] **Step 7: Validar em execução**

Subir o `FaturamentoServicesAPI` no ambiente de teste, provocar um erro em qualquer endpoint e consultar:

```sql
SELECT AUTOINCREM, LOG_DTAERR, LOG_HORERR, LOG_DESCRI, LOG_RELERR
  FROM LOGERR
 WHERE LOG_CODEMP = '001'
 ORDER BY AUTOINCREM DESC
 LIMIT 5;
```

Esperado no `LOG_RELERR`: o bloco com `Executavel`, `Modulo`, `Host`, `PID/Thread`, `Banco`, `Empresa`, `Operador`. **Ainda sem `Origem`, `Inicio` e `Payload`** — eles chegam nas tarefas 3 a 6.

- [ ] **Step 8: Conferir o `Modulo`, que é a incógnita da spec**

Olhar o valor do campo `Modulo` no registro acima e comparar com o `Executavel`.

Se `Modulo` trouxer o nome de uma `.so` (`bplShared260.so` e afins) **em todos** os erros, independente de onde estouraram, então `untDBUtils` está num runtime package e o campo é constante — útil apenas para identificar o pacote, não a origem. É o cenário previsto na seção 9 da spec.

**Registrar o valor observado na seção 9 da spec, com data.** Não remover o campo em silêncio, e não deixar a seção 9 dizendo "a verificar" depois de ter verificado.

- [ ] **Step 9: Verificar que nenhuma query nova foi emitida**

Com o serviço apontado para uma base de teste, ligar o log geral do MySQL, provocar um erro e conferir que entre a query anterior ao erro e o `INSERT` em `LOGERR` não aparece nenhum `SELECT` em `EMPLOJ`, `CFGSIS` ou `CADOPE`.

```sql
SET GLOBAL general_log = 'ON';
-- provocar o erro
SET GLOBAL general_log = 'OFF';
```

Esperado: nenhuma consulta adicional. É o critério de aceitação 3, e é o que separa esta implementação da versão ingênua que usaria `fRetNomeDesteServidor`.

---

### Task 3: Origem e payload na API REST

**Files:**
- Modify: `padra_atualizado/Services/Core/api/core/api.core.middleware.pas` (`:49-80`)

**Interfaces:**
- Consumes: `Services.Core.ContextoExecucao.pDefinirOrigem`, `pLimparOrigem` (Task 1)
- Produces: nada consumido por outras tarefas

- [ ] **Step 1: Descobrir se ler o body consome o stream**

**Fazer isto antes de escrever a captura.** Se `AContext.Request.Body` consumir o stream no `OnBeforeRouting`, o controller passa a receber body vazio e a alteração quebra todos os endpoints POST.

Instrumentação mínima: em `OnBeforeRouting`, logar `Length(AContext.Request.Body)` sem guardar nada; num controller POST qualquer, logar o tamanho do body recebido. Chamar o endpoint e comparar.

Resultado A — o controller continua recebendo o body íntegro: seguir para o Step 2 com a captura em `OnBeforeRouting`.

Resultado B — o controller recebe vazio: mover a captura para `TConnectionMiddleware.OnBeforeControllerAction` ([api.core.middleware.pas:62](../../padra_atualizado/Services/Core/api/core/api.core.middleware.pas)), que hoje é corpo vazio e roda depois do parse. O restante do plano não muda — só o método onde o `pDefinirOrigem` é chamado.

**Anotar qual dos dois ocorreu, aqui no `tasks.md`.** Quem revisar precisa saber qual caminho foi tomado e por quê.

- [ ] **Step 2: Publicar a origem no `OnBeforeRouting`**

Em `api.core.middleware.pas:68`, ao final de `OnBeforeRouting`, imediatamente antes de `AHandled := False`:

```pascal
  { Publica quem chamou para o LOG_RELERR. Fica no fim do metodo porque
    pDefinirUsuario acima ja definiu o operador, e o bloco de contexto le a
    global que ele alimenta. Ver IA\specs\460534-B\spec.md. }
  pDefinirOrigem('REST ' + AContext.Request.HTTPMethodAsString + ' ' +
                 AContext.Request.PathInfo,
                 AContext.Request.Body +
                 IfThen(AContext.Request.QueryStringParams.Count = 0, '',
                        ' ?' + AContext.Request.QueryStringParams.Text));

  AHandled := False;
```

Se o Step 1 deu Resultado B, este bloco vai para `OnBeforeControllerAction` em vez de `OnBeforeRouting`.

- [ ] **Step 3: Limpar no `OnAfterRouting`**

Em `api.core.middleware.pas:55`, dentro de `OnAfterRouting`, antes das duas chamadas que já existem:

```pascal
procedure TConnectionMiddleware.OnAfterRouting(AContext: TWebContext;
  const AHandled: Boolean);
begin
  { Obrigatorio: a thread volta para o pool do Indy e atenderia a proxima
    requisicao carregando a origem da anterior. Alem disso, threadvar de tipo
    gerenciado nao e finalizada pela RTL na saida da thread nesta base. }
  pLimparOrigem;

  pLimparVariaveis;
  EndThreadConnection;
end;
```

- [ ] **Step 4: Acrescentar ao `uses` da implementation**

Em `api.core.middleware.pas`, no `uses` da `implementation` (`:27-31`), acrescentar `Services.Core.ContextoExecucao`. `System.StrUtils` também, se o `IfThen` do Step 2 não resolver — conferir o que já está importado antes de acrescentar duplicado.

- [ ] **Step 5: Build**

`Services.groupproj` → `FaturamentoServicesAPI` → Linux 64 → **Build**.

- [ ] **Step 6: Validar**

Subir o serviço, chamar um endpoint POST que falhe, e consultar o `LOGERR` com a query do Step 7 da Task 2.

Esperado no `LOG_RELERR`: bloco completo, com `Origem : REST POST /caminho/do/endpoint`, `Inicio` preenchido e `Payload` com o body.

- [ ] **Step 7: Validar a máscara**

Chamar um endpoint enviando no body um campo `"senha"` e outro `"token"`, com valores reconhecíveis, e provocar erro.

Esperado: no `LOG_RELERR`, as chaves aparecem e os valores viraram `***`. Se o valor original aparecer, a máscara não pegou o formato — corrigir o `TRegEx` da Task 1 antes de seguir.

- [ ] **Step 8: Validar que não houve regressão nos endpoints**

Rodar a suíte de testes REST do Faturamento (`Services/TestExecute/_ci`).

Esperado: mesmo número de casos passando que antes da alteração. Este é o critério de aceitação 12, e é a rede que pega o Resultado B do Step 1 caso ele tenha passado despercebido.

- [ ] **Step 9: Validar o vazamento entre requisições**

Chamar um endpoint A que **falhe**, depois um endpoint B que **também falhe**, em sequência, com carga suficiente para que o Indy reaproveite a mesma thread.

Esperado: o `LOGERR` do erro de B traz a rota de B, nunca a de A. Se trouxer a de A, o `pLimparOrigem` do Step 3 não está sendo alcançado.

---

### Task 4: Origem e payload no worker

**Files:**
- Modify: `padra_atualizado/Services/Core/Services.Core.Worker.pas` (`:2110-2130`)

**Interfaces:**
- Consumes: `Services.Core.ContextoExecucao.pDefinirOrigem`, `pLimparOrigem` (Task 1)

- [ ] **Step 1: Publicar a origem em `ProcessTask`**

Em `Services.Core.Worker.pas`, dentro de `TWorkerServerBase.ProcessTask`, logo após a linha que monta o `LKey` (`:2117-2118`) e antes do `try` que chama `pNotifyStart` (`:2120`):

```pascal
  { Junto do pDefinirUsuario e do pDefinirTarefa logo acima, pelo mesmo motivo:
    e aqui que a linha da tarefa esta em maos. O id na origem leva a linha da
    tabela, onde o _PARAMS esta inteiro - saida para quando o payload do log
    vier truncado. Ver IA\specs\460534-B\spec.md. }
  pDefinirOrigem('WORKER ' + LKey + ' id=' + LAutoincrem,
                 LQuery.FieldByName(FPrefix + '_PARAMS').AsString);
```

- [ ] **Step 2: Limpar ao final**

`ProcessTask` termina em três `finally` aninhados — `pNotifyFinish` (`:2147`), `pDestravarTodosLocksConexaoAtual` (`:2151`) e `EndThreadConnection` (`:2154`). A limpeza vai no **mais externo**, ao lado do `EndThreadConnection`:

```pascal
  finally
    { Worker atende varias tarefas no mesmo processo: sem isto a proxima tarefa
      herdaria a origem da anterior. Ao lado do EndThreadConnection de proposito
      - e o mesmo par de ciclo de vida usado no middleware REST. }
    pLimparOrigem;
    EndThreadConnection();
  end;
```

Não colocar num dos `finally` internos e não colocar depois do `except`: tarefa que falha é exatamente a que precisa do contexto correto, e uma que falhe sem passar pela limpeza contamina a seguinte.

- [ ] **Step 3: Acrescentar ao `uses` da implementation**

`Services.Core.ContextoExecucao` no `uses` da `implementation` de `Services.Core.Worker.pas`.

- [ ] **Step 4: Build**

`Services.groupproj` → `FaturamentoServicesAPI` → Linux 64 → **Build**. O worker é o mesmo binário, em modo `task`.

- [ ] **Step 5: Validar**

Enfileirar uma task que falhe e consultar o `LOGERR`.

Esperado: `Origem : WORKER <servico>.<metodo> id=<n>` e `Payload` com o JSON de parâmetros. Confirmar que o `id` bate com o `AUTOINCREM` da linha na tabela de tarefas.

- [ ] **Step 6: Validar o encadeamento**

Enfileirar duas tasks distintas em sequência no mesmo worker, a segunda falhando.

Esperado: o `LOGERR` traz o id da segunda. Se trouxer o da primeira, o `finally` do Step 2 não cobre o caminho percorrido.

---

### Task 5: Origem no daemon / monitor

**Files:**
- Modify: `padra_atualizado/Services/Core/Services.Core.Task.Monitor.pas` (`:101-125`)

**Interfaces:**
- Consumes: `Services.Core.ContextoExecucao.pDefinirOrigem`, `pLimparOrigem` (Task 1)

- [ ] **Step 1: Publicar a origem em `TTaskMonitor.Execute`**

Em `Services.Core.Task.Monitor.pas`, dentro de `TTaskMonitor.Execute`, logo após a linha 120 que já monta o `LNomExe`, e antes do `Writeln`:

```pascal
  { O daemon roda um laco unico no processo inteiro: a origem e definida uma vez
    e vale ate o fim. Nao ha limpeza por iteracao, e nao deve haver - erro em
    qualquer ponto do laco pertence a este monitor.
    Ver IA\specs\460534-B\spec.md. }
  pDefinirOrigem('MONITOR ' + LNomExe, LParams);
```

O `LParams` já vem montado dos `ParamStr` nas linhas 116-118 — reaproveitar, não recalcular.

- [ ] **Step 2: Limpar no encerramento**

`Services.Core.Task.Monitor.pas:112` abre um `Try` cujo `finally` já chama `EndThreadConnection` (por volta de `:177`). Acrescentar `pLimparOrigem` nesse mesmo `finally`, antes do `EndThreadConnection`.

- [ ] **Step 3: Acrescentar ao `uses` da implementation**

`Services.Core.ContextoExecucao` no `uses` da `implementation`.

- [ ] **Step 4: Build**

`Services.groupproj` → qualquer serviço que use `TTaskMonitor` — `Bralog` serve — → Linux 64 → **Build**.

- [ ] **Step 5: Validar**

Subir o daemon com argumentos de linha de comando, provocar erro no laço e consultar o `LOGERR`.

Esperado: `Origem : MONITOR <nome do executavel>`, `Argumentos` e `Payload` ambos com os argumentos. A duplicação é intencional — `Argumentos` é da camada ambiente e existe sempre; `Payload` é o que este entry point tem a declarar.

---

### Task 6: Origem no gatilho de informação

**Files:**
- Modify: `padra_atualizado/Services/GatilhosInformacao/Target/Linux/MonitorarGatilhos/untGatilhos.pas` (`:30`)

**Interfaces:**
- Consumes: `Services.Core.ContextoExecucao.pDefinirOrigem`, `pLimparOrigem` (Task 1)

**O que esta tarefa cobre, e o que já estava coberto sem ela.** `TEnviarGatilhos.ExecutarGatilhosInformacao` ([untGatilhos.pas:1519](../../padra_atualizado/Services/GatilhosInformacao/Target/Linux/MonitorarGatilhos/untGatilhos.pas)) **não executa o gatilho** — ela monta os parâmetros e dispara um processo separado, `./GatilhosInformacao`, via `ShellExecute` (`:1682`). Logo:

- Erro **dentro do binário `GatilhosInformacao`** já fica coberto pela Task 2 sozinha, e o campo `Argumentos` da camada ambiente traz o `LParams` com `NUMIP`, `PORTA` e `NOMBAN`. Nada a fazer.
- Esta tarefa cobre erro **no monitor que dispara** — conexão, lock, montagem de parâmetro. É o que falta.

- [ ] **Step 1: Publicar a origem**

`untGatilhos.pas:1550-1551` faz `LConn := TConexao.Create();` seguido de `try`. A publicação vai como **primeira instrução dentro desse `try`**, na linha 1552, antes de `LConn.Servidor := ...`:

```pascal
  LConn := TConexao.Create();
  try
    { Dentro do try, nao antes: ha um Exit precoce em :1538 quando o servidor ja
      esta executando, e o laco chama este metodo repetidamente na mesma thread.
      Publicar fora da regiao protegida deixaria origem obsoleta viva.
      Ver IA\specs\460534-B\spec.md. }
    pDefinirOrigem('GATILHO ' + ADadosConexao.gatilho +
                   ' servidor=' + ADadosConexao.servidor +
                   ' empresa=' + ADadosConexao.empresa,
                   'num_ip=' + ADadosConexao.num_ip +
                   ' porta=' + ADadosConexao.porta +
                   ' banco=' + ADadosConexao.banco);

    LConn.Servidor := ADadosConexao.num_ip;
```

Os campos são os do record declarado em `untGatilhos.pas:11-19`: `empresa`, `num_ip`, `porta`, `banco`, `servidor`, `gatilho`, `status`. **Senha e usuário da conexão não entram** — são atribuídos logo abaixo, em `:1555-1556`, a partir de `fDecrypt`.

- [ ] **Step 2: Limpar**

No `finally` em `untGatilhos.pas:1685`, que já tem o `FreeAndNil(LConn)` protegido e o `pLog` de saída. Acrescentar como primeira linha do `finally`:

```pascal
  finally
    pLimparOrigem;

    try
      FreeAndNil(LConn);
```

- [ ] **Step 3: Acrescentar ao `uses` da implementation**

`Services.Core.ContextoExecucao` no `uses` da `implementation` de `untGatilhos.pas`.

- [ ] **Step 4: Build**

`Services.groupproj` → `MonitorarGatilhos` → Linux 64 → **Build**.

- [ ] **Step 5: Validar o monitor**

Apontar um gatilho para um `num_ip` inexistente, para que a conexão falhe dentro do `try`, e consultar o `LOGERR`.

Esperado: `Origem : GATILHO <gatilho> servidor=<servidor> empresa=<empresa>` e `Payload` com `num_ip`, `porta` e `banco`. Confirmar que **não** aparece senha nem usuário.

- [ ] **Step 6: Validar o binário disparado**

Provocar erro dentro do `GatilhosInformacao` propriamente dito e consultar o `LOGERR`.

Esperado: bloco de ambiente com `Executavel : GatilhosInformacao` e `Argumentos` trazendo `NUMIP`, `PORTA` e `NOMBAN`. **Sem `Origem`** — e está certo assim: aquele processo não passa por nenhum entry point instrumentado, e o caso 5 da spec prevê exatamente isso.

---

## Fechamento

- [ ] **Atualizar a seção 9 da spec** com o valor real de `Modulo` observado no Step 8 da Task 2, com data. É a única incógnita declarada da spec e ela não pode ficar aberta depois de verificada.

- [ ] **Registrar no `tasks.md`** qual caminho o Step 1 da Task 3 tomou — `OnBeforeRouting` ou `OnBeforeControllerAction` — e o que foi observado.

- [ ] **Commit:** `Req. 460534` na primeira linha mais o token do DelphAI. Este trabalho é continuação daquele requisito — pasta renomeada de slug para `460534-B` em 17/09/2026.

---

## Casos a cobrir — entrega para o analista

Os casos de teste são escritos por analista humano. O que a implementação entrega é a lista abaixo, que é a seção 8 da spec transposta para o que cada tarefa deste plano torna verificável.

| # | Caso | Coberto pela | Verificação |
|---|------|--------------|-------------|
| 1 | Erro em endpoint REST | Task 3 | bloco presente, `Origem = REST <verbo> <rota>`, `Payload` com body + query string |
| 2 | Erro em worker | Task 4 | `Origem = WORKER <servic>.<method> id=<n>`, `Payload` com `_PARAMS` |
| 3 | Erro em monitor/daemon | Task 5 | `Origem = MONITOR <nome>`, `Argumentos` e `Payload` preenchidos |
| 4 | Erro em gatilho | Task 6 | `Origem = GATILHO <id>` |
| 5 | Erro sem entry point registrado | Task 2 | bloco presente, sem `Origem`, `Inicio` nem `Payload` |
| 6 | Erro de conexão com o banco | Task 2, Step 9 | bloco traz `Server:Port` configurado; nenhuma query extra |
| 7 | Montagem do contexto lança exceção | Task 1, Step 6 | erro original gravado, sem bloco |
| 8 | Chamador já passa relatório | Task 2, Step 2 | bloco + relatório do chamador, nessa ordem |
| 9 | `Payload` > 8192 caracteres; bloco > 12288 | Task 1, Step 4 | truncados com marca |
| 10 | Execução Windows | Task 2, Step 6 | `LOG_RELERR` inalterado |
| 11 | Body com `senha`, `token`, `Authorization` | Task 3, Step 7 | chaves visíveis, valores `***` |
| 12 | Endpoint com body grande, sem erro | Task 3, Step 8 | controller recebe body íntegro; suíte REST sem regressão |
| 13 | Duas requisições seguidas na mesma thread | Task 3, Step 9 | a segunda não herda a origem da primeira |

---

## Executado em 16/09/2026 — leia a seção 11 da spec antes de usar este plano

Este plano foi escrito antes de compilar. Quatro coisas nele estão **erradas** e ficaram registradas com o porquê em `spec.md`, seção 11:

| Onde | O que o plano dizia | O que é |
|------|---------------------|---------|
| Estrutura de arquivos, Task 1 | Criar `Services.Core.ContextoExecucao.pas` | Não há unit nova. A pasta `Core` não está no caminho de busca — `F2613` no build. O código foi para `Services.Core.Utils` |
| Task 2, Step 3 | "nenhum `.dpr` precisa ser tocado" | Só é verdade porque a unit nova foi abandonada. Com ela, seriam 38 `.dpr` |
| Task 6 inteira | Instrumentar `untGatilhos.pas` do `MonitorarGatilhos` | **Cancelada.** Aquele processo não grava no `LOGERR` — tem cópia local de `untDBUtils`, sem `pGravarLogErr`, e só lê. O binário que grava roda sob `TTaskMonitor` e já é coberto pelas Tasks 2 e 5 |
| Task 3, Step 1 | Verificar em execução se ler o body consome o stream | Resolvido por leitura da fonte do DMVC. Fica no `OnBeforeRouting` |

Nomes finais, prefixados para não colidir na unit grande: `pDefinirOrigemExecucao`, `pLimparOrigemExecucao`, `fMontarContextoExecucao`.

**Builds:** `FaturamentoServicesAPI` ok, `SuprimentoServicesAPI` ok (regressão). `GatilhosInformacao` falha em `untGeraFR3.pas` por `untGeraArquivoSaida` ausente do `.dpr` — quebra **pré-existente**, sem relação com esta alteração, e esse projeto não está no conjunto que a CI compila.

**Não validado:** todos os passos de execução — subir serviço, provocar erro, ler `LOGERR`. Inclusive o valor real de `Modulo`, que é a incógnita da seção 9 da spec, e a checagem de query extra pelo `general_log`.
