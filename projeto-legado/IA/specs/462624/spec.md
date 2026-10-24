# Req. 462624 — Contrato por fornecedor na exportação de cotação e motivo real da falha de e-mail

**Sistema:** API Suprimentos (`Suprimento.Services.API`)
**Solicitante:** Wagner Neves — 17/09/2026
**Consumidor único:** ReporMais+ (appPastaCompra)
**Requisito de origem:** Req. 455094, que entregou o `POST /cotacao/exportacao/gerar`

---

## 1. Motivação

O endpoint atual trata `enviarEmail`, `destinatarios` e `opcoes` como decisão única do lote: valem
igual para todos os fornecedores da requisição. Não há como, num mesmo POST, gerar arquivo para
alguns fornecedores e gerar **e enviar** para outros, nem mandar para destinatário diferente do
cadastro, nem variar as opções de planilha por fornecedor. O ReporMais+ passa a ter controle total
de quem recebe o quê, num disparo só.

Junto, corrige-se um defeito confirmado: quando o envio não acontece, o item do fornecedor recebe
um texto genérico de fila que **não diz o motivo e, na maioria dos desfechos, é factualmente
falso** — ver seção 6.

---

## 2. Escopo

Entrega única, um commit, duas frentes:

| Frente | O quê |
|--------|-------|
| A — Contrato | `fornecedores` passa de `string[]` para `object[]`, com `enviarEmail`, `destinatarios` e `opcoes` por item |
| B — Motivo real | O texto da falha de e-mail deixa de ser genérico e passa a carregar o motivo, atravessando a fronteira da libGatIme |

**Quebra de contrato, não é aditivo.** O ReporMais+ acompanha a mudança na mesma versão; não há
período de transição nem suporte ao corpo antigo.

---

## 3. Contrato

### 3.1 Antes

```json
{
  "sequencialCotacao": "string",
  "fornecedores": ["string"],
  "enviarEmail": false,
  "destinatarios": ["string"],
  "opcoes": { "exibirAplicacaoProduto": false, "...": false }
}
```

### 3.2 Depois

```json
{
  "sequencialCotacao": "string",
  "fornecedores": [
    {
      "codigo": "string",
      "enviarEmail": false,
      "destinatarios": ["string"],
      "opcoes": {
        "exibirAplicacaoProduto": false,
        "exibirMensagemLivre": false,
        "todosOsItens": false,
        "exibirMarca": false,
        "exibirSemelhantes": false,
        "exibirCNA": false,
        "exibirReferencia": false,
        "similaresAgrupados": false,
        "exibirCodigosFabrica": false,
        "exibirCodigosFabricaFornecedor": false,
        "exportarSemPreco": false,
        "embalagemCompra": false
      }
    }
  ]
}
```

As doze opções são as mesmas de hoje, com o mesmo significado. O corpo da resposta (202 com
`idProcessamento`) e o GET de andamento **não mudam de forma** — o item do fornecedor no resultado
continua com `codigoFornecedor`, `nomeFornecedor`, `arquivoGerado`, `quantidadeItens`,
`emailEnviado`, `destinatario` e `mensagem`.

### 3.3 Os três estados por fornecedor

Sem campo extra para expressá-los:

| Situação | Efeito |
|----------|--------|
| Fora da lista `fornecedores` | Nada acontece: nem arquivo, nem e-mail |
| Na lista, `enviarEmail: false` | Gera só o arquivo |
| Na lista, `enviarEmail: true` | Gera o arquivo e envia aos `destinatarios` daquele item |

---

## 4. Requisitos funcionais

- **RF01** — `fornecedores` é lista de objeto. Cada item tem `codigo` obrigatório e
  `enviarEmail`, `destinatarios` e `opcoes` próprios.
- **RF02** — `enviarEmail`, `destinatarios` e `opcoes` deixam de existir no nível raiz do corpo.
- **RF03** — As opções de planilha aplicadas a cada fornecedor são as do **seu** item. Dois
  fornecedores no mesmo POST podem receber planilhas com colunas diferentes.
- **RF04** — O envio de e-mail é decidido por item. Um mesmo POST pode gerar arquivo para uns e
  gerar e enviar para outros.
