# Req. 468631 — Etiqueta unificada: DANFE separada quando não couber

Cliente: VIPASA (empresa 001 — única que fatura marketplace). Envolvidos: Vitor, Ronaldo, João.
Continuação do Req. 450454 (EDUNIF); histórico em `IA\specs\450454\record.md`.
Spec e plano aprovados pelo João em 08/10/2026.

## Problema

A DANFE embutida na etiqueta unificada (`IMPNFE.NFE_LAYUNI`) é uma página FastReport de altura
fixa. O que não cabe vai para uma página 2 que ninguém lê: os itens excedentes **somem sem aviso**.
A VIPASA usa a DANFE para conferir a saída da mercadoria. Para não sair DANFE em dobro, desde
24/09/2026 os operadores escolhem o ponto `NÃO_IMPRIMIR` na expedição — logo, nota que não cabe
sai hoje sem DANFE completa nenhuma.

## Requisitos

**R1 — Dados adicionais do layout unificado: só o pedido e-commerce, sem mensagens fiscais.**

> **Decisão de 09/10/2026 — mensagens fiscais retiradas da etiqueta unificada a pedido da
> VIPASA.** O requisito pedia o pedido e-commerce + a mensagem de totais de impostos. A versão com
> as mensagens fiscais (`infAdFisco` inteiro + linha CBS/IBS, numa banda esticável depois dos itens)
> foi implantada em 08/10 e retirada em 09/10: o cliente ligou reclamando delas e, sem confirmação
> de que sejam obrigatórias na etiqueta, preferiu ficar sem. A NT 2020.004 (DANFE Simplificado –
> Etiqueta) não as lista entre os campos obrigatórios; a SEFAZ-SP (RC 24712/2021) só proíbe o DANFE
> de divergir do XML. Se a obrigatoriedade for confirmada depois, a versão fiscal está pronta e
> testada (`layuni_vipasa_fiscal.fr3`).
>
> A decisão vale **só para a etiqueta unificada**. A DANFE simplificada separada (R6) continua com
> as mensagens fiscais: é o documento completo, e é ela que sai quando a nota não cabe na etiqueta.

Fica o layout de 06/10 (Req. 450454): rodapé de uma linha com `PEDIDO E-COMMERCE: <pedido>`. Cabem
~10 itens; com o fiscal cabiam ~7 a 8.

**R2 — O próprio layout decide se coube.** Sem configuração nova. O NFeImpressao exporta uma
página por arquivo (`etq-unif-<chave>.1.bmp`, `.2.bmp`…) — o nome sai de
`TConexaoBD.pSalvarDFEBMP`, em `PainelNfe\imprimenfe\untConexaoBD.pas`, que renomeia só a `.1.bmp`.
Existir a `.2.bmp` = não coube → a etiqueta **não** é unificada e sai a original do marketplace,
sem mensagem (é desfecho previsto, não falha). Verificado em 08/10 com a NF 1.242.415 (12 itens).

**R3 — A etiqueta informa se unificou.** Três estados: não se aplica (marketplace fora do
`CFG_EDUNIF`, ou não é etiqueta de marketplace), unificada, não unificada (habilitado, mas não coube
ou falhou).

**R4 — Expedição de documento do Faturamento Automático decide a DANFE.** Ordem nova: etiqueta
primeiro; DANFE simplificada depois, **só se a etiqueta não a trouxe**.

A DANFE sai pelo **ponto de impressão da NF**, como sempre — **não** pela fila da etiqueta, apesar
de o texto do requisito pedir "na fila da impressora de etiqueta". Decisão do João (08/10/2026),
pelo motivo técnico: a fila da etiqueta (`frmImpEtiDespacho_*`) recebe ZPL como texto por driver
genérico e não imprime FastReport. O que o requisito quer — sair no mesmo momento e na mesma Zebra
— o ponto já entrega: na VIPASA, o ponto `DANFE SIMPLIFICADO` aponta para a mesma Zebra com driver
gráfico (fila `DANFE SIMPLIFICADA`), e foi assim que DANFE e etiqueta saíram juntas até 23/09
(~900/dia cada, conferido na `SPOIMP`).

Só o fluxo FATAUT usa o resultado da etiqueta, porque é o único em que a DANFE é impressa **na
expedição**. Nos demais fluxos de etiqueta da expedição (`CFG_IEDAEX`, expedição que fatura, lote,
seleção múltipla) a DANFE sai na autorização, pelo ponto da NF; ali o resultado é descartado, e uma
nota que não cabe sai com a etiqueta original — o mesmo que um marketplace fora do `CFG_EDUNIF`, e
melhor que a DANFE embutida cortada de antes. Chamar a DANFE separada nesses fluxos a imprimiria em
dobro.

