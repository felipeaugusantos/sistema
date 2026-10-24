unit untDefineCFOP;

interface

uses untTypesCFOP, Shared.Functions.Configuracoes,
  Faturamento.Impostos.Interfaces.ClassificacaoItem.TransferenciaEstoqueEmpresa;

type
  TDefineCFOP = class
  private
    FClassificacao: TAbstractClassificacao;
    FClasseClassificacao: TClassificacaoClass;
    FInput: TInputDefineClassificacaoFiscal;
    FConfiguracoes: IConfiguracoes;
    FTransferenciaEstoqueEmpresa: ITransferenciaEstoqueEmpresaDadosDB;
    procedure AddRegra(const ACondicao: TFunctionRegraCFOP; AClasse: TClassificacaoClass);
    function EhReposicaoClienteGarantia: Boolean;
    procedure ProcessarRegras;
    function GetPrefixoClassificacao : String;
    function EhOperacaoDeUsoEConsumo : Boolean;
    function EhItemSimplesRemessaConcreto: Boolean;
    function EhClienteZonaFrancaOuReducaoBaseIcmsST: Boolean;
    function GetRegraZonaFrancaOuReducaoBaseIcmsST: TClassificacaoClass;
    function EhExcecoesServico: Boolean;
    function EhOperacaoDeSaidaComClienteFilial: Boolean;
    function GetRegraOperacaoSaidaClienteFilial: TClassificacaoClass;
    function EhOperacaoClienteExterior: Boolean;
    function EhOperacaoDeConfirmacaoDeAjustes: Boolean;
    procedure InicializarDadosQuandoOperacaoDeConfirmacaoDeAjustes;
    function EhOperacaoDeNotaEspecialTintometricoEspiritoSanto: Boolean;
    function EhOperacaoRecebimentoGarantiaOutrasEntradas: Boolean;
    function EhOperacaoDeEnvioGarantiaFornecedor: Boolean;
    function EhOperacaoComBrinde: Boolean;
    function EhOperacaoDeEntregaFutura : Boolean;
    function EhOperacaoComConsumidorForaDoEstadoOuAtendeDifal : Boolean;
    function EhOperacaoNotaEspecialVendaABaseDeTroca: Boolean;
    function EhOperacaoAmostraGratis: Boolean;
    function EhOperacaoDeNotaDeComplementoDeClienteComplementandoValor: Boolean;
    function EhOperacaoDeComplementoFornecedorValor: Boolean;
    function EhOperacaoDeOutrasSaidasParaConserto: Boolean;
    function EhOperacaoDeNotaDeImportacao: Boolean;
    function EhOperacaoDeConsignacaoEnvio: Boolean;
    function EhOperacaoAkzoNobel: Boolean;
    function EhOperacaoDeEmprestimo: Boolean;
    function EhOperacaoOrdemDeProducaoAvulsaTintometrico: Boolean;
    function EhOperacaoRemessaEstoqueExterno: Boolean;
    function EhOperacaoDeBaixaRefugo: Boolean;
    function EhOperacaoDevolucaoOuOutrasEntradas: Boolean;
    function EhOperacaoDevolucaoDemonstracao: Boolean;
    function EhOperacaoDePedidoComBonificacao: Boolean;
    function EhOperacaoDePedidoComDemonstracao: Boolean;
    function EhOperacapDeRemessaPorContaEOrdem: Boolean;
    function EhOperacaoDeRetornoDeConsignacao: Boolean;
    function EhOperacaoDeFaturamentoDeConsignacao: Boolean;
    function EhOperacaoDeRemessaDeMercadoriaFaltante: Boolean;
    function EhOperacaoDeAtivoImobilizado: Boolean;
    function EhOperacaoDeVendaParaForaDoEstabelecimentoRemessa: Boolean;
    function EhOperacaoDeRetornoDeVendaParaForaDoEstabelecimento: Boolean;
    function EhOperacaoDeFaturamentoDeVendaParaForaDoEstabelecimento: Boolean;
    function EhOperacaoComClienteExportacaoIndireta: Boolean;
    function EhOperacaoComComodatoCilindroVasilhame: Boolean;
    function EhOperacaoDePedidoComRemessaContaOrdem: Boolean;
    function EhOperacaoDePedidoContaEOrdem: Boolean;
    function EhOperacaoDePedidoDeRemessaParaGarantia: Boolean;
    function EhOperacaoDeBaixaDeEntregaFutura: Boolean;
    function EhOperacaoDeConfirmacaoDeCupomFiscal: Boolean;
    function EhOperacaoDeTributacaoEstado: Boolean;
    function EhEstornoDeNotaFiscal: Boolean;
  public
    constructor Create(AConfiguracoes: IConfiguracoes);
    destructor Destroy; override;
    property TransferenciaEstoqueEmpresa: ITransferenciaEstoqueEmpresaDadosDB read FTransferenciaEstoqueEmpresa write FTransferenciaEstoqueEmpresa;
    function GetClassificacao(const AInput: TInputDefineClassificacaoFiscal): TInputOutputClassificacaoFiscal;
  End;

