unit untFatBaixarPedOrcNaoEntregue;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Uni, System.Generics.Collections,
  untMsgLiberacao, untLiberacao, UniClientDataSet, cxGridCustomTableView,
  untFuncFat, untTypesSistema, StrUtils,cxProgressBar, Variants, untFuncFatTypes,
  untGravando, Dialogs, untFatGor;

type
  TOcorrenciaBaixa = record
    strCodOco : String;
    strHisBai : String;
    strHistComplementar : String;
    blnMostrarOpVendaPerdida : Boolean;
  End;

  TRecItemSemSaldo = Record
    strCodEmp: String;
    strEspDoc: String;
    strNumDoc: String;
    strCodCli: String;
    strNomCli: String;
    strCodIte: String;
    strDesIte: String;
    strSigUni: String;
    fltSalDsp: Double;
  End;

  TDocumento = class
  private
    FNumero: String;
    FEspecie: String;
    FCodigoEmpresa: String;
    FAutoIncrem: String;
    FNomeCliente: String;
    FCgcCliente: String;
    FJaFaturado: Integer;
    FMotivoBaixa: String;
    FCodigoCliente: String;
    FValorAdiantamento: Double;
    FCodigoOcorrencia: String;
    FCodigoVendedor: String;
    FNomeVendedor: String;
    FMensagemOrdemProducao: String;
    FGerouOrdemProducao: Boolean;
    FExcluiuOrdemProducao: Boolean;
    FTinDorBaixado: Boolean;
    FVinculadoGarantia: Boolean;
    FNumeroGarantia: String;
    FValorTotal    : Double;
    FDataDocumento : TDate;
    FTrocaCliente: Boolean;
    FCodCliNov: String;
    FNomCliNov: String;
    FBlnPedECom: Boolean;
    FblnPedidoAlpe: Boolean;
    FPagtoOnLineLinkPagamentoCitel: Boolean;
    FstrIntFus: String;

    FAguardandoTransferencia: Boolean;
    FPedidoTransferencia: Boolean;
    FRequisicaoCompra: Boolean;
    FPedidoPossuiItensEmSemparacao: Boolean;
    FPedidoComRequisicaoEmAbertoSemPedidoDeCompra: Boolean;
    FPedidoComPedAbastecimento: Boolean;

    FDocAbs: String;
    FEspAbs: String;
    FEmpAbs: String;
    FPedidoOriginadoDeTransferencia: Boolean;

    FValorBoletosAdiantamento: Double;
    FPedidoComRequisicaoEmAbertoComPedidoDeCompra: Boolean;

    FListVerificar: TStringList;
    FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra: TLiberacao;
    FNumeroRequisicao: String;
    FCodEmpRequisicao: String;

    FTipRec: String;
    FNumOrigem: String;
    FEmpOrigem: String;
    FEspOrigem: String;

    FNumOrdemServico: String;

    function VerificaPedidoTransferencia: Boolean;
    function VerificaAguardandoTransferencia: Boolean;
    function VerificaRequisicaoCompra: Boolean;
    function VerificaPedidoPossuiItensEmSemparacao: Boolean;
    function VerificaPedidoOriginadoDeTransferencia: Boolean;
    function VerificaPedidoComRequisicaoEmAbertoComPedidoDeCompra: Boolean;
    function VerificaPedidoComRequisicaoEmAbertoSemPedidoDeCompra: Boolean;
    function VerificaPedidoComPedAbastecimento: Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    property Numero: String read FNumero write FNumero;
    property Especie: String read FEspecie write FEspecie;
    property CodigoEmpresa: String read FCodigoEmpresa write FCodigoEmpresa;
    property AutoIncrem: String read FAutoIncrem;
    property CodigoCliente: String read FCodigoCliente;
    property MotivoBaixa: String read FMotivoBaixa;
    property NomeCliente: String read FNomeCliente;
    property CgcCliente: String read FCgcCliente;
    property CodigoVendedor: String read FCodigoVendedor;
    property NomeVendedor: String read FNomeVendedor;
    property NumeroGarantia: String read FNumeroGarantia;
    property ListVerificar: TStringList read FListVerificar;
    property objLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra: TLiberacao read FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra;
    property NumeroRequisicao: String read FNumeroRequisicao;
    property CodEmpRequisicao: String read FCodEmpRequisicao;
    property MensagemOrdemProducao: String read FMensagemOrdemProducao;
    property ExcluiuOrdemProducao: Boolean read FExcluiuOrdemProducao;
    property ValorTotal    : Double read FValorTotal write FValorTotal;
    property DataDocumento : TDate read FDataDocumento write FDataDocumento;
    property TipRec: String read FTipRec;
    property NumOrigem: String read FNumOrigem write FNumOrigem;
    property EspOrigem: String read FEspOrigem write FEspOrigem;
    property EmpOrigem: String read FEmpOrigem write FEmpOrigem;
    property blnTrocaCliente: Boolean Read FTrocaCliente Write FTrocaCliente;
    property CodigoClienteNovo: String Read FCodCliNov Write FCodCliNov;
    property NomeClienteNovo: String Read FNomCliNov Write FNomCliNov;
    property NumOrdemServico: String read FNumOrdemServico write FNumOrdemServico;

    function PossuiAdiantamento: Boolean;
    function PossuiOcorrencia: Boolean;
    function JaFaturado: Boolean;
    function GerouOrdemProducao: Boolean;
    function TinDorBaixado: Boolean;
    function VinculadoGarantia: Boolean;
    function AguardandoTransferencia: Boolean;
    function PedidoTransferencia: Boolean;
    function RequisicaoCompra: Boolean;
    function PedidoPossuiItensEmSemparacao: Boolean;
    function PedidoOriginadoDeTransferencia: Boolean;
    function PossuiBoletosAdiantamento: Boolean;
    function PedidoComRequisicaoEmAbertoComPedidoDeCompra: Boolean;
    function PedidoComRequisicaoEmAbertoSemPedidoDeCompra: Boolean;
    function PedidoComPedAbastecimento: Boolean;
    function PedidoComDocumentoOrigem: Boolean;
    function EhClienteConsumidor: Boolean;
    function fEhPedidoECommerce: Boolean;
    function fEhPedidoAlpe: Boolean;
    function PedidoComOrdemServico: Boolean;
    function fEhPagtoOnLineLinkPagamentoCitel: Boolean;
    function fEhPedidoIntegracaoFusion: Boolean;

    procedure CarregarDados;
  end;

  TCondicaoRemover = reference to function(ADocumento: TDocumento): Boolean;

  EValidaException                    = class(Exception);
  EValidaPedidoPossuiItensEmSeparacao = class(Exception);

  TBaixarPedOrcNaoEntregue = class
  private
    FLiberouTravaAditivo: Boolean;
    FExecutandoPeloCRM: Boolean;
    FNomeForm: String;
    FListaDocumentos: TObjectList<TDocumento>;
    FMultiplosDocumentos: Boolean;
    FblnRealizarEstoAdt: Boolean;
    FblnGerarCreditoAdt: Boolean;
    FblnExecutandoCnsOr: Boolean;
    FblnVendaPerdidaGer: Boolean;
    FLiberouBaixaDePedidoNaoEntregue: Boolean;
    FblnExecutandoLocEqu: Boolean;
    FLimparSeparacao: Boolean;
    FExcluirExtLar : Boolean;
    FRealizouValidacao: Boolean;
    FOcorrenciaBaixa : TOcorrenciaBaixa;
    FExibirMensagemFinalizacao : Boolean;

    function VaiAbrirTelaPraCancelarLinkPagamentoCitel(const ADocumento: TDocumento): Boolean;
    procedure RemoveDocumentos(ACondicao: TCondicaoRemover);

    function PossuiAcesso: Boolean;

    function RetornarMensagemTrava(Const AContador :Integer) : String;

    procedure ValidaAditivo;
    procedure ValidaAditivoSimples;
    procedure ValidaAditivoMultiplo;

    procedure ValidaCrm;
    procedure ValidaCrmSimples;
    procedure ValidaCrmMultiplo;

    procedure ValidaJaFaturado;
    procedure ValidaJaFaturadoSimples;
    procedure ValidaJaFaturadoMultiplo;

    procedure ValidaOrdemProducao;
    procedure ValidaOrdemProducaoSimples;
    procedure ValidaOrdemProducaoMultiplo;

    procedure ValidaTinDorBaixado;
    procedure ValidaTinDorBaixadoSimples;
    procedure ValidaTinDorBaixadoMultiplo;

    procedure ValidaVinculadoGarantia;
    procedure ValidaVinculadoGarantiaSimples;
    procedure ValidaVinculadoGarantiaMultiplo;

    procedure ValidaTransferenciasRequisicoes;
    procedure ValidaTransferenciasRequisicoesSimples;
    procedure ValidaTransferenciasRequisicoesMultiplo;

    procedure ValidaAguardandoTransferencia;
    procedure ValidaPedidoTransferencia;
    procedure ValidaRequisicaoCompra;

    procedure ValidaPedidoPossuiItensEmSemparacao;
    procedure ValidaPedidoPossuiItensEmSemparacaoSimples;
    procedure ValidaPedidoPossuiItensEmSemparacaoMultiplo;

    procedure ValidaPedidoOriginadoDeTransferencia;
    procedure ValidaPedidoOriginadoDeTransferenciaSimples;
    procedure ValidaPedidoOriginadoDeTransferenciaMultiplo;

    procedure ValidaBoletosAdiantamento;
    procedure ValidaBoletosAdiantamentoSimples;
    procedure ValidaBoletosAdiantamentoMultiplo;

    procedure ValidaPedidoComRequisicaoEmAbertoComPedidoDeCompra;
    procedure ValidaPedidoComRequisicaoEmAbertoComPedidoDeCompraSimples;
    procedure ValidaPedidoComRequisicaoEmAbertoComPedidoDeCompraMultiplo;

    procedure ValidaPedidoComRequisicaoEmAbertoSemPedidoDeCompra;
    procedure ValidaPedidoComRequisicaoEmAbertoSemPedidoDeCompraSimples;
    procedure ValidaPedidoComRequisicaoEmAbertoSemPedidoDeCompraMultiplo;

    procedure ValidaPedidoComPedAbastecimento;
    procedure ValidaPedidoComPedAbastecimentoSimples;
    procedure ValidaPedidoComPedAbastecimentoMultiplo;

    procedure ValidaDocumentoOrigem;
    procedure ValidaDocumentoOrigemSimples;
    procedure ValidaDocumentoOrigemMultiplo;

    procedure ValidaGeracaoCredito;
    procedure ValidaGeracaoCreditoMultiplo;

    procedure ValidaPedidoComOS;
    procedure ValidaPedidoComOSSimples;
    procedure ValidaPedidoComOSMultiplo;

    function fTrocaClientePedido(cdsDados: TUniClientDataSet): Boolean;

    function RealizaBaixa: Boolean;
    function ProcessouCancelamentoLinkPagamentoCitel : Boolean;

    procedure MostraMensagem(AQtdeOk: Integer);

    procedure SemDocumentos;
    function MultiplosDocumentos: Boolean;
    function LiberacaoNaoSeraEntregue(const APreMensagem, APosMensagem: string; AObjTabela: TRegistroMsgLibera; docDocumento : TDocumento = Nil): Boolean;

    function GerarLogLiberacao(ADocumento: TDocumento): Boolean;
    function fGerarVendaPerdida(ADocumento: TDocumento): Boolean;

    procedure pRetornaComplementosPedido(var strNumRom, strEntRet, strCodFpg, strDtEntr, strCodCnd: String; docDocumento : TDocumento );
    function fBaixarDocumentoVinculadoRemessaContaOrdem: Boolean;
    function fValidarClienteFilial: Boolean;

    procedure pVerificaAbastecimentoTransf(ADocumento: TDocumento);
    procedure pMostraMensagemAbastecimentoTransf(AMensagem: TStringList);

    procedure pGerarTarefaRomaneioFusion(ADocumento: TDocumento);
    procedure ValidaPixEmAberto;
    procedure pExcluiPrepTE(ADocumento: TDocumento);
    procedure pExcluiRequisicoesDeCompraVinculadasAoDocumento(const ANumDoc, AEspDoc, ACodEmp: String);

    function PerguntaOpcaoEstornoCreditoPedidoEcommerce(ADocumento: TDocumento): Boolean;
    function LimpaExpedicaoPedido(const strAutInc : String; const blnExcluirExtLar: Boolean): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    function Executar: Boolean;
    function ValidouRestricoesLimparSeparacao: Boolean;
    procedure ReprocessarValidacoes;
    procedure ValidaDocumento;
    function PermiteExecutar : Boolean;
    function fGetOcorrencia(var AHisBai, AHistcomplementar : String; var AMostrarOpVendaPerdida : Boolean) : String;

    function VerificarAcessoLiberacao : Boolean;
    procedure AddDocumento(ANumero, AEspecie, ACodigoEmpresa: String);
    property ExecutandoPeloCRM: Boolean read FExecutandoPeloCRM write FExecutandoPeloCRM;
    property strNomeForm: String read FNomeForm write FNomeForm;
    property blnExecutandoCnsOr: Boolean read FblnExecutandoCnsOr write FblnExecutandoCnsOr;
    property blnExecutandoLocEqu: Boolean read FblnExecutandoLocEqu write FblnExecutandoLocEqu;
    property LimparSeparacao: Boolean read FLimparSeparacao write FLimparSeparacao;
    property ExcluirExtLar: Boolean read FExcluirExtLar write FExcluirExtLar;
    property RealizouValidacao: Boolean read FRealizouValidacao write FRealizouValidacao;
    property OcorrenciaBaixa : TOcorrenciaBaixa read FOcorrenciaBaixa write FOcorrenciaBaixa;
    property ExibirMensagemFinalizacao : Boolean read FExibirMensagemFinalizacao write FExibirMensagemFinalizacao;
  end;

  TGerarVendaPerdida = Class
  private
    FObjFatVenda: TFatVenda;
    FblnJaAvisouAltPD: Boolean;
    FblnPDOriDesmembramento: Boolean;
    FblnUtilizaVendaVidro: Boolean;
    qryConIte: TUniQuery;
    FblnVendaPerdidaGerada: Boolean;
    FblnDocumentoExcluido: Boolean;

    //StringLists
    FstlFormulacaoBaixada: TStringList;
    FstlOrdemProd: TStringList;
    FstlProdCampanha: TStringList;
    FstlProdBonus   : TStringList;

    blnRecalculaTabelaTintasPrecos: Boolean;
    blnRecalcularSomenteItensTinta: Boolean;
    blnAltTabRecalculoPrecos    : Boolean;
    blnRecalculaSomenteItensQueEntraramOuSairamDePromocao: Boolean;
    blnRecalcularSomentePrecosComCotacaoDolar: Boolean;
    blnRecalculaSomenteItensQueSairamDePromocao: Boolean;
    blnRecalculaSomenteItensQueEntraramEmPromocao: Boolean;
    blnApenasVerificaSeItensTeraoModicacaoAposCondicaoPagamento: Boolean;
    blnAltTabelaPreco: Boolean;
    blnVerUniOriginal: Boolean;
    blnModuloAltCondPagtoPedido: Boolean;
    blnAtualizaTabPreCnd: Boolean;
    blnItensEntraramOuSairamDePromocao: Boolean;
    blnItensTiveramUnitarModificados: Boolean;
    blnVerUniOriRecalculoPrecos: Boolean;
    blnDescProfissRecalculoPrecos: Boolean;
    blnZerarDescontoDoItemRecalculoPrecos: Boolean;
    blnManterPrecoDigitado: Boolean;
    blnRecalculoParaTrava: Boolean;
    strCodigoPromocaoColetiva: String;
    intSeqItemEstruturaRecalcular: Integer;
    frmGravandoInterno: TfrmGravando;
    strInfoProcessamento: String;
    FblnRecalculaPrecos: Boolean;
    pOnProcessaItem: TOnProcessaItem;
    FLimparSeparacao : Boolean;
    FExcluirExtLar : Boolean;
    FFncLimparSeparacao : TFunctionLimparSeparacao;
    function fDeletaItem(blnExibeSenha:Boolean; strNumOrc, strEspOrc, strEmpOrc: String): Boolean;
    function fValidaPodeDeletaItem(blnExibeSenha:Boolean; strNumOrc, strEspOrc, strEmpOrc: String): Boolean;
    function fPedeSenhaLiberacaoExcluirItemComSolicitacaoAbastecimento: Boolean;
    function fPodeAlterarItemOutroVendedor(FObjFatVenda: TFatVenda; strVenAtu, strVenIte: String; blnComSenha: Boolean = True): Boolean;
    function fTravaExclusaoAlteracaoDoItemExpedido(const FObjFatVenda: TFatVenda; const strEntRet, strEntFut: string; blnExcluindo : Boolean = False): Boolean;
    function fPodeExcluirItemRequsicaoCompra(FObjFatVenda: TFatVenda; strCodIte: String;
      fltQtdDel: Double): Boolean;
    procedure pDeletaItemDevolucaoCompleta(const FObjFatVenda: TFatVenda);
    function fPermiteAlterarPedido(FObjFatVenda: TFatVenda; blnAlterando: Boolean): Boolean;
    function fPermiteSelecionarEspeciePedido(const FObjFatVenda: TFatVenda): Boolean;

    function fTemItemEspecialVenda: Boolean;
    function fPDEmPreRomaneio(strNumDoc, strEspDoc, strCodCli, strCodEmp: String): Boolean;
    function fValidaGeracaoVendaPerdida: Boolean;
    procedure pCarregarOrdPro;
    procedure pProcessaCalculoFlex;
    procedure pApagaItensComboVenda(strAtivac: String; intSeqCom: Integer);
    procedure pAtualizaItensEstrutura(intSeqEst: Integer);
    function fRecalculaItensPromocaoColetiva(strCodIte, strCodigoUnidadeMedida, strPromoc: String;
      Var strCodPro: String; blnDel: Boolean = False; strRshDel: String=''; strRshAut: String=''): Boolean;
    procedure pRecalculaPrecos(blnVerUniOri             : Boolean = False;
                               blnAltTab                : Boolean = False;
                               blnAplicaDescProfiss     : Boolean = False;
                               blnRecalculaTabelaTintas : Boolean = True;
                               strPromocaoColetiva      : String  = '';
                               blnSomentePromocao       : Boolean = False;
                               blnSomenteSaidaPromocao  : Boolean = False;
                               blnSomenteEntradaPromocao: Boolean = False;
                               blnManterPrecoDigitado   : Boolean = False;
                               blnZerarDescontoDoItem   : Boolean = False;
                               blnSomentePrecosComCotacaoDolar: Boolean = False;
                               blnRecalculoParaTrava    : Boolean = False;
                               intSeqItemEstrutura      : Integer = 0;
                               blnSomenteItensTinta     : Boolean = False);

    function fCarregarBrindesPromocaoCompostaPorKit: Boolean;
    function fRevisarBrindesPromocaoCompostaPorKit(AListKit: TStringList; AInserirBrinde: Boolean): Boolean;
    function fRealizarGravacao: Boolean;
    function fRecalculaPrecosInterna(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fRetEmpresaItem: String;
    function fTabelaPrecoClienteOuVendedor: String;
    function fUnitariosDiferentes(fltUnitar: Double): Boolean;
    function fPodeAplicarDescontoCondicaoPagamento(fltUnitar: Double): Boolean;
    function fCalculaTotalPedidoInterna(pgbStatus: TcxProgressBar = nil): Boolean;
    function fQtdTotItem(strCodIte: String): Double;
    function fObtemStrTabela: String;
    function fCalculaUniTar(blnItemEspecial: Boolean; strTabela: String; var fltDescontoCndDestacado: Double): Double;
    function fItensEntraramOuSairamDePromocao(fltUnitar: Double): Boolean;
    function fValidaLiberacaoSenha(strNumOrc, strEspOrc, strEmpOrc: String;
      blnExibeSenha: boolean): Boolean;
    function fValidaItem: Boolean;

    procedure pRecalculaItem(strIteDel, strUnidadeDel, strProDel, strCodPro, strRshDel: String;
      blnRecalcularItensSairamPromocao: Boolean);
    procedure pAjustarListas;
    procedure pAlterarTabela(strTabela: String);
    function fExigirSenha(LDocumento: TDocumento): Boolean;
    function fInformarSenha(LDocumento: TDocumento; blnExisteOcorrencia: Boolean): Boolean;
    procedure pRecalcularTotIte(fltUnitar, fltUniDol, fltDescontoCndDestacado: Double);
    function fCalcularUniTarDescontoDestacado(fltUniTar: Double; var fltDescontoCndDestacado: Double): Double;
    function fTemPromocaoColetiva: Boolean;
    procedure pCalcularValFre;
    procedure pCalcularTxEntrega;
    procedure pCalcularVolume;
    procedure pDeletaListas;
    function fCalcularQtdIte(var fltQtdIte: Double; var fltQtdTotIte: Double;
      blnDel, blnProAtv: Boolean): Boolean;
    function fValidaAbastecimentoVinculado: Boolean;
    function fValidaPermiteAlterarItem: Boolean;
    procedure pInsereItensSep;
    procedure pProcessaEstruturaVidros;
    procedure pProcessaDicFormulas(const strAutInc: String);
    procedure pApagaSerieItem;
    procedure pProcessaVendaNaoEntregue(LDocumento: TDocumento; blnExisteOcorrencia: Boolean);
    procedure pCalculaTotGer;
    procedure pCalculaTxVpr;
    procedure pCalculaTotCadRec;
    procedure pProcessaVendaPerdidaItens(oblItens: TObjectList<TItemVendasPerdidas>; LDocumento: TDocumento);
    procedure pAjustaPrecoPromocao(const strTabela: String);
    procedure pProcessaQtdColetiva(strCodIte, strRshDel, strCodigoUnidadeMedida, strCodPro, strRshAut: string;
      blnDel: Boolean; fltQtdLim, fltQtdMin: Double);
    function fCondicaoFaturamentoFinal: Boolean;
  public
    constructor Create(const strEspPed: String);
    destructor Destroy; override;

    procedure pGerarVendaPerdida(LDocumento: TDocumento); overload;
    procedure pGerarVendaPerdida(const strEmpDoc, strEspDoc, strNumDoc: String); overload;

    property blnVendaPerdidaGerada: Boolean read FblnVendaPerdidaGerada;
    property blnDocumentoExcluido : Boolean read FblnDocumentoExcluido;
    property LimparSeparacao: Boolean read FLimparSeparacao write FLimparSeparacao;
    property FncLimparSeparacao : TFunctionLimparSeparacao read FFncLimparSeparacao write FFncLimparSeparacao;
    property ExcluirExtLar : Boolean read FExcluirExtLar write FExcluirExtLar;
  End;

  function fPedidoGerouOrdProd(strNumPed, strCodEmp: String; var strMens: String): Boolean; overload;
  function fPedidoGerouOrdProd(strNumPed, strCodEmp: String): Boolean; overload;


implementation

uses
  System.UITypes, untFuncoesSimples, untFuncoesGenerica,
  untTSituacaoPedidoVenda, untAdiantamentoCliente,
  untFuncoesCRM, untFuncoes, untMensagemExplicativa,
  untAdiantamentoClienteGenerico, untMovRcd, untFatAltQtdeItensPedido,
  untProjetos, untFatConfirmaPedOrd, untFatSelItemVendaPerdida,
  untTFatReprocessarSaldoItem, untFatAbastecimentoItens,
  untFuncoesAutocenter, untCadPro, untOrdPro,
  untPromocaoBrindes, untConstantes, Math, untTiposPix, untLinkPagamentoCitelUtil,
  untRomaneioTarefasFusion, untTPixDao, untClassesComumLinkPagamentoCitel;

function TBaixarPedOrcNaoEntregue.PossuiAcesso: Boolean;
begin
  Result := False;

  If (FListaDocumentos[0].Especie = 'PD') Then
    Result := TPermissoesAcesso.GetInstance.fVerificaAcesso('BXPNFT', strLoginUsuarioLogado)
  Else
  If (FListaDocumentos[0].Especie = 'OR') Then
    Result := TPermissoesAcesso.GetInstance.fVerificaAcesso('BAIPDV', strLoginUsuarioLogado);
end;

function TBaixarPedOrcNaoEntregue.VaiAbrirTelaPraCancelarLinkPagamentoCitel(const ADocumento: TDocumento): Boolean;
begin
  Result := False;

  If (ADocumento.Especie <> 'PD') Then
    Exit;

  If (Not ADocumento.fEhPagtoOnLineLinkPagamentoCitel) Then
    Exit;

  If ADocumento.PossuiAdiantamento Then
    Exit;

  if TLinkPagamentoCitelClass.fTemAdcliTransformadoEmCC(ADocumento.Numero, ADocumento.Especie, ADocumento.CodigoEmpresa) then
    Exit ;

  Result := True;
end;

function TBaixarPedOrcNaoEntregue.LimpaExpedicaoPedido(const strAutInc : String; const blnExcluirExtLar: Boolean): Boolean;
  Var
    opcExcluirExtLar : TExcluirExtLarOpcoes;
begin
  If (blnExcluirExtLar) Then
    opcExcluirExtLar := eeloExcluir
  Else
    opcExcluirExtLar := eeloNaoExcluir;
  Result := untFatGor.fLimpaExpedicaoPedido(strAutInc, False, opcExcluirExtLar, True);
end;

function TBaixarPedOrcNaoEntregue.ProcessouCancelamentoLinkPagamentoCitel : Boolean;
  Var
    LDocumento: TDocumento;
begin
  Result := True;
  for LDocumento in FListaDocumentos do
  begin
    if (VaiAbrirTelaPraCancelarLinkPagamentoCitel(LDocumento)) then
    begin

      if not TLinkPagamentoCitelClass.fTemSaldoSuficienteAdtCli(LDocumento.Numero,
                                                                LDocumento.Especie,
                                                                LDocumento.CodigoEmpresa) then
      begin
        Result := False;
        Exit ;
      end;

      if not TLinkPagamentoCitelClass.fProcessaCancelamento(LDocumento.Numero, LDocumento.Especie, LDocumento.CodigoEmpresa) then
      begin
        Result := False;
        pMensagemOK('Processo cancelado!');
        Exit ;
      end ;
    end ;
  end ;
end;

function TBaixarPedOrcNaoEntregue.fGetOcorrencia(var AHisBai, AHistcomplementar : String; var AMostrarOpVendaPerdida : Boolean) : String;
begin
  Result := TfrmFatAltQtdeItensPedido.fGetOcorrencia(AHisBai, AHistcomplementar, AMostrarOpVendaPerdida, True, FblnExecutandoCnsOr, ExecutandoPeloCRM, FListaDocumentos.First.Especie);
end;

function TBaixarPedOrcNaoEntregue.RealizaBaixa: Boolean;
var
  LDocumento: TDocumento;
  LqryGen: TUniQuery;
  LQtdeOk: Integer;
  blnGerarVndPer: Boolean;
  FncLimparSeparacao : TFunctionLimparSeparacao;
begin
  Result := False;

  If fEmptyStr(FOcorrenciaBaixa.strCodOco) Then
    FOcorrenciaBaixa.strCodOco := fGetOcorrencia(FOcorrenciaBaixa.strHisBai, FOcorrenciaBaixa.strHistComplementar, blnGerarVndPer);

  If fEmptyStr(FOcorrenciaBaixa.strCodOco) Then
    Exit;

  LQtdeOk := 0;

  If (Self.LimparSeparacao) Then
    FncLimparSeparacao := LimpaExpedicaoPedido
  Else
    FncLimparSeparacao := Nil;

  for LDocumento in FListaDocumentos do
  begin
    If ((FblnExecutandoCnsOr) And (blnGerarVndPer)) Then
    Begin
      If fGerarVendaPerdida(LDocumento) Then
        Inc(LQtdeOk);
    End
    Else
    Begin
      If TfrmFatAltQtdeItensPedido.pBaixarPedidoNaoEntregue(
        LDocumento.Numero,
        LDocumento.Especie,
        LDocumento.CodigoEmpresa,
        LDocumento.CodigoCliente,
        True,
        False,
        FOcorrenciaBaixa.strCodOco,
        FOcorrenciaBaixa.strHisBai,
        False,
        LDocumento.blnTrocaCliente,
        LDocumento.CodigoClienteNovo,
        FblnRealizarEstoAdt,
        FncLimparSeparacao,
        LDocumento.FAutoIncrem,
        ExcluirExtLar,
        FOcorrenciaBaixa.strHistComplementar,
        FNomeForm) Then
      Begin
        Inc(LQtdeOk);
        pGerarTarefaRomaneioFusion(LDocumento);
        pExcluiPrepTE(LDocumento);
      End;

      If (fCfgSis('USADEP') = 'S') Then
      begin
        LqryGen := fCriaQuery();
        try
          LqryGen.SQL.Add('SELECT FGO_ESPDOC, FGO_USADEP, AUTOINCREM, FGO_NUMDOC, FGO_CODEMP');
          LqryGen.SQL.Add('FROM FATGOR G');
          LqryGen.SQL.Add('INNER JOIN EXTGOR ON FGO_SEQFGO = G.AUTOINCREM');
          LqryGen.SQL.Add(' WHERE FGO_NUMDOC = :NUMDOC');
          LqryGen.SQL.Add('   AND FGO_ESPDOC = :ESPDOC');
          LqryGen.SQL.Add('   AND FGO_CODEMP = :CODEMP');
          LqryGen.ParamByName('NUMDOC').AsString := LDocumento.Numero;
          LqryGen.ParamByName('ESPDOC').AsString := LDocumento.Especie;
          LqryGen.ParamByName('CODEMP').AsString := LDocumento.CodigoEmpresa;
          LqryGen.Open;
          pGravaStatusDEPS(LqryGen);
        finally
          FreeAndNil(LqryGen);
        end;
      end;
    End;

    If fCfgSis('UTLPRJ', varBoolean) Then
      TProjeto.pRecalculaVendas(LDocumento.Numero,
                                LDocumento.Especie,
                                LDocumento.CodigoEmpresa);

    If GerarLogLiberacao(LDocumento) Then
      pGeraLogLiberacao(LDocumento.Numero,
                        LDocumento.Especie,
                        LDocumento.CodigoEmpresa);

  end;
  Result := True;
  Self.MostraMensagem(LQtdeOk);
end;

procedure TBaixarPedOrcNaoEntregue.RemoveDocumentos(
  ACondicao: TCondicaoRemover);
var
  LCount: Integer;
  I: Integer;
begin
  LCount := FListaDocumentos.Count;

  for I := Pred(LCount) Downto 0 do
    if ACondicao(FListaDocumentos[I]) then
      FListaDocumentos.Delete(I);
end;

procedure TBaixarPedOrcNaoEntregue.ReprocessarValidacoes;
var
  LDocumento: TDocumento;
begin
  for LDocumento in FListaDocumentos do
    LDocumento.CarregarDados;
end;

function TBaixarPedOrcNaoEntregue.RetornarMensagemTrava(Const AContador : Integer): String;
begin
  Result := '';

  If (FListaDocumentos[AContador].Especie = 'PD') Then
    Result := 'Permitir baixa de Pedidos que não serão entregues'
  Else
  If (FListaDocumentos[AContador].Especie = 'OR') Then
    Result := 'Permitir baixa de Orçamentos que não serão faturados';
end;

procedure TBaixarPedOrcNaoEntregue.SemDocumentos;
begin
  if FListaDocumentos.Count = 0 then
    raise EValidaException.Create('Todos os documentos foram desmarcados! Operacão encerrada!');
end;

procedure TBaixarPedOrcNaoEntregue.ValidaAditivo;
begin
  SemDocumentos;

  if MultiplosDocumentos then
    ValidaAditivoMultiplo
  else
    ValidaAditivoSimples;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaAditivoMultiplo;
var
  LDocumento: TDocumento;
  LPreMensagem: String;
  LPosMensagem: String;
  LPedirLiberacao: Boolean;

  LobjTabela: TRegistroMsgLiberaTabela;
  LobjLinha: TLinhaMsgLibera;

  LfrmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc;
  LOk: Boolean;
begin
  FLiberouTravaAditivo := False;
  LPedirLiberacao := False;

  LobjTabela := TRegistroMsgLiberaTabela.Create;

  LPreMensagem := 'Atenção! O(s) pedido(s) listado(s) abaixo possue(m) adiantamento.';
  LPosMensagem := 'Ao realizar a liberação desta trava, o(s) pedido(s) será(ão) baixado(s) e será gerado um crédito (CC) para o cliente no valor do adiantamento.';

  LobjLinha  := TLinhaMsgLibera.Create;
  LobjLinha.enuTipoLinha := tlCabecalho;
  LobjLinha.pAddColuna('', 'Documento'    , 12);
  LobjLinha.pAddColuna('', 'Emp.'         , 3 );
  LobjLinha.pAddColuna('', 'Cod.Cli.'     , 8 );
  LobjLinha.pAddColuna('', 'Nome Cliente' , 60);
  LobjTabela.lstLinhas.Add(LobjLinha);

  pCriarFormularios(TfrmFatConfirmaPedOrc, LfrmFatConfirmaPedOrc);
  try
    LfrmFatConfirmaPedOrc.lblTitulo.Caption := LPreMensagem;
    LfrmFatConfirmaPedOrc.lblRodape.Caption :=
      'Deseja desmarcar este(s) documento(s) para prosseguir com a baixa do(s) outro(s) selecionado(s)?' + sLineBreak +
      'Deseja liberar e o(s) documento(s) será(ão) baixado(s) e será gerado um crédito (CC) para o cliente no valor do adiantamento?';

    LfrmFatConfirmaPedOrc.btnLibera.Visible := True;

    for LDocumento in FListaDocumentos do
    begin
      if LDocumento.PossuiAdiantamento then
      begin
        LPedirLiberacao := True;

        LobjLinha := TLinhaMsgLibera.Create;
        LobjLinha.enuTipoLinha := tlValor;
        LobjLinha.pAddColuna('Documento'   , LDocumento.Numero       , 12);
        LobjLinha.pAddColuna('Emp.'        , LDocumento.CodigoEmpresa, 3 );
        LobjLinha.pAddColuna('Cod.Cli.'    , LDocumento.CodigoCliente, 8 );
        LobjLinha.pAddColuna('Nome Cliente', LDocumento.NomeCliente  , 60);
        LobjTabela.lstLinhas.Add(LobjLinha);

        LfrmFatConfirmaPedOrc.AddDocumento(
          LDocumento.Numero,
          LDocumento.Especie,
          LDocumento.CodigoEmpresa,
          LDocumento.CodigoVendedor,
          LDocumento.NomeVendedor,
          LDocumento.CodigoCliente,
          LDocumento.NomeCliente,
          LDocumento.CodigoClienteNovo,
          LDocumento.NomeClienteNovo
        );
      end;
    end;

    if LPedirLiberacao then
    begin
      case LfrmFatConfirmaPedOrc.ShowModal of
        mrOk:
          begin
            RemoveDocumentos(
              function(ADocumento: TDocumento): Boolean
              begin
                Result := ADocumento.PossuiAdiantamento;
              end);
          end;
        mrYes:
          begin
            LOk := LiberacaoNaoSeraEntregue(LPreMensagem, LPosMensagem, LobjTabela);
            FLiberouTravaAditivo := LOk;
            if not LOk then
              raise EValidaException.Create('');
          end;
      end;
    end;

  finally
    pFreeAndNil(LfrmFatConfirmaPedOrc);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaAditivoSimples;
var
  LDocumento: TDocumento;
  LPosMensagem: String;
  LOk: Boolean;
  intOpc: Integer;
  objLiberacao : TLiberacao;
begin
  SemDocumentos;

  FLiberouTravaAditivo := False;
  LDocumento := FListaDocumentos[0];
  If Not LDocumento.PossuiAdiantamento Then
    Exit;

  FLiberouTravaAditivo := False;
  FblnGerarCreditoAdt := False;
  FblnRealizarEstoAdt := False;
  LOk := False;
  LDocumento := FListaDocumentos[0];

  If FListaDocumentos[0].fEhPagtoOnLineLinkPagamentoCitel Then
  Begin
    FblnGerarCreditoAdt := True;
    FblnRealizarEstoAdt := False;
  End
  Else If FListaDocumentos[0].fEhPedidoAlpe Then
  Begin
    FblnGerarCreditoAdt := False;
    FblnRealizarEstoAdt := False;
    LOk := True;
  End
  Else If PerguntaOpcaoEstornoCreditoPedidoEcommerce(FListaDocumentos[0]) Then
  Begin
    intOpc := fMensagem('', 'Este pedido de venda possui adiantamento pago no valor de R$ ' + FormatFloat('#,##0.00',LDocumento.FValorAdiantamento) + '. ' +  #13#10 +
                            'Escolha a opção desejada:' +  #13#10 +
                            '[1] Realizar a baixa do pedido, gerando crédito na conta corente do cliente. ' +  #13#10 +
                            '[2] Realizar o estorno do adiantamento, e realizar a baixa do pedido. ',
                            ['[&1] Gerar Crédito', '[&2] Realizar Estorno'], 1, False, 1, 200);
    Begin
      FblnGerarCreditoAdt := intOpc = 1;
      FblnRealizarEstoAdt := intOpc = 2;
    End;
  End
  Else
    FblnGerarCreditoAdt := True;

  If FblnGerarCreditoAdt Then
  Begin
    LPosMensagem := 'Ao realizar a liberação desta trava, o pedido será baixado e será gerado um crédito (CC) para o cliente no valor do adiantamento.';

    LOk := LiberacaoNaoSeraEntregue('', LPosMensagem, nil, LDocumento);
  End
  Else If FblnRealizarEstoAdt Then
  Begin
    objLiberacao := TLiberacao.Create;
    Try
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Atenção! Estorno de adiantamento pago do Pedido de Venda pelo CRM');
      objLiberacao.objMsgLibera.pAddTexto('Operador do CRM : ' + strLoginUsuarioLogado + ' - ' + fRetNomVendRep(strLoginUsuarioLogado));
      objLiberacao.objMsgLibera.pAddTexto('Pedido          : ' + LDocumento.Numero + ' - ' + LDocumento.CodigoEmpresa);
      objLiberacao.objMsgLibera.pAddTexto('Cliente         : ' + LDocumento.CodigoCliente + ' - ' + LDocumento.NomeCliente);
      objLiberacao.objMsgLibera.pAddTexto('Vendedor        : ' + LDocumento.FCodigoVendedor + ' - ' + LDocumento.NomeVendedor);
      objLiberacao.objMsgLibera.pAddTexto('Vr.Adiantamento : ' + FormatFloat('#,##0.00',LDocumento.FValorAdiantamento));
      objLiberacao.strDirAce := 'PERBAI';
      objLiberacao.strMsgSen := 'Senha para baixar pedido que não será entregue';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.pInformaNumDocEspDocCodEmp(LDocumento.Numero, LDocumento.Especie, LDocumento.CodigoEmpresa);

      LOk := objLiberacao.fLibera;
    Finally
      FreeAndNil(objLiberacao);
    End;
  End;

  FLiberouTravaAditivo := LOk;
  If Not LOk Then
    Raise EValidaException.Create('');

end;

procedure TBaixarPedOrcNaoEntregue.ValidaAguardandoTransferencia;
var
  LDocumento: TDocumento;
  LfrmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc;
begin
  pCriarFormularios(TfrmFatConfirmaPedOrc, LfrmFatConfirmaPedOrc);
  try
    LfrmFatConfirmaPedOrc.lblTitulo.Caption := 'Os documentos listados abaixo contem pedido(s) de transferência!';
    LfrmFatConfirmaPedOrc.lblRodape.Caption :=
      'Deseja desmarcar este(s) documento(s) para prosseguir com a baixa do(s) outro(s) selecionado(s)?';

    for LDocumento in FListaDocumentos do
    begin
      If not LDocumento.AguardandoTransferencia Then
      Begin
        LfrmFatConfirmaPedOrc.AddDocumento(
          LDocumento.Numero,
          LDocumento.Especie,
          LDocumento.CodigoEmpresa,
          LDocumento.CodigoVendedor,
          LDocumento.NomeVendedor,
          LDocumento.CodigoCliente,
          LDocumento.NomeCliente,
          LDocumento.CodigoClienteNovo,
          LDocumento.NomeClienteNovo
        );
      End;
    end;

    if not LfrmFatConfirmaPedOrc.cdsDados.IsEmpty then
    begin
      if LfrmFatConfirmaPedOrc.ShowModal = MrOk then
        RemoveDocumentos(
          function(ADocumento: TDocumento): Boolean
          begin
            Result := not ADocumento.AguardandoTransferencia;
          end)
       else
         raise EValidaException.Create('');
    end;
  finally
    pFreeAndNil(LfrmFatConfirmaPedOrc);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaBoletosAdiantamento;
begin
  SemDocumentos;

  if MultiplosDocumentos then
    ValidaBoletosAdiantamentoMultiplo
  else
    ValidaBoletosAdiantamentoSimples;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaBoletosAdiantamentoMultiplo;
var
  LDocumento: TDocumento;
  LfrmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc;
begin
  pCriarFormularios(TfrmFatConfirmaPedOrc, LfrmFatConfirmaPedOrc);
  try
    LfrmFatConfirmaPedOrc.lblTitulo.Caption := 'Os documentos listados abaixo possuem boleto(s) de adiantamento!';
    LfrmFatConfirmaPedOrc.lblRodape.Caption :=
      'Deseja desmarcar este(s) documento(s) para prosseguir com a baixa do(s) outro(s) selecionado(s)?';

    for LDocumento in FListaDocumentos do
    begin
      If LDocumento.PossuiBoletosAdiantamento Then
      Begin
        LfrmFatConfirmaPedOrc.AddDocumento(
          LDocumento.Numero,
          LDocumento.Especie,
          LDocumento.CodigoEmpresa,
          LDocumento.CodigoVendedor,
          LDocumento.NomeVendedor,
          LDocumento.CodigoCliente,
          LDocumento.NomeCliente,
          LDocumento.CodigoClienteNovo,
          LDocumento.NomeClienteNovo
        );
      End;
    end;

    if not LfrmFatConfirmaPedOrc.cdsDados.IsEmpty then
    begin
      if LfrmFatConfirmaPedOrc.ShowModal = MrOk then
        RemoveDocumentos(
          function(ADocumento: TDocumento): Boolean
          begin
            Result := ADocumento.PossuiBoletosAdiantamento;
          end)
      else
        raise EValidaException.Create('');
    end;
  finally
    pFreeAndNil(LfrmFatConfirmaPedOrc);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaBoletosAdiantamentoSimples;
var
  LDocumento: TDocumento;
begin
  LDocumento := FListaDocumentos[0];
  If LDocumento.PossuiBoletosAdiantamento Then
  begin
    if not MultiplosDocumentos then
    begin
      If VS_strHabilitarCRM Then
        raise EValidaException.Create('Esse pedido possui boleto(s) de adiantamento. '+ #13#10+
                                      'Para baixá-lo, será necessário carregá-lo para alteração e remover a instrução para geração de boletos. '+ #13#10+
                                      'Assim, ficará liberado para ser baixado por aqui.')
      Else
      raise EValidaException.Create('Esse pedido possui boleto de adiantamento. '+ #13#10+
                                    'Favor verificar e/ou excluí-lo no Manutenção de Contas a Receber antes de baixar o pedido.');
    end
    else
    begin
      raise EValidaException.Create('Esse pedido possui boleto(s) de adiantamento. '+ #13#10+
                                    'Favor utilizar rotina de cancelamento!');
    end;
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaCrm;
begin
  SemDocumentos;

  If ExecutandoPeloCRM Or FblnExecutandoLocEqu Then
    Exit;

  If (VS_strHabilitarCRM) Then
  begin
    If MultiplosDocumentos Then
      ValidaCrmMultiplo
    Else
      ValidaCrmSimples;
  End;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaCrmMultiplo;
var
  LDocumento: TDocumento;
  LfrmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc;
begin
  pCriarFormularios(TfrmFatConfirmaPedOrc, LfrmFatConfirmaPedOrc);
  try
    LfrmFatConfirmaPedOrc.lblTitulo.Caption :=
      'Os documentos listados abaixo possuem movimentações pelo CRM. É necessário concluir a operação via CRM! ' +
      'Acesse a tela do CRM, e clique com o botão direito do mouse sobre a Ocorrência desejada e vá na opção "Baixar (não será entregue)"!';

    LfrmFatConfirmaPedOrc.lblRodape.Caption :=
      'Deseja desmarcar este(s) documento(s) para prosseguir com a baixa do(s) outro(s) selecionado(s)?';

    for LDocumento in FListaDocumentos do
    begin
      If LDocumento.PossuiOcorrencia Then
      Begin
        LfrmFatConfirmaPedOrc.AddDocumento(
          LDocumento.Numero,
          LDocumento.Especie,
          LDocumento.CodigoEmpresa,
          LDocumento.CodigoVendedor,
          LDocumento.NomeVendedor,
          LDocumento.CodigoCliente,
          LDocumento.NomeCliente,
          LDocumento.CodigoClienteNovo,
          LDocumento.NomeClienteNovo
        );
      End;
    end;

    if not LfrmFatConfirmaPedOrc.cdsDados.IsEmpty then
    begin
      if LfrmFatConfirmaPedOrc.ShowModal = MrOk then
        RemoveDocumentos(
          function(ADocumento: TDocumento): Boolean
          begin
            Result := ADocumento.PossuiOcorrencia;
          end)
      else
        raise EValidaException.Create('');
    end;
  finally
    pFreeAndNil(LfrmFatConfirmaPedOrc);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaCrmSimples;
var
  LDocumento: TDocumento;
begin
  LDocumento := FListaDocumentos[0];
  If LDocumento.PossuiOcorrencia Then
    raise EValidaException.Create('Documento possui movimentação pelo CRM. É necessário concluir a operação via CRM! ' +
                                  'Acesse a tela do CRM, e clique com o botão direito do mouse sobre a Ocorrência desejada e vá na opção "Baixar (não será entregue)"!');
end;

procedure TBaixarPedOrcNaoEntregue.ValidaDocumentoOrigem;
begin
  SemDocumentos;

  if MultiplosDocumentos then
    ValidaDocumentoOrigemMultiplo
  else
    ValidaDocumentoOrigemSimples;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaDocumentoOrigemMultiplo;
var
  LDocumento: TDocumento;
  LfrmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc;
begin
  pCriarFormularios(TfrmFatConfirmaPedOrc, LfrmFatConfirmaPedOrc);
  try
    LfrmFatConfirmaPedOrc.lblTitulo.Caption := 'Os documentos listados abaixo foram originados de outros pedidos';
    LfrmFatConfirmaPedOrc.lblRodape.Caption :=
      'Deseja desmarcar este(s) documento(s) para prosseguir com a baixa do(s) outro(s) selecionado(s)?' + sLineBreak +
      'Deseja prosseguir e o(s) documento(s) será(ão) baixado(s)?';

    LfrmFatConfirmaPedOrc.btnLibera.Visible := True;
    LfrmFatConfirmaPedOrc.btnLibera.Caption := 'Prosseguir';
    LfrmFatConfirmaPedOrc.cxgDadosOBSERV.Caption := 'Originado do Documento';
    LfrmFatConfirmaPedOrc.cxgDadosOBSERV.Visible := True;

    for LDocumento in FListaDocumentos do
    begin
      If LDocumento.PedidoComDocumentoOrigem Then
      Begin
        LfrmFatConfirmaPedOrc.AddDocumento(
          LDocumento.Numero,
          LDocumento.Especie,
          LDocumento.CodigoEmpresa,
          LDocumento.CodigoVendedor,
          LDocumento.NomeVendedor,
          LDocumento.CodigoCliente,
          LDocumento.NomeCliente,
          LDocumento.CodigoClienteNovo,
          LDocumento.NomeClienteNovo,
          LDocumento.NumOrigem + '-' + LDocumento.EspOrigem + '-' + LDocumento.EmpOrigem
        );
      End;
    end;

    if not LfrmFatConfirmaPedOrc.cdsDados.IsEmpty then
    begin
      case LfrmFatConfirmaPedOrc.ShowModal of
        mrOk:
          begin
            RemoveDocumentos(
              function(ADocumento: TDocumento): Boolean
              begin
                Result := ADocumento.PedidoComDocumentoOrigem;
              end);
          end;
        mrYes:
          begin
          end;
      else
        raise EValidaException.Create('');
      end;

    end;
  finally
    pFreeAndNil(LfrmFatConfirmaPedOrc);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaDocumentoOrigemSimples;
var
  LDocumento: TDocumento;
begin
  LDocumento := FListaDocumentos[0];
  If LDocumento.PedidoComDocumentoOrigem Then
  Begin
    If fMensagem('ATENÇÃO', 'O pedido selecionado foi originado do pedido ' +
      LDocumento.NumOrigem + '-' + LDocumento.EspOrigem + '-' + LDocumento.EmpOrigem + '. Deseja realmente prosseguir com a baixa?', ['&Sim', '&Não'], 1) = 2 Then
      raise EValidaException.Create('');
  End;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaGeracaoCredito;
begin
  if not fCfgSis('TRACCC', varBoolean) then
    Exit;

  SemDocumentos;
  ValidaGeracaoCreditoMultiplo;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaGeracaoCreditoMultiplo;
var
  LDocumento: TDocumento;
  LfrmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc;
  blnTrocou: Boolean;
begin
  pCriarFormularios(TfrmFatConfirmaPedOrc, LfrmFatConfirmaPedOrc);
  try
    LfrmFatConfirmaPedOrc.lblTitulo.Caption := 'Os documentos listados abaixo são de "Cliente Consumidor" e o '+
                                               'sistema está configurado para não permitir geração de crédito para este '+
                                               'tipo de cliente! (CFG_TRACCC)';
    LfrmFatConfirmaPedOrc.lblRodape.Caption :=
      'Na coluna Cód. Cliente Novo, informe o código do cliente para trocar o cliente do pedido.'+#13#10+
      'Apenas os documentos que contiverem o código do novo cliente serão baixados.';

    LfrmFatConfirmaPedOrc.btnConfirma.Caption := '&Confirma';
    LfrmFatConfirmaPedOrc.cxgDadosCCLNOV.Visible := True;
    LfrmFatConfirmaPedOrc.cxgDadosCCLNOV.Properties.Buttons[0].Visible := True;
    LfrmFatConfirmaPedOrc.cxgDadosNCLNOV.Visible := True;

    for LDocumento in FListaDocumentos do
    begin
      if (LDocumento.EhClienteConsumidor) and (LDocumento.PossuiAdiantamento) then
      begin
        LfrmFatConfirmaPedOrc.AddDocumento(
          LDocumento.Numero,
          LDocumento.Especie,
          LDocumento.CodigoEmpresa,
          LDocumento.CodigoVendedor,
          LDocumento.NomeVendedor,
          LDocumento.CodigoCliente,
          LDocumento.NomeCliente,
          LDocumento.CodigoClienteNovo,
          LDocumento.NomeClienteNovo
        );
      end;
    end;

    if not LfrmFatConfirmaPedOrc.cdsDados.IsEmpty then
    begin
      if fPergunta('Atenção! O sistema está configurado para não permitir '+
               'geração crédito para cliente consumidor (CFG_TRACCC). Deseja trocar o cliente do pedido?') then
      begin

        if fVerificaAcessoSistema('frmFatVendas - PD') then

        begin
          blnTrocou := False;

          if LfrmFatConfirmaPedOrc.ShowModal = MrOk then
          begin
            blnTrocou := fTrocaClientePedido(LfrmFatConfirmaPedOrc.cdsDados);

            RemoveDocumentos(
              function(ADocumento: TDocumento): Boolean
              begin
                Result := (ADocumento.EhClienteConsumidor and not ADocumento.blnTrocaCliente and ADocumento.PossuiAdiantamento);
              end);
          end;

          if not blnTrocou then
            raise EValidaException.Create('');
        end
        else
          raise EValidaException.Create('Atenção! Operador não possui acesso liberado na '+
                                        'rotina de pedido para alterar o cliente.');
      end
      else
        raise EValidaException.Create('');
    end;
  finally
    pFreeAndNil(LfrmFatConfirmaPedOrc);
  end;
end;

function TBaixarPedOrcNaoEntregue.fTrocaClientePedido(cdsDados: TUniClientDataSet): Boolean;
var
  LDocumento: TDocumento;
begin
  Result := False;

  for LDocumento in FListaDocumentos do
  begin
    if (LDocumento.EhClienteConsumidor) and (LDocumento.PossuiAdiantamento) then
    begin
      cdsDados.First;
      while not cdsDados.Eof do
      begin
        if (cdsDados.FieldByName('NUMDOC').AsString = LDocumento.Numero) and
           (cdsDados.FieldByName('ESPDOC').AsString = LDocumento.Especie) and
           (cdsDados.FieldByName('CODEMP').AsString = LDocumento.CodigoEmpresa) and
           (not fEmptyStr(cdsDados.FieldByName('CCLNOV').AsString)) then
        begin
          LDocumento.blnTrocaCliente := True;
          LDocumento.CodigoClienteNovo := cdsDados.FieldByName('CCLNOV').AsString;
          LDocumento.NomeClienteNovo := cdsDados.FieldByName('NCLNOV').AsString;
          Result := True;
          Break;
        end;
        cdsDados.Next;
      end;
    end;
  end;

  if Result then
  begin
    if not fPergunta('Cliente(s) atualizado(s) com sucesso! Deseja prosseguir com a baixa do pedido?') then
      Result := False;
  end;

end;

function TBaixarPedOrcNaoEntregue.fValidarClienteFilial: Boolean;
var
  LDocumento: TDocumento;
  strCodEmpFil: String;
  LQry: TUniQuery;
  fltSaldoDisp: Double;
  arrItemSemSaldo: array of TRecItemSemSaldo;
  objLiberacao: TLiberacao;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
  strPedAnt,
  strPedAtu : String;
  intCnt: Integer;
begin
  Result := True;
  SetLength(arrItemSemSaldo, 0);

  LQry := fCriaQuery();
  Try
    LQry.SQL.Clear;
    LQry.SQL.Add('SELECT FDO_CODITE,          ');
    LQry.SQL.Add('       FDO_NUMLOT,          ');
    LQry.SQL.Add('       FDO_QTDITE,          ');
    LQry.SQL.Add('       FDO_DESCRI,          ');
    LQry.SQL.Add('       FDO_UNIDAD           ');
    LQry.SQL.Add(' FROM FATDOR                ');
    LQry.SQL.Add(' WHERE FDO_CODEMP = :CODEMP ');
    LQry.SQL.Add('   AND FDO_ESPDOC = :ESPDOC ');
    LQry.SQL.Add('   AND FDO_NUMDOC = :NUMDOC ');
    LQry.SQL.Add('   AND (FDO_QTDITE - IFNULL(FDO_QTDBAI, 0)) > 0 ');
    LQry.Prepare;
    For LDocumento in FListaDocumentos Do
    Begin
      If fClienteFilial(LDocumento.CodigoCliente, strCodEmpFil) Then
      Begin
        LQry.ParamByName('CODEMP').AsString := LDocumento.CodigoEmpresa;
        LQry.ParamByName('ESPDOC').AsString := LDocumento.Especie;
        LQry.ParamByName('NUMDOC').AsString := LDocumento.Numero;
        LQry.Open();

        If Not LQry.IsEmpty Then
        Begin
          while not LQry.Eof do
          begin
            fltSaldoDisp := fRetornaSaldoDisponivel(LQry.FieldByName('FDO_CODITE').AsString,
                                                    False, True,
                                                    LQry.FieldByName('FDO_NUMLOT').AsString,
                                                    True,
                                                    strCodEmpFil);

            If (fFormataFloat(fltSaldoDisp, fCfgSis('DECQTD', varInteger))) < (fFormataFloat(LQry.FieldByName('FDO_QTDITE').AsFloat, fCfgSis('DECQTD', varInteger))) Then
            Begin
              SetLength(arrItemSemSaldo, length(arrItemSemSaldo)+1);
              arrItemSemSaldo[length(arrItemSemSaldo)-1].strCodEmp := LDocumento.CodigoEmpresa;
              arrItemSemSaldo[length(arrItemSemSaldo)-1].strEspDoc := LDocumento.Especie;
              arrItemSemSaldo[length(arrItemSemSaldo)-1].strNumDoc := LDocumento.Numero;
              arrItemSemSaldo[length(arrItemSemSaldo)-1].strCodCli := LDocumento.CodigoCliente;
              arrItemSemSaldo[length(arrItemSemSaldo)-1].strNomCli := LDocumento.NomeCliente;

              arrItemSemSaldo[length(arrItemSemSaldo)-1].strCodIte := LQry.FieldByName('FDO_CODITE').AsString;
              arrItemSemSaldo[length(arrItemSemSaldo)-1].strDesIte := LQry.FieldByName('FDO_DESCRI').AsString;
              arrItemSemSaldo[length(arrItemSemSaldo)-1].strSigUni := LQry.FieldByName('FDO_UNIDAD').AsString;
              arrItemSemSaldo[length(arrItemSemSaldo)-1].fltSalDsp := fltSaldoDisp;
            End;

            LQry.Next;
          end;
        End;
      End;
    End;

    strPedAtu := EmptyStr;
    strPedAnt := EmptyStr;
    If length(arrItemSemSaldo) > 0 Then
    Begin
      Result := False;
      objLiberacao := TLiberacao.Create;
      Try
        objLiberacao.strDirAce := 'CFIBAI';
        objLiberacao.strMsgSen := 'Senha para baixar pedido de cliente filial que não será entregue';
        objLiberacao.objMsgLibera.pAddTexto('Pedido de cliente filial sendo baixado como não entregue.');
        objLiberacao.objMsgLibera.pAddTexto('');
        objTabela := TRegistroMsgLiberaTabela.Create;
        For intCnt:=0 To length(arrItemSemSaldo)-1 Do
        Begin
          strPedAtu := arrItemSemSaldo[intCnt].strCodEmp + '-' +
                       arrItemSemSaldo[intCnt].strEspDoc + '-' +
                       arrItemSemSaldo[intCnt].strNumDoc;

          If strPedAtu <> strPedAnt Then
          Begin
            objLiberacao.objMsgLibera.pAddTexto('');
            objLiberacao.objMsgLibera.pAddTexto('--------------------------------------------------------------------------');
            objLiberacao.objMsgLibera.pAddTextoCaption('Documento', FListaDocumentos[intCnt].Numero,12 );
            objLiberacao.objMsgLibera.pAddTextoCaption('Cliente  ', FListaDocumentos[intCnt].NomeCliente,12 );

            objLinha  := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlCabecalho;
            objLinha.pAddColuna(''  , 'Cód.Item'               , 7  , alEsquerda , teAutcom);
            objLinha.pAddColuna(''  , 'Descrição'              , 40 , alEsquerda , teAutcom);
            objLinha.pAddColuna(''  , 'Un.'                    , 6  , alCentro   , teAutcom);
            objLinha.pAddColuna(''  , 'Saldo'                  , 14 , alEsquerda , teAutcom);
            objTabela.lstLinhas.Add(objLinha);
          End;

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('Cód.Item' , arrItemSemSaldo[intCnt].strCodIte              ,7  , alEsquerda);
          objLinha.pAddColuna('Descrição', arrItemSemSaldo[intCnt].strDesIte              ,40 , alEsquerda);
          objLinha.pAddColuna('Un.'      , fRetSiglaUni(arrItemSemSaldo[intCnt].strSigUni),6 , alCentro  );
          objLinha.pAddColuna('Saldo'    , FormatFloat(fMskDigitos(4),arrItemSemSaldo[intCnt].fltSalDsp) ,14, alDireita);
          objTabela.lstLinhas.Add(objLinha);

          strPedAnt := arrItemSemSaldo[intCnt].strCodEmp + '-' +
                       arrItemSemSaldo[intCnt].strEspDoc + '-' +
                       arrItemSemSaldo[intCnt].strNumDoc;
        End;

        If Not objTabela.isEmpty Then
        Begin
          objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
          Result := objLiberacao.fLibera;
        End;

      Finally
        FreeAndNil(objLiberacao);
      End;
    End;

  Finally
    FreeAndNil(LQry);

    If Not Result Then
      raise EValidaException.Create('');
  End;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaDocumento;
begin
  If (RealizouValidacao) Then
    Exit;

  ValidaGeracaoCredito;
  ValidaAditivo;
  ValidaCrm;
  ValidaJaFaturado;
  ValidaOrdemProducao;
  ValidaTinDorBaixado;
  ValidaVinculadoGarantia;
  ValidaPedidoComPedAbastecimento;

  If Not FLiberouBaixaDePedidoNaoEntregue Then
    ValidaTransferenciasRequisicoes;

  ValidaPedidoPossuiItensEmSemparacao;
  ValidaPedidoOriginadoDeTransferencia;
  ValidaBoletosAdiantamento;
  ValidaPedidoComRequisicaoEmAbertoComPedidoDeCompra;
  ValidaPedidoComRequisicaoEmAbertoSemPedidoDeCompra;
  ValidaDocumentoOrigem;
  ValidaPedidoComOS;
  fValidarClienteFilial;
  ValidaPixEmAberto;

  SemDocumentos;
end;

procedure TBaixarPedOrcNaoEntregue.pVerificaAbastecimentoTransf(ADocumento: TDocumento);
var
  LMensagem: TStringList;
begin
  LMensagem := TStringList.Create;

  try
    pValidaPDComAbastecimentoTransf(ADocumento.Numero,
                                    ADocumento.Especie,
                                    ADocumento.CodigoEmpresa,
                                    LMensagem);

    if (LMensagem.Count > 0) then
    begin
      pMostraMensagemAbastecimentoTransf(LMensagem);
      raise EValidaException.Create('');
    end;
    FLiberouBaixaDePedidoNaoEntregue := True;
  finally
    FreeAndNil(LMensagem);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaJaFaturado;
begin
  SemDocumentos;

  if MultiplosDocumentos then
    ValidaJaFaturadoMultiplo
  else
    ValidaJaFaturadoSimples;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaJaFaturadoMultiplo;
var
  LDocumento: TDocumento;
  LfrmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc;
  strMensagem: String;

begin
  pCriarFormularios(TfrmFatConfirmaPedOrc, LfrmFatConfirmaPedOrc);
  try
    LfrmFatConfirmaPedOrc.lblTitulo.Caption := 'Os documentos listados abaixo já foram faturados/baixados!';
    LfrmFatConfirmaPedOrc.lblRodape.Caption :=
      'Deseja desmarcar este(s) documento(s) para prosseguir com a baixa do(s) outro(s) selecionado(s)?';

    for LDocumento in FListaDocumentos do
    begin
      If LDocumento.JaFaturado Then
      Begin
        LfrmFatConfirmaPedOrc.AddDocumento(
          LDocumento.Numero,
          LDocumento.Especie,
          LDocumento.CodigoEmpresa,
          LDocumento.CodigoVendedor,
          LDocumento.NomeVendedor,
          LDocumento.CodigoCliente,
          LDocumento.NomeCliente,
          LDocumento.CodigoClienteNovo,
          LDocumento.NomeClienteNovo
        );
      End;
    end;

    if not LfrmFatConfirmaPedOrc.cdsDados.IsEmpty then
    begin
      if LfrmFatConfirmaPedOrc.ShowModal = MrOk then
        RemoveDocumentos(
          function(ADocumento: TDocumento): Boolean
          begin
            Result := ADocumento.JaFaturado;
          end)
      else
        raise EValidaException.Create('');
    end;

    strMensagem := '';
    for LDocumento in FListaDocumentos do
    begin
      if LDocumento.ExcluiuOrdemProducao then
        strMensagem := StrMensagem + LDocumento.MensagemOrdemProducao;
    end;

    if strMensagem <> '' then
      fMensagem('', strMensagem, ['&O K']);

  finally
    pFreeAndNil(LfrmFatConfirmaPedOrc);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaJaFaturadoSimples;
var
  LDocumento: TDocumento;
begin
  LDocumento := FListaDocumentos[0];
  If LDocumento.JaFaturado Then
    raise EValidaException.Create('Esse ' + IIF(LDocumento.Especie = 'PD','pedido','orçamento') +
                          ' já foi ' + IIF(fEmptyStr(LDocumento.MotivoBaixa), 'faturado', 'baixado') + '!');
end;

procedure TBaixarPedOrcNaoEntregue.ValidaOrdemProducao;
begin
  SemDocumentos;

  if MultiplosDocumentos then
    ValidaOrdemProducaoMultiplo
  else
    ValidaOrdemProducaoSimples;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaOrdemProducaoMultiplo;
var
  LDocumento: TDocumento;
  LfrmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc;
begin
  pCriarFormularios(TfrmFatConfirmaPedOrc, LfrmFatConfirmaPedOrc);
  try
    LfrmFatConfirmaPedOrc.lblTitulo.Caption := 'Os documentos listados abaixo geraram ordem de produção!';
    LfrmFatConfirmaPedOrc.lblRodape.Caption :=
      'Deseja desmarcar este(s) documento(s) para prosseguir com a baixa do(s) outro(s) selecionado(s)?';

    for LDocumento in FListaDocumentos do
    begin
      If LDocumento.GerouOrdemProducao Then
      Begin
        LfrmFatConfirmaPedOrc.AddDocumento(
          LDocumento.Numero,
          LDocumento.Especie,
          LDocumento.CodigoEmpresa,
          LDocumento.CodigoVendedor,
          LDocumento.NomeVendedor,
          LDocumento.CodigoCliente,
          LDocumento.NomeCliente,
          LDocumento.CodigoClienteNovo,
          LDocumento.NomeClienteNovo
        );
      End;
    end;

    if not LfrmFatConfirmaPedOrc.cdsDados.IsEmpty then
    begin
      if LfrmFatConfirmaPedOrc.ShowModal = MrOk then
        RemoveDocumentos(
          function(ADocumento: TDocumento): Boolean
          begin
            Result := ADocumento.GerouOrdemProducao;
          end)
      else
        raise EValidaException.Create('');
    end;
  finally
    pFreeAndNil(LfrmFatConfirmaPedOrc);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaOrdemProducaoSimples;
var
  LDocumento: TDocumento;
begin
  LDocumento := FListaDocumentos[0];
  If LDocumento.GerouOrdemProducao Then
    raise EValidaException.Create(LDocumento.MensagemOrdemProducao)
  else
   begin
     if LDocumento.ExcluiuOrdemProducao then
       fMensagem('', LDocumento.MensagemOrdemProducao, ['&O K']);
   end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPixEmAberto;
var
  LDocumento: TDocumento;
begin
  LDocumento := FListaDocumentos[0];
  If (LDocumento.FEspecie = 'PD') Then
  Begin
    if MatchStr(TPixDao.RetornaStatusSePedidoPossuirPix(LDocumento.FNumero, LDocumento.FEspecie, VS_strCodEmp), STATUS_PIX_ATIVO) Then
    begin
      fMensagem('PIX',
                'Pedido ' +
                LDocumento.FNumero + '-' +
                LDocumento.FEspecie + '-' +
                VS_strCodEmp +
                ' possuí cobrança Pix ativa!' + #13 +
                'Para cancelar o documento, é necessário remover o Pix do pedido.',
                ['&OK']);

      Raise EValidaException.Create('');
    end;
  End;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoComOS;
begin
  SemDocumentos;

  if MultiplosDocumentos then
    ValidaPedidoComOSMultiplo
  else
    ValidaPedidoComOSSimples;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoComOSMultiplo;
var
  LDocumento: TDocumento;
  LfrmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc;
begin
  pCriarFormularios(TfrmFatConfirmaPedOrc, LfrmFatConfirmaPedOrc);
  try
    LfrmFatConfirmaPedOrc.lblTitulo.Caption := 'Os Pedidos listados abaixo possuem vínculo com Ordem de Serviço. ' +
      'Acesse a rotina de Conserto de Equipamentos e reprove a Ordem de Serviço para baixar o Pedido de Venda.';
    LfrmFatConfirmaPedOrc.lblRodape.Caption :=
      'Deseja desmarcar este(s) documento(s) para prosseguir com a baixa do(s) outro(s) selecionado(s)?';

    LfrmFatConfirmaPedOrc.btnConfirma.Visible := True;
    LfrmFatConfirmaPedOrc.cxgDadosOBSERV.Caption := 'Ordem Serviço';
    LfrmFatConfirmaPedOrc.cxgDadosOBSERV.Visible := True;

    for LDocumento in FListaDocumentos do
    begin
      If LDocumento.PedidoComOrdemServico Then
      Begin
        LfrmFatConfirmaPedOrc.AddDocumento(
          LDocumento.Numero,
          LDocumento.Especie,
          LDocumento.CodigoEmpresa,
          LDocumento.CodigoVendedor,
          LDocumento.NomeVendedor,
          LDocumento.CodigoCliente,
          LDocumento.NomeCliente,
          LDocumento.CodigoClienteNovo,
          LDocumento.NomeClienteNovo,
          LDocumento.NumOrdemServico
        );
      End;
    end;

    if not LfrmFatConfirmaPedOrc.cdsDados.IsEmpty then
    begin
      if LfrmFatConfirmaPedOrc.ShowModal = MrOk then
        RemoveDocumentos(
          function(ADocumento: TDocumento): Boolean
          begin
            Result := ADocumento.PedidoComOrdemServico;
          end)
      else
        raise EValidaException.Create('');
    end;
  finally
    pFreeAndNil(LfrmFatConfirmaPedOrc);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoComOSSimples;
var
  LDocumento: TDocumento;
begin
  LDocumento := FListaDocumentos[0];

  if LDocumento.PedidoComOrdemServico then
  begin
    fMensagem('ATENÇÃO', 'Pedido possui vínculo com Ordem de Serviço. Acesse a rotina de Conserto de Equipamentos ' +
              'e reprove a Ordem de Serviço para baixar o Pedido de Venda.', ['&Ok']);
    raise EValidaException.Create('');
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoComPedAbastecimento;
begin
  SemDocumentos;

  If MultiplosDocumentos Then
    ValidaPedidoComPedAbastecimentoMultiplo
  Else
    ValidaPedidoComPedAbastecimentoSimples;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoComPedAbastecimentoMultiplo;
var
  LDocumento: TDocumento;
  LfrmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc;
begin
  pCriarFormularios(TfrmFatConfirmaPedOrc, LfrmFatConfirmaPedOrc);
  Try
    LfrmFatConfirmaPedOrc.lblTitulo.Caption := 'Os documentos listados abaixo geraram pedido de abastecimento!';
    LfrmFatConfirmaPedOrc.lblRodape.Caption :=
      'Deseja desmarcar este(s) documento(s) para prosseguir com a baixa do(s) outro(s) selecionado(s)?';

    For LDocumento In FListaDocumentos Do
    Begin
      If LDocumento.PedidoComPedAbastecimento Then
      Begin
        LfrmFatConfirmaPedOrc.AddDocumento(
          LDocumento.Numero,
          LDocumento.Especie,
          LDocumento.CodigoEmpresa,
          LDocumento.CodigoVendedor,
          LDocumento.NomeVendedor,
          LDocumento.CodigoCliente,
          LDocumento.NomeCliente,
          LDocumento.CodigoClienteNovo,
          LDocumento.NomeClienteNovo
        );
      End;
    End;

    If Not LfrmFatConfirmaPedOrc.cdsDados.IsEmpty Then
    Begin
      If LfrmFatConfirmaPedOrc.ShowModal = MrOk Then
        RemoveDocumentos(
          function(ADocumento: TDocumento): Boolean
          begin
            Result := ADocumento.PedidoComPedAbastecimento;
          end)
      Else
        Raise EValidaException.Create('');
    End;
  Finally
    pFreeAndNil(LfrmFatConfirmaPedOrc);
  End;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoComPedAbastecimentoSimples;
var
  LDocumento: TDocumento;
  LOk: Boolean;
  LMensagem: String;
  objLiberacao : TLiberacao;
begin
  LOk := True;
  LDocumento := FListaDocumentos[0];
  If LDocumento.PedidoComPedAbastecimento Then
  Begin
    if fCfgSis('CPDABT', varBoolean) then
    begin
      LMensagem := 'Este pedido de venda está vinculado a um pedido de abastecimento ('+LDocumento.FDocAbs+'-'+LDocumento.FEspAbs+'-'+LDocumento.FEmpAbs+'). ';
      LMensagem := LMensagem + sLineBreak + 'Para baixar o pedido de venda, é necessário solicitar senha de liberação. Deseja continuar?';

      If fMensagem('ATENÇÃO!', LMensagem, ['&Sim', '&Não']) = 2 Then
        Raise EValidaException.Create('');

      objLiberacao := TLiberacao.Create;

      try
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Permitir baixar pedidos com abastecimento por transferência de estoque vinculado');
        objLiberacao.strDirAce := 'BPATEV';
        objLiberacao.strMsgSen := 'Senha para Permitir baixar pedidos com abastecimento por transferência de estoque vinculado';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.pInformaNumDocEspDocCodEmp(LDocumento.Numero, LDocumento.Especie, LDocumento.CodigoEmpresa);

        FLiberouBaixaDePedidoNaoEntregue := objLiberacao.fLibera;
        LOk := FLiberouBaixaDePedidoNaoEntregue;
      finally
        FreeAndNil(objLiberacao);
      end;
    end
    else
      pVerificaAbastecimentoTransf(LDocumento);
  End;

  If Not LOk Then
    Raise EValidaException.Create('');
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoComRequisicaoEmAbertoComPedidoDeCompra;
begin
  SemDocumentos;

  if MultiplosDocumentos then
    ValidaPedidoComRequisicaoEmAbertoComPedidoDeCompraMultiplo
  else
    ValidaPedidoComRequisicaoEmAbertoComPedidoDeCompraSimples;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoComRequisicaoEmAbertoComPedidoDeCompraMultiplo;
var
  LDocumento: TDocumento;
  LfrmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc;
begin
  pCriarFormularios(TfrmFatConfirmaPedOrc, LfrmFatConfirmaPedOrc);
  try
    LfrmFatConfirmaPedOrc.lblTitulo.Caption := 'Os documentos listados abaixo estão vinculado a uma requisição que foi comprada por um ou mais pedido(s) de compra!';
    LfrmFatConfirmaPedOrc.lblRodape.Caption :=
      'Deseja desmarcar este(s) documento(s) para prosseguir com a baixa do(s) outro(s) selecionado(s)?';

    for LDocumento in FListaDocumentos do
    begin
      If LDocumento.PedidoComRequisicaoEmAbertoComPedidoDeCompra Then
      Begin
        LfrmFatConfirmaPedOrc.AddDocumento(
          LDocumento.Numero,
          LDocumento.Especie,
          LDocumento.CodigoEmpresa,
          LDocumento.CodigoVendedor,
          LDocumento.NomeVendedor,
          LDocumento.CodigoCliente,
          LDocumento.NomeCliente,
          LDocumento.CodigoClienteNovo,
          LDocumento.NomeClienteNovo
        );
      End;
    end;

    if not LfrmFatConfirmaPedOrc.cdsDados.IsEmpty then
    begin
      if LfrmFatConfirmaPedOrc.ShowModal = MrOk then
        RemoveDocumentos(
          function(ADocumento: TDocumento): Boolean
          begin
            Result := ADocumento.PedidoComRequisicaoEmAbertoComPedidoDeCompra;
          end)
      else
        raise EValidaException.Create('');
    end;
  finally
    pFreeAndNil(LfrmFatConfirmaPedOrc);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoComRequisicaoEmAbertoComPedidoDeCompraSimples;
var
  LDocumento: TDocumento;
  strNTrava: String;
begin
  LDocumento := FListaDocumentos[0];
  If LDocumento.PedidoComRequisicaoEmAbertoComPedidoDeCompra Then
  Begin
    If fMensagem('ATENÇÃO', ' Este pedido de venda está vinculado a uma requisição que foi comprada por um ou mais'+
    ' pedido(s) de compra. '+ #13#10+
    'Para baixar o pedido de venda, é necessário solicitar senha de liberação. Deseja continuar?', ['&Sim', '&Não'], 2) = 2 Then
      raise EValidaException.Create('');

    If (Not fMensagemLiberacao(LDocumento.objLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra, strNTrava, nil)) Then
      raise EValidaException.Create('')
    else
      pGeraLogLiberacao(LDocumento.Numero, LDocumento.Especie, LDocumento.CodigoEmpresa);
  End;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoComRequisicaoEmAbertoSemPedidoDeCompra;
begin
  SemDocumentos;

  if MultiplosDocumentos then
    ValidaPedidoComRequisicaoEmAbertoSemPedidoDeCompraMultiplo
  else
    ValidaPedidoComRequisicaoEmAbertoSemPedidoDeCompraSimples;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoComRequisicaoEmAbertoSemPedidoDeCompraMultiplo;
var
  LDocumento: TDocumento;
  LfrmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc;
begin
  pCriarFormularios(TfrmFatConfirmaPedOrc, LfrmFatConfirmaPedOrc);
  try
    LfrmFatConfirmaPedOrc.lblTitulo.Caption := 'Os documentos listados abaixo estão vinculado a uma requisição porém sem pedido de compra vinculado!';
    LfrmFatConfirmaPedOrc.lblRodape.Caption :=
      'Deseja desmarcar este(s) documento(s) para prosseguir com a baixa do(s) outro(s) selecionado(s)?';

    for LDocumento in FListaDocumentos do
    begin
      If LDocumento.PedidoComRequisicaoEmAbertoSemPedidoDeCompra Then
      Begin
        LfrmFatConfirmaPedOrc.AddDocumento(
          LDocumento.Numero,
          LDocumento.Especie,
          LDocumento.CodigoEmpresa,
          LDocumento.CodigoVendedor,
          LDocumento.NomeVendedor,
          LDocumento.CodigoCliente,
          LDocumento.NomeCliente,
          LDocumento.CodigoClienteNovo,
          LDocumento.NomeClienteNovo
        );
      End;
    end;

    if not LfrmFatConfirmaPedOrc.cdsDados.IsEmpty then
    begin
      if LfrmFatConfirmaPedOrc.ShowModal = MrOk then
        RemoveDocumentos(
          function(ADocumento: TDocumento): Boolean
          begin
            Result := ADocumento.PedidoComRequisicaoEmAbertoSemPedidoDeCompra;
          end)
      else
        raise EValidaException.Create('');
    end;
  finally
    pFreeAndNil(LfrmFatConfirmaPedOrc);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoComRequisicaoEmAbertoSemPedidoDeCompraSimples;
var
  LDocumento: TDocumento;
begin
  LDocumento := FListaDocumentos[0];
  If LDocumento.PedidoComRequisicaoEmAbertoSemPedidoDeCompra Then
  Begin
    If fMensagem('ATENÇÃO', 'Este registro está vinculado à requisição de compra "'+LDocumento.NumeroRequisicao+'", '+
    'porém sem pedido de compra vinculado. Se baixar este registro esta requisição será excluída. Confirma a baixa? ', ['&Sim', '&Não'], 1) = 1 Then
    begin
      pExcluiRequisicoesDeCompraVinculadasAoDocumento(LDocumento.FNumero,
                                                      LDocumento.FEspecie,
                                                      LDocumento.FCodigoEmpresa);
    end
    else
      raise EValidaException.Create('');
  End;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoOriginadoDeTransferencia;
begin
  SemDocumentos;

  if MultiplosDocumentos then
    ValidaPedidoOriginadoDeTransferenciaMultiplo
  else
    ValidaPedidoOriginadoDeTransferenciaSimples;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoOriginadoDeTransferenciaMultiplo;
var
  LDocumento: TDocumento;
  LfrmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc;
begin
  pCriarFormularios(TfrmFatConfirmaPedOrc, LfrmFatConfirmaPedOrc);
  try
    LfrmFatConfirmaPedOrc.lblTitulo.Caption := 'Os documentos listados abaixo possuem baixa de pedido originado a partir de uma solicitação de transferência!';
    LfrmFatConfirmaPedOrc.lblRodape.Caption :=
      'Deseja desmarcar este(s) documento(s) para prosseguir com a baixa do(s) outro(s) selecionado(s)?';

    for LDocumento in FListaDocumentos do
    begin
      If LDocumento.PedidoOriginadoDeTransferencia Then
      Begin
        LfrmFatConfirmaPedOrc.AddDocumento(
          LDocumento.Numero,
          LDocumento.Especie,
          LDocumento.CodigoEmpresa,
          LDocumento.CodigoVendedor,
          LDocumento.NomeVendedor,
          LDocumento.CodigoCliente,
          LDocumento.NomeCliente,
          LDocumento.CodigoClienteNovo,
          LDocumento.NomeClienteNovo
        );
      End;
    end;

    if not LfrmFatConfirmaPedOrc.cdsDados.IsEmpty then
    begin
      if LfrmFatConfirmaPedOrc.ShowModal = MrOk then
        RemoveDocumentos(
          function(ADocumento: TDocumento): Boolean
          begin
            Result := ADocumento.PedidoOriginadoDeTransferencia;
          end)
      else
        raise EValidaException.Create('');
    end;
  finally
    pFreeAndNil(LfrmFatConfirmaPedOrc);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoOriginadoDeTransferenciaSimples;
var
  LDocumento: TDocumento;
  LobjLiberacao : TLiberacao;
  strNTrava: String;
begin
  if (not fCfgSis('CPDABT', varBoolean)) then
    Exit;

  LDocumento := FListaDocumentos[0];
  If LDocumento.PedidoOriginadoDeTransferencia Then
  Begin
    LobjLiberacao := TLiberacao.Create;
    try
      LobjLiberacao.strMsgSen := 'CRM - Baixa de pedido originado a partir de uma solicitação de transferência';
      LobjLiberacao.objMsgLibera.pAddTexto(LobjLiberacao.strMsgSen);
      LobjLiberacao.objMsgLibera.pAddTextoCaption('Pedido' , LDocumento.FDocAbs, 08);
      LobjLiberacao.objMsgLibera.pAddTextoCaption('Espécie', LDocumento.FEspAbs, 08);
      LobjLiberacao.objMsgLibera.pAddTextoCaption('Empresa', LDocumento.FEmpAbs, 08);
      LobjLiberacao.strDirAce := 'BXACTRA';
      LobjLiberacao.blnTraTel := True;
      LobjLiberacao.strSenLib := '';
      LobjLiberacao.blnMosMen := True;
      LobjLiberacao.strCodOpe := strLoginUsuarioLogado;
      LobjLiberacao.strCodDig := '';

      if (Not fMensagemLiberacao(LobjLiberacao, strNTrava, nil)) then
        raise EValidaException.Create('');
    finally
      FreeAndNil(LobjLiberacao);
    end;
  End;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoPossuiItensEmSemparacao;
begin
  SemDocumentos;

  If (Self.LimparSeparacao) Then
    Exit;

  if MultiplosDocumentos then
    ValidaPedidoPossuiItensEmSemparacaoMultiplo
  else
    ValidaPedidoPossuiItensEmSemparacaoSimples;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoPossuiItensEmSemparacaoMultiplo;
var
  LDocumento: TDocumento;
  LfrmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc;
begin
  pCriarFormularios(TfrmFatConfirmaPedOrc, LfrmFatConfirmaPedOrc);
  try
    LfrmFatConfirmaPedOrc.lblTitulo.Caption := 'Os documentos listados abaixo estão em separação!';
    LfrmFatConfirmaPedOrc.lblRodape.Caption :=
      'Deseja desmarcar este(s) documento(s) para prosseguir com a baixa do(s) outro(s) selecionado(s)?';

    for LDocumento in FListaDocumentos do
    begin
      If LDocumento.PedidoPossuiItensEmSemparacao Then
      Begin
        LfrmFatConfirmaPedOrc.AddDocumento(
          LDocumento.Numero,
          LDocumento.Especie,
          LDocumento.CodigoEmpresa,
          LDocumento.CodigoVendedor,
          LDocumento.NomeVendedor,
          LDocumento.CodigoCliente,
          LDocumento.NomeCliente,
          LDocumento.CodigoClienteNovo,
          LDocumento.NomeClienteNovo
        );
      End;
    end;

    if not LfrmFatConfirmaPedOrc.cdsDados.IsEmpty then
    begin
      if LfrmFatConfirmaPedOrc.ShowModal = MrOk then
        RemoveDocumentos(
          function(ADocumento: TDocumento): Boolean
          begin
            Result := ADocumento.PedidoPossuiItensEmSemparacao;
          end)
      else
        raise EValidaPedidoPossuiItensEmSeparacao.Create('');
    end;
  finally
    pFreeAndNil(LfrmFatConfirmaPedOrc);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoPossuiItensEmSemparacaoSimples;
var
  LDocumento: TDocumento;
begin
  LDocumento := FListaDocumentos[0];
  If LDocumento.PedidoPossuiItensEmSemparacao Then
    raise EValidaPedidoPossuiItensEmSeparacao.Create('Pedido está em separação, para efetuar a baixa é necessário solicitar para o separador "Limpar a Separação"');
end;

procedure TBaixarPedOrcNaoEntregue.ValidaPedidoTransferencia;
var
  LDocumento: TDocumento;
  LfrmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc;
begin
  pCriarFormularios(TfrmFatConfirmaPedOrc, LfrmFatConfirmaPedOrc);
  try
    LfrmFatConfirmaPedOrc.lblTitulo.Caption := 'Os documentos listados abaixo aguardam a geração do(s) pedido(s) de transferência!';
    LfrmFatConfirmaPedOrc.lblRodape.Caption :=
      'Deseja desmarcar este(s) documento(s) para prosseguir com a baixa do(s) outro(s) selecionado(s)?';

    for LDocumento in FListaDocumentos do
    begin
      If not LDocumento.PedidoTransferencia Then
      Begin
        LfrmFatConfirmaPedOrc.AddDocumento(
          LDocumento.Numero,
          LDocumento.Especie,
          LDocumento.CodigoEmpresa,
          LDocumento.CodigoVendedor,
          LDocumento.NomeVendedor,
          LDocumento.CodigoCliente,
          LDocumento.NomeCliente,
          LDocumento.CodigoClienteNovo,
          LDocumento.NomeClienteNovo
        );
      End;
    end;

    if not LfrmFatConfirmaPedOrc.cdsDados.IsEmpty then
    begin
      if LfrmFatConfirmaPedOrc.ShowModal = MrOk then
        RemoveDocumentos(
          function(ADocumento: TDocumento): Boolean
          begin
            Result := not ADocumento.PedidoTransferencia;
          end)
      else
        raise EValidaException.Create('');
    end;
  finally
    pFreeAndNil(LfrmFatConfirmaPedOrc);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaRequisicaoCompra;
var
  LDocumento: TDocumento;
  LfrmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc;
begin
  pCriarFormularios(TfrmFatConfirmaPedOrc, LfrmFatConfirmaPedOrc);
  try
    LfrmFatConfirmaPedOrc.lblTitulo.Caption := 'Os documentos listados abaixo aguardam a geração da(s) requisição(ões) de compra!';
    LfrmFatConfirmaPedOrc.lblRodape.Caption :=
      'Deseja desmarcar este(s) documento(s) para prosseguir com a baixa do(s) outro(s) selecionado(s)?';

    for LDocumento in FListaDocumentos do
    begin
      If not LDocumento.RequisicaoCompra Then
      Begin
        LfrmFatConfirmaPedOrc.AddDocumento(
          LDocumento.Numero,
          LDocumento.Especie,
          LDocumento.CodigoEmpresa,
          LDocumento.CodigoVendedor,
          LDocumento.NomeVendedor,
          LDocumento.CodigoCliente,
          LDocumento.NomeCliente,
          LDocumento.CodigoClienteNovo,
          LDocumento.NomeClienteNovo
        );
      End;
    end;

    if not LfrmFatConfirmaPedOrc.cdsDados.IsEmpty then
    begin
      if LfrmFatConfirmaPedOrc.ShowModal = MrOk then
        RemoveDocumentos(
          function(ADocumento: TDocumento): Boolean
          begin
            Result := not ADocumento.RequisicaoCompra;
          end)
      else
        raise EValidaException.Create('');
    end;
  finally
    pFreeAndNil(LfrmFatConfirmaPedOrc);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaTinDorBaixado;
begin
  SemDocumentos;

  if MultiplosDocumentos then
    ValidaTinDorBaixadoMultiplo
  else
    ValidaTinDorBaixadoSimples;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaTinDorBaixadoMultiplo;
var
  LDocumento: TDocumento;
  LfrmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc;
begin
  pCriarFormularios(TfrmFatConfirmaPedOrc, LfrmFatConfirmaPedOrc);
  try
    LfrmFatConfirmaPedOrc.lblTitulo.Caption := 'Os documentos listados abaixo possuem a formulação de tinta de máquina já baixada!';
    LfrmFatConfirmaPedOrc.lblRodape.Caption :=
      'Deseja desmarcar este(s) documento(s) para prosseguir com a baixa do(s) outro(s) selecionado(s)?';

    for LDocumento in FListaDocumentos do
    begin
      If LDocumento.TinDorBaixado Then
      Begin
        LfrmFatConfirmaPedOrc.AddDocumento(
          LDocumento.Numero,
          LDocumento.Especie,
          LDocumento.CodigoEmpresa,
          LDocumento.CodigoVendedor,
          LDocumento.NomeVendedor,
          LDocumento.CodigoCliente,
          LDocumento.NomeCliente,
          LDocumento.CodigoClienteNovo,
          LDocumento.NomeClienteNovo
        );
      End;
    end;

    if not LfrmFatConfirmaPedOrc.cdsDados.IsEmpty then
    begin
      if LfrmFatConfirmaPedOrc.ShowModal = MrOk then
        RemoveDocumentos(
          function(ADocumento: TDocumento): Boolean
          begin
            Result := ADocumento.TinDorBaixado;
          end)
      else
        raise EValidaException.Create('');
    end;
  finally
    pFreeAndNil(LfrmFatConfirmaPedOrc);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaTinDorBaixadoSimples;
var
  LDocumento: TDocumento;
begin
  LDocumento := FListaDocumentos[0];
  If LDocumento.TinDorBaixado Then
    raise EValidaException.Create('Esse ' + IIF(LDocumento.Especie = 'PD','pedido','orçamento') +
                        ' não poderá ser baixado, ' + #13#10 +
                        'pois a formulação de tinta de máquina já foi baixada !' + #13#10 +
                        'Para baixar o pedido será necessário desmarcar a baixa da formulação');
end;

procedure TBaixarPedOrcNaoEntregue.ValidaTransferenciasRequisicoes;
begin
  SemDocumentos;

  if MultiplosDocumentos then
    ValidaTransferenciasRequisicoesMultiplo
  else
    ValidaTransferenciasRequisicoesSimples;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaTransferenciasRequisicoesMultiplo;
begin
  SemDocumentos;
  ValidaPedidoTransferencia;

  SemDocumentos;
  ValidaAguardandoTransferencia;

  SemDocumentos;
  ValidaRequisicaoCompra;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaTransferenciasRequisicoesSimples;
var
  LDocumento: TDocumento;
begin
  LDocumento := FListaDocumentos[0];
  if (not LDocumento.PedidoTransferencia) or
     (not LDocumento.AguardandoTransferencia) or
     (not LDocumento.RequisicaoCompra) then
  Begin
    pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
    Try
      frmMensagemExplicativa.Caption := 'Não será possível realizar baixa do pedido';
      frmMensagemExplicativa.Width   := 650;
      frmMensagemExplicativa.Height  := 300;
      frmMensagemExplicativa.mmoInstru.Lines.Add(LDocumento.ListVerificar.Text);
      frmMensagemExplicativa.ShowModal;
    Finally
      FreeAndNil(frmMensagemExplicativa);
    End;
    raise EValidaException.Create('');
  End;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaVinculadoGarantia;
begin
  SemDocumentos;

  if MultiplosDocumentos then
    ValidaVinculadoGarantiaMultiplo
  else
    ValidaVinculadoGarantiaSimples;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaVinculadoGarantiaMultiplo;
var
  LDocumento: TDocumento;
  LfrmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc;
begin
  pCriarFormularios(TfrmFatConfirmaPedOrc, LfrmFatConfirmaPedOrc);
  try
    LfrmFatConfirmaPedOrc.lblTitulo.Caption := 'Os documentos listados abaixo contem vínculo com Garantia!';
    LfrmFatConfirmaPedOrc.lblRodape.Caption :=
      'Deseja desmarcar este(s) documento(s) para prosseguir com a baixa do(s) outro(s) selecionado(s)?';

    for LDocumento in FListaDocumentos do
    begin
      If LDocumento.VinculadoGarantia Then
      Begin
        LfrmFatConfirmaPedOrc.AddDocumento(
          LDocumento.Numero,
          LDocumento.Especie,
          LDocumento.CodigoEmpresa,
          LDocumento.CodigoVendedor,
          LDocumento.NomeVendedor,
          LDocumento.CodigoCliente,
          LDocumento.NomeCliente,
          LDocumento.CodigoClienteNovo,
          LDocumento.NomeClienteNovo
        );
      End;
    end;

    if not LfrmFatConfirmaPedOrc.cdsDados.IsEmpty then
    begin
      if LfrmFatConfirmaPedOrc.ShowModal = MrOk then
        RemoveDocumentos(
          function(ADocumento: TDocumento): Boolean
          begin
            Result := ADocumento.VinculadoGarantia;
          end)
      else
        raise EValidaException.Create('');
    end;
  finally
    pFreeAndNil(LfrmFatConfirmaPedOrc);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.ValidaVinculadoGarantiaSimples;
var
  LDocumento: TDocumento;
begin
  LDocumento := FListaDocumentos[0];
  If LDocumento.VinculadoGarantia Then
    raise EValidaException.Create('Não será possível realizar baixa, pois o Pedido contem vínculo com Garantia: GA [' + LDocumento.NumeroGarantia + ']  !');
end;

function  TBaixarPedOrcNaoEntregue.VerificarAcessoLiberacao : Boolean;
Var
  objLiberacao : TLiberacao;
  LContador    : Integer;
begin
  objLiberacao := TLiberacao.Create;

  Try
    For LContador := 0 to FListaDocumentos.Count -1 do
    Begin
      If LContador = 0 then
      begin
        objLiberacao.strMsgSen := RetornarMensagemTrava(LContador);
        objLiberacao.objMsgLibera.pAddTexto(objLiberacao.strMsgSen);
        objLiberacao.objMsgLibera.pAddTexto('--------------------------------------------------------');
      end
      else
        objLiberacao.objMsgLibera.pAddTexto('--------------------------------------------------------');

      objLiberacao.objMsgLibera.pAddTextoCaption('Documento', FListaDocumentos[LContador].Numero,8 );
      objLiberacao.objMsgLibera.pAddTextoCaption('Cliente  ', FListaDocumentos[LContador].NomeCliente,8 );
      objLiberacao.objMsgLibera.pAddTextoCaption('Data     ', dateToStr(FListaDocumentos[LContador].DataDocumento),8);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor    ', FloatToStrF(FListaDocumentos[LContador].ValorTotal, ffNumber, 12, 2), 8);

      If LContador = (FListaDocumentos.Count -1) Then
        objLiberacao.objMsgLibera.pAddTexto('--------------------------------------------------------');
    End;

    objLiberacao.strDirAce := IIF(FListaDocumentos[0].Especie = 'PD','BXPNFT', 'BAIPDV' );
    objLiberacao.blnTraTel := True;
    objLiberacao.strSenLib := '';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := '';

    Result := objLiberacao.fLibera;
  finally
    FreeAndNil(objLiberacao);
  end;

end;

procedure TBaixarPedOrcNaoEntregue.AddDocumento(ANumero, AEspecie, ACodigoEmpresa: String);
var
  LDocumento: TDocumento;
begin
  LDocumento := TDocumento.Create;
  LDocumento.Numero := ANumero;
  LDocumento.Especie := AEspecie;
  LDocumento.CodigoEmpresa := ACodigoEmpresa;
  LDocumento.CarregarDados;

  FListaDocumentos.Add(LDocumento);
end;

constructor TBaixarPedOrcNaoEntregue.Create;
begin
  FListaDocumentos := TObjectList<TDocumento>.Create;
  FblnGerarCreditoAdt := True;
  FblnRealizarEstoAdt := False;
  FblnExecutandoCnsOr := False;
  FblnVendaPerdidaGer := False;
  FLiberouBaixaDePedidoNaoEntregue := False;
  FblnExecutandoLocEqu := False;
  FLimparSeparacao := False;
  FExcluirExtLar := False;
  FRealizouValidacao := False;
  FExibirMensagemFinalizacao := True;
  FillChar(FOcorrenciaBaixa, SizeOf(FOcorrenciaBaixa), #0);
end;

destructor TBaixarPedOrcNaoEntregue.Destroy;
begin
  FreeAndNil(FListaDocumentos);
  inherited;
end;

function TBaixarPedOrcNaoEntregue.PermiteExecutar : Boolean;
begin
  Result := False;

  If (RealizouValidacao) Then
    Exit(True);

  if FListaDocumentos.Count = 0 then
  begin
    fMensagem('ATENÇÃO!', 'Nenhum documento foi informado! Impossível executar essa operação!', ['&Ok']);
    Exit;
  end;

  If Not PossuiAcesso Then
  Begin
    If Not VerificarAcessoLiberacao Then
      Exit;
  End;

  If Not fBaixarDocumentoVinculadoRemessaContaOrdem Then
    Exit;

  If Not ProcessouCancelamentoLinkPagamentoCitel Then
    Exit;

  Result := True;
end;

function TBaixarPedOrcNaoEntregue.Executar: Boolean;
begin
  Result := False;

  FMultiplosDocumentos := FListaDocumentos.Count > 1;

  If (Not PermiteExecutar) Then
    Exit;

  try
    ValidaDocumento;

    Result := RealizaBaixa;
    FLiberouBaixaDePedidoNaoEntregue := False;
  except

    on E: EValidaPedidoPossuiItensEmSeparacao do
      Raise;

    on E: EValidaException do
    begin
      if not fEmptyStr(E.Message) then
        fMensagem('ATENÇÃO!', E.Message, ['&Ok']);
      Exit;
    end;

  end;
end;

function TBaixarPedOrcNaoEntregue.GerarLogLiberacao(
  ADocumento: TDocumento): Boolean;
begin
  Result := True;
  if not FLiberouTravaAditivo then
    Exit(False);

  if not ADocumento.PossuiAdiantamento then
    Exit(False);
end;

function TBaixarPedOrcNaoEntregue.LiberacaoNaoSeraEntregue(const APreMensagem, APosMensagem: string; AObjTabela: TRegistroMsgLibera; docDocumento : TDocumento = Nil): Boolean;
var
  LobjLiberacao : TLiberacao;
  strNumRom : String;
  strCodFpg : String;
  strEntRet : String;
  strDtEntr : String;
  strCodCnd : String;

Begin
  LobjLiberacao := TLiberacao.Create;
  Try
    LobjLiberacao.Clear;
    LobjLiberacao.objMsgLibera.pAddTexto('Senha para baixar pedido que não será entregue');

    If (Not fEmptyStr(APreMensagem)) Then
      LobjLiberacao.objMsgLibera.pAddTexto(APreMensagem);

    If (Assigned(docDocumento)) then
    Begin
      LobjLiberacao.objMsgLibera.pAddTexto('-----------------------------------------------------------');

      LobjLiberacao.objMsgLibera.pAddTextoCaption('Documento', docDocumento.Numero+'-'+docDocumento.CodigoEmpresa, 21);
      LobjLiberacao.objMsgLibera.pAddTextoCaption('Cliente  ', docDocumento.CodigoCliente +'-'+docDocumento.NomeCliente, 21);
      LobjLiberacao.objMsgLibera.pAddTextoCaption('Data     ', dateToStr(docDocumento.DataDocumento), 21);

      pRetornaComplementosPedido(strNumRom, strEntRet, strCodFpg, strDtEntr, strCodCnd, docDocumento);

      If (Not fEmptyStr(strCodCnd)) Then
        LobjLiberacao.objMsgLibera.pAddTextoCaption('Condição de Pagamento', strCodCnd + '-'+fRetDesConPag(strCodCnd), 21);

      LobjLiberacao.objMsgLibera.pAddTextoCaption('Forma de Pagamento', strCodFpg + '-'+fRetDesFpg(strCodFpg), 21);
      LobjLiberacao.objMsgLibera.pAddTextoCaption('Tipo do Pedido', strEntRet, 21);

      If Pos('ENTREGA', UpperCase(strEntRet)) > 0 Then
      Begin
        If (Not fEmptyStr(strDtEntr)) Then
          LobjLiberacao.objMsgLibera.pAddTextoCaption('Data Entrega', strDtEntr, 21);
        If (Not fEmptyStr(strNumRom)) Then
          LobjLiberacao.objMsgLibera.pAddTextoCaption('Romaneio', strNumRom, 21);
      End;

      LobjLiberacao.objMsgLibera.pAddTexto('-----------------------------------------------------------');
    End;

    if AObjTabela <> nil then
      LobjLiberacao.objMsgLibera.lstRegistros.Add(AObjTabela);
    LobjLiberacao.objMsgLibera.pAddTexto(APosMensagem);
    LobjLiberacao.strDirAce := 'PERBAI';
    LobjLiberacao.strMsgSen := 'Senha para baixar pedido que não será entregue';
    LobjLiberacao.strCodOpe := strLoginUsuarioLogado;
//    LobjLiberacao.strCliente := strCliente;
//    LobjLiberacao.strCpfCnpj := qryGen.FieldByName('CLI_C_G_C_').AsString;

    Result := LobjLiberacao.fLibera;
  Finally
    FreeAndNil(LobjLiberacao);
  End;
End;

function TBaixarPedOrcNaoEntregue.ValidouRestricoesLimparSeparacao: Boolean;
  Var
    LDocumento : TDocumento;
    LValidouExtLar : String;
    LExcluirExtLarOpcoes : TExcluirExtLarOpcoes;
begin
  LValidouExtLar := EmptyStr;
  For LDocumento In FListaDocumentos Do
  begin
    If fEmptyStr(LValidouExtLar) Then
      LExcluirExtLarOpcoes := eeloPerguntar
    Else If ExcluirExtLar Then
      LExcluirExtLarOpcoes := eeloExcluir
    Else
      LExcluirExtLarOpcoes := eeloNaoExcluir;
    LValidouExtLar := 'S';
    If Not fValidouLimpaExpedicaoPedido(FExcluirExtLar, LDocumento.FAutoIncrem, False, LExcluirExtLarOpcoes) Then
      Exit(False);
  End;
  Result := True;
end;

procedure TBaixarPedOrcNaoEntregue.MostraMensagem(AQtdeOk: Integer);
begin
  If (Not FExibirMensagemFinalizacao) Then
    Exit;
  If (AQtdeOk = 0) Then
    fMensagem('', 'Nenhum Documento foi baixado!', ['&Ok'])
  Else
  Begin
    If AQtdeOk = FListaDocumentos.Count Then
    Begin
      If FblnVendaPerdidaGer Then
        fMensagem('', 'Venda(s) Perdida(s) baixado(s) com sucesso!', ['&Ok'])
      Else
        fMensagem('', 'Documento(s) baixado(s) com sucesso!', ['&Ok']);
    End
    Else
      fMensagem('', 'Ocorreram erros ao baixar os Documento(s)!', ['&Ok'])
  End;
end;

function TBaixarPedOrcNaoEntregue.MultiplosDocumentos: Boolean;
begin
  Result := FMultiplosDocumentos;
end;

function TBaixarPedOrcNaoEntregue.PerguntaOpcaoEstornoCreditoPedidoEcommerce(
  ADocumento: TDocumento): Boolean;
begin
  Result := False;

  if (not FListaDocumentos[0].fEhPedidoECommerce) then
    Exit;

  Result := FExecutandoPeloCRM or fUsaOndaSeparacaoExpedicao;
end;

procedure TBaixarPedOrcNaoEntregue.pExcluiPrepTE(ADocumento: TDocumento);
var
  qryPrepTE: TUniQuery;
begin
  qryPrepTE := fCriaQuery;

  try
    qryPrepTE.Close;
    qryPrepTE.SQL.Clear;
    qryPrepTE.SQL.Add('DELETE FROM PREPTE WHERE AUTOINCREM IN(');
    qryPrepTE.SQL.Add('  SELECT * FROM(');
    qryPrepTE.SQL.Add('    SELECT AUTOINCREM');
    qryPrepTE.SQL.Add('    FROM PREPTE');
    qryPrepTE.SQL.Add('    WHERE PRE_DOCABS = :NUMDOC');
    qryPrepTE.SQL.Add('    AND PRE_ESPABS = :ESPDOC');
    qryPrepTE.SQL.Add('    AND PRE_EMPABS = :CODEMP');
    qryPrepTE.SQL.Add('    AND PRE_NUMDOC IS NULL');
    qryPrepTE.SQL.Add('    AND PRE_LIBERA = "N") AS TMP)');

    qryPrepTE.ParamByName('NUMDOC').AsString := ADocumento.Numero;
    qryPrepTE.ParamByName('ESPDOC').AsString := ADocumento.Especie;
    qryPrepTE.ParamByName('CODEMP').AsString := ADocumento.CodigoEmpresa;

    qryPrepTE.ExecSQL;
  finally
    FreeAndNil(qryPrepTE);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.pExcluiRequisicoesDeCompraVinculadasAoDocumento(
  const ANumDoc, AEspDoc, ACodEmp: String);
var
  qryRequisicao: TUniQuery;
begin
  qryRequisicao := fCriaQuery;

  try
    qryRequisicao.Close;
    qryRequisicao.SQL.Clear;
    qryRequisicao.SQL.Add('SELECT DISTINCT RCD_CODIGO, RCD_CODEMP ');
    qryRequisicao.SQL.Add('FROM MOVRCD                ');
    qryRequisicao.SQL.Add('WHERE                      ');
    qryRequisicao.SQL.Add('  RCD_DOCPDV = :NUMDOC AND ');
    qryRequisicao.SQL.Add('  RCD_ESPPDV = :ESPDOC AND ');
    qryRequisicao.SQL.Add('  RCD_EMPPDV = :CODEMP     ');

    qryRequisicao.ParamByName('NUMDOC').AsString := ANumDoc;
    qryRequisicao.ParamByName('ESPDOC').AsString := AEspDoc;
    qryRequisicao.ParamByName('CODEMP').AsString := ACodEmp;

    qryRequisicao.Open;

    if qryRequisicao.IsEmpty then
      Exit;

    while not qryRequisicao.Eof do
    begin
      if (Not fTemCotacaoVinculada(qryRequisicao.FieldByName('RCD_CODIGO').AsString)) then
      begin
        pExcluiRequisicaoCompra(qryRequisicao.FieldByName('RCD_CODIGO').AsString,
                                qryRequisicao.FieldByName('RCD_CODEMP').AsString,
                                'pExcluiRequisicoesDeCompraVinculadasAoDocumento');
      end
      else
        Raise EValidaException.Create('');

      qryRequisicao.Next;
    end;
  finally
    FreeAndNil(qryRequisicao);
  end;
end;

procedure TBaixarPedOrcNaoEntregue.pGerarTarefaRomaneioFusion(
  ADocumento: TDocumento);
begin
  if (not fCfgSis('FUSUSA', varBoolean)) then
    Exit;

  if (not ADocumento.fEhPedidoIntegracaoFusion) then
    Exit;

  TRomaneioTarefasFusion.pInsereTarFus('', '', ADocumento.FNumero, ADocumento.Especie, ADocumento.CodigoEmpresa, 'B');
end;

procedure TBaixarPedOrcNaoEntregue.pMostraMensagemAbastecimentoTransf(AMensagem: TStringList);
var
  frmMensagemExplicativa: TfrmMensagemExplicativa;
begin
  pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
  Try
    frmMensagemExplicativa.Caption := 'Não será possível realizar baixa do pedido';
    frmMensagemExplicativa.Width   := 650;
    frmMensagemExplicativa.Height  := 300;
    frmMensagemExplicativa.mmoInstru.Lines.Add(AMensagem.Text);
    frmMensagemExplicativa.ShowModal;
  Finally
    pFreeAndNil(frmMensagemExplicativa);
  End;
end;

function TBaixarPedOrcNaoEntregue.fBaixarDocumentoVinculadoRemessaContaOrdem: Boolean;
var
  intOrdem            : Integer;
  blnExisteVinculacao : Boolean;
  strNumDoc,
  strEspDoc,
  strCodEmp           : String;
  blnExistemPedidos   : Boolean;
begin
  Result := True;

  blnExisteVinculacao := False;
  blnExistemPedidos   := False;
  For intOrdem := 0 To Pred(FListaDocumentos.Count) Do
  Begin
    If (FListaDocumentos.Items[intOrdem].Especie = 'PD') And
       (fPermiteBaixarDocumentosContaOrdemRemessaContaOrdem(
          FListaDocumentos.Items[intOrdem].Numero,
          FListaDocumentos.Items[intOrdem].Especie,
          strNumDoc, strEspDoc, strCodEmp)) Then
    Begin
      blnExisteVinculacao := True;
      blnExistemPedidos   := True;
      AddDocumento(strNumDoc, strEspDoc, strCodEmp);
    End;
  End;

  If (blnExisteVinculacao) And
     (blnExistemPedidos) Then
  Begin
    Result := (fMensagem('Atenção', 'Existem documentos vinculados a remessas de conta e ordem.'+#13#10
                                  + 'Confirma a baixa como não entregue de todos os documentos '
                                  + 'vinculados?', ['&Sim', '&Não']) = 1);
  End;
end;

function TBaixarPedOrcNaoEntregue.fGerarVendaPerdida(ADocumento: TDocumento): Boolean;
  Var
    objVendaPerdida: TGerarVendaPerdida;
    FncLimparSeparacao : TFunctionLimparSeparacao;
begin
  Result := False;
  objVendaPerdida := TGerarVendaPerdida.Create(ADocumento.Especie);
  Try
    Try
      If (Self.LimparSeparacao) Then
        FncLimparSeparacao := LimpaExpedicaoPedido
      Else
        FncLimparSeparacao := Nil;
      objVendaPerdida.LimparSeparacao := Self.LimparSeparacao;
      objVendaPerdida.ExcluirExtLar := Self.ExcluirExtLar;
      objVendaPerdida.FncLimparSeparacao := FncLimparSeparacao;
      objVendaPerdida.pGerarVendaPerdida(ADocumento);
      Result := objVendaPerdida.blnVendaPerdidaGerada;
      FblnVendaPerdidaGer := Result;
    Finally
      FreeAndNil(objVendaPerdida);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TBaixarPedOrcNaoEntregue.pGerarVendaPerdida]');
  End;
end;

{ TDocumento }

function TDocumento.AguardandoTransferencia: Boolean;
begin
  Result := FAguardandoTransferencia;
end;

procedure TDocumento.CarregarDados;
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  try
    qryGen.SQL.Add('SELECT G.AUTOINCREM, G.FGO_CODCLI, G.FGO_JAFATU,     ');
    qryGen.SQL.Add('       G.FGO_MOTBAI, C.CLI_NOMCLI, C.CLI_C_G_C_,     ');
    qryGen.SQL.Add('       G.FGO_CODVEN, V.OPE_NOMOPE,                   ');
    qryGen.SQL.Add('       G.FGO_DTAENT, G.FGO_TOTPRO, E.FGO_TIPREC,     ');
    qryGen.SQL.Add('       E.FGO_NUMORI, E.FGO_ESPORI, E.FGO_EMPORI,     ');
    qryGen.SQL.Add('       G.FGO_NUMPOK, E.FGO_INTFUS                    ');
    qryGen.SQL.Add('  FROM FATGOR G                                      ');
    qryGen.SQL.Add('  INNER JOIN EXTGOR E ON G.AUTOINCREM = E.FGO_SEQFGO ');
    qryGen.SQL.Add('  LEFT JOIN CADCLI C ON C.CLI_CODCLI = G.FGO_CODCLI  ');
    qryGen.SQL.Add('  LEFT JOIN CADOPE V ON V.OPE_CODOPE = G.FGO_CODVEN  ');
    qryGen.SQL.Add(' WHERE FGO_NUMDOC = :NUMDOC                          ');
    qryGen.SQL.Add('   AND FGO_ESPDOC = :ESPDOC                          ');
    qryGen.SQL.Add('   AND FGO_CODEMP = :CODEMP                          ');

    qryGen.ParamByName('NUMDOC').AsString := Numero;
    qryGen.ParamByName('ESPDOC').AsString := Especie;
    qryGen.ParamByName('CODEMP').AsString := CodigoEmpresa;

    qryGen.Open();
    Self.FAutoIncrem     := qryGen.FieldByName('AUTOINCREM').AsString;
    Self.FCodigoCliente  := qryGen.FieldByName('FGO_CODCLI').AsString;
    Self.FJaFaturado     := qryGen.FieldByName('FGO_JAFATU').AsInteger;
    Self.FMotivoBaixa    := qryGen.FieldByName('FGO_MOTBAI').AsString;
    Self.FNomeCliente    := qryGen.FieldByName('CLI_NOMCLI').AsString;
    Self.FCgcCliente     := qryGen.FieldByName('CLI_C_G_C_').AsString;
    Self.FCodigoVendedor := qryGen.FieldByName('FGO_CODVEN').AsString;
    Self.FNomeVendedor   := qryGen.FieldByName('OPE_NOMOPE').AsString;
    Self.FDataDocumento  := qryGen.FieldByName('FGO_DTAENT').AsDateTime;
    Self.FValorTotal     := qryGen.FieldByName('FGO_TOTPRO').AsFloat;
    Self.FBlnPedECom     := Not fEmptyStr(qryGen.FieldByName('FGO_NUMPOK').AsString);
    Self.FblnPedidoAlpe  := (Pos(qryGen.FieldByName('FGO_TIPREC').AsString, 'ALPE_ALPEF_ALPEC_ALPEP_ALPES_ALPEFP_') > 0);
    Self.FPagtoOnLineLinkPagamentoCitel := TLinkPagamentoCitelFornecedores.fEhLinkPagamentoCitel(qryGen.FieldByName('FGO_TIPREC').AsString) ;

    Self.FValorAdiantamento  := TAdiantamento.fGetTotaisAdiantamento(Self.Numero, Self.Especie, Self.CodigoEmpresa).fltValLan;
    Self.FCodigoOcorrencia   := fRetornaCodigoOcorrencia(Self.Numero, Self.Especie, Self.CodigoCliente, Self.CodigoEmpresa, '');
    if Especie = 'PD' then
    begin
      Self.FGerouOrdemProducao := fPedidoGerouOrdProd(Self.Numero, Self.CodigoEmpresa, Self.FMensagemOrdemProducao);
      if (not Self.FGerouOrdemProducao) and (Self.FMensagemOrdemProducao <> '') then
        Self.FExcluiuOrdemProducao := true
      else Self.FExcluiuOrdemProducao := false;
    end
    else
      Self.FGerouOrdemProducao := False;
    Self.FTinDorBaixado := untFuncoes.fTinDorBaixado(Self.Numero, Self.Especie, Self.CodigoEmpresa, True);
    Self.FVinculadoGarantia := fPedidoVinculadoComGarantia(Self.FAutoIncrem, Self.FNumeroGarantia);

    Self.FListVerificar.Clear;
    Self.FAguardandoTransferencia := VerificaAguardandoTransferencia;
    Self.FPedidoTransferencia := VerificaPedidoTransferencia;
    Self.FRequisicaoCompra := VerificaRequisicaoCompra;
    Self.FPedidoPossuiItensEmSemparacao := VerificaPedidoPossuiItensEmSemparacao;
    Self.FPedidoOriginadoDeTransferencia := VerificaPedidoOriginadoDeTransferencia;
    Self.FValorBoletosAdiantamento := TAdiantamentoGenerico.fRetornaValorBoletosAdiantamento(Self.Numero, Self.Especie, Self.CodigoEmpresa, Self.CodigoCliente);
    Self.FPedidoComRequisicaoEmAbertoComPedidoDeCompra := VerificaPedidoComRequisicaoEmAbertoComPedidoDeCompra;
    Self.FPedidoComRequisicaoEmAbertoSemPedidoDeCompra := VerificaPedidoComRequisicaoEmAbertoSemPedidoDeCompra;
    Self.FPedidoComPedAbastecimento := VerificaPedidoComPedAbastecimento;

    Self.FTipRec := qryGen.FieldByName('FGO_TIPREC').AsString;

    Self.FNumOrigem := qryGen.FieldByName('FGO_NUMORI').AsString;
    Self.FEspOrigem := qryGen.FieldByName('FGO_ESPORI').AsString;
    Self.FEmpOrigem := qryGen.FieldByName('FGO_EMPORI').AsString;

    Self.FNumOrdemServico := fRetornaOrdemServicoPedido(Numero, CodigoEmpresa, '', Especie);

    Self.FstrIntFus := qryGen.FieldByName('FGO_INTFUS').AsString;
  finally
    FreeAndNil(qryGen);
  end;
end;

constructor TDocumento.Create;
begin
  FListVerificar := TStringList.Create;
  FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra := TLiberacao.Create;
end;

destructor TDocumento.Destroy;
begin
  FreeAndNil(FListVerificar);
  FreeAndNil(FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra);
  inherited;
end;

function TDocumento.EhClienteConsumidor: Boolean;
begin
  Result := fClienteConsumidor(Self.FNomeCliente);
end;

function TDocumento.fEhPagtoOnLineLinkPagamentoCitel: Boolean;
begin
  Result := Self.FPagtoOnLineLinkPagamentoCitel;
end;

function TDocumento.fEhPedidoAlpe: Boolean;
begin
  Result := Self.FblnPedidoAlpe;
end;

function TDocumento.fEhPedidoECommerce: Boolean;
begin
  Result := Self.FBlnPedECom;
end;

function TDocumento.fEhPedidoIntegracaoFusion: Boolean;
begin
  Result := (Self.FstrIntFus <> 'N');
end;

function TDocumento.GerouOrdemProducao: Boolean;
begin
  Result := Self.FGerouOrdemProducao;
end;

function TDocumento.JaFaturado: Boolean;
begin
  Result := Self.FJaFaturado = 1;
end;

function TDocumento.PedidoComDocumentoOrigem: Boolean;
begin
  Result := not fEmptyStr(Self.FNumOrigem);
end;

function TDocumento.PedidoComOrdemServico: Boolean;
begin
  Result := (not fEmptyStr(Self.FNumOrdemServico));
end;

function TDocumento.PedidoComPedAbastecimento: Boolean;
begin
  Result := Self.FPedidoComPedAbastecimento;
end;

function TDocumento.PedidoComRequisicaoEmAbertoComPedidoDeCompra: Boolean;
begin
  Result := FPedidoComRequisicaoEmAbertoComPedidoDeCompra;
end;

function TDocumento.PedidoComRequisicaoEmAbertoSemPedidoDeCompra: Boolean;
begin
  Result := FPedidoComRequisicaoEmAbertoSemPedidoDeCompra;
end;

function TDocumento.PedidoOriginadoDeTransferencia: Boolean;
begin
  Result := FPedidoOriginadoDeTransferencia;
end;

function TDocumento.PedidoPossuiItensEmSemparacao: Boolean;
begin
  Result := Self.FPedidoPossuiItensEmSemparacao;
end;

function TDocumento.PedidoTransferencia: Boolean;
begin
  Result := Self.FPedidoTransferencia;
end;

function TDocumento.PossuiAdiantamento: Boolean;
begin
  Result := Self.FValorAdiantamento > 0;
end;

function TDocumento.PossuiBoletosAdiantamento: Boolean;
begin
  Result := FValorBoletosAdiantamento > 0;
end;

function TDocumento.PossuiOcorrencia: Boolean;
begin
  Result := not fEmptyStr(Self.FCodigoOcorrencia);
end;

function TDocumento.RequisicaoCompra: Boolean;
begin
  Result := Self.FRequisicaoCompra;
end;

procedure TBaixarPedOrcNaoEntregue.pRetornaComplementosPedido(var strNumRom, strEntRet,
  strCodFpg, strDtEntr, strCodCnd: String; docDocumento : TDocumento);
  Var
    qryGen : TUniQuery;

begin
  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT  DISTINCT ');
    qryGen.SQL.Add('  D.DET_NUMROM,  ');
    qryGen.SQL.Add('  CASE           ');
    qryGen.SQL.Add('   WHEN FDO_ENTRET = "R" AND IFNULL(FDO_LOCRET, "") = ""   THEN "RETIRA"           ');
    qryGen.SQL.Add('   WHEN FDO_ENTRET = "R" AND IFNULL(FDO_LOCRET, "") = "C"  THEN "RETIRA CAIXA"     ');
    qryGen.SQL.Add('   WHEN FDO_ENTRET = "R" AND IFNULL(FDO_LOCRET, "") = "E"  THEN "RETIRA EXPEDIÇÃO" ');
    qryGen.SQL.Add('   WHEN FDO_ENTRET = "E" AND IFNULL(FDO_ENTFUT,"N") = "S"  THEN "ENTREGA FUTURA"   ');
    qryGen.SQL.Add('   ELSE "ENTREGA IMEDIATA" END AS DESTINO, ');
    qryGen.SQL.Add('  FG.FGO_CODCND,                           ');
    qryGen.SQL.Add('  (SELECT MAX( ED.FDO_DTENTR)              ');
    qryGen.SQL.Add('   FROM FATDOR FD                          ');
    qryGen.SQL.Add('   LEFT JOIN EXTDOR ED                     ');
    qryGen.SQL.Add('     ON FD.AUTOINCREM = ED.FDO_SEQFDO      ');
    qryGen.SQL.Add('   WHERE ED.FDO_ENTRET = "E"               ');
    qryGen.SQL.Add('     AND FD.FDO_SEQGER = FG.AUTOINCREM ) as FDO_DTENTR, ');
    qryGen.SQL.Add('  FG.FGO_CODFPG   ');
    qryGen.SQL.Add('FROM              ');
    qryGen.SQL.Add('  FATDOR  F       ');
    qryGen.SQL.Add('  LEFT JOIN ROMDETX D ON F.AUTOINCREM = D.DET_AUTINC AND D.DET_ESPDOC = "PD" ');
    qryGen.SQL.Add('  LEFT JOIN FATGOR  FG ON FG.AUTOINCREM = F.FDO_SEQGER  ');
    qryGen.SQL.Add('  LEFT JOIN EXTDOR  E ON F.AUTOINCREM = E.FDO_SEQFDO    ');

    qryGen.SQL.Add('WHERE FDO_CODEMP = :CODEMP ');
    qryGen.SQL.Add('AND   FDO_NUMDOC = :NUMDOC ');
    qryGen.SQL.Add('AND   FDO_ESPDOC = :ESPDOC ');
    qryGen.SQL.Add('AND   FDO_CODCLI = :CODCLI ');

    qryGen.ParamByName('CODEMP').AsString := docDocumento.FCodigoEmpresa;
    qryGen.ParamByName('NUMDOC').AsString := docDocumento.FNumero;
    qryGen.ParamByName('ESPDOC').AsString := docDocumento.FEspecie;
    qryGen.ParamByName('CODCLI').AsString := docDocumento.FCodigoCliente;

    qryGen.Open;
    qryGen.First;

    strNumRom := qrygen.FieldByName('DET_NUMROM').AsString;
    strCodFpg := qrygen.FieldByName('FGO_CODFPG').AsString;
    strEntRet := qrygen.FieldByName('DESTINO').AsString;

    If (Not qrygen.FieldByName('FDO_DTENTR').IsNull) or
       (Not (fEmptyStr(qrygen.FieldByName('FDO_DTENTR').AsString))) Then
      strDtEntr := dateToStr(qrygen.FieldByName('FDO_DTENTR').AsDateTime);

    strCodCnd := qrygen.FieldByName('FGO_CODCND').AsString;

    qryGen.Close;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TDocumento.TinDorBaixado: Boolean;
begin
  Result := Self.FTinDorBaixado;
end;

function TDocumento.VinculadoGarantia: Boolean;
begin
  Result := Self.FVinculadoGarantia;
end;

function TDocumento.VerificaPedidoTransferencia: Boolean;
var
  qryAux: TUniQuery;
begin
  Result := True;

  qryAux := fCriaQuery();
  Try
    {Pedidos aguardando pedido de transferência}
    qryAux.Close();
    qryAux.SQL.Clear();
    qryAux.SQL.Add('SELECT SQL_NO_CACHE                              ');
    qryAux.SQL.Add('  PRE_EMPORI, PRE_CODITE, ITE_DESITE             ');
    qryAux.SQL.Add('  FROM PREPTE                                    ');
    qryAux.SQL.Add('  JOIN CADITE ON ITE_CODITE = PRE_CODITE         ');
    qryAux.SQL.Add(' WHERE PRE_DOCABS = :NUMDOC                      ');
    qryAux.SQL.Add('   AND PRE_ESPABS = :ESPDOC                      ');
    qryAux.SQL.Add('   AND PRE_EMPABS = :CODEMP                      ');
    qryAux.SQL.Add('   AND PRE_NUMDOC IS NULL                        ');
    qryAux.SQL.Add('   AND PRE_LIBERA = "S"                          ');
    qryAux.SQL.Add('UNION ALL                                        ');
    qryAux.SQL.Add('SELECT SQL_NO_CACHE                              ');
    qryAux.SQL.Add('  PRE_EMPORI, PRE_CODITE, ITE_DESITE             ');
    qryAux.SQL.Add('  FROM REQVEN                                    ');
    qryAux.SQL.Add('  JOIN PREPTE ON PREPTE.AUTOINCREM = SEQ_PREPTE  ');
    qryAux.SQL.Add('  JOIN MOVRCD ON MOVRCD.AUTOINCREM = SEQ_MOVRCD  ');
    qryAux.SQL.Add('  JOIN CADITE ON ITE_CODITE = PRE_CODITE         ');
    qryAux.SQL.Add(' WHERE RCD_DOCPDV = :NUMDOC                      ');
    qryAux.SQL.Add('   AND RCD_ESPPDV = :ESPDOC                      ');
    qryAux.SQL.Add('   AND RCD_EMPPDV = :CODEMP                      ');
    qryAux.SQL.Add('   AND PRE_NUMDOC IS NULL                        ');
    qryAux.SQL.Add('   AND PRE_LIBERA = "S"                          ');
    qryAux.ParamByName('NUMDOC').AsString := Self.Numero;
    qryAux.ParamByName('ESPDOC').AsString := Self.Especie;
    qryAux.ParamByName('CODEMP').AsString := Self.CodigoEmpresa;
    qryAux.Open();

    If (Not qryAux.IsEmpty) Then
    Begin
      Result := False;
      FListVerificar.Add('É necessário aguardar a geração do(s) pedido(s) de transferência,');
      FListVerificar.Add('e após isso ser solicitado o cancelamento/baixa do(s) mesmo(s),');
      FListVerificar.Add('para o(s) seguinte(s) item(ns):');
      FListVerificar.Add('--------------------------------------------------------');
      FListVerificar.Add('| Empresa | Código | Descrição                         |');
      FListVerificar.Add('--------------------------------------------------------');

      While (Not qryAux.Eof) Do
      Begin
        FListVerificar.Add('| ' + fPadR(qryAux.FieldByName('PRE_EMPORI').AsString, 7) +
                         ' | ' + fPadC(qryAux.FieldByName('PRE_CODITE').AsString, 06) +
                         ' | ' + fPadR(qryAux.FieldByName('ITE_DESITE').AsString, 33) +
                         ' |');

        qryAux.Next();
      End;

      FListVerificar.Add('--------------------------------------------------------');
      FListVerificar.Add('');
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TDocumento.VerificaAguardandoTransferencia: Boolean;
var
  qryAux: TUniQuery;
begin
    Result := True;

  qryAux := fCriaQuery();
  Try
    {Pedidos aguardando transferência}
    qryAux.Close();
    qryAux.SQL.Clear();
    qryAux.SQL.Add('SELECT SQL_NO_CACHE                              ');
    qryAux.SQL.Add('  PRE_NUMDOC, PRE_ESPDOC, PRE_EMPDOC             ');
    qryAux.SQL.Add('  FROM PREPTE                                    ');
    qryAux.SQL.Add('  JOIN FATGOR ON FGO_NUMDOC = PRE_NUMDOC         ');
    qryAux.SQL.Add('             AND FGO_ESPDOC = PRE_ESPDOC         ');
    qryAux.SQL.Add('             AND FGO_CODEMP = PRE_EMPDOC         ');
    qryAux.SQL.Add(' WHERE PRE_DOCABS = :NUMDOC                      ');
    qryAux.SQL.Add('   AND PRE_ESPABS = :ESPDOC                      ');
    qryAux.SQL.Add('   AND PRE_EMPABS = :CODEMP                      ');
    qryAux.SQL.Add('   AND FGO_JAFATU = 0                            ');
    qryAux.SQL.Add('GROUP BY PRE_NUMDOC, PRE_ESPDOC, PRE_EMPDOC      ');
    qryAux.SQL.Add('UNION ALL                                        ');
    qryAux.SQL.Add('SELECT SQL_NO_CACHE                              ');
    qryAux.SQL.Add('  PRE_NUMDOC, PRE_ESPDOC, PRE_EMPDOC             ');
    qryAux.SQL.Add('  FROM REQVEN                                    ');
    qryAux.SQL.Add('  JOIN PREPTE ON PREPTE.AUTOINCREM = SEQ_PREPTE  ');
    qryAux.SQL.Add('  JOIN MOVRCD ON MOVRCD.AUTOINCREM = SEQ_MOVRCD  ');
    qryAux.SQL.Add('  JOIN FATGOR ON FGO_NUMDOC = PRE_NUMDOC         ');
    qryAux.SQL.Add('             AND FGO_ESPDOC = PRE_ESPDOC         ');
    qryAux.SQL.Add('             AND FGO_CODEMP = PRE_EMPDOC         ');
    qryAux.SQL.Add(' WHERE RCD_DOCPDV = :NUMDOC                      ');
    qryAux.SQL.Add('   AND RCD_ESPPDV = :ESPDOC                      ');
    qryAux.SQL.Add('   AND RCD_EMPPDV = :CODEMP                      ');
    qryAux.SQL.Add('   AND FGO_JAFATU = 0                            ');
    qryAux.SQL.Add('GROUP BY PRE_NUMDOC, PRE_ESPDOC, PRE_EMPDOC      ');
    qryAux.ParamByName('NUMDOC').AsString := Self.Numero;
    qryAux.ParamByName('ESPDOC').AsString := Self.Especie;
    qryAux.ParamByName('CODEMP').AsString := Self.CodigoEmpresa;
    qryAux.Open();

    If (Not qryAux.IsEmpty) Then
    Begin
      Result := False;
      FListVerificar.Add('É necessário solicitar o cancelamento do(s) seguinte(s) ');
      FListVerificar.Add('pedido(s) de transferência na(s) respectiva(s) empresa(s):');
      FListVerificar.Add('------------------------------------');
      FListVerificar.Add('| Documento    | Espécie | Empresa |');
      FListVerificar.Add('------------------------------------');

      While (Not qryAux.Eof) Do
      Begin
        FListVerificar.Add('| ' + qryAux.FieldByName('PRE_NUMDOC').AsString +
                         ' | ' + fPadR(qryAux.FieldByName('PRE_ESPDOC').AsString, 07) +
                         ' | ' + fPadR(qryAux.FieldByName('PRE_EMPDOC').AsString, 07) +
                         ' |');

        qryAux.Next();
      End;

      FListVerificar.Add('------------------------------------');
      FListVerificar.Add('');
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TDocumento.VerificaRequisicaoCompra: Boolean;
var
  qryAux: TUniQuery;
begin
  Result := True;

  qryAux := fCriaQuery();
  Try
    {Pedidos aguardando requisição de compra}
    qryAux.Close();
    qryAux.SQL.Clear();
    qryAux.SQL.Add('SELECT SQL_NO_CACHE                              ');
    qryAux.SQL.Add('  PRQ_CODITE, PRQ_QTDITE, ITE_DESITE,            ');
    qryAux.SQL.Add('  PRQ_EMPREQ                                     ');
    qryAux.SQL.Add('  FROM PREPRQ                                    ');
    qryAux.SQL.Add('  JOIN CADITE ON ITE_CODITE = PRQ_CODITE         ');
    qryAux.SQL.Add(' WHERE PRQ_NUMDOC = :NUMDOC                      ');
    qryAux.SQL.Add('   AND PRQ_ESPDOC = :ESPDOC                      ');
    qryAux.SQL.Add('   AND PRQ_EMPDOC = :CODEMP                      ');
    qryAux.SQL.Add('   AND PRQ_CODREQ IS NULL                        ');
    qryAux.ParamByName('NUMDOC').AsString := Self.Numero;
    qryAux.ParamByName('ESPDOC').AsString := Self.Especie;
    qryAux.ParamByName('CODEMP').AsString := Self.CodigoEmpresa;
    qryAux.Open();

    If (Not qryAux.IsEmpty) Then
    Begin
      Result := False;
      FListVerificar.Add('É necessário aguardar a geração da(s) requisição(ões) de compra,');
      FListVerificar.Add('e após isso efetuar a baixa informando a senha de liberação.');
      FListVerificar.Add('--------------------------------------------------------');
      FListVerificar.Add('| Empresa | Código | Descrição                         |');
      FListVerificar.Add('--------------------------------------------------------');

      While (Not qryAux.Eof) Do
      Begin
        FListVerificar.Add('| ' + fPadR(qryAux.FieldByName('PRQ_EMPREQ').AsString, 7) +
                         ' | ' + fPadC(qryAux.FieldByName('PRQ_CODITE').AsString, 06) +
                         ' | ' + fPadR(qryAux.FieldByName('ITE_DESITE').AsString, 33) +
                         ' |');

        qryAux.Next();
      End;

      FListVerificar.Add('--------------------------------------------------------');
      FListVerificar.Add('');
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TDocumento.VerificaPedidoPossuiItensEmSemparacao: Boolean;
var
  LQry: TUniQuery;
begin
  if (Self.Especie = 'OR') then
    Exit(False);

  if fUsaOndaSeparacaoAgrupamento then
    Exit(False);

  LQry := fCriaQuery();
  Try
    LQry.SQL.Add(TGetSQLStatus.New(statusPedido).sqlEmSeparacao);
    LQry.ParamByName('NUMDOC').AsString := Self.Numero;
    LQry.ParamByName('ESPDOC').AsString := Self.Especie;
    LQry.ParamByName('CODEMP').AsString := Self.CodigoEmpresa;
    LQry.Open();

    Result := (LQry.FieldByName('QTDE').AsInteger > 0);
  Finally
    FreeAndNil(LQry);
  End;
end;

function TDocumento.VerificaPedidoOriginadoDeTransferencia: Boolean;
var
  LQry: TUniQuery;
begin
  LQry := fCriaQuery();
  Try
    LQry.SQL.Add('SELECT SQL_NO_CACHE                              ');
    LQry.SQL.Add('  PRE_DOCABS, PRE_ESPABS, PRE_EMPABS             ');
    LQry.SQL.Add('  FROM PREPTE                                    ');
    LQry.SQL.Add(' WHERE PRE_NUMDOC = :NUMDOC                      ');
    LQry.SQL.Add('   AND PRE_ESPDOC = :ESPDOC                      ');
    LQry.SQL.Add('   AND PRE_EMPDOC = :CODEMP                      ');
    LQry.SQL.Add('GROUP BY PRE_DOCABS, PRE_ESPABS, PRE_EMPABS      ');
    LQry.SQL.Add('UNION ALL                                        ');
    LQry.SQL.Add('SELECT SQL_NO_CACHE                              ');
    LQry.SQL.Add('  RCD_DOCPDV AS PRE_DOCABS,                      ');
    LQry.SQL.Add('  RCD_ESPPDV AS PRE_ESPDOC,                      ');
    LQry.SQL.Add('  RCD_EMPPDV AS PRE_EMPDOC                       ');
    LQry.SQL.Add('  FROM REQVEN                                    ');
    LQry.SQL.Add('  JOIN PREPTE ON PREPTE.AUTOINCREM = SEQ_PREPTE  ');
    LQry.SQL.Add('  JOIN MOVRCD ON MOVRCD.AUTOINCREM = SEQ_MOVRCD  ');
    LQry.SQL.Add(' WHERE PRE_NUMDOC = :NUMDOC                      ');
    LQry.SQL.Add('   AND PRE_ESPDOC = :ESPDOC                      ');
    LQry.SQL.Add('   AND PRE_EMPDOC = :CODEMP                      ');
    LQry.SQL.Add('GROUP BY RCD_DOCPDV, RCD_ESPPDV, RCD_EMPPDV      ');
    LQry.ParamByName('NUMDOC').AsString := Self.Numero;
    LQry.ParamByName('ESPDOC').AsString := Self.Especie;
    LQry.ParamByName('CODEMP').AsString := Self.CodigoEmpresa;
    LQry.Open();

    Result := (Not LQry.IsEmpty);

    Self.FDocAbs := LQry.FieldByName('PRE_DOCABS').AsString;
    Self.FEspAbs := LQry.FieldByName('PRE_ESPABS').AsString;
    Self.FEmpAbs := LQry.FieldByName('PRE_EMPABS').AsString;
  Finally
    FreeAndNil(LQry);
  End;
end;

function TDocumento.VerificaPedidoComPedAbastecimento: Boolean;
  Var
    LNumPdAb, LEspPdAb, LEmpPdAb: String;
begin
  Result := False;

  If Self.Especie = 'PD' Then
  Begin
    Result := fExistePedidoAbastecimento(Self.Numero, Self.Especie, Self.CodigoEmpresa,
                                         LNumPdAb, LEspPdAb, LEmpPdAb);
    If Result Then
    Begin
      Self.FDocAbs := LNumPdAb;
      Self.FEspAbs := LEspPdAb;
      Self.FEmpAbs := LEmpPdAb;
    End;
  End;
end;

function TDocumento.VerificaPedidoComRequisicaoEmAbertoComPedidoDeCompra: Boolean;
var
  LQry: TUniQuery;
  LIdx: Integer;
  LNota: String;
  LNotas: TStrings;
begin
  LQry := fCriaQuery();
  LNotas := TStringList.Create();

  Try
    LQry.SQL.Add( fGetSqlPedComRequisicaoEmAberto );
    LQry.SQL.Add(' AND IFNULL(M.RCD_SEQPCD,"") <> "" ');

    LQry.ParamByName('NUMDOC').AsString := Self.Numero;
    LQry.ParamByName('ESPDOC').AsString := Self.Especie;
    LQry.ParamByName('CODEMP').AsString := Self.CodigoEmpresa;
    LQry.Open();

    Result := (Not LQry.IsEmpty);

    If Result Then
    Begin

      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.Clear();
      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.strMsgSen := 'LIBERAÇÃO DE PEDIDO VINCULADO A REQUISIÇÃO DE COMPRA COMPRADA POR PEDIDO DE COMPRA';
      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.objMsgLibera.pAddTexto(FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.strMsgSen);

      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.objMsgLibera.pAddSeparador(162);
      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.objMsgLibera.pAddTextoCaption('Cliente'      , LQry.FieldByName('NOMCLI').AsString, 13);
      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.objMsgLibera.pAddTextoCaption('ClCPF/CNPJ:'  , fFormataCpfCgc(LQry.FieldByName('CLI_C_G_C_').AsString, fSetaPais), 13);
      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.objMsgLibera.pAddTextoCaption('Vendedor'     , LQry.FieldByName('NOMVEN').AsString, 13);
      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.objMsgLibera.pAddSeparador(162);
      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.objMsgLibera.pAddTextoCaption('Pedido Venda' , LQry.FieldByName('PEDVEN').AsString, 13);
      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.objMsgLibera.pAddSeparador(162);
      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.objMsgLibera.pAddTexto(fPadR('PRODUTO', 42) + ' | UN | QTD.PEDIDO | REQUISICAO | QTD.REQUISICAO | QTD.BAIXADA | ' +
                                          fPadR('PED.COMPRA', 20) + ' | DT.ENTREGA | NOTA ENTRADA', alEsquerda, teAmbos, '', 162);
      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.objMsgLibera.pAddSeparador(162);

      While (Not LQry.Eof) Do
      Begin
        LNotas.Clear();
        ExtractStrings([','], [' '], pChar(LQry.FieldByName('NOTAS').AsString), LNotas);

        If (LNotas.Count > 0) Then
          LNota := LNotas[0];

        FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.objMsgLibera.pAddTexto(
          Concat(fPadR(LQry.FieldByName('DESITE').AsString, 42), ' | ',
            LQry.FieldByName('UNIDAD').AsString, ' | ',
            fPadL(FloatToStrF(LQry.FieldByName('QTDITE').AsFloat, ffFixed, 10, 2), 10), ' | ',
            LQry.FieldByName('NUMREQ').AsString, '-', LQry.FieldByName('EMPREQ').AsString, ' | ',
            fPadL(FloatToStrF(LQry.FieldByName('QTDREQ').AsFloat, ffFixed, 13, 2), 14), ' | ',
            fPadL(FloatToStrF(LQry.FieldByName('QTDBAI').AsFloat, ffFixed, 11, 2), 11), ' | ',
            fPadR(LQry.FieldByName('NUMCOM').AsString, 20), ' | ',
            LQry.FieldByName('DTAENT').AsString, ' | ',
            LNota), alEsquerda, teAmbos, '', 162);

        For LIdx := 1 To Pred(LNotas.Count) Do
          FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.objMsgLibera.pAddTexto(fPadL(LNotas[LIdx], 162), alEsquerda, teAmbos, '', 162);

        LQry.Next();
      End;

      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.objMsgLibera.pAddSeparador(162);
      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.strDirAce := 'BPRQPC';
      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.blnTraTel := True;
      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.strSenLib := '';
      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.blnMosMen := True;
      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.strCodOpe := strLoginUsuarioLogado;
      FobjLiberacaoPedidoComRequisicaoEmAbertoComPedidoDeCompra.strCodDig := '';
    End;
  Finally
    LNotas.Free();
    FreeAndNil(LQry);
  End;
End;

function TDocumento.VerificaPedidoComRequisicaoEmAbertoSemPedidoDeCompra: Boolean;
var
  LQry: TUniQuery;
begin
  LQry := fCriaQuery();

  Try
    LQry.SQL.Add( fGetSqlPedComRequisicaoEmAberto );
    LQry.SQL.Add(' AND P.PCD_NUMPED IS NULL ');

    LQry.ParamByName('NUMDOC').AsString := Self.Numero;
    LQry.ParamByName('ESPDOC').AsString := Self.Especie;
    LQry.ParamByName('CODEMP').AsString := Self.CodigoEmpresa;
    LQry.Open();

    Result := (Not LQry.IsEmpty);

    If Result Then
    Begin
     Self.FNumeroRequisicao := LQry.FieldByName('NUMREQ').AsString;
     Self.FCodEmpRequisicao := LQry.FieldByName('EMPREQ').AsString;
    End;

  Finally
    FreeAndNil(LQry);
  End;
End;

{ TGerarVendaPerdida }

constructor TGerarVendaPerdida.Create(const strEspPed: String);
begin
  FobjFatVenda := TFatVenda.CreateInstance(strEspPed);
  FstlFormulacaoBaixada := TStringList.Create;
  FstlOrdemProd         := TStringList.Create;
  FstlProdCampanha      := TStringList.Create;
  FstlProdBonus         := TStringList.Create;
  qryConIte             := fCriarQueryIteGer(Nil);

  FblnVendaPerdidaGerada := False;
  FblnDocumentoExcluido  := False;
  FblnRecalculaPrecos    := False;
  FLimparSeparacao := False;
  FFncLimparSeparacao := Nil;
  FExcluirExtLar := False;
  pCriarCdsVenda(Nil);
end;

destructor TGerarVendaPerdida.Destroy;
begin
  inherited;

  FreeAndNil(FobjFatVenda);

  pFreeCdsVenda;

  If Assigned(FstlFormulacaoBaixada) Then
    FreeAndNil(FstlFormulacaoBaixada);

  If Assigned(FstlOrdemProd) Then
    FreeAndNil(FstlOrdemProd);

  If Assigned(FstlProdCampanha) Then
    FreeAndNil(FstlProdCampanha);

  If Assigned(FstlProdBonus) Then
    FreeAndNil(FstlProdBonus);

  pFreeCdsVenda;

  If Assigned(qryConIte) Then
    FreeAndNil(qryConIte);

end;

function TGerarVendaPerdida.fExigirSenha(LDocumento: TDocumento): Boolean;
Begin
  Result := ((Not fEmptyStr(fCfgSis('SENEXI'))) And (LDocumento.Especie <> 'OR'))
              Or ((Not fEmptyStr(fCfgSis('SENEIO'))) And (LDocumento.Especie = 'OR'));

  If (Result) Then
    If fEmptyStr(LDocumento.Numero) Or (Not  fExisteItemPD_OR(LDocumento.Numero,
                                                              LDocumento.Especie,
                                                              LDocumento.CodigoEmpresa,
                                                              cdsVenda.FieldByName('ITE_CODITE').AsString,
                                                              cdsVenda.FieldByName('ITE_SEQINC').AsString)) Then
      Result := False;
End;

function TGerarVendaPerdida.fInformarSenha(LDocumento: TDocumento; blnExisteOcorrencia: Boolean): Boolean;
var
  strSenhaConfg: String;
  strSenha: String;
Begin
  Result := True;

  If Not fExigirSenha(LDocumento) Then
    Exit;

  If ((Not fEmptyStr(fCfgSis('SENEXI'))) And (LDocumento.Especie <> 'OR')) Then
    strSenhaConfg := fCfgSis('SENEXI')
  Else If ((Not fEmptyStr(fCfgSis('SENEIO'))) And (LDocumento.Especie = 'OR')) Then
    strSenhaConfg := fCfgSis('SENEIO')
  Else
    strSenhaConfg := '';

  If ffrmSenha(strSenha, IIF(blnExisteOcorrencia, 'Inclusão Venda Perdida', 'Exclusão de item')) Then
  Begin
    If (strSenha <> strSenhaConfg) Then
    Begin
      fMensagem('','Senha incorreta!',['&OK']);
      Result := False;
    End;
  End
  Else
    Result := False;

End;

procedure TGerarVendaPerdida.pGerarVendaPerdida(LDocumento: TDocumento);
  Var
    qryFatGor           : TUniQuery;
    blnExisteOcorrencia : Boolean;
    frmFatSelItemVendaPerdida: TfrmFatSelItemVendaPerdida;
    blnDeletouItens     : Boolean;
    intQtdIteVndPer     : Integer;
    strSQLFatgor : String;
begin

  inherited;

  If Not fVerificaAcessoSistema('INVDPE') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso em Incluir Vendas Perdidas!', ['&O k']);
    Exit;
  End;

  qryFatGor := fCriaQuery(Nil);

  FblnVendaPerdidaGerada := False;

  Try
    FObjfatVenda.strCodCli := LDocumento.CodigoCliente;
    FObjfatVenda.strNumDoc := LDocumento.Numero;
    FObjfatVenda.strEspDoc := LDocumento.Especie;
    FObjfatVenda.strEmpDoc := LDocumento.CodigoEmpresa;

    FObjfatVenda.strNumOrc := LDocumento.Numero;
    FObjfatVenda.strEspOrc := LDocumento.Especie;

    strSQLFatgor := EmptyStr;
    strSQLFatgor := strSQLFatgor + fSelectFromFatgorLeftAuxiliares(False);
    strSQLFatgor := strSQLFatgor + ' WHERE F.FGO_CODEMP = :CODEMP ';
    strSQLFatgor := strSQLFatgor + '   AND F.FGO_ESPDOC = :ESPDOC ';
    strSQLFatgor := strSQLFatgor + '   AND F.FGO_NUMDOC = :NUMDOC ';
    strSQLFatgor := strSQLFatgor + '   AND F.FGO_CODCLI = :CODCLI ';

    qryFatGor.Close;
    qryFatGor.SQL.Clear;
    qryFatGor.SQL.Add(strSQLFatgor);
    qryFatGor.ParamByName('CODEMP').AsString := LDocumento.CodigoEmpresa;
    qryFatGor.ParamByName('NUMDOC').AsString := LDocumento.Numero;
    qryFatGor.ParamByName('ESPDOC').AsString := LDocumento.Especie;
    qryFatGor.ParamByName('CODCLI').AsString := LDocumento.CodigoCliente;
    qryFatGor.Open;

    If qryFatGor.IsEmpty Then
    Begin
      Exit;
    End;

    untFuncFat.pCarregarClientePedidoOrcamento(FObjfatVenda);
    FObjfatVenda.pCarregaPedidoOrcamento(qryFatGor, blnDeletouItens, Nil);

    If cdsVenda.IsEmpty Then
    Begin
      fMensagem('', 'Não há nenhum item para ser adicionado em vendas perdidas!', ['&Ok']);
      Exit;
    End;

    pCarregarFormulacaoBaixada(FstlFormulacaoBaixada, LDocumento.Numero, LDocumento.Especie, LDocumento.CodigoEmpresa);
    pCarregarOrdPro;

    If Not fValidaGeracaoVendaPerdida Then
      Exit;

    blnExisteOcorrencia := (Not fEmptyStr(fRetornaCodigoOcorrencia(LDocumento.Numero,
                                                                   LDocumento.Especie,
                                                                   LDocumento.CodigoCliente,
                                                                   LDocumento.CodigoEmpresa,'')));

    pCriarFormularios(TfrmFatSelItemVendaPerdida, frmFatSelItemVendaPerdida);
    Try
      frmFatSelItemVendaPerdida.blnExisteDocumento  := not fEmptyStr(LDocumento.Numero);
      frmFatSelItemVendaPerdida.blnExisteOcorrencia := blnExisteOcorrencia;
      pCloneDataSet(frmFatSelItemVendaPerdida.cdsVenda, cdsVenda);
      If frmFatSelItemVendaPerdida.ShowModal = mrOk Then
      Begin
        If Not fInformarSenha(LDocumento, blnExisteOcorrencia) Then
          Exit;

        pProcessaVendaPerdidaItens(frmFatSelItemVendaPerdida.oblItens, LDocumento);

        intQtdIteVndPer := FobjFatVenda.ItensVendaPerdida.Count;

        If (cdsVenda.IsEmpty) and (not fEmptyStr(LDocumento.Numero)) Then
        begin
          pProcessaVendaNaoEntregue(LDocumento, blnExisteOcorrencia);
          FblnVendaPerdidaGerada := FblnDocumentoExcluido And (intQtdIteVndPer > 0);
        end
        Else
        Begin
          FblnVendaPerdidaGerada := fRealizarGravacao And (intQtdIteVndPer > 0);
        End;
      End;
    Finally
      pFreeAndNil(frmFatSelItemVendaPerdida);
    End;
  Finally
    FreeAndNil(qryFatGor);
  End;
end;

procedure TGerarVendaPerdida.pProcessaVendaPerdidaItens(oblItens: TObjectList<TItemVendasPerdidas>; LDocumento: TDocumento);
var
  objItem: TItemVendasPerdidas;
Begin
  For objItem In oblItens Do
  Begin
    If cdsVenda.Locate('AUTOINCREM', objItem.strAutoIncrem, []) Then
    Begin
      If fDeletaItem(False,
                     LDocumento.Numero,
                     LDocumento.Especie,
                     LDocumento.CodigoEmpresa
                    ) Then
      FobjFatVenda.ItensVendaPerdida.Add(objItem);
    End
    Else
      objItem.Destroy;
  End;
End;

procedure TGerarVendaPerdida.pProcessaVendaNaoEntregue(LDocumento: TDocumento; blnExisteOcorrencia: Boolean);
  Var
    qryTemp: TUniQuery;
Begin
  FobjFatVenda.strNumDoc := LDocumento.Numero;
  FobjFatVenda.strEspDoc := LDocumento.Especie;
  FobjFatVenda.pInsereVendasPerdidas(false);
  If blnExisteOcorrencia Then
  Begin
    TfrmFatAltQtdeItensPedido.pBaixarPedidoNaoEntregue(LDocumento.Numero,
                                                       LDocumento.Especie,
                                                       LDocumento.CodigoEmpresa,
                                                       LDocumento.CodigoCliente,
                                                       False,
                                                       True,
                                                       EmptyStr,
                                                       EmptyStr,
                                                       True,
                                                       False,
                                                       EmptyStr,
                                                       False,
                                                       FncLimparSeparacao,
                                                       LDocumento.FAutoIncrem,
                                                       ExcluirExtLar);
  End
  Else
  Begin
    qryTemp := fCriaQuery(Nil);
    Try
      qryTemp.Close;
      qryTemp.SQL.Clear;
      qryTemp.SQL.Add('DELETE FROM FATGOR         ');
      qryTemp.SQL.Add('WHERE FGO_NUMDOC = :NUMDOC ');
      qryTemp.SQL.Add('  AND FGO_ESPDOC = :ESPDOC ');
      qryTemp.SQL.Add('  AND FGO_CODCLI = :CODCLI ');
      qryTemp.SQL.Add('  AND FGO_CODEMP = :CODEMP ');
      qryTemp.ParamByName('NUMDOC').AsString := LDocumento.Numero;
      qryTemp.ParamByName('ESPDOC').AsString := LDocumento.Especie;
      qryTemp.ParamByName('CODCLI').AsString := LDocumento.CodigoCliente;
      qryTemp.ParamByName('CODEMP').AsString := LDocumento.CodigoEmpresa;

      {Reprocessar Saldos}
      TReprocessarSaldoItem.New
        .AddItensDoDocumento(
          TItensReprocessarDoDocumento.New
            .Documento(LDocumento.Numero)
            .Especie(LDocumento.Especie)
            .Empresa(LDocumento.CodigoEmpresa)
          ).NotificarRoboParaReprocessarSaldos;

      qryTemp.ExecSQL;

      FblnDocumentoExcluido := True;
    Finally
      FreeAndNil(qryTemp);
    End;
  End;
End;

function TGerarVendaPerdida.fPedeSenhaLiberacaoExcluirItemComSolicitacaoAbastecimento: Boolean;
Var
  strPedTE: String;
  objLiberacao: TLiberacao;
begin
  If fEmptyStr(cdsVenda.FieldByName('ITE_EMPSOL').AsString) Then
    Exit(True);

  objLiberacao := TLiberacao.Create;
  Try

    strPedTE := fCampoTabela('GROUP_CONCAT(FGO_NUMDOC,"-",FGO_ESPDOC,"-",FGO_CODEMP)',
      'FATGOR INNER JOIN EXTGOR ON FATGOR.AUTOINCREM = FGO_SEQFGO',
      ['FGO_NMPDAB','FGO_ESPDAB','FGO_EMPDAB'],
      [FObjFatVenda.strNumOrc, FObjFatVenda.strEspOrc, FObjFatVenda.strEmpOri]);

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Exclusão de produto com solicitação de abastecimento');
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTextoCaption('Pedido', FObjFatVenda.strNumOrc + '-' + FObjFatVenda.strEspOrc + '-' + FObjFatVenda.strEmpOri);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente', FObjFatVenda.strCodCli + '-' + FObjFatVenda.strCliNom);
    objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor', FObjFatVenda.strCodVen + '-' + FObjFatVenda.strNomVen);
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTextoCaption('Produto', cdsVenda.FieldByName('ITE_CODITE').AsString + '-' + cdsVenda.FieldByName('ITE_DESITE').AsString);
    objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade', FloatToStrF(cdsVenda.FieldByName('ITE_QTDITE').AsFloat, ffFixed, 12, fCfgSis('DECQTD', varInteger)), 70, alDireita, teAmbos, '', 10);
    objLiberacao.objMsgLibera.pAddTextoCaption('Vr.Unitário', FloatToStrF(cdsVenda.FieldByName('ITE_UNITAR').AsFloat, ffFixed, 12, fCfgSis('DECUNI', varInteger)), 70, alDireita, teAmbos, '', 10);
    objLiberacao.objMsgLibera.pAddTextoCaption('Vr.Total', FloatToStrF(cdsVenda.FieldByName('ITE_TOTITE').AsFloat, ffFixed, 12, 2), 70, alDireita, teAmbos, '', 10);
    objLiberacao.objMsgLibera.pAddTextoCaption('Ped. TE', strPedTE);
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTexto('* Importante lembrar que o pedido de transferência está em trânsito.');
    objLiberacao.objMsgLibera.pAddTexto('  Caso seja necessário abortar a transferência, o mesmo precisa ser ');
    objLiberacao.objMsgLibera.pAddTexto('  alterado e/ou cancelado manualmente. ');
    objLiberacao.objMsgLibera.pAddQuebra;

    objLiberacao.strDirAce := 'EXCITESOLABS';
    objLiberacao.strMsgSen := 'Exclusão de produto com solicitação de abastecimento';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := FObjFatVenda.strCodDig;
    objLiberacao.strCliente := FObjFatVenda.strCodCli + '-' + FObjFatVenda.strNomCli;
    objLiberacao.strCpfCnpj := FObjFatVenda.strCliCgc;

    Result := FObjFatVenda.fFatMensagemLiberacao(objLiberacao);
  Finally
    FreeAndNil(objLiberacao);
  End;
end;

function TGerarVendaPerdida.fPodeAlterarItemOutroVendedor(FObjFatVenda: TFatVenda; strVenAtu, strVenIte: String; blnComSenha: Boolean = True): Boolean;
var
  objLiberacao: TLiberacao;
begin
  Result := True;

  If Not ( fCfgSis('VNDSPD', varBoolean) And (Pos(FObjFatVenda.strOpcDoc, 'OR_PD_VN_') > 0) ) Then
    Exit;

  objLiberacao := TLiberacao.Create;
  Try

    If (strVenIte <> strVenAtu) Then
    Begin
      Result := False;
      If blnComSenha Then
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Alterar / Excluir produtos e serviços de outros Vendedores (PD/OR/VN)');

        objLiberacao.strDirAce := 'ALITOUVEN';
        objLiberacao.strMsgSen := 'Alterar / Excluir produtos e serviços de outros Vendedores (PD/OR/VN)';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strCodDig := FObjFatVenda.strCodDig;
        objLiberacao.strCliente := FObjFatVenda.strCodCli  + '-' + FObjFatVenda.strNomCli;
        objLiberacao.strCpfCnpj := FObjFatVenda.strCliCgc;

        If (FObjFatVenda.fFatMensagemLiberacao(objLiberacao)) Then
        Begin
          Result := True;
        End;
      End;
    End;

  Finally
    FreeAndNil(objLiberacao);
  End;
end;

function TGerarVendaPerdida.fTravaExclusaoAlteracaoDoItemExpedido(const FObjFatVenda: TFatVenda; const strEntRet, strEntFut: string; blnExcluindo : Boolean = False): Boolean;
begin
  If FObjFatVenda.fProdutoSempreMarcaComoJaExpedido(strEntRet, strEntFut) then
    Exit(False);

  If Not blnExcluindo Then
    Exit(False);

  Result := (cdsVenda.FieldByName('ITE_QTDEXP').AsFloat > 0) And (VS_strTipExp = '4');

end;

procedure TGerarVendaPerdida.pCarregarOrdPro;
var
  intRecNo: Integer;
Begin
  intRecNo := cdsVenda.RecNo;
  cdsVenda.DisableControls;
  Try
    FstlOrdemProd.Clear;
    FstlProdCampanha.Clear;
    FstlProdBonus.Clear;

    cdsVenda.First;
    While Not cdsVenda.Eof Do
    Begin
      If Not fEmptyStr(cdsVenda.FieldByName('ITE_ORDPRO').AsString) Then
        FstlOrdemProd.Add(cdsVenda.FieldByName('AUTOINCREM').AsString);

      If (cdsVenda.FindField('FLG_STATUS') <> Nil)  And
         (cdsVenda.FieldByName('FLG_STATUS').AsString = 'C') Then
        FstlProdCampanha.Add(cdsVenda.FieldByName('ITE_CODITE').AsString);

      If (cdsVenda.FindField('FLG_STATUS') <> Nil)  And
         (cdsVenda.FieldByName('FLG_STATUS').AsString = 'B') Then
        FstlProdBonus.Add(cdsVenda.FieldByName('ITE_CODITE').AsString);

      cdsVenda.Next;
    End;
  Finally
    cdsVenda.RecNo := intRecNo;
    cdsVenda.EnableControls;
  End;
End;

procedure TGerarVendaPerdida.pDeletaItemDevolucaoCompleta(const FObjFatVenda: TFatVenda);
Var
  dtsTemp: TDataSet;
  strDocumento: String;
  strEspecie  : String;
  strEmpresa  : String;
  intSeqCom   : Integer;
  strMensagem : String;
  strTabDev   : String;
begin

  dtsTemp := cdsVenda.DataSource.DataSet;

  If Not dtsTemp.IsEmpty Then
  Begin
    strDocumento := dtsTemp.FieldByName('ITE_DOCDEV').AsString;
    strEspecie   := dtsTemp.FieldByName('ITE_ESPDEV').AsString;
    strEmpresa   := dtsTemp.FieldByName('ITE_EMPDEV').AsString;
    intSeqCom    := dtsTemp.FieldByName('ITE_SEQCOM').AsInteger;
    strTabDev    := dtsTemp.FieldByName('ITE_TABDEV').AsString;

    If (intSeqCom > 0) And (Not FObjFatVenda.blnDevolucaoCompleta) Then
      strMensagem := 'Deseja cancelar a devolução para TODOS os itens desse Combo?'
    Else
      strMensagem := 'Deseja cancelar a devolução para TODOS os itens do documento ' + strDocumento + '-' + strEspecie + '-' + strEmpresa + '?';

    If fMensagem('ATENÇÃO!', strMensagem, ['&Sim', '&Não']) = 1 Then
    Begin
      dtsTemp.First;
      While (Not dtsTemp.Eof) Do
      Begin
        If (strDocumento = dtsTemp.FieldByName('ITE_DOCDEV').AsString) And
           (strEspecie   = dtsTemp.FieldByName('ITE_ESPDEV').AsString) And
           (strEmpresa   = dtsTemp.FieldByName('ITE_EMPDEV').AsString) Then
        Begin
          If (intSeqCom > 0) And (Not FObjFatVenda.blnDevolucaoCompleta) And (intSeqCom <> dtsTemp.FieldByName('ITE_SEQCOM').AsInteger) Then
          Begin
            dtsTemp.Next;
            Continue;
          End;

          FObjFatVenda.pDestravaELimpaStlDocDevLck(strTabDev, strDocumento, strEspecie, strEmpresa, FObjFatVenda.strCodCli);
          dtsTemp.Delete;
        End
        Else
        Begin
          dtsTemp.Next;
        End;
      End;

      If (intSeqCom > 0) And (Not FObjFatVenda.blnDevolucaoCompleta) Then
        FObjFatVenda.fOrdemItem(cdsVenda,'Delete',Nil);
    End;
  End;

end;

procedure TGerarVendaPerdida.pGerarVendaPerdida(const strEmpDoc, strEspDoc,
  strNumDoc: String);
var
  LDocumento: TDocumento;
begin
  LDocumento := TDocumento.Create;
  Try
    LDocumento.Numero := strNumDoc;
    LDocumento.Especie := strEspDoc;
    LDocumento.CodigoEmpresa := strEmpDoc;
    LDocumento.CarregarDados;

    pGerarVendaPerdida(LDocumento);
  Finally
    FreeAndNil(LDocumento);
  End;
end;

function TGerarVendaPerdida.fQtdTotItem(strCodIte: String): Double;
var
  intRecNo: Integer;
Begin
  intRecNo := cdsVenda.RecNo;
  cdsVenda.DisableControls;
  Try
    cdsVenda.First;
    Result := 0;
    While Not cdsVenda.Eof Do
    Begin
      If cdsVenda.FieldByName('ITE_CODITE').AsString = strCodIte Then
        Result := Result + cdsVenda.FieldByName('ITE_QTDITE').AsFloat;

      cdsVenda.Next;
    End;
  Finally
    cdsVenda.RecNo := intRecNo;
    cdsVenda.EnableControls;
  End;
End;

function TGerarVendaPerdida.fPodeExcluirItemRequsicaoCompra(FObjFatVenda: TFatVenda; strCodIte: String;
  fltQtdDel: Double): Boolean;
var
  strSQL: String;
  qryAux: TUniQuery;
  fltQtdTot: Double;
  objLiberacao: TLiberacao;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                              ';
  strSQL := strSQL + '   RCD_CODIGO,                       ';
  strSQL := strSQL + '   GROUP_CONCAT(                     ';
  strSQL := strSQL + '     COT_NUMCOT                      ';
  strSQL := strSQL + '   ) AS COTACOES,                    ';
  strSQL := strSQL + '   GROUP_CONCAT(                     ';
  strSQL := strSQL + '     CONCAT(                         ';
  strSQL := strSQL + '       PCD_NUMPED,                   ';
  strSQL := strSQL + '       "-",                          ';
  strSQL := strSQL + '       PCD_ESPDOC,                   ';
  strSQL := strSQL + '       "-",                          ';
  strSQL := strSQL + '       PCD_CODEMP                    ';
  strSQL := strSQL + '     )                               ';
  strSQL := strSQL + '   ) AS PEDIDOS,                     ';
  strSQL := strSQL + '   SUM(RCD_QTDITE) AS RCD_QTDITE     ';
  strSQL := strSQL + ' FROM                                ';
  strSQL := strSQL + '   MOVRCD                            ';
  strSQL := strSQL + ' LEFT JOIN PCMDET                    ';
  strSQL := strSQL + '   ON PCMDET.AUTOINCREM = RCD_SEQPCD ';
  strSQL := strSQL + ' LEFT JOIN COTITE                    ';
  strSQL := strSQL + '   ON COTITE.AUTOINCREM = RCD_SEQCOT ';
  strSQL := strSQL + ' LEFT JOIN COTGER                    ';
  strSQL := strSQL + '   ON COTGER.AUTOINCREM = COT_SEQGER ';
  strSQL := strSQL + ' WHERE RCD_CODITE = :CODITE          ';
  strSQL := strSQL + '   AND RCD_CODIGO = :CODIGO          ';
  strSQL := strSQL + '   AND (                             ';
  strSQL := strSQL + '     (RCD_SEQPCD IS NOT NULL)        ';
  strSQL := strSQL + '     OR (RCD_SEQCOT IS NOT NULL)     ';
  strSQL := strSQL + '   )                                 ';

  Result := True;
  qryAux := fCriaQuery();
  objLiberacao := TLiberacao.Create;
  Try
    qryAux.SQL.Text := strSQL;
    qryAux.ParamByName('CODITE').AsString := strCodIte;
    qryAux.ParamByName('CODIGO').AsString := fCampoTabela('RCG_CODIGO', 'MOVRCG', ['AUTOINCREM'], [FObjFatVenda.strInRqCp]);
    qryAux.Open;

    If qryAux.FieldByName('RCD_QTDITE').IsNull Then
      Exit;

    fltQtdTot := fQtdTotItem(strCodIte);

    if fltQtdTot - fltQtdDel >= qryAux.FieldByName('RCD_QTDITE').AsFloat Then
      Exit;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Exclusão/Alteração de um item de um pedido de venda com requisição de compra');
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTextoCaption('Item:', strCodIte + '-' + fRetNomProduto(strCodIte));
    objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade total do item no pedido'                                 , FloatToStrF(fltQtdTot, ffFixed, 12, fCfgSis('DECQTD', varInteger))                         , 70, alDireita, teAmbos, '', 10);
    objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade sendo retirada do pedido'                                , FloatToStrF(fltQtdDel, ffFixed, 12, fCfgSis('DECQTD', varInteger))                         , 70, alDireita, teAmbos, '', 10);
    objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade restante no pedido'                                      , FloatToStrF(fltQtdTot - fltQtdDel, ffFixed, 12, fCfgSis('DECQTD', varInteger))             , 70, alDireita, teAmbos, '', 10);
    objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade total que não pode ser excluída da requisição de compra' , FloatToStrF(qryAux.FieldByName('RCD_QTDITE').AsFloat, ffFixed, 12, fCfgSis('DECQTD', varInteger)) , 70, alDireita, teAmbos, '', 10);
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTextoCaption('Número da requisição de compra: ',  qryAux.FieldByName('RCD_CODIGO').AsString);

    If Not qryAux.FieldByName('COTACOES').IsNull Then
      objLiberacao.objMsgLibera.pAddTextoCaption('Cotações vinculadas à requisição', qryAux.FieldByName('COTACOES').AsString);
    If Not qryAux.FieldByName('PEDIDOS').IsNull Then
      objLiberacao.objMsgLibera.pAddTextoCaption('Pedidos de compra vinculados à requisição', qryAux.FieldByName('PEDIDOS').AsString);

    objLiberacao.strDirAce := 'EXCITEREQCOM';
    objLiberacao.strMsgSen := 'Exclusão/Alteração de um item de um pedido de venda com requisição de compra';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := FObjFatVenda.strCodDig;
    objLiberacao.strCliente := FObjFatVenda.strCodCli + '-' + FObjFatVenda.strNomCli;
    objLiberacao.strCpfCnpj := FObjFatVenda.strCliCgc;

    If (Not FObjFatVenda.fFatMensagemLiberacao(objLiberacao)) Then
    Begin
      Result := False;
    End;

  Finally
    FreeAndNil(objLiberacao);
    FreeAndNil(qryAux);
  End;
end;

function TGerarVendaPerdida.fPermiteSelecionarEspeciePedido(const FObjFatVenda: TFatVenda): Boolean;
begin
  Result := (Pos(FObjFatVenda.strOpcDoc, 'VN_CS_') > 0) And
            fCfgSis('SVPDVN', varBoolean) And
            fCfgSis('USAPDV', varBoolean) And
            fVerificaAcessoSistema('frmFatVendas - PD') And
            (Not FObjFatVenda.fOrcamentoOutraLojaORVN);

  If Result And (FblnPDOriDesmembramento) And (Not fCfgSis('EDPDDS', varBoolean)) Then
    Result := False;

  If (FObjFatVenda.blnEnt_CD) And
     (Not fEmptyStr(FObjFatVenda.strNumOrc)) And (SameText(FObjFatVenda.strEspOrc, 'PD')) Then
  Begin
    If (FObjFatVenda.fTotalDuplicataQuitada(FObjFatVenda.strNumOrc,
                                           FObjFatVenda.strEspOrc,
                                           FObjFatVenda.strEmpOri,
                                           FObjFatVenda.fRetClienteOriginal) > 0) Then
    Begin
      Result := False;
    End;

    If (TAdiantamento.fGetTotaisAdiantamento(FObjFatVenda.strNumOrc,
                                             FObjFatVenda.strEspOrc,
                                             FObjFatVenda.strEmpOri).fltValLan > 0) Then
    Begin
      Result := False;
    End;
  End;

  If fUsaRotinaWMS(FObjFatVenda.fEmpresaSaldoMatriz_CD) Then
    Result := False;

  If (Not fPermiteItemEspecial('PD')) And fTemItemEspecialVenda Then
    Result := False;

  If (FObjFatVenda.strOpcDoc = 'CS') and
     not(FObjFatVenda.fEhEmissaoDocumentoWMS) and
     fCfgSis('PDENCS', varBoolean) Then
    Result := True;
end;

function TGerarVendaPerdida.fTemItemEspecialVenda: Boolean;
  Var
    cdsDados: TUniClientDataSet;
begin
  Result := False;

  cdsDados := TUniClientDataSet.Create(Nil);
  Try
    pCloneDataSet(cdsDados, cdsVenda);
    cdsDados.First;
    While Not cdsDados.Eof do
    begin
      Result := fPos('ITEM ESPECIAL', cdsDados.FieldByName('ITE_DESORI').AsString);

      If Result Then
        Break;

      cdsDados.Next;
    End;
  Finally
    pFreeAndNil(cdsDados);
  End;
end;

function TGerarVendaPerdida.fPermiteAlterarPedido(FObjFatVenda: TFatVenda; blnAlterando: Boolean): Boolean;
  Var
    strTmp: String;
    strOpc: String;
begin
  Result := True;

  If blnAlterando Then
    strTmp := 'alter'
  Else
    strTmp := 'delet';

  If FObjFatVenda.strOpcDoc = 'TE' Then
    strOpc := 'Transferência de Estoque'
  Else If FObjFatVenda.strOpcDoc = 'OU' Then
    strOpc := 'Outras Saídas'
  Else
    strOpc := 'Venda Normal';

  If ((FObjFatVenda.strEspOrc='PD') And (Not fEmptyStr(FObjFatVenda.strNumOrc)) And
       (fPedidoTemVinculo(FObjFatVenda.strNumOrc, FObjFatVenda.strEspOrc, FObjFatVenda.strEmpOri))) And (Not fCfgSis('EDPDDS', varBoolean)) Then
  Begin
    fMensagem('ATENÇÃO!', 'O sistema está configurado para não permitir alterar um pedido oriundo de desmembramento, '+
                          'você poderá apenas faturá-lo!', ['&Ok']);
    Result := False;
  End;

  If (Result) And
     (fPos(FObjFatVenda.strOpcDoc, 'VN_TE_OU_')) And
     (Not fEmptyStr(FObjFatVenda.strNumOrc) ) And
     (Not fEmptyStr(FObjFatVenda.strEspOrc) ) And
     (Not fEmptyStr(FObjFatVenda.strEmpOri) ) And
     (SameText(FObjFatVenda.strEspOrc, 'PD')) And
     (Not FblnJaAvisouAltPD) Then
  Begin
    If fPermiteSelecionarEspeciePedido(FObjFatVenda) Then
    Begin
      fMensagem('ATENÇÃO!','Você está ' + strTmp + 'ando itens de um pedido, por isso só será permitido salvar o mesmo como pedido.',['&OK']);
      FblnJaAvisouAltPD := True;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!','Não é permitido ' + strTmp + 'ar itens de um pedido pela rotina de ' + strOpc +
                '. Carregue o mesmo pela opção de pedido e realize as ' + IIF(blnAlterando, 'alterações', 'deleções') + ' necessárias.',['&OK']);
      Result := False;
    End;
  End;