**R5 — Avisar quando a DANFE necessária não vai sair.** Só quando a etiqueta era unificável e não
unificou:
- nenhum ponto de impressão resolvido (inexistente ou escolha cancelada) → mensagem;
- ponto cuja impressora é "não imprimir" → mensagem.

Só avisa: o operador não tem autonomia para mexer em ponto/fila, quem configura é o TI. A mensagem
**não** fala em conferência — é particularidade da VIPASA.

**R6 — DANFE simplificada separada (`NFE_LAYSIM`) legível em mais de uma folha.** Incluído em
08/10 depois do teste com a NF 1.242.415: o rodapé "Dados adicionais" (~45 mm, OBS inteiro) saía em
toda folha, e a folha 2 não tinha destinatário, "Itens:" nem numeração. Configuração do cliente
(`.fr3`), sem release:
- dados adicionais só no fim, com pedido e-commerce + mensagens fiscais (OBS inteiro se não houver
  o rótulo do pedido). As mensagens fiscais **ficam** aqui — a retirada de 09/10 (R1) é só da
  etiqueta unificada;
- "Folha N de M", destinatário e "Itens:" em toda folha;
- código de barras de ~20 mm para ~10 mm de altura (mesma largura; bipado e lido).

## Fora de escopo

- Faturamento (`untFuncFatImp`), romaneio, nota especial, FatImpressão e a tela manual de etiqueta.
- Reimpressão pela tela manual: imprime **só a etiqueta** (unificada ou não). Sai naturalmente,
  porque a decisão da DANFE vive na expedição.
- Empresas 002/003: não faturam marketplace. Se um dia faturarem, o `NFE_LAYSIM` da 002 não tem
  itens e a 003 não tem layout.
- No `NFE_LAYSIM`: descrição longa de item cortada na margem e protocolo de autorização impresso
  como `__` — já eram assim no layout original (decisão do João, 08/10).
- `TLibNfe.Create` dentro do `Try` em `pImprimirDANFE` — pré-existente; corrigido em 09/10 na .111,
  .150.100 e .150.45 (o DelphAI rejeita com ⚪ em aberto). A .150 foi aprovada antes (r499294) e
  segue com ele.

## Critérios de aceitação

| # | Cenário (expedição de doc. FATAUT, `CFG_IEDFAU=S`) | Esperado |
|---|---|---|
| A1 | Marketplace em `CFG_EDUNIF`, itens cabem | Etiqueta unificada; **sem** DANFE separada; sem pergunta de ponto |
| A2 | Marketplace em `CFG_EDUNIF`, itens não cabem | Etiqueta original; depois DANFE simplificada pelo ponto |
| A3 | Como A2, ponto "não imprimir" | Etiqueta original; mensagem de que a DANFE não foi impressa |
| A4 | Como A2, nenhum ponto / escolha cancelada | Etiqueta original; mensagem de ponto não configurado |
| A5 | Marketplace em `CFG_EDUNIF`, falha na unificação (sem chave, layout vazio…) | Mensagem da falha (já existente); etiqueta original; DANFE separada |
| A6 | Marketplace fora do `CFG_EDUNIF` / nota sem marketplace | Etiqueta; depois DANFE como hoje; **nenhuma** mensagem nova mesmo com ponto "não imprimir" |
| A7 | `CFG_IEDFAU=N` | Só DANFE, como hoje |
| A8 | Reimpressão pela tela manual, nota que não cabe | Só etiqueta original |
| A9 | Duas notas seguidas, a 1ª com `.2.bmp` | A 2ª não herda a página 2 da 1ª (arquivos por chave + limpeza) |

## Configuração do cliente na entrega

Voltar a estação para o ponto `DANFE SIMPLIFICADO 1/2` (ou deixar o operador escolhê-lo): com R4, a
pergunta de ponto só aparece quando a DANFE é de fato necessária.

Layouts em uso na VIPASA (backup de antes das trocas: `IMPNFE_BKP_20261008`):
- `NFE_LAYUNI` da 001, 002 e 003 → `IA\specs\450454\vipasa-layuni\layuni_vipasa_pedido.fr3`
  (MD5 `8239a4c2…`), reimportado em 09/10 (R1);
- `NFE_LAYSIM` da 001 → `laysim_vipasa_fiscal.fr3` (MD5 `9b3d663b…`), importado em 08/10 (R6).
  Original de produção em `laysim_vipasa_original.fr3`.

Não usado desde 09/10, guardado: `layuni_vipasa_fiscal.fr3` (etiqueta unificada com fiscal).
