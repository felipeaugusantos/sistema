# Análise — Req. 462714: CBS / IBS / IS no Pedido de Compra e na Cotação

**Versões:** 150 (base), 150.100, 150.45, 74.111, 72
**Zona:** Legado (`padra_atualizado/fontes/movimentacaoitens/`)
**Período:** 08/10/2026 a 09/10/2026
**Documentos da pasta:** `spec.md`, `plan.md`, `tasks.md` e `script_462714.sql` (DDL). Este arquivo é o registro de
memória: contexto, decisões, caminhos descartados e pendências.

## 1. Pedido original

Texto do requisito (Ronaldo, 08/10/2026):

```
PEDIDO DE COMPRA e COTACAO
- CONFIGURACAO (1) LIGADA e (CFG_SIMPAU = N ou (CFG_SIMPAU = S e HIBRIDO = S)):
    1. MOSTRAR NO RODAPE OS IMPOSTOS CBS / IBS / IS
    2. SOMAR OS NOVOS IMPOSTOS NO VALOR CONTABIL DO DOCUMENTO
- CONFIGURACAO (1) DESLIGADA OU (CFG_SIMPAU = S e HIBRIDO = N):
    1. NAO EXIBIR NO RODAPE
    2. NAO SOMAR NO VALOR CONTABIL
```

A "configuração (1)" é a `CFG_REFCIS` ("REFORMA TRIBUTÁRIA - Somar impostos CBS/IBS/IS no Valor Contábil do Documento?").
O "híbrido" é a `CFG_SIMHIB` ("Optante por simples nacional - Regime Híbrido?").

## 2. Contexto de negócio

- O Pedido de Compra (`TfrmPedidoDeCompra`, na DLL `libPedidoDeCompra`) e a Cotação (`TfrmCadCotacaoGeralCX` /
  `TCotacao`, no `autcom.exe`) não tinham nenhum tratamento de CBS/IBS/IS.
- O IPI é o imposto de referência nas duas telas, e o desenho seguiu a cadeia dele ponto a ponto:
  - **Pedido:** `% IPI` por item (`ITE_PERIPI`), valor `ITE_TOTIPI` arredondado por linha, aggregate `TOT_TOTIPI` no
    rodapé, soma em `TOT_TOTGER` / `edtTotGer`, gravação em `PCMDET` / `PCMGER`.
  - **Cotação 150.x:** `% IPI` por item × fornecedor (`COT_IPIENT`), valor calculado por unidade e
    `TOTAL_IPI = QTDTOT × unitário`; só o percentual é gravado.
  - **Cotação 7x (74.111 e 72):** desenho pivô, um único `cdsItens` com colunas por posição de fornecedor (`nn` = 01..50).
- Decisão de 08/10: o operador informa a **alíquota** (não o valor), e o sistema calcula. A primeira versão pedia o
  valor digitado; foi trocada no mesmo dia.

## 3. Regra de cálculo (base da NT)

Fonte: NT 2025.002-RTC v1.33, regra UB16-10 (rejeição 1104):

```
vBC = vProd + vServ + vFrete + vSeg + vOutro + vII + vIS
      − vDesc − vPIS − vCOFINS − vICMS − vICMSUFDest − vFCP − vFCPUFDest − vICMSMono − vISSQN
```

| Documento | Base usada (só campos existentes na tela) |
|-----------|-------------------------------------------|
| Pedido normal | `ITE_TOTITE + ITE_VALFRE + ITE_DESACE − ICMS` |
| Pedido de importação | `ITE_TOTITE + ITE_VALFRE + ITE_DESACE + ITE_VALIMP − ITE_VALPIS − ITE_VALCOF − ICMS` |
| Cotação (por unidade) | `(preço + frete − crédito de ICMS) / divisor` (mesma unidade do `UNITOT`) |

- `ITE_TOTITE` já é líquido de desconto.
- IPI e ICMS-ST não entram (LC 214/2025, art. 12, § 2º).
- O frete entra sempre, independentemente de `IPIFre`.
- **ICMS no pedido:** `RoundTo(ITE_BASICM × ITE_ALQICM / 100, -2)`.
  - Não é subtraído quando o ICMS é desonerado: empresa em estado de Zona Franca (`fEhEstadoRegraZonaFranca`) **e**
    `ITE_CICMDE = 'S'`. É a mesma condição de `fCalcularSubstituicaoProduto` e do `TOT_TOTGER`.
  - No 72 não existe desonerado.
- **ICMS na cotação:** o crédito calculado na própria cotação, quando a versão o tem. 74.111 e 72 não têm
  `COT_CREICM`, então subtraem 0.