end;

function TGerarVendaPerdida.fPDEmPreRomaneio(strNumDoc, strEspDoc, strCodCli, strCodEmp: String): Boolean;
Var
  qryGen : TUniQuery;
begin
  Result := False;

  If ( fEmptyStr(strNumDoc) And fEmptyStr(strEspDoc) And fEmptyStr(strCodEmp) ) Then
    Exit;

  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT ');
    qryGen.SQL.Add('  GER_NUMROM ');
    qryGen.SQL.Add('FROM ');
    qryGen.SQL.Add('  ROMGERX D  ');
    qryGen.SQL.Add('WHERE ');
    qryGen.SQL.Add('  GER_CODEMP = :CODEMP AND ');
    qryGen.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
    qryGen.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
    qryGen.SQL.Add('  GER_CODCLI = :CODCLI AND ');
    qryGen.SQL.Add('  GER_STATUS = "P"         ');

    qryGen.ParamByName('CODEMP').AsString := strCodEmp;
    qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
    qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
    qryGen.ParamByName('CODCLI').AsString := strCodCli;
    qryGen.Open;

    Result := Not qryGen.IsEmpty;
  Finally
    FreeAndNil(qryGen);
  End;
End;

function TGerarVendaPerdida.fValidaAbastecimentoVinculado: Boolean;
var
  strRequisicoes: String;
  strTransferencias: String;