- **RF05** — `destinatarios` deixa de ter fallback para o cadastro do fornecedor. A API usa
  exatamente o que veio no array.
- **RF06** — Quando o envio não acontece, `mensagem` carrega o **motivo real**, e não texto
  genérico de fila.
- **RF07** — Quando o envio foi pedido e a libGatIme não está utilizável no processo, o POST é
  recusado antes de gerar qualquer planilha.

---

## 5. Regras de negócio — frente A (contrato)

- **RN01 — Resolução de contato é de quem monta o request.** O ReporMais+ sempre manda a lista de
  destinatários já resolvida e completa quando `enviarEmail: true`. Cadastro, preferência do
  usuário, endereço digitado na hora — a escolha é dele. A API não consulta `FOR_EMAPED` nem
  qualquer outro cadastro.

  *Consequência de código:* a função `fEmailDoCadastro`
  (`Suprimento.Services.Cotacao.Exportacao.pas`) perde o único chamador e é **removida**. Mantê-la
  deixaria no fonte uma regra que ninguém mais aplica — exatamente o tipo de código que volta a ser
  chamado por engano meses depois.

- **RN02 — `destinatarios` vazio com `enviarEmail: true` é falha daquele fornecedor, não do lote.**
  *Decidido em 17/09/2026.* A planilha é gerada e o item volta com `emailEnviado: false` e o motivo
  em `mensagem`, no mesmo formato do que já acontece hoje com fornecedor sem e-mail válido. O lote
  segue para os demais — é a RN03 do 455094, que existe para que a falha de um não custe os outros.

- **RN03 — Código de fornecedor repetido na lista é 400.** O arquivo gerado é nomeado por
  processamento + fornecedor, então duas entradas do mesmo código sobrescreveriam o arquivo uma da
  outra e o GET de download não teria como devolver as duas. Recusar é mais honesto que produzir um
  resultado em que o segundo item apagou silenciosamente o primeiro.

- **RN04 — `codigo` vazio em qualquer item é 400.** Validação de formato, no controller, sem ida ao
  banco — junto das duas que já existem (`sequencialCotacao` vazio e lista vazia).

- **RN05 — `opcoes` omitido no item vale como todas falsas.** É o comportamento de hoje quando o
  objeto não vem no corpo, e não há motivo para mudá-lo.

- **RN06 — A guarda de travessia do download acompanha a mudança.** O GET de download confere que o
  fornecedor pedido estava na lista **daquele** processamento, lendo o array `fornecedores` do JSON
  gravado em `SST_PARAMS` (`Suprimento.Services.Cotacao.Consulta.pas`,
  `fFornecedorPertenceAoProcessamento`). A leitura atual compara `LItem.Value`, que devolve string
  vazia quando o item é objeto: sem alterar este ponto no mesmo commit, **todo download passa a
  responder 404**, inclusive para exportações bem-sucedidas.

  Este é o único ponto do sistema que lê o corpo do POST depois de gravado, e é uma guarda de
  segurança — ela existe para impedir que um código de fornecedor bem formado componha o caminho do
  arquivo de outro processamento.

---

## 6. Regras de negócio — frente B (motivo real)

### 6.1 O diagnóstico

*Levantado em 17/09/2026, na base `PRG_REPOR` (`64.181.184.234:62002`, MySQL 5.7.44) e na base da
suíte de testes (`2_30_BELAT_TC`, MySQL 8.0.36).*

Três exportações do dia 17/09 na base do Wagner (`SSATSK` 39790, 39795, 39800) terminaram com a
mensagem genérica. A `LOGERR` da mesma base, nos mesmos segundos (11:45:24, 14:17:28, 14:24:59),
registra o motivo:

> `TDllGatime.Create: libGatIme nao carregada - o host precisa chamar pCarregaFuncoesDllGatilhoImediatos antes de usar o wrapper.`

O `.dpr` está correto: `pLoadLibGatIme` roda **antes** do desvio por `ParamStr(1)`
(`SuprimentoServicesAPI.dpr:1020`), portanto vale também no modo `task`, que é onde a exportação
roda. A falha é de ambiente: `libGatIme.so` ausente ao lado do binário, ou anterior ao Req. 455094
e sem o símbolo `fCarregarDll`. Os dois casos deixam `fCarregarDllGatIme` em nil e caem no `Exit`
de `untDllGatIme.pas:306`. *A `.so` do ambiente do Wagner foi atualizada em 17/09/2026.*

