# Especificação — Req. 468309

**Título:** Importação de NFS-e — retenções no financeiro (duplicata líquida e títulos de retenção) e PIS/COFINS do XML nacional
**Objetivo:** Trazer para a versão 74.111 o tratamento já existente na 74.150 (Req. 432369 e Req. 465130) na rotina Importação de Nota Fiscal de Serviço.
**Zona:** Legado
**Data:** 2026-10-13

## 1. Contexto / problema atual
Na 74.111, `TEntImpNFSe.fConfirmaImportacao` (`untEntImpNFSe.pas`):
- Lança a duplicata (`fDigDuplic`) pelo valor **bruto** (`FValTot` = soma de `FValCo1..5`), com impostos fixos em `0`. As retenções (PIS, COFINS, CSLL, IRRF, INSS, ISS) não são abatidas.
- Não gera títulos de retenção no contas a pagar (CADPAG/CTPDET/RETFIS).
- Em XML do padrão nacional, `vPis`/`vCofins` são o valor do tributo; o código os trata sempre como **retenção** (`FIS_VREPIS`/`FIS_VRECOF`), sem consultar `tpRetPisCofins`.

A 74.150 resolveu isso nos requisitos:
- **432369** (r473009): `TRetencoesNoFrame` (unit `untLancamentoRetencoes.pas`) usada na importação — calcula retenções do fornecedor (FORRET), abate da duplicata e cria os títulos de retenção.
- **465130** (r498495): leitura de `tpRetPisCofins` (`FIS_TRPICO`); PIS/COFINS não retidos viram apuração própria (`FIS_TOTPIS`/`FIS_TOTCOF`).

## 2. Módulos e entidades envolvidos
- Módulo: Movimentação de Itens > Importação de Nota Fiscal de Serviço.
- Units:
  - `padra_atualizado/fontes/cadastros/untLancamentoRetencoes.pas` (nova na 74.111, cópia da 74.150)
  - `padra_atualizado/fontes/movimentacaoitens/untEntImpNFSe.pas`
  - `padra_atualizado/fontes/movimentacaoitens/untXMLNFSePadrao.pas`
  - `padra_atualizado/autcom.dpr`
- Tabelas: FORRET (retenções do fornecedor), RETFIS, CTPDET, CADPAG, CADFIS (`FIS_VREPIS`, `FIS_VRECOF`, `FIS_RECSSL`, `FIS_RETISS`, `FIS_TOTPIS`, `FIS_TOTCOF`...). Colunas conferidas no banco AUTCOM (somente leitura): todas existem.

## 3. Requisitos funcionais
- RF01 — A duplicata principal da NFS-e deve ser lançada pelo valor bruto menos o total das retenções do fornecedor.
- RF02 — Quando o fornecedor tiver retenções cadastradas (FORRET) e o parâmetro de gravação estiver ativo, gerar os títulos de retenção no contas a pagar (CADPAG, CTPDET, RETFIS).
- RF03 — No layout nacional (V1/V1.1), ler `tpRetPisCofins`; PIS/COFINS só são retenção quando o código indicar (1, 3, 4, 5, 6, 7, 9 conforme o tributo).
- RF04 — PIS/COFINS do XML nacional não retidos devem ser gravados como apuração própria (`FIS_TOTPIS`/`FIS_TOTCOF`, com base e alíquota derivadas) e não em `FIS_VREPIS`/`FIS_VRECOF`.
- RF05 — Quando há ISS retido, zerar base, alíquota e valor do ISS (`pZerarValorComRetencao`).

## 4. Regras de negócio
- RN01 — Valor líquido = `FVlServ` (ou `FValCo1` se `FVlServ <= 0`) − total das retenções (`fRetTotalImpostos`). Sem retenções cadastradas, nada é abatido.
- RN02 — Retenções do XML (IRRF, CSLL, INSS, ISS, INSS patronal) prevalecem; se zeradas, vale o cálculo da FORRET.
- RN03 — Fornecedor sem retenção cadastrada: `FblnGravarPagamentoRetido := False` (não gera títulos).
- RN04 — `tpRetPisCofins` ausente = 0 = não retido.

## 5. Requisitos técnicos / não-funcionais
- Arquivos Delphi em cp1252/CRLF; edição somente via Python (sem a ferramenta Edit).
- A criação dos títulos ocorre dentro da transação aberta em `fConfirmaImportacao` (`fStartTransaction`/`fCommit`/`fRollBack`).
- Nova unit incluída no `autcom.dpr` (o `.dproj` é sincronizado pela IDE).
- Sem nomes de identificador com número de requisito.

## 6. Critérios de aceitação
- [ ] Projeto compila (`untEntImpNFSe`, `untLancamentoRetencoes`, `untXMLNFSePadrao`).
- [ ] NFS-e de fornecedor com retenção cadastrada: duplicata = bruto − retenções; títulos de retenção criados.
- [ ] NFS-e de fornecedor sem retenção cadastrada: comportamento igual ao anterior.
- [ ] XML nacional com `vPis`/`vCofins` sem `tpRetPisCofins`: gravados como apuração própria (nota do Req. 465130: líquido 175,51).
- [ ] XML nacional com `tpRetPisCofins = 3`: PIS/COFINS tratados como retidos.

## 7. Fora de escopo
- Rateio do total PIS/COFINS/CSLL informado em `vRetCSLL` quando `vPis`/`vCofins` não vêm no XML (caso NFS-e 54092). Não tratado na 74.150 e adiado.
- Outros requisitos da 74.150 em `untEntImpNFSe.pas` (seleção de empresa por CNPJ, assinatura de `fGravaCadFis` com itens 6 a 8, etc.).
- Alterações em `untCadImpostosNFS.pas` e `untCadLivroFiscal.pas`.

## 8. Dependências e riscos
- `untLancamentoRetencoes.pas` na versão atual da 74.150 inclui alterações do r495652 (Req. 453146), além do r473009.
- `fDigDuplic` da 74.111 tem assinatura diferente da 74.150 (`fltImpost` no lugar de `fltImpFre`/`fltRetIpi`); a chamada foi mantida na assinatura da 74.111.
- O frame é criado por documento do loop de importação (na 74.150 o loop trata um documento).
- O banco de testes tem poucos registros em FORRET (4); testes com PIS/COFINS/CSLL retidos exigem fornecedor com esse cadastro.