Begin
  Result := True;
  If (FObjFatVenda.strOpcDoc = 'PD') And fCfgSis('SLTFRC', varBoolean) Then
  Begin
    If fPossuiAbastecimentoVinculadoComReqCompra(cdsVenda.FieldByName('ITE_SEQDET').AsString, strRequisicoes) Then
    Begin
      fMensagem('','Produto vinculado à requisição de compra não pode ser excluído!' + #13#10 +
        'Req. Compra: ' + strRequisicoes + '.', ['&OK']);
      Result := False;
    End;

    If fPossuiAbastecimentoVinculadoComTransferencia(cdsVenda.FieldByName('ITE_SEQDET').AsString, strTransferencias) Then
    Begin
      fMensagem('','Produto vinculado à transferência(s) de estoque não pode ser excluído!' + #13#10 +
        'Doc. Transf.: ' + strTransferencias + '.', ['&OK']);
      Result := False;
    End;
  End;
End;

function TGerarVendaPerdida.fValidaPermiteAlterarItem: Boolean;
var
  blnPermiteAlterarItem : Boolean;
Begin
  Result := True;

  blnPermiteAlterarItem := IIF(FObjFatVenda.strOpcDoc = 'EM', False, cdsVenda.FieldByName('ITE_PODALT').AsBoolean);

  If (Not blnPermiteAlterarItem) Then
  Begin
    If (fEmptyStr(cdsVenda.FieldByName('ITE_EMPSOL').AsString)) Then
     Result := False;

    If Not fPedeSenhaLiberacaoExcluirItemComSolicitacaoAbastecimento Then
     Result := False;
  End;

  If Not fPodeAlterarItemOutroVendedor(FObjFatVenda, FObjFatVenda.strCodVen, cdsVenda.FieldByName('ITE_CODVEN').AsString) Then
    Result := False;

