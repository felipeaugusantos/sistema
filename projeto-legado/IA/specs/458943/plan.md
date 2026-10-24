# Plano de Execução — Req. 458943

**Referência:** `spec.md`, `fase1-inventario.md`
**Zona:** Híbrida — Legado em `fontes/financeiro/contasareceber/`, Moderna em `Services/`
**Modelo:** Req. 454631 (`Financeiro.ContasReceber.BaixaDuplicatas`, r491104)

---

## 1. Abordagem técnica

Padrão A — **classe compartilhada + record de parâmetros**.

```
Financeiro.ContasReceber.EstornoDuplicatas.pas      TEstornoDuplicatas
   TEstornoParams  ─── record de records (entrada)
   TResultadoEstorno ─ record (saída, com TErrosEstorno)
   class function fEstornarDuplicatas(AParams, pgbProgresso): TResultadoEstorno
        |
        +── untEstornoReceber.pas                    monta o record a partir da tela
        +── Financeiro.Services.Cobranca.Estorno.pas monta o record a partir do DTO
                                                      + aplica os portões da RN02
```

### Onde vivem os portões de escopo — decisão estruturante

Os portões da RN02 (só cartão e PIX puros) ficam **na camada de serviço, nunca na classe**.

A razão é dupla:

1. **A tela não pode perder cobertura.** `frmEstornoReceber` continua estornando dinheiro, cheque, adiantamento, vale-presente, contas a pagar e modo caixa. Se os portões estivessem na classe, a extração quebraria a tela.
2. **Delphi compila a unit inteira.** Se `fEstornaCheque` vier para a classe compartilhada, `untTCadChqRepository` e `untCadChq` passam a precisar compilar para Linux, mesmo sem nunca executar lá.

Solução — a mesma que a `BaixaDuplicatas` já emprega com suas 13 diretivas: **os caminhos que só a tela usa ficam dentro de `{$IFNDEF LINUX}` dentro da classe compartilhada.**

```pascal
{$IFNDEF LINUX}
  // cheques, adiantamento, vale-presente, contas a pagar, modo caixa
{$ENDIF}
```

No Linux esse código não existe; no Windows a tela o encontra intacto. Os portões da RN02 no serviço garantem que essas rotas nunca sejam pedidas pelo endpoint.

| Bloco | Linux | Windows |
|-------|-------|---------|
| Cartão — `fEstornaMovCar`, `fHouveTransferenciaCartao`, `fCarregaCartoesTransferidos`, conciliação | ✔ | ✔ |
| PIX — todo o `DevolucaoPix` | ✔ | ✔ |
| MOVBAN, juros/desconto separados, comissão `CTR_CTPCOM`, conjugadas | ✔ | ✔ |
| Cheques — `fEstornaCheque`, `pLogChq`, `fHouveTransferenciaCheque` | `{$IFNDEF}` | ✔ |
| Adiantamento — `pEstornaAdiantamentoCliente`, `fValidaEstornoAdiantamento`, `fGetMenu` | `{$IFNDEF}` | ✔ |
| Contas a pagar, vale-presente, desconto no banco | `{$IFNDEF}` | ✔ |
| Modo caixa — `fSaldoCaixaSuficiente`, `TResumoDeCaixa` | `{$IFNDEF}` | ✔ |

> `CTR_AUTCTP` é nulo em 100% das baixas do escopo (`fase1-inventario.md`), o que confirma que `pEstornaContasAPagar` nunca dispara no endpoint.

### Divisão em quatro units

