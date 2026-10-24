# Plano de Execução — Req. 462266

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Inserir, no início de `TfrmCancelamentoDocumentos.fVerificaSalBal` (após o `Exit` do filtro de espécies, antes da montagem do SELECT em `MOVDET`), uma checagem específica para `strEspSel = 'NE'`: consultar `GERELE.GER_TIPXML` e, se corresponder a `xmlEntradaMercadoriasSistemaAnteriorDevolucao` (4), sair permitindo o cancelamento sem rodar a validação de balanço.

Reaproveitar a variável `strSQL` (já declarada na função) para montar o novo SELECT e a variável `qryGenDet` (já declarada e criada via `fCriaQuery(Self)` no início da função) para executar a consulta — a mesma instância é reutilizada depois para o SELECT em `MOVDET` (via `SQL.Clear`).

Padrão de join com `GERELE` (mesmo usado em `fRetAutoIncremGerEle` e `untConsultas.pas:16148`):
- `GER_ESPENT` = `fRetornaEspecieCancelamento(strEspSel)` (para `NE`, resolve para `'NF'` ou `'PD'`)
- `GER_DOCENT` = `strNumDoc`
- `GER_EMPENT` = `VS_strCodEmp`
- `GER_CODFOR` = `strCodCli` (para `NE`, `strCodCli` já é o código do fornecedor — mesma convenção de `fRetSQLCodCli`)
- `IFNULL(B07_SERIE, '') = strSerie` — a série do documento também compõe a chave (mesmo padrão de `fRetAutoIncremGerEle`, que usa `IFNULL(B07_SERIE, "") = :NUMSER`); necessário um novo parâmetro `strSerie` na função, propagado a partir do chamador (`strSerieSel` em `untCancelamentoDocumentos.pas`; `FInput.strSerie` em `untCancelaDocumentos.pas` nas réplicas)

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untCancelamentoDocumentos.pas` | `padra_atualizado/fontes/cancelamento/untCancelamentoDocumentos.pas` | alterar (`fVerificaSalBal`, ~linha 11815) |

## 3. Sequência de implementação

1. Alterar a assinatura de `fVerificaSalBal` (declaração na interface e implementação) para receber também `strSerie`, e no chamador (`pCancelarDocumentos`) passar `strSerieSel`.
2. Logo após o bloco:
   ```pascal
   If (Pos(strEspSel, 'NE_OF_TE_BR_AJ_RQ_TR_DV_NF_EL_NS_IF_IV_D1_MI_FF_PI_UC_TA_TL_CS_CR_GF_GR_GC_GA_NG_NR_EF_RL_') <= 0) Then
   Begin
     Exit;
   End;
   ```
   inserir a checagem de `GERELE`:
   ```pascal
   {Documento de entrada do sistema anterior p/ emissao de devolucao nao gera
    movimentacao real - nao deve ser validado contra a data de balanco.
    Verificar Nota 1 - Req. 462266}
   If (strEspSel = 'NE') Then
   Begin
     strSQL := '';
     strSQL := strSQL + 'SELECT ';
     strSQL := strSQL + '  GER_TIPXML ';
     strSQL := strSQL + 'FROM ';
     strSQL := strSQL + '  GERELE ';
     strSQL := strSQL + 'WHERE ';
     strSQL := strSQL + '  GER_ESPENT = :ESPENT AND ';
     strSQL := strSQL + '  GER_DOCENT = :DOCENT AND ';
     strSQL := strSQL + '  GER_EMPENT = :EMPENT AND ';
     strSQL := strSQL + '  GER_CODFOR = :CODFOR AND ';
     strSQL := strSQL + '  IFNULL(B07_SERIE, '''') = :SERIE ';

     With qryGenDet Do
     Begin
       Close;
       SQL.Clear;
       SQL.Add(strSQL);
       ParamByName('ESPENT').AsString := fRetornaEspecieCancelamento(strEspSel);
       ParamByName('DOCENT').AsString := strNumDoc;
       ParamByName('EMPENT').AsString := VS_strCodEmp;
       ParamByName('CODFOR').AsString := strCodCli;
       ParamByName('SERIE').AsString  := strSerie;
       Open;

       If (Not IsEmpty) And (FieldByName('GER_TIPXML').AsInteger = Ord(xmlEntradaMercadoriasSistemaAnteriorDevolucao)) Then
       Begin
         Close;
         Exit;
       End;

       Close;
     End;
   End;
   ```
4. Manter o restante da função inalterado — o SELECT em `MOVDET` já faz `SQL.Clear` antes de montar sua própria query, então a reutilização de `qryGenDet` é segura.
5. Validar manualmente com a NF 883370 (COMAX, LJ001) ou massa equivalente: `GERELE.GER_TIPXML = 4` para o documento e série/documento correspondentes → cancelamento não deve mais exibir a mensagem de bloqueio.
6. Validar que um `NE` comum (`GER_TIPXML <> 4`) com item cuja `DET_DTAENT` seja anterior ao balanço continua bloqueando (regressão).

## 4. Conformidade com padrões do projeto

- Zona Legado: Hungarian style, `p`/`f` prefixos — não se aplica alteração de nomenclatura, só inclusão de bloco na função existente.
- `ParamByName()` — sem concatenação de valor no SQL (mantido).
- Sem uso de `Now()`/`NOW()` — não se aplica.
- `untTypesSistema` já está no `uses` da unit — `xmlEntradaMercadoriasSistemaAnteriorDevolucao` é acessível diretamente, sem precisar adicionar unit.
- Comentário no fonte deve ser curto + referência cruzada `Verificar Nota N - Req. NNNNNN` (ver seção "Notas Referenciadas no Código-Fonte" a ser gerada por `/citel-resumoAnaliseRequisito`).

## 5. Estratégia de testes

- Não há suíte DUnit específica para `untCancelamentoDocumentos.pas` neste projeto — validação manual via tela de Cancelamento de Documentos.
- Casos a cobrir:
  1. `NE` com `GER_TIPXML = 4` (mesma série/documento/empresa/fornecedor) e item com `DET_DTAENT` < data de balanço → deve permitir cancelamento.
  2. `NE` com `GER_TIPXML <> 4`, ou registro em `GERELE` de série diferente (sem correspondência), com item com `DET_DTAENT` < data de balanço → deve continuar bloqueando (regressão).
  3. `NE` sem nenhum item com `DET_DTAENT` < data de balanço → deve permitir cancelamento (comportamento já correto, não deve regredir).
  4. Outras espécies (`OF`, `NF`, `TE`, etc.) → sem alteração de comportamento.

## 6. Riscos e mitigação

- Risco: campo/join errado no `GERELE` (`GER_CODFOR` vs `GER_CODCLI`, ou série ausente na chave) → mitigado replicando exatamente o padrão já usado em `fRetAutoIncremGerEle` / `untConsultas.pas`, incluindo `B07_SERIE` (com `IFNULL`, pois pode ser nulo) para não casar documentos de séries diferentes.
- Risco: reutilização de `qryGenDet` sem `Close`/`SQL.Clear` correto antes do segundo uso → mitigado mantendo o `SQL.Clear` já existente no bloco de `MOVDET`.
- Risco: réplica manual em `379.48.2.30.74.150` e `379.48.2.30.74.150.100` divergir da assinatura desta unit (`untCancelaDocumentosValidacoes.fVerificaSalBal` recebe `strEspecieCancelamento` já resolvido por parâmetro, e retorna mensagem por `var strMessage`, em vez de chamar `fMensagem` diretamente) → detalhado na Fase de replicação em `tasks.md`; adaptar a assinatura em cada projeto, não copiar o trecho literalmente.
- Risco: alterar a assinatura de `fVerificaSalBal` (novo parâmetro `strSerie`) pode quebrar outros chamadores não identificados → mitigado confirmando, em cada projeto, que existe um único ponto de chamada (`pCancelarDocumentos` em 74.150.45; `TCancelamentoDocumentosService`/`untCancelaDocumentos.pas` nas réplicas) antes de alterar a assinatura.