implementation

uses System.SysUtils, System.StrUtils, untCFOPNotaEspecialVendaABaseDeTroca,
  untCFOPReposicaoClienteGarantia, Shared.Functions.Funcoes.Faturamento,
  untCFOPAkzoNobel, untCFOPUsoEConsumo, untCFOPEmprestimo,
  untCFOPOrdemDeProducaoAvulsaTintometrico, untCFOPSimplesRemessaDeConcreto,
  untCFOPRemessaEstoqueExterno, untCFOPBaixaRefugo, untCFOPDevolucaoOuOutrasEntradas,
  Shared.Functions.Constantes, untCFOPDevolucaoDemonstracao, untCFOPTipoOperacaoPedidoVenda,
  untCFOPExcecoesServico, untCFOPClienteZonaFrancaOuReducaoBaseIcmsST,
  untCFOPRemessaPorContaEOrdem, untCFOPRetornoConsignacao, untCFOPFaturamentoConsignacao,
  untCFOPClienteFilial, untCFOPRemessaDeMercadoriaFaltante, untCFOPAtivoImobilizado,
  untCFOPEnvioRemessa, untCFOPRetornoRemessa, untCFOPFaturamentoRemessa,
  untCFOPClienteExportacaoIndireta, untCFOPComodatoCilindroVasilhame,
  untCFOPNFAmostraGratis, untCFOPNFComplementoFornecedorValor, untCFOPOutrasSaidasParaConserto,
  untCFOPNotaImportacao, untCFOPClienteExterior, untCFOPConfirmacaoAjustes,
  untCFOPNotaFiscalTintometricoEspiritoSanto,
  untCFOPrecebimentoGarantiaOutrasEntradas, untCFOPEnvioGarantiaFornecedor,
  untCFOPConsignacaoEnvio, untCFOPBrinde, untCFOPPedidoDeRemessaParaGarantia,
  untCFOPBaixaEntregaFutura, untCFOPEntregaFutura, untCFOPConfirmacaoDeCupom,
  untCFOPConsumidorForaDoEstadoOuAtendeDifal, untCFOPRegrasDeTributacaoEstado,
  untCFOPEstornoNotaFiscal;

{ TDefineCFOP }

procedure TDefineCFOP.AddRegra(const ACondicao: TFunctionRegraCFOP; AClasse: TClassificacaoClass);
begin
  If Assigned(FClasseClassificacao) Then
    Exit;

  If (Not ACondicao) Then
    Exit;

  FClasseClassificacao := AClasse;
end;

constructor TDefineCFOP.Create(AConfiguracoes: IConfiguracoes);
begin
  FClassificacao := Nil;
  FConfiguracoes := AConfiguracoes;
end;

destructor TDefineCFOP.Destroy;
begin
  If Assigned(FClassificacao) Then
    FreeAndNil(FClassificacao);
  inherited;
end;

function TDefineCFOP.EhOperacaoAkzoNobel: Boolean;
begin
  Result := FInput.FatGorOrigem = AKZO_NOBEL;
end;

function TDefineCFOP.EhOperacaoAmostraGratis: Boolean;
begin
  Result := (FInput.TipoDeOperacaoDoPedidoDeVenda = 'A');
end;

function TDefineCFOP.EhOperacaoClienteExterior: Boolean;
begin
  Result := False;

  If (FInput.ClienteEstado <> CLIENTE_EXTERIOR) Then
    Exit;

  If (FInput.BaixaDeEntregaFutura) Then
    Exit;

  If (FInput.VendaPresencial) Then
    Exit;

  Result := True;
