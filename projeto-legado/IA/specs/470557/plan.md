# Plano de Execução — Req. 470557

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

O trabalho fica dividido em três camadas, nesta ordem de dependência:

- **Telas:** resolvem a lista de empresas.
  - inclusão: a raiz, por `fObtemEmpresasFiliais`, ou só a empresa;
  - exclusão: as empresas da raiz que têm fechamento na data.
- **Classes:** ganham métodos novos que recebem `TConsultasArray` e fazem a operação inteira, tudo ou nada:
  1. travar todas as empresas;
  2. validar todas;
  3. uma transação;
  4. gravar ou excluir cada uma pelo `pIncluiFechamento` / `pExcluiFechamento` existente;
  5. commit;
  6. liberar as travas no `finally`.
- **Métodos atuais:** `fIncluiFechamento`, `fExcluiFechamento`, `IncluiFechamento` (as duas sobrecargas) e `ExcluiFechamento` ficam **intocados**. O `TOutrosFechamentos` (contábil anual) depende deles.

`Contabilidade\` não muda: só se usa `fObtemEmpresasFiliais` (em `Contabilidade.Funcoes`, já no `autcom.dpr`) nas telas, que só existem no `autcom.dpr`. As classes não ganham dependência nova (`TConsultasArray` vem de `untTypesSistema`, já usada).

### Métodos novos (nomes indicativos)

| Classe | Inclusão | Exclusão | Apoio |
|---|---|---|---|
| `TFechamentoFiscal` | `fIncluiFechamentoRaiz(const AarrEmp: TConsultasArray; dtaDtaRef: TDate): Boolean` | `fExcluiFechamentoRaiz(const AarrEmp: TConsultasArray; dtaDtaRef: TDate): Boolean` | `fEmpresasComFechamento(const AarrEmp: TConsultasArray; dtaDtaRef: TDate): TConsultasArray` |
| `TFechamentoEstoque` | `fIncluiFechamentoRaiz(const AarrEmp; intAno, intMes)` | `fExcluiFechamentoRaiz(const AarrEmp; intAno, intMes)` | `fEmpresasComFechamento(const AarrEmp; intAno, intMes)` |
| `TFechamentoFinanceiro` | `IncluiFechamentoRaiz(const AarrEmp; ADataRef)` | `ExcluiFechamentoRaiz(const AarrEmp; ADataRef)` | `EmpresasComFechamento(const AarrEmp; ADataRef)` |

Detalhes:

- **Validação por empresa:** a mesma regra do método atual (RN02/RN03), com o código da empresa na mensagem. A primeira falha encerra sem gravar.
- **Exclusão:** `TOutrosFechamentos.fPodeDeletarFechamento` por empresa, antes da transação.
- **Travas:**
  - `fVeSeTrava…` por empresa, guardando numa lista local as que efetivamente travaram (`FTravou = True` depois da chamada);
  - liberação de cada uma no `finally` (repondo `FTravou := True` antes de `pDestrava…`, porque o campo é um só por objeto).
- **Financeiro, deduplicação (RN04):** é feita na tela (união das raízes das selecionadas, sem repetir `strCodigo`). A classe também ignora código repetido, como garantia.

### Telas

| Tela | Alteração |
|---|---|
| `untIncluiFechamento{Fiscal,Estoque,Financeiro}.dfm` | `chkRaiz: TCheckBox`, com caption "Fechar todas as empresas com a mesma raiz do CNPJ", abaixo ou ao lado da data nova (como no contábil), ajustando a altura do form e `pnlBotoes` |
| `untIncluiFechamento*.pas` — `FormClose` | `chkRaiz` marcada → lista da raiz (CNPJ vazio: só a empresa) → confirmação com a quantidade → método `…Raiz`. Desmarcada → caminho atual |
| `untIncluiFechamentoFinanceiro.pas` | com `chkRaiz` e várias empresas (`arrEmpresa`), une as raízes de cada uma sem repetir |
| `untExcluiFechamento{Fiscal,Estoque,Financeiro}.pas` — `FormClose` | depois das validações atuais: lista da raiz → `fEmpresasComFechamento`. Se houver outra empresa além da informada, `fPergunta('Deseja excluir o fechamento para as outras empresas na mesma raiz?')`: Sim → `fExcluiFechamentoRaiz`; Não → caminho atual |

## 2. Arquivos impactados

Todos em `padra_atualizado\fontes\fechamentosmensais\`:

| Arquivo / Unit | Ação |
|---|---|
| `untFechamentoFiscal.pas` | alterar |
| `untFechamentoEstoque.pas` | alterar |
| `untFechamentoFinanceiro.pas` | alterar (na `.150`, conferir `{$IFDEF LINUX}`) |
| `untIncluiFechamentoFiscal.pas` / `.dfm` | alterar |
| `untIncluiFechamentoEstoque.pas` / `.dfm` | alterar |
| `untIncluiFechamentoFinanceiro.pas` / `.dfm` | alterar |
| `untExcluiFechamentoFiscal.pas` | alterar |
| `untExcluiFechamentoEstoque.pas` | alterar |
| `untExcluiFechamentoFinanceiro.pas` | alterar |

Sem alteração de `.dpr` / `.dproj`, sem DDL.

## 3. Sequência de implementação

1. Locks em `_locks\379.48.2.30.74.150.100\` para as 12 units (9 `.pas` e 3 `.dfm`).
2. `fonte_delphi.py conferir` em cada arquivo, para saber o encoding e se há acento.
3. Fiscal: métodos na classe → tela de inclusão → tela de exclusão.
4. Estoque: idem.
5. Financeiro: idem, com a deduplicação.
6. Parada 3: você compila na IDE e valida pelo roteiro da Parada 2.
7. Porte por `fonte_delphi.py aplicar --comparar`:
   - para a `.150` (unit financeira divergente: aplicar por contexto e compilar também o `FinanceiroServicesAPI` Linux);
   - para a `.150.100.12` (checkout esparso da fechada, com autorização).
8. Review (`code-review.md`) → DelphAI.

## 4. Conformidade com padrões do projeto

- Zona Legado: Hungarian (`arrEmpRaiz`, `lstTravadas`, `blnRaiz`), prefixos `p`/`f`, parâmetros `A`, `const` nos arrays.
- Componentes: `TCheckBox` (permitido; é o mesmo do contábil). Sem `TButton`/`TBitBtn`/`TDBGrid`/`TClientDataSet`.
- Chamadas: `ParamByName` nas consultas novas, `fNow` se houver data de gravação (os métodos internos atuais já cuidam), `pSetFocus` se houver foco, mensagens no padrão da unit (`pMensagemOk`, `fPergunta`).
- Pre-commit: sem `Now`, sem `StrToFloat`, sem `.SetFocus`, sem `ActiveControl :=`, sem `Application.CreateForm`; no `.dfm`, sem `FillType`/`Outline`.
- Escopo mínimo: nada além do necessário nos métodos atuais. Defeitos vistos no caminho são relatados, não corrigidos (ex.: a condição do lock no estoque sem parênteses, linha ~450).

## 5. Estratégia de testes

- Suite: não há (zona legado, sem infraestrutura). A validação é manual, pelo roteiro da Parada 2, numa base de homologação com uma raiz de 2 a 3 empresas.
- Casos a cobrir: CA01 a CA10 da spec, em cada módulo quando aplicável. Destaques:
  - CA02 e CA05, com uma empresa travando no meio da lista (não só a primeira);
  - CA07, conferindo `FECFIN` / `LOGFIN` por SQL;
  - CA09, com duas estações;
  - CA10, regressão do contábil anual.

## 6. Riscos e mitigação

- Os métodos atuais são usados pelo contábil anual → não alterá-los; caso CA10 no roteiro.
- `FTravou` é um booleano por objeto → lista local de travas; caso CA09.
- O financeiro compila para Linux na `.150` → compilar o serviço Linux antes de entregar o porte.
- As classes entram em 13 projetos → só métodos novos, sem unit nova; compilar o `autcom` (e, se possível, uma DLL que use as classes, ex.: `libCadastros`).
- Encoding cp1252 → `fonte_delphi.py substituir` / `aplicar`, nunca Edit/Write.
