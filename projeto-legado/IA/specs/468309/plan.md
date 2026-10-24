# Plano de Execução — Req. 468309

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica
Portar de forma cirúrgica, para a 74.111, apenas o que é de retenção dos requisitos 432369 (r473009) e 465130 (r498495) da 74.150:
- copiar `untLancamentoRetencoes.pas` (classe `TRetencoesNoFrame`) e usá-la só na importação de NFS-e;
- ajustar `untEntImpNFSe.pas` à mão (o `svn patch` rejeita a maioria dos hunks porque os arquivos divergem por outros requisitos);
- adicionar a tag `FIS_TRPICO` em `untXMLNFSePadrao.pas`.

## 2. Arquivos impactados
| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untLancamentoRetencoes | padra_atualizado/fontes/cadastros/untLancamentoRetencoes.pas | criar (cópia da 74.150) |
| untEntImpNFSe | padra_atualizado/fontes/movimentacaoitens/untEntImpNFSe.pas | alterar |
| untXMLNFSePadrao | padra_atualizado/fontes/movimentacaoitens/untXMLNFSePadrao.pas | alterar |
| autcom.dpr | padra_atualizado/autcom.dpr | alterar (incluir a nova unit) |

## 3. Sequência de implementação
1. Conferir dependências da nova unit na 74.111 (`untCtaDet`, `untTypesSistema`, `untTCadPag`, `untLogCtp`, `untZClient`, `untCadPag`, `Shared.Core`) e as colunas no banco (FORRET, RETFIS, CTPDET, CADPAG, CADFIS).
2. Copiar `untLancamentoRetencoes.pas` (cp1252/CRLF, cópia binária) e incluir no `autcom.dpr`.
3. `untXMLNFSePadrao.pas`: enum `FIS_TRPICO` e mapeamento `...piscofins;tpRetPisCofins` nos layouts Nacional V1 e V1.1.
4. `untEntImpNFSe.pas`:
   - `uses untLancamentoRetencoes`; campos `FPisCofDefXML`, `FValorPIS`, `FValorCofins`, `FHisRet`, `FblnGravarPagamentoRetido`;
   - campos temporários `PCXMLD`, `VALPIS`, `VALCOF` (arrCampos/arrDataTypes/arrTamanhos 163 → 166) e leitura/gravação em `pAtualizaDados`/`pEnviaDados`;
   - `pCarregaArquivoNFSeXML`: tratamento de `tpRetPisCofins`;
   - `pCalculaPisCofins`: PIS/COFINS não retidos como apuração própria;
   - `fConfirmaImportacao`: criar o frame por documento, `pCalcularRetencoes`, `fDigDuplic` com `fValorTotalLiquido`, `fCriarParcelasRetencoesFornecedor`, liberar o frame;
   - métodos novos `pCalcularRetencoes`, `fValorTotalLiquido`, `pZerarValorComRetencao`.
5. Validar encoding (decodifica em cp1252, sem U+FFFD) e `svn diff` com só as alterações pretendidas.
6. Conferir compilação (`compilar_delphi.py --conferir-units`).
7. Replicar na working copy `74.Fechadas/74.111.Fechadas/379.48.2.30.74.111.184` (ver tasks.md).

## 4. Conformidade com padrões do projeto
- Zona Legado: Hungarian style e prefixos `F`/`L`/`p`/`f`, igual ao restante da unit; identificadores sem número de requisito.
- Sem componentes/chamadas proibidos; sem `.SetFocus`, `StrToFloat`, `Now`, `Application.CreateForm`; SQL da nova unit usa `ParamByName` (um `SELECT` em CADPAG por concatenação de `AIncCTP`, vindo do código; ver risco).
- Pre-commit: sem `FOREIGN_KEY_CHECKS`; nenhum `.dfm` alterado.

## 5. Estratégia de testes
- Suite: não há teste automatizado dessa rotina; validação manual na tela Importação de NFS-e.
- Casos: fornecedor com FORRET (duplicata líquida + títulos de retenção); fornecedor sem FORRET (sem mudança); XML nacional sem `tpRetPisCofins` (apuração própria); XML nacional com `tpRetPisCofins = 3` (retido); ISS retido (zera `FIS_VALISS`).

## 6. Riscos e mitigação
- Compilação: a unit usa funções de `untCadPag`/`untLogCtp` → conferir com `--conferir-units`.
- `lQryCadPag.SQL.Text := 'SELECT * FROM CADPAG WHERE AUTOINCREM = "'+AIncCTP+'"'` (concatenação, herdado da 74.150): valor vem do código, não do usuário; registrar para revisão futura.
- A cópia de `untLancamentoRetencoes.pas` difere da 74.150 na chamada de `fGravaCadPag` (assinatura da 74.111; na 184 sem `AUsaMca`) e em `fIncluiRETFIS`, onde `RET_CODPOR` vazio vai NULL (senão viola a FK_RETFIS_05 quando FORRET não tem portador; a 74.150 tem o mesmo problema latente).
- O r495652 (Req. 453146) vem junto na unit; revisar o que ele altera.
- Divergência entre 74.111 e 74.150 em `untEntImpNFSe.pas`: portar só o necessário e não misturar outros requisitos.