end;

function TDefineCFOP.EhOperacaoComBrinde: Boolean;
begin
  Result := True;

  If (FInput.OpcaoDeDocumento = BRINDE) Then
    Exit;

  If (FInput.ItemBrinde) Then
    Exit;

  Result := False;
end;

function TDefineCFOP.EhOperacaoComClienteExportacaoIndireta: Boolean;
begin
  Result := FInput.ClienteExportacaoIndireta;
end;

function TDefineCFOP.EhOperacaoComComodatoCilindroVasilhame: Boolean;
begin
  Result := FInput.ComodatoCilindroVasilhame;
end;

function TDefineCFOP.EhOperacaoComConsumidorForaDoEstadoOuAtendeDifal: Boolean;
begin
  Result := (Not (FInput.ClienteCodigo = EmptyStr)) And
            (
              (
                (FInput.ClienteInscricaoEstadual = EmptyStr) And
                (Not FInput.ClienteMicroEmpreendedor) And
                (Not FInput.DentroDoEstadoCFOP) And
                (Not (FInput.ClienteEstado = CLIENTE_EXTERIOR))
              )
              Or
                FInput.AtendeRegrasDifal
            );
end;

function TDefineCFOP.EhOperacaoDeAtivoImobilizado: Boolean;
begin
  Result := FInput.OpcaoDeDocumento = ATIVO_IMOBILIZADO;
end;

function TDefineCFOP.EhOperacaoDeBaixaDeEntregaFutura: Boolean;
begin
  Result := FInput.BaixaDeEntregaFutura;
end;

function TDefineCFOP.EhOperacaoDeBaixaRefugo: Boolean;
begin
  Result := FInput.BaixaRefugo;
end;

function TDefineCFOP.EhOperacaoDeComplementoFornecedorValor: Boolean;
begin
  Result := FInput.NFComplementoFornecedorValor;
end;

function TDefineCFOP.EhOperacaoDeConfirmacaoDeAjustes: Boolean;
begin
  Result := (FInput.OpcaoDeDocumento = CONFIRMACAO_AJUSTES);
end;

function TDefineCFOP.EhOperacaoDeConfirmacaoDeCupomFiscal: Boolean;
begin
  Result := FInput.OpcaoDeDocumento = CONFIRMACAO_CUPOM_FISCAL;
end;

function TDefineCFOP.EhOperacaoDeConsignacaoEnvio: Boolean;
begin
  Result := FInput.OpcaoDeDocumento = CONSIGNACAO;
end;

function TDefineCFOP.EhOperacaoDeUsoEConsumo: Boolean;
begin
  Result := True;

  If (FInput.OpcaoDeDocumento = USO_E_CONSUMO) Then
    Exit;

  If (FInput.TipoDeOperacaoDoPedidoDeVenda = 'U') Then
    Exit;

  Result := False;
end;

function TDefineCFOP.EhOperacaoDevolucaoDemonstracao: Boolean;
begin
  Result := FInput.OpcaoDeDocumento = DEVOLUCAO_DEMONSTRACAO;
end;

function TDefineCFOP.EhOperacaoDevolucaoOuOutrasEntradas: Boolean;
begin
  Result := TFunctionFuncoesFaturamento.EhDevolucaoOuOutrasEntradas(FInput.OpcaoDeDocumento, FInput.EntradaOuSaidaDoItem);
end;

function TDefineCFOP.EhOperacaoNotaEspecialVendaABaseDeTroca: Boolean;
begin
  Result := FInput.NotaEspecialVendaABaseDeTroca;
end;

function TDefineCFOP.EhOperacaoOrdemDeProducaoAvulsaTintometrico: Boolean;
begin
  Result := FInput.OpcaoDeDocumento = ORDEM_DE_PRODUCAO_AVULSA_TINTOMETRICO;
end;

function TDefineCFOP.EhOperacaoRecebimentoGarantiaOutrasEntradas: Boolean;
begin
  Result := (Pos(FInput.OpcaoDeDocumento, OUTRAS_ENTRADAS_CLIENTE_FORNECEDOR) > 0) And
            (TFunctionFuncoesFaturamento.fEhRecGarantia(FInput.OpcaoDeDocumento, FInput.ClassificacaoFiscalRecebimentoGarantia));