| Unit | Conteúdo |
|------|----------|
| `EstornoDuplicatas.pas` | `TEstornoDuplicatas` — o motor: `pConfirmaEstornoInterno`, `pEstornaDuplicataSimples`, `pEstornaDuplicataParcial`, `fEstornaMovCar`, `pApagaChequeCartao`, `fEstornaDuplicataConjugadas`, `fEstornaMovbanJurosDescto`, mais os blocos `{$IFNDEF LINUX}` |
| `ValidacaoEstorno.pas` | `TValidacaoEstorno` — `fDupJaEstornada`, `fVerConfirmada`, `fVerSeqBai`, `fBloquearEstornoPedidoJaFaturado`, `ValidarDuplicatasComBaixaParcial`, `fCreditoUtilizado`, `fDocsBaixaComLCK`, `ValidaTransferenciasLiberadas`, `fVerificaDocumentosBaixados`, `fVerificaDatasDiferentes`, `DocumentoPossuiDevolucoes`, **e os portões da RN02** como funções puras reutilizáveis pelo serviço |
| `FiltroEstorno.pas` | Carga do lote — SQL de `pCriaTemporaria` (`:1543`). O UNION com `ADTCLI` fica sob `{$IFNDEF LINUX}`. Reaproveita `TChaveDuplicata` de `FiltroDuplicatas.pas` |
| `EstornoTypes.pas` | Vocabulario compartilhado: `TErroEstorno` / `TErrosEstorno`, `TResultadoEstorno`. Unit propria para o servico consumir sem arrastar o motor (UniDAC, locks, auditoria) |
| `DevolucaoPix.pas` | `ValidacoesDeRecebimentoPorPix`, `SolicitarDevolucaoDoPix`, `ValorPixJaDevolvidoNoBanco`, `GeracaoCreditoRecebimentoPix`, `GerarCreditoRecebimentoPix`, `ApagaRegistroPix`, `fRetornaValRecPix` |

### Os records

```pascal
TEstornoParams = record
  Datasets      : TEstornoDatasets;      // cdsDados, FRegistroMovPix, clones
  Chave         : TChaveEstorno;         // numdup, parcel, espdoc, codemp, codcli, seqbai
  Cabecalho     : TEstornoCabecalho;     // strPorBai, strMotEst, LHistComplementar, strNomOrigem
  Opcoes        : TEstornoOpcoes;        // blnResCai, blnEstornoAutomatico, blnEstornoDocLocEqu
  Pix           : TEstornoPix;           // TipoEstornoPix; portador/evento do credito
                                         // vem de CFG_PCTRPX / CFG_ECTRPX (RN07)
  Colaboradores : TEstornoColaboradores; // objLock, objLiberacao, FAuditoriaCadRec
end;

TResultadoEstorno = record
  Sucesso                   : Boolean;
  SequencialControle        : Integer;
  EmpresaBaixa              : String;
  Estornadas                : TChavesDuplicatas;
  SugerirRebaixaConjugadas  : Boolean;   // a tela pergunta; o serviço ignora
  Erros                     : TErrosEstorno;
end;
```

`TErroEstorno` copia a forma de `TErroBaixa` (`BaixaDuplicatas.pas:72`): `Escopo`, `Regra`, `Mensagem`, `Chave`.

### O que substitui a UI

| Ponto na tela | Na classe |
|---|---|
| `fPedePortador` (`TfrmDigPortador`) | **Some.** RN04 — `strPorBai` vem de `CTR_PORBAI`; vazio vira erro |
| `fInformarOcorrencia` (`TfrmDigOcorrencia`) | **Some.** RN08 |
| `TfrmCtrSelecionaTipoEstornoPix` | `AParams.Pix.TipoEstornoPix` |
| `TfrmBaixaAnalitica` (portador/evento do crédito) | `CFG_PCTRPX` / `CFG_ECTRPX`; vazias -> erro (RN07). A tela segue abrindo a modal |
| `fGetMenu` (escolher adiantamento) | Dentro de `{$IFNDEF LINUX}` — só a tela |
| `fMensagem` de confirmação (`:1187`) | Fica no form, antes de montar o record |
| Aviso de duplicata descontada (`:1196`) | Dentro de `{$IFNDEF LINUX}` |
| "Deseja baixar novamente?" (`:6159`) | Fica no form, via `SugerirRebaixaConjugadas` |
| `pEmitirMensagem` (44 usos) | `pAddErro(Escopo, Regra, Mensagem, Chave)` |
| `pSetFocus` (29 usos) | Fica no form |
| `TfrmGravando` | Fica no form; a classe recebe `pgbProgresso: TcxProgressBar` |