End;

function TGerarVendaPerdida.fValidaPodeDeletaItem(blnExibeSenha:Boolean; strNumOrc, strEspOrc, strEmpOrc: String): Boolean;
Begin
  Result := False;

  If FObjFatVenda.strOpcDoc = 'CO' Then
    Exit;

  If cdsVenda.IsEmpty Then
    Exit;

  If Not fValidaPermiteAlterarItem Then
    Exit;

  If Assigned(FObjFatVenda.DadosPixDaVenda.ObjetoPixPago) And  (MatchStr(FObjFatVenda.DadosPixDaVenda.ObjetoPixPago.Status, STATUS_PIX_PAGO)) Then
  Begin
    fMensagem('ATENÇÃO', 'Não é permitido excluir um item de uma venda com uma cobrança Pix já recebida.', ['&Ok']);
    Exit(False);
  End;

  If FObjFatVenda.blnFromOrdemProducao Then
  Begin
    fMensagem('','Não é permitido excluir itens em pedidos com ordem de produção vinculada!', ['&OK']);
    Exit;
  End;

  If Not fValidaAbastecimentoVinculado Then
    Exit;

  If fTravaExclusaoAlteracaoDoItemExpedido(FObjFatVenda, cdsVenda.FieldByName('ITE_ENTRET').AsString, cdsVenda.FieldByName('ITE_ENTFUT').AsString, True) Then
  Begin
    fMensagem('ATENÇÃO!','Não é permitido excluir este produto, pois o mesmo já possui quantidade expedida!',['&O K']);
    Exit;
  End;

  If (cdsVenda.FieldByName('ITE_SEQINC').AsInteger > 0) And (Not fEmptyStr(FObjFatVenda.strNumOrc)) And
     (fQuantidadeItensPendenteAlmoxarifeAutocenter(FObjFatVenda.strNumOrc,
                                                    FObjFatVenda.strEspOrc,
                                                    FObjFatVenda.strEmpDoc,
                                                    cdsVenda.FieldByName('ITE_SEQINC').AsInteger) > 0) Then
  Begin
    fMensagem('', 'Este produto possui itens que saíram do almoxarifado e não voltaram, ' +
                  'é preciso efetuar a conferência de entrada ' +
                  'dos itens para poder excluir o mesmo!', ['&O k']);
    Exit;
  End;

  If (FObjFatVenda.strOpcDoc = 'CN') And Not fEmptyStr(cdsVenda.FieldByName('ITE_DOCCNF').AsString) Then
  Begin
    fMensagem('', 'Não é permitido excluir este produto, pois o mesmo pertence a ' +
                  'Nota Fiscal ' + cdsVenda.FieldByName('ITE_DOCCNF').AsString, ['&Ok']);
    Exit;
  End;

  If Not fPodeExcluirItemRequsicaoCompra(FObjFatVenda,
                                         cdsVenda.FieldByName('ITE_CODITE').AsString,
                                         fFormataFloat(cdsVenda.FieldByName('ITE_QTDITE').AsFloat, fCfgSis('DECQTD', VarInteger))) Then
  Begin
    Exit;
  End;

  If (Pos(FObjFatVenda.strOpcDoc, 'DV_PR_') > 0) And ((FObjFatVenda.blnDevolucaoCompleta) Or (cdsVenda.FieldByName('ITE_SEQCOM').AsInteger > 0)) Then
  Begin
    pDeletaItemDevolucaoCompleta(FObjFatVenda);
    Exit;
  End;

  Result := True;
