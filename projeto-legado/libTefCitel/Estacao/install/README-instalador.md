# Instalador da estação — Req. 456190, Fase 7

Como gerar o `TefCitelEstacaoSetup.exe`, de onde vêm os binários e o que conferir antes de
publicar. O contrato está em `IA\specs\456190\specs.md` §13 e o plano técnico em
`IA\specs\456190\plans.md` §12.

## O que é, em uma frase

Um instalador atendido que deixa **o básico funcionando** na estação — serviço no SCM, plug-ins
de canal registrados, pasta excluída no Defender — para que o **primeiro login do AUTCOM** traga
o resto pelo mecanismo da Fase 6. Se você está procurando onde as DLLs do Scope e os `.ini` são
instalados, a resposta é: **não são, e isso é de propósito.**

## Ferramenta

**Inno Setup 6.3 ou superior** (testado com o compilador 6.4.2). Abaixo de 6.3 o
`ArchitecturesInstallIn64BitMode=x64compatible` não existe.

Linha de comando — **use o `build-setup.cmd`, não o `ISCC.exe` direto**:

```
build-setup.cmd              compila e assina
build-setup.cmd /semassinar  compila sem assinar (bancada)
```

Chamar o `ISCC.exe` na mão gera um instalador **sem assinatura** sem avisar, porque o parâmetro
que registra o assinador (`/Scitel=...`) fica de fora. Ver a seção *Assinatura digital*.

O `setup.exe` sai **nesta mesma pasta** (`OutputDir=.`), ao lado do `.iss` — que é onde o SVN já
versiona o script e onde quem for publicar vai procurar. Para um ensaio sem sujar a pasta,
`/O<pasta>` na linha de comando sobrepõe.

O `TefCitelEstacaoSetup.exe` **não é versionado** — está no `svn:ignore` desta pasta. É saída de
build: quem precisar do instalador recompila, e o repositório não carrega 3,5 MB novos a cada
publicação. O que vai para o SVN é o `.iss` e este README.

## De onde vêm os binários

Todos os caminhos em `[Files]` são **relativos a esta pasta** e apontam para a saída da IDE.
A configuração é o `#define Cfg` no topo do `.iss`, hoje `"Release"`. **Nunca copie binário para
dentro do pacote à mão** — o que a IDE gerou é o que vai.

| Arquivo | Origem | Obrigatório |
|---|---|---|
| `TefEstacaoService.exe` | `Estacao\Win32\<Cfg>\` | sim |
| `TefEstacaoAtualizador.exe` | `Estacao\Atualizador\Win32\<Cfg>\` | sim |
| `borlndmm.dll` | `padra_atualizado\` (raiz do repositório) | **sim** |
| `TefCitelDvcPlugin.dll` | `Estacao\ClientPlugin\Win32\<Cfg>\` **e** `Win64\<Cfg>\` | sim, as duas |
| `TefCitelDvcUpdate.dll` | `Estacao\UpdatePlugin\Win32\<Cfg>\` **e** `Win64\<Cfg>\` | não |
| `libTefCitel.dll` | `padra_atualizado\` (raiz do repositório) | **sim, como semente** |

**O `libTefCitel.dll` vai como semente de bootstrap**, com `onlyifdoesntexist`: a versão definitiva é a que a Fase 6 entrega na primeira carga. Sem ela, uma estação vazia não consegue nem pedir a atualização — ver `specs.md` §13.10.

**O `borlndmm.dll` não é acessório.** O `TefEstacaoService.dpr` tem `ShareMem` como primeira unit,
e sem essa DLL ao lado **o serviço não sobe**. É uma só e é Win32: o atualizador declara no
próprio `.dpr` que não usa `ShareMem`, e os dois plug-ins, inclusive o Win64, também não. É o
único arquivo do pacote que vem de fora da árvore da estação — a mesma cópia que o autcom usa.

**As duas bitness dos plug-ins viajam dentro do `setup.exe`**; só a que casar com o cliente RDP
da máquina é gravada em disco. O setup cresce alguns MB e a pasta instalada fica sem ambiguidade,
que é o que importa quando o suporte for olhar.

> O `skipifsourcedoesntexist` do `TefCitelDvcUpdate.dll` reflete a opcionalidade da RF47: build
> ausente gera instalador sem o canal de volume — a estação atualiza pelo caminho lento (RF45) —,
> em vez de abortar a compilação.

## Antes de publicar

1. **Compilar sem avisos**, exceto um: `Minimum version is set to 6.1 but using 6.1sp1 ... is
   recommended`. Esse é deliberado — o piso do canal DVC é o Windows 7, inclusive RTM, não o
   Service Pack 1.
2. **Conferir as sete linhas `Compressing:`** na saída da compilação — em especial as duas
   bitness do `TefCitelDvcPlugin.dll`, as duas do `TefCitelDvcUpdate.dll` e o `borlndmm.dll`. Elas
   provam que os caminhos relativos acharam a saída `Release` da IDE, e não uma pasta velha.
3. **Conferir o `#define AppVersao`** — ver a seção seguinte.
4. Rodar a bateria do `tasks.md`, Fase 7, Passo 10. O item **V.4** (usuário N) não é opcional:
   conferir que a tarefa de logon foi criada não prova nada.