- Termos sem campo na tela entram como 0. Base negativa vira 0.
- **Ordem:** o IS é calculado primeiro e integra a base do CBS/IBS (CF art. 153, § 6º, IV; LC 214/2025, art. 12, § 1º, V):
  - `IS = base × ALQ_IS / 100`
  - `CBS = (base + IS) × ALQCBS / 100`
  - `IBS = (base + IS) × ALQIBS / 100`
- **Massa de aceite:** base 940,00 → IS 9,40; base CBS/IBS 949,40 → CBS 8,54; IBS 0,95.
- **Risco futuro:** a NT 2026.008 remove a UB16-10 (homologação 10/2026), e a base passa a ser só a da LC 214. A mudança
  fica restrita ao núcleo.

## 4. Regra ligada / desligada

- Função única: `fSomarNovosImpostosDaReformaAoValorContabil`, que devolve `REFCIS <> 'N'` e não
  (`SIMPAU = 'S'` e `SIMHIB = 'N'`).
  - Avaliada uma vez por abertura de tela e guardada em `FblnSomaReforma`.
  - **Nenhuma soma pode depender de `.Visible` de um controle.** A primeira versão da 150 fazia isso em
    `untPedidoCompraImportacao`, `untPedidoCompraResumoLojas` e `untPedidoCompraResumoLojasItem`; foi corrigido na
    refatoração de 09/10.
- O cálculo dos valores roda sempre; só exibição e soma dependem da regra.
- Um pedido gravado com valores, aberto depois de a regra ser desligada, não exibe nem soma, mas os valores ficam no banco.
- **7x:** não tinham a função. Ela foi criada direto em `genericos\untFuncoesSimples.pas`, com o corpo da 150. O plano
  previa `untFuncoesGenerica` mais um wrapper, e foi simplificado.
- **`CFG_SIMHIB`:** existia nas 150.x e não existia nos 7x. Na auditoria de 09/10 o usuário decidiu criá-la neste
  requisito, só no `configuracoes\untCfgRepositorio.pas` do 74.111 e do 72.
  - Linha copiada da 150: padrão `N`, grupo DADOS FISCAIS.
  - **Armadilha:** a tela de configurações liga o editor de cada configuração pela ordem dentro do grupo
    (`arrCamposCfg[fInc(intInd)]`). Só o `pAdicionarConfiguracao` deixaria o editor desalinhado. Por isso também entrou a
    linha `AProperties := rdgSimNao_S_N.Properties; //CFG_SIMHIB`, na última posição do bloco do grupo.
  - **Ressalva:** empresa do Simples sem a linha gravada na `CFGSIS` lê vazio e soma. Precisa ter `N` gravado.

## 5. Solução — núcleo e adapters

**Núcleo OO:** `PedidoDeCompra\untImpostosReformaCompra.pas`, sem dependência de banco nem de genericos. É idêntico nas 5
versões (SHA-256 `02175E2C4BC92EDCC5C0B8352CE6C20F4C48D6D2CA8F693FC03EE35F85C94AD1`).

| Tipo | Papel |
|------|-------|
| `TAliquotasReforma` | alíquotas, com `fAliquotaValida` de 0 a 100; validação única do pedido e do diálogo da cotação |
| `TBaseReforma` | campos nomeados da base; `fValor` aplica a fórmula e o piso 0 |
| `TValoresReforma` | valores CBS/IBS/IS e `fTotal` |
| `TCalculoReformaCompra` | `fCalcular` (com ou sem arredondamento) e `fSQLValores` (a mesma fórmula em SQL, para a cotação) |

- **Adapters** (onde o dado está):
  - `pCalculaImpostosReformaItem` (dataset do item do pedido, em `untFuncoesPedidoSimples`);
  - `pCalculaImpostosReformaPcmDet` (cotação → pedido);
  - o BeforePost e o SQL da cotação.
- **Cópia de alíquotas entre datasets:** rotina única `pCopiaAliquotasReforma`, usada no multi-loja e no `untFuncoesPedido`.
- **Gravação:** parâmetros novos ao final de `pGravaPcmGer`, `pAtualizaPcmGer` e `fGravaPcmDet`, com default 0. Records
  não foram usados porque o Delphi não aceita default em parâmetro record. As caudas posicionais diferem por versão e
  foram conferidas uma a uma (`plan.md` §4).
- **Unitário com impostos do pedido** (revisão de 09/10, pedido do usuário no teste da 150):
  - `pCalculaUniImp` soma `(CBS + IBS + IS) / quantidade`;
  - as cargas usam `fSQLUnitarioImpostosReforma`;
  - na cotação o `UNITOT` não mudou, de propósito, para não afetar a escolha do melhor fornecedor.
- **Unit em todo `.dpr` que compila `untFuncoesPedidoSimples`:** na 150 são 17 (`autcom`, `libPedidoDeCompra` e 15
  Services Linux); a lista de cada versão está no `tasks.md`.