End;

function TGerarVendaPerdida.fValidaLiberacaoSenha(strNumOrc, strEspOrc, strEmpOrc: String;
  blnExibeSenha: boolean): Boolean;
var
  blnExigeSenha: Boolean;
  strSenhaConfg: String;
  blnTemDireitoAcessoExclusao : Boolean;
  LDescricaoDoDireitoDeAcesso : String;
  objLiberacao : TLiberacao;
  LMensagem : String;
Begin
  Result := True;

  blnExigeSenha := ((Not fEmptyStr(fCfgSis('SENEXI'))) And (FObjFatVenda.strOpcDoc <> 'OR'))
                         Or ((Not fEmptyStr(fCfgSis('SENEIO'))) And (FObjFatVenda.strOpcDoc = 'OR'));

  If (blnExigeSenha) Then
    If fEmptyStr(strNumOrc) Or (Not fExisteItemPD_OR(strNumOrc,
                                                     strEspOrc,
                                                     strEmpOrc,
                                                     cdsVenda.FieldByName('ITE_CODITE').AsString,
                                                     cdsVenda.FieldByName('ITE_SEQINC').AsString)) Then
      blnExigeSenha := False;

  If blnExigeSenha and  blnExibeSenha Then
  Begin
    If ((Not fEmptyStr(fCfgSis('SENEXI'))) And (FObjFatVenda.strOpcDoc <> 'OR')) Then
    begin
      strSenhaConfg := fCfgSis('SENEXI');
      LDescricaoDoDireitoDeAcesso := 'PEREXCLPRODPED';
    end
    Else If ((Not fEmptyStr(fCfgSis('SENEIO'))) And (FObjFatVenda.strOpcDoc = 'OR')) Then
    begin
      strSenhaConfg := fCfgSis('SENEIO');
      LDescricaoDoDireitoDeAcesso :=  'PEREXCLPRODORC';
    end
    Else
      strSenhaConfg := '';

    objLiberacao := TLiberacao.Create;
    Try
      LMensagem := 'Permitir excluir produtos no faturamento - '+ IIF(LDescricaoDoDireitoDeAcesso = 'PEREXCLPRODORC', 'Orçamento', 'Pedido e Venda Normal');

      objLiberacao.Clear;
      objLiberacao.blnManterCompatibilidadeSenCfg := Not fEmptyStr(strSenhaConfg);
      objLiberacao.strSenLib    := strSenhaConfg;
      objLiberacao.strDirAce    := strSenhaConfg;
      objLiberacao.strMsgSen    := LMensagem ;
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto(LMensagem);

      blnTemDireitoAcessoExclusao := objLiberacao.fLibera;

      If Not blnTemDireitoAcessoExclusao Then
        Result := False;

    Finally
      FreeAndNil(objLiberacao);
    End;
  End;