---

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `Financeiro.ContasReceber.EstornoDuplicatas` | `fontes/financeiro/contasareceber/` | criar |
| `Financeiro.ContasReceber.ValidacaoEstorno` | `fontes/financeiro/contasareceber/` | criar |
| `Financeiro.ContasReceber.FiltroEstorno` | `fontes/financeiro/contasareceber/` | criar |
| `Financeiro.ContasReceber.DevolucaoPix` | `fontes/financeiro/contasareceber/` | criar |
| `Financeiro.ContasReceber.EstornoTypes` | `fontes/financeiro/contasareceber/` | criar |
| `untEstornoReceber` | `fontes/financeiro/contasareceber/` | alterar |
| `Financeiro.ContasReceber.FiltroDuplicatas` | `fontes/financeiro/contasareceber/` | alterar — expor `TChaveDuplicata` |
| `Financeiro.Services.Cobranca.Estorno.Types` | `Services/Core/financeiro/services/types/` | criar |
| `Financeiro.Services.Cobranca.Estorno` | `Services/Core/financeiro/services/` | criar |
| `Financeiro.Services.Workers` | `Services/Core/financeiro/services/` | alterar |
| `api.controller.cobranca.estorno` | `Services/Financeiro.Services.API/Source/api/controller/` | criar |
| `api.controller.cobranca.estorno.test` | idem | criar |
| `autcom.dpr` | `padra_atualizado/` | alterar — UTF-8 com BOM |
| `FinanceiroServicesAPI.dpr` / `FinanceiroServicesTEST.dpr` | `Services/Financeiro.Services.API/Target/Linux/` | alterar |
| `Test_Cases/estorno/*.inc` | idem | criar — casos pelo analista |
| `untFuncoes`, `untFuncoesSimples`, `untFuncoesGenerica` | `fontes/genericos/` | alterar — 9 funções (§4) |
| `untCfgRepositorio` | `fontes/configuracoes/` | alterar — criar `CFG_PCTRPX` e `CFG_ECTRPX` (RN07) |

---

## 3. Contrato REST

```
POST /contasareceber/cobranca/estorno
Headers: Authorization: Bearer <jwt>, Empresa, OperadorLogado
```

| Campo | Tipo | Obrigatório |
|-------|------|-------------|
| `numeroDuplicata` | string | sim |
| `parcela` | string | sim |
| `especieDocumento` | string | sim |
| `codigoEmpresa` | string | sim |
| `codigoCliente` | string | sim |
| `sequencialBaixa` | integer | sim |

**Response:** `sucesso`, `sequencialControle`, `empresaBaixa`, `duplicatasEstornadas[]`, `mensagem`

**Status:** `200` · `400` payload inválido · `401` sem JWT · `422` regra recusou

---

## 4. Funções genéricas Windows-only — resolvido sem tocar nas genéricas

> Atualizado em 02/09/2026, ao fim da Fase 2. A estimativa original desta seção
> (9 funções a portar, ~414 linhas em `untFuncoesGenerica`/`untFuncoesSimples`/
> `untFuncoes`, pelo precedente do Req. 454631) **não se confirmou**: nenhuma
> linha dessas três units foi alterada.

Varredura por identificador, marcando em que ramo de `{$IFDEF}` cada chamada cai:

| Função | Resolução |
|---|---|
| `EstaConciliado`, `fVerificaSeDuplicataEstaVinculadaParaConciliacao`, `fDuplicataPrincipalBaixada`, `fEhDuplicataOriginadaDeConverte`, `fTemDuplicataPosteriorBaixada` | Em `ValidacaoEstorno`, só o ramo `CADREC` — o único que o estorno usa |
| `fCriaQueryCadPagCTPCom` | Absorvida por `fComissaoDeVendedores`, que parametriza o `IN` |
| `fCarregaCartoesTransferidos` | Consulta curta; entrou em `fHouveTransferenciaCartao` |
| `fDocumentoFaturado` | Era método do form (`untEstornoReceber.pas:7657`), não a homônima de `untFuncoesSimples`. Foi para `ValidacaoEstorno` |
| `fRetNomPortador` | `fCampoTabela` tem forma diferente no Linux (`IMyCampoTabela`, não `String`). Virou `fNomeDoPortador`, com SELECT próprio |
| `pGeraLogLiberacao` | Já era wrapper de `untFuncoesGenerica.pGerarLogLiberacao` (`untFuncoesSimples.pas:40025`), que existe nas duas plataformas. Chamada qualificada |
| `fCarregaChequesTransferidos` | Só no ramo Windows (cheque, RN02) |
| `fTipDtaEstBai` | **Era `ShowModal`** (`TfrmDtaEstorno`), não regra. Ver abaixo |

### `fTipDtaEstBai` — correção de premissa

Esta seção a listava como regra de negócio a portar. `untFuncoesSimples.pas:40631`
abre `TfrmDtaEstorno` com `ShowModal` para o operador escolher entre a data do
estorno e a data da baixa. Diálogo não atravessa.

**A decisão de data saiu inteira do motor** (definido com o requisitante em
02/09/2026: *"a gente nunca pede a data, faz o esquema do estorno automático"*).

A origem resolvia isso em três etapas encadeadas (`untEstornoReceber.pas:5490`):
conferia os direitos `DTAOER`/`DTESTR`, lia `CFG_RDTEMB` e, quando a configuração
mandava perguntar, abria `TfrmDtaEstorno`. Direito de operador e diálogo não
existem sem operador, e as três etapas são inseparáveis — separar só a leitura de
`CFG_RDTEMB` deixaria no motor metade de uma decisão. Foram todas para o chamador.

O motor recebe `TEstornoOpcoes.EstornoComDataDoDocumento: Boolean` e usa como veio.
O que **ficou** no motor é a varredura que define *se* a data do documento chega a
valer para o lote (`RESCAI = 0`, ou `DTAREC` diferente da data do caixa) — isso é
regra, não diálogo.

- **Serviço:** passa sempre `False` → data do dia. É literalmente o caminho
  `blnEstornoAutomatico` da origem (`:5502`), que também ignora `CFG_RDTEMB` e o
  teste de direitos. Nenhum lançamento financeiro retroage.
- **Tela:** reproduz as três etapas antes de montar o record.

**Impacto na Fase 3:** o form precisa fazer o teste de `DTAOER`/`DTESTR`, ler
`CFG_RDTEMB` e chamar `fTipDtaEstBai` ele mesmo, preenchendo
`EstornoComDataDoDocumento` — senão a tela perde o diálogo de data e o aviso de
operador sem direito.

---

## 5. Sequência de implementação

### Fase 2 — Classes compartilhadas

1. Expor `TChaveDuplicata` / `TChavesDuplicatas` de `FiltroDuplicatas.pas`.
2. Criar `FiltroEstorno.pas` com o SQL de `pCriaTemporaria`, UNION `ADTCLI` sob `{$IFNDEF LINUX}`, corrigindo a concatenação para `ParamByName()`.
3. Criar `ValidacaoEstorno.pas` — validações de leitura **mais os portões da RN02** como funções puras.
4. Criar `DevolucaoPix.pas`, removendo `Application.ProcessMessages`.
5. Criar `EstornoDuplicatas.pas` com o cabeçalho `{$IFDEF LINUX}` de `BaixaDuplicatas.pas`, os records e o motor.
6. Marcar com `{$IFNDEF LINUX}` os blocos da tabela em §1.
7. Trocar `pEmitirMensagem` por `pAddErro`; `pSetFocus` e `fMensagem` não atravessam.
8. Criar as 9 versões Linux das genéricas (§4).

