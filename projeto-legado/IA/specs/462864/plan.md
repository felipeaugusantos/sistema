# Plano de Execução — Req. 462864

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Correção pontual de regra de negócio dentro de uma função existente, sem criação de novas telas, tabelas ou
camadas. `fBaixaPedidosEmbalagem` (unit `untPcmGer.pas`) não tinha acesso, na sua assinatura original, às
flags que identificam devolução de cliente, garantia ou consignação de equipamento — informação que já
existe como parâmetros de `fConfirmaEntradaMercadorias`, disponíveis por escopo léxico na função aninhada
`fBaixaPedidosEntrada`, que é quem chama `fBaixaPedidosEmbalagem`.

A abordagem foi propagar (thread) essas quatro flags booleanas através da assinatura de
`fBaixaPedidosEmbalagem`, com valor default `False` para preservar compatibilidade com o único outro call
site (`fBaixaPedidos`), e usá-las na condição que decide gravar o histórico de fornecedor em `HISENT`.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untPcmGer.pas` | `padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas` (4 working copies) | alterar |

Working copies alteradas (mesmo diff em todas, verificado por conteúdo exato — os arquivos têm o mesmo
trecho de código, mas número de linha divergente entre cópias):

- `379.48.2.30.74.150.45`
- `379.48.2.30.74.150.100`
- `379.48.2.30.74.150`
- `74.Fechadas\74.150.45.Fechadas\379.48.2.30.74.150.45.69`
- `74.Fechadas\74.150.45.Fechadas\379.48.2.30.74.150.45.68`

## 3. Sequência de implementação

1. Alterar a assinatura de `fBaixaPedidosEmbalagem`, adicionando 4 parâmetros booleanos opcionais (default
   `False`) após `blnUtilizarCFG_CLARET`: `blnDevolu`, `blnRecCliGarantia`, `blnConEqu`,
   `blnAcessadoViaRetornoConsignacao`.
2. Alterar a condição `If Not fEmptyStr(strCodFor) Then` (bloco que chama
   `fGravaHistoricoEntradaMercadorias`, dentro do laço principal da função) para também exigir que nenhuma
   das 4 flags esteja ativa.
3. Atualizar os dois call sites internos a `fBaixaPedidosEntrada` (função aninhada em
   `fConfirmaEntradaMercadorias`), passando `blnDevolu`, `blnRecCliGarantia`, `blnConEqu` e
   `AblnAcessadoViaRetornoConsignacao` — variáveis já existentes no escopo, sem necessidade de nova
   declaração.
4. Repetir os passos 1–3, por conteúdo exato de trecho de código (não por número de linha fixo), em cada uma
   das 4 working copies.
5. Validar, em cada cópia, que o arquivo decodifica corretamente no encoding declarado (cp1252) e que
   nenhuma sequência `\xef\xbf\xbd` (marcador de corrupção UTF-8) foi introduzida.
6. Rodar a skill `corrigeUnitFlipCRLF-LF` (modo lote) em cada working copy, para confirmar que o `svn diff`
   contém apenas as alterações pretendidas, sem ruído de EOL/encoding.

## 4. Conformidade com padrões do projeto

- Zona Legado: Hungarian style mantido (`blnDevolu`, `blnRecCliGarantia`, `blnConEqu` seguem o padrão já
  usado no restante do arquivo); nenhuma unit/classe nova criada.
- Nenhum componente proibido (`TButton`, `TBitBtn`, `TDBGrid`, `TClientDataSet`, `TDataSetProvider`,
  `dxSkin*`, `frxSmartMemo`) envolvido — alteração é 100% lógica de negócio em Object Pascal puro.
- Nenhuma chamada proibida envolvida (`Now`/`NOW()`, `StrToFloat`/`StrToFloatDef`, `.SetFocus` direto,
  `Application.CreateForm`, `ActiveControl :=`, SQL por concatenação, `FOREIGN_KEY_CHECKS`).
- Arquivo `.pas` em encoding legado (cp1252/CRLF): todas as edições feitas via Python em nível de bytes
  (não pela ferramenta de edição de texto genérica), devido a uma corrupção de encoding pré-existente e não
  relacionada já presente no arquivo (impede decodificação completa em cp1252) — ver seção 8 de
  `correcaoFkHisentDevolucao_Req462864.md`.
- Pre-commit: sem SQL/componentes/chamadas proibidos; nenhuma propriedade de formulário (`.dfm`) alterada.

## 5. Estratégia de testes

- Suite: não há suite DUnit cobrindo especificamente o fluxo de baixa de pedido na entrada de mercadorias
  por devolução/garantia/consignação; nenhuma suite existente em `AutcomTestesClientes.groupproj` foi
  identificada como aplicável a este trecho de código.
- Validação realizada: revisão de lógica e rastreamento de escopo de variáveis, sem acesso a IDE
  Delphi/compilador neste ambiente de execução (sem simulação em homologação).
  - Confirmado, por busca textual exaustiva na unit, que `fBaixaPedidosEmbalagem` não é declarada na
    interface e tem apenas 3 call sites no projeto inteiro (os 2 alterados + `fBaixaPedidos`, que não
    precisa de ajuste).
  - Confirmado que, para o fluxo de fornecedor (todas as 4 flags `False`), a nova condição é logicamente
    equivalente à antiga — nenhum comportamento muda para entrada normal de fornecedor.
  - Confirmado que a baixa do pedido (`fBaixaPcmDet`/`fBaixaPcmGer`) permanece fora do bloco condicional
    alterado, garantindo que o pedido de compra continue sendo baixado mesmo quando a gravação do histórico
    de fornecedor é descartada.
- Recomendação para validação funcional futura: reproduzir a confirmação de uma entrada de mercadorias
  vinculada a devolução de cliente em ambiente de homologação, referenciando a nota de venda original, e
  confirmar ausência do erro `#23000` e baixa correta do pedido em `PCMGER`.

## 6. Riscos e mitigação

| Risco | Mitigação |
|---|---|
| Alteração de assinatura de função quebrar outro call site não mapeado | Busca textual exaustiva confirmou que `fBaixaPedidosEmbalagem` só é chamada em 3 pontos no projeto inteiro (não declarada na interface da unit); os 4 novos parâmetros têm default `False`, preservando o comportamento do call site não alterado (`fBaixaPedidos`) |
| Ausência de validação em homologação | Equivalência lógica confirmada por revisão de código para o fluxo de fornecedor (sem mudança de comportamento); recomendação de teste funcional registrada na seção 5 |
| Corrupção de encoding pré-existente no arquivo interferir na edição | Edição feita em nível de bytes (Python), sem decodificar o arquivo inteiro, preservando a região corrompida sem tocá-la e sem introduzir nova corrupção (validado após cada gravação) |
| Divergência de número de linha entre as 4 working copies causar edição no lugar errado | Localização e aplicação da correção por conteúdo exato de trecho de código, nunca por número de linha fixo, com validação de 1 ocorrência por trecho antes de cada gravação |