End;

function TGerarVendaPerdida.fValidaItem: Boolean;
Begin
  Result := False;
  If Not fEmptyStr(cdsVenda.FieldByName('ITE_ORDPRO').AsString) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido excluir este produto pois o mesmo possui ordem de produção. ' +
                          'Para excluir este produto é necessário cancelar a ordem de produção ' +
                          cdsVenda.FieldByName('ITE_ORDPRO').AsString, ['&Ok']);
    Exit;
  End;

  If (FstlFormulacaoBaixada.IndexOf(cdsVenda.FieldByName('ITE_CODACA').AsString +
                                   cdsVenda.FieldByName('ITE_EMPACA').AsString) >= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido excluir esta tinta de máquina, pois a mesma já foi baixada.', ['&Ok']);
    Exit;
  End;

  If (cdsVenda.FieldByName('ITE_QTDBAI').AsFloat > 0.0) Then
  Begin
    cdsVenda.Edit;
    cdsVenda.FieldByName('ITE_QTDITE').AsFloat := 0;
    cdsVenda.FieldByName('ITE_TOTITE').AsFloat := 0;
    cdsVenda.Post;

    Exit;
  End;

  If (Not FObjFatVenda.blnCarregandoEstrutura) And (Not fPermiteAlterarPedido(FObjFatVenda, True)) Then
    Exit;

  Result := True;
End;

procedure TGerarVendaPerdida.pDeletaListas;
Begin
  If ((FstlOrdemProd.Count > 0)) And (FstlOrdemProd.IndexOf(cdsVenda.FieldByName('AUTOINCREM').AsString) <> -1) Then
  Begin
    FstlOrdemProd.Delete(FstlOrdemProd.IndexOf(cdsVenda.FieldByName('AUTOINCREM').AsString));
  End;

  If ((FstlProdCampanha.Count > 0)) And (FstlProdCampanha.IndexOf(cdsVenda.FieldByName('ITE_CODITE').AsString) <> -1) Then
  Begin
    FstlProdCampanha.Delete(FstlProdCampanha.IndexOf(cdsVenda.FieldByName('ITE_CODITE').AsString));
  End;

  If ((FstlProdBonus.Count > 0)) And (FstlProdBonus.IndexOf(cdsVenda.FieldByName('ITE_CODITE').AsString) <> -1) Then
  Begin
    FstlProdBonus.Delete(FstlProdBonus.IndexOf(cdsVenda.FieldByName('ITE_CODITE').AsString));
  End;
End;

procedure TGerarVendaPerdida.pInsereItensSep;
Begin
  If (FObjFatVenda.fEhAutocenter) Or (fCfgSis('RETDEV', varBoolean)) Then
    FObjFatVenda.pInsereRegistroLogItensSep(cdsVenda, 'E', cdsVenda.FieldByName('ITE_QTDITE').AsFloat, True);
End;

procedure TGerarVendaPerdida.pProcessaEstruturaVidros;
Begin
  If FblnUtilizaVendaVidro And Assigned(FObjFatVenda.objEstruturaVidros) And
     fEhItemVendaVidro(cdsVenda.FieldByName('ITE_CODITE').AsString) Then
  Begin
    FObjFatVenda.objEstruturaVidros.pExcluirEstrutura(cdsVenda.FieldByName('AUTOINCREM').AsInteger);
  End;
End;

procedure TGerarVendaPerdida.pProcessaDicFormulas(const strAutInc: String);
Begin
  If Assigned(FObjFatVenda.dicFormulas.RetornaObjeto(strAutInc)) Then
  Begin
    FObjFatVenda.dicFormulas.RetornaObjeto(strAutInc).Free;
    FObjFatVenda.dicFormulas.Remove(strAutInc);
  End;
End;

procedure TGerarVendaPerdida.pApagaSerieItem;
Begin
  If fCfgSis('NSERQT', varBoolean) And (cdsVenda.FieldByName('ITE_TEMNSE').AsString = 'S') Then
  Begin
    FObjFatVenda.objFatSerieItem.AutoincItem := IntToStr(cdsVenda.FieldByName('AUTOINCREM').AsInteger);
    FObjFatVenda.objFatSerieItem.pApagaSeries;
  End;
End;

function TGerarVendaPerdida.fDeletaItem(blnExibeSenha:Boolean;
  strNumOrc, strEspOrc, strEmpOrc: String): Boolean;
Var
  strAutInc: String;
  prcScroll: TprcScroll;
  blnRecalcularItensSairamPromocao: Boolean;
  strDevDoc,
  strDevEsp,
  strDevEmp: String;
  strAtivac: String;
  intSeqCom: Integer;
  blnDelete: Boolean;
  strIteDel: String;
  strUnidadeDel : String;
  strProDel: String;
  strCodPro: String;
  strRshDel : String;
  intSeqEst: Integer;
  intRecNo: Integer;
begin
  Result := False;

  If Not fValidaPodeDeletaItem(blnExibeSenha, strNumOrc, strEspOrc, strEmpOrc) Then
    Exit;

  blnRecalcularItensSairamPromocao := (cdsVenda.FieldByName('ITE_PROMOC').AsString = 'S') And
                                      (FObjFatVenda.fRetQtdDigitada(cdsVenda.FieldByName('ITE_CODITE').AsString,
                                                                cdsVenda.FieldByName('ITE_NUMLOT').AsString,
                                                                cdsVenda.FieldByName('AUTOINCREM').AsString,
                                                                cdsVenda.FieldByName('ITE_CODACA').AsString,
                                                                cdsVenda.FieldByName('ITE_EMPACA').AsString,
                                                                cdsVenda.FieldByName('ITE_EMPITE').AsString,
                                                                False,
                                                                False,
                                                                FObjFatVenda.fDesconsiderarNaQtdLimDaPromoItensUnitarMaior,
                                                                True {Somente em promocao}) > 0);

  strIteDel := '';
  strUnidadeDel := '';
  strProDel := '';

  If (Not cdsVenda.IsEmpty) Then
  Begin
    intRecNo := cdsVenda.RecNo;
    Try
      If Not fValidaLiberacaoSenha(strNumOrc, strEspOrc, strEmpOrc, blnExibeSenha) Then
        Exit;

      If Not fValidaItem Then
        Exit;

      pDeletaListas;

      pDisableControls(cdsVenda, prcScroll);

      strAutInc := cdsVenda.FieldByName('AUTOINCREM').AsString;

      pProcessaDicFormulas(strAutInc);

      pInsereItensSep;

      pProcessaDicFormulas('tintaDeMaquina.' + strAutInc);

      pProcessaEstruturaVidros;

      pApagaSerieItem;

      If (FObjFatVenda.strOpcDoc = 'PD')             And
         (FObjFatVenda.strEspOrc = 'PD')             And
         (fPDEmPreRomaneio(FObjFatVenda.strNumOrc, FObjFatVenda.strEspOrc, FObjFatVenda.strCodCli, FObjFatVenda.strEmpOri)) And
         (fCfgSis('USPRRO',varBoolean)) Then
      Begin
        SetLength(FObjFatVenda.arrAutIncIteDel, Length(FObjFatVenda.arrAutIncIteDel) + 1);
        FObjFatVenda.arrAutIncIteDel[Length(FObjFatVenda.arrAutIncIteDel) - 1] := cdsVenda.FieldByName('ITE_SEQDET').AsString;
      End;

      If Not fEmptyStr(cdsVenda.FieldByName('ITE_SEQDET').AsString) Then
        pIncrementaListaStr(cdsVenda.FieldByName('ITE_SEQDET').AsString, FObjFatVenda.strAutIncIteDel, True);

      FObjFatVenda.pDelCalcFlex(strAutInc);

      pProcessaCalculoFlex;

      strDevDoc:= cdsVenda.FieldByName('ITE_DOCDEV').AsString;
      strDevEsp:= cdsVenda.FieldByName('ITE_ESPDEV').AsString;
      strDevEmp:= cdsVenda.FieldByName('ITE_EMPDEV').AsString;

      strAtivac := cdsVenda.FieldByName('ITE_ATIVAC').AsString;
      intSeqCom := cdsVenda.FieldByName('ITE_SEQCOM').AsInteger;
      intSeqEst := cdsVenda.FieldByName('ITE_SEQEST').AsInteger;

      blnDelete := True;

      blnDelete := IIF((strAtivac = 'S') And (fMensagem('ATENÇÃO!', 'O Produto que está excluindo é um Produto de Ativação do Combo de Venda. Excluindo esse Produto, todos os Produtos do Combo de Venda também serão excluídos. Confirma?', ['&S i m', '&N ã o'], 2) = 2),
                       False,
                       blnDelete);

      If (fCfgSis('OSPDVN', varBoolean)) Then Begin
        FObjFatVenda.objOrdSer.pExcluirItem(cdsVenda.FieldByName('ITE_CODITE').AsString, cdsVenda.FieldByName('ITE_SEQORS').AsInteger);
      End;

      If (blnDelete) Then
      Begin
        strIteDel     := cdsVenda.FieldByName('ITE_CODITE').AsString;
        strUnidadeDel := cdsVenda.FieldByName('ITE_CODUNI').AsString;
        strProDel := cdsVenda.FieldByName('ITE_PROMOC').AsString;
        strRshDel := cdsVenda.FieldByName('ITE_ITETIN').AsString;
        cdsVenda.Delete;
        pApagaItensComboVenda(strAtivac, intSeqCom);
        pAtualizaItensEstrutura(intSeqEst);
      End
      Else
        Exit;

      FObjFatVenda.arrMatItens := FObjFatVenda.arrMatItens;

      FObjFatVenda.fOrdemItem(cdsVenda,'Delete',Nil);

      pRecalculaItem(strIteDel, strUnidadeDel, strProDel, strCodPro, strRshDel, blnRecalcularItensSairamPromocao);

      Result := True;

    Finally
      If (Not cdsVenda.IsEmpty) And
         (cdsVenda.RecordCount >= intRecNo) Then
      Begin
        cdsVenda.RecNo := intRecNo;
      End;

      cdsVenda.EnableControls;

    End;
  End;
end;

procedure TGerarVendaPerdida.pRecalculaItem(strIteDel, strUnidadeDel, strProDel, strCodPro, strRshDel: String;
  blnRecalcularItensSairamPromocao: Boolean);
var
  strRshAut: String;
Begin
  If (cdsVenda.IsEmpty) And (FObjFatVenda.blnComVal) Then
  Begin
    FObjFatVenda.blnComVal := False;
  End;

  strRshAut := cdsVenda.FieldByName('ITE_ITETIN').AsString;

  TProQtdColetiva.strRshTinAtual := cdsVenda.FieldByName('ITE_ITETIN').AsString;

  TProQtdColetiva.cdsDadosPromocaoKit := Nil;
  If fCfgSis('PROKIT', varBoolean) Then
  Begin
    FObjFatVenda.pCarregarDadosParaPromocaoPorKit;
    If (Assigned(FObjFatVenda.cdsDadosPromocaoKit) and (FObjFatVenda.cdsDadosPromocaoKit.RecordCount > 0))  then
      TProQtdColetiva.cdsDadosPromocaoKit := FObjFatVenda.cdsDadosPromocaoKit;
  End;

  If (fRecalculaItensPromocaoColetiva(strIteDel, strUnidadeDel, strProDel, strCodPro, True, strRshDel, strRshAut)) Then
  Begin
    FblnRecalculaPrecos := True;
    pRecalculaPrecos(False, False, False, True, strCodPro);
  End
  Else If blnRecalcularItensSairamPromocao Then
  Begin
    FblnRecalculaPrecos := True;
    pRecalculaPrecos(False, False, False, True, '', True, True {Somente saida de promocao}, False);
  End
  Else if TProQtdColetiva.fRecalculaPrecosDevidoAPromocaoPorKit then
  Begin
    FblnRecalculaPrecos := True;
    pRecalculaPrecos(False, False, False, True, '');
  End;

  fCarregarBrindesPromocaoCompostaPorKit;
End;

function TGerarVendaPerdida.fValidaGeracaoVendaPerdida: Boolean;
begin
  Result := True;

  FblnJaAvisouAltPD := False;
  FblnPDOriDesmembramento := (FObjfatVenda.strEspOrc='PD') And (Not fEmptyStr(FObjfatVenda.strNumOrc)) And
                             (fPedidoTemVinculo(FObjfatVenda.strNumOrc, FObjfatVenda.strEspOrc, FObjfatVenda.strEmpOri));
end;

procedure TGerarVendaPerdida.pProcessaCalculoFlex;
  Var
    intRecNo: Integer;
    blnItemEmbalagemFechada: Boolean;
begin
  intRecNo := cdsVenda.RecNo;
  cdsVenda.DisableControls;
  Try
    cdsVenda.First;
    While Not cdsVenda.Eof Do
    Begin
      blnItemEmbalagemFechada := fEhEmbalagemFechadaItem(cdsVenda.FieldByName('ITE_CODITE').AsString, cdsVenda.FieldByName('ITE_TABPRE').AsString, cdsVenda.FieldByName('ITE_QTDITE').AsFloat);

      If (Pos(FObjfatVenda.strOpcDoc,'OR_PD_VN_') > 0) And
         (fCfgSis('EXFLVN', varBoolean)) And
         (VS_strTRVEPR = '1') And
         (FObjfatVenda.fGeraFlexOpe) And
         (fUsaFlex(cdsVenda.FieldByName('ITE_CODITE').AsString)) And
         ((cdsVenda.FieldByName('ITE_PROMOC').AsString = 'N') Or ((cdsVenda.FieldByName('ITE_PROMOC').AsString = 'S') And
         (fCfgSis('PROFLE', varBoolean)))) And
         ((Not blnItemEmbalagemFechada) Or ((blnItemEmbalagemFechada) And (fCfgSis('EMFFLE', varBoolean)))) Then
      Begin
        FObjfatVenda.fAddCalcFlex(cdsVenda.FieldByName('AUTOINCREM').AsString,
                                  cdsVenda.FieldByName('ITE_CODITE').AsString,
                                  cdsVenda.FieldByName('ITE_TOTITE').AsFloat,
                                  cdsVenda.FieldByName('ITE_DESESP').AsFloat,
                                  cdsVenda.FieldByName('ITE_QTDITE').AsFloat,
                                  cdsVenda.FieldByName('ITE_UNIORI').AsFloat,
                                  cdsVenda.FieldByName('ITE_DESMAX').AsFloat);
      End;

      cdsVenda.Next;
    End;
  Finally
    cdsVenda.RecNo := intRecNo;
    cdsVenda.EnableControls;
  End;
end;

procedure TGerarVendaPerdida.pApagaItensComboVenda(strAtivac: String; intSeqCom: Integer);
Var
  intRecNo: Integer;
begin
  intRecNo := cdsVenda.RecNo;
  Try
    If (strAtivac = 'S') Then
    Begin
      cdsVenda.First;

      While Not cdsVenda.Eof Do
      Begin
        If (cdsVenda.FieldByName('ITE_SEQCOM').AsInteger = intSeqCom) And
           (cdsVenda.FieldByName('ITE_ATIVAC').AsString <> 'S') Then
        Begin
          cdsVenda.Delete;
          Continue;
        End;

        cdsVenda.Next;
      End;
    End;
  Finally
    If (intRecNo > cdsVenda.RecordCount) Then
      cdsVenda.Last
    Else
      cdsVenda.RecNo := intRecNo;
  End;
end;

procedure TGerarVendaPerdida.pAtualizaItensEstrutura(intSeqEst: Integer);
Var
  intRecNo: Integer;
begin
  If FObjfatVenda.fUtilizarPrecoSubItemEstruturaTravaPreco() And (intSeqEst > 0) Then
  Begin
    cdsVenda.DisableControls;
    intRecNo := cdsVenda.RecNo;

    pRecalculaPrecos(False, False, False, True, '', False, False, False, False, False, False, False, intSeqEst);
    Try
      cdsVenda.First;
      While Not cdsVenda.Eof Do
      Begin
        If (cdsVenda.FieldByName('ITE_SEQEST').AsInteger = intSeqEst) Then
        Begin
          cdsVenda.Edit;
          cdsVenda.FieldByName('ITE_SEQEST').AsInteger := 0;
          cdsVenda.FieldByName('ITE_ITEEST').AsString  := '';
          cdsVenda.FieldByName('ITE_UNIEST').AsInteger := 0;
          cdsVenda.FieldByName('ITE_QTDSBI').AsInteger := 0;
          cdsVenda.FieldByName('ITE_UNISBI').AsInteger := 0;
          cdsVenda.Post;
        End;
        cdsVenda.Next;
      End;

      If (intRecNo > cdsVenda.RecordCount) Then
        cdsVenda.Last
      Else
        cdsVenda.RecNo := intRecNo;

    Finally
      cdsVenda.EnableControls;
    End;
  End;
end;

function TGerarVendaPerdida.fTemPromocaoColetiva: Boolean;
Begin
  Result := (Pos(FObjFatVenda.strOpcDoc, 'PD_OR_VN_') > 0) And
            (Not cdsVenda.IsEmpty) And
            (Length(TProQtdColetiva.ArrItemPro) > 0);
End;

function TGerarVendaPerdida.fCalcularQtdIte(var fltQtdIte: Double; var fltQtdTotIte: Double;
  blnDel, blnProAtv: Boolean): Boolean;
var
  intRecNo: Integer;
Begin
  fltQtdIte := 0;

  Result := False;
  intRecNo := cdsVenda.RecNo;
  Try
    cdsVenda.First;
    While Not cdsVenda.Eof Do
    Begin
      If (Not Result) And
         (((blnProAtv) <> (cdsVenda.FieldByName('ITE_PROMOC').AsString = 'S'))) Then
      Begin
        Result := True;

        If (Not blnDel) Then
          Break;
      End;

      fltQtdIte := fltQtdIte + cdsVenda.FieldByName('ITE_QTDITE').AsFloat;
      fltQtdTotIte := fltQtdTotIte + cdsVenda.FieldByName('ITE_QTDITE').AsFloat;

      cdsVenda.Next;
    End;

    Result := True;
  Finally
    cdsVenda.RecNo := intRecNo;
  End;
End;

procedure TGerarVendaPerdida.pProcessaQtdColetiva(strCodIte, strRshDel, strCodigoUnidadeMedida, strCodPro, strRshAut: string;
  blnDel: Boolean; fltQtdLim, fltQtdMin: Double);
Begin
  If (Not fEmptyStr(strCodIte)) And (blnDel) Then
  Begin
    TProQtdColetiva.strRshTinAtual := strRshDel;
    TProQtdColetiva.pAddOrUpdateItem(strCodIte, strCodigoUnidadeMedida, strCodPro, 0, fltQtdLim, fltQtdMin);
    TProQtdColetiva.strRshTinAtual := strRshAut;
  End;
End;

function TGerarVendaPerdida.fRecalculaItensPromocaoColetiva(strCodIte, strCodigoUnidadeMedida, strPromoc: String;
  Var strCodPro: String; blnDel: Boolean = False; strRshDel: String=''; strRshAut: String=''): Boolean;
Var
  blnProAtv : Boolean;
  strFilter : String;
  blnFiltered : Boolean;
  fltQtdTotIte : Double;
  fltQtdIte : Double;
  intRecNo : Integer;
  prcScroll: TprcScroll;
  intCnt : Integer;
  fltQtdLim : Double;
  fltQtdMin : Double;
  stlCodIteRep : TStringList;
  blnCodIteRep : Boolean;
  strCodIteAux: String;
  blnPromocaoAtiva: Boolean;
begin
  Result := False;

  TProQtdColetiva.pLimpar;

  If fTemPromocaoColetiva Then
  Begin
    strCodPro := TProQtdColetiva.fGetCodPro(strCodIte);

    blnProAtv := TProQtdColetiva.fAtivaPromocao(strCodPro, strCodIte, strCodigoUnidadeMedida);
    TProQtdColetiva.pSetQtdLimMin(strCodPro, fltQtdLim, fltQtdMin);

    If (fEmptyStr(strCodPro)) And (IfEmptyStr(strPromoc, 'N') = 'N') Then
      Exit;

    strFilter := cdsVenda.Filter;
    blnFiltered := cdsVenda.Filtered;
    intRecNo := cdsVenda.RecNo;
    stlCodIteRep := TStringList.Create;

    pDisableControls(cdsVenda, prcScroll);
    Try
      fltQtdTotIte := 0;

      pProcessaQtdColetiva(strCodIte, strRshDel, strCodigoUnidadeMedida, strCodPro, strRshAut,
        blnDel, fltQtdLim, fltQtdMin) ;

      For intCnt := Low(TProQtdColetiva.ArrItemPro) To High(TProQtdColetiva.ArrItemPro) Do
      Begin
        If (Result) And (Not blnDel) Then
          Break;

        If (Not fEmptyStr(strCodPro)) And
           (TProQtdColetiva.fGetCodPro(TProQtdColetiva.ArrItemPro[intCnt].strCodIte) <> strCodPro) Then
        Begin
          Continue;
        End;

        blnCodIteRep := TProQtdColetiva.fCodIteRepetido(TProQtdColetiva.ArrItemPro[intCnt].strCodPro, TProQtdColetiva.ArrItemPro[intCnt].strCodIte, TProQtdColetiva.ArrItemPro[intCnt].strCodUnidade);
        strCodIteAux := TProQtdColetiva.ArrItemPro[intCnt].strCodPro + TProQtdColetiva.ArrItemPro[intCnt].strCodIte + TProQtdColetiva.ArrItemPro[intCnt].strCodUnidade;

        If (blnCodIteRep) And (stlCodIteRep.IndexOf(strCodIteAux) <> -1) Then
          Continue;

        cdsVenda.Filtered := False;
        cdsVenda.Filter := 'ITE_CODITE = ' + QuotedStr( TProQtdColetiva.ArrItemPro[intCnt].strCodIte );
        cdsVenda.Filtered := True;

        Result := fCalcularQtdIte(fltQtdIte, fltQtdTotIte, blnDel, blnProAtv);

        If (blnCodIteRep) Then
        Begin
          stlCodIteRep.Add(strCodIteAux);
        End
        Else
        If (Not fEmptyStr(strCodIte)) And (blnDel) And (strCodIte = cdsVenda.FieldByName('ITE_CODITE').AsString) Then
        Begin
          TProQtdColetiva.pAddOrUpdateItem(strCodIte, strCodigoUnidadeMedida, strCodPro, fltQtdIte, fltQtdLim, fltQtdMin);
        End;

      End;

      If (Not Result) Then
      Begin
        blnPromocaoAtiva := TProQtdColetiva.fAtivaPromocao(strCodPro, strCodIte, strCodigoUnidadeMedida, fltQtdTotIte);
        Result := IIF((blnProAtv <> blnPromocaoAtiva) Or ((blnProAtv = blnPromocaoAtiva) And (Not blnDel) And (fEhPromocaoTabloid(strCodPro))), True, Result);
      End;

    Finally
      cdsVenda.Filter := strFilter;
      cdsVenda.Filtered := blnFiltered;
      cdsVenda.RecNo := intRecNo;

      FreeAndNil(stlCodIteRep);
      pEnableControls(cdsVenda, prcScroll, True);
    End;
  End;

end;

function TGerarVendaPerdida.fTabelaPrecoClienteOuVendedor: String;
begin
  Result := fCampoTabela('CLI_TABPRE', 'CADCLI', ['CLI_CODCLI'], [FObjfatVenda.strCodCli], False);
  If fEmptyStr(Result) And fCfgSis('HIETAB', VarBoolean) Then
    Result := fCampoTabela('OPE_TABPRE', 'CADOPE', ['OPE_CODOPE'], [FObjfatVenda.strCodVen], False);
end;

function TGerarVendaPerdida.fRetEmpresaItem: String;
Begin
  Result := IIF(FObjfatVenda.blnEmpFat, IIF(fEmptyStr(cdsVenda.FieldByName('ITE_EMPITE').AsString),
    VS_strCodEmp, cdsVenda.FieldByName('ITE_EMPITE').AsString), VS_strCodEmp);
End;

function TGerarVendaPerdida.fUnitariosDiferentes(fltUnitar: Double): Boolean;
begin
  Result := (fFormataFloat(fltUnitar, 4) <> fFormataFloat(cdsVenda.FieldByName('ITE_UNITAR').AsFloat, 4));
end;

function TGerarVendaPerdida.fPodeAplicarDescontoCondicaoPagamento(fltUnitar: Double): Boolean;
begin
  Result := True;

  If FObjfatVenda.fItemPromocaoUsandoF3PuroComCondicaoNoFinal And fUnitariosDiferentes(fltUnitar) Then
  Begin
    Result := False;
  End;
end;

function TGerarVendaPerdida.fObtemStrTabela: String;
Begin
  If (FObjfatVenda.strIdePro = 'NOR') Then
  Begin
    If (fCfgSis('TABITE', varBoolean)) And (Not blnAltTabelaPreco) And (cdsVenda.FieldByName('ITE_TABPRE').AsString <> '') Then
      Result := cdsVenda.FieldByName('ITE_TABPRE').AsString
    Else
      Result := FObjfatVenda.strTabPre;
  End
  Else
  Begin
    If (fCfgSis('PRTTIN') = 'S') Then
    Begin
      If (fCfgSis('TABITE', varBoolean)) And (Not blnAltTabelaPreco) And (cdsVenda.FieldByName('ITE_TABPRE').AsString <> '') Then
        Result := cdsVenda.FieldByName('ITE_TABPRE').AsString
      Else
        Result := FObjfatVenda.strTabPre;
    End
    Else If fEmptyStr(FObjfatVenda.strTabTin) And fEmptyStr(fTabelaPrecoClienteOuVendedor) Then
    Begin
      Result := FObjfatVenda.strTabPre;
    End
    Else
    Begin
      Result := IIF( fEmptyStr(FObjfatVenda.strTabTin), fTabelaPrecoClienteOuVendedor, FObjfatVenda.strTabTin);
    End;
  End;

  If ((FObjfatVenda.strIdePro <> 'NOR') Or Not fEmptyStr(cdsVenda.FieldByName('ITE_CODACA').AsString)) And
     (fCfgSis('PREGER') = '1') And
     (fCfgSis('PRTTIN') = 'N') Then
  Begin
    Result := fCfgSis('TABPRE');
  End;

End;

function TGerarVendaPerdida.fCalculaUniTar(blnItemEspecial: Boolean; strTabela: String; var fltDescontoCndDestacado: Double): Double;
var
  fltUnitar,
  fltUniLot: Double;
  blnAplicarTaxaJuros : Boolean;
Begin
  fltUnitar := IIF(blnApenasVerificaSeItensTeraoModicacaoAposCondicaoPagamento, 0.00, fltUnitar);

  If (FObjfatVenda.stlItensNaoTemLote.IndexOf(cdsVenda.FieldByName('ITE_CODITE').AsString) = -1) And
     (Not FObjfatVenda.fEhEmissaoDocumentoWMS) And
     (Not FObjfatVenda.fEmpresaParaFaturamentoUsaWMS(cdsVenda.FieldByName('ITE_EMPITE').AsString)) And
     (FObjfatVenda.objCadLot.fExisteLote(cdsVenda.FieldByName('ITE_CODITE').AsString,
                                     IIF(FObjfatVenda.blnEmpFat,
                                     cdsVenda.FieldByName('ITE_EMPITE').AsString,
                                     VS_strCodEmp),
                                     cdsVenda.FieldByName('ITE_NUMLOT').AsString)) And

     FObjfatVenda.fCalculaPrecosLote(cdsVenda.FieldByName('ITE_QTDITE').AsFloat, fltUniLot, strTabela) Then
  Begin
    FObjfatVenda.fltUniVis := fltUniLot;
    fltUnitar := FObjfatVenda.fltUniVis;
    FObjfatVenda.fltTaxJur := 0.00;

    If FObjfatVenda.fAplicaTaxaJuros And fAplicarTaxaJurosPrecoSugestao Then
    Begin
      FObjfatVenda.fltTaxJur := FObjfatVenda.fGetTaxVprItem(cdsVenda.FieldByName('ITE_CODITE').AsString);
      fltUnitar := fltUnitar + fFormataFloat(fltUnitar * (FObjfatVenda.fGetTaxVprItem(cdsVenda.FieldByName('ITE_CODITE').AsString) / 100.0), 04);
    End;
  End

  Else If SameText(fCfgSis('SUGVLE'), '1') Then
    fltUnitar := FObjfatVenda.fPegaPrecoVenda(cdsVenda, cdsVenda.FieldByName('ITE_EMPITE').AsString, cdsVenda.FieldByName('ITE_ENTSAI').AsString,
                                              FObjfatVenda.fltMargem, blnItemEspecial,
                                              FObjfatVenda.strIdePro, strTabela, True, FObjfatVenda.FTaxJur, FObjfatVenda.FUniVis )
  Else
  Begin

    If (FObjfatVenda.stlItensNaoEhEstrutura.IndexOf(cdsVenda.FieldByName('ITE_CODITE').AsString) = -1) Then
    Begin
      blnAplicarTaxaJuros := FObjfatVenda.fAplicaTaxaJuros And fAplicarTaxaJurosPrecoSugestao;
      FObjfatVenda.fltUniVis := FObjfatVenda.fCalculaPrecoEstrutura( blnAplicarTaxaJuros,
                                                                     Preco_de_Venda,
                                                                     cdsVenda.FieldByName('ITE_CODITE').AsString,
                                                                     cdsVenda.FieldByName('ITE_EMPITE').AsString,
                                                                     cdsVenda.FieldByName('ITE_ENTSAI').AsString,
                                                                     strTabela,
                                                                     FObjfatVenda.fltMargem );
      fltUnitar := FObjfatVenda.fltUniVis;
      FObjfatVenda.fltTaxJur := 0.00;

      If blnAplicarTaxaJuros Then
      Begin
        FObjfatVenda.fltTaxJur := FObjfatVenda.fGetTaxVprItem(cdsVenda.FieldByName('ITE_CODITE').AsString);
        fltUnitar := fltUnitar + fFormataFloat(fltUnitar * (FObjfatVenda.fGetTaxVprItem(cdsVenda.FieldByName('ITE_CODITE').AsString) / 100.0), 04);
      End;
    End

    Else fltUnitar := FObjfatVenda.fPegaPrecoVenda( cdsVenda, cdsVenda.FieldByName('ITE_EMPITE').AsString, cdsVenda.FieldByName('ITE_ENTSAI').AsString,
                                                    FObjfatVenda.fltMargem, blnItemEspecial,
                                                    FObjfatVenda.strIdePro, strTabela, True,
                                                    FObjfatVenda.FTaxJur, FObjfatVenda.FUniVis );
  End;

  FObjfatVenda.pCalculaValorRT(fltUnitar, FObjfatVenda.FVal_RT);

  FObjfatVenda.fltUniOri := fltUnitar;

  If (FObjfatVenda.stlItensNaoTemQtdeEmbFec.IndexOf(cdsVenda.FieldByName('ITE_CODITE').AsString) = -1) And
     (fEhEmbalagemFechadaItem(cdsVenda.FieldByName('ITE_CODITE').AsString, strTabela, cdsVenda.FieldByName('ITE_QTDITE').AsFloat)) And
     (FObjfatVenda.strPromoc <> 'S') Then
  Begin
    fltUnitar := fltUnitar * ( 1 - ( fPercDescEmbalagemFechadaItem(cdsVenda.FieldByName('ITE_CODITE').AsString, strTabela, cdsVenda.FieldByName('ITE_QTDITE').AsFloat, '') / 100 ) );
  End;

  If Not fEmptyStr(cdsVenda.FieldByName('ITE_BAREMB').AsString) And fCfgSis('PRVEMB', VarBoolean) And (FObjfatVenda.strPromoc <> 'S') Then
  Begin
    If fRetornaPrecoCodBarraEmb( cdsVenda.FieldByName('ITE_CODITE').AsString,
                                 cdsVenda.FieldByName('ITE_BAREMB').AsString,
                                 VS_strCodEmp,
                                 strTabela,
                                 False) > 0 Then
    Begin
      fltUnitar := fRetornaPrecoCodBarraEmb( cdsVenda.FieldByName('ITE_CODITE').AsString,
                                             cdsVenda.FieldByName('ITE_BAREMB').AsString,
                                             VS_strCodEmp,
                                             strTabela,
                                             False);
      FObjfatVenda.fltUniOri := fltUnitar;
    End;
  End;

  fltDescontoCndDestacado := 0;

  fltUniTar := fCalcularUniTarDescontoDestacado(fltUniTar, fltDescontoCndDestacado);

  Result := IIF(fAplicarTaxaJurosPrecoDigitado, cdsVenda.FieldByName('ITE_UNIDIG').AsFloat, fltUnitar);
End;

function TGerarVendaPerdida.fCondicaoFaturamentoFinal: Boolean;
Begin
  Result := ((fCfgSis('CNDVEN') = 'I') Or (FObjfatVenda.fUsandoF3PuroComCondicaoNoFinal));
End;

function TGerarVendaPerdida.fCalcularUniTarDescontoDestacado(fltUniTar: Double; var fltDescontoCndDestacado: Double): Double;
var
  fltDesMax: Double;
Begin
  If (FObjfatVenda.strCAbDes = 'S') And
     fCondicaoFaturamentoFinal And
     ((FObjfatVenda.strPromoc <> 'S') Or (fPodeAplicarDescontoCondicaoPagamento(fltUnitar) And (FObjfatVenda.fRegraPrecoSugestaoAtiva = TRegraPrecoSugestao.PrecoDeTabela))) And
     (Not fAplicarTaxaJurosPrecoDigitado) Then
  Begin
    fltDesMax := FObjfatVenda.fRetornaDescLinGru(cdsVenda.FieldByName('ITE_CODITE').AsString, FObjfatVenda.strCodCnd);

    If fCfgSis('DESCND',varBoolean) Then
    Begin
      If fCampoTabela('ITE_DESCND','CADITE', ['ITE_CODITE'], [cdsVenda.FieldByName('ITE_CODITE').AsString]) = 'S' Then
      Begin
        fltUnitar               := FObjfatVenda.fltUniOri;
        fltDescontoCndDestacado := fltDesMax;
      End
      Else
        fltUnitar := FObjfatVenda.fltUniOri;
    End

    Else If (FObjfatVenda.strCodFpg = '007') And (FObjfatVenda.strAbDeCc = 'S') Then
    Begin
      fltUnitar :=  fltUnitar - FObjfatVenda.fRetornaVrDesconto(2, fltUnitar, fltDesMax);
    End

    Else
      fltUnitar :=  fltUnitar - FObjfatVenda.fRetornaVrDesconto(2, fltUnitar, fltDesMax);
  End;

  Result := fltUnitar;
End;

function TGerarVendaPerdida.fItensEntraramOuSairamDePromocao(fltUnitar: Double): Boolean;
Begin
  Result := False;
  If (blnApenasVerificaSeItensTeraoModicacaoAposCondicaoPagamento) Then
  Begin
    If fCfgSis('PROCXA', VarBoolean) Then
    Begin
      If (fCfgSis('RECCND', varBoolean)) Or (fCfgSis('RECPRO', varBoolean)) Then
      Begin
        If (Not blnItensEntraramOuSairamDePromocao) Then
        Begin
          If (fCfgSis('PRMF11', varInteger) = 1) Then
          Begin
            //PRMF11 = 1 - Preço Promoção
            Result := (FObjfatVenda.strPromoc <> cdsVenda.FieldByName('ITE_PROMOC').AsString);
          End
          Else
          Begin
            //PRMF11 = 2 - Preço Tabela
            If FObjfatVenda.strPromoc = 'S' Then
            Begin
              If (fCfgSis('RECCND', varBoolean)) And (fltUnitar > 0.00) Then
                Result := (fUnitariosDiferentes(fltUnitar));
            End;
          End;
        End;
      End;
    End;
  End;
End;

procedure TGerarVendaPerdida.pAjustarListas;
Begin
  If (FObjfatVenda.stlItensNaoTemQtdeEmbFec.IndexOf(cdsVenda.FieldByName('ITE_CODITE').AsString) = -1) And
     (Not fTemQuantEmbalagemFechada(cdsVenda.FieldByName('ITE_CODITE').AsString)) Then
  Begin
    FObjfatVenda.stlItensNaoTemQtdeEmbFec.Add(cdsVenda.FieldByName('ITE_CODITE').AsString);
  End;

  If (FObjfatVenda.stlItensNaoEhEstrutura.IndexOf(cdsVenda.FieldByName('ITE_CODITE').AsString) = -1) And
     (Not fItemEstrutura(cdsVenda.FieldByName('ITE_CODITE').AsString)) Then
  Begin
    FObjfatVenda.stlItensNaoEhEstrutura.Add(cdsVenda.FieldByName('ITE_CODITE').AsString);
  End;

  If (FObjfatVenda.stlItensNaoTemLote.IndexOf(cdsVenda.FieldByName('ITE_CODITE').AsString) = -1) And
     (FObjfatVenda.objCadLot.fItemSemNenhumLote(cdsVenda.FieldByName('ITE_CODITE').AsString)) Then
  Begin
    FObjfatVenda.stlItensNaoTemLote.Add(cdsVenda.FieldByName('ITE_CODITE').AsString);
  End;
End;

procedure TGerarVendaPerdida.pAlterarTabela(strTabela: String);
var
  blnAlterar: Boolean;
Begin
  blnAlterar := blnAltTabelaPreco Or ((FObjfatVenda.strIdePro <> 'NOR') And
               (cdsVenda.FieldByName('ITE_TABPRE').AsString <> strTabela) And
               (fCfgSis('PRTTIN') = 'N')) And
               (Not blnApenasVerificaSeItensTeraoModicacaoAposCondicaoPagamento);

  If blnAlterar Then
  Begin
    cdsVenda.Edit;
    cdsVenda.FieldByName('ITE_TABPRE').AsString := strTabela;
    cdsVenda.Post;
  End;
End;

procedure TGerarVendaPerdida.pRecalcularTotIte(fltUnitar, fltUniDol, fltDescontoCndDestacado: Double);
Begin
  If blnRecalcularSomentePrecosComCotacaoDolar Then
  Begin
    cdsVenda.FieldByName('ITE_DESCON').AsFloat  := 0.0;
    cdsVenda.FieldByName('ITE_UNIDIG').AsFloat  := fFormataFloat(fltUniDol * FObjfatVenda.fltVlCtVn, FObjfatVenda.VS_intDecUni);
    cdsVenda.FieldByName('ITE_UNITAR').AsFloat  := fFormataFloat(fltUniDol * FObjfatVenda.fltVlCtVn, FObjfatVenda.VS_intDecUni);
    cdsVenda.FieldByName('ITE_TOTITE').AsFloat  := fFormataFloat(cdsVenda.FieldByName('ITE_UNITAR').AsFloat * cdsVenda.FieldByName('ITE_QTDITE').AsInteger, 2);
  End
  Else
  Begin
    cdsVenda.FieldByName('ITE_UNIDIG').AsFloat := fFormataFloat(fltUnitar, fCfgSis('DECUNI', varInteger));

    If FObjfatVenda.fAplicaTaxaJuros And fAplicarTaxaJurosPrecoDigitado Then
    Begin
      FObjfatVenda.fltTaxJur := FObjfatVenda.fGetTaxVprItem(cdsVenda.FieldByName('ITE_CODITE').AsString);

      fltUnitar := fltUnitar + (fltUnitar * FObjfatVenda.fltTaxJur / 100.0);

      cdsVenda.FieldByName('ITE_TAXJUR').AsFloat := FObjfatVenda.fltTaxJur;
    End;

    If (fCfgSis('DESCND',varBoolean)) And
       (fCampoTabela('ITE_DESCND','CADITE', ['ITE_CODITE'], [cdsVenda.FieldByName('ITE_CODITE').AsString]) = 'S') Then
    Begin
      fltUnitar := fltUnitar - FObjfatVenda.fRetornaVrDesconto(2, fltUnitar, fltDescontoCndDestacado);
      cdsVenda.FieldByName('ITE_DESCON').AsFloat := fltDescontoCndDestacado;
    End
    Else
    begin
      fltUnitar := fltUnitar - FObjfatVenda.fRetornaVrDesconto(2, fltUnitar, cdsVenda.FieldByName('ITE_DESCON').AsFloat)
    End;

    cdsVenda.FieldByName('ITE_UNITAR').AsFloat := fltUnitar;

    cdsVenda.FieldByName('ITE_TOTITE').AsFloat := fFormataFloat(cdsVenda.FieldByName('ITE_QTDITE').AsFloat * fltUnitar, 02);
  End;
End;

procedure TGerarVendaPerdida.pAjustaPrecoPromocao(const strTabela: String);
var
  fltQtdDis: Double;
  blnParticiona: Boolean;
  blnPromo: Boolean;
Begin
  FObjfatVenda.strPromoc := 'N';
  If (Not FObjfatVenda.blnCliFil) And (FObjfatVenda.strIdePro = 'NOR') And
     (FObjfatVenda.fItemPassivelDeVerificacaoPromo(cdsVenda.FieldByName('ITE_CODITE').AsString, fRetEmpresaItem)) Then
  Begin
    If fRetornaPrecosPromocao(cdsVenda.FieldByName('ITE_CODITE').AsString,  //aqui promoc
                              FObjfatVenda.strCodCli,
                              VS_Date,
                              cdsVenda.FieldByName('ITE_QTDITE').AsFloat,

                              FObjfatVenda.fRetQtdDigitada(cdsVenda.FieldByName('ITE_CODITE').AsString,
                                                       '',
                                                       cdsVenda.FieldByName('AUTOINCREM').AsString,
                                                       '',
                                                       '',
                                                       cdsVenda.FieldByName('ITE_EMPITE').AsString,
                                                       False),

                              FObjfatVenda.fRetQtdDigitada(cdsVenda.FieldByName('ITE_CODITE').AsString,
                                                       '',
                                                       cdsVenda.FieldByName('AUTOINCREM').AsString,
                                                       '',
                                                       '',
                                                       cdsVenda.FieldByName('ITE_EMPITE').AsString,
                                                       False,
                                                       False,
                                                       FObjfatVenda.fDesconsiderarNaQtdLimDaPromoItensUnitarMaior,
                                                       True {Somente em promocao}),

                              FObjfatVenda.intPrzMed,
                              FObjfatVenda.fltProPreCus,
                              FObjfatVenda.fltProPreVen,
                              FObjfatVenda.fltProComVar,
                              FObjfatVenda.fltProComAta,
                              FObjfatVenda.fltProComDis,
                              fltQtdDis,
                              FObjfatVenda.fltProDesF07,
                              FObjfatVenda.strComPro,
                              FObjfatVenda.strCodPro,
                              blnParticiona,
                              blnPromo,
                              strTabela,
                              FObjfatVenda.strCodCnd,
                              '',
                              '',
                              True,
                              False,
                              '-1',
                              ((cdsVenda.FieldByName('ITE_ENTRET').AsString = 'E') And (cdsVenda.FieldByName('ITE_ENTFUT').AsString = 'N')),
                              ((cdsVenda.FieldByName('ITE_ENTRET').AsString = 'E') And (cdsVenda.FieldByName('ITE_ENTFUT').AsString = 'S')),
                              cdsVenda.FieldByName('ITE_MOTFUT').AsString,
                              fRetEmpresaItem,
                              FObjfatVenda.strNumOrc,
                              FObjfatVenda.strEspOrc) Then
    Begin
      FObjfatVenda.strPromoc := IIF(Not blnParticiona, 'S', FObjfatVenda.strPromoc);
    End;
  End;
End;

function TGerarVendaPerdida.fRecalculaPrecosInterna(
  pgbStatus: TcxProgressBar): Boolean;
Var
  fltUniDol,
  fltUnitar,
  fltComTbl,
  fltDescontoCndDestacado: Double;
  strTabela: String;
  blnItemEspecial: Boolean;
  prcScroll: TprcScroll;
begin
  Try
    pDisableControls(cdsVenda, prcScroll);

    FObjfatVenda.intPrzMed := fFloatToInt(fCalcMediaPagto(FObjfatVenda.strConPag));

    FObjfatVenda.strTabPre := IIF(fEmptyStr(FObjfatVenda.strTabPre), '1', FObjfatVenda.strTabPre);

    cdsVenda.First;

    While Not cdsVenda.Eof Do
    Begin
      FObjfatVenda.strIdePro := cdsVenda.FieldByName('ITE_IDEPRO').AsString;

      blnItemEspecial := (Pos('ITEM ESPECIAL', cdsVenda.FieldByName('ITE_DESORI').AsString) > 0);

      FObjfatVenda.fltPreVe1 := cdsVenda.FieldByName('ITE_PREVE1').AsFloat;
      FObjfatVenda.fltPreVe2 := cdsVenda.FieldByName('ITE_PREVE2').AsFloat;
      FObjfatVenda.fltPreVe3 := cdsVenda.FieldByName('ITE_PREVE3').AsFloat;
      FObjfatVenda.fltPreVe4 := cdsVenda.FieldByName('ITE_PREVE4').AsFloat;
      FObjfatVenda.fltPreVe5 := cdsVenda.FieldByName('ITE_PREVE5').AsFloat;
      FObjfatVenda.fltPreVe6 := cdsVenda.FieldByName('ITE_PREVE6').AsFloat;
      FObjfatVenda.fltPreVe7 := cdsVenda.FieldByName('ITE_PREVE7').AsFloat;
      FObjfatVenda.fltPreLot := cdsVenda.FieldByName('ITE_PRELOT').AsFloat;

      strTabela := fObtemStrTabela;

      pAjustarListas;

      pAjustaPrecoPromocao(strTabela);

      fltUniDol := 0.0;

      If blnRecalcularSomentePrecosComCotacaoDolar Then
      Begin
        If Not fItemUtilizaPrecoEmDolar(cdsVenda.FieldByName('ITE_CODITE').AsString) Then
        Begin
          cdsVenda.Next;
          Continue;
        End;

        If fFormataFloat(FObjfatVenda.fltVlCtVn, 6) <= 0 Then
        Begin
          cdsVenda.Next;
          Continue;
        End;

        fltUniDol := cdsVenda.FieldByName('ITE_UNIDOL').AsFloat;

        If fFormataFloat(fltUniDol, 6) <= 0 Then
        Begin
          cdsVenda.Next;
          Continue;
        End;
      End;

      fltComTbl := IIF(strTabela = cdsVenda.FieldByName('ITE_TABPRE').AsString,
                       cdsVenda.FieldByName('ITE_COMTBL').AsFloat,
                       fCampoTabela('ITE_COMTB' + strTabela,
                                    'ITEGER',
                                   ['ITE_CODITE', 'ITE_CODEMP'],
                                   [cdsVenda.FieldByName('ITE_CODITE').AsString, VS_StrCodEmp]));

      fltUnitar := fCalculaUniTar(blnItemEspecial, strTabela, fltDescontoCndDestacado);

      pAlterarTabela(strTabela);

      If (Not blnRecalcularSomentePrecosComCotacaoDolar) And
         (blnVerUniOriginal) And
         (fFormataFloat(fltUnitar, 2) = fFormataFloat(cdsVenda.FieldByName('ITE_UNIORI').AsFloat, 2)) Then
      Begin
        cdsVenda.Next;
        Continue;
      End;

      If (Not blnRecalcularSomentePrecosComCotacaoDolar) And
         (IIF(blnModuloAltCondPagtoPedido, Not Self.blnAtualizaTabPreCnd, True)) And
         ((FObjfatVenda.strPromoc = 'N') And (fConfiguradoParaRecalcularSomenteItensEmPromocao)) Then
      Begin
        cdsVenda.Next;
        Continue;
      End;

      blnItensEntraramOuSairamDePromocao := fItensEntraramOuSairamDePromocao(fltUnitar);
      If (blnApenasVerificaSeItensTeraoModicacaoAposCondicaoPagamento) Then
      Begin
        blnItensTiveramUnitarModificados := IIF(fCfgSis('CNDCXA', VarBoolean) And
                                                (fCfgSis('RECCND', varBoolean)) And
                                                (fltUnitar > 0.00) And
                                                (Not blnItensTiveramUnitarModificados),
                                                (fUnitariosDiferentes(fltUnitar)),
                                                blnItensTiveramUnitarModificados);

        cdsVenda.Next;
        Continue;
      End;

      cdsVenda.Edit;
      cdsVenda.FieldByName('ITE_COMTBL').AsFloat := fltComTbl;
      cdsVenda.FieldByName('ITE_TAXJUR').AsFloat := FObjfatVenda.fltTaxJur;
      cdsVenda.FieldByName('ITE_UNIVIS').AsFloat := FObjfatVenda.fltUniVis;
      cdsVenda.FieldByName('ITE_UNIORI').AsFloat := FObjfatVenda.fltUniOri;
      cdsVenda.FieldByName('ITE_VAL_RT').AsFloat := FObjfatVenda.fltVal_RT;

      pRecalcularTotIte(fltUnitar, fltUniDol, fltDescontoCndDestacado);

      cdsVenda.FieldByName('ITE_PRVTIN').AsFloat := IIF( (FObjfatVenda.strIdePro <> 'NOR'), fltUnitar, cdsVenda.FieldByName('ITE_PRVTIN').AsFloat);

      FObjfatVenda.pCarregaValoresCusto(cdsVenda.FieldByName('ITE_CODITE').AsString, FObjfatVenda.fGetEmpCalculoItem(fRetEmpresaItem), FObjfatVenda.strTabPre);

      cdsVenda.FieldByName('ITE_MARLUC').AsFloat := fCalculaPrecoVenda(2, FObjfatVenda.fRetPreCus(cdsVenda.FieldByName('ITE_PRECUS').AsFloat) + FObjfatVenda.fRetOutVal(cdsVenda.FieldByName('ITE_OUTVAL').AsFloat),
                                                                 fltUnitar,
                                                                 0,
                                                                 FObjfatVenda.fRetIcmSai(cdsVenda.FieldByName('ITE_ICMSAI').AsFloat),
                                                                 FObjfatVenda.fRetImpFed(cdsVenda.FieldByName('ITE_IMPFED').AsFloat),
                                                                 FObjfatVenda.fRetDesOpe(cdsVenda.FieldByName('ITE_DESOPE').AsFloat),
                                                                 fltComTbl, FObjfatVenda.VS_strMARMKP); //(%) COMISSAO DA TABELA DE PRECO DO ITEM

      cdsVenda.FieldByName('FLG_STATUS').AsString:= FObjfatVenda.strStatus;
      cdsVenda.FieldByName('ITE_PROMOC').AsString:= FObjfatVenda.strPromoc;
      cdsVenda.FieldByName('ITE_CODPRO').AsString:= FObjfatVenda.strCodPro;

      cdsVenda.FieldByName('ITE_VARTAB').AsFloat := IIF( cdsVenda.FieldByName('ITE_UNIORI').AsFloat <> 0,
                                                         ( ( cdsVenda.FieldByName('ITE_UNITAR').AsFloat /
                                                         cdsVenda.FieldByName('ITE_UNIORI').AsFloat ) - 1 ) * 100,
                                                         cdsVenda.FieldByName('ITE_VARTAB').AsFloat);

      cdsVenda.Post;
      cdsVenda.Next;
    End;

    FObjfatVenda.fltPreVe1 := 0.0;
    FObjfatVenda.fltPreVe2 := 0.0;
    FObjfatVenda.fltPreVe3 := 0.0;
    FObjfatVenda.fltPreVe4 := 0.0;
    FObjfatVenda.fltPreVe5 := 0.0;
    FObjfatVenda.fltPreVe6 := 0.0;
    FObjfatVenda.fltPreVe7 := 0.0;
    FObjfatVenda.fltPreLot := 0.0;

    Result := True;
  Finally
    pEnableControls(cdsVenda, prcScroll);
  End;
end;

procedure TGerarVendaPerdida.pRecalculaPrecos(blnVerUniOri, blnAltTab,
  blnAplicaDescProfiss, blnRecalculaTabelaTintas: Boolean;
  strPromocaoColetiva: String; blnSomentePromocao, blnSomenteSaidaPromocao,
  blnSomenteEntradaPromocao, blnManterPrecoDigitado, blnZerarDescontoDoItem,
  blnSomentePrecosComCotacaoDolar, blnRecalculoParaTrava: Boolean;
  intSeqItemEstrutura: Integer; blnSomenteItensTinta: Boolean);
Var
  intRecNo : Integer;
  strRshTinAtualAux: String;
begin
  If (Pos(FObjFatVenda.strOpcDoc, 'CF_CI_CN_CT_CO_MF_DV_PR_DD_') > 0) Or
     (FObjFatVenda.blnComVal) Then
    Exit;

  If cdsVenda.IsEmpty Then
    Exit;

  intRecNo := 0;

  strRshTinAtualAux := TProQtdColetiva.strRshTinAtual;
  Try
    cdsVenda.DisableControls;
    intRecNo := cdsVenda.RecNo;
    FObjFatVenda.pgbProgresso := nil;

    Self.blnVerUniOriRecalculoPrecos   := blnVerUniOri;
    Self.blnAltTabRecalculoPrecos      := blnAltTab;
    Self.blnDescProfissRecalculoPrecos := blnAplicaDescProfiss;
    Self.blnZerarDescontoDoItemRecalculoPrecos := blnZerarDescontoDoItem;
    Self.blnRecalcularSomentePrecosComCotacaoDolar := blnSomentePrecosComCotacaoDolar;
    Self.blnRecalculaTabelaTintasPrecos:= blnRecalculaTabelaTintas;
    Self.blnRecalcularSomenteItensTinta:= blnSomenteItensTinta;
    Self.blnManterPrecoDigitado        := blnManterPrecoDigitado;
    Self.strCodigoPromocaoColetiva     := strPromocaoColetiva;
    Self.blnRecalculaSomenteItensQueEntraramOuSairamDePromocao := blnSomentePromocao;
    Self.blnRecalculaSomenteItensQueSairamDePromocao := blnSomenteSaidaPromocao;
    Self.blnRecalculaSomenteItensQueEntraramEmPromocao := blnSomenteEntradaPromocao;
    Self.intSeqItemEstruturaRecalcular := intSeqItemEstrutura;
    Self.blnRecalculoParaTrava := blnRecalculoParaTrava;

    fChamaTelaGravando(fRecalculaPrecosInterna);

  Finally
    TProQtdColetiva.strRshTinAtual := strRshTinAtualAux;

    If (intRecNo <= cdsVenda.RecordCount) Then
      cdsVenda.RecNo := intRecNo
    Else
      cdsVenda.Last;

    cdsVenda.EnableControls;
  End;
end;

procedure TGerarVendaPerdida.pCalcularValFre;
Begin
  If (FObjfatVenda.blnEhTelaAltItensPed) Then
  Begin
    FObjfatVenda.fltValFre := FObjfatVenda.fRetornaTotFreProporcionalConformeOriginal;
  End;

  If fRateiaFreteItensTransportadora(FObjfatVenda.strCodTra, FObjfatVenda.strTipFre) And (FObjfatVenda.fltValFre > 0) Then
  Begin
    FObjfatVenda.fltFreRat := FObjfatVenda.fltValFre;
    FObjfatVenda.fltValFre := 0.00;
    FObjfatVenda.fltFreDig := 0.00;
  End;

  If (Not FObjfatVenda.fHaveraDesmembramentoVenda(FObjfatVenda.arrMatItens)) And
     (FObjfatVenda.strEspDoc = 'IF') And fCfgSis('FRECUP', VarBoolean) Then
  Begin
    FObjfatVenda.pInsereItemFreteNoCupomFiscal;
  End;

  FObjfatVenda.pAplicarFreteComoAcrescimoNFCe;

  If fRateiaFreteItensTransportadora(FObjfatVenda.strCodTra, FObjfatVenda.strTipFre) And (FObjfatVenda.fltValFre > 0) Then
  Begin
    FObjfatVenda.fltFreRat := FObjfatVenda.fltValFre;
    FObjfatVenda.fltValFre := 0.00;
    FObjfatVenda.fltFreDig := 0.00;
  End;
End;

procedure TGerarVendaPerdida.pCalcularVolume;
Begin
  If  fCfgSis('CALVOL', varBoolean) And (Floor(FObjfatVenda.fRetVolumes) <> FObjfatVenda.intQtdTra) Then
  Begin
    FObjfatVenda.intQtdTra := Floor(FObjfatVenda.fRetVolumes);
  End;
End;

procedure TGerarVendaPerdida.pCalcularTxEntrega;
Begin
  If (Pos(FObjfatVenda.strOpcDoc, 'PD_OR_VN_CP_') > 0) And (fCfgSis('TAXENT', varBoolean)) Then
  Begin
    FObjfatVenda.blnAplicaTaxaEntrega := True;
    FObjfatVenda.pAtualizaValorTaxaEntrega;
  End;
End;

procedure TGerarVendaPerdida.pCalculaTotGer;
Begin
  If (FObjfatVenda.blnCondicaoEspecial) And (FObjfatVenda.blnCndEsp) And blnZerarDescontoDoItemRecalculoPrecos Then
  Begin
    FObjfatVenda.pSetBackupVar(VARIAVEIS_ZERA_PERCENTUAIS_DESCONTO_TRUE);
    FObjfatVenda.pCalculaTotGer(blnZerarDescontoDoItemRecalculoPrecos, False, pOnProcessaItem);
    FObjfatVenda.pGetBackupVar(VARIAVEIS_ZERA_PERCENTUAIS_DESCONTO_TRUE);
  End
  Else
    FObjfatVenda.pCalculaTotGer(False, False, pOnProcessaItem);
End;

procedure TGerarVendaPerdida.pCalculaTotCadRec;
Begin
  If (FObjfatVenda.fltValAdt > 0) And
     (FObjfatVenda.blnEhTelaAltItensPed) Then
  Begin
    FObjfatVenda.fltTotCadRec := FObjfatVenda.fltTotCadRec - fFormataFloat(FObjfatVenda.fRetornaTotFreJaBaixado -
                                                                   FObjfatVenda.fRetornaDesEspJaBaixado, 2);
  End;
End;

procedure TGerarVendaPerdida.pCalculaTxVpr;
Begin
  If FObjfatVenda.blnTaxVpr Then
    FObjfatVenda.pCalculaTaxVpr;
End;

function TGerarVendaPerdida.fCalculaTotalPedidoInterna(
  pgbStatus: TcxProgressBar): Boolean;
Var
  arrDatas: TDateArray;
  blnMostraDigDuplic: Boolean;
begin
  Result := True;

  If FblnRecalculaPrecos Then
  Begin
    FObjfatVenda.pCalculaTaxVpr;

    If blnApenasVerificaSeItensTeraoModicacaoAposCondicaoPagamento Then
      Exit;
  End;

  strInfoProcessamento := 'Aguarde, Inserindo produto %s...';

  FObjfatVenda.pPreencheMatrizFechamento('', pOnProcessaItem);

  FObjfatVenda.blnDeCndF := (fCfgSis('CNDVEN') = 'F');

  pCalcularValFre;

  pCalculaTxVpr;

  pCalcularTxEntrega;

  FObjfatVenda.pCalculaPesBruLiq;

  pCalcularVolume;

  strInfoProcessamento := 'Aguarde, Calculando valor do produto %s...';

  pCalculaTotGer;

  If FObjfatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial And (FObjfatVenda.fltDesEsp <= 0.00) And (FObjfatVenda.fltIcmOrg > 0) Then
    FObjfatVenda.fltDesEsp := FObjfatVenda.fltIcmOrg;

  FObjfatVenda.pDestacaRetencoes;
  FObjfatVenda.pRetemImpostosNoDescontoEspecial;

  If (FObjfatVenda.blnCondicaoEspecial) And (FObjfatVenda.blnCndEsp) And blnZerarDescontoDoItemRecalculoPrecos Then
  Begin
    FObjfatVenda.pSetBackupVar(VARIAVEIS_ZERA_PERCENTUAIS_DESCONTO_TRUE);
    FObjfatVenda.pCalculaTotGer(blnZerarDescontoDoItemRecalculoPrecos, True, pOnProcessaItem);
    FObjfatVenda.pGetBackupVar(VARIAVEIS_ZERA_PERCENTUAIS_DESCONTO_TRUE);
  End
  Else
    FObjfatVenda.pCalculaTotGer(False, True, pOnProcessaItem);

  FObjfatVenda.strDesCla := fRetDesCla(FObjfatVenda.strClaFis);

  FObjfatVenda.pCalculaTotalParaCadRec;

  pCalculaTotCadRec;

  FObjfatVenda.pRateiaValores;

  blnMostraDigDuplic := False;

  FObjfatVenda.fDigitaDuplicata(blnMostraDigDuplic,
                                arrDatas, FObjfatVenda.dtaPreVis,
                                True, FObjfatVenda.arrDuplicCop);

  If FObjfatVenda.fltValAdt > 0 Then
  Begin
    Result := Result And FObjfatVenda.fAdicionaAdiantamentoPrimeiraParcela;
  End;

end;

function TGerarVendaPerdida.fCarregarBrindesPromocaoCompostaPorKit: Boolean;
var
  LstlKitsAtivos   : TStringList;
  LstlKitsInativos : TStringList;
Begin
  Result := False;

  If Not fCfgSis('PROKIT', varBoolean) Then
    Exit;

  Try
    LstlKitsAtivos   := TStringList.Create;
    LstlKitsInativos := TStringList.Create;
    Try
      CdsVenda.DisableControls;

      TProQtdColetiva.cdsDadosPromocaoKit := Nil;
      FObjfatVenda.pCarregarDadosParaPromocaoPorKit;
      If (Assigned(FObjfatVenda.cdsDadosPromocaoKit) And (FObjfatVenda.cdsDadosPromocaoKit.RecordCount > 0))  Then
        TProQtdColetiva.cdsDadosPromocaoKit := FObjfatVenda.cdsDadosPromocaoKit;

      cdsVenda.First;
      While Not cdsVenda.Eof Do
      Begin
        If Not fEmptystr(cdsVenda.FieldByName('ITE_PROKIT').AsString) Then
        Begin
          If (TProQtdColetiva.fVerificarKitAtivo(cdsVenda.FieldByName('ITE_PROKIT').AsString)) Then
          Begin
            If LstlKitsAtivos.IndexOf(cdsVenda.FieldByName('ITE_PROKIT').AsString) = -1 Then
              LstlKitsAtivos.Add(cdsVenda.FieldByName('ITE_PROKIT').AsString);
          End
          Else
          begin
            If LstlKitsInativos.IndexOf(cdsVenda.FieldByName('ITE_PROKIT').AsString) = -1 Then
              LstlKitsInativos.Add(cdsVenda.FieldByName('ITE_PROKIT').AsString);
          end;
        End;
        cdsVenda.Next;
      End;

      If LstlKitsInativos.Count > 0 Then
        fRevisarBrindesPromocaoCompostaPorKit(LstlKitsInativos, False);

      CdsVenda.EnableControls;
    Finally
      FreeAndNil(LstlKitsAtivos);
      FreeAndNil(LstlKitsInativos);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fCarregarBrindesPromocaoCompostaPorKit]');
    End;
  End;