### Fase 3 — Desktop

9. `pConfirmaEstornoInterno` passa a montar `TEstornoParams` e chamar a classe, no molde de `untBaixaReceber.pas:3196`.
10. Traduzir `TErrosEstorno` de volta para `pEmitirMensagem` / `pSetFocus`; usar `SugerirRebaixaConjugadas` para a pergunta de `:6159`.
11. Incluir as units no `autcom.dpr`; compilar `autcom.groupproj`.
12. Validar a tela — **inclusive os cenários fora do escopo do endpoint**.

> Fim da fase = **commit próprio**, sem alteração de comportamento.

### Fase 4 — Serviço e API

13. `Financeiro.Services.Cobranca.Estorno.Types.pas` (Params/Result com `MVCSwagJsonSchemaField`).
14. `Financeiro.Services.Cobranca.Estorno.pas`: valida payload, **aplica os portões da RN02 sobre todas as linhas do lote**, aplica RN03/RN06/RN07, monta o record, chama a classe, traduz `TErrosEstorno` em 422.
15. Registrar em `TFinanceiroWorkerServer.LoadMethods`.
16. `api.controller.cobranca.estorno.pas` com `initialization`.
17. Incluir nos `.dpr`; compilar para Linux via PAServer; conferir o timeout do worker para o caminho `devolucao` (> 30 s).

### Fase 5 — Validação

18. Roteiro de validação manual da tela (entregável).
19. Entregar ao analista o contrato (§3) e os casos (§6).

---

## 6. Estratégia de testes

**Suite:** `FinanceiroServicesTEST.dpr`, casos em `Target/Linux/Test_Cases/estorno/*.inc`.

> Na Zona Moderna **os casos são escritos por analista humano**. A entrega de quem implementa é o projeto registrado, o contrato e a lista abaixo.

*Caminho feliz*
1. Baixa em cartão, duplicata única
2. Várias duplicatas no mesmo `CTR_SEQCON` — todas estornadas (RN01)
3. Cartão — `MOVCAR` desfeito e `MOVBAN` gravado
4. Baixa com juros/desconto — `MOVBAN` separado estornado
5. Baixa parcial — duplicata original reconstituída
6. PIX com portao fechado (ex.: `CFG_DEVPIX` desligada) - credito lancado
7. PIX em condicoes de devolver - devolucao executada, `MPX_QTDDEV` incrementado
8. Comissão de agrupamento (`CTR_CTPCOM`) estornada
9. Duplicatas conjugadas

*Portões de escopo — RN02*
10. Baixa em cartão com parte em crédito (`CTR_DINHEI <> 0`) → **estorna**, nao recusa
11. Baixa com cheque à vista → 422
12. Baixa com cheque pré → 422
13. Baixa com ordem de pagamento → **estorna** (Pix cai em CTR_ORDPAG)
14. `CTR_ADTCLI='S'` → 422
15. `CTR_MOVDES` preenchido → 422
16. `CTR_RESCAI=1` → 422
17. **Lote misto: linha da chave é cartão, outra linha tem cheque → 422 recusando o lote inteiro**

*Outras recusas*
18. Chave inexistente → 422
19. Duplicata já estornada → 422
20. `sequencialBaixa` ausente → 400
21. Operador sem `DIRRCXEST` → 422 nomeando o direito
22. `CTR_PORBAI` vazio → 422 identificando a duplicata
23. Duplicata travada por outra conexão → 422
24. `OperadorLogado` ausente ou não cadastrado → 400

*PIX — RN06/RN07*
25. `CFG_DEVPIX` ligada e recebimento em condicoes -> devolve
26. `CFG_DEVPIX` desligada -> gera credito, estorno conclui
27. Recebimento com 90 dias ou mais -> gera credito
28. Banco 748/208 com `MPX_USASHP<>'S'` -> gera credito
29. Valor ja devolvido (`MPX_QTDDEV` em 1,2) -> nem devolve nem credita, so remove a cobranca
30. `credito` com `CFG_PCTRPX` ou `CFG_ECTRPX` vazia -> 422 nomeando a configuracao

