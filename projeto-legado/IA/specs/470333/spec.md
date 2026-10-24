# Req. 470333 — NF-e do faturamento automático presa em GE sem reconsulta

**Versão:** só 379.48.2.30.74.150 (os robôs Linux saem dela).
**Unit:** `padra_atualizado/fontes/faturamento/Faturamento.Classes.TFaturamentoAutomatico.pas`

## Problema

O integrador FIT responde `105 - Em processamento`. O `NFeStatus` grava `GE` e o robô espera no
máximo 30 s (`TIMEOUT` de `fValidarAutorizacaoNFe`) antes de seguir para o próximo pedido.

- A chamada `STA:GE` que o robô dispara nesse intervalo é descartada pelo `NFeStatus`: a
  anti-colisão em `PainelNfe/consultastatus/untVerificarStatus.pas` (`fExisteTarefaRecente('AE', 60)`)
  ignora `GE` se houve tarefa `AE` nos últimos 60 s. Como 30 s < 60 s, essa chamada **nunca** consulta.
- Depois disso, a única passada do `pExecuteAll` que revisita pedido já faturado
  (`FAT_NUMFAT` preenchido) é `sqlPedidosPendentesEtiquetaDespacho`, que só roda com
  `CFG_EXPFAU = S` **e** `CFG_IEDFAU = S`. As outras duas exigem `FAT_NUMFAT IS NULL`.
- Resultado: cliente com `CFG_EXPFAU = N` fica com a nota em `GE` para sempre, mesmo já
  autorizada na SEFAZ.

Caso real: Tintas Gonçalves Centro, empresa 002, em 15/10/2026, pedidos Mercado Livre. As notas
45141, 45160, 45180, 45183, 45202, 45215 e 45232, mais 45117 e 45119 do dia anterior, ficaram
presas. Todas tinham sido autorizadas segundos após o envio.

## Solução

1. Nova consulta `sqlPedidosPendentesAutorizacaoNFe` no `SQL_PEDIDOS` (agora `0..3`), **fora** do
   filtro `EXPFAU`/`IEDFAU`. Ela seleciona pedidos com `FGO_JAFATU = 1`, `LOGNFE.NFE_STATUS IN ('AE','GE')`,
   `NFE_TIP_FC = 'C'` e `FAT_DTAINS` nos últimos 2 dias. O resto é fluxo existente:
   `JaFaturado` → `fValidarAutorizacaoNFe` → `NFeStatus STA:GE`.
2. `fValidarAutorizacaoNFe` passa a retornar `False` no timeout. Com isso a linha
   `Timeout - Status da NFe` volta a ser gravada e a etiqueta não é gerada para nota não autorizada.

## Decisões

- **Não** remover o filtro da `sqlPedidosPendentesEtiquetaDespacho`. Ela filtra `NFEIMP IS NULL`
  e `FAT_ETIDTA IS NULL`; em cliente que não imprime, isso reprocessaria todo pedido marketplace
  dos últimos 2 dias a cada ciclo.
- Join com a `LOGNFE` pelas 5 colunas da PK, sem `IFNULL` em `NFE_SERIE_` (a coluna é NOT NULL e
  a função anulava o uso do índice). Na base do cliente, nenhum `FAT_SERFAT`/`FAT_CLIFAT`/`FAT_TIPFAT`
  é nulo com `FAT_NUMFAT` preenchido.
- O ritmo das tentativas fica a cargo da regra existente de 10 min (`MinutosNovaTentativaFaturamentoAutomatico`
  sobre `FAT_LOGDTA`). Isso também garante que a reconsulta caia fora da janela de 60 s da anti-colisão.

## Desempenho (base do cliente, 71.711 linhas na LOGNFE)

O EXPLAIN parte de `IDX_LOGNFE_04` (status), lê só as notas em AE/GE (9) e liga por índice:
`FATAUT` por `IDX_FATAUT_10`, `FATGOR` por `UK_FATGOR_01`, `EXTGOR` pela PK. O custo é
equivalente a um `SELECT 1`. O pior caso é um cliente com muitas notas antigas em AE/GE na
LOGNFE: o range cresce com elas.

## Liberação manual (sem a correção)

Rodar na pasta do robô, uma linha por nota:

```
./NFeStatus "TRF:NFE_PROCESSAR_STATUS" "DOC:<NUMDOC>" "ESP:NF" "EMP:<EMP>" "SER:<SERIE>" "CLI:<CODCLI>" "TFC:C" "STA:GE"
```

## Em aberto

- Compilar a .150 para Linux e ver um ciclo real `GE` → `AT` pela nova passada.
- Caminho com `CFG_EXPFAU = S` / `CFG_IEDFAU = S` não exercitado (o cliente usa `N`).
- 45117 e 45119 ficaram `AT` com `NFE_DTAAUT = 1899-12-30` após a liberação manual; não investigado.
- XML/PDF/etiqueta das 9 notas liberadas à mão não foram gerados.
