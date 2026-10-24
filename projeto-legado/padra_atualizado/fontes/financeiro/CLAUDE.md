# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Módulo Financeiro

Módulo VCL (~367 .pas). Units com prefixo `unt`, sem namespaces. Organizado por subdomínio financeiro.

## Subdomínios

| Pasta | Conteúdo |
|-------|----------|
| `contasareceber/` | Contas a receber, baixas, recebimentos |
| `contasapagar/` | Contas a pagar, pagamentos |
| `cartoes/` | Conciliação e movimentação de cartões |
| `chequepre/` | Cheques pré-datados |
| `chequeemitido/` | Cheques emitidos |
| `pix/` | Operações PIX no desktop |
| `gerais/` | Utilitários e integrações externas |

## Integração Yapay (`gerais/api.yapay/`)

Única DLL compilada neste módulo: `Yapay.Api.Rest.dll` (gerada de `api.rest/Yapay.Api.Rest.dpr`). O subdiretório `demo/` contém um executável de demonstração isolado — não é parte do ERP.

## Integração com outros módulos

- **Faturamento → Financeiro**: o módulo de faturamento gera títulos (contas a receber) que são processados aqui.
- **Financeiro → libCartoes**: conciliação de cartões consome as DLLs de adquirentes em `libCartoes/`.
- **Financeiro → libIntegracaoPixCitel**: operações PIX desktop (`pix/`) delegam para a lib de integração Citel.
- **Financeiro → libIntegracaoContasBancarias**: extrato bancário e open banking via a lib de contas bancárias.

## Padrões de nomenclatura

- Forms: `Tfrm` + PascalCase, herdando de `TfrmPai` ou `TfrmPaiSimples` — nunca `TForm` direto
- Classes de baixa/lançamento: `untTBaixa<Dominio>.pas`
- Repositórios: `untT<Entidade>Repository.pas`
- Conciliação de cartões: `untConciliacaoCartoes.pas`, `untTMovCarRepository.pas`
- Integração externa: `untIntegracao<Servico>.pas` (ex: `untIntegracaoYapay.pas`)
- Variáveis seguem Hungarian style obrigatório — ver tabela de prefixos no CLAUDE.md raiz
