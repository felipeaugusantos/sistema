# Plano de Execução — Req. 463387

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Ajuste pontual e aditivo em `TLotePrecos.pAlterarPrecoMargem` (unit `untLotePrecos.pas`). A rotina
interna `pRecalculaDados` já implementa o mecanismo de replicação entre tabelas de preço ativas
para os campos `PREVE` (preço de venda) e `MARBR` (margem bruta), controlado pela variável
`blnEPrecoDeVendaOuMargemBruta`. A solução estende esse mesmo mecanismo para o campo `COMTB`
(comissão de tabela), em dois pontos:

1. Inclusão de `COMTB` na condição que habilita o laço de propagação entre todas as tabelas ativas
   (`VS_strTabPrc`), em vez de gravar apenas a tabela do campo editado.
2. Inclusão do remapeamento de nome de campo dentro do laço (`strCamAlt := 'COMTB' + IntToStr(intCont)`),
   simétrico ao já existente para `PREVE`/`MARBR`, para que cada iteração do laço grave no campo da
   tabela correspondente (`COMTB1`, `COMTB2`, ... `COMTB7`) em vez de repetir sempre o campo de
   origem.

Não há alteração de arquitetura, de tela ou de estrutura de dados — apenas correção de uma lacuna
de simetria em lógica já existente.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untLotePrecos.pas | `padra_atualizado/fontes/movimentacaoitens/untLotePrecos.pas` | alterar |

## 3. Sequência de implementação

1. Localizar `pAlterarPrecoMargem` e a sub-rotina `pRecalculaDados` na unit `untLotePrecos.pas`.
2. Renomear `blnEPrecoDeVendaOuMargemBruta` para `blnEPrecoDeVendaOuMargemBrutaOuComissao` (3
   ocorrências: declaração e 2 usos), incluindo `AnsiStartsStr('COMTB', strCamAlt)` na condição de
   atribuição.
3. Adicionar bloco de remapeamento de campo para `COMTB` dentro do laço de replicação, logo após o
   bloco equivalente de `MARBR`.
4. Validar a edição: arquivo deve decodificar sem erro em `cp1252` e não conter sequência de
   corrupção (`\xef\xbf\xbd`).
5. Validação funcional manual na tela "Ativar Lote de Preços da Entrada de Mercadorias":
   editar "Comissão Tabela 1", marcar "Replicar para todas as tabelas", confirmar propagação para
   as tabelas ativas do item (2, 3 e 7, no cenário relatado).

## 4. Conformidade com padrões do projeto

- Zona Legado: mantido Hungarian style (`bln`, `str`, `int`), prefixos de escopo já existentes na
  unit; nenhuma refatoração adicional foi feita além do necessário para a correção.
- Edição do arquivo `.pas` (encoding `cp1252`/Windows-1252) realizada via script Python com
  encoding explícito (`io.open(..., encoding='cp1252', newline='')`), nunca via ferramenta de edição
  de texto genérica, para evitar corrupção silenciosa de caracteres acentuados no restante do
  arquivo.
- Nenhum componente, chamada ou padrão de SQL proibido pelo pre-commit foi introduzido.

## 5. Estratégia de testes

- Suite: não há suite DUnit cobrindo `TLotePrecos`/`untDigValorLote` nesta cópia do projeto
  (`AutcomTestesClientes.groupproj` cobre apenas regras tributárias — Difal/FCP, ICMS, IPI, ST).
- Validação: manual, na tela de origem do problema, reproduzindo exatamente o cenário relatado pelo
  cliente (MRA Auto Peças — editar Comissão Tabela 1 com replicação marcada e conferir tabelas 2, 3
  e 7).

## 6. Riscos e mitigação

- Risco: alteração poderia afetar o comportamento já existente de `PREVE`/`MARBR` se a condição
  fosse mal ajustada → Mitigação: alteração aditiva (uso de `Or`), sem remover nem modificar as
  condições existentes para `PREVE`/`MARBR`.
- Risco: outros campos de `LOTPRE` com a mesma limitação (não reportados) → Mitigação: registrado
  como fora de escopo em spec.md; não investigado nesta correção.