## 6. Rodapé em linha corrida (RF03a)

- **Problema:** o `Panel4` do pedido não tinha espaço. A primeira solução foi uma segunda linha com CBS/IBS/IS, de altura
  ajustada pela regra.
- **Pedido do usuário:** mostrar "RÓTULO: valor" em linha corrida, com rótulo vermelho em negrito e valor preto.

**Alternativas avaliadas e descartadas:**

| Opção | Motivo do descarte |
|-------|--------------------|
| `TRichEdit` disfarçado | recebe foco, cursor e seleção; acinzenta quando desabilitado; fundo não segue o tema; formatação por `SelStart` pisca |
| `TWebBrowser` com HTML | carrega o motor do IE para uma linha; carga assíncrona; cor de fundo e DPI não seguem o painel |
| `TdxFormattedLabel` | não existe na versão do DevExpress instalada |

**Solução adotada:** unit nova `PedidoDeCompra\untRodapeFormatado.pas`, classe `TRodapeFormatado` (`TComponent`, dono = o
form).
- Move todos os controles do `Panel4` para um painel oculto (`FpnlCampos`) e põe um `TPaintBox` `alClient` no lugar.
  - Os controles continuam existindo porque o form lê e grava o texto deles. Exemplos: `fStrToFloat(edtTotGer.Text)` e
    `edtTotFre.Text := ...`.
  - O form também liga e desliga a visibilidade deles: ST/FCP na importação, CBS/IBS/IS pela regra, ICMS DESON e DESC.
    PIS pela Zona Franca, litragem pela `CFG_USATMQ`.
- **Pareamento:** cada `TLabel` mostra o edit mais próximo à direita na mesma linha (tolerância de 8 px no `Top`). Rótulo
  ou edit invisível não aparece.
- **Ordem:** a da tela (linha, depois esquerda → direita). O rótulo passado no `Create` (`lblTotGer`) vai sempre por
  último, e assim CBS/IBS/IS ficam antes do TOTAL.
- **Desenho em duas passadas:** a primeira mede as linhas e a segunda desenha centralizado. A linha quebra quando não cabe.
  `ClientHeight` do painel = linhas × altura + 3 px acima e abaixo; isso passa por cima dos 54/27 do
  `pAjustaCamposReforma`.
- **Atualização:** gancho no `WindowProc` de cada controle movido (`TGanchoCampoRodape`), que redesenha em
  `CM_TEXTCHANGED` e `CM_VISIBLECHANGED`.
  - A primeira versão usava `OnChange` dos edits e foi descartada: não pega mudança de `Visible` nem de `Caption` do
    rótulo (ex.: "LIT./QUI." ↔ "GALÕES").
- **Destruição:** o destructor libera os ganchos e restaura o `WindowProc` **antes** do `inherited`. O
  `inherited` libera o `FpnlCampos`, que libera os controles filhos. Sem essa ordem, o `WindowProc` apontaria para um
  objeto liberado durante a destruição dos campos (AV ao fechar o form).
  - Liberar os controles pelo painel oculto é seguro: o `TComponent` se remove da lista do dono (o form) ao ser destruído,
    sem dupla liberação.
- **Uso:** `TRodapeFormatado.Create(Self, Panel4, lblTotGer)` no `FormCreate`, depois do `pAjustaCamposReforma`. A unit
  entra só no `libPedidoDeCompra.dpr`, porque o form fica na DLL.
- **Validação:** compila isolada (dcc32) sem aviso. O usuário aprovou a tela na 150, e a unit foi replicada byte a byte
  nas outras 4.

## 7. Auditoria (/citel-aprovaRequisito, 09/10)

Varredura das linhas acrescentadas e das units novas nas 5 versões.

| # | Achado | Decisão |
|---|--------|---------|
| B1 | 72, `untPedidoCompra.pas`: `pAjustaCamposReforma`, `pCalculaReformaTela` e `fValidaAlqReforma` declarados no meio dos campos da seção `private`; o Delphi recusa campo depois de método (E2169) | **Corrigido:** os 3 métodos foram para o fim da seção `private` |
| B2 | `untCotacao.pas` (5 versões): alíquotas e `COT_CODFOR` concatenados no SQL, no mesmo comando que já concatenava IPI/DIVISO/ST | **Mantido** pelo usuário: o comando inteiro já era concatenado, e passar só os campos novos para parâmetro exigiria reescrevê-lo |
| B3 | DDL ausente em `2_30_74_XX_COM` (74.111) e `2_30_72_COM` (72); presente só no banco da 150 (`2_30_74_150_COM`, inclusive `_RES`) | Ignorado nesta etapa (pendência) |
| B4 | DUnit e CA não executados | Ignorado nesta etapa (pendência) |
| B5 | rodapé em linha corrida fora de spec/plan/tasks | **Registrado** (RF03a, plan §3, tasks Fase 8c) |