end;

function TDefineCFOP.EhOperacaoRemessaEstoqueExterno: Boolean;
begin
  Result := FInput.RemessaEstoqueExterno;
end;

function TDefineCFOP.EhOperacapDeRemessaPorContaEOrdem: Boolean;
begin
  Result := FInput.OpcaoDeDocumento = REMESSA_POR_CONTA_E_ORDEM;
end;

function TDefineCFOP.EhReposicaoClienteGarantia: Boolean;
begin
  Result := False;

  If (FInput.Operacao <> REPOSICAO_CLIENTE_GARANTIA) Then
    Exit;

  If (Not MatchStr(FInput.OpcaoDeDocumento, [OUTRAS_SAIDAS, CONFIRMACAO_PEDIDO])) Then
    Exit;

  Result := True;
end;

function TDefineCFOP.GetRegraOperacaoSaidaClienteFilial: TClassificacaoClass;
begin
  If EhExcecoesServico Then
    Result := TCFOPExcecoesServico
  Else
    Result := TCFOPClienteFilial;
end;

function TDefineCFOP.GetRegraZonaFrancaOuReducaoBaseIcmsST: TClassificacaoClass;
begin
  If EhExcecoesServico Then
    Result := TCFOPExcecoesServico
  Else
    Result := TCFOPClienteZonaFrancaOuReducaoBaseIcmsST;
end;

procedure TDefineCFOP.InicializarDadosQuandoOperacaoDeConfirmacaoDeAjustes;
begin
  If (Not EhOperacaoDeConfirmacaoDeAjustes) Then
    Exit;
  SetObjTransferenciaEstoqueEmpresaDadosDB(TransferenciaEstoqueEmpresa);
end;

function TDefineCFOP.GetClassificacao(const AInput: TInputDefineClassificacaoFiscal): TInputOutputClassificacaoFiscal;
  Var
    InputOutputClassificacaoFiscal : TInputOutputClassificacaoFiscal;