**A consequência é o que torna a mensagem nociva:** `GATIME_WPPEMA` daquela base tem **zero**
linhas. Nada foi enfileirado. A mensagem promete que o item "ficou pendente na fila de envio" e o
robô nunca vai mandar, porque não há o que mandar. Não é vagueza — é informação falsa, que leva o
usuário a esperar em vez de agir.

Na base da suíte, o mesmo texto genérico cobriu outro motivo real, também registrado só na
`LOGERR`: `Não é permitido enviar e-mail nesse banco de dados!` — a trava `VS_PermitidoEnviarEmail`
de `untTEnvioEmail.pas:3670`. E em 14/09, `Username and Password not accepted (...) BadCredentials`.
Três motivos distintos, todos acionáveis pelo usuário, todos apresentados com a mesma frase que não
diz nenhum deles.

### 6.2 As regras

- **RN07 — Quem decide se ficou pendente é o carimbo, não o enum.** *Redigida em 17/09/2026 e
  corrigida em 18/09/2026, contra comportamento medido.*

  Em `fExecutarGatilho`, cada canal só roda `if GAT_D_EEMA is null`. Enquanto essa coluna estiver
  nula, a linha volta na próxima varredura do robô; carimbada, ninguém mais a processa.

  A primeira redação desta regra deduzia a pendência do `TResultEnvio`: só `tpTentarNovamente`
  ficaria pendente, porque `pMarcaEnvioEmail` carimba **inclusive no erro**
  (`untProcessaGatilhosImediatos.pas:783`). Está **errado**, e o teste de 18/09/2026 mostrou por
  quê: o carimbo só acontece quando a falha é tratada **dentro** do canal. Exceção que sobe antes
  disso — a da trava `VS_PermitidoEnviarEmail` é o caso observado — chega ao `except` do
  `TGatIme.fProcessarGatilho` sem passar pela marcação, e devolve `tpEnviadoErro` com a linha
  **ainda pendente**.

  Consequência prática, e o motivo de a correção não ser cosmética: dizer "corrija e reexporte"
  para uma linha que o robô ainda vai enviar faz o fornecedor **receber duas vezes**.

  Por isso a mensagem consulta `GAT_D_EEMA` daquele gatilho — `fGatilhoAindaPendente` — em vez de
  inferir do enum. Uma consulta, só no caminho de falha.

  **Isto corrige também a RN24 do Req. 455094**, que fixou o significado oposto: lá se afirmava que
  falha *sempre* deixa a linha pendente. Nem sempre — e a spec do 455094 deve remeter a esta.

- **RN08 — A mensagem promete o futuro só quando ele é verdadeiro.** O texto entregue ao consumidor
  tem duas partes: o motivo real, sempre; e o que vai acontecer a seguir, decidido pela RN07 — "o
  robô tentará de novo" quando a linha continua sem carimbo, e "corrija e reexporte" quando não há
  linha ou ela já foi encerrada.

- **RN09 — O motivo atravessa a fronteira da biblioteca pelo contrato, versão 3.**
  `fGravarGatilhoObtendoId` e `fProcessarGatilho` ganham `out AstrMotivo: String` em
  `GatilhosImediatos.Interfaces.pas`, e `GATIME_CONTRATO_VERSAO` passa de 2 para 3. O portão de
  versão que já existe (`TDllGatime.fVersaoCompativel`) degrada sozinho: `.so` mais velha continua
  respondendo sem motivo, como hoje, em vez de saltar além do fim da vtable.

- **RN10 — As duas fronteiras, não só a do envio.** A falha observada acontece **antes** do
  processamento, no `fGravarGatilhoObtendoId`, que devolve `False` na guarda de
  `Assigned(DllGatIme)`. Tratar apenas `fProcessarGatilho` deixaria justamente o caso confirmado sem
  motivo.

