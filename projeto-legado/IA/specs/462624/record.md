# Req. 462624 — retrospectiva

Registro da sessão de 17 e 18/09/2026. O `spec.md` diz o que foi entregue e por quê; este arquivo
guarda a jornada — o que se tentou e não deu, o que custou tempo, e as decisões que não aparecem no
texto curto.

---

## O diagnóstico veio do banco, não do código

O bug chegou marcado como "a confirmar". A confirmação saiu de duas consultas, e vale registrar o
caminho porque ele se repetiu depois:

1. `SSATSK` filtrando `SST_RESULT LIKE '%pendente na fila%'` — deu as exportações que falharam.
2. `LOGERR` na janela de horário — deu o motivo que aquelas exportações não contaram.

Na base do Wagner (`PRG_REPOR`) o motivo era `libGatIme nao carregada`; na base da suíte, a trava
`VS_PermitidoEnviarEmail`. Dois textos diferentes, a mesma frase genérica chegando ao usuário.

**A `GATIME_WPPEMA` do Wagner tinha zero linhas.** Foi o que transformou o requisito de "mensagem
vaga" em "mensagem falsa": ela prometia pendência numa fila onde nada tinha sido enfileirado.

---

## O que a investigação descobriu e a spec original não previa

- A guarda de travessia do download (`fFornecedorPertenceAoProcessamento`) lê `fornecedores` do
  `SST_PARAMS` com `LItem.Value`. Com array de objeto isso devolve vazio e **todo download passaria
  a 404**. Virou a RN06.
- `untGatilhosInformacao.pas` tem dois chamadores das assinaturas que mudaram. Sem eles a Fase 1
  não compila. Virou a tarefa 5 do plano.
- A exceção do 503 exige **três** edições, não uma: a classe em `untTypesSistema`, o apelido em
  `Cotacao.Types` e o elo na cadeia de `Services.Core.Worker`. As duas irmãs já eram assim, e eu
  tinha escrito no plano que a classe nascia em `Cotacao.Types` — errado.
- A procedure de assert lia `$.enviarEmail` da raiz do `SST_PARAMS`, campo que deixou de existir.
  Sem mexer nela, cinco casos reprovariam por motivo errado. A chave virou `ENVIOS_PEDIDOS`.

---

## O caso 58 nasceu de uma rodada real

Na primeira execução com o binário novo e a tabela ainda com os corpos antigos, os onze casos de
exportação voltaram **500**, não 400: o DMVC levanta `EAssertionFailed` dentro do `BodyAs<T>`, antes
de qualquer validação do controller, e a mensagem levava o caminho do fonte no servidor.

Tecnicamente era recusa. Na prática dizia ao consumidor que o servidor tinha quebrado. Virou o
`try/except` em volta da leitura do corpo e o caso 0058.

---

## O caso 58 que não existe: opções por fornecedor

O critério 3 ia ter caso automatizado comparando `quantidadeItens` entre dois fornecedores com
`todosOsItens` diferente. **Medido em 18/09/2026: não dá.** Nas cotações da empresa 022 todos os
fornecedores têm todos os itens, então ligar ou desligar a opção produz a mesma contagem, e o caso
seria verde guardando o vazio.

Foi para o `ROTEIRO_MANUAL.md` com a medição registrada. O id 58 foi reaproveitado pelo caso do
contrato antigo.

---

## A caça ao `not` — e o custo de teorizar

Esta é a parte que mais consumiu tempo, e a lição não é sobre o defeito.

**O sintoma:** com a `GAT_KEY_ID` faltando na base, a mensagem entregue era "o e-mail não foi
enviado: O gatilho  nao foi encontrado na fila de envio" — com espaço duplo, id vazio. O motivo real
(`Unknown column 'GAT_KEY_ID'`) estava na `LOGERR` desde a primeira rodada.

**O que eu fiz:** construí três hipóteses, cada uma exigindo uma compilação do usuário para ser
derrubada — `ShareMem` ausente no `.dpr`, marshaling de `out String` entre `.so` e host, e
divergência de ABI. Cheguei a escrever no chat que a fronteira estava corrompida.

**O que resolveu:** cinco `WriteLog` temporários, dois dentro da `.so` e três no host, registrando o
que cada lado via da mesma chamada. Uma execução:

```
[.so]  SAIDA:   Result=0 id="" motivo="#42S22Unknown column 'GAT_KEY_ID' in 'field list'"
[host] RECEBEU: Result=0 id="" motivo="#42S22Unknown column 'GAT_KEY_ID' in 'field list'"
[host] fProcessarGatilho ENVIANDO: id=""
```

Idênticos. A fronteira estava **perfeita** — todas as minhas teorias eram falsas. E a terceira linha
mostrava o defeito: o host recebeu `False` e chamou o processar mesmo assim.

