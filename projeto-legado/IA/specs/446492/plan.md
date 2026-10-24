# Plano de Execução — Req. 446492

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

O fluxo passa por três camadas. A **biblioteca** seleciona, agrupa e checa duplicidade. A **interface nova** leva os dados de cada venda ao Autcom. A **Manutenção de Cartões** do Autcom pré-preenche, valida e grava. A gravação do `MOVCAR` continua sendo da Manutenção de Cartões, sem insert paralelo na lib.

```
TfrmMercadoLivreBaixaRecebiveisMkt
  btnIncluirVendasNaoEncontradas   visível: há inconsistência "não encontrada" E Supports(VS_FuncoesExternas, ILibCartoesWrapperMarketplace)
    -> TfrmMercadoLivreVendasNaoEncontradas    um pedido por linha, checkbox, Marcar/Desmarcar todos, Confirmar
    -> TMercadoLivreInclusaoVendas
         valida CFG_MERCAR (RN01)
         agrupa por MER_SHP_ID (RN02); maquininha = 1 parcela (RN06)
         por envio: já existe MOVCAR? -> pula (RN08)
                    senão monta JSON (empresa, parcelas[valores, ORDEID], NSU, datas, cartões da CFG)
                    -> ILibCartoesWrapperMarketplace.fIIncluirCartaoVendaMarketplace(JSON): Boolean
                       cancelou -> pergunta: segue/interrompe (RF05)
         resumo (gravadas/canceladas/puladas) -> recarrega a conciliação (RF06)

TILibCartoesAutcom (trunk/Autcom) implementa ILibCartoesWrapperMarketplace
  -> pCriarFormularios(TfrmCadMovCartoes) ; CarregaVendaMarketplace(JSON) ; ShowModal ; Result := gravou

TfrmCadMovCartoes.CarregaVendaMarketplace
  preenche empresa, valores, parcelas A/B, MCA_ORDEID, NSU, datas; cartão se único na CFG
  ao gravar, neste modo: cartão ∈ CFG_MERCAR da empresa (RN07)
```