## Assinatura digital

Os `.exe` e as `.dll` são assinados **antes** de entrarem no `setup.exe`, e o `setup.exe` e o
desinstalador são assinados depois. Quem faz isso é o próprio compilador do Inno: cada arquivo
leva a flag `signonce` e o `[Setup]` declara `SignTool=citel`, que o `build-setup.cmd` registra
apontando para o `assinar-arquivo.cmd`.

**Como usar:**

```
set CITEL_ASSINA_SENHA=<senha do mycert.pfx>
build-setup.cmd
```

Para bancada, sem assinar — **nunca para publicar**:

```
build-setup.cmd /semassinar
```

**A senha nunca entra no repositório.** É por isso que ela é variável de ambiente e não parâmetro
de arquivo versionado. Para não redigitar a cada sessão, `setx CITEL_ASSINA_SENHA "<senha>"` e
abra um CMD novo.

| Variável | Para quê | Default |
|---|---|---|
| `CITEL_ASSINA_SENHA` | senha do `.pfx` — **obrigatória** | — |
| `CITEL_ASSINA_PFX` | caminho do `.pfx` | `%USERPROFILE%\Desktop\Assinador\Certificado\mycert.pfx` |
| `CITEL_ASSINA_TSA` | servidor de carimbo de tempo | `http://timestamp.digicert.com` |
| `CITEL_ASSINA_SIGNTOOL` | caminho do `signtool.exe` | o mais novo do Windows 10/11 SDK |

> O default do `.pfx` aponta para a área de trabalho porque é onde ele está hoje. Certificado de
> assinatura em Desktop é frágil — vale mover para um lugar estável e apontar `CITEL_ASSINA_PFX`
> para lá.

### "Editor desconhecido" no UAC é esperado

O certificado em uso (`mycert.pfx`) é **autoassinado** — `Issued to` e `Issued by` são os
dois "Citel Software". A assinatura é válida e carimbada, e serve para **integridade**: arquivo
adulterado deixa de validar. Mas o Windows não tem como confiar numa raiz que não conhece, então:

- o diálogo de elevação mostra **"Editor desconhecido"** — **isso é esperado, não é defeito**;
- `signtool verify /pa` termina em *"root certificate which is not trusted"* — idem;
- **não há ganho de reputação para antivírus nem SmartScreen.** Um binário autoassinado é, para o
  AV, equivalente a um sem assinatura.

Decisão do Rafael em 2026-09-21 (opção 3 da `specs.md` §13.14). No dia em que houver um
certificado de CA pública, basta apontar `CITEL_ASSINA_PFX` para o novo `.pfx` — nada mais
muda.

### O que NÃO é usado, e por quê

O `signtool.exe` que vem dentro da pasta `Assinador\Certificado` é a versão **5.2.3790.1830**, do
SDK do **Windows Server 2003**. Dois problemas, os dois definitivos:

