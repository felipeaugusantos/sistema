# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Módulo Faturamento

Maior módulo do ERP (~1.037 .pas). VCL legacy — units com prefixo `unt`, sem namespaces em arquivo. Organizado de forma majoritariamente plana com subpastas para domínios complexos.

## Subpastas relevantes

| Pasta | Conteúdo |
|-------|----------|
| `Model/` | Modelos de dados: `untConsultaModelFaturamento.pas`, `untConsultaModelFaturamentoDatabase.pas` |
| `Impostos/` | Motor de cálculo tributário — ver abaixo |
| `FatImpressao/` | Serviço de impressão de NF/documentos (`FatImpressao.dpr` — EXE separado) |
| `Pedido/` | Gestão de pedidos de venda |
| `Devolucao/` | Processo de devolução de mercadorias |
| `Expedicao/` | Controle de expedição |
| `Promocao/` | Regras e gestão de promoções |
| `Auditoria/` | Auditoria de operações de faturamento |
| `Origem/` | Controle de origem dos pedidos |
| `B2W/` | Integração com marketplace B2W (Americanas) |
| `iLog/` | Integração com transportadora iLog |

## Motor de Impostos (`Impostos/`)

Subdividido por tipo de imposto — cada pasta é independente:

`BeneficioREIDI/` `IcmsEfetivo/` `IPI/` `RegrasTributacao/` `SubstituicaoTributaria/`

A pasta `RegrasTributacao/` contém as interfaces centrais (`untImpostoRegrasTributacao.pas`, `untImpostoRegrasAliquota.pas`) que os demais impostos implementam.

## Interfaces

Interfaces espalhadas no nível raiz da pasta, nomeadas como `unt<Conceito>Intf.pas` (ex: `untFatContratoEmpreitaIntf.pas`). Não há pasta `Interfaces/` centralizada — padrão legado.

## Impressão

`FatImpressao/` compila apenas como **Windows EXE**, invocado pelo ERP desktop (`autcom.groupproj`). Nesta cópia não existe contrapartida Linux em `Services/` — toda alteração no código-fonte impacta somente o alvo Windows.
