unit untCfgSistemaValidar;

interface

uses
  SysUtils, untCfgRepositorio, cxGridDBTableView, UniClientDataSet, StdCtrls,
  System.Generics.Collections, DB, Classes, PNGImage, JPEG, StrUtils, Uni,
  ExtCtrls, Forms, Variants, untTypesSistema;

type
  TValidarConfiguracoes = class sealed
  public
    class var cfgRepositorio: TfrmCfgRepositorio;
    class var cxDBTableView: TcxGridDBTableView;
    class var cdsCfgSis: TUniClientDataSet;
    class var lblInformacao: TLabel;
    class var dicAlteracoes: TDictionary<String, String>;
    class var blnBaixaPedidosEnderecamento: Boolean;
    class var blnAtualizarSaldoPedido: Boolean;
    class var blnAtualizarComissaoProfissionais: Boolean;
    class var blnAdicionarConfigDuranteValidacao: Boolean;
    class var intValAnt: Integer;
    class var strValAnt: string;
    class var funcCadastroCartaoTefConferencia: TfuncCadastroCartaoTefConferencia ;
  public
    class function fFindCfg(ACodCfg: string): Boolean;
    class function fConfiguracaoEncriptada(AConfiguracao: String): Boolean;
    class function fGetValorConfiguracao(strConfiguracao : String): String;
    class function fChaveJaCriptografada(AValue: String): Boolean;
    class function fAgendaDesligamentoDaCFG_ENTEND(var blnCancelouEdicao: Boolean): Boolean;
    class function fINTRPSValido: Boolean;
    class function fValidaConfiguracaoUsaPreRomaneio: Boolean;
    class function fValidaFreteNFCeCupomFiscal: Boolean;
    class function fValidaPDBaixaEntregaFutura: Boolean;
    class function fValidaRegraDinpar: Boolean;
    class function fValidaTriggerPreAlt: Boolean;
    class function ValidaCasasDecimaisMora: Boolean;
    class function ValidaConfiguracaoAutenticacaoTransferenciasRcx: Boolean;
    class function ValidaConfiguracaoTransferenciasRcxOrdemPagamento: Boolean;
    class function ValidaConfiguracaoPix: Boolean;
    class function ValidaFormaPadraoEnvioLinkPagamento: Boolean ;
    class function ValidaImpressaoAutomaticaBoleto: Boolean;
    class function ValidaConfiguracaoTFOrdemPagamentoAnalitica: Boolean;
    class function ValidaConfiguracaoValorToleranciaConciliacaoCartao: Boolean;
    class function ValidaConfiguracaoNoFechamentoCaixaZerarSaldoDinheiro: Boolean;
    class function ValidaEnvioDeAvisosDeCobranca: Boolean;
    class function ValidaModelosDeAvisosDeCobrancaProximoDiaUtil: Boolean;
    class function ValidaEnvioDeAvisosDeDebitos: Boolean;
    class function ValidaQuantidadeMaximaRoboExtratoCobranca:Boolean;
    class function ValidaTransferenciaDeCartoes: Boolean;
    class function ValidaMovimentacaoContaBanco: Boolean;
    class function ValidaDigitosNumeroCheque: Boolean;
    class function fApenasRetiraItemOk: Boolean;
    class function fBonificacaoPedidoOk: Boolean;
    class function fValidaBitribitacaoIPI: Boolean;
    class function fValidaCFG_QTDROB: Boolean;
    class function fValidaCFG_REMSIM: Boolean;
    class function fControleEntregaOk: Boolean;
    class function fDefinicaoPorAmbienteOk: Boolean;
    class function fItemConsertoEquipamentoOk: Boolean;
    class function fMsgRodapeClienteOk: Boolean;
    class function fNumeroArtigoAgronomico: Boolean;
    class function fPermiteDesabilitarConfiguracaoCFG_HBFPRC: Boolean;
    class function fQtdDiasDtPrevisaoPDOk: Boolean;
    class function fQtdeBox: Boolean;
    class function fResponsavelRetencaoNotaServicoValido: Boolean;
    class function fSolicitacaoTransfReqCompra: Boolean;
    class function fTabelaPrecoUtilizadaPelaTintaDeMaquina: Boolean;
    class function fTabelasUsadasConsultaPrecosColetor: Boolean;
    class function fTabelasUsadasFaturamentoOk: Boolean;
    class function fUtilizaControleGuicheDestFat: Boolean;
    class function fUtilizaControleGuicheGeral: Boolean;
    class function fValidaABADEP: Boolean;
    class function fValidaADTLIB: Boolean;
    class function fValidaGROPWS: Boolean;
    class function fValidaVALWMS: Boolean;
    class function fValidaAjusteCartoes: Boolean;
    class function fValidaAliquotasPisCofins: Boolean;
    class function fValidaAplicaDescConPag: Boolean;
    class function fValidaAppEntrega: Boolean;
    class function fValidaArmazemNoCaixaParaBaixarEstoqueF3: Boolean;
    class function fValidaBEFAMB: Boolean;
    class function fValidaCFG_ALITPR: Boolean;
    class function fValidaCFG_BFSGIS: Boolean;
    class function fValidaCFG_CCRF11: Boolean;
    class function fValidaCFG_CLACDT: Boolean;
    class function fValidaCFG_CLIDOC: boolean;
    class function fValidaCFG_CRDCON: boolean;
    class function fValidaCFG_FREDES: boolean;
    class function fValidaCFG_FTPDEX: boolean;
    class function fValidaCFG_ITECNF: Boolean;
    class function fValidaCFG_MARMOR: Boolean;
    class function fValidaCFG_ONDAGR: Boolean;
    class function fValidaEXLEND: Boolean;
    class function fValidaVEMACS: Boolean;
    class function fValidaFATCNS: Boolean;
    class function fValidaSUGCAP: Boolean;
    class function fValidaDFPSSL: Boolean;
    class function fValidaCFG_PLAAUT: Boolean;
    class function fValidaCFG_PLAROT: Boolean;
    class function fValidaCFG_PORCDR: Boolean;
    class function fValidaCFG_PROCND: Boolean;
    class function fValidaCFG_QTMICR: boolean;
    class function fValidaCFG_RCPCCR: Boolean;
    class function fValidaCFG_RCPCNE: Boolean;
    class function fValidaCFG_ROTROM: boolean;
    class function fValidaCFG_SEPFAT: Boolean;
    class function fValidaCFG_SEPITE: Boolean;
    class function fValidaCFG_CLPVDI: Boolean;
    class function fValidaCFG_VVCSDV: Boolean;
    class function fValidaCFG_FULDIA: Boolean;
    class function fValidaCfgContele: Boolean;
    class function fValidaCFGsLocalizacaoRemessaDevolucao: Boolean;
    class function fValidaPermitirConfirmarCupomComContasReceberAgrupadoCFG_PRCFRA: Boolean;
    class function fValidaCNPJAutDownNFE: Boolean;
    class function fValidaCONEFE: Boolean;
    class function fValidaCalculoSaldoParaTrava: Boolean;
    class function fValidaCartaoGenericoPagueFacil : Boolean;
    class function fValidaCfgLayPad: Boolean;
    class function fValidaCfgLoteSeparacaoParcial: Boolean;
    class function fValidaCfgVerDireitosDeAcessoNaLiberacaoPedidos: Boolean;
    class function fValidaCfopSaidaTagDETEXPORT: Boolean;
    class function fValidaClaGae: Boolean;
    class function fValidaClassificacoesFiscaisDevolucaoSimbolicaConsignacao: Boolean;
    class function fValidaCondicaoPagamentoPorFaixa: Boolean;
    class function fValidaConfAutocenter: Boolean;
    class function fValidaConfComanda: Boolean;
    class function fValidaConfItensPorLocalSeparacao: Boolean;
    class function fValidaConfigFuncionarios: Boolean;
    class function fValidaConfiguracaoCfg_CupNot: Boolean;
    class function fValidaConfiguracaoGravarContasPagarDifalDestino(strCfgPai: String): Boolean;
    class function fValidaConfiguracaoJatLog: Boolean;
    class function fValidaConfiguracaoNovaTelaFechamentoOrcamentoPedido(): Boolean;
    class function fValidaConfiguracaoUtilizaRT: Boolean;
    class function fValidaConfiguracoesSintetizacaoConfirmacao: Boolean;
    class function fValidaConsertoEquipamentos: Boolean;
    class function fValidaControleCobrancaPaleteConfiguradoCorretamente: Boolean;
    class function fValidaCorteDePedidoSemEstoqueOk: Boolean;
    class function fValidaCortePorEstoqueNoPedidoDeVendaOk: Boolean;
    class function fValidaDICMFR: Boolean;
    class function fValidaDescricaoCampoPercentual: Boolean;
    class function fValidaDiasEntregaImediata: Boolean;
    class function fValidaDigitoLinGruFranq: Boolean;
    class function fValidaDmpMvp: Boolean;
    class function fValidaDmpOpc: Boolean;
    class function fValidaDownloadXml: Boolean;
    class function fPagarMeRecebiveisOk: Boolean;
    class function fValidaEFXTPF: Boolean;
    class function fValidaEFXTPG: Boolean;
    class function fValidaENITCN: Boolean;
    class function fValidaENVCTT: Boolean;
    class function fValidaESPNPC: Boolean;
    class function fValidaESP_AD: Boolean;
    class function fValidaEXFPFF: Boolean;
    class function fValidaEditarDescontoEspecial: Boolean;
    class function fValidaEmpCarregamento: Boolean;
    class function fValidaEnotas: Boolean;
    class function fValidaEspecieDocPerfilCondPagto: Boolean;
    class function fValidaExpedirFaturarTodos: Boolean;
    class function fValidaFIOCDV: Boolean;
    class function fValidaFLXSEP: Boolean;
    class function fValidaFORPAT: Boolean;
    class function fValidaFatorCustoNotaEspecial: Boolean;
    class function fValidaFormaPagtoNegociadaAutoAtendimentoPagueFacil : Boolean;
    class function fValidaFreDev: Boolean;
    class function fValidaFreTra: Boolean;
    class function fValidaFrenet: Boolean;
    class function fValidaNovaFormaCadCartaoTef: Boolean;
    class function fValidaGeraLinkPagamentoCitel : Boolean;
    class function fValidaIntegracaoContabilidadeDigital : Boolean;
    class function fValidaGrupoRiscoCliente(): Boolean;
    class function fValidaIMPLST: boolean;
    class function fValidaImpressoraGNRE: Boolean;
    class function fValidaIntegracaoAlpe: Boolean;
    class function fValidaIntegracaoAlpeKonekt: Boolean;
    class function fValidaIntegracaoDeSistemaGS1_CNPCadastroNacionalDeProdutos: Boolean;
    class function fValidaIntegracaoGryncash: Boolean;
    class function fValidaItensParaSintetizacaoDePedido: Boolean;
    class function fValidaLMENDV: Boolean;
    class function fValidaLOCDEC: Boolean;
    class function fValidaLinhasServico: Boolean;
    class function fValidaLocSepArmzBaixaSep: Boolean;
    class function fValidaAtivacaoAncora: Boolean;

    class function fValidaLotBas: Boolean;
    class function fValidaLoteEntradaSimplificada: Boolean;
    class function fValidaMCAT17: Boolean;
    class function fValidaMPRORI: Boolean;
    class function fValidaMandae: Boolean;
    class function fValidaMargemMinimaPorDocumentoOk: Boolean;
    class function fValidaMargensDeExibicaoNoF4: Boolean;
    class function fValidaMascaraCentroDeCusto: Boolean;
    class function fValidaMultSeparacao: Boolean;
    class function fValidaOPLORE: Boolean;
    class function fValidaObrigatoriedadeEmpresaIdentificadora: Boolean;
    class function fValidaOpcaoPrecoMedioSemImpostos: Boolean;
    class function fValidaPDISIF: Boolean;
    class function fValidaPDRCTR: Boolean;
    class function fValidaPICOUT : Boolean;
    class function fValidaPedidoComplementarParaCliente: Boolean;
    class function fValidaPedidosComCondicoesPagamentoDiferentesConfirmacaoPedidos: Boolean;
    class function fValidaPedidosComCondicoesPagamentoDiferentesExpedicao: Boolean;
    class function fValidaPercentual_0_100(strCFG: String): Boolean;
    class function fValidaPortadorSenha2QuandoMeiaNotaESeparaFinanceiroOk: Boolean;
    class function fValidaPromocaoCompostaPorKit: Boolean;
    class function fValidaQTDCAR: Boolean;
    class function fValidaQtdeCasasDecimaisDesconto: Boolean;
    class function fValidaQtdeCasasDecimaisQtdeEntrada: Boolean;
    class function fValidaQtdeCasasDecimaisValorUnitario: Boolean;
    class function fValidaQtdeMsgNFCfg_QtdMsg: Boolean;
    class function fValidaQtdeMsgPDORCfg_QtPdOr: Boolean;
    class function fValidaQuandoObrigatorioInformarProfissionalNoCadClientes: Boolean;
    class function fValidaQuantidadeRecorrenciaOcorrencias: Boolean;
    class function fValidaQuestFidelidade: Boolean;
    class function fValidaREGCID: Boolean;
    class function fValidaRETGOS: Boolean;
    class function fValidaRMPDPA: Boolean;
    class function fValidaROMPLP: boolean;
    class function fValidaRasInd: Boolean;
    class function fValidaReaproveitamentoVendasPerdidas: Boolean;
    class function fValidaResumoExpedicao: Boolean;
    class function fValidaRotinaPrioridadeSaidaEstoque: Boolean;
    class function fValidaSMS: Boolean;
    class function fValidaSPOIMP: boolean;
    class function fValidaSequenciaAgrupamento: Boolean;
    class function fValidaSistemaEstoqueForaLojaOk: Boolean;
    class function fValidaSmsMKOM: Boolean;
    class function fValidaSugEqu_TabPrc: Boolean;
    class function fValidaSugestaoLocalRetira: Boolean;
    class function fValidaTABPCV: Boolean;
    class function fValidaBLNSTE: Boolean;
    class function fValidaTBCNPR: Boolean;
    class function fValidaTERROS: Boolean;
    class function fValidaTIPEXP: Boolean;
    class function fValidaTPLRECeSUGBAN: Boolean;
    class function fValidaTRDPCI: Boolean;
    class function fValidaTXAUTI: Boolean;
    class function fValidaTabEqu_TabPrc: Boolean;
    class function fValidaTabImp_TabPrc: Boolean;
    class function fValidaTabVen_TabPrc: Boolean;
    class function fValidaTabelasPrecoUtilizadas(strNomeConfig : String)  : Boolean;
    class function fValidaTagsCampoVendedorFornecedorTigre: Boolean;
    class function fValidaTamanhoCampoMsgNF: Boolean;
    class function fValidaTamanhoIdealImagem(PathImg: String): Boolean;
    class function fValidaTbpCon_TabPrc: Boolean;
    class function fValidaTefCitel: Boolean;
    class function fValidaTempoCfgImportacaoSiteTablet: Boolean;
    class function fValidaTmpevf: Boolean;
    class function fValidaUTIFNS: Boolean;
    class function fValidaUTIRE2: Boolean;
    class function fValidaUTIRRD: Boolean;
    class function fValidaUTITDE: Boolean;
    class function fValidaUTIWMS: Boolean;
    class function fValidaUTI_RE: Boolean;
    class function fValidaUTLSLF: Boolean;
    class function fValidaINFDIE: Boolean;
    class function fValidaUsarExpedicaoConferenciaRetiraCaixa: Boolean;
    class function fValidaUtiHor: Boolean;
    class function fValidaUtilizacaoDescMaxVendFaixaQtdeVendida: Boolean;
    class function fValidaUtilizacaoRestricaoVendaProduto: Boolean;
    class function fValidaUtilizarOndaSeparacao: Boolean;
    class function fValidaVALFMC : Boolean;
    class function fValidaBEACCS: Boolean;
    class function fValidaVAPICO: Boolean;
    class function fValidaVCPPRO: Boolean;
    class function fValidaVendaVidroOuMadeira: Boolean;
    class function fValidaVendasHorario: Boolean;
    class function fValidaZFMCST: Boolean;
    class function fValidarConfiguracoesResumoDeCaixa: Boolean;
    class function fValidouDevolucaoEspelhoComAlteracaoDePreco: Boolean;
    class function fValidaNFCeOffLine: Boolean;
    class function fValidaNumeroSerie_Com_Wms: Boolean;
    class function fVendaMetroLinearOk: Boolean;
    class function fVerificaSeMudouOModoDeAcrescimoEDescontoNoCupom: Boolean;
    class function fValidaIntegracaoDataFrete: Boolean;
    class function fValidaRATEST: Boolean;
    class function fValidaTPCHFD: Boolean;
    class function fValidaDASWEB: Boolean;
    class function fValidaSPCDEN: Boolean;
    class function fValidaOSGLCP: Boolean;
    class function fValidaPTCCKO: Boolean;
    class function fValidaIDVCPR: Boolean;
    class function fValidaHABREA: Boolean;
    class function fValidaGONDOL: Boolean;
    class function fValidaMUNINC: Boolean;
    class function fValidarIMPCPD: Boolean;
    class function fValidaCENDNE: Boolean;
    class function fValidaLSEWMS : Boolean;
    class function fValidaSOLOLA : Boolean;
    class function fValidaConfiguracaoNotaComplementarCLANCO: Boolean;
    class function fValidaTabelaDePrecoHubTBPCLI: Boolean;
    class function fValidaTabelaDePrecoHubTABPRE: Boolean;
    class function fValidaCORDCL: Boolean;
    class function fValidaPEPFIM : Boolean;
    class function fValidaSONCEE: Boolean;
    class function fValidaSIMHIB: Boolean;
    class function fValidaENDAUT: boolean;
    class function fValidaINVCRI: boolean;
    class function fValidaSUPSEP: boolean;
    class function fValidaPRQSEC: Boolean;
    class function fValidaUTILLC: boolean;
    class function fValidaEMSRCS: Boolean;
    class function fValidaIMPXGR: Boolean;
    class function fValidaENPAFR: Boolean;
    class function fValidaUGPDTE: Boolean;
    class function fValidaENDPRO: Boolean;
    class function fValidaIntegracaoIntelipost: Boolean;
    class function fValidaCFGCANEND: boolean;
    class function fValidaCDPHAB_CDPURL_CDPAPK: boolean;
    class function fValidaCOFTRA: boolean;
    class function fValidaDVTBCR: Boolean;
    class function fValidaAGDPIF: Boolean;
    class function fValidaPROCTR: Boolean;
    class function fValidaOBRLPK: boolean;
    class function fValidaUSALAL: Boolean;
    class function fValidaUTSCNF: Boolean;
    class function fValidaUDEVME: Boolean; static;
    class function fValidaPMVCSH(const AExibirMensagem: Boolean=True): Boolean;
    class function fValidaCBKUTI: Boolean;
    class function fValidaPMEVMN: Boolean;
    class function fValidaCDCRNV: Boolean;
    class function fValidaCONLAR: boolean;
    class function fValidaAUTSEP: boolean;
    class function fValidaFORDCE: boolean;
    class function fValidaCEDVDF: boolean;
    class function fValidaDIMPF4: Boolean;
    class function fValidaICMSEP: Boolean;
    class function fValidaETICON: boolean;
    class function fValidaALTVMT: Boolean;
    class function fValidaDVECSH: Boolean;
    class function ValidarSegundosTimerRoboGatilhosImediatos: Boolean;
    class function fValidaEtqConWmsPlaTplRec: Boolean;
    class function fValidaGATOPE: Boolean;
    class function fValidaSEPLCS: Boolean; static;
    class function fValidaEXCLOR: Boolean;
  public
    class procedure pEncriptarConfiguracao(AConfiguracao: String; var DataSet: TUniClientDataSet);
    class procedure pDecriptarConfiguracao(AConfiguracao: String; var DataSet: TUniClientDataSet);
    class procedure pAddGrupoConfigDataSet(strGruCfg, strCodEmp: string);
    class procedure pAddConfigDataSet(strCodCfg, strCodEmp: string);
    class procedure pAvisoYapay;
    class procedure pVerificaSeMudouAOpcaoDeMFDLocal;
    class procedure pVeSeAtualizaSaldoPedidoCompra;
    class procedure pVeSeAtualizarComissaoProfissionais;
    class procedure pInformacao(strInfo: String; blnExibir: Boolean = True);
    class procedure pOnChangeValCfg(Sender: TField);
    class procedure cdsCfgSisAfterOpen(DataSet: TDataSet);
    class procedure cdsCfgSisAfterPost(DataSet: TDataSet);
    class procedure cdsCfgSisBeforePost(DataSet: TDataSet);
    class procedure cdsCfgSisBeforeEdit(DataSet: TDataSet);
    class procedure pDcryptChaves(var DataSet: TUniClientDataSet);
    class procedure pEcryptChaves(var DataSet: TUniClientDataSet);
    class procedure pEncriptarConfiguracoes;
    class procedure pDecriptarConfiguracoes;
    class procedure pAjustaLabelCfgVlcUne;
    class procedure pAjustaCFG_PLAROT;
    class procedure pDesabilitaUtiWmsEmpresa(strCodEmp: string);
    class procedure pAtualizarStatusPlanosRecebimento;
    class procedure pNormalizaDadosAlteracaoROMPLP;
    class procedure pBaixaPedidosEnderecamento;
    class procedure pAtualizarComissaoProfissionais;
    class function fCadastrarCadBanNovaFormaCadCartaoTef: Boolean ;
    class procedure pAtualizaLayoutAutocenter;
    class procedure pAtualizarVariaveisDeSistema;
    class procedure pAtualizarTimeZone(const strTimeZoneOld, strUsaTmzOld : String);
    class function fValidaGERTRF: Boolean;
    class procedure pExpirarSenhaOperadorCFG_EXPSEN;
  private
    class function fValidaDVSPCL: Boolean; static;
  public
    class function fValidarConfiguracoes(): Boolean;
  end;

implementation

uses
  untFuncoesSimples, untConstantes,
  untFuncoesGenerica, untFuncoes, untMemo, untPreAlt_Trigger,
  untTLog, Contabilidade.Classes.TControleContabilidade, untSIGEPWebFuncoes,
  untHorarioSistema, untCadRcxx, untRegrasCadastroCartaoTef;

class function TValidarConfiguracoes.fBonificacaoPedidoOk: Boolean;
begin
  pInformacao('Aguarde, validando configuração de bonificação no pedido!');

  Result := TRUE;

  With cdsCfgSis Do
  If (fFindCfg('CFG_PROKIT') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')) Then
  Begin
    If (fFindCfg('CFG_BONPED') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
    Begin
      If (fFindCfg('CFG_USABRI') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
      Begin
        Result := FALSE;
        fMensagem('Atenção','Não é permitido utilizar "Permitir fazer Bonificação na digitação do Pedido? (CFG_BONPED)" '+
                            'e "Permitir informar produtos Brinde nos Pedidos de Venda? (CFG_USABRI)" simultaneamente.',['&Ok']);
      End
    End;
  End;

end;

class function TValidarConfiguracoes.fChaveJaCriptografada(AValue: String): Boolean;
begin
  Result := fCrypt(fDecrypt(AValue)).Equals(AValue);
end;

class function TValidarConfiguracoes.fControleEntregaOk: Boolean;
Begin
  pInformacao('Aguarde, validando configuração de controle de entrega!');

  With cdsCfgSis Do
  If fFindCfg('CFG_SOLITE') And
     (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') And
     fFindCfg('CFG_CONENT') And
     (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
  Begin
    Result := FALSE;
    fMensagem('Atenção','Sistema configurado para utilizar solicitação de transferência de estoque para itens sem saldo (CFG_SOLITE).'+#13+
                        'Sendo assim, esta configuração (CFG_CONENT) não pode ser desabilitada.',['&Ok']);
  End

  Else Result := TRUE;
End;

class function TValidarConfiguracoes.fPagarMeRecebiveisOk: Boolean;
Begin
  pInformacao('Aguarde, validando configuração da conciliação Pagar.Me!');

  With cdsCfgSis Do
  If fFindCfg('CFG_PGMREC') And
     (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') And
     fFindCfg('CFG_PGMVER') And
     (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'v4') Then
  Begin
    Result := FALSE;
    fMensagem('Atenção', 'A Pagar.Me está configurada para utilizar a conciliação de recebíveis [CFG_PGMREC].' + #13 +
                         'Portanto, a configuração [CFG_PGMVER] deve estar definida como versão 5.', ['&Ok']);
  End
  Else
    Result := True;
End;

class function TValidarConfiguracoes.fDefinicaoPorAmbienteOk: Boolean;
Begin
  pInformacao('Aguarde, validando configuração de definição do ambiente do produto na tela de vendas!');

  If fFindCfg('CFG_UTIDEF') And
     (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') And
     fFindCfg('CFG_FATCOM') And
     (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
  Begin
    Result := FALSE;
    fMensagem('','Para utilizar a configuração de definição do ambiente do produto na tela de vendas ' +
      'também é necessário alterar a configuração "[CFG_FATCOM] Digitar complemento do produto?" com a opção SIM.',['&Ok']);
  End

  Else Result := TRUE;
End;

class function TValidarConfiguracoes.fFindCfg(ACodCfg: string): Boolean;
begin
  If Self.cdsCfgSis.FindKey([ACodCfg, VS_strCodEmp]) Then
  Begin
    Result := True;
    Exit;
  End;

  If blnAdicionarConfigDuranteValidacao Then
  Begin
    Try
      fCfgSis(ACodCfg.Replace('CFG_', ''), VarString, VS_strCodEmp);
    Except
      on E: Exception do
        pLog('[fFindCfg] Erro ao buscar cfg ' + ACodCfg + ': ' + E.Message);
    End;

    If fExisteConfiguracao(ACodCfg, VS_strCodEmp) Then
    Begin
      pAddConfigDataSet(ACodCfg, VS_strCodEmp);
      Result := True;
      Exit;
    End;
  End;

  Result := False;
end;

class function TValidarConfiguracoes.fGetValorConfiguracao(strConfiguracao: String): String;
begin
  if not dicAlteracoes.TryGetValue('CFG_' + strConfiguracao + '|' + VS_strCodEmp, Result) then
    Result := fCfgSis(strConfiguracao, varString, VS_strCodEmp);
end;

class Function TValidarConfiguracoes.fVendaMetroLinearOk: Boolean;
Begin
  pInformacao('Aguarde, validando configuração de venda de metro linear!');

  Result := TRUE;

  With cdsCfgSis Do
  If (fFindCfg('CFG_VENMTL') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
  Begin
    If (fFindCfg('CFG_VENMAD') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Or
       (fFindCfg('CFG_VENMAD') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
    Begin
      Result := FALSE;
      fMensagem('Atenção','Não é permitido utilizar venda de metro linear (CFG_VENMTL) '+
                          'e venda de vidro (CFG_VENVID) ou madeira (CFG_VENMAD) simultaneamente.',['&Ok']);
    End
  End;
End;

class function TValidarConfiguracoes.fINTRPSValido: Boolean;
  Var
    intIntRps : Integer;
    intPro_NS : Integer;
begin
  pInformacao('Aguarde, validando configuração CFG_INTRPS!');

  Result := True;

  With cdsCfgSis Do
  Begin
    If fFindCfg('CFG_INTRPS') Then
    Begin
      intIntRps := StrToIntDef(cdsCfgSis.FieldByName('SIS_VALCFG').AsString,0);

      If (intIntRps <> 0) Then
      Begin
        If fFindCfg('CFG_PRO_NS') Then
        Begin
          intPro_NS := StrToIntDef(cdsCfgSis.FieldByName('SIS_VALCFG').AsString,0);

          If (intPro_NS - intIntRps) <= 0 Then
          Begin
            Result := False;
            fMensagem('','Intervalo entre número RPS e número NOTA FISCAL inválido:' + Chr(13) +
                         'CFG_INTRPS: "' + IntToStr(intIntRps) + '"' + Chr(13) +
                         'CFG_PRO_NS: "' + IntToStr(intPro_NS) + '"' + Chr(13) +
                         'RESULTADO.: "' + IntToStr(intPro_NS - intIntRps) + '"' + Chr(13) +
                         'Ajustar para obter um valor maior que zero.' , ['&OK']);
          End;
        End;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fItemConsertoEquipamentoOk: Boolean;
  Var
    strIteCon,
    strIteBom,
    strIteFre,
    strIteEne,
    strIteVid,
    strIteTax,
    strIteSer,
    strSerTer: String;

    function fGetConfigItemEquals: String;
    Begin
      Result := '';

      If SameText(strIteCon, strIteBom) Then
        Result := 'CFG_ITEBOM'
      Else If SameText(strIteCon, strIteFre) Then
        Result := 'CFG_ITEFRE'
      Else If SameText(strIteCon, strIteEne) Then
        Result := 'CFG_ITEENE'
      Else If SameText(strIteCon, strIteVid) Then
        Result := 'CFG_ITEVID'
      Else If SameText(strIteCon, strIteTax) Then
        Result := 'CFG_ITETAX'
      Else If SameText(strIteCon, strIteSer) Then
        Result := 'CFG_ITESER'
      Else If SameText(strIteCon, strSerTer) Then
        Result := 'CFG_SERTER';
    End;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração Item para Entrada/Saída de Mercadorias na Nota Fiscal de Conserto!');

  fFindCfg('CFG_ITECON');
  strIteCon := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  fFindCfg('CFG_ITEBOM');
  strIteBom := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  fFindCfg('CFG_ITEFRE');
  strIteFre := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  fFindCfg('CFG_ITEENE');
  strIteEne := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  fFindCfg('CFG_ITEVID');
  strIteVid := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  fFindCfg('CFG_ITETAX');
  strIteTax := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  fFindCfg('CFG_ITESER');
  strIteSer := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  fFindCfg('CFG_SERTER');
  strSerTer := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  If (Not fEmptyStr(fGetConfigItemEquals)) And
     (Not fEmptyStr(strIteCon))            Then
  Begin
    fMensagem('ATENÇÃO!', 'O Item para Entrada/Saída de Mercadorias na Nota Fiscal de Conserto (CFG_ITECON) ' +
                          'deve ser diferente da configuração ' + fGetConfigItemEquals, ['&Ok']);
    Result := False;
  End;
end;

class procedure TValidarConfiguracoes.pDcryptChaves(var DataSet: TUniClientDataSet);
  Var
    SL : TStringList;
    idx : Integer;
begin
  Try
    SL:=TStringList.Create;
    ExtractStrings([';'],[' '],PChar(consChavesCript),SL);

    For idx:=0 To SL.Count-1 Do
    Begin
      If DataSet.FindKey([SL[idx], VS_strCodEmp]) Then
      Begin
        If fChaveJaCriptografada(DataSet.FieldByName('SIS_VALCFG').AsString) Then
        Begin
          DataSet.Edit;
          DataSet.FieldByName('SIS_VALCFG').AsString:=fDecrypt(DataSet.FieldByName('SIS_VALCFG').AsString);
          DataSet.Post;
        End;
      End;
    End;

  Finally
    DataSet.First;
    FreeAndNil(SL);
  End;
end;

class procedure TValidarConfiguracoes.pEcryptChaves(var DataSet: TUniClientDataSet);
  Var
    SL  : TStringList;
    idx : Integer;
begin
  Try
    SL:=TStringList.Create;
    ExtractStrings([';'],[' '],PChar(consChavesCript),SL);

    For idx:=0 To SL.Count-1 Do
    Begin
      If DataSet.FindKey([SL[idx], VS_strCodEmp]) Then
      Begin
        If Not fChaveJaCriptografada(DataSet.FieldByName('SIS_VALCFG').AsString) Then
        Begin
          DataSet.Edit;
          DataSet.FieldByName('SIS_VALCFG').AsString:=fcrypt(DataSet.FieldByName('SIS_VALCFG').AsString);
          DataSet.Post;
        End;
      End;
    End;

  Finally
    DataSet.First;
    FreeAndNil(SL);
  End;
end;

class function TValidarConfiguracoes.fMsgRodapeClienteOk: Boolean;
begin
  pInformacao('Aguarde, validando configuração de mensagem de rodapé cliente!');

  With cdsCfgSis Do
  Begin
    If fFindCfg('CFG_MSGROD') And
       (Length(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) > 255) Then
    Begin
      fMensagem('','A mensagem de rodapé do cliente não pode ultrapassar de 255 caracteres.',['&Ok']);
      Result := False;
    End
    Else
      Result := True;
  End;
end;

class function TValidarConfiguracoes.fNumeroArtigoAgronomico: Boolean;
begin
  With cdsCfgSis Do
  If fFindCfg('CFG_ARTATU') And
     (Length(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) > 20) Then
  Begin
    Result := FALSE;
    fMensagem('', 'O Número do ART deve conter no máximo 20 caracteres!', ['&Ok']);
  End

  Else Result := TRUE;
end;

class function TValidarConfiguracoes.fResponsavelRetencaoNotaServicoValido: Boolean;
begin
  Result := True;

  If fFindCfg('CFG_RSRTNS') Then
  Begin
    If fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
      Exit;

    If (Pos(cdsCfgSis.FieldByName('SIS_VALCFG').AsString, '1_2_') <= 0) Then
    Begin
      Result := False;
      fMensagem('', 'O valor da configuração [CFG_RSRTNS] deve ser: 1, 2 ou (Sem valor preenchido)!', ['&Ok']);
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaFreDev: Boolean;
begin
  Result := True;

  If fFindCfg('CFG_PMFRDV') Then
  Begin
    If (Pos('S', cdsCfgSis.FieldByName('SIS_VALCFG').AsString
    ) <= 0) Then
    Begin
      Result := False;
      fMensagem('Atenção!', 'Marque pelo menos uma opção na configuração CFG_PMFRDV - '+fRetNomCfg('CFG_PMFRDV'), ['&Ok']);
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaTamanhoCampoMsgNF: Boolean;
begin
  Result := True;

  If fFindCfg('CFG_QTCANF') And (StrToIntDef(cdsCfgSis.FieldByName('SIS_VALCFG').AsString,0) > fTamCampoMsgNF) Then
  Begin
    Result := False;
    fMensagem('', 'A configuração CFG_QTCANF deve ser no máximo '+IntToStr(fTamCampoMsgNF)+'!', ['&Ok']);
  End;
end;

class function TValidarConfiguracoes.fValidaTamanhoIdealImagem(PathImg: String): Boolean;
Var
  JPG : TJPEGImage;
  PNG : TPNGImage;
  imgHeight: Integer;
  blnTamanhoIdeal : Boolean;
begin
  Result := True;

  {*************************************************************************}
  {* Bloquear tamanho mínimo da imagem somente se utilizar AUTOATENDIMENTO *}
  {*************************************************************************}
  If (fArqIni(0, 'GERAL', 'AUTOATENDIMENTO', '') = 'S') Then
  Begin
    If ContainsStr(PathImg, '.png') Then
    Begin
      PNG := TPngImage.Create;
      PNG.LoadFromFile(PathImg);
      imgHeight := PNG.Height;
    End
    Else
    Begin
      JPG := TJpegImage.Create;
      JPG.LoadFromFile(PathImg);
      imgHeight := JPG.Height;
    End;

    blnTamanhoIdeal := (imgHeight > 95);

    If blnTamanhoIdeal Then
      blnTamanhoIdeal := (imgHeight < 105);

    if Not blnTamanhoIdeal Then
    Begin
      pMensagemOk('A imagem deve ter 100 px de altura para ser importada' + #13 + #13 +
                  'Tamanho da imagem selecionada: ' + imgHeight.ToString() + ' px');
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaTBCNPR: Boolean;
Var
  strCFPREP: String;
  strTBCNPR: String;
  strTABPRC : String;
begin
  Result := True;

  strCFPREP := fGetValorConfiguracao('CFPREP');
  strTBCNPR := fGetValorConfiguracao('TBCNPR');
  strTABPRC := fGetValorConfiguracao('TABPRC');

  If (strCFPREP = 'S') And fEmptyStr(strTBCNPR) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para habilitar a configuração CFG_CFPREP, é necessário informar uma tabela de preços na configuração CFG_TBCNPR', ['&Ok']);
    Result := False;
  End
  Else
  Begin
    If (Not fEmptyStr(strTBCNPR)) And (Length(strTABPRC) = 7) Then
      Result := (strTABPRC[StrToInt(strTBCNPR)] = 'S');

    If (Not Result) Then
      fMensagem('ATENÇÃO!', 'A tabela utilizada na CFG_TBCNPR deve estar ativada na configuração CFG_TABPRC', ['&Ok']);
  End;
end;

class function TValidarConfiguracoes.fValidaLotBas: Boolean;
begin

  Result := True;

  if fGetValorConfiguracao('LOTBAS') = 'S' then
  begin

    if (fGetValorConfiguracao('TMQLOT') = 'S') or
       (fGetValorConfiguracao('UTIWMS') = 'S') then
    begin
      pMensagemOk('Para utilizar a configuração [LOTBAS] é preciso desabilitar as configurações [TMQLOT] e [UTIWMS]!');
      Result := False;
    end;

  end;

end;

class function TValidarConfiguracoes.fValidaLoteEntradaSimplificada: Boolean;
begin
  Result := True;

  With cdsCfgSis Do
  If fFindCfg('CFG_LOTSIM') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') And
     ((fFindCfg('CFG_ATPREN') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')) OR
      (fFindCfg('CFG_LOTPRE') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N'))) Then
  Begin
    pMensagemOk('As configurações "CFG_ATPREN" e "CFG_LOTPRE" devem estar "Sim" para que a configuração "CFG_LOTSIM" possa estar habilitada!');
    Result := False;
  End;

End;

class function TValidarConfiguracoes.fValidaLSEWMS: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_LSEWMS!');

  if (fFindCfg('CFG_LSEWMS')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
  begin
    if ((fFindCfg('CFG_SOLOLA')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) then
    begin
      fMensagem('ATENÇÃO!', 'Quando utilizar a configuração "CFG_LSEWMS" como SIM, deve-se configurar a configuração "CFG_SOLOLA" como NÃO.', ['&OK']);
      Result := False;
    end;
  end;
end;

class function TValidarConfiguracoes.fValidaCFG_ALITPR: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_ALITPR!');

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_ALITPR') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
       ((fFindCfg('CFG_TABITE') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')) Or
       (fFindCfg('CFG_PROPRE') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> '1'))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Para a configuração [CFG_ALITPR] funcionar a configuração [CFG_TABITE] tem que estar ligada e a [CFG_PROPRE] deve ser "Preço por Promoção" !', ['&Ok']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaCFG_BFSGIS: Boolean;
begin
  Result := True;

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_BFSGIS') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
       ((fFindCfg('CFG_WMSPIC') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Or
        (fFindCfg('CFG_LOTPIC') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N'))) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'Para ativar a configuração [CFG_BFSGIS], ajuste as configurações abaixo para continuar:' + sLineBreak +
         '* [CFG_WMSPIC] = NÃO' + sLineBreak +
         '* [CFG_LOTPIC] = SIM', ['&Ok']);
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaCFG_CCRF11: Boolean;
begin
  Result := False;

  If (fGetValorConfiguracao('CCRF11') = 'S') And
     (fGetValorConfiguracao('USACCR') = 'N') Then
  begin
    fMensagem('ATENÇÃO!', 'Para ativar a configuração "CFG_CCRF11", a configuração '+
      '"CFG_USACCR" precisa estar ativada.', ['&Ok']);
    Exit;
  end;

  Result := True;
end;

class function TValidarConfiguracoes.fValidaCFG_CLACDT: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_CLACDT!');

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_CLACDT') And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Para a configuração [CFG_CDTCLV] funcionar a configuração [CFG_CLACDT] deve estar preenchida corretamente!', ['&Ok']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaCFG_CLIDOC: boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_CLIDOC!');

  With cdsCfgSis Do
    If (fFindCfg('CFG_CLIDOC') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
       (fFindCfg('CFG_TIPEXP') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '5')) And
       (fFindCfg('CFG_RMPDAV') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> '1')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Com a configuração (CFG_TIPEXP = 5) e (CFG_RMPDAV <> 1), a configuração (CFG_CLIDOC) não poderá ser utilizada!', ['&Ok']);
      Result := False;
    End;
end;

class function TValidarConfiguracoes.fValidaCFG_FTPDEX: boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_FTPDEX!');

  If (fFindCfg('CFG_FTPDEX') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
     (fFindCfg('CFG_TIPEXP') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> '4'))Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_FTPDEX], a [CFG_TIPEXP] tem que ser do Tipo 4!', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaCFG_QTMICR: boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_QTMICR!');

  If (fFindCfg('CFG_SENSEG') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
     (fFindCfg('CFG_QTMICR') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger < 3))Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_QTMICR] com a [CFG_SENSEG] = SIM, a quantidade mínima deve ser 3!', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaCFG_RCPCCR: Boolean;
begin
  Result := True;

  If fFindCfg('CFG_RCPCCR') Then
  Begin
    If (Length(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) <= 0) Then
    Begin
      Result := False;
      fMensagem('Atenção!', 'Marque pelo menos uma opção na configuração CFG_RCPCCR - ' + fRetNomCfg('CFG_RCPCCR'), ['&Ok']);
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaCFG_RCPCNE: Boolean;
begin
  Result := True;

  If fFindCfg('CFG_RCPCNE') Then
  Begin
    If (Length(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) <= 0) Then
    Begin
      Result := False;
      fMensagem('Atenção!', 'Marque pelo menos uma opção na configuração CFG_RCPCNE - ' + fRetNomCfg('CFG_RCPCNE'), ['&Ok']);
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaCFG_ROTROM: boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_ROTROM!');

  With cdsCfgSis Do
    If fFindCfg('CFG_ROTROM') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '2') And
       fFindCfg('CFG_REGCID') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') And
       ((fFindCfg('CFG_TIPEXP') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> '5'))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Para usar a configuração (CFG_ROTROM = 2) é preciso que a configuração (CFG_TIPEXP = 5) e (CFG_REGCID = Sim)!', ['&Ok']);
      Result := False;
    End;
end;

class function TValidarConfiguracoes.fValidaCFG_SEPFAT: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configurações CFG_SEPFAT e CFG_SEPDTC!');

  With cdsCfgSis Do
  Begin
    If fFindCfg('CFG_SEPFAT') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') And
       (fFindCfg('CFG_UTIWMS') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Or
       fFindCfg('CFG_TIPEXP') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> '4') Or
       fFindCfg('CFG_SEPDTC') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Para usar a configuração (CFG_SEPFAT = Sim) é preciso que a configuração (CFG_UTIWMS = Não), (CFG_TIPEXP = 4) e (CFG_SEPDTC preenchido)!', ['&Ok']);
      Result := False;
      Exit;
    End;

    If fFindCfg('CFG_SEPDTC') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> '') And
       fFindCfg('CFG_SEPFAT') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
    Begin
      fMensagem('ATENÇÃO!', 'Para usar a configuração (CFG_SEPDTC preenchida) é preciso que a configuração (CFG_SEPFAT = Sim)!', ['&Ok']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaCFG_SEPITE: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_SEPITE!');

  With cdsCfgSis Do
  Begin
    If fFindCfg('CFG_SEPITE') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') And
       ((fFindCfg('CFG_UTIWMS') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Or
        (fFindCfg('CFG_TIPEXP') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> '4'))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Para usar a configuração (CFG_SEPITE = Sim) é preciso que a configuração (CFG_UTIWMS = Não) e (CFG_TIPEXP = 4)!', ['&Ok']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaCFG_CLPVDI: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_CLPVDI!');

  With cdsCfgSis Do
  Begin
    If (FindKey(['CFG_CLPVDI']) And (FieldByName('SIS_VALCFG').AsString = 'S')) And
       (FindKey(['CFG_EMBDFL']) And (FieldByName('SIS_VALCFG').AsString = 'S')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Para usar a configuração [CFG_CLPVDI], a configuração [CFG_EMBDFL] deve ser "Não"!', ['&Ok']);

      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaCFG_VVCSDV: Boolean;
  Var
    lVariacao: Double;

begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_VVCSDV!');

  If Not fFindCfg('CFG_VVCSDV') Then
    Exit;

  lVariacao := fStrToFloat(cdsCfgSis.FieldByName('SIS_VALCFG').AsString);
  if lVariacao < 0 then
  begin
    Result := False;
    fMensagem('ATENÇÃO!', 'O limite de variação de crédito deve ser maior ou igual a zero!', ['&Ok']);
    Exit;
  end;
end;

class function TValidarConfiguracoes.ValidaEnvioDeAvisosDeCobranca: Boolean;
begin
  pInformacao('Aguarde, validando configuração de avisos de cobrança!');

  Result := fGetValorConfiguracao('AVISBO') <> 'S';

  If Not Result Then
  Begin
    Result := fGetValorConfiguracao('BOLAVI') = 'S';

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_AVISBO na opção "Sim", a configuração CFG_BOLAVI deve estar preenchida como "Sim"!', ['&Ok']);
      Exit;
    End;

  End;

  If Not fGetValorConfiguracao('AVIFDS').Equals('S') Then
    Exit;

  Result := ValidaModelosDeAvisosDeCobrancaProximoDiaUtil;

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_AVIFDS na opção "Sim", os modelos de aviso de cobrança ' +
                         'para o próximo dia útil devem ser configurados!', ['&Ok']);
    Exit;
  End;
end;

class function TValidarConfiguracoes.ValidaEnvioDeAvisosDeDebitos: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  pInformacao('Aguarde, validando configuração de avisos de débitos!');

  Result := fGetValorConfiguracao('AVIDEB') <> 'S';

  If Not Result Then
  Begin
    LConsulta := fCriaQuery;

    Try
      LConsulta.SQL.Text := 'SELECT GROUP_CONCAT(DISTINCT  SIS_CODEMP) AS EMPRESAS ' +
                            'FROM CFGSIS ' +
                            'WHERE SIS_CODCFG="CFG_AVIDEB" ' +
                            '  AND SIS_CODEMP<>"' + VS_strCodEmp + '" ' +
                            '  AND SIS_VALCFG="S"';
      LConsulta.Open;

      Result := LConsulta.FieldByName('EMPRESAS').AsString.IsEmpty;

      If Not Result Then
        Result :=  fMensagem('ATENÇÃO',
                             'A configuração CFG_AVIDEB já está configurada com o valor "Sim" na(s) empresa(s) ' +
                                LConsulta.FieldByName('EMPRESAS').AsString + '.' + #13 +
                                'É recomendável que apenas uma empresa fique responsável pelo envio dos avisos de débito.' + #13 +
                                'Deseja realmente continuar?',
                             ['&Sim', '&Não'], 2) = 1;
    Finally
      LConsulta.Close;

      FreeAndNil(LConsulta);
    End;

  End;
end;

class function TValidarConfiguracoes.ValidaFormaPadraoEnvioLinkPagamento: Boolean;
var
  LstrUsaWhats: String ;
  LstrOpcaoEnvio: String ;
begin
  Result := True ;
  pInformacao('Aguarde, validando forma de envio padrão do link de pagamento!');

  If fFindCfg('CFG_UTIWPP') Then
  Begin
    LstrUsaWhats := cdsCfgSis.FieldByName('SIS_VALCFG').AsString ;
    LstrOpcaoEnvio := '1' ;
    If fFindCfg('CFG_SAILNK') Then
      LstrOpcaoEnvio := cdsCfgSis.FieldByName('SIS_VALCFG').AsString ;
    if (LstrOpcaoEnvio <> '1') and (LstrUsaWhats = 'N') then
    begin
     fMensagem('ATENÇÃO!', 'Para utilizar CFG_SAILNK = "2-CitelDesk" ou "3-Dicidir" é necessário contratar o CitelDesk (CFG_UTIWPP = SIM)', ['&Ok']);
     Exit(False);
    end
  end ;
end;

class function TValidarConfiguracoes.ValidaQuantidadeMaximaRoboExtratoCobranca: Boolean;
begin

  Result := True;
  pInformacao('Aguarde, validando as configurações do robô de envio de extrato para cobrança!');

  If fFindCfg('CFG_MAXETC') Then
  Begin
    If cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger > 5 Then
    Begin
        fMensagem('ATENÇÃO!', 'Não é permitido configurar para executar mais de 5 robôs de envio de extrato para cobrança!'+#13#13 +
                              'Verifique a configuração [CFG_MAXETC].', ['&Ok']);
        Exit(False);
    End;
  End;

end;

class function TValidarConfiguracoes.ValidaCasasDecimaisMora: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configurações do Caixa!');

  If fFindCfg('CFG_CSDMOR') Then
  Begin

    If  cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger > 6 Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido informar mais que 6 casas decimais na configuração [CFG_CSDMOR].', ['&Ok']);
      Exit(False);
    End
    Else If cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger < 2 Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido informar menos que 2 casas decimais na configuração [CFG_CSDMOR].', ['&Ok']);
      Exit(False);
    End;

  End;
end;

class function TValidarConfiguracoes.ValidaConfiguracaoAutenticacaoTransferenciasRcx: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configurações do Caixa!');

  If fFindCfg('CFG_USAAUT') Then
  Begin
    Result := cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N';

    If Not Result Then
    Begin
      Result := (fFindCfg('CFG_TPFCCX')) And
                (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'C');

      If Not Result Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar autenticação de transferências de caixa para fechamento (CFG_USAAUT), é necessário utilizar: ' + #13 +
                              'Tipo de fechamento do Resumo de Caixa (CFG_TPFCCX) igual a "Caixas"!', ['&Ok']);

        Exit;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.ValidaConfiguracaoPix: Boolean;
  Var
    LUsaPix,
    LChavePix: String;
begin
  Result := True;
  pInformacao('Aguarde, validando configurações do Pix!');

  LChavePix := '';

  If fFindCfg('CFG_CHAPIX') Then
  Begin
    If Not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
    Begin
      Result := fCampoTabela('AUTOINCREM', 'CCAPIX', ['AUTOINCREM', 'PIX_ATIVA_'], [cdsCfgSis.FieldByName('SIS_VALCFG').AsString, 'S']) <> '';

      LChavePix := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;
    End;

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'A chave pix selecionada na configuração [CFG_CHAPIX] não existe ou está desativada na Manutenção de Contas Bancárias. Verifique!', ['&Ok']);

      Exit;
    End;
  End;

  If fFindCfg('CFG_TEMPIX') Then
  Begin
    Result := Not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString);

    If Result Then
      Result := cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger in [1..60];

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor da configuração [CFG_TEMPIX] deve estar no intervalo entre 1 e 60. Verifique!', ['&Ok']);

      Exit;
    End;
  End;

  If fFindCfg('CFG_EXPPIX') Then
  Begin
    Result := Not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString);

    If Result Then
      Result := cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger in [1..168];

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor da configuração [CFG_EXPPIX] deve estar no intervalo entre 1 e 168. Verifique!', ['&Ok']);

      Exit;
    End;
  End;

  If fFindCfg('CFG_USAPIX') Then
    LUsaPix := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  If fFindCfg('CFG_RCXORD') Then
  Begin
    If cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'P' Then
    Begin
      Result := (LUsaPix = 'S') And (Not LChavePix.IsEmpty);

      If Not Result Then
        fMensagem('ATENÇÃO!', 'O valor da configuração [CFG_RCXORD] só pode ser "Somente Pix QRCode", ' +
                              'caso a configuração [CFG_USAPIX] estiver igual a "Sim" e a ' +
                              'configuração [CFG_CHAPIX] estiver preenchida.', ['&Ok']);
    End;
  End;
end;

class function TValidarConfiguracoes.ValidaConfiguracaoTFOrdemPagamentoAnalitica: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando Transferência de Ordem de Pagamento Analítica!');

  If fFindCfg('CFG_CXMVTP') Then
  Begin
    If cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> '2' Then
      Exit;

    If fFindCfg('CFG_PORORD') Then
    Begin
      If fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
      Begin
        fMensagem('ATENÇÃO!','Quando o valor da configuração [CFG_CXMVTP] for igual a 2 (Analítica), ' +
                             'o Portador para transferência de valores - Ordem de Pagamento [CFG_PORORD] deve ser preenchido. Verifique!', ['&Ok']);
        Exit(False);
      End;
    End;

    If fFindCfg('CFG_CTTROP') Then
    Begin
      If fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
      Begin
        fMensagem('ATENÇÃO!','Quando o valor da configuração [CFG_CXMVTP] for igual a 2 (Analítica), ' +
                             'o Plano de Contas para transferência de valores - Ordem de Pagamento [CFG_CTTROP] deve ser preenchido. Verifique!', ['&Ok']);
        Exit(False);
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.ValidaConfiguracaoTransferenciasRcxOrdemPagamento: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configurações do Caixa!');

  If fFindCfg('CFG_UTICON') Then
  Begin
    Result := cdsCfgSis.FieldByName('SIS_VALCFG').AsString.Equals('N');

    If Result Then
      Exit;

    If fFindCfg('CFG_CXMVTP') Then
      Result := cdsCfgSis.FieldByName('SIS_VALCFG').AsString.Equals('2');

    If Result Then
    Begin
      If fFindCfg('CFG_PTFAUT') Then
        Result := cdsCfgSis.FieldByName('SIS_VALCFG').AsString.Equals('S');
    End;

    If Not Result Then
      fMensagem('ATENÇÃO!', 'Quando utilizar contabilidade (CFG_UTICON = "Sim"), as configurações devem ser:' + #13 +
                            '-CFG_CXMVTP - Gravar movimentação bancária na transferência de ordem de pagamento = "2"; ' + #13 +
                            '-CFG_PTFAUT - Solicitar portador para transferência de ordem de pagamento quando a configuração [CFG_CXMVTP] igual a 2 = "Sim".', ['&Ok']);
  End;
end;

class function TValidarConfiguracoes.ValidaConfiguracaoValorToleranciaConciliacaoCartao: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando valor de tolerância para conciliação automática de Cartões de Crédito!');

  If fFindCfg('CFG_CIETOL') Then
  Begin
    If (fFormataFloat(fStrToFloat(cdsCfgSis.FieldByName('SIS_VALCFG').AsString),6) > fFormataFloat(0.05,6)) Then
    Begin
      fMensagem('ATENÇÃO!','Não é permitido uma tolerância superior a 0,05 centavos na configuração [CFG_CIETOL]. Verifique!', ['&Ok']);
      Exit(False);
    End;
  End;

  If fFindCfg('CFG_SICTOL') Then
  Begin
    If (fFormataFloat(fStrToFloat(cdsCfgSis.FieldByName('SIS_VALCFG').AsString),6) > fFormataFloat(0.05,6)) Then
    Begin
      fMensagem('ATENÇÃO!','Não é permitido uma tolerância superior a 0,05 centavos na configuração [CFG_SICTOL]. Verifique!', ['&Ok']);
      Exit(False);
    End;
  End;

  If fFindCfg('CFG_REDTOL') Then
  Begin
    If (fFormataFloat(fStrToFloat(cdsCfgSis.FieldByName('SIS_VALCFG').AsString),6) > fFormataFloat(0.05,6)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido uma tolerância superior a 0,05 centavos na configuração [CFG_REDTOL]. Verifique!', ['&Ok']);
      Exit(False);
    End;
  End;

  //MF: 284105 - 12/05/2023 - INI
  If fFindCfg('CFG_PAGTOL') Then
  Begin
    If (fFormataFloat(fStrToFloat(cdsCfgSis.FieldByName('SIS_VALCFG').AsString),6) < fFormataFloat(0.02,6)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido uma tolerância inferior a 0,02 centavos na configuração [CFG_PAGTOL]. Verifique!', ['&Ok']);
      Exit(False);
    End;

    If (fFormataFloat(fStrToFloat(cdsCfgSis.FieldByName('SIS_VALCFG').AsString),6) > fFormataFloat(0.05,6)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido uma tolerância superior a 0,05 centavos na configuração [CFG_PAGTOL]. Verifique!', ['&Ok']);
      Exit(False);
    End;
  End;
  //MF: 284105 - 12/05/2023 - FIM

  //MF: 294809 - 09/08/2023 - INI
  If fFindCfg('CFG_PGMTOL') Then
  Begin
    If (fFormataFloat(fStrToFloat(cdsCfgSis.FieldByName('SIS_VALCFG').AsString),6) < fFormataFloat(0.00,6)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido uma tolerância inferior a 0,00 na configuração [CFG_PGMTOL]. Verifique!', ['&Ok']);
      Exit(False);
    End;

    If (fFormataFloat(fStrToFloat(cdsCfgSis.FieldByName('SIS_VALCFG').AsString),6) > fFormataFloat(0.06,6)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido uma tolerância superior a 0,06 centavos na configuração [CFG_PGMTOL]. Verifique!', ['&Ok']);
      Exit(False);
    End;
  End;
  //MF: 294809 - 09/08/2023 - FIM

  If fFindCfg('CFG_GETTOL') Then
  Begin

    If (fFormataFloat(fStrToFloat(cdsCfgSis.FieldByName('SIS_VALCFG').AsString),6) > fFormataFloat(0.05,6)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido uma tolerância superior a 0,05 centavos na configuração [CFG_GETTOL]. Verifique!', ['&Ok']);
      Exit(False);
    End;
  End;

  If fFindCfg('CFG_MADTOL') Then
  Begin
    If (fFormataFloat(fStrToFloat(cdsCfgSis.FieldByName('SIS_VALCFG').AsString),6) > fFormataFloat(0.05,6)) Then
    Begin
      fMensagem('ATENÇÃO!','Não é permitido uma tolerância superior a 0,05 centavos na configuração [CFG_MADTOL]. Verifique!', ['&Ok']);
      Exit(False);
    End;
  End;

  If cdsCfgSis.FindKey(['CFG_SAFTOL']) Then
  Begin
    If (fFormataFloat(fStrToFloat(cdsCfgSis.FieldByName('SIS_VALCFG').AsString),6) < fFormataFloat(0.02,6)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido uma tolerância inferior a 0,02 centavos na configuração [CFG_SAFTOL]. Verifique!', ['&Ok']);
      Exit(False);
    End;

    If (fFormataFloat(fStrToFloat(cdsCfgSis.FieldByName('SIS_VALCFG').AsString),6) > fFormataFloat(0.05,6)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido uma tolerância superior a 0,05 centavos na configuração [CFG_SAFTOL]. Verifique!', ['&Ok']);
      Exit(False);
    End;
  End;

end;

class function TValidarConfiguracoes.ValidaConfiguracaoNoFechamentoCaixaZerarSaldoDinheiro: Boolean;
  Var
    LValorUltimoFechamento: Double;
    LDataUltimoFechanmento: TDateTime;
begin
  Result := True;
  pInformacao('Aguarde, validando configurações do Caixa!');

  If fCfgSis('CEGZER', varBoolean) Then // se já tiver ativa não valida.
    Exit;

  If fFindCfg('CFG_CEGZER') Then
  Begin
    If cdsCfgSis.FieldByName('SIS_VALCFG').AsString.Equals('S') Then
    Begin
      If (fCfgSis('TPFCCX') <> 'C') Then
      Begin
        untCadRcxx.pRetornaUltimoFechamento(LValorUltimoFechamento, LDataUltimoFechanmento, VS_strCodEmp);
        If (LValorUltimoFechamento <> 0) Then
        Begin
          fMensagem('ATENÇÃO!','Para ativar a configuração [CFG_CEGZER] e no fechamento do caixa começar a zerar o saldo em '+
                               'dinheiro dos lançamentos do dia, é necessário que o saldo do último fechamento esteja zerado.', ['&Ok']);
          Exit(False);
        End;
      End;
    End;
  End;

end;

class function TValidarConfiguracoes.ValidaDigitosNumeroCheque: Boolean;
  Var
    LValorConfiguracao: Integer;
begin
  Result := TryStrToInt(fGetValorConfiguracao('CHQDIG'), LValorConfiguracao);

  If Result Then
    Result := LValorConfiguracao In [0..10];

  If Not Result Then
    fMensagem('ATENÇÃO!', 'O valor da configuração [CFG_CHQDIG]-"Quantidade mínima de dígitos no campo número do cheque" deve ser entre 0 e 10!', ['&Ok']);
end;

class function TValidarConfiguracoes.fValidaRETGOS: Boolean;
begin
  Result := True;

  If (fGetValorConfiguracao('RETGOS') = 'S') And (fGetValorConfiguracao('CONEQU') = 'N') Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a [CFG_RETGOS], é preciso ativar a [CFG_CONEQU]-"Utilizar rotina de Conserto de Equipamentos?"!', ['&Ok']);
    Result := False;
    Exit;
  End;

  If (fGetValorConfiguracao('RETGOS') = 'S') And
     ((fEmptyStr(fGetValorConfiguracao('CLIGOS'))) Or
      (fEmptyStr(fGetValorConfiguracao('CNDGOS')))) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a [CFG_RETGOS], é preciso preencher as configurações [CFG_CLIGOS] e [CFG_CNDGOS]!', ['&Ok']);
    Result := False;
    Exit;
  End;
end;

class function TValidarConfiguracoes.fValidarIMPCPD: Boolean;
const
  arrCamposChvLayEti: array of string = ['LAY_TIPLAY', 'LAY_PADRAO', 'LAY_CODEMP'];
var
  strCodLay: String;
begin
  Result := True;

  strCodLay := fCampoTabela('LAY_CODLAY', 'LAYETI', arrCamposChvLayEti, ['234', 'S', VS_strCodEmp]);

  If AnsiMatchStr(fGetValorConfiguracao('IMPCPD'), ['2','3','4']) Then
    Result := Not fEmptyStr(strCodLay);

  If Not Result Then
    fMensagem('ATENÇÃO!', 'Para selecionar as opções "2, 3, 4" na (CFG_IMPCPD),'+
                          ' necessário ter um layout de "Cupom de Próximo Desconto" disponível'+
                          ' em seu editor de layout!', ['&Ok']);
end;

class function TValidarConfiguracoes.fValidaADTLIB: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração CFG_RESEXP!');

  If (fGetValorConfiguracao('ADTLIB') = 'S') And (fGetValorConfiguracao('EXIADT') <> 'S') Then
  Begin
    fMensagem('ATENÇÃO!', 'Com a configuração (CFG_ADTLIB = "S"), a configuração (CFG_EXIADT) deve ser "S"', ['&Ok']);
    Result := False;
  End;
end;

class procedure TValidarConfiguracoes.pDesabilitaUtiWmsEmpresa(strCodEmp: string);
  var
    qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery;
  Try
     qryUpdate.SQL.Add('UPDATE CADEMP');
     qryUpdate.SQL.Add('   SET EMP_UTIWMS = "N"');
     qryUpdate.SQL.Add(' WHERE EMP_CODEMP = "' + strCodEmp + '"');
     qryUpdate.ExecSQL;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

class procedure TValidarConfiguracoes.pAddConfigDataSet(strCodCfg, strCodEmp: string);
var
  LQuery: TUniQuery;
  LIndex: Integer;
begin
  LQuery := fCriaQuery;
  try
    LQuery.SQL.Add('SELECT * FROM CFGSIS WHERE SIS_CODCFG = :CODCFG AND SIS_CODEMP = :CODEMP');
    LQuery.ParamByName('CODCFG').AsString := strCodCfg;
    LQuery.ParamByName('CODEMP').AsString := strCodEmp;
    LQuery.Open;
    cdsCfgSis.Append;
    for LIndex := 0 To LQuery.Fields.Count-1 do
      if cdsCfgSis.FindField(LQuery.Fields[LIndex].FieldName) <> nil then
        cdsCfgSis.FindField(LQuery.Fields[LIndex].FieldName).Value :=
          LQuery.Fields[LIndex].Value;
    cdsCfgSis.Post;
  finally
    LQuery.Free;
  end;
end;

class procedure TValidarConfiguracoes.pAddGrupoConfigDataSet(strGruCfg, strCodEmp: string);
var
  LQuery: TUniQuery;
  LIndex: Integer;
begin
  LQuery := fCriaQuery;
  try
    LQuery.SQL.Add('SELECT * FROM CFGSIS WHERE SIS_GRUCFG = :GRUCFG AND SIS_CODEMP = :CODEMP');
    LQuery.ParamByName('GRUCFG').AsString := strGruCfg;
    LQuery.ParamByName('CODEMP').AsString := strCodEmp;
    LQuery.Open;
    while not LQuery.Eof do
    begin
      cdsCfgSis.Append;
      for LIndex := 0 To LQuery.Fields.Count-1 do
        if cdsCfgSis.FindField(LQuery.Fields[LIndex].FieldName) <> nil then
          cdsCfgSis.FindField(LQuery.Fields[LIndex].FieldName).Value :=
            LQuery.Fields[LIndex].Value;
      cdsCfgSis.Post;
      LQuery.Next;
    end;
  finally
    LQuery.Free;
  end;
end;


class procedure TValidarConfiguracoes.pAjustaCFG_PLAROT;
begin
  If Assigned(cdsCfgSis) And (fFindCfg('CFG_APIROT')) Then
    cfgRepositorio.chkPlanejamentoRota.Properties.Items[0].Enabled := (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> 'GOOGLE');
end;

class procedure TValidarConfiguracoes.pAjustaLabelCfgVlcUne;
  Var
    intIdx: Integer;
begin
  If Assigned(cfgRepositorio) Then
  Begin
    For intIdx := 0 To cfgRepositorio.rdgValFatNotEsp.Properties.Items.Count-1 Do
    Begin
      If (cfgRepositorio.rdgValFatNotEsp.Properties.Items[intIdx].Value = 'CUSFRE') Then
      Begin
        cfgRepositorio.rdgValFatNotEsp.Properties.Items[intIdx].Caption :=
           'Preço de Custo - "'+IfEmptyStr(TValidarConfiguracoes.fGetValorConfiguracao('DESVFR'),'Valor Frete')+'" (CFG_DESVFR)';
      End;
    End;
  End;
end;

class procedure TValidarConfiguracoes.pAtualizaLayoutAutocenter;
Var
  qryAux: TUniQuery;
Begin
  If TValidarConfiguracoes.fFindCfg('CFG_AUTCEN') And (fCfgSis('AUTCEN') <> cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
  Begin
    qryAux := fCriaQuery;
    With qryAux, SQl Do
    Begin
      Clear;
      Add('UPDATE ');
      Add('  CAMETI ');
      Add('SET ');
      Add('  CAM_DOC_PD = :AUTCEN, ');
      Add('  CAM_DOC_OR = :AUTCEN  ');
      Add('WHERE ');
      Add('  CAM_EXPCAM = ("PRISVE") ');
      ParamByName('AUTCEN').AsString := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;
      ExecSQL;

      Clear;
      Add('UPDATE ');
      Add('  CAMETI ');
      Add('SET ');
      Add('  CAM_DOC_MI = :AUTCEN, ');
      Add('  CAM_DOC_FF = :AUTCEN, ');
      Add('  CAM_DOC_NF = :AUTCEN, ');
      Add('  CAM_DOC_PD = :AUTCEN, ');
      Add('  CAM_DOC_OR = :AUTCEN  ');
      Add('WHERE ');
      Add('  CAM_EXPCAM IN ("MARVEI","PLAVEI","KM_VEI","MODVEI","CORVEI") ');
      ParamByName('AUTCEN').AsString := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;
      ExecSQL;
    End;
    FreeAndNil(qryAux);
  End;
end;

class procedure TValidarConfiguracoes.pAtualizarComissaoProfissionais;
Var
  qryCadDiv: TUniQuery;
Begin
  qryCadDiv := fCriaQuery;
  Try
    With qryCadDiv, SQl Do
    Begin
      Clear;
      Add('UPDATE CADDIV');
      Add('INNER JOIN CADATI ON ATI_CODATI = DIV_CODATI ');
      Add('SET DIV_PERCOM = IFNULL(ATI_PERCOM, 0)');
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryCadDiv);
  End;
end;

class procedure TValidarConfiguracoes.pAtualizarStatusPlanosRecebimento;
begin
  If (TValidarConfiguracoes.fFindCfg('CFG_WMSPLA')) Then
  Begin
    If (VarToStr(cdsCfgSis.FieldByName('SIS_VALCFG').Value) <> fCfgSis('WMSPLA', varString) ) Then
    Begin
      //Atualiza os planos ja finalizados, para o ultimo status de cada opção  (isso faz que os pedidos nao voltem para coletor ao mudar a cfg);
      If (cdsCfgSis.FieldByName('SIS_VALCFG').Value = 'R') Then
      Begin
        fExecutaSQL('UPDATE AGEREC SET ARC_STATUS = "CN" WHERE ARC_STATUS = "EP" AND ARC_CODEMP = ' + QuotedStr(VS_strCodEmp));
      End
      Else
      Begin
        fExecutaSQL('UPDATE AGEREC SET ARC_STATUS = "EP" WHERE ARC_STATUS = "CN" AND ARC_CODEMP = ' + QuotedStr(VS_strCodEmp));
      End;
    End;
  End;
end;

class procedure TValidarConfiguracoes.pAtualizarTimeZone(const strTimeZoneOld,
  strUsaTmzOld: String);
  Var
    strUsaTmz : String;
    strTimeZone : String;
begin
  If (Not fFindCfg('CFG_USATMZ')) Then
    Exit;

  strUsaTmz := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  If (Not fFindCfg('CFG_TMZONE')) Then
    Exit;

  strTimeZone := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  If (strUsaTmz <> strUsaTmzOld) Then
    DefinirTimeZoneEmSessaoMySql(fGetConexao, VS_strCodEmp, False)
  Else If (strUsaTmz = 'S') And (strTimeZone <> strTimeZoneOld) Then
    DefinirTimeZoneEmSessaoMySql(fGetConexao, VS_strCodEmp, False);
end;

class procedure TValidarConfiguracoes.pAtualizarVariaveisDeSistema;
begin
  pDisponibilizaTefModular;
  dicConfiguracoes.Clear;
  LimparDicionarioConfiguracoesHorario;
  pAtuVarGlobaisSimples;
end;

class procedure TValidarConfiguracoes.pAvisoYapay;
var
  blnMudou: Boolean;
begin
  blnMudou := (fFindCfg('CFG_YAPHAB')) And
              (fCfgSis('YAPHAB') <> cdsCfgSis.FieldByName('SIS_VALCFG').AsString) And
              (cdsCfgSis.FieldByName('SIS_VALCFG').NewValue = 'S');

  If blnMudou Then
    fMensagem('ATENÇÃO!', 'Solicitar que seja instalado o serviço linux de comunicação com a Yapay!', ['&Ok']);
end;

class procedure TValidarConfiguracoes.pBaixaPedidosEnderecamento;
  var
    qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery;
  Try
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add('UPDATE FATGOR');
    qryUpdate.SQL.Add(' INNER JOIN EXTGOR ON FATGOR.AUTOINCREM = FGO_SEQFGO');
    qryUpdate.SQL.Add('   SET FGO_BKPEND = FGO_DOCEND,');
    qryUpdate.SQL.Add('       FGO_DOCEND = CONCAT("EXC", FGO_DOCEND)');
    qryUpdate.SQL.Add(' WHERE FGO_CODEMP =  "'+VS_StrCodEmp+'"');
    qryUpdate.SQL.Add('   AND IFNULL(FGO_DOCEND, "") <> ""');
    qryUpdate.ExecSQL;

    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add('UPDATE FATGOR');
    qryUpdate.SQL.Add(' INNER JOIN EXTGOR ON FATGOR.AUTOINCREM = FGO_SEQFGO');
    qryUpdate.SQL.Add(' INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM');
    qryUpdate.SQL.Add(' INNER JOIN ITEGER ON ITE_CODITE = FDO_CODITE AND ITE_CODEMP = FDO_CODEMP');
    qryUpdate.SQL.Add('   SET ITE_REPAUD = "S"');
    qryUpdate.SQL.Add(' WHERE FGO_CODEMP =  "'+VS_StrCodEmp+'"');
    qryUpdate.SQL.Add('   AND IFNULL(FGO_DOCEND, "") <> ""');
    qryUpdate.ExecSQL;

    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add('UPDATE FATGOR');
    qryUpdate.SQL.Add(' INNER JOIN EXTGOR ON FATGOR.AUTOINCREM = FGO_SEQFGO');
    qryUpdate.SQL.Add(' INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM');
    qryUpdate.SQL.Add('   SET FATDOR.FDO_JAFATU = 1,');
    qryUpdate.SQL.Add('       FATDOR.FDO_QTDBAI = FATDOR.FDO_QTDITE');
    qryUpdate.SQL.Add('    WHERE FGO_CODEMP = "'+VS_StrCodEmp+'"');
    qryUpdate.SQL.Add('    AND IFNULL(FGO_DOCEND, "") <> ""');
    qryUpdate.ExecSQL;

    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add('UPDATE FATGOR');
    qryUpdate.SQL.Add(' INNER JOIN EXTGOR ON FATGOR.AUTOINCREM = FGO_SEQFGO');
    qryUpdate.SQL.Add('   SET FGO_JAFATU = 1,');
    qryUpdate.SQL.Add('       FGO_MOTBAI = CONCAT("PEDIDOS BAIXADOS PELO DESLIGAMENTO DA CONFIGURACAO [CFG_ENTEND] Data: " , CURDATE())');
    qryUpdate.SQL.Add(' WHERE FGO_CODEMP = "'+VS_StrCodEmp+'"');
    qryUpdate.SQL.Add('   AND IFNULL(FGO_DOCEND, "") <> ""');
    qryUpdate.ExecSQL;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

class function TValidarConfiguracoes.fCadastrarCadBanNovaFormaCadCartaoTef: Boolean;
var
  LblnPodeCadastrar: Boolean ;
  LblnBandeira, LblnAdquirente: Boolean ;
begin
  Result := True ;
  LblnPodeCadastrar := fFindCfg('CFG_CDCRNV')
                       And (fCfgSiS('CDCRNV') = 'N')
                       And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') ;

  if LblnPodeCadastrar then
  begin
    LblnBandeira :=  TRegrasCadastroCartaoTef.fTemRegistrosCadBan ;
    LblnAdquirente := TRegrasCadastroCartaoTef.fTemRegistrosCdAdqC ;
    if LblnBandeira or LblnAdquirente then
    begin
      if Assigned(Self.funcCadastroCartaoTefConferencia) then
      begin
        Result := Self.funcCadastroCartaoTefConferencia(LblnBandeira, LblnAdquirente) ;
        if Result then
        begin
          if not LblnBandeira then
            TRegrasCadastroCartaoTef.fCadastraCadBanPadronizadoTef ;
          if not LblnAdquirente then
            TRegrasCadastroCartaoTef.fCadastraCdAdqCPadronizadoTef ;
        end ;
      end ;
    end
    else
    begin
      TRegrasCadastroCartaoTef.fCadastraCadBanPadronizadoTef ;
      TRegrasCadastroCartaoTef.fCadastraCdAdqCPadronizadoTef ;
    end ;
  end ;
end;

class procedure TValidarConfiguracoes.cdsCfgSisAfterOpen(DataSet: TDataSet);
begin
  inherited;
  pDecriptarConfiguracoes;
  if DataSet.FindField('SIS_VALCFG') <> Nil Then
    DataSet.FieldByName('SIS_VALCFG').OnChange := TValidarConfiguracoes.pOnChangeValCfg;
end;

class procedure TValidarConfiguracoes.cdsCfgSisAfterPost(DataSet: TDataSet);
begin
  dicAlteracoes.AddOrSetValue(DataSet.FieldByName('SIS_CODCFG').AsString + '|' + DataSet.FieldByName('SIS_CODEMP').AsString, DataSet.FieldByName('SIS_VALCFG').AsString);

  If (DataSet.FieldByName('SIS_CODCFG').AsString = 'CFG_MARMKP') And (cfgRepositorio.chkGruposF4.Properties.Items.Count >= 8) Then
    cfgRepositorio.chkGruposF4.Properties.Items[8].Caption := IIF(pos(TValidarConfiguracoes.fGetValorConfiguracao('MARMKP'), '1_5_') > 0,'Margem','Markup') + ' do Cadastro do Produto';

  pAjustaLabelCfgVlcUne;

  If (DataSet.FieldByName('SIS_CODCFG').AsString.Equals('CFG_APIROT')) Then
    pAjustaCFG_PLAROT;

  pExpirarSenhaOperadorCFG_EXPSEN;
end;

class procedure TValidarConfiguracoes.pOnChangeValCfg(Sender : TField);
var
  qryAux : TUniQuery;

    procedure pMensagemDocumento(strMensagem : string);
    var
      arrMensagem: TStringArray;
    begin

      SetLength(arrMensagem, 0);

      pAddDados(arrMensagem, '---------------------------------------------');
      pAddDados(arrMensagem, '| Documento         |  Espécie  |  Romaneio |');
      pAddDados(arrMensagem, '---------------------------------------------');

      qryAux.First;
      while not qryAux.Eof do
      begin
        pAddDados(arrMensagem, '| ' + fPadR(qryAux.FieldByName('GER_NUMDOC').AsString , 18, ' ') + '|' +
                               fPadC(qryAux.FieldByName('GER_ESPDOC').AsString        , 11, ' ') + '|' +
                               fPadC(qryAux.FieldByName('GER_NUMROM').AsString        , 11, ' ') + '|');

        qryAux.Next;

      end;

      fMensagemTabela('ATENÇÃO!',
                      'Documentos',
                      arrMensagem,
                      strMensagem,
                      ['&Ok'],
                      1,
                      False,
                      1,
                      0,
                      False,
                      0,
                      False,
                      False,
                      False,
                      500,
                      70);
    end;
Begin

  If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ROMPLP') Then
  begin
    qryAux := fCriaQuery(nil);
    try
      qryAux.SQL.Add('SELECT DISTINCT                                         ');
      qryAux.SQL.Add('  GER_NUMROM,                                          ');
      qryAux.SQL.Add('  GER_NUMDOC,                                          ');
      qryAux.SQL.Add('  GER_ESPDOC                                           ');
      qryAux.SQL.Add('FROM                                                   ');
      qryAux.SQL.Add('  CORPLP                                               ');
      qryAux.SQL.Add('  INNER JOIN PLPDOC  ON PLD_SEQPLP = CORPLP.AUTOINCREM ');
      qryAux.SQL.Add('   LEFT JOIN COROBJ  ON COB_NUMOBJ = PLD_NUMOBJ AND COB_INATVO = "N" ');
      qryAux.SQL.Add('  INNER JOIN ROMGERX ON GER_NUMDOC = PLD_NUMDOC        ');
      qryAux.SQL.Add('                    AND GER_CODEMP = PLD_EMPDOC        ');
      qryAux.SQL.Add('                    AND GER_ESPDOC = PLD_ESPDOC        ');
      qryAux.SQL.Add('WHERE PLP_CODEMP = '+ QuotedStr(VS_strCodEmp)           );
      qryAux.SQL.Add('  AND PLP_DTAENV IS NULL                               ');
      qryAux.SQL.Add('  AND PLP_NUMROM IS NOT NULL                           ');
      qryAux.Open;

      if not qryAux.IsEmpty then
      begin
        if (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
        begin
          pMensagemDocumento('Não é possível ativar essa configuração, pois os documentos acima, estão em um romaneio com a Pré-Lista de Postagem em aberto. Para prosseguir, envie as Pré-Listas de Postagem, ou remova os documentos dos romaneios!');
          cdsCfgSis.FieldByName('SIS_VALCFG').OnChange := nil;
          cdsCfgSis.FieldByName('SIS_VALCFG').AsString := 'N';
          cdsCfgSis.CheckbrowseMode;
          cdsCfgSis.FieldByName('SIS_VALCFG').OnChange := pOnChangeValCfg;
          Exit;
        end
        else
        begin
          pMensagemDocumento('Não é possível desativar essa configuração, pois os documentos acima, estão em romaneio com a Pré-Lista de Postagem em aberto. Para prosseguir, envie a Pré-Lista de Postagem, ou remova os documentos dos romaneios!');
          cdsCfgSis.FieldByName('SIS_VALCFG').OnChange := nil;
          cdsCfgSis.FieldByName('SIS_VALCFG').AsString := 'S';
          cdsCfgSis.CheckbrowseMode;
          cdsCfgSis.FieldByName('SIS_VALCFG').OnChange := pOnChangeValCfg;
          Exit;
        end;
      end;

    finally
      FreeAndNil(qryAux);
    end;
  end

  else  If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_TPLREC') Then
  begin
    If (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'L') And (fCfgSis('TPLREC', varString) <> cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
    Begin
      if (TValidarConfiguracoes.fGetValorConfiguracao('WMSPLA') = 'R') And (TValidarConfiguracoes.fGetValorConfiguracao('ETQCON') = 'N') Then
      Begin
        fMensagem('','Não é possível utilizar Plano por local de separação quando (CFG_WMSPLA = Após o recebimento do caminhão)!', ['&Ok']);
        cdsCfgSis.FieldByName('SIS_VALCFG').OnChange := nil;
        cdsCfgSis.FieldByName('SIS_VALCFG').AsString := 'C';
        cdsCfgSis.CheckbrowseMode;
        cdsCfgSis.FieldByName('SIS_VALCFG').OnChange := pOnChangeValCfg;
        Exit;
      End;
    end;
  end

  else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_WMSPLA') Then
  Begin
    //Após a Conferencia
    If (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'C') And (fCfgSis('WMSPLA', varString) <> cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
    Begin
      //Não pode ter planos com status "EP" Endereçamento planejado, pois esses planos tem que ser conferidos e endereçados antes de mudar a cfg.
      if ( fCampoTabela('COUNT(0)', 'AGEREC', ['ARC_CODEMP', 'ARC_STATUS'], [VS_strCodEmp, 'EP'] ) > 0 ) Then
      Begin
        fMensagem('','Não é possível mudar a ordem do plano, pois existem planos com status de endereçamento planejado, é necessário conferir todos esses planos para alterar a configuração !', ['&Ok']);
        cdsCfgSis.FieldByName('SIS_VALCFG').OnChange := nil;
        cdsCfgSis.FieldByName('SIS_VALCFG').AsString := 'R';
        cdsCfgSis.CheckbrowseMode;
        cdsCfgSis.FieldByName('SIS_VALCFG').OnChange := pOnChangeValCfg;
      End;

    End

    Else
    //Após o Recebimento do Caminhão
    If (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'R') And (fCfgSis('WMSPLA', varString) <> cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
    Begin
      if (TValidarConfiguracoes.fGetValorConfiguracao('TPLREC') = 'L') And (TValidarConfiguracoes.fGetValorConfiguracao('ETQCON') = 'N') Then
      Begin
        fMensagem('', 'Não é possível realizar o plano antes da conferência quando utiliza Plano de Recebimento por Local de Separação (CFG_TPLREC = L)!', ['&Ok']);
        cdsCfgSis.FieldByName('SIS_VALCFG').OnChange := nil;
        cdsCfgSis.FieldByName('SIS_VALCFG').AsString := 'C';
        cdsCfgSis.CheckbrowseMode;
        cdsCfgSis.FieldByName('SIS_VALCFG').OnChange := pOnChangeValCfg;
        Exit;
      End;

      //Não pode ter planos com status "CN" conferencia, pois esses planos tem que ser planejados e endereçados antes de mudar a cfg.
      if ( fCampoTabela('COUNT(0)', 'AGEREC', ['ARC_CODEMP', 'ARC_STATUS'], [VS_strCodEmp, 'CN'] ) > 0 ) Then
      Begin
        fMensagem('','Não é possível mudar a ordem do plano, pois existem planos com status de conferido, é necessário planejar todos esses planos para alterar a configuração !', ['&Ok']);
        cdsCfgSis.FieldByName('SIS_VALCFG').OnChange := nil;
        cdsCfgSis.FieldByName('SIS_VALCFG').AsString := 'C';
        cdsCfgSis.CheckbrowseMode;
        cdsCfgSis.FieldByName('SIS_VALCFG').OnChange := pOnChangeValCfg;
      End;

    End;

  End;

End;

class procedure TValidarConfiguracoes.cdsCfgSisBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_FRMCUS' Then
  Begin
    If fEmptyStr(TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue) Then
      intValAnt := 2 //default do repositório
    Else
      intValAnt := StrToInt(TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue);
  End
  Else if cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_EXCOSA' Then
    strValAnt := TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue;
end;

class procedure TValidarConfiguracoes.cdsCfgSisBeforePost(DataSet: TDataSet);
var
    strCNPJ: String;
    LCodEmpresas: String;
    LQtdeEmp: integer;
begin
  inherited;

  With DataSet Do
  Begin
    If (FieldByName('SIS_CODCFG').AsString = 'CFG_EXFLCS') Then
    Begin
       LCodEmpresas := FieldByName('SIS_VALCFG').AsString;
       LCodEmpresas := Copy(LCodEmpresas,1, Pos(' ',LCodEmpresas)-1);
       LQtdeEmp     := Length(LCodEmpresas) div 4;
       LCodEmpresas := Copy(LCodEmpresas,1, (LQtdeEmp*4)-1);

       FieldByName('SIS_VALCFG').AsString := LCodEmpresas;
    End
    else
    If (FieldByName('SIS_CODCFG').AsString = 'CFG_CNPJRC') Then
    Begin
      strCNPJ := FieldByName('SIS_VALCFG').AsString;

      If (Not fEmptyStr(strCNPJ)) Then
      Begin

        If fStringRepetida(strCNPJ) Or (Not fTestaCgc(strCNPJ))  Then
        Begin
          pMensagemOk(strCNPJ +  ' não é um CNPJ válido!');
          Abort;
        End;

      End;
    End
    Else If (FieldByName('SIS_CODCFG').AsString = 'CFG_UTIWMS') Then
    Begin
      If FieldByName('SIS_VALCFG').AsString = 'N' Then
        pDesabilitaUtiWmsEmpresa(FieldByName('SIS_CODEMP').AsString);
    End
    Else If (FieldByName('SIS_CODCFG').AsString = 'CFG_QTOREC') Then
    Begin
      If ((FieldByName('SIS_VALCFG').AsInteger <= 0) or (FieldByName('SIS_VALCFG').AsInteger > 999999))  Then
      Begin
        fMensagem('Atenção!','A quantidade limite de ocorrência deve ser de 1 até 999999.', ['&Ok']);
        Abort;
      End;
    End;

    If Assigned(DataSet.AfterScroll) then
      DataSet.AfterScroll(DataSet);
  End;
end;

class function TValidarConfiguracoes.fTabelaPrecoUtilizadaPelaTintaDeMaquina: Boolean;
  Var
    strTabPrc: String;
    strUsaTmq: String;
    intContador: Integer;
    strTabTin: String;
begin
  Result := False;

  strTabTin := '';

  pInformacao('Aguarde, validando configuração de tabela de preço utilizada pela Tinta de Máquina!');

  fFindCfg('CFG_USATMQ');
  strUsaTmq := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  //Tabela de preco Tinta - Cadastro de produtos
  If (fCfgSis('PREGER') = '1') Then
    strTabTin := fCfgSis('TABPRE');

  If (strUsaTmq <> 'S') Or fEmptyStr(strTabTin) Then
  Begin
    Result := True;
    Exit;
  End;

  fFindCfg('CFG_TABPRC');
  strTabPrc := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  For intContador := 1 To Length(strTabPrc) Do
  Begin
    If intContador = strToInt(strTabTin) Then
    Begin
      If (Copy(strTabPrc, intContador, 1) = 'S') Then
      Begin
        Result := True;
        Exit;
      End;
    End;
  End;

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO!','A tabela ( ' + strTabTin + ' ) utilizada para cálculo de preço da tinta de máquina, ' +
                         'não está configurada no faturamento (CFG_TABPRC - Tabelas de preço utilizadas). ' +
                         'Para o correto funcionamento do sistema, essa tabela deverá ser configurada.', ['&Ok']);
  End;
end;

class function TValidarConfiguracoes.fTabelasUsadasFaturamentoOk: Boolean;
  Var
    strTabPrc: String;
    strTabFat: String;
    intContador: Integer;
    strTabIncorretas: String;
begin
  pInformacao('Aguarde, validando configuração de tabelas de preço utilizadas no faturamento!');

  fFindCfg('CFG_TABPRC');
  strTabPrc := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  fFindCfg('CFG_TABFAT');
  strTabFat := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  strTabIncorretas := '';

  For intContador := 1 To Length(strTabFat) Do
  Begin

    If (Copy(strTabFat, intContador, 1) = 'S') Then
    Begin
      If (Copy(strTabPrc, intContador, 1) <> 'S') Then
      Begin
        strTabIncorretas := strTabIncorretas + IntToStr(intContador) + ',';
      End;
    End;

  End;

  Result := True;
  If Not fEmptyStr(strTabIncorretas) Then
  Begin
    strTabIncorretas := LeftStr(strTabIncorretas, Length(strTabIncorretas)-1);
    fMensagem('ATENÇÃO!', 'As tabelas (' + strTabIncorretas + ') não estão configuradas ' +
                         'para utilização no sistema, portanto não podem ser indicadas para ' +
                         'utilização no faturamento.', ['&Ok']);
    Result := False;
  End;

end;

class function TValidarConfiguracoes.fTabelasUsadasConsultaPrecosColetor: Boolean;
  Var
    strTabPrc: String;
    strTabPcl: String;
    intContador: Integer;
    strTabIncorretas: String;
begin
  pInformacao('Aguarde, validando configuração de tabelas de preço utilizadas na consulta de preços do Coletor!');

  fFindCfg('CFG_TABPRC');
  strTabPrc := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  fFindCfg('CFG_TABPCL');
  strTabPcl := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  strTabIncorretas := '';

  For intContador := 1 To Length(strTabPcl) Do
  Begin

    If (Copy(strTabPcl, intContador, 1) = 'S') Then
    Begin
      If (Copy(strTabPrc, intContador, 1) <> 'S') Then
      Begin
        strTabIncorretas := strTabIncorretas + IntToStr(intContador) + ',';
      End;
    End;

  End;

  Result := True;
  If Not fEmptyStr(strTabIncorretas) Then
  Begin
    strTabIncorretas := LeftStr(strTabIncorretas, Length(strTabIncorretas)-1);
    fMensagem('ATENÇÃO!', 'As tabelas (' + strTabIncorretas + ') não estão configuradas ' +
                         'para utilização no sistema, portanto não podem ser indicadas para ' +
                         'utilização na consulta de preços do Coletor.', ['&Ok']);
    Result := False;
  End;

end;

class function TValidarConfiguracoes.fUtilizaControleGuicheDestFat: Boolean;
begin
  Result := True;

  With cdsCfgSis Do Begin
    If (fFindCfg('CFG_USGURE')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') And
       (fFindCfg('CFG_TR1DES')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> 'S') Then Begin
      fMensagem('ATENÇÃO!', 'A configuração ' + QuotedStr('[CFG_USGURE] Controle de Guiche por Retira / Entrega - Utilizar controle de guiche na separacao de OR/PD?') +
       ' somente pode ser utilizada caso a configuração ' + QuotedStr('[CFG_TR1DES] Travar para permitir apenas 1 destino no faturamento (Retira/Entrega)') + ' for utilizada em conjunto.', ['&Ok']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fUtilizaControleGuicheGeral: Boolean;
begin
  Result := True;

  With cdsCfgSis Do Begin
    If (fFindCfg('CFG_USAGUI')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') And
       (fFindCfg('CFG_USGURE')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then Begin
      fMensagem('ATENÇÃO!', 'As configurações ' + QuotedStr('[CFG_USAGUI] Controle de Guiche Geral - Utilizar controle de guiche na separação de OR/PD?') +
       ' e ' + QuotedStr('[CFG_USGURE] Controle de Guiche por Retira / Entrega - Utilizar controle de guiche na separacao de OR/PD?') + ' não podem ser utilizadas em conjunto.', ['&Ok']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaMandae: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configurações de integração com Mandaê !');

  If ((fFindCfg('CFG_MANUSA')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
  Begin
    If (fFindCfg('CFG_MANURL')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Ao habilitar a [CFG_MANUSA] é necessário informar a [CFG_MANURL]. Verifique!', ['&Ok']);
      Result := False;
      Exit;
    End;

    If (fFindCfg('CFG_MANTOK')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Ao habilitar a [CFG_MANUSA] é necessário informar a [CFG_MANTOK]. Verifique!', ['&Ok']);
      Result := False;
      Exit;
    End;

    If (fFindCfg('CFG_MANCRP')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Ao habilitar a [CFG_MANUSA] é necessário informar a [CFG_MANCRP]. Verifique!', ['&Ok']);
      Result := False;
      Exit;
    End;

    If (fFindCfg('CFG_MANCRS')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Ao habilitar a [CFG_MANUSA] é necessário informar a [CFG_MANCRS]. Verifique!', ['&Ok']);
      Result := False;
      Exit;
    End;

    If (fFindCfg('CFG_MANCID')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Ao habilitar a [CFG_MANUSA] é necessário informar a [CFG_MANCID]. Verifique!', ['&Ok']);
      Result := False;
      Exit;
    End;

    If (fFindCfg('CFG_MANADC')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Ao habilitar a [CFG_MANUSA] é necessário informar a [CFG_MANADC]. Verifique!', ['&Ok']);
      Result := False;
      Exit;
    End;

    If (fFindCfg('CFG_MANCTR')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Ao habilitar a [CFG_MANUSA] é necessário informar a [CFG_MANCTR]. Verifique!', ['&Ok']);
      Result := False;
      Exit;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaMargemMinimaPorDocumentoOk: Boolean;

  function asFloat(strCampo: String): Double;
  begin
    Result := cdsCfgSis.FieldByName(strCampo).AsFloat;
  end;

begin
  pInformacao('Aguarde, validando configuração de margem mínima por documento!');

  With cdsCfgSis Do
  Begin

    Result := False;

    If (fFindCfg('CFG_MMDNV1')) And Not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
      Result :=  (asFloat('SIS_VALCFG') >= 0);

    If Not Result Then
      fMensagem('ATENÇÃO!', 'Margens mínimas por documento inválidas!', ['&Ok']);

  End;
end;

class function TValidarConfiguracoes.fValidaMargensDeExibicaoNoF4: Boolean;
  Var
    strExMaF4 : String;
    blnExMrId : Boolean;
    blnMarIde : Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando margens de exibição no F4!');

  strExMaF4 := '';
  blnExMrId := False;
  blnMarIde := False;

  If (fFindCfg('CFG_EXMAF4')) Then
    strExMaF4 := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  If (Not fEmptyStr(strExMaF4)) And (Length(strExMaF4) >= 7) Then
    blnExMrId := (strExMaF4[7] = 'S');

  If (fFindCfg('CFG_MARIDE')) Then
    blnMarIde := (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S');

  If (blnExMrId) And (Not blnMarIde) Then
  Begin
    fMensagem('ATENÇÃO!','Para exibir a Margem Ideal no F4 (CFG_EXMAF4) é necessário habilitar a configuração (CFG_MARIDE)', ['&Ok']);
    Result := False;
  End;

  If (strExMaF4 <> fCfgSis('EXMAF4', varString)) then
  begin
    if (fPergunta('A alteração da configuração '+#13#10+
                  '"CFG_EXMAF4 - Campos de exibição no [F4] Margem no Faturamento" '+#13#10+
                  'irá ocasionar a perda dos ajustes do operador nas colunas do GRID do [F4] Margem no Faturamento.'+#13#10+
                  'Deseja continuar?')) Then
      fGetFuncoesCxGrid.pDeletarView('frmFatMostraMargemNovo.cxgItens', True)
    else
      Result := False;
  end;
end;

class function TValidarConfiguracoes.fValidaMascaraCentroDeCusto: Boolean;
  Var
    strValCfg : String;
begin
  Result := True;
  With cdsCfgSis Do
  Begin
    If fFindCfg('CFG_CODCOM') Then
    Begin
      strValCfg := AnsiReplaceStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString,'.','');
      If fEmptyStr(strValCfg)Then
      Begin
        pMensagemOk('A configuração "CFG_CODCOM" deve ser preenchida!');
        Result := False;
      End
      Else If Length(strValCfg) <= 5 Then
      Begin
        pMensagemOk('A configuração "CFG_CODCOM" não permite máscara com menos de 6 dígitos!');
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaConfiguracoesSintetizacaoConfirmacao: Boolean;
begin
  Result := True;

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_SINCNF') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
       (fFindCfg('CFG_ENTDEV') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')) Then
    Begin
      pMensagemOk('Ao habilitar a "'+'CFG_SINCNF-'+fRetNomCfg('SINCNF') +'", a "CFG_ENTDEV'+
                  '-'+fRetNomCfg('ENTDEV') +'" também deverá ser habilitada!');
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaPDBaixaEntregaFutura: Boolean;
begin
  pInformacao('Aguarde, validando configuração de baixa de entrega futura no romaneio!');

  With cdsCfgSis Do
  If fFindCfg('CFG_ROENFU') And
     (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') And
     fFindCfg('CFG_OPCROM') And
     (Pos(cdsCfgSis.FieldByName('SIS_VALCFG').AsString, '1_5_') <= 0) Then
  Begin
    Result := FALSE;
    fMensagem('','Quando a configuração "CFG_ROENFU - Quando estiver utilizando Romaneio por Pedido de Venda, incluir ' +
                 'documentos de baixa de entrega futura?" estiver ativada, utilizar opção de romaneio por:'+#13#10+
                 '- Pedido de Venda não Faturado '+#13#10+
                 'ou '+#13#10+
                 '- Pedido de Venda não Faturado + Pedido de Venda Faturado',['&Ok']);
  End

  Else Result := TRUE;
end;

class function TValidarConfiguracoes.fValidaPDISIF: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração CFG_PDISIF!');

  With cdsCfgSis Do Begin
    If (fFindCfg('CFG_ICMDEB')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
    Begin
      If (fFindCfg('CFG_PDISIF')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a [CFG_PDISIF], a [CFG_ICMDEB] também precisa estar habilitada. Verifique!', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaPDRCTR: Boolean;
begin
  Result := True;
  If ((fFindCfg('CFG_PDRCTR')) And
      (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
     ((fFindCfg('CFG_CPGCTR')) And
      (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a Configuração CFG_PDRCTR = Sim, a configuração CFG_CPGCTR deve estar configurada como "Sim".', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaREGCID: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração CFG_REGCID!');

  With cdsCfgSis Do Begin
    If (fFindCfg('CFG_REGCID')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
    Begin
      If (fFindCfg('CFG_RECIEF')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a [CFG_RECIEF], a [CFG_REGCID] também precisa estar habilitada. Verifique!', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaRegraDinpar: Boolean;
begin
  Result := True;
  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_TABPRD')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin

      If (fFindCfg('CFG_TIPABF')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '2') Then
      Begin
        fMensagem('ATENÇÃO!', 'Com a configuração (CFG_TABPRD = S), a configuração (CFG_TIPABF) deverá ser Geral!', ['&Ok']);
        Result := False;
      End;
      //Se usar dinpar(CFG_TABPRD) a empresa deve usar o preço da matriz, ou seja tem que apontar para a empresa matriz
      If (fFindCfg('CFG_INFMAT')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
      begin
        If (fFindCfg('CFG_EMPMAT')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> VS_StrCodEmp) Then
        begin
          fMensagem('ATENÇÃO!', 'Com a configuração (CFG_TABPRD = S), deve ser informado a Empresa Matriz(CFG_EMPMAT)!', ['&Ok']);
          Result := False;
        End
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaRMPDPA: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração CFG_RMPDPA!');

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_RMPDPA')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      If (fFindCfg('CFG_ROMPAR')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
      Begin
        fMensagem('ATENÇÃO!', 'Com a configuração (CFG_RMPDPA = S), a configuração (CFG_ROMPAR) deverá ser habilitada!', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaTIPEXP: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração CFG_TIPEXP!');

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_TIPEXP')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '5') Then
    Begin
      If (fFindCfg('CFG_USPRRO')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
      Begin
        fMensagem('ATENÇÃO!', 'Com a configuração (CFG_TIPEXP = 5), a configuração (CFG_USPRRO) deverá ser habilitada!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaROMPLP: boolean;
begin

  if ((fGetValorConfiguracao('ROMPLP') = 'S') and (fGetValorConfiguracao('OPCROM') = '1')) Then
  Begin
    fMensagem('','Não é possível utilizar o Vínculo da PLP (SIGEP WEB) ao romaneio [CFG_ROMPLP], quando utiliza romaneio por Pedido Pedido de Venda [CFG_OPCOM]!', ['&Ok']);
    Result := False;
  End
  else
    Result := True;
end;

class function TValidarConfiguracoes.fValidaSPOIMP : boolean;
begin
  Result := True;
  if ((fGetValorConfiguracao('SPOIMP') = 'S') And (fGetValorConfiguracao('USASER') = 'S') And (fGetValorConfiguracao('IMPNFS') = 'N')) then
  begin
    pMensagemOk('Para utilizar a configuração "Spool de Impressão Citel" é preciso habilitar a configuração "Imprimir nota fiscal eletrônica de serviço pelo NFeImpressão"!');
    Result := False;
  end;
end;

class function TValidarConfiguracoes.fValidaSUGCAP: Boolean;
var
  strSUGCAP: String;
  strSUGPIC: String;
begin
  Result := True;

  strSUGCAP := fGetValorConfiguracao('SUGCAP');
  strSUGPIC := fGetValorConfiguracao('SUGPIC');

  If (strSUGCAP = 'S') And (strSUGPIC <> 'S') Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido utilizar a configuração [CFG_SUGCAP] = "S" com a [CFG_SUGPIC] = "N", Verifique!', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaICMSEP: Boolean;
var
  CFG_CLPVDI: String;
  CFG_ICMSEP: String;
begin
  Result := False;

  CFG_CLPVDI := fGetValorConfiguracao('CLPVDI');
  CFG_ICMSEP := fGetValorConfiguracao('ICMSEP');

  if (CFG_CLPVDI = 'N') and (CFG_ICMSEP = 'S') then
  begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração CFG_ICMSEP, a configuração CFG_CLPVDI deve estar ligada!', ['&Ok']);
    Exit;
  end;

  Result := True;
end;

class function TValidarConfiguracoes.fValidaIDVCPR: Boolean;
begin
  Result := True;
  if ((fGetValorConfiguracao('IDVCPR') = 'S') And (fGetValorConfiguracao('UTICPP') = 'N')) then
  begin
    pMensagemOk('Para utilizar a configuração [CFG_IDVCPR] é preciso habilitar a configuração [CFG_UTICPP]!');
    Result := False;
  end;
end;

class function TValidarConfiguracoes.fValidaIMPLST : boolean;
begin
  Result := True;
  if ((fGetValorConfiguracao('IMPLST') = 'S') And (fGetValorConfiguracao('ILIEMP') = 'N')) then
  begin
    pMensagemOk('Para utilizar a configuração [IMPLST] é preciso habilitar a configuração [ILIEMP]!');
    Result := False;
  end;
end;

class function TValidarConfiguracoes.fValidaRotinaPrioridadeSaidaEstoque: Boolean;
begin
  Result := True;

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_UPSEML') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
       (fFindCfg('CFG_EMPFAT') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')) Then
    Begin
      pMensagemOk('Ao habilitar a "'+'CFG_UPSEML-'+fRetNomCfg('UPSEML') +'", a "CFG_EMPFAT'+
                  '-'+fRetNomCfg('EMPFAT') +'" também deverá ser habilitada!');
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaOpcaoPrecoMedioSemImpostos: Boolean;
begin
  Result := True;

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_TEPREV') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'SIC')) And
       (fFindCfg('CFG_UTISIC') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')) Then
    Begin
      pMensagemOk('Para usar a opção "Preço Médio sem ICMS" em CFG_TEPREV a configuração CFG_UTISIC deverá ser habilitada!');
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaPortadorSenha2QuandoMeiaNotaESeparaFinanceiroOk: Boolean;
  function asString(strCampo: String): String;
  begin
    Result := cdsCfgSis.FieldByName(strCampo).AsString;
  end;
begin
  pInformacao('Aguarde, validando configuração de gravação de contas a receber quando faturar um pedido em nota especial!');

  With cdsCfgSis Do
  Begin
    Result := Not (
                    (fFindCfg('CFG_FINMNO')) And
                    (asString('SIS_VALCFG') = '2') And
                    (fFindCfg('CFG_POCAS2')) And
                    (fEmptyStr(asString('SIS_VALCFG')))
                  );

    If Not Result Then
      fMensagem('ATENÇÃO!', 'Quando grava contas a receber separadamente na meia nota, ' + #13#10 +
        'é necessário configurar o Portador Carteira para gravação do contas a receber, ' +
        'pedidos faturamento futuro.', ['&Ok']);
  End;
end;

class function TValidarConfiguracoes.fValidaPromocaoCompostaPorKit: Boolean;
  var
    LblnPromocaoPorKit,
    LblnUtilizarTabloid : Boolean;
begin
  Result := True;

  LblnPromocaoPorKit  := False;
  LblnUtilizarTabloid := False;

  pInformacao('Aguarde, validando configurações para promoção composta por Kit !');

  If fFindCfg('CFG_PROKIT') Then
    LblnPromocaoPorKit := cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S';

  if LblnPromocaoPorKit Then
  Begin
    If fFindCfg('CFG_TABLOI') Then
      LblnUtilizarTabloid := cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S';

    if not LblnUtilizarTabloid then
    Begin
      fMensagem('ATENÇÃO!', 'Para utilizar promoção composta é preciso ativar a rotina de Tabloid (CFG_TABLOI)', ['&Ok']);
      Exit(False);
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaPRQSEC: Boolean;
begin
  Result := True;

  if (fGetValorConfiguracao('PRQSEC') = 'N') then
    Exit;

  pInformacao('Aguarde, validando configuração CFG_PRQSEC!');

  If (fGetValorConfiguracao('ENTVAL') <> '2') and (fGetValorConfiguracao('ENTLOT') <> '2') Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_PRQSEC = "S"], a configuração CFG_ENTVAL ou a configuração CFG_ENTLOT deve ser Conferencia Entrada!', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaPTCCKO: Boolean;
begin
  Result := True;

  if (fGetValorConfiguracao('PTCCKO') = 'S') and (fGetValorConfiguracao('PCLF11') = 'N') then
  begin
    pMensagemOk('Para utilizar a configuração [CFG_PTCCKO], a configuração [CFG_PCLF11] de deve estar ligada!');
    Result := False;
  end;
end;

class function TValidarConfiguracoes.fValidaQTDCAR: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração CFG_QTDCAR!');

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_OBRMSG')) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      If (fFindCfg('CFG_QTDCAR')) And
         (cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Com a configuração (CFG_OBRMSG = S), a configuração (CFG_QTDCAR) deve ser maior que zero!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaQtdeCasasDecimaisDesconto: Boolean;
Var
  strTabsCmps: String;
  intQtdeDecs: Integer;
  intQtdeDecsCmp: Integer;
begin
  pInformacao('Aguarde, validando configuração de quantidade de casas decimais no desconto!');

  Result := TRUE;
  strTabsCmps := '';

  With cdsCfgSis Do
  If (fFindCfg('CFG_DECDES')) Then
  Begin
    intQtdeDecs := FieldByName('SIS_VALCFG').AsInteger;
    intQtdeDecsCmp := fObterQtdeCasasDecimaisCampo('FATDOR', 'FDO_DESCON');
    If (intQtdeDecsCmp < intQtdeDecs) Then
    Begin
      Result := FALSE;
      strTabsCmps := strTabsCmps + #13 + 'Tabela: "FATDOR" - Campo: "FDO_DESCON" - Qtde Atual: ' + IntToStr(intQtdeDecsCmp);
    End;
    intQtdeDecsCmp := fObterQtdeCasasDecimaisCampo('MOVDET', 'DET_DESCON');
    If (intQtdeDecsCmp < intQtdeDecs) Then
    Begin
      Result := FALSE;
      strTabsCmps := strTabsCmps + #13 + 'Tabela: "MOVDET" - Campo: "DET_DESCON" - Qtde Atual: ' + IntToStr(intQtdeDecsCmp);
    End;
    If Not Result Then
      fMensagem('Atenção','Para que (CFG_DECDES) - Quantidade de Casas decimais para desconto do item funcione, '+
                          'é necessário alterar o tamanho dos seguintes campos no banco de dados: ' + strTabsCmps + #13 +
                          'Entre em contato com a Citel informando esta mensagem.', ['&Ok']);
  End;
end;

class function TValidarConfiguracoes.fValidaQtdeCasasDecimaisQtdeEntrada: Boolean;
Var
  strTabsCmps: String;
  intQtdeDecs: Integer;
  intQtdeQtdIte,
  intQtdePcdQtdIte,
  intQtdeDetQtdIte,
  intQtdeQtdEmb,
  intQtdeDecsFatDorQtdIte,
  intQtdeDecsMovTriEmbala: Integer;
begin
  pInformacao('Aguarde, validando configuração de quantidade de casas decimais da quantidade na entrada de mercadorias!');

  Result := TRUE;
  strTabsCmps := '';

  With cdsCfgSis Do
  If (fFindCfg('CFG_DEQTEM')) Then
  Begin

    intQtdeDecs := FieldByName('SIS_VALCFG').AsInteger;

    if (intQtdeDecs > 4) then
    begin
      intQtdeQtdIte := fObterQtdeCasasDecimaisCampo('MOVDET', 'DET_QTDITE');
      If (intQtdeQtdIte < intQtdeDecs) Then
      Begin
        Result := FALSE;
        strTabsCmps := strTabsCmps + #13 + 'Tabela: "MOVDET" - Campo: "DET_QTDITE" - Qtde Atual: ' + IntToStr(intQtdeQtdIte);
      End;

      intQtdeQtdEmb := fObterQtdeCasasDecimaisCampo('MOVDET', 'DET_QTDEMB');
      If (intQtdeQtdEmb < intQtdeDecs) Then
      Begin
        Result := FALSE;
        strTabsCmps := strTabsCmps + #13 + 'Tabela: "MOVDET" - Campo: "DET_QTDEMB" - Qtde Atual: ' + IntToStr(intQtdeQtdEmb);
      End;

      intQtdePcdQtdIte := fObterQtdeCasasDecimaisCampo('PCMDET', 'PCD_QTDITE');
      If (intQtdePcdQtdIte < intQtdeDecs) Then
      Begin
        Result := FALSE;
        strTabsCmps := strTabsCmps + #13 + 'Tabela: "PCMDET" - Campo: "PCD_QTDITE" - Qtde Atual: ' + IntToStr(intQtdePcdQtdIte);
      End;

      intQtdeDecsFatDorQtdIte := fObterQtdeCasasDecimaisCampo('FATDOR', 'FDO_QTDITE');
      If (intQtdeDecsFatDorQtdIte < intQtdeDecs) Then
      Begin
        Result := FALSE;
        strTabsCmps := strTabsCmps + #13 + 'Tabela: "FATDOR" - Campo: "FDO_QTDITE" - Qtde Atual: ' + IntToStr(intQtdeDecsFatDorQtdIte);
      End;

      intQtdeDecsMovTriEmbala := fObterQtdeCasasDecimaisCampo('MOVTRI', 'TRI_EMBALA');
      If (intQtdeDecsMovTriEmbala < intQtdeDecs) Then
      Begin
        Result := FALSE;
        strTabsCmps := strTabsCmps + #13 + 'Tabela: "MOVTRI" - Campo: "TRI_EMBALA" - Qtde Atual: ' + IntToStr(intQtdeDecsMovTriEmbala);
      End;

      intQtdeDetQtdIte := fObterQtdeCasasDecimaisCampo('DETELE', 'I10_QCCOM');
      If (intQtdeDetQtdIte < intQtdeDecs) Then
      Begin
        Result := FALSE;
        strTabsCmps := strTabsCmps + #13 + 'Tabela: "DETELE" - Campo: "I10_QCCOM" - Qtde Atual: ' + IntToStr(intQtdeDetQtdIte);
      End;
    end;

    If Not Result Then
      fMensagem('Atenção','Para que [(CFG_DEQTEM) - Quantidade de casas decimais para quantidade do produto - ENTRADA DE MERCADORIAS] funcione, '+
                          'é necessário alterar o tamanho dos seguintes campos no banco de dados: ' + strTabsCmps + #13 +
                          'Entre em contato com a Citel informando esta mensagem.', ['&Ok']);
  End;

end;

class function TValidarConfiguracoes.fValidaQtdeCasasDecimaisValorUnitario: Boolean;
Var
  strTabsCmps: String;
  intQtdeDecs: Integer;
  intQtdeDecsUnitar,
  intQtdeDecsUnidig,
  intQtdeDecsUniori: Integer;
begin
  pInformacao('Aguarde, validando configuração de quantidade de casas decimais no valor unitário!');

  Result := TRUE;
  strTabsCmps := '';

  With cdsCfgSis Do
  If (fFindCfg('CFG_DECUNI')) Then
  Begin

    intQtdeDecs := FieldByName('SIS_VALCFG').AsInteger;

    if (intQtdeDecs > 4) then
    begin
      intQtdeDecsUnitar := fObterQtdeCasasDecimaisCampo('MOVDET', 'DET_UNITAR');
      If (intQtdeDecsUnitar < intQtdeDecs) Then
      Begin
        Result := FALSE;
        strTabsCmps := strTabsCmps + #13 + 'Tabela: "MOVDET" - Campo: "DET_UNITAR" - Qtde Atual: ' + IntToStr(intQtdeDecsUnitar);
      End;

      intQtdeDecsUnidig := fObterQtdeCasasDecimaisCampo('MOVDET', 'DET_UNIDIG');
      If (intQtdeDecsUnidig < intQtdeDecs) Then
      Begin
        Result := FALSE;
        strTabsCmps := strTabsCmps + #13 + 'Tabela: "MOVDET" - Campo: "DET_UNIDIG" - Qtde Atual: ' + IntToStr(intQtdeDecsUnidig);
      End;

      intQtdeDecsUniori := fObterQtdeCasasDecimaisCampo('MOVDET', 'DET_UNIORI');
      If (intQtdeDecsUniori < intQtdeDecs) Then
      Begin
        Result := FALSE;
        strTabsCmps := strTabsCmps + #13 + 'Tabela: "MOVDET" - Campo: "DET_UNIORI" - Qtde Atual: ' + IntToStr(intQtdeDecsUniori);
      End;
    end;

    If Not Result Then
      fMensagem('Atenção','Para que (CFG_DECUNI) - Quantidade de Casas decimais para o valor unitário funcione, '+
                          'é necessário alterar o tamanho dos seguintes campos no banco de dados: ' + strTabsCmps + #13 +
                          'Entre em contato com a Citel informando esta mensagem.', ['&Ok']);
  End;
end;

class function TValidarConfiguracoes.fValidaQuandoObrigatorioInformarProfissionalNoCadClientes: Boolean;
begin
  Result := True;

  if (fFindCfg('CFG_OBPRCC'))
     and (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')
     and (not fTemProfissionalAtivo) then
  Begin
    fMensagem('Atenção!','Para ativar a CFG_OBPRCC - "Tornar obrigatório informar o Profissional no Cadastro de Clientes?" '+
                         'é necessário ter pelo menos um cadastro ativo em "Principal > Manutenção de Cadastros > Diversos".' + #13 +
                         'Revise o cadastro de profissionais e depois ative novamente esta configuração.', ['&Ok']);
    cdsCfgSis.Edit;
    cdsCfgSis.FieldByName('SIS_VALCFG').AsString := 'N';
    cdsCfgSis.Post;
  End;
end;

class function TValidarConfiguracoes.fValidaQuantidadeRecorrenciaOcorrencias: Boolean;
begin
  Result := True;

  If (fFindCfg('CFG_QTOREC')) Then
  Begin
    If ((cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger < 0) or
        (cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger > 999999)) Then
    Begin
      fMensagem('Atenção!','A quantidade limite de ocorrência deve ser de 1 até 999999.', ['&Ok']);
      cdsCfgSis.Edit;
      cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger := 1;
      cdsCfgSis.Post;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaQuestFidelidade: Boolean;
begin
  Result := True;

  With cdsCfgSis Do
  if (fFindCfg('CFG_PONQUE') And ((FieldByName('SIS_VALCFG').AsString = 'S'))) And
     ((fFindCfg('CFG_TOKQUE') And (fEmptyStr(FieldByName('SIS_VALCFG').AsString))) Or
      (fFindCfg('CFG_USUQUE') And (fEmptyStr(FieldByName('SIS_VALCFG').AsString))) Or
      (fFindCfg('CFG_SENQUE') And (fEmptyStr(FieldByName('SIS_VALCFG').AsString))) Or
      (fFindCfg('CFG_CARQUE') And (fEmptyStr(FieldByName('SIS_VALCFG').AsString)))) Then
  Begin
    pMensagemOk('As configurações "CFG_TOKQUE", "CFG_CARQUE", "CFG_USUQUE" e "CFG_SENQUE" devem estar preenchidas para que a configuração "CFG_PONQUE" possa estar habilitada!');
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaSequenciaAgrupamento: Boolean;
begin
  Result := True;

  With cdsCfgSis Do
  If (fFindCfg('CFG_AGRCTP') And ((Length(FieldByName('SIS_VALCFG').AsString) > 9))) Then
  Begin
    pMensagemOk('A configuração "CFG_AGRCTP" não permite valor com mais de 9 dígitos!');
    Result := False;
  End;

end;

class function TValidarConfiguracoes.fValidaSistemaEstoqueForaLojaOk: Boolean;
  function asString(strCampo: String): String;
  begin
    Result := cdsCfgSis.FieldByName(strCampo).AsString;
  end;
begin
  pInformacao('Aguarde, validando configuração "Sistema de Estoque Utilizado Quando da Produção de Tinta de Máquina Fora da Loja"!');

  With cdsCfgSis Do
  Begin
    Result := Not (
                    (fFindCfg('CFG_ESTFLJ')) And
                    (asString('SIS_VALCFG') = '2') And
                    (fFindCfg('CFG_OPRFLJ')) And
                    (asString('SIS_VALCFG') = 'S')
                  );

    If Not Result Then
      fMensagem('ATENÇÃO!', 'Quanto a configuração "Sistema de Estoque Utilizado Quando da Produção de Tinta de Máquina Fora da Loja" ' +
        'estiver configurada para "Transferência de Bases / Colorantes" a configuração "Utilizar ordem de produção fora da loja?" ' +
        'não pode estar configurada para "Sim" ', ['&Ok']);
  End;
end;

class function TValidarConfiguracoes.fValidaCfgLayPad: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração CFG_LAYPAD!');

  If Not fFindCfg('CFG_LAYPAD') Then
    Exit;

  If Not fFindCfg('CFG_TIPETI') Then
    Exit;

  If ((fFindCfg('CFG_TIPETI')) And ((cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'M') Or
                                               (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Or
                                               (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)))) Then
  Begin

    If ((fFindCfg('CFG_LAYPAD')) And ((cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> 'Nenhum'))) Then
    Begin
      fMensagem('ATENÇÃO!',  'Quando a configuração [CFG_TIPETI - Etiqueta de Produto] ' + #13#10 +
                             'está com as opções: ' + #13#10 +
                             '[Selecionar no ato da impress'+#227+'o] ou [Matricial]' + #13#10 +
                             'a configuração [CFG_LAYPAD - Layout padrão para impressão de Etiquetas de Produtos]' + #13#10 +
                             'não pode conter layout definido.', ['&Ok']);

      Exit(False);
    End
  End;
end;

class function TValidarConfiguracoes.fValidaCfgLoteSeparacaoParcial: Boolean;
Var
  strDesCfg: String;

  function asString(strCampo: String): String;
  begin
    Result := cdsCfgSis.FieldByName(strCampo).AsString;
  end;

begin
  Result := True;

  If Not fFindCfg('CFG_ROMLPA') Then
    Exit;

  strDesCfg := asString('SIS_DESCRI');

  pInformacao('Aguarde, validando configuração "' + strDesCfg + '"!');

  If asString('SIS_VALCFG') <> 'S' Then
    Exit;

  If Not (fFindCfg('CFG_ROMLOT') And (asString('SIS_VALCFG') = 'S')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Quando a configuração "' + strDesCfg + '" ' +
      'estiver configurada para "Sim" a configuração "' + asString('SIS_DESCRI') + '" ' +
      'também deve estar configurada para "Sim" ', ['&Ok']);
    Exit(False);
  End;

  If Not (fFindCfg('CFG_TIPEXP') And (asString('SIS_VALCFG') = '4')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Quando a configuração "' + strDesCfg + '" ' +
      'estiver configurada para "Sim" a configuração "' + asString('SIS_DESCRI') + '" ' +
      ' deve estar configurada para "4 - Pedido (O pedido não será faturado)" ', ['&Ok']);
    Exit(False);
  End;

end;

class function TValidarConfiguracoes.fValidaCFGsLocalizacaoRemessaDevolucao: Boolean;
var
  arrCFG, arrValor: array of string;
  intPosicao1, intPosicao2: integer;
begin
  Result := True;

  SetLength(arrCFG, 4);
  SetLength(arrValor, 4);

  arrCFG[0] := 'CFG_RDDLFL';
  arrCFG[1] := 'CFG_RDLFLT';
  arrCFG[2] := 'CFG_LFLOSF';
  arrCFG[3] := 'CFG_LFLGDC';

  arrValor[0] := fGetValorConfiguracao('RDDLFL');
  arrValor[1] := fGetValorConfiguracao('RDLFLT');
  arrValor[2] := fGetValorConfiguracao('LFLOSF');
  arrValor[3] := fGetValorConfiguracao('LFLGDC');

  for intPosicao1 := 0 to 2 do
  begin
    for intPosicao2 := intPosicao1+1 to 3 do
    begin
      if arrValor[intPosicao1] = arrValor[intPosicao2] then
      begin
        pMensagemOk('As configurações estão iguais, favor alterar! ' +arrCFG[intPosicao1] + ' - ' + arrCFG[intPosicao2]);
        Exit(False);
      end;
    end;
  end;
end;

class function TValidarConfiguracoes.fValidaSMS: Boolean;
begin
  Result := True;

  With cdsCfgSis Do
  If (
       (
         (fFindCfg('CFG_USRSMS')) And (Not fEmptyStr(FieldByName('SIS_VALCFG').AsString))
       ) And
       (
         (fFindCfg('CFG_SENSMS')) And (fEmptyStr(FieldByName('SIS_VALCFG').AsString))
       )
     ) Or
     (
       (
         (fFindCfg('CFG_USRSMS')) And (fEmptyStr(FieldByName('SIS_VALCFG').AsString))
       ) And
       (
         (fFindCfg('CFG_SENSMS')) And (Not fEmptyStr(FieldByName('SIS_VALCFG').AsString))
       )
     ) Then
  Begin
    If (fFindCfg('CFG_URLSMS')) And (fEmptyStr(FieldByName('SIS_VALCFG').AsString)) Then Begin
      pMensagemOk('A configuração "CFG_URLSMS" deve ser informada!');
    End Else Begin
      pMensagemOk('As configurações "CFG_USRSMS" e "CFG_SENSMS" devem ser informadas!');
    End;

    Result := False;
  End Else If (fFindCfg('CFG_REMSMS')) And (Length(FieldByName('SIS_VALCFG').AsString) > 20) Then Begin
    pMensagemOk('A configuração "CFG_REMSMS" deve possuir no máximo 20 caracteres!');

    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaSugEqu_TabPrc: Boolean;
var
  strTabPrc: String;
  strSugEqu: String;
  strTabEqu: String;
begin
  pInformacao('Aguarde, validando configuração de tabelas de preço utilizadas no conserto de equipamentos!');

  strSugEqu := '0';

  if fFindCfg('CFG_TABPRC') then
    strTabPrc := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  if fFindCfg('CFG_SUGEQU') then
    strSugEqu := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  if fFindCfg('CFG_TABEQU') then
    strTabEqu := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  Result := True;

  if (strSugEqu = '0') then
    Exit;

  if (Copy(strTabPrc, strToInt(strSugEqu), 1) = 'N') then
  begin
    Result := False;

    fMensagem('ATENÇÃO!', 'A tabela (' + strSugEqu + ') não está configurada ' +
                          'para utilização no sistema, portanto não pode ser permitida ' +
                          'no conserto de equipamentos. (CFG_SUGEQU)', ['&Ok']);
    Exit;
  end;

  if (strTabEqu = 'NNNNNNN') then
    Exit;


  if (Copy(strTabEqu, strToInt(strSugEqu), 1) = 'N') then
  begin
    Result := False;

    fMensagem('ATENÇÃO!', 'A tabela (' + strSugEqu + ') não está configurada ' +
                          'para utilização na CFG_TABEQU. (CFG_SUGEQU)', ['&Ok']);
  end;
end;

class function TValidarConfiguracoes.fValidaSugestaoLocalRetira: Boolean;
var
  strOplore : string;
  strLocrsu : string;
  intIndice  : Integer;
  intTamanho : Integer;
begin
  Result := True;
  strOplore := EmptyStr;
  strLocrsu := EmptyStr;

  If fFindCfg('CFG_OPLORE') Then
    strOplore := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  If fFindCfg('CFG_LOCRSU') Then
    strLocrsu := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  intIndice := StrToIntDef(strLocrsu, 0);
  intTamanho := Length(strOplore);

  If intIndice > intTamanho Then
    intIndice := intTamanho;

  If (strOplore[intIndice] = 'N') Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_LOCRSU], a opção na configuração [CFG_OPLORE] deve estar ativa!', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaSUPSEP: boolean;
var
  strSUPSEP: String;
  strUTIWMS: String;
begin
  Result := True;

  strSUPSEP := fGetValorConfiguracao('SUPSEP');
  strUTIWMS := fGetValorConfiguracao('UTIWMS');

  If (strSUPSEP = 'S') And (strUTIWMS <> 'N') Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração CFG_SUPSEP = Sim, o sistema deverá estar utilizando as configurações CFG_UTIWMS = Não', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaCalculoSaldoParaTrava: Boolean;
  function asString(strCampo: String): String;
  begin
    Result := cdsCfgSis.FieldByName(strCampo).AsString;
  end;
begin
  pInformacao('Aguarde, validando configuração "Saldo de estoque para trava"!');

  With cdsCfgSis Do
  Begin
    Result := Not (
                    (fFindCfg('CFG_CALSAL')) And
                    (asString('SIS_VALCFG') <> '2') And
                    (fFindCfg('CFG_BEFTRG')) And
                    (asString('SIS_VALCFG') = 'S')
                  );

    If Not Result Then
      fMensagem('ATENÇÃO!', 'Quando a configuração "Baixar estoque de vendas de ' +
        'entrega futura utilizando Triggers no banco de dados?" estiver configurada para "Sim" a ' +
        'configuração "Saldo de estoque para trava" deve estar definida para ' +
        '"Saldo estoque - Saldo reservado de pedidos"', ['&Ok']);
  End;
end;

class function TValidarConfiguracoes.fValidaCartaoGenericoPagueFacil: Boolean;
begin
  pInformacao('Aguarde, validando configuração "Cartão genérico para transações TEF do Pague Fácil." ');

  Result := True;

  if (fArqIni(0, 'GERAL', 'AUTOATENDIMENTO', '') = 'S') then
  begin
    If (fFindCfg('CFG_TEFCIT') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') And
        fFindCfg('CFG_CARGEN') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Quando o AUTOATENDIMENTO estiver habilitado no arquivo opções.ini da estação e '+
                            'a configuração "CFG_TEFCIT" estiver ativa, a configuração "CFG_CARGEN" '+
                            'deve ser devidamente preenchida!', ['&Ok']);
      Exit(False);
    End;
  end;
end;

class function TValidarConfiguracoes.fValidaCBKUTI: Boolean;
var
  LCBKUTI: String;
begin
  Result := True;

  LCBKUTI := fGetValorConfiguracao('CBKUTI');

  If (LCBKUTI = 'S') And
     (Not fValidaPMVCSH(False)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_CBKUTI=S], '+
                          'O percentual máximo para permitir utilizar cashback '+
                          'em vendas deve estar entre 0.01 e 99.99%! '+
                          'Verifique a configuração [CFG_PMVCSH]', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaCDCRNV: Boolean;
var Lcdcrnv: Boolean;
    LTemCartaoCad: Boolean;

begin
  Lcdcrnv := False;

  Result := True;

  If fFindCfg('CFG_CDCRNV') Then
    Lcdcrnv := (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') And (fCfgSiS('CDCRNV') = 'N') ;

  If (Lcdcrnv) Then
  Begin
    LTemCartaoCad := (fCampoTabela('COUNT(*)',
                                   'CADCAR',
                                   [],
                                   []) > 0);

    If LTemCartaoCad Then
    Begin
      pMensagemSonora('Ao habilitar a variável de configuração "CDCRNV", existem campos que devem ser configurados no cadastro de "Cartões" ("Tipo Transação" e "Adquirente") para o correto funcionamento do TEF. Favor verificar!');
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaCDPHAB_CDPURL_CDPAPK: boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configurações da INTEGRAÇÃO DE SISTEMAS - CLUBE DO PINTOR!');

  If (fGetValorConfiguracao('CDPHAB') = 'N') And
     (fEmptyStr(fGetValorConfiguracao('CDPURL'))) And
     (fEmptyStr(fGetValorConfiguracao('CDPAPK'))) Then
    Exit;

  If (fGetValorConfiguracao('CDPHAB') = 'S') And
     (Not fEmptyStr(fGetValorConfiguracao('CDPURL'))) And
     (Not fEmptyStr(fGetValorConfiguracao('CDPAPK'))) Then
    Exit;

  Result := False;

  fMensagem(
    'ATENÇÃO!',
      'Para utilizar a INTEGRAÇÃO DE SISTEMAS - CLUBE DO PINTOR, a configuração '+
      '[CFG_CDPHAB] deve ser igual a "Sim" e as configurações [CFG_CDPURL] e [CFG_CDPAPK] '+
      'devem ser preenchidas corretamente.', ['&Ok']);
end;

class function TValidarConfiguracoes.fValidaCENDNE: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração Reposição de Gôndola!');

  if (fFindCfg('CFG_CENDNE')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') then
  begin
    if ((fFindCfg('CFG_ROMBCX')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) or
      ((fFindCfg('CFG_CFVLCB')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')) then
    begin
      fMensagem('ATENÇÃO!', 'Para utilizar a configuração ["CFG_CENDNE" - Utilizar rotina de Conferência de Entrada para Documentos Não Entregues], '+
        'é necessário definir as configurações [CFG_CFVLCB = SIM] e [CFG_ROMBCX = NÃO].', ['&Ok']);
      Result := False;
    end;
  end;
end;

class function TValidarConfiguracoes.fValidaCFGCANEND: boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração CFG_CANEND!');

  If (fFindCfg('CFG_CANEND') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
     (fFindCfg('CFG_BXSLSE') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
  Begin
    fMensagem(
      'ATENÇÃO!',
        'As configurações [CFG_CANEND] e [CFG_BXSLSE] são exclusivas. ' + sLineBreak +
        'Para ativar uma delas, a outra deverá estar defina como "Não"!', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaPEPFIM : Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_PEPFIM!');

  if (fFindCfg('CFG_PEPFIM')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
  begin
    if ((fFindCfg('CFG_PROPRE')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> '1')) then
    begin
      fMensagem('ATENÇÃO!', 'Quando utilizar a configuração "CFG_PEPFIM" que habilita promoção com Preço fixo para Tinta de Máquina Imobiliária, a CFG_PROPRE deve ser configurada com o valor "1 - Preço de Promoção".', ['&OK']);
      Result := False;
    end;
  end;
end;

class function TValidarConfiguracoes.fValidaVendasHorario: Boolean;
  Var
    intAbertura : Integer;
    intFechamento : Integer;
begin
  pInformacao('Aguarde, validando configuração de vendas por horário!');

  Result := True;

  With cdsCfgSis Do
  Begin
    fFindCfg('CFG_VHHRAB');
    intAbertura := StrToIntDef(cdsCfgSis.FieldByName('SIS_VALCFG').AsString, -1);

    fFindCfg('CFG_VHHRFC');
    intFechamento := StrToIntDef(cdsCfgSis.FieldByName('SIS_VALCFG').AsString, -1);

    If (intAbertura < 0) Or (intAbertura > 23) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'O horário de abertura deve ser uma valor inteiro de 0 a 23 - CFG_VHHRAB', ['&Ok']);
    End
    Else If (intFechamento < 0) Or (intFechamento > 23) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'O horário de fechamento deve ser uma valor inteiro de 0 a 23 - CFG_VHHRFC', ['&Ok']);
    End
    Else If (intFechamento <= intAbertura) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'O horário de fechamento não pode ser menor ou igual ao horário de abertura', ['&Ok']);
    End;

  End;
end;

class function TValidarConfiguracoes.fValidaVendaVidroOuMadeira: Boolean;
begin
  pInformacao('Aguarde, validando configuração de venda de Vidro ou Madeira!');

  With cdsCfgSis Do
  Begin
    Result := NOT ((fFindCfg('CFG_VENMAD')) And
                   (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') And
                   (fFindCfg('CFG_VENVID')) And
                   (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S'));

    If Not Result Then
      fMensagem('ATENÇÃO!', 'O sistema não permite a configuração de ' + #13 +
                            'Venda de Madeira e Venda de Vidro juntos.' + #13 +
                            'Configure apenas uma destas opções!', ['&Ok']);
  End;
end;

class function TValidarConfiguracoes.fValidaAliquotasPisCofins: Boolean;
  Var
    strAliquotas: String;
    stlAliquotas: TStringList;
    intContador: Integer;
Begin
  Result := True;

  If fFindCfg('CFG_PISCOF') Then
  Begin

    strAliquotas := AnsiReplaceStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString, '-', #13#10);

    stlAliquotas := TStringList.Create;
    stlAliquotas.Text := strAliquotas;

    For intContador := 0 To stlAliquotas.Count -1 Do
      If (Not fEmptyStr(stlAliquotas[intContador])) And
         (StrToFloatDef(Trim(stlAliquotas[intContador]), -1) = - 1) Then
      Begin
        Result := False;
        pMensagemOk('O formato para a configuração das alíquotas deve ser o percentuais separados por "-". Exemplo: 9,25-6,25');
        Break;
      End;

    FreeAndNil(stlAliquotas);

  End;
End;

class function TValidarConfiguracoes.fValidaALTVMT: Boolean;
var
  LALTVMT: String;
  LTRVEPR: String;
begin
  Result := True;

  LALTVMT := fGetValorConfiguracao('ALTVMT');
  LTRVEPR := fGetValorConfiguracao('TRVEPR');

  If LALTVMT = 'N' Then
    Exit;

  If LTRVEPR = '2' Then
    Exit;

  fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_ALTVMT], a configuração [CFG_TRVEPR] deve estar em "2-Travar no final da venda"!', ['&Ok']);
  Result := False;
end;

class function TValidarConfiguracoes.fValidaCorteDePedidoSemEstoqueOk: Boolean;
  function asString(strCampo: String): String;
  begin
    Result := cdsCfgSis.FieldByName(strCampo).AsString;
  end;
begin
  pInformacao('Aguarde, validando configuração de corte de pedido X solicitar empresa de faturamento!');

  With cdsCfgSis Do
  Begin
    Result := Not (
                    (fFindCfg('CFG_EMPFAT')) And
                    (asString('SIS_VALCFG') = 'S') And
                    (fFindCfg('CFG_CTESPV')) And
                    (asString('SIS_VALCFG') = 'S')
                  );

    If Not Result Then
      fMensagem('ATENÇÃO!', 'Não é possível utilizar as configurações ' +
        'Solicitar empresa de faturamento nos itens da tela de orçamento/pedido/vendas e ' +
        'Utilizar corte de pedido de venda, mediante quantidade de estoque ao mesmo tempo.', ['&Ok']);
  End;
end;

class function TValidarConfiguracoes.fValidaCortePorEstoqueNoPedidoDeVendaOk: Boolean;
  function asString(strCampo: String): String;
  begin
    Result := cdsCfgSis.FieldByName(strCampo).AsString;
  end;
begin
  pInformacao('Aguarde, validando configuração de corte de pedido - motivo de vendas perdidas!');

  With cdsCfgSis Do
  Begin
    Result := Not (
                    (fFindCfg('CFG_CTESPV')) And
                    (asString('SIS_VALCFG') = 'S') And
                    (fFindCfg('CFG_MOTCOR')) And
                    (fEmptyStr(asString('SIS_VALCFG')))
                  );

    If Not Result Then
      fMensagem('ATENÇÃO!', 'Favor configurar o motivo de vendas perdidas para o corte.', ['&Ok']);
  End;
end;

class function TValidarConfiguracoes.fValidaDigitoLinGruFranq: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de dígito para cadastro de Linha/Grupo Franqueadora!');

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_PRDFRQ')) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      If (fFindCfg('CFG_FRQLGD')) And
         (
           (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '') Or
           (cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger > 9)
         ) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a Configuração CFG_PRDFRQ = Sim, a configuração CFG_FRQLGD deve estar no intervalo de 0 a 9.', ['&Ok']);
        Result := False;
      End;
    End Else Begin
      If (fFindCfg('CFG_FRQLGD')) And
         ((cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> '') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> '0')) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a Configuração CFG_FRQLGD diferente de vazio, a configuração CFG_PRDFRQ deve estar configurada como Sim.', ['&Ok']);
        Result := False;
      End;
    End;
  End;


end;

class function TValidarConfiguracoes.fValidaDIMPF4: Boolean;
var
  LDIMPF4,
  LICMDEB,
  LFCPBPC,
  LPDISIF: String;
begin
  Result  := True;

  pInformacao('Aguarde, validando configuração CFG_DIMPF4!');

  LDIMPF4 := fGetValorConfiguracao('DIMPF4');
  LICMDEB := fGetValorConfiguracao('ICMDEB');
  LFCPBPC := fGetValorConfiguracao('FCPBPC');
  LPDISIF := fGetValorConfiguracao('PDISIF');

  if (LDIMPF4 = 'N') then
    Exit;

  if (LICMDEB = 'S') and (LFCPBPC <> 'N') and (LPDISIF = 'N') then
    Exit;

  fMensagem('ATENÇÃO!', 'Para ligar a configuração [CFG_DIMPF4], deve ativar as configurações [CFG_ICMDEB] e [CFG_FCPBPC] e desativar a configuração [CFG_PDISIF]!', ['&Ok']);
  Result := False;
end;

class function TValidarConfiguracoes.fValidaDmpMvp: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de Desmembramento de Pedido de Venda');

  With cdsCfgSis Do Begin
    If (fFindCfg('CFG_DMPOPC')) And (Copy(cdsCfgSis.FieldByName('SIS_VALCFG').AsString, 2, 1) = 'S') and
       (fFindCfg('CFG_DMPMVP')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '') Then
    begin
      fMensagem('ATENÇÃO!', 'Favor configurar o Motivo para geração de Venda Perdida [CFG_DMPMVP]!', ['&Ok']);
      Result := False;
    end;
  End;

end;

class function TValidarConfiguracoes.fValidaDmpOpc: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de Desmembramento de Pedido de Venda');

  With cdsCfgSis Do Begin
    If (fFindCfg('CFG_DMPOPC')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'NNN') Then
    Begin
      fMensagem('ATENÇÃO!', 'Pelo menos uma opção deve ser selecionada na configuração CFG_DMPOPC. Verifique!', ['&Ok']);
      Result := False;
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaDownloadXml: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de envio das informações de venda na Nota Fiscal Eletrônica!');

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_AUTDOW')) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      If (fFindCfg('CFG_ESCDOW')) And
         (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a configuração CFG_AUTDOW = "Sim", a configuração CFG_ESCDOW' + #13 +
                              'deve ser alterada para "Não".', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaFormaPagtoNegociadaAutoAtendimentoPagueFacil: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de formas de pagamento negociada para o Auto Atendimento!');

  If ((fFindCfg('CFG_TFPCPG')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
  Begin
    If (fFindCfg('CFG_SOLCAR')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      fMensagem('ATENÇÃO!', 'Para utilizar a configuração CFG_TFPCPG = "Sim", a configuração CFG_SOLCAR' + #13 +
                            'deve ser alterada para "Não".', ['&Ok']);
      Result := False;
      Exit;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaFrenet: Boolean;
  var
    LstrNomeCFG : String;
    LintIdx     : Integer;
begin
  Result := True;

  pInformacao('Aguarde, validando configurações de integração com Frenet !');

  If ((fFindCfg('CFG_FREUSA')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
  Begin
    If (fFindCfg('CFG_FREURL')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Ao habilitar a [CFG_FREUSA] é necessário informar a [CFG_FREURL]. Verifique!', ['&Ok']);
      Result := False;
      Exit;
    End;

    If (fFindCfg('CFG_FRETOK')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Ao habilitar a [CFG_FREUSA] é necessário informar a [CFG_FRETOK]. Verifique!', ['&Ok']);
      Result := False;
      Exit;
    End;

    If (fFindCfg('CFG_FRECOR')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Ao habilitar a [CFG_FREUSA] é necessário informar a [CFG_FRECOR]. Verifique!', ['&Ok']);
      Result := False;
      Exit;
    End;

    If (fFindCfg('CFG_MOEXSI')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '0') Then
    Begin
      fMensagem('ATENÇÃO!', 'Para utilizar integração Frenet (CFG_FREUSA), a configuração do Modelo de Exportação para utilização '+
        '(CFG_MOEXSI) deverá ser diferente de "Não gerar arquivos". A escolha de qualquer modelo não influenciará no processo!', ['&Ok']);
      Result := False;
      Exit;
    End;

    If (fFindCfg('CFG_FRESVC')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Ao habilitar a [CFG_FREUSA] é necessário informar a [CFG_FRESVC]. Verifique!', ['&Ok']);
      Result := False;
      Exit;
    End;

    For LintIdx := 1 To 7 Do
    Begin
      LstrNomeCFG := 'CFG_FREFT'+IntToStr(LintIdx);

      If (fFindCfg(LstrNomeCFG)) And
         ((StrToFloat(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) < 0) Or  (StrToFloat(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) > 100)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Ao habilitar a [CFG_FREUSA] é necessário que a ['+LstrNomeCFG+'] esteja entre 0% e 100%!', ['&Ok']);
        Result := False;
        Exit;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaFATCNS: Boolean;
var
  strFATCNS: String;
  strUTIWMS: String;
  strSOLOLA: String;
begin
  Result := True;

  strFATCNS := fGetValorConfiguracao('FATCNS');
  strUTIWMS := fGetValorConfiguracao('UTIWMS');
  strSOLOLA := fGetValorConfiguracao('SOLOLA');

  If (strFATCNS = 'S') And ((strUTIWMS <> 'S') Or (strSOLOLA <> 'S')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração CFG_FATCNS = Sim, ' + #13 + ' o sistema deverá estar utilizando as ' +
      'configurações CFG_UTIWMS = SIM, CFG_SOLOLA = Sim', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaFatorCustoNotaEspecial: Boolean;
begin
  Result := True;

  With cdsCfgSis Do
  Begin
    If fFindCfg('CFG_FTCUNE') And
       (FieldByName('SIS_VALCFG').Value <= 0) Then
    Begin
      fMensagem('','[CFG_FTCUNE] '+fRetNomCfg('CFG_FTCUNE')+' deve ser maior que zero!',['&Ok']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaFLXSEP: Boolean;
begin
  Result := True;

  if (fFindCfg('CFG_FLXSEP')) And
     (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') then
  begin
    if (fFindCfg('CFG_BAISEP')) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') then
    begin
      fMensagem('ATENÇÃO!', 'Para utilizar a Configuração CFG_FLXSEP = Sim, a configuração CFG_BAISEP' + #13 +
                            'deve ser alterada para "SIM".', ['&Ok']);
      Result := False;
    end;
  end;
end;

class function TValidarConfiguracoes.fValidaFreteNFCeCupomFiscal: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de frete para NFC-e e Cupom Fiscal!');

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_FRECUP')) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      If (fFindCfg('CFG_USNFCE')) And
         (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a Configuração CFG_FRECUP = Sim, a configuração CFG_USNFCE' + #13 +
                              'deve ser alterada para "NÃO".', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaFreTra: Boolean;
begin

  Result := True;

  pInformacao('Aguarde, validando configuração "CFG_FRETRA - Forma do cálculo do frete no faturamento".');

  With cdsCfgSis Do
  Begin

    If ((fFindCfg('CFG_FRETRA')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '5')) Then
    Begin

      If ((fFindCfg('CFG_REGCLO')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> 'S')) Or
         ((fFindCfg('CFG_INFFRE')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> 'S')) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a configuração "CFG_FRETRA = Pela Transportadora / Região" as configurações "CFG_REGCLO / CFG_INFFRE" precisam estar igual a SIM!', ['&Ok']);
        Result := False;
      End;

    End;

  End;

end;

class function TValidarConfiguracoes.fValidaIntegracaoContabilidadeDigital : Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando integração contabilidade digital!');
  if (fFindCfg('CFG_DOMHAB')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') then
  begin
    if (fFindCfg('CFG_DOMCID')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    begin
      fMensagem('ATENÇÃO!', 'Para utilizar a integração contabilidade digital é necessário que a "CFG_DOMCID" esteja preenchida.', ['&Ok']);
      Result := False;
      exit ;
    end;
    if (fFindCfg('CFG_DOMSEC')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    begin
      fMensagem('ATENÇÃO!', 'Para utilizar a integração contabilidade digital é necessário que a "CFG_DOMSEC" esteja preenchida.', ['&Ok']);
      Result := False;
      exit ;
    end;
    if (fFindCfg('CFG_DOMAUD')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    begin
      fMensagem('ATENÇÃO!', 'Para utilizar a integração contabilidade digital é necessário que a "CFG_DOMAUD" esteja preenchida.', ['&Ok']);
      Result := False;
      exit ;
    end;
    if (fFindCfg('CFG_DOMXIK')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    begin
      fMensagem('ATENÇÃO!', 'Para utilizar a integração contabilidade digital é necessário que a "CFG_DOMXIK" esteja preenchida.', ['&Ok']);
      Result := False;
      exit ;
    end;
    if (fFindCfg('CFG_DOMURL')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    begin
      fMensagem('ATENÇÃO!', 'Para utilizar a integração contabilidade digital é necessário que a "CFG_DOMURL" esteja preenchida.', ['&Ok']);
      Result := False;
      exit ;
    end;
    if (fFindCfg('CFG_DOMUTK')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    begin
      fMensagem('ATENÇÃO!', 'Para utilizar a integração contabilidade digital é necessário que a "CFG_DOMUTK" esteja preenchida.', ['&Ok']);
      Result := False;
      exit ;
    end;
  end ;
end ;

class function TValidarConfiguracoes.fValidaGATOPE: Boolean;
begin
  Result := True;

  If (fFindCfg('CFG_UTIWPP')) and (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
    Exit;

  If (fFindCfg('CFG_GATINF')) and (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
    Exit;

  If Not fFindCfg('CFG_GATOPE') Then
    Exit;

  if not fValidarEstruturaParaDisparoDeWhatsappDosGatilhosDeInformacao(cdsCfgSis.FieldByName('SIS_VALCFG').AsString, True, False) then
    Exit(False);
end;

class function TValidarConfiguracoes.fValidaGeraLinkPagamentoCitel: Boolean;
var
  LVal: Integer;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de link de pagamento online!');

  if (fFindCfg('CFG_LINKPG')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger in [2, 3, 5, 7]) then
  begin
    if (fFindCfg('CFG_CARSIT')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) then
    begin
      fMensagem('ATENÇÃO!', 'Para utilizar o Link de Pagamento E-Sitef("CFG_LINKPG - 2") ou Cielo("CFG_LINKPG - 3") é necessário que a configuração "CFG_CARSIT" esteja preenchida.', ['&Ok']);
      Result := False;
    end ;

    if (fFindCfg('CFG_PORBLK')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) then
    begin
      fMensagem('ATENÇÃO!', 'Para utilizar o Link de Pagamento [CFG_LINKPG] é necessário que a configuração "CFG_PORBLK" esteja preenchida.', ['&Ok']);
      Result := False;
    end ;

    if (fFindCfg('CFG_CTABLK')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) then
    begin
      fMensagem('ATENÇÃO!', 'Para utilizar o Link de Pagamento [CFG_LINKPG] é necessário que a configuração "CFG_CTABLK" esteja preenchida.', ['&Ok']);
      Result := False;
    end ;

    if fFindCfg('CFG_LNKEXP') then
    begin
      LVal := StrToIntDef(cdsCfgSis.FieldByName('SIS_VALCFG').AsString, 0);
      if (LVal <= 0) or (LVal > 30) then
      begin
        fMensagem('ATENÇÃO!', 'O prazo de expiração do Link de Pagamento [CFG_LNKEXP] deve ser entre 1 e 30 dias. Ajuste o valor e tente novamente.', ['&Ok']);
        Result := False;
      end;
    end ;

    If (fFindCfg('CFG_LINKPG')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger = 2) Then
    Begin
      If ((fFindCfg('CFG_MIPSIT')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) or
         ((fFindCfg('CFG_MKPSIT')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) or
         ((fFindCfg('CFG_URLSIT')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar o Link de Pagamento E-Sitef("CFG_LINKPG - 2") é necessário que as configurações "CFG_MIPSIT", "CFG_MKPSIT" e "CFG_URLSIT" estejam preenchidas.', ['&Ok']);
        Result := False;
      End;
    End
    else If (fFindCfg('CFG_LINKPG')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger = 3) Then
    begin
      If ((fFindCfg('CFG_ID_CIE')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) or
         ((fFindCfg('CFG_SECCIE')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) or
         ((fFindCfg('CFG_URLCIE')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar o Link de Pagamento Cielo("CFG_LINKPG - 3") é necessário que as configurações "CFG_ID_CIE", "CFG_SECCIE" e "CFG_URLCIE" estejam preenchidas.', ['&Ok']);
        Result := False;
      End;
    end
    else If (fFindCfg('CFG_LINKPG')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger = 5) Then
    begin
      If ((fFindCfg('CFG_IDCPAY')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) or
         ((fFindCfg('CFG_SCCPAY')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) or
         ((fFindCfg('CFG_URCPAY')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar o Link de Pagamento CredPay("CFG_LINKPG - 5") é necessário que as configurações "CFG_IDCPAY", "CFG_SCCPAY" e "CFG_URCPAY" estejam preenchidas.', ['&Ok']);
        Result := False;
      End;
    end else If (fFindCfg('CFG_LINKPG')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger = 7) Then
    begin
      If ((fFindCfg('CFG_URLIPG')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) or
         ((fFindCfg('CFG_ID_IPG')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) or
         ((fFindCfg('CFG_SECIPG')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar o Link de Pagamento Ipag("CFG_LINKPG - 7") é necessário que as configurações "CFG_URLIPG", "CFG_ID_IPG" e "CFG_SECIPG" estejam preenchidas.', ['&Ok']);
        Result := False;
      End;
    end ;
  end ;
end;

class function TValidarConfiguracoes.fValidaGONDOL: Boolean;
begin
  rESULT := True;
  pInformacao('Aguarde, validando configuração Reposição de Gôndola!');

  With cdsCfgSis Do Begin
    If (fFindCfg('CFG_GONDOL')) And (FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      If (fFindCfg('CFG_UTIWMS')) And (FieldByName('SIS_VALCFG').AsString = 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'A configuração ["CFG_GONDOL" - Utilizar rotina de solicitação de Reposição de Gôndola?] não pode ser utiliza com Wms.', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaGROPWS: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_GROPWS!');

  If fFindCfg('CFG_GROPWS') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') And
     fFindCfg('CFG_ORDPRO') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> 'N') Then
  Begin
    fMensagem('ATENÇÃO!', 'Para usar a configuração CFG_GROPWS é preciso que a configuração (CFG_ORDPRO = NÃO)!', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaMUNINC: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração CFG_ENOOBR e CFG_MUNINC.');

  With cdsCfgSis Do Begin
    If ((fFindCfg('CFG_ENOOBR')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
       ((fFindCfg('CFG_MUNINC')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido utilizar a configuração [CFG_ENOOBR] = "S" com a [CFG_MUNINC] = "S", Verifique!', ['&Ok']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaGrupoRiscoCliente: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de linhas de serviço!');

  With cdsCfgSis Do Begin
    If (fFindCfg('CFG_GRRSCL')) And (FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      If (fFindCfg('CFG_CLIATR')) And (FieldByName('SIS_VALCFG').AsString = 'N') Then
      Begin
        fMensagem('ATENÇÃO!', 'Quando se utiliza grupo de risco de cliente é necessário utilizar quantidade de dias em atraso por cliente (CFG_CLIATR)', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaHABREA: Boolean;
begin
  Result := True;

  if (fGetValorConfiguracao('HABREA') <> 'NN') then
    Exit;

  fMensagem('ATENÇÃO!', 'Selecione ao menos uma opção na [CFG_HABREA]!', ['&Ok']);

  Result := False;
end;

class function TValidarConfiguracoes.fValidaIntegracaoGryncash: Boolean;
begin
  pInformacao('Aguarde, validando configuração GRYNCASH!');

  Result := fGetValorConfiguracao('USAGRY') = 'N'; // NÃO USA GRYNCASH

  if not Result then // USA GRYNCASH
  Begin
    Result := not fEmptyStr(fGetValorConfiguracao('URLGRY'));
    if not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_USAGRY, a configuração CFG_URLGRY deve estar preenchida!', ['&Ok']);
      Exit;
    end;

    Result := not fEmptyStr(fGetValorConfiguracao('STORID'));
    if Not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_USAGRY, a configuração CFG_STORID deve estar preenchida!', ['&Ok']);
      Exit;
    end;

    Result := not fEmptyStr(fGetValorConfiguracao('TOKGRY'));
    if Not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_USAGRY, a configuração CFG_TOKGRY deve estar preenchida!', ['&Ok']);
      Exit;
    end;

    Result := not fEmptyStr(fGetValorConfiguracao('CARGRY'));
    if Not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_USAGRY, a configuração CFG_CARGRY deve estar preenchida!', ['&Ok']);
      Exit;
    end;
  end;
end;

class function TValidarConfiguracoes.fValidaIntegracaoIntelipost: Boolean;
begin
  pInformacao('Aguarde, validando configuração Intelipost!');

  Result := fGetValorConfiguracao('ITPUTI') = 'N';

  if not Result then
  Begin
    Result := not fEmptyStr(fGetValorConfiguracao('ITPURL'));
    if not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_ITPUTI, a configuração CFG_ITPURL deve estar preenchida!', ['&Ok']);
      Exit;
    end;

    Result := not fEmptyStr(fGetValorConfiguracao('ITPKEY'));
    if Not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_ITPUTI, a configuração CFG_ITPKEY deve estar preenchida!', ['&Ok']);
      Exit;
    end;
  end;
end;

class function TValidarConfiguracoes.fValidaINVCRI: boolean;
var
  strINVCRI: String;
  strLRGMIC: String;
  strMPINAT: String;
begin
  Result := True;

  strINVCRI := fGetValorConfiguracao('INVCRI');
  strLRGMIC := fGetValorConfiguracao('LRGMIC');
  strMPINAT := fGetValorConfiguracao('MPINAT');

  If (strINVCRI = 'S') And ((strLRGMIC <> 'S') Or (strMPINAT <> 'S')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração CFG_INVCRI = Sim, o sistema deverá estar utilizando as configurações CFG_LRGMIC = Sim e CFG_MPINAT = Sim', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaItensParaSintetizacaoDePedido: Boolean;
  var
    LstrValorCFG : String;
    LintIdx      : Integer;
begin
  Result := True;

  pInformacao('Aguarde, validando configurações para itens da sintetização do pedido !');

  If fFindCfg('CFG_ITESIN') Then
    LstrValorCFG := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  For LintIdx := 1 To 2 Do
  Begin
    If Copy(LstrValorCFG, LintIdx, 1) = '0' Then
    Begin
      if LintIdx = 1 then
        LstrValorCFG := '"Código do Item"'
      else
        LstrValorCFG := '"Descrição do Item"';

      fMensagem('ATENÇÃO!','A opção '+LstrValorCFG+' da "CFG_ITESIN" não pode ser desmarcada!', ['&Ok']);
      Exit(False);
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaIntegracaoAlpe: Boolean;
begin
  pInformacao('Aguarde, validando configuração ALPE!');

  Result := fGetValorConfiguracao('USAALP') = 'N'; // NÃO USA ALPE

  if not Result then // USA ALPE
  Begin
    Result := not fEmptyStr(fGetValorConfiguracao('URLALP'));
    if not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_USAALP, a configuração CFG_URLALP deve estar preenchida!', ['&Ok']);
      Exit;
    end;

    Result := not fEmptyStr(fGetValorConfiguracao('CLIEID'));
    if Not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_USAALP, a configuração CFG_CLIEID deve estar preenchida!', ['&Ok']);
      Exit;
    end;

    Result := not fEmptyStr(fGetValorConfiguracao('CLISEC'));
    if Not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_USAALP, a configuração CFG_CLISEC deve estar preenchida!', ['&Ok']);
      Exit;
    end;

    Result := not fEmptyStr(fGetValorConfiguracao('CPGALP'));
    if Not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_USAALP, a configuração CFG_CPGALP deve estar preenchida!', ['&Ok']);
      Exit;
    end
    else
    begin
      if fCampoTabela('CND_TIPFOR', 'CADCND', ['CND_CODIGO'], [Copy(fGetValorConfiguracao('CPGALP'),1,3)] ) <> 'OUTROS' then
      begin
        fMensagem('ATENÇÃO', ' A Condição de Pagamento Alpe deve ser fora "Outros".', ['&Ok']);
        Exit(False);
      end;
    end;

    Result := not fEmptyStr(fGetValorConfiguracao('CARALP'));
    if not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_USAALP, a configuração CFG_CARALP deve estar preenchida!', ['&Ok']);
      Exit;
    end;
  end;
end;

class function TValidarConfiguracoes.fValidaIntegracaoAlpeKonekt: Boolean;
begin
  pInformacao('Aguarde, validando configuração ALPE KONEKT!');

  Result := fGetValorConfiguracao('ALPKNK') = 'N'; // NÃO USA ALPE KONEKT

  if not Result then // USA ALPE KONEKT
  Begin
    Result := not fEmptyStr(fGetValorConfiguracao('URLKNK'));
    if not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_ALPKNK, a configuração CFG_URLKNK deve estar preenchida!', ['&Ok']);
      Exit;
    end;

    Result := not fEmptyStr(fGetValorConfiguracao('IDKNKT'));
    if Not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_ALPKNK, a configuração CFG_IDKNKT deve estar preenchida!', ['&Ok']);
      Exit;
    end;

    Result := not fEmptyStr(fGetValorConfiguracao('SECKNK'));
    if Not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_ALPKNK, a configuração CFG_SECKNK deve estar preenchida!', ['&Ok']);
      Exit;
    end;

    Result := not fEmptyStr(fGetValorConfiguracao('CNDBOL'));
    if Not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_ALPKNK, a configuração CFG_CNDBOL deve estar preenchida!', ['&Ok']);
      Exit;
    end;

    Result := not fEmptyStr(fGetValorConfiguracao('TOKKNK'));
    if not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_ALPKNK, a configuração CFG_TOKKNK deve estar preenchida!', ['&Ok']);
      Exit;
    end;
  end;

end;

class function TValidarConfiguracoes.fValidaUTLSLF: Boolean;
begin
  Result := True;

  If (fFindCfg('CFG_UTLSLF') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
     (fFindCfg('CFG_UTIWMS') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
  Begin
    pMensagemOk('Para utilizar a configuração [CFG_UTLSLF] é preciso desabilitar a configuração [CFG_UTIWMS]!');
    Result := False;
  End;
end;



class function TValidarConfiguracoes.fValidaIntegracaoDataFrete: Boolean;
begin
  pInformacao('Aguarde, validando configuração DataFrete!');

  Result := fGetValorConfiguracao('DTFUSA') = 'N';

  if not Result then
  Begin
    Result := not fEmptyStr(fGetValorConfiguracao('DTFCOT'));
    if not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_DTFUSA, a configuração CFG_DTFCOT deve estar preenchida!', ['&Ok']);
      Exit;
    end;

    Result := not fEmptyStr(fGetValorConfiguracao('DTFTOC'));
    if Not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_DTFUSA, a configuração CFG_DTFTOC deve estar preenchida!', ['&Ok']);
      Exit;
    end;

    Result := not fEmptyStr(fGetValorConfiguracao('DTFSER'));
    if not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_DTFUSA, a configuração CFG_DTFSER deve estar preenchida!', ['&Ok']);
      Exit;
    end;

    Result := not fEmptyStr(fGetValorConfiguracao('DTFTOS'));
    if Not Result then
    begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_DTFUSA, a configuração CFG_DTFTOS deve estar preenchida!', ['&Ok']);
      Exit;
    end;
  end;
end;

class function TValidarConfiguracoes.fValidaIntegracaoDeSistemaGS1_CNPCadastroNacionalDeProdutos: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de Integração de Sistemas - GS1 / CNP - Cadastro Nacional de Produtos!');

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_GS1CNP')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') And
       ((fFindCfg('CFG_GCURLA')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '') Or
        (fFindCfg('CFG_GCUSUA')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '') Or
        (fFindCfg('CFG_GCSENA')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '') Or
        (fFindCfg('CFG_GCSEWE')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '') Or
        (fFindCfg('CFG_GCUSWE')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '') Or
        (fFindCfg('CFG_GCCEMP')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Para utilizar a Configuração CFG_GS1CNP = Sim, as configurações ' + #13 +
                            '[CFG_GCURLA], [CFG_GCUSUA], [CFG_GCSENA], [CFG_GCSEWE], [CFG_GCUSWE] e [CFG_GCCEMP] ' + #13 +
                            'devem estar preenchidas.', ['&Ok']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaLinhasServico: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de linhas de serviço!');

  With cdsCfgSis Do Begin
    If (fFindCfg('CFG_LINSER')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger > 30) Then Begin
      fMensagem('ATENÇÃO!', 'O número de linhas de serviço máximo permitido é 30!', ['&Ok']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaLMENDV: Boolean;
begin
  Result := True;

  if (fGetValorConfiguracao('LMENDV') = 'S') And (fGetValorConfiguracao('SGLTVL') = 'S') then
  begin
    pMensagemOk('Atenção! Para utilizar a configuração "CFG_LMENDV" é preciso desabilitar a configuração "CFG_SGLTVL" para não gerar conflitos no faturamento na carga de lote sugestão para venda.');
    Result := False;
  end;
end;

class function TValidarConfiguracoes.fValidaLOCDEC: Boolean;
begin
  Result := True;

  If (fFindCfg('CFG_LOCDEC')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger > 4) Then Begin
    fMensagem('ATENÇÃO!', 'O número de casas decimais máximo é de 4 !', ['&Ok']);
    Result := False;
  End;

end;

class function TValidarConfiguracoes.fValidaABADEP: Boolean;
begin
  Result := True;

  With cdsCfgSis Do Begin
    If (fFindCfg('CFG_ABADEP')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      If (fFindCfg('CFG_EMPFAT')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a [CFG_ABADEP], a [CFG_EMPFAT] também precisa estar habilitada. Verifique!', ['&Ok']);
        Result := False;
      End
      Else If (fFindCfg('CFG_ENT_CD')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a [CFG_ABADEP], a [CFG_ENT_CD] também precisa estar habilitada. Verifique!', ['&Ok']);
        Result := False;
      End
      Else If (fFindCfg('CFG_EXOULJ')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a [CFG_ABADEP], a [CFG_EXOULJ] precisa estar desabilitada. Verifique!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaAjusteCartoes: Boolean;
begin
   If Assigned(procCfgRepositorioCartoesValidar) Then
  Begin
    procCfgRepositorioCartoesValidar(Self.cdsCfgSis, blnAdicionarConfigDuranteValidacao, Result);
    Exit;
  End;

  Result := True;
end;

class function TValidarConfiguracoes.ValidaTransferenciaDeCartoes: Boolean;
  Var
    LContador,
    LMaximo: Integer;
begin
  LMaximo := 2;
  fFindCfg('CFG_CTPOBE');
  If cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S' Then
    LMaximo := 3;

  //PagSeguro
  LContador := 0;

  fFindCfg('CFG_PAGTRF');
  If Not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
    Inc(LContador);

  fFindCfg('CFG_PAGCTF');
  If Not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
    Inc(LContador);

  fFindCfg('CFG_PAGETF');
  If Not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
    Inc(LContador);

  Result := LContador = 0;
  If Not Result Then
    Result := LContador >= LMaximo;

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'As configurações da PagSeguro CFG_PAGTRF, CFG_PAGCTF' +
                         IIF(LMaximo = 3, ', CFG_PAGETF ', ' ') +
                         'devem estar todas preenchidas ou todas em branco.' , ['&Ok']);

    Exit;
  End;

  //Mercado Livre
  LContador := 0;

  fFindCfg('CFG_MERTRF');
  If Not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
    Inc(LContador);

  fFindCfg('CFG_MERCTF');
  If Not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
    Inc(LContador);

  fFindCfg('CFG_MERETF');
  If Not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
    Inc(LContador);

  Result := LContador = 0;
  If Not Result Then
    Result := LContador >= LMaximo;

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'As configurações do Mercado Livre CFG_MERTRF, CFG_MERCTF' +
                         IIF(LMaximo = 3, ', CFG_MERETF ', ' ') +
                         'devem estar todas preenchidas ou todas em branco.' , ['&Ok']);

    Exit;
  End;

  //Yapay
  LContador := 0;

  fFindCfg('CFG_YAPTRF');
  If Not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
    Inc(LContador);

  fFindCfg('CFG_YAPCTF');
  If Not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
    Inc(LContador);

  fFindCfg('CFG_YAPETF');
  If Not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
    Inc(LContador);

  Result := LContador = 0;
  If Not Result Then
    Result := LContador >= LMaximo;

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'As configurações da Yapay CFG_YAPTRF, CFG_YAPCTF' +
                         IIF(LMaximo = 3, ', CFG_YAPETF ', ' ') +
                         'devem estar todas preenchidas ou todas em branco.' , ['&Ok']);

    Exit;
  End;
end;

class function TValidarConfiguracoes.fValidaConsertoEquipamentos: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de conserto de equipamentos!');

  If ((fFindCfg('CFG_EQFLXP')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S'))  And
     ((fFindCfg('CFG_EXISTA')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N'))  Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração "CFG_EQFLXP" a configurações "CFG_EXISTA" precisa estar igual a SIM!', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaCNPJAutDownNFE: Boolean;
  function asString(strCampo: String): String;
  begin
    Result := cdsCfgSis.FieldByName(strCampo).AsString;
  end;
begin
  pInformacao('Aguarde, validando configuração de autorização de download de XML da NF-e!');

  With cdsCfgSis Do
  Begin
    Result := Not (
                    (fFindCfg('CFG_AUTDOW')) And
                    (asString('SIS_VALCFG') = 'S') And
                    (fFindCfg('CFG_AUTCGC')) And
                    (fEmptyStr(asString('SIS_VALCFG')))
                  );

    If Not Result Then
      fMensagem('ATENÇÃO!', 'Favor configurar o CNPJ autorizado a baixar o XML das Notas Fiscais Eletrônicas (CFG_AUTCGC).', ['&Ok']);
  End;
end;

class function TValidarConfiguracoes.fValidaCondicaoPagamentoPorFaixa: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de condições de pagamento por faixa!');

  If (fFindCfg('CFG_CNDFAI') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
  Begin
    If (fFindCfg('CFG_CNDVEN') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> 'I')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Para utilizar a configuração CFG_CNDFAI = Sim, a configuração '+
                'CFG_CNDVEN deve estar configurada como Início', ['&Ok']);
      Result := False;
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaCONEFE: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_CONEFE!');

  if (fFindCfg('CFG_CONEFE')) And
     (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') then
  begin
    if fUsaRotinaWMS then
    begin
      fMensagem('ATENÇÃO!', 'Para utilizar a Configuração CFG_CONEFE = Sim, deve ser desabilitado o uso de WMS desligando a configuração [CFG_UTIWMS]', ['&Ok']);
      Result := False;
    end;
  end;
end;

class function TValidarConfiguracoes.fValidaConfAutocenter: Boolean;
begin

  Result := True;
  pInformacao('Aguarde, validando configuração de cadastro de veículos!');

  With cdsCfgSis Do
  begin

    {Rotinas de Centro Automotivo}
    If fFindCfg('CFG_AUTCEN') Then
    begin

      if (FieldByName('SIS_VALCFG').AsString = 'S') then
      begin

        {Quando autocenter habilitado se torna obrigatório
         habilitar o cadastro de veículos}
        If fFindCfg('CFG_CLIVEI') Then
        begin

          if (FieldByName('SIS_VALCFG').AsString <> 'S') then
          begin
            Result := FALSE;
            fMensagem('Atenção!','Quando o parâmetro "CFG_AUTCEN" estiver habilitado, se torna obrigatório habilitar o parâmetro "CFG_CLIVEI"!.',['&Ok']);
          end;

        end;

      end;

    end;

  end;

end;

class function TValidarConfiguracoes.fValidaConfComanda: Boolean;
var
  intIni, intFin : Integer;
begin

  Result := True;

  {Valida faixa de comandas!}
  With cdsCfgSis Do
  Begin

    If fFindCfg('CFG_COMAND') And (FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin

      intIni := 0;
      intFin := 0;

      If fFindCfg('CFG_COMINI') Then
        intIni := FieldByName('SIS_VALCFG').AsInteger;

      If fFindCfg('CFG_COMFIN') Then
        intFin := FieldByName('SIS_VALCFG').AsInteger;

      If (intIni = 0) Or (intFin = 0) Then
      Begin
        pMensagemOk('As configurações "CFG_COMINI" e "CFG_COMFIN" devem ser maior que 0 "Zero"!');
        Result := False;
      End;

      If (intIni > intFin) Then
      Begin
        pMensagemOk('A configuração "CFG_COMINI" não pode conter um valor maior que "CFG_COMFIN"!');
        Result := False;
      End;

    End;

  End;

end;

class function TValidarConfiguracoes.fValidaConfigFuncionarios: Boolean;
begin
  pInformacao('Aguarde, validando configuração de Funcionários!');

  Result := fGetValorConfiguracao('FUNCPG') = 'A'; //analítico

  If Not Result Then //sintético
  Begin
    Result := Not fEmptyStr(fGetValorConfiguracao('FUNFOR'));
    If Not Result Then
    Begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_FUNCPG na opção "Sintético", a configuração CFG_FUNFOR deve estar preenchida!', ['&Ok']);
      Exit;
    End;

    Result := Not fEmptyStr(fGetValorConfiguracao('FUNCTA'));
    If Not Result Then
    Begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_FUNCPG na opção "Sintético", a configuração CFG_FUNCTA deve estar preenchida!', ['&Ok']);
      Exit;
    End;

    Result := Not fEmptyStr(fGetValorConfiguracao('FUNPOR'));
    If Not Result Then
    Begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_FUNCPG na opção "Sintético", a configuração CFG_FUNPOR deve estar preenchida!', ['&Ok']);
      Exit;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaConfiguracaoCfg_CupNot: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de geração de cupom fiscal para entrega futura!');

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_CUPNOT')) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '2') Then
    Begin
      If (fFindCfg('CFG_USNFCE')) And
         (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a Configuração CFG_CUPNOT na opção cupom + cupom, a configuração CFG_USNFCE' + #13 +
                              'deve ser alterada para "NÃO".', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;



class function TValidarConfiguracoes.fValidaCFG_MARMOR: Boolean;
var strMensagem: String;
begin
  Result := True;
  strMensagem := '';
   If (fFindCfg('CFG_MARMOR')) And  (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
   Begin
     If ((fFindCfg('CFG_ENTEND')) And  (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
        strMensagem := 'Não é permitido usar rotina de compra e venda de mármore e granito com endereçamento (CFG_ENTEND).'
     Else If ((fFindCfg('CFG_UTIWMS')) And  (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
        strMensagem := 'Não é permitido usar rotina de compra e venda de mármore e granito com WMS (CFG_UTIWMS).'
     Else If ((fFindCfg('CFG_USACON')) And  (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
        strMensagem := 'Não é permitido usar rotina de compra e venda de mármore e granito com conferência (CFG_USACON).';
   End;
   If strMensagem <> '' Then
   Begin
     Result := False;
     fMensagem('ATENÇÃO!', strMensagem, ['&Ok']);
   End;
End;

class function TValidarConfiguracoes.fValidaConfiguracaoNotaComplementarCLANCO: Boolean;
Var
  strCfgErro: String;
  strCfgValor : String;
begin
  Result := True;
  strCfgErro := 'O valor da configuração "CFG_CLANCO" não pode ser vazia, ' +
                'informe ao menos as classificações padrão (1603 e 2603).';

  pInformacao('Aguarde, validando configuração para gravar ' +
              'Classificação fiscal para Nota de Complemento - Restituição de ICMS ST/Estoque!');
  if (fFindCfg('CFG_CLANCO')) then
  begin
    strCfgValor := fGetValorConfiguracao('CLANCO');
    Result := not fEmptyStr(strCfgValor);
    If Not Result Then
      fMensagem('ATENÇÃO!', strCfgErro, ['&Ok']);
  end;

end;

class function TValidarConfiguracoes.fValidaConfiguracaoNovaTelaFechamentoOrcamentoPedido(): Boolean;
  Var
    strCfgErro: String;
begin
  Result := True;
  strCfgErro := '';

  pInformacao('Aguarde, validando configuração para utilizar nova tela de fechamento de Orçamento/Pedido!');

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_NVORPD')) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      strCfgErro := 'A configuração [CFG_NVORPD] "' + cdsCfgSis.FieldByName('SIS_DESCRI').AsString +
        '" esta configurada como "SIM". Para utilizar esta rotina ' +
        'é necessário também alterar a configuração ';

      If (fFindCfg('CFG_BTDISE')) And
         (FieldByName('SIS_VALCFG').AsString = 'N') Then
      Begin
        Result := False;
        strCfgErro := strCfgErro + ' "CFG_BTDISE - ' + FieldByName('SIS_DESCRI').AsString + '" para "SIM" !';
      End;

      If Not Result Then
        pMensagemSonora(strCfgErro, False, 16);
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaConfiguracaoGravarContasPagarDifalDestino(strCfgPai: String): Boolean;
  Var
    strCfgErro: String;
begin
  Result := True;
  strCfgErro := '';

  pInformacao('Aguarde, validando configuração para gravar contas a pagar DIFAL!');

  With cdsCfgSis Do
  Begin
    If (fFindCfg(strCfgPai)) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      strCfgErro := 'A configuração [' + strCfgPai + '] "' + cdsCfgSis.FieldByName('SIS_DESCRI').AsString +
        '" esta configurada como "SIM". Para utilizar esta rotina ' +
        'é necessário também alterar a seguinte configuração: ' + #13#10 + #13#10;

      If (fFindCfg('CFG_DIFFOR')) And
         (fEmptyStr(fRetNomFornecedor(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) Then
      Begin
        Result := False;
        strCfgErro := strCfgErro + ' -> [CFG_DIFFOR] "' + cdsCfgSis.FieldByName('SIS_DESCRI').AsString + '".' + #13#10;
      End
      Else If (fFindCfg('CFG_DIFCTA')) And
              (fEmptyStr(fRetNomeConta(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) Then
      Begin
        Result := False;
        strCfgErro := strCfgErro + ' -> [CFG_DIFCTA] "' + cdsCfgSis.FieldByName('SIS_DESCRI').AsString + '".' + #13#10;
      End;

     Result := (Result) Or (((fFindCfg('CFG_PGMKEY')) And
               (Not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) And
               ((fFindCfg('CFG_PGMPOR')) And
               (Not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) And
               ((fFindCfg('CFG_PGMCTA')) And
               (Not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) And
               ((fFindCfg('CFG_PGMFOR')) And
               (Not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))));

     If Not Result Then
        pMensagemSonora(strCfgErro, False, 16);
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaConfiguracaoJatLog: Boolean;
begin
  Result := True;

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_USAJAD') And (FieldByName('SIS_VALCFG').AsString = 'S')) And
       ((fFindCfg('CFG_TOKJaD') And (fEmptyStr(FieldByName('SIS_VALCFG').AsString))) Or
       (fFindCfg('CFG_URLJAD') And (fEmptyStr(FieldByName('SIS_VALCFG').AsString))) Or
       (fFindCfg('CFG_CUOJAD') And (fEmptyStr(FieldByName('SIS_VALCFG').AsString))) Or
       (fFindCfg('CFG_UCAJAD') And (fEmptyStr(FieldByName('SIS_VALCFG').AsString)))) Then
    Begin
      pMensagemOk('Ao habilitar a "'+'CFG_USAJAD-'+fRetNomCfg('USAJAD') +'", a "CFG_TOKJAD-'+
                  fRetNomCfg('TOKJAD') +'" e a "CFG_URLJAD-'+fRetNomCfg('URLJAD') +'" também devem ser habilitadas!');
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaCfgVerDireitosDeAcessoNaLiberacaoPedidos: Boolean;
  Var
    strCFG_VPALPD: String;
begin

  Result := True;

  With cdsCfgSis Do
  begin

    {Rotinas de Centro Automotivo}
    If fFindCfg('CFG_VPALPD') Then
    begin
      strCFG_VPALPD := FieldByName('SIS_DESCRI').AsString;

      pInformacao('Aguarde, validando configuração "CFG_VPALPD - ' + strCFG_VPALPD + '" !');

      If (FieldByName('SIS_VALCFG').AsString <> 'S') then
        Exit;

      If fFindCfg('CFG_LIBPED') And (FieldByName('SIS_VALCFG').AsString <> 'S') then
      begin
        Result := FALSE;
        fMensagem('Atenção!','Para utilizar a configuração "CFG_VPALPD - ' + strCFG_VPALPD + '" ' +
          'você também deve ativar a configuração "CFG_LIBPED - ' + FieldByName('SIS_DESCRI').AsString + '" !',['&Ok']);
        Exit;
      End;

      If fFindCfg('CFG_HABREM') And (FieldByName('SIS_VALCFG').AsString <> 'S') then
      begin
        Result := FALSE;
        fMensagem('Atenção!','Para utilizar a configuração "CFG_VPALPD - ' + strCFG_VPALPD + '" ' +
          'você também deve ativar a configuração "CFG_HABREM - ' + FieldByName('SIS_DESCRI').AsString + '" !',['&Ok']);
        Exit;
      End;

      If fFindCfg('CFG_TRAREM') And (FieldByName('SIS_VALCFG').AsString <> '2') then
      begin
        Result := FALSE;
        fMensagem('Atenção!','Para utilizar a configuração "CFG_VPALPD - ' + strCFG_VPALPD + '" ' +
          'você deve alterar a configuração "CFG_TRAREM - ' + FieldByName('SIS_DESCRI').AsString + '" para ' +
          '"Coletiva, na Finalização da venda" !',['&Ok']);
        Exit;
      End;

    end;

  end;

end;

class function TValidarConfiguracoes.fValidaCFG_CRDCON: boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração CFG_CRDCON!');

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_CRDCON')) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '1') Then
    Begin
      If (fFindCfg('CFG_RPCTRD')) And
         (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar conta reduzida em automático sequencial ( CFG_CRDCON = 1 ), a configuração CFG_RPCTRD deve ser desligada.', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaCFG_FREDES: boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração CFG_FREDES!');

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_FREDES')) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      If (fFindCfg('CFG_FRENFC')) And
         (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para permitir destaque de frete na NFCe ( CFG_FREDES = S ), a configuração CFG_FRENFC deve ser desligada.', ['&Ok']);
        Result := False;
      End
      else
      If (fFindCfg('CFG_FR2NFC')) And
         (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para permitir destaque de frete na NFCe ( CFG_FREDES = S ), a configuração CFG_FR2NFC deve ser desligada.', ['&Ok']);
        Result := False;
      End
      else
      If (fFindCfg('CFG_FRECUP')) And
         (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para permitir destaque de frete na NFCe ( CFG_FREDES = S ), a configuração CFG_FRECUP deve ser desligada.', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaCfopSaidaTagDETEXPORT: Boolean;
var
  strCfop: string;
  intCfop: integer;
begin
  Result := False;
  if fFindCfg('CFG_CLASET') Then
  begin
    strCfop := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

    while Length(strCfop) >= 4 do
    begin
      intCfop := StrToIntDef(Copy(strCfop, 1 ,4), 0);
      if intCfop <= 7000 then
      begin
        fMensagem('ATENÇÃO!', 'CFOP de saída inválida [CFG_CLASET], favor verificar.', ['&Ok']);
        Exit;
      end;
      Delete(strCfop, 1, 4);
    end;

    if not fEmptyStr(strCfop) then
    begin
      fMensagem('ATENÇÃO!', 'CFOP de saída inválida [CFG_CLASET], favor verificar', ['&Ok']);
      Exit;
    end;
    Result := True;
  end;
end;

class function TValidarConfiguracoes.fValidaClaGae: Boolean;
const
  MSG: String = 'CFOP definida como de envio para fornecedor [CFG_CLAGAE] não pode constar na classificação de venda [CFG_CLAVEN]. Favor revisar a(s) CFOP(s): %s.';
var
  strCfopClaGae: string;
  strCfopClaVen: string;
  strCfop: string;
  lListaCFOPInvalida: TStringList;
  lstrMsg: String;
  intLimite: Integer;
begin
  Result := False;
  lListaCFOPInvalida := TStringList.Create;
  lListaCFOPInvalida.Clear;
  Try
    if fFindCfg('CFG_CLAVEN') Then
      strCfopClaVen := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

    if fFindCfg('CFG_CLAGAE') Then
    begin
      strCfopClaGae := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;
      intLimite := 5;
      while (Length(strCfopClaGae) <> 0) And (intLimite > 0) do
      begin
        strCfop := Copy(strCfopClaGae, 1 ,4);

        if pos(strCfop, strCfopClaVen) > 0 then
        begin
          Dec(intLimite);
          lListaCFOPInvalida.Add(strCfop);
        end;
        Delete(strCfopClaGae, 1, 4);
      end;
      Result := lListaCFOPInvalida.Count = 0;
      if Not Result then
      begin
        lstrMsg := Format(MSG,[lListaCFOPInvalida.CommaText]);
        fMensagem('ATENÇÃO!', lstrMsg, ['&Ok']);
      end;
    end;
  Finally
    FreeAndNil(lListaCFOPInvalida);
  End;
end;

class function TValidarConfiguracoes.fValidaClassificacoesFiscaisDevolucaoSimbolicaConsignacao: Boolean;
  var
    LstrValorConfiguracao   : String;
    LIntPosicao             : Integer;
    LcdsDevolucaoSimbolica  : TUniClientDataSet;
    LcdsDevolucaoDefinitiva : TUniClientDataSet;
begin
  Result := True;

  LcdsDevolucaoSimbolica  := TUniClientDataSet.Create(nil);
  LcdsDevolucaoDefinitiva := TUniClientDataSet.Create(nil);

  Try
    LcdsDevolucaoSimbolica.FieldDefs.Add('CLAFIS', ftString,  4, False);
    LcdsDevolucaoSimbolica.CreateDataSet;
    LcdsDevolucaoSimbolica.Open;

    LcdsDevolucaoDefinitiva.FieldDefs.Add('CLAFIS', ftString,  4, False);
    LcdsDevolucaoDefinitiva.CreateDataSet;
    LcdsDevolucaoDefinitiva.Open;

    if fFindCfg('CFG_CLADSC') Then
    begin
      LstrValorConfiguracao := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

      LIntPosicao := 1;
      While LIntPosicao < Length(LstrValorConfiguracao) Do
      Begin
        LcdsDevolucaoSimbolica.Append;
        LcdsDevolucaoSimbolica.FieldByName('CLAFIS').AsString := Copy(LstrValorConfiguracao, LIntPosicao+1, 3);
        LcdsDevolucaoSimbolica.Post;

        Inc(LIntPosicao, 4);
      End;
    end;

    if fFindCfg('CFG_RETCON') Then
    begin
      LstrValorConfiguracao := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

      LIntPosicao := 1;
      While LIntPosicao < Length(LstrValorConfiguracao) Do
      Begin
        LcdsDevolucaoDefinitiva.Append;
        LcdsDevolucaoDefinitiva.FieldByName('CLAFIS').AsString := Copy(LstrValorConfiguracao, LIntPosicao+1, 3);
        LcdsDevolucaoDefinitiva.Post;

        Inc(LIntPosicao, 4);
      End;
    end;

    LcdsDevolucaoSimbolica.First;
    while not LcdsDevolucaoSimbolica.Eof do
    Begin
      if LcdsDevolucaoDefinitiva.Locate('CLAFIS', LcdsDevolucaoSimbolica.FieldByName('CLAFIS').AsString, []) then
      Begin
        fMensagem('ATENÇÃO!', 'Classificações fiscais de devolução simbólica de consignação (CFG_CLADSC) em conflito com as classificações '+
        'de retorno de consignação (CFG_RETCON) nos finais "'+LcdsDevolucaoSimbolica.FieldByName('CLAFIS').AsString+'". É necessário revisar.', ['&Ok']);
        Exit(False);
      End;

      LcdsDevolucaoSimbolica.Next;
    End;

  Finally
    FreeAndNil(LcdsDevolucaoSimbolica);
    FreeAndNil(LcdsDevolucaoDefinitiva);
  End;
end;

class function TValidarConfiguracoes.fValidaConfiguracaoUsaPreRomaneio: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de utilização de pré romaneio!');

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_USPRRO')) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      If (fFindCfg('CFG_OPCROM')) And
         (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> '1') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar Pré Romaneio, a configuração CFG_OPCROM' + #13 +
                              'deve ser alterada para "PEDIDO DE VENDA".', ['&Ok']);
        Result := False;
      End;
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaConfiguracaoUtilizaRT: Boolean;
  Var
    strCfgErro: String;
begin
  Result := True;
  strCfgErro := '';

  pInformacao('Aguarde, validando configuração para utilizar cálculo do RT!');

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_UTI_RT')) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      strCfgErro := 'A configuração [CFG_UTI_RT] "' + cdsCfgSis.FieldByName('SIS_DESCRI').AsString +
        '" esta configurada como "SIM". Para utilizar esta rotina ' +
        'é necessário também alterar a seguinte configuração: ' + #13#10 + #13#10;

      If (fFindCfg('CFG_ORIPRO')) And
         (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> '4') Then
      Begin
        Result := False;
        strCfgErro := strCfgErro + ' -> [CFG_ORIPRO] "' + cdsCfgSis.FieldByName('SIS_DESCRI').AsString +
          '" deve ser alterada para "CADASTRO DE CLIENTES".' + #13#10;
      End
      Else If (fFindCfg('CFG_TCOPRO')) And
              (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> '1') And
              (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> '2') Then
      Begin
        Result := False;
        strCfgErro := strCfgErro + ' -> [CFG_TCOPRO] "' + cdsCfgSis.FieldByName('SIS_DESCRI').AsString +
          '" deve ser alterada para "PELO CONTA CORRENTE DO PROFISSIONAL" ou "PELO CONTAS A RECEBER".' + #13#10;
      End;
{     Else If (fFindCfg('CFG_TIPCOM')) And
              (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> 'G') Then
      Begin
        Result := False;
        strCfgErro := strCfgErro + ' -> [CFG_TIPCOM] "' + cdsCfgSis.FieldByName('SIS_DESCRI').AsString +
          '" deve ser alterada para "GERAL".' + #13#10;
      End;}

      If Not Result Then
        pMensagemSonora(strCfgErro, False, 16);
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaConfItensPorLocalSeparacao: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando realizar a conferência dos Itens por local de separação');

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_BXLCSP')) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      If (fFindCfg('CFG_BAISEP')) And
         (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar realizar a conferência dos Itens por local de separação - CFG_BXLCSP' + #13 +
                              'a Configuração Utilizar módulo de impressão e baixa da separação' + #13 +
                              '(Expedição antes do Faturamento) - CFG_BAISEP, tem que ser igual a "Sim".', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaControleCobrancaPaleteConfiguradoCorretamente: Boolean;
  function asString(strCampo: String): String;
  begin
    Result := cdsCfgSis.FieldByName(strCampo).AsString;
  end;
  var
    blnCLIFOMarcado, blnUSASERMarcado: Boolean;
begin
  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_CCDPRM')) And (asString('SIS_VALCFG') <> 'S') Then
      Exit(True);

    If (asString('SIS_VALCFG') = '') Then
      Exit(True);

    pInformacao('Aguarde, validando configuração "Utilizar controle de cobrança por descarregamento de pallets no recebimento de mercadorias?"!');
    blnCLIFOMarcado := True;
    If (fFindCfg('CFG_CLIFOR')) Then
      blnCLIFOMarcado := (asString('SIS_VALCFG') = 'S');
    blnUSASERMarcado := True;
    If (fFindCfg('CFG_USASER')) Then
      blnUSASERMarcado := (asString('SIS_VALCFG') = 'S');

    Result := ((blnCLIFOMarcado) And (blnUSASERMarcado));

    If not Result Then
      fMensagem('ATENÇÃO!', 'Quanto a configuração "Utilizar controle de cobrança por descarregamento de pallets no recebimento de mercadorias?" ' +
        'Para ativar as configurações CFG_CLIFOR e CFG_USASER devem estar igual a Sim e a configuração CFG_CSDPRM deve estar preenchinda com o item de serviço.', ['&Ok']);
  End;
end;

class function TValidarConfiguracoes.fValidaCORDCL: Boolean;
begin
  Result := True;

  If fGetValorConfiguracao('CORDCL') <> 'S' Then
    Exit;

  If fStrToFloat(fGetValorConfiguracao('CORVMI')) <= 0 Then
  Begin
    pMensagemOk('Se estiver configurado para enviar o valor declarado na Pré Lista de Postagem (CFG_CORDCL), '+
                'o valor da configuração CFG_CORVMI precisa ser maior que zero!');
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaEditarDescontoEspecial: Boolean;
  function asString(strCampo: String): String;
  begin
    Result := cdsCfgSis.FieldByName(strCampo).AsString;
  end;
begin
  pInformacao('Aguarde, validando configuração "Permitir editar desconto especial (em valor) no faturamento ?"!');

  With cdsCfgSis Do
  Begin
    Result := Not (
                    (fFindCfg('CFG_EXIDES')) And
                    (asString('SIS_VALCFG') = 'N') And
                    (fFindCfg('CFG_DESVAL')) And
                    (asString('SIS_VALCFG') = 'S')
                  );

    If Not Result Then
      fMensagem('ATENÇÃO!', 'Quanto a configuração "Permitir editar desconto especial (em valor) no faturamento ?" ' +
        'estiver configurada para "Não" a configuração "Quando informar o desconto em percentual na telinha do desconto especial, converte-lo em valor e carrega-lo no campo de desconto especial em valor ? "' +
        'não pode estar configurada para "Sim" ', ['&Ok']);
  End;
end;

class function TValidarConfiguracoes.fValidaEFXTPF: Boolean;
var
  intFXFIVD,
  intFXFIAM,
  intFXFIVM: Integer;
begin
  Result := False;

  intFXFIVD := 0;
  intFXFIAM := 0;
  intFXFIVM := 0;

  pInformacao('Aguarde, validando configuração "Exibir no fluxo o controle de tempo restante e status para a finalização da OS?"!');

  if (fFindCfg('CFG_EFXTPF')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') then
  begin
    if (fFindCfg('CFG_FXFIVD')) Then
      intFXFIVD := cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger;

    if (fFindCfg('CFG_FXFIAM')) Then
      intFXFIAM := cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger;

    if (fFindCfg('CFG_FXFIVM')) Then
      intFXFIVM := cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger;

    if (intFXFIVD <= 0) or (intFXFIAM <= 0) or (intFXFIVM <= 0) then
    begin
      fMensagem('ATENÇÃO!', 'Quando a configuração "Exibir no fluxo o controle de tempo restante e status para a finalização da OS?" '
        + 'estiver configurada para "Sim" é necessário informar a quantidade de dias nas configurações CFG_FXFIVD, CFG_FXFIAM e CFG_FXFIVM.', ['&Ok']);
      Exit;
    end;

    if (intFXFIAM <= intFXFIVD) then
    begin
      fMensagem('ATENÇÃO!', 'O valor definido na configuração CFG_FXFIAM não pode ser menor ou igual ao valor definido na configuração CFG_FXFIVD.', ['&Ok']);
      Exit;
    end;

    if (intFXFIVM < intFXFIAM) then
    begin
      fMensagem('ATENÇÃO!', 'O valor definido na configuração CFG_FXFIVM não pode ser menor que o valor definido na configuração CFG_FXFIAM.', ['&Ok']);
      Exit;
    end;
  end;

  Result := True;
end;

class function TValidarConfiguracoes.fValidaEFXTPG: Boolean;
var
  intFXTPVD,
  intFXTPAM,
  intFXTPVM: Integer;
begin
  Result := False;

  intFXTPVD := 0;
  intFXTPAM := 0;
  intFXTPVM := 0;

  pInformacao('Aguarde, validando configuração "Exibir no fluxo o controle de tempo restante e status para garantia da OS?"!');

  if (fFindCfg('CFG_EFXTPG')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') then
  begin
    if (fFindCfg('CFG_FXTPVD')) Then
      intFXTPVD := cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger;

    if (fFindCfg('CFG_FXTPAM')) Then
      intFXTPAM := cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger;

    if (fFindCfg('CFG_FXTPVM')) Then
      intFXTPVM := cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger;

    if (intFXTPVD <= 0) or (intFXTPAM <= 0) or (intFXTPVM <= 0) then
    begin
      fMensagem('ATENÇÃO!', 'Quando a configuração "Exibir no fluxo o controle de tempo restante e status para garantia da OS?" '
        + 'estiver configurada para "Sim" é necessário informar a quantidade de dias nas configurações CFG_FXTPVD, CFG_FXTPAM e CFG_FXTPVM.', ['&Ok']);
      Exit;
    end;

    if (intFXTPAM <= intFXTPVD) then
    begin
      fMensagem('ATENÇÃO!', 'O valor definido na configuração CFG_FXTPAM não pode ser menor ou igual ao valor definido na configuração CFG_FXTPVD.', ['&Ok']);
      Exit;
    end;

    if (intFXTPVM <= intFXTPAM) then
    begin
      fMensagem('ATENÇÃO!', 'O valor definido na configuração CFG_FXTPVM não pode ser menor ou igual ao valor definido na configuração CFG_FXTPAM.', ['&Ok']);
      Exit;
    end;
  end;

  Result := True;
end;

class function TValidarConfiguracoes.fValidaEmpCarregamento: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de empresa de carregamento e entrega!');

  If (fFindCfg('CFG_EMPCAR') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
  Begin
    If (fFindCfg('CFG_EMPFAT') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Or
       (fFindCfg('CFG_EMPFVN') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Or
       (fFindCfg('CFG_SOLITE') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido utilizar definição de empresa responsável pelo carregamento e entrega '+
                            'do item (CFG_EMPCAR) juntamente com: [CFG_EMPFAT], [CFG_EMPFVN] ou [CFG_SOLITE].', ['&Ok']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaEMSRCS: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração CFG_EMSRCS!');

  With cdsCfgSis Do Begin
    If (fFindCfg('CFG_EMSRCS')) And (FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      If (fFindCfg('CFG_CONSIM')) And (FieldByName('SIS_VALCFG').AsString = 'N') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar CFG_EMSRCS = "S" a CFG_CONSIM deve diferente de "N"', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaENDAUT: boolean;
var
  strENDAUT: String;
  strUTIWMS: String;
  strUM1LFL: String;
  strLOTEND: String;
begin
  Result := True;

  strENDAUT := fGetValorConfiguracao('ENDAUT');
  strUTIWMS := fGetValorConfiguracao('UTIWMS');
  strUM1LFL := fGetValorConfiguracao('UM1LFL');
  strLOTEND := fGetValorConfiguracao('LOTEND');

  If (strENDAUT = 'S') And ((strUTIWMS <> 'N') or (strUM1LFL <> 'S') or (strLOTEND  <> '1')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração CFG_ENDAUT = Sim, o sistema deverá estar utilizando as configurações CFG_UTIWMS = Não, CFG_UM1LFL = Sim e CFG_LOTEND = 1', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaENDPRO: Boolean;
var
  strENDPRO: String;
  strUTIWMS: String;
  strTPLREC: String;
begin
  Result := True;

  strENDPRO := fGetValorConfiguracao('ENDPRO');
  strUTIWMS := fGetValorConfiguracao('UTIWMS');
  strTPLREC := fGetValorConfiguracao('TPLREC');

  If (strENDPRO = '2') And ((strUTIWMS <> 'S') or ((strTPLREC <> 'C') and (strTPLREC <> 'L'))) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração CFG_ENDPRO = 2, o sistema deverá estar utilizando as configurações CFG_UTIWMS = Sim, CFG_TPLREC = (C)LASSE OU (L)OCAL DE SEPARAÇÃO', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaENITCN: Boolean;
var
  strENITCN: String;
  strUTIWMS: String;
  strENDITE: String;
  strWMSPLA: String;
begin
  Result := True;

  strENITCN := fGetValorConfiguracao('ENITCN');
  strUTIWMS := fGetValorConfiguracao('UTIWMS');
  strENDITE := fGetValorConfiguracao('ENDITE');
  strWMSPLA := fGetValorConfiguracao('WMSPLA');

  If (strENITCN = 'S') And ((strUTIWMS <> 'S') or (strENDITE <> 'S') or (strWMSPLA <> 'R')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração CFG_ENITCN = Sim, o sistema deverá estar utilizando as configurações CFG_UTIWMS = Sim, CFG_ENDITE = Sim e CFG_WMSPLA = R', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaEspecieDocPerfilCondPagto: Boolean;
begin
  pInformacao('Aguarde, validando configuração de validação de documentos no perfil da condição de pagamento!');

  Result := fGetValorConfiguracao('VALDOC') <> 'S';

  If Not Result Then
  Begin
    Result := fGetValorConfiguracao('PFLCLI') = 'S';

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração "CFG_VALDOC" na opção "Sim", a configuração de perfil "CFG_PFLCLI" deve estar habilitada!', ['&Ok']);
      Exit;
    End;

  End;

end;

class function TValidarConfiguracoes.fValidaExpedirFaturarTodos: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração expedição e faturamento automático de todos os pedidos!');

  With cdsCfgSis Do
  Begin
    If ((fFindCfg('CFG_EXFTAU')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
    Begin

      If ((fFindCfg('CFG_UTIWMS')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitida a utilização das configurações [CFG_EXFTAU] e' + #13#10 + '[CFG_UTIWMS] em conjunto. Verifique!', ['&Ok']);
        Exit(False);
      End;

      If ((fFindCfg('CFG_VENVID')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitida a utilização das configurações [CFG_EXFTAU] e' + #13#10 + '[CFG_VENVID] em conjunto. Verifique!', ['&Ok']);
        Exit(False);
      End;

      If ((fFindCfg('CFG_VENMAD')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitida a utilização das configurações [CFG_EXFTAU] e' + #13#10 + '[CFG_VENMAD] em conjunto. Verifique!', ['&Ok']);
        Exit(False);
      End;

      If (fFindCfg('CFG_TIPEXP')) And (Pos(cdsCfgSis.FieldByName('SIS_VALCFG').AsString, '3_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_EXFTAU] a configuração [CFG_TIPEXP] deve '+
          'ser [3]Faturamento depois da expedição. Verifique!', ['&Ok']);
        Exit(False);
      End;

    End;
  End;

end;

class function TValidarConfiguracoes.fPermiteDesabilitarConfiguracaoCFG_HBFPRC: Boolean;
var
  qryDados : TUniQuery;
begin
  Result := True;

  With cdsCfgSis Do
  Begin
    If (Not fCfgSis('HBFPRC', varBoolean)) Or
       (fFindCfg('CFG_HBFPRC') And (FieldByName('SIS_VALCFG').AsString = 'S')) Then
      Exit;
  End;

  qryDados := fCriaQuery;
  Try
    qryDados.SQL. Text := 'SELECT * '
                        + '  FROM (SELECT '
                        + '               G.FGO_DTAENT '
                        + '             , G.AUTOINCREM '
                        + '             , G.FGO_NUMDOC '
                        + '             , G.FGO_ESPDOC '
                        + '             , G.FGO_CODEMP '
                        + '             , G.FGO_TIPOPE '
                        + '             , E.FGO_AUTRCO '
                        + '             , R.AUTOINCREM AS AUTINC_VINCULACAO '
                        + '             , R.FGO_NUMDOC AS NUMDOC_VINCULACAO '
                        + '             , R.FGO_ESPDOC AS ESPDOC_VINCULACAO '
                        + '             , R.FGO_CODEMP AS CODEMP_VINCULACAO '
                        + '             , R.FGO_CODCLI AS CODCLI_VINCULACAO '
                        + '             , IFNULL(G.FGO_MOTBAI,"") AS MOTIVO_BAIXA '
                        + '             , IFNULL(V.GER_NUMDOC,"") AS NUMDOC_FATURAMENTO '
                        + '             , IFNULL(V.GER_ESPDOC,"") AS ESPDOC_FATURAMENTO '
                        + '             , IFNULL(V.GER_CODEMP,"") AS CODEMP_FATURAMENTO '
                        + '             , IFNULL(R.FGO_NUMFAT,"") AS NUMDOC_REMESSA_FATURADA '
                        + '             , IFNULL(R.FGO_TIPFAT,"") AS ESPDOC_REMESSA_FATURADA '
                        + '             , IFNULL(R.FGO_EMPFAT,"") AS CODEMP_REMESSA_FATURADA '
                        + '             , IFNULL(N.GER_NUMDOC,"") AS NUMDOC_NOTGER '
                        + '             , IFNULL(N.GER_ESPDOC,"") AS ESPDOC_NOTGER '
                        + '             , IFNULL(N.GER_CODEMP,"") AS CODEMP_NOTGER '
                        + '             , IFNULL(T.GER_NUMDOC,"") AS NUMDOC_NOTGER_REMESSA '
                        + '             , IFNULL(T.GER_ESPDOC,"") AS ESPDOC_NOTGER_REMESSA '
                        + '             , IFNULL(T.GER_CODEMP,"") AS CODEMP_NOTGER_REMESSA '
                        + '          FROM FATGOR G '
                        + '         INNER JOIN EXTGOR X ON X.FGO_SEQFGO = G.AUTOINCREM '
                        + '         INNER JOIN EXTGOR E ON E.FGO_AUTRCO = G.AUTOINCREM '
                        + '         INNER JOIN FATGOR R ON R.AUTOINCREM = E.FGO_SEQFGO '
                        + '          LEFT JOIN MOVGER V ON V.GER_NUMDOC = G.FGO_NUMFAT '
                        + '                            AND V.GER_ESPDOC = G.FGO_TIPFAT '
                        + '                            AND V.GER_CODEMP = G.FGO_EMPFAT '
                        + '          LEFT JOIN NOTGER N ON N.GER_NUMDOC = V.GER_NUMFAT '
                        + '                            AND N.GER_ESPDOC = V.GER_TIPFAT '
                        + '                            AND N.GER_CODEMP = V.GER_EMPFAT '
                        + '          LEFT JOIN MOVGER O ON O.GER_NUMDOC = R.FGO_NUMFAT '
                        + '                            AND O.GER_ESPDOC = R.FGO_TIPFAT '
                        + '                            AND O.GER_CODEMP = R.FGO_EMPFAT '
                        + '          LEFT JOIN NOTGER T ON T.GER_NUMDOC = O.GER_NUMFAT '
                        + '                            AND T.GER_ESPDOC = O.GER_TIPFAT '
                        + '                            AND T.GER_CODEMP = O.GER_EMPFAT '
                        + '         WHERE G.FGO_TIPOPE = "C" '
                        + '           AND G.FGO_ESPDOC = "PD") AS DADOS '
                        + ' WHERE FGO_CODEMP = :CODEMP '
                        + '   AND ((NUMDOC_FATURAMENTO = "" '
                        + '    OR   (NUMDOC_FATURAMENTO = "FF" '
                        + '   AND    NUMDOC_NOTGER = "")) '
                        + '    OR  (NUMDOC_REMESSA_FATURADA = "" '
                        + '    OR   (NUMDOC_REMESSA_FATURADA = "FF" '
                        + '   AND    NUMDOC_NOTGER_REMESSA = ""))) '
                        + '   AND MOTIVO_BAIXA = "" ';

    qryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryDados.Open;

    Result := qryDados.IsEmpty;

    If Not Result Then
    Begin
      fMensagem('','Não é possível desativar essa configuração (CFG_HBFPRC), '
                  +'pois existe(m) documento(s) de Conta e Ordem e/ou Remessa '
                  +'Conta e Ordem que não foram totalmente faturados ou '
                  +'baixados como não entregue!',['&Ok']);
    End;
  Finally
    FreeAndNil(qryDados);
  End;
end;

class function TValidarConfiguracoes.fQtdDiasDtPrevisaoPDOk: Boolean;
begin
  pInformacao('Aguarde, validando configuração de sugestão de dias úteis para o pedido de venda!');

  With cdsCfgSis Do
  Begin
    If fFindCfg('CFG_DIASPD') And
       (FieldByName('SIS_VALCFG').AsInteger < 0) Then
    Begin
      fMensagem('','A quantidade de dias úteis deve ser maior ou igual a zero.',['&Ok']);
      Result := False;
    End
    Else
      Result := True;
  End;
end;

class function TValidarConfiguracoes.fQtdeBox: Boolean;
begin
  Result := True;

  With cdsCfgSis Do Begin
    If fFindCfg('CFG_QTDBOX') Then Begin
      If (FieldByName('SIS_VALCFG').AsInteger <= 0) Then Begin
        fMensagem('','A quantidade de Box de Entrega disponíveis deve ser maior que zero.',['&Ok']);
        Result := False;
      End Else If (FieldByName('SIS_VALCFG').AsInteger < fRetornarBoxSeparacaoMaximo()) Then Begin
        fMensagem('','Existem documentos alocados em um Box de Entrega de número maior que o informado. Verifique!',['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaAplicaDescConPag: Boolean;
begin

  Result := False;

  pInformacao('Aguarde, validando configuração de desconto da condição de pagamento nos produtos identificados!');

  With cdsCfgSis Do
  If fFindCfg('CFG_DESCND') Then
    If (FieldByName('SIS_VALCFG').AsString = 'S') And
       (  ( fFindCfg('CFG_EDIUNP') And (FieldByName('SIS_VALCFG').AsString <> 'N') ) Or
          ( fFindCfg('CFG_EDUNTB') And ( Pos('S',FieldByName('SIS_VALCFG').AsString) > 0) ) Or
          ( fFindCfg('CFG_UNIBRI') And (FieldByName('SIS_VALCFG').AsString <> 'N') ) Or
          ( fFindCfg('CFG_EDIDES') And (FieldByName('SIS_VALCFG').AsString <> 'N') ) ) Then
  Begin
    fMensagem('Atenção', 'Para utilização da configuração [CFG_DESCND], será necessário o ajuste das configurações [CFG_EDIUNP], [CFG_EDUNTB], [CFG_UNIBRI] e [CFG_EDIDES]. Verifique!', ['&Ok']);
  End
  Else
    Result := True;

end;

class function TValidarConfiguracoes.fValidaAppEntrega: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configurações do App Entrega!');

  If ((fFindCfg('CFG_MATDIS')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
  Begin
    If (fFindCfg('CFG_APEOBR')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Ao habilitar a [CFG_MATDIS] é necessário informar a [CFG_APEOBR]. Verifique!', ['&Ok']);
      Result := False;
      Exit;
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaLocSepArmzBaixaSep: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração baixa de separação!');

  With cdsCfgSis Do
  Begin
    If ((fFindCfg('CFG_BXAZSP')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
       ((fFindCfg('CFG_BXLCSP')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitida a utilização das configurações [CFG_BXAZSP] e' + #13#10 + '[CFG_BXLCSP] em conjunto. Verifique!', ['&Ok']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fSolicitacaoTransfReqCompra: Boolean;
begin

  Result := False;

  pInformacao('Aguarde, validando configuração de abastecimento de item sem estoque!');

  With cdsCfgSis Do
  If fFindCfg('CFG_SLTFRC') And
     (FieldByName('SIS_VALCFG').AsString = 'S') And
     (
       ( fFindCfg('CFG_SOLITE') And (FieldByName('SIS_VALCFG').AsString = 'N') ) Or
       ( fFindCfg('CFG_CONENT') And (FieldByName('SIS_VALCFG').AsString = 'N') ) Or
       ( fFindCfg('CFG_SLRQPV') And (FieldByName('SIS_VALCFG').AsString = 'N') ) Or
       ( fFindCfg('CFG_OPSOAB') And (FieldByName('SIS_VALCFG').AsString <> '1') ) Or
       ( fFindCfg('CFG_CEATMN') And (FieldByName('SIS_VALCFG').AsString <> '2') )
     ) Then
  Begin
    fMensagem('Atenção', 'Para utilização da configuração [CFG_SLTFRC], será necessário o ajuste das configurações [CFG_SOLITE], [CFG_CONENT], [CFG_SLRQPV], [CFG_OPSOAB] e [CFG_CEATMN]. Verifique!', ['&Ok']);
  End
  Else
    Result := True;

end;

class function TValidarConfiguracoes.fVerificaSeMudouOModoDeAcrescimoEDescontoNoCupom: Boolean;
begin
  pInformacao('Aguarde, validando configuração de modo de acréscimo e desconto no cupom fiscal!');

  Result := True;
  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_MDADCF')) And
       (fCfgSis('MDADCF', varString) = '1') And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '2') Then
    Begin
      pCriarFormularios(TfrmMemo, frmMemo);
      Try
        frmMemo.cxMemo.Lines.Add(fPadC('ATENÇÃO', 40));
        frmMemo.cxMemo.Lines.Add(fPadC('A configuração "Modo de acréscimo /', 40));
        frmMemo.cxMemo.Lines.Add(fPadC('desconto para acerto e desconto especial', 40));
        frmMemo.cxMemo.Lines.Add(fPadC('no cupom fiscal" foi alterada de "1-Por item"', 40));
        frmMemo.cxMemo.Lines.Add(fPadC('para "2-Total do cupom". Isso poderá acarretar', 40));
        frmMemo.cxMemo.Lines.Add(fPadC('divergências entre os totais do sistema e da', 40));
        frmMemo.cxMemo.Lines.Add(fPadC('redução Z.', 40));
        frmMemo.cxMemo.Lines.Add(fPadC('(Pressione ESC)', 40));
        frmMemo.ShowModal;
      Finally
        FreeAndNil(frmMemo);
      End;

      Result := fMensagem('', 'Confirma a alteração da configuração ' + #13#10 +
        '"Modo de acréscimo / desconto para acerto e desconto especial no cupom fiscal"?',
        ['&Sim', '&Não'], 2) = 1;

      If Not Result Then
      Begin
        Edit;
        cdsCfgSis.FieldByName('SIS_VALCFG').AsString := fCfgSis('MDADCF', varString);
        Post;
      End;

    End;
  End;
end;

class function TValidarConfiguracoes.fValidaTabelaDePrecoHubTABPRE: Boolean;
const
  SQL_TABPRE = ' SELECT SIS_VALCFG FROM HUBCIT_CFGSIS WHERE SIS_CODEMP = :CODEMP AND SIS_CODCFG = "CFG_TABPRE" ';
Var
  strTabPre: String;
  strTabPrc: String;
  strTabFat: String;
  intContador: Integer;
  qryCfgHub: TUniQuery;
begin
  Result := True;

  {## VALIDANDO SE CFG_TABPRE ESTÁ CONFIGURADA NA CFG_TABPRC ##}
  pInformacao('Aguarde, validando configuração de tabela de preço utilizada pelo Hub(CFG_TABPRE)!');

  fFindCfg('CFG_TABPRC');
  strTabPrc := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  qryCfgHub := fCriaQuery;
  try
    qryCfgHub.Close;
    qryCfgHub.SQL.Text := SQL_TABPRE;
    qryCfgHub.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCfgHub.Open;

    while not qryCfgHub.Eof do
    begin
      strTabPre := qryCfgHub.FieldByName('SIS_VALCFG').AsString;

      For intContador := 1 To Length(strTabPrc) Do
      Begin
        If intContador = strToInt(strTabPre) Then
        Begin
          Result := (Copy(strTabPrc, intContador, 1) = 'S');
          Break;
        End;
      End;

      if not Result then
        Break;

      qryCfgHub.Next;
    end;

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!','A tabela ( ' + strTabPre + ' ) utilizada para cálculo de preço de anúncios do hub(CFG_TABPRE), ' +
                           'não está configurada na CFG_TABPRC. ' + sLineBreak +
                           'Ative a tabela de preço na CFG_TABPRC ou desative o uso da tabela na CFG_TABPRE.', ['&Ok']);
      Exit;
    End;

    {## VALIDANDO SE CFG_TABPRE ESTÁ CONFIGURADA NA CFG_TABFAT ##}

    fFindCfg('CFG_TABFAT');
    strTabFat := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

    qryCfgHub.First;
    while not qryCfgHub.Eof do
    begin
      strTabPre := qryCfgHub.FieldByName('SIS_VALCFG').AsString;

      For intContador := 1 To Length(strTabFat) Do
      Begin
        If intContador = strToInt(strTabPre) Then
        Begin
          Result := (Copy(strTabFat, intContador, 1) = 'S');
          Break;
        End;
      End;

      if not Result then
        Break;

      qryCfgHub.Next;
    end;

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!','A tabela ( ' + strTabPre + ' ) utilizada para cálculo de preço de anúncios do hub(CFG_TABPRE), ' +
                           'não está configurada na CFG_TABFAT. ' + sLineBreak +
                           'Ative a tabela de preço na CFG_TABFAT ou desative o uso da tabela na CFG_TABPRE.', ['&Ok']);
      Exit;
    End;
  finally
    FreeAndNil(qryCfgHub);
  end;
end;

class function TValidarConfiguracoes.fValidaTabelaDePrecoHubTBPCLI: Boolean;
const
  SQL_TABPRE = ' SELECT SIS_VALCFG FROM HUBCIT_CFGSIS WHERE SIS_CODEMP = :CODEMP AND SIS_CODCFG = "CFG_TBPCLI" ';
Var
  strTbpCli: String;
  strTabPrc: String;
  strTabFat: String;
  intContador: Integer;
  qryCfgHub: TUniQuery;
begin
  Result := True;

  {## VALIDANDO SE CFG_TABPRE ESTÁ CONFIGURADA NA CFG_TABPRC ##}
  pInformacao('Aguarde, validando configuração de tabela de preço utilizada pelo Hub(CFG_TBPCLI)!');

  fFindCfg('CFG_TABPRC');
  strTabPrc := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  qryCfgHub := fCriaQuery;
  try
    qryCfgHub.Close;
    qryCfgHub.SQL.Text := SQL_TABPRE;
    qryCfgHub.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCfgHub.Open;

    while not qryCfgHub.Eof do
    begin
      strTbpCli := qryCfgHub.FieldByName('SIS_VALCFG').AsString;

      For intContador := 1 To Length(strTabPrc) Do
      Begin
        If intContador = strToInt(strTbpCli) Then
        Begin
          Result := (Copy(strTabPrc, intContador, 1) = 'S');
          Break;
        End;
      End;

      if not Result then
        Break;

      qryCfgHub.Next;
    end;

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!','A tabela ( ' + strTbpCli + ' ) utilizada para cálculo de preço do hub(CFG_TBPCLI), ' +
                           'não está configurada na CFG_TABPRC. ' + sLineBreak +
                           'Ative a tabela de preço na CFG_TABPRC ou desative o uso da tabela na CFG_TBPCLI.', ['&Ok']);
      Exit;
    End;

    {## VALIDANDO SE CFG_TABPRE ESTÁ CONFIGURADA NA CFG_TABFAT ##}

    fFindCfg('CFG_TABFAT');
    strTabFat := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

    qryCfgHub.First;
    while not qryCfgHub.Eof do
    begin
      strTbpCli := qryCfgHub.FieldByName('SIS_VALCFG').AsString;

      For intContador := 1 To Length(strTabFat) Do
      Begin
        If intContador = strToInt(strTbpCli) Then
        Begin
          Result := (Copy(strTabFat, intContador, 1) = 'S');
          Break;
        End;
      End;

      if not Result then
        Break;

      qryCfgHub.Next;
    end;

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!','A tabela ( ' + strTbpCli + ' ) utilizada para cálculo de preço do hub(CFG_TBPCLI), ' +
                           'não está configurada na CFG_TABFAT. ' + sLineBreak +
                           'Ative a tabela de preço na CFG_TABFAT ou desative o uso da tabela na CFG_TBPCLI.', ['&Ok']);
      Exit;
    End;
  finally
    FreeAndNil(qryCfgHub);
  end;
end;

class function TValidarConfiguracoes.fValidaTabelasPrecoUtilizadas(strNomeConfig : String) : Boolean;
  Var
    strTabUti  :String;
    strTabPrc  :String;
begin
  pInformacao('Aguarde, validando configuração de tabelas de preço!');

  fFindCfg('CFG_TABPRC');
  strTabPrc := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  fFindCfg(strNomeConfig);

  strTabUti := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  If (strTabUti = '0') Or (fEmptyStr(strTabUti)) Then
  Begin
    Result := True;
    Exit;
  End;

  If Length(strTabPrc) < StrToInt(strTabUti) then
    Result := False
  Else
    Result := (Copy(strTabPrc, StrToInt(strTabUti), 1) = 'S');

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO!', 'A tabela (' + strTabUti + ') não está configurada ' +
                         'para utilização no sistema, portanto não pode ser indicada. ' +
                         'Verifique a configuração ''CFG_TABPRC - Tabelas de preço utilizadas''', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaTabEqu_TabPrc: Boolean;
var
  strTabPrc: String;
  strTabEqu: String;
  intContador: Integer;
  strTabIncorretas: String;
begin
  pInformacao('Aguarde, validando configuração de tabelas de preço utilizadas no conserto de equipamentos!');

  fFindCfg('CFG_TABPRC');
  strTabPrc := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  fFindCfg('CFG_TABEQU');
  strTabEqu := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  strTabIncorretas := '';

  for intContador := 1 to Length(strTabEqu) do
  begin
    if (Copy(strTabEqu, intContador, 1) = 'S') then
    begin
      if (Copy(strTabPrc, intContador, 1) <> 'S') then
        strTabIncorretas := strTabIncorretas + IntToStr(intContador) + ',';
    end;
  end;

  Result := True;
  if not fEmptyStr(strTabIncorretas) then
  begin
    strTabIncorretas := LeftStr(strTabIncorretas, Length(strTabIncorretas)-1);
    fMensagem('ATENÇÃO!', 'As tabelas (' + strTabIncorretas + ') não estão configuradas ' +
                         'para utilização no sistema, portanto não podem ser permitidas ' +
                         'no conserto de equipamentos. (CFG_TABEQU)', ['&Ok']);
    Result := False;
  end;
end;

class function TValidarConfiguracoes.fValidaTabImp_TabPrc: Boolean;
  Var
    strTabPrc: String;
    strTabImp: String;
    intContador: Integer;
    strTabIncorretas: String;
begin
  pInformacao('Aguarde, validando configuração de tabelas de preço utilizadas!');

  fFindCfg('CFG_TABPRC');
  strTabPrc := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  fFindCfg('CFG_TABIMP');
  strTabImp := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  strTabIncorretas := '';

  For intContador := 1 To Length(strTabImp) Do
  Begin

    If (Copy(strTabImp, intContador, 1) = 'S') Then
    Begin
      If (Copy(strTabPrc, intContador, 1) <> 'S') Then
      Begin
        strTabIncorretas := strTabIncorretas + IntToStr(intContador) + ',';
      End;
    End;

  End;

  Result := True;
  If Not fEmptyStr(strTabIncorretas) Then
  Begin
    strTabIncorretas := LeftStr(strTabIncorretas, Length(strTabIncorretas)-1);
    fMensagem('ATENÇÃO!', 'As tabelas (' + strTabIncorretas + ') não estão configuradas ' +
                         'para utilização no sistema, portanto não podem ser indicadas para ' +
                         'utilização na importação de produtos da franqueadora.', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaTABPCV: Boolean;
Var
  strTABPCV : String;
  strTABPRC : String;
begin
  Result := True;

  strTABPCV := fGetValorConfiguracao('TABPCV');
  strTABPRC := fGetValorConfiguracao('TABPRC');

  If (Not fEmptyStr(strTABPCV)) And (Length(strTABPRC) = 7) Then
    Result := (strTABPRC[StrToInt(strTABPCV)] = 'S');

  If (Not Result) Then
    fMensagem('ATENÇÃO!', 'A tabela utilizada na CFG_TABPCV deve estar ativada na configuração CFG_TABPRC', ['&Ok']);
end;

class function TValidarConfiguracoes.fValidaTabVen_TabPrc: Boolean;
  Var
    strTabPrc: String;
    strTabFat: String;
    intContador: Integer;
    strTabIncorretas: String;
begin
  pInformacao('Aguarde, validando configuração de tabelas de preço utilizadas no faturamento!');

  fFindCfg('CFG_TABPRC');
  strTabPrc := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  fFindCfg('CFG_TABVEN');
  strTabFat := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  strTabIncorretas := '';

  For intContador := 1 To Length(strTabFat) Do
  Begin

    If (Copy(strTabFat, intContador, 1) = 'S') Then
    Begin
      If (Copy(strTabPrc, intContador, 1) <> 'S') Then
      Begin
        strTabIncorretas := strTabIncorretas + IntToStr(intContador) + ',';
      End;
    End;

  End;

  Result := True;
  If Not fEmptyStr(strTabIncorretas) Then
  Begin
    strTabIncorretas := LeftStr(strTabIncorretas, Length(strTabIncorretas)-1);
    fMensagem('ATENÇÃO!', 'As tabelas (' + strTabIncorretas + ') não estão configuradas ' +
                         'para utilização no sistema, portanto não podem ser permitidas ' +
                         'no faturamento.', ['&Ok']);
    Result := False;
  End;

end;

class function TValidarConfiguracoes.fValidaTagsCampoVendedorFornecedorTigre: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_DCTGOX!');

  If (fFindCfg('CFG_TAGOXV') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
     (fFindCfg('CFG_DCTGOX') And (Not fExisteFornecedorTigreConfigurado)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_TAGOXV] = SIM, o fornecedor na configuração [CFG_DCTGOX] deve ser preenchido!', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaTbpCon_TabPrc: Boolean;
  Var
    strTabPrc: String;
    strTbpCon: String;
    intContador: Integer;
    strTabIncorretas: String;
begin
  pInformacao('Aguarde, validando configuração de tabelas de preço utilizadas na consulta de estoque!');

  fFindCfg('CFG_TABPRC');
  strTabPrc := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  fFindCfg('CFG_TBPCON');
  strTbpCon := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  strTabIncorretas := '';

  For intContador := 1 To Length(strTbpCon) Do
  Begin

    If (Copy(strTbpCon, intContador, 1) = 'S') Then
    Begin
      If (Copy(strTabPrc, intContador, 1) <> 'S') Then
      Begin
        strTabIncorretas := strTabIncorretas + IntToStr(intContador) + ',';
      End;
    End;

  End;

  Result := True;
  If Not fEmptyStr(strTabIncorretas) Then
  Begin
    strTabIncorretas := LeftStr(strTabIncorretas, Length(strTabIncorretas)-1);
    fMensagem('ATENÇÃO!', 'As tabelas (' + strTabIncorretas + ') não estão configuradas ' +
                         'para utilização no sistema, portanto não podem ser visualizadas ' +
                         'na consulta de estoque do coletor.', ['&Ok']);
    Result := False;
  End;

end;

class function TValidarConfiguracoes.fValidaTefCitel: Boolean;
var
  LScopeEmpresaFilial: String;
  LScopePdv: String;
begin
  pInformacao('Aguarde, validando configuração Tef Citel!" ');

  Result := True;

  If (fFindCfg('CFG_TEFCIT') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'T') And
      fFindCfg('CFG_TIPTER') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '2')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Conferir CFG_TIPTER. A utilização de TEF Citel NCR exige Tipo de Consulta de '+
                          'Terminal diferente de 2.', ['&Ok']);
    Exit(False);
  End;

  If (fFindCfg('CFG_PIXSCP') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
  Begin
    if fFindCfg('CFG_PXCEMP') then
    begin
      LScopeEmpresaFilial := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;
      if fEmptyStr(LScopeEmpresaFilial) then
      begin
        fMensagem('ATENÇÃO!', 'Quando CFG_PIXSCP estiver ligada a CFG_PXCEMP precisa ser informada!', ['&Ok']);
        Exit(False);
      end;

      if Length(Trim(LScopeEmpresaFilial)) < 8 then
      begin
        fMensagem('ATENÇÃO!', 'CFG_PXCEMP precisa ter 8 digitos!', ['&Ok']);
        Exit(False);
      end;
    end
    else
    begin
      fMensagem('ATENÇÃO!', 'CFG_PXCEMP não está disponível neste banco — atualize o repositório.', ['&Ok']);
      Exit(False);
    end;

    if fFindCfg('CFG_PXCPDV') then
    begin
      LScopePdv := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;
      if fEmptyStr(LScopePdv) then
      begin
        fMensagem('ATENÇÃO!', 'Quando CFG_PIXSCP estiver ligada a CFG_PXCPDV precisa ser informada!', ['&Ok']);
        Exit(False);
      end;

      if Length(Trim(LScopePdv)) < 3 then
      begin
        fMensagem('ATENÇÃO!', 'CFG_PXCPDV precisa ter 3 digitos!', ['&Ok']);
        Exit(False);
      end;
    end
    else
    begin
      fMensagem('ATENÇÃO!', 'CFG_PXCPDV não está disponível neste banco — atualize o repositório.', ['&Ok']);
      Exit(False);
    end;
  End;

  if (fFindCfg('CFG_TERSAL') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') and
      fFindCfg('CFG_CARSAL') And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) then
  begin
    fMensagem('ATENÇÃO!', 'Quando CFG_TERSAL igual a Sim, a CFG_CARSAL deve ser preenchida!', ['&Ok']);
    Exit(False);
  end ;

  if (fFindCfg('CFG_TPVPSL') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '3') and
      fFindCfg('CFG_OTPSAL') And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) then
  begin
    fMensagem('ATENÇÃO!', 'Quando CFG_TPVPSL configurado como "TLS GSurf", a CFG_OTPSAL deve ser preenchida!', ['&Ok']);
    Exit(False);
  end ;

  if (fFindCfg('CFG_TPVPSL') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '4') and
      fFindCfg('CFG_TKVPSL') And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) then
  begin
    fMensagem('ATENÇÃO!', 'Quando CFG_TPVPSL configurado como "TLS Software Express (TLSGWP)", a CFG_TKVPSL deve ser preenchida!', ['&Ok']);
    Exit(False);
  end ;

  if (fFindCfg('CFG_PIMPTF') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') And
      fFindCfg('CFG_TIPVIA') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> 'A')) then
  begin
    fMensagem('ATENÇÃO!', 'Quando CFG_PIMPTF igual a "Sim", a CFG_TIPVIA deve ser "Ambas"!', ['&Ok']);
    Exit(False);
  end;
end;

class function TValidarConfiguracoes.fValidaTempoCfgImportacaoSiteTablet: Boolean;
begin
  Result := True;

  With cdsCfgSis Do
  Begin
    If fFindCfg('CFG_TMPSFA') Then
    Begin
      If (FieldByName('SIS_VALCFG').AsInteger < 5) Then
      Begin
        fMensagem('','Intervalo para execução para a importação do Site/Table (CFG_TMPSFA) deve ser maior ou igual a 5 min!',['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaTERROS: Boolean;
begin
  pInformacao('Aguarde, validando a configuração "Impressão de Termo de Responsabilidade na Ordem de Serviço:"!');

  Result := True;

  if (fGetValorConfiguracao('TERCEQ') = 'N') then
    Exit;

  if fGetValorConfiguracao('TERROS') = 'NN' then
  begin
    fMensagem('ATENÇÃO!', 'Atenção! O sistema está configurado para imprimir termo de responsabilidade na OS (CFG_TERCEQ).'
      + 'Sendo assim, é preciso informar na configuração (CFG_TERROS) em qual momento o termo será impresso', ['&Ok']);
    Result := False;
  end;
end;

class function TValidarConfiguracoes.fValidaTriggerPreAlt: Boolean;
  var
    ProcessaObjetosbancoPreAlt: TProcessaObjetosbancoPreAlt;
    frmLog: TfrmLog;
begin
  Result := True;
  If fFindCfg('CFG_RESPRE') Then
  Begin
    If (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      ProcessaObjetosbancoPreAlt :=  TProcessaObjetosbancoPreAlt.Create;
      Try
        ProcessaObjetosbancoPreAlt.blnValidaSeTemQueRemoverEstrutura := False;
        ProcessaObjetosbancoPreAlt.blnForcaValidacao := True;
        If not ProcessaObjetosbancoPreAlt.fValidaTrigger Then
        Begin
          pCriarFormularios(TFrmlog, frmLog);
          Try
            fMensagem('Atenção', 'A Configuração CFG_RESPRE - não foi alterada.' + #$A#$D + 'Não foi encontrado a estrutura necessária para restauração de preços.' + #$A#$D +
                        ProcessaObjetosbancoPreAlt.strErro + #$A#$D + 'Para prosseguir rodar o scritpt que iremos apresentar a seguir.', ['OK']);
            frmLog.Caption  := 'Script';
            frmLog.memLog.Text := ProcessaObjetosbancoPreAlt.fGetSQL_CUSTOREAL.Text + #$A#$D +
                                  ProcessaObjetosbancoPreAlt.fGetSQL_COMPRALIQUIDO.Text + #$A#$D +
                                  ProcessaObjetosbancoPreAlt.fGetSQL_PINSEREPREALT.Text + #$A#$D +
                                  ProcessaObjetosbancoPreAlt.fGetSQL_Trigger;

            frmLog.Showmodal;

            Result := False;
          Finally
            FreeAndNil(frmLog);
          End;
        End;
      Finally
        FreeAndNil(ProcessaObjetosbancoPreAlt);
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaTXAUTI: Boolean;
begin
  Result := True;

  if fFindCfg('CFG_TXAUTI') Then
  begin
    if (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') then
      Exit;

    if fFindCfg('CFG_TXAPOR') And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) then
    begin
      fMensagem('','Para utilizar a configuração CFG_TXAUTI = Sim, é necessário configurar o Portador [CFG_TXAPOR]!',['&Ok']);
      Result := False;
    end;

    if fFindCfg('CFG_TXAVAL') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsFloat <= 0) then
    begin
      fMensagem('','Para utilizar a configuração CFG_TXAUTI = Sim, é necessário configurar o valor da taxa [CFG_TXAVAL]!',['&Ok']);
      Result := False;
    end;
  end;
end;

class function TValidarConfiguracoes.fValidaQtdeMsgNFCfg_QtdMsg: Boolean;
begin
  Result := True;

  With cdsCfgSis Do
  Begin
    If fFindCfg('CFG_QTDMSG') Then
    Begin
      If (FieldByName('SIS_VALCFG').AsInteger > 5) Then
      Begin
        fMensagem('','O intervalo para a quantidade de mensagens na Nota Fiscal (CFG_QTDMSG) deve ser menor ou igual a 5!',['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaQtdeMsgPDORCfg_QtPdOr: Boolean;
begin
  Result := True;

  With cdsCfgSis Do
  Begin
    If fFindCfg('CFG_QTPDOR') Then
    Begin
      If (FieldByName('SIS_VALCFG').AsInteger > 5) Then
      Begin
        fMensagem('','O intervalo para a quantidade de mensagens no orçamento/pedido (CFG_QTPDOR) deve ser menor ou igual a 5!',['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaMCAT17: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de CAT Ressarcimento !');

  With cdsCfgSis Do
  Begin
    If ( (fFindCfg('CFG_MCAT17')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'D') ) And
       ( (fFindCfg('CFG_C17MOD'))  And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '3') ) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido utilizar a configuração [CFG_MCAT17] = "D" ' + #13#10 + 'com a [CFG_C17MOD] = "3". Verifique!', ['&Ok']);
      Result := False;
    End;
    If ( (fFindCfg('CFG_MCAT17')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'A') ) And
       ( (fFindCfg('CFG_C17MOD'))  And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '3') ) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido utilizar a configuração [CFG_MCAT17] = "A" ' + #13#10 + 'com a [CFG_C17MOD] = "3". Verifique!', ['&Ok']);
      Result := False;
    End;
    If ( (fFindCfg('CFG_MCAT17')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'C') ) And
       ( (fFindCfg('CFG_C17MOD'))  And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '3') ) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido utilizar a configuração [CFG_MCAT17] = "C" ' + #13#10 + 'com a [CFG_C17MOD] = "3". Verifique!', ['&Ok']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaMPRORI: Boolean;
begin
  Result := True;
  If ((fFindCfg('CFG_PFLCLI')) And
      (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')) And
     ((fFindCfg('CFG_MPRORI')) And
      (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'D')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a Configuração "CFG_MPRORI = Definir no perfil da condição", a configuração CFG_PFLCLI deve estar com a opção "Sim" selecionada.', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaMultSeparacao: Boolean;
begin
  Result := True;

  With cdsCfgSis Do Begin
    If ((fFindCfg('CFG_MULSEP')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
       (((fFindCfg('CFG_UTIWMS')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')) Or
       ((fFindCfg('CFG_ROMLOT')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')))Then
    Begin
      fMensagem('ATENÇÃO!', 'A configuração [CFG_MULSEP] = "S" só pode ser utilizada se as configurações [CFG_UTIWMS] = "S" e [CFG_ROMLOT] = "S". Verifique!', ['&Ok']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaObrigatoriedadeEmpresaIdentificadora: Boolean;
begin
  Result := True;

  With cdsCfgSis Do Begin
    If ((fFindCfg('CFG_OBEMID')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
       (((fFindCfg('CFG_EMPFAT')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')) And
       ((fFindCfg('CFG_EMPFVN')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')))Then
    Begin
      fMensagem('ATENÇÃO!', 'Para ativar a configuração [CFG_OBEMID], as configurações [CFG_EMPFAT] OU [CFG_EMPFVN] deve estar ligada. Verifique!', ['&Ok']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaOBRLPK: boolean;
begin
 Result := True;

  With cdsCfgSis Do Begin
    If ((fFindCfg('CFG_OBRLPK')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And ((fFindCfg('CFG_LOTPIC')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Para ativar a configuração [CFG_OBRLPK], a configuração [CFG_LOTPIC] deve estar ligada. Verifique!', ['&Ok']);
      Result := False;
    End
    Else
    If ((fFindCfg('CFG_OBRLPK')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')) And ((fFindCfg('CFG_LOTPIC')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Para desativar a configuração [CFG_OBRLPK], a configuração [CFG_LOTPIC] deve estar desligada. Verifique!', ['&Ok']);
      Result := False;
    End
  End;
end;

class function TValidarConfiguracoes.fValidaOPLORE: Boolean;
begin
  Result := True;

  With cdsCfgSis Do Begin
    If ((fFindCfg('CFG_OPLORE')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'NNN')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Pelo menos uma opção deve ser selecionada na configuração CFG_OPLORE. Verifique!', ['&Ok']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaOSGLCP: Boolean;
begin
  Result := True;

  if (fGetValorConfiguracao('OSGLCP') = 'N') then
    Exit;

  if (not fEmptyStr(fGetValorConfiguracao('OSGLPO'))) and (not fEmptyStr(fGetValorConfiguracao('OSGLPC'))) then
    Exit;

  fMensagem('ATENÇÃO!', 'Para habilitar a configuração CFG_OSGLCP, é necessário definir as configurações [CFG_OSGLPO] e [CFG_OSGLPC].', ['&Ok']);

  Result := False;
end;

class function TValidarConfiguracoes.fValidaNumeroSerie_Com_Wms: Boolean;
Begin
  Result := True;

  pInformacao('Aguarde, Utilizar controle simplificado de números de série.');

  With cdsCfgSis Do Begin
    If ((fFindCfg('CFG_NUMSER')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
       ((fFindCfg('CFG_UTIWMS')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido utilizar a configuração [CFG_NUMSER] = "S" ' + #13#10 + 'com a [CFG_UTIWMS] = "S". Verifique!', ['&Ok']);
      Result := False;
    End;
  End;
End;

class function TValidarConfiguracoes.fValidaNFCeOffLine: Boolean;
Begin
  Result := True;

  If (fFindCfg('CFG_USAOFF') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
  Begin
    pInformacao('Aguarde, Validando configurações NFCe Off-Line.');

    With cdsCfgSis Do
    Begin
      If ((fFindCfg('CFG_EMP_ID')) And fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Or
         ((fFindCfg('CFG_CERJKS')) And fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Or
         ((fFindCfg('CFG_SENJKS')) And fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Or
         ((fFindCfg('CFG_ITOKEN')) And fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Or
         ((fFindCfg('CFG_NTOKEN')) And fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Or
         ((fFindCfg('CFG_OFFLIC')) And fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Or
         ((fFindCfg('CFG_URLOFF')) And fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe todas os configurações da NFCe Off-Line!', ['&Ok']);
        Result := False;
      End;
    End;
  End;
End;

class function TValidarConfiguracoes.fValidaNovaFormaCadCartaoTef: Boolean;
var
  LstrValorAnterior: String ;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CDCRNV!');

  LstrValorAnterior := fCfgSis('CDCRNV') ;

  if (fFindCfg('CFG_CDCRNV')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> LstrValorAnterior) then
  begin
    if cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N' then
    begin
      Result := fMensagem('','Deseja realmente desabilitar a nova forma de cadastro de cartão, considerando os dados para TEF [CFG_CDCRNV]?',['','']) = 1  ;
    end ;
  end ;
end;

class function TValidarConfiguracoes.fValidaDASWEB: Boolean;
Var
  strDASWEB : String;

  function fTriggerExiste(const strTabela, strTrigger: String): Boolean;
    Var
      qryAux: TUniQuery;
  begin
    Result := False;
    qryAux := fCriaQuery;

    Try
      qryAux.SQL.Text := ' SELECT * FROM INFORMATION_SCHEMA.TRIGGERS ' +
                         ' WHERE INFORMATION_SCHEMA.TRIGGERS.TRIGGER_SCHEMA = DATABASE() ' +
                         '     AND INFORMATION_SCHEMA.TRIGGERS.TRIGGER_NAME = :TRIGGER ' +
                         '     AND INFORMATION_SCHEMA.TRIGGERS.EVENT_OBJECT_TABLE = :TABELA ' ;
      qryAux.ParamByName('TRIGGER').AsString := strTrigger;
      qryAux.ParamByName('TABELA').AsString := strTabela;
      qryAux.Open;

      Result := not qryAux.IsEmpty;
    Except
      On E: Exception Do
        pMensagensErro(E.message, '');
    End;

    FreeAndNil(qryAux);
  end;

begin
  If fFindCfg('CFG_DASWEB') Then
    strDASWEB := cdsCfgSis.FieldByName('SIS_VALCFG').AsString
  Else
    strDASWEB := 'N';

  Result := False;

  If (strDASWEB = 'S') Then
    If (Not ((fTabelaExiste('MOVDET_DASHBOARD', True))
      And (fTabelaExiste('FATDOR_DASHBOARD', True))
      And (fTriggerExiste('MOVDET', 'T_MOVDET_AI_DASHBOARD'))
      And (fTriggerExiste('MOVDET', 'T_MOVDET_AU_DASHBOARD')))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Para usar a configuração CFG_DASWEB entre em contato com a Citel para configurações adicionais!', ['&Ok']);
      Exit;
    End;

  Result := True;
end;

class function TValidarConfiguracoes.fValidaSPCDEN: Boolean;
Var
  strSPCDEN : String;

  function fTriggerExiste(const strTabela, strTrigger: String): Boolean;
    Var
      qryAux: TUniQuery;
  begin
    Result := False;
    qryAux := fCriaQuery;

    Try
      Try
        qryAux.SQL.Text := ' SELECT * FROM INFORMATION_SCHEMA.TRIGGERS ' +
                           ' WHERE INFORMATION_SCHEMA.TRIGGERS.TRIGGER_SCHEMA = DATABASE() ' +
                           '     AND INFORMATION_SCHEMA.TRIGGERS.TRIGGER_NAME = :TRIGGER ' +
                           '     AND INFORMATION_SCHEMA.TRIGGERS.EVENT_OBJECT_TABLE = :TABELA ' ;
        qryAux.ParamByName('TRIGGER').AsString := strTrigger;
        qryAux.ParamByName('TABELA').AsString := strTabela;
        qryAux.Open;

        Result := not qryAux.IsEmpty;
      Except
        On E: Exception Do
          pMensagensErro(E.message, '[fValidaSPCDEN.fTriggerExiste]');
      End;
    Finally
      FreeAndNil(qryAux);
    End;
  end;

begin
  If fFindCfg('CFG_SPCDEN') Then
    strSPCDEN := cdsCfgSis.FieldByName('SIS_VALCFG').AsString
  Else
    strSPCDEN := 'N';

  Result := False;

  If (strSPCDEN = 'S') Then
    If (Not ((fTriggerExiste('EXTGOR', 'BI_EXTGOR_DOCEND'))
      And (fTriggerExiste('EXTGOR', 'BU_EXTGOR_DOCEND')))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Para usar a configuração CFG_SPCDEN entre em contato com a Citel para disponibilizar as triggers BI_EXTGOR_DOCEND e BU_EXTGOR_DOCEND!', ['&Ok']);
      Exit;
    End;

  Result := True;
end;


class function TValidarConfiguracoes.fValidaDiasEntregaImediata: Boolean;
var
  intDiasMax: integer;
  intDiasMin: integer;
begin
  Result := True;

  if fFindCfg('CFG_DIAIME') Then
    intDiasMax := StrToIntDef(cdsCfgSis.FieldByName('SIS_VALCFG').AsString,0)
  else
    intDiasMax := 0;

  if fFindCfg('CFG_QMDPEI') Then
    intDiasMin := StrToIntDef(cdsCfgSis.FieldByName('SIS_VALCFG').AsString,0)
  else
    intDiasMin := 0;

  if intDiasMax < intDiasMin then
  begin
    pMensagemOk('A configuração de Quantidade mínima de dias [CFG_QMDPEI] não pode ser superior a '+
                'Quantidade máxima de dias para entrega imediata [CFG_DIAIME] !');
    Result := False;
  end;

end;

class function TValidarConfiguracoes.fValidaPedidoComplementarParaCliente: Boolean;
begin
  pInformacao('Aguarde, validando configuração de Pedido de Venda Complementar!');

  Result := True;

  with cdsCfgSis Do
  if (fFindCfg('CFG_PEDCPL') And (FieldByName('SIS_VALCFG').AsString = 'S')) and
     ((fFindCfg('CFG_VNDSPD') And (FieldByName('SIS_VALCFG').AsString = 'N')) or
      (fFindCfg('CFG_ALTVEN') And (FieldByName('SIS_VALCFG').AsString = 'N'))) then
  begin
    Result := False;

    fMensagem('Atenção!','Quando a configuração (CFG_PEDCPL) estiver ativa, as configurações '+
                         '(CFG_VNDSPD) e (CFG_ALTVEN) também precisarão ser ativadas para '+
                         'permitir vendedores diferentes para um mesmo pedido!', ['&Ok']);
  end;
end;

class function TValidarConfiguracoes.fValidaPedidosComCondicoesPagamentoDiferentesExpedicao: Boolean;
begin
  pInformacao('Aguarde, validando configuração de Procedimento quando marcar pedidos com condições de pagamento diferentes!');

  With cdsCfgSis Do
  If (fFindCfg('CFG_CNEXCP') And (FieldByName('SIS_VALCFG').AsString = 'C')) And
     (fFindCfg('CFG_PFLCLI') And (FieldByName('SIS_VALCFG').AsString = 'N')) Then
  Begin
    Result := FALSE;
    fMensagem('Atenção','Sistema configurado para Permitir selecionar e considerar a condição de maior prazo desde que satisfaça o valor da parcela mínima definida no perfil da condição. Se não fizer, operador deverá decidir qual condição será utilizada. (CFG_CNEXCP).'+#13+
                        'Sendo assim, esta configuração (CFG_PFLCLI) não pode ser desabilitada.',['&Ok']);
  End

  Else Result := TRUE;
end;

class function TValidarConfiguracoes.fValidaPedidosComCondicoesPagamentoDiferentesConfirmacaoPedidos: Boolean;
begin
  pInformacao('Aguarde, validando configuração de Procedimento quando marcar pedidos com condições de pagamento diferentes!');

  With cdsCfgSis Do
  If (fFindCfg('CFG_CNDICP') And (FieldByName('SIS_VALCFG').AsString = 'C')) And
     (fFindCfg('CFG_PFLCLI') And (FieldByName('SIS_VALCFG').AsString = 'N')) Then
  Begin
    Result := FALSE;
    fMensagem('Atenção','Sistema configurado para Permitir selecionar e considerar a condição de maior prazo desde que satisfaça o valor da parcela mínima definida no perfil da condição. Se não fizer, operador deverá decidir qual condição será utilizada. (CFG_CNDICP).'+#13+
                        'Sendo assim, esta configuração (CFG_PFLCLI) não pode ser desabilitada.',['&Ok']);
  End

  Else Result := TRUE;
end;

class function TValidarConfiguracoes.fValidaPercentual_0_100(strCFG: String): Boolean;
  var
    fltPerVal: Double;
begin
  Result := True;

  if fFindCfg(strCFG) then
    fltPerVal := StrToFloatDef(cdsCfgSis.FieldByName('SIS_VALCFG').AsString,-1)
  else
    fltPerVal := 0;

  if (fltPerVal < 0) or (fltPerVal > 100) then
  begin
    pMensagemOk('O valor da configuração ['+strCFG+'] é um percentual e deve ficar entre 0% e 100%! ');
    Result := False;
  end;
end;

class function TValidarConfiguracoes.fValidaPICOUT: Boolean;
begin

  Result := True;

  If (fGetValorConfiguracao('PICOUT').Equals('S')) Then
  Begin

    If (fGetValorConfiguracao('UTIWMS') <> 'S') Then
    Begin
      pMensagemOk('Para utilizar a configuração [PICOUT] é preciso definir "[UTIWMS] Utilizar WMS (Sistema de Gerenciamento de Armazém)?" = Sim');
      Exit(False);
    End;

    If (fGetValorConfiguracao('LOCRET') <> 'S') Then
    Begin
      pMensagemOk('Para utilizar a configuração [PICOUT] é preciso definir "[LOCRET] Local de Retira - Solicitar Local de Retira na emissão de Orçamento/Pedidos?" = Sim');
      Exit(False);
    End;

    If (fGetValorConfiguracao('NPDF11') <> 'S') Then
    Begin
      pMensagemOk('Para utilizar a configuração [PICOUT] é preciso definir "[NPDF11] Gerar novo Pedido de Venda para itens de entrega imediata quando faturar um pedido pelo F11 do Resumo de Caixa?" = Sim');
      Exit(False);
    End;

  End;

end;

class function TValidarConfiguracoes.fValidaPMEVMN: Boolean;
var
  LPMEVMN: String;
begin
  Result := True;

  LPMEVMN := fGetValorConfiguracao('PMEVMN');

  If fEmptyStr(LPMEVMN) Or (fStrToFloat(LPMEVMN) < 1) Then
  Begin
    fMensagem('ATENÇÃO!', 'A configuração [CFG_PMEVMN] precisa ser maior ou igual a "1,00" (Um Real) !', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaPMVCSH(
  const AExibirMensagem: Boolean): Boolean;
var
  LPMVCSH: String;
begin
  Result := True;

  LPMVCSH := fGetValorConfiguracao('PMVCSH');

  If (fStrToFloat(LPMVCSH) < 0.01) Or
     (fStrToFloat(LPMVCSH) > 99.99) Then
  Begin
    If AExibirMensagem Then
      fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_PMVCSH], o percentual deve estar entre 0.01 e 99.99%!', ['&Ok']);

    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaUsarExpedicaoConferenciaRetiraCaixa: Boolean;
Var
  strDesCfg: String;

  function asString(strCampo: String): String;
  begin
    Result := cdsCfgSis.FieldByName(strCampo).AsString;
  end;

begin
  Result := True;

  If Not fFindCfg('CFG_EXRETC') Then
    Exit;

  strDesCfg := asString('SIS_DESCRI');

  pInformacao('Aguarde, validando configuração "' + strDesCfg + '"!');

  If asString('SIS_VALCFG') <> 'S' Then
    Exit;

  If Not (fFindCfg('CFG_LOCRET') And (asString('SIS_VALCFG') = 'S')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Quando a configuração "' + strDesCfg + '" ' +
      'estiver configurada para "Sim" a configuração "' + asString('SIS_DESCRI') + '" ' +
      'também deve estar configurada para "Sim" ', ['&Ok']);
    Exit(False);
  End;

  If Not (fFindCfg('CFG_TIPEXP') And (asString('SIS_VALCFG') = '4')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Quando a configuração "' + strDesCfg + '" ' +
      'estiver configurada para "Sim" a configuração "' + asString('SIS_DESCRI') + '" ' +
      ' deve estar configurada para "4 - Pedido (O pedido não será faturado)" ', ['&Ok']);
    Exit(False);
  End;

end;

class function TValidarConfiguracoes.fValidaUTIFNS: Boolean;
var
  strUTIFNS: String;
  strFNSCSV: String;
  strFNSDSV: String;
  strUSASER: String;
  strITESER: String;
begin
  Result := True;

  strUTIFNS := fGetValorConfiguracao('UTIFNS');
  strFNSCSV := fGetValorConfiguracao('FNSCSV');
  strFNSDSV := fGetValorConfiguracao('FNSDSV');
  strUSASER := fGetValorConfiguracao('USASER');
  strITESER := fGetValorConfiguracao('ITESER');

  If strUTIFNS = 'N' Then
    Exit;

  If fEmptyStr(strFNSCSV) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para habilitar a configuração CFG_UTIFNS, é necessário informar um serviço na configuração CFG_FNSCSV', ['&Ok']);
    Result := False;
    Exit;
  End;

  If fEmptyStr(strFNSDSV) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para habilitar a configuração CFG_UTIFNS, é necessário informar uma discriminação na configuração CFG_FNSDSV', ['&Ok']);
    Result := False;
    Exit;
  End;

  If fEmptyStr(strITESER) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para habilitar a configuração CFG_UTIFNS, é necessário informar um item na configuração CFG_ITESER', ['&Ok']);
    Result := False;
    Exit;
  End;

  if strUSASER = 'N' Then
  Begin
    fMensagem('ATENÇÃO!', 'Para habilitar a configuração CFG_UTIFNS, é necessário ligar a configuração CFG_USASER', ['&Ok']);
    Result := False;
    Exit;
  End;
end;

class function TValidarConfiguracoes.fValidaUtiHor: Boolean;
var
  intMinutos : Integer;
begin

  Result := True;

  pInformacao('Aguarde, validando configuração "CFG_UTIHOR - Utilizar permissão de horários de operação do Sistema?".');

  With cdsCfgSis Do
  Begin

    If ((fFindCfg('CFG_UTIHOR')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
    Begin

      If ((fFindCfg('CFG_TMPHOR')) And (Not cdsCfgSis.FieldByName('SIS_VALCFG').IsNull)) Then
      Begin

        If TryStrToInt(cdsCfgSis.FieldByName('SIS_VALCFG').AsString, intMinutos) Then
        Begin

          If (intMinutos Mod 10) > 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Para utilizar a configuração "CFG_TMPHOR" seu valor deve ser múltiplo de 10 (Minutos).', ['&Ok']);
            Result := False;
          End;

        End;

      End;

    End;

  End;

end;

class function TValidarConfiguracoes.fValidaUtilizacaoDescMaxVendFaixaQtdeVendida: Boolean;
begin
  Result := True;

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_ITETBP') And (FieldByName('SIS_VALCFG').AsString = 'S')) And
       (fFindCfg('CFG_DMVFQV') And (FieldByName('SIS_VALCFG').AsString = 'S')) Then
    Begin
      pMensagemOk('Não é permitido usar a configuração [CFG_ITETBP] em conjunto '+#13+
                  'com a configuração [CFG_DMVFQV]!');
      Result := False;
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaUtilizacaoRestricaoVendaProduto: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de Restrição de Vendas de produtos!');

  If (fGetValorConfiguracao('UTCRVP') = 'S') And (fGetValorConfiguracao('UTIFMP') = 'S') Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido que as configurações [CFG_UTIFMP] e [CFG_UTCRVP] '+
                          'estejam ativas ao mesmo tempo.', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaUtilizarOndaSeparacao: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração Onda de Separação!');

  With cdsCfgSis Do
  Begin
    If ((fFindCfg('CFG_ONDASE')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
    Begin

      If ((fFindCfg('CFG_VENVID')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitida a utilização das configurações [CFG_ONDASE] e' + #13#10 + '[CFG_VENVID] em conjunto. Verifique!', ['&Ok']);
        Exit(False);
      End;

      If ((fFindCfg('CFG_VENMAD')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitida a utilização das configurações [CFG_ONDASE] e' + #13#10 + '[CFG_VENMAD] em conjunto. Verifique!', ['&Ok']);
        Exit(False);
      End;

      If (fFindCfg('CFG_TIPEXP')) And (Pos(cdsCfgSis.FieldByName('SIS_VALCFG').AsString, '3_4_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_ONDASE] a configuração [CFG_TIPEXP] deve '+
          'ser [3]Faturamento depois da expedição ou [4]Pedido - O pedido não será faturado. Verifique!', ['&Ok']);
        Exit(False);
      End;

    End;
  End;

end;

class function TValidarConfiguracoes.fValidaRasInd: Boolean;
begin
  Result := True;

  if fGetValorConfiguracao('RASIND')  <> '1' then
  begin
    If fGetValorConfiguracao('LOTCOM') = 'S' Then
    Begin
      pMensagemOk('Não é permitido utilizar a configuração [CFG_RASIND] em conjunto '+#13+
                  'com a configuração [CFG_LOTCOM]!');
      Result := False;
    End
    else if fGetValorConfiguracao('LOTCRO') = 'S' Then
    Begin
      pMensagemOk('Não é permitido utilizar a configuração [CFG_RASIND] em conjunto '+#13+
                  'com a configuração [CFG_LOTCRO]!');
      Result := False;
    End;
  end;
end;

class function TValidarConfiguracoes.fValidaRATEST: Boolean;
begin
  Result := True;

  if (fGetValorConfiguracao('RATEST') <> 'N') and (fGetValorConfiguracao('SUGVLE') = '2') then
  begin
    pMensagemOk('Para utilizar a configuração CFG_SUGVLE na opção "Somando os preços de venda dos sub-produtos", a configuração CFG_RATEST deve estar NÃO!');
    Result := False;
  end;
end;

class function TValidarConfiguracoes.fValidarConfiguracoesResumoDeCaixa: Boolean;
  Var
    strTPFCCX: String;
begin
  Result := True;

  strTPFCCX := fGetValorConfiguracao('TPFCCX');

  If strTPFCCX = 'T' Then
    Result := (fGetValorConfiguracao('RCXLAC') <> 'S') And
              (MatchStr(fGetValorConfiguracao('RCXTOL'), ['0,00', '0', EmptyStr]));

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'Para selecionar o valor da configuração "Tipo de fechamento do caixa" como "Total", as configurações: ' + #13 +
                         'CFG_RCXLAC - "Utiliza controle de fechamento de caixas com lacre de malote?" - Devem estar selecionadas como "Não"; ' + #13 +
                         'CFG_RCXTOL - "Tolerância para fechamento de caixa na utilização de transferência cega" - Não deve ser maior que zero.',
                         ['&Ok']);
    Exit;
  End;

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'Para selecionar o valor da configuração "Tipo de fechamento do caixa" como "Caixas", a configuração: ' + #13 +
                         'CFG_SIGPAI - "Sigla do Pais"' + #13 +
                         'Não pode ser do Paraguay',
                         ['&Ok']);
    Exit;
  End;

  If strTPFCCX.Equals('C') THen
  Begin
    If Not fGetValorConfiguracao('SALRCX').Equals('O') Then
    Begin
      Result := Not fGetValorConfiguracao('TRFCEG').Equals('S');

      If Not Result Then
      Begin
        fMensagem('ATENÇÃO', 'Para utilizar Transferência cega com a configuração "Tipo de fechamento do caixa" como "Caixas", ' +
                             'a configuração [CFG_SALRCX] deve estar selecionada como "Operador"',
                             ['&Ok']);
        Exit;
      End;

      Result := Not fGetValorConfiguracao('OPTFLG').Equals('S');

      If Not Result Then
        fMensagem('ATENÇÃO', 'Para utilizar Transferência cega com a configuração "Tipo de fechamento do caixa" como "Caixas", ' +
                             'a configuração [CFG_OPTFLG] deve estar selecionada como "Não"',
                             ['&Ok']);
    End;

    If Result Then
    Begin
      If fGetValorConfiguracao('TRFCEG').Equals('N') Then
      Begin
        Result := fGetValorConfiguracao('RCXDIV').Equals('N');

        If Not Result Then
          fMensagem('ATENÇÃO', 'Quando a configuração [CFG_RCXDIV] "Utiliza controle divergência de valores no fechamento do Caixa..." estiver "Sim", ' +
                               'a configuração [CFG_TRFCEG] não pode estar selecionada como "Não".',
                               ['&Ok']);
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaVALFMC: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração "Permitir aplicar desconto e/ou alterar o valor unitário na rotina de "Faturamento de Mercadoria em Consignação!"');

  if fGetValorConfiguracao('VALFMC')= 'S' then
  begin
    If fGetValorConfiguracao('RETACS') = 'N' Then
    Begin
      pMensagemOk('Não é permitido utilizar a configuração [CFG_VALFMC] sem que a '+#13+
                  'configuração [CFG_RETACS] esteja ativada!');
      Result := False;
    End;
  end;
end;

class function TValidarConfiguracoes.fValidaVALWMS: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_VALWMS!');

  If fFindCfg('CFG_VALWMS') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
  Begin
    If fFindCfg('CFG_UTIWMS') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
    Begin
      fMensagem('ATENÇÃO!', 'Para usar a configuração CFG_VALWMS é preciso que a configuração (CFG_UTIWMS = SIM)!', ['&Ok']);
      Result := False;
    End;

    If fFindCfg('CFG_TPLREC') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> 'C') Then
    Begin
      fMensagem('ATENÇÃO!', 'Para usar a configuração CFG_VALWMS é preciso que a configuração (CFG_TPLREC = (C)LASSE)!', ['&Ok']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaVAPICO: Boolean;
begin
  Result := True;
  if fGetValorConfiguracao('VAPICO') = 'S' then
  begin
    If fGetValorConfiguracao('UTIABR') = 'N' Then
    Begin
      pMensagemOk('Para utilizar a configuração [VAPICO] é preciso habilitar a configuração [UTIABR]!');
      Result := False;
    End;
    If fGetValorConfiguracao('VALELE') = 'N' Then
    Begin
      pMensagemOk('Para utilizar a configuração [VAPICO] é preciso habilitar a configuração [VALELE]!');
      Result := False;
    End;

  end;

end;


class function TValidarConfiguracoes.fValidaFORPAT: Boolean;
Var
  strValor: String;
begin
  Result  := True;
  strValor:= '';

  pInformacao('Aguarde, validando configuração CFG_FORPAT!');

  If (fFindCfg('CFG_FORPAT')) And
     (Not(fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) Then
  Begin

    strValor:= cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

    If fFindCfg('CFG_CLIPAT') Then
    Begin

      If (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = strValor) Then
      Begin
        fMensagem('ATENÇÃO!', 'Diretório já definido na configuração [CFG_CLIPAT] favor informar outro diretório.', ['&Ok']);
        Result := False;
      End;

    End;

  End;

End;

class function TValidarConfiguracoes.fValidaUGPDTE: Boolean;
var
  lUGPDTE: String;
  lREGCID: String;
  lPDVIME: String;

begin
  Result := True;
  lUGPDTE := fGetValorConfiguracao('UGPDTE');
  lREGCID := fGetValorConfiguracao('REGCID');
  lPDVIME := fGetValorConfiguracao('PDVIME');

  if lUGPDTE = 'N' then
    Exit;

  if (lREGCID = 'S') And (lPDVIME = 'N') then
    Exit;

  if lPDVIME = 'S' then
  begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração CFG_UGPDTE = Sim, a configuração [CFG_PDVIME] deve estar configurada = Nao!', ['&Ok']);
    Exit(False);
  end;

  if lREGCID = 'N' then
  begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração CFG_UGPDTE = Sim, a configuração [CFG_REGCID] deve estar configurada = Sim!', ['&Ok']);
    Exit(False);
  end;
end;

class function TValidarConfiguracoes.fValidaUTILLC: boolean;
var
  strUTILLC: String;
  strUTIWMS: String;
  strGRUSEP: String;
  strLSEWMS: String;
begin
  Result := True;

  strUTILLC := fGetValorConfiguracao('UTILLC');
  strUTIWMS := fGetValorConfiguracao('UTIWMS');
  strGRUSEP := fGetValorConfiguracao('GRUSEP');
  strLSEWMS := fGetValorConfiguracao('LSEWMS');

  If (strUTILLC = 'S') And ((strUTIWMS <> 'S') or (strGRUSEP <> 'S') or (strLSEWMS <> 'N')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração CFG_UTILLC = Sim, o sistema deverá estar utilizando as configurações CFG_UTIWMS = Não, CFG_GRUSEP = "Por Local de Separação" e CFG_LSEWMS = N', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaUTIRE2: Boolean;
begin
  Result := True;

  With cdsCfgSis Do Begin
    If (fFindCfg('CFG_UTIRE2')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      If (fFindCfg('CFG_EMPFAT')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a [CFG_UTIRE2], a [CFG_EMPFAT] também precisa estar habilitada. Verifique!', ['&Ok']);
        Result := False;
      End
      Else If (fFindCfg('CFG_ENT_CD')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a [CFG_UTIRE2], a [CFG_ENT_CD] também precisa estar habilitada. Verifique!', ['&Ok']);
        Result := False;
      End
      Else If (fFindCfg('CFG_NPDF11')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a [CFG_UTIRE2], a [CFG_NPDF11] também precisa estar habilitada. Verifique!', ['&Ok']);
        Result := False;
      End
      Else If (fFindCfg('CFG_ABADEP')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a [CFG_UTIRE2], a [CFG_ABADEP] precisa estar desabilitada. Verifique!', ['&Ok']);
        Result := False;
      End
      Else If (fFindCfg('CFG_EXOULJ')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a [CFG_UTIRE2], a [CFG_EXOULJ] precisa estar desabilitada. Verifique!', ['&Ok']);
        Result := False;
      End
      Else If (fFindCfg('CFG_UTI_RE')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar a [CFG_UTIRE2], a [CFG_UTI_RE] precisa estar desabilitada. Verifique!', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaUTIRRD: Boolean;
var
  strUTIRRD,
  strRDDLFL,
  strRDLFLT,
  strLFLOSF,
  strLFLGDC,
  strRDCGTL,
  strDEVEND,
  strUTIWMS: String;
begin
  Result := True;

  strUTIRRD := fGetValorConfiguracao('UTIRRD');
  strUTIWMS := fGetValorConfiguracao('UTIWMS');
  strRDDLFL := fGetValorConfiguracao('RDDLFL');
  strRDLFLT := fGetValorConfiguracao('RDLFLT');
  strLFLOSF := fGetValorConfiguracao('LFLOSF');
  strLFLGDC := fGetValorConfiguracao('LFLGDC');
  strRDCGTL := fGetValorConfiguracao('RDCGTL');
  strDEVEND := fGetValorConfiguracao('DEVEND');

  If (strUTIRRD = 'S') And (strUTIWMS = 'N') Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa rotina só pode ser utilizada com WMS (CFG_UTIWMS = "S")', ['&Ok']);
    Result := False;
  End;

  If (strUTIRRD = 'S') And
     ((fEmptyStr(strRDDLFL)) Or (fEmptyStr(strRDLFLT)) Or (fEmptyStr(strLFLOSF)) Or (fEmptyStr(strLFLGDC)) Or (fEmptyStr(strRDCGTL))) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para usar a rotina de remessa de devolução é preciso informar as localizações físicas nas configurações: ' +
                          'CFG_RDCGTL, CFG_RDLFLT, CFG_LFLOSF, CFG_LFLGDC e CFG_RDCGTL. Ajuste as configurações antes de prosseguir.', ['&Ok']);
    Result := False;
  End;

  If (strUTIRRD = 'S') And (strDEVEND = 'N') Then
  Begin
    fMensagem('ATENÇÃO!', 'A configuração "CFG_DEVEND" deve estar ligada.', ['&Ok']);
    Result := False;
  End;


  If (strUTIRRD = 'S') And (Not fValidaCFGsLocalizacaoRemessaDevolucao) Then
  Begin
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaUTITDE: Boolean;
begin
Result := True;

  pInformacao('Aguarde, validando controle de transbordo para documentos de entrega!');

  With cdsCfgSis Do Begin
    If (fFindCfg('CFG_UTITDE')) And (FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      If (fFindCfg('CFG_OPCROM')) And (FieldByName('SIS_VALCFG').AsString = '1') Then
      Begin
        fMensagem('ATENÇÃO!', 'Quando se utiliza a configuração [CFG_UTITDE], o valor de [CFG_OPCROM] não pode ser "Pedido de Venda"!', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaUTIWMS: Boolean;
begin

  Result := True;

  if fGetValorConfiguracao('UTIWMS') = 'S' then
  begin

    If fFindCfg('CFG_CTLEST') And
       Not (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '1') Then
    Begin
      pMensagemOk('Para utilizar a configuração [UTIWMS] é preciso definir "[CTLEST] Tipo de controle de sub-estoque na mesma loja = POR LOTE."');
      Result := False;
    End;

    If fFindCfg('CFG_CADLOC') And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
    Begin
      pMensagemOk('Para utilizar a configuração [UTIWMS] é preciso habilitar a configuração [CADLOC]!');
      Result := False;
    End;

    If fFindCfg('CFG_CONFME') And
       Not (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '1') Then
    Begin
      pMensagemOk('Para utilizar a configuração [UTIWMS] é preciso definir "[CONFME] Realizar Conferência para Entrada de Mercadorias através: = PRE-NOTA."');
      Result := False;
    End;

    If fFindCfg('CFG_USACON') And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
    Begin
      pMensagemOk('Para utilizar a configuração [UTIWMS] é preciso habilitar a configuração [USACON]!');
      Result := False;
    End;

    If fFindCfg('CFG_TIPEXP') And
       ( (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '1') Or
         (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '2')) Then
    Begin
      pMensagemOk('Para utilizar a configuração [UTIWMS] é preciso definir "[TIPEXP] Expedição = (3) FATURAMENTO DEPOIS DA EXPEDICAO, (4) PEDIDO NÃO SERÁ FATURADO ou (5) PRÉ-ROMANEIO"');
      Result := False;
    End;

  end;

end;

class function TValidarConfiguracoes.fValidaUTI_RE: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configurações do Regime Especial!');

  If fFindCfg('CFG_UTI_RE') Then
  Begin
    If cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S' Then
    Begin
      Result := ((fFindCfg('CFG_EMPRES')) And (not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString))) Or
                ((fFindCfg('CFG_EMPREN')) And (not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)));

      If Not Result Then
      Begin
        pMensagemOk('Para utilizar a rotina de emissão de faturamento, pela empresa com Regime especial (CFG_UTI_RE), é necessário configurar: ' + #13 +
                    '(CFG_EMPRES) - Empresa com Regime Especial' + sLineBreak +
                    '(CFG_EMPREN) - Empresa fora do Regime Especial'+ sLineBreak + sLineBreak +
                    'Verifique se as configurações foram informadas!');

        Exit;
      End;
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaImpressoraGNRE: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração [CFG_GNRIMP] GNRE Nacional - Impressora !');

  With cdsCfgSis Do
  Begin
    If fFindCfg('CFG_GNRIMP') And (not fEmptyStr(FieldByName('SIS_VALCFG').AsString)) Then
    Begin
      If VerImpressoraONLINE(FieldByName('SIS_VALCFG').AsString) <> 0 Then
      Begin
        fMensagem('','A impressora informada na configuração [CFG_GNRIMP] é inválida.',['&Ok']);
        Result := False;
      End;
    End;

  End;

end;

class function TValidarConfiguracoes.fValidaIMPXGR: Boolean;
var
  valCFG_IMPXGR: String;
  valCFG_REFENT: String;
begin
  Result := True;

  pInformacao('Aguarde, validando configurações REFENT e IMPXGR!');

  If (cdsCfgSis.FindKey(['CFG_IMPXGR'])) Then
    valCFG_IMPXGR := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;
  If (cdsCfgSis.FindKey(['CFG_REFENT'])) Then
    valCFG_REFENT := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  If (valCFG_REFENT = 'S') And (valCFG_IMPXGR = 'S') Then
  begin
    fMensagem('ATENÇÃO!', 'Quando se utiliza a configuração [CFG_IMPXGR = "S"], a configuração [CFG_REFENT] não pode estar ativa!', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaDescricaoCampoPercentual: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando descrição de campo percentual de acrescimo!');

  With cdsCfgSis Do Begin
    If (fFindCfg('CFG_TCOMTB')) And (fEmptyStr(FieldByName('SIS_VALCFG').AsString)) Then
    Begin
      If (fFindCfg('CFG_PCMPRO')) And (FieldByName('SIS_VALCFG').AsString = '3') Then
      Begin
        fMensagem('ATENÇÃO!', 'Quando se utiliza a configuração [CFG_PCMPRO = 3], o valor de [CFG_TCOMTB] não pode ser vazio!', ['&Ok']);
        Result := False;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaDFPSSL: Boolean;
var
  strDFPSSL: String;
  strROMLOT: String;
begin
  Result := True;

  strDFPSSL := fGetValorConfiguracao('DFPSSL');
  strROMLOT := fGetValorConfiguracao('ROMLOT');

  If Not fEmptyStr(strDFPSSL) Then
  Begin
    If (strDFPSSL <> '1') And (strROMLOT <> 'S') Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido utilizar a configuração [CFG_DFPSSL] sem [CFG_ROMLOT] = "S", Verifique!', ['&Ok']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaReaproveitamentoVendasPerdidas: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração [CFG_REAVPD] - Reaproveitar vendas perdidas no faturamento? !');

  With cdsCfgSis Do
  Begin
    If fFindCfg('CFG_REAVPD') And (FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      If Result And fFindCfg('CFG_DMPOPC') And (Copy(FieldByName('SIS_VALCFG').AsString, 2, 1) = 'N') Then
      Begin
        fMensagem('','Para usar a configuração [CFG_REAVPD] verifique a configuração [CFG_DMPOPC] = Gerar vendas perdidas.',['&Ok']);
        Result := False;
      End;

      If Result And fFindCfg('CFG_DMPMVP') And (fEmptyStr(FieldByName('SIS_VALCFG').AsString)) Then
      Begin
        fMensagem('','Para usar a configuração [CFG_REAVPD] verifique a configuração [CFG_DMPMVP] = Configurar um motivo.',['&Ok']);
        Result := False;
      End;

      If Result And fFindCfg('CFG_CTESPV') And (FieldByName('SIS_VALCFG').AsString = 'S') Then
      Begin
        fMensagem('','Para usar a configuração [CFG_REAVPD] verifique a configuração [CFG_CTESPV] = NÃO.',['&Ok']);
        Result := False;
      End;

      If Result And fFindCfg('CFG_UTIPEN') And (FieldByName('SIS_VALCFG').AsString = 'S') Then
      Begin
        fMensagem('','Para usar a configuração [CFG_REAVPD] verifique a configuração [CFG_UTIPEN] = NÃO.',['&Ok']);
        Result := False;
      End;

      If Result And fFindCfg('CFG_TIPEXP') And (not (Pos(cdsCfgSis.FieldByName('SIS_VALCFG').AsString, '3_4_') > 0)) Then
      Begin
        fMensagem('','Para usar a configuração [CFG_REAVPD] verifique a configuração [CFG_TIPEXP] = 3 ou 4.',['&Ok']);
        Result := False;
      End;
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaVCPPRO: Boolean;
begin

  Result := True;

  With cdsCfgSis Do
  Begin

    If (fFindCfg('CFG_VCPPRO') And (FieldByName('SIS_VALCFG').AsString = 'S')) Then
    Begin

      If (fFindCfg('CFG_PRZPRO') And (FieldByName('SIS_VALCFG').AsString = 'N')) Then
      Begin
        pMensagemOk('Para utilizar a configuração [VCPPRO] é preciso habilitar a configuração [PRZPRO]!');
        Exit(False);
      End;

      If (fFindCfg('CFG_CNDVEN') And (FieldByName('SIS_VALCFG').AsString <> 'I')) Then
      Begin
        pMensagemOk('O sistema está configurado para permitir cadastrar promoções vigentes para o mesmo produto se ' +
                    'a condição de pagamento for diferente entre elas (CFG_VCPPRO). Para usar essa configuração, ' +
                    'somente é permitido usar condição de pagamento no início (CFG_CNDVEN).');
        Exit(False);
      End;

    End;

  End;

end;

class function TValidarConfiguracoes.fValidaVEMACS: Boolean;
var
  strUTIVMA: String;
  strVEMACS: String;
begin
  Result := True;

  strUTIVMA := fGetValorConfiguracao('UTIVMA');
  strVEMACS := fGetValorConfiguracao('VEMACS');

  If (strVEMACS = 'S') And (strUTIVMA <> 'S') Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido utilizar a configuração [CFG_VEMACS] = "S" com a [CFG_UTIVMA] = "N", Verifique!', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaTmpevf: Boolean;
Var
  LstrDTPDCR: String;
  LstrTMPEVF: String;
  LstrTR1DES: String;
  LintContador: Integer;
  LblnMarcado: boolean ;
  LblnTodasSelecionadas: boolean ;
begin
  result := False ;

  LstrDTPDCR := '' ;
  if fFindCfg('CFG_DTPDCR') Then
  begin
    LstrDTPDCR := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;
  end ;

  LstrTMPEVF := '' ;
  if fFindCfg('CFG_TMPEVF') Then
  begin
    LstrTMPEVF := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;
  end ;

  LstrTR1DES := '' ;
  if fFindCfg('CFG_TR1DES') Then
  begin
    LstrTR1DES := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;
  end ;

  if LstrDTPDCR = 'S' then
  begin
    LblnMarcado := False ;
    LblnTodasSelecionadas := True ;
    For LintContador := 1 To Length(LstrTMPEVF) Do
    Begin
      If (Copy(LstrTMPEVF, LintContador, 1) = 'S') Then
      Begin
        LblnMarcado := True ;
      End
      else
      begin
        LblnTodasSelecionadas := False ;
      end ;
    End;

    if not LblnMarcado then
    begin
      fMensagem('ATENÇÃO!', 'O sistema está configurado para "Utilizar a data de emissão do pedido para calcular o dia do vencimento das duplicatas ao faturá-lo?(CFG_DTPDCR)."'+#13+
                          'É necessário marcar pelo menos uma das opções na configuração (CFG_TMPEVF).', ['&Ok']);
      exit ;
    end ;

    if (LstrTR1DES = 'N') and (not LblnTodasSelecionadas) then
    begin
      fMensagem('ATENÇÃO!', 'Para remover um dos destinos e assim tratar o vencimento da duplicata ao faturar o pedido, '+
                            'é obrigatório travar para permitir apenas 1 destino no faturamento (Retira/Entrega) (CFG_TR1DES).', ['&Ok']);
      exit ;
    end ;

  end ;
  Result := True;
end;

class function TValidarConfiguracoes.fValidaTPCHFD: Boolean;
begin
  Result := True;

  if (fGetValorConfiguracao('TPCHFD') = 'N') then
    Exit;

  if (fGetValorConfiguracao('OPCCOM') = 'HFD') then
    Exit;

  fMensagem('ATENÇÃO!', 'Para ligar a configuração CFG_TPCHFD a configuração CFG_OPCCOM deve estar na opção "Hierarquia por Faixa de Desconto (menu Comissão por Hierarquia por Faixa de Desconto)" .', ['&Ok']);

  Result := False;
end;

class function TValidarConfiguracoes.fValidaTPLRECeSUGBAN: Boolean;
begin
  If Not ((fGetValorConfiguracao('TPLREC') = 'L') And (fGetValorConfiguracao('SUGBAN') = 'S')) Then
    Exit(True);

  pInformacao('Aguarde, validando as configuração CFG_TPLREC e CFG_SUGBAN!');

  Result := fExisteProcedure('pGeraMapaDistanciaLocalizacaoFisica');
  If Not Result Then
    fMensagem('ATENÇÃO!', 'Não foi encontrada no banco de dados a procedure que gera as melhores sugestões de lotes para um determinado produto!' + #13 +
                          'Entre em contato com a Citel', ['&Ok']);
end;

class function TValidarConfiguracoes.fValidaESPNPC: Boolean;
Var
  strESPNPC : String;
  strAux    : String;
  intIndex  : Integer;
begin
  Result := True;

  strESPNPC := fGetValorConfiguracao('ESPNPC');

  If ((Length(strESPNPC) Mod 2) > 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Na CFG_ESPNPC são permitidas somente as espécies "FF", "DV", "NF" e "IF".', ['&Ok']);
    Exit(False);
  End;

  strAux := '';

  For intIndex := 1 To Length(strESPNPC) Do
  Begin
    strAux := strAux + Copy(strESPNPC, intIndex, 1);

    If (Length(strAux) = 2) Then
    Begin
      If (Not 'FF_DV_NF_IF_'.Contains(strAux)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Espécie "' + strAux + '" inválida na CFG_ESPNPC são permitidas somente as espécies "FF", "DV", "NF" e "IF".', ['&Ok']);
        Exit(False);
      End;

      strAux := '';
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaTRDPCI: Boolean;
var qryConsulta: TUniQuery;
begin
  Result := True;
  If (fFindCfg('CFG_TRDPCI') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
  Begin
    qryConsulta := fCriaQuery;
    Try
      qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM CONEMP WHERE CON_EMPDES = "' + VS_strCodEmp + '" AND CON_CODTEP <> "SIC"');
      qryConsulta.Open;
      IF qryConsulta.FieldByName('QTD').ASInteger > 0 Then
      Begin
        Result := false;
        fMensagem('ATENÇÃO!', 'No cadastro de empresa todas as transferências para esta loja devem estar com o campo "Pr. Transf. não Promoc." igual a "SIC"', ['&Ok']);
        exit ;
      End;

      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM CONEMP WHERE CON_EMPDES = "' + VS_strCodEmp + '" AND CON_TEPPRO <> "SIC"');
      qryConsulta.Open;
      IF qryConsulta.FieldByName('QTD').ASInteger > 0 Then
      Begin
        Result := false;
        fMensagem('ATENÇÃO!', 'No cadastro de empresa todas as transferências para esta loja devem estar com o campo "Pr. Transf. Promoc." igual a "SIC"', ['&Ok']);
        exit ;
      End;

      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM CONEMP WHERE CON_EMPDES = "' + VS_strCodEmp + '" AND CON_TEPDEF <> "SIC"');
      qryConsulta.Open;
      IF qryConsulta.FieldByName('QTD').ASInteger > 0 Then
      Begin
        Result := false;
        fMensagem('ATENÇÃO!', 'No cadastro de empresa todas as transferências para esta loja devem estar com o campo "Pr. Transf. Dep. fechado." igual a "SIC"', ['&Ok']);
        exit ;
      End;
    Finally
      FreeAndNil(qryConsulta)
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaESP_AD: Boolean;
begin
  Result := True;

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_ESP_AD') And (FieldByName('SIS_VALCFG').AsString = 'S')) And
       (fFindCfg('CFG_UTI_AD') And (FieldByName('SIS_VALCFG').AsString = 'N')) Then
    Begin
      pMensagemOk('Para utilizar a configuração [ESP_AD] habilite a configuração [UTI_AD]!');
      Result := False;
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaEXFPFF: Boolean;
begin
  Result := True;

  if (fGetValorConfiguracao('EXFPFF') = 'S') And (fGetValorConfiguracao('PREMFF') = 'N') then
  begin
    pMensagemOk('Atenção! Não é possível emitir apenas FF no faturamento parcial pela expedição porque a configuração "CFG_PREMFF - Permitir emissão de FF - Faturamento Futuro?" está desligada. Por favor, entre em contato com a citel.');
    Result := False;
  end;
end;

class function TValidarConfiguracoes.fValidaEXLEND: Boolean;
var
  strEXLEND: String;
  strUTIWMS: String;
  strTIPEXP: String;
  strTPLREC: String;
begin
  Result := True;

  strEXLEND := fGetValorConfiguracao('EXLEND');
  strUTIWMS := fGetValorConfiguracao('UTIWMS');
  strTIPEXP := fGetValorConfiguracao('TIPEXP');
  strTPLREC := fGetValorConfiguracao('TPLREC');

  If (strEXLEND = 'S') And ((strUTIWMS <> 'S') Or (strTIPEXP <> '4') Or (strTPLREC <> 'C')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração CFG_EXLEND = Sim, o sistema deverá estar utilizando as ' +
      'configurações CFG_UTIWMS = SIM, CFG_TIPEXP = PEDIDO , CFG_TPLREC = R/C', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fAgendaDesligamentoDaCFG_ENTEND(var blnCancelouEdicao: Boolean): Boolean;
begin
  Result := False;
  If (fFindCfg('CFG_ENTEND')) And
     (fCfgSis('ENTEND', VarString) = 'S') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
  Begin
    If fTemSaldoParaEnderecamento then
    Begin
      Result := fPergunta('Para desligar esta configuração, o Sistema irá baixar todos os pedidos de endereçamento ' +
                          'que estão pendentes. Confirma que realmente quer desligá-la ?', False);
      If not Result Then
      Begin
        cdsCfgSis.Edit;
        cdsCfgSis.FieldByName('SIS_VALCFG').AsString := 'S';
        cdsCfgSis.Post;
        blnCancelouEdicao := True;
      End;
    End;
  End
end;

class function TValidarConfiguracoes.fValidaDICMFR: Boolean;
begin
  Result := True;
  if (fGetValorConfiguracao('FREMED') = 'N') And
     (fGetValorConfiguracao('DICMFR') = 'S') Then
  begin
      pMensagemOk('Atenção, A Configuração [CFG_DICMFR - Deduzir ICMS do frete para cálculo do preço médio?] esta ativa, '+#13+
                  'então a configuração [CFG_FREMED - Somar frete no preço médio?] também deve estar ativa!');
      Result := False;
  end;
end;

class function TValidarConfiguracoes.fValidaEnotas: Boolean;
begin
  Result := True;
  if fGetValorConfiguracao('NFSENO') = 'S' then
  begin
    If (pos('homo', fGetValorConfiguracao('CITURL')) > 0) Then
    Begin
      pMensagemOk('Atenção, nota de serviço eNotas só funciona em ambiente de produção.'+#13+
                  'Para utilizar a configuração [CFG_NFSENO] é necessário ajustar a configuração [CFG_CITURL]!');
      Result := False;
    End;

    If ((fFindCfg('CFG_CSC_ID')) And  (fCfgSis('CSC_ID') <> cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Or
       ((fFindCfg('CFG_CSC_CD')) And  (fCfgSis('CSC_CD') <> cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Or
       ((fFindCfg('CFG_UAPENO')) And  (fCfgSis('UAPENO') <> cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Or
       ((fFindCfg('CFG_SAPENO')) And  (fCfgSis('SAPENO') <> cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Or
       ((fFindCfg('CFG_TKNENO')) And  (fCfgSis('TKNENO') <> cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    Begin
      fMensagem('ATENÇÃO', 'Para efetivar as configurações que forma modificadas é necessário ir no cadastro de empresas e transmitir para o eNotas!'+#13+
                           'Após pesquisar a empresa use os botões [eNotas], [Alterar] e [Gravar].', ['&Ok']);
    End;
  end;
end;

class function TValidarConfiguracoes.fValidaENPAFR: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração CFG_ENPAFR!');

  If fGetValorConfiguracao('ENPAFR') <> 'S' Then
    Exit;

  Result := (fCampoTabela('COUNT(1)', 'ENPAFR', ['END_CODEMP', 'END_ENDPAD'], [VS_strCodEmp, 'S']) > 0);

  If Not Result Then
    pMensagemOk('Para habilitar a CFG_ENPAFR, deve haver ao menos um endereço cadastrado na CFG_SELEPF!');
end;

class function TValidarConfiguracoes.fValidaENVCTT: Boolean;
begin
  pInformacao('Aguarde, validando configuração CFG_ENVCTT!');

  Result := fGetValorConfiguracao('ENVCTT') = 'N';

  If not Result Then
  Begin
    Result := fGetValorConfiguracao('UTIWPP') = 'S';

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO', 'Para utilizar a configuração CFG_ENVCTT, a configuração CFG_UTIWPP deve estar ativada!', ['&Ok']);
      Exit;
    End;

  End;
end;

class function TValidarConfiguracoes.fValidaArmazemNoCaixaParaBaixarEstoqueF3: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de vincular Armazém no Caixa para baixa de estoque do [F3] - CHECKOUT!');

  If ((fFindCfg('CFG_VINAF3')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
      (((fFindCfg('CFG_CTLEST')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> '2'))  Or
      ((fFindCfg('CFG_TPFCCX')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> 'C'))) Then
  Begin
    pMensagemOk('Atenção, só é permitido a ativação da configuração "CFG_VINAF3" se [CFG_CTLEST = Por armazém] e [CFG_TPFCCX = Caixas]!');
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaAtivacaoAncora: Boolean;
begin
  Result := True;

  If ((fGetValorConfiguracao('HABCBA'))  = 'S') then
  Begin
    If (fGetValorConfiguracao('ANCTOK') = '') Then
    begin
      fMensagem('ATENÇÃO!', 'Não é permitida habiltar consulta Ancora sem definir o token [CFG_ANCTOK]. Verifique!', ['&Ok']);
      Result := False;
    End;
    If (fGetValorConfiguracao('ANCURL') = '') Then
    begin
      fMensagem('ATENÇÃO!', 'Não é permitida habiltar consulta Ancora sem definir a url [CFG_ANCURL]. Verifique!', ['&Ok']);
      Result := False;
    End;
  End

end;

class function TValidarConfiguracoes.fValidaFIOCDV: Boolean;
begin
  Result := False;

  If (fGetValorConfiguracao('FINROM') = 'S') And
     (fGetValorConfiguracao('DEVROM') = '5') And
     (fGetValorConfiguracao('FIOCDV') = 'N') Then
  begin
    fMensagem('ATENÇÃO!', 'Para utilizar as configurações [CFG_FINROM = "SIM"] E '+
      '[CFG_DEVROM = 5], precisa ativar a [CFG_FIOCDV].', ['&Ok']);
    Exit;
  end;

  Result := True;
end;

class function TValidarConfiguracoes.fValidaBEACCS: Boolean;
begin
  Result := False;
  If (fGetValorConfiguracao('BEACCS') = '2') Then
  Begin
    If (fGetValorConfiguracao('TIPEXP') <> '4') Then
    begin
      fMensagem('ATENÇÃO!', 'Para utilizar as configurações [BEACCS = "2"] A  '+
        '[TIPEXP] precisa ser 4', ['&Ok']);
      Exit;
    end;
    If (fGetValorConfiguracao('UTIWMS') = 'S') Then
    Begin
      fMensagem('ATENÇÃO!', 'Para utilizar as configurações [BEACCS = "2"] A  '+
        '[UTIWMS] precisa ser "Não"', ['&Ok']);
      Exit;
    end;
  End;
  Result := True;
end;

class function TValidarConfiguracoes.fValidaBEFAMB: Boolean;
begin
  Result := False;

  If (fGetValorConfiguracao('BEFAMB') = 'S') And
     (fGetValorConfiguracao('UTIDEF') = 'N') Then
  begin
    fMensagem('ATENÇÃO!', 'Para ativar a configuração "CFG_BEFAMB", as configurações '+
      '"CFG_UTIDEF" e "CFG_FATCOM" precisam estar ativadas.', ['&Ok']);
    Exit;
  end;

  Result := True;
end;

class function TValidarConfiguracoes.fValidaZFMCST: Boolean;
var
  LZfmCst: String;
begin
  Result := False;

  LZfmCst := fTransform(fGetValorConfiguracao('ZFMCST'), 1);

  If not (pos('6', LZfmCst) > 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'CST iniciando com 6 é obrigatório na configuração "CFG_ZFMCST".', ['&Ok']);
    Exit;
  End;

  If not (pos('7', LZfmCst) > 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'CST iniciando com 7 é obrigatório na configuração "CFG_ZFMCST".', ['&Ok']);
    Exit;
  End;

  Result := True;
end;

class function TValidarConfiguracoes.fValidaCFG_ONDAGR: Boolean;
  var
    LLigouOndaSeparacao,
    LLigouOndaAgrupamento,
    LLigouOndaWMS,
    LLigouWMS : Boolean;
begin

  Result := True;

  pInformacao('Aguarde, validando configuração CFG_ONDAGR!');

  LLigouOndaSeparacao   := (fFindCfg('CFG_ONDASE') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S'));
  LLigouOndaAgrupamento := (fFindCfg('CFG_ONDAGR') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S'));
  LLigouOndaWMS         := (fFindCfg('CFG_ONDWMS') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S'));
  LLigouWMS             := (fCfgSis('UTIWMS', varString) = 'S');

  If Not LLigouOndaAgrupamento Then
    Exit;

  If Not LLigouOndaSeparacao Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_ONDAGR], a [CFG_ONDASE] deve estar ligada!', ['&Ok']);
    Exit(False);
  End;

  If Not LLigouOndaWMS Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_ONDAGR], a [CFG_ONDWMS] deve estar ligada!', ['&Ok']);
    Exit(False);
  End;

  If Not LLigouWMS Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_ONDAGR], a [CFG_UTIWMS] deve estar ligada!', ['&Ok']);
    Exit(False);
  End;

end;

class function TValidarConfiguracoes.fValidaCFG_PLAAUT: Boolean;
begin
  Result := True;
  If (fFindCfg('CFG_PLAAUT') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> 'S')) Then
    Exit;

  If (fFindCfg('CFG_TPLREC') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> 'C')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_PLAAUT], a [CFG_TPLREC] tem que ser "Mapeamento da Classe de Local!"', ['&Ok']);
    Result := False;
  End;


  If (fFindCfg('CFG_WMSPLA') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> 'R')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_PLAAUT], a [CFG_WMSPLA] tem que ser "Após o recebimento do caminhão na portaria!"', ['&Ok']);
    Result := False;
  End;

  If (fFindCfg('CFG_CLAPLA') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = '')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_PLAAUT], a [CFG_CLAPLA] tem que ser definida!', ['&Ok']);
    Result := False;
  End;


end;

class function TValidarConfiguracoes.fValidaCFG_PLAROT: Boolean;
begin
  Result := True;

  If (fFindCfg('CFG_MATDIS')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> 'S') Then
    Exit;

  If (fFindCfg('CFG_APIROT')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'GOOGLE') Then
  Begin
    If (fFindCfg('CFG_PLAROT')) Then
    Begin
      cdsCfgSis.Edit;
      cdsCfgSis.FieldByName('SIS_VALCFG').AsString := AnsiReplaceStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString, '0_', '');
      cdsCfgSis.Post;
    End;
  End;

  If (fFindCfg('CFG_PLAROT')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO!', 'Informe ao menos uma opção para o planejamento da rota! [CFG_PLAROT]', ['&Ok']);
  End;
end;

class function TValidarConfiguracoes.fValidaCFG_PORCDR: Boolean;
begin
  Result := True;

  If (fFindCfg('CFG_PORCDR') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
  Begin
    If (fFindCfg('CFG_PORPED') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
      Result := False;

    If (fFindCfg('CFG_ALPTBL') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')) Then
      Result := False;
  End;

  If (Not Result) Then
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_PORCDR], [CFG_PORPED] deve ser "Não" e [CFG_ALPTBL] deve ser "Sim"!', ['&Ok']);
end;

class function TValidarConfiguracoes.fValidaCFG_PROCND: Boolean;
begin
  Result := False;

  If (fGetValorConfiguracao('PROCND') = 'M') And
     (fGetValorConfiguracao('CNDVEN') <> 'I') Then
  begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração "CFG_PROCND", na opção "Manualmente no "Fechamento com Desconto - CTRL+F10"", a configuração '+
      '"CFG_CNDVEN" precisa estar configurada no inicio.', ['&Ok']);
    Exit;
  end;

  Result := True;
end;

class function TValidarConfiguracoes.fValidouDevolucaoEspelhoComAlteracaoDePreco: Boolean;
begin
  Result := True;
  If (fFindCfg('CFG_ESPDEV') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
  Begin
    If (fFindCfg('CFG_PREDEV') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'Quando configurado para espelhar os valores da nota original:' + sLineBreak +
                            '( CFG_ESPDEV = S )' + sLineBreak +
                            'Não podemos permitir alterações de valor ao realizar a devolução:' + sLineBreak +
                            '( CFG_PREDEV = S )' + sLineBreak +
                            'Favor adequar uma das configurações para prosseguir com a gravação!', ['&Ok']);
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaSmsMKOM: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configurações de SMS - MKOM!');

  If ((fFindCfg('CFG_SMSMKM')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
  Begin
    If (fFindCfg('CFG_TOKMKM')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Ao habilitar a [CFG_SMSMKM] é necessário informar a [CFG_TOKMKM]. Verifique!', ['&Ok']);
      Result := False;
      Exit;
    End
    Else If (fFindCfg('CFG_CCUMKM')) And (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Ao habilitar a [CFG_SMSMKM] é necessário informar a [CFG_CCUMKM]. Verifique!', ['&Ok']);
      Result := False;
      Exit;
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaSOLOLA: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_SOLOLA!');

  If (fFindCfg('CFG_SOLOLA')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
  Begin
    If (fGetValorConfiguracao('UTIWMS') = 'S') And
       ((fFindCfg('CFG_GDPDCN')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Quando utilizar a configuração "CFG_SOLOLA" como SIM, deve-se configurar a "CFG_GDPDCN" como SIM caso a "CFG_UTIWMS" estiver habilitada.', ['&OK']);
      Result := False;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaSIMHIB: Boolean;
begin
  Result := True;

  if (fGetValorConfiguracao('SIMHIB') = 'S') and (fGetValorConfiguracao('SIMPAU') <> 'S') then
  begin
    fMensagem('ATENÇÃO!', 'O Regime Híbrido [CFG_SIMHIB] aplica-se somente a empresas optantes pelo Simples Nacional.' + #13 +
                          'Esta empresa não está enquadrada como optante em [CFG_SIMPAU], portanto [CFG_SIMHIB] deve permanecer como "N".', ['&Ok']);
    Result := False;
  end;
end;

class function TValidarConfiguracoes.fValidaSONCEE: Boolean;
begin
  Result := False;

  If (fGetValorConfiguracao('SONCEE') = '1') And
     (fGetValorConfiguracao('NUMSER') = 'N') Then
  begin
    fMensagem('ATENÇÃO!', 'Quando utilizar a configuração "CFG_SONCEE" como CONFERÊNCIA DE ENTRADA, deve-se configurar a "CFG_NUMSER" como SIM.', ['&Ok']);
    Exit;
  end;

  Result := True;
end;

class function TValidarConfiguracoes.fValidaCFG_ITECNF: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_ITECNF!');

  If (fFindCfg('CFG_USACON') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')) Then
  Begin
    If (fFindCfg('CFG_ITECNF') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_ITECNF], a configuração [CFG_USACON] deve ser = SIM!', ['&Ok']);
      Result := False;
    End;
  End;
end;

{ TValidarConfiguracoes }

class function TValidarConfiguracoes.fValidarConfiguracoes: Boolean;
var
  blnCancelouEdicao: Boolean;
begin
  Result := False;

  If Not fValidaPercentual_0_100('CFG_ALINFS') Then
    Exit;

  If Not fValidaQtdeCasasDecimaisDesconto Then
    Exit;

  If Not fValidaQtdeCasasDecimaisQtdeEntrada Then
    Exit;

  If Not fValidaQtdeCasasDecimaisValorUnitario Then
    Exit;

  If Not fControleEntregaOk Then
    Exit;

  If Not fDefinicaoPorAmbienteOk Then
    Exit;

  If Not fVendaMetroLinearOk Then
    Exit;

  If Not fBonificacaoPedidoOk Then
    Exit;

  If Not fValidaBitribitacaoIPI Then
    Exit;

  If Not ValidaImpressaoAutomaticaBoleto Then
    Exit;

  If (Not fValidaBLNSTE) Then
    Exit;

  If (Not fValidaCfgContele) Then
    Exit;

  If (Not fValidaCFG_FULDIA) Then
    Exit;

  If (Not fValidaCFG_QTDROB) Then
    Exit;

  If (Not fValidaCFG_REMSIM) Then
    Exit;

  If (Not fValidaPermitirConfirmarCupomComContasReceberAgrupadoCFG_PRCFRA) Then
    Exit;

  If Not fValidaCFG_CLIDOC Then
    Exit;

  If Not fValidaCFG_ROTROM Then
    Exit;

  If Not fTabelasUsadasFaturamentoOk Then
    Exit;

  If Not fTabelasUsadasConsultaPrecosColetor Then
    Exit;

  If Not fValidaTabVen_TabPrc Then
    Exit;

  If Not fValidaTbpCon_TabPrc Then
    Exit;

  If Not fValidaTabelasPrecoUtilizadas('CFG_TABPAD') Then
    Exit;

  If Not fValidaMargemMinimaPorDocumentoOk Then
    Exit;

  If Not fValidaCortePorEstoqueNoPedidoDeVendaOk Then
    Exit;

  If Not fValidaCorteDePedidoSemEstoqueOk Then
    Exit;

  If Not fValidaPortadorSenha2QuandoMeiaNotaESeparaFinanceiroOk Then
    Exit;

  If Not fVerificaSeMudouOModoDeAcrescimoEDescontoNoCupom Then
    Exit;

  if not fValidaSistemaEstoqueForaLojaOk then
    Exit;

  if not fValidaCfgLoteSeparacaoParcial Then
    Exit;

  if not fValidaUsarExpedicaoConferenciaRetiraCaixa then
    Exit;

  If not fValidaCFG_PLAAUT then
   Exit;

  if not fValidaCalculoSaldoParaTrava then
    Exit;

  If Not fMsgRodapeClienteOk Then
    Exit;

  If Not fQtdDiasDtPrevisaoPDOk Then
    Exit;

  If Not fValidaVendaVidroOuMadeira Then
    Exit;

  If Not fValidaAliquotasPisCofins Then
    Exit;

  If Not fValidaConfiguracaoUtilizaRT Then
    Exit;

  If Not fValidaConfiguracaoGravarContasPagarDifalDestino('CFG_DIFCTP') Then
    Exit;

  If Not fValidaConfiguracaoGravarContasPagarDifalDestino('CFG_FCPCTP') Then
    Exit;

  If Not fValidaConfiguracaoNovaTelaFechamentoOrcamentoPedido() Then
    Exit;

  If Not fValidaCFG_MARMOR Then
    Exit;

  If Not fValidaVendasHorario Then
    Exit;

  If Not fValidaConfiguracaoUsaPreRomaneio Then
    Exit;

  If Not fValidaConfiguracoesSintetizacaoConfirmacao Then
    Exit;

  If Not fValidaConfiguracaoJatLog Then
    Exit;

  If Not fValidaPDBaixaEntregaFutura Then
    Exit;

  If Not fINTRPSValido Then
    Exit;

  If Not fValidaConfiguracaoCfg_CupNot Then
    Exit;

  If Not fValidaTabelasPrecoUtilizadas('CFG_TBPSUG') Then
    Exit;

  If Not fValidaTabelasPrecoUtilizadas('CFG_UTAPTB') Then
    Exit;

  If Not fValidaTabelasPrecoUtilizadas('CFG_TABRET') Then
    Exit;

  If Not fValidaTabelasPrecoUtilizadas('CFG_TABENT') Then
    Exit;

  If Not fValidaFreteNFCeCupomFiscal Then
    Exit;

  If not fValidaTriggerPreAlt Then
    Exit;

  If not fValidaRegraDinpar Then
    Exit;

  If Not fTabelaPrecoUtilizadaPelaTintaDeMaquina Then
    Exit;

  If Not fValidaLinhasServico Then
    Exit;

  If Not fItemConsertoEquipamentoOk Then
    Exit;

  If Not fApenasRetiraItemOk Then
    Exit;

  If Not fNumeroArtigoAgronomico Then
    Exit;

  If Not fResponsavelRetencaoNotaServicoValido Then
    Exit;

  If Not fValidaFreDev Then
    Exit;

  If Not fValidaTamanhoCampoMsgNF Then
    Exit;

  If Not fQtdeBox Then
    Exit;

  If Not fValidaTempoCfgImportacaoSiteTablet Then
    Exit;

  If Not fValidaQtdeMsgNFCfg_QtdMsg Then
    Exit;

  If Not fValidaQtdeMsgPDORCfg_QtPdOr Then
    Exit;

  If Not fUtilizaControleGuicheGeral Then
    Exit;

  If Not fUtilizaControleGuicheDestFat Then
    Exit;

  If Not fValidaEditarDescontoEspecial Then
    Exit;

  If Not fValidaLoteEntradaSimplificada Then
    Exit;

  If Not fValidaMargensDeExibicaoNoF4 Then
    Exit;

  If Not fValidaAjusteCartoes Then
    Exit;

  If Not ValidaTransferenciaDeCartoes Then
    Exit;

  If Not ValidaMovimentacaoContaBanco Then
    Exit;

  If Not ValidaDigitosNumeroCheque Then
    Exit;

  If Not fValidaConsertoEquipamentos Then
    Exit;

  If Not fValidaTabImp_TabPrc() Then
    Exit;

  If Not fValidaConfComanda() Then
    Exit;

  If Not fValidaConfAutocenter() Then
    Exit;

  If Not fValidaCfgVerDireitosDeAcessoNaLiberacaoPedidos Then
    Exit;

  If Not fValidaCNPJAutDownNFE Then
    Exit;

  If Not fValidaDigitoLinGruFranq() Then
    Exit;

  If Not fValidaGrupoRiscoCliente() Then
    Exit;

  If Not fSolicitacaoTransfReqCompra() Then
    Exit;

  If Not fValidaAplicaDescConPag() Then
    Exit;

  If Not fValidaLocSepArmzBaixaSep Then
    Exit;

   If Not fValidaAtivacaoAncora Then
     Exit;

  If Not fValidaUtilizarOndaSeparacao Then
    Exit;

  If Not fValidaExpedirFaturarTodos Then
    Exit;

  if not fValidaConfItensPorLocalSeparacao() then
    Exit;

  If Not fValidaSMS() Then
    Exit;

  If Not fValidaMCAT17 Then
    Exit;

  If Not fValidaNumeroSerie_Com_Wms Then
    Exit;

  If Not fValidaNFCeOffLine Then
    Exit;

  if not fValidaQuestFidelidade then
    Exit;

  If Not fValidaSequenciaAgrupamento Then
    Exit;

  If Not fValidaMascaraCentroDeCusto Then
    Exit;

  If Not fValidaUtilizacaoDescMaxVendFaixaQtdeVendida then
    Exit;

  if not fValidaROMPLP then
    Exit;

  If not fValidaPDISIF Then
    Exit;

  If Not fValidaSPOIMP Then
    Exit;

  If Not fValidaTRDPCI Then
    Exit;

  if not fValidaRasInd then
    Exit;

  If Not fValidaDownloadXml Then
    Exit;

  If Not fValidaFreTra Then
    Exit;

  If Not fValidaUtiHor Then
    Exit;

  If Not fValidaVAPICO Then
    Exit;

  If Not fValidaEXFPFF Then
    Exit;

  If Not fValidaIMPLST Then
    Exit;

  If Not fValidaLotBas Then
    Exit;

  If Not fValidarConfiguracoesResumoDeCaixa Then
    Exit;

  if not fValidaDiasEntregaImediata then
    exit;

  If Not fValidaConfigFuncionarios Then
    Exit;

  if not fValidaMandae then
    Exit;

  if not fValidaCFG_CRDCON then
    Exit;

  if not fValidaPromocaoCompostaPorKit then
    Exit;

  if not fValidaCfopSaidaTagDETEXPORT then
    Exit;

  if not fValidaItensParaSintetizacaoDePedido then
    Exit;

  if not fValidaPedidosComCondicoesPagamentoDiferentesExpedicao then
    Exit;

  if not fValidaPedidosComCondicoesPagamentoDiferentesConfirmacaoPedidos then
    Exit;

  If Not fValidaIntegracaoDeSistemaGS1_CNPCadastroNacionalDeProdutos Then
    Exit;

  If Not fValidaCFG_FREDES then
    Exit;

  if not fValidaVALFMC then
    Exit;

  If not fValidaBEACCS Then
    Exit;

  If Not fValidaEmpCarregamento then
    Exit;

  If Not fValidaCondicaoPagamentoPorFaixa then
    Exit;

  If Not fValidaRotinaPrioridadeSaidaEstoque then
    Exit;

  If Not fValidaOpcaoPrecoMedioSemImpostos Then
    Exit;

  If Not ValidaEnvioDeAvisosDeCobranca Then
    Exit;

  If Not ValidaEnvioDeAvisosDeDebitos Then
    Exit;

  If Not fValidaControleCobrancaPaleteConfiguradoCorretamente Then
    Exit;

  if not fValidaFrenet then
    Exit;

  if not fValidaQTDCAR then
    Exit;

  if not fValidaFatorCustoNotaEspecial then
    Exit;

  if not fValidaTIPEXP then
    Exit;

  if not fValidaRMPDPA then
    Exit;

  If not fValidaImpressoraGNRE then
    Exit;

  if not fValidaTmpevf then
    Exit ;

  if not fValidaClaGae then
    Exit;

  if not fValidaClassificacoesFiscaisDevolucaoSimbolicaConsignacao then
    Exit;

  If Not fValidaIntegracaoAlpe Then
    Exit;

  If Not fValidaIntegracaoGryncash Then
    Exit;

  If Not fValidaREGCID Then
    Exit;

  If Not fValidaABADEP Then
    Exit;

  If Not fValidaMultSeparacao Then
    Exit;

  If Not fValidaObrigatoriedadeEmpresaIdentificadora Then
    Exit;

  If Not fValidaDmpOpc Then
    Exit;

  If Not fValidaDmpMvp Then
    Exit;

  if not fValidaUTIWMS then
    exit;

  if not fValidaPICOUT then
    exit;

  if not fValidaEFXTPG then
    Exit;

  if not fValidaTabEqu_TabPrc() then
    Exit;

  if not fValidaSugEqu_TabPrc() then
    Exit;

  if not fValidaUTLSLF then
    exit;

  if not fValidaEFXTPF then
    Exit;

  if not fValidaTERROS then
    Exit;

  if not fValidaQuandoObrigatorioInformarProfissionalNoCadClientes then
    Exit;

  if Not fValidaFormaPagtoNegociadaAutoAtendimentoPagueFacil then
    Exit;

  if Not fValidaCartaoGenericoPagueFacil then
    Exit;

  if Not fValidaEspecieDocPerfilCondPagto then
    Exit;

  if not fValidaConfiguracaoNotaComplementarCLANCO then
    Exit;

  pInformacao('Aguarde, validando parametros da contabilidade!');

  If blnAdicionarConfigDuranteValidacao Then
    pAddGrupoConfigDataSet('CONTABILIDADE', VS_strCodEmp);

  if Not TCfgRepositorioContabilidade.fValidarParametros(cdsCfgSis) then
    Exit;

  if not ValidaFormaPadraoEnvioLinkPagamento then
    Exit;

  if not fValidaAppEntrega then
    Exit;

  If Not ValidaConfiguracaoPix then
    Exit;

  If Not ValidaCasasDecimaisMora Then
    Exit;

  if not fValidaTefCitel then
    Exit ;

  If Not ValidaConfiguracaoValorToleranciaConciliacaoCartao Then
    Exit;

  If Not ValidaConfiguracaoNoFechamentoCaixaZerarSaldoDinheiro Then
    Exit;

  If Not ValidaConfiguracaoTFOrdemPagamentoAnalitica Then
    Exit;

  If not fValidaDescricaoCampoPercentual Then
    Exit;

  If not fValidaReaproveitamentoVendasPerdidas Then
    Exit;

  If Not fValidaVCPPRO then
    Exit;

  blnCancelouEdicao := False;

  blnBaixaPedidosEnderecamento := fAgendaDesligamentoDaCFG_ENTEND(blnCancelouEdicao);

  If blnCancelouEdicao Then
    Exit;

  if not fValidaGeraLinkPagamentoCitel then
    Exit;

  if not fValidaIntegracaoContabilidadeDigital then
    Exit;

  if not fValidaNovaFormaCadCartaoTef then
    Exit ;

  If Not fValidaQuantidadeRecorrenciaOcorrencias Then
    Exit;

  if not fValidaESP_AD then
    Exit;

  if not fValidaPedidoComplementarParaCliente then
    Exit;

  if not fValidaUTITDE then
    Exit;

  if not fValidaOPLORE then
    Exit;

  If Not ValidaConfiguracaoAutenticacaoTransferenciasRcx Then
    Exit;

  If Not ValidaConfiguracaoTransferenciasRcxOrdemPagamento Then
    Exit;

  If Not ValidaQuantidadeMaximaRoboExtratoCobranca Then
    Exit;

  if not fValidaFORPAT then
    Exit;

  If Not fValidaEnotas Then
    Exit;

  If Not fValidaArmazemNoCaixaParaBaixarEstoqueF3 Then
    Exit;

  If Not fValidaDICMFR Then
    Exit;

  if not fValidaUTI_RE then
    Exit;

  if not fValidaUTIRE2 then
    Exit;

  If (Not fValidaResumoExpedicao) Then
    Exit;

  If Not fValidaCFG_ALITPR Then
    Exit;

  If Not fValidaCFG_CLACDT Then
    Exit;

  If Not fValidaCfgLayPad Then
    Exit;

  If Not fValidaADTLIB Then
    Exit;

  If (Not fValidaGROPWS) Then
    Exit;

  If (Not fValidaVALWMS) Then
    Exit;

  If (Not fValidaESPNPC) Then
    Exit;

  If (Not fValidaTABPCV) Then
    Exit;

  If (Not fValidaUtilizacaoRestricaoVendaProduto) Then
    Exit;

  If (Not fValidaENVCTT) then
    Exit;

  If (Not fValidaIntegracaoAlpeKonekt) Then
    Exit;

  If (Not fValidaCFG_FTPDEX) then
    Exit;

  If (Not fValidaCFG_QTMICR) then
    Exit;

  If (Not fValidaTagsCampoVendedorFornecedorTigre) then
    Exit;

  If (Not fValidaSugestaoLocalRetira) then
    Exit;

  If (Not fValidaRETGOS) Then
    Exit;

  If (Not(fValidaPDRCTR)) Then
    Exit;

  If (Not(fValidaMPRORI)) Then
    Exit;

  If (Not(fValidaLOCDEC)) Then
    Exit;

  If (Not fValidaTXAUTI) Then
    Exit;

  If (Not fValidaTBCNPR) Then
    Exit;

  if (Not fValidaFLXSEP) then
    Exit;

  If (Not fValidaFIOCDV) then
    Exit;

  If (Not fValidaBEFAMB) Then
    Exit;

  If (Not fValidaBEACCS) Then
    Exit;

  If (Not fValidaZFMCST) Then
    Exit;

  If (Not fValidaCFG_ONDAGR) Then
    Exit;

  If (Not fValidaEXLEND) Then
    Exit;

  If (Not fValidaVEMACS) Then
    Exit;

  If (Not fValidaFATCNS) Then
    Exit;

  If (Not fValidaSUGCAP) Then
    Exit;

  If (Not fValidaDFPSSL) Then
    Exit;

  If (Not fValidaTPLRECeSUGBAN) Then
    Exit;

  If (Not fValidaCFG_PORCDR) Then
    Exit;

  If (Not fValidaCFG_CCRF11) Then
    Exit;

  If (Not fValidaCFG_PROCND) Then
    Exit;

  If (Not fPermiteDesabilitarConfiguracaoCFG_HBFPRC) Then
    Exit;

  If (Not fValidaSmsMKOM) Then
    Exit;

  If (Not fValidaCONEFE) Then
    Exit;

  If (Not fValidaUTIFNS) Then
    Exit;

  If (Not fValidaUTIRRD) Then
    Exit;

  If (Not fValidouDevolucaoEspelhoComAlteracaoDePreco) Then
    Exit;

  If (Not fValidaENITCN) Then
    Exit;

  if (Not fValidaCFG_VVCSDV) then
    Exit;

  If (Not fValidaINFDIE) Then
    Exit;

  If Not fValidaLMENDV Then
    Exit;

  If (Not fValidaCFG_SEPITE) Then
    Exit;

  If (Not fValidaCFG_CLPVDI) Then
    Exit;

  If (Not fValidaCFG_SEPFAT) Then
    Exit;

  If (Not fValidaCFG_PLAROT) Then
    Exit;

  If (Not fValidaCFG_ITECNF) Then
    Exit;

  If (Not fValidaCFG_RCPCNE) Then
    Exit;

  If (Not fValidaCFG_RCPCCR) Then
    Exit;

  If (Not fValidaCFG_BFSGIS) Then
    Exit;

  If (Not fValidaRATEST) Then
    Exit;

  If (Not fValidaTPCHFD) Then
    Exit;

  If (Not fValidaIntegracaoDataFrete) Then
    Exit;

  If (Not fValidaDASWEB()) Then
    Exit;

  If (Not fValidaSPCDEN()) Then
    Exit;

  If (Not fValidaPTCCKO) Then
    Exit;

  If (Not fValidaIDVCPR) Then
    Exit;

  If (Not fValidaOSGLCP) Then
    Exit;

  If (Not fValidaHABREA) Then
    Exit;

  If (Not fValidaGONDOL) Then
    Exit;

  If (Not fValidarIMPCPD) Then
    Exit;

  If (Not fValidaCENDNE) Then
    Exit;

  If (Not fValidaLSEWMS) Then
    Exit;

  If (Not fValidaSOLOLA) Then
    Exit;

  If (Not fValidaTabelaDePrecoHubTBPCLI) Then
    Exit;

  If (Not fValidaTabelaDePrecoHubTABPRE) Then
    Exit;

  If (Not fValidaCORDCL) Then
    Exit;

  If (Not fValidaPEPFIM) Then
    Exit;

  If (Not fValidaMUNINC) Then
    Exit;

  If (Not fValidaSONCEE) Then
    Exit;

  If (Not fValidaENDAUT) Then
    Exit;

  If (Not fValidaINVCRI) Then
    Exit;

  If (Not fValidaPRQSEC) Then
    Exit;

  If (Not fValidaSUPSEP) Then
    Exit;

  If (Not fValidaUTILLC) Then
    Exit;

  if Not fValidaEMSRCS Then
    Exit;

  If not fValidaIMPXGR Then
    Exit;

  If (Not fValidaENPAFR) Then
    Exit;

  if Not fValidaENDPRO Then
    Exit;

  If (Not fValidaUGPDTE) Then
    Exit;

  If (Not fValidaIntegracaoIntelipost) Then
    Exit;

  if Not fValidaCFGCANEND Then
    Exit;

  If Not fPagarMeRecebiveisOk Then
    Exit;

  If Not fValidaSIMHIB Then
    Exit;

  If Not fValidaCDPHAB_CDPURL_CDPAPK Then
    Exit;

  If Not fValidaCOFTRA Then
    Exit;

  If (Not fValidaDVTBCR) Then
    Exit;

  If (Not fValidaPROCTR) Then
    Exit;

  If (Not fValidaAGDPIF) Then
    Exit;

  If Not fValidaOBRLPK Then
    Exit;

  If Not fValidaUSALAL Then
    Exit;

  If Not fValidaUTSCNF Then
    Exit;

  If Not fValidaPMVCSH Then
    Exit;

  If Not fValidaCBKUTI Then
    Exit;

  If Not fValidaPMEVMN Then
    Exit;

  If (Not fValidaCDCRNV) Then
    Exit;

  If (Not fValidaCONLAR) Then
    Exit;

  If (Not fValidaAUTSEP) Then
    Exit;

  If (Not fValidaFORDCE) Then
    Exit;

  If (Not fValidaCEDVDF) Then
    Exit;

  If (Not fValidaDIMPF4) Then
    Exit;

  If (Not fValidaICMSEP) Then
    Exit;

  If (Not fValidaETICON) Then
    Exit;

  If (Not fValidaALTVMT) Then
    Exit;

  If Not fValidaDVECSH Then
    Exit;

  If (Not ValidarSegundosTimerRoboGatilhosImediatos) Then
    Exit;

  If (Not fValidaGERTRF) Then
    Exit;

  If (Not fValidaEtqConWmsPlaTplRec) Then
    Exit;

  If Not fValidaGATOPE Then
    Exit;

  If Not fValidaSEPLCS Then
    Exit;

  If Not fValidaDVSPCL Then
    Exit;

  pVerificaSeMudouAOpcaoDeMFDLocal;

  If Not fValidaEXCLOR Then
    Exit;

  pVeSeAtualizaSaldoPedidoCompra;
  pVeSeAtualizarComissaoProfissionais;
  pAvisoYapay;

  Result := True;
end;

class procedure TValidarConfiguracoes.pInformacao(strInfo: String; blnExibir: Boolean = True);
begin
  lblInformacao.Visible := blnExibir;
  lblInformacao.Caption := strInfo;
  Application.ProcessMessages;
end;

class procedure TValidarConfiguracoes.pNormalizaDadosAlteracaoROMPLP;
begin
  If (TValidarConfiguracoes.fFindCfg('CFG_ROMPLP')) Then
    If (VarToStr(cdsCfgSis.FieldByName('SIS_VALCFG').Value) <> fCfgSis('ROMPLP', varString)) Then
      pNormalizaDadosParaAlteracaoROMPLP(cdsCfgSis.FieldByName('SIS_VALCFG').Value = 'S');
end;

class function TValidarConfiguracoes.fApenasRetiraItemOk: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração "Utilizar controle de destino "Apenas Retira" no Cadastro de Produtos"!');

  With cdsCfgSis Do
  Begin
    If ((fFindCfg('CFG_APERET')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S'))   And
       (((fFindCfg('CFG_TR1DES')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S'))  Or
        ((fFindCfg('CFG_ENTFAT')) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N'))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Para utilizar a configuração "CFG_APERET" as configurações "CFG_TR1DES" precisa estar igual a NÃO e a "CFG_ENTFAT" precisar estar igual a SIM!', ['&Ok']);
      Result := False;
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaResumoExpedicao: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração CFG_RESEXP!');

  If (fGetValorConfiguracao('RESEXP') = 'S') Then
  Begin
    If (Not (fGetValorConfiguracao('TIPEXP') = '4')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Com a configuração (CFG_RESEXP = S), a configuração (CFG_TIPEXP) deve ser = "4 - Pedido"!', ['&Ok']);
      Result := False;
    End;
  End;
end;

class procedure TValidarConfiguracoes.pVeSeAtualizarComissaoProfissionais;
begin
  blnAtualizarComissaoProfissionais := False;
  If fFindCfg('CFG_DIVCOM') And (fCfgSiS('DIVCOM') <> cdsCfgSis.FieldByName('SIS_VALCFG').AsString) And (fCfgSiS('DIVCOM') = '1') Then
     blnAtualizarComissaoProfissionais := fPergunta('A configuração da comissão do Cadastro de Diversos foi alterada para obter o '+
      'percentual a partir do Cadastro de Atividades. Deseja atualizar automaticamente a comissão de todos os profissionais?');
end;

class procedure TValidarConfiguracoes.pVeSeAtualizaSaldoPedidoCompra;
Begin
  blnAtualizarSaldoPedido := (fFindCfg('CFG_LIBPCM')) And (fCfgSiS('LIBPCM') <> cdsCfgSis.FieldByName('SIS_VALCFG').AsString);
End;

class procedure TValidarConfiguracoes.pVerificaSeMudouAOpcaoDeMFDLocal;
  Var
    blnMudou: Boolean;
begin
  With cdsCfgSis Do
  Begin
    blnMudou := (fFindCfg('CFG_MFDLOC')) And
                (fCfgSiS('MFDLOC') <> cdsCfgSis.FieldByName('SIS_VALCFG').AsString) And
                (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S');

    If blnMudou Then
      fMensagem('ATENÇÃO!', 'Foi ativada a configuração para extrair o espelho da MFD localmente. ' +
        'Por favor realize uma importação de redução Z (qualquer período) para validar a rotina.', ['&Ok']);
  End;
end;

class procedure TValidarConfiguracoes.pDecriptarConfiguracoes;
begin
  TValidarConfiguracoes.pDcryptChaves(cdsCfgSis);
  pDecriptarConfiguracao('CFG_KEYENO', cdsCfgSis);
  pDecriptarConfiguracao('CFG_SNHSAN', cdsCfgSis);
end;

class procedure TValidarConfiguracoes.pEncriptarConfiguracoes;
begin
  TValidarConfiguracoes.pEcryptChaves(cdsCfgSis);
  pEncriptarConfiguracao('CFG_SNHSAN', cdsCfgSis);
  pEncriptarConfiguracao('CFG_KEYENO', cdsCfgSis);
end;

class function TValidarConfiguracoes.fConfiguracaoEncriptada(AConfiguracao: String): Boolean;
begin
  Result := fEncriptar(fDecriptar(AConfiguracao)).Equals(AConfiguracao);
end;

class procedure TValidarConfiguracoes.pEncriptarConfiguracao(AConfiguracao: String; var DataSet: TUniClientDataSet);
begin
  try
    If DataSet.FindKey([AConfiguracao, VS_strCodEmp]) Then
    Begin
      If Not fConfiguracaoEncriptada(DataSet.FieldByName('SIS_VALCFG').AsString) Then
      Begin
        DataSet.Edit;
        DataSet.FieldByName('SIS_VALCFG').AsString := fEncriptar(DataSet.FieldByName('SIS_VALCFG').AsString);
        DataSet.Post;
      End;
    End;
  Finally
    DataSet.First;
  End;
end;

class procedure TValidarConfiguracoes.pDecriptarConfiguracao(AConfiguracao: String; var DataSet: TUniClientDataSet);
begin
  Try
    If DataSet.FindKey([AConfiguracao, VS_strCodEmp]) Then
    Begin
      If fConfiguracaoEncriptada(DataSet.FieldByName('SIS_VALCFG').AsString) Then
      Begin
        DataSet.Edit;
        DataSet.FieldByName('SIS_VALCFG').AsString := fDecriptar(DataSet.FieldByName('SIS_VALCFG').AsString);
        DataSet.Post;
      End;
    End;
  Finally
    DataSet.First;
  End;
end;

class function TValidarConfiguracoes.ValidaImpressaoAutomaticaBoleto: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configurações de impressão automática de boletos!');

  If fFindCfg('CFG_BOLAUT') Then
  Begin
    If cdsCfgSis.FieldByName('SIS_VALCFG').AsString.Equals('S') Then
    Begin
      Result := False;

      If fFindCfg('CFG_BOLCTR') Then
      Begin
        Result := cdsCfgSis.FieldByName('SIS_VALCFG').AsString.Equals('S');
      End;

    End;
  End;

  If Not Result Then
    fMensagem('ATENÇÃO!', 'O valor da configuração [CFG_BOLAUT] só pode ser "Sim" '+
                          'caso a configuração [CFG_BOLCTR] também esteja igual a "Sim".', ['&Ok']);

end;

class function TValidarConfiguracoes.ValidaModelosDeAvisosDeCobrancaProximoDiaUtil: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := True;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT EMA_CODIGO  ' +
                          'FROM EMASAI ' +
                          '  INNER JOIN MODEMA ON MOD_SEQGER = EMASAI.AUTOINCREM ' +
                          '  INNER JOIN CFGEMA ON CFG_SEQGER = EMASAI.AUTOINCREM ' +
                          '  LEFT  JOIN CADPRV ON PRV_CODPRV = CFG_CODPRV ' +
                          'WHERE EMA_CODGRU="009" ' +
                          '  AND EMA_CODEMP="' + VS_strCodEmp + '" ' +
                          '  AND EMA_STATUS="A" ' +
                          '  AND EMA_ENTSAI="S" ';

    LConsulta.Open;
    LConsulta.Filter := 'EMA_CODIGO <> ''023'' AND EMA_CODIGO <> ''024'' ';
    LConsulta.Filtered := True;

    If Not LConsulta.IsEmpty Then
    Begin
      LConsulta.Filter := 'EMA_CODIGO = ''023'' OR EMA_CODIGO = ''024'' ';
      LConsulta.Filtered := True;

      If LConsulta.RecordCount < 2 Then
        Exit(False);
    End;

    If (fCfgSis('SMSMKM', varBoolean)) Or
       ((Not fEmptyStr(fCfgSis('USRSMS', varString))) And
        (Not fEmptyStr(fCfgSis('SENSMS', varString)))) Then
    Begin
      LConsulta.Filtered := False;
      LConsulta.Close;
      LConsulta.SQL.Text := 'SELECT SMS_CODIGO ' +
                            'FROM SMSSAI ' +
                            'WHERE SMS_CODGRU="009" ' +
                            '  AND SMS_CODEMP="' + VS_strCodEmp + '" ' +
                            '  AND SMS_STATUS="A" ';

      LConsulta.Open;
      LConsulta.Filter := 'SMS_CODIGO <> ''023'' AND SMS_CODIGO <> ''024'' ';
      LConsulta.Filtered := True;

      If Not LConsulta.IsEmpty Then
      Begin
        LConsulta.Filter := 'SMS_CODIGO = ''023'' OR SMS_CODIGO = ''024'' ';
        LConsulta.Filtered := True;

        If LConsulta.RecordCount < 2 Then
          Exit(False);
      End;
    End;

    If fCfgSis('UTIWPP', varBoolean) Then
    Begin
      LConsulta.Filtered := False;
      LConsulta.Close;
      LConsulta.SQL.Text := 'SELECT WPP_CODIGO ' +
                            'FROM WPPSAI ' +
                            'WHERE WPP_CODGRU="009" ' +
                            '  AND WPP_CODEMP="' + VS_strCodEmp + '" ' +
                            '  AND WPP_STATUS="A" ';

      LConsulta.Open;
      LConsulta.Filter := 'WPP_CODIGO <> ''023'' AND WPP_CODIGO <> ''024'' ';
      LConsulta.Filtered := True;

      If Not LConsulta.IsEmpty Then
      Begin
        LConsulta.Filter := 'WPP_CODIGO = ''023'' OR WPP_CODIGO = ''024'' ';
        LConsulta.Filtered := True;

        If LConsulta.RecordCount < 2 Then
          Exit(False);
      End;
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

class function TValidarConfiguracoes.ValidaMovimentacaoContaBanco: Boolean;
  Var
    LDiasTolerancia: String;
begin
  LDiasTolerancia := EmptyStr;

  If fFindCfg('CFG_CTBTOL') Then
    LDiasTolerancia := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;

  Result := Not LDiasTolerancia.Trim.IsEmpty;
  If Result Then
    Result := StrToInt(LDiasTolerancia) >= 0;

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'A CFG_CTBTOL deve ser maior ou igual a zero.', ['&Ok']);

    Exit;
  End;

  fFindCfg('CFG_DTACBH');
  If cdsCfgSis.FieldByName('SIS_VALCFG').AsString.Equals('N') Then
  Begin
    Result := StrToInt(LDiasTolerancia) = 0;

    If Not Result Then
      fMensagem('ATENÇÃO', 'Quando a CFG_DTACBH estiver igual a "Não", a CFG_CTBTOL não pode ser maior que zero.', ['&Ok']);
  End;
end;

class function TValidarConfiguracoes.fValidaCFG_QTDROB: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_QTDROB!');

  If (fFindCfg('CFG_MULROB') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
     (fFindCfg('CFG_QTDROB') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger > 50))Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_MULROB] = SIM a [CFG_QTDROB] não pode exceder a quantidade máxima de 50!', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaCFG_REMSIM: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_REMSIM...');

  If (fFindCfg('CFG_REMSIM') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
     (fFindCfg('CFG_COTSIM') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S'))Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_REMSIM] = SIM a [CFG_COTSIM] não pode estar ativada!', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaBitribitacaoIPI: Boolean;
begin
  pInformacao('Aguarde, validando configurações de IPI...');

  Result := TRUE;

  With cdsCfgSis Do
  If (fFindCfg('CFG_DPCIPU') And (FieldByName('SIS_VALCFG').AsString = 'S')) Then
  Begin
    If (fFindCfg('CFG_IPIPIS') And (FieldByName('SIS_VALCFG').AsString = '2')) Then
    Begin
      Result := FALSE;
      fMensagem('Atenção','Não é permitido utilizar "IMPULT 06 - PIS/COFINS - IPI - Deduzir PIS/COFINS do IPI para cálculo do Pr. Últ. Compra com Imp. de Entrada? (CFG_DPCIPU)" '+
                          'e "IMPULT 10 - PIS/COFINS - Base de cálculo para PIS/COFINS para dedução do Pr.Ult.Compra com Imp.Entrada? (CFG_IPIPIS)" simultaneamente, podendo causar uma bitributação de IPI!',['&Ok']);
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaCfgContele: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configurações Contele!');

  If fFindCfg('CFG_APICON') Then
  Begin
    If cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S' Then
    Begin
      Result := ((Result) And (Not fEmptyStr(fCampoTabela('CON_URLCON', 'APICON', ['CON_CODEMP'], [VS_strCodEmp]))));

      Result := ((Result) And (Not fEmptyStr(fCampoTabela('CON_KEYCON', 'APICON', ['CON_CODEMP'], [VS_strCodEmp]))));

      Result := ((Result) And (Not fEmptyStr(fCampoTabela('CON_AUTCON', 'APICON', ['CON_CODEMP'], [VS_strCodEmp]))));

      If Not Result Then
        fMensagem('ATENÇÃO!', 'Para utilizar a integração com a Contele acesse a CFG_CFGCON e configure a Api!', ['&Ok']);
    End;
  End;
end;


class function TValidarConfiguracoes.fValidaCFG_FULDIA: Boolean;
begin

  Result := True;
  pInformacao('Aguarde, validando configuração CFG_FULDIA!');

  If (fFindCfg('CFG_FULDIA') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger <= 0)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A configuração [CFG_FULDIA] não pode ser definida com valor negativo ou zerado!', ['&Ok']);
    Result := False;
  End;

end;

class function TValidarConfiguracoes.fValidaBLNSTE: Boolean;
begin
  Result := False;

  If (fGetValorConfiguracao('BLNSTE') = 'S') And (fGetValorConfiguracao('NUMSER') = 'N') Then
  Begin
    fMensagem('ATENÇÃO!', 'Para usar a configuração CFG_BLNSTE, a configuração CFG_NUMSER deve estar ligada.', ['&Ok']);
    Exit;
  End;

  Result := True;
end;

class function TValidarConfiguracoes.fValidaPermitirConfirmarCupomComContasReceberAgrupadoCFG_PRCFRA: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_PRCFRA!');

  If (fFindCfg('CFG_PROCTR') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> '1')) And
     (fFindCfg('CFG_PRCFRA') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_PRCFRA] = SIM, a configuração [CFG_PROCTR] deve estar na opção "Manter o Contas a Recever do Cupom Fiscal"!', ['&Ok']);
    Result := False;
  End;
end;


class function TValidarConfiguracoes.fValidaINFDIE: Boolean;
var
  LInfDie: String;
  LCodEmp: String;
begin
  Result := True;

  LInfDie := fTransform(fGetValorConfiguracao('INFDIE'), 3);

  While not LInfDie.IsEmpty Do
  Begin
    LCodEmp := Copy(LInfDie, 1, pos('_', LInfDie) -1);

    If not fEmpresaExiste(LCodEmp) Then
    Begin
      fMensagem('ATENÇÃO!', 'A empresa '+LCodEmp+' é inválida na configuração "CFG_INFDIE".', ['&Ok']);
      Result := False;
      Break;
    End;

    Delete(LInfDie, 1, pos('_', LInfDie));

  End;

end;

class function TValidarConfiguracoes.fValidaCOFTRA: boolean;
var
  srtCOFTRA: String;
  strUTIWMS: String;
  strCONSIM: String;
  strUDEVME: String;
begin
  Result := True;

  srtCOFTRA := fGetValorConfiguracao('COFTRA');
  strUTIWMS := fGetValorConfiguracao('UTIWMS');
  strCONSIM := fGetValorConfiguracao('CONSIM');
  strUDEVME := fGetValorConfiguracao('UDEVME');

  If srtCOFTRA = 'N' Then
    Exit;

  Result := (srtCOFTRA = 'S') And (strUTIWMS = 'N') And (strCONSIM <> 'N') And (strUDEVME = 'S');
  If Not Result Then
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração CFG_COFTRA = Sim, ' +
      'o sistema deverá estar utilizando as configurações CFG_UTIWMS = Não, CFG_CONSIM <> Não e CFG_UDEVME = Sim', ['&Ok']);
end;

class function TValidarConfiguracoes.fValidaDVTBCR: Boolean;
begin
  Result := True;

  If (fFindCfg('CFG_DVTBCR')) And
     (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> 'S') Then
    Exit;

  If (fFindCfg('CFG_DVTBPC')) And
     (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração "CFG_DVTBCR = Devolução de Venda oriunda de site/tablet - '+
              'Gravar Contas a Receber (crédito) baixado?", o Plano de Contas precisa estar preenchido (CFG_DVTBPC).', ['&Ok']);
    Exit(False);
  End;

  If (fFindCfg('CFG_DVTBPB')) And
     (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração "CFG_DVTBCR = Devolução de Venda oriunda de site/tablet - '+
              'Gravar Contas a Receber (crédito) baixado?", o Portador precisa estar preenchido (CFG_DVTBPB).', ['&Ok']);
    Exit(False);
  End;
end;

class function TValidarConfiguracoes.fValidaPROCTR: Boolean;
var
  LPROCTR,
  LUTICON: String;
begin
  Result := True;

  LPROCTR := fGetValorConfiguracao('PROCTR');
  LUTICON := fGetValorConfiguracao('UTICON');

  If (LPROCTR = '2') And
     (LUTICON = 'S') Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido utilizar Contabilidade com a '
                        + 'configuração [CFG_PROCTR] na opção ( 2 ).' + #13#10
                        + 'Confira também a configuracao [CFG_AGDPIF].', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaAGDPIF: Boolean;
var
  LAGDPIF,
  LPROCTR: String;
begin
  Result := True;

  LAGDPIF := fGetValorConfiguracao('AGDPIF');
  LPROCTR := fGetValorConfiguracao('PROCTR');

  If (LPROCTR <> '1') And
     (LAGDPIF = 'S') Then
  Begin
    fMensagem('ATENÇÃO!', 'A configuração [CFG_AGDPIF] só deve ser ativada se a '
                        + 'opção na [CFG_PROCTR] for '
                        + '"[1] Manter o Contas à Receber do Cupom Fiscal"!', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaUSALAL: Boolean;

  procedure pMessageLalaMove(const strProblemas : String);
    Var
      stlList : TStringList;
  begin
    stlList := TStringList.Create;
    Try
      ExtractStrings([#13,#10], [' '], PChar(MESSAGE_CFG_LALAMOVE + strProblemas), stlList);
      fMensagem('ATENÇÃO!', MESSAGE_CFG_LALAMOVE + sLineBreak + strProblemas, ['&Ok'], 1, False, 1, 0, False, 0, False, False, False, 0, 0, stlList.Count + 1);
    Finally
      FreeAndNil(stlList);
    End;
  end;

  procedure pValidouCfg(const strCodCfg : String; const strValorEsperado : String; var strProblemas : String);
  begin
    If (fFindCfg(strCodCfg)) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> strValorEsperado) Then
    Begin
      strProblemas := strProblemas + strCodCfg + sLineBreak;
    End;
  end;

  Var
    strProblemas : String;
begin
  Result := True;
  strProblemas := '';

  pInformacao('Aguarde, validando configuração LALAMOVE!');

  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_USALAL')) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      pValidouCfg('CFG_USALAT', 'S', strProblemas);
      pValidouCfg('CFG_ENPAFR', 'N', strProblemas);
      pValidouCfg('CFG_ITPUTI', 'N', strProblemas);
      pValidouCfg('CFG_DTFUSA', 'N', strProblemas);
      pValidouCfg('CFG_QLPUSA', 'N', strProblemas);
      pValidouCfg('CFG_FREUSA', 'N', strProblemas);
      If (fFindCfg('CFG_LATLON')) And
         (fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)) Then
      Begin
        strProblemas := strProblemas + 'CFG_LATLON' + sLineBreak;
      End;
      If (Not fEmptyStr(strProblemas)) Then
      Begin
        pMessageLalaMove('Ajustar as configurações:' + sLineBreak + strProblemas);
        Result := False;
        Exit;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaUTSCNF: Boolean;
begin
  Result := True;
  pInformacao('Aguarde, validando configuração CFG_UTSCNF!');
  With cdsCfgSis Do
  Begin
    If (fFindCfg('CFG_UTSCNF')) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
    Begin
      If (fFindCfg('CFG_BAISEP')) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
      Begin
        pMensagemOK('Para utilizar a configuração CFG_UTSCNF = S, a configuração CFG_BAISEP deve estar desligada!');
        Result := False;
        Exit;
      End;
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaUDEVME: Boolean;
Var
  LLocalizouCfg : Boolean;
begin
  Result := True;

  If (fFindCfg('CFG_UDEVME')) And
     (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S') Then
  Begin
    LLocalizouCfg := fFindCfg('CFG_QTDEND');
    If (Not LLocalizouCfg) Or
       ((LLocalizouCfg) And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N')) Then
    Begin
      pMensagemOK('Para utilizar a configuração CFG_UDEVME igual a "Sim", a configuração CFG_QTDEND deve estar igual a "Sim"!');
      Result := False;
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaCEDVDF: boolean;
begin
  Result := True;

  If (Not fEmptyStr(fGetValorConfiguracao('CEDVDF'))) And
     (fGetValorConfiguracao('UM1LFL') = 'N') Then
  begin
    fMensagem('ATENÇÃO!', 'Quando a configuração [CFG_UM1LFL] está desabilitada, '
                        + 'é necessário selecionar "Nenhuma opção" na configuração '
                        + '[CFG_CEDVDF].', ['&Ok']);
    Exit(False);
  end;
end;

class function TValidarConfiguracoes.fValidaFORDCE: boolean;
begin
  Result := True;

  If (fGetValorConfiguracao('FORDCE') <> '3') And
     (fGetValorConfiguracao('UM1LFL') = 'N') Then
  begin
    fMensagem('ATENÇÃO!', 'Quando a configuração [CFG_UM1LFL] está desabilitada, '
                        + 'a opção "3" da configuração [CFG_FORDCE] deve ser '
                        + 'selecionada.', ['&Ok']);
    Exit(False);
  end;
end;

class function TValidarConfiguracoes.fValidaCONLAR: boolean;
begin
  Result := True;

  If (fGetValorConfiguracao('CONLAR') = 'S') And
     ((fGetValorConfiguracao('UTIWMS') <> 'S') Or
      (fGetValorConfiguracao('SOLOLA') <> 'S')) Then
  begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_CONLAR], '+
      'as configurações [CFG_UTIWMS] e [CFG_SOLOLA] devem estar ativadas.', ['&Ok']);
    Exit(False);
  end;
end;

class function TValidarConfiguracoes.fValidaETICON: boolean;
begin
  Result := True;

  If (fGetValorConfiguracao('ETICON') = 'S') And
     (fGetValorConfiguracao('ETQCON') <> 'S') Then
  begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_ETICON], '+
      'a configuração [CFG_ETQCON] deve estar ativada.', ['&Ok']);
    Exit(False);
  end;
end;

class function TValidarConfiguracoes.fValidaEtqConWmsPlaTplRec: Boolean;
var
  strETQCON,
  strWMSPLA,
  strTPLREC: String;
begin
  Result := True;

  strETQCON := fGetValorConfiguracao('ETQCON');
  strWMSPLA := fGetValorConfiguracao('WMSPLA');
  strTPLREC := fGetValorConfiguracao('TPLREC');

  If (strETQCON = 'N') And ((strWMSPLA = 'R') and (strTPLREC = 'L')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é possível utilizar Plano por local de Separação (CFG_TPLREC = L) quando: ' + #13#10 +
                          ' CFG_WMSPLA: Após o recebimento do caminhão ' + #13#10+
                          ' CFG_ETQCON: Gerar as etiquetas ID e realizar a preparação para endereçamento junto com a rotina de conferência de entrada? está definida como NÃO!', ['&Ok']);
    Result := False;
  End;
end;

class function TValidarConfiguracoes.fValidaAUTSEP: boolean;
begin
  Result := True;

  If (fGetValorConfiguracao('AUTSEP') = 'S') And
     (fGetValorConfiguracao('FATAUT') <> 'S') Then
  begin
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração [CFG_AUTSEP], '+
      'a configuração [CFG_FATAUT] deve estar ativada.', ['&Ok']);
    Exit(False);
  end;
end;

class function TValidarConfiguracoes.ValidarSegundosTimerRoboGatilhosImediatos: Boolean;
begin

  Result := True;
  pInformacao('Aguarde, validando as configurações do robô de gatilhos imediatos!');

  If fFindCfg('CFG_TMRGAT') Then
  Begin
    If cdsCfgSis.FieldByName('SIS_VALCFG').AsInteger < 120 Then
    Begin
        fMensagem('ATENÇÃO!', 'O intervalo de execução do robô de gatilhos imediatos deve ser de, no mínimo, 120 segundos. [CFG_TMRGAT].', ['&Ok']);
        Exit(False);
    End;
  End;

end;

class function TValidarConfiguracoes.fValidaDVECSH: Boolean;
var
  LDVECSH,
  LCLCCSH,
  LCBKUTI : String;
begin
  Result := True;

  LDVECSH := fGetValorConfiguracao('DVECSH');
  LCLCCSH := fGetValorConfiguracao('CLCCSH');
  LCBKUTI := fGetValorConfiguracao('CBKUTI');

  If LDVECSH = 'N' Then
    Exit;

  If (LCLCCSH = '3') Or
     (LCBKUTI = 'N') Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO!', 'Para utilizar a configuração "CFG_DVECSH", é necessário '
                        + 'habilitar a "CFG_CBKUTI" e escolher uma opção na "CFG_CLCCSH" '
                        + 'diferente de "Código Cliente".', ['&Ok']);
  End;
end;

class function TValidarConfiguracoes.fValidaEXCLOR: Boolean;
begin
  Result := True;

  If Not fFindCfg('CFG_EXCLOR') Then
    Exit;

  If (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'N') Then
    Exit;

  If (fGetValorConfiguracao('UTICON') = 'N') Then
    Exit;

  Result := False;

  fMensagem('ATENÇÃO!', 'Não é permitido habilitar CFG_EXCLOR=S enquanto a empresa utilizar rotina '+
                        'de contabilidade (CFG_UTICON=S).', ['&Ok']);
end;

class function TValidarConfiguracoes.fValidaGERTRF: Boolean;
var
  LstrGERTRF: String;
  LstrUTIWMS: String;
  LstrCONSIM: String;
  LstrENTEND: String;
  LstrUSACON: String;
  LstrCOFTRA: String;
begin
  Result := True;

  LstrGERTRF := fGetValorConfiguracao('GERTRF');
  LstrUTIWMS := fGetValorConfiguracao('UTIWMS');
  LstrCONSIM := fGetValorConfiguracao('CONSIM');
  LstrENTEND := fGetValorConfiguracao('ENTEND');
  LstrUSACON := fGetValorConfiguracao('USACON');
  LstrCOFTRA := fGetValorConfiguracao('COFTRA');

  if LstrGERTRF = 'N' then
    Exit;

  Result := (LstrGERTRF = 'S') and
            (LstrUSACON = 'S') and
            (LstrCONSIM <> 'N') and
            (LstrENTEND = 'N') and
            (LstrUTIWMS = 'N') and
            (LstrCOFTRA = 'N');

  if not Result then
    fMensagem('ATENÇÃO!',
      'Para utilizar a configuração CFG_GERTRF = Sim, o sistema deverá estar configurado da seguinte forma:' + sLineBreak +
      '- CFG_USACON = Sim' + sLineBreak +
      '- CFG_CONSIM <> Não' + sLineBreak +
      '- CFG_ENTEND = Não' + sLineBreak +
      '- CFG_UTIWMS = Não' + sLineBreak +
      '- CFG_COFTRA = Não',
      ['&Ok'], 1, True, 1, 0, False, 0, False, False, False, 300);


end;

class procedure TValidarConfiguracoes.pExpirarSenhaOperadorCFG_EXPSEN;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_EXPSEN' Then
    Exit;

  If cdsCfgSis.FieldByName('SIS_VALCFG').OldValue = cdsCfgSis.FieldByName('SIS_VALCFG').Value Then
    Exit;

  If StrToIntDef(cdsCfgSis.FieldByName('SIS_VALCFG').AsString, 0) > 0 Then
  Begin
    If fMensagem('ATENÇÃO',
      'Deseja marcar todas as senhas atuais como "Expirado"?' + sLineBreak + sLineBreak +
      'Caso marque "SIM"' + sLineBreak +
      'Todas as senhas dos usuários serão expiradas' + sLineBreak +
      'Será solicitada a troca obrigatória de senha no próximo "Login"', ['&Sim', '&Não'], 2) = 1 Then
    Begin
      fExpirarOuLiberarSenha('', ssExpirada);
    End
    Else
    Begin
      fExpirarOuLiberarSenha('', ssApenasDataAlteracao);
    End;
  End;
end;

class function TValidarConfiguracoes.fValidaSEPLCS: Boolean;
var
  LstrUTIWMS: String;
  LstrSEPLCS: String;
begin
  Result := True;

  LstrUTIWMS := fGetValorConfiguracao('UTIWMS');
  LstrSEPLCS := fGetValorConfiguracao('SEPLCS');

  If LstrSEPLCS <> 'S' Then
    Exit;

  Result :=  LstrUTIWMS.Equals('S');
  If Not Result Then
  Begin
    pMensagemOk('Para utilizar a configuração [CFG_SEPLCS] = S, é obrigatório [CFG_UTIWMS] = S');
  End;
end;

class function TValidarConfiguracoes.fValidaDVSPCL: Boolean;
var
  LstrCTGRTN: String;
  LstrDVSPCL: String;
begin
  Result := True;

  LstrCTGRTN := fGetValorConfiguracao('CTGRTN');
  LstrDVSPCL := fGetValorConfiguracao('DVSPCL');

  If LstrDVSPCL <> 'S' Then
    Exit;

  Result :=  Not LstrCTGRTN.Equals('');
  If Not Result Then
  Begin
    pMensagemOk('Para utilizar a configuração [CFG_DVSPCL ] = S, é obrigatório que [CFG_CTGRTN] esteja preenchida');
  End;
end;

Initialization
  TValidarConfiguracoes.funcCadastroCartaoTefConferencia := nil ;

finalization
  TValidarConfiguracoes.funcCadastroCartaoTefConferencia := nil ;

end.