**A causa:** `if LGatIme.fGravarGatilhoObtendoId(...)` sem o `not`. Ao reescrever o bloco abaixo
daquela linha, escrevi o corpo novo pressupondo uma negação que nunca coloquei. Compila, roda, e
inverte o significado: falha vira "segue em frente", sucesso vira "não foi enfileirado".

**Três correções minhas nesse episódio:** a teoria do `ShareMem` (descartada — aquele comentário no
`.dpr` é de DLL Windows, e o `out` já existia antes e funcionava); a suspeita de que o worker morria
por causa da entrega (a AV existe desde 14/09 e acontece **depois** do resultado gravado); e o uso
de `pGravarErro` para rastrear, que é tabela de **erro** e não log — o log é o `WriteLog`.

O usuário segurou nos três pontos. Registrado porque a próxima sessão vai ter a mesma tentação:
**quando o log já tem a resposta, parar de deduzir e ir medir.**

---

## A RN07 estava errada, e o teste provou

A primeira redação deduzia a pendência do `TResultEnvio`: só `tpTentarNovamente` ficaria pendente,
porque `pMarcaEnvioEmail` carimba `GAT_D_EEMA` mesmo no erro.

O rastro do caminho feliz, depois do `ALTER`, mostrou `tpEnviadoErro` com `GAT_OBSEMA` **nula** — a
exceção da trava `VS_PermitidoEnviarEmail` sobe até o `except` do `TGatIme.fProcessarGatilho` sem
passar pela marcação. A linha continua na fila e o robô a manda depois.

Consequência: a mensagem dizia "corrija e reexporte" para algo que já ia ser enviado — **fornecedor
recebendo duas vezes**. A regra passou a consultar `GAT_D_EEMA` (`fGatilhoAindaPendente`) em vez de
inferir do enum.

Não teria sido pego por leitura de código. Foi pego porque os rastros ficaram ligados na rodada em
que o caminho feliz funcionou pela primeira vez.

---

## Dois achados que não são deste requisito

**DDL faltando: `GAT_KEY_ID` na `GATIME_WPPEMA`.** A `libGatIme` insere essa coluna desde a r495209
(breno.papera, 16/09/2026, Req. 435579) e o `ALTER` nunca rodou na base da suíte. Só apareceu agora
porque a `.so` foi recompilada por esta entrega — até então o servidor rodava uma build anterior à
mudança dele. Aplicado na `2_30_BELAT_TC` em 18/09; **as demais bases seguem sem**.

**AV do worker na finalização.** O processo filho morre depois de `ExecuteTaskById: tarefa N
concluida`, com `EAccessViolation` num endereço igual ao endereço acessado. Existe desde pelo menos
14/09 — o log da tarefa 1943 mostra `Runtime error 217` no mesmo ponto —, e o comentário em
`untDllGatIme.pas` já citava o sintoma no Req. 455094. **Não afeta o resultado**, que é gravado
antes. Há binário com símbolos de debug gerado em 18/09, e existe skill de DWARF neste ambiente para
resolver o endereço quando virar requisito.

---

## Ordem que funcionou, e uma que não

**Não aplicar o `ALTER` antes de a mensagem funcionar** foi decisão do usuário, contra a minha
sugestão inicial. Estava certo: com a coluna criada, o INSERT passa, o caminho de falha some e o
`not` invertido teria ido para produção escondido atrás do caminho feliz. O defeito só foi visível
porque a falha continuou reproduzível.

**A suíte lê o `request` da TABELA, não do arquivo.** Duas rodadas foram gastas antes de perceber
que os `.sql` dos casos não tinham sido aplicados. Sintoma: erro de desserialização em todos os
casos de exportação, e `Table ... has no test with id NN` para os novos.

**Guarda de revisão:** `TestAlreadyRun` compara `test_last_revision` com `SVN_UPDATE_RANGE` e pula o
caso já executado naquela revisão. É o que faz uma rodada reexecutar só os que falharam. Para forçar
um caso, `UPDATE ... SET test_last_revision = NULL WHERE id = NN`.

**Rodar um caso só:** `./SuprimentoServicesTEST --run:<unit>.<classe>.<metodo>.<TEST_CASE>` — o
runner `.sh` não repassa parâmetro, tem que chamar o binário na mão na pasta do deploy.

---

## Estado final

57 de 57 na suíte, com a procedure de assert publicando o bloco `FORNECEDORES` — codigo, os dois
booleanos e a **mensagem** por fornecedor, que é o que permite afirmar a frente B em vez de só
contá-la.

Fora da suíte, no `ROTEIRO_MANUAL.md`: critérios 9 e 10 (exigem renomear a `.so` no servidor), 3
(medição acima) e o caso de credencial SMTP, que segue **não confirmado** — não se mediu se o erro
escapa do `TEnvioEmail` como exceção.
