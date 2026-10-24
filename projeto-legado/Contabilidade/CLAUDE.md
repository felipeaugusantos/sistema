# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Módulo Contabilidade

Módulo com **arquitetura limpa** — o mais bem estruturado do projeto. Diferente dos demais módulos VCL legados, usa **namespaces nos nomes de arquivo** com prefixo `Contabilidade.`.

## Estrutura de camadas

```
Contabilidade/
  Interfaces/    → contratos (IRepository, IService, etc.)
  Classes/       → implementações de domínio e serviços
  Repositories/  → acesso a dados
  Services/      → regras de negócio
  Factories/     → criação de objetos
  Model/         → tipos e estruturas de dados
  View/          → formulários VCL
  Scripts/       → stored procedures SQL
  Outros/        → utilitários, log, trace
```

## Convenção de nomenclatura

Todos os arquivos seguem o padrão `Contabilidade.<Camada>.<NomeClasse>.pas`:

- `Contabilidade.Interfaces.ApuracaoLucroPresumido.pas`
- `Contabilidade.Classes.TGeradorContabil.pas`
- `Contabilidade.Classes.TVinculoPlanoContabilService.pas`
- `Contabilidade.Classes.TVinculoPlanoContabilRepo.pas`

Classes de domínio usam prefixo `T`. Interfaces na pasta `Interfaces/` sem prefixo `I` no nome do arquivo, mas com prefixo `I` na declaração interna:
- Arquivo: `Contabilidade.Interfaces.ApuracaoLucroPresumido.pas`
- Declaração interna: `IApuracaoLucroPresumido = interface ['{GUID}']`

## Domínios implementados

Apuração de Lucro Presumido, Demonstração de Valor Adicionado, Vínculos de Plano Contábil, lançamentos contábeis (CPC, AJE), Imposto de Renda, Lucro Presumido.

## Observação

Este módulo **não tem `.dpr` próprio** — é uma biblioteca de units referenciada pela aplicação principal (`padra_atualizado`).