- **Limpos nas 5 versões:**
  - componentes e chamadas proibidas, `FillType`/`Outline`, `FOREIGN_KEY_CHECKS`;
  - `Create` sem `Free`, variáveis globais, lógica em eventos, soma por `.Visible`;
  - encoding cp1252 e EOL iguais ao BASE: os 6 LF soltos do `untPedidoCompra.pas` e os 23 do `untCotacao.pas` já
    existiam; `autcom.dpr`, `untFuncoesSimples.pas` e `untPcmGer.pas` dos 7x já eram UTF-8 com BOM no BASE;
  - os `.dpr` só acrescentam as units do requisito.
- **`svn add` feito na sessão:**
  - `untImpostosReformaCompra.pas` em 150.100, 150.45, 74.111 e 72 (estava fora do SVN, mas já constava nos `.dpr`);
  - `TestuntImpostosReformaCompra.pas` nas 5 versões;
  - `untRodapeFormatado.pas` nas 5 versões.
- **Não commitar:**
  - 150: `untPrincipal.dfm` (ruído da IDE), `cadastros\untTCadTabPrecoAutomatico.pas` (alteração alheia), `opcoes.ini`,
    os `rev.inc`, `libCadastros.identcache` e `Tintas.View.res`;
  - 150.100 e 150.45: `opcoes.ini` e os `rev.inc`;
  - 74.111: `opcoes.ini`;
  - 72: `opcoes.ini` e `autcom.stat`;
  - todas: `review.diff` e `.delphAI`.

## 8. Decisões de escopo

**Fora deste requisito:**
- motor `TRefTribCalculo` e busca automática de alíquota;
- separação do IBS em UF/município;
- pré-nota;
- importação de cotação via API (`Suprimento.Services.Cotacao.Importacao`) e via portal; compilam com os defaults e
  preservam as alíquotas;
- caminho `COTACAO_MODO_GRAVACAO_ANTIGA` do 74.111: o pedido gerado nesse modo nasce sem CBS/IBS/IS;
- baixa por entrada de nota (equivalente a `PCD_IPIBAI`);
- layout `.fr3`, editado pelo usuário;
- CBS/IBS/IS no `UNITOT` da cotação.

**Também fora (decisão de 09/10):**
- "Dados Atuais do Produto" e o grid esquerdo da aba 4, porque o cadastro do produto não tem alíquota;
- telas de entrada de nota (`untEntSelPedidos`, `untEntConfPedidos`, `untNotaFiscalImport`);
- relatório `untConsultaPedCom`.

**Achado colateral, não tratado:** o ramo cotação do `TValidaValorPedidoCompra` nunca roda. O `Exit` do r213184 avalia
`FblnCotacao` antes de ele ser ligado. Fica para requisito próprio.

## 9. Pendências

- DDL (`script_462714.sql`) e `SHOW COLUMNS` nos bancos de 150.100, 150.45, 74.111 e 72. Nos 7x, conferir antes quais
  tabelas `_RES` existem (o 72 não tem `COTFOR_RES`).
- Compilar `autcom.groupproj` e `libPedidoDeCompra` em 150.100, 150.45, 74.111 e 72. No 72, depois da correção do B1.
- Rodar o `AutcomTestes` (DUnit `TestuntImpostosReformaCompra`) e os CA01–CA17 por versão.
- Retestar o diálogo da cotação (massa 10 × 100,00; CBS 10 / IBS 1 / IS 1 → total 1.121,10).
- Retestar o pedido 000000006296 / emp 003 (unitário com impostos 135,52 pela carga do banco; 155,52 com IPI de 20%
  digitado).
- Comunicar a mudança no valor das parcelas com a regra ligada: `PCG_TOTGER` passa a incluir CBS/IBS/IS.
- Commit: primeira linha `Req. 462714` + token DelphAI. A 150 leva esta pasta; as demais versões, a mesma referência.

## 10. Lições de processo

- `.pas`, `.dfm` e `.dpr` só foram editados por script em bytes cp1252, preservando o EOL de cada arquivo e com âncora
  única. A exibição do `cat -A` no Git Bash desta máquina não mostrou `^M` em arquivo CRLF; a contagem real foi feita em
  Python.
- No 72 e no 74.111, o `pAjustaCamposReforma` aparece duas vezes no `untPedidoCompra.pas`. A âncora do `FormCreate` usou
  a linha anterior (`FblnSomaReforma := ...`) para cair no lugar certo; isso foi conferido depois de gravar.
- Unit nova referenciada no `.dpr` precisa de `svn add` na mesma hora: quatro versões estavam com o núcleo fora do SVN.