1. **Ele exige o CAPICOM registrado como COM.** O `capicom.dll` está na pasta, mas nesta máquina
   está registrado só na visão de **64 bits** — e o signtool é de 32 bits, então não o enxerga e
   para com `SignTool Error: Signtool requires CAPICOM version 2.1.0.1 or higher`. O CAPICOM foi
   aposentado pela Microsoft; registrá-lo numa máquina de build não é caminho.
2. **Ele só produz assinatura SHA-1**, que o Windows moderno não aceita para arquivo assinado
   hoje. Não tem `/fd`, não tem `/tr`.

O `signtool` do Windows 10 SDK faz **SHA-256 com carimbo de tempo RFC3161** e não depende de COM
nenhum. É o que o `assinar-arquivo.cmd` procura e usa.

### O `borlndmm.dll` não é assinado por nós

Ele **já vem assinado pela Embarcadero**, e é compartilhado com o autcom. Reassinar substituiria a
assinatura do fabricante pela nossa num arquivo que não é nosso. Por isso ele é o único do pacote
sem a flag de assinatura. (A flag `signonce` também o pularia sozinha, por ele já estar assinado —
a ausência da flag é redundância proposital.)

### Efeito colateral que vale conhecer

**A assinatura reescreve o arquivo de origem em disco.** Depois de um `build-setup.cmd`, os
binários em `...\Release\` ficam assinados — não são cópias temporárias. Isso é inofensivo aqui
porque essas pastas **não são versionadas** e a IDE as regenera, mas explica por que o hash deles
muda sem ninguém ter recompilado. Num rebuild pela IDE a assinatura se perde e o próximo
`build-setup.cmd` a repõe.

### Endurecimento possível, não feito

A senha vai para o `signtool` pela linha de comando (`/p`), que é visível a outros processos da
máquina enquanto o comando roda. A alternativa é importar o `.pfx` no repositório de certificados
do usuário uma única vez e assinar por `/sha1 <thumbprint>`, sem senha em lugar nenhum. Dá menos
flexibilidade de build e exige um passo manual por máquina; ficou registrado como opção.

## Primeira instalação numa estação

**Leve dois arquivos:** o `TefCitelEstacaoSetup.exe` e o `conferir-instalacao.ps1`.

O `conferir-instalacao.ps1` só lê — não muda nada. Rode-o **como Administrador** depois de o
instalador terminar; ele imprime na tela e grava um `conferencia.txt` na pasta da estação.

```
.\conferir-instalacao.ps1
```

Ele responde os critérios 1, 4, 5, 7, 8 e 10 da §13.4 da spec: serviço rodando com start
automático e recuperação, qual bitness foi instalada (lida do cabeçalho PE, não do nome),
**quais usuários do Windows já têm o plug-in registrado**, se a exclusão do Defender entrou, e as
linhas `[TEF]` do `instalacao.log`.

**O que ele não responde, porque não dá para inferir de fora:** os critérios 2 e 3 — o canal abrir
e os arquivos do TEF chegarem na primeira carga. Isso se vê subindo o AUTCOM e olhando os logs da
estação.

### A ordem que faz a viagem render

1. Instalar. Anotar o que a tela final diz — em especial **para qual usuário** o plug-in foi
   registrado.
2. Rodar o `conferir-instalacao.ps1`. Guardar o `conferencia.txt`.
3. **Reconectar a sessão RDP** (não é preciso logoff nem reiniciar) e subir o AUTCOM com
   `CFG_TEFDVC = 'S'`. Confere os critérios 2 e 3 de uma vez: o canal abre, e na mesma carga as
   DLLs do Scope/CliSiTef e os três `.ini` chegam sozinhos e o serviço reinicia uma vez.
4. Passar um cartão.
5. **Critério 4, o obrigatório:** fazer **logon como um segundo usuário**, rodar o
   `conferir-instalacao.ps1` de novo e conferir que o plug-in agora aparece **também para ele** —
   foi a tarefa de logon que registrou. Abrir o RDP pelo atalho e passar um cartão nessa conta.
   Só os hives carregados aparecem no relatório, então **rodar o script de novo depois do logon é
   a única forma de provar isso**. Conferir que a tarefa foi criada não prova nada.
6. Repetir a instalação **com o serviço rodando** (critério 6) e conferir que não dá erro de
   arquivo em uso.
7. Desinstalar (critério 9) e conferir que `TefEstacaoVersao.ini`, os `.log`, `_Preparo` e
   `_Falhou` **continuam na pasta**.

### Não teste num servidor de terminal compartilhado

A tarefa de logon é "ao logon de **qualquer** usuário": num TS com várias pessoas, ela gravaria a
chave do plug-in no perfil de todas elas no próximo logon de cada uma. Além disso, num servidor a
sessão de console costuma estar **sem usuário** — e aí o instalador cai no caminho degradado
(registra o aviso, não registra o plug-in) e o teste não exercita a RF52. Estação de verdade, ou
VM descartável com um único usuário no console.

## Ao rebuildar o serviço, lembre do TefEstacaoService.zip

O TefEstacaoService.exe chega à estação por **dois caminhos**, e eles são independentes:

| Caminho | Origem | Quando |
|---|---|---|
| O instalador | Estacao\Win32\Release\TefEstacaoService.exe | na instalação |
| A Fase 6 | padra_atualizado\TefEstacaoService.zip | **na primeira carga do AUTCOM** |

A Fase 6 é a dona do estado permanente, então **o que estiver no .zip vence**. Rebuildar o
serviço e gerar o instalador **sem atualizar o .zip** faz a estação ser instalada com a versão
nova e **rebaixada para a antiga no primeiro login** — sem erro nenhum, porque do ponto de vista
da Fase 6 é só a estação ficando igual ao servidor.

Regra prática: **rebuild do serviço → atualizar o TefEstacaoService.zip → uild-setup.cmd.**

## Versão do instalador

`#define AppVersao` no topo do `.iss` é o que aparece no **Adicionar/Remover Programas**. A
proposta em aberto é usar a mesma revisão do SVN que o `rev.inc` já carrega, como o serviço e o
atualizador fazem. **Ainda não está automatizado** — hoje o número é fixo e precisa ser mexido à
mão a cada publicação.