- **RN11 — Onde o texto é preenchido.** De fora para dentro:

  | Camada | O que passa a informar |
  |--------|------------------------|
  | `TDllGatime` (wrapper) | `.so` não carregada; versão de contrato incompatível |
  | `TGatIme.fProcessarGatilho` | `e.Message` do `except` que hoje só grava no log; `GET_LOCK` negado |
  | `fExecutarGatilho` → `fExecutaClienteEmail` → `fEnviarEmail` | Os `Exit` mudos: configuração de e-mail do operador incompleta, arquivo do anexo inexistente, anexo não recuperado |

- **RN12 — `TEnvioEmail` não é alterada.** São ~4.700 linhas compartilhadas pelo autcom inteiro, e o
  que ela levanta já chega pelo `except` do `fProcessarGatilho`. O que ela **engole** fica fora
  desta entrega — ver seção 9.

- **RN13 — Pré-voo recusa o lote quando o envio é impossível.** Havendo ao menos um item com
  `enviarEmail: true`, o pré-voo confere se a libGatIme está utilizável no processo e, não estando,
  recusa com **503** e o motivo, antes de gerar qualquer planilha.

  A conferência é por inspeção pura — `Assigned(fCarregarDllGatIme)`,
  `Assigned(fContratoVersaoGatImeSO)` e a versão do contrato —, sem carregar nada e sem efeito
  colateral. Nasce como `fLibGatImeDisponivel(out AstrMotivo): Boolean` em `untDllGatIme`. O
  `fVersaoCompativel` existente não serve: é método de instância, e criar a instância é justamente o
  que grava o erro no log.

  O pré-voo roda num processo filho que carrega a biblioteca do mesmo jeito que a tarefa, então o
  que ele enxerga é o que valerá no envio.

  **O carregamento também deixa de ser silencioso.** Hoje `pCarregaFuncoesDllGatilhoImediatos` sai
  calado quando não encontra a `.so`, e a primeira notícia do problema é o `pGravarErro` lá dentro
  do `Create`, já durante uma exportação. No ambiente do Wagner isso custou de 8h20 a 14h25 do dia
  17/09, com dois operadores, até alguém reclamar. A função passa a registrar o motivo ao falhar —
  edição única, na própria `untDllGatIme`, que vale para os três hosts Linux que a chamam
  (Suprimento, GatilhosInformacao e GatilhosImediatos). Quem faz o deploy vê no primeiro log, em vez
  de depois da reclamação.

  *Como o pré-voo fica sabendo:* `TCotacaoExportacaoValidarParams` carrega hoje apenas cotação,
  empresa e operador — por decisão do 455094, ele não olha opções nem destinatários, para não
  desserializar doze booleanos que não usaria. Ganha **um** campo booleano, preenchido pelo
  controller a partir do corpo já desserializado: "algum item pediu envio". A regra continua no
  worker; o controller só responde a pergunta que o corpo já contém.

---

## 7. Impacto técnico