begin
  FillChar(Result, SizeOf(Result), #0);
  FInput := AInput;

  ProcessarRegras;

  FillChar(InputOutputClassificacaoFiscal, SizeOf(InputOutputClassificacaoFiscal), #0);
  InputOutputClassificacaoFiscal.PrefixoClassificacao := GetPrefixoClassificacao;
  InputOutputClassificacaoFiscal.ClassificacaoDeServico := FInput.ClassificacaoDeServico;
  InputOutputClassificacaoFiscal.SituacaoTributaria := FInput.SituacaoTributaria;
  InputOutputClassificacaoFiscal.MensagemRetorno := EmptyStr;
  InputOutputClassificacaoFiscal.AbortarProcedimento := False;

  InicializarDadosQuandoOperacaoDeConfirmacaoDeAjustes;

  If Assigned(FClassificacao) Then
    FreeAndNil(FClassificacao);
  FClassificacao := FClasseClassificacao.Create(FInput, FConfiguracoes, InputOutputClassificacaoFiscal);

  Result := FClassificacao.GetClassificacao;
end;

function TDefineCFOP.GetPrefixoClassificacao: String;
begin
  If (TFunctionFuncoesFaturamento.fDentroDoEstadoCFOP(FInput.VendaPresencial, FInput.ClienteEstado, FInput.DentroDoEstado)) Then
    Result := '5'
  Else
    Result := '6';
end;

function TDefineCFOP.EhOperacaoDeSaidaComClienteFilial: Boolean;
begin
  Result := False;

  If (Not FInput.ClienteFilial) Then
    Exit;

  If (EhOperacaoDevolucaoOuOutrasEntradas) Then
    Exit;

  Result := True;
end;

function TDefineCFOP.EhOperacaoDeTributacaoEstado: Boolean;
begin
  Result := True;
end;

procedure TDefineCFOP.ProcessarRegras;
begin
  FClasseClassificacao := Nil;
  AddRegra(EhEstornoDeNotaFiscal, TCFOPEstornoNotaFiscal);
  AddRegra(EhOperacaoNotaEspecialVendaABaseDeTroca, TCfopNotaEspecialVendaABaseDeTroca);
  AddRegra(EhOperacaoAmostraGratis, TCFOPNFAmostraGratis);
  AddRegra(EhOperacaoDeNotaDeComplementoDeClienteComplementandoValor, TCFOPNFComplementoFornecedorValor);
  AddRegra(EhOperacaoDeComplementoFornecedorValor, TCFOPNFComplementoFornecedorValor);
  AddRegra(EhOperacaoDeOutrasSaidasParaConserto, TCFOPOutrasSaidasParaConserto);
  AddRegra(EhOperacaoDeNotaDeImportacao, TCFOPNotaImportacao);
  AddRegra(EhOperacaoClienteExterior, TCFOPClienteExterior);
  AddRegra(EhOperacaoDeConfirmacaoDeAjustes, TCFOPConfirmacaoAjustes);
  AddRegra(EhOperacaoDeNotaEspecialTintometricoEspiritoSanto, TCFOPNotaFiscalTintometricoEspiritoSanto);
  AddRegra(EhOperacaoRecebimentoGarantiaOutrasEntradas, TCFOPRecebimentoGarantiaOutrasEntradas);
  AddRegra(EhOperacaoDeEnvioGarantiaFornecedor, TCFOPEnvioGarantiaFornecedor);
  AddRegra(EhOperacaoDeConsignacaoEnvio, TCFOPConsignacaoEnvio);
  AddRegra(EhReposicaoClienteGarantia, TCFOPReposicaoClienteGarantia);
  AddRegra(EhOperacaoAkzoNobel, TCFOPAkzoNobel);
  AddRegra(EhOperacaoDeUsoEConsumo, TCFOPUsoEConsumo);
  AddRegra(EhOperacaoDeEmprestimo, TCFOPEmprestimo);
  AddRegra(EhOperacaoOrdemDeProducaoAvulsaTintometrico, TCFOPOrdemDeProducaoAvulsaTintometrico);
  AddRegra(EhItemSimplesRemessaConcreto, TCFOPSimplesRemessaDeConcreto);
  AddRegra(EhOperacaoDeSaidaComClienteFilial, GetRegraOperacaoSaidaClienteFilial);
  AddRegra(EhOperacaoRemessaEstoqueExterno, TCFOPRemessaEstoqueExterno);
  AddRegra(EhOperacaoDeBaixaRefugo, TCFOPBaixaRefugo);
  AddRegra(EhOperacaoDevolucaoOuOutrasEntradas, TCFOPDevolucaoOuOutrasEntradas);
  AddRegra(EhOperacaoDevolucaoDemonstracao, TCFOPDevolucaoDemonstracao);
  AddRegra(EhOperacaoDePedidoComBonificacao, TCFOPTipoOperacaoPedidoVenda);
  AddRegra(EhOperacaoDePedidoComDemonstracao, TCFOPTipoOperacaoPedidoVenda);
  AddRegra(EhClienteZonaFrancaOuReducaoBaseIcmsST, GetRegraZonaFrancaOuReducaoBaseIcmsST);
  AddRegra(EhOperacapDeRemessaPorContaEOrdem, TCFOPRemessaPorContaEOrdem);
  AddRegra(EhOperacaoDeRetornoDeConsignacao, TCFOPRetornoConsignacao);
  AddRegra(EhOperacaoDeFaturamentoDeConsignacao, TCFOPFaturamentoConsignacao);
  AddRegra(EhOperacaoDeRemessaDeMercadoriaFaltante, TCFOPRemessaDeMercadoriaFaltante);
  AddRegra(EhOperacaoDeAtivoImobilizado, TCFOPAtivoImobilizado);
  AddRegra(EhOperacaoDeVendaParaForaDoEstabelecimentoRemessa, TCFOPEnvioRemessa);
  AddRegra(EhOperacaoDeRetornoDeVendaParaForaDoEstabelecimento, TCFOPRetornoRemessa);
  AddRegra(EhOperacaoDeFaturamentoDeVendaParaForaDoEstabelecimento, TCFOPFaturamentoRemessa);
  AddRegra(EhOperacaoComClienteExportacaoIndireta, TCFOPClienteExportacaoIndireta);
  AddRegra(EhOperacaoComComodatoCilindroVasilhame, TCFOPComodatoCilindroVasilhame);
  AddRegra(EhOperacaoComBrinde, TCFOPBrinde);
  AddRegra(EhExcecoesServico, TCFOPExcecoesServico);
  AddRegra(EhOperacaoDePedidoComRemessaContaOrdem, TCFOPTipoOperacaoPedidoVenda);
  AddRegra(EhOperacaoDePedidoContaEOrdem, TCFOPTipoOperacaoPedidoVenda);
  AddRegra(EhOperacaoDePedidoDeRemessaParaGarantia, TCFOPPedidoDeRemessaParaGarantia);
  AddRegra(EhOperacaoDeBaixaDeEntregaFutura, TCFOPBaixaEntregaFutura);
  AddRegra(EhOperacaoDeEntregaFutura, TCFOPEntregaFutura);
  AddRegra(EhOperacaoDeConfirmacaoDeCupomFiscal, TCFOPConfirmacaoDeCupom);
  AddRegra(EhOperacaoComConsumidorForaDoEstadoOuAtendeDifal, TCFOPConsumidorForaDoEstadoOuAtendeDifal);
  AddRegra(EhOperacaoDeTributacaoEstado, TCFOPRegrasDeTributacaoEstado);
end;

function TDefineCFOP.EhItemSimplesRemessaConcreto: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      fEhItemSimplesRemessaConcreto(FInput.OpcaoDeDocumento,
                                    FInput.TaxaBombeamentoPedidoOrcamento,
                                    FInput.SimplesRemessaConcretoDadosCliente,
                                    FInput.ItemConcreto,
                                    FInput.SimplesRemessaConcreto);
end;

function TDefineCFOP.EhClienteZonaFrancaOuReducaoBaseIcmsST: Boolean;
begin
  Result := False;
  if (FInput.ClienteZonaFranca And FInput.TributaZonaFrancaManaus) then
    Exit;

  Result := (
              FInput.ClienteZonaFranca And
              (FInput.EspecieDoDocumento <> USO_E_CONSUMO) And
              (Not FInput.BaixaDeEntregaFutura)
             )
            Or
            TFunctionFuncoesFaturamento.
              fCalcBeneficioReducaoBaseIcmsST(
                FInput.TipoDaAbreviacaoFiscal, FInput.SituacaoTributaria, FInput.DentroDoEstado);
end;

function TDefineCFOP.EhExcecoesServico: Boolean;
  Var
    LEhItemConcreto: Boolean;
begin
  LEhItemConcreto := TFunctionFuncoesFaturamento.fEhItemConcreto(FInput.SimplesRemessaConcretoDadosCliente, FInput.ItemConcreto);
  Result := TFunctionFuncoesFaturamento.fEhItemServico(FInput.CodigoDoItem) Or
            (FInput.CodigoDoItem = FConfiguracoes.fGetValorConfiguracao(CFG_ITEM_TAXA_BOMBEAMENTO_CONFIRMACAO_NOTA_CONCRETO)) Or
            (FInput.CodigoDoItem = FConfiguracoes.fGetValorConfiguracao(CFG_ITEM_TAXA_MINIMA_BOMBEAMENTO_NOTA_CONCRETO))      Or
            (FInput.CodigoDoItem = FConfiguracoes.fGetValorConfiguracao(CFG_ITEM_TAXA_BOMBEAMENTO_BOMBA_MANGOTE_NOTA_CONCRETO)) Or
            (FInput.CodigoDoItem = FConfiguracoes.fGetValorConfiguracao(CFG_ITEM_TAXA_BOMBEAMENTO_BOMBA_LANCA_NOTA_CONCRETO))   Or
            (LEhItemConcreto And FInput.DesmembrarNotaProdutosServicos) Or
            ((FConfiguracoes.fGetValorConfiguracao(CFG_PROCEDIMENTO_IMPRESSAO_NOTA_FISCAL) = J_A_MASSA_CONCRETO) And FInput.ConfirmandoNotaFiscalConcreto);
end;

function TDefineCFOP.EhOperacaoDeNotaDeComplementoDeClienteComplementandoValor: Boolean;
begin
  Result := FInput.NotaDeComplementoDeClienteComplementandoValor;
end;

function TDefineCFOP.EhOperacaoDeNotaDeImportacao: Boolean;
begin
  Result := FInput.NotaDeImportacao;
end;

function TDefineCFOP.EhOperacaoDeNotaEspecialTintometricoEspiritoSanto: Boolean;
begin
  Result := False;

  If (FInput.OpcaoDeDocumento <> NOTA_ESPECIAL) Then
    Exit;

  If (FConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_NOTA_TINTOMETRICO_ESPIRITO_SANTO, varString) = 'N') Then
    Exit;

  If (Not TFunctionFuncoesFaturamento.fClientSelectEhClientFilialEmpLogada(FInput.ClienteCodigo, FInput.RetornaClienteFilial)) Then
    Exit;

  If (FInput.DocumentoDeComplementoDeValores) Then
    Exit;

  Result := True;
end;

function TDefineCFOP.EhOperacaoDeOutrasSaidasParaConserto: Boolean;
begin
  Result := (FInput.OpcaoDeDocumento = OUTRAS_SAIDAS) And (FInput.ConsertoDeEquipamento);
end;

function TDefineCFOP.EhOperacaoDePedidoComBonificacao: Boolean;
begin
  Result := FInput.TipoDeOperacaoDoPedidoDeVenda = 'B';
end;

function TDefineCFOP.EhOperacaoDePedidoComDemonstracao: Boolean;
begin
  Result := FInput.TipoDeOperacaoDoPedidoDeVenda = 'D';
end;

function TDefineCFOP.EhOperacaoDePedidoComRemessaContaOrdem: Boolean;
begin
  Result := FInput.TipoDeOperacaoDoPedidoDeVenda = 'R';
end;

function TDefineCFOP.EhOperacaoDePedidoContaEOrdem: Boolean;
begin
  Result := FInput.TipoDeOperacaoDoPedidoDeVenda = 'C';
end;

function TDefineCFOP.EhOperacaoDePedidoDeRemessaParaGarantia: Boolean;
begin
  Result := FInput.PedidoDeRemessaParaGarantia;
end;

function TDefineCFOP.EhOperacaoDeRemessaDeMercadoriaFaltante: Boolean;
begin
  Result := FInput.OpcaoDeDocumento = REMESSA_DE_MERCADORIA_FALTANTE;
end;

function TDefineCFOP.EhOperacaoDeRetornoDeConsignacao: Boolean;
begin
  Result := FInput.OpcaoDeDocumento = RETORNO_DE_CONSIGNACAO;
end;

function TDefineCFOP.EhOperacaoDeRetornoDeVendaParaForaDoEstabelecimento: Boolean;
begin
  Result := FInput.OpcaoDeDocumento = RETORNO_DE_REMESSA;
end;

function TDefineCFOP.EhOperacaoDeEmprestimo: Boolean;
begin
  Result := FInput.OpcaoDeDocumento = EMPRESTIMO_PRODUTOS;
end;

function TDefineCFOP.EhOperacaoDeEntregaFutura: Boolean;
begin
  Result := False;

  If (FInput.BaixaDeEntregaFutura) Then
    Exit;

  If (Not FInput.EntregaFuturaDoItem) Then
    Exit;

  If (FConfiguracoes.fGetValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, varBoolean)) Then
    Exit;

  Result := True;
end;

function TDefineCFOP.EhOperacaoDeVendaParaForaDoEstabelecimentoRemessa: Boolean;
begin
  Result := FInput.OpcaoDeDocumento = ENVIO_REMESSA;
end;

function TDefineCFOP.EhOperacaoDeEnvioGarantiaFornecedor: Boolean;
begin
  Result := (FInput.OpcaoDeDocumento = ENVIO_GARANTIA_FORNECEDOR) And
   (
    (Not (FInput.ClassificacaoFiscalEnvioGarantia = EmptyStr))
     Or
    (Not (FInput.ClassificacaoFiscalEnvioGarantiaST = EmptyStr))
   )
end;

function TDefineCFOP.EhOperacaoDeFaturamentoDeConsignacao: Boolean;
begin
  Result := FInput.OpcaoDeDocumento = FATURAMENTO_CONSIGNACAO;
end;

function TDefineCFOP.EhOperacaoDeFaturamentoDeVendaParaForaDoEstabelecimento: Boolean;
begin
  Result := FInput.OpcaoDeDocumento = FATURAMENTO_REMESSA;
end;

function TDefineCFOP.EhEstornoDeNotaFiscal: Boolean;
begin
  Result := FInput.EstornoNotaFiscal;
end;

end.