**Compatibilidade (RN09):** a interface nova tem GUID próprio e unit própria, e a `ILibCartoesWrapper` atual **não muda**. Se o Autcom não implementa a interface, `Supports` falha e o botão fica oculto.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untILibCartoesWrapperMarketplace.pas` | `libCartoes/libCentralizado/interfaces/` | criar: interface com GUID e `fIIncluirCartaoVendaMarketplace(const AJsonVenda: String): Boolean` |
| `untTLibCartoesAutcom.pas` | `libCartoesProjetos-v2/trunk/Autcom/` | alterar: `TILibCartoesAutcom` implementa a interface nova |
| `untCadMovCartoes.pas` (e `.dfm` se preciso) | `padra_atualizado/fontes/financeiro/cartoes/` — `.150`, `.150.100`, `.150.45` | alterar: `CarregaVendaMarketplace` e validação do cartão na gravação |
| `untTMercadoLivreInclusaoVendas.pas` | `libCartoes/libCartoesMercadoLivre/recebiveis/` | criar: agrupamento, duplicidade, chamada da interface, resumo |
| `untMercadoLivreVendasNaoEncontradas.pas/.dfm` | `libCartoes/libCartoesMercadoLivre/recebiveis/views/` | criar: tela de seleção (`TfrmPai`, `TcxGridCitel`, `TBitBtnLocked`) |
| `untMercadoLivreBaixaRecebiveisMkt.pas/.dfm` | `libCartoes/libCartoesMercadoLivre/recebiveis/views/` | alterar: botão, visibilidade, chamada e recarga |
| `libCartoesMercadoLivre.dpr` | `libCartoes/libCartoesMercadoLivre/` | alterar: `uses` das units novas |
| `.dpr` que compila `untTLibCartoesAutcom` / `autcom.dpr` | conforme o projeto | alterar só o `uses`, se a unit nova da interface precisar entrar |

### Desvios do plano original, decididos na implementação (08/10/2026)

- **Sem unit nova de interface.** O Autcom não importa a interface da lib: mantém uma cópia com o mesmo GUID (`trunk/Autcom/untInterfacesLibCartoesAutcom.pas`). A `ILibCartoesMarketplace` (GUID `{D833374A-D22C-4AF3-8DB2-24301F210F7D}`) entrou como **tipo novo** nas duas units existentes, `libCentralizado/interfaces/untILibCartoesWrapper.pas` e `untInterfacesLibCartoesAutcom.pas`, sem alterar a `ILibCartoes`.
- **Guarda de compilação.** `trunk/Autcom` também é compilado por `.111` e `.150.CONFE`, que não terão a Manutenção de Cartões nova. Por isso `TILibCartoesAutcom` só declara e implementa a interface nova sob `{$IF Declared(VS_INCLUSAO_VENDA_MARKETPLACE_EXISTE)}`. A constante fica em `padra_atualizado/fontes/genericos/untFuncoesSimples.pas` (mesmo padrão de `VS_MAIXA_RECEBIVEIS_ML`) e entra **nas mesmas versões** que a `untCadMovCartoes` nova. Sem ela, o botão fica oculto e o build continua passando.
- **Arquivos a mais por versão:** `untFuncoesSimples.pas` (constante) acompanha a `untCadMovCartoes.pas` no porte para `.150.100` e `.150.45`.
- **Modo novo da Manutenção de Cartões** reaproveita as guardas do modo extrato (`FExtratoVendaCartao`) por meio de `fOrigemExternaCarregada`. Nos três pontos guardados, nem o cliente digitado limpa os campos, nem o cartão recalcula taxa ou vencimento.

## 3. Sequência de implementação

1. Atualizar as cópias e conferir os locks; confirmar no fonte se o dataset da conciliação tem `MER_ORD_ID` por linha (senão, buscar em `MER_MLPGTO`).
2. Criar a interface nova (`libCentralizado`).
3. Na `.150`: `TfrmCadMovCartoes.CarregaVendaMarketplace` + validação do cartão na `CFG_MERCAR`.
4. `TILibCartoesAutcom` implementa a interface (`trunk/Autcom`).
5. Criar `TMercadoLivreInclusaoVendas` e a tela `TfrmMercadoLivreVendasNaoEncontradas`.
6. Botão na conciliação: visibilidade (inconsistência + `Supports`), chamada, resumo e recarga.
7. Compilar e validar na `.150` com o roteiro (seção 5).
8. Portar `untCadMovCartoes` para `.150.100` e `.150.45`, conferindo por `svn diff` e hash.

## 4. Conformidade com padrões do projeto

- **Zona Legado:** Hungarian (`strNsu`, `cdsVendas`, `lstEnvios`), prefixos `p`/`f`, `F`/`A`; forms herdam de `TfrmPai`; SQL com `.SQL.Text` + `ParamByName`.
- **Componentes:** `TBitBtnLocked` (sem `TButton`/`TBitBtn`), `TcxGridCitel` (sem `TDBGrid`), `TUniQuery`/`TUniClientDataSet` (sem `TClientDataSet`/`TDataSetProvider`), sem `dxSkin*`.
- **Chamadas:** `fNow()`, `fStrToFloat()`, `fMensagem()`, `pSetFocus()`, `pCriarFormularios()`, `ParamByName()`; nada de `ActiveControl :=` nem `Application.CreateForm`.
- **Pre-commit:** sem `FOREIGN_KEY_CHECKS`; sem `FillType = ftBrush` / `Outline =` em `.dfm`.
- **Escopo mínimo:** não corrigir o `fIIncluirCartaoVenda` existente; não gravar log novo; avisar por `fMensagem`, nunca `Raise`.
- **Encoding:** `fonte_delphi.py conferir` antes de tocar; acento só por `fonte_delphi.py substituir`/`aplicar`.

## 5. Estratégia de testes

- **Suite:** a zona Legado não tem infraestrutura de teste automatizado; a validação é **manual, com roteiro**, na `.150`, pelo usuário.
- **Casos** (critérios de aceitação da spec): uma venda; várias com Marcar todos; envio com dois pedidos (parcelas A/B); maquininha (1 parcela); `CFG_MERCAR` com vários cartões e cartão fora da lista; `CFG_MERCAR` em branco; cancelar no meio (seguir e interromper); venda já lançada (pulada); recarga e casamento na conciliação seguinte; Autcom sem a interface (botão oculto).
- **Regressão:** conciliação sem inconsistências e baixa normal; Manutenção de Cartões aberta pelo menu; Confirmação de Cartões (`fIIncluirCartaoVenda`) inalterada.

## 6. Riscos e mitigação

- Conflito com os Reqs. 466823/467374 (caique.reboucas) em `untConciliaRecebiveisMercadoLivre.pas` → evitar mexer no motor; concentrar a alteração na view e nas units novas; atualizar antes de editar.
- Lib nova com Autcom antigo → interface separada + `Supports` (botão oculto).
- `MER_ORD_ID` ausente no dataset → buscar em `MER_MLPGTO` por `MER_SHP_ID`/`MER_CODAUT`.
- `untCadMovCartoes` divergente entre as versões → `svn diff` entre `.150`, `.150.100` e `.150.45` antes do porte; ajuste próprio onde divergir.
- Fronteira DLL → strings com `ShareMem` (já é o padrão); JSON evita depender do layout de record entre os binários.