end;

function TGerarVendaPerdida.fRevisarBrindesPromocaoCompostaPorKit(AListKit: TStringList; AInserirBrinde: Boolean): Boolean;
var
  LstrKit   : String;
  LQueryKit : TUniQuery;
begin
  Result := True;
  Try
    cdsVenda.DisableControls;

    For LstrKit In AListKit Do
    Begin
      LQueryKit := TProQtdColetiva.fGetBrindesDoKit(LstrKit);
      Try
        If Not LQueryKit.IsEmpty Then
        Begin
          While not LQueryKit.Eof do
          Begin
            If cdsVenda.Locate('ITE_CODITE;ITE_BRINDE;ITE_PROKIT',
                                VarArrayOf([LQueryKit.FieldBYName('BRI_CODITE').AsString,
                                            'S',
                                            LQueryKit.FieldBYName('BRI_SEQKIT').AsString]), []) Then
            Begin
              If Not AInserirBrinde Then
                fDeletaItem(False,
                            FObjFatVenda.strNumDoc,
                            FObjFatVenda.strEspDoc,
                            FObjFatVenda.strEmpDoc
                            );

            End;

            LQueryKit.next;
          End;
        End;
      Finally
        FreeAndNil(LQueryKit);
      End;
    End;

    cdsVenda.EnableControls;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fRevisarBrindesPromocaoCompostaPorKit]');
    End;
  End;
