
{***********************}
{* qryConIte -> CADITE *}
{********************JB*}
unit untPrincipal;

interface

uses
  UnitProfiler, Winapi.Messages, SysUtils, Types, Classes, Variants, Menus, ExtCtrls, Rtti,
  Graphics, Buttons, Dialogs, StdCtrls, StrUtils, ImgList, DateUtils,
  jpeg, Shellapi, MidasLib, untMensagemExplicativa, BitBtnLockedIncrem, untITintasDeMaquina,
  untCfgRepositorio, ActiveX,  CxProgressBar, untCadClassificacaoOnu,
  untRelCtrCartaCob, untRelCtrReimpressaoDocs, untIIntegracaoCartoes, ComCtrls,
  untRelEstItemsAcimaMax, untRelEstItemsAbaixoMin,untTMonitorGeraBoletos,
  untRelEstLibArmazenamento, untCtpReprogVen, untRelatorio,
  cxLookAndFeelPainters, cxGraphics,  Controls, dxScreenTip, dxCustomHint, cxHint,
  cxClasses, dxAlertWindow, AdvMenus, AdvMenuStylers, cxLookAndFeels, cxButtons,
  dxGDIPlusClasses, Contnrs, untMenuSemaforo, IniFiles, cxLocalization, frxClass,
  cxControls, cxContainer, cxEdit, cxImage, System.ImageList, dxCoreGraphics,
  untLogForm, untPlugin, Vcl.AppEvnts, Login.View.Interfaces, untTLogin,
  Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel, cxGroupBox, Math, untTDashboard,
  Datasnap.DBClient, UniClientDataSet, untRelCartoesLogAcomp,untCadAjustes, clipBrd,
  untConciliacaoCartoes, Winapi.GDIPOBJ, untLiberacao, VirtualUI_SDK, untfuncoesSimples,
  untQuadroLicencas, untQuadroLicencasDados,
  untFramePesquisarMenu, System.Generics.Collections, System.TypInfo,
  untConectando, untErroRede, untFuncIns,  untFuncInsFactory, untFatRomaneioLoteSeparacao,
  untDllGnre, untDllGnreFuncoes, TaEntregue.Romaneios.Classes, Xml.XMLDoc,
  Principal.View.Interfaces, untTypesSistema, untTMenuAutcom, Xml.XMLIntf,
  Vcl.Themes, System.UITypes, System.UIConsts,EditFocus,
  untPnlDadosItemPrecoProduto, untTFuncoesFiremonkey,
  {$IFDEF TESTABILIDADE_AUTCOM}
  madExcept,
  {$Else}
  //não utiliza quando Teste Automatizado
  FMX.Forms,
  Principal.View.FMXPrincipal, Login.View.FMXLogin, Login.View.FMXSplash, Principal.View.FMXCRM,
  Autoatendimento.PagueFacil.View.RecebimentoPedido,
  Autoatendimento.ConsultaPreco.View.ConsultarPreco, Principal.View.FMXPainelEntregas,
  Principal.View.FMXMensagemInstalacaoWebView,
  Principal.View.FMXDashboardOld, Principal.View.FMXDashboard, FMX.Platform.Win,
  {$ENDIF}
  untImportarArquivoParaAnalise_de_Compras, dxCore, untRequisicaoPedidoCompra, untFuncoesPedidoSimples,
  TlHelp32, untInterfaceTefCitel,untMovimentacaoProgramadaManual, untPreAlt_Trigger,untOrdProAtualizaPrecos_Dinpar,
  untPgtOnlineApi, untTEnderecamentoMarmoreGranito, untManutencaoOrdProVidro, untCadFinalidadeAjuste, untImpPagina, untAlterarPaginaRevista,
  untCancelamentoFrete, untAlpePaymentProductsArrangements, untNotificacoes,
  untEntImportacaoNFSe, Windows, Uni, untLiberacaoCNPJ, Forms,
  untCfgHabilitaConsultaCotacaoAPIBalcao, untCfgRelacionaFornecedorSkyFornecedorAutcom,

  Fulfillment.Funcoes,
  Fulfillment.Constantes,
  untEntConferenciaTransferencia,
  untTransfArmazensProdutoAcabado,
  TypesLayoutPedidoCompra;

type
  TfrmPrincipal = class(TForm, IPrincipalAutcom, IObserverTEFCitel)
    mnuAutcomK: TAdvMainMenu;
    mnuPrincipal: TMenuItem;
    mnuRelatorio: TMenuItem;
    mnuUtil: TMenuItem;
    mnuCadConfiguracoes: TMenuItem;
    stbStatus: TStatusBar;
    mnuProxCodigos: TMenuItem;
    mnuManCadastros: TMenuItem;
    mnuCadPortadores: TMenuItem;
    mnuProdutosAgregados: TMenuItem;
    mnuCadProdutos: TMenuItem;
    mnuCadFornecedores: TMenuItem;
    mnuCadClientes: TMenuItem;
    mnuCadMarcas: TMenuItem;
    mnuCadAtividades: TMenuItem;
    mnuCadDiversos: TMenuItem;
    mnuCadCidades: TMenuItem;
    mnuCadUnidades: TMenuItem;
    mnuCadCompromissos: TMenuItem;
    mnuCadAuxiliares: TMenuItem;
    mnuCadEmpresas: TMenuItem;
    mnuCadBancos: TMenuItem;
    mnuCadCentroCusto: TMenuItem;
    mnuCadCtaResultados: TMenuItem;
    mnuCadSitTributaria: TMenuItem;
    mnuCadClassFiscal: TMenuItem;
    mnuCadIrregFiscal: TMenuItem;
    mnuCadTransporatadoras: TMenuItem;
    mnuCadCartoes: TMenuItem;
    mnuCadConfRelatorios: TMenuItem;
    mnuCadImpressoras: TMenuItem;
    mnuCadIdentificacaoImpressora: TMenuItem;
    mnuSeguranca: TMenuItem;
    mnuCadOperadores: TMenuItem;
    mnuCadGruOperadorNovo: TMenuItem;
    mnuDirAcesso: TMenuItem;
    mnuCadGrupos: TMenuItem;
    mnuCadAbrevFiscal: TMenuItem;
    mnuCadRessarcimentoIcmsStCAT: TMenuItem;
    mnuFinanceiro: TMenuItem;
    mnuCadMovBancaria: TMenuItem;
    N2: TMenuItem;
    mnuAmbienteRede: TMenuItem;
    mnuGenrencImpr: TMenuItem;
    mnuRelCadastros: TMenuItem;
    N3: TMenuItem;
    mnuLivroFiscal: TMenuItem;
    mnuCadLivroFiscal: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    mnuCtaReceber: TMenuItem;
    mnuCadCtaReceber: TMenuItem;
    mnuFornecedores: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    EUTRCT: TMenuItem;
    mnuBaixaCtaReceber: TMenuItem;
    mnuEstornoCtaReceber: TMenuItem;
    mnuRelCtaReceber: TMenuItem;
    mnuRelCtrAnalCredito: TMenuItem;
    mnuRelCtrTitRecebidos: TMenuItem;
    mnuCadAdquirenteCartao: TMenuItem;
    mnuRelContBanc: TMenuItem;
    mnuRelClientes: TMenuItem;
    mnuManCheques: TMenuItem;
    mnuCadCheques: TMenuItem;
    PaineldaGondola1: TMenuItem;
    LIBGONABRIR: TMenuItem;
    LIBGONREIMP: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    mnuBaixaCheque: TMenuItem;
    mnuChequesRepasse: TMenuItem;
    mnuCancRepasse: TMenuItem;
    N10: TMenuItem;
    mnuCadSalBalanco: TMenuItem;
    N11: TMenuItem;
    mnuCtaPagar: TMenuItem;
    mnuCadCtaPagar: TMenuItem;
    mnuBaixaCtaPagar: TMenuItem;
    N12: TMenuItem;
    mnuRelChequePre: TMenuItem;
    mnuEstornoCtaPagar: TMenuItem;
    mnuImpBoletoIndiv: TMenuItem;
    mnuEtiquetas: TMenuItem;
    mnuEtiClientes: TMenuItem;
    mnuEtiItens: TMenuItem;
    mnuEtiDiversos: TMenuItem;
    mnuEtiFornecedores: TMenuItem;
    mnuEtiVendedores: TMenuItem;
    mnuAgrupDuplicatas: TMenuItem;
    mnuDesagrupDuplicatas: TMenuItem;
    N13: TMenuItem;
    mnuRelCtaPagar: TMenuItem;
    mnuRelCtpAnaDebitos: TMenuItem;
    mnuRelCtpTitConta: TMenuItem;
    N15: TMenuItem;
    mnuMovItens: TMenuItem;
    mnuPedidoCompras: TMenuItem;
    mnuCancelamentoPedido: TMenuItem;
    N14: TMenuItem;
    mnuFechamentosMensais: TMenuItem;
    mnuFecGiroEstoque: TMenuItem;
    N16: TMenuItem;
    mnuContrCartoes: TMenuItem;
    mnuManCartao: TMenuItem;
    mnuBaixaCartoes: TMenuItem;
    N17: TMenuItem;
    mnuCadPrevisoes: TMenuItem;
    mnuDirAutBan: TMenuItem;
    N18: TMenuItem;
    mnuGerLayoutBan: TMenuItem;
    GEMTVU: TMenuItem;
    mnuEntMercadorias: TMenuItem;
    N21: TMenuItem;
    N20: TMenuItem;
    mnuAjusteEstoque: TMenuItem;
    mnuOpeProdutos: TMenuItem;
    N19: TMenuItem;
    mnuAltPrecoProduto: TMenuItem;
    N23: TMenuItem;
    mnuAltPrecoGlo: TMenuItem;
    N24: TMenuItem;
    mnuRelacSimilaridade: TMenuItem;
    N25: TMenuItem;
    N99: TMenuItem;
    mnuRelEstoque: TMenuItem;
    mnuRelEspNotaEnt: TMenuItem;
    mnuRelLstPreAlt: TMenuItem;
    N26: TMenuItem;
    mnuTransfLinGru: TMenuItem;
    N27: TMenuItem;
    mnuFaturamento: TMenuItem;
    mnuEmisFaturamento: TMenuItem;
    mnuFatConsPrecos: TMenuItem;
    mnuConsultaFatNovosItens: TMenuItem;
    mnuFatResumoCaixa: TMenuItem;
    mnuFatOrcamento: TMenuItem;
    mnuFatPedido: TMenuItem;
    mnuFatOrcamentoVendaRapida: TMenuItem;
    mnuFatPedidoVendaRapida: TMenuItem;
    mnuFatVendaNormal: TMenuItem;
    mnuFatConfDocumentos: TMenuItem;
    mnuFatOutrasSaidas: TMenuItem;
    mnuFatNFComplemento: TMenuItem;
    mnuFatBrinde: TMenuItem;
    mnuFatTransfEstoque: TMenuItem;
    mnuFatTrocaMerc: TMenuItem;
    Faturamento1: TMenuItem;
    OUTSA: TMenuItem;
    LIMCR: TMenuItem;
    MRGLU: TMenuItem;
    CLAVE: TMenuItem;
    COMPR: TMenuItem;
    PRMIN: TMenuItem;
    VEMIN: TMenuItem;
    DEATR: TMenuItem;
    CONCC: TMenuItem;
    VLCRE: TMenuItem;
    EXEPMR:TMenuItem;
    CANNET: TMenuItem;
    PROVEN: TMenuItem;
    LIBCAN: TMenuItem;
    mnuRelEstCompForn: TMenuItem;
    mnuRelEstItensAbaixoMin: TMenuItem;
    mnuRelEstItensAcimaMax: TMenuItem;
    N28: TMenuItem;
    mnuExclusaoOrcFaturados: TMenuItem;
    mnuFatDevolucao: TMenuItem;
    mnuFatDevolucaoBaixaEntFut: TMenuItem;
    mnuRelEstMovSaldoBal: TMenuItem;
    N29: TMenuItem;
    mnuTintaDeMaquina: TMenuItem;
    N30: TMenuItem;
    mnuRelEstatisticas: TMenuItem;
    mnuRelEstatAnalResult: TMenuItem;
    N32: TMenuItem;
    mnuRelFaturamento: TMenuItem;
    mnuConsultaProdutos: TMenuItem;
    mnuRelBancFluxoCaixa: TMenuItem;
    N33: TMenuItem;
    mnuRelLivrosFiscais: TMenuItem;
    mnuRelFiscResumoIcms: TMenuItem;
    mnuRelFatComVendedor: TMenuItem;
    mnuRelFatReimprDocumentos: TMenuItem;
    mnuRelFatListVenRep: TMenuItem;
    N34: TMenuItem;
    DIGBARLOC_ITEATI: TMenuItem;
    DIGBARLOC_ESTMIN: TMenuItem;
    DIGBARLOC_ESTMAX: TMenuItem;
    DIGBARLOC_PONEXP: TMenuItem;
    mnuRelPedidos: TMenuItem;
    mnuRelCtrCartaCob: TMenuItem;
    mnuCartaAnuencia: TMenuItem;
    mnuFatFormulacaoDocumentos: TMenuItem;
    imgIcones: TImageList;
    N1: TMenuItem;
    mnuCancelamentoDocumentos: TMenuItem;
    mnuDirAutTin: TMenuItem;
    pnlFundo: TPanel;
    popFaturamento: TAdvPopupMenu;
    mnuReimpressaoDocs2: TMenuItem;
    mnuCadEventos: TMenuItem;
    mnuRelCtrCartoes: TMenuItem;
    mnuCadEcf: TMenuItem;
    mnuBaixaChequesCustodia: TMenuItem;
    mnuBaixaCancCustodia: TMenuItem;
    popFinanceiro: TAdvPopupMenu;
    pnlRodape: TPanel;
    popMovItens: TAdvPopupMenu;
    mnuRelCtrReimpressaoDocs: TMenuItem;
    mnuCadCnd: TMenuItem;
    mnuCadFpg: TMenuItem;
    mnuFinDesmRemBanc: TMenuItem;
    mnuCadCom: TMenuItem;
    mnuCadMotoristas: TMenuItem;
    mnuFatRomaneio: TMenuItem;
    mnuFatLiberacaoRomaneio: TMenuItem;
    mnuCadServicos: TMenuItem;
    mnuCadTipSer: TMenuItem;
    mnuCadStaSer: TMenuItem;
    popProdutos: TAdvPopupMenu;
    mnuAltPrecoIndividual: TMenuItem;
    N31: TMenuItem;
    mnuGerAutCtaPagar: TMenuItem;
    mnuAcertoConta: TMenuItem;
    mnuCadPromocoes: TMenuItem;
    mnuCadPromocaoBrindes: TMenuItem;
    mnuRelItensPromocao: TMenuItem;
    mnuInfCobranca: TMenuItem;
    mnuCadTiposCliente: TMenuItem;
    NOESP: TMenuItem;
    mnuCadEmiCheques: TMenuItem;
    mnuFatConfCupomFiscal: TMenuItem;
    mnuTransfCodCliente: TMenuItem;
    mnuAltVenRep: TMenuItem;
    N39: TMenuItem;
    mnuTransfCodVendedor: TMenuItem;
    N40: TMenuItem;
    mnuCadEstruturas: TMenuItem;
    mnuGerImpFiscais: TMenuItem;
    N36: TMenuItem;
    mnuFatConfTransEstoque: TMenuItem;
    N37: TMenuItem;
    mnuNotaFiscalImport: TMenuItem;
    mnuRelEstSaldoReservado: TMenuItem;
    mnuCadMetas: TMenuItem;
    mnuCadConciliacaoBancaria: TMenuItem;
    N41: TMenuItem;
    mnuTransCodFornecedor: TMenuItem;
    mnuFatConfPedidos: TMenuItem;
    mnuTransfCodCidade: TMenuItem;
    N44: TMenuItem;
    mnuOrdemProducao: TMenuItem;
    mnuManOrdPro: TMenuItem;
    mnuBaiOrdPro: TMenuItem;
    mnuFatExpedicao: TMenuItem;
    mnuFatExpedicaoBaiSep: TMenuItem;
    mnuFatExpedicaoConferenciaRetiraCaixa: TMenuItem;
    mnuRedeLojas: TMenuItem;
    mnuCampanhaVendas: TMenuItem;
    mnufrmLogDelecoes: TMenuItem;
    mnufrmLogErros: TMenuItem;
    mnuSenhadeLiberacao: TMenuItem;
    N45: TMenuItem;
    mnuCtrLiberacaoFiltros: TMenuItem;
    mnuAltEfetivacaoPrecos: TMenuItem;
    mnuBonusVenda: TMenuItem;
    mnuCadMetasClientes: TMenuItem;
    mnuFatOutrasEntradas: TMenuItem;
    N46: TMenuItem;
    btnConEst: TMenuItem;
    mnuGarantia: TMenuItem;
    mnuRecebimentoCliente: TMenuItem;
    mnuEnvioFornecedor: TMenuItem;
    mnuRetornoFornecedor: TMenuItem;
    mnuEnvioCliente: TMenuItem;
    mnuTransfCodCta: TMenuItem;
    mnuGerInventario: TMenuItem;
    mnuInventario: TMenuItem;
    mnuManutInventario: TMenuItem;
    mnuProcessList: TMenuItem;
    mnuFatNotaFiscalEspecial: TMenuItem;
    N49: TMenuItem;
    mnuTeleatendimento: TMenuItem;
    mnuAgendamentoCiclicoComDia: TMenuItem;
    mnuGeraAgendaCiclicoComDia: TMenuItem;
    mnuRelTelListaAtendimento: TMenuItem;
    mnuRelTelMapaAten: TMenuItem;
    mnuAtendimento: TMenuItem;
    N52: TMenuItem;
    mnuGeracaoCodBarras: TMenuItem;
    N53: TMenuItem;
    mnuClubeFidelidade: TMenuItem;
    mnuManClubeFidelidade: TMenuItem;
    mnuSobre: TMenuItem;
    N55: TMenuItem;
    mnuBalancas: TMenuItem;
    mnuFilizola: TMenuItem;
    mnuCadSetoresFilizola: TMenuItem;
    mnuEtiAvulsa: TMenuItem;
    mnuCadConsumidor: TMenuItem;
    mnuAgrupDuplicatasCtp: TMenuItem;
    btnVendasCanceladas: TMenuItem;
    mnuRelCadDiversos: TMenuItem;
    N56: TMenuItem;
    mnuLogoff: TMenuItem;
    mnuCadRegioes: TMenuItem;
    mnuDesagrupCtaPag: TMenuItem;
    N57: TMenuItem;
    N149: TMenuItem;
    mnuCadFasesOrdProd: TMenuItem;
    mnuMonitorFasesOrdProd: TMenuItem;
    mnuOrdProEmissaoPerdaRefugo: TMenuItem;
    mnuComissaoProfissionais: TMenuItem;
    mnuManutComProfissionais: TMenuItem;
    VCOMIS: TMenuItem;
    LBSDVN: TMenuItem;
    mnuRelFiscTermoAbert: TMenuItem;
    mnuCadBocaCaixa: TMenuItem;
    untCadMsg: TMenuItem;
    pnlMenTef: TPanel;
    mnuADMAdministracaoTEF: TMenuItem;
    mnuRelComissaoVendedorCTR: TMenuItem;
    mnuRelComissaoProfissionalCTR: TMenuItem;
    OUTEN: TMenuItem;
    mnuCadTelefoneContato: TMenuItem;
    mnuSenhadeLiberacao2: TMenuItem;
    mnuRelFiscProdutoControlado: TMenuItem;
    mnuRelFiscSaiSTDadosEntrada: TMenuItem;
    mnuCalEstMin: TMenuItem;
    mnuConsultaFatCatalogo: TMenuItem;
    N59: TMenuItem;
    mnuImportCatalogoPreco: TMenuItem;
    ATVPRO: TMenuItem;
    ALTSEN: TMenuItem;
    mnuBaixaBocaCaixa: TMenuItem;
    N60: TMenuItem;
    mnuFatBaixaRomaneio: TMenuItem;
    mnuConsultaFatCatalogoAlteracao: TMenuItem;
    mnuCadMovBancario_TE: TMenuItem;
    mnuFatBaixaEntregaFutura: TMenuItem;
    N61: TMenuItem;
    mnuCancDepChequePre: TMenuItem;
    ResumodeCaixa1: TMenuItem;
    ransferncia1: TMenuItem;
    Pagamento1: TMenuItem;
    LancDbito1: TMenuItem;
    LancCrdito1: TMenuItem;
    CrditoCliente1: TMenuItem;
    mnuAltPrecoGlobal: TMenuItem;
    mnuAltPrecoGlobalCatalogo: TMenuItem;
    LBITES: TMenuItem;
    MARGE: TMenuItem;
    mnuTXTACACIAServer: TMenuItem;
    mnuTXTACACIAServerExp: TMenuItem;
    mnuTXTACACIAServerImp: TMenuItem;
    mnuRelEstDigitacaoNotaEntrada: TMenuItem;
    SENPED: TMenuItem;
    PRMIN2: TMenuItem;
    VEMIN2: TMenuItem;
    LBPRME: TMenuItem;
    VSCCCL: TMenuItem;
    ALPDCE: TMenuItem;
    VISMLCP: TMenuItem;
    mnuManutComProfissionaisInc: TMenuItem;
    IMPORD: TMenuItem;
    mnuEstornaCartoes: TMenuItem;
    mnuRelCtpTitPortador: TMenuItem;
    TROTAB: TMenuItem;
    mnuEtiEstruturas: TMenuItem;
    mnuEtiDespacho: TMenuItem;
    mnuCalNivGirEst: TMenuItem;
    MargemLucro1: TMenuItem;
    mnuTransfCodProduto: TMenuItem;
    N63: TMenuItem;
    mnuDigCodBarLocFis: TMenuItem;
    mnuManECommerce: TMenuItem;
    N64: TMenuItem;
    mnuSelListPreco: TMenuItem;
    rocarFormadePagamento1: TMenuItem;
    mnuRelacSemelhanca: TMenuItem;
    OBCLAT: TMenuItem;
    OBCLAC: TMenuItem;
    BAIPDV: TMenuItem;
    N65: TMenuItem;
    mnuBalancoEstoque: TMenuItem;
    mnuBalancoEstoqueZera: TMenuItem;
    mnuBalancoEstoqueImportar: TMenuItem;
    mnuBalancoEstoqueDigManual: TMenuItem;
    mnuBalancoEstoqueGravacao: TMenuItem;
    mnuFatConsertoEquipamentos: TMenuItem;
    mnuFatManConsertoEquip: TMenuItem;
    mnuRelCtrCompAgrupDup: TMenuItem;
    N66: TMenuItem;
    mnuImportTabPrecosIteger: TMenuItem;
    mnuImportMargemLucroTabPreco: TMenuItem;
    mnuImportComisVendTabPreco: TMenuItem;
    mnuRelFiscResumoApIcms: TMenuItem;
    mnuCadFeriado: TMenuItem;
    VITBPR: TMenuItem;
    mnuClientes1: TMenuItem;
    AlteraodeStatus1: TMenuItem;
    AlteraodeLimitedeCrdito1: TMenuItem;
    AlteraodeTipodeCliente1: TMenuItem;
    mnuFatAltVendedor: TMenuItem;
    mnuComissaoIndices: TMenuItem;
    mnuCadIndCom: TMenuItem;
    mnuComissaoporfaixadepesos: TMenuItem;
    mnuCadComPes: TMenuItem;
    mnuCadCotacoes: TMenuItem;
    SENZTA: TMenuItem;
    N68: TMenuItem;
    mnuEntConferencia: TMenuItem;
    mnuFatAlteraDtaEntFut: TMenuItem;
    mnuEntFreConImportacao: TMenuItem;
    mnuCadGruCompras: TMenuItem;
    mnuCadOriFgo: TMenuItem;
    mnuPedidoCompraLiberacao: TMenuItem;
    N70: TMenuItem;
    mnuEntImportaNotaElet: TMenuItem;
    mnuCadComEntregadores: TMenuItem;
    mnuComissaoporfaixadefaturamento: TMenuItem;
    mnuCadComFat: TMenuItem;
    mnuFatRemContaOrdem: TMenuItem;
    mnuFatRemMercFaltante: TMenuItem;
    mnuBaixaEntregadores: TMenuItem;
    mnuCtrDescontada: TMenuItem;
    VISCUS: TMenuItem;
    mnuFatCupomFiscalEsp: TMenuItem;
    EXPAUT: TMenuItem;
    LIMEXP: TMenuItem;
    mnuAlteracaoEntregaFutura: TMenuItem;
    mnuExpProdColetor: TMenuItem;
    ALTVEO: TMenuItem;
    ENTPNL: TMenuItem;
    SENITE: TMenuItem;
    TROMER: TMenuItem;
    SENPAR: TMenuItem;
    mnuRcxReimpTransfer: TMenuItem;
    mnuOrdProdGerAutom: TMenuItem;
    AlteraodaDatadePrevisodosPedidos1: TMenuItem;
    mnuAlteraAlqRetencao: TMenuItem;
    mnuCadGrupoPrecos: TMenuItem;
    ContasaPagar1: TMenuItem;
    CTPALTDUP: TMenuItem;
    mnuToledo: TMenuItem;
    CadastrodeSetores1: TMenuItem;
    mnuAlteraodeTabeladePreo1: TMenuItem;
    mnuFatVendaServico: TMenuItem;
    LIBITEF11: TMenuItem;
    PERCANCELARPEDIDORCX: TMenuItem;
    ENENC: TMenuItem;
    ALFZCL: TMenuItem;
    HERPDC: TMenuItem;
    FPGSEN: TMenuItem;
    mnuEmprestimosdeDocumentos: TMenuItem;
    frmFatEmprestimos: TMenuItem;
    mnuFatBaixaEmprestimos: TMenuItem;
    ALTVCL: TMenuItem;
    ALTFPG: TMenuItem;
    ALTATI: TMenuItem;
    ALTPOR: TMenuItem;
    ALTOGP: TMenuItem;
    RCXCRE: TMenuItem;
    TABCLI: TMenuItem;
    CAMLIM: TMenuItem;
    REMCTR: TMenuItem;
    ALTZOF: TMenuItem;
    N71: TMenuItem;
    mnuCadBocaCaixaAlt: TMenuItem;
    mnuRelEstListaPrecosGComp: TMenuItem;
    mnuTransfCheqEmpresa: TMenuItem;
    mnuFatCancBaixaRomaneio: TMenuItem;
    mnuRelEstatAnalResultMovBan: TMenuItem;
    mnuCadLoteItens: TMenuItem;
    mnuCadLoteItensRapido: TMenuItem;
    N72: TMenuItem;
    mnuTXTIntegracaoSistemas: TMenuItem;
    mnuTXTSFAMob: TMenuItem;
    mnuTxtSfaMobImp: TMenuItem;
    mnuImportacaoSfaMobAndroid: TMenuItem;
    mnuRecTransfEstoque: TMenuItem;
    N73: TMenuItem;
    mnuExportacaoSite: TMenuItem;
    mnuConsultadeSaldodeContasBancrias: TMenuItem;
    mnuVendasPerdidas: TMenuItem;
    mnuVendasPerdidasDig: TMenuItem;
    mnuExpFunBoshSep: TMenuItem;
    mnuExpFunBosh: TMenuItem;
    SENMPR: TMenuItem;
    mnuDiversos: TMenuItem;
    F11AVS: TMenuItem;
    F11ALTCAR: TMenuItem;
    F11UNICAR: TMenuItem;
    RCXDESMAX: TMenuItem;
    SIVDVM: TMenuItem;
    RTRSGR: TMenuItem;
    RTRRGR: TMenuItem;
    RIMPDC: TMenuItem;
    RFACOVD: TMenuItem;
    RFCVDFT: TMenuItem;
    RFCVDID: TMenuItem;
    RFCVDPS: TMenuItem;
    RFCVDPL: TMenuItem;
    RFVDCLI: TMenuItem;
    RFVDDR: TMenuItem;
    RFMETCLIVEN: TMenuItem;
    REABCVENREPVEN: TMenuItem;
    REABCVENREPREP: TMenuItem;
    mnuCadMetasValor: TMenuItem;
    mnuCadMetasGalonagem: TMenuItem;
    mnuFatVendaUsoConsumo: TMenuItem;
    N75: TMenuItem;
    mnuTransfCodMarca: TMenuItem;
    mnuCadVeiculos: TMenuItem;
    mnuTransfCodUnidade: TMenuItem;
    mnuCtpAtribPortador: TMenuItem;
    mnuVendaTintaMaq: TMenuItem;
    NOVFMT: TMenuItem;
    mnuRelCtrBordero: TMenuItem;
    RESFIN: TMenuItem;
    ITEVEN: TMenuItem;
    ITECMP: TMenuItem;
    mnuCadDepartamentos: TMenuItem;
    PIGBAS: TMenuItem;
    mnuCancDevChequePre: TMenuItem;
    INFPRO: TMenuItem;
    PRGTP2: TMenuItem;
    PRGTP3: TMenuItem;
    PRGTP4: TMenuItem;
    PRGTP5: TMenuItem;
    PRGTP6: TMenuItem;
    PRGTP7: TMenuItem;
    mnuEtiOrcPed: TMenuItem;
    ALMBEF: TMenuItem;
    VRMPNF: TMenuItem;
    ALTPDI: TMenuItem;
    ALTPCD: TMenuItem;
    REVOVE: TMenuItem;
    PROEXC: TMenuItem;
    mnuCadBandeiras: TMenuItem;
    mnuRelEstKardexAcabado: TMenuItem;
    mnuRelCtpReimpBordero: TMenuItem; //Liberação de PD/OR com promoção excedida
    ATISUS: TMenuItem;
    ALTMEQ: TMenuItem;
    CANCOS: TMenuItem;
    ALCLOS: TMenuItem;
    Mensagem1: TMenuItem;
    Enviar: TMenuItem;
    Receber: TMenuItem;
    RFATCV: TMenuItem;
    PIMPME: TMenuItem;
    ALTRZS: TMenuItem;
    ALTCGC: TMenuItem;
    mnuDirAcessoCancelaDoc: TMenuItem;
    CANCNF: TMenuItem;
    CANCNS: TMenuItem;
    CANCDC: TMenuItem;
    CANCNE: TMenuItem;
    CANCPD: TMenuItem;
    CANCOR: TMenuItem;
    CANCTE: TMenuItem;
    CANCIF: TMenuItem;
    CANCND: TMenuItem;
    CANCNI: TMenuItem;
    CANCOF: TMenuItem;
    CANCEP: TMenuItem;
    CANCBE: TMenuItem;
    CANCFF: TMenuItem;
    CANCMI: TMenuItem;
    CANCTR: TMenuItem;
    CANCDV: TMenuItem;
    CANCBR: TMenuItem;
    CANCAJ: TMenuItem;
    CANCRM: TMenuItem;
    CANCPI: TMenuItem;
    CANCUC: TMenuItem;
    mnuRelContratoAberturaCredito: TMenuItem;
    GERAGM: TMenuItem;
    mnuFatReciboAvulso: TMenuItem;
    VERORC: TMenuItem;
    VERPED: TMenuItem;
    DELFOR: TMenuItem;
    mnuTransfCodAtividade: TMenuItem;
    frmRelDireitosDeAcesso: TMenuItem;
    N77: TMenuItem;
    mnuCadBandeiraEmpresa: TMenuItem;
    mnuCadParametrosEmpresa: TMenuItem;
    mnuPastaCompraConsulta: TMenuItem;
    mnuCadLimiteComprasFornecedor: TMenuItem;
    mnuDASSuvinil: TMenuItem;
    mnuDASAbcClientes: TMenuItem;
    popDASSuvinil: TAdvPopupMenu;
    mnuBackup: TMenuItem;
    mnuExportXmlNexxera: TMenuItem;
    mnuRelCtrLogAcompDuplic: TMenuItem;
    METVNF: TMenuItem;
    Devoluodedinheiroaocliente1: TMenuItem;
    mnuFatPigmento: TMenuItem;
    N79: TMenuItem;
    mnuManutKmRodado: TMenuItem;
    mnuTransfCodDiversos: TMenuItem;
    mnuSenhaOperador: TMenuItem;
    mnuLocksTravados: TMenuItem;
    mnuComissaoporfaixaderecebimento: TMenuItem;
    mnuCadComRec: TMenuItem;
    RFCVDRC: TMenuItem;
    PER_FF: TMenuItem;
    ORDABA: TMenuItem;
    PWDTRO: TMenuItem;
    mnuDireitosCheques: TMenuItem;
    TELECHE: TMenuItem;
    ContasaReceber1: TMenuItem;
    DADUEB: TMenuItem;
    mnuFatControleDataEntrega: TMenuItem;
    mnuComissaoEspecie: TMenuItem;
    mnuRelFatComissaoEspecieCadastro: TMenuItem;
    RFACOES: TMenuItem;
    mnuBaixaChequesTelecheque: TMenuItem;
    mnuBaixaCancTelecheque: TMenuItem;
    mnuCadOcorrencias: TMenuItem;
    REIMCI: TMenuItem;
    mnuRelCtrCartaProtesto: TMenuItem;
    N81: TMenuItem;
    mnuControlePagtoFuncionarios: TMenuItem;
    mnufrmCadFuncionarios: TMenuItem;
    mnuCadVerbas: TMenuItem;
    mnuDigMovimentoMensal: TMenuItem;
    ESPNFE: TMenuItem;
    ENTCRI: TMenuItem;
    ENTLIB: TMenuItem;
    ENTLPN: TMenuItem;
    VDTFGR: TMenuItem;
    CANCEL: TMenuItem;
    METVEN: TMenuItem;
    METVAL: TMenuItem;
    METGAL: TMenuItem;
    mnuFatRomManutEntrega: TMenuItem;
    N82: TMenuItem;
    mnuEditorEtiquetasCliente: TMenuItem;
    mnuEditorEtiquetasCliLaser: TMenuItem;
    frmEditorEtiquetasCliArgox: TMenuItem;
    MARREL: TMenuItem;
    mnuCadMetasRec: TMenuItem;
    REIBOL: TMenuItem;
    mnuEditorEtiquetasItensOrcPed: TMenuItem;
    mnuEditorEtiquetasDespacho: TMenuItem;
    mnuEditorEtiquetasDespachoLaser: TMenuItem;
    mnuEditorEtiquetasDespachoArgox: TMenuItem;
    mnuEditorEtiquetasTinta: TMenuItem;
    N84: TMenuItem;
    mnuCtrLiberacaoFiltrosComercial: TMenuItem;
    mnuCanalAcesso: TMenuItem;
    PARMIN: TMenuItem;
    mnuEditorEtiquetasFormulacao: TMenuItem;
    mnuTransferencia: TMenuItem;
    mnuConfiguracoesEtiquetas: TMenuItem;
    Comisses1: TMenuItem;
    N38: TMenuItem;
    mnuAltRegClientes: TMenuItem;
    N42: TMenuItem;
    AUTEMB: TMenuItem;
    IMPROM: TMenuItem;
    LIBROM: TMenuItem;
    CANLIBROM: TMenuItem;
    mnuRelEstKardexSint: TMenuItem;
    mnuCadFin: TMenuItem;
    N35: TMenuItem;
    mnuEntPreNotaEntrada: TMenuItem;
    N43: TMenuItem;
    mnuLotePrecosEfetivacao: TMenuItem;
    ENDOC: TMenuItem;
    mnuEntConferPreNota: TMenuItem;
    mnuEntEnderecamentoProduto: TMenuItem;
    EntradadeMercadorias1: TMenuItem;
    BXVFRM: TMenuItem;
    mnuFatLiberacaoEntFut: TMenuItem;
    frmFatVendasPR: TMenuItem;
    mnuFatBaixaPedidoDev: TMenuItem;
    PIPCEST: TMenuItem;
    RELRCX: TMenuItem;
    mnuServicoAtencimentoCliente: TMenuItem;
    mnuSacAtedimento: TMenuItem;
    CADCEX: TMenuItem;
    mnuManCentroCustoRateio: TMenuItem;
    PERBON: TMenuItem;
    mnuReimpressaoCarnePagto: TMenuItem;
    ALTFN1: TMenuItem;
    ALTFN2: TMenuItem;
    ALTCON: TMenuItem;
    ALTEM1: TMenuItem;
    ALTEM2: TMenuItem;
    ALTFAX: TMenuItem;
    ALTRAM: TMenuItem;
    ALTCEL: TMenuItem;
    ALTRED: TMenuItem;
    ELTMARNEG: TMenuItem;
    mnuEditorEtiquetasItensCPF: TMenuItem;
    mnuEditorEtiquetasItensCPFLaser: TMenuItem;
    mnuEditorEtiquetasItensCPFArgox: TMenuItem;
    mnuEtiqItensCPF: TMenuItem;
    VENCND: TMenuItem;
    METCUB: TMenuItem;
    mnuFatAcompEntrega: TMenuItem;
    mnuCadVenCnd: TMenuItem;
    mnuCadAjudantes: TMenuItem;
    mnuCadCupomDesconto: TMenuItem;
    N76: TMenuItem;
    mnuFatorPrecoCadastro: TMenuItem;
    mnuN78: TMenuItem;
    mnuBalanceteFinanceiro: TMenuItem;
    mnuCadastrodeClassificaodeCentrodeCusto1: TMenuItem;
    mnuClassificaodosCentrosdeCustos1: TMenuItem;
    mnuImpressodoBalanceteFinanceiro1: TMenuItem;
    mnuLogsFaturamento: TMenuItem;
    mnuMetasFaturamento: TMenuItem;
    mnuComissaoFaixaFaturamentoFaixaVendedor: TMenuItem;
    mnuCadComFatVend: TMenuItem;
    mnuCadFaixaFatVend: TMenuItem;
    LIBPDC: TMenuItem;
    VECUS: TMenuItem;
    mnuCadReceitAgronomico: TMenuItem;
    ACEF2_: TMenuItem;
    ACEF3_: TMenuItem;
    ACEF4_: TMenuItem;
    ACEF5_: TMenuItem;
    ACEF6_: TMenuItem;
    ACEF7_: TMenuItem;
    ACEF8_: TMenuItem;
    ACEF9_: TMenuItem;
    ACEF10: TMenuItem;
    ACEF11: TMenuItem;
    ACESPED: TMenuItem;
    DIRRCXRECF11: TMenuItem;
    DIRRCXCTP: TMenuItem;
    DIRRCXREC: TMenuItem;
    DIRRCXEPG: TMenuItem;
    DIRRCXIFD: TMenuItem;
    DIRRCXIFDF1: TMenuItem;
    DIRRCXCCS: TMenuItem;
    DIRRCXCFF: TMenuItem;
    DIRRCXDPC: TMenuItem;
    DIRRCXPBR: TMenuItem;
    DIRRCXPEF: TMenuItem;
    DIRRCXADC: TMenuItem;
    DIRRCXADCGCC: TMenuItem;
    CANCNC: TMenuItem;
    CANCPR: TMenuItem;
    RCXF11: TMenuItem;
    ImpressoraFiscal1: TMenuItem;
    CANCUP: TMenuItem;
    RELTDI: TMenuItem;
    mnuCadAbreviacaoPIS: TMenuItem;
    mnuCadAbreviacaoCOFINS: TMenuItem;
    mnuCadAbreviacaoIPI: TMenuItem;
    mnuCadEnquadramentoIPI: TMenuItem;
    DIVTCO: TMenuItem;
    N78: TMenuItem;
    mnuImpEtiqNotaEntrada: TMenuItem;
    HISFUN: TMenuItem;
    ITREPR: TMenuItem;
    F11VDL: TMenuItem;
    IMPBVE: TMenuItem;
    mnuN80: TMenuItem;
    mnuAltNumLote: TMenuItem;
    IMPRVE: TMenuItem;
    COBIMP: TMenuItem;
    EXITF11: TMenuItem;
    CANCF4C: TMenuItem;
    RETPREF3: TMenuItem;
    ALTNOF: TMenuItem;
    SENPEM: TMenuItem;
    LNKSIT: TMenuItem;
    CNPCLI: TMenuItem;
    mnuIntegraDoctorcred: TMenuItem;
    CONMEP: TMenuItem;
    ITEENT: TMenuItem;
    mnuGeraNotaDebito: TMenuItem;
    mnuGeraDuplicataReceber: TMenuItem;
    SACDPO: TMenuItem;
    SACDRE: TMenuItem;
    SENCND: TMenuItem;
    RELMSG: TMenuItem;
    pnlLibera: TPanel;
    pnlLiberaPedCom: TPanel;
    COMDIV: TMenuItem;
    GERCLI: TMenuItem;
    GERDIV: TMenuItem;
    SARELAY: TMenuItem;
    CODBAR: TMenuItem;
    mnuAltEfetivacaoPrecosTab: TMenuItem;
    N80: TMenuItem;
    mnuVerificadorDeCupons: TMenuItem;
    mnuPedidodedeCompra: TMenuItem;
    BAXPED: TMenuItem;
    RELRCXESP: TMenuItem;
    DADEFN: TMenuItem;
    mntmExpGNREdeSaida: TMenuItem;
    tryIconAutcom: TTrayIcon;
    popMenuAutcom: TAdvPopupMenu;
    mnuPedidosLiberacao: TMenuItem;
    mnuRelEtiqQtdRestante: TMenuItem;
    MKPPREUNI: TMenuItem;
    mnuCadClienteContato: TMenuItem;
    mnuCadGostoMusical: TMenuItem;
    mnuCadHobby: TMenuItem;
    mnuCadEscolaridade: TMenuItem;
    mnuCadEstadoCivil: TMenuItem;
    mnuDepartamentos: TMenuItem;
    mnuCadCargos: TMenuItem;
    mnuCadTimeFutebol: TMenuItem;
    mnuN87: TMenuItem;
    mnuLayoutsImpressao: TMenuItem;
    DIFCLI: TMenuItem;
    DIF_ST: TMenuItem;
    DIF_PC: TMenuItem;
    N83: TMenuItem;
    mnuAlteraEstMinMax: TMenuItem;
    LSTPREALT: TMenuItem;
    IMPPREALT: TMenuItem;
    PERCLI: TMenuItem;
    IMPRFP: TMenuItem;
    OPJAIM: TMenuItem;
    N85: TMenuItem;
    mnuCRM: TMenuItem;
    mnuCadCrm: TMenuItem;
    mnuCadGrupoOcorrencias: TMenuItem;
    mnuCadTiposOcorrencias: TMenuItem;
    TRFCTR: TMenuItem;
    mnuCadSitProduto: TMenuItem;
    RELBALESTAJU: TMenuItem;
    mnuCadMontadoras: TMenuItem;
    mnuCadLocFisica: TMenuItem;
    mnuCadArmazem: TMenuItem;
    mnuCadPrevisaoMensal: TMenuItem;
    N86: TMenuItem;
    mnuTransfArmazens: TMenuItem;
    mnuControledeKMRodado: TMenuItem;
    mnuCadAutAba: TMenuItem;
    N87: TMenuItem;
    RMCREP: TMenuItem;
    N88: TMenuItem;
    PIGPCP: TMenuItem;
    mnuImportaSPEDPISCOFINS: TMenuItem;
    mnuRelRecPagtoFunc: TMenuItem;
    mnuRelCtpReimpressaoDocs: TMenuItem;
    CTPOSF: TMenuItem;
    mnuRelFatExtratoProfissional: TMenuItem;
    mnuCadComplOcorrencias: TMenuItem;
    ALTNNB: TMenuItem;
    INCCRE: TMenuItem;
    pnlCompromissos: TPanel;
    mnuEditorEtiquetasItensQtdRestFat: TMenuItem;
    mnuEditorEtiquetasItensQtdRestAvu: TMenuItem;
    mnuAltPrecoFornecedor: TMenuItem;
    mnuAltPrecoGlobalCustosFor: TMenuItem;
    mnuCadTipoAtendimento: TMenuItem;
    SENJUR: TMenuItem;
    mnuCadMotVendasPerdidas: TMenuItem;
    mnuTXTsFullSoft: TMenuItem;
    mnuCadMetasLitragem: TMenuItem;
    mnuCadFreteTranspCidade: TMenuItem;
    FRETRA: TMenuItem;
    mnuCadSubRegiao: TMenuItem;
    mnuComissoporFaixadeFaturamento1: TMenuItem;
    mnuCadComFatVendDepart: TMenuItem;
    SENCREDUP: TMenuItem;
    ENTXML: TMenuItem;
    mnuContProgProd: TMenuItem;
    mnuConsControleProducao: TMenuItem;
    mnuRelEstComparativoPrecosFornec: TMenuItem;
    mnuCadTabelaPrecos: TMenuItem;
    mnuGeraDespesasProtesto: TMenuItem;
    mnuRelCtrCartaDes: TMenuItem;
    TRQDMI: TMenuItem;
    mnuComissaoFaixaDescDepto: TMenuItem;
    mnuComissaoFaixaMarDepto: TMenuItem;
    mnuCadComFatDepart: TMenuItem;
    mnuCadComFatMarDepart: TMenuItem;
    mnuAnaliseCompras: TMenuItem;
    ALTMAN: TMenuItem;
    EXIITECOM: TMenuItem;
    mnuFatDevDemonstracao: TMenuItem;
    ALTPED: TMenuItem;
    TALORC: TMenuItem;
    mnuCadCor: TMenuItem;
    mnuEntFreConhecimento: TMenuItem;
    mnuRelFiscCreIcmVendInterest: TMenuItem;
    mnuCadCompProdAcab: TMenuItem;
    EXPMTD: TMenuItem;
    EXDFSE: TMenuItem;
    RIMPSEWMS: TMenuItem;
    PRITNAEN: TMenuItem;
    FTPDAGCOM: TMenuItem;
    mnurelFiscGerArqAcSef107_2011: TMenuItem;
    VERCRP: TMenuItem;
    CTPALTVLR: TMenuItem;
    ALTCDV: TMenuItem;
    mnuAltPrecoGlobalNota: TMenuItem;
    mnuCadFases: TMenuItem;
    mnuCadCotacaoMoeda: TMenuItem;
    SENDIFENT: TMenuItem;
    mnuConsignacao: TMenuItem;
    mnuFatConsignacao: TMenuItem;
    mnuFatRetornoConsignacao: TMenuItem;
    mnuFatFaturaConsignacao: TMenuItem;
    mnuFatConsEntPendentes: TMenuItem;
    PENENT: TMenuItem;
    BAIENT: TMenuItem;
    //Inicio Direitos de acesso emissão de faturamento - Especies
    EMIFAT_NS: TMenuItem;
    EMIFAT_NF: TMenuItem;
    EMIFAT_OR: TMenuItem;
    EMIFAT_PD: TMenuItem;
    EMIFAT_IF: TMenuItem;
    EMIFAT_TE: TMenuItem;
    EMIFAT_MI: TMenuItem;
    EMIFAT_BR: TMenuItem;
    EMIFAT_TR: TMenuItem;
    EMIFAT_DV: TMenuItem;
    EMIFAT_FF: TMenuItem;
    EMIFAT_PI: TMenuItem;
    EMIFAT_EP: TMenuItem;
    EMIFAT_UC: TMenuItem;
    EMIFAT_PR: TMenuItem;
    EMIFAT_CS: TMenuItem;
    //Fim Direitos de acesso emissão de faturamento - Especies
    VEMIN3: TMenuItem;
    PRMIN3: TMenuItem;
    SEALVE: TMenuItem;
    NAOATUPRE: TMenuItem;
    mnuBalancoEstoqueDigColetivo: TMenuItem;
    PREVEN: TMenuItem;
    N47: TMenuItem;
    mnuUtilCRM: TMenuItem;
    mnuAtribOcorrEmerg: TMenuItem;
    mnuAnaliseProducao: TMenuItem;
    mnuCadEstrIndSubsComp: TMenuItem;
    mnuConfFFemD1: TMenuItem;
    mnuOrdProIndustrialEtq: TMenuItem;
    mnuEditorEtiquetasOPI: TMenuItem;
    mnuRelFiscMovEstoqContabil: TMenuItem;
    mnuConsultaFatLogPromocao: TMenuItem;
    RFATCG: TMenuItem;
    N62: TMenuItem;
    mnuAltPrecoAcabadosInd: TMenuItem;
    mnuFatDigCartaCorrecao: TMenuItem;
    N69: TMenuItem;
    mnuNfeUtil: TMenuItem;
    mnuNfeInutilizacao: TMenuItem;
    mnuEditorEtiquetasProducaoTinta: TMenuItem;
    SENMTP: TMenuItem;
    mnuMapaDemonstrativodeEstoque1: TMenuItem;
    mnuCadGrupoProdutos: TMenuItem;
    BXENTF: TMenuItem;
    mnuEntConferenciaCancel: TMenuItem;
    mnuFatBaixaEntregaFuturaSEP: TMenuItem;
    mnuFatSepFutDigSeparador: TMenuItem;
    ALTSEPFUT: TMenuItem;
    LIMPSEPFUT: TMenuItem;
    LIMPSEPRET: TMenuItem;
    CANCGA: TMenuItem;
    RFCMPVEN: TMenuItem;
    LIMCR2: TMenuItem;
    mnuPesarProdutos: TMenuItem;
    mnuAlteraoGlobaldePrecos: TMenuItem;
    ALTGCUSVEN: TMenuItem;
    ALTGCUSMAR: TMenuItem;
    ALTGVENMAR: TMenuItem;
    AlteraoIndividualdePrecos: TMenuItem;
    ALTICUSVEN: TMenuItem;
    ALTICUSMAR: TMenuItem;
    ALTIVENMAR: TMenuItem;
    mnuFatRetiraDigSeparador: TMenuItem;
    mnuRelCadCustosIndustrial: TMenuItem;
    IMPCF8: TMenuItem;
    mnuPedidoDeCompraImpAutcom: TMenuItem;
    ALTOBS: TMenuItem;
    ALTCODEAC: TMenuItem;
    ALTCCR: TMenuItem;
    SECDGA: TMenuItem;
    DIMXFP: TMenuItem;
    mnuEditorEtiquetasFuncionarios: TMenuItem;
    mnuEditorEtiquetasFuncionariosLaser: TMenuItem;
    mnuEditorEtiquetasFuncionariosArgox: TMenuItem;
    mnuImpEtiquetasFun: TMenuItem;
    VDRLPDVEN: TMenuItem;
    VDRLPDREP: TMenuItem;
    RELMSGDES: TMenuItem;
    RPDCLIVEN: TMenuItem;
    N50: TMenuItem;
    mnuRelCRM: TMenuItem;
    DEVPJ: TMenuItem;
    mnuCadClassificacaoOnu: TMenuItem;
    N89: TMenuItem;
    DELCEN: TMenuItem;
    RELCPN: TMenuItem;
    mnuEmailMarketing: TMenuItem;
    IMPRVIMP: TMenuItem;
    CNFEFP: TMenuItem;
    mnuRelEstatDemonsFat: TMenuItem;
    TABCND: TMenuItem;
    MOSVLM: TMenuItem;
    BAIEMPF10: TMenuItem;
    BAIEMPF8: TMenuItem;
    BAIEMPMP: TMenuItem;
    mnuCadMetasFornecValFat: TMenuItem;
    mnuImportaSPEDFiscal: TMenuItem;
    SEN_OI: TMenuItem;
    RFACOVO: TMenuItem;
    RFACOVT: TMenuItem;
    mnuRelComissaoCondPagtoDesc: TMenuItem;
    mnuCadFaixasCndPagDesc: TMenuItem;
    mnuFatConfirmacaoAjustes: TMenuItem;
    TINACA: TMenuItem;
    IMPBOLEMP: TMenuItem;
    mnuSolicitacaodeAbastecimentodeTintasdeMaquina: TMenuItem;
    RDZIFP: TMenuItem;
    mnuVeiculos: TMenuItem;
    mnCadMarVei: TMenuItem;
    mnuCadCorVei: TMenuItem;
    mnuCadModVei: TMenuItem;
    mnuServicos: TMenuItem;
    LIBOSC: TMenuItem;
    mnuConsultaServicosAutocenter: TMenuItem;
    BCPBF3: TMenuItem;
    mnuCadMetasValorPedCom: TMenuItem;
    mnuMetas: TMenuItem;
    mnuListaPrecos: TMenuItem;
    mnuPesquisaMercado: TMenuItem;
    mnuPerguntas: TMenuItem;
    mnuPesquisas: TMenuItem;
    mnuRelEstLibArmazenamento: TMenuItem;
    mnuGerarOrcamentoCompraAuto: TMenuItem;
    mnuRequisicaoComprasMenu: TMenuItem;
    mnuFatRequisicaoCompras: TMenuItem;
    mnuBaixaOrdProdGeral: TMenuItem;
    mnuTxtImpFullSoftTablet: TMenuItem;
    SENSER: TMenuItem;
    mnuComissaoFaixaFaturamentoCTR: TMenuItem;
    mnuCadFaixaFaturamentoComissaoCTR: TMenuItem;
    mnuRelFatComFaixaVendedorCTR: TMenuItem;
    SEALTS: TMenuItem;
    LIBALTMAI: TMenuItem;
    mnuFatExpServicos: TMenuItem;
    PEALTSTASE: TMenuItem;
    PEALTMECSEFIN: TMenuItem;
    RETITEEXP: TMenuItem;
    mnuRelFiscMapaResumo: TMenuItem;
    ACEACOSERRCX: TMenuItem;
    ACEACOSERFAT: TMenuItem;
    ACEINCSERPDFIN: TMenuItem;
    mnuAgendamentosProg: TMenuItem;
    RFVDRCO: TMenuItem;
    XMLDIF: TMenuItem;
    SENMNF: TMenuItem;
    N90: TMenuItem;
    mnuGerAvisoEmbarque: TMenuItem;
    mnuCadAliqIBPT: TMenuItem;
    mnuCadMetasVendDepProd: TMenuItem;
    ALTJUR: TMenuItem;
    ALTDES: TMenuItem;
    mnuCadGrupoAtividade: TMenuItem;
    mnuAtividade: TMenuItem;
    N92: TMenuItem;
    mnuCadMetasVendedorAtividade: TMenuItem;
    DTAFIS_IF: TMenuItem;
    N93: TMenuItem;
    mnuCfgCompCusto: TMenuItem;
    N94: TMenuItem;
    mnuAlteracaoTipoAtendPed: TMenuItem;
    mnuCadFaixasVenCndDesc: TMenuItem;
    N95: TMenuItem;
    DESBOP: TMenuItem;
    CNIFNI: TMenuItem;
    mnuManDesIte: TMenuItem;
    SENBAI: TMenuItem;
    CANCGF: TMenuItem;
    METREP: TMenuItem;
    ALITOUVEN: TMenuItem;
    mnuManGarantiaFornecAntEnvio: TMenuItem;
    CANCGR: TMenuItem;
    CANCGC: TMenuItem;
    CANCNG: TMenuItem;
    CANCNR: TMenuItem;
    CANCCR: TMenuItem;
    mnuCadMetasRapel: TMenuItem;
    CANCCS: TMenuItem;
    ALT_FTNFES: TMenuItem;
    CLINCVEN: TMenuItem;
    CLINCVRP: TMenuItem;
    COMPRO: TMenuItem;
    mnuFatOrdemProducaoAvulsa: TMenuItem;
    CFESP: TMenuItem;
    mnuN96: TMenuItem;
    mnuAltValorEntrega: TMenuItem;
    mnuFatConfOrcamentosSiteEmPedidos: TMenuItem;
    ALTPCO: TMenuItem;
    EXCINV: TMenuItem;
    SALINV: TMenuItem;
    SENORC: TMenuItem;
    mnuFatAltComissao: TMenuItem;
    mnuComissaoFaixaDescTabPreco: TMenuItem;
    mnuComissaoFaixaMargemTabPreco: TMenuItem;
    mnuCadFaixaDescTabPreco: TMenuItem;
    mnuCadFaixaMargemTabPreco: TMenuItem;
    COMPRF: TMenuItem;
    COMPRF_DEB: TMenuItem;
    COMPRF_CRE: TMenuItem;
    EMAILPED: TMenuItem;
    mnuImportaNfeParaSped: TMenuItem;
    mnuManifestoEletronico: TMenuItem;
    mnuFatManifestoEletronico: TMenuItem;
    mnuFatManutencaoManifestoEletronico: TMenuItem;
    mnuFatCancelamentoManifestoEletronico: TMenuItem;
    mnuPreparaGerTE: TMenuItem;
    ALTORC: TMenuItem;
    mnuDigGNRE: TMenuItem;
    mnuFatEncerramentoManifestoEletronico: TMenuItem;
    CANCNW: TMenuItem;
    VERCLI: TMenuItem;
    mnuAlteracaoFreteSugestao: TMenuItem;
    mnuAnaliseEstoqueEmExcesso: TMenuItem;
    SAMPRE: TMenuItem;
    LIBVPO: TMenuItem;
    mnuCancelaOrdemProd: TMenuItem;
    VEIMNF: TMenuItem;
    TRFVAL: TMenuItem;
    mnuImportaMovimentoPAFECF: TMenuItem;
    DEMXSE: TMenuItem;
    N96: TMenuItem;
    mnuCRM1: TMenuItem;
    CRMGOC: TMenuItem;
    LayoutsdeImpressodoFaturamento1: TMenuItem;
    mnuGeraVisitaCliente: TMenuItem;
    mnuComissaoManualpeloContasaReceber: TMenuItem;
    mnuFatAltComissaoManualCTR: TMenuItem;
    mnuRelComissaoVendedorManualCTR: TMenuItem;
    frmFatBaixaEntregaFuturaPar: TMenuItem;
    mnuFatConfNotaConcreto: TMenuItem;
    mnuCadDespFaturamento: TMenuItem;
    mnuCadProdutosCndPag: TMenuItem;
    ITECND: TMenuItem;
    LIBCIC: TMenuItem;
    VERCPF: TMenuItem;
    mnuFornecedores1: TMenuItem;
    VEFCPF: TMenuItem;
    mnuRomaneio: TMenuItem;
    N97: TMenuItem;
    mnuControleChqEmi: TMenuItem;
    mnuManutChqEmi: TMenuItem;
    POROPE: TMenuItem;
    CANCD1: TMenuItem;
    BXPDPA: TMenuItem;
    mnuConsultaServicos: TMenuItem;
    COPRTI: TMenuItem;
    mnuManutCustoProdutos: TMenuItem;
    OSMIN: TMenuItem;
    REISEP: TMenuItem;
    EMIFUT: TMenuItem;
    N117: TMenuItem;
    mnuReqMatCon: TMenuItem;
    mnuCadMaterialConsumo: TMenuItem;
    mnuReqMaterialConsumo: TMenuItem;
	mnuEvoVen: TMenuItem;
    mnuCadComplVidro: TMenuItem;
    mnuVendas: TMenuItem;
    CANTFV: TMenuItem;
    CTPEMITBORDERO: TMenuItem;
    mnuDigGNRE_EDIT: TMenuItem;
    mnuCadastros1: TMenuItem;
    EMCLVN: TMenuItem;
    EMCLRP: TMenuItem;
    EMPRVN: TMenuItem;
    mnuDelEst: TMenuItem;
    mnuCtpReprogVen: TMenuItem;
    mnuEditorEtiquetasPrecificacaoProdutos: TMenuItem;
    mnuEditorEtiquetasPreArgox: TMenuItem;
    mnuEditorEtiquetasPreLaser: TMenuItem;
    mnuEtiPrecificacao: TMenuItem;
    ATPRPO: TMenuItem;
    VDHIRO: TMenuItem;
    CTRDESMAX: TMenuItem;
    dxAlertWindow: TdxAlertWindowManager;
    CTPDTARET: TMenuItem;
    imgBotoes: TImageList;
    COMPRF_ALT: TMenuItem;
    pnlEsquerda: TPanel;
    mnuCadGruposUnidade: TMenuItem;
    CNDPRA: TMenuItem;
    mnuRelChqLogAcomp: TMenuItem;
    FCXDPE: TMenuItem;
    Confirmaes1: TMenuItem;
    mnuEntregaFatura: TMenuItem;
    mnuRelCtpLogAcompDuplic: TMenuItem;
    MUDPF9: TMenuItem;
    RELBCA: TMenuItem;
    Liberaprodutoqueultrapassouoprazodagarantia1: TMenuItem;
    AlteraodeContaContbil1: TMenuItem;
    AlteraodeContaContbil2: TMenuItem;
    RelatriodeBocadeCaixaPermissoVendedor1: TMenuItem;
    LiberardevoluodeTintadeMquina1: TMenuItem;
    mnuRelClientesPromocao: TMenuItem;
    CONTFV: TMenuItem;
    RCXLIBRECBOL: TMenuItem;
    AUXCRM: TMenuItem;
    mnuCadFrequenciaCRM: TMenuItem;
    mnuCadPorteCRM: TMenuItem;
    mnuCadFaixaFatuEstimadoCRM: TMenuItem;
    mnuCadForAtuCRM: TMenuItem;
    VDMKGE: TMenuItem;
    VDMKSU: TMenuItem;
    mnuCadAdenFatSer: TMenuItem;
    N98: TMenuItem;
    mnuReqEnvioMatVidro: TMenuItem;
    CHQPENFIN: TMenuItem;
    ALTBOL: TMenuItem;
    REIMPBOLORI: TMenuItem;
    mnCliSujPass: TMenuItem;
    mnuCadMetasCentroCusto: TMenuItem;
    METPEDCTA: TMenuItem;
    EST_DV: TMenuItem;
    mnuCadEquipamentosInd: TMenuItem;
    mnuOPIndMonitoramento: TMenuItem;
    LIBOPEORD: TMenuItem;
    mnuFatPromocaoBrindes: TMenuItem;
    mnuControledeQualidade: TMenuItem;
    mnuCadAnalise: TMenuItem;
    mnuCadAnaliseMov: TMenuItem;
    VALPED: TMenuItem;
    ISCOSE: TMenuItem;
    mnuCadEstruturasIndustrialDF: TMenuItem;
    LIBCONSIM: TMenuItem;
    PermitegerarPDFparaPedidoOrcamento: TMenuItem;
    PermiteenviarPedidoouOramentoporEmail: TMenuItem;
    mnuCtrGeracaoDesCobCheques: TMenuItem;
    CTRCHQ: TMenuItem;
    CANCTL: TMenuItem;
    CANCRQ: TMenuItem;
    CANCTA: TMenuItem;
    ALTCOM: TMenuItem;
    mnuConsultaCxGridNova: TMenuItem;
    mnuConsultaCxGridNovaConfig: TMenuItem;
    mnuConsultaCxGridNovaConfigSQL: TMenuItem;
    mnuConsultaCxGridNovaConfigOperador: TMenuItem;
    mnuConsultarAdiantamentos: TMenuItem;
    DESDIA: TMenuItem;
    mnuWMSLOT: TMenuItem;
    DTAOER: TMenuItem;
    DTAOEP: TMenuItem;
    mnuCartoes: TMenuItem;
    DTAOEB: TMenuItem;
    mnuAltPrecoMedio: TMenuItem;
    SENABA: TMenuItem;
    mnuCadAuxSpedFiscal: TMenuItem;
    mnuCadControleCreditoFiscais: TMenuItem;
    mnuAjusteIcmsST: TMenuItem;
    LIBPREDEV: TMenuItem;
    DOCCOM: TMenuItem;
    mnuDesvalorizacaoProdutos: TMenuItem;
    CNPSEN: TMenuItem;
    mnuReiniciarRoboImportacaoPDV: TMenuItem;
    RCPMSG: TMenuItem;
    RCPMSS: TMenuItem;
    RCPMSV: TMenuItem;
    mnuCadBairros: TMenuItem;
    VLRMIN: TMenuItem;
    MAXUCM: TMenuItem;
    mnuFatAtivaPreRomaneio: TMenuItem;
    ALPRRO: TMenuItem;
    mnuCadLocalizacaoSeparacao: TMenuItem;
    mnuCad800: TMenuItem;
    mnuCadFasObr: TMenuItem;
    mnuFatAltMecanico: TMenuItem;
    EXPDEX: TMenuItem;
    BXENFUDOFI: TMenuItem;
    mnuCadAuxSpedPisCof: TMenuItem;
    mnuPlanodecontascontabeis: TMenuItem;
    IMREIN: TMenuItem;
    PEATMA: TMenuItem;
    LIBCPRCEN: TMenuItem;
    N48: TMenuItem;
    mnuSacMotivosAtend: TMenuItem;
    mnuGeoSales: TMenuItem;
    mnuGeoSalesImportar: TMenuItem;
    mnuGeoSalesExportar: TMenuItem;
    N91: TMenuItem;
    mnuOrdProAtualizaPrecos: TMenuItem;
    ESTPRE: TMenuItem;
    mnuAjusteEstoqueContraPartida: TMenuItem;
    mnuConferenciaPreNotaCancel: TMenuItem;
    ALTVCP: TMenuItem;
    PEDJLB: TMenuItem;
    lcl: TcxLocalizer;
    LIBRES: TMenuItem;
    RABCPR: TMenuItem;
    LIB_F3: TMenuItem;
    LIBCREDIRETO: TMenuItem;
    LIBCREAMAIOR: TMenuItem;
    LIBRECNFIFSEMAUTSEFAZ: TMenuItem;
    LIBRECCREDEXP: TMenuItem;
    IMPEXP: TMenuItem;
    mnuAgruPedOrdProInd: TMenuItem;
    mnuCadPadraQualidadeInd: TMenuItem;
    PEDOPI: TMenuItem;
    mnuCadMotivoReprovacao: TMenuItem;
    mnuConsertodeEquipamentos: TMenuItem;
    mnuCadEquipamentos: TMenuItem;
    mnuCadDefeitos: TMenuItem;
    LCPGFO: TMenuItem;
    N22: TMenuItem;
    mnuLiberaPrepTE: TMenuItem;
    mnuEtqProdutosControlados: TMenuItem;
    mnuEditorEtiquetasProdutosCont: TMenuItem;
    mnuEditorEtiquetasProdutosContArgox: TMenuItem;
    mnuEditorEtiquetasProdutosContLaser: TMenuItem;
    mnuEditorEtiquetasOrdemServico: TMenuItem;
    mnufrmEditorEtiquetasOrdemServicoLaser: TMenuItem;
    mnufrmEditorEtiquetasOrdemServicoArgox: TMenuItem;
    mnuEditorEtiquetasOrdemServicoZebra: TMenuItem;
    CRMMSG: TMenuItem;
    CRM_OR: TMenuItem;
    CRM_PD: TMenuItem;
    ALTSIT: TMenuItem;
    mnuCadProspectos: TMenuItem;
    mnuCadSitOco: TMenuItem;
    mnuFatRomaneioPedidosNaoFaturados: TMenuItem;
    mnuTriggerCRM: TMenuItem;
    mnuControleSepAvulsa: TMenuItem;
    DTACRM: TMenuItem;
    OPNCRM: TMenuItem;
    FLUCRM: TMenuItem;
    BAICRM: TMenuItem;
    CANATI: TMenuItem;
    ALTPDS: TMenuItem;
    ALTPDT: TMenuItem;
    ALTDLC: TMenuItem;
    LIBCFOP: TMenuItem;
    CANCPA: TMenuItem;
    Frete: TMenuItem;
    IMFRDD: TMenuItem;
    mnuFatAlteraTransRomaneio: TMenuItem;
    mnuAltGlobalPromocoes: TMenuItem;
    DIAVEN: TMenuItem;
    HintControler: TcxHintStyleController;
    TITRECREL: TMenuItem;
    SENFOR: TMenuItem;
    N107: TMenuItem;
    N108: TMenuItem;
    N109: TMenuItem;
    N110: TMenuItem;
    N111: TMenuItem;
    N101: TMenuItem;
    mnuManutencaoLoteMP: TMenuItem;
    mnuCadLocFisAmostraProducao: TMenuItem;
    mnuCadParceiros: TMenuItem;
    REIPOP: TMenuItem;
    BXPNFT: TMenuItem;
    mnuImpEtiEmpresa: TMenuItem;
    mnuImpEtiEmpresaSub: TMenuItem;
    mnuImpEtiEmpresaLazer: TMenuItem;
    mnuImpEtiEmpresaArgox: TMenuItem;
    mnuGrupoServicos: TMenuItem;
    mnuCadNegociacaoClientes: TMenuItem;
    TRCLDV: TMenuItem;
    mnuImpressaoCP: TMenuItem;
    LIBF12: TMenuItem;
    CTPALTCTABAI: TMenuItem;
    IMPRF4: TMenuItem;
    mnuClassificacaoCest: TMenuItem;
    BASITE: TMenuItem;
    mnuEditorRelatorios: TMenuItem;
    mnuCadModelosRel: TMenuItem;
    mnuCadRelatorios: TMenuItem;
    mnuCadDirVerdeVermelho: TMenuItem;
    mnuConsultaRelatMenu: TMenuItem;
    mnuTransfLocFisGlobalWMS: TMenuItem;
    DIRRelAltFormaPag: TMenuItem;
    mnuEtiquetaLoteProduto: TMenuItem;
    mnuEtiquetasDeLoteDeProdutos: TMenuItem;
    ALTCCID: TMenuItem;
    ALTCIE: TMenuItem;
    mnuEditorEtiquetasOP: TMenuItem;
    mnuEmailMarketingCliente: TMenuItem;
    mnuProfissionais: TMenuItem;
    FATSXP: TMenuItem;
    CancelarlanamentodecrditoparaclienteCC1: TMenuItem;
    mnuGeraFichaControledeImportacao: TMenuItem;
    N113: TMenuItem;
    mnuFatDesmembrarPedido: TMenuItem;
    mnuExportacaoSEFAZ: TMenuItem;
    mnuImportacaoSEFAZ: TMenuItem;
    mnuImpEtiOrdPro: TMenuItem;
    SETCND: TMenuItem;
    PEDPEN: TMenuItem;
    mnuEtiLoteProdLaser: TMenuItem;
    mnuEtiLoteProdArgox: TMenuItem;
  	mnuRelCtrExportaCobranca: TMenuItem;
    mnuCadTipoAnalise: TMenuItem;
    mnuCadEspecificacoesTecnicas: TMenuItem;
    mnuControleQualidadeProducao: TMenuItem;
    N114: TMenuItem;
    mnuGarantiaBaixaRefugo: TMenuItem;
    mnuManutancaoDescontoEmbalagem: TMenuItem;
    BAQTZE: TMenuItem;
    N102: TMenuItem;
    ALTEM3: TMenuItem;
    SENITR: TMenuItem;
    INFCOB: TMenuItem;
    DIRRCXSALDOMAIORQUEPERMITIDO: TMenuItem;
    mnuCadVenMar: TMenuItem;
    mnuCadCliVen: TMenuItem;
    DIGBARLOC_LOCFIS: TMenuItem;
    DIGBARLOC_CAPLOC: TMenuItem;
    DIGBARLOC_LOCSUP: TMenuItem;
    DIGBARLOC_LOCSEP: TMenuItem;
    DIGBARLOC_LOCADI: TMenuItem;
    DIGBARLOC_EMBALA: TMenuItem;
    TRCCDV: TMenuItem;
    AJUENT: TMenuItem;
    AJUSAI: TMenuItem;
    mnuMovEcfPaf: TMenuItem;
    pnlBotoes2: TPanel;
    btnCadClientes: TcxImage;
    btnCadItens: TcxImage;
    btnMovItens: TcxImage;
    btnFaturamento: TcxImage;
    btnResumoCaixa: TcxImage;
    btnFinanceiro: TcxImage;
    pnlBotoes1: TPanel;
    btnMensagem: TcxImage;
    btnTintaMaquina: TcxImage;
    btnRelFatMetasVendedor_Dir: TcxImage;
    btnDASSuvinil: TcxImage;
    btnPesar: TcxImage;
    btnCRM: TcxImage;
    N103: TMenuItem;
    mnuManutencaoFlex: TMenuItem;
    mnuCadMovFlex: TMenuItem;
    mnuBaixaCreditosFlex: TMenuItem;
    CONFLE: TMenuItem;
    mnuCadMotivoVerbas: TMenuItem;
    mnuCadVerbasCliFor: TMenuItem;
    mnuLogCpr: TMenuItem;
    LIBSEN: TMenuItem;
    STRCST: TMenuItem;
    LIBMOV: TMenuItem;
    DSPDEX: TMenuItem;
    COMVF9: TMenuItem;
    mnuGarantiaGeraCreditos: TMenuItem;
    ICMDES: TMenuItem;
    mnuEntFreConImportacaoSaida: TMenuItem;
    mnuEntFreConImportacaoEntrada: TMenuItem;
    EXF9PD: TMenuItem;
    N104: TMenuItem;
    mnuRelacaoNetpoints: TMenuItem;
    mnuPainelECommerce: TMenuItem;
    mnuCadComboProdVenda: TMenuItem;
    PCRPOP: TMenuItem;
    TREXCP: TMenuItem;
    CNEXCP: TMenuItem;
    PEREXICRED: TMenuItem;
    mnuFaixasCondPagAgr: TMenuItem;
    mnuCtpLiberacaoBaixa: TMenuItem;
    mnuRelVendedores: TMenuItem;
    IMFRSN: TMenuItem;
    VISLIB: TMenuItem;
    ALTPORBOL: TMenuItem;
    CASPRO: TMenuItem;
    N105: TMenuItem;
    N106: TMenuItem;
    N112: TMenuItem;
    N115: TMenuItem;
    N116: TMenuItem;
    CRMVPR: TMenuItem;
    CRMVCL: TMenuItem;
    LIBCOM: TMenuItem;
    CRMCLI: TMenuItem;
    CRMFOR: TMenuItem;
    CRMPRO: TMenuItem;
    mnuEmailMarketingProspectos: TMenuItem;
    mnuImportacaoRetCustodia: TMenuItem;
    mnuBoxEntrega: TMenuItem;
    mnuGeraVisitaClienteIndividual: TMenuItem;
    MEDCOM: TMenuItem;
    SEPAUT: TMenuItem;
    RIMPPARCIAL: TMenuItem;
    ConsultadeProdutos: TMenuItem;
    CUSPRO: TMenuItem;
    mnuCTRReajuste: TMenuItem;
    mnuLogAcompPedidos: TMenuItem;
    VIMASIT: TMenuItem;
    VIMLF4: TMenuItem;
    ALTDTCAD: TMenuItem;
    RFMETCLIREP: TMenuItem;
    CTPALTCTA: TMenuItem;
    mnuCadClientesDesconto: TMenuItem;
    mnuCadRegioesDesconto: TMenuItem;
    mnuCadDescontoClienteProduto: TMenuItem;
    ALTBOLVENC: TMenuItem;
    mnuRelFatDocTinta: TMenuItem;
    CNDICP: TMenuItem;
    Atendimento: TMenuItem;
    OBSCRD: TMenuItem;
	  VENCOMVV: TMenuItem;
    mnuImportacaoCartoes: TMenuItem;
    mnuConciliacaoCartoes: TMenuItem;
    CARCONARQIMP: TMenuItem;
    CARBAIINC: TMenuItem;
    CLCOMP: TMenuItem;
    CLCOBR: TMenuItem;
    CLINFC: TMenuItem;
    CLDADF: TMenuItem;
    CLQDSO: TMenuItem;
    CLRFBA: TMenuItem;
    CLINCR: TMenuItem;
    CLCNDP: TMenuItem;
    CLCONT: TMenuItem;
    CLINVN: TMenuItem;
    mnuRelSimplesNacional: TMenuItem;
    mnuTabelaFatSimples: TMenuItem;
    mnuAntecipacaoDeCartoes: TMenuItem;
    mnuCadEmbarcacoes: TMenuItem;
    CARBAITODOS: TMenuItem;
    TRVF9C: TMenuItem;
    mnuExportacaoCartoes: TMenuItem;
    mnuCadPagBosch: TMenuItem;
    mnuImportaProdFranq: TMenuItem;
    PREPRO: TMenuItem;
    TABPRC: TMenuItem;
    CANCRO: TMenuItem;
    mnuReplicaodeArmazensProdutos: TMenuItem;
    mnuContratosCorreios : TMenuItem;
    mnuManCadCidadeSigep : TMenuItem;
    mnuCadPos: TMenuItem;
    mnuCadAdquirente: TMenuItem;
    ICSTPVVIS: TMenuItem;
    METFRE: TMenuItem;
    ContaCorrente1: TMenuItem;
    LIBPREMED: TMenuItem;
    VRENDU: TMenuItem;
    SENELI: TMenuItem;
    N119: TMenuItem;
    mnuLiberacaoAcompEntregas: TMenuItem;
    LBETAE: TMenuItem;
    Con1: TMenuItem;
    IgnorarLanamentos1: TMenuItem;
    mnuDownloadAutomaticoOFX: TMenuItem;
    Bradesco1: TMenuItem;
    BancodoBrasil1: TMenuItem;
    Ita1: TMenuItem;
    Santader1: TMenuItem;
    Sicredi1: TMenuItem;
    CLIFILFAT: TMenuItem;
    mnuCadFinalidadeAjuste: TMenuItem;
    CFOPF11: TMenuItem;
    TRSALO: TMenuItem;
    mnuRelCartoesLogAcomp: TMenuItem;
    RVNFOS: TMenuItem;
    mnuImportPrecoVendaTabPrecoConfirma: TMenuItem;
    mnuIndustrial: TMenuItem;
    mnuFormulas: TMenuItem;
    mnuOrdemProducaoInd: TMenuItem;
    N122: TMenuItem;
    mnuControledeQualidadeInd: TMenuItem;
    N123: TMenuItem;
    mnuManOrdProIndustrial: TMenuItem;
    mnuBaixaOrdProdIndustrial: TMenuItem;
    mnuCancelaOrdemProdIndustrial: TMenuItem;
    N124: TMenuItem;
    N126: TMenuItem;
    N127: TMenuItem;
    mnuAjustesIcms: TMenuItem;
    RIMPSE: TMenuItem;
    mnuCadTemplates: TMenuItem;
    mnuCadAjuRelatorio: TMenuItem;
    mnuCadInstrucoes: TMenuItem;
    mnuRelGarantia: TMenuItem;
    mnuTransfCodPortador: TMenuItem;
    mnuTransfCodTransportadora: TMenuItem;
    RECTRE: TMenuItem;
    SLRQPV: TMenuItem;
    CARALTTODAS: TMenuItem;
    mnuImportCadProduto: TMenuItem;
    mnuImportCadEstrutura: TMenuItem;
    GRCDPR: TMenuItem;
    RENAUT: TMenuItem;
    LIBBXVI: TMenuItem;
    ArquivamentodeDocumentos1: TMenuItem;
    LIBERSF: TMenuItem;
    CLPROF: TMenuItem;
    BAIDUPJUR: TMenuItem;
    RCXDESMA2: TMenuItem;
    CTRSJU: TMenuItem;
    SENJM1: TMenuItem;
    SENJM2: TMenuItem;
    SENJM3: TMenuItem;
    CTRDESMA2: TMenuItem;
    mnuDigSerieProdRastreaveis: TMenuItem;
    ORCVBL: TMenuItem;
    MDFEMP: TMenuItem;
    CONDIR: TMenuItem;
    mnuRestituicaoIcmsST: TMenuItem;
    CANSAL: TMenuItem;
    VDMKRP: TMenuItem;
    VDMKVC: TMenuItem;
    VDMKVN: TMenuItem;
    ALCOSD: TMenuItem;
    mnuFatAltEmbarcacao: TMenuItem;
    VDACEN: TMenuItem;
    DESPRO: TMenuItem;
    PROMARNEG: TMenuItem;
    N120: TMenuItem;
    SEMCOM: TMenuItem;
    mnuExportaXMLNotasRomaneio: TMenuItem;
    mnuCadFatMetasVendedorFatLiq: TMenuItem;
    N920: TMenuItem;
    mnuCadAgendamentodeEntrega: TMenuItem;
    mnuRecebimentoEntregaAgendada: TMenuItem;
    mnuPlanoDeRecebimento: TMenuItem;
    mnuManutencaoDocas: TMenuItem;
    mnuCadDocas: TMenuItem;
    mnuImpEtiLocalizacao: TMenuItem;
    mnuEtiquetasDeLocalizacaoFisica: TMenuItem;
    mnuEtiLocFisLaser: TMenuItem;
    mnuEtiLocFisArgox: TMenuItem;
    mnuEtiquetasPlanoRecebimento: TMenuItem;
    mnuEtiquetasPlanoRecebimentoLaser: TMenuItem;
    mnuEtiquetasPlanoRecebimentoArgox: TMenuItem;
    mnuEtiquetasSeqSeparacaoWMS: TMenuItem;
    mnuEtiquetasSeqSeparacaoWMSLaser: TMenuItem;
    mnuEtiquetasSeqSeparacaoWMSArgox: TMenuItem;
    mnuEntMercadoriasEfetivaMovFiscal: TMenuItem;
    mnuCadClasseLocFis: TMenuItem;
    mnuMapeamentoItemClasseLocFis: TMenuItem;
    mnuBaixaVolumes: TMenuItem;
    TRODIR: TMenuItem;
    mnuCadEquLocacao: TMenuItem;
    mnuLocacaoEquip: TMenuItem;
    mnuContratLocacao: TMenuItem;
    mnuInspLibEquip: TMenuItem;
    mnuEnvioEquip: TMenuItem;
    mnuRetornoEquip: TMenuItem;
    mnuFatLocEquip: TMenuItem;
    CNDSEN: TMenuItem;
    mnuLocacaoEquipamentos: TMenuItem;
    CMSGER: TMenuItem;
    CMSSUB: TMenuItem;
    FolhadePagamento1: TMenuItem;
    GeraodoContasaPagar1: TMenuItem;
    mnuControleDeEstoqueCat1799: TMenuItem;
    mnuEditorEtiquetasOPLaser: TMenuItem;
    mnuEditorEtiquetasOPLaserArgox: TMenuItem;
    mnuEditorEtiquetasOPLaserZebra: TMenuItem;
    mnuRelConsertoEquipamentos: TMenuItem;
    CLCDCB: TMenuItem;
    TRCLVD: TMenuItem;
    ZEROKM: TMenuItem;
    SEMCON: TMenuItem;
    mnuManutInventarioLote: TMenuItem;
    mnuEditorEtiquetasCaixas: TMenuItem;
    mnuEditorEtiquetasCaixasArgox: TMenuItem;
    mnuEditorEtiquetasCaixasLaser: TMenuItem;
    mnuEtiquetaCaixas: TMenuItem;
    mnuOrdemServicoProdVenda: TMenuItem;
    mnuReimpEtiOrdServico: TMenuItem;
    mnuOcorrenciasRomaneio: TMenuItem;
    mnuRelFatEtiArmazenamento: TMenuItem;
    mnuEtiquetasArmazenamento: TMenuItem;
    mnuEtiquetasArmazenamentoLaser: TMenuItem;
    mnuEtiquetasArmazenamentoArgox: TMenuItem;
    mnuCadBoxWms: TMenuItem;
    btnConferenciaLocFis: TMenuItem;
    PESEXD: TMenuItem;
    mnuConsultaPedidosPend: TMenuItem;
    DCVINC: TMenuItem;
    EXCITEREQCOM: TMenuItem;
    EXCITESOLABS: TMenuItem;
    mnuControleRotasRegiao: TMenuItem;
    mnuLiberacaoTransferenciaArmazem: TMenuItem;
    mnuRotasRegiao: TMenuItem;
    mnuEntregasRegiao: TMenuItem;
    EXEHMP: TMenuItem;
    EXEHFR: TMenuItem;
    PERFAD: TMenuItem;
    mnuCadEpi: TMenuItem;
    DTCADINF: TMenuItem;
    mnuCalNivCriEst: TMenuItem;
    mnuGrupoRisco: TMenuItem;
    GRURIS: TMenuItem;
    LMCROP: TMenuItem;
    mnuGerAutCtaReceber: TMenuItem;
    OSALTC: TMenuItem;
    OSALDG: TMenuItem;
    PEDMIN: TMenuItem;
    mnuLiberacaoPedidos: TMenuItem;
    mnuLibPedVisualizarMargemECusto: TMenuItem;
    UTDTFA: TMenuItem;
    UTDTEN: TMenuItem;
    mnuOrdProdGeracaoAutomaticaEstoque: TMenuItem;
    DIRRCXEST: TMenuItem;
    mnuEtiqOrdSerVenda: TMenuItem;
    mnuEtiqOrdSerVendaLaser: TMenuItem;
    mnuEtiqOrdSerVendaArgox: TMenuItem;
    mnuEtiqOrdSerVendaZebra: TMenuItem;
    CANCNP: TMenuItem;
    mnuAltVendTemp: TMenuItem;
    PFPOPA: TMenuItem;
    PEBACF: TMenuItem;
    mnuRELOPI: TMenuItem;
    ORDGER: TMenuItem;
    SLD_OI: TMenuItem;
    SLD_COR: TMenuItem;
    BXOIDV: TMenuItem;
    RESIOI: TMenuItem;
    OIACOM: TMenuItem;
    LANAOI: TMenuItem;
    mnuRELOPR: TMenuItem;
    mnuPreNotaCancel: TMenuItem;
    N155: TMenuItem;
    N154: TMenuItem;
    mnuFatDevolucaoEspecial: TMenuItem;
    VALORC: TMenuItem;
    mnuRelCtpTitContasAno: TMenuItem;
    mnuRelEstatAbcClientes: TMenuItem;
    btnDisponibilizarLocFis: TMenuItem;
    btnRegularizaLocFis: TMenuItem;
    CUSSPR: TMenuItem;
    CNCOPI: TMenuItem;
    EXCOPI: TMenuItem;
    mnuTransCodCorIndustrial: TMenuItem;
    LOGINBVES: TMenuItem;
    CONSULTASCPCSOPHUS: TMenuItem;
    CONSULTASPC: TMenuItem;
    mnuVendaClienteTodasEmpresas: TMenuItem;
    mnuManGerAutCtaPagar: TMenuItem;
    CTPALTGERAUT: TMenuItem;
    mnuRelCatalogoLinhaGrupo: TMenuItem;
    mnuRelCatalogoProduto: TMenuItem;
    INTPAR: TMenuItem;
    mnuCadFaixaPrzMed: TMenuItem;
    PEACVI: TMenuItem;
    PEACVE: TMenuItem;
    PEACVD: TMenuItem;
    PRZMED: TMenuItem;
    mnuLibVendasEntrega: TMenuItem;
    SELMBR: TMenuItem;
    CONCRE: TMenuItem;
    IBLSEP: TMenuItem;
    MAIMAX: TMenuItem;
    mnuVisualizarFormulcaoTMQ: TMenuItem;
    CANCEF: TMenuItem;
    mnuEtiquetasSeparacaoErrada: TMenuItem;
    mnuEtiquetasSeparacaoErradaLaser: TMenuItem;
    mnuEtiquetasSeparacaoErradaArgox: TMenuItem;
    mnuSpoolTransferenciaEdicao: TMenuItem;
    PERITE: TMenuItem;
    ORPDVN: TMenuItem;
    ACACRM: TMenuItem;
    PermitirIgnorarRecomporLanamentosExtrato1: TMenuItem;
    ALTFRE: TMenuItem;
    mnuEditorEtiquetasMontagemCaixas: TMenuItem;
    LBQTMX: TMenuItem;
    mnuCadFreteFaixaFaturamento: TMenuItem;
    mnuFatSATComplementar: TMenuItem;
    N51: TMenuItem;
    mnuConfirmaEspelho: TMenuItem;
    mnuEfetivacaoOutrasSaidasGarantiaEnvioFornecedor: TMenuItem;
    MANESP: TMenuItem;
    EXPESP: TMenuItem;
    EMIESP: TMenuItem;
    mnuContabilidade: TMenuItem;
    mnuGeracaoPedidoTransferenciaAberturaNovaEmpresa: TMenuItem;
    HerdarMsBase1: TMenuItem;
    NFPRCU: TMenuItem;
    ALTVPR: TMenuItem;
    GRUCOM: TMenuItem;
    DELESP: TMenuItem;
    IMPESP: TMenuItem;
    mnuEntConferPreNotaWMSDevolucao: TMenuItem;
    VALCBE: TMenuItem;
    btnMovLote: TMenuItem;
    PermitirEfetuarLanamentodeAjustedeSaldoparaoPortadordoExtrato1: TMenuItem;
    LiberarrastreamentonoF4daAcompanhamentodePedidos1: TMenuItem;
    fraPesquisarMenu: TfraPesquisarMenu;
    pnlBaixo: TPanel;
    btnSair: TcxImage;
    btnConfiguracoes: TcxImage;
    btnEnvioEmail: TcxImage;
    imgLogoDark: TImage;
    DVPJSI: TMenuItem;
    mnuBalancoIniciaArmazem: TMenuItem;
    mnuBalancoFinalizaArmazem: TMenuItem;
    F10TRA: TMenuItem;
    mnuLiberacaoLocalizacaoFisicaColetor: TMenuItem;
    VIIMF4: TMenuItem;
    mnuImpRecCobranca: TMenuItem;
    REATIV: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    mnuMapeamentoLocalizacaoFisica: TMenuItem;
    EXBCEX: TMenuItem;
    EXBCRO: TMenuItem;
    BXACTRA: TMenuItem;
    mnuLOGAlteraesEndereodeEntrega: TMenuItem;
    mnuLiberaodePedidosExternos: TMenuItem;
    ENTURG: TMenuItem;
    VSEWMS: TMenuItem;
    ALTPEDEXP: TMenuItem;
    ALTPEDBOLADT: TMenuItem;
    mnuEntradaAutomatizadaNotas: TMenuItem;
    mnuFatAltLoteItem: TMenuItem;
    DEVPROD: TMenuItem;
    mnuCadBeneficioFiscal: TMenuItem;
    N121: TMenuItem;
    CLICON: TMenuItem;
    CLENET: TMenuItem;
    CLRFCM: TMenuItem;
    CLRLCP: TMenuItem;
    CLRLDP: TMenuItem;
    CLVEIC: TMenuItem;
    CLIVIS: TMenuItem;
    CLIPRO: TMenuItem;
    CLBRAT: TMenuItem;
    CLIFAZ: TMenuItem;
    CLEMBA: TMenuItem;
    CLDTCT: TMenuItem;
    METVNCTR: TMenuItem;
    EPCTMC: TMenuItem;
    ALTFORBAICOMPROF: TMenuItem;
    mnuInativarLotesSemSaldo: TMenuItem;
    OENCTP: TMenuItem;
    mnuRelFatFichaTecnicaProdutosOrcamento: TMenuItem;
    mnuFatRomaneioLoteSeparacao: TMenuItem;
    ATPROR: TMenuItem;
    CTPALTCOMP: TMenuItem;
    mnuFiscal: TMenuItem;
    TABPREITE: TMenuItem;
    PLACON: TMenuItem;
    SENEQU: TMenuItem;
    ULTVND: TMenuItem;
    VDSIAN: TMenuItem;
    MNTCMS: TMenuItem;
    ENRROM: TMenuItem;
    ENPROM: TMenuItem;
    ENRTOT: TMenuItem;
    INFPCI: TMenuItem;
    OBCLVD: TMenuItem;
    ALEITE: TMenuItem;
    ALEITG: TMenuItem;
    ALMITE: TMenuItem;
    ALTCOTDOL: TMenuItem;
    REQIMP: TMenuItem;
    HISVEI: TMenuItem;
    LOFIPR: TMenuItem;
    CSTSER: TMenuItem;
    TRPROR: TMenuItem;
    VIPRIM: TMenuItem;
    INVDPE: TMenuItem;
    IMITOD: TMenuItem;
    CAEQOS: TMenuItem;
    MTITAM: TMenuItem;
    OSECMV: TMenuItem;
    mnuBPRQPC: TMenuItem;
    CRMPMN: TMenuItem;
    CRMBOC: TMenuItem;
    CRMBOR: TMenuItem;
    CRMPED: TMenuItem;
    CRMEMA: TMenuItem;
    CRMRAD: TMenuItem;
    CRMROC: TMenuItem;
    CRMGGO: TMenuItem;
    CRMRSV: TMenuItem;
    CRMMEN: TMenuItem;
    CRMOCN: TMenuItem;
    CRMVEC: TMenuItem;
    CRMFCA: TMenuItem;
    CRMVAC: TMenuItem;
    CRMVCC: TMenuItem;
    CONOPD: TMenuItem;
    CRMLOC: TMenuItem;
    CRFPME: TMenuItem;
    CRFBOC: TMenuItem;
    CRFLOC: TMenuItem;
    CRFROC: TMenuItem;
    CRFMEN: TMenuItem;
    CONOPO: TMenuItem;
    F7DESF11: TMenuItem;
    CRMGBV: TMenuItem;
    CRMGBR: TMenuItem;
    ALTECF: TMenuItem;
    EXPRTD: TMenuItem;
    EXPRAT: TMenuItem;
    mnuRPNLBXRM: TMenuItem;
    mnumportarArquivoParaAnalisedeCompras: TMenuItem;
    mnuEtiquetasCodBarrasProdutoExpedicao: TMenuItem;
    mnuEtiquetasCodBarrasProdutoExpedicaoLaser: TMenuItem;
    mnuVendaForadoEstabelecimento: TMenuItem;
    mnuVendaRemessaForadoEstabelecimentoRemessa: TMenuItem;
    mnuVendaRemessaForadoEstabelecimentoRetorno: TMenuItem;
    mnuVendaRemessaForadoEstabelecimentoFaturamento: TMenuItem;
    mnuPermitirNovoRomaneioPLP: TMenuItem;
    mnuDigRecursosProjeto: TMenuItem;
    mnuProjeto: TMenuItem;
    mnuCadProjetos: TMenuItem;
    mnuCadRecursoProjeto: TMenuItem;
    mnuPermitirAlterarDataMovimentacaoBancaria: TMenuItem;
    CONFRM: TMenuItem;
    ETPDRM: TMenuItem;
    ETRERM: TMenuItem;
    DIDEGA: TMenuItem;
    RIDCRM: TMenuItem;
    OUTERM: TMenuItem;
    DCEXRM: TMenuItem;
    ACENRM: TMenuItem;
    FERROM: TMenuItem;
    LPSPRM: TMenuItem;
    AppCitelGestor: TMenuItem;
    app_liberacoes: TMenuItem;
    app_faturamento: TMenuItem;
    app_estoque: TMenuItem;
    app_pagar: TMenuItem;
    app_receber: TMenuItem;
    app_fat_operador: TMenuItem;
    mnuImpKoncilia: TMenuItem;
    mnuConciliaoKoncilia: TMenuItem;
    mnuEditorEtiquetasDespachoLaserECommerce: TMenuItem;
    IMPDCP: TMenuItem;
    PERBAIFOR: TMenuItem;
    mnuAtualizacaoCotacaoDolarNosCatalogos: TMenuItem;
    mnuCadMatrizAliquotasIcms: TMenuItem;
    mnuCadMatrizAliquotasFCP: TMenuItem;
    mnuCadNCM: TMenuItem;
    mnuManutencaoEmpresaCentralizadora: TMenuItem;
    CadastrodeProdutoLote1: TMenuItem;
    mnuSubServicos: TMenuItem;
    mnuCodigoTipodeServico: TMenuItem;
    mnuCadProdutosAltoGiro: TMenuItem;
    LIMSEP: TMenuItem;
    NOVOBSROM: TMenuItem;
    LIMOBSROM: TMenuItem;
    ALTCOMPCTP: TMenuItem;
    CTRDTARET: TMenuItem;
    CTRALTVALDUP: TMenuItem;
    mnuRestauraDuplicataMercantil: TMenuItem;
    mnuCadMetasVendLinhaGrupoProd: TMenuItem;
    mnuControledeCanhotosdeNotasFiscaisEmitidas: TMenuItem;
    LIBCHT: TMenuItem;
    mmuCadMetasCobranca: TMenuItem;
    mnuEtiquetasLoteRastreamentoProduto: TMenuItem;
    mnuEtiquetasLoteRastreamentoProdutoLaser: TMenuItem;
    mnuEtiquetasLoteRastreamentoProdutoArgox: TMenuItem;
    mnuEtiquetasLoteRastreamentoProdutoZebra: TMenuItem;
    mnuProdutoCadastroRapidoLoteRastreamento: TMenuItem;
    mnuLoteRastreamentoProduto: TMenuItem;
    btnConferenciaOrdemProducaoIndustrialMateriaPrima: TMenuItem;
    btnConferenciaOrdemProducaoIndustrialEnvase: TMenuItem;
    CEVOPI: TMenuItem;
    mnuDigAtualizaPreco: TMenuItem;
    ISLTRA: TMenuItem;
    mnuFatManifestoEletronicoEncerrados: TMenuItem;
    CRMVDN: TMenuItem;
    CRM_VN: TMenuItem;
    mmuRelCbaLogAcompMovBanNovo: TMenuItem;
    LBTRCL: TMenuItem;
    LBTRCP: TMenuItem;
    CANLOCEQU: TMenuItem;
    mnuManutencaoEmpresasDestinoMultiLojas: TMenuItem;
    mnuEnvioConfirmacaoSefaz: TMenuItem;
    CRMPRM: TMenuItem;
    mnuEntImportaNotaEletDivFiscal: TMenuItem;
    QTDMTP: TMenuItem;
    GRULCP: TMenuItem;
    SEALV2: TMenuItem;
    mnuUltimosFechamentosEstoque: TMenuItem;
    mnuUltimosFechamentosFiscais: TMenuItem;
    mnuPermitirRecCtrExpPen: TMenuItem;
    PDGXML: TMenuItem;
    mnuCadFreteTranspRegiao: TMenuItem;
    EXLICR: TMenuItem;
    LIBHOR: TMenuItem;
    mnuCadConcorrencia: TMenuItem;
    mnuFluxoCompras: TMenuItem;
    ALTPFI: TMenuItem;
    ALTPJU: TMenuItem;
	  mnuStatusOrcamentoSistemaDEPS: TMenuItem;
    mnuQualificaodeClientes: TMenuItem;
    mnuCategoriaOrcamentoPedido: TMenuItem;
    MSGEXP: TMenuItem;
    CANBAI: TMenuItem;
    FechamentoFinanceiro2: TMenuItem;
    mnuCadFaixaDescTabPrecoLinhaGrupo: TMenuItem;
    PermitirExcluirFechamentoFinanceiro1: TMenuItem;
    PermitirIncluirFechamentoFinanceiro1: TMenuItem;
    mnuFechamentoFinanceiro: TMenuItem;
    LIBLANCXOPE: TMenuItem;
    mnuBreak: TMenuItem;
    CRMLIMSEP: TMenuItem;
    mnuAtivaoeInativaodeNFCeOffLine1: TMenuItem;
    PRODLIMSEP: TMenuItem;
    mnuPermitirAlterarValorDaGarantia: TMenuItem;
    mnuCadCaixas: TMenuItem;
    N58: TMenuItem;
    mnuRcxTransfLancamentosEntreCaixas: TMenuItem;
    LIBCTPPREV: TMenuItem;
    mnuCtpLiberacaoPrevisao: TMenuItem;
    mnuiLimparSeparacaoComTransitoria: TMenuItem;
    btnConferenciaDeLocalizacaoPorDemanda: TMenuItem;
    mnuCadCnae: TMenuItem;
    CANDPA: TMenuItem;
    MODCAT: TMenuItem;
    mnuComissaFaixaFaturamentoMecanicoServicos: TMenuItem;
    mnuCadComFat2: TMenuItem;
    CLIEND: TMenuItem;
    CLINUM: TMenuItem;
    CLICEP: TMenuItem;
    CLICOM: TMenuItem;
    CLIBAI: TMenuItem;
    CLICID: TMenuItem;
    CLI_IE: TMenuItem;
    CLIMUN: TMenuItem;
    CLINRE: TMenuItem;
    CLINCI: TMenuItem;
    PMFRDEFXAF: TMenuItem;
    mnuConsolidacaoDeAdiantamentoDeValores: TMenuItem;
    CLI_PR: TMenuItem;
    CLIMEI: TMenuItem;
    mnuCadMetasFaturamentoServicoPorFaixa: TMenuItem;
    mnuFatReg: TMenuItem;
    DIRRCXCCREC: TMenuItem;
    PERBAI: TMenuItem;
    mnuDigTCIF: TMenuItem;
    mnuDigTS: TMenuItem;
    mnuDigTCIF_EDIT: TMenuItem;
    mnuDigTS_EDIT: TMenuItem;
    CTRALTVENDUP: TMenuItem;
    mmoRecManualBolAdt: TMenuItem;
    mnuPermitirExcluirMovimentacaoBancaria: TMenuItem;
    mnuFatManConsertoEquipTec: TMenuItem;
    CTPALTALLPARC: TMenuItem;
    mnufrmCadFuncoes: TMenuItem;
    mnuMontQuadroFuncEvento: TMenuItem;
    mnuCadEmpresasEstoqueExterno: TMenuItem;
    mnuMandaeEnvioEncomendas: TMenuItem;
    LIBLANRCXDIV: TMenuItem;
    LIBRCXSEMLAC: TMenuItem;
    N74: TMenuItem;
    mnuRcxLiberacaoDeCaixas: TMenuItem;
    LIBRCXLIBCAX: TMenuItem;
    mnuBotesPrincipal: TMenuItem;
    mnuAjusteEstoqueSaldoExterno: TMenuItem;
    mnuEnviaEmail: TMenuItem;
    mnuMensagensRecebidas: TMenuItem;
    ATIDESPRM: TMenuItem;
    LXMLAD: TMenuItem;
    CLIPOR: TMenuItem;
    CLIPO2: TMenuItem;
    EDSUAD: TMenuItem;
    PCRCPB: TMenuItem;
    CALIEF: TMenuItem;
    mnuAlteracaoGlobalProdutosAcabados: TMenuItem;
    mnuCadCupomPromProd: TMenuItem;
    ENVCONSIGNACAO: TMenuItem;
    mnuFatManifestoEletronicoEventoPagamentoOperacaoTransporte: TMenuItem;
    mnuAlteracaoGeraldePrecosdeProdutos: TMenuItem;
    mnuPermitirAlterarLimiteCreditoCliente: TMenuItem;
    EXNTCO: TMenuItem;
    mnuEntradaAutomatizadaImportacao: TMenuItem;    
    PERMITEREQCOM: TMenuItem;
    LIBDTAENTMESANT: TMenuItem;
    btnSeparacaoAvulsa: TMenuItem;
    LTESMI: TMenuItem;
    mnuPermitirDevolucaoFreteSuperiorDocumentosOriginais: TMenuItem;
    TRDESANA: TMenuItem;
    mnuPermitirAlterarDataEntrega: TMenuItem;
    mnuCadGPC: TMenuItem;
    N125: TMenuItem;
    mnuGerarGTINAtualizarCadastroGS1CNP: TMenuItem;
    VARPRE: TMenuItem;
    ALTFREOFGF: TMenuItem;
    mnuRelMapaDeCaontagem: TMenuItem;
    SITEQP: TMenuItem;
    frmNotasFulfillmentPat: TMenuItem;
    LIBRECCREDABE: TMenuItem;
    DESEXP: TMenuItem;
    PERDEVENTF: TMenuItem;
    PERBFPASFRE: TMenuItem;
    mnuCadAtributos: TMenuItem;
    mnuCadGrupoAtributo: TMenuItem;
    mnuAlteraCheckboxInformarQuantidade: TMenuItem;
    mnuCadLocalArmazenamentoWMS: TMenuItem;
    mnuEtiquetasLocalArmazenamentoWMS: TMenuItem;
    mnuEtiquetasLocalArmazenamentoWMSArgox: TMenuItem;
    mnuEtiquetasLocalArmazenamentoWMSLaser: TMenuItem;
    mnuImpEtiLocalArmazenamentoWms: TMenuItem;
    mnuEtiquetasRegioes: TMenuItem;
    mnuEtiquetasRegioesArgox: TMenuItem;
    mnuEtiquetasRegioesLaser: TMenuItem;
    mnuImpEtiRegiao: TMenuItem;
    CORFAT: TMenuItem;
    LIBDTAENTMENORDTADOC: TMenuItem;
    mnuCadMatrizBasesDifal: TMenuItem;
    MABADI: TMenuItem;
    mnuFatTransfEstDevEmpCarregamento: TMenuItem;
    mnuPermitirAlterarDataEntregaPedido: TMenuItem;
    PERINTFATCON: TMenuItem;
    LCRCLIOPE: TMenuItem;
    Permitirvincularrecursosidependentedooperador1: TMenuItem;
    mnubtnReiniciarContagemProduto: TMenuItem;
    mnubtnReiniciarContagemTotal: TMenuItem;
    BtnSeparaItemComDivergencia: TMenuItem;
    FINALIZAMAPADIV: TMenuItem;
    mnuMatrizCadNovosProdutos: TMenuItem;
    EQUVBL: TMenuItem;
    mnuConsertoEquipamentos: TMenuItem;
    ALTCOMINT: TMenuItem;
    EXCCOMINT: TMenuItem;
    mnuTransCodPlacaVeiculo: TMenuItem;
    DIRRCXTROCO: TMenuItem;
    mnuDashboard: TMenuItem;
    ECORCE: TMenuItem;
    N128: TMenuItem;
    mnuRelacionamentoClienteProdutoGarantia: TMenuItem;
    SEAUPE: TMenuItem;
    SEDIPE: TMenuItem;
    mnuPrioridadeSaidaEstoqueEmpresa: TMenuItem;
    SEDIP2: TMenuItem;
    SEAUP2: TMenuItem;
    CANCCT: TMenuItem;
    PERALTFRETEFRENET: TMenuItem;
    mmuRelCtrReceber: TMenuItem;
    mnuManutencaoCte: TMenuItem;
    mnuCadComissaoProdTabPre: TMenuItem;
    mnuAbaVendedor: TMenuItem;
    mnuAbaLojas: TMenuItem;
    PERDMP: TMenuItem;
    mnuDashboardAbas: TMenuItem;
    TOMSRV: TMenuItem;
    mnuCadSinaleiroFaturamento: TMenuItem;
    AMOREMCONORD: TMenuItem;
    btnRomaneio: TMenuItem;
    btnMovimentaLoteCritico: TMenuItem;
    btnOrdemdeProducaoIndustrial: TMenuItem;
    btnLimpaConferenciaMateriaPrima: TMenuItem;
    btnLimpaConferenciaEnvase: TMenuItem;
    limpaOrdemProducao: TMenuItem;
    LSRALTDTENT: TMenuItem;
    mnuCadPendencias: TMenuItem;
    PREDEF: TMenuItem;
    mnuAltGlobalVenMar: TMenuItem;
    mnuMovimentacaoBancaria: TMenuItem;
    mnuTransferenciaEstoque: TMenuItem;
    mnuLogs: TMenuItem;
    mnuSenhaLiberacao: TMenuItem;
    mnuDireitosDeAcesso: TMenuItem;
    mnuFatRomaneioManutencao: TMenuItem;
    btnFinalizaConferenciaComDivergencia: TMenuItem;
    CTPBXPARCFUNC: TMenuItem;
    mnuProdutos: TMenuItem;
    RCXCANCTEF: TMenuItem;
    mnuCadCfgTerminalTef: TMenuItem;
    CARCANCEFET: TMenuItem;
    SAREEN: TMenuItem;
    Permitirvisualizarasinformaeseasmargensmarkupsutilizadasnadefiniodosinaleirodofaturamento1: TMenuItem;
    ALSETE: TMenuItem;
    ALDENT: TMenuItem;
    mnuFaixasCondPagGeraNotaDebito: TMenuItem;
    CFGCON: TMenuItem;
    mnuFatBaixaEntregaFutura49: TMenuItem;
    CARALTVLSTX: TMenuItem;
    CARALTTXVLADM: TMenuItem;
    CARALTVLDOC: TMenuItem;
    mnuReimpReciboComissaoProfissionais: TMenuItem;
    mnuEditorEtiquetasIteArgGondCPreLayout1: TMenuItem;
    mnuCtrReprogVen: TMenuItem;
    mnuCadCotacaoRelac: TMenuItem;
    SEMTRA: TMenuItem;
    mnuTransferenciaArmazens: TMenuItem;
    TACAPMAXDES: TMenuItem;
    CNLFLX: TMenuItem;
    mnuCadAcessorios: TMenuItem;
    mnuCadEstProduto: TMenuItem;
    mnuFatManConsertoFluxoProcesso: TMenuItem;
    mnuConEquFluxoProcesso: TMenuItem;
    FLXCLI: TMenuItem;
    FLXCOS: TMenuItem;
    FLXIMP: TMenuItem;
    FLXETI: TMenuItem;
    FXTDEV: TMenuItem;
    FXHSTA: TMenuItem;
    FXDOCF: TMenuItem;
    FLXDPS: TMenuItem;
    FLXORC: TMenuItem;
    FLXAPR: TMenuItem;
    FLXREP: TMenuItem;
    FLXMAN: TMenuItem;
    FLXFIN: TMenuItem;
    FLXRET: TMenuItem;
    FLXNOS: TMenuItem;
    CFGGNR: TMenuItem;
    ALTCERTINT: TMenuItem;
    ALTCHAVEAUTAPIBB :TMenuItem;

    mnuCadFaixasCatEtiqProduto: TMenuItem;
    mnuCadTiposCotacaoPedidoCompra: TMenuItem;
    mnuCadCentroCustoImobilizado: TMenuItem;
    mnuTransfCodAcessorio: TMenuItem;
    N67: TMenuItem;
    mnuPromocaoAutCadastro: TMenuItem;
    mnuPromocaoAutAtivacao: TMenuItem;
    PVISPF: TMenuItem;
    SEPCPD: TMenuItem;
    mnuRestauraPreco: TMenuItem;
    mnuCadFasApontamento: TMenuItem;
    FLXAPO: TMenuItem;
    FLXCNS: TMenuItem;
    PERDEM: TMenuItem;
    LIFLNE: TMenuItem;
    DIRRCXCTPRC: TMenuItem;
    N129: TMenuItem;
    mnuReiniciarRoboImportacaoCTe: TMenuItem;
    LSRACECONEX: TMenuItem;
    mnuFatDigitalizacaoDocumentos: TMenuItem;
    MOVDIG: TMenuItem;
    mnuNegociacaoOrdemServico: TMenuItem;
    QMDPEI: TMenuItem;
    RMVPRE: TMenuItem;
    btnConfValidadeForaPrazo: TMenuItem;
    pastaConferenciaEntrada: TMenuItem;
    pastaConferenciaSaida: TMenuItem;
    pastaSeparao: TMenuItem;
    pastaDespacho: TMenuItem;
    pastaOrdemProducaoIndustrial: TMenuItem;
    pastaEstoque: TMenuItem;
    mnuEquLocacao: TMenuItem;
    mnuCadAclLocacao: TMenuItem;
    mnuLocacaoEquipamentos1: TMenuItem;
    EQUSIT: TMenuItem;
    ITEINA: TMenuItem;
    PASARC: TMenuItem;
    CTRBOLADI: TMenuItem;
    FLXENV: TMenuItem;
    FLXINO: TMenuItem;
    FLXCRE: TMenuItem;
    FLXRMA: TMenuItem;
    FLXINM: TMenuItem;
    LOCVM1: TMenuItem;
    LOCVM2: TMenuItem;
    LOCVM3: TMenuItem;
    mnuCadLocalDaMercadoria: TMenuItem;
    mnuConsultaControleDeColeta: TMenuItem;
    LOCIPS: TMenuItem;
    LOCIPE: TMenuItem;
    CARAJUVALCON: TMenuItem;
    DELUNIDUPBOLADT: TMenuItem;
    BalancoDeEstoque: TMenuItem;
    LIBCONTFINAL: TMenuItem;    
    FXREAF: TMenuItem;
    PEVEPB: TMenuItem;
    mnuEditorEtiquetasMontagemCaixasLaser: TMenuItem;
    mnuEditorEtiquetasMontagemCaixasLaserComCodBarras: TMenuItem;
    LOCACD: TMenuItem;
    LOCENC: TMenuItem;
    LOCDSF: TMenuItem;
    mnuTipoImobilizado: TMenuItem;
    mnuCadImobilizado: TMenuItem;
    mnuCadDescontoClientesMarcas: TMenuItem;
    popLocacaoEquipamento: TAdvPopupMenu;
    btnLocacaoEquipamento: TcxImage;
    mnuLibLocEquip: TMenuItem;
    VNDPGT: TMenuItem;
    mnuMenuFiscalPafNFCe: TMenuItem;
    FXOSFA: TMenuItem;
    mnuCadCondPagtoEspecialProdutos: TMenuItem;
    CTPEMC: TMenuItem;
    mnuMovimentacaoProgramadaManual: TMenuItem;
    mnuTrocaLocEqu: TMenuItem;
    mnuAuditoriasSistema: TMenuItem;
    CPSFOS: TMenuItem;
    mnuCalNivGirEstFornecedor: TMenuItem;
    SAPOUE: TMenuItem;
    QTDEXP: TMenuItem;
    PRENOT: TMenuItem;
    mnuFatMensalLocEquip: TMenuItem;
    mnuCancelamentoPedidoJadlog: TMenuItem;
    mnuPainelAcompanhamentoOS: TMenuItem;
    mnuProrrogaContratoLocEq: TMenuItem;
    SLRQCE: TMenuItem;
    PRMIN4: TMenuItem;
    PRMIN5: TMenuItem;
    PRMIN6: TMenuItem;
    VEMIN4: TMenuItem;
    VEMIN5: TMenuItem;
    VEMIN6: TMenuItem;
    LBMKIT: TMenuItem;
    mnuRelLiberacaoRemota: TMenuItem;
    mnuCancelaLocEqu: TMenuItem;
    mnuPedLiberacao: TMenuItem;
    DIMFNE: TMenuItem;
    mnuFatRomaneioSimplificado: TMenuItem;
    mnuManutencaoLocEq: TMenuItem;
    SENCOS: TMenuItem;
    FXALCP: TMenuItem;
    EXBCAD: TMenuItem;
    VPCMF4: TMenuItem;
    VMPMF4: TMenuItem;
    VPRMF4: TMenuItem;
    VMRMF4: TMenuItem;
    VPMMF4: TMenuItem;
    VPUMF4: TMenuItem;
    VPIMF4: TMenuItem;
    VQVMF4: TMenuItem;
    VMIMF4: TMenuItem;
    VCTMF4: TMenuItem;
    VCPMF4: TMenuItem;
    ALTCST: TMenuItem;
    mnuReimpressaoCompInspecao: TMenuItem;
    btnBalanco: TMenuItem;
    infQtdBalanco: TMenuItem;
    REIBPE: TMenuItem;
    mnuPix: TMenuItem;
    ALTCHAVPIX: TMenuItem;
    PERMRECPIX: TMenuItem;
    ALTPEDPIXATV: TMenuItem;
    mnuRelacaoPedidosPixGerados: TMenuItem;
    ALTLTV: TMenuItem;
    mnuAltClientes: TMenuItem;
    ALPDAD: TMenuItem;
    CTRBXTOTCDESC: TMenuItem;
    BAIXACTRBTNCONFIRMA: TMenuItem;
    pastaLocalizacoesFisicas: TMenuItem;
    btnLocalizacoesFisicas: TMenuItem;
    btnLocPrincipal: TMenuItem;
    btnLimparLocPrincipal: TMenuItem;
    btnLocSupEstoque: TMenuItem;
    btnLimpaLocSupEstoque: TMenuItem;
    btnLocAdicionais: TMenuItem;
    btnAdicionaLocalizacao: TMenuItem;
    btnRemoveLocalizacao: TMenuItem;
    N7444: TMenuItem;
    mnuSpoolImpressao: TMenuItem;
    mnuCadPontosImpressao: TMenuItem;
    mnuGerarOrdemdeProducaoPorArquivoDeImportacao: TMenuItem;
    mnuFatDevolucaoRapida: TMenuItem;
    DEVRAP: TMenuItem;
    CANCRL: TMenuItem;
    mnuMapaDeInventarioParaColetores: TMenuItem;
    mnuFatLibReservaEstoqueOS: TMenuItem;    
    mnuFatExclusaoVendasPerdidas: TMenuItem;
    PERMITEEXCPRODREQCOM: TMenuItem;
    pastaMapaInventario: TMenuItem;
    btnInventarioMapa: TMenuItem;
    btnInventarioMapaInfQtd: TMenuItem;
    PERMRECRCXPIX: TMenuItem;
    PERCANCRCXPIXREC: TMenuItem;
    FXITDO: TMenuItem;
    PCCGCV: TMenuItem;
    mnuGarantiaRetornoColeta: TMenuItem;
    FRCBOT: TMenuItem;
    PERMDIGCODBARLOCFIS: TMenuItem;
    FLXEDT: TMenuItem;
    N130: TMenuItem;
    mnuLiberaRomaneiosAppEntrega: TMenuItem;
    VESRNF: TMenuItem;
    mnuCadOcorrenciaEntrega: TMenuItem;
    mnuEditorEtiquetasIteLasCodBarSPre: TMenuItem;
    FXCAAR: TMenuItem;
    CEQALT: TMenuItem;    
    mnuBaixarGarantiaEnviaaoFornecedor: TMenuItem;    
    CNDDES: TMenuItem;
    LOTCRP: TMenuItem;
    CARALTVLBXM: TMenuItem;
    LISEEX: TMenuItem;
    mnuRecorrenciaOcorrencia: TMenuItem;
    mnuSpedContribuicoes: TMenuItem;
    mnuCfgEfdSpedContribuicao: TMenuItem;
    mnuPedidoDeCompraImpEdiSawluz: TMenuItem;
    mnuEtiquetasMontagemArgox: TMenuItem;
    mnuEtiquetasMontagemZebra: TMenuItem;
    mnuPortos: TMenuItem;
    mnuAeroportos: TMenuItem;
    mnuIncoterms: TMenuItem;
    ACEVOI: TMenuItem;
    mnuEtiquetasMarmoreGranito: TMenuItem;
    mnuEtiquetasMarmoreGranitoArgox: TMenuItem;
    mnuEtiquetasMarmoreGranitoLazer: TMenuItem;
    mnuEnderecamentoMarmoreGranito: TMenuItem;
    OCOREC: TMenuItem;
    VMENCU: TMenuItem;
    AEPCET: TMenuItem;
    mnuAvaliacaoGarantiaPropriaEmpresa: TMenuItem;
    btnConferenciaCargaPorRomaneio: TMenuItem;
    PBOPIC: TMenuItem;
    mnuCadCorrecaoOrdProducaoIndustrial: TMenuItem;
    PCCOPI: TMenuItem;
    mnuBaixaOrdemProducaoIndustrialGeral: TMenuItem;

    PERMRECCTRPIX: TMenuItem;
    PERCANCCTRPIXREC: TMenuItem;

    FLXBOS: TMenuItem;
    FXRMAP: TMenuItem;

    mnuEtiquetasProdutoControladoVenda: TMenuItem;
    mnuEtiquetasProdutoControladoVendaLaser: TMenuItem;
    mnuEtiquetasProdutoControladoVendaArgox: TMenuItem;
    mnuEtiquetasProdutoControladoVendaZebra: TMenuItem;
    mnuEtiquetadoProdutoSeparado_QtdRestante: TMenuItem;
    mnuEtiquetaDoProdutoSeparadoLaser: TMenuItem;
    mnuEtiquetaDoProdutoSeparadoArgox: TMenuItem;
    mnuEtiquetaDoProdutoSeparado: TMenuItem;
    pastaRomaneioVolumes: TMenuItem;
    confRomVolFinalizarDivergencia: TMenuItem;
    FXTRES: TMenuItem;
    PRODIMPLIST: TMenuItem;
    mnuRelEstOrdensBaixadasParcialmenteEmAberto: TMenuItem;
    mnuCadMetaCompDepVend: TMenuItem;
    FLXREM: TMenuItem;
    
    CTRPADPMM: TMenuItem;    
    mnuEditorEtiquetasMontagemCaixasZebraPackList: TMenuItem;
    CANCDL: TMenuItem;
    GASEVE: TMenuItem;
    btnGuardarItemSeparado: TMenuItem;
    btnConferenciaOrdemProducaoIndustrialMPCorrecao: TMenuItem;
    btnLimpaConferenciaMPCorrecao: TMenuItem;
    mnuEditorEtiquetasMontagemCaixasLaserPackList: TMenuItem;
    PERDME: TMenuItem;
    PERMME: TMenuItem;
    mnuPainelEntregas: TMenuItem;
    infQtdConferenciaEntrada: TMenuItem;
    PERMITEEXCPDLOTSEP: TMenuItem;
    LPSSCE: TMenuItem;
    btnEnderecarDivergencias: TMenuItem;
    EMIFUTNL: TMenuItem;
    mnuConsultaCadLocEqu: TMenuItem;
    CANYAP: TMenuItem;
    EXVLPD: TMenuItem;
    EXPSPD: TMenuItem;
    EXF10P: TMenuItem;
    EXF11P: TMenuItem;
    TPLIBCTPBX: TMenuItem;
    Garantia: TMenuItem;
    GCFPDS: TMenuItem;
    GCFPDN: TMenuItem;
    mnuTransfTabelas: TMenuItem;
    mnuAcertoDeContasDeProfissionais: TMenuItem;
    BAIXAACERTOCONTASPROF: TMenuItem;
    PEDAMO: TMenuItem;
    PEDUCO: TMenuItem;
    PRDVCCCHP: TMenuItem;
    ALTDTAINIPOR: TMenuItem;
    mnuAltGlobalServico: TMenuItem;
    ALTGLOBSER: TMenuItem;
    CARHERANCA: TMenuItem;
    RIMETIENT: TMenuItem;
    ALTCANALACESSO: TMenuItem;
    PERREMPIXRELAC: TMenuItem;
    PERFILVENPIXGER: TMenuItem;
    PERFILVEN2PIXGER: TMenuItem;
    PERFILEMPPIXGER: TMenuItem;
    CRMCONSLEADSVEN: TMenuItem;
    CRMCONSLEADSVEE: TMenuItem;
    btnExpRetiraSep: TMenuItem;
    btnTransfLocSemWms: TMenuItem;
    btnCadastroEmbalagem: TMenuItem;
    PERWPP: TMenuItem;
    VMPRF4: TMenuItem;
    VMPCF4: TMenuItem;
    mnuCadCotacaoDiariaCombustiveis: TMenuItem;
    TRACGC: TMenuItem;
    btnConfSaidaPorRomaneio: TMenuItem;
    FLXMRE: TMenuItem;
    mnuTransportadora: TMenuItem;
    FLXNEG: TMenuItem;
    FLXDTR: TMenuItem;
    mnuEditorEtiquetasIndividuaisDespachoProduto: TMenuItem;
    mnuEditorEtiquetasIndividuaisDespachoProdutoArgox: TMenuItem;
    DIRRCXRECPORTRA: TMenuItem;
    mnuFatVendaNormalVendaRapida: TMenuItem;
    CFDPNT: TMenuItem;
    mnuRelCtrCartaNotifExtrajudicial: TMenuItem;
    mnuGatilhoCTR: TMenuItem;
    mnuGatilhoCtrEnviaExtratoCobranca: TMenuItem;
    PERRECPIXRELAC: TMenuItem;
    EXBDCT: TMenuItem;
    PERMAX: TMenuItem;
    mnuManutencaoOrdProVidro: TMenuItem;
    FXCAMA: TMenuItem;
    AIEOPV: TMenuItem;
    OPVLQM: TMenuItem;
    mnuPermAbortarMovProg: TMenuItem;
    CLIVEI: TMenuItem;
    N132: TMenuItem;
    mnuRecebimentoTransbordo: TMenuItem;
    mnuSpedFiscal: TMenuItem;
    mnuGIA: TMenuItem;
    frmCfgSpedFiscal: TMenuItem;
    mnuDescontoMaximoPorAtividade: TMenuItem;
    mnuMargemMinimaPorAtividade: TMenuItem;
    CANPME: TMenuItem;
    EXVACE: TMenuItem;
    mnuCadMotFinOco: TMenuItem;
    mnuCadMotivoPausaAppEntrega: TMenuItem;
    mnuBoxEntregaImediata: TMenuItem;
    mnuLiberacaoCaixas: TMenuItem;
    VISMODDINLIBCAX: TMenuItem;
    VISMODCARLIBCAX: TMenuItem;
    VISMODCHVLIBCAX: TMenuItem;
    VISMODCHPLIBCAX: TMenuItem;
    VISMODORDLIBCAX: TMenuItem;
    VISDIVLIBCAX: TMenuItem;
    mnuAltPrecoRecalc: TMenuItem;
    mnuCadCarteiraDigital: TMenuItem;
    ATLGDV: TMenuItem;
    CMPMLT: TMenuItem;
    FXORDE: TMenuItem;
	  PERMDEVRECPIX: TMenuItem;
    PERMESTSEMDEVPIX: TMenuItem;
    mnuRelatorioAcompanhamentoPix: TMenuItem;
    DIAPRE: TMenuItem;
    mnuCadFreteRegiao: TMenuItem;
    mnuTranferenciaPedidoMultiLoja: TMenuItem;
    OSCAPR: TMenuItem;
    N133: TMenuItem;
    mnuPainelRessuprimentos: TMenuItem;	ETMRGF: TMenuItem;
    WMSBUF: TMenuItem;
    CARREIMPFET: TMenuItem;
    PEDCOM: TMenuItem;
    Permitirrealizarimpressodeboletosnateladeconsultadeocorrencias1: TMenuItem;
    SERTRA: TMenuItem;
    SENVRU: TMenuItem;
    PERIMPPLANP: TMenuItem;
    FREESP: TMenuItem;
    FLXCFG: TMenuItem;
    CNSCRE: TMenuItem;
    CNSCCA: TMenuItem;
    FXCAEN: TMenuItem;
    LOCAIS: TMenuItem;
    LOCAIE: TMenuItem;
    ALTCNT: TMenuItem;
    EXCCNT: TMenuItem;
    FXESAL: TMenuItem;
    PBOPIS: TMenuItem;
    N134: TMenuItem;
    frmAlterarPaginaRevista: TMenuItem;
    frmImpPagina: TMenuItem;
    mnuImportaPrecos: TMenuItem;
    mnuCadTemperaturaAtendimentoCRM: TMenuItem;
    N135: TMenuItem;
    mnuConsultoriaFiscalSaneamento: TMenuItem;
    mnuManutencaoOrigemProdAcabados: TMenuItem;
    DBXEXR: TMenuItem;
    TIPPRC: TMenuItem;
    ACEUC: TMenuItem;
    SPLAUT: TMenuItem;
    ALTEST: TMenuItem;
    GRCOET: TMenuItem;
    N136: TMenuItem;
    mnuImportaoXMLdeNFEparaAuditoria: TMenuItem;
	  BXPDNE: TMenuItem;
  	mnuManutancaoDescontoEmbalagemExcluir: TMenuItem;
    LBRBOL: TMenuItem;
    mnuAlterarPrazoGarantia: TMenuItem;
    DIRRCXALTFORPAG: TMenuItem;
    N137: TMenuItem;
    mnuUtilLocacaoEquipamento: TMenuItem;
    mnufrmImportarCadLocEqu: TMenuItem;
    PVVNEF: TMenuItem;
    mnuOutrasDespesasAposEntrada: TMenuItem;
    DIRRCXRECDUPAVCCCH: TMenuItem;
    mnuCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa: TMenuItem;
    TFANSP: TMenuItem;
    mnuFaixaFaturamentoDeptoVendProd: TMenuItem;
    mnuCadFaixaFaturamentoDeptoVendProd: TMenuItem;
    mnuCadMotivosAproveitamentoItens: TMenuItem;
    AQCLUFI: TMenuItem;
    N138: TMenuItem;
    btnPreEnd: TMenuItem;
    frmConEquipAtualizaProdutosReqCompra: TMenuItem;
    HRDPDL: TMenuItem;
    FATCDTCILVAS: TMenuItem;
    DIRRCXTRDV: TMenuItem;
    DIRTECSEAT: TMenuItem;
	  MSGFILOPE: TMenuItem;
    mnuEditorEtiquetasIDDoPlanoDeRecebimento: TMenuItem;
    mnuEditorEtiquetasIDDoPlanoDeRecebimentoLaser: TMenuItem;
    mnuEditorEtiquetasIDDoPlanoDeRecebimentoArgox: TMenuItem;
    mnuCadAssistenciaTecnica: TMenuItem;
    mnuChecklistValidacaoGarantia: TMenuItem;
    mnuEdicaoParamCmpCadPrd: TMenuItem;
    mnuCompromissos: TMenuItem;
    mnuCompromissoGlobal: TMenuItem;
    ACQDDP: TMenuItem;
    SUSROBSEP: TMenuItem;
    mnuConfTintaMaquina: TMenuItem;
    mnuGlasurit: TMenuItem;
    mnuSalcomix: TMenuItem;
    mnuConfiguracoesGlasurit: TMenuItem;
    mnuCadGlaBases: TMenuItem;
    mnuCadGlaNovasFormulas: TMenuItem;
    mnuCadGlaGeraArquivo: TMenuItem;
    mnuConsultaGlasurit: TMenuItem;
    mnuCadGlaGerNfm: TMenuItem;
    mnuConfiguracoesSalcomix: TMenuItem;
    mnuCadSalBases: TMenuItem;
    mnuCadSalNovasFormulas: TMenuItem;
    mnuCadSalGeraArquivo: TMenuItem;
    mnuConsultaSalcomix: TMenuItem;
    mnuCadSalGerNfm: TMenuItem;
    popTintasMaquina: TAdvPopupMenu;
    mnuCancelamentoFrete: TMenuItem;
    mnuImportCadNCM: TMenuItem;
    mnuImportCadNOP: TMenuItem;
    ITENVEND: TMenuItem;
    mnuCadastrosPisCofins: TMenuItem;
    mnuPlanoContabilPorCfop: TMenuItem;
    mnuPlanoContabilPorCst: TMenuItem;
    mnuCadDespFin: TMenuItem;
    mnuCadGerAutDespFin: TMenuItem;
    mnuCadEfdContriSemDadosEscriturar: TMenuItem;
    mnuSintegra: TMenuItem;
    mnuConverte: TMenuItem;
    mnuCadastrosGIA: TMenuItem;
    mnuDescricaoOcorrencias: TMenuItem;
    mnuCadGiaFundamentoLegal: TMenuItem;
    mnuCadGiaOcorrencias: TMenuItem;
    ENTREP: TMenuItem;
    mnuCadRestricaoVenda: TMenuItem;
    ALTURGPD: TMenuItem;
    mnuFatConvOrcPedVendaCasada: TMenuItem;
    N139: TMenuItem;
    mnuEditorEtiquetasDespachoFaturarPedidoLaser: TMenuItem;
    mnuEditorEtiquetasDespachoFaturarPedidoArgox: TMenuItem;
    N140: TMenuItem;
    mnuContatosWhatsappIntegracao: TMenuItem;
    TRADOC: TMenuItem;
    BPATEV: TMenuItem;
    VIGAUT: TMenuItem;
    STAATV: TMenuItem;
    Produtos: TMenuItem;
    dirAceCHKMTG: TMenuItem;
    INCLTITE: TMenuItem;
    btnTransfLoc: TMenuItem;
    LiberaTransfLocalAcimaCapacidadeMax: TMenuItem;
    mnuFatDefineLoteEntregaFuturaFaltaProduto: TMenuItem;
    DIREXPPAR: TMenuItem;
    BTNARQCAD: TMenuItem;
    ALTLEILGPD: TMenuItem;
    ALTTERACE: TMenuItem;
    BTNARQACE: TMenuItem;
    ALTOBROPE: TMenuItem;
    ALTPERENTFUTAC: TMenuItem;
    ALTPERENTFUTPE: TMenuItem;
    ALTPERENTFUTFP: TMenuItem;
    DIRALIQISS: TMenuItem;
    MNUPERALTDOCFIN: TMenuItem;
    LIBVENFORAEST: TMenuItem;
    LIFIAB: TMenuItem;
    mnuPgtoOnlineESiTefParChavesManutencao: TMenuItem;
    mnuFatNFCeComplemento: TMenuItem;
    mnuPERIMPSPRV: TMenuItem;
    mnuPERIMPBOLVIDEO: TMenuItem;
    PERMITEDIMQTDPRODREQCOM: TMenuItem;
    EXPLIMPSEP: TMenuItem;
    N100: TMenuItem;
    mnuDireitoAcessoPromocoes: TMenuItem;
    PERIAE: TMenuItem;
    CANPDA: TMenuItem;
    PERMGERCCPIX: TMenuItem;
    FLXRQC: TMenuItem;
    mnuFiltroComCus: TMenuItem;
    mnuCampoItegerPermiteEdicao: TMenuItem;
    mnuDireitoAcessoPainelDeEntregas: TMenuItem;
    mnuAtualizacaoMargemParaFranquias: TMenuItem;
    LIBPRO: TMenuItem;
    LIBDEV: TMenuItem;
    QTDITEF11: TMenuItem;
    DIRYAPSSR: TMenuItem;
    ALTFNE: TMenuItem;
    mnuCadEtiquetaVolumeEtiquetaDespacho: TMenuItem;
    mnuEditorEtiquetasDespachoVolumeGeral: TMenuItem;
    mnuEditorEtiquetasDespachoVolumeIndividual: TMenuItem;
    mnuEditorEtiquetasDespachoVolumeGeralArgox: TMenuItem;
    mnuEditorEtiquetasDespachoVolumeGeralLaser: TMenuItem;
    mnuEditorEtiquetasDespachoVolumeIndividualArgox: TMenuItem;
    mnuEditorEtiquetasDespachoVolumeIndividualLaser: TMenuItem;
    mnuCadastrosSpedFiscal: TMenuItem;
    mnuCadAdiAjuste: TMenuItem;
    mnuCadAdiAjusteApu: TMenuItem;
    mnuCadVenDiaEmp: TMenuItem;
    mnuCadApuIpiAjuste: TMenuItem;
    mnuCadContribuicaoRetidaFonte: TMenuItem;
    mnuCadCampo06BlocoC185Sped: TMenuItem;
    mnuCadGrupoEcoFornec: TMenuItem;
    mnuGatilhosInformacao: TMenuItem;
    N141: TMenuItem;
    OSDFOT: TMenuItem;
    CTPEXCGERAUT: TMenuItem;
    mnuCadComFaiFatDepVenProFator: TMenuItem;
    ALTPORMOVBAN: TMenuItem;
    btnConfPre: TMenuItem;
    ATUCTR: TMenuItem;
    FXRMAS: TMenuItem;
    ALTCEPIMPTABLET: TMenuItem;
    LIBCREDDOCNAOEXP: TMenuItem;    
    PDDRBA: TMenuItem;
    EQSSER: TMenuItem;
    OBRCRE: TMenuItem;
    DLSWMS: TMenuItem;
    ENCCTR: TMenuItem;
    PERMCLIDIFCLUBFIDEL: TMenuItem;
    ALTPEDPIXADT: TMenuItem;
    GRPREF: TMenuItem;
    mnuPrmRotCitelAbastece: TMenuItem;
    ARCTIE: TMenuItem;
    ALTPEDTOTPARC: TMenuItem;
    MREQFA: TMenuItem;
    PERRECF11MODOP: TMenuItem;
    PERRETITECORTE: TMenuItem;
    LSEPON: TMenuItem;
    mnuAgrupamentoDeOndaDeSeparacao: TMenuItem;
    mnuNCMparaoutrospases: TMenuItem;
    CRMPTB: TMenuItem;
    CRMPDC: TMenuItem;
    CRMCMG: TMenuItem;
    CRMPDT: TMenuItem;
    APROSC: TMenuItem;
    btnSeparacaoGrossa: TMenuItem;
    DESVINESITGERLINK: TMenuItem;
    TCKESTCTX: TMenuItem;
    BtnSepararacaoGrossaAutomatica: TMenuItem;
    BtnSepararacaoFinaAutomatica: TMenuItem;
    mnuCadArmazemOperadores: TMenuItem;
    mnuCupomPromocao: TMenuItem;
    REIMPCPP: TMenuItem;
    mnuImpCupPro: TMenuItem;
    PERMVISULCADCLITODOSVENDEDORES: TMenuItem;
    ALTLOTNOTWMS: TMenuItem;
    PERDEPCHQ: TMenuItem;
    mnuTransfCodMotorista: TMenuItem;
    CFIBAI: TMenuItem;
    BPVLSR: TMenuItem;
    btnCitelDesk: TcxImage;
    N142: TMenuItem;
    mnuCitelDesk: TMenuItem;
    VISRESFINCLI: TMenuItem;
    mnuGarantiaReimpressaoComprovantes: TMenuItem;
    BTNPRM: TMenuItem;
    OSGEXC: TMenuItem;
    HISBAI: TMenuItem;
    pnlBotoes3: TPanel;
    btnWMS: TcxImage;
    popWMS: TAdvPopupMenu;
    UVCF11: TMenuItem;
    mnuGruposAnaliseProducao: TMenuItem;
    VNDSBA: TMenuItem;
    mnuRelMenuFavoritos: TMenuItem;
    SAMEXC: TMenuItem;
    mnuCadMontagemCaixa: TMenuItem;
    CRMALTOCOEMA: TMenuItem;
    mnuEditorEtiquetasProdutosQtdFracionada: TMenuItem;
    mnuEditorEtiquetasProdutosQtdFracionadaLaser: TMenuItem;
    mnuEditorEtiquetasProdutosQtdFracionadaArgox: TMenuItem;
    TRALTCLIORPED: TMenuItem;
    TRAALTITEMORPED: TMenuItem;
    DDUPVE: TMenuItem;
    LiberaTransfLocalNaoValidadeMaisProxima: TMenuItem;
    RMPCPG: TMenuItem;
    EXF5EXPED: TMenuItem;
    mnuReimpressaoGarantiaGR: TMenuItem;
    WPPREI: TMenuItem;
    PROEMP: TMenuItem;
    mnuTransfCodEvento: TMenuItem;
    mnuPastaComprasExecAux: TMenuItem;
    mnuManutMultiLojaAposEntrada: TMenuItem;
    mnuRemessaDevolucao: TMenuItem;
    FNSPED: TMenuItem;
    mnuComissaoDepTabPre: TMenuItem;
    mnuComissaoDepartamento: TMenuItem;
    PERVERTODOSCHQ: TMenuItem;
    RCBAPP: TMenuItem;
    CHKBRI: TMenuItem;
    mnuEntImportaNFSe: TMenuItem;
    GPCSDV: TMenuItem;
    mnuDireitoAcessoControleRotasRegiao: TMenuItem;
    RRGIPD: TMenuItem;
    RRGEPD: TMenuItem;
    mnuComissaoLinhaProd: TMenuItem;
    mnuCadMetMix: TMenuItem;
    mnuComissaoLinha: TMenuItem;
    mnuControleAcessoMovimentacaoItens: TMenuItem;
    mnuVendaABaseDeTroca: TMenuItem;
    VBTAVU: TMenuItem;
    VBTBAI: TMenuItem;
    VBTCRE: TMenuItem;
    mnuVendaBaseTroca: TMenuItem;
    mnuVendaBaseTrocaRecebimento: TMenuItem;
    CNTRCR: TMenuItem;
    PERSERVBRINDE: TMenuItem;
	  CONBANOFX: TMenuItem;
    mnuComissaoPorHeraquiaFaixaDesconto: TMenuItem;
    mnuFaixaDeDescontoPorLinhaGrupoCliente: TMenuItem;
    mnuFaixaDeDescontoPorLinhaGrupoVendedor: TMenuItem;
    mnuFaixaDeDescontoPorLinhaGrupoGerente: TMenuItem;
    mnuFaixaDeDescontoPorLinhaGrupo: TMenuItem;
    CRMBEF: TMenuItem;
    mnuLimparSeparaodoPedidodeVenda: TMenuItem;
    ALTLEG: TMenuItem;
    PILDEF: TMenuItem;
    mnuEmailAutomatico: TMenuItem;
    frmCfgBlackListEmail: TMenuItem;
    PEREFEANTREDCARD: TMenuItem;
    IMPORTAREXTRATOCARTOES: TMenuItem;
    IGNORARCARTOESCONFIRMACAO: TMenuItem;
    LIBEXCITEPED: TMenuItem;
    PERMF8NOF4: TMenuItem;
    mnuCadMetasEmpresa: TMenuItem;
    ALTEMPMET: TMenuItem;
    mnuFatAltEvento: TMenuItem;
    TCCCFL: TMenuItem;
    ALTPTE: TMenuItem;
    LIBPARVEN: TMenuItem;
    btnFinalizaConferenciaEntradaComDivergencia: TMenuItem;
    TRCDIF: TMenuItem;
    mnuPainelFusion: TMenuItem;
    VTOPVD: TMenuItem;
    ALTLIM: TMenuItem;
    LIMCTR: TMenuItem;
    PERMGERARPDFFF: TMenuItem;
    mnuManutNumSerieItens: TMenuItem;
    mnuFatManPedCortadoFaltaEstoque: TMenuItem;
    ALTIGTVMK: TMenuItem;
    mnuConfirmacaoDeCartoes: TMenuItem;
    mnuRequisicaoVinculadasComPedidoDeCompra: TMenuItem;
    LIBBRCB: TMenuItem;
    CANWEB: TMenuItem;
    mnuCadLocFisicaConsertoEquip: TMenuItem;
    mnuFaixaDeDescontoPorLinhaGrupoSubgerente: TMenuItem;
    mnuDecretos: TMenuItem;
    mnuCat42: TMenuItem;
    mnuExpCat42 : TMenuItem;
    mnuRelatorioCat42: TMenuItem;
    mnuConfiguraoEnquadramento: TMenuItem;
    mnuConfiguraoCat42: TMenuItem;
    mnuEstornoNotaFiscalDevolucao: TMenuItem;
    VNFACP: TMenuItem;
    EXPSIT: TMenuItem;
    POSAMS: TMenuItem;
    MNUPRTEXCDOCPRELSTPOSTCORREIOS: TMenuItem;
    MPVMPC: TMenuItem;
    MPVMIC: TMenuItem;
    mnuReinf: TMenuItem;
    ALTDOCCONFE: TMenuItem;
    btnFinalizarConfEnvaseDivergencia: TMenuItem;
    btnEnderecamentoOutrasEntradas: TMenuItem;
    VAQTTR: TMenuItem;
    ALEPCM: TMenuItem;
    PVPMLR: TMenuItem;
    PALTDUPCON: TMenuItem;
    PERALTPORTADORBOLETO: TMenuItem;
    PERALTCLICREDPIX: TMenuItem;
    PSABCT: TMenuItem;
    ITPRCV: TMenuItem;
    mnuConsultaFatCobrancaEletronica: TMenuItem;
    mnuEditorMetas: TMenuItem;
    FCX15V: TMenuItem;
    N143: TMenuItem;
    mnuAltGlobCadCartoes: TMenuItem;
    PERMCTRLF10CONFDOC: TMenuItem;
    PECTVN: TMenuItem;
    ESPDNF: TMenuItem;
    mnuFatAnaliseCustoPedido: TMenuItem;
    CANCRB: TMenuItem;
    PAOSEG: TMenuItem;
    PVCPPC: TMenuItem;
    TECCEN: TMenuItem;
    btnVisualizarSaldoProdutos: TMenuItem;
    mnuCadOcorrenciasDoColetor: TMenuItem;
    OBRCIF: TMenuItem;
    imgLogoLight: TImage;
    ENCCTF: TMenuItem;
    ENENDI: TMenuItem;
    mnuImportaoCustosRegimeTributrioFranquias: TMenuItem;
    mnuImportProdutoVeiculo: TMenuItem;
    mnuFatRemoverDocumentoPreRomaneio: TMenuItem;
    mnuFatGerarNovoPreRomaneio: TMenuItem;
    mnuFatRomaneioAdicionarDoctosNaoEntregues: TMenuItem;
    mnuCadNBS: TMenuItem;
    mnuCadIndicadorOperacaoServico: TMenuItem;
  	mnuConfTransfArmazens: TMenuItem;
    btnLimparSeparacaoNoLocal: TMenuItem;
    mnuTransfArmazensProdutoAcabado: TMenuItem;
    mnuControleGondola: TMenuItem;
    mnuSolicitacaodeReposicaodeGondola: TMenuItem;
    mnuPaineldeReposicaodeGondola: TMenuItem;
    ReimpressodeSeparao1: TMenuItem;
    mnuGatilhosImediatos: TMenuItem;
    TEFCADTERSAL: TMenuItem;
    PERALTVENDORCTAPAGARCOMFECFIN: TMenuItem;
    PERGERPIXBOLHIBR: TMenuItem;
    GERADT: TMenuItem;
    FIESOP: TMenuItem;
    PVADCTP: TMenuItem;
    SBAREX: TMenuItem;
    PERMCADENDENTUFDIF: TMenuItem;
    MnuConcorrentesParaPesquisaDeMercado: TMenuItem;
    CPPACI: TMenuItem;
    PERENTUFDIFEL: TMenuItem;
    mnuCashback: TMenuItem;
    mnuFatConfeEntDocNaoEntregues: TMenuItem;
    ROMCAV: TMenuItem;
    mnuCadBaseFreteCFOP: TMenuItem;
    mnuNCMEmpresa: TMenuItem;
    PERMCANNFENFCEERRCHVACESDUP: TMenuItem;
    UTDCOB: TMenuItem;
    PERMEDITDOCJACONFERIDO: TMenuItem;
    mnuResumoISS: TMenuItem;
    LIBGRVAJUEST: TMenuItem;
    pnlNotificacao: TPanel;
    shNotificacao: TShape;
    lblNotificacao: TLabel;
    mnuNFSeSubstituicao: TMenuItem;
    mnuPermitevisualizarsaldoanteriorconcil: TMenuItem;
    ALVCAR: TMenuItem;
    mnuConferenciaEstoqueContabil: TMenuItem;
    PERMALTFCI: TMenuItem;
    mnuMovProgramada: TMenuItem;
    EXCMOVPRG: TMenuItem;
    mnuImportaPROSER: TMenuItem;
    OCOALT: TMenuItem;
    btnTransferenciaEntreArmazens: TMenuItem;
    mnuRelEmprestimos: TMenuItem;
    mnuSolicitacaoManutencaoEquipamentosInternos: TMenuItem;
    mnuLiberacaoManutencaoEquipamentosInternos: TMenuItem;
    PATEXPITE: TMenuItem;
    FREMAI: TMenuItem;
    FREMEN: TMenuItem;
    TRPPRM: TMenuItem;
    SATOIR: TMenuItem;
    ALRTRA: TMenuItem;
    SATOIE: TMenuItem;
    ALMTRA: TMenuItem;
    mnuAltGlobCadClientes: TMenuItem;
    mnuAltGlobalCadClientes: TMenuItem;
    mnuFatReimpressaoManifestoEletronico: TMenuItem;
    ECAPEDBAI: TMenuItem;
    N150: TMenuItem;
    mnuExpContabilModalidade: TMenuItem;
    mnuGerImobilizado: TMenuItem;
    mnuCadAbfReformaTributaria: TMenuItem;
    btnMovimentacaoCarga: TMenuItem;
    PermitirF7CancelarPendenteRelTEF: TMenuItem;
    PermitirF10ConsultarTransTEFRelTEF: TMenuItem;
    mnuPreNota: TMenuItem;
    DIRLIBDEVPROCSH: TMenuItem;
    LIMEND: TMenuItem;
    LIMCON: TMenuItem;
    mnuReformaTributariaTipoCredito: TMenuItem;
    mnuReformaTributariaTipoDebito: TMenuItem;
    mnuReformaTributariaCreditoDebito: TMenuItem;
    mnuReformaTributriaCreditoDebito: TMenuItem;
    mnuIntegracaoDominioSistemas: TMenuItem;
    mnuCadPerfilAduaneiro: TMenuItem;
    mnuPERMALTDTAENTLIVFIS: TMenuItem;
    VERTOTITENSVEND: TMenuItem;
    mnuLiberacaoCNPJ: TMenuItem;
    PERIMPARQMAISMKT: TMenuItem;
    PMCALG: TMenuItem;
    N151: TMenuItem;
    mnuDivergenciasSeparacao: TMenuItem;
    mnuCadastroDeAlquotasDeICMSporEstado: TMenuItem;
    GAJESTDSEP: TMenuItem;
    LIBERAREGISTROCOBELT: TMenuItem;
    CRIANOVOLINKCOBELT: TMenuItem;
    CNPECX: TMenuItem;
    PermissoparaexcluirprodutanarotinadeTransfernciadeEstoqueentreArmaznsConferncia1: TMenuItem;
    mnuCadNatReceitaPisCof: TMenuItem;
    mnuImportacaoNotaFiscalUsoConsumo: TMenuItem;
    LIBERACONSNEOC: TMenuItem;
    LIBERAPEDSEMAPROVACAONEOC: TMenuItem;
    mnuCTE: TMenuItem;
    PERCTEDE: TMenuItem;
    LFGCPF: TMenuItem;
    mnuReporMais: TMenuItem;
    REPMPAINEL: TMenuItem;
    REPMCOMPRAR: TMenuItem;
    REPMPEDIDOS: TMenuItem;
    REPMCOTACAO: TMenuItem;
    REPMCADASTRO: TMenuItem;
    REPMABASTECE: TMenuItem;
    REPMRELATORIO: TMenuItem;
    mnuReporMaisConfiguracoes: TMenuItem;
    LIBDVECSH: TMenuItem;
    mnuFatCashback: TMenuItem;
    mnuCashbackDevolucaoEmbalagem: TMenuItem;
    DFE_EVENTOS_DE_ENTREGA: TMenuItem;
    REPMACESSO: TMenuItem;
    REPMCFGCMP: TMenuItem;
    REPMCFGABA: TMenuItem;
    EXCLUIRMOVBANCOMORIGEM: TMenuItem;
    pastaImprimirEtiquetas: TMenuItem;
    btnImprimirEtiquetaDespacho: TMenuItem;
    btnImprimirEtiquetaLocalizacao: TMenuItem;
    btnImprimirEtiquetaLote: TMenuItem;
    btnImprimirEtiquetaProduto: TMenuItem;
    btnImprimirEtiquetaProdutoPedido: TMenuItem;
    btnLiberarSeparacaoGrossa: TMenuItem;
    mnuLibAcessoWS: TMenuItem;
    mnuCadAutorizadosWS: TMenuItem;
    mnuLibAcessoEndPointsWS: TMenuItem;
    mnuCadTiposIntegracaoWS: TMenuItem;
    btnImprimirEtiquetas: TMenuItem;
    mnuExibirCompromissoTodosOpe: TMenuItem;
    mnuConvertReforma: TMenuItem;
    procedure mnuManutancaoDescontoEmbalagemExcluirClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure tmrRelogioTimer(Sender: TObject);
    procedure mnuCadConfiguracoesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnuProxCodigosClick(Sender: TObject);
    procedure mnuConvertReformaClick(Sender: TObject);
    procedure mnuCadPerfilAduaneiroClick(Sender: TObject);
    procedure mnuCadCidadesClick(Sender: TObject);
    procedure mnuCadEmpresasClick(Sender: TObject);
    procedure mnuCadOperadoresClick(Sender: TObject);
    procedure mnuCadAtividadesClick(Sender: TObject);
    procedure mnuCadFornecedoresClick(Sender: TObject);
    procedure mnuCadGruposClick(Sender: TObject);
    procedure mnuCadCentroCustoClick(Sender: TObject);
    procedure mnuCadMarcasClick(Sender: TObject);
    procedure mnuCadUnidadesClick(Sender: TObject);
    procedure mnuCadTransporatadorasClick(Sender: TObject);
    procedure mnuCadIrregFiscalClick(Sender: TObject);
    procedure mnuCadPortadoresClick(Sender: TObject);
    procedure mnuCadBancosClick(Sender: TObject);
    procedure mnuCadDiversosClick(Sender: TObject);
    procedure mnuCadSitTributariaClick(Sender: TObject);
    procedure mnuCadClassFiscalClick(Sender: TObject);
    procedure mnuCadCtaResultadosClick(Sender: TObject);
    procedure mnuCadAbrevFiscalClick(Sender: TObject);
    procedure mnuCadRessarcimentoIcmsStCATClick(Sender: TObject);
    procedure mnuCadConfRelatoriosClick(Sender: TObject);
    procedure mnuCadImpressorasClick(Sender: TObject);
    procedure mnuCadIdentificacaoImpressoraClick(Sender: TObject);
    procedure mnuCadClientesClick(Sender: TObject);
    procedure mnuCadMovBancariaClick(Sender: TObject);
    procedure mnuGenrencImprClick(Sender: TObject);
    procedure mnuCadProdutosClick(Sender: TObject);
    procedure mnuCadLivroFiscalClick(Sender: TObject);
    procedure mnuFatRomaneioLoteSeparacaoClick(Sender: TObject);
    procedure mnuCadCtaReceberClick(Sender: TObject);
    procedure mnuBaixaCtaReceberClick(Sender: TObject);
    procedure mnuEstornoCtaReceberClick(Sender: TObject);
    procedure mnuCadChequesClick(Sender: TObject);
    procedure mnuBaixaChequeClick(Sender: TObject);
    procedure mnuChequesRepasseClick(Sender: TObject);
    procedure mnuCancRepasseClick(Sender: TObject);
    procedure mnuCadSalBalancoClick(Sender: TObject);
    procedure mnuCadCtaPagarClick(Sender: TObject);
    procedure mnuBaixaCtaPagarClick(Sender: TObject);
    procedure mnuRelChqInclDiariasClick(Sender: TObject);
    procedure mnuRelChqDeposClick(Sender: TObject);
    procedure mnuLiberacaoLocalizacaoFisicaColetorClick(Sender: TObject);
    procedure mnuRelChqRepassadosClick(Sender: TObject);
    procedure mnuRelChqPredatadosClick(Sender: TObject);
    procedure mnuRelChqDevolvidosClick(Sender: TObject);
    procedure mnuEstornoCtaPagarClick(Sender: TObject);
    procedure mnuImpBoletoIndivClick(Sender: TObject);
    procedure mnuEtiClientesClick(Sender: TObject);
    procedure mnuEtiItensClick(Sender: TObject);
    procedure mnuEtiDiversosClick(Sender: TObject);
    procedure mnuEtiFornecedoresClick(Sender: TObject);
    procedure mnuEtiVendedoresClick(Sender: TObject);
    procedure mnuAgrupDuplicatasClick(Sender: TObject);
    procedure mnuDesagrupDuplicatasClick(Sender: TObject);
    procedure mnuRelCtpEncQuitadosClick(Sender: TObject);
    procedure mnuRelCtpCtaCorrenteClick(Sender: TObject);
    procedure mnuRelCtpIncDiariasClick(Sender: TObject);
    procedure mnuRelCtpPosContabilClick(Sender: TObject);
    procedure mnuRelCtpIncDiariasMesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mnuCadGruOperadorNovoClick(Sender: TObject);
    procedure mnuDirAcessoClick(Sender: TObject);
    procedure mnuPedidoComprasClick(Sender: TObject);
    procedure mnuCancelamentoPedidoClick(Sender: TObject);
    procedure mnuCadCartoesClick(Sender: TObject);
    procedure mnuFecGiroEstoqueClick(Sender: TObject);
    procedure mnuManCartaoClick(Sender: TObject);
    procedure mnuCadLoteItensRapidoClick(Sender: TObject);
    procedure mnuBaixaCartoesClick(Sender: TObject);
    procedure mnuCadPrevisoesClick(Sender: TObject);
    procedure mnuDirAutBanClick(Sender: TObject);
    procedure mnuEntMercadoriasClick(Sender: TObject);
    procedure mnuGerLayoutBanClick(Sender: TObject);
    procedure mnuAjusteEstoqueClick(Sender: TObject);
    procedure mnuAltPrecoProdutoClick(Sender: TObject);
    procedure mnuRelacSimilaridadeClick(Sender: TObject);
    procedure mnuRelEspNotaEntClick(Sender: TObject);
    procedure mnuTransfLinGruClick(Sender: TObject);
    procedure mnuFatTrocaMercClick(Sender: TObject);
    procedure mnuCadCompromissosClick(Sender: TObject);
    procedure mnuRelEstItensAbaixoMinClick(Sender: TObject);
    procedure mnuRelEstItensAcimaMaxClick(Sender: TObject);
    procedure mnuExclusaoOrcFaturadosClick(Sender: TObject);
    procedure mnuRelEstatAbcProdutosClick(Sender: TObject);
    procedure mnuRelEstatAbcFornecedoresClick(Sender: TObject);
    procedure mnuRelEstatAnalResultClick(Sender: TObject);
    procedure mnuConsultaProdutosClick(Sender: TObject);
    procedure mnuConsultaFatNovosItensClick(Sender: TObject);
    procedure mnuRelFatVendasClienteClick(Sender: TObject);
    procedure mnuCancelamentoDocumentosClick(Sender: TObject);
    procedure mnuDirAutTinClick(Sender: TObject);
    procedure mnuRelFatReimprDocumentosClick(Sender: TObject);
    procedure mnuFatResumoCaixaClick(Sender: TObject);
    procedure tmrDataSistemaTimer(Sender: TObject);
    procedure pGeraPopUpFaturamento;
    procedure pGeraPopUpFinanceiro;
    procedure pGeraPopUpMovimentacaoItens;
    procedure pGeraPopUpDASSuvinil;
    procedure pGeraPopUpTintasMaquinas(AOwner: TComponent; Menu: TMenuItem; popMenu: TMenuItem;
  strEsconder: String = ''; blnMenuPath: Boolean = False; blnSomenteRaiz: Boolean = True);
    procedure pGeraPopUpLocacaoEquipamento;
    procedure pGeraPopUpWMS;
    procedure pGeraSubGrupoPopUpWMS(mnuSubMenu, mnuReferencia: TMenuItem; popUp: TAdvPopupMenu; strMenusAdd: String);
    procedure pGeraPopUpWMSRelatorios(mnuSubGrupo, mnuReferencia: TMenuItem; popUp: TAdvPopupMenu; strMenusAdd: String);
    function fCriaNovoSubMenuPopUp(mnuReferencia: TMenuItem; popUp: TAdvPopupMenu): TMenuItem;
    function fHabilitarAtalhoWMS: Boolean;
    procedure btnFaturamentoClick(Sender: TObject);
    procedure mnuReimpressaoDocs2Click(Sender: TObject);
    procedure mnuRelFatListVenRepClick(Sender: TObject);
    procedure mnuCadEventosClick(Sender: TObject);
    procedure mnuRelFatComVendedorClick(Sender: TObject);
    procedure mnuRelCtrCartaCobClick(Sender: TObject);
    procedure mnuCartaAnuenciaClick(Sender: TObject);
    procedure mnuCadTipoAnaliseClick(Sender: TObject);
    procedure mnuCadEspecificacoesTecnicasClick(Sender: TObject);
    procedure mnuControleQualidadeProducaoClick(Sender: TObject);
    procedure mnuRelFiscResumoIcmsClick(Sender: TObject);
    procedure mnuCadEcfClick(Sender: TObject);
    procedure mnuRelFiscOpeInterEntradasClick(Sender: TObject);
    procedure mnuRelFiscOpeInterSaidasClick(Sender: TObject);
    procedure mnuBaixaChequesCustodiaClick(Sender: TObject);
    procedure mnuRelChqEmCustodiaClick(Sender: TObject);
    procedure mnuBaixaCancCustodiaClick(Sender: TObject);
    procedure mnuLiberacaoTransferenciaArmazemClick(Sender: TObject);
    procedure btnCadClientesClick(Sender: TObject);
    procedure btnCadItensClick(Sender: TObject);
    procedure btnTintaMaquinaClick(Sender: TObject);
    procedure btnMovItensClick(Sender: TObject);
    procedure btnFinanceiroClick(Sender: TObject);
    procedure btnResumoCaixaClick(Sender: TObject);
    procedure btnConfiguracoesClick(Sender: TObject);
    procedure mnuRelCtrReimpressaoDocsClick(Sender: TObject);
    procedure mnuCadCndClick(Sender: TObject);
    procedure mnuFatFormulacaoDocumentosClick(Sender: TObject);
    procedure mnuCadFpgClick(Sender: TObject);
    procedure mnuFinDesmRemBancClick(Sender: TObject);
    procedure mnuCadComClick(Sender: TObject);
    procedure mnuCadMotoristasClick(Sender: TObject);
    procedure mnuConsolidacaoDeAdiantamentoDeValoresClick(Sender: TObject);  
    procedure mnuFatRomaneioClick(Sender: TObject);
    procedure mnuFatLiberacaoRomaneioClick(Sender: TObject);
    procedure mnuCadServicosClick(Sender: TObject);
    procedure mnuCadStaSerClick(Sender: TObject);
    procedure mnuCadTipSerClick(Sender: TObject);
    procedure mnuAltPrecoIndividualClick(Sender: TObject);
    procedure mnuTransfLocFisGlobalWMSClick(Sender: TObject);
    procedure mnuGerAutCtaPagarClick(Sender: TObject);
    procedure mnuAcertoContaClick(Sender: TObject);
    procedure mnuCadPromocoesClick(Sender: TObject);
    procedure mnuImpEtiEmpresaClick(Sender: TObject);
    procedure mnuImpEtiEmpresaLazerClick(Sender: TObject);
    procedure mnuImpEtiEmpresaArgoxClick(Sender: TObject);
    procedure mnuCadPromocaoBrindesClick(Sender: TObject);
    procedure mnuInfCobrancaClick(Sender: TObject);
    procedure mnuCadTiposClienteClick(Sender: TObject);
    procedure mnuCadEmiChequesClick(Sender: TObject);
    procedure mnuRelEstatAbcVenRepClick(Sender: TObject);
    procedure mnuTransfCodClienteClick(Sender: TObject);
    procedure mnuRelCtpTitAbertoMesClick(Sender: TObject);
    procedure mnuAltVenRepClick(Sender: TObject);
    procedure mnuTransfCodVendedorClick(Sender: TObject);
    procedure mnuCadEstruturasClick(Sender: TObject);
    procedure mnuGerImpFiscaisClick(Sender: TObject);
    procedure mnuNotaFiscalImportClick(Sender: TObject);
    procedure mnuRelEstSaldoReservadoClick(Sender: TObject);
    procedure mnuCadMetasClick(Sender: TObject);
    procedure mnuCadConciliacaoBancariaClick(Sender: TObject);
    procedure mnuRelEstatAbcProfissionaisClick(Sender: TObject);
    procedure mnuTransCodFornecedorClick(Sender: TObject);
    procedure mnuTransfCodCidadeClick(Sender: TObject);
    procedure mnuManOrdProClick(Sender: TObject);
    procedure mnuBaiOrdProClick(Sender: TObject);
    procedure mnuRelEstatAbcFornecVendaClick(Sender: TObject);
    procedure mnuRedeLojasClick(Sender: TObject);
    procedure mnuCampanhaVendasClick(Sender: TObject);
    procedure mnuFatExpedicaoClick(Sender: TObject);
    procedure mnuFatExpedicaoBaiSepClick(Sender: TObject);
    procedure mnuFatExpedicaoConferenciaRetiraCaixaClick(Sender: TObject);
    procedure mnuCtrLiberacaoFiltrosClick(Sender: TObject);
    procedure mnuAltEfetivacaoPrecosClick(Sender: TObject);
    procedure mnuClassificacaoCestClick(Sender: TObject);
    procedure mnuBonusVendaClick(Sender: TObject);
    procedure mnuCadMetasClientesClick(Sender: TObject);
    procedure mnuTransfCodCtaClick(Sender: TObject);
    procedure mnuRecebimentoClienteClick(Sender: TObject);
    procedure mnuEnvioFornecedorClick(Sender: TObject);
    procedure mnuRetornoFornecedorClick(Sender: TObject);
    procedure mnuEnvioClienteClick(Sender: TObject);
    procedure mnuGerInventarioClick(Sender: TObject);
    procedure mnuManutInventarioClick(Sender: TObject);
    procedure mnuProcessListClick(Sender: TObject);
    procedure mnuRelCurvaAbcCidadeClick(Sender: TObject);
    procedure mnuAgendamentoCiclicoComDiaClick(Sender: TObject);
    procedure mnuGeraAgendaCiclicoComDiaClick(Sender: TObject);
    procedure mnuAtendimentoClick(Sender: TObject);
    procedure mnuRelTelListaAtendimentoClick(Sender: TObject);
    procedure mnuRelTelMapaAtenClick(Sender: TObject);
    procedure mnuGeracaoCodBarrasClick(Sender: TObject);
    procedure mnuGeracaoPedidoTransferenciaAberturaNovaEmpresaClick(Sender: TObject);
    procedure mnuProdutosAgregadosClick(Sender: TObject);
    procedure mnuManClubeFidelidadeClick(Sender: TObject);
    procedure mnuSobreClick(Sender: TObject);
    procedure mnuCadSetoresFilizolaClick(Sender: TObject);
    procedure mnuEtiAvulsaClick(Sender: TObject);
    procedure mnuCadConsumidorClick(Sender: TObject);
    procedure mnuAgrupDuplicatasCtpClick(Sender: TObject);
    procedure mnuLogoffClick(Sender: TObject);
    procedure mnuCadRegioesClick(Sender: TObject);
    procedure mnuDesagrupCtaPagClick(Sender: TObject);
    procedure mnuRelCtpAgrupClick(Sender: TObject);
    procedure mnuManutComProfissionaisClick(Sender: TObject);
    procedure mnuRelFiscTermoAbertClick(Sender: TObject);
    procedure mnuCadBocaCaixaClick(Sender: TObject);
    procedure mnuRelCopiaChequeClick(Sender: TObject);
    procedure tmrMensagemTimer(Sender: TObject);
    procedure tmrLotWmsTimer(Sender: TObject);
    procedure tmrRecorrenciaCrmTimer(Sender: TObject);
    procedure mnuAtualizacaoMargemParaFranquiasClick(Sender: TObject);
    procedure btnMensagemClick(Sender: TObject);
    procedure untCadMsgClick(Sender: TObject);
    procedure mnuADMAdministracaoTEFClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnDASSuvinilClick(Sender: TObject);
    procedure mnuRelComissaoVendedorCTRClick(Sender: TObject);
    procedure mnuRelComissaoProfissionalCTRClick(Sender: TObject);
    procedure mnuCadTelefoneContatoClick(Sender: TObject);
    procedure mnuCalEstMinClick(Sender: TObject);
    procedure mnuConsultaFatCatalogoClick(Sender: TObject);
    procedure mnuImportCatalogoPrecoClick(Sender: TObject);
    procedure mnuBaixaBocaCaixaClick(Sender: TObject);
    procedure mnuFatBaixaRomaneioClick(Sender: TObject);
    procedure mnuRelFatBocaCaixaVendedorClick(Sender: TObject);
    procedure mnuConsultaFatCatalogoAlteracaoClick(Sender: TObject);
    procedure mnuCadMovBancario_TEClick(Sender: TObject);
    procedure mnuFatBaixaEntregaFuturaClick(Sender: TObject);
    procedure mnuCancDepChequePreClick(Sender: TObject);
    procedure mnuAltPrecoGlobalClick(Sender: TObject);
    procedure mnuAltPrecoGlobalCatalogoClick(Sender: TObject);
    procedure mnuTXTACACIAServerExpClick(Sender: TObject);
    procedure mnuTXTACACIAServerImpClick(Sender: TObject);
    procedure mnuRelEstDigitacaoNotaEntradaClick(Sender: TObject);
    procedure mnuManutComProfissionaisIncClick(Sender: TObject);
    procedure mnuEstornaCartoesClick(Sender: TObject);
    procedure mnuEtiEstruturasClick(Sender: TObject);
    procedure mnuEtiDespachoClick(Sender: TObject);
    procedure mnuCalNivGirEstClick(Sender: TObject);
    procedure mnuTransfCodProdutoClick(Sender: TObject);
    procedure tmrTemMsgTimer(Sender: TObject);
    procedure mnuDigCodBarLocFisClick(Sender: TObject);
    procedure mnuManECommerceClick(Sender: TObject);
    procedure stbStatusDblClick(Sender: TObject);
    procedure mnuSelListPrecoClick(Sender: TObject);
    procedure mnuRelacSemelhancaClick(Sender: TObject);
    procedure mnuBalancoEstoqueZeraClick(Sender: TObject);
    procedure mnuBalancoEstoqueImportarClick(Sender: TObject);
    procedure mnuBalancoEstoqueDigManualClick(Sender: TObject);
    procedure mnuBalancoEstoqueGravacaoClick(Sender: TObject);
    procedure mnuFatManConsertoEquipClick(Sender: TObject);
    procedure mnuRelCtrCompAgrupDupClick(Sender: TObject);
    procedure mnuRelFiscResumoApIcmsClick(Sender: TObject);
    procedure mnuRelFiscDiarioAuxiliarClick(Sender: TObject);
    procedure mnuCadFeriadoClick(Sender: TObject);
    procedure mnuFatAltVendedorClick(Sender: TObject);
    procedure mnuCadIndComClick(Sender: TObject);
    procedure mnuCadComPesClick(Sender: TObject);
    procedure mnuCadCotacoesClick(Sender: TObject);
    procedure mnuEntConferenciaClick(Sender: TObject);
    procedure mnuFatAlteraDtaEntFutClick(Sender: TObject);
    procedure mnuPedidoCompraLiberacaoClick(Sender: TObject);
    procedure mnuCadGruComprasClick(Sender: TObject);
    procedure mnuCadOriFgoClick(Sender: TObject);
    procedure mnuEntImportaNotaEletClick(Sender: TObject);
    procedure mnuCadComEntregadoresClick(Sender: TObject);
    procedure mnuCadComFatClick(Sender: TObject);
    procedure mnuBaixaEntregadoresClick(Sender: TObject);
    procedure mnuCtrDescontadaClick(Sender: TObject);
    procedure mnuAlteracaoEntregaFuturaClick(Sender: TObject);
    procedure mnuExpProdColetorClick(Sender: TObject);
    procedure mnuRelCtpTitPagosComChequeClick(Sender: TObject);
    procedure mnuRcxReimpTransferClick(Sender: TObject);
    procedure mnuOrdProdGerAutomClick(Sender: TObject);
    procedure AlteraodaDatadePrevisodosPedidos1Click(Sender: TObject);
    procedure mnuCadGrupoPrecosClick(Sender: TObject);
    procedure CadastrodeSetores1Click(Sender: TObject);
    procedure mnuFatBaixaEmprestimosClick(Sender: TObject);
    procedure mnuCadBocaCaixaAltClick(Sender: TObject);
    procedure mnuFatCancBaixaRomaneioClick(Sender: TObject);
    procedure mnuTransfCheqEmpresaClick(Sender: TObject);
    procedure mnuRelEstatAnalResultMovBanClick(Sender: TObject);
    procedure mnuCadLoteItensClick(Sender: TObject);
    procedure mnuGeraLivroCaixaClick(Sender: TObject);
    procedure mnuRelPosContabilChqClick(Sender: TObject);
    procedure mnuTxtSfaMobImpClick(Sender: TObject);
    procedure mnuImportacaoSfaMobAndroidClick(Sender: TObject);
    procedure mnuRecTransfEstoqueClick(Sender: TObject);
    procedure mnuExportacaoSiteClick(Sender: TObject);
    procedure mnuConsultadeSaldodeContasBancriasClick(Sender: TObject);
    procedure mnuVendasPerdidasDigClick(Sender: TObject);
    procedure mnuExpFunBoshClick(Sender: TObject);
    procedure mnuCadMetasValorClick(Sender: TObject);
    procedure mnuCadMetasGalonagemClick(Sender: TObject);
    procedure mnuTransfCodMarcaClick(Sender: TObject);
    procedure mnuCadVeiculosClick(Sender: TObject);
    procedure mnuTransfCodUnidadeClick(Sender: TObject);
    procedure mnuCtpAtribPortadorClick(Sender: TObject);
    procedure mnuRelFiscNFServicosClick(Sender: TObject);
    procedure mnuRelCtrBorderoClick(Sender: TObject);
    procedure mnuCadDepartamentosClick(Sender: TObject);
    procedure mnuCancDevChequePreClick(Sender: TObject);
    procedure mnuEtiOrcPedClick(Sender: TObject);
    procedure mnuCadBandeirasClick(Sender: TObject);
    procedure mnuRelEstKardexAcabadoClick(Sender: TObject);
    procedure mnuRelCtpReimpBorderoClick(Sender: TObject);
    procedure mnuRelContratoAberturaCreditoClick(Sender: TObject);
    procedure mnuFatReciboAvulsoClick(Sender: TObject);
    procedure mnuTransfCodAtividadeClick(Sender: TObject);
    Procedure pRelCadDireitosDeAcesso(mnuMainMenu: TMainMenu);
    procedure frmRelDireitosDeAcessoClick(Sender: TObject);
    procedure mnuBackupClick(Sender: TObject);
    procedure mnuExportXmlNexxeraClick(Sender: TObject);
    procedure mnuRelCtrLogAcompDuplicClick(Sender: TObject);
    procedure mnuManutKmRodadoClick(Sender: TObject);
    procedure mnuRelCtpKmRodadoVeicClick(Sender: TObject);
    procedure mnuTransfCodDiversosClick(Sender: TObject);
    procedure mnuSenhaOperadorClick(Sender: TObject);
    procedure mnuLocksTravadosClick(Sender: TObject);
    procedure mnuCadComRecClick(Sender: TObject);
    procedure mnuFatControleDataEntregaClick(Sender: TObject);
    procedure mnuRelFatComissaoEspecieCadastroClick(Sender: TObject);
    procedure mnuRelChqTelechequeClick(Sender: TObject);
    procedure mnuReimpressaoBorderoTelechequeClick(Sender: TObject);
    procedure mnuBaixaChequesTelechequeClick(Sender: TObject);
    procedure mnuBaixaCancTelechequeClick(Sender: TObject);
    procedure mnuCadOcorrenciasClick(Sender: TObject);
    procedure mnuRelCtpChequesEmitidosClick(Sender: TObject);
    procedure mnuRelCtrCartaProtestoClick(Sender: TObject);
    procedure mnufrmCadFuncionariosClick(Sender: TObject);
    procedure mnuCadVerbasClick(Sender: TObject);
    procedure mnuDigMovimentoMensalClick(Sender: TObject);
    procedure mnuFatRomManutEntregaClick(Sender: TObject);
    procedure mnuEditorEtiquetasCliLaserClick(Sender: TObject);
    procedure frmEditorEtiquetasCliArgoxClick(Sender: TObject);
    procedure mnuCadMetasRecClick(Sender: TObject);
    procedure mnuEditorEtiquetasForArgoxClick(Sender: TObject);
    procedure mnuEditorEtiquetasForLaserClick(Sender: TObject);
    procedure mnuEditorEtiquetasDivLaserClick(Sender: TObject);
    procedure mnuEditorEtiquetasEstArgoxClick(Sender: TObject);
    procedure mnuEditorEtiquetasOpeLaserClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteLaserClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteLasCodBarPadrClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteLasCodBarPersClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteZebGondCPreClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteZebGondSPreClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteZebCodBarCPreClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteZebCodBarSPreClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteArgGondCPreClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteArgGondSPreClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteArgCodBarCPreClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteArgCodBarSPreClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteOrcPedLasClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteOrcPedLasCodBarClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteOrcPedZebGondCPreClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteOrcPedZebGondSPreClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteOrcPedZebCodBarCPreClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteOrcPedZebCodBarSPreClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteOrcPedArgGondCPreClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteOrcPedArgGondSPreClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteOrcPedArgCodBarCPreClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteOrcPedArgCodBarSPreClick(Sender: TObject);
    procedure mnuEditorEtiquetasDespachoLaserClick(Sender: TObject);
    procedure mnuEditorEtiquetasDespachoArgoxClick(Sender: TObject);
    procedure mnuEditorEtiquetasTintaClick(Sender: TObject);
    procedure mnuCtrLiberacaoFiltrosComercialClick(Sender: TObject);
    procedure mnuCanalAcessoClick(Sender: TObject);
    procedure mnuEditorEtiquetasFormulacaoClick(Sender: TObject);
    procedure mnuAltRegClientesClick(Sender: TObject);
    procedure mnuCadFinClick(Sender: TObject);
    procedure mnuEntPreNotaEntradaClick(Sender: TObject);
    procedure mnuLotePrecosEfetivacaoClick(Sender: TObject);
    procedure mnuEntConferPreNotaClick(Sender: TObject);
    procedure mnuEntEnderecamentoProdutoClick(Sender: TObject);
    procedure mnuFatLiberacaoEntFutClick(
      Sender: TObject);
    procedure mnuFatBaixaPedidoDevClick(Sender: TObject);
    //procedure mnuMonitorReplicacaoClick(Sender: TObject);
    procedure mnuSacAtedimentoClick(Sender: TObject);
    procedure mnuManCentroCustoRateioClick(Sender: TObject);
    procedure mnuReimpressaoCarnePagtoClick(Sender: TObject);
    procedure mnuEditorEtiquetasItensCPFLaserClick(Sender: TObject);
    procedure mnuEditorEtiquetasItensCPFArgoxClick(Sender: TObject);
    procedure mnuEtiqItensCPFClick(Sender: TObject);
    procedure mnuCadVenCndClick(Sender: TObject);
    procedure mnuCadVenMarClick(Sender: TObject);
    procedure mnuCadAjudantesClick(Sender: TObject);
    procedure mnuCadCupomDescontoClick(Sender: TObject);
    procedure mnuFatorPrecoCadastroClick(Sender: TObject);
    procedure mnuFatAcompEntregaClick(Sender: TObject);
    procedure mnuCadastrodeClassificaodeCentrodeCusto1Click(Sender: TObject);
    procedure mnuClassificaodosCentrosdeCustos1Click(Sender: TObject);
    procedure mnuImpressodoBalanceteFinanceiro1Click(Sender: TObject);
    procedure mnuCadComFatVendClick(Sender: TObject);
    procedure mnuCadFaixaFatVendClick(Sender: TObject);
    procedure mnuCadReceitAgronomicoClick(Sender: TObject);
    procedure mnuCadAbreviacaoPISClick(Sender: TObject);
    procedure mnuCadAbreviacaoCOFINSClick(Sender: TObject);
    procedure mnuCadAbreviacaoIPIClick(Sender: TObject);
    procedure mnuCadEnquadramentoIPIClick(Sender: TObject);
    procedure mnuImpEtiqNotaEntradaClick(Sender: TObject);
    procedure mnuAltNumLoteClick(Sender: TObject);
    procedure mnuIntegraDoctorcredClick(Sender: TObject);
    procedure mnuGeraNotaDebitoClick(Sender: TObject);
    procedure mnuGeraDuplicataReceberClick(Sender: TObject);
    procedure pnlLiberaClick(Sender: TObject);
    procedure mnuAltEfetivacaoPrecosTabClick(Sender: TObject);
    procedure mnuVerificadorDeCuponsClick(Sender: TObject);
    procedure mnuRelChqDeletadosClick(Sender: TObject);
    procedure mntmExpGNREdeSaidaClick(Sender: TObject);
    procedure mnuEditorEtiquetasItensQtdRestFatClick(Sender: TObject);
    procedure mnuRelEtiqQtdRestanteClick(Sender: TObject);
    procedure mnuCadCargosClick(Sender: TObject);
    procedure mnuDepartamentosClick(Sender: TObject);
    procedure mnuCadTimeFutebolClick(Sender: TObject);
    procedure mnuCadHobbyClick(Sender: TObject);
    procedure mnuCadEscolaridadeClick(Sender: TObject);
    procedure mnuCadGostoMusicalClick(Sender: TObject);
    procedure mnuCadEstadoCivilClick(Sender: TObject);
    procedure mnuLayoutsImpressaoClick(Sender: TObject);
    procedure mnuCRMClick(Sender: TObject);
    procedure mnuAlteraEstMinMaxClick(Sender: TObject);
    procedure mnuCadGrupoOcorrenciasClick(Sender: TObject);
    procedure mnuCadTiposOcorrenciasClick(Sender: TObject);
    procedure mnuCadSitProdutoClick(Sender: TObject);
    procedure mnuCadMontadorasClick(Sender: TObject);
    procedure mnuCadLocFisicaClick(Sender: TObject);
    procedure mnuCadArmazemClick(Sender: TObject);
    procedure mnuCadPrevisaoMensalClick(Sender: TObject);
    procedure mnuTransfArmazensClick(Sender: TObject);
    procedure mnuCadAutAbaClick(Sender: TObject);
    procedure mnuImportaSPEDPISCOFINSClick(Sender: TObject);
    procedure mnuRelRecPagtoFuncClick(Sender: TObject);
    procedure mnuRelCtpReimpressaoDocsClick(Sender: TObject);
    procedure mnuRelFatExtratoProfissionalClick(Sender: TObject);
    procedure mnuCadComplOcorrenciasClick(Sender: TObject);
    procedure tmrCompromissosTimer(Sender: TObject);
    procedure pnlCompromissosClick(Sender: TObject);
    procedure mnuRelCtpTitDeletadosClick(Sender: TObject);
    procedure mnuEditorEtiquetasItensQtdRestAvuClick(Sender: TObject);
    procedure mnuAltPrecoFornecedorClick(Sender: TObject);
    procedure mnuAltPrecoGlobalCustosForClick(Sender: TObject);
    procedure mnuCadTipoAtendimentoClick(Sender: TObject);
    procedure mnuCadMotVendasPerdidasClick(Sender: TObject);
    procedure mnuTxtImpFullSoftClick(Sender: TObject);
    procedure mnuCadMetasLitragemClick(Sender: TObject);
    procedure mnuCadFreteTranspCidadeClick(Sender: TObject);
    procedure mnuCadSubRegiaoClick(Sender: TObject);
    procedure mnuCadComFatVendDepartClick(Sender: TObject);
    procedure mnuContProgProdClick(Sender: TObject);
    procedure mnuConsControleProducaoClick(Sender: TObject);
    procedure mnuRelEstComparativoPrecosFornecClick(Sender: TObject);
    procedure mnuCadTabelaPrecosClick(Sender: TObject);
    procedure mnuGeraDespesasProtestoClick(Sender: TObject);
    procedure mnuRelCtrCartaDesClick(Sender: TObject);
    procedure mnuCadComFatDepartClick(Sender: TObject);
    procedure mnuCadComFatMarDepartClick(Sender: TObject);
    procedure mnuAnaliseComprasClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure mnuCadCorClick(Sender: TObject);
    procedure mnuEntFreConhecimentoClick(Sender: TObject);
    procedure mnuRelFiscCreIcmVendInterestClick(Sender: TObject);
    procedure mnuCadCompProdAcabClick(Sender: TObject);
    procedure mnuFatRetornoConsignacaoClick(Sender: TObject);
    procedure mnurelFiscGerArqAcSef107_2011Click(Sender: TObject);
    procedure mnuFatFaturaConsignacaoClick(Sender: TObject);
    procedure mnuAltPrecoGlobalNotaClick(Sender: TObject);
    procedure mnuCadFasesClick(Sender: TObject);
    procedure mnuCadCotacaoMoedaClick(Sender: TObject);
    procedure mnuFatConsEntPendentesClick(Sender: TObject);
    procedure mnuBalancoEstoqueDigColetivoClick(Sender: TObject);
    procedure mnuAtribOcorrEmergClick(Sender: TObject);
    procedure mnuEmailMarketingProspectosClick(Sender: TObject);
    procedure mnuAnaliseProducaoClick(Sender: TObject);
    procedure mnuCadEstrIndSubsCompClick(Sender: TObject);
    procedure mnuConfFFemD1Click(Sender: TObject);
    procedure mnuOrdProIndustrialEtqClick(Sender: TObject);
    procedure mnuEditorEtiquetasOPIClick(Sender: TObject);
    procedure mnuConsultaFatLogPromocaoClick(Sender: TObject);
    procedure mnuAltPrecoAcabadosIndClick(Sender: TObject);
    procedure mnuFatDigCartaCorrecaoClick(Sender: TObject);
    procedure mnuNfeInutilizacaoClick(Sender: TObject);
    procedure mnuEditorEtiquetasProducaoTintaClick(Sender: TObject);
    procedure mnuCadMaterialConsumoClick(Sender: TObject);
    procedure mnuReqMaterialConsumoClick(Sender: TObject);
    procedure mnuMapaDemonstrativodeEstoque1Click(Sender: TObject);
    procedure mnuCadGrupoProdutosClick(Sender: TObject);
    procedure mnuEntConferenciaCancelClick(Sender: TObject);
    procedure mnuFatBaixaEntregaFuturaSEPClick(Sender: TObject);
    procedure mnuFatSepFutDigSeparadorClick(Sender: TObject);
    procedure mnuPesarProdutosClick(Sender: TObject);
    procedure btnPesarClick(Sender: TObject);
    procedure mnuFatRetiraDigSeparadorClick(Sender: TObject);
    procedure mnuPedidoDeCompraImpAutcomClick(Sender: TObject);
    procedure mnuRelCadCustosIndustrialClick(Sender: TObject);
    procedure mnuEditorEtiquetasFuncionariosArgoxClick(Sender: TObject);
    procedure mnuEditorEtiquetasFuncionariosLaserClick(Sender: TObject);
    procedure mnuImpEtiquetasFunClick(Sender: TObject);
    procedure mnuCadClassificacaoOnuClick(Sender: TObject);
    procedure mnuGarantiaBaixaRefugoClick(Sender: TObject);
    procedure mnuRelEstatDemonsFatClick(Sender: TObject);
    procedure mnuCadMetasFornecValFatClick(Sender: TObject);
    procedure mnuImportaSPEDFiscalClick(Sender: TObject);
    procedure mnuFatConfirmacaoAjustesClick(Sender: TObject);
    procedure mnuCadFaixasCndPagDescClick(Sender: TObject);
    procedure mnuRelFatComVendCndDesClick(Sender: TObject);
    procedure mnuSolicitacaodeAbastecimentodeTintasdeMaquinaClick(Sender: TObject);
    procedure mnuCadCorVeiClick(Sender: TObject);
    procedure mnCadMarVeiClick(Sender: TObject);
    procedure mnuCadModVeiClick(Sender: TObject);
    procedure mnuConsultaServicosAutocenterClick(Sender: TObject);
    procedure mnuCadMetasValorPedComClick(Sender: TObject);
    procedure mnuPerguntasClick(Sender: TObject);
    procedure mnuPesquisasClick(Sender: TObject);
    procedure mnuRelEstLibArmazenamentoClick(Sender: TObject);
    procedure mnuGerarOrcamentoCompraAutoClick(Sender: TObject);
    procedure mnuFatRequisicaoComprasClick(Sender: TObject);
    procedure mnuBaixaOrdProdGeralClick(Sender: TObject);
    procedure btnRelFatMetasVendedor_DirClick(Sender: TObject);
    procedure mnuTxtImpFullSoftTabletClick(Sender: TObject);
    procedure mnuCadFaixaFaturamentoComissaoCTRClick(Sender: TObject);
    procedure mnuRelFatComFaixaVendedorCTRClick(Sender: TObject);
    procedure mnuFatExpServicosClick(Sender: TObject);
    procedure mnuRelFiscMapaResumoClick(Sender: TObject);
    procedure mnuAgendamentosProgClick(Sender: TObject);
    procedure mnuGerAvisoEmbarqueClick(Sender: TObject);
    procedure mnuCadAliqIBPTClick(Sender: TObject);
    procedure mnuRelEstatResumoCliAtiClick(Sender: TObject);
    procedure mnuCadMetasVendDepProdClick(Sender: TObject);
    procedure mnuCadGrupoAtividadeClick(Sender: TObject);
    procedure mnuCadMetasVendedorAtividadeClick(Sender: TObject);
    procedure mnuCfgCompCustoClick(Sender: TObject);
    procedure mnuAlteracaoTipoAtendPedClick(Sender: TObject);
    procedure mnuCadFaixasVenCndDescClick(Sender: TObject);
    procedure mnuManDesIteClick(Sender: TObject);
    procedure mnuManGarantiaFornecAntEnvioClick(Sender: TObject);
    procedure mnuCadMetasRapelClick(Sender: TObject);
    procedure mnuAltValorEntregaClick(Sender: TObject);
    procedure mnuFatAltComissaoClick(Sender: TObject);
    procedure mnuCadFaixaDescTabPrecoClick(Sender: TObject);
    procedure mnuCadFaixaMargemTabPrecoClick(Sender: TObject);
    procedure mnuImportaNfeParaSpedClick(Sender: TObject);
    procedure mnuFatManifestoEletronicoClick(Sender: TObject);
    procedure mnuFatManutencaoManifestoEletronicoClick(Sender: TObject);
    procedure mnuFatCancelamentoManifestoEletronicoClick(Sender: TObject);
    procedure mnuPreparaGerTEClick(Sender: TObject);
    procedure mnuDigGNREClick(Sender: TObject);
    procedure mnuFatEncerramentoManifestoEletronicoClick(Sender: TObject);
    procedure mnuAnaliseEstoqueEmExcessoClick(Sender: TObject);
    procedure mnuAlteracaoFreteSugestaoClick(Sender: TObject);
    procedure mnuCancelaOrdemProdClick(Sender: TObject);
    procedure mnuImportaMovimentoPAFECFClick(Sender: TObject);
    procedure mnuFatConfOrcamentosSiteEmPedidosClick(Sender: TObject);
    procedure LayoutsdeImpressodoFaturamento1Click(Sender: TObject);
    procedure mnuControleSepAvulsaClick(Sender: TObject);
    procedure mnuGeraVisitaClienteClick(Sender: TObject);
    procedure mnuFatAltComissaoManualCTRClick(Sender: TObject);
    procedure mnuRelComissaoVendedorManualCTRClick(Sender: TObject);
    procedure mnuCadDespFaturamentoClick(Sender: TObject);
    procedure mnuCadProdutosCndPagClick(Sender: TObject);
    procedure mnuManutChqEmiClick(Sender: TObject);
    procedure mnuConsultaServicosClick(Sender: TObject);
    procedure mnuManutCustoProdutosClick(Sender: TObject);
    procedure mnuCadComplVidroClick(Sender: TObject);
    procedure mnuEditorEtiquetasDivArgoxClick(Sender: TObject);
    procedure mnuDigGNRE_EDITClick(Sender: TObject);
    procedure mnuCtpReprogVenClick(Sender: TObject);
    procedure mnuEtiPrecificacaoClick(Sender: TObject);
    procedure mnuCadGruposUnidadeClick(Sender: TObject);
    procedure mnuEditorEtiquetasPreArgoxClick(Sender: TObject);
    procedure mnuEditorEtiquetasPreLaserClick(Sender: TObject);
    procedure dxAlertWindowButtonClick(Sender: TObject;
      AAlertWindow: TdxAlertWindow; AButtonIndex: Integer);
    procedure mnuRelChqLogAcompClick(Sender: TObject);
    procedure mnuRelCtpLogAcompDuplicClick(Sender: TObject);
    procedure mnuCadAdenFatSerClick(Sender: TObject);
    procedure mnuReqEnvioMatVidroClick(Sender: TObject);
    procedure mnuCadMetasCentroCustoClick(Sender: TObject);
    procedure mnuFatPromocaoBrindesClick(Sender: TObject);
    procedure mnuCadEquipamentosIndClick(Sender: TObject);
    procedure mnuOPIndMonitoramentoClick(Sender: TObject);
    procedure mnuCadEstruturasIndustrialDFClick(Sender: TObject);
    procedure mnuCadAnaliseClick(Sender: TObject);
    procedure mnuCadAnaliseMovClick(Sender: TObject);
    procedure mnuConsultarAdiantamentosClick(Sender: TObject);
    procedure mnuCtrGeracaoDesCobChequesClick(Sender: TObject);
    procedure mnuAltPrecoMedioClick(Sender: TObject);
    procedure mnuCadControleCreditoFiscaisClick(Sender: TObject);
    procedure mnuAjusteIcmsSTClick(Sender: TObject);
    procedure mnuReiniciarRoboImportacaoPDVClick(Sender: TObject);
    procedure mnuCadBairrosClick(Sender: TObject);
    procedure mnuCad800Click(Sender: TObject);
    procedure mnuFatAtivaPreRomaneioClick(Sender: TObject);
    procedure mnuCadLocalizacaoSeparacaoClick(Sender: TObject);
    procedure mnuCadFasObrClick(Sender: TObject);
    procedure mnuFatAltMecanicoClick(Sender: TObject);
    procedure mnuCadSitOcoClick(Sender: TObject);
    procedure mnuPlanodecontascontabeisClick(Sender: TObject);
    procedure mnuCadAdquirenteCartaoClick(Sender: TObject);
    procedure mnuSacMotivosAtendClick(Sender: TObject);
    procedure mnuGeoSalesExportarClick(Sender: TObject);
    procedure mnuManutencaoLoteMPClick(Sender: TObject);
    procedure mnuCadProspectosClick(Sender: TObject);
    procedure mnuGeoSalesImportarClick(Sender: TObject);
    procedure mnuAgruPedOrdProIndClick(Sender: TObject);
    procedure mnuImportTabPrecosItegerClick(Sender: TObject);
    procedure mnuImportMargemLucroTabPrecoClick(Sender: TObject);
    procedure mnuImportComisVendTabPrecoClick(Sender: TObject);
    procedure mnuOrdProAtualizaPrecosClick(Sender: TObject);
    procedure mnuAjusteEstoqueContraPartidaClick(Sender: TObject);
    procedure mnuConferenciaPreNotaCancelClick(Sender: TObject);
    procedure mnuCadMotivoReprovacaoClick(Sender: TObject);
    procedure mnuCadDefeitosClick(Sender: TObject);
    procedure mnuCadEquipamentosClick(Sender: TObject);
    procedure mnuCadPadraQualidadeIndClick(Sender: TObject);
    procedure mnuLiberaPrepTEClick(Sender: TObject);
    procedure mnuTriggerCRMClick(Sender: TObject);
    procedure mnuEtqProdutosControladosClick(Sender: TObject);
    procedure mnuEditorEtiquetasProdutosContArgoxClick(Sender: TObject);
    procedure mnuEditorEtiquetasProdutosContLaserClick(Sender: TObject);
    procedure mnufrmEditorEtiquetasOrdemServicoArgoxClick(Sender: TObject);
    procedure mnufrmEditorEtiquetasOrdemServicoLaserClick(Sender: TObject);
    procedure mnuCadLocFisAmostraProducaoClick(Sender: TObject);
    procedure mnuEditorEtiquetasOrdemServicoZebraClick(Sender: TObject);
    procedure mnuFatAlteraTransRomaneioClick(Sender: TObject);
    procedure mnuAltGlobalPromocoesClick(Sender: TObject);
    procedure mnuCadParceirosClick(Sender: TObject);
    procedure mnuGrupoServicosClick(Sender: TObject);
    procedure mnuCadNegociacaoClientesClick(Sender: TObject);
    procedure mnuImpressaoCPClick(Sender: TObject);
    procedure mnuRessarcImpRetidoPorSujeicaoPassivaSubstClick(Sender: TObject);
    procedure mnuConsultaRelatMenuClick(Sender: TObject);
    procedure mnuCadModelosRelClick(Sender: TObject);
    procedure mnuCadRelatoriosClick(Sender: TObject);
    procedure mnuCadDirVerdeVermelhoClick(Sender: TObject);
    procedure mnuEmailMarketingClienteClick(Sender: TObject);
    procedure mnuProfissionaisClick(Sender: TObject);
    procedure mnuFatDesmembrarPedidoClick(Sender: TObject);
    procedure mnuExportacaoSEFAZClick(Sender: TObject);
    procedure mnuImportacaoSEFAZClick(Sender: TObject);
    procedure mnuImpEtiOrdProClick(Sender: TObject);
    procedure mnuEtiquetaLoteProdutoClick(Sender: TObject);
    procedure mnuEtiLoteProdLaserClick(Sender: TObject);
    procedure mnuEtiLoteProdArgoxClick(Sender: TObject);
    procedure mnuCadFrequenciaCRMClick(Sender: TObject);
    procedure mnuCadPorteCRMClick(Sender: TObject);
    procedure mnuCadFaixaFatuEstimadoCRMClick(Sender: TObject);
    procedure mnuCadForAtuCRMClick(Sender: TObject);
    procedure mnuRelCtrExportaCobrancaClick(Sender: TObject);
    procedure mnuManutancaoDescontoEmbalagemClick(Sender: TObject);
    procedure btnCRMClick(Sender: TObject);
    procedure mnuCadCliVenClick(Sender: TObject);
    procedure mnuMovEcfPafClick(Sender: TObject);
    procedure mnuCadMovFlexClick(Sender: TObject);
    procedure mnuBaixaCreditosFlexClick(Sender: TObject);
    procedure btnEnvioEmailClick(Sender: TObject);
    procedure mnuCadMotivoVerbasClick(Sender: TObject);
    procedure mnuCadVerbasCliForClick(Sender: TObject);
    procedure mnuRelEstCMVClick(Sender: TObject);
    procedure mnuPedeUnificacaoPedidosClick(Sender: TObject);
    procedure mnuGarantiaGeraCreditosClick(Sender: TObject);
    procedure mnuEntFreConImportacaoSaidaClick(Sender: TObject);
    procedure mnuEntFreConImportacaoEntradaClick(Sender: TObject);
    procedure mnuFatRomaneioPedidosNaoFaturadosClick(Sender: TObject);
    procedure mnuRelacaoNetpointsClick(Sender: TObject);
    procedure mnuPainelECommerceClick(Sender: TObject);
    procedure mnuCadComboProdVendaClick(Sender: TObject);
    procedure mnuFaixasCondPagAgrClick(Sender: TObject);
    procedure mnuCtpLiberacaoBaixaClick(Sender: TObject);
    procedure mnuImportacaoRetCustodiaClick(Sender: TObject);
    procedure mnuBoxEntregaClick(Sender: TObject);
    procedure mnuGeraVisitaClienteIndividualClick(Sender: TObject);
    procedure mnuCTRReajusteClick(Sender: TObject);
    procedure mnuLogAcompPedidosClick(Sender: TObject);
    procedure mnuCadClientesDescontoClick(Sender: TObject);
    procedure mnuCadRegioesDescontoClick(Sender: TObject);
    procedure mnuCadDescontoClienteProdutoClick(Sender: TObject);
    procedure mmuRelCtrReceberClick(Sender: TObject);
    procedure mnuEnvInterfaceAnaliticaClick(Sender: TObject);
    procedure mnuCadConciliaAcumuloNetpointsClick(Sender: TObject);
    procedure mnuRelFatDocTintaClick(Sender: TObject);
    procedure mnuRelSimplesNacionalClick(Sender: TObject);
    procedure mnuTabelaFatSimplesClick(Sender: TObject);
    procedure mnuCadEmbarcacoesClick(Sender: TObject);
    procedure pnlEsquerdaClick(Sender: TObject);
    procedure pnlEsquerdaEnter(Sender: TObject);
    procedure pnlRodapeEnter(Sender: TObject);
    procedure pnlRodapeClick(Sender: TObject);
    procedure pnlBaixoClick(Sender: TObject);
    procedure pnlBaixoEnter(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure mnuCadPagBoschClick(Sender: TObject);
    procedure mnuImportaProdFranqClick(Sender: TObject);
    procedure mnuReplicaodeArmazensProdutosClick(Sender: TObject);
    procedure mnuContratosCorreiosClick(Sender: TObject);
    procedure mnuManCadCidadeSigepClick(Sender: TObject);
    procedure mnuCadPosClick(Sender: TObject);
    procedure mnuCadAgendamentodeEntregaClick(Sender: TObject);
    procedure mnuRecebimentoEntregaAgendadaClick(Sender: TObject);
    procedure mnuPlanoDeRecebimentoClick(Sender: TObject);
    procedure mnuManutencaoDocasClick(Sender: TObject);
    procedure mnuCadDocasClick(Sender: TObject);
    procedure mnuImpEtiLocalizacaoClick(Sender: TObject);
    procedure mnuEtiLocFisLaserClick(Sender: TObject);
    procedure mnuEtiLocFisArgoxClick(Sender: TObject);
    procedure mnuEtiquetasPlanoRecebimentoLaserClick(Sender: TObject);
    procedure mnuEtiquetasPlanoRecebimentoArgoxClick(Sender: TObject);
    procedure mnuEtiquetasSeqSeparacaoWMSLaserClick(Sender: TObject);
    procedure mnuEtiquetasSeqSeparacaoWMSArgoxClick(Sender: TObject);
    procedure mnuEntMercadoriasEfetivaMovFiscalClick(Sender: TObject);
    procedure mnuCadClasseLocFisClick(Sender: TObject);
    procedure mnuMapeamentoItemClasseLocFisClick(Sender: TObject);
    procedure mnuBaixaVolumesClick(Sender: TObject);
    procedure mnuCadAdquirenteClick(Sender: TObject);
    procedure ContaCorrente1Click(Sender: TObject);
    procedure mnuLiberacaoAcompEntregasClick(Sender: TObject);
    procedure imgLogoDarkClick(Sender: TObject);
    procedure mnuRelCartoesLogAcompClick(Sender: TObject);
    procedure mnuAjustesIcmsClick(Sender: TObject);
    procedure mnuImportPrecoVendaTabPrecoConfirmaClick(Sender: TObject);
    procedure mnuCadTemplatesClick(Sender: TObject);
    procedure mnuCadAjuRelatorioClick(Sender: TObject);
    procedure mnuCadInstrucoesClick(Sender: TObject);
    procedure mnuTransfCodPortadorClick(Sender: TObject);
    procedure mnuTransfCodTransportadoraClick(Sender: TObject);
    procedure mnuImportCadProdutoClick(Sender: TObject);
    procedure mnuImportCadEstruturaClick(Sender: TObject);
    procedure ArquivamentodeDocumentos1Click(Sender: TObject);
    procedure mnuDigSerieProdRastreaveisClick(Sender: TObject);
    procedure mnuRestituicaoIcmsSTClick(Sender: TObject);
    procedure mnuFatAltEmbarcacaoClick(Sender: TObject);
    procedure mnuExportaXMLNotasRomaneioClick(Sender: TObject);
    procedure mnuCadFatMetasVendedorFatLiqClick(Sender: TObject);
    procedure mnuCadEquLocacaoClick(Sender: TObject);
    procedure mnuContratLocacaoClick(Sender: TObject);
    procedure mnuInspLibEquipClick(Sender: TObject);
    procedure mnuEnvioEquipClick(Sender: TObject);
    procedure mnuRetornoEquipClick(Sender: TObject);
    procedure mnuFatLocEquipClick(Sender: TObject);
    procedure mnuControleDeEstoqueCat1799Click(Sender: TObject);
    procedure mnuEditorEtiquetasOPLaserArgoxClick(Sender: TObject);
    procedure mnuEditorEtiquetasOPLaserClick(Sender: TObject);
    procedure mnuEditorEtiquetasOPLaserZebraClick(Sender: TObject);
    procedure mnuManutInventarioLoteClick(Sender: TObject);
    procedure mnuEditorEtiquetasCaixasArgoxClick(Sender: TObject);
    procedure mnuEditorEtiquetasCaixasLaserClick(Sender: TObject);
    procedure mnuEtiquetaCaixasClick(Sender: TObject);
    procedure mnuOrdemServicoProdVendaClick(Sender: TObject);
    procedure mnuReimpEtiOrdServicoClick(Sender: TObject);
    procedure mnuOcorrenciasRomaneioClick(Sender: TObject);
    procedure mnuRelFatEtiArmazenamentoClick(Sender: TObject);
    procedure mnuEtiquetasArmazenamentoLaserClick(Sender: TObject);
    procedure mnuEtiquetasArmazenamentoArgoxClick(Sender: TObject);
    procedure mnuEtiquetasArmazenamentoZebraClick(Sender: TObject);
    procedure mnuCadNBSClick(Sender: TObject);
    procedure mnuCadIndicadorOperacaoServicoClick(Sender: TObject);
    procedure mnuCadBoxWmsClick(Sender: TObject);
    procedure mnuConsultaPedidosPendClick(Sender: TObject);
    procedure mnuRotasRegiaoClick(Sender: TObject);
    procedure mnuEntregasRegiaoClick(Sender: TObject);
    procedure mnuCalNivCriEstClick(Sender: TObject);
    procedure mnuGrupoRiscoClick(Sender: TObject);
    procedure mnuGerAutCtaReceberClick(Sender: TObject);
    procedure mnuOrdProdGeracaoAutomaticaEstoqueClick(Sender: TObject);
    procedure mnuEtiqOrdSerVendaLaserClick(Sender: TObject);
    procedure mnuEtiqOrdSerVendaArgoxClick(Sender: TObject);
    procedure mnuEtiqOrdSerVendaZebraClick(Sender: TObject);
    procedure mnuAltVendTempClick(Sender: TObject);
    procedure mnuCadEpiClick(Sender: TObject);
    procedure mnuFormulasClick(Sender: TObject);
    procedure mnuManOrdProIndustrialClick(Sender: TObject);
    procedure mnuBaixaOrdProdIndustrialClick(Sender: TObject);
    procedure mnuTransCodCorIndustrialClick(Sender: TObject);
    procedure mnuCancelaOrdemProdIndustrialClick(Sender: TObject);
    procedure mnuManGerAutCtaPagarClick(Sender: TObject);
    procedure mnuRelCatalogoLinhaGrupoClick(Sender: TObject);
    procedure mnuRelCatalogoProdutoClick(Sender: TObject);
    procedure mnuCadFaixaPrzMedClick(Sender: TObject);
    procedure mnuLibVendasEntregaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tmrTestaLogReplicacaoTimer(Sender: TObject);
    procedure mnuCadFinalidadeAjusteClick(Sender: TObject);
    procedure mnuEtiquetasSeparacaoErradaArgoxClick(Sender: TObject);
    procedure mnuEtiquetasSeparacaoErradaLaserClick(Sender: TObject);
    procedure mnuSpoolTransferenciaEdicaoClick(Sender: TObject);
    procedure mnuCadFreteFaixaFaturamentoClick(Sender: TObject);
    procedure mnuConfirmaEspelhoClick(Sender: TObject);
    procedure mnuEntConferPreNotaWMSDevolucaoClick(Sender: TObject);
    procedure mnuPreNotaCancelClick(Sender: TObject);
    procedure tmrSincEmailTimer(Sender: TObject);
    procedure mnuImpRecCobrancaClick(Sender: TObject);
    procedure mnuBalancoIniciaArmazemClick(Sender: TObject);
    procedure mnuBalancoFinalizaArmazemClick(Sender: TObject);
    procedure ApplicationEventsActivate(Sender: TObject);
    procedure mnuMapeamentoLocalizacaoFisicaClick(Sender: TObject);
    procedure mnuLOGAlteraesEndereodeEntregaClick(Sender: TObject);
    procedure mnuLiberaodePedidosExternosClick(Sender: TObject);
    procedure mnuCadMatrizAliquotasIcmsClick(Sender: TObject);
    procedure mnuCadMatrizAliquotasFCPClick(Sender: TObject);
    procedure mnuCadNCMClick(Sender: TObject);
    procedure mnuEntradaAutomatizadaNotasClick(Sender: TObject);
    procedure mnuFatAltLoteItemClick(Sender: TObject);
    procedure mnuInativarLotesSemSaldoClick(Sender: TObject);
    procedure mnuCadBeneficioFiscalClick(Sender: TObject);
    procedure mnuRelFatFichaTecnicaProdutosOrcamentoClick(Sender: TObject);
    procedure tmrMonitorTimer(Sender: TObject);
    procedure tmrGatimeTimer(Sender: TObject);
    procedure mnuEtiquetasCodBarrasProdutoExpedicaoLaserClick(Sender: TObject);
    procedure mnuVendaRemessaForadoEstabelecimentoRemessaClick(Sender: TObject);
    procedure mnuVendaRemessaForadoEstabelecimentoRetornoClick(Sender: TObject);
    procedure mnuVendaRemessaForadoEstabelecimentoFaturamentoClick(
      Sender: TObject);
    procedure mnumportarArquivoParaAnalisedeComprasClick(Sender: TObject);
    procedure mnuDigRecursosProjetoClick(Sender: TObject);
    procedure mnuCadProjetosClick(Sender: TObject);
    procedure mnuCadRecursoProjetoClick(Sender: TObject);
    procedure mnuImpKonciliaClick(Sender: TObject);
    procedure mnuConciliaoKonciliaClick(Sender: TObject);
    procedure mnuEditorEtiquetasDespachoLaserECommerceClick(Sender: TObject);
    procedure mnuManutencaoEmpresaCentralizadoraClick(Sender: TObject);
    procedure mnuCadAtributosClick(Sender: TObject);
    procedure mnuCadGrupoAtributoClick(Sender: TObject);
    procedure mnuAtualizacaoCotacaoDolarNosCatalogosClick(Sender: TObject);    
    procedure mnuCodigoTipodeServicoClick(Sender: TObject);
    procedure mnuCadProdutosAltoGiroClick(Sender: TObject);
    procedure mnuRestauraDuplicataMercantilClick(Sender: TObject);
    procedure mnuCadMetasVendLinhaGrupoProdClick(Sender: TObject);
    procedure mnuControledeCanhotosdeNotasFiscaisEmitidasClick(Sender: TObject);
    procedure mmuCadMetasCobrancaClick(Sender: TObject);
    procedure mnuEtiquetasLoteRastreamentoProdutoLaserClick(Sender: TObject);
    procedure mnuEtiquetasLoteRastreamentoProdutoArgoxClick(Sender: TObject);
    procedure mnuEtiquetasLoteRastreamentoProdutoZebraClick(Sender: TObject);
    procedure mnuLoteRastreamentoProdutoClick(Sender: TObject);
    procedure mnuProdutoCadastroRapidoLoteRastreamentoClick(Sender: TObject);
    procedure mnuDigAtualizaPrecoClick(Sender: TObject);
    procedure mnuCadBandeiraEmpresaClick(Sender: TObject);
    procedure mnuCadParametrosEmpresaClick(Sender: TObject);
    procedure mnuPastaCompraConsultaClick(Sender: TObject);
    procedure mnuCadLimiteComprasFornecedorClick(Sender: TObject);
    procedure mnuFatManifestoEletronicoEncerradosClick(Sender: TObject);
    procedure mmuRelCbaLogAcompMovBanNovoClick(Sender: TObject);
    procedure mnuManutencaoEmpresasDestinoMultiLojasClick(Sender: TObject);
    procedure mnuEnvioConfirmacaoSefazClick(Sender: TObject);
    procedure mnuEntImportaNotaEletDivFiscalClick(Sender: TObject);
    procedure mnuUltimosFechamentosEstoqueClick(Sender: TObject);
    procedure mnuUltimosFechamentosFiscaisClick(Sender: TObject);
    procedure mnuCadFreteTranspRegiaoClick(Sender: TObject);
    procedure mnuCadConcorrenciaClick(Sender: TObject);
    procedure mnuQualificaodeClientesClick(Sender: TObject);
    procedure mnuCategoriaOrcamentoPedidoClick(Sender: TObject);
    procedure mnuFechamentoFinanceiroClick(Sender: TObject);
    procedure mnuAtivaoeInativaodeNFCeOffLine1Click(Sender: TObject);
    procedure mnuCadFaixaDescTabPrecoLinhaGrupoClick(Sender: TObject);
    procedure mnuCadCaixasClick(Sender: TObject);
    procedure mnuRcxTransfLancamentosEntreCaixasClick(Sender: TObject);
    procedure mnuCtpLiberacaoPrevisaoClick(Sender: TObject);
    procedure mnuFluxoComprasClick(Sender: TObject);
    procedure mnuPaineldeRequisicoesDeComprasClick(Sender: TObject);
    procedure mnuCadCnaeClick(Sender: TObject);
    procedure mnuCadComFat2Click(Sender: TObject);
    procedure mnuFatRegClick(Sender: TObject);
    procedure mnuDigTCIFClick(Sender: TObject);
    procedure mnuDigTSClick(Sender: TObject);   
    procedure mnuDigTCIF_EDITClick(Sender: TObject);
    procedure mnuDigTS_EDITClick(Sender: TObject);
    procedure mnuCadMetasFaturamentoServicoPorFaixaClick(Sender: TObject);
    procedure mnuFatManConsertoEquipTecClick(Sender: TObject);
    procedure mnufrmCadFuncoesClick(Sender: TObject);
    procedure mnuMontQuadroFuncEventoClick(Sender: TObject);
    procedure mnuCadEmpresasEstoqueExternoClick(Sender: TObject);
    procedure mnuMandaeEnvioEncomendasClick(Sender: TObject);
    procedure mnuRcxLiberacaoDeCaixasClick(Sender: TObject);
    procedure mnuAlteracaoGeraldePrecosdeProdutosClick(Sender: TObject);
    procedure mnuAjusteEstoqueSaldoExternoClick(Sender: TObject);
    procedure mnuAlteracaoGlobalProdutosAcabadosClick(Sender: TObject);
    procedure mnuCadCupomPromProdClick(Sender: TObject);
    procedure mnuFatManifestoEletronicoEventoPagamentoOperacaoTransporteClick(
      Sender: TObject);
    procedure mnuEntradaAutomatizadaImportacaoClick(Sender: TObject);
    procedure mnuCadGPCClick(Sender: TObject);
    procedure mnuGerarGTINAtualizarCadastroGS1CNPClick(Sender: TObject);
    procedure mnuRelMapaDeCaontagemClick(Sender: TObject);
    procedure frmNotasFulfillmentPatClick(Sender: TObject);
    procedure mnuCadLocalArmazenamentoWMSClick(Sender: TObject);
    procedure mnuEtiquetasLocalArmazenamentoWMSArgoxClick(Sender: TObject);
    procedure mnuEtiquetasLocalArmazenamentoWMSLaserClick(Sender: TObject);
    procedure mnuImpEtiLocalArmazenamentoWmsClick(Sender: TObject);
    procedure mnuEtiquetasRegioesArgoxClick(Sender: TObject);
    procedure mnuEtiquetasRegioesLaserClick(Sender: TObject);
    procedure mnuImpEtiRegiaoClick(Sender: TObject);
    procedure mnuCadTipoProjetoClick(Sender: TObject);
    procedure mnuMatrizCadNovosProdutosClick(Sender: TObject);
    procedure mnuFatTransfEstDevEmpCarregamentoClick(Sender: TObject);
    procedure mnuTransCodPlacaVeiculoClick(Sender: TObject);
    procedure mnuDashboardClick(Sender: TObject);
    procedure mnuRelacionamentoClienteProdutoGarantiaClick(Sender: TObject);
    procedure mnuPrioridadeSaidaEstoqueEmpresaClick(Sender: TObject);
    procedure mnuManutencaoCteClick(Sender: TObject);
    procedure mnuCadSinaleiroFaturamentoClick(Sender: TObject);
    procedure mnuCadComissaoProdTabPreClick(Sender: TObject);
    procedure mnuCadCategoriaCRMClick(Sender: TObject);
    procedure pnlLiberaPedComClick(Sender: TObject);
    procedure mnuCadPendenciasClick(Sender: TObject);
    procedure mnuCadMatrizBasesDifalClick(Sender: TObject);
    procedure mnuAltGlobalVenMarClick(Sender: TObject);
    procedure mnuFatRomaneioManutencaoClick(Sender: TObject);
    procedure mnuCadCfgTerminalTefClick(Sender: TObject);
    procedure mnuFaixasCondPagGeraNotaDebitoClick(Sender: TObject);
    procedure mnuFatBaixaEntregaFutura49Click(Sender: TObject);
    procedure mnuReimpReciboComissaoProfissionaisClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteArgGondCPreLayout1Click(Sender: TObject);
    procedure mnuCtrReprogVenClick(Sender: TObject);
    procedure mnuRestauraPrecoClick(Sender: TObject);
    procedure mnuCadCotacaoRelacClick(Sender: TObject);
    procedure mnuCadAcessoriosClick(Sender: TObject);
    procedure mnuCadEstProdutoClick(Sender: TObject);
    procedure mnuFatManConsertoFluxoProcessoClick(Sender: TObject);

    procedure mnuCadFaixasCatEtiqProdutoClick(Sender: TObject);
    procedure mnuCadTiposCotacaoPedidoCompraClick(Sender: TObject);
    procedure mnuCadCentroCustoImobilizadoClick(Sender: TObject);
    procedure mnuTransfCodAcessorioClick(Sender: TObject);
    procedure mnuPromocaoAutCadastroClick(Sender: TObject);
    procedure mnuPromocaoAutAtivacaoClick(Sender: TObject);
    procedure mnuCadFasApontamentoClick(Sender: TObject);
    procedure mnuReiniciarRoboImportacaoCTeClick(Sender: TObject);
    procedure mnuFatDigitalizacaoDocumentosClick(Sender: TObject);
    procedure mnuNegociacaoOrdemServicoClick(Sender: TObject);
    procedure mnuCadAclLocacaoClick(Sender: TObject);
    procedure mnuCadLocalDaMercadoriaClick(Sender: TObject);
    procedure mnuConsultaControleDeColetaClick(Sender: TObject);
    procedure mmoEstornoComissaoProfissionaisClick(Sender: TObject);
    procedure mnuEditorEtiquetasMontagemCaixasLaserClick(Sender: TObject);
    procedure mnuEditorEtiquetasMontagemCaixasLaserComCodBarrasClick(Sender: TObject);
    procedure mnuTipoImobilizadoClick(Sender: TObject);
    procedure mnuCadImobilizadoClick(Sender: TObject);
    procedure mnuCadDescontoClientesMarcasClick(Sender: TObject);
    procedure btnLocacaoEquipamentoClick(Sender: TObject);
    procedure mnuLibLocEquipClick(Sender: TObject);
    procedure mnuMenuFiscalPafNFCeClick(Sender: TObject);
    procedure mnuCadPontosImpressaoClick(Sender: TObject);
    procedure mnuCadCondPagtoEspecialProdutosClick(Sender: TObject);
    procedure mnuMovimentacaoProgramadaManualClick(Sender: TObject);
    procedure mnuTrocaLocEquClick(Sender: TObject);
    procedure mnuCalNivGirEstFornecedorClick(Sender: TObject);
    procedure mnuFatMensalLocEquipClick(Sender: TObject);
    procedure mnuCancelamentoPedidoJadlogClick(
      Sender: TObject);
    procedure mnuPainelAcompanhamentoOSClick(Sender: TObject);
    procedure mnuProrrogaContratoLocEqClick(Sender: TObject);
    procedure mnuRelLiberacaoRemotaClick(Sender: TObject);
    procedure mnuCancelaLocEquClick(Sender: TObject);
    procedure mnuFatRomaneioSimplificadoClick(Sender: TObject);
    procedure mnuGerarOrdemdeProducaoPorArquivoDeImportacaoClick(Sender: TObject);
    procedure mnuManutencaoLocEqClick(Sender: TObject);
    procedure mnuReimpressaoCompInspecaoClick(Sender: TObject);
    procedure mnuRelacaoPedidosPixGeradosClick(Sender: TObject);
    procedure mnuMapaDeInventarioParaColetoresClick(Sender: TObject);
    procedure mnuFatLibReservaEstoqueOSClick(Sender: TObject);
    procedure mnuFatExclusaoVendasPerdidasClick(Sender: TObject);
    procedure mnuGarantiaRetornoColetaClick(Sender: TObject);
    procedure mnuLiberaRomaneiosAppEntregaClick(Sender: TObject);
    procedure mnuCadOcorrenciaEntregaClick(Sender: TObject);
    procedure mnuEditorEtiquetasIteLasCodBarSPreClick(Sender: TObject);
    procedure mnuBaixarGarantiaEnviaaoFornecedorClick(Sender: TObject);
    procedure mnuRecorrenciaOcorrenciaClick(Sender: TObject);
    procedure mnuPortosClick(Sender: TObject);
    procedure mnuAeroportosClick(Sender: TObject);
    procedure mnuIncotermsClick(Sender: TObject);
    procedure mnuEnderecamentoMarmoreGranitoClick(Sender: TObject);
    procedure mnuEtiquetasMarmoreGranitoClick(Sender: TObject);
    procedure mnuEtiquetasMarmoreGranitoArgoxClick(Sender: TObject);


    procedure mnuCfgEfdSpedContribuicaoClick(Sender: TObject);
    procedure mnuPedidoDeCompraImpEdiSawluzClick(Sender: TObject);
    procedure mnuEtiquetasMontagemArgoxClick(Sender: TObject);
    procedure mnuEtiquetasMontagemZebraClick(Sender: TObject);
    procedure mnuEtiquetaDoProdutoSeparadoLaserClick(Sender: TObject);
    procedure mnuEtiquetaDoProdutoSeparadoArgoxClick(Sender: TObject);
    procedure mnuEtiquetadoProdutoSeparado_QtdRestanteClick(Sender: TObject);
    procedure mnuAvaliacaoGarantiaPropriaEmpresaClick(Sender: TObject);
    procedure mnuEtiquetasProdutoControladoVendaLaserClick(Sender: TObject);
    procedure mnuEtiquetasProdutoControladoVendaArgoxClick(Sender: TObject);
    procedure mnuEtiquetasProdutoControladoVendaZebraClick(Sender: TObject);

    procedure mnuPgtoOnlineESiTefManutencaoClick(Sender: TObject);
    procedure mnuPgtoOnlineESiTefParChavesManutencaoClick(Sender: TObject);
    procedure mnuRelEstOrdensBaixadasParcialmenteEmAbertoClick(Sender: TObject);
    procedure mnuCadMetaCompDepVendClick(Sender: TObject);
    procedure mnuEditorEtiquetasMontagemCaixasZebraPackListClick(
      Sender: TObject);
    procedure mnuCadCorrecaoOrdProducaoIndustrialClick(Sender: TObject);
    procedure mnuBaixaOrdemProducaoIndustrialGeralClick(Sender: TObject);
    procedure mnuEditorEtiquetasMontagemCaixasLaserPackListClick(
      Sender: TObject);
    procedure mnuPainelEntregasClick(Sender: TObject);
    procedure mnuConsultaCadLocEquClick(Sender: TObject);
    procedure mnuTransfTabelasClick(Sender: TObject);
    procedure mnuAcertoDeContasDeProfissionaisClick(Sender: TObject);
    procedure mnuAltGlobalServicoClick(Sender: TObject);
    procedure mnuCadCotacaoDiariaCombustiveisClick(Sender: TObject);
    procedure mnuEditorEtiquetasIndividuaisDespachoProdutoArgoxClick(
      Sender: TObject);
    procedure mnuRelCtrCartaNotifExtrajudicialClick(Sender: TObject);
    procedure mnuGatilhoCtrEnviaExtratoCobrancaClick(Sender: TObject);
    procedure mnuRecebimentoTransbordoClick(Sender: TObject);
    procedure frmCfgSpedFiscalClick(Sender: TObject);
    procedure mnuDescontoMaximoPorAtividadeClick(Sender: TObject);
    procedure mnuMargemMinimaPorAtividadeClick(Sender: TObject);
    procedure mnuCadMotFinOcoClick(Sender: TObject);
    procedure mnuCadMotivoPausaAppEntregaClick(Sender: TObject);
    procedure mnuBoxEntregaImediataClick(Sender: TObject);
    procedure mnuAltPrecoRecalcClick(Sender: TObject);
    procedure mnuCadCarteiraDigitalClick(Sender: TObject);
    procedure mnuRelatorioAcompanhamentoPixClick(Sender: TObject);
    procedure mnuCadFreteRegiaoClick(Sender: TObject);
    procedure mnuPainelRessuprimentosClick(Sender: TObject);
    procedure mnuTranferenciaPedidoMultiLojaClick(Sender: TObject);
    procedure frmImpPaginaClick(Sender: TObject);
    procedure frmAlterarPaginaRevistaClick(Sender: TObject);
    procedure mnuImportaPrecosClick(Sender: TObject);
    procedure mnuCadTemperaturaAtendimentoCRMClick(Sender: TObject);
    procedure mnuConsultoriaFiscalSaneamentoClick(Sender: TObject);
    procedure mnuManutencaoOrigemProdAcabadosClick(Sender: TObject);
    procedure mnuImportaoXMLdeNFEparaAuditoriaClick(Sender: TObject);
    procedure mnuAlterarPrazoGarantiaClick(Sender: TObject);
    procedure mnufrmImportarCadLocEquClick(Sender: TObject);
    procedure mnuOutrasDespesasAposEntradaClick(Sender: TObject);
    procedure mnuCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresaClick(
      Sender: TObject);
    procedure mnuCadFaixaFaturamentoDeptoVendProdClick(
      Sender: TObject);
    procedure mnuCadMotivosAproveitamentoItensClick(Sender: TObject);
    procedure fraPesquisarMenubtnDashboardClick(Sender: TObject);
    procedure frmConEquipAtualizaProdutosReqCompraClick(Sender: TObject);
    procedure mnuEditorEtiquetasIDDoPlanoDeRecebimentoLaserClick(
      Sender: TObject);
    procedure mnuEditorEtiquetasIDDoPlanoDeRecebimentoArgoxClick(
      Sender: TObject);
    procedure mnuCadAssistenciaTecnicaClick(Sender: TObject);
    procedure mnuChecklistValidacaoGarantiaClick(Sender: TObject);
    procedure mnuConfTintaMaquinaClick(Sender: TObject);
    procedure mnuConfiguracoesGlasuritClick(Sender: TObject);
    procedure mnuCadGlaBasesClick(Sender: TObject);
    procedure mnuCadGlaNovasFormulasClick(Sender: TObject);
    procedure mnuCadGlaGeraArquivoClick(Sender: TObject);
    procedure mnuConsultaGlasuritClick(Sender: TObject);
    procedure mnuCadGlaGerNfmClick(Sender: TObject);
    procedure mnuConfiguracoesSalcomixClick(Sender: TObject);
    procedure mnuCadSalBasesClick(Sender: TObject);
    procedure mnuCadSalNovasFormulasClick(Sender: TObject);
    procedure mnuCadSalGeraArquivoClick(Sender: TObject);
    procedure mnuConsultaSalcomixClick(Sender: TObject);
    procedure mnuCadSalGerNfmClick(Sender: TObject);
    procedure mnuCancelamentoFreteClick(Sender: TObject);
    procedure mnuImportCadNCMClick(Sender: TObject);
    procedure mnuImportCadNOPClick(Sender: TObject);
    procedure mnuPlanoContabilPorCfopClick(Sender: TObject);
    procedure mnuPlanoContabilPorCstClick(Sender: TObject);
    procedure mnuCadDespFinClick(Sender: TObject);
    procedure mnuCadGerAutDespFinClick(Sender: TObject);
    procedure mnuCadEfdContriSemDadosEscriturarClick(Sender: TObject);
    procedure mnuSintegraClick(Sender: TObject);
    procedure mnuConverteClick(Sender: TObject);
    procedure mnuDescricaoOcorrenciasClick(Sender: TObject);
    procedure mnuCadGiaFundamentoLegalClick(Sender: TObject);
    procedure mnuCadGiaOcorrenciasClick(Sender: TObject);
    procedure mnuFatConvOrcPedVendaCasadaClick(Sender: TObject);
    procedure mnuCadRestricaoVendaClick(Sender: TObject);
    procedure mnuEditorEtiquetasDespachoFaturarPedidoLaserClick(
      Sender: TObject);
    procedure mnuEditorEtiquetasDespachoFaturarPedidoArgoxClick(
      Sender: TObject);
    procedure mnuContatosWhatsappIntegracaoClick(Sender: TObject);
    procedure mnuFatDefineLoteEntregaFuturaFaltaProdutoClick(Sender: TObject);
    procedure mnuCampoItegerPermiteEdicaoClick(Sender: TObject);
    procedure mnuCadEtiquetaVolumeEtiquetaDespachoClick(Sender: TObject);
    procedure mnuEditorEtiquetasDespachoVolumeGeralArgoxClick(Sender: TObject);
    procedure mnuEditorEtiquetasDespachoVolumeGeralLaserClick(Sender: TObject);
    procedure mnuEditorEtiquetasDespachoVolumeIndividualArgoxClick(
      Sender: TObject);
    procedure mnuEditorEtiquetasDespachoVolumeIndividualLaserClick(
      Sender: TObject);
    procedure mnuGatilhosInformacaoClick(Sender: TObject);
    procedure mnuCadAdiAjusteClick(Sender: TObject);
    procedure mnuCadAdiAjusteApuClick(Sender: TObject);
    procedure mnuCadVenDiaEmpClick(Sender: TObject);
    procedure mnuCadApuIpiAjusteClick(Sender: TObject);
    procedure mnuCadContribuicaoRetidaFonteClick(Sender: TObject);
    procedure mnuCadCampo06BlocoC185SpedClick(Sender: TObject);
    procedure mnuCadGrupoEcoFornecClick(Sender: TObject);
    procedure mnuCadComFaiFatDepVenProFatorClick(Sender: TObject);
    procedure mnuPrmRotCitelAbasteceClick(Sender: TObject);
    procedure mnuAgrupamentoDeOndaDeSeparacaoClick(Sender: TObject);
    procedure mnuNCMparaoutrospasesClick(Sender: TObject);
    procedure mnuCadArmazemOperadoresClick(Sender: TObject);
    procedure mnuImpCupProClick(Sender: TObject);
    procedure mnuTransfCodMotoristaClick(Sender: TObject);
    procedure btnCitelDeskClick(Sender: TObject);
    procedure mnuCitelDeskClick(Sender: TObject);
    procedure mnuGarantiaReimpressaoComprovantesClick(Sender: TObject);
    procedure btnWMSClick(Sender: TObject);
    procedure mnuGruposAnaliseProducaoClick(Sender: TObject);
    procedure mnuRelMenuFavoritosClick(Sender: TObject);
    procedure mnuReimpressaoGarantiaGRClick(Sender: TObject);
    procedure mnuCadMontagemCaixaClick(Sender: TObject);
    procedure mnuEditorEtiquetasProdutosQtdFracionadaLaserClick(Sender: TObject);
    procedure mnuEditorEtiquetasProdutosQtdFracionadaArgoxClick(Sender: TObject);
//    function ForceForegroundWindow(hwnd: THandle): Boolean;
    procedure mnuManutMultiLojaAposEntradaClick(Sender: TObject);
    procedure mnuTransfCodEventoClick(Sender: TObject);
	  procedure mnuPastaComprasExecAuxClick(Sender: TObject);
    procedure mnuRemessaDevolucaoClick(Sender: TObject);
    procedure mnuComissaoDepartamentoClick(Sender: TObject);
    procedure mnuEntImportaNFSeClick(Sender: TObject);
    procedure mnuFaixaDeDescontoPorLinhaGrupoClienteClick(Sender: TObject);
    procedure mnuFaixaDeDescontoPorLinhaGrupoVendedorClick(Sender: TObject);
    procedure mnuFaixaDeDescontoPorLinhaGrupoGerenteClick(Sender: TObject);
    procedure mnuFaixaDeDescontoPorLinhaGrupoClick(Sender: TObject);

    procedure mnuCadMetMixClick(Sender: TObject);
    procedure mnuComissaoLinhaClick(Sender: TObject);
    procedure mnuVendaBaseTrocaRecebimentoClick(Sender: TObject);
    procedure mnuLimparSeparaodoPedidodeVendaClick(Sender: TObject);
    procedure frmCfgBlackListEmailClick(Sender: TObject);
    procedure mnuCadMetasEmpresaClick(Sender: TObject);
    procedure mnuFatAltEventoClick(Sender: TObject);
    procedure mnuPainelFusionClick(Sender: TObject);
    procedure mnuConfirmacaoDeCartoesClick(Sender: TObject);
    procedure mnuManutNumSerieItensClick(Sender: TObject);
    procedure mnuFatManPedCortadoFaltaEstoqueClick(Sender: TObject);
    procedure mnuRequisicaoVinculadasComPedidoDeCompraClick(Sender: TObject);
    procedure mnuCadLocFisicaConsertoEquipClick(Sender: TObject);
    procedure mnuFaixaDeDescontoPorLinhaGrupoSubgerenteClick(Sender: TObject);
    procedure mnuExpCat42Click(Sender: TObject);
    procedure mnuRelatorioCat42Click(Sender: TObject);
    procedure mnuConfiguraoEnquadramentoClick(Sender: TObject);
    procedure mnuEstornoNotaFiscalDevolucaoClick(Sender: TObject);
    procedure mnuConfiguraoCat42Click(Sender: TObject);
    procedure mnuReinfClick(Sender: TObject);
    procedure mnuConsultaFatCobrancaEletronicaClick(Sender: TObject);
    procedure mnuImportacaoAbreviacaoIcmsClick(Sender: TObject);
    procedure mnuExportacaoImagemProdutosClick(Sender: TObject);
    procedure mnuEditorMetasClick(Sender: TObject);
    procedure mnuAltGlobCadCartoesClick(Sender: TObject);
    procedure mnuFatAnaliseCustoPedidoClick(Sender: TObject);
    procedure mnuImportacaoSimilaridadeClick(Sender: TObject);
    procedure mnuCadOcorrenciasDoColetorClick(Sender: TObject);
    procedure mnuImportaoCustosRegimeTributrioFranquiasClick(Sender: TObject);
    procedure mnuImportProdutoVeiculoClick(Sender: TObject);
    procedure mnuFatRemoverDocumentoPreRomaneioClick(Sender: TObject);
    procedure mnuFatGerarNovoPreRomaneioClick(Sender: TObject);
    procedure mnuFatRomaneioAdicionarDoctosNaoEntreguesClick(Sender: TObject);
    procedure mnuSolicitacaodeReposicaodeGondolaClick(Sender: TObject);
    procedure mnuPaineldeReposicaodeGondolaClick(Sender: TObject);
    procedure ReimpressodeSeparao1Click(Sender: TObject);
    procedure mnuConfTransfArmazensClick(Sender: TObject);
    procedure mnuTransfArmazensProdutoAcabadoClick(Sender: TObject);
    procedure mnuGatilhosImediatosClick(Sender: TObject);
    procedure MnuConcorrentesParaPesquisaDeMercadoClick(Sender: TObject);
    procedure mnuCashbackClick(Sender: TObject);
    procedure mnuFatConfeEntDocNaoEntreguesClick(Sender: TObject);
    procedure mnuCadBaseFreteCFOPClick(Sender: TObject);
    procedure mnuNCMEmpresaClick(Sender: TObject);
    procedure mnuResumoISSClick(Sender: TObject);
    procedure mnuConferenciaEstoqueContabilClick(Sender: TObject);
    procedure mnuImportaPROSERClick(Sender: TObject);
    procedure mnuCadFasesOrdProdClick(Sender: TObject);
    procedure mnuMonitorFasesOrdProdClick(Sender: TObject);
    procedure mnuOrdProEmissaoPerdaRefugoClick(Sender: TObject);
    procedure mnuSolicitacaoManutencaoEquipamentosInternosClick(
      Sender: TObject);
    procedure mnuLiberacaoManutencaoEquipamentosInternosClick(
      Sender: TObject);
    procedure mnuAltGlobCadClientesClick(Sender: TObject);
    procedure mnuAltGlobalCadClientesClick(Sender: TObject);
    procedure mnuExpContabilModalidadeClick(Sender: TObject);
    procedure mnuGerImobilizadoClick(Sender: TObject);
    procedure mnuCadAbfReformaTributariaClick(Sender: TObject);
    procedure mnuIntegracaoDominioSistemasClick(Sender: TObject);
    procedure mnuReformaTributariaTipoCreditoClick(Sender: TObject);
    procedure mnuReformaTributariaTipoDebitoClick(Sender: TObject);
    procedure mnuReformaTributariaCreditoDebitoClick(Sender: TObject);
    procedure mnuReformaTributriaCreditoDebitoClick(Sender: TObject);
    procedure mnuFatReimpressaoManifestoEletronicoClick(Sender: TObject);
    procedure mnuLiberacaoCNPJClick(Sender: TObject);
    procedure mnuDivergenciasSeparacaoClick(Sender: TObject);
    procedure mnuCadastroDeAlquotasDeICMSporEstadoClick(Sender: TObject);
    procedure mnuCadNatReceitaPisCofClick(Sender: TObject);
    procedure mnuCashbackDevolucaoEmbalagemClick(Sender: TObject);
    procedure mnuImportacaoNotaFiscalUsoConsumoClick(Sender: TObject);
    procedure mnuCadAutorizadosWSClick(Sender: TObject);
    procedure mnuLibAcessoEndPointsWSClick(Sender: TObject);
    procedure mnuCadTiposIntegracaoWSClick(Sender: TObject);
  private
    { Private declarations }
    horResetSleep: TDateTime;
    mnuAuxTinta: TMenuItem;
    mnuSubItemsTinta: TMenuItem;
    mnuRelFav: TMenuItem;
    iTintasMaquina: ITintasDeMaquina;

    FLibAutTinInicializada: Boolean;

    FobjQuadroLicencas: TQuadroLicencas;

    blnAutoGiro,
    blnAutoEntTE,
    blnAutoConEnt,
    blnVendaAssistida,
    blnAcaoAutomaticaCRM,
    blnDisparaEmailAutEnt,
    blnDisparaEmailPedidoCompra,
    blnEnviaPLP_WMS,
    blnImprimePedido,
    blnImprimeEtiquetaGondolaComPreco,
    blnImprimeSeparacao,
    blnImprimeSeparacaoFina,
    blnGerSfaMob,
    blnGerSfaEst,
    blnGerExpPre,
    blnGerExpPreGertec,
    blnAutoTransfEmpCar: Boolean;

    intMsg: Integer;
    arrMenu  : Array Of String;
    strCodLay: String;
    blnUtiNps : Boolean;

    blnIniciouSistema: Boolean;
    blnAuditouMenu: Boolean;

    mnuBarrinha: TMenuItem;
    blnMenuPintor: Boolean;

    blnFecharForm: Boolean;
    blnExpAcacia    : Boolean;
    blnImpAcacia    : Boolean;
    blnConAjuMot    : Boolean;
    blnMotorConf    : Boolean;
    blnConAjuCom    : Boolean;
    blnCompeConf    : Boolean;
    blnExpMotorola  : Boolean;
    blnExpGeoSales  : Boolean;
    blnImpGeoSales  : Boolean;
    blnImpMovMe     : Boolean;
    blnImpSfaMob    : Boolean;
    blnExpTigre     : Boolean;
    blnExpRelatorio : Boolean;

    blnGeracaoAut : Boolean;
    blnIgnorarPopUpMsgLib: Boolean;

    intSemaforoCadCli: Integer;

    blnTerminouFormShow : Boolean;

    objSemaforoGeralMenus: TSemaforo;
    lstSemaforos: TObjectList;

    stlTintasMenu: TStringList;
    stlTintaMdlls: TStringList;
    intSemaforoEsc: Integer;

    dicOrdenaMnu: TDictionary<String, TOrdenaMnu>;
    objRelatorio: TRelatorio;
    objPlugin : TPlugin;

    objLiberacao : TLiberacao;

    hraMensagemTEF: TDateTime;

    cdsStatusDEPS,
    cdsAvisosPrevisionamentoCTP: TUniClientDataSet;

    blnExpHenkel: Boolean;

    ThreadProcessaAlpeBoleto: TThreadProcessaAlpeBoleto;

    blnImprimeEtiquetaMontagemCaixa: Boolean;
    blnImprimeEtiquetaVolume: Boolean;
    blnImprimeEtiquetaDespacho: Boolean;
    blnImprimeEtiquetaBoxPedido: Boolean;

    FpgbProgressoTefCitel: TcxProgressBar;
    function fExecutouCanceladorAutomatico(const blnConfirma : Boolean) : Boolean;
    procedure OnApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure tmrImpRomMovMeOnTimer(Sender: TObject);
    procedure tmrImpSfaMobOnTimer(Sender: TObject);
    procedure tmrQuestFidelidadeOnTimer(Sender: TObject);
    procedure tmrSistemaDEPSOnTimer(Sender: TObject);
    procedure tmrImportaCTesOnTimer(Sender: TObject);
    procedure tmrImpFranqOnTimer(Sender: TObject);
    procedure tmrEmailBoletoAutomaticoOnTimer(Sender: TObject);
    procedure tmrIniciaImportacaoPAFOnTimer(Sender: TObject);
    procedure tmrAvisosPrevisaoCTPOnTimer(Sender: TObject);
    procedure tmrProjetosAtrasadoOnTimer(Sender: TObject);
    procedure tmrTransfEstOnTimer(Sender: TObject);
    procedure tmrConsultaPixOnTimer(Sender: TObject);
    procedure tmrAlpeBoletoOnTimer(Sender: TObject);
    procedure tmrAvisoDebitoAutomaticoOnTimer(Sender: TObject);
    procedure tmrEntregaDivergenteOnTimer(Sender: TObject);
    procedure pAtualizaEntregaVerificada(strAutinc : String);
    procedure tmrCobrancaEletronicaOnTimer(Sender: TObject);
    function fValidaNumeroParametrosTotem(var AstrParametrosEncontrados: String): Boolean ;

    procedure pTourAbrirMenu(mnuItemAlvo: TMenuItem; blnAbrirAlvo: Boolean = True; intIntervaloNavegacao: Cardinal = 15);
    function fAchaItemPopUpPorNomeOriginal(PopUp: TPopupMenu; strNomeOriginal: String): TMenuItem;

    procedure pGerarPopupRecentesFavoritos;

    procedure pInicializacaoFinalizacaoDicConfigInicial(const blnFinaliza: Boolean=False);
    function fRetCfgRelacionadaArquivo(strNomArq: string): string;
    procedure pGravaConfiguracoesUsadasLogin;

    procedure pExibirNovaTelaPrincipalAutcom;

    procedure pVerificarAutcomIniciadoModoRobo;

    function fExisteDireitoAcesso(ADirAce: String): Boolean;

    function DeveEnviarAvisoDeDebito: Boolean;

    function Titulo(): String;
    function NomeUsuario(): String;
    function LoginUsuarioLogado(): String;
    function MenuPrincipal(): IMenuAutcom;
    function MenuWMS(): IMenuAutcom;
    function Favoritos: IFavoritosAutcom;
    function Recentes: IRecentesAutcom;
    function CorIdentificacaoEmpresa(): TAlphaColor;
    function Pesquisar(ATexto: String): IResultadoPesquisaAutcom;
    function RetornaTodos(): IResultadoPesquisaAutcom;
    function BancoDeDados(): String;
    function IP(): String;
    function IDConexao(): String;
    function Revisao(): String;
    function Versao(): String;
    function DiretorioExecutavel(): String;
    function VerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;
    function PanelTEFIsVisible(): Boolean;
    function RunningInTSPlus(): Boolean;
    function GerarDashboard(): IDashboard;
    function GerarQuadroLicencas(): IQuadroLicencas;
    function GerarFuncoesFiremonkey(): IFuncoes;
    function TEFIsEnabled() : Boolean;
    function GoogleAPIKey(): String;
    procedure GerarPopupFavoritos;
    procedure GerarPopupRecentes;
    procedure AbrirCRM(Opcao: Integer);
    procedure MudarMonitor(IndexMonitor: Integer);
    procedure KeyDownVersaoClassica();
    procedure AbrirCitelDesk;
    function HabilitaAtalhoWMS: Boolean;
    function CodigoEmpresaLogada(): String;

    {$IFDEF TESTABILIDADE_AUTCOM}
      // Funções utilizadas nos testes automatizados
    {$Else}
      function CheckEdgeBrowser: Boolean;
      procedure MensagemInstalacaoWebView;

      procedure pCriaDashboardAntiga(objDash: IDashboard);
      procedure pCriaDashboardWeb(objDash: IDashboard);
      procedure pAbrirPainelEntregas(strNumRom: String = '');
    {$ENDIF}

    procedure pIniciarTraceViewer;

    procedure pMonitorEntregaFutura;
    procedure pMonitorAuditoria;
    procedure pMonitorReservaItem;
    procedure pMonitorStatus;
    procedure pMonitorEmail;
    procedure pMonitorEmailCobrançaEletronica;
    procedure pMonitorLotesWMS;
    procedure ExecutaMonitorAvisoDebito;
    procedure ExecutaMonitorExtratoCobranca;

    procedure pExibirRelatorio(const APrograma, ADescricao: String; AReport: IReport); overload;
    procedure pExibirRelatorio(const APrograma, ADescricao: String; AReport: TfrxReport); overload;
    procedure MudaStatusTimers(blnSuspende: Boolean);

    function fIPesqEmpresa(ASelf : TForm; edtCodigo: TCustomEdit; edtNomEmp: TEditFocus; Var chrKey: Char): Boolean;

    procedure pIniciandoSpedViaParametros;

    procedure pImportacaoCartoes(strNomCon: String);
    procedure pConfirmacaoDeCartoes;
    procedure pConciliacaoCartoes(strNomCon: String);

    function fPodeExecutarFuncaoDoTimer: Boolean;
    function fPodeExecutarExportacaoTerceiros: Boolean;
    procedure pTituloSistema;
    procedure pConsultaNovosItens;
    procedure pConsultaItem(frmSelf: TForm);
    procedure pConsultaCadLocEql;

    procedure pAbrirDevolucaoBaixaEntregaFutura(strCodCli: String);

    procedure pOnClick(Sender: TObject);
    procedure pProcessaDicOrdenaMenuItem(menu: TMenuItem);

    //libAutTin
    procedure pAjustaPresencaFilhosFixosTintaMaquina(blnApresentar: Boolean);
    procedure pOnClickSemDireitoAcessoAutTin(Sender: TObject);
    procedure pOnClickComDireitoAcessoAutTin(Sender: TObject);
    procedure pOnClickConsultaTinta(Sender: TObject);
    procedure pOnClickConsultaAuttin(Sender: TObject);
    procedure pGeraMenusConsultaTinta; overload;
    procedure pGeraMenusConsultaTinta(blnLogOff: Boolean); overload;
    procedure pCarregaMenuTintaMaquinaSobDemanda(Sender: TObject=Nil; blnCarregaSomenteDLL: Boolean=False);
    procedure pGeraMenuTintaMaquina(); overload;
    procedure pGeraMenuTintaMaquina(blnLogOff: Boolean); overload;

    //libCartoesAutcom
    procedure GeraMenuLibCartoes; overload;
    procedure GeraMenuLibCartoes(ARealizandoLogOff: Boolean); overload;

    procedure pGeraMenuRelatoriosFavoritos;
    procedure pAddRelatoriosFavoritos(mnuBuscar, mnuAdd : TMenuItem; lstFavoritos: TStringList);

    function fTemMensagem(strUsuario: String) : Integer;
    function fTemLiberacao(strUsuario: String) : Integer;
    function fTemLiberacaoPedidoCompra(strUsuario: String): Integer;

    procedure pVerCompromisso;
    procedure pGeraEntradaTransfEstoque(strDocOri, strEspOri, strEmpOri: String; strSerOri: String = '';
                                         strCodForTe: String = ''; blnPedidoCompra: Boolean = True);

    procedure pVerAlteraPreco;
    procedure pProjetosAtrasado;

    function fMontaMenu: Integer;

    procedure pSetaDirecaoPopupMsg;

    procedure pExibiBotoes;
    procedure pEscondeBotoes;
    procedure pBloqueiaBotoes;
    procedure pOrdenaMenu(mniMenu: TMenuItem; blnInsRisco: Boolean; blnOrdSubMenus : Boolean = False);

    procedure pFuncoesDiariasAutomatico(strCodEmp: String);
    procedure pFuncoesDiariasAutomaticoEmpresas;

    function fLogoff(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fImportaImagens(pgbStatus: TcxProgressBar = Nil): Boolean;

    procedure pProgresso(pgbStatus: TcxProgressBar; intPos, intMax: Integer; strMsg: String; blnApenasMsg: Boolean=False);

    procedure pCriaRepositorioConfiguracoes(var cfgRepositorio: TfrmCfgRepositorio);

    procedure pFilasSeparacao;
    procedure pFilasBoletos;
    procedure pFilasNFCe;
    procedure pPontosImpressao;
    procedure pModCartaCob;
    procedure pCfgPais;
    procedure pCfgModCartaDes;
    procedure pCfgCamposClientesCRM;
    procedure pCfgCamposFornecedoresCRM;
    procedure pCfgModCartaPro;
    procedure pCfgModCartaAnu;
    procedure pCfgItensOrdenaPadrao;
    procedure pCfgCliAti;
    procedure pCfgCadProvedorEmail;
    procedure pCfgApiCotacaoHabilitaUso(AcdsCfgSis: TUniClientDataSet);
    procedure pCfgRelSkyFornecedor(AcdsCfgSis: TUniClientDataSet);

    procedure pCfgMltBol;
    procedure pCfgFpfAti_Autonomo;
    procedure pCfgFpfAti_Fisica;
    procedure pCfgFpfAti_Juridica;
    procedure pCfgOcoFid;
    procedure pCfgEmailAutEntrada;
    procedure pCertificadoDigital;
    procedure pLayoutImpPdOr;
    procedure pCfgValorMaxEmissaoNFCeUF;
    procedure pCfgCondicaoPagamento;
    procedure pCfgFornecedoresTagsTigre;
    function fCfgFgoSta(var strValCfg: String): Boolean;
    Procedure pCriarCfgsTinta;
    procedure pCfgCredenciaisSitefExp;

    function  fExitemCompromissos: Boolean;
    procedure pAtualizaBemaFI32;

    procedure pHabilitarItemMenu(menu: TMenuItem; blnHabilitar: Boolean);
    procedure pGeraConsultaLapis;

    procedure pAjustaTintasLogOff;
    procedure pAjustaMenuTintaMaquinaLogOff;
    Procedure pVerificaMenusFixadosTintaMaquina();
    Procedure pVerificaMenuTintaMaquina(Item: TMenuItem);

    procedure ExportaBuscaPreco(strTabPre, strStatus: String; blnGertec: Boolean = False);
    procedure pAdicionaSemaforo(mniMenu: TMenuItem);
    procedure pCadastrarAliquotas(iniArqIni: TIniFile);
    function  fPreencheTag(pgbStatus: TcxProgressBar): Boolean;
    procedure pPreencheTagDir(pgbStatus: TcxProgressBar);
    procedure pPreencheTagDirInicial(pgbStatus: TcxProgressBar);
    procedure pPreencheTagDirInterna(mnuMenu: TMenuItem; pgbStatus: TcxProgressBar);
    procedure pIniciaPreencheTagDir;
    procedure pCarregarRelatorios;
    procedure pCarregarLibFuncoes;
    procedure pCarregarLibTintaMaquina;
    procedure pCarregarMenusAcesso;

    function fOpcoesIgnorar: Boolean;
    function UtilizarRoboDeAvisoDeCobraca: Boolean;
    procedure pIniciarTimersImportacao;
    procedure pVerificaTEF;
    { Barra de progresso da carga do TEF, enquanto ela existe (Req. 456190,
      Fase 6). Campo, e nao parametro, porque pStatusCargaTefCitel precisa
      ser um metodo para caber no TprocStatusCargaTef - e metodo nao recebe a
      barra que o fIniciarTefCitel tem na mao. Atribuido e limpo DENTRO do
      fIniciarTefCitel, num try/finally. }
    procedure pStatusCargaTefCitel(const AstrTexto: String;
      const AintFeito, AintTotal: Integer);
    procedure pVerificaTEFCitel;
    procedure pChecagemCfgCliAti;
    procedure pImprimePedido(strIdDocumento: String; blnSeparacao: Boolean);
    procedure pHabilitarMenusOrdSerVenda;
    function fVerificaAcessoDepositoCheque: Boolean;
    procedure pVerificaSincronizacaoEmail;
    procedure pAguardaSincronizacaoEmail;
    procedure pIniciaTimerQuestFidelidade;
    procedure pCfgEtiquetas(strCodCfg: String);
    function fConfigAuxiliar(strCodCfg: String; var strValCfg: String): Boolean;

    procedure pHideApplicationEx(const pBlnHideForm: Boolean);

    procedure pAbreJanelaDeStatusDoSistemaDEPS;
    procedure pAbreJanelaDeAvisoDePrevisaoCTP;
    procedure pProcIniciaCotacao;
    procedure ProcIniciaPedComp;

    function ProcessExists(exeFileName: string): Boolean;
    procedure AtualizarTelaPrincipalAutcom(Esconder: Boolean);
    procedure VerificarSeAutTinEstaAberto;
    procedure pRelFatMetasVendedor(Sender: TObject; blnDir: Boolean = False);
    procedure pRelFatMetasVendedorPopup(Sender: TObject);
    procedure pImportarCTes;
    procedure pTestaInatividadeCTe;
    procedure pMarcarEtiquetasConfiguradas;

    procedure pEscolherOpcaoRetornoConsignacao(var AblnChamarRetornoConsignacaoNovamente : Boolean);
    procedure pBaixaEntregaFutura(blnBFut49: Boolean; blnExibirSomenteProdQtdeEntPreenchida: Boolean = False);
    procedure pMarcarLiberacaoLida;

    procedure ValidacaoCertificadosPix;
    procedure pModCartaExtrajudicial;
    procedure pModContratoServico;

    procedure pProcessaMenusCRM;
    procedure pProcessarMenusLocacaoEquipamento;

    procedure pAtualizaProdReqOrdemServico(strCodReq, strCodEmp: String; Var blnConfirmado: Boolean);
    procedure pAtualizaProdReqSemOS(strCodReq, strCodEmp: String; Var blnConfirmado: Boolean);
    procedure pAcompanhamentoPedidosMostraDebCtrChq2(cdsDados: TUniClientDataSet; strNumDoc : string);

    function fDashboardHabilitadaParaUsuario: Boolean;
    function fDashboarDireitoAcessoLiberado: Boolean;

    function fPainelEntregasDireitoAcessoLiberado(dashHabilitada: Boolean): Boolean;

    procedure pIniciaTmrAlpeBoleto;

    procedure pLiberaLCKATCDasNotificacoes;
    procedure pLiberaLCKATCAlpeBoleto;

    procedure pCfgDescricaoLocRet;
    function fDisparaSMSWhatsappPedidoCompra(strNumPed, strCodEmp,
      strEspDoc: String; staStatus: TStatusDisparaEmail;
      ARecOpcaoImpressao: TRecOpcaoImpressao;
      blnEnviarWhatsapp: Boolean = false): Boolean;

    procedure pGeraEtiquetaMontagemCaixa;
    procedure pGeraEtiquetaVolume;
    procedure pGeraEtiquetaDespacho;
    procedure pGeraEtiquetaBoxPedido;
    procedure pCfgPerAplFRENET;
    procedure pCfgQuadroAcompanhamentoOS;
    procedure pCfgHorBloqueioTransferenciaCodigo(Var pstrValCfg: String);
    procedure pCfgEndPartidaConsFrete;

    procedure VerificaConfiguracaoForcarEmail;
    procedure DesabilitaEnvioEmails;
    procedure pRemoverEventosParaFinalizarPrograma;

    function fValidaLimiteDias: Boolean;
    procedure ThreadSafeAfterConnect(const AConnection : TUniConnection);
    function IsLightTheme: Boolean;
    procedure pAtualizaQuadroLicencas;

    function fExibirAlertaEntregaComDivergencia: Boolean;

    procedure pExibeNotificacaoQtdMensagens(const intNroMsg: Integer);

  protected
    procedure AtualizaTefCitel(ARetorno: IRetornoTEFCitel);
    procedure pGeraEtiquetaGondolaComPreco;

  public
    { Public declarations }
    blnHomologacao: Boolean;
    blnExecutandoAutBan: Boolean;
    blnExecutandoAutTin: Boolean;
    blnGerImpPdv: Boolean;
    blnGerImpCTe: Boolean;
    blnDefinirLotesWMS: Boolean;
    blnCanceladorAutomatico : Boolean;
    blnFaturamentoAutomatico: Boolean;
    blnNotificacoesMonitor: Boolean;
    blnDesmembramentoPedidoPIX: Boolean;
    blnGatilhosInformacao: Boolean;
    blnGatilhosImediatos: Boolean;
    blnConsultaPrecoTintas: Boolean;
    blnSpedFiscal: Boolean;
    blnSpedPisCofins: Boolean;

    tmrRelogio: TNewTimer;
    tmrDataSistema: TNewTimer;
    tmrCompromissos: TNewTimer;
    tmrSincEmail: TNewTimer;
    tmrMonitor: TNewTimer;
    tmrGatime: TNewTimer;
    tmrTestaLogReplicacao: TNewTimer;
    tmrTemMsg: TNewTimer;
    tmrLotWms: TNewTimer;
    tmrSistemaDEPS: TNewTimer;
    tmrProjetosAtrasado: TNewTimer;
    tmrEmailBoletoAutomatico: TNewTimer;
    tmrAvisosPrevisaoCTP: TNewTimer;
    tmrImportaCTes: TNewTimer;
    tmrTransfEst: TNewTimer;
    tmrImpFranq: TNewTimer;
    tmrIniciaImportacaoPAF: TNewTimer;
    tmrQuestFidelidade: TNewTimer;
    tmrImpRomMovMe: TNewTimer;
    tmrImpSfaMob: TNewTimer;
    tmrConsultaPix: TNewTimer;
    tmrRecorrenciaCrm: TNewTimer;
    tmrAlpeBoleto: TNewTimer;
    tmrAvisoDebitoAutomatico: TNewTimer;
    tmrEntregaDivergente: TNewTimer;
    tmrCobrancaEletronica: TNewTimer;

    strNLeads : String;
    strNumOrcPedAbrir: String;
    strEspOrcPedAbrir: String;
    strCodCliGravado : String;
    blnEstouNoCrm: Boolean;
    blnNumSerSAT: Boolean;

    intNextMonitorId: Integer;

    LastTick : DWORD;

    class var blnYapay: Boolean;

    procedure pTerminate(blnEncerrarPorTerminateProcess: Boolean=True; blnExecutouFinalizaObjetos: Boolean=False);
    procedure pFinalizaObjetos;
    procedure pFinalizaAuttin;

    function fPedeLogin(blnLogOff: Boolean = False): Boolean;
    function fExecutarSplash(): Boolean;

    procedure pMenuFaturamentoClick(Sender             : TObject;
                                    Var recReabrirForm : TReabrirForm;
                                    Var strOpcDoc      : String;
                                    strCodCli          : String = '';
                                    blnForcarAbrirDigDocumento: Boolean = False);

    procedure pVerificaMenu(Item: TMenuItem; trvItem: TTreeNode; pgbStatus: TcxProgressBar = Nil;
      blnVerificarAcesso: Boolean = True; blnTemDireito: Boolean = True);
    procedure pExibeMenu(Item: TMenuItem); Overload;
    procedure pExibeMenu(Item: TMenuItem; blnHabilitaDesabilita: Boolean; strSomentoOsSubMenus: String); Overload;
    procedure pProcessaMenu(pgbStatus: TcxProgressBar = Nil);
    procedure pEscondeMenus;

    procedure pOrdenarMenus;
    function fTintaDisponivel(strTinta: String; iTintas: ITintasDeMaquina): Boolean;
    function fVerificaAcessoMenuTintas(strTinta: String; iTintas: ITintasDeMaquina; strName: String): boolean;
    function fVerificaAcessoGeracaoTintas(ACaption: String): Boolean;

    procedure pOrdenaMenusPosteriorLogOff;

    procedure AbrirCRMClassico;
    procedure AbrirCRMNovo;

    procedure pMostraMensTEF(frmNomeForm: TForm; strMensagem: String);

    procedure pExportarMenuSistema;
    procedure pLogsCTRLF1;

    function fIniciarTefCitel(pgbProgresso: TcxProgressBar) : Boolean;

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses untFuncoes, untFuncoesGenerica, untFuncoesFiscais, untSplash, untConstantes, IOUtils,
  untCadProxCodigos, untCadCidades, untCadEmpresas, untCadOperadores,
  untCadAtividades, untCadFornecedores, untCadGrupos, untCadCentroCusto,
  untCadMarcas, untCadUnidades, untCadTransportadoras, untCadIrregFiscal,
  untCadPortadores, untCadBancos, untCadDiversos, untCadSitTributarias,
  untPaiCad, untCadClassFiscal, untCadCtaResultados, untCadConfRelatorios,
  untCadClientes, untCadMovBancario, untGerencImpr, untCadOriFgo, untExecutaSPED,
  untPaiRelatorio, untCadProdutos, untCadLivroFiscal, untCadCtaReceber,
  untBaixaDigValores, untEstornoReceber, untCadCheques, untBaixaCheques,
  untBaixaChequesRepasse, untModuloSPR, untBaixaCancRepasse, untCadCtaPagar,
  untBaixaCtaPagar, untImpBoletoIndiv, untCnfBoleto, untFatDesmembrarPedido,
  untFuncMacro, untCnfEtiqueta, untImpEtiquetas, untAgrupDuplicatas,
  untDesagrupDuplicatas, untDirAcesso, untCancelamentoPedido,
  untCadCartoes, untBaseFechamento, untFecGiroEstoque, untCadMovCartoes,
  untBaixaCartoes, untBaixaCtcAnaSin, untEntDigPedido, untEntSelPedidos,
  untEntMercadorias, untDirAutBan, untAjusteEstoque, untFatVendas,
  untFatLiberacaoCliBlo, untFatLiberacaoCliente, untFuncFat, untPainelECommerce,
  untFatDigDocumento, untFatTipoFaturamento, untFatDadosFiscais,
  untCadAtributos, untCadGrupoAtributo, untCadCentroCustoImobilizado,
  untFatDigMensagem, untFuncGrava, untMenuFilas, untMenuTipImp,
  untTFatConsultaPrecoTintaMonitor, untCadMatrizAliquotasFCP,
  //
  Autoatendimento.PagueFacil.Interfaces,
  Autoatendimento.PagueFacil.Classes,
  Autoatendimento.ConsultaPreco.Interfaces,
  Autoatendimento.ConsultaPreco.Classes,
  //
  untCadRessarcimentoIcmsStCAT, untCadMatrizAliquotasIcms, untCadNCM,
  untCadNBS, untCadIndicadorOperacaoServico,
  untExclusaoOrcFaturados, untVerificaIntegridadeCaixa2, untFatConfDocumentos,
  untCadGruposUnidade, untBaixaCreditosFlex, untConfirmacaoMemo,
  untFatLazDigPreFor, Printers, untFuncTinta, untSplashExt,
  untGatilhosInformacao, untGatilhosInformacaoGrid,
  untCfgHorarioBloqueioTransferenciaCodigo,
  untCancelamentoDocumentos, untDirAutTin, untReimpressaoDocs, untCadEventos,
  untLogDelecoes, untRcxOperador, untRcxResumoCaixa, untCadEcf, untRelacaoSpoolImpressao,
  untBaixaCancCustodia, untBaixaChequesCustodia, untCadCondicoes, untFiscal,
  untCadFormaPagamento, untFinDesmRemBanc, untCadCom, untFuncAutban, untCadCupomDesconto,
  untFatRomaneio, untFatLiberacaoRomaneio, untCadServicos, untCadTipSer, untCadStaSer,
  {untExpAutSin,} untCadMotoristas, untWaitWindow, untTDefinirLotesWMS,
  untCadImpressoras, untCadIdentificacaoImpressora,
  untGerAutCtaPagar, untAcertoConta, untCadPromocoes, untInfCobranca,
  untCadTiposCliente, untCadEmiCheques, untAltVenRep, untCadEstruturas,
  untGerImpFiscais, untNotaFiscalImport, untCadConciliacaoBancaria,
  untManOrdPro, untCadRedeLojas, untCadGrupoEcoFornec, untCadCampanhaVendas,
  untFatExpedicao, untCtrLiberacaoFiltros, untCadBonusVendas, untWhatsapp,
  untCadMetasClientes, untGarantiaEnvCliente, untGarantiaEnvFornecedor,
  untGarantiaRecCliente, untGarantiaRetFornecedor, untSpoolImpressao,
  untProcessList, untAgendamentoCiclicoComDia, untEmailMarketingProspectos,
  untGeraAgendaCiclicoComDia, untAtendimento, untCadMotivoPausaAppEntrega,
  untManClubeFidelidade, untCadLocalDaMercadoria, untConsultaControleDeColeta,
  untSobre, untCadSetoresFilizola, untFatPromocaoBrindes,
  untImpEtiquetaAvulsa, untCadConsumidor, untAgrupDuplicatasCtp,
  untModuloReplicacao, untLogin, untReformaGravacaoHost, untReformaConvertHost, untCadRegioes,
  untDesagrupCtaPag, untManComissaoProfissionais, untRelComissaoProfissionais, untEstornoComissaoProfissionais,
  untRelCopiaCheque, untCadMsg, untCadBocaCaixa, untFunTef, untCadTelefoneContato,
  untCalEstMin, untFatMenuOutSaidas, untFuncoesRel, untFuncoesRel2, untFuncoesEtiquetas,
  untConsultaFatCatalogo, untCfgFilasImpressaoSeparacao, untCfgFilasImpressaoBoletos,
  untCadMaterialConsumo, untReqMaterialConsumo,
  untBaixaBocaCaixa, untFatBaixaRomaneio,
  untFatBaixaEntregaFutura, untCfgSistema, untModulo, untCancDepChequePre,
  untTxtACACIAServer, untTxtACACIAServerImp,
  untCadVerbasCliFor, untCadMotivoVerbas,
  untEstornaCartoes, untImpEtiDespacho, untCalNivGirEst, untCalNivGirEstFornecedor,
  untAtuVarGlobais, untCadAbreviacaoFiscal, untFatManConsertoEquip,
  untCadFeriado,
  untFatAltComissao, untAutcomDllTinta, untCadIndCom, untCadComPes,
  untRelEspNotaEnt, untCadCotacaoCX, untDllTransfCod, untDllTransfCodFuncoes, untDllOpeProd, untDllOpeProdFuncoes,
  untEntConferencia, untFatAlteraDtaEntFut,
  untEntFreConImportacao, untEntSelDocumentos, untCadGruCompras,
  untPedidoCompraLiberacao, untEntImportaNotaElet, untCadComEntregadores,
  untCadComFat, untBaixaEntregadores, untCtrDescontada,
  untAlteracaoEntregaFutura, untRcxReimpTransfer,
  untOrdProdGeracaoAutomatica, untFatAltDataPrevisaoPD, untCadGrupoPrecos,
  untCadLoteItens,untTIntegracaoDLLCartoes, untCadAdquirenteCartao,
  untFatBaixaEmprestimos, untFatFormulacaoItens,
  untFatCancBaixaRomaneio, untTransfCheqEmpresa, untGeraLivroCaixa,
  untTxtSfaMobImp, untRecTransfEstoque, untImportacaoSfaMobAndroid,
  untExportacaoSiteMod1, untVendasPerdidasDig,
  untCadMetasValor, untCadMetasGalonagem, untTransfCodMarca, untCadVeiculos,
  untCtpAtribPortador, untFuncoesDiarias,
  untCadDepartamentos, untEtiOrcPed, untCadBandeiras, untCadBandeiraEmpresa, untCadParametrosEmpresa,
  untCadLimiteComprasFornecedor, untExportXmlNexxera, untRelDASAcompTop20, untRelDASRupturaVendas,
  untManutKmRodado, untSenhaOperador,
  untCadComRec, untFatDigControleDataEntrega, untCadComissaoEspecie, untLibNfe, untInicializarDllAutTin,
  untBaixaCancTelecheque, untCadOcorrencias, untFatGor, untFatGorEmail,
  untCadRcxx, untMovGer, untCadFuncionarios, untDigMovimentoMensal,
  untCadVerbas, untFatRomManutEntrega, untCadCanaldeAcesso,
  untCadPrevisao, untAltRegClientes, untCadFin, untEntPreNotaEntradaCx,
  untLotePrecosEfetivacaoCx, untEntConferPreNota, untEntEnderecamentoProduto,
  untFatLiberacaoEntFut, untFatBaixaPedidoDev, untMonitorReplicacao,
  untCadServAtendCliente, untBaixaOrdProd, untBaixaOrdProdGeral, untManCentroCustoRateio,
  untBaixaReceber, untReimpressaoCarnePagto,
  untCadVenCnd, untConsultas, untCadAjudantes, untCadConcorrPesqMer, untFatorPrecoCadastro, untCadControleEntrega,
  untTefRecebimento, untCadClassifCentroCusto, untClassifCentroCusto,
  untCadComFatVend, untCadFaixaFatVend, untPanelCxItem,
  untPnlDadosItem, untCadReceitAgronomico,
  untCadAbreviacaoCOFINS, untCadAbreviacaoIPI, untCadAbreviacaoPIS,
  untIntegraDoctorcred, untGeraNotaDebito, untGeraDuplicataReceber,
  untEntConferenciaMotorola, untMsgAlerta, untVersaoProg,
  untVerificadorDeCupons, untCadPromocaoBrindes,
  untCadAssistenciaTecnica,
  untTransferencias, untITransferencias, untCadCargos,
  untCadDepartamentosCliCon, untCadTimeFutebol, untCadHobbys,
  untCadEscolaridades, untCadGostoMusical, untCadEstadoCivil,
  untLayoutsImpressao, untIFatOrdProTintaMaquina, untFatOrdProTintaMaquina,
  untCadTiposOcorrencias, untCadGrupoOcorrencias, untCRM, untCadPrevisaoMensal,
  untCadSitProduto, untCadMontadoras, untCadLocFisica, untCadArmazem, untCadLote,
  untTransfArmazens, untConsultaPedidos, untCadAutAba, untImportaSpedPisCofins,
  untRelRecPagtoFunc, untCadComplOcorrencias, untTxtACACIAServerExpAndroid,
  untCadTipoAtendimento, untCadMotVendasPerdidas,
  untCadMetasLitragem, untCompromissos, untGarantiaBaixaRefugo,
  untCadFreteTranspCidade, untCadSubRegiao, untCadComFatVendDepart,
  untCadControleProducao, untCadTabelaPrecos, untGeraDespesasProtesto,
  untCadCor, untEntFreConhecimento, untFatConfOrcamentosSiteEmPedidos,
  untCadComFatDepart, untCadComFatMarDepart, untAnaliseCompras, untCadEstruturasIndustrial,
  untCadComposicaoProdAcab, untFatRetornoConsignacao, untFatFaturaConsignacao,
  untCadFases, untCadCotacaoMoeda, untConsControleProducao,
  untFatConsEntPendentes, untAtribuicaoOcorrenciasEmergenciasCRM, untCliForCRM,
  untCRMForn, untAnaliseProducao, untManOrdProIndustrial,
  untCadEstruturasIndustrialSubsComp, untConfFFemD1, untOrdProIndustrialEtq,
  untTxtACACIAServerImpAndroid, untBaixaOrdProdIndustrial,
  untAltPrecoAcabadosInd, untNfeInutilizacao,untFuncoesInicializarLibContasBancarias,
  untFatDigCartaCorrecao, untCadGrupoProdutos, untEntConferenciaCancel,
  untFatSepFutDigSeparador, untPesarProdutos, untConsultaServicosAutocenter,
  untFatRetiraDigSeparador, untRelCadCustosIndustrial, untCadModVei, untCadMarVei, untCadCorVei,
  untPedidoDeCompraImpAutcom, untFuncoesAuxiliares, untEmailMarketing,
  untGravando, untCadMetasFornecValFat, untFatConfirmacaoAjustes,
  untImportaSpedFiscal, untCadFaixasCndPagDesc,untCadFaixasCndPagGeraNotaDebito, untEntregasFuturasTintas, untCadMetasValorPedCom,
  untCadPerguntas, untCadPesquisas, untGerarOrcamentoCompraAuto, untFatRequisicaoCompras,
  untTxtImpFullSoftTablet, untCadFaixaFaturamentoComissaoCTR, untFatExpServicos, untPai, untGerAvisoEmbarque,
  untCadAliqIBPT, untCadMetasVendDepProd, untCadGrupoAtividade, untCadMetasVendedorAtividade,
  untCfgCompCusto, untCadFaixasVenCndDesc, untFatAltTipoAtendimento, untEntFreConLista,
  untManGarantiaFornecAntEnvio, untCadGruOperadorNovo, untCadMetasRapel, untCadFaixaDescTabPreco, untCadFaixaMargemTabPreco,
  untAltValorEntrega, untFatAltVendedor, untImportaNfeParaSped, untReqEnvioMatVidro,
  untFatManifestoEletronico, untFatManutencaoManifestoEletronico, untCad800,
  untFatCancelamentoManifestoEletronico, untPreparaGeracaoTE, untDigGNRE,
  untFatEncerramentoManifestoEletronico, untFatReimpressaoManifestoEletronico, untFatAltValorFreteSuges,
  untCancelaOrdemProdIndustrial, untAnaliseEstoqueEmExcesso, untConsultarAdiantamentos,
  untConsultaServicosAutocenterVendas, untImportaMovimentoPAFECF,
  untImportaPAFECF, untGeraVisitaCliente, untFatAltComissaoManualCTR,
  untCadProdutoCndPag, untLiberacaoLocalizacaoFisicaColetor,
  untManutChqEmi, untCadDespFaturamento, TypesRel, untRelComissaoVendedorCTR,
  untRelComissaoVendedorCTRMod2, untCadSitOco, untRelFatListVenRep, untCadComplVidro,
  untRelComissaoVendedorManualCTR, untBaixaChequesTelecheque, untRelCtrCompAgrupDup,
  untRelCtpReimpBordero, untTIntegracaoCartoes, untInicializaDllPedido,
  untRelEtiPrecificacao, untRelFiscResumoApIcms, untRelFatVendasCliente,
  untCadFrequenciaCRM, untCadPorteCRM, untCadFaixaFatuEstimadoCRM, untCadForAtuCRM,
  untEntConferenciaCompexPM260, untEntConferPreNotaMotorola,
  untCadMetasMarca, untCadAdenFatSer, untCadMetasCentroCusto, untCadEquipamentosInd,
  untOPIndMonitoramento, untCtrGeracaoDesCobCheques, untFatDigRomaneio,
  untFatAtivaPreRomaneio, untCadLocalizacaoSeparacao, untEntFreConImpVarios,
  untFatAlteraTransRomaneio, untCadAnalise, untCadAnaliseMov, untCadLocFisAmostraProducao,
  untCadEstruturasIndustrialDF, untEstornoPagar, untCadBairros, untManutencaoLoteMP,
  untFasObr, untCadFasObr, untFatAltMecanico, untAgruPedOrdProInd, untControleSepAvulsa,
  untMemo, untExclusaoArquivosCartoes,
  (*WMS*)
  untCadDocas, untManutencaoDocas, untPlanoDeRecebimento, untRecebimentoEntregaAgendada, untBaixaVolumes,
  untCadAgendamentodeEntrega,untMapeamentoItemClasseLocFis, untCadClasseLocFis,
  (*WMS*)
  untTFaturamentoAutomatico, Faturamento.Classes.CanceladorAutomatico, untTDesmembramentoPedidoRecebidoPIX,
  untCadPlanConcon, untCadPlanoContasPorCfop, untCadPlanoContasPorCst, untCadDespFin,
  untGerAutDespesasFinanceiras, untCadEfdContriSemDadosEscriturar,
  untEntSelecionaNotaElet, untEntConfPreNotaFuncoes, untImpEtiEmpresa,
  untSacMotivosAtend, untOrdProAtualizaPrecos, untGeoSales,
  untTraducaoCxComps, untPanelCxServico, untPnlDadosServico, untCadEnquadramentoIPI,
  untCadMotivoReprovacao, untCadDefeitos, untCadEquipamentos, untCadParceiros, untGarantiaGeraCreditos,
  untCadPadraQualidadeInd, untLiberaPrepTE, untEntEtiquetas, untTCliAtiRepository,
  untCadAjustIcmSt, untTriggerCRM, untCadProspectos, untCadGrupoServicos, untCadMovFlex,
  untCadNegociacaoClientes, untImpressaoCP, untCadCEST, untCadRelatorios, untCadDirVerdeVermelho, untCadModelosRel,
  untEmailMarketingProfissionais, untTransfLocFisGlobalWMS, untImpEtiOrdPro,untImpEtiLoteDoProduto,
  untCancelaBaixaOrdProd, untCadTipoAnalise, untCadEspecifiTecnicas, untControleQualidadeProducao,
  untCadVenMar, untCadCliVen, untMenuFiscalMovEcf,untRelCtrLogAcompDuplicNovo,
  untConsultaMensagemEmail, untUnificacaoPedidos, untNetpoints,
  untNotificaAtivacaoTabPreFor, untGeraVisitaClienteIndividual,
  untCadReformaTributariaTipoCredito, untCadReformaTributariaTipoDebito,
  untCadReformaTributariaCreditoDebito, untReformaTributariaCreditoDebito,
  untEntFreCon, untRelacaoNetpoints, untCadComboProdVenda, untLogGor,
  untCadFaixasCndPagAgr, untCtpLiberacaoBaixa, untICadastrosImpl, untImportaRetornoCustodia,
  untBoxEntrega, untPanelCxBanner, untPnlBanner,untControlaNotSaldoMin, untCTRReajuste, untLogAcompPedidos,
  untCadClientesDesconto, untCadRegioesDesconto, untCadDescontoClienteProduto, untEnvInterfaceAnalitica,
  untCadConciliaAcumuloNetpoints, untRelFatDocTinta,  untRelContratoAberturaCredito, untRelCadDireitosDeAcesso,
  untRelEtiqQtdRestante, untExecutaSQLReplicacaoTinta, untCadTabelaFaixasSimplesNacional, untCadEmbarcacoes,
  untRelComissaoProfissionalCTR, untCalculoPrecoMedio, untCadPagBosch,
  untContratosCorreios, untMovMeComunica,
  untCadCCa,  untManCadCidadeSigep, untCadPos, untCadAdquirente, untLiberacaoAcompEntregas,
  untCadTemplates, untCadAjuRelatorio, untCadInstrucoes, untPanelCxPreFiltro, untPnlPreFiltroCarro,
  untAgregados, untFuncFatImp, untFuncFatTypes,
  untOpcArquivo, untDigSerieRastreaveis, untFatDefineLotesPedidoWMSWrapper,  untFatAltEmbarcacoes, untFuncoesImagem,
  untExportaXMLNotasRomaneio, untCadMetasFatLiq, untCadEquLocacao, untCadAcessorioLocacao, untCadContratoLocEquip, untInspecaoLocEqu,
  untFatManOrdSer,untFatOrdSer, untRelFatEtiArmazenamento, untOcorrenciasRomaneio,
  untEnvioLocEqu, untRetornoLocEqu, untFaturaLocEqu, untEntMercadoriasEfetivaMovFiscal, untImpEtiLocalizacao,
  untRelChqLogAcomp,   untReimpressaoBorderoTelecheque, untRelCtpLogAcompDuplic, untRelCtpReimpressaoDocs,
  untCartaAnuencia, untRelCtrBordero, untRelCtrCartaProtesto, untModuloRelCtrCartaProtesto, untRelCtrCartaDes,
  untRelCtrExportaCobranca,untSelCtrExportaCobranca, untCalNivCriEst, untTPixTefBridgeAutcom,
  untConsultaPedidosPend, untCadBoxWms, untControleRotasRegiao, untCadRotasRegiao,
  untGerAutCtaReceber, untMovCar, untEntradaAutomatizadaImportacao, untCadCategoriaCRM,
  untFuncoesInicializarLibCartoes,
  {* CONTABILIDADE *}
  Contabilidade.Funcoes, Contabilidade.Consultas, Contabilidade.Classes.TControleContabilidade, untDicionarioResultadoQuerySimples,
  Contabilidade.View.ConferenciaEstoqueContabil,
  {RELATÓRIOS DE ESTOQUE REMOVIDOS DA LIB}
  untRelEstKardexAcabado,
  {****************************}
  untCadGrupoRisco, untOrdProdGeracaoAutomaticaEstoque, untTrocaVendedorTemp,
  untCadEpi, untReimpressao, untLogTrace, untBalancoEstoqueGravar,
  untManGerAutCtaPagar, untTrocaVendTemp, untCadFaixaPrzMed, untEntradaAutomatizada,
  untLibVendasEntrega, untFatMenuOutEntradas, untLiberacaoFactory, untVendaAssistida,
  untCancDepChequePreMod2, untTCRMGeracaoGlobal, untDisparaEmailAutEnt, untCadFreteFaixaFaturamento,
  untEntConferPreNotaWMSDevolucao, untLiberacaoTransferenciaArmazem,
  untConfirmaEspelho, untTSituacaoPedidoVenda, untTEnvioEmailAutController,
  untTEnvioEmail, untMapeamentoItemLocalizacaoFisica, untLiberacaoPedidosExternos,untrelEstSaldoReservado,
  untFatAltLoteItem, untLogAut, untTFatReservaSaldo,
  untCadBeneficioFiscal, untUtilMonitor, untTSaldoReservadoPedido,
  untInativarLotesSemSaldo, untRelFatFichaTecnicaProdutosOrcamento, untTFatEntregaFutura,
  untFuncoesCRM, untGeracaoPedidoTransferenciaAberturaNovaEmpresa,  untRelCatalogoLinhaGrupo, untRelCatalogoProduto,
  untQuestFidelidade, untCfgCadProvedorEmail, untCfgCamposClientesCRM, untControleEstoqueCat17,
  untCfgCamposFornecedoresCRM, untCfgCliAti, untCfgEmailAutEntrada, untRelSimplesNacional,
  untCfgItensOrdenaPadrao, untCfgModCartaAnu, untCfgMltBol, untRelFiscGerArqAcMod2,
  untCfgModCartaDes, untCfgModCartaPro, untCfgPais, untCadMetasVendLinhaGrupoProd,
  untCfgModCartaCob, untCfgPontosImpressao, untCfgFpfAti, untSeqCom, untRelFiscMapaResumo,
  untCfgOcoFid, untFatRetornoRemessa, untFatFaturaRemessa, untEntImportaNotaEletDivFiscal,
  untSIGEPWebFuncoes, untCadProjetos, untCadControleCreditoFiscais,
  untDigRecursosProjeto, untCadRecursosProjeto,untCadTiposProjeto, untSeparacaoFina, untRelFiscGerArqAcSef107_2011,
  untCadCodTipoServico, untFuncoesSaldos, untConfiguraEtiquetas, untCadProdutosAltoGiro, untRelFiscRestituicaoIcms,
  untRestauraDuplicataMercantil, untCadCanhotosNF, untCadMetasCobranca, untImprimeEtiquetaLoteRastreamentoProduto,
  untProdutoCadastroRapidoLoteRastreamento, untDigAtualizaPreco, untCadQualificacaoClientes,
  untFatManifestoEletronicoEncerrados, untRelCbaLogAcompMovBanNovo, untCfgFilasImpressaoNFCe,
  untEnvioConfirmacaoSefaz, untUltimosFechamentosEstoque, untUltimosFechamentosFiscais, untCadFreteTranspRegiao,
  untCadConcorrencia, untTHorOpe, untStatusOrcamentosSistemaDEPS, untValidacoesSistemaDEPS, untCategoriaOrcamentoPedido,
  untUltimosFechamentosFinanceiro, UntAtivacaoInativacaoNFCeOFFLINE, untCadCaixas, untRcxTransfLancamentosEntreCaixas,
  untCtpLiberacaoPrevisao, untTLiberacaoPrevisaoPagar, untAvisosPrevisionamentoCTP, untFluxoComprasView,
  Yapay.Api.Facade, untCadCna, untComFat, untCadFatReg, untConsolidacaoDeAdiantamentoDeValores, untRelFiscTermoAbert,
  untCadMetasFaturamentoServicoPorFaixa, untGNRE, untCadFaixaDescTabPrecoLinhaGrupo, untCadFuncoes,
  untMontQuadroFuncEvento, untMandaeEnvioEncomendas, untRcxLiberacaoDeCaixas,
  untRelFatMapDemonsEstoq, untRelFatExtratoProfissional, untRelFiscResumoIcms,
  untCadCupomPromProd, untCadEmpresasEstoqueExterno, untFatManifestoEletronicoEventoPagamentoOperacaoTransporte,
  untRelFiscCreIcmVendInterest, untRessarcImpRetidoPorSujeicaoPassivaSubst, untRelEstatDemonsFat, untFatGorFactory, untTFatGor,
  untRelEstComparativoPrecosFornec, untRelFatComVendedor, untCadGPC, untRelEstatAnalResultBan,untRelFatReciboAvulso,
  untGerarGTINAtualizarCadastroGS1CNP, untRelEstatAnalResult2, untRelEstatAnalResult2Ritec,
  untHistoricoBalanco, Fulfillment.View.NotasFulfillmentPat, untCadPontosImpressao,
  untCadPendencias, untCancelamentoPedidoJadlog,
  untCadLocalArmazenamentoWms,
  untImpEtiLocalArmazenamentoWms, untImpEtiRegiao, untRelCtrReceber,
  untMatrizProdutos, untFatTransfEstDevEmpCarregamento, untTransfEmpCarregamento,
  untPrioridadeSaidaEstoqueEmpresa, Faturamento.View.ConsultaCTe, untCadComissaoProdTabPre,
  untLayoutImpressaoPedidoOrcamento, EmailContasReceber.Classes,
  untFatRomaneioManutencao, Faturamento.Consignacao.Classes, untRestauraPreco, untTLog,
  untCfgValorMaxEmissaoNFCeUF, untAlteraVendedorMarca, untCfgPerAplFRENET,
  untCadMatrizBasesDifal, untCadCfgTerminalTef, untTefCitelUtil, untCadSinaleiroFaturamento,
  untTefCitelAdministracao, untTefCitelInfoMsg, untCfgCondicaoPagamento,
  untCtrReprogVen, untFatLimparSeparacaoPedido, untDicSis,
  untReimpReciboComissaoProfissionais, untCadCotacaoRelac, untCadAcessorios, untCadEstProduto,
  untFatManConsertoFluxoProcesso, untCadFaixasCatEtiqProduto, untCadTiposCotacaoPedidoCompra,
  untCadFasApontamento, untCadPromocoesAut, untPromocoesAutAtivacao, Faturamento.View.DigitalizacaoDocumentos,
  untNegociacaoOrdemServico, untDigCndPagamentoEsp, untControleContagemBalancoEstoque,
  untCadDescontoClientesMarcas, untUtilMenuPAFNFCe, untCadCondPagtoEspecialProdutos,
  untPainelAcompanhamentoOS, untTFuncoesPixAutcom, untRelacaoPedidosPixGerados, untTPixDao,
  untRelatorioAcompanhamentoPix, untCfgBlackListEmail, untImportacaoAbreviacaoIcms,
  untTLibCartoesAutcom,
  {* LOCAÇÃO DE EQUIPAMENTOS - INÍCIO *}
  untLiberacaoLocacao, untTrocaLocEqu, untFaturaMensalLocEqu, untCancelaLocEqu,
  untManutencaoLocEqu, untReimpressaoCompInspecao,
  untPnlDadosEquLocacao,  untPanelCxInfoEquLocacao,
  ImportacaoDados.Interfaces, ImportacaoDados.View.ImportarArquivo,
  cadastro.Controller.ContratoLocacaoEquipamentos, untFuncoesLocEqu,
  {* LOCAÇÃO DE EQUIPAMENTOS - FIM *}
  untFatRelLiberacaoRemota, untAltGlobCadClientes, untAltGlobCadCartoes, untFatLibReservaEstoqueOS,untEtiquetadoProdutoSeparado_QtdRestante, untEnderecamentoMarmoreGranito,
  untCadPortos, untCadAeroportos, untCadIncoterms, untCadCarteiraDigital, untAltGlobalCadClientes,
  Faturamento.View.ExclusaoVendasPerdidas, untGarantiaRetornoColeta,  untGarantiaBaixaEnvioFornecedorConserto,
  untLiberaRomaneiosAppEntrega, untGerarOrdemdeProducaoPorArquivoDeImportacao,
  untCadOcorrenciaEntrega, untSelFgoSta, untRecorrenciaOcorrencia, untTRecorrenciaOcorrencia,
  {* OBRIGAÇÕES ACESSORIAS SPEDs*}
  untCfgEfdSpedContribuicao,
  untCfgSpedFiscal,
  untCadAdiAjuste, untCadAdiAjusteApu, untCadVenDiaEmp, untCadApuIpiAjuste, untCadContribuicaoRetidaFonte, untCadCampo06BlocoC185SPED,
  untCadDescricaoOcorrenciasGia, untCadFundamentoLegalGia, untCadOcorrenciasGia,
  untPedidoDeCompraImpEdiSawluz,
  untAvaliacaoGarantiaPropriaEmpresa,
  untLinkPagamentoCitelRetorno, untPgtoOnlineESiTefManutencao, untPgtoOnlineESiTefParChavesManutencao, untCadMetaCompDepVend,
  untCadCorrecaoOrdProducaoIndustrial, untBaixaOrdProdGeralIndustrial,
  untWorkStationInfo, untTransfTabelas, untAcertoDeContasDeProfissionais,
  untFormTestabilidade, untCadCotacaoDiariaCombustiveis,
  untRelCtrCartaExtrajudicial, untCfgModCartaExtrajudicial, untRecebimentoTransbordo,
  untCadDescontoMaximoPorAtividade, untCadMargemMinimaPorAtividade, untAltPrecoRecalc,untPainelRessuprimento,
  untCadCheckListValidacaoGarantia, untCadMotivosAproveitamentoItens,
  untAlterarPrazoGarantia,
  {* CRM *}
  untCadMotFinOco, untAtualizaOcorrenciasCRM, untCadTemperaturaAtendimento,
  {* CRM *}
  untCadFreteRegiao, untEntImportacaoNotaEletronica, untTravaCaixa, untTranferenciaPedidoMultiLoja,
  untImportaPrecos, untCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa, untOutrasDespesasAposEntrada,
  untCadComFaiFatDepVenPro, untConEquipAtualizaProdutosReqCompra, untController.CheckListGarantia,
  untFatConvOrcPedVendaCasada, untFatDefineLoteEntregaFuturaFaltaProduto,
  untContatosWhatsappIntegracao, untCadRestricaoVenda,
  untCadEtiquetaVolumeEtiquetaDespacho,untDigEmailPedidoCompra, untCadComFaiFatDepVenProFator,
  untTGerenciaItegerPermiteEdicao, untCfgDescricaoLocalRetira, untFornecedoresTagsTigre,
  untCadPrmRotCitelAbastece, AgrupamentoDeOndaDeSeparacao, untCadNCMOutrosPaises, untCadNCMEmpresa,
  untCadArmazemOperadores, untCfgRel, CupomPromocao.Reimpressao, untCadGruposAnaliseProducao, untManutencaoOrigemProdAcabados,
  untTDisparaEnvioEmailPedidoDeCompraAutomatico, untRelMenuFavoritos, untFatRemessaDevolucao,
  untDisparaSMSAut, untCadMontagemCaixa, untMontagemCaixas, untComissaoLinha, untFatDigPedidoEmpresa,
  untPastaComprasExecAux, untTMostraDebCtrChq2,untTExtratoCobranca, untTEnviaRegistrosFusion, untTObtemRomaneioIntegFusion,
  untManutencaoMultiLojaAposEntrada, untCadMetMix, untComissaoDepartamento, untCadFaixaDescontoLinhaGrupoGerente,
  untCadFaixaDescontoLinhaGrupoCliente, untCadFaixaDescontoLinhaGrupoVendedor, untThreadUtils,
  untCadFaixaDescontoLinhaGrupo, untCalcFatReg, untCadMetasEmpresa,
  {* Venda Base Troca *}
  untVendaBaseTrocaRecebimento,
  {* Venda Base Troca *}
  untCfgQuadroAcompanhamentoOS, untFatImpressao, untFatAltEvento, untCadAbfReformaTributaria,
  untPainelFusion, untManutNumSerieItens, untFatManPedCortadoFaltaEstoque,
  untRequisicaoVinculadasComPedidoDeCompra, untCadLocFisicaConsertoEquip,
  untCadFaixaDescontoLinhaGrupoSubGerente, untDllReinfFuncoes, untDLLReinf,
  untConstCompartilhadaCat42, untFuncoesDllFiscalCat42, untEstornoNotaFiscal,
  CobrancaEletronica.Lib.Facade, CobrancaEletronica.Lib.Types, untCadCashback,
  untConsultaFatCobrancaEletronica, untExportarImagensProdutos, untEditorMetas,
  untHorarioSistema, untImportacaoSimilaridade, untCadOcorrenciasDoColetor, Romaneio.Types, Romaneio.Constantes,
  untCfgCredenciaisSitefExp, untImportacaoCustosRegimeTributarioFranquias, untImportProdutoVeiculo,
  untFatRemoverDocumentoPreRomaneio, untFatGerarNovoPreRomaneio, untFatRomaneioAdicionarDoctosNaoEntregues,
  untGatilhosImediatos, untCadBoxEti, untTGerenciaMovimentacaoGondola, untFatConfeEntDocNaoEntregues,
  untDllDominioSistemas, untDllDominioSistemasFuncoes, untCadBaseFreteCFOP,
  untResumoISS, untCadFasesOrdProd, untOrdProdMonitoramento, untOrdProEmiPerdaRefugo,
  untCadEndPartidaConsFrete, untManutencaoEquipamentoInternoSolicitacao,
  untManutencaoEquipamentoInternoLiberacao, untExpContabilModalidade, untCadTabelaIcms,
  untGerImobilizado, untCadastroPerfilDespachanteAduaneiro, untDllGatIme,
  untCadNatReceitaPisCof, untCadCashbackDevolucaoEmbalagem, Cashback.Controle,
  untEntImportacaoConsumo, untCadAutorizadosWS, untLiberacaoAcessoEndPointsWS,
  untCadTiposIntegracaoWS, untCfgModContrato, untDisparaEmailAut;

{$IFNDEF TESTABILIDADE_AUTCOM}
var
  WndProcHookAfter: HHOOK;
  WndProcHookBefore: HHOOK;

  FMinimized: Boolean;
  FMinimizedTime: TDateTime;
  FMinimizedHandle: HWND;

  FHooksFinalizando: Boolean;
{$ENDIF}

{$R TradDev.res}
{$R *.dfm}

{$IFNDEF TESTABILIDADE_AUTCOM}
function ObterFormFMXPorHandle(const AHandle: HWND): FMX.Forms.TCommonCustomForm;
begin
  Result := nil;

  if AHandle = 0 then
    Exit;

  try
    Result := FMX.Platform.Win.FindWindow(AHandle);
  except
    {
      A janela pode estar sendo destruída ou recriada.

      Como esta função é chamada dentro de um hook do Windows,
      nenhuma exceção deve sair daqui.
    }
    Result := nil;
  end;
end;

function FormFMXMonitorado(const AForm: FMX.Forms.TCommonCustomForm): Boolean;
begin
  Result := Assigned(AForm) and (SameText(AForm.Name, 'fmxPainelEntregas') or
                                 SameText(AForm.Name, 'fmxDashboardPrincipal') or
                                 SameText(AForm.Name, 'fmxDashboardPrincipalOld') or
                                 SameText(AForm.Name, 'fmxMenu'));
end;

function WndProcAfter(Code: Integer; WParam: WPARAM; LParam: LPARAM): LRESULT; stdcall;
var
  LMsg: PCWPRetStruct;
  LFormFMX: FMX.Forms.TCommonCustomForm;
  LHandleFMX: HWND;
begin
  Result := 0;

  try
    if FHooksFinalizando then
      Exit;

    if Code < HC_ACTION then
      Exit;

    if LParam = 0 then
      Exit;

    if not Assigned(frmPrincipal) then
      Exit;

    LMsg := PCWPRetStruct(LParam);

    case LMsg^.Message of
      WM_SIZE:
        begin
          if LMsg^.WParam <> SIZE_MINIMIZED then
            Exit;

          {O retorno é obtido apenas uma vez.

           Isso evita chamar FindWindow repetidamente enquanto a
           janela pode estar sendo destruída ou recriada. }
          LFormFMX := ObterFormFMXPorHandle(LMsg^.hwnd);

          if not FormFMXMonitorado(LFormFMX) then
            Exit;

          try
            LHandleFMX := FormToHWND(LFormFMX);
          except
            LHandleFMX := 0;
          end;

          if LHandleFMX = 0 then
            Exit;

          FMinimized := True;
          FMinimizedTime := fNow;
          FMinimizedHandle := LHandleFMX;
        end;

      WM_ACTIVATE:
        begin
          if not FMinimized then
            Exit;

          { Não processa a desativação da janela. }
          if LOWORD(LMsg^.WParam) = WA_INACTIVE then
            Exit;

          if SecondsBetween(fNow, FMinimizedTime) < 1 then
            Exit;

          FMinimized := False;

          if (FMinimizedHandle <> 0) and IsWindow(FMinimizedHandle) then
            ShowWindow(FMinimizedHandle, SW_SHOWMAXIMIZED);

          FMinimizedHandle := 0;
        end;
    end;
  except
    on E: Exception do
    begin
      try
        pGravarErro(True, 'WndProcAfter - Exceção capturada', E.Message);
      except
        { Não pode deixar uma exceção atravessar o limite
          de um callback stdcall do Windows. }
      end;
    end;
  end;

  Result := CallNextHookEx(WndProcHookAfter,
                           Code,
                           WParam,
                           LParam);
end;

function WndProcBefore(Code: Integer; WParam: WPARAM; LParam: LPARAM): LRESULT; stdcall;
var
  LMsg: PCWPStruct;
begin
  Result := 0;

  try
    if FHooksFinalizando then
      Exit;

    if Code < HC_ACTION then
      Exit;

    if LParam = 0 then
      Exit;

    LMsg := PCWPStruct(LParam);

    if (LMsg^.Message = WM_ENDSESSION) and
       (LMsg^.WParam <> 0) then
    begin
      if Assigned(frmPrincipal) then
      begin
        try
          frmPrincipal.MudaStatusTimers(True);
          frmPrincipal.pFinalizaObjetos;
        finally
          frmPrincipal.pTerminate(True, True);
        end;
      end;
    end;
  except
    on E: Exception do
    begin
      try
        pGravarErro(True, 'WndProcBefore - Exceção capturada', E.Message);
      except
        // Não propaga exceções pelo callback.
      end;
    end;
  end;

  Result := CallNextHookEx(WndProcHookBefore,
                           Code,
                           WParam,
                           LParam);
end;

procedure InstalarHooks;
var
  LThreadID: DWORD;
begin
  if (WndProcHookBefore <> 0) or
     (WndProcHookAfter <> 0) then
    Exit;

  FHooksFinalizando := False;
  FMinimized := False;
  FMinimizedTime := 0;
  FMinimizedHandle := 0;

  LThreadID := GetCurrentThreadId;

  WndProcHookBefore := SetWindowsHookEx(WH_CALLWNDPROC,
                                        @WndProcBefore,
                                        0,
                                        LThreadID);

  WndProcHookAfter := SetWindowsHookEx(WH_CALLWNDPROCRET,
                                       @WndProcAfter,
                                       0,
                                       LThreadID);
end;

procedure RemoverHooks;
var
  LHookBefore: HHOOK;
  LHookAfter: HHOOK;
begin
  { Bloqueia imediatamente o processamento dentro dos callbacks. }
  FHooksFinalizando := True;

  { Copia os handles e zera as variáveis antes de chamar o Windows.
    Isso também evita reutilização durante uma sequência de finalização. }
  LHookBefore := WndProcHookBefore;
  LHookAfter := WndProcHookAfter;

  WndProcHookBefore := 0;
  WndProcHookAfter := 0;

  if LHookBefore <> 0 then
    UnhookWindowsHookEx(LHookBefore);

  if LHookAfter <> 0 then
    UnhookWindowsHookEx(LHookAfter);

  FMinimized := False;
  FMinimizedTime := 0;
  FMinimizedHandle := 0;
end;
{$ENDIF}

procedure pCallLogTot(const AstrMenssagem: String;
  const AobjPagueFacil: IAutoatendimentoPagueFacilRecebimentoPedido; const AException: Exception = Nil);
Const
  intTAMANHO_LOG_DESCRI = 255;
var
  LstrDocume: string ;
  LstrMsgLogErr: string ;
  LstrContexto: string ;
  LstrTrilha: string ;
  LstrDesLogTot: string ;
  LstrTitulo: string ;

  function fDescricaoFormaPagamento(const AstrTipoCartao: String): String;
  begin
    If AstrTipoCartao = 'D' Then
      Result := 'Débito'
    Else If AstrTipoCartao = 'C' Then
      Result := 'Crédito'
    Else If AstrTipoCartao = 'P' Then
      Result := 'PIX'
    Else If fEmptyStr(AstrTipoCartao) Then
      Result := '(não informada)'
    Else
      Result := AstrTipoCartao;
  end;

begin
  LstrDocume := '' ;
  LstrContexto := '' ;

  if Assigned(AobjPagueFacil) and Assigned(AobjPagueFacil.Pedido) then
    LstrDocume := AobjPagueFacil.Pedido.Numero ;

  try
    if Assigned(AobjPagueFacil) then
    begin
      LstrContexto := 'Forma de pagamento: ' + fDescricaoFormaPagamento(AobjPagueFacil.TipoCartao) +
                      '  Parcelas: ' + IntToStr(AobjPagueFacil.Parcelas) + sLineBreak ;

      if Assigned(AobjPagueFacil.Pedido) then
        LstrContexto := LstrContexto +
                        'Pedido: ' + AobjPagueFacil.Pedido.Numero + '-' +
                                     AobjPagueFacil.Pedido.Especie + '-' +
                                     AobjPagueFacil.Pedido.Empresa + sLineBreak ;
    end ;
  except
    // montar contexto e diagnostico: nunca pode derrubar o log do erro original
  end ;

  LstrTrilha := fRetornaTrilhaMensagensTotem ;

  // LOGTOT: mensagem que disparou o log + final da trilha (mensagens mais recentes)
  LstrDesLogTot := AstrMenssagem ;
  if not fEmptyStr(LstrTrilha) then
    LstrDesLogTot := LstrDesLogTot + ' | ' +
                     Copy(LstrTrilha,
                          Length(LstrTrilha) - (intTAMANHO_LOG_DESCRI - Length(AstrMenssagem) - 3) + 1,
                          intTAMANHO_LOG_DESCRI) ;

  if Length(LstrDesLogTot) > intTAMANHO_LOG_DESCRI then
    LstrDesLogTot := Copy(LstrDesLogTot, 1, intTAMANHO_LOG_DESCRI) ;

  pGravaLogTot(LstrDocume, LstrDesLogTot) ;

  if Assigned(AException) or (not fEmptyStr(LstrTrilha)) then
  begin
    LstrMsgLogErr := '' ;

    if not fEmptyStr(LstrTrilha) then
      LstrMsgLogErr := LstrTrilha + sLineBreak + sLineBreak ;

    LstrMsgLogErr := LstrMsgLogErr + LstrContexto +
                     'Mensagem: ' + AstrMenssagem + sLineBreak ;

    if Assigned(AException) then
      LstrMsgLogErr := LstrMsgLogErr + sLineBreak +
                       'CALL STACK:' + sLineBreak +
                       AException.StackTrace ;

    If Assigned(AException) Then
      LstrTitulo := 'Erro Pague Fácil'
    Else
      LstrTitulo := 'Diagnóstico Pague Fácil' ;

    pLimparTrilhaMensagensTotem ;
    pGravarErro(True, LstrTitulo, LstrMsgLogErr);
  end ;
end;

Type
  TYapayMonitor = class sealed(TInterfacedObject, IMonitorProcedure)
  public
    procedure pExecuteAll;
    procedure pExecute;
    function fExecute : TResultExecute;
  end;

{ TYapayMonitor }

function TYapayMonitor.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  pExecute;
end;

procedure TYapayMonitor.pExecute;
begin
  TYapayFacade.fExecutaRotinasMonitor;
  Sleep(RandomRange(30000, 60000));
end;

procedure TYapayMonitor.pExecuteAll;
begin
  TYapayFacade.fExecutaRotinasMonitor;
  Sleep(RandomRange(30000, 60000));
end;

procedure TfrmPrincipal.pVerAlteraPreco;
  Var
    qryGen: TUniQuery;
begin
  Screen.Cursor := crSQLWait;

  qryGen := fCriaQuery(Nil);

  With qryGen Do
  Begin
    SQL.Clear;
    SQL.Add(' SELECT ');
    SQL.Add('   PRE_DTAPRE ');
    SQL.Add(' FROM PREITE ');
    SQL.Add(' WHERE PRE_DTAPRE <= :DTAPRE AND ');
    SQL.Add('       PRE_CODEMP = :CODEMP ');

    ParamByName('DTAPRE').AsDateTime := VS_Date;
    ParamByName('CODEMP').AsString   := VS_strCodEmp;

    Open;
    If Not IsEmpty Then
      fMensagem('', 'Existem alterações de preços pendentes!',['&OK']);
    Close;
  End;

  FreeAndNil(qryGen);

  Screen.Cursor := crDefault;
end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
  Close;
  Windows.setFocus(0);
end;

procedure TfrmPrincipal.tmrRecorrenciaCrmTimer(Sender: TObject);
var
  objProcessar: TProcessarRecorrencia;
  LLogTmr: ILogTmr;
begin
  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If Not fCfgSis('OCOREC', varBoolean) Then
  Begin
    tmrRecorrenciaCrm.Enabled := False;
    Exit;
  End;

  If Assigned(VS_objTraceViewer) Then
    VS_objTraceViewer.LogTimer('tmrRecorrenciaCrmTimer');

  LLogTmr := TLogTmr.New('tmrRecorrenciaCrmTimer')
    .Enter('TProcessarRecorrencia.Create');

  objProcessar := TProcessarRecorrencia.Create;
  Try
    objProcessar.pProcessarRecorrencias;
  Finally
    FreeAndNil(objProcessar);
  End;

  LLogTmr.Exit;
end;

procedure TfrmPrincipal.tmrRelogioTimer(Sender: TObject);
var
  LLogTmr: ILogTmr;
begin
  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If MinutesBetween(fTime(True), horResetSleep) >= 1 Then
  Begin
    if FileExists(VS_ProcessId + '.msg') then
      if not assigned(ApplicationEvents.OnMessage) then
        ApplicationEvents.OnMessage := Self.OnApplicationEventsMessage;

    if FileExists(VS_ProcessId + '.end') then
    begin
      TThreadFinalizarAutcomMonitor.Monitorar;
      raise EFilerError.Create(VS_ProcessId + '.end File');
    end;

    If Assigned(frmModulo) And frmModulo.Database.Connected Then
    Begin
      VS_LastConnID := fGetConnectionID;//Apenas para manter conexao ativa
      horResetSleep := fTime(True);
    End;
  End;

  If Assigned(VS_objTraceViewer) Then
    VS_objTraceViewer.LogTimer('tmrRelogioTimer');

  LLogTmr := TLogTmr.New('tmrRelogioTimer').Enter;

  If VS_blnUsaFin Then
  Begin
    If (Date > VS_dtaIni) And (Time >= VS_hraFin) Then
    Begin
      tmrRelogio.Enabled := False;
      pFinalizaObjetos;
      pTerminate;
    End;
  End;

  If blnGerImpPdv or blnGerImpCTe Or fOpcoesIgnorar Or blnYapay Then
  Begin
    Try
      If (fOpcoesIgnorar) Then
      Begin
        If blnTerminouFormShow Then
          Application.ProcessMessages;

        If fTempoExecucaoExcedido Then
          pTerminate
        Else If Self.Visible Then
          Self.Hide;
      End
      Else
        Self.Hide;
    Except

    End;
  End
  Else If (VS_Date <> 0) Then
  Begin
    stbStatus.Panels[1].Text := FormatDateTime('dd/mm/yyyy', VS_Date);
    stbStatus.Panels[0].Text := FormatDateTime('hh:mm', fTime());

    if (not fEmptyStr(pnlMenTef.Caption)) and (VS_strUsaTef = 'S') and (not fInTransaction) then
    begin
    If SecondsBetween(hraMensagemTEF, fTime(True)) >= 10 Then   // 10 segundos
      begin
        pnlMenTef.Caption := '';
        pnlMenTef.Refresh;

        {$IFDEF TESTABILIDADE_AUTCOM}
        //não utiliza quando Teste Automatizado
        {$Else}
        If Not blnUsuarioLogadoUtilizaModoClassico Then
          Principal.View.FMXPrincipal.MostraMensagemTEF('');
        {$ENDIF}
      end;
    end;
  End;

  If (VS_Date <> 0) Then
  Begin
    If MinutesBetween(hrCicloHorOpe, fTime(True)) >= 10 Then
    Begin
      If fEmpresaUsuarioPreenchido Then
      Begin
        hrCicloHorOpe := fTime(True);
        THorOpe.fExisteRestricoesDeAcesso(resAcesso);
      End;
    End;
  End;

  if VS_blnTefModularIndisponivel then
    stbStatus.Panels[5].Text := 'TEF INATIVO'
  else if VS_blnTefContingencia then
    stbStatus.Panels[5].Text := 'TEF CONTINGÊNCIA'
  else
    stbStatus.Panels[5].Text := '';

  LLogTmr.Exit;
end;

procedure TfrmPrincipal.tmrSincEmailTimer(Sender: TObject);
begin
  if  (blnGerImpCTe) then
    Exit;

  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If VS_strCodEmp.IsEmpty Then
    Exit;

  If OperadorCitelLogado Then
  Begin
    tmrSincEmail.Enabled := False;
    Exit;
  End;

  If fCfgSis('EMASAI', VarString) = 'Desativado' Then
  Begin
    tmrSincEmail.Enabled := False;
    Exit;
  End;

  tmrSincEmail.Enabled := False;

  pVerificaSincronizacaoEmail;

  tmrSincEmail.Enabled := True;
end;

procedure TfrmPrincipal.tmrSistemaDEPSOnTimer(Sender: TObject);
var
  LLogTmr: ILogTmr;
begin
  if (blnGerImpCTe) then
    Exit;

  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If OperadorCitelLogado Then
  Begin
    tmrSistemaDEPS.Enabled := False;
    Exit;
  End;

  If Assigned(VS_objTraceViewer) Then
    VS_objTraceViewer.LogTimer('tmrSistemaDEPSTimer');

  LLogTmr := TLogTmr.New('tmrSistemaDEPSTimer')
    .Enter('TValidacoesSistemaDEPS.fRetornaStatusNaoLidosDoSistemaDEPSDoVendedor');

  tmrSistemaDEPS.Enabled := False;

  cdsStatusDEPS := TValidacoesSistemaDEPS.fRetornaStatusNaoLidosDoSistemaDEPSDoVendedor(strLoginUsuarioLogado);

  If Not cdsStatusDEPS.IsEmpty Then
  Begin
    dxAlertWindow.OptionsButtons.Buttons[1].Visible := True;
    dxAlertWindow.Show('AUTCOM - Sistema DEPS', 'Existem Orçamentos validados pelo Sistema DEPS!');
    dxAlertWindow.OptionsButtons.Buttons[1].Visible := False;
  End;
  
  tmrSistemaDEPS.Enabled := True;

  LLogTmr.Exit;
end;

procedure TfrmPrincipal.mnuPortosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPortos);
end;

procedure TfrmPrincipal.mnuAeroportosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAeroportos);
end;

procedure TfrmPrincipal.mnuIncotermsClick(Sender: TObject);
begin
  pCriarForm(TfrmCadIncoterms);
end;

procedure TfrmPrincipal.mnuCadConfiguracoesClick(Sender: TObject);
  Var
    strSenha: String;
    frmCfgSistema : TfrmCfgSistema;
begin
  If Not (fVerificaAcessoSistema(mnuCadConfiguracoes.Hint)) Then
  Begin
    fMensagem('', 'Esse usuário não tem direito a acessar esse módulo!', ['&Ok']);
    Exit;
  End;

  If ffrmSenha(strSenha) Then
  Begin
    If strSenha = fCfgSis('SENHA3') Then
    Begin

      If (Not fLock_Unlock('CFGSIS', True, False)) Then
      Begin
        fMensagem('', 'Há outra estação utilizando as configurações do sistema!', ['&Ok']);
        Exit;
      End;

      Try
        pCriarFormularios(TfrmCfgSistema, frmCfgSistema);
        pCriaRepositorioConfiguracoes(frmCfgSistema.cfgRepositorio);
        frmCfgSistema.ShowModal;

        IMPEXP.Caption := 'Expedição - F6 - Imprimir ' + IfThen(fCfgSis('SEPEXP') = 'P', 'Pedido', 'Separação');
      Finally
        fLock_Unlock('CFGSIS', False, False);
        pFreeAndNil(frmCfgSistema);
      End;

      dicConfiguracoes.Clear;
      dicDireitosEspecificos.Clear;
    End
    Else
    Begin
      fMensagem('', 'Senha Incorreta!', ['&Ok']);
    End;
  End;
end;

procedure TfrmPrincipal.pFilasBoletos;
begin
  pCriarForm(TfrmCfgFilasImpressaoBoletos);
end;

procedure TfrmPrincipal.pFilasNFCe;
begin
  pCriarForm(TfrmCfgFilasImpressaoNFCe);
end;

procedure TfrmPrincipal.pFilasSeparacao;
begin
  pCriarForm(TfrmCfgFilasImpressaoSeparacao);
end;

procedure TfrmPrincipal.pFinalizaAuttin;
begin
  If HandleDllAuttin <> 0 Then
  Begin
    pAjustaMenuTintaMaquinaLogOff;
    pFreeLibraryAutTin;
    HandleDllAuttin := 0;
    FLibAutTinInicializada := False;
    pAjustaPresencaFilhosFixosTintaMaquina(False);
  End;
end;

procedure TfrmPrincipal.pFinalizaObjetos;
begin
  If VS_FinalizandoAutCom Then Exit;

  VS_FinalizandoAutCom := True;

  If Assigned(frmModulo) Then
    pDeletaDicSisPorPidMd5(fGetConexao);

  DesabilitaEnvioEmails;

  TLogAut.New().pLogout();

  TThreadFinalizarAutcomMonitor.Monitorar;

  If Assigned(VS_TimerTransacao) Then
    VS_TimerTransacao.Enabled := False;

  If Assigned(objSemaforoGeralMenus) Then
    FreeAndNil(objSemaforoGeralMenus);

  If Assigned(stlTintasMenu) Then
    FreeAndNil(stlTintasMenu);

  If Assigned(stlTintaMdlls) Then
    FreeAndNil(stlTintaMdlls);

  If Assigned(mnuSubItemsTinta) Then
    FreeAndNil(mnuSubItemsTinta);

  If Assigned(mnuAuxTinta) Then
    FreeAndNil(mnuAuxTinta);

  If Assigned(lstSemaforos) Then
    FreeAndNil(lstSemaforos);

  If Assigned(utcRegistros) Then
    FreeAndNil(utcRegistros);

  If Assigned(lstRetirar) Then
    FreeAndNil(lstRetirar);

  If Assigned(lstVariaveis) Then
    FreeAndNil(lstVariaveis);

  If Assigned(objPlugin) Then
    FreeAndNil(objPlugin);

  {$IFDEF TESTABILIDADE_AUTCOM}
  If Assigned(frmTestabilidade) Then
  Begin
    frmTestabilidade.Close;
    pFreeAndNil(frmTestabilidade);
  End;
  {$ENDIF}

  If HandleDllTinta <> 0 Then
  Begin
    If Assigned(dxFinalizeTin) Then
      dxFinalizeTin;
    FreeLibrary(HandleDllTinta);
    HandleDllTinta := 0;
  End;

  pLog('pFinalizaObjetos>pFinalizaLibrarys;');
  pFinalizaLibrarys;

  If Assigned(frmModulo) Then
  Begin
    if VS_strUsaTef = 'S' then
      pDisponibilizaTefModular;

    If (Not blnImpSfaMob) Then
      pDisponibilizaChvRoboSFA;
  End;

  pLog('pFinalizaObjetos>frmModuloReplicacao;');
  If Assigned(frmModuloReplicacao) Then
    pDestroiModulo(frmModuloReplicacao, False);

  pLog('pFinalizaObjetos>frmModuloSPR;');
  If Assigned(frmModuloSPR) Then
    pDestroiModulo(frmModuloSPR, False);

  pLog('pFinalizaObjetos>frmModuloLegenda;');
  If Assigned(frmModuloLegenda) Then
    pDestroiModulo(frmModuloLegenda, False);

  pLog('pFinalizaObjetos>pFecharBanco(frmModulo.GetCurrentConnection);');
  If Assigned(frmModulo) Then
  Begin
    pGeraRegistroParaLogGeneral(frmModulo.GetCurrentConnection, 'pFinalizaObjetos > frmModulo.Database.Disconnect');
    pFecharBanco(frmModulo.GetCurrentConnection);
  End;

  pLog('pFinalizaObjetos>pDestroiModulo(frmModulo);');
  If Assigned(frmModulo) Then
    pDestroiModulo(frmModulo, False);

  If Assigned(VS_ListaDeCarteiras) Then
    FreeAndNil(VS_ListaDeCarteiras);

  If Assigned(mnuRelFav) Then
    FreeAndNil(mnuRelFav);

  If Assigned(dicOrdenaMnu) Then
    FreeAndNil(dicOrdenaMnu);

  If Assigned(pnlPanelItemPrecoProduto) Then
    FreeAndNil(pnlPanelItemPrecoProduto);

  If Assigned(VS_ModelosAvisosEmailAtivado) THen
  Begin
    FreeAndNil(VS_ModelosAvisosEmailAtivado);
    FreeAndNil(VS_ModelosAvisosSMSAtivado);
    FreeAndNil(VS_ModelosAvisosWPPAtivado);
  End;
end;

procedure TfrmPrincipal.pFuncoesDiariasAutomatico(strCodEmp: String);
Begin

  pSetaEmpresaLogada(strCodEmp);
  fAjustaDataSistema;
  If pAtuVarGlobais Then
    pFuncoesDiarias(True);

End;

procedure TfrmPrincipal.pFuncoesDiariasAutomaticoEmpresas;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Clear;
    Add('SELECT EMP_CODEMP FROM CADEMP');
    Open;

    While Not Eof Do
    Begin
      pFuncoesDiariasAutomatico(FieldByName('EMP_CODEMP').AsString);
      Next;
    End;

    Close;
  End;

  FreeAndNil(qryGen);
End;


procedure TfrmPrincipal.pGeraEtiquetaGondolaComPreco;
var
  prmDllEtq: TParamDllEtiquetas;
  strCfgTipEti: String;
begin
  prmDllEtq := TParamDllEtiquetas.Create;
  Try
    VS_ExibirMensagemAoUsuario := False;
    VS_ExibirMensagemDeErro    := False;
    VS_ExibirMensagemAguarde   := False;

    strCfgTipEti := fCfgSis('TIPETI');
    If strCfgTipEti = 'Z' Then
      prmDllEtq.tpeTipEtq := tpeItensZebraGondolaCPre
    Else
      prmDllEtq.tpeTipEtq := tpeItensArgoxGondolaCPre;
    prmDllEtq.blnImpAut := True;
    prmDllEtq.strCodIte := ParamStr(2);
    prmDllEtq.strCodEmp := ShortString(ParamStr(3)); // ShortString(IfThen(fEmptyStr(strCodEmpAlt) Or (strCodEmpAlt = '000'), VS_strCodEmp, strCodEmpAlt));
    If (prmDllEtq.strCodIte <> '') And (prmDllEtq.strCodEmp <> '') Then
      fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetaitens');
  Finally
    FreeAndNIl(prmDllEtq)
  End;
End;


procedure TfrmPrincipal.pGeraEtiquetaMontagemCaixa;
var
  prmDllEtq: TParamDllEtiquetas;
  cdsCaixas: TUniClientDataSet;
begin
  If Not fAtivadoMontagemCaixaConferenciaAUTCOMColetor Then
    Exit;

  cdsCaixas := Nil;
  prmDllEtq := TParamDllEtiquetas.Create;
  Try
    cdsCaixas := TMontarCaixas.fRetornaDataSetEtiquetaMontagemCaixas(ParamStr(2));

    VS_ExibirMensagemAoUsuario := False;
    VS_ExibirMensagemDeErro    := False;
    VS_ExibirMensagemAguarde   := False;

    prmDllEtq.blnImpEtiquetaMontagemCaixa := True;
    prmDllEtq.cdsDadosEtiqueta := cdsCaixas;
    prmDllEtq.strOpeImp := fBuscaOperadorImpEtiquetaMontagemCaixa(ParamStr(1), ParamStr(2));

    If (Assigned(prmDllEtq.cdsDadosEtiqueta)) And
       (prmDllEtq.cdsDadosEtiqueta.RecordCount > 0) Then
      fImprimeEtiqueta(prmDllEtq, 'pimprimeetiquetamontagemcaixas');
  Finally
    FreeAndNIl(prmDllEtq);

    If Assigned(cdsCaixas) Then
      FreeAndNil(cdsCaixas);
  End;
end;

procedure TfrmPrincipal.pGeraEtiquetaDespacho;
  Var
    frmImpEtiDespacho: TfrmImpEtiDespacho;
begin
  VS_ExibirMensagemAoUsuario := False;
  VS_ExibirMensagemDeErro    := False;
  VS_ExibirMensagemAguarde   := False;
  Try
    pCriarFormularios(TfrmImpEtiDespacho, frmImpEtiDespacho);

    frmImpEtiDespacho.blnImpEti := True;
    frmImpEtiDespacho.blnImpAut := True;
    frmImpEtiDespacho.strNomFil := ParamStr(8);

    frmImpEtiDespacho.pOnShow;

    frmImpEtiDespacho.edtNumDoc.Text := ParamStr(4);
    frmImpEtiDespacho.edtEspDoc.Text := ParamStr(5);
    frmImpEtiDespacho.edtCodEmp.Text := ParamStr(6);
    frmImpEtiDespacho.edtCodCli.Text := fRetornaInformacaoVenda(ParamStr(4), ParamStr(5), ParamStr(6), 'CODCLI');
    frmImpEtiDespacho.edtQtdVol.Text := ParamStr(7);
    frmImpEtiDespacho.strCodCli      := frmImpEtiDespacho.edtCodCli.Text;

    If frmImpEtiDespacho.fValidarTodosCampos Then
      frmImpEtiDespacho.btnConfirma.Click;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmPrincipal -> pGeraEtiquetaDespacho]');
  End;
  pFreeAndNil(frmImpEtiDespacho);
end;

procedure TfrmPrincipal.pGeraEtiquetaVolume;
var
  prmDllEtq: TParamDllEtiquetas;
begin

  prmDllEtq := TParamDllEtiquetas.Create;
  Try
    VS_ExibirMensagemAoUsuario := False;
    VS_ExibirMensagemDeErro    := False;
    VS_ExibirMensagemAguarde   := False;

    prmDllEtq.blnImpEti := True;
    prmDllEtq.blnImpAut := True;
    prmDllEtq.strCodEmp := ShortString(ParamStr(2));
    prmDllEtq.strNumDoc := ShortString(fCampoTabela('FGO_NUMDOC', 'FATGOR', ['AUTOINCREM'], [ShortString(ParamStr(4))]));
    prmDllEtq.strEspDoc := 'PD';
    prmDllEtq.strTipoFC := 'C';
    prmDllEtq.strNomTab := 'FATGOR';
    prmDllEtq.intQtdVol := StrToInt(ParamStr(5));
    if (fCfgSis('ETIDES', varString) = 'L') then
    begin
      prmDllEtq.tpeTipEtq := tpeDespachoLaser;
      prmDllEtq.strLayDoc := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_PADRAO', 'LAY_CODEMP'], ['35', 'S', ShortString(ParamStr(2))]);
    end
    else
    begin
      prmDllEtq.tpeTipEtq := tpeDespachoArgox;
      prmDllEtq.strLayDoc := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_PADRAO', 'LAY_CODEMP'], ['36', 'S', ShortString(ParamStr(2))]);
    end;
    prmDllEtq.strNomFil := ParamStr(6);

    fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetas');

  Finally
    FreeAndNIl(prmDllEtq)
  End;
End;

procedure TfrmPrincipal.pGeraEtiquetaBoxPedido;
  var
    frmCadBoxEti : TfrmCadBoxEti;
    strNumDoc,
    strEspDoc,
    strCodEmp,
    strCodCli,
    strCodBox,
    strNomImp : String;
begin

  //Exemplo: IMPRIME_ETIQUETA_BOX_PEDIDO_0001_010_998_CutePDF Writer

  frmCadBoxEti := TfrmCadBoxEti.Create(nil);

  Try

    strCodEmp := Copy(ParamStr(1), 34, 3);
    strCodBox := Copy(ParamStr(1), 29, 4);

    strNumDoc := fCampoTabela('BOX_NUMDOC', 'CADBOX', ['BOX_CODIGO', 'BOX_EMPDOC'], [ShortString(strCodBox), ShortString(strCodEmp)]);
    strEspDoc := 'PD';
    strNomImp := Copy(ParamStr(1), 42, Length(ParamStr(1)));
    strCodCli := fCampoTabela('FGO_CODCLI', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [strNumDoc, strEspDoc, strCodEmp]);

    frmCadBoxEti.pImprimirBoxSep(strNumDoc, strEspDoc, strCodEmp, strCodCli, strNomImp);

  Finally
    FreeAndNil(frmCadBoxEti);
  End;

End;

procedure TfrmPrincipal.FormShow(Sender: TObject);
  Var
    frmImportacaoSfaMobAndroid: TfrmImportacaoSfaMobAndroid;
    blnConfirma : Boolean;

    strVendSfaMob: String;
    stlVendSfaMob: TStringList;

    intContador : Integer;

    objComMovMe: TMovMeComunica;

    objSeparacaoFina : TSeparacaoFina;

    {$IFNDEF TESTABILIDADE_AUTCOM}
    frmAutoatendimentoPagueFacil : TfmxRecebimentoPedido;
    frmAutoatendimentoConsultaPreco : TfmxConsultaPreco;
    {$ENDIF}

    frmTxtSfaMobImp: TfrmTxtSfaMobImp;
    frmTxtACACIAServer: TfrmTxtACACIAServer;
    frmTxtACACIAServerImp: TfrmTxtACACIAServerImp;
    frmTxtACACIAServerExpAndroid: TfrmTxtACACIAServerExpAndroid;
    frmTxtACACIAServerImpAndroid: TfrmTxtACACIAServerImpAndroid;
    frmVendaAssistida: TfrmVendaAssistida;

    ProcessaObjetosbancoPreAlt: TProcessaObjetosbancoPreAlt;
    frmLog: TfrmLog;
    LstrMensagemValidacao: String ;

    LIdMonitor: String;

    intCodRel: Integer;
    sltAuxParamRel: TStringList;
    arrParametros, arrValores: Array Of String;

  procedure pVerificaEntregasEmpresa(strCodEmp: String);
    Var
      objConEnt: TControleEntrega;
  begin
    pSetaEmpresaLogada(strCodEmp);

    If (Not fEmptyStr(fRetNomeEmpresa)) And
       (Not fEmptyStr(fRetNomeOperador(strLoginUsuarioLogado))) Then
    Begin
      fAjustaDataSistema;

      If pAtuVarGlobais And (fCfgSis('CONENT', varBoolean)) Then
      Begin
        Try

          objConEnt := TControleEntrega.Create(nil);
          objConEnt.pVerificaEntregas(True);
          FreeAndNil(objConEnt);

        Except
          On E: Exception Do
          Begin
            Screen.Cursor := crDefault;
            pMensagensErro(E.Message, '[pVerificaEntregasEmpresa]');
          End;
        End;
      End;

    End;

  end;

  {***************************************************}
  {* TRANSFERÊNCIA AUTOMÁTICA - EMPRESA CARREGAMENTO *}
  {*REQ.148688*************************************RP*}
  procedure pVerificaTransfAutoEmpCar(Const strCodUsu, strCodEmp: String);
    Var
      objMovEmpCar: TMovEmpCar;
  begin
    strLoginUsuarioLogado := strCodUsu;
    pCarregarVariaveisUsuarioLogado;
    pSetaEmpresaLogada(strCodEmp);

    If fEmptyStr(fRetNomeEmpresa) Then
      Exit;
    If fEmptyStr(fRetNomeOperador(strLoginUsuarioLogado)) Then
      Exit;

    fAjustaDataSistema;

    If pAtuVarGlobais And (fCfgSis('EMPCAR', varBoolean)) Then
    Begin
      Try
        objMovEmpCar := TMovEmpCar.Create(Self);
        objMovEmpCar.pProcessaTransferenciasPendentes(strCodEmp);
        FreeAndNil(objMovEmpCar);
      Except On E: Exception Do
        pMensagensErro(E.Message, '[pVerificaTransfAutoEmpCar]');
      End;
    End;
  end;

  function fDefineEmpresaAutcom: String;

    function fEmpresaValida(strEmpVal: String): Boolean;
    begin
      Result := (Not fEmptyStr(strEmpVal)) And
                (Not fEmptyStr(fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_CODEMP'], [strEmpVal])));
    end;

    Function fDefineEmpresa: String;
    Begin
      Result := fCampoTabela('EMP_CODEMP', 'CADEMP', ['1'], ['1']);
      pSetaEmpresaLogada(Result);
      If Not fEmptyStr(fCfgSis('EMPMAT')) Then
        Result := fCfgSis('EMPMAT');
    End;

  begin
    If blnAutoGiro Then
      Result := fArqIni(0, 'GERAL', 'CODEMP', '')

    Else If (blnYapay) Or
            (blnExpTigre) Or
            (blnExpRelatorio) Or
            (blnGerImpPdv) Or
            (blnAutoEntTE) Or
            (blnGerSfaMob) Or
            (blnImpSfaMob) Or
            (blnExpHenkel) Or
            (blnGerImpCTe) Or
            (blnGerSfaEst) Or
            (blnImpGeoSales) Or
            (blnVendaAssistida) Or
            (blnAcaoAutomaticaCRM) Or
            (blnDisparaEmailAutEnt) Or
            (blnDisparaEmailPedidoCompra) Or
            (blnImprimeSeparacaoFina) Or
            (blnConsultaPrecoTintas) Or
            (blnSpedFiscal) Or
            (blnSpedPisCofins) Or
            (blnDefinirLotesWMS) Or
            (blnFaturamentoAutomatico) Or
            (blnCanceladorAutomatico) Or
            (blnImprimeEtiquetaDespacho) Or
            (blnImprimeEtiquetaVolume) Or
            (blnNotificacoesMonitor) Or
            (blnDesmembramentoPedidoPIX) Or
            (blnGatilhosInformacao) Or
            (blnGatilhosImediatos) Or
            (VS_AutoatendimentoPagueFacil) Or
            (VS_AutoatendimentoConsultaPreco) Or
            (VS_AutoatendimentoBuscaFacil) Then
    Begin
      Result := ParamStr(2);

      If Not fEmpresaValida(Result) Then
        Result := fDefineEmpresa;
    End
    Else If blnCompeConf Or
            blnConAjuCom Or
            blnMotorConf Or
            blnConAjuMot Then
    Begin
      Result := fArqIni(0, 'GERAL', 'CODEMP', '');

      If fEmptyStr(Result) Then
        Result := fDefineEmpresa;
    End

    Else
    Begin
      Result := fDefineEmpresa;
    End;

  end;

begin

  if blnYapay then
    pHideApplicationEx(False);

  Try

    VS_APPLICATION_HANDLE := Application.Handle;

    Try
      VS_HEIGHT_START_MENU_WINDOWS := (Screen.Height - Self.Height);
    Except
      VS_HEIGHT_START_MENU_WINDOWS := 0;
    End;

    VS_blnPreAltViaTrigger := fConfiguracaoAtivaTriggerPreAlt;

    ProcessaObjetosbancoPreAlt :=  TProcessaObjetosbancoPreAlt.Create;
    Try
      If not ProcessaObjetosbancoPreAlt.fValidaTrigger Then
      Begin
        If VS_blnPreAltViaTrigger Then
        begin
          pCriarFormularios(TFrmlog, frmLog);
          Try

            fMensagem('Atenção', 'Não foi encontrado a estrutura necessária para restauração de preços.' + #$A#$D +
                       ProcessaObjetosbancoPreAlt.strErro + #$A#$D + 'Para prosseguir rodar o scritpt que iremos apresentar a seguir.', ['OK']);

            frmLog.Caption  := 'Script';

            frmLog.memLog.Text := ProcessaObjetosbancoPreAlt.fGetSQL_CUSTOREAL.Text + #$A#$D +
                                  ProcessaObjetosbancoPreAlt.fGetSQL_COMPRALIQUIDO.Text + #$A#$D +
                                  ProcessaObjetosbancoPreAlt.fGetSQL_PINSEREPREALT.Text + #$A#$D +
                                  ProcessaObjetosbancoPreAlt.fGetSQL_Trigger;
            frmLog.Showmodal;
          Finally
            FreeAndNil(frmLog);
          End;
        End
        Else
          fMensagem('Atenção', ProcessaObjetosbancoPreAlt.strErro, ['OK']);

        pTerminate;
        Exit;
      End;
    Finally
      FreeAndNil(ProcessaObjetosbancoPreAlt);
    End;

    if not fValidaNumeroParametrosTotem(LstrMensagemValidacao) then
    begin
      fMensagem('','Para o Auto Atendimento funcionar serão necessários 3 parâmetros!' + #13 + LstrMensagemValidacao, ['OK']);
      pFinalizaObjetos;
      pTerminate;
      Exit;
    end ;


    If Not blnExecutandoAutBan And Not blnExecutandoAutTin Then
    Begin
      blnConfirma := True;

      If VS_AutcomIniciadoModoRobo Then
      Begin
        {******************************************************************************************}
        {* PRECISA DEFINIR A EMPRESA AQUI POIS VÁRIAS FUNÇÕES UTILIZAM A fCfgSis() QUE POR SUA    *}
        {* VEZ USA A EMPRESA LOGADA PARA ACESSAR A CFG, PORÉM , NEM SEMPRE A EMPRESA 001 ECZISTE! *}
        {***************************************************************************************RN*}
        strLoginUsuarioLogado := LOG_ADM;
        If blnImpSfaMob Then
        Begin
          If (Not fEmptyStr(ParamStr(3))) And (Not fEmptyStr(fRetNomVendRep(ParamStr(3)))) Then
           strLoginUsuarioLogado := ParamStr(3);
        End;
        pCarregarVariaveisUsuarioLogado;
        pSetaEmpresaLogada(fDefineEmpresaAutcom);
        fAjustaDataSistema;
        pAtuVarGlobais;

        VerificaConfiguracaoForcarEmail;

        VS_strHabilitarCRM := ((fArqIni(0, 'GERAL', 'CRM', '') = 'S') And (fCfgSis('UTICRM', varBoolean)));
        VS_ImprimeSepFaturados := False;

        If blnEnviaPLP_WMS Then
        Begin
          VS_ExibirMensagemAoUsuario := False;
          VS_ExibirMensagemDeErro    := False;
          VS_ExibirMensagemAguarde   := False;
          //É preciso informar o Usuário pelo motivo que a configuração de envio de E-mail esta por Operador.
          // temos que deixar um operador especifico para isso;
          strLoginUsuarioLogado := fCfgSis('OPEWMS', varString);
          pCarregarVariaveisUsuarioLogado;
          If fEmptyStr(strLoginUsuarioLogado) Then
          Begin
            fMensagem('','Configure o usuário responsável pelo envio de e-mail para continuar!' + #13 + 'Configurações do Sistema: "CFG_OPEWMS"', ['OK']);
            pFinalizaObjetos;
            pTerminate;
            Exit;
          End;
        End;

        If blnYapay Or blnDefinirLotesWMS Or blnFaturamentoAutomatico Or blnCanceladorAutomatico Or
           blnImprimeEtiquetaDespacho Or blnImprimeEtiquetaVolume Or
           blnNotificacoesMonitor Or blnDesmembramentoPedidoPIX Or blnGatilhosInformacao Or blnGatilhosImediatos Or blnConsultaPrecoTintas Or
           blnSpedFiscal Or blnSpedPisCofins Or VS_AutoatendimentoPagueFacil Or
           VS_AutoatendimentoConsultaPreco Or VS_AutoatendimentoBuscaFacil Then
        Begin
          ShowWindow(Application.Handle, SW_HIDE);
        End;

        if blnExpTigre and blnConfirma then
        begin
          Try
            pSetaEmpresaLogada(ParamStr(2));
          Except
            pSetaEmpresaLogada('');
          End;

          Try
            strLoginUsuarioLogado := ParamStr(3);
            pCarregarVariaveisUsuarioLogado;
          Except
            strLoginUsuarioLogado := '';
          End;
        end;

        if blnExpRelatorio and blnConfirma then
        begin
          Try
            pSetaEmpresaLogada(ParamStr(3));
          Except
            pSetaEmpresaLogada('');
          End;

          Try
            strLoginUsuarioLogado := ParamStr(4);
            pCarregarVariaveisUsuarioLogado;
          Except
            strLoginUsuarioLogado := '';
          End;
        end;

        TLogGor.blnExecutaLog := fTabelaExiste('LOGGOR', True) And fTabelaExiste('LOGDOR', True);
      End;

      {********************************}
      {* INICIANDO A DLL "libFuncoes" *}
      {*****************************AN*}
      If blnConfirma Then
      Begin
        pCarregaTABNRE;
        If Not blnImpMovMe Then
          pCarregarLibFuncoes;
      End;

      VS_blnUsaItemPigmento := fUsaItemPigmento;

      {**********}
      {* SPLASH *}
      {**********}
      If blnConfirma And VS_AutcomIniciadoModoRobo Then
      Begin
        blnGeracaoAut := True;

        blnConfirma := TSplash.Create(VS_AutcomIniciadoModoRobo,
                                      blnGerImpPdv,
                                      True,
                                      pIniciaPreencheTagDir,
                                      nil,
                                      nil,
                                      nil,
                                      nil,
                                      nil).ExecutarSplash;

        If Not blnConfirma Then
          blnFecharForm := True;

        pVerificaTEF;
      End;

      If (blnConfirma) And (ParamCount > 0) And (VS_AutcomIniciadoModoRobo) Then
      Begin
        Try
          //registra no LOGACE como o autcom foi chamado em modo robo com seus parâmetros;
          TLogAut.New().pLogin();
        Except
          //
        End;
      End;
      
      If blnVendaAssistida And blnConfirma Then
      Begin
        Try
          fAjustaDataSistema;
          pAtuVarGlobais;
          pCriarFormularios(TfrmVendaAssistida, frmVendaAssistida);
          frmVendaAssistida.ShowModal;
        Except

        End;
        FreeAndNil(frmVendaAssistida);
        pFinalizaObjetos;
        pTerminate;
      End;

      if blnEnviaPLP_WMS And blnConfirma Then
      Begin
        pEnviaEmailPLP_WMS;
        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      If blnGerSfaMob And blnConfirma Then
      Begin

        If fCfgSis('MODSFA') = '1' Then
        Begin

          strVendSfaMob := '';
          stlVendSfaMob := TStringList.Create;

          If ParamCount > 1 Then
          Begin
            VS_ExibirMensagemAoUsuario := False;
            VS_ExibirMensagemDeErro    := False;
            VS_ExibirMensagemAguarde   := False;

            pCarregarLibTintaMaquina;

            strVendSfaMob := ParamStr(2);
            strVendSfaMob := AnsiReplaceStr(strVendSfaMob, '[', '');
            strVendSfaMob := AnsiReplaceStr(strVendSfaMob, ']', '');
            strVendSfaMob := AnsiReplaceStr(strVendSfaMob, ',', #13#10);

            stlVendSfaMob.Text := strVendSfaMob;

            For intContador := 0 To stlVendSfaMob.count -1 Do
            Begin

              If Assigned(prcExecutaRelatorio) Then
              begin
                prcExecutaRelatorio(272, 8965, [8966,8967,8968,8969,8970,8971,8972,8973,8974,
                                                8975,8976,8977,8978,8979,8980,8981,8982,8983,
                                                8984,8985,8986,8987,8988,8989,8990,8991,8992,8993],
                                  ['CODREP'],
                                  [QuotedStr(fStrZero(stlVendSfaMob[intContador], 3))],
                                  nil,
                                  nil,
                                  True,
                                  False);
              End;

            End;

          end;

          FreeAndNil(stlVendSfaMob);

        End;

        pFinalizaObjetos;
        pTerminate;
        Exit;

      End;

      If blnGerSfaEst And blnConfirma Then
      Begin

        If fCfgSis('MODSFA') = '1' Then
        Begin
          If Assigned(prcExecutaRelatorio) Then
          begin
            VS_ExibirMensagemAoUsuario := False;
            VS_ExibirMensagemDeErro    := False;
            VS_ExibirMensagemAguarde   := False;

            pCarregarLibTintaMaquina;

            prcExecutaRelatorio(272, 8965, [8966,8967,8968,8969,8970,8971,8972,8973,8974,
                                            8975,8976,8977,8978,8979,8980,8981,8982,8983,
                                            8984,8985,8986,8987,8988,8989,8990,8991,8992,8993],
                                ['CODREP'],
                                [''],
                                nil,
                                nil,
                                True,
                                False);
          End;
        End;

        pFinalizaObjetos;
        pTerminate;
        Exit;

      End;

      If blnImpSfaMob And blnConfirma Then
      Begin

        If fCfgSis('MODSFA') = '1' Then
        Begin
          Try
            pCriarFormularios(TfrmTxtSfaMobImp, frmTxtSfaMobImp);
            frmTxtSfaMobImp.blnGeracaoAut := blnImpSfaMob;
            frmTxtSfaMobImp.ShowModal;
          Except

          End;
          FreeAndNil(frmTxtSfaMobImp);
        End
        Else
        Begin
          TNewTimer.SuspendedTimers.Add('frmPrincipal');
          Application.ProcessMessages;

          Try
            pLog('fLock_Unlock(CHAVE_LOCK_SFAMOB, True, False, False, '', False);');
            If fLock_Unlock(CHAVE_LOCK_SFAMOB, True, False, False, '', False) Then
            Begin
              Try
                Try
                  pLog('pCarregarLibTintaMaquina;');
                  pCarregarLibTintaMaquina;

                  pLog('pCriarFormularios(TfrmImportacaoSfaMobAndroid, frmImportacaoSfaMobAndroid);');
                  pCriarFormularios(TfrmImportacaoSfaMobAndroid, frmImportacaoSfaMobAndroid);
                  frmImportacaoSfaMobAndroid.blnModoRobo := True;

                  pLog('frmImportacaoSfaMobAndroid.btnImporta.Click;');
                  frmImportacaoSfaMobAndroid.btnImporta.Click;

                  If frmImportacaoSfaMobAndroid.btnGravar.Enabled Then
                  Begin
                    pLog('frmImportacaoSfaMobAndroid.btnImporta.Click;');
                    frmImportacaoSfaMobAndroid.btnGravar.Click;
                  End;  
                Except
                  //
                End;
              Finally
                pLog('fLock_Unlock(CHAVE_LOCK_SFAMOB, False, False, False, '', False);');
                fLock_Unlock(CHAVE_LOCK_SFAMOB, False, False, False, '', False);

                pLog('pFreeAndNil(frmImportacaoSfaMobAndroid);');
                pFreeAndNil(frmImportacaoSfaMobAndroid);
              End;
            End;
          Finally
            pLog('pFinalizaObjetos;');
            pFinalizaObjetos;
            pLog('pTerminate;');
            pTerminate;
          End;

          pLog('Exit;');
          Exit;
        End;
      End;

      If (blnGerExpPre Or blnGerExpPreGertec) And blnConfirma Then
      Begin
        ExportaBuscaPreco(ParamStr(2), ParamStr(3), blnGerExpPreGertec);
        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      if blnYapay then
      begin
        strLoginUsuarioLogado := ParamStr(3);
        pCarregarVariaveisUsuarioLogado;
        pHideApplicationEx(True);

        Try
          If TUtilMonitor.fLockMonitor(TYapayFacade.objCfgMonitor.strID_MONITOR, TYapayFacade.objCfgMonitor.VS_strLockMonitor) Then
          Begin
            TMonitor.New()
              .IdMonitor(TYapayFacade.objCfgMonitor.strID_MONITOR)
              .TimeLimit(StrToIntDef(GetParamValue('TL='), TYapayFacade.objCfgMonitor.intTIME_LIMIT_MONITOR))
              .LockMonitor(TYapayFacade.objCfgMonitor.VS_strLockMonitor)
              .ProcedureExec(TYapayMonitor.Create())
              .pStart();
          End;
        Finally
          TUtilMonitor.fRemoveLockMonitor(TYapayFacade.objCfgMonitor.strID_MONITOR);
        End;

        pFinalizaObjetos;
        pTerminate;
        Exit;
      end;

      If blnGerImpPdv And blnConfirma Then
      Begin
        ShowWindow(Application.Handle, SW_HIDE);
        if Assigned(tmrDataSistema) then
          tmrDataSistema.Enabled := False;
        If fLockImportacao Then
        Begin
          pCarregarLibTintaMaquina;
          pGeraMenusConsultaTinta;
          pImportarAutomatico;
        End;
        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      If blnGerImpCTe And blnConfirma Then
      Begin
        ShowWindow(Application.Handle, SW_HIDE);
        pAtuVarGlobaisSimples;
        if Assigned(tmrDataSistema) then
          tmrDataSistema.Enabled := False;
        If fLockImportacaoCTe Then
          pImportarCTes;

        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      If (Not blnConfirma) Then
        Exit;

      If blnAutoGiro Then
      Begin

        pSetaEmpresaLogada(fArqIni(0, 'GERAL', 'CODEMP', ''));

        If fEmptyStr(VS_strCodEmp) Then
           pFuncoesDiariasAutomaticoEmpresas
        Else
           pFuncoesDiariasAutomatico(VS_strCodEmp);

        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      If blnAutoEntTE Then
      Begin
        strLoginUsuarioLogado := ParamStr(3);
        pCarregarVariaveisUsuarioLogado;

        If (Not fEmptyStr(fRetNomeEmpresa)) And
           (Not fEmptyStr(fRetNomeOperador(strLoginUsuarioLogado))) Then
        Begin
          pGeraEntradaTransfEstoque(ParamStr(4), ParamStr(5), ParamStr(6));
        End;

        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      If blnAcaoAutomaticaCRM Then
      Begin
        strLoginUsuarioLogado := ParamStr(3);
        pCarregarVariaveisUsuarioLogado;

        If (Not fEmptyStr(fRetNomeEmpresa)) And
           (Not fEmptyStr(fRetNomeOperador(strLoginUsuarioLogado))) Then
        Begin
          TCRMGeracaoGlobal.pProcessarAcoesAutomaticasCRM(False);
        End;

        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      If blnDisparaEmailAutEnt Then
      Begin
        strLoginUsuarioLogado := ParamStr(3);
        pCarregarVariaveisUsuarioLogado;

        If (Not fEmptyStr(fRetNomeEmpresa)) And
           (Not fEmptyStr(fRetNomeOperador(strLoginUsuarioLogado))) Then
        Begin
          TEmaAutEnt.pDispatchAutomaticEmails();
        End;

        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      If blnDisparaEmailPedidoCompra Then
      Begin
        TDisparaEnvioEmailPedidoDeCompraAutomatico.pDisparaEmailAutomatico;
        pFinalizaObjetos;
        pTerminate;
        Exit;

      End;

      If blnAutoConEnt Then
      Begin
        strLoginUsuarioLogado := ParamStr(2);//USUARIO LOGADO
        pCarregarVariaveisUsuarioLogado;

        Try
          TLogAut.New().pUpdate;
        Except
          //
        End;

        pVerificaEntregasEmpresa(ParamStr(3));//GERA TRANFERENCIA DE ESTOQUE (EMPRESA FORNECEDORA)
        pVerificaEntregasEmpresa(ParamStr(4));//GERA ENTRADA DE MERCADORIAS  (EMPRESA SOLICITANTE)

        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      If blnExpGeoSales And blnConfirma Then
      Begin
        TfrmGeoSales.pExporta(True);
        pFinalizaObjetos;
        pTerminate;
      End;

      If blnImpMovMe And blnConfirma Then
      Begin
        TNewTimer.SuspendedTimers.Add('frmPrincipal');
        Application.ProcessMessages;

        VS_strHabilitarCRM := ((fArqIni(0, 'GERAL', 'CRM', '') = 'S') And (fCfgSis('UTICRM', varBoolean)));
        objComMovMe := TMovMeComunica.Create(Nil);
        Try
          If fLock_Unlock(CHAVE_LOCK_MOVMER, True, False, False, '', False) Then
          Begin
            objComMovMe.pConsumirDados;
            fLock_Unlock(CHAVE_LOCK_MOVMER, False, False, False, '', False);
          End;
        Finally
          FreeAndNil(objComMovMe);
          pFinalizaObjetos;
          pTerminate;
        End;

        Exit;
      End;

      If blnImpGeoSales And blnConfirma Then
      Begin
        Try
          pSetaEmpresaLogada(ParamStr(2));
        Except
          pSetaEmpresaLogada('');
        End;

        Try
          strLoginUsuarioLogado := ParamStr(3);
          pCarregarVariaveisUsuarioLogado;
        Except
          strLoginUsuarioLogado := '';
        End;

        If fEmptyStr(fRetNomeOperador(strLoginUsuarioLogado)) Then
        Begin
          fMensagem('', 'Não foi informado o código do operador responsável pela importação.' + #13 +
                        'O Parametro deve seguir o padrão "GEOSALES_IMPORTAR 000 888", onde 000 é o código da empresa e 888 o Código do Operador!', ['&OK']);
          pFinalizaObjetos;
          pTerminate;
          Exit;
        End;

        If fEmptyStr(fRetNomeEmpresa) Then
        Begin
          fMensagem('', 'Não foi informado o código da empresa da importação.' + #13 +
                        'O Parametro deve seguir o padrão "GEOSALES_IMPORTAR 000 888", onde 000 é o código da empresa e 888 o Código do Operador!', ['&OK']);
          pFinalizaObjetos;
          pTerminate;
          Exit;
        End;

        If (fEmptyStr(fCfgSis('IMPGEO', varString))) Or (not TryDirectoryExists(fCfgSis('IMPGEO', varString))) Then
        Begin
          fMensagem('', 'É necessário configurar o diretório padrão da importação nas configurações do sistema "CFG_IMPGEO"!', ['&OK']);
          pFinalizaObjetos;
          pTerminate;
          Exit;
        End;

        TfrmGeoSales.pImporta(True);
        pFinalizaObjetos;
        pTerminate;

      End;

      if blnExpTigre and blnConfirma then
      begin
        Try
          pSetaEmpresaLogada(ParamStr(2));
        Except
          pSetaEmpresaLogada('');
        End;

        Try
          strLoginUsuarioLogado := ParamStr(3);
          pCarregarVariaveisUsuarioLogado;
        Except
          strLoginUsuarioLogado := '';
        End;

        If fEmptyStr(fRetNomeOperador(strLoginUsuarioLogado)) Then
        Begin
          fMensagem('', 'Não foi informado o código do operador responsável pela importação.' + #13 +
                        'O Parametro deve seguir o padrão "IMPORTACAO_TIGRE 000 999", onde 999 é o Código do Operador!', ['&OK']);
          pFinalizaObjetos;
          pTerminate;
          Exit;
        End;

        strEmpAcessoUsuarioLogado := fRetEmpAcessoUsuario(strLoginUsuarioLogado);
        strEmpConsVendFatur := fRetEmpConsVendFatur(strLoginUsuarioLogado);

        If Assigned(prcExecutaRelatorio) Then
        begin
          VS_ExibirMensagemAoUsuario := False;
          VS_ExibirMensagemDeErro    := False;
          VS_ExibirMensagemAguarde   := False;

          pCarregarLibTintaMaquina;

          prcExecutaRelatorio(267, 8733, [8734,8735,8736,8737,8738,8739,8740,8741,8742,8743,8744,8745,8746,8747,8748,8749,8750,8751,8752],
                              ['DTAINI','DTAFIN','CODEMP','OPCVER'],
                              [FormatDateTime('dd/mm/yyyy', IncMonth(fNow()-1,-3)),
                              FormatDateTime('dd/mm/yyyy', fNow()-1),
                              VS_strCodEmp,
                              '3.5 - Tigre'],
                              nil,
                              nil,
                              True,
                              False);
        End;

        pFinalizaObjetos;
        pTerminate;
      end;

      if blnExpRelatorio and blnConfirma then
      begin
        intCodRel := 0;

        Try
          intCodRel := StrToInt(ParamStr(2));
        Except
          Begin
            pFinalizaObjetos;
            pTerminate;
          End;
        End;

        Try
          pSetaEmpresaLogada(ParamStr(3));
        Except
          pSetaEmpresaLogada('');
        End;

        Try
          strLoginUsuarioLogado := ParamStr(4);
          pCarregarVariaveisUsuarioLogado;
        Except
          strLoginUsuarioLogado := '';
        End;

        If fEmptyStr(fRetNomeOperador(strLoginUsuarioLogado)) Then
        Begin
          fMensagem('', 'Não foi informado o código do operador responsável pela importação.' + #13 +
                        'O Parametro deve seguir o padrão "EXPORTACAO_RELATORIO 000 999", onde 999 é o Código do Operador!', ['&OK']);
          pFinalizaObjetos;
          pTerminate;
          Exit;
        End;

        strEmpAcessoUsuarioLogado := fRetEmpAcessoUsuario(strLoginUsuarioLogado);
        strEmpConsVendFatur := fRetEmpConsVendFatur(strLoginUsuarioLogado);

        If Assigned(prcExecutaRelatorio) Then
        begin
          VS_ExibirMensagemAoUsuario := False;
          VS_ExibirMensagemDeErro    := False;
          VS_ExibirMensagemAguarde   := False;

          pCarregarLibTintaMaquina;

          If (ParamCount = 4) Then
            prcExecutaRelatorio(0, intCodRel, [],
                                [],
                                [],
                                nil,
                                nil,
                                True,
                                False)
          Else If (ParamCount > 4) Then
          Begin
            sltAuxParamRel := TStringList.Create;

            SetLength(arrParametros, 0);
            SetLength(arrValores, 0);

            For intContador := 5 to ParamCount do
            Begin
              sltAuxParamRel.Text := AnsiReplaceStr(ParamStr(intContador), '=', #13#10);

              SetLength(arrParametros, Length(arrParametros) + 1);
              arrParametros[Length(arrParametros)-1] := AnsiReplaceStr(sltAuxParamRel[0], '"', '');

              SetLength(arrValores, Length(arrValores) + 1);

              If sltAuxParamRel.Count = 2 then
                arrValores[Length(arrValores)-1] := AnsiReplaceStr(sltAuxParamRel[1], '"', '');

            End;

            FreeAndNil(sltAuxParamRel);

            prcExecutaRelatorio(0, intCodRel, [],
                                arrParametros,
                                arrValores,
                                nil,
                                nil,
                                True,
                                False)

          End;
        End;

        pFinalizaObjetos;
        pTerminate;
      end;

      If blnExpAcacia And blnConfirma Then
      Begin
        If (fCfgSis('MODACA') = '1') Then
        Begin
          Try
            pCriarFormularios(TfrmTxtACACIAServer, frmTxtACACIAServer);
            frmTxtACACIAServer.blnGeracaoAut := blnExpAcacia;
            frmTxtACACIAServer.ShowModal;
          Except

          End;
          pFreeAndNil(frmTxtACACIAServer);
        End
        Else
        Begin
          Try
            pCriarFormularios(TfrmTxtACACIAServerExpAndroid, frmTxtACACIAServerExpAndroid);
            frmTxtACACIAServerExpAndroid.blnGeracaoAut := blnExpAcacia;
            frmTxtACACIAServerExpAndroid.ShowModal;
          Except

          End;
          FreeAndNil(frmTxtACACIAServerExpAndroid);
        End;

        pFreeAndNil(frmTxtACACIAServer);

        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      If blnImpAcacia And blnConfirma Then
      Begin
        If (fCfgSis('MODACA') = '1') Then
        Begin
          Try
            pCriarFormularios(TfrmTxtACACIAServerImp, frmTxtACACIAServerImp);
            frmTxtACACIAServerImp.blnGeracaoAut := blnImpAcacia;
            frmTxtACACIAServerImp.ShowModal;
          Except

          End;
          FreeAndNil(frmTxtACACIAServerImp);
        End
        Else
        Begin
          Try
            pCriarFormularios(TfrmTxtACACIAServerImpAndroid, frmTxtACACIAServerImpAndroid);
            frmTxtACACIAServerImpAndroid.blnGeracaoAut := blnImpAcacia;
            frmTxtACACIAServerImpAndroid.ShowModal;
          Except

          End;
          FreeAndNil(frmTxtACACIAServerImpAndroid);
        End;

        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      If blnConAjuMot And blnConfirma Then
      Begin
        pOpeProd(BalancoEstoqueDigMotorola);
        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      If blnConAjuCom And blnConfirma Then
      Begin
        pOpeProd(BalancoEstoqueDigCompex260);
        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      If blnMotorConf And blnConfirma Then
      Begin
        if (fCfgSis('CONFME') = '1') Or
           (fCfgSis('CONFME') = '3') then
          pCriarForm(TfrmEntConferPreNotaMotorola)
        else
          pCriarForm(TfrmEntConferenciaMotorola);

        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      If blnCompeConf And blnConfirma Then
      Begin
        pCriarForm(TfrmEntConferenciaCompexPM260);
        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      If blnImprimeEtiquetaGondolaComPreco And blnConfirma Then
      Begin
        pGeraEtiquetaGondolaComPreco;
      End;

      If blnImprimePedido And blnConfirma Then
      Begin
        VS_ExibirMensagemAoUsuario := False;
        VS_ExibirMensagemDeErro    := False;
        VS_ExibirMensagemAguarde   := False;

        If ParamCount > 1 Then
          pImprimePedido(ParamStr(2), False);

        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      If blnImprimeSeparacao And blnConfirma Then
      Begin
        VS_ExibirMensagemAoUsuario := False;
        VS_ExibirMensagemDeErro    := False;
        VS_ExibirMensagemAguarde   := False;

        If ParamCount > 1 Then
          pImprimePedido(ParamStr(2), True);

        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      If blnImprimeSeparacaoFina And blnConfirma Then
      Begin
        VS_ExibirMensagemAoUsuario := False;
        VS_ExibirMensagemDeErro    := False;
        VS_ExibirMensagemAguarde   := False;

        strLoginUsuarioLogado := ParamStr(3);
        pCarregarVariaveisUsuarioLogado;

        if fCfgSis('TIPEXP', varInteger) = 5 then
          objSeparacaoFina := TSeparacaoFina.Create(tdsRomaneio, VS_strCodEmp)
        else
          objSeparacaoFina := TSeparacaoFina.Create(tdsPedido, VS_strCodEmp);

        try
          objSeparacaoFina.strCodigoBarrasSeparacao := ParamStr(4);
          objSeparacaoFina.strAutoincremLocalSeparacao := ParamStr(5);
          objSeparacaoFina.fImprimeSeparacaoRomaneio;
        finally
          FreeAndNil(objSeparacaoFina);
        end;

        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      If (blnSpedFiscal Or blnSpedPisCofins) And blnConfirma Then
      Begin
        Try
          Try
            If blnSpedFiscal Then
              TExecutarSPED.Executar(SPED_FISCAL_CODREL);
            If blnSpedPisCofins Then
              TExecutarSPED.Executar(SPED_PIS_COFINS_CODREL);
          Except
            On E: Exception Do
              pMensagensErro(E.Message, '');
          End;
        Finally
          pFinalizaObjetos;
          pTerminate;
        End;
        Exit;
      End;

      If blnConsultaPrecoTintas And blnConfirma Then
      Begin
        strLoginUsuarioLogado := LOG_ADM;
        pCarregarVariaveisUsuarioLogado;

        Try
          If Not TUtilMonitor.fLockMonitor(MonitorConsultaPrecoTintaId, VS_strLockMonitorConsultaPrecoTinta) Then
            Exit;

          Try
            pCarregarLibTintaMaquina;
            Try
              TConsultaPrecoTintaMonitor.pIniciarObjetos;
              Try
                TMonitor.New()
                  .IdMonitor(MonitorConsultaPrecoTintaId)
                  .TimeLimit(StrToIntDef(GetParamValue('TL='), MonitorConsultaPrecoTintaTimeLimit))
                  .LockMonitor(VS_strLockMonitorConsultaPrecoTinta)
                  .ProcedureExec(TConsultaPrecoTintaMonitor.New())
                  .WaitInterval(1000)
                  .pStart();
              Finally
                TConsultaPrecoTintaMonitor.pFinalizarObjetos;
              End;
            Finally
              TUtilMonitor.fRemoveLockMonitor(MonitorConsultaPrecoTintaId);
            End;
          Except
            On E: Exception Do
              pMensagensErro(E.Message, '');
          End;

        Finally
          TLogAut.New().pLogout();
          pFinalizaObjetos;
          pTerminate;
        End;

        Exit;
      End;

      If blnDefinirLotesWMS And blnConfirma Then
      Begin
        VS_ExibirMensagemAoUsuario := False;
        VS_ExibirMensagemDeErro    := False;
        VS_ExibirMensagemAguarde   := False;

        VS_OnMensagemAoUsuario  := TDefinirLotesWMS.AddLog;
        VS_OnMensagemDeErro     := TDefinirLotesWMS.AddLog;
        VS_OnMensagemAguarde    := TDefinirLotesWMS.AddLog;

        strLoginUsuarioLogado := LOG_ADM;
        pCarregarVariaveisUsuarioLogado;

        Try
          If Not TUtilMonitor.fLockMonitor(spIdMonitorLotWMS, VS_strLockMonitorLotWMS) Then
            Exit;

          pCarregarLibTintaMaquina;

          Try
            Try
              TMonitor.New()
                .IdMonitor(spIdMonitorLotWMS)
                .TimeLimit(StrToIntDef(GetParamValue('TL='), spTimeLimitMonitorLotWMS))
                .LockMonitor(VS_strLockMonitorLotWMS)
                .ProcedureExec(TDefinirLotesWMS.New())
                .pStart();
            Finally
              TUtilMonitor.fRemoveLockMonitor(spIdMonitorLotWMS);
            End;
          Except
            On E: Exception Do
              pMensagensErro(E.Message, '');
          End;

        Finally
          pFinalizaObjetos;
          pTerminate;
        End;

        Exit;

      End;

      {$IFNDEF TESTABILIDADE_AUTCOM}
      If VS_AutoatendimentoPagueFacil And blnConfirma Then
      Begin
        strLoginUsuarioLogado := ParamStr(3);

        If strLoginUsuarioLogado.IsEmpty Then
          strLoginUsuarioLogado := LOG_ADM;

        pCarregarVariaveisUsuarioLogado;

        pCarregarLibTintaMaquina;

        Try
          pCriarFormularios(TfmxRecebimentoPedido, frmAutoatendimentoPagueFacil);

          Try
            VS_ExibirMensagemAoUsuario := False;
            VS_ExibirMensagemDeErro    := False;
            VS_ExibirMensagemAguarde   := False;

            VS_OnMensagemDeErro := frmAutoatendimentoPagueFacil.OnMensagemDeErro;
            VS_OnMensagemAguarde := frmAutoatendimentoPagueFacil.OnMensagemAguarde;
            VS_OnMensagemAoUsuario := frmAutoatendimentoPagueFacil.OnMensagemAoUsuario;

            Try
              frmAutoatendimentoPagueFacil.PagueFacil := TAutoatendimentoPagueFacilRecebimentoPedido.Create;
            Except
            {$IFDEF DEBUG}
              On E: Exception Do
                pMensagensErro(E.Message, '');
            {$ENDIF}
            End;

            frmAutoatendimentoPagueFacil.CallLogTot := pCallLogTot ;

            If fCfgSis('COMAND', varBoolean) Then
              frmAutoatendimentoPagueFacil.lblCodigoBarras.Text := 'Para efetuar o pagamento, digite o número da comanda do pedido no local indicado'
            Else
              frmAutoatendimentoPagueFacil.lblCodigoBarras.Text := 'Para efetuar o pagamento, posicione o código de barras do pedido no local indicado';

            frmAutoatendimentoPagueFacil.ShowModal;
          Finally
            pFreeAndNil(frmAutoatendimentoPagueFacil);

            VS_ExibirMensagemDeErro    := True;
            VS_ExibirMensagemAguarde   := True;

            VS_OnMensagemDeErro := nil;
            VS_OnMensagemAguarde := nil;
            VS_OnMensagemAoUsuario := nil;
          End;
        Finally
          pFinalizaObjetos;
          pTerminate;
        End;

        Exit;
      End;
      {$ENDIF}

      {$IFNDEF TESTABILIDADE_AUTCOM}
      If (VS_AutoatendimentoConsultaPreco Or VS_AutoatendimentoBuscaFacil) And blnConfirma Then
      Begin
        strLoginUsuarioLogado := ParamStr(3);

        If strLoginUsuarioLogado.IsEmpty Then
          strLoginUsuarioLogado := LOG_ADM;

        pCarregarVariaveisUsuarioLogado;

        Try
          If Not fUtilizaAutoAtendimento Then
          Begin
            pMensagemOk('É necessário configurar o sistema para "Utilizar autoatendimento consulta preço" = "Sim" !');
            Exit;
          End;

          pCriarFormularios(TfmxConsultaPreco, frmAutoatendimentoConsultaPreco);

          Try
            VS_ExibirMensagemAoUsuario := False;
            VS_ExibirMensagemDeErro    := False;
            VS_ExibirMensagemAguarde   := False;

            VS_OnMensagemDeErro := frmAutoatendimentoConsultaPreco.OnMensagemDeErro;
            VS_OnMensagemAguarde := frmAutoatendimentoConsultaPreco.OnMensagemAguarde;
            VS_OnMensagemAoUsuario := frmAutoatendimentoConsultaPreco.OnMensagemAoUsuario;

            frmAutoatendimentoConsultaPreco.MostrarPrecos := VS_AutoatendimentoConsultaPreco;
            frmAutoatendimentoConsultaPreco.ConsultaPreco := TAutoatendimentoConsultaPreco.Create;
            frmAutoatendimentoConsultaPreco.ShowModal;
          Finally
            pFreeAndNil(frmAutoatendimentoConsultaPreco);

            VS_ExibirMensagemDeErro    := True;
            VS_ExibirMensagemAguarde   := True;

            VS_OnMensagemDeErro := nil;
            VS_OnMensagemAguarde := nil;
            VS_OnMensagemAoUsuario := nil;
          End;
        Finally
          pFinalizaObjetos;
          pTerminate;
        End;

        Exit;
      End;
      {$ENDIF}

      If blnFaturamentoAutomatico And blnConfirma Then
      Begin
        VS_ExibirMensagemAoUsuario := False;
        VS_ExibirMensagemDeErro    := False;
        VS_ExibirMensagemAguarde   := False;

        VS_OnMensagemAoUsuario  := TFaturamentoAutomatico.AddLog;
        VS_OnMensagemDeErro     := TFaturamentoAutomatico.AddLog;
        VS_OnMensagemAguarde    := TFaturamentoAutomatico.AddLog;

        strLoginUsuarioLogado := ParamStr(3);

        If strLoginUsuarioLogado.IsEmpty Then
          strLoginUsuarioLogado := LOG_ADM;

        pCarregarVariaveisUsuarioLogado;

        Try
          Try
            LIdMonitor := Format(IdMonitorFaturamentoAutomatico, [VS_strCodEmp, strLoginUsuarioLogado]);
            If Not TUtilMonitor.fLockMonitor(LIdMonitor, VS_strLockMonitorFaturamentoAutomatico) Then
              Exit;
            Try
              pCarregarLibTintaMaquina;
              TMonitor.New()
                .IdMonitor(LIdMonitor)
                .TimeLimit(StrToIntDef(GetParamValue('TL='), TimeLimitMonitorFaturamentoAutomatico))
                .LockMonitor(VS_strLockMonitorFaturamentoAutomatico)
                .ProcedureExec(TFaturamentoAutomatico.New())
                .WaitInterval(StrToIntDef(GetParamValue('-T'), 10000))
                .pStart();
            Finally
              TUtilMonitor.fRemoveLockMonitor(LIdMonitor);
            End;
          Except
            On E: Exception Do
              pMensagensErro(E.Message, '');
          End;
        Finally
          pFinalizaObjetos;
          pTerminate;
        End;
        Exit;
      End;

      If fExecutouCanceladorAutomatico(blnConfirma) Then
        Exit;

      If blnNotificacoesMonitor And blnConfirma Then
      Begin
        VS_ExibirMensagemAoUsuario := False;
        VS_ExibirMensagemDeErro    := False;
        VS_ExibirMensagemAguarde   := False;

        strLoginUsuarioLogado := ParamStr(3);

        If strLoginUsuarioLogado.IsEmpty Then
          strLoginUsuarioLogado := LOG_ADM;

        pCarregarVariaveisUsuarioLogado;

        Try
          Try
            LIdMonitor := Format(IdMonitorEnviarNotificacoes, [VS_strCodEmp]);
            If Not TUtilMonitor.fLockMonitor(LIdMonitor, VS_strLockMonitorEnviarNotificacoes) Then
              Exit;
            Try
              pCarregarLibTintaMaquina;
              TMonitor.New()
                .IdMonitor(LIdMonitor)
                .TimeLimit(StrToIntDef(GetParamValue('TL='), TimeLimitMonitorEnviarNotificacoes))
                .LockMonitor(VS_strLockMonitorEnviarNotificacoes)
                .ProcedureExec(TNotificacoesMonitor.Create())
                .WaitInterval(StrToIntDef(GetParamValue('-T'), 3000))
                .pStart();
            Finally
              TUtilMonitor.fRemoveLockMonitor(LIdMonitor);
            End;
          Except
            On E: Exception Do
              pMensagensErro(E.Message, '');
          End;
        Finally
          pFinalizaObjetos;
          pTerminate;
        End;
        Exit;
      End;

      If blnDesmembramentoPedidoPIX And blnConfirma Then
      Begin
        VS_ExibirMensagemAoUsuario := False;
        VS_ExibirMensagemDeErro    := False;
        VS_ExibirMensagemAguarde   := False;

        VS_OnMensagemAoUsuario  := TDesmembramentoPedidoRecebidoPIX.AddLog;
        VS_OnMensagemDeErro     := TDesmembramentoPedidoRecebidoPIX.AddLog;
        VS_OnMensagemAguarde    := TDesmembramentoPedidoRecebidoPIX.AddLog;

        strLoginUsuarioLogado := ParamStr(3);

        If strLoginUsuarioLogado.IsEmpty Then
          strLoginUsuarioLogado := LOG_ADM;

        pCarregarVariaveisUsuarioLogado;

        Try
          Try
            LIdMonitor := Format(IdMonitorDesmembramentoPedidoRecebidoPIX, [VS_strCodEmp]);
            If Not TUtilMonitor.fLockMonitor(LIdMonitor, VS_strLockMonitorDesmembramentoPedidoRecebidoPIX) Then
              Exit;
            Try
              pCarregarLibTintaMaquina;
              TMonitor.New()
                .IdMonitor(LIdMonitor)
                .TimeLimit(StrToIntDef(GetParamValue('TL='), TimeLimitMonitorDesmembramentoPedidoRecebidoPIX))
                .LockMonitor(VS_strLockMonitorDesmembramentoPedidoRecebidoPIX)
                .ProcedureExec(TDesmembramentoPedidoRecebidoPIX.New())
                .WaitInterval(StrToIntDef(GetParamValue('-T'), 3000))
                .pStart();
            Finally
              TUtilMonitor.fRemoveLockMonitor(LIdMonitor);
            End;
          Except
            On E: Exception Do
              pMensagensErro(E.Message, '');
          End;
        Finally
          pFinalizaObjetos;
          pTerminate;
        End;
        Exit;
      End;

      If blnGatilhosInformacao And blnConfirma Then
      Begin
        VS_ExibirMensagemAoUsuario := False;
        VS_ExibirMensagemDeErro    := False;
        VS_ExibirMensagemAguarde   := False;

        VS_OnMensagemAoUsuario  := TGatilhosInformacaoMonitor.AddLog;
        VS_OnMensagemDeErro     := TGatilhosInformacaoMonitor.AddLog;
        VS_OnMensagemAguarde    := TGatilhosInformacaoMonitor.AddLog;

        strLoginUsuarioLogado := ParamStr(3);

        If strLoginUsuarioLogado.IsEmpty Then
          strLoginUsuarioLogado := LOG_ADM;

        pCarregarVariaveisUsuarioLogado;

        Try
          Try
            If HasParam('GATINF=') Then
            Begin
              pCarregarLibTintaMaquina;
              TGatilhosInformacaoMonitor.New(GetParamValue('GATINF=')).pExecute;
            End
            Else
            Begin
              LIdMonitor := Format(IdMonitorGatilhosInformacao, [VS_strCodEmp]);
              If Not TUtilMonitor.fLockMonitor(LIdMonitor, VS_strLockMonitorGatilhosInformacao) Then
                Exit;
              Try
                pCarregarLibTintaMaquina;
                TMonitor.New()
                  .IdMonitor(LIdMonitor)
                  .TimeLimit(StrToIntDef(GetParamValue('TL='), TimeLimitMonitorGatilhosInformacao))
                  .LockMonitor(VS_strLockMonitorGatilhosInformacao)
                  .ProcedureExec(TGatilhosInformacaoMonitor.New())
                  .pStart();
              Finally
                TUtilMonitor.fRemoveLockMonitor(LIdMonitor);
              End;
            End;
          Except
            On E: Exception Do
              pMensagensErro(E.Message, '');
          End;
        Finally
          pFinalizaObjetos;
          pTerminate;
        End;
        Exit;
      End;

      If blnGatilhosImediatos And blnConfirma Then
      Begin
        VS_ExibirMensagemAoUsuario := False;
        VS_ExibirMensagemDeErro    := False;
        VS_ExibirMensagemAguarde   := False;

        strLoginUsuarioLogado := ParamStr(4);

        If strLoginUsuarioLogado.IsEmpty Then
          strLoginUsuarioLogado := LOG_ADM;

        pCarregarVariaveisUsuarioLogado;

        Try
          Try
            LIdMonitor := Format(IIF(ParamStr(3) = 'COMPLEMENTAR', IdMonitorGatilhosImediatosComplementar, IdMonitorGatilhosImediatosOperacional), [VS_strCodEmp]);
            if ParamStr(3) = 'COMPLEMENTAR' then
            begin
              If Not TUtilMonitor.fLockMonitor(LIdMonitor, VS_strLockMonitorGatilhosImediatosComplementar) Then
                Exit;
            end
            else
            begin
              If Not TUtilMonitor.fLockMonitor(LIdMonitor, VS_strLockMonitorGatilhosImediatosOperacional) Then
                Exit;
            end;

            Try
              pCarregarLibTintaMaquina;
              TMonitor.New()
                .IdMonitor(LIdMonitor)
                .TimeLimit(StrToIntDef(GetParamValue('TL='), TimeLimitMonitorGatilhosImediatos))
                .LockMonitor(IIF(ParamStr(3) = 'COMPLEMENTAR', VS_strLockMonitorGatilhosImediatosComplementar, VS_strLockMonitorGatilhosImediatosOperacional))
                .ProcedureExec(TDllGatime.fNew.fMonitorarGatilhosImediatos(ParamStr(3)))
                .pStart();
            Finally
              TUtilMonitor.fRemoveLockMonitor(LIdMonitor);
            End;
          Except
            On E: Exception Do
              pMensagensErro(E.Message, '');
          End;
        Finally
          pFinalizaObjetos;
          pTerminate;
        End;
        Exit;
      End;

      If blnExpHenkel And blnConfirma Then
      Begin

        If Assigned(prcExecutaRelatorio) Then
        begin
          VS_ExibirMensagemAoUsuario := False;
          VS_ExibirMensagemDeErro    := False;
          VS_ExibirMensagemAguarde   := False;

          pCarregarLibTintaMaquina;

          prcExecutaRelatorio(252, 8588, [8589,8590,8591,8592,8593,8594,8595,8596,8597,8598,8599,8600],
                              ['DTAINI','DTAFIN','CODFOR','CODEMP'],
                              [FormatDateTime('dd/mm/yyyy', IncMonth(fNow(),-3)),
                              FormatDateTime('dd/mm/yyyy', fNow()),
                              fCfgSis('CFORHE'),
                              VS_strCodEmp],
                              nil,
                              nil,
                              True,
                              False);
        End;

        Exit;

      End;

      If blnAutoTransfEmpCar Then
      Begin
        If fEmptyStr(ParamStr(2)) Then
          Exit;
        If fEmptyStr(ParamStr(3)) Then
          Exit;

        pVerificaTransfAutoEmpCar(ParamStr(2),  //usuário logado
                                  ParamStr(3)); //empresa solicitante

        pFinalizaObjetos;
        pTerminate;
        Exit;
      End;

      If blnUsuarioLogadoUtilizaModoClassico Then
      Begin
        mnuDashboard.Tag   := 63000;
        mnuPainelEntregas.Tag := 67000;
      End
      Else
      Begin
        mnuDashboard.Tag   := 0;
        mnuPainelEntregas.Tag := 0;
      End;

      If blnImprimeEtiquetaMontagemCaixa And blnConfirma Then
      Begin
        Try
          pGeraEtiquetaMontagemCaixa;
        Finally
          pFinalizaObjetos;
          pTerminate;
        End;
        Exit;
      End;

      If blnImprimeEtiquetaVolume And blnConfirma Then
      Begin
        Try
          pGeraEtiquetaVolume;
        Finally
          pFinalizaObjetos;
          pTerminate;
        End;
        Exit;
      End;

      If blnImprimeEtiquetaDespacho And blnConfirma Then
      Begin
        Try
          pGeraEtiquetaDespacho;
        Finally
          pFinalizaObjetos;
          pTerminate;
        End;
        Exit;
      End;

      If blnImprimeEtiquetaBoxPedido And blnConfirma Then
      Begin
        Try
          pGeraEtiquetaBoxPedido;
        Finally
          pFinalizaObjetos;
          pTerminate;
        End;
        Exit;
      End;

      If (Not blnConfirma) Then
        Exit;

      fraPesquisarMenu.pLimparPesquisa;
    End;

    blnIgnorarPopUpMsgLib := False;
    VS_IgnoraTravaAjustePrecoAutorizado := False;

    procChamaAtualizaProdReqOrdemServico := pAtualizaProdReqOrdemServico;
    procChamaAtualizaProdReqSemOS := pAtualizaProdReqSemOS;
    pProcAcompEntMostraDebCtrChq2 := pAcompanhamentoPedidosMostraDebCtrChq2;
  Finally
    If VS_AutcomIniciadoModoRobo Then
      KillProcess(GetCurrentProcessId);

    blnTerminouFormShow := True;
  End;

end;

procedure TfrmPrincipal.mnuCadFaixaFaturamentoDeptoVendProdClick(Sender: TObject);
begin
  TfrmCadComFaiFatDepVenPro.pCadastrarFaixaComissao();
end;

function TfrmPrincipal.Favoritos: IFavoritosAutcom;
begin
  Result := TFavoritosAutcom.New(fraPesquisarMenu.popFavoritos);
end;

procedure TfrmPrincipal.mnuEstornoNotaFiscalDevolucaoClick(Sender: TObject);
begin
  pCriarForm(TfrmEstornoNotaFiscal);
end;

procedure TfrmPrincipal.mnuFechamentoFinanceiroClick(Sender: TObject);
begin
  pCriarForm(TfrmUltimosFechamentosFinanceiro, frmUltimosFechamentosFinanceiro);
end;

function TfrmPrincipal.fExecutarSplash: Boolean;
Var
  objSplash: ISplash;
  frmSplash: TfrmSplash;
  blnExibirTelaAguarde: Boolean;
begin
  {$IFDEF TESTABILIDADE_AUTCOM}
  blnExibirTelaAguarde := False;
  {$Else}
  blnExibirTelaAguarde := True;
  {$ENDIF}

  untThreadUtils.TSafeThread.EnableLogging := fCfgSis('SFTLOG', VarBoolean);
  untThreadUtils.TSafeThread.MaxThreads := fCfgSis('SFTMAX', VarInteger);
  untThreadUtils.TSafeThread.PrcAfterConnect := ThreadSafeAfterConnect;

  If Not blnUsuarioLogadoUtilizaModoClassico Then
    blnExibirTelaAguarde := False;

  GeraMenuLibCartoes;

  objSplash := TSplash.Create(blnGeracaoAut,
                              blnGerImpPdv,
                              blnExibirTelaAguarde,
                              pIniciaPreencheTagDir,
                              pCarregarRelatorios,
                              pCarregarLibFuncoes,
                              pCarregarLibTintaMaquina,
                              pCarregarMenusAcesso,
                              pOrdenarMenus);

  {$IFDEF TESTABILIDADE_AUTCOM}
  //Sempre usa modo clássico
  {$Else}
  If Not blnUsuarioLogadoUtilizaModoClassico Then
    Exit(Login.View.FMXSplash.ExecutarSplash(objSplash, Self.RunningInTSPlus));
  {$ENDIF}

  Try
    pCriarFormularios(TfrmSplash, frmSplash);
    frmSplash.objSplash := objSplash;
    frmSplash.showModal;
    Result := objSplash.SplashRealizado;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fExecutarSplash]');
    End;
  End;

  If Assigned(frmSplash) Then
  Begin
    objSplash.RemoveView(frmSplash);
    frmSplash.objSplash := nil;
  End;

  pFreeAndNil(frmSplash);
end;

function TfrmPrincipal.fExibirAlertaEntregaComDivergencia: Boolean;
begin
  Result := False;

  If Not fCfgSis('MATDIS', varBoolean) Then
    Exit;

  If Not fCfgSis('ENENDI', varBoolean) Then
    Exit;

  If Not fVerificaAcessoSistema('ENENDI', strLoginUsuarioLogado) Then
    Exit;

  Result := True;
end;

function TfrmPrincipal.fExisteDireitoAcesso(ADirAce: String): Boolean;
begin
  Result := Not GetDescricaoDirAce(ADirAce).IsEmpty;
end;

function TfrmPrincipal.fExitemCompromissos: Boolean;
begin
  If (Not fPodeExecutarFuncaoDoTimer) Then
  begin
    Result := False;
    tmrCompromissos.Enabled := True;
    Exit;
  end;

  Result := fExistemCompromissosAgendados;
end;

function TfrmPrincipal.fHabilitarAtalhoWMS: Boolean;
begin
  Result := False;

  If Not (fCfgSis('UTIWMS', varBoolean)) Then
    Exit;

  If (popWMS.Items.Count <= 0) Then
    Exit;

  Result := True;
End;

function TfrmPrincipal.fMontaMenu: Integer;
Const
  OPCOS     : Array[0..3] Of String = ('Logs de Erros','Logs de Deleção','Senha de Liberação Preço','Senha de Liberação Geral');
  FORMS     : Array[0..3] Of String = ('frmLogErros',  'frmLogDelecoes', 'frmFatLiberacaoCliBlo','frmFatLiberacaoCliBlo2');
  Var
    intCount  : integer;
    arrResult : Array Of Integer;
Begin
  Result := 0;
  SetLength(arrMenu,0);
  SetLength(arrResult,0);

  For intCount := Low(OPCOS) To High(OPCOS) Do
    If fVerificaAcessoSistema(FORMS[intCount]) Then
    Begin
      SetLength(arrMenu,Succ(Length(arrMenu)));
      arrMenu[High(arrMenu)] := OPCOS[intCount];

      SetLength(arrResult,Succ(Length(arrResult)));
      arrResult[High(arrResult)] := Succ(intCount);
    End;

  If Length(arrMenu) > 0 Then
  Begin
    If Length(arrMenu) = 1 Then
    Begin
      Result :=  arrResult[0];
    End Else
    Begin
      intCount := fGetMenu('Logs', arrMenu, 0, True);
      If intCount > 0 Then
        Result :=  arrResult[Pred(intCount)];
    End;
  End;
End;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Quando fecha uma tela rapidamente com esc esta ocorrendo acessviolation
  // pois entra no formkeydown antes mesmo de liberar os objetos do semaforo
  If TSemaforo.intSemaforo = 0 Then
    Exit;

  fraPesquisarMenu.OnFormKeyDown(Sender, Key, Shift);

  If (Key = VK_Escape) And (Self.Showing) Then
    Close;

  If (Shift = ([ssCtrl])) And (Key = VK_F1) Then
    pLogsCTRLF1;

  If (Shift = ([ssCtrl, ssAlt, ssShift])) And (Key = VK_F12) Then
    pExportarMenuSistema();
end;

procedure TfrmPrincipal.mnuConvertReformaClick(Sender: TObject);
begin
  {*****************************************************}
  {* REFTRI-02: A CONVERSAO ALTERA CUSTO E PRECO DE    *}
  {* TODOS OS PRODUTOS: EXIGE O DIREITO DO CADASTRO    *}
  {*****************************************************}
  If Not fVerificaAcessoSistema('frmCadProdutos') Then
  Begin
    fMensagem('Ativar Preços Reforma Tributária',
              'O usuário logado não tem direito de acesso ao Cadastro de Produtos.' + #13 +
              'A ativação dos preços da Reforma Tributária altera o custo e o preço de todos os produtos e exige esse direito.',
              ['&Ok']);
    Exit;
  End;

  If fPreMat Then
  Begin
    fMensagem('Ativar Preços Reforma Tributária', 'Operação permitida apenas pela Loja Matriz!' + #13 +
              'A empresa logada recebe os preços da matriz.', ['&Ok']);
    Exit;
  End;

  If Not fEmpresaNesteServidor(VS_strCodEmp) Then
  Begin
    pMensagemOK('A empresa logada não faz parte desse servidor - Rotina não pode ser executada!');
    Exit;
  End;

  pReformaAbrirConvert;
end;

procedure TfrmPrincipal.mnuProxCodigosClick(Sender: TObject);
  Var
    strSenha: String;
    frmCadProxCodigos : TfrmCadProxCodigos;
begin
  If ffrmSenha(strSenha) Then
  Begin
    If strSenha = SEN_PROCOD Then
    Begin
      Try
        pCriarFormularios(TfrmCadProxCodigos, frmCadProxCodigos);
        frmCadProxCodigos.showModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[mnuProxCodigosClick]');
        End;
      End;

      pFreeAndNil(frmCadProxCodigos);

    End
    Else
    Begin
      fMensagem('', 'Senha Incorreta!', ['&Ok']);
    End;

  End;
end;

procedure TfrmPrincipal.mnuQualificaodeClientesClick(Sender: TObject);
var
  frmCadQualificacaoClientes: TfrmCadQualificacaoClientes;
begin
  Try
    pCriarFormularios(TfrmCadQualificacaoClientes, frmCadQualificacaoClientes);
    frmCadQualificacaoClientes.ShowModal;
  Finally
    FreeAndNil(frmCadQualificacaoClientes);
  End;
end;

procedure TfrmPrincipal.mnuCadCidadesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCidades);
end;

procedure TfrmPrincipal.mnuCadEmpresasClick(Sender: TObject);
begin
  If (fCfgSis('EMPGER', varBoolean)) Then
    pCriarForm(TfrmCadEmpresas)
  Else
    fMensagem('', 'Cadastro permitido apenas para a Loja Matriz!', ['&Ok']);
end;

procedure TfrmPrincipal.mnuCadEquipamentosIndClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEquipamentosInd);
end;

procedure TfrmPrincipal.mnuCadEquLocacaoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEquLocacao);
end;

procedure TfrmPrincipal.mnuCadOcorrenciaEntregaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadOcorrenciaEntrega);
end;

procedure TfrmPrincipal.mnuCadOcorrenciasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadOcorrencias);
end;

procedure TfrmPrincipal.mnuCadOperadoresClick(Sender: TObject);
begin
  pCriarForm(TfrmCadOperadores);
end;

procedure TfrmPrincipal.mnuCadAtividadesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAtividades);
end;

procedure TfrmPrincipal.mnuCadForAtuCRMClick(Sender: TObject);
begin
  pCriarForm(TfrmCadForAtuCRM);
end;

procedure TfrmPrincipal.mnuCadFornecedoresClick(Sender: TObject);
begin
  TLiberacaoFactory.pSetLiberacao( TLiberacao.Create );
  pCriarFormularios(TfrmCadFornecedores, frmCadFornecedores);
  try
    frmCadFornecedores.fMskCon := fMskCon;
    frmCadFornecedores.fSemMascaraPlaNco := fSemMascaraPlaNco;
    frmCadFornecedores.fPesqPlanoContabil := fPesqPlanoContabil;
    frmCadFornecedores.pPlanoDeContasPorEmpresa := pPlanoDeContasPorEmpresa;
    frmCadFornecedores.pGravarPlanoContasAutomatico := pGravarPlanoContasAutomatico;
    frmCadFornecedores.pGravarPlanoContasAutomaticoParaCadaEmpresa := pGravarPlanoContasAutomaticoParaCadaEmpresa;
    frmCadFornecedores.fCadastroRapidoCliente := TfrmCadClientes.fCadastroRapidoCliente;
    frmCadFornecedores.fCadastroRapidoTransportadora := TfrmCadTransportadoras.fCadastroRapidoTransportadora;
    frmCadFornecedores.fCampoTabelaPlanco := fCampoTabelaPlanco;
    frmCadFornecedores.fVerificarPlanoDeContasPorEmpresa := fVerificarPlanoDeContasPorEmpresa;
    frmCadFornecedores.fCriaEstruturaCdsNCO := fCriaEstruturaCdsNCO ;
    frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := pCarregaPlanoDeContasPorEmpresa ;
    frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := pSalvaPlanoDeContasPorEmpresa;
    frmCadFornecedores.ShowModal;
  finally
    frmCadFornecedores.fMskCon := Nil;
    frmCadFornecedores.fSemMascaraPlaNco := Nil;
    frmCadFornecedores.fPesqPlanoContabil := Nil;
    frmCadFornecedores.pPlanoDeContasPorEmpresa := Nil;
    frmCadFornecedores.pGravarPlanoContasAutomatico := Nil;
    frmCadFornecedores.pGravarPlanoContasAutomaticoParaCadaEmpresa := Nil;
    frmCadFornecedores.fCadastroRapidoCliente := Nil;
    frmCadFornecedores.fCadastroRapidoTransportadora := Nil;
    frmCadFornecedores.fCampoTabelaPlanco := Nil;
    frmCadFornecedores.fVerificarPlanoDeContasPorEmpresa := Nil;
    frmCadFornecedores.fCriaEstruturaCdsNCO := Nil ;
    frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := Nil ;
    frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := Nil ;
    pFreeAndNil(frmCadFornecedores);
  end;
end;

procedure TfrmPrincipal.mnuCadGruposClick(Sender: TObject);
begin
  pCriarForm(TfrmCadGrupos);
end;

procedure TfrmPrincipal.mnuCadGruposUnidadeClick(Sender: TObject);
begin
  pCriarForm(TfrmCadGruposUnidade);
end;

procedure TfrmPrincipal.mnuCadHobbyClick(Sender: TObject);
begin
  pCriarForm(TfrmCadHobbys);
end;

procedure TfrmPrincipal.mnuCadCentroCustoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCentroCusto);
end;

procedure TfrmPrincipal.mnuCadCentroCustoImobilizadoClick(Sender: TObject);
var
  frmCadCentroCustoImobilizado: TfrmCadCentroCustoImobilizado;
begin
  pCriarFormularios(TfrmCadCentroCustoImobilizado, frmCadCentroCustoImobilizado);
  Try
    frmCadCentroCustoImobilizado.ShowModal;
  Finally
    pFreeAndNil(frmCadCentroCustoImobilizado);
  End;
end;

procedure TfrmPrincipal.mnuCadCfgTerminalTefClick(Sender: TObject);
var
  frmCadCfgTerminalTef : TfrmCadCfgTerminalTef;
begin
  pCriarFormularios(TfrmCadCfgTerminalTef, frmCadCfgTerminalTef);
  try
    frmCadCfgTerminalTef.ShowModal;
  Finally
    pFreeAndNil(frmCadCfgTerminalTef);
  End;
end;

procedure TfrmPrincipal.mnuCadMarcasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMarcas);
end;

procedure TfrmPrincipal.mnuCadMaterialConsumoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMaterialConsumo);
end;

procedure TfrmPrincipal.mnuCadNatReceitaPisCofClick(Sender: TObject);
begin
  pCriarForm(TfrmCadNatReceitaPisCof);
end;

procedure TfrmPrincipal.mnuCadNBSClick(Sender: TObject);
begin
  pCriarForm(TfrmCadNBS);
end;

procedure TfrmPrincipal.mnuCadNCMClick(Sender: TObject);
begin
  pCriarForm(TfrmCadNCM);
end;

procedure TfrmPrincipal.mnuCadMatrizAliquotasIcmsClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMatrizAliquotasIcms);
end;

procedure TfrmPrincipal.mnuCadMatrizAliquotasFCPClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMatrizAliquotasFCP);
end;

procedure TfrmPrincipal.mnuCadMatrizBasesDifalClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMatrizBasesDifal);
end;

procedure TfrmPrincipal.mnuCadUnidadesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadUnidades);
end;

procedure TfrmPrincipal.mnuCadTransporatadorasClick(Sender: TObject);
var
  frmCadTransportadoras: TfrmCadTransportadoras;
begin
  pCriarFormularios(TfrmCadTransportadoras, frmCadTransportadoras);
  try
    frmCadTransportadoras.fCadastroRapidoCliente := TfrmCadClientes.fCadastroRapidoCliente;
    frmCadTransportadoras.fCadastroRapidoFornecedor := TfrmCadFornecedores.fCadastroRapidoFornecedor;
    frmCadTransportadoras.ShowModal;
  finally
    frmCadTransportadoras.fCadastroRapidoCliente := Nil;
    frmCadTransportadoras.fCadastroRapidoFornecedor := Nil;
    pFreeAndNil(frmCadTransportadoras);
  end;
end;

procedure TfrmPrincipal.mnuCadIrregFiscalClick(Sender: TObject);
begin
  pCriarForm(TfrmCadIrregFiscal);
end;

procedure TfrmPrincipal.mnuCadPadraQualidadeIndClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPadraQualidade);
end;

procedure TfrmPrincipal.mnuCadParceirosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadParceiros);
end;

procedure TfrmPrincipal.mnuCadPendenciasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPendencias);
end;

procedure TfrmPrincipal.mnuCadPerfilAduaneiroClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPerfilAduaneiro, frmCadPerfilAduaneiro);
end;

procedure TfrmPrincipal.mnuCadPontosImpressaoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPontosImpressao, frmCadPontosImpressao);
end;

procedure TfrmPrincipal.mnuCadPortadoresClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPortadores);
end;

procedure TfrmPrincipal.mnuCadPorteCRMClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPorteCRM);
end;

procedure TfrmPrincipal.mnuCadPosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPos);
end;

procedure TfrmPrincipal.mnuCadBairrosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadBairros);
end;

procedure TfrmPrincipal.mnuCadBancosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadBancos);
end;

procedure TfrmPrincipal.mnuCadDiversosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadDiversos);
end;

procedure TfrmPrincipal.mnuCadSinaleiroFaturamentoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadSinaleiroFaturamento);
end;

procedure TfrmPrincipal.mnuCadSitOcoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadSitOco);
end;

procedure TfrmPrincipal.mnuCadSitProdutoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadSitProduto);
end;

procedure TfrmPrincipal.mnuCadSitTributariaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadSitTributarias);
end;

procedure TfrmPrincipal.mnuCadSubRegiaoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadSubRegiao);
end;

procedure TfrmPrincipal.mnuCadClassFiscalClick(Sender: TObject);
begin
  pCriarForm(TfrmCadClassFiscal);
end;

procedure TfrmPrincipal.mnuCadClassificacaoOnuClick(Sender: TObject);
begin
  pCriarForm(TfrmCadClassificacaoOnu);
end;

procedure TfrmPrincipal.mnuCadCtaResultadosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCtaResultados);
end;

procedure TfrmPrincipal.mnuCadCupomPromProdClick(Sender: TObject);
var
  frmCadCupomPromProd: TfrmCadCupomPromProd;
begin
  try
    try
      pCriarFormularios(TfrmCadCupomPromProd, frmCadCupomPromProd);
      frmCadCupomPromProd.ShowModal;
    except
      On E: Exception Do
        pMensagensErro(E.Message, '[]');
    end
  finally
    pFreeAndNil(frmCadCupomPromProd);
  end;
end;

procedure TfrmPrincipal.mnuCad800Click(Sender: TObject);
begin
  pCriarForm(TfrmCad800);
end;

procedure TfrmPrincipal.mnuCadAbfReformaTributariaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAbfReformaTributaria, frmCadAbfReformaTributaria);
end;

procedure TfrmPrincipal.mnuIntegracaoDominioSistemasClick(Sender: TObject);
begin
  pAbrirFormDominio(tpdIntegracaoAPI);
end;

procedure TfrmPrincipal.mnuCadAbrevFiscalClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAbreviacaoFiscal);
end;

procedure TfrmPrincipal.mnuCadAbreviacaoCOFINSClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAbreviacaoCOFINS);
end;

procedure TfrmPrincipal.mnuCadAbreviacaoIPIClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAbreviacaoIPI);
end;

procedure TfrmPrincipal.mnuCadEnquadramentoIPIClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEnquadramentoIPI);
end;

procedure TfrmPrincipal.mnuCadEpiClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEpi);
end;

procedure TfrmPrincipal.mnuCadAbreviacaoPISClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAbreviacaoPIS);
end;

procedure TfrmPrincipal.mnuCadAcessoriosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAcessorios);
end;

procedure TfrmPrincipal.mnuCadAclLocacaoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAcessorioLocacao);
end;

procedure TfrmPrincipal.mnuCadAdenFatSerClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAdenFatSer);
end;

procedure TfrmPrincipal.mnuCadAdquirenteCartaoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAdquirenteCartao);
end;

procedure TfrmPrincipal.mnuCadAdquirenteClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAdquirente);
end;

procedure TfrmPrincipal.mnuCadAjudantesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAjudantes);
end;


procedure TfrmPrincipal.mnuCadCupomDescontoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCupomDesconto, frmCadCupomDesconto);
end;

procedure TfrmPrincipal.mnuCadAliqIBPTClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAliqIBPT);
end;

procedure TfrmPrincipal.mnuRelEstatResumoCliAtiClick(Sender: TObject);
begin
  pRelatorioEstatisticas(relEstatResumoCliAti);
end;

procedure TfrmPrincipal.mnuCadAnaliseClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAnalise);
end;

procedure TfrmPrincipal.mnuCadAnaliseMovClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAnaliseMov);
end;

procedure TfrmPrincipal.mnuCadArmazemOperadoresClick(Sender: TObject);
begin
  pCriarForm(TfrmCadArmazemOperadores, frmCadArmazemOperadores);
end;

procedure TfrmPrincipal.mnuCadastrodeClassificaodeCentrodeCusto1Click(
  Sender: TObject);
begin
  pCriarForm(TfrmCadClassifCentroCusto);
end;

procedure TfrmPrincipal.mnuCadImobilizadoClick(Sender: TObject);
begin
  TMenuContabilidade.mnuCadImobilizadoClick(Sender) ;
end;

procedure TfrmPrincipal.mnuGerImobilizadoClick(Sender: TObject);
begin
  pCriarForm(TfrmGerImobilizado, frmGerImobilizado);
end;

procedure TfrmPrincipal.mnuCadImpressorasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadImpressoras);
end;

procedure TfrmPrincipal.mnuCadIdentificacaoImpressoraClick(Sender: TObject);
begin
  pCriarForm(TfrmCadIdentificacaoImpressora);
end;

procedure TfrmPrincipal.mnuCadConfRelatoriosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadConfRelatorios, frmCadConfRelatorios);
end;

procedure TfrmPrincipal.mnuCadClientesClick(Sender: TObject);
var
  LfrmCadClientes: TfrmCadClientes;
begin
  Try
    pCriarFormularios(TfrmCadClientes, LfrmCadClientes);
    LfrmCadClientes.strPermiCadCid := mnuCadCidades.Hint;
    LfrmCadClientes.ShowModal;
  Finally
    pFreeAndNil(LfrmCadClientes);
  End;
end;

procedure TfrmPrincipal.mnuCadClientesDescontoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadClientesDesconto);
end;

procedure TfrmPrincipal.mnuCadCliVenClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCliVen);
end;

procedure TfrmPrincipal.mnuCadMovBancariaClick(Sender: TObject);
begin
  Try
    pCriarFormularios(TfrmCadMovBancario, frmCadMovBancario);
    frmCadMovBancario.strTipMov := 'CB';
    frmCadMovBancario.Caption := 'Movimentação de Conta Banco';
    frmCadMovBancario.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmPrincipal.mnuCadMovBancariaClick]');
    End;
  End;
  pFreeAndNil(frmCadMovBancario);

end;

procedure TfrmPrincipal.mnuGarantiaBaixaRefugoClick(Sender: TObject);
begin
  If fEmptyStr(fCfgSis('CLAREF', varBoolean)) then
  Begin
    fMensagem('', 'A configuração "CFG_CLAREF - Classificação Fiscal para Perda de Itens Refugados na Garantia" está vazia. ' + #13 +
                  'Solicitar ao responsável para que cadastre corretamente esta configuracao.', ['&Ok']);
    Exit;
  End;

  pCriarForm(TfrmGarantiaBaixaRefugo);
end;

procedure TfrmPrincipal.mnuGarantiaGeraCreditosClick(Sender: TObject);
begin
  pCriarForm(TfrmGarantiaGeraCreditos);
end;

procedure TfrmPrincipal.mnuGarantiaReimpressaoComprovantesClick(
  Sender: TObject);
 Var
   NomeForm : TForm;
begin
  Try
    pCriarFormularios(TfrmReimpressaoDocs,NomeForm);
    TfrmReimpressaoDocs(NomeForm).pSetReimpressaoDocGarantia(TReimpressaoDocGarantia.trRecebimentoCliente);
    try
      NomeForm.ShowModal;
    finally
      pFreeAndNil(NomeForm);
    end;
  Except
    On E: Exception do
      pErro(E.Message);
  End;

end;

procedure TfrmPrincipal.mnuGarantiaRetornoColetaClick(Sender: TObject);
begin
  pCriarForm(TfrmGarantiaRetornoColeta, frmGarantiaRetornoColeta);
end;

procedure TfrmPrincipal.mnuGatilhoCtrEnviaExtratoCobrancaClick(
  Sender: TObject);
  Var
    LListaExtratos:TStringList;
begin

  Try
    If Not untTExtratoCobranca.ExiteExtratoParaSeremEnviados(LListaExtratos) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não há extratos para serem enviados!' + #13#10 +
      'Verifique a pasta: ' + untTExtratoCobranca.RetornaDiretorioAEnviar , ['&Ok']);
      Exit;
    End;

  Finally
    FreeAndNil(LListaExtratos);
  End;

  If fMensagem('AVISO', 'Confirma a inicialização do robô de envio de extrato de cobrança?',
    ['&Sim', '&Não'], 2) = 2 Then
    Exit;


  If fGetTempoDuracaoLock('MONITOR_EXTRATO_COBRANCA_ATIVADO') = 0 Then
      fLock_Unlock('MONITOR_EXTRATO_COBRANCA_ATIVADO',
                   True,
                   False,
                   False,
                   '',
                   False);

  ExecutaMonitorExtratoCobranca;

  fMensagem('ATENÇÃO!', 'Robô inicializado com sucesso, os E-mail(s) estão sendo enviados em segundo plano!', ['&Ok']);
end;

procedure TfrmPrincipal.mnuGatilhosImediatosClick(Sender: TObject);
begin
  pCriarForm(TfrmGatilhosImediatos);
end;

procedure TfrmPrincipal.mnuGatilhosInformacaoClick(Sender: TObject);
begin
  pCriarForm(TfrmGatilhosInformacaoGrid);
end;

procedure TfrmPrincipal.mnuGenrencImprClick(Sender: TObject);
begin
  If VS_SpoolImpressaoCitel Then
    pCriarForm(TfrmRelacaoSpoolImpressao)
  Else
    pCriarForm(TfrmGerencImpr);
end;

procedure TfrmPrincipal.mnuGeoSalesExportarClick(Sender: TObject);
begin
  TfrmGeoSales.pExporta;
end;

procedure TfrmPrincipal.mnuGeoSalesImportarClick(Sender: TObject);
begin
  TfrmGeoSales.pImporta;
end;

procedure TfrmPrincipal.mnuCadProdutosAltoGiroClick(Sender: TObject);
begin
  pCriarForm(TfrmCadProdutosAltoGiro);
end;

procedure TfrmPrincipal.mnuCadProdutosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadProdutos);
end;

procedure TfrmPrincipal.mnuCadProdutosCndPagClick(Sender: TObject);
begin
  pCriarForm(TfrmCadProdutosCndPag);
end;

procedure TfrmPrincipal.mnuCadProjetosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadProjetos);
end;

procedure TfrmPrincipal.mnuCadDescontoClienteProdutoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadDescontoClienteProduto);
end;

procedure TfrmPrincipal.mnuCadDespFaturamentoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadDespFaturamento);
end;

procedure TfrmPrincipal.mnuCadDespFinClick(Sender: TObject);
begin
  pCriarForm(TfrmCadDespFin, frmCadDespFin);
end;

procedure TfrmPrincipal.mnuCadEfdContriSemDadosEscriturarClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEfdContriSemDadosEscriturar);
end;

procedure TfrmPrincipal.mnuCadLivroFiscalClick(Sender: TObject);
begin
  pCriarForm(TfrmCadLivroFiscal, frmCadLivroFiscal);
end;

procedure TfrmPrincipal.mnuCadCtaReceberClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCtaReceber);
end;

procedure TfrmPrincipal.mnuReplicaodeArmazensProdutosClick(Sender: TObject);
begin
  pOpeProd(ReplicacaoLotes);
end;

procedure TfrmPrincipal.mnuReqEnvioMatVidroClick(Sender: TObject);
begin
  pCriarForm(TfrmReqEnvioMatVidro);
end;

procedure TfrmPrincipal.mnuReqMaterialConsumoClick(Sender: TObject);
  Var
    frmReqMaterialConsumo: TfrmReqMaterialConsumo;
begin
  Try
    pCriarFormularios(TfrmReqMaterialConsumo, frmReqMaterialConsumo);
    frmReqMaterialConsumo.intStatus := fMensagem('','Selecione o status das requisições:', ['Abertas', 'Encerradas', 'Todas'], 1);
    frmReqMaterialConsumo.ShowModal;
  Finally
    FreeAndNil(frmReqMaterialConsumo);
  End;
end;

procedure TfrmPrincipal.mnuRessarcImpRetidoPorSujeicaoPassivaSubstClick(
  Sender: TObject);
begin
  If (fTabelaExiste('CAT_158', True)) and
     (fTabelaExiste('CAT_158_SPED', True)) Then
  Begin
    pVerificaProCod;
    pValidaProCod('CAT_158');
    pValidaProCod('CAT_158_SPED');
    pValidaProCod('CAT_158_ENTRADA');
    pValidaProCod('CAT_158_SAIDAS');
    pCriarForm(TfrmRessarcImpRetidoPorSujeicaoPassivaSubst);
  End
  Else
    fMensagem('', 'A tabela CAT_158 ou CAT_158_SPED não existe, favor entrar em contato com o suporte!',['&OK']);
end;

procedure TfrmPrincipal.mnuRestauraDuplicataMercantilClick(Sender: TObject);
begin
  pCriarForm(TfrmRestauraDuplicataMercantil);
end;

procedure TfrmPrincipal.mnuRestauraPrecoClick(Sender: TObject);
begin
  pCriarFormularios(TfrmRestauraPreco, frmRestauraPreco);
  Try
    frmRestauraPreco.ShowModal;
  Finally
    FreeAndNil(frmRestauraPreco);
  End
end;

procedure TfrmPrincipal.mnuRestituicaoIcmsSTClick(Sender: TObject);
begin
  if fTabelaExiste('COMUTI', True) then
  begin
    pVerificaProCod;
    pValidaProCod('COMUTI');
    pValidaProCod('COMUTI_DADOS');
    pCriarForm(TfrmRelFiscRestituicaoIcms);
  end
  else
    fMensagem('', 'A tabela COMUTI não existe, favor entrar em contato com o suporte!',['&OK']);
end;

procedure TfrmPrincipal.mnuResumoISSClick(Sender: TObject);
var
  frmResumoISS: TfrmResumoISS;
begin
  pCriarFormularios(TfrmResumoISS, frmResumoISS);
  Try
    frmResumoISS.ShowModal;
  Finally
    pFreeAndNil(frmResumoISS);
  End;
end;

procedure TfrmPrincipal.mnuBaixaCtaReceberClick(Sender: TObject);
begin
  pCriarForm(TfrmBaixaReceber);
end;

procedure TfrmPrincipal.mnuEstornoCtaReceberClick(Sender: TObject);
  Var
    frmEstornoReceber : TfrmEstornoReceber;
begin

  Try
    pCriarFormularios(TfrmEstornoReceber, frmEstornoReceber);
    frmEstornoReceber.blnResCai := False;
    frmEstornoReceber.strEstRec := '(Controle Financeiro)';
    frmEstornoReceber.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmPrincipal.mnuEstornoCtaReceberClick]');
    End;
  End;
  pFreeAndNil(frmEstornoReceber);

end;

procedure TfrmPrincipal.mnuCadChequesClick(Sender: TObject);
begin
  pCriarFormularios(TfrmCadCheques, frmCadCheques);
  frmCadCheques.strCodOpe := strLoginUsuarioLogado;
  frmCadCheques.blnChamadoDoManutencao    := True;
  frmCadCheques.btnDepositoCheque.Visible := fVerificaAcessoDepositoCheque;
  frmCadCheques.showModal;
  FreeAndNil(frmCadCheques);
end;

procedure TfrmPrincipal.mnuBaixaChequeClick(Sender: TObject);
begin
  pCriarForm(TfrmBaixaCheques);
end;

procedure TfrmPrincipal.mnuChecklistValidacaoGarantiaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadChecklistValidacaoGarantia);
end;

procedure TfrmPrincipal.mnuChequesRepasseClick(Sender: TObject);
begin
  pCriarForm(TfrmBaixaChequesRepasse);
end;

procedure TfrmPrincipal.mnuCitelDeskClick(Sender: TObject);
begin
  AbrirCitelDesk;
end;

procedure TfrmPrincipal.mnuClassificacaoCestClick(Sender: TObject);
begin
  pCriarForm(TFrmCadCest);
end;

procedure TfrmPrincipal.mnuClassificaodosCentrosdeCustos1Click(Sender: TObject);
begin
  pCriarForm(TfrmClassifCentroCusto);
end;

procedure TfrmPrincipal.mnuCancRepasseClick(Sender: TObject);
begin
  pCriarForm(TfrmBaixaCancRepasse);
end;

procedure TfrmPrincipal.mnuCadSalBalancoClick(Sender: TObject);
begin
  pOpeProd(CadSalBalanco);
end;

procedure TfrmPrincipal.mnuCadSalBasesClick(Sender: TObject);
begin
  Try
    pCarregaMenuTintaMaquinaSobDemanda;

    If HandleDllAuttin <> 0 Then
      pCriaFormularioBaseSalcomix;
  Finally
    pFinalizaAuttin;
  End;
end;

procedure TfrmPrincipal.mnuCadSalGeraArquivoClick(Sender: TObject);
begin
  Try
    pCarregaMenuTintaMaquinaSobDemanda;

    If HandleDllAuttin <> 0 Then
      pCriaFormularioGerArqSalcomix;
  Finally
    pFinalizaAuttin;
  End;
end;

procedure TfrmPrincipal.mnuCadSalGerNfmClick(Sender: TObject);
begin
  Try
    pCarregaMenuTintaMaquinaSobDemanda;

    If HandleDllAuttin <> 0 Then
      pCriaFormularioGerarNovasFormulasSalcomix(Self);
  Finally
    pFinalizaAuttin;
  End;
end;

procedure TfrmPrincipal.mnuCadSalNovasFormulasClick(Sender: TObject);
begin
  Try
    pCarregaMenuTintaMaquinaSobDemanda;

    If HandleDllAuttin <> 0 Then
      pCriaFormularioNovasFormulasSalcomix;
  Finally
    pFinalizaAuttin;
  End;
end;

procedure TfrmPrincipal.mnuCadCtaPagarClick(Sender: TObject);
  Var
    LManutencaoCtaPagar : TfrmCadCtaPagar;
begin
  Try
    pCriarFormularios(TfrmCadCtaPagar, LManutencaoCtaPagar);
    LManutencaoCtaPagar.ShowModal;
  Finally
    pFreeAndNil(LManutencaoCtaPagar);
  End;
end;

procedure TfrmPrincipal.mnuBaixaCtaPagarClick(Sender: TObject);
begin
  pCriarForm(TfrmBaixaCtaPagar);
end;

procedure TfrmPrincipal.mnuRelChqInclDiariasClick(Sender: TObject);
begin
  pRelatorioChequesPre(relChqInclDiarias);
end;

procedure TfrmPrincipal.mnuRelChqLogAcompClick(Sender: TObject);
begin
  pCriarForm(TfrmRelChqLogAcomp);
end;

procedure TfrmPrincipal.mnuRelChqDeletadosClick(Sender: TObject);
begin
  pRelatorioChequesPre(relChqDeletados);
end;

procedure TfrmPrincipal.mnuRelChqDeposClick(Sender: TObject);
begin
  pRelatorioChequesPre(relChqDepos);
end;

procedure TfrmPrincipal.mnuRelChqRepassadosClick(Sender: TObject);
begin
  pRelatorioChequesPre(relChqRepassados);
end;

procedure TfrmPrincipal.mnuRelChqTelechequeClick(Sender: TObject);
begin
  pRelatorioChequesPre(relChqTelecheque);
end;

procedure TfrmPrincipal.mnuRelChqPredatadosClick(Sender: TObject);
begin
  pRelatorioChequesPre(relChqPredatados);
end;

procedure TfrmPrincipal.mnuRelChqDevolvidosClick(Sender: TObject);
begin
  pRelatorioChequesPre(relChqDevolvidos);
end;

procedure TfrmPrincipal.mnuEstornoCtaPagarClick(Sender: TObject);
begin
  pCriarForm(TfrmEstornoPagar);
end;

procedure TfrmPrincipal.mnuImpBoletoIndivClick(Sender: TObject);
begin
  pCriarForm(TfrmImpBoletoIndiv);
end;

procedure TfrmPrincipal.mnuImpCupProClick(Sender: TObject);
begin
  pCriarForm(TfrmImpCupProm);
end;

procedure TfrmPrincipal.mnuImpEtiqNotaEntradaClick(Sender: TObject);
begin
  pOpeProd(EtiquetasNotaEntrada);
end;

procedure TfrmPrincipal.mnuImpEtiquetasFunClick(Sender: TObject);
  Var
    frmImpEtiquetas : TfrmImpEtiquetas;
begin

  Try
    pCriarFormularios(TfrmImpEtiquetas, frmImpEtiquetas);
    frmImpEtiquetas.intTipEti := ETI_FUNCIONARIOS;
    frmImpEtiquetas.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuImpEtiquetasFunClick]');
    End;
  End;
  pFreeAndNil(frmImpEtiquetas);

end;

procedure TfrmPrincipal.mnuImpEtiRegiaoClick(Sender: TObject);
begin
  pCriarForm(TfrmImpEtiRegiao);
end;

procedure TfrmPrincipal.mnuImpKonciliaClick(Sender: TObject);
begin
   pImportacaoCartoes('Koncili');
end;

procedure TfrmPrincipal.mnuReimpEtiOrdServicoClick(Sender: TObject);
  Var
    frmFatManOrdSer: TfrmFatManOrdSer;
begin
  Try
    pCriarFormularios(TfrmFatManOrdSer, frmFatManOrdSer);
    frmFatManOrdSer.opeTipOpe := opeEtiquetasSer;
    frmFatManOrdSer.ShowModal();
  Finally
    FreeAndNil(frmFatManOrdSer);
  End;
end;

procedure TfrmPrincipal.mnuReimpReciboComissaoProfissionaisClick(
  Sender: TObject);
begin
  pCriarForm(TfrmReimpReciboComissaoProfissionais, frmReimpReciboComissaoProfissionais);
end;

procedure TfrmPrincipal.mnuReimpressaoCarnePagtoClick(Sender: TObject);
begin
  pCriarForm(TfrmReimpressaoCarnePagto);
end;

procedure TfrmPrincipal.mnuReimpressaoCompInspecaoClick(Sender: TObject);
begin
  pCriarForm(TfrmReimpressaoCompInspecao);
end;

procedure TfrmPrincipal.mnuEtiClientesClick(Sender: TObject);
  Var
    frmImpEtiquetas : TfrmImpEtiquetas;
begin
  Try
    pCriarFormularios(TfrmImpEtiquetas, frmImpEtiquetas);
    frmImpEtiquetas.intTipEti := ETI_CLIENTES;
    frmImpEtiquetas.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuEtiClientesClick]');
    End;
  End;
  pFreeAndNil(frmImpEtiquetas);

end;

procedure TfrmPrincipal.mnuEtiItensClick(Sender: TObject);
  Var
    frmImpEtiquetas : TfrmImpEtiquetas;
begin
  Try
    pCriarFormularios(TfrmImpEtiquetas, frmImpEtiquetas);
    frmImpEtiquetas.intTipEti := ETI_ITENS;
    frmImpEtiquetas.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuEtiItensClick]');
    End;
  End;
  pFreeAndNil(frmImpEtiquetas);

end;

procedure TfrmPrincipal.mnuEtiLoteProdArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeLoteProdutoArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiLoteProdLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeLoteProduto, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiDiversosClick(Sender: TObject);
  Var
    frmImpEtiquetas : TfrmImpEtiquetas;
begin
  Try
    pCriarFormularios(TfrmImpEtiquetas, frmImpEtiquetas);
    frmImpEtiquetas.intTipEti := ETI_DIVERSOS;
    frmImpEtiquetas.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuEtiDiversosClick]');
    End;
  End;

  pFreeAndNil(frmImpEtiquetas);

end;

procedure TfrmPrincipal.mnuEtiFornecedoresClick(Sender: TObject);
  var
    frmImpEtiquetas : TfrmImpEtiquetas;
begin
  Try
    pCriarFormularios(TfrmImpEtiquetas, frmImpEtiquetas);
    frmImpEtiquetas.intTipEti := ETI_FORNECEDORES;
    frmImpEtiquetas.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuEtiFornecedoresClick]');
    End;
  End;

  pFreeAndNil(frmImpEtiquetas);

end;

procedure TfrmPrincipal.mnuEtiVendedoresClick(Sender: TObject);
  Var
    frmImpEtiquetas : TfrmImpEtiquetas;
begin
  Try
    pCriarFormularios(TfrmImpEtiquetas, frmImpEtiquetas);
    frmImpEtiquetas.intTipEti := ETI_VENDEDORES;
    frmImpEtiquetas.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuEtiVendedoresClick]');
    End;
  End;

  pFreeAndNil(frmImpEtiquetas);

end;

procedure TfrmPrincipal.mnuEtqProdutosControladosClick(Sender: TObject);
begin
  TfrmEntEtiquetas.pImpEtiEntradaMercadorias('', '', '', '', True);
end;

procedure TfrmPrincipal.mnuAgrupamentoDeOndaDeSeparacaoClick(Sender: TObject);
  var
    frmAgrupamentoDeOndaDeSeparacao: TfrmAgrupamentoDeOndaDeSeparacao;
begin
  pCriarFormularios(TfrmAgrupamentoDeOndaDeSeparacao, frmAgrupamentoDeOndaDeSeparacao);
  Try
    frmAgrupamentoDeOndaDeSeparacao.pSetTipoOnda(toRemessaDeSeparacao);
    frmAgrupamentoDeOndaDeSeparacao.ShowModal;
  Finally
    pFreeAndNil(frmAgrupamentoDeOndaDeSeparacao);
  End;
end;

procedure TfrmPrincipal.mnuAgrupDuplicatasClick(Sender: TObject);
var
  frmAgrupDuplicatas: TfrmAgrupDuplicatas;
begin
  Try
    TNewTimer.SuspendedTimers.Add('frmPrincipal');

    //pCriarForm(TfrmAgrupDuplicatas);
    Try
      pCriarFormularios(TfrmAgrupDuplicatas, frmAgrupDuplicatas);
      frmAgrupDuplicatas.AgrupContaReceber := True;
      frmAgrupDuplicatas.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[mnuAgrupDuplicatasClick]');
      End;
    End;

  Finally
    pFreeAndNil(frmAgrupDuplicatas);
    TNewTimer.SuspendedTimers.Remove('frmPrincipal');
  end;
end;

procedure TfrmPrincipal.MudaStatusTimers(blnSuspende: Boolean);
begin
  If blnSuspende Then
    TNewTimer.SuspendedTimers.Add('frmPrincipal')
  Else
    TNewTimer.SuspendedTimers.Remove('frmPrincipal');
End;

procedure TfrmPrincipal.mnuDesagrupDuplicatasClick(Sender: TObject);
begin
  pCriarForm(TfrmDesagrupDuplicatas);
end;

procedure TfrmPrincipal.mnuCadDescontoClientesMarcasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadDescontoClientesMarcas);
end;

procedure TfrmPrincipal.mnuDescontoMaximoPorAtividadeClick(Sender: TObject);
begin
  pCriarForm(TfrmCadDescontoMaximoPorAtividade);
end;

procedure TfrmPrincipal.mnuDescricaoOcorrenciasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadDescricaoOcorrenciasGia);
end;

procedure TfrmPrincipal.mnuRelCtpEncQuitadosClick(Sender: TObject);
begin
  pRelatorioContasAPagar(relCtpEncQuitados);
end;

procedure TfrmPrincipal.mnuRelCtpChequesEmitidosClick(Sender: TObject);
begin
  pRelatorioContasAPagar(relCtpChequesEmitidos);
end;

procedure TfrmPrincipal.mnuRelCtpCtaCorrenteClick(Sender: TObject);
begin
  pRelatorioContasAPagar(relCtpContaCorrente);
end;

procedure TfrmPrincipal.mnuRelCtpIncDiariasClick(Sender: TObject);
begin
  pRelatorioContasAPagar(relCtpIncDiarias);
end;

procedure TfrmPrincipal.mnuRelCtpPosContabilClick(Sender: TObject);
begin
  pRelatorioContasAPagar(relCtpPosContabil);
end;

procedure TfrmPrincipal.mnuRelCtpIncDiariasMesClick(Sender: TObject);
begin
  pRelatorioContasAPagar(relCtpIncDiariasMes);
end;

procedure TfrmPrincipal.mnuRelCtpKmRodadoVeicClick(Sender: TObject);
begin
  pRelatorioContasAPagar(relCtpKmRodadoVeic);
end;

procedure TfrmPrincipal.mnuRelCtpLogAcompDuplicClick(Sender: TObject);
begin
  pCriarForm(TfrmRelCtpLogAcompDuplic);
end;

procedure TfrmPrincipal.pExibirRelatorio(const APrograma, ADescricao: String; AReport: TfrxReport);
begin
  untFuncoesSimples.pPreviewReport(APrograma, ADescricao, AReport);
end;

procedure TfrmPrincipal.pExibirRelatorio(const APrograma, ADescricao: String; AReport: IReport);
begin
  untFuncoesSimples.pPreviewReport(APrograma, ADescricao, AReport);
end;

procedure TfrmPrincipal.pIniciandoSpedViaParametros;
begin
  If SameText(ParamStr(1), SPED_FISCAL_PARAM) Or
     SameText(ParamStr(1), SPED_PIS_COFINS_PARAM) Then
  Begin
    strLoginUsuarioLogado := LOG_ADM;
    pCarregarVariaveisUsuarioLogado;

    VS_ExibirMensagemAoUsuario := False;
    VS_ExibirMensagemDeErro    := False;
    VS_ExibirMensagemAguarde   := False;

    VS_OnMensagemDeErro     := TExecutarSPED.AddErro;
    VS_OnMensagemAoUsuario  := TExecutarSPED.AddLog;
    VS_OnMensagemAguarde    := TExecutarSPED.AddLog;

    TExecutarSPED.DataInicial   := StrToDateTimeDef(ParamStr(2), StartOfTheMonth(VS_Date));
    TExecutarSPED.DataFinal     := StrToDateTimeDef(ParamStr(3), EndOfTheMonth(VS_Date));
    TExecutarSPED.PathArquivos  := ParamStr(4);
    TExecutarSPED.ProcLoadTinta := Self.pCarregarLibTintaMaquina;
  End;
end;

function TfrmPrincipal.fDisparaSMSWhatsappPedidoCompra(strNumPed,
                                  strCodEmp,
                                  strEspDoc: String;
                                  staStatus: TStatusDisparaEmail;
                                  ARecOpcaoImpressao: TRecOpcaoImpressao;
                                  blnEnviarWhatsapp: Boolean = False): Boolean;
Var
  objSmsAut: TSMSAut;
  qrySQL: TUniQuery;
  recArquivos : TArray<TRecArquivosGatilhos>;
  DisparaEnvioEmailPedidoDeCompraAutomatico: TDisparaEnvioEmailPedidoDeCompraAutomatico;
Begin
  Result := False;

  qrySQL := fCriaQuery(Nil);
  objSmsAut := TSMSAut.Create(Nil);
  Try
    qrySQL.SQL.Add('SELECT        ');
    qrySQL.SQL.Add('	PCG_NUMPED PEDCOM, ');
    qrySQL.SQL.Add('	PCG_ESPDOC ESPCOM, ');
    qrySQL.SQL.Add('	PCG_CODEMP EMPCOM, ');
    qrySQL.SQL.Add('	IFNULL(PCG_EMPDES, "") AS EMPDES, ');
    qrySQL.SQL.Add('	PCG_TOTGER TOTCOM, ');
    qrySQL.SQL.Add('	PCG_DTAEMI DTAEMI, ');
    qrySQL.SQL.Add('	PCG_DTAENT DTAENT, ');
    qrySQL.SQL.Add('	PCG_CODFOR CODFOR, ');
    qrySQL.SQL.Add('	FOR_NOMFOR RAZFOR, ');
    qrySQL.SQL.Add('	FOR_NOMFAN FANFOR, ');
    qrySQL.SQL.Add('	FOR_C_G_C_ CGCFOR, ');
    qrySQL.SQL.Add('	FOR_NUMCEL CELULA ');
    qrySQL.SQL.Add('FROM PCMGER ');
    qrySQL.SQL.Add('  JOIN CADFOR ON CADFOR.FOR_CODFOR = PCG_CODFOR  ');
    qrySQL.SQL.Add('WHERE    ');
    qrySQL.SQL.Add('  LOCATE(CONCAT(PCG_NUMPED,";",PCG_CODEMP),:NUMPED) > 0 AND ');
    qrySQL.SQL.Add('  PCG_ESPDOC = :ESPDOC ');
    qrySQL.ParamByName('NUMPED').AsString := strNumPed;
    qrySQL.ParamByName('ESPDOC').AsString := strEspDoc;
    qrySQL.Open;

    objSmsAut.strOpcDoc := 'PC';
    objSmsAut.staStatus := staStatus;
    objSmsAut.blnAssincrono := True;

    objSmsAut.strPedCom := qrySQL.FieldByName('PEDCOM').AsString;
    objSmsAut.strEspCom := qrySQL.FieldByName('ESPCOM').AsString;
    objSmsAut.strEmpCom := qrySQL.FieldByName('EMPCOM').AsString;
    objSmsAut.strEmpDes := qrySQL.FieldByName('EMPDES').AsString;
    objSmsAut.strTotCom := qrySQL.FieldByName('TOTCOM').AsString;
    objSmsAut.strDtaEmi := qrySQL.FieldByName('DTAEMI').AsString;
    objSmsAut.strDtaEnt := qrySQL.FieldByName('DTAENT').AsString;
    objSmsAut.strCodFor := qrySQL.FieldByName('CODFOR').AsString;
    objSmsAut.strRazFor := qrySQL.FieldByName('RAZFOR').AsString;
    objSmsAut.strFanFor := qrySQL.FieldByName('FANFOR').AsString;
    objSmsAut.strCGCFor := qrySQL.FieldByName('CGCFOR').AsString;
    objSmsAut.strTransp := '';

    objSmsAut.strTo := Trim(qrySQL.FieldByName('CELULA').AsString);


    Try
      DisparaEnvioEmailPedidoDeCompraAutomatico := TDisparaEnvioEmailPedidoDeCompraAutomatico.Create;
      While Not qrySQL.Eof Do
      Begin
        SetLength(recArquivos, Length(recArquivos)+1);
        recArquivos[High(recArquivos)] := TRecArquivosGatilhos.Create('PEDIDO DE COMPRA_'+qrySQL.FieldByName('PEDCOM').AsString+'-'+qrySQL.FieldByName('ESPCOM').AsString,
                                                                      DisparaEnvioEmailPedidoDeCompraAutomatico.fCodigo('PDCWPP')
                                                                                                               .fEspDoc(qrySQL.FieldByName('ESPCOM').AsString)
                                                                                                               .SetRecOpcaoImpressa(ARecOpcaoImpressao)
                                                                                                               .fGeraPDFEmailAutomatico(qrySQL.FieldByName('PEDCOM').AsString,
                                                                                                                 strCodEmp,
                                                                                                                 objSmsAut.strCodFor,
                                                                                                                 qrySQL.FieldByName('EMPDES').AsString,
                                                                                                                 True{blnSemProgresso}
                                                                                                                ),
                                                                      EmptyStr);

        qrySQL.Next;
      End;
    Finally
      pFreeAndNil(DisparaEnvioEmailPedidoDeCompraAutomatico);
    End;
    objSmsAut.FArquiv := recArquivos;
    objSmsAut.blnWhatsApp := blnEnviarWhatsapp;

    If (objSmsAut.fTemModeloAtivo) Then
    Begin
      if (blnEnviarWhatsapp) and (not fRetFilaEContatoEnvio(objSmsAut.FAutIncCtt,
                                                            objSmsAut.FTo,
                                                            objSmsAut.FIDFila,
                                                            objSmsAut.strCodFor,
                                                            objSmsAut.strRazFor,
                                                            objSmsAut.strCodigo,
                                                            objSmsAut.strCodGru,
                                                            objSmsAut.blnAbreTelaEscolherContato)) then
        Exit;

      Result := objSmsAut.fEnviaSMSAutomatico;
    End;
  Finally
    FreeAndNil(qrySQL);
    FreeAndNil(objSmsAut);
  End;
End;

procedure TfrmPrincipal.pRemoverEventosParaFinalizarPrograma;
begin
  Self.OnShow := Nil;
  Self.OnActivate := Nil;
  Self.OnPaint := Nil;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  {$IFNDEF TESTABILIDADE_AUTCOM}
  InstalarHooks;
  {$ENDIF}

  objTefCitel := Nil ;
  dicOrdenaMnu := TDictionary<String, TOrdenaMnu>.Create;
  FLibAutTinInicializada := False;
  pIniciandoSpedViaParametros;
  pnlPanelItemPrecoProduto := TPanelCxItem.New(tpProdutoPreco);
  // Req 376187, passando False para não criar CONFERENCIA DE ESTOQUE CONTÁBIL no menu de contabilidade
  TMenuContabilidade.Carregar(mnuContabilidade, Self, False);
  procLimparDicionarioCampoTabelaContabilidade := TLimparCaches.Execute;

  untFuncoesSimples.PrcSuspenteTimerPrincipal := Self.MudaStatusTimers;

  Contabilidade.Funcoes.ProcExibirRelatorio := Self.pExibirRelatorio;

  untFuncoesSimples.funDisparaSMSWhatsappPedidoCompra := fDisparaSMSWhatsappPedidoCompra;
  untFuncoesSimples.funDisparaWhatsappAutomatico := untFuncoes.fDisparaWhatsappSimples;
  untFuncoesSimples.funDisparaEmailAutomatico := untFuncoes.fDisparaEmailSimples;
  untFuncoesSimples.fExisteDireitoAcesso := Self.fExisteDireitoAcesso;
  prcExibeRequisicaoCompra := TfrmFatRequisicaoCompras.pExibeRequisicaoCompra;
  ProcRetCfgRelacionadaArquivo :=  fRetCfgRelacionadaArquivo;
  PrcIniciaProcessoDivisaoDeChapa :=  TDividirChapa.pIniciaProcessoDivisaoDeChapa;
  funGerarEmail := TfrmFatGorEmail.fGerarEmail;
  funCfgPedidoDeCompra := TfrmDigEmailPedidoCompra.pChamaConfiguracaoEnvioAutoticoEmail;

  pSetCxControlsScrollbarModeClassic(Self);

  pIniciarConexao;

  If Assigned(frmModulo) Then
    pGeraRegistroParaLogGeneral(frmModulo.GetCurrentConnection, 'Inicializacao');

  fAjustaDataSistema;
  TLogAut.New().pLogin();//deve registrar o login assim que se conectar com o banco de dados

  frmModulo.VersionTitle := TVersaoExecutavel.GetTituloVersao;

  If Assigned(VS_ListaDeCarteiras) Then
    FreeAndNil(VS_ListaDeCarteiras);
  VS_ListaDeCarteiras := RetornaListaDeCarteirasCFGBAN;

  VS_blnPreAltViaTrigger := fConfiguracaoAtivaTriggerPreAlt;

  if blnYapay then
    pHideApplicationEx(True);

  blnExecutandoAutBan := False;
  blnExecutandoAutTin := False;

  strNLeads := '';
  blnEstouNoCrm := False;

  hraMensagemTEF := 0;
  hrCicloHorOpe := fTime(True);
  fraPesquisarMenu.pSetaMenu(mnuAutcomK);

  intNextMonitorId := 0;

  blnHomologacao := fArqIni(0, 'GERAL', 'HOMOLOGACAO', '') = 'S';

  blnImpMovMe  := SameText(ParamStr(1), PARAM_EXEC_MOVMER);
  blnImpSfaMob := SameText(ParamStr(1), PARAM_EXEC_SFAMOB);

  pIniciaLogLeak(DebugHook, 'Autcom');

  lcl.Active := True;
  lcl.Locale := 1046;

  CHAVE_PUBLICA := 'D506134F38A24A07DEF86195DFBB397C9C10E72D91AFEFBBF139D91054F5' +
                   '88E4EDF84A4A65F5278DBDD497A7314F300E3D40E4099BAFA34ACDCF3500' +
                   '07531AACBD08DED89868AE82D0A58E2614768750F5D3A658E22DC9D99ECB' +
                   '60FCDFA83BA455D07CA62FA3A2B215E23F3473222F11634DAF005DEAE841' +
                   '3DBE95C0E78E9179';

  CHAVE_PRIVADA := 'F8AD74EC889822A79F044E3E1325E9E62C127AE4AA5149B6B33A8C59F886' +
                   'C30A4F9DEE443E95C4E8F1E89F4C3952BB2332665D5E6533C2026224E376' +
                   '5D4701C1DB4BDBC0BED364B2258A6C6715C378FF0CB262022784E538A03D' +
                   '2EE59E3A377B29D03F0551C9D6A65BC95062DE71A6373B9B13E7EE1FF6CE' +
                   'CCA5E93E17078DB9';

  VS_blnCupomAberto   := False;
  blnVerificaTef      := False;
  blnMenuPintor       := True;
  blnUtiNps           := False;
  blnFecharForm       := False;
  VS_AutcomIniciadoModoRobo := False;
  blnIniciouSistema   := False;
  blnAuditouMenu      := False;
  blnTerminouFormShow := False;

  intSemaforoCadCli := -1;
  intSemaforoEsc    := -1;

  objSemaforoGeralMenus := TSemaforo.Create;
  lstSemaforos          := TObjectList.Create;
  stlTintasMenu         := TStringList.Create;
  stlTintaMdlls         := TStringList.Create;
  utcRegistros          := TUltConsultas.Create;
  objCadastros          := TCadastros.Create;

  {*********************************************}
  {* DESLIGA O BEEP DO SPEAKER                 *}
  {******************************************MV*}
  Try
    SystemParametersInfo(SPI_SETBEEP, 0, Nil, 0);
  Except

  End;

  pBloqueiaBotoes;
  pEscondeBotoes;

  untFuncoesSimples.VS_objTraceViewer := TTraceViewer.Create;
  untConsultas.VS_Application := Application;
  untConsultas.fMskCon := Contabilidade.Funcoes.fMskCon;
  untConsultas.fncPesqPlanoContabil := Contabilidade.Consultas.fPesqPlanoContabil;

  untFuncInsFactory.objIFuncIns := TObjFuncIns.Create;
  untFatGorFactory.pSetFatGor(TFatGor.Create);
  untGravando.prcMenOK := untFuncoesSimples.pMensagemGravando;


  pVerificarAutcomIniciadoModoRobo;

  If (Not VS_AutcomIniciadoModoRobo) Then
  Begin
    If Not frmPrincipal.fPedeLogin Then
    Begin
      pRemoverEventosParaFinalizarPrograma;
      TNewTimer.SuspendedTimers.Add('frmPrincipal');
      pFinalizaObjetos;
      pTerminate;
    End;

    pInitProfilerUser(strLoginUsuarioLogado, frmModulo.GetCurrentConnection);
    ActivateClassGroup(TControl);//Fix FindClass Error when using vcl and firemonkey

    VerificaConfiguracaoForcarEmail;
  End;

  VS_dtaIni := Date;

  objLiberacao := TLiberacao.create;

  tmrRelogio := TNewTimer.Get('frmPrincipal.tmrRelogio');
  tmrRelogio.Interval := 20000;
  tmrRelogio.Enabled  := True;
  tmrRelogio.OnTimer  := tmrRelogioTimer;

  tmrDataSistema := TNewTimer.Get('frmPrincipal.tmrDataSistema');
  tmrDataSistema.Interval := 1800000;
  tmrDataSistema.Enabled  := False;
  tmrDataSistema.OnTimer  := tmrDataSistemaTimer;

  tmrCompromissos := TNewTimer.Get('frmPrincipal.tmrCompromissos');
  tmrCompromissos.Interval := 90000;
  tmrCompromissos.Enabled  := True;
  tmrCompromissos.OnTimer  := tmrCompromissosTimer;

  tmrTemMsg := TNewTimer.Get('frmPrincipal.tmrTemMsg');
  tmrTemMsg.Interval := 10000;
  tmrTemMsg.Enabled  := False;
  tmrTemMsg.OnTimer  := tmrTemMsgTimer;

  tmrSincEmail := TNewTimer.Get('frmPrincipal.tmrSincEmail');
  tmrSincEmail.Interval := 90000;
  tmrSincEmail.Enabled  := True;
  tmrSincEmail.OnTimer  := tmrSincEmailTimer;

  tmrMonitor := TNewTimer.Get('frmPrincipal.tmrMonitor');
  tmrMonitor.Interval := 90000;
  tmrMonitor.Enabled  := False;
  tmrMonitor.OnTimer  := tmrMonitorTimer;

  tmrGatime := TNewTimer.Get('frmPrincipal.tmrGatime');
  tmrGatime.Interval := 90000;
  tmrGatime.Enabled  := False;
  tmrGatime.OnTimer  := tmrGatimeTimer;

  tmrTestaLogReplicacao := TNewTimer.Get('frmPrincipal.tmrTestaLogReplicacao');
  tmrTestaLogReplicacao.Interval := 120000;
  tmrTestaLogReplicacao.Enabled  := False;
  tmrTestaLogReplicacao.OnTimer  := tmrTestaLogReplicacaoTimer;

  tmrRecorrenciaCrm := TNewTimer.Get('frmPrincipal.tmrRecorrenciaCrm');
  tmrRecorrenciaCrm.Interval := 90000;
  tmrRecorrenciaCrm.Enabled  := False;
  tmrRecorrenciaCrm.OnTimer  := tmrRecorrenciaCrmTimer;

  tmrLotWms := TNewTimer.Get('frmPrincipal.tmrLotWms');
  tmrLotWms.Interval := 90000;
  tmrLotWms.Enabled  := False;
  tmrLotWms.OnTimer  := tmrLotWmsTimer;

  tmrEntregaDivergente := TNewTimer.Get('frmPrincipal.tmrEntregaDivergente');
  tmrEntregaDivergente.Interval := 120000;
  tmrEntregaDivergente.Enabled  := False;
  tmrEntregaDivergente.OnTimer  := tmrEntregaDivergenteOnTimer;

  pIniciarTraceViewer;

  {$IFDEF TESTABILIDADE_AUTCOM}
  //não altera propriedades
  {$Else}
  If Not blnUsuarioLogadoUtilizaModoClassico Then
  Begin
    If Not RunningInTSPlus Then
    Begin
      Self.AlphaBlend := True;
      Self.AlphaBlendValue := 0;
    End;
    SetAsMainForm(Self);
  End;
  {$ENDIF}

  untFuncoes.pMostraMensTEF := Self.pMostraMensTEF;

  untFuncoesSimples.VS_BancosPix := TFuncoesPixAutcom.InicializaBancosPixAtivos;

  VS_WorkStationIP     := TWorkStationInfo.fGetWorkStationIP;
  VS_WorkstationID     := TWorkStationInfo.fGetWorkStationID;

  pnlNotificacao.Top  := btnMensagem.Top;
  pnlNotificacao.Left := btnMensagem.Left + btnMensagem.Width - 20;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  Self.MudaStatusTimers(True);

  untConsultas.fMskCon := Nil;
  untConsultas.fncPesqPlanoContabil := Nil;
  untGravando.prcMenOK := nil;
  iTintasMaquina := Nil;

  DesabilitaEnvioEmails;

  If Assigned(objLiberacao) Then
    FreeAndNil(objLiberacao);

  If Assigned(FobjQuadroLicencas) Then
    FreeAndNil(FobjQuadroLicencas);
end;

procedure TfrmPrincipal.FormActivate(Sender: TObject);
  Var
    blnConfirma  : Boolean;
    strDir       : String;
    LfrmGravando : TfrmGravando;
begin
  pVerificarAutcomIniciadoModoRobo;

  If Not blnUsuarioLogadoUtilizaModoClassico Then
    If RunningInTSPlus Then
      Self.WindowState := wsMinimized;

  if blnYapay then
    pHideApplicationEx(True);

  if VS_AutcomIniciadoModoRobo then
    Exit;

  If Not blnTerminouFormShow Then
    Exit;

  If Not blnIniciouSistema Then
    blnIniciouSistema := True
  Else
    Exit;

  blnConfirma := True;
  If Not blnExecutandoAutBan And Not blnExecutandoAutTin Then
  Begin
    VS_LastConnID := fGetConnectionID;

    pInicializacaoFinalizacaoDicConfigInicial;

    DefinirTimeZoneEmSessaoMySql(fGetConexao, VS_strCodEmp);

    fAjustaDataSistema;

    pSetaDirecaoPopupMsg;

    {********************************}
    {* INICIANDO A DLL "libFuncoes" *}
    {*****************************AN*}
    If blnConfirma Then
    Begin
      pCarregaTABNRE;
    End;

    If blnConfirma Then
    begin
      if not TYapayFacade.fVerificaExistenciaRestDLL then
      begin
        pTerminate;
        Exit;
      end;
    end;

    If blnConfirma And (Not fPainelAtualizado) Then
    Begin
      fMensagem('ATENÇÃO!', '>>>>>> Você utiliza nota fiscal eletrônica. Por favor, abra o PainelNFe.' + #13#10 +
        'Caso essa mensagem persistir, por favor ligue na Citel.', ['&Ok']);
    End;

    pIncluiCfgSisTCOARR;

    VS_strHabilitarCRM := ((fArqIni(0, 'GERAL', 'CRM', '') = 'S') And (fCfgSis('UTICRM', varBoolean)));

    pPrimeiroLogin(strLoginUsuarioLogado);

    {**********}
    {* SPLASH *}
    {**********}
    If blnConfirma Then
    Begin
      pInicializaVariavelGlobalPixScope;
      blnGeracaoAut := False;
      Try
        blnConfirma := fExecutarSplash;
      Finally
        pTrimAppMemorySize;
      End;
      pVerificaTEF;
    End;

    VS_blnPreAltViaTrigger := fConfiguracaoAtivaTriggerPreAlt;

    If blnConfirma And blnNumSerSAT Then
    Begin
      VS_NumSerSat := ParamStr(2);
      VS_ImpressoraSat := ParamStr(3);
    End;

    If Not blnConfirma Then
    Begin
      pTerminate;
      Exit;
    End;

    {*******************************************************}
    {* REFTRI: COM O PLUGIN DE PRECOS DA REFORMA NA PASTA, *}
    {* O BANCO GANHA AS TABELAS E COLUNAS QUE ELE ESPERA   *}
    {*******************************************************}
    pReformaPrepararBanco;

    {*********************}
    {* COTAÇÃO DE MOEDAS *}
    {******************PZ*}
    If blnConfirma Then
    Begin
      If (fCfgSis('COTDOR', varBoolean)) Then
      Begin
        If Not fVerifCotacao(VS_Date) Then
        Begin
          If Not fInsereCotacaoDoDia Then
          Begin
            fMensagem('', 'Erro ao incluir Cotação do Dia!',['&OK']);
            pTerminate;
            Exit;
          End;
        End;
      End;
    End;

    TLogForm.strCodEmp := VS_strCodEmp;
    TLogForm.strCodOpe := strLoginUsuarioLogado;
    TLogForm.dtaDtaLog := VS_Date;
    TLogForm.fncCriaQuery := fCriaQuery;
    TLogForm.fncTime := fTime;
    TLogForm.blnLogFrm := fCfgSis('LOGFRM', varBoolean) And fTabelaExiste('LOGFRM', True);

    TLogGor.blnExecutaLog := fTabelaExiste('LOGGOR', True) And fTabelaExiste('LOGDOR', True);

    VS_blnNotificaSaldoAbaixMinimo := fCfgSis('UTINEM', varBoolean);

    blnUtiNps := fCfgSis('UTINPS', varBoolean);

    If SameText(fCfgSis('TELAGE'),'4') Then
    Begin
      mnuGeraAgendaCiclicoComDia.Caption := 'Gera Primeiro Agendamento';
    End;

    pLiberaExecucaoChm;
    pLiberaExecucaoRobos;

    TMenuContabilidade.DesabilitarItemMenu(Self) ;

    stbStatus.Panels[3].Text := strLoginUsuarioLogado + ' - ' + strDescriUsuarioLogado;
    stbStatus.Panels[4].Text := Concat(frmModulo.GetCurrentConnection.Server, '/', frmModulo.GetCurrentConnection.Database);
    stbStatus.Panels[6].Text := Trim(DiretorioExecutavel);

    ValidacaoCertificadosPix;
  End;

  {*****************************************************************************}
  {* VERIFICA NO BemaFI32.ini SE IMPRESSORA = 1 SE NÃO ESTIVER FORÇA A GRAVAÇÃO*}
  {**************************************************************************RN*}
  pAtualizaBemaFI32;

  {****************************************************************************}
  {* CRIA PASTA DE IMAGENS CASO NÃO EXISTA A PARTIR DO DIRETORIO DA APLICACAO *}
  {**************************************************16/07/09******** AM ******}
  If fCfgSis('IMGPRO') = 'S' Then
  Begin
    strDir := fRetornaPathImagem;
    If (Not VS_PathImagemExiste) And (strDir <> '') And (LeftStr(strDir, 2) <> '\\') Then
    Begin
      If CreateDir(strDir) Then
        VS_PathImagemExiste := True
      Else
        fMensagem('', 'O sistema não pode criar uma pasta ["Imagens"] para receber as imagens dos produtos.'+#13+
                      'Verifique sua autoridade de acesso no sistema operacional.', ['&Ok']);
    End;

    //Se existir a pasta Importar dentro da pasta Imagens iniciar o processo para importar as imagens ao banco
    If VS_PathImagemExiste And TryDirectoryExists(strDir + 'IMPORTAR') then
    Begin
      Try
        pCriarFormularios(TfrmGravando, LfrmGravando);
        LfrmGravando.lblGravando.Caption := 'Importando Imagens...';
        LfrmGravando.pgbStatus.Visible := False;
        LfrmGravando.fExecutarAcao := fImportaImagens;
        LfrmGravando.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '');
        End;
      End;

      pFreeAndNil(LfrmGravando);
    End;
  End;

  if Assigned(tmrTemMsg) then
    tmrTemMsg.Enabled := True;

  if Assigned(tmrDataSistema) then
    tmrDataSistema.Enabled := True;

  pDesabilitaHabilitaTimerECarregaEventoOnTimer(fCfgSis('BOLAVI', varBoolean) And VS_PermitidoEnviarEmail,
                                                tmrEmailBoletoAutomatico, tmrEmailBoletoAutomaticoOnTimer, 'tmrEmailBoletoAutomatico',
                                                Self,
                                                3600000);

  pDesabilitaHabilitaTimerECarregaEventoOnTimer(fCfgSis('PMEHAB', varBoolean),
                                                tmrCobrancaEletronica, tmrCobrancaEletronicaOnTimer, 'tmrCobrancaEletronicaAutomatico',
                                                Self,
                                                Max(fCfgSis('PMETML', varInteger), 60) * 1000);												
  
  pDesabilitaHabilitaTimerECarregaEventoOnTimer((fCfgSis('USADEP') = 'S') And (ParamStr(1).IsEmpty),
                                                tmrSistemaDEPS, tmrSistemaDEPSOnTimer, 'tmrSistemaDEPS',
                                                Self,
                                                90000);

  pDesabilitaHabilitaTimerECarregaEventoOnTimer((fCfgSis('CTPPRE') = 'S') And
                                                (ParamStr(1).IsEmpty) And
                                                (fCampoTabela('OPE_MSGPRE', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]) = 'S'),
                                                tmrAvisosPrevisaoCTP, tmrAvisosPrevisaoCTPOnTimer, 'tmrAvisosPrevisaoCTP',
                                                Self,
                                                90000);

  pDesabilitaHabilitaTimerECarregaEventoOnTimer(fCfgSis('EMICTE', varBoolean),
                                                tmrImportaCTes, tmrImportaCTesOnTimer, 'tmrImportaCTes',
                                                Self,
                                                90000);


  pDesabilitaHabilitaTimerECarregaEventoOnTimer(fCfgSis('UTLPRJ', varBoolean) And (fCampoTabela('OPE_MSGPRJ', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]) = 'S'),
                                                tmrProjetosAtrasado, tmrProjetosAtrasadoOnTimer, 'tmrProjetosAtrasado',
                                                Self,
                                                10000);

  pDesabilitaHabilitaTimerECarregaEventoOnTimer(fCfgSis('USAPIX', varBoolean) And (Not untFuncoesSimples.RunningInTSPlus),
                                                tmrConsultaPix, tmrConsultaPixOnTimer, 'tmrConsultaPix',
                                                Self,
                                                30000);

  pDesabilitaHabilitaTimerECarregaEventoOnTimer(fCfgSis('AVIDEB', varBoolean) And VS_PermitidoEnviarEmail,
                                                tmrAvisoDebitoAutomatico, tmrAvisoDebitoAutomaticoOnTimer, 'tmrAvisoDebitoAutomatico',
                                                Self,
                                                90000);

  pDesabilitaHabilitaTimerECarregaEventoOnTimer(fExibirAlertaEntregaComDivergencia,
                                                tmrEntregaDivergente, tmrEntregaDivergenteOnTimer, 'tmrEntregaDivergente',
                                                Self,
                                                120000);

  pIniciarTimersImportacao;

  pIniciaTimerQuestFidelidade;

  {****************************************}
  {* VERIFICA SE EXISTE TRANSFERENCIA DE  *}
  {* ESTOQUE PARA DAR ENTRADA...          *}
  {*************************************IV*}
  If fCfgSis('MSGTRE', varBoolean) Then
    pDesabilitaHabilitaTimerECarregaEventoOnTimer(fCampoTabela('OPE_MSGTRE', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]) = 'S',
                                                  tmrTransfEst, tmrTransfEstOnTimer, 'tmrTransfEst',
                                                  Self,
                                                  10000);

  {*******************************************}
  {* VERIFICA SE EXISTE COMPROMISSO PARA O   *}
  {* OPERADOR LOGADO                         *}
  {****************************************ED*}
  pVerCompromisso;

  TControlaNotificacaoSaldoMin.pExbirProdutosComSaldoAbaixoMinimo(strLoginUsuarioLogado);

  with TNewTimer.Get('frmPrincipal.tmrMensagem') do
  begin
    Interval := 1000;
    Enabled  := True;
    OnTimer  := tmrMensagemTimer;
  end;

  pMostraProdutosComPrecoPautaFiscalVencido(strLoginUsuarioLogado);

  if Assigned(tmrTestaLogReplicacao) then
    tmrTestaLogReplicacao.Enabled := TRUE;

  pIniciaTmrAlpeBoleto;

  pChecagemCfgCliAti;

  If (VS_strIconeAutcomBarraNotificacao = 'S') And Not RunningInTSPlus Then
  Begin
    Try
      tryIconAutcom.Hint := Self.Caption;
      tryIconAutcom.Visible := fCfgSis('HABREM', varBoolean);

      If (tryIconAutcom.Visible) Then
        VS_trayIconAutcom := tryIconAutcom;
    Except
      //Em servidores TS o usuário pode não ter permissão para criar icone na barra de
      //notificação gerando um erro "Cannot create shell notification icon."
    End;
  End;

  pValidaProCod('CFGCON');
  pValidaProCod('CADINT');
  pValidaProCod('COTITE');
  pValidaProCod('ALTEST');

  if fCfgSis('PMEHAB', varBoolean) then
    pValidaProCod('COBELT');

  If (Not blnFecharForm) And
     (blnGerImpPdv Or blnGerImpCTe Or blnDefinirLotesWMS Or blnFaturamentoAutomatico Or blnCanceladorAutomatico Or
      blnImprimeEtiquetaDespacho Or blnImprimeEtiquetaVolume Or
      blnNotificacoesMonitor Or blnDesmembramentoPedidoPIX Or blnGatilhosInformacao Or blnGatilhosImediatos Or blnConsultaPrecoTintas Or
      blnSpedPisCofins Or blnSpedFiscal Or VS_AutoatendimentoPagueFacil Or VS_AutoatendimentoConsultaPreco Or VS_AutoatendimentoBuscaFacil Or blnYapay) Then
  Begin
    Try
      Self.Hide;
    Except
    End;
  End;

  If blnExpMotorola And blnConfirma Then
  Begin
    mnuFatExpedicaoClick(mnuFatExpedicao);
    pFinalizaObjetos;
    pTerminate;
  End;

  If VS_strHabilitarCRM Then
  Begin
    TCategoriaCrm.pInserirCategoriasProspectoPadraoCRM;
    if Assigned(tmrRecorrenciaCrm) then
      tmrRecorrenciaCrm.Enabled := True;
  End;

  {*******************************************}
  {* VERIFICA SE EXISTE ALTERAÇÃO DE PREÇOS  *}
  {* PROGRAMADA PARA O DIA. SE TIVER, MOSTRA *}
  {* MENSAGEM                                *}
  {*******************************************}
  pVerAlteraPreco;

  Self.FormResize(Nil);

  If fEhAdministrador(strLoginUsuarioLogado) Then
  Begin
    If (Not blnFecharForm) And (Not blnGerImpPdv) And (Not blnGerImpCTe) And (Not fOpcoesIgnorar) And
       (ParamCount = 0) and (not blnYapay) And (Not blnAuditouMenu) Then
    Begin   
      blnAuditouMenu := True; 
      pAuditaTagMenu(mnuAutcomK);
      pAuditaHintMenu(mnuAutcomK);
      pAuditaCfg ;
    End; 
  End;   
  
  fraPesquisarMenu.pLimparPesquisa;

  If Assigned(tmrEmailBoletoAutomatico) Then
    If tmrEmailBoletoAutomatico.Enabled Then
      tmrEmailBoletoAutomaticoOnTimer(tmrEmailBoletoAutomatico);

  TThread.CreateAnonymousThread(
    procedure
    begin
      SetForegroundWindow(Handle);
    end
  ).start();

  pGravaConfiguracoesUsadasLogin;
  pExibirNovaTelaPrincipalAutcom;

  {$IFDEF TESTABILIDADE_AUTCOM}
    pCriarFormularios(TfrmTestabilidade, frmTestabilidade);
    frmTestabilidade.Show;

    If MadExcept.MESettings().ReportLeaks Then
      ClearLeaks();
  {$ENDIF}
end;

procedure TfrmPrincipal.pTerminate(blnEncerrarPorTerminateProcess: Boolean=True; blnExecutouFinalizaObjetos: Boolean=False);
Begin
  {$IFNDEF TESTABILIDADE_AUTCOM}
  RemoverHooks;
  {$ENDIF}

  If (Not blnExecutouFinalizaObjetos) Then
  Begin
    TThreadFinalizarAutcomMonitor.Monitorar;
    TLogAut.New().pLogout();
    pFinalizaLibrarys;
  End;

  If blnEncerrarPorTerminateProcess Then
  Begin
    Try 
      If Not TerminateProcess(GetCurrentProcess, 0) Then
        Application.Terminate;
    Except
      Application.Terminate;
    End;
  End
  Else
  Begin
    Application.Terminate;
  End;
End;

procedure TfrmPrincipal.pTestaInatividadeCTe;
var
  strLockInatividade: string;
begin
  strLockInatividade := 'TESTE_INATIVIDADE_CTE_' + VS_strCodEmp;

  pDestravaLockForcado(strLockInatividade);
  If fLock_Unlock(strLockInatividade, True, False, False, '', False) Then
  Begin
    Try
      If MinutesBetween(fNow(), VS_dtaUltimaExecucaoImportadorCTe) >= TEMPO_EXECUCAO_IMPORTADOR_CTE+3 Then
      Begin
        Try
          TerminateProcess(VS_objProcessoImportadorCTe.hProcess, 0);
          VS_dtaUltimaExecucaoImportadorCTe := fNow();
        Except
        End;
      End;
    Finally
      fLock_Unlock(strLockInatividade, False, False, False, '', False);
    End;
  End;
end;

procedure TfrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  If (TSemaforo.intSemaforo >= 0) Then
    CanClose := False
  Else
    CanClose := True;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF TESTABILIDADE_AUTCOM}
    If (Sender = Self) Then
    Begin
      TLogAut.New().pLogout();
      pFinalizaObjetos;
      If MadExcept.MESettings().ReportLeaks Then
        HideLeak('cxControls|CalculatePopupScrollElementVisibleRect');
      Exit;
    End;
  {$Else}
  If Not blnUsuarioLogadoUtilizaModoClassico Then
  Begin
    If (Sender = Self) Then
      Exit;
  End;
  {$ENDIF}

  If InterlockedIncrement(intSemaforoEsc) = 0 Then
  Begin
    Try
      If (Not blnFecharForm) And (Not blnGeracaoAut) Then
      Begin
        If ( (VS_strUsaTef = 'S') And (Assigned(VS_objTef)) And (VS_objTef.fTef_Atv()) ) Or (VS_strUsaTef <> 'S') Or (VS_blnTefCitel) Then
        Begin
          If fMensagem('AVISO', 'Deseja sair do sistema?', ['', '']) = 2 Then
            Action := caNone;

          if Action <> caNone then
          begin
            pLiberaLCKATCDasNotificacoes;
            pLiberaLCKATCAlpeBoleto;
            TfrmGravando.fExecutarModal(pAguardaSincronizacaoEmail,'Aguarde... Encerrando Sincronização de E-mails Enviados...','');
          end;
        End;
      End;

      If (Action <> caNone) Then
      Begin
        Self.MudaStatusTimers(True);
        pFinalizaObjetos;
      End;
    Finally
      InterlockedDecrement(intSemaforoEsc);
    End;
  End
  Else
  Begin
    InterlockedDecrement(intSemaforoEsc);
  End;
end;

procedure TfrmPrincipal.pProgresso(pgbStatus: TcxProgressBar; intPos, intMax: Integer; strMsg: String; blnApenasMsg: Boolean);
Begin
  If Assigned(pgbStatus) Then
  Begin
    if not blnApenasMsg then
    begin
      pgbStatus.Visible := (intMax + intPos) > 0;

      pgbStatus.Properties.Max := intMax;
      pgbStatus.Position := intPos;
    end;

    If Not fEmptyStr(strMsg) Then
      If Assigned(GetParentForm(pgbStatus).FindComponent('lblGravando')) Then
        TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strMsg;

    Application.ProcessMessages;
  End;
End;

procedure TfrmPrincipal.pProjetosAtrasado;
begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(152, 7045, [],
                        [],
                        [],
                        nil,
                        nil,
                        True,
                        False);
  End;

end;


procedure TfrmPrincipal.mnuPreparaGerTEClick(
  Sender: TObject);
  Var
    objPreparaGer: TPreparaGeracaoTE;
begin
  objPreparaGer := TPreparaGeracaoTE.Create;
  objPreparaGer.pInformaPreparacao('');

  FreeAndNil(objPreparaGer);
end;

procedure TfrmPrincipal.mnuPrioridadeSaidaEstoqueEmpresaClick(Sender: TObject);
var
  frmPrioridadeSaidaEstoqueEmpresa: TfrmPrioridadeSaidaEstoqueEmpresa;
begin
  pCriarFormularios(TfrmPrioridadeSaidaEstoqueEmpresa, frmPrioridadeSaidaEstoqueEmpresa);
  try
    frmPrioridadeSaidaEstoqueEmpresa.ShowModal;
  finally
    FreeAndNil(frmPrioridadeSaidaEstoqueEmpresa);
  end;
end;

procedure TfrmPrincipal.mnuPrmRotCitelAbasteceClick(Sender: TObject);
var
  frmCadPrmRotCitelAbastece: TfrmCadPrmRotCitelAbastece;
begin
  pCriarFormularios(TfrmCadPrmRotCitelAbastece, frmCadPrmRotCitelAbastece);
  try
    frmCadPrmRotCitelAbastece.ShowModal;
  finally
    FreeAndNil(frmCadPrmRotCitelAbastece);
  end;
end;

procedure TfrmPrincipal.pVerificaMenu(Item: TMenuItem; trvItem: TTreeNode; pgbStatus: TcxProgressBar = Nil;
  blnVerificarAcesso: Boolean = True; blnTemDireito: Boolean = True);
  Var
    intContador: Integer;
    blnBarrinha: Boolean;
    trvNovo: TTreeNode;
Begin
  blnBarrinha := False;
  trvNovo     := nil;

  {**********************************}
  {* FOR NO MENU INTEIRO            *}
  {*******************************AF*}
  For intContador := 0 To Item.Count-1 Do
  Begin
    pProgresso(pgbStatus, Succ(intContador), Item.Count, Item.Caption + ' ...');

    If (Item[intContador].Caption <> '-') Then
    Begin
      If blnVerificarAcesso Then
      Begin
        blnTemDireito := fVerificaAcessoSistema(Item[intContador].Hint);

        If Not blnTemDireito Then
        Begin
          blnTemDireito := fVerificaAcessoAutTin(Item[intContador].Hint, Item[intContador].Name);

          If blnTemDireito Then
          Begin
            blnTemDireito := fVerificaAcessoGeracaoTintas(Item[intContador].Caption);
            blnTemDireito := blnTemDireito And fTintaDisponivel(Item[intContador].Hint, iTintasMaquina);
          End;
        End;
      End;

      {******************************}
      {* SE A TAG FOR = 0 ENTAO VAI *}
      {* COLOCAR A LETRA            *}
      {***************************AF*}
      If blnTemDireito Then
      Begin

        If Item[intContador].Tag = 0 Then
        Begin

          {*****************************}
          {* MANDA APARECER A BARRINHA *}
          {**************************AF*}
          If (mnuBarrinha <> Nil) Then
          Begin
            mnuBarrinha.Visible := True;
            mnuBarrinha := Nil;
          End;
          blnBarrinha := True;
        End;

      End
      Else
      Begin

        If fCfgSis('MOSMNU', varBoolean) Then
        Begin
          {*****************************}
          {* MANDA APARECER A BARRINHA *}
          {**************************AF*}
          If (mnuBarrinha <> Nil) Then
          Begin
            mnuBarrinha.Visible := True;
          End;
          blnBarrinha := True;

          Item[intContador].Enabled := False;

        End
        Else
        Begin
          Item[intContador].Visible := False;
          {********************************}
          {* MANDA DESAPARECER A BARRINHA *}
          {*****************************AF*}
          If mnuBarrinha <> Nil Then
          Begin
            mnuBarrinha.Visible := False;
          End;
        End;
      End;

      {************************************}
      {* MONTA O POP DE PRODUTOS          *}
      {*********************************AF*}
      If blnUsuarioLogadoUtilizaModoClassico Then
        If (Pos(Item[intContador].Hint,'frmConsultaServicos_frmCadProdutos_frmConsultaFatProdutos_frmConsultaFatCatalogo_frmConsultaFatCatalogoAlteracao_') > 0) Or
           ((stlTintasMenu.IndexOf(Item[intContador].Caption) > -1) And (Item[intContador].Caption = Item[intContador].Hint)) Then
          pGeraPopUp(Self, Item[intContador],popProdutos.Items);

      {**********************************}
      {* VERIFICA SE EXISTE UM SUBMENU  *}
      {*******************************AF*}
      If Item[intContador].Count > 0 Then
      Begin
        If blnTemDireito Then
          pVerificaMenu(Item[intContador],trvNovo, pgbStatus)
        Else
          pVerificaMenu(Item[intContador],trvNovo, pgbStatus, False, False);
      End;

    End
    Else
    Begin

      If blnBarrinha Then
      Begin
        If mnuBarrinha = Nil Then
        Begin
          Item[intContador].Visible := True;
          blnBarrinha := False;
          mnuBarrinha := Item[intContador];
        End
        Else
        Begin
          mnuBarrinha := Item[intContador];
        End;
      End
      Else
      Begin
        Item[intContador].Visible := False;
      End;

    End;
  End;

  mnuConsultoriaFiscalSaneamento.Visible := fCfgSis('USASAN', varBoolean);
  mnuCashbackDevolucaoEmbalagem.Visible  := (fCfgSis('CBKUTI') = 'S') And (fCfgSis('DVECSH') = 'S');
  mnuFatCashback.Visible                 := mnuCashbackDevolucaoEmbalagem.Visible;
End;

procedure TfrmPrincipal.pVerificaMenusFixadosTintaMaquina;
begin
  If (VS_strUsaTmq <> 'S') Then
    Exit;

  If blnUsuarioLogadoUtilizaModoClassico And (mnuConfTintaMaquina.Parent = Nil) Then
    Exit;

  mnuConfTintaMaquina.Visible := fVerificaAcessoMenuTintas(mnuConfTintaMaquina.Hint, iTintasMaquina, mnuConfTintaMaquina.Name);

  If (mnuGlasurit <> Nil) Then
  Begin
    mnuGlasurit.Visible := fVerificaAcessoMenuTintas(mnuGlasurit.Hint, iTintasMaquina, mnuGlasurit.Name);

    If mnuGlasurit.Visible Then
    Begin
      mnuConfiguracoesGlasurit.Visible := fVerificaAcessoMenuTintas(mnuConfiguracoesGlasurit.Hint, iTintasMaquina, mnuConfiguracoesGlasurit.Name);
      mnuCadGlaBases.Visible           := fVerificaAcessoMenuTintas(mnuCadGlaBases.Hint, iTintasMaquina, mnuCadGlaBases.Name);
      mnuCadGlaNovasFormulas.Visible   := fVerificaAcessoMenuTintas(mnuCadGlaNovasFormulas.Hint, iTintasMaquina, mnuCadGlaNovasFormulas.Name);
      mnuCadGlaGeraArquivo.Visible     := fVerificaAcessoMenuTintas(mnuCadGlaGeraArquivo.Hint, iTintasMaquina, mnuCadGlaGeraArquivo.Name);
      mnuConsultaGlasurit.Visible      := fVerificaAcessoMenuTintas(mnuConsultaGlasurit.Hint, iTintasMaquina, mnuConsultaGlasurit.Name);
      mnuCadGlaGerNfm.Visible          := fVerificaAcessoMenuTintas(mnuCadGlaGerNfm.Hint, iTintasMaquina, mnuCadGlaGerNfm.Name);
    End;
  End;

  If (mnuSalcomix <> Nil) Then
  Begin
    mnuSalcomix.Visible := fVerificaAcessoMenuTintas(mnuSalcomix.Hint, iTintasMaquina, mnuSalcomix.Name);

    If mnuSalcomix.Visible Then
    Begin
      mnuConfiguracoesSalcomix.Visible := fVerificaAcessoMenuTintas(mnuConfiguracoesSalcomix.Hint, iTintasMaquina, mnuConfiguracoesSalcomix.Name);
      mnuCadSalBases.Visible           := fVerificaAcessoMenuTintas(mnuCadSalBases.Hint, iTintasMaquina, mnuCadSalBases.Name);
      mnuCadSalNovasFormulas.Visible   := fVerificaAcessoMenuTintas(mnuCadSalNovasFormulas.Hint, iTintasMaquina, mnuCadSalNovasFormulas.Name);
      mnuCadSalGeraArquivo.Visible     := fVerificaAcessoMenuTintas(mnuCadSalGeraArquivo.Hint, iTintasMaquina, mnuCadSalGeraArquivo.Name);
      mnuConsultaSalcomix.Visible      := fVerificaAcessoMenuTintas(mnuConsultaSalcomix.Hint, iTintasMaquina, mnuConsultaSalcomix.Name);
      mnuCadSalGerNfm.Visible          := fVerificaAcessoMenuTintas(mnuCadSalGerNfm.Hint, iTintasMaquina, mnuCadSalGerNfm.Name);
    End;
  End;
end;

procedure TfrmPrincipal.pVerificaMenuTintaMaquina(Item: TMenuItem);
Var
  IntContador : Integer;
begin
  For intContador := 0 To Item.Count - 1 Do
  Begin
    If Item[intContador].Tag = 0 Then
    Begin
      Item[intContador].Visible := fVerificaAcessoMenuTintas(Item[intContador].Hint, iTintasMaquina, Item[intContador].Name);
      If Item[intContador].Visible Then
        Item[intContador].Visible := fVerificaAcessoGeracaoTintas(Item[intContador].Caption);

      If Item[intContador].Count > 0 Then
        pVerificaMenuTintaMaquina(Item[intContador]);
    End;
  End;
end;

procedure TfrmPrincipal.pVerificarAutcomIniciadoModoRobo;
begin
  blnImprimeEtiquetaGondolaComPreco := False;

  If ParamCount > 0 Then
  Begin
    blnGerSfaMob := SameText(ParamStr(1), 'SFAMOBILEEXPORTACAO');
    blnGerSfaEst := SameText(ParamStr(1), 'SFAMOBILEEXPESTOQUE');
    blnAutoGiro  := SameText(ParamStr(1), 'AUTOGIRO');
    blnExpAcacia := SameText(ParamStr(1), 'EXPACACIA');
    blnAutoEntTE := SameText(ParamStr(1), 'AUTOENTTE');
    blnAutoConEnt:= SameText(ParamStr(1), 'AUTOCONENT');
    blnImpAcacia := SameText(ParamStr(1), 'IMPACACIA');
    blnConAjuMot := SameText(ParamStr(1), 'COLETOR-MOTOROLA');
    blnMotorConf := SameText(ParamStr(1), 'COLETOR-MOTOROLA-CONF');
    blnConAjuCom := SameText(ParamStr(1), 'COLETOR-COMPEX260');
    blnCompeConf := SameText(ParamStr(1), 'COLETOR-COMPEX260-CONF');
    blnGerImpPdv := SameText(ParamStr(1), 'IMPORTA-PDV');
    blnGerImpCTe := SameText(ParamStr(1), 'IMPORTA-CTE');
    blnExpMotorola:= SameText(ParamStr(1), 'EXPEDICAO_MOTOROLA');
    blnExpGeoSales:= SameText(UpperCase(ParamStr(1)), 'GEOSALES_EXPORTAR');
    blnImpGeoSales:= SameText(UpperCase(ParamStr(1)), 'GEOSALES_IMPORTAR');
    blnGerExpPre := SameText(ParamStr(1), 'EXP-PRECO-CONSULTA');
    blnGerExpPreGertec := SameText(ParamStr(1), 'EXP-PRECO-CONSULTA-GERTEC');
    blnImprimePedido := SameText(ParamStr(1), 'IMPRIME_PEDIDO');
    blnImprimeSeparacao := SameText(ParamStr(1), 'IMPRIME_SEPARACAO');
    blnImprimeSeparacaoFina := SameText(ParamStr(1), 'IMPRIME_SEPARACAO_FINA');
    blnEnviaPLP_WMS := SameText(ParamStr(1), 'ENVIA_PLP_WMS');
    blnVendaAssistida := SameText(ParamStr(1), 'VENDA_ASSISTIDA');
    blnAcaoAutomaticaCRM := SameText(ParamStr(1), 'ACAO_AUTOMATICA_CRM');
    blnDisparaEmailAutEnt:= SameText(ParamStr(1), 'DISP_EMAIL_AUTENT');
    blnDisparaEmailPedidoCompra := SameText(ParamStr(1), 'DISP_EMAIL_PEDIDO_COMPRA');
    blnExpTigre := SameText(UpperCase(ParamStr(1)), 'EXPORTACAO_TIGRE');
    blnExpRelatorio := SameText(UpperCase(ParamStr(1)), 'EXPORTACAO_RELATORIO');
    blnDefinirLotesWMS := SameText(ParamStr(1), spLotWMSMonitorExeParam);
    blnFaturamentoAutomatico := SameText(ParamStr(1), FaturamentoAutomaticoMonitorExeParam);
    blnCanceladorAutomatico := SameText(ParamStr(1), CanceladorAutomaticoMonitorExeParam);
    blnNotificacoesMonitor := SameText(ParamStr(1), NotificacoesMonitorMonitorExeParam);
    blnDesmembramentoPedidoPIX := SameText(ParamStr(1), DesmembramentoPedidoRecebidoPIXMonitorExeParam);
    blnGatilhosInformacao := SameText(ParamStr(1), GatilhosInformacaoMonitorExeParam);
    blnGatilhosImediatos := SameText(ParamStr(1), GatilhosImediatosMonitorExeParam);
    blnConsultaPrecoTintas := SameText(ParamStr(1), MonitorConsultaPrecoTintaParam);
    blnSpedFiscal := SameText(ParamStr(1), SPED_FISCAL_PARAM);
    blnSpedPisCofins := SameText(ParamStr(1), SPED_PIS_COFINS_PARAM);
    VS_AutoatendimentoPagueFacil    := SameText(ParamStr(1), 'AUTOATENDIMENTO_PAGUE_FACIL');
    VS_AutoatendimentoConsultaPreco := SameText(ParamStr(1), 'AUTOATENDIMENTO_CONSULTA_PRECO');
    VS_AutoatendimentoBuscaFacil    := SameText(ParamStr(1), 'AUTOATENDIMENTO_BUSCA_FACIL');
    blnExpHenkel := SameText(ParamStr(1), 'EXPORTACAO_HENKEL');
    blnAutoTransfEmpCar := SameText(ParamStr(1), 'AUTOTRANSFEMPCAR');
    blnNumSerSAT := SameText(ParamStr(1), 'NUMERO_SERIE_SAT');
    blnImprimeEtiquetaGondolaComPreco := SameText(ParamStr(1), 'IMPRIMIR_ETIQUETA_GONDOLA_COM_PREÇO');
    blnImprimeEtiquetaMontagemCaixa := SameText(ParamStr(1), 'IMPRIMIR_ETIQUETA_MONTAGEM_CAIXA');
    blnImprimeEtiquetaVolume := SameText(ParamStr(1), 'IMPRIME_ETIQUETA_VOLUME');
    blnImprimeEtiquetaDespacho := SameText(ParamStr(1), 'IMPRIME_ETIQUETA_DESPACHO');
    blnImprimeEtiquetaBoxPedido := SameText(Copy(ParamStr(1),1,27), 'IMPRIME_ETIQUETA_BOX_PEDIDO');
  End
  Else
  Begin
    blnGerSfaMob := False;
    blnGerSfaEst := False;
    blnAutoGiro  := False;
    blnAutoEntTE := False;
    blnAutoConEnt:= False;
    blnExpAcacia := False;
    blnImpAcacia := False;
    blnConAjuMot := False;
    blnMotorConf := False;
    blnConAjuCom := False;
    blnCompeConf := False;
    blnGerImpPdv := False;
    blnGerImpCTe := False;
    blnExpMotorola := False;
    blnExpGeoSales:= False;
    blnImpGeoSales:= False;
    blnGerExpPre := False;
    blnGerExpPreGertec := False;
    blnImprimePedido := False;
    blnImprimeSeparacao := False;
    blnImprimeSeparacaoFina := False;
    blnEnviaPLP_WMS := False;
    blnVendaAssistida := False;
    blnAcaoAutomaticaCRM := False;
    blnDisparaEmailAutEnt:= False;
    blnDisparaEmailPedidoCompra := False;
    blnExpTigre := False;
    blnExpRelatorio := False;
    blnDefinirLotesWMS := False;
    blnFaturamentoAutomatico := False;
    blnCanceladorAutomatico := False;
    blnNotificacoesMonitor := False;
    blnDesmembramentoPedidoPIX := False;
    blnGatilhosInformacao := False;
    blnGatilhosImediatos := False;
    blnConsultaPrecoTintas := False;
    blnSpedPisCofins := False;
    blnSpedFiscal := False;
    VS_AutoatendimentoPagueFacil    := False;
    VS_AutoatendimentoConsultaPreco := False;
    VS_AutoatendimentoBuscaFacil    := False;
    blnExpHenkel := False;
    blnAutoTransfEmpCar := False;
    blnNumSerSAT := False;
    blnImprimeEtiquetaMontagemCaixa := False;
    blnImprimeEtiquetaVolume := False;
    blnImprimeEtiquetaDespacho := False;
    blnImprimeEtiquetaBoxPedido := False;
  End;

  VS_AutcomIniciadoModoRobo :=
                (blnGerSfaMob  Or
                 blnImpSfaMob  Or
                 blnAutoGiro   Or
                 blnAutoEntTE  Or
                 blnAutoConEnt Or
                 blnExpAcacia     Or
                 blnImpAcacia     Or
                 blnMotorConf     Or
                 blnConAjuMot     Or
                 blnConAjuCom     Or
                 blnGerSfaEst     Or
                 blnCompeConf     Or
                 blnGerImpPdv     Or
                 blnGerImpCTe     Or
                 blnExpGeoSales   Or
                 blnImpGeoSales   Or
                 blnGerExpPre     Or
                 blnGerExpPreGertec Or
                 blnImpMovMe      Or
                 blnImprimePedido Or
                 blnImprimeEtiquetaGondolaComPreco Or
                 blnEnviaPLP_WMS  Or
                 blnImprimeSeparacao Or
                 blnImprimeSeparacaoFina Or
                 blnVendaAssistida Or
                 blnAcaoAutomaticaCRM Or
                 blnExpTigre Or
                 blnExpRelatorio Or
                 blnDisparaEmailAutEnt Or
                 blnDisparaEmailPedidoCompra Or
                 blnDefinirLotesWMS Or
                 blnFaturamentoAutomatico Or
                 blnCanceladorAutomatico Or
                 blnNotificacoesMonitor Or
                 blnDesmembramentoPedidoPIX Or
                 blnGatilhosInformacao Or
                 blnGatilhosImediatos Or
                 blnConsultaPrecoTintas Or
                 blnSpedPisCofins Or
                 blnSpedFiscal Or
                 VS_AutoatendimentoPagueFacil Or
                 VS_AutoatendimentoConsultaPreco Or
                 VS_AutoatendimentoBuscaFacil Or
                 blnYapay Or
                 blnExpHenkel Or
                 blnAutoTransfEmpCar Or
                 blnImprimeEtiquetaMontagemCaixa Or
                 blnImprimeEtiquetaVolume Or
                 blnImprimeEtiquetaDespacho Or
                 blnImprimeEtiquetaBoxPedido);
end;

procedure TfrmPrincipal.pVerificaSincronizacaoEmail;
begin
  If TListaThreadsSincronizaEmails.GetInstance.QuantidadeThreads > 0 Then
    TListaThreadsSincronizaEmails.GetInstance.pRemoveSincronizacoesConcluidas;
end;

{ Mostra na tela de carga o andamento da atualizacao de arquivos da estacao
  (Req. 456190, Fase 6, RN34).

  Reaproveita a barra que a carga do TEF JA usa, em vez de abrir um
  TfrmGravando proprio: a rotina inteira ja roda dentro de
  fChamaTelaGravando (pVerificaTEFCitel, logo abaixo), e uma segunda janela
  modal apareceria por cima da tela que ja esta ali.

  AintTotal = 0 e etapa sem progresso mensuravel - consulta a estacao,
  espera o servico voltar - e ai so o texto muda. }
procedure TfrmPrincipal.pStatusCargaTefCitel(const AstrTexto: String;
  const AintFeito, AintTotal: Integer);
begin
  { GUARDA DE THREAD, pelo mesmo motivo do fConfirmaTomadaPinpadTefEvent
    (apontamento do DelphAI, 2026-09-25). Este tambem e um callback stdcall
    registrado na DLL (TprocProgressoAtualizacaoTef) e toca VCL: Properties.Max,
    Position e pProcessMessages. Hoje a DLL chama na thread principal; o dia em
    que o download/unzip virar thread de fundo, tocar VCL de la e AV.

    Sai calado, e nao com log como o irmao: la e decisao unica com consequencia
    de seguranca; aqui e progresso, chamado muitas vezes por carga - logar cada
    uma inundaria o arquivo. Perder o avanco da barra nao quebra a atualizacao. }
  if TThread.CurrentThread.ThreadID <> MainThreadID then
    Exit;

  if not Assigned(FpgbProgressoTefCitel) then
    Exit;

  { Nesta linha o pStepStatusGravacao tem SO DOIS parametros - o blnStep
    (que no 74.150 permite nao avancar a barra) nao existe aqui, e o
    incremento e incondicional. Efeito: nas etapas sem progresso
    mensuravel a barra anda um passo a mais. E cosmetico; a alternativa
    seria mexer no untFuncoesSimples desta revisao fechada. }
  if AintTotal <= 0 then
  begin
    pStepStatusGravacao(FpgbProgressoTefCitel, AstrTexto);
    pProcessMessages;
    Exit;
  end;

  { So refaz o Max quando ele muda - trocar de pacote. pInfoStatusGravacao
    zera a Position, entao chama-lo a cada parte faria a barra piscar do
    inicio o tempo todo. }
  if FpgbProgressoTefCitel.Properties.Max <> AintTotal then
    pInfoStatusGravacao(FpgbProgressoTefCitel, AstrTexto, AintTotal)
  else
    pStepStatusGravacao(FpgbProgressoTefCitel, AstrTexto);

  FpgbProgressoTefCitel.Position := AintFeito;
  pProcessMessages;
end;

procedure TfrmPrincipal.pVerificaTEFCitel;
begin
  try
    fChamaTelaGravando(fIniciarTefCitel);
  finally
    Self.Enabled := True;
    SetForegroundWindow(Handle);
  end;
end;

procedure TfrmPrincipal.mnuTransfCodEventoClick(Sender: TObject);
begin
  pTransfCod(TransfCodEvento);
end;

procedure TfrmPrincipal.pVerificaTEF;
  Var
    objTefRecebimento: ITefRecebimento;
begin
  If Not VS_AutoatendimentoPagueFacil Then
    If (blnGerImpPdv) Or (blnGerImpCTe) Or (fOpcoesIgnorar) Or (blnYapay) or (fAutComEmModoImportacao) Then
      Exit;

  {***************************************}
  {* VERIFICA SE EXISTE PENDENCIA NO TEF *}
  {************************************AF*}
  If (Not blnVerificaTef) And ((Assigned(VS_objTef)) Or (VS_blnTefCitel)) Then
  Begin
    blnVerificaTef := True;
    Try
      If (VS_blnTefCitel) then
      Begin
        pVerificaTEFCitel;
      End
      Else If (VS_strUsaTef = 'S') Then
      Begin
        If VS_objTef.fTef_Atv Then
        Begin
          Self.Enabled := False;

          objTefRecebimento := fCriarTefRecebimento(VS_objTef);
          objTefRecebimento.fVerificaPendencias;

          VS_objTef.fPendenciaTEF;
          Self.Enabled := True;
          SetForegroundWindow(Handle);
        End;

      End;

    Finally
      pnlMenTef.Caption := '';
      pnlMenTef.Refresh;

      {$IFDEF TESTABILIDADE_AUTCOM}
      //não utiliza quando Teste Automatizado
      {$Else}
      If Not blnUsuarioLogadoUtilizaModoClassico Then
        Principal.View.FMXPrincipal.MostraMensagemTEF('');
      {$ENDIF}
    End;

  End;

end;

function TfrmPrincipal.Recentes: IRecentesAutcom;
begin
  Result := TRecentesAutcom.New(fraPesquisarMenu.popRecentes);
end;

procedure TfrmPrincipal.ReimpressodeSeparao1Click(Sender: TObject);
begin
  TGerenciaMovimentacaoGondola.ReimpressaoDeSeparacao;

end;

function TfrmPrincipal.RetornaTodos: IResultadoPesquisaAutcom;
begin
  Result := fraPesquisarMenu.RetornaTodos();
end;

function TfrmPrincipal.Revisao: String;
  {$I rev.inc}
begin
  Result := SVN_REVISION;
end;

procedure TfrmPrincipal.frmImpPaginaClick(Sender: TObject);
begin
    pCriarForm(TfrmImpPagina);
end;

procedure TfrmPrincipal.fraPesquisarMenubtnDashboardClick(Sender: TObject);
begin
  mnuDashboardClick(mnuDashboard);
end;

procedure TfrmPrincipal.frmAlterarPaginaRevistaClick(Sender: TObject);
begin
  pCriarForm(TfrmAlterarPaginaRevista);
end;

function TfrmPrincipal.RunningInTSPlus: Boolean;
begin
  Result := untFuncoesSimples.RunningInTSPlus;
end;

procedure TfrmPrincipal.pExibeMenu(Item: TMenuItem);
  Var
    IntContador : Integer;
Begin

  For intContador := 0 To Item.Count-1 Do
  Begin

    If Item[intContador].Tag = 0 Then
    Begin
      Item[intContador].Visible := True;
      Item[intContador].Enabled := True;

      If Item[intContador].Count > 0 Then
        pExibeMenu(Item[intContador]);
    End;

  End;

End;

procedure TfrmPrincipal.pExibeMenu(Item: TMenuItem; blnHabilitaDesabilita: Boolean; strSomentoOsSubMenus: String);
  Var
    IntContador : Integer;
Begin
  Item.Tag := IIF(blnHabilitaDesabilita, 0, 1);    
  Item.Visible := blnHabilitaDesabilita;
  Item.Enabled := blnHabilitaDesabilita;

  If (Item.Count > 0) Then
  Begin
    For intContador := 0 To Item.Count-1 Do
    Begin
      If (Pos(Item[intContador].Name, strSomentoOsSubMenus) > 0) Then
        pExibeMenu(Item[intContador], True, strSomentoOsSubMenus)
      Else
        pExibeMenu(Item[intContador], False, strSomentoOsSubMenus)
    End;
  End;
End;

procedure TfrmPrincipal.pExibeNotificacaoQtdMensagens(const intNroMsg: Integer);
begin
  Application.ProcessMessages;
  pnlNotificacao.Visible := intNroMsg > 0;
  lblNotificacao.Caption := IntToStr(intNroMsg);
  shNotificacao.Repaint;
  Application.ProcessMessages;
end;

{**********************************}
{* PROCESSA O MENU PARA VERIFI-   *}
{* CAO DE ACESSOS               *}
{*******************************AF*}
procedure TfrmPrincipal.pProcessaMenu(pgbStatus: TcxProgressBar = Nil);
  Var
    intContador: Integer;
    trvItem: TTreeNode;
    blnLibCom: Boolean;
    blnUsaCtc: Boolean;
    blnUsaAtb: Boolean;
    blnUsaDAS: Boolean;
    objCadLot: TCadLot;
    blnUTCDDE: Boolean;

    function fCfgSisLoc(const strCamCfg: String; varTipVar: TVarType = varString) : Variant;
    Begin
      Result := fCfgSis(strCamCfg, varTipVar);
    End;

Begin
  If fEmptyStr(VS_strCodEmp) Then
    Exit;

  trvItem := Nil;

  pnlFundo.Color := fRetCorEmpresa(VS_strCodEmp);

  imgLogoDark.Visible  := IsLightTheme;
  imgLogoLight.Visible := Not imgLogoDark.Visible;

  pAtualizaQuadroLicencas;

  If fEhEmpresaDARE Then
  Begin
    mnuDigGNRE.Caption := fTrocaNomeGNRE(True, mnuDigGNRE.Caption);
    mnuDigGNRE_EDIT.Caption := fTrocaNomeGNRE(True, mnuDigGNRE_EDIT.Caption);
  End;

  popProdutos.Items.Clear;

  mnuAutcomK.BeginUpdate;
  pExibeMenu(mnuAutcomK.Items);
  mnuAutcomK.EndUpdate;

  {*******************************************}
  {* RONALDO PEDIU PARA POR ENQUANTO DEIXAR  *}
  {* DESABILITADO.                           *}
  {****************************************AC*}
  mnuBackup.Visible := False;

  pHabilitarItemMenu(mnuCadEcf, (Not fCfgSisLoc('USNFCE', varBoolean)) And (Not fUsaSat) );
  mnuCadArmazemOperadores.Visible := fCfgSisLoc('CTRAMZ', varBoolean);

  mnuManutMultiLojaAposEntrada.Visible := fCfgSisLoc('PDCGTR', varBoolean);

  mnuAltGlobCadCartoes.Visible := not (fCfgSisLoc('CDCRNV', varBoolean));

  mnuPastaComprasExecAux.Visible  := (Pos(strLoginUsuarioLogado, '999_998_997') > 0 ) And (fCfgSisLoc('UTIPCM', varBoolean));

  mnuAlteracaoGeraldePrecosdeProdutos.Visible := fCfgSisLoc('ALTGLO', varBoolean);
  mnuEntradaAutomatizadaImportacao.Visible := fCfgSisLoc('PEDIMP', varBoolean);


  mnuEtiquetaDoProdutoSeparado.Visible := fCfgSisLoc('SEPRES', varBoolean);
  mnuEtiquetadoProdutoSeparado_QtdRestante.Visible := fCfgSisLoc('SEPRES', varBoolean);

  mnuAtualizacaoMargemParaFranquias.Visible := ((fCfgSis('HPRTFR') = 'S') And (Not fPreMat));
  mnuImportaoCustosRegimeTributrioFranquias.Visible := fCfgSis('HPRTFR') = 'S';

  mnuDescontoMaximoPorAtividade.Visible := (TipoOpcaoDeTrava = totDescontoMaximoPorAtividade);
  mnuDescontoMaximoPorAtividade.Tag     := IIF(mnuDescontoMaximoPorAtividade.Visible, 0, 1);

  mnuMargemMinimaPorAtividade.Visible   := (TipoOpcaoDeTrava = totMargemMinimaPorAtividade);
  mnuMargemMinimaPorAtividade.Tag       := IIF(mnuMargemMinimaPorAtividade.Visible, 0, 1);

  mnuPainelFusion.Visible := fCfgSis('FUSUSA', varBoolean);
  mnuPainelFusion.Tag     := IIF(mnuPainelFusion.Visible, 0, 1);

  mnuFatConfeEntDocNaoEntregues.Visible := fUtilizaConferenciaDocsRemovidosRomaneio;
  mnuFatConfeEntDocNaoEntregues.Tag     := IIF(mnuFatConfeEntDocNaoEntregues.Visible, 0, 1);

  mnuConcorrentesParaPesquisaDeMercado.Visible := fCfgSis('PESMER', varBoolean);
  mnuConcorrentesParaPesquisaDeMercado.Tag     := IIF(mnuConcorrentesParaPesquisaDeMercado.Visible, 0, 1);

  If (Not fCfgSisLoc('USNFCE', varBoolean)) And fUsaSat Then
  Begin
    mnuFatSATComplementar.Visible := True;
    mnuFatSATComplementar.Tag     := 0;
  End
  Else
  Begin
    mnuFatSATComplementar.Visible := False;
    mnuFatSATComplementar.Tag     := 1;
  End;

  If fCfgSis('GATINF', varBoolean) Then
  Begin
    mnuGatilhosInformacao.Visible := True;
    mnuGatilhosInformacao.Tag     := 0;
  End
  Else
  Begin
    mnuGatilhosInformacao.Visible := False;
    mnuGatilhosInformacao.Tag     := 1;
  End;

  If (fVerificaAcessoSistema(mnuCitelDesk.Hint)) and (fCfgSis('URLWPP', varString) <> EmptyStr) Then
  Begin
    mnuCitelDesk.Visible := True;
    mnuCitelDesk.Tag     := 0;
  End
  Else
  Begin
    mnuCitelDesk.Visible := False;
    mnuCitelDesk.Tag     := 1;
  End;

  If fCfgSisLoc('SUFRAM', varBoolean) Then
  Begin
    mnuDigTCIF.Visible      := True;
    mnuDigTS.Visible        := True;
    mnuDigTCIF_EDIT.Visible := True;
    mnuDigTS_EDIT.Visible   := True;
  End
  Else
  Begin
    mnuDigTCIF.Visible      := False;
    mnuDigTS.Visible        := False;
    mnuDigTCIF_EDIT.Visible := False;
    mnuDigTS_EDIT.Visible   := False;
  End;
  mmuRelCtrReceber.Visible := fCfgSisLoc('REL_CC', varBoolean);
  mnuAjusteEstoqueSaldoExterno.Visible := fCfgSisLoc('ESTEXT', varBoolean);


  mnuRestauraPreco.Visible := fConfiguracaoAtivaTriggerPreAlt;
  mnuOutrasDespesasAposEntrada.Visible := (fCfgSis('HODAEM', varInteger) > 0);

  mnuLiberacaoCNPJ.Visible := fCfgSis('CSDENE', varBoolean);
  mnuLiberacaoCNPJ.Tag     := IIF(mnuLiberacaoCNPJ.Visible, 0, 1);

  If VS_SpoolImpressaoCitel Then
  Begin
    mnuSpoolImpressao.Visible := True;
    mnuSpoolImpressao.Tag     := 0;
  End Else
  Begin
    mnuSpoolImpressao.Visible := False;
    mnuSpoolImpressao.Tag     := 1;
  End;

  If fCfgSisLoc('CADIMP', varBoolean) And Not VS_SpoolImpressaoCitel Then
  Begin
    mnuCadImpressoras.Visible := True;
    mnuCadImpressoras.Tag     := 0;

    mnuCadIdentificacaoImpressora.Visible := True;
    mnuCadIdentificacaoImpressora.Tag     := 0;
  End Else
  Begin
    mnuCadImpressoras.Visible := False;
    mnuCadImpressoras.Tag     := 1;

    mnuCadIdentificacaoImpressora.Visible := False;
    mnuCadIdentificacaoImpressora.Tag     := 1;
  End;

  If fCfgSisLoc('USAPAR', varBoolean) Then
  Begin
    mnuCadParceiros.Visible := True;
    mnuCadParceiros.Tag     := 0;
  End Else
  Begin
    mnuCadParceiros.Visible := False;
    mnuCadParceiros.Tag     := 1;
  End;

  If fCfgSisLoc('LIBETE') = '2' Then
  Begin
    mnuLiberaPrepTE.Tag     := 0;
    mnuLiberaPrepTE.Visible := True;
  End Else
  Begin
    mnuLiberaPrepTE.Tag     := 1;
    mnuLiberaPrepTE.Visible := False;
  End;

  If fCfgSisLoc('CUPDES') = 'S' Then
  Begin
    mnuCadCupomDesconto.Tag     := 0;
    mnuCadCupomDesconto.Visible := True;
  End Else
  Begin
    mnuCadCupomDesconto.Tag     := 1;
    mnuCadCupomDesconto.Visible := False;
  End;

  if fCfgSisLoc('CLIBAT', varBoolean) Then
  Begin
    mnuCad800.Visible := True;
    mnuCad800.Tag     := 0;
  End
  Else
  Begin
    mnuCad800.Visible := False;
    mnuCad800.Tag     := 1;
  End;

  If fCfgSisLoc('SITPRO', varBoolean) Then
  Begin
    mnuCadSitProduto.Tag     := 0;
    mnuCadSitProduto.Visible := True;
  End Else
  Begin
    mnuCadSitProduto.Tag     := 1;
    mnuCadSitProduto.Visible := False;
  End;

  If fCfgSisLoc('MOEXSI') <> '0' Then
  Begin
    mnuManECommerce.Tag     := 0;
    mnuManECommerce.Visible := True;
  End Else
  Begin
    mnuManECommerce.Tag     := 1;
    mnuManECommerce.Visible := False;
  End;

  If fUsaPedidoBaixaEntregaFutura Then
  Begin
    mnuFatDevolucaoBaixaEntFut.Tag     := 0;
    mnuFatDevolucaoBaixaEntFut.Visible := True;
  End Else
  Begin
    mnuFatDevolucaoBaixaEntFut.Tag     := 1;
    mnuFatDevolucaoBaixaEntFut.Visible := False;
  End;

  If fCfgSis('ORDPRO', varBoolean) Then
  Begin
    mnuImpEtiOrdPro.Visible := True;
    mnuImpEtiOrdPro.Tag     := 0;
  End
  Else
  Begin
    mnuImpEtiOrdPro.Visible := False;
    mnuImpEtiOrdPro.Tag     := 1;
  End;

  if fCfgSis('OUSAFO', varString) = '1' Then
  Begin
    mnuConfirmaEspelho.Visible := False;
    mnuConfirmaEspelho.Tag     := 1;
  End
  Else
  Begin
    mnuConfirmaEspelho.Visible := True;
    mnuConfirmaEspelho.Tag     := 0;
  End;


  mnuAvaliacaoGarantiaPropriaEmpresa.Visible :=  fCfgSis('GARIND', varString) = 'S';
  mnuAvaliacaoGarantiaPropriaEmpresa.Tag := IIf(mnuAvaliacaoGarantiaPropriaEmpresa.Visible, 0 , 1);

  if fCfgSis('CHKLGA', varString)  = 'S' then
  begin
    mnuCadAssistenciaTecnica.Visible := True;
    mnuChecklistValidacaoGarantia.Visible := True;
  end
  else begin
    mnuCadAssistenciaTecnica.Visible := False;
    mnuChecklistValidacaoGarantia.Visible := False;
  end;

  mnuCadAssistenciaTecnica.Tag := iif(mnuCadAssistenciaTecnica.Visible, 0,1);
  mnuChecklistValidacaoGarantia.Tag := iif(mnuChecklistValidacaoGarantia.Visible, 0,1);

  mnuCadCotacaoMoeda.Visible := fCfgSis('COTDOR', VarBoolean);
  mnuCadCotacaoDiariaCombustiveis.Visible := fCfgSis('QLPUSA', VarBoolean);

  If fCfgSisLoc('PAGREV', varBoolean) Then
  Begin
    frmAlterarPaginaRevista.Visible := True;
    frmImpPagina.Visible := True;
  End
  Else
  Begin
    frmAlterarPaginaRevista.Visible := False;
    frmImpPagina.Visible := False;
  End;

  If fCfgSisLoc('UTIIND', varBoolean) Then
  Begin
    mnuIndustrial.Visible := True;
    mnuIndustrial.Tag     := 0 ;

    mnuRELOPI.Tag := 0;
    mnuRELOPI.Visible := True;

    mnuTransCodCorIndustrial.Tag := 0;
    mnuTransCodCorIndustrial.Visible := True;

    mnuCadEquipamentosInd.Tag     := 0;
    mnuCadEquipamentosInd.Visible := True;

    If fCfgSis('MDORIN', VarString) = '3'Then
    Begin
      mnuCadPadraQualidadeInd.Tag     := 0;
      mnuCadPadraQualidadeInd.Visible := True;
      mnuManutencaoLoteMP.Tag         := 0;
      mnuManutencaoLoteMP.Visible     := True;
    End
    Else
    Begin
      mnuCadPadraQualidadeInd.Tag     := 1;
      mnuCadPadraQualidadeInd.Visible := False;
      mnuManutencaoLoteMP.Tag         := 1;
      mnuManutencaoLoteMP.Visible     := False;
    End;

    If fCfgSis('ARMAMO', varBoolean) Then
    Begin
      mnuCadLocFisAmostraProducao.Tag     := 0;
      mnuCadLocFisAmostraProducao.Visible := True;
    End
    Else
    Begin
      mnuCadLocFisAmostraProducao.Tag     := 1;
      mnuCadLocFisAmostraProducao.Visible := False;
    End;

    If (fCfgSis('MDORIN', varString) = '6') Then
    Begin
      mnuCadEpi.Tag     := 0;
      mnuCadEpi.Visible := True;
    End
    Else
    Begin
      mnuCadEpi.Tag     := 1;
      mnuCadEpi.Visible := False
    End;
  End Else
  Begin
    mnuRELOPI.Tag := 1;
    mnuRELOPI.Visible := False;

    mnuOrdProIndustrialEtq.Tag := 1;
    mnuOrdProIndustrialEtq.Visible := False;

    mnuIndustrial.Visible := False;
    mnuIndustrial.Tag      := 1;

    mnuTransCodCorIndustrial.Tag := 1;
    mnuTransCodCorIndustrial.Visible := False;

    If fCfgSis('QLDEST', varBoolean) then
    Begin
      mnuControledeQualidade.Tag     := 0;
      mnuControledeQualidade.Visible := True;
    End
    Else
    Begin
      mnuControledeQualidade.Tag     := 1;
      mnuControledeQualidade.Visible := False;
    End;

  End;

  If fVerificaAcessoSistema(mnuFechamentoFinanceiro.Hint) Then
  Begin
    mnuFechamentoFinanceiro.Tag     := 0;
    mnuFechamentoFinanceiro.Visible := True;
  End
  Else
  Begin
    mnuFechamentoFinanceiro.Visible := False;
    mnuFechamentoFinanceiro.Tag     := 1;
  End;

  If fCfgSisLoc('CORROP', varString) = 'N' Then
  Begin
    If fVerificaAcessoSistema('PCCOPI', strLoginUsuarioLogado) Then
    Begin
      mnuCadCorrecaoOrdProducaoIndustrial.Tag     := 0;
      mnuCadCorrecaoOrdProducaoIndustrial.Visible := True;
    End
    Else
    Begin
      mnuCadCorrecaoOrdProducaoIndustrial.Visible := False;
      mnuCadCorrecaoOrdProducaoIndustrial.Tag     := 1;
    End;
  End
  Else
  Begin
    mnuCadCorrecaoOrdProducaoIndustrial.Visible := False;
    mnuCadCorrecaoOrdProducaoIndustrial.Tag     := 1;
  End;


  If fCfgSis('UCLVEN', varBoolean) Then
  Begin
    mnuCadCliVen.Visible := True;
    mnuCadCliVen.Tag     := 0;
  End
  Else
  Begin
    mnuCadCliVen.Visible := False;
    mnuCadCliVen.Tag     := 1;
  End;


  If fCfgSisLoc('FASOBR', varBoolean) Then
  Begin
    mnuCadFasObr.Visible := True;
    mnuCadFasObr.Tag     := 0;
  End
  Else
  Begin
    mnuCadFasObr.Visible := False;
    mnuCadFasObr.Tag     := 1;
  End;

  If fCfgSis('CLIDMP') = '2' Then
    mnuFatDesmembrarPedido.Caption := 'Desmembramento de corte de pedido de venda por falta de estoque'
  Else
    mnuFatDesmembrarPedido.Caption := 'Desmembramento de Orçamento/Pedido';

  objCadLot := TCadLot.Create(Self);
  If fCfgSisLoc('CTLEST') = '2' Then
  Begin
    mnuCadLoteItens.Caption := 'Produtos - ' + objCadLot.strTitLbs;
    mnuTransfArmazens.Caption := 'Transferência de Estoque entre Armazéns';

    mnuLiberacaoTransferenciaArmazem.Tag     := 0;
    mnuLiberacaoTransferenciaArmazem.Visible := fCfgSis('TRAMZ2') = 'S';

    mnuBalancoIniciaArmazem.Tag     := 0;
    mnuBalancoIniciaArmazem.Visible := TRUE;

    mnuBalancoFinalizaArmazem.Tag     := 0;
    mnuBalancoFinalizaArmazem.Visible := TRUE;
    mnuConfTransfArmazens.Visible := fCfgSis('TRAMZ2') = 'C';
    mnuTransfArmazensProdutoAcabado.Visible := (mnuConfTransfArmazens.Visible)
      And (fCfgSis('UTIIND') = 'S');
  End Else
  Begin
    mnuTransfArmazens.Caption := 'Transferência de Estoque entre Lotes';

    mnuBalancoIniciaArmazem.Tag     := 1;
    mnuBalancoIniciaArmazem.Visible := FALSE;

    mnuBalancoFinalizaArmazem.Tag     := 1;
    mnuBalancoFinalizaArmazem.Visible := FALSE;

    mnuLiberacaoTransferenciaArmazem.Tag     := 1;
    mnuLiberacaoTransferenciaArmazem.Visible := False;

  End;


  if fCfgSis('RASIND', varInteger) = 2 then
  begin

    mnuCadLoteItens.Tag     := 1;
    mnuCadLoteItens.Visible := False;

    mnuCadLoteItensRapido.Tag     := 1;
    mnuCadLoteItensRapido.Visible := False;

  end
  else begin
    mnuCadLoteItens.Tag     := 0;
    mnuCadLoteItens.Visible := True;

    mnuCadLoteItensRapido.Tag     := 0;
    mnuCadLoteItensRapido.Visible := True;
  end;

  if fCfgSis('CADRAS', varBoolean) then
  begin
    mnuProdutoCadastroRapidoLoteRastreamento.Tag := 0;
    mnuProdutoCadastroRapidoLoteRastreamento.Visible := True;
  end
  else begin
    mnuProdutoCadastroRapidoLoteRastreamento.Tag := 1;
    mnuProdutoCadastroRapidoLoteRastreamento.Visible := False;
  end;

  mnuFatAltLoteItem.Caption := Format(mnuFatAltLoteItem.Caption, [objCadLot.strTitLab]);

  VS_strTitLot := objCadLot.strTitLab;
  VS_strTitLts := objCadLot.strTitLbs;
  VS_strLotImp := objCadLot.strTitImp;

  FreeAndNil(objCadLot);

  If fCfgSisLoc('TABPRF', varBoolean) Then
  Begin
    mnuCadTabelaPrecos.Tag     := 0;
    mnuCadTabelaPrecos.Visible := True;

    mnuRelEstComparativoPrecosFornec.Tag     := 0;
    mnuRelEstComparativoPrecosFornec.Visible := True;
  End Else
  Begin
    mnuCadTabelaPrecos.Tag     := 1;
    mnuCadTabelaPrecos.Visible := False;

    mnuRelEstComparativoPrecosFornec.Tag     := 1;
    mnuRelEstComparativoPrecosFornec.Visible := False;
  End;

  mnuTranferenciaPedidoMultiLoja.Visible := fCfgSis('PDCGTR', varBoolean);


  If fCfgSisLoc('CADMON', varBoolean) Then
  Begin
    mnuCadMontadoras.Tag     := 0;
    mnuCadMontadoras.Visible := True;
  End Else
  Begin
    mnuCadMontadoras.Tag     := 1;
    mnuCadMontadoras.Visible := False;
  End;

  If fCfgSisLoc('CADLOC', varBoolean) Then
  Begin
    mnuCadLocFisica.Tag     := 0;
    mnuCadLocFisica.Visible := True;
  End Else
  Begin
    mnuCadLocFisica.Tag     := 1;
    mnuCadLocFisica.Visible := False;
  End;

  If fCfgSisLoc('CTLEST') = '2' Then
  Begin
    mnuCadArmazem.Tag     := 0;
    mnuCadArmazem.Visible := True;
  End Else
  Begin
    mnuCadArmazem.Tag     := 1;
    mnuCadArmazem.Visible := False;
  End;

  If Not fCfgSisLoc('UTIPCM', varBoolean) Then
  Begin
    mnuCadBandeiraEmpresa.Visible         := False;
    mnuCadParametrosEmpresa.Visible       := False;
    mnuPastaCompraConsulta.Visible        := False;
    mnuCadLimiteComprasFornecedor.Visible := False;
  End;

  If fCfgSisLoc('CONAJU', varBoolean) Then
  Begin
    mnuFatConfirmacaoAjustes.Tag     := 0;
    mnuFatConfirmacaoAjustes.Visible := True;
  End Else
  Begin
    mnuFatConfirmacaoAjustes.Tag     := 1;
    mnuFatConfirmacaoAjustes.Visible := False;
  End;

    mnuTxtSfaMobImp.Visible := True;
    mnuTxtSfaMobImp.Tag     := 0;

    mnuImportacaoSfaMobAndroid.Visible := True;
    mnuImportacaoSfaMobAndroid.Tag     := 0;

  If fCfgSisLoc('USACND', varBoolean) And fCfgSisLoc('CNPVEN', varBoolean) Then
  Begin
    mnuCadVenCnd.Visible := True;
    mnuCadVenCnd.Tag     := 0;
  End Else
  Begin
    mnuCadVenCnd.Visible := False;
    mnuCadVenCnd.Tag     := 1;
  End;

  If Not fCfgSisLoc('EMICTE', varBoolean) Then
  Begin
    mnuManutencaoCte.Tag := 1;
    mnuManutencaoCte.Visible := False;
  End
  Else
  Begin
    mnuManutencaoCte.Tag := 0;
    mnuManutencaoCte.Visible := True;
  End;

  If Not fCfgSisLoc('SISCRE', varBoolean) Then
  Begin
    mnuReimpressaoCarnePagto.Tag := 1;
    mnuReimpressaoCarnePagto.Visible := False;
  End
  Else
  Begin
    mnuReimpressaoCarnePagto.Tag := 0;
    mnuReimpressaoCarnePagto.Visible := True;
  End;

  If Not fCfgSisLoc('LOTPRE', varBoolean) Then
  Begin
    mnuLotePrecosEfetivacao.Tag := 1;
    mnuLotePrecosEfetivacao.Visible := False;
  End
  Else
  Begin
    mnuLotePrecosEfetivacao.Tag := 0;
    mnuLotePrecosEfetivacao.Visible := True;
  End;

  If fCfgSisLoc('OPCCOM', varString) = 'FD' Then
  Begin
    mnuComissaoFaixaDescDepto.Tag := 0;
    mnuComissaoFaixaDescDepto.Visible := True;
  End
  Else
  Begin
    mnuComissaoFaixaDescDepto.Tag := 1;
    mnuComissaoFaixaDescDepto.Visible := False;
  End;

  If fCfgSisLoc('ANARES') = '1' Then
  Begin
    mnuRelEstatAnalResult.Tag           := 0;
    mnuRelEstatAnalResult.Visible       := True;

    mnuRelEstatAnalResultMovBan.Tag     := 1;
    mnuRelEstatAnalResultMovBan.Visible := False;
  End
  Else
  Begin
    mnuRelEstatAnalResult.Tag           := 1;
    mnuRelEstatAnalResult.Visible       := False;

    mnuRelEstatAnalResultMovBan.Tag     := 0;
    mnuRelEstatAnalResultMovBan.Visible := True;
  End;

  {***************************************}
  {* FAZ A VERIFICAO SE USA OU NAO O     *}
  {* CADASTRO DE CARTO DE CREDITO        *}
  {************************************MV*}
  blnUsaCtc := (fCfgSisLoc('USACTC', varBoolean));

  {***************************************}
  {* FAZ VERIFICAO SE USA AUTBAN         *}
  {************************************MV*}
  blnUsaAtb := (fCfgSisLoc('USAATB', varBoolean));

 If fCfgSisLoc('APUEDT') = 'S' Then
 Begin
   mnuRelFiscResumoApIcms.Visible := False;
 End Else
 Begin
   mnuRelFiscResumoApIcms.Visible := True;
 End;

 If fCfgSisLoc('COMEDT') = 'S' Then
 Begin
   mnuRelFatComVendedor.Visible := False;
 End Else
 Begin
   mnuRelFatComVendedor.Visible := True;
 End;

 If fCfgSisLoc('VPREDT') = 'S' Then
 Begin
   mnuRelFatListVenRep.Visible := False;
 End Else
 Begin
   mnuRelFatListVenRep.Visible := True;
 End;

  If (Not blnUsaCtc) Then
  Begin
    mnuCadCartoes.Tag   := 1;
    mnuContrCartoes.Tag := 1;

    mnuCadCartoes.Visible   := False;
    mnuContrCartoes.Visible := False;
  End
  Else
  Begin
    mnuCadCartoes.Tag   := 0;
    mnuContrCartoes.Tag := 0;

    mnuCadCartoes.Visible   := True;
    mnuContrCartoes.Visible := True;
  End;

  If (Not blnUsaAtb) Then
  Begin
    mnuDirAutBan.Tag    := 1;
    mnuGerLayoutBan.Tag := 1;

    mnuDirAutBan.Visible    := False;
    mnuGerLayoutBan.Visible := False;
  End
  Else
  Begin
    mnuDirAutBan.Tag    := 0;
    mnuGerLayoutBan.Tag := 0;

    mnuDirAutBan.Visible    := True;
    mnuGerLayoutBan.Visible := True;
  End;

  {*****************************************}
  {* VERIFICA SE UTILIZA ORDEM DE PRODUÇÃO *}
  {* PS: ISSO NAUM VAI SER FACIL AFFFFF    *}
  {**************************************AF*}
  If (fCfgSisLoc('ORDPRO', varBoolean)) Then
  Begin
    mnuOrdemProducao.Tag := 0;
    mnuOrdemProducao.Visible := True;

    mnuRELOPR.Tag := 0;
    mnuRELOPR.Visible := True;

    If (fCfgSisLoc('UTIIND', varBoolean)) Then
    begin
      mnuOrdemProducaoInd.Tag := 0;
      mnuOrdemProducaoInd.Visible := True;
    end
    else
    begin
      mnuOrdemProducaoInd.Tag := 1;
      mnuOrdemProducaoInd.Visible := False;
    end;

  End
  Else
  Begin
    mnuOrdemProducao.Tag := 1;
    mnuOrdemProducao.Visible := False;

    mnuRELOPR.Tag := 1;
    mnuRELOPR.Visible := False;

    mnuOrdemProducaoInd.Tag := 1;
    mnuOrdemProducaoInd.Visible := False;
  End;

  If fCfgSisLoc('REACTR', varBoolean) Then
  Begin
    mnuCTRReajuste.Tag := 0;
    mnuCTRReajuste.Visible := True;
  End
  Else
  Begin
    mnuCTRReajuste.Tag := 1;
    mnuCTRReajuste.Visible := False;
  End;

  {***********************************************}
  {* VERIFICA SE VAI TRABALHAR COM PROFISSIONAIS *}
  {********************************************LU*}
  If fCfgSisLoc('TCOPRO') <> '2' Then
  Begin
    If fCfgSisLoc('NROPRO') = '1' Then
    Begin
      mnuComissaoProfissionais.Tag := 1;
      mnuComissaoProfissionais.Visible := False;
    End
    Else
    Begin
      mnuComissaoProfissionais.Tag := 0;
      mnuComissaoProfissionais.Visible := True;
    End;
  End
  Else
  Begin
    mnuComissaoProfissionais.Tag := 1;
    mnuComissaoProfissionais.Visible := False;
  End;

  If (fCfgSisLoc('USACND', varBoolean)) Then
  Begin
    mnuCadCnd.Tag     := 0;
    mnuCadCnd.Visible := True;
  End
  Else
  Begin
    mnuCadCnd.Tag     := 1;
    mnuCadCnd.Visible := False;
  End;

  {*****************************************}
  {* VERIFICA SE DEVE EXIBIR MENU DE ECF   *}
  {**************************************MA*}
  If (fCfgSisLoc('USACUP', varBoolean)) Then
  Begin

    mnuGerImpFiscais.Tag     := 0;
    mnuGerImpFiscais.Visible := True;
  End
  Else
  Begin
    mnuGerImpFiscais.Tag     := 1;
    mnuGerImpFiscais.Visible := False;
  End;

  {*****************************************}
  {* VERIFICA SE DEVE EXIBIR CADASTRO DE   *}
  {* FORMAS DE PAGAMENTO                   *}
  {**************************************MA*}
  If (fCfgSisLoc('USAFPG', varBoolean)) Then
  Begin
    mnuCadFpg.Tag     := 0;
    mnuCadFpg.Visible := True;
  End
  Else
  Begin
    mnuCadFpg.Tag     := 1;
    mnuCadFpg.Visible := False;
  End;

  {*****************************************}
  {* VERIFICA SE DEVE EXIBIR CADASTRO DE   *}
  {* TIPOS DE ATENDIMENTO                  *}
  {**************************************MM*}
  If (fCfgSisLoc('TIPATE', varBoolean)) Then
  Begin
    mnuCadTipoAtendimento.Tag     := 0;
    mnuCadTipoAtendimento.Visible := True;
  End
  Else
  Begin
    mnuCadTipoAtendimento.Tag     := 1;
    mnuCadTipoAtendimento.Visible := False;
  End;

  If (fCfgSisLoc('USASER', varBoolean)) Then
  Begin
    mnuServicos.Tag := 0;
    mnuServicos.Visible := True;
    mnuConsultaServicos.Tag := 0;
    mnuConsultaServicos.Visible := True;

    If fCfgSisLoc('TIPNFS') = '2' Then
    Begin
      mnuFatVendaNormal.Caption  := 'Venda de Produtos';
      mnuFatVendaServico.Tag     := 0;
      mnuFatVendaServico.Visible := True;
      mnuNFSeSubstituicao.Visible:= fCfgSisLoc('NFSSUB', varBoolean);
    End
    Else
    Begin
      mnuFatVendaNormal.Caption  := 'Venda Normal';
      mnuFatVendaServico.Tag     := 1;
      mnuFatVendaServico.Visible := False;
      mnuNFSeSubstituicao.Visible:= False;
    End;

  End
  Else
  Begin
    mnuServicos.Tag := 1;
    mnuServicos.Visible := False;
    mnuConsultaServicos.Tag := 1;
    mnuConsultaServicos.Visible := False;
    mnuFatVendaServico.Tag     := 1;
    mnuFatVendaServico.Visible := False;
    mnuFatVendaNormal.Caption  := 'Venda Normal';
    mnuFatVendaServico.Tag     := 1;
    mnuFatVendaServico.Visible := False;
  End;

  If (fCfgSisLoc('UTI_TR', varBoolean)) Then
  Begin
    mnuFatTrocaMerc.Tag := 0;
    mnuFatTrocaMerc.Visible := True;
  End
  Else
  Begin
    mnuFatTrocaMerc.Tag := 1;
    mnuFatTrocaMerc.Visible := False;
  End;

  If (fCfgSisLoc('UTICON', varBoolean)) Then
  Begin
    mnuContabilidade.Tag := 0;
    mnuContabilidade.Visible := True;
  End
  Else
  Begin
    mnuContabilidade.Tag := 1;
    mnuContabilidade.Visible := False;
  End;

  If fCfgSis('DOMHAB') = 'S' Then
  Begin
    mnuIntegracaoDominioSistemas.Tag := 0;
    mnuIntegracaoDominioSistemas.Visible := True;
  End
  Else
  Begin
    mnuIntegracaoDominioSistemas.Tag := 1;
    mnuIntegracaoDominioSistemas.Visible := False;
  End;

  {************************************************}
  {*  MENUS CRM                                   *}
  {************************************************}
  pProcessaMenusCRM;

  {************************************************}
  {* VERIFICA SE USA CONFIRMAO DE CUPOM  FISCAL *}
  {*********************************************MV*}
  If (fCfgSisLoc('AUTCEN', varBoolean)) Then
  Begin
    mnuCadTipSer.Tag := 0;
    mnuCadTipSer.Visible := True;

    mnuCadStaSer.Tag := 0;
    mnuCadStaSer.Visible := True;

    mnuConsultaServicosAutocenter.Tag := 0;
    mnuConsultaServicosAutocenter.Visible := True;

    mnuAgendamentosProg.Tag := 0;
    mnuAgendamentosProg.Visible := True;

    mnuFatAltMecanico.Tag := 0;
    mnuFatAltMecanico.Visible := True;
  End
  Else
  Begin
    mnuCadTipSer.Tag := 1;
    mnuCadTipSer.Visible := False;

    mnuCadStaSer.Tag := 1;
    mnuCadStaSer.Visible := False;

    mnuConsultaServicosAutocenter.Tag := 1;
    mnuConsultaServicosAutocenter.Visible := False;

    mnuAgendamentosProg.Tag := 1;
    mnuAgendamentosProg.Visible := False;

    mnuFatAltMecanico.Tag := 1;
    mnuFatAltMecanico.Visible := False;
  End;

  {************************************************}
  {* VERIFICA SE USA CONFIRMAO DE CUPOM  FISCAL   *}
  {*********************************************MV*}
  If (fCfgSisLoc('USACIF', varBoolean)) Then
  Begin
    mnuFatConfCupomFiscal.Tag := 0;
    mnuFatConfCupomFiscal.Visible := True;
  End
  Else
  Begin
    mnuFatConfCupomFiscal.Tag := 1;
    mnuFatConfCupomFiscal.Visible := False;
  End;

  {************************************************}
  {* VERIFICA SE USA RELACIONAMENTO DE SEMELHANÇA *}
  {*********************************************LU*}
  If (fCfgSisLoc('UTISEM', varBoolean)) Then
  Begin
    mnuRelacSemelhanca.Tag := 0;
    mnuRelacSemelhanca.Visible := True;
  End
  Else
  Begin
    mnuRelacSemelhanca.Tag := 1;
    mnuRelacSemelhanca.Visible := False;
  End;

  {*******************************************}
  {* VERIFICA SE USA PEDIDO DE IMPORTAO      *}
  {****************************************MV*}
  If (fCfgSisLoc('PEDIMP', varBoolean)) Then
  Begin
    mnuNotaFiscalImport.Tag     := 0;
    mnuNotaFiscalImport.Visible := True;
  End
  Else
  Begin
    mnuNotaFiscalImport.Tag     := 1;
    mnuNotaFiscalImport.Visible := False;
  End;

  If SameText(fCfgSisLoc('TELAGE'),'3') Then
  Begin
    mnuAgendamentoCiclicoComDia.Tag := 1;
    mnuAgendamentoCiclicoComDia.Visible := False;
  End;

  If (Not fCfgSisLoc('CATPRE', varBoolean)) Then
  Begin
    mnuImportCatalogoPreco.Tag := 1;
    mnuImportCatalogoPreco.Visible := False;
    mnuConsultaFatCatalogo.Tag := 1;
    mnuConsultaFatCatalogo.Visible := False;
    mnuConsultaFatCatalogoAlteracao.Tag := 1;
    mnuConsultaFatCatalogoAlteracao.Visible := False;
    mnuAltPrecoGlobalCatalogo.Tag := 1;
    mnuAltPrecoGlobalCatalogo.Visible := False;
  End
  Else
  Begin
    mnuImportCatalogoPreco.Tag := 0;
    mnuImportCatalogoPreco.Visible := True;
    mnuConsultaFatCatalogo.Tag := 0;
    mnuConsultaFatCatalogo.Visible := True;
    mnuConsultaFatCatalogoAlteracao.Tag := 0;
    mnuConsultaFatCatalogoAlteracao.Visible := True;
    mnuAltPrecoGlobalCatalogo.Tag := 0;
    mnuAltPrecoGlobalCatalogo.Visible := True;
  End;

  If fCfgSisLoc('CONEQU') <> 'S' Then
  Begin
    mnuFatConsertoEquipamentos.Tag := 1;
    mnuFatConsertoEquipamentos.Visible := False;
    mnuRelConsertoEquipamentos.Tag := 1;
    mnuRelConsertoEquipamentos.Visible := False;
    mnuCadAcessorios.Tag := 1;
    mnuCadAcessorios.Visible := False;
    mnuCadEstProduto.Tag := 1;
    mnuCadEstProduto.Visible := False;
    mnuFatManConsertoFluxoProcesso.Tag := 1;
    mnuFatManConsertoFluxoProcesso.Visible := False;
    mnuCadFasApontamento.Tag := 1;
    mnuCadFasApontamento.Visible := False;
    mnuNegociacaoOrdemServico.Tag := 1;
    mnuNegociacaoOrdemServico.Visible := False;
    mnuPainelAcompanhamentoOS.Tag := 1;
    mnuPainelAcompanhamentoOS.Visible := False;
    mnuFatLibReservaEstoqueOS.Tag := 1;
    mnuFatLibReservaEstoqueOS.Visible := False;
    mnuCadLocFisicaConsertoEquip.Tag := 1;
    mnuCadLocFisicaConsertoEquip.Visible := False;
  End
  Else
  Begin
    mnuFatConsertoEquipamentos.Tag := 0;
    mnuFatConsertoEquipamentos.Visible := True;
    mnuRelConsertoEquipamentos.Tag := 0;
    mnuRelConsertoEquipamentos.Visible := True;
    // EXIBE TAMBÉM O MENU DE SERVIÇOS
    mnuServicos.Tag := 0;
    mnuServicos.Visible := True;
    mnuConsultaServicos.Tag := 0;
    mnuConsultaServicos.Visible := True;
    mnuCadAcessorios.Tag := 0;
    mnuCadAcessorios.Visible := True;
    mnuCadFasApontamento.Tag := 0;
    mnuCadFasApontamento.Visible := True;
    mnuNegociacaoOrdemServico.Tag := 0;
    mnuNegociacaoOrdemServico.Visible := True;
    mnuPainelAcompanhamentoOS.Tag := 0;
    mnuPainelAcompanhamentoOS.Visible := True;
    mnuCadLocFisicaConsertoEquip.Visible := fCfgSis('ULCFCE', varBoolean);
    mnuCadLocFisicaConsertoEquip.Tag := IIF(mnuCadLocFisicaConsertoEquip.Visible, 1, 0);

    If fCfgSisLoc('ESTPRD') = 'S' Then
    Begin
      mnuCadEstProduto.Tag := 0;
      mnuCadEstProduto.Visible := True;
    End
    Else
    Begin
      mnuCadEstProduto.Tag := 1;
      mnuCadEstProduto.Visible := False;
  End;

    If fCfgSisLoc('EQFLXP') = 'S' Then
    Begin
      mnuFatManConsertoFluxoProcesso.Tag := 0;
      mnuFatManConsertoFluxoProcesso.Visible := True;

      if fCfgSis('FXRESS', varBoolean) then
      begin
        mnuFatLibReservaEstoqueOS.Tag := 0;
        mnuFatLibReservaEstoqueOS.Visible := True;
      end;
    End
    Else
    Begin
      mnuFatManConsertoFluxoProcesso.Tag := 1;
      mnuFatManConsertoFluxoProcesso.Visible := False;
      mnuFatLibReservaEstoqueOS.Tag := 1;
      mnuFatLibReservaEstoqueOS.Visible := False;
    End;
  End;

  If fCfgSisLoc('TCSPRE') = 'S' Then
  Begin
    mnuFatManConsertoEquipTec.Tag := 0;
    mnuFatManConsertoEquipTec.Visible := True;
  End
  Else
  Begin
    mnuFatManConsertoEquipTec.Tag := 1;
    mnuFatManConsertoEquipTec.Visible := False;
  End;

  If (Not (fCfgSisLoc('EMPGER', varBoolean))) Then
  Begin
    mnuRelacSimilaridade.Tag     := 1;
    mnuRelacSimilaridade.Visible := False;
  End
  Else
  Begin
    mnuRelacSimilaridade.Tag     := 0;
    mnuRelacSimilaridade.Visible := True;
  End;

  If (Not (fCfgSisLoc('CFFFD1', varBoolean))) Then
  Begin
    mnuConfFFemD1.Tag     := 1;
    mnuConfFFemD1.Visible := False;
  End
  Else
  Begin
    mnuConfFFemD1.Tag     := 0;
    mnuConfFFemD1.Visible := True;
  End;

  If (Not fCfgSisLoc('USAPDV', varBoolean)) Then
  Begin
    mnuFatPedido.Tag      := 1;
    mnuRelPedidos.Tag     := 1;

    mnuFatPedido.Visible  := False;
    mnuRelPedidos.Visible := False;

    mnuFatPedidoVendaRapida.Tag      := 1;
    mnuFatPedidoVendaRapida.Visible  := False;
  End
  Else
  Begin
    mnuFatPedido.Tag      := 0;
    mnuRelPedidos.Tag     := 0;

    mnuFatPedido.Visible  := True;
    mnuRelPedidos.Visible := True;

    If Not fEmptyStr(fCfgSisLoc('VRACLI')) Then
    Begin
      mnuFatPedidoVendaRapida.Tag      := 0;
      mnuFatPedidoVendaRapida.Visible  := True;
    End
    Else
    Begin
      mnuFatPedidoVendaRapida.Tag      := 1;
      mnuFatPedidoVendaRapida.Visible  := False;
    End;
  End;

  If Not fEmptyStr(fCfgSisLoc('VRACLI')) Then
  Begin
    mnuFatOrcamentoVendaRapida.Tag      := 0;
    mnuFatOrcamentoVendaRapida.Visible  := True;
  End
  Else
  Begin
    mnuFatOrcamentoVendaRapida.Tag      := 1;
    mnuFatOrcamentoVendaRapida.Visible  := False;
  End;

  If Not fEmptyStr(fCfgSisLoc('VRACLI')) Then
  Begin
    mnuFatVendaNormalVendaRapida.Tag      := 0;
    mnuFatVendaNormalVendaRapida.Visible  := True;
  End
  Else
  Begin
    mnuFatVendaNormalVendaRapida.Tag      := 1;
    mnuFatVendaNormalVendaRapida.Visible  := False;
  End;

  If Not fCfgSisLoc('LIBROM', varBoolean) Then
  Begin
    mnuFatLiberacaoRomaneio.Visible := False;
    mnuFatLiberacaoRomaneio.Tag := 1;
  End
  Else
  Begin
    mnuFatLiberacaoRomaneio.Visible := True;
    mnuFatLiberacaoRomaneio.Tag := 0;
  End;

  If (Not fCfgSisLoc('TBENTR', varBoolean)) Then
  Begin
    mnuLiberacaoAcompEntregas.Visible := False;
    mnuLiberacaoAcompEntregas.Tag := 1;
  End
  Else
  Begin
    mnuLiberacaoAcompEntregas.Visible := True;
    mnuLiberacaoAcompEntregas.Tag := 0;
  End;

  If Not fCfgSisLoc('DESFAT', varBoolean) Then
  Begin
    mnuCadDespFaturamento.Visible := False;
    mnuCadDespFaturamento.Tag := 1;
  End
  Else
  Begin
    mnuCadDespFaturamento.Visible := True;
    mnuCadDespFaturamento.Tag := 0;
  End;

  mnuControleGondola.Visible := TGerenciaMovimentacaoGondola.fGerenciaGondolaAtivo;

  If Not fUtilizaAutoAtendimento Then
  Begin
    mnuCadAtributos.Visible := False;
    mnuCadAtributos.Tag := 1;

    mnuCadGrupoAtributo.Visible := False;
    mnuCadGrupoAtributo.Tag := 1;
  End
  Else
  Begin
    mnuCadAtributos.Visible := True;
    mnuCadAtributos.Tag := 0;

    mnuCadGrupoAtributo.Visible := True;
    mnuCadGrupoAtributo.Tag := 0;
  End;

  mnuEntImportaNotaEletDivFiscal.Visible := fCfgSis('XMLVAL', varInteger) = 2;

  If fUsaRotinaWMS Then
  Begin
    mnuMovimentacaoProgramadaManual.Tag      := 0;
    mnuMovimentacaoProgramadaManual.Visible  := True;

    mnuFatConfPedidos.Tag      := 1;
    mnuFatConfPedidos.Visible  := False;

    mnuFatAltLoteItem.Tag := 1;
    mnuFatAltLoteItem.Visible := False;

    mnuTransfLocFisGlobalWMS.Tag      := 0;
    mnuTransfLocFisGlobalWMS.Visible  := True;

    mnuCadLoteItensRapido.Tag      := 0;
    mnuCadLoteItensRapido.Visible  := True;

    mnuEntMercadoriasEfetivaMovFiscal.Tag      := 1;
    mnuEntMercadoriasEfetivaMovFiscal.Visible  := False;

    mnuLiberacaoLocalizacaoFisicaColetor.Tag      := 0;
    mnuLiberacaoLocalizacaoFisicaColetor.Visible  := True;

    mnuPainelRessuprimentos.Tag := 0;
    mnuPainelRessuprimentos.Visible := True;

    If fConferenciaDepoisDaEntrada And (fCfgSis('TPLREC', varString) <> 'N') Then
    Begin

      mnuTransfArmazens.Tag     := 1;
      mnuTransfArmazens.Visible := False;

      mnuTransfLocFisGlobalWMS.Tag     := 1;
      mnuTransfLocFisGlobalWMS.Visible := False;

      mnuCadAgendamentodeEntrega.Tag      := 0;
      mnuCadAgendamentodeEntrega.Visible  := True;

      mnuRecebimentoEntregaAgendada.Tag     := 0;
      mnuRecebimentoEntregaAgendada.Visible := True;

      mnuPlanoDeRecebimento.Tag     := 0;
      mnuPlanoDeRecebimento.Visible := True;

      mnuCadDocas.Tag     := 0;
      mnuCadDocas.Visible := True;

      mnuManutencaoDocas.Tag     := 0;
      mnuManutencaoDocas.Visible := True;

      mnuEtiquetasPlanoRecebimento.Tag     := 0;
      mnuEtiquetasPlanoRecebimento.Visible := True;

      mnuEtiquetasSeqSeparacaoWMS.Tag     := 0;
      mnuEtiquetasSeqSeparacaoWMS.Visible := True;

      mnuEntConferPreNotaWMSDevolucao.Tag     := 0;
      mnuEntConferPreNotaWMSDevolucao.Visible := True;

      mnuMapeamentoLocalizacaoFisica.Tag      := 0;
      mnuMapeamentoLocalizacaoFisica.Visible  := True;

      If (fCfgSis('TPLREC',varString) = 'C') Then
      Begin
        mnuCadClasseLocFis.Tag     := 0;
        mnuCadClasseLocFis.Visible := True;

        mnuMapeamentoItemClasseLocFis.Tag     := 0;
        mnuMapeamentoItemClasseLocFis.Visible := True;
      End
      Else
      Begin
        mnuCadClasseLocFis.Tag     := 1;
        mnuCadClasseLocFis.Visible := False;

        mnuMapeamentoItemClasseLocFis.Tag     := 1;
        mnuMapeamentoItemClasseLocFis.Visible := False;

      End;
    End
    Else
    Begin
      If (Not fCfgSisLoc('UDEVME', varBoolean)) Then
      Begin
        mnuEntConferPreNotaWMSDevolucao.Tag     := 1;
        mnuEntConferPreNotaWMSDevolucao.Visible := False;
      End;

      mnuCadAgendamentodeEntrega.Tag      := 1;
      mnuCadAgendamentodeEntrega.Visible  := False;

      mnuRecebimentoEntregaAgendada.Tag     := 1;
      mnuRecebimentoEntregaAgendada.Visible := False;

      mnuPlanoDeRecebimento.Tag     := 1;
      mnuPlanoDeRecebimento.Visible := False;

      mnuCadDocas.Tag     := 1;
      mnuCadDocas.Visible := False;

      mnuManutencaoDocas.Tag     := 1;
      mnuManutencaoDocas.Visible := False;

      mnuEtiquetasPlanoRecebimento.Tag     := 1;
      mnuEtiquetasPlanoRecebimento.Visible := False;

      mnuEtiquetasSeqSeparacaoWMS.Tag     := 1;
      mnuEtiquetasSeqSeparacaoWMS.Visible := False;

      mnuCadClasseLocFis.Tag     := 1;
      mnuCadClasseLocFis.Visible := False;

      mnuMapeamentoItemClasseLocFis.Tag     := 1;
      mnuMapeamentoItemClasseLocFis.Visible := False;

      mnuMapeamentoLocalizacaoFisica.Tag      := 0;
      mnuMapeamentoLocalizacaoFisica.Visible  := False;

      mnuEntMercadoriasEfetivaMovFiscal.Tag      := 0;
      mnuEntMercadoriasEfetivaMovFiscal.Visible  := True;

    End;


  End
  Else
  Begin
    mnuMovimentacaoProgramadaManual.Tag      := 1;
    mnuMovimentacaoProgramadaManual.Visible  := False;

    mnuLiberacaoLocalizacaoFisicaColetor.Tag      := 1;
    mnuLiberacaoLocalizacaoFisicaColetor.Visible  := False;

    mnuPainelRessuprimentos.Tag := 1;
    mnuPainelRessuprimentos.Visible := False;

    If (Not fCfgSisLoc('UDEVME', varBoolean)) Then
    Begin
      mnuEntConferPreNotaWMSDevolucao.Tag     := 1;
      mnuEntConferPreNotaWMSDevolucao.Visible := False;
    End;

    mnuFatConfPedidos.Tag      := 0;
    mnuFatConfPedidos.Visible  := True;

    mnuFatAltLoteItem.Tag := 0;
    mnuFatAltLoteItem.Visible := True;

    mnuTransfLocFisGlobalWMS.Tag      := 1;
    mnuTransfLocFisGlobalWMS.Visible  := False;

    mnuCadLoteItensRapido.Tag      := 1;
    mnuCadLoteItensRapido.Visible  := False;

    mnuCadAgendamentodeEntrega.Tag      := 1;
    mnuCadAgendamentodeEntrega.Visible  := False;

    mnuRecebimentoEntregaAgendada.Tag     := 1;
    mnuRecebimentoEntregaAgendada.Visible := False;

    mnuPlanoDeRecebimento.Tag     := 1;
    mnuPlanoDeRecebimento.Visible := False;

    mnuCadDocas.Tag     := 1;
    mnuCadDocas.Visible := False;

    mnuManutencaoDocas.Tag     := 1;
    mnuManutencaoDocas.Visible := False;

    mnuEtiquetasPlanoRecebimento.Tag     := 1;
    mnuEtiquetasPlanoRecebimento.Visible := False;

    mnuEtiquetasSeqSeparacaoWMS.Tag     := 1;
    mnuEtiquetasSeqSeparacaoWMS.Visible := False;

    mnuCadClasseLocFis.Tag     := 1;
    mnuCadClasseLocFis.Visible := False;

    mnuMapeamentoLocalizacaoFisica.Tag      := 0;
    mnuMapeamentoLocalizacaoFisica.Visible  := False;

    If fConferenciaDepoisDaEntrada Then
    Begin
      mnuEntMercadoriasEfetivaMovFiscal.Tag      := 0;
      mnuEntMercadoriasEfetivaMovFiscal.Visible  := True;
    End
    Else
    Begin
      mnuEntMercadoriasEfetivaMovFiscal.Tag      := 1;
      mnuEntMercadoriasEfetivaMovFiscal.Visible  := False;
    End;

  End;

  If (fCfgSisLoc('UDEVME') = 'S') Then
  begin
    mnuEntConferPreNotaWMSDevolucao.Tag     := 1;
    mnuEntConferPreNotaWMSDevolucao.Visible := True;
  End;

  if (fCfgSisLoc('UDEVME') = 'S') then
  begin
    mnuEntConferPreNotaWMSDevolucao.Tag     := 0;
    mnuEntConferPreNotaWMSDevolucao.Visible := True;
  end;


  If Not fCfgSisLoc('UTIROM', varBoolean) Then
  Begin
    mnuRomaneio.Visible := False;
    mnuRomaneio.Tag := 1;
  End
  Else
  Begin
    mnuRomaneio.Visible := True;
    mnuRomaneio.Tag := 0;
  End;

  //Prestcon
  If fCfgSisLoc('USACCR', varBoolean) And MatchStr(fCfgSisLoc('TPNFCR'),[PRESTCON,SECOL,J_A_MASSA_CONCRETO]) Then
  Begin
    If (fCfgSisLoc('TPNFCR') = PRESTCON) Then
    Begin
    mnuFatOrcamento.Visible := False;
    mnuFatOrcamento.Tag := 1;

      mnuFatPedido.Visible := False;
      mnuFatPedido.Tag := 1;
    End;

    mnuFatConfPedidos.Visible := False;
    mnuFatConfPedidos.Tag := 1;

    mnuFatOrcamentoVendaRapida.Visible := False;
    mnuFatOrcamentoVendaRapida.Tag := 1;

    mnuFatPedidoVendaRapida.Visible := False;
    mnuFatPedidoVendaRapida.Tag := 1;

    mnuFatConfNotaConcreto.Visible := True;
    mnuFatConfNotaConcreto.Tag := 0;
  End
  Else
  Begin
    mnuFatConfNotaConcreto.Visible := False;
    mnuFatConfNotaConcreto.Tag := 1;
  End;

  If (Not fCfgSisLoc('USATES', varBoolean)) Then
  Begin
    mnuFatTransfEstoque.Tag     := 1;
    mnuFatTransfEstoque.Visible := False;
  End
  Else
  Begin
    mnuFatTransfEstoque.Tag     := 0;
    mnuFatTransfEstoque.Visible := True;
  End;

  If (Not fCfgSisLoc('CONSIG', varBoolean)) Then
  Begin
    mnuConsignacao.Tag     := 1;
    mnuConsignacao.Visible := False;
  End
  Else
  Begin
    mnuConsignacao.Tag     := 0;
    mnuConsignacao.Visible := True;
  End;

  If (Not fCfgSisLoc('USACND', varBoolean)) Then
  Begin
    mnuRelComissaoCondPagtoDesc.Tag     := 1;
    mnuRelComissaoCondPagtoDesc.Visible := False;
  End
  Else
  Begin
    mnuRelComissaoCondPagtoDesc.Tag     := 0;
    mnuRelComissaoCondPagtoDesc.Visible := True;
  End;

  mnuSolicitacaodeAbastecimentodeTintasdeMaquina.Tag := 1;
  mnuSolicitacaodeAbastecimentodeTintasdeMaquina.Visible := False;

  If (THistoricoBalanco.fDeveGravarHistorico) Or
     (TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco) Then
  Begin
    mnuRelMapaDeCaontagem.Tag     := 0;
    mnuRelMapaDeCaontagem.Visible := True;
  End Else
  Begin
    mnuRelMapaDeCaontagem.Tag     := 1;
    mnuRelMapaDeCaontagem.Visible := False;
  End;

  mnuBalancoEstoqueDigColetivo.Visible :=  Not TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco;
  mnuBalancoEstoqueDigManual.Visible :=  Not TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco;
  mnuBalancoEstoqueImportar.Visible :=  Not TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco;

  pVerificaMenuTintaMaquina(mnuTintadeMaquina);
  pVerificaMenusFixadosTintaMaquina();

  If (VS_strUsaTmq <> 'S') Then
  Begin
    mnuTintaDeMaquina.Tag              := 1;
    mnuTintaDeMaquina.Visible          := False;
    mnuFatFormulacaoDocumentos.Tag     := 1;
    mnuFatFormulacaoDocumentos.Visible := False;
    btnTintaMaquina.Visible            := False;
    mnuSolicitacaodeAbastecimentodeTintasdeMaquina.Tag := 1;
    mnuSolicitacaodeAbastecimentodeTintasdeMaquina.Visible := False;
    mnuFatOrdemProducaoAvulsa.Visible := False;
    mnuAlteracaoGlobalProdutosAcabados.Visible := False;
  End
  Else
  Begin
    mnuTintaDeMaquina.Tag              := 0;
    mnuTintaDeMaquina.Visible          := True;
    mnuFatFormulacaoDocumentos.Tag     := 0;
    mnuFatFormulacaoDocumentos.Visible := True;
    btnTintaMaquina.Visible            := True;

    if fCfgSisLoc('ESTFLJ') = '2' then
    begin
      mnuSolicitacaodeAbastecimentodeTintasdeMaquina.Tag := 0;
      mnuSolicitacaodeAbastecimentodeTintasdeMaquina.Visible := True;
    end;

    mnuFatOrdemProducaoAvulsa.Visible := True;
    mnuAlteracaoGlobalProdutosAcabados.Visible := True;
  End;

  If (VS_strUsaTmq = 'S') And (fCfgSis('UPROAC') = 'S')  Then
  Begin
    mnuRelEstKardexAcabado.Tag     := 0;
    mnuRelEstKardexAcabado.Visible := True;
  End Else
  Begin
    mnuRelEstKardexAcabado.Tag     := 1;
    mnuRelEstKardexAcabado.Visible := False;
  End;

  If (Not fCfgSisLoc('USARCX', varBoolean)) Then
  Begin
    mnuFatResumoCaixa.Tag     := 1;
    mnuFatResumoCaixa.Visible := False;
    btnResumoCaixa.Visible := False;
  End
  Else
  Begin
    mnuFatResumoCaixa.Tag     := 0;
    mnuFatResumoCaixa.Visible := True;
    btnResumoCaixa.Visible := True;
  End;

  If (fCfgSisLoc('USATPC', varBoolean)) Then
  Begin
    mnuCadTiposCliente.Tag     := 0;
    mnuCadTiposCliente.Visible := True;
  End
  Else
  Begin
    mnuCadTiposCliente.Tag     := 1;
    mnuCadTiposCliente.Visible := False;
  End;

  If (fCfgSisLoc('CADEST', varBoolean)) Then
  Begin
    mnuCadEstruturas.Visible := True;
    mnuFormulas.Visible := True;
  End
  Else
  Begin
    mnuCadEstruturas.Visible := False;
    mnuFormulas.Visible := False;
  End;

  If fCfgSisLoc('LIBPED', varBoolean) or fCfgSisLoc('APPSAL', varBoolean) Then
  Begin
    mnuCtrLiberacaoFiltros.Tag := 0;
    mnuCtrLiberacaoFiltros.Visible := True;
  End
  Else
  Begin
    mnuCtrLiberacaoFiltros.Tag := 1;
    mnuCtrLiberacaoFiltros.Visible := False;
  End;

  If (Pos(fCfgSis('MCAT17'), 'A_C_V_') > 0) Then
  Begin
    mnuCadRessarcimentoIcmsStCAT.Tag     := 0;
    mnuCadRessarcimentoIcmsStCAT.Visible := True;
  End
  Else
  Begin
    mnuCadRessarcimentoIcmsStCAT.Tag     := 1;
    mnuCadRessarcimentoIcmsStCAT.Visible := False;
  End;

  If (VS_strTipExp <> '1') Then
  Begin
    mnuFatExpedicao.Tag     := 0;
    mnuFatExpedicao.Visible := True;
  End
  Else
  Begin
    mnuFatExpedicao.Tag     := 1;
    mnuFatExpedicao.Visible := False;
  End;

  If (VS_strTipExp <> '1') And fCfgSisLoc('BAISEP', VarBoolean) Then
  Begin
    mnuFatExpedicaoBaiSep.Tag     := 0;
    mnuFatExpedicaoBaiSep.Visible := True;
  End
  Else
  Begin
    mnuFatExpedicaoBaiSep.Tag     := 1;
    mnuFatExpedicaoBaiSep.Visible := False;
  End;

  If fUsaRotinaExpedicaoConferenciaRetiraCaixa Then
  Begin
    mnuFatExpedicaoConferenciaRetiraCaixa.Tag     := 0;
    mnuFatExpedicaoConferenciaRetiraCaixa.Visible := True;
  End
  Else
  Begin
    mnuFatExpedicaoConferenciaRetiraCaixa.Tag     := 1;
    mnuFatExpedicaoConferenciaRetiraCaixa.Visible := False;
  End;

  If (VS_strTipExp = '3') Then
  Begin
    mnuFatRetiraDigSeparador.Tag     := 0;
    mnuFatRetiraDigSeparador.Visible := True;
  End
  Else
  Begin
    mnuFatRetiraDigSeparador.Tag     := 1;
    mnuFatRetiraDigSeparador.Visible := False;
  End;

  If (fCfgSisLoc('GARANT', varBoolean)) Then
  Begin
    mnuGarantia.Visible := True;
    mnuGarantia.Tag     := 0;
    mnuRelGarantia.Visible := True;
    mnuRelGarantia.Tag     := 0;
  End
  Else
  Begin
    mnuGarantia.Visible := False;
    mnuGarantia.Tag     := 1;
    mnuRelGarantia.Visible := False;
    mnuRelGarantia.Tag     := 1;
  End;

  If (fCfgSisLoc('BALANC', varBoolean)) Then
  Begin
    mnuBalancas.Visible := True;
    mnuBalancas.Tag     := 0;
  End
  Else
  Begin
    mnuBalancas.Visible := False;
    mnuBalancas.Tag     := 1;
  End;

  If SameText(fCfgSisLoc('TELAGE'),'3') Then
  Begin
    mnuAgendamentoCiclicoComDia.Tag := 1;
    mnuAgendamentoCiclicoComDia.Visible := False;
  End;

  If Not (fCfgSisLoc('LIBPCM', varBoolean)) Then
  Begin
    mnuPedidoCompraLiberacao.Tag     := 1;
    mnuPedidoCompraLiberacao.Visible := False;
  End
  Else
  Begin
    mnuPedidoCompraLiberacao.Tag     := 0;
    mnuPedidoCompraLiberacao.Visible := True;
  End;

  If fCfgSisLoc('MOEXSI') <> '0' Then
  Begin
    mnuExportacaoSite.Tag := 0;
    mnuExportacaoSite.Visible := True;
  End
  Else
  Begin
    mnuExportacaoSite.Tag := 1;
    mnuExportacaoSite.Visible := False;
  End;

  If (fCfgSisLoc('FUNUSA', varBoolean)) Then
  Begin
    mnuExpFunBoshSep.Tag     := 0;
    mnuExpFunBosh.Tag        := 0;
    mnuExpFunBoshSep.Visible := True;
    mnuExpFunBosh.Visible    := True;
  End Else
  Begin
    mnuExpFunBoshSep.Tag     := 1;
    mnuExpFunBosh.Tag        := 1;
    mnuExpFunBoshSep.Visible := False;
    mnuExpFunBosh.Visible    := False;
  End;

  If (VS_strUsaTef = 'S') or fExibeMenuAdmTef Then
  Begin
    mnuADMAdministracaoTEF.Tag     := 0;
    mnuADMAdministracaoTEF.Visible := True;
  End
  Else
  Begin
    mnuADMAdministracaoTEF.Tag     := 1;
    mnuADMAdministracaoTEF.Visible := False;
  End;

  mnuPgtoOnlineESiTefParChavesManutencao.Tag := IfThen(fCfgSis('LINKPG', varString) = '2', 0, 1) ;
  mnuPgtoOnlineESiTefParChavesManutencao.Visible := fCfgSis('LINKPG', varString) = '2' ;

  mnuEntPreNotaEntrada.Tag     := 1;
  mnuEntPreNotaEntrada.Visible := False;

  mnuEntConferencia.Tag        := 1;
  mnuEntConferencia.Visible    := False;

  mnuEntConferenciaCancel.Tag     := 1;
  mnuEntConferenciaCancel.Visible := False;

  mnuEntConferPreNota.Tag      := 1;
  mnuEntConferPreNota.Visible  := False;

  mnuConferenciaPreNotaCancel.Tag      := 1;
  mnuConferenciaPreNotaCancel.Visible  := False;

  If (fCfgSisLoc('USACON', varBoolean)) Then
  Begin

    If fCfgSisLoc('CONFME') = '1' Then
    Begin
      mnuEntPreNotaEntrada.Tag     := 0;
      mnuEntPreNotaEntrada.Visible := True;

      mnuEntConferPreNota.Tag     := 0;
      mnuEntConferPreNota.Visible := True;

      mnuConferenciaPreNotaCancel.Tag      := 0;
      mnuConferenciaPreNotaCancel.Visible  := True;

    End
    Else If fCfgSisLoc('CONFME') = '2' Then
    Begin
      mnuEntConferencia.Tag     := 0;
      mnuEntConferencia.Visible := True;

      mnuEntConferenciaCancel.Tag     := 0;
      mnuEntConferenciaCancel.Visible := True;

    End

    Else
    Begin
      mnuConferenciaPreNotaCancel.Caption := 'Cancelamento de Conferência de Entrada (Pré-Nota)';
      mnuEntConferenciaCancel.Caption     := 'Cancelamento de Conferência de Entrada (Pedido)';

      mnuEntPreNotaEntrada.Tag     := 0;
      mnuEntPreNotaEntrada.Visible := True;

      mnuEntConferencia.Tag        := 0;
      mnuEntConferencia.Visible    := True;

      mnuEntConferenciaCancel.Tag     := 0;
      mnuEntConferenciaCancel.Visible := True;

      mnuEntConferPreNota.Tag      := 0;
      mnuEntConferPreNota.Visible  := True;

      mnuConferenciaPreNotaCancel.Tag      := 0;
      mnuConferenciaPreNotaCancel.Visible  := True;
    End;
  End;

  If Not fUsaEnderecamento Then
  Begin
    mnuEntEnderecamentoProduto.Tag      := 1;
    mnuEntEnderecamentoProduto.Visible  := False;
  End
  Else
  Begin
      mnuEntEnderecamentoProduto.Tag      := 0;
      mnuEntEnderecamentoProduto.Visible  := True;
    End;


  mnuEnderecamentoMarmoreGranito.Visible := fCfgSis('MARMOR', varBoolean);

  If Not fCfgSisLoc('VENVID', varBoolean) Then
  Begin
    mnuCadComplVidro.Tag      := 1;
    mnuCadComplVidro.Visible  := False;
    mnumportarArquivoParaAnalisedeCompras.Visible := False;
    mnuGerarOrdemdeProducaoPorArquivoDeImportacao.Visible := False;
  End
  Else
  Begin
    mnuCadComplVidro.Tag      := 0;
    mnuCadComplVidro.Visible  := True;
    mnumportarArquivoParaAnalisedeCompras.Visible := True;
    mnuGerarOrdemdeProducaoPorArquivoDeImportacao.Visible := fCfgSis('IMPGOR', varBoolean);
  End;

  If fUsaRequisicaoEnvioMateriais Then
  Begin
    mnuReqEnvioMatVidro.Tag      := 0;
    mnuReqEnvioMatVidro.Visible  := True;

  End
  Else
  Begin
    mnuReqEnvioMatVidro.Tag      := 1;
    mnuReqEnvioMatVidro.Visible  := False;

  End;

  // Essa variavel é lida do aquivo opcoes.ini para habilitar ou nao a config. EXDFSE
  EXDFSE.Visible := (fArqIni(0, 'GERAL', 'EXDFSE', '') = 'S');
  EXIBE_MARMKP_4_5 := (fArqIni(0, 'GERAL', 'EXIBE_MARMKP_4_5', '') = 'S');
  If (fArqIni(0, 'GERAL', 'VALIDA_QTDBAIXA_OP', '') = '') Then
    VALIDA_QTDBAIXA_OP := True
  Else
    VALIDA_QTDBAIXA_OP := (fArqIni(0, 'GERAL', 'VALIDA_QTDBAIXA_OP', '') = 'S');

  If (fArqIni(0, 'GERAL', 'VALIDA_LOTE_OP', '') = '') Then
    VALIDA_LOTE_OP := False
  Else
    VALIDA_LOTE_OP:= (fArqIni(0, 'GERAL', 'VALIDA_LOTE_OP', '') = 'S');

  If (fArqIni(0, 'GERAL', 'PLANO_RECEBIMENTO_SEM_SUGESTAO', '') = '') Then
    TRAVA_PLANO_RECEBIMENTO_SEM_SUGESTAO := True
  Else
    TRAVA_PLANO_RECEBIMENTO_SEM_SUGESTAO := (fArqIni(0, 'GERAL', 'PLANO_RECEBIMENTO_SEM_SUGESTAO', '') = 'T');

  If (fArqIni(0, 'GERAL', 'COTACAO_MODO_GRAVACAO_ANTIGA', '') = '') Then
    COTACAO_MODO_GRAVACAO_ANTIGA := False
  Else
    COTACAO_MODO_GRAVACAO_ANTIGA := (fArqIni(0, 'GERAL', 'COTACAO_MODO_GRAVACAO_ANTIGA', '') = 'S');

  TCalcFatReg.fIniciaALIQUOTAS_ICMS_INTERESTADUAIS;

  If fCfgSisLoc('CLIBAT', varBoolean) Then
  Begin
    mnuCadBairros.Tag     := 0;
    mnuCadBairros.Visible := True;
  End
  Else
  Begin
    mnuCadBairros.Tag     := 1;
    mnuCadBairros.Visible := False;
  End;

  If fCfgSis('UTIVMA', varBoolean) Then
  Begin
    mnuCadVenMar.Tag     := 0;
    mnuCadVenMar.Visible := True;
  End
  Else
  Begin
    mnuCadVenMar.Tag     := 1;
    mnuCadVenMar.Visible := False;
  End;

  blnUsaDAS := fCfgSisLoc('USADAS', varBoolean);

  If (VS_strUsaTmq = 'S')                         And
     (fGetConfTinta('SUV').fGetBoolean('USATIN')) And
     (blnUsaDAS)                                  Then
  Begin
    btnDASSuvinil.Visible := True;
    mnuDASSuvinil.Visible := True;

    btnDASSuvinil.Tag     := 0;
    mnuDASSuvinil.Tag     := 0;
  End
  Else
  Begin
    btnDASSuvinil.Visible := False;
    mnuDASSuvinil.Visible := False;

    btnDASSuvinil.Tag     := 1;
    mnuDASSuvinil.Tag     := 1;
  End;


  If (Not fCfgSisLoc('USAGAG', varBoolean)) Then
  Begin
    mnuGeraNotaDebito.Tag           := 1;
    mnuGeraNotaDebito.Visible       := False;
    mnuGeraDuplicataReceber.Tag     := 1;
    mnuGeraDuplicataReceber.Visible := False;
  End
  Else
  Begin
    mnuGeraNotaDebito.Tag           := 0;
    mnuGeraNotaDebito.Visible       := True;
    mnuGeraDuplicataReceber.Tag     := 0;
    mnuGeraDuplicataReceber.Visible := True;
  End;

  If (fCfgSisLoc('FAICND', varString) = '2') Then
  Begin
    // cadastro de faixa de valores para geração de nota debito
    mnuFaixasCondPagGeraNotaDebito.Visible := True;
    mnuFaixasCondPagGeraNotaDebito.Tag := 0;
  End
  Else
  Begin
    // cadastro de faixa de valores para geração de nota debito
    mnuFaixasCondPagGeraNotaDebito.Visible := False;
    mnuFaixasCondPagGeraNotaDebito.Tag := 1;
  End;
  If (fCfgSisLoc('FRETRA') = FRETRA_POR_TRANSPORTADORA_CIDADE) Or
     ((fCfgSisLoc('UTICTE', varBoolean)) And (fCfgSis('FRETRA') <> FRETRA_POR_TRANSPORTADORA_REGIAO)) Then
  Begin
    mnuCadFreteTranspCidade.Tag := 0;
    mnuCadFreteTranspCidade.Visible := True;
  End
  Else
  Begin
    mnuCadFreteTranspCidade.Tag := 1;
    mnuCadFreteTranspCidade.Visible := False;

  End;

  If fCfgSisLoc('FRETRA') <> FRETRA_POR_TRANSPORTADORA_REGIAO Then
  Begin
    mnuCadFreteTranspRegiao.Tag := 1;
    mnuCadFreteTranspRegiao.Visible := False;
  End
  Else
  Begin
    mnuCadFreteTranspRegiao.Tag := 0;
    mnuCadFreteTranspRegiao.Visible := True;
  End;

  If (Not fCfgSisLoc('PROPRO', varBoolean)) Then
  Begin
    mnuContProgProd.Tag     := 1;
    mnuContProgProd.Visible := False;

    mnuConsControleProducao.Tag := 1;
    mnuConsControleProducao.Visible := False;
  End
  Else
  Begin
    mnuContProgProd.Tag     := 0;
    mnuContProgProd.Visible := True;

    mnuConsControleProducao.Tag := 0;
    mnuConsControleProducao.Visible := True;
  End;

  If (fCfgSisLoc('USIGEP', varString) = 'N') Then
  Begin
    mnuContratosCorreios.Tag     := 1;
    mnuContratosCorreios.Visible := False;

    mnuManCadCidadeSigep.Tag     := 1;
    mnuManCadCidadeSigep.Visible := False;

    mnuBaixaVolumes.Tag     := 1;
    mnuBaixaVolumes.Visible := False;
  End
  Else
  //Caso seja Envio Off Line não tem configuração de Contrato nem Envio da PLP ao webService.
  If (fCfgSisLoc('USIGEP', varString) = 'O') Then
  Begin
    mnuContratosCorreios.Tag     := 1;
    mnuContratosCorreios.Visible := False;
  End;

  If Not fCfgSis('COTDOR', varBoolean) Then
  Begin
    mnuCadCotacaoMoeda.Tag     := 1;
    mnuCadCotacaoMoeda.Visible := False;
  end;

  If (MatchStr(fCfgSisLoc('OPCCOM'), ['G', 'M', 'C', 'CC', 'R', 'PD', 'MP', 'MD'])) Then
  Begin
    mnuCadCom.Visible := True;
    mnuCadCom.Tag     := 0;
  End
  Else
  Begin
    mnuCadCom.Visible := False;
    mnuCadCom.Tag     := 1;
  End;

  If (Not fCfgSisLoc('CLAONU', varBoolean)) Then
  Begin
    mnuCadClassificacaoOnu.Tag := 1;
    mnuCadClassificacaoOnu.Visible := False;
  end
  Else
  Begin
    mnuCadClassificacaoOnu.Tag := 0;
    mnuCadClassificacaoOnu.Visible := True;
  End;

  If fCfgSisLoc('IMPLIB', varBoolean) Then
  Begin
    mnuRelEstLibArmazenamento.Visible := True;
    mnuRelEstLibArmazenamento.Tag     := 0;
  End
  Else
  Begin
    mnuRelEstLibArmazenamento.Visible := False;
    mnuRelEstLibArmazenamento.Tag     := 1;
  End;

  If fCfgSisLoc('IMPPAG', varInteger) = '1' Then
  Begin
    mnuCadAliqIBPT.Tag := 1;
    mnuCadAliqIBPT.Visible := False;
  End
  Else
  Begin
    mnuCadAliqIBPT.Tag := 0;
    mnuCadAliqIBPT.Visible := True;
  End;

  If Not fCfgSisLoc('ESTSER', VarBoolean) Then
  Begin
    mnuCadAdenFatSer.Tag     := 1;
    mnuCadAdenFatSer.Visible := False;
  End
  Else
  Begin
    mnuCadAdenFatSer.Tag     := 0;
    mnuCadAdenFatSer.Visible := True;
  End;

  If mnuFatorPrecoCadastro.Visible And fCfgSisLoc('FATPRE', varBoolean) Then
  Begin
    mnuFatorPrecoCadastro.Tag := 0;
    mnuFatorPrecoCadastro.Visible := True;
  End
  Else
  Begin
    mnuFatorPrecoCadastro.Tag := 1;
    mnuFatorPrecoCadastro.Visible := False;
  End;

  If mnuFatAltComissao.Visible And (fArqIni(0, 'GERAL', 'ALVECO', '') = 'S') And (fCfgSisLoc('ALVECO') = 'S') Then
  Begin
    mnuFatAltComissao.Tag     := 0;
    mnuFatAltComissao.Visible := True;
  End
  Else
  Begin
    mnuFatAltComissao.Tag     := 1;
    mnuFatAltComissao.Visible := False;
  End;

  mnuGerAvisoEmbarque.Visible := fCfgSisLoc('USAAVE', varBoolean);
  mnuGerAvisoEmbarque.Tag     := IIF(fCfgSisLoc('USAAVE', varBoolean), 0, 1);

  mnuAlteracaoTipoAtendPed.Visible := fCfgSisLoc('PEDTPA', varBoolean);
  mnuAlteracaoTipoAtendPed.Tag     := IIF(fCfgSisLoc('PEDTPA', varBoolean), 0, 1);

  mnuCadMetasRapel.Visible := fCfgSisLoc('URAPEL', varBoolean);
  mnuCadMetasRapel.Tag     := IIF(fCfgSisLoc('URAPEL', varBoolean), 0, 1);

  mnuAlteracaoFreteSugestao.Visible := fCfgSisLoc('FREVEN', varBoolean);
  mnuAlteracaoFreteSugestao.Tag     := IIF(fCfgSisLoc('FREVEN', varBoolean), 0, 1);

  mnuRelCtpReimpBordero.Visible := fCfgSisLoc('CTPBOR', varBoolean);
  mnuRelCtpReimpBordero.Tag     := IIF(fCfgSisLoc('CTPBOR', varBoolean), 0, 1);

  If fCfgSisLoc('ENTFUT', varBoolean) Then
  Begin
    mnuFatSepFutDigSeparador.Visible := True;
    mnuFatSepFutDigSeparador.Tag     := 0;

    mnuFatBaixaEntregaFuturaSEP.Visible := True;
    mnuFatBaixaEntregaFuturaSEP.Tag     := 0;

    mnuEntregaFatura.Visible := True;
    mnuEntregaFatura.Tag     := 0;

    mnuFatBaixaEntregaFutura.Visible := True;
    mnuFatBaixaEntregaFutura.Tag     := 0;

    mnuFatAlteraDtaEntFut.Visible := True;
    mnuFatAlteraDtaEntFut.Tag     := 0;

    mnuAlteracaoEntregaFutura.Visible := True;
    mnuAlteracaoEntregaFutura.Tag     := 0;

    mnuFatBaixaEntregaFutura49.Visible := fCfgSis('BFUT49', varBoolean);
    mnuFatBaixaEntregaFutura49.Tag     := IIF(fCfgSis('BFUT49', varBoolean), 0, 1);
  End
  Else
  Begin
    mnuFatSepFutDigSeparador.Visible := False;
    mnuFatSepFutDigSeparador.Tag     := 1;

    mnuFatBaixaEntregaFuturaSEP.Visible := False;
    mnuFatBaixaEntregaFuturaSEP.Tag     := 1;

    mnuEntregaFatura.Visible := False;
    mnuEntregaFatura.Tag     := 1;

    mnuFatBaixaEntregaFutura.Visible := False;
    mnuFatBaixaEntregaFutura.Tag     := 1;

    mnuFatAlteraDtaEntFut.Visible := False;
    mnuFatAlteraDtaEntFut.Tag     := 1;

    mnuAlteracaoEntregaFutura.Visible := False;
    mnuAlteracaoEntregaFutura.Tag     := 1;

    mnuFatBaixaEntregaFutura49.Visible := False;
    mnuFatBaixaEntregaFutura49.Tag     := 1;
  End;

  If fCfgSisLoc('CONVIS', varBoolean) Then
  Begin
    frmPrincipal.mnuGeraVisitaCliente.Visible           := True;
    frmPrincipal.mnuGeraVisitaClienteIndividual.Visible := True;

    frmPrincipal.mnuGeraVisitaCliente.Tag               := 0;
    frmPrincipal.mnuGeraVisitaClienteIndividual.Tag     := 0;
  End
  Else
  Begin
    frmPrincipal.mnuGeraVisitaCliente.Visible           := False;
    frmPrincipal.mnuGeraVisitaClienteIndividual.Visible := False;

    frmPrincipal.mnuGeraVisitaCliente.Tag               := 1;
    frmPrincipal.mnuGeraVisitaClienteIndividual.Tag     := 1;
  End;

  If fCfgSisLoc('ITECND', varBoolean) Then
  Begin
    frmPrincipal.mnuCadProdutosCndPag.Visible := True;
    frmPrincipal.mnuCadProdutosCndPag.Tag     := 0;
  End
  Else
  Begin
    frmPrincipal.mnuCadProdutosCndPag.Visible := False;
    frmPrincipal.mnuCadProdutosCndPag.Tag     := 1;
  End;

  If fCfgSisLoc('USADCB', varBoolean) Then
  Begin
    mnuCtrGeracaoDesCobCheques.Visible := True;
    mnuCtrGeracaoDesCobCheques.Tag     := 0;
  End
  Else
  Begin
    mnuCtrGeracaoDesCobCheques.Visible := False;
    mnuCtrGeracaoDesCobCheques.Tag     := 1;
  End;

  If fCfgSisLoc('USPRRO', varBoolean) Then
  Begin
    mnuFatAtivaPreRomaneio.Visible := True;
    mnuFatAtivaPreRomaneio.Tag     := 0;

    If (Not fCfgSis('ROMPAR', varBoolean)) And fCfgSis('GERPRO', varBoolean) Then
    Begin
      mnuFatRemoverDocumentoPreRomaneio.Visible := True;
      mnuFatRemoverDocumentoPreRomaneio.Tag     := 0;

      mnuFatGerarNovoPreRomaneio.Visible := True;
      mnuFatGerarNovoPreRomaneio.Tag     := 0;

      mnuFatRomaneioAdicionarDoctosNaoEntregues.Visible := True;
      mnuFatRomaneioAdicionarDoctosNaoEntregues.Tag     := 0;
    End;
  End
  Else
  Begin
    mnuFatAtivaPreRomaneio.Visible := False;
    mnuFatAtivaPreRomaneio.Tag     := 1;

    mnuFatRemoverDocumentoPreRomaneio.Visible := False;
    mnuFatRemoverDocumentoPreRomaneio.Tag     := 1;

    mnuFatGerarNovoPreRomaneio.Visible := False;
    mnuFatGerarNovoPreRomaneio.Tag     := 1;

    mnuFatRomaneioAdicionarDoctosNaoEntregues.Visible := False;
    mnuFatRomaneioAdicionarDoctosNaoEntregues.Tag     := 1;
  End;

  //Um Valor de Comissão Para Cada Tabela de Preço;
  If fCfgSisLoc('PCMPRO', varInteger) = 2 Then
  Begin
    mnuImportComisVendTabPreco.Visible := True;
    mnuImportComisVendTabPreco.Tag     := 0;
  End
  Else
  Begin
    mnuImportComisVendTabPreco.Visible := False;
    mnuImportComisVendTabPreco.Tag     := 1;
  End;

  If fCfgSisLoc('ROMLOT', varBoolean) Then
  Begin
    mnuFatRomaneioLoteSeparacao.Visible := True;
    mnuFatRomaneioLoteSeparacao.Tag     := 0;
  End
  Else
  Begin
    mnuFatRomaneioLoteSeparacao.Visible := False;
    mnuFatRomaneioLoteSeparacao.Tag     := 1;
  End;

  If fCfgSisLoc('MOVDIG', varBoolean) Then
  Begin
    mnuFatDigitalizacaoDocumentos.Visible := True;
    mnuFatDigitalizacaoDocumentos.Tag     := 0;
  End
  Else
  Begin
    mnuFatDigitalizacaoDocumentos.Visible := False;
    mnuFatDigitalizacaoDocumentos.Tag     := 1;
  End;

  if fUsaRotinaGarantiaPelaMatriz Then
  Begin
    mnuManGarantiaFornecAntEnvio.Visible       := False;
    mnuEnvioFornecedor.Visible                 := False;
    mnuRetornoFornecedor.Visible               := False;
    mnuBaixarGarantiaEnviaaoFornecedor.Visible := False;

    mnuManGarantiaFornecAntEnvio.Tag           := 1;
    mnuEnvioFornecedor.Tag                     := 1;
    mnuRetornoFornecedor.Tag                   := 1;
    mnuBaixarGarantiaEnviaaoFornecedor.Tag     := 1;

    If fCfgSis('REFENT', varBoolean, fCfgSis('EMPMAT', varString) ) Then
    Begin
      mnuGarantiaBaixaRefugo.Visible := True;
      mnuGarantiaBaixaRefugo.Tag     := 0;
    End
    Else
    Begin
      mnuGarantiaBaixaRefugo.Visible := False;
      mnuGarantiaBaixaRefugo.Tag     := 1;
    End;
  End
  Else
  Begin
    mnuManGarantiaFornecAntEnvio.Visible := True;
    mnuManGarantiaFornecAntEnvio.Tag := 0;

    mnuEnvioFornecedor.Visible := True;
    mnuEnvioFornecedor.Tag := 0;

    If fCfgSis('REFENT', varBoolean) Then
    Begin
      mnuGarantiaBaixaRefugo.Visible := True;
      mnuGarantiaBaixaRefugo.Tag     := 0;

      mnuRetornoFornecedor.Visible := False;
      mnuRetornoFornecedor.Tag := 1;

      mnuBaixarGarantiaEnviaaoFornecedor.Visible := True;
      mnuBaixarGarantiaEnviaaoFornecedor.Tag := 0;

    End
    Else
    Begin
      mnuGarantiaBaixaRefugo.Visible := False;
      mnuGarantiaBaixaRefugo.Tag     := 1;

      mnuRetornoFornecedor.Visible := True;
      mnuRetornoFornecedor.Tag := 0;

      mnuBaixarGarantiaEnviaaoFornecedor.Visible := False;
      mnuBaixarGarantiaEnviaaoFornecedor.Tag := 1;
    End;
  End;

  If fCfgSisLoc('CADEST', varString) = 'S' Then
  Begin
    mnuOrdProAtualizaPrecos.Visible := True;
    mnuOrdProAtualizaPrecos.Tag     := 0;
  End
  Else
  Begin
    mnuOrdProAtualizaPrecos.Visible := False;
    mnuOrdProAtualizaPrecos.Tag     := 1;
  End;

  If fCfgSisLoc('TABPRD', varBoolean) Then
  Begin
    mnuAltPrecoRecalc.Visible := True;
    mnuCalNivGirEstFornecedor.Tag     := 0;
    mnuCalNivGirEstFornecedor.Visible := True;
    mnuImportCadProduto.Visible := False;
    mnuImportTabPrecosIteger.Visible := False;
    mnuImportMargemLucroTabPreco.Visible := False;
    mnuAltPrecoProduto.Visible := False;
    mnuTransfCodProduto.Visible := False;
    mnuTransCodFornecedor.Visible := False;
    mnuAltPrecoGlobalNota.Visible := False;
    mnuImportPrecoVendaTabPrecoConfirma.Visible := False;
    mnuTransfTabelas.Visible := True;
    mnuImportaPrecos.Visible := True;
//    mnuAltPrecoIndividual.Visible := False;
//    mnuAltPrecoIndividual.Tag     := 1;
  End Else
  Begin
    mnuAltPrecoRecalc.Visible := False;
    mnuCalNivGirEstFornecedor.Tag     := 1;
    mnuCalNivGirEstFornecedor.Visible := False;
    mnuImportCadProduto.Visible := True;
    mnuImportTabPrecosIteger.Visible := True;
    mnuImportMargemLucroTabPreco.Visible := True;
    mnuAltPrecoProduto.Visible := True;
    mnuTransfCodProduto.Visible := Not fUsaRotinaWMS;
    mnuTransCodFornecedor.Visible := True;
    mnuImportPrecoVendaTabPrecoConfirma.Visible := True;
    mnuAltPrecoGlobalNota.Visible := True;
    mnuTransfTabelas.Visible := False;
    mnuImportaPrecos.Visible := False;
//    mnuAltPrecoIndividual.Visible := True;
//    mnuAltPrecoIndividual.Tag     := 0;
  End;

  if (VS_strTipExp = '5') And
     (fCfgSisLoc('ALTRPD', varBoolean)) And
     (fCfgSisLoc('USPRRO', varBoolean)) Then
  Begin
    mnuFatAlteraTransRomaneio.Visible := True;
    mnuFatAlteraTransRomaneio.Tag     := 0;
  End
  Else
  Begin
    mnuFatAlteraTransRomaneio.Visible := False;
    mnuFatAlteraTransRomaneio.Tag     := 1;
  End;

  If (VS_strTipExp = '5') And (fCfgSisLoc('USPRRO', varBoolean)) Then
  Begin
    mnuFatRomaneioPedidosNaoFaturados.Visible := True;
    mnuFatRomaneioPedidosNaoFaturados.Tag     := 0;
  End
  Else
  Begin
    mnuFatRomaneioPedidosNaoFaturados.Visible := False;
    mnuFatRomaneioPedidosNaoFaturados.Tag     := 1;
  End;

  If fCfgSisLoc('UTCSEA', varString) <> 'N' Then
  Begin
    mnuControleSepAvulsa.Visible := True;
    mnuControleSepAvulsa.Tag     := 0;
  End
  Else
  Begin
    mnuControleSepAvulsa.Visible := False;
    mnuControleSepAvulsa.Tag     := 1;
  End;

  If (fCfgSis('USAFLE', varBoolean)) Then
  Begin
    mnuManutencaoFlex.Tag     := 0;
    mnuManutencaoFlex.Visible := True;
  End
  Else
  Begin
    mnuManutencaoFlex.Tag     := 1;
    mnuManutencaoFlex.Visible := False;
  End;


  If (fCfgSis('CREGAR', varString) = '2') Then
  Begin
    mnuGarantiaGeraCreditos.Tag     := 0;
    mnuGarantiaGeraCreditos.Visible := True;
  End
  Else
  Begin
    mnuGarantiaGeraCreditos.Tag     := 1;
    mnuGarantiaGeraCreditos.Visible := False;
  End;

  If (fArqIni(0, 'GERAL', 'EMPECO', '') = VS_strCodEmp) And fVerificaAcessoSistema(mnuPainelECommerce.Hint) Then
  Begin
    VS_blnPainelEcommerce      := True;
    mnuPainelECommerce.Tag     := 0;
    mnuPainelECommerce.Visible := True;
  End
  Else
  Begin
    VS_blnPainelEcommerce      := False;
    mnuPainelECommerce.Tag     := 1;
    mnuPainelECommerce.Visible := False;
  End;

  If fCfgSis('MATCON', varBoolean) And fVerificaAcessoSistema(mnuReqMatCon.Hint) Then
  Begin
    mnuReqMatCon.Tag     := 0;
    mnuReqMatCon.Visible := True;
  End
  Else
  Begin
    mnuReqMatCon.Tag     := 1;
    mnuReqMatCon.Visible := False;
  End;

  If fCfgSis('CTPLBB', varBoolean) Then
  Begin
    mnuCtpLiberacaoBaixa.Tag     := 0;
    mnuCtpLiberacaoBaixa.Visible := True;
  End
  Else
  Begin
    mnuCtpLiberacaoBaixa.Tag     := 1;
    mnuCtpLiberacaoBaixa.Visible := False;
  End;

  If (fCfgSisLoc('SIMPAU', varBoolean)) Then Begin
    mnuRelSimplesNacional.Visible := True;
    mnuRelSimplesNacional.Tag     := 0;
  End Else Begin
    mnuRelSimplesNacional.Visible := False;
    mnuRelSimplesNacional.Tag     := 1;
  End;

  if fCfgSis('UTIFEC', varBoolean) then
  begin
    mnuUltimosFechamentosEstoque.Visible := True;
    mnuUltimosFechamentosEstoque.Tag     := 0;

    mnuUltimosFechamentosFiscais.Visible := True;
    mnuUltimosFechamentosFiscais.Tag     := 0;
  end
  else
  begin
    mnuUltimosFechamentosEstoque.Visible := False;
    mnuUltimosFechamentosEstoque.Tag     := 1;

    mnuUltimosFechamentosFiscais.Visible := False;
    mnuUltimosFechamentosFiscais.Tag     := 1;
  end;

  If fCfgSis('GS1CNP', varBoolean) And fVerificaAcessoSistema(mnuCadGPC.Hint) Then
  Begin
    mnuCadGPC.Tag     := 0;
    mnuCadGPC.Visible := True;
  End
  Else
  Begin
    mnuCadGPC.Tag     := 1;
    mnuCadGPC.Visible := False;
  End;

  If fCfgSis('GS1CNP', varBoolean) And fVerificaAcessoSistema(mnuGerarGTINAtualizarCadastroGS1CNP.Hint) Then
  Begin
    mnuGerarGTINAtualizarCadastroGS1CNP.Tag     := 0;
    mnuGerarGTINAtualizarCadastroGS1CNP.Visible := True;
  End
  Else
  Begin
    mnuGerarGTINAtualizarCadastroGS1CNP.Tag     := 1;
    mnuGerarGTINAtualizarCadastroGS1CNP.Visible := False;
  End;

  blnUTCDDE := fCfgSisLoc('UTCDDE', varBoolean);
  pHabilitarItemMenu(mnuCadClientesDesconto,       blnUTCDDE);
  pHabilitarItemMenu(mnuCadRegioesDesconto,        blnUTCDDE);
  pHabilitarItemMenu(mnuCadDescontoClienteProduto, blnUTCDDE);
  pHabilitarItemMenu(mnuCadDescontoClientesMarcas, blnUTCDDE);

  mnuBoxEntrega.Visible := fCfgSisLoc('USABOX', varBoolean);
  mnuBoxEntregaImediata.Visible := fCfgSisLoc('USABEI', varBoolean);

  mnuTabelaFatSimples.Visible := (fCfgSisLoc('SIMPAU', varBoolean));
  mnuTabelaFatSimples.Tag     := IIF(mnuTabelaFatSimples.Visible, 0, 1);

  mnuCadEmbarcacoes.Visible := (fCfgSisLoc('CADEMB', varBoolean));
  mnuCadEmbarcacoes.Tag     := IIF(mnuCadEmbarcacoes.Visible, 0, 1);

  mnuFatAltEmbarcacao.Visible := (fCfgSisLoc('CADEMB', varBoolean));
  mnuFatAltEmbarcacao.Tag     := IIF(mnuCadEmbarcacoes.Visible, 0, 1);

  blnLibCom := fCfgSisLoc('AGDLBT', VarBoolean) Or
              (fCfgSisLoc('AGDLIB', varBoolean) And fCfgSisLoc('LPPDBL', varBoolean)) Or
               fCfgSisLoc('APPSAL', varBoolean);

  pHabilitarItemMenu(mnuExportaXMLNotasRomaneio, (Pos(fCfgSis('OPCROM', varString),'2_3_4_') > 0));

  pHabilitarItemMenu(mnuGerImpFiscais, (Not fCfgSisLoc('USNFCE', varBoolean)) And (Not fCfgSisLoc('PAFECF', varBoolean)) And (Not fUsaSat));
  pHabilitarItemMenu(mnuCadEcf, (Not fCfgSisLoc('USNFCE', varBoolean)) And (Not fUsaSat) );
  pHabilitarItemMenu(mnuFatCupomFiscalEsp, (Not fCfgSisLoc('PAFECF', varBoolean)));

  pHabilitarItemMenu(mnuRelacaoNetpoints, fCfgSisLoc('UTINPS', varBoolean));



  pHabilitarItemMenu(mnuAltPrecoMedio, False);

  pHabilitarItemMenu(mnuCadPagBosch, fCfgSis('USBOSC', varBoolean));

  pHabilitarItemMenu(mnuDigSerieProdRastreaveis, fCfgSis('SERRAS', varBoolean));

  pHabilitarItemMenu(mnuLiberaRomaneiosAppEntrega, fCfgSis('MATDIS', varBoolean));

  pHabilitarItemMenu(mnuCadOcorrenciaEntrega, fCfgSis('MATDIS', varBoolean));

  pHabilitarItemMenu(mnuCadMotivoPausaAppEntrega, fCfgSis('MATDIS', varBoolean));

  pHabilitarItemMenu(mnuContatosWhatsappIntegracao, fCfgSis('UTIWPP', varBoolean));

  pHabilitarItemMenu(mnuReinf, fCfgSis('UTIREI', varBoolean));

  {********************************}
  {* CAPTION DO MENU DE LIBERAÇÃO *}
  {*****************************RV*}
  mnuCtrLiberacaoFiltros.Caption          := IIF(blnLibCom, 'Liberação de Pedidos - Financeiro', 'Liberação de Pedidos');
  mnuCtrLiberacaoFiltrosComercial.Visible := blnLibCom;

  If (fCfgSis('CTLEST', varString) = '2') And (fCfgSis('REPLOT', varBoolean)) Then Begin
    mnuReplicaodeArmazensProdutos.Visible := True;
    mnuReplicaodeArmazensProdutos.Tag     := 0;
  End Else Begin
    mnuReplicaodeArmazensProdutos.Visible := False;
    mnuReplicaodeArmazensProdutos.Tag     := 1;
  End;

  {********************************}
  {* MENUS LOCAÇÃO EQUIPAMENTO    *}
  {********************************}
  pProcessarMenusLocacaoEquipamento;

  mnuImportaProdFranq.Visible := fCfgSis('PRDFRQ', varBoolean);
  mnuImportaProdFranq.Tag     := IIF(mnuImportaProdFranq.Visible, 0, 1);

  If (mnuImportaProdFranq.Visible) And (fCfgSis('TMPIMP', varInteger) > 0) And (fVerificaAcessoSistema('frmImportaProdFranq')) And fValidaLimiteDias Then
  Begin
    pDesabilitaHabilitaTimerECarregaEventoOnTimer(True,
                                                  tmrImpFranq, tmrImpFranqOnTimer, 'tmrImpFranq',
                                                  Self,
                                                  fCfgSis('TMPIMP', varInteger) * 1000 * 60);
  End Else
  Begin
    pDesabilitaTimer(tmrImpFranq);
  End;

  if fCfgSis('BOXWMS', varBoolean) Then
  Begin
    mnuCadBoxWms.Visible := True;
    mnuCadBoxWms.Tag     := 0;
  End
  Else
  Begin
    mnuCadBoxWms.Visible := False;
    mnuCadBoxWms.Tag     := 1;
  End;

  { ETIQUETA DE CAIXAS }
  If (fCfgSis('CFVLCB') = 'S') And (fCfgSis('CFVBCX') = 'S') Then
  Begin
    mnuEtiquetaCaixas.Visible        := True;
    mnuEditorEtiquetasCaixas.Visible := True;
  End
  Else
  Begin
    mnuEtiquetaCaixas.Visible        := False;
    mnuEditorEtiquetasCaixas.Visible := False;
  End;

  If fCfgSis('MONCAI', varBoolean) And (Pos(VS_strTipExp, '3_4') > 0) Then
    mnuEditorEtiquetasMontagemCaixas.Visible := True
  Else
    mnuEditorEtiquetasMontagemCaixas.Visible := False;

  {*If fCfgSis('FUSUSA', varBoolean) Then
  Begin
    mnuLibVendasEntrega.Tag     := 0;
    mnuLibVendasEntrega.Visible := True;
  End
  Else
  Begin
    mnuLibVendasEntrega.Tag     := 1;
    mnuLibVendasEntrega.Visible := False;
  End;*}

  mnuLibVendasEntrega.Tag     := 1;
  mnuLibVendasEntrega.Visible := False;

  mnuLimparSeparaodoPedidodeVenda.Visible := fUsaOndaSeparacaoAgrupamento;
  mnuLimparSeparaodoPedidodeVenda.Tag     := IIF(mnuLimparSeparaodoPedidodeVenda.Visible, 0, 1);

  if fCfgSis('USABEF', varBoolean) then
  begin
    mnuCadBeneficioFiscal.Visible := True;
    mnuCadBeneficioFiscal.Tag     := 0;
  end
  else
  begin
    mnuCadBeneficioFiscal.Visible := False;
    mnuCadBeneficioFiscal.Tag     := 1;
  end;

  if fCfgSis('VENOUT', varBoolean) then
  begin
    mnuVendaForadoEstabelecimento.Visible := True;
    mnuVendaForadoEstabelecimento.Tag     := 0;
  end
  else
  begin
    mnuVendaForadoEstabelecimento.Visible := False;
    mnuVendaForadoEstabelecimento.Tag     := 1;
  end;

  If fCfgSis('ALTGIR', varBoolean) Then
  begin
    mnuCadProdutosAltoGiro.Visible := True;
    mnuCadProdutosAltoGiro.Tag := 0;
  end
  else
  begin
    mnuCadProdutosAltoGiro.Visible := False;
    mnuCadProdutosAltoGiro.Tag := 1;
  end;

  If fCfgSis('COMFLU', varBoolean) Then
  begin
    mnuFluxoCompras.Visible := True;
    mnuFluxoCompras.Tag := 0;

    mnuCadPendencias.Visible := True;
    mnuCadPendencias.Tag := 0;
  end
  else
  begin
    mnuFluxoCompras.Visible := False;
    mnuFluxoCompras.Tag := 1;

    mnuCadPendencias.Visible := False;
    mnuCadPendencias.Tag := 1;
  end;

  If fCfgSis('CONCOL', varBoolean) Then
  begin
    mnuCadLocalDaMercadoria.Visible := True;
    mnuCadLocalDaMercadoria.Tag := 0;

    mnuConsultaControleDeColeta.Visible := True;
    mnuConsultaControleDeColeta.Tag := 0;
  end
  else
  begin
    mnuCadLocalDaMercadoria.Visible := False;
    mnuCadLocalDaMercadoria.Tag := 1;

    mnuConsultaControleDeColeta.Visible := False;
    mnuConsultaControleDeColeta.Tag := 1;
  end;

  If fCfgSis('ESTEXT', varBoolean) Then
  Begin
    mnuCadEmpresasEstoqueExterno.Visible := True;
    mnuCadEmpresasEstoqueExterno.Tag     := 0;
  End
  Else
  Begin
    mnuCadEmpresasEstoqueExterno.Visible := False;
    mnuCadEmpresasEstoqueExterno.Tag     := 1;
  End;

  pHabilitarMenusOrdSerVenda();

  mnuAltVendTemp.Visible := fCfgSis('MLTOPE', varBoolean);
  mnuAltVendTemp.Tag     := IIF(mnuAltVendTemp.Visible, 0, 1);

  mnuAltGlobalVenMar.Visible := fCfgSis('MLTOPE', varBoolean);
  mnuAltGlobalVenMar.Tag     := IIF(mnuAltGlobalVenMar.Visible, 0, 1);

  mnuGrupoRisco.Visible := fCfgSis('GRRSCL', varBoolean);
  mnuGrupoRisco.Tag     := IIF(mnuGrupoRisco.Visible, 0, 1);

  mnuCadFaixaPrzMed.Visible := fCfgSis('PRZMED', varBoolean);
  mnuCadFaixaPrzMed.Tag     := IIF(mnuCadFaixaPrzMed.Visible, 0, 1);

  mnuCadFreteFaixaFaturamento.Visible := (fCfgSis('FRETRA') = FRETRA_POR_FAIXA_FATURAMENTO);
  mnuCadFreteFaixaFaturamento.Tag     := IIF(mnuCadFreteFaixaFaturamento.Visible, 0, 1);
  mnuAtualizacaoCotacaoDolarNosCatalogos.Visible := fCfgSisLoc('COTDOR', varBoolean);

  {Sinaleiro de Faturamento - Faixa de Margem/Markup x Vendedor}
  mnuCadSinaleiroFaturamento.Visible := fCfgSis('UTISIN', varBoolean);
  mnuCadSinaleiroFaturamento.Tag     := IIF(mnuCadSinaleiroFaturamento.Visible, 0, 1);

  {Liberação de Pedidos Externos}
  mnuLiberaodePedidosExternos.Visible := fCfgSis('LIBEXT', varBoolean);
  mnuLiberaodePedidosExternos.Tag     := IIF(mnuLiberaodePedidosExternos.Visible, 0, 1);

  {Categoria para Orçamento / Pedido}
  mnuCategoriaOrcamentoPedido.Visible := (fCfgSis('UTICAO', varBoolean) Or fCfgSis('UTICAP', varBoolean)) And fVerificaAcessoSistema(mnuCategoriaOrcamentoPedido.Hint);
  mnuCategoriaOrcamentoPedido.Tag     := IIF(mnuCategoriaOrcamentoPedido.Visible, 0, 1);

  {Tabela de Qualificação}
  mnuQualificaodeClientes.Visible     := fCfgSis('USAQUA', varBoolean) And fVerificaAcessoSistema(mnuQualificaodeClientes.Hint);
  mnuQualificaodeClientes.Tag         := IIF(mnuQualificaodeClientes.Visible, 0, 1);

  {Romaneio Simplificado}
  mnuFatRomaneioSimplificado.Visible := fVerificaAcessoSistema(mnuFatRomaneioSimplificado.Hint) And (fCfgSis('OPCROM', varString) <> '1');
  mnuFatRomaneioSimplificado.Tag     := IIF(mnuFatRomaneioSimplificado.Visible, 0, 1);

  {Devolução Rápida}
  mnuFatDevolucaoRapida.Visible := fVerificaAcessoSistema('DEVRAP');
  mnuFatDevolucaoRapida.Tag     := IIF(mnuFatDevolucaoRapida.Visible, 0, 1);

  //CFG_PREMDV - Devolução Não Controlada DEVE FICAR ABERTA
  //CFG_PREMTE - Transferência Estoque Não Controlada DEVE FICAR ABERTA
  //CFG_PREMFF - Faturamento Futuro Não Controlada no menu TIPO DE FECHAMENTO
  //CFG_PREMMI - Movimentação de Itens Não Controlada no menu TIPO DE FECHAMENTO
  pHabilitarItemMenu(mnuEmprestimosdeDocumentos, fPermiteEmissaoEspecie('EP')); //CFG_PREMEP
  pHabilitarItemMenu(mnuFatTrocaMerc, fPermiteEmissaoEspecie('TR')); //CFG_PREMTR
  //pHabilitarItemMenu(mnuFatVendaUsoConsumo, fPermiteEmissaoEspecie('UC')); //CFG_PREMUC
  //pHabilitarItemMenu(mnuFatBrinde, fPermiteEmissaoEspecie('BR')); //CFG_PREMBR

  TMenuContabilidade.EsconderItemMenu(Self);

  mnuProjeto.Visible := fCfgSis('UTLPRJ', varBoolean);
  mnuProjeto.Tag    := IIF(mnuProjeto.Visible, 0, 1);
  mnuDigRecursosProjeto.Visible := mnuProjeto.Visible;
  mnuDigRecursosProjeto.Tag     := mnuProjeto.Tag;

  {*******************************************************}
  {* LIBERA OPÇÃO NO MENU PARA O ESTADO DISTRITO FEDERAL *}
  {****************************************************FS*}
  if Not fCfgSis('SOLCSV', varBoolean) then
  begin
    mnuSubServicos.Tag:= 1;
    mnuSubServicos.Visible:= False;
  end
  else
  begin
    mnuSubServicos.Tag:= 0;
    mnuSubServicos.Visible:= True;
  end;

  If fCfgSis('IPRNFS', varBoolean) Then
  Begin
    mnuEntImportaNFSe.Visible := True;
    mnuEntImportaNFSe.Tag     := 0;

    if Not fCfgSis('SOLCSV', varBoolean) then
    Begin
      mnuSubServicos.Tag:= 0;
      mnuSubServicos.Visible:= True;
    End;

  End
  Else
  Begin
    mnuEntImportaNFSe.Visible := False;
    mnuEntImportaNFSe.Tag     := 1;
  End;

  If fCfgSis('SUFRAM', varBoolean) Then
  Begin
    mnuFatReg.Tag := 0;
    mnuFatReg.Visible := True;
  End
  Else
  Begin
    mnuFatReg.Tag := 1;
    mnuFatReg.Visible := False;
  End;

  If fCfgSis('UTICPP', varBoolean) Then
  Begin
    mnuCadCupomPromProd.Tag := 0;
    mnuCadCupomPromProd.Visible := True;
  End
  Else
  Begin
    mnuCadCupomPromProd.Tag := 1;
    mnuCadCupomPromProd.Visible := False;
  End;

  If (fCfgSis('SEPCON', varBoolean) Or fCfgSis('SEPLAZ', varBoolean) or fCfgSis('SOLOLA', varBoolean)) And
     fVerificaAcessoSistema(mnuCadLocalArmazenamentoWMS.Hint) Then
  Begin
    mnuCadLocalArmazenamentoWMS.Tag     := 0;
    mnuCadLocalArmazenamentoWMS.Visible := True;
  End
  Else
  Begin
    mnuCadLocalArmazenamentoWMS.Tag     := 1;
    mnuCadLocalArmazenamentoWMS.Visible := False;
  End;

  If fCfgSis('SEPCON', varBoolean) And fVerificaAcessoSistema(mnuEtiquetasLocalArmazenamentoWMSArgox.Hint) Then
  Begin
    mnuEtiquetasLocalArmazenamentoWMSArgox.Tag     := 0;
    mnuEtiquetasLocalArmazenamentoWMSArgox.Visible := True;
  End
  Else
  Begin
    mnuEtiquetasLocalArmazenamentoWMSArgox.Tag     := 1;
    mnuEtiquetasLocalArmazenamentoWMSArgox.Visible := False;
  End;

  If fCfgSis('SEPCON', varBoolean) And fVerificaAcessoSistema(mnuEtiquetasLocalArmazenamentoWMSLaser.Hint) Then
  Begin
    mnuEtiquetasLocalArmazenamentoWMSLaser.Tag     := 0;
    mnuEtiquetasLocalArmazenamentoWMSLaser.Visible := True;
  End
  Else
  Begin
    mnuEtiquetasLocalArmazenamentoWMSLaser.Tag     := 1;
    mnuEtiquetasLocalArmazenamentoWMSLaser.Visible := False;
  End;

  If fCfgSis('SEPCON', varBoolean) And fVerificaAcessoSistema(mnuEtiquetasRegioesArgox.Hint) Then
  Begin
    mnuEtiquetasRegioesArgox.Tag     := 0;
    mnuEtiquetasRegioesArgox.Visible := True;
  End
  Else
  Begin
    mnuEtiquetasRegioesArgox.Tag     := 1;
    mnuEtiquetasRegioesArgox.Visible := False;
  End;

  If fCfgSis('SEPCON', varBoolean) And fVerificaAcessoSistema(mnuEtiquetasRegioesLaser.Hint) Then
  Begin
    mnuEtiquetasRegioesLaser.Tag     := 0;
    mnuEtiquetasRegioesLaser.Visible := True;
  End
  Else
  Begin
    mnuEtiquetasRegioesLaser.Tag     := 1;
    mnuEtiquetasRegioesLaser.Visible := False;
  End;

  If (fCfgSis('UPSEML', varBoolean)) And (fCfgSis('EMPFAT', varBoolean)) Then
  Begin
    mnuPrioridadeSaidaEstoqueEmpresa.Tag := 0;
    mnuPrioridadeSaidaEstoqueEmpresa.Visible := True;
  End
  Else
  Begin
    mnuPrioridadeSaidaEstoqueEmpresa.Tag := 1;
    mnuPrioridadeSaidaEstoqueEmpresa.Visible := False;
  End;

  If (fCfgSis('OPCCOM') = 'PPT') Then
  Begin
    mnuCadComissaoProdTabPre.Tag := 0;
    mnuCadComissaoProdTabPre.Visible := True;
  End
  Else
  Begin
    mnuCadComissaoProdTabPre.Tag := 1;
    mnuCadComissaoProdTabPre.Visible := False;
  End;


  If fCfgSis('CNDPES',varBoolean) Then
  Begin
    mnuCadCondPagtoEspecialProdutos.Tag := 0;
    mnuCadCondPagtoEspecialProdutos.Visible := True;
  End
  Else
  Begin
    mnuCadCondPagtoEspecialProdutos.Tag := 1;
    mnuCadCondPagtoEspecialProdutos.Visible := False;
  End;

  If fCfgSis('FREREG',varBoolean) Then
  Begin
    mnuCadFreteRegiao.Tag := 0;
    mnuCadFreteRegiao.Visible := True;
  End
  Else
  Begin
    mnuCadFreteRegiao.Tag := 1;
    mnuCadFreteRegiao.Visible := False;
  End;

  If fCfgSis('USAVOI',varBoolean) And fVerificaAcessoSistema('ACEVOI') Then
  Begin
    mnuPortos.Tag         := 0;
    mnuPortos.Visible     := True;

    mnuAeroportos.Tag     := 0;
    mnuAeroportos.Visible := True;

    mnuIncoterms.Tag      := 0;
    mnuIncoterms.Visible  := True;
  End
  Else
  Begin
    mnuPortos.Tag         := 1;
    mnuPortos.Visible     := False;

    mnuAeroportos.Tag     := 1;
    mnuAeroportos.Visible := False;

    mnuIncoterms.Tag      := 1;
    mnuIncoterms.Visible  := False;
  End;

  mnuCadMatrizBasesDifal.Visible := fCfgSis('BASDFL', varBoolean) And fVerificaAcessoSistema('MABADI');
  mnuCadMatrizBasesDifal.Tag     := IIF(mnuCadMatrizBasesDifal.Visible, 0, 1);

  mnuEnvioConfirmacaoSefaz.Visible := fCfgSis('SEFREC', varBoolean);

  mnuMontQuadroFuncEvento.Visible := fCfgSis('EVEDTQ', varBoolean);
  mnuMontQuadroFuncEvento.Tag     := IIF(mnuMontQuadroFuncEvento.Visible, 0, 1);

  mnuMandaeEnvioEncomendas.Visible := fCfgSis('MANUSA', varBoolean);
  mnuMandaeEnvioEncomendas.Tag     := IIF(mnuMandaeEnvioEncomendas.Visible, 0, 1);

  mnuCancelamentoPedidoJadlog.Visible := fCfgSis('USAJAD', varBoolean) And fVerificaAcessoSistema(mnuCancelamentoPedidoJadlog.Hint);
  mnuCancelamentoPedidoJadlog.Tag     := IIF(mnuMandaeEnvioEncomendas.Visible, 0, 1);

  mnuFatTransfEstDevEmpCarregamento.Visible := fCfgSis('EMPCAR', varBoolean);
  mnuFatTransfEstDevEmpCarregamento.Tag     := IIF(mnuFatTransfEstDevEmpCarregamento.Visible, 0, 1);

  mnuRelEstOrdensBaixadasParcialmenteEmAberto.Visible := fCfgSis('OIBXPA', varBoolean);
  mnuRelEstOrdensBaixadasParcialmenteEmAberto.Tag     := IIF(mnuRelEstOrdensBaixadasParcialmenteEmAberto.Visible, 0, 1);

  mnuRelacionamentoClienteProdutoGarantia.Visible := fVerificaAcessoSistema(mnuRelacionamentoClienteProdutoGarantia.Hint);
  mnuRelacionamentoClienteProdutoGarantia.Tag     := IIF(mnuRelacionamentoClienteProdutoGarantia.Visible, 0, 1);

  mnuFatRomaneioManutencao.Visible := fVerificaAcessoSistema(mnuFatRomaneioManutencao.Hint);
  mnuFatRomaneioManutencao.Tag     := IIF(mnuFatRomaneioManutencao.Visible, 0, 1);

  mnuMenuFiscalPafNFCe.Visible := fCfgSis('PAFSC_', varBoolean);
  mnuMenuFiscalPafNFCe.Tag     := IIF(mnuMenuFiscalPafNFCe.Visible, 0, 1);

  {* LOCAÇÃO DE EQUIPAMENTOS - INÍCIO *}

  mnuLibLocEquip.Visible := (fCfgSisLoc('LOCLIB', varBoolean));
  mnuLibLocEquip.Tag     := IIF(mnuLibLocEquip.Visible, 0, 1);

  mnuTrocaLocEqu.Visible := fVerificaAcessoSistema(mnuTrocaLocEqu.Hint);
  mnuTrocaLocEqu.Tag     := IIF(mnuTrocaLocEqu.Visible, 0, 1);

  mnuProrrogaContratoLocEq.Visible := fVerificaAcessoSistema(mnuProrrogaContratoLocEq.Hint);
  mnuProrrogaContratoLocEq.Tag     := IIF(mnuProrrogaContratoLocEq.Visible, 0, 1);

  mnuCancelaLocEqu.Visible := fVerificaAcessoSistema(mnuCancelaLocEqu.Hint);
  mnuCancelaLocEqu.Tag     := IIF(mnuCancelaLocEqu.Visible, 0, 1);

  mnuManutencaoLocEq.Visible := fVerificaAcessoSistema(mnuManutencaoLocEq.Hint);
  mnuManutencaoLocEq.Tag     := IIF(mnuManutencaoLocEq.Visible, 0, 1);

  mnuConsultaCadLocEqu.Visible := fVerificaAcessoSistema(mnuConsultaCadLocEqu.Hint) And (fCfgSisLoc('LOCEQU', varBoolean));
  mnuConsultaCadLocEqu.Tag     := IIF(mnuConsultaCadLocEqu.Visible, 0, 1);

  {* LOCAÇÃO DE EQUIPAMENTOS - FIM *}

  If fCfgSis('ISPCMP', VarBoolean) Then
  Begin
    mnuReimpressaoCompInspecao.Visible := fVerificaAcessoSistema(mnuReimpressaoCompInspecao.Hint);
    mnuReimpressaoCompInspecao.Tag     := IIF(mnuReimpressaoCompInspecao.Visible, 0, 1);
  End
  Else
    mnuReimpressaoCompInspecao.Visible := False;

  
  If Not ((fCfgSis('LRGMIC', varBoolean)) and (fCfgSis('UTIWMS', varBoolean))) Then
  Begin
    mnuMapaDeInventarioParaColetores.Visible := False;
    mnuBalancoEstoqueZera.Visible := true;
    If fCfgSisLoc('CTLEST') = '2' Then
    begin
      mnuBalancoEstoqueImportar.Visible := true;
      mnuBalancoIniciaArmazem.Visible := true;
      mnuBalancoFinalizaArmazem.Visible := true;
      mnuBalancoEstoqueDigManual.Visible := true;
      mnuBalancoEstoqueDigColetivo.Visible := true;
    end;
  End
  Else If ((fCfgSis('LRGMIC', varBoolean)) and (fCfgSis('UTIWMS', varBoolean))) Then
  begin
    mnuMapaDeInventarioParaColetores.Visible := True;
    mnuBalancoEstoqueZera.Visible := False;
    mnuBalancoEstoqueImportar.Visible := False;
    mnuBalancoIniciaArmazem.Visible := False;
    mnuBalancoFinalizaArmazem.Visible := False;
    mnuBalancoEstoqueDigManual.Visible := False;
    mnuBalancoEstoqueDigColetivo.Visible := False;
  End;

  mnuRecorrenciaOcorrencia.Visible := fCfgSis('OCOREC', varBoolean);
  mnuRecorrenciaOcorrencia.Tag     := IIF(mnuRecorrenciaOcorrencia.Visible, 0, 1);

  mnuCadAdquirenteCartao.Visible := OperadorCitelLogado and fCadastroCartaoParamAutTef ;
  mnuCadAdquirenteCartao.Tag     := IIF(mnuCadAdquirenteCartao.Visible, 0, 1);

  mnuAgrupamentoDeOndaDeSeparacao.Visible := fUsaOndaSeparacaoAgrupamento;
  mnuAgrupamentoDeOndaDeSeparacao.Tag     := IIF(mnuAgrupamentoDeOndaDeSeparacao.Visible, 0, 1);

  mnuFatAltEvento.Visible := fCfgSis('EVEFAT', varBoolean);
  mnuFatAltEvento.Tag     := IIF(mnuFatAltEvento.Visible, 0, 1);

  If Not FileExists(ExtractFilePath(Application.ExeName) + 'libFiscalCat42.dll') Then
  Begin
    mnuCat42.Visible                   := False;
    mnuExpCat42.Visible                := False;
    mnuRelatorioCat42.Visible          := False;
    mnuConfiguraoEnquadramento.Visible := False;
    mnuConfiguraoCat42.Visible         := False;
  End;

  mnuBarrinha     := Nil;
  mnuAutcomK.BeginUpdate;
  For intContador := 0 To mnuAutcomK.Items.Count -1 Do
  Begin
    pProgresso(pgbStatus, Succ(intContador), mnuAutcomK.Items.Count, mnuAutcomK.Items[intContador].Caption + ' ...');

    If fVerificaAcessoSistema(mnuAutcomK.Items[intContador].Hint) Then
    Begin

      If (mnuAutcomK.Items[intContador].Caption <> '|') And (mnuAutcomK.Items[intContador].Visible) Then
      Begin
        {*****************************}
        {* ADICIONA NOVO ITEM NO TRV *}
        {**************************AF*}
        pVerificaMenu(mnuAutcomK.Items[intContador],trvItem, pgbStatus);
      End;

    End
    Else
    Begin
      If fCfgSisLoc('MOSMNU', varBoolean) Then
      Begin
        mnuAutcomK.Items[intContador].Enabled := False;
      End
      Else
      Begin
        mnuAutcomK.Items[intContador].Visible := False;
      End;

    End;
  End;

  pMarcarEtiquetasConfiguradas;

  mnuDashboard.Visible := fDashboardHabilitadaParaUsuario;

  mnuPainelEntregas.Visible := fPainelEntregasDireitoAcessoLiberado(fCfgSisLoc('MATDIS') = 'S');

  mnuPedLiberacao.Tag := 1;
  mnuPedLiberacao.Visible := False;

  mnuRecebimentoTransbordo.Visible := fCfgSis('UTITDE', varBoolean);
  mnuRecebimentoTransbordo.Tag     := IIF(mnuRecebimentoTransbordo.Visible, 0, 1);

  mnuSintegra.Visible := FileExists(ExtractFilePath(Application.ExeName) + 'sintegra-1.0.exe');
  mnuConverte.Visible := FileExists(ExtractFilePath(Application.ExeName) + 'ConvertePISCOFINS.exe');

  mnuCadEtiquetaVolumeEtiquetaDespacho.Visible := (fCfgSis('ETIDCE', varBoolean)) And (fVerificaAcessoSistema(mnuCadEtiquetaVolumeEtiquetaDespacho.Hint));
  mnuCadEtiquetaVolumeEtiquetaDespacho.Tag := IIF(mnuCadEtiquetaVolumeEtiquetaDespacho.Visible, 0, 1);
  mnuEditorEtiquetasDespachoVolumeGeral.Visible := (fCfgSis('ETIDCE', varBoolean)) And (fVerificaAcessoSistema(mnuEditorEtiquetasDespachoVolumeGeral.Hint));
  mnuEditorEtiquetasDespachoVolumeGeral.Tag := IIF(mnuEditorEtiquetasDespachoVolumeGeral.Visible, 0, 1);
  mnuEditorEtiquetasDespachoVolumeIndividual.Visible := (fCfgSis('ETIDCE', varBoolean)) And (fVerificaAcessoSistema(mnuEditorEtiquetasDespachoVolumeIndividual.Hint));
  mnuEditorEtiquetasDespachoVolumeIndividual.Tag := IIF(mnuEditorEtiquetasDespachoVolumeIndividual.Visible, 0, 1);

  mnuCadComFaiFatDepVenProFator.Visible := ((fCfgSis('FATACN', varBoolean)) And (fCfgSis('OPCCOM', varString) = 'PPT'));
  mnuCadComFaiFatDepVenProFator.Tag := IIF(mnuCadComFaiFatDepVenProFator.Visible, 0, 1);

  mnuCadRestricaoVenda.Visible := (fCfgSis('UTCRVP', varBoolean));
  mnuCadRestricaoVenda.Tag     := IIF(mnuCadRestricaoVenda.Visible, 0, 1);

  mnuNCMparaoutrospases.Visible := True;

  mnuImpCupPro.Visible := (fVerificaAcessoSistema(mnuImpCupPro.Hint));

  mnuRemessaDevolucao.Visible := ((fUsaRotinaWMS()) And (fCfgSis('UTIRRD', varBoolean)) And (fVerificaAcessoSistema(mnuRemessaDevolucao.Hint)));
  mnuRemessaDevolucao.Tag := IIF(mnuRemessaDevolucao.Visible, 0, 1);

  mnuCadMontagemCaixa.Visible := fAtivadoMontagemCaixaConferenciaAUTCOMColetor;

  mnuVendaBaseTroca.Visible := fCfgSisLoc('USAVBT', varBoolean);
  mnuVendaBaseTroca.Tag     := IIF(mnuVendaBaseTroca.Visible, 0, 1);

  mnuManutNumSerieItens.Visible := (fCfgSis('NUMSER', varBoolean) And (fVerificaAcessoSistema(mnuManutNumSerieItens.Hint)));
  mnuManutNumSerieItens.Tag     := IIF(mnuManutNumSerieItens.Visible, 0, 1);

  mnuFatManPedCortadoFaltaEstoque.Visible := fCfgSis('ONDAGR', varBoolean);
  mnuFatManPedCortadoFaltaEstoque.Tag     := IIF(mnuFatManPedCortadoFaltaEstoque.Visible, 0, 1);

  If fArqIni(0, 'GERAL', 'USAACP',  '') = 'S' Then
  Begin
    mnuFatAnaliseCustoPedido.Visible := fCfgSis('USAACP', varBoolean);
    mnuFatAnaliseCustoPedido.Tag := IIF(mnuFatAnaliseCustoPedido.Visible, 0, 1);
  End;

  mnuCadVenDiaEmp.Visible := fCfgSis('EVDECA', varBoolean);
  mnuCadVenDiaEmp.Tag     := IIF(mnuCadVenDiaEmp.Visible, 0, 1);

  mnuCadOcorrenciasDoColetor.Visible := fCfgSis('UTOCOL', varBoolean) And (fVerificaAcessoSistema(mnuCadOcorrenciasDoColetor.Hint));
  mnuCadOcorrenciasDoColetor.Tag     := IIF(mnuCadOcorrenciasDoColetor.Visible, 0, 1);

  mnuCashback.Visible := fCfgSis('CBKUTI', varBoolean);
  mnuImportaPROSER.Visible := fCfgSis('NUMSER', varBoolean) And (fVerificaAcessoSistema(mnuImportaPROSER.Hint));
  mnuImportaPROSER.Tag     := IIF(mnuImportaPROSER.Visible, 0, 1);

  pHabilitarItemMenu(mnuImportProdutoVeiculo, fCfgSis('PROVEI', varBoolean));

  mnuNCMEmpresa.Visible := fCfgSis('NCMEMP', varBoolean) And fVerificaAcessoSistema(mnuNCMEmpresa.Hint);
  mnuNCMEmpresa.Tag     := IIF(mnuNCMEmpresa.Visible, 0, 1);

  mnuSolicitacaoManutencaoEquipamentosInternos.Visible := fCfgSis('URMEIE', varBoolean) And fVerificaAcessoSistema(mnuSolicitacaoManutencaoEquipamentosInternos.Hint);
  mnuSolicitacaoManutencaoEquipamentosInternos.Tag     := IIF(mnuSolicitacaoManutencaoEquipamentosInternos.Visible, 0, 1);

  mnuLiberacaoManutencaoEquipamentosInternos.Visible := fCfgSis('URMEIE', varBoolean) And fVerificaAcessoSistema(mnuLiberacaoManutencaoEquipamentosInternos.Hint);
  mnuLiberacaoManutencaoEquipamentosInternos.Tag     := IIF(mnuLiberacaoManutencaoEquipamentosInternos.Visible, 0, 1);

  mnuLibAcessoWS.Visible := fCfgSis('UTIEND', varBoolean);
  mnuLibAcessoWS.Tag := IIF(mnuLibAcessoWS.Visible, 0, 1);

  If Assigned(objRelatorio) Then
    objRelatorio.pHabilitaMenus;

  mnuCadFasesOrdProd.Visible := fCfgSis('MONFAS', varBoolean) And (fVerificaAcessoSistema(mnuCadFasesOrdProd.Hint));
  mnuMonitorFasesOrdProd.Visible := mnuCadFasesOrdProd.Visible And (fVerificaAcessoSistema(mnuMonitorFasesOrdProd.Hint));
  mnuOrdProEmissaoPerdaRefugo.Visible :=mnuCadFasesOrdProd.Visible And (fVerificaAcessoSistema(mnuOrdProEmissaoPerdaRefugo.Hint));


  mnuFatReimpressaoManifestoEletronico.Visible := fVerificaAcessoSistema(mnuFatReimpressaoManifestoEletronico.Hint);
  mnuFatReimpressaoManifestoEletronico.Tag     := IIF(mnuFatReimpressaoManifestoEletronico.Visible, 0, 1);

  mnuCadastroDeAlquotasDeICMSporEstado.Visible := fVerificaAcessoSistema(mnuCadastroDeAlquotasDeICMSporEstado.Hint);
  mnuCadastroDeAlquotasDeICMSporEstado.Tag     := IIF(mnuCadastroDeAlquotasDeICMSporEstado.Visible, 0, 1);

  mnuAutcomK.EndUpdate;
End;

procedure TfrmPrincipal.pProcessaMenusCRM;
begin

  If (Not VS_strHabilitarCRM) Then
  Begin

    mnuCRM.Tag     := 1;
    mnuCRM.Visible := False;

    mnuRelCRM.Tag     := 1;
    mnuRelCRM.Visible := False;

    mnuCadCRM.Tag     := 1;
    mnuCadCRM.Visible := False;

    mnuUtilCRM.Tag     := 1;
    mnuUtilCRM.Visible := False;

    mnuEmailMarketingProspectos.Tag     := 1;
    mnuEmailMarketingProspectos.Visible := False;

    mnuCadTemperaturaAtendimentoCRM.Tag     := 1;
    mnuCadTemperaturaAtendimentoCRM.Visible := False;

  End
  Else
  Begin

    mnuCRM.Tag     := 0;
    mnuCRM.Visible := True;

    mnuRelCRM.Tag     := 0;
    mnuRelCRM.Visible := True;

    mnuCadCRM.Tag     := 0;
    mnuCadCRM.Visible := True;

    mnuUtilCRM.Tag     := 0;
    mnuUtilCRM.Visible := True;

    mnuEmailMarketingProspectos.Tag     := 0;
    mnuEmailMarketingProspectos.Visible := True;

    mnuCadTemperaturaAtendimentoCRM.Tag     := 0;
    mnuCadTemperaturaAtendimentoCRM.Visible := (fCfgSis('CRMTEA', varBoolean));
  End;
end;

procedure TfrmPrincipal.pProcessarMenusLocacaoEquipamento;
begin
  If (fCfgSis('LOCEQU', varBoolean)) Then
  Begin

    mnuEquLocacao.Visible := True;
    mnuEquLocacao.Tag     := 0;

    mnuCadAclLocacao.Visible := IIF(fCfgSis('UTIACE', varBoolean), True, False);
    mnuCadAclLocacao.Tag     := IIF(fCfgSis('UTIACE', varBoolean), 0, 1);

    mnuCadEquLocacao.Visible := True;
    mnuCadEquLocacao.Tag     := 0;

    mnuLocacaoEquip.Visible := True;
    mnuLocacaoEquip.Tag     := 0;

    mnuLocacaoEquipamentos.Visible := True;
    mnuLocacaoEquipamentos.Tag     := 0;

    mnuUtilLocacaoEquipamento.Visible := fVerificaAcessoSistema('frmUtilLocacaoEquipamento');
    mnuUtilLocacaoEquipamento.Tag := 0;

    mnufrmImportarCadLocEqu.Visible := fVerificaAcessoSistema('frmImportarCadLocEqu');
    mnufrmImportarCadLocEqu.Tag := 0;

  End Else
  Begin
    mnuCadEquLocacao.Visible := False;
    mnuCadEquLocacao.Tag     := 1;

    mnuLocacaoEquip.Visible := False;
    mnuLocacaoEquip.Tag     := 1;

    mnuLocacaoEquipamentos.Visible := False;
    mnuLocacaoEquipamentos.Tag     := 1;

    mnuEquLocacao.Visible := False;
    mnuEquLocacao.Tag     := 1;

    mnuCadAclLocacao.Visible := False;
    mnuCadAclLocacao.Tag     := 1;

    mnuUtilLocacaoEquipamento.Visible := False;
    mnuUtilLocacaoEquipamento.Tag :=  1;

    mnufrmImportarCadLocEqu.Visible := False;
    mnufrmImportarCadLocEqu.Tag     := 1;
  End;

  mnuDivergenciasSeparacao.Visible := fCfgSis('DVSPCL', varBoolean);
end;

procedure TfrmPrincipal.mnuCadGruOperadorNovoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadGruOperadorNovo);
end;

procedure TfrmPrincipal.mnuDirAcessoClick(Sender: TObject);
begin
  fExecutarModal(procedure
                 begin
                   pProcessaDicOrdenaMenuItem(Nil);
                 end,
                 'Aguarde, ordenando itens...',
                 EmptyStr);

  pCriarForm(TfrmDirAcesso);
end;

procedure TfrmPrincipal.mnuPedidoComprasClick(Sender: TObject);
 (* Var
    hwdDllPedido: Cardinal;
    pPedidoDeCompra: procedure; stdcall;
    pSetDigSenVar : Procedure (objSenVar : IDigSenVar); stdcall;
    *)
begin
(*  hwdDllPedido := fLoadLibraryPedidoCompra;

  If hwdDllPedido > 0 Then
  Begin
    pPedidoDeCompra := GetProcAddress(hwdDllPedido, PChar('pPedidoDeCompra'));
    pSetDigSenVar   :=  GetProcAddress(hwdDllPedido, PChar('pSetDigSenVar'));
    pSetDigSenVar( TDigSenVar.Create );
    pPedidoDeCompra;
  End;
  *)

  pPedidoDeCompraAutCom;
end;

procedure TfrmPrincipal.mnuPedidoDeCompraImpAutcomClick(Sender: TObject);
begin
  pCriarForm(TfrmPedidoDeCompraImpAutcom);
end;

procedure TfrmPrincipal.mnuPedidoDeCompraImpEdiSawluzClick(Sender: TObject);
begin
  pCriarForm(TfrmPedidoDeCompraImpEdiSawluz);
end;

procedure TfrmPrincipal.mnuPerguntasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPerguntas);
end;

procedure TfrmPrincipal.mnuPesarProdutosClick(Sender: TObject);
begin
  pCriarForm(TfrmPesarProdutos);
end;

procedure TfrmPrincipal.mnuPesquisasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPesquisas);
end;

procedure TfrmPrincipal.mnuPgtoOnlineESiTefManutencaoClick(Sender: TObject);
  var
    frmPgtoOnlineESiTefManutencao : TfrmPgtoOnlineESiTefManutencao;
begin
  Try
    pCriarFormularios(TfrmPgtoOnlineESiTefManutencao, frmPgtoOnlineESiTefManutencao);
    frmPgtoOnlineESiTefManutencao.ShowModal;
  Finally
    pFreeAndNil(frmPgtoOnlineESiTefManutencao);
  End;
end;

procedure TfrmPrincipal.mnuPgtoOnlineESiTefParChavesManutencaoClick(
  Sender: TObject);
var
  LfrmPgtoOnlineESiTefParChavesManutencao: TfrmPgtoOnlineESiTefParChavesManutencao ;
  LstrSenha: String ;
begin

  If ffrmSenha(LstrSenha) Then
  Begin
    If LstrSenha = SEN_ESTSIT Then
    Begin
      pCriarFormularios(TfrmPgtoOnlineESiTefParChavesManutencao, LfrmPgtoOnlineESiTefParChavesManutencao) ;
      try
        LfrmPgtoOnlineESiTefParChavesManutencao.ShowModal ;
      finally
        pFreeAndNil(LfrmPgtoOnlineESiTefParChavesManutencao) ;
      end;
    End
    Else
    Begin
      fMensagem('', 'Senha Incorreta!', ['&Ok']);
    End;
  End;

end;

procedure TfrmPrincipal.mnuPlanoContabilPorCfopClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPlanoContasPorCfop);
end;

procedure TfrmPrincipal.mnuPlanoContabilPorCstClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPlanoContasPorCst);
end;

procedure TfrmPrincipal.mnuPlanodecontascontabeisClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPlanConCon);
end;

procedure TfrmPrincipal.mnuCancelamentoPedidoClick(Sender: TObject);
begin
  pCriarForm(TfrmCancelamentoPedido);
end;

procedure TfrmPrincipal.mnuCancelaOrdemProdClick(Sender: TObject);
begin
  pCriarForm(TfrmCancelaBaixaOrdProd);
end;

procedure TfrmPrincipal.mnuCadMontagemCaixaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMontagemCaixa);
end;

procedure TfrmPrincipal.mnuCadCaixasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCaixas);
end;

procedure TfrmPrincipal.mnuCadCargosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCargos);
end;

procedure TfrmPrincipal.mnuCadCarteiraDigitalClick(Sender: TObject);
var
  LfrmCadCarteiraDigital : TfrmCadCarteiraDigital ;
begin
  pCriarFormularios(TfrmCadCarteiraDigital, LfrmCadCarteiraDigital);
  try
    Try
      LfrmCadCarteiraDigital.showModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
      End;
    End;
  finally
    pFreeAndNil(LfrmCadCarteiraDigital);
  end ;
end;

procedure TfrmPrincipal.mnuCadCartoesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCartoes);
end;

procedure TfrmPrincipal.mnuCadCategoriaCRMClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCategoriaCRM);
end;

procedure TfrmPrincipal.mnuFecGiroEstoqueClick(Sender: TObject);
begin
  pCriarForm(TfrmFecGiroEstoque, frmFecGiroEstoque);
end;

procedure TfrmPrincipal.mnuManCadCidadeSigepClick(Sender: TObject);
begin
  pCriarForm(TfrmManCadCidadeSigep);
end;

procedure TfrmPrincipal.mnuManCartaoClick(Sender: TObject);
begin
  pCriarFormularios(TfrmCadMovCartoes, frmCadMovCartoes);
  frmCadMovCartoes.blnChamadoDoManutencao := True;
  frmCadMovCartoes.showModal;
  FreeAndNil(frmCadMovCartoes);
end;

procedure TfrmPrincipal.mnuManCentroCustoRateioClick(Sender: TObject);
begin
  pCriarForm(TfrmManCentroCustoRateio);
end;

procedure TfrmPrincipal.mnuBaixaCartoesClick(Sender: TObject);
begin
  pCriarForm(TfrmBaixaCartoes);
end;

procedure TfrmPrincipal.mnuCadPrevisaoMensalClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPrevisaoMensal);
end;

procedure TfrmPrincipal.mnuCadPrevisoesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPrevisao);
end;

procedure TfrmPrincipal.mnuLayoutsImpressaoClick(Sender: TObject);
begin
  pCriarForm(TfrmLayoutsImpressao);
end;

procedure TfrmPrincipal.mnuCtpLiberacaoBaixaClick(Sender: TObject);
begin
  pCriarForm(TfrmCtpLiberacaoBaixa);
end;

procedure TfrmPrincipal.mnuCtpLiberacaoPrevisaoClick(Sender: TObject);
begin
  pCriarForm(TfrmCtpLiberacaoPrevisao);
end;

procedure TfrmPrincipal.mnuLibAcessoEndPointsWSClick(Sender: TObject);
begin
  pCriarForm(TfrmLiberacaoAcessoEndPointsWS);
end;

procedure TfrmPrincipal.mnuLiberacaoAcompEntregasClick(Sender: TObject);
begin
  pCriarForm(TfrmLiberacaoAcompEntregas);
end;

procedure TfrmPrincipal.mnuLiberacaoCNPJClick(Sender: TObject);
begin
  pCriarForm(TfrmLiberacaoCNPJ);
end;

procedure TfrmPrincipal.mnuLiberaPrepTEClick(Sender: TObject);
begin
  pCriarForm(TfrmLiberaPrepTE, frmLiberaPrepTE);
end;

procedure TfrmPrincipal.mnuLiberaRomaneiosAppEntregaClick(Sender: TObject);
begin
  pCriarForm(TfrmLiberaRomaneiosAppEntrega);
end;

procedure TfrmPrincipal.mnuLibLocEquipClick(Sender: TObject);
begin
  pCriarForm(TfrmLiberacaoLocacao);
end;

procedure TfrmPrincipal.mnuLibVendasEntregaClick(Sender: TObject);
begin
  pCriarForm(TfrmLibVendasEntrega);
end;

procedure TfrmPrincipal.mnuLimparSeparaodoPedidodeVendaClick(Sender: TObject);
begin
  pCriarForm(TfrmFatLimparSeparacaoPedido);
end;

procedure TfrmPrincipal.mnuDirAutBanClick(Sender: TObject);
begin
  pCriarForm(TfrmDirAutBan);
end;

procedure TfrmPrincipal.mnuEntMercadoriasClick(Sender: TObject);
begin
  If fEmptyStr(fCfgSis('CONCLA')) Then
  Begin
    pMensagemOk('Configure a [CFG_CONCLA] "Classificação para entrada de material de consumo tributado"');
    Exit;
  End;

  If fEmptyStr(fCfgSis('CONSUB')) Then
  Begin
    pMensagemOk('Configure a [CFG_CONSUB] "Classificação para entrada de material de consumo substituído"');
    Exit;
  End;

  If fTemAntecipacaoIcms And
     (fEmptyStr(fRetNomFornecedor(fCfgSis('ANTFOR'))) Or
      fEmptyStr(fRetDescCentroCusto(fCfgSis('ANTCTA'))) Or
      (fCfgSis('ANTVEN', varInteger) < 1) Or
      (fCfgSis('ANTVEN', varInteger) > 31)) Then
  Begin
    pMensagemOk('Configure as informações para recolhimento de ICMS ' +
                'antecipado na aba de Entrada de Mercadorias (em Configurações do Sistema)!');
    Exit;
  End;

  {If Not fChecaConfiguracoesEntradaMercadorias Then
    Exit;}

  pCriarForm(TfrmEntDigPedido, frmEntDigPedido);
end;

procedure TfrmPrincipal.mnuEntPreNotaEntradaClick(Sender: TObject);
begin
  pCriarForm(TfrmEntPreNotaEntradaCx);
end;

procedure TfrmPrincipal.mnuEntradaAutomatizadaImportacaoClick(Sender: TObject);
begin
  pCriarForm(TfrmEntradaAutomatizadaImportacao, frmEntradaAutomatizadaImportacao);
end;

procedure TfrmPrincipal.mnuEntradaAutomatizadaNotasClick(Sender: TObject);
begin
  TEntradaAutomatizada.pCarregaNotas;
end;

procedure TfrmPrincipal.mnuEntregasRegiaoClick(Sender: TObject);
begin
  pCriarForm(TfrmControleRotasRegiao);
end;

procedure TfrmPrincipal.mnuGerLayoutBanClick(Sender: TObject);
  Var
    strPath: String;
    frmSplashExt : TfrmSplashExt;
begin
  strPath   := fGetPath(ExtractFilePath(Application.ExeName) + '\autban\');

  If FileExists(strPath + '\autban.exe') Then
  Begin
    If VirtualUI.Active Then
      VirtualUI.AllowExecute(strPath + '\autban.exe');

    blnExecutandoAutBan := True;

    AtualizarTelaPrincipalAutcom(True);

    Try
      pCriarFormularios(TfrmSplashExt,frmSplashExt);
      frmSplashExt.strProg := 'autban';
      frmSplashExt.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[mnuGerLayoutBanClick]');
    End;
    pFreeAndNil(frmSplashExt);

    {*********************************************}
    {* TRAVAR O SISTEMA AQUI AT FECHAR O AUTBAN *}
    {******************************************AF*}
    While FindWindow(Nil,PChar('AutBan')) > 0 Do
    Begin
      Application.ProcessMessages;
      Sleep(100);
    End;

    AtualizarTelaPrincipalAutcom(False);
    blnExecutandoAutBan := False;
  End;
End;

procedure TfrmPrincipal.mnuGrupoRiscoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadGrupoRisco);
end;

procedure TfrmPrincipal.mnuGruposAnaliseProducaoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadGruposAnaliseProducao, frmCadGruposAnaliseProducao);
end;

procedure TfrmPrincipal.mnuGrupoServicosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadGrupoServicos);
end;

procedure TfrmPrincipal.mnuAjusteEstoqueClick(Sender: TObject);
  Var
    frmAjusteEstoque: TfrmAjusteEstoque;
begin
  try
    pCriarFormularios(TfrmAjusteEstoque, frmAjusteEstoque);
    frmAjusteEstoque.blnAjuContrPart := False;
    frmAjusteEstoque.Showmodal;
  Finally
    FreeAndNil(frmAjusteEstoque);
  End;
end;

procedure TfrmPrincipal.mnuAjusteIcmsSTClick(Sender: TObject);
begin
  If (fTabelaExiste('AJICST', True)) Then
  Begin
    pVerificaProCod;
    pValidaProCod('AJICST');
    pCriarForm(TfrmCadAjustIcmSt);
  End
  Else
    fMensagem('ATENÇÃO','A tabela AJICST não existe, favor entrar em contato com o suporte!', ['&Ok']);
end;

procedure TfrmPrincipal.mnuAjustesIcmsClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAjustes);
end;

procedure TfrmPrincipal.mnuAltPrecoProdutoClick(Sender: TObject);
begin
  If (fPreMat) Then
  Begin
    fMensagem('AVISO','Operação permitida apenas pela Loja Matriz!', ['&Ok']);
    Exit;
  End
  Else
    pOpeProd(AltPrecoProduto);
end;

procedure TfrmPrincipal.mnuAltPrecoRecalcClick(Sender: TObject);
begin
  If (fCfgSis('EMPGER', varBoolean)) Then
    pCriarForm(TfrmAltPrecoRecalc, frmAltPrecoRecalc)
  Else
    pMensagemOk('Função permitida apenas para empresa gerencial!');
end;

procedure TfrmPrincipal.mnuAltRegClientesClick(Sender: TObject);
begin
  pCriarForm(TfrmAltRegClientes);
end;

procedure TfrmPrincipal.mnuRelacSimilaridadeClick(Sender: TObject);
begin
  pOpeProd(RelacSimilaridade);
end;

procedure TfrmPrincipal.mnuRelEspNotaEntClick(Sender: TObject);
begin
  if not fCfgSis('ENTEDI', varBoolean) then
    pCriarForm(TfrmRelEspNotaEnt)
  else
  begin
    if Assigned(prcExecutaRelatorio) then
      prcExecutaRelatorio(154, 5814, [5814], [], [], Sender, nil);
  end;

end;

procedure TfrmPrincipal.mnuTransfLinGruClick(Sender: TObject);
begin
  if fConfirmaTransfCodigo then
    pOpeProd(TransfLinGru);
end;

procedure TfrmPrincipal.mnuTriggerCRMClick(Sender: TObject);
begin
  pCriarForm(TfrmTriggerCRM);
end;

procedure TfrmPrincipal.mnuTrocaLocEquClick(Sender: TObject);
begin
  pCriarForm(TfrmTrocaEquipamento);
end;

procedure TfrmPrincipal.mnuTransfLocFisGlobalWMSClick(Sender: TObject);
begin
  pCriarForm(TfrmTransfLocFisGlobalWMS);
end;

procedure TfrmPrincipal.mnuTransfTabelasClick(Sender: TObject);
begin
  pCriarForm(TfrmTransfTabelas, frmTransfTabelas);
end;

procedure TfrmPrincipal.mnuLiberacaoLocalizacaoFisicaColetorClick(
  Sender: TObject);
begin
  pCriarForm(TfrmLiberacaoLocalizacaoFisicaColetor);
end;

procedure TfrmPrincipal.mnuFatTransfEstDevEmpCarregamentoClick(Sender: TObject);
begin
  pCriarForm(TfrmFatTransfEstDevEmpCarregamento);
end;

procedure TfrmPrincipal.mnuFatTrocaMercClick(Sender: TObject);
var
  strOpcDoc          : String;
  recReabrirForm     : TReabrirForm;
  blnDevolucaoRapida : Boolean;
begin

  FillChar(recReabrirForm, SizeOf(recReabrirForm), #0);

  {***************************************************************}
  {* O SEMAFORO DO MENU ESTAVA IMPEDINDO DE REABRIR O FORMULARIO *}
  {************************************************************JC*}
  recReabrirForm.blnReabrirForm          := False;
  recReabrirForm.blnAbrirDevolucaoNormal := False;

  blnDevolucaoRapida := (LeftStr(TMenuItem(Sender).Name, Length(mnuFatDevolucaoRapida.Name)) = mnuFatDevolucaoRapida.Name);

  Repeat
    if (fCfgSis('PEDCPL', varBoolean)) and
       (strOpcDoc = 'PD') then
      recReabrirForm.blnReabrirForm := False;

    If (recReabrirForm.blnAbrirDevolucaoNormal) And (blnDevolucaoRapida) Then
    Begin
      strOpcDoc := RightStr(mnuFatDevolucao.Hint, 2);
      pMenuFaturamentoClick(mnuFatDevolucao, recReabrirForm, strOpcDoc);
    End
    Else
      pMenuFaturamentoClick(Sender, recReabrirForm, strOpcDoc);

  Until (Not recReabrirForm.blnReabrirForm);

  {********************************************************************}
  {* QUANDO JA EXISTE UM ORCAMENTO OU PEDIDO EM ABERTO PARA O CLIENTE *}
  {* EM ROTINAS DE AUTOCENTER, DEVE CARREGAR NOVAMENTE A VENDA COM O  *}
  {* ESTE DOCUMENTO.                                                  *}
  {****************************************************************JC**}
  If Not fEmptyStr(Self.strNumOrcPedAbrir) And
     Not fEmptyStr(Self.strEspOrcPedAbrir) Then
  Begin
    If strOpcDoc = 'VN' Then
      pMenuFaturamentoClick(mnuFatVendaNormal, recReabrirForm, strOpcDoc)

    Else If Self.strEspOrcPedAbrir = 'PD' Then
      pMenuFaturamentoClick(mnuFatPedido, recReabrirForm, strOpcDoc)

    Else If Self.strEspOrcPedAbrir = 'OR' Then
      pMenuFaturamentoClick(mnuFatOrcamento, recReabrirForm, strOpcDoc);
  End;
end;

procedure TfrmPrincipal.pMenuFaturamentoClick(Sender             : TObject;
                                              Var recReabrirForm : TReabrirForm;
                                              Var strOpcDoc      : String;
                                              strCodCli          : String = '';
                                              blnForcarAbrirDigDocumento: Boolean = False);
  Var
    strTitulo: String;
    strMnuSel: String;
    strTipDoc: String;
    blnDevBaiEntFut: Boolean;
    blnGravarComo  : Boolean;
    blnApenasPrazo: Boolean;
    blnApenasVista: Boolean;
    blnConEqu: Boolean;
    blnSatComplementar: Boolean;
    blnNFCeComplementar: Boolean;
    blnNFSeSubstituicao: Boolean;
    strProspe: String;
    blnCRM: Boolean;
    strCgcCpf: String;
    frmFatDigDocumento : TfrmFatDigDocumento;
    frmFatMenuOutEntradas: TfrmFatMenuOutEntradas;
    frmFatMenuOutSaidas: TfrmFatMenuOutSaidas;
    objTravaCaixa : TTravaCaixa;
begin
  blnConEqu                      := False;
  recReabrirForm.blnReabrirForm  := False;
  strOpcDoc                      := RightStr((Sender As TMenuItem).Hint, 2);
  blnDevBaiEntFut                := ((Sender As TMenuItem).Name = 'mnuFatDevolucaoBaixaEntFut');
  blnSatComplementar             := (Pos('mnuFatSATComplementar', (Sender As TMenuItem).Name) > 0);
  blnNFCeComplementar            := (Pos('mnuFatNFCeComplemento', (Sender As TMenuItem).Name) > 0);
  blnNFSeSubstituicao            := (Pos('mnuNFSeSubstituicao',   (Sender As TMenuItem).Name) > 0);

  If (THorOpe.fExisteRestricoesDeAcesso(resVenda, True)) Then
    Exit;

  {*************************}
  {* ROTINA USADA PELO CRM *}
  {**********************AC*}
  blnCRM := LeftStr((Sender As TMenuItem).Hint, 3) = 'CRM';
  If blnCRM then
  Begin
    strCodCli := Copy((Sender As TMenuItem).Hint,4,8);

    If Pos('PROSPECTO', (Sender As TMenuItem).Hint) > 0 Then
      strProspe := LeftStr(RightStr((Sender As TMenuItem).Hint, 10),8);

    If Pos('CGC', (Sender As TMenuItem).Hint) > 0 Then
    Begin
      strCgcCpf := Copy((Sender As TMenuItem).Hint,
                        Pos('CGC',(Sender As TMenuItem).Hint) +3,
                        Length((Sender As TMenuItem).Hint));
      strCgcCpf := LeftStr(strCgcCpf, Length(strCgcCpf) -2);
    End;
  End;

  If SameText(strOpcDoc, 'BR') Then
  Begin
    If fEmptyStr(fCfgSis('CLABRI')) Then
    Begin
      pMensagemOk('Configure a Classificação Fiscal para Brinde em Configurações/Faturamento');
      Exit;
    End;
  End;

  If SameText(strOpcDoc, 'CS') Then
  Begin
    If fEmptyStr(fCfgSis('ENVCON')) Then
    Begin
      pMensagemOk('Configure a Classificação Fiscal para Envio de Mercadoria em Consignação em Configurações/Faturamento');
      Exit;
    End;
  End;

  If SameText(strOpcDoc, 'CI') Then
  Begin
    If fEmptyStr(fCfgSis('CLACIF')) Then
    Begin
      pMensagemOk('Configure a Classificação fiscal para confirmação de cupons.');
      Exit;
    End;
  End;

  If SameText(strOpcDoc, 'ER') Then
  Begin
    If (fEmptyStr(fCfgSis('CFRSAI'))) Or (fEmptyStr(fCfgSis('CFRSAS'))) Then
    Begin
      pMensagemOk('Configure a Classificação Fiscal para saída de remessa para fora do estabelecimento (Demais CSTs e Substituido).' + sLineBreak +
                  'CFG_CFRSAI e CFG_CFRSAS');
      Exit;
    End;
  End;

  If SameText(strOpcDoc, 'EM') Then
  Begin
    If fEmptyStr(fCfgSis('CFVOUT')) Then
    Begin
      pMensagemOk('Configure a Classificação Fiscal para Faturamento de Mercadoria em Remessa em Configurações/Faturamento.');
      Exit;
    End;
  End;

  If (Pos(strOpcDoc, 'PD_OR_VN') > 0) And (fTravaAliquota) Then
    Exit;

  If SameText(strOpcDoc, 'OR') Or
     SameText(strOpcDoc, 'PD') Or
     SameText(strOpcDoc, 'CS') Or
     SameText(strOpcDoc, 'ER') Or
     SameText(strOpcDoc, 'VN') Then
  Begin
    If (fCfgSis('ENTFUT') = 'S') Then
      If Not fTemCFOPEntregaFutura(True) Then
      Begin
        Exit
      End
      Else If (Pos('6922', VS_strClaVen) = 0) Or
              (Pos('5922', VS_strClaVen) = 0) Then
      Begin
        fMensagem('','Cadastre as Classificações Fiscais 5922 e 6922 nas Classificações de Venda do Sistema.', ['&Ok']);
        Exit;
      End;
  End;

  If SameText(strOpcDoc, 'UC') Then
  Begin
    If fEmptyStr(fRetNomFornecedor(fCadEmp('FORFIL'))) Then
    Begin
      fMensagem('ATENÇÃO','O fornecedor filial está incorreto.',['&OK']);
      Exit;
    End;
  End;

  If SameText(strOpcDoc, 'PA') Then
  Begin
    If fEmptyStr(fRetNomCliente(fCadEmp('CLIFIL'))) Then
    Begin
      fMensagem('ATENÇÃO','O cliente filial não foi preenchido corretamente no cadastro de empresas, favor verificar!',['&OK']);
      Exit;
    End;
  End;

  If MatchStr(strOpcDoc, ['OR', 'PD', 'VN', 'VS', 'DV', 'DE', 'DR', 'TR', 'TE']) Then
  Begin
    If (Not fEmpresaNesteServidor(VS_strCodEmp)) Then
    Begin
      pMensagemOK('A empresa logada não faz parte desse servidor - Rotina não pode ser executada!');
      Exit;
    End;
  End;

  strTitulo := StringReplace((Sender As TMenuItem).Caption,'&','',[]);
  strMnuSel := (Sender As TMenuItem).Name + 'Click';

  objTravaCaixa := TTravaCaixa.New(strOpcDoc);

  Try

    If (objTravaCaixa.blnTravar) Then
      Exit;

    blnApenasPrazo := objTravaCaixa.blnApenasEmissaoDeDocumentosAPrazo;
    blnApenasVista := objTravaCaixa.blnApenasEmissaoDePD_OR_AVista;
    blnGravarComo  := objTravaCaixa.blnGravarComo;

  Finally
    FreeAndNil(objTravaCaixa);
  End;

  If ( (VS_strCodEmp = fCfgSis('EMPMAT')) And (fCfgSis('ORTERE', varBoolean)) ) Or
     (fCfgSis('CAORTE', varBoolean))  Then
    strTipDoc := 'OR_PD_VN_VS_TE_CS_ER_EM_'
  Else
    strTipDoc := 'OR_PD_VN_VS_CS_ER_EM_';

  If Pos(strOpcDoc, strTipDoc) > 0 Then
  Begin
    If Assigned(frmFatDigDocumento) Then
      pFreeAndNil(frmFatDigDocumento);

    pCriarFormularios(TfrmFatDigDocumento, frmFatDigDocumento);
    Try
      Try
        frmFatDigDocumento.strOpcDoc      := strOpcDoc;
        frmFatDigDocumento.Caption        := strTitulo;
        frmFatDigDocumento.blnGravarComo  := blnGravarComo;
        frmFatDigDocumento.blnApenasPrazo := blnApenasPrazo;
        frmFatDigDocumento.blnApenasVista := blnApenasVista;
        frmFatDigDocumento.strCodCliDef   := strCodCli;
        frmFatDigDocumento.strProspe      := strProspe;
        frmFatDigDocumento.strNLeads      := strNLeads;
        frmFatDigDocumento.blnEstouNoCrm  := blnEstouNoCrm;
        frmFatDigDocumento.strCgcCpf      := strCgcCpf;

        frmFatDigDocumento.blnForcarAbrirDigDocumento := blnForcarAbrirDigDocumento;

        If Not fEmptyStr(Self.strNumOrcPedAbrir) And
           Not fEmptyStr(Self.strEspOrcPedAbrir) Then
        Begin
          frmFatDigDocumento.strNumOrcPedAbrir := Self.strNumOrcPedAbrir;
          frmFatDigDocumento.strEspOrcPedAbrir := Self.strEspOrcPedAbrir;

          Self.strNumOrcPedAbrir := '';
          Self.strEspOrcPedAbrir := '';
        End;

        //Prestcon
        If (strOpcDoc = 'VN') And fCfgSis('USACCR', varBoolean) And (fCfgSis('TPNFCR') = PRESTCON) Then
        Begin
          frmFatDigDocumento.pIniciaTela;
          frmFatDigDocumento.btnConfirmaDados.Click;
        End
        Else
          frmFatDigDocumento.showModal;

        Self.strNumOrcPedAbrir := frmFatDigDocumento.strNumOrcPedAbrir;
        Self.strEspOrcPedAbrir := frmFatDigDocumento.strEspOrcPedAbrir;
        Self.strCodCliGravado  := frmFatDigDocumento.strCodCliGravado;

        if (fCfgSis('PEDCPL', varBoolean)) and
           (strOpcDoc = 'PD') and
           (Not fEmptyStr(Self.strEspOrcPedAbrir)) and
           (Not fEmptyStr(Self.strNumOrcPedAbrir)) then
          recReabrirForm.blnReabrirForm := True;

        If blnCRM Then
        Begin
          If Pos('PROSPECTO', (Sender As TMenuItem).Hint) > 0 Then
            (Sender As TMenuItem).Hint := StringReplace((Sender As TMenuItem).Hint, strProspe, frmFatDigDocumento.strProspe, [rfReplaceAll])
          Else
            (Sender As TMenuItem).Hint := StringReplace((Sender As TMenuItem).Hint, strCodCli, frmFatDigDocumento.strCodCliDef, [rfReplaceAll])
        End;

      Except
        On E: Exception Do
          pMensagensErro(E.Message, '['+strMnuSel+']');
      End;
    Finally
      pFreeAndNil(frmFatDigDocumento);
    End;
  End
  Else
  Begin

    If strOpcDoc = 'OU' Then
    Begin

      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'OUTSA';
      objLiberacao.strSenLib    := fCfgSis('SENNFO');
      objLiberacao.strMsgSen    := 'Outras Saídas';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Acesso ao módulo Outras Saídas');

      If not objLiberacao.fLibera then
        Exit;

      Try
        pCriarFormularios(TfrmFatMenuOutSaidas, frmFatMenuOutSaidas);
        frmFatMenuOutSaidas.showModal;
        strOpcDoc := frmFatMenuOutSaidas.strOpcDoc;
        blnConEqu := frmFatMenuOutSaidas.blnConEqu;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '['+strMnuSel+']');
      End;

      pFreeAndNil(frmFatMenuOutSaidas);

      if fEmptyStr(strOpcDoc) Then
        Exit;

      If SameText('OF',strOpcDoc) Then
      Begin

        If fEmptyStr(fRetDescCentroCusto(fCfgSis('CTACOM'))) Then
        Begin
          fMensagem('','Favor configurar "Plano de Contas para comissão corretamente".',['&OK']);
          Exit;
        End;

        If fEmptyStr(fRetDescCentroCusto(fCfgSis('CTADOF'))) Then
        Begin
          fMensagem('','Favor configurar "Plano de Contas para créditos de Outras Saídas Para Fornecedor".',['&OK']);
          Exit;
        End;

      End;

      If (strOpcDoc <> 'OV') And
         ((Pos(strOpcDoc, 'OU_') > 0) And
          ( (VS_strCodEmp = fCfgSis('EMPMAT')) And (fCfgSis('ORTERE', varBoolean)) ) Or
          (fCfgSis('CAORTE', varBoolean))) Then
      Begin

        If Not blnConEqu Then
        Begin
          If Assigned(frmFatDigDocumento) Then
            pFreeAndNil(frmFatDigDocumento);

          pCriarFormularios(TfrmFatDigDocumento, frmFatDigDocumento);
          Try
            Try
              frmFatDigDocumento.strOpcDoc      := strOpcDoc;
              frmFatDigDocumento.Caption        := strTitulo;
              frmFatDigDocumento.blnApenasPrazo := blnApenasPrazo;
              frmFatDigDocumento.blnApenasVista := blnApenasVista;
              frmFatDigDocumento.strCodCliDef   := strCodCli;
              frmFatDigDocumento.showModal;
            Except
              On E: Exception Do
                pMensagensErro(E.Message, '['+strMnuSel+']');
            End;
          Finally
            pFreeAndNil(frmFatDigDocumento);
          End;
        End
        Else
        Begin
          pCriarFormularios(TfrmFatVendas, frmFatVendas);

          If Not frmFatVendas.blnFecharForm Then
          Begin
            frmFatVendas.strOpcDoc          := 'OU';
            frmFatVendas.strTitulo          := 'Outras Saídas';
            frmFatVendas.blnApenasPrazo     := False;
            frmFatVendas.blnApenasVista     := False;
            frmFatVendas.blnDevBaiEntFut    := False;
            frmFatVendas.blnSatComplementar := False;
            frmFatVendas.blnNFCeComplementar:= False;
            frmFatVendas.blnNFSeSubstituicao:= False;
            frmFatVendas.blnConEqu          := True;
            frmFatVendas.strCodCliDef       := '';
            frmFatVendas.edtCodCli.Text     := '';
            frmFatVendas.ShowModal;
          End;

          pFreeAndNil(frmFatVendas);
          Application.ProcessMessages;
        End;

        Exit;

      End;

    End

    Else If strOpcDoc = 'OE' Then
    Begin

      If fEmptyStr(fRetDescCentroCusto(fCfgSis('CTACOM'))) Then
      Begin
        fMensagem('','Favor configurar "Plano de Contas para comissão corretamente".',['&OK']);
        Exit;
      End;

      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'OUTEN';
      objLiberacao.strSenLib    := fCfgSis('SENNFE');
      objLiberacao.strMsgSen    := 'Outras Entradas';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Acesso ao módulo Outras Entradas');

      If not objLiberacao.fLibera then
        Exit;

      Try
        pCriarFormularios(TfrmFatMenuOutEntradas, frmFatMenuOutEntradas);
        frmFatMenuOutEntradas.showModal;
        strOpcDoc := frmFatMenuOutEntradas.strOpcDoc;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '['+strMnuSel+']');
      End;

      pFreeAndNil(frmFatMenuOutEntradas);

      if fEmptyStr(strOpcDoc) Then
        Exit;

    End

    Else If (strOpcDoc = 'TR') And (fCfgSis('SNTRIF') = 'I') And (Not fEmptyStr(fCfgSis('SENTRO'))) Then
    Begin

      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'TROMER';
      objLiberacao.strSenLib    := fCfgSis('SENTRO');
      objLiberacao.strMsgSen    := 'Troca de Mercadorias';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Acesso ao módulo Troca de Mercadorias');

      If not objLiberacao.fLibera then
        Exit;

    End

    Else If strOpcDoc = 'NE' Then
    Begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'NOESP';
      objLiberacao.strSenLib    := fCfgSis('SENNES');
      objLiberacao.strMsgSen    := 'Nota Especial';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Liberação de Nota Especial');

      If not objLiberacao.fLibera then
        Exit;

    End

    Else If strOpcDoc = 'CE' Then
    Begin

      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'CFESP';
      objLiberacao.strSenLib    := fCfgSis('SENCFE');
      objLiberacao.strMsgSen    := 'Cupom Fiscal Especial';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Liberação de Cupom Fiscal Especial');

      If not objLiberacao.fLibera then
        Exit;

    End

    Else If strOpcDoc = 'UC' Then
    Begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'ACEUC';
      objLiberacao.strSenLib    := '';
      objLiberacao.strMsgSen    := 'Uso/Consumo de materiais';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Acesso ao módulo Uso/Consumo de materiais');

      If not objLiberacao.fLibera then
        Exit;
    End;

    Try

      pCriarFormularios(TfrmFatVendas, frmFatVendas);

      If Not frmFatVendas.blnFecharForm Then
      Begin

        {Devolução Especial}
        If strOpcDoc = 'DE' Then
        Begin
          strOpcDoc := 'DV';
          frmFatVendas.blnDevEsp := True;
        End;

        {Devolução Rápida}
        If strOpcDoc = 'DR' Then
        Begin
          strOpcDoc := 'DV';
          frmFatVendas.blnDevRap := True;
        End;

        If blnNFSeSubstituicao Then
          strOpcDoc := 'VS';

        frmFatVendas.strOpcDoc          := strOpcDoc;
        frmFatVendas.strTitulo          := strTitulo;
        frmFatVendas.blnApenasPrazo     := blnApenasPrazo;
        frmFatVendas.blnApenasVista     := blnApenasVista;
        frmFatVendas.blnDevBaiEntFut    := blnDevBaiEntFut;
        frmFatVendas.blnSatComplementar := blnSatComplementar;
        frmFatVendas.blnNFCeComplementar:= blnNFCeComplementar;
        frmFatVendas.blnNFSeSubstituicao:= blnNFSeSubstituicao;
        frmFatVendas.strCodCliDef       := strCodCli;
        frmFatVendas.blnConEqu          := blnConEqu;

        If strOpcDoc = 'NE' Then
          If fMensagem('ATENÇÃO!', 'Nota Especial para?', ['&Cliente', '&Fornecedor'],1,False,1,0,False,0,False,False,True) = 2 Then
            frmFatVendas.blnNEFornecedor := True
          Else
            frmFatVendas.blnNEFornecedor := False;

        frmFatVendas.showModal;

        recReabrirForm.blnReabrirForm          := (frmFatVendas.blnConfirmouOperacao    And (Pos(strOpcDoc, 'CF_CI_CN_CT_CP_DV_VC_') > 0));
        recReabrirForm.blnAbrirDevolucaoNormal := (frmFatVendas.blnAbrirDevolucaoNormal And (Pos(strOpcDoc, 'DV_') > 0));

      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '['+strMnuSel+']');
    End;

    pFreeAndNil(frmFatVendas);
    Application.ProcessMessages;

  End;

end;

procedure TfrmPrincipal.mnuCadComplOcorrenciasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadComplOcorrencias);
end;

procedure TfrmPrincipal.mnuCadComplVidroClick(Sender: TObject);
begin
  pCriarForm(TfrmCadComplVidro);
end;

procedure TfrmPrincipal.mnuCadCompProdAcabClick(Sender: TObject);
begin
  pCriarForm(TfrmCadComposicaoProdAcab);
end;

procedure TfrmPrincipal.mnuCadCompromissosClick(Sender: TObject);
begin
  pCriarForm(TfrmCompromissos);
end;

procedure TfrmPrincipal.mnuCadComRecClick(Sender: TObject);
begin
  pCriarForm(TfrmCadComRec);
end;

procedure TfrmPrincipal.mnuRelEstCMVClick(Sender: TObject);
begin
  pRelatorioEstatisticas(relEstatCMV);
end;

procedure TfrmPrincipal.mnuRelEstComparativoPrecosFornecClick(Sender: TObject);
begin
  pCriarForm(TfrmRelEstComparativoPrecosFornec);
end;

procedure TfrmPrincipal.mnuRelEstItensAbaixoMinClick(Sender: TObject);
begin
  Try
    pCriarFormularios(TfrmRelEstItemsAbaixoMin, frmRelEstItemsAbaixoMin);
    frmRelEstItemsAbaixoMin.fGravaFatGor := untFatGor.fGravaFatGor;
    frmRelEstItemsAbaixoMin.fGravaFatDor := untFatGor.fGravaFatDor;
    frmRelEstItemsAbaixoMin.blnOriRcx    := false;
    frmRelEstItemsAbaixoMin.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pRelEstItemsAbaixoMin]');
    End;
  End;

  pFreeAndNil(frmRelEstItemsAbaixoMin);
end;

procedure TfrmPrincipal.mnuRelEstItensAcimaMaxClick(Sender: TObject);
  Var
    frmRelEstItemsAcimaMax: TfrmRelEstItemsAcimaMax;
begin

  Try
    pCriarFormularios(TfrmRelEstItemsAcimaMax, frmRelEstItemsAcimaMax);
    frmRelEstItemsAcimaMax.fGravaFatGor := untFatGor.fGravaFatGor;
    frmRelEstItemsAcimaMax.fGravaFatDor := untFatGor.fGravaFatDor;
    frmRelEstItemsAcimaMax.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pRelEstItemsAcimaMax]');
    End;
  End;

  pFreeAndNil(frmRelEstItemsAcimaMax);

end;

procedure TfrmPrincipal.mnuRelEtiqQtdRestanteClick(Sender: TObject);
begin
  pCriarForm(TfrmRelEtiqQtdRestante);
end;

procedure TfrmPrincipal.mnuExclusaoOrcFaturadosClick(Sender: TObject);
begin
  pCriarForm(TfrmExclusaoOrcFaturados);
end;

procedure TfrmPrincipal.mnuControleSepAvulsaClick(Sender: TObject);
begin
  pCriarForm(TfrmControleSepAvulsa);
end;

procedure TfrmPrincipal.mnuRelEstOrdensBaixadasParcialmenteEmAbertoClick(
  Sender: TObject);
begin
  if not fCfgSis('OIBXPA', varBoolean) then
    Exit;

  if Assigned(prcExecutaRelatorio) then
    prcExecutaRelatorio(330, 12557, [12557], [], [], Sender, nil);
end;

procedure TfrmPrincipal.mnuRelEstatAbcProdutosClick(Sender: TObject);
begin
  pRelatorioEstatisticas(relEstatAbcProdutos);
end;

procedure TfrmPrincipal.mnuRelEstatAbcFornecedoresClick(Sender: TObject);
begin
  pRelatorioEstatisticas(relEstatAbcFornecedor);
end;

procedure TfrmPrincipal.mnuRelEstatAnalResultClick(Sender: TObject);
begin
  If (fCfgSis('ARITEC') = 'S') Then
    pCriarForm(TfrmRelEstatAnalResult2Ritec)
  Else
  Begin
    If Not fCfgSis('DREEDI', varBoolean) Then
      pCriarForm(TfrmRelEstatAnalResult2)
    Else
    Begin
      if Assigned(prcExecutaRelatorio) then
        prcExecutaRelatorio(339, 15692, [15692], [], [], Sender, nil);
    End;
  End;
end;

procedure TfrmPrincipal.mnuConsultaPedidosPendClick(Sender: TObject);
begin
  pCriarForm(TfrmConsultaPedidosPend);
end;

procedure TfrmPrincipal.mnuConsultaProdutosClick(Sender: TObject);
begin
  pConsultaItem(self);
end;

procedure TfrmPrincipal.mnuConsultarAdiantamentosClick(Sender: TObject);
begin
  pCriarForm(TfrmConsultarAdiantamentos);
end;

procedure TfrmPrincipal.mnuSintegraClick(Sender: TObject);
begin
  If FileExists(ExtractFilePath(Application.ExeName) + 'sintegra-1.0.exe') Then
  Begin
    WinExec(PAnsiChar(AnsiString(ExtractFilePath(Application.ExeName) + 'sintegra-1.0.exe')), SW_SHOWNORMAL);
  End
  Else
  Begin
    fMensagem('MÓDULO EM DESENVOLVIMENTO!', 'O módulo de geração do Sintegra está em desenvolvimento.', ['&Ok']);
  End;
end;

procedure TfrmPrincipal.mnuConsultaRelatMenuClick(Sender: TObject);
begin
  objRelatorio.pMostraRelatoriosMenu(frmPrincipal);
end;

procedure TfrmPrincipal.mnuConsultaSalcomixClick(Sender: TObject);
begin
  pCarregaMenuTintaMaquinaSobDemanda;

  If HandleDllAuttin <> 0 Then
    pConsultaSalcomixGeralDinamica(Self);
end;

procedure TfrmPrincipal.mnuConsultaServicosAutocenterClick(Sender: TObject);
begin
  If fCfgSis('ACOSER') = '1' Then
    pCriarForm(TfrmConsultaServicosAutocenter)
  Else
    pCriarForm(TfrmConsultaServicosAutocenterVendas);
end;

procedure TfrmPrincipal.mnuConsultaServicosClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
    objfrmPnl : TPanelCxServico;
begin
  chrKey:= '/';
  objfrmPnl := TPanelCxServico.Create(TfrmPnlDadosServico);
  fPesqServicos(Self, Nil, Nil, Nil, chrKey, arrSel, True,
                fCfgSis('AUTCEN', varBoolean), objfrmPnl);
end;

procedure TfrmPrincipal.mnuConsultoriaFiscalSaneamentoClick(Sender: TObject);
begin
  pOpeProd(ApiSaneamento);
end;

procedure TfrmPrincipal.mnuContatosWhatsappIntegracaoClick(Sender: TObject);
begin
  pCriarForm(TfrmContatosWhatsappIntegracao);
end;

procedure TfrmPrincipal.mnuContProgProdClick(Sender: TObject);
begin
  pCriarForm(TfrmCadControleProducao);
end;

procedure TfrmPrincipal.mnuConciliaoKonciliaClick(Sender: TObject);
begin
  pConciliacaoCartoes('Koncili');
end;

procedure TfrmPrincipal.mnuConferenciaEstoqueContabilClick(Sender: TObject);
begin
  // Req 376187, criando a tela de Conferência no menu de estoque e mudando o Caption
  Try
    pCriarFormularios(TfrmConferenciaEstoqueContabil, frmConferenciaEstoqueContabil);
    frmConferenciaEstoqueContabil.Caption := 'Kardex de Estoque Contábil';
    frmConferenciaEstoqueContabil.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuConferenciaEstoqueContabilClick]');
    End;
  End;
  pFreeAndNil(frmConferenciaEstoqueContabil);
end;

procedure TfrmPrincipal.mnuConferenciaPreNotaCancelClick(Sender: TObject);
  Var
    frmEntSelecionaNotaElet: TfrmEntSelecionaNotaElet;
begin
  If fVerificaAcessoSistema('frmConferenciaPreNotaCancel') Then
  Begin
    pCriarFormularios(TfrmEntSelecionaNotaElet, frmEntSelecionaNotaElet);
    frmEntSelecionaNotaElet.opcTipoOperacao := opeCancelaConferencia;
    frmEntSelecionaNotaElet.objConfPreNota := TConferePreNota.Create;
    frmEntSelecionaNotaElet.ShowModal;
    FreeAndNil(frmEntSelecionaNotaElet.objConfPreNota);
    pFreeAndNil(frmEntSelecionaNotaElet);
  End;
end;

procedure TfrmPrincipal.mnuPreNotaCancelClick(Sender: TObject);
  Var
    frmEntSelecionaNotaElet: TfrmEntSelecionaNotaElet;
begin
  If fVerificaAcessoSistema('frmPreNotaCancel') Then
  Begin
    pCriarFormularios(TfrmEntSelecionaNotaElet, frmEntSelecionaNotaElet);
    frmEntSelecionaNotaElet.opcTipoOperacao := opeCancelaPreNota;
    frmEntSelecionaNotaElet.objConfPreNota := TConferePreNota.Create;
    frmEntSelecionaNotaElet.ShowModal;
    FreeAndNil(frmEntSelecionaNotaElet.objConfPreNota);
    pFreeAndNil(frmEntSelecionaNotaElet);
  End;
end;

procedure TfrmPrincipal.mnuConfFFemD1Click(Sender: TObject);
  Var
    objConfFFemD1: TConfirmarFFemD1;
    blnConfirmou: Boolean;
begin
  objConfFFemD1 := TConfirmarFFemD1.Create(Self);

  With objConfFFemD1 Do
  Begin
    blnConfirmou := fPedeDocumentos And
                    fConfirmarFFemD1;
    Destroy;
  End;

  If blnConfirmou Then
    mnuConfFFemD1.Click;
end;

procedure TfrmPrincipal.mnuConfiguracoesGlasuritClick(Sender: TObject);
begin
  Try
    pCarregaMenuTintaMaquinaSobDemanda;

    If HandleDllAuttin <> 0 Then
      pCriaFormularioConfGlasurit;
  Finally
    pFinalizaAuttin;
  End;
end;

procedure TfrmPrincipal.mnuConfiguracoesSalcomixClick(Sender: TObject);
begin
  Try
    pCarregaMenuTintaMaquinaSobDemanda;

    If HandleDllAuttin <> 0 Then
      pCriaFormularioConfSalcomix;
  Finally
    pFinalizaAuttin;
  End;
end;

procedure TfrmPrincipal.mnuConfirmacaoDeCartoesClick(Sender: TObject);
begin
  pConfirmacaoDeCartoes;
end;

procedure TfrmPrincipal.mnuConfirmaEspelhoClick(Sender: TObject);
begin
  pCriarForm(TfrmConfirmaEspelho);
end;

procedure TfrmPrincipal.mnuConfTintaMaquinaClick(Sender: TObject);
begin
  pCarregaMenuTintaMaquinaSobDemanda;

  If HandleDllAuttin <> 0 Then
   pConfiguracaoTintaMaquina;
end;

procedure TfrmPrincipal.mnuConfTransfArmazensClick(Sender: TObject);
begin
  pCriarForm(TfrmEntConferenciaTransferencia);
end;

procedure TfrmPrincipal.mnuConsControleProducaoClick(Sender: TObject);
begin
  pCriarForm(TfrmConsControleProducao);
end;

procedure TfrmPrincipal.mnuConsolidacaoDeAdiantamentoDeValoresClick(
  Sender: TObject);
begin
  pCriarForm(TfrmConsolidacaoDeAdiantamentoDeValores, frmConsolidacaoDeAdiantamentoDeValores);
end;

procedure TfrmPrincipal.mnuCRMClick(Sender: TObject);
begin
  If blnUsuarioLogadoUtilizaModoClassico Then
    AbrirCRMClassico
  Else
    {$IFDEF TESTABILIDADE_AUTCOM}
    AbrirCRMClassico;
    {$Else}
    AbrirCRMNovo;
    {$ENDIF}
end;

procedure TfrmPrincipal.pConsultaNovosItens;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
begin
  Try
    chrKey := '?';
    fPesqItem(conNovosItens, Self, nil, nil, Nil, chrKey, arrSel, True, nil, 'Consulta de Itens', '1',
              '',
              0,
              False,
              False,
              0,
              cdrCodIte,
              '',
              False,   {* Se é pedido de compra                        *}
              '',
              '',
              True,
              False,
              True,
              '', // Codigo do Comprador
              False,
              False,
              False,
              False,
              False,
              False,
              False,
              False,
              '',
              -1,
              False,
              '',
              True,
              '',
              '',
              '',
              '',
              '',
              '',
              False);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pConsultaNovosItens]');
    End;
  End;
end;

procedure TfrmPrincipal.pAcompanhamentoPedidosMostraDebCtrChq2(cdsDados: TUniClientDataSet; strNumDoc : string);
var
  frmConsultaPedidos : TfrmConsultaPedidos;
begin
  pCriarFormularios(TfrmConsultaPedidos, frmConsultaPedidos);

  Try
    If (not cdsDados.IsEmpty) Then
    Begin
      frmConsultaPedidos.cdsInfDuplicatas    := cdsDados;
      frmConsultaPedidos.blnMostraDebCtrChq2 := True;
      frmConsultaPedidos.cdsInfDuplicatas.Filtered := False;
      frmConsultaPedidos.cdsInfDuplicatas.Filter := 'CTR_NUMDUP = '+quotedStr(strNumDoc);
      frmConsultaPedidos.cdsInfDuplicatas.Filtered := True;

      frmConsultaPedidos.NumDocFat := frmConsultaPedidos.cdsInfDuplicatas.FieldByName('CTR_NUMDUP').AsString;
      frmConsultaPedidos.EspFat    := frmConsultaPedidos.cdsInfDuplicatas.FieldByName('CTR_ESPDOC').AsString;
      frmConsultaPedidos.EmpFat    := frmConsultaPedidos.cdsInfDuplicatas.FieldByName('CTR_CODEMP').AsString;
      frmConsultaPedidos.CodCli    := frmConsultaPedidos.cdsInfDuplicatas.FieldByName('CTR_CODCLI').AsString;
    End;

    frmConsultaPedidos.ShowModal;
  Finally
    FreeAndNil(frmConsultaPedidos);
  End;
end;

procedure TfrmPrincipal.mnuConsultaFatNovosItensClick(Sender: TObject);
begin
  pConsultaNovosItens;
end;

procedure TfrmPrincipal.mnuConsultaGlasuritClick(Sender: TObject);
begin
  pCarregaMenuTintaMaquinaSobDemanda;

  If HandleDllAuttin <> 0 Then
    pConsultaGlasuritGeralDinamica(Self);
end;

procedure TfrmPrincipal.mnuRelFatVendasClienteClick(Sender: TObject);
begin
  Try
    pCriarFormularios(TfrmRelFatVendasCliente, frmRelFatVendasCliente);
    frmRelFatVendasCliente.blnSenha      := True;
    frmRelFatVendasCliente.blnFiltroCFOP := True;
    frmRelFatVendasCliente.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuRelFatVendasClienteClick]');
    End;
  End;
  pFreeAndNil(frmRelFatVendasCliente);
end;

procedure TfrmPrincipal.mnuTabelaFatSimplesClick(Sender: TObject);
var
  frmCadTabelaFaixasSimplesNacional: TfrmCadTabelaFaixasSimplesNacional;
begin
  Try
    pCriarFormularios(TfrmCadTabelaFaixasSimplesNacional, frmCadTabelaFaixasSimplesNacional);
    frmCadTabelaFaixasSimplesNacional.ShowModal();
  Finally
    FreeAndNil(frmCadTabelaFaixasSimplesNacional);
  End;
end;

procedure TfrmPrincipal.mnuTipoImobilizadoClick(Sender: TObject);
begin
  TMenuContabilidade.mnuTipoImobilizadoCClick(Sender) ;
end;

procedure TfrmPrincipal.pGeraConsultaLapis;
  var
    intContador: Integer;
begin
  If (VS_strUsaTmq <> 'S') Then
  Begin
    Exit;
  End;

  popProdutos.Items.Clear;

  pGeraPopUp(Self, mnuCadProdutos, popProdutos.Items);

  For intContador := 0 To mnuFatConsPrecos.Count - 1 Do
    pGeraPopUp(Self, mnuFatConsPrecos.Items[intContador], popProdutos.Items);
end;

procedure TfrmPrincipal.pGeraEntradaTransfEstoque(strDocOri, strEspOri,
  strEmpOri, strSerOri, strCodForTe: String; blnPedidoCompra: Boolean);
var intQtd: integer;
begin
  Try
    pCriarFormularios(TfrmRecTransfEstoque, frmRecTransfEstoque);
    frmRecTransfEstoque.objEntradaSimplificada.recAutEntTe.blnAutEnt := True;
    frmRecTransfEstoque.objEntradaSimplificada.recAutEntTe.strDocOri := strDocOri;
    frmRecTransfEstoque.objEntradaSimplificada.recAutEntTe.strEspOri := strEspOri;
    frmRecTransfEstoque.objEntradaSimplificada.recAutEntTe.strEmpOri := strEmpOri;
    frmRecTransfEstoque.objEntradaSimplificada.recAutEntTe.strSerOri := strSerOri;
    frmRecTransfEstoque.objEntradaSimplificada.recAutEntTe.strCodForTe := strCodForTe;
    frmRecTransfEstoque.objEntradaSimplificada.recAutEntTe.blnPedidoCompra := blnPedidoCompra;
    intQtd := 0;
    While Not frmRecTransfEstoque.blnEntradaOk do
    Begin
      frmRecTransfEstoque.pFormShow(frmRecTransfEstoque);

      If Not fEmptyStr(frmRecTransfEstoque.strMensagem) Then
        Raise Exception.Create(frmRecTransfEstoque.strMensagem);

      inc(intQtd);
      If intQtd = 3 then
         Exit;
      If not frmRecTransfEstoque.blnEntradaOk Then
      Begin
        If frmRecTransfEstoque.blnFecharForm Then
          frmRecTransfEstoque.blnFecharForm := False; {Se vai necessário isso para entrar na rotina pFormShow req 223076}
        Sleep(120000);
      End;
    End;
  Except
    On E: Exception Do
    Begin
      If Not blnPedidoCompra Then
      Begin
        pFreeAndNil(frmRecTransfEstoque);
        Raise Exception.Create(E.Message);
      End
      Else
        pMensagensErro(E.Message, '[pGeraEntradaTransfEstoque]');
    End;
  End;
  pFreeAndNil(frmRecTransfEstoque);
end;

procedure TfrmPrincipal.pGeraMenusConsultaTinta;
begin
  pGeraMenusConsultaTinta(False);
end;

procedure TfrmPrincipal.pGeraMenusConsultaTinta(blnLogOff: Boolean);
  Var
    iTintas    : ITintasDeMaquina;
    mnuTemp    : TMenuItem;
    mnuAux     : TMenuItem;
    mnuAux2    : TMenuItem;
    intContador: Integer;
begin
  pCriarCfgsTinta;

  If (Not blnLogOff) And (Not fVerificaAcessoSistema('COPRTI', strLoginUsuarioLogado)) Then
    Exit;

  stlTintasMenu.Clear;

  If blnLogOff Then
  Begin
    If (HandleDllAuttin <> 0) Then
      pIniciaFuncoesDllAuttin(blnLogOff);

    pAjustaTintasLogOff;
  End;

  If (VS_strUsaTmq <> 'S') Then
  Begin
    Exit;
  End;

  iTintas := fGetTintasdeMaquina(blnLogOff);

  If Not fVerificaAcessoSistema('COPRTI', strLoginUsuarioLogado) Then
    Exit;

  mnuTemp := Nil;
  mnuAux  := Nil;

  try
    mnuAutcomK.BeginUpdate;

    mnuTemp := TMenuItem.Create(mnuFatConsPrecos);

    For intContador := 0 To iTintas.fGetQtdTintas -1 Do
    Begin
      If (mnuFatConsPrecos.Find(iTintas.fGetNomeTinta(intContador)) = Nil) And (iTintas.fEstaDisponivel(intContador)) And
         (iTintas.fGetNomeTinta(intContador) <> '') Then
      Begin
        mnuAux         := TMenuItem.Create(mnuFatConsPrecos);
        mnuAux.Tag     := 7654321;
        mnuAux.Hint    := iTintas.fGetNomeTinta(intContador);
        mnuAux.Caption := iTintas.fGetNomeTinta(intContador);
        mnuAux.OnClick := pOnClickConsultaTinta;
        mnuAux.Name    := fTiraCaracEspeciais(AnsiReplaceStr(iTintas.fGetNomeTinta(intContador), ' ', '')) + '_';

        mnuTemp.Add(mnuAux);
      End;
    End;

    If mnuTemp.Count <= 0 Then
    Begin
      mnuAutcomK.EndUpdate;
      FreeAndNil(mnuTemp);
      Exit;
    End;

    pOrdenaMenu(mnuTemp, False);

    For intContador := 0 To mnuTemp.Count -1 Do
    Begin
      mnuAux2         := TMenuItem.Create(mnuFatConsPrecos);
      mnuAux2.Hint    := mnuTemp[intContador].Hint;
      mnuAux2.Caption := mnuTemp[intContador].Caption;
      mnuAux2.OnClick := mnuTemp[intContador].OnClick;
      mnuAux2.Name    := fTiraCaracEspeciais(AnsiReplaceStr(mnuTemp[intContador].Name, ' ', ''));
      mnuFatConsPrecos.Add(mnuAux2);

      stlTintasMenu.Add(mnuAux2.Caption);

    End;
  Finally
   mnuAutcomK.EndUpdate;
   FreeAndNil(mnuAux);
   FreeAndNil(mnuTemp);
  end;

end;

procedure TfrmPrincipal.pGeraMenuTintaMaquina(blnLogOff: Boolean);
begin
  If (VS_strUsaTmq <> 'S') Then
  Begin
    mnuTintaDeMaquina.Visible := False;
    Exit;
  End;

  If blnLogOff Then
  Begin
    If (HandleDllAuttin <> 0) Then
      pIniciaFuncoesDllAuttin(blnLogOff);

    pAjustaMenuTintaMaquinaLogOff;
  End;

  iTintasMaquina := fGetTintasdeMaquina(blnLogOff);

  pAjustaPresencaFilhosFixosTintaMaquina(False);

  {REQ 366548}
  {************* COLOCADO VALIDAÇÃO 'NOVFMT' POIS AS CLASSES DEVEM SER CARREGADAS *************}
  {* QUANDO UTILIZA ESSE DIREITO DE ACESSO, O USUARIO CONSEGUE REALIZAR CADASTRO DE NOVAS     *}
  {* FORMULAS, ENTÃO É NECESSARIO CARREGAR OS DEVIDOS MENUS DE CADASTROS DO AUTTIN          *RG}
  If (Not fVerificaAcessoAutTin(mnuTintaDeMaquina.Hint, mnuTintaDeMaquina.Name)) And (Not fVerificaAcessoSistema('NOVFMT')) Then
  Begin
    mnuTintaDeMaquina.OnClick := pOnClickSemDireitoAcessoAutTin;
    FLibAutTinInicializada := True;
    Exit;
  End;

  mnuTintaDeMaquina.OnClick := pOnClickComDireitoAcessoAutTin;

  If blnLogOff Then
  Begin
    If FLibAutTinInicializada Then
    Begin
      FLibAutTinInicializada := False;
      pCarregaMenuTintaMaquinaSobDemanda;
    End;
  End
  Else
  Begin
    FLibAutTinInicializada := False;
  End;
end;

procedure TfrmPrincipal.pCarregaMenuTintaMaquinaSobDemanda(Sender: TObject=Nil; blnCarregaSomenteDLL: Boolean=False);
begin
  If FLibAutTinInicializada Then
    Exit;

  If blnCarregaSomenteDLL Then
  Begin
    If (HandleDllAuttin = 0) Then
    Begin
      fExecutarModal(procedure
        begin
          pCarregaFuncoesDllAuttin;

          If HandleDllAuttin <> 0 Then
            pIniciaFuncoesDllAuttin;
        end,
        'Aguarde, carregando módulos básicos AutTin...',
        EmptyStr);
    End;

    Exit;
  End;

  fExecutarModal(procedure
      Var
        intFilhosFixos,
        intIdx: Integer;
        strXmlMenuAuttin: String;
        oXml: IXMLDocument;
    begin
      pCarregaFuncoesDllAuttin;

      If HandleDllAuttin = 0 Then
      Begin
        mnuTintaDeMaquina.Caption := 'Tinta de Máquina (libAuttin.dll) não encontrado na pasta ' + ExtractFilePath(Application.ExeName) + 'auttin';
        popTintasMaquina.Items.Clear;
        If blnUsuarioLogadoUtilizaModoClassico Then
          pGeraPopUpTintasMaquinas(Self, mnuTintaDeMaquina, popTintasMaquina.Items);
        Exit;
      End;

      If Assigned(untfuncoesSimples.dicConfigInicial) Then
        If Assigned(pIniciaFinalizaDicConfigInicialAutTin) Then
          pIniciaFinalizaDicConfigInicialAutTin;

      stlTintaMdlls.Clear;
      iTintasMaquina := fGetTintasdeMaquina(False);

      mnuAutcomK.BeginUpdate;
      mnuTintaDeMaquina.Caption := 'Tinta de Máquina';
      Try
        pIniciaFuncoesDllAuttin;

        If Assigned(pProcessarTodasTintasParaModoCompleto) Then
          pProcessarTodasTintasParaModoCompleto;

        strXmlMenuAuttin := fMenuTintaToXml();
        If (strXmlMenuAuttin = '') Then
          Exit;

        oXml := TXMLDocument.Create(nil);
        oXml.XML.Text := strXmlMenuAuttin;
        oXml.Active := True;

        pAjustaPresencaFilhosFixosTintaMaquina(True);

        intFilhosFixos := mnuTintaDeMaquina.Count;

        pXmlToMenu(oXml.DocumentElement, mnuTintaDeMaquina, 'LIBAUTTIN.DLL', pOnClickConsultaAuttin, ['']);

        pVerificaMenuTintaMaquina(mnuTintadeMaquina);
        pVerificaMenusFixadosTintaMaquina();

        For intIdx := intFilhosFixos To mnuTintaDeMaquina.Count - 1 Do
          pAdicionaSemaforo(mnuTintaDeMaquina.Items[intIdx]);

        FLibAutTinInicializada := True;

        popTintasMaquina.Items.Clear;
        If blnUsuarioLogadoUtilizaModoClassico Then
          pGeraPopUpTintasMaquinas(Self, mnuTintaDeMaquina, popTintasMaquina.Items, '', False, False);
      Finally
        mnuAutcomK.EndUpdate;
      End;

      fraPesquisarMenu.pMontarPesquisa;
      pGerarPopupRecentesFavoritos;

      If Not blnUsuarioLogadoUtilizaModoClassico Then
      Begin
       {$IFNDEF TESTABILIDADE_AUTCOM}
       Principal.View.FMXPrincipal.AtualizarNovaTelaPrincipalAutcom(True, mnuTintaDeMaquina.Name);
       {$ENDIF}
      End;
    end,
    'Aguarde, carregando módulo AutTin e menus correspondentes...',
    EmptyStr);

  If FLibAutTinInicializada And blnUsuarioLogadoUtilizaModoClassico Then
  Begin
    //EMULA A VOLTA AO MENU RECEM CRIADO
    If Assigned(Sender) And (Sender Is TMenuItem) Then
    Begin
      If TMenuItem(Sender).GetParentMenu Is TAdvPopupMenu Then
        pTourAbrirMenu(fAchaItemPopUpPorNomeOriginal(TAdvPopupMenu(TMenuItem(Sender).GetParentMenu), mnuTintaDeMaquina.Name))
      Else
        pTourAbrirMenu(TMenuItem(Sender))
    End;
  End;
end;

procedure TfrmPrincipal.pGeraMenuTintaMaquina;
begin
  pGeraMenuTintaMaquina(False);
end;

procedure TfrmPrincipal.pOnClickConsultaAuttin(Sender: TObject);
Var
  strMenuName: String;
begin
  strMenuName := TMenuItem(Sender).Name;
  If (Pos('_PopUp_', strMenuName) > 0) Then
    strMenuName := LeftStr(strMenuName, Pos('_PopUp_', strMenuName) - 1);

  pCarregaMenuTintaMaquinaSobDemanda;

  pOnClickMenuGenericTinta(strMenuName);
end;

procedure TfrmPrincipal.pProcessaDicOrdenaMenuItem(menu: TMenuItem);
  Var
    recOrdMnu: TOrdenaMnu;
    intIdx: Integer;
    strMnu: String;

    procedure pOrdena;
    begin
      If (Not recOrdMnu.blnOrdenados) Then
      Begin
        pOrdenaMenu(menu, recOrdMnu.blnInsRiscos, recOrdMnu.blnOrdSubMnu);
        recOrdMnu.blnOrdenados := True;
        dicOrdenaMnu.AddOrSetValue(menu.Name, recOrdMnu);
        dicOrdenaMnu.TrimExcess;
      End;
    end;

begin
  mnuAutcomK.BeginUpdate;

  If (Assigned(menu)) Then
  Begin
    If (dicOrdenaMnu.TryGetValue(menu.Name, recOrdMnu)) Then
    Begin
      pOrdena;
    End;
  End
  Else
  Begin
    For intIdx := 0 To dicOrdenaMnu.Count-1 Do
    Begin
      strMnu := dicOrdenaMnu.ToArray[intIdx].Key;

      If dicOrdenaMnu.TryGetValue(strMnu, recOrdMnu) Then
      Begin
        menu := TMenuItem(Self.FindComponent(strMnu));
        If Assigned(menu) Then
        Begin
          pOrdena;
        End;
      End;
    End;
  End;

  mnuAutcomK.EndUpdate;
end;

procedure TfrmPrincipal.pOnClick(Sender: TObject);
begin
  //
end;

procedure TfrmPrincipal.pAjustaPresencaFilhosFixosTintaMaquina(blnApresentar: Boolean);

  procedure pRemoverSeFilho(mnuItem: TMenuItem);
  begin
    If (mnuItem <> Nil) And (mnuItem.Parent = mnuTintaDeMaquina) Then
      mnuTintaDeMaquina.Remove(mnuItem);
  end;

  procedure pInserirSeOrfao(intPos: Integer; mnuItem: TMenuItem);
  begin
    If (mnuItem <> Nil) And (mnuItem.Parent = Nil) Then
      mnuTintaDeMaquina.Insert(intPos, mnuItem);
  end;

begin
  // Modo FMX: árvore montada por fmxMenu.CarregarMenu (sem o problema do ">").
  If Not blnUsuarioLogadoUtilizaModoClassico Then
    Exit;

  // DLL carregada: fixos precisam permanecer ancorados para responder a cliques.
  If (HandleDllAuttin <> 0) And (Not blnApresentar) Then
    Exit;

  If blnApresentar Then
  Begin
    // Reanexa na ordem original do .dfm antes das pVerifica* aplicarem direitos.
    pInserirSeOrfao(0, mnuConfTintaMaquina);
    pInserirSeOrfao(1, mnuGlasurit);
    pInserirSeOrfao(2, mnuSalcomix);
  End
  Else
  Begin
    // Desancora -> Count = 0 -> suprime ">" -> clique no raiz dispara OnClick
    // (pOnClickComDireitoAcessoAutTin) e força a carga sob demanda.
    pRemoverSeFilho(mnuConfTintaMaquina);
    pRemoverSeFilho(mnuGlasurit);
    pRemoverSeFilho(mnuSalcomix);
  End;
end;

procedure TfrmPrincipal.pOnClickSemDireitoAcessoAutTin(Sender: TObject);
begin
  fMensagem('Atenção', 'Tinta de Máquina (Operador sem direito de acesso)',['&OK']);
end;

procedure TfrmPrincipal.pOnClickConsultaTinta(Sender: TObject);
  Var
    strIdePro: String;
begin
  strIdePro := TMenuItem(Sender).Hint;
  fConsultaTintaGeral(strIdePro, Self, VS_strCodEmp);
end;

procedure TfrmPrincipal.mnuCancelaLocEquClick(Sender: TObject);
begin
  pCriarForm(TfrmCancelaLocEqu);
end;

procedure TfrmPrincipal.mnuCancelamentoDocumentosClick(Sender: TObject);
  Var
    blnValorOriVerificaTef: Boolean;
begin
  If (Not fEmpresaNesteServidor(VS_strCodEmp)) Then
  Begin
    pMensagemOK('A empresa logada não faz parte desse servidor - Rotina não pode ser executada!');
    Exit;
  End;
  blnValorOriVerificaTef := blnVerificaTef;
  blnVerificaTef := True;
  Try
    pCriarForm(TfrmCancelamentoDocumentos);
  Finally
    blnVerificaTef := blnValorOriVerificaTef;
  End;
end;

procedure TfrmPrincipal.mnuDirAutTinClick(Sender: TObject);
begin
  pCarregaMenuTintaMaquinaSobDemanda;

  pCriarForm(TfrmDirAutTin);
end;

procedure TfrmPrincipal.mnuDivergenciasSeparacaoClick(Sender: TObject);
begin
  pOpeProd(DivergenciasSeparacao);
end;

procedure TfrmPrincipal.pHabilitarItemMenu(menu: TMenuItem; blnHabilitar: Boolean);
begin
  If blnHabilitar Then
  Begin
    menu.Tag := 0;
    menu.Visible := True;
  End
  Else
  Begin
    menu.Tag := 1;
    menu.Visible := False;
  End;
end;

procedure TfrmPrincipal.pHabilitarMenusOrdSerVenda;
  Var
    blnVisible: Boolean;
begin
  blnVisible := fCfgSis('OSPDVN', varBoolean);

  mnuOrdemServicoProdVenda.Visible := blnVisible;
  mnuReimpEtiOrdServico.Visible    := blnVisible;
  mnuEtiqOrdSerVenda.Visible       := blnVisible;
  mnuEtiqOrdSerVendaLaser.Visible  := blnVisible;
  mnuEtiqOrdSerVendaArgox.Visible  := blnVisible;
  mnuEtiqOrdSerVendaZebra.Visible  := blnVisible;

  mnuOrdemServicoProdVenda.Tag     := IIF(blnVisible, 0, 1);
  mnuReimpEtiOrdServico.Tag        := IIF(blnVisible, 0, 1);
  mnuEtiqOrdSerVenda.Tag           := IIF(blnVisible, 0, 1);
  mnuEtiqOrdSerVendaLaser.Tag      := IIF(blnVisible, 0, 1);
  mnuEtiqOrdSerVendaArgox.Tag      := IIF(blnVisible, 0, 1);
  mnuEtiqOrdSerVendaZebra.Tag      := IIF(blnVisible, 0, 1);
end;

function TfrmPrincipal.fLogoff(pgbStatus: TcxProgressBar = Nil): Boolean;
  Const
    MAX_PROGRESSO = 14;
    MSG_PROGRESSO = 'Aguarde. Validando Direitos de Acesso....';

  Var
    dicParametros: TDicionario;
    recModulos: TRecModulosAutcom;
    strNomeTrava: string;

    LEmpresaAnterior: String;
begin
  strNomeTrava := 'IMPORTAR_CTE_' + VS_strCodEmp;
  LEmpresaAnterior := VS_strCodEmp;

  TLogAut.New().pLogout();

  pProgresso(pgbStatus, 0, MAX_PROGRESSO, 'Realizando Logoff....');

  pDisponibilizaTefModular;

  If (Not blnImpSfaMob) Then
    pDisponibilizaChvRoboSFA;

  pDesabilitaTimer(tmrCompromissos);
  pDesabilitaTimer(tmrTemMsg);
  pDesabilitaTimer(tmrDataSistema);
  pDesabilitaTimer(tmrTransfEst);
  pDesabilitaTimer(tmrIniciaImportacaoPAF);
  pDesabilitaTimer(tmrMonitor);
  pDesabilitaTimer(tmrGatime);
  pDesabilitaTimer(tmrLotWms);
  pDesabilitaTimer(tmrSistemaDEPS);
  pDesabilitaTimer(tmrProjetosAtrasado);
  pDesabilitaTimer(tmrImportaCTes);
  pDesabilitaTimer(tmrEntregaDivergente);

  if fTravaBancoAtiva(strNomeTrava) then
    fLiberaTravaBanco(strNomeTrava);

  pnlLibera.Visible := False;
  mnuPedidosLiberacao.Visible := False;

  pnlCompromissos.Visible := False;

  if Assigned(objTefCitel) then
    objTefCitel := Nil ;

  VS_blnTefCitelIndisponivel := False;

  TFuncoesPixAutcom.DesregistrarBridgeTef;
  TPixTefBridgeAutcom.InvalidarInstance;
  TFuncoesPixAutcom.pResetarRegistro;

  Result := fPedeLogin(True);

  If Result Then
  Begin
    If (Not VS_AutcomIniciadoModoRobo) Then
    Begin
      ActivateClassGroup(TControl);//Fix FindClass Error when using vcl and firemonkey
    End;
  End;

  If Result Then
  Begin
    pPrimeiroLogin(strLoginUsuarioLogado);
    pMostraProdutosComPrecoPautaFiscalVencido(strLoginUsuarioLogado);
    pInicializacaoFinalizacaoDicConfigInicial;
    TLogAut.New().pLogin();
    dicConfiguracoes.Clear;
    dicDireitosEspecificos.Clear;
    If Assigned(dicDirAceAutTin) Then
      FreeAndNil(dicDirAceAutTin);
    TPermissoesAcesso.GetInstance.pLimpar;
    DefinirTimeZoneEmSessaoMySql(fGetConexao, VS_strCodEmp);
    pSetarVariaveisDeAmbienteTransacao(fGetConexao);
    VS_blnNotificaSaldoAbaixMinimo := fCfgSis('UTINEM', varBoolean);
    VS_TrimMemorySize := '';
    blnFecharForm := False;
    stbStatus.Panels[3].Text := strLoginUsuarioLogado + ' - ' + strDescriUsuarioLogado;

    pSetaDirecaoPopupMsg;

    pAtuVarGlobais;
    VS_CfgJaVerificadas := False;
    TfrmCfgRepositorio.pMontaArrConfiguracoes;
    pProgresso(pgbStatus, 01, MAX_PROGRESSO, MSG_PROGRESSO);

    pInitProfilerUser(strLoginUsuarioLogado, frmModulo.GetCurrentConnection);
    pCarregarLibTintaMaquina;

    If VS_strUsaTmq = 'N' Then
    Begin
      dicParametros := TDicionario.Create;
      dicParametros['codemp'] := VS_strCodEmp;
      dicParametros['usuariologado'] := strLoginUsuarioLogado;

      recModulos.Banco := frmModulo.GetCurrentConnection;

      If Assigned(pSetaParametros) Then
        pSetaParametros(dicParametros, Nil, Nil, recModulos, Nil, Nil, DebugHook, Nil, Nil);

      FreeAndNil(dicParametros);
    End;

    TLogForm.strCodEmp := VS_strCodEmp;
    TLogForm.strCodOpe := strLoginUsuarioLogado;
    TLogForm.dtaDtaLog := VS_Date;
    TLogForm.fncCriaQuery := fCriaQuery;
    TLogForm.fncTime := fTime;
    TLogForm.blnLogFrm := fCfgSis('LOGFRM', varBoolean) And fTabelaExiste('LOGFRM', True);

    pDesabilitaHabilitaTimerECarregaEventoOnTimer(fCfgSis('PAFECF', varBoolean),
                                                  tmrIniciaImportacaoPAF, tmrIniciaImportacaoPAFOnTimer, 'tmrIniciaImportacaoPAF',
                                                  Self,
                                                  RandomRange(TIMER_UM_MINUTO, TIMER_DEZ_MINUTOS));

    if Assigned(tmrMonitor) then
      tmrMonitor.Enabled := True;

    if Assigned(tmrGatime) then
      tmrGatime.Enabled := True;

    If (Assigned(tmrLotWms)) and (fCfgSis('WMRBTP', varInteger) > 0) And fUsaRotinaWMS() And (fCfgSis('WMSSEP') = '2') And (fCfgSis('WMSROB') = 'S') Then
    Begin
      tmrLotWms.Interval := fCfgSis('WMRBTP', varInteger) * 1000;
      tmrLotWms.Enabled  := True;
    End;

    VS_strHabilitarCRM := ((fArqIni(0, 'GERAL', 'CRM', '') = 'S') And (fCfgSis('UTICRM', varBoolean)));

    pGeraMenusConsultaTinta(True);
    pGeraMenuTintaMaquina(True);
    GeraMenuLibCartoes(True);
    pProcessaMenu(pgbStatus);
    pProgresso(pgbStatus, 02, MAX_PROGRESSO, MSG_PROGRESSO);
    pVerificaMenuTintaMaquina(mnuTintadeMaquina);
    pVerificaMenusFixadosTintaMaquina();
    pProgresso(pgbStatus, 04, MAX_PROGRESSO, MSG_PROGRESSO);
    pEscondeMenus;  pProgresso(pgbStatus, 05, MAX_PROGRESSO, MSG_PROGRESSO);

    fraPesquisarMenu.pMontarPesquisa;

    popFaturamento.Items.Clear;
    popFinanceiro.Items.Clear;
    popMovItens.Items.Clear;
    popDASSuvinil.Items.Clear;
    popLocacaoEquipamento.Items.Clear;
    popTintasMaquina.Items.Clear;
    popWMS.Items.Clear;

    If blnUsuarioLogadoUtilizaModoClassico Then
    Begin
      pGeraPopUpFaturamento;                           pProgresso(pgbStatus, 06, MAX_PROGRESSO, MSG_PROGRESSO);
      pGeraPopUpFinanceiro;                            pProgresso(pgbStatus, 07, MAX_PROGRESSO, MSG_PROGRESSO);
      pGeraPopUpMovimentacaoItens;                     pProgresso(pgbStatus, 08, MAX_PROGRESSO, MSG_PROGRESSO);
      pGeraPopUpDASSuvinil;                            pProgresso(pgbStatus, 09, MAX_PROGRESSO, MSG_PROGRESSO);
      pGeraConsultaLapis;                              pProgresso(pgbStatus, 10, MAX_PROGRESSO, MSG_PROGRESSO);
      pGeraPopUpLocacaoEquipamento;                    pProgresso(pgbStatus, 11, MAX_PROGRESSO, MSG_PROGRESSO);
      pGeraPopUpTintasMaquinas(Self, mnuTintaDeMaquina, popTintasMaquina.Items, '', False, HandleDllAuttin = 0);
      pGeraPopUpWMS;                                   pProgresso(pgbStatus, 12, MAX_PROGRESSO, MSG_PROGRESSO);
    End
    Else
    Begin
      pProgresso(pgbStatus, 12, MAX_PROGRESSO, MSG_PROGRESSO);
    End;

    pExibiBotoes;                                    pProgresso(pgbStatus, 13, MAX_PROGRESSO, MSG_PROGRESSO);
    pTituloSistema;                                  pProgresso(pgbStatus, 14, MAX_PROGRESSO, MSG_PROGRESSO);

    pGerarPopupRecentesFavoritos;

    if Assigned(tmrCompromissos) then
      tmrCompromissos.Enabled := True;

    if Assigned(tmrTemMsg) then
      tmrTemMsg.Enabled := True;

    if Assigned(tmrDataSistema) then
      tmrDataSistema.Enabled := True;

    pDesabilitaHabilitaTimerECarregaEventoOnTimer(fCfgSis('EMICTE', varBoolean),
                                                  tmrImportaCTes, tmrImportaCTesOnTimer, 'tmrImportaCTes',
                                                  Self,
                                                  90000);

    pIniciarTimersImportacao;

    strNomeTrava := 'IMPORTAR_CTE_' + VS_strCodEmp;

    if (not blnGerImpCTe) and (Assigned(tmrImportaCTes)) and (tmrImportaCTes.Enabled) and (not fTravaBancoAtiva(strNomeTrava)) then
      fGetLock(strNomeTrava);

    {****************************************}
    {* VERIFICA SE EXISTE TRANSFERENCIA DE  *}
    {* ESTOQUE PARA DAR ENTRADA...          *}
    {*************************************IV*}
    If fCfgSis('MSGTRE', varBoolean) Then
      pDesabilitaHabilitaTimerECarregaEventoOnTimer(fCampoTabela('OPE_MSGTRE', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]) = 'S',
                                                    tmrTransfEst, tmrTransfEstOnTimer, 'tmrTransfEst',
                                                    Self,
                                                    10000);

    mnuPedidosLiberacao.Visible := fCfgSis('HABREM', varBoolean);

    pnlFundo.Color := fRetCorEmpresa(VS_strCodEmp);  pProgresso(pgbStatus, 15, MAX_PROGRESSO, MSG_PROGRESSO);

    If (VS_blnTefCitel) then
      pVerificaTEFCitel;

    if not TYapayFacade.fVerificaExistenciaRestDLL then
    begin
      pTerminate;
      Exit;
    end;

    pCarregaTABNRE;
    pCarregarLibFuncoes;
    pProgresso(pgbStatus, 16, MAX_PROGRESSO, MSG_PROGRESSO);

    If Not LEmpresaAnterior.Equals(VS_strCodEmp) Then
    Begin
      If Assigned(VS_ModelosAvisosEmailAtivado) Then
      Begin
        FreeAndNil(VS_ModelosAvisosEmailAtivado);
        FreeAndNil(VS_ModelosAvisosSMSAtivado);
        FreeAndNil(VS_ModelosAvisosWPPAtivado);
      End;

      pDesabilitaHabilitaTimerECarregaEventoOnTimer(fCfgSis('BOLAVI', varBoolean) And VS_PermitidoEnviarEmail,
                                                    tmrEmailBoletoAutomatico, tmrEmailBoletoAutomaticoOnTimer, 'tmrEmailBoletoAutomatico',
                                                    Self,
                                                    3600000);

      If Assigned(tmrEmailBoletoAutomatico) Then
        If tmrEmailBoletoAutomatico.Enabled Then
          tmrEmailBoletoAutomaticoOnTimer(tmrEmailBoletoAutomatico);
    End;

    pDesabilitaHabilitaTimerECarregaEventoOnTimer((fCfgSis('USADEP') = 'S') And (ParamStr(1).IsEmpty),
                                                  tmrSistemaDEPS, tmrSistemaDEPSOnTimer, 'tmrSistemaDEPS',
                                                  Self,
                                                  90000);

    pDesabilitaHabilitaTimerECarregaEventoOnTimer((fCfgSis('CTPPRE') = 'S') And
                                                  (ParamStr(1).IsEmpty) And
                                                  (fCampoTabela('OPE_MSGPRE', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]) = 'S'),
                                                  tmrAvisosPrevisaoCTP, tmrAvisosPrevisaoCTPOnTimer, 'tmrAvisosPrevisaoCTP',
                                                  Self,
                                                  90000);

    blnIgnorarPopUpMsgLib := False;

    If Assigned(objPlugin) Then
      objPlugin.pLogoffPlugins;

    pGravaConfiguracoesUsadasLogin;

    {$IFDEF TESTABILIDADE_AUTCOM}
    //não chama a tela nova
    {$Else}
    If Not blnUsuarioLogadoUtilizaModoClassico Then
      Principal.View.FMXPrincipal.AtualizarNovaTelaPrincipalAutcom(True);
    {$ENDIF}
  End
  Else
  Begin
    {$IFDEF TESTABILIDADE_AUTCOM}
    //não chama a tela nova
    {$Else}
    If Not blnUsuarioLogadoUtilizaModoClassico Then
      Principal.View.FMXPrincipal.EncerrarNovaTelaPrincipalAutcom();
    {$ENDIF}

    pFinalizaObjetos;
    pTerminate(True, True);
  End;

end;

procedure TfrmPrincipal.pAddRelatoriosFavoritos(mnuBuscar, mnuAdd : TMenuItem; lstFavoritos: TStringList);
Var
  mnuItem: TMenuItem;
  i : Integer;
begin
  For i := 0 To mnuBuscar.Count-1 Do
  Begin
    If Not (lstFavoritos.IndexOf(mnuBuscar.Items[i].Name) >= 0) Then
      Continue;

    If Not (fVerificaAcessoSistema(mnuBuscar.Items[i].Hint)) Then
      Continue;

    mnuAutcomK.BeginUpdate;

    mnuItem := TMenuItem.Create(mnuAdd);
    mnuItem.Hint    := mnuBuscar.Items[i].Hint + 'Fav';
    mnuItem.Caption := mnuBuscar.Items[i].Caption;
    mnuItem.OnClick := mnuBuscar.Items[i].OnClick;
    mnuItem.Name    := mnuBuscar.Items[i].Name + 'Fav';
    mnuItem.Visible := mnuBuscar.Items[i].Visible;
    mnuItem.Enabled := mnuBuscar.Items[i].Enabled;

    mnuAdd.Add(mnuItem);

    mnuAutcomK.EndUpdate;

    If (mnuBuscar.Items[i].Count > 0) Then
      pAddRelatoriosFavoritos(mnuBuscar.Items[i], mnuItem, lstFavoritos);
  End;
end;

procedure TfrmPrincipal.pAdicionaSemaforo(mniMenu: TMenuItem);
Const
  arrIgnorarOnAfterExecute: Array Of String = ['mnuDashboard', 'mnuPainelEntregas', 'mnuTintaDeMaquina'];
Var
  intCont: Integer;
  objMenuSemaforo: TMenuSemaforo;
begin
  If (Assigned(mniMenu.OnClick)) Or (blnUsuarioLogadoUtilizaModoClassico And dicOrdenaMnu.ContainsKey(mniMenu.Name)) Then
  Begin
    objMenuSemaforo := TMenuSemaforo.Create(objSemaforoGeralMenus, VS_AutcomIniciadoModoRobo);

    If dicOrdenaMnu.ContainsKey(mniMenu.Name) Then
    begin
      If (Not Assigned(mniMenu.OnClick)) Then
        mniMenu.OnClick := pOnClick;

      objMenuSemaforo.OnOrdenaMenuItem := pProcessaDicOrdenaMenuItem;
    end;

    If Assigned(mniMenu.OnClick) Then
    Begin
      objMenuSemaforo.Evento := mniMenu.OnClick;

      If blnUsuarioLogadoUtilizaModoClassico Then
        objMenuSemaforo.OnAfterExecute := pGerarPopupRecentesFavoritos
      Else
      Begin
        If (Not MatchText(mniMenu.Name, arrIgnorarOnAfterExecute)) Then
          objMenuSemaforo.OnAfterExecute := pGerarPopupRecentesFavoritos;
      End;

      mniMenu.OnClick := objMenuSemaforo.pExecutar;
    End;

    lstSemaforos.Add(objMenuSemaforo);
  End;

  For intCont := 0 To mniMenu.Count -1 Do
  Begin
    pAdicionaSemaforo(mniMenu[intCont]);
  End;
end;

procedure TfrmPrincipal.pAguardaSincronizacaoEmail;
begin
  if Assigned(tmrSincEmail) then
    tmrSincEmail.Enabled := False;

  while TListaThreadsSincronizaEmails.GetInstance.QuantidadeThreads > 0 do
  begin
    TListaThreadsSincronizaEmails.GetInstance.pRemoveSincronizacoesConcluidas;
    Sleep(1000);
    Application.ProcessMessages;
  end;
end;


procedure TfrmPrincipal.pProcIniciaCotacao;
var frmCadCotacaoCX: TfrmCadCotacaoCX;
begin
  pCriarFormularios(TfrmCadCotacaoCX, frmCadCotacaoCX);
  Try
    frmCadCotacaoCX.btnIncluir.Click;
  Finally
    FreeAndNil(frmCadCotacaoCX);
  End;
end;

function TfrmPrincipal.ProcessExists(exeFileName: string): Boolean;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := False;
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
    begin
      Result := True;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

procedure TfrmPrincipal.ProcIniciaPedComp;
begin
  pPedidoDeCompraAutCom;
end;

procedure TfrmPrincipal.pAjustaMenuTintaMaquinaLogOff;
var
  stlTintas: TStringList;
  intContador: Integer;
begin
  Try
    stlTintas := TStringList.Create;

    For intContador := 0 To mnuTintaDeMaquina.Count - 1 Do
    Begin
      If (Pos(mnuTintaDeMaquina.Items[intContador].Hint,'frmConfTintaMaquina_mnuGlasurit_mnuSalcomix_') <= 0) Then
        stlTintas.Add(mnuTintaDeMaquina.Items[intContador].Name);
    End;

    If stlTintas.Count > 0 Then
    Begin
      For intContador := 0 To stlTintas.Count - 1 Do
      Begin
        pEliminaMenu(TMenuItem(mnuTintaDeMaquina.FindComponent(stlTintas[intContador])), False);
      End;
    End;
  Finally
    FreeAndNil(stlTintas);
  End;
end;

procedure TfrmPrincipal.pAjustaTintasLogOff;
var
  stlTintas: TStringList;
  intContador: Integer;
begin
  Try
    stlTintas := TStringList.Create;

    For intContador := 0 To mnuFatConsPrecos.Count - 1 Do
    Begin
      If (Pos(mnuFatConsPrecos.Items[intContador].Hint,'frmCadProdutos_frmConsultaFatProdutos_frmConsultaFatCatalogo_frmConsultaFatCatalogoAlteracao_') <= 0 ) Then
        stlTintas.Add(mnuFatConsPrecos.Items[intContador].Name);
    End;

    If stlTintas.Count > 0 Then
    Begin
      For intContador := 0 To stlTintas.Count - 1 Do
      Begin
        pEliminaMenu(TMenuItem(mnuFatConsPrecos.FindComponent(stlTintas[intContador])), False);
      End;
    End;
  Finally
    FreeAndNil(stlTintas);
  End;
end;

function TfrmPrincipal.PanelTEFIsVisible: Boolean;
begin
  Result := pnlMenTef.Visible;
end;

{*****************************************************************************}
{* VERIFICA NO BemaFI32.ini SE IMPRESSORA = 1 SE NÃO ESTIVER FORÇA A GRAVAÇÃO*}
{**************************************************************************RN*}
procedure TfrmPrincipal.pAtualizaBemaFI32;
function fPathSystem32 : String;
  Begin
    SetLength(Result, MAX_PATH);
    If GetSystemDirectory(PChar(Result), MAX_PATH) > 0 Then
      Result := String(PChar(Result))
    Else
      Result := 'C:\WINDOWS\system32\';
  End;

  function fBarraNoFinal(strPath: String) : String;
    Var
      strTmp : String;
  Begin
    strTmp := strPath;
    If Not (strTmp[Length(strTmp)] = '\') Then
      Result := strTmp + '\'
    Else
      Result := strTmp;
  End;

  Const
    strFileName = 'BemaFI32.ini';
  Var
    iniArqIni    : TIniFile;
    strPathApp   : String;
    strPathSys32 : String;
    strPath      : String;
    blnMp20      : Boolean;
    strDirIniLocal : String;
Begin
  strDirIniLocal := fCfgSis('DIRINI', varString);

  if fEmptyStr(strDirIniLocal) then
    Exit;

  if not TryDirectoryExists(strDirIniLocal) then
    Exit;

  blnMp20 := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO', '', strDirIniLocal + '/opcoes_fiscal.ini') = 'BEMATECH-MP20';

  strPath      := '';
  strPathApp   := fBarraNoFinal(ExtractFilePath(Application.ExeName));
  strPathSys32 := fBarraNoFinal(fPathSystem32);

  If FileExists(strPathSys32 + strFileName) Then
    strPath := strPathSys32 + strFileName
  Else If FileExists(strPathApp + strFileName) Then
    strPath := strPathApp + strFileName;

  If Not fEmptyStr(strPath) Then
  Begin
    iniArqIni := TIniFile.Create(strPath);
    Try
      Try
        If blnMp20 Then
        Begin
          If iniArqIni.ReadString('MFD', 'Impressora', '0') <> '0' Then
            iniArqIni.WriteString('MFD', 'Impressora', '0');
        End
        Else
        Begin
          If iniArqIni.ReadString('MFD', 'Impressora', '1') <> '1' Then
            iniArqIni.WriteString('MFD', 'Impressora', '1');

          If (Assigned(VS_objFiscal)) And (Pos('MP4200FI', VS_objFiscal.strModEcf) > 0) Then
            pCadastrarAliquotas(iniArqIni);
        End;
      Except
        On E: Exception Do
          pMensagensErro('Erro ao Atualizar BemaFI32.ini', '[TfrmPrincipal.pAtualizaBemaFI32]');
      End;
    Finally
      iniArqIni.Free;
    End;
  End;
end;

procedure TfrmPrincipal.pAtualizaEntregaVerificada(strAutinc: String);
Var
  strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE RASROM          ';
  strSQL := strSQL + 'SET                    ';
  strSQL := strSQL + '  RAS_VERPOP = "N"     ';
  strSQL := strSQL + 'WHERE                  ';
  strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

  pExecutaSQL(strSQL, ['AUTINC'], [strAutinc]);
end;

procedure TfrmPrincipal.pAtualizaProdReqOrdemServico(strCodReq, strCodEmp: String; Var blnConfirmado: Boolean);
var
  frmConEquipAtualizaProdutosReqCompra: TfrmConEquipAtualizaProdutosReqCompra;
begin
  pCriarFormularios(TfrmConEquipAtualizaProdutosReqCompra, frmConEquipAtualizaProdutosReqCompra);

  try
    frmConEquipAtualizaProdutosReqCompra.blnSomenteItensSemOS := False;
    frmConEquipAtualizaProdutosReqCompra.edtCodReq.Text := strCodReq;
    frmConEquipAtualizaProdutosReqCompra.strCodEmp      := strCodEmp;
    frmConEquipAtualizaProdutosReqCompra.ShowModal;
    blnConfirmado := frmConEquipAtualizaProdutosReqCompra.ModalResult = mrOk;
  finally
    pFreeAndNil(frmConEquipAtualizaProdutosReqCompra);
  end;
end;

procedure TfrmPrincipal.pAtualizaProdReqSemOS(strCodReq, strCodEmp: String; Var blnConfirmado: Boolean);
var
  frmConEquipAtualizaProdutosReqCompra: TfrmConEquipAtualizaProdutosReqCompra;
begin
  pCriarFormularios(TfrmConEquipAtualizaProdutosReqCompra, frmConEquipAtualizaProdutosReqCompra);

  try
    frmConEquipAtualizaProdutosReqCompra.blnSomenteItensSemOS := True;
    frmConEquipAtualizaProdutosReqCompra.edtCodReq.Text := strCodReq;
    frmConEquipAtualizaProdutosReqCompra.strCodEmp      := strCodEmp;
    frmConEquipAtualizaProdutosReqCompra.ShowModal;
    blnConfirmado := frmConEquipAtualizaProdutosReqCompra.ModalResult = mrOk;
  finally
    pFreeAndNil(frmConEquipAtualizaProdutosReqCompra);
  end;

end;

procedure TfrmPrincipal.pBloqueiaBotoes;
Var
 i, x : Integer;
begin
  For i := 0 to Self.ComponentCount - 1 do
  Begin
    If Self.Components[i].ClassNameIs('TfraPesquisarMenu') Then
    Begin
      For x := 0 to TfraPesquisarMenu(Self.Components[i]).ComponentCount - 1 do
      Begin
        If TfraPesquisarMenu(Self.Components[i]).Components[x].ClassNameIs('TcxImage') Then
          TcxImage(TfraPesquisarMenu(Self.Components[i]).Components[x]).Properties.ReadOnly := True;
      End;
    End;

    If Self.Components[i].ClassNameIs('TcxImage') Then
      TcxImage(Self.Components[i]).Properties.ReadOnly := True;
  End;
end;

procedure TfrmPrincipal.pCadastrarAliquotas(iniArqIni: TIniFile);
  Var
    qryAlqs: TUniQuery;
    strCodAlq: String;
    strAlqBema: String;
    arrAlqs: Array[1..16] Of String;
    intContador: Integer;
    blnTemPreenchido: Boolean;

  function fAlqBema(fltAlq: Double): String;
  begin
    Result := FloatToStrF(fltAlq, ffNumber, 12, 2);
    Result := fStrZero(AnsiReplaceStr(AnsiReplaceStr(Result, ',', ''), '.', ''), 4) + '_T';
  end;

  function fAliquotasIniDiferenteCadastro: Boolean;
    Var
      intCont: Integer;
  begin
    For intCont := Low(arrAlqs) To High(arrAlqs) Do
    Begin
      If fEmptyStr(arrAlqs[intCont]) Then
      Begin
        Result := qryAlqs.Locate('ECF_CODALQ', fStrZero(intCont, 2), []);
      End
      Else
      Begin
        If Not qryAlqs.Locate('ECF_CODALQ', fStrZero(intCont, 2), []) Then
        Begin
          Result := True;
        End
        Else
        Begin
          Result := arrAlqs[intCont] <> fAlqBema(qryAlqs.FieldByName('ECF_PERALQ').AsFloat);
        End;
      End;

      If Result Then
      Begin
        Break;
      End;
    End;
  end;
begin
  if not fCfgSis('VERALQ', varBoolean) then
    Exit;

  qryAlqs := fCriaQuery(Nil);
  qryAlqs.SQL.Add('SELECT * FROM ECFALQ WHERE ECF_CODECF = :CODECF ORDER BY ECF_CODALQ ');
  qryAlqs.ParamByName('CODECF').AsString := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA', '', fCfgSis('DIRINI') + '/opcoes_fiscal.ini');
  qryAlqs.Open;

  blnTemPreenchido := False;
  For intContador := Low(arrAlqs) To High(arrAlqs) Do
  Begin
    arrAlqs[intContador] := iniArqIni.ReadString('Aliquotas', 'Aliquota' + fStrZero(intContador, 2), '');
    If Not fEmptyStr(arrAlqs[intContador]) Then
    Begin
      blnTemPreenchido := True;
    End;
  End;

  Try
    If (Not blnTemPreenchido) Then
    Begin
      qryAlqs.First;
      While (Not qryAlqs.Eof) Do
      Begin
        strCodAlq := fStrZero(qryAlqs.FieldByName('ECF_CODALQ').AsString, 2);
        strAlqBema := fAlqBema(qryAlqs.FieldByName('ECF_PERALQ').AsFloat);

        iniArqIni.WriteString('Aliquotas', 'Aliquota' + strCodAlq, strAlqBema);

        qryAlqs.Next;
      End;
    End
    Else If fAliquotasIniDiferenteCadastro Then
    Begin
      VS_objFiscal := Nil;
      Raise Exception.Create('Atenção: as alíquotas desse ECF estão diferentes das alíquotas dos outros ECFs da empresa. Entre em contato com a Citel.');
    End;
  Finally
    FreeAndNil(qryAlqs);
  End;
end;

procedure TfrmPrincipal.pOnClickComDireitoAcessoAutTin(Sender: TObject);
begin
  If FLibAutTinInicializada Then
    Exit;

  pCarregaMenuTintaMaquinaSobDemanda(Sender);
end;

procedure TfrmPrincipal.pCarregarLibFuncoes;
begin
  pIniciaDllFuncoes(frmModulo.GetCurrentConnection, strLoginUsuarioLogado, VS_strCodEmp, DebugHook, TCfgSis.Create(),
    untFuncoesSimples.VS_objTraceViewer, VS_Date, VS_ComputerNetName, VS_UserFromWindows, VS_IPAddressAsString,
    VS_MacAddress);
end;

procedure pCallbackCarregaMenuTintaMaquinaParaAutcomTintaDll; stdcall;
begin
  If Assigned(frmPrincipal) Then
    frmPrincipal.pCarregaMenuTintaMaquinaSobDemanda(Nil, True);
end;

procedure TfrmPrincipal.pCarregarLibTintaMaquina;
begin
  pCarregaFuncoesDll(fGravaMovGer,
                     fGravaMovDet,
                     Nil,
                     Nil,
                     TLiberacao.Create,
                     untFuncoesSimples.VS_objTraceViewer,
                     TExecutaSQLReplicacaoTinta.Create,
                     Nil,
                     Nil,
                     TFuncoesSaldos.Create,
                     pImprimeFatImpTin);

  {$IFNDEF LINUX}
  If (VS_strUsaTmq = 'S') Then
    pRegistrarCallbackCarregaMenuTintaMaquina(@pCallbackCarregaMenuTintaMaquinaParaAutcomTintaDll);
  {$ENDIF}
end;

procedure TfrmPrincipal.pCarregarMenusAcesso;
  Var
    intContador: Integer;
    strNomeTrava: string;
begin
  Try
    strNomeTrava := 'IMPORTAR_CTE_' + VS_strCodEmp;
    mnuAutcomK.BeginUpdate;
    pGeraMenusConsultaTinta;
    pGeraMenuTintaMaquina;
    GeraMenuLibCartoes;

    {*****************************************}
    {* DESCRIÇÃO DO MENU "PIGMENTO"          *}
    {**************************************MV*}
    mnuFatPigmento.Caption := IIF(fEmptyStr(fCfgSis('DESCPI')),'Pigmento',fCfgSis('DESCPI'));

    {*********************************************************}
    {* ALTERA A DESCRICAO DO MENU DE IMPRESSAO DAS ETIQUETAS *}
    {* DE ORCAMENTO OU PEDIDO CONFORME CONFIGURACAO          *}
    {******************************************************IV*}
    If (fCfgSis('ESPCFO') = 'OR') Then
    Begin
      frmPrincipal.mnuEtiOrcPed.Caption := 'Produtos do Orçamento';
      frmPrincipal.mnuEditorEtiquetasItensOrcPed.Caption := 'Configura Etiquetas de Produtos do Orçamento';
    End
    Else
    Begin
      frmPrincipal.mnuEtiOrcPed.Caption := 'Produtos do Pedido';
      frmPrincipal.mnuEditorEtiquetasItensOrcPed.Caption := 'Configura Etiquetas de Produtos do Pedido';
    End;

    For intContador := 0 To mnuAutcomK.Items.Count-1 Do
    Begin
      If (mnuAutcomK.Items[intContador].Caption <> '-') Then
      Begin
        pAdicionaSemaforo(mnuAutcomK.Items[intContador]);
      End;
    End;

    pProcessaMenu;
    pEscondeMenus;

    mnuCadCaixas.Visible := (mnuCadCaixas.Visible) And
                            (fCfgSis('TPFCCX') = 'C');

    mnuRcxTransfLancamentosEntreCaixas.Visible := (mnuRcxTransfLancamentosEntreCaixas.Visible) And
                                                  (fCfgSis('TPFCCX') = 'C');

    mnuRcxLiberacaoDeCaixas.Visible := (mnuRcxLiberacaoDeCaixas.Visible) And
                                       (fCfgSis('TPFCCX') = 'C');

    mnuCtpLiberacaoPrevisao.Visible := (mnuCtpLiberacaoPrevisao.Visible) And
                                       (fCfgSis('CTPPRE') = 'S');


    {**************************************************************}
    {* REFTRI-02: ATIVAR PRECOS DA REFORMA TRIBUTARIA SO COM O     *}
    {* PLUGIN APTO E EM EMPRESA QUE GERENCIA PRECO (NAO RECEBE DA  *}
    {* MATRIZ). TAG = 1 IMPEDE O pExibeMenu DE REEXIBIR O ITEM.    *}
    {**************************************************************}
    mnuConvertReforma.Visible := fReformaConvertDisponivel And (Not fPreMat);
    mnuConvertReforma.Tag := IIF(mnuConvertReforma.Visible, 0, 1);

    fraPesquisarMenu.pMontarPesquisa;

    If blnUsuarioLogadoUtilizaModoClassico Then
    Begin
      pGeraPopUpFaturamento;
      pGeraPopUpFinanceiro;
      pGeraPopUpMovimentacaoItens;
      pGeraPopUpDASSuvinil;
      pGeraPopUpLocacaoEquipamento;
      pGeraPopUpTintasMaquinas(Self, mnuTintaDeMaquina, popTintasMaquina.Items);
      pGeraPopUpWMS;
    End;

    pGerarPopupRecentesFavoritos;

    pTituloSistema;

    pnlFundo.Color := fRetCorEmpresa(VS_strCodEmp);

    mnuEditorEtiquetasIndividuaisDespachoProduto.Visible := fCfgSis('IMPEIP', varBoolean);
    mnuEditorEtiquetasIndividuaisDespachoProdutoArgox.Visible := fCfgSis('IMPEIP', varBoolean);

    {*********************************************************}
    {* VERIFICA SE EXIBE OS MENUS REFERENTE AS TABELAS       *}
    {* DINAMICAS ("CFG_TABDIN")                              *}
    {******************************************************RV*}
    frmPrincipal.mnuAltEfetivacaoPrecosTab.Visible := fCfgSis('TABDIN', varBoolean);

    mnuPedidosLiberacao.Visible := fCfgSis('HABREM', varBoolean);
  //  mnuRelCadLogFrm.Visible     := fCfgSis('LOGFRM', varBoolean);

    {****************************************************}
    {* CASO NÃO EXISTA A TABELA DEL_CADPAG TORNA O MENU *}
    {* RELATÓRIOS\CONTAS A PAGAR\TÍTULOS DELETADOS      *}
    {* INVISÍVEL                                        *}
    {*************************************************JU*}

    pDesabilitaHabilitaTimerECarregaEventoOnTimer(fCfgSis('PAFECF', varBoolean),
                                                  tmrIniciaImportacaoPAF, tmrIniciaImportacaoPAFOnTimer, 'tmrIniciaImportacaoPAF',
                                                  Self,
                                                  RandomRange(TIMER_UM_MINUTO, TIMER_DEZ_MINUTOS)); 

    pDesabilitaHabilitaTimerECarregaEventoOnTimer(fCfgSis('EMICTE', varBoolean),
                                                  tmrImportaCTes, tmrImportaCTesOnTimer, 'tmrImportaCTes',
                                                  Self,
                                                  90000);

    strNomeTrava := 'IMPORTAR_CTE_' + VS_strCodEmp;

    if (not blnGerImpCTe) and (Assigned(tmrImportaCTes)) and (tmrImportaCTes.Enabled) and (not fTravaBancoAtiva(strNomeTrava)) then
      fGetLock(strNomeTrava);

    if Assigned(tmrMonitor) then
      tmrMonitor.Enabled := True;

    if Assigned(tmrGatime) then
      tmrGatime.Enabled := True;

    If (Assigned(tmrLotWms)) and (fCfgSis('WMRBTP', varInteger) > 0) And fUsaRotinaWMS() And (fCfgSis('WMSSEP') = '2') And (fCfgSis('WMSROB') = 'S') Then
    Begin
      tmrLotWms.Interval := fCfgSis('WMRBTP', varInteger) * 1000;
      tmrLotWms.Enabled  := True;
    End;

    IMPEXP.Caption := 'Expedição - F6 - Imprimir ' + IfThen(fCfgSis('SEPEXP') = 'P', 'Pedido', 'Separação');

    pGeraMenuRelatoriosFavoritos;

    pExibiBotoes;

    TLogAut.New().pLogin();
  Finally
    mnuAutcomK.EndUpdate;
  End;
end;

procedure TfrmPrincipal.pCarregarRelatorios;
  Var
    arrMenuItem: TarrMenu;
begin
  Try
    mnuAutcomK.BeginUpdate;

    SetLength(arrMenuItem, Length(arrMenuItem)+1);
    arrMenuItem[High(arrMenuItem)] := mnuRelatorio;

    SetLength(arrMenuItem, Length(arrMenuItem)+1);
    arrMenuItem[High(arrMenuItem)] := mnuContabilidade;

    SetLength(arrMenuItem, Length(arrMenuItem)+1);
    arrMenuItem[High(arrMenuItem)] := mnuUtil;

    SetLength(arrMenuItem, Length(arrMenuItem)+1);
    arrMenuItem[High(arrMenuItem)] := mnuControlePagtoFuncionarios;

    SetLength(arrMenuItem, Length(arrMenuItem)+1);
    arrMenuItem[High(arrMenuItem)] := mnuBalanceteFinanceiro;

    SetLength(arrMenuItem, Length(arrMenuItem)+1);
    arrMenuItem[High(arrMenuItem)] := mnuLivroFiscal;

    objRelatorio := TRelatorio.Create(Self, True, False, Nil, False, 'CADVAL', '','', True, True);
    objRelatorio.pInsereOpcoesRelatorio(Self, mnuAutcomK, arrMenuItem, False);

    objPlugin := TPlugin.Create(Self, mnuAutcomK);
    objPlugin.pCarregarPlugin;
  Finally
    mnuAutcomK.EndUpdate;
  End;
end;

procedure TfrmPrincipal.pGeraMenuRelatoriosFavoritos;
Var
  mnuRisco  : TMenuItem;
  qryFav    : TUniQuery;
  stlMenFav : TStringList;
begin
  If Not fTabelaExiste('RELFAV', True) Then
    Exit;

  Try
    stlMenFav := TStringList.Create;
    qryFav    := fCriaQuery(Nil);

    qryFav.SQL.Clear;
    qryFav.SQL.Add('SELECT * FROM RELFAV ');
    qryFav.SQL.Add('ORDER BY AUTOINCREM  ');
    qryFav.Open;

    If Not qryFav.IsEmpty Then
    Begin
      qryFav.First;

      If (qryFav.FieldByName('FAV_HABILI').AsString = 'S') Then
      Begin
        mnuAutcomK.BeginUpdate;

        If Not Assigned(mnuRelFav) Then
        Begin
          mnuRisco := TMenuItem.Create(mnuRelatorio);
          mnuRisco.Caption := '-';
          mnuRisco.Name    := 'mnuRiscoFavoritos';
          mnuRelatorio.Add(mnuRisco);

          mnuRelFav         := TMenuItem.Create(mnuRelatorio);
          mnuRelFav.Hint    := 'mnuRelatoriosFavoritos';
          mnuRelFav.Caption := qryFav.FieldByName('FAV_DESMEN').AsString;
          mnuRelFav.Name    := 'mnuRelatoriosFavoritos';
          mnuRelatorio.Add(mnuRelFav);
        End
        Else
        Begin
          If (mnuRelFav.Count > 0) Then
            mnuRelFav.Clear;
        End;

        mnuAutcomK.EndUpdate;

        stlMenFav.Clear;
        While Not qryFav.Eof Do
        Begin
          stlMenFav.Add(qryFav.FieldByName('FAV_NOMREL').AsString);
          qryFav.Next;
        End;

        pAddRelatoriosFavoritos(mnuRelatorio, mnuRelFav, stlMenFav);
      End;
    End;

    qryFav.Close;

  Finally
    FreeAndNil(stlMenFav);
    FreeAndNil(qryFav);
  End;
end;

procedure TfrmPrincipal.pCertificadoDigital;
var
  strCertificadoDigital : String;
begin
  strCertificadoDigital := fGetCertificado;
  If not fEmptyStr(strCertificadoDigital) Then
    pGravaCfgCertificadoDigital(strCertificadoDigital);
end;

procedure TfrmPrincipal.pCfgCadProvedorEmail;
begin
  pCriarForm(TfrmCfgCadProvedorEmail);
end;

procedure TfrmPrincipal.pCfgCamposClientesCRM;
begin
  pCriarForm(TfrmCfgCamposClientesCRM);
end;

procedure TfrmPrincipal.pCfgCamposFornecedoresCRM;
begin
  pCriarForm(TfrmCfgCamposFornecedoresCRM);
end;

procedure TfrmPrincipal.pCfgCliAti;
begin
  pCriarForm(TfrmCfgCliAti);
end;

procedure TfrmPrincipal.pCfgFornecedoresTagsTigre;
begin
  pCriarForm(TfrmFornecedoresTagsTigre);
end;

procedure TfrmPrincipal.pCfgCondicaoPagamento;
begin
  pCriarForm(TfrmCfgCondicaoPagamento);
end;

procedure TfrmPrincipal.pCfgCredenciaisSitefExp;
begin
  pCriarForm(TfrmCfgCredenciaisSitefExp);
end;

procedure TfrmPrincipal.pCfgDescricaoLocRet;
begin
  pCriarForm(TfrmCfgDescricaoLocRet);
end;

procedure TfrmPrincipal.pCfgEmailAutEntrada;
var frmCfgEmailAutEntrada: TfrmCfgEmailAutEntrada;
begin
  pCriarFormularios(TfrmCfgEmailAutEntrada, frmCfgEmailAutEntrada);
  frmCfgEmailAutEntrada.procCfgDisparaEmailPedidoDeCompraAutomatico :=   TfrmDigEmailPedidoCompra.pChamaConfiguracaoEnvioAutoticoEmail;
  frmCfgEmailAutEntrada.ShowModal;
end;

procedure TfrmPrincipal.pCfgFpfAti_Autonomo;
begin
  TfrmCfgFpfAti.pChamaTelaDeAmarracaoFidelidadeGrupoDeAtividade(tpfAutonomo);
end;

procedure TfrmPrincipal.pCfgFpfAti_Fisica;
begin
  TfrmCfgFpfAti.pChamaTelaDeAmarracaoFidelidadeGrupoDeAtividade(tpfFisica);
end;

procedure TfrmPrincipal.pCfgFpfAti_Juridica;
begin
  TfrmCfgFpfAti.pChamaTelaDeAmarracaoFidelidadeGrupoDeAtividade(tpfJuridica);
end;

procedure TfrmPrincipal.pCfgHorBloqueioTransferenciaCodigo(
  var pstrValCfg: String);
Var
  lfrm: TfrmCfgHorarioBloqueioTransferenciaCodigo;
begin
  pCriarFormularios(TfrmCfgHorarioBloqueioTransferenciaCodigo, lfrm);
  Try
    lfrm.strPeriodo := pstrValCfg;
    lfrm.ShowModal;
    if lfrm.ModalResult = mrOk then
      pstrValCfg := lfrm.strPeriodo;
  Finally
    If Assigned(lfrm) Then
      pFreeAndNil(lfrm);
  End;
end;

procedure TfrmPrincipal.pCfgItensOrdenaPadrao;
Var
  objSeqCom : TSeqCom;
  stlItens  : TStringList;
  intCnt    : Integer;
  cdsItens  : TUniClientDataSet;
begin

  stlItens  := Nil;
  cdsItens  := Nil;
  objSeqCom := TSeqCom.Create(Self);

  pCriarFormularios(TfrmCfgItensOrdenaPadrao, frmCfgItensOrdenaPadrao);

  Try

    frmCfgItensOrdenaPadrao.strCampoCha := 'COM_DESCRI';
    frmCfgItensOrdenaPadrao.strCampoSeq := 'COM_SEQIND';
    frmCfgItensOrdenaPadrao.pAdicionarItem('COM_SEQIND', 'Sequência', ftInteger);
    frmCfgItensOrdenaPadrao.pAdicionarItem('COM_DESCRI', 'Descrição', ftString, 50);
    frmCfgItensOrdenaPadrao.pIniciarDados;
    stlItens := objSeqCom.fGetLista;

    For intCnt := 0 To (stlItens.Count-1) Do
      frmCfgItensOrdenaPadrao.pAdicionarDados(['COM_SEQIND', 'COM_DESCRI'], [IntToStr(intCnt), stlItens.Strings[intCnt]]);

    frmCfgItensOrdenaPadrao.ShowModal;

    If (frmCfgItensOrdenaPadrao.ModalResult = mrOK) Then
    Begin

      With frmCfgItensOrdenaPadrao Do
      Begin
        cdsItens := fGetCopiaCds;

        If Not cdsItens.IsEmpty Then
        Begin
          fStartTransaction;
          Try
            cdsItens.First;
            While Not cdsItens.Eof Do
            Begin
              objSeqCom.pUpdateTabela(cdsItens.FieldByName('COM_SEQIND').AsInteger, cdsItens.FieldByName('COM_DESCRI').AsString);
              cdsItens.Next;
            End;
            fCommit;
          Except
            On E: Exception Do
            Begin
              fRollBack;
            End;
          End;
        End;
      End;

    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCfgRepositorio.btnSeqComPropertiesButtonClick]');
  End;

  If Assigned(cdsItens) Then
    FreeAndNil(cdsItens);

  If Assigned(stlItens) Then
    FreeAndNil(stlItens);

  If Assigned(objSeqCom) Then
    FreeAndNil(objSeqCom);

  If Assigned(frmCfgItensOrdenaPadrao) Then
    pFreeAndNil(frmCfgItensOrdenaPadrao);

end;

procedure TfrmPrincipal.pCfgMltBol;
begin
  pCriarForm(TfrmCfgMltBol);
end;

procedure TfrmPrincipal.pCfgModCartaAnu;
begin
  pCriarForm(TfrmCfgModCartaAnu);
end;

procedure TfrmPrincipal.pCfgModCartaDes;
begin
  pCriarForm(TfrmCfgModCartaDes);
end;

procedure TfrmPrincipal.pCfgModCartaPro;
begin
  pCriarForm(TfrmCfgModCartaPro);
end;

procedure TfrmPrincipal.pCfgOcoFid;
begin
  pCriarForm(TfrmCfgOcoFid);
end;

procedure TfrmPrincipal.pCfgPais;
begin

  Try

    pCriarFormularios(TfrmCfgPais, frmCfgPais);
    frmCfgPais.strSigPai := fRetSiglaPaisAtual;
    frmCfgPais.ShowModal;

    If (frmCfgPais.blnConfirma) Then
      pGravaCfgPais(frmCfgPais.strSigPai);

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmPrincipal.pCfgPais]');
  End;

  FreeAndNil(frmCfgPais);

end;

procedure TfrmPrincipal.pCfgValorMaxEmissaoNFCeUF;
begin
  pCriarForm(TfrmValorMaxEmissaoNFCeUF);
end;

procedure TfrmPrincipal.pChecagemCfgCliAti;
  Var
    qryCfgSis : TUniQuery;
    qryLogCfg : TUniQuery;
    repCliAti : TCliAtiRepository;
begin
  qryCfgSis := fCriaQuery(Self);
  qryLogCfg := fCriaQuery(Self);
  repCliAti := TCliAtiRepository.Create(False);

  Try
    With qryCfgSis Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT * ');
      SQL.Add('   FROM CFGSIS ');
      SQL.Add('  WHERE SIS_CODCFG = "CFG_CLIATI" ');
      SQL.Add('    AND SIS_CODEMP = :CODEMP ');
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If (Not IsEmpty) And
         (Not fEmptyStr(FieldByName('SIS_VALCFG').AsString)) And
         (Not fEmptyStr(fRetNomAtividade(FieldByName('SIS_VALCFG').AsString))) And
         (Not repCliAti.fAtividadeCadastrada(FieldByName('SIS_VALCFG').AsString)) Then
      Begin
        If repCliAti.fInsereAtividade(FieldByName('SIS_VALCFG').AsString) Then
        Begin
          qryLogCfg.Close;
          qryLogCfg.SQL.Clear;
          qryLogCfg.SQL.Add('SELECT * FROM LOGCFG WHERE FALSE');
          qryLogCfg.Open;

          qryLogCfg.Insert;
          qryLogCfg.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOGCFG', VS_strCodEmp);
          qryLogCfg.FieldByName('LOG_DTAALT').AsDateTime := VS_Date;
          qryLogCfg.FieldByName('LOG_HORALT').AsDateTime := fTime();
          qryLogCfg.FieldByName('LOG_CODOPE').AsString := strLoginUsuarioLogado;
          qryLogCfg.FieldByName('LOG_CODEMP').AsString := VS_strCodEmp;
          qryLogCfg.FieldByName('LOG_EMPCFG').AsString := FieldByName('SIS_CODEMP').AsString;
          qryLogCfg.FieldByName('LOG_CODCFG').AsString := FieldByName('SIS_CODCFG').AsString;
          qryLogCfg.FieldByName('LOG_VALANT').AsString := FieldByName('SIS_VALCFG').AsString;
          qryLogCfg.FieldByName('LOG_VALATU').AsString := '';
          qryLogCfg.Post;

          qryCfgSis.Edit;
          qryCfgSis.FieldByName('SIS_VALCFG').AsString := '';
          qryCfgSis.Post;
        End;
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryCfgSis);
    FreeAndNil(qryLogCfg);
    FreeAndNil(repCliAti);
  End;
end;

procedure TfrmPrincipal.mnuGerarGTINAtualizarCadastroGS1CNPClick(
  Sender: TObject);
begin
  pCriarForm(TfrmGerarGTINAtualizarCadastroGS1CNP, frmGerarGTINAtualizarCadastroGS1CNP);
end;

procedure TfrmPrincipal.mnuGerarOrcamentoCompraAutoClick(Sender: TObject);
begin

  If fMensagem('','Calcular pelo estoque:', ['&Mínimo/Máximo', '&Giro de Estoque' ], 1, True, 1, 150) = 1 Then
    pCriarForm(TfrmGerarOrcamentoCompraAuto)
  Else
   TGeraOrc.fGeraItensGiro(True);
end;

procedure TfrmPrincipal.mnuRelRecPagtoFuncClick(Sender: TObject);
begin
  pCriarForm(TfrmRelRecPagtoFunc);
end;

procedure TfrmPrincipal.mnuRelFatReimprDocumentosClick(Sender: TObject);
begin
  pCriarForm(TfrmReimpressaoDocs);
end;

procedure TfrmPrincipal.mnuFatResumoCaixaClick(Sender: TObject);
  Var
    blnConfirma: Boolean;

    strCodOpe,
    strNomOpe,
    strCodigoCaixa,
    strDescricaoCaixa: String;

    blnValorOriVerificaTef: Boolean;
    frmRcxOperador : TfrmRcxOperador;
    frmRcxResumoCaixa : TfrmRcxResumoCaixa;
begin
  If (Not fVerificaAcessoSistema(mnuFatResumoCaixa.Hint)) Then
  Begin
    fMensagem('', 'Esse usuário não tem direito a acessar esse módulo!', ['&Ok']);
    Exit;
  End;

  {***************************************}
  {* CONFERE CADASTRO PORTADOR DA BAIXA  *}
  {*********************************IV,RN*}
  If fEmptyStr(fRetNomPortador(fCfgSis('PORRCX'))) Then
  Begin
    fMensagem('ATENÇÃO', 'O Portador de Baixa do Contas a Receber CFG_PORRCX ' + #13#10 + ' não existe ou não está cadastrado, corrija!', ['&OK']);
    Exit;
  End;

  blnValorOriVerificaTef := blnVerificaTef;

  VS_strCodigoOperadorLogadoCaixa := '';
  try
    Try
      blnVerificaTef := True;
      pCriarFormularios(TfrmRcxOperador, frmRcxOperador);

      frmRcxOperador.ShowModal;

      blnConfirma := frmRcxOperador.blnRetorno;
      strCodOpe   := frmRcxOperador.edtCodOpe.Text;
      strNomOpe   := frmRcxOperador.edtDesOpe.Text;
      strCodigoCaixa    := frmRcxOperador.edtCodigoCaixa.Text;
      strDescricaoCaixa := frmRcxOperador.edtDescricaoCaixa.Text;
      VS_strCodigoOperadorLogadoCaixa := frmRcxOperador.edtCodOpe.Text;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmPrincipal.mnuFatResumoCaixaClick]');
        blnConfirma := False;
      End;
    End;
    pFreeAndNil(frmRcxOperador);
    blnVerificaTef := blnValorOriVerificaTef;

    If (blnConfirma) Then
    Begin
      blnVerificaTef := True;
      pCriarFormularios(TfrmRcxResumoCaixa, frmRcxResumoCaixa);
      Try
        Try
          If Not frmRcxResumoCaixa.blnFecharForm Then
          Begin
            frmRcxResumoCaixa.edtCodOpe.Text := strCodOpe;
            frmRcxResumoCaixa.edtNomOpe.Text := strNomOpe;
            frmRcxResumoCaixa.edtCodigoCaixa.Text    := strCodigoCaixa;
            frmRcxResumoCaixa.edtDescricaoCaixa.Text := strDescricaoCaixa;
            frmRcxResumoCaixa.ShowModal;
          End;
        Except
          On E: Exception Do
            pMensagensErro(E.Message, '[frmPrincipal.mnuFatResumoCaixaClick]');
        End;
      Finally
        blnVerificaTef := blnValorOriVerificaTef;
        pFreeAndNil(frmRcxResumoCaixa);
      End;
    End;
  finally
    VS_strCodigoOperadorLogadoCaixa := '';
  end;

end;

procedure TfrmPrincipal.mnuFatRetiraDigSeparadorClick(Sender: TObject);
begin
  pCriarForm(TfrmFatRetiraDigSeparador);
end;

procedure TfrmPrincipal.mnuFatRetornoConsignacaoClick(Sender: TObject);
  var
    LblnChamarRetornoConsignacaoNovamente : Boolean;
begin
  If fEmptyStr(fCfgSis('RETCON')) Then
  Begin
    pMensagemOk('Configure a Classificação Fiscal para Retorno de Mercadoria em Consignação em Configurações/Faturamento');
    Exit;
  End;

  strListIdGerEle.Clear;

  Repeat
    pEscolherOpcaoRetornoConsignacao(LblnChamarRetornoConsignacaoNovamente);
  Until not LblnChamarRetornoConsignacaoNovamente ;

end;

procedure TfrmPrincipal.tmrAlpeBoletoOnTimer(Sender: TObject);
var
  LLogTmr: ILogTmr;
begin
  If Not fPodeExecutarFuncaoDoTimer Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If fAutComEmModoImportacao Then
    Exit;

  If fOpcoesIgnorar Then
    Exit;

  If (blnGerImpPdv) or (blnGerImpCTe) Then
    Exit;

  If fInTransaction then
    Exit;

  If Not fCfgSis('ALPKNK', varBoolean) then
    Exit;

  LLogTmr := TLogTmr.New('tmrAlpeBoletoOnTimer').Enter('ThreadProcessaAlpeBoleto');
  Try
    if Assigned(ThreadProcessaAlpeBoleto) then
    begin
      if ThreadProcessaAlpeBoleto.Finished then
      begin
        FreeAndNil(ThreadProcessaAlpeBoleto);
        LLogTmr.Exit('ThreadProcessaAlpeBoleto.Finished = True');
        fLock_Unlock('Thread_TIMER_ALPE_BOLETO_'+VS_strCodEmp, False, False);
        Exit;
      end
      else
      begin
        LLogTmr.Exit('ThreadProcessaAlpeBoleto.Finished = False');
        Exit;
      end;
    end;

    if fLock_Unlock('Thread_TIMER_ALPE_BOLETO_'+VS_strCodEmp, True, False, False, '', False) then
    begin
      ThreadProcessaAlpeBoleto := TThreadProcessaAlpeBoleto.Create(fCfgSis('MINACK', varString),
                                                                   fCfgSis('MINACN', varString),
                                                                   fCfgSis('MINENP', varString),
                                                                   fCfgSis('MINBKT', varString));

      ThreadProcessaAlpeBoleto.FreeOnTerminate := False;
      ThreadProcessaAlpeBoleto.Start;
      LLogTmr.Exit('ThreadProcessaAlpeBoleto.Start');
      Exit;
    end;

  Finally

    If fGetTentativasLock('Thread_TIMER_ALPE_BOLETO_'+VS_strCodEmp) > 20 Then
    Begin
      pDestravaLockForcado('Thread_TIMER_ALPE_BOLETO_'+VS_strCodEmp, 20);

      LLogTmr.Exit('ThreadProcessaAlpeBoleto.pDestravaLockForcado');
    End;

  End;
end;

procedure TfrmPrincipal.tmrAvisoDebitoAutomaticoOnTimer(Sender: TObject);
  Var
    LModelo: String;
    LLogTmr: ILogTmr;
begin
  If Not fPodeExecutarFuncaoDoTimer Then
    Exit;

  tmrAvisoDebitoAutomatico.Enabled := False;
  tmrAvisoDebitoAutomatico.Interval := 125000;

  If OperadorCitelLogado Then
    Exit;

  LModelo := TMostraDebCtrChq2.RetornaModeloEmail;

  If Not TEmailAutController.ExisteOModeloAvisoDebitoAtivo(LModelo) Then
    Exit;

  If TMostraDebCtrChq2.EnviouTodosAvisosDebitosClientes(LModelo) Then
    Exit;

  If Assigned(VS_objTraceViewer) Then
    VS_objTraceViewer.LogTimer('tmrAvisoDebitoAutomaticoOnTimer');

  LLogTmr := TLogTmr.New('tmrAvisoDebitoAutomaticoOnTimer')
    .Enter('ExecutaMonitorAvisoDebito');

  If DeveEnviarAvisoDeDebito Then
    ExecutaMonitorAvisoDebito;

  tmrAvisoDebitoAutomatico.Enabled := True;

  LLogTmr.Exit;
end;

procedure TfrmPrincipal.tmrAvisosPrevisaoCTPOnTimer(Sender: TObject);
var
  LLogTmr: ILogTmr;
begin
  if (blnGerImpCTe) then
    Exit;

  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If Assigned(VS_objTraceViewer) Then
    VS_objTraceViewer.LogTimer('tmrProjetosAtrasadoTimer');

  LLogTmr := TLogTmr.New('tmrProjetosAtrasadoTimer')
    .Enter('TLiberacaoPrevisaoPagar.fRetornaAvisosPrevisionamentoCTPNaoLidos');

  tmrAvisosPrevisaoCTP.Enabled := False;

  cdsAvisosPrevisionamentoCTP := TLiberacaoPrevisaoPagar.fRetornaAvisosPrevisionamentoCTPNaoLidos(strLoginUsuarioLogado);

  If Not cdsAvisosPrevisionamentoCTP.IsEmpty Then
  Begin
    dxAlertWindow.OptionsButtons.Buttons[2].Visible := True;
    dxAlertWindow.Show('AUTCOM - Previsionamento', 'Existem previsionamentos de contas a pagar reprovados!');
    dxAlertWindow.OptionsButtons.Buttons[2].Visible := False;
  End;

  tmrAvisosPrevisaoCTP.Enabled := True;

  LLogTmr.Exit;
end;

procedure TfrmPrincipal.tmrCobrancaEletronicaOnTimer(Sender: TObject);
var
  LLogTmr: ILogTmr;
begin
  // 1. Gates em memória primeiro (custo zero, antes de qualquer I/O)
  If TfrmErroRede.fExibindoMensagemErroRede Then Exit;
  If TfrmConectando.fTentandoReconectarModulo Then Exit;

  // 2. Gate de operador em memória — 99 estações saem aqui sem tocar em nada
  If OperadorCitelLogado Then
  Begin
    tmrCobrancaEletronica.Enabled := False;
    Exit;
  End;

  // 3. Gate de configuração (cache em memória) ANTES do lock distribuído.
  //    Evita contender pela tabela LOCKS em estações que usam outro gateway.
  If Not TFacadeCobrancaEletronica
           .fUtilizarRoboDisparosCobrancaEletronica(tcPagarMe) Then
    Exit;

  // 4. Lock distribuído. Só a estação vencedora dispara o EXE;
  //    o lock fica preso até o próprio EXE liberar em pFinaliza.
  If Not fLock_Unlock(SP_DISPARO_COBRANCA_ELETRONICA_AUTOMATICO,
                      True, False, False, EmptyStr, False) Then
  Begin
    // Lock órfão > 2h: força liberação para próximo tick reentrar
    if fGetTempoDuracaoLock(SP_DISPARO_COBRANCA_ELETRONICA_AUTOMATICO) > StrToTime('02:00:00') Then
      fLock_Unlock(SP_DISPARO_COBRANCA_ELETRONICA_AUTOMATICO,
                   False, False, False, EmptyStr, False,
                   SP_DISPARO_COBRANCA_ELETRONICA_AUTOMATICO);
    Exit;
  End;

  // 5. SETUP — LogTimer e LLogTmr.Enter podem falhar (I/O em LOGTMR).
  //    Se falhar AQUI, libera o lock (EXE não chegou a assumi-lo) e re-raise.
  LLogTmr := nil;
  Try
    If (Assigned(VS_objTraceViewer)) Then
      VS_objTraceViewer.LogTimer('tmrCobrancaEletronicaAutomaticoTimer');

    LLogTmr := TLogTmr.New('tmrCobrancaEletronicaAutomaticoTimer')
                      .Enter(SP_DISPARO_COBRANCA_ELETRONICA_AUTOMATICO);
  Except
    fLock_Unlock(SP_DISPARO_COBRANCA_ELETRONICA_AUTOMATICO,
                 False, False, False, EmptyStr, False);
    Raise;
  End;

  // 6. DISPATCH — daqui em diante o lock pertence ao EXE.
  //    Qualquer exceção pós-dispatch NÃO deve liberar o lock, ou geramos
  //    disparo duplicado se outra estação ganhar o lock liberado por engano.
  pMonitorEmailCobrançaEletronica;

  // 7. Best-effort fechar LOGTMR; se falhar, log fica sem LOG_FINTHR mas
  //    o lock já é do EXE — não tocar.
  Try
    LLogTmr.Exit;
  Except
    // Swallow: erro em LOGTMR.UPDATE não pode liberar o lock que o EXE assumiu
  End;
end;

procedure TfrmPrincipal.tmrCompromissosTimer(Sender: TObject);
var
  LLogTmr: ILogTmr;
begin
  If (Not fPodeExecutarFuncaoDoTimer) Or
     (blnGerImpPdv) Or (blnGerImpCTe) Or (fOpcoesIgnorar) Or blnHomologacao Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If Assigned(VS_objTraceViewer) Then
    VS_objTraceViewer.LogTimer('tmrCompromissosTimer');

  LLogTmr := TLogTmr.New('tmrCompromissosTimer').Enter('fExitemCompromissos');

  tmrCompromissos.Enabled := False;
  If fExitemCompromissos Then
  Begin
    //Se ja estiver visivel nao deve mostrar a mensagem novamente
    If Not pnlCompromissos.Visible Then
    Begin
      pnlCompromissos.Caption := 'Existem Compromissos Vencidos';
      pnlCompromissos.Visible := True;
      pnlCompromissos.Refresh;
      dxAlertWindow.Show('Autcom - Compromissos', pnlCompromissos.Caption);
    End;
  End
  Else
    pnlCompromissos.Visible := False;

  tmrCompromissos.Interval := RandomRange(TIMER_UM_MINUTO, TIMER_DEZ_MINUTOS);
  tmrCompromissos.Enabled := True;

  LLogTmr.Exit;
end;

procedure TfrmPrincipal.tmrConsultaPixOnTimer(Sender: TObject);
  Var
    LTempoRoboPix,
    LEmpresaCentralizada: String;
    LLogTmr: ILogTmr;
begin
  If untFuncoesSimples.RunningInTSPlus Then
  Begin
    tmrConsultaPix.Enabled := False;
    Exit;
  End;

  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  LLogTmr := TLogTmr.New('tmrConsultaPixOnTimer').Enter('TFuncoesPixAutcom.MonitorRecebimentosPix');

  If tmrConsultaPix.Interval = 30000 Then
  Begin
    LTempoRoboPix := fCfgSis('TEMPIX', varString);
    If LTempoRoboPix.IsEmpty Then
      LTempoRoboPix := '10';

    tmrConsultaPix.Interval := StrToInt(LTempoRoboPix) * 60000;
  End;

  If Not fCfgSis('USAPIX', varBoolean) Then
  Begin
    tmrConsultaPix.Enabled := False;
    LLogTmr.Exit('CFG_USAPIX = N');
    Exit;
  End;

  If Not FileExists(ExtractFilePath(Application.ExeName) + 'libIntegracaoPixCitel.dll') Then
  Begin
    tmrConsultaPix.Enabled := False;
    TFuncoesPixAutcom.GeraMensagemAoOperadorFaltaPix('libIntegracaoPixCitel.dll');
    LLogTmr.Exit('libIntegracaoPixCitel.dll not found');
    Exit;
  End;

  If Not FileExists(ExtractFilePath(Application.ExeName) + 'ConsultaPagamentosPixMonitor.exe') Then
  Begin
    tmrConsultaPix.Enabled := False;
    TFuncoesPixAutcom.GeraMensagemAoOperadorFaltaPix('ConsultaPagamentosPixMonitor.exe');
    LLogTmr.Exit('ConsultaPagamentosPixMonitor.exe not found');
    Exit;
  End;

  LEmpresaCentralizada := TPixDao.EmpresaCentralizadoraDasConsultasPix;
  If Not LEmpresaCentralizada.IsEmpty Then
  Begin
    If LEmpresaCentralizada <> fRetEmpresaFisica Then
    Begin
      tmrConsultaPix.Enabled := False;
      LLogTmr.Exit('LEmpresaCentralizada <> fRetEmpresaFisica');
      Exit;
    End;
  End;

  TFuncoesPixAutcom.FIntervaloExecucaoRobo := tmrConsultaPix.Interval;

  TFuncoesPixAutcom.MonitorRecebimentosPix;

  LLogTmr.Exit;
end;

procedure TfrmPrincipal.tmrDataSistemaTimer(Sender: TObject);
var
  LLogTmr: ILogTmr;
begin
  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If Assigned(VS_objTraceViewer) Then
    VS_objTraceViewer.LogTimer('tmrDataSistemaTimer');

  LLogTmr := TLogTmr.New('tmrDataSistemaTimer').Enter('fAjustaDataSistema');

  fAjustaDataSistema;

  LLogTmr.Exit;
end;

procedure TfrmPrincipal.tmrEmailBoletoAutomaticoOnTimer(Sender: TObject);
var
  LLogTmr: ILogTmr;
begin
  if (blnGerImpCTe) then
    Exit;

  If TfrmErroRede.fExibindoMensagemErroRede Then
    Exit;

  If TfrmConectando.fTentandoReconectarModulo Then
    Exit;

  If Not UtilizarRoboDeAvisoDeCobraca Then
    Exit;

  If (Not fVerificaAcessoSistema('frmImpBoletosIndiv')) Or
     (VS_ModelosAvisosEmailAtivado.Count +
      VS_ModelosAvisosSMSAtivado.Count +
      VS_ModelosAvisosWPPAtivado.Count = 0) Then
  Begin
    tmrEmailBoletoAutomatico.Enabled := False;
    Exit;
  End;

  If Not TEmailAutController.fExistemBoletosASeremEnviados Then
    Exit;

  If Assigned(VS_objTraceViewer) Then
    VS_objTraceViewer.LogTimer('tmrEmailBoletoAutomaticoTimer');

  LLogTmr := TLogTmr.New('tmrEmailBoletoAutomaticoTimer').Enter('ENVIO_EMAIL_BOLETO_AUTOMATICO');

  If Not fLock_Unlock('ENVIO_EMAIL_BOLETO_AUTOMATICO',
                      True,
                      False,
                      False,
                      '',
                      False) Then
  Begin
    if fGetTempoDuracaoLock('ENVIO_EMAIL_BOLETO_AUTOMATICO') > StrToTime('02:00:00') Then
      fLock_Unlock('ENVIO_EMAIL_BOLETO_AUTOMATICO',
                   False,
                   False,
                   False,
                   '',
                   False,
                   'ENVIO_EMAIL_BOLETO_AUTOMATICO')
    Else
    Begin
      LLogTmr.Exit('Saiu sem executar pMonitorEmail');
      Exit;
    End;
  End;

  pMonitorEmail;

  LLogTmr.Exit;
end;

procedure TfrmPrincipal.tmrEntregaDivergenteOnTimer(Sender: TObject);
Var
  qryRas    : TUniQuery;
  Distancia : Double;
  LLogTmr   : ILogTmr;
begin
  // 0. Pre-emptive: desabilita timer ANTES de qualquer outra coisa para
  //    evitar re-entrância via WM_TIMER enfileirado durante o processamento.
  tmrEntregaDivergente.Enabled := False;
  Try
    // 1. Gates em memória primeiro (custo zero)
    If TfrmErroRede.fExibindoMensagemErroRede Then Exit;
    If TfrmConectando.fTentandoReconectarModulo Then Exit;

    // 2. Lock distribuído ANTES de qualquer SELECT.
    //    99 estações saem aqui sem tocar em RASROM/ROMGERX.
    If Not fLock_Unlock(SP_ALERTA_ENTREGA_DIVERGENTE,
                        True, False, False, EmptyStr, False) Then
    Begin
      // Tratamento de lock órfão (ex: estação derrubou no meio do processamento)
      if fGetTempoDuracaoLock(SP_ALERTA_ENTREGA_DIVERGENTE) > StrToTime('00:10:00') Then
        fLock_Unlock(SP_ALERTA_ENTREGA_DIVERGENTE,
                     False, False, False, EmptyStr, False,
                     SP_ALERTA_ENTREGA_DIVERGENTE);
      Exit;
    End;

    // 3. Só a estação vencedora chega aqui.
    Try
      If (Assigned(VS_objTraceViewer)) Then
        VS_objTraceViewer.LogTimer('tmrEntregaDivergenteOnTimer');

      LLogTmr := TLogTmr.New('tmrEntregaDivergenteOnTimer').Enter(SP_ALERTA_ENTREGA_DIVERGENTE);
      Try
        qryRas := fCriaQuery(Nil);
        Try
          qryRas.SQL.Clear;
          qryRas.SQL.Add(' SELECT                                           ');
          qryRas.SQL.Add('   RASROM.AUTOINCREM,                             ');
          qryRas.SQL.Add('   GER_NUMROM,                                    ');
          qryRas.SQL.Add('   CONCAT(GER_NUMDOC, "-", GER_ESPDOC) AS NUMDOC, ');
          qryRas.SQL.Add('   GER_LATLON,                                    ');
          qryRas.SQL.Add('   RAS_LATLON                                     ');
          qryRas.SQL.Add(' FROM                                             ');
          qryRas.SQL.Add('   RASROM                                         ');
          qryRas.SQL.Add('   INNER JOIN ROMGERX ON GER_NUMROM = RAS_NUMROM  ');
          qryRas.SQL.Add('                     AND GER_DTACHE = DATE(RAS_DTAHOR) ');
          qryRas.SQL.Add('                     AND TIME(RAS_DTAHOR) BETWEEN TIMESTAMPADD(SECOND, -30, GER_HORCHE) AND TIMESTAMPADD(SECOND, 30, GER_HORCHE) ');
          qryRas.SQL.Add(' WHERE RAS_TIPRAS = "C"                           ');
          qryRas.SQL.Add('   AND RAS_VERPOP = "S"                           ');
          qryRas.Open;

          qryRas.First;
          While Not qryRas.Eof Do
          Begin
            If Not (qryRas.FieldByName('GER_LATLON').AsString.IsEmpty Or
                    qryRas.FieldByName('RAS_LATLON').AsString.IsEmpty) Then
            Begin
              Distancia := fDistanciaEntreCoordenadas(qryRas.FieldByName('GER_LATLON').AsString,
                                                      qryRas.FieldByName('RAS_LATLON').AsString);

              If (Distancia > 50) Then
              Begin
                dxAlertWindow.OptionsButtons.Buttons[5].Hint := 'Abrir Romaneio ' +
                  qryRas.FieldByName('GER_NUMROM').AsString + ' no Painel de Entregas';
                dxAlertWindow.OptionsButtons.Buttons[5].Visible := True;
                dxAlertWindow.Show('Divergência na entrega',
                                   'Romaneio : ' + qryRas.FieldByName('GER_NUMROM').AsString + #13 +
                                   'Documento: ' + qryRas.FieldByName('NUMDOC').AsString);
                dxAlertWindow.OptionsButtons.Buttons[5].Visible := False;
              End;
            End;

            pAtualizaEntregaVerificada(qryRas.FieldByName('AUTOINCREM').AsString);
            qryRas.Next;
          End;

          qryRas.Close;
        Finally
          FreeAndNil(qryRas);
        End;
      Finally
        // LLogTmr.Exit pareado com Enter — só executa se Enter rodou.
        If Assigned(LLogTmr) Then
          LLogTmr.Exit;
      End;
    Finally
      // 4. Libera lock SEMPRE
      fLock_Unlock(SP_ALERTA_ENTREGA_DIVERGENTE,
                   False, False, False, EmptyStr, False);
    End;
  Finally
    // 5. Reabilita timer SEMPRE (mesmo em exceção nos gates iniciais)
    tmrEntregaDivergente.Enabled := True;
  End;
end;

procedure TfrmPrincipal.tmrImpFranqOnTimer(Sender: TObject);
  Var
    intQtdRegFor, intQtdRegPro: Integer;
    LLogTmr: ILogTmr;
begin
  if (blnGerImpCTe) then
    Exit;

  If (Not fPodeExecutarFuncaoDoTimer) Or (fOpcoesIgnorar) Or (Not Assigned(VS_trayIconAutcom)) Or (Not VS_trayIconAutcom.Visible) Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If Assigned(VS_objTraceViewer) Then
    VS_objTraceViewer.LogTimer('tmrImpFranqTimer');

  LLogTmr := TLogTmr.New('tmrImpFranqTimer').Enter('Importação Franqueadora');

  Try
    tmrImpFranq.Enabled := False;

    intQtdRegFor := fCampoTabela('COUNT(*)', 'IMP_FORNECEDOR', ['IFNULL(IMP_DTAIMP, 0)'], [0]);
    intQtdRegPro := fCampoTabela('COUNT(*)', 'IMP_PRODUTO', ['IFNULL(IMP_DTAIMP, 0)'], [0]);

    If (intQtdRegFor > 0) Or (intQtdRegPro > 0) Then Begin
      VS_trayIconAutcom.BalloonTimeout := 20000;
      VS_trayIconAutcom.BalloonTitle   := 'Importação Franqueadora';
      VS_trayIconAutcom.BalloonHint    := 'Existem ' + IntToStr(intQtdRegFor + intQtdRegPro) +
        ' novo(s) registro(s) para ser(em) importado(s)!';
      VS_trayIconAutcom.ShowBalloonHint();
    End;
  Finally
    tmrImpFranq.Enabled := True;
  End;

  LLogTmr.Exit;
end;

procedure TfrmPrincipal.tmrImportaCTesOnTimer(Sender: TObject);
var
  strNomeTrava: string;
  LLogTmr: ILogTmr;
begin
  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If TfrmErroRede.fExibindoMensagemErroRede Then
    Exit;

  If TfrmConectando.fTentandoReconectarModulo Then
    Exit;

  If (fOpcoesIgnorar) or (blnGerImpPdv) Then
    Exit;

  LLogTmr := TLogTmr.New('tmrImportaCTesOnTimer').Enter('pExecutaImportadorCTe');

  strNomeTrava := 'IMPORTAR_CTE_' + VS_strCodEmp;
  tmrImportaCTes.Enabled := False;

  Try
    if not fTravaBancoAtiva(strNomeTrava) then
      fGetLock(strNomeTrava);

    pTestaInatividadeCTe;
    pExecutaImportadorCTe;

    If fGetTentativasLock(strNomeTrava) > 30 Then
    Begin
      pDestravaLockForcado(strNomeTrava, 30)
    End;
  Finally
    tmrImportaCTes.Enabled := True;
  End;

  LLogTmr.Exit;
end;

procedure TfrmPrincipal.tmrIniciaImportacaoPAFOnTimer(Sender: TObject);
var
  LLogTmr: ILogTmr;
begin
  If TfrmErroRede.fExibindoMensagemErroRede Then
    Exit;

  If TfrmConectando.fTentandoReconectarModulo Then
    Exit;

  If (fOpcoesIgnorar) or (blnGerImpCTe) Then
    Exit;

  If Assigned(VS_objTraceViewer) Then
    VS_objTraceViewer.LogTimer('tmrIniciaImportacaoPAFTimer');

  LLogTmr := TLogTmr.New('tmrIniciaImportacaoPAFTimer').Enter('pExecutaImportadorPAF');

  tmrIniciaImportacaoPAF.Enabled := False;
  Try
    pTestaInatividade;
    pExecutaImportadorPAF;

    If fGetTentativasLock('IMPORTACAO_PAF_' + VS_strCodEmp, False) > 15 Then
    Begin
      pDestravaLockForcado('IMPORTACAO_PAF_' + VS_strCodEmp, 15)
    End;
  Finally
    tmrIniciaImportacaoPAF.Interval := RandomRange(TIMER_UM_MINUTO, TIMER_DEZ_MINUTOS);
    tmrIniciaImportacaoPAF.Enabled := True;
  End;

  LLogTmr.Exit;
end;

procedure TfrmPrincipal.tmrLotWmsTimer(Sender: TObject);
var
  LLogTmr: ILogTmr;
begin
  If Not fPodeExecutarFuncaoDoTimer Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If Not VS_blnEmpLogadaPertenceBaseEmpFisica Then
    Exit;

  If fOpcoesIgnorar Then
    Exit;

  If blnGerImpPdv Then
    Exit;

  If blnHomologacao Then
    Exit;

  If fEmptyStr(VS_strCodEmp) Then
    Exit;

  If Assigned(VS_objTraceViewer) Then
    VS_objTraceViewer.LogTimer('tmrLotWmsTimer');

  LLogTmr := TLogTmr.New('tmrLotWmsTimer').Enter('pMonitorLotesWMS');

  tmrLotWms.Enabled := False;
  Try
    pMonitorLotesWMS;
  Finally
    tmrLotWms.Enabled := True;
  End;

  LLogTmr.Exit;
end;

procedure TfrmPrincipal.btnFaturamentoClick(Sender: TObject);
  Var
    Posicao: TPoint;
begin
  GetCursorPos(Posicao);
  popFaturamento.Popup(Posicao.X + 40,Posicao.Y);
  Windows.setFocus(0);
end;

procedure TfrmPrincipal.pGeraPopUpFaturamento;
  Const
    STR_MENUS_FATURAMENTO = 'mnuFatOrcamento_mnuFatOrcamentoVendaRapida_mnuFatPedido_mnuFatPedidoVendaRapida_'+
                            'mnuFatVendaNormal_mnuFatVendaNormalVendaRapida_mnuFatExpedicao_mnuFatExpedicaoBaiSep_mnuFatExpedicaoConferenciaRetiraCaixa_'+
                            'mnuFatRetiraDigSeparador_' +
                            'mnuFatBrinde_mnuFatVendasAS_mnuFatVendaServico_mnuFatAcompEntrega_' +
                            'mnuConsultaServicosAutocenter_mnuFatExpServicos_mnuAgendamentosProg_mnuFatDesmembrarPedido';

  Var
    intContador: Integer;
    mnuAux: TMenuItem;
Begin
  If mnuEmisFaturamento.Visible And fVerificaAcessoSistema(mnuEmisFaturamento.Hint) Then
    For intContador := 0 To mnuEmisFaturamento.Count -1 Do
      If Pos(mnuEmisFaturamento.Items[intContador].Name, STR_MENUS_FATURAMENTO) > 0 Then
        pGeraPopUp(Self, mnuEmisFaturamento.Items[intContador], popFaturamento.Items);

  pGeraPopUp(Self, mnuFatConfPedidos, popFaturamento.Items);

  If fCfgSis('CONEQU') = 'S' Then
    pGeraPopUp(Self, mnuFatManConsertoEquip, popFaturamento.Items);

  pGeraPopUp(Self, mnuFatConsEntPendentes, popFaturamento.Items);

  mnuAux := TMenuItem.Create(nil);
  try
    mnuAux.Hint    := 'frmRelFatMetasVendedor';
    mnuAux.Caption := 'Metas por Vendedor/Representante - Faturamento';
    mnuAux.OnClick := pRelFatMetasVendedorPopup;
    mnuAux.Name    := 'mnuRelFatMetasVendedor';
    pGeraPopUp(Self, mnuAux, popFaturamento.Items);
  finally
    FreeAndNil(mnuAux);
  end;

  pGeraPopUp(Self, mnuRomaneio, popFaturamento.Items);
End;

procedure TfrmPrincipal.pGeraPopUpFinanceiro;
begin
  pGeraPopUp(Self, mnuFinanceiro, popFinanceiro.Items);
end;

procedure TfrmPrincipal.pGeraPopUpLocacaoEquipamento;
Begin
  pGeraPopUp(Self, mnuLocacaoEquip, popLocacaoEquipamento.Items);
End;

procedure TfrmPrincipal.pGeraPopUpMovimentacaoItens;
begin
  pGeraPopUp(Self, mnuMovItens, popMovItens.Items);
end;

procedure TfrmPrincipal.pGeraPopUpTintasMaquinas(AOwner: TComponent; Menu: TMenuItem; popMenu: TMenuItem;
  strEsconder: String = ''; blnMenuPath: Boolean = False; blnSomenteRaiz: Boolean = True);
Var
  intContador: Integer;
  mnuNovo: TMenuItem;
  blnTemDireito: Boolean;
begin
  blnTemDireito := fVerificaAcessoSistema(Menu.Hint);

  If Menu.Hint = 'mnuGlasurit' Then
    blnTemDireito := fVerificaAcessoSistema(Menu.Hint);

  If Not blnTemDireito Then
  Begin
    blnTemDireito := fVerificaAcessoAutTin(Menu.Hint, Menu.Name);

    If blnTemDireito Then
      blnTemDireito := fTintaDisponivel(Menu.Hint, iTintasMaquina);
  End;

  If (Not Menu.Visible) Then
    Exit;

  If blnTemDireito Then
  Begin
    If (Menu.Count > 0) And (Not blnSomenteRaiz) Then
    Begin
      mnuNovo := TMenuItem.Create(AOwner);

      If blnMenuPath Then
        mnuNovo.Caption := fGetMenuPath(Menu)
      Else
        mnuNovo.Caption := Menu.Caption;

      mnuNovo.Hint    := Menu.Hint;
      mnuNovo.Tag     := Menu.Tag;
      mnuNovo.Name    := Menu.Name + '_PopUp_' + fInc(VS_intPopUpId).ToString;
      mnuNovo.OnClick := Menu.OnClick;
      popMenu.Add(mnuNovo);
      For intContador := 0 To Menu.Count -1 Do
      Begin
        pGeraPopUpTintasMaquinas(AOwner, Menu.Items[intContador], mnuNovo, strEsconder, blnMenuPath, blnSomenteRaiz);
      End;
    End
    Else
    Begin

      If (Not fEmptyStr(strEsconder)) Then
      Begin
        If (Pos(Menu.Name, strEsconder) > 0) Then
          Exit;
      End;

      mnuNovo := TMenuItem.Create(AOwner);

      If blnMenuPath Then
        mnuNovo.Caption := fGetMenuPath(Menu)
      Else
        mnuNovo.Caption := Menu.Caption;

      mnuNovo.Hint    := Menu.Hint;
      mnuNovo.Tag     := Menu.Tag;
      mnuNovo.Name    := Menu.Name + '_PopUp_' + fInc(VS_intPopUpId).ToString;
      mnuNovo.OnClick := Menu.OnClick;
      popMenu.Add(mnuNovo);
    End;
  End;
end;

procedure TfrmPrincipal.pGeraPopUpWMSRelatorios(mnuSubGrupo, mnuReferencia: TMenuItem; popUp: TAdvPopupMenu; strMenusAdd: String);
Var
  i : Integer;
begin
  For i := 0 To mnuReferencia.Count -1 Do
  Begin
    If (mnuReferencia.Items[i].Count > 0) Then
      pGeraPopUpWMSRelatorios(mnuSubGrupo, mnuReferencia.Items[i], popUp, strMenusAdd)
    Else
      If Pos(UpperCase(fRemoveAcento(mnuReferencia.Items[i].Caption)), strMenusAdd) > 0 Then
        pGeraPopUp(Self, mnuReferencia.Items[i], mnuSubGrupo);
  End;
end;

procedure TfrmPrincipal.pGeraPopUpWMS;
Const
  STR_MENUS_CADASTROS = 'mnuCadLoteItens_mnuDadosCadLoteWMS_mnuMapeamentoItemClasseLocFis_'+
                        'mnuMapeamentoItemLocalizacaoFisica_mnuCadClasseLocFis_mnuCadLocalArmazenamentoWMS_'+
                        'mnuCadLocalizacaoSeparacao_mnuCadLocFisica_mnuCadDocas_mnuCadBoxWms_'+
                        'mnuCadLoteItensRapido_mnuMapeamentoLocalizacaoFisica_';

  STR_MENUS_MOVITENS = 'mnuManutencaoDocas_mnuCadAgendamentodeEntrega_mnuRecebimentoEntregaAgendada_'+
                       'mnuPlanoDeRecebimento_mnuMovimentacaoProgramadaManual_mnuPainelRessuprimentos_'+
                       'mnuTransfLocFisGlobalWMS_mnuEntConferPreNotaWMSDevolucao_mnuMovimentacaoProgramadaManual_';

  STR_MENUS_BALANCO = 'mnuBalancoEstoqueZera_mnuBalancoEstoqueImportar_mnuBalancoEstoqueDigManual_'+
                      'mnuBalancoEstoqueDigColetivo_mnuBalancoIniciaArmazem_mnuBalancoFinalizaArmazem_'+
                      'mnuMapaDeInventarioParaColetores_';

  STR_MENUS_RELATORIOS = 'CADASTRO DE LOCALIZACAO FISICA_'+
                         'LOCAL DE ARMAZENAMENTO - WMS_'+
                         'LOCALIZACAO FISICA_'+
                         'LOTE DO PRODUTO_'+
                         'LOG DE ALTERACAO - LOCALIZACAO FISICA_'+
                         'MOVIMENTACAO PROGRAMADA EM ABERTO_'+
                         'PONTO DE REPOSICAO POR ARMAZEM_';

Var
  mnuSubMenu : TMenuItem;
Begin
  {*******************************************}
  {* Cria e preenche Menu BALANÇO DE ESTOQUE *}
  {*******************************************}
  mnuSubMenu := fCriaNovoSubMenuPopUp(mnuBalancoEstoque, popWMS);
  pGeraSubGrupoPopUpWMS(mnuSubMenu, mnuBalancoEstoque, popWMS, STR_MENUS_BALANCO);

  {**********************************}
  {* Cria e preenche Menu ETIQUETAS *}
  {**********************************}
  mnuSubMenu := fCriaNovoSubMenuPopUp(mnuConfiguracoesEtiquetas, popWMS);
  pGeraPopUp(Self, mnuEtiquetasPlanoRecebimento, mnuSubMenu);
  pGeraPopUp(Self, mnuEtiquetasSeqSeparacaoWMS, mnuSubMenu);
  pGeraPopUp(Self, mnuEtiquetasLocalArmazenamentoWMS, mnuSubMenu);

  {************************************}
  {* Cria e preenche Menu FATURAMENTO *}
  {************************************}
  mnuSubMenu := fCriaNovoSubMenuPopUp(mnuFaturamento, popWMS);
  pGeraPopUp(Self, mnuLiberacaoLocalizacaoFisicaColetor, mnuSubMenu);

  {**********************************}
  {* Cria e preenche Menu CADASTROS *}
  {**********************************}
  mnuSubMenu := fCriaNovoSubMenuPopUp(mnuManCadastros, popWMS);
  pGeraSubGrupoPopUpWMS(mnuSubMenu, mnuProdutos, popWMS, STR_MENUS_CADASTROS);
  pGeraSubGrupoPopUpWMS(mnuSubMenu, mnuCadAuxiliares, popWMS, STR_MENUS_CADASTROS);

  {**********************************************}
  {* Cria e preenche Menu MOVIMENTAÇÃO DE ITENS *}
  {**********************************************}
  mnuSubMenu := fCriaNovoSubMenuPopUp(mnuMovItens, popWMS);
  pGeraSubGrupoPopUpWMS(mnuSubMenu, mnuMovItens, popWMS, STR_MENUS_MOVITENS);

  {***********************************}
  {* Cria e preenche Menu RELATÓRIOS *}
  {***********************************}
  mnuSubMenu := fCriaNovoSubMenuPopUp(mnuRelatorio, popWMS);
  pGeraPopUpWMSRelatorios(mnuSubMenu, mnuRelCadastros, popWMS, STR_MENUS_RELATORIOS);
  pGeraPopUpWMSRelatorios(mnuSubMenu, mnuRelEstoque, popWMS, STR_MENUS_RELATORIOS);
end;

procedure TfrmPrincipal.pTourAbrirMenu(mnuItemAlvo: TMenuItem; blnAbrirAlvo: Boolean = True; intIntervaloNavegacao: Cardinal = 15);
  Var
    lstPassos: TList<Word>;
    arrTeclas: TArray<Word>;
    lstCaminho: TList<TMenuItem>;
    ItemAtual: TMenuItem;
    LMenu: TMenu;
    blnPopup: Boolean;
    intInd, intPos: Integer;
    LPonto: TPoint;
    LControle: TControl;
    intCon: Integer;

    function fPosicaoNavegavel(Item: TMenuItem): Integer;
      Var
        intInd, intCon: Integer;
        LMnuPai: TMenuItem;
    Begin
      Result := -1;
      LMnuPai := Item.Parent;
      If LMnuPai = Nil Then
        Exit;

      intCon := 0;
      For intInd := 0 To LMnuPai.Count - 1 Do
      Begin
        If Not LMnuPai.Items[intInd].Visible Then
          Continue;
        If LMnuPai.Items[intInd].Caption = '-' Then
          Continue;

        If LMnuPai.Items[intInd] = Item Then
        Begin
          Result := intCon;
          Exit;
        End;
        Inc(intCon);
      End;
    End;

Begin
  If mnuItemAlvo = Nil Then
    Exit;

  LMenu := mnuItemAlvo.GetParentMenu;
  If LMenu = Nil Then
    Exit;

  blnPopup := LMenu Is TPopupMenu;

  lstCaminho := TList<TMenuItem>.Create;
  lstPassos  := TList<Word>.Create;
  Try
    // 1. Sobe a árvore juntando o caminho do raiz até o alvo
    ItemAtual := mnuItemAlvo;
    While ItemAtual <> Nil Do
    Begin
      lstCaminho.Insert(0, ItemAtual);
      ItemAtual := ItemAtual.Parent;
    End;

    // 2. Monta sequência de teclas
    If blnPopup Then
    Begin
      For intInd := 1 To lstCaminho.Count - 1 Do
      Begin
        intPos := fPosicaoNavegavel(lstCaminho[intInd]);
        If intPos < 0 Then
          Continue;

        // Popup começa SEM seleção: precisa de intPos+1 DOWNs no primeiro nível
        // Submenus já abrem com o 1º item selecionado: precisam só de intPos DOWNs
        If intInd = 1 Then
        Begin
          For intCon := 0 To intPos Do
            lstPassos.Add(VK_DOWN);
        End
        Else
        Begin
          For intCon := 0 To intPos - 1 Do
            lstPassos.Add(VK_DOWN);
        End;

        If intInd < lstCaminho.Count - 1 Then
          lstPassos.Add(VK_RIGHT);
      End;

      If blnAbrirAlvo Then
        lstPassos.Add(VK_RETURN)
    End
    Else
    Begin
      // TMainMenu: nível raiz navega com VK_RIGHT, subníveis com VK_DOWN.
      // lstCaminho[1] é o item de LMenu raiz visível (ex: "Cadastros")
      // lstCaminho[0] é o "Items" interno do TMainMenu (não conta).
      If lstCaminho.Count < 2 Then
        Exit;

      intPos := fPosicaoNavegavel(lstCaminho[1]);
      For intCon := 0 To intPos - 1 Do
        lstPassos.Add(VK_RIGHT);

      // Abre o primeiro submenu
      lstPassos.Add(VK_DOWN);

      // Desce pelos demais níveis
      For intInd := 2 To lstCaminho.Count - 1 Do
      Begin
        intPos := fPosicaoNavegavel(lstCaminho[intInd]);
        For intCon := 0 To intPos - 1 Do
          lstPassos.Add(VK_DOWN);

        If intInd < lstCaminho.Count - 1 Then
          lstPassos.Add(VK_RIGHT);
      End;

      If blnAbrirAlvo Then
        lstPassos.Add(VK_RETURN)
    End;

    arrTeclas := lstPassos.ToArray;

    // 3. Dispara a thread auxiliar (vai começar a postar teclas em XXXms)
    TTourMenuThread.Create(arrTeclas, intIntervaloNavegacao);

    // 4. Garante que o MainForm está visível e focado (vale para popup e mainmenu)
    If Assigned(Application.MainForm) Then
    Begin
      Application.MainForm.BringToFront;
      pSetFocus(Application.MainForm);
    End;

    // 5. Abre o LMenu na thread principal (bloqueia até fechar)
    If blnPopup Then
    Begin
      // Calcula LPonto: prioriza PopupComponent, depois ActiveControl, depois centro do MainForm
      LControle := Nil;
      If TPopupMenu(LMenu).PopupComponent Is TControl Then
        LControle := TControl(TPopupMenu(LMenu).PopupComponent)
      Else If Screen.ActiveControl <> Nil Then
        LControle := Screen.ActiveControl;

      If Assigned(LControle) And LControle.Visible And (LControle.Width > 0) Then
      Begin
        LPonto.X := LControle.Width  Div 2;
        LPonto.Y := LControle.Height Div 2;
        LPonto   := LControle.ClientToScreen(LPonto);
      End
      Else
      Begin
        If Not Assigned(Application.MainForm) Then
          Exit;
        // Fallback: centro do MainForm (nunca cai no Mouse.CursorPos)
        LPonto.X := Application.MainForm.Left + (Application.MainForm.Width  Div 2);
        LPonto.Y := Application.MainForm.Top  + (Application.MainForm.Height Div 2);
      End;

      TPopupMenu(LMenu).Popup(LPonto.X, LPonto.Y);
    End
    Else
    Begin
      //Aciona o MainMenu com Alt
      pKeybd_Event(VK_MENU);
    End;
  Finally
    lstCaminho.Free;
    lstPassos.Free;
  End;
End;

function TfrmPrincipal.fAchaItemPopUpPorNomeOriginal(PopUp: TPopupMenu; strNomeOriginal: String): TMenuItem;

  function fBuscaRecursiva(Pai: TMenuItem): TMenuItem;
    Var
      intIdx,
      intPos: Integer;
      strNomeItem,
      strNomeBase: String;
  Begin
    Result := Nil;
    If Pai = Nil Then
      Exit;

    For intIdx := 0 To Pai.Count - 1 Do
    Begin
      strNomeItem := Pai.Items[intIdx].Name;
      intPos      := Pos('_PopUp_', strNomeItem);

      If intPos > 0 Then
        strNomeBase := LeftStr(strNomeItem, intPos - 1)
      Else
        strNomeBase := strNomeItem;

      If SameText(strNomeBase, strNomeOriginal) Then
      Begin
        Result := Pai.Items[intIdx];
        Exit;
      End;

      Result := fBuscaRecursiva(Pai.Items[intIdx]);
      If Result <> Nil Then
        Exit;
    End;
  End;

Begin
  Result := Nil;
  If PopUp = Nil Then
    Exit;
  Result := fBuscaRecursiva(PopUp.Items);
End;

procedure TfrmPrincipal.pGerarPopupRecentesFavoritos;
begin
  fraPesquisarMenu.pGeraPopUpRecentes;
  fraPesquisarMenu.pGeraPopUpFavoritos;

  {$IFDEF TESTABILIDADE_AUTCOM}
  //não chama a tela nova
  {$Else}
  If Not blnUsuarioLogadoUtilizaModoClassico Then
    Principal.View.FMXPrincipal.AtualizarNovaTelaPrincipalAutcom(False);
  {$ENDIF}
end;

procedure TfrmPrincipal.pGeraSubGrupoPopUpWMS(mnuSubMenu, mnuReferencia: TMenuItem; popUp: TAdvPopupMenu; strMenusAdd: String);
Var
  intContador: Integer;
begin
  If mnuReferencia.Visible And fVerificaAcessoSistema(mnuReferencia.Hint) Then
    For intContador := 0 To mnuReferencia.Count -1 Do
      If Pos(UpperCase(mnuReferencia.Items[intContador].Name) + '_', UpperCase(strMenusAdd)) > 0 Then
        pGeraPopUp(Self, mnuReferencia.Items[intContador], mnuSubMenu);
end;

procedure TfrmPrincipal.pGeraPopUpDASSuvinil;
  Var
    i: Integer;
Begin
  For i := 0 To mnuDASSuvinil.Count -1 Do
    pGeraPopUp(Self, mnuDASSuvinil.Items[i], popDASSuvinil.Items);
End;

procedure TfrmPrincipal.mnuReimpressaoDocs2Click(Sender: TObject);
  Var
    blnValorOriVerificaTef: Boolean;
    frmReimpressaoDocs: TfrmReimpressaoDocs;
begin
  blnValorOriVerificaTef := blnVerificaTef;
  blnVerificaTef := True;
  Try
    Try
      pCriarFormularios(TfrmReimpressaoDocs,frmReimpressaoDocs);
    Except
      On E: Exception do
      Begin
        pMensagensErro(E.Message, '[mnuReimpressaoDocs2Click_1]');
        Exit;
      End;
    End;

    Try
      frmReimpressaoDocs.blnFaturamento := True;
      frmReimpressaoDocs.ShowModal;
    Except
      On E: Exception do
      Begin
        pMensagensErro(E.Message, '[mnuReimpressaoDocs2Click_2]');
      End;
    End;

    pFreeAndNil(frmReimpressaoDocs);
  Finally
    blnVerificaTef := blnValorOriVerificaTef;
  End;
end;

procedure TfrmPrincipal.mnuReimpressaoGarantiaGRClick(Sender: TObject);
Var
   NomeForm : TForm;
begin
  Try
    pCriarFormularios(TfrmReimpressaoDocs,NomeForm);
    TfrmReimpressaoDocs(NomeForm).pSetReimpressaoDocGarantia(TReimpressaoDocGarantia.trRetornoFornecedor);
    try
      NomeForm.ShowModal;
    finally
      pFreeAndNil(NomeForm);
    end;
  Except
    On E: Exception do
      pErro(E.Message);
  End;
end;

procedure TfrmPrincipal.mnuReinfClick(Sender: TObject);
begin
  pReinfParam(IntegracaoReinf);
end;

procedure TfrmPrincipal.mnuReiniciarRoboImportacaoCTeClick(Sender: TObject);
begin
  If fMensagem('', 'Confirma reiniciar o robô de importação de CTes?',
    ['&Sim', '&Não'], 2) = 1 Then
  Begin
    pDestravaLockForcado('IMPORTAR_CTE_' + VS_strCodEmp, 0);
    pMensagemOk('Em instantes um novo robô de importação será iniciado.');
  End;
end;

procedure TfrmPrincipal.mnuReiniciarRoboImportacaoPDVClick(Sender: TObject);
begin
  If fMensagem('', 'Confirma reiniciar o robô de importação do PDVCitel?',
    ['&Sim', '&Não'], 2) = 1 Then
  Begin
    pDestravaLockForcado('IMPORTACAO_PAF_' + VS_strCodEmp, 0);
    pMensagemOk('Em instantes um novo robô de importação será iniciado.');
  End;
end;

procedure TfrmPrincipal.mnuRelFatListVenRepClick(Sender: TObject);
begin
  Try
    pCriarFormularios(TfrmRelFatListVenRep, frmRelFatListVenRep);
    frmRelFatListVenRep.fGravaFatGor := untFatGor.fGravaFatGor;
    frmRelFatListVenRep.fGravaFatDor := untFatGor.fGravaFatDor;
    frmRelFatListVenRep.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pRelFatListVenRep]');
    End;
  End;
  pFreeAndNil(frmRelFatListVenRep);
end;

procedure TfrmPrincipal.mnuCadEventosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEventos);
end;

procedure TfrmPrincipal.mnuRelFatComVendedorClick(Sender: TObject);
begin
  // pRelatorioFaturamento(relFatComVendedor);
  pCriarForm(TfrmRelFatComVendedor);
end;

procedure TfrmPrincipal.mnuRelCtrCartaCobClick(Sender: TObject);
  Var
    LRelCartaCob : TfrmRelCartaCob;
begin
  Try
    pCriarFormularios(TfrmRelCartaCob, LRelCartaCob);
    LRelCartaCob.ShowModal;
  Finally
    pFreeAndNil(LRelCartaCob);
  End;
end;

procedure TfrmPrincipal.mnuRelCtrCartaProtestoClick(Sender: TObject);
begin
  pCriarForm(TfrmRelCtrCartaProtesto);
end;

procedure TfrmPrincipal.mnuCartaAnuenciaClick(Sender: TObject);
  Var
    LfrmCartaAnuencia : TfrmCartaAnuencia;
begin
  Try
    pCriarFormularios(TfrmCartaAnuencia, LfrmCartaAnuencia);
    LfrmCartaAnuencia.ShowModal;
  Finally
    pFreeAndNil(LfrmCartaAnuencia);
  End;
end;

procedure TfrmPrincipal.mnuCashbackClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCashback);
end;

procedure TfrmPrincipal.mnuCategoriaOrcamentoPedidoClick(Sender: TObject);
begin
  pCriarForm(TfrmCategoriaOrcamentoPedido);
end;

procedure TfrmPrincipal.mnuCfgCompCustoClick(Sender: TObject);
begin
  pCriarForm(TfrmCfgCompCusto);
end;

procedure TfrmPrincipal.mnuCfgEfdSpedContribuicaoClick(Sender: TObject);
begin
  pCriarForm(TfrmCfgEfdSpedContribuicao);
end;

procedure TfrmPrincipal.mnuRelCtrCartaDesClick(Sender: TObject);
begin
  pCriarForm(TfrmRelCtrCartaDes);
end;

procedure TfrmPrincipal.mnuRelCtrCartaNotifExtrajudicialClick(Sender: TObject);
begin
  pCriarForm(TfrmRelCtrCartaExtrajudicial);
end;

procedure TfrmPrincipal.pnlBaixoClick(Sender: TObject);
begin
  fraPesquisarMenu.pLimparPesquisa;
end;

procedure TfrmPrincipal.pnlBaixoEnter(Sender: TObject);
begin
  fraPesquisarMenu.pLimparPesquisa;
end;

procedure TfrmPrincipal.pnlCompromissosClick(Sender: TObject);
Var
  Key: Char;
  frmCompromissos: TfrmCompromissos;
begin
  Try
    Key := #13;
    Try
      pCriarFormularios(TfrmCompromissos, frmCompromissos);
      frmCompromissos.edtCodOpe.Text := strLoginUsuarioLogado;
      frmCompromissos.edtCodOpeKeyPress(frmCompromissos.edtCodOpe, Key);
      frmCompromissos.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
        Exit;
      End;
    End;
  Finally
    pFreeAndNil(frmCompromissos);
  End;
end;

procedure TfrmPrincipal.pnlEsquerdaClick(Sender: TObject);
begin
  fraPesquisarMenu.pLimparPesquisa;
end;

procedure TfrmPrincipal.pnlEsquerdaEnter(Sender: TObject);
begin
  fraPesquisarMenu.pLimparPesquisa;
end;

procedure TfrmPrincipal.pnlLiberaClick(Sender: TObject);
  Var
    frmMsg: TfrmCadMsg;
begin
  If frmModulo.GetCurrentConnection.InTransaction Or blnCadMsgAberto Then
    Exit;

  Try
    pCriarFormularios(TfrmCadMsg, frmMsg);
    try
      frmMsg.tmrTemMsg   := tmrTemMsg;
      frmMsg.Tag         := 1;
      frmMsg.ShowModal;
    finally
      pFreeAndNil(frmMsg);
    end;
  Except
    On E: EInvalidOperation Do
    Begin
      Exit; //Control '' has no parent window.
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[Criar Formulário de Mensagens]');
      Exit;
    End;
  End;

  If Assigned(tmrTemMsg)Then
    tmrTemMsg.Enabled := True;
end;

procedure TfrmPrincipal.pnlLiberaPedComClick(Sender: TObject);
  Var
    frmPedidoCompraLiberacao: TfrmPedidoCompraLiberacao;
begin
  pCriarFormularios(TfrmPedidoCompraLiberacao, frmPedidoCompraLiberacao);
  Try
    frmPedidoCompraLiberacao.pImprimePedidoCompra := untInicializaDllPedido.pImprimePedidoCompraAutCom;
    frmPedidoCompraLiberacao.blnPnlLiberaPedCom := True;
    frmPedidoCompraLiberacao.Showmodal;
  Finally
    FreeAndNil(frmPedidoCompraLiberacao);
  End;
  pnlLiberaPedCom.Visible := False;
end;

procedure TfrmPrincipal.pnlRodapeClick(Sender: TObject);
begin
  fraPesquisarMenu.pLimparPesquisa;
end;

procedure TfrmPrincipal.pnlRodapeEnter(Sender: TObject);
begin
  fraPesquisarMenu.pLimparPesquisa;
end;

procedure TfrmPrincipal.mnuRelFiscResumoIcmsClick(Sender: TObject);
begin
  pValidaProCod('CREFIS');
  pCriarForm(TfrmRelFiscResumoIcms);
end;

procedure TfrmPrincipal.mnuCadEcfClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEcf);
end;

procedure TfrmPrincipal.pVerCompromisso;
  Var
    strSQL : String;
    qryTmp: TUniQuery;
    frmCompromissos: TfrmCompromissos;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT   ';
  strSQL := strSQL + '  *      ';
  strSQL := strSQL + 'FROM     ';
  strSQL := strSQL + '  AGENDA ';
  strSQL := strSQL + 'WHERE    ';
  strSQL := strSQL + '  AGE_CODOPE = :CODOPE AND ';
  strSQL := strSQL + '  AGE_DTACOM = :DTACOM AND ';
  strSQL := strSQL + '  AGE_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  AGE_BAIXAD = "N"         ';
  strSQL := strSQL + 'ORDER BY                   ';
  strSQL := strSQL + '  AGE_DTACOM, AGE_HORCOM   ';

  qryTmp := fCriaQuery(Self);
  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;
    ParamByName('DTACOM').AsDateTime := VS_Date;
    ParamByName('CODEMP').AsString   := VS_strCodEMp;
    Open;
    If Not IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmCompromissos, frmCompromissos);
        frmCompromissos.edtCodOpe.Text := strLoginUsuarioLogado;
        frmCompromissos.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[pVerCompromisso]');
        End;
      End;
      pFreeAndNil(frmCompromissos);
    End;
    Close;
    FreeAndNil(qryTmp);
  End;
end;

procedure TfrmPrincipal.mnuRelFiscOpeInterEntradasClick(
  Sender: TObject);
begin
  pRelatorioLivrosFiscais(relFiscOpeInterEntradas);
end;

procedure TfrmPrincipal.mnuRelFiscOpeInterSaidasClick(Sender: TObject);
begin
  pRelatorioLivrosFiscais(relFiscOpeInterSaidas);
end;

procedure TfrmPrincipal.mnuBaixaChequesCustodiaClick(Sender: TObject);
begin
  pCriarForm(TfrmBaixaChequesCustodia);
end;

procedure TfrmPrincipal.mnuBaixaChequesTelechequeClick(Sender: TObject);
begin

  If fEmptyStr(fCfgSis('PORTEL')) Then
    fMensagem('', 'A configuração do grupo Cheques: "Portador para envio de cheques para Telecheque" está em branco. Informe um portador!', ['&Ok'])
  Else
    pCriarForm(TfrmBaixaChequesTelecheque);

end;

procedure TfrmPrincipal.mnuBaixaCreditosFlexClick(Sender: TObject);
begin
  pCriarForm(TfrmBaixaCreditosFlex);
end;

procedure TfrmPrincipal.mnuRelChqEmCustodiaClick(Sender: TObject);
begin
  pRelatorioChequesPre(relChqEmCustodia);
end;

procedure TfrmPrincipal.mnuBaixaCancCustodiaClick(Sender: TObject);
begin
  pCriarForm(TfrmBaixaCancCustodia);
end;

procedure TfrmPrincipal.mnuBaixaCancTelechequeClick(Sender: TObject);
begin
  pCriarForm(TfrmBaixaCancTelecheque);
end;

procedure TfrmPrincipal.pEscolherOpcaoRetornoConsignacao(var AblnChamarRetornoConsignacaoNovamente : Boolean);
  Var
    frmFatRetornoConsignacao : TfrmFatRetornoConsignacao;
    frmEntImportaNotaElet    : TfrmEntImportaNotaElet;
    frmEntDigPedido          : TfrmEntDigPedido;
    LintOpcao                : Integer;
begin
  AblnChamarRetornoConsignacaoNovamente := False;

  LintOpcao := fGetMenu('Escolha o Tipo de NF de Entrada', ['Devolução', 'Outras Entradas', 'Entrada Devolução - Importar do xml',
  'Entrada Devolução - Xml já importado', 'Entrada Devolução - Digitação manual', 'Sair'], 1);

  if (LintOpcao = 1) or (LintOpcao = 2) then
  Begin
    pCriarFormularios(TfrmFatRetornoConsignacao, frmFatRetornoConsignacao);
    frmFatRetornoConsignacao.blnNfeOutrasEntradas := LintOpcao = 2;
    frmFatRetornoConsignacao.ShowModal;
    pFreeAndNil(frmFatRetornoConsignacao);
  End
  Else
  Begin
    if LintOpcao = 3 then
    Begin
      if not fVerificaAcessoSistema(mnuEntImportaNotaElet.Hint) then
      Begin
        fMensagem('ATENÇÃO', 'Operador sem acesso à rotina de importação de nota fiscal eletrônica!', ['&Ok']);
        Exit;
      End
      Else
      Begin
        pCriarFormularios(TfrmEntImportaNotaElet, frmEntImportaNotaElet);
        frmEntImportaNotaElet.blnAcessadoViaRetornoConsignacao := True;
        frmEntImportaNotaElet.pAjustargTipXML; { Insere valores no rdgTipXML }
        frmEntImportaNotaElet.rdgTipXML.ItemIndex := frmEntImportaNotaElet.rdgTipXML.Items.IndexOf(arrFinalidadeXML[xmlConsignacaoDevolucaoCliente]); {Seta o rdgTipXML na posição certa}

        frmEntImportaNotaElet.btnImportarClick(frmEntImportaNotaElet.btnImportar);

        AblnChamarRetornoConsignacaoNovamente := frmEntImportaNotaElet.blnChamarRetornoConsignacaoNovamente;

        pFreeAndNil(frmEntImportaNotaElet);
      End;
    End
    Else if LintOpcao = 4 then
    Begin
      if not fVerificaAcessoSistema('frmEntDigPedido') then
      Begin
        fMensagem('ATENÇÃO', 'Operador sem acesso à rotina de entrada de mercadorias.', ['&Ok']);
        Exit;
      End
      Else
      Begin
        pCriarFormularios(TfrmEntDigPedido, frmEntDigPedido);
        frmEntDigPedido.blnAcessadoViaRetornoConsignacao := True;
        frmEntDigPedido.TipoRetornoConsignacao           := ttrImportacaoXML;
        frmEntDigPedido.ShowModal;
        pFreeAndNil(frmEntDigPedido);

        AblnChamarRetornoConsignacaoNovamente := True;
      End;
    End
    Else if LintOpcao = 5 then
    Begin
      if not fVerificaAcessoSistema('frmEntDigPedido') then
      Begin
        fMensagem('ATENÇÃO', 'Operador sem acesso à rotina de entrada de mercadorias.', ['&Ok']);
        Exit;
      End
      Else
      Begin
        pCriarFormularios(TfrmEntDigPedido, frmEntDigPedido);
        frmEntDigPedido.blnAcessadoViaRetornoConsignacao := True;
        frmEntDigPedido.TipoRetornoConsignacao           := ttrEntradaManual;
        frmEntDigPedido.ShowModal;
        pFreeAndNil(frmEntDigPedido);

        AblnChamarRetornoConsignacaoNovamente := True;
      End;
    End
    Else if LintOpcao = 6 then
      Exit;
  End;

  strListIdGerEle.Clear;
end;

procedure TfrmPrincipal.pEscondeBotoes;
begin
  btnCadClientes.Visible := False;
  btnCadItens.Visible := False;
  btnMovItens.Visible := False;
  btnFaturamento.Visible := False;
  btnResumoCaixa.Visible := False;
  btnFinanceiro.Visible := False;
  btnWMS.Visible := False;

  btnMensagem.Visible := False;
  btnTintaMaquina.Visible := False;
  btnRelFatMetasVendedor_Dir.Visible := False;
  btnDASSuvinil.Visible := False;
  btnPesar.Visible := False;
  btnCrm.Visible := False;

  btnCadClientes.Align := alNone;
  btnCadItens.Align := alNone;
  btnMovItens.Align := alNone;
  btnFaturamento.Align := alNone;
  btnResumoCaixa.Align := alNone;
  btnFinanceiro.Align := alNone;
  btnWMS.Align := alNone;

  btnMensagem.Align := alNone;
  btnTintaMaquina.Align := alNone;
  btnRelFatMetasVendedor_Dir.Align := alNone;
  btnDASSuvinil.Align := alNone;
  btnPesar.Align := alNone;
  btnCrm.Align := alNone;
  btnLocacaoEquipamento.Align := alNone;

  btnEnvioEmail.Visible := False;
  btnCitelDesk.Visible := False;
  btnConfiguracoes.Visible := False;
  btnSair.Visible := False;
  btnLocacaoEquipamento.Visible := False;

  fraPesquisarMenu.btnDashboard.Visible := False;

  pnlNotificacao.Visible := False;
end;

procedure TfrmPrincipal.pEscondeMenus;
begin
  If fCfgSis('MENSUP', varBoolean) Then
    Menu := Nil;

  mnuAgendamentoCiclicoComDia.Visible := Not SameText(fCfgSis('TELAGE'),'3');
  mnuAntecipacaoDeCartoes.Visible := False;

  mnuFatExpServicos.Visible := fCfgSis('AUTCEN', VarBoolean) And fCfgSis('USAEXS', varBoolean);
end;

function TfrmPrincipal.Pesquisar(ATexto: String): IResultadoPesquisaAutcom;
begin
  Result := fraPesquisarMenu.Pesquisar(ATexto);
end;

procedure TfrmPrincipal.mnuAnaliseEstoqueEmExcessoClick(Sender: TObject);
begin
  pCriarForm(TfrmAnaliseEstoqueEmExcesso);
end;

procedure TfrmPrincipal.mnuImpEtiEmpresaArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeEmpresaArgox, strCodLay);
end;

procedure TfrmPrincipal.ApplicationEventsActivate(Sender: TObject);
//var localHandle: THandle;
 {   pName: pChar;
    Len: LongInt;
    Title: string;}
begin
  SetForegroundWindow(Application.Handle);

//    localHandle := GetActiveWindow;
//    ForceForegroundWindow(localHandle);

{    pName :='';

    GetWindowText(localHandle, pName, 255);
    Len := GetWindowTextLength(localHandle) + 1;
    SetLength(Title, Len);
    GetWindowText(localHandle, PChar(Title), Len);
    If FindControl(localHandle) is TForm Then
    Begin
      FindControl(localHandle).BringToFront;
      TForm(FindControl(localHandle)).Show;
    End;
}
end;

//function TfrmPrincipal.ForceForegroundWindow(hwnd: THandle): boolean;
//const
//  SPI_GETFOREGROUNDLOCKTIMEOUT = $2000;
//  SPI_SETFOREGROUNDLOCKTIMEOUT = $2001;
//var
//  ForegroundThreadID: DWORD;
//  ThisThreadID : DWORD;
//  timeout : DWORD;
//begin
//  SetForegroundWindow(hwnd);
//  Result := (GetForegroundWindow = hwnd);
//
//  if IsIconic(hwnd) And (Not Result) then
//  Begin
//     ShowWindow(hwnd, SW_SHOWDEFAULT);
//  End;
//
//  if GetForegroundWindow = hwnd then
//    Result := true
//  else
//  begin
//    if ((Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion > 4)) or
//      ((Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and
//      ((Win32MajorVersion > 4) or ((Win32MajorVersion = 4) and (Win32MinorVersion > 0)))) then
//    begin
//
//      Result := false;
//      ForegroundThreadID := GetWindowThreadProcessID(GetForegroundWindow,nil);
//      ThisThreadID := GetWindowThreadPRocessId(hwnd,nil);
//      if AttachThreadInput(ThisThreadID, ForegroundThreadID, true) then
//      begin
//        BringWindowToTop(hwnd); // IE 5.5 related hack
//        SetForegroundWindow(hwnd);
//        AttachThreadInput(ThisThreadID, ForegroundThreadID, false);
//        Result := (GetForegroundWindow = hwnd);
//      end;
//      if not Result then
//      begin
//        SystemParametersInfo(SPI_GETFOREGROUNDLOCKTIMEOUT, 0, @timeout, 0);
//        SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, TObject(0), SPIF_SENDCHANGE);
//        BringWindowToTop(hwnd); // IE 5.5 related hack
//        SetForegroundWindow(hWnd);
//        SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0,
//        TObject(timeout), SPIF_SENDCHANGE);
//      end;
//    end
//    else begin
//      BringWindowToTop(hwnd); // IE 5.5 related hack
//      SetForegroundWindow(hwnd);
//    end;
//
//    Result := (GetForegroundWindow = hwnd);
//  end;
//end;

procedure TfrmPrincipal.ArquivamentodeDocumentos1Click(Sender: TObject);
begin
  pCriarForm(TfrmOpcArquivo);
end;

procedure TfrmPrincipal.AtualizarTelaPrincipalAutcom(Esconder: Boolean);
begin
  If Esconder Then
  Begin
    {$IFDEF  TESTABILIDADE_AUTCOM}
    Self.Hide
    {$Else}
    If blnUsuarioLogadoUtilizaModoClassico Then
      Self.Hide
    Else
      Principal.View.FMXPrincipal.AtualizarTelaPrincipalNova(True);
    {$ENDIF}
  End
  Else
  Begin
    {$IFDEF  TESTABILIDADE_AUTCOM}
    VerificarSeAutTinEstaAberto;
    Self.Show;
    SetForegroundWindow(Self.Handle);
    {$Else}
    If blnUsuarioLogadoUtilizaModoClassico Then
    Begin
      VerificarSeAutTinEstaAberto;
      Self.Show;
      SetForegroundWindow(Self.Handle);
    End
    Else
    Begin
      If blnExecutandoAutTin Then
      VerificarSeAutTinEstaAberto;
      Principal.View.FMXPrincipal.AtualizarTelaPrincipalNova(False);
    End;
    {$ENDIF}
  End;
end;

function TfrmPrincipal.BancoDeDados: String;
begin
  Result := frmModulo.GetCurrentConnection.Database;
end;

procedure TfrmPrincipal.mnuCadBeneficioFiscalClick(Sender: TObject);
begin
  pCriarForm(TfrmCadBeneficioFiscal);
end;

procedure TfrmPrincipal.btnCadClientesClick(Sender: TObject);
begin
  If InterlockedIncrement(intSemaforoCadCli) = 0 Then
  Begin
    Try
      If (fVerificaAcessoSistema(mnuCadClientes.Hint)) Then
      Begin
        mnuCadClientes.Click;
      End
      Else
      Begin
        fMensagem('', 'Esse usuário não tem direito a acessar esse módulo!', ['&Ok']);
      End;
    Finally
      InterlockedDecrement(intSemaforoCadCli);
    End;
  End
  Else
    InterlockedDecrement(intSemaforoCadCli);

  Windows.setFocus(0);
end;

procedure TfrmPrincipal.btnCadItensClick(Sender: TObject);
  Var
    Posicao: TPoint;
begin
  GetCursorPos(Posicao);
  popProdutos.Popup(Posicao.X + 40,Posicao.Y);
  Windows.setFocus(0);
end;

procedure TfrmPrincipal.btnCitelDeskClick(Sender: TObject);
begin
  AbrirCitelDesk;
end;

procedure TfrmPrincipal.btnTintaMaquinaClick(Sender: TObject);
Var
  Posicao: TPoint;
begin
  If (fVerificaAcessoSistema(mnuTintaDeMaquina.Hint)) Or (fVerificaAcessoAutTin(mnuTintaDeMaquina.Hint, mnuTintaDeMaquina.Name))  Then
  Begin
    GetCursorPos(Posicao);
    popTintasMaquina.Popup(Posicao.X + 40,Posicao.Y);
    Windows.setFocus(0);
  End
  Else
  Begin
    fMensagem('', 'Esse usuário não tem direito a acessar esse módulo!', ['&Ok']);
  End;
  Windows.SetFocus(0);
end;

procedure TfrmPrincipal.btnWMSClick(Sender: TObject);
Var
  Posicao: TPoint;
begin
  GetCursorPos(Posicao);
  popWMS.Popup(Posicao.X + 40,Posicao.Y);
  Windows.setFocus(0);
end;

procedure TfrmPrincipal.btnMovItensClick(Sender: TObject);
  Var
    Posicao: TPoint;
begin
  GetCursorPos(Posicao);
  popMovItens.Popup(Posicao.X + 40,Posicao.Y);
  Windows.setFocus(0);
end;

procedure TfrmPrincipal.btnPesarClick(Sender: TObject);
begin
  mnuPesarProdutos.Click;
  Windows.setFocus(0);
end;

procedure TfrmPrincipal.btnFinanceiroClick(Sender: TObject);
  Var
    Posicao: TPoint;
begin
  GetCursorPos(Posicao);
  popFinanceiro.Popup(Posicao.X + 40,Posicao.Y);
  Windows.setFocus(0);
end;

procedure TfrmPrincipal.btnLocacaoEquipamentoClick(Sender: TObject);
Var
  Posicao: TPoint;
begin
  GetCursorPos(Posicao);
  popLocacaoEquipamento.Popup(Posicao.X + 40,Posicao.Y);
  Windows.setFocus(0);
end;

procedure TfrmPrincipal.btnResumoCaixaClick(Sender: TObject);
begin
  mnuFatResumoCaixa.Click;

  Windows.setFocus(0);
end;

procedure TfrmPrincipal.btnConfiguracoesClick(Sender: TObject);
begin
    mnuCadConfiguracoes.Click;
  Windows.setFocus(0);
end;

procedure TfrmPrincipal.btnCRMClick(Sender: TObject);
begin
  mnuCRM.Click;
end;

procedure TfrmPrincipal.mnuRelCtrReimpressaoDocsClick(Sender: TObject);
begin
  pCriarForm(TfrmRelCtrReimpressaoDocs);
end;

procedure TfrmPrincipal.mnuRelFatExtratoProfissionalClick(Sender: TObject);
begin
  pCriarForm(TfrmRelFatExtratoProfissional);
end;

procedure TfrmPrincipal.mnuCadCndClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCondicoes);
end;

procedure TfrmPrincipal.mnuFatFaturaConsignacaoClick(Sender: TObject);
begin
  If fEmptyStr(fCfgSis('FATCON')) Then
  Begin
    pMensagemOk('Configure a Classificação Fiscal para Faturamento de Mercadoria em Consignação em Configurações/Faturamento');
    Exit;
  End;

  pCriarForm(TfrmFatFaturaConsignacao);
end;

procedure TfrmPrincipal.mnuFatFormulacaoDocumentosClick(Sender: TObject);
begin
  pCriarForm(TfrmFatFormulacaoItens);
end;

procedure TfrmPrincipal.mnuFatGerarNovoPreRomaneioClick(Sender: TObject);
begin
  pCriarForm(TfrmFatGerarNovoPreRomaneio);
end;

procedure TfrmPrincipal.mnuCadFpgClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFormaPagamento);
end;

procedure TfrmPrincipal.mnuCadFrequenciaCRMClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFrequenciaCRM);
end;

procedure TfrmPrincipal.mnuCadFreteFaixaFaturamentoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFreteFaixaFaturamento);
end;

procedure TfrmPrincipal.mnuCadFreteRegiaoClick(Sender: TObject);
begin
  pCriarForm(TFrmCadFreteRegiao);
end;

procedure TfrmPrincipal.mnuCadFreteTranspCidadeClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFreteTranspCidade);
end;

procedure TfrmPrincipal.mnuCadFreteTranspRegiaoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFreteTranspRegiao, frmCadFreteTranspRegiao);
end;

procedure TfrmPrincipal.mnuFinDesmRemBancClick(Sender: TObject);
begin
  pCriarForm(TfrmFinDesmRemBanc);
end;

procedure TfrmPrincipal.mnuFluxoComprasClick(Sender: TObject);
begin
  pCriarForm(TfrmFluxoComprasView);
end;

procedure TfrmPrincipal.mnufrmCadFuncionariosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFuncionarios);
end;

procedure TfrmPrincipal.mnufrmCadFuncoesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFuncoes);
end;

procedure TfrmPrincipal.mnufrmEditorEtiquetasOrdemServicoArgoxClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeOrdemServicoArgox, strCodLay);
end;

procedure TfrmPrincipal.mnufrmEditorEtiquetasOrdemServicoLaserClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeOrdemServicoLaser, strCodLay);
end;

procedure TfrmPrincipal.mnufrmImportarCadLocEquClick(Sender: TObject);
begin
  TfrmImportaArquivoCadastro.pAbreTelaImportacaoArquivo(tpCadLocEqu);
end;

procedure TfrmPrincipal.mnuCadComboProdVendaClick(Sender: TObject);
Const
  CHAVE_LCKATC = 'COMBO_VENDA';
begin
  If (Not fCfgSis('USABRI', varBoolean)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar o cadastro de Combo de Venda, é preciso permitir utilizar Brinde no Faturamento.' + #13#10 +
              'Verifique a Configuração CFG_USABRI nas Configurações do Sistema.', ['&O k']);
    Exit;
  End;

  If (Not fCfgSis('VENBRI', varBoolean)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar o cadastro de Combo de Venda, é preciso configurar para não desmembrar os Produtos de Brinde dos demais Produtos no faturamento.' + #13#10 +
              'Verifique a Configuração CFG_VENBRI nas Configurações do Sistema.', ['&O k']);
    Exit;
  End;

  If (fLock_Unlock(CHAVE_LCKATC, True, False)) Then
  Begin
    pCriarForm(TfrmCadComboProdVenda);
    fLock_Unlock(CHAVE_LCKATC, False, False);
  End
  Else
  Begin
    fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(CHAVE_LCKATC), ['&Ok']);
  End;
end;

procedure TfrmPrincipal.mnuCadComClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCom);
end;

procedure TfrmPrincipal.mnuCadModelosRelClick(Sender: TObject);
begin
  pCriarForm(TfrmCadModelosRel);
end;

procedure TfrmPrincipal.mnuCadModVeiClick(Sender: TObject);
begin
  pCriarForm(TfrmCadModVei);
end;

procedure TfrmPrincipal.mnuCadMontadorasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMontadoras);
end;

procedure TfrmPrincipal.mnuCadMotFinOcoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMotFinOco);
end;

procedure TfrmPrincipal.mnuCadMotivoPausaAppEntregaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMotivoPausaAppEntrega);
end;

procedure TfrmPrincipal.mnuCadMotivoReprovacaoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMotivoReprovacao);
end;

procedure TfrmPrincipal.mnuCadMotivosAproveitamentoItensClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMotivosAproveitamentoItens);
end;

procedure TfrmPrincipal.mnuCadMotivoVerbasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMotivoVerbas);
end;

procedure TfrmPrincipal.mnuCadMotoristasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMotoristas);
end;

procedure TfrmPrincipal.mnuCadMotVendasPerdidasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMotVendasPerdidas);
end;

procedure TfrmPrincipal.mnuFatRomaneioAdicionarDoctosNaoEntreguesClick(Sender: TObject);
begin
  pCriarForm(TfrmFatRomaneioAdicionarDoctosNaoEntregues);
end;

procedure TfrmPrincipal.mnuFatRomaneioClick(Sender: TObject);
begin
  pCriarForm(TfrmFatRomaneio);
end;

procedure TfrmPrincipal.mnuFatRomaneioLoteSeparacaoClick(Sender: TObject);
begin
  pCriarForm(TfrmFatRomaneioLoteSeparacao);
end;

procedure TfrmPrincipal.mnuFatRomaneioManutencaoClick(Sender: TObject);
begin
  pCriarForm(TfrmFatRomaneioManutencao);
end;

procedure TfrmPrincipal.mnuFatRomaneioPedidosNaoFaturadosClick(Sender: TObject);
begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(204, 7603, [],
                        ['EMPROM'],
                        [VS_strCodEmp],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmPrincipal.mnuFatRomaneioSimplificadoClick(Sender: TObject);
var
  frmFatRomaneio : TfrmFatRomaneio;
begin
  frmFatRomaneio := TfrmFatRomaneio.Create(Self);
  Try
    frmFatRomaneio.TipoTela := ttRomaneioSimplificado;
    frmFatRomaneio.Showmodal;
  Finally
    pFreeAndNil(frmFatRomaneio);
  End;
end;

procedure TfrmPrincipal.mnuFatLiberacaoRomaneioClick(Sender: TObject);
begin
  pCriarForm(TfrmFatLiberacaoRomaneio);
end;

procedure TfrmPrincipal.mnuFatLibReservaEstoqueOSClick(Sender: TObject);
begin
  pCriarForm(TfrmFatLibReservaEstoqueOS);
end;

procedure TfrmPrincipal.mnuFatRomManutEntregaClick(Sender: TObject);
begin
  pCriarForm(TfrmFatRomManutEntrega);
end;

procedure TfrmPrincipal.mnuFatSepFutDigSeparadorClick(Sender: TObject);
begin
  pCriarForm(TfrmFatSepFutDigSeparador);
end;

procedure TfrmPrincipal.mnuCadServicosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadServicos);
end;

procedure TfrmPrincipal.mnuFatLocEquipClick(Sender: TObject);
begin
  pCriarForm(TfrmFaturaLocEqu);
end;

procedure TfrmPrincipal.mnuCadStaSerClick(Sender: TObject);
begin
  pCriarForm(TfrmCadStaSer);
end;

procedure TfrmPrincipal.mnuCadTipSerClick(Sender: TObject);
begin
  pCriarForm(TfrmCadTipSer);
end;

procedure TfrmPrincipal.mnuAltPrecoIndividualClick(Sender: TObject);
begin
  If fVerificaAcessoSistema('ALTICUSVEN', strLoginUsuarioLogado) Or
     fVerificaAcessoSistema('ALTICUSMAR', strLoginUsuarioLogado) Or
     fVerificaAcessoSistema('ALTIVENMAR', strLoginUsuarioLogado) Then
    pOpeProd(AltPrecoIndividual)
  Else
    pMensagemOk('Usuário sem direito de acesso!');
end;

procedure TfrmPrincipal.mnuAltPrecoMedioClick(Sender: TObject);
begin
  pOpeProd(AltPrecoMedio);
end;

procedure TfrmPrincipal.mnuGerAutCtaPagarClick(Sender: TObject);
begin
  pCriarForm(TfrmGerAutCtaPagar);
end;

procedure TfrmPrincipal.mnuGerAutCtaReceberClick(Sender: TObject);
begin
  pCriarForm(TfrmGerAutCtaReceber);
end;

procedure TfrmPrincipal.mnuGeraVisitaClienteClick(Sender: TObject);
begin
  pCriarForm(TfrmGeraVisitaCliente);
end;

procedure TfrmPrincipal.mnuGeraVisitaClienteIndividualClick(Sender: TObject);
begin
  pCriarForm(TfrmGeraVisitaClienteIndividual);
end;

procedure TfrmPrincipal.mnuCadReceitAgronomicoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadReceitAgronomico);
end;

procedure TfrmPrincipal.mnuCadRecursoProjetoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadRecursosProjeto);
end;

procedure TfrmPrincipal.mmoEstornoComissaoProfissionaisClick(Sender: TObject);
begin
  pCriarForm(TfrmEstornoComissaoProfissionais);
end;

procedure TfrmPrincipal.mmuCadMetasCobrancaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMetasCobranca);
end;

procedure TfrmPrincipal.mmuRelCbaLogAcompMovBanNovoClick(Sender: TObject);
begin
  pCriarForm(TfrmRelCbaLogAcompMovBanNovo);
end;

procedure TfrmPrincipal.mnCadMarVeiClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMarVei);
end;

procedure TfrmPrincipal.mntmExpGNREdeSaidaClick(Sender: TObject);
begin
  pCarregaLibGnre(GnrePernambuco);
end;

procedure TfrmPrincipal.mnuAcertoContaClick(Sender: TObject);
begin
  pCriarForm(TfrmAcertoConta);
end;

procedure TfrmPrincipal.mnuAcertoDeContasDeProfissionaisClick(Sender: TObject);
begin
  pCriarForm(TfrmAcertoDeContasDeProfissionais, frmAcertoDeContasDeProfissionais);
end;

procedure TfrmPrincipal.mnuCadPromocoesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPromocoes);
end;

procedure TfrmPrincipal.mnuCadProspectosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadProspectos);
end;

procedure TfrmPrincipal.mnuCadPromocaoBrindesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPromocaoBrindes);
end;

procedure TfrmPrincipal.mnuInativarLotesSemSaldoClick(Sender: TObject);
begin
  pCriarForm(TfrmInativarLotesSemSaldo);
end;

procedure TfrmPrincipal.mnuInfCobrancaClick(Sender: TObject);
begin
  pCriarForm(TfrmInfCobranca);
end;

procedure TfrmPrincipal.mnuInspLibEquipClick(Sender: TObject);
begin
  pCriarForm(TfrmInspecaoLocEqu);
end;

procedure TfrmPrincipal.mnuIntegraDoctorcredClick(Sender: TObject);
begin
  pCriarForm(TfrmIntegraDoctorcred);
end;

procedure TfrmPrincipal.mnuCadTimeFutebolClick(Sender: TObject);
begin
  pCriarForm(TfrmCadTimeFutebol);
end;

procedure TfrmPrincipal.mnuCadTipoAtendimentoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadTipoAtendimento);
end;

procedure TfrmPrincipal.mnuCadTipoProjetoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadTiposProjeto, frmCadTiposProjeto);
end;

procedure TfrmPrincipal.mnuCadTiposClienteClick(Sender: TObject);
begin
  pCriarForm(TfrmCadTiposCliente);
end;

procedure TfrmPrincipal.mnuCadTiposCotacaoPedidoCompraClick(Sender: TObject);
begin
  pCriarForm(TfrmCadTiposCotacaoPedidoCompra, frmCadTiposCotacaoPedidoCompra);
end;

procedure TfrmPrincipal.mnuCadTiposIntegracaoWSClick(Sender: TObject);
begin
  pCriarForm(TfrmCadTiposIntegracaoWS);
end;

procedure TfrmPrincipal.mnuCadTiposOcorrenciasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadTiposOcorrencias);
end;

procedure TfrmPrincipal.mnuCadEmbarcacoesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEmbarcacoes);
end;

procedure TfrmPrincipal.mnuCadEmiChequesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEmiCheques);
end;

procedure TfrmPrincipal.mnuRelEstatAbcVenRepClick(Sender: TObject);
begin
  pRelatorioEstatisticas(relEstatAbcVenRep);
end;

procedure TfrmPrincipal.mnuTransfCodClienteClick(Sender: TObject);
begin
  pTransfCod(TransfCodCliente);
end;

procedure TfrmPrincipal.mnuRelCtrExportaCobrancaClick(Sender: TObject);
begin
  pCriarForm(TfrmRelCtrExportaCobranca);
end;

procedure TfrmPrincipal.mnuRelCtpTitAbertoMesClick(Sender: TObject);
begin
   pRelatorioContasAPagar(relCtpTitAbertoMes);
end;

procedure TfrmPrincipal.mnuAltValorEntregaClick(Sender: TObject);
begin
  pCriarForm(TfrmAltValorEntrega);
end;

procedure TfrmPrincipal.mnuAltVendTempClick(Sender: TObject);
begin
  pCriarForm(TfrmTrocaVendTemp);
end;

procedure TfrmPrincipal.mnuAltVenRepClick(Sender: TObject);
begin
  pCriarForm(TfrmAltVenRep);
end;

procedure TfrmPrincipal.mnuAnaliseComprasClick(Sender: TObject);
begin
  pCriarForm(TfrmAnaliseCompras);
end;

procedure TfrmPrincipal.mnuAnaliseProducaoClick(Sender: TObject);
begin
  pCriarForm(TfrmAnaliseProducao);
end;

procedure TfrmPrincipal.mnuTransfCodVendedorClick(Sender: TObject);
begin
  pTransfCod(TransfCodVendedor);
end;

procedure TfrmPrincipal.mnuRelEstatDemonsFatClick(Sender: TObject);
begin
  pCriarForm(TfrmRelEstatDemonsFat);
end;

procedure TfrmPrincipal.mnuCadEscolaridadeClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEscolaridades);
end;

procedure TfrmPrincipal.mnuCadEstadoCivilClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEstadoCivil);
end;

procedure TfrmPrincipal.mnuCadEstProdutoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEstProduto);
end;

procedure TfrmPrincipal.mnuCadEstrIndSubsCompClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEstruturasIndustrialSubsComp);
end;

procedure TfrmPrincipal.mnuCadEstruturasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEstruturas);
end;

procedure TfrmPrincipal.mnuCadEstruturasIndustrialDFClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEstruturasIndustrialDF);
end;

procedure TfrmPrincipal.mnuCadEtiquetaVolumeEtiquetaDespachoClick(
  Sender: TObject);
begin
  pCriarForm(TfrmCadEtiquetaVolumeEtiquetaDespacho);
end;

procedure TfrmPrincipal.mnuGerImpFiscaisClick(Sender: TObject);
begin
  pCriarForm(TfrmGerImpFiscais);
end;

procedure TfrmPrincipal.mnuNegociacaoOrdemServicoClick(Sender: TObject);
begin
  pCriarForm(TfrmNegociacaoOrdemServico);
end;

procedure TfrmPrincipal.mnuNfeInutilizacaoClick(Sender: TObject);
begin
  pCriarForm(TfrmNfeInutilizacao);
end;

procedure TfrmPrincipal.mnuNotaFiscalImportClick(Sender: TObject);
begin
  pCriarForm(TfrmNotaFiscalImport);
end;

procedure TfrmPrincipal.mnuRelEstSaldoReservadoClick(Sender: TObject);
begin
  pCriarForm(TfrmRelEstSaldoReservado);
end;

procedure TfrmPrincipal.mnuCadMetaCompDepVendClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMetaCompDepVend);
end;

procedure TfrmPrincipal.mnuCadMetasCentroCustoClick(Sender: TObject);
  Var
    frmCadMetasCentroCusto: TfrmCadMetasCentroCusto;
begin
  frmCadMetasCentroCusto := TfrmCadMetasCentroCusto.Create(Self);
  Try
    frmCadMetasCentroCusto.blnTodasEmpresas := fCfgSis('METPED') = '4';
    frmCadMetasCentroCusto.Showmodal;
  Finally
    FreeAndNil(frmCadMetasCentroCusto);
  End;
end;

procedure TfrmPrincipal.mnuCadMetasClick(Sender: TObject);
  Var
    frmCadMetasValor : TfrmCadMetasValor;
begin

  Try
    pCriarFormularios(TfrmCadMetasValor, frmCadMetasValor);

    If Assigned(frmCadMetasValor) Then
    Begin
      frmCadMetasValor.tmtTipMet      := tmeFaturamento;
      frmCadMetasValor.blnPorSubMetas := False;
      frmCadMetasValor.ShowModal;
      FreeAndNil(frmCadMetasValor);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuCadMetasClick]');
    End;
  End;

end;

procedure TfrmPrincipal.pRelFatMetasVendedor(Sender: TObject; blnDir: Boolean = False);
begin
  If blnDir Then
  Begin
    //pRelatorioFaturamentoDir(relFatMetasVendedor)
    If Assigned(prcExecutaRelatorio) Then
    begin
    prcExecutaRelatorio(117, 5952, [5952],
                        ['CODVEN', 'MESINI', 'MESFIN', 'OPCREL'],
                        [IIF(fVerificaAcessoSistema('vv500039'), strLoginUsuarioLogado, fRetSenhaVendedor(strLoginUsuarioLogado)), FormatDateTime('mm/yyyy', VS_Date), FormatDateTime('mm/yyyy', VS_Date), 'Analítico'],
                        Sender,
                        nil,
                        True,
                        True,
                        '',
                        Not fVerificaAcessoSistema('vv500039'));
    End;
  End
  Else
  Begin
    //pRelatorioFaturamento(relFatMetasVendedor);
    If Assigned(prcExecutaRelatorio) Then
    begin
    prcExecutaRelatorio(118, 5952, [5952],
                        [],
                        [],
                        Sender,
                        nil,
                        False);
    End;
  End;
end;

procedure TfrmPrincipal.pRelFatMetasVendedorPopup(Sender: TObject);
begin
  pRelFatMetasVendedor(Sender);
end;

procedure TfrmPrincipal.mnuCadConciliacaoBancariaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadConciliacaoBancaria);
end;

procedure TfrmPrincipal.mnuCadConcorrenciaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadConcorrencia);
end;

procedure TfrmPrincipal.mnuCadCondPagtoEspecialProdutosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCondPagtoEspecialProdutos);
end;

procedure TfrmPrincipal.mnuRelEstatAbcProfissionaisClick(Sender: TObject);
begin
  pRelatorioEstatisticas(relEstatAbcProfissionais);
end;

procedure TfrmPrincipal.mnuTransCodCorIndustrialClick(Sender: TObject);
begin
  pTransfCod(TransfCodCorIndustrial);
end;

procedure TfrmPrincipal.mnuTransCodFornecedorClick(Sender: TObject);
begin
  pTransfCod(TransfCodFornecedor);
end;

procedure TfrmPrincipal.mnuTransCodPlacaVeiculoClick(Sender: TObject);
begin
  pTransfCod(TransfCodPlacaVeiculo);
end;

procedure TfrmPrincipal.mnuTransfCodCidadeClick(Sender: TObject);
begin
  pTransfCod(TransfCodCidade);
end;

procedure TfrmPrincipal.mnuManOrdProClick(Sender: TObject);
begin
  If fCfgSis('VENVID', varBoolean) And fCfgSis('IMPGOR', varBoolean) Then
    pCriarForm(TfrmManutencaoOrdProVidro)
  Else
    pCriarForm(TfrmManOrdPro);
end;

procedure TfrmPrincipal.mnuBaiOrdProClick(Sender: TObject);
begin
  pCriarForm(TfrmBaixaOrdProd);
end;

procedure TfrmPrincipal.mnuRelEstatAbcFornecVendaClick(Sender: TObject);
begin
  pRelatorioEstatisticas(relEstatAbcFornecVenda);
end;

procedure TfrmPrincipal.mnuRedeLojasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadRedeLojas);
end;

procedure TfrmPrincipal.mnuReformaTributariaCreditoDebitoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadReformaTributariaCreditoDebito);
end;

procedure TfrmPrincipal.mnuReformaTributariaTipoCreditoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadReformaTributariaTipoCredito);
end;

procedure TfrmPrincipal.mnuReformaTributariaTipoDebitoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadReformaTributariaTipoDebito);
end;

procedure TfrmPrincipal.mnuReformaTributriaCreditoDebitoClick(Sender: TObject);
begin
  pCriarForm(TfrmReformaTributariaCreditoDebito);
end;

procedure TfrmPrincipal.mnuCampanhaVendasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCampanhaVendas);
end;

procedure TfrmPrincipal.mnuCampoItegerPermiteEdicaoClick(Sender: TObject);
begin
  TGerenciaItegerPermiteEdicao.pAbreEdicao;
end;

procedure TfrmPrincipal.mnuFatExpedicaoClick(Sender: TObject);
  Var
    frmFatDigRomaneio : TfrmFatDigRomaneio;
    blnApenasPrazo    : Boolean;
    objTravaCaixa     : TTravaCaixa;
begin

  blnApenasPrazo := False;
  objTravaCaixa  := TTravaCaixa.New('');

  Try

    If (objTravaCaixa.blnTravar) Then
      Exit;

    If objTravaCaixa.fCaixaDoDiaFechadoOuCaixaDoDiaAnteriorAindaNaoFechado Then
      blnApenasPrazo := objTravaCaixa.blnApenasEmissaoDeDocumentosAPrazo;

  Finally
    FreeAndNil(objTravaCaixa);
  End;

  Try
    If (VS_strTipExp = '5') Then
    Begin
      pCriarFormularios(TfrmFatDigRomaneio, frmFatDigRomaneio);
      Try
        frmFatDigRomaneio.ShowModal;
      Finally
        pFreeAndNil(frmFatDigRomaneio)
      End;
    End
    Else
    Begin

      pCriarFormularios(TfrmFatExpedicao, frmFatExpedicao);

      Try

        frmFatExpedicao.blnApenasImprimirBaixarSeparacao := False;
        frmFatExpedicao.blnApenasPrazo := blnApenasPrazo;

        frmFatExpedicao.ShowModal;

      Finally
        pFreeAndNil(frmFatExpedicao);
      End;

    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[]');
  End;

end;

procedure TfrmPrincipal.mnuFatEncerramentoManifestoEletronicoClick(
  Sender: TObject);
begin
  pCriarForm(TfrmFatEncerramentoManifestoEletronico);
end;

procedure TfrmPrincipal.mnuFatExclusaoVendasPerdidasClick(Sender: TObject);
begin
  pCriarForm(TfrmFatExclusaoVendasPerdidas);
end;

procedure TfrmPrincipal.mnuFatExpedicaoBaiSepClick(Sender: TObject);
begin
  Try
    pCriarFormularios(TfrmFatExpedicao, frmFatExpedicao);
    frmFatExpedicao.blnApenasImprimirBaixarSeparacao := True;
    frmFatExpedicao.Caption := mnuFatExpedicaoBaiSep.Caption;
    frmFatExpedicao.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[]');
  End;

  pFreeAndNil(frmFatExpedicao);
end;

procedure TfrmPrincipal.mnuFatExpedicaoConferenciaRetiraCaixaClick(Sender: TObject);
begin
  Try
    pCriarFormularios(TfrmFatExpedicao, frmFatExpedicao);
    frmFatExpedicao.blnApenasConferenciaProdutosRetiraCaixa := True;
    frmFatExpedicao.Caption := mnuFatExpedicaoConferenciaRetiraCaixa.Caption;
    frmFatExpedicao.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[]');
  End;

  pFreeAndNil(frmFatExpedicao);
end;

procedure TfrmPrincipal.mnuCtrLiberacaoFiltrosClick(Sender: TObject);
var
  frmCtrLiberacaoFiltros: TfrmCtrLiberacaoFiltros;
begin
  pCriarFormularios(TfrmCtrLiberacaoFiltros, frmCtrLiberacaoFiltros);
  If Assigned(frmCtrLiberacaoFiltros) Then
  Begin
    frmCtrLiberacaoFiltros.strTipLib := '1';
    frmCtrLiberacaoFiltros.ShowModal;
    FreeAndNil(frmCtrLiberacaoFiltros);
  End;
end;

procedure TfrmPrincipal.mnuCtrLiberacaoFiltrosComercialClick(Sender: TObject);
var
  frmCtrLiberacaoFiltros: TfrmCtrLiberacaoFiltros;
begin
  pCriarFormularios(TfrmCtrLiberacaoFiltros, frmCtrLiberacaoFiltros);
  If Assigned(frmCtrLiberacaoFiltros) Then
  Begin
    frmCtrLiberacaoFiltros.strTipLib := '2';
    frmCtrLiberacaoFiltros.ShowModal;
    FreeAndNil(frmCtrLiberacaoFiltros);
  End;
end;

procedure TfrmPrincipal.mnuCTRReajusteClick(Sender: TObject);
begin
  pCriarForm(TfrmCTRReajuste);
end;

procedure TfrmPrincipal.mnuCtrReprogVenClick(Sender: TObject);
begin
  pCriarForm(TfrmCtrReprogVen);
end;

procedure TfrmPrincipal.mnuDepartamentosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadDepartamentosCliCon);
end;

procedure TfrmPrincipal.mnuAltEfetivacaoPrecosClick(Sender: TObject);
begin
  pOpeProd(AltEfetivacaoPrecos);
end;

procedure TfrmPrincipal.mnuAltEfetivacaoPrecosTabClick(Sender: TObject);
begin
  pOpeProd(AltEfetivacaoPrecosTab);
end;

procedure TfrmPrincipal.mnuBonusVendaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadBonusVendas);
end;

procedure TfrmPrincipal.mnuCadPagBoschClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPagBosch);
end;

procedure TfrmPrincipal.mnuBoxEntregaClick(Sender: TObject);
var
  frmBoxEntrega : TfrmBoxEntrega;
begin
  pCriarFormularios(TfrmBoxEntrega, frmBoxEntrega);
  Try
    frmBoxEntrega.pConfiguraTelaParaOperacaoDeRetira;
    frmBoxEntrega.ShowModal;
  Finally
    pFreeAndNil(frmBoxEntrega);
  End;
end;

procedure TfrmPrincipal.mnuBoxEntregaImediataClick(Sender: TObject);
var
  frmBoxEntrega : TfrmBoxEntrega;
begin
  pCriarFormularios(TfrmBoxEntrega, frmBoxEntrega);
  Try
    frmBoxEntrega.pConfiguraTelaParaOperacaoDeEntregaImediata;
    frmBoxEntrega.ShowModal;
  Finally
    pFreeAndNil(frmBoxEntrega);
  End;
end;

procedure TfrmPrincipal.mnuCadMetasClientesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMetasClientes);
end;

procedure TfrmPrincipal.mnuCadMetasFaturamentoServicoPorFaixaClick(Sender: TObject);
begin
  If (Not fVerificaAcessoSistema(mnuCadMetasFaturamentoServicoPorFaixa.Hint)) Then
  Begin
    fMensagem('', 'Esse usuário não tem direito de acessar esse cadastro!', ['&Ok']);
    Exit;
  End;
  pCriarForm(TfrmCadMetasFaturamentoServicoPorFaixa, frmCadMetasFaturamentoServicoPorFaixa);
end;

procedure TfrmPrincipal.mnuCadMetasFornecValFatClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMetasFornecValFat);
end;

procedure TfrmPrincipal.mnuTransfCodCtaClick(Sender: TObject);
begin
  pTransfCod(TransfCodCta);
end;

procedure TfrmPrincipal.mnuTransfCodDiversosClick(Sender: TObject);
begin
  pTransfCod(TransfCodDiverso);
end;

procedure TfrmPrincipal.mnuRecebimentoClienteClick(Sender: TObject);
begin
  pCriarForm(TfrmGarantiaRecCliente);
end;

procedure TfrmPrincipal.mnuEnvioFornecedorClick(Sender: TObject);
begin
  pCriarForm(TfrmGarantiaEnvFornecedor);
end;

procedure TfrmPrincipal.mnuRetornoEquipClick(Sender: TObject);
begin
  If fCfgSis('RETGOS', varBoolean) And (Not TRetornoContrato.fValidaPodeProcessarOSContrato) Then
  Begin
    Exit;
  End;

  pCriarForm(TfrmRetornoLocEqu);
end;

procedure TfrmPrincipal.mnuRetornoFornecedorClick(Sender: TObject);
begin
  pCriarForm(TfrmGarantiaRetFornecedor);
end;

procedure TfrmPrincipal.mnuRotasRegiaoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadRotasRegiao);
end;

procedure TfrmPrincipal.mnuEnvioClienteClick(Sender: TObject);
begin
  pCriarForm(TfrmGarantiaEnvCliente);
end;

procedure TfrmPrincipal.mnuEnvioConfirmacaoSefazClick(Sender: TObject);
begin
  pCriarForm(TfrmEnvioConfirmacaoSefaz);
end;

procedure TfrmPrincipal.mnuEnvioEquipClick(Sender: TObject);
begin
  pCriarForm(TfrmEnvioLocEqu);
end;

procedure TfrmPrincipal.mnuRelSimplesNacionalClick(Sender: TObject);
begin
  If (fEmptyStr(fCfgSis('CLAIND', varString))) Then Begin
    fMensagem('ALERTA!', 'Necessário configurar as classificações fiscais de venda de produtos industrializados [CFG_CLAIND]!',['&OK']);
    Exit;
  End;

  If (fCfgSis('USASER', varBoolean)) And (fEmptyStr(fCfgSis('CLASER', varString))) Then Begin
    fMensagem('ALERTA!', 'Necessário configurar as classificações fiscais de venda de serviços [CFG_CLASER]!',['&OK']);
    Exit;
  End;

  pCriarForm(TfrmRelSimplesNacional);
end;

procedure TfrmPrincipal.mnuGerInventarioClick(Sender: TObject);
begin
  // CFG_MEDEMP = '1' (preco medio global) e tratado na propria geracao de
  // inventario: o preco medio e calculado com a soma do estoque de todas
  // as empresas do grupo e replicado em todas elas.
  pOpeProd(GerInventario);
end;

procedure TfrmPrincipal.mnuManutInventarioClick(Sender: TObject);
begin
  pOpeProd(ManutInventario);
end;

procedure TfrmPrincipal.mnuManutInventarioLoteClick(Sender: TObject);
begin
  pOpeProd(ManutInventarioLote);
end;

procedure TfrmPrincipal.mnuManutKmRodadoClick(Sender: TObject);
begin
  pCriarForm(TfrmManutKmRodado);
end;

procedure TfrmPrincipal.mnuManutMultiLojaAposEntradaClick(Sender: TObject);
begin
  pCriarForm(TfrmManutecaoMultiLojaPosEntrada);
end;

procedure TfrmPrincipal.mnuManutNumSerieItensClick(Sender: TObject);
begin
  pCriarForm(TfrmManutNumSerieItens);
end;

procedure TfrmPrincipal.mnuMapaDeInventarioParaColetoresClick(Sender: TObject);
begin
  pOpeProd(MapaDeInventarioParaColetores);

end;

procedure TfrmPrincipal.mnuMapaDemonstrativodeEstoque1Click(Sender: TObject);
begin
  pCriarForm(TfrmRelFatMapDemonsEstoq);
end;

procedure TfrmPrincipal.mnuProcessListClick(Sender: TObject);
begin
  pCriarForm(TfrmProcessList);
end;

procedure TfrmPrincipal.mnuProdutoCadastroRapidoLoteRastreamentoClick(
  Sender: TObject);
begin
  pCriarForm(TfrmProdutoCadastroRapidoLoteRastreamento);
end;

procedure TfrmPrincipal.pConciliacaoCartoes(strNomCon: String);
  Var
    objCartoes: TConciliacaoCartoes;
    blnReabre : Boolean;
    frmBaixaCartoes : TfrmBaixaCartoes;
begin
  blnReabre := True;

  While blnReabre Do
  Begin
    If Not fLock_Unlock('CONCILIACAO_BAIXA_CARTOES_' + StringReplace(strNomCon, ' ', '_', [rfReplaceAll]), True, False) Then
    Begin
      fMensagem('ATENÇÃO', 'A rotina de baixa/conciliação da operadora ' + strNomCon + ' está sendo utilizada por outra estação: ' +
                           fGetHostLock('CONCILIACAO_BAIXA_CARTOES_' + StringReplace(strNomCon.Trim, ' ', '_', [rfReplaceAll])), ['&OK'], 1);
      Exit;
    End;

    pCriarFormularios(TfrmBaixaCartoes, frmBaixaCartoes);

    objCartoes := fSetConcil(StringReplace(strNomCon, ' ', EmptyStr, [rfReplaceAll]));
    objCartoes.frxPagina    := frmBaixaCartoes.frxPagina;
    objCartoes.frxRelatorio := frmBaixaCartoes.frxRelatorio;
    objCartoes.frxListArq   := frmBaixaCartoes.frxListArq;
    objCartoes.frxSemRed    := frmBaixaCartoes.frxSemRed;
    objCartoes.frxTotBan    := frmBaixaCartoes.frxTotBan;
    objCartoes.frxTotalFinal := frmBaixaCartoes.frxTotalFinal;
    objCartoes.strNomCon    := UpperCase(strNomCon);

    frmBaixaCartoes.BaixaCartoesRelatorio.NomeConciliacao := objCartoes.strNomCon;

    frmPrincipal.Enabled := False;

    If objCartoes.fConciliaCartoes Then
    Begin
      objCartoes.cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
      objCartoes.cdsBaiCar.Filtered := True;

      If Assigned(frmBaixaCartoes.cdsBaiCar) Then
        FreeAndNil(frmBaixaCartoes.cdsBaiCar);

      frmBaixaCartoes.cdsBaiCar := CriarClientDataSet(objCartoes.cdsBaiCar);
      frmBaixaCartoes.cdsBaiCar.IndexFieldNames := objCartoes.cdsBaiCar.IndexFieldNames;

      frmBaixaCartoes.blnConcil    := True;
      frmBaixaCartoes.blnConRed    := False;
      frmBaixaCartoes.blnConML     := False;
      frmBaixaCartoes.blnGraAju    := objCartoes.blnGraAju;
      frmBaixaCartoes.blnInconsist := objCartoes.blnInconsist;
      frmBaixaCartoes.objConcil    := objCartoes.objConcil;

      frmBaixaCartoes.DataInicialConciliacao := objCartoes.DataInicialConciliacao;
      frmBaixaCartoes.DataFinalConciliacao   := objCartoes.DataFinalConciliacao;
      frmBaixaCartoes.ExibirCartoesPendente  := objCartoes.ExibirCartoesPendente;

      If objCartoes.blnResolverAPI Then
      Begin
        frmBaixaCartoes.cdsResolverAPI     := objCartoes.cdsResolverAPI;
        frmBaixaCartoes.cdsResolverAPICanc := objCartoes.cdsResolverAPICanc;
        frmBaixaCartoes.cdsWithDrawal      := objCartoes.cdsWithDrawal;
      End;

      frmBaixaCartoes.Caption      := 'Conciliação de Cartão de Crédito (' + UpperCase(strNomCon) + ')';

      frmBaixaCartoes.ShowModal;
    End;

    blnReabre := objCartoes.blnReabre;
    frmPrincipal.Enabled := True;
    FreeAndNil(objCartoes);
    FreeAndNil(frmBaixaCartoes);

    fLock_Unlock('CONCILIACAO_BAIXA_CARTOES_' + StringReplace(strNomCon.Trim, ' ', '_', [rfReplaceAll]), False);
  End;
end;

procedure TfrmPrincipal.pConfirmacaoDeCartoes;
begin
  If Assigned(TMenuLibCartoes.procOnClickConfirmacaoCartoes) Then
    TMenuLibCartoes.procOnClickConfirmacaoCartoes();
end;

procedure TfrmPrincipal.pConsultaCadLocEql;
Var
  chrKey: Char;
  arrCadEqlTmp: TConsultasArray;
  objfrmPnl : TPanelCxInfoEquLocacao;
  qryConsulta: TUniQuery;
  frmCadEquLocacao: TfrmCadEquLocacao;
begin
  inherited;

  chrKey := '/';

  pCriarFormularios(TfrmCadEquLocacao, frmCadEquLocacao);
  Try
    Try
      objfrmPnl := TPanelCxInfoEquLocacao.Create(TfrmPnlDadosEquLocacao);
      objfrmPnl.strNomForm := self.name;

      qryConsulta := fCriarQuery('SELECT * FROM CADEQL', Self);
      chrKey := '/';

      fPesqCadastroEquipLocacao(frmCadEquLocacao, Nil, Nil, qryConsulta, chrKey, arrCadEqlTmp, True, '', 0,0, objfrmPnl);

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[mnuConsultaCadLocEquClick]');
    End;
  Finally
    FreeAndNil(objfrmPnl);
    pFreeAndNil(frmCadEquLocacao);
  End;

end;

procedure TfrmPrincipal.pConsultaItem(frmSelf: TForm);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
    objfrmPnl: TPanelCxItem;
    objfrmPnlBanner: TPanelCxBanner;
    objfrmPreFiltroCarro: TPanelCxPreFiltro;
    strTabPre: String;
    strCfgBan: String;
    qryConsulta: TUniQuery;
begin
  strTabPre    :=  IIF(fEmptyStr(fCfgSis('TABPAD', varString)), '1', fCfgSis('TABPAD', varString));
  chrKey       := '/';

  Try
    objfrmPnl := TPanelCxItem.New();

    Try
      objFrmPnl.procMostraDocumentoReimpressao := pMostraDocumentoReimpressao;
      objFrmPnl.strNomForm := frmSelf.Name;
      objFrmPnl.recParametros.strCodCli  := '';
      objFrmPnl.strCodVen  := '';
      objFrmPnl.strCodDig  := '';
      objFrmPnl.intPraMedio:= 0;
      objFrmPnl.blnFaturamento := True;
      objFrmPnl.recParametros.strTabPre  := strTabPre;
      objfrmPnl.strNumOrc  := '';
      objfrmPnl.strEspOrc  := '';
      objFrmPnl.procExibeAgregados := TfrmAgregados.pExibe;
      objFrmPnl.procExibeRequisicaoCompra := TfrmFatRequisicaoCompras.pExibe;
      objFrmPnl.blnCndPag := (fCfgSis('PANITE', VarBoolean) And fCfgSis('CPDNPI', VarBoolean));
      objFrmPnl.procExibeCndPag := TfrmDigCndPagamentoEsp.pExibe;

      strCfgBan := fCfgSis('BANVEN', VarString);

      If (Pos('1', strCfgBan) > 0) Then
      Begin
        objfrmPnlBanner := TPanelCxBanner.Create(TfrmPnlBanner);
        objfrmPnlBanner.strTabPre := strTabPre;
      End;

      objfrmPreFiltroCarro := Nil;

      If fCfgSis('PROVEI', varBoolean) Then
        objfrmPreFiltroCarro := TPanelCxPreFiltro.Create(TfrmPnlPreFiltroCarro);

      qryConsulta := fCriaQuery(Nil);

      fPesqItem(conIteCompleta,
                frmSelf,
                Nil,
                Nil,
                qryConsulta,
                chrKey,
                arrSel,
                True,
                objfrmPnl,
                'Consulta de Produtos',
                strTabPre,
                '',
                0,
                false,
                false,
                -1, // SEGUE A CONFIGURAÇÃO DE ATIVOS
                cdrCodIte,
                '',
                False,   {* Se é pedido de compra                        *}
                '',
                '',
                True,
                False,
                True,
                '', // Codigo do Comprador
                False,
                False,
                False,
                False,
                False,
                False,
                False,
                False,
                '',
                -1,
                False,
                '',
                True,
                '',
                '',
                '',
                '',
                '',
                '',
                False,
                False,
                False,
                objFrmPnlBanner,
                objfrmPreFiltroCarro);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pConsultaItem]');
      End;
    End;

  Finally
    FreeAndNil(qryConsulta);
    FreeAndNil(objfrmPnl);

    If Assigned(objfrmPnlBanner) Then
      FreeAndNil(objfrmPnlBanner);

    If Assigned(objfrmPreFiltroCarro) Then
      FreeAndNil(objfrmPreFiltroCarro);
  End;
end;

procedure TfrmPrincipal.mnuRelCurvaAbcCidadeClick(Sender: TObject);
begin
  pRelatorioEstatisticas(relEstatAbcCidade);
end;

procedure TfrmPrincipal.mnuRelEstLibArmazenamentoClick(Sender: TObject);
begin
  pCriarForm(TfrmRelEstLibArmazenamento);
end;

procedure TfrmPrincipal.mnuAgendamentoCiclicoComDiaClick(
  Sender: TObject);
  Var
    frmAgendamentoCiclicoComDia : TfrmAgendamentoCiclicoComDia;
begin
  If SameText(fCfgSis('TELAGE'),'3') Then
  Begin
    mnuAgendamentoCiclicoComDia.Tag := 1;
    mnuAgendamentoCiclicoComDia.Visible := False;
    Exit;
  End;

  Try
    pCriarFormularios(TfrmAgendamentoCiclicoComDia, frmAgendamentoCiclicoComDia);

    Case StrToIntDef(fCfgSis('TELAGE'),0) Of
      1: frmAgendamentoCiclicoComDia.tagTipAge := taDiaInicio;
      2: frmAgendamentoCiclicoComDia.tagTipAge := taContinuo;
      4: frmAgendamentoCiclicoComDia.tagTipAge := taAutomatico;
    End;

    frmAgendamentoCiclicoComDia.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuAgendamentoCiclicoComDiaClick]');
    End;
  End;

  pFreeAndNil(frmAgendamentoCiclicoComDia);

end;

procedure TfrmPrincipal.mnuAgendamentosProgClick(Sender: TObject);
  Var
    frmConsultaServicosAutocenter : TfrmConsultaServicosAutocenter;
begin
  pCriarFormularios(TfrmConsultaServicosAutocenter, frmConsultaServicosAutocenter);
  Try
    frmConsultaServicosAutocenter.blnAgendamento := True;
    frmConsultaServicosAutocenter.Caption := 'Agendamentos Programados / Acompanhamento de Serviços';
    frmConsultaServicosAutocenter.ShowModal;
  Finally
    pFreeAndNil(frmConsultaServicosAutocenter);
  End;
end;

procedure TfrmPrincipal.mnuGeraAgendaCiclicoComDiaClick(Sender: TObject);
  Var
    frmAgendamentoCiclicoComDia : TfrmAgendamentoCiclicoComDia;
begin
  If StrToIntDef(fCfgSis('TELAGE'),0) In [1,2,4] Then
  Begin
    Try
      pCriarFormularios(TfrmGeraAgendaCiclicoComDia, frmGeraAgendaCiclicoComDia);

      Case StrToIntDef(fCfgSis('TELAGE'),0) Of
        1: frmGeraAgendaCiclicoComDia.tagTipAge := taDiaInicio;
        2: frmGeraAgendaCiclicoComDia.tagTipAge := taContinuo;
        4: frmGeraAgendaCiclicoComDia.tagTipAge := taAutomatico;
      End;

      frmGeraAgendaCiclicoComDia.ShowModal;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[mnuGeraAgendaCiclicoComDiaClick]');
      End;
    End;

    pFreeAndNil(frmGeraAgendaCiclicoComDia);

  End Else
  Begin
    Try
      pCriarFormularios(TfrmAgendamentoCiclicoComDia, frmAgendamentoCiclicoComDia);

      frmAgendamentoCiclicoComDia.tagTipAge := taManual;

      frmAgendamentoCiclicoComDia.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[mnuGeraAgendaCiclicoComDiaClick_1]');
      End;
    End;

    pFreeAndNil(frmAgendamentoCiclicoComDia);

  End;

end;

procedure TfrmPrincipal.mnuRelFatDocTintaClick(Sender: TObject);
begin
  If VS_strUsaTmq = 'S' Then
    pCriarForm(TfrmRelFatDocTinta)
  Else
    fMensagem('', 'DLL AutTin não encontrada! Verifique.', ['&OK']);
end;

procedure TfrmPrincipal.mnuAtendimentoClick(Sender: TObject);
begin
  pCriarForm(TfrmAtendimento);
end;

procedure TfrmPrincipal.mnuAtivaoeInativaodeNFCeOffLine1Click(Sender: TObject);
begin
  pCriarForm(TFrmAtivacaoInativacaoNFCeOFFLINE);
end;

procedure TfrmPrincipal.mnuFatAtivaPreRomaneioClick(Sender: TObject);
var
  frmFatAtivaPreRomaneio: TfrmFatAtivaPreRomaneio;
begin
  Try
    pCriarFormularios(TfrmFatAtivaPreRomaneio, frmFatAtivaPreRomaneio);
    frmFatAtivaPreRomaneio.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[]');
  End;

  pFreeAndNil(frmFatAtivaPreRomaneio);
end;

procedure TfrmPrincipal.mnuAtribOcorrEmergClick(Sender: TObject);
begin
  pCriarForm(TfrmAtribuicaoOcorrenciasEmergenciasCRM);
end;

procedure TfrmPrincipal.mnuAtualizacaoCotacaoDolarNosCatalogosClick(
  Sender: TObject);
begin
  pOpeProd(AtualizaDolarCatalogos);
end;

procedure TfrmPrincipal.mnuAtualizacaoMargemParaFranquiasClick(Sender: TObject);
begin
  pOpeProd(AtualizacaoMargemParaFranquia);
end;

procedure TfrmPrincipal.mnuAvaliacaoGarantiaPropriaEmpresaClick(Sender: TObject);
begin
  pCriarForm(TfrmAvaliacaoGarantiaPropriaEmpresa);
end;

procedure TfrmPrincipal.mnuRelTelListaAtendimentoClick(Sender: TObject);
begin
  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(68, 5170, [5172,5173],
                        ['CODEMP'],
                        [VS_STRCODEMP],
                        Sender,
                        nil,
                        False);
  End;
end;

procedure TfrmPrincipal.mnuRelTelMapaAtenClick(Sender: TObject);
begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(77, 5294, [5295,5296,5297],
                        [],
                        [],
                        Sender,
                        nil,
                        False);
  End;

end;

procedure TfrmPrincipal.mnuRemessaDevolucaoClick(Sender: TObject);
begin
  pCriarForm(TfrmFatRemessaDevolucao);
end;

procedure TfrmPrincipal.mnuGeracaoCodBarrasClick(Sender: TObject);
begin
  pOpeProd(GeracaoCodBarras);
end;

procedure TfrmPrincipal.mnuGeracaoPedidoTransferenciaAberturaNovaEmpresaClick(
  Sender: TObject);
begin
  pCriarForm(TfrmGeracaoPedidoTransferenciaAberturaNovaEmpresa);
end;

procedure TfrmPrincipal.mnuGeraDespesasProtestoClick(Sender: TObject);
begin
  pCriarForm(TfrmGeraDespesasProtesto)
end;

procedure TfrmPrincipal.mnuGeraDuplicataReceberClick(Sender: TObject);
begin
  Try
    TNewTimer.SuspendedTimers.Add('frmPrincipal');
    pCriarForm(TfrmGeraDuplicataReceber);
  Finally
    TNewTimer.SuspendedTimers.Remove('frmPrincipal');
  end;
end;


Procedure TfrmPrincipal.mnuProdutosAgregadosClick(Sender: TObject);
begin
  pOpeProd(ProdutosAgrupados);
end;

procedure TfrmPrincipal.mnuProfissionaisClick(Sender: TObject);
begin
  pCriarForm(TfrmEmailMarketingProfissionais);
end;

procedure TfrmPrincipal.mnuPromocaoAutAtivacaoClick(Sender: TObject);
begin
  pCriarForm(TfrmPromocoesAutAtivacao);
end;

procedure TfrmPrincipal.mnuPromocaoAutCadastroClick(Sender: TObject);
begin
  pCriarForm(TfrmCadPromocoesAut);
end;

procedure TfrmPrincipal.mnuProrrogaContratoLocEqClick(Sender: TObject);
Var
  frmCadContratoLocEquip: TfrmCadContratoLocEquip;
begin
  Try
    pCriarFormularios(TfrmCadContratoLocEquip, frmCadContratoLocEquip);
    frmCadContratoLocEquip.blnProrrogacao := True;
    frmCadContratoLocEquip.ShowModal;
  Finally
    pFreeAndNil(frmCadContratoLocEquip);
  End;
end;

procedure TfrmPrincipal.mnuManClubeFidelidadeClick(Sender: TObject);
begin
  pCriarForm(TfrmManClubeFidelidade);
end;

procedure TfrmPrincipal.mnuMandaeEnvioEncomendasClick(Sender: TObject);
  Var
    frmMandaeEnvioEncomendas: TfrmMandaeEnvioEncomendas;
begin
  Try
    pCriarFormularios(TfrmMandaeEnvioEncomendas, frmMandaeEnvioEncomendas);
    frmMandaeEnvioEncomendas.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuMandaeEnvioEncomendasClick]');
      Exit;
    End;
  End;
  pFreeAndNil(frmMandaeEnvioEncomendas);
end;

procedure TfrmPrincipal.mnuManDesIteClick(Sender: TObject);
begin
  pOpeProd(ManDesIte);
end;

procedure TfrmPrincipal.mnuSobreClick(Sender: TObject);
  Var
    frmSobre: TfrmSobre;
begin
  Try
    pCriarFormularios(TfrmSobre, frmSobre);
    frmSobre.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuSobreClick]');
    End;
  End;

  pFreeAndNil(frmSobre);

end;

procedure TfrmPrincipal.mnuSolicitacaodeAbastecimentodeTintasdeMaquinaClick(Sender: TObject);
begin
  Try
    Try
      frmEntregasFuturasTintas := TfrmEntregasFuturasTintas.Create(Self);
      frmEntregasFuturasTintas.ShowModal;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmEntregasFuturasTintas) then FreeAndNil(frmEntregasFuturasTintas);
  End;
end;

procedure TfrmPrincipal.mnuSolicitacaodeReposicaodeGondolaClick(
  Sender: TObject);
begin
  TGerenciaMovimentacaoGondola.pSolicitacaodeReposicaodeGondola;
end;

procedure TfrmPrincipal.mnuSolicitacaoManutencaoEquipamentosInternosClick(
  Sender: TObject);
begin
  pCriarForm(TfrmManutencaoEquipamentoInternoSolicitacao);
end;

procedure TfrmPrincipal.mnuSpoolTransferenciaEdicaoClick(Sender: TObject);
begin
  pGeraSpoolTransferenciaAutCom;
end;

procedure TfrmPrincipal.mnuFatBaixaPedidoDevClick(Sender: TObject);
begin
  pCriarForm(TfrmFatBaixaPedidoDev);
end;

procedure TfrmPrincipal.mnuCadSetoresFilizolaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadSetoresFilizola);
end;

procedure TfrmPrincipal.mnuEtiAvulsaClick(Sender: TObject);
begin
  pCriarForm(TfrmImpEtiquetaAvulsa);
end;

procedure TfrmPrincipal.mnuCadConsumidorClick(Sender: TObject);
begin
  pCriarForm(TfrmCadConsumidor);
end;

procedure TfrmPrincipal.mnuCadCorClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCor);
end;

procedure TfrmPrincipal.mnuCadCorrecaoOrdProducaoIndustrialClick(
  Sender: TObject);
begin
  pCriarForm(TfrmCadCorrecaoOrdProducaoIndustrial, frmCadCorrecaoOrdProducaoIndustrial);
end;

procedure TfrmPrincipal.mnuCadCorVeiClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCorVei);
end;

procedure TfrmPrincipal.mnuAgrupDuplicatasCtpClick(Sender: TObject);
begin
   pCriarForm(TfrmAgrupDuplicatasCtp);
end;

procedure TfrmPrincipal.mnuAgruPedOrdProIndClick(Sender: TObject);
begin
  pCriarForm(TfrmAgruPedOrdProInd);
end;

procedure TfrmPrincipal.mnuCadLocalArmazenamentoWMSClick(Sender: TObject);
begin
  pCriarForm(TfrmCadLocalArmazenamentoWms, frmCadLocalArmazenamentoWms);
end;

procedure TfrmPrincipal.mnuCadLocalDaMercadoriaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadLocalDaMercadoria);
end;

procedure TfrmPrincipal.mnuLocksTravadosClick(Sender: TObject);
begin
  pLocksTravados(True, True);
end;

procedure TfrmPrincipal.mnuLogAcompPedidosClick(Sender: TObject);
begin
  pCriarForm(TfrmLogAcompPedidos);
end;

procedure TfrmPrincipal.mnuLOGAlteraesEndereodeEntregaClick(Sender: TObject);
begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(203, 7592, [],
                        [],
                        [],
                        Sender,
                        nil,
                        False);
  End;

end;

procedure TfrmPrincipal.mnuLogoffClick(Sender: TObject);
  Var
    LfrmGravando: TfrmGravando;
begin
  utcRegistros.pLimparCampos;

  Try
    pCriarFormularios(TfrmGravando, LfrmGravando);
    try
      LfrmGravando.fExecutarAcao := fLogoff;
      LfrmGravando.ShowModal;
    finally
      pFreeAndNil(LfrmGravando);
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmPrincipal.mnuLotePrecosEfetivacaoClick(Sender: TObject);
begin
  pCriarForm(TfrmLotePrecosEfetivacaoCx);
end;

procedure TfrmPrincipal.mnuLoteRastreamentoProdutoClick(Sender: TObject);
begin
  pCriarForm(TfrmImprimeEtiquetaLoteRastreamentoProduto);
end;

procedure TfrmPrincipal.mnuCadRegioesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadRegioes);
end;

procedure TfrmPrincipal.mnuCadRegioesDescontoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadRegioesDesconto);
end;

procedure TfrmPrincipal.mnuCadRelatoriosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadRelatorios);
end;

procedure TfrmPrincipal.mnuCadDirVerdeVermelhoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadDirVerdeVermelho);
end;

procedure TfrmPrincipal.mnuCadRessarcimentoIcmsStCATClick(Sender: TObject);
begin
  pCriarForm(TfrmCadRessarcimentoIcmsStCAT,frmCadRessarcimentoIcmsStCAT);
end;

procedure TfrmPrincipal.mnuCadRestricaoVendaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadRestricaoVenda);
end;

procedure TfrmPrincipal.mnuDesagrupCtaPagClick(Sender: TObject);
begin
  pCriarForm(TFrmDesagrupCtaPag);
end;

procedure TfrmPrincipal.mnuRelCtpAgrupClick(Sender: TObject);
begin
  pRelatorioContasAPagar(relCtpAgrup);
end;

procedure TfrmPrincipal.mnuManutancaoDescontoEmbalagemClick(Sender: TObject);
begin
  pOpeProd(ManutancaoDescontoEmbalagem);
end;

procedure TfrmPrincipal.mnuManutancaoDescontoEmbalagemExcluirClick(
  Sender: TObject);
begin
  pOpeProd(ManutancaoDescontoEmbalagemExcluir);
end;

procedure TfrmPrincipal.mnuManutChqEmiClick(Sender: TObject);
begin
  pCriarForm(TfrmManutChqEmi);
end;

procedure TfrmPrincipal.mnuManutComProfissionaisClick(Sender: TObject);
var
  frmManComissaoProfissionais: TfrmManComissaoProfissionais;
begin
  Try
    pCriarFormularios(TfrmManComissaoProfissionais,frmManComissaoProfissionais);
    frmManComissaoProfissionais.strNomeForm := mnuManutComProfissionais.Hint;

    If fCfgSis('TCOPRO') = '4' Then
    Begin
      If fMensagem('','Selecione o tipo de Comissão de Profissional:', ['&Valor', '&Pontos']) = 1 Then
      Begin
        frmManComissaoProfissionais.VS_strTCoProInterna := '1';
        frmManComissaoProfissionais.Caption := frmManComissaoProfissionais.Caption + ' - VALOR ';
      End
      Else
      Begin
        frmManComissaoProfissionais.VS_strTCoProInterna := '3';
        frmManComissaoProfissionais.Caption := frmManComissaoProfissionais.Caption + ' - PONTOS ';
      End;
    End;

    frmManComissaoProfissionais.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmPrincipal.mnuManutComProfissionaisClick]');
    End;
  End;

  pFreeAndNil(frmManComissaoProfissionais);
end;

procedure TfrmPrincipal.mnuRelFiscTermoAbertClick(Sender: TObject);
begin
  pCriarForm(TfrmRelFiscTermoAbert);
end;

procedure TfrmPrincipal.mnuRelLiberacaoRemotaClick(Sender: TObject);
begin
  pCriarForm(TfrmRelLiberacaoRemota);
end;

procedure TfrmPrincipal.mnuCadBocaCaixaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadBocaCaixa);
end;

procedure TfrmPrincipal.mnuCadBoxWmsClick(Sender: TObject);
begin
  pCriarForm(TfrmCadBoxWms);
end;

procedure TfrmPrincipal.mnuRelCopiaChequeClick(Sender: TObject);
begin
  pCriarForm(TfrmRelCopiaCheque);
end;

procedure TfrmPrincipal.tmrMensagemTimer(Sender: TObject);
var
  LLogTmr: ILogTmr;
  intQtdMsg: Integer;
begin
  If (Not fPodeExecutarFuncaoDoTimer) Or (fOpcoesIgnorar) or (blnGerImpCTe) Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If Assigned(VS_objTraceViewer) Then
    VS_objTraceViewer.LogTimer('tmrMensagemTimer');

  LLogTmr := TLogTmr.New('tmrMensagemTimer').Enter('pAbreMensagem');

  TNewTimer.Del('frmPrincipal.tmrMensagem');

  intQtdMsg := fTemMensagem(strLoginUsuarioLogado);

  pExibeNotificacaoQtdMensagens(intQtdMsg);

  If intQtdMsg > 0  Then
    pAbreMensagem(tmrTemMsg);

  {*******************************************}
  {* VERIFICA SE EXIBE NOTIFICAÇÃO DE        *}
  {* EFETIVAÇÃO DE TABELA DE PREÇOS POR      *}
  {* FORNECEDOR                              *}
  {*******************************************}
  TfrmNotificaAtivacaoTabPreFor.pVerificaEfetivacao;

  LLogTmr.Exit;
end;

procedure TfrmPrincipal.tmrMonitorTimer(Sender: TObject);
{$I rev.inc}
var
  LLogTmr: ILogTmr;
begin
  If Not fPodeExecutarFuncaoDoTimer Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If Not VS_blnEmpLogadaPertenceBaseEmpFisica Then
    Exit;

  If fOpcoesIgnorar Then
    Exit;

  If (blnGerImpPdv) or (blnGerImpCTe) Then
    Exit;

  If (fCfgSis('LXRBSL', varString) <> 'S') Then
    If fQuantidadeRobosDeMonitaramentoExecutandoNestaEstacao >= fCfgSis('MAXROB', varInteger) Then
      Exit;

  If fEmptyStr(VS_strCodEmp) Then
    Exit;

  tmrMonitor.Enabled := False;

  If Assigned(VS_objTraceViewer) Then
    VS_objTraceViewer.LogTimer('tmrMonitorTimer');

  LLogTmr := TLogTmr.New('tmrMonitorTimer').Enter('TTipoMonitor.' +
    TRttiEnumerationType.GetName(TTipoMonitor(intNextMonitorId)));

  try
    Case TTipoMonitor(intNextMonitorId) Of
      tmMonitor_Auditoria:
      begin
        If blnHomologacao Then
          Exit;

        pMonitorAuditoria;
      end;
      tmMonitor_Entrega_Futura:
      begin
        If blnHomologacao Then
          Exit;

        If fCfgSis('ENTFUT', varBoolean) Then
          pMonitorEntregaFutura;
      end;
      tmMonitor_Status:
      begin
        If blnHomologacao Then
          Exit;

        If fCfgSis('EXISTA', varBoolean) Then
          pMonitorStatus;
      end;
      tmMonitor_Reserva_Item:
      begin
        If blnHomologacao Then
          Exit;

        If fCfgSis('SLTFRC', varBoolean) Then
          pMonitorReservaItem;
      end;
      tmMonitor_Lotes_WMS:
      begin
        If blnHomologacao Then
          Exit;

        If (fCfgSis('WMRBTP', varInteger) = 0) And fUsaRotinaWMS() And (fCfgSis('WMSSEP') = '2') And (fCfgSis('WMSROB') = 'S') Then
          pMonitorLotesWMS;
      end;
      TTipoMonitor.tmMonitor_Contabil:
      begin
        If blnHomologacao Then
          Exit;

        If fCfgSis('UTICON', varBoolean) and fCfgSis('CONONL', varBoolean) then
          TMenuContabilidade.MonitorContabil;
      end;
      TTipoMonitor.tmMonitor_PrecoTinta:
      begin
        If blnHomologacao Then
          Exit;

        if fCfgSis('TINPRE', varBoolean) and fCfgSis('USATMQ', varBoolean) then
          TConsultaPrecoTintaMonitor.ExecutarRobo;
      end;
      TTipoMonitor.tmMonitor_Fat_Automatico:
      begin
        If blnHomologacao Then
          Exit;

        If fCfgSis('FATAUT', varBoolean) Then
          TFaturamentoAutomatico.ExecutarRobo;
      end;
      TTipoMonitor.tmMonitor_Cancelador_Automatico:
      Begin
        If blnHomologacao Then
          Exit;
        If (fCfgSis('CANAUT', varString) = 'S') Then
          TCanceladorAutomaticoMonitor.ExecutarRobo;
      End;
      TTipoMonitor.tmMonitor_MonitorGatilhosInformacao:
      begin
        If blnHomologacao Then
          Exit;

        if not OperadorCitelLogado then
          TGatilhosInformacaoMonitor.ExecutarRobo;
      end;
      TTipoMonitor.tmMonitor_Desmembramento_Pedido_PIX:
      begin
        If blnHomologacao Then
          Exit;

        If fCfgSis('DMPPIX', varBoolean) Then
          TDesmembramentoPedidoRecebidoPIX.ExecutarRobo;
      end;
      TTipoMonitor.tmMonitor_Envio_Extrato_Cobranca:
      begin
        If blnHomologacao Then
          Exit;

        if untTExtratoCobranca.ExecutarRobo then
          ExecutaMonitorExtratoCobranca;
      end;
      TTipoMonitor.tmMonitor_Gera_Boletos:
      begin
        If blnHomologacao Then
          Exit;

        If untTMonitorGeraBoletos.ExecutarRobo Then
          untTMonitorGeraBoletos.TMonitorGeraBoletos.ExecutaMonitorGeraBoletos;
      end;
    end;
  finally
    Inc(intNextMonitorId);

    If intNextMonitorId > TTipoMonitor.Max Then
      intNextMonitorId := 0;

    tmrMonitor.Interval := RandomRange(TIMER_UM_MINUTO, fCfgSisL('INTROB', VarInteger) * 1000);
    tmrMonitor.Enabled := True;

    LLogTmr.Exit;
  end;
end;

procedure TfrmPrincipal.tmrGatimeTimer(Sender: TObject);
{$I rev.inc}
begin
  If Not fPodeExecutarFuncaoDoTimer Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If Not VS_blnEmpLogadaPertenceBaseEmpFisica Then
    Exit;

  If fOpcoesIgnorar Then
    Exit;

  If (blnGerImpCTe) Then
    Exit;

  If fEmptyStr(VS_strCodEmp) Then
    Exit;

  tmrGatime.Enabled := False;

  If (Assigned(VS_objTraceViewer)) Then
    VS_objTraceViewer.LogTimer('tmrGatimeTimer');

  try
    if not OperadorCitelLogado then
    begin
      if fMecanismoNotFicHabilitado then
      begin
        If (blnHomologacao) and (fGetRevisaoLock(Format(IdMonitorEnviarNotificacoes, [VS_strCodEmp])) < StrToIntDef(SVN_REVISION, 0)) Then
          pDestravaLockForcado(Format(IdMonitorEnviarNotificacoes, [VS_strCodEmp]), -1);

        TNotificacoesMonitor.ExecutarRobo;
      end;

      if fMecanismoGatImeHabilitado then
      begin
        If (blnHomologacao) and (fGetRevisaoLock(Format(IdMonitorGatilhosImediatosOperacional, [VS_strCodEmp])) < StrToIntDef(SVN_REVISION, 0)) Then
          pDestravaLockForcado(Format(IdMonitorGatilhosImediatosOperacional, [VS_strCodEmp]), -1);

        TDllGatime.ExecutarRoboOperacional;

        If (blnHomologacao) and (fGetRevisaoLock(Format(IdMonitorGatilhosImediatosComplementar, [VS_strCodEmp])) < StrToIntDef(SVN_REVISION, 0)) Then
          pDestravaLockForcado(Format(IdMonitorGatilhosImediatosComplementar, [VS_strCodEmp]), -1);

        TDllGatime.ExecutarRoboComplementar;
      end;
    end;
  finally
    tmrGatime.Interval := RandomRange(TIMER_TREZ_MINUTOS, fCfgSisL('TMRGAT', VarInteger) * 1000);
    tmrGatime.Enabled := True;
  end;
end;

procedure TfrmPrincipal.pMonitorEmail;
begin
  TUtilMonitor.pTestInactivity(spIdInactivityMonitorEmail,
                               spTimeLimitMonitorEmail,
                               VS_objProcessoMonitorEmail,
                               VS_dtaUltimaExecucaoMonitorEmail);

  TUtilMonitor.pRunMonitor(spIdMonitorEmail,
                           VS_objProcessoMonitorEmail,
                           VS_dtaUltimaExecucaoMonitorEmail,
                           spEnviaEmailBoletoExeName,
                           NO_PARAMS);

  TUtilMonitor.pClearAttemptsLock(Format(spIdMonitorEmail, [VS_strCodEmp]),
                                  spAttemptsLockMonitorEmail);
end;

procedure TfrmPrincipal.pMonitorEmailCobrançaEletronica;
begin
  TUtilMonitor.pTestInactivity(spIdInactivityMonitorEmail,
                               spTimeLimitMonitorEmail,
                               VS_objProcessoMonitorEmail,
                               VS_dtaUltimaExecucaoMonitorEmail);

  TUtilMonitor.pRunMonitor(spIdMonitorEmail,
                           VS_objProcessoMonitorEmail,
                           VS_dtaUltimaExecucaoMonitorEmail,
                           spEnviaEmailBoletoExeName,
                           Format(SP_DISPARO_COBRANCA_ELETRONICA_PARAMS, [VS_strCodEmp]));

  TUtilMonitor.pClearAttemptsLock(Format(spIdMonitorEmail, [VS_strCodEmp]),
                                  spAttemptsLockMonitorEmail);
end;

procedure TfrmPrincipal.pMonitorEntregaFutura;
begin
  If (fCfgSis('LXRBSL', varString) = 'S') Then
    Exit;

  TUtilMonitor.pTestInactivity(spIdInactivityMonitorEntFut,
                               spTimeLimitMonitorEntFut,
                               VS_objProcessoMonitorEntregaFutura,
                               VS_dtaUltimaExecucaoMonitorEntregaFutura);

  TUtilMonitor.pRunMonitor(spIdMonitorEntFut,
                           VS_objProcessoMonitorEntregaFutura,
                           VS_dtaUltimaExecucaoMonitorEntregaFutura,
                           spRecalculoEntregaFuturaExeName,
                           NO_PARAMS);

  TUtilMonitor.pClearAttemptsLock(Format(spIdMonitorEntFut, [VS_strCodEmp]),
                                  spAttemptsLockMonitorEntFut);
end;

procedure TfrmPrincipal.pMonitorLotesWMS;
begin
  TUtilMonitor.pTestInactivity(spIdInactivityMonitorLotWMS,
                               spTimeLimitMonitorLotWMS,
                               VS_objProcessoMonitorLotWMS,
                               VS_dtaUltimaExecucaoMonitorLotWMS);

  TUtilMonitor.pRunMonitor(spIdMonitorLotWMS,
                           VS_objProcessoMonitorLotWMS,
                           VS_dtaUltimaExecucaoMonitorLotWMS,
                           spLotWMSMonitorExeName,
                           spLotWMSMonitorExeParam);

  TUtilMonitor.pClearAttemptsLock(Format(spIdMonitorLotWMS, [VS_strCodEmp]),
                                  spAttemptsLockMonitorLotWMS);
end;

procedure TfrmPrincipal.pModCartaCob;
begin
  pCriarForm(TfrmCfgModCartaCob);
end;

procedure TfrmPrincipal.pModContratoServico;
begin
  pCriarForm(TfrmCfgModContrato);
end;

procedure TfrmPrincipal.pModCartaExtrajudicial;
begin
  pCriarForm(TfrmCfgModCartaExtrajudicial);
end;

procedure TfrmPrincipal.pMonitorAuditoria;
begin
  If (fCfgSis('LXRBSL', varString) = 'S') Then
    Exit;

  TUtilMonitor.pTestInactivity(spIdInactivityMonitorAudit,
                               spTimeLimitMonitorAudit,
                               VS_objProcessoMonitorAudit,
                               VS_dtaUltimaExecucaoMonitorAudit);

  TUtilMonitor.pRunMonitor(spIdMonitorAudit,
                           VS_objProcessoMonitorAudit,
                           VS_dtaUltimaExecucaoMonitorAudit,
                           spRecalculoSaldoReservadoExeName,
                           NO_PARAMS);

  TUtilMonitor.pClearAttemptsLock(Format(spIdMonitorAudit, [VS_strCodEmp]),
                                  spAttemptsLockMonitorAudit);
end;

procedure TfrmPrincipal.pMonitorReservaItem;
begin
  If (fCfgSis('LXRBSL', varString) = 'S') Then
    Exit;

  TUtilMonitor.pTestInactivity(spIdInactivityMonitorReservaItem,
                               spTimeLimitMonitorReservaItem,
                               VS_objProcessoMonitorReservaItem,
                               VS_dtaUltimaExecucaoMonitorReservaItem);

  TUtilMonitor.pRunMonitor(spIdMonitorReservaItem,
                           VS_objProcessoMonitorReservaItem,
                           VS_dtaUltimaExecucaoMonitorReservaItem,
                           spReservaItemPedidoMonitorExeName,
                           NO_PARAMS);

  TUtilMonitor.pClearAttemptsLock(Format(spIdMonitorReservaItem, [VS_strCodEmp]),
                                  spAttemptsLockMonitorReservaItem);
end;

procedure TfrmPrincipal.pMonitorStatus;
begin
  If (fCfgSis('LXRBSL', varString) = 'S') Then
    Exit;

  TUtilMonitor.pTestInactivity(spIdInactivityMonitorSta,
                               spTimeLimitMonitorStatus,
                               VS_objProcessoMonitorStatus,
                               VS_dtaUltimaExecucaoMonitorStatus);

  TUtilMonitor.pRunMonitor(spIdMonitorStatus,
                           VS_objProcessoMonitorStatus,
                           VS_dtaUltimaExecucaoMonitorStatus,
                           spStatusMonitorExeName,
                           NO_PARAMS);

  TUtilMonitor.pClearAttemptsLock(Format(spIdMonitorStatus, [VS_strCodEmp]),
                                  spAttemptsLockMonitorSt);
end;

procedure TfrmPrincipal.tmrProjetosAtrasadoOnTimer(Sender: TObject);
var
  LLogTmr: ILogTmr;
begin
  If (Not fPodeExecutarFuncaoDoTimer) Or (fOpcoesIgnorar) or (blnGerImpCTe) Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  LLogTmr := TLogTmr.New('tmrProjetosAtrasadoOnTimer').Enter('pProjetosAtrasado');

  tmrProjetosAtrasado.Enabled := False;

  TNewTimer.Del('frmPrincipal.tmrProjetosAtrasado');

  pProjetosAtrasado;

  LLogTmr.Exit;
end;

procedure TfrmPrincipal.tmrQuestFidelidadeOnTimer(Sender: TObject);
var
  LLogTmr: ILogTmr;
begin
  if (blnGerImpCTe) then
    Exit;

  if fCfgSis('PONQUE', varBoolean) then
  begin
    If Assigned(VS_objTraceViewer) Then
      VS_objTraceViewer.LogTimer('tmrQuestFidelidadeTimer');

    LLogTmr := TLogTmr.New('tmrQuestFidelidadeTimer').Enter('pControlaQuestFidelidade');

    tmrQuestFidelidade.Enabled := False;
    pControlaQuestFidelidade;
    tmrQuestFidelidade.Enabled := True;

    LLogTmr.Exit;
  end;
end;

procedure TfrmPrincipal.btnMensagemClick(Sender: TObject);
  Var
    frmMsg: TfrmCadMsg;
begin
  Try
    pCriarFormularios(TfrmCadMsg, frmMsg);
    frmMsg.tmrTemMsg   := tmrTemMsg;
    frmMsg.Tag         := 0;
    frmMsg.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[Criar Formulário de Mensagens]');
      Exit;
    End;
  End;

  pFreeAndNil(frmMsg);
  Windows.setFocus(0);
  If Assigned(tmrTemMsg)Then
    tmrTemMsg.Enabled := True;
end;

procedure TfrmPrincipal.btnRelFatMetasVendedor_DirClick(Sender: TObject);
begin
  If (fVerificaAcessoSistema('frm505952Rel')) Then
  Begin
    pRelFatMetasVendedor(nil, True);
    //mnuRelFatMetasVendedorClick(btnRelFatMetasVendedor_Dir);
  End
  Else
  Begin
    fMensagem('', 'Esse usuário não tem direito a acessar esse módulo!', ['&Ok']);
  End;
  Windows.setFocus(0);
end;

procedure TfrmPrincipal.untCadMsgClick(Sender: TObject);
  Var
    frmMsg: TfrmCadMsg;
begin
  Try
    pCriarFormularios(TfrmCadMsg, frmMsg);
    frmMsg.tmrTemMsg   := tmrTemMsg;
    frmMsg.Tag         := 0;
    frmMsg.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[Criar Formulário de Mensgens]');
      Exit;
    End;
  End;

  pFreeAndNil(frmMsg);
  If Assigned(tmrTemMsg)Then
    tmrTemMsg.Enabled := True;
end;

function TfrmPrincipal.UtilizarRoboDeAvisoDeCobraca: Boolean;
  Var
    LFeriadoFimDeSemana : TFeriadoFimDeSemana;
begin
  If OperadorCitelLogado Then
    Exit(False);

  TEmailAutController.CarregarModelosAvisosCobrancaEmailSMSWppAtivos;

  Result := fCfgSis('BOLAVI', varBoolean); // Enviar e-mails e/ou SMS de avisos de cobrança?
  If Result Then
  Begin
    //Não enviar com 997, 998 e 999
    If MatchStr(strLoginUsuarioLogado, ['997', '998', '999']) Then
    Begin
      If Not fArqIni(0, 'BANCO', 'NOMBAN', '').Equals(fCfgSis('EMABAS')) Then
        Exit(False);
    End;

    //Enviar boletos de cobrança Sábado/Domingo/Feriado?
    If Not fCfgSis('AVIUTI', varBoolean) Then
    Begin
      LFeriadoFimDeSemana := fBuscaProxDiaUtil(VS_Date,VS_strCodEmp);
      If Not LFeriadoFimDeSemana.blnDAtaEDiaUtil Then
      Begin
        Result := False;
      End;
    End;

    // Está dentro do horário previsto para execução dos envio ?
    If Not HorarioExecutaRobo(fCfgSis('HORAVI', varString)) Then
      Result := False;
  End;

end;

procedure TfrmPrincipal.AtualizaTefCitel(ARetorno: IRetornoTEFCitel);
  var
    FrmTefCitelInfoMsg : TFrmTefCitelInfoMsg;
begin
  if fVerificaMsgTefCitel(ARetorno.StatusTEF.strMensagem) then
  begin
    try
      pCriarFormularios(TFrmTefCitelInfoMsg, FrmTefCitelInfoMsg);
      FrmTefCitelInfoMsg.lbStatusTef.Caption := ARetorno.StatusTEF.strMensagem;
      FrmTefCitelInfoMsg.ShowModal;
    finally
      pFreeAndNil(FrmTefCitelInfoMsg);
    end;
  end
  else
  begin
    pMostraMensTEF(Self,ARetorno.StatusTEF.strMensagem);
    hraMensagemTEF := fTime(True);
  end;
end;

procedure TfrmPrincipal.mnuRelatorioAcompanhamentoPixClick(Sender: TObject);
  Var
    LRelatorioAcompanhamentoPix: TfrmRelatorioAcompanhamentoPix;
begin
  LRelatorioAcompanhamentoPix := Nil;
  pCriarForm(TfrmRelatorioAcompanhamentoPix, LRelatorioAcompanhamentoPix);
end;

procedure TfrmPrincipal.ValidacaoCertificadosPix;
  Var
    LContasPix: String;
begin
  LContasPix := TFuncoesPixAutcom.RetornaContasBancariasComCertificadosAVencerVencidos;

  If LContasPix.IsEmpty Then
    Exit;

  TfrmMemo.pShowMessage(LContasPix, 18);
end;

function TfrmPrincipal.VerificaAcessoSistema(strNomeForm,
  strCodOpe: String): Boolean;
begin
  Result := fVerificaAcessoSistema(strNomeForm, strCodOpe);
end;

procedure TfrmPrincipal.VerificaConfiguracaoForcarEmail;
  Var
    LForcarEnvioEmail: String;

    LNomeBanco: String;
begin
  LNomeBanco := Trim(fCfgSis('EMABAS', varString));
  If LNomeBanco.IsEmpty Then
    LNomeBanco := 'AUTCOM';

  LForcarEnvioEmail := fArqIni(0, 'GERAL', 'FORCAR_ENVIO_EMAIL', '');
  if LForcarEnvioEmail.IsEmpty Then
  Begin
    fArqIni(1, 'GERAL', 'FORCAR_ENVIO_EMAIL', 'N');
    LForcarEnvioEmail := 'N';
  End;

  VS_PermitidoEnviarEmail := fArqIni(0, 'BANCO', 'NOMBAN', '').Equals(LNomeBanco);
  If Not VS_PermitidoEnviarEmail Then
    VS_PermitidoEnviarEmail := LForcarEnvioEmail.Equals('S');
end;

procedure TfrmPrincipal.VerificarSeAutTinEstaAberto;
begin
  If blnUsuarioLogadoUtilizaModoClassico Then
  Begin
    While (FindWindow(Nil, PChar('AutTin')) > 0) Do
    Begin
      Application.ProcessMessages;
      Sleep(100);
    End;
  End
  Else
  Begin
    While (ProcessExists('AutTin.exe')) Do
    Begin
      Application.ProcessMessages;
      Sleep(100);
    End;
  End;
end;

function TfrmPrincipal.Versao: String;
begin
  Result := fPADR(TVersaoExecutavel.GetVersaoArquivo, 20);
end;

procedure TfrmPrincipal.mnuADMAdministracaoTEFClick(Sender: TObject);
Var
  frmTefCitelAdministracao : TfrmTefCitelAdministracao;
begin
  if Assigned(VS_objTef) then
    VS_objTef.fTef_Adm
  else if (VS_blnTefCitel) or fExibeMenuAdmTef then
  begin
    try
      pCriarFormularios(TfrmTefCitelAdministracao, frmTefCitelAdministracao);
      if VS_blnTefCitel then
        objTefCitel.AdicionaObserver(frmTefCitelAdministracao);
      frmTefCitelAdministracao.ShowModal;
    finally
      if VS_blnTefCitel then
        ObjTefCitel.RemoveObserver(frmTefCitelAdministracao);
      pFreeAndNil(frmTefCitelAdministracao);
    end;
  end
  Else
    fMensagem('Atenção', 'Não foi possível comunicar com o TEF. Favor verificar as configurações do Client TEF.', ['&OK']);
end;

procedure TfrmPrincipal.FormPaint(Sender: TObject);
begin
  If (fOpcoesIgnorar) Then
    Exit;

  pVerificaTEF;

  If blnFecharForm Then
    Close;
end;

procedure TfrmPrincipal.FormResize(Sender: TObject);
begin
  If (fOpcoesIgnorar) Then
    Exit;

  fraPesquisarMenu.Height := pnlEsquerda.Height;
  fraPesquisarMenu.Width  := pnlEsquerda.Width;

  fraPesquisarMenu.pAjustarPesquisa;
end;

procedure TfrmPrincipal.btnDASSuvinilClick(Sender: TObject);
var Posicao: TPoint;
begin
  GetCursorPos(Posicao);
  popDASSuvinil.Popup(Posicao.X + 40,Posicao.Y);
  Windows.setFocus(0);
end;

procedure TfrmPrincipal.btnEnvioEmailClick(Sender: TObject);
begin
  pCriarForm(TfrmConsultaMensagemEmail);
end;

procedure TfrmPrincipal.mnuRelComissaoVendedorCTRClick(Sender: TObject);
var
  LfrmRelComissaoVendedorCTR: TfrmRelComissaoVendedorCTR;
  LfrmRelComissaoVendedorCTRMod2: TfrmRelComissaoVendedorCTRMod2;
begin
  LfrmRelComissaoVendedorCTR := nil;
  LfrmRelComissaoVendedorCTRMod2 := nil;
  If Pos(fCfgSis('RELCT2', varString), '1_4_') > 0 Then
    pCriarForm(TfrmRelComissaoVendedorCTR, LfrmRelComissaoVendedorCTR)
  Else
    pCriarForm(TfrmRelComissaoVendedorCTRMod2, LfrmRelComissaoVendedorCTRMod2);
end;

procedure TfrmPrincipal.mnuRelComissaoProfissionalCTRClick(
  Sender: TObject);
begin
  pCriarForm(TfrmRelComissaoProfissionalCTR);
end;

procedure TfrmPrincipal.mnuCadTabelaPrecosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadTabelaPrecos);
end;

procedure TfrmPrincipal.mnuCadTelefoneContatoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadTelefoneContato);
end;

procedure TfrmPrincipal.mnuCalEstMinClick(Sender: TObject);
begin
  pCriarForm(TfrmCalEstMin);
end;

procedure TfrmPrincipal.mnuConsultaFatCatalogoClick(Sender: TObject);
begin
  pCriarForm(TfrmConsultaFatCatalogo);
end;

procedure TfrmPrincipal.mnuConsultaFatCobrancaEletronicaClick(Sender: TObject);
begin
  pCriarForm(TfrmConsultaFatCobrancaEletronica, frmConsultaFatCobrancaEletronica);
end;

procedure TfrmPrincipal.mnuConsultaFatLogPromocaoClick(Sender: TObject);
begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(66, 5141, [],
                        [],
                        [],
                        Sender,
                        nil,
                        False);
  End;

end;

procedure TfrmPrincipal.mnuImportaSPEDFiscalClick(Sender: TObject);
begin
  pCriarForm(TfrmImportaSPEDFiscal);
end;

procedure TfrmPrincipal.mnuImportaSPEDPISCOFINSClick(Sender: TObject);
begin
  pCriarForm(TfrmImportaSPEDPISCOFINS);
end;

procedure TfrmPrincipal.mnuImportCatalogoPrecoClick(Sender: TObject);
begin
  pOpeProd(ImportCatalogoPreco);
end;

procedure TfrmPrincipal.mnuImportComisVendTabPrecoClick(Sender: TObject);
begin
  pOpeProd(ImportComisVendTabPreco);
end;

procedure TfrmPrincipal.mnuImportMargemLucroTabPrecoClick(Sender: TObject);
begin
  pOpeProd(ImportMarBruTabPreco);
end;

procedure TfrmPrincipal.mnuImportPrecoVendaTabPrecoConfirmaClick(
  Sender: TObject);
begin
  pOpeProd(ImportPreVenTabPreco);
end;

procedure TfrmPrincipal.mnuImportProdutoVeiculoClick(Sender: TObject);
begin
  pCriarForm(TfrmImportProdutoVeiculo, frmImportProdutoVeiculo);
end;

procedure TfrmPrincipal.mnuRelFatFichaTecnicaProdutosOrcamentoClick(Sender: TObject);
begin
  pCriarForm(TfrmRelFatFichaTecnicaProdutosOrcamento);
end;

procedure TfrmPrincipal.mnuBaixaBocaCaixaClick(Sender: TObject);
begin
  pCriarForm(TfrmBaixaBocaCaixa);
end;

procedure TfrmPrincipal.mnuFatBaixaRomaneioClick(Sender: TObject);
begin
  If Pos(VS_strCodEmp ,fCampoTabela('OPE_EMPROM', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado])) > 0 Then
    pCriarForm(TfrmFatBaixaRomaneio, frmFatBaixaRomaneio)
  Else
    pMensagemOk('Usuário sem direto de acesso a baixa de romaneio (Configuração no Cadastro de Operadores)!');
end;

procedure TfrmPrincipal.mnuRelFatBocaCaixaVendedorClick(Sender: TObject);
begin
  pRelatorioFaturamento(relFatBocaCaixaVendedor);
end;

procedure TfrmPrincipal.pExibiBotoes;
  Var
    blnUsaDAS: Boolean;
Begin
  pEscondeBotoes;

  If Not (fVerificaAcessoSistema(mnuCadClientes.Hint)) Then
    btnCadClientes.Visible := False
  Else
    btnCadClientes.Visible := True;

  If popProdutos.Items.Count = 0 Then
    btnCadItens.Visible := False
  Else
    btnCadItens.Visible := True;

  If popMovItens.Items.Count = 0 Then
    btnMovItens.Visible := False
  Else
    btnMovItens.Visible := True;

  {****************************************}
  {* BOTOES - VERIFICA SE EXIBE OU NO    *}
  {*************************************LU*}
  If popFaturamento.Items.Count = 0 Then
    btnFaturamento.Visible := False
  Else
    btnFaturamento.Visible := True;

  btnResumoCaixa.Visible := mnuFatResumoCaixa.Visible and fVerificaAcessoSistema(mnuFatResumoCaixa.Hint);

  If popFinanceiro.Items.Count = 0 Then
    btnFinanceiro.Visible := False
  Else
    btnFinanceiro.Visible := True;

  If popLocacaoEquipamento.Items.Count = 0 Then
    btnLocacaoEquipamento.Visible := False
  Else
    btnLocacaoEquipamento.Visible := True;

  btnWMS.Visible := fHabilitarAtalhoWMS;

  btnMensagem.Visible := True;

  If VS_strUsaTmq = 'S' Then
  Begin
    If Not (fVerificaAcessoSistema(mnuTintaDeMaquina.Hint)) And Not (fVerificaAcessoAutTin(mnuTintaDeMaquina.Hint, mnuTintaDeMaquina.Name)) Then
     btnTintaMaquina.Visible := False
  Else
    btnTintaMaquina.Visible := True;
  End;

  If Not (fVerificaAcessoSistema('frm505952Rel')) Then
    btnRelFatMetasVendedor_Dir.Visible := False
  Else
    btnRelFatMetasVendedor_Dir.Visible := True;

  If popDASSuvinil.Items.Count = 0 Then
    btnDASSuvinil.Visible := False
  Else
  Begin
    blnUsaDAS := (fCfgSis('USADAS', varBoolean));
    If (VS_strUsaTmq = 'S')                         And
       (fGetConfTinta('SUV').fGetBoolean('USATIN')) And
       (blnUsaDAS)                                  And
       (fVerificaAcessoSistema('mnuDASSuvinil'))    Then
    Begin
      btnDASSuvinil.Visible := True;
    End;
  End;

  {****************************************}
  {* SÓ IRÁ MOSTRAR O BOTÃO SE O VENDEDOR *)
  {* TIVER META NO MES E ANO ATUAL.       *}
  {*************************************PZ*}
  If (btnRelFatMetasVendedor_Dir.Visible) And ((fRetMetasVendedorMes(strLoginUsuarioLogado, FormatDateTime('MMYYYY', VS_Date))) <= 0) Then
    btnRelFatMetasVendedor_Dir.Visible := False;

  btnPesar.Visible  := mnuBalancas.Visible;
  btnCRM.Visible    := mnuCRM.Visible;

  btnEnvioEmail.Visible := True;
  btnCitelDesk.Visible := mnuCitelDesk.Visible And mnuCitelDesk.Enabled;

  If Not (fVerificaAcessoSistema(mnuCadConfiguracoes.Hint)) Then
    btnConfiguracoes.Visible := False
  Else
    btnConfiguracoes.Visible := True;

  btnSair.Visible := True;

  btnCadClientes.Align := alTop;
  btnCadItens.Align := alTop;
  btnMovItens.Align := alTop;
  btnFaturamento.Align := alTop;
  btnResumoCaixa.Align := alTop;
  btnFinanceiro.Align := alTop;
  btnWMS.Align := alTop;

  btnMensagem.Align := alTop;
  btnTintaMaquina.Align := alTop;
  btnRelFatMetasVendedor_Dir.Align := alTop;
  btnDASSuvinil.Align := alTop;
  btnPesar.Align := alTop;
  btnCrm.Align := alTop;
  btnLocacaoEquipamento.Align := alTop;

  fraPesquisarMenu.btnDashboard.Visible := mnuDashboard.Visible;
End;

procedure TfrmPrincipal.pInicializacaoFinalizacaoDicConfigInicial(const blnFinaliza: Boolean=False);

   procedure pIniciaFinalizaDicConfigInicialAutcom(const blnFinaliza: Boolean=False);
   begin
     If (blnFinaliza) Then
     Begin
       If (Assigned(untFuncoesSimples.dicConfigInicial)) Then
         FreeAndNil(untFuncoesSimples.dicConfigInicial);

       If (Assigned(untFuncoesSimples.dicConfiguracoes)) Then
       Begin
         untFuncoesSimples.dicConfiguracoes.Clear;
         untFuncoesSimples.dicConfiguracoes.TrimExcess;
       End;
     End
     Else
     Begin
       If (Assigned(untFuncoesSimples.dicConfigInicial)) Then
       Begin
         untFuncoesSimples.dicConfigInicial.Clear;
         untFuncoesSimples.dicConfigInicial.TrimExcess;
       End
       Else
         untFuncoesSimples.dicConfigInicial := TDictionary<string,boolean>.Create
     End;
   end;

begin
  If VS_AutcomIniciadoModoRobo Then
    Exit;

  TMenuLibCartoes.CarregaDllLibCartoes;

  pIniciaFinalizaDicConfigInicialAutcom(blnFinaliza);

  If Assigned(pIniciaFinalizaDicConfigInicialAutcomTinta) Then
    pIniciaFinalizaDicConfigInicialAutcomTinta(blnFinaliza);

  If Assigned(pIniciaFinalizaDicConfigInicialAutTin) Then
    pIniciaFinalizaDicConfigInicialAutTin(blnFinaliza);
end;

function TfrmPrincipal.fRetCfgRelacionadaArquivo(strNomArq: string): string;
begin
  Result := TfrmCfgRepositorio.pRetCfgRelacionadaArquivo(strNomArq);
end;

procedure TfrmPrincipal.pGravaConfiguracoesUsadasLogin;
begin
  If Assigned(dicConfigInicial) Then
  Begin
    //GRAVA AS CONFIGURAÇÕES USADAS NO LOGIN POR CADA PROJETO PARA QUE OUTROS EXECUTÁVEIS GANHEM TEMPO
    If Assigned(dicConfigInicial) Then
      pGravaConfiguraoesInicializacao(fGetConexao, dicConfigInicial);

    If Assigned(fRetornaDicConfigInicialAutcomTinta) Then
      pGravaConfiguraoesInicializacao(fGetConexao, fRetornaDicConfigInicialAutcomTinta);

    If Assigned(fRetornaDicConfigInicialAutTin) Then
      pGravaConfiguraoesInicializacao(fGetConexao, fRetornaDicConfigInicialAutTin);

    pInicializacaoFinalizacaoDicConfigInicial(True); //Para matar todos os dicConfigInicial
  End;
end;

procedure TfrmPrincipal.pExibirNovaTelaPrincipalAutcom;
begin
  {$IFDEF  TESTABILIDADE_AUTCOM}
  Exit;
  {$Else}
  If blnUsuarioLogadoUtilizaModoClassico Then
    Exit;

  Self.Left := Screen.WorkAreaLeft;
  Self.Top := Screen.WorkAreaTop;
  Self.Height := Screen.WorkAreaHeight;
  Self.Width := Screen.WorkAreaWidth;

  ShowWindow(Self.Handle, SW_HIDE);

  Try
    Principal.View.FMXPrincipal.ExibirNovaTelaPrincipalAutcom(Self);
  Finally
    TNewTimer.SuspendedTimers.Add('frmPrincipal');
    pFinalizaObjetos;
    pTerminate;
  End;
  {$ENDIF}
end;

procedure TfrmPrincipal.mnuCodigoTipodeServicoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCodTipoServico);
end;

procedure TfrmPrincipal.mnuComissaoDepartamentoClick(Sender: TObject);
begin
  pCriarForm(TfrmComissaoDepartamento);
end;

procedure TfrmPrincipal.mnuComissaoLinhaClick(Sender: TObject);
begin
  pCriarForm(TfrmComissaoLinha);
end;

procedure TfrmPrincipal.mnuConsultaCadLocEquClick(Sender: TObject);
begin
  pConsultaCadLocEql;
end;

procedure TfrmPrincipal.mnuConsultaControleDeColetaClick(Sender: TObject);
begin
  pCriarForm(TfrmConsultaControleDeColeta);
end;

procedure TfrmPrincipal.mnuConsultadeSaldodeContasBancriasClick(
  Sender: TObject);
begin
  untFuncoesInicializarLibContasBancarias.
   TLibContasBancarias.
    ConsultarSaldoContaBancaria;
end;

procedure TfrmPrincipal.mnuConsultaFatCatalogoAlteracaoClick(
  Sender: TObject);
Var
    frmConsultaFatCatalogo : TfrmConsultaFatCatalogo;
begin
  Try
    pCriarFormularios(TfrmConsultaFatCatalogo,frmConsultaFatCatalogo);
    frmConsultaFatCatalogo.blnEditar := TRUE;
    frmConsultaFatCatalogo.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuConsultaFatCatalogoAlteracaoClick]');
    End;
  End;

  pFreeAndNil(frmConsultaFatCatalogo);

end;

procedure TfrmPrincipal.mnuRelComissaoVendedorManualCTRClick(
  Sender: TObject);
begin
  pCriarForm(TfrmRelComissaoVendedorManualCTR);
end;

procedure TfrmPrincipal.pOrdenaMenusPosteriorLogOff;
  Var
    item: TMenuItem;
begin
  For item In mnuAutcomK.Items Do
    If item.MenuIndex > mnuLogoff.MenuIndex Then
      pOrdenaMenu(item, False, True);
end;

procedure TfrmPrincipal.pOrdenaMenu(mniMenu: TMenuItem; blnInsRisco: Boolean; blnOrdSubMenus : Boolean = False);
  Const
    STR_NAO_ORDENA_MENUS = 'mnuTXTsFullSoft_mnuBalancoEstoque_';

  procedure pRemoverRiscos;
    Var
      intContador: Integer;
  begin
    if Not blnInsRisco then exit;
    intContador := 0;
    while intContador < mniMenu.Count do
    begin
      if mniMenu.Items[intContador].Caption = '-' then
        mniMenu.Remove(mniMenu.Items[intContador]);
      Inc(intContador);
    end;
  end;

  procedure pInserirRisco;
    Var
      mnuNovo: TMenuItem;
      intContador: Integer;
  begin
    if Not blnInsRisco then exit;
    intContador := 1;
    while intContador < mniMenu.Count Do
    begin
      mnuNovo := TMenuItem.Create(mniMenu);
      mnuNovo.Caption := '-';
      mnuNovo.Name := 'R' + IntToStr(intContador);
      mniMenu.Insert(intContador, mnuNovo);
      Inc(intContador, 2);
    end;
  end;

  procedure pOrdenarItens;
    var
      index: Integer;
      item: TMenuItem;
      stlOrdem: TStringList;
      mnuAnt: String;
      mnuCap: String;
      itemNovRel: TMenuItem;
  begin
    stlOrdem := TStringList.Create;
    stlOrdem.BeginUpdate;
    itemNovRel := Nil;
    Try
      for item in mniMenu do
      begin
        if (Item.Caption = MOME_MENU_CRIAREL) then
          itemNovRel := Item;

        mnuCap := AnsiReplaceStr(Item.Caption, '&', '');
        if (not blnInsRisco) And (mnuCap = '-') And (mnuAnt <> '') then
          mnuCap := mnuAnt+'Z';

        stlOrdem.AddObject(mnuCap, item);
        if blnOrdSubMenus then
          if item.Count > 0 then
            if Pos(item.Name, STR_NAO_ORDENA_MENUS) <= 0 then
              pOrdenaMenu(item, False, True);

        mnuAnt := item.Caption;
      end;

      stlOrdem.CaseSensitive := True;
      stlOrdem.Sort;

      for index := stlOrdem.Count -1 downto 0 do
      begin
        item := TMenuItem(stlOrdem.Objects[index]);
        if (item.MenuIndex <> index) then
          item.MenuIndex := index;
      end;

      if Assigned(itemNovRel) then
        if (itemNovRel.MenuIndex <> stlOrdem.Count -1) then
          itemNovRel.MenuIndex := stlOrdem.Count -1
    finally
      stlOrdem.EndUpdate;
      FreeAndNil(stlOrdem);
    end;
  end;

begin
  pRemoverRiscos;
  pOrdenarItens;
  pInserirRisco;
end;

procedure TfrmPrincipal.pOrdenarMenus;
  Var
    recOrdMnu: TOrdenaMnu;

  procedure pOrdena(mniMenu: TMenuItem; blnInsRiscos: Boolean; blnOrdSubMenu : Boolean = False; blnInicializa: Boolean = False);
  begin
    FillChar(recOrdMnu, SizeOf(recOrdMnu), #0);

    recOrdMnu.blnInsRiscos := blnInsRiscos;
    recOrdMnu.blnOrdSubMnu := blnOrdSubMenu;
    recOrdMnu.blnOrdenados := False;

    If blnUsuarioLogadoUtilizaModoClassico Then
    Begin
      If blnInicializa Then
      Begin
        pOrdenaMenu(mniMenu, recOrdMnu.blnInsRiscos, recOrdMnu.blnOrdSubMnu);
        recOrdMnu.blnOrdenados := True;
      End;
    End;

    dicOrdenaMnu.AddOrSetValue(mniMenu.Name, recOrdMnu);
    dicOrdenaMnu.TrimExcess;
  end;

begin
  mnuAutcomK.BeginUpdate;

  pOrdena(mnuFiscal,                    False, True);
  pOrdena(mnuProdutos,                  False, True,  fCfgSis('UTIWMS', varBoolean));

  pOrdena(mnuTransferencia,             True);
  pOrdena(mnuConfiguracoesEtiquetas,    True,  False, fCfgSis('UTIWMS', varBoolean));

  pOrdena(mnuEtiquetas,                 False);
  pOrdena(mnuCadAuxiliares,             False, False, fCfgSis('UTIWMS', varBoolean));

  pOrdena(mnuManCadastros,              False, False, fCfgSis('UTIWMS', varBoolean));
  pOrdena(mnuFaturamento,               False, False, fCfgSis('UTIWMS', varBoolean));
  pOrdena(mnuEmisFaturamento,           False, False, True);
  pOrdena(mnuTeleatendimento,           False);
  pOrdena(mnuFinanceiro,                True,  False, True);
  pOrdena(mnuCtaReceber,                False);
  pOrdena(mnuCtaPagar,                  False);
  pOrdena(mnuManCheques,                False);
  pOrdena(mnuControleChqEmi,            False);
  pOrdena(mnuContrCartoes,              False);
  pOrdena(mnuClubeFidelidade,           False);
  pOrdena(mnuComissaoProfissionais,     False);
  pOrdena(mnuFatConsPrecos,             False, False, True);
  pOrdena(mnuFechamentosMensais,        False);
  pOrdena(mnuTintadeMaquina,            False, False, True);

  pOrdena(mnuNfeUtil,                   True,  False);

  pOrdena(mnuContabilidade,             False, True);

  pOrdena(mnuRelatorio,                 False, True,  True);
  pOrdena(mnuControlePagtoFuncionarios, False, True);
  pOrdena(mnuBalanceteFinanceiro,       False, True);
  pOrdena(mnuLivroFiscal,               False, True);

  pOrdena(mnuDireitosDeAcesso,          False, True);
  pOrdena(SIVDVM,                       False);
  pOrdena(mnuUtil,                      True,  True);

  pOrdenaMenusPosteriorLogOff;

  mnuAutcomK.EndUpdate;
end;

procedure TfrmPrincipal.mnuCadMovBancario_TEClick(Sender: TObject);
begin
  Try
    pCriarFormularios(TfrmCadMovBancario, frmCadMovBancario);
    frmCadMovBancario.strTipMov := 'TE';
    frmCadMovBancario.Caption := 'Transferência de Valores';
    frmCadMovBancario.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuCadMovBancario_TEClick]');
    End;
  End;

  pFreeAndNil(frmCadMovBancario);
end;

procedure TfrmPrincipal.mnuCadMovFlexClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMovFlex);
end;

procedure TfrmPrincipal.mnuCadNegociacaoClientesClick(Sender: TObject);
  Var
    frmCadNegociacaoClientes : TfrmCadNegociacaoClientes;
begin
  Try
    pCriarFormularios(TfrmCadNegociacaoClientes, frmCadNegociacaoClientes);
    frmCadNegociacaoClientes.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[mnuCadNegociacaoClientesClick]');
  End;
  pFreeAndNil(frmCadNegociacaoClientes);
end;

procedure TfrmPrincipal.pAbreJanelaDeStatusDoSistemaDEPS;
  Var
    frmStatusOrcamentosSistemasDEPS: TfrmStatusOrcamentosSistemasDEPS;
begin
  if Assigned(tmrSistemaDEPS) then
    tmrSistemaDEPS.Enabled := False;
  pCriarFormularios(TfrmStatusOrcamentosSistemasDEPS, frmStatusOrcamentosSistemasDEPS);
  frmStatusOrcamentosSistemasDEPS.cdsStatusDEPS.Data := cdsStatusDEPS.Data;
  frmStatusOrcamentosSistemasDEPS.ShowModal;
  FreeAndNil(frmStatusOrcamentosSistemasDEPS);
  if Assigned(tmrSistemaDEPS) then
    tmrSistemaDEPS.Enabled := True;
end;

procedure TfrmPrincipal.pAbreJanelaDeAvisoDePrevisaoCTP;
  Var
    frmAvisosPrevisionamentoCTP: TfrmAvisosPrevisionamentoCTP;
begin
  if Assigned(tmrAvisosPrevisaoCTP) then
    tmrAvisosPrevisaoCTP.Enabled := False;
  pCriarFormularios(TfrmAvisosPrevisionamentoCTP, frmAvisosPrevisionamentoCTP);
  frmAvisosPrevisionamentoCTP.cdsAvisosPrevisionamento.Data := cdsAvisosPrevisionamentoCTP.Data;
  frmAvisosPrevisionamentoCTP.ShowModal;
  FreeAndNil(frmAvisosPrevisionamentoCTP);
  if Assigned(tmrAvisosPrevisaoCTP) then
    tmrAvisosPrevisaoCTP.Enabled := True;
end;

procedure TfrmPrincipal.pAbrirDevolucaoBaixaEntregaFutura(strCodCli: String);
Var
  strOpcDoc      : String;
  recReabrirForm : TReabrirForm;
begin

  FillChar(recReabrirForm, SizeOf(recReabrirForm), #0);

  If mnuFatDevolucaoBaixaEntFut.Visible Then
    pMenuFaturamentoClick(mnuFatDevolucaoBaixaEntFut, recReabrirForm, strOpcDoc, strCodCli);
end;

{$IFDEF TESTABILIDADE_AUTCOM}
//
{$Else}
procedure TfrmPrincipal.pAbrirPainelEntregas(strNumRom: String = '');
Var
  objDash: IDashboard;
begin
  If (fCfgSis('DASWEB', varString) = 'S') And (Not CheckEdgeBrowser) Then
  Begin
    MensagemInstalacaoWebView;
    Exit;
  End;

  If Not blnUsuarioLogadoUtilizaModoClassico Then
  Begin
    Principal.View.FMXPrincipal.AbrirPainelEntregas(TTaEntregue.Create, TTaEntregue.Create, strNumRom);
  End
  Else
  Begin
    If Assigned(fmxPainelEntregas) Then
      Exit;

    If (Not Assigned(objDash)) Then
      objDash := TDashboard.Create;

    fmxPainelEntregas := TfmxPainelEntregas.Create(Self);
    try
      fmxPainelEntregas.strGoogleAPIKey        := GoogleAPIKey;
      fmxPainelEntregas.strLoginUsuarioLogado  := strLoginUsuarioLogado;
      fmxPainelEntregas.strNomeUsuarioLogado   := strDescriUsuarioLogado;
      fmxPainelEntregas.TaEntregue             := TTaEntregue.Create;
      fmxPainelEntregas.TaEntregueRefresh      := TTaEntregue.Create;
      fmxPainelEntregas.Position               := FMX.Forms.TFormPosition.Designed;
      fmxPainelEntregas.ClientWidth            := 1024;
      fmxPainelEntregas.ClientHeight           := 768;
      fmxPainelEntregas.WindowState            := TWindowState.wsMaximized;
      fmxPainelEntregas.scrBarraRolagem.Height := Screen.WorkAreaHeight;
      fmxPainelEntregas.scrBarraRolagem.Width  := Screen.WorkAreaWidth;
      fmxPainelEntregas.Tag                    := 1;
      fmxPainelEntregas.Top                    := Round((Screen.DesktopHeight / 2) - 384);
      fmxPainelEntregas.Left                   := Round((Screen.DesktopWidth / 2) - 512);      fmxPainelEntregas.Tag                    := 1;
      fmxPainelEntregas.recBotaoFiltros.Tag    := 0;
      fmxPainelEntregas.edtDataIni.Text        := DateToStr(Today);
      fmxPainelEntregas.edtDataFim.Text        := DateToStr(Today);
      fmxPainelEntregas.edtDataIniDash.Text    := DateToStr(StartOfaMonth(YearOf(Today), MonthOf(Today)));
      fmxPainelEntregas.edtDataFinDash.Text    := DateToStr(Today);
      fmxPainelEntregas.strEmpLogada           := VS_strCodEmp;
      fmxPainelEntregas.objDash                := objDash;
      fmxPainelEntregas.objFuncoes             := TFuncoes.Create;
      fmxPainelEntregas.HabilitaDashboard;
      fmxPainelEntregas.MostrarFiltros;

      If Not strNumRom.IsEmpty Then
        fmxPainelEntregas.AtualizaRomaneios(IncYear(Today,-5), Today, strNumRom)
      Else
        fmxPainelEntregas.AtualizaRomaneios(Today, Today);

      fmxPainelEntregas.NotificaNovasMensagens;
      fmxPainelEntregas.ShowModal;
    finally
      FreeAndNil(fmxPainelEntregas);
    End;
  End;
end;
{$ENDIF}

procedure TfrmPrincipal.mnuFatBaixaEntregaFutura49Click(Sender: TObject);
begin
  pBaixaEntregaFutura(True);
end;

procedure TfrmPrincipal.mnuFatBaixaEntregaFuturaClick(Sender: TObject);
begin
  pBaixaEntregaFutura(False, True);
end;

procedure TfrmPrincipal.mnuFatBaixaEntregaFuturaSEPClick(Sender: TObject);
  Var
    frmFatBaixaEntregaFutura : TfrmFatBaixaEntregaFutura;
begin
  Try
    pCriarFormularios(TfrmFatBaixaEntregaFutura, frmFatBaixaEntregaFutura);
    frmFatBaixaEntregaFutura.blnSepFut := True;
    frmFatBaixaEntregaFutura.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[]');
  End;
  pFreeAndNil(frmFatBaixaEntregaFutura);
end;

procedure TfrmPrincipal.mnuCanalAcessoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCanaldeAcesso);
end;

procedure TfrmPrincipal.mnuCancDepChequePreClick(
  Sender: TObject);
begin
  pCriarForm(TfrmCancDepChequePreMod2);
end;

procedure TfrmPrincipal.mnuAltPrecoGlobalClick(Sender: TObject);
begin
  If fVerificaAcessoSistema('ALTGCUSVEN', strLoginUsuarioLogado) Or
     fVerificaAcessoSistema('ALTGCUSMAR', strLoginUsuarioLogado) Or
     fVerificaAcessoSistema('ALTGVENMAR', strLoginUsuarioLogado) Then
    pOpeProd(AltPrecoGlobal)
  Else
    pMensagemOk('Usuário sem direito de acesso!');
end;

procedure TfrmPrincipal.mnuAltGlobalServicoClick(Sender: TObject);
begin
  If fVerificaAcessoSistema('ALTGLOBSER', strLoginUsuarioLogado) Then
    pOpeProd(AltGlobalServico)
  Else
    pMensagemOk('Usuário sem direito de acesso!');

end;

procedure TfrmPrincipal.mnuAltPrecoGlobalCustosForClick(Sender: TObject);
begin
  If fCfgSis('TABPRD', VarBoolean) Then
    pOpeProd(AtivacaoTabelaPreco)
  Else
    pOpeProd(EfetivacaoPrecosFornecedor);
end;

procedure TfrmPrincipal.mnuAltPrecoGlobalNotaClick(Sender: TObject);
begin
  pOpeProd(AltPrecoGlobalNota);
end;

procedure TfrmPrincipal.mnuAltPrecoAcabadosIndClick(Sender: TObject);
begin
  pCriarForm(TfrmAltPrecoAcabadosInd);
end;

procedure TfrmPrincipal.mnuAltPrecoFornecedorClick(Sender: TObject);
begin
  pOpeProd(AltPrecoGlobalFornecedor);
end;

procedure TfrmPrincipal.mnuAltPrecoGlobalCatalogoClick(Sender: TObject);
begin
  pOpeProd(AltPrecoGlobalCatalogo);
end;

procedure TfrmPrincipal.mnuTXTACACIAServerExpClick(Sender: TObject);
begin
  If (fCfgSis('MODACA') = '1') Then
    pCriarForm(TfrmTxtACACIAServer)
  Else
    pCriarForm(TfrmTxtACACIAServerExpAndroid);
end;

procedure TfrmPrincipal.mnuTXTACACIAServerImpClick(Sender: TObject);
begin
  If fCfgSis('MODACA', varInteger) = 1 Then
    pCriarForm(TfrmTxtACACIAServerImp)
  Else
    pCriarForm(TfrmTxtACACIAServerImpAndroid);
end;

procedure TfrmPrincipal.mnuRelEstDigitacaoNotaEntradaClick(Sender: TObject);
Var
  strMensagem : String;

begin

  strMensagem := 'Este Relatório mostrará somente os documentos que tiveram sua ' +
                 'entrada através de um pedido de compra e que os produtos foram digitados ' +
                 'manualmente. Para isso, na entrada de mercadorias os produtos não devem ' +
                 'ser carregados e os itens digitados a partir da Nota Fiscal, o Relatório ' +
                 'irá exibir a diferença entre o que foi digitado e o que havia no pedido de ' +
                 'compra selecionado.';

  Try
    pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
    frmMensagemExplicativa.mmoInstru.Text := strMensagem;
    frmMensagemExplicativa.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuRelEstDigitacaoNotaEntradaClick]');
    End;
  End;

  pFreeAndNil(frmMensagemExplicativa);

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(238, 8085, [8086,8087,8088],
                        [],
                        [],
                        Sender,
                        nil,
                        False);
  End;

end;

procedure TfrmPrincipal.mnuManutComProfissionaisIncClick(Sender: TObject);
var
  frmManComissaoProfissionais: TfrmManComissaoProfissionais;
begin
  Try
    pCriarFormularios(TfrmManComissaoProfissionais, frmManComissaoProfissionais);
    frmManComissaoProfissionais.strNomeForm := mnuManutComProfissionaisInc.Hint;
    frmManComissaoProfissionais.blnOpcInc := TRUE;

    If fCfgSis('TCOPRO') = '4' Then
    Begin
      If fMensagem('','Selecione o tipo de Comissão de Profissional:', ['&Valor', '&Pontos']) = 1 Then
      Begin
        frmManComissaoProfissionais.VS_strTCoProInterna := '1';
        frmManComissaoProfissionais.Caption := frmManComissaoProfissionais.Caption + ' - VALOR ';
      End
      Else
      Begin
        frmManComissaoProfissionais.VS_strTCoProInterna := '3';
        frmManComissaoProfissionais.Caption := frmManComissaoProfissionais.Caption + ' - PONTOS ';
      End;
    End;

    frmManComissaoProfissionais.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmPrincipal.mnuManutComProfissionaisIncClick]');
    End;
  End;

  pFreeAndNil(frmManComissaoProfissionais);

end;

procedure TfrmPrincipal.mnuManutCustoProdutosClick(Sender: TObject);
begin
  pOpeProd(ManutCustoProdutos);
end;

procedure TfrmPrincipal.mnuManutencaoLocEqClick(Sender: TObject);
begin
  pCriarForm(TfrmManutencaoLocEqu);
end;

procedure TfrmPrincipal.mnuManutencaoLoteMPClick(Sender: TObject);
begin
  pCriarForm(TfrmManutencaoLoteMP);
end;

procedure TfrmPrincipal.mnuManutencaoOrigemProdAcabadosClick(Sender: TObject);
begin
  pCriarForm(TfrmManutencaoOrigemProdAcabados, frmManutencaoOrigemProdAcabados);
end;

procedure TfrmPrincipal.mnuEstornaCartoesClick(Sender: TObject);
begin
  pCriarForm(TfrmEstornaCartoes);
end;

procedure TfrmPrincipal.mnuEtiEstruturasClick(Sender: TObject);
  Var
    frmImpEtiquetas : TfrmImpEtiquetas;
begin
  Try
    pCriarFormularios(TfrmImpEtiquetas, frmImpEtiquetas);
    frmImpEtiquetas.intTipEti := ETI_ESTRUTURAS;
    frmImpEtiquetas.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuEtiEstruturasClick]');
    End;
  End;

  pFreeAndNil(frmImpEtiquetas);

end;

procedure TfrmPrincipal.mnuEtiDespachoClick(Sender: TObject);
begin
  pCriarForm(TfrmImpEtiDespacho);
end;

procedure TfrmPrincipal.mnuCalNivCriEstClick(Sender: TObject);
begin
  pCriarForm(TfrmCalNivCriEst);
end;

procedure TfrmPrincipal.mnuCalNivGirEstClick(Sender: TObject);
begin
  pCriarForm(TfrmCalNivGirEst);
end;

procedure TfrmPrincipal.mnuCalNivGirEstFornecedorClick(Sender: TObject);
begin
  If (fCfgSis('EMPGER', varBoolean)) Then
    pCriarForm(TfrmCalNivGirEstFornecedor)
  Else
    pMensagemOk('Cálculo permitido apenas para empresa gerencial!');
end;

procedure TfrmPrincipal.mnuTransfCodProdutoClick(Sender: TObject);
begin
  pOpeProd(TransfCodProduto);
end;

function TfrmPrincipal.fTemLiberacao(strUsuario: String): Integer;
  Var
    qryGen: TUniQuery;
begin
  Result := 0;

  If (Not fPodeExecutarFuncaoDoTimer) Then
  begin
    tmrTemMsg.Enabled := True;
    Exit;
  end;

  if (fEmptyStr(strUsuario)) then
    Exit;

  Try
    qryGen := fCriaQuery(Nil);
    try
      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(TfrmCadMsg.fGetSqlMsg(strUsuario, True, 'MSG_OPELIB', False));
      qryGen.Open;
      qryGen.First;
      Result := 0;
      While Not qryGen.Eof Do
      Begin
        If (qryGen.FindField('MSG_OPELIB') <> Nil) And qryGen.FieldByName('MSG_OPELIB').AsString.IsEmpty Then
          Inc(Result);
        qryGen.Next;
      End;
      qryGen.Close;
    finally
      FreeAndNil(qryGen);
    end;
  Except

    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '[fTemLiberacao]');
    End;
  End;
end;

function TfrmPrincipal.fTemLiberacaoPedidoCompra(strUsuario: String): Integer;
  Var
    qryGen: TUniQuery;
    blnMSGPDL: Boolean;
begin
  Result := 0;
  If Not mnuPedidoCompraLiberacao.Visible Then
    Exit;

  If Not fCfgSIS('LIBPCM', varBoolean) Then
    Exit;

  blnMSGPDL := fCampoTabela('OPE_MSGPDL', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado], False) = 'S';

  if Not blnMSGPDL Then
    Exit;

  If (Not fPodeExecutarFuncaoDoTimer) Then
  begin
    tmrTemMsg.Enabled := True;
    Exit;
  end;

  if (fEmptyStr(strUsuario)) then
    Exit;

  Try
    qryGen := fCriaQuery(Nil);
    try
      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.add('SELECT COUNT(1) AS QTDE     ');
      qryGen.SQL.add('FROM                        ');
      qryGen.SQL.add('  PCMGER P                  ');
      qryGen.SQL.add('  LEFT JOIN CADFOR ON       ');
      qryGen.SQL.add('    FOR_CODFOR = PCG_CODFOR ');
      qryGen.SQL.add('  LEFT JOIN CADOPE ON OPE_CODOPE = PCG_CODCMP ');
      qryGen.SQL.add('WHERE                       ');
      qryGen.SQL.add('   PCG_BAIXAD = 0 AND ');
      qryGen.SQL.add('   PCG_PEDLIB IS NULL AND   ');
      qryGen.SQL.add('   PCG_ESPDOC = "PD"    ');
      qryGen.SQL.add('   AND PCG_NUMCTN = 0   ');

      If fCfgSis('LEMPCM') = '1' Then
      Begin
        qryGen.SQL.add(' AND (IF(IFNULL(PCG_EMPDES, "") = "", PCG_CODEMP, PCG_EMPDES) = ' + QuotedStr(VS_strCodEmp)+'');
        qryGen.SQL.add('    OR PCG_CODEMP = ' + QuotedStr(VS_strCodEmp) + ')');
      End;

      qryGen.Open;
      Result := qryGen.FieldByName('QTDE').AsInteger;
      qryGen.Close;
    finally
      FreeAndNil(qryGen);
    end;
  Except

    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '[fTemLiberacao]');
    End;
  End;
end;


function TfrmPrincipal.fTemMensagem(strUsuario: String): Integer;
  Var
    qryGen: TUniQuery;
Begin

  Result := 0;

  Try
    qryGen := fCriaQuery(Nil);
    With qryGen Do
    Begin
      SQL.Clear;
      SQL.add(TfrmCadMsg.fGetSqlMsg(strUsuario, False, 'COUNT(0)', False));
      Open;
      Result := Fields[0].AsInteger;
    End;
    FreeAndNil(qryGen);
  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '[fTemMensagem]');
    End;
  End;

End;

function TfrmPrincipal.fTintaDisponivel(strTinta: String;
  iTintas: ITintasDeMaquina): Boolean;
Var
  intContador: Integer;
begin
  Result := False;

  If StartsText('frm', strTinta) Then
    Exit(True);

  If (Not Assigned(iTintas)) Then
    Exit;

  If strTinta = 'mnuTintaDeMaquina' Then
    Exit(True);

  Result := iTintas.fEstaDisponivel(iTintas.fGetIdePro(strTinta));

  If Not Result Then
  Begin
    If StartsText('mnu', strTinta) Then
    Begin
      strTinta := Copy(strTinta, 4, Length(strTinta));

      For intContador := 0 To iTintas.fGetQtdTintas -1 Do
      Begin
        If (iTintas.fEstaDisponivel(intContador))
          And (AnsiLowerCase(iTintas.fGetNomeTinta(intContador)) = AnsiLowerCase(strTinta)) Then
        Begin
          Result := True;
          Break;
        End;
      End;
    End;
  End;
end;

function TfrmPrincipal.TEFIsEnabled() : Boolean;
begin
  Result := VS_blnTefModularIndisponivel;
end;

function TfrmPrincipal.fVerificaAcessoDepositoCheque: Boolean;
var
  qryDepositoCheque: TUniQuery;
begin
  qryDepositoCheque := fCriaQuery(self);
  try
    qryDepositoCheque.SQL.Add('SELECT DIR_NOMFRM FROM DIROPE WHERE DIR_NOMFRM = "frmBaixaCheques" AND OPE_CODOPE = :COD');
    qryDepositoCheque.ParamByName('COD').AsString := strLoginUsuarioLogado;
    qryDepositoCheque.Open;
    Result := not qryDepositoCheque.IsEmpty;
  finally
    FreeAndNil(qryDepositoCheque);
  end;
end;

function TfrmPrincipal.fVerificaAcessoGeracaoTintas(ACaption: String): Boolean;
begin
  Result := True;

  If ACaption = 'Gerar Cadastro de Tintas' Then
  Begin
    If Not fEhAdministrador(strLoginUsuarioLogado) Then
      Result := False;
  End;
end;

function TfrmPrincipal.fVerificaAcessoMenuTintas(strTinta: String;
  iTintas: ITintasDeMaquina; strName: String): boolean;
Var
  blnTemDireito: Boolean;
begin
  blnTemDireito := fVerificaAcessoAutTin(strTinta, strName);
  blnTemDireito := blnTemDireito And fVerificaAcessoGeracaoTintas(strTinta);

  If (blnTemDireito) And (strTinta <> 'frmConfTintaMaquina') Then
    blnTemDireito := fTintaDisponivel(strTinta, iTintas);

  Result :=  blnTemDireito;
end;

function TfrmPrincipal.fImportaImagens(pgbStatus: TcxProgressBar): Boolean;
begin
  Result := True;
  pImportaImagens;
end;

function TfrmPrincipal.fIniciarTefCitel(
  pgbProgresso: TcxProgressBar): Boolean;
  const
    intQtdMax = 2;
var
  LblnEscondeMenuAdmTef: Boolean ;
begin
  pgbProgresso.Properties.Max := intQtdMax;

  pInfoStatusGravacao(pgbProgresso, 'Verificando exigências do TEF...',2);
  pStepStatusGravacao(pgbProgresso);
  Application.ProcessMessages ;
  FpgbProgressoTefCitel := pgbProgresso;
  try
    pIniciaTefCitel(LblnEscondeMenuAdmTef, pStatusCargaTefCitel);
  finally
    FpgbProgressoTefCitel := nil;
  end;

  { A atualizacao da estacao pode ter usado a barra para medir a
    transferencia de um pacote (pStatusCargaTefCitel). Devolver o Max e a
    Position ao que esta rotina espera, para o pStepStatusGravacao logo
    abaixo continuar fazendo sentido. }
  pgbProgresso.Properties.Max := intQtdMax;
  pgbProgresso.Position       := 1;

  if LblnEscondeMenuAdmTef and (not fExibeMenuAdmTef) then
  begin
    mnuADMAdministracaoTEF.Tag     := 1;
    mnuADMAdministracaoTEF.Visible := False;
    fraPesquisarMenu.pMontarPesquisa;
  end ;
  pStepStatusGravacao(pgbProgresso);
  Application.ProcessMessages ;

  if not fConfiguracaoExiste('TRAPEN') then
    Exit(True)  ;

  if fCfgSis('TRAPEN', varBoolean) then
  begin
    pInfoStatusGravacao(pgbProgresso, 'Verificando pendências de transações TEF...',2);
    Application.ProcessMessages ;
    pStepStatusGravacao(pgbProgresso);
    fVerificaPendenciasTEFCitel;
    pStepStatusGravacao(pgbProgresso);
  end;

  Result := True;
end;

function TfrmPrincipal.fIPesqEmpresa(ASelf: TForm; edtCodigo: TCustomEdit;edtNomEmp: TEditFocus; var chrKey: Char): Boolean;
  Var
    arrEmp : TConsultasArray;
begin
  Result := untConsultas.fPesqEmpresa(conEmpSimples, ASelf, edtCodigo, edtNomEmp, Nil, chrKey,arrEmp);
end;

procedure TfrmPrincipal.GeraMenuLibCartoes;
begin
  GeraMenuLibCartoes(False);
end;

procedure TfrmPrincipal.GeraMenuLibCartoes(ARealizandoLogOff: Boolean);
begin
  fExecutarModal(procedure
                   Var
                     LControleRecebiveisMenu: TMenuItem;
                 begin
                   TMenuLibCartoes.CarregaDllLibCartoes;

                   If untFuncoesInicializarLibCartoes.LibCartoesHandle = 0 Then
                     Exit;

                   mnuAutcomK.BeginUpdate;
                   Try
                     TMenuLibCartoes.CarregarMenusImportacao(mnuImportacaoCartoes);
                     TMenuLibCartoes.CarregarMenusConciliacao(mnuConciliacaoCartoes);
                     TMenuLibCartoes.CarregarMenusAntecipacao(mnuAntecipacaoDeCartoes);
                     TMenuLibCartoes.CarregarMenusImportacaoRecebiveisMkt(mnuImportacaoCartoes,
                                                                          mnuFinanceiro);

                     LControleRecebiveisMenu := mnuFinanceiro.Find('Controle de Recebíveis Market Place');
                     TMenuLibCartoes.CarregarMenusBaixaRecebiveisMkt(LControleRecebiveisMenu);

                     TMenuLibCartoes.CarregarMenusExclusao(mnuContrCartoes);
                     TMenuLibCartoes.CarregarMenusExportacao(mnuContrCartoes);

                     If ARealizandoLogOff Then
                     Begin
                       pVerificaMenu(mnuImportacaoCartoes, Nil);
                       pVerificaMenu(mnuConciliacaoCartoes, Nil);
                       pVerificaMenu(mnuAntecipacaoDeCartoes, Nil);
                       pVerificaMenu(LControleRecebiveisMenu.Find('Importação de Recebíveis'), Nil);
                       pVerificaMenu(LControleRecebiveisMenu.Find('Conciliação/Baixa de Recebíveis'), Nil);
                     End;
                   Finally
                     mnuAutcomK.EndUpdate;
                   End;
                 end,
                 'Aguarde, carregando módulo Cartões Autcom e menus correspondentes...',
                 EmptyStr);
end;

function TfrmPrincipal.GerarQuadroLicencas: IQuadroLicencas;
begin
  { as tres verificacoes do requisito acontecem dentro da carga }
  Result := TQuadroLicencasInfo.Create(strLoginUsuarioLogado);
end;

{***************************************************}
{* QUADRO DE LICENCAS - RODAPE DA TELA PRINCIPAL   *}
{* Criado sob demanda: operador que nao e master   *}
{* (OPE_SENLIB <> N) nao instancia nada. O quadro  *}
{* e informativo, entao falha aqui nao pode        *}
{* impedir a abertura da tela principal.           *}
{***************************************************}
procedure TfrmPrincipal.pAtualizaQuadroLicencas;
begin
  Try
    If Not Assigned(FobjQuadroLicencas) Then
      FobjQuadroLicencas := TQuadroLicencas.Create(pnlEsquerda);

    FobjQuadroLicencas.pAtualizar(strLoginUsuarioLogado, IsLightTheme);
  Except
    On E: Exception Do
      pGravaLogErrArquivoLocal(E.ClassName + ' - ' + E.Message, fRetornaStack,
                               'TfrmPrincipal.pAtualizaQuadroLicencas');
  End;
end;

function TfrmPrincipal.GerarDashboard: IDashboard;
begin
  Result := TDashboard.Create;
end;

function TfrmPrincipal.GerarFuncoesFiremonkey: IFuncoes;
begin
  Result := TFuncoes.Create;
end;

procedure TfrmPrincipal.GerarPopupFavoritos;
begin
  fraPesquisarMenu.pGeraPopUpFavoritos;
end;

procedure TfrmPrincipal.GerarPopupRecentes;
begin
  fraPesquisarMenu.pGeraPopUpRecentes;
end;

function TfrmPrincipal.GoogleAPIKey(): String;
begin
  Result := fCfgSis('KEYMDP', varString);
end;

function TfrmPrincipal.HabilitaAtalhoWMS: boolean;
begin
  Result := fHabilitarAtalhoWMS;
end;

procedure TfrmPrincipal.mnuOrdProdGeracaoAutomaticaEstoqueClick(Sender: TObject);
begin
  pCriarForm(TfrmOrdProdGeracaoAutomaticaEstoque);
end;

function TfrmPrincipal.IDConexao: String;
begin
  Result := fGetConnectionID;
end;

(**********************************************************
 * Evento criado para pegar a maior tag do menu           *
 * para auxiliar na criação de direitos de acesso.        *
 **************************************************KP*6959*)
procedure TfrmPrincipal.imgLogoDarkClick(Sender: TObject);
var
  i, j, intMaiorTag: Integer;
begin
  If Not fModoDeDesenvolvimento Then
    Exit;

  intMaiorTag := 0;
    for j := 0 to mnuDireitosDeAcesso.Count-1 do
    begin
      for i := 0 to mnuDireitosDeAcesso.Items[J].Count-1 do
        if mnuDireitosDeAcesso.Items[J].Items[I].Tag > intMaiorTag then
          intMaiorTag := mnuDireitosDeAcesso.Items[J].Items[I].Tag;
    end;
    pMensagemOk(IntToStr(intMaiorTag));
  end;

procedure TfrmPrincipal.mnuImportCadProdutoClick(Sender: TObject);
begin
  pOpeProd(ImportCadProduto);
end;

procedure TfrmPrincipal.mnuImportCadEstruturaClick(Sender: TObject);
begin
  pOpeProd(ImportCadEstrutura);
end;


procedure TfrmPrincipal.mnuImportCadNCMClick(Sender: TObject);
begin
 If (Not fVerificaAcessoSistema(mnuImportCadNCM.Hint)) Then
  Begin
    fMensagem('', 'Esse usuário não tem direito de acesso a essa rotina!', ['&Ok']);
    Exit;
  End;
  pOpeProd(ImportCadNCM);
end;

procedure TfrmPrincipal.mnuImportCadNOPClick(Sender: TObject);
begin
 If (Not fVerificaAcessoSistema(mnuImportCadNOP.Hint)) Then
  Begin
    fMensagem('', 'Esse usuário não tem direito de acesso a essa rotina!', ['&Ok']);
    Exit;
  End;
  pOpeProd(ImportCadNOP);
end;

function TfrmPrincipal.IP: String;
begin
  Result := frmModulo.GetCurrentConnection.Server;
end;

procedure TfrmPrincipal.mnuImportacaoNotaFiscalUsoConsumoClick(
  Sender: TObject);
begin
  pCriarForm(TfrmEntImpConsumo);
end;

function TfrmPrincipal.IsLightTheme: Boolean;
var
  WC: TColor;
  PL: Integer;
  RGB : Longint;
  R,G,B: Byte;
begin
  WC := pnlFundo.Color;

  //break out it's component RGB parts
  RGB := ColorToRGB(WC);
  R   := GetRValue(RGB);
  G   := GetGValue(RGB);
  B   := GetBValue(RGB);

  //calc the "perceived luminance" of the color.  The human eye perceives green the most,
  //then red, and blue the least; to determine the luminance, you can multiply each color
  //by a specific constant and total the results, or use the simple formula below for a
  //faster close approximation that meets our needs. PL will always be between 0 and 255.
  //Thanks to Glenn Slayden for the formula and Tom Brunberg for pointing me to it!
  PL := (R+R+R+B+G+G+G+G) shr 3;

  //if the PL is greater than the color midpoint, it's "light", otherwise it's "dark".
  Result := (PL > $7F);
end;

procedure TfrmPrincipal.KeyDownVersaoClassica;
begin
  pLogsCTRLF1;
end;

procedure TfrmPrincipal.mnumportarArquivoParaAnalisedeComprasClick(
  Sender: TObject);
  Var
    frmImportarArquivoParaAnalise_de_Compras: TfrmImportarArquivoParaAnalise_de_Compras;
begin
  pCriarFormularios(TfrmImportarArquivoParaAnalise_de_Compras, frmImportarArquivoParaAnalise_de_Compras);
  Try
    frmImportarArquivoParaAnalise_de_Compras.ShowModal;
  Finally
    pFreeAndNil(frmImportarArquivoParaAnalise_de_Compras);
  End;
end;

procedure TfrmPrincipal.mnuGerarOrdemdeProducaoPorArquivoDeImportacaoClick(
  Sender: TObject);
begin
  pCriarFormularios(TfrmGerarOrdemdeProducaoPorArquivoDeImportacao, frmGerarOrdemdeProducaoPorArquivoDeImportacao);
  Try
    frmGerarOrdemdeProducaoPorArquivoDeImportacao.ShowModal;
  Finally
    pFreeAndNil(frmGerarOrdemdeProducaoPorArquivoDeImportacao);
  End;
end;

procedure TfrmPrincipal.mnuImpRecCobrancaClick(Sender: TObject);
  Var
    frmBaixaReceber : TfrmBaixaReceber;
begin
    if not fVerificaAcessoSistema(mnuImpRecCobranca.Hint) then
  begin
    fMensagem('', 'Esse usuário não tem direito a acessar esse módulo!', ['&Ok']);
    exit;
  end;

  Try
    pCriarFormularios(TfrmBaixaReceber, frmBaixaReceber);
    frmBaixaReceber.blnApenasImpressaoRecibo := True;
    frmBaixaReceber.Caption := 'Baixa de Contas a Receber - Impressão de Recibo de Cobrança';
    frmBaixaReceber.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmPrincipal.mnuImpRecCobrancaClick]');
    End;
  End;
  pFreeAndNil(frmBaixaReceber);
end;

procedure TfrmPrincipal.pSetaDirecaoPopupMsg;
begin
  If fCampoTabela('OPE_MSGPOS', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]) = 'D' Then
  Begin
    dxAlertWindow.OptionsAnimate.HidingAnimationDirection  := awmdRight;
    dxAlertWindow.OptionsAnimate.ShowingAnimationDirection := awmdLeft;
    dxAlertWindow.WindowPosition := awpBottomRight;
  End
  Else
  Begin
    dxAlertWindow.OptionsAnimate.HidingAnimationDirection  := awmdLeft;
    dxAlertWindow.OptionsAnimate.ShowingAnimationDirection := awmdRight;
    dxAlertWindow.WindowPosition := awpBottomLeft;
  End;
end;

procedure TfrmPrincipal.tmrTemMsgTimer(Sender: TObject);
  Var
    intQtdMsg: Integer;
    intQtdLib: Integer;
    strIgMsgL: String;
    LLogTmr: ILogTmr;
begin

  If (Not fPodeExecutarFuncaoDoTimer) Or (fOpcoesIgnorar) or (blnGerImpCTe) Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If Assigned(VS_objTraceViewer) Then
    VS_objTraceViewer.LogTimer('tmrTemMsgTimer');

  LLogTmr := TLogTmr.New('tmrTemMsgTimer').Enter('fTemLiberacao');

  tmrTemMsg.Enabled := False;
  Try
    {********************************************}
    {* VERIFICA SE EXISTEM PEDIDOS DE LIBERAÇÃO *}
    {*****************************************RV*}
    intQtdLib := fTemLiberacao(strLoginUsuarioLogado);
    If (intQtdLib > 0) and (not blnIgnorarPopUpMsgLib) Then
    Begin
      If (intQtdLib = 1) Then
        pnlLibera.Caption := ' ' + IntToStr(intQtdLib) + ' Pedido de Liberação Recebido'
      Else
        pnlLibera.Caption := ' ' + IntToStr(intQtdLib) + ' Pedidos de Liberação Recebidos';

      pnlLibera.Visible := True;
      pnlLibera.Refresh;

      If (Not blnCadMsgAberto) And (fCfgSis('UTIPOL', varBoolean)) Then
      Begin
        dxAlertWindow.OptionsButtons.Buttons[0].Visible := True;

        strIgMsgL := fCampoTabela('OPE_IGMSGL', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);

        if (strIgMsgL = 'S') then
        begin
          if (intQtdLib = 1) then
            dxAlertWindow.OptionsButtons.Buttons[3].Hint := 'Ignorar este pedido de liberação recebido'
          else
            dxAlertWindow.OptionsButtons.Buttons[3].Hint := 'Ignorar pedidos de liberação recebidos';

          dxAlertWindow.OptionsButtons.Buttons[3].Visible := True;
          dxAlertWindow.OptionsButtons.Buttons[4].Visible := True;
        end;

        dxAlertWindow.Show('Autcom - Pedidos de Liberação', pnlLibera.Caption);
        dxAlertWindow.OptionsButtons.Buttons[0].Visible := False;
        dxAlertWindow.OptionsButtons.Buttons[3].Visible := False;
        dxAlertWindow.OptionsButtons.Buttons[4].Visible := False;
      End;
    End
    Else
      pnlLibera.Visible := False;

    {$IFDEF TESTABILIDADE_AUTCOM}
    //não chama a tela nova
    {$Else}
    if Not blnUsuarioLogadoUtilizaModoClassico Then
    begin
      Principal.View.FMXPrincipal.AtualizarQuantidadePedLiberacao(intQtdLib);
    end;
    {$ENDIF}

    {********************************************************}
    {* VERIFICA SE EXISTEM PEDIDOS DE COMPRA PARA LIBERAÇÃO *}
    {*****************************************************WG*}
    intQtdLib := fTemLiberacaoPedidoCompra(strLoginUsuarioLogado);
    If pnlLiberaPedCom.Visible Then
      pnlLiberaPedCom.Visible := intQtdLib <> 0;

    If (intQtdLib = 1) Then
      pnlLiberaPedCom.Caption := ' ' + IntToStr(intQtdLib) + ' Pedido de Compra Recebido Para Liberação'
    Else
      pnlLiberaPedCom.Caption := ' ' + IntToStr(intQtdLib) + ' Pedidos de Compra Recebidos Para Liberação';
    If Not pnlLiberaPedCom.Visible Then
    Begin
      If (intQtdLib > 0) Then
      Begin

        pnlLiberaPedCom.Visible := True;
        pnlLiberaPedCom.Refresh;

        If (Not blnCadMsgAberto) And (fCfgSis('LIBPCM', varBoolean)) Then
        Begin
          dxAlertWindow.OptionsButtons.Buttons[2].Visible := True;
          dxAlertWindow.Show('Autcom - Pedidos de Compra Para Liberação', pnlLiberaPedCom.Caption);
          dxAlertWindow.OptionsButtons.Buttons[2].Visible := False;
        End;
      End
      Else
        pnlLiberaPedCom.Visible := False;
    End;


    {******************************}
    {* VERIFICA DIREITO DE ACESSO *}
    {* PARA RECEBER MENSAGENS.    *}
    {***************************PZ*}
    If(Not fVerificaAcessoSistema('DIRREC')) Then
    Begin
      tmrTemMsg.Enabled := True;
      LLogTmr.Exit('Sem permissão de acesso DIRREC');
      Exit;
    End;

    intQtdMsg := fTemMensagem(strLoginUsuarioLogado);

    pExibeNotificacaoQtdMensagens(intQtdMsg);

    If (intQtdMsg > 0) Then
    Begin
      If (intQtdMsg = 1) Then
        stbStatus.Panels[2].Text := ' '+IntToStr(intQtdMsg)+ ' Mensagem Recebida'
      Else
        stbStatus.Panels[2].Text := ' '+IntToStr(intQtdMsg)+ ' Mensagens Recebidas';

      If (intMsg <> intQtdMsg) Then
      Begin
        dxAlertWindow.Show('Autcom - Mensagem Recebida!', stbStatus.Panels[2].Text);
        intMsg := intQtdMsg;
      End;
    End
    Else
      stbStatus.Panels[2].Text := '';

    {$IFDEF TESTABILIDADE_AUTCOM}
    //não chama a tela nova
    {$Else}
    if Not blnUsuarioLogadoUtilizaModoClassico Then
      Principal.View.FMXPrincipal.AtualizarQuantidadeMensagens(intQtdMsg);
    {$ENDIF}
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[tmrTemMsgTimer]');
    End;
  End;
  tmrTemMsg.Enabled := True;

  LLogTmr.Exit;
end;

procedure TfrmPrincipal.tmrTestaLogReplicacaoTimer(Sender: TObject);
var
  LLogTmr: ILogTmr;
begin
  If (Not fPodeExecutarFuncaoDoTimer) Or (fOpcoesIgnorar) Or (blnHomologacao)  or (blnGerImpCTe) Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If Assigned(VS_objTraceViewer) Then
    VS_objTraceViewer.LogTimer('tmrTestaLogReplicacaoTimer');

  LLogTmr := TLogTmr.New('tmrTestaLogReplicacaoTimer').Enter('pTestarLogReplicacao');

  tmrTestaLogReplicacao.Enabled := False;
  Try
    VS_EXECUTAR_TESTE_LOG_REPLICACAO := True;
    pTestarLogReplicacao;

    tmrTestaLogReplicacao.Interval := RandomRange(TIMER_UM_MINUTO, TIMER_DEZ_MINUTOS);
  Finally
    tmrTestaLogReplicacao.Enabled := True;
  End;

  LLogTmr.Exit;
end;

procedure TfrmPrincipal.tmrTransfEstOnTimer(Sender: TObject);
var
  LLogTmr: ILogTmr;
begin
  If (Not fPodeExecutarFuncaoDoTimer) Or (fOpcoesIgnorar) or (blnGerImpCTe) Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If Assigned(VS_objTraceViewer) Then
    VS_objTraceViewer.LogTimer('tmrTransfEstTimer');

  LLogTmr := TLogTmr.New('tmrTransfEstTimer').Enter('fTemTransfEstoque');

  tmrTransfEst.Enabled := False;

  If fTemTransfEstoque Then
    dxAlertWindow.Show('Autcom - Transferência de Estoque',
                       'Existe Transferência de Estoque para realizar Entrada!');

  tmrTransfEst.Interval := 130000;
  tmrTransfEst.Enabled  := True;

  LLogTmr.Exit;
end;

procedure TfrmPrincipal.tmrImpRomMovMeOnTimer(Sender: TObject);
var
  LLogTmr: ILogTmr;
begin
  if (blnGerImpCTe) then
    Exit;

  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If fAutComEmModoImportacao Then
    Exit;

  if fVerificaAcessoSistema('IMOVME') then
  begin
    If Assigned(VS_objTraceViewer) Then
      VS_objTraceViewer.LogTimer('tmrImpRomMovMeTimer');

    LLogTmr := TLogTmr.New('tmrImpRomMovMeTimer').Enter('pChamaAutComModoImportacao');

    pChamaAutComModoImportacao(CHAVE_LOCK_MOVMER, PARAM_EXEC_MOVMER, LIMIT_TEMP_MOVMER);

    LLogTmr.Exit;
  end;
end;

procedure TfrmPrincipal.tmrImpSfaMobOnTimer(Sender: TObject);
var
  LLogTmr: ILogTmr;
begin
  if (blnGerImpCTe) then
    Exit;

  If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If fAutComEmModoImportacao Then
    Exit;

  If (Not VS_blnAutcomResponsavelPeloSFA) Then
  Begin
    If (Not fTravaBancoAtiva(fGetMD5ChvRoboSFA)) Then
    Begin
      VS_blnAutcomResponsavelPeloSFA := fGetLock(fGetMD5ChvRoboSFA);
    End;
  End;

  If Not VS_blnAutcomResponsavelPeloSFA Then
    Exit;

  If OperadorCitelLogado Then
  Begin
    tmrImpSfaMob.Enabled := False;
    Exit;
  End;

  If Pos(strLoginUsuarioLogado, fTransform(fCfgSis('SFAOPE'), 3)) > 0 Then
  Begin
    If Assigned(VS_objTraceViewer) Then
      VS_objTraceViewer.LogTimer('tmrImpSfaMobTimer');

    LLogTmr := TLogTmr.New('tmrImpSfaMobTimer').Enter('pChamaAutComModoImportacao');

    pChamaAutComModoImportacao(CHAVE_LOCK_SFAMOB, PARAM_EXEC_SFAMOB + ' ' + VS_strCodEmp + ' ' + strLoginUsuarioLogado, LIMIT_TEMP_SFAMOB);

    LLogTmr.Exit;
  End;

end;

procedure TfrmPrincipal.mnuDigAtualizaPrecoClick(Sender: TObject);
begin
  pCriarForm(TfrmDigAtualizaPreco);
end;

procedure TfrmPrincipal.mnuDigCodBarLocFisClick(Sender: TObject);
begin
  pOpeProd(DigCodBarLocFis);
end;

procedure TfrmPrincipal.mnuDigGNREClick(Sender: TObject);
begin
  TfrmDigGNRE.CriarFormulario(tcGNREPadrao);
end;

procedure TfrmPrincipal.mnuManECommerceClick(Sender: TObject);
begin
  pOpeProd(ManECommerce);
end;

procedure TfrmPrincipal.mnuManGarantiaFornecAntEnvioClick(Sender: TObject);
begin
  pCriarForm(TfrmManGarantiaFornecAntEnvio);
end;

procedure TfrmPrincipal.mnuManGerAutCtaPagarClick(Sender: TObject);
begin
  if not fVerificaAcessoSistema(mnuCadCtaPagar.Hint) then
  begin
    fMensagem('', 'Esse usuário não tem direito a acessar esse módulo!', ['&Ok']);
    exit;
  end;
  pCriarForm(TfrmManGerAutCtaPagar);
end;

procedure TfrmPrincipal.mnuDigMovimentoMensalClick(Sender: TObject);
begin
  pCriarForm(TfrmDigMovimentoMensal);
end;

procedure TfrmPrincipal.mnuDigRecursosProjetoClick(Sender: TObject);
begin
  pCriarForm(TfrmDigRecursosProjeto);
end;

procedure TfrmPrincipal.stbStatusDblClick(Sender: TObject);
begin
  If stbStatus.Panels[2].Text <> '' Then
    btnMensagemClick(Sender);
end;

function TfrmPrincipal.Titulo: String;
begin
  Result := Self.Caption;
end;

procedure TfrmPrincipal.mnuSacAtedimentoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadServAtendCliente);
end;

procedure TfrmPrincipal.mnuSacMotivosAtendClick(Sender: TObject);
begin
  pCriarForm(TfrmSacMotivosAtend);
end;

procedure TfrmPrincipal.mnuSelListPrecoClick(Sender: TObject);
begin
  pOpeProd(SelListPreco);
end;

procedure TfrmPrincipal.mnuSenhaOperadorClick(Sender: TObject);
begin
  pCriarForm(TfrmSenhaOperador);
end;

procedure TfrmPrincipal.mnuRelacaoNetpointsClick(Sender: TObject);
begin
  pCriarForm(TfrmRelacaoNetpoints);
end;

procedure TfrmPrincipal.mnuRelacaoPedidosPixGeradosClick(Sender: TObject);
begin
  pCriarForm(TfrmRelacaoPedidosPixGerados,frmRelacaoPedidosPixGerados);
end;

procedure TfrmPrincipal.mnuRelacionamentoClienteProdutoGarantiaClick(
  Sender: TObject);
begin
  pOpeProd(RelClienteProdutoGarantia);
end;

procedure TfrmPrincipal.mnuRelacSemelhancaClick(Sender: TObject);
begin
  pOpeProd(RelacSemelhanca);
end;

procedure TfrmPrincipal.mnuBalancoEstoqueZeraClick(Sender: TObject);
begin
  pOpeProd(BalancoEstoqueZera);
end;

procedure TfrmPrincipal.mnuBalancoEstoqueImportarClick(Sender: TObject);
begin
  pOpeProd(BalancoEstoqueImportar);
end;

procedure TfrmPrincipal.mnuBalancoEstoqueDigColetivoClick(Sender: TObject);
begin
  pOpeProd(BalancoEstoqueDigColetivo);
end;

procedure TfrmPrincipal.mnuBalancoEstoqueDigManualClick(Sender: TObject);
begin
  pOpeProd(BalancoEstoqueDigManual);
end;

procedure TfrmPrincipal.mnuBalancoEstoqueGravacaoClick(Sender: TObject);
//  Var
//    varParam: TOpeProdParam;
var
  frmBalancoEstoqueGravar: TfrmBalancoEstoqueGravar;
begin
//  varParam.fGMovGer := fGravaMovGer;
//  varParam.fGMovDet := fGravaMovDet;
//  pOpeProdParam(BalancoEstoqueGravar,varParam);

  If fEmptyStr( fCampoTabela('AUTOINCREM', 'FINAJU', ['FAJ_CODIGO'], [fCfgSis('FINAJU', varString)]) ) Then
  Begin
    fMensagem('', 'A finalidade do ajuste de estoque não está cadastrada na configuração [CFG_FINAJU].' + #13 +
                  '* Somente após o cadastramento será possível realizar a gravação da contagem.', ['&Ok']);
    Exit;
  End;

  If fEmptyStr(fRetNomCliente(fCfgSis('CLIAJU'))) Then
  Begin
    fMensagem('', 'O cliente configurado para ajuste de estoque não está cadastrado no sistema (CFG_CLIAJU).' +
                  'Por favor verifique.', ['&O k']);
  End

  Else
  Begin
    pCriarFormularios(TfrmBalancoEstoqueGravar, frmBalancoEstoqueGravar);
    Try
      frmBalancoEstoqueGravar.blnContagemControlada := False;
      If TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco Then
      Begin
        frmBalancoEstoqueGravar.blnContagemControlada := True;
        If TControleContagemBalancoEstoque.fVerficaTemBalGerAbertaSemContagem Then
        Begin
          If fPergunta('Atenção! Existem localizações sem contagem deseja excluí-las?') Then
            TControleContagemBalancoEstoque.pRemoveBalGerSemContagem;
        End;

        If TControleContagemBalancoEstoque.fTemBalGerAberta Then
          pMensagemOk('Existem contagens em aberto, não é possivel concluír, verifique no mapa de contagens!')
        Else
          frmBalancoEstoqueGravar.ShowModal;
      End
      Else
        frmBalancoEstoqueGravar.ShowModal;
    Finally
      pFreeAndNil(frmBalancoEstoqueGravar);
    End;
  End;
end;

procedure TfrmPrincipal.mnuFatManConsertoEquipClick(Sender: TObject);
begin
  If (fEmptyStr(fCfgSis('ITESER', varString))) Then Begin
    fMensagem('', 'A configuração [CFG_ITESER] deve ser informada para prosseguir com a rotina de Manutenção de Ordem de Serviços!', ['&OK']);
    Exit;
  End;

  pCriarForm(TfrmFatManConsertoEquip);
end;

procedure TfrmPrincipal.mnuFatManConsertoEquipTecClick(Sender: TObject);
var
  frmFatManConsertoEquipLocal: TfrmFatManConsertoEquip;
begin
  try
    pCriarFormularios(TfrmFatManConsertoEquip, frmFatManConsertoEquipLocal);
    frmFatManConsertoEquipLocal.blnRotinaTecnico := True;
    frmFatManConsertoEquipLocal.ShowModal;
  finally
    pFreeAndNil(frmFatManConsertoEquipLocal);
  end;
end;

procedure TfrmPrincipal.mnuFatManConsertoFluxoProcessoClick(Sender: TObject);
begin
  pCriarForm(TfrmFatManConsertoFluxoProcesso);
end;

procedure TfrmPrincipal.mnuFatManifestoEletronicoClick(Sender: TObject);
begin
  pCriarForm(TfrmFatManifestoEletronico);
end;

procedure TfrmPrincipal.mnuFatManifestoEletronicoEncerradosClick(
  Sender: TObject);
begin
  pCriarForm(TfrmFatManifestoEletronicoEncerrados);
end;

procedure TfrmPrincipal.mnuFatManifestoEletronicoEventoPagamentoOperacaoTransporteClick(
  Sender: TObject);
begin
  pCriarForm(TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte);
end;

procedure TfrmPrincipal.mnuFatManPedCortadoFaltaEstoqueClick(Sender: TObject);
begin
  pCriarForm(TfrmFatManPedCortadoFaltaEstoque);
end;

procedure TfrmPrincipal.mnuFatManutencaoManifestoEletronicoClick(
  Sender: TObject);
begin
  pCriarForm(TfrmFatManutencaoManifestoEletronico);
end;

procedure TfrmPrincipal.mnuFatMensalLocEquipClick(Sender: TObject);
begin
  pCriarForm(TfrmFaturaMensalLocEqu);
end;

procedure TfrmPrincipal.mnuFatRequisicaoComprasClick(Sender: TObject);
begin
  pCriarForm(TfrmFatRequisicaoCompras);
end;

procedure TfrmPrincipal.mnuRelCtrCompAgrupDupClick(Sender: TObject);
begin
  pCriarForm(TfrmRelCtrCompAgrupDup);
end;

procedure TfrmPrincipal.mnuImportTabPrecosItegerClick(Sender: TObject);
begin
  pOpeProd(ImportTabPreIteger);
end;

procedure TfrmPrincipal.mnuImpressaoCPClick(Sender: TObject);
  Var
    frmImpressaoCP: TfrmImpressaoCP;
begin
  pCriarFormularios(TfrmImpressaoCP, frmImpressaoCP);
  frmImpressaoCP.ShowModal;
  pFreeAndNil(frmImpressaoCP);
end;

procedure TfrmPrincipal.mnuImpressodoBalanceteFinanceiro1Click(Sender: TObject);
begin

  If Assigned(prcExecutaRelatorio) Then
  begin

    If fncExecutaRelatorio(206, 7605, [],
                        [],
                        [],
                        Sender,
                        nil,
                        True,
                        False) then
     begin

       If fPergunta('As Contas do Plano de Contas relacionadas estão na Movimentação Bancária,' + #$A#$D +
                    'porém não estão relacionadas na Classificação de Plano de Contas.' + #$A#$D +
                    'Haverá divergência de valores em relação ao Conta Corrente Bancário. Deseja prosseguir?') Then
       begin
          prcExecutaRelatorio(234, 7970, [7971],
                          [],
                          [],
                          Sender,
                          nil,
                          False);
       end;

     end
     else
     begin

       prcExecutaRelatorio(234, 7970, [7971],
                    [],
                    [],
                    Sender,
                    nil,
                    False);


     end;

  End;

end;

procedure TfrmPrincipal.mnuRelFiscResumoApIcmsClick(Sender: TObject);
begin
  pCriarForm(TfrmRelFiscResumoApIcms);
end;

procedure TfrmPrincipal.mnuRelFiscCreIcmVendInterestClick(Sender: TObject);
begin
  pCriarForm(TfrmRelFiscCreIcmVendInterest);
end;

procedure TfrmPrincipal.mnuRelFiscDiarioAuxiliarClick(Sender: TObject);
begin
  pRelatorioLivrosFiscais(relFiscDiarioAuxiliar);
end;

procedure TfrmPrincipal.mnurelFiscGerArqAcSef107_2011Click(Sender: TObject);
begin
  If fEmptyStr(fCfgSis('NROCEF')) Then
  Begin
    pMensagemOk('Configure o Número do Acordo Sefaz (Termo de Acordo de Ressarcimento) na aba Dados Fiscais em Configurações do Sistema!');
    Exit;
  End;

  If fCfgSis('MODRES', varInteger) = 2 Then
  Begin
    If (Not fTabelaExiste(fCfgSis('ARQINV'))) Or
       (fCfgSis('DTAINV', varDate) = 0) Then
    Begin
      pMensagemOk('Configure o nome da Tabela de Inventário e a Data do Inventário na aba Dados Fiscais em Configurações do Sistema!');
      Exit;
    End;

    pCriarForm(TfrmRelFiscGerArqAcMod2);
  End
  Else
    pCriarForm(TfrmRelFiscGerArqAcSef107_2011);

end;

procedure TfrmPrincipal.mnuCadFaixaFatVendClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFaixaFatVend);
end;

procedure TfrmPrincipal.mnuCadFaixaPrzMedClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFaixaPrzMed);
end;

procedure TfrmPrincipal.mnuCadFasApontamentoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFasApontamento);
end;

procedure TfrmPrincipal.mnuCadFasesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFases);
end;

procedure TfrmPrincipal.mnuCadFasObrClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFasObr);
end;

procedure TfrmPrincipal.mnuCadFatMetasVendedorFatLiqClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMetasFatLiq);
end;

procedure TfrmPrincipal.mmuRelCtrReceberClick(Sender: TObject);
begin
  pCriarForm(TfrmRelCtrReceber,frmRelCtrReceber);
end;

procedure TfrmPrincipal.mnuCadFeriadoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFeriado);
end;

procedure TfrmPrincipal.mnuCadFinalidadeAjusteClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFinalidadeAjuste, frmCadFinalidadeAjuste);
end;

procedure TfrmPrincipal.mnuCadFinClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFin);
end;

procedure TfrmPrincipal.mnuFatAltVendedorClick(Sender: TObject);
begin
  pCriarForm(TfrmFatAltVendedor);
end;

procedure TfrmPrincipal.mnuFatAnaliseCustoPedidoClick(Sender: TObject);
begin
  pCriarForm(TfrmFatDigPedidoEmpresa);
end;

procedure TfrmPrincipal.mnuFatAltEmbarcacaoClick(Sender: TObject);
begin
  pCriarForm(TfrmFatAltEmbarcacoes);
end;

procedure TfrmPrincipal.mnuCadIndComClick(Sender: TObject);
begin
  If Not fLock_Unlock('COMIAT', True, False) Then
  Begin
    fMensagem('', 'Este cadastro está sendo utilizado em Outra Estação por ' +
                   fGetHostLock('COMIAT')  + '!', ['&Ok']);
    Exit;
  End;

  If Not fLock_Unlock('COMINT', True, False) Then
  Begin
    fMensagem('', 'Este cadastro está sendo utilizado em Outra Estação por ' +
                   fGetHostLock('COMINT')  + '!', ['&Ok']);
    Exit;
  End;

  pCriarForm(TfrmCadIndCom);

  fLock_Unlock('COMIAT', False, False);
  fLock_Unlock('COMINT', False, False);
end;

procedure TfrmPrincipal.mnuCadIndicadorOperacaoServicoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadIndicadorOperacaoServico);
end;

procedure TfrmPrincipal.mnuCadComPesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadComPes);
end;

procedure TfrmPrincipal.mnuCadCotacaoDiariaCombustiveisClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCotacaoDiariaCombustiveis);
end;

procedure TfrmPrincipal.mnuCadCotacaoMoedaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCotacaoMoeda);
end;

procedure TfrmPrincipal.mnuCadCotacaoRelacClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCotacaoRelac, frmCadCotacaoRelac);
end;

procedure TfrmPrincipal.mnuCadCotacoesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCotacaoCX, frmCadCotacaoCX);
end;

procedure TfrmPrincipal.mnuCadFaixaDescTabPrecoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFaixaDescTabPreco, frmCadFaixaDescTabPreco);
end;

procedure TfrmPrincipal.mnuCadFaixaMargemTabPrecoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFaixaMargemTabPreco, frmCadFaixaMargemTabPreco);
end;

procedure TfrmPrincipal.mnuCadFaixaDescTabPrecoLinhaGrupoClick(Sender: TObject);
  var
    frmCadFaixaDescTabPrecoLinhaGrupo : TfrmCadFaixaDescTabPrecoLinhaGrupo;
begin
  pCriarFormularios(TfrmCadFaixaDescTabPrecoLinhaGrupo, frmCadFaixaDescTabPrecoLinhaGrupo);
  Try
    frmCadFaixaDescTabPrecoLinhaGrupo.Showmodal;
  Finally
    pFreeAndNil(frmCadFaixaDescTabPrecoLinhaGrupo);
  End;
end;

procedure TfrmPrincipal.mnuEditorEtiquetasCaixasArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeCaixasArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasCaixasLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeCaixasLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasCliLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeClienteLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasDespachoArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeDespachoArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasDespachoFaturarPedidoArgoxClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeDespachoFaturarExpedidoArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasDespachoFaturarPedidoLaserClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeDespachoFaturarExpedidoLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasDespachoLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeDespachoLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasDespachoLaserECommerceClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeDespachoLaserECommerce, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasDespachoVolumeGeralArgoxClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeEtiquetaDespachoVolumeGeralArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasDespachoVolumeGeralLaserClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeEtiquetaDespachoVolumeGeralLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasDespachoVolumeIndividualArgoxClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeEtiquetaDespachoVolumeIndividualArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasDespachoVolumeIndividualLaserClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeEtiquetaDespachoVolumeIndividualLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasDivArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeDiversosArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasDivLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeDiversosLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasEstArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeEstruturaArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasForArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeFornecedorArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasForLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeFornecedorLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIDDoPlanoDeRecebimentoArgoxClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpePlanoDeRecebimentoEtiquetaIDArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIDDoPlanoDeRecebimentoLaserClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpePlanoDeRecebimentoEtiquetaIDLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIndividuaisDespachoProdutoArgoxClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeDespachoProdutoArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteArgCodBarCPreClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeItensArgoxCodBarCPre, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteArgCodBarSPreClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeItensArgoxCodBarSPre, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteArgGondCPreClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeItensArgoxGondolaCPre, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteArgGondCPreLayout1Click(Sender: TObject);
begin
  pEditorEtiqueta(tpeItensArgoxGondolaCPreLayout1, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteArgGondSPreClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeItensArgoxGondolaSPre, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteLasCodBarPadrClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeItensLaserCodBarPadr, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteLasCodBarPersClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeItensLaserCodBarPers, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteLasCodBarSPreClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeItensLaserCodBarSPre, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeItensLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasItensCPFArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeItensCPFArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasItensCPFLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeItensCPF, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasItensQtdRestAvuClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeUnidadesRestantesArgoxAvu, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasItensQtdRestFatClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeUnidadesRestantesArgoxFat, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteOrcPedArgCodBarCPreClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeItensOrcPedArgoxCodBarCPre, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteOrcPedArgCodBarSPreClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeItensOrcPedArgoxCodBarSPre, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteOrcPedArgGondCPreClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeItensOrcPedArgoxGondolaCPre, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteOrcPedArgGondSPreClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeItensOrcPedArgoxGondolaSPre, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteOrcPedLasClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeItensOrcPedLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteOrcPedLasCodBarClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeItensOrcPedLaserCodBar, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteOrcPedZebCodBarCPreClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeItensOrcPedZebraCodBarCPre, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteOrcPedZebCodBarSPreClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeItensOrcPedZebraCodBarSPre, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteOrcPedZebGondCPreClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeItensOrcPedZebraGondolaCPre, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteOrcPedZebGondSPreClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeItensOrcPedZebraGondolaSPre, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteZebCodBarCPreClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeItensZebraCodBarCPre, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteZebCodBarSPreClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeItensZebraCodBarSPre, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteZebGondCPreClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeItensZebraGondolaCPre, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasIteZebGondSPreClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeItensZebraGondolaSPre, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasOpeLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeOperadorLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasOPIClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeOPIndustrialArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasOPLaserArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeOrdemProducaoArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasOPLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeOrdemProducao, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasOPLaserZebraClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeOrdemProducaoZebra, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasOrdemServicoZebraClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeOrdemServicoZebra, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasPreArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpePrecificacaoProdutosArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasPreLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpePrecificacaoProdutosLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasProducaoTintaClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeProducaoTintaMaquina, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasProdutosContArgoxClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeItensControladosArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasProdutosContLaserClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeItensControladosLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasProdutosQtdFracionadaArgoxClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeProdutoQuantidadeFracionadaArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasProdutosQtdFracionadaLaserClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeProdutoQuantidadeFracionadaLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEntConferenciaCancelClick(Sender: TObject);
begin
  pCriarForm(TfrmEntConferenciaCancel);
end;

procedure TfrmPrincipal.mnuEntConferenciaClick(Sender: TObject);
begin
  pCriarForm(TfrmEntConferencia);
end;

procedure TfrmPrincipal.mnuEntConferPreNotaClick(Sender: TObject);
begin
  pCriarForm(TfrmEntConferPreNota);
end;

procedure TfrmPrincipal.mnuEntEnderecamentoProdutoClick(Sender: TObject);
begin
  If (fCfgSis('CTLEST') = '2') And fEmptyStr(fRetNomCliente(fCfgSis('CLI_TA'))) Then
  Begin
    pMensagemOk('Configure o Código do Cliente para Transferências de Estoque ' +
                'entre Armazéns (CFG_CLI_TA) nas Configurações do Sistema!');
    Exit;
  End;

  pCriarForm(TfrmEntEnderecamentoProduto);
end;

procedure TfrmPrincipal.mnuFaixaDeDescontoPorLinhaGrupoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFaixaDescontoLinhaGrupo);
end;

procedure TfrmPrincipal.mnuFaixaDeDescontoPorLinhaGrupoClienteClick(
  Sender: TObject);
begin
  pCriarForm(TfrmCadFaixaDescontoLinhaGrupoCliente);
end;

procedure TfrmPrincipal.mnuFaixaDeDescontoPorLinhaGrupoGerenteClick(
  Sender: TObject);
begin
  pCriarForm(TfrmCadFaixaDescontoLinhaGrupoGerente);
end;

procedure TfrmPrincipal.mnuFaixaDeDescontoPorLinhaGrupoSubgerenteClick(
  Sender: TObject);
begin
  pCriarForm(TfrmCadFaixaDescontoLinhaGrupoSubGerente);
end;

procedure TfrmPrincipal.mnuFaixaDeDescontoPorLinhaGrupoVendedorClick(
  Sender: TObject);
begin
  pCriarForm(TfrmCadFaixaDescontoLinhaGrupoVendedor);
end;

procedure TfrmPrincipal.mnuFaixasCondPagAgrClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFaixasCndPagAgr);
end;

procedure TfrmPrincipal.mnuFaixasCondPagGeraNotaDebitoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFaixasCndPagGeraNotaDebito);
end;

procedure TfrmPrincipal.mnuFatAcompEntregaClick(Sender: TObject);
begin
  pCriarForm(TfrmConsultaPedidos);
end;

procedure TfrmPrincipal.mnuFatAltComissaoClick(Sender: TObject);
begin
  pCriarForm(TfrmFatAltComissao);
end;

procedure TfrmPrincipal.mnuFatAlteraDtaEntFutClick(
  Sender: TObject);
begin
  pCriarForm(TfrmFatAlteraDtaEntFut);
end;

procedure TfrmPrincipal.mnuFatAlteraTransRomaneioClick(Sender: TObject);
begin
  pCriarForm(TfrmFatAlteraTransRomaneio);
end;

procedure TfrmPrincipal.mnuFatAltEventoClick(Sender: TObject);
begin
  pCriarForm(TfrmFatAltEvento);
end;

procedure TfrmPrincipal.mnuFatAltLoteItemClick(Sender: TObject);
begin
  pCriarForm(TfrmFatAltLoteItem);
end;

procedure TfrmPrincipal.mnuFatAltMecanicoClick(Sender: TObject);
begin
  pCriarForm(TfrmFatAltMecanico);
end;

procedure TfrmPrincipal.mnuEntFreConhecimentoClick(Sender: TObject);
  Var
    objLisFre: TFreConLista;
begin
  objLisFre := TFreConLista.Create(Self, True, False);
  objLisFre.pGridConhecimento;
  FreeAndNil(objLisFre);
end;

procedure TfrmPrincipal.mnuEntFreConImportacaoEntradaClick(Sender: TObject);
  Var
    frmEntFreConImpVarios: TfrmEntFreConImpVarios;
begin
  pCriarFormularios(TfrmEntFreConImpVarios, frmEntFreConImpVarios);
  Try
    frmEntFreConImpVarios.tpFrete := tpfEntrada;
    frmEntFreConImpVarios.Showmodal;
  Finally
    FreeAndNil(frmEntFreConImpVarios);
  End
end;

procedure TfrmPrincipal.mnuEntFreConImportacaoSaidaClick(Sender: TObject);
  Var
    frmEntFreConImpVarios: TfrmEntFreConImpVarios;
begin
  pCriarFormularios(TfrmEntFreConImpVarios, frmEntFreConImpVarios);
  Try
    frmEntFreConImpVarios.tpFrete := tpfSaida;
    frmEntFreConImpVarios.Showmodal;
  Finally
    FreeAndNil(frmEntFreConImpVarios);
  End
end;

procedure TfrmPrincipal.mnuCadGerAutDespFinClick(Sender: TObject);
var
  LfrmGerAutDespesasFinanceiras: TfrmGerAutDespesasFinanceiras;
begin
  pCriarFormularios(TfrmGerAutDespesasFinanceiras, LfrmGerAutDespesasFinanceiras);
  Try
    LfrmGerAutDespesasFinanceiras.ShowModal;
  Finally
    pFreeAndNil(LfrmGerAutDespesasFinanceiras);
  End;
end;

procedure TfrmPrincipal.mnuCadGiaFundamentoLegalClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFundamentoLegalGia);
end;

procedure TfrmPrincipal.mnuCadGiaOcorrenciasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadOcorrenciasGia);
end;

procedure TfrmPrincipal.mnuCadGlaBasesClick(Sender: TObject);
begin
  Try
    pCarregaMenuTintaMaquinaSobDemanda;

    If HandleDllAuttin <> 0 Then
      pCriaFormularioBaseGlasurit;
  Finally
    pFinalizaAuttin;
  End;
end;

procedure TfrmPrincipal.mnuCadGlaGeraArquivoClick(Sender: TObject);
begin
  Try
    pCarregaMenuTintaMaquinaSobDemanda;

    If HandleDllAuttin <> 0 Then
      pCriaFormularioGerArqGlasurit;
  Finally
    pFinalizaAuttin;
  End;
end;

procedure TfrmPrincipal.mnuCadGlaGerNfmClick(Sender: TObject);
begin
  Try
    pCarregaMenuTintaMaquinaSobDemanda;

    If HandleDllAuttin <> 0 Then
      pCriaFormularioGerarNovasFormulasGlasurit(Self);
  Finally
    pFinalizaAuttin;
  End;
end;

procedure TfrmPrincipal.mnuCadGlaNovasFormulasClick(Sender: TObject);
begin
  Try
    pCarregaMenuTintaMaquinaSobDemanda;

    If HandleDllAuttin <> 0 Then
      pCriaFormularioNovasFormulasGlasurit;
  Finally
    pFinalizaAuttin;
  End;
end;

procedure TfrmPrincipal.mnuCadGostoMusicalClick(Sender: TObject);
begin
  pCriarForm(TfrmCadGostoMusical);
end;

procedure TfrmPrincipal.mnuCadGPCClick(Sender: TObject);
begin
  pCriarForm(TfrmCadGPC, frmCadGPC);
end;

procedure TfrmPrincipal.mnuCadGruComprasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadGruCompras);
end;

procedure TfrmPrincipal.mnuPainelAcompanhamentoOSClick(Sender: TObject);
begin
  pCriarForm(TfrmPainelAcompanhamentoOS);
end;

procedure TfrmPrincipal.mnuPaineldeReposicaodeGondolaClick(Sender: TObject);
begin
  TGerenciaMovimentacaoGondola.pPainelGondola;

end;

procedure TfrmPrincipal.mnuPaineldeRequisicoesDeComprasClick(Sender: TObject);
var objReq : TRequisicaoPedidoCompra;
begin
  objReq := TRequisicaoPedidoCompra.Create;
  Try
    objReq.FProcIniciaCotacao := pProcIniciaCotacao;
    objReq.FProcIniciaPedComp := ProcIniciaPedComp;
    objReq.pCarregaPainelRequisicoes;
  Finally
    FreeAndNil(objReq)
  End;
end;

procedure TfrmPrincipal.mnuCadOriFgoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadOriFgo, frmCadOriFgo);
end;

procedure TfrmPrincipal.mnuPainelECommerceClick(Sender: TObject);
begin
  pCriarForm(TfrmPainelECommerce);
end;

procedure TfrmPrincipal.mnuPainelEntregasClick(Sender: TObject);
begin
  {$IFDEF TESTABILIDADE_AUTCOM}
    // Funções utilizadas nos testes automatizados
  {$Else}
    pAbrirPainelEntregas;
  {$ENDIF}
end;

procedure TfrmPrincipal.mnuPainelFusionClick(Sender: TObject);
var
  frmPainelFusion: TfrmPainelFusion;
begin
  frmPainelFusion := TfrmPainelFusion.Create(Self);
  Try
    frmPainelFusion.ShowModal;
  Finally
    FreeAndNil(frmPainelFusion);
  End;
end;

procedure TfrmPrincipal.mnuPainelRessuprimentosClick(Sender: TObject);
begin
  pCriarForm(TfrmPainelRessuprimento);
end;

procedure TfrmPrincipal.mnuPedeUnificacaoPedidosClick(Sender: TObject);
  Var
    objUnificacaoPedidos: TUnificacaoPedidos;
begin
  objUnificacaoPedidos := TUnificacaoPedidos.Create(Self);
  objUnificacaoPedidos.pUnificacaoPedidos;
  FreeAndNil(objUnificacaoPedidos);
end;

procedure TfrmPrincipal.mnuPedidoCompraLiberacaoClick(Sender: TObject);
  Var
    frmPedidoCompraLiberacao: TfrmPedidoCompraLiberacao;
begin
  pCriarFormularios(TfrmPedidoCompraLiberacao, frmPedidoCompraLiberacao);
  Try
    frmPedidoCompraLiberacao.pImprimePedidoCompra := untInicializaDllPedido.pImprimePedidoCompraAutCom;
    frmPedidoCompraLiberacao.Showmodal;
  Finally
    FreeAndNil(frmPedidoCompraLiberacao);
  End;
end;

procedure TfrmPrincipal.mnuEntImportaNotaEletClick(
  Sender: TObject);
begin
  pCriarForm(TfrmEntImportaNotaElet);
end;

procedure TfrmPrincipal.mnuEntImportaNotaEletDivFiscalClick(Sender: TObject);
begin
  pCriarForm(TfrmEntImportaNotaEletDivFiscal);
end;

procedure TfrmPrincipal.mnuCadComEntregadoresClick(Sender: TObject);
begin
  pCriarForm(TfrmCadComEntregadores);
end;

procedure TfrmPrincipal.mnuCadComFaiFatDepVenProFatorClick(Sender: TObject);
begin
  TfrmCadComFaiFatDepVenProFator.pCadastrarFaixaComissao();
end;

procedure TfrmPrincipal.mnuCadComFat2Click(Sender: TObject);
  var
    frmCadComFat : TfrmCadComFat;
begin
  Try
    Try
      pCriarFormularios(TfrmCadComFat, frmCadComFat);
      frmCadComFat.TipoComissao := tcMecanico;
      frmCadComFat.showModal;
    Except
      on E: Exception do
        pMensagensErro(E.Message, '[mnuCadComFatClick]');
    End;
  Finally
    pFreeAndNil(frmCadComFat);
  End;
end;

procedure TfrmPrincipal.mnuCadComFatClick(Sender: TObject);
  var
    frmCadComFat : TfrmCadComFat;
begin
  Try
    Try
      pCriarFormularios(TfrmCadComFat, frmCadComFat);
      frmCadComFat.TipoComissao := tcDepartamento;
      frmCadComFat.showModal;
    Except
      on E: Exception do
        pMensagensErro(E.Message, '[mnuCadComFatClick]');
    End;
  Finally
    pFreeAndNil(frmCadComFat);
  End;
end;

procedure TfrmPrincipal.mnuCadComFatDepartClick(Sender: TObject);
begin
  pCriarForm(TfrmCadComFatDepart);
end;

procedure TfrmPrincipal.mnuCadComFatMarDepartClick(Sender: TObject);
begin
  pCriarForm(TfrmCadComFatMarDepart, frmCadComFatMarDepart);
end;

procedure TfrmPrincipal.mnuCadComFatVendClick(Sender: TObject);
begin
  pCriarForm(TfrmCadComFatVend);
end;

procedure TfrmPrincipal.mnuCadComFatVendDepartClick(Sender: TObject);
begin
  pCriarForm(TfrmCadComFatVendDepart);
end;

procedure TfrmPrincipal.mnuCadComissaoProdTabPreClick(Sender: TObject);
var
  frmCadComissaoProdTabPre: TfrmCadComissaoProdTabPre;
begin
  pCriarFormularios(TfrmCadComissaoProdTabPre, frmCadComissaoProdTabPre);
  try
    frmCadComissaoProdTabPre.ShowModal;
  finally
    pFreeAndNil(frmCadComissaoProdTabPre);
  end;
end;

procedure TfrmPrincipal.mnuBaixaEntregadoresClick(Sender: TObject);
begin
  pCriarForm(TfrmBaixaEntregadores);
end;

procedure TfrmPrincipal.mnuBaixaOrdemProducaoIndustrialGeralClick(
  Sender: TObject);
begin
  pCriarFormularios(TfrmBaixaOrdProdGeralIndustrial, frmBaixaOrdProdGeralIndustrial);
  frmBaixaOrdProdGeralIndustrial.ShowModal;
  FreeAndNil(frmBaixaOrdProdGeralIndustrial);
end;

procedure TfrmPrincipal.mnuBaixaOrdProdGeralClick(Sender: TObject);
begin
  pCriarForm(TfrmBaixaOrdProdGeral);
end;

procedure TfrmPrincipal.mnuCtrDescontadaClick(Sender: TObject);
begin
  pCriarForm(TfrmCtrDescontada);
end;

procedure TfrmPrincipal.mnuCtrGeracaoDesCobChequesClick(Sender: TObject);
begin
  {***************************************}
  {* VERIFICAÇÃO DA CONFIGURAÇÃO QUE USA *}
  {* EM SEU SELECT                       *}
  {*25/02/2015*REQ:30057***************AF*}
  If fEmptyStr(fCfgSis('PORDCB')) Then
  Begin
    pMensagemOk('Para acessar esta rotina será necessário configurar ' +
                '"[CFG_PORDCB]Cheques Devolvidos Espécie CH - Portador para geração de despesas de cobrança". ' +
                'Procure o responsável pela configuração do sistema.');
    Exit;
  End;

  pCriarForm(TfrmCtrGeracaoDesCobCheques);
end;

procedure TfrmPrincipal.mnuCadAutAbaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAutAba);
end;

procedure TfrmPrincipal.mnuCadAutorizadosWSClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAutorizadosWebService);
end;

procedure TfrmPrincipal.mnuAlteracaoEntregaFuturaClick(Sender: TObject);
begin
  pCriarForm(TfrmAlteracaoEntregaFutura);
end;

procedure TfrmPrincipal.mnuAlteracaoFreteSugestaoClick(Sender: TObject);
begin
  pCriarForm(TfrmFatAltValorFreteSuges);
end;

procedure TfrmPrincipal.mnuAlteracaoGlobalProdutosAcabadosClick(
  Sender: TObject);
begin
  pOpeProd(AltGlobalProdutosAcabados);
end;

procedure TfrmPrincipal.mnuAlteracaoTipoAtendPedClick(Sender: TObject);
begin
  pCriarForm(TfrmFatAltTipoAtendimento);
end;

procedure TfrmPrincipal.mnuAlteraEstMinMaxClick(Sender: TObject);
begin
  pOpeProd(AlteraEstMinMax);
end;

procedure TfrmPrincipal.mnuAlterarPrazoGarantiaClick(Sender: TObject);
begin
  pCriarForm(TfrmAlterarPrazoGarantia);
end;

procedure TfrmPrincipal.mnuAltGlobalCadClientesClick(Sender: TObject);
begin
  pCriarForm(TfrmAltGlobalCadClientes);
end;

procedure TfrmPrincipal.mnuAltGlobalPromocoesClick(Sender: TObject);
begin
  pOpeProd(AltGlobalPromocoes);
end;

procedure TfrmPrincipal.mnuAltGlobalVenMarClick(Sender: TObject);
begin
  pCriarForm(TfrmAlteraVendedorMarca);
end;

procedure TfrmPrincipal.mnuAltGlobCadCartoesClick(Sender: TObject);
var
  LfrmAltGlobCadCartoes : TfrmAltGlobCadCartoes ;
begin
  Try
    pCriarFormularios(TfrmAltGlobCadCartoes, LfrmAltGlobCadCartoes);
    LfrmAltGlobCadCartoes.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
  pFreeAndNil(LfrmAltGlobCadCartoes);
end;

procedure TfrmPrincipal.mnuAltGlobCadClientesClick(Sender: TObject);
begin
  pCriarForm(TfrmAltGlobCadClientes);
end;

procedure TfrmPrincipal.mnuAltNumLoteClick(Sender: TObject);
begin
  pOpeProd(AltNumLote);
end;

procedure TfrmPrincipal.mnuExpProdColetorClick(Sender: TObject);
begin

  Case (fCfgSis('MODCOE')) of

    1: Begin

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(257, 8676, [],
                              [],
                              [],
                              Sender,
                              nil,
                              False);
          End;

        End;

    2: Begin

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(258, 8677, [8678,8679],
                              [],
                              [],
                              Sender,
                              nil,
                              False);
          End;

        End;

    3: Begin

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(259, 8680, [],
                              [],
                              [],
                              Sender,
                              nil,
                              False);
          End;

        End;

    4: Begin

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(260, 8681, [],
                              [],
                              [],
                              Sender,
                              nil,
                              False);
          End;

        End;

    5: Begin

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(261, 8682, [],
                              [],
                              [],
                              Sender,
                              nil,
                              False);
          End;

        End;

    6: Begin

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(262, 8683, [],
                              [],
                              [],
                              Sender,
                              nil,
                              False);
          End;

        End;

    7: Begin

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(263, 8684, [],
                              [],
                              [],
                              Sender,
                              nil,
                              False);
          End;

        End;

    8: Begin

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(264, 8685, [],
                              [],
                              [],
                              Sender,
                              nil,
                              False);
          End;

        End;

    9: Begin

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(265, 8686, [],
                              [],
                              [],
                              Sender,
                              nil,
                              False);
          End;

        End;

    10: Begin

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(266, 8687, [],
                              [],
                              [],
                              Sender,
                              nil,
                              False);
          End;

        End;

    Else begin

          fMensagem('', 'O MODELO da exportação não foi configurado.' + #13 +
                    'Verifique as configurações do sistema. (CFG_MODCOE)', ['&OK'] );

        end;

  end;

end;

procedure TfrmPrincipal.mnuRelCtpTitPagosComChequeClick(Sender: TObject);
begin
  pRelatorioContasAPagar(relCtpTitPagosComCheque);
end;

procedure TfrmPrincipal.mnuRcxLiberacaoDeCaixasClick(Sender: TObject);
begin
  pCriarForm(TfrmRcxLiberacaoDeCaixas);
end;

procedure TfrmPrincipal.mnuRcxReimpTransferClick(Sender: TObject);
begin
  pCriarForm(TfrmRcxReimpTransfer, frmRcxReimpTransfer);
end;

procedure TfrmPrincipal.mnuRcxTransfLancamentosEntreCaixasClick(
  Sender: TObject);
begin
  pCriarForm(TfrmRcxTransfLancamentosEntreCaixas);
end;

procedure TfrmPrincipal.mnuOcorrenciasRomaneioClick(Sender: TObject);
begin
  pCriarForm(TfrmOcorrenciasRomaneio);
end;

procedure TfrmPrincipal.mnuOPIndMonitoramentoClick(Sender: TObject);
begin
  pCriarForm(TfrmOPIndMonitoramento);
end;

procedure TfrmPrincipal.mnuOrdemServicoProdVendaClick(Sender: TObject);
  Var
    intOpcoes: Integer;
    odTipoFiltro: TFiltroOrdServProd;
    frmFatManOrdSer: TfrmFatManOrdSer;
begin
  intOpcoes := fMensagem('','Selecione o status da ordem de serviço:', ['Abertas', 'Baixadas', 'Todas'], 3);

  Case (intOpcoes) Of
    1: odTipoFiltro := odNaoBaixados;
    2: odTipoFiltro := odBaixados;
    Else odTipoFiltro := odTodos;
  End;

  Try
    pCriarFormularios(TfrmFatManOrdSer, frmFatManOrdSer);
    frmFatManOrdSer.opeTipOpe    := opeBaixaSer;
    frmFatManOrdSer.odTipoFiltro := odTipoFiltro;
    frmFatManOrdSer.ShowModal();
  Finally
    FreeAndNil(frmFatManOrdSer);
  End;
end;

procedure TfrmPrincipal.mnuOrdProAtualizaPrecosClick(Sender: TObject);
begin
  If fCfgSis('TABPRD', varBoolean) Then
    pCriarForm(TfrmOrdProAtualizaPrecos_Dinpar)
  Else
    pCriarForm(TfrmOrdProAtualizaPrecos);
end;

procedure TfrmPrincipal.mnuOrdProdGerAutomClick(Sender: TObject);
begin
  pCriarForm(TfrmOrdProdGeracaoAutomatica);
end;

procedure TfrmPrincipal.mnuOrdProIndustrialEtqClick(Sender: TObject);
begin
  pCriarForm(TfrmOrdProIndustrialEtq);
end;

procedure TfrmPrincipal.mnuAjusteEstoqueContraPartidaClick(Sender: TObject);
  Var
    frmAjusteEstoque: TfrmAjusteEstoque;
begin
  Try
    pCriarFormularios(TfrmAjusteEstoque, frmAjusteEstoque);
    frmAjusteEstoque.blnAjuContrPart := True;
    frmAjusteEstoque.Showmodal;
  Finally
    FreeAndNil(frmAjusteEstoque);
  End;
end;

function TfrmPrincipal.fValidaNumeroParametrosTotem(var AstrParametrosEncontrados: String): Boolean ;
var
  LintCnt: Integer ;
begin
  Result := True ;
  AstrParametrosEncontrados := '' ;
  if VS_AutoatendimentoPagueFacil then
  begin
    if ParamCount <> 3 then
    begin
      AstrParametrosEncontrados := 'Foram encontrados apenas ' + IntTostr(ParamCount) + ' parâmetro(s):' + #13 ;
      for LintCnt := 1 to ParamCount do
      begin
        AstrParametrosEncontrados := AstrParametrosEncontrados + 'Parâmetro ' + inttostr(LintCnt) + ' = ' + ParamStr(LintCnt) + #13 ;
      end ;
      Result := False ;
    end ;
  end ;

end ;

procedure TfrmPrincipal.AbrirCitelDesk;
Var
  strURL: String;
begin
  strURL := fCfgSis('URLWPP',varString);

  If Not strURL.IsEmpty Then
    pBrowserNavigate(strURL);
end;

procedure TfrmPrincipal.AbrirCRM(Opcao: Integer);
Var
  frmCRM: TfrmCRM;
  frmCRMForn: TfrmCRMForn;
begin
  frmCRM    := Nil;
  frmCRMForn:= Nil;

  Case Opcao Of
    0: pCriarForm(TfrmCRM, frmCRM);         //Crm para Cliente
    1: Begin
         Try
           pCriarFormularios(TfrmCRM, frmCRM);
           frmCRM.blnProspecto := True;
           frmCRM.ShowModal;
         Finally
           pFreeAndNil(frmCRM);
         End;
       End;
    2: pCriarForm(TfrmCRMForn, frmCRMForn); //Crm para Fornecedor
  End;
end;

procedure TfrmPrincipal.AbrirCRMClassico;
  Var
    intQtdLib : Integer;
    frmCRM: TfrmCRM;
    frmCRMForn: TfrmCRMForn;
    frmCliForCRM: TfrmCliForCRM;
    blnTmrCompromissosPrincipal: Boolean;
    blnConfirmaCliForCRM: boolean;
    intOpcaoSelCliForCRM: Integer;
begin
  frmCRM       := nil;
  frmCRMForn   := nil;
  frmCliForCRM := nil;
  blnTmrCompromissosPrincipal := Self.tmrCompromissos.Enabled;

  Try
    try
      pCriarFormularios(TfrmCliForCRM,frmCliForCRM);

      frmCliForCRM.pnlCliente.Enabled    := fVerificaAcessoSistema('CRMCLI');
      frmCliForCRM.pnlProspecto.Enabled  := fVerificaAcessoSistema('CRMPRO');
      frmCliForCRM.pnlFornecedor.Enabled := fVerificaAcessoSistema('CRMFOR');

      intQtdLib := frmCliForCRM.CountOpcoesCRM;

      If (intQtdLib = 0) Then
      Begin
        fMensagem('', 'O usuário logado não tem direito de acesso em nenhum tipo de CRM.' + #13 +
                      'Para acessar esse modulo é necessário permissão em pelo menos uma das opções: Cliente, Prospecto ou Fornecedor.', ['&OK'] );
        Exit;
      End
      Else If (intQtdLib = 1) Then
      Begin
        frmCliForCRM.intOpcaoSel := frmCliForCRM.RetornaUnicaOpcao;
        frmCliForCRM.blnConfirma := True;
      End
      Else
        frmCliForCRM.ShowModal;

      blnConfirmaCliForCRM := frmCliForCRM.blnConfirma;
      intOpcaoSelCliForCRM := frmCliForCRM.intOpcaoSel;
    finally
      pFreeAndNil(frmCliForCRM);
    end;

    If blnConfirmaCliForCRM Then
    Begin
      Self.tmrCompromissos.Enabled := False;

      Case intOpcaoSelCliForCRM Of
        0: pCriarForm(TfrmCRM, frmCRM); //Crm para Cliente
        2: pCriarForm(TfrmCRMForn, frmCRMForn); //Crm para Fornecedor
        1: Begin
             Try
               pCriarFormularios(TfrmCRM, frmCRM);
               frmCRM.blnProspecto := True;
               frmCRM.ShowModal;
             Finally
               pFreeAndNil(frmCRM);
             End;
           End;
      End;
    End;
  Finally
    Self.tmrCompromissos.Enabled := blnTmrCompromissosPrincipal;
  End;
end;

procedure TfrmPrincipal.AbrirCRMNovo;
{$IFDEF TESTABILIDADE_AUTCOM}
//não usa a variável
{$Else}
Var
  intQtdLib: Integer;
{$ENDIF}
begin
  {$IFDEF TESTABILIDADE_AUTCOM}
  //não entra na rotina
  {$Else}
  Try
    fmxCRM := TfmxCRM.Create(Self);

    fmxCRM.recCliente.Enabled    := fVerificaAcessoSistema('CRMCLI');
    fmxCRM.recProspecto.Enabled  := fVerificaAcessoSistema('CRMPRO');
    fmxCRM.recFornecedor.Enabled := fVerificaAcessoSistema('CRMFOR');

    intQtdLib := fmxCRM.CountOpcoesCRM;

    If intQtdLib = 0 Then
    Begin
      fmxCRM.lblAcesso.Visible   := True;
      fmxCRM.flaQuadrado.Visible := False;
      Exit;
    End
    Else If intQtdLib = 1 Then
    Begin
      fmxCRM.lblAcesso.Visible   := False;
      fmxCRM.flaQuadrado.Visible := True;

      fmxCRM.intOpcaoSel := fmxCRM.RetornaUnicaOpcao;
      fmxCRM.blnConfirma := True;
    End
    Else
      fmxCRM.ShowModal;

    If fmxCRM.blnConfirma Then
      AbrirCRM(fmxCRM.intOpcaoSel);

  Finally
    fmxCRM.Free;
  End;
  {$ENDIF}
end;

procedure TfrmPrincipal.mnuAjusteEstoqueSaldoExternoClick(Sender: TObject);
  Var
    frmAjusteEstoque: TfrmAjusteEstoque;
begin
  Try
    pCriarFormularios(TfrmAjusteEstoque, frmAjusteEstoque);
    frmAjusteEstoque.blnAjuContrPart := False;
    frmAjusteEstoque.blnAjuSaldoExterno := True;
    frmAjusteEstoque.Showmodal;
  Finally
    FreeAndNil(frmAjusteEstoque);
  End;
end;

procedure TfrmPrincipal.AlteraodaDatadePrevisodosPedidos1Click(
  Sender: TObject);
begin
  pCriarForm(TfrmFatAltDataPrevisaoPD);
end;

procedure TfrmPrincipal.mnuEtiquetaLoteProdutoClick(Sender: TObject);
begin
  pCriarForm(TfrmImpEtiLoteDoProduto);
end;

procedure TfrmPrincipal.mnuCadGrupoAtividadeClick(Sender: TObject);
begin
  pCriarForm(TfrmCadGrupoAtividade);
end;

procedure TfrmPrincipal.mnuCadGrupoOcorrenciasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadGrupoOcorrencias);
end;

procedure TfrmPrincipal.mnuCadGrupoPrecosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadGrupoPrecos);
end;

procedure TfrmPrincipal.mnuCadGrupoProdutosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadGrupoProdutos);
end;

procedure TfrmPrincipal.mnuCadFaixasCatEtiqProdutoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFaixasCatEtiqProduto);
end;

procedure TfrmPrincipal.mnuCadFaixasCndPagDescClick(
  Sender: TObject);
begin
  pCriarForm(TfrmCadFaixasCndPagDesc);
end;

procedure TfrmPrincipal.mnuCadFaixasVenCndDescClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFaixasVenCndDesc);
end;

procedure TfrmPrincipal.mnuCadControleCreditoFiscaisClick(Sender: TObject);
begin
  If (fTabelaExiste('COCFIS', True)) Then
  Begin
    pValidaProCod('COCFIS');
    pCriarForm(TfrmCadControleCreditoFiscais);
  End
  Else
    fMensagem('ATENÇÃO','A tabela COCFIS não existe, favor entrar em contato com o suporte!', ['&Ok']);
end;

procedure TfrmPrincipal.mnuCadastroDeAlquotasDeICMSporEstadoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadTabelaIcms);
end;

procedure TfrmPrincipal.CadastrodeSetores1Click(Sender: TObject);
begin
  pCriarForm(TfrmCadSetoresFilizola);
end;

{$IFNDEF TESTABILIDADE_AUTCOM}
function TfrmPrincipal.CheckEdgeBrowser: Boolean;
begin
  Result := untFuncoesSimples.CheckEdgeBrowser;
end;
{$ENDIF}

function TfrmPrincipal.CodigoEmpresaLogada: String;
begin
  Result := VS_strCodEmp;
end;

procedure TfrmPrincipal.MnuConcorrentesParaPesquisaDeMercadoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadConcorrPesqMer);
end;

procedure TfrmPrincipal.ContaCorrente1Click(Sender: TObject);
begin
  pCriarForm(TfrmCadCCa);
end;

procedure TfrmPrincipal.mnuConverteClick(Sender: TObject);
begin
  If FileExists(ExtractFilePath(Application.ExeName) + 'ConvertePISCOFINS.exe') Then
  Begin
    WinExec(PAnsiChar(AnsiString(ExtractFilePath(Application.ExeName) + 'ConvertePISCOFINS.exe ' + strLoginUsuarioLogado)), SW_SHOWNORMAL);
  End
  Else
  Begin
    fMensagem('Atenção', 'É necessário o exe do converte na pasta do autcom!', ['&Ok']);
  End;
end;

function TfrmPrincipal.CorIdentificacaoEmpresa: TAlphaColor;
Var
  LColor: String;
  I: Integer;
begin
  Result := TAlphaColor($FF003E5A);

  LColor := fCampoTabela('EMP_CORIDE', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]);

  For I := 0 To Length(AUTCOM_NOME_CORES_IDENT_EMPRESA) -1 Do
    If LColor = AUTCOM_NOME_CORES_IDENT_EMPRESA[I] Then
      Exit(AUTCOM_CORES_IDENT_EMPRESA[I]);
end;

{$IFNDEF TESTABILIDADE_AUTCOM}
procedure TfrmPrincipal.pCriaDashboardAntiga(objDash: IDashboard);
begin
  Try
    fmxDashboardPrincipalOld := TfmxDashboardPrincipalOld.Create(Self);
    fmxDashboardPrincipalOld.blnUsuarioLogadoUtilizaModoClassico := blnUsuarioLogadoUtilizaModoClassico;
    fmxDashboardPrincipalOld.objDash                             := objDash;
    fmxDashboardPrincipalOld.ClientWidth                         := Screen.WorkAreaWidth - 100;
    fmxDashboardPrincipalOld.ClientHeight                        := Screen.WorkAreaHeight - 100;
    fmxDashboardPrincipalOld.Width                               := Screen.WorkAreaWidth;
    fmxDashboardPrincipalOld.Height                              := Screen.WorkAreaHeight - 25;
    fmxDashboardPrincipalOld.scrBarraRolagem.Height              := Screen.WorkAreaHeight - 25;
    fmxDashboardPrincipalOld.scrBarraRolagem.Width               := Screen.WorkAreaWidth;
    fmxDashboardPrincipalOld.WindowState                         := TWindowState.wsMaximized;
    fmxDashboardPrincipalOld.Tag                                 := 1;
    fmxDashboardPrincipalOld.recComCusto.Enabled                 := fVerificaAcessoSistema('mnuFiltroComCus');
    fmxDashboardPrincipalOld.btnAbaLoja.Tag                      := Iif(fVerificaAcessoSistema('mnuAbaLojas'), 1, 0);
    fmxDashboardPrincipalOld.ShowModal;
  Finally
    FreeAndNil(fmxDashboardPrincipalOld);
  End;
end;

procedure TfrmPrincipal.pCriaDashboardWeb(objDash: IDashboard);
begin
  Try
    fmxDashboardPrincipal := TfmxDashboardPrincipal.Create(Self);
    fmxDashboardPrincipal.blnUsuarioLogadoUtilizaModoClassico := blnUsuarioLogadoUtilizaModoClassico;
    fmxDashboardPrincipal.objDash                             := objDash;
    fmxDashboardPrincipal.ClientWidth                         := Screen.WorkAreaWidth - 100;
    fmxDashboardPrincipal.ClientHeight                        := Screen.WorkAreaHeight - 100;
    fmxDashboardPrincipal.Width                               := Screen.WorkAreaWidth;
    fmxDashboardPrincipal.Height                              := Screen.WorkAreaHeight - 25;
    fmxDashboardPrincipal.scrBarraRolagem.Height              := Screen.WorkAreaHeight - 25;
    fmxDashboardPrincipal.scrBarraRolagem.Width               := Screen.WorkAreaWidth;
    fmxDashboardPrincipal.WindowState                         := TWindowState.wsMaximized;
    fmxDashboardPrincipal.Tag                                 := 1;
    fmxDashboardPrincipal.recComCusto.Enabled                 := fVerificaAcessoSistema('mnuFiltroComCus');
    fmxDashboardPrincipal.btnAbaLoja.Tag                      := Iif(fVerificaAcessoSistema('mnuAbaLojas'), 1, 0);
    fmxDashboardPrincipal.ShowModal;
  Finally
    FreeAndNil(fmxDashboardPrincipal);
  End;
end;
{$ENDIF}

procedure TfrmPrincipal.pCriarCfgsTinta;
begin
  {****************************************}
  {** VERIFICA SE EXISTE A CONFIGURACAO  **}
  {** SE NÃO EXISTIR CRIA A CONFIGURAÇÃO **}
  {*************************************RG*}
  If Not fEhAdministrador(strLoginUsuarioLogado) Then
  Begin
    pCriarCfgSis('CFG_PREGER', 'Utilizar qual cadastro para tabela de preço de tinta de máquina?', 'AUTTIN', fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', ''));
    pCriarCfgSis('CFG_TABPRE', 'Tabela de preço para cadastro de produto (tinta de máquina):', 'AUTTIN', fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', ''));
    pCriarCfgSis('CFG_UPROAC', 'Utilizar Produto Acabado?', 'AUTTIN', fArqIniTinta(0, 'PRODUTO ACABADO', 'USATIN', ''));
    pCriarCfgSis('CFG_TABTER', 'Tabela de preço para geração de exportação de tintométricos para terceiros:', 'AUTTIN', fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO_TERCEIROS', ''));
  End;
end;

procedure TfrmPrincipal.DesabilitaEnvioEmails;
begin
  if VS_AutcomIniciadoModoRobo then
    Exit;

  If fArqIni(0, 'GERAL', 'FORCAR_ENVIO_EMAIL', '').Equals('S') Then
    fArqIni(1, 'GERAL', 'FORCAR_ENVIO_EMAIL', 'N');
end;

function TfrmPrincipal.DeveEnviarAvisoDeDebito: Boolean;
  Var
    LFeriadoFimDeSemana : TFeriadoFimDeSemana;
begin
  Result := fCfgSis('AVIDEB', varBoolean);

  If Result Then
  Begin
    //Enviar boletos de cobrança Sábado/Domingo/Feriado?
    If Not fCfgSis('AVIUTI', varBoolean) Then
    Begin
      LFeriadoFimDeSemana := fBuscaProxDiaUtil(VS_Date,VS_strCodEmp);
      If Not LFeriadoFimDeSemana.blnDAtaEDiaUtil Then
        Result := False;
    End;

    // Está dentro do horário previsto para execução dos envio ?
    If Not HorarioExecutaRobo(fCfgSis('HORAVI', varString)) Then
      Result := False;

    If fGetTempoDuracaoLock('INSERT_AVISO_DEBITO') <> 0 then
      Result := False;

    If Result Then
      Result := VS_PermitidoEnviarEmail;
  End;
end;

function TfrmPrincipal.DiretorioExecutavel: String;
Var
  LPath : TArray<String>;
begin
  LPath  := ExtractFilePath(Application.ExeName).Split(['\']);
  Result := ' \' + Trim(LPath[High(LPath)]) + '\' + ExtractFileName(Application.ExeName);
end;

procedure TfrmPrincipal.mnuCancelamentoPedidoJadlogClick(
  Sender: TObject);
var
  frmCancelamentoPedidoJadlog: TfrmCancelamentoPedidoJadlog;
begin
  try
    pCriarFormularios(TfrmCancelamentoPedidoJadlog, frmCancelamentoPedidoJadlog);
    try
      frmCancelamentoPedidoJadlog.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[mnuCancelamentoPedidoJadlog]');
        Exit;
      End;
    end;
  finally
    pFreeAndNil(frmCancelamentoPedidoJadlog);
  end;
end;

procedure TfrmPrincipal.mnuEmailMarketingClienteClick(Sender: TObject);
begin
  If VS_strHabilitarCRM And fEmptyStr( fCfgSis('TOCEMA') ) Then
  Begin
    fMensagem('', 'O sistema está configurado para utilizar CRM. Será necessário cadastrar '+#13+
                  'um tipo de ocorrência na configuração [CFG_TOCEMA] para utilizar esta rotina.',['&Ok']);
    Exit;
  End;

  pCriarForm(TfrmEmailMarketing);
end;

procedure TfrmPrincipal.mnuCadDefeitosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadDefeitos);
end;


procedure TfrmPrincipal.mnuDigSerieProdRastreaveisClick(
  Sender: TObject);
begin
  pCriarForm(TfrmDigSerieRastreaveis);
end;

procedure TfrmPrincipal.mnuDigTCIFClick(Sender: TObject);
begin
  TfrmDigGNRE.CriarFormulario(tcTCIF);
end;

procedure TfrmPrincipal.mnuDigTSClick(Sender: TObject);
begin
  TfrmDigGNRE.CriarFormulario(tcTS);
end;

procedure TfrmPrincipal.mnuDigTCIF_EDITClick(Sender: TObject);
begin
  TfrmDigGNRE.CriarFormulario(tcTCIF, True);
end;

procedure TfrmPrincipal.mnuDigTS_EDITClick(Sender: TObject);
begin
  TfrmDigGNRE.CriarFormulario(tcTS, True);
end;

procedure TfrmPrincipal.dxAlertWindowButtonClick(Sender: TObject;
  AAlertWindow: TdxAlertWindow; AButtonIndex: Integer);
Var
  strNumRom : String;
begin
  If AButtonIndex = 0 Then
    pnlLiberaClick(Nil)

  Else If AButtonIndex = 2 Then
    pnlLiberaPedComClick(Nil)

  Else If AButtonIndex = 1 Then
  Begin
    AAlertWindow.Hide;
    pAbreJanelaDeStatusDoSistemaDEPS;
  End

  Else If AButtonIndex = 2 Then
  Begin
    AAlertWindow.Hide;
    pAbreJanelaDeAvisoDePrevisaoCTP;
  End

  Else If AButtonIndex = 3 Then
  Begin
    AAlertWindow.Hide;
    pMarcarLiberacaoLida;
    tmrTemMsgTimer(Self);
  End

  Else If AButtonIndex = 4 Then
  Begin
    AAlertWindow.Hide;
    pnlLibera.Visible := False;
    blnIgnorarPopUpMsgLib := True;
  End

  Else If AButtonIndex = 5 Then
  Begin
    AAlertWindow.Hide;
    strNumRom := AAlertWindow.OptionsButtons.Buttons[5].Hint;
    {$IFDEF TESTABILIDADE_AUTCOM}
      // Funções utilizadas nos testes automatizados
    {$Else}
      pAbrirPainelEntregas(Copy(strNumRom, 16, 6));
    {$ENDIF}
  End;
end;

procedure TfrmPrincipal.mnuCadEquipamentosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEquipamentos);
end;

procedure TfrmPrincipal.mnuImpEtiEmpresaClick(Sender: TObject);
begin
  pCriarForm(TfrmImpEtiEmpresa);
end;

procedure TfrmPrincipal.mnuFatAltComissaoManualCTRClick(Sender: TObject);
begin
  pCriarForm(TfrmFatAltComissaoManualCTR);
end;

procedure TfrmPrincipal.mnuRelFatComVendCndDesClick(
  Sender: TObject);
begin
  pRelatorioFaturamento(RelFatComVendCndDes);
end;

procedure TfrmPrincipal.mnuFatorPrecoCadastroClick(Sender: TObject);
begin
  pCriarForm(TfrmFatorPrecoCadastro);
end;

procedure TfrmPrincipal.mnuFatPromocaoBrindesClick(Sender: TObject);
begin
  pCriarForm(TfrmFatPromocaoBrindes);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasFormulacaoClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeFomulacaoTinta, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasFuncionariosArgoxClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeFuncionarioArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasFuncionariosLaserClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeFuncionarioLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasTintaClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeEntregaTintaMaquina, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorMetasClick(Sender: TObject);
begin
  pCriarForm(TfrmEditorMetas);
end;

procedure TfrmPrincipal.mnuEmailMarketingProspectosClick(Sender: TObject);
begin
  If VS_strHabilitarCRM And fEmptyStr( fCfgSis('TOCEMA') ) Then
  Begin
    fMensagem('', 'O sistema está configurado para utilizar CRM. Será necessário cadastrar '+#13+
                  'um tipo de ocorrência na configuração [CFG_TOCEMA] para utilizar esta rotina.',['&Ok']);
    Exit;
  End;

  pCriarForm(TfrmEmailMarketingProspectos);
end;

procedure TfrmPrincipal.mnuExportacaoSEFAZClick(Sender: TObject);
begin
  pOpeProd(GeracaoFCI_Exportacao);
end;

procedure TfrmPrincipal.mnuRelFatComissaoEspecieCadastroClick(Sender: TObject);
begin
  pCriarForm(TfrmCadComissaoEspecie);
end;

procedure TfrmPrincipal.mnuRelCtpTitDeletadosClick(Sender: TObject);
begin
  pRelatorioContasAPagar(relCtpTitDeletados);
end;

procedure TfrmPrincipal.mnuFatBaixaEmprestimosClick(Sender: TObject);
begin
  pCriarForm(TfrmFatBaixaEmprestimos);
end;

procedure TfrmPrincipal.mnuRelFatEtiArmazenamentoClick(Sender: TObject);
begin
  pCriarForm(TfrmRelFatEtiArmazenamento);
end;

procedure TfrmPrincipal.mnuCadBocaCaixaAltClick(Sender: TObject);
begin
  pOpeProd(CadBocaCaixaAlt);
end;

procedure TfrmPrincipal.mnuFatCancBaixaRomaneioClick(Sender: TObject);
begin
  pCriarForm(TfrmFatCancBaixaRomaneio);
end;

procedure TfrmPrincipal.mnuFatCancelamentoManifestoEletronicoClick(
  Sender: TObject);
begin
  pCriarForm(TfrmFatCancelamentoManifestoEletronico);
end;

procedure TfrmPrincipal.mnuFatConfeEntDocNaoEntreguesClick(Sender: TObject);
begin
  pCriarForm(TfrmFatConfeEntDocNaoEntregues);
end;

procedure TfrmPrincipal.mnuFatConfirmacaoAjustesClick(Sender: TObject);
begin
  If fEmptyStr(fCfgSis('CLCAJE')) Or fEmptyStr(fCfgSis('CLCAJS')) Then
  Begin
    pMensagemOk('Verifique se as classificações fiscais para confirmação ' +
                'de ajuste foram configuradas corretamente!');
    Exit;
  End;

  pCriarForm(TfrmFatConfirmacaoAjustes);
end;

procedure TfrmPrincipal.mnuFatConsEntPendentesClick(Sender: TObject);
begin
  pCriarForm(TfrmFatConsEntPendentes);
end;

procedure TfrmPrincipal.mnuFatControleDataEntregaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadControleEntrega);
end;

procedure TfrmPrincipal.mnuFatConvOrcPedVendaCasadaClick(Sender: TObject);
begin
  pCriarForm(TfrmFatConvOrcPedVendaCasada);
end;

procedure TfrmPrincipal.mnuFatDefineLoteEntregaFuturaFaltaProdutoClick(
  Sender: TObject);
begin
  pCriarForm(TfrmFatDefineLoteEntregaFuturaFaltaProduto);
end;

procedure TfrmPrincipal.mnuFatDesmembrarPedidoClick(Sender: TObject);
var
 frmFatDesmembrarPedido : TfrmFatDesmembrarPedido;
begin
  pCriarFormularios(TfrmFatDesmembrarPedido, frmFatDesmembrarPedido);
  Try
    frmFatDesmembrarPedido.blnDesmembrarOrcamentoPedido := True;
    frmFatDesmembrarPedido.blnPermiteAlterarCndPag := True;
    frmFatDesmembrarPedido.ShowModal();
  Finally
    pFreeAndNil(frmFatDesmembrarPedido);
  End;
end;

procedure TfrmPrincipal.mnuFatDigCartaCorrecaoClick(Sender: TObject);
begin
  pCriarForm(TfrmFatDigCartaCorrecao);
end;

procedure TfrmPrincipal.mnuFatDigitalizacaoDocumentosClick(Sender: TObject);
begin
  pCriarForm(TfrmFatDigitalizacaoDocumentos);
end;

procedure TfrmPrincipal.mnuTransfArmazensClick(Sender: TObject);
begin
  If fEmptyStr(fRetNomCliente(fCfgSis('CLI_TA'))) Then
    pMensagemOk('Configure o Código do Cliente para Transferências de Estoque ' +
    'entre Armazéns (CFG_CLI_TA) nas Configurações do Sistema!')
  Else
    pCriarForm(TfrmTransfArmazens);
end;

procedure TfrmPrincipal.mnuTransfArmazensProdutoAcabadoClick(Sender: TObject);
begin
  If fEmptyStr(fRetNomCliente(fCfgSis('CLI_TA'))) Then
    pMensagemOk('Configure o Código do Cliente para Transferências de Estoque ' +
    'entre Armazéns (CFG_CLI_TA) nas Configurações do Sistema!')
  Else
    pCriarForm(TfrmTransfArmazensProdutoAcabado);
end;

procedure TfrmPrincipal.mnuTransfCheqEmpresaClick(Sender: TObject);
begin
  pCriarForm(TfrmTransfCheqEmpresa);
end;

procedure TfrmPrincipal.mnuRelEstatAnalResultMovBanClick(Sender: TObject);
begin
  pCriarForm(TfrmRelEstatAnalResultBan);
end;

procedure TfrmPrincipal.mnuCadLoteItensClick(Sender: TObject);
begin
  If fCfgSis('UTIWMS', VarBoolean) And (fCadEmp('UTIWMS') = 'N') Then
  Begin
    fMensagem('', 'Cadastro permitido apenas para empresas que Utilizam o WMS', ['&OK']);
    Exit;
  End;

  pCriarForm(TfrmCadLoteItens);
end;

procedure TfrmPrincipal.mnuCadLoteItensRapidoClick(Sender: TObject);
begin
  TfrmCadLoteItens.pCadastroRapidoSemProdutoWMS;
end;

procedure TfrmPrincipal.mnuGeraLivroCaixaClick(Sender: TObject);
begin
{  If fEmptyStr(fRetNomPortador(fCfgSis('PORGER'))) Then
    fMensagem('', 'Cadastre um portador em Configurações/ Movimentação Conta Banco/ Portador para geração do Livro Caixa', ['&Ok'])
  Else
    pCriarForm(TfrmGeraLivroCaixa, frmGeraLivroCaixa);}
end;

procedure TfrmPrincipal.mnuGeraNotaDebitoClick(Sender: TObject);
begin
  pCriarForm(TfrmGeraNotaDebito);
end;

procedure TfrmPrincipal.mnuRelPosContabilChqClick(Sender: TObject);
begin
  pRelatorioChequesPre(relPosContabilChq);
end;

procedure TfrmPrincipal.mnuTxtSfaMobImpClick(Sender: TObject);
begin
  pCriarForm(TfrmTxtSfaMobImp);
end;

procedure TfrmPrincipal.mnuUltimosFechamentosEstoqueClick(Sender: TObject);
begin
  pCriarForm(TfrmUltimosFechamentosEstoque, frmUltimosFechamentosEstoque);
end;

procedure TfrmPrincipal.mnuUltimosFechamentosFiscaisClick(Sender: TObject);
begin
  pCriarForm(TfrmUltimosFechamentosFiscais, frmUltimosFechamentosFiscais);
end;

procedure TfrmPrincipal.mnuImportacaoRetCustodiaClick(Sender: TObject);
begin
  pCriarForm(TfrmImportaRetornoCustodia);
end;

procedure TfrmPrincipal.mnuImportacaoSEFAZClick(Sender: TObject);
begin
  pOpeProd(GeracaoFCI_Importacao);
end;

procedure TfrmPrincipal.mnuImportacaoSfaMobAndroidClick(Sender: TObject);
begin
  If fLock_Unlock(CHAVE_LOCK_SFAMOB, True, False, True) Then
  Begin
    Try
      pCriarForm(TfrmImportacaoSfaMobAndroid)
    Finally
      fLock_Unlock(CHAVE_LOCK_SFAMOB, False);
    End;
  End
  Else
    fMensagem('ATENÇÃO!', 'Esta tela está sendo utilizada por outra estação: ' + fGetHostLock(CHAVE_LOCK_SFAMOB), ['&Ok']);
end;

procedure TfrmPrincipal.mnuImportacaoSimilaridadeClick(Sender: TObject);
begin
  pCriarForm(TfrmImportacaoSimilaridade);
end;

procedure TfrmPrincipal.mnuImportaMovimentoPAFECFClick(Sender: TObject);
begin
  pCriarForm(TfrmImportaMovimentoPAFECF);
end;

procedure TfrmPrincipal.mnuFatConfOrcamentosSiteEmPedidosClick(Sender: TObject);
begin
  pCriarForm(TfrmFatConfOrcamentosSiteEmPedidos);
end;

procedure TfrmPrincipal.mnuImportaNfeParaSpedClick(Sender: TObject);
begin
  pCriarForm(TfrmImportaNfeParaSped);
end;

procedure TfrmPrincipal.mnuImportaPrecosClick(Sender: TObject);
begin
   pCriarForm(TfrmImportaPrecos, frmImportaPrecos);
end;

procedure TfrmPrincipal.mnuImportaoCustosRegimeTributrioFranquiasClick(
  Sender: TObject);
begin
  pCriarForm(TfrmImportacaoCustosRegimeTributarioFranquias);
end;

procedure TfrmPrincipal.mnuImportaoXMLdeNFEparaAuditoriaClick(Sender: TObject);
begin
  TfrmEntImportacaoNotaEletronica.fImportar(xmlEntradaMercadoriaAuditoria);
end;

procedure TfrmPrincipal.mnuImportaProdFranqClick(Sender: TObject);
begin
  Try
    pDesabilitaTimer(tmrImpFranq);

    pOpeProd(ImportaProdFranq);
  Finally
    If (fCfgSis('TMPIMP', varInteger) > 0) And (fVerificaAcessoSistema('frmImportaProdFranq')) Then
      pDesabilitaHabilitaTimerECarregaEventoOnTimer(True,
                                                    tmrImpFranq, tmrImpFranqOnTimer, 'tmrImpFranq',
                                                    Self,
                                                    fCfgSis('TMPIMP', varInteger) * 1000 * 60); 
  End;
end;

procedure TfrmPrincipal.mnuRecTransfEstoqueClick(
  Sender: TObject);
begin
  {If Not fChecaConfiguracoesEntradaMercadorias Then
    Exit;           }

  pCriarForm(TfrmRecTransfEstoque, frmRecTransfEstoque);
end;

procedure TfrmPrincipal.mnuExportacaoImagemProdutosClick(Sender: TObject);
begin
  pCriarForm(TfrmExportarImagensProdutos);
end;

procedure TfrmPrincipal.mnuExportacaoSiteClick(Sender: TObject);
begin
  If fCfgSis('MOEXSI') <> '0' Then
    pCriarForm(TfrmExportacaoSiteMod1);
end;


procedure TfrmPrincipal.mnuExportaXMLNotasRomaneioClick(Sender: TObject);
begin
  pCriarForm(TfrmExportaXMLNotasRomaneio);
end;

procedure TfrmPrincipal.mnuVendaBaseTrocaRecebimentoClick(Sender: TObject);
begin
  If fCfgSis('USAVBT', varBoolean) Then
    pCriarForm(TfrmVendaBaseTrocaRecebimento);
end;

procedure TfrmPrincipal.mnuVendaRemessaForadoEstabelecimentoFaturamentoClick(
  Sender: TObject);
var
  strOpcDoc: String;
  recReabrirForm : TReabrirForm;
begin

  FillChar(recReabrirForm, SizeOf(recReabrirForm), #0);

  If fEmptyStr(fCfgSis('CFVOUT')) Then
  Begin
    pMensagemOk('Configure a Classificação Fiscal para Faturamento de Mercadoria em Remessa em Configurações/Faturamento');
    Exit;
  End;

  Repeat
    pMenuFaturamentoClick(Sender, recReabrirForm, strOpcDoc);
  Until (Not recReabrirForm.blnReabrirForm);

end;

procedure TfrmPrincipal.mnuVendaRemessaForadoEstabelecimentoRemessaClick(
  Sender: TObject);
Var
  strOpcDoc: String;
  recReabrirForm : TReabrirForm;
begin

  FillChar(recReabrirForm, SizeOf(recReabrirForm), #0);

  If (fEmptyStr(fCfgSis('CFRSAI'))) Or (fEmptyStr(fCfgSis('CFRSAS'))) Then
  Begin
    pMensagemOk('Configure a Classificação Fiscal para saída de remessa para fora do estabelecimento (Demais CSTs e Substituido).' + sLineBreak +
                'CFG_CFRSAI e CFG_CFRSAS');
    Exit;
  End;

  Repeat
    pMenuFaturamentoClick(Sender, recReabrirForm, strOpcDoc);
  Until (Not recReabrirForm.blnReabrirForm);

end;

procedure TfrmPrincipal.mnuVendaRemessaForadoEstabelecimentoRetornoClick(
  Sender: TObject);
  Var
    frmFatRetornoRemessa: TfrmFatRetornoRemessa;
begin
  If fEmptyStr(fCfgSis('CFRENT')) Then
  Begin
    pMensagemOk('Configure a Classificação Fiscal para Retorno de Mercadoria em Remessa em Configurações/Faturamento');
    Exit;
  End;

  pCriarFormularios(TfrmFatRetornoRemessa, frmFatRetornoRemessa);

  frmFatRetornoRemessa.blnNfeOutrasEntradas := True;

  frmFatRetornoRemessa.ShowModal;
  pFreeAndNil(frmFatRetornoRemessa);
end;

procedure TfrmPrincipal.mnuVendasPerdidasDigClick(Sender: TObject);
begin
  pCriarForm(TfrmVendasPerdidasDig, frmVendasPerdidasDig);
end;

procedure TfrmPrincipal.mnuVerificadorDeCuponsClick(Sender: TObject);
begin
  pCriarForm(TfrmVerificadorDeCupons);
end;

procedure TfrmPrincipal.MudarMonitor(IndexMonitor: Integer);
Var
  X, Y : Integer;
begin
  X := Screen.Monitors[IndexMonitor].WorkareaRect.Left;
  Y := Screen.Monitors[IndexMonitor].WorkareaRect.Top;

  SetWindowPos(VS_APPLICATION_HANDLE, HWND_TOPMOST, X, Y, 0, 0, SWP_NOSIZE);
end;

procedure TfrmPrincipal.mnuNCMEmpresaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadNCMEmpresa);
end;

procedure TfrmPrincipal.mnuNCMparaoutrospasesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadNCMOutrosPaises);
end;

function TfrmPrincipal.NomeUsuario: String;
begin
  Result := untFuncoesSimples.strDescriUsuarioLogado;
end;

procedure TfrmPrincipal.mnuCadOcorrenciasDoColetorClick(Sender: TObject);
begin
  pCriarForm(TfrmCadOcorrenciasDoColetor);
end;

procedure TfrmPrincipal.OnApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
var
  sMsg: string;
begin
  sMsg := Format('message = {time: %d, hwnd: %d, message: %d, wParam: %d, lParam: %d}',
    [Msg.time, Msg.hwnd, Msg.message, Msg.wParam, Msg.lParam]);
  try
    TFile.AppendAllText(VS_ProcessId + '.msg', DateTimeToStr(fNow()) + ' - ' + sMsg + sLineBreak);
  except
  end;
end;

procedure TfrmPrincipal.mnuEditorEtiquetasMontagemCaixasZebraPackListClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeMontagemCaixasZebraPackList, strCodLay);
end;

procedure TfrmPrincipal.mnuExpFunBoshClick(Sender: TObject);
begin
  pOpeProd(ExpFunBosh);
end;

procedure TfrmPrincipal.mnuCadMetasValorClick(Sender: TObject);
  Var
    frmCadMetasValor : TfrmCadMetasValor;
begin

  Try
    pCriarFormularios(TfrmCadMetasValor, frmCadMetasValor);

    If Assigned(frmCadMetasValor) Then
    Begin
      frmCadMetasValor.blnPorSubMetas := True;
      frmCadMetasValor.ShowModal;
      FreeAndNil(frmCadMetasValor);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuCadMetasValorClick]');
    End;
  End;

end;

procedure TfrmPrincipal.mnuCadMetasValorPedComClick(Sender: TObject);
  Var
    frmCadMetasValorPedCom : TfrmCadMetasValorPedCom;
begin
  frmCadMetasValorPedCom := TfrmCadMetasValorPedCom.Create(Self);
  Try
    frmCadMetasValorPedCom.blnTodasEmpresas := fCfgSis('METPED') = '3';
    frmCadMetasValorPedCom.Showmodal;
  Finally
    FreeAndNil(frmCadmetasValorPedCom);
  End;
end;

procedure TfrmPrincipal.mnuCadMetasVendDepProdClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMetasVendDepProd);
end;

procedure TfrmPrincipal.mnuCadMetasVendedorAtividadeClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMetasVendedorAtividade);
end;

procedure TfrmPrincipal.mnuCadMetasVendLinhaGrupoProdClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMetasVendLinhaGrupoProd);
end;

procedure TfrmPrincipal.mnuCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa);
end;

procedure TfrmPrincipal.mnuCadMetMixClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMetMix);
end;

procedure TfrmPrincipal.mnuCadMetasGalonagemClick(
  Sender: TObject);
begin
  pCriarForm(TfrmCadMetasGalonagem);
end;

procedure TfrmPrincipal.mnuRelCadCustosIndustrialClick(Sender: TObject);
begin
  pCriarForm(TfrmRelCadCustosIndustrial);
end;

procedure TfrmPrincipal.mnuTransfCodMarcaClick(Sender: TObject);
begin
  if fConfirmaTransfCodigo then
    pCriarForm(TfrmTransfCodMarca);
end;

procedure TfrmPrincipal.mnuTransfCodMotoristaClick(Sender: TObject);
begin
  pTransfCod(TransfCodMotorista);
end;

procedure TfrmPrincipal.mnuCadVeiculosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadVeiculos);
end;

procedure TfrmPrincipal.mnuCadVenCndClick(Sender: TObject);
begin
  If fCfgSis('USACND', varBoolean) And fCfgSis('CNPVEN', varBoolean) Then
    pCriarForm(TfrmCadVenCnd);
end;

procedure TfrmPrincipal.mnuCadVenMarClick(Sender: TObject);
begin
  pCriarForm(TfrmCadVenMar);
end;

procedure TfrmPrincipal.mnuCadVerbasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadVerbas);
end;

procedure TfrmPrincipal.mnuCadVerbasCliForClick(Sender: TObject);
begin
  pCriarForm(TfrmCadVerbasCliFor);
end;

procedure TfrmPrincipal.mnuTransfCodUnidadeClick(Sender: TObject);
begin
  pTransfCod(TransfCodUnidade);
end;

procedure TfrmPrincipal.mnuCtpAtribPortadorClick(Sender: TObject);
begin
  pCriarForm(TfrmCtpAtribPortador);
end;

procedure TfrmPrincipal.mnuCtpReprogVenClick(Sender: TObject);
begin
  pCriarForm(TfrmCtpReprogVen);
end;

procedure TfrmPrincipal.mnuRelFiscNFServicosClick(Sender: TObject);
begin
  pRelatorioLivrosFiscais(relFiscNFServicos);
end;

procedure TfrmPrincipal.mnuRelCtrBorderoClick(Sender: TObject);
begin
  pCriarForm(TfrmRelCtrBordero);
end;

procedure TfrmPrincipal.mnuCadDepartamentosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadDepartamentos);
end;

procedure TfrmPrincipal.mnuRelFiscMapaResumoClick(Sender: TObject);
begin
  pCriarForm(TfrmRelFiscMapaResumo);
end;

procedure TfrmPrincipal.mnuCancDevChequePreClick(Sender: TObject);
  Var
    frmCancDepChequePre : TfrmCancDepChequePre;
begin
  Try
    pCriarFormularios(TfrmCancDepChequePre, frmCancDepChequePre);

    If Assigned(frmCancDepChequePre) Then
    Begin
      frmCancDepChequePre.blnCanDev := True;
      frmCancDepChequePre.ShowModal;
      FreeAndNil(frmCancDepChequePre);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCancDevChequePre]');
    End;
  End;
end;

procedure TfrmPrincipal.mnuEtiOrcPedClick(Sender: TObject);
begin
  pCriarForm(TfrmEtiOrcPed);
end;

procedure TfrmPrincipal.mnuEtiPrecificacaoClick(Sender: TObject);
begin
  pCriarForm(TfrmRelEtiPrecificacao);
end;

procedure TfrmPrincipal.mnuEtiqItensCPFClick(Sender: TObject);
begin
  pEtiItemCPF;
end;

procedure TfrmPrincipal.mnuEtiqOrdSerVendaArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeOrdemServicoVendaArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiqOrdSerVendaLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeOrdemServicoVendaLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiqOrdSerVendaZebraClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeOrdemServicoVendaZebra, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetaCaixasClick(Sender: TObject);
begin
  pGeraEtiquetaCaixas;
end;

procedure TfrmPrincipal.mnuEtiquetaDoProdutoSeparadoArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeEtiquetaDoProdutoSeparadoArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetaDoProdutoSeparadoLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeEtiquetaDoProdutoSeparado, strCodLay);

end;

procedure TfrmPrincipal.mnuEtiquetadoProdutoSeparado_QtdRestanteClick(
  Sender: TObject);
begin
  pCriarForm(TfrmEtiquetadoProdutoSeparado_QtdRestante);

end;

procedure TfrmPrincipal.mnuCadBandeiraEmpresaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadBandeiraEmpresa);
end;

procedure TfrmPrincipal.mnuCadParametrosEmpresaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadParametrosEmpresa);
end;

procedure TfrmPrincipal.mnuPastaCompraConsultaClick(Sender: TObject);
begin
  pPastaCompraAutCom;
end;

procedure TfrmPrincipal.mnuPastaComprasExecAuxClick(Sender: TObject);
begin
  pCriarForm(TfrmPastaComprasExecAux);
end;

procedure TfrmPrincipal.mnuCadLimiteComprasFornecedorClick(Sender: TObject);
begin
  pCriarForm(TfrmCadLimiteComprasFornecedor);
end;

procedure TfrmPrincipal.mnuCadBandeirasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadBandeiras);
end;

procedure TfrmPrincipal.mnuCadBaseFreteCFOPClick(Sender: TObject);
begin
  pCriarForm(TfrmCadBaseFreteCFOP);
end;

procedure TfrmPrincipal.mnuRelEstKardexAcabadoClick(Sender: TObject);
begin
  pCriarForm(TfrmRelEstKardexAcabado);
end;

procedure TfrmPrincipal.mnuRelCtpReimpBorderoClick(Sender: TObject);
begin
  pCriarForm(TfrmRelCtpReimpBordero);
end;

procedure TfrmPrincipal.mnuRelCtpReimpressaoDocsClick(Sender: TObject);
begin
  pCriarForm(TfrmRelCtpReimpressaoDoc)
end;

procedure TfrmPrincipal.mnuMenuFiscalPafNFCeClick(Sender: TObject);
var
  frmUtilMenuPAFNFCe: TfrmUtilMenuPAFNFCe;
begin
  Try
    pCriarFormularios(TfrmUtilMenuPAFNFCe, frmUtilMenuPAFNFCe);
    frmUtilMenuPAFNFCe.ShowModal;
  Finally
    FreeAndNil(frmUtilMenuPAFNFCe);
  End;
end;

procedure TfrmPrincipal.mnuCadMetasEmpresaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMetasEmpresa);
end;

(*procedure TfrmPrincipal.mnuMonitorReplicacaoClick(Sender: TObject);
begin
  {** COMENTADO POR POSSUIR UM OUTRO RECURSO COM ESSA FUNCIONALIDADE - KM - Req: 183808 *}
  pCriarForm(TfrmMonitorReplicacao);
end;*)

procedure TfrmPrincipal.mnuMontQuadroFuncEventoClick(Sender: TObject);
begin
  pCriarForm(TfrmMontQuadroFuncEvento);
end;

procedure TfrmPrincipal.mnuMovEcfPafClick(Sender: TObject);
begin
  if Assigned(VS_objFiscal) then
    pCriarForm(TfrmMenuFiscalMovEcf)
  else
  begin
    fMensagem('ATENÇÃO!', 'Esta operação requer uma Impressora Fiscal (ECF).' + #13#10 +
                          'Feche o Sistema AUTCOM e tente conectar novamente com a impressora.' + #13#10 +
                          'Caso o problema persista, entre em contato com o responsável.', ['&Ok']);
  end;
end;

procedure TfrmPrincipal.mnuMovimentacaoProgramadaManualClick(Sender: TObject);
begin
  pCriarForm(TfrmMovimentacaoProgramadaManual);
end;

procedure TfrmPrincipal.mnuRelContratoAberturaCreditoClick(
  Sender: TObject);
begin
  pCriarForm(TfrmRelContratoAberturaCredito);
end;

procedure TfrmPrincipal.mnuFatLiberacaoEntFutClick(
  Sender: TObject);
begin
  pCriarForm(TfrmFatLiberacaoEntFut);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasMontagemCaixasLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeMontagemCaixasLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasMontagemCaixasLaserComCodBarrasClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeMontagemCaixasLaserCodBarras, strCodLay);
end;

procedure TfrmPrincipal.mnuEditorEtiquetasMontagemCaixasLaserPackListClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeMontagemCaixasLaserPackList, strCodLay);
end;

procedure TfrmPrincipal.LayoutsdeImpressodoFaturamento1Click(Sender: TObject);
begin
  pGridDocumento;
end;

function TfrmPrincipal.LoginUsuarioLogado: String;
begin
  Result := untfuncoessimples.strLoginUsuarioLogado;
end;

procedure TfrmPrincipal.mnuImpEtiLocalArmazenamentoWmsClick(Sender: TObject);
begin
  pCriarForm(TfrmImpEtiLocalArmazenamentoWms);
end;

procedure TfrmPrincipal.mnuRelMapaDeCaontagemClick(Sender: TObject);
begin
  pOpeProd(RelMapaDeContagem);
end;

procedure TfrmPrincipal.mnuRelMenuFavoritosClick(Sender: TObject);
 Var
   frmRelMenuFavoritos : TfrmRelMenuFavoritos;
begin
  frmRelMenuFavoritos := TfrmRelMenuFavoritos.Create(Self);
  try
    frmRelMenuFavoritos.ShowModal;
  finally
    pFreeAndNil(frmRelMenuFavoritos);
    fExecutarModal(pGeraMenuRelatoriosFavoritos,'Atualizando Menu de Relatórios Favoritos, Aguarde ...', '');
  end;
end;

procedure TfrmPrincipal.mnuRequisicaoVinculadasComPedidoDeCompraClick(
  Sender: TObject);
begin
  pCriarForm(TfrmRequisicaoVinculadasComPedidoDeCompra);
end;

procedure TfrmPrincipal.mnuImportacaoAbreviacaoIcmsClick(Sender: TObject);
begin
  pCriarForm(TfrmImportacaoAbreviacaoIcms);
end;

{$IFNDEF TESTABILIDADE_AUTCOM}
procedure TfrmPrincipal.MensagemInstalacaoWebView;
begin
  Try
    FmxMensagemInstalacaoWebView := TFmxMensagemInstalacaoWebView.Create(Self);
    FmxMensagemInstalacaoWebView.objFuncoes := TFuncoes.Create;
    FmxMensagemInstalacaoWebView.memMensagem.Lines.Clear;
    FmxMensagemInstalacaoWebView.memMensagem.Lines.Add('As bibliotecas de utilização da Dashboard não estão instaladas.');
    FmxMensagemInstalacaoWebView.memMensagem.Lines.Add('Por favor, efetue a instalação antes de prosseguir!');
    FmxMensagemInstalacaoWebView.ShowModal;
  Finally
    FreeAndNil(FmxMensagemInstalacaoWebView);
  End;
end;
{$ENDIF}

function TfrmPrincipal.MenuPrincipal: IMenuAutcom;
begin
  Result := TMenuAutcom.New(Self.mnuAutcomK);
end;

function TfrmPrincipal.MenuWMS: IMenuAutcom;
begin
  Result := TMenuAutcom.NewPopUp(Self.popWMS);
end;

procedure TfrmPrincipal.mnuRelCartoesLogAcompClick(Sender: TObject);
begin
  pCriarForm(TfrmRelCartoesLogAcomp);
end;

procedure TfrmPrincipal.mnuRelCatalogoLinhaGrupoClick(Sender: TObject);
begin
  pCriarForm(TfrmRelCatalogoLinhaGrupo);
end;

procedure TfrmPrincipal.mnuRelCatalogoProdutoClick(Sender: TObject);
begin
  pCriarForm(TfrmRelCatalogoProduto);
end;

procedure TfrmPrincipal.mnuImpEtiEmpresaLazerClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeEmpresaLazer, strCodLay);
end;

procedure TfrmPrincipal.mnuImpEtiOrdProClick(Sender: TObject);
begin
  pCriarForm(TfrmImpEtiOrdPro);
end;

procedure TfrmPrincipal.mnuCadMetasLitragemClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMetasLitragem);
end;

procedure TfrmPrincipal.mnuCadMetasRapelClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMetasRapel);
end;

procedure TfrmPrincipal.mnuEtiquetasSeparacaoErradaArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeSepErrArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasSeparacaoErradaLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeSepErrLaser, strCodLay);
end;


procedure TfrmPrincipal.mnuCadMetasRecClick(Sender: TObject);
  Var
    frmCadMetasValor : TfrmCadMetasValor;
begin
  Try
    pCriarFormularios(TfrmCadMetasValor, frmCadMetasValor);

    If Assigned(frmCadMetasValor) Then
    Begin
      frmCadMetasValor.tmtTipMet      := tmeRecebimento;
      frmCadMetasValor.blnPorSubMetas := False;
      frmCadMetasValor.ShowModal;
      FreeAndNil(frmCadMetasValor);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuCadMetasClick]');
    End;
  End;
end;

procedure TfrmPrincipal.mnuFatReciboAvulsoClick(Sender: TObject);
begin
  pCriarForm(TfrmRelFatReciboAvulso);
end;

procedure TfrmPrincipal.mnuFatRegClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFatReg);
end;

procedure TfrmPrincipal.mnuFatReimpressaoManifestoEletronicoClick(Sender: TObject);
begin
  pCriarForm(TfrmFatReimpressaoManifestoEletronico);
end;

procedure TfrmPrincipal.mnuFatRemoverDocumentoPreRomaneioClick(Sender: TObject);
begin
  pCriarForm(TfrmFatRemoverDocumentoPreRomaneio);
end;

procedure TfrmPrincipal.pTituloSistema;
begin
  Caption := '.' + TVersaoExecutavel.GetTituloVersao + ' - ' + VS_strCodEmp + ' - ' + fRetNomeEmpresa;
end;

procedure TfrmPrincipal.mnuTransfCodAcessorioClick(Sender: TObject);
begin
  pTransfCod(TransfCodAcessorio);
end;

procedure TfrmPrincipal.mnuTransfCodAtividadeClick(Sender: TObject);
begin
  pTransfCod(TransfCodAtividade);
end;

procedure TfrmPrincipal.mnuCadLocalizacaoSeparacaoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadLocalizacaoSeparacao);
end;

procedure TfrmPrincipal.mnuCadLocFisAmostraProducaoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadLocFisAmostraProducao);
end;

procedure TfrmPrincipal.mnuCadLocFisicaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadLocFisica);
end;

procedure TfrmPrincipal.mnuCadLocFisicaConsertoEquipClick(Sender: TObject);
begin
  pCriarForm(TfrmCadLocFisicaConsertoEquip);
end;

procedure TfrmPrincipal.mnuCadArmazemClick(Sender: TObject);
begin
  pCriarForm(TfrmCadArmazem);
end;

procedure TfrmPrincipal.mnuCadAssistenciaTecnicaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAssistenciaTecnica);
end;

procedure TfrmPrincipal.mnuCadFaixaFatuEstimadoCRMClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFaixaFatuEstimadoCRM);
end;

procedure TfrmPrincipal.mnuCadFaixaFaturamentoComissaoCTRClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFaixaFaturamentoComissaoCTR);
end;

procedure TfrmPrincipal.mnuDigGNRE_EDITClick(Sender: TObject);
begin
  TfrmDigGNRE.CriarFormulario(tcGNREPadrao, True);
end;

procedure TfrmPrincipal.mnuCadTemperaturaAtendimentoCRMClick(Sender: TObject);
begin
  pCriarForm(TfrmCadTempAtendimentoCRM);
end;

procedure TfrmPrincipal.mnuCadTemplatesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadTemplates);
end;

procedure TfrmPrincipal.mnuCadAjuRelatorioClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAjuRelatorio);
end;

procedure TfrmPrincipal.mnuCadInstrucoesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadInstrucoes);
end;

procedure TfrmPrincipal.mnuAlteracaoGeraldePrecosdeProdutosClick(Sender: TObject);
begin
  If fPergunta('Atenção! Esta rotina atualiza os preços dos produtos conforme filtros e opções' + #$A#$D +
               'selecionadas sem seguir as regras de replicação de preço, ou seja, todas as empresas escolhidas serão atualizadas mesmo' + #$A#$D +
               'que estiverem configuradas para utilizar preços independentes. Deseja continuar?') Then
     pOpeProd(AltGeralProdutos);
end;

procedure TfrmPrincipal.frmCfgBlackListEmailClick(Sender: TObject);
begin
  pCriarForm(TfrmCfgBlackListEmail);
end;

procedure TfrmPrincipal.mnuConfiguraoCat42Click(Sender: TObject);
var
  varParametros: TCat42Variaveis;
begin
  pIniVariaveis(varParametros);
  fChamaProcessoCat42(tcc42Tela4, varParametros);
end;

procedure TfrmPrincipal.mnuConfiguraoEnquadramentoClick(Sender: TObject);
var
  varParametros: TCat42Variaveis;
begin
  pIniVariaveis(varParametros);
  fChamaProcessoCat42(tcc42Tela3, varParametros);
end;

procedure TfrmPrincipal.mnuRelatorioCat42Click(Sender: TObject);
var
  varParametros: TCat42Variaveis;
begin
  pIniVariaveis(varParametros);
  fChamaProcessoCat42(tcc42Tela2, varParametros);
end;

procedure TfrmPrincipal.mnuExpCat42Click(Sender: TObject);
var
  varParametros: TCat42Variaveis;
begin
  pIniVariaveis(varParametros);
  fChamaProcessoCat42(tcc42Tela1, varParametros);
end;

procedure TfrmPrincipal.mnuExpContabilModalidadeClick(Sender: TObject);
var
  frmExpContabilModalidade: TfrmExpContabilModalidade;
begin
  pCriarFormularios(TfrmExpContabilModalidade, frmExpContabilModalidade);
  Try
    frmExpContabilModalidade.ShowModal;
  Finally
    pFreeAndNil(frmExpContabilModalidade);
  End;
end;

procedure TfrmPrincipal.frmCfgSpedFiscalClick(Sender: TObject);
begin
  pCriarForm(TfrmCfgSpedFiscal);
end;

procedure TfrmPrincipal.mnuCadAdiAjusteClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAdiAjuste);
end;

procedure TfrmPrincipal.mnuCadAdiAjusteApuClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAdiAjusteApu);
end;

procedure TfrmPrincipal.mnuCadVenDiaEmpClick(Sender: TObject);
begin
  pCriarForm(TfrmCadVenDiaEmp);
end;

procedure TfrmPrincipal.mnuCadApuIpiAjusteClick(Sender: TObject);
begin
  pCriarForm(TfrmCadApuIpiAjuste);
end;

procedure TfrmPrincipal.mnuCadContribuicaoRetidaFonteClick(Sender: TObject);
begin
  pCriarForm(TfrmCadContribuicaoRetidaFonte);
end;

procedure TfrmPrincipal.mnuCadCampo06BlocoC185SpedClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCampo06BlocoC185SPED);
end;

procedure TfrmPrincipal.frmConEquipAtualizaProdutosReqCompraClick(
  Sender: TObject);
begin
  pCriarForm(TfrmConEquipAtualizaProdutosReqCompra);
end;

procedure TfrmPrincipal.frmEditorEtiquetasCliArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeClienteArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEnderecamentoMarmoreGranitoClick(Sender: TObject);
begin
  pCriarForm(TfrmEnderecamentoMarmoreGranito);
end;

procedure TfrmPrincipal.mnuEntConferPreNotaWMSDevolucaoClick(Sender: TObject);
begin
  pCriarForm(TfrmEntConferPreNotaWMSDevolucao);
end;

procedure TfrmPrincipal.frmNotasFulfillmentPatClick(Sender: TObject);
begin
  pCriarForm(TfrmNotasFulfillmentPat);
end;

procedure TfrmPrincipal.mnuOutrasDespesasAposEntradaClick(Sender: TObject);
begin
  pCriarForm(TfrmOutrasDespesasAposEntrada);
end;

procedure TfrmPrincipal.mnuGerAvisoEmbarqueClick(Sender: TObject);
  Var
    strMsg: String;
begin
  If fEmptyStr(fCfgSis('AVEIDP')) Then
    strMsg := 'CFG_AVEIDP'

  Else If fEmptyStr(fCfgSis('AVENVT')) Then
    strMsg := 'CFG_AVENVT'

  Else If fEmptyStr(fCfgSis('AVECIT')) Then
    strMsg := 'CFG_AVECIT'

  Else If fEmptyStr(fCfgSis('AVENDT')) Then
    strMsg := 'CFG_AVENDT';

  If fEmptyStr(strMsg) Then
    pCriarForm(TfrmGerAvisoEmbarque)
  Else
    pMensagemOk('"'+strMsg+'" Não está configurada, configure todas opções do grupo "Exportação de Aviso de Embarque" antes de prosseguir!');
end;

procedure TfrmPrincipal.mnuFatExpServicosClick(Sender: TObject);
begin
  pCriarForm(TfrmFatExpServicos);
end;

procedure TfrmPrincipal.mnuReimpressaoBorderoTelechequeClick(Sender: TObject);
begin
  pCriarForm(TfrmReimpressaoBorderoTelecheque);
end;

Procedure TfrmPrincipal.pRelCadDireitosDeAcesso(mnuMainMenu: TMainMenu);
  Var
    frmRelCadDireitosDeAcesso: TfrmRelCadDireitosDeAcesso;
Begin
  pCriarFormularios(TfrmRelCadDireitosDeAcesso, frmRelCadDireitosDeAcesso);
  frmRelCadDireitosDeAcesso.mnuMainMenu := mnuMainMenu;
  frmRelCadDireitosDeAcesso.ShowModal;
  FreeAndNil(frmRelCadDireitosDeAcesso);
End;

procedure TfrmPrincipal.frmRelDireitosDeAcessoClick(Sender: TObject);
  Var
    varRegistro: TRegistroVarCadastro;
begin
  With varRegistro Do
  Begin
    blnTemParametros := True;
    mnuMainMenu      := mnuAutcomK;
  End;

  pRelCadDireitosDeAcesso(mnuAutcomK);
end;

procedure TfrmPrincipal.mnuTranferenciaPedidoMultiLojaClick(Sender: TObject);
begin
  pCriarForm(TfrmTranferenciaPedidoMultiLoja);
end;

procedure TfrmPrincipal.mnuTransfCodPortadorClick(Sender: TObject);
begin
  pTransfCod(TransfCodPortador);
end;

procedure TfrmPrincipal.mnuTransfCodTransportadoraClick(Sender: TObject);
begin
  pTransfCod(TransfCodTransportadora);
end;

procedure TfrmPrincipal.mnuRelFatComFaixaVendedorCTRClick(Sender: TObject);
begin
  pCriarFormularios(TfrmRelComissaoVendedorCTRMod2,frmRelComissaoVendedorCTRMod2);
  Try
    frmRelComissaoVendedorCTRMod2.blnComissaoPorFaixa := True;
    frmRelComissaoVendedorCTRMod2.ShowModal;
  Finally
    pFreeAndNil(frmRelComissaoVendedorCTRMod2);
  End;
end;

procedure TfrmPrincipal.mnuBackupClick(Sender: TObject);
begin
  pGeraBackup;
end;

procedure TfrmPrincipal.mnuExportXmlNexxeraClick(Sender: TObject);
begin
  pCriarForm(TfrmExportXmlNexxera);
end;

procedure TfrmPrincipal.mnuDashboardClick(Sender: TObject);
{$IFDEF TESTABILIDADE_AUTCOM}
  //
{$Else}
  Var
    objDash: IDashboard;
{$ENDIF}
begin
  {$IFDEF TESTABILIDADE_AUTCOM}
  //
  {$Else}

  If (fCfgSis('DASWEB', varString) = 'S') And (Not CheckEdgeBrowser) Then
  Begin
    MensagemInstalacaoWebView;
    Exit;
  End;

  If Not blnUsuarioLogadoUtilizaModoClassico Then
    Principal.View.FMXPrincipal.AbrirDashboard

  Else
  Begin
    If (Not Assigned(objDash)) Then
      objDash := TDashboard.Create;

    If (fCfgSis('DASWEB', varString) = 'S') Then
      pCriaDashboardweb(objDash)
    Else
      pCriaDashboardAntiga(objDash);
    End;
  {$ENDIF}
end;

procedure TfrmPrincipal.mnuTxtImpFullSoftClick(Sender: TObject);
begin
//  pCriarForm(TfrmTxtImpFullSoft, frmTxtImpFullSoft);
end;

procedure TfrmPrincipal.mnuTxtImpFullSoftTabletClick(Sender: TObject);
begin
  If Not fLock_Unlock('frmTxtImpFullSoftTablet', True, False) Then
  Begin
    fMensagem('ATENÇÃO!', 'A rotina "Importação Tablet FullSoft" já ' +
                          'está sendo utilizada por outra estação: ' +
                          fGetHostLock('frmTxtImpFullSoftTablet'), ['&Ok']);
  End
  Else
  Begin
    Try
      pCriarForm(TfrmTxtImpFullSoftTablet);
    Finally
      fLock_Unlock('frmTxtImpFullSoftTablet', False);
    End;
  End;
end;

procedure TfrmPrincipal.mnuRelCtrLogAcompDuplicClick(Sender: TObject);
begin
  pCriarForm(TfrmRelCtrLogAcompDuplicNovo);
end;

procedure TfrmPrincipal.pImportacaoCartoes(strNomCon: String);
  Var
    Cartoes                : TIntegracaoCartoes;
    strPathDll             : String;
    HandleCart             : THandle;
    pIniciaIntegacaoCartoes: procedure(objFunc: IIntegracaoCartoes); StdCall;
    pIniciaEditorRelatorio : procedure(AObjetoEditor: ICartoesEditorRelatorios); StdCall;
    pSetProcPreviewReport  : procedure(AProc: TProcPreviewReport); stdcall;
    pSetFuncPesquisaEmpresa: procedure(AFunc: TFuncPesquisaEmpresa); stdcall;
    pSetFuncCriarQueryDLL  : procedure(AFunc: TFuncCriarQueryDLL); stdcall;
    pVerificaTabelas       : procedure; StdCall;
    pImporta               : procedure(Aplicacao: HWND); StdCall;
    pImportaKoncili        : procedure(Aplicacao: HWND; strAmbiente: String); StdCall;
    pImportaMadeiraMadeira : procedure(Aplicacao: HWND); StdCall;
    pImportaNew            : procedure(Aplicacao: HWND; strFolder: String; strNomCon: String; strNomEmp: String = ''); StdCall;
    dxInitialize           : procedure; StdCall;
    LEmpresa: String;
begin

  strPathDll := ExtractFilePath(Application.ExeName) + 'libIntegracaoCartoes.dll';
  Cartoes    := TIntegracaoCartoes.Create;
  LEmpresa   := fRetNomeEmpresa;

  If MatchStr(strNomCon,['MercadoLivre', 'SHOPEEPAY']) Then
  Begin
    LEmpresa := Concat(VS_strCodEmp,' - ',LEmpresa);
  End;

  If Not FileExists(strPathDll) Then
  Begin
    fMensagem('ATENÇÃO','O arquivo ' + strPathDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!',['&OK']);
    Exit;
  End;

  If ExisteChaveDeAutorizacaoDuplicada(strNomCon) Then
  Begin
    fMensagem('ATENÇÃO','Existe a mesma chave de autorização da ' +
                        strNomCon+ ' configurada para mais' +
                        ' de uma empresa.' + #13 +
                        'Para empresas que não possuem chave de autorização, '+
                        'deixe a configuração em branco.' + #13 +
                        'A operação foi cancelada.',['&OK'], 0);
    Exit;
  End;

  HandleCart := 0;
  Try
    HandleCart             := LoadLibrary(PChar(strPathDll));

    dxInitialize           := GetProcAddress(HandleCart,'dxInitializeDefault');
    dxInitialize;

    pIniciaIntegacaoCartoes:= GetProcAddress(HandleCart, pChar('pIniciaIntegacaoCartoes'));
    pIniciaIntegacaoCartoes(Cartoes);

    pIniciaEditorRelatorio:= GetProcAddress(HandleCart, pChar('pIniciaEditorRelatorio'));
    pIniciaEditorRelatorio(TCartoesEditorRelatorios.Create);

    pVerificaTabelas       := GetProcAddress(HandleCart, pChar('pVerificaTabelas'));
    pVerificaTabelas;

    pSetProcPreviewReport  := GetProcAddress(HandleCart, pChar('pSetProcPreviewReport'));
    pSetProcPreviewReport(Self.pExibirRelatorio);

    pSetFuncPesquisaEmpresa  := GetProcAddress(HandleCart, pChar('pSetFuncPesquisaEmpresa'));
    pSetFuncPesquisaEmpresa(Self.fIPesqEmpresa);

    pSetFuncCriarQueryDLL  := GetProcAddress(HandleCart, pChar('pSetFuncCriarQueryDLL'));
    pSetFuncCriarQueryDLL(untTIntegracaoDLLCartoes.TIntegracaoDLL.CriarQuery);


    If Not MatchStr(strNomCon, ['Stone', 'Koncili', 'RedeCard API','Alpe','Lucree','Pagar.Me','PagSeguro API','MadeiraMadeira']) Then
    Begin
      pImportaNew          := GetProcAddress(HandleCart, pChar('pImportaCartoes'));
      pImportaNew(Application.Handle, ExtractFilePath(Application.ExeName), strNomCon, LEmpresa);
    End
    Else If (Pos(strNomCon, 'Stone_') > 0) Then
    Begin
      pImporta             := GetProcAddress(HandleCart, pChar('pImporta' + strNomCon));
      pImporta(Application.Handle);
    End
    Else If MatchStr(strNomCon, ['RedeCard API']) Then
    Begin
      pImporta             := GetProcAddress(HandleCart, pChar('pImportaRedeCardAPI'));
      pImporta(Application.Handle);
    End
    Else If MatchStr(strNomCon, ['PagSeguro API']) Then
    Begin
      pImporta             := GetProcAddress(HandleCart, pChar('pImportaPagSeguroAPI'));
      pImporta(Application.Handle);
    End
    Else If MatchStr(strNomCon, ['Alpe']) Then
    Begin
      pImporta             := GetProcAddress(HandleCart, pChar('pImportaAlpe'));
      pImporta(Application.Handle);
    End
    Else If MatchStr(strNomCon, ['Lucree']) Then
    Begin
      pImporta             := GetProcAddress(HandleCart, pChar('pImportaLucree'));
      pImporta(Application.Handle);
    End
    Else If MatchStr(strNomCon, ['Pagar.Me']) Then
    Begin
      pImporta             := GetProcAddress(HandleCart, pChar('pImportaPagarMe'));
      pImporta(Application.Handle);
    End
    Else If MatchStr(strNomCon, ['Koncili']) Then
    Begin
      pImportaKoncili     := GetProcAddress(HandleCart, pChar('pImportaKoncilia'));
      pImportaKoncili(Application.Handle, fCfgSis('KONAMB'));
    End
    Else
    Begin
      pImportaMadeiraMadeira     := GetProcAddress(HandleCart, pChar('pImportaMadeiraMadeira'));
      pImportaMadeiraMadeira(Application.Handle);
    End;
  Finally
    FreeLibrary(HandleCart);
  End;
end;

procedure TfrmPrincipal.pImportarCTes;
var
  strSQL: string;
  qryCTes: TUniQuery;
  objFreCon: TFreCon;
  dtaInicio: TDateTime;
begin
  dtaInicio := fNow();

  qryCTes := fCriaQuery();
  try
    while True do
    begin
      if MinutesBetween(fNow(), dtaInicio) > TEMPO_EXECUCAO_IMPORTADOR_CTE then
        Break;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTE_NUMCTE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVCTE ';
    strSQL := strSQL + '  JOIN MOVGER ON CTE_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTE_CODEMP = :CODEMP ';
    strSQL := strSQL + '  AND IFNULL(CTE_ACESSO, "") <> "" ';
    strSQL := strSQL + '  AND CTE_IMPORT = "N" ';

      qryCTes.Close;
      qryCTes.SQL.Clear;
    qryCTes.SQL.Add(strSQL);
    strSQL := AnsiReplaceStr(strSQL, 'MOVCTE', 'NOTCTE');
    strSQL := AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER');
    qryCTes.SQL.Add('UNION ALL ');
    qryCTes.SQL.Add(strSQL);
    qryCTes.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCTes.Open;

    if (qryCTes.RecordCount > 0) then
    begin
      objFreCon := TFreCon.Create(Self);
      try
        objFreCon.pImportaCTeBancoDados(tpfSaida);
      finally
        objFreCon.Free;
      end;
    end;

      pZerarTentativasLock('IMPORTAR_CTE_' + VS_strCodEmp);

      Sleep(10000);
      Application.ProcessMessages;
    end;
  finally
    FreeAndNil(qryCTes);
    pDestravaLockForcado('IMPORTAR_CTE_' + VS_strCodEmp, 0);
  end;
end;

procedure TfrmPrincipal.pCriaRepositorioConfiguracoes(var cfgRepositorio: TfrmCfgRepositorio);
begin
  pCriarModulo(TfrmCfgRepositorio, TDataModule(cfgRepositorio));
  cfgRepositorio.pSetPontosImpressao(TSpoolImpressaoCitel.fGetPontosImpressao);
  cfgRepositorio.pFilasSeparacao           := pFilasSeparacao;
  cfgRepositorio.pFilasBoletos             := pFilasBoletos;
  cfgRepositorio.pFilasNFCe                := pFilasNFCe;
  cfgRepositorio.pPontosImpressao          := pPontosImpressao;
  cfgRepositorio.pModCartaCob              := pModCartaCob;
  cfgRepositorio.pCfgPais                  := pCfgPais;
  cfgRepositorio.pCfgModCartaDes           := pCfgModCartaDes;
  cfgRepositorio.pCfgModCartaPro           := pCfgModCartaPro;
  cfgRepositorio.pCfgModCartaAnu           := pCfgModCartaAnu;
  cfgRepositorio.pCfgItensOrdenaPadrao     := pCfgItensOrdenaPadrao;
  cfgRepositorio.pCfgCliAti                := pCfgCliAti;
  cfgRepositorio.pCfgCadProvedorEmail      := pCfgCadProvedorEmail;
  cfgRepositorio.pCfgMltBol                := pCfgMltBol;
  cfgRepositorio.pCfgFpfAti_Autonomo       := pCfgFpfAti_Autonomo;
  cfgRepositorio.pCfgFpfAti_Fisica         := pCfgFpfAti_Fisica;
  cfgRepositorio.pCfgFpfAti_Juridica       := pCfgFpfAti_Juridica;
  cfgRepositorio.pCfgEmailAutEntrada       := pCfgEmailAutEntrada;
  cfgRepositorio.pCertificadoDigital       := pCertificadoDigital;
  cfgRepositorio.pCfgCamposClientesCRM     := pCfgCamposClientesCRM;
  cfgRepositorio.pCfgCamposFornecedoresCRM := pCfgCamposFornecedoresCRM;
  cfgRepositorio.pCfgOcoFid                := pCfgOcoFid;
  cfgRepositorio.pCfgEtiquetas             := pCfgEtiquetas;
  cfgRepositorio.fConfigAuxiliar           := fConfigAuxiliar;
  cfgRepositorio.pLayoutImpPdOr            := pLayoutImpPdOr;
  cfgRepositorio.pCfgCondicaoPagamento     := pCfgCondicaoPagamento;
  cfgRepositorio.pCfgValorMaxEmissaoNFCeUF := pCfgValorMaxEmissaoNFCeUF;
  cfgRepositorio.fCfgFgoSta                := fCfgFgoSta;
  cfgRepositorio.pModCartaExtrajudicial    := pModCartaExtrajudicial;
  cfgRepositorio.pModContratoServico       := pModContratoServico;
  cfgRepositorio.pCfgDescricaoLocRet       := pCfgDescricaoLocRet;
  cfgRepositorio.pCfgFornecedoresTagsTigre := pCfgFornecedoresTagsTigre;
  cfgRepositorio.pCfgPerAplFRENET          := pCfgPerAplFRENET;
  cfgRepositorio.pCfgQuadroAcompanhamentoOS:= pCfgQuadroAcompanhamentoOS;
  cfgRepositorio.pCfgCredenciaisSitefExp   := pCfgCredenciaisSitefExp;
  cfgRepositorio.pCfgApiCotacaoHabilitaUso := pCfgApiCotacaoHabilitaUso;
  cfgRepositorio.pCfgRelSkyFornecedor      := pCfgRelSkyFornecedor;
  cfgRepositorio.pCfgEndPartidaConsFrete   := pCfgEndPartidaConsFrete;
  cfgRepositorio.pCfgHorBloqueioTransCod   := pCfgHorBloqueioTransferenciaCodigo;
end;

procedure TfrmPrincipal.pCfgRelSkyFornecedor(AcdsCfgSis: TUniClientDataSet);
begin
  pCriarFormularios(TfrmCfgRelacionaForncedorSkyFornecedorAutcom, frmCfgRelacionaForncedorSkyFornecedorAutcom);
  Try
    frmCfgRelacionaForncedorSkyFornecedorAutcom.cdsCfgSis := AcdsCfgSis;
    frmCfgRelacionaForncedorSkyFornecedorAutcom.pIniciaConfiguracao;
  Finally
    FreeAndNil(frmCfgRelacionaForncedorSkyFornecedorAutcom)
  End;
end;

procedure TfrmPrincipal.pCfgPerAplFRENET;
begin
  pCriarForm(TfrmPerAplFRENET);
end;

procedure TfrmPrincipal.pCfgQuadroAcompanhamentoOS;
begin
  pCriarForm(TfrmCfgQuadroAcompanhamentoOS);
end;

procedure TfrmPrincipal.pCfgEndPartidaConsFrete;
begin
  pCriarForm(TfrmCadEndPartidaConsFrete);
end;

procedure TfrmPrincipal.pCfgEtiquetas(strCodCfg : String);
Begin
  TfrmConfiguraEtiquetas.pShow(strCodCfg);
End;

function TfrmPrincipal.fCfgFgoSta(var strValCfg: String): Boolean;
var
  frmSelFgoSta: TfrmSelFgoSta;
begin
  Result := False;
  pCriarFormularios(TfrmSelFgoSta, frmSelFgoSta);
  try
    frmSelFgoSta.pMarcarSelecionados(strValCfg);
    if frmSelFgoSta.ShowModal = MrOk then
    begin
      Result := True;
      strValCfg := frmSelFgoSta.fRetSelecionados;
    end;
  finally
    pFreeAndNil(frmSelFgoSta);
  end;
end;

function TfrmPrincipal.fConfigAuxiliar(strCodCfg: String; var strValCfg: String): Boolean;
Var
  qryAuxVar: TUniQuery;
  frmMemo: TfrmConfirmacaoMemo;
begin
  Result := False;
  pCriarFormularios(TfrmConfirmacaoMemo, frmMemo);
  Try
    qryAuxVar := fCriaQuery(nil);
    Try
      qryAuxVar.SQL.Text := 'SELECT * FROM AUXCFG WHERE SIS_CODEMP = :CODEMP AND SIS_CODCFG = :CODCFG';
      qryAuxVar.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAuxVar.ParamByName('CODCFG').AsString := strCodCfg;
      qryAuxVar.Open;

      strValCfg := qryAuxVar.FieldByName('SIS_VALCFG').AsString;

      If frmMemo.fInformarMensagem('Informe o valor da configuração', fRetNomCfg(strCodCfg), strValCfg) Then
      Begin
        If qryAuxVar.IsEmpty Then
        Begin
          qryAuxVar.Insert;
          qryAuxVar.FieldByName('SIS_CODEMP').AsString := VS_strCodEmp;
          qryAuxVar.FieldByName('SIS_CODCFG').AsString := strCodCfg;
        End
        Else
          qryAuxVar.Edit;

        qryAuxVar.FieldByName('SIS_VALCFG').AsString := strValCfg;

        qryAuxVar.Post;
        Result := True;
      End;
    Finally
      FreeAndNil(qryAuxVar);
    End;
  Finally
    FreeAndNil(frmMemo);
  End;
end;

function TfrmPrincipal.fCriaNovoSubMenuPopUp(mnuReferencia: TMenuItem; popUp: TAdvPopupMenu): TMenuItem;
Var
  mnuNovo: TMenuItem;
begin
  Result := popUp.Items.Find(mnuReferencia.Caption);
  If Assigned(Result) Then
    Exit;

  mnuNovo         := TMenuItem.Create(Self);
  mnuNovo.Caption := mnuReferencia.Caption;
  mnuNovo.Hint    := mnuReferencia.Hint;
  mnuNovo.Tag     := mnuReferencia.Tag;
  mnuNovo.Name    := mnuReferencia.Name + '_PopUp_' + fInc(VS_intPopUpId).ToString;

  popUp.Items.Add(mnuNovo);

  Result := mnuNovo;
end;

function TfrmPrincipal.fDashboardHabilitadaParaUsuario: Boolean;
Var
  objDash: IDashboard;
begin
  objDash := TDashboard.Create;

  Result := True;

  If Not (objDash.TemRelatorioConfiguradoParaDashboard) Then
    Result := False;

  If Not (fDashboarDireitoAcessoLiberado) Then
    Result := False;
end;

function TfrmPrincipal.fDashboarDireitoAcessoLiberado: Boolean;
Var
  qryDir: TUniQuery;
begin
  Result := True;

  If (fCfgSis('DASWEB', varString) = 'S') Then
  Begin
    Try
      If fVerificaAcessoSistema('frmDashboard') Then
      Begin
        Result := True;
        Exit;
      End;

      qryDir := fCriaQuery(Nil);

      qryDir.SQL.Clear;
      qryDir.SQL.Add(' SELECT ');
      qryDir.SQL.Add('   REPLACE(DAS_NOMBTN, "btn", "mnu") AS MNUABA ');
      qryDir.SQL.Add(' FROM ');
      qryDir.SQL.Add('   DASHAB        ');
      qryDir.SQL.Add(' ORDER BY MNUABA ');
      qryDir.Open;
      qryDir.First;
      While Not qryDir.Eof Do
      Begin
        If fVerificaAcessoSistema(qryDir.FieldByName('MNUABA').AsString) Then
        Begin
          Result := True;
          Exit;
        End
        Else
        Begin
          Result := False;
          qryDir.Next;
        End;
      End;

      If Not Result Then
      Begin
        qryDir.SQL.Clear;
        qryDir.SQL.Add(' SELECT ');
        qryDir.SQL.Add('   REPLACE(DAS_NOMBTN, "btn", "mnu") AS MNUABA, ');
        qryDir.SQL.Add('   CASE ');
        qryDir.SQL.Add('     WHEN DAS_NOMBTN = "btnAbaGerentes" THEN "G_S" ');
        qryDir.SQL.Add('     WHEN DAS_NOMBTN = "btnAbaFiliais" THEN "A" ');
        qryDir.SQL.Add('     WHEN DAS_NOMBTN = "btnAbaLoja" THEN "A_G_S" ');
        qryDir.SQL.Add('     WHEN DAS_NOMBTN = "btnAbaVendedores" THEN "V" ');
        qryDir.SQL.Add('     WHEN DAS_NOMBTN = "btnAbaMeta" THEN "A_G_S_V" ');
        qryDir.SQL.Add('     ELSE DAS_TIPVIS END TIPVIS, ');
        qryDir.SQL.Add('   GPO.OPE_CODOPE AS CODOPE, ');
        qryDir.SQL.Add('   CASE ');
        qryDir.SQL.Add('     WHEN OPE.OPE_INTEXT NOT IN ("A","G","S") THEN "V" ');
        qryDir.SQL.Add('     WHEN OPE.OPE_INTEXT = "A" THEN "A" ');
        qryDir.SQL.Add('     WHEN OPE.OPE_INTEXT IN ("G","S") THEN "G" ELSE "" END AS INTEXT ');
        qryDir.SQL.Add(' FROM ');
        qryDir.SQL.Add('   DASHAB DAS ');
        qryDir.SQL.Add('   LEFT JOIN DIRGPO DIR ON SUBSTRING(DAS_NOMBTN, 4, 60) = SUBSTRING(DIR_NOMFRM, 4, 60) ');
        qryDir.SQL.Add('   LEFT JOIN OPEGPO GPO ON GPO.GPO_CODGPO = DIR.GPO_CODGPO ');
        qryDir.SQL.Add('   LEFT JOIN CADOPE OPE ON GPO.OPE_CODOPE = OPE.OPE_CODOPE ');
        qryDir.SQL.Add(' WHERE OPE.OPE_CODOPE = :CODOPE ');
        qryDir.SQL.Add(' GROUP BY MNUABA, TIPVIS, CODOPE, INTEXT ');
        qryDir.SQL.Add(' HAVING LOCATE(INTEXT, TIPVIS) > 0 ');
        qryDir.SQL.Add(' ORDER BY CODOPE, MNUABA ');
        qryDir.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
        qryDir.Open;

        Result := Not qryDir.IsEmpty;
      End;
    Finally
      FreeAndNil(qryDir);
    End;
  End
  Else
  Begin
  If Not fVerificaAcessoSistema('mnuAbaVendedor') Then
    If Not fVerificaAcessoSistema('mnuAbaLojas') Then
      Result := False;
  End;
end;

procedure TfrmPrincipal.pImprimePedido(strIdDocumento: String; blnSeparacao: Boolean);
var
  strNumDoc, strEspDoc, strCodEmp: String;
  objFatImp: TFatVendaImp;
  documento: TDadosImpressaoVenda;
  imImpPdOr: TDadosImprimePdOrSep;

  function fExtraiParte(var strTexto: String; strSeparador: String): String;
  var
    intPosSep: Integer;
  Begin
    intPosSep := pos(strSeparador, strTexto);
    If intPosSep > 0 Then
    Begin
      Result := Copy(strTexto, 1, intPosSep - 1);
      strTexto := Copy(strTexto, intPosSep + 1, Length(strTexto));
    End
    Else
    Begin
      Result := strTexto;
      strTexto := '';
    End;
  End;

begin
  strNumDoc := fExtraiParte(strIdDocumento, '-');
  strEspDoc := fExtraiParte(strIdDocumento, '-');
  strCodEmp := fExtraiParte(strIdDocumento, '-');

  objFatImp := TFatVendaImp.Create;
  Try
    documento.strCodCli := fCampoTabela('FGO_CODCLI', 'FATGOR',
                                        ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                                        [strNumDoc, strEspDoc, strCodEmp]);
    documento.strNumDoc := strNumDoc;
    documento.strEspDoc := strEspDoc;
    documento.strEmpDoc := strCodEmp;
    documento.strSerFsc := '';

    documento.blnExpedi := False;
    documento.blnEnt_CD := (Pos(documento.strEspDoc, 'OR_PD_') > 0) And
                           (fCampoTabela('FGO_ENT_CD', 'FATGOR',
                                         ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                                         [strNumDoc, strEspDoc, strCodEmp]) = 'S');

    objFatImp.Add(documento);

    If blnSeparacao Then
      objFatImp.fImprimeSeparacao(objFatImp[0],
                                  '',
                                  '',
                                  False,
                                  -1,
                                  TFatVendaImp.fItensDocumento(documento.strNumDoc,
                                                               documento.strEspDoc,
                                                               documento.strEmpDoc,
                                                               documento.strCodCli))
    Else
    Begin
      imImpPdOr := TDadosImprimePdOrSep.Create;
      imImpPdOr.imImpDoc := imImprimeSemPergutar;
      imImpPdOr.intQtdVia := 1;

      objFatImp.pImprimeDocumento(objFatImp[0], imImpPdOr);
    End;
  Finally
    If Assigned(objFatImp) Then
      objFatImp.Destroy;
  End;
end;

procedure TfrmPrincipal.pIniciaPreencheTagDir;
  var
    LfrmGravando : TfrmGravando;
begin
  if fAutComEmModoImportacao then
    exit;

  If not fCfgSis('PAFECF', varBoolean) then
    exit;

  if fLock_Unlock('GERACAO_TAGDIR', True, False, False, '', False) Then
  begin
    Try
      Try
        pCriarFormularios(TfrmGravando, LfrmGravando);
        LfrmGravando.fExecutarAcao := fPreencheTag;
        LfrmGravando.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '');
        End;
      End;
    finally
      pFreeAndNil(LfrmGravando);
      fLock_Unlock('GERACAO_TAGDIR', False, False, False, '', False);
    end;
  end;
end;

procedure TfrmPrincipal.pIniciarTimersImportacao;
begin
  pDesabilitaHabilitaTimerECarregaEventoOnTimer((fCfgSis('TBENTR', varBoolean)) And (fCfgSis('TBETID', varString) = '1'),
                                                tmrImpRomMovMe, tmrImpRomMovMeOnTimer, 'tmrImpRomMovMe',
                                                Self,
                                                300000); 

  pDesabilitaHabilitaTimerECarregaEventoOnTimer((fCfgSis('AGESFA', varBoolean)),
                                                tmrImpSfaMob, tmrImpSfaMobOnTimer, 'tmrImpSfaMob',
                                                Self,
                                                (fCfgSis('TMPSFA', varInteger) * 60000)); 
end;

procedure TfrmPrincipal.pIniciaTmrAlpeBoleto;
begin
  pDesabilitaHabilitaTimerECarregaEventoOnTimer(True,
                                                tmrAlpeBoleto, tmrAlpeBoletoOnTimer, 'tmrAlpeBoleto',
                                                Self,
                                                90000);
end;

procedure TfrmPrincipal.pIniciaTimerQuestFidelidade;
begin
 If (Not fPodeExecutarFuncaoDoTimer) Then
    Exit;

  If Not fPodeExecutarExportacaoTerceiros Then
    Exit;

  If fAutComEmModoImportacao Then
    Exit;

  pDesabilitaHabilitaTimerECarregaEventoOnTimer(fCfgSis('PONQUE', varBoolean),
                                                tmrQuestFidelidade, tmrQuestFidelidadeOnTimer, 'tmrQuestFidelidade',
                                                Self,
                                                10800000); 
end;

procedure TfrmPrincipal.pLayoutImpPdOr;
begin
  pCriarForm(TfrmLayoutImpressaoPedidoOrcamento);
end;

procedure TfrmPrincipal.pLiberaLCKATCAlpeBoleto;
begin
  pDestravaLockForcado('Thread_TIMER_ALPE_BOLETO_'+VS_strCodEmp, 0);
end;

procedure TfrmPrincipal.pLiberaLCKATCDasNotificacoes;
begin
  pDestravaLockForcado('NOTFIC_NOTIFICA_EMAIL_'+VS_strCodEmp, 0);
  pDestravaLockForcado('NOTFIC_NOTIFICA_SMS_'+VS_strCodEmp, 0);
  pDestravaLockForcado('NOTFIC_NOTIFICA_WHATSAPP_'+VS_strCodEmp, 0);
  pDestravaLockForcado('NOTFIC_NOTIFICA_OPINIONE_'+VS_strCodEmp, 0);
end;

procedure TfrmPrincipal.pExportarMenuSistema;
var
  SLMenu: TStringList;
  LMenuIndex: Integer;
  LSomenteVisivel: Boolean;
  LTempFile: String;
  LSenha: String;

  procedure pProcessaMenu(item: TMenuItem);
  var
    I: Integer;
  begin
    If LSomenteVisivel Then
      If Not item.Visible Then
        Exit;

    If item.Caption = '-' Then
      Exit;

    If item.Count = 0 Then
      SLMenu.Add(fGetMenuPath(item))
    Else
      For I := 0 To item.Count -1 Do
        pProcessaMenu(item.Items[I]);
  end;

begin
  if not ffrmSenha(LSenha) then Exit;
  if not LSenha.Equals(SEN_ADM) then Exit;
  LSomenteVisivel := fGetMenu('Exportar Menu Autcom', ['Somente os visíveis', 'Todo o menu'], 2) = 1;
  SLMenu := TStringList.Create;
  Try
    For LMenuIndex := 0 To mnuAutcomK.Items.Count -1 Do
      pProcessaMenu(mnuAutcomK.Items[LMenuIndex]);
    LTempFile := TPath.GetTempFileName + '.txt';
    SLMenu.SaveToFile(LTempFile);
    WinExec(PAnsiChar(AnsiString('cmd /c Notepad "' + LTempFile +'"')), SW_HIDE);
  Finally
    SLMenu.Free;
  End;
end;

procedure TfrmPrincipal.pLogsCTRLF1;
Var
  intMenu  : Integer;
  arrTabela: Array Of String;
  qryGenDel: TUniQuery;
  intAcesso: Integer;
  frmLogDelecoes : TfrmLogDelecoes;
  frmFatLiberacaoCliBlo : TfrmFatLiberacaoCliBlo;
begin
  qryGenDel := fCriaQuery(Self);
  intAcesso := fMontaMenu;

  Case intAcesso Of
  1: Begin

       If Assigned(prcExecutaRelatorio) Then
       begin
          prcExecutaRelatorio(176, 7392, [],
                              [],
                              [],
                              nil,
                              nil,
                              False);
        End;

     End;

  2: Begin
       {************************************}
       {* COLOCA EM UMA MATRIZ AS TABELAS  *}
       {*********************************AF*}
       With qryGenDel Do
       Begin
         Close;
         SQL.Clear;
         SQL.Add('SHOW TABLES LIKE "DEL_%"');
         Open;

         SetLength(arrTabela,RecordCount);

         For intMenu := 0 To RecordCount -1 Do
         Begin
           arrTabela[intMenu] := Fields[0].AsString;
           Next;
         End;

         Close;
       End;

       {****************************}
       {* MOSTRA OPO DAS TABELAS *}
       {*************************AF*}
       Try
         pCriarFormularios(TfrmLogDelecoes,frmLogDelecoes);
         intMenu := fGetMenu('Escolha a Tabela',arrTabela,0);
         frmLogDelecoes.strTabela := arrTabela[intMenu -1];
         frmLogDelecoes.ShowModal;
       Except
         On E: Exception Do
           pMensagensErro(E.Message, '[frmPrincipal.FormKeyDown_1]');
       End;

       pFreeAndNil(frmLogDelecoes);

     End;

  3,
  4: Begin

       Try
         pCriarFormularios(TfrmFatLiberacaoCliBlo,frmFatLiberacaoCliBlo);
         frmFatLiberacaoCliBlo.intAcesso := intAcesso;
         frmFatLiberacaoCliBlo.ShowModal;
       Except
         On E: Exception Do
           pMensagensErro(E.Message, '[frmPrincipal.FormKeyDown_2]');
       End;

       pFreeAndNil(frmFatLiberacaoCliBlo);

     End;
  End;

  FreeAndNil(qryGenDel);
end;

procedure TfrmPrincipal.pIniciarTraceViewer;
begin
  If blnFecharForm Then
    Exit;

  If Not fIniciaTraceViewer Then
    Exit;

  untFuncoesSimples.VS_objTraceViewer.Show;
end;

function TfrmPrincipal.fPainelEntregasDireitoAcessoLiberado(dashHabilitada: Boolean): Boolean;
begin
  Result := False;

  If dashHabilitada Then
    If fVerificaAcessoSistema(mnuPainelEntregas.Hint) Then
      Result := True;
end;

function TfrmPrincipal.fPedeLogin(blnLogOff: Boolean = False): Boolean;
Var
  frmLogin: TfrmLogin;
begin
  VS_PastaEmailsEnviados := EmptyStr;

  {$IFDEF TESTABILIDADE_AUTCOM}
  //
  {$Else}
  If VersaoWindowsSuportaFiremonkey Then
  Begin
    Try
      Result := Login.View.FMXLogin.ExecutarLogin(TLogin.Create(blnLogOff), RunningInTSPlus);
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmPrincipal.fPedeLogin]');
      End;
    End;

    If Result And (Not blnUsuarioLogadoUtilizaModoClassico) Then
    Begin
      Try
        TStyleManager.TrySetStyle(AUTCOM_STYLE_NAME);
        // shToolTips fora: o hook do style desenha o balao nativo do Windows (ex.: aviso de
        // Caps Lock em campo de senha) cortado.
        TStyleManager.SystemHooks  := TStyleManager.SystemHooks - [shDialogs, shToolTips];
        TfrmGravando.CorPadraoTema := AUTCOM_COR_TELA_AGUARDE_TEMA;
      Except
        blnUsuarioLogadoUtilizaModoClassico := True;
      End;
    End;

    Exit;
  End;
  {$ENDIF}

  pCriarFormularios(TfrmLogin, frmLogin);
  Try
    Try
      frmLogin.objLogin := TLogin.Create(blnLogOff);
      frmLogin.showModal;

      Result := frmLogin.blnConfirma;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmPrincipal.fPedeLogin]');
      End;
    End;
  Finally
    pFreeAndNil(frmLogin);
  End;
end;

function TfrmPrincipal.fPodeExecutarExportacaoTerceiros: Boolean;
begin
  Result := True;

  {***************************************************************}
  {* CASO GERE A EXPORTAÇÃO DE TERCEIROS NÃO É EXECUTADO O TIMER *}
  {************************************************************RG*}

  If fGetNomeFormularios.Contains('frmExportaTintometricosTerceiros') Then
    Result := False;
end;

function TfrmPrincipal.fPodeExecutarFuncaoDoTimer: Boolean;
begin
  If VS_FinalizandoAutCom Then
    Exit(False);

  If Not Assigned(frmModulo) Then
    Exit(False);

  If TfrmErroRede.fExibindoMensagemErroRede Then
    Exit(False);

  If TfrmConectando.fTentandoReconectarModulo Then
    Exit(False);

  If Not frmModulo.Database.Connected Then
    Exit(False);

  If frmModulo.Database.InTransaction Then
    Exit(False);

  If fEmptyStr(VS_strCodEmp) Then
    Exit(False);

  If fTransacaoAbertaEmOutroModulo(frmModulo.Database) Then
    Exit(False);

  Result := True;
end;

procedure TfrmPrincipal.mnuCadAtributosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAtributos, frmCadAtributos);
end;

procedure TfrmPrincipal.mnuCadGrupoAtributoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadGrupoAtributo, frmCadGrupoAtributo);
end;

procedure TfrmPrincipal.mnuCadGrupoEcoFornecClick(Sender: TObject);
begin
  pCriarForm(TfrmCadGrupoEcoFornec);
end;

function TfrmPrincipal.fPreencheTag(pgbStatus: TcxProgressBar): Boolean;
begin
  pProgresso(pgbStatus, 0, 0, 'Aguarde, Processando menus do sistema...');
  pPreencheTagDirInicial(pgbStatus);

  If Not fMesmoExecutavel Then
    pPreencheTagDir(pgbStatus);

  Result := True;
End;

function TfrmPrincipal.fOpcoesIgnorar: Boolean;
begin
  Result := blnYapay Or blnImpMovMe Or blnImpSfaMob Or
            blnDefinirLotesWMS Or blnFaturamentoAutomatico Or blnNotificacoesMonitor Or blnDesmembramentoPedidoPIX Or blnCanceladorAutomatico Or
            blnImprimeEtiquetaDespacho Or blnImprimeEtiquetaVolume Or blnGatilhosInformacao Or blnGatilhosImediatos Or blnConsultaPrecoTintas Or
            blnSpedPisCofins Or blnSpedFiscal Or VS_AutoatendimentoPagueFacil Or VS_AutoatendimentoConsultaPreco Or VS_AutoatendimentoBuscaFacil Or
            blnAutoEntTE Or blnAutoConEnt Or blnAutoTransfEmpCar;
end;

procedure TfrmPrincipal.pPontosImpressao;
begin
  pCriarForm(TfrmCfgPontosImpressao);
end;

procedure TfrmPrincipal.pPreencheTagDir(pgbStatus: TcxProgressBar);
  Var
    intContador: Integer;
    qryAux: TUniQuery;
begin
  If Not fCfgSis('PAFECF', varBoolean)Then
    Exit;

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('DELETE FROM TAGDIR');
  qryAux.ExecSQL;
  FreeAndNil(qryAux);

  For intContador := 0 To mnuAutcomK.Items.Count -1 Do
  Begin
    pPreencheTagDirInterna(mnuAutcomK.Items[intContador], pgbStatus);
  End;
end;

procedure TfrmPrincipal.pPreencheTagDirInterna(mnuMenu: TMenuItem; pgbStatus: TcxProgressBar);
  Var
    qryIns: TUniQuery;
    intContador: Integer;

  procedure pInsereMenu(strHint: String; intTag: Integer);
  begin
    If fEmptyStr(strHint) Then
      Exit;

    qryIns := fCriaQuery();
    qryIns.SQL.Add('INSERT INTO TAGDIR VALUES (:DESHIN, :NUMTAG) ');
    qryIns.ParamByName('DESHIN').AsString := strHint;
    qryIns.ParamByName('NUMTAG').AsInteger := intTag;
    qryIns.ExecSQL;
    FreeAndNil(qryIns);
  end;

begin
  If Not fCfgSis('PAFECF', varBoolean)Then
    Exit;

  If mnuMenu.Tag > 0 Then
    pInsereMenu(mnuMenu.Hint, mnuMenu.Tag);

  For intContador := 0 To mnuMenu.Count -1 Do
  Begin
    pPreencheTagDirInterna(mnuMenu.Items[intContador], pgbStatus);

    pProgresso(pgbStatus, Succ(intContador),
               mnuMenu.Count,
               'Aguarde, Validando menus do sistema...');
  End;

end;

procedure TfrmPrincipal.pPreencheTagDirInicial(pgbStatus: TcxProgressBar);
  Var
    qryAux: TUniQuery;
begin
  If Not fCfgSis('PAFECF', varBoolean) Then
    Exit;

  pProgresso(pgbStatus, 0, 0, 'Aguarde, Processando menus do sistema...');

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM TAGDIR');
  qryAux.Open;

  If qryAux.FieldByName('QTD').AsInteger <= 0 Then
  Begin
    pPreencheTagDir(pgbStatus);
  End;

  FreeAndNil(qryAux);
end;

procedure TfrmPrincipal.mnuCadEmpresasEstoqueExternoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEmpresasEstoqueExterno);
end;

procedure TfrmPrincipal.ExecutaMonitorAvisoDebito;
begin
  If Not fLock_Unlock('AVISO_DEBITO_MONITOR',
                      True,
                      False,
                      False,
                      '',
                      False) Then
  Begin
    if fGetTempoDuracaoLock('AVISO_DEBITO_MONITOR') > StrToTime('02:00:00') Then
    Begin
      fLock_Unlock('AVISO_DEBITO_MONITOR',
                   False,
                   False,
                   False,
                   '',
                   False,
                   'AVISO_DEBITO_MONITOR');

      fLock_Unlock('AVISO_DEBITO_MONITOR',
                   True,
                   False,
                   False,
                   '',
                   False);
    End
    Else
      Exit;
  End;

  If Not Assigned(TMostraDebCtrChq2.MonitorAvisoDebito) Then
    TMostraDebCtrChq2.MonitorAvisoDebito := TMonitorAvisoDebito.Create;

  TUtilMonitor.pTestInactivity(Format(TMostraDebCtrChq2.MonitorAvisoDebito.ID_INATIVIDADE_MONITOR, [VS_strCodEmp]),
                               TMostraDebCtrChq2.MonitorAvisoDebito.TEMPO_LIMITE_MONITOR,
                               TMostraDebCtrChq2.MonitorAvisoDebito.ProcessoMonitor,
                               TMostraDebCtrChq2.MonitorAvisoDebito.DataUltimaExecucaoMonitor);

  TUtilMonitor.pRunMonitor(TMostraDebCtrChq2.MonitorAvisoDebito.ID_MONITOR,
                           TMostraDebCtrChq2.MonitorAvisoDebito.ProcessoMonitor,
                           TMostraDebCtrChq2.MonitorAvisoDebito.DataUltimaExecucaoMonitor,
                           TMostraDebCtrChq2.MonitorAvisoDebito.ExeName,
                           Format(TMostraDebCtrChq2.MonitorAvisoDebito.PARAMETROS, [VS_strCodEmp, 'ROBO_AVISO_DEBITO']));

  tmrAvisoDebitoAutomatico.Interval := 3600000;
end;


procedure TfrmPrincipal.ExecutaMonitorExtratoCobranca;
  Var
    LIDMonitor : String;
begin

  If Not Assigned(untTExtratoCobranca.MonitorExtratoCobranca) Then
    untTExtratoCobranca.MonitorExtratoCobranca := TMonitorExtratoCobranca.Create;


  LIDMonitor := untTExtratoCobranca.MonitorExtratoCobranca.ID_MONITOR;
  LIDMonitor := Format(LIDMonitor, [VS_strCodEmp, strLoginUsuarioLogado]);

  If Not fLock_Unlock(LIDMonitor,
                      True,
                      False,
                      False,
                      '',
                      False) Then
  Begin
    if fGetTempoDuracaoLock(LIDMonitor) > StrToTime('02:00:00') Then
    Begin
      fLock_Unlock(LIDMonitor,
                   False,
                   False,
                   False,
                   '',
                   False,
                   LIDMonitor);

      fLock_Unlock(LIDMonitor,
                   True,
                   False,
                   False,
                   '',
                   False);
    End
    Else
      Exit;
  End;

  TUtilMonitor.pTestInactivity(Format(untTExtratoCobranca.MonitorExtratoCobranca.ID_INATIVIDADE_MONITOR, [VS_strCodEmp]),
                               untTExtratoCobranca.MonitorExtratoCobranca.TEMPO_LIMITE_MONITOR,
                               untTExtratoCobranca.MonitorExtratoCobranca.ProcessoMonitor,
                               untTExtratoCobranca.MonitorExtratoCobranca.DataUltimaExecucaoMonitor);

  TUtilMonitor.pRunMonitor('',
                           untTExtratoCobranca.MonitorExtratoCobranca.ProcessoMonitor,
                           untTExtratoCobranca.MonitorExtratoCobranca.DataUltimaExecucaoMonitor,
                           untTExtratoCobranca.MonitorExtratoCobranca.ExeName,
                           Format(untTExtratoCobranca.MonitorExtratoCobranca.PARAMETROS, [VS_strCodEmp,strLoginUsuarioLogado,'ROBO_ENVIO_EXTRATO_COBRANCA']));

end;

procedure TfrmPrincipal.ExportaBuscaPreco(strTabPre, strStatus : String; blnGertec: Boolean = False);
  Var
    varParametro : TOpeProdParam;
begin
  pCarregarLibTintaMaquina;

  varParametro.strTabPre := strTabPre;
  varParametro.strStatus := strStatus;

  If blnGertec Then
  Begin

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(240, 8173, [],
                          ['TABPRE','ITEATI'],
                          [strTabPre,strStatus],
                          nil,
                          nil,
                          True);
    End;

  End
  Else
  Begin

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(242, 8220, [],
                          ['TABPRE','ITEATI'],
                          [strTabPre,strStatus],
                          nil,
                          nil,
                          True);
    End;

  End;

End;

procedure TfrmPrincipal.mnuContratLocacaoClick(Sender: TObject);
begin
  If Not ValidaConfiguracoesLocEqu Then
    Exit;

  pCriarForm(TfrmCadContratoLocEquip);
end;

procedure TfrmPrincipal.mnuContratosCorreiosClick(Sender: TObject);
begin
  pCriarForm(TfrmContratosCorreios);
end;

procedure TfrmPrincipal.mnuControledeCanhotosdeNotasFiscaisEmitidasClick(
  Sender: TObject);
begin
  pCriarForm(TfrmCadCanhotosNF);
end;

procedure TfrmPrincipal.mnuControleDeEstoqueCat1799Click(Sender: TObject);
begin
  pCriarForm(TfrmControleEstoqueCat17);
end;

procedure TfrmPrincipal.mnuControleQualidadeProducaoClick(Sender: TObject);
begin
  pCriarForm(TfrmControleQualidadeProducao);
end;

procedure TfrmPrincipal.mnuCadTipoAnaliseClick(Sender: TObject);
begin
  pCriarForm(TfrmCadTipoAnalise);
end;

procedure TfrmPrincipal.mnuCadEspecificacoesTecnicasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEspecifiTecnicas);
end;

procedure TfrmPrincipal.mnuCadConciliaAcumuloNetpointsClick(Sender: TObject);
begin
  pCriarForm(TfrmCadConciliaAcumuloNetpoints);
end;

procedure TfrmPrincipal.mnuCadAgendamentodeEntregaClick(Sender: TObject);
begin
  pCriarForm(TfrmCadAgendamentodeEntrega);
end;

procedure TfrmPrincipal.mnuRecebimentoEntregaAgendadaClick(Sender: TObject);
begin
  pCriarForm(TfrmRecebimentoEntregaAgendada);
end;

procedure TfrmPrincipal.mnuRecebimentoTransbordoClick(Sender: TObject);
begin
  pCriarForm(TfrmRecebimentoTransbordo);
end;

procedure TfrmPrincipal.mnuRecorrenciaOcorrenciaClick(Sender: TObject);
begin
  pCriarForm(TfrmRecorrenciaOcorrencia);
end;

procedure TfrmPrincipal.mnuPlanoDeRecebimentoClick(Sender: TObject);
begin
  pCriarForm(TfrmPlanoDeRecebimento);
end;

procedure TfrmPrincipal.mnuManutencaoCteClick(Sender: TObject);
begin
  pCriarForm(TfrmFatConsultaCTe);
end;

procedure TfrmPrincipal.mnuManutencaoDocasClick(Sender: TObject);
begin
  pCriarForm(TfrmManutencaoDocas);
end;

procedure TfrmPrincipal.mnuManutencaoEmpresaCentralizadoraClick(
  Sender: TObject);
begin
  pOpeProd(ManutencaoEmpresaCentraliza);
end;

procedure TfrmPrincipal.mnuCadDocasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadDocas);
end;

procedure TfrmPrincipal.mnuImpEtiLocalizacaoClick(Sender: TObject);
begin
  pCriarForm(TfrmImpEtiLocalizacao);
end;

procedure TfrmPrincipal.mnuEtiLocFisArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeLocFisArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiLocFisLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeLocFisLaser, strCodLay);
end;


procedure TfrmPrincipal.mnuEtiquetasArmazenamentoArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeArmazenamentoArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasArmazenamentoLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeArmazenamento, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasArmazenamentoZebraClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeArmazenamentoZebra, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasCodBarrasProdutoExpedicaoLaserClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeCodBarrasProduto, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasLocalArmazenamentoWMSArgoxClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeLocalArmazenamentoWmsArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasLocalArmazenamentoWMSLaserClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeLocalArmazenamentoWmsLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasLoteRastreamentoProdutoArgoxClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeLoteRastreamentoProdutoArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasLoteRastreamentoProdutoLaserClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeLoteRastreamentoProdutoLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasLoteRastreamentoProdutoZebraClick(
  Sender: TObject);
begin
  pEditorEtiqueta(tpeLoteRastreamentoProdutoZebra, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasMarmoreGranitoArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeMarmoreGranitoArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasMarmoreGranitoClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeMarmoreGranito, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasMontagemArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeMontagemCaixasArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasMontagemZebraClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeMontagemCaixasZebra, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasPlanoRecebimentoArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpePlanoRecebWMSArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasPlanoRecebimentoLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpePlanoRecebWMSLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasProdutoControladoVendaArgoxClick(Sender: TObject);
begin
pEditorEtiqueta(tpeProdutosControladosVendasArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasProdutoControladoVendaLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeProdutosControladosVendasLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasProdutoControladoVendaZebraClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeProdutosControladosVendasZebra, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasRegioesArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeRegiaoArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasRegioesLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeRegiaoLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasSeqSeparacaoWMSLaserClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeSeqSeparacaoWMSLaser, strCodLay);
end;

procedure TfrmPrincipal.mnuEtiquetasSeqSeparacaoWMSArgoxClick(Sender: TObject);
begin
  pEditorEtiqueta(tpeSeqSeparacaoWMSArgox, strCodLay);
end;

procedure TfrmPrincipal.mnuEntMercadoriasEfetivaMovFiscalClick(Sender: TObject);
begin
  pCriarForm(TfrmEntMercadoriasEfetivaMovFiscal);
end;

procedure TfrmPrincipal.mnuCadClasseLocFisClick(Sender: TObject);
begin
  pCriarForm(TfrmCadClasseLocFis);
end;

procedure TfrmPrincipal.mnuMapeamentoItemClasseLocFisClick(Sender: TObject);
begin
  pCriarForm(TfrmMapeamentoItemClasseLocFis);
end;

procedure TfrmPrincipal.mnuMapeamentoLocalizacaoFisicaClick(Sender: TObject);
begin
  pCriarForm(TfrmMapeamentoItemLocalizacaoFisica);
end;

procedure TfrmPrincipal.mnuMatrizCadNovosProdutosClick(Sender: TObject);
begin
  pCriarForm(TfrmMatrizProdutos)
end;

procedure TfrmPrincipal.mnuMargemMinimaPorAtividadeClick(Sender: TObject);
begin
  pCriarForm(TfrmCadMargemMinimaPorAtividade);
end;

procedure TfrmPrincipal.mnuBaixaVolumesClick(Sender: TObject);
begin
  pCriarForm(TfrmBaixaVolumes);
end;

procedure TfrmPrincipal.mnuEnvInterfaceAnaliticaClick(Sender: TObject);
  Var
    strNomeTrava : String;
begin
  strNomeTrava := 'NETPOINTS_INTERFACE_ANALITICA_' + VS_strCodEmp;
  If fLock_Unlock(strNomeTrava, True, False, False, '', False) Then
  Begin
    Try
      pCriarForm(TfrmEnvInterfaceAnalitica);
    Finally
      fLock_Unlock(strNomeTrava, False, False, False, '', False);
    End;
  End
  Else
    fMensagem('', 'Há outra estação utilizando o envio de interface analítica no momento!', ['&OK']);
end;

procedure TfrmPrincipal.mnuCancelaOrdemProdIndustrialClick(Sender: TObject);
begin
  pCriarForm(TfrmCancelaOrdemProdIndustrial);
end;

procedure TfrmPrincipal.mnuManOrdProIndustrialClick(Sender: TObject);
begin
  pCriarForm(TfrmManOrdProIndustrial);
end;

procedure TfrmPrincipal.mnuBaixaOrdProdIndustrialClick(Sender: TObject);
begin
  pCriarForm(TfrmBaixaOrdProdIndustrial);
end;

procedure TfrmPrincipal.mnuBaixarGarantiaEnviaaoFornecedorClick(Sender: TObject);
begin
  pCriarForm(TfrmGarantiaBaixaEnvioFornecedorConserto);
end;

procedure TfrmPrincipal.mnuFormulasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadEstruturasIndustrial);
end;

procedure TfrmPrincipal.mnuBalancoFinalizaArmazemClick(Sender: TObject);
begin
  pOpeProd(BalancoFinalizaArmazem);
end;

procedure TfrmPrincipal.mnuBalancoIniciaArmazemClick(Sender: TObject);
begin
  pOpeProd(BalancoIniciaArmazem);
end;

procedure TfrmPrincipal.mnuLiberacaoTransferenciaArmazemClick(Sender: TObject);
begin
  pCriarForm(TfrmLiberacaoTransferenciaArmazem);
end;

procedure TfrmPrincipal.mnuLiberaodePedidosExternosClick(Sender: TObject);
begin
  pCriarForm(TfrmLiberacaoPedidosExternos);
end;

procedure TfrmPrincipal.mnuLiberacaoManutencaoEquipamentosInternosClick(
  Sender: TObject);
begin
  pCriarForm(TfrmManutencaoEquipamentoInternoLiberacao);
end;

procedure TfrmPrincipal.mnuManutencaoEmpresasDestinoMultiLojasClick(
  Sender: TObject);
begin
  pManutencaoEmpresasDestinoMultiLojasAutcom;
end;

procedure TfrmPrincipal.pMostraMensTEF(frmNomeForm: TForm; strMensagem: String);
Var
  intContador: Integer;
Begin

  For intContador := 0 To frmNomeForm.ComponentCount - 1 Do
  Begin

    If frmNomeForm.Components[intContador].Name = 'pnlMenTef' Then
    Begin
      Application.ProcessMessages;
      (frmNomeForm.Components[intContador] As TPanel).Caption := strMensagem;
      (frmNomeForm.Components[intContador] As TPanel).Refresh;

      {$IFDEF TESTABILIDADE_AUTCOM}
      //não utiliza quando Teste Automatizado
      {$Else}
      If Not blnUsuarioLogadoUtilizaModoClassico Then
        Principal.View.FMXPrincipal.MostraMensagemTEF(strMensagem);
      {$ENDIF}

      Application.ProcessMessages;
      Break;
    End;

  End;

end;

procedure TfrmPrincipal.pHideApplicationEx(const pBlnHideForm: Boolean);
begin
  if pBlnHideForm then
  begin
    try
      Self.Hide;
    except
    end;
  end;
  WindowState := wsMinimized;
  ShowWindow(Application.Handle, SW_HIDE);
  Application.MainFormOnTaskbar := False;
  Application.ShowMainForm := False;
  SetWindowLong(Application.Handle, GWL_EXSTYLE, GetWindowLong(Application.Handle, GWL_EXSTYLE) OR WS_EX_TOOLWINDOW AND NOT WS_EX_APPWINDOW);
end;

procedure TfrmPrincipal.mnuCadCnaeClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCna, frmCadCna);
end;

procedure TfrmPrincipal.pMarcarEtiquetasConfiguradas;
  Var
    i : TTipoEtiqueta;
    qryAux: TUniQuery;
    dicTipLay : TDictionary<string,boolean>;
begin
  qryAux := fCriaQuery(Nil);
  dicTipLay := TDictionary<string,boolean>.Create;
  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT LAY_TIPLAY ');
    qryAux.SQL.Add('  FROM LAYETI     ');
    qryAux.SQL.Add(' WHERE LAY_PADRAO = "S"');
    if fCfgSis('ETIEMP', varBoolean) Then
      qryAux.SQL.Add(' AND LAY_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryAux.Open;

    dicTipLay.AddOrSetValue(qryAux.FieldByName('LAY_TIPLAY').AsString, True);
    dicTipLay.TrimExcess;

    for i := tpeClienteLaser to tpeRegiaoArgox do
    begin
      if Not fEmptyStr( ARR_MENU_ETIQ [i][2] ) then
        if (dicTipLay.ContainsKey(ARR_MENU_ETIQ [i][0])) then
          if Copy(TMenuItem(FindComponent(ARR_MENU_ETIQ [i][2])).Caption,1,2) <> '[[' then
            TMenuItem(FindComponent(ARR_MENU_ETIQ [i][2])).Caption :=
              ('[[ '+TMenuItem(FindComponent(ARR_MENU_ETIQ [i][2])).Caption+' ]]');
    end;
  Finally
    FreeAndNil(dicTipLay);
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmPrincipal.pMarcarLiberacaoLida;
var
  strSQL: String;
  qryLib,
  qryAux: TUniQuery;
begin
  qryLib := fCriaQuery;
  qryAux := fCriaQuery;

  try
    qryLib.SQL.Text := TfrmCadMsg.fGetSqlMsg(strLoginUsuarioLogado, True, 'CADMSG.AUTOINCREM', False);
    qryLib.Open;

    strSQL := '';
    strSQL := strSQL + ' DELETE FROM CADMSG         ';
    strSQL := strSQL + ' WHERE AUTOINCREM = :AUTINC ';

    qryAux.SQL.Text := strSQL;

    qryLib.First;

    while not qryLib.Eof do
    begin
      qryAux.Close;
      qryAux.ParamByName('AUTINC').AsString := qryLib.FieldByName('AUTOINCREM').AsString;
      qryAux.ExecSQL;

      qryLib.Next;
    end;
  finally
    FreeAndNil(qryLib);
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmPrincipal.pBaixaEntregaFutura(blnBFut49: Boolean; blnExibirSomenteProdQtdeEntPreenchida: Boolean);
  Var
    frmFatBaixaEntregaFutura : TfrmFatBaixaEntregaFutura;
begin
  If fTemCFOPBaixaEntregaFutura(TRUE) And fTemTransportadoraPadrao(TRUE) Then
  Begin
    If fCfgSis('BFUT49', varBoolean) And fEmptyStr(fCfgSis('DFUT49')) Then
    Begin
      fMensagem('','Favor informar a data de corte para entrega futura com CST de PIS/COFINS 49, configuração CFG_DFUT49', ['&OK']);
      Exit;
    End;

    Try
      pCriarFormularios(TfrmFatBaixaEntregaFutura, frmFatBaixaEntregaFutura);
      frmFatBaixaEntregaFutura.pAbrirDevolucaoBaixaEntregaFutura := pAbrirDevolucaoBaixaEntregaFutura;
      frmFatBaixaEntregaFutura.blnBFut49 := blnBFut49;
      frmFatBaixaEntregaFutura.blnExibirSomenteProdQtdeEntPreenchida := blnExibirSomenteProdQtdeEntPreenchida;
      frmFatBaixaEntregaFutura.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmPrincipal.pBaixaEntregaFutura]');
    End;
    pFreeAndNil(frmFatBaixaEntregaFutura);
  End;
end;

procedure TfrmPrincipal.mnuCancelamentoFreteClick(Sender: TObject);
Var
  frmCancelamentoFrete: TfrmCancelamentoFrete;
begin
  pCriarFormularios(TfrmCancelamentoFrete, frmCancelamentoFrete);
  Try
    frmCancelamentoFrete.Showmodal;
  Finally
    FreeAndNil(frmCancelamentoFrete);
  End
end;

procedure TfrmPrincipal.mnuImportaPROSERClick(Sender: TObject);
begin
  pOpeProd(ImportaPROSER);
end;

procedure TfrmPrincipal.mnuEntImportaNFSeClick(Sender: TObject);
begin
  pCriarForm(TfrmEntImpNFSe);
end;


function TFrmPrincipal.fValidaLimiteDias: Boolean;
var
  qryAux: TUniQuery;
  intDias: Integer;
  objLiberacao : TLiberacao;
begin
  Result := True;

  If Pos(strLoginUsuarioLogado, '999_998_997') > 0 Then
    Exit;

  If Not fCfgSis('PRDFRQ', varBoolean) Then
    Exit;

  intDias := fCfgSis('LMTDIA', varInteger);

  If intDias = 999 Then
    Exit;

  qryAux := fCriaQuery;
  qryAux.SQL.Clear;
  qryAux.SQL.Add('   SELECT IMP_CODIMP FROM IMP_PRODUTO               ');
  qryAux.SQL.Add('   WHERE TRUE                                       ');
  qryAux.SQL.Add('   AND DATEDIFF(CURDATE(), IMP_DTAINS) > :DIAS      ');
  qryAux.SQL.Add('   AND IMP_DTAINS IS NOT NULL                       ');

  qryAux.ParamByName('DIAS').AsInteger := intDias;

  qryAux.Open;

  If Not qryAux.isEmpty Then
  Begin
    Try
      objLiberacao := TLiberacao.Create;
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddSeparador(113);
      objLiberacao.objMsgLibera.pAddTexto('Confirmação de liberação de limite de dias para importação de produtos da franqueadora ultrapassado.');
      objLiberacao.objMsgLibera.pAddSeparador(113);
      objLiberacao.objMsgLibera.pAddTexto('Atenção, o limite de dias para importação de novos produtos da franqueadora foi ultrpassado!');
      objLiberacao.objMsgLibera.pAddTexto('Por favor realize o processo de importação dos registros pela rotina:');
      objLiberacao.objMsgLibera.pAddTexto('UTIL > OPERAÇÕES REFERENTES A PRODUTOS > IMPORTAÇÃO DE NOVOS PRODUTOS FRANQUEADORA');
      objLiberacao.objMsgLibera.pAddSeparador(113);
      objLiberacao.strDirAce := 'PERLIM';
      objLiberacao.strMsgSen := 'Confirmação de liberação de limite de dias para importação de produtos da franqueadora ultrapassado';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;

      If Not Result Then
      Begin
        pMensagemOk('Acesso não autorizado para este operador!');
        pTerminate;
      End;

    Finally
      FreeAndNil(objLiberacao);
    End;
  End;
end;

procedure TfrmPrincipal.pCfgApiCotacaoHabilitaUso(
  AcdsCfgSis: TUniClientDataSet);
begin
  pCriarFormularios(TfrmCfgHabilitaConsultaCotacaoAPIBalcao, frmCfgHabilitaConsultaCotacaoAPIBalcao);
  Try
    frmCfgHabilitaConsultaCotacaoAPIBalcao.cdsCfgSis := AcdsCfgSis;
    frmCfgHabilitaConsultaCotacaoAPIBalcao.ShowModal;
  Finally
    FreeAndNil(frmCfgHabilitaConsultaCotacaoAPIBalcao)
  End;
end;

procedure TfrmPrincipal.ThreadSafeAfterConnect(const AConnection : TUniConnection);
begin
  DefinirTimeZoneEmSessaoMySql(AConnection, VS_strCodEmp, True);
end;

procedure TfrmPrincipal.mnuCadFasesOrdProdClick(Sender: TObject);
begin
  pCriarForm(TfrmCadFasesOrdProd);
end;

procedure TfrmPrincipal.mnuOrdProEmissaoPerdaRefugoClick(Sender: TObject);
begin
  pCriarForm(TfrmOrdProEmiPerdaRefugo);
end;

procedure TfrmPrincipal.mnuMonitorFasesOrdProdClick(Sender: TObject);
begin
  pCriarForm(TfrmOrdProdMonitoramento);
end;

function TfrmPrincipal.fExecutouCanceladorAutomatico(const blnConfirma : Boolean) : Boolean;
  Var
    LParams : TCanceladorAutomaticoParams;
    LIdMonitor : String;
begin
  Result := False;
  If blnCanceladorAutomatico And blnConfirma Then
  Begin
    Result := True;
    VS_ExibirMensagemAoUsuario := False;
    VS_ExibirMensagemDeErro := False;
    VS_ExibirMensagemAguarde := False;
    VS_OnMensagemAoUsuario := TCanceladorAutomaticoMonitor.AddLog;
    VS_OnMensagemDeErro := TCanceladorAutomaticoMonitor.AddLog;
    VS_OnMensagemAguarde := TCanceladorAutomaticoMonitor.AddLog;
    strLoginUsuarioLogado := ParamStr(3);
    If strLoginUsuarioLogado.IsEmpty Then
      strLoginUsuarioLogado := LOG_ADM;
    Try
      Try
        pCarregarVariaveisUsuarioLogado;
        LIdMonitor := Format(IdMonitorCanceladorAutomatico, [VS_strCodEmp, strLoginUsuarioLogado]);
        If Not TUtilMonitor.fLockMonitor(LIdMonitor, VS_strLockMonitorCanceladorAutomatico) Then
          Exit;
        Try
          pCarregarLibTintaMaquina;
          LParams := Default(TCanceladorAutomaticoParams);
          TMonitor.New()
            .IdMonitor(LIdMonitor)
            .TimeLimit(StrToIntDef(GetParamValue('TL='), TimeLimitMonitorCanceladorAutomatico))
            .LockMonitor(VS_strLockMonitorCanceladorAutomatico)
            .ProcedureExec(TCanceladorAutomaticoMonitor.New(LParams))
            .WaitInterval(StrToIntDef(GetParamValue('-T'), 3000))
            .pStart();
        Finally
          TUtilMonitor.fRemoveLockMonitor(LIdMonitor);
        End;
      Except
        On E: Exception Do
          pGravarErro(True, 'ERRO CANCELADOR AUTOMATICO - ' + E.Message, E.StackTrace);
      End;
    Finally
      pFinalizaObjetos;
      pTerminate;
    End;
  End;
end;

procedure TfrmPrincipal.mnuCashbackDevolucaoEmbalagemClick(Sender: TObject);
var
  controle : TControleCashback;
begin
  controle := nil;
  Try
    controle := TControleCashback.Create;

    If controle.ExisteCashbackDevolucaoEmbalagemVigente Then
      pCriarForm(TfrmCadCashbackDevolucaoEmbalagem);
  Finally
    FreeAndNil(controle);
  End;
end;

initialization
  dxInitializeLibNfe;
//  dxInitializeFuncoes;
  CoInitialize(nil);

finalization
  dxFinalizeLibNfe;
//  dxFinalizeFuncoes;
  CoUninitialize;
  TCalculoPrecoMedio.pLiberaMemoria;
  TThreadFinalizarAutcomMonitor.Parar;

end.

