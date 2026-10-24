# Plano de Execução — Req. 470363

**Referência:** spec.md
**Zona:** Legado (`fontes\`) + `libTefCitel`

## 1. Abordagem técnica

A confirmação do cartão tem três desfechos: **confirmada**, **falhou com erro** (outros erros, que continuam como hoje) e **não realizada** (novo: canal fora, ou serviço reiniciado). O terceiro é sinalizado pela DLL por uma interface separada, consultada pelo autcom logo depois de `fFinalizarTransacao`. Assim:

- a assinatura de `ITefCitel` não muda (procedure sem retorno, regra 2 do contrato EXE ↔ DLL);
- `TTefCitelNCR`/`TTefCitel` não são tocadas (lock do 418470); sem a interface (`Supports` = False), o autcom segue o caminho atual;
- nenhuma exceção atravessa a fronteira EXE/DLL nesses casos.

Detecção de reinício: hoje só a resposta do `reata` (com a instância conhecida preenchida) e o `loginNecessario` ligam `FintServicoReiniciou`. A finalização usa os dois detectores existentes; nenhum detector novo.

## 2. Arquivos impactados
| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untInterfaceTefCitel` | `libTefCitel\untInterfaceTefCitel.pas` | alterar — declarar a interface nova (GUID) no fim da seção de tipos |
| `untTefCitelDvc` | `libTefCitel\untTefCitelDvc.pas` | alterar — RF01–RF05 |
| `untTefCitelDvcTransporte` | `libTefCitel\untTefCitelDvcTransporte.pas` | alterar — RF08 (só lado autcom) |
| `untTefCitelUtil` | `padra_atualizado\fontes\tef\TefCitel\untTefCitelUtil.pas` | alterar — RF06, nas 5 versões |

`libTefCitel` = external `svn://srvprg1.citelsoftware.com.br/libTefCitel`, o mesmo nas .72, .74.111, .74.150, .150.45 e .150.100: um commit. `untTefCitelUtil.pas` é por versão: altera na principal e porta.

## 3. Sequência de implementação
1. Parada 2: feita (15/10).
2. `fChamaRpcUmaVez`: `ETefCitelDvcTransporte` do envio → retirar a chamada do `FdictChamadas` e levantar `ETefCitelDvcCanal` (RF01).
3. `pInfo21`/`pInfo30`: capturar `ETefCitelDvcCanal` e só registrar no log do DVC (RF02).
4. Interface nova + implementação em `TTefCitelDvc`; `fFinalizarTransacao` zera o estado na entrada e marca "não realizada" no ramo de canal e no de reinício; `pRefazTefSeServicoReiniciou` não guarda o aviso quando o método é `fFinalizarTransacao` (RF03–RF05, RN04).
6. `fFinalizaCartao`: depois de `pFinalizaTranscacao(True, …)`, `Supports(objTefCitel, <interface>)` e, se "não realizada", `fMensagem` (RN01) e pular `pGravaTransacaoFinalizada` (RF06).
7. Transporte: CRC inválido / tamanho fora do limite → descartar e ressincronizar sem `pOnDesconectado` (RF08).
8. Parada 3 (o usuário compila e valida); porte de `untTefCitelUtil.pas` para as outras 4 versões; conferência por hash.

## 4. Conformidade com padrões do projeto
- Legado: Hungarian, prefixos `p`/`f`, `A` em parâmetro, `F` em campo; `const` em parâmetro não alterado.
- `fMensagem` para o operador; nunca `raise`; sem LOGERR nem log novo (só o log do DVC existente).
- Interface com GUID; nada inserido no meio de `ITefCitel`/`ITefCitelV2`/records da fronteira.
- `IA\rules\tef-dvc.md`: sem timeout sobre o pinpad; formato do quadro inalterado (a estação não muda).
- `.pas` com acento: `fonte_delphi.py conferir`/`substituir` (regra 9).
- Pre-commit: sem `Now`, `StrToFloat`, `.SetFocus`, `Application.CreateForm`.

## 5. Estratégia de testes
Legado sem infraestrutura de teste: roteiro manual, conferindo TEFTRA, MOVCAR, LOGERR e o log do DVC.
- CA01: queda de RDP depois da aprovação, antes de confirmar (derrubar a sessão do cliente RDP).
- CA02: reiniciar o PC da estação antes de confirmar; reconectar; concluir.
- CA03: vendas normais (débito, crédito à vista, parcelado, 2 cartões).
- CA04: queda durante a passagem de cartão.
- CA05: quadro corrompido — log em nível diagnóstico, ou validação pelo mecanismo.
- CA06: estação com TEF clássico.

## 6. Riscos e mitigação
- Ressincronização (RF08) descarta quadros válidos colados → reenvio por ACK (2 s); a causa real fica para o log diagnóstico.
- Commit da `libTefCitel` arrastar as alterações do 418470 na .150 → listar os paths explicitamente no DelphAI.
