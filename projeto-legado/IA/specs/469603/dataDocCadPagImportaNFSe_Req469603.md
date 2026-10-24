# Análise — Req. 469603 — CTP_DTADOC não preenchido na importação de NFS-e

## 1. Contexto de negócio
Na importação de NFS-e (tela EntImportaNFSe, classe `TEntImpNFSe`), a confirmação gera o lançamento fiscal (CADFIS) e os
títulos a pagar (CADPAG), um por parcela. O campo `CADPAG.CTP_DTADOC` representa a **data do documento** (emissão) do título.
Ele estava saindo `NULL` nos títulos gerados por essa importação.

## 2. Problema e causa raiz
- `untCadPag.pas`, função `fGravaCadPag` (~linhas 826-829): o parâmetro opcional `dtaDtaDoc: TDateTime = 0` grava
  `CTP_DTADOC = Null` quando vale 0 e `AsDateTime := dtaDtaDoc` quando diferente de 0.
- `untEntImpNFSe.pas`, `TEntImpNFSe.fConfirmaImportacao`: a chamada a `fGravaCadPag` é posicional, sem nomes, e o valor
  literal `0` ocupava a posição de `dtaDtaDoc` (4º valor após `fltMulSuj`). Resultado: `CTP_DTADOC` sempre `NULL`.
- Mapeamento dos parâmetros finais (antes da correção): `0` fltMulSuj, `''` strAutIncPix, `0` fltGrvOri, `0` dtaDtaDoc,
  `0` ADtaLiberacao, `0` AHorLiberacao, `''` AOpeLiberacao, `''` AUsaMca, `''` strGnreChaveDeApuracao,
  `strAutIncCadFis` AIncCadFis.

## 3. Origem da data do documento
- Campo da classe `TEntImpNFSe.FDtaDoc`, lido do XML no campo `FIS_DTAENT` do layout de NFS-e (~linha 2464).
- Já é usado como "Data do Documento" na gravação do CADFIS (~linha 1561).
- Sincronizado com a coluna `DTADOC` da grid (`cxgArquivosDTADOC`) em `pEnviaDados` (~1023) e `pAtualizaDados` (~1263):
  alteração do usuário na tela também chega ao CADPAG.

## 4. Solução aplicada
- Em `fConfirmaImportacao`, o `0` da posição de `dtaDtaDoc` foi substituído por `FDtaDoc`.
- Os 10 parâmetros finais da chamada (`fltMulSuj` … `AIncCadFis`) receberam comentário de identificação, para evitar novo
  erro de posição.
- `untCadPag.pas` **não** foi alterado (assinatura e lógica mantidas).

| Cópia | Linha de `dtaDtaDoc` após a alteração |
|-------|---------------------------------------|
| 379.48.2.30.74.150.45 | 2058 |
| 379.48.2.30.74.150.100 | 2032 |
| 379.48.2.30.74.150 | 2066 |

### 4.1 Ajuste por diferença de assinatura (74.150.100 e 74.150)
Em 74.150.100 e 74.150, `fGravaCadPag` possui o parâmetro `ATemAne: String = 'N'` entre `AUsaMca` e `strGnreChaveDeApuracao`
(em 74.150.45 ele não existe). A chamada original já estava deslocada uma posição: o `strAutIncCadFis` caía em
`strGnreChaveDeApuracao` (CTP_APUGNR) e `AIncCadFis` (CTP_INCFIS) ficava com o padrão ''. Nessas duas cópias foi inserido o
argumento `'N'` (ATemAne) antes de `strGnreChaveDeApuracao`, de modo que `strAutIncCadFis` chega em `AIncCadFis`, e os
comentários foram corrigidos. Os 10 comentários da primeira versão (iguais nas 3 cópias) estavam errados nessas duas cópias.
Efeito: CTP_APUGNR deixa de receber o autoincremento do CADFIS (evita o DELETE da GNRE por CTP_APUGNR atingir esses títulos),
CTP_INCFIS passa a vincular o título ao lançamento fiscal e CTP_TEMANE passa a 'N' em vez de vazio.
Lição: conferir a assinatura de `fGravaCadPag` em cada cópia antes de replicar o mapeamento de parâmetros.

## 5. Decisões de escopo
- Não há quarto diretório (o texto original do requisito citava 4 por engano).
- Não foi feita correção retroativa dos títulos já gravados com `CTP_DTADOC` nulo.
- Outros chamadores de `fGravaCadPag` não são afetados.
- Títulos antigos continuam funcionando: `untCadPag.pas` (~linha 1369) usa `CTP_CODCAD` como alternativa quando
  `CTP_DTADOC` é nulo.

## 6. Ressalvas
- Confirmar que `FIS_DTAENT` do layout XML do município corresponde à data de emissão da NFS-e.
- Arquivo `untEntImpNFSe.pas` em cp1252/CRLF: edição feita via Python com encoding explícito, validada sem U+FFFD.
- Alteração não compilada nem testada na importação real até o registro deste documento.

## 7. Achados colaterais não corrigidos
- A chamada a `fGravaCadPag` usa ~70 parâmetros posicionais, sujeita a erros desse tipo; apenas os 10 finais foram
  comentados neste requisito.

## NOTAS REFERENCIADAS NO CÓDIGO-FONTE
Nenhuma nota: os comentários inseridos são apenas identificadores de parâmetro, sem explicação não óbvia a preservar.
