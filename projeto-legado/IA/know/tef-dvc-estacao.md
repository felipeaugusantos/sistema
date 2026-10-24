# TEF na estação (DVC) — como ligar, testar e dar suporte

> Para **testes e suporte**. Req. 456190.

## O que muda, em uma frase

O TEF deixa de rodar dentro do AUTCOM no servidor de terminal e passa a rodar num **serviço
Windows instalado na estação física**, onde o pinpad está ligado. A conversa entre os dois usa um
canal do próprio RDP.

**Por que:** o redirecionamento de porta do TSPlus/RDP perdia a porta a cada oscilação de rede, e
recuperar exigia reiniciar a sessão inteira do operador.

---

## Ligar: quatro passos, nesta ordem

### 1. Os três `.zip` no diretório do `autcom.exe`

No servidor, na mesma pasta do `autcom.exe`:

| Arquivo | O que leva |
|---|---|
| `tef_scope.zip` | DLLs do Scope |
| `tef_clisitef.zip` | DLLs do CliSiTef |
| `TefEstacaoService.zip` | o serviço da estação |

É daqui que a estação se abastece. **Sem eles, nada é enviado.**

### 2. Instalar o serviço na estação

Rodar o **`TefCitelEstacaoSetup.exe`** na estação, como administrador. Instala em `C:\Tef_Citel`
por padrão.

O assistente decide sozinho se o plug-in é de 32 ou 64 bits e **mostra o motivo na tela** — o
técnico pode trocar se souber que está errado.

**Ao terminar: fechar e reabrir a sessão RDP.** Só isso — **não** precisa de logoff do Windows nem
de reiniciar a máquina.

> Se a estação tem mais de um usuário Windows, os demais são configurados **sozinhos** no próximo
> logon de cada um. Não precisa reinstalar por usuário.

### 3. Ligar a configuração

`CFG_TEFDVC` — *"Executar o TEF (pinpad) por um serviço Windows instalado na estação, em vez de
dentro do AUTCOM?"*, no grupo **LIBTEF**. Sim/Não, **vem como Não**.

Com **Não**, tudo funciona exatamente como antes. Essa é a saída se algo der errado: **voltar para
Não e reabrir o AUTCOM.**

### 4. Abrir o AUTCOM e deixar a primeira carga acontecer

No primeiro login de operador com `CFG_TEFDVC = Sim`, a estação recebe as DLLs e os `.ini`,
**reinicia o serviço uma vez** e o TEF sobe. Aparece uma barra de progresso na tela de carga.

Essa primeira carga demora mais que as seguintes. **É esperado, e é uma vez só.**

---

## A regra que mais vai gerar chamado

> ## Configuração **sempre** no servidor. **Nunca** direto na estação.

Os arquivos `scope.ini`, `CliSiTef.ini` e `CONFITLS.ini` da estação são **cópias** — a cada carga
o AUTCOM compara com os do servidor e reescreve quando estiverem diferentes.

**Editar o `.ini` direto em `C:\Tef_Citel` funciona até o próximo login do operador, e depois
some.** Vai parecer "a configuração não pegou" ou "desconfigurou sozinho", e não é: foi
sobrescrita, como projetado.

**Onde editar de verdade:**

| Arquivo | Onde fica o original |
|---|---|
| `scope.ini` | diretório do `autcom.exe` |
| `CliSiTef.ini` e `CONFITLS.ini` | diretório do `autcom.exe`, ou a pasta do terminal se a `CFG_PTTFCT` estiver preenchida |

O sistema **só corrige os caminhos** de cada arquivo ao gravar na estação. Fora isso, o `.ini` que
chega é igual ao do servidor — mesmos comentários, mesmas linhas, **e nenhuma chave inventada**. Se
o Scope precisar de uma chave que não está lá, ela tem de ser acrescentada **no arquivo do
servidor**.

---

## O que acontece sozinho, sem ninguém pedir

- **Versão nova de DLL, do serviço ou de `.ini`:** basta trocar o arquivo no servidor. A estação
  se atualiza na carga seguinte.
- **Estação que perdeu um arquivo** (antivírus levou, alguém apagou): ela percebe e se conserta na
  carga seguinte, sem reinstalar.
- **Usuário Windows novo na estação:** configurado no primeiro logon dele.
- **Queda de rede no meio da venda:** a sessão é retomada quando a conexão volta, sem novo login
  do TEF. Leva de 45 a 55 segundos — nesse intervalo o TEF fica indisponível, mas **a transação
  seguinte funciona normalmente**.

**Uma estação com o instalador de seis meses atrás fica em dia sozinha no primeiro login.** O
instalador é pequeno de propósito: tudo que muda com frequência viaja pelo canal.

---

## Quando der problema, onde olhar

| Arquivo | Onde | Serve para |
|---|---|---|
| `TefCitelDvcTransporte_<ESTAÇÃO>.log` | `<pasta do autcom.exe>\TefLog\` | a conversa do lado servidor. **O sufixo é o nome da estação** — com várias, um arquivo cada |
| `TefEstacaoService.log` | `C:\Tef_Citel` | o serviço da estação: o que recebeu, o que aplicou |
| `TefCitelDvcPlugin.log` | `C:\Tef_Citel` | o canal, dentro do cliente RDP |
| `instalacao.log` | `C:\Tef_Citel` | o que o instalador fez, e por que parou se parou |

**"Ver libTefCitelErro.log"**, na tela de erro do TEF, agora traz o arquivo **da estação** — não
mais o do servidor. É o motivo real de quem carregou a DLL.

### Duas mensagens e o que significam

- **"Aguarde, comunicando com o servidor TEF…"** — a atualização terminou e agora é a conexão com
  o TEF que está demorando. **O problema não é a estação**: olhar VPN, `ScopeSrv`, IP no
  `scope.ini`.
- **"Não foi possível falar com o serviço de TEF da estação"** — o serviço não respondeu.
  Conferir se o `TefEstacaoService` está em execução na estação e se a sessão RDP foi reaberta
  depois da instalação.

---

## O que **não** mudou

- Com `CFG_TEFDVC = Não`, nada muda — mesmo comportamento de sempre.
- A operação de caixa é a mesma: passar cartão, cancelar, reimprimir, PIX.
- Cadastros, relatórios e o resto do AUTCOM não são afetados.
- O instalador **não mexe no firewall** — os dois canais da estação só falam com a própria máquina.

---

## Para quem for testar

Vale exercitar, além da venda simples:

- **cancelamento de transação** e **reimpressão**;
- **oscilação de rede** no meio da venda — derrubar e devolver a conexão;
- **dois AUTCOM na mesma estação**, com um pinpad só;
- **um usuário Windows diferente** do que instalou, passando cartão;
- **`CFG_TEFDVC = Não`** depois de tudo, confirmando que volta ao comportamento antigo.