end;

function TGerarVendaPerdida.fRealizarGravacao: Boolean;
begin
  pCriarFormularios(TfrmGravando, frmGravandoInterno);
  Try
    Try
      frmGravandoInterno.strChave := 'FATVENDAS';
      FObjfatVenda.strEmpLog := VS_strCodEmp;

      fCalculaTotalPedidoInterna(Nil);

      frmGravandoInterno.fExecutarAcao := FObjfatVenda.fGravaArquivosDesmembrandoVenda;
      frmGravandoInterno.ShowModal;
      Result := frmGravandoInterno.blnConfirma;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TGerarVendaPerdida.fRealizarGravacao]');
      End;
    End;
  Finally
    pFreeAndNil(frmGravandoInterno);
  End;
end;

function fPedidoGerouOrdProd(strNumPed, strCodEmp: String): Boolean;
var
  strMens : String;

begin
  Result := fPedidoGerouOrdProd(strNumPed, strCodEmp, strMens);
  if Result then
    fMensagem('', strMens, ['&O K'])
  else
   begin
     if strMens <> '' then
       fMensagem('', strMens, ['&O K']);
   end;
end;

function fPedidoGerouOrdProd(strNumPed, strCodEmp: String; var strMens: String): Boolean;
  Var
    strSql,
    strOrdPro     : String;
    qryGen        : TUniQuery;
    TamArrOrdPro,
    i             : integer;
    ArrOrdPro     : Array of String;
    OrdProBaix,
    ExcOrdPro,
    ExcTodOrdPro  : boolean;
Begin
  Result  := False;
  strMens := '';

  qryGen := fCriaQuery(Nil);

  strSql := '';
  strSql := strSql + ' SELECT                                  ';
  strSql := strSql + '   FDO_NUMDOC,                           ';
  strSql := strSql + '   FDO_ESPDOC,                           ';
  strSql := strSql + '   FDO_DTAENT,                           ';
  strSql := strSql + '   FDO_CODEMP,                           ';
  strSql := strSql + '   FDO_CODCLI,                           ';
  strSql := strSql + '   FDO_CODITE,                           ';
  strSql := strSql + '   FDO_DESCRI,                           ';
  strSql := strSql + '   FDO_QTDITE,                           ';
  strSql := strSql + '   FDO_ORDPRO,                           ';
  strSql := strSql + '   F.AUTOINCREM                          ';
  strSql := strSql + ' FROM FATDOR F,                          ';
  strSql := strSql + '   GERMAT                                ';
  strSql := strSql + ' WHERE FDO_CODITE = GMT_CODITE           ';
  strSql := strSql + '     AND FDO_JAFATU = 0                  ';
  strSql := strSql + '     AND FDO_ESPDOC = "PD"               ';
  strSql := strSql + '     AND FDO_NUMDOC = :NUMDOC            ';
  strSql := strSql + '     AND FDO_CODEMP = :CODEMP            ';
  strSql := strSql + '     AND FDO_ORDPRO IS NOT NULL          ';
  strSql := strSql + ' ORDER BY                                ';
  strSql := strSql + '   FDO_ORDPRO                            ';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('NUMDOC').AsString := strNumPed;
    ParamByName('CODEMP').AsString := strCodEmp;

    If Not fEmptyStr(ParamByName('NUMDOC').AsString) Then
    Begin

      Open;
      OrdProBaix := false;
      If Not IsEmpty Then
      Begin

        Result := True;

        First;

        If RecordCount = 1 Then
          strMens := 'O pedido ' + strNumPed + ' gerou a seguinte Ordem de Produção: '
        Else
          strMens := 'O pedido ' + strNumPed + ' gerou as seguintes Ordens de Produção: ' + #10#13;

        TamArrOrdPro := 0;
        While Not Eof Do
        Begin
          strMens := strMens + FieldByName('FDO_ORDPRO').AsString;

          If RecNo < RecordCount Then
            strMens := strMens + ', ';

          if fCfgSis('EXOPAB', varBoolean) then
          begin
            if TOrdPro.fOrdemProducaoBaixada(FieldByName('FDO_ORDPRO').AsString, strCodEmp) then
              OrdProBaix := true
            else
             begin
               inc(TamArrOrdPro);
               SetLength(ArrOrdPro, TamArrordPro);
               ArrOrdPro[TamArrOrdPro-1] := FieldByName('FDO_ORDPRO').AsString;
             end;
          end;

          Next;

        End;

      End;

      If Result then
      begin
        if fCfgSis('EXOPAB', varBoolean) then
        begin
          if OrdProBaix then
            strMens := strMens + '.' + #10#13 + 'Para prosseguir é necessário excluir o(s) documento(s).'
          else
           begin
             if RecordCount = 1 then
               strMens := strMens + ', que será excluída.' + #10#13
             else strMens := strMens + 'que serão excluídas.' +  #10#13;

             ExcTodOrdPro := true;
             for i := 0 to length(ArrOrdPro)-1 do
             begin
               strOrdPro  := ArrOrdPro[i];
               ExcOrdPro := TOrdPro.fExcluirOrdemProducao(StrOrdPro, strCodEmp, 'untFuncoes', strLoginUsuarioLogado);
               if not ExcOrdPro then
                 ExcTodOrdPro := false;
             end;
             SetLength(ArrOrdPro,0);
             if ExcTodOrdPro then
               Result := false;
           end;
        end
        else strMens := strMens + '.' + #10#13 + 'Para prosseguir é necessário excluir o(s) documento(s).'
      end;

    End;

  End;

  FreeAndNil(qryGen);

End;

end.