## Onde isto é compilado

O `setup.exe` é gerado nesta pasta. Fica em aberto apenas se a **chamada** do `ISCC.exe` entra em
algum `.groupproj` ou segue manual, como o build da IDE. Enquanto não houver decisão, é manual.

## Os `.ps1` desta pasta continuam existindo

`install-service.ps1`, `register-plugin.ps1`, `uninstall-service.ps1` e `unregister-plugin.ps1`
**não** são chamados pelo instalador e **não** foram removidos. Eles são a ferramenta de bancada
de quem desenvolve: dá para instalar o serviço e registrar o plug-in direto da árvore de build,
sem gerar setup. Quem mexer no instalador provavelmente vai continuar usando os dois caminhos.

O que o instalador faz **diferente** deles, e por quê:

| Tema | Os `.ps1` | O instalador |
|---|---|---|
| Registro do plug-in | `regsvr32` na DLL | grava o valor de registro direto — o `DllRegisterServer` não faz nada além disso |
| Raiz do registro | `HKCU` do usuário que roda | `HKEY_USERS\<SID>` do usuário da **sessão interativa** — o setup roda elevado, e o `HKCU` dele pode ser o do administrador que elevou |
| Bitness | parâmetro `-Platform`, default `Win64` | detectada (TSPlus → Win32), mostrada na tela e alterável |
| Outros usuários da máquina | nada | tarefa agendada de logon |

## Duas coisas que o instalador deliberadamente não faz

- **Não mexe no firewall.** Os dois listeners da estação fazem `bind` em `127.0.0.1`.
- **Não usa HKLM para o plug-in.** A documentação da Microsoft sobre registro de plug-in DVC lista
  uma única raiz, e é `HKEY_CURRENT_USER`. A hipótese de HKLM já foi levantada, investigada e
  descartada — ver `plans.md` §12.2 antes de propô-la de novo.