*Transação e auditoria*
31. Falha no meio → rollback completo, locks liberados (RN09)
32. `LOGMOVCTR` com origem `Financeiro.Services.Cobranca.Estorno` (RN10)
33. `CTR_MOTEST` em branco com `CFG_RMOTES` ligado (RN08)

**Validação manual do desktop:** roteiro cobrindo cartão, PIX, dinheiro, cheque, parcial, adiantamento, vale-presente, contas a pagar, conjugadas, modo caixa e estorno automático do cancelamento de documentos. Os cenários fora do escopo do endpoint são justamente os que a extração pode quebrar sem nenhum teste pegar.

---

## 7. Conformidade com padrões do projeto

**Zona Legado** (as quatro classes novas e `untEstornoReceber`): Hungarian style; prefixos `F`/`A`/`p`/`f`; dot-notation nos nomes das units novas, como a `BaixaDuplicatas` na mesma pasta; form segue em `TfrmPaiSimples`; não refatorar além do necessário à extração.

**Zona Moderna**: dot-notation; sem Hungarian; `Controller → Service`; atributos `[MVCPath]`, `[MVCHTTPMethod]`, `[MVCSwagSummary]`, `[MVCSwagParam]`, `[MVCSwagResponses]`; header `Empresa` no Swagger; registro em `initialization`.

**Travas do pre-commit — não gerar:** `TBitBtn`/`TButton`; `TDBGrid`/`TClientDataSet`/`TDataSetProvider`; `dxSkin*`, `frxSmartMemo`, `frCoreClasses`; `.SetFocus`; `StrToFloat`/`StrToFloatDef`; `Now`/`NOW()`; `Application.CreateForm`; `ActiveControl :=`; `FOREIGN_KEY_CHECKS`; SQL por concatenação; `FillType=ftBrush` e `Outline=` em `.dfm`.

> **SQL concatenado no código a mover** — mapeado em `fase1-inventario.md` §4. Os piores são `:3763` e `:5160` (`' AND RCX_CODCAX="' + strCodigoCaixa + '"'`, sem `QuotedStr`). A varredura por linha única subestima: SQL montado em várias linhas escapa dela, então o mapeamento definitivo é manual, unit por unit.

**Encoding:** `.pas` em CP1252 com CRLF — `untEstornoReceber.pas` tem acentuação nos literais, então gravar por PowerShell/Python em CP1252. `autcom.dpr` é a exceção: UTF-8 com BOM.

---

## 8. Riscos e mitigação

| Risco | Mitigação |
|-------|-----------|
| Reescrita, não mudança de endereço | Roteiro manual; commit da extração separado. Referência: 4.059 linhas alteradas no Req. 454631 |
| **A tela perder cobertura que o endpoint não tem** | Portões da RN02 no serviço, nunca na classe; blocos `{$IFNDEF LINUX}` preservam os caminhos só-Windows; roteiro manual cobre exatamente esses cenários |
| Bloco `{$IFNDEF LINUX}` mal delimitado quebra a compilação Windows ou Linux | Compilar os dois lados ao fim de cada unit extraída, não só ao fim da fase |
| 9 genéricas sem equivalente Linux | Inventariadas; precedente de 414 linhas no Req. 454631 |
| Devolução de PIX chama banco no request (~28 s de `Sleep`) | Timeout > 30 s; `ValorPixJaDevolvidoNoBanco` barra dupla devolução; falha → rollback |
| SQL por concatenação | Corrigir ao extrair; mapeamento manual complementa a varredura |
| Locks vazando em falha | Liberação no `finally`, exercitada pelo caso 31 |
| Acentuação corrompida ao editar `.pas` | Contar bytes ≥ 0x80 antes; conferir ausência de `EF BF BD` depois |
| Divergência de `CTR_MOTEST` (RN08) | Decisão registrada; comunicar ao suporte |
