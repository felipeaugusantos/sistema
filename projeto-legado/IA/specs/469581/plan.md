# Plano de Execução — Req. 469581

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica
Duas camadas independentes de proteção:
1. **Banco:** UK em AGEDOC — não depende de versão de executável nem de caminho de código.
2. **Aplicação:** trava por NF no Recebimento de Entrega Agendada, na carga do agendamento (`fCarregaDocumentos`), ponto comum ao fluxo (`FormShow` → `pCarregaDocumentoExterno` → Enter em `edtCodigo` → `fValidaCampos`) e ao menu. Reaproveita `fLock_Unlock` (untFuncoesSimples), mesmo padrão da trava `strTrava` já existente.

Mudança mínima em `untCadAgendamentodeEntrega`: tratar o erro 1062 no `btnGravarClick`.

## 2. Arquivos impactados
| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untRecebimentoEntregaAgendada | padra_atualizado/fontes/movimentacaoitens | alterar |
| untCadAgendamentodeEntrega | padra_atualizado/fontes/cadastros | alterar (tratamento do 1062) |
| Script da UK | — | apenas em tela (sem arquivo) |

Working copies: `379.48.2.30.74.150.45` (base), `379.48.2.30.74.150`, `379.48.2.30.74.150.100`. As duas últimas têm as mesmas units; no Recebimento a trava existente está nas linhas 500 e 562 (+2 em relação à .45).

## 3. Sequência de implementação
1. Em `untRecebimentoEntregaAgendada`: campo privado `TStringList` (lista de chaves de NF travadas), criado no `FormCreate`, liberado em `FormDestroy` novo (try/finally).
2. Função privada que trava todas as NFs do `cdsAgeDoc` (tudo ou nada, RN03) e procedure que destrava a lista.
3. Chamar a função em `fCarregaDocumentos` logo após a trava `strTrava` existente; em falha: `fMensagem` com `fGetHostLock`, `edtCodigo.Clear`, `cdsAgeDoc.Close`, `Result := False`, `Exit`.
4. Liberação das travas por NF (procedure de destrava chamada em cada ponto):
   - `pLimpaAgendamento` — já executado após `fCommit` em `btnConfirmaClick`, no cancelamento do `FormClose` e nos retornos antecipados de `fCarregaDocumentos`.
   - `btnConfirmaClick` — no `except` (erro/exceção) e no ramo de rollback por falha do plano (`blnResult = False`): liberar as travas e limpar o recebimento (`pLimpaDocumento` + `pLimpaAgendamento`), para o operador recarregar o agendamento.
   - `FormClose` — quando o fechamento é efetivado (`Action <> caNone`), liberar antes de fechar; `FormDestroy` como garantia final.
   - Exclusão de documento do grid — não se aplica ao Recebimento: o grid é somente leitura (`OptionsData.Deleting = False`, sem `OnKeyDown/OnKeyUp`). A remoção por tecla Delete existe só no form de agendamento (`cxgDocumentosTableViewKeyUp` → `pRemoverDocDaLista`), onde não há trava por NF.
5. Em `btnConfirmaClick`, antes de `fStartTransaction`, conferir que as travas são da conexão atual (RN04); abortar com mensagem se não forem.
6. Em `untCadAgendamentodeEntrega.btnGravarClick`, no `except`, reconhecer o erro 1062 e exibir mensagem clara de documento já em outro agendamento (mantendo `fRollback`).
7. Aplicar o script da UK (exibido em tela) no banco, após limpeza manual de duplicados:
   ```sql
   ALTER TABLE AGEDOC
     ADD UNIQUE KEY UK_AGEDOC_01 (ADC_NUMDOC, ADC_ESPDOC, ADC_SERIE_, ADC_CODFOR, ADC_CODEMP);
   ```
8. Replicar os passos 1–6 em `379.48.2.30.74.150` e `379.48.2.30.74.150.100`, conferindo contexto antes de cada alteração (linhas diferem).

## 4. Conformidade com padrões do projeto
- Zona Legado: Hungarian (`str`, `bln`, `lst`), prefixos `F` (campo privado), `p`/`f` (métodos), identificadores sem número do requisito; seguir o estilo da unit (capitalização `If/Then/Begin`).
- Chamadas: `fMensagem`, `pSetFocus`, `fLock_Unlock`, `fGetHostLock`; `fNow()` se houver data/hora; sem `.SetFocus`, `ActiveControl :=`, `Application.CreateForm`.
- SQL (se houver): `ParamByName()`, sem concatenação.
- `try/finally` na `TStringList`; lógica de negócio fora dos eventos `OnClick` (usar métodos).
- Pre-commit: sem componentes/chamadas/SQL proibidos.
- Encoding: cp1252 + CRLF; edição somente via Python com `io.open(..., encoding='cp1252', newline='')`; validar depois (decodifica sem erro, sem `\xef\xbf\xbd`).
- Se precisar de comentário explicativo longo, usar o padrão "comentário curto + Verificar Nota N - Req. 469581".

## 5. Estratégia de testes
- Não há suite DUnit para estas units; validação manual.
- Casos:
  - Dois agendamentos com a mesma NF (base sem UK): estação A carrega pelo fluxo, estação B pelo menu → B bloqueada com nome do host.
  - Inverso (A pelo menu, B pelo fluxo).
  - Confirmar recebimento em A → B passa a conseguir carregar.
  - Cancelar recebimento carregado (FormClose) libera a trava.
  - Agendamento com 2+ NFs, 2ª travada por outra estação → 1ª liberada.
  - Com a UK: gravar a mesma NF em dois agendamentos → mensagem clara, sem gravação parcial.
  - Repetir os cenários em 74.150 e 74.150.100.

## 6. Riscos e mitigação
- Trava presa por queda da estação → mesmo mecanismo das travas existentes; liberar pela rotina padrão de limpeza de locks.
- Chamadas de trava em lote na carga → aceito; agendamentos costumam ter poucas NFs.
- UK com duplicados remanescentes → ajuste manual prévio no cliente (fora do escopo).
- Linhas divergentes entre as working copies → ler o contexto ao redor antes de alterar em cada projeto.