| Arquivo | Alteração |
|---------|-----------|
| `Services/Core/suprimento/services/types/Suprimento.Services.Cotacao.Types.pas` | Nasce `TCotacaoExportacaoFornecedorParams`; `TCotacaoExportacaoGerarParams` perde três campos e troca o tipo de `fornecedores` |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Exportacao.pas` | Opções e destinatários passam a vir do item; remoção de `fEmailDoCadastro`; montagem da nova mensagem |
| `Services/Core/suprimento/services/Suprimento.Services.Cotacao.Consulta.pas` | Guarda de travessia do download lê `codigo` do objeto (RN06) |
| `Services/Suprimento.Services.API/Source/api/controller/api.controller.cotacao.pas` | Validações RN03 e RN04; anotações de Swagger |
| `Services/Core/suprimento/services/Suprimento.Services.Workers.pas` | Pré-voo da RN13 |
| `fontes/genericos/GatilhosImediatos.Interfaces.pas` | Contrato v3 (RN09) |
| `fontes/genericos/untDllGatIme.pas` | `out` nos dois métodos; `fLibGatImeDisponivel`; `pCarregaFuncoesDllGatilhoImediatos` deixa de falhar em silêncio |
| `fontes/libGatIme/fontes/GatilhosImediatos.Classes.pas` | `out` nos dois métodos; motivo no `except` |
| `fontes/util/untProcessaGatilhosImediatos.pas` | `out` atravessa `fExecutarGatilho`, `fExecutaClienteEmail` e `fEnviarEmail` |

**Sem DDL.** Nenhuma tabela muda.

**Recompilação obrigatória:** a `libGatIme` (`.so` e `.dll`) e todos os hosts que a carregam. O
portão de versão protege quem ficar para trás, mas o Suprimento precisa da v3 para entregar motivo.

---

## 8. Critérios de aceitação

1. POST com `fornecedores` no formato antigo (`string[]`) é recusado.
2. POST com dois fornecedores, um com `enviarEmail: true` e outro com `false`, gera dois arquivos e
   envia exatamente um e-mail.
3. Dois fornecedores com `opcoes` diferentes produzem planilhas com colunas diferentes, cada uma
   conforme o seu item.
4. `destinatarios` preenchido envia **somente** para aqueles endereços; o e-mail do cadastro do
   fornecedor não é consultado nem acrescentado.
5. `enviarEmail: true` com `destinatarios` vazio: a planilha daquele fornecedor é gerada, o item
   volta com `emailEnviado: false` e motivo em `mensagem`, e os demais fornecedores do lote são
   processados normalmente.
6. Código de fornecedor repetido na lista responde 400.
7. `codigo` vazio em qualquer item responde 400.
8. GET de download continua devolvendo o arquivo de um fornecedor que estava na lista, e continua
   respondendo 404 para um que não estava.
9. Com a libGatIme indisponível e ao menos um item pedindo envio, o POST responde 503 com o motivo,
   e nenhuma planilha é gerada.
10. Com a libGatIme indisponível e **nenhum** item pedindo envio, o POST é aceito e as planilhas são
    geradas normalmente.
11. Falhando o envio de um fornecedor, `mensagem` contém o motivo real e **não** afirma que ficou
    pendente, salvo quando o desfecho for `tpTentarNovamente`.
12. A trava `VS_PermitidoEnviarEmail` acionada produz mensagem que nomeia essa causa.
13. Falha de envio de um fornecedor não impede a geração nem o envio dos demais.
14. Subindo o serviço sem a `libGatIme.so` ao lado do binário, o log registra o motivo — sem depender
    de alguém tentar exportar para descobrir.

---

## 9. Limites conhecidos

- **Erro de SMTP engolido por `TEnvioEmail`.** O `BadCredentials` observado em 14/09 *parece*
  escapar como exceção depois da terceira tentativa do laço de reconexão, e nesse caso chega pelo
  `except` do `fProcessarGatilho` — mas isso **não foi confirmado**. Entra como caso de teste (o
  critério 12 cobre a trava de banco; o de credencial é o caso a construir). Confirmando-se que a
  exceção não escapa, o motivo de SMTP fica fora desta entrega e exigiria mexer em `TEnvioEmail`,
  que a RN12 deliberadamente preserva.

- **O consumidor decide pelo texto.** Optou-se por não acrescentar campo de desfecho ao DTO
  (decisão de 17/09/2026): `mensagem` carrega motivo e situação em linguagem natural, e o ReporMais+
  interpreta a frase para decidir o que exibir. É a mesma dependência de texto que produziu o
  problema atual — registrado aqui como risco assumido, não como omissão.

- **Ambiente do Wagner.** A `.so` foi atualizada em 17/09/2026. Com o contrato v3, ela precisará ser
  atualizada de novo no deploy desta entrega.

---

## 10. Fora de escopo

- Suporte ao corpo antigo, em qualquer forma de convivência.
- Campo de desfecho estruturado no DTO de resposta.
- Exposição do estado da libGatIme na rota `/info`. O pré-voo responde a mesma pergunta no momento
  em que ela importa, com 503 e a causa nomeada; o `/info` só acrescentaria diagnóstico remoto, ao
  custo de ampliar o contrato de uma rota que tem consumidor. Se o suporte pedir depois de rodar um
  tempo, vira requisito próprio, barato.
- Retentativa automática de envio pela API.
- Alteração de `TEnvioEmail`.
