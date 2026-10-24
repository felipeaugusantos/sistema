unit untUtilBD;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Windows,
  Forms,
  Controls,
  Dialogs,
{$ENDIF}

  SysUtils,
  untInterfaces,
  DB,
  untConfigNFe,
  EncdDecd,
  untDicSis,

{$IF Defined(VER270)}
  Uni, MySQLUniProvider, AnsiStrings, System.Generics.Collections,
{$ELSEIF Defined(VER250) Or Defined(UNIDAC) Or Defined(VER300)}
  Uni, MySQLUniProvider, AnsiStrings, System.Generics.Collections, NetEncoding,
{$ELSE}
  ZDataset, ZConnection,
{$IFEND}

  untLogDanfe,
  untFonteDados,
  Classes,
  Contnrs,
  untManifestoEletronico,
  untInterfacesManifestoEletronico,
  untConhecimentoEletronico,
  untInterfacesConhecimentoEletronico,
  DateUtils,
  Math,
  Types;

Type
  TValorAliquotaIBPT = Record
    fltNacional : Double;
    fltImportado : Double;
    fltEstadual : Double;
    fltMunicipal : Double;
End;

Type
  TDadosIbge = Record
    strCodUf_ : String;
    strCodMun : String;
    strEstado : String;
    strCidade : String;
End;

Type
  TTipoAliquotaIBPT = (alNacional, alImportado, alEstadual, alMunicipal);

Type
  TArrDigDuplic = Record
    intNumDup:  Int64;
    strSequen: String;
    curValor : Currency;
    dtaDtaVen: String;
    strUsaChq: String;
    strHist02: String;
  End;

  TarrDuplicata = Array[0..23] Of TArrDigDuplic;

  TFonteDadosBD = class(TInterfacedObject, IFonteDados, IFonteDadosManifesto, IFonteDadosConhecimento)
    private
      {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(VER300)}
       {$IFNDEF LINUX}
        blnNovaConexao: Boolean;
        MySQLUniProvider: TMySQLUniProvider;
       {$ENDIF}
        Database: TUniConnection;
        qryDados: TUniQuery;
        qryDuplicatas: TUniQuery;
        qryItensNotaComp: TUniQuery;
        qryChavesReferenciadas: TUniQuery;
      {$ELSE}
        Database: TZConnection;
        qryDados: TZQuery;
        qryDuplicatas: TZQuery;
        qryItensNotaComp: TZQuery;
        qryChavesReferenciadas: TZQuery;
      {$IFEND}
      FNumDoc  : String;
      FEspDoc  : String;
      FCodEmp  : String;
      FCodCli  : String;
      FSerie   : String;
      FTip_FC  : String;
      FEmitente: Boolean;
      FGarantiaPropriaEmpresa: Boolean;
      FDocNGComMultiplasChaves: Boolean;
      FChaAce: String;
      FChaTabela: String;

      dadosEmitente: TDadosEmitente;
      dadosGerais: TDadosGerais;

      intPosAtual: Integer;
      lstItens: TObjectList;

      blnCliConNC: Boolean;
      blnTrSeCi : Boolean;
      blnDupCND : Boolean;
      blnTemDupCND : Boolean;

      arrDuplicataCND : TarrDuplicata;

      strIntegradorCitel: String;
      strPathSatCitel: String;

      arrNcmObrAnvisa: array of string;
      FTemPerfilAduaneiro: Boolean;

      {$IF Defined(UNIDAC) Or Defined(LINUX)}
      dicEmpEst: TDictionary<string, string>;
      dicXmlBai: TDictionary<string, string>;
      dicCadIbg: TDictionary<string, TDadosIbge>;
      {$IFEND}

      function fRetCampoValOri(strAgrupamento: String=''): String;

      procedure pCarregaDuplicatas(dadosGerais: TDadosGerais);
      procedure pCarregaDuplicatasOutrasNotas(dadosGerais: TDadosGerais);
      procedure pCarregaTotalDuplicataRecebida(dadosGerais: TDadosGerais);
      procedure pRetornaDadosIbge(strCodCid: String; Var strCodIbge, strUfIbge, strEstado, strCidade: String);
      {$HINTS OFF}
      procedure pRetornaNomeDaCidadeIbge(strCodMun: String; var strNomCid, strEstado: String);
      {$HINTS ON}
      procedure pRetDadosNotaOrigem(Var dtaDtaDoc: TDateTime);
      procedure pRetAlqPisCofins(Var fltAlqPis, fltAlqCof: Double);
      procedure pCarregaCfgDesFab(Var blnDesFab: Boolean);
      procedure pRetClassificacoesDevolucao;

      procedure pCarregarDocumentoImportacao(dadosItem: TDadosItem; strAutIncDet: String);

      function fRetDesCla(strCodCfo: String): String;
      function fNotaComplemento(strNumDoc, strEspDoc, strCodEmp, strCodCli,
        strSerie, strTip_FC: String): Boolean;
      procedure pCarregaItensNotaComp(dadosGerais: TDadosGerais; strAutIncCadFis: String);
      function fAdicionaItem(intIndice, intIndColSer: Integer): TDadosItem;

      function fConfiguracao(strCodCfg: String; strCodEmpPar : String = ''): String;
      function fAtividadeConstrutora(strCodAti: String): Boolean;
      function fRetAtividades: String;

      procedure pAdicionaItensNaLista;
      procedure pAdicionaServicosNaListaDeItens(intIndInicial: Integer);
      procedure pRetCstSimplesProdSubstituidos;
      procedure pRetCfgImpValorIpiDadosPropriosCFOPNaoVenda;
      {$HINTS OFF}
      function fClienteFilial(Const strCodCli: String): Boolean;
      function fRetDesCndPagamento(strCodCnd: String): String;
      {$HINTS ON}
      function fEmiteNCMPorLinhaDeTinta: Boolean;
      function fClaFisGarantia:String;
      procedure pCarregaConfiguracoesNotaServico;
      procedure pCarregaAtividadeConstrutora;
      procedure pCarregaEmpresaNFSe;
      procedure pVerificaSeImprimePalavraAVistaDuplicata(dadosGerais: TDadosGerais);
      {$HINTS OFF}
      procedure pPegaNumeroPedidosFaturados(dadosGerais: TDadosGerais);
      {$HINTS ON}
      procedure pAgrupaDocumentosFaturadosPorVendedor(dadosGerais: TDadosGerais);
      function fRetornaChaveAcesso: String;

      function fGetQuantidadeItensServico: Integer;

      function fTiraPipeEnter(const strTexto: String): String;
      function fCriaQuery(Owner: TComponent): {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
      procedure pCarregaDadosNFSeSubstituicao(var dadosGerais: TDadosGerais;
        strAutInc: String);
      procedure pCarregaInformacoesDoIntermediadorDaTransacao(var dadosGerais: TDadosGerais);
      function fCarregouChavesReferenciadasRegimeEspecialDevolucao(dadosGerais: TDadosGerais) : Boolean;
      procedure pCarregaChavesReferenciadas(dadosGerais: TDadosGerais);
      procedure pCarregaChavesReferenciadasAKZ(strNumDoc,strEspDoc,strCodEmp: String);
      {$HINTS OFF}
      function fRetornaInscSubstitutoTributarioEmpresa(strEmpresa, strEstadoDestino: String): String;
      {$HINTS ON}
      function fRetPontoVendaNFCe: String;

      function fGetDocumentoRemessaConcreto(intSeqCcr: Integer): String;

      procedure pPreencheBeneficiarioDoCartao(var dtaDtaPag: TDateTime; var strCnpjBeneficiario: String);
      procedure pCarregaDadosModalidades(dadosGerais: TDadosGerais; const blnUsarMovCar: Boolean; qryModalidades: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
      procedure pCarregaArrFormasPagamento(const qryModalidades: TDataSet; var fltTotalModalidades: Double; dadosGerais: TDadosGerais);
      procedure pTrataDiferencaEntreTotGerEModalidades(dadosGerais: TDadosGerais; const fltTotalModalidades: Double);
      procedure pAdicionaFormaPagamentoPoisDocumentoNaoTemMovMod(dadosGerais: TDadosGerais);
      procedure pCarregarFormasPagamento(dadosGerais: TDadosGerais);
      procedure pCarregarFormasPagamentoMultas_e_Juros(dadosGerais: TDadosGerais);
      function fEhCupomEletronicoSAT(AdadosGerais: TDadosGerais): boolean;
      {$HINTS OFF}
      procedure pLogarPerformance(objeto: TObject);
      function fCriaObjetoLogPerformance(intCodigo: Integer; strMensagem: String): TLogPerformance;
      {$HINTS ON}
      function fBuscaAlqIBPT(strNcm: String; blnImport: Boolean): Double; Overload;
      function fBuscaAlqIBPT(strNcm: String; strEx: String; strCodEmp: String; strEstado: String=''): TValorAliquotaIBPT; Overload;
      function fRetornaPercetualDevolvido(qryDados: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Double;
      function fArredondaABNT_NBR5891_77(fltValor: Double;
        intDecimais: Integer): Double;
      function fParteInteira(fltValor: Double): Double;
      function fRemoveDizimas(fltValor: Double; intDecimais: Integer): Double;
      function fRetSQLMsg1e2TipAbfdeSAI(strTip: String): String;
      procedure pCarregaDuplicatasCND(strTabela, strAutoincrem:String);
      function fTemMensagemParaCFOP(strAutInc, strClaFis: string): Boolean;
      function fDuplicouItens(qryDados: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): boolean;
      function fAliquotaSuportadoPeloConsumidorFinal(qryDados: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Double;
      function fRetornarModDocumento(dadosGerais: TDadosGerais): String;
      function fRetornaPedidoDoDocumentoSeExistir(Var strPedido: String; dadosGerais: TDadosGerais; blnModelo2: Boolean = False): Boolean;
      function fTipoDocManifesto(strNumMan: string): string;
      procedure pGravaLogRep(strComand, strTabela, strCarreg: String);
      procedure pGravaInfUsuarioReplicacao(intSeqReplicacao: Int64);
      procedure pGeraTextoDocumentosVendedor(var strTexto: string; var qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
      function fTemAdiantamentoNotaEspecialFator(strNumDup, strEspDoc, strCodEmp, strCodCli: String; var intQtdParcel: Integer): Boolean;
      function fDestacaNosDadosAdcionaisDuplicatasQuitadasCreditos: Boolean;
      function fEhDocumentoNGMultiplasChavesRefernciada: Boolean;
      function fBase64Codifica(ATexto: String): String;
      function fBase64Decodifica(ATexto: String): String;
      procedure pExportaPDF(ATexto, APath: String);
      function fExisteRecebimentoEmPix(var strEndToEndIdPixRecebimento : String; const strModalidade: String;
                                       const fltValorModalidade : Double; var strEndToEndIdPixRecebimentoDoValor : String;
                                       var dtaDtaPag: TDateTime; var strCnpjFinanceira: String; var strCnpjBeneficiario: String): Boolean;
      function fExisteAdiantamentoEmPix(strSeqCon, strEmpLan: String; var strMPX_END_ID: String; var fltMPX_VALREC: Double): Boolean;
      function fEhOrdemPagamentoSemPixSat007(const AstrVersao, AstrModalidade, AstrPix: String; AdadosGerais: TDadosGerais): Boolean;
      function fEhOrdemPagamentoSatEquipamentoNaoSuportaCod16Ou17(const AstrModalidade: String; AdadosGerais: TDadosGerais): Boolean;
      function fValCfgOrdemPagamentoSatEquipamentoNaoSuportaCod16Ou17(const AstrModalidade: String; AdadosGerais: TDadosGerais): String;
      function fConfirmacaoTransfEstoque: Boolean;
      function fOperacaoRegimeEspecial: Boolean;
      function fCurrentDateTime: String; Overload;
      function fCurrentDateTime(Const Value: TDateTime): String; Overload;
      function fCarregarPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): String;
      function fRetornaClienteFilial(strCodEmp: String; strTipo_FC: String = 'C'): String;
      function fGetTipOpeTransferencia(strEmpOri, strCliFil: String): String;
      function fRetornaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc, strTipInt: String): Boolean;
      function fTemLancamentoDeMovCar(const AqryFormaPgto: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND} ): Boolean ;
      function fMovModGravaDadosDoCartao: Boolean;
      function fExisteCartaoNaMovMod: Boolean;
      procedure pCarregarFormaPagamentoNotaEspecial(dadosGerais: TDadosGerais);
      function fRetornaNCM(strCodNCM, strCodIte, strCodEmp: String): String;
      function fRetornaNCMEmpresa(strCodIte, strCodEmp: String): String;
      function fRetornaNCMExterior(strCodIte: String): String;
      function fRetornaCodigoDeBarrasDoLote(strNumLot, strLotOri, strCodIte, strCodEmp, strEspDoc, strClaFis: String): String;
      function fRetornaNumLote(strNumLote, strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte, strSeqDet: String;
                               out strDtaFab: String; out strDtaVal: String; out strNumLotDtaVal: String): String;
      function fRetornaLoteUtilizandoMaisDeUmaLocFis(strSeqDet, strNumLot: String): String;
      function fUsaRotinaWMS: Boolean;

      function fEhTipoOperacaoContaOrdem(const strNumDoc, strEspDoc,
        strCodEmp: String): Boolean;
      function fDocumentoComRemessaContaOrdem(const strNumDoc, strEspDoc,
        strCodEmp: String): Boolean;
      procedure pCarregaChavesReferenciadasRemessaContaOrdem(const strNumDoc,
        strEspDoc, strCodEmp: String);
      function fRetornaEmails: String;
      function fBuscaBeneficioFiscalDoCliente(strCodCli, strCodCst, strCdbFis: String): string;
      procedure pModificaXMLNFeBD(AChaveAcesso, AXML: string);
      procedure pAtualizaXMLNFeBD(AChaveAcesso, AXML: string);
      function fRetornaCaminhoNFCeOffLine: String;
      function fImprimeLoteNaDescricaoDoProduto(const strCodIte, strEspDoc: String): Boolean;
      function fRetornaNotasDeCupomComIPI(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;
      function fRetornaDeclaracaoDeImportacaoDaUltimaNotaDeCompra(strCodIte: String): String;
      function fZeraIBPT: Boolean;
      function fGetConnectionID: String;
      function fObterCodFabMovGad(pstrIncDet: String): String;
      function fRetCodigoPais(strCodCidade: String; strCodPaiEnt: String): String;
      procedure pReformaTributariaConfiguracoes(const strClaFis: String;
                                                var strCodCst, strClaTri, strTriReg: String;
                                                var fltCBSALQ, fltCBSALD, fltCBSRLR,
                                                    fltIBSUFA, fltIBSUFD, fltIBSUFR,
                                                    fltIBSMNA, fltIBSMND, fltIBSMNR: Double);

      procedure pReformaTributariaIBS_CBS(var Item: TDadosItem; blnPadrao: Boolean; strCodCst, strClaTri: String; fltBasCal, fltValOpe, fltValIBS: Double);
      procedure pReformaTributariaSEL(var Item: TDadosItem; blnPadrao: Boolean; strSelCst, strSelCla: String; fltSelBas, fltSelAlq, fltSelVal: Double);
      procedure pReformaTributariaCBS(var Item: TDadosItem; blnPadrao: Boolean; fltBasCal, fltCBSALQ, fltCBSALD, fltCBSRLR: Double);
      procedure pReformaTributariaIBS_UF(var Item: TDadosItem; blnPadrao: Boolean; fltBasCal, fltIBSUFA, fltIBSUFD, fltIBSUFR: Double);
      procedure pReformaTributariaIBS_MUN(var Item: TDadosItem; blnPadrao: Boolean; fltBasCal, fltIBSMNA, fltIBSMND, fltIBSMNR: Double);
      procedure pReformaTributariaTRIB_REGULAR(var Item: TDadosItem; blnPadrao: Boolean; strTriReg, strCodCst, strClaTri: String; fltVlrBas: Double);

      procedure pReformaTributariaItens(var Item: TDadosItem);
      procedure pReformaTributariaTotal;
      procedure pCarregaNcmObrigatorioAnvisa;
      procedure pPegaDataHoraSistema(Var dtaDtaSis, dtaHraSis : TDateTime);
     {$IFNDEF LINUX}
      procedure AfterConnect(Sender : TObject);
      procedure pDefinirTimeZoneEmSessaoMySql;
      function fCfgTmZoneToMySqlFormatTimeZone: String;
     {$ENDIF}
      function fDeveEnviarIPIDevolvido : Boolean;
      function fCarregarViaNfeGravado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): Integer;
      function fDataEmissaoDocumentoFiscal(const strNumDoc, strEspDoc, strCodEmp, strForCli, strSerie, strTipFc : String) : TDate;
      procedure pDestroiArrDuplicatas;
      procedure pDestroiArrFormasPagamento;
      procedure pDestroiArrFormasPagamentoInterna;
      function fDeveConcatenarAsNaturezas : Boolean;
      function fReceberApenasUmaNaturezaDeOperacao(const strNat1, strNat2, strNat3, strNat4 : String) : String;
      function fRetornaDataDeCompetenciaNFS(const strChaveAcesso: String): TDateTime;
      function fEhDevolucaoTotal(AChaveAcesso: String): Boolean;
      procedure pPreparaChavesReferenciadasDevolucao;
      function fRetornaFusoHorario: Integer;
    public
      constructor Create(Database: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}; strNumDoc, strEspDoc,
        strCodEmp, strCodCli, strSerie, strTip_FC: String; blnEmitente: Boolean=False); overload;
      constructor Create(Database: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}); overload;
      destructor Destroy; override;

      procedure pCarregarDados;
      procedure pInicio;
      function fDadosEmitente: TDadosEmitente;
      function fDadosGerais: TDadosGerais;
      function fTemDados: Boolean;
      function fProximoItem: TDadosItem;

      function fChaveAcesso: String;
      function fNotaServicoEletronica: Boolean;
      function fNotaServicoEletronicaConcreto: Boolean;

      function fRetornaEstadoEmpresa(strCnpj: String): String;
      procedure pCarregaConfiguracoes;

      function fGetTipAbfSaida(strFisJur, strIES, strProRur, strMicEmp, strConsum, strCodAti, strRegTri, strIndust: String; blnCliFil: Boolean): String;
      function fGetTipoAbfEnt(blnRetPes: Boolean; strRegimeTributario, strFisJur, strIES, strTipFor: String): String;
      function fGetTipoAbfFornecedor(const strCodFor: String): String;
      procedure pAtualizaObraArtigo(strCodObr, strCodArt, strNumDoc, strEspDoc, strCodEmp, strCodCli, strTip_Fc: String);
      function fGetEntGer(strNumDoc, strEspDoc, strCodEmp, strCodCli, strTip_Fc: String): String;
      function fGetCampoValor(strCampoRetorno, strCampoChave, strValorChave, strTabela: String): String;
      function fGetCodObr: String;
      function fGetCodArt: String;

      function fGetProprietarioVeiculo(strNumMan,
                                       strCodEmp : String) : TProprietarioVeiculo;

      function fGetProdutoPredominante(strNumMan,
                                       strCodEmp : String) : TProdutoPredominante;

      function fGetEventoPagamentoOperacaoTransporte(strNumMan,
                                                     strCodEmp : String) : TEventoPagamentoOperacaoTransporte;

      procedure pAddInformacoesPagamentoFrete(Var ManifestoEletronico : TManifestoEletronico;
                                                  strNumMan,
                                                  strCodEmp : String);

      function fGetManifesto(strNumeroManifesto: String): TManifestoEletronico;
      function fGetManifestoCompacto(strNumeroManifesto: String): TManifestoEletronico;
      function fGetDadosAdicionaisReferenteAEntrega : String;
      function fGetIbgeCarregamentoPosterior(strEmpLog: string): String;

      function fGetSQLConhecimento(blnExistePARCTE: Boolean; blnConsulta: Boolean=False): string;
      function fGetConhecimento(strNumeroConhecimento: String; blnConsulta: Boolean=False): TConhecimentoEletronico;
      function fGetConhecimentoCompacto(strNumeroConhecimento: String): TConhecimentoEletronico;

      function fSuportaOperacaoBanco: Boolean;

      function fExecutaQuery(strSQL: String; arrParametros: Array Of String; arrValores: Array Of Variant): TDataSet;
      function fCampoExiste(const strTabela, strCampo: String): Boolean;
      function fTabelaExiste(strNomeTabela: String): Boolean;

      procedure pCarregaConfiguracoesInternas(Var objConfig: TConfiguracoesInternas);

      function fCampoTabela(strCampo : String;
                            strNomTab: String;
                            arrCampoChave: Array Of String;
                            arrValorChave: Array Of Variant): Variant;
      procedure pSalvarXMLNFeBD(AChaveAcesso, AXML: string; AXMLJaBaixado: String = '');
      function XMlJaBaixado(AChaveAcesso: string): Boolean;
      function fBuscaBeneficioFiscal(strPerAbrSai, strCodEmp, strCFOP, strCST: string):string;
      function fNFCeEnderecoDeConsulta(strUF: String): String;
      procedure pNFCeOffLineConfiguracoes(strCodEmp: String);
      function fChaveTabela: String;
      procedure pGravaTabela(objItem: TDadosItem; strTabela: String);
      function fGetSqlManifestoNFe(): String;
      function fGetSqlManifestoCTe(): String;
      procedure pGravaIcmsDesonerado(strTabela, strAutInc, strMtdIcm: String; fltIcmDes: Double);
      function fGetDadosVeiculoManifesto(strPlaca: string): TDadosVeiculo;
      function fGetDadosReboqueManifesto(strPlaca: string): TDadosReboque;
      function fConfiguracaoExiste(strCodCfg: String): Boolean;
      function PDFJaBaixado(AChaveAcesso: string): Boolean;
      procedure pSalvarPDFNFeBD(AChaveAcesso, APDF: string; APDFJaBaixado: String = '');
      function fUsaNotaServicoEletronicaEnotas: Boolean;
      function CarregarPDF(AChaveAcesso, ANomeArquivo: string; AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean): string;
      procedure pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
                              strCodCli, strTip_FC, strStatus, strObserv: String;
                              strChaAce: String=''; dtaDtaAut: TDateTime=0; strPonImp: String='');
      procedure pAtualizaDadosAutorizacaoNFe(Const strChaveAcesso, strProtocolo, strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
      function fRetornaDocumentoImpresso(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): Boolean;
      procedure pGravaDocumentoImpresso(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
      procedure pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc, strTipInt: String);
      procedure pSalvarXmlDfeBD(ATipDfe, AChaveAcesso, AProtocolo, AXml: string);
      procedure pSetaIndicadorIntegracaoCitel(const AstrIntegradorCitel: String='S');
      procedure pSetaPathSatCitel(const AstrPathSatCitel: String='');
      procedure pGravarLogFit(strNumDoc, strEspDoc, strCodEmp, strSerie_, strForCli, strTip_FC, strTipArq, strArquiv: String);
      procedure pAtualizaDataDeAutorizacao(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli: String);
      function  GetTemPerfilAduaneiro: Boolean;
      function fRetornaXMLNFeBD(AChaveAcesso: string): String;
      {$IF Defined(UNIDAC)}
      function fRetDataBase: TUniConnection;
      {$IFEND}
  End;

Var
  VS_GravaUsuRep  : String;
  VS_LogRepConId  : String;
  VS_LogRepCodOp  : String;
  VS_ConnectionID : string;

implementation

uses StrUtils, untUtil, untTipoFreteAtc, untConstantesNFe, Variants;

{ TFonteDadosBD }

constructor TFonteDadosBD.Create(Database: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}; strNumDoc,
  strEspDoc, strCodEmp, strCodCli, strSerie, strTip_FC: String;
  blnEmitente: Boolean=False);
  const
    MAX_NFE_NUMDOC = 999999999;//Limite de 9 digitos NFe

  Var
    intCodAut : Integer;

  function fUsarSenhaDLL(strPathIni: String): Boolean;
  begin
    Result := (intCodAut > 0) And (FileExists(strPathIni + 'libUtil.dll'));
  end;

  procedure DefineIsolationLevel;
    Var
      qryIsolation: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  begin
    qryIsolation := fCriaQuery(Nil);
    try
      qryIsolation.SQL.Text := DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION;
      qryIsolation.ExecSQL;
    finally
      FreeAndNil(qryIsolation);
    end;
  end;

  procedure pDefinirCharsetConexao;
    Var
      qryGen: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  begin
    qryGen := fCriaQuery(Nil);

    Try
      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SET character_set_connection = LATIN1');
        ExecSQL;

        SQL.Clear;
        SQL.Add('SET character_set_client = LATIN1');
        ExecSQL;

        SQL.Clear;
        SQL.Add('SET character_set_database = LATIN1');
        ExecSQL;

        SQL.Clear;
        SQL.Add('SET character_set_results = LATIN1');
        ExecSQL;

        SQL.Clear;
        SQL.Add('SET character_set_server = LATIN1');
        ExecSQL;

        SQL.Clear;
        SQL.Add('SET collation_connection = latin1_swedish_ci');
        ExecSQL;

        SQL.Clear;
        SQL.Add('SET collation_database = latin1_swedish_ci');
        ExecSQL;

        SQL.Clear;
        SQL.Add('SET collation_server = latin1_swedish_ci');
        ExecSQL;
      End;

    Finally
      FreeAndNil(qryGen);
    End;

  end;

{$IFNDEF LINUX}
  {$IF Defined(VER250) Or Defined(UNIDAC)}
  function fUsarNovaConexaoLibNfe: Boolean;
    Var
      strPathIni : String;
  begin
    Result := True;
    strPathIni := fPathOpcoesIni;
    If (Not fEmptyStr(strPathIni)) Then
      Result := fArqIniLocal(0, 'CONEXAO', 'NOVA_CONEXAO_LIBNFE', 'S', strPathIni) <> 'N';
  end;
  {$IFEND}
{$ENDIF}

{$IFNDEF LINUX}
  function fConectar: Boolean;
    {$IF Defined(VER250) Or Defined(UNIDAC)}
    Var
      strPathIni : String;
      libUtil: Cardinal;
      fRetornaUsuario: function: PAnsiChar; stdcall;
      fRetornaSenha: function: PAnsiChar; stdcall;
      pSetaArquivoOpcoes: procedure(strArquivo: PAnsiChar); stdcall;
      arrStr: Array [0..255] Of AnsiChar;
      blnPooling : Boolean;
      strExePai: String;
    {$IFEND}
  begin
    Result := False;

    {$IF Defined(VER250) Or Defined(UNIDAC)}
    strPathIni := fPathOpcoesIni;

    If (Not fEmptyStr(strPathIni)) Then
    Begin
      Result := True;
      Self.Database.Disconnect;
      Self.Database.ProviderName := 'MySQL';
      Self.Database.Database := '';
      Self.Database.Server   := '';

      intCodAut := StrToIntDef(fArqIniLocal(0, 'GERAL', 'CODAUT', '0', strPathIni), 0);

      If fUsarSenhaDLL(AnsiReplaceStr(strPathIni, 'opcoes.ini', '')) Then
      Begin
        libUtil := LoadLibrary(PChar(AnsiReplaceStr(strPathIni, 'opcoes.ini', '') + 'libUtil.dll'));
        Try
          fRetornaUsuario := GetProcAddress(libUtil, PChar('fRetornaUsuarioPChar'));
          fRetornaSenha   := GetProcAddress(libUtil, PChar('fRetornaSenhaPChar'));
          pSetaArquivoOpcoes := GetProcAddress(libUtil, PChar('pSetaArquivoOpcoesPChar'));

          If Assigned(pSetaArquivoOpcoes) Then
          Begin
            pSetaArquivoOpcoes(AnsiStrings.StrPCopy(arrStr, AnsiString(strPathIni)));
          End;

          Self.Database.Username := String(AnsiStrings.StrPas(fRetornaUsuario));
          Self.Database.Password := String(AnsiStrings.StrPas(fRetornaSenha));

        Finally
          FreeLibrary(libUtil);
        End;
      End
      Else
      Begin
        if Assigned(Database) then
        begin
          Self.Database.Username := Database.Username;
          Self.Database.Password := Database.Password;
        end
        else
        begin
          Self.Database.Username := 'root';
          Self.Database.Password := 'citel13347';
        end;
      End;

      if HasParam('NUMIP=') then
        Self.Database.Server := GetParamValue('NUMIP=')
      else
        Self.Database.Server   := AnsiReplaceStr(fArqIniLocal(0, 'BANCO', 'NUMIP', '', strPathIni), ' ', '');

      if HasParam('NOMBAN=') then
        Self.Database.Database := GetParamValue('NOMBAN=')
      else
        Self.Database.Database := fArqIniLocal(0, 'BANCO', 'NOMBAN', '', strPathIni);

      if HasParam('PORTA=') then
        Self.Database.Port := GetParamValue('PORTA=').ToInteger()
      else
        Self.Database.Port     := StrToIntDef(AnsiReplaceStr(fArqIniLocal(0, 'BANCO', 'PORTA', '3306', strPathIni), ' ', ''), 3306);

      strExePai := ExtractFileName(Application.ExeName);

      If (Pos(AnsiUpperCase(strExePai), AnsiUpperCase('PainelNFe.exe/NFeStatus.exe/NFeImpressao.exe')) > 0) Then
        blnPooling := False
      Else
        blnPooling := (fArqIniLocal(0, 'CONEXAO', 'POOLING', 'S', strPathIni) = 'S');

      If (blnPooling) Then
      begin
        Self.Database.PoolingOptions.MaxPoolSize := StrToIntDef(AnsiReplaceStr(fArqIniLocal(0, 'CONEXAO', 'MAXPOOLSIZE', '100', strPathIni), ' ', ''), 100);
        Self.Database.PoolingOptions.MinPoolSize := StrToIntDef(AnsiReplaceStr(fArqIniLocal(0, 'CONEXAO', 'MINPOOLSIZE', '0',   strPathIni), ' ', ''), 0);
        Self.Database.PoolingOptions.Validate := (fArqIniLocal(0, 'CONEXAO', 'VALIDATE', 'S', strPathIni) = 'S');
        Self.Database.PoolingOptions.ConnectionLifetime := StrToIntDef(AnsiReplaceStr(fArqIniLocal(0, 'CONEXAO', 'CONNECTIONLIFETIME', '10000',   strPathIni), ' ', ''), 10000);
        Self.Database.Pooling := True;
      end;

      Self.Database.AfterConnect := Self.AfterConnect;
      Self.Database.Connect;

      pGeraRegistroParaLogGeneral(Self.Database, 'Inicializacao', True);

      {$IF not Defined(LINUX)}
      pDefinirCharsetConexao;
      {$IFEND}
      DefineIsolationLevel;// AfterConnect não executa no linux.

      Self.blnNovaConexao := True;
    End;
    {$IFEND}
  End;
{$ENDIF}

begin
  FNumDoc := strNumDoc;
  FEspDoc := strEspDoc;
  FCodEmp := strCodEmp;
  FCodCli := strCodCli;
  FSerie  := strSerie;
  FTip_FC := strTip_FC;

{$IFDEF LINUX}
  Self.Database := Database;
{$ELSE}
  {$IF Defined(VER250) Or Defined(UNIDAC)}
    Self.Database := TUniConnection.Create(Nil);
    Self.MySQLUniProvider := TMySQLUniProvider.Create(Self.Database);
    Self.blnNovaConexao := False;
    Try
      If fUsarNovaConexaoLibNfe Then
        fConectar
      Else
      Begin
        Self.Database.AssignConnect(Database);
        Self.Database.Tag := Database.Tag;
      End;
    Except
      On E: EAccessViolation Do
      Begin
        If fUsarNovaConexaoLibNfe Then
          Raise
        Else If Not fConectar Then
          Raise;
      End;
    End;
  {$ELSE}
    Self.Database := Database;
  {$IFEND}
{$ENDIF}

  If Not fEmptyStr(strNumDoc) And (StrToInt64Def(strNumDoc, MAXINT) > MAX_NFE_NUMDOC) And (strEspDoc <> 'NS') Then
    Raise Exception.Create('Número do documento (' + strNumDoc +') excede o limite disponível. Verifique!');

  objLogDanfe.strNumDoc := strNumDoc;
  objLogDanfe.strEspDoc := strEspDoc;
  objLogDanfe.strCodEmp := strCodEmp;
  objLogDanfe.strCodCli := strCodCli;
  objLogDanfe.strSerie_ := strSerie;
  objLogDanfe.objConexao := Self.Database;

  objLogDanfe.AddLog('TFonteDadosBD.Create');

  FEmitente := blnEmitente;
  blnDupCND := False;
  blnTemDupCND := False;
  strIntegradorCitel := '';
  strPathSatCitel := '';

  If (blnEmitente) Then
  Begin
    dadosGerais := TDadosGerais.Create;
    dadosGerais.strNumDoc := strNumDoc;
    dadosGerais.strEspDoc := strEspDoc;
    dadosGerais.strCodEmp := strCodEmp;
    dadosGerais.strCodCli := strCodCli;
    dadosGerais.strSerie  := strSerie;
    dadosGerais.strTip_FC := strTip_FC;

    dadosGerais.strTemRefFis := 'N';
  End;

  lstItens := TObjectList.Create;

  pCarregaConfiguracoes;

  FDocNGComMultiplasChaves := False;

  SetLength(arrNcmObrAnvisa, 0);

  {$IF Defined(UNIDAC) Or Defined(LINUX)}
  dicEmpEst := TDictionary<string, string>.Create;
  dicXmlBai := TDictionary<string, string>.Create;
  dicCadIbg := TDictionary<string, TDadosIbge>.Create;
  {$IFEND}
end;

constructor TFonteDadosBD.Create(Database: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND});
begin
  Create(DataBase, '', '', objConfig.strCodEmp, '', '', '', True);
end;

destructor TFonteDadosBD.Destroy;
begin
  pDestroiArrDuplicatas;
  pDestroiArrFormasPagamento;
  pDestroiArrFormasPagamentoInterna;

  If Assigned(qryDados) Then
    FreeAndNil(qryDados);

  If Assigned(qryDuplicatas) Then
    FreeAndNil(qryDuplicatas);

  If Assigned(qryItensNotaComp) Then
    FreeAndNil(qryItensNotaComp);

  If Assigned(qryChavesReferenciadas) Then
    FreeAndNil(qryChavesReferenciadas);

  If Assigned(lstItens) Then
  Begin
    lstItens.Clear;
    FreeAndNil(lstItens);
  End;

  If Assigned(dadosGerais) Then
    FreeAndNil(dadosGerais);

  If Assigned(dadosEmitente) Then
    FreeAndNil(dadosEmitente);

{$IFDEF LINUX}
{$ELSE}
  {$IF Defined(VER250) Or Defined(UNIDAC)}
    If Self.blnNovaConexao Then
    Begin
      pGeraRegistroParaLogGeneral(Self.Database, 'TFonteDadosBD.Destroy > Self.Database.Disconnect', True);

      Self.Database.AfterConnect := Nil;
      Self.Database.Disconnect;
    End
    Else If Not Self.Database.Pooling Then
    Begin
      pGeraRegistroParaLogGeneral(Self.Database, 'TFonteDadosBD.Destroy > Self.Database.AssignConnect(nil) ', True);

      Self.Database.AssignConnect(nil);
    End;
    FreeAndNil(Self.Database);
  {$IFEND}
{$ENDIF}

{$IF Defined(UNIDAC) Or Defined(LINUX)}
  If Assigned(dicEmpEst) Then
    FreeAndNil(dicEmpEst);

  If Assigned(dicXmlBai) Then
    FreeAndNil(dicXmlBai);

  If Assigned(dicCadIbg) Then
    FreeAndNil(dicCadIbg);
{$IFEND}

  objLogDanfe.objConexao := Nil;

  inherited Destroy;
end;

function TFonteDadosBD.fChaveAcesso: String;
begin
  Result := FChaAce;
end;

function TFonteDadosBD.fChaveTabela: String;
begin
  Result := FChaTabela;
end;

function TFonteDadosBD.fClaFisGarantia: String;
  Var
    strVal: String;
begin
  Result := '';

  strVal := fConfiguracao('CLARGF');

  If (Not fEmptyStr(strVal)) Then
    Result := '5' + strVal + '_6' + strVal;
end;

function TFonteDadosBD.fClienteFilial(const strCodCli: String): Boolean;
  Var
    qryEmp: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryEmp := fCriaQuery(Nil);

  qryEmp.SQL.Add('SELECT COUNT(*) AS QTD FROM CADEMP WHERE EMP_CLIFIL = :CODCLI');
  qryEmp.ParamByName('CODCLI').AsString := strCodCli;
  qryEmp.Open;

  Result := (qryEmp.FieldByName('QTD').AsInteger > 0);

  FreeAndNil(qryEmp);
end;

function TFonteDadosBD.fDadosEmitente: TDadosEmitente;
  Var
    qryDadosEmit: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    blnUsaCadastroInscricaoSubstituto: Boolean;
begin
  If (Not Assigned(dadosEmitente)) Then
  Begin
    blnUsaCadastroInscricaoSubstituto := False;
    If Assigned(qryDados) Then
      If qryDados.Active Then
        If fTabelaExiste('EMPISB') Then
          blnUsaCadastroInscricaoSubstituto := True;

    qryDadosEmit := fCriaQuery(Nil);
    qryDadosEmit.SQL.Add('SELECT ');
    qryDadosEmit.SQL.Add('  E.EMP_C_G_C_, ');
    qryDadosEmit.SQL.Add('  E.EMP_NOMEMP, ');
    qryDadosEmit.SQL.Add('  E.EMP_NOMFAN, ');
    qryDadosEmit.SQL.Add('  E.EMP_ENDERE, ');
    qryDadosEmit.SQL.Add('  E.EMP_ENDNUM, ');
    qryDadosEmit.SQL.Add('  E.EMP_ENDCMP, ');
    qryDadosEmit.SQL.Add('  E.EMP_BAIRRO, ');
    qryDadosEmit.SQL.Add('  E.EMP_CODCID, ');
    qryDadosEmit.SQL.Add('  E.EMP_C_E_P_, ');
    qryDadosEmit.SQL.Add('  E.EMP_FONE01, ');
    qryDadosEmit.SQL.Add('  E.EMP_I_E_S_, ');

    If blnUsaCadastroInscricaoSubstituto Then
      qryDadosEmit.SQL.Add(' (SELECT I.EMP_INSSUB FROM EMPISB I WHERE I.EMP_CODEMP = E.EMP_CODEMP AND I.EMP_ESTADO = :ESTCON LIMIT 1) AS EMP_INSSUB, ')
    Else If fCampoExiste('CADEMP', 'EMP_INSSUB') Then
      qryDadosEmit.SQL.Add(' E.EMP_INSSUB, ')
    Else
      qryDadosEmit.SQL.Add(' CAST("" AS CHAR(1)) AS EMP_INSSUB, ');

    If fCampoExiste('CADEMP', 'EMP_REGTRI') Then
      qryDadosEmit.SQL.Add(' E.EMP_REGTRI, ')
    Else
      qryDadosEmit.SQL.Add(' "" AS EMP_REGTRI, ');

    qryDadosEmit.SQL.Add('  E.EMP_CODEMP, ');

    qryDadosEmit.SQL.Add('  E.EMP_INSMUN, ');
    qryDadosEmit.SQL.Add('  E.EMP_CNAEFI, ');
    qryDadosEmit.SQL.Add('  E.EMP_EMAIL_, ');
    qryDadosEmit.SQL.Add('  C.CID_COIBGE, ');
    qryDadosEmit.SQL.Add('  C.CID_NOMCID, ');
    qryDadosEmit.SQL.Add('  C.CID_ESTADO, ');
    qryDadosEmit.SQL.Add('  (SELECT IBG_CODUF_ FROM IBG_CADIBG I WHERE I.IBG_CODMUN = C.CID_COIBGE LIMIT 1) AS IBG_CODUF_ ');
    qryDadosEmit.SQL.Add('FROM ');
    qryDadosEmit.SQL.Add('  CADEMP E INNER JOIN CADCID C ON C.CID_CODCID = E.EMP_CODCID ');
    qryDadosEmit.SQL.Add('WHERE ');
    qryDadosEmit.SQL.Add('  E.EMP_CODEMP = :CODEMP ');

    qryDadosEmit.ParamByName('CODEMP').AsString  := objConfig.strCodEmp;
    If blnUsaCadastroInscricaoSubstituto Then
      qryDadosEmit.ParamByName('ESTCON').AsString := qryDados.FieldByName('GER_ESTCON').AsString;

    qryDadosEmit.Open;

    dadosEmitente := TDadosEmitente.Create;

    dadosEmitente.strCnpj               := qryDadosEmit.FieldByName('EMP_C_G_C_').AsString;
    dadosEmitente.strRazao              := qryDadosEmit.FieldByName('EMP_NOMEMP').AsString;
    dadosEmitente.strFantasia           := qryDadosEmit.FieldByName('EMP_NOMFAN').AsString;
    dadosEmitente.strEndereco           := qryDadosEmit.FieldByName('EMP_ENDERE').AsString;
    dadosEmitente.strNumeroEnd          := qryDadosEmit.FieldByName('EMP_ENDNUM').AsString;
    dadosEmitente.strComplementoEnd     := qryDadosEmit.FieldByName('EMP_ENDCMP').AsString;
    dadosEmitente.strCodIbge            := qryDadosEmit.FieldByName('CID_COIBGE').AsString;
    dadosEmitente.strUfIbge             := qryDadosEmit.FieldByName('IBG_CODUF_').AsString;
    dadosEmitente.strBairro             := qryDadosEmit.FieldByName('EMP_BAIRRO').AsString;
    dadosEmitente.strNomeCidade         := qryDadosEmit.FieldByName('CID_NOMCID').AsString;
    dadosEmitente.strEstado             := qryDadosEmit.FieldByName('CID_ESTADO').AsString;
    dadosEmitente.strCep                := qryDadosEmit.FieldByName('EMP_C_E_P_').AsString;
    dadosEmitente.strCodigoPais         := consCodIbgeBrasil;
    dadosEmitente.strNomePais           := 'BRASIL';
    dadosEmitente.strTelefone           := fLimpaCaracteresTelefone(qryDadosEmit.FieldByName('EMP_FONE01').AsString);
    dadosEmitente.strIES                := qryDadosEmit.FieldByName('EMP_I_E_S_').AsString;
    dadosEmitente.strIESST              := qryDadosEmit.FieldByName('EMP_INSSUB').AsString;
    dadosEmitente.strREGTRI             := qryDadosEmit.FieldByName('EMP_REGTRI').AsString;
    dadosEmitente.strInscricaoMunicipal := qryDadosEmit.FieldByName('EMP_INSMUN').AsString;
    dadosEmitente.strCNAEFiscal         := qryDadosEmit.FieldByName('EMP_CNAEFI').AsString;
    dadosEmitente.strEMail              := qryDadosEmit.FieldByName('EMP_EMAIL_').AsString;

    dadosEmitente.strFitOffLineLicenca    := fConfiguracao('OFFLIC');
    dadosEmitente.strFitOffLineCertJKS    := fConfiguracao('CERJKS');
    dadosEmitente.strFitOffLineCertSenha  := fConfiguracao('SENJKS');
    dadosEmitente.strFitOffLineIdToken    := fConfiguracao('ITOKEN');
    dadosEmitente.strFitOffLineNroToken   := fConfiguracao('NTOKEN');
    dadosEmitente.strFitOffLinePath       := fRetornaCaminhoNFCeOffLine;
    dadosEmitente.strFitAmbiente          := IIF((pos('hom',fConfiguracao('CITURL')) > 0),'2','1');

    FreeAndNil(qryDadosEmit);
  End;

  Result := dadosEmitente;
end;

function TFonteDadosBD.fDadosGerais: TDadosGerais;
  Var
    strCodIbge: String;
    strUfIbge: String;
    strEstado: String;
    strCidade: String;
    intLivFis: Integer;
    strCFG_NATOPA: String;
    recCliEnd: TRecCliEnd;

    function fRetDesPai(strCodPai: String): String;
      Var
        qryGen: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    Begin
      Result := '';

      If fEmptyStr(strCodPai) Then
      Begin
        Exit;
      End;

      If (consCodIbgeBrasil = strCodPai) Then
      Begin
        Result := 'BRASIL';
        Exit;
      End;

      qryGen := fCriaQuery(Nil);
      Try
        qryGen.SQL.Clear;
        qryGen.SQL.Add('SELECT IBG_NOMPAI FROM IBG_CADPAI WHERE IBG_CODPAI = :CODPAI');
        qryGen.ParamByName('CODPAI').AsString := strCodPai;
        qryGen.Open;

        Result := qryGen.FieldByName('IBG_NOMPAI').AsString;
      Finally
        FreeAndNil(qryGen);
      End;
    End;

    function fPermitirFreteEmVendaPresencial: Boolean;
      Var
        strVal: String;
    Begin
      Result := True;

      If (Pos(dadosGerais.strOpcDoc, 'DV_OF_GF_NG_') > 0) Then
        Exit;

      If (Not dadosGerais.blnVenPre) Then
        Exit;

      strVal := fConfiguracao('FREPRE');
      Result := strVal = 'S';
    End;

    function fEnviaEnderecoDeEntrega: Boolean;
    begin
      Result := True;

      If not (fCampoExiste('MOVGER', 'GER_ENTFAT')) Then
        Exit;

      If fEmptyStr(qryDados.FieldByName('GER_ENTFAT').AsString) Then
        Exit;

      If (qryDados.FieldByName('GER_ENTFAT').AsString = 'S') Then
        Exit;

      If not (fConfiguracao('NEVRET') = 'S') Then
        Exit;

      Result := False;
    end;

    procedure pReformaTributariaCreditoDebito;
    begin
      If Not Assigned(dadosGerais.ReformaTributariaCreditoDebito) Then
        dadosGerais.ReformaTributariaCreditoDebito := TCREDITO_DEBITO.Create;

      If fCampoExiste('NOTCOM', 'GER_CODCST') Then
        dadosGerais.ReformaTributariaCreditoDebito.strCodigoCST := qryDados.FieldByName('GER_CODCST').AsString;

      If fCampoExiste('NOTCOM', 'GER_CLATRI') Then
        dadosGerais.ReformaTributariaCreditoDebito.strClassTrib := qryDados.FieldByName('GER_CLATRI').AsString;

      If fCampoExiste('NOTCOM', 'GER_MESANO') Then
        dadosGerais.ReformaTributariaCreditoDebito.strMesAno := qryDados.FieldByName('GER_MESANO_').AsString;

      If fCampoExiste('NOTCOM', 'GER_BASCAL') Then
        dadosGerais.ReformaTributariaCreditoDebito.fltBasCal := qryDados.FieldByName('GER_BASCAL').AsFloat;

      If fCampoExiste('NOTCOM', 'GER_ALQCBS') Then
        dadosGerais.ReformaTributariaCreditoDebito.fltAlqCBS := qryDados.FieldByName('GER_ALQCBS').AsFloat;

      If fCampoExiste('NOTCOM', 'GER_VALCBS') Then
        dadosGerais.ReformaTributariaCreditoDebito.fltValCBS := qryDados.FieldByName('GER_VALCBS').AsFloat;

      If fCampoExiste('NOTCOM', 'GER_ALQIBS') Then
        dadosGerais.ReformaTributariaCreditoDebito.fltAlqIBS := qryDados.FieldByName('GER_ALQIBS').AsFloat;

      If fCampoExiste('NOTCOM', 'GER_VALIBS') Then
        dadosGerais.ReformaTributariaCreditoDebito.fltValIBS := qryDados.FieldByName('GER_VALIBS').AsFloat;
    end;

    procedure pRetirarReformaDoValorContabil;
    begin
      // O GER_VLRCON traz CBS/IBS/IS (CFG_REFCIS) e o vNF nao pode trazer (rejeicao 610)
      dadosGerais.blnReformaNoValorContabil := False;
      dadosGerais.fltValorReformaContabil   := 0;
      dadosGerais.blnReformaSomadaNoVNF     := False;
      If (qryDados.FindField('GER_VALREF') = Nil) Then
        Exit;
      If (qryDados.FieldByName('FIS_NFCOMP').AsString = 'S') Then
        Exit;
      dadosGerais.blnReformaNoValorContabil := True;
      dadosGerais.fltValorReformaContabil   := fFormataFloat(qryDados.FieldByName('GER_VALREF').AsFloat, 2);
      dadosGerais.blnReformaSomadaNoVNF     := fSomarNovosImpostosDaReformaAoVNF(Self, FCodEmp);
      If dadosGerais.blnReformaSomadaNoVNF Then
      Begin
        pLogImp('Reforma mantida no vNF (CFG_REFVNF): ' + FloatToStr(dadosGerais.fltValorReformaContabil));
        Exit;
      End;
      dadosGerais.fltTotGer                 := fFormataFloat(dadosGerais.fltTotGer - dadosGerais.fltValorReformaContabil, 2);
      pLogImp('Reforma retirada do vNF: ' + FloatToStr(dadosGerais.fltValorReformaContabil));
    end;

begin

  If (Not Assigned(dadosGerais)) And (Assigned(qryDados)) Then
  Begin
    dadosGerais := TDadosGerais.Create;

    If qryDados.FieldByName('GER_ESTCON').AsString = 'EX' Then
    Begin
      strCodIbge := '9999999';
      dadosGerais.strNomeCidade := 'EXTERIOR';
      strUfIbge  := 'EX'
    End
    Else
    Begin
      pRetornaDadosIbge(qryDados.FieldByName('GER_CIDCON').AsString, strCodIbge, strUfIbge, strEstado, strCidade);
      dadosGerais.strNomeCidade       := qryDados.FieldByName('GER_NOMCID').AsString;
    End;

    If (qryDados.FindField('GER_OPCDOC') <> Nil) Then
      dadosGerais.strOpcDoc := qryDados.FindField('GER_OPCDOC').AsString;

    dadosGerais.strCodCli           := qryDados.FieldByName('FIS_FORCLI').AsString;
    dadosGerais.strNomCli           := fTiraPipeEnter(qryDados.FieldByName('GER_NOMCON').AsString);
    dadosGerais.strIDEstrangeiro    := qryDados.FieldByName('CLI_IDESTR').AsString;
    dadosGerais.strCnpj             := qryDados.FieldByName('GER_CGCCON').AsString;

    If (Assigned(qryDados.FindField('GER_MATREV'))) Then
      dadosGerais.strMatRev := qryDados.FieldByName('GER_MATREV').AsString
    Else
      dadosGerais.strMatRev := '';

    If (fEmptyStr(dadosGerais.strCnpj)) And (FTip_FC = 'C') And
       (Pos(dadosGerais.strOpcDoc, 'DV_NW_') > 0) And
       ((fConfiguracao('CPFSDV') = 'S') Or (fConfiguracao('CNPSDV') = 'S')) And
       (fCampoExiste('CADCLI', 'CLI_CPFDEV')) Then
    Begin
      dadosGerais.strCnpj := fCampoTabela('CLI_CPFDEV', 'CADCLI', ['CLI_CODCLI'], [dadosGerais.strCodCli]);
    End;

    If (Not fEmptyStr(dadosGerais.strCnpj)) And (FTip_FC = 'C') And
       (Pos(FEspDoc, 'IF_IV_') > 0) And
       (fConfiguracao('NFPCLI') = 'S') And (fCampoExiste('AUXMOV', 'AUX_NOTPAU')) Then
    Begin
      If qryDados.FieldByName('GER_NOTPAU').AsString = 'N' Then
        dadosGerais.strCnpj := '';
    End;

    dadosGerais.strNotPau := '';
    If (Assigned(qryDados.FindField('GER_NOTPAU'))) Then
      dadosGerais.strNotPau := qryDados.FieldByName('GER_NOTPAU').AsString;

    If (FEspDoc = 'NF') And
       (fEmptyStr(dadosGerais.strCnpj)) And (FTip_FC = 'C') And
       (pos(dadosGerais.strOpcDoc, 'CF_BD_') > 0) And
       ((fConfiguracao('CPFSDV') = 'S') Or (fConfiguracao('CNPSDV') = 'S')) And
       (fCampoExiste('CADCLI', 'CLI_CPFDEV')) Then
    Begin
      dadosGerais.strCnpj := fCampoTabela('CLI_CPFDEV', 'CADCLI', ['CLI_CODCLI'], [dadosGerais.strCodCli]);
    End;

    dadosGerais.strLogradouro       := fTiraPipeEnter(qryDados.FieldByName('GER_ENDERE').AsString);
    dadosGerais.strNumeroEnd        := fTiraPipeEnter(qryDados.FieldByName('GER_ENDNUM').AsString);
    dadosGerais.strComplementoEnd   := fTiraPipeEnter(qryDados.FieldByName('GER_ENDCOM').AsString);
    dadosGerais.strBairro           := fTiraPipeEnter(qryDados.FieldByName('GER_BAICON').AsString);
    dadosGerais.strCodIbge          := strCodIbge;
    dadosGerais.strUfIbge           := strUfIbge;
    dadosGerais.strEstado           := qryDados.FieldByName('GER_ESTCON').AsString;

    dadosGerais.strCEP              := fRetSomenteNumeros(qryDados.FieldByName('GER_CEPCON').AsString);
    dadosGerais.strTelefone         := fLimpaCaracteresTelefone(qryDados.FieldByName('GER_TELCON').AsString);
    dadosGerais.strIES              := fRetSomenteNumeros(qryDados.FieldByName('GER_IESCON').AsString);
    dadosGerais.strInscMunicipal    := fTiraCaracEspeciais(qryDados.FieldByName('GER_IMPCON').AsString, True, True, True);
    dadosGerais.strEmail            := fTiraPipeEnter(qryDados.FieldByName('GER_EMAIL_').AsString);
    dadosGerais.strEmail2           := fTiraPipeEnter(qryDados.FieldByName('GER_EMAIL2').AsString);
    dadosGerais.strConsum           := qryDados.FieldByName('GER_CONSUM').AsString;

    If not fExisteNumeros(dadosGerais.strNumeroEnd) Then
      dadosGerais.strNumeroEnd := 'SN';

    If (dadosGerais.strConsum = 'S') And (dadosGerais.strNumeroEnd = 'SN') Then
    begin
      recCliEnd := fGetParteEndereco(dadosGerais.strLogradouro);

      If (Not fEmptyStr(recCliEnd.strNumero)) Then
      Begin
        dadosGerais.strLogradouro     := recCliEnd.strLograd;
        dadosGerais.strNumeroEnd      := recCliEnd.strNumero;
        dadosGerais.strComplementoEnd := recCliEnd.strComple;
      End;
    end;

    If (Pos(dadosGerais.strEstado, 'AC_AM_AP_RO_RR_') > 0) Then
      dadosGerais.strSuframa        := fTiraPipeEnter(qryDados.FieldByName('GER_SUFRAM').AsString);

    If Not fEmptyStr(qryDados.FieldByName('GER_CLIORI').AsString) Then
    Begin
      dadosGerais.strEmail          := fGetCampoValor('CLI_EMAIL3', 'CLI_CODCLI', qryDados.FieldByName('GER_CLIORI').AsString, 'CADCLI');
      dadosGerais.strEmail2         := fGetCampoValor('CLI_EMAIL2', 'CLI_CODCLI', qryDados.FieldByName('GER_CLIORI').AsString, 'CADCLI');
    End;

    If (FEspDoc = 'NS') Then
    Begin
      dadosGerais.strEmails := fRetornaEmails;
    End;

    dadosGerais.strCodigoPais       := qryDados.FieldByName('GER_CODPAI').AsString;
    dadosGerais.strNomePais         := fRetDesPai(qryDados.FieldByName('GER_CODPAI').AsString);

    dadosGerais.strCliCon           := qryDados.FieldByName('GER_CLICON').AsString;
    dadosGerais.strZonFra           := qryDados.FieldByName('GER_ZONFRA').AsString;
    dadosGerais.strBenCst           := qryDados.FieldByName('GER_BENCST').AsString;
    dadosGerais.strDesZon           := qryDados.FieldByName('GER_DESZON').AsString;
    dadosGerais.strRetPco           := qryDados.FieldByName('GER_RETPCO').AsString;
    dadosGerais.strRegFis           := qryDados.FieldByName('GER_REGFIS').AsString;
    dadosGerais.strCodAti           := qryDados.FieldByName('GER_CODATI').AsString;
    dadosGerais.strIESUni           := qryDados.FieldByName('GER_IESUNI').AsString;
    dadosGerais.strMicroEmpreendedor:= qryDados.FieldByName('GER_MICEMP').AsString;
    dadosGerais.strProdutorRural    := qryDados.FieldByName('GER_PRORUR').AsString;
    dadosGerais.strBeneficioREIDI   := qryDados.FieldByName('GER_BENREI').AsString;
    dadosGerais.strRegimeTributacao := qryDados.FieldByName('GER_REGTRI').AsString;
    dadosGerais.strRetIss           := qryDados.FieldByName('GER_RETISS').AsString;

    dadosGerais.fltPisRet           := qryDados.FieldByName('GER_PISRET').AsFloat;
    dadosGerais.fltCofRet           := qryDados.FieldByName('GER_COFRET').AsFloat;
    dadosGerais.fltIrfRet           := qryDados.FieldByName('GER_IRFRET').AsFloat;
    dadosGerais.fltCslRet           := qryDados.FieldByName('GER_CSLRET').AsFloat;
    dadosGerais.fltVlSgSo           := qryDados.FieldByName('GER_VLSGSO').AsFloat;

    dadosGerais.strNumDoc           := qryDados.FieldByName('FIS_NUMDOC').AsString;
    dadosGerais.strCodEmp           := qryDados.FieldByName('FIS_CODEMP').AsString;
    dadosGerais.strClaFis           := qryDados.FieldByName('GER_CLAFIS').AsString;
    dadosGerais.strCondPagamento    := qryDados.FieldByName('GER_CONPAG').AsString;
    dadosGerais.strDesCondPagamento := fTiraPipeEnter(qryDados.FieldByName('CND_DESCRI').AsString);
    dadosGerais.strFormaPagamento   := qryDados.FieldByName('GER_CODFPG').AsString;
    dadosGerais.strSerie            := qryDados.FieldByName('FIS_SERIE_').AsString;
    dadosGerais.strTip_FC           := qryDados.FieldByName('FIS_TIP_FC').AsString;
    dadosGerais.dtaDtaEnt           := qryDados.FieldByName('FIS_DTAENT').AsDateTime;
    dadosGerais.dtaDtaDoc           := qryDados.FieldByName('FIS_DTADOC').AsDateTime;
    dadosGerais.dtaHorEnt           := qryDados.FieldByName('GER_HORENT').AsDateTime;
    dadosGerais.dtaHorDoc           := qryDados.FieldByName('GER_HORENT').AsDateTime;
    dadosGerais.fltBasIcm           := qryDados.FieldByName('GER_BASICM').AsFloat;
    dadosGerais.fltAlqIcm           := 0;
    dadosGerais.fltTotIcm           := qryDados.FieldByName('GER_TOTICM').AsFloat;
    dadosGerais.fltBasRet           := qryDados.FieldByName('GER_BASRET').AsFloat;
    dadosGerais.fltTotRet           := qryDados.FieldByName('GER_TOTRET').AsFloat;
    dadosGerais.fltTotIpi           := qryDados.FieldByName('GER_TOTIPI').AsFloat;
    dadosGerais.fltBasIpi           := qryDados.FieldByName('GER_BASIPI').AsFloat;

    dadosGerais.fltBasRetBkp        := qryDados.FieldByName('GER_BASRET').AsFloat;
    dadosGerais.fltTotRetBkp        := qryDados.FieldByName('GER_TOTRET').AsFloat;
    dadosGerais.fltTotIpiBkp        := qryDados.FieldByName('GER_TOTIPI').AsFloat;

    dadosGerais.fltImpPag           := qryDados.FieldByName('GER_IMPPAG').AsFloat;
    dadosGerais.strDevSim           := qryDados.FieldByName('FIS_DEVSIM').AsString;

    dadosGerais.blnDesativaSinief_08_2026  := (fCfgSisFonte(Self, 'DES_NT') = 'S');
    dadosGerais.blnDesativaDfeReferenciado := (fCfgSisFonte(Self, 'DESREF') = 'S');

    dadosGerais.strFinalidade       := qryDados.FieldByName('FIS_FINNFE').AsString;

    If dadosGerais.strFinalidade = '5' Then
      dadosGerais.strTipoCredito    := qryDados.FieldByName('FIS_TIPFIN').AsString;

    If dadosGerais.strFinalidade = '6' Then
      dadosGerais.strTipoDebito     := qryDados.FieldByName('FIS_TIPFIN').AsString;

    If not fEmptyStr(qryDados.FieldByName('FIS_MESANO').AsString) Then
      dadosGerais.strMesAno         := qryDados.FieldByName('FIS_MESANO').AsString
    Else
      dadosGerais.strMesAno         := FormatDateTime('MM/yyyy', qryDados.FieldByName('FIS_DTAENT').AsDateTime);

    If fCampoExiste('AUXMOV', 'AUX_FEDIMP') And
       fCampoExiste('AUXNOT', 'AUX_FEDIMP') Then
      dadosGerais.fltFedImp         := qryDados.FieldByName('GER_FEDIMP').AsFloat
    Else
      dadosGerais.fltFedImp         := 0;

    If (Assigned(qryDados.FindField('FIS_NOTESP'))) Then
      dadosGerais.blnNotEsp := (qryDados.FieldByName('FIS_NOTESP').AsString = 'S');

    If fCampoExiste('AUXMOV', 'AUX_ESTIMP') And
       fCampoExiste('AUXNOT', 'AUX_ESTIMP') Then
      dadosGerais.fltEstImp         := qryDados.FieldByName('GER_ESTIMP').AsFloat
    Else
      dadosGerais.fltEstImp         := 0;

    If fCampoExiste('AUXMOV', 'AUX_MUNIMP') And
       fCampoExiste('AUXNOT', 'AUX_MUNIMP') Then
      dadosGerais.fltMunImp         := qryDados.FieldByName('GER_MUNIMP').AsFloat
    Else
      dadosGerais.fltMunImp         := 0;

    dadosGerais.fltTotPro           := qryDados.FieldByName('GER_TOTPRO').AsFloat;
    dadosGerais.fltTotFre           := qryDados.FieldByName('GER_TOTFRE').AsFloat;
    dadosGerais.fltDesEsp           := qryDados.FieldByName('GER_DESESP').AsFloat;
    dadosGerais.fltValPis           := qryDados.FieldByName('FIS_TOTPIS').AsFloat;
    dadosGerais.fltValCof           := qryDados.FieldByName('FIS_TOTCOF').AsFloat;
    dadosGerais.fltDesAce           := qryDados.FieldByName('GER_DESACE').AsFloat;
    dadosGerais.fltTotGer           := qryDados.FieldByName('GER_VLRCON').AsFloat;
    pRetirarReformaDoValorContabil;
    dadosGerais.strDocOriNC         := qryDados.FieldByName('GER_DOCORI').AsString;
    dadosGerais.strSerOriNC         := qryDados.FieldByName('GER_SERORI').AsString;
    dadosGerais.strAceOriNC         := qryDados.FieldByName('GER_ACEORI').AsString;
    dadosGerais.strDesIteNC         := qryDados.FieldByName('GER_DESITE').AsString;

    If fCampoExiste('NOTCOM', 'GER_EMPORI') Then
    Begin
      dadosGerais.strEspOriNC       := qryDados.FieldByName('GER_ESPORI').AsString;
      dadosGerais.strEmpOriNC       := qryDados.FieldByName('GER_EMPORI').AsString;
    End;

    If fCampoExiste('NOTCOM', 'GER_COMFRE') Then
      dadosGerais.blnComplementoFrete := qryDados.FieldByName('GER_COMFRE').AsString = 'S'
    Else
      dadosGerais.blnComplementoFrete := False;

    If fCampoExiste('NOTCOM', 'GER_AJUMAI') Then
      dadosGerais.blnNFAjusteICMSaMaior := qryDados.FieldByName('GER_AJUMAI').AsString = 'S'
    Else
      dadosGerais.blnNFAjusteICMSaMaior := False;

    If fCampoExiste('NOTCOM', 'GER_COMDFL') Then
      dadosGerais.blnComplementoDifal := qryDados.FieldByName('GER_COMDFL').AsString = 'S'
    Else
      dadosGerais.blnComplementoDifal := False;

    If fCampoExiste('NOTCOM', 'GER_COMCNC') Then
      dadosGerais.blnComplementoStPerfilCnc := qryDados.FieldByName('GER_COMCNC').AsString = 'S'
    Else
      dadosGerais.blnComplementoStPerfilCnc := False;

    If fCampoExiste('NOTCOM', 'GER_COMTRS') Then
      dadosGerais.blnComplementoStPerfilTrs := qryDados.FieldByName('GER_COMTRS').AsString = 'S'
    Else
      dadosGerais.blnComplementoStPerfilTrs := False;

    If fCampoExiste('NOTCOM', 'GER_COMICM') Then
      dadosGerais.blnComplementoIcms := qryDados.FieldByName('GER_COMICM').AsString = 'S'
    Else
      dadosGerais.blnComplementoIcms := (Pos('COMPLEMENTO', UpperCase(fTiraCaracEspeciais(dadosGerais.strDesIteNC))) > 0);

    If fCampoExiste('NOTCOM', 'GER_CREICM') Then
      dadosGerais.blnCreditoIcms := qryDados.FieldByName('GER_CREICM').AsString = 'S'
    Else
      dadosGerais.blnCreditoIcms := (Pos('CREDITO', UpperCase(fTiraCaracEspeciais(dadosGerais.strDesIteNC))) > 0) And
                                    (Pos('ICMS',    UpperCase(fTiraCaracEspeciais(dadosGerais.strDesIteNC))) > 0);

    If fCampoExiste('NOTCOM', 'GER_TRAICM') Then
      dadosGerais.blnTransfIcms := qryDados.FieldByName('GER_TRAICM').AsString = 'S'
    Else
      dadosGerais.blnTransfIcms := (Pos('TRANSFERENCIA', UpperCase(fTiraCaracEspeciais(dadosGerais.strDesIteNC))) > 0) And
                                   (Pos('ICMS',    UpperCase(fTiraCaracEspeciais(dadosGerais.strDesIteNC))) > 0);

    If fCampoExiste('AUXMOV', 'AUX_EST_DV') Then
      dadosGerais.blnEst_Dv := qryDados.FieldByName('GER_EST_DV').AsString = 'S'
    Else
      dadosGerais.blnEst_Dv := False;

    If fCampoExiste('NOTCOM', 'GER_COMVAL') Then
      dadosGerais.blnComplementoValor := qryDados.FieldByName('COMPLEMENTO_VALOR').AsString = 'S'
    Else
      dadosGerais.blnComplementoValor := False;

    If fCampoExiste('NOTCOM', 'GER_RESICM') Then
      dadosGerais.blnRestituicaoIcms := qryDados.FieldByName('GER_RESICM').AsString = 'S'
    Else
      dadosGerais.blnRestituicaoIcms := False;

    If fCampoExiste('NOTCOM', 'GER_COMEST') Then
      dadosGerais.blnEstornoDeCredito := qryDados.FieldByName('GER_COMEST').AsString = 'S'
    Else
      dadosGerais.blnEstornoDeCredito := False;

    If fCampoExiste('NOTCOM', 'GER_COMICM') And (qryDados.FieldByName('GER_COMICM').AsString = 'S') Then
    Begin
      dadosGerais.fltPerIcm := qryDados.FieldByName('GER_PERICM').AsFloat;
      dadosGerais.fltIcmsOP := qryDados.FieldByName('GER_ICMSOP').AsFloat;
      dadosGerais.fltPerDif := qryDados.FieldByName('GER_PERDIF').AsFloat;
      dadosGerais.fltIcmDif := qryDados.FieldByName('GER_ICMDIF').AsFloat;
      dadosGerais.fltVlrIcm := qryDados.FieldByName('GER_VALICM').AsFloat;
    End;

    dadosGerais.strMenNc01          := qryDados.FieldByName('GER_MENC01').AsString;
    dadosGerais.strMenNc02          := qryDados.FieldByName('GER_MENC02').AsString;
    dadosGerais.strMenNc03          := qryDados.FieldByName('GER_MENC03').AsString;
    dadosGerais.strMenNc04          := qryDados.FieldByName('GER_MENC04').AsString;
    dadosGerais.strMenNc05          := qryDados.FieldByName('GER_MENC05').AsString;
    dadosGerais.strMenNc06          := qryDados.FieldByName('GER_MENC06').AsString;
    dadosGerais.strMenNc07          := qryDados.FieldByName('GER_MENC07').AsString;
    dadosGerais.strMenNc08          := qryDados.FieldByName('GER_MENC08').AsString;
    dadosGerais.strMenNc09          := qryDados.FieldByName('GER_MENC09').AsString;
    dadosGerais.strMenNc10          := qryDados.FieldByName('GER_MENC10').AsString;
    dadosGerais.fltImpMer           := qryDados.FieldByName('FIS_IMPMER').AsFloat;
    dadosGerais.fltImpSeg           := qryDados.FieldByName('FIS_IMPSEG').AsFloat;
    dadosGerais.fltImpImp           := qryDados.FieldByName('FIS_IMPIMP').AsFloat;
    dadosGerais.fltBaseII           := qryDados.FieldByName('FIS_BASEII').AsFloat;
    dadosGerais.fltVaFRMM           := qryDados.FieldByName('FIS_VAFRMM').AsFloat;
    dadosGerais.fltDesAdu           := qryDados.FieldByName('FIS_DESADU').AsFloat;
    dadosGerais.fltValIOF           := qryDados.FieldByName('FIS_VALIOF').AsFloat;
    dadosGerais.fltImpPro           := qryDados.FieldByName('FIS_IMPPRO').AsFloat;
    dadosGerais.fltImpTax           := qryDados.FieldByName('FIS_IMPTAX').AsFloat;
    dadosGerais.fltImpPis           := qryDados.FieldByName('FIS_IMPPIS').AsFloat;
    dadosGerais.fltImpCof           := qryDados.FieldByName('FIS_IMPCOF').AsFloat;
    dadosGerais.fltValAdp           := qryDados.FieldByName('FIS_VALADP').AsFloat;
    dadosGerais.strImpIC1           := qryDados.FieldByName('FIS_IMPIC1').AsString;
    dadosGerais.strImpIC2           := qryDados.FieldByName('FIS_IMPIC2').AsString;

    If (fCampoExiste('AUXMOV', 'AUX_VENPRE') And (qryDados.FindField('AUX_VENPRE') <> Nil)) Then
      dadosGerais.blnVenPre := qryDados.FieldByName('AUX_VENPRE').AsString = 'S'
    Else
      dadosGerais.blnVenPre := False;

    If (dadosGerais.blnComplementoIcms Or dadosGerais.blnCreditoIcms Or dadosGerais.blnComplementoValor Or dadosGerais.blnNFAjusteICMSaMaior) And
       (fCampoExiste('NOTCOM', 'GER_PERFCP') And (Assigned(qryDados.FindField('GER_PERFCP')))) Then
    Begin
      If (dadosGerais.blnComplementoIcms Or dadosGerais.blnNFAjusteICMSaMaior) Then
      begin
        dadosGerais.fltPerFcpComplementoIcmsCapa := qryDados.FieldByName('GER_PERFCP').AsFloat;
        dadosGerais.fltValFcpComplementoIcmsCapa := qryDados.FieldByName('GER_VALFCP').AsFloat;

        if fCampoExiste('NOTCOM', 'GER_BASFCP') then
        begin
          dadosGerais.fltBasFcpComplementoIcmsCapa := qryDados.FieldByName('GER_BASFCP').AsFloat;
        end
        else
        begin
          if (fFormataFloat(dadosGerais.fltPerFcpComplementoIcmsCapa, 2) > 0) then
            dadosGerais.fltBasFcpComplementoIcmsCapa := (dadosGerais.fltValFcpComplementoIcmsCapa * 100) / dadosGerais.fltPerFcpComplementoIcmsCapa
          else
            dadosGerais.fltBasFcpComplementoIcmsCapa := 0;
        end;
      End;
      dadosGerais.blnVenPre := (qryDados.FieldByName('COM_VENPRE').AsString = 'S');
    End;

    dadosGerais.blnEntFat           := qryDados.FieldByName('GER_ENTFAT').AsString = 'S';

    dadosGerais.intTipFre := tfCif;
    If (Not qryDados.FieldByName('GER_TIPFRE').IsNull) Then
      dadosGerais.intTipFre := fConverteParaTipoNfe(IfThen(Not fPermitirFreteEmVendaPresencial, '9', qryDados.FieldByName('GER_TIPFRE').AsString));

    dadosGerais.strCgcTra           := qryDados.FieldByName('TRA_C_G_C_').AsString;
    dadosGerais.strNomTra           := qryDados.FieldByName('TRA_NOMTRA').AsString;
    dadosGerais.strIesTra           := qryDados.FieldByName('TRA_I_E_S_').AsString;
    dadosGerais.strEndTra           := qryDados.FieldByName('TRA_ENDERE').AsString;
    dadosGerais.strCidTra           := qryDados.FieldByName('TRA_NOMCID').AsString;
    dadosGerais.strEstTra           := qryDados.FieldByName('TRA_ESTADO').AsString;
    dadosGerais.intQtdTra           := qryDados.FieldByName('GER_VOLUME').AsInteger;
    dadosGerais.strEspTra           := qryDados.FieldByName('GER_ESPECI').AsString;
    dadosGerais.strMarTra           := qryDados.FieldByName('GER_MARCA_').AsString;
    dadosGerais.strNumera           := qryDados.FieldByName('AUX_NUMERA').AsString;
    dadosGerais.fltPesLiq           := qryDados.FieldByName('GER_PESLIQ').AsFloat;
    dadosGerais.fltPesBru           := qryDados.FieldByName('GER_PESBRU').AsFloat;
    dadosGerais.strPlaVei           := AnsiReplaceStr(qryDados.FieldByName('TRA_NUMPLA').AsString, '-', '');
    dadosGerais.strEmaTra           := qryDados.FieldByName('TRA_EMAIL_').AsString;

    if Assigned(qryDados.FindField('TRA_EMAILR')) then
      dadosGerais.strEmaTrr           := qryDados.FieldByName('TRA_EMAILR').AsString;

    dadosGerais.strC_Antt           := qryDados.FieldByName('TRA_C_ANTT').AsString;
    dadosGerais.strEscCre           := qryDados.FieldByName('TRA_ESCCRE').AsString;
    dadosGerais.strMotDes           := qryDados.FieldByName('CLI_MOTDES').AsString;
    dadosGerais.strEmp_TE           := qryDados.FieldByName('AUX_EMP_TE').AsString;
    If Not fEmptyStr(dadosGerais.strPlaVei) Then
      dadosGerais.strEstVei := dadosGerais.strEstTra;

    dadosGerais.strCodVen           := qryDados.FieldByName('GER_CODVEN').AsString;
    dadosGerais.strNomVen           := qryDados.FieldByName('OPE_NOMOPE').AsString;
    dadosGerais.strCodDig           := qryDados.FieldByName('GER_CODDIG').AsString;
    dadosGerais.strNomDig           := qryDados.FieldByName('OPE_NOMDIG').AsString;
    dadosGerais.strMen001           := fTiraPipeEnter(qryDados.FieldByName('GER_MEN001').AsString);
    dadosGerais.strMen002           := fTiraPipeEnter(qryDados.FieldByName('GER_MEN002').AsString);
    dadosGerais.strMen003           := fTiraPipeEnter(qryDados.FieldByName('GER_MEN003').AsString);
    dadosGerais.strMen004           := fTiraPipeEnter(qryDados.FieldByName('GER_MEN004').AsString);
    dadosGerais.strMen005           := fTiraPipeEnter(qryDados.FieldByName('GER_MEN005').AsString);

    dadosGerais.blnNfComp           := (qryDados.FieldByName('FIS_NFCOMP').AsString='S');

    If fNotaServicoEletronicaConcreto Then
      dadosGerais.fltTotSer         := qryDados.FieldByName('GER_TOTPRO').AsFloat - qryDados.FieldByName('GER_DESESP').AsFloat
    Else
      dadosGerais.fltTotSer         := qryDados.FieldByName('GER_TOTSER').AsFloat;

    dadosGerais.fltBasIss           := dadosGerais.fltTotSer;

    if dadosGerais.fltTotSer > 0 then
    begin
      dadosGerais.fltAlqPisRet := RoundTo((qryDados.FieldByName('GER_PISRET').AsFloat / dadosGerais.fltTotSer) * 100, -4);
      dadosGerais.fltAlqCofRet := RoundTo((qryDados.FieldByName('GER_COFRET').AsFloat / dadosGerais.fltTotSer) * 100, -4);
      dadosGerais.fltAlqCslRet := RoundTo((qryDados.FieldByName('GER_CSLRET').AsFloat / dadosGerais.fltTotSer) * 100, -4);
    end
    else
    begin
      dadosGerais.fltAlqPisRet := 0;
      dadosGerais.fltAlqCofRet := 0;
      dadosGerais.fltAlqCslRet := 0;
    end;

    If (qryDados.FindField('AUX_TOTSDS') <> Nil) And (qryDados.FieldByName('AUX_TOTSDS').AsFloat > 0) Then
    Begin
      dadosGerais.fltTotDescInc     := qryDados.FieldByName('AUX_TOTSDS').AsFloat;
    End;

    If (qryDados.FindField('GER_BASISS') <> Nil) And (qryDados.FieldByName('GER_BASISS').AsFloat > 0) Then
    Begin
      dadosGerais.fltBasIss         := qryDados.FieldByName('GER_BASISS').AsFloat;
    End;

    dadosGerais.fltPerIss           := qryDados.FieldByName('GER_PERISS').AsFloat;
    dadosGerais.fltValIss           := qryDados.FieldByName('GER_VALISS').AsFloat;

    dadosGerais.fltReceitaBrutaNS := qryDados.FieldByName('EMP_NSRBRU').AsFloat;

    dadosGerais.strCodObr           := qryDados.FieldByName('AUX_CODOBR').AsString;
    dadosGerais.strCodArt           := qryDados.FieldByName('AUX_CODART').AsString;
    dadosGerais.strCodCno           := qryDados.FieldByName('AUX_CODCNO').AsString;
    dadosGerais.strInsImo           := qryDados.FieldByName('AUX_INSIMO').AsString;
    dadosGerais.strCodCib           := qryDados.FieldByName('AUX_CODCIB').AsString;

    dadosGerais.strAuxEntGer         := qryDados.FieldByName('AUX_ENTGER').AsString;
    dadosGerais.strLogradouroEndEnt  := fTiraPipeEnter(qryDados.FieldByName('ETC_ENDENT').AsString);
    dadosGerais.strNumeroEndEnt      := '';
    dadosGerais.strComplementoEndEnt := fTiraPipeEnter(qryDados.FieldByName('ETC_REFENT').AsString);

    If fCampoExiste('ENTCLI', 'ETC_ENDCOM') Then
    Begin
      If not fEmptyStr(qryDados.FieldByName('ETC_ENDCOM').AsString) Then
        dadosGerais.strComplementoEndEnt := fTiraPipeEnter(qryDados.FieldByName('ETC_ENDCOM').AsString);
    End;

    dadosGerais.strBairroEndEnt      := fTiraPipeEnter(qryDados.FieldByName('ETC_BAIENT').AsString);
    dadosGerais.strCEPEndEnt         := fRetSomenteNumeros(qryDados.FieldByName('ETC_CEPENT').AsString);

    dadosGerais.strPaisEndEnt        := fRetCodigoPais(qryDados.FieldByName('ETC_CIDENT').AsString, qryDados.FieldByName('ETC_CODPAI').AsString);
    dadosGerais.strFoneEndEnt        := fLimpaCaracteresTelefone(IIF(fEmptyStr(qryDados.FieldByName('ETC_TELENT').AsString), dadosGerais.strTelefone, qryDados.FieldByName('ETC_TELENT').AsString));

    dadosGerais.strCNPJEndEnt        := qryDados.FieldByName('ETC_NUCNPJ').AsString;
    dadosGerais.strIESEndEnt         := fLimpaCaracteres(qryDados.FieldByName('ETC_I_E_S_').AsString);

    If ((fConfiguracao('IEPDRU') = 'S') and (dadosGerais.strProdutorRural = 'S')) then
      dadosGerais.strIESEndEnt       := fLimpaCaracteres(qryDados.FieldByName('ETC_I_E_S_RURAL').AsString);

    If fCampoExiste('ENTCLI', 'ETC_ENDERE') Then
    Begin
      If not fEmptyStr(qryDados.FieldByName('ETC_ENDERE').AsString) Then
      Begin
        dadosGerais.strLogradouroEndEnt  := fTiraPipeEnter(qryDados.FieldByName('ETC_ENDERE').AsString);
        dadosGerais.strNumeroEndEnt      := fTiraPipeEnter(qryDados.FieldByName('ETC_ENDNUM').AsString);
        dadosGerais.strComplementoEndEnt := fTiraPipeEnter(qryDados.FieldByName('ETC_ENDCOM').AsString);
      End;
    End;

    pRetornaDadosIbge(qryDados.FieldByName('ETC_CIDENT').AsString,
                      dadosGerais.strCodIbgeEntrega,
                      dadosGerais.strUfIbgeEntrega,
                      dadosGerais.strEstadoEndEnt,
                      dadosGerais.strNomCidEndEnt);

    If fEmptyStr(dadosGerais.strCodIbgeEntrega) Or (dadosGerais.strConsum = 'S') Then
    Begin
      dadosGerais.strCodIbgeEntrega := dadosGerais.strCodIbge;
      dadosGerais.strUfIbgeEntrega  := dadosGerais.strUfIbge;

      dadosGerais.strLogradouroEndEnt  := fTiraPipeEnter(dadosGerais.strLogradouro);
      dadosGerais.strNumeroEndEnt      := fTiraPipeEnter(dadosGerais.strNumeroEnd);
      dadosGerais.strComplementoEndEnt := fTiraPipeEnter(dadosGerais.strComplementoEnd);
      dadosGerais.strBairroEndEnt      := fTiraPipeEnter(dadosGerais.strBairro);
      dadosGerais.strCEPEndEnt         := dadosGerais.strCEP;
      dadosGerais.strEstadoEndEnt      := dadosGerais.strEstado;
    End;

    If Length(fLimpaCaracteres(dadosGerais.strLogradouro)) <= 1 Then
      dadosGerais.strLogradouro := 'N/D';

    If Length(dadosGerais.strLogradouroEndEnt) <= 1 Then
      dadosGerais.strLogradouroEndEnt := 'N/D';

    If fEmptyStr(dadosGerais.strNumeroEndEnt) Or (dadosGerais.strNumeroEndEnt = 'SN') Then
    begin
      recCliEnd := fGetParteEndereco(dadosGerais.strLogradouroEndEnt);

      If (Not fEmptyStr(recCliEnd.strNumero)) And (dadosGerais.strConsum = 'S') Then
      Begin
        dadosGerais.strLogradouroEndEnt  := recCliEnd.strLograd;
        dadosGerais.strNumeroEndEnt      := recCliEnd.strNumero;
        dadosGerais.strComplementoEndEnt := recCliEnd.strComple;
      End
      Else
      Begin
        dadosGerais.strNumeroEndEnt := 'SN';
      End;
    end;

    strCFG_NATOPA := Trim(fCfgSisFonte(Self, 'NATOPA'));

    If (dadosGerais.strOpcDoc = 'CA') And (Not fEmptyStr(strCFG_NATOPA)) Then
    Begin
      dadosGerais.strDescricaoClaFis := strCFG_NATOPA;
    End
    Else If (dadosGerais.strDevSim = 'S') Then
    Begin
      dadosGerais.strDescricaoClaFis := 'ANULAÇÃO DA OPERAÇÃO - AJUSTE SINIEF 13/24';
    End
    Else
    Begin
      If (Not fDeveConcatenarAsNaturezas) Then
      Begin
        dadosGerais.strDescricaoClaFis  := fReceberApenasUmaNaturezaDeOperacao(qryDados.FieldByName('CFO_NATOPE_01').AsString,
                                                                               qryDados.FieldByName('CFO_NATOPE_02').AsString,
                                                                               qryDados.FieldByName('CFO_NATOPE_03').AsString,
                                                                               qryDados.FieldByName('CFO_NATOPE_04').AsString);
      End
      Else
      Begin
        dadosGerais.strDescricaoClaFis  := qryDados.FieldByName('CFO_NATOPE_01').AsString;
        If Not (fEmptyStr(qryDados.FieldByName('CFO_NATOPE_02').AsString)) Then
        Begin
          dadosGerais.strDescricaoClaFis := dadosGerais.strDescricaoClaFis + '/' +
            qryDados.FieldByName('CFO_NATOPE_02').AsString;
        End;

        If Not (fEmptyStr(qryDados.FieldByName('CFO_NATOPE_03').AsString)) Then
        Begin
          dadosGerais.strDescricaoClaFis := dadosGerais.strDescricaoClaFis + '/' +
            qryDados.FieldByName('CFO_NATOPE_03').AsString;
        End;

        If Not (fEmptyStr(qryDados.FieldByName('CFO_NATOPE_04').AsString)) Then
        Begin
          dadosGerais.strDescricaoClaFis := dadosGerais.strDescricaoClaFis + '/' +
            qryDados.FieldByName('CFO_NATOPE_04').AsString;
        End;
      End;
    End;

    If fCampoExiste('MOVOBS', 'MOV_STAOFF') And (qryDados.FindField('MOV_STAOFF') <> Nil) Then
      dadosGerais.strStaOffLine := qryDados.FieldByName('MOV_STAOFF').AsString
    Else
      dadosGerais.strStaOffLine := '';

    If fCampoExiste('MOVOBS', 'MOV_DTEOFF') And (qryDados.FindField('MOV_DTEOFF') <> Nil) Then
      dadosGerais.dtaDteOffLine := qryDados.FieldByName('MOV_DTEOFF').AsDateTime;

    If fCampoExiste('MOVOBS', 'MOV_XMLOFF') And (qryDados.FindField('MOV_XMLOFF') <> Nil) Then
      dadosGerais.strXmlOffLine := qryDados.FieldByName('MOV_XMLOFF').AsString
    Else
      dadosGerais.strXmlOffLine := '';

    If fCampoExiste('MOVOBS', 'MOV_CNFNFE') And (qryDados.FindField('MOV_CNFNFE') <> Nil) Then
    Begin
      dadosGerais.strMensagemAplicacao := qryDados.FieldByName('MOV_CNFNFE').AsString
    End
    Else
    Begin
      dadosGerais.strMensagemAplicacao := qryDados.FieldByName('MOV_OBSERV').AsString;

      If (fCfgSisFonte(Self, 'AXCFNS') = 'S') Then
      Begin
        If (Pos('Informacoes:', dadosGerais.strMensagemAplicacao) > 0) Then
          dadosGerais.strMensagemAplicacao := Copy(dadosGerais.strMensagemAplicacao, 1, Pos('Informacoes:', dadosGerais.strMensagemAplicacao)-1)
        Else If (Pos('Vendedor:', dadosGerais.strMensagemAplicacao) > 0) Then
          dadosGerais.strMensagemAplicacao := Copy(dadosGerais.strMensagemAplicacao, 1, Pos('Vendedor:', dadosGerais.strMensagemAplicacao)-1);
      End;
    End;

    If (fCampoExiste('MOVOBS', 'MOV_CNFFIS') And (qryDados.FindField('MOV_CNFFIS') <> Nil)) Then
      dadosGerais.strMensagemFiscalCnf := qryDados.FieldByName('MOV_CNFFIS').AsString
    Else If (fCampoExiste('MOVOBS', 'MOV_OBSFIS') And (qryDados.FindField('MOV_OBSFIS') <> Nil)) Then
      dadosGerais.strMensagemFiscalCnf := qryDados.FieldByName('MOV_OBSFIS').AsString
    Else
      dadosGerais.strMensagemFiscalCnf := '';

    If (Trim(qryDados.FieldByName('GER_SEROBS').AsString)<>'') Then
     dadosGerais.strMensagemAplicacao := dadosGerais.strMensagemAplicacao +
                                         IfThen(Trim(dadosGerais.strMensagemAplicacao)<>'', #13#10, '') +
                                         qryDados.FieldByName('GER_SEROBS').AsString;

     If (qryDados.FindField('GER_DISSER') <> Nil) And (Not fEmptyStr(qryDados.FieldByName('GER_DISSER').AsString)) Then
      dadosGerais.strDisSer := qryDados.FieldByName('GER_DISSER').AsString
    Else
      dadosGerais.strDisSer := '';

    If (qryDados.FieldByName('MOV_IPDPNF').IsNull) Then
      dadosGerais.blnImprimirDuplicatas := True
    Else
      dadosGerais.blnImprimirDuplicatas := (qryDados.FieldByName('MOV_IPDPNF').AsInteger=1);

    If (qryDados.FieldByName('MOV_IPDPCI').IsNull) Then
      dadosGerais.blnImprimirDuplicatasConfCI := False
    Else
      dadosGerais.blnImprimirDuplicatasConfCI := (qryDados.FieldByName('MOV_IPDPCI').AsInteger = 1 );

    If Not (qryDados.FieldByName('MOV_DTESNF').IsNull) Then
    Begin
      dadosGerais.dtaDtaDoc := qryDados.FieldByName('MOV_DTESNF').AsDateTime;
      dadosGerais.dtaHorDoc := qryDados.FieldByName('MOV_HRESNF').AsDateTime;
    End;

    dadosGerais.strNatSer := qryDados.FieldByName('GER_SERNAT').AsString;
    dadosGerais.strNtOpNS := qryDados.FieldByName('GER_MUNPRE').AsString;
    dadosGerais.strStReEs := qryDados.FieldByName('GER_STREES').AsString;
    dadosGerais.strPrStRe := qryDados.FieldByName('GER_PRSTRE').AsString;
    dadosGerais.fltBasOrg := qryDados.FieldByName('GER_BASORG').AsFloat;
    dadosGerais.fltIcmOrg := qryDados.FieldByName('GER_ICMORG').AsFloat;
    dadosGerais.fltBasVrd := qryDados.FieldByName('AUX_BASVRD').AsFloat;
    dadosGerais.fltVrdIcm := qryDados.FieldByName('AUX_VRDICM').AsFloat;

    dadosGerais.blnOrgPub := (SameText(qryDados.FieldByName('GER_ORGPUB').AsString, 'S'));
    dadosGerais.strOrPuRD := qryDados.FieldByName('GER_ORPURD').AsString;
    dadosGerais.blnCalIcm := (SameText(qryDados.FieldByName('GER_CALICM').AsString, 'S'));
    dadosGerais.blnIndust := (SameText(qryDados.FieldByName('GER_INDUST').AsString, 'S'));

    dadosGerais.strEntGov := qryDados.FieldByName('GER_ENTGOV').AsString;
    dadosGerais.strTpOpEg := qryDados.FieldByName('GER_TPOPEG').AsString;

    dadosGerais.blnComVal := qryDados.FieldByName('GER_COMVAL').AsString = 'S';
    dadosGerais.strDocsPD := qryDados.FieldByName('GER_LISPED').AsString;

    dadosGerais.strTemRefFis := qryDados.FieldByName('GER_REFFIS').AsString;

    dadosGerais.strInfAdEnt := fGetDadosAdicionaisReferenteAEntrega;

    If Not fEmptyStr(qryDados.FieldByName('GER_SITP_C').asString) Then
    Begin
      dadosGerais.strSitP_C := qryDados.FieldByName('GER_SITP_C').AsString;
      dadosGerais.strMenP_C := qryDados.FieldByName('GER_MENP_C').AsString;
    End;

    If Not fEmptyStr(qryDados.FieldByName('GER_SITIPI').asString) Then
    Begin
      dadosGerais.strSitIPI   := qryDados.FieldByName('GER_SITIPI').AsString;
      dadosGerais.strEnqIPI   := qryDados.FieldByName('GER_ENQIPI').AsString;
      dadosGerais.strMenIPI   := qryDados.FieldByName('GER_MENIPI').AsString;
    End;

    dadosGerais.strPerfil := fGetTipAbfSaida(
                             IIF(Length(qryDados.FieldByName('GER_CGCCON').AsString) <= 11, 'F', 'J'),
                                        qryDados.FieldByName('GER_IESCON').AsString,
                                        qryDados.FieldByName('GER_PRORUR').AsString,
                                        qryDados.FieldByName('GER_MICEMP').AsString,
                                        qryDados.FieldByName('GER_CLICON').AsString,
                                        qryDados.FieldByName('GER_CODATI').AsString,
                                        qryDados.FieldByName('GER_REGTRI').AsString,
                                        qryDados.FieldByName('GER_INDUST').AsString,
                                        qryDados.FieldByName('GER_CLIFIL').AsString = 'S');
    If FTip_FC = 'F' Then
    begin
      dadosGerais.strPerfil := fGetTipoAbfFornecedor(qryDados.FieldByName('GER_CODCLI').AsString);
    end;

    dadosGerais.fltBasIcmSimples := qryDados.FieldByName('GER_BASSIM').AsFloat;

    dadosGerais.strDesativaTagsDesoneracao := qryDados.FieldByName('GER_NOTDES').AsString;

    If pos(dadosGerais.strFinalidade, '5_6_') > 0 Then
      dadosGerais.strDesativaTagsDesoneracao := 'S';

    dadosGerais.strNaturezaServico := qryDados.FieldByName('GER_NATSER').AsString;

    dadosGerais.strIprNum := fCfgSisFonte(Self, 'IPRNUM');
    dadosGerais.strIprOri := fCfgSisFonte(Self, 'IPRORI');
    dadosGerais.strIprTip := fCfgSisFonte(Self, 'IPRTIP');

    pCarregaDuplicatas(dadosGerais);
    pCarregaDuplicatasOutrasNotas(dadosGerais);
    pCarregaTotalDuplicataRecebida(dadosGerais);
    pVerificaSeImprimePalavraAVistaDuplicata(dadosGerais);
    pAgrupaDocumentosFaturadosPorVendedor(dadosGerais);

    pRetDadosNotaOrigem(dadosGerais.dtaDtaOriNC);

    If dadosGerais.blnNfComp Then
    Begin
      If (qryDados.FindField('FIS_CSTENT') <> Nil) Then
        dadosGerais.strCodSit := qryDados.FieldByName('FIS_CSTENT').AsString
      Else
        dadosGerais.strCodSit := '';

      dadosGerais.strClaFis := qryDados.FieldByName('FIS_CLFSC1').AsString;

      If Trim(qryDados.FieldByName('FIS_HISTOR').AsString) <> '' Then
        dadosGerais.strDescricaoClaFis := qryDados.FieldByName('FIS_HISTOR').AsString
      Else
        dadosGerais.strDescricaoClaFis := fRetDesCla(dadosGerais.strClaFis);

      If dadosGerais.blnTransfIcms Then
      Begin
        If SameText(dadosGerais.strClaFis, '5601') Then
          dadosGerais.strDescricaoClaFis := 'TRANSFERÊNCIA DE CRÉDITO ACUMULADO DE ICMS'
        Else If SameText(dadosGerais.strClaFis, '5602') Then
          dadosGerais.strDescricaoClaFis := 'TRANSF. DE CRÉDITO DE ICMS'
        Else If SameText(dadosGerais.strClaFis, '5605') Then
          dadosGerais.strDescricaoClaFis := 'TRANSF.DE SALDO DEV. DE ICMS DE OUTRO ESTAB.P/ MESMA EMPRESA';
      End
      Else If (dadosGerais.blnComplementoValor) Then
        dadosGerais.strDescricaoClaFis := 'NF COMPLEMENTAR DE VALOR';

      If (dadosGerais.blnNFAjusteICMSaMaior) Then
        dadosGerais.strDescricaoClaFis := '999 - AJUSTE DE DFE EMITIDO COM VALOR OU DESTAQUE SUPERIOR';

      If (dadosGerais.blnComplementoFrete) Then
        dadosGerais.strDescricaoClaFis := 'COMPLEMENTO DE FRETE';

      dadosGerais.fltTotGer := 0;
      dadosGerais.fltTotPro := 0;
      dadosGerais.fltBasIcm := 0;
      dadosGerais.fltTotIcm := 0;
      dadosGerais.fltAlqIcm := 0;
      dadosGerais.fltBasRet := 0;
      dadosGerais.fltTotRet := 0;
      dadosGerais.fltTotIpi := 0;
      dadosGerais.fltBasIpi := 0;

      For intLivFis := 1 To 8 Do
      Begin
        If not Assigned(qryDados.FindField('FIS_CLFSC' + intToStr(intLivFis))) Then
          Continue;

        If fEmptyStr(qryDados.FieldByName('FIS_CLFSC' + intToStr(intLivFis)).AsString) Then
          Continue;

        dadosGerais.fltTotGer := dadosGerais.fltTotGer + qryDados.FieldByName('FIS_VLCON' + intToStr(intLivFis)).AsFloat;
        dadosGerais.fltTotPro := dadosGerais.fltTotPro + qryDados.FieldByName('FIS_VLCON' + intToStr(intLivFis)).AsFloat;
        dadosGerais.fltBasIcm := dadosGerais.fltBasIcm + qryDados.FieldByName('FIS_BASIC' + intToStr(intLivFis)).AsFloat;
        dadosGerais.fltTotIcm := dadosGerais.fltTotIcm + qryDados.FieldByName('FIS_VLRIC' + intToStr(intLivFis)).AsFloat;

        If (qryDados.FieldByName('FIS_BASIC' + intToStr(intLivFis)).AsFloat <> 0) And
           (qryDados.FieldByName('FIS_ALQIC' + intToStr(intLivFis)).AsFloat <> 0) Then
        Begin
          dadosGerais.fltAlqIcm := qryDados.FieldByName('FIS_ALQIC' + intToStr(intLivFis)).AsFloat;
        End;

        If intLivFis > 1 Then
          dadosGerais.fltAlqIcm := 0;

        dadosGerais.fltBasRet   := dadosGerais.fltBasRet + qryDados.FieldByName('FIS_BCRET' + intToStr(intLivFis)).AsFloat;
        dadosGerais.fltTotRet   := dadosGerais.fltTotRet + qryDados.FieldByName('FIS_RETID' + intToStr(intLivFis)).AsFloat;
        dadosGerais.fltTotIpi   := dadosGerais.fltTotIpi + qryDados.FieldByName('FIS_VLRIP' + intToStr(intLivFis)).AsFloat;
        dadosGerais.fltBasIpi   := dadosGerais.fltBasIpi + qryDados.FieldByName('FIS_BASIP' + intToStr(intLivFis)).AsFloat;
        dadosGerais.fltBasFcpST := dadosGerais.fltBasFcpST + qryDados.FieldByName('FIS_BFCPS' + intToStr(intLivFis)).AsFloat;
        dadosGerais.fltTotFcpST := dadosGerais.fltTotFcpST + qryDados.FieldByName('FIS_VFCPS' + intToStr(intLivFis)).AsFloat;
      End;

      pCarregaItensNotaComp(dadosGerais, qryDados.FieldByName('FIS_AUTOINCREM').AsString);
    End;

    dadosGerais.strMotivoEstorno := qryDados.FieldByName('FIS_ESTMOT').AsString;

    dadosGerais.fltAlqFcpST := qryDados.FieldByName('FIS_ALQFCP').AsFloat;

    dadosGerais.strNfCIAP := qryDados.FieldByName('FIS_NFCIAP').AsString;
    dadosGerais.strCstIPI := qryDados.FieldByName('FIS_CSTIPI').AsString;
    dadosGerais.strCstPIS := qryDados.FieldByName('FIS_CSTPIS').AsString;
    dadosGerais.strCstCOF := qryDados.FieldByName('FIS_CSTCOF').AsString;

    dadosGerais.strEspDoc := FEspDoc;

    dadosGerais.strUFEmba := qryDados.FieldByName('EXP_UFEMBA').AsString;
    dadosGerais.strLoEmba := qryDados.FieldByName('EXP_LOEMBA').AsString;
    dadosGerais.strLocDes := qryDados.FieldByName('EXP_LOCDES').AsString;
    dadosGerais.strEndToEndIdPixPedido := qryDados.FieldByName('MPX_END_ID').AsString;

    If qryDados.FieldByName('FGO_ORIGEM').AsString = 'AKZO NOBEL' then
      pCarregaChavesReferenciadasAKZ(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp)
    Else
      pCarregaChavesReferenciadas(dadosGerais);

    pPreparaChavesReferenciadasDevolucao;

    If (FEspDoc = 'NS') Then
      pCarregaDadosNFSeSubstituicao(dadosGerais, qryDados.FieldByName('FIS_AUTOINCREM').AsString);

    pCarregaInformacoesDoIntermediadorDaTransacao(dadosGerais);

    If dadosGerais.blnNotEsp Then
      pCarregarFormaPagamentoNotaEspecial(dadosGerais)
    Else
      pCarregarFormasPagamento(dadosGerais);

    If (dadosGerais.strFinalidade = '6') Then
      pCarregarFormasPagamentoMultas_e_Juros(dadosGerais);

    dadosGerais.strNumPok := qryDados.FieldByName('FGO_NUMPOK').AsString;
    dadosGerais.strPedSit := qryDados.FieldByName('FGO_PEDSIT').AsString;

    dadosGerais.blnNFCeOffLine := not fEmptyStr(dadosGerais.strXmlOffLine);

    dadosGerais.fltAliquotaIRRF   := qryDados.FieldByName('GER_ALQIRF').AsFloat;
    dadosGerais.fltAliquotaCSLL   := qryDados.FieldByName('GER_ALQCSL').AsFloat;
    dadosGerais.fltBasePIS        := qryDados.FieldByName('FIS_BASPIS').AsFloat;
    dadosGerais.fltAliquotaPIS    := qryDados.FieldByName('FIS_ALQPIS').AsFloat;
    dadosGerais.fltBaseCOFINS     := qryDados.FieldByName('FIS_BASCOF').AsFloat;
    dadosGerais.fltAliquotaCOFINS := qryDados.FieldByName('FIS_ALQCOF').AsFloat;
    dadosGerais.strIdNFSeSub      := qryDados.FieldByName('FIS_NFSSUB').AsString;
    dadosGerais.strEntFutOpc      := qryDados.FieldByName('AUX_ENFUOP').AsString;
    dadosGerais.fltTotIpiEntFut   := qryDados.FieldByName('AUX_TIPIBF').AsFloat;
    dadosGerais.fltTotRetEntFut   := qryDados.FieldByName('AUX_TRETBF').AsFloat;
    dadosGerais.fltTotFcpSTEntFut := qryDados.FieldByName('AUX_TFSTBF').AsFloat;
    dadosGerais.dtaCompetencia    := fRetornaDataDeCompetenciaNFS(qryDados.FieldByName('FIS_NFSSUB').AsString);

    if (fCampoExiste('AUXMOV', 'AUX_NUMDRW') and fCampoExiste('AUXNOT', 'AUX_NUMDRW')) then
      dadosGerais.strNumeroDrawback := qryDados.FieldByName('AUX_NUMDRW').AsString;

    dadosGerais.strMsgAtoDeclaratorioDF := qryDados.FieldByName('CLI_MSATDF').AsString;

    if fTabelaExiste('OMOCLI') then
      dadosGerais.strOrdMaoObraCli := qryDados.FieldByName('OMO_MAOCLI').AsString;

    dadosGerais.strOriundoOS := qryDados.FieldByName('GER_CONEQU').AsString;
    dadosGerais.strObsNFSOrdServ := qryDados.FieldByName('EQU_OBSNFS').AsString;

    dadosGerais.blnEnviaEnderecoDeEntrega := fEnviaEnderecoDeEntrega;

    dadosGerais.blnInconsistenciaEFD_Gravar := False;
    If (qryDados.FieldByName('CHAVE_TABELA').AsString = 'NOTDET') Then
    Begin
      dadosGerais.blnInconsistenciaEFD_Gravar := Not fEmptyStr(qryDados.FieldByName('EFD_SEQGER').AsString);
      dadosGerais.strInconsistenciaEFD_RefNfe := qryDados.FieldByName('EFD_REFNFE').AsString;
      dadosGerais.strInconsistenciaEFD_InfAdc := qryDados.FieldByName('EFD_INFADC').AsString;
      dadosGerais.strInconsistenciaEFD_Identi := qryDados.FieldByName('EFD_IDENTI').AsString;
      dadosGerais.strInconsistenciaEFD_Period := qryDados.FieldByName('EFD_PERIOD').AsString;
    End;

    If fCampoExiste('CADOPE', 'OPE_NUMCPF') Then
      dadosGerais.strCpfVen := qryDados.FieldByName('OPE_NUMCPF').AsString;

    If fCampoExiste('MOVOBS', 'MOV_XCAMPO') Then
      dadosGerais.strXCampo := qryDados.FieldByName('MOV_XCAMPO').AsString
    Else
      dadosGerais.strXCampo := EmptyStr;

    If fCampoExiste('MOVOBS', 'MOV_XTEXTO') Then
      dadosGerais.strXTexto := qryDados.FieldByName('MOV_XTEXTO').AsString
    Else
      dadosGerais.strXTexto := EmptyStr;

    If fEhTipoOperacaoContaOrdem(
         dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp) Then
    Begin
      If fDocumentoComRemessaContaOrdem(
           dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp) Then
      Begin
        pCarregaChavesReferenciadasRemessaContaOrdem(
          dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp);
      End;
    End;

    If (dadosGerais.strOpcDoc = 'DV') And (qryDados.FieldByName('DET_ESPDEV').AsString = 'IF') Then
    Begin
      dadosGerais.strNotasDeCupomComIPI := fRetornaNotasDeCupomComIPI(dadosGerais.strNumDoc,
                                                                      dadosGerais.strEspDoc,
                                                                      dadosGerais.strCodEmp,
                                                                      dadosGerais.strCodCli);
    End;

    pReformaTributariaCreditoDebito;

  End;

  Result := dadosGerais;

end;

function TFonteDadosBD.fEhCupomEletronicoSAT(
  AdadosGerais: TDadosGerais): boolean;
begin
  Result := ((fConfiguracao('USASAT') = 'S') And (AdadosGerais.strEspDoc = 'IF'));
end;

function TFonteDadosBD.fEhDocumentoNGMultiplasChavesRefernciada: Boolean;
begin
  Result := False;
  if Not Assigned(QryDados) then
    Exit;

  if QryDados.IsEmpty then
    Exit;

  if Not Assigned(qryDados.FieldByName('GER_OPCDOC')) then
    Exit;

  if Not Assigned(qryDados.FieldByName('DET_DOCDEV')) then
    Exit;

  if Not Assigned(qryDados.FieldByName('DET_ESPDEV')) then
    Exit;

  if Not Assigned(qryDados.FieldByName('DET_EMPDEV')) then
    Exit;

  if (qryDados.FieldByName('GER_OPCDOC').AsString <> 'NG') then
    Exit;

  qryDados.First;
  Try
    While ((Not QryDados.Eof) and (Not Result)) do
    begin
      if qryDados.FieldByName('DET_ESPDEV').AsString = 'NF' Then
        Result := (Trim(qryDados.FieldByName('DET_DOCDEV').AsString) <> '') and (Trim(qryDados.FieldByName('DET_EMPDEV').AsString) <> '');

       qryDados.Next;
    end;

  Finally
    qryDados.First;
  End;
end;

function TFonteDadosBD.fEhOrdemPagamentoSemPixSat007(const AstrVersao, AstrModalidade, AstrPix: String; AdadosGerais: TDadosGerais): Boolean;
begin
  Result := False ;
  if AstrVersao <> '0.07' then
    Exit ;

  if AstrModalidade <> '012' then
    Exit ;

  if AstrPix = 'S' then
    Exit ;

  if not fEhCupomEletronicoSAT(AdadosGerais) then
    Exit ;

  Result := True ;
end;

function TFonteDadosBD.fEhOrdemPagamentoSatEquipamentoNaoSuportaCod16Ou17(const AstrModalidade: String; AdadosGerais: TDadosGerais): Boolean;
begin
  Result := False ;

  if AstrModalidade <> '012' then
    Exit ;

  if not fEhCupomEletronicoSAT(AdadosGerais) then
    Exit ;

  if trim(fConfiguracao('ORDSAT')) = '' then
    Exit ;

  Result := True ;
end ;

function TFonteDadosBD.fValCfgOrdemPagamentoSatEquipamentoNaoSuportaCod16Ou17(const AstrModalidade: String; AdadosGerais: TDadosGerais): String;
begin
  Result := '99' ;

  if AstrModalidade <> '012' then
    Exit ;

  if not fEhCupomEletronicoSAT(AdadosGerais) then
    Exit ;

  if trim(fConfiguracao('ORDSAT')) = '' then
    Exit ;

  Result := fConfiguracao('ORDSAT') ;
end;

function TFonteDadosBD.fEhTipoOperacaoContaOrdem(const strNumDoc, strEspDoc,
  strCodEmp: String): Boolean;
Var
  qryConsulta: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := False;

  If (Trim(fCfgSisFonte(Self, 'HBFPRC')) = 'N') Then
    Exit;

  If Not fCampoExiste('AUXMOV', 'AUX_AUTRCO') Then
    Exit;

  qryConsulta := fCriaQuery(Nil);
  Try
    If (qryDados.FieldByName('CHAVE_TABELA').AsString = 'MOVGER') Or
       (qryDados.FieldByName('CHAVE_TABELA').AsString = 'MOVDET') Then
    Begin
      qryConsulta.SQL.Text := 'SELECT '
                            + '       F.FGO_TIPOPE '
                            + '  FROM FATGOR F '
                            + ' INNER JOIN MOVGER G ON G.GER_NUMDOC = F.FGO_NUMFAT '
                            + '                    AND G.GER_ESPDOC = F.FGO_TIPFAT '
                            + '                    AND G.GER_CODEMP = F.FGO_EMPFAT '
                            + ' WHERE G.GER_NUMDOC = :NUMDOC '
                            + '   AND G.GER_ESPDOC = :ESPDOC '
                            + '   AND G.GER_CODEMP = :CODEMP ';
    End
    Else
    Begin
      qryConsulta.SQL.Text := 'SELECT '
                            + '       F.FGO_TIPOPE '
                            + '  FROM FATGOR F '
                            + ' INNER JOIN MOVGER G ON G.GER_NUMDOC = F.FGO_NUMFAT '
                            + '                    AND G.GER_ESPDOC = F.FGO_TIPFAT '
                            + '                    AND G.GER_CODEMP = F.FGO_EMPFAT '
                            + ' INNER JOIN NOTGER N ON N.GER_NUMDOC = G.GER_NUMFAT '
                            + '                    AND N.GER_ESPDOC = G.GER_TIPFAT '
                            + '                    AND N.GER_CODEMP = G.GER_EMPFAT '
                            + ' WHERE N.GER_NUMDOC = :NUMDOC '
                            + '   AND N.GER_ESPDOC = :ESPDOC '
                            + '   AND N.GER_CODEMP = :CODEMP ';
    End;

    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;
    qryConsulta.Open;

    Result := (qryConsulta.FieldByName('FGO_TIPOPE').AsString = 'C');

    qryConsulta.Close;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TFonteDadosBD.fEmiteNCMPorLinhaDeTinta: Boolean;
begin
  Result := (fConfiguracao('NCMTIN') = 'S');
end;

function TFonteDadosBD.fExecutaQuery(strSQL: String;
  arrParametros: array of String; arrValores: array of Variant): TDataSet;
  Var
    qryRes: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    intContador: Integer;
begin
  qryRes := fCriaQuery(Nil);
  qryRes.SQL.Add(strSQL);

  For intContador := Low(arrParametros) To High(arrParametros) Do
  Begin
    qryRes.ParamByName(arrParametros[intContador]).Value := arrValores[intContador];
  End;
  qryRes.Open;

  Result := qryRes;
end;

function TFonteDadosBD.fNotaComplemento(strNumDoc, strEspDoc, strCodEmp,
  strCodCli, strSerie, strTip_FC: String): Boolean;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  try
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  FIS_NFCOMP ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  CADFIS ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  FIS_TIP_FC = :TIP_FC AND ');
    qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  FIS_FORCLI = :CODCLI AND ');
    qryAux.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ ');

    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie;

    qryAux.Open;

    Result := (qryAux.FieldByName('FIS_NFCOMP').AsString = 'S');
  finally
    FreeAndNil(qryAux);
  end;
end;

function TFonteDadosBD.fParteInteira(fltValor: Double): Double;
Var
  strValor: String;
begin
  strValor := FloatToStrf(fltValor, ffFixed, 9, StrToInt(fConfiguracao('DECUNI')));

  If Pos(',', strValor) > 0 Then
    Result := fStrToFloat(Copy(strValor, 1, Pos(',', strValor)))
  Else
    Result := fStrToFloat(strValor);
end;

function TFonteDadosBD.fProximoItem: TDadosItem;
begin

  Result := Nil;

  If (Assigned(qryDados)) And
     (qryDados.FieldByname('GER_NUMDOC').IsNull) Then
  Begin
    Exit;
  End;

  Result := TDadosItem(lstItens[intPosAtual]);

  Inc(intPosAtual);
End;

function TFonteDadosBD.fAdicionaItem(intIndice, intIndColSer: Integer): TDadosItem;
  const
    METRO_LINEAR_IMPRIME_METRAGEM_TOTAL : String = '2';

  Var
    strNFEObserv: String;
    strTipAbfSai: String;
    ValorAliquotaIBPT: TValorAliquotaIBPT;
    blnEnvioFornecedor: Boolean;
    strFabLot: String;
    strValLot: String;
    fltUnitTrib : Double;
    fltQtdeTrib : Double;
    fltTotiTrib : Double;
    fltFator: Double;

  function fRetornaNumsPedidoCompra(strNumDoc, strEspDoc, strCodCli, strCodEmp: String): String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  begin
    Result := '';

    If Not fTabelaExiste('NUMCMP') Then
      Exit;

    If fEmptyStr(strNumDoc+strEspDoc+strCodEmp) Then
      Exit;

    qryAux := fCriaQuery(Nil);
    Try
      Try
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add('   SELECT                        ');
        qryAux.SQL.Add('     CMP_NUMCMP                  ');
        qryAux.SQL.Add('   FROM                          ');
        qryAux.SQL.Add('     NUMCMP                      ');
        qryAux.SQL.Add('   WHERE CMP_NUMDOC = :NUMDOC    ');
        qryAux.SQL.Add('     AND CMP_ESPDOC = :ESPDOC    ');
        qryAux.SQL.Add('     AND CMP_CODCLI = :CODCLI    ');
        qryAux.SQL.Add('     AND CMP_CODEMP = :CODEMP    ');
        qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
        qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
        qryAux.ParamByName('CODCLI').AsString := strCodCli;
        qryAux.ParamByName('CODEMP').AsString := strCodEmp;
        qryAux.Open;

        If qryAux.RecordCount > 0 Then
        Begin
          qryAux.First;
          While Not qryAux.Eof Do
          Begin

            Result := Result + qryAux.FieldByName('CMP_NUMCMP').AsString;

            qryAux.Next;

            If Not (qryAux.Eof) Then
              Result := Result + ',';

          End;

          Result := Trim(StringReplace(Result, '|', '/', [rfReplaceAll]));
        End;

        qryAux.Close;
      Except
        On E: Exception Do
          raise Exception.Create(E.Message + ' [TFonteDadosBD.fRetornaNumsPedidoCompra]');
      End;
    Finally
      FreeAndNil(qryAux);
    End;
  End;

  function fRetImpPagItem(item:TDadosItem):Double;
    Var
      fltPeImPg: Double;
      strCfgImpPag: String;
  begin
    Result := 0;

    strCfgImpPag := fConfiguracao('IMPPAG');
    If Not fEmptyStr(strCfgImpPag) Then
    Begin
      If strCfgImpPag = '1' Then
        fltPeImPg := qryDados.FieldByName('ABF_PEIMPG').AsFloat
      Else
        fltPeImPg := fBuscaAlqIBPT(fTiraCaracEspeciais(item.strClaIpi), (LeftStr(item.strCodSit,1) <> '0'));

      Result := fArredondaABNT_NBR5891_77((item.fltTotIte-item.fltDesEsp) * fltPeImPg / 100, 2);
    End;
  end;

  function fEhVendaMetroLinear: Boolean;
  begin
    Result := (fTabelaExiste('MOVMAD')) And
              (fConfiguracao('VENMTL') = 'S') And
              (qryDados.FindField('DET_QTDPEC') <> Nil) And
              (qryDados.FieldByName('DET_QTDPEC').AsFloat > 0) And
              ((qryDados.FieldByName('DET_COMPEC').AsFloat +
                qryDados.FieldByName('DET_LARPEC').AsFloat +
                qryDados.FieldByName('DET_ESPPEC').AsFloat + 0) > 0);
  end;

  function fEhVendaMetroLinearENaoImprimeMetragemTotal: boolean;
  begin
    Result := ((fEhVendaMetroLinear) And (fConfiguracao('NFEMTL') <> METRO_LINEAR_IMPRIME_METRAGEM_TOTAL));
  end;

  function fDocumentoCalculaFundoDeCombateGB: Boolean;
  var
    qryDocDev : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  begin
    Result := True;

    If not (qryDados.FieldByName('GER_OPCDOC').AsString = 'DV') Then
      Exit;

    qryDocDev := fCriaQuery(nil);
    try
      qryDocDev.Close;
      qryDocDev.SQL.Clear;
      qryDocDev.SQL.Add('SELECT DET_DTAENT FROM MOVDET ');
      qryDocDev.SQL.Add('WHERE DET_NUMDOC = :NUMDOC ');
      qryDocDev.SQL.Add('  AND DET_ESPDOC = :ESPDOC ');
      qryDocDev.SQL.Add('  AND DET_CODEMP = :CODEMP ');

      qryDocDev.SQL.Add('UNION ALL ' + AnsiReplaceStr(qryDocDev.SQL.Text, 'MOVGER', 'NOTGER'));

      qryDocDev.ParamByName('NUMDOC').AsString := qryDados.FieldByName('DET_DOCDEV').AsString;
      qryDocDev.ParamByName('ESPDOC').AsString := qryDados.FieldByName('DET_ESPDEV').AsString;
      qryDocDev.ParamByName('CODEMP').AsString := qryDados.FieldByName('DET_EMPDEV').AsString;            
      qryDocDev.Open;

      If not qryDocDev.IsEmpty Then
      Begin
        Result := (qryDocDev.FieldByName('DET_DTAENT').AsDateTime >= EncodeDate(2024, 6, 24));
      End;

    finally
      qryDocDev.free;
    end;
  end;

  function fCalculaFundoDeCombateGB(item: TDadosItem): Boolean;
  begin
    Result := False;

    if fTabelaExiste('MOVICD') then
      Exit;

    If not (fDadosGerais.dtaDtaEnt >= EncodeDate(2024, 6, 25)) Then
      Exit;

    if not (LeftStr(fDadosEmitente.strCnpj, 11) = '38843249000') then
      Exit;

    if not (fDadosEmitente.strEstado = 'RJ') then
      Exit;

    if not (RightStr(item.strCodSit, 2) = '00') then
      Exit;

    if (fConfiguracao('SIMPAU') = 'S') then
      Exit;

    If not fDocumentoCalculaFundoDeCombateGB Then
      Exit;      

    if (fDadosGerais.strCliCon = 'S') And
       (Length(fRetSomenteNumeros(fDadosEmitente.strIES)) > 1) Then
    begin
      Result := True;
      Exit;
    end;

    if (fDadosGerais.strCliCon = 'N') And
       (fDadosGerais.strEstado = fDadosEmitente.strEstado) Then
    begin
      Result := True;
      Exit;
    end;
  end;

  function fRecalculaValorUnitarioAumentandoCasasDecimais: Boolean;
  begin
    Result := True;

    If not (fCfgSisFonte(Self, 'RVAC10') = 'N') then
      Exit;

    Result := False;
  end;

  function fSortLetra: String;
    const
      arrAlfa : Array[0..25] Of String = ('A','B','C','D','E','F','G','H','I','J','K',
                                          'L','M','N','O','P','Q','R','S','T','U','V',
                                          'W','X','Y','Z');
  begin
    Result := RandomFrom(arrAlfa);
  end;

  function fEhProdutoRastreavel(item: TDadosItem): Boolean;
  var
    dtaFabLot: TDateTime;
  begin
    Result := False;

    If item.blnMedicamento Then
    Begin
      Result := True;
      Exit;
    End;

    If not (fCfgSisFonte(Self, 'TAGLOT') = 'S') then
      Exit;

    If fEmptyStr(item.strFabLot) Then
      Exit;

    dtaFabLot := StrToDateDef(item.strFabLot, 0);

    If not (dtaFabLot > 0) Then
      Exit;

    If not fDataValida(dtaFabLot) Then
      Exit;

    Result := True;
  End;

  function fEhDevolucaoDeFornecedorEspelho: Boolean;
  begin
    Result := False;

    If Not (dadosGerais.strOpcDoc = 'OF') Then
      Exit;

    If Not (Pos(qryDados.FieldByName('DET_CLAFIS').AsString, CFOP_DEVOLUCAO) > 0) Then
      Exit;

    If Not (fCfgSisFonte(Self, 'ESPDEV') = 'S') Then
      Exit;

    Result := True;
  end;

  function fRetornaClassificacaoDeVenda_Transferencia_Bonificacao_EntregaFutura: String;
  begin
    Result := fTransform(fConfiguracao('CLAVEN'), 4);
    Result := Result + '5151_6151_5152_6152_5408_6408_5409_6409_5910_6910_5116_6116_5117_6117_';
  end;

  function fUsaCodigoDeBeneficioFiscalDaAbreviacao: Boolean;
  begin
    Result := False;

    If not (fConfiguracao('OBRBEN') = 'S') Then
      Exit;

    Result := True;

    If not (fConfiguracao('CADBEF') = 'S') Then
      Exit;

    Result := False;

    If not (Pos(qryDados.FieldByName('DET_CLAFIS').AsString, fRetornaClassificacaoDeVenda_Transferencia_Bonificacao_EntregaFutura) > 0) Then
      Exit;

    Result := True;
  end;

  function fUsaCadastroDeBeneficioFiscal: Boolean;
  begin
    Result := False;

    If not (fConfiguracao('USABEF') = 'S') Then
      Exit;

    If not ((FTip_FC = 'C') or (FTip_FC = 'F')) Then
      Exit;

    Result := True;
  end;

  function fRetornaCodigoDeBeneficioFiscalDaCADBEF(strCodBef: String): Boolean;
  begin
    Result := False;

    If not fEmptyStr(strCodBef) Then
      Exit;

    If not fUsaCadastroDeBeneficioFiscal Then
      Exit;

    Result := True;
  end;

begin
  If (qryDados.FindField('GER_OPCDOC') <> Nil) And
      (qryDados.FieldByName('GER_OPCDOC').AsString = 'NG') Then
  begin
    blnEnvioFornecedor := True;
  end
  else
    blnEnvioFornecedor := False;

  Try
    Result := TDadosItem(lstItens.Items[intIndice]);
  Except
    Result := TDadosItem.Create;
    lstItens.Insert(intIndice, Result);

    Result.strAutInc := qryDados.FieldByName('DET_AUTOINCREM').AsString;
    Result.strCodIte := qryDados.FieldByName('DET_CODITE').AsString;
    Result.strCdGTin := fTiraPipeEnter(qryDados.FieldByName('ITE_CODBAR').AsString);

    if blnEnviofornecedor and objConfigInterna.blnFabNfe then
    begin
      Result.strCodFab := fObterCodFabMovGad(qryDados.FieldByName('DET_AUTOINCREM').AsString);
      if fEmptyStr(Result.strCodFab) then
        Result.strCodFab := qryDados.FieldByName('ITE_CODFAB').AsString;
    end
    else
      Result.strCodFab := qryDados.FieldByName('ITE_CODFAB').AsString;

    Result.strCod_Nf := qryDados.FieldByName('CLI_COD_NF').AsString;
    Result.strDes_Nf := qryDados.FieldByName('CLI_DES_NF').AsString;
    Result.strCodBar := EmptyStr;
    If (fConfiguracao('CLIPRO') = 'S') And (fConfiguracao('APRBAR') = 'S') Then
      Result.strCodBar := fTiraPipeEnter(fCampoTabela('CLI_CODBAR', 'CLIPRO', ['CLI_CODCLI','CLI_CODITE'], [dadosGerais.strCodCli, Result.strCodIte]));

    If fEmptyStr(Result.strCodBar) Then
      Result.strCodBar := fTiraPipeEnter(qryDados.FieldByName('ITE_CODBAR').AsString);

    Result.strForIte := qryDados.FieldByName('DET_FORITE').AsString;
    Result.strUni_NF := qryDados.FieldByName('CLI_SIGUNI').AsString;
    Result.strAplica := fSubstituirEnterPorEspaco(qryDados.FieldByName('ITE_APLICA').AsString);
    Result.strAplica := AnsiReplaceStr(Result.strAplica, '<<csq>>', ' ');
    Result.strCForDi := qryDados.FieldByName('DET_CFORDI').AsString;
    Result.strIteRef := qryDados.FieldByName('DET_ITEREF').AsString;
    Result.strChvRef := qryDados.FieldByName('DET_CHVREF').AsString;
    Result.fltVlrCon := qryDados.FieldByName('DET_VLRCON').AsFloat;

    If (fConfiguracao('UNITRI') = 'S') And fCampoExiste('ITEBAR', 'BAR_EANTRB') then
    Begin
      Result.strCdGTin := fCampoTabela('BAR_CODBAR', 'ITEBAR', ['BAR_CODITE','BAR_EANTRB'], [Result.strCodIte,'S']);
      If fEmptyStr(Result.strCdGTin) then
        Result.strCdGTin := Result.strCodBar ;
    End;

    //Caso configurado para imprimir o codigo do produto acabado para as tintas
    Result.strCodigoTinta := '';

    If (fConfiguracao('CODTIN') = '2') And Not fEmptyStr(qryDados.FieldByName('DET_CODACA').AsString) Then
      Result.strCodigoTinta := qryDados.FieldByName('DET_CODACA').AsString + '-' + qryDados.FieldByName('DET_EMPACA').AsString
    Else If (fConfiguracao('CODTIN') = '3') And Not fEmptyStr(qryDados.FieldByName('DET_CODACA').AsString) Then
      Result.strCodigoTinta := intToStr(qryDados.FieldByName('ACA_UNITIN').AsInteger);

    If (Pos(qryDados.FieldByName('DET_CLAFIS').AsString, '5933_6933_') > 0) And
       (Not fNotaServicoEletronicaConcreto)                                 Then
    Begin
      Result.strDesIte := fTiraPipeEnter(qryDados.FieldByName('GER_DESS' + untUtil.fStrZero(intIndColSer, 2)).AsString);
      Result.strUnidad := qryDados.FieldByName('ITE_SIGUNV').AsString;
      Result.fltQtdIte := 1.0;
      Result.fltUnitar := qryDados.FieldByName('GER_VALS' + untUtil.fStrZero(intIndColSer, 2)).AsFloat;
      Result.strUnTrib := qryDados.FieldByName('ITE_SIGUNV').AsString;
      Result.fltQtdTri := 1.0;
      Result.fltUniTri := qryDados.FieldByName('GER_VALS' + untUtil.fStrZero(intIndColSer, 2)).AsFloat;
      Result.fltTotIte := qryDados.FieldByName('GER_VALS' + untUtil.fStrZero(intIndColSer, 2)).AsFloat;
      Result.fltUniTrO := qryDados.FieldByName('GER_VALS' + untUtil.fStrZero(intIndColSer, 2)).AsFloat;

      If (intIndColSer = 1) Then
      Begin
        If (fCfgSisFonte(Self, 'AXCFNS') = 'S') Then
        Begin
          strNFEObserv := fCampoTabela('NFE_OBSERV', 'LOGNFE',['NFE_NUMDOC','NFE_ESPDOC','NFE_CODEMP','NFE_CODCLI','NFE_TIP_FC'],
                                                              [dadosGerais.strNumDoc,dadosGerais.strEspDoc,dadosGerais.strCodEmp,dadosGerais.strCodCli,dadosGerais.strTip_FC]);


          If (Pos(AnsiUpperCase('HASH do Arquivo TXT'), AnsiUpperCase(strNFEObserv)) > 0) Then
            Result.strDesIte := Result.strDesIte + '  ' + fSortLetra;
        End;
      End;
    End
    Else
    Begin
      Result.strDesIte := fTiraPipeEnter(qryDados.FieldByName('DET_DESCRI').AsString);

      fltFator := qryDados.FieldByName('ITE_FATUTR').AsFloat;

      If (fltFator = 0) Then
        fltFator := 1;

      If fEhVendaMetroLinearENaoImprimeMetragemTotal Then
      Begin
        Result.strUnidad := 'PC';
        Result.fltTotIte := qryDados.FieldByName('DET_TOTITE').AsFloat;
        Result.fltQtdIte := qryDados.FieldByName('DET_QTDPEC').AsFloat;
        Result.fltUnitar := Result.fltTotIte / Result.fltQtdIte;

        Result.strUnTrib := qryDados.FieldByName('ITE_SIGUNT').AsString;
        Result.fltQtdTri := qryDados.FieldByName('DET_QTDITE').AsFloat * fltFator;
        Result.fltUniTri := qryDados.FieldByName('DET_UNITAR').AsFloat / fltFator;
        Result.fltUniTrO := qryDados.FieldByName('DET_UNIORI').AsFloat / fltFator;
      End
      Else
      Begin
        //Unidade de venda
        Result.strUnidad := qryDados.FieldByName('ITE_SIGUNV').AsString;
        Result.fltQtdIte := qryDados.FieldByName('DET_QTDITE').AsFloat;
        Result.fltUnitar := qryDados.FieldByName('DET_UNITAR').AsFloat;
        //Unidade tributavel
        Result.strUnTrib := qryDados.FieldByName('ITE_SIGUNT').AsString;
        Result.fltQtdTri := qryDados.FieldByName('DET_QTDITE').AsFloat * fltFator;
        Result.fltUniTri := qryDados.FieldByName('DET_UNITAR').AsFloat / fltFator;
        Result.fltUniTrO := qryDados.FieldByName('DET_UNIORI').AsFloat / fltFator;
        //Total do item
        Result.fltTotIte := qryDados.FieldByName('DET_TOTITE').AsFloat;
      End;

      //Prestcon
      If fNotaServicoEletronicaConcreto And
         ((objConfigInterna.strTpNfCr = PRESTCON) Or (objConfigInterna.strTpNfCr = SECOL)) Then
      Begin
        Result.strDocRemessaConcreto := fGetDocumentoRemessaConcreto(qryDados.FieldByName('DET_SEQCCR').AsInteger);
      End;
    End;

    If fRecalculaValorUnitarioAumentandoCasasDecimais Then
    Begin
      With Result Do
      Begin
        If fFormataFloat(fltQtdIte * fltUnitar, 2) <> fFormataFloat(fltTotIte, 2) Then
        Begin
          fltUnitar := fFormataFloat(fltTotIte / fltQtdIte, 10);

          {****************************************************************************************}
          {* NÃO PODE REESCREVER O UNITÁRIO DE TRIBUTAÇÃO CASO TENHA FATOR DE CONVERSÃO ENVOLVIDO *}
          {*************************************************************************************RN*}
          if ((not fEhVendaMetroLinearENaoImprimeMetragemTotal) and
              (fFormataFloat(qryDados.FieldByName('ITE_FATUTR').AsFloat, 2) = 1)) Or
             (fEhVendaMetroLinearENaoImprimeMetragemTotal) then
          begin
            fltUniTri := fFormataFloat(fltTotIte / fltQtdIte, 10);
            fltUniTrO := fFormataFloat(fltTotIte / fltQtdIte, 10);
          end;
        End;
      End;

      If (Not fEhVendaMetroLinearENaoImprimeMetragemTotal) And ((fEmptyStr(fConfiguracao('IMPRNF'))) Or (fConfiguracao('IMPRNF') = '1')) Then
      Begin
        fltUnitTrib := fStrToFloat(FloatToStrF(Result.fltUniTri, ffNumber, 11, 10));
        fltQtdeTrib := fStrToFloat(FloatToStrF(Result.fltQtdTri, ffNumber, 15, 04));
        fltTotiTrib := fStrToFloat(FloatToStrF(Result.fltTotIte, ffNumber, 15, 02));

        If fFormataFloat(fltQtdeTrib * fltUnitTrib, 10) <> fFormataFloat(fltTotiTrib, 2) Then
          Result.fltUniTri := fFormataFloat(fltTotiTrib / fltQtdeTrib, 10);
      End;
    End;

    Result.strDesFab := fTiraPipeEnter(qryDados.FieldByName('ITE_DESFAB').AsString);
    Result.fltUniOri := qryDados.FieldByName('DET_UNIORI').AsFloat;

    If (fEmptyStr(qryDados.FieldByName('DET_NCMITE').AsString)) Then
      Result.strClaIpi := fRetornaNCM(qryDados.FieldByName('ITE_CLAIPI').AsString, qryDados.FieldByName('DET_CODITE').AsString, qryDados.FieldByName('GER_CODEMP').AsString)
    Else
      Result.strClaIpi := fRetornaNCM(qryDados.FieldByName('DET_NCMITE').AsString, qryDados.FieldByName('DET_CODITE').AsString, qryDados.FieldByName('GER_CODEMP').AsString);

    If fDadosGerais.blnInconsistenciaEFD_Gravar Or ((dadosGerais.strOpcDoc = 'CA') And (dadosGerais.strEstado = 'AM')) Then
      Result.strClaIpi := '00';

    If ((qryDados.FieldByName('GER_OPCDOC').AsString = 'NE') And
       (Pos('ITEM ESPECIAL', qryDados.FieldByName('ITE_DESITE').AsString) > 0)) Or
       ((qryDados.FieldByName('GER_OPCDOC').AsString = 'CF') And
        (qryDados.FieldByName('GER_ESPDOC').AsString = 'NF')) Then
    Begin
      If not fEmptyStr(qryDados.FieldByName('DET_NCMITE').AsString) Then
      Begin
        Result.strClaIpi := qryDados.FieldByName('DET_NCMITE').AsString;
      End;
    End;

    Result.blnMedicamento  := False;
    Result.strCodPrdAnvisa := '';
    Result.strMotIseAnvisa := '';

    If fCampoExiste('CADNCM', 'NCM_ANVOBR') Then
    Begin
      If (Length(arrNcmObrAnvisa) > 0) Then
        Result.blnMedicamento := fMatchText(Result.strClaIpi, arrNcmObrAnvisa)
      Else
        Result.blnMedicamento := (fCampoTabela('NCM_ANVOBR', 'CADNCM', ['NCM_CODNCM'], [Result.strClaIpi]) = 'S');

      If Result.blnMedicamento Then
      Begin
        If qryDados.FieldByName('ITE_ANVISE').AsString = 'S' Then
        Begin
          Result.strCodPrdAnvisa := 'ISENTO';
          Result.strMotIseAnvisa := qryDados.FieldByName('ITE_ANVRDC').AsString;
        End
        Else
          Result.strCodPrdAnvisa := qryDados.FieldByName('ITE_ANVREG').AsString;
      End;
    End;

    Result.strExcIpi := qryDados.FieldByName('ITE_EXCIPI').AsString;
    Result.strClaFis := qryDados.FieldByName('DET_CLAFIS').AsString;
    Result.fltDesEsp := qryDados.FieldByName('DET_DESESP').AsFloat;

    If fDadosGerais.blnNfComp And (Not fEmptyStr(fDadosGerais.strCodSit)) Then
      Result.strCodSit := fDadosGerais.strCodSit
    Else
      Result.strCodSit := qryDados.FieldByName('DET_CODFIS').AsString;

    Result.strCodMar := qryDados.FieldByName('DET_CODMAR').AsString;
    Result.strDesMar := fTiraPipeEnter(qryDados.FieldByName('MAR_DESMAR').AsString);

    Result.fltBasIcm := qryDados.FieldByName('DET_BASICM').AsFloat;

    if (Assigned(qryDados.FindField('DET_PERBAS'))) then
      Result.fltPerBas := qryDados.FieldByName('DET_PERBAS').AsFloat;

    Result.fltAlqIcm := qryDados.FieldByName('DET_ALQICM').AsFloat;
    Result.fltValIcm := qryDados.FieldByName('DET_VALICM').AsFloat;
    Result.fltBasRet := qryDados.FieldByName('DET_BASRET').AsFloat;
    Result.fltAlqRet := qryDados.FieldByName('DET_ALQRET').AsFloat;
    Result.fltValRet := qryDados.FieldByName('DET_VALRET').AsFloat;
    Result.fltPerRed := qryDados.FieldByName('DET_PERRED').AsFloat;
    Result.fltPRedST := qryDados.FieldByName('DET_PERRED').AsFloat;

    Result.fltAlqCreIcmSimples := Result.fltAlqIcm;
    Result.fltValCreIcmSimples := Result.fltValIcm;

    If Not qryDados.FieldByName('DET_PEBAST').IsNull Then
    Begin
      If fEhDevolucaoDeFornecedorEspelho Then
        Result.fltPRedST := qryDados.FieldByName('DET_PEBAST').AsFloat
      Else
        Result.fltPRedST := 100 - qryDados.FieldByName('DET_PEBAST').AsFloat;

      If (Result.fltPRedST < 0) Then
        Result.fltPRedST := 0;
    End;

    Result.fltValIva := qryDados.FieldByName('DET_VALIVA').AsFloat;
    Result.fltValIpi := qryDados.FieldByName('DET_VALIPI').AsFloat;
    Result.fltBasIpi := qryDados.FieldByName('DET_BASIPI').AsFloat;
    Result.fltAlqIpi := qryDados.FieldByName('DET_ALQIPI').AsFloat;
    Result.strCodAbf := qryDados.FieldByName('ITE_CODABF').AsString;

    If fTabelaExiste('ABFICM') Then
    Begin
      If FTip_FC = 'C' Then
      Begin
        strTipAbfSai := fGetTipAbfSaida(
                             IIF(Length(qryDados.FieldByName('GER_CGCCON').AsString) <= 11, 'F', 'J'),
                                        qryDados.FieldByName('GER_IESCON').AsString,
                                        qryDados.FieldByName('GER_PRORUR').AsString,
                                        qryDados.FieldByName('GER_MICEMP').AsString,
                                        qryDados.FieldByName('GER_CLICON').AsString,
                                        qryDados.FieldByName('GER_CODATI').AsString,
                                        qryDados.FieldByName('GER_REGTRI').AsString,
                                        qryDados.FieldByName('GER_INDUST').AsString,
                                        qryDados.FieldByName('GER_CLIFIL').AsString = 'S');

        If (strTipAbfSai = '_SAI_TRS') And (fCampoExiste('AUXMOV', 'AUX_EMP_TE')) Then
        Begin
          If (qryDados.FieldByName('GER_INDUST').AsString = 'S') And
             (Not fEmptyStr(fRetSQLMsg1e2TipAbfdeSAI('IND'))) Then
            strTipAbfSai := '_SAI_IND'

          Else If (fGetTipOpeTransferencia(IIF(qryDados.FieldByName('GER_CODCLI').AsString = fRetornaClienteFilial(objConfig.strCodEmp), dadosGerais.strEmp_TE, objConfig.strCodEmp),
                                           qryDados.FieldByName('GER_CODCLI').AsString) = 'V') Then
          Begin
            strTipAbfSai := fGetTipAbfSaida(
                                 IIF(Length(qryDados.FieldByName('GER_CGCCON').AsString) <= 11, 'F', 'J'),
                                            qryDados.FieldByName('GER_IESCON').AsString,
                                            qryDados.FieldByName('GER_PRORUR').AsString,
                                            qryDados.FieldByName('GER_MICEMP').AsString,
                                            qryDados.FieldByName('GER_CLICON').AsString,
                                            qryDados.FieldByName('GER_CODATI').AsString,
                                            qryDados.FieldByName('GER_REGTRI').AsString,
                                            qryDados.FieldByName('GER_INDUST').AsString,
                                            False);
           End;
        End;

        If (qryDados.FindField('ABF_MENS01' + strTipAbfSai) <> Nil) And
           (qryDados.FindField('ABF_MENS02' + strTipAbfSai) <> Nil) And
           (((qryDados.FindField('ABF_IMPMSG') <> Nil) and (qryDados.FieldByName('ABF_IMPMSG').AsInteger = 0))Or
           ((qryDados.FindField('ABF_AUTOIN') <> Nil) And (fTemMensagemParaCFOP(qryDados.FieldByName('ABF_AUTOIN').AsString,qryDados.FieldByName('DET_CLAFIS').AsString)))) Then
          Result.strMen__S := fTiraPipeEnter(qryDados.FieldByName('ABF_MENS01' + strTipAbfSai).AsString + ' ' +
                                        qryDados.FieldByName('ABF_MENS02' + strTipAbfSai).AsString);
      End
      Else
      If FTip_FC = 'F' Then
      begin
        strTipAbfSai := fGetTipoAbfFornecedor(qryDados.FieldByName('GER_CODCLI').AsString);
      end;
    End
    Else
    Begin
      If (qryDados.FieldByName('GER_CLICON').AsString = 'N') Or
         (Not ((fCampoExiste('CADABF', 'ABF_MENSA5') And fCampoExiste('CADABF', 'ABF_MENSA6')))) Then
      Begin
        Result.strMen__S := fTiraPipeEnter(qryDados.FieldByName('ABF_MENS01').AsString + ' ' +
                                      qryDados.FieldByName('ABF_MENS02').AsString)
      End
      Else
      Begin
        Result.strMen__S := fTiraPipeEnter(qryDados.FieldByName('ABF_MENS05').AsString + ' ' +
                                      qryDados.FieldByName('ABF_MENS06').AsString)
      End;
    End;
    
    Result.blnPromocao := qryDados.FieldByName('DET_PROMOC').AsString = 'S';
    
    Result.strDesNes := fTiraPipeEnter(qryDados.FieldByName('DET_DESNES').AsString);
    Result.strNumFCI := fTiraPipeEnter(qryDados.FieldByName('ITE_NUMFCI').AsString);

    Result.strNumLot := fRetornaNumLote(qryDados.FieldByName('DET_NUMLOT').AsString,
                                        qryDados.FieldByName('GER_NUMDOC').AsString,
                                        qryDados.FieldByName('GER_ESPDOC').AsString,
                                        qryDados.FieldByName('GER_CODEMP').AsString,
                                        qryDados.FieldByName('GER_CODCLI').AsString,
                                        qryDados.FieldByName('DET_CODITE').AsString,
                                        qryDados.FieldByName('DET_AUTOINCREM').AsString,
                                        strFabLot,
                                        strValLot,
                                        Result.strNumLotDtaVal);

    Result.strNumLot := fRetornaCodigoDeBarrasDoLote(Result.strNumLot,
                                                     qryDados.FieldByName('DET_NUMLOT').AsString,
                                                     qryDados.FieldByName('DET_CODITE').AsString,
                                                     qryDados.FieldByName('GER_CODEMP').AsString,
                                                     qryDados.FieldByName('GER_ESPDOC').AsString,
                                                     qryDados.FieldByName('DET_CLAFIS').AsString);

    Result.strNumLot := fRetornaLoteUtilizandoMaisDeUmaLocFis(qryDados.FieldByName('DET_AUTOINCREM').AsString, Result.strNumLot);

    Result.strNumLot := fTiraPipeEnter(Result.strNumLot);

    if fImprimeLoteNaDescricaoDoProduto(Result.strCodIte, qryDados.FieldByName('GER_ESPDOC').AsString) then
      Result.strDesIte := Result.strDesIte + '/' + Result.strNumLot;

    If (qryDados.FieldByName('DET_NUMLOT').AsString <> Result.strNumLot) Then
      Result.strFabLot := strFabLot
    Else
      Result.strFabLot := qryDados.FieldByName('LOT_DTAFAB').AsString;

    If (qryDados.FieldByName('DET_NUMLOT').AsString <> Result.strNumLot) Then
      Result.strValLot := strValLot
    Else
      Result.strValLot := qryDados.FieldByName('LOT_DTAVAL').AsString;

    Result.blnRastreavel := fEhProdutoRastreavel(Result);

    Result.strLocFis := fTiraPipeEnter(qryDados.FieldByName('DET_LOCFIS').AsString);

    Result.strMenFis := fTiraPipeEnter(qryDados.FieldByName('ITE_MENFIS').AsString);

    Result.blnIncPis := (qryDados.FieldByName('ITE_INCPIS').AsString='S');

    Result.fltBasPis := Result.fltTotIte - Result.fltDesEsp;
    Result.fltBasCof := Result.fltTotIte - Result.fltDesEsp;

    Result.fltAlqPis := objConfig.fltAlqPis;
    Result.fltAlqCof := objConfig.fltAlqCof;

    If (qryDados.FieldByName('FIS_TOTPIS').AsFloat <= 0) Then
    Begin
      Result.fltAlqPis := 0;
      Result.fltBasPis := 0;
    End;

    If (qryDados.FieldByName('FIS_TOTCOF').AsFloat <= 0) Then
    Begin
      Result.fltAlqCof := 0;
      Result.fltBasCof := 0;
    End;

    Result.fltValPis := Result.fltBasPis * Result.fltAlqPis / 100;
    Result.fltValCof := Result.fltBasCof * Result.fltAlqCof / 100;

    If (qryDados.FindField('DET_CSTPIS') <> Nil) And
       (Not fEmptyStr(qryDados.FieldByName('DET_CSTPIS').AsString)) Then
    Begin
      Result.fltBasPis := qryDados.FieldByName('DET_BASPIS').AsFloat;
      Result.fltBasCof := qryDados.FieldByName('DET_BASCOF').AsFloat;

      Result.fltAlqPis := qryDados.FieldByName('DET_ALQPIS').AsFloat;
      Result.fltAlqCof := qryDados.FieldByName('DET_ALQCOF').AsFloat;

      Result.fltValPis := qryDados.FieldByName('DET_VALPIS').AsFloat;
      Result.fltValCof := qryDados.FieldByName('DET_VALCOF').AsFloat;

      Result.strCstPis := qryDados.FieldByName('DET_CSTPIS').AsString;
      Result.strCstCof := qryDados.FieldByName('DET_CSTCOF').AsString;

    End;

    If (qryDados.FindField('DET_CSTIPI') <> Nil) Then
    Begin
      Result.strCSTIpi := qryDados.FieldByName('DET_CSTIPI').AsString;
    End;

    If (qryDados.FindField('DET_ENQIPI') <> Nil) Then
    Begin
      Result.strEnqIpi := qryDados.FieldByName('DET_ENQIPI').AsString;
    End;

    Result.fltBARTSP := qryDados.FieldByName('DET_BARTSP').AsFloat;
    Result.fltVLRTSP := qryDados.FieldByName('DET_VLRTSP').AsFloat;
    Result.fltICOPPR := qryDados.FieldByName('DET_ICOPPR').AsFloat;

    Result.strDiferi := qryDados.FieldByName('GER_DIFERI').AsString;

    Result.fltTotFre := qryDados.FieldByName('DET_TOTFRE').AsFloat;
    Result.fltDesAce := qryDados.FieldByName('DET_DESACE').AsFloat;

    If fNotaServicoEletronicaConcreto Then
    Begin
      Result.strCodSLC       := fConfiguracao('CLCSCR');
      Result.strTriMun       := fConfiguracao('TRMNCR');
      Result.strCodListaServ := fConfiguracao('CLCSCR');
      Result.strSerClaTri    := fConfiguracao('CRCTRI');
      Result.strSerIndOpe    := fConfiguracao('CRIOPE');
      Result.strCodNBS       := fConfiguracao('CRCNBS');
      Result.fltIBPT_F       := fStrToFloat(AnsiReplaceStr(fConfiguracao('CRIB_F'), '.', ','));
      Result.fltIBPT_E       := fStrToFloat(AnsiReplaceStr(fConfiguracao('CRIB_E'), '.', ','));
      Result.fltIBPT_M       := fStrToFloat(AnsiReplaceStr(fConfiguracao('CRIB_M'), '.', ','));
    End
    Else
    Begin
      Result.strCodSLC       := qryDados.FieldByName('SER_CDLSSE').AsString;
      Result.strTriMun       := qryDados.FieldByName('SER_TRIMUN').AsString;
      Result.strCodListaServ := qryDados.FieldByName('SER_CDLSSE').AsString;
      Result.strSerClaTri    := qryDados.FieldByName('SER_CLATRI').AsString;
      Result.strSerIndOpe    := qryDados.FieldByName('SER_INDOPE').AsString;
      Result.strCodNBS       := qryDados.FieldByName('SER_CODNBS').AsString;
      Result.fltIBPT_F       := qryDados.FieldByName('SER_IBPT_F').AsFloat;
      Result.fltIBPT_E       := qryDados.FieldByName('SER_IBPT_E').AsFloat;
      Result.fltIBPT_M       := qryDados.FieldByName('SER_IBPT_M').AsFloat;
    End;

    Result.strNfsNat := qryDados.FieldByName('SER_NATOPE').AsString;

    If fNotaServicoEletronica And (Not fNotaServicoEletronicaConcreto) And fCampoExiste('CADSER', 'SER_TRIBUT') And (intIndColSer > 0) Then
    Begin
      Result.strServicoTributavel := fCampoTabela('SER_TRIBUT', 'CADSER', ['SER_CODSER'], [qryDados.FieldByName('GER_CODS' + untUtil.fStrZero(intIndColSer, 2)).AsString]);
    End;

    If (Not fEmptyStr(qryDados.FieldByName('SER_CNAECP').AsString)) And (fConfiguracao('HCCNFS') = 'S') Then
    Begin
      Result.strCnaeFiscal := qryDados.FieldByName('SER_CNAEFI').AsString +
                              qryDados.FieldByName('SER_CNAECP').AsString;
    End
    Else
    Begin
      Result.strCnaeFiscal := qryDados.FieldByName('SER_CNAEFI').AsString;
    End;

    {******INFORMAÇÕES REF. PEDIDO DE COMPRA******}
    Result.strCoiCmp := qryDados.FieldByName('DET_COICMP').AsString;     //CÓDIGO DO ITEM NO CLIENTE QUE SOLICITOU A PEDIDO
                                                                         //CAMPO CRIADO REQ.: 38461 MAS O REQUISITO FOI "PERDIDO" NA VIRADA 48.02.DESEN > 48.02.30
                                                                         //MANTIDO AQUI SOMENTE POR QUESTÃO DE COMPATIBILIDADE
    If (qryDados.FieldByName('DET_NITCMP').AsInteger > 0) Then
    begin
      if (fConfiguracao('ITPDXM') = '2') then
      begin
        Result.strNItemPed := untUtil.fStrZero(qryDados.FieldByName('DET_NITCMP').AsString, 6); //QUANTIDADE SOLICITADA NO PEDIDO DE COMPRA
      end
      else
      begin
        Result.strNItemPed := qryDados.FieldByName('DET_NITCMP').AsString; //QUANTIDADE SOLICITADA NO PEDIDO DE COMPRA
      end;
    end;

    //NÚMERO PEDIDO DE COMPRA COM PRIORIDADE DEFINIDA CONFORME REQ.: 76040
    If (Not fEmptyStr(qryDados.FieldByName('DET_NUMCMP').AsString)) Then
    Begin
      Result.strPedCom := qryDados.FieldByName('DET_NUMCMP').AsString
    End
    Else
    Begin
      Result.strPedCom := fRetornaNumsPedidoCompra(qryDados.FieldByName('DET_NUM_PD').AsString,
                                                   qryDados.FieldByName('DET_ESP_PD').AsString,
                                                   qryDados.FieldByName('GER_CODCLI').AsString,
                                                   qryDados.FieldByName('DET_EMP_PD').AsString);
    End;

    Result.strPedCom := AnsiReplaceStr(Result.strPedCom, #13#10, '');
    Result.strPedCom := LeftStr(StringReplace(Result.strPedCom, '|', '/', [rfReplaceAll]), 15);
    {******INFORMAÇÕES REF. PEDIDO DE COMPRA******}

    Result.strImpDir := qryDados.FieldByName('ITE_IMPDIR').AsString; // Importacao Direta

    Result.strRICMPR := qryDados.FieldByName('DET_RICMPR').AsString;

    Result.strInfGar := IIF(qryDados.FieldByName('DET_TMPGAR').AsInteger <> 0,
                           'Garantia de ' + qryDados.FieldByName('DET_TMPGAR').AsString + ' meses. ', '') +
                       qryDados.FieldByName('ITE_INFGAR').AsString;

    pCarregarDocumentoImportacao(Result, qryDados.FieldByName('DET_AUTINC').AsString);

    If (qryDados.FindField('DET_QTDPEC') <> Nil) And
       (qryDados.FieldByName('DET_QTDPEC').AsFloat > 0) And
       ((qryDados.FieldByName('DET_COMPEC').AsFloat +
         qryDados.FieldByName('DET_LARPEC').AsFloat +
         qryDados.FieldByName('DET_ESPPEC').AsFloat + 0) > 0) Then
    Begin
      Result.dadosMadeira := TDadosMadeira.Create;
      Result.dadosMadeira.fltQtdPec := qryDados.FieldByName('DET_QTDPEC').AsFloat;
      Result.dadosMadeira.fltComPec := qryDados.FieldByName('DET_COMPEC').AsFloat;
      Result.dadosMadeira.fltLarPec := qryDados.FieldByName('DET_LARPEC').AsFloat;
      Result.dadosMadeira.fltEspPec := qryDados.FieldByName('DET_ESPPEC').AsFloat;
      Result.dadosMadeira.fltPerApa := qryDados.FieldByName('DET_PERAPA').AsFloat;
      Result.dadosMadeira.fltPerBen := qryDados.FieldByName('DET_PERBEN').AsFloat;
      Result.dadosMadeira.strAparel := qryDados.FieldByName('DET_APAREL').AsString;
      Result.dadosMadeira.strBenefi := qryDados.FieldByName('DET_BENEFI').AsString;

      if (qryDados.FindField('DET_VLUNPC') <> Nil) then
      begin
        Result.dadosMadeira.fltVlUnPc := qryDados.FieldByName('DET_VLUNPC').AsFloat;
      end
      else
      begin
        Result.dadosMadeira.fltVlUnPc := 0;
      end;

    End;

    Result.strCodLub := qryDados.FieldByName('ITE_CODLUB').AsString;
    Result.strDesANP := qryDados.FieldByName('ITE_DESANP').AsString;
    Result.strCodOnu := qryDados.FieldByName('ONU_CODONU').AsString;
    Result.strDesOnu := qryDados.FieldByName('ONU_DESCRI').AsString;
    Result.strCodigo := qryDados.FieldByName('ONU_CODIGO').AsString;
    Result.strClaRis := qryDados.FieldByName('ONU_CLARIS').AsString;
    Result.strGruEmb := qryDados.FieldByName('ONU_GRUEMB').AsString;

    Result.fltTotPes := qryDados.FieldByName('DET_TOTPES').AsFloat;

    Result.fltImpPag := 0;
    Result.fltFedImp := 0;
    Result.fltEstImp := 0;
    Result.fltMunImp := 0;

    If (qryDados.FindField('DET_FEDIMP') <> Nil) And
       (qryDados.FindField('DET_ESTIMP') <> Nil) And
       (qryDados.FindField('DET_MUNIMP') <> Nil) And
       (fConfiguracao('IMPPAG') = '2')           Then
    Begin
      ValorAliquotaIBPT := fBuscaAlqIBPT(fTiraCaracEspeciais(Result.strClaIpi),
                                         Result.strExcIpi,
                                         FCodEmp,
                                         fDadosEmitente.strEstado);

      If qryDados.FieldByName('DET_FEDIMP').AsFloat > 0 Then
        Result.fltFedImp := qryDados.FieldByName('DET_FEDIMP').AsFloat
      Else
        Result.fltFedImp := IIF((LeftStr(Result.strCodSit,1) <> '0'),
                                fFormataFloat((Result.fltTotIte - Result.fltDesEsp) * ValorAliquotaIBPT.fltImportado / 100, 2),
                                fFormataFloat((Result.fltTotIte - Result.fltDesEsp) * ValorAliquotaIBPT.fltNacional  / 100, 2));

      If qryDados.FieldByName('DET_ESTIMP').AsFloat > 0 Then
        Result.fltEstImp := qryDados.FieldByName('DET_ESTIMP').AsFloat
      Else
        Result.fltEstImp := fFormataFloat((Result.fltTotIte - Result.fltDesEsp) * ValorAliquotaIBPT.fltEstadual / 100, 2);

      If qryDados.FieldByName('DET_MUNIMP').AsFloat > 0 Then
        Result.fltMunImp := qryDados.FieldByName('DET_MUNIMP').AsFloat
      Else
        Result.fltMunImp := fFormataFloat((Result.fltTotIte - Result.fltDesEsp) * ValorAliquotaIBPT.fltMunicipal / 100, 2);

    End
    Else
    Begin
      If (qryDados.FindField('DET_IMPPAG') <> Nil) Then
      Begin
        If qryDados.FieldByName('DET_IMPPAG').AsFloat > 0 Then
          Result.fltImpPag := qryDados.FieldByName('DET_IMPPAG').AsFloat
        Else
          Result.fltImpPag := fRetImpPagItem(Result);
      End
      Else
      Begin
        Result.fltImpPag := fRetImpPagItem(Result);
      End;
    End;

    If (qryDados.FindField('DET_ICMORG') <> Nil) Then
      Result.fltIcmOrg := qryDados.FindField('DET_ICMORG').AsFloat;

    If (qryDados.FindField('DET_VRDICM') <> Nil) Then
      Result.fltVrdIcm := qryDados.FindField('DET_VRDICM').AsFloat;

    If (qryDados.FindField('DET_MTDICM') <> Nil) Then
      Result.strMtdIcm := qryDados.FindField('DET_MTDICM').AsString;

    If (qryDados.FindField('ITE_PROPCD') <> Nil) Then
      Result.strProPCD := qryDados.FindField('ITE_PROPCD').AsString;

    If (qryDados.FindField('DET_VALDIF') <> Nil) Then
      Result.fltValDif := qryDados.FindField('DET_VALDIF').AsFloat;

    Result.fltPerDevolvido := 0;
    If (Pos(Result.strClaFis, CFOP_DEVOLUCAO) > 0)              And
       (Not fEmptyStr(qryDados.FieldByName('DET_DOCDEV').AsString)) And
       {(qryDados.FieldByName('DET_CLAFIS').AsString < '5000') And}
       (FTip_FC = 'F') And
       (fDeveEnviarIPIDevolvido) Then
    Begin
      Result.fltPerDevolvido := fRetornaPercetualDevolvido(qryDados);
    End;

    Result.strRIcmPRAbf := qryDados.FieldByName('ABF_RICMPR_SAI_CNC').AsString;

    If (qryDados.FieldByName('ITE_CDCEST').AsString = '0000000') Then
      Result.strCodigoCEST := ''
    Else
      Result.strCodigoCEST := qryDados.FieldByName('ITE_CDCEST').AsString;

    Result.strEniEcb := qryDados.FieldByName('ITE_ENIECB').AsString;
    Result.strIndEsc := qryDados.FieldByName('ITE_INDESC').AsString;
    Result.strCnpFab := qryDados.FieldByName('ITE_CNPFME').AsString;
    Result.strCdbFis := qryDados.FieldByName('ITE_CDBFIS').AsString;
    Result.strCodFor := qryDados.FieldByName('ITE_CODFOR').AsString;

    If fUsaCodigoDeBeneficioFiscalDaAbreviacao then
    begin
      Result.strCdbFis := fCodigoBeneficioFiscal(Self, Result.strCodSit, Result.strCodAbf, strTipAbfSai, Result.strClaFis);

      If fRetornaCodigoDeBeneficioFiscalDaCADBEF(Result.strCdbFis) Then
        Result.strCdbFis := fBuscaBeneficioFiscal(strTipAbfSai, FCodEmp, Result.strClaFis, Result.strCodSit);

      If fEmptyStr(Result.strCdbFis) Then
        Result.strCdbFis := fBuscaBeneficioFiscalDaTabelaDefault(Self, Result.strCodSit, fDadosEmitente.strEstado);
    end
    else
    begin
      If fUsaCadastroDeBeneficioFiscal Then
      Begin
        Result.strCdbFis := fBuscaBeneficioFiscal(strTipAbfSai, FCodEmp, Result.strClaFis, Result.strCodSit);
      End
      Else
      Begin
        Result.strCdbFis := '';
      End;
    end;

    If (dadosGerais.strBenCst = 'S') Then
    Begin
      Result.strCdbFis := fBuscaBeneficioFiscalDoCliente(dadosGerais.strCodCli, Result.strCodSit, Result.strCdbFis);
    End;

    Result.strCdbFis := fTiraPipeEnter(Result.strCdbFis);

    If Assigned(qryDados.FindField('ICD_BCUFDE')) Then
    Begin
      Result.fltBaseUfDestino := qryDados.FieldByName('ICD_BCUFDE').AsFloat;
      Result.fltPercentualFCP := qryDados.FieldByName('ICD_PERFCP').AsFloat;
      Result.fltAliquotaDestino := qryDados.FieldByName('ICD_ALQUFD').AsFloat;
      Result.fltAliquotaInterestadual := qryDados.FieldByName('ICD_ALQINE').AsFloat;
      Result.fltPercentualPartilha := qryDados.FieldByName('ICD_PERPAR').AsFloat;
      Result.fltValorFCP := qryDados.FieldByName('ICD_VALFCP').AsFloat;
      Result.fltValorIcmsDestino := qryDados.FieldByName('ICD_VALDES').AsFloat;
      Result.fltValorIcmsOrigem := qryDados.FieldByName('ICD_VALORI').AsFloat;
      Result.fltBaseFCP := qryDados.FieldByName('ICD_BASFCP').AsFloat;
      Result.strFcpProprio := qryDados.FieldByName('ICD_FCPPRO').AsString;
    End;

    If fCalculaFundoDeCombateGB(Result) Then
    Begin
      Result.fltPercentualFCP := 2;
      Result.fltBaseFCP       := Result.fltBasIcm;
      Result.fltValorFCP      := fFormataFloat((Result.fltBaseFCP * Result.fltPercentualFCP) / 100, 2);
    End;

    Result.fltBaseFCPST       := qryDados.FieldByName('DET_BFCPST').AsFloat;
    Result.fltPercentualFCPST := qryDados.FieldByName('DET_PFCPST').AsFloat;
    Result.fltValorFCPST      := qryDados.FieldByName('DET_VFCPST').AsFloat;

    Result.fltPICMEF := qryDados.FieldByName('DET_PICMEF').AsFloat;
    Result.fltBICMEF := qryDados.FieldByName('DET_BICMEF').AsFloat;
    Result.fltAICMEF := qryDados.FieldByName('DET_AICMEF').AsFloat;
    Result.fltVICMEF := qryDados.FieldByName('DET_VICMEF').AsFloat;
    Result.fltSICMEF := qryDados.FieldByName('DET_SICMEF').AsFloat;
    Result.fltBSTANT := qryDados.FieldByName('DET_BSTANT').AsFloat;
    Result.fltVSTANT := qryDados.FieldByName('DET_VSTANT').AsFloat;
    Result.fltVDesST := qryDados.FieldByName('DET_VDESST').AsFloat;
    Result.strMDesST := qryDados.FieldByName('DET_MDESST').AsString;
    Result.fltBimRet := qryDados.FieldByName('DET_BIMRET').AsFloat;
    Result.fltAimRet := qryDados.FieldByName('DET_AIMRET').AsFloat;
    Result.fltVimRet := qryDados.FieldByName('DET_VIMRET').AsFloat;

    If (RightStr(Result.strCodSit, 2) = '30') And
       (Result.fltIcmOrg = 0) And (Result.fltVrdIcm = 0) And
       (Not fSimplesPaulista(fDadosGerais, dadosEmitente, False)) Then
    Begin
      If (dadosGerais.fltBasIcm > 0) And (Result.fltBasIcm > 0) Then
      Begin
        dadosGerais.fltBasIcm := dadosGerais.fltBasIcm - Result.fltBasIcm ;
        Result.fltBasIcm := 0;
      End;

      If (dadosGerais.fltTotIcm > 0) And (Result.fltValIcm > 0) Then
      Begin
        dadosGerais.fltTotIcm := dadosGerais.fltTotIcm - Result.fltValIcm;
        Result.fltValIcm := 0;
      End;

    End;

    Result.strIndRev := qryDados.FieldByName('ITE_INDREV').AsString;

    Result.fltAlqFin := fAliquotaSuportadoPeloConsumidorFinal(qryDados);

    Result.strChaveAcesso := qryDados.FieldByName('DET_CHACES').AsString;
    Result.fltQtItCo := qryDados.FieldByName('DET_QTDCOM').AsFloat;
    Result.strRefere := qryDados.FieldByName('DET_REFERE').AsString;

    If qryDados.FieldByName('DET_ATODDF').AsString = 'S' Then
      dadosGerais.blnAtoDeclaratorioDF := True;

    If (qryDados.FindField('DET_NUMDRW') <> Nil) Then
      Result.strNumDrw := qryDados.FindField('DET_NUMDRW').AsString;

    Result.strComple := fTiraPipeEnter(qryDados.FieldByName('DET_COMPLE').AsString);
    Result.fltPerDif := qryDados.FieldByName('DET_PERDIF').AsFloat;

    If (Pos(Result.strClaFis, objConfig.strClaVen) > 0) Then
      Result.strNum_DI := fRetornaDeclaracaoDeImportacaoDaUltimaNotaDeCompra(qryDados.FieldByName('DET_CODITE').AsString);

    If (fConfiguracao('CREPRE') = 'S') And (Not fSimplesPaulista(fDadosGerais, dadosEmitente, False)) then
    Begin
      Result.fltEnvPre := 'S';

      If not fEmptyStr(qryDados.FieldByName('DET_CBENEF').AsString) Then
        Result.strCdbFis := qryDados.FieldByName('DET_CBENEF').AsString;

      Result.strCodPre := qryDados.FieldByName('DET_CODPRE').AsString;
      Result.fltPerPre := qryDados.FieldByName('DET_PERPRE').AsFloat;
      Result.fltValPre := qryDados.FieldByName('DET_VALPRE').AsFloat;
    End;

    pReformaTributariaItens(Result);

  End;
end;

function TFonteDadosBD.fAliquotaSuportadoPeloConsumidorFinal(qryDados: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Double;
begin
  Result := 0;

  if (not Assigned(qryDados)) or (not qryDados.Active) then
    exit;

  if not Assigned(qryDados.FindField('ABF_ALQRET_ENT_PEJ')) then
    exit;

  Result := qryDados.FieldByName('ABF_ALQRET_ENT_PEJ').AsFloat;
end;

(*
  2.1 Quando o algarismo imediatamente seguinte ao último algarismo a ser conservado
  for inferior a 5, o último permanecerá sem modificação
  Exemplo: 1,333 3 arredondado à primeira decimal tornar-se-á:1,3

  2.2 Quando o algarismo imediatamente seguinte ao último algarismo a ser conservado
  for superior a 5, ou sendo 5, seguido de no mínimo um algarismo diferente de zero,
  o último algarismo a ser conservado deverá ser aumentado de uma unidade.
  Exemplo: 1,666 6 arredondado à primeira decimal tornar-se-á:1,7
  4,851 5 arredondado à primeira decimal torna-se-ão:4,9

  2.3 Quando o algarismo imediatamente seguinte ao último algarismo a ser conservado
  for 5 seguido de zeros, dever-se-á arredondar o algarismo a ser conservado para o
  algarismo par mais próximo. Conseqüentemente, o último algarismo a ser retido,
  se for ímpar, aumentará uma unidade.
  Exemplo: 4,550 0 arredondado à primeira decimal tornar-se-á:4,6

  2.4 Quando o algarismo imediatamente seguinte ao último a ser conservado for 5
  seguido de zeros, se for par o algarismo a ser conservado ele permanecerá sem
  modificação.
  Exemplo: 4,850 0 arredondado à primeira decimal tornar-se-á:4,8
*)
function TFonteDadosBD.fArredondaABNT_NBR5891_77(fltValor: Double;
  intDecimais: Integer): Double;
  Var
    fltUltimosNumeros: Double;
    intPow: Int64;
    fltValorPow: Double;
    fltParteInteira: Double;
    intUltimoNumeroInteira: Integer;
    fltResto: Double;
begin
  intPow := Trunc(Power(10.0, intDecimais));
  fltValorPow := fRemoveDizimas(fltValor * intPow, 9);
  fltParteInteira := fParteInteira(fltValorPow);
  fltUltimosNumeros := Trunc(Frac(fltValorPow) * 100);

  If (fltUltimosNumeros > 50) Then
  Begin
    fltParteInteira := fltParteInteira + 1;
  End
  Else if (fltUltimosNumeros = 50) Then
  Begin
    intUltimoNumeroInteira := Round(Frac(fltParteInteira/10)*10);
    If Odd(intUltimoNumeroInteira) Then
      fltParteInteira := fltParteInteira + 1
    Else
    Begin
      fltResto := Frac(fltValorPow * 10);
      If CompareValue(fltResto, 0, 0.00001) = GreaterThanValue Then
        fltParteInteira := fltParteInteira + 1;
    End;
  End;

  Result := fltParteInteira / intPow;
end;

function TFonteDadosBD.fBuscaAlqIBPT(strNcm: String; strEx: String; strCodEmp: String; strEstado: String=''): TValorAliquotaIBPT;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strSQL,
    strEstEmp: String;
    ValorAliquotaIBPT: TValorAliquotaIBPT;

    function fRetEstadoCadEmp: String;
    Begin
      {$IF Defined(UNIDAC) Or Defined(LINUX)}
      If dicEmpEst.ContainsKey(strCodEmp) Then
      Begin
        Result := dicEmpEst[strCodEmp];
        Exit;
      End;
      {$IFEND}

      Result := fCampoTabela('CID_ESTADO','CADEMP E JOIN CADCID ON CID_CODCID = E.EMP_CODCID', ['E.EMP_CODEMP'], [strCodEmp]);

      {$IF Defined(UNIDAC) Or Defined(LINUX)}
      dicEmpEst.AddOrSetValue(strCodEmp, Result);
      {$IFEND}
    End;

begin
  FillChar(ValorAliquotaIBPT, SizeOf(TValorAliquotaIBPT), 0);
  Try
    Result := ValorAliquotaIBPT;

    If (Not fEmptyStr(strEstado)) And (objConfig.strCodEmp = FCodEmp) Then
      strEstEmp := strEstado
    Else
      strEstEmp := fRetEstadoCadEmp;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  IBP_ALQNAC, ';
    strSQL := strSQL + '  IBP_ALQIMP, ';
    strSQL := strSQL + '  IBP_ALQEST, ';
    strSQL := strSQL + '  IBP_ALQMUN  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADIBP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  IBP_N_C_M_ = :NCM AND';
    strSQL := strSQL + '  IBP_E_X___ = :E_X AND ';
    strSQL := strSQL + '  IBP_ESTADO = :EST ';

    qryAux := fCriaQuery(Nil);
    qryAux.Close;
    qryAux.SQL.Text := strSQL;
    qryAux.ParamByName('NCM').AsString := strNcm;
    qryAux.ParamByName('E_X').AsString := strEx;
    qryAux.ParamByName('EST').AsString := strEstEmp;
    qryAux.Open;

    If qryAux.IsEmpty Then
    Begin
      qryAux.Close;
      qryAux.ParamByName('NCM').AsString := LeftStr(strNcm,4);
      qryAux.ParamByName('E_X').AsString := strEx;
      qryAux.ParamByName('EST').AsString := strEstEmp;
      qryAux.Open;
    End;

    If qryAux.IsEmpty Then
    Begin
      qryAux.Close;
      qryAux.ParamByName('NCM').AsString := LeftStr(strNcm,2);
      qryAux.ParamByName('E_X').AsString := strEx;
      qryAux.ParamByName('EST').AsString := strEstEmp;
      qryAux.Open;
    End;

    If Not qryAux.IsEmpty Then
    Begin
      ValorAliquotaIBPT.fltNacional  := qryAux.FieldByName('IBP_ALQNAC').AsFloat;
      ValorAliquotaIBPT.fltImportado := qryAux.FieldByName('IBP_ALQIMP').AsFloat;
      ValorAliquotaIBPT.fltEstadual  := qryAux.FieldByName('IBP_ALQEST').AsFloat;
      ValorAliquotaIBPT.fltMunicipal := qryAux.FieldByName('IBP_ALQMUN').AsFloat;

      Result := ValorAliquotaIBPT;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fBuscaBeneficioFiscal(strPerAbrSai, strCodEmp, strCFOP, strCST: string): string;
var
  qryBeneficioFiscal: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strSQL: string;
begin
  Result := '';

  if fTabelaExiste('CADBEF') then
  begin
    qryBeneficioFiscal := fCriaQuery(nil);
    try
      strSQL := '';
      strSQL := strSQL + 'SELECT BEF_CODIGO ';
      strSQL := strSQL + '  FROM CADBEF ';
      strSQL := strSQL + ' WHERE BEF_CFOPBF = :CFOPBF ';
      strSQL := strSQL + '   AND BEF_CSTBEF = :CSTBEF ';
      strSQL := strSQL + '   AND BEF_PERABR = :PERABR ';

      If (fConfiguracao('CADBEF') = 'S') Then
        strSQL := strSQL + '   AND BEF_CODEMP = :CODEMP ';

      qryBeneficioFiscal.Close;
      qryBeneficioFiscal.SQL.Clear;
      qryBeneficioFiscal.SQL.Add(strSQL);
      qryBeneficioFiscal.ParamByName('CFOPBF').AsString := strCFOP;
      qryBeneficioFiscal.ParamByName('CSTBEF').AsString := strCST;
      qryBeneficioFiscal.ParamByName('PERABR').AsString := strPerAbrSai;

      If (fConfiguracao('CADBEF') = 'S') Then
        qryBeneficioFiscal.ParamByName('CODEMP').AsString := strCodEmp;

      qryBeneficioFiscal.Open;

      if not qryBeneficioFiscal.IsEmpty then
      begin
        Result := qryBeneficioFiscal.FieldByName('BEF_CODIGO').AsString;
      end;
    finally
      FreeAndNil(qryBeneficioFiscal);
    end;
  end;
end;

function TFonteDadosBD.fRemoveDizimas(fltValor: Double;
  intDecimais: Integer): Double;
  Var
    intPow: Double;
begin
  intPow := Power(10, -intDecimais);
  Result := Trunc((fltValor / intPow) + 0.5) * intPow;
end;

function TFonteDadosBD.fRetDesCla(strCodCfo: String): String;
begin
  If fCampoExiste('NATCFO', 'NAT_DESCRI') Then
    fCampoTabela('NAT_DESCRI', 'NATCFO', ['NAT_CODCFO'], [strCodCfo])
  Else
    fCampoTabela('CFO_NATOPE', 'CADCFO', ['CFO_CODCFO'], [strCodCfo]);
end;

procedure TFonteDadosBD.pRetAlqPisCofins(var fltAlqPis, fltAlqCof: Double);
  Var
    strVal: String;
begin
  fltAlqPis := 0;
  fltAlqCof := 0;

  strVal := (fConfiguracao('ALPISP'));
  If (Not fEmptyStr(strVal)) Then
    fltAlqPis := StrToFloatDef(strVal, 0);

  strVal := (fConfiguracao('ALCOFP'));
  If (Not fEmptyStr(strVal)) Then
    fltAlqCof := StrToFloatDef(strVal, 0);
end;

procedure TFonteDadosBD.pRetClassificacoesDevolucao;
begin
  objConfig.strClaDev := fTransform(fConfiguracao('CLADEV'), 4);
end;

procedure TFonteDadosBD.pRetDadosNotaOrigem(var dtaDtaDoc: TDateTime);
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  If (dadosGerais.blnNfComp) And (Not fEmptyStr(dadosGerais.strDocOriNC)) Then
  Begin
    qryAux := fCriaQuery(Nil);
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  FIS_DTADOC ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  CADFIS ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ AND ');
    qryAux.SQL.Add('  FIS_ACESSO = :ACESSO ');

    qryAux.ParamByName('NUMDOC').AsString := dadosGerais.strDocOriNC;
    qryAux.ParamByName('CODEMP').AsString := dadosGerais.strCodEmp;
    qryAux.ParamByName('SERIE_').AsString := dadosGerais.strSerOriNC;
    qryAux.ParamByName('ACESSO').AsString := dadosGerais.strAceOriNC;

    qryAux.Open;

    If (qryAux.IsEmpty) Then
    Begin
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT ');
      qryAux.SQL.Add('  FIS_DTADOC ');
      qryAux.SQL.Add('FROM ');
      qryAux.SQL.Add('  CADFIS ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
      qryAux.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ AND ');
      qryAux.SQL.Add('	(FIS_ESPDOC = "NF" OR FIS_ESPDOC = "EL") ');

      qryAux.ParamByName('NUMDOC').AsString := dadosGerais.strDocOriNC;
      qryAux.ParamByName('CODEMP').AsString := dadosGerais.strCodEmp;
      qryAux.ParamByName('SERIE_').AsString := dadosGerais.strSerOriNC;

      qryAux.Open;

      If (qryAux.IsEmpty) Then
        Raise Exception.Create('Nota de origem (' + dadosGerais.strDocOriNC + ') não encontrada.');
    End;

    dtaDtaDoc := qryAux.FieldByName('FIS_DTADOC').AsDateTime;

    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fTemAdiantamentoNotaEspecialFator(strNumDup, strEspDoc,
  strCodEmp, strCodCli: String; var intQtdParcel: Integer): Boolean;
var
  qryParcel: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryParcel := fCriaQuery(Nil);

  try
    intQtdParcel := 0;
    Result := False;

    if not fCampoExiste('CADREC', 'CTR_ADTCLI') then
      Exit;

    qryParcel.Close;
    qryParcel.SQL.Clear;
    qryParcel.SQL.Add('SELECT AUTOINCREM');
    qryParcel.SQL.Add('FROM CADREC');
    qryParcel.SQL.Add('WHERE CTR_NUMDUP = :NUMDUP');
    qryParcel.SQL.Add('AND CTR_ESPDOC = :ESPDOC');
    qryParcel.SQL.Add('AND CTR_CODEMP = :CODEMP');
    qryParcel.SQL.Add('AND CTR_CODCLI = :CODCLI');

    qryParcel.ParamByName('NUMDUP').AsString := strNumDup;
    qryParcel.ParamByName('ESPDOC').AsString := strEspDoc;
    qryParcel.ParamByName('CODEMP').AsString := strCodEmp;
    qryParcel.ParamByName('CODCLI').AsString := strCodCli;

    qryParcel.Open;

    if qryParcel.IsEmpty then
      Exit;

    intQtdParcel := qryParcel.RecordCount;

    qryParcel.Close;
    qryParcel.SQL.Add('AND CTR_ADTCLI = "S"');
    qryParcel.Open;

    Result := qryParcel.RecordCount > 0;
  finally
    FreeAndNil(qryParcel);
  end;
end;

function TFonteDadosBD.fTemDados: Boolean;
begin
  Result := (intPosAtual < lstItens.Count);

  {************************************}
  {* AS NOTAS DE COMPLEMENTO NÃO TEM  *}
  {* ITEM.                            *}
  {*********************************MV*}
  If Result Then
    Result := (Not qryDados.FieldByName('GER_NUMDOC').IsNull);
end;

function TFonteDadosBD.fTemLancamentoDeMovCar(
  const AqryFormaPgto: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Boolean;
begin
  result := False ;
  AqryFormaPgto.First ;
  try
    while not AqryFormaPgto.Eof do
    begin
      if not fEmptyStr(AqryFormaPgto.FieldByName('AUTOINCREM').AsString) then
      begin
        Result := True ;
        Break ;
      end ;
      AqryFormaPgto.Next ;
    end ;
  finally
    AqryFormaPgto.First ;
  end ;
end;

function TFonteDadosBD.fDuplicouItens(qryDados: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): boolean;
  var
    stlItens : TStringList;
begin
  Result := False;

  if FileExists(ExtractFilePath(Application.ExeName) + 'nfe.duplic') then
    exit;

  if (not Assigned(qryDados)) then
    exit;

  if (not qryDados.Active) then
    exit;

  if (qryDados.IsEmpty) then
    exit;

  if (not Assigned(qryDados.FindField('DET_AUTOINCREM'))) then
    exit;

  if (not Assigned(qryDados.FindField('CHAVE_TABELA'))) then
    exit;

  if not ((qryDados.FieldByName('CHAVE_TABELA').AsString = 'MOVDET') or
          (qryDados.FieldByName('CHAVE_TABELA').AsString = 'NOTDET')) then
    exit;

  pLogImp('fDuplicouItens >');
  stlItens := TStringList.Create;
  try
    stlItens.Clear;
    qryDados.First;
    while not qryDados.Eof do
    begin
      if fEmptyStr(qryDados.FieldByName('DET_AUTOINCREM').AsString) then
      begin
        qryDados.Next;
        Continue;
      end;

      if stlItens.IndexOf(qryDados.FieldByName('DET_AUTOINCREM').AsString) >= 0 then
      begin
        Result := True;
        Break;
      end;

      stlItens.Add(qryDados.FieldByName('DET_AUTOINCREM').AsString);

      qryDados.Next;
    end;
  finally
    FreeAndNil(stlItens);
    pLogImp('fDuplicouItens < = '+IIF(Result, 'S', 'N'));
  end;
end;

function TFonteDadosBD.fTemMensagemParaCFOP(strAutInc,
  strClaFis: string): Boolean;
var
  qryCFOPMsg: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  try
    qryCFOPMsg := fCriaQuery(Nil);
    qryCFOPMsg.Close;
    qryCFOPMsg.SQL.Clear;
    qryCFOPMsg.SQL.Add('SELECT CFO_CFOPMS FROM MSGCFO WHERE CFO_CFOPMS = :CFOPMS AND CFO_SEQABF = :SEQABF');
    qryCFOPMsg.ParamByName('CFOPMS').AsString := strClaFis;
    qryCFOPMsg.ParamByName('SEQABF').AsString := strAutInc;
    qryCFOPMsg.Open;
    Result := not qryCFOPMsg.IsEmpty;
  finally
    FreeAndNil(qryCFOPMsg);
  end;
end;

function TFonteDadosBD.GetTemPerfilAduaneiro: Boolean;
begin
  Result :=  FTemPerfilAduaneiro;
end;

function TFonteDadosBD.fTipoDocManifesto(strNumMan: string): string;
var
  qryTipDocME: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strSQL: string;
  blnExisteEmpMan: Boolean;
begin
  if (fCfgSisFonte(Self, 'EMICTE') <> 'S') then
  begin
    Result := 'NFe';
    Exit;
  end;

  blnExisteEmpMan := fCampoExiste('CADFIS', 'FIS_EMPMAN');
  qryTipDocME := fCriaQuery(Nil);
  try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  FIS_ESPDOC ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADFIS ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FIS_NUMMAN = :NUMMAN ';
    if blnExisteEmpMan then
      strSQL := strSQL + '  AND FIS_EMPMAN = :CODEMP '
    else
      strSQL := strSQL + '  AND FIS_CODEMP = :CODEMP ';
    strSQL := strSQL + 'LIMIT 1';

    qryTipDocME.SQL.Add(strSQL);
    qryTipDocME.ParamByName('NUMMAN').AsString := strNumMan;
    qryTipDocME.ParamByName('CODEMP').AsString := objConfig.strCodEmp;
    qryTipDocME.Open;

    if (qryTipDocME.FieldByName('FIS_ESPDOC').AsString = 'CT') then
      Result := 'CTe'
    else
      Result := 'NFe';
  finally
    FreeAndNil(qryTipDocME);
  end;
end;

function TFonteDadosBD.fTiraPipeEnter(const strTexto: String): String;
begin
  Result := strTexto;
  Result := AnsiReplaceStr(Result, '|', '');
  Result := AnsiReplaceStr(Result, #10, '');
  Result := AnsiReplaceStr(Result, #13, '');
end;

procedure TFonteDadosBD.pPreencheBeneficiarioDoCartao(var dtaDtaPag: TDateTime; var strCnpjBeneficiario: String);
var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strSQL: string;
begin

  dtaDtaPag := 0;
  strCnpjBeneficiario := '';

  qryAux := fCriaQuery(Nil);
  try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + ' EMP_C_G_C_, ';
    strSQL := strSQL + ' CTR_DTAREC ';
    strSQL := strSQL + 'FROM MOVMOD ';
    strSQL := strSQL + 'LEFT JOIN CADEMP ON EMP_CODEMP = MOD_CODEMP ';
    strSQL := strSQL + 'LEFT JOIN CADREC ON CTR_NUMDUP = MOD_NUMDOC ';
    strSQL := strSQL + '                AND CTR_ESPDOC = MOD_ESPDOC ';
    strSQL := strSQL + '                AND CTR_CODEMP = MOD_CODEMP ';
    strSQL := strSQL + '                AND CTR_CODCLI = MOD_CODCLI ';
    strSQL := strSQL + 'WHERE MOD_CODMOD = "007" ';
    strSQL := strSQL + '  AND MOD_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '  AND MOD_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '  AND MOD_CODEMP = :CODEMP ';
    strSQL := strSQL + '  AND MOD_CODCLI = :CODCLI ';
    strSQL := strSQL + '  AND MOD_SERIE_ = :SERIE_ ';
    strSQL := strSQL + 'LIMIT 1 ';

    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMDOC').AsString := dadosGerais.strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := dadosGerais.strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := dadosGerais.strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := dadosGerais.strCodCli;
    qryAux.ParamByName('SERIE_').AsString := dadosGerais.strSerie;
    qryAux.Open;

    if not qryAux.IsEmpty Then
    Begin
      dtaDtaPag           := qryAux.FieldByName('CTR_DTAREC').AsDateTime;
      strCnpjBeneficiario := fTiraCaracEspeciaisPonto(qryAux.FieldByName('EMP_C_G_C_').AsString);
    End;

  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TFonteDadosBD.pCarregaArrFormasPagamento(const qryModalidades: TDataSet; var fltTotalModalidades: Double; dadosGerais: TDadosGerais);
var
  LstrVerSat: String ;
  LstrCndPag: String;
begin
  fltTotalModalidades := 0;
  LstrVerSat := fConfiguracao('VERSAT');
  LstrVerSat := IfThen(fEmptyStr(LstrVerSat), '0.07', LstrVerSat);
  LstrCndPag := IIF(fEmptyStr(dadosGerais.strCondPagamento), '01000', dadosGerais.strCondPagamento);

  If (fEhCupomEletronicoSAT(dadosGerais)) Then
    pLogImp('VERSAT = ' + LstrVerSat);

  While (Not qryModalidades.Eof) Do
  Begin
    If qryModalidades.FieldByName('VALMOD').AsFloat <= 0 Then
    Begin
      qryModalidades.Next;
      Continue;
    End;

    SetLength(dadosGerais.arrFormasPagamento, Length(dadosGerais.arrFormasPagamento)+1);
    dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1] := TFormaPagamento.Create;
    dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCodigo    := qryModalidades.FieldByName('CODMOD').AsString;
    dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strModCodMod := qryModalidades.FieldByName('MOD_CODMOD').AsString;
    dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].fltValor     := qryModalidades.FieldByName('VALMOD').AsFloat;
    dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCndPag    := LstrCndPag;

    If fExisteRecebimentoEmPix(dadosGerais.strEndToEndIdPixRecebimento,
                               dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strModCodMod,
                               dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].fltValor,
                               dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strEndToEndIdPix,
                               dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].dtaDtaPag,
                               dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCnpjFinanceira,
                               dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCnpjBeneficiario)
       Or fEhOrdemPagamentoSemPixSat007(LstrVerSat, qryModalidades.FieldByName('MOD_CODMOD').AsString, qryModalidades.FieldByName('PIXS_N').AsString, dadosGerais)
       Or fEhOrdemPagamentoSatEquipamentoNaoSuportaCod16Ou17(qryModalidades.FieldByName('MOD_CODMOD').AsString, dadosGerais)
       Or (qryModalidades.FieldByName('PIXS_N').AsString = 'S') Then
    Begin
      If (fEhCupomEletronicoSAT(dadosGerais)) Then
        dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCodigo := fValCfgOrdemPagamentoSatEquipamentoNaoSuportaCod16Ou17(qryModalidades.FieldByName('MOD_CODMOD').AsString, dadosGerais)
      Else
        dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCodigo := FORMA_PAGTO_PIX;

      pLogImp('PIX, Codigo do Meio de Pagamento.: ' + dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCodigo);

      If not (fEhCupomEletronicoSAT(dadosGerais)) And fEmptyStr(dadosGerais.strEndToEndIdPixRecebimento) Then
      Begin
        dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCodigo    := '01';
        dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strModCodMod := '001';
        pLogImp('PIX com váriavel strEndToEndIdPixRecebimento vazia, convertido em dinheiro.');
      End;
    End;

    If fCampoExiste('MOVMOD', 'MOD_VALPAG') Then
      dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].fltValPag := qryModalidades.FieldByName('VALPAG').AsFloat
    Else
      dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].fltValPag := 0;

    If (qryModalidades.FieldByName('MOD_CODMOD').AsString = '007') Then
    Begin
      pPreencheBeneficiarioDoCartao(dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].dtaDtaPag,
                                    dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCnpjBeneficiario);

      dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCodRed := qryModalidades.FieldByName('CODRED').AsString;
      If fEmptyStr(dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCodRed) Then
        dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCodRed := fConfiguracao('COCPRD');
    End
    Else
      dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCodRed := '';

    fltTotalModalidades := fltTotalModalidades + qryModalidades.FieldByName('VALMOD').AsFloat;

    qryModalidades.Next;
  End;
end;

procedure TFonteDadosBD.pCarregaAtividadeConstrutora;
begin
  objConfig.strVS_CliAti := fRetAtividades;
end;

procedure TFonteDadosBD.pCarregaCfgDesFab(var blnDesFab: Boolean);
  Var
    strVal: String;
begin
  blnDesFab := True;

  strVal := fConfiguracao('DESFAB');

  If (Not fEmptyStr(strVal)) Then
    blnDesFab := (fConfiguracao('DESFAB') = 'S');
end;

procedure TFonteDadosBD.pCarregaDuplicatas(dadosGerais: TDadosGerais);
  Var
    fltTotVPar: Double;
    intQtdVPar: Integer;
    blnUsaVPar: Boolean;
    intContador: Integer;
    strSQLDupAgr: String;
    strSQLCadRec: String;
    strSQLAgrIfs: String;
    strSQL: String;
begin

  If Not Assigned(qryDuplicatas) Then
  Begin
    qryDuplicatas := fCriaQuery(Nil);
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '  CTR_NUMDUP, ';
    strSQL := strSQL + '  CTR_PARCEL, ';
    strSQL := strSQL + '  CTR_DTAVEN, ';
    strSQL := strSQL + ' /*VALORI*/ ';
    strSQL := strSQL + '  CTR_VALDUP, ';
    strSQL := strSQL + '  CTR_SEQBAI  ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + ' WHERE ';
    if (fCfgSisFonte(Self, 'USABAC') = 'S') And (Not fDestacaNosDadosAdcionaisDuplicatasQuitadasCreditos) then
      strSQL := strSQL + '  CTR_SEQBAI = 0 AND ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    if fCampoExiste('CADREC', 'CTR_SERIE_') Then
      strSQL := strSQL + '  CTR_SERIE_ = :SERIE_ AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI     ';

    If (objConfigInterna.blnAgrDup) Then
    Begin
      strSQL := strSQL + ' GROUP BY ';
      strSQL := strSQL + '  CTR_PARCEL, ';
      strSQL := strSQL + '  CTR_DTAVEN  ';
    End;

    strSQLCadRec := AnsiReplaceStr(strSQL, '/*VALORI*/', fRetCampoValOri);

    strSQLDupAgr := AnsiReplaceStr(strSQL, '/*VALORI*/', fRetCampoValOri('DUPAGR'));
    strSQLDupAgr := AnsiReplaceStr(strSQLDupAgr, 'CADREC', 'DUPAGR');

    qryDuplicatas.SQL.Add(strSQLCadRec + ' UNION ALL ' + strSQLDupAgr);

    If (fCfgSisFonte(Self,'PROCTR') = '1') And (fCfgSisFonte(Self,'AGDPIF') = 'S') Then
    Begin
      strSQLAgrIfs := ' UNION ALL '
                    + 'SELECT '
                    + '       C.CTR_NUMDUP '
                    + '     , C.CTR_PARCEL '
                    + '     , C.CTR_DTAVEN '
                    + '     , C.CTR_VALORI '
                    + '     , C.CTR_VALDUP '
                    + '     , C.CTR_SEQBAI '
                    + '  FROM CADREC C '
                    + ' WHERE C.CTR_ESPDOC = "AG" '
                    + '   AND EXISTS(SELECT G.AUTOINCREM FROM MOVGER G '
                    + '               INNER JOIN DUPAGR D ON D.CTR_NUMDUP = G.GER_NUMDOC '
                    + '                                  AND D.CTR_ESPDOC = G.GER_ESPDOC '
                    + '                                  AND D.CTR_CODEMP = G.GER_CODEMP '
                    + '               WHERE G.GER_NUMFAT = :NUMDUP '
                    + '                 AND G.GER_TIPFAT = :ESPDOC '
                    + '                 AND G.GER_EMPFAT = :CODEMP '
                    + '                 AND G.GER_CODCLI = :CODCLI '
                    + '                 AND G.GER_ESPDOC = "IF" '
                    + '                 AND D.CTR_NUMAGR = C.CTR_NUMDUP '
                    + '                 AND D.CTR_CODEMP = C.CTR_CODEMP) ';

      qryDuplicatas.SQL.Add(strSQLAgrIfs);
    End;

    qryDuplicatas.SQL.Add(' ORDER BY ');

    If (objConfigInterna.blnAgrDup) Then
      qryDuplicatas.SQL.Add('  CTR_PARCEL, CTR_DTAVEN ') //CTR_PARCEL,  CTR_DTAVEN
    Else
      qryDuplicatas.SQL.Add('  CTR_PARCEL, CTR_DTAVEN, CTR_VALDUP ');//CTR_PARCEL,  CTR_DTAVEN, CTR_VALDUP

    qryDuplicatas.ParamByName('NUMDUP').AsString := qryDados.FieldByName('GER_NUMDOC').AsString;
    qryDuplicatas.ParamByName('ESPDOC').AsString := qryDados.FieldByName('GER_ESPDOC').AsString;
    if fCampoExiste('CADREC', 'CTR_SERIE_') Then
      qryDuplicatas.ParamByName('SERIE_').AsString := qryDados.FieldByName('GER_SERIE_').AsString;
    qryDuplicatas.ParamByName('CODEMP').AsString := qryDados.FieldByName('GER_CODEMP').AsString;
    qryDuplicatas.ParamByName('CODCLI').AsString := qryDados.FieldByName('GER_CODCLI').AsString;
    qryDuplicatas.Open;
  End;

  fltTotVPar := 0;
  intQtdVPar := 0;

  If blnDupCND Then
  Begin
    For intContador := 0 To 23 Do
      If arrDuplicataCND[intContador].curValor > 0 Then
      Begin
        fltTotVPar := fltTotVPar + arrDuplicataCND[intContador].curValor;
        intQtdVPar := intQtdVPar + 1;
      End;
  End
  Else
  Begin
    For intContador := 1 To 12 Do
    Begin
      If qryDados.FieldByName('GER_VPAR' + untUtil.fStrZero(intContador, 2)).AsFloat = 0.00 Then
        Break;

      fltTotVPar := fltTotVPar + qryDados.FieldByName('GER_VPAR' + untUtil.fStrZero(intContador, 2)).AsFloat;
      intQtdVPar := intQtdVPar + 1;
    End;
  End;

  blnUsaVPar := (intQtdVPar = qryDuplicatas.RecordCount) And
                (fFormataFloat(fltTotVPar, 2) = fFormataFloat(qryDados.FieldByName('GER_VLRCON').AsFloat, 2));

  SetLength(dadosGerais.arrDuplicatas, 0);
  SetLength(dadosGerais.arrDuplicatas, qryDuplicatas.RecordCount);
  intContador := 0;

  qryDuplicatas.First;
  While (Not qryDuplicatas.Eof) Do
  Begin
    dadosGerais.arrDuplicatas[intContador] := TDuplicatas.Create;

    {*****************************************************************************}
    {* TENTATIVA DE IDENTIFICAR A DUPLICATA DE CRÉDITO PARA INCLUIR A SILGA "CR" *}
    {* ALTERAÇÃO SOLICITADA PELA PIG ATRAVÉS DO REQUISITO 45864.                 *}
    {**************************************************************************PZ*}
    If (Not objConfigInterna.blnAgrDup)                      And
       (qryDuplicatas.FieldByName('CTR_VALDUP').AsFloat = 0) Then
    Begin
      If (qryDuplicatas.FieldByName('CTR_SEQBAI').AsInteger > 0) Then
        dadosGerais.arrDuplicatas[intContador].strNumDup := qryDuplicatas.FieldByName('CTR_NUMDUP').AsString + consCredito
      Else
        dadosGerais.arrDuplicatas[intContador].strNumDup := qryDuplicatas.FieldByName('CTR_NUMDUP').AsString + consQuitada;
    End
    Else
    Begin
      dadosGerais.arrDuplicatas[intContador].strNumDup := qryDuplicatas.FieldByName('CTR_NUMDUP').AsString + '/' +
                                                          qryDuplicatas.FieldByName('CTR_PARCEL').AsString;
    End;

    dadosGerais.arrDuplicatas[intContador].dtaDtaVen := qryDuplicatas.FieldByName('CTR_DTAVEN').AsDateTime;

    If blnDupCND Then
    Begin
      If (arrDuplicataCND[intContador].curValor <> 0.00) And blnUsaVPar Then
        dadosGerais.arrDuplicatas[intContador].fltValDup := arrDuplicataCND[intContador].curValor
      Else
        dadosGerais.arrDuplicatas[intContador].fltValDup := qryDuplicatas.FieldByName('CTR_VALORI').AsFloat;
    End
    Else
    Begin
      If (qryDados.FieldByName('GER_VPAR' + untUtil.fStrZero(intContador+1, 2)).AsFloat <> 0.00) And blnUsaVPar Then
        dadosGerais.arrDuplicatas[intContador].fltValDup := qryDados.FieldByName('GER_VPAR' + untUtil.fStrZero(intContador+1, 2)).AsFloat
      Else
        dadosGerais.arrDuplicatas[intContador].fltValDup := qryDuplicatas.FieldByName('CTR_VALORI').AsFloat;
    End;

    qryDuplicatas.Next;
    Inc(intContador);
  End;
end;

procedure TFonteDadosBD.pCarregaDuplicatasOutrasNotas(dadosGerais: TDadosGerais);
  Var
    intContador: Integer;
    intQtdDup: Integer;
    intQtdParc: Integer;
    strCndPag: String;
    arrDatas: Array Of TDateTime;
    dtaDtaBas: TDateTime;

  function fPrecisaAjustarCndPag():Boolean;
  begin
    Result := ((Length(strCndPag) / 3) <> intQtdParc);
  end;

begin
  If fEmptyStr(dadosGerais.strCondPagamento) Then
    Exit;

  If (qryDados.FindField('GER_OPCDOC') <> Nil) And
     (qryDados.FieldByName('GER_OPCDOC').AsString = 'CA') Then
    Exit;

  If (Pos(dadosGerais.strClaFis, '5902_6902_5903_6903_') > 0) Then
    Exit;

  Try
    If (qryDados.FieldByName('GER_FATNOT').AsFloat > 0)    Or
       (qryDados.FieldByName('FIS_NOTESP').AsString = 'S') Or
       (qryDados.FieldByName('GER_CLIFIL').AsString = 'S') Then
    Begin
      strCndPag := dadosGerais.strCondPagamento;

      intQtdDup := StrToInt(LeftStr(strCndPag, 2));
      Delete(strCndPag, 1, 2);

      If (fTemAdiantamentoNotaEspecialFator(FNumDoc, FEspDoc, FCodEmp, FCodCli, intQtdParc)) And (intQtdParc <> intQtdDup) Then
      Begin
        For intContador := 1 To (intQtdParc - intQtdDup) Do
        Begin
          If (Not fPrecisaAjustarCndPag()) Then
            Break;

          strCndPag := '000' + strCndPag;
        End;

        intQtdDup := intQtdParc;
      End;

      dtaDtaBas := Date;
      If (dadosGerais.dtaDtaEnt > 0) And (dadosGerais.dtaDtaEnt < dtaDtaBas) Then
        dtaDtaBas := dadosGerais.dtaDtaEnt;

      SetLength(arrDatas, intQtdDup);
      For intContador := 1 To intQtdDup Do
      Begin
        arrDatas[intContador-1] := dtaDtaBas + StrToInt(Copy(strCndPag, 1, 3));
        Delete(strCndPag, 1, 3);
      End;

      SetLength(dadosGerais.arrDuplicatas, intQtdDup);
      For intContador := 1 To intQtdDup Do
      Begin
        If (blnDupCND) And (blnTemDupCND) Then
        Begin
          If (arrDuplicataCND[intContador-1].curValor <> 0) Then
          Begin
            dadosGerais.arrDuplicatas[intContador-1] := TDuplicatas.Create;
            dadosGerais.arrDuplicatas[intContador-1].strNumDup := dadosGerais.strNumDoc + '/' + Chr(64+intContador);
            dadosGerais.arrDuplicatas[intContador-1].dtaDtaVen := arrDatas[intContador-1];
            dadosGerais.arrDuplicatas[intContador-1].fltValDup := arrDuplicataCND[intContador-1].curValor;
          End;
        End
        Else
        Begin
          If (qryDados.FieldByName('GER_VPAR' + untUtil.fStrZero(intContador, 2)).AsFloat <> 0) Then
          Begin
            dadosGerais.arrDuplicatas[intContador-1] := TDuplicatas.Create;
            dadosGerais.arrDuplicatas[intContador-1].strNumDup := dadosGerais.strNumDoc + '/' + Chr(64+intContador);
            dadosGerais.arrDuplicatas[intContador-1].dtaDtaVen := arrDatas[intContador-1];
            dadosGerais.arrDuplicatas[intContador-1].fltValDup := qryDados.FieldByName('GER_VPAR' + untUtil.fStrZero(intContador, 2)).AsFloat;
          End;
        End;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pLogImp(E.Message + ' [untUtilBD.pCarregaDuplicatasOutrasNotas]');
    End;
  End;
end;

procedure TFonteDadosBD.pCarregaEmpresaNFSe;
begin
  objConfigInterna.strEmpNFSe := fConfiguracao('EMPSER');
end;

function TFonteDadosBD.fRetornaNCM(strCodNCM, strCodIte, strCodEmp: String): String;
begin
  Result := strCodNCM;

  strCodNCM := fRetornaNCMExterior(strCodIte);

  If not fEmptyStr(strCodNCM) Then
  Begin
    Result := strCodNCM;
    Exit;
  End;

  strCodNCM := fRetornaNCMEmpresa(strCodIte, strCodEmp);

  If fEmptyStr(strCodNCM) Then
    Exit;

  Result := strCodNCM;
end;

function TFonteDadosBD.fRetornaNCMEmpresa(strCodIte, strCodEmp: String): String;
var
  strCodNCM: String;
begin
  Result := '';

  If not (fConfiguracao('NCMEMP') = 'S') Then
    Exit;

  If fEmptyStr(strCodEmp) Then
    Exit;

  If (Not fTabelaExiste('CADNCE')) Then
    Exit;

  strCodNCM := fCampoTabela('NCE_CODNCM', 'CADNCE', ['NCE_CODEMP', 'NCE_CODITE'], [strCodEmp, strCodIte]);

  If fEmptyStr(strCodNCM) Then
    Exit;

  Result := strCodNCM;
end;

function TFonteDadosBD.fRetornaNCMExterior(strCodIte: String): String;
var
  strCodNCM: String;
begin
  Result := '';

  If Not SameText(dadosGerais.strEstado, 'EX') Then
    Exit;

  If (Not fTabelaExiste('CADNOP')) Then
    Exit;

  strCodNCM := fCampoTabela('NOP_CODNCM', 'CADNOP', ['NOP_CODPAI', 'NOP_CODITE'], [dadosGerais.strCodigoPais, strCodIte]);

  If Not fEmptyStr(strCodNCM) Then
    Result := strCodNCM;
end;

function TFonteDadosBD.fRetornaCodigoDeBarrasDoLote(strNumLot, strLotOri, strCodIte, strCodEmp, strEspDoc, strClaFis: String): String;
var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

  function fUsaLoteNaDescricaoDoProduto: Boolean;
  begin
    Result := False;

    If (strEspDoc = 'NF') And (fConfiguracao('NFELOT') = 'S') Then
    Begin
      Result := True;
      Exit;
    End;

    If (strEspDoc = 'IF') And (fConfiguracao('NFCLOT') = 'S') Then
    Begin
      Result := True;
      Exit;
    End;
  end;

  function fEhProdutoDeRetornoSimbolico: Boolean;
  begin
    Result := False;

    If RightStr(strClaFis, 3) = fConfiguracao('RSICFO') Then
    Begin
      Result := True;
      Exit;
    End;

    If RightStr(strClaFis, 3) = fConfiguracao('RSRCFO') Then
    Begin
      Result := True;
      Exit;
    End;
  end;

begin
  Result := strNumLot;

  If not fUsaLoteNaDescricaoDoProduto Then
    Exit;

  If fEhProdutoDeRetornoSimbolico Then
    Exit;

  if (UpperCase(Trim(Result)) = 'A DEFINIR') then
    Exit;

  if not (fConfiguracao('LOTECB') = '2') then
    Exit;

  If not fCampoExiste('CADLOT', 'LOT_CODBAR') Then
    Exit;

  qryAux := fCriaQuery(Nil);
  Try
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT LOT_CODBAR FROM CADLOT '+
                       'WHERE LOT_NUMLOT = :NUMLOT '+
                       '  AND LOT_CODITE = :CODITE '+
                       '  AND LOT_CODEMP = :CODEMP ';
    qryAux.ParamByName('NUMLOT').AsString := strLotOri;
    qryAux.ParamByName('CODITE').AsString := strCodIte;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.Open;

    If not qryAux.IsEmpty Then
    Begin
      Result := qryAux.FieldByName('LOT_CODBAR').AsString;
    End;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fRetornaNumLote(strNumLote, strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte, strSeqDet: String;
                                       out strDtaFab: String; out strDtaVal: String; out strNumLotDtaVal: String): String;
const
  strTagMovAux = ' /*MOVAUX*/ ';
var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strSQL: String;
begin
  Result := strNumLote;

  strDtaFab := '';
  strDtaVal := '';
  strNumLotDtaVal := '';

  if fConfiguracao('NFELOT') <> 'S' then
    Exit;

  if not fUsaRotinaWMS then
    Exit;

  if UpperCase(Trim(Result)) <> 'A DEFINIR' then
    Exit;

  qryAux := fCriaQuery(Nil);
  Try
    strSQL := strSQL + ' SELECT';
    strSQL := strSQL + '    DET_NUMLOT';

    If fCampoExiste('CADLOT', 'LOT_DTAFAB') Then
    Begin
      strSQL := strSQL + '  ,(SELECT LOT_DTAFAB FROM CADLOT';
      strSQL := strSQL + '     WHERE DET_NUMLOT = LOT_NUMLOT';
      strSQL := strSQL + '       AND DET_CODITE = LOT_CODITE';
      strSQL := strSQL + '       AND DET_CODEMP = LOT_CODEMP) AS LOT_DTAFAB';
    End;

    If fCampoExiste('CADLOT', 'LOT_DTAVAL') Then
    Begin
      strSQL := strSQL + '  ,(SELECT LOT_DTAVAL FROM CADLOT';
      strSQL := strSQL + '     WHERE DET_NUMLOT = LOT_NUMLOT';
      strSQL := strSQL + '       AND DET_CODITE = LOT_CODITE';
      strSQL := strSQL + '       AND DET_CODEMP = LOT_CODEMP) AS LOT_DTAVAL';
    End;

    strSQL := strSQL + ' FROM';
    strSQL := strSQL + '   MOVDET '+ strTagMovAux;
    strSQL := strSQL + ' WHERE DET_NUMFAT = :NUMDOC';
    strSQL := strSQL + '   AND DET_TIPFAT = :ESPDOC';
    strSQL := strSQL + '   AND DET_EMPFAT = :CODEMP';
    strSQL := strSQL + '   AND DET_CLIFAT = :CODCLI';
    strSQL := strSQL + '   AND DET_CODITE = :CODITE';
    strSQL := strSQL + '   AND DET_ESPDOC IN ("TA", "TL")';
    strSQL := strSQL + '   AND DET_CLAFIS > "5000"';

    qryAux.Close;
    qryAux.SQL.Clear;
    If (Not fEmptyStr(strSeqDet)) And (fCampoExiste('MOVAUX', 'DET_INCORI')) Then
    Begin
      qryAux.SQL.Text := AnsiReplaceStr(strSQL, strTagMovAux, 'LEFT JOIN MOVAUX ON MOVDET.AUTOINCREM = MOVAUX.DET_SEQGER');
      qryAux.SQL.Add('     AND COALESCE(DET_INCORI, :INCORI) = :INCORI');
      qryAux.ParamByName('INCORI').AsString := strSeqDet;
    End
    Else
    Begin
      qryAux.SQL.Text := strSQL
    End;

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('CODITE').AsString := strCodIte;
    qryAux.Open;

    If qryAux.IsEmpty Then
    Begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Text := AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET');
      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.ParamByName('CODITE').AsString := strCodIte;
      qryAux.Open;
    End;

    qryAux.First;
    While Not qryAux.Eof Do
    Begin
      If (Not fEmptyStr(qryAux.FieldByName('DET_NUMLOT').AsString)) Then
      Begin
        If (qryAux.Bof) Then
        Begin
          Result := qryAux.FieldByName('DET_NUMLOT').AsString;
          If (qryAux.FindField('LOT_DTAFAB') <> Nil) Then
            strDtaFab := qryAux.FieldByName('LOT_DTAFAB').AsString;
          If (qryAux.FindField('LOT_DTAVAL') <> Nil) Then
            strDtaVal := qryAux.FieldByName('LOT_DTAVAL').AsString;
        End;

        If (qryAux.RecordCount > 1) then
        Begin
          If (fCfgSisFonte(Self, 'VALLOT') = 'S') Then
          Begin
            strNumLotDtaVal := strNumLotDtaVal + 'LOTE: ' + qryAux.FieldByName('DET_NUMLOT').AsString + ' VALIDADE: ' + qryAux.FieldByName('LOT_DTAVAL').AsString + ' ';
          End
          Else
          Begin
            strNumLotDtaVal := strNumLotDtaVal + 'LOTE: ' + qryAux.FieldByName('DET_NUMLOT').AsString + ' ';
          End;
        End;
      End;

      qryAux.Next;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TFonteDadosBD.pCarregaItensNotaComp(dadosGerais: TDadosGerais; strAutIncCadFis: String);

  procedure pAdicionaCampoIteCom(strCampo: String; strValEmpty: String);
  begin
    If fCampoExiste('ITECOM', strCampo) Then
      qryItensNotaComp.SQL.Add('  , ITECOM.' + strCampo + ' AS ' + strCampo + ' ')
    Else
      qryItensNotaComp.SQL.Add('  , ' + strValEmpty + ' AS ' + strCampo + ' ');
  end;

  procedure pAdicionaCampoCadIte(strCampo: String; strValEmpty: String);
  begin
    If fCampoExiste('CADITE', strCampo) Then
      qryItensNotaComp.SQL.Add('  , CADITE.' + strCampo + ' AS ' + strCampo + ' ')
    Else
      qryItensNotaComp.SQL.Add('  , ' + strValEmpty + ' AS ' + strCampo + ' ');
  end;

  Var
    blnExisteComIcd : Boolean;

begin
  If dadosGerais.blnNfComp And fTabelaExiste('ITECOM') And Not Assigned(qryItensNotaComp) Then
  Begin
    blnExisteComIcd := fTabelaExiste('COMICD');

    qryItensNotaComp := fCriaQuery(Nil);

    With qryItensNotaComp, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT ');
      Add('  ITC_CODITE, ');
      Add('  ITC_DESCRI, ');
      Add('  ITC_REFERE, ');
      Add('  UNI_SIGUNI, ');
      Add('  ITC_CODFIS, ');
      Add('  ITC_CLAFIS, ');
      Add('  ITC_BASICM, ');
      Add('  ITC_ALQICM, ');
      Add('  ITC_VALICM, ');
      Add('  ITC_BASRET, ');
      Add('  ITC_ALQRET, ');
      Add('  ITC_VALRET, ');

      If fCampoExiste('ITECOM', 'ITC_SICMEF') Then
        Add('  ITC_SICMEF, ')
      Else
        Add('  0.00 AS ITC_SICMEF, ');

      If fCampoExiste('ITECOM', 'ITC_BSTANT') Then
        Add('  ITC_BSTANT, ')
      Else
        Add('  0.00 AS ITC_BSTANT, ');

      If fCampoExiste('ITECOM', 'ITC_VSTANT') Then
        Add('  ITC_VSTANT, ')
      Else
        Add('  0.00 AS ITC_VSTANT, ');

      If fCampoExiste('ITECOM', 'ITC_BFCPST') Then
        Add('  ITC_BFCPST, ')
      Else
        Add('  0.00 AS ITC_BFCPST, ');

      If fCampoExiste('ITECOM', 'ITC_PFCPST') Then
        Add('  ITC_PFCPST, ')
      Else
        Add('  0.00 AS ITC_PFCPST, ');

      If fCampoExiste('ITECOM', 'ITC_VFCPST') Then
        Add('  ITC_VFCPST, ')
      Else
        Add('  0.00 AS ITC_VFCPST, ');

      If fCampoExiste('ITECOM', 'ITC_QTDITE') Then
        Add('  ITC_QTDITE, ')
      Else
        Add('  0.00 AS ITC_QTDITE, ');

      If fCampoExiste('ITECOM', 'ITC_UNITAR') Then
        Add('  ITC_UNITAR, ')
      Else
        Add('  0.00 AS ITC_UNITAR, ');

      If fCampoExiste('ITECOM', 'ITC_ICMSOP') Then
        Add('  ITC_ICMSOP, ')
      Else
        Add('  0.00 AS ITC_ICMSOP, ');

      If fCampoExiste('ITECOM', 'ITC_PERDIF') Then
        Add('  ITC_PERDIF, ')
      Else
        Add('  0.00 AS ITC_PERDIF, ');

      If fCampoExiste('ITECOM', 'ITC_ICMDIF') Then
        Add('  ITC_ICMDIF, ')
      Else
        Add('  0.00 AS ITC_ICMDIF, ');

      Add('  ITC_BASIPI, ');
      Add('  ITC_ALQIPI, ');
      Add('  ITC_VALIPI, ');
      Add('  ITE_CLAIPI  ');

      If fCampoExiste('CADITE', 'ITE_EXCIPI') Then
        Add('  , CADITE.ITE_EXCIPI AS ITE_EXCIPI ')
      Else
        Add('  , " " AS ITE_EXCIPI ');

      If fCampoExiste('CADITE', 'ITE_CDCEST') Then
      Begin
        Add('  , CADITE.ITE_CDCEST ');
      End
      Else If fConfiguracao('CESTPD') <> '' Then
      Begin
        Add('  , ' + fConfiguracao('CESTPD') + ' AS ITE_CDCEST ');
      End
      Else Begin
        Add('  , "" AS ITE_CDCEST ');
      End;

      If fCampoExiste('ITECOM', 'ITC_VALCOM') Then
        Add('  , ITECOM.ITC_VALCOM AS ITC_VALCOM ')
      Else
        Add('  , 0.00 AS ITC_VALCOM ');

      If fCampoExiste('ITECOM', 'ITC_NUM_DI') Then
      Begin
        Add('  , ITECOM.ITC_NUM_DI AS ITC_NUM_DI ');
        Add('  , ITECOM.ITC_DTA_DI AS ITC_DTA_DI ');
        Add('  , ITECOM.ITC_LCDESE AS ITC_LCDESE ');
        Add('  , ITECOM.ITC_UFDESE AS ITC_UFDESE ');
        Add('  , ITECOM.ITC_DTDESE AS ITC_DTDESE ');
        Add('  , ITECOM.ITC_VTRINT AS ITC_VTRINT ');
        Add('  , ITECOM.ITC_VAFRMM AS ITC_VAFRMM ');
        Add('  , ITECOM.ITC_FORIMP AS ITC_FORIMP ');
        Add('  , ITECOM.ITC_CGCADQ AS ITC_CGCADQ ');
        Add('  , ITECOM.ITC_UF_ADQ AS ITC_UF_ADQ ');
      End
      Else
      Begin
        Add('  , ""   AS ITC_NUM_DI ');
        Add('  , 0    AS ITC_DTA_DI ');
        Add('  , ""   AS ITC_LCDESE ');
        Add('  , ""   AS ITC_UFDESE ');
        Add('  , 0    AS ITC_DTDESE ');
        Add('  , ""   AS ITC_VTRINT ');
        Add('  , 0.00 AS ITC_VAFRMM ');
        Add('  , ""   AS ITC_FORIMP ');
        Add('  , ""   AS ITC_CGCADQ ');
        Add('  , ""   AS ITC_UF_ADQ ');
      End;

      pAdicionaCampoCadIte('ITE_INDESC', '"S"');
      pAdicionaCampoCadIte('ITE_CNPFME', '""');
      pAdicionaCampoCadIte('ITE_CDBFIS', '""');
      pAdicionaCampoCadIte('ITE_ENIECB', '"N"');
      pAdicionaCampoCadIte('ITE_CODFOR', '""');

      pAdicionaCampoIteCom('ITC_CSTPIS', '""');
      pAdicionaCampoIteCom('ITC_CSTCOF', '""');
      pAdicionaCampoIteCom('ITC_BASPIS', '0.00');
      pAdicionaCampoIteCom('ITC_BASCOF', '0.00');
      pAdicionaCampoIteCom('ITC_ALQPIS', '0.00');
      pAdicionaCampoIteCom('ITC_ALQCOF', '0.00');
      pAdicionaCampoIteCom('ITC_VALPIS', '0.00');
      pAdicionaCampoIteCom('ITC_VALCOF', '0.00');

      If (blnExisteComIcd) Then
      Begin
        Add('  ,ITECOM.AUTOINCREM AS ICD_AUTINC ');
        Add('  ,ICD_ALQINE ');
        Add('  ,ICD_ALQUFD ');
        Add('  ,ICD_BCUFDE ');
        Add('  ,ICD_PERFCP ');
        Add('  ,ICD_PERPAR ');
        Add('  ,ICD_VALDES ');
        Add('  ,ICD_VALFCP ');
        Add('  ,ICD_VALORI ');
        Add('  ,ICD_BASFCP ');
      End;

      If fCampoExiste('CADITE', 'ITE_CODLUB') Then
        Add('  ,CADITE.ITE_CODLUB ')
      Else
        Add('  , "" AS ITE_CODLUB ');

      If fCampoExiste('CADITE', 'ITE_DESANP') Then
        Add('  ,CADITE.ITE_DESANP ')
      Else
        Add('  , "" AS ITE_DESANP ');

      If fCampoExiste('CADITE', 'ITE_CODFAB') Then
        Add('  ,CADITE.ITE_CODFAB ')
      Else
        Add('  , "" AS ITE_CODFAB ');

      Add('FROM ');
      Add('  ITECOM ');
      Add('  INNER JOIN CADITE ON ITE_CODITE = ITC_CODITE ');
      Add('  LEFT  JOIN CADUNI ON UNI_CODUNI = ITC_UNIDAD ');

      If (blnExisteComIcd) Then
        Add(' LEFT JOIN COMICD ON COMICD.ICD_SEQITE = ITECOM.AUTOINCREM ');

      Add('WHERE ');
      Add('  ITC_SEQFIS = :SEQFIS ');

      ParamByName('SEQFIS').AsString := strAutIncCadFis;
      Open;

      SetLength(dadosGerais.arrItensNfComp, RecordCount);

      First;
      While (Not Eof) Do
      Begin
        dadosGerais.arrItensNfComp[RecNo-1]           := TItemNfComp.Create;

        dadosGerais.arrItensNfComp[RecNo-1].strAutInc := '';
        dadosGerais.arrItensNfComp[RecNo-1].strCodIte := FieldByName('ITC_CODITE').AsString;
        dadosGerais.arrItensNfComp[RecNo-1].strCodFab := FieldByName('ITE_CODFAB').AsString;
        dadosGerais.arrItensNfComp[RecNo-1].strDesIte := FieldByName('ITC_DESCRI').AsString;
        dadosGerais.arrItensNfComp[RecNo-1].strCodFis := FieldByName('ITC_CODFIS').AsString;
        dadosGerais.arrItensNfComp[RecNo-1].strClaFis := FieldByName('ITC_CLAFIS').AsString;
        dadosGerais.arrItensNfComp[RecNo-1].fltQtdIte := FieldByName('ITC_QTDITE').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltUnitar := FieldByName('ITC_UNITAR').AsFloat;

        If (FieldByName('ITE_CDCEST').AsString = '0000000') Then
          dadosGerais.arrItensNfComp[RecNo-1].strCdCEST := ''
        Else
          dadosGerais.arrItensNfComp[RecNo-1].strCdCEST := FieldByName('ITE_CDCEST').AsString;

        dadosGerais.arrItensNfComp[RecNo-1].strUnidad := FieldByName('UNI_SIGUNI').AsString;
        dadosGerais.arrItensNfComp[RecNo-1].strClaIpi := fRetornaNCM(FieldByName('ITE_CLAIPI').AsString, FieldByName('ITC_CODITE').AsString, dadosGerais.strCodEmp);
        dadosGerais.arrItensNfComp[RecNo-1].strExcIpi := FieldByName('ITE_EXCIPI').AsString;
        dadosGerais.arrItensNfComp[RecNo-1].fltBasIcm := FieldByName('ITC_BASICM').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltAlqIcm := FieldByName('ITC_ALQICM').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltValIcm := FieldByName('ITC_VALICM').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltBasRet := FieldByName('ITC_BASRET').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltAlqRet := FieldByName('ITC_ALQRET').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltValRet := FieldByName('ITC_VALRET').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltBasIpi := FieldByName('ITC_BASIPI').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltAlqIpi := FieldByName('ITC_ALQIPI').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltValIpi := FieldByName('ITC_VALIPI').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltValCom := FieldByName('ITC_VALCOM').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].strCstPis := FieldByName('ITC_CSTPIS').AsString;
        dadosGerais.arrItensNfComp[RecNo-1].strCstCof := FieldByName('ITC_CSTCOF').AsString;
        dadosGerais.arrItensNfComp[RecNo-1].fltBasPis := FieldByName('ITC_BASPIS').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltBasCof := FieldByName('ITC_BASCOF').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltAlqPis := FieldByName('ITC_ALQPIS').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltAlqCof := FieldByName('ITC_ALQCOF').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltValPis := FieldByName('ITC_VALPIS').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltValCof := FieldByName('ITC_VALCOF').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltBasFcpST := FieldByName('ITC_BFCPST').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltAlqFcpST := FieldByName('ITC_PFCPST').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltValFcpST := FieldByName('ITC_VFCPST').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltSICMEF := FieldByName('ITC_SICMEF').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltBSTANT := FieldByName('ITC_BSTANT').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltVSTANT := FieldByName('ITC_VSTANT').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltIcmsOP := FieldByName('ITC_ICMSOP').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltPerDif := FieldByName('ITC_PERDIF').AsFloat;
        dadosGerais.arrItensNfComp[RecNo-1].fltIcmDif := FieldByName('ITC_ICMDIF').AsFloat;

        If (blnExisteComIcd) Then
        Begin
          dadosGerais.arrItensNfComp[RecNo-1].strAutInc := FieldByName('ICD_AUTINC').AsString;
          dadosGerais.arrItensNfComp[RecNo-1].fltBasDes := FieldByName('ICD_BCUFDE').AsFloat;
          dadosGerais.arrItensNfComp[RecNo-1].fltPerFCP := FieldByName('ICD_PERFCP').AsFloat;
          dadosGerais.arrItensNfComp[RecNo-1].fltAlqUfd := FieldByName('ICD_ALQUFD').AsFloat;
          dadosGerais.arrItensNfComp[RecNo-1].fltAlqIne := FieldByName('ICD_ALQINE').AsFloat;
          dadosGerais.arrItensNfComp[RecNo-1].fltPerPar := FieldByName('ICD_PERPAR').AsFloat;
          dadosGerais.arrItensNfComp[RecNo-1].fltValFCP := FieldByName('ICD_VALFCP').AsFloat;
          dadosGerais.arrItensNfComp[RecNo-1].fltValDes := FieldByName('ICD_VALDES').AsFloat;
          dadosGerais.arrItensNfComp[RecNo-1].fltValOri := FieldByName('ICD_VALORI').AsFloat;
          dadosGerais.arrItensNfComp[RecNo-1].fltBasFCP := FieldByName('ICD_BASFCP').AsFloat;
        End;

        dadosGerais.arrItensNfComp[RecNo-1].strCodLub := FieldByName('ITE_CODLUB').AsString;
        dadosGerais.arrItensNfComp[RecNo-1].strDesANP := FieldByName('ITE_DESANP').AsString;

        If not fEmptyStr(FieldByName('ITC_NUM_DI').AsString) Then
        Begin
          dadosGerais.arrItensNfComp[RecNo-1].documentoImportacao := TDocumentoImportacao.Create;
          dadosGerais.arrItensNfComp[RecNo-1].documentoImportacao.strNumeroDi                := FieldByName('ITC_NUM_DI').AsString;
          dadosGerais.arrItensNfComp[RecNo-1].documentoImportacao.dtaDataDi                  := FieldByName('ITC_DTA_DI').AsDateTime;
          dadosGerais.arrItensNfComp[RecNo-1].documentoImportacao.strLocalizacaoDesembaracao := FieldByName('ITC_LCDESE').AsString;
          dadosGerais.arrItensNfComp[RecNo-1].documentoImportacao.strUFDesembaraco           := FieldByName('ITC_UFDESE').AsString;
          dadosGerais.arrItensNfComp[RecNo-1].documentoImportacao.dtaDataDesembaraco         := FieldByName('ITC_DTDESE').AsDateTime;

          dadosGerais.arrItensNfComp[RecNo-1].documentoImportacao.intViaTransporte      := strToIntDef(FieldByName('ITC_VTRINT').AsString, 0);
          dadosGerais.arrItensNfComp[RecNo-1].documentoImportacao.fltValorAFRMM         := FieldByName('ITC_VAFRMM').AsFloat;
          dadosGerais.arrItensNfComp[RecNo-1].documentoImportacao.intFormaIntermediacao := strToIntDef(FieldByName('ITC_FORIMP').AsString, 0);
          dadosGerais.arrItensNfComp[RecNo-1].documentoImportacao.strCNPJAdquirente     := FieldByName('ITC_CGCADQ').AsString;
          dadosGerais.arrItensNfComp[RecNo-1].documentoImportacao.strUFAdquirente       := FieldByName('ITC_UF_ADQ').AsString;
        End;

        Next;
      End;
    End;
  End;
end;

procedure TFonteDadosBD.pCarregaTotalDuplicataRecebida(dadosGerais: TDadosGerais);
  Var
    intContador: Integer;
begin
  If (qryDados.FieldByName('GER_DUPREC').AsFloat > 0)  And
     (qryDados.FieldByName('GER_FATNOT').AsFloat <= 0) And
     (qryDados.FieldByName('FIS_NOTESP').AsString <> 'S') Then
  Begin
    SetLength(dadosGerais.arrDuplicatas, Length(dadosGerais.arrDuplicatas) + 1);

    For intcontador := Length(dadosGerais.arrDuplicatas) -1 downto 1 Do
    Begin
      dadosGerais.arrDuplicatas[intContador] := dadosGerais.arrDuplicatas[intContador -1];
    End;

    dadosGerais.arrDuplicatas[0] := TDuplicatas.Create;
    dadosGerais.arrDuplicatas[0].strNumDup := dadosGerais.strNumDoc + ' q';
    dadosGerais.arrDuplicatas[0].dtaDtaVen := dadosGerais.dtaDtaEnt;
    dadosGerais.arrDuplicatas[0].fltValDup := qryDados.FieldByName('GER_DUPREC').AsFloat;
  End;
end;

procedure TFonteDadosBD.pGravaTabela(objItem: TDadosItem; strTabela: String);
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('REPLACE INTO '+ strTabela); {MOVICD_ESPEC, NOTICD_ESPEC}
    qryAux.SQL.Add(' (ICD_SEQGER, ');
    qryAux.SQL.Add('  ICD_ALQINE, ');
    qryAux.SQL.Add('  ICD_ALQUFD, ');
    qryAux.SQL.Add('  ICD_BCUFDE, ');
    qryAux.SQL.Add('  ICD_PERFCP, ');
    qryAux.SQL.Add('  ICD_PERPAR, ');
    qryAux.SQL.Add('  ICD_VALDES, ');
    qryAux.SQL.Add('  ICD_VALFCP, ');
    qryAux.SQL.Add('  ICD_VALORI, ');
    qryAux.SQL.Add('  ICD_BASFCP) ');
    qryAux.SQL.Add('VALUES ');
    qryAux.SQL.Add(' (:SEQGER, ');
    qryAux.SQL.Add('  :ALQINE, ');
    qryAux.SQL.Add('  :ALQUFD, ');
    qryAux.SQL.Add('  :BCUFDE, ');
    qryAux.SQL.Add('  :PERFCP, ');
    qryAux.SQL.Add('  :PERPAR, ');
    qryAux.SQL.Add('  :VALDES, ');
    qryAux.SQL.Add('  :VALFCP, ');
    qryAux.SQL.Add('  :VALORI, ');
    qryAux.SQL.Add('  :BASFCP) ');

    qryAux.ParamByName('SEQGER').AsString := objItem.strAutInc;
    qryAux.ParamByName('ALQINE').AsFloat  := objItem.fltAliquotaInterestadual;
    qryAux.ParamByName('ALQUFD').AsFloat  := objItem.fltAliquotaDestino;
    qryAux.ParamByName('BCUFDE').AsFloat  := objItem.fltBaseUfDestino;
    qryAux.ParamByName('PERFCP').AsFloat  := objItem.fltPercentualFCP;
    qryAux.ParamByName('PERPAR').AsFloat  := objItem.fltPercentualPartilha;
    qryAux.ParamByName('VALDES').AsFloat  := objItem.fltValorIcmsDestino;
    qryAux.ParamByName('VALFCP').AsFloat  := objItem.fltValorFCP;
    qryAux.ParamByName('VALORI').AsFloat  := objItem.fltValorIcmsOrigem;
    qryAux.ParamByName('BASFCP').AsFloat  := objItem.fltBaseFCP;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fCriaObjetoLogPerformance(intCodigo: Integer; strMensagem: String): TLogPerformance;
begin
  //Função em desuso, mantida apenas por compatibilidade;

  Result := Nil;
  Exit;

  Result := TLogPerformance.Create;
  Result.strOrigem := Self.ClassName;
  Result.strNumDoc := FNumDoc;
  Result.strEspDoc := FEspDoc;
  Result.strCodEmp := FCodEmp;
  Result.strCodCli := FCodCli;
  Result.strSerie := FSerie;
  Result.strTipFc := '';
  Result.dtaHoraInicial := nOw();
  Result.intCodigo := intCodigo;
  Result.strMensagem := strMensagem;
end;

procedure TFonteDadosBD.pCarregarDados;
  Const
    STR_CLIENTE_CONSUMIDOR = 'CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%"';
  Var
    strSQL   : String;
    strSQLNot: String;
    strSQLDel: String;
    strTabAbf: String;
    blnBaEIPI: Boolean;
    blnVaEIPI: Boolean;

    blnBaERet: Boolean;
    blnVaERet: Boolean;

    blnCadFaz: Boolean;
    blnReformaNoValorContabil: Boolean;

    intAux   : Integer;

    blnNSRBru: Boolean;

    strSelectTraRed: String;
    strWhereTraRed_: String;
  Const
    strBasOrg = 'MOVGER.GER_BASORG AS GER_BASORG';
    strIcmOrg = 'MOVGER.GER_ICMORG AS GER_ICMORG';
    strChvNfe = 'AUX_CHVNFE AS GER_CHVNFE';
    strNumCOO = 'AUX_NUMCOO AS GER_NUMCOO';
    strNumSer = 'AUX_NUMSER AS GER_NUMSER';
    strNumUSU = 'AUX_NUMUSU AS GER_NUMUSU';
    strTipDoc = 'AUX_TIPDOC AS GER_TIPDOC';
    strEst_Dv = 'AUX_EST_DV AS GER_EST_DV';
    strNumero = 'AUX_NUMERO AS GER_NUMERO';
    strSerie_ = 'AUX_SERIE_ AS GER_SERIE1';
    strModelo = 'AUX_MODELO AS GER_MODELO';
    strCPFCNP = 'AUX_CPFCNP AS GER_CPFCNP';
    strEstado = 'AUX_ESTADO AS GER_ESTADO';
    strMesAno = 'AUX_MESANO AS GER_MESANO';
    strComVal = '"N"        AS GER_COMVAL';
    strBasVrd = 'AUX_BASVRD AS AUX_BASVRD';
    strVrdIcm = 'AUX_VRDICM AS AUX_VRDICM';
    strNumeroDrawback = 'AUX_NUMDRW AS AUX_NUMDRW';
    strRegEs2 = '"N" AS AUX_REGES2';
    strEmp_Te = 'AUX_EMP_TE AS AUX_EMP_TE';
    strTotSDs = 'AUX_TOTSDS AS AUX_TOTSDS';

    function fConsumid(const strCampoGer, strCampoCon: String): String;
    begin
      Result := 'IF(CLICON.CON_C_P_F_ IS NULL, MOVGER.' + strCampoGer + ', CLICON.' + strCampoCon + ') '
    end;

    function fFazenda(const strCampoCli, strCampoFaz: String): String;
    begin
      If Not blnCadFaz Then
        Result := strCampoCli
      Else
        Result := 'IF(FAZ_CODFAZ IS NULL, ' + strCampoCli + ', ' + strCampoFaz + ') '
    end;

    function fOutrasSaidasConEqu: Boolean;
    begin
      Result := (fTabelaExiste('MOVTRI')) And
        (fCampoExiste('MOVTRI', 'DET_NCMITE'));
    end;

    procedure pAdicionaCampoCadIte(strCampo: String; strValEmpty: String);
    begin
      If fCampoExiste('CADITE', strCampo) Then
        strSQL := strSQL + ' CADITE.' + strCampo + ' AS ' + strCampo + ',  '
      Else
        strSQL := strSQL + ' ' + strValEmpty + ' AS ' + strCampo + ',  ';
    end;

    function fUtilizaExtgorNoSelect : Boolean;
    begin
      Result := False;
      If (Not fTabelaExiste('EXTGOR')) Then
        Exit;
      If (Not fCampoExiste('EXTGOR', 'FGO_TX_PIX')) Then
        Exit;
      If (fConfiguracao('PGPIXL') <> 'S') Then
        Exit;
      Result := True;
    end;

begin
  If Assigned(dadosGerais) Then
    Exit;

  pLogImp('pCarregarDados >');

  if not fEmptyStr(fConfiguracao('CFODVF')) then
    CFOP_DEVOLUCAO_FORNECEDOR_NFE := fTransform(fConfiguracao('CFODVF'),4);

  blnCadFaz    := (fConfiguracao('CADFAZ') = 'S') And (fCampoExiste('AUXMOV', 'AUX_CODFAZ'));

  blnReformaNoValorContabil := fSomarNovosImpostosDaReformaAoValorContabil(Self, FCodEmp) And
                               fTabelaExiste('AUXMOV') And
                               fCampoExiste('AUXMOV', 'AUX_TOTCBS') And fCampoExiste('AUXMOV', 'AUX_TOTIBS') And fCampoExiste('AUXMOV', 'AUX_TOT_IS') And
                               fCampoExiste('AUXNOT', 'AUX_TOTCBS') And fCampoExiste('AUXNOT', 'AUX_TOTIBS') And fCampoExiste('AUXNOT', 'AUX_TOT_IS');

  If blnReformaNoValorContabil And (strIntegradorCitel = 'S') Then
    blnReformaNoValorContabil := fCampoExiste('DEL_AUXMOV', 'AUX_TOTCBS') And fCampoExiste('DEL_AUXMOV', 'AUX_TOTIBS') And fCampoExiste('DEL_AUXMOV', 'AUX_TOT_IS') And
                                 fCampoExiste('DEL_AUXNOT', 'AUX_TOTCBS') And fCampoExiste('DEL_AUXNOT', 'AUX_TOTIBS') And fCampoExiste('DEL_AUXNOT', 'AUX_TOT_IS');

  blnTrSeCi    := fConfiguracao('TRSECI') = 'S';
  blnBaEIPI    := fCampoExiste('MOVTRI', 'DET_BAEIPI');
  blnVaEIPI    := fCampoExiste('MOVTRI', 'DET_VAEIPI');

  blnBaERet    := fCampoExiste('MOVTRI', 'DET_BAERET');
  blnVaERet    := fCampoExiste('MOVTRI', 'DET_VAERET');
  blnDupCND    := fCampoExiste('GERCND', 'GER_PARCEL');

  blnNSRBru    := (fCampoExiste('CADEMP', 'EMP_NSRBRU')) And (fConfiguracao('NSRBRU') = 'S');

  intPosAtual := 0;

  If FEmitente Then
  Begin
    FChaAce    := fRetornaChaveAcesso;
    FChaTabela := EmptyStr;
    Exit;
  End;

  If FCodEmp <> objConfig.strCodEmp Then
    Raise Exception.Create('Empresa do Documento (' + FCodEmp +') é diferente da empresa configurada (' + objConfig.strCodEmp +'). Verifique.');

  If (Not Assigned(qryDados)) Then
    qryDados := fCriaQuery(Nil);

  blnCliConNC := fCampoExiste('NOTCOM', 'GER_CPFCON');

  objConfig.blnClaOnu := fTabelaExiste('CADONU') And (fConfiguracao('CLAONU') = 'S');

  objConfigInterna.strImpPag := fConfiguracao('IMPPAG');
  objConfigInterna.blnMsgIaI := (fConfiguracao('MSGIAI') = 'S');

  objConfigInterna.strImpOnu := fConfiguracao('IMPONU');
  If fEmptyStr(objConfigInterna.strImpOnu) Then
    objConfigInterna.strImpOnu := 'A';

  objConfig.blnVenMad := (fConfiguracao('VENMAD') = 'S');
  objConfig.blnVenMtl := (fConfiguracao('VENMTL') = 'S');

  objConfigInterna.blnImpLot := (fConfiguracao('NFELOT') <> 'N');

  objConfigInterna.blnFcpAni := (fConfiguracao('FCPANI') = 'S');

  objConfigInterna.blnAgrDup := True;
  If (Pos(fConfiguracao('AGRDUP'), 'N_S_') > 0) Then
    objConfigInterna.blnAgrDup := SameText(fConfiguracao('AGRDUP'), 'S');

  objConfigInterna.blnPDCNFE := (fConfiguracao('PDCNFE') = 'S');

  objConfigInterna.blnNFeDig := (fConfiguracao('NFEDIG') <> 'N');

  objConfigInterna.blnNFeBar := (fConfiguracao('NFEBAR') = 'S');

  objConfigInterna.strTCrIcm := fConfiguracao('TCRICM');

  objConfigInterna.blnUniTri := (fConfiguracao('UNITRI') = 'S');
  objConfigInterna.strUTCFOP := fTransform(fConfiguracao('UTCFOP'), 4);

  objConfigInterna.blnImprimeAnotacoesItem := (fConfiguracao('IMPANO')='S');

  objConfigInterna.blnComplInfAd := (fConfiguracao('CINFAD') = 'S');

  VS_PathSat := strPathSatCitel;

  strSelectTraRed := '';
  strWhereTraRed_ := '';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_TRARDP') Then
  Begin
    strSelectTraRed := ' TRARED.TRA_EMAIL_ AS TRA_EMAILR, ';
    strWhereTraRed_ := ' LEFT JOIN CADTRA AS TRARED ON AUXMOV.AUX_TRARDP = TRARED.TRA_CODTRA ';
  End;

  If fTabelaExiste('ABFICM') Then
    strTabAbf := 'ABFICM'//Nova tabela de abreviacao Fiscal
  Else
    strTabAbf := 'CADABF';

  If (FEspDoc = 'NS') Then
  Begin
    pAtualizaObraArtigo(fGetCodObr, fGetCodArt, FNumDoc, FEspDoc, FCodEmp, FCodCli, FTip_FC);
  End;

 {$IF Defined(VER180)}
 {$ELSE}
  if Assigned(untUtil.OnNotificarProgresso) then
    untUtil.OnNotificarProgresso('Carregando dados, aguarde ...');
 {$IFEND}

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADFIS.AUTOINCREM AS FIS_AUTOINCREM,  ';
  strSQL := strSQL + '  MOVDET.AUTOINCREM AS DET_AUTOINCREM,  ';
  strSQL := strSQL + '  "MOVDET"          AS CHAVE_TABELA,    ';
  strSQL := strSQL + '  MOVDET.DET_SEQGER AS CHAVE_DUPLICATA, ';

  strSQL := strSQL + '  MOVGER.GER_ESPDOC, ';
  strSQL := strSQL + '  MOVGER.GER_CODEMP, ';

  If FTip_FC = 'C' Then
  Begin
    strSQL := strSQL + '  MOVGER.GER_CODCLI, ';
    strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' +                                                                               '"S", "N") AS GER_CONSUM, ';
    strSQL := strSQL + '  " " AS GER_MATREV, ';
    strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_CGCCON', 'CON_C_P_F_') + ', ' + fFazenda('CLI_C_G_C_', 'FAZ_C_G_C_') + ') AS GER_CGCCON, ';
    strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_NOMCON', 'CON_NOMCON') + ', ' + fFazenda('CLI_NOMCLI', 'CLI_NOMCLI') + ') AS GER_NOMCON, ';
    strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_NOMCON', 'CON_NOMCON') + ', ' + fFazenda('CLI_NOMCLI', 'CLI_NOMCLI') + ') AS GER_NOMFAN, ';
    strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_ENDCON', 'CON_ENDERE') + ', ' + fFazenda('CLI_ENDERE', 'FAZ_NOMFAZ') + ') AS GER_ENDERE, ';
    strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', "", '                                            + fFazenda('CLI_ENDNUM', 'NULL'      ) + ') AS GER_ENDNUM, ';
    strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', "", '                                            + fFazenda('CLI_ENDCOM', 'NULL'      ) + ') AS GER_ENDCOM, ';
    strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_BAICON', 'CON_BAIRRO') + ', ' + fFazenda('CLI_BAIRRO', 'FAZ_BAIRRO') + ') AS GER_BAICON, ';
    strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_CIDCON', 'CON_CODCID') + ', ' + fFazenda('CLI_CODCID', 'FAZ_CODCID') + ') AS GER_CIDCON, ';
    strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_CEPCON', 'CON_C_E_P_') + ', ' + fFazenda('CLI_C_E_P_', 'FAZ_C_E_P_') + ') AS GER_CEPCON, ';
    strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_TELCON', 'CON_FONE01') + ', ' + fFazenda('CLI_FONE01', 'CLI_FONE01') + ') AS GER_TELCON, ';
    strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_IESCON', 'CON_I_E_S_') + ', ' + fFazenda('CLI_I_E_S_', 'FAZ_I_E_S_') + ') AS GER_IESCON, ';
    strSQL := strSQL + '  CC.CID_ESTADO AS GER_ESTCON, ';
    strSQL := strSQL + '  CC.CID_NOMCID AS GER_NOMCID, ';
    strSQL := strSQL + '  CC.CID_CODPAI AS GER_CODPAI, ';
    {***************************************************}
    {* SE O CAMPO GER_EMLCON EXISTIR NA TABELA MOVGER, *}
    {* PEGA O E-MAIL DO CLIENTE "CONSUMIDOR"           *}
    {************************************************RV*}
    If fCampoExiste('MOVGER', 'GER_EMLCON') Then
      strSQL := strSQL + '  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_EMLCON', 'CON_EMLCON') + ', ' + fFazenda('CLI_EMAIL3', 'CLI_EMAIL3') + ') AS GER_EMAIL_, '
    Else
      strSQL := strSQL + '  CLI_EMAIL3 AS GER_EMAIL_, ';

    strSQL := strSQL + ' CLI_SUFRAM AS GER_SUFRAM, ';

    strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%", "", CLI_EMAIL2)                AS GER_EMAIL2, ';
    strSQL := strSQL + '  CLI_DIFERI AS GER_DIFERI, ';

    If fCampoExiste('AUXMOV', 'AUX_RETISS') Then
      strSQL := strSQL + '  AUX_RETISS AS GER_RETISS, '
    Else
      strSQL := strSQL + '  CLI_RETISS AS GER_RETISS, ';

    If fCampoExiste('AUXMOV', 'AUX_NOTPAU') Then
      strSQL := strSQL + '  AUX_NOTPAU AS GER_NOTPAU, '
    Else
      strSQL := strSQL + '  "S" AS GER_NOTPAU, ';

    If fCampoExiste('MOVGER', 'GER_CONSUM') And (fConfiguracao('USOREV') = 'S') Then
      strSQL := strSQL + '  IF((GER_CONSUM = "S") OR (GER_CONSUM = "N"), GER_CONSUM, CLI_CONSUM) AS GER_CLICON, '
    Else
      strSQL := strSQL + '  CLI_CONSUM AS GER_CLICON, ';

    strSQL := strSQL + '  CLI_ZONFRA AS GER_ZONFRA, ';
    strSQL := strSQL + '  CLI_CODATI AS GER_CODATI, ';

    If fCampoExiste('CADCLI', 'CLI_BENCST') Then
      strSQL := strSQL + '  CLI_BENCST AS GER_BENCST, '
    Else
      strSQL := strSQL + '  "N" AS GER_BENCST, ';

    If fCampoExiste('CADCLI', 'CLI_REGFIS') Then
      strSQL := strSQL + '  CLI_REGFIS AS GER_REGFIS, '
    Else
      strSQL := strSQL + '  0 AS GER_REGFIS, ';

    If fCampoExiste('CADCLI', 'CLI_DESZON') Then
      strSQL := strSQL + '  CLI_DESZON AS GER_DESZON, '
    Else
      strSQL := strSQL + '  "N" AS GER_DESZON, ';

    If fCampoExiste('CADCLI', 'CLI_RETPCO') Then
      strSQL := strSQL + '  CLI_RETPCO AS GER_RETPCO, '
    Else
      strSQL := strSQL + '  "N" AS GER_RETPCO, ';

    If fCampoExiste('MOVGER', 'GER_CSLRET') Then
    Begin
      strSQL := strSQL + '  MOVGER.GER_PISRET, ';
      strSQL := strSQL + '  MOVGER.GER_COFRET, ';
      strSQL := strSQL + '  MOVGER.GER_IRFRET, ';
      strSQL := strSQL + '  MOVGER.GER_CSLRET, ';
      strSQL := strSQL + '  MOVGER.GER_VLSGSO, ';
    End
    Else
    Begin
      strSQL := strSQL + '  0.00 AS GER_PISRET, ';
      strSQL := strSQL + '  0.00 AS GER_COFRET, ';
      strSQL := strSQL + '  0.00 AS GER_IRFRET, ';
      strSQL := strSQL + '  0.00 AS GER_CSLRET, ';
      strSQL := strSQL + '  0.00 AS GER_VLSGSO, ';      
    End;

    If fCampoExiste('CADCLI', 'CLI_PRORUR') Then
      strSQL := strSQL + '  CLI_PRORUR AS GER_PRORUR, '
    Else
      strSQL := strSQL + '  "N"        AS GER_PRORUR, ';

    If fCampoExiste('CADCLI', 'CLI_BENREI') Then
      strSQL := strSQL + '  CLI_BENREI AS GER_BENREI, '
    Else
      strSQL := strSQL + '  "N"        AS GER_BENREI, ';

    If fCampoExiste('CADCLI', 'CLI_MICEMP') Then
      strSQL := strSQL + '  CLI_MICEMP AS GER_MICEMP, '
    Else
      strSQL := strSQL + '  "N"        AS GER_MICEMP, ';

    strSQL := strSQL + ' IF(CLI_NOMCLI LIKE "%CONSUMIDOR%", "S" ,';

    If fCampoExiste('CADCLI', 'CLI_IESUNI') Then
      strSQL := strSQL + '  CLI_IESUNI) AS GER_IESUNI, '
    Else
      strSQL := strSQL + '  "N"       ) AS GER_IESUNI, ';

    If fCampoExiste('CADCLI', 'CLI_REGTRI') Then
      strSQL := strSQL + '  CLI_REGTRI AS GER_REGTRI, '
    Else
      strSQL := strSQL + '  " "        AS GER_REGTRI, ';

    If fCampoExiste('CADCLI', 'CLI_STREES') Then
      strSQL := strSQL + '  CLI_STREES AS GER_STREES, '
    Else
      strSQL := strSQL + '  "N"        AS GER_STREES, ';

    If fCampoExiste('CADCLI', 'CLI_PRSTRE') Then
      strSQL := strSQL + '  CLI_PRSTRE AS GER_PRSTRE, '
    Else
      strSQL := strSQL + '  " "        AS GER_PRSTRE, ';

    If fCampoExiste('CADCLI', 'CLI_ORGPUB') Then
      strSQL := strSQL + '  CLI_ORGPUB AS GER_ORGPUB, '
    Else
      strSQL := strSQL + '  "N"        AS GER_ORGPUB, ';

    If fCampoExiste('CADCLI', 'CLI_ENTGOV') Then
      strSQL := strSQL + '  CLI_ENTGOV AS GER_ENTGOV, '
    Else
      strSQL := strSQL + '  CAST("" AS CHAR(1)) AS GER_ENTGOV, ';

    If fCampoExiste('CADCLI', 'CLI_TPOPEG') Then
      strSQL := strSQL + '  CLI_TPOPEG AS GER_TPOPEG, '
    Else
      strSQL := strSQL + '  CAST("" AS CHAR(1)) AS GER_TPOPEG, ';

    If fCampoExiste('CADCLI', 'CLI_MOTDES') Then
      strSQL := strSQL + '  CLI_MOTDES AS CLI_MOTDES, '
    Else
      strSQL := strSQL + '  "8"        AS CLI_MOTDES, ';

    If fCampoExiste('CADCLI', 'CLI_INDUST') Then
      strSQL := strSQL + '  CLI_INDUST AS GER_INDUST, '
    Else
      strSQL := strSQL + '  "N"        AS GER_INDUST, ';

    If fCampoExiste('CADCLI', 'CLI_ORPURD') Then
      strSQL := strSQL + '  CLI_ORPURD AS GER_ORPURD, '
    Else
      strSQL := strSQL + '  " "        AS GER_ORPURD, ';

    If fCampoExiste('CADCLI', 'CLI_CALICM') Then
      strSQL := strSQL + '  CLI_CALICM AS GER_CALICM, '
    Else
      strSQL := strSQL + '  "N"        AS GER_CALICM, ';

    If fCampoExiste('CADCLI', 'CLI_I_M_P_') Then
      strSQL := strSQL + '  CLI_I_M_P_ AS GER_IMPCON, '
    Else
      strSQL := strSQL + '  ""         AS GER_IMPCON, ';

    If fCampoExiste('CADCLI', 'CLI_SITP_C') Then
      strSQL := strSQL + '  CLI_SITP_C AS GER_SITP_C, '
    Else
      strSQL := strSQL + '  ""         AS GER_SITP_C, ';

    If fCampoExiste('CADCLI', 'CLI_MENP_C') Then
      strSQL := strSQL + '  CLI_MENP_C AS GER_MENP_C, '
    Else
      strSQL := strSQL + '  ""         AS GER_MENP_C, ';

    If fCampoExiste('CADCLI', 'CLI_SITIPI') Then
      strSQL := strSQL + '  CLI_SITIPI AS GER_SITIPI, '
    Else
      strSQL := strSQL + '  ""         AS GER_SITIPI, ';

    If fCampoExiste('CADCLI', 'CLI_ENQIPI') Then
      strSQL := strSQL + '  CLI_ENQIPI AS GER_ENQIPI, '
    Else
      strSQL := strSQL + '  ""         AS GER_ENQIPI, ';

    If fCampoExiste('CADCLI', 'CLI_MENIPI') Then
      strSQL := strSQL + '  CLI_MENIPI AS GER_MENIPI, '
    Else
      strSQL := strSQL + '  ""         AS GER_MENIPI, ';

    If fCampoExiste('CADCLI', 'CLI_NOTDES') Then
      strSQL := strSQL + '  CLI_NOTDES AS GER_NOTDES, '
    Else
      strSQL := strSQL + '  "N"        AS GER_NOTDES, ';

    If fCampoExiste('CADCLI', 'CLI_NATSER') Then
      strSQL := strSQL + '  CLI_NATSER AS GER_NATSER, '
    Else
      strSQL := strSQL + '  CAST("" AS CHAR(1)) AS GER_NATSER, ';

    If (fConfiguracao('TAGEST') = 'S') And (fCampoExiste('CADCLI', 'CLI_IDESTR')) Then
      strSQL := strSQL + '  CLI_IDESTR, '
    Else
      strSQL := strSQL + '  "00000" AS CLI_IDESTR, ';
  End
  Else
  Begin
    strSQL := strSQL + '  MOVGER.GER_CODFOR AS GER_CODCLI, ';
    strSQL := strSQL + '  "N"        AS GER_CONSUM, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS GER_NATSER, ';
    strSQL := strSQL + '  "00000" AS CLI_IDESTR, ';

    If fCampoExiste('CADFOR', 'FOR_MATREV') Then
      strSQL := strSQL + '  FOR_MATREV AS GER_MATREV, '
    Else
      strSQL := strSQL + '  " " AS GER_MATREV, ';

    If fCampoExiste('CADFOR', 'FOR_NOTDES') Then
      strSQL := strSQL + '  FOR_NOTDES AS GER_NOTDES, '
    Else
      strSQL := strSQL + '  "N"        AS GER_NOTDES, ';

    strSQL := strSQL + '  FOR_C_G_C_ AS GER_CGCCON, ';
    strSQL := strSQL + '  FOR_NOMFOR AS GER_NOMCON, ';
    strSQL := strSQL + '  FOR_NOMFAN AS GER_NOMFAN, ';
    strSQL := strSQL + '  FOR_ENDERE AS GER_ENDERE, ';
    strSQL := strSQL + '  FOR_ENDNUM AS GER_ENDNUM, ';
    strSQL := strSQL + '  FOR_ENDCOM AS GER_ENDCOM, ';
    strSQL := strSQL + '  FOR_BAIRRO AS GER_BAICON, ';
    strSQL := strSQL + '  FOR_CODCID AS GER_CIDCON, ';
    strSQL := strSQL + '  FOR_C_E_P_ AS GER_CEPCON, ';
    strSQL := strSQL + '  FOR_FONE01 AS GER_TELCON, ';
    strSQL := strSQL + '  FOR_I_E_S_ AS GER_IESCON, ';
    strSQL := strSQL + '  CF.CID_ESTADO AS GER_ESTCON, ';
    strSQL := strSQL + '  CF.CID_NOMCID AS GER_NOMCID, ';
    strSQL := strSQL + '  CF.CID_CODPAI AS GER_CODPAI, ';

    If fCampoExiste('CADFOR', 'FOR_EMAIL3') Then
    Begin
      strSQL := strSQL + '  FOR_EMAIL3 AS GER_EMAIL_, ';
    End
    Else
    Begin
      strSQL := strSQL + '  FOR_EMAIL_ AS GER_EMAIL_, ';
    End;

    If fCampoExiste('CADFOR', 'FOR_SUFRAM') Then
      strSQL := strSQL + '  FOR_SUFRAM AS GER_SUFRAM, '
    Else
      strSQL := strSQL + '  "" AS GER_SUFRAM, ';

    If fCampoExiste('CADFOR', 'FOR_EMAIL2') Then
    Begin
      strSQL := strSQL + '  FOR_EMAIL2 AS GER_EMAIL2, ';
    End
    Else
    Begin
      strSQL := strSQL + '  "" AS GER_EMAIL2, ';
    End;

    strSQL := strSQL + '  ""         AS GER_DIFERI, ';
    strSQL := strSQL + '  ""         AS GER_RETISS, ';
    strSQL := strSQL + '  ""         AS GER_NOTPAU, ';
    strSQL := strSQL + '  ""         AS GER_CLICON, ';
    strSQL := strSQL + '  ""         AS GER_ZONFRA, ';
    strSQL := strSQL + '  "000"      AS GER_CODATI, ';
    strSQL := strSQL + '  "N"        AS GER_BENCST, ';
    strSQL := strSQL + '  0          AS GER_REGFIS, ';
    strSQL := strSQL + '  "N"        AS GER_DESZON, ';
    strSQL := strSQL + '  "N"        AS GER_RETPCO, ';
    strSQL := strSQL + '  0.00       AS GER_PISRET, ';
    strSQL := strSQL + '  0.00       AS GER_COFRET, ';
    strSQL := strSQL + '  0.00       AS GER_IRFRET, ';
    strSQL := strSQL + '  0.00       AS GER_CSLRET, ';
    strSQL := strSQL + '  0.00       AS GER_VLSGSO, ';
    strSQL := strSQL + '  "N"        AS GER_PRORUR, ';
    strSQL := strSQL + '  "N"        AS GER_BENREI, ';
    strSQL := strSQL + '  "N"        AS GER_MICEMP, ';
    strSQL := strSQL + '  "N"        AS GER_IESUNI, ';

    If fCampoExiste('CADFOR', 'FOR_SIMPAU') Then
      strSQL := strSQL + '  FOR_SIMPAU AS GER_REGTRI, '
    Else
      strSQL := strSQL + '  " "        AS GER_REGTRI, ';

    strSQL := strSQL + '  "N"        AS GER_STREES, ';
    strSQL := strSQL + '  " "        AS GER_PRSTRE, ';
    strSQL := strSQL + '  "N"        AS GER_ORGPUB, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS GER_ENTGOV, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS GER_TPOPEG, ';
    strSQL := strSQL + '  "8"        AS CLI_MOTDES, ';
    strSQL := strSQL + '  "N"        AS GER_INDUST, ';
    strSQL := strSQL + '  " "        AS GER_ORPURD, ';
    strSQL := strSQL + '  "N"        AS GER_CALICM, ';
    strSQL := strSQL + '  ""         AS GER_IMPCON, ';
    strSQL := strSQL + '  ""         AS GER_SITP_C, ';
    strSQL := strSQL + '  ""         AS GER_MENP_C, ';
    strSQL := strSQL + '  ""         AS GER_SITIPI, ';
    strSQL := strSQL + '  ""         AS GER_ENQIPI, ';
    strSQL := strSQL + '  ""         AS GER_MENIPI, ';
  End;

  strSQL := strSQL + '  FIS_FORCLI, ';
  strSQL := strSQL + '  FIS_NUMDOC, ';
  strSQL := strSQL + '  FIS_ESPDOC, ';
  strSQL := strSQL + '  FIS_CODEMP, ';
  strSQL := strSQL + '  FIS_SERIE_, ';
  strSQL := strSQL + '  FIS_TIP_FC, ';
  strSQL := strSQL + '  FIS_DTAENT, ';
  strSQL := strSQL + '  FIS_DTADOC, ';

  If fCampoExiste('CADFIS', 'FIS_MESANO') Then
    strSQL := strSQL + '  FIS_MESANO, '
  Else
    strSQL := strSQL + '  "" AS FIS_MESANO, ';

  If fCampoExiste('CADFIS', 'FIS_ALQFCP') Then
    strSQL := strSQL + '  FIS_ALQFCP, '
  Else
    strSQL := strSQL + '  0.00 AS FIS_ALQFCP, ';

  If fCampoExiste('CADFIS', 'FIS_NFCIAP') Then
    strSQL := strSQL + '  FIS_NFCIAP, '
  Else
    strSQL := strSQL + '  "N" AS FIS_NFCIAP, ';

  If fCampoExiste('CADFIS', 'FIS_CSTPIS') Then
    strSQL := strSQL + '  FIS_CSTPIS, '
  Else
    strSQL := strSQL + '  "" AS FIS_CSTPIS, ';

  If fCampoExiste('CADFIS', 'FIS_CSTCOF') Then
    strSQL := strSQL + '  FIS_CSTCOF, '
  Else
    strSQL := strSQL + '  "" AS FIS_CSTCOF, ';

  If fCampoExiste('CADFIS', 'FIS_CSTIPI') Then
    strSQL := strSQL + '  FIS_CSTIPI, '
  Else
    strSQL := strSQL + '  "" AS FIS_CSTIPI, ';

  If fCampoExiste('CADFIS', 'FIS_ESTMOT') Then
    strSQL := strSQL + '  FIS_ESTMOT, '
  Else
    strSQL := strSQL + '  "" AS FIS_ESTMOT, ';

  For intAux := 1 To 5 Do
  Begin
    strSQL := strSQL + '  FIS_CLFSC' + intToStr(intAux) + ', ';
    strSQL := strSQL + '  FIS_VLCON' + intToStr(intAux) + ', ';
    strSQL := strSQL + '  FIS_BASIC' + intToStr(intAux) + ', ';
    strSQL := strSQL + '  FIS_ALQIC' + intToStr(intAux) + ', ';
    strSQL := strSQL + '  FIS_VLRIC' + intToStr(intAux) + ', ';
    strSQL := strSQL + '  FIS_BCRET' + intToStr(intAux) + ', ';
    strSQL := strSQL + '  FIS_RETID' + intToStr(intAux) + ', ';
    strSQL := strSQL + '  FIS_BASIP' + intToStr(intAux) + ', ';
    strSQL := strSQL + '  FIS_VLRIP' + intToStr(intAux) + ', ';

    If fCampoExiste('CADFIS', 'FIS_BFCPS' + intToStr(intAux)) And
       fCampoExiste('CADFIS', 'FIS_VFCPS' + intToStr(intAux)) Then
    Begin
      strSQL := strSQL + '  FIS_BFCPS' + intToStr(intAux) + ', ';
      strSQL := strSQL + '  FIS_VFCPS' + intToStr(intAux) + ', ';
    End
    Else
    Begin
      strSQL := strSQL + ' 0.00 AS FIS_BFCPS' + intToStr(intAux) + ', ';
      strSQL := strSQL + ' 0.00 AS FIS_VFCPS' + intToStr(intAux) + ', ';
    End;
  End;

  strSQL := strSQL + '  FIS_NOTESP, ';
  strSQL := strSQL + '  FIS_HISTOR, ';
  strSQL := strSQL + '  MOVGER.GER_NUMDOC, ';
  strSQL := strSQL + '  MOVGER.GER_CLAFIS, ';
  strSQL := strSQL + '  MOVGER.GER_CONPAG, ';
  strSQL := strSQL + '  MOVGER.GER_CODCND, ';
  strSQL := strSQL + '  MOVGER.GER_SERIE_, ';
  strSQL := strSQL + '  MOVGER.GER_DTAENT, ';
  strSQL := strSQL + '  MOVGER.GER_HORENT, ';
  strSQL := strSQL + '  MOVGER.GER_DTADOC, ';
  strSQL := strSQL + '  MOVGER.GER_BASICM, ';
  strSQL := strSQL + '  MOVGER.GER_TOTICM, ';

  If fCampoExiste('MOVGER', 'GER_CODFPG') Then
    strSQL := strSQL + '  MOVGER.GER_CODFPG, '
  Else
    strSQL := strSQL + '   "" AS GER_CODFPG, ';

  If blnBaERet Then
  Begin
    strSQL := strSQL + '  MOVGER.GER_BASRET + IFNULL((SELECT SUM(IFNULL(T.DET_BAERET, 0))                ';
    strSQL := strSQL + '                              FROM MOVDET D                                      ';
    strSQL := strSQL + '                              INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
    strSQL := strSQL + '                              WHERE D.DET_SEQGER = MOVGER.AUTOINCREM),0)         ';
    strSQL := strSQL + '                              AS GER_BASRET,                                     ';
  End
  Else
    strSQL := strSQL + '  MOVGER.GER_BASRET, ';

  If blnVaERet Then
  Begin
    strSQL := strSQL + '  MOVGER.GER_TOTRET + IFNULL((SELECT SUM(IFNULL(T.DET_VAERET, 0))                ';
    strSQL := strSQL + '                              FROM MOVDET D                                      ';
    strSQL := strSQL + '                              INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
    strSQL := strSQL + '                              WHERE D.DET_SEQGER = MOVGER.AUTOINCREM),0)         ';
    strSQL := strSQL + '  AS GER_TOTRET,                                                                 ';
  End  
  Else
    strSQL := strSQL + '  MOVGER.GER_TOTRET, ';

  strSQL := strSQL + '  MOVGER.GER_TOTPRO, ';
  strSQL := strSQL + '  MOVGER.GER_DESESP, ';

  If blnBaEIPI Then
  Begin
    strSQL := strSQL + '  MOVGER.GER_BASIPI + IFNULL((SELECT SUM(IFNULL(T.DET_BAEIPI, 0))                ';
    strSQL := strSQL + '                              FROM MOVDET D                                      ';
    strSQL := strSQL + '                              INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
    strSQL := strSQL + '                              WHERE D.DET_SEQGER = MOVGER.AUTOINCREM),0)         ';
    strSQL := strSQL + '                              AS GER_BASIPI,                                     ';
  End  
  Else
    strSQL := strSQL + '  MOVGER.GER_BASIPI, ';

  If blnVaEIPI Then
  Begin
    strSQL := strSQL + '  MOVGER.GER_TOTIPI + IFNULL((SELECT SUM(IFNULL(T.DET_VAEIPI, 0))                ';
    strSQL := strSQL + '                              FROM MOVDET D                                      ';
    strSQL := strSQL + '                              INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
    strSQL := strSQL + '                              WHERE D.DET_SEQGER = MOVGER.AUTOINCREM),0)         ';
    strSQL := strSQL + '                              AS GER_TOTIPI,                                     ';
  End
  Else
    strSQL := strSQL + '  MOVGER.GER_TOTIPI, ';

  strSQL := strSQL + '  MOVGER.GER_VALPIS, ';
  strSQL := strSQL + '  MOVGER.GER_VALCOF, ';
  strSQL := strSQL + '  MOVGER.GER_DESACE, ';
  strSQL := strSQL + '  MOVGER.GER_VLRCON, ';

  If blnReformaNoValorContabil Then
    strSQL := strSQL + '  IFNULL(AUXMOV.AUX_TOTCBS, 0) + IFNULL(AUXMOV.AUX_TOTIBS, 0) + IFNULL(AUXMOV.AUX_TOT_IS, 0) AS GER_VALREF, ';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_IMPPAG') Then
    strSQL := strSQL + '  AUX_IMPPAG AS GER_IMPPAG,'
  Else If fCampoExiste('MOVGER', 'GER_IMPPAG') Then
    strSQL := strSQL + '  MOVGER.GER_IMPPAG,'
  Else
    strSQL := strSQL + '  0.00 AS GER_IMPPAG,';

  If fTabelaExiste('AUXMOV') And
     fCampoExiste('AUXMOV', 'AUX_FEDIMP') And
     fCampoExiste('AUXNOT', 'AUX_FEDIMP') Then
    strSQL := strSQL + '  AUX_FEDIMP AS GER_FEDIMP,'
  Else
    strSQL := strSQL + '  0.00 AS GER_FEDIMP,';

  If fTabelaExiste('AUXMOV') And
     fCampoExiste('AUXMOV', 'AUX_ESTIMP') And
     fCampoExiste('AUXNOT', 'AUX_ESTIMP') Then
    strSQL := strSQL + '  AUX_ESTIMP AS GER_ESTIMP,'
  Else
    strSQL := strSQL + '  0.00 AS GER_ESTIMP,';

  If fTabelaExiste('AUXMOV') And
     fCampoExiste('AUXMOV', 'AUX_MUNIMP') And
     fCampoExiste('AUXNOT', 'AUX_MUNIMP') Then
    strSQL := strSQL + '  AUX_MUNIMP AS GER_MUNIMP,'
  Else
    strSQL := strSQL + '  0.00 AS GER_MUNIMP,';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_OPCDOC') Then
    strSQL := strSQL + '  AUX_OPCDOC AS GER_OPCDOC,'
  Else
  Begin
    strSQL := strSQL + '  IF(RIGHT(GER_CLAFIS, 3)="929", "CI", ' +
                       '     IF(LOCATE(GER_CLAFIS, "' + CFOP_DEVOLUCAO + '") > 0, ' +
                       '        IF(GER_TIP_FC="C", "DV", "OF"), " ")) AS GER_OPCDOC, ';
  End;


  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_CHVNFE') Then
    strSQL := strSQL + ' ' + strChvNfe + ', '
  Else
    strSQL := strSQL + '  "  " AS GER_CHVNFE,';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_NUMCOO') Then
    strSQL := strSQL + ' ' + strNumCOO + ', '
  Else
    strSQL := strSQL + '  "  " AS GER_NUMCOO,';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_NUMSER') Then
    strSQL := strSQL + ' ' + strNumSer + ', '
  Else
    strSQL := strSQL + '  "  " AS GER_NUMSER,';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_NUMUSU') Then
    strSQL := strSQL + ' ' + strNumUSU + ', '
  Else
    strSQL := strSQL + '  "  " AS GER_NUMUSU,';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_TIPDOC') Then
    strSQL := strSQL + ' ' + strTipDoc + ', '
  Else
    strSQL := strSQL + '  "  " AS GER_TIPDOC,';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_EST_DV') Then
    strSQL := strSQL + ' ' + strEst_Dv + ', '
  Else
    strSQL := strSQL + '  "  " AS GER_EST_DV,';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_CLIORI') Then
    strSQL := strSQL + '  AUX_CLIORI AS GER_CLIORI,'
  Else
    strSQL := strSQL + '  "        " AS GER_CLIORI,';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_NUMERO') Then
    strSQL := strSQL + ' ' + strNumero + ', '
  Else
    strSQL := strSQL + '  "  " AS GER_NUMERO,';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_SERIE_') Then
    strSQL := strSQL + ' ' + strSerie_ + ', '
  Else
    strSQL := strSQL + '  "  " AS GER_SERIE1,';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_MODELO') Then
    strSQL := strSQL + ' ' + strModelo + ', '
  Else
    strSQL := strSQL + '  "  " AS GER_MODELO,';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_CPFCNP') Then
    strSQL := strSQL + ' ' + strCPFCNP + ', '
  Else
    strSQL := strSQL + '  "  " AS GER_CPFCNP,';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_ESTADO') Then
    strSQL := strSQL + ' ' + strEstado + ', '
  Else
    strSQL := strSQL + '  "  " AS GER_ESTADO,';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_MESANO') Then
    strSQL := strSQL + ' ' + strMesAno + ', '
  Else
    strSQL := strSQL + '  "  " AS GER_MESANO,';

  strSQL := strSQL + ' ' + strComVal + ', ';

  strSQL := strSQL + '  NOTCOM.GER_DOCORI, ';
  strSQL := strSQL + '  NOTCOM.GER_SERORI, ';
  strSQL := strSQL + '  NOTCOM.GER_ACEORI, ';
  strSQL := strSQL + '  NOTCOM.GER_DESITE, ';
  strSQL := strSQL + '  NOTCOM.GER_MENC01, ';
  strSQL := strSQL + '  NOTCOM.GER_MENC02, ';
  strSQL := strSQL + '  NOTCOM.GER_MENC03, ';
  strSQL := strSQL + '  NOTCOM.GER_MENC04, ';
  strSQL := strSQL + '  NOTCOM.GER_MENC05, ';
  strSQL := strSQL + '  NOTCOM.GER_MENC06, ';
  strSQL := strSQL + '  NOTCOM.GER_MENC07, ';
  strSQL := strSQL + '  NOTCOM.GER_MENC08, ';
  strSQL := strSQL + '  NOTCOM.GER_MENC09, ';
  strSQL := strSQL + '  NOTCOM.GER_MENC10, ';
  If fCampoExiste('NOTCOM', 'GER_ESPORI') Then
  Begin
    strSQL := strSQL + '  NOTCOM.GER_ESPORI, ';
    strSQL := strSQL + '  NOTCOM.GER_EMPORI, ';
  End;
  If fCampoExiste('NOTCOM', 'GER_COMICM') Then
  Begin
    strSQL := strSQL + '  NOTCOM.GER_COMICM, ';
  End;
  If fCampoExiste('NOTCOM', 'GER_CREICM') Then
  Begin
    strSQL := strSQL + '  NOTCOM.GER_CREICM, ';
  End;
  If fCampoExiste('NOTCOM', 'GER_TRAICM') Then
  Begin
    strSQL := strSQL + '  NOTCOM.GER_TRAICM, ';
  End;
  If fCampoExiste('NOTCOM', 'GER_COMVAL') Then
  Begin
    strSQL := strSQL + '  NOTCOM.GER_COMVAL AS COMPLEMENTO_VALOR, ';
  End;
  If fCampoExiste('NOTCOM', 'GER_RESICM') Then
  Begin
    strSQL := strSQL + '  NOTCOM.GER_RESICM, ';
  End;
  If fCampoExiste('NOTCOM', 'GER_COMEST') Then
  Begin
    strSQL := strSQL + '  NOTCOM.GER_COMEST, ';
  End;

  If fCampoExiste('NOTCOM', 'GER_PERFCP') Then
  Begin
    strSQL := strSQL + '  NOTCOM.GER_PERFCP, ';
    strSQL := strSQL + '  NOTCOM.GER_VALFCP, ';

    If fCampoExiste('NOTCOM', 'GER_BASFCP') Then
      strSQL := strSQL + '  NOTCOM.GER_BASFCP, ';

    strSQL := strSQL + '  NOTCOM.GER_VENPRE AS COM_VENPRE, ';
  End;

  If fCampoExiste('NOTCOM', 'GER_COMDFL') Then
  Begin
    strSQL := strSQL + '  NOTCOM.GER_COMDFL, ';
  End
  Else
  Begin
    strSQL := strSQL + '  "N" AS GER_COMDFL, ';
  End;

  If fCampoExiste('NOTCOM', 'GER_COMCNC') Then
  Begin
    strSQL := strSQL + '  NOTCOM.GER_COMCNC, ';
  End
  Else
  Begin
    strSQL := strSQL + '  "N" AS GER_COMCNC, ';
  End;

  If fCampoExiste('NOTCOM', 'GER_COMTRS') Then
  Begin
    strSQL := strSQL + '  NOTCOM.GER_COMTRS, ';
  End
  Else
  Begin
    strSQL := strSQL + '  "N" AS GER_COMTRS, ';
  End;

  If fCampoExiste('NOTCOM', 'GER_AJUMAI') Then
  Begin
    strSQL := strSQL + '  NOTCOM.GER_AJUMAI, ';
  End
  Else
  Begin
    strSQL := strSQL + '  "N" AS GER_AJUMAI, ';
  End;

  If fCampoExiste('NOTCOM', 'GER_COMFRE') Then
  Begin
    strSQL := strSQL + '  NOTCOM.GER_COMFRE, ';
  End
  Else
  Begin
    strSQL := strSQL + '  "N" AS GER_COMFRE, ';
  End;

  If fCampoExiste('NOTCOM', 'GER_CODCST') Then
    strSQL := strSQL + '  NOTCOM.GER_CODCST, '
  Else
    strSQL := strSQL + '  "" AS GER_CODCST, ';

  If fCampoExiste('NOTCOM', 'GER_CLATRI') Then
    strSQL := strSQL + '  NOTCOM.GER_CLATRI, '
  Else
    strSQL := strSQL + '  "" AS GER_CLATRI, ';

  If fCampoExiste('NOTCOM', 'GER_MESANO') Then
    strSQL := strSQL + '  NOTCOM.GER_MESANO AS GER_MESANO_ , '
  Else
    strSQL := strSQL + '  "" AS GER_MESANO_, ';

  If fCampoExiste('NOTCOM', 'GER_BASCAL') Then
    strSQL := strSQL + '  NOTCOM.GER_BASCAL, '
  Else
    strSQL := strSQL + '  0.00 AS GER_BASCAL, ';

  If fCampoExiste('NOTCOM', 'GER_ALQCBS') Then
    strSQL := strSQL + '  NOTCOM.GER_ALQCBS, '
  Else
    strSQL := strSQL + '  0.00 AS GER_ALQCBS, ';

  If fCampoExiste('NOTCOM', 'GER_VALCBS') Then
    strSQL := strSQL + '  NOTCOM.GER_VALCBS, '
  Else
    strSQL := strSQL + '  0.00 AS GER_VALCBS, ';

  If fCampoExiste('NOTCOM', 'GER_ALQIBS') Then
    strSQL := strSQL + '  NOTCOM.GER_ALQIBS, '
  Else
    strSQL := strSQL + '  0.00 AS GER_ALQIBS, ';

  If fCampoExiste('NOTCOM', 'GER_VALIBS') Then
    strSQL := strSQL + '  NOTCOM.GER_VALIBS, '
  Else
    strSQL := strSQL + '  0.00 AS GER_VALIBS, ';

  strSQL := strSQL + '  FIS_NFCOMP, ';
  strSQL := strSQL + '  FIS_IMPMER, ';
  strSQL := strSQL + '  FIS_IMPSEG, ';
  strSQL := strSQL + '  FIS_IMPIMP, ';

  If fCampoExiste('CADFIS', 'FIS_CSTENT') Then
    strSQL := strSQL + '  FIS_CSTENT, ';

  If fCampoExiste('CADFIS', 'FIS_BASEII') Then
  Begin
    strSQL := strSQL + '  FIS_BASEII, ';
    strSQL := strSQL + '  FIS_DESADU, ';
    strSQL := strSQL + '  FIS_VALIOF, ';
  End
  Else
  Begin
    strSQL := strSQL + '  0.00 AS FIS_BASEII, ';
    strSQL := strSQL + '  0.00 AS FIS_DESADU, ';
    strSQL := strSQL + '  0.00 AS FIS_VALIOF, ';
  End;

  If fCampoExiste('CADFIS', 'FIS_VAFRMM') Then
    strSQL := strSQL + '  FIS_VAFRMM, '
  Else
    strSQL := strSQL + '  0.00 AS FIS_VAFRMM, ';

  If fCampoExiste('DOCIMP', 'IMP_VLRADP') Then
    strSQL := strSQL + '  (SELECT IFNULL(SUM(IMP_VLRADP),0) FROM DOCIMP ' +
              '   WHERE IMP_SQMVDT = MOVDET.AUTOINCREM) AS FIS_VALADP, '
  Else
    strSQL := strSQL + '  0.00 AS FIS_VALADP, ';

  strSQL := strSQL + '  FIS_IMPPRO, ';
  strSQL := strSQL + '  FIS_IMPTAX, ';
  strSQL := strSQL + '  FIS_IMPPIS, ';
  strSQL := strSQL + '  FIS_IMPCOF, ';
  strSQL := strSQL + '  FIS_IMPIC1, ';
  strSQL := strSQL + '  FIS_IMPIC2, ';
  strSQL := strSQL + '  FIS_TOTPIS, ';
  strSQL := strSQL + '  FIS_TOTCOF, ';

  If fCampoExiste('NOTCOM', 'GER_TIPFRE') Then
    strSQL := strSQL + '  IFNULL(MOVGER.GER_TIPFRE, NOTCOM.GER_TIPFRE) AS GER_TIPFRE, '
  Else
    strSQL := strSQL + '  MOVGER.GER_TIPFRE, ';

  If fCampoExiste('NOTCOM', 'GER_TOTFRE') Then
    strSQL := strSQL + '  IFNULL(MOVGER.GER_TOTFRE, NOTCOM.GER_TOTFRE) AS GER_TOTFRE, '
  Else
    strSQL := strSQL + '  MOVGER.GER_TOTFRE, ';

  If fCampoExiste('NOTCOM', 'GER_PERICM') Then
    strSQL := strSQL + '  IFNULL(GER_PERICM, 0) AS GER_PERICM, '
  Else
    strSQL := strSQL + '  0.00 AS GER_PERICM, ';

  If fCampoExiste('NOTCOM', 'GER_ICMSOP') Then
    strSQL := strSQL + '  IFNULL(GER_ICMSOP, 0) AS GER_ICMSOP, '
  Else
    strSQL := strSQL + '  0.00 AS GER_ICMSOP, ';

  If fCampoExiste('NOTCOM', 'GER_PERDIF') Then
    strSQL := strSQL + '  IFNULL(GER_PERDIF, 0) AS GER_PERDIF, '
  Else
    strSQL := strSQL + '  0.00 AS GER_PERDIF, ';

  If fCampoExiste('NOTCOM', 'GER_ICMDIF') Then
    strSQL := strSQL + '  IFNULL(GER_ICMDIF, 0) AS GER_ICMDIF, '
  Else
    strSQL := strSQL + '  0.00 AS GER_ICMDIF, ';

  If fCampoExiste('NOTCOM', 'GER_VALICM') Then
    strSQL := strSQL + '  IFNULL(GER_VALICM, 0) AS GER_VALICM, '
  Else
    strSQL := strSQL + '  0.00 AS GER_VALICM, ';

  strSQL := strSQL + '  CADTRA.TRA_C_G_C_, ';
  strSQL := strSQL + '  CADTRA.TRA_NOMTRA, ';
  strSQL := strSQL + '  CADTRA.TRA_I_E_S_, ';
  strSQL := strSQL + '  CADTRA.TRA_ENDERE, ';

  If fCampoExiste('AUXMOV', 'AUX_PLAFAT') Then
    strSQL := strSQL + ' AUX_PLAFAT AS TRA_NUMPLA, '
  Else
    strSQL := strSQL + '  CADTRA.TRA_NUMPLA, ';

  strSQL := strSQL + '  CADTRA.TRA_EMAIL_, ';

  strSQL := strSQL + strSelectTraRed;

  If fCampoExiste('CADTRA', 'TRA_C_ANTT') Then
    strSQL := strSQL + '  CADTRA.TRA_C_ANTT, '
  Else
    strSQL := strSQL + ' "" AS TRA_C_ANTT, ';

  strSQL := strSQL + '  CIDTRA.CID_NOMCID AS TRA_NOMCID, ';
  strSQL := strSQL + '  CIDTRA.CID_ESTADO AS TRA_ESTADO, ';
  strSQL := strSQL + '  IFNULL(MOVGER.GER_VOLUME, 0) AS GER_VOLUME, ';
  strSQL := strSQL + '  MOVGER.GER_ESPECI, ';
  strSQL := strSQL + '  MOVGER.GER_MARCA_, ';
  strSQL := strSQL + '  MOVGER.GER_PESLIQ, ';
  strSQL := strSQL + '  MOVGER.GER_PESBRU, ';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_NUMERA') Then
    strSQL := strSQL + '  AUX_NUMERA, '
  Else
    strSQL := strSQL + ' "" AS AUX_NUMERA, ';

  strSQL := strSQL + '  IFNULL(MOVGER.GER_FATNOT, 0) AS GER_FATNOT, ';

  strSQL := strSQL + '  MOVGER.GER_VPAR01, ';
  strSQL := strSQL + '  MOVGER.GER_VPAR02, ';
  strSQL := strSQL + '  MOVGER.GER_VPAR03, ';
  strSQL := strSQL + '  MOVGER.GER_VPAR04, ';
  strSQL := strSQL + '  MOVGER.GER_VPAR05, ';
  strSQL := strSQL + '  MOVGER.GER_VPAR06, ';
  strSQL := strSQL + '  MOVGER.GER_VPAR07, ';
  strSQL := strSQL + '  MOVGER.GER_VPAR08, ';
  strSQL := strSQL + '  MOVGER.GER_VPAR09, ';
  strSQL := strSQL + '  MOVGER.GER_VPAR10, ';
  strSQL := strSQL + '  MOVGER.GER_VPAR11, ';
  strSQL := strSQL + '  MOVGER.GER_VPAR12, ';

  strSQL := strSQL + '  DET_CODITE, ';

  if fCampoExiste('MOVDET', 'DET_CODACA') then
  begin
    strSQL := strSQL + '  DET_CODACA, ';
    strSQL := strSQL + '  DET_EMPACA, ';
  end
  else
  begin
    strSQL := strSQL + '  "" AS DET_CODACA, ';
    strSQL := strSQL + '  "" AS DET_EMPACA, ';
  end;

  if fCampoExiste('MOVDET', 'DET_PROMOC') then
    strSQL := strSQL + '  DET_PROMOC, '
  else
    strSQL := strSQL + '  CAST("N" AS CHAR(1)) AS DET_PROMOC, ';

  If fCampoExiste('CADACA', 'ACA_UNITIN') and fCampoExiste('MOVDET', 'DET_CODACA') Then
    strSQL := strSQL + '  ACA_UNITIN, '
  Else
    strSQL := strSQL + '  0 AS ACA_UNITIN, ';

  strSQL := strSQL + '  CLI_COD_NF, ';

  If fTabelaExiste('CLIPRO') And fCampoExiste('CLIPRO', 'CLI_DES_NF') Then
    strSQL := strSQL + '  CLI_DES_NF, '
  Else
    strSQL := strSQL + '  "" AS CLI_DES_NF, ';

  If fTabelaExiste('CLIPRO') And fCampoExiste('CLIPRO', 'CLI_CODUNI') Then
    strSQL := strSQL + '  UNCLI.UNI_SIGUNI AS CLI_SIGUNI, '
  Else
    strSQL := strSQL + '  "" AS CLI_SIGUNI, ';

  {********************************************}
  {* SE NF FOR DE GARANTIA, ENTÃO DEVE SAIR   *}
  {* O CÓD. FAB. CADASTRADO NA TABELA MOVGAD  *}
  {* SE NÃO PEGA DO CADITE                    *}
  {*****************************************MM*}
  If fCampoExiste('MOVGAD', 'GAD_CODFAB') Then
  Begin
    strSQL := strSQL + '  IF(LOCATE(MOVGER.GER_CLAFIS,' + QuotedStr(fClaFisGarantia) + ') > 0, ';
    strSQL := strSQL + '      IFNULL((SELECT GAD_CODFAB FROM MOVGAD WHERE AUTOINCREM = MOVTRI.DET_SEQGAD), CADITE.ITE_CODFAB), ';
    strSQL := strSQL + '       CADITE.ITE_CODFAB ';
    strSQL := strSQL + '    ) AS ITE_CODFAB, ';
  End
  Else
  Begin
    strSQL := strSQL + '  CADITE.ITE_CODFAB, ';
  End;

  If fCampoExiste('CADITE', 'ITE_INDREV') Then
  Begin
    If (fConfiguracao('INDREV') = '2') And fCampoExiste('ITEGER', 'ITE_INDREV') Then
      strSQL := strSQL + '  ITEGER.ITE_INDREV AS ITE_INDREV, '
    Else
      strSQL := strSQL + '  CADITE.ITE_INDREV AS ITE_INDREV, '
  End
  Else
    strSQL := strSQL + '  " " AS ITE_INDREV, ';

  strSQL := strSQL + '  CADITE.ITE_DESFAB, ';
  strSQL := strSQL + '  CADITE.ITE_CODBAR, ';

  If fCampoExiste('CADITE', 'ITE_APLICA') Then
    strSQL := strSQL + '  CADITE.ITE_APLICA, '
  Else
    strSQL := strSQL + '  "" AS ITE_APLICA, ';

  If fCampoExiste('CADITE', 'ITE_DESITE') Then
    strSQL := strSQL + '  CADITE.ITE_DESITE, '
  Else
    strSQL := strSQL + '  "" AS ITE_DESITE, ';

  strSQL := strSQL + '  DET_DESCRI, ';

  //Versao 27.16.470 - CFG_NCMTIN
  If fEmiteNCMPorLinhaDeTinta Then
  Begin
    strSQL := strSQL + '  IF(DET_IDEPRO = "NOR", IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI), IF(IFNULL(MOVTRI.TRI_NCMTIN,"") <> "", MOVTRI.TRI_NCMTIN, IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI))) AS ITE_CLAIPI, ';
  End
  //Versoes superiores a 27.16.470 - CFG_NCMTIN nao existe mais
  Else
  Begin
    if fCampoExiste('MOVDET', 'DET_ITEEMB') then
    begin
      If fCampoExiste('MOVTRI', 'TRI_NCMTIN') Then
        strSQL := strSQL + '  IF(DET_IDEPRO = "NOR", IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI), IF(IFNULL(MOVTRI.TRI_NCMTIN, "") <> "", MOVTRI.TRI_NCMTIN, IFNULL(ITEEMB.ITE_CLAIPI, IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI)))) AS ITE_CLAIPI, '
      Else
        strSQL := strSQL + '  IF(DET_IDEPRO = "NOR", IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI), IFNULL(ITEEMB.ITE_CLAIPI, IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI))) AS ITE_CLAIPI, ';
    end
    else
      strSQL := strSQL + '  IFNULL(ITEABF.ITE_CLAIPI, CADITE.ITE_CLAIPI) AS ITE_CLAIPI, ';
  End;

  If (fOutrasSaidasConEqu()) Then
    strSQL := strSQL + ' MOVTRI.DET_NCMITE AS DET_NCMITE, '
  Else
    strSQL := strSQL + ' "" AS DET_NCMITE, ';

  If fCampoExiste('CADITE', 'ITE_EXCIPI') Then
    strSQL := strSQL + '  CADITE.ITE_EXCIPI AS ITE_EXCIPI, '
  Else
    strSQL := strSQL + '  " " AS ITE_EXCIPI, ';

  strSQL := strSQL + '  DET_CLAFIS, ';
  strSQL := strSQL + '  UV.UNI_SIGUNI AS ITE_SIGUNV, ';

  If fCampoExiste('CADUNI', 'UNI_PESLIT') Then
    strSQL := strSQL + '  UV.UNI_PESLIT AS UNI_PESLTV, '
  Else
    strSQL := strSQL + '  0.000 AS UNI_PESLTV, ';

  If (fConfiguracao('UNITRI') <> 'S') Then
  Begin
    strSQL := strSQL + '  UV.UNI_SIGUNI AS ITE_SIGUNT, ';
    strSQL := strSQL + '  1.000000 AS ITE_FATUTR, ';
  End
  Else
  Begin
    strSQL := strSQL + '  IFNULL(UT.UNI_SIGUNI, UV.UNI_SIGUNI) AS ITE_SIGUNT, ';
    strSQL := strSQL + '  IFNULL(CADITE.ITE_FATUTR, 1) AS ITE_FATUTR, ';
  End;

  strSQL := strSQL + '  DET_QTDITE, ';
  strSQL := strSQL + '  DET_UNITAR, ';
  strSQL := strSQL + '  DET_TOTITE, ';
  strSQL := strSQL + '  DET_VLRCON, ';
  strSQL := strSQL + '  DET_DESESP, ';
  strSQL := strSQL + '  DET_CODFIS, ';
  strSQL := strSQL + '  DET_NUMLOT, ';
  strSQL := strSQL + '  DET_UNIORI, ';

  If fCampoExiste('CADLOT', 'LOT_DTAFAB') Then
    strSQL := strSQL + '  LOT_DTAFAB, '
  Else
    strSQL := strSQL + ' " " AS LOT_DTAFAB, ';

  If fCampoExiste('CADLOT', 'LOT_DTAVAL') Then
    strSQL := strSQL + '  LOT_DTAVAL, '
  Else
    strSQL := strSQL + ' " " AS LOT_DTAVAL, ';

  If fTabelaExiste('CADLOT') Then
    strSQL := strSQL + '   IF(IFNULL(DET_NUMLOT, "") = "", ITE_LOCFIS, LOT_LOCFIS) AS DET_LOCFIS, '
  Else
    strSQL := strSQL + '   ITE_LOCFIS AS DET_LOCFIS, ';

  If fCampoExiste('CADLOT', 'LOT_LOCSEP') And fCampoExiste('ITEGER', 'ITE_CODLSE') Then
    strSQL := strSQL + '   IFNULL(NULLIF(LOT_LOCSEP, ""), ITE_CODLSE) AS DET_CODLSE, '
  Else If fCampoExiste('ITEGER', 'ITE_CODLSE') Then
    strSQL := strSQL + '   ITE_CODLSE AS DET_CODLSE, '
  Else
    strSQL := strSQL + '   " " AS DET_CODLSE, ';

  strSQL := strSQL + '  DET_DESNES, ';
  strSQL := strSQL + '  DET_CODMAR, ';
  strSQL := strSQL + '  MAR_DESMAR, ';
  strSQL := strSQL + '  CADITE.ITE_MENFIS, ';

  If fCampoExiste('CADITE', 'ITE_PROPCD') Then
    strSQL := strSQL + '  CADITE.ITE_PROPCD, '
  Else
    strSQL := strSQL + '  " " AS ITE_PROPCD, ';

  strSQL := strSQL + '  DET_BASICM, ';
  strSQL := strSQL + '  DET_ALQICM, ';
  strSQL := strSQL + '  DET_VALICM, ';

  if blnBaERet Then
    strSQL := strSQL + '  DET_BASRET + IFNULL(DET_BAERET,0) AS DET_BASRET, '
  Else
    strSQL := strSQL + '  DET_BASRET, ';

  strSQL := strSQL + '  DET_ALQRET, ';

  If blnVaERet Then
    strSQL := strSQL + '  DET_VALRET + IFNULL(DET_VAERET,0) AS DET_VALRET, '
  Else
    strSQL := strSQL + '  DET_VALRET, ';

  strSQL := strSQL + '  DET_PERRED, ';

  If fCampoExiste('MOVTRI', 'DET_VALIVA') Then
    strSQL := strSQL + '  DET_VALIVA, '
  Else
    strSQL := strSQL + '  0.00 DET_VALIVA, ';


  If fCampoExiste('MOVTRI', 'DET_PEBAST') Then
    strSQL := strSQL + '  DET_PEBAST, '
  Else
    strSQL := strSQL + '  DET_PERBAS AS DET_PEBAST, ';

  If fCampoExiste('MOVDET', 'DET_PERBAS') Then
    strSQL := strSQL + '  DET_PERBAS, ';

  If blnVaEIPI Then
    strSQL := strSQL + '  DET_VALIPI + IFNULL(MOVTRI.DET_VAEIPI,0) AS DET_VALIPI, '
  Else
    strSQL := strSQL + '  DET_VALIPI, ';

  strSQL := strSQL + '  DET_BASIPI, ';
  strSQL := strSQL + '  DET_ALQIPI, ';
  strSQL := strSQL + '  DET_TOTFRE, ';
  strSQL := strSQL + '  DET_DESACE, ';

  If fConfiguracao('TIPABF') = '1' Then
    strSQL := strSQL + '  CADITE.ITE_CODABF, '
  else
    strSQL := strSQL + '  ITEGER.ITE_CODABF, ';

  If strTabAbf = 'ABFICM' Then
  Begin
    If fCampoExiste('ABFICM', 'ABF_ALQRET_ENT_PEJ') Then
    begin
      strSQL := strSQL + '  ABF_ALQRET_ENT_PEJ, ';
    end
    Else
    Begin
      strSQL := strSQL + '  0 AS ABF_ALQRET_ENT_PEJ, ';
    End;

    If fCampoExiste('ABFICM', 'ABF_RICMPR_SAI_CNC') Then
    Begin
      strSQL := strSQL + '  ABF_RICMPR_SAI_CNC, ';
    End
    Else
    Begin
      strSQL := strSQL + '  "N" AS ABF_RICMPR_SAI_CNC, ';
    End;

    If fCampoExiste('ABFICM', 'ABF_CODBEN_ENT_PEF') Then
    begin
      strSQL := strSQL + '  ABF_CODBEN_ENT_PEF, ';
      strSQL := strSQL + '  ABF_CODBEN_ENT_PEJ, ';
      strSQL := strSQL + '  ABF_CODBEN_ENT_PER, ';
      strSQL := strSQL + '  ABF_CODBEN_SAI_NCO, ';
      strSQL := strSQL + '  ABF_CODBEN_SAI_CCO, ';
      strSQL := strSQL + '  ABF_CODBEN_SAI_CNC, ';
      strSQL := strSQL + '  ABF_CODBEN_SAI_SNA, ';
      strSQL := strSQL + '  ABF_CODBEN_SAI_CTA, ';
      strSQL := strSQL + '  ABF_CODBEN_SAI_PRU, ';
      strSQL := strSQL + '  ABF_CODBEN_SAI_IND, ';
      strSQL := strSQL + '  ABF_CODBEN_SAI_TRS, ';
    end
    else
    begin
      strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_ENT_PEF, ';
      strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_ENT_PEJ, ';
      strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_ENT_PER, ';
      strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_SAI_NCO, ';
      strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_SAI_CCO, ';
      strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_SAI_CNC, ';
      strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_SAI_SNA, ';
      strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_SAI_CTA, ';
      strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_SAI_PRU, ';
      strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_SAI_IND, ';
      strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_SAI_TRS, ';
    end;

    If fCampoExiste('ABFICM', 'ABF_IMPMSG') Then
    Begin
      strSQL := strSQL + '  ABF_IMPMSG, ';
    End
    Else
    Begin
      strSQL := strSQL + '  0 AS ABF_IMPMSG, ';
    End;

    If fCampoExiste('ABFICM', 'AUTOINCREM') Then
    Begin
      strSQL := strSQL + '  ABFICM.AUTOINCREM AS ABF_AUTOIN, ';
    End
    Else
    Begin
      strSQL := strSQL + '  " " AS ABF_AUTOIN, ';
    End;


    If FTip_FC = 'C' Then
    Begin
      strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('NCO'); //RETORNA MENSAGENS NÃO CONTRIBUINTE
      strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('CCO'); //RETORNA MENSAGENS CONTRIBUINTE CONSUMIDOR
      strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('CNC'); //RETORNA MENSAGENS CONTRIBUINTE NÃO CONSUMIDOR
      strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('CTA'); //RETORNA MENSAGENS CONSTRUTORA
      strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('PRU'); //RETORNA MENSAGENS PRODUTOR RURAL
      strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('SNA'); //RETORNA MENSAGENS SIMPLES NACIONAL
      strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('IND'); //RETORNA MENSAGENS INDUSTRIA
      strSQL := strSQL + fRetSQLMsg1e2TipAbfdeSAI('TRS'); //RETORNA MENSAGENS CLIENTE FILIAL
    End;
  End
  Else
  Begin
    strSQL := strSQL + '  "N" AS ABF_RICMPR_SAI_CNC, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_ENT_PEF, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_ENT_PEJ, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_ENT_PER, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_SAI_NCO, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_SAI_CCO, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_SAI_CNC, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_SAI_SNA, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_SAI_CTA, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_SAI_PRU, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_SAI_IND, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ABF_CODBEN_SAI_TRS, ';
    strSQL := strSQL + ' 0 AS ABF_IMPMSG, ';
    strSQL := strSQL + ' " " AS ABF_AUTOIN, ';
    strSQL := strSQL + '  ABF_MENSAG AS ABF_MENS01, ';
    strSQL := strSQL + '  ABF_MENSA2 AS ABF_MENS02, ';

    For intAux:=3 To 6 Do
    Begin
      If fCampoExiste('CADABF', 'ABF_MENSA'+IntToStr(intAux)) Then
        strSQL := strSQL + '  ABF_MENSA'+IntToStr(intAux)+' AS '+'ABF_MENS'+untUtil.fStrZero(IntToStr(intAux),2) + ', '
      Else
        strSQL := strSQL + '  "" AS '+'ABF_MENS'+untUtil.fStrZero(IntToStr(intAux),2) + ', '
    End;
  End;

  strSQL := strSQL + '  FIS_ACESSO, ';
  strSQL := strSQL + '  IF(LOCATE(MOVGER.GER_CLAFIS, ' + QuotedStr(objConfig.strClaDev) + '), MOVDET.DET_CODVEN, MOVGER.GER_CODVEN) AS GER_CODVEN, ';
  strSQL := strSQL + '  IFNULL(MOVGER.GER_CODDIG, "") AS GER_CODDIG, ';

  If objConfig.blnAutCen Then
  Begin
    strSQL := strSQL + ' (SELECT ';
    strSQL := strSQL + '    GROUP_CONCAT(DISTINCT  " ", CONCAT(DET_CODVEN, "-", OPE_NOMOPE)) AS NOME ';
    strSQL := strSQL + '  FROM ';
    strSQL := strSQL + '    MOVDET D INNER JOIN CADOPE O ON D.DET_CODVEN = O.OPE_CODOPE ';
    strSQL := strSQL + '  WHERE ';
    strSQL := strSQL + '    D.DET_SEQGER = MOVGER.AUTOINCREM) AS OPE_NOMOPE, ';

    If fCampoExiste('CADOPE', 'OPE_NUMCPF') Then
    Begin
      strSQL := strSQL + ' (SELECT ';
      strSQL := strSQL + '   GROUP_CONCAT(DISTINCT " ",  O.OPE_NUMCPF) AS OPE_NUMCPF ';
      strSQL := strSQL + '  FROM ';
      strSQL := strSQL + '    MOVDET D INNER JOIN CADOPE O ON D.DET_CODVEN = O.OPE_CODOPE ';
      strSQL := strSQL + '  WHERE ';
      strSQL := strSQL + '    D.DET_SEQGER = MOVGER.AUTOINCREM) AS OPE_NUMCPF, ';
    End;
  End
  Else
  Begin
    strSQL := strSQL + '  IF(LOCATE(MOVGER.GER_CLAFIS, ' + QuotedStr(objConfig.strClaDev) + '), ';
    strSQL := strSQL + '           (SELECT O.OPE_NOMOPE FROM CADOPE O WHERE MOVDET.DET_CODVEN = O.OPE_CODOPE), VE.OPE_NOMOPE) AS OPE_NOMOPE, ';

    If fCampoExiste('CADOPE', 'OPE_NUMCPF') Then
      strSQL := strSQL + '  VE.OPE_NUMCPF, ';
  End;

  If objConfig.blnAutCen Then
  Begin
    strSQL := strSQL + ' (SELECT ';
    strSQL := strSQL + '    GROUP_CONCAT(DISTINCT  " ", CONCAT(DET_CODDIG, "-", OPE_NOMOPE)) AS NOME ';
    strSQL := strSQL + '  FROM ';
    strSQL := strSQL + '    MOVDET D INNER JOIN CADOPE O ON D.DET_CODDIG = O.OPE_CODOPE ';
    strSQL := strSQL + '  WHERE ';
    strSQL := strSQL + '    D.DET_SEQGER = MOVGER.AUTOINCREM) AS OPE_NOMDIG, ';
  End
  Else
    strSQL := strSQL + '  DI.OPE_NOMOPE AS OPE_NOMDIG, ';

  strSQL := strSQL + '  MOVGER.GER_MEN001, ';
  strSQL := strSQL + '  MOVGER.GER_MEN002, ';
  strSQL := strSQL + '  MOVGER.GER_MEN003, ';
  strSQL := strSQL + '  MOVGER.GER_MEN004, ';
  strSQL := strSQL + '  MOVGER.GER_MEN005, ';

  If fCampoExiste('NATCFO', 'NAT_DESCRI') Then
    strSQL := strSQL + '  IF(TRIM(IFNULL(MOVGER.GER_NATOPE,""))<>"", MOVGER.GER_NATOPE, (SELECT NAT_DESCRI FROM NATCFO WHERE NAT_CODCFO = GER_CLAFIS LIMIT 1)) AS CFO_NATOPE_01, '
  Else If fCampoExiste('MOVGER', 'GER_NATOPE') Then
    strSQL := strSQL + '  IF(TRIM(IFNULL(MOVGER.GER_NATOPE,""))<>"", MOVGER.GER_NATOPE, C1.CFO_NATOPE) AS CFO_NATOPE_01, '
  Else
    strSQL := strSQL + '  C1.CFO_NATOPE AS CFO_NATOPE_01, ';

  If fCampoExiste('NATCFO', 'NAT_ATIVO_') And fCampoExiste('NATCFO', 'NAT_SUGEST') Then
  Begin
    strSQL := strSQL + '  (SELECT NAT_DESCRI FROM NATCFO WHERE NAT_ATIVO_ = "S" AND NAT_CODCFO = GER_CLAFI2 ORDER BY NAT_SUGEST DESC LIMIT 1) AS CFO_NATOPE_02, ';
    strSQL := strSQL + '  (SELECT NAT_DESCRI FROM NATCFO WHERE NAT_ATIVO_ = "S" AND NAT_CODCFO = GER_CLAFI3 ORDER BY NAT_SUGEST DESC LIMIT 1) AS CFO_NATOPE_03, ';
    strSQL := strSQL + '  (SELECT NAT_DESCRI FROM NATCFO WHERE NAT_ATIVO_ = "S" AND NAT_CODCFO = GER_CLAFI4 ORDER BY NAT_SUGEST DESC LIMIT 1) AS CFO_NATOPE_04, ';
  End
  Else If fCampoExiste('NATCFO', 'NAT_DESCRI') Then
  Begin
    strSQL := strSQL + '  (SELECT NAT_DESCRI FROM NATCFO WHERE NAT_CODCFO = GER_CLAFI2 LIMIT 1) AS CFO_NATOPE_02, ';
    strSQL := strSQL + '  (SELECT NAT_DESCRI FROM NATCFO WHERE NAT_CODCFO = GER_CLAFI3 LIMIT 1) AS CFO_NATOPE_03, ';
    strSQL := strSQL + '  (SELECT NAT_DESCRI FROM NATCFO WHERE NAT_CODCFO = GER_CLAFI4 LIMIT 1) AS CFO_NATOPE_04, ';
  End
  Else
  Begin
    strSQL := strSQL + '  C2.CFO_NATOPE AS CFO_NATOPE_02, ';
    strSQL := strSQL + '  C3.CFO_NATOPE AS CFO_NATOPE_03, ';
    strSQL := strSQL + '  C4.CFO_NATOPE AS CFO_NATOPE_04, ';
  End;

  strSQL := strSQL + '  MOVGER.GER_TOTSER, ';

  If fCampoExiste('AUXNOT', 'AUX_TOTSDS') Then
    strSQL := strSQL + ' ' + strTotSDs + ', '
  Else
    strSQL := strSQL + ' 0.00 AS AUX_TOTSDS, ';

  If fCampoExiste('CADFIS', 'FIS_BASISS') Then
    strSQL := strSQL + '  CADFIS.FIS_BASISS AS GER_BASISS, ';

  strSQL := strSQL + '  MOVGER.GER_PERISS, ';
  strSQL := strSQL + '  MOVGER.GER_VALISS, ';
  strSQL := strSQL + '  MOVOBS.MOV_OBSERV, ';

  If fCampoExiste('MOVOBS', 'MOV_STAOFF') Then
    strSQL := strSQL + '  MOVOBS.MOV_STAOFF, '
  Else
    strSQL := strSQL + ' " " AS MOV_STAOFF, ';

  If fCampoExiste('MOVOBS', 'MOV_DTEOFF') Then
    strSQL := strSQL + '  MOVOBS.MOV_DTEOFF, '
  Else
    strSQL := strSQL + ' NULL AS MOV_DTEOFF, ';

  If fCampoExiste('MOVOBS', 'MOV_XMLOFF') Then
    strSQL := strSQL + '  MOVOBS.MOV_XMLOFF, '
  Else
    strSQL := strSQL + ' " " AS MOV_XMLOFF, ';

  If fCampoExiste('MOVOBS', 'MOV_OBSFIS') Then
    strSQL := strSQL + '  MOVOBS.MOV_OBSFIS, '
  Else
    strSQL := strSQL + ' " " AS MOV_OBSFIS, ';

  strSQL := strSQL + '  MOVOBS.MOV_IPDPNF, ';
  strSQL := strSQL + '  MOVOBS.MOV_IPDPCI, ';
  strSQL := strSQL + '  MOVOBS.MOV_DTESNF, ';
  strSQL := strSQL + '  MOVOBS.MOV_HRESNF, ';

  If fCampoExiste('MOVOBS', 'MOV_CNFNFE') Then
    strSQL := strSQL + '  MOVOBS.MOV_CNFNFE, '
  Else
    strSQL := strSQL + ' " " AS MOV_CNFNFE, ';

  If fCampoExiste('MOVOBS', 'MOV_XCAMPO') Then
    strSQL := strSQL + '  MOVOBS.MOV_XCAMPO, '
  Else
    strSQL := strSQL + ' " " AS MOV_XCAMPO, ';

  If fCampoExiste('MOVOBS', 'MOV_XTEXTO') Then
    strSQL := strSQL + '  MOVOBS.MOV_XTEXTO, '
  Else
    strSQL := strSQL + ' " " AS MOV_XTEXTO, ';

  If fCampoExiste('MOVOBS', 'MOV_CNFFIS') Then
    strSQL := strSQL + '  MOVOBS.MOV_CNFFIS, '
  Else
    strSQL := strSQL + ' " " AS MOV_CNFFIS, ';

  If fCampoExiste('MOVDET', 'DET_INCPIS') Then
    strSQL := strSQL + '  DET_INCPIS AS ITE_INCPIS, '
  Else
    strSQL := strSQL + '  CADITE.ITE_INCPIS, ';

  strSQL := strSQL + '  REPEAT(" ", 20) AS DET_AUTINC, ';

  strSQL := strSQL + '  MOVTRI.DET_BARTSP, ';
  strSQL := strSQL + '  MOVTRI.DET_VLRTSP, ';
  strSQL := strSQL + '  MOVTRI.DET_ICOPPR, ';

  If fCampoExiste('MOVTRI', 'DET_CSTPIS') Then
  Begin
    strSQL := strSQL + '  MOVTRI.DET_CSTPIS, ';
    strSQL := strSQL + '  MOVTRI.DET_BASPIS, ';
    strSQL := strSQL + '  MOVTRI.DET_ALQPIS, ';
    strSQL := strSQL + '  MOVTRI.DET_VALPIS, ';
    strSQL := strSQL + '  MOVTRI.DET_CSTCOF, ';
    strSQL := strSQL + '  MOVTRI.DET_BASCOF, ';
    strSQL := strSQL + '  MOVTRI.DET_ALQCOF, ';
    strSQL := strSQL + '  MOVTRI.DET_VALCOF, ';

    strSQL := strSQL + '  MOVTRI.DET_CSTIPI, ';
  End;

  If fCampoExiste('MOVTRI', 'DET_ENQIPI') Then
    strSQL := strSQL + '  MOVTRI.DET_ENQIPI, ';

  If fCampoExiste('MOVTRI', 'DET_COMPLE') And fCampoExiste('NOTTRI', 'DET_COMPLE') Then
    strSQL := strSQL + '  MOVTRI.DET_COMPLE, '
  Else
    strSQL := strSQL + ' "" AS DET_COMPLE, ';

  If fCampoExiste('MOVTRI', 'DET_PERDIF') And fCampoExiste('NOTTRI', 'DET_PERDIF') Then
    strSQL := strSQL + '  MOVTRI.DET_PERDIF, '
  Else
    strSQL := strSQL + ' 0.00 AS DET_PERDIF, ';

  if fCampoExiste('MOVGER', 'GER_CODS01') then
  begin
    strSQL := strSQL + '  MOVGER.GER_CODS01, ';
    strSQL := strSQL + '  MOVGER.GER_CODS02, ';
    strSQL := strSQL + '  MOVGER.GER_CODS03, ';
    strSQL := strSQL + '  MOVGER.GER_CODS04, ';
    strSQL := strSQL + '  MOVGER.GER_CODS05, ';
    strSQL := strSQL + '  MOVGER.GER_CODS06, ';
  end
  else
  begin
    strSQL := strSQL + '  "" AS GER_CODS01, ';
    strSQL := strSQL + '  "" AS GER_CODS02, ';
    strSQL := strSQL + '  "" AS GER_CODS03, ';
    strSQL := strSQL + '  "" AS GER_CODS04, ';
    strSQL := strSQL + '  "" AS GER_CODS05, ';
    strSQL := strSQL + '  "" AS GER_CODS06, ';
  end;

  // Se existe os serviços 07 a 10
  If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_CODS07') Then
  Begin
    strSQL := strSQL + '  SERMOV.GER_CODS07, ';
    strSQL := strSQL + '  SERMOV.GER_CODS08, ';
    strSQL := strSQL + '  SERMOV.GER_CODS09, ';
    strSQL := strSQL + '  SERMOV.GER_CODS10, ';
  End;

  // Se existe os serviços 11 a 30
  If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_CODS11') Then
  Begin
    strSQL := strSQL + '  SERMOV.GER_CODS11, ';
    strSQL := strSQL + '  SERMOV.GER_CODS12, ';
    strSQL := strSQL + '  SERMOV.GER_CODS13, ';
    strSQL := strSQL + '  SERMOV.GER_CODS14, ';
    strSQL := strSQL + '  SERMOV.GER_CODS15, ';
    strSQL := strSQL + '  SERMOV.GER_CODS16, ';
    strSQL := strSQL + '  SERMOV.GER_CODS17, ';
    strSQL := strSQL + '  SERMOV.GER_CODS18, ';
    strSQL := strSQL + '  SERMOV.GER_CODS19, ';
    strSQL := strSQL + '  SERMOV.GER_CODS20, ';
    strSQL := strSQL + '  SERMOV.GER_CODS21, ';
    strSQL := strSQL + '  SERMOV.GER_CODS22, ';
    strSQL := strSQL + '  SERMOV.GER_CODS23, ';
    strSQL := strSQL + '  SERMOV.GER_CODS24, ';
    strSQL := strSQL + '  SERMOV.GER_CODS25, ';
    strSQL := strSQL + '  SERMOV.GER_CODS26, ';
    strSQL := strSQL + '  SERMOV.GER_CODS27, ';
    strSQL := strSQL + '  SERMOV.GER_CODS28, ';
    strSQL := strSQL + '  SERMOV.GER_CODS29, ';
    strSQL := strSQL + '  SERMOV.GER_CODS30, ';
  End;

  if fCampoExiste('MOVGER', 'GER_DESS01') then
  begin
    strSQL := strSQL + '  MOVGER.GER_DESS01, ';
    strSQL := strSQL + '  MOVGER.GER_DESS02, ';
    strSQL := strSQL + '  MOVGER.GER_DESS03, ';
    strSQL := strSQL + '  MOVGER.GER_DESS04, ';
    strSQL := strSQL + '  MOVGER.GER_DESS05, ';
    strSQL := strSQL + '  MOVGER.GER_DESS06, ';
  end
  else
  begin
    strSQL := strSQL + '  "" AS GER_DESS01, ';
    strSQL := strSQL + '  "" AS GER_DESS02, ';
    strSQL := strSQL + '  "" AS GER_DESS03, ';
    strSQL := strSQL + '  "" AS GER_DESS04, ';
    strSQL := strSQL + '  "" AS GER_DESS05, ';
    strSQL := strSQL + '  "" AS GER_DESS06, ';
  end;

  // Se existe os serviços 07 a 10
  If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_DESS07') Then
  Begin
    strSQL := strSQL + '  SERMOV.GER_DESS07, ';
    strSQL := strSQL + '  SERMOV.GER_DESS08, ';
    strSQL := strSQL + '  SERMOV.GER_DESS09, ';
    strSQL := strSQL + '  SERMOV.GER_DESS10, ';
  End;

  // Se existe os serviços 11 a 30
  If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_DESS11') Then
  Begin
    strSQL := strSQL + '  SERMOV.GER_DESS11, ';
    strSQL := strSQL + '  SERMOV.GER_DESS12, ';
    strSQL := strSQL + '  SERMOV.GER_DESS13, ';
    strSQL := strSQL + '  SERMOV.GER_DESS14, ';
    strSQL := strSQL + '  SERMOV.GER_DESS15, ';
    strSQL := strSQL + '  SERMOV.GER_DESS16, ';
    strSQL := strSQL + '  SERMOV.GER_DESS17, ';
    strSQL := strSQL + '  SERMOV.GER_DESS18, ';
    strSQL := strSQL + '  SERMOV.GER_DESS19, ';
    strSQL := strSQL + '  SERMOV.GER_DESS20, ';
    strSQL := strSQL + '  SERMOV.GER_DESS21, ';
    strSQL := strSQL + '  SERMOV.GER_DESS22, ';
    strSQL := strSQL + '  SERMOV.GER_DESS23, ';
    strSQL := strSQL + '  SERMOV.GER_DESS24, ';
    strSQL := strSQL + '  SERMOV.GER_DESS25, ';
    strSQL := strSQL + '  SERMOV.GER_DESS26, ';
    strSQL := strSQL + '  SERMOV.GER_DESS27, ';
    strSQL := strSQL + '  SERMOV.GER_DESS28, ';
    strSQL := strSQL + '  SERMOV.GER_DESS29, ';
    strSQL := strSQL + '  SERMOV.GER_DESS30, ';
  End;

  if fCampoExiste('MOVGER', 'GER_VALS01') then
  begin
    If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV','GER_DECS01') Then
    Begin
      If fCampoExiste('SERMOV','GER_IDES01') Then
      Begin
        strSQL := strSQL + ' IF(SERMOV.GER_IDES01 = "I", 0.00, (MOVGER.GER_VALS01 - (MOVGER.GER_VALS01 * (SERMOV.GER_DECS01 / 100)))) AS GER_VALS01, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES02 = "I", 0.00, (MOVGER.GER_VALS02 - (MOVGER.GER_VALS02 * (SERMOV.GER_DECS02 / 100)))) AS GER_VALS02, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES03 = "I", 0.00, (MOVGER.GER_VALS03 - (MOVGER.GER_VALS03 * (SERMOV.GER_DECS03 / 100)))) AS GER_VALS03, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES04 = "I", 0.00, (MOVGER.GER_VALS04 - (MOVGER.GER_VALS04 * (SERMOV.GER_DECS04 / 100)))) AS GER_VALS04, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES05 = "I", 0.00, (MOVGER.GER_VALS05 - (MOVGER.GER_VALS05 * (SERMOV.GER_DECS05 / 100)))) AS GER_VALS05, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES06 = "I", 0.00, (MOVGER.GER_VALS06 - (MOVGER.GER_VALS06 * (SERMOV.GER_DECS06 / 100)))) AS GER_VALS06, ';
      End
      Else
      Begin
        strSQL := strSQL + ' (MOVGER.GER_VALS01 - (MOVGER.GER_VALS01 * (SERMOV.GER_DECS01 / 100))) AS GER_VALS01, ';
        strSQL := strSQL + ' (MOVGER.GER_VALS02 - (MOVGER.GER_VALS02 * (SERMOV.GER_DECS02 / 100))) AS GER_VALS02, ';
        strSQL := strSQL + ' (MOVGER.GER_VALS03 - (MOVGER.GER_VALS03 * (SERMOV.GER_DECS03 / 100))) AS GER_VALS03, ';
        strSQL := strSQL + ' (MOVGER.GER_VALS04 - (MOVGER.GER_VALS04 * (SERMOV.GER_DECS04 / 100))) AS GER_VALS04, ';
        strSQL := strSQL + ' (MOVGER.GER_VALS05 - (MOVGER.GER_VALS05 * (SERMOV.GER_DECS05 / 100))) AS GER_VALS05, ';
        strSQL := strSQL + ' (MOVGER.GER_VALS06 - (MOVGER.GER_VALS06 * (SERMOV.GER_DECS06 / 100))) AS GER_VALS06, ';
      End;
    End
    Else
    Begin
      strSQL := strSQL + '  MOVGER.GER_VALS01, ';
      strSQL := strSQL + '  MOVGER.GER_VALS02, ';
      strSQL := strSQL + '  MOVGER.GER_VALS03, ';
      strSQL := strSQL + '  MOVGER.GER_VALS04, ';
      strSQL := strSQL + '  MOVGER.GER_VALS05, ';
      strSQL := strSQL + '  MOVGER.GER_VALS06, ';
    End;
  end
  else
  begin
    strSQL := strSQL + '  0.00 AS GER_VALS01, ';
    strSQL := strSQL + '  0.00 AS GER_VALS02, ';
    strSQL := strSQL + '  0.00 AS GER_VALS03, ';
    strSQL := strSQL + '  0.00 AS GER_VALS04, ';
    strSQL := strSQL + '  0.00 AS GER_VALS05, ';
    strSQL := strSQL + '  0.00 AS GER_VALS06, ';
  end;

  // Se existe os serviços 07, 08, 09 e 10
  If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_VALS07') Then
  Begin
    If fCampoExiste('SERMOV','GER_DECS07') Then
    Begin
      If fCampoExiste('SERMOV','GER_IDES07') Then
      Begin
        strSQL := strSQL + ' IF(SERMOV.GER_IDES07 = "I", 0.00, (SERMOV.GER_VALS07 - (SERMOV.GER_VALS07 * (SERMOV.GER_DECS07 / 100)))) AS GER_VALS07, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES08 = "I", 0.00, (SERMOV.GER_VALS08 - (SERMOV.GER_VALS08 * (SERMOV.GER_DECS08 / 100)))) AS GER_VALS08, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES09 = "I", 0.00, (SERMOV.GER_VALS09 - (SERMOV.GER_VALS09 * (SERMOV.GER_DECS09 / 100)))) AS GER_VALS09, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES10 = "I", 0.00, (SERMOV.GER_VALS10 - (SERMOV.GER_VALS10 * (SERMOV.GER_DECS10 / 100)))) AS GER_VALS10, ';
      End
      Else
      Begin
        strSQL := strSQL + ' (SERMOV.GER_VALS07 - (SERMOV.GER_VALS07 * (SERMOV.GER_DECS07 / 100))) AS GER_VALS07, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS08 - (SERMOV.GER_VALS08 * (SERMOV.GER_DECS08 / 100))) AS GER_VALS08, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS09 - (SERMOV.GER_VALS09 * (SERMOV.GER_DECS09 / 100))) AS GER_VALS09, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS10 - (SERMOV.GER_VALS10 * (SERMOV.GER_DECS10 / 100))) AS GER_VALS10, ';
      End;
    End
    Else
    Begin
      strSQL := strSQL + '  SERMOV.GER_VALS07, ';
      strSQL := strSQL + '  SERMOV.GER_VALS08, ';
      strSQL := strSQL + '  SERMOV.GER_VALS09, ';
      strSQL := strSQL + '  SERMOV.GER_VALS10, ';
    End;
  End;

  If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_IDES11') Then
  Begin
    If fCampoExiste('SERMOV','GER_IDES11') Then
    Begin
      If fCampoExiste('SERMOV','GER_IDES11') Then
      Begin
        strSQL := strSQL + ' IF(SERMOV.GER_IDES11 = "I", 0.00, (SERMOV.GER_VALS11 - (SERMOV.GER_VALS11 * (SERMOV.GER_DECS11 / 100)))) AS GER_VALS11, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES12 = "I", 0.00, (SERMOV.GER_VALS12 - (SERMOV.GER_VALS12 * (SERMOV.GER_DECS12 / 100)))) AS GER_VALS12, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES13 = "I", 0.00, (SERMOV.GER_VALS13 - (SERMOV.GER_VALS13 * (SERMOV.GER_DECS13 / 100)))) AS GER_VALS13, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES14 = "I", 0.00, (SERMOV.GER_VALS14 - (SERMOV.GER_VALS14 * (SERMOV.GER_DECS14 / 100)))) AS GER_VALS14, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES15 = "I", 0.00, (SERMOV.GER_VALS15 - (SERMOV.GER_VALS15 * (SERMOV.GER_DECS15 / 100)))) AS GER_VALS15, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES16 = "I", 0.00, (SERMOV.GER_VALS16 - (SERMOV.GER_VALS16 * (SERMOV.GER_DECS16 / 100)))) AS GER_VALS16, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES17 = "I", 0.00, (SERMOV.GER_VALS17 - (SERMOV.GER_VALS17 * (SERMOV.GER_DECS17 / 100)))) AS GER_VALS17, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES18 = "I", 0.00, (SERMOV.GER_VALS18 - (SERMOV.GER_VALS18 * (SERMOV.GER_DECS18 / 100)))) AS GER_VALS18, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES19 = "I", 0.00, (SERMOV.GER_VALS19 - (SERMOV.GER_VALS19 * (SERMOV.GER_DECS19 / 100)))) AS GER_VALS19, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES20 = "I", 0.00, (SERMOV.GER_VALS20 - (SERMOV.GER_VALS20 * (SERMOV.GER_DECS20 / 100)))) AS GER_VALS20, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES21 = "I", 0.00, (SERMOV.GER_VALS21 - (SERMOV.GER_VALS21 * (SERMOV.GER_DECS21 / 100)))) AS GER_VALS21, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES22 = "I", 0.00, (SERMOV.GER_VALS22 - (SERMOV.GER_VALS22 * (SERMOV.GER_DECS22 / 100)))) AS GER_VALS22, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES23 = "I", 0.00, (SERMOV.GER_VALS23 - (SERMOV.GER_VALS23 * (SERMOV.GER_DECS23 / 100)))) AS GER_VALS23, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES24 = "I", 0.00, (SERMOV.GER_VALS24 - (SERMOV.GER_VALS24 * (SERMOV.GER_DECS24 / 100)))) AS GER_VALS24, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES25 = "I", 0.00, (SERMOV.GER_VALS25 - (SERMOV.GER_VALS25 * (SERMOV.GER_DECS25 / 100)))) AS GER_VALS25, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES26 = "I", 0.00, (SERMOV.GER_VALS26 - (SERMOV.GER_VALS26 * (SERMOV.GER_DECS26 / 100)))) AS GER_VALS26, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES27 = "I", 0.00, (SERMOV.GER_VALS27 - (SERMOV.GER_VALS27 * (SERMOV.GER_DECS27 / 100)))) AS GER_VALS27, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES28 = "I", 0.00, (SERMOV.GER_VALS28 - (SERMOV.GER_VALS28 * (SERMOV.GER_DECS28 / 100)))) AS GER_VALS28, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES29 = "I", 0.00, (SERMOV.GER_VALS29 - (SERMOV.GER_VALS29 * (SERMOV.GER_DECS29 / 100)))) AS GER_VALS29, ';
        strSQL := strSQL + ' IF(SERMOV.GER_IDES30 = "I", 0.00, (SERMOV.GER_VALS30 - (SERMOV.GER_VALS30 * (SERMOV.GER_DECS30 / 100)))) AS GER_VALS30, ';
      End
      Else
      Begin
        strSQL := strSQL + ' (SERMOV.GER_VALS11 - (SERMOV.GER_VALS11 * (SERMOV.GER_DECS11 / 100))) AS GER_VALS11, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS12 - (SERMOV.GER_VALS12 * (SERMOV.GER_DECS12 / 100))) AS GER_VALS12, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS13 - (SERMOV.GER_VALS13 * (SERMOV.GER_DECS13 / 100))) AS GER_VALS13, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS14 - (SERMOV.GER_VALS14 * (SERMOV.GER_DECS14 / 100))) AS GER_VALS14, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS15 - (SERMOV.GER_VALS15 * (SERMOV.GER_DECS15 / 100))) AS GER_VALS15, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS16 - (SERMOV.GER_VALS16 * (SERMOV.GER_DECS16 / 100))) AS GER_VALS16, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS17 - (SERMOV.GER_VALS17 * (SERMOV.GER_DECS17 / 100))) AS GER_VALS17, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS18 - (SERMOV.GER_VALS18 * (SERMOV.GER_DECS18 / 100))) AS GER_VALS18, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS19 - (SERMOV.GER_VALS19 * (SERMOV.GER_DECS19 / 100))) AS GER_VALS19, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS20 - (SERMOV.GER_VALS20 * (SERMOV.GER_DECS20 / 100))) AS GER_VALS20, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS21 - (SERMOV.GER_VALS21 * (SERMOV.GER_DECS21 / 100))) AS GER_VALS21, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS22 - (SERMOV.GER_VALS22 * (SERMOV.GER_DECS22 / 100))) AS GER_VALS22, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS23 - (SERMOV.GER_VALS23 * (SERMOV.GER_DECS23 / 100))) AS GER_VALS23, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS24 - (SERMOV.GER_VALS24 * (SERMOV.GER_DECS24 / 100))) AS GER_VALS24, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS25 - (SERMOV.GER_VALS25 * (SERMOV.GER_DECS25 / 100))) AS GER_VALS25, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS26 - (SERMOV.GER_VALS26 * (SERMOV.GER_DECS26 / 100))) AS GER_VALS26, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS27 - (SERMOV.GER_VALS27 * (SERMOV.GER_DECS27 / 100))) AS GER_VALS27, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS28 - (SERMOV.GER_VALS28 * (SERMOV.GER_DECS28 / 100))) AS GER_VALS28, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS29 - (SERMOV.GER_VALS29 * (SERMOV.GER_DECS29 / 100))) AS GER_VALS29, ';
        strSQL := strSQL + ' (SERMOV.GER_VALS30 - (SERMOV.GER_VALS30 * (SERMOV.GER_DECS30 / 100))) AS GER_VALS30, ';
      End;
    End
    Else
    Begin
      strSQL := strSQL + '  SERMOV.GER_VALS11, ';
      strSQL := strSQL + '  SERMOV.GER_VALS12, ';
      strSQL := strSQL + '  SERMOV.GER_VALS13, ';
      strSQL := strSQL + '  SERMOV.GER_VALS14, ';
      strSQL := strSQL + '  SERMOV.GER_VALS15, ';
      strSQL := strSQL + '  SERMOV.GER_VALS16, ';
      strSQL := strSQL + '  SERMOV.GER_VALS17, ';
      strSQL := strSQL + '  SERMOV.GER_VALS18, ';
      strSQL := strSQL + '  SERMOV.GER_VALS19, ';
      strSQL := strSQL + '  SERMOV.GER_VALS20, ';
      strSQL := strSQL + '  SERMOV.GER_VALS21, ';
      strSQL := strSQL + '  SERMOV.GER_VALS22, ';
      strSQL := strSQL + '  SERMOV.GER_VALS23, ';
      strSQL := strSQL + '  SERMOV.GER_VALS24, ';
      strSQL := strSQL + '  SERMOV.GER_VALS25, ';
      strSQL := strSQL + '  SERMOV.GER_VALS26, ';
      strSQL := strSQL + '  SERMOV.GER_VALS27, ';
      strSQL := strSQL + '  SERMOV.GER_VALS28, ';
      strSQL := strSQL + '  SERMOV.GER_VALS29, ';
      strSQL := strSQL + '  SERMOV.GER_VALS30, ';
    End;
  End;

  If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_SEROBS') Then
    strSQL := strSQL + ' IFNULL(SERMOV.GER_SEROBS,"") AS GER_SEROBS, '
  Else
    strSQL := strSQL + ' "" AS GER_SEROBS, ';

  If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_MUNPRE') Then
    strSQL := strSQL + ' IFNULL(SERMOV.GER_MUNPRE,"") AS GER_MUNPRE, '
  Else
    strSQL := strSQL + ' "" AS GER_MUNPRE, ';

  If fTabelaExiste('SERMOV') And fCampoExiste('SERMOV', 'GER_NATSER') Then
    strSQL := strSQL + ' IFNULL(SERMOV.GER_NATSER,"") AS GER_SERNAT, '
  Else
    strSQL := strSQL + ' "" AS GER_SERNAT, ';

  If fTabelaExiste('MOVOBS') And fCampoExiste('MOVOBS', 'MOV_DISSER') Then
    strSQL := strSQL + ' IFNULL(MOVOBS.MOV_DISSER,"") AS GER_DISSER, '
  Else
    strSQL := strSQL + ' " " AS GER_DISSER, ';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_DUPREC') Then
    strSQL := strSQL + '  AUX_DUPREC AS GER_DUPREC,'
  Else
    strSQL := strSQL + '  0.00 AS GER_DUPREC,';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_CODOBR') Then
  Begin
    strSQL := strSQL + '  AUX_ENTGER, ';
    strSQL := strSQL + '  AUX_CODOBR, ';
    strSQL := strSQL + '  AUX_CODART, ';
    strSQL := strSQL + '  ETC_CIDENT, ';
    strSQL := strSQL + '  ETC_ENDENT, ';
    strSQL := strSQL + '  ETC_BAIENT, ';
    strSQL := strSQL + '  ETC_CEPENT, ';
    strSQL := strSQL + '  ETC_TELENT, ';
    strSQL := strSQL + '  ETC_CONENT, ';
    strSQL := strSQL + '  ETC_REFENT, ';
    If fCampoExiste('CADCID', 'CID_CODPAI') then
      strSQL := strSQL + '  (SELECT CID_CODPAI FROM CADCID WHERE CID_CODCID = ETC_CIDENT LIMIT 1) AS ETC_CODPAI, '
    Else
      strSQL := strSQL + '  "" AS ETC_CODPAI, ';
  End
  Else
  Begin
    strSQL := strSQL + '  "" AS AUX_ENTGER, ';
    strSQL := strSQL + '  "" AS AUX_CODOBR, ';
    strSQL := strSQL + '  "" AS AUX_CODART, ';
    strSQL := strSQL + '  "" AS ETC_CIDENT, ';
    strSQL := strSQL + '  "" AS ETC_ENDENT, ';
    strSQL := strSQL + '  "" AS ETC_BAIENT, ';
    strSQL := strSQL + '  "" AS ETC_CEPENT, ';
    strSQL := strSQL + '  "" AS ETC_TELENT, ';
    strSQL := strSQL + '  "" AS ETC_CONENT, ';
    strSQL := strSQL + '  "" AS ETC_REFENT, ';
    strSQL := strSQL + '  "" AS ETC_CODPAI, ';
  End;

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_INSIMO') Then
    strSQL := strSQL + ' IFNULL(AUXMOV.AUX_INSIMO,"") AS AUX_INSIMO, '
  Else
    strSQL := strSQL + ' " " AS AUX_INSIMO, ';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_CODCIB') Then
    strSQL := strSQL + ' IFNULL(AUXMOV.AUX_CODCIB,"") AS AUX_CODCIB, '
  Else
    strSQL := strSQL + ' " " AS AUX_CODCIB, ';

  If fTabelaExiste('AUXMOV') And fCampoExiste('AUXMOV', 'AUX_CODCNO') Then
    strSQL := strSQL + ' IFNULL(AUXMOV.AUX_CODCNO,"") AS AUX_CODCNO, '
  Else
    strSQL := strSQL + ' " " AS AUX_CODCNO, ';

  If fCampoExiste('ENTCLI', 'ETC_ENDERE') Then
    strSQL := strSQL + '  ETC_ENDERE, '
  Else
    strSQL := strSQL + '  "" AS ETC_ENDERE, ';

  If fCampoExiste('ENTCLI', 'ETC_ENDNUM') Then
    strSQL := strSQL + '  ETC_ENDNUM, '
  Else
    strSQL := strSQL + '  "" AS ETC_ENDNUM, ';

  If fCampoExiste('ENTCLI', 'ETC_ENDCOM') Then
    strSQL := strSQL + '  ETC_ENDCOM, '
  Else
    strSQL := strSQL + '  "" AS ETC_ENDCOM, ';

  If (fConfiguracao('CNPENT') = 'S') And (fTabelaExiste('AUXMOV')) And (fCampoExiste('ENTCLI', 'ETC_NUCNPJ')) Then
    strSQL := strSQL + '  ETC_NUCNPJ, '
  Else
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ETC_NUCNPJ, ';

  If (fConfiguracao('CNPENT') = 'S') And (fTabelaExiste('AUXMOV')) And (fCampoExiste('ENTCLI', 'ETC_I_E_S_')) Then
    strSQL := strSQL + '  ETC_I_E_S_, '
  Else
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ETC_I_E_S_, ';

  If (fConfiguracao('IEPDRU') = 'S') And (fTabelaExiste('AUXMOV')) And (fCampoExiste('ENTCLI', 'ETC_I_E_S_')) Then
    strSQL := strSQL + '  ETC_I_E_S_ AS ETC_I_E_S_RURAL, '
  Else
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ETC_I_E_S_RURAL, ';

  If fCampoExiste('MOVTRI', 'DET_SEQCCR') Then
    strSQL := strSQL + '  DET_SEQCCR, '
  Else
    strSQL := strSQL + '  "" AS DET_SEQCCR,  ';

  if blnTrSeCi And fTabelaExiste('TRISER') then
    strSQL := strSQL + '  TSE_CDLSSE AS SER_CDLSSE, '
  Else
  If fCampoExiste('CADSER', 'SER_CDLSSE') Then
    strSQL := strSQL + '  SER_CDLSSE, '
  Else
    strSQL := strSQL + ' "" AS SER_CDLSSE, ';

  if blnTrSeCi And fTabelaExiste('TRISER') then
    strSQL := strSQL + '  TSE_TRIMUN AS SER_TRIMUN, '
  Else
  If fCampoExiste('CADSER', 'SER_TRIMUN') Then
    strSQL := strSQL + '  SER_TRIMUN, '
  Else
    strSQL := strSQL + '  REPEAT(" ", 20) AS SER_TRIMUN,  ';

  If fCampoExiste('CADSER', 'SER_CLATRI') Then
    strSQL := strSQL + '  SER_CLATRI, '
  Else
    strSQL := strSQL + '  "" AS SER_CLATRI, ';

  If fCampoExiste('CADSER', 'SER_INDOPE') Then
    strSQL := strSQL + '  SER_INDOPE, '
  Else
    strSQL := strSQL + '  "" AS SER_INDOPE, ';

  If (fCampoExiste('CADSER', 'SER_CNAEFI')) Then
    strSQL := strSQL + '  SER_CNAEFI, '
  Else
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS SER_CNAEFI, ';

  If (fCampoExiste('CADSER', 'SER_CNAECP')) Then
    strSQL := strSQL + '  SER_CNAECP, '
  Else
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS SER_CNAECP, ';

  If fCampoExiste('CADSER', 'SER_CODNBS') Then
    strSQL := strSQL + '  SER_CODNBS, '
  Else
    strSQL := strSQL + ' "" AS SER_CODNBS, ';

  If fCampoExiste('CADSER', 'SER_NATOPE') Then
    strSQL := strSQL + '  SER_NATOPE, '
  Else
    strSQL := strSQL + ' "" AS SER_NATOPE, ';

  If fCampoExiste('CADSER', 'SER_IBPT_F') Then
    strSQL := strSQL + '  SER_IBPT_F, '
  Else
    strSQL := strSQL + ' 0 AS SER_IBPT_F, ';

  If fCampoExiste('CADSER', 'SER_IBPT_E') Then
    strSQL := strSQL + '  SER_IBPT_E, '
  Else
    strSQL := strSQL + ' 0 AS SER_IBPT_E, ';

  If fCampoExiste('CADSER', 'SER_IBPT_M') Then
    strSQL := strSQL + '  SER_IBPT_M, '
  Else
    strSQL := strSQL + ' 0 AS SER_IBPT_M, ';

  strSQL := strSQL + '  DET_NUM_PD, ';
  strSQL := strSQL + '  DET_ESP_PD, ';
  strSQL := strSQL + '  DET_EMP_PD, ';
  strSQL := strSQL + '  DET_IND_PD, ';

  If (fConfiguracao('IMPDIR') = 'S') And fCampoExiste('CADITE', 'ITE_IMPDIR') Then
  Begin
    If (fConfiguracao('IMPDIG') = '2') Then
      strSQL := strSQL + '  ITEGER.ITE_IMPDIR, '
    Else
      strSQL := strSQL + '  CADITE.ITE_IMPDIR, ';
  End
  Else
    strSQL := strSQL + '  "N" AS ITE_IMPDIR, ';

  If ((fConfiguracao('VENMAD') = 'S') Or
      (fConfiguracao('VENVID') = 'S') Or
      (fConfiguracao('VENMTL') = 'S')) And
       fTabelaExiste('MOVMAD') Then
  Begin
    strSQL := strSQL + '  DET_QTDPEC, ';
    strSQL := strSQL + '  DET_COMPEC, ';
    strSQL := strSQL + '  DET_LARPEC, ';
    strSQL := strSQL + '  DET_ESPPEC, ';
    strSQL := strSQL + '  DET_APAREL, ';
    strSQL := strSQL + '  DET_BENEFI, ';
    strSQL := strSQL + '  DET_PERAPA, ';
    strSQL := strSQL + '  DET_PERBEN, ';
    strSQL := strSQL + '  if( (DET_QTDPEC > 0) AND (DET_TOTITE > 0), (DET_TOTITE / DET_QTDPEC), 0) AS DET_VLUNPC, ';
  End;

  If fCampoExiste('CADITE', 'ITE_CODLUB') Then
  Begin
    strSQL := strSQL + '  CADITE.ITE_CODLUB, ';
  End
  Else
  Begin
    strSQL := strSQL + '  "" AS ITE_CODLUB, ';
  End;

  If fCampoExiste('CADITE', 'ITE_DESANP') Then
    strSQL := strSQL + '  CADITE.ITE_DESANP, '
  Else
    strSQL := strSQL + '  "" AS ITE_DESANP, ';

  If fCampoExiste('CADITE', 'ITE_NUMFCI') Then
  Begin
    strSQL := strSQL + '  CADITE.ITE_NUMFCI, ';
  End
  Else
  Begin
    strSQL := strSQL + '  "" AS ITE_NUMFCI, ';
  End;

  If objConfig.blnClaOnu Then
  Begin
    strSQL := strSQL + '  ONU_CODONU, ';
    strSQL := strSQL + '  ONU_DESCRI, ';

    If fCampoExiste('CADONU', 'ONU_CODIGO') Then
      strSQL := strSQL + '  ONU_CODIGO, '
    Else
      strSQL := strSQL + '  "" AS ONU_CODIGO, ';

    If fCampoExiste('CADONU', 'ONU_CLARIS') Then
      strSQL := strSQL + '  ONU_CLARIS, '
    Else
      strSQL := strSQL + '  "" AS ONU_CLARIS, ';

    If fCampoExiste('CADONU', 'ONU_GRUEMB') Then
      strSQL := strSQL + '  ONU_GRUEMB, '
    Else
      strSQL := strSQL + '  "" AS ONU_GRUEMB, ';
  End
  Else
  Begin
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ONU_CODONU, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ONU_DESCRI, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ONU_CODIGO, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ONU_CLARIS, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ONU_GRUEMB, ';
  End;

  strSQL := strSQL + '  MOVDET.DET_TOTPES, ';
  strSQL := strSQL + '  MOVDET.DET_FORITE, ';

  If fCampoExiste('MOVTRI', 'DET_COICMP') And fCampoExiste('NOTTRI', 'DET_COICMP') Then //CAMPO CRIADO REQ.: 38461 MAS O REQUISITO FOI "PERDIDO" NA VIRADA 48.02.DESEN > 48.02.30
    strSQL := strSQL + '  MOVTRI.DET_COICMP, '                                          //MANTIDO AQUI SOMENTE POR QUESTÃO DE COMPATIBILIDADE
  Else
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS DET_COICMP, ';

  If fCampoExiste('MOVTRI', 'DET_CFORDI') And fCampoExiste('NOTTRI', 'DET_CFORDI') Then
    strSQL := strSQL + '  MOVTRI.DET_CFORDI, '
  Else
    strSQL := strSQL + '  "" AS DET_CFORDI, ';

  If fCampoExiste('MOVTRI', 'DET_NUMCMP') Then
    strSQL := strSQL + '  MOVTRI.DET_NUMCMP, '
  Else
    strSQL := strSQL + '  "" AS DET_NUMCMP, ';

  If fCampoExiste('MOVTRI', 'DET_NITCMP') Then
    strSQL := strSQL + '  MOVTRI.DET_NITCMP, '
  Else
    strSQL := strSQL + '  0  AS DET_NITCMP, ';

  If fCampoExiste('MOVTRI', 'DET_CBENEF') Then
    strSQL := strSQL + '  MOVTRI.DET_CBENEF, '
  Else
    strSQL := strSQL + '  ""  AS DET_CBENEF, ';

  If fCampoExiste('MOVTRI', 'DET_CODPRE') Then
    strSQL := strSQL + '  MOVTRI.DET_CODPRE, '
  Else
    strSQL := strSQL + '  ""  AS DET_CODPRE, ';

  If fCampoExiste('MOVTRI', 'DET_PERPRE') Then
    strSQL := strSQL + '  MOVTRI.DET_PERPRE, '
  Else
    strSQL := strSQL + '  0  AS DET_PERPRE, ';

  If fCampoExiste('MOVTRI', 'DET_VALPRE') Then
    strSQL := strSQL + '  MOVTRI.DET_VALPRE, '
  Else
    strSQL := strSQL + '  0  AS DET_VALPRE, ';

  If fCampoExiste('MOVTRI', 'DET_ITEREF') Then
    strSQL := strSQL + '  MOVTRI.DET_ITEREF, '
  Else
    strSQL := strSQL + '  " "  AS DET_ITEREF, ';

  If fCampoExiste('MOVTRI', 'DET_CHVREF') Then
    strSQL := strSQL + '  MOVTRI.DET_CHVREF, '
  Else
    strSQL := strSQL + '  " "  AS DET_CHVREF, ';

  //Quando nao existir o campo enviar em branco
  If fCampoExiste('MOVTRI', 'DET_RICMPR') Then
    strSQL := strSQL + '  MOVTRI.DET_RICMPR, '
  Else
    strSQL := strSQL + '  "" AS DET_RICMPR, ';

  strSQL := strSQL + '  MOVDET.DET_TMPGAR, ';

  If fCampoExiste('CADITE', 'ITE_INFGAR') Then
    strSQL := strSQL + '  CADITE.ITE_INFGAR, '
  Else
    strSQL := strSQL + '  "" AS ITE_INFGAR, ';

  If fCampoExiste('MOVGER', 'GER_BASORG') Then
    strSQL := strSQL + ' ' + strBasOrg + ', '
  Else
    strSQL := strSQL + ' 0.00 AS GER_BASORG, ';

  If fCampoExiste('MOVGER', 'GER_ICMORG') Then
    strSQL := strSQL + ' ' + strIcmOrg + ', '
  Else
    strSQL := strSQL + ' 0.00 AS GER_ICMORG, ';

  If fCampoExiste('AUXMOV', 'AUX_BASVRD') Then
    strSQL := strSQL + ' ' + strBasVrd + ', '
  Else
    strSQL := strSQL + ' 0.00 AS AUX_BASVRD, ';

  If fCampoExiste('AUXMOV', 'AUX_VRDICM') Then
    strSQL := strSQL + ' ' + strVrdIcm + ', '
  Else
    strSQL := strSQL + ' 0.00 AS AUX_VRDICM, ';

  strSQL := strSQL + '  FGO_NUMCMP, ';
  strSQL := strSQL + '  FGO_NUMPOK, ';
  strSQL := strSQL + '  FGO_PEDSIT, ';

  If (fUtilizaExtgorNoSelect) Then
    strSQL := strSQL + '  MOVPIX.MPX_END_ID, '
  Else
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS MPX_END_ID, ';

  If fCampoExiste('FATGOR', 'FGO_ORIGEM') Then
    strSQL := strSQL + '  FGO_ORIGEM, '
  else
    strSQL := strSQL + '  "AUTCOM" AS FGO_ORIGEM, ';

  strSQL := strSQL + '  ABF_PEIMPG, ';

  If fCampoExiste('MOVTRI', 'DET_IMPPAG') Then
    strSQL := strSQL + '  MOVTRI.DET_IMPPAG, ';

  If fCampoExiste('MOVTRI', 'DET_FEDIMP') Then
    strSQL := strSQL + '  MOVTRI.DET_FEDIMP, ';

  If fCampoExiste('MOVTRI', 'DET_ESTIMP') Then
    strSQL := strSQL + '  MOVTRI.DET_ESTIMP, ';

  If fCampoExiste('MOVTRI', 'DET_MUNIMP') Then
    strSQL := strSQL + '  MOVTRI.DET_MUNIMP, ';

  If fCampoExiste('MOVTRI', 'DET_ICMORG') Then
    strSQL := strSQL + '  MOVTRI.DET_ICMORG, ';

  If fCampoExiste('MOVTRI', 'DET_VRDICM') Then
    strSQL := strSQL + '  MOVTRI.DET_VRDICM, '
  Else
    strSQL := strSQL + '  0.00 AS DET_VRDICM, ';

  If fCampoExiste('MOVTRI', 'DET_MTDICM') Then
    strSQL := strSQL + '  MOVTRI.DET_MTDICM, '
  Else
    strSQL := strSQL + '  "" AS DET_MTDICM, ';

  If fCampoExiste('MOVTRI', 'DET_ICMORG') Then
    strSQL := strSQL + '  MOVTRI.DET_ICMORG, ';

  If fCampoExiste('MOVTRI', 'DET_VALDIF') Then
    strSQL := strSQL + '  MOVTRI.DET_VALDIF, '
  Else
    strSQL := strSQL + '  0.00 AS DET_VALDIF, ';

  If fCampoExiste('MOVDET', 'DET_DOCDEV') Then
  Begin
    strSQL := strSQL + '  MOVDET.DET_DOCDEV, ';
    strSQL := strSQL + '  MOVDET.DET_ESPDEV, ';
    strSQL := strSQL + '  MOVDET.DET_EMPDEV, ';

    If fCampoExiste('MOVDET', 'DET_SERDEV') Then
      strSQL := strSQL + '  MOVDET.DET_SERDEV, ';
  End
  Else
  Begin
    strSQL := strSQL + ' " " AS DET_DOCDEV, ';
    strSQL := strSQL + ' " " AS DET_ESPDEV, ';
    strSQL := strSQL + ' " " AS DET_EMPDEV, ';

    If fCampoExiste('MOVDET', 'DET_SERDEV') Then
      strSQL := strSQL + ' " " AS DET_SERDEV, ';
  End;

  If fCampoExiste('CADITE', 'ITE_CDCEST') Then
  Begin
    strSQL := strSQL + '  CADITE.ITE_CDCEST, ';
  End
  Else If fConfiguracao('CESTPD') <> '' Then
  Begin
    strSQL := strSQL + ' ' + fConfiguracao('CESTPD') + ' AS ITE_CDCEST, ';
  End
  Else Begin
    strSQL := strSQL + '  "" AS ITE_CDCEST, ';
  End;

  pAdicionaCampoCadIte('ITE_INDESC', '"S"');
  pAdicionaCampoCadIte('ITE_CNPFME', '" "');
  pAdicionaCampoCadIte('ITE_CDBFIS', '" "');
  pAdicionaCampoCadIte('ITE_ENIECB', '"N"');
  pAdicionaCampoCadIte('ITE_ANVISE', '"N"');
  pAdicionaCampoCadIte('ITE_ANVRDC', '" "');
  pAdicionaCampoCadIte('ITE_ANVREG', '" "');
  pAdicionaCampoCadIte('ITE_CODFOR', '""');

  If fCampoExiste('MOVTRI', 'DET_BFCPST') Then
    strSQL := strSQL + '  DET_BFCPST, '
  Else
    strSQL := strSQL + ' 0.00 AS DET_BFCPST, ';

  If fCampoExiste('MOVTRI', 'DET_PFCPST') Then
    strSQL := strSQL + '  DET_PFCPST, '
  Else
    strSQL := strSQL + ' 0.00 AS DET_PFCPST, ';

  If fCampoExiste('MOVTRI', 'DET_VFCPST') Then
    strSQL := strSQL + '  DET_VFCPST, '
  Else
    strSQL := strSQL + ' 0.00 AS DET_VFCPST, ';

  If fTabelaExiste('MOVICD') Then
  Begin
    strSQL := strSQL + '  ICD_SEQGER, ';
    strSQL := strSQL + '  ICD_BCUFDE, ';
    strSQL := strSQL + '  ICD_PERFCP, ';
    strSQL := strSQL + '  ICD_ALQUFD, ';
    strSQL := strSQL + '  ICD_ALQINE, ';
    strSQL := strSQL + '  ICD_PERPAR, ';
    strSQL := strSQL + '  ICD_VALFCP, ';
    strSQL := strSQL + '  ICD_VALDES, ';
    strSQL := strSQL + '  ICD_VALORI, ';

    If fCampoExiste('MOVICD', 'ICD_FCPPRO') Then
      strSQL := strSQL + '  IFNULL(ICD_FCPPRO, "N") AS ICD_FCPPRO, '
    Else
      strSQL := strSQL + '  "N" AS ICD_FCPPRO, ';

    If fCampoExiste('MOVICD', 'ICD_BASFCP') Then
      strSQL := strSQL + '  ICD_BASFCP, '
    Else
      strSQL := strSQL + ' ICD_BCUFDE AS ICD_BASFCP, ';
  End;

  If fTabelaExiste('AUXMOV') And (fCampoExiste('AUXMOV', 'AUX_VENPRE')) Then
    strSQL := strSQL + '  AUX_VENPRE, ';

  If (fCampoExiste('MOVGER', 'GER_ENTFAT')) Then
    strSQL := strSQL + '     GER_ENTFAT, '
  Else
    strSQL := strSQL + ' "N" GER_ENTFAT, ';

  If blnNSRBru Then
    strSQL := strSQL + '     EMP_NSRBRU, '
  Else
    strSQL := strSQL + '  -1 EMP_NSRBRU, ';

  If fTabelaExiste('MOVAUX') And (fCampoExiste('MOVAUX', 'DET_PICMEF')) Then
  Begin
    strSQL := strSQL + '  MOVAUX.DET_PICMEF, ';
    strSQL := strSQL + '  MOVAUX.DET_BICMEF, ';
    strSQL := strSQL + '  MOVAUX.DET_AICMEF, ';
    strSQL := strSQL + '  MOVAUX.DET_VICMEF, ';
    strSQL := strSQL + '  MOVAUX.DET_BSTANT, ';
    strSQL := strSQL + '  MOVAUX.DET_VSTANT, ';
  End
  Else
  Begin
    strSQL := strSQL + ' 0.00 AS DET_PICMEF, ';
    strSQL := strSQL + ' 0.00 AS DET_BICMEF, ';
    strSQL := strSQL + ' 0.00 AS DET_AICMEF, ';
    strSQL := strSQL + ' 0.00 AS DET_VICMEF, ';
    strSQL := strSQL + ' 0.00 AS DET_BSTANT, ';
    strSQL := strSQL + ' 0.00 AS DET_VSTANT, ';
  End;

  If fTabelaExiste('MOVAUX') And (fCampoExiste('MOVAUX', 'DET_SICMEF')) Then
    strSQL := strSQL + '  MOVAUX.DET_SICMEF, '
  Else
    strSQL := strSQL + ' 0.00 AS DET_SICMEF, ';

  If fTabelaExiste('DOCEXP') And (fCampoExiste('DOCEXP', 'EXP_UFEMBA')) Then
  Begin
    strSQL := strSQL + '  DOCEXP.EXP_UFEMBA, ';
    strSQL := strSQL + '  DOCEXP.EXP_LOEMBA, ';
    strSQL := strSQL + '  DOCEXP.EXP_LOCDES ';
  End
  Else
  Begin
    strSQL := strSQL + ' " " AS EXP_UFEMBA, ';
    strSQL := strSQL + ' " " AS EXP_LOEMBA, ';
    strSQL := strSQL + ' " " AS EXP_LOCDES ';
  End;

  If fCampoExiste('MOVGER', 'GER_BASSIM') Then
    strSQL := strSQL + '  ,        GER_BASSIM '
  else
    strSQL := strSQL + '  ,0.00 AS GER_BASSIM ';

  If fCampoExiste('MOVGER', 'GER_ALQIRF') Then
    strSQL := strSQL + '  ,GER_ALQIRF '
  else
    strSQL := strSQL + '  ,0.00 AS GER_ALQIRF ';

  If fCampoExiste('MOVGER', 'GER_ALQCSL') Then
    strSQL := strSQL + '  ,GER_ALQCSL '
  else
    strSQL := strSQL + '  ,0.00 AS GER_ALQCSL ';

  If fCampoExiste('CADFIS', 'FIS_BASPIS') Then
    strSQL := strSQL + '  ,FIS_BASPIS '
  else
    strSQL := strSQL + '  ,0.00 AS FIS_BASPIS ';

  If fCampoExiste('CADFIS', 'FIS_ALQPIS') Then
    strSQL := strSQL + '  ,FIS_ALQPIS '
  else
    strSQL := strSQL + '  ,0.00 AS FIS_ALQPIS ';

  If fCampoExiste('CADFIS', 'FIS_BASCOF') Then
    strSQL := strSQL + '  ,FIS_BASCOF '
  else
    strSQL := strSQL + '  ,0.00 AS FIS_BASCOF ';

  If fCampoExiste('CADFIS', 'FIS_ALQCOF') Then
    strSQL := strSQL + '  ,FIS_ALQCOF '
  else
    strSQL := strSQL + '  ,0.00 AS FIS_ALQCOF ';

  If fCampoExiste('CADFIS', 'FIS_NFSSUB') Then
    strSQL := strSQL + '  ,FIS_NFSSUB '
  else
    strSQL := strSQL + '  ," " AS FIS_NFSSUB ';

  If fCampoExiste('CADFIS', 'FIS_DEVSIM') Then
    strSQL := strSQL + '  ,FIS_DEVSIM '
  else
    strSQL := strSQL + '  ,"N" AS FIS_DEVSIM ';

  If fCampoExiste('CADFIS', 'FIS_FINNFE') Then
    strSQL := strSQL + '  ,FIS_FINNFE '
  else
    strSQL := strSQL + '  ," " AS FIS_FINNFE ';

  If fCampoExiste('CADFIS', 'FIS_TIPFIN') Then
    strSQL := strSQL + '  ,FIS_TIPFIN '
  else
    strSQL := strSQL + '  ," " AS FIS_TIPFIN ';

  If fCampoExiste('MOVTRI', 'DET_CHACES') Then
    strSQL := strSQL + ' ,DET_CHACES '
  else
    strSQL := strSQL + ', " " AS DET_CHACES ';

  If fCampoExiste('MOVTRI', 'DET_QTDCOM') Then
    strSQL := strSQL + ' ,DET_QTDCOM '
  else
    strSQL := strSQL + ', 0.00 AS DET_QTDCOM ';

  If fCampoExiste('MOVDET', 'DET_REFERE') Then
    strSQL := strSQL + ' , DET_REFERE '
  else
    strSQL := strSQL + ', "" AS DET_REFERE ';

  If fCampoExiste('AUXMOV', 'AUX_ENFUOP') Then
    strSQL := strSQL + ' ,AUX_ENFUOP '
  Else
    strSQL := strSQL + ' ," " AS AUX_ENFUOP ';

  If fCampoExiste('AUXMOV', 'AUX_TIPIBF') Then
    strSQL := strSQL + ' ,AUX_TIPIBF '
  Else
    strSQL := strSQL + ' ,0.00 AS AUX_TIPIBF ';

  If fCampoExiste('AUXMOV', 'AUX_TRETBF') Then
    strSQL := strSQL + ' ,AUX_TRETBF '
  Else
    strSQL := strSQL + ' ,0.00 AS AUX_TRETBF ';

  If fCampoExiste('AUXMOV', 'AUX_TFSTBF') Then
    strSQL := strSQL + ' ,AUX_TFSTBF '
  Else
    strSQL := strSQL + ' ,0.00 AS AUX_TFSTBF ';

  if fCampoExiste('CADTRA', 'TRA_ESCCRE') Then
    strSQL := strSQL + ' , CADTRA.TRA_ESCCRE '
  else
    strSQL := strSQL + ' , "" AS TRA_ESCCRE ';

  If fCampoExiste('AUXMOV', 'AUX_NUMDRW') Then
    strSQL := strSQL + ' ,AUX_NUMDRW '
  Else
    strSQL := strSQL + ' ,"" AS AUX_NUMDRW ';

  If fCampoExiste('AUXMOV', 'AUX_EMP_TE') Then
    strSQL := strSQL + ' ,' + strEmp_Te + ' '
  Else
    strSQL := strSQL + '  ,CAST("" AS CHAR(3)) AS AUX_EMP_TE ';

  If fCampoExiste('MOVAUX', 'DET_ATODDF') Then
    strSQL := strSQL + ' ,MOVAUX.DET_ATODDF '
  Else
    strSQL := strSQL + ' ,"N" AS DET_ATODDF ';

  If fCampoExiste('MOVAUX', 'DET_VDESST') Then
    strSQL := strSQL + ' ,MOVAUX.DET_VDESST '
  Else
    strSQL := strSQL + ' ,0.00 AS DET_VDESST ';

  If fCampoExiste('MOVAUX', 'DET_MDESST') Then
    strSQL := strSQL + ' ,MOVAUX.DET_MDESST '
  Else
    strSQL := strSQL + ' ,"" AS DET_MDESST ';

  If fCampoExiste('MOVAUX', 'DET_BIMRET') Then
    strSQL := strSQL + ' ,MOVAUX.DET_BIMRET '
  Else
    strSQL := strSQL + ' ,0.00 AS DET_BIMRET ';

  If fCampoExiste('MOVAUX', 'DET_AIMRET') Then
    strSQL := strSQL + ' ,MOVAUX.DET_AIMRET '
  Else
    strSQL := strSQL + ' ,0.00 AS DET_AIMRET ';

  If fCampoExiste('MOVAUX', 'DET_VIMRET') Then
    strSQL := strSQL + ' ,MOVAUX.DET_VIMRET '
  Else
    strSQL := strSQL + ' ,0.00 AS DET_VIMRET ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_CODCST') Then
    strSQL := strSQL + ' ,MOVREF.REF_CODCST '
  Else
    strSQL := strSQL + ' ,"" AS REF_CODCST ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_CLATRI') Then
    strSQL := strSQL + ' ,MOVREF.REF_CLATRI '
  Else
    strSQL := strSQL + ' ,"" AS REF_CLATRI ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_VALOPE') Then
    strSQL := strSQL + ' ,MOVREF.REF_VALOPE '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_VALOPE ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_VALIBS') Then
    strSQL := strSQL + ' ,MOVREF.REF_VALIBS '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_VALIBS ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_BASCAL') Then
    strSQL := strSQL + ' ,MOVREF.REF_BASCAL '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_BASCAL ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_CBSALQ') Then
    strSQL := strSQL + ' ,MOVREF.REF_CBSALQ '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_CBSALQ ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_CBSALD') Then
    strSQL := strSQL + ' ,MOVREF.REF_CBSALD '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_CBSALD ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_CBSVLD') Then
    strSQL := strSQL + ' ,MOVREF.REF_CBSVLD '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_CBSVLD ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_CBSALR') Then
    strSQL := strSQL + ' ,MOVREF.REF_CBSALR '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_CBSALR ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_CBSVLT') Then
    strSQL := strSQL + ' ,MOVREF.REF_CBSVLT '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_CBSVLT ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_CBSALE') Then
    strSQL := strSQL + ' ,MOVREF.REF_CBSALE '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_CBSALE ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_CBSVAL') Then
    strSQL := strSQL + ' ,MOVREF.REF_CBSVAL '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_CBSVAL ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_IBSUFA') Then
    strSQL := strSQL + ' ,MOVREF.REF_IBSUFA '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_IBSUFA ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_IBSUFD') Then
    strSQL := strSQL + ' ,MOVREF.REF_IBSUFD '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_IBSUFD ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_IBSUVD') Then
    strSQL := strSQL + ' ,MOVREF.REF_IBSUVD '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_IBSUVD ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_IBSUFR') Then
    strSQL := strSQL + ' ,MOVREF.REF_IBSUFR '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_IBSUFR ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_IBSUFT') Then
    strSQL := strSQL + ' ,MOVREF.REF_IBSUFT '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_IBSUFT ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_IBSUFE') Then
    strSQL := strSQL + ' ,MOVREF.REF_IBSUFE '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_IBSUFE ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_IBSUFV') Then
    strSQL := strSQL + ' ,MOVREF.REF_IBSUFV '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_IBSUFV ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_IBSMNA') Then
    strSQL := strSQL + ' ,MOVREF.REF_IBSMNA '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_IBSMNA ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_IBSMND') Then
    strSQL := strSQL + ' ,MOVREF.REF_IBSMND '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_IBSMND ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_IBSMVD') Then
    strSQL := strSQL + ' ,MOVREF.REF_IBSMVD '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_IBSMVD ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_IBSMNR') Then
    strSQL := strSQL + ' ,MOVREF.REF_IBSMNR '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_IBSMNR ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_IBSMNT') Then
    strSQL := strSQL + ' ,MOVREF.REF_IBSMNT '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_IBSMNT ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_IBSMNE') Then
    strSQL := strSQL + ' ,MOVREF.REF_IBSMNE '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_IBSMNE ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_IBSMNV') Then
    strSQL := strSQL + ' ,MOVREF.REF_IBSMNV '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_IBSMNV ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_SELCST') Then
    strSQL := strSQL + ' ,MOVREF.REF_SELCST '
  Else
    strSQL := strSQL + ' ,"" AS REF_SELCST ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_SELCLA') Then
    strSQL := strSQL + ' ,MOVREF.REF_SELCLA '
  Else
    strSQL := strSQL + ' ,"" AS REF_SELCLA ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_SELBAS') Then
    strSQL := strSQL + ' ,MOVREF.REF_SELBAS '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_SELBAS ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_SELALQ') Then
    strSQL := strSQL + ' ,MOVREF.REF_SELALQ '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_SELALQ ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_SELVAL') Then
    strSQL := strSQL + ' ,MOVREF.REF_SELVAL '
  Else
    strSQL := strSQL + ' ,0.00 AS REF_SELVAL ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_TRIREG') Then
    strSQL := strSQL + ' ,MOVREF.REF_TRIREG '
  Else
    strSQL := strSQL + ' ,"N" AS REF_TRIREG ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_CREPRE') Then
    strSQL := strSQL + ' ,MOVREF.REF_CREPRE '
  Else
    strSQL := strSQL + ' ,"N" AS REF_CREPRE ';

  If fTabelaExiste('MOVREF') And fCampoExiste('MOVREF', 'REF_MONOFA') Then
    strSQL := strSQL + ' ,MOVREF.REF_MONOFA '
  Else
    strSQL := strSQL + ' ,"N" AS REF_MONOFA ';

  If fCampoExiste('CADCLI', 'CLI_ATODDF') And fCampoExiste('CADCLI', 'CLI_MSATDF') Then
    strSQL := strSQL + ' ,IF(CLI_ATODDF = "S", CLI_MSATDF, "") AS CLI_MSATDF '
  Else
    strSQL := strSQL + ' ,"" AS CLI_MSATDF ';

  if fTabelaExiste('OMOCLI') then
    strSQL := strSQL + ' ,CAST(CONCAT("ORDEM DE MÃO DE OBRA DO CLIENTE: ", (SELECT GROUP_CONCAT(DISTINCT OMO_MAOCLI) FROM OMOCLI WHERE FATGOR.AUTOINCREM = OMO_SEQFGO)) AS CHAR(255)) OMO_MAOCLI ';

  if fTabelaExiste('EQUGOR') and fCampoExiste('EQUGER', 'EQU_NUMPED') and fCampoExiste('EQUGER', 'EQU_TIPPED') and fCampoExiste('EQUGER', 'EQU_EMPPED') then
  begin
    strSQL := strSQL + ' ,IF((SELECT COUNT(EQU_NUMOSE) FROM EQUGER WHERE EQU_NUMPED = FGO_NUMDOC AND EQU_EMPPED = FGO_CODEMP ';
    strSQL := strSQL + '      AND EQU_TIPPED = FGO_ESPDOC) > 0, "S", IF((SELECT COUNT(EQUGOR.FGO_SEQEQU) ';
    strSQL := strSQL + '      FROM EQUGOR WHERE EQUGOR.FGO_SEQFGO = FATGOR.AUTOINCREM) > 0, "S", "N")) AS GER_CONEQU ';

    if fCampoExiste('EQUGER', 'EQU_OBSNFS') Then
    begin
      strSQL := strSQL + ' ,IFNULL((SELECT EQU_OBSNFS FROM EQUGER WHERE (EQU_NUMPED = FGO_NUMDOC AND EQU_TIPPED = FGO_ESPDOC AND EQU_EMPPED = FGO_CODEMP) LIMIT 1), ';
      strSQL := strSQL + '(SELECT EQU_OBSNFS FROM EQUGER INNER JOIN EQUGOR ON EQUGER.AUTOINCREM = EQUGOR.FGO_SEQEQU WHERE (FATGOR.AUTOINCREM = EQUGOR.FGO_SEQFGO) LIMIT 1)) AS EQU_OBSNFS ';
    end
    else
      strSQL := strSQL + ' ,CAST("" AS CHAR(1)) AS EQU_OBSNFS ';
  end
  else if fCampoExiste('EQUGER', 'EQU_NUMPED') and fCampoExiste('EQUGER', 'EQU_TIPPED') and fCampoExiste('EQUGER', 'EQU_EMPPED') then
  begin
    strSQL := strSQL + ' ,IF((SELECT COUNT(EQU_NUMOSE) FROM EQUGER WHERE EQU_NUMPED = FGO_NUMDOC AND EQU_TIPPED = FGO_ESPDOC ';
    strSQL := strSQL + '      AND EQU_EMPPED = FGO_CODEMP) > 0, "S", "N") AS GER_CONEQU ';

    if fCampoExiste('EQUGER', 'EQU_OBSNFS') then
      strSQL := strSQL + ' ,(SELECT EQU_OBSNFS FROM EQUGER WHERE (EQU_NUMPED = FGO_NUMDOC AND EQU_TIPPED = FGO_ESPDOC AND EQU_EMPPED = FGO_CODEMP)) AS EQU_OBSNFS '
    else
      strSQL := strSQL + ' ,CAST("" AS CHAR(1)) AS EQU_OBSNFS ';
  end
  else
  begin
    strSQL := strSQL + ' ,"N" AS GER_CONEQU ';
    strSQL := strSQL + ' ,CAST("" AS CHAR(1)) AS EQU_OBSNFS ';
  end;

  If fCampoExiste('MOVTRI', 'DET_NITEM_') Then
    strSQL := strSQL + ' ,MOVTRI.DET_NITEM_ '
  Else
    strSQL := strSQL + ' ,CAST("" AS CHAR(1)) AS DET_NITEM_ ';

  If fCampoExiste('MOVTRI', 'DET_NUMDRW') Then
    strSQL := strSQL + ' ,MOVTRI.DET_NUMDRW '
  Else
    strSQL := strSQL + ' ,CAST("" AS CHAR(1)) AS DET_NUMDRW ';

  strSQL := strSQL + ' ,' + strRegEs2 + ' ';

  If fTabelaExiste('INCEFD') Then
  Begin
    strSQL := strSQL + ' ,INCEFD.EFD_SEQGER ';
    strSQL := strSQL + ' ,INCEFD.EFD_REFNFE ';
    strSQL := strSQL + ' ,INCEFD.EFD_INFADC ';
    strSQL := strSQL + ' ,INCEFD.EFD_IDENTI ';
    strSQL := strSQL + ' ,INCEFD.EFD_PERIOD ';
  End
  Else
  Begin
    strSQL := strSQL + ' ,CAST("" AS CHAR(1)) AS EFD_SEQGER ';
    strSQL := strSQL + ' ,CAST("" AS CHAR(1)) AS EFD_REFNFE ';
    strSQL := strSQL + ' ,CAST("" AS CHAR(1)) AS EFD_INFADC ';
    strSQL := strSQL + ' ,CAST("" AS CHAR(1)) AS EFD_IDENTI ';
    strSQL := strSQL + ' ,CAST("" AS CHAR(1)) AS EFD_PERIOD ';
  End;

  strSQL := strSQL + ' ,CAST((SELECT IF(COUNT(*) > 0, "S", "N") FROM CADEMP WHERE EMP_CLIFIL = CADFIS.FIS_FORCLI LIMIT 1) AS CHAR(1)) AS GER_CLIFIL ';
  strSQL := strSQL + ' ,CAST((SELECT CND_DESCRI FROM CADCND WHERE CND_CODIGO = MOVGER.GER_CODCND LIMIT 1) AS CHAR(70)) AS CND_DESCRI ';
  If (FEspDoc = 'IF') Then
  Begin
    strSQL := strSQL + ' ,CAST("" AS CHAR(1)) AS GER_LISPED ';
  End
  Else
  Begin
    strSQL := strSQL + ' ,CAST((SELECT GROUP_CONCAT(DISTINCT FDO_NUMDOC)         ';
    strSQL := strSQL + '          FROM FATDOR                                    ';
    strSQL := strSQL + '         WHERE FATDOR.FDO_NUMFAT = :NUMDOC               ';
    strSQL := strSQL + '           AND FATDOR.FDO_EMPFAT = :CODEMP               ';
    strSQL := strSQL + '           AND FATDOR.FDO_TIPFAT = :ESPDOC               ';
    If fCampoExiste('FATDOR', 'FDO_SERFAT') Then
      strSQL := strSQL + '         AND FATDOR.FDO_SERFAT = :SERIE_               ';
    strSQL := strSQL + '        ORDER BY FDO_NUMDOC) AS CHAR(255)) AS GER_LISPED ';
  End;

  If fTabelaExiste('REFFIS') Then
  Begin
    strSQL := strSQL + ' ,CAST((SELECT IF(COUNT(*)>0, "S", "N") ';
    strSQL := strSQL + '          FROM REFFIS ';
    strSQL := strSQL + '         WHERE REFFIS.FIS_SEQFIS = CADFIS.AUTOINCREM LIMIT 1) AS CHAR(1)) AS GER_REFFIS ';
  End
  Else
  Begin
    strSQL := strSQL + ' ,CAST("N" AS CHAR(1)) AS GER_REFFIS ';
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFIS ';

  strSQL := strSQL + 'LEFT JOIN MOVGER ON MOVGER.GER_NUMDOC = FIS_NUMDOC AND ';
  strSQL := strSQL + '                    MOVGER.GER_ESPDOC = FIS_ESPDOC AND ';
  strSQL := strSQL + '                    MOVGER.GER_SERIE_ = FIS_SERIE_ AND ';
  strSQL := strSQL + '                    MOVGER.GER_CODEMP = FIS_CODEMP AND ';
  strSQL := strSQL + '                    MOVGER.GER_TIP_FC = FIS_TIP_FC AND ';
  strSQL := strSQL + '                    IF(FIS_TIP_FC="C", MOVGER.GER_CODCLI, MOVGER.GER_CODFOR) = FIS_FORCLI ';

  If fTabelaExiste('SERMOV') Then
    strSQL := strSQL + 'LEFT JOIN SERMOV ON SERMOV.GER_SEQGER = MOVGER.AUTOINCREM ';

  strSQL := strSQL + 'LEFT JOIN MOVDET ON DET_NUMDOC = MOVGER.GER_NUMDOC AND ';
  strSQL := strSQL + '                    DET_ESPDOC = MOVGER.GER_ESPDOC AND ';
  strSQL := strSQL + '                    DET_SERIE_ = MOVGER.GER_SERIE_ AND ';
  strSQL := strSQL + '                    DET_CODEMP = MOVGER.GER_CODEMP AND ';
  strSQL := strSQL + '                    DET_TIP_FC = MOVGER.GER_TIP_FC AND ';
  strSQL := strSQL + '                    IF(FIS_TIP_FC="C", DET_CODCLI, DET_CODFOR) = IF(FIS_TIP_FC="C", MOVGER.GER_CODCLI, MOVGER.GER_CODFOR) ';

  strSQL := strSQL + 'LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';

  If fTabelaExiste('MOVREF') Then
    strSQL := strSQL + 'LEFT JOIN MOVREF ON MOVREF.REF_SEQGER = MOVDET.AUTOINCREM ';

  if fCampoExiste('MOVGER', 'GER_CODS01') then
    strSQL := strSQL + 'LEFT JOIN CADSER ON CADSER.SER_CODSER = MOVGER.GER_CODS01 '
  else
    strSQL := strSQL + 'LEFT JOIN CADSER ON CADSER.SER_CODSER = "" ';

  If fTabelaExiste('MOVAUX') Then
    strSQL := strSQL + 'LEFT JOIN MOVAUX ON MOVAUX.DET_SEQGER = MOVDET.AUTOINCREM ';

  if blnTrSeCi And fTabelaExiste('TRISER') then
  begin
    strSQL := strSQL + 'INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = CADFIS.FIS_CODEMP ';
    strSQL := strSQL + 'LEFT  JOIN TRISER ON TSE_CODSER = CADSER.SER_CODSER AND TSE_CODCID = EMP_CODCID ';
  End
  Else If blnNSRBru Then
  Begin
    strSQL := strSQL + 'INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = CADFIS.FIS_CODEMP ';
  End;

  strSQL := strSQL + 'LEFT JOIN CADITE ON CADITE.ITE_CODITE = DET_CODITE ';

  strSQL := strSQL + 'LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = DET_CODITE AND ';
  strSQL := strSQL + '                    ITEGER.ITE_CODEMP = DET_CODEMP ';

  if fCampoExiste('MOVDET', 'DET_ITEEMB') then
    strSQL := strSQL + 'LEFT JOIN CADITE ITEEMB ON ITEEMB.ITE_CODITE = DET_ITEEMB ';

  If fCampoExiste('MOVTRI', 'DET_ITEABF') Then
    strSQL := strSQL + 'LEFT JOIN CADITE ITEABF ON ITEABF.ITE_CODITE = DET_ITEABF '
  Else
    strSQL := strSQL + 'LEFT JOIN CADITE ITEABF ON ITEABF.ITE_CODITE = DET_CODITE ';

  If fTabelaExiste('CADLOT') Then
  Begin
    strSQL := strSQL + 'LEFT JOIN CADLOT ON DET_NUMLOT = LOT_NUMLOT AND ';
    strSQL := strSQL + '                    DET_CODITE = LOT_CODITE AND ';
    strSQL := strSQL + '                    DET_CODEMP = LOT_CODEMP     ';
  End;

  strSQL := strSQL + 'LEFT JOIN NOTCOM ON NOTCOM.GER_SEQGER = CADFIS.AUTOINCREM ';
  strSQL := strSQL + 'LEFT JOIN CLICON ON CLICON.CON_C_P_F_ = ' + IIF(blnCliConNC, 'NOTCOM.GER_CPFCON', 'NULL') + ' ';

  strSQL := strSQL + 'LEFT JOIN CADTRA ON MOVGER.GER_CODTRA = CADTRA.TRA_CODTRA ';
  strSQL := strSQL + 'LEFT JOIN CADCID AS CIDTRA ON CIDTRA.CID_CODCID = TRA_CODCID ';

  strSQL := strSQL + 'LEFT JOIN CADCLI CL ON CL.CLI_CODCLI = FIS_FORCLI AND FIS_TIP_FC="C" ';
  strSQL := strSQL + 'LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI AND FIS_TIP_FC="F" ';

  If fTabelaExiste('AUXMOV') Then
  Begin
    strSQL := strSQL + 'LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + 'LEFT JOIN ENTCLI ON AUXMOV.AUX_ENTGER = ENTCLI.AUTOINCREM AND ENTCLI.ETC_CODCLI = CL.CLI_CODCLI ';

    If blnCadFaz Then
      strSQL := strSQL + 'LEFT JOIN CADFAZ ON CADFAZ.FAZ_CODFAZ = IFNULL(NOTCOM.GER_CODFAZ, AUXMOV.AUX_CODFAZ) ';

    strSQL := strSQL + strWhereTraRed_;
  End;

  strSQL := strSQL + 'LEFT JOIN CADCID CC ON CC.CID_CODCID = IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('GER_CIDCON', 'CON_CODCID') + ', ' + fFazenda('CLI_CODCID', 'FAZ_CODCID') + ') ';
  strSQL := strSQL + 'LEFT JOIN CADCID CF ON CF.CID_CODCID = FOR_CODCID ';

  strSQL := strSQL + 'LEFT JOIN CADUNI AS UV ON UV.UNI_CODUNI = DET_UNIDAD ';

  If (fConfiguracao('UNITRI') = 'S') Then
    strSQL := strSQL + '  LEFT  JOIN CADUNI AS UT ON UT.UNI_CODUNI = CADITE.ITE_UNITRI ';

  strSQL := strSQL + 'LEFT JOIN CADMAR ON MAR_CODMAR = DET_CODMAR ';

  If fConfiguracao('TIPABF') = '1' Then
  Begin
    If fCampoExiste('ABFICM', 'ABF_CSTORI') Then
      strSQL := strSQL + 'LEFT JOIN ' + strTabAbf + ' ON ABF_CODABF = CADITE.ITE_CODABF AND ABF_CSTORI = CADITE.ITE_CSTORI AND '
    Else
      strSQL := strSQL + 'LEFT JOIN ' + strTabAbf + ' ON ABF_CODABF = CADITE.ITE_CODABF AND '
  End
  Else
  Begin
    If fCampoExiste('ABFICM', 'ABF_CSTORI') then
      strSQL := strSQL + 'LEFT JOIN ' + strTabAbf + ' ON ABF_CODABF = ITEGER.ITE_CODABF AND ABF_CSTORI = ITEGER.ITE_CSTORI AND '
    Else
      strSQL := strSQL + 'LEFT JOIN ' + strTabAbf + ' ON ABF_CODABF = ITEGER.ITE_CODABF AND ';
  End;


  strSQL := strSQL + '                    ABF_ESTADO = MOVGER.GER_ESTADO ';

  If Not fCampoExiste('NATCFO', 'NAT_DESCRI') Then
  Begin
    strSQL := strSQL + 'LEFT JOIN CADCFO C1 ON C1.CFO_CODCFO = MOVGER.GER_CLAFIS ';
    strSQL := strSQL + 'LEFT JOIN CADCFO C2 ON C2.CFO_CODCFO = MOVGER.GER_CLAFI2 ';
    strSQL := strSQL + 'LEFT JOIN CADCFO C3 ON C3.CFO_CODCFO = MOVGER.GER_CLAFI3 ';
    strSQL := strSQL + 'LEFT JOIN CADCFO C4 ON C4.CFO_CODCFO = MOVGER.GER_CLAFI4 ';
  End;

  strSQL := strSQL + 'LEFT JOIN CADOPE VE ON VE.OPE_CODOPE = MOVGER.GER_CODVEN ';
  strSQL := strSQL + 'LEFT JOIN CADOPE DI ON DI.OPE_CODOPE = MOVGER.GER_CODDIG ';

  strSQL := strSQL + 'LEFT JOIN MOVOBS ON MOV_SEQGER = MOVGER.AUTOINCREM ';

  strSQL := strSQL + 'LEFT JOIN CLIPRO P ON P.CLI_CODITE = DET_CODITE ';
  strSQL := strSQL + '                  AND P.CLI_CODCLI = DET_CODCLI ';

  If fTabelaExiste('CLIPRO') And fCampoExiste('CLIPRO', 'CLI_CODUNI') Then
    strSQL := strSQL + 'LEFT JOIN CADUNI UNCLI ON P.CLI_CODUNI = UNCLI.UNI_CODUNI ';

  strSQL := strSQL + 'LEFT JOIN FATGOR ON DET_NUM_PD = FGO_NUMDOC AND ';
  strSQL := strSQL + '                    DET_ESP_PD = FGO_ESPDOC AND ';
  strSQL := strSQL + '                    DET_EMP_PD = FGO_CODEMP AND ';
  strSQL := strSQL + '                    DET_CODCLI = FGO_CODCLI     ';

  If (fUtilizaExtgorNoSelect) Then
  Begin
    strSQL := strSQL + ' LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
    strSQL := strSQL + ' LEFT JOIN MOVPIX ON EXTGOR.FGO_TX_PIX = MOVPIX.MPX_TX_ID_ ';
    strSQL := strSQL + '                 AND EXTGOR.FGO_EMPPIX = MOVPIX.MPX_CODEMP ';
  End;

  If ((fConfiguracao('VENMAD') = 'S') Or
      (fConfiguracao('VENVID') = 'S') Or
      (fConfiguracao('VENMTL') = 'S')) And
       fTabelaExiste('MOVMAD') Then
    strSQL := strSQL + 'LEFT JOIN MOVMAD ON MOVMAD.DET_SEQGER = MOVDET.AUTOINCREM ';

  If objConfig.blnClaOnu Then
    strSQL := strSQL + 'LEFT JOIN CADONU ON CADITE.ITE_CODONU = CADONU.ONU_CODONU ';

  If fTabelaExiste('MOVICD') Then
  Begin
    strSQL := strSQL + 'LEFT JOIN MOVICD ON MOVICD.ICD_SEQGER = MOVDET.AUTOINCREM ';
  End;

  If fTabelaExiste('DOCEXP') Then
    strSQL := strSQL + 'LEFT JOIN DOCEXP ON DOCEXP.EXP_SEQFIS = CADFIS.AUTOINCREM ';

  if fCampoExiste('MOVDET', 'DET_CODACA') then
  begin
    strSQL := strSQL + 'LEFT JOIN CADACA ACA ON ACA.ACA_CODACA = MOVDET.DET_CODACA AND ';
    strSQL := strSQL + '                        ACA.ACA_CODEMP = MOVDET.DET_EMPACA     ';
  end;

  If fTabelaExiste('INCEFD') Then
    strSQL := strSQL + 'LEFT JOIN INCEFD ON INCEFD.EFD_SEQGER = MOVGER.AUTOINCREM ';

  strSQL := strSQL + 'WHERE ';

  If Not (strIntegradorCitel = 'S') Then
    strSQL := strSQL + '  IFNULL(FIS_HISTOR,"") <> "CANCELADO" AND ';

  strSQL := strSQL + '  IF(FIS_NFCOMP="S", TRUE, MOVGER.GER_NUMDOC IS NOT NULL) AND ';

  If fCampoExiste('CADFIS', 'FIS_DEVNES') Then
    strSQL := strSQL + '  ((IFNULL(DET_PROEMB,"N") <> "S") OR (IFNULL(DET_PROEMB,"N") = "S" AND IFNULL(FIS_DEVNES,"N") = "S")) AND '
  Else
    strSQL := strSQL + '  IFNULL(DET_PROEMB,"N") <> "S" AND ';

  strSQL := strSQL + '  FIS_TIP_FC = :TIP_FC AND ';
  strSQL := strSQL + '  FIS_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  FIS_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  FIS_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  FIS_FORCLI = :CODCLI AND ';
  strSQL := strSQL + '  IFNULL(FIS_SERIE_, "") = :SERIE_ ';

  If (Not fNotaComplemento(FNumDoc, FEspDoc, FCodEmp, FCodCli, FSerie, FTip_FC)) Then
  Begin
    strSQLNot := strSQL;
    strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVGER', 'NOTGER');
    strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVDET', 'NOTDET');
    strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVOBS', 'NOTOBS');
    strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVTRI', 'NOTTRI');
    strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVREF', 'NOTREF');
    strSQLNot := AnsiReplaceStr(strSQLNot, 'AUXMOV', 'AUXNOT');
    strSQLNot := AnsiReplaceStr(strSQLNot, 'SERMOV', 'SERNOT');
    strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVMAD', 'NOTMAD');
    strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVICD', 'NOTICD');
    strSQLNot := AnsiReplaceStr(strSQLNot, 'MOVAUX', 'NOTAUX');
    strSQLNot := AnsiReplaceStr(strSQLNot, 'GER_DTADOC', 'GER_DTAENT');
    strSQLNot := AnsiReplaceStr(strSQLNot, 'AUX_CLIORI', '"        "');
    strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_ITEABF', '""');
    strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_NUM_PD', '""');
    strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_ESP_PD', '""');
    strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_EMP_PD', '""');
    strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_IND_PD', '""');

    If fCampoExiste('NOTGER', 'GER_DUPREC') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, '0.00 AS GER_DUPREC', 'GER_DUPREC');
      strSQLNot := AnsiReplaceStr(strSQLNot, 'AUX_DUPREC AS GER_DUPREC', 'GER_DUPREC');
    End;

    If Not fCampoExiste('NOTGER', 'GER_BASORG') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strBasOrg, ' 0.00 AS GER_ICMORG ');
    End;

    If Not fCampoExiste('NOTGER', 'GER_ICMORG') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strIcmOrg, ' 0.00 AS GER_ICMORG ');
    End;

    If Not fCampoExiste('NOTTRI', 'DET_ICMORG') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, 'NOTTRI.DET_ICMORG', ' 0.00 AS DET_ICMORG ');
    End;

    If Not fCampoExiste('AUXNOT', 'AUX_BASVRD') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strBasVrd, ' 0.00 AS AUX_BASVRD ');
    End;

    If Not fCampoExiste('AUXNOT', 'AUX_VRDICM') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strVrdIcm, ' 0.00 AS AUX_VRDICM ');
    End;

    If Not fCampoExiste('AUXNOT', 'AUX_CHVNFE') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strChvNfe, ' " " AS GER_CHVNFE ');
    End;

    If Not fCampoExiste('AUXNOT', 'AUX_NUMCOO') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strNumCOO, ' " " AS GER_NUMCOO ');
    End;

    If Not fCampoExiste('AUXNOT', 'AUX_NUMSER') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strNumSer, ' " " AS GER_NUMSER ');
    End;

    If Not fCampoExiste('AUXNOT', 'AUX_NUMUSU') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strNumUSU, ' " " AS GER_NUMUSU ');
    End;

    If Not fCampoExiste('AUXNOT', 'AUX_TIPDOC') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strTipDoc, ' " " AS GER_TIPDOC ');
    End;

    If Not fCampoExiste('AUXNOT', 'AUX_EST_DV') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strEst_Dv, ' " " AS GER_EST_DV ');
    End;

    If Not fCampoExiste('AUXNOT', 'AUX_NUMERO') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strNumero, ' " " AS GER_NUMERO ');
    End;

    If Not fCampoExiste('AUXNOT', 'AUX_SERIE_') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strSerie_, ' " " AS GER_SERIE1 ');
    End;

    If Not fCampoExiste('AUXNOT', 'AUX_MODELO') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strModelo, ' " " AS GER_MODELO ');
    End;

    If Not fCampoExiste('AUXNOT', 'AUX_CPFCNP') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strCPFCNP, ' " " AS GER_CPFCNP ');
    End;

    If Not fCampoExiste('AUXNOT', 'AUX_ESTADO') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strEstado, ' " " AS GER_ESTADO ');
    End;

    If Not fCampoExiste('AUXNOT', 'AUX_MESANO') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strMesAno, ' " " AS GER_MESANO ');
    End;

    If fCampoExiste('AUXNOT', 'AUX_COMVAL') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strComVal, ' AUX_COMVAL AS GER_COMVAL ');
    End;

    If fCampoExiste('AUXNOT', 'AUX_NUMDRW') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strNumeroDrawback, ' " " AS AUX_NUMDRW ');
    End;

    If Not fCampoExiste('AUXNOT', 'AUX_EMP_TE') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strEmp_Te, ' CAST("" AS CHAR(3)) AS AUX_EMP_TE ');
    End;

    If fCampoExiste('AUXNOT', 'AUX_REGES2') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strRegEs2, 'AUX_REGES2');
    End;

   If (Not fCampoExiste('NOTDET', 'DET_DESNES')) And
      (Not fCampoExiste('NOTTRI', 'DET_DESNES')) Then
      strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_DESNES', '"" DET_DESNES');

    strSQLNot := AnsiReplaceStr(strSQLNot, 'REPEAT(" ", 20) AS DET_AUTINC, ', 'NOTDET.AUTOINCREM AS DET_AUTINC, ');

    If (Not fCampoExiste('NOTTRI', 'DET_VAEIPI')) Then
      strSQLNot := AnsiReplaceStr(strSQLNot, 'DET_VALIPI + IFNULL(NOTTRI.DET_VAEIPI,0)', '0');

    If (Not fCampoExiste('AUXNOT', 'AUX_TRARDP')) Then
    Begin
      If (Not fEmptyStr(strSelectTraRed)) Then
      Begin
        strSelectTraRed := AnsiReplaceStr(strSelectTraRed, 'AUXMOV', 'AUXNOT');
        strWhereTraRed_ := AnsiReplaceStr(strWhereTraRed_, 'AUXMOV', 'AUXNOT');

        strSQLNot := AnsiReplaceStr(strSQLNot, strSelectTraRed, ' " " AS TRA_EMAILR, ');
        strSQLNot := AnsiReplaceStr(strSQLNot, strWhereTraRed_, ' ');
      End;
    End;

    If Not fCampoExiste('AUXNOT', 'AUX_TOTSDS') Then
    Begin
      strSQLNot := AnsiReplaceStr(strSQLNot, strTotSDs, ' 0.00 AS AUX_TOTSDS ');
    End;

    If (strIntegradorCitel = 'S') Then
    Begin
      strSQL := strSQL + ' UNION ALL ' + strSQLNot;

      strSQLDel := strSQL;
      strSQLDel := AnsiReplaceStr(strSQLDel, 'MOVGER', 'DEL_MOVGER');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'SERMOV', 'DEL_SERMOV');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'MOVDET', 'DEL_MOVDET');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'MOVTRI', 'DEL_MOVTRI');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'MOVAUX', 'DEL_MOVAUX');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'NOTCOM', 'DEL_NOTCOM');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'AUXMOV', 'DEL_AUXMOV');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'MOVOBS', 'DEL_MOVOBS');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'FATGOR', 'DEL_FATGOR');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'MOVICD', 'DEL_MOVICD');

      strSQLDel := AnsiReplaceStr(strSQLDel, 'NOTGER', 'DEL_NOTGER');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'SERNOT', 'DEL_SERNOT');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'NOTDET', 'DEL_NOTDET');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'NOTTRI', 'DEL_NOTTRI');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'NOTAUX', 'DEL_NOTAUX');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'AUXNOT', 'DEL_AUXNOT');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'NOTOBS', 'DEL_NOTOBS');
      strSQLDel := AnsiReplaceStr(strSQLDel, 'NOTICD', 'DEL_NOTICD');

      strSQL := strSQL + ' UNION ALL ' + strSQLDel;
    End
    Else
    Begin
      strSQL := strSQL + ' UNION ALL ' + strSQLNot;
    End;
  End;

  strSQL := AnsiReplaceStr(strSQL, ':NUMDOC', QuotedStr(FNumDoc));
  strSQL := AnsiReplaceStr(strSQL, ':ESPDOC', QuotedStr(FEspDoc));
  strSQL := AnsiReplaceStr(strSQL, ':CODEMP', QuotedStr(FCodEmp));
  strSQL := AnsiReplaceStr(strSQL, ':CODCLI', QuotedStr(FCodCli));
  strSQL := AnsiReplaceStr(strSQL, ':TIP_FC', QuotedStr(FTip_FC));
  strSQL := AnsiReplaceStr(strSQL, ':SERIE_', QuotedStr(FSerie));

  qryDados.SQL.Clear;
  qryDados.SQL.Add(strSQL);
  qryDados.SQL.Add(fRetOrderByNota(fConfiguracao('USA_RS'), fConfiguracao('ORDALF'), 'DET_AUTOINCREM'));

  pLogImp('<qryDados.Open;>');
  pLogImp(Trim(qryDados.SQL.Text));
  qryDados.Open;
  pLogImp('</qryDados.Open;>');

  FGarantiaPropriaEmpresa := pos('GARANTIA PEDIDO REPOSICAO CLIENTE', QryDados.FieldByName('GER_MEN001').AsString) > 0;
  FDocNGComMultiplasChaves := fEhDocumentoNGMultiplasChavesRefernciada;

  FChaAce    := qryDados.FieldByName('FIS_ACESSO').AsString;
  FChaTabela := qryDados.FieldByName('CHAVE_TABELA').AsString;

  If (qryDados.IsEmpty) Then
  Begin
    pLogImp('Documento (' + FNumDoc + '-' + FEspDoc + '-' + FCodEmp + ') não encontrado. Verifique.');
    pLogImp('<Parâmetros>');
    pLogImp('NUMDOC=' + FNumDoc);
    pLogImp('ESPDOC=' + FEspDoc);
    pLogImp('CODEMP=' + FCodEmp);
    pLogImp('CODCLI=' + FCodCli);
    pLogImp('SERIE_=' + FSerie );
    pLogImp('TIP_FC=' + FTip_FC);
    pLogImp('</Parâmetros>');
    pLogImp(qryDados.SQL.Text);
    Raise Exception.Create('Documento (' + FNumDoc + '-' + FEspDoc + '-' + FCodEmp + ') não encontrado. Verifique.')
  End
  Else If fDuplicouItens(qryDados) Then
  Begin
    pLogImp(qryDados.SQL.Text);
    Raise Exception.Create('Documento (' + FNumDoc + '-' + FEspDoc + '-' + FCodEmp + ') com itens duplicados! Entre em contato com a Citel.');
  End;

  If blnDupCND Then
    pCarregaDuplicatasCND( qryDados.FieldByName('CHAVE_TABELA').AsString, qryDados.FieldByName('CHAVE_DUPLICATA').AsString );

  objConfig.pValoresDefault;
  pRetAlqPisCofins(objConfig.fltAlqPis, objConfig.fltAlqCof);
  pCarregaAtividadeConstrutora;
  pCarregaNcmObrigatorioAnvisa;
  pCarregaCfgDesFab(objConfig.blnDesFab);
  pRetClassificacoesDevolucao;
  pRetCstSimplesProdSubstituidos;
  pCarregaConfiguracoesNotaServico;
  pRetCfgImpValorIpiDadosPropriosCFOPNaoVenda;
  pCarregaEmpresaNFSe;

  {************************************}
  {* PERMITIR NOTA DE SERVICO SEM CPF *}
  {********************************JC**}
  objConfigInterna.strNFSeSemCpf := fConfiguracao('NSSCPF');

  {***********************************}
  {* TIPO DE NOTA FISCAL DE CONCRETO *}
  {********************************JC*}
  objConfigInterna.strTpNfCr := fConfiguracao('TPNFCR');

  {*************************************************************************}
  {* VERIFICA DE IRA PRATICAR O CST DE OUTRAS ENTRADAS E SAIDAS PARA O IPI *}
  {**********************************************************************JC*}
  objConfigInterna.blnCstIpiOutras := (fConfiguracao('CSTIPO') = 'S');

  {**************************************************************************}
  {* VERIFICA SE CONCATENA O CODIGO DE FABRICA JUNTO A DESCRICAO DO PRODUTO *}
  {**********************************************************************JC**}
  objConfigInterna.blnFabNfe := (fConfiguracao('FABNFE') = 'S');

  objConfigInterna.strImpIcmsOpeProprias := fConfiguracao('ICOPDI');

  objConfigInterna.blnZeraIBPT := fZeraIBPT;
  objConfigInterna.blnImpIBP := (fConfiguracao('IMPIBP') = 'S');

  pAdicionaItensNaLista;
  pAdicionaServicosNaListaDeItens(qryDados.RecordCount - fGetQuantidadeItensServico);
  pReformaTributariaTotal;

  lstItens.Pack;

  pLogImp('pCarregarDados <');
end;

procedure TFonteDadosBD.pAddInformacoesPagamentoFrete(Var ManifestoEletronico: TManifestoEletronico;
                                                          strNumMan,
                                                          strCodEmp : String);
Var
  qryMDFPAG,
  qryMDFCOM,
  qryMDFPRA : {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

  InformacoesPagamentoFrete            : TInformacoesPagamentoFrete;
  InformacoesPagamentoFreteComponentes : TInformacoesPagamentoFreteComponentes;
  InformacoesPagamentoFretePrazos      : TInformacoesPagamentoFretePrazos;

Const
  strSQLMDFPAG = 'SELECT ' +
                 '  *    ' +
                 'FROM   ' +
                 '  MDFPAG ' +
                 'WHERE    ' +
                 '  MDF_NUMMAN = :NUMMAN AND ' +
                 '  MDF_EMPMAN = :EMPMAN     ' +
                 'ORDER BY                   ' +
                 '  MDF_SEQPAG';

  strSQLMDFCOM = 'SELECT ' +
                 '  *    ' +
                 'FROM   ' +
                 '  MDFCOM ' +
                 'WHERE    ' +
                 '  MDF_NUMMAN = :NUMMAN AND ' +
                 '  MDF_EMPMAN = :EMPMAN AND ' +
                 '  MDF_SEQPAG = :SEQPAG     ' +
                 'ORDER BY                   ' +
                 '  MDF_SEQCOM';

  strSQLMDFPRA = 'SELECT ' +
                 '  *    ' +
                 'FROM   ' +
                 '  MDFPRA ' +
                 'WHERE    ' +
                 '  MDF_NUMMAN = :NUMMAN AND ' +
                 '  MDF_EMPMAN = :EMPMAN AND ' +
                 '  MDF_SEQPAG = :SEQPAG     ' +
                 'ORDER BY                   ' +
                 '  MDF_SEQPRA, MDF_NUMPAR';

begin

  If Not fEmptyStr(strNumMan) And Not fEmptyStr(strCodEmp) then
  Begin

    qryMDFPAG := fCriaQuery(Nil);
    qryMDFCOM := fCriaQuery(Nil);
    qryMDFPRA := fCriaQuery(Nil);

    Try

      {Informações do Pagamento do Frete}
      qryMDFPAG.Close;
      qryMDFPAG.SQL.Clear;
      qryMDFPAG.SQL.Add(strSQLMDFPAG);
      qryMDFPAG.ParamByName('NUMMAN').AsString := strNumMan;
      qryMDFPAG.ParamByName('EMPMAN').AsString := strCodEmp;
      qryMDFPAG.Open;

      qryMDFPAG.First;
      While Not qryMDFPAG.Eof Do
      Begin

        InformacoesPagamentoFrete := TInformacoesPagamentoFrete.create;
        InformacoesPagamentoFrete.intSeqInfPagFrete  := qryMDFPAG.FieldByName('MDF_SEQPAG').AsInteger;
        InformacoesPagamentoFrete.strNomeResponsavel := qryMDFPAG.FieldByName('MDF_NOMRES').AsString;
        InformacoesPagamentoFrete.strCPF_CNPJ        := qryMDFPAG.FieldByName('MDF_CPFCNP').AsString;
        InformacoesPagamentoFrete.strIDEstrangeiro   := qryMDFPAG.FieldByName('MDF_ESTRAN').AsString;
        InformacoesPagamentoFrete.fltValorTotal      := qryMDFPAG.FieldByName('MDF_VALTOT').AsFloat;
        InformacoesPagamentoFrete.intFormaPagamento  := qryMDFPAG.FieldByName('MDF_FORPAG').AsInteger;
        InformacoesPagamentoFrete.strNumeroBanco     := qryMDFPAG.FieldByName('MDF_NUMBAN').AsString;
        InformacoesPagamentoFrete.strNumeroAgencia   := qryMDFPAG.FieldByName('MDF_NUMAGE').AsString;
        InformacoesPagamentoFrete.strCNPJPagamento   := qryMDFPAG.FieldByName('MDF_CNPJPG').AsString;
        if (Assigned(qryMDFPAG.FindField('MDF_CHAPIX'))) then
          InformacoesPagamentoFrete.strChavePix      := qryMDFPAG.FieldByName('MDF_CHAPIX').AsString;
        if (Assigned(qryMDFPAG.FindField('MDF_VALADI'))) then
          InformacoesPagamentoFrete.fltValorAdiantam := qryMDFPAG.FieldByName('MDF_VALADI').AsFloat;

        ManifestoEletronico.pAddInfPagFretePag(InformacoesPagamentoFrete);

        {Componentes}
        qryMDFCOM.Close;
        qryMDFCOM.SQL.Clear;
        qryMDFCOM.SQL.Add(strSQLMDFCOM);
        qryMDFCOM.ParamByName('NUMMAN').AsString := strNumMan;
        qryMDFCOM.ParamByName('EMPMAN').AsString := strCodEmp;
        qryMDFCOM.ParamByName('SEQPAG').AsString := qryMDFPAG.FieldByName('MDF_SEQPAG').AsString;
        qryMDFCOM.Open;

        qryMDFCOM.First;
        While Not qryMDFCOM.Eof Do
        Begin
          InformacoesPagamentoFreteComponentes := TInformacoesPagamentoFreteComponentes.create;
          InformacoesPagamentoFreteComponentes.intSeqInfPagFrete      := qryMDFCOM.FieldByName('MDF_SEQPAG').AsInteger;
          InformacoesPagamentoFreteComponentes.intSeqInfPagFreteCom   := qryMDFCOM.FieldByName('MDF_SEQCOM').AsInteger;
          InformacoesPagamentoFreteComponentes.strTipoComponente      := qryMDFCOM.FieldByName('MDF_TIPCOM').AsString;
          InformacoesPagamentoFreteComponentes.fltValorComponente     := qryMDFCOM.FieldByName('MDF_VALCOM').AsFloat;
          InformacoesPagamentoFreteComponentes.strDescricaoComponente := qryMDFCOM.FieldByName('MDF_DESCOM').AsString;
          ManifestoEletronico.pAddInfPagFreteCom(InformacoesPagamentoFreteComponentes);
          qryMDFCOM.Next;
        End;

        {Prazos}
        qryMDFPRA.Close;
        qryMDFPRA.SQL.Clear;
        qryMDFPRA.SQL.Add(strSQLMDFPRA);
        qryMDFPRA.ParamByName('NUMMAN').AsString := strNumMan;
        qryMDFPRA.ParamByName('EMPMAN').AsString := strCodEmp;
        qryMDFPRA.ParamByName('SEQPAG').AsString := qryMDFPAG.FieldByName('MDF_SEQPAG').AsString;
        qryMDFPRA.Open;

        qryMDFPRA.First;
        While Not qryMDFPRA.Eof Do
        Begin
          InformacoesPagamentoFretePrazos := TInformacoesPagamentoFretePrazos.create;
          InformacoesPagamentoFretePrazos.intSeqInfPagFrete    := qryMDFPRA.FieldByName('MDF_SEQPAG').AsInteger;
          InformacoesPagamentoFretePrazos.intSeqInfPagFretePra := qryMDFPRA.FieldByName('MDF_SEQPRA').AsInteger;
          InformacoesPagamentoFretePrazos.intNumeroParcela     := qryMDFPRA.FieldByName('MDF_NUMPAR').AsInteger;
          InformacoesPagamentoFretePrazos.strDataVencimento    := qryMDFPRA.FieldByName('MDF_DTAVEN').AsString;
          InformacoesPagamentoFretePrazos.fltValorParcela      := qryMDFPRA.FieldByName('MDF_VALPAR').AsFloat;
          ManifestoEletronico.pAddInfPagFretePra(InformacoesPagamentoFretePrazos);
          qryMDFPRA.Next;
        End;

        {Próximo}
        qryMDFPAG.Next;

      End;

    Finally
      FreeAndNil(qryMDFPAG);
      FreeAndNil(qryMDFCOM);
      FreeAndNil(qryMDFPRA);
    End;

  End;

end;

procedure TFonteDadosBD.pAdicionaFormaPagamentoPoisDocumentoNaoTemMovMod(
  dadosGerais: TDadosGerais);
begin
  SetLength(dadosGerais.arrFormasPagamento, 1);
  dadosGerais.arrFormasPagamento[0] := TFormaPagamento.Create;
  dadosGerais.arrFormasPagamento[0].strCodigo := '01';
  dadosGerais.arrFormasPagamento[0].fltValor := dadosGerais.fltTotGer;
end;

procedure TFonteDadosBD.pAdicionaItensNaLista;
begin
  qryDados.First;
  While (Not qryDados.Eof) Do
  Begin
    If (Pos(qryDados.FieldByName('DET_CLAFIS').AsString, '5933_6933_') <= 0) Or
       (fNotaServicoEletronicaConcreto)                                      Then
    Begin
      fAdicionaItem(qryDados.RecNo-1, 0);
    End;

    qryDados.Next;
  End;
end;

procedure TFonteDadosBD.pAdicionaServicosNaListaDeItens(intIndInicial: Integer);
  Var
    intContador: Integer;
begin
  If intIndInicial <= 0 Then
    intIndInicial := 0;

  If Not fEmptyStr(qryDados.FieldByName('GER_DESS01').AsString) And (qryDados.FieldByName('GER_TOTSER').AsFloat > 0) Then
  Begin
    For intContador := 1 To 30 Do
    Begin
      If qryDados.Fields.FindField('GER_DESS' + untUtil.fStrZero(intContador, 2)) = Nil Then
        Continue;

      If Not fEmptyStr(qryDados.FieldByName('GER_DESS' + untUtil.fStrZero(intContador, 2)).AsString) Then
        fAdicionaItem(intIndInicial+intContador-1, intContador);
    End;
  end;
end;

function TFonteDadosBD.fGetQuantidadeItensServico: Integer;
begin
  Result := 0;
  qryDados.First;
  While (Not qryDados.Eof) Do
  Begin
    If (Pos(qryDados.FieldByName('DET_CLAFIS').AsString, '5933_6933_') > 0) And
       (Not fNotaServicoEletronicaConcreto)                                 Then
    Begin
      Inc(Result);
    End;
    qryDados.Next;
  End;
end;

function TFonteDadosBD.fGetSQLConhecimento(blnExistePARCTE: Boolean; blnConsulta: Boolean=False): string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  CC.CID_COIBGE AS CODIBGE_INICIO, ';
  Result := Result + '  IFNULL(CCC.CID_COIBGE, CDC.CID_COIBGE) AS CODIBGE_TERMINO, ';
  Result := Result + '  EC.EMP_C_G_C_ AS REMETENTE_CNPJ, ';
  Result := Result + '  IF(IFNULL(EC.EMP_I_E_S_, "") = "", "ISENTO", EC.EMP_I_E_S_) AS REMETENTE_IE, ';
  Result := Result + '  EC.EMP_NOMEMP AS REMETENTE_RAZAOSOCIAL, ';
  Result := Result + '  EC.EMP_NOMFAN AS REMETENTE_FANTASIA, ';
  Result := Result + '  EC.EMP_FONE01 AS REMETENTE_TELEFONE, ';
  Result := Result + '  EC.EMP_ENDERE AS REMETENTE_ENDERECO, ';
  Result := Result + '  EC.EMP_ENDNUM AS REMETENTE_NUMERO, ';
  Result := Result + '  IFNULL(EC.EMP_ENDCMP, "") AS REMETENTE_COMPLEMENTO, ';
  Result := Result + '  EC.EMP_BAIRRO AS REMETENTE_BAIRRO, ';
  Result := Result + '  EC.EMP_C_E_P_ AS REMETENTE_CEP, ';
  Result := Result + '  IFNULL(EC.EMP_EMAIL_, "") AS REMETENTE_EMAIL, ';
  Result := Result + '  CLI_C_G_C_ AS CLIENTE_CNPJ, ';
  Result := Result + '  IF(CLI_CGCCPF = 2, "", IFNULL(CLI_I_E_S_, "")) AS CLIENTE_IE, ';
  Result := Result + '  CLI_NOMCLI AS CLIENTE_RAZAOSOCIAL, ';
  Result := Result + '   "" AS CLIENTE_FANTASIA, ';
  Result := Result + '  CLI_TELENT AS CLIENTE_TELEFONE, ';
  Result := Result + '  CLI_ENDERE AS CLIENTE_ENDERECO, ';
  Result := Result + '  IF(IFNULL(CLI_ENDNUM, "") = "", "0", CLI_ENDNUM) AS CLIENTE_NUMERO, ';
  Result := Result + '  CLI_ENDCOM AS CLIENTE_COMPLEMENTO, ';
  Result := Result + '  CLI_BAIRRO AS CLIENTE_BAIRRO, ';
  Result := Result + '  CLI_C_E_P_ AS CLIENTE_CEP, ';
  Result := Result + '  "" AS CLIENTE_EMAIL, ';
  Result := Result + '  CDC.CID_COIBGE AS CLIENTE_CODIBGE, ';
  Result := Result + '  CTE_CODEMP, ';
  Result := Result + '  CTE_EMPCLI, ';
  Result := Result + '  CTE_NUMCTE, ';
  Result := Result + '  CTE_DTAEMI, ';
  Result := Result + '  CTE_CFOP__, ';
  Result := Result + '  CTE_NATOPE, ';
  Result := Result + '  CTE_SERIE_, ';
  Result := Result + '  CTE_TOMSER, ';
  Result := Result + '  CTE_PAPTOM, ';

  if fCampoExiste('MOVCTE', 'CTE_CSTREF') then
    Result := Result + '  CTE_CSTREF, '
  else
    Result := Result + '  "" AS CTE_CSTREF, ';

  if fCampoExiste('MOVCTE', 'CTE_CLAREF') then
    Result := Result + '  CTE_CLAREF, '
  else
    Result := Result + '  "" AS CTE_CLAREF, ';

  if fCampoExiste('MOVCTE', 'CTE_BASREF') then
    Result := Result + '  CTE_BASREF, '
  else
    Result := Result + '  0 AS CTE_BASREF, ';

  if fCampoExiste('MOVCTE', 'CTE_CBS_AL') then
    Result := Result + '  CTE_CBS_AL, '
  else
    Result := Result + '  0 AS CTE_CBS_AL, ';

  if fCampoExiste('MOVCTE', 'CTE_IBS_UF') then
    Result := Result + '  CTE_IBS_UF, '
  else
    Result := Result + '  0 AS CTE_IBS_UF, ';

  if fCampoExiste('MOVCTE', 'CTE_IBS_MN') then
    Result := Result + '  CTE_IBS_MN, '
  else
    Result := Result + '  0 AS CTE_IBS_MN, ';

  if fCampoExiste('MOVCTE', 'CTE_CBSVAL') then
    Result := Result + '  CTE_CBSVAL, '
  else
    Result := Result + '  0 AS CTE_CBSVAL, ';

  if fCampoExiste('MOVCTE', 'CTE_IBSUFV') then
    Result := Result + '  CTE_IBSUFV, '
  else
    Result := Result + '  0 AS CTE_IBSUFV, ';

  if fCampoExiste('MOVCTE', 'CTE_IBSMNV') then
    Result := Result + '  CTE_IBSMNV, '
  else
    Result := Result + '  0 AS CTE_IBSMNV, ';

  Result := Result + '  CTE_CLATRI, ';
  Result := Result + '  CTE_PERRBC, ';
  if fCampoExiste('MOVCTE', 'CTE_VLRFRE') then
    Result := Result + '  CTE_VLRFRE, '
  else
    Result := Result + '  CTE_VLRBCI AS CTE_VLRFRE, ';
  Result := Result + '  CTE_VLRBCI, ';
  Result := Result + '  CTE_ALIQUO, ';
  Result := Result + '  CTE_VLRIMP, ';
  Result := Result + '  CTE_VLRCRE, ';
  Result := Result + '  CTE_PROPRE, ';
  Result := Result + '  CTE_DESSER, ';
  Result := Result + '  CTE_QTDCAR, ';
  Result := Result + '  CTE_RNTRC_, ';
  Result := Result + '  GER_TOTFRE, ';
  Result := Result + '  GER_PESBRU, ';
  Result := Result + '  GER_PESLIQ, ';
  Result := Result + '  GER_VLRCON, ';
  Result := Result + '  GER_TOTPRO, ';
  Result := Result + '  FIS_ACESSO ';
  if blnExistePARCTE then
  begin
    Result := Result + ',  PAR_SEQGER, ';
    Result := Result + '  PAR_BCIUFD, ';
    Result := Result + '  PAR_AIIUFD, ';
    Result := Result + '  PAR_AICMSI, ';
    Result := Result + '  PAR_ICMSPT, ';
    Result := Result + '  PAR_ICMSPI, ';
    Result := Result + '  PAR_ALQFCP, ';
    Result := Result + '  PAR_VLRFCP ';
  end;
  Result := Result + 'FROM ';
  Result := Result + '  MOVCTE ';
  if blnExistePARCTE then
    Result := Result + '  LEFT JOIN PARCTE ON MOVCTE.AUTOINCREM = PAR_SEQGER ';
  Result := Result + '  JOIN CADEMP EC ON CTE_EMPCLI = EC.EMP_CODEMP ';
  Result := Result + '  JOIN CADCID CC ON EC.EMP_CODCID = CC.CID_CODCID ';
  Result := Result + '  JOIN MOVGER ON CTE_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result + '  JOIN CADCLI ON GER_CODCLI = CLI_CODCLI ';
  Result := Result + '  LEFT JOIN CADCID CDC ON CLI_CODCID = CDC.CID_CODCID ';
  Result := Result + '  JOIN AUXMOV ON MOVGER.AUTOINCREM = AUX_SEQGER ';
  Result := Result + '  LEFT JOIN ENTCLI ON AUX_ENTGER = ENTCLI.AUTOINCREM ';
  Result := Result + '  LEFT JOIN CADCID CCC ON ETC_CIDENT = CCC.CID_CODCID ';
  Result := Result + '  JOIN CADFIS ON GER_NUMDOC = FIS_NUMDOC ';
  Result := Result + '             AND GER_ESPDOC = FIS_ESPDOC ';
  Result := Result + '             AND GER_SERIE_ = FIS_SERIE_ ';
  Result := Result + '             AND GER_CODEMP = FIS_CODEMP ';
  Result := Result + '             AND GER_CODCLI = FIS_FORCLI ';
  Result := Result + 'WHERE ';
  Result := Result + '  CTE_NUMCTE = :NUMCTE ';
  Result := Result + '  AND CTE_CODEMP = :CODEMP ';

  If not blnConsulta Then
  Begin
    Result := Result + '  AND IFNULL(CTE_ACESSO, "") = "" ';
    Result := Result + '  AND IFNULL(FIS_ACESSO, "") <> "" ';
  End;

end;

procedure TFonteDadosBD.pCarregaDadosModalidades(dadosGerais: TDadosGerais; const blnUsarMovCar: Boolean; qryModalidades: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
  Var
    strSQL : String;
    strFpgAux: String;
begin
  strFpgAux := fConfiguracao('FPGAUX');
  strFpgAux := IIF(fEmptyStr(strFpgAux),'05',strFpgAux);

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CASE MOD_CODMOD ';
  strSQL := strSQL + '       WHEN "001" THEN "01" ';
  strSQL := strSQL + '       WHEN "002" THEN "02" ';
  strSQL := strSQL + '       WHEN "006" THEN "02" ';
  strSQL := strSQL + '       WHEN "012" THEN "16" ';

  If (blnUsarMovCar) Then
  Begin
    If fCampoExiste('MOVMOD', 'MOD_TIPCAR') Then
      strSQL := strSQL + '   WHEN "007" THEN IF(((MOD_TIPCAR IS NULL) OR (MOD_TIPCAR = "")), IF(CAR_TIPCAR IS NULL, '+ QuotedStr(strFpgAux) +' , IF(CAR_TIPCAR="C", "03", "04")), IF(MOD_TIPCAR="C","03","04"))'
    Else
      strSQL := strSQL + '   WHEN "007" THEN IF(CAR_TIPCAR IS NULL, '+ QuotedStr(strFpgAux) +' , IF(CAR_TIPCAR="C", "03", "04")) ';
  End
  Else
  Begin
    If fCampoExiste('MOVMOD', 'MOD_TIPCAR') Then
      strSQL := strSQL + '   WHEN "007" THEN IF(((MOD_TIPCAR IS NULL) OR (MOD_TIPCAR = "")), '+ QuotedStr(strFpgAux) +' , IF(MOD_TIPCAR="C","03","04"))'
    Else
      strSQL := strSQL + '   WHEN "007" THEN ' + QuotedStr(strFpgAux) + ' ';
  End;

  If (Not fEhCupomEletronicoSAT(dadosGerais)) Then
    strSQL := strSQL + '     WHEN "008" THEN "15" ';

  strSQL := strSQL + '    ELSE '+ QuotedStr(strFpgAux);
  strSQL := strSQL + '  END AS CODMOD, ';
  strSQL := strSQL + '  MOD_CODMOD, ';

  If (blnUsarMovCar) Then
  Begin
    If fCampoExiste('MOVCAR', 'MCA_PIXS_N') Then
      strSQL := strSQL + '  MCA_PIXS_N AS PIXS_N, '
    Else
      strSQL := strSQL + '  "N" AS PIXS_N, ';
  End
  Else
  Begin
    If fCampoExiste('MOVMOD', 'MOD_PIXS_N') Then
      strSQL := strSQL + '  MOD_PIXS_N AS PIXS_N, '
    Else
      strSQL := strSQL + '  "N" AS PIXS_N, ';
  End;

  If fCampoExiste('MOVMOD', 'MOD_VALPAG') Then
    strSQL := strSQL + '  SUM(MOD_VALPAG) AS VALPAG, ';

  If (blnUsarMovCar) Then
  Begin
    If (fCampoExiste('CADCAR', 'CAR_CODRED')) Then
      strSQL := strSQL + '  CAR_CODRED AS CODRED, '
    Else
      strSQL := strSQL + '  CAST("" AS CHAR(1)) AS CODRED, ';
  End
  Else
  Begin
    If fCampoExiste('MOVMOD', 'MOD_CODRED') then
      strSQL := strSQL + '  MOD_CODRED AS CODRED, '
    Else
      strSQL := strSQL + '  CAST("" AS CHAR(1)) AS CODRED, ';
  End;

  If (blnUsarMovCar) Then
    strSQL := strSQL + '  MOVCAR.AUTOINCREM, ';

  strSQL := strSQL + '  SUM(MOD_VALMOD) AS VALMOD ';
  strSQL := strSQL + ' FROM MOVMOD ';

  If (blnUsarMovCar) Then
  Begin
    strSQL := strSQL + ' LEFT JOIN MOVCAR ON ((MCA_DOCUME LIKE :DOCUME) OR (MCA_HIST02 LIKE :DOCUME)) ';
    strSQL := strSQL + '                 AND MCA_PARCEL = "A" ';
    strSQL := strSQL + '                 AND MOD_CODMOD = "007" ';
    strSQL := strSQL + ' LEFT JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR ';
  End;

  strSQL := strSQL + ' WHERE MOD_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '   AND MOD_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '   AND MOD_CODEMP = :CODEMP ';
  strSQL := strSQL + '   AND MOD_CODCLI = :CODCLI ';
  strSQL := strSQL + '   AND MOD_SERIE_ = :SERIE_ ';

  If (fConfiguracao('PGPIXL') = 'S') Then
    strSQL := strSQL + ' GROUP BY IF(MOD_CODMOD = "012", MOVMOD.AUTOINCREM, MOD_CODMOD) '
  Else
    strSQL := strSQL + ' GROUP BY MOD_CODMOD ';

  qryModalidades.Close;
  qryModalidades.SQL.Clear;
  qryModalidades.SQL.Add(strSQL);
  qryModalidades.ParamByName('NUMDOC').AsString := dadosGerais.strNumDoc;
  qryModalidades.ParamByName('ESPDOC').AsString := dadosGerais.strEspDoc;
  qryModalidades.ParamByName('CODEMP').AsString := dadosGerais.strCodEmp;
  qryModalidades.ParamByName('CODCLI').AsString := dadosGerais.strCodCli;
  qryModalidades.ParamByName('SERIE_').AsString := dadosGerais.strSerie;
  If (blnUsarMovCar) Then
    qryModalidades.ParamByName('DOCUME').AsString := fRetornarModDocumento(dadosGerais);
  qryModalidades.Open;
end;

function TFonteDadosBD.fGetSqlManifestoCTe: String;
var
  blnTemCarPos : Boolean;
  blnEstMan : Boolean;
begin
  blnTemCarPos := fCampoExiste('CADFIS', 'FIS_CARPOS');
  blnEstMan := fCampoExiste('CADFIS', 'FIS_ESTMAN');

  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  FIS_DTAMAN AS DTAMAN, ';
  Result := Result + '  FIS_ACESSO AS ACESSO, ';

  if blnTemCarPos then
  begin
    Result := Result + '  IFNULL(FIS_CARPOS, "N") AS CARPOS, ';
  end
  else
  begin
    Result := Result + '  "N" AS CARPOS, ';
  end;

  Result := Result + '  GER_VLRCON AS VLRCON, ';
  Result := Result + '  GER_PESBRU AS PESBRU, ';
  Result := Result + '  MOT_CPFMOT AS CPFMOT, ';
  Result := Result + '  MOT_NOMMOT AS NOMMOT, ';
  Result := Result + '  CID_COIBGE AS COIBGE, ';

  If fCampoExiste('CADFIS', 'FIS_EMPMAN') Then
    Result := Result + ' FIS_EMPMAN AS EMPMAN, '
  Else
    Result := Result + ' "" AS EMPMAN, ';

  Result := Result + '  FIS_PLAMAN AS PLAMAN, ';
  if fCampoExiste('CADFIS', 'FIS_PLAMA2') then
    Result := Result + '  FIS_PLAMA2 AS PLAMA2, ';

  if fCampoExiste('CADFIS', 'FIS_PLAMA3') then
    Result := Result + '  FIS_PLAMA3 AS PLAMA3, ';

  if fCampoExiste('CADFIS', 'FIS_PLAMA4') then
    Result := Result + '  FIS_PLAMA4 AS PLAMA4, ';

  If (blnEstMan) Then
    Result := Result + '  FIS_ESTMAN AS ESTADO, '
  Else
    Result := Result + '  FIS_ESTADO AS ESTADO, ';

  If fCampoExiste('CADFIS', 'FIS_PERCUR') Then
    Result := Result + ' FIS_PERCUR AS PERCUR, '
  Else
    Result := Result + ' "" AS PERCUR, ';

  Result := Result + '  CADFIS.AUTOINCREM AS AUTOINCREM, ';
  Result := Result + '  CLI_C_G_C_ AS CNPJ_CPF_TOMADOR, ';
  Result := Result + '  CLI_NOMCLI AS NOME_TOMADOR ';

  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';
  Result := Result + '  LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI AND FIS_TIP_FC = "C" ';
  Result := Result + '  JOIN MOVCTE ON FIS_NUMDOC = CONCAT("000", CTE_NUMCTE) ';
  Result := Result + '             AND FIS_CODEMP = CTE_CODEMP ';
  Result := Result + '  JOIN MOVGER ON CTE_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result + '  LEFT JOIN CADMOT ON MOT_CODMOT = FIS_MOTMAN ';

  If (blnEstMan) And (fTabelaExiste('AUXMOV')) And (fTabelaExiste('ENTCLI')) Then
  Begin
    Result := Result + ' LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ';
    Result := Result + ' LEFT JOIN ENTCLI ON AUXMOV.AUX_ENTGER = ENTCLI.AUTOINCREM ';
    Result := Result + '                 AND ENTCLI.ETC_CODCLI = IFNULL(GER_CODCLI, NULL) ';
    Result := Result + ' JOIN CADCID ON CID_CODCID = IFNULL(ETC_CIDENT, CLI_CODCID) ';
  End
  Else
    Result := Result + '  JOIN CADCID ON CID_CODCID = CLI_CODCID ';

  Result := Result + 'WHERE ';
  Result := Result + '  FIS_ESPDOC = "CT" AND ';
  If fCampoExiste('CADFIS', 'FIS_EMPMAN') Then
    Result := Result + '  FIS_EMPMAN = :CODEMP AND '
  else
    Result := Result + '  FIS_CODEMP = :CODEMP AND ';
  Result := Result + '  FIS_NUMMAN = :NUMMAN ';

  Result := Result + 'UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(Result, 'MOVGER', 'NOTGER'), 'MOVCTE', 'NOTCTE');
end;

function TFonteDadosBD.fGetSqlManifestoNFe: String;
var
  blnTemCidOri : Boolean;
  blnTemCidDes : Boolean;
  blnTemCarPos : Boolean;
  blnEstMan    : Boolean;
begin

  blnTemCidOri := fCampoExiste('CADFIS', 'FIS_CIDORI');
  blnTemCidDes := fCampoExiste('CADFIS', 'FIS_CIDDES');
  blnTemCarPos := fCampoExiste('CADFIS', 'FIS_CARPOS');
  blnEstMan    := fCampoExiste('CADFIS', 'FIS_ESTMAN');

  Result := '';
  Result := Result + 'SELECT ';

  If (blnTemCidOri) Then
  Begin
    Result := Result + '  (CADFIS.FIS_CIDORI) AS CIDADE_CARREGAMENTO, ';
    Result := Result + '  (SELECT C.CID_NOMCID FROM CADCID C WHERE C.CID_CODCID = CADFIS.FIS_CIDORI) AS NOMCID_CARREGAMENTO, ';
    Result := Result + '  (SELECT C.CID_ESTADO FROM CADCID C WHERE C.CID_CODCID = CADFIS.FIS_CIDORI) AS ESTADO_CARREGAMENTO, ';
    Result := Result + '  (SELECT C.CID_COIBGE FROM CADCID C WHERE C.CID_CODCID = CADFIS.FIS_CIDORI) AS COIBGE_CARREGAMENTO, ';
  End;

  If (blnTemCidDes) Then
  Begin
    Result := Result + '  (CADFIS.FIS_CIDDES) AS CIDADE_DESCARREGAMENTO, ';
    Result := Result + '  (SELECT C.CID_ESTADO FROM CADCID C WHERE C.CID_CODCID = CADFIS.FIS_CIDDES) AS ESTADO_DESCARREGAMENTO, ';
    Result := Result + '  (SELECT C.CID_COIBGE FROM CADCID C WHERE C.CID_CODCID = CADFIS.FIS_CIDDES) AS COIBGE_DESCARREGAMENTO, ';
  End;

  Result := Result + '  FIS_DTAMAN AS DTAMAN, ';
  Result := Result + '  FIS_ACESSO AS ACESSO, ';

  if blnTemCarPos then
  begin
    Result := Result + '  IFNULL(FIS_CARPOS, "N") AS CARPOS, ';
  end
  else
  begin
    Result := Result + '  "N" AS CARPOS, ';
  end;

  Result := Result + '  GER_VLRCON AS VLRCON, ';
  Result := Result + '  GER_PESBRU AS PESBRU, ';
  Result := Result + '  MOT_CPFMOT AS CPFMOT, ';
  Result := Result + '  MOT_NOMMOT AS NOMMOT, ';
  Result := Result + '  CID_COIBGE AS COIBGE, ';

  If fCampoExiste('CADFIS', 'FIS_EMPMAN') Then
    Result := Result + ' FIS_EMPMAN AS EMPMAN, '
  Else
    Result := Result + ' "" AS EMPMAN, ';

  Result := Result + '  FIS_PLAMAN AS PLAMAN, ';
  if fCampoExiste('CADFIS', 'FIS_PLAMA2') then
    Result := Result + '  FIS_PLAMA2 AS PLAMA2, ';

  if fCampoExiste('CADFIS', 'FIS_PLAMA3') then
    Result := Result + '  FIS_PLAMA3 AS PLAMA3, ';

  if fCampoExiste('CADFIS', 'FIS_PLAMA4') then
    Result := Result + '  FIS_PLAMA4 AS PLAMA4, ';

  If (blnEstMan) Then
    Result := Result + '  FIS_ESTMAN AS ESTADO, '
  Else
    Result := Result + '  FIS_ESTADO AS ESTADO, ';

  If fCampoExiste('CADFIS', 'FIS_PERCUR') Then
    Result := Result + ' FIS_PERCUR AS PERCUR, '
  Else
    Result := Result + ' "" AS PERCUR, ';

  If fCampoExiste('CADFIS', 'FIS_PREVIA') Then
    Result := Result + ' FIS_PREVIA AS PREVISAO_VIAGEM, '
  Else
    Result := Result + ' "" AS PREVISAO_VIAGEM, ';

  Result := Result + '  CADFIS.AUTOINCREM AS AUTOINCREM ';

  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';
  Result := Result + '  JOIN CADEMP ON EMP_CODEMP = FIS_CODEMP ';
  Result := Result + '  LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI AND FIS_TIP_FC = "C" ';
  Result := Result + '  LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI AND FIS_TIP_FC = "F" ';
  Result := Result + '  JOIN MOVGER ON GER_NUMDOC = FIS_NUMDOC AND ';
  Result := Result + '                 GER_ESPDOC = FIS_ESPDOC AND ';
  Result := Result + '                 GER_SERIE_ = FIS_SERIE_ AND ';
  Result := Result + '                 GER_CODEMP = FIS_CODEMP AND ';
  Result := Result + '                 GER_TIP_FC = FIS_TIP_FC AND ';
  Result := Result + '                 IFNULL(GER_CODCLI, FOR_CODFOR) = FIS_FORCLI ';
  Result := Result + '  LEFT JOIN CADMOT ON MOT_CODMOT = FIS_MOTMAN ';

  If (blnEstMan) And (fTabelaExiste('AUXMOV')) And (fTabelaExiste('ENTCLI')) Then
  Begin
    Result := Result + ' LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ';
    Result := Result + ' LEFT JOIN ENTCLI ON AUXMOV.AUX_ENTGER = ENTCLI.AUTOINCREM ';
    Result := Result + '                 AND ENTCLI.ETC_CODCLI = IFNULL(GER_CODCLI, NULL) ';

    If fCampoExiste('AUXMOV', 'AUX_VENPRE') Then
      Result := Result + ' JOIN CADCID ON CID_CODCID = IF((IFNULL(AUX_VENPRE, "") = "S") AND (IFNULL(AUX_ENTGER, "") = ""), EMP_CODCID, IFNULL(ETC_CIDENT, IFNULL(CLI_CODCID, FOR_CODCID))) '
    Else
      Result := Result + ' JOIN CADCID ON CID_CODCID = IFNULL(ETC_CIDENT, IFNULL(CLI_CODCID, FOR_CODCID)) ';
  End
  Else
    Result := Result + '  JOIN CADCID ON CID_CODCID = IFNULL(CLI_CODCID, FOR_CODCID) ';

  Result := Result + 'WHERE ';
  Result := Result + '  FIS_ESPDOC IN ("NF", "EL") AND ';

  Result := Result + '  (((FIS_CLFSC1 > "5000" AND FIS_ORIDOC = "V") OR ((LOCATE(FIS_CLFSC1,'+QuotedStr(objConfig.strClaDev)+') > 0)AND ((FIS_ORIDOC = "V") OR (FIS_ORIDOC = "D")))) OR ((FIS_DTAENT IS NOT NULL) AND ((IFNULL(FIS_ORIDOC, "") = "") OR (FIS_ORIDOC = "C")))) AND ';
  If fCampoExiste('CADFIS', 'FIS_EMPMAN') Then
    Result := Result + '  FIS_EMPMAN = :CODEMP AND '
  else
    Result := Result + '  FIS_CODEMP = :CODEMP AND ';
  Result := Result + '  FIS_NUMMAN = :NUMMAN ';

  Result := Result + 'UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(Result, 'MOVGER', 'NOTGER'), 'AUXMOV' , 'AUXNOT');
end;

procedure TFonteDadosBD.pAtualizaDataDeAutorizacao(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli: String);
Var
  qryUpdTmp : {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strComando: string;
  blnInTransaction: Boolean;
begin
  If not (strEspDoc = 'NS') Then
    Exit;

  If not (fConfiguracao('NFSDTA') = '2') Then
    Exit;

  pLogImp('pAtualizaDataDeAutorizacao >');

  blnInTransaction := Database.InTransaction;

  if not blnInTransaction then
    Database.StartTransaction;

  qryUpdTmp := fCriaQuery(Nil);

  Try
    Try
      qryUpdTmp.Close;
      qryUpdTmp.SQL.Clear;
      qryUpdTmp.SQL.Add('UPDATE CADFIS SET FIS_DTAENT = :DTAENT WHERE FIS_NUMDOC = :NUMDOC AND FIS_ESPDOC = :ESPDOC AND FIS_CODEMP = :CODEMP AND FIS_FORCLI = :FORCLI AND FIS_TIP_FC = "C" ');
      qryUpdTmp.ParamByName('NUMDOC').AsString := strNumDoc;
      qryUpdTmp.ParamByName('ESPDOC').AsString := strEspDoc;
      qryUpdTmp.ParamByName('CODEMP').AsString := strCodEmp;
      qryUpdTmp.ParamByName('FORCLI').AsString := strCodCli;
      qryUpdTmp.ParamByName('DTAENT').AsDateTime := nOw();
      qryUpdTmp.ExecSQL;

      strComando := qryUpdTmp.SQL.Text;
      strComando := AnsiReplaceStr(strComando, ':NUMDOC', QuotedStr(strNumDoc));
      strComando := AnsiReplaceStr(strComando, ':ESPDOC', QuotedStr(strEspDoc));
      strComando := AnsiReplaceStr(strComando, ':CODEMP', QuotedStr(strCodEmp));
      strComando := AnsiReplaceStr(strComando, ':FORCLI', QuotedStr(strCodCli));
      strComando := AnsiReplaceStr(strComando, ':DTAENT', QuotedStr(FormatDateTime('yyyy-mm-dd', nOw())));
      strComando := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strComando, #13#10, ' '), #10, ' '), #13, ' ');

      pGravaLogRep(strComando, 'CADFIS', 'N');

      qryUpdTmp.Close;
      qryUpdTmp.SQL.Clear;
      qryUpdTmp.SQL.Add('UPDATE MOVGER SET GER_DTAENT = :DTAENT WHERE GER_NUMDOC = :NUMDOC AND GER_ESPDOC = :ESPDOC AND GER_CODEMP = :CODEMP AND GER_CODCLI = :CODCLI ');
      qryUpdTmp.ParamByName('NUMDOC').AsString := strNumDoc;
      qryUpdTmp.ParamByName('ESPDOC').AsString := strEspDoc;
      qryUpdTmp.ParamByName('CODEMP').AsString := strCodEmp;
      qryUpdTmp.ParamByName('CODCLI').AsString := strCodCli;
      qryUpdTmp.ParamByName('DTAENT').AsDateTime := nOw();
      qryUpdTmp.ExecSQL;

      strComando := qryUpdTmp.SQL.Text;
      strComando := AnsiReplaceStr(strComando, ':NUMDOC', QuotedStr(strNumDoc));
      strComando := AnsiReplaceStr(strComando, ':ESPDOC', QuotedStr(strEspDoc));
      strComando := AnsiReplaceStr(strComando, ':CODEMP', QuotedStr(strCodEmp));
      strComando := AnsiReplaceStr(strComando, ':CODCLI', QuotedStr(strCodCli));
      strComando := AnsiReplaceStr(strComando, ':DTAENT', QuotedStr(FormatDateTime('yyyy-mm-dd', nOw())));
      strComando := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strComando, #13#10, ' '), #10, ' '), #13, ' ');

      pGravaLogRep(strComando, 'MOVGER', 'N');

      qryUpdTmp.Close;
      qryUpdTmp.SQL.Clear;
      qryUpdTmp.SQL.Add('UPDATE MOVDET SET DET_DTAENT = :DTAENT WHERE DET_NUMDOC = :NUMDOC AND DET_ESPDOC = :ESPDOC AND DET_CODEMP = :CODEMP AND DET_CODCLI = :CODCLI ');
      qryUpdTmp.ParamByName('NUMDOC').AsString := strNumDoc;
      qryUpdTmp.ParamByName('ESPDOC').AsString := strEspDoc;
      qryUpdTmp.ParamByName('CODEMP').AsString := strCodEmp;
      qryUpdTmp.ParamByName('CODCLI').AsString := strCodCli;
      qryUpdTmp.ParamByName('DTAENT').AsDateTime := nOw();
      qryUpdTmp.ExecSQL;

      strComando := qryUpdTmp.SQL.Text;
      strComando := AnsiReplaceStr(strComando, ':NUMDOC', QuotedStr(strNumDoc));
      strComando := AnsiReplaceStr(strComando, ':ESPDOC', QuotedStr(strEspDoc));
      strComando := AnsiReplaceStr(strComando, ':CODEMP', QuotedStr(strCodEmp));
      strComando := AnsiReplaceStr(strComando, ':CODCLI', QuotedStr(strCodCli));
      strComando := AnsiReplaceStr(strComando, ':DTAENT', QuotedStr(FormatDateTime('yyyy-mm-dd', nOw())));
      strComando := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strComando, #13#10, ' '), #10, ' '), #13, ' ');

      pGravaLogRep(strComando, 'MOVDET', 'N');

      qryUpdTmp.Close;
      qryUpdTmp.SQL.Clear;
      qryUpdTmp.SQL.Add('UPDATE NOTGER SET GER_DTAENT = :DTAENT WHERE GER_NUMDOC = :NUMDOC AND GER_ESPDOC = :ESPDOC AND GER_CODEMP = :CODEMP AND GER_CODCLI = :CODCLI ');
      qryUpdTmp.ParamByName('NUMDOC').AsString := strNumDoc;
      qryUpdTmp.ParamByName('ESPDOC').AsString := strEspDoc;
      qryUpdTmp.ParamByName('CODEMP').AsString := strCodEmp;
      qryUpdTmp.ParamByName('CODCLI').AsString := strCodCli;
      qryUpdTmp.ParamByName('DTAENT').AsDateTime := nOw();
      qryUpdTmp.ExecSQL;

      strComando := qryUpdTmp.SQL.Text;
      strComando := AnsiReplaceStr(strComando, ':NUMDOC', QuotedStr(strNumDoc));
      strComando := AnsiReplaceStr(strComando, ':ESPDOC', QuotedStr(strEspDoc));
      strComando := AnsiReplaceStr(strComando, ':CODEMP', QuotedStr(strCodEmp));
      strComando := AnsiReplaceStr(strComando, ':CODCLI', QuotedStr(strCodCli));
      strComando := AnsiReplaceStr(strComando, ':DTAENT', QuotedStr(FormatDateTime('yyyy-mm-dd', nOw())));
      strComando := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strComando, #13#10, ' '), #10, ' '), #13, ' ');

      pGravaLogRep(strComando, 'NOTGER', 'N');

      qryUpdTmp.Close;
      qryUpdTmp.SQL.Clear;
      qryUpdTmp.SQL.Add('UPDATE NOTDET SET DET_DTAENT = :DTAENT WHERE DET_NUMDOC = :NUMDOC AND DET_ESPDOC = :ESPDOC AND DET_CODEMP = :CODEMP AND DET_CODCLI = :CODCLI ');
      qryUpdTmp.ParamByName('NUMDOC').AsString := strNumDoc;
      qryUpdTmp.ParamByName('ESPDOC').AsString := strEspDoc;
      qryUpdTmp.ParamByName('CODEMP').AsString := strCodEmp;
      qryUpdTmp.ParamByName('CODCLI').AsString := strCodCli;
      qryUpdTmp.ParamByName('DTAENT').AsDateTime := nOw();
      qryUpdTmp.ExecSQL;

      strComando := qryUpdTmp.SQL.Text;
      strComando := AnsiReplaceStr(strComando, ':NUMDOC', QuotedStr(strNumDoc));
      strComando := AnsiReplaceStr(strComando, ':ESPDOC', QuotedStr(strEspDoc));
      strComando := AnsiReplaceStr(strComando, ':CODEMP', QuotedStr(strCodEmp));
      strComando := AnsiReplaceStr(strComando, ':CODCLI', QuotedStr(strCodCli));
      strComando := AnsiReplaceStr(strComando, ':DTAENT', QuotedStr(FormatDateTime('yyyy-mm-dd', nOw())));
      strComando := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strComando, #13#10, ' '), #10, ' '), #13, ' ');

      pGravaLogRep(strComando, 'NOTDET', 'N');

      if not blnInTransaction then
        Database.Commit;

    Except
      On E: Exception Do
      Begin
        if not blnInTransaction then
          Database.Rollback;

        pLogImp(E.Message + ' [untUtilBD.pAtualizaDataDeAutorizacao]');
      End;
    End;

  Finally
    FreeAndNil(qryUpdTmp);
    pLogImp('pAtualizaDataDeAutorizacao <');
  End;

End;

procedure TFonteDadosBD.pAtualizaDadosAutorizacaoNFe(Const strChaveAcesso, strProtocolo, strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
const
  strTabela: String = 'CADFIS';
var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  blnFldPotocExiste : Boolean;
  blnInTransaction: Boolean;
  strComando: String;
begin
  if fEmptyStr(strChaveAcesso) then
    Exit;

  if Length(strChaveAcesso) <> 44 then
    Exit;

  blnInTransaction := False;

  qryAux := fCriaQuery(Nil);
  try
    try
      blnFldPotocExiste := fCampoExiste(strTabela, 'FIS_PROTOC');
      blnInTransaction := Database.InTransaction;

      if not blnInTransaction then
        Database.StartTransaction;

      qryAux.Close;
      qryAux.SQL.Text :=
      'UPDATE '+
      strTabela+
      ' SET '+
      '  FIS_ACESSO = :ACESSO '+
      IIF((not fEmptyStr(strProtocolo)) and (blnFldPotocExiste), ' ,FIS_PROTOC = :PROTOC ', '')+
      ' WHERE  FIS_NUMDOC = :NUMDOC '+
      '    AND FIS_ESPDOC = :ESPDOC '+
      '    AND FIS_CODEMP = :CODEMP '+
      '    AND FIS_FORCLI = :CODCLI '+
      '    AND IFNULL(FIS_SERIE_, "") = :SERIE_ '+
      '    AND FIS_TIP_FC = :TIP_FC '+
      '    AND IFNULL(FIS_ACESSO, "") = "" ';

      qryAux.ParamByName('ACESSO').AsString := strChaveAcesso;

      if (not fEmptyStr(strProtocolo)) and (blnFldPotocExiste) then
        qryAux.ParamByName('PROTOC').AsString := strProtocolo;

      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.ParamByName('SERIE_').AsString := strSerie;
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
      qryAux.ExecSQL;

      strComando := qryAux.SQL.Text;
      strComando := AnsiReplaceStr(strComando, ':ACESSO', QuotedStr(strChaveAcesso));

      if (not fEmptyStr(strProtocolo)) and (blnFldPotocExiste) then
        strComando := AnsiReplaceStr(strComando, ':PROTOC', QuotedStr(strProtocolo));

      strComando := AnsiReplaceStr(strComando, ':NUMDOC', QuotedStr(strNumDoc));
      strComando := AnsiReplaceStr(strComando, ':ESPDOC', QuotedStr(strEspDoc));
      strComando := AnsiReplaceStr(strComando, ':CODEMP', QuotedStr(strCodEmp));
      strComando := AnsiReplaceStr(strComando, ':SERIE_', QuotedStr(strSerie));
      strComando := AnsiReplaceStr(strComando, ':CODCLI', QuotedStr(strCodCli));
      strComando := AnsiReplaceStr(strComando, ':TIP_FC', QuotedStr(strTip_FC));
      strComando := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strComando, #13#10, ' '), #10, ' '), #13, ' ');
      pGravaLogRep(strComando, strTabela, 'N');

      if not blnInTransaction then
        Database.Commit;
    except
      on E: Exception do
      begin
        if not blnInTransaction then
          Database.Rollback;

        Raise Exception.Create(E.Message + ' [untUtilBD.pAtualizaDadosAutorizacaoNFe]');
      end;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TFonteDadosBD.pAtualizaObraArtigo(strCodObr, strCodArt, strNumDoc, strEspDoc, strCodEmp, strCodCli, strTip_Fc: String);
  Const
    arrMovNot : Array[1..2] Of String[6] = ('MOVGER', 'NOTGER');

  function fSQLUpDate(strTabPri: String; strArtObr: String): String;
    Var
      strTabAux : String;
  begin
    If (strTabPri = 'NOTGER') Then
      strTabAux := 'AUXNOT'
    Else
      strTabAux := 'AUXMOV';
    Result := '';
    Result := Result + ' UPDATE ' + strTabAux ;
    Result := Result + '  INNER JOIN ' + strTabPri + ' ON ' + strTabPri + '.AUTOINCREM = ' + strTabAux + '.AUX_SEQGER  ';
    Result := Result + '    SET ' + strArtObr + ' = :ARTOBR ';
    Result := Result + '  WHERE GER_NUMDOC = :NUMDOC ';
    Result := Result + '    AND GER_ESPDOC = :ESPDOC ';
    Result := Result + '    AND GER_CODEMP = :CODEMP ';
    Result := Result + '    AND GER_TIP_FC = :TIP_FC ';
    If (strTip_Fc = 'F') Then
      Result := Result + '  AND GER_CODFOR = :CODCLI '
    Else
      Result := Result + '  AND GER_CODCLI = :CODCLI ';
  end;

  procedure pAtualiza(strCodObrArt, strObrArt: String);
    Var
      qryAtu : {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
      intCnt : Integer;
  begin
    qryAtu := fCriaQuery(Nil);

    Try
      With qryAtu DO
      Begin
        If (Not fEmptyStr(strCodObrArt)) Then
        Begin
          For intCnt := 1 To 2 Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add( fSQLUpDate( String(arrMovNot[intCnt]), strObrArt )  );
            ParamByName('ARTOBR').AsString := strCodObrArt;
            ParamByName('NUMDOC').AsString := strNumDoc;
            ParamByName('ESPDOC').AsString := strEspDoc;
            ParamByName('CODEMP').AsString := strCodEmp;
            ParamByName('TIP_FC').AsString := strTip_Fc;
            ParamByName('CODCLI').AsString := strCodCli;
            ExecSQL;
          End;
        End;
      End;
    Except
      On E: Exception Do
        Exception.Create(E.Message + ' [untUtilBD.pAtualizaObraArtigo]');
    End;

    FreeAndNil(qryAtu);
  End;

begin
  If Not fTabelaExiste('AUXMOV') Then
    Exit;

  If (strEspDoc <> 'NS') Then
    Exit;

  If (Not fCampoExiste('AUXMOV', 'AUX_CODOBR')) Or (Not fCampoExiste('AUXMOV', 'AUX_CODART')) Then
    Exit;

  If (Not fEmptyStr(strCodObr)) Then
    pAtualiza(strCodObr, 'AUX_CODOBR');

  If (Not fEmptyStr(strCodArt)) Then
    pAtualiza(strCodArt, 'AUX_CODART');
end;

procedure TFonteDadosBD.pCarregarDocumentoImportacao(dadosItem: TDadosItem;
  strAutIncDet: String);
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  If fEmptyStr(strAutIncDet) Then
    Exit;

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Add('SELECT * FROM DOCIMP WHERE IMP_SEQDET = :SEQDET');
    qryAux.ParamByName('SEQDET').AsString := strAutIncDet;
    qryAux.Open;

    If (Not qryAux.IsEmpty) Then
    Begin
      dadosItem.documentoImportacao := TDocumentoImportacao.Create;
      dadosItem.documentoImportacao.strNumeroDi                := qryAux.FieldByName('IMP_NUM_DI').AsString;
      dadosItem.documentoImportacao.dtaDataDi                  := qryAux.FieldByName('IMP_DTA_DI').AsDateTime;
      dadosItem.documentoImportacao.strLocalizacaoDesembaracao := qryAux.FieldByName('IMP_LCDESE').AsString;
      dadosItem.documentoImportacao.strUFDesembaraco           := qryAux.FieldByName('IMP_UFDESE').AsString;
      dadosItem.documentoImportacao.dtaDataDesembaraco         := qryAux.FieldByName('IMP_DTDESE').AsDateTime;

      If (qryAux.FindField('IMP_ADICAO') <> Nil) Then
        dadosItem.documentoImportacao.intAdicao                  := qryAux.FieldByName('IMP_ADICAO').AsInteger
      Else
        dadosItem.documentoImportacao.intAdicao                  := 1;

      If (qryAux.FindField('IMP_BASEII') <> Nil) Then
      Begin
        dadosItem.documentoImportacao.fltBaseImpostoImportacao   := qryAux.FieldByName('IMP_BASEII').AsFloat;
        dadosItem.documentoImportacao.fltDespesasAduaneiras      := qryAux.FieldByName('IMP_DESADU').AsFloat;
        dadosItem.documentoImportacao.fltValorImpostoImportacao  := qryAux.FieldByName('IMP_VAL_II').AsFloat;
        dadosItem.documentoImportacao.fltValorIOF                := qryAux.FieldByName('IMP_VALIOF').AsFloat;
      End;

      If (qryAux.FindField('IMP_VTRINT') <> Nil) Then
      Begin
        dadosItem.documentoImportacao.intViaTransporte      := strToIntDef(qryAux.FieldByName('IMP_VTRINT').AsString, 0);
        dadosItem.documentoImportacao.fltValorAFRMM         := qryAux.FieldByName('IMP_VAFRMM').AsFloat;
        dadosItem.documentoImportacao.intFormaIntermediacao := strToIntDef(qryAux.FieldByName('IMP_FORIMP').AsString, 0);
        dadosItem.documentoImportacao.strCNPJAdquirente     := qryAux.FieldByName('IMP_CGCADQ').AsString;
        dadosItem.documentoImportacao.strUFAdquirente       := qryAux.FieldByName('IMP_UF_ADQ').AsString;
      End;
      FTemPerfilAduaneiro := False;
      If (qryAux.FindField('IMP_PERFIL') <> Nil) Then
      begin
        FTemPerfilAduaneiro := not fEmptyStr(qryAux.FieldByName('IMP_PERFIL').AsString);
      end;

      If (qryAux.FindField('IMP_SISCOM') <> Nil) Then
      Begin
        dadosItem.documentoImportacao.fltSiscomex  := qryAux.FieldByName('IMP_SISCOM').AsFloat;
        dadosItem.documentoImportacao.fltPisPasep  := qryAux.FieldByName('IMP_PISPAS').AsFloat;
        dadosItem.documentoImportacao.fltCofins    := qryAux.FieldByName('IMP_COFINS').AsFloat;

       (*
        dadosItem.documentoImportacao.fltValorImpostoImportacao :=
          dadosItem.documentoImportacao.fltValorImpostoImportacao + dadosItem.fltValIcm;

        dadosItem.documentoImportacao.fltValorImpostoImportacao :=
          dadosItem.documentoImportacao.fltValorImpostoImportacao + dadosItem.documentoImportacao.fltSiscomex;

        dadosItem.documentoImportacao.fltValorImpostoImportacao :=
          dadosItem.documentoImportacao.fltValorImpostoImportacao + dadosItem.documentoImportacao.fltPisPasep;

        dadosItem.documentoImportacao.fltValorImpostoImportacao :=
          dadosItem.documentoImportacao.fltValorImpostoImportacao + dadosItem.documentoImportacao.fltCofins;
          *)
      End;

      dadosItem.documentoImportacao.fltValAdp := 0;
      If (qryAux.FindField('IMP_VLRADP') <> Nil) Then
        dadosItem.documentoImportacao.fltValAdp    := qryAux.FieldByName('IMP_VLRADP').AsFloat;

    End;
  Finally
    FreeAndNil(qryAux);
  End;

end;

Function TFonteDadosBD.fRetornarModDocumento(dadosGerais: TDadosGerais) : String;
begin
  Result :=
    fCampoTabela(
      'MOD_DOCUME',
      'MOVMOD',
      ['MOD_CODEMP','MOD_NUMDOC', 'MOD_CODCLI', 'MOD_ESPDOC'],
      [dadosGerais.strCodEmp, dadosGerais.strNumDoc, dadosGerais.strCodCli, dadosGerais.strEspDoc]);

  If Not fEmptyStr(Result) Then
    Exit;

  Result := dadosGerais.strNumDoc + '-A-' + dadosGerais.strEspDoc + '-' + dadosGerais.strCodEmp + '-000%';
end;

function TFonteDadosBD.fExisteRecebimentoEmPix(var strEndToEndIdPixRecebimento : String; const strModalidade: String;
                                               const fltValorModalidade : Double; var strEndToEndIdPixRecebimentoDoValor : String;
                                               var dtaDtaPag: TDateTime; var strCnpjFinanceira: String; var strCnpjBeneficiario: String): Boolean;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    blnMovPixExiste : Boolean;
    blnSeqConExiste : Boolean;
    blnRecPixExiste : Boolean;
    blnBcoCGCExiste : Boolean;
    blnDtaPixExiste : Boolean;
    strMPX_END_ID: String;
    fltMPX_VALREC: Double;
begin

  Result := False;

  If not (strModalidade = '012') Then
    Exit;

  If not fCampoExiste('CADREC', 'CTR_RECPIX') Then
    Exit;

  dtaDtaPag := 0;
  strCnpjFinanceira := '';
  strCnpjBeneficiario := '';

  strEndToEndIdPixRecebimento := '';
  strEndToEndIdPixRecebimentoDoValor := '';

  blnSeqConExiste := fCampoExiste('CADREC', 'CTR_SEQCON');
  blnMovPixExiste := fCampoExiste('MOVPIX', 'MPX_END_ID');
  blnRecPixExiste := fCampoExiste('ADTCLI', 'ADT_RECPIX');
  blnDtaPixExiste := fCampoExiste('MOVPIX', 'MPX_DTACAD');
  blnBcoCGCExiste := fCampoExiste('CADBCO', 'BCO_C_G_C_');

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT CTR_RECPIX ');

    If blnSeqConExiste Then
    Begin
      qryAux.SQL.Add(' ,CTR_SEQCON ');
      qryAux.SQL.Add(' ,CTR_CODEMP ');
    End;

    If blnDtaPixExiste Then
    Begin
      qryAux.SQL.Add(' ,MPX_DTACAD ');
    End;

    If blnBcoCGCExiste Then
    Begin
      qryAux.SQL.Add(' ,EMP_C_G_C_ ');
      qryAux.SQL.Add(' ,BCO_C_G_C_ ');
    End;

    If (blnMovPixExiste) Then
    Begin
      qryAux.SQL.Add(' ,MPX_END_ID ');
      qryAux.SQL.Add(' ,MPX_VALREC ');
    End;

    qryAux.SQL.Add('   FROM MOVMOD ');
    qryAux.SQL.Add('   LEFT JOIN CADREC ON CTR_NUMDUP = MOD_NUMDOC ');
    qryAux.SQL.Add('                   AND CTR_ESPDOC = MOD_ESPDOC ');
    qryAux.SQL.Add('                   AND CTR_CODEMP = MOD_CODEMP ');
    qryAux.SQL.Add('                   AND CTR_CODCLI = MOD_CODCLI ');

    if fCampoExiste('CADREC', 'CTR_SERIE_') Then
      qryAux.SQL.Add('                 AND CTR_SERIE_ = MOD_SERIE_ ');

    If (blnMovPixExiste) Then
    Begin
      qryAux.SQL.Add(' LEFT JOIN MOVPIX ON CADREC.CTR_SEQCON = MPX_SEQCON ');
      qryAux.SQL.Add('                 AND CADREC.CTR_EMPBAI = MPX_CODEMP ');
      qryAux.SQL.Add('                 AND CADREC.CTR_DTAREC = MPX_DTAREC ');
    End;

    If (blnBcoCGCExiste) Then
    Begin
      qryAux.SQL.Add(' LEFT JOIN CCAPIX ON MOVPIX.MPX_SEQPIX = CCAPIX.AUTOINCREM ');
      qryAux.SQL.Add(' LEFT JOIN CADCCA ON CCAPIX.PIX_SEQCCA = CADCCA.AUTOINCREM ');
      qryAux.SQL.Add(' LEFT JOIN CADEMP ON CADCCA.CCA_CODEMP = CADEMP.EMP_CODEMP ');
      qryAux.SQL.Add(' LEFT JOIN CADBCO ON CADCCA.CCA_CODBCO = CADBCO.BCO_CODBCO ');
    End;

    qryAux.SQL.Add('WHERE MOD_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('  AND MOD_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('  AND MOD_CODEMP = :CODEMP ');
    qryAux.SQL.Add('  AND MOD_CODCLI = :CODCLI ');
    qryAux.SQL.Add('  AND MOD_SERIE_ = :SERIE_ ');
    qryAux.SQL.Add('  AND CTR_RECPIX = "S" ');

    qryAux.ParamByName('NUMDOC').AsString := dadosGerais.strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := dadosGerais.strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := dadosGerais.strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := dadosGerais.strCodCli;
    qryAux.ParamByName('SERIE_').AsString := dadosGerais.strSerie;

    qryAux.Open;

    If not qryAux.IsEmpty Then
    Begin
      Result := (qryAux.RecordCount > 0);

      If (Result) And (fEmptyStr(strEndToEndIdPixRecebimento)) And (blnMovPixExiste) Then
      Begin
        qryAux.First;
        While Not qryAux.Eof Do
        Begin
          If fEmptyStr(qryAux.FieldByName('MPX_END_ID').AsString) Then
          Begin
            qryAux.Next;
            Continue;
          End;

          If blnDtaPixExiste And (dtaDtaPag = 0) Then
            dtaDtaPag := qryAux.FieldByName('MPX_DTACAD').AsDateTime;

          If blnBcoCGCExiste And fEmptyStr(strCnpjFinanceira) Then
            strCnpjFinanceira := qryAux.FieldByName('BCO_C_G_C_').AsString;

          If blnBcoCGCExiste And fEmptyStr(strCnpjBeneficiario) Then
            strCnpjBeneficiario := fTiraCaracEspeciaisPonto(qryAux.FieldByName('EMP_C_G_C_').AsString);

          If (fEmptyStr(strEndToEndIdPixRecebimentoDoValor)) And (CompareValue(fltValorModalidade, qryAux.FieldByName('MPX_VALREC').AsFloat, 0.03) = EqualsValue) Then
            strEndToEndIdPixRecebimentoDoValor := qryAux.FieldByName('MPX_END_ID').AsString;
          If (Not fEmptyStr(strEndToEndIdPixRecebimento)) Then
            strEndToEndIdPixRecebimento := strEndToEndIdPixRecebimento + ';';
          strEndToEndIdPixRecebimento := strEndToEndIdPixRecebimento + qryAux.FieldByName('MPX_END_ID').AsString;
          qryAux.Next;
        End;
      End;

      If (Result) And (fEmptyStr(strEndToEndIdPixRecebimento)) And (blnMovPixExiste) And (blnSeqConExiste) And (blnRecPixExiste) Then
      Begin
        qryAux.First;
        While Not qryAux.Eof Do
        Begin
          If not fExisteAdiantamentoEmPix(qryAux.FieldByName('CTR_SEQCON').AsString,
                                          qryAux.FieldByName('CTR_CODEMP').AsString,
                                          strMPX_END_ID, fltMPX_VALREC) Then
          Begin
            qryAux.Next;
            Continue;
          End;

          If (fEmptyStr(strEndToEndIdPixRecebimentoDoValor)) And (CompareValue(fltValorModalidade, fltMPX_VALREC, 0.03) = EqualsValue) Then
            strEndToEndIdPixRecebimentoDoValor := strMPX_END_ID;

          If (Not fEmptyStr(strEndToEndIdPixRecebimento)) Then
            strEndToEndIdPixRecebimento := strEndToEndIdPixRecebimento + ';';

          strEndToEndIdPixRecebimento := strEndToEndIdPixRecebimento + strMPX_END_ID;

          qryAux.Next;
        End;
      End;

    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fExisteAdiantamentoEmPix(strSeqCon, strEmpLan: String; var strMPX_END_ID: String; var fltMPX_VALREC: Double): Boolean;
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strNumDoc: String;
  strEspDoc: String;
  strCodEmp: String;
  strCodCli: String;
  strSeqPix: String;

begin
  Result := False;

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT ADT_NUMDOC, ADT_ESPDOC, ADT_EMPLAN, ADT_CODCLI FROM ADTCLI ');
    qryAux.SQL.Add('WHERE ADT_SEQCON = :SEQCON ');
    qryAux.SQL.Add('  AND ADT_EMPLAN = :EMPLAN ');
    qryAux.ParamByName('SEQCON').AsString := strSeqCon;
    qryAux.ParamByName('EMPLAN').AsString := strEmpLan;
    qryAux.Open;

    If qryAux.IsEmpty Then
      Exit;

    strNumDoc := qryAux.FieldByName('ADT_NUMDOC').AsString;
    strEspDoc := qryAux.FieldByName('ADT_ESPDOC').AsString;
    strCodEmp := qryAux.FieldByName('ADT_EMPLAN').AsString;
    strCodCli := qryAux.FieldByName('ADT_CODCLI').AsString;

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT ADT_SEQCON, ADT_EMPLAN FROM ADTCLI ');
    qryAux.SQL.Add('WHERE ADT_RECPIX = "S" ');
    qryAux.SQL.Add('  AND ADT_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('  AND ADT_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('  AND ADT_EMPLAN = :EMPLAN ');
    qryAux.SQL.Add('  AND ADT_CODCLI = :CODCLI ');
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('EMPLAN').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.Open;

    If qryAux.IsEmpty Then
      Exit;

    strSeqPix := qryAux.FieldByName('ADT_SEQCON').AsString;
    strCodEmp := qryAux.FieldByName('ADT_EMPLAN').AsString;

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT MPX_END_ID, MPX_VALREC FROM MOVPIX ');
    qryAux.SQL.Add('WHERE MPX_SEQCON = :SEQCON ');
    qryAux.SQL.Add('  AND MPX_CODEMP = :CODEMP ');
    qryAux.ParamByName('SEQCON').AsString := strSeqPix;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.Open;

    If qryAux.IsEmpty Then
      Exit;

    strMPX_END_ID := qryAux.FieldByName('MPX_END_ID').AsString;
    fltMPX_VALREC := qryAux.FieldByName('MPX_VALREC').AsFloat;

    If fEmptyStr(strMPX_END_ID) Then
      Exit;

    Result := True;

  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TFonteDadosBD.pCarregarFormasPagamento(dadosGerais: TDadosGerais);
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    fltTotalModalidades: Double;
    strPedidoDocumento: String;
    blnUsarMovCar : Boolean;
begin
  blnUsarMovCar := True;
  If (fMovModGravaDadosDoCartao) Then
    blnUsarMovCar := False
  Else If (Not fExisteCartaoNaMovMod) Then
    blnUsarMovCar := False;

  SetLength(dadosGerais.arrFormasPagamento, 0);
  qryAux := fCriaQuery(Nil);
  Try
    pCarregaDadosModalidades(dadosGerais, blnUsarMovCar, qryAux);

    If (blnUsarMovCar) Then
    Begin
      If (not fTemLancamentoDeMovCar(qryAux)) And (fRetornaPedidoDoDocumentoSeExistir(strPedidoDocumento, dadosGerais, False)) Then
      Begin
        qryAux.Close;
        qryAux.ParamByName('NUMDOC').AsString := dadosGerais.strNumDoc;
        qryAux.ParamByName('ESPDOC').AsString := dadosGerais.strEspDoc;
        qryAux.ParamByName('CODEMP').AsString := dadosGerais.strCodEmp;
        qryAux.ParamByName('CODCLI').AsString := dadosGerais.strCodCli;
        qryAux.ParamByName('SERIE_').AsString := dadosGerais.strSerie;
        qryAux.ParamByName('DOCUME').AsString := strPedidoDocumento;
        qryAux.Open;
      End;

      If (not fTemLancamentoDeMovCar(qryAux)) And (fRetornaPedidoDoDocumentoSeExistir(strPedidoDocumento, dadosGerais, True)) Then
      Begin
        qryAux.Close;
        qryAux.ParamByName('NUMDOC').AsString := dadosGerais.strNumDoc;
        qryAux.ParamByName('ESPDOC').AsString := dadosGerais.strEspDoc;
        qryAux.ParamByName('CODEMP').AsString := dadosGerais.strCodEmp;
        qryAux.ParamByName('CODCLI').AsString := dadosGerais.strCodCli;
        qryAux.ParamByName('SERIE_').AsString := dadosGerais.strSerie;
        qryAux.ParamByName('DOCUME').AsString := strPedidoDocumento;
        qryAux.Open;
      End;
    End;

    If Not qryAux.IsEmpty Then
    Begin
      pCarregaArrFormasPagamento(qryAux, fltTotalModalidades, dadosGerais);
      pTrataDiferencaEntreTotGerEModalidades(dadosGerais, fltTotalModalidades);
    End
    Else
      pAdicionaFormaPagamentoPoisDocumentoNaoTemMovMod(dadosGerais);
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TFonteDadosBD.pCarregarFormasPagamentoMultas_e_Juros(dadosGerais: TDadosGerais);
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  i: integer;
begin

  If Not fTabelaExiste('JURMUL') Then
    Exit;

  If not (dadosGerais.strFinalidade = '6') Then
    Exit;

  For i := 0 To Length(dadosGerais.arrFormasPagamento)-1 Do
    FreeAndNil(dadosGerais.arrFormasPagamento[i]);

  For i := 0 To Length(dadosGerais.arrDuplicatas)-1 Do
    FreeAndNil(dadosGerais.arrDuplicatas[i]);

  For i := 0 To Length(arrFormasPagamentoInterna)-1 Do
    FreeAndNil(arrFormasPagamentoInterna[i]);

  SetLength(dadosGerais.arrDuplicatas, 0);
  SetLength(dadosGerais.arrFormasPagamento, 0);
  SetLength(arrFormasPagamentoInterna, 0);

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  MUL_TIPPAG, ');
    qryAux.SQL.Add('  MUL_CODPAG, ');
    qryAux.SQL.Add('  MUL_DTAPAG, ');
    qryAux.SQL.Add('  MUL_VALPAG, ');
    qryAux.SQL.Add('  MUL_CNPJPG, ');
    qryAux.SQL.Add('  MUL_NUMAUT, ');
    qryAux.SQL.Add('  MUL_TIPINT, ');
    qryAux.SQL.Add('  MUL_CNPJBF ');
    qryAux.SQL.Add('FROM JURMUL ');
    qryAux.SQL.Add('WHERE MUL_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('  AND MUL_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('  AND MUL_CODEMP = :CODEMP ');
    qryAux.SQL.Add('  AND MUL_CODCLI = :CODCLI ');
    qryAux.SQL.Add('ORDER BY MUL_SEQITE ');
    qryAux.ParamByName('NUMDOC').AsString := dadosGerais.strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := dadosGerais.strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := dadosGerais.strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := dadosGerais.strCodCli;
    qryAux.Open;

    If qryAux.RecordCount > 0 Then
    Begin
      dadosGerais.blnImprimirDuplicatas := True;

      SetLength(dadosGerais.arrDuplicatas, 1);
      dadosGerais.arrDuplicatas[0] := TDuplicatas.Create;
      dadosGerais.arrDuplicatas[0].strNumDup := dadosGerais.strNumDoc;
      dadosGerais.arrDuplicatas[0].dtaDtaVen := dadosGerais.dtaDtaEnt;
      dadosGerais.arrDuplicatas[0].fltValDup := dadosGerais.fltTotGer;

      While not qryAux.Eof Do
      Begin
        SetLength(dadosGerais.arrFormasPagamento, Length(dadosGerais.arrFormasPagamento)+1);
        dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1] := TFormaPagamento.Create;
        dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCodigo := qryAux.FieldByName('MUL_CODPAG').AsString;
        dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].fltValor  := qryAux.FieldByName('MUL_VALPAG').AsFloat;
        dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].dtaDtaPag := qryAux.FieldByName('MUL_DTAPAG').AsDateTime;

        If (dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCodigo = '17') Then
        Begin
          dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCnpjFinanceira   := qryAux.FieldByName('MUL_CNPJPG').AsString;
          dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strEndToEndIdPix    := qryAux.FieldByName('MUL_NUMAUT').AsString;
          dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCnpjBeneficiario := qryAux.FieldByName('MUL_CNPJBF').AsString;
        End;

        SetLength(arrFormasPagamentoInterna, Length(arrFormasPagamentoInterna)+1);
        arrFormasPagamentoInterna[Length(arrFormasPagamentoInterna)-1] := TFormaPagamentoInterna.Create;

        If Pos(dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCodigo, '03_04_') > 0 Then
        Begin
          arrFormasPagamentoInterna[Length(arrFormasPagamentoInterna)-1].strCnpjOperadora    := qryAux.FieldByName('MUL_CNPJPG').AsString;
          arrFormasPagamentoInterna[Length(arrFormasPagamentoInterna)-1].strBandeira         := qryAux.FieldByName('MUL_CODPAG').AsString;
          arrFormasPagamentoInterna[Length(arrFormasPagamentoInterna)-1].strNumAutorizacao   := qryAux.FieldByName('MUL_NUMAUT').AsString;
          arrFormasPagamentoInterna[Length(arrFormasPagamentoInterna)-1].strTipCar           := qryAux.FieldByName('MUL_TIPINT').AsString;
          arrFormasPagamentoInterna[Length(arrFormasPagamentoInterna)-1].strCnpjBeneficiario := qryAux.FieldByName('MUL_CNPJBF').AsString;
        End;

        qryAux.Next;
      End;
    End;

  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TFonteDadosBD.pInicio;
begin
  If (Not Assigned(qryDados)) Then
  Begin
    pCarregarDados;
  End;

  intPosAtual := 0;

  If Assigned(qryDados) Then
    qryDados.First;
end;

procedure TFonteDadosBD.pLogarPerformance(objeto: TObject);
//  Var
//    log: TLogPerformance;
//    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
//    qrySel: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  //Função em desuso, mantida apenas por compatibilidade;

  If Not objConfigInterna.blnMonitoramentoTempo Then
    Exit;

  If (objeto = Nil) Then
    Exit;

//  log := TLogPerformance(objeto);
//  qryAux := fCriaQuery(Nil);
//  qryAux.SQL.Add('INSERT INTO NFE_TEMPO (');
//  qryAux.SQL.Add('  NFE_ORIGEM, ');
//  qryAux.SQL.Add('  NFE_NUMDOC, ');
//  qryAux.SQL.Add('  NFE_ESPDOC, ');
//  qryAux.SQL.Add('  NFE_CODEMP, ');
//  qryAux.SQL.Add('  NFE_CODCLI, ');
//  qryAux.SQL.Add('  NFE_SERIE_, ');
//  qryAux.SQL.Add('  NFE_TIP_FC, ');
//  qryAux.SQL.Add('  NFE_INIOPE, ');
//  qryAux.SQL.Add('  NFE_FIMOPE, ');
//  qryAux.SQL.Add('  NFE_CODEVE, ');
//  qryAux.SQL.Add('  NFE_DESEVE) ');
//  qryAux.SQL.Add('VALUES ( ');
//  qryAux.SQL.Add('  :ORIGEM, ');
//  qryAux.SQL.Add('  :NUMDOC, ');
//  qryAux.SQL.Add('  :ESPDOC, ');
//  qryAux.SQL.Add('  :CODEMP, ');
//  qryAux.SQL.Add('  :CODCLI, ');
//  qryAux.SQL.Add('  :SERIE_, ');
//  qryAux.SQL.Add('  :TIP_FC, ');
//  qryAux.SQL.Add('  :INIOPE, ');
//  qryAux.SQL.Add('  :FIMOPE, ');
//  qryAux.SQL.Add('  :CODEVE, ');
//  qryAux.SQL.Add('  :DESEVE) ');
//
//  qryAux.ParamByName('ORIGEM').AsString := log.strOrigem;
//  qryAux.ParamByName('NUMDOC').AsString := log.strNumDoc;
//  qryAux.ParamByName('ESPDOC').AsString := log.strEspDoc;
//  qryAux.ParamByName('CODEMP').AsString := log.strCodEmp;
//  qryAux.ParamByName('CODCLI').AsString := log.strCodCli;
//  qryAux.ParamByName('SERIE_').AsString := log.strSerie;
//  qryAux.ParamByName('TIP_FC').AsString := FTip_FC;
//  qryAux.ParamByName('INIOPE').AsDateTime := log.dtaHoraInicial;
//  qryAux.ParamByName('FIMOPE').AsDateTime := log.dtaHoraFinal;
//  qryAux.ParamByName('CODEVE').AsInteger := log.intCodigo;
//  qryAux.ParamByName('DESEVE').AsString := log.strMensagem;
//  qryAux.ExecSQL;
//
//  If log.intCodigo = IMPRESSAO_NOTA_FISCAL Then
//  Begin
//    qrySel := fCriaQuery(Nil);
//    qrySel.SQL.Add('SELECT NFE_INIOPE FROM NFE_TEMPO WHERE ');
//    qrySel.SQL.Add('  NFE_NUMDOC = :NUMDOC AND ');
//    qrySel.SQL.Add('  NFE_ESPDOC = :ESPDOC AND ');
//    qrySel.SQL.Add('  NFE_CODEMP = :CODEMP AND ');
//    qrySel.SQL.Add('  NFE_CODCLI = :CODCLI AND ');
//    qrySel.SQL.Add('  IFNULL(NFE_SERIE_, "") = :SERIE_ AND ');
//    qrySel.SQL.Add('  NFE_TIP_FC = :TIP_FC AND ');
//    qrySel.SQL.Add('  NFE_CODEVE = :CODEVE ');
//    qrySel.SQL.Add('ORDER BY ');
//    qrySel.SQL.Add('  NFE_INIOPE DESC ');
//    qrySel.SQL.Add('LIMIT 1 ');
//
//    qrySel.ParamByName('NUMDOC').AsString := log.strNumDoc;
//    qrySel.ParamByName('ESPDOC').AsString := log.strEspDoc;
//    qrySel.ParamByName('CODEMP').AsString := log.strCodEmp;
//    qrySel.ParamByName('CODCLI').AsString := log.strCodCli;
//    qrySel.ParamByName('SERIE_').AsString := log.strSerie;
//    qrySel.ParamByName('TIP_FC').AsString := FTip_FC;
//    qrySel.ParamByName('CODEVE').AsInteger := PRIMEIRO_PASSO_MEDICAO_TEMPO;
//    qrySel.Open;
//
//    If Not qrySel.IsEmpty Then
//    Begin
//      qryAux.ParamByName('ORIGEM').AsString := log.strOrigem;
//      qryAux.ParamByName('NUMDOC').AsString := log.strNumDoc;
//      qryAux.ParamByName('ESPDOC').AsString := log.strEspDoc;
//      qryAux.ParamByName('CODEMP').AsString := log.strCodEmp;
//      qryAux.ParamByName('CODCLI').AsString := log.strCodCli;
//      qryAux.ParamByName('SERIE_').AsString := log.strSerie;
//      qryAux.ParamByName('TIP_FC').AsString := FTip_FC;
//      qryAux.ParamByName('INIOPE').AsDateTime := qrySel.FieldByName('NFE_INIOPE').AsDateTime;
//      qryAux.ParamByName('FIMOPE').AsDateTime := log.dtaHoraFinal;
//      qryAux.ParamByName('CODEVE').AsInteger := MEDICAO_TEMPO_GERAL;
//      qryAux.ParamByName('DESEVE').AsString := 'Tempo total para emissão NFe';
//      qryAux.ExecSQL;
//    End;
//
//    FreeAndNil(qrySel);
//  End;
//
//  FreeAndNil(qryAux);
end;

procedure TFonteDadosBD.pRetornaDadosIbge(strCodCid: String; var strCodIbge,
  strUfIbge, strEstado, strCidade: String);
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    recDadosIbge: TDadosIbge;
begin
  strUfIbge  := '';
  strCodIbge := '';
  strEstado  := '';
  strCidade  := '';

  If Not fEmptyStr(strCodCid) Then
  Begin
    {$IF Defined(UNIDAC) Or Defined(LINUX)}
    If dicCadIbg.ContainsKey(strCodCid) Then
    Begin
      recDadosIbge := dicCadIbg[strCodCid];
      strUfIbge  := recDadosIbge.strCodUf_;
      strCodIbge := recDadosIbge.strCodMun;
      strEstado  := recDadosIbge.strEstado;
      strCidade  := recDadosIbge.strCidade;

      Exit;
    End;
    {$IFEND}

    qryAux := fCriaQuery(Nil);
    Try
      qryAux.SQL.Add('SELECT ');
      qryAux.SQL.Add('  IBG_CODUF_, ');
      qryAux.SQL.Add('  IBG_CODMUN, ');
      qryAux.SQL.Add('  CID_ESTADO, ');
      qryAux.SQL.Add('  CID_NOMCID  ');
      qryAux.SQL.Add('FROM ');
      qryAux.SQL.Add('  IBG_CADIBG ');
      qryAux.SQL.Add('JOIN CADCID ON CID_COIBGE = IBG_CODMUN ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  CID_CODCID = :CODCID ');
      qryAux.ParamByName('CODCID').AsString := strCodCid;
      qryAux.Open;

      strUfIbge  := qryAux.FieldByName('IBG_CODUF_').AsString;
      strCodIbge := qryAux.FieldByName('IBG_CODMUN').AsString;
      strEstado  := qryAux.FieldByName('CID_ESTADO').AsString;
      strCidade  := qryAux.FieldByName('CID_NOMCID').AsString;

      {$IF Defined(UNIDAC) Or Defined(LINUX)}
      FillChar(recDadosIbge, SizeOf(recDadosIbge), 0);

      recDadosIbge.strCodUf_ := strUfIbge;
      recDadosIbge.strCodMun := strCodIbge;
      recDadosIbge.strEstado := strEstado;
      recDadosIbge.strCidade := strCidade;

      dicCadIbg.AddOrSetValue(strCodCid, recDadosIbge);
      {$IFEND}
    Finally
      FreeAndNil(qryAux);
    End;
  End;
end;

procedure TFonteDadosBD.pRetornaNomeDaCidadeIbge(strCodMun: String; var strNomCid, strEstado: String);
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  strNomCid  := '';
  strEstado  := '';

  If fEmptyStr(strCodMun) Then
    Exit;

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT CID_NOMCID, CID_ESTADO FROM CADCID ');
    qryAux.SQL.Add('WHERE CID_COIBGE = :CODMUN ');
    qryAux.ParamByName('CODMUN').AsString := strCodMun;
    qryAux.Open;

    strNomCid := qryAux.FieldByName('CID_NOMCID').AsString;
    strEstado := qryAux.FieldByName('CID_ESTADO').AsString;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function  TFonteDadosBD.fRetCodigoPais(strCodCidade: String; strCodPaiEnt: String): String;
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := consCodIbgeBrasil;

  If (Not fEmptyStr(strCodPaiEnt)) Then
  begin
    Result := strCodPaiEnt;
    Exit;
  end;

  If (Not fEmptyStr(strCodCidade)) Then
  Begin
    If (fCampoExiste('CADCID', 'CID_CODPAI')) then
    Begin
      qryAux := fCriaQuery(Nil);
      Try
        qryAux.SQL.Clear;
        qryAux.SQL.Add('SELECT CID_CODPAI FROM CADCID');
        qryAux.SQL.Add(' WHERE CID_CODCID = :CODCID');
        qryAux.ParamByName('CODCID').AsString := strCodCidade;
        qryAux.Open;

        Result := qryAux.FieldByName('CID_CODPAI').AsString;
      Finally
        FreeAndNil(qryAux);
      End;
    End;
  End;
end;

function TFonteDadosBD.fRetSQLMsg1e2TipAbfdeSAI(strTip: String): String;
  Var
    intAux: Integer;
    strAux: String;
begin
  For intAux:=1 To 2 Do
  Begin
    strAux := 'ABF_MENS'+untUtil.fStrZero(IntToStr(intAux),2)+'_SAI_'+strTip;
    If fCampoExiste('ABFICM', strAux) Then
      Result := Result + ' ' + strAux + ', ';
  End;
end;

function TFonteDadosBD.fGetCampoValor(strCampoRetorno, strCampoChave, strValorChave, strTabela: String): String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := '';

  If Not fTabelaExiste(strTabela) Then
    Exit;

  If (Not fCampoExiste(strTabela, strCampoRetorno)) Then
    Exit;

  If (Not fCampoExiste(strTabela, strCampoChave)) Then
    Exit;

  qryAux := fCriaQuery(Nil);

  Try
    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT ' + strCampoRetorno );
      SQL.Add('   FROM ' + strTabela);
      SQL.Add('  WHERE ' + strCampoChave + ' = :CHAVE ');
      ParamByName('CHAVE').AsString := strValorChave;
      Open;
      Result := FieldByName(strCampoRetorno).AsString;
      Close;
    End;
  Except

  End;

  FreeAndNil(qryAux);
end;

function TFonteDadosBD.fGetCodArt: String;
  Var
    strEntGer : String;
begin
  Result := '';
  strEntGer := fGetEntGer(FNumDoc, FEspDoc, FCodEmp, FCodCli, FTip_FC);

  If (Not fEmptyStr(strEntGer)) Then
    Result := fGetCampoValor('ETC_CODART', 'AUTOINCREM', strEntGer, 'ENTCLI');

  If fEmptyStr(Result) Then
    Result := fGetCampoValor('CLI_CODART', 'CLI_CODCLI', FCodCli, 'CADCLI');
end;

function TFonteDadosBD.fGetCodObr: String;
  Var
    strEntGer : String;
begin
  Result := '';
  strEntGer := fGetEntGer(FNumDoc, FEspDoc, FCodEmp, FCodCli, FTip_FC);

  If (Not fEmptyStr(strEntGer)) Then
    Result := fGetCampoValor('ETC_CODOBR', 'AUTOINCREM', strEntGer, 'ENTCLI');

  If fEmptyStr(Result) Then
    Result := fGetCampoValor('CLI_CODOBR', 'CLI_CODCLI', FCodCli, 'CADCLI');
end;

function TFonteDadosBD.fGetConhecimento(strNumeroConhecimento: String; blnConsulta: Boolean=False): TConhecimentoEletronico;
var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  objQtdeCarga: TInformacoesQtdeCarga;
  objNFe: TInformacoesNFe;
  strSQLUnion: string;
  strTomador: string;
  blnExistePARCTE: Boolean;
  tipoImpressao: TTipoImpressao;
begin
  qryAux := fCriaQuery(Nil);
  try
    blnExistePARCTE := fTabelaExiste('PARCTE');
    strSQLUnion := fGetSQLConhecimento(blnExistePARCTE, blnConsulta);
    qryAux.SQL.Add(strSQLUnion);
    qryAux.SQL.Add('UNION ALL ');
    strSQLUnion := AnsiReplaceStr(strSQLUnion, 'MOVCTE', 'NOTCTE');
    strSQLUnion := AnsiReplaceStr(strSQLUnion, 'MOVGER', 'NOTGER');
    strSQLUnion := AnsiReplaceStr(strSQLUnion, 'AUXMOV', 'AUXNOT');
    qryAux.SQL.Add(strSQLUnion);
    qryAux.ParamByName('CODEMP').AsString := objConfig.strCodEmp;
    qryAux.ParamByName('NUMCTE').AsString := strNumeroConhecimento;
    qryAux.Open;

    tipoImpressao := tiPadrao;
    If fConfiguracao('NFICTE') = 'S' Then
      tipoImpressao := tiNfeImpressao;

    Result := TConhecimentoEletronico.Create(fDadosEmitente, tipoImpressao);

    Result.strCodEmp := objConfig.strCodEmp;
    Result.strCFOP := qryAux.FieldByName('CTE_CFOP__').AsString;
    Result.strNaturezaOperacao := qryAux.FieldByName('CTE_NATOPE').AsString;
    Result.strSerie := qryAux.FieldByName('CTE_SERIE_').AsString;
    Result.strNumeroConhecimento := strNumeroConhecimento;
    Result.dtaDataEmissao := qryAux.FieldByName('CTE_DTAEMI').AsDateTime;
    Result.strTipoCTe := '0';
    Result.strModal := '01';
    Result.strTipoServico := '0';
    Result.strCodIBGEInicioPrestacao := qryAux.FieldByName('CODIBGE_INICIO').AsString;
    Result.strCodIBGEFimPrestacao := qryAux.FieldByName('CODIBGE_TERMINO').AsString;
    Result.strIndicadorRetira := '1';
    Result.fltValorPrestacaoServico := qryAux.FieldByName('CTE_VLRFRE').AsFloat;
    Result.fltValoraReceber := qryAux.FieldByName('CTE_VLRFRE').AsFloat;
    Result.strModeloDocumentoFiscal := '57';
    Result.fltPercAproximadosTributos := StrToFloatDef(fCfgSisFonte(Self,'TRICTE'), 0);

    Result.Tomador.strTomadorServico := LeftStr(qryAux.FieldByName('CTE_TOMSER').AsString, 1);
    strTomador := Result.Tomador.strTomadorServico;
    Result.Tomador.strCPFCNPJ           := IIF(strTomador = '0', qryAux.FieldByName('REMETENTE_CNPJ').AsString,                     qryAux.FieldByName('CLIENTE_CNPJ').AsString);
    Result.Tomador.strInscricaoEstadual := fLimpaCaracteres(IIF(strTomador = '0', qryAux.FieldByName('REMETENTE_IE').AsString,                       qryAux.FieldByName('CLIENTE_IE').AsString));
    Result.Tomador.strRazaoSocialNome   := IIF(strTomador = '0', LeftStr(qryAux.FieldByName('REMETENTE_RAZAOSOCIAL').AsString, 60), LeftStr(qryAux.FieldByName('CLIENTE_RAZAOSOCIAL').AsString, 60));
    Result.Tomador.strNomeFantasia      := IIF(strTomador = '0', LeftStr(qryAux.FieldByName('REMETENTE_FANTASIA').AsString, 60),    LeftStr(qryAux.FieldByName('CLIENTE_FANTASIA').AsString, 60));
    Result.Tomador.strTelefone          := IIF(strTomador = '0', LeftStr(qryAux.FieldByName('REMETENTE_TELEFONE').AsString, 14),    LeftStr(qryAux.FieldByName('CLIENTE_TELEFONE').AsString, 14));
    Result.Tomador.strLogradouro        := IIF(strTomador = '0', qryAux.FieldByName('REMETENTE_ENDERECO').AsString,                 qryAux.FieldByName('CLIENTE_ENDERECO').AsString);
    Result.Tomador.strNumero            := IIF(strTomador = '0', qryAux.FieldByName('REMETENTE_NUMERO').AsString,                   qryAux.FieldByName('CLIENTE_NUMERO').AsString);
    Result.Tomador.strComplemento       := IIF(strTomador = '0', qryAux.FieldByName('REMETENTE_COMPLEMENTO').AsString,              qryAux.FieldByName('CLIENTE_COMPLEMENTO').AsString);
    Result.Tomador.strBairro            := IIF(strTomador = '0', LeftStr(qryAux.FieldByName('REMETENTE_BAIRRO').AsString, 60),      LeftStr(qryAux.FieldByName('CLIENTE_BAIRRO').AsString, 60));
    Result.Tomador.strCodIBGE           := IIF(strTomador = '0', Result.strCodIBGEInicioPrestacao,                                  Result.strCodIBGEFimPrestacao);
    Result.Tomador.strCEP               := fRetSomenteNumeros(
                                           IIF(strTomador = '0', qryAux.FieldByName('REMETENTE_CEP').AsString,                      qryAux.FieldByName('CLIENTE_CEP').AsString));
    Result.Tomador.strCodPais           := consCodIbgeBrasil;
    Result.Tomador.strEmail             := IIF(strTomador = '0', LeftStr(qryAux.FieldByName('REMETENTE_EMAIL').AsString, 60),       LeftStr(qryAux.FieldByName('CLIENTE_EMAIL').AsString, 60));
    Result.Tomador.strIndicador         := IIF(strTomador = '0', LeftStr(qryAux.FieldByName('CTE_PAPTOM').AsString, 1),             LeftStr(qryAux.FieldByName('CTE_PAPTOM').AsString, 1));

    Result.Remetente.strCPFCNPJ           := qryAux.FieldByName('REMETENTE_CNPJ').AsString;
    Result.Remetente.strInscricaoEstadual := qryAux.FieldByName('REMETENTE_IE').AsString;
    Result.Remetente.strRazaoSocialNome   := LeftStr(qryAux.FieldByName('REMETENTE_RAZAOSOCIAL').AsString, 60);
    Result.Remetente.strNomeFantasia      := LeftStr(qryAux.FieldByName('REMETENTE_FANTASIA').AsString, 60);
    Result.Remetente.strTelefone          := LeftStr(qryAux.FieldByName('REMETENTE_TELEFONE').AsString, 14);
    Result.Remetente.strLogradouro        := qryAux.FieldByName('REMETENTE_ENDERECO').AsString;
    Result.Remetente.strNumero            := qryAux.FieldByName('REMETENTE_NUMERO').AsString;
    Result.Remetente.strComplemento       := qryAux.FieldByName('REMETENTE_COMPLEMENTO').AsString;
    Result.Remetente.strBairro            := LeftStr(qryAux.FieldByName('REMETENTE_BAIRRO').AsString, 60);
    Result.Remetente.strCodIBGE           := Result.strCodIBGEInicioPrestacao;
    Result.Remetente.strCEP               := fRetSomenteNumeros(qryAux.FieldByName('REMETENTE_CEP').AsString);
    Result.Remetente.strCodPais           := consCodIbgeBrasil;
    Result.Remetente.strEmail             := LeftStr(qryAux.FieldByName('REMETENTE_EMAIL').AsString, 60);

    Result.Destinatario.strCPFCNPJ           := qryAux.FieldByName('CLIENTE_CNPJ').AsString;
    Result.Destinatario.strInscricaoEstadual := fLimpaCaracteres(qryAux.FieldByName('CLIENTE_IE').AsString);
    Result.Destinatario.strRazaoSocialNome   := LeftStr(qryAux.FieldByName('CLIENTE_RAZAOSOCIAL').AsString, 60);
    Result.Destinatario.strTelefone          := LeftStr(qryAux.FieldByName('CLIENTE_TELEFONE').AsString, 14);
    Result.Destinatario.strSuframa           := '';
    Result.Destinatario.strLogradouro        := qryAux.FieldByName('CLIENTE_ENDERECO').AsString;
    Result.Destinatario.strNumero            := qryAux.FieldByName('CLIENTE_NUMERO').AsString;
    Result.Destinatario.strComplemento       := qryAux.FieldByName('CLIENTE_COMPLEMENTO').AsString;
    Result.Destinatario.strBairro            := LeftStr(qryAux.FieldByName('CLIENTE_BAIRRO').AsString, 60);
    Result.Destinatario.strCodIBGE           := qryAux.FieldByName('CLIENTE_CODIBGE').AsString;
    Result.Destinatario.strCEP               := fRetSomenteNumeros(qryAux.FieldByName('CLIENTE_CEP').AsString);
    Result.Destinatario.strCodPais           := consCodIbgeBrasil;
    Result.Destinatario.strEmail             := LeftStr(qryAux.FieldByName('CLIENTE_EMAIL').AsString, 60);

    Result.ValoresPrestacaoServico.strTipoCTE := '0';
    Result.ValoresPrestacaoServico.strNroItem := '1';
    Result.ValoresPrestacaoServico.strNomeComponente := 'FRETE PESO';
    Result.ValoresPrestacaoServico.fltValor := qryAux.FieldByName('GER_PESBRU').AsFloat;

    Result.InformacoesImpostos.strTipoCTE := '0';
    Result.InformacoesImpostos.strClassificacaoTS := qryAux.FieldByName('CTE_CLATRI').AsString;
    Result.InformacoesImpostos.fltPercentualReducaoBC := qryAux.FieldByName('CTE_PERRBC').AsFloat;
    Result.InformacoesImpostos.fltValorBCIcms := qryAux.FieldByName('CTE_VLRBCI').AsFloat;
    Result.InformacoesImpostos.fltAliquotaICMS := qryAux.FieldByName('CTE_ALIQUO').AsFloat;
    Result.InformacoesImpostos.fltValorICMS := qryAux.FieldByName('CTE_VLRIMP').AsFloat;
    Result.InformacoesImpostos.fltValorCredito := qryAux.FieldByName('CTE_VLRCRE').AsFloat;

    Result.strReformaCST        := qryAux.FieldByName('CTE_CSTREF').AsString;
    Result.strReformaClasTrib   := qryAux.FieldByName('CTE_CLAREF').AsString;
    Result.fltReformaBasIBS_CBS := qryAux.FieldByName('CTE_BASREF').AsFloat;
    Result.fltReformaAlqCBS     := qryAux.FieldByName('CTE_CBS_AL').AsFloat;
    Result.fltReformaAlqIBS_UF  := qryAux.FieldByName('CTE_IBS_UF').AsFloat;
    Result.fltReformaAlqIBS_MN  := qryAux.FieldByName('CTE_IBS_MN').AsFloat;
    Result.fltReformaVlrCBS     := qryAux.FieldByName('CTE_CBSVAL').AsFloat;
    Result.fltReformaVlrIBS_UF  := qryAux.FieldByName('CTE_IBSUFV').AsFloat;
    Result.fltReformaVlrIBS_MN  := qryAux.FieldByName('CTE_IBSMNV').AsFloat;

    Result.InformacoesCarga.fltValorTotal := qryAux.FieldByName('GER_VLRCON').AsFloat;
    Result.InformacoesCarga.strProdutoPredominante := qryAux.FieldByName('CTE_PROPRE').AsString;

    objQtdeCarga := TInformacoesQtdeCarga.Create('01', 'PESO BRUTO', qryAux.FieldByName('GER_PESBRU').AsFloat);
    Result.pAddInformacoesQtdeCarga(objQtdeCarga);

    objNFe := TInformacoesNFe.Create(qryAux.FieldByName('FIS_ACESSO').AsString, '', 0);
    Result.pAddInformacoesNFe(objNFe);

    Result.InformacoesServicoPrestado.strDescricaoServico := qryAux.FieldByName('CTE_DESSER').AsString;
    Result.InformacoesServicoPrestado.fltQtdeCargas := qryAux.FieldByName('CTE_QTDCAR').AsFloat;

    Result.InformacoesRodoviario.strRegistroNacionalANTT := qryAux.FieldByName('CTE_RNTRC_').AsString;

    if (blnExistePARCTE) and (not qryAux.FieldByName('PAR_SEQGER').IsNull) then
    begin
      Result.Partilha := TPartilhaCTe.Create;
      Result.Partilha.fltValorBaseCalculoIcmsUfDestino := qryAux.FieldByName('PAR_BCIUFD').AsFloat;
      Result.Partilha.fltAliquotaIcmsInternaUfDestino  := qryAux.FieldByName('PAR_AIIUFD').AsFloat;
      Result.Partilha.fltAliquotaIcmsInterestadual     := qryAux.FieldByName('PAR_AICMSI').AsFloat;
      Result.Partilha.fltValorIcmsPartilhaTermino      := qryAux.FieldByName('PAR_ICMSPT').AsFloat;
      Result.Partilha.fltValorIcmsPartilhaInicio       := qryAux.FieldByName('PAR_ICMSPI').AsFloat;
      Result.Partilha.fltAliquotaFcp                   := qryAux.FieldByName('PAR_ALQFCP').AsFloat;
      Result.Partilha.fltValorFcpDestino               := qryAux.FieldByName('PAR_VLRFCP').AsFloat;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

function TFonteDadosBD.fGetConhecimentoCompacto(strNumeroConhecimento: String): TConhecimentoEletronico;
var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strSQL: string;
begin
  qryAux := fCriaQuery(Nil);
  try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTE_DTAEMI, CTE_ACESSO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVCTE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTE_NUMCTE = :NUMCTE ';
    strSQL := strSQL + '  AND CTE_CODEMP = :CODEMP';

    qryAux.SQL.Add(strSQL);
    qryAux.SQL.Add('UNION ALL ');
    qryAux.SQL.Add(AnsiReplaceStr(strSQL, 'MOVCTE', 'NOTCTE'));

    qryAux.ParamByName('CODEMP').AsString := objConfig.strCodEmp;
    qryAux.ParamByName('NUMCTE').AsString := strNumeroConhecimento;
    qryAux.Open;

    Result := TConhecimentoEletronico.Create(fDadosEmitente);

    Result.strNumeroConhecimento := strNumeroConhecimento;
    Result.dtaDataEmissao        := qryAux.FieldByName('CTE_DTAEMI').AsDateTime;
    Result.strCodEmp             := objConfig.strCodEmp;
    Result.strChaveAcesso        := qryAux.FieldByName('CTE_ACESSO').AsString;
  finally
    FreeAndNil(qryAux);
  end;
end;

function TFonteDadosBD.fGetConnectionID: String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Try
    qryAux := fCriaQuery(Nil);
    Try
      qryAux.SQL.Add('SELECT CONNECTION_ID()');
      qryAux.Open;

      Result := qryAux.Fields[0].AsString;
    Finally
      FreeAndNil(qryAux);
    End;
  Except
    //
  End;
end;

procedure TFonteDadosBD.pPegaDataHoraSistema(Var dtaDtaSis, dtaHraSis : TDateTime);
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  Try
    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT CURRENT_DATE, CURRENT_TIME');
      qryAux.Open;
      dtaDtaSis := qryAux.FieldByName('CURRENT_DATE').AsDateTime;
      dtaHraSis := qryAux.FieldByName('CURRENT_TIME').AsDateTime;
      qryAux.Close;
    Except
      dtaDtaSis := Date;
      dtaHraSis := Time();
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fGetDadosAdicionaisReferenteAEntrega: String;

  function fIdxTurno(strTurno: String): Integer;
  begin
    Result := -1;
    If (AnsiSameText(strTurno, 'Manhã')) Then
      Result := 0
    Else If (AnsiSameText(strTurno, 'Tarde')) Then
      Result := 1
    Else If (AnsiSameText(strTurno, 'Noite')) Then
      Result := 2;
  end;

  function fSQLBase(strTabela: String): String;
    Var
      strTabTri : String;
  begin
    If (strTabela = 'MOVDET') Then
      strTabTri := 'MOVTRI'
    Else
      strTabTri := 'NOTTRI';

    Result := '';
    Result := Result + ' SELECT DET_TURENT, DET_DTAFUT ';
    Result := Result + '   FROM ' + strTabela;
    Result := Result + '   LEFT JOIN ' + strTabTri + ' ON ' + strTabTri + '.DET_SEQGER = ' + strTabela + '.AUTOINCREM ';
    Result := Result + '  WHERE DET_DTAFUT IS NOT NULL ';
    Result := Result + '    AND DET_NUMDOC = :NUMDOC ';
    Result := Result + '    AND DET_ESPDOC = :ESPDOC ';
    Result := Result + '    AND DET_SERIE_ = :SERIE_ ';
    Result := Result + '    AND DET_CODEMP = :CODEMP ';
    Result := Result + '    AND DET_TIP_FC = :TIP_FC ';
    If (FTip_FC = 'C') Then
      Result := Result + '    AND DET_CODCLI = :CLIFOR '
    Else
      Result := Result + '    AND DET_CODFOR = :CLIFOR ';
  end;

  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    dtaBase : TDateTime;
    strTurno : String;
begin
  Result := '';

  If Not (fConfiguracao('EXITUR') = 'S') Then
    Exit;

  If (fConfiguracao('TURDAD') = 'N') Then
    Exit;

  If Not fTabelaExiste('MOVTRI') Then
    Exit;

  If Not fTabelaExiste('MOVDET') Then
    Exit;

  If (Not fCampoExiste('MOVTRI', 'DET_TURENT')) Then
    Exit;

  If (Not fCampoExiste('MOVDET', 'DET_DTAFUT')) Then
    Exit;

  qryAux := fCriaQuery(Nil);

  With qryAux Do
  Begin
    SQL.Clear;
    SQL.Add(fSQLBase('MOVDET'));
    SQL.Add(' UNION ALL ');
    SQL.Add(fSQLBase('NOTDET'));
    SQL.Add(' ORDER BY DET_DTAFUT DESC ');
    ParamByName('NUMDOC').AsString := FNumDoc;
    ParamByName('ESPDOC').AsString := FEspDoc;
    ParamByName('SERIE_').AsString := FSerie;
    ParamByName('CODEMP').AsString := FCodEmp;
    ParamByName('TIP_FC').AsString := FTip_FC;
    ParamByName('CLIFOR').AsString := FCodCli;
    Open;

    If (Not IsEmpty) Then
    Begin

      First;

      dtaBase := FieldByName('DET_DTAFUT').AsDateTime;
      strTurno := FieldByName('DET_TURENT').AsString;

      While Not Eof Do
      Begin

        If (AnsiSameText(strTurno, 'Noite')) Or (RecordCount = 1) Then
          Break;

        If fEmptyStr(FieldByName('DET_TURENT').AsString) Then
        Begin
          Next;
          Continue;
        End;

        If (dtaBase = FieldByName('DET_DTAFUT').AsDateTime) Then
        Begin
          If fEmptyStr(strTurno) Then
            strTurno := FieldByName('DET_TURENT').AsString;

          If fIdxTurno(FieldByName('DET_TURENT').AsString) > fIdxTurno(strTurno) Then
            strTurno := FieldByName('DET_TURENT').AsString;
        End;

        Next;
      End;

      Result := 'PREVISAO DE ENTREGA ATÉ ' + FormatDateTime('dd/MM/yyyy', dtaBase);

      If Not fEmptyStr(strTurno) Then
        Result := Result + ', NO PERÍODO DA ' + strTurno;

      Result := Result + '.#';
    End;

  End;

  FreeAndNil(qryAux);
end;

function TFonteDadosBD.fGetDadosReboqueManifesto(strPlaca: string): TDadosReboque;
var
  qryDados: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := nil;
  qryDados := fCriaQuery(nil);
  try
    qryDados.SQL.Add('SELECT ');
    qryDados.SQL.Add('  VEI_TARAKG, ');
    qryDados.SQL.Add('  VEI_CAPCAR, ');
    qryDados.SQL.Add('  VEI_TPCARR ');
    qryDados.SQL.Add('FROM ');
    qryDados.SQL.Add('  CADVEI ');
    qryDados.SQL.Add('WHERE ');
    qryDados.SQL.Add('  VEI_PLAVEI = :PLAVEI ');

    qryDados.ParamByName('PLAVEI').AsString := strPlaca;
    qryDados.Open;
    if not qryDados.IsEmpty then
      Result := TDadosReboque.create(strPlaca,
                                     LeftStr(qryDados.FieldByName('VEI_TPCARR').AsString, 2),
                                     qryDados.FieldByName('VEI_TARAKG').AsInteger,
                                     qryDados.FieldByName('VEI_CAPCAR').AsInteger);
    qryDados.Close;
  finally
    FreeAndNil(qryDados);
  end;
end;

function TFonteDadosBD.fGetDadosVeiculoManifesto(strPlaca: string): TDadosVeiculo;
var
  qryDados: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := nil;
  qryDados := fCriaQuery(nil);
  try
    qryDados.SQL.Add('SELECT ');
    qryDados.SQL.Add('  VEI_TARAKG, ');
    qryDados.SQL.Add('  VEI_TIPROD, ');
    qryDados.SQL.Add('  VEI_TPCARR ');
    qryDados.SQL.Add('FROM ');
    qryDados.SQL.Add('  CADVEI ');
    qryDados.SQL.Add('WHERE ');
    qryDados.SQL.Add('  VEI_PLAVEI = :PLAVEI ');

    qryDados.ParamByName('PLAVEI').AsString := strPlaca;
    qryDados.Open;
    if not qryDados.IsEmpty then
      Result := TDadosVeiculo.create(qryDados.FieldByName('VEI_TARAKG').AsInteger,
                                     LeftStr(qryDados.FieldByName('VEI_TIPROD').AsString, 2),
                                     LeftStr(qryDados.FieldByName('VEI_TPCARR').AsString, 2));
    qryDados.Close;
  finally
    FreeAndNil(qryDados);
  end;
end;

function TFonteDadosBD.fGetDocumentoRemessaConcreto(intSeqCcr: Integer): String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);

  With qryAux, SQL Do
  Begin
    Clear;
    
    Add('SELECT SQL_NO_CACHE ');
    Add('  CONCAT("DANFE: ", DET_NUMDOC,"-",DET_ESPDOC,"-",IFNULL(DET_SERIE_,"")) AS DOCUMENTO');
    Add('FROM');
    Add('  MOVDET D');
    Add('  INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM');
    Add('WHERE');
    Add('  D.DET_NUMFAT = :NUMDOC AND ');
    Add('  D.DET_TIPFAT = :ESPDOC AND ');

    If fCampoExiste('MOVDET', 'DET_SERFAT') Then
      Add('  D.DET_SERFAT = :SERDOC AND ');

    Add('  D.DET_EMPFAT = :CODEMP AND ');
    Add('  T.DET_SEQCCR = :SEQCCR');

    ParamByName('NUMDOC').AsString  := FNumDoc;
    ParamByName('ESPDOC').AsString  := FEspDoc;

    If fCampoExiste('MOVDET', 'DET_SERFAT') Then
      ParamByName('SERDOC').AsString  := FSerie;

    ParamByName('CODEMP').AsString  := FCodEmp;
    ParamByName('SEQCCR').AsInteger := intSeqCcr;

    Open;

    Result := FieldByName('DOCUMENTO').AsString;
  End;

  FreeAndNil(qryAux);
end;

function TFonteDadosBD.fGetEntGer(strNumDoc, strEspDoc, strCodEmp, strCodCli, strTip_Fc: String): String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    intCnt : Integer;
  Const
    arrAuxMovNot : Array[1..2] Of String[6] = ('AUXMOV', 'AUXNOT');
    arrGerMovNot : Array[1..2] Of String[6] = ('MOVGER', 'NOTGER');
begin
  Result := '';

  If Not fTabelaExiste('AUXMOV') Then
    Exit;

  If (Not fCampoExiste('AUXMOV', 'AUX_ENTGER')) Then
    Exit;

  qryAux := fCriaQuery(Nil);

  Try
    With qryAux Do
    Begin
      For intCnt := 1 To 2 Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT IFNULL(AUX_ENTGER,"") AUX_ENTGER ');
        SQL.Add('   FROM ' + String(arrAuxMovNot[intCnt]) );
        SQL.Add('  INNER JOIN ' + String(arrGerMovNot[intCnt]) + ' ON ' + String(arrGerMovNot[intCnt]) + '.AUTOINCREM = ' + String(arrAuxMovNot[intCnt]) + '.AUX_SEQGER  ');
        SQL.Add('  WHERE GER_NUMDOC = :NUMDOC ');
        SQL.Add('    AND GER_ESPDOC = :ESPDOC ');
        SQL.Add('    AND GER_CODEMP = :CODEMP ');
        SQL.Add('    AND GER_TIP_FC = :TIP_FC ');
        If (strTip_Fc = 'F') Then
          SQL.Add('  AND GER_CODFOR = :CODCLI ')
        Else
          SQL.Add('  AND GER_CODCLI = :CODCLI ');
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('TIP_FC').AsString := strTip_Fc;
        ParamByName('CODCLI').AsString := strCodCli;
        Open;

        If (RecordCount > 0) Then
        Begin
          Result := FieldByName('AUX_ENTGER').AsString;
          Break;
        End;
      End;
      Close;
    End;
  Except

  End;

  FreeAndNil(qryAux);
end;

function TFonteDadosBD.fGetEventoPagamentoOperacaoTransporte(strNumMan, strCodEmp: String): TEventoPagamentoOperacaoTransporte;
var
  qrySQL : {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  EventoPagamentoOperacaoTransporte : TEventoPagamentoOperacaoTransporte;
const
  strSQL = 'SELECT * FROM MDFEVE WHERE MDF_NUMMAN = :NUMMAN AND MDF_EMPMAN = :EMPMAN';
begin

  EventoPagamentoOperacaoTransporte := TEventoPagamentoOperacaoTransporte.Create;

  qrySQL := fCriaQuery(Nil);

  Try

    qrySQL.Close;
    qrySQL.SQL.Clear;
    qrySQL.SQL.Add(strSQL);
    qrySQL.ParamByName('NUMMAN').AsString := strNumMan;
    qrySQL.ParamByName('EMPMAN').AsString := strCodEmp;
    qrySQL.Open;

    If Not qrySQL.IsEmpty Then
    Begin
      EventoPagamentoOperacaoTransporte.intNumeroProtocolo   := qrySQL.FieldByName('MDF_NUMPRO').AsInteger;
      EventoPagamentoOperacaoTransporte.intQuantidadeViagens := qrySQL.FieldByName('MDF_QTDVIA').AsInteger;
      EventoPagamentoOperacaoTransporte.intNumeroViagem      := qrySQL.FieldByName('MDF_NUMVIA').AsInteger;
    End;

  Finally
    FreeAndNil(qrySQL);
  End;

  Result := EventoPagamentoOperacaoTransporte;

End;

function TFonteDadosBD.fGetManifesto(
  strNumeroManifesto: String): TManifestoEletronico;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    qrySeg: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    qryInfCompl: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    nfe: TNFeManifesto;
    segCar: TManifestoSegCar;
    segCarAverb: TManifestoSegCarAverb;
    InfComplContrib: TManifestoInfAdiContribuinte;
    iPosicao: Integer;
    strInfComplContrib: String;
    iLinha: Integer;
    cte: TCTeManifesto;
    strTipoDoc: string;
    strSerieMan: string;

    strCarregamentoCidade : String;
    strCarregamentoNomCid : String;
    strCarregamentoEstado : String;
    strCarregamento_IBGE_ : String;

    strDescarregamentoCidade : String;
    strDescarregamentoEstado : String;
    strDescarregamento_IBGE_ : String;
    strIbgeCarregamentoPosterior: String;
    strPrevisaoViagem : String;
    tipoImpressao: TTipoImpressao;

begin
  strTipoDoc := fTipoDocManifesto(strNumeroManifesto);
  strSerieMan := fConfiguracao('SERMDF');
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add(IIF(strTipoDoc = 'NFe', fGetSqlManifestoNFe, fGetSqlManifestoCTe));
  qryAux.ParamByName('CODEMP').AsString := objConfig.strCodEmp;
  qryAux.ParamByName('NUMMAN').AsString := strNumeroManifesto;
  qryAux.Open;

  strCarregamentoCidade := '';
  strCarregamentoNomCid := '';
  strCarregamentoEstado := '';
  strCarregamento_IBGE_ := '';

  If (qryAux.FindField('CIDADE_CARREGAMENTO') <> Nil) Then
    strCarregamentoCidade := qryAux.FieldByName('CIDADE_CARREGAMENTO').AsString;

  If (qryAux.FindField('NOMCID_CARREGAMENTO') <> Nil) Then
    strCarregamentoNomCid := qryAux.FieldByName('NOMCID_CARREGAMENTO').AsString;

  If (qryAux.FindField('ESTADO_CARREGAMENTO') <> Nil) Then
    strCarregamentoEstado := qryAux.FieldByName('ESTADO_CARREGAMENTO').AsString;

  If (qryAux.FindField('COIBGE_CARREGAMENTO') <> Nil) Then
    strCarregamento_IBGE_ := qryAux.FieldByName('COIBGE_CARREGAMENTO').AsString;

  strDescarregamentoCidade := '';
  strDescarregamentoEstado := '';
  strDescarregamento_IBGE_ := '';

  If (qryAux.FindField('CIDADE_DESCARREGAMENTO') <> Nil) Then
    strDescarregamentoCidade := qryAux.FieldByName('CIDADE_DESCARREGAMENTO').AsString;

  If (qryAux.FindField('ESTADO_DESCARREGAMENTO') <> Nil) Then
    strDescarregamentoEstado := qryAux.FieldByName('ESTADO_DESCARREGAMENTO').AsString;

  If (qryAux.FindField('COIBGE_DESCARREGAMENTO') <> Nil) Then
    strDescarregamento_IBGE_ := qryAux.FieldByName('COIBGE_DESCARREGAMENTO').AsString;

  strIbgeCarregamentoPosterior := fGetIbgeCarregamentoPosterior(objConfig.strEmpLog);

  strPrevisaoViagem := qryAux.FieldByName('PREVISAO_VIAGEM').AsString;

  tipoImpressao := tiPadrao;
  If fConfiguracao('NFIMDF') = 'S' Then
    tipoImpressao := tiNfeImpressao;

  Result := TManifestoEletronico.Create(strNumeroManifesto,
                                        fDadosEmitente,
                                        qryAux.FieldByName('DTAMAN').AsDateTime,
                                        qryAux.FieldByName('CPFMOT').AsString,
                                        qryAux.FieldByName('NOMMOT').AsString,
                                        qryAux.FieldByName('PLAMAN').AsString,
                                        objConfig.strCodEmp,
                                        IIF(qryAux.Locate('CARPOS', 'S', []), 'S', 'N'),
                                        fConfiguracao('VERMDF'),
                                        strDescarregamentoCidade,
                                        strDescarregamentoEstado,
                                        strDescarregamento_IBGE_,
                                        strIbgeCarregamentoPosterior,
                                        tipoImpressao,
                                        strCarregamentoCidade,
                                        strCarregamentoNomCid,
                                        strCarregamentoEstado,
                                        strCarregamento_IBGE_,
                                        strPrevisaoViagem);

  Result.strTipoDocumento := strTipoDoc;
  Result.strSerie := IIF(fEmptyStr(strSerieMan), '001', strSerieMan);

  if fCampoExiste('CADVEI', 'VEI_TIPROD') then
    Result.DadosVeiculo := fGetDadosVeiculoManifesto(qryAux.FieldByName('PLAMAN').AsString);

  if (qryAux.FindField('PLAMA2') <> Nil) and (not fEmptyStr(qryAux.FieldByName('PLAMA2').AsString)) then
    Result.DadosReboque1 := fGetDadosReboqueManifesto(qryAux.FieldByName('PLAMA2').AsString);

  if (qryAux.FindField('PLAMA3') <> Nil) and (not fEmptyStr(qryAux.FieldByName('PLAMA3').AsString)) then
    Result.DadosReboque2 := fGetDadosReboqueManifesto(qryAux.FieldByName('PLAMA3').AsString);

  if (qryAux.FindField('PLAMA4') <> Nil) and (not fEmptyStr(qryAux.FieldByName('PLAMA4').AsString)) then
    Result.DadosReboque3 := fGetDadosReboqueManifesto(qryAux.FieldByName('PLAMA4').AsString);

  qryAux.First;
  While (Not qryAux.Eof) Do
  Begin
    if (strTipoDoc = 'CTe') then
    begin
      cte := TCTeManifesto.Create(qryAux.FieldByName('ACESSO').AsString,
        qryAux.FieldByName('COIBGE').AsString,
        qryAux.FieldByName('PESBRU').AsFloat,
        qryAux.FieldByName('VLRCON').AsFloat,
        qryAux.FieldByName('ESTADO').AsString,
        qryAux.FieldByName('PERCUR').AsString,
        qryAux.FieldByName('AUTOINCREM').AsString);
      Result.pAddCte(cte);

      Result.pAddInfContratante(
        TInformacoesContratantes.Create(
          qryAux.FieldByName('CNPJ_CPF_TOMADOR').AsString,
          Copy(qryAux.FieldByName('NOME_TOMADOR').AsString, 1, 60)));
    end
    else
    begin
      nfe := TNFeManifesto.Create(qryAux.FieldByName('ACESSO').AsString,
        qryAux.FieldByName('COIBGE').AsString,
        qryAux.FieldByName('PESBRU').AsFloat,
        qryAux.FieldByName('VLRCON').AsFloat,
        qryAux.FieldByName('ESTADO').AsString,
        qryAux.FieldByName('PERCUR').AsString,
        qryAux.FieldByName('AUTOINCREM').AsString);
      Result.pAddNfe(nfe);

      if (fTabelaExiste('MDFPRO')) and
         (fCampoExiste('MDFPRO', 'MDF_NOMRAZ')) and
         (not fEmptyStr(fCampoTabela('MDF_NOMRAZ','MDFPRO', ['MDF_NUMMAN', 'MDF_EMPMAN'],[strNumeroManifesto, objConfig.strCodEmp]))) then
        Result.pAddInfContratante(
          TInformacoesContratantes.Create(
            dadosEmitente.strCnpj,
            Copy(dadosEmitente.strRazao, 1, 60)));
    end;

    qryAux.Next;
  End;

  If (fTabelaExiste('FISMOT')) Then
  Begin
    qrySeg := fCriaQuery(Nil);
    Try
      qrySeg.SQL.Add('SELECT FMO_CODMOT, MOT_CPFMOT, MOT_NOMMOT');
      qrySeg.SQL.Add('FROM FISMOT');
      qrySeg.SQL.Add('JOIN CADMOT ON MOT_CODMOT = FMO_CODMOT');
      qrySeg.SQL.Add('WHERE FMO_SEQGER = :SEQGER');
      qrySeg.ParamByName('SEQGER').AsString := qryAux.FieldByName('AUTOINCREM').AsString;
      qrySeg.Open;
      while not qrySeg.Eof do
      begin
        Result.pAddMotorista(
          TManifestoMotorista.Create(
            qrySeg.FieldByName('MOT_CPFMOT').AsString,
            qrySeg.FieldByName('MOT_NOMMOT').AsString));

        qrySeg.Next;
      end;
    Finally
      qrySeg.Free;
    End;
  End;

  If (fTabelaExiste('MDFSEG')) And (fTabelaExiste('MDFAVE')) And
     (qryAux.FindField('EMPMAN') <> Nil) And
     (Not fEmptyStr(qryAux.FieldByName('EMPMAN').AsString)) Then
  Begin
    qrySeg := fCriaQuery(Nil);
    Try
      qrySeg.SQL.Text := 'SELECT * FROM MDFSEG WHERE MDF_NUMMAN = :NUMMAN AND MDF_EMPMAN = :EMPMAN ORDER BY MDF_SEQUEN';
      qrySeg.ParamByName('NUMMAN').AsString := strNumeroManifesto;
      qrySeg.ParamByName('EMPMAN').AsString := qryAux.FieldByName('EMPMAN').AsString;
      qrySeg.Open;

      qrySeg.First;
      While Not qrySeg.Eof Do
      Begin
        segCar := TManifestoSegCar.Create(qrySeg.FieldByName('MDF_SEQUEN').AsInteger,
                                          qrySeg.FieldByName('MDF_RESSEG').AsInteger,
                                          qrySeg.FieldByName('MDF_RESCPF').AsString,
                                          qrySeg.FieldByName('MDF_NOMSEG').AsString,
                                          qrySeg.FieldByName('MDF_SEGCNP').AsString,
                                          qrySeg.FieldByName('MDF_NUMAPO').AsString
                                          );
        Result.pAddSeqCarga(segCar);

        qrySeg.Next;
      End;

      qrySeg.Close;
      qrySeg.SQL.Text := 'SELECT * FROM MDFAVE WHERE MDF_NUMMAN = :NUMMAN AND MDF_EMPMAN = :EMPMAN ORDER BY MDF_SEQUEN';
      qrySeg.ParamByName('NUMMAN').AsString := strNumeroManifesto;
      qrySeg.ParamByName('EMPMAN').AsString := qryAux.FieldByName('EMPMAN').AsString;
      qrySeg.Open;

      qrySeg.First;
      While Not qrySeg.Eof Do
      Begin
        segCarAverb := TManifestoSegCarAverb.Create(qrySeg.FieldByName('MDF_SEQUEN').AsInteger,
                                                    qrySeg.FieldByName('MDF_NUMAVE').AsString
                                                    );
        Result.pAddSeqCargaAverb(segCarAverb);

        qrySeg.Next;
      End;
    Finally
      FreeAndNil(qrySeg);
    End;
  End;

  If (fTabelaExiste('MDFINC')) And
     (qryAux.FindField('EMPMAN') <> Nil) And
     (Not fEmptyStr(qryAux.FieldByName('EMPMAN').AsString)) Then
  Begin
    qryInfCompl := fCriaQuery(Nil);
    Try
      qryInfCompl.SQL.Text := 'SELECT * FROM MDFINC WHERE MDF_NUMMAN = :NUMMAN AND MDF_EMPMAN = :EMPMAN';
      qryInfCompl.ParamByName('NUMMAN').AsString := strNumeroManifesto;
      qryInfCompl.ParamByName('EMPMAN').AsString := qryAux.FieldByName('EMPMAN').AsString;
      qryInfCompl.Open;

      qryInfCompl.First;
      While Not qryInfCompl.Eof Do
      Begin
        iPosicao := 0;
        iLinha := 1;
        strInfComplContrib := qryInfCompl.FieldByName('MDF_INFCOM').AsString;
        Repeat
          If iPosicao > 0 Then
            strInfComplContrib := RightStr(strInfComplContrib, Length(qryInfCompl.FieldByName('MDF_INFCOM').AsString) - iPosicao);
          iPosicao := iPosicao + 254;
          If (Not fEmptyStr(LeftStr(strInfComplContrib, 254))) And (iLinha <= 50) Then
          Begin
            InfComplContrib := TManifestoInfAdiContribuinte.Create(LeftStr(strInfComplContrib, 254));
            Result.pAddSeqInfComplContrib(InfComplContrib);
          End;
          inc(iLinha);
          If iLinha > 50 Then
            strInfComplContrib := '';
        Until fEmptyStr(strInfComplContrib);

        qryInfCompl.Next;
      End;
    Finally
      FreeAndNil(qryInfCompl);
    End;
  End;

  If (Not fEmptyStr(objConfig.strCodEmp)) And (Not fEmptyStr(strNumeroManifesto)) Then
  Begin

    {Proprietário do Veículo}
    If fTabelaExiste('MDFPRO') Then
      Result.ProprietarioVeiculo := fGetProprietarioVeiculo(strNumeroManifesto, objConfig.strCodEmp);

    {Produto Predominante}
    If fTabelaExiste('MDFPPR') Then
      Result.ProdutoPredominante := fGetProdutoPredominante(strNumeroManifesto, objConfig.strCodEmp);

    {Evento Pagamento da Operação de Transporte}
    If fTabelaExiste('MDFEVE') Then
      Result.EventoPagamentoOperacaoTransporte := fGetEventoPagamentoOperacaoTransporte(strNumeroManifesto, objConfig.strCodEmp);

    {Informações do Pagamento do Frete (Componentes e Prazos)}
    If fTabelaExiste('MDFPAG') And fTabelaExiste('MDFCOM') And fTabelaExiste('MDFPRA') Then
      pAddInformacoesPagamentoFrete(Result, strNumeroManifesto, objConfig.strCodEmp);

  End;

  FreeAndNil(qryAux);
end;

function TFonteDadosBD.fGetManifestoCompacto(
  strNumeroManifesto: String): TManifestoEletronico;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strIbgeCarregamentoPosterior: String;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  FIS_DTAMAN, FIS_ACEMAN, ');

  if fCampoExiste('CADFIS', 'FIS_CARPOS') then
  begin
    qryAux.SQL.Add('  IFNULL(FIS_CARPOS, "N") AS CARPOS ');
  end
  else
  begin
    qryAux.SQL.Add('  "N" AS CARPOS ');
  end;

  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADFIS ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FIS_NUMMAN = :NUMMAN AND ');
  if fCampoExiste('CADFIS', 'FIS_EMPMAN') then
    qryAux.SQL.Add('FIS_EMPMAN = :CODEMP')
  else
    qryAux.SQL.Add('FIS_CODEMP = :CODEMP');

  qryAux.ParamByName('CODEMP').AsString := objConfig.strCodEmp;
  qryAux.ParamByName('NUMMAN').AsString := strNumeroManifesto;
  qryAux.Open;

  strIbgeCarregamentoPosterior := fGetIbgeCarregamentoPosterior(objConfig.strEmpLog);

  Result := TManifestoEletronico.Create(strNumeroManifesto,
                                        fDadosEmitente,
                                        qryAux.FieldByName('FIS_DTAMAN').AsDateTime,
                                        '',
                                        '',
                                        '',
                                        objConfig.strCodEmp,
                                        IIF(qryAux.Locate('CARPOS', 'S', []), 'S', 'N'),
                                        fConfiguracao('VERMDF'),
                                        '',
                                        '',
                                        '',
                                        strIbgeCarregamentoPosterior);

  Result.SetChaveAcesso(qryAux.FieldByName('FIS_ACEMAN').AsString);

  FreeAndNil(qryAux);
end;

function TFonteDadosBD.fGetIbgeCarregamentoPosterior(strEmpLog: string): String;
var
  qryDados: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strCodIbge: String;
  strUfIbge: String;
  strEstado: String;
  strCidade: String;
begin
  Result := '';

  If fEmptyStr(strEmpLog) Then
    Exit;

  qryDados := fCriaQuery(nil);

  try
    qryDados.SQL.Add('SELECT ');
    qryDados.SQL.Add('  EMP_CODCID ');
    qryDados.SQL.Add('FROM ');
    qryDados.SQL.Add('  CADEMP E ');
    qryDados.SQL.Add('JOIN CADCID ON CID_CODCID = E.EMP_CODCID ');
    qryDados.SQL.Add('WHERE ');
    qryDados.SQL.Add('  E.EMP_CODEMP = :CODEMP ');

    qryDados.ParamByName('CODEMP').AsString := strEmpLog;
    qryDados.Open;

    pRetornaDadosIbge(qryDados.FieldByName('EMP_CODCID').AsString, strCodIbge, strUfIbge, strEstado, strCidade);

    Result := strCodIbge;

  finally
    FreeAndNil(qryDados);
  end;
end;

function TFonteDadosBD.fGetProdutoPredominante(strNumMan, strCodEmp: String): TProdutoPredominante;
var
  qrySQL : {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  ProdutoPredominante : TProdutoPredominante;
const
  strSQL = 'SELECT * FROM MDFPPR WHERE MDF_NUMMAN = :NUMMAN AND MDF_EMPMAN = :EMPMAN';
begin

  ProdutoPredominante := TProdutoPredominante.Create;

  qrySQL := fCriaQuery(Nil);

  Try

    qrySQL.Close;
    qrySQL.SQL.Clear;
    qrySQL.SQL.Add(strSQL);
    qrySQL.ParamByName('NUMMAN').AsString := strNumMan;
    qrySQL.ParamByName('EMPMAN').AsString := strCodEmp;
    qrySQL.Open;

    If Not qrySQL.IsEmpty Then
    Begin
      ProdutoPredominante.strTipoDeCarga                         := qrySQL.FieldByName('MDF_TIPCAR').AsString;
      ProdutoPredominante.strDescricaoProdutoPredominante        := qrySQL.FieldByName('MDF_DESPRO').AsString;
      ProdutoPredominante.strCEAN_GTIN                           := qrySQL.FieldByName('MDF_C_GTIN').AsString;
      ProdutoPredominante.strNCM                                 := qrySQL.FieldByName('MDF_CODNCM').AsString;
      ProdutoPredominante.strCEPLocalizacaoCarregamento          := qrySQL.FieldByName('MDF_CEPCAR').AsString;
      ProdutoPredominante.strLatitudeLocalizacaoCarregamento     := qrySQL.FieldByName('MDF_LATCAR').AsString;
      ProdutoPredominante.strLongitudeLocalizacaoCarregamento    := qrySQL.FieldByName('MDF_LONCAR').AsString;
      ProdutoPredominante.strCEPLocalizacaoDescarregamento       := qrySQL.FieldByName('MDF_CEPDES').AsString;
      ProdutoPredominante.strLatitudeLocalizacaoDescarregamento  := qrySQL.FieldByName('MDF_LATDES').AsString;
      ProdutoPredominante.strLongitudeLocalizacaoDescarregamento := qrySQL.FieldByName('MDF_LONDES').AsString;
    End;

  Finally
    FreeAndNil(qrySQL);
  End;

  Result := ProdutoPredominante;

End;

function TFonteDadosBD.fGetProprietarioVeiculo(strNumMan, strCodEmp: String): TProprietarioVeiculo;
var
  qrySQL : {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  ProprietarioVeiculo : TProprietarioVeiculo;
const
  strSQL = 'SELECT * FROM MDFPRO WHERE MDF_NUMMAN = :NUMMAN AND MDF_EMPMAN = :EMPMAN';
begin

  ProprietarioVeiculo := TProprietarioVeiculo.Create;

  qrySQL := fCriaQuery(Nil);

  Try

    qrySQL.Close;
    qrySQL.SQL.Clear;
    qrySQL.SQL.Add(strSQL);
    qrySQL.ParamByName('NUMMAN').AsString := strNumMan;
    qrySQL.ParamByName('EMPMAN').AsString := strCodEmp;
    qrySQL.Open;

    If Not qrySQL.IsEmpty Then
    Begin
      ProprietarioVeiculo.strCPF_CNPJ          := qrySQL.FieldByName('MDF_CPFCNP').AsString;
      ProprietarioVeiculo.strRNTRC             := qrySQL.FieldByName('MDF_RNTRC_').AsString;
      ProprietarioVeiculo.strNomeRazaoSocial   := qrySQL.FieldByName('MDF_NOMRAZ').AsString;
      ProprietarioVeiculo.strInscricaoEstadual := qrySQL.FieldByName('MDF_INSEST').AsString;
      ProprietarioVeiculo.strEstado            := qrySQL.FieldByName('MDF_UF_PRO').AsString;
      ProprietarioVeiculo.intTipoProprietario  := qrySQL.FieldByName('MDF_TIPPRO').AsInteger;
    End;

  Finally
    FreeAndNil(qrySQL);
  End;

  Result := ProprietarioVeiculo;

End;

procedure TFonteDadosBD.pRetCstSimplesProdSubstituidos;
  Var
    strCfg: String;
begin
  If fEmptyStr(fConfiguracao('CSTSSC')) Then
    strCfg := 'CSTSSC'
  Else
    strCfg := IIF(fDadosGerais.strCliCon='S', 'CSTSSB', 'CSTSSC');

  objConfig.strCstSimSubs := fConfiguracao(strCfg);

  If fEmptyStr(fConfiguracao('CSTNSF')) Then
    strCfg := 'CSTSSF'
  Else
    strCfg := IIF(fDadosGerais.strCliCon='S', 'CSTSSF', 'CSTNSF');

  objConfig.strCstSimSubsForaEstado := fConfiguracao(strCfg);

  If fEmptyStr(objConfig.strCstSimSubsForaEstado) Then
    objConfig.strCstSimSubsForaEstado := objConfig.strCstSimSubs;

  if (fDadosGerais.strOriundoOS = 'S') and (fConfiguracao('SIMPAU') = 'S') and (fConfiguracao('CSTCEQ') = 'S') then
    objConfig.strCstSimTrib := '102'
  else
    objConfig.strCstSimTrib := fConfiguracao('CSTSTR');

  objConfig.strCstSimTribCI := fConfiguracao('CSTSTC');

  objConfig.strAPCSOS := fConfiguracao('APCSOS');
end;

procedure TFonteDadosBD.pRetCfgImpValorIpiDadosPropriosCFOPNaoVenda;
begin
  objConfig.strOpcImpValIpi := fConfiguracao('IVLIPI');
end;

function TFonteDadosBD.fRetDesCndPagamento(strCodCnd: String): String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT CND_DESCRI FROM CADCND WHERE CND_CODIGO = :CODCND');
    qryAux.ParamByName('CODCND').AsString := strCodCnd;
    qryAux.Open;
    Result := qryAux.FieldByName('CND_DESCRI').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fCampoExiste(const strTabela, strCampo: String): Boolean;
  {$IF Defined(UNIDAC)}
  Var
    strKey: String;
  {$IFEND}
begin
  {$IF Defined(UNIDAC)}
  strKey := fFormataKeyCmpExiParaDicSis(strTabela, strCampo);
  If fAchouDicSisBln(Database, strKey, Result) Then
    Exit;
  {$IFEND}

  Result := fTabelaCampoExiste(Database, strTabela, strCampo);

  {$IF Defined(UNIDAC)}
  pInsereDicSis(Database, strKey, fBooleanToStringDisSis(Result));
  {$IFEND}
end;

{***********************************************}
{* RETORNA O VALOR DE UM DETERMINADO CAMPO     *}
{* DE UMA TABELA PASSANDO COMO PARAMETROS      *}
{* OS CAMPOS CHAVES E SEUS VALORES (WHERE)     *}
{* PODE SER UTIL PARA RETORNAR DESDE DESCRICAO *}
{* ATE VALORES, DATAS ENTRE OUTROS             *}
{********************************************JC*}
function TFonteDadosBD.fCampoTabela(strCampo : String;
                                    strNomTab: String;
                                    arrCampoChave: Array Of String;
                                    arrValorChave: Array Of Variant): Variant;
  Const
    arrParms : Array [0..11] Of String[1] = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L');

  Var
    intCont  : Integer;
    strSQL   : String;
    qryGenGer: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin
  Try
    qryGenGer := fCriaQuery(nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  ' + strCampo + ' ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ' + strNomTab + ' ';
    strSQL := strSQL + 'WHERE ';

    For intCont := 0 To Length(arrCampoChave) -1 Do
    Begin
      If Pos('<>', arrCampoChave[intCont]) > 0 Then
        strSQL := strSQL + '  ' + arrCampoChave[intCont] + ' :' + String(arrParms[intCont]) + ' AND '
      Else
        strSQL := strSQL + '  ' + arrCampoChave[intCont] + ' = :' + String(arrParms[intCont]) + ' AND ';
    End;

    strSQL := strSQL + '  TRUE  ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      For intCont := 0 To Length(arrCampoChave) -1 Do
        ParamByName(String(arrParms[intCont])).Value := arrValorChave[intCont];

      Open;

      Result := Fields[0].Value;

      {*******************************************}
      {* EXECUTA UM CAST PARA NAO RETORNAR NULL  *}
      {****************************************JC*}
      Case Fields[0].DataType Of
        ftString, ftWideString, ftFixedChar: Result := Fields[0].AsString;
        ftMemo, ftFmtMemo: Result := Fields[0].AsString;
        ftFloat  : Result := Fields[0].AsFloat;
        ftInteger: Result := Fields[0].AsInteger;
        ftBoolean: Result := Fields[0].AsBoolean;
        ftDate   : Result := Fields[0].AsDateTime;
        ftTime   : Result := Fields[0].AsDateTime;
      else
        Result := VarToStrDef(Fields[0].Value, '');
      End;

    End;

  Finally
    FreeAndNil(qryGenGer);
  End;

End;

function TFonteDadosBD.fNotaServicoEletronica: Boolean;
begin
  Result := (FEspDoc = 'NS');
end;

function TFonteDadosBD.fNotaServicoEletronicaConcreto: Boolean;
begin
  Result := fNotaServicoEletronica And Assigned(qryDados) And
            (Not fEmptyStr(qryDados.FieldByName('DET_SEQCCR').AsString));
end;

function TFonteDadosBD.fConfiguracao(strCodCfg: String; strCodEmpPar : String = ''): String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strRes,
    strAux : String;
    {$IF Defined(UNIDAC)}
    strKey: String;
    {$IFEND}
begin
  If SameText(strCodCfg, 'CLIATI') Then
    raise Exception.Create('"CFG_CLIATI" obsoleta, utilizar: "fAtividadeConstrutora" ou "fRetAtividades" ');

  qryAux := fCriaQuery(Nil);
  Try
    Try
      {$IF Defined(UNIDAC)}
      If (Trim(strCodEmpPar) = '') Then
        strKey := fFormataKeyValCfgParaDicSis(strCodCfg, objConfig.strCodEmp)
      Else
        strKey := fFormataKeyValCfgParaDicSis(strCodCfg, strCodEmpPar);
      If fAchouDicSisStr(qryAux.Connection, strKey, Result) Then
        Exit;
      {$IFEND}

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT ');
      qryAux.SQL.Add('  SIS_CODCFG,');
      qryAux.SQL.Add('  SIS_VALCFG ');
      qryAux.SQL.Add('FROM ');
      qryAux.SQL.Add('  CFGSIS ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  SIS_CODCFG = :CODCFG AND ');
      qryAux.SQL.Add('  SIS_CODEMP = :CODEMP ');

      If (Trim(strCodEmpPar) = '') Then
        qryAux.ParamByName('CODEMP').AsString := objConfig.strCodEmp
      Else
        qryAux.ParamByName('CODEMP').AsString := strCodEmpPar;
      qryAux.ParamByName('CODCFG').AsString := 'CFG_' + strCodCfg;

      qryAux.Open;

      strRes := qryAux.FieldByName('SIS_VALCFG').AsString;

      {**********************************************************}
      {* VALIDAÇÃO PARA TESTAR SE JÁ É UMA CHAVE CRIPTROGRAFADA *}
      {********************************************************VA}
      If Pos(qryAux.FieldByName('SIS_CODCFG').AsString, consChavesCript) > 0 Then
      Begin
        strAux:=fDecrypt(strRes);
        If fCrypt(strAux) = strRes Then
          Result := fDecrypt(strRes)
        Else
          Result := strRes;
      End
      Else
        Result := strRes;
    Except
      Result := '';
    End;
    {$IF Defined(UNIDAC)}
    pInsereDicSis(qryAux.Connection, strKey, Result);
    {$IFEND}
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fConfiguracaoExiste(strCodCfg: String): Boolean;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    {$IF Defined(UNIDAC)}
    strKey: String;
    {$IFEND}
begin
  qryAux := fCriaQuery(Nil);
  Try
    {$IF Defined(UNIDAC)}
    strKey := fFormataKeyCfgExiParaDicSis(strCodCfg, objConfig.strCodEmp);
    If fAchouDicSisBln(qryAux.Connection, strKey, Result) Then
      Exit;
    {$IFEND}

    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT ');
      qryAux.SQL.Add('  SIS_CODCFG AS CONFIG_EXISTE ');
      qryAux.SQL.Add('FROM ');
      qryAux.SQL.Add('  CFGSIS ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  SIS_CODCFG = :CODCFG AND ');
      qryAux.SQL.Add('  SIS_CODEMP = :CODEMP ');

      qryAux.ParamByName('CODEMP').AsString := objConfig.strCodEmp;
      qryAux.ParamByName('CODCFG').AsString := 'CFG_' + strCodCfg;

      qryAux.Open;

      Result := (Not qryAux.IsEmpty);

      qryAux.Close;
    Except
      Result := False;
    End;
    {$IF Defined(UNIDAC)}
    pInsereDicSis(qryAux.Connection, strKey, fBooleanToStringDisSis(Result));
    {$IFEND}
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fConfirmacaoTransfEstoque: Boolean;
begin
  Result := False;

  If qryDados.FindField('GER_OPCDOC') = Nil Then
    Exit;

  Result := (qryDados.FieldByName('GER_OPCDOC').AsString = 'CT');
end;

function TFonteDadosBD.fObterCodFabMovGad(pstrIncDet: String): String;
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strSql: String;
begin
  Result := '';

  If Not fCampoExiste('MOVGAD', 'GAD_CODFAB') Then
    Exit;

  strSql := ' SELECT D.AUTOINCREM, D2.GAD_CODFAB ';
  strSql := strSql + ' FROM MOVDET D ';
  strSql := strSql + ' JOIN MOVGAE E ON E.GAE_NUMENV = D.DET_NUMDOC AND E.GAE_ESPENV = D.DET_ESPDOC AND E.GAE_EMPENV = D.DET_CODEMP ';
  strSql := strSql + ' JOIN MOVGAD D2 ON D2.AUTOINCREM = E.GAE_SEQGAD AND D2.GAD_CODITE = D.DET_CODITE ';
  strSql := strSql + ' WHERE D.AUTOINCREM = :INCDET ';

  Try
    qryAux := fCriaQuery(Nil);
    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(strSql);
      qryAux.ParamByName('INCDET').AsString := pstrIncDet;
      qryAux.Open;

      if qryAux.IsEmpty then
        Exit;

      qryAux.First;
      Result := qryAux.FieldByName('GAD_CODFAB').AsString;
      qryAux.Close;
    Finally
      FreeAndNil(qryAux);
    End;
  Except
    {caso a versão utilizada não tenha alguma das colunas mencionadas no select}
  End;
end;

function TFonteDadosBD.fOperacaoRegimeEspecial: Boolean;
begin
  Result := False;

  If qryDados.FindField('AUX_REGES2') = Nil Then
    Exit;

  Result := (qryDados.FieldByName('AUX_REGES2').AsString = 'S');
end;

function TFonteDadosBD.fAtividadeConstrutora(strCodAti: String): Boolean;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If (Not fEmptyStr(objConfig.strVS_CliAti)) Then
  Begin
    Result := (Pos(strCodAti, objConfig.strVS_CliAti) > 0);
  End
  Else
  Begin
    qryAux := fCriaQuery(Nil);
    Try
      If fTabelaExiste('CLIATI') Then
      Begin
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add('SELECT ATI_CODATI ');
        qryAux.SQL.Add('  FROM CLIATI ');
        qryAux.SQL.Add(' WHERE ATI_CODATI = :CODATI ');
        qryAux.SQL.Add('   AND ATI_CODEMP = :CODEMP ');
        qryAux.ParamByName('CODATI').AsString := strCodAti;
        qryAux.ParamByName('CODEMP').AsString := objConfig.strCodEmp;
        qryAux.Open;
        Result := (Not qryAux.IsEmpty);
        qryAux.Close;
      End
      Else
      Begin
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add('SELECT SIS_VALCFG ');
        qryAux.SQL.Add('  FROM CFGSIS ');
        qryAux.SQL.Add(' WHERE SIS_CODCFG = "CFG_CLIATI" ');
        qryAux.SQL.Add('   AND SIS_CODEMP = :CODEMP ');
        qryAux.ParamByName('CODEMP').AsString := objConfig.strCodEmp;
        qryAux.Open;
        Result := (qryAux.FieldByName('SIS_VALCFG').AsString = strCodAti);
        qryAux.Close;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        Exception.Create(E.Message + ' [TFonteDadosBD.fAtividadeConstrutora]');
      End;
    End;

    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fRetAtividades: String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  Try
    If fTabelaExiste('CLIATI') Then
    Begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT ATI_CODATI ');
      qryAux.SQL.Add('  FROM CLIATI ');
      qryAux.SQL.Add(' WHERE ATI_CODEMP = :CODEMP ');
      qryAux.ParamByName('CODEMP').AsString := objConfig.strCodEmp;
      qryAux.Open;

      Result := '---_';

      qryAux.First;
      While Not qryAux.Eof Do
      Begin
        Result := Result + qryAux.FieldByName('ATI_CODATI').AsString + '_';
        qryAux.Next;
      End;

      qryAux.Close;
    End
    Else
    Begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT SIS_VALCFG ');
      qryAux.SQL.Add('  FROM CFGSIS ');
      qryAux.SQL.Add(' WHERE SIS_CODCFG = "CFG_CLIATI" ');
      qryAux.SQL.Add('   AND SIS_CODEMP = :CODEMP ');
      qryAux.ParamByName('CODEMP').AsString := objConfig.strCodEmp;
      qryAux.Open;
      Result := qryAux.FieldByName('SIS_VALCFG').AsString;
      qryAux.Close;
    End;
  Except
    On E: Exception Do
    Begin
      Result := '';
      Exception.Create(E.Message + ' [TFonteDadosBD.fRetAtividades]');
    End;
  End;

  FreeAndNil(qryAux);
end;

function TFonteDadosBD.fDestacaNosDadosAdcionaisDuplicatasQuitadasCreditos: Boolean;
begin
  Result := False;

  If objConfigInterna.blnAgrDup Then
    Exit;

  If (fCfgSisFonte(Self, 'DUPADC') = 'S') Then
    Result := True;
end;

function TFonteDadosBD.fDeveEnviarIPIDevolvido: Boolean;
  Var
    strIPIDVF : String;
begin
  strIPIDVF := fConfiguracao('IPIDVF');
  If (strIPIDVF = 'N') Then
  Begin
    Result := True;
    Exit;
  End
  Else
    Result := (Assigned(qryDados.FindField('GER_MATREV'))) And (qryDados.FieldByName('GER_MATREV').AsString = 'I');
end;

function TFonteDadosBD.fRetCampoValOri(strAgrupamento: String=''): String;
begin
  if (fCfgSisFonte(Self, 'USABAC') = 'S') And (Not fDestacaNosDadosAdcionaisDuplicatasQuitadasCreditos) then
    Result := 'CTR_GRVORI'
  else
  begin
    If (fDestacaNosDadosAdcionaisDuplicatasQuitadasCreditos) Then
    Begin
      If (fCfgSisFonte(Self, 'USABAC') = 'S') And (Not fEmptyStr(fCfgSisFonte(Self, 'HISBAC'))) And fEmptyStr(strAgrupamento) Then
      Begin
        Result := Result + 'IF((CTR_SEQBAI = 0) AND (CTR_VALDUP > 0) AND ';
        Result := Result + '   ((SELECT COUNT(*) FROM CADREC AUX ';
        Result := Result + '      WHERE AUX.CTR_NUMDUP = CADREC.CTR_NUMDUP AND ';
        Result := Result + '            AUX.CTR_ESPDOC = CADREC.CTR_ESPDOC AND ';
        Result := Result + '            AUX.CTR_CODEMP = CADREC.CTR_CODEMP AND ';
        If fCampoExiste('CADREC', 'CTR_SERIE_') Then
          Result := Result + '          AUX.CTR_SERIE_ = CADREC.CTR_SERIE_ AND ';
        Result := Result + '            AUX.CTR_CODCLI = CADREC.CTR_CODCLI AND ';
        Result := Result + '            AUX.CTR_SEQBAI = 1 AND ';
        Result := Result + '            LOCATE(AUX.CTR_HISBAI,"'+fCfgSisFonte(Self, 'HISBAC')+'") > 0) > 0), CTR_VALDUP, CTR_VALORI)';
      End
      Else
      Begin
        Result := 'CTR_VALORI';
      End;
    End
    Else
    Begin
      Result := 'CTR_VALORI';
    End;
  end;

  If (objConfigInterna.blnAgrDup) Then
    Result := '  SUM(' + Result + ') AS CTR_VALORI, '
  Else
    Result := '  ' + Result + ' AS CTR_VALORI, ';
end;

procedure TFonteDadosBD.pCarregaConfiguracoes;
begin
  objConfig.strFitLicenca := fConfiguracao('CITLIC');
  objConfig.strFitUsuario := fConfiguracao('CITUSU');
  objConfig.strFitSenha   := fConfiguracao('CITSEN');
  objConfig.strFitUrlWebService := fConfiguracao('CITURL');

  objConfig.strFitImpressoraPadrao := fConfiguracao('CITIMP');

  objConfigProxy.strFitUsuarioProxy := fConfiguracao('CITUSP');
  objConfigProxy.strFitSenhaProxy := fConfiguracao('CITPSP');
  objConfigProxy.strFitProxy := fConfiguracao('CITPRX');
  objConfigProxy.strFitProxyByPass := fConfiguracao('CITPBP');

  objConfig.blnInfGar := False;

  If SameText(fConfiguracao('IMPGAR'), 'S')  Then
    objConfig.blnInfGar := True;

  objConfig.blnPRFCFB := True;
  If fConfiguracao('PRFCFB') = 'N' Then
    objConfig.blnPRFCFB := False;

  If fConfiguracao('NFEMAR') = EmptyStr Then
    objConfig.blnNFEMar := objConfig.blnNFEFab;

  objConfig.blnNfeFCI := fConfiguracao('NFEFCI') <> 'N';

  If SameText(fConfiguracao('AUTCEN'), 'S')  Then
    objConfig.blnAutCen := True
  Else
    objConfig.blnAutCen := False;

  If SameText(fConfiguracao('AGRDOC'), 'S')  Then
    objConfig.blnAgrDoc := True
  Else
    objConfig.blnAgrDoc := False;

  If SameText(fConfiguracao('NFIMDF'), 'S')  Then
    objConfig.blnNfiMdf := True
  Else
    objConfig.blnNfiMdf := False;

  Try
    objConfigInterna.strFitIntegradorImpressao := fConfiguracao('CITINT');
    objConfigInterna.strPontoVenda := fRetPontoVendaNFCe;
    objConfigInterna.strUrlNFCe    := '';//MORTA
    objConfigInterna.blnMonitoramentoTempo := False;
  Except
  End;

  Try
    objConfig.strFitUrlWebServiceManifesto := fConfiguracao('CITURM');
  Except
  End;

  Try
    objConfig.strFitUrlWebServiceConhecimento := fConfiguracao('CIUCTE');
  Except
  End;
end;

procedure TFonteDadosBD.pCarregaConfiguracoesInternas(
  var objConfig: TConfiguracoesInternas);
begin
  //
end;

function TFonteDadosBD.fRetPontoVendaNFCe: String;
  Var
    strPathOpcoesNFCe: String;
begin
  Result := '';
  strPathOpcoesNFCe := fConfiguracao('PTNFCE');
  If fEmptyStr(strPathOpcoesNFCe) Then
  Begin
    Exit;
  End;

  Result := fArqIniLocal(0, 'NFCE', 'PDV', '', strPathOpcoesNFCe + PATH_SEPARATOR + 'opcoes_nfce.ini');
end;

function TFonteDadosBD.fSuportaOperacaoBanco: Boolean;
begin
  Result := True;
end;

procedure TFonteDadosBD.pCarregaConfiguracoesNotaServico;
begin
  objConfigInterna.strPatNES := fConfiguracao('PATNES');
  objConfigInterna.strCliNES := fConfiguracao('CCLNSE');
  objConfigInterna.strReEsTr := fConfiguracao('REESTR');
  objConfigInterna.strNtOpNS := fConfiguracao('NTOPNS');
  objConfigInterna.blnSimISS := fConfiguracao('SIMISS') = 'S';
  objConfigInterna.blnZerIss := fConfiguracao('ZERISS') = 'S';
  objConfigInterna.strIteTax := fConfiguracao('ITETAX');
end;

function TFonteDadosBD.fTabelaExiste(strNomeTabela: String): Boolean;
  {$IF Defined(UNIDAC)}
  Var
    strKey: String;
  {$IFEND}
Begin
  If (fEmptyStr(strNomeTabela)) Then
  Begin
    Result := False;
    Exit;
  End;

  {$IF Defined(UNIDAC)}
  strKey := fFormataKeyTabExiParaDicSis(strNomeTabela);
  If fAchouDicSisBln(Database, strKey, Result) Then
    Exit;
  {$IFEND}

  Result := fTabelaCampoExiste(Database, strNomeTabela);

  {$IF Defined(UNIDAC)}
  pInsereDicSis(Database, strKey, fBooleanToStringDisSis(Result));
  {$IFEND}
End;

procedure TFonteDadosBD.pVerificaSeImprimePalavraAVistaDuplicata(dadosGerais: TDadosGerais);
begin
  If (fConfiguracao('IMPAVI') = 'P') And
     (Length(dadosGerais.arrDuplicatas) = 1) And
     (Assigned(dadosGerais.arrDuplicatas[0])) And
     (dadosGerais.arrDuplicatas[0].dtaDtaVen = dadosGerais.dtaDtaEnt) Then
  Begin
    dadosGerais.arrDuplicatas[0].strNumDup := 'A VISTA';
  End;
end;

procedure TFonteDadosBD.pAgrupaDocumentosFaturadosPorVendedor(dadosGerais: TDadosGerais);
  Var
    qryGenTmp: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strWhere: string;
begin

  If (IfEmptyStr(fConfiguracao('AGRDOC'), 'N') = 'N') Then
    Exit;

  strWhere := '';
  Try
    qryGenTmp := fCriaQuery(Nil);

    qryGenTmp.Close;
    qryGenTmp.SQL.Clear;

    qryGenTmp.SQL.Add( 'SELECT DISTINCT ');
    qryGenTmp.SQL.Add( '  DET_CODVEN AS CODVEN, OPE_NOMOPE, DET_ESPDOC AS ESPDOC, DET_NUMDOC AS NUMDOC, ');
    qryGenTmp.SQL.Add( '  DET_NUMFAT AS NUMFAT, DET_TIPFAT AS TIPFAT, DET_EMPFAT AS EMPFAT');
    qryGenTmp.SQL.Add( 'FROM ');
    qryGenTmp.SQL.Add( '  MOVDET ');
    qryGenTmp.SQL.Add( '  LEFT JOIN CADOPE ON OPE_CODOPE = DET_CODVEN ');
    qryGenTmp.SQL.Add( 'WHERE ');
    qryGenTmp.SQL.Add( '      DET_NUMFAT = :NUMFAT ');
    qryGenTmp.SQL.Add( '  AND DET_TIPFAT = :TIPFAT ');
    qryGenTmp.SQL.Add( '  AND DET_EMPFAT = :EMPFAT ');
    qryGenTmp.SQL.Add( '  AND DET_JAFATU = "1" ');
    qryGenTmp.SQL.Add( 'ORDER BY ');
    qryGenTmp.SQL.Add( '  DET_CODVEN ');
    qryGenTmp.ParamByName('NUMFAT').AsString := FNumDoc;
    qryGenTmp.ParamByName('TIPFAT').AsString := FEspDoc;
    qryGenTmp.ParamByName('EMPFAT').AsString := FCodEmp;
    qryGenTmp.Open;

    pGeraTextoDocumentosVendedor(dadosGerais.strVendedorOriginalDocumentos, qryGenTmp);

    if not qryGenTmp.IsEmpty then
    begin
      qryGenTmp.Close;
      qryGenTmp.SQL.Clear;

      qryGenTmp.SQL.Add( 'SELECT DISTINCT');
      qryGenTmp.SQL.Add( '  DET_ESPDOC, DET_NUMDOC, DET_CODEMP ');
      qryGenTmp.SQL.Add( 'FROM ');
      qryGenTmp.SQL.Add( '  MOVDET ');
      qryGenTmp.SQL.Add( 'WHERE ');
      qryGenTmp.SQL.Add( '      DET_NUMFAT = :NUMFAT ');
      qryGenTmp.SQL.Add( '  AND DET_TIPFAT = :TIPFAT ');
      qryGenTmp.SQL.Add( '  AND DET_EMPFAT = :EMPFAT ');
      qryGenTmp.SQL.Add( '  AND DET_JAFATU = "1" ');
      qryGenTmp.ParamByName('NUMFAT').AsString := FNumDoc;
      qryGenTmp.ParamByName('TIPFAT').AsString := FEspDoc;
      qryGenTmp.ParamByName('EMPFAT').AsString := FCodEmp;
      qryGenTmp.Open;

      while not qryGenTmp.Eof do
      begin
        if fEmptyStr(strWhere) then
          strWhere := ' ('
        else
          strWhere := strWhere + ' OR ';

        strWhere := strWhere + '(FDO_NUMFAT = "' + qryGenTmp.FieldByName('DET_NUMDOC').AsString +
                               '" AND FDO_TIPFAT = "' + qryGenTmp.FieldByName('DET_ESPDOC').AsString +
                               '" AND FDO_EMPFAT = "' + qryGenTmp.FieldByName('DET_CODEMP').AsString + '") ';

        qryGenTmp.Next;
      end;

      if not fEmptyStr(strWhere) then
        strWhere := strWhere + ')';
    end;

    qryGenTmp.Close;
    qryGenTmp.SQL.Clear;

    qryGenTmp.SQL.Add( 'SELECT DISTINCT ');
    qryGenTmp.SQL.Add( '  FDO_CODVEN AS CODVEN, OPE_NOMOPE, FDO_ESPDOC AS ESPDOC, FDO_NUMDOC AS NUMDOC, ');
    qryGenTmp.SQL.Add( '  FDO_NUMFAT AS NUMFAT, FDO_TIPFAT AS TIPFAT, FDO_EMPFAT AS EMPFAT ');
    qryGenTmp.SQL.Add( 'FROM ');
    qryGenTmp.SQL.Add( '  FATDOR');
    qryGenTmp.SQL.Add( '  LEFT JOIN CADOPE ON OPE_CODOPE = FDO_CODVEN ');
    qryGenTmp.SQL.Add( 'WHERE ');
    if fEmptyStr(strWhere) then
    begin
      qryGenTmp.SQL.Add( '      FDO_NUMFAT = :NUMFAT ');
      qryGenTmp.SQL.Add( '  AND FDO_TIPFAT = :TIPFAT ');
      qryGenTmp.SQL.Add( '  AND FDO_EMPFAT = :EMPFAT ');
    end
    else
      qryGenTmp.SQL.Add(strWhere);

    qryGenTmp.SQL.Add( '    AND FDO_JAFATU = "1" ');
    qryGenTmp.SQL.Add( 'ORDER BY ');
    qryGenTmp.SQL.Add( '  FDO_CODVEN ');

    if fEmptyStr(strWhere) then
    begin
      qryGenTmp.ParamByName('NUMFAT').AsString := FNumDoc;
      qryGenTmp.ParamByName('TIPFAT').AsString := FEspDoc;
      qryGenTmp.ParamByName('EMPFAT').AsString := FCodEmp;
    end;

    qryGenTmp.Open;

    pGeraTextoDocumentosVendedor(dadosGerais.strVendedorOriginalPedido, qryGenTmp);

    qryGenTmp.Close;
    qryGenTmp.SQL.Clear;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

procedure TFonteDadosBD.pPegaNumeroPedidosFaturados(dadosGerais: TDadosGerais);
  Var
    qryGenTmp: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin

  Try
    qryGenTmp := fCriaQuery(Nil);

    With qryGenTmp, SQL Do
    Begin
      Close;
      Clear;

      Add('SELECT GROUP_CONCAT(DISTINCT FDO_NUMDOC) AS PEDIDOS ');
      Add('FROM ');
      Add('  FATDOR ');
      Add('WHERE ');
      Add('  FDO_NUMFAT = :NUMFAT AND ');
      Add('  FDO_TIPFAT = :TIPFAT AND ');

      If fCampoExiste('FATDOR', 'FDO_SERFAT') Then
        Add('  FDO_SERFAT = :SERFAT AND ');

      Add('  FDO_EMPFAT = :EMPFAT ');
      Add('ORDER BY ');
      Add('  FDO_NUMDOC ');

      ParamByName('NUMFAT').AsString := FNumDoc;
      ParamByName('TIPFAT').AsString := FEspDoc;

      If fCampoExiste('FATDOR', 'FDO_SERFAT') Then
        ParamByName('SERFAT').AsString := FSerie;

      ParamByName('EMPFAT').AsString := FCodEmp;

      Open;

      dadosGerais.strDocsPD := FieldByName('PEDIDOS').AsString;

      Close;
    End;

  Except

  End;

  FreeAndNil(qryGenTmp);
end;

function TFonteDadosBD.fRetornaChaveAcesso: String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  FIS_ACESSO ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADFIS ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FIS_TIP_FC = :TIP_FC AND ');
  qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  FIS_FORCLI = :CODCLI AND ');
  qryAux.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ ');

  qryAux.ParamByName('TIP_FC').AsString := FTip_FC;
  qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
  qryAux.ParamByName('CODEMP').AsString := FCodEmp;
  qryAux.ParamByName('CODCLI').AsString := FCodCli;
  qryAux.ParamByName('SERIE_').AsString := FSerie;
  qryAux.Open;

  Result := qryAux.FieldByName('FIS_ACESSO').AsString;

  FreeAndNil(qryAux);
end;

function TFonteDadosBD.fRetornaEstadoEmpresa(strCnpj: String): String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  CID_ESTADO ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADEMP ');
  qryAux.SQL.Add('JOIN CADCID ON CID_CODCID = EMP_CODCID ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  EMP_C_G_C_ = :CGC ');

  qryAux.ParamByName('CGC').AsString := strCnpj;
  qryAux.Open;

  Result := qryAux.FieldByName('CID_ESTADO').AsString;

  FreeAndNil(qryAux);
end;

{**************************************************************}
{* NCO - SAIDA NAO CONTRIBUINTE (PF OU PJ SEM INSC. ESTADUAL) *}
{* CCO - SAIDA CONTRIBUINTE CONSUMIDOR                        *}
{* CNC - SAIDA CONTRIBUINTE NAO CONSUMIDOR                    *}
{* CTA - SAIDA CONSTRUTORA                                    *}
{* PRU - SAIDA PRODUTOR RURAL                                 *}
{* IND - SAIDA INDUSTRIA                                      *}
{**************************************************************}
function TFonteDadosBD.fGetTipAbfSaida(strFisJur, strIES, strProRur, strMicEmp, strConsum, strCodAti, strRegTri, strIndust: String; blnCliFil: Boolean): String;
begin
  Result := '_SAI_';

  If (fCampoExiste('ABFICM', 'ABF_ALQICM_SAI_TRS')) And  blnCliFil Then
    Result := Result + 'TRS'//TRS - SAIDAS TRANSFERENCIAS ENTRE LOJAS

  Else If (strProRur = 'S') And (Not fEmptyStr(fRetSQLMsg1e2TipAbfdeSAI('PRU'))) Then
    Result := Result + 'PRU'//PRU - PRODUTOR RURAL

  Else If (strIndust = 'S') And (Not fEmptyStr(fRetSQLMsg1e2TipAbfdeSAI('IND'))) Then
    Result := Result + 'IND'//IND - SAIDA INDUSTRIA

  Else If (strRegTri = 'S') And (Not fEmptyStr(fRetSQLMsg1e2TipAbfdeSAI('SNA'))) Then
    Result := Result + 'SNA'//SNA - SIMPLES NACIONAL

  Else If fAtividadeConstrutora(strCodAti) Then
    Result := Result + 'CTA'//CTA - CONSTRUTORA

  Else If (strFisJur = 'F') And (strMicEmp = 'S') And (not fEmptyStr(strIES)) Then
    Result := Result + 'CCO'//CCO - CONTRIBUINTE CONSUMIDOR MICRO EMPREENDEDOR INDIVIDUAL

  Else If (fEmptyStr(strIES) And (strMicEmp <> 'S'))  Or (strFisJur = 'F') Then//(F)isica ou (J)uridica
    Result := Result + 'NCO'//NCO - NAO CONTRIBUINTE (PF OU PJ SEM INSC. ESTADUAL)

  Else If strConsum = 'S' Then
    Result := Result + 'CCO'//CCO - CONTRIBUINTE CONSUMIDOR

  Else
    Result := Result + 'CNC';//CNC - CONTRIBUINTE NAO CONSUMIDOR
end;

function TFonteDadosBD.fGetTipoAbfEnt(blnRetPes: Boolean; strRegimeTributario, strFisJur, strIES, strTipFor: String): String;
begin
  Result := '_ENT_';

  If blnRetPes And (Pos(strRegimeTributario, '_S_M_A') > 0 ) Then
  Begin
    If (strTipFor = 'I') Or (strTipFor = 'Y') Then
      Result := Result + 'PSI' // PSI - ENTRADAS PESSOA JURÍDICA (SIMPLES NACIONAL - INDÚSTRIA)
    Else
      Result := Result + 'PES' // PES - ENTRADAS PESSOA JURÍDICA (SIMPLES NACIONAL - DISTRIBUIÇÃO / REVENDA / COMERCIALIZAÇÃO)
  End
  Else If fEmptyStr(strIES) Or (strFisJur = 'F') Then//(F)isica ou (J)uridica
    Result := Result + 'PEF' //PESSOA FISICA (PF OU PJ SEM INSC. ESTADUAL)
  Else If strTipFor = 'I' Then
  Begin
    If (Pos(strRegimeTributario, '_S_M_A') > 0 ) And (fCampoExiste('ABFICM', 'ABF_BASICM_ENT_PJS')) Then
      Result := Result + 'PJS' //PEJ - PESSOA JURIDICA (INDUSTRIA) SIMPLES
    Else
      Result := Result + 'PEJ'; //PEJ - PESSOA JURIDICA (INDUSTRIA)
  End
  Else
  Begin
    If (strTipFor = 'Y')  Then
      Result := Result + 'PII' //ENTRADAS PESSOA JURIDICA ( INDUSTRIA INCENTIVADA )
    Else
    Begin
      If (Pos(strRegimeTributario, '_S_M_A') > 0 ) And (fCampoExiste('ABFICM', 'ABF_BASICM_ENT_PJS')) Then
        Result := Result + 'PRS' //PER - PESSOA JURIDICA (DISTRIBUICAO/REVENDA/COMERCIALIZACAO) SIMPLES
      else
        Result := Result + 'PER';//PER - PESSOA JURIDICA (DISTRIBUICAO/REVENDA/COMERCIALIZACAO)
    End;
  End;
end;

function TFonteDadosBD.fGetTipoAbfFornecedor(const strCodFor: String): String;
  Var
    blnRetPes: Boolean;
    qryFornecedor: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  Result := '';

  If fEmptyStr(strCodFor) Then
    Exit;

  qryFornecedor := fCriaQuery(Nil);

  try

    With qryFornecedor, SQL Do
    Begin

      qryFornecedor.SQL.Text := 'SELECT ABF_RICMPR_ENT_PES FROM ABFICM LIMIT 1';
      Try
        qryFornecedor.Open;
        blnRetPes := True;
      Except
        blnRetPes := False;
      End;

      qryFornecedor.SQL.Clear;


      Add('SELECT ');
      Add('  IF(FOR_CGCCPF = 1, "J", "F") AS FISJUR,');
      Add('  FOR_I_E_S_ AS I_E_S_,');
      Add('  FOR_SIMPAU AS SIMPAU,');
      Add('  FOR_MATREV AS TIPFOR ');
      Add('FROM');
      Add('  CADFOR ');
      Add('WHERE');
      Add('  FOR_CODFOR = :CODFOR');

      ParamByName('CODFOR').AsString := strCodFor;

      Open;

      Result := fGetTipoAbfEnt(blnRetPes,
                               FieldByName('SIMPAU').AsString,
                               FieldByName('FISJUR').AsString,
                               FieldByName('I_E_S_').AsString,
                               FieldByName('TIPFOR').AsString);
    End;

  finally
    FreeAndNil(qryFornecedor);
  end;

end;

procedure TFonteDadosBD.pGravaLogRep(strComand, strTabela, strCarreg: String);
Var
  qryLogRep: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  dtaDtaSis : TDateTime;
  dtaHraSis : TDateTime;


  function fGravaLogRepConId: Boolean;
  begin
    Result := (VS_LogRepConId = 'S') And (VS_ConnectionID <> '');
  end;

  function fGravaTabelasFilhasLogRep: Boolean;
  begin
    Result := (VS_GravaUsuRep = 'S') And (VS_ConnectionID <> '');
  end;

  procedure pCarregaVariaveisControle;
  begin
    If (VS_ConnectionID = '') Then
      VS_ConnectionID := fGetConnectionID();

    If (VS_LogRepConId = '') Then
    Begin
      If fCampoExiste('LOGREP', 'LOG_CON_ID') Then
        VS_LogRepConId := 'S'
      Else
        VS_LogRepConId := 'N'
    End;

    If (VS_LogRepCodOp = '') Then
    Begin
      If fCampoExiste('LOGREP', 'LOG_CODOPE') Then
        VS_LogRepCodOp := 'S'
      Else
        VS_LogRepCodOp := 'N'
    End;

    If (VS_GravaUsuRep = '') Then
    Begin
      VS_GravaUsuRep := 'N';

      If (VS_LogRepConId = 'N') Then
      Begin
        If (fCampoExiste('USUREP', 'LOG_SEQREP')) And
           (fCampoExiste('USUREP', 'LOG_NOMMAQ')) And
           (fCampoExiste('USUREP', 'LOG_NOMUSU')) And
           (fCampoExiste('USUREP', 'LOG_NUM_IP')) And
           (fCampoExiste('USUREP', 'LOG_MACADD')) And
           (fCampoExiste('USUREP', 'LOG_CON_ID')) Then
        Begin
          VS_GravaUsuRep := 'S'
        End;
      End;
    End;
  end;

Begin
  Try
    pCarregaVariaveisControle;

    qryLogRep := fCriaQuery(Nil);
    Try
      pPegaDataHoraSistema(dtaDtaSis, dtaHraSis);

      If fGravaTabelasFilhasLogRep Then
      Begin
        qryLogRep.SQL.Text := 'SELECT * FROM LOGREP WHERE FALSE';
        qryLogRep.Open;

        qryLogRep.Insert;

        If (fGravaLogRepConId) Then
          qryLogRep.FieldByName('LOG_CON_ID').AsString := VS_ConnectionID;

        If (VS_LogRepCodOp = 'S') Then
          qryLogRep.FieldByName('LOG_CODOPE').AsString := '999';

        qryLogRep.FieldByName('LOG_DTACAD').AsDateTime := dtaDtaSis;
        qryLogRep.FieldByName('LOG_HRACAD').AsDateTime := dtaHraSis;
        qryLogRep.FieldByName('LOG_COMAND').AsString   := strComand;
        qryLogRep.FieldByName('LOG_TABELA').AsString   := strTabela;
        qryLogRep.FieldByName('LOG_CARREG').AsString   := strCarreg;

        qryLogRep.Post;

        If (VS_GravaUsuRep = 'S') Then
          pGravaInfUsuarioReplicacao(qryLogRep.FieldByName('LOG_CODIGO').Value);
      End
      Else
      Begin
        qryLogRep.SQL.Clear;
        qryLogRep.SQL.Add('INSERT INTO LOGREP ');
        qryLogRep.SQL.Add('  (                ');

        If (fGravaLogRepConId) Then
          qryLogRep.SQL.Add(' LOG_CON_ID,     ');

        If (VS_LogRepCodOp = 'S') Then
         qryLogRep.SQL.Add('  LOG_CODOPE,     ');

        qryLogRep.SQL.Add('   LOG_DTACAD,     ');
        qryLogRep.SQL.Add('   LOG_HRACAD,     ');
        qryLogRep.SQL.Add('   LOG_COMAND,     ');
        qryLogRep.SQL.Add('   LOG_TABELA,     ');
        qryLogRep.SQL.Add('   LOG_CARREG      ');
        qryLogRep.SQL.Add('  )                ');
        qryLogRep.SQL.Add('VALUES             ');
        qryLogRep.SQL.Add('  (                ');

        If (fGravaLogRepConId) Then
          qryLogRep.SQL.Add(' :CON_ID,         ');

        If (VS_LogRepCodOp = 'S') Then
          qryLogRep.SQL.Add(' :CODOPE,        ');

        qryLogRep.SQL.Add('   :DTACAD,        ');
        qryLogRep.SQL.Add('   :HRACAD,        ');
        qryLogRep.SQL.Add('   :COMAND,        ');
        qryLogRep.SQL.Add('   :TABELA,        ');
        qryLogRep.SQL.Add('   :CARREG         ');

        qryLogRep.SQL.Add('  )                ');

        If (fGravaLogRepConId) Then
          qryLogRep.ParamByName('CON_ID').AsString := VS_ConnectionID;

        If (VS_LogRepCodOp = 'S') Then
          qryLogRep.ParamByName('CODOPE').AsString := '999';

        qryLogRep.ParamByName('DTACAD').AsDateTime := dtaDtaSis;
        qryLogRep.ParamByName('HRACAD').AsDateTime := dtaHraSis;
        qryLogRep.ParamByName('COMAND').AsString   := strComand;
        qryLogRep.ParamByName('TABELA').AsString   := strTabela;
        qryLogRep.ParamByName('CARREG').AsString   := strCarreg;

        qryLogRep.ExecSQL;
      End;

      qryLogRep.Close;
    Finally
      FreeAndNil(qryLogRep);
    End;
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteLn('Erro ao tentar gravar LogRep - ' + E.Message);
     {$ELSE}
      pLogImp('Erro ao tentar gravar LogRep - ' + E.Message);
     {$ENDIF}
    End;
  End;
end;

function TFonteDadosBD.fCriaQuery(Owner: TComponent): {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin
  Result := {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery.Create(Owner); {$ELSE} TZQuery.Create(Owner); {$IFEND}
  Result.Connection := Database;
  Result.Tag := Database.Tag;
  {$IF Defined(VER250) Or Defined(UNIDAC)}
  Result.BeforeExecute := untDicSis.TQueryLog.BeforeExecute;
  {$ELSE}
  Result.BeforeOpen := untDicSis.TQueryLog.BeforeOpen;
  {$IFEND}
End;

procedure TFonteDadosBD.pCarregaDadosNFSeSubstituicao(Var dadosGerais: TDadosGerais; strAutInc: String);
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If Not fTabelaExiste('SUBNFS') Then
  Begin
    Exit;
  End;

  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add('SELECT * FROM SUBNFS WHERE SUB_SEQGER = :SEQGER AND SUB_ENVIAD = 1 ORDER BY SUB_NUMRPS DESC LIMIT 1');
  qryAux.ParamByName('SEQGER').AsString := strAutInc;
  qryAux.Open;

  dadosGerais.strNumeroRpsSubstituto := qryAux.FieldByName('SUB_NUMRPS').AsString;
  dadosGerais.strSerieRpsSubstituto := qryAux.FieldByName('SUB_SERRPS').AsString;

  FreeAndNil(qryAux);
end;

procedure TFonteDadosBD.pCarregaChavesReferenciadasAKZ(strNumDoc,strEspDoc,strCodEmp: String);
  Var
    qryInfCom: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    stlAdicionadas : TStringList;
    strChvAce: String;
Begin
  SetLength(dadosGerais.arrChavesReferenciadas, 0);
  qryInfCom := fCriaQuery(Nil);
  stlAdicionadas := TStringList.Create;
  Try
    With qryInfCom, SQL Do
    Begin
      Clear;
      Add('SELECT DISTINCT SUBSTR(LOT_NOTULT,1,12) AS LOT_NOTULT, LOT_DTAULT, ');
      Add('                LOT_CHVULT, FIS_NUMDOC, FIS_DTAENT, FIS_ACESSO     ');
      Add('FROM MOVDET                                                        ');
      Add('INNER JOIN FATDOR ON FDO_NUMDOC = DET_NUM_PD AND                   ');
      Add('                     FDO_ESPDOC = DET_ESP_PD AND                   ');
      Add('                     FDO_CODEMP = DET_EMP_PD AND                   ');
      Add('                     FDO_CODITE = DET_CODITE AND                   ');
      Add('                     FDO_SEQIND = DET_IND_PD                       ');
      Add('INNER JOIN DEL_LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM            ');
      Add('INNER JOIN CADLOT ON LOT_NUMLOT = LDO_NUMLOT AND                   ');
      Add('                     LOT_CODEMP = FDO_CODEMP AND                   ');
      Add('                     LOT_CODITE = FDO_CODITE                       ');
      Add('LEFT  JOIN CADFIS ON FIS_NUMDOC = SUBSTR(LOT_NOTULT,1,12) AND      ');
      Add('                     FIS_FORCLI = LOT_FORULT  AND                  ');
      Add('                     FIS_TIP_FC = "F" AND                          ');
      Add('                     FIS_ENTSAI = "E"                              ');
      Add('WHERE LOT_NOTULT IS NOT NULL                                       ');
      Add('  AND DET_NUMDOC = :NUMDOC                                         ');
      Add('  AND DET_ESPDOC = :ESPDOC                                         ');
      Add('  AND DET_CODEMP = :CODEMP                                         ');
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      First;
      While Not Eof Do
      Begin
        strChvAce := IIF(fEmptyStr(FieldByName('FIS_ACESSO').AsString), FieldByName('LOT_CHVULT').AsString, FieldByName('FIS_ACESSO').AsString);

        If (stlAdicionadas.IndexOf(strChvAce) < 0) Then
        Begin
          SetLength(dadosGerais.arrChavesReferenciadas, Length(dadosGerais.arrChavesReferenciadas) + 1);
          dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] := TChaveReferenciada.Create;

          With dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] Do
          Begin
            strTipoChave := DOCUMENTO_REF_NFe_Modelo_55;

            If fEmptyStr(FieldByName('FIS_ACESSO').AsString) Then
              strChaveAcessoNfe := FieldByName('LOT_CHVULT').AsString
            Else
              strChaveAcessoNfe := FieldByName('FIS_ACESSO').AsString;

            stlAdicionadas.Add(strChvAce);
          End;
        End;

        Next;
      End;
    End;
  Finally
    FreeAndNil(qryInfCom);
    FreeAndNil(stlAdicionadas);
  End;
end;

procedure TFonteDadosBD.pCarregaChavesReferenciadasRemessaContaOrdem(
  const strNumDoc, strEspDoc, strCodEmp: String);
Var
  qryConsulta: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  stlAdicionadas: TStrings;
  strChave: String;
begin
  If Not fCampoExiste('AUXMOV', 'AUX_AUTRCO') Then
    Exit;

  qryConsulta := fCriaQuery(Nil);
  stlAdicionadas := TStringList.Create;
  Try
    If (qryDados.FieldByName('CHAVE_TABELA').AsString = 'MOVGER') Or
       (qryDados.FieldByName('CHAVE_TABELA').AsString = 'MOVDET') Then
    Begin
      qryConsulta.SQL.Text := 'SELECT '
                            + '       F.FIS_ACESSO '
                            + '     , G.GER_NUMDOC '
                            + '     , G.GER_ESPDOC '
                            + '     , G.GER_CODEMP '
                            + '  FROM MOVGER G '
                            + ' INNER JOIN AUXMOV A ON A.AUX_SEQGER = G.AUTOINCREM '
                            + ' INNER JOIN CADFIS F ON F.FIS_NUMDOC = G.GER_NUMDOC '
                            + '                    AND F.FIS_ESPDOC = G.GER_ESPDOC '
                            + '                    AND F.FIS_CODEMP = G.GER_CODEMP '
                            + ' WHERE A.AUX_AUTRCO IN (SELECT M.AUTOINCREM FROM MOVGER M '
                            + '                         WHERE M.GER_NUMDOC = :NUMDOC '
                            + '                           AND M.GER_ESPDOC = :ESPDOC '
                            + '                           AND M.GER_CODEMP = :CODEMP) ';
    End
    Else
    Begin
      qryConsulta.SQL.Text := 'SELECT '
                            + '       F.FIS_ACESSO '
                            + '     , N.GER_NUMDOC '
                            + '     , N.GER_ESPDOC '
                            + '     , N.GER_CODEMP '
                            + '  FROM NOTGER N '
                            + ' INNER JOIN MOVGER G ON G.GER_NUMFAT = N.GER_NUMDOC '
                            + '                    AND G.GER_TIPFAT = N.GER_ESPDOC '
                            + '                    AND G.GER_EMPFAT = N.GER_CODEMP '
                            + ' INNER JOIN AUXMOV A ON A.AUX_SEQGER = G.AUTOINCREM '
                            + ' INNER JOIN CADFIS F ON F.FIS_NUMDOC = N.GER_NUMDOC '
                            + '                    AND F.FIS_ESPDOC = N.GER_ESPDOC '
                            + '                    AND F.FIS_CODEMP = N.GER_CODEMP '
                            + ' WHERE A.AUX_AUTRCO IN (SELECT M.AUTOINCREM FROM NOTGER T '
                            + '                         INNER JOIN MOVGER M ON M.GER_NUMFAT = T.GER_NUMDOC '
                            + '                                            AND M.GER_TIPFAT = T.GER_ESPDOC '
                            + '                                            AND M.GER_EMPFAT = T.GER_CODEMP '
                            + '                         WHERE T.GER_NUMDOC = :NUMDOC '
                            + '                           AND T.GER_ESPDOC = :ESPDOC '
                            + '                           AND T.GER_CODEMP = :CODEMP) ';
    End;

    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;
    qryConsulta.Open;

    qryConsulta.First;
    While Not qryConsulta.Eof Do
    Begin
      strChave := qryConsulta.FieldByName('FIS_ACESSO').AsString;

      If Not fEmptyStr(strChave) And (stlAdicionadas.IndexOf(strChave) < 0) Then
      Begin
        SetLength(dadosGerais.arrChavesReferenciadas, Length(dadosGerais.arrChavesReferenciadas) + 1);
        dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] := TChaveReferenciada.Create;

        With dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] Do
        Begin
          strTipoChave      := DOCUMENTO_REF_NFCE;
          strChaveAcessoNfe := strChave;

          stlAdicionadas.Add(strChave);
        End;
      End;

      qryConsulta.Next;
    End;

    qryConsulta.Close;
  Finally
    FreeAndNil(stlAdicionadas);
    FreeAndNil(qryConsulta);
  End;
end;

procedure TFonteDadosBD.pCarregaChavesReferenciadas(dadosGerais: TDadosGerais);
  Var
    strSQL,
    strCodIbge,
    strUfIbge,
    strEstado: String;
    strCidade: String;
    blnPermitirGC: Boolean;
    objChaveRefPrincipal: TChaveReferenciada;
    qryRemessaFora: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strAutInc: String;
    blnFiltroRemessa: Boolean;

    function fExiteTipoDoc: Boolean;
    Begin
      Result := (qryDados.FindField('GER_TIPDOC') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_TIPDOC').AsString));
    End;

    function fExisteChaveNfeAuxMov: Boolean;
    Begin
      Result := (qryDados.FindField('GER_CHVNFE') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_CHVNFE').AsString));
    End;

    function fExisteCupomFiscalAuxMov: Boolean;
    Begin
      Result := (qryDados.FindField('GER_NUMCOO') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_NUMCOO').AsString)) And
                (qryDados.FindField('GER_NUMSER') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_NUMSER').AsString)) And
                (qryDados.FindField('GER_NUMUSU') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_NUMUSU').AsString));

    End;

    function fExisteModeloA1AuxMov: Boolean;
    Begin
      Result := (qryDados.FindField('GER_NUMERO') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_NUMERO').AsString)) And
                (qryDados.FindField('GER_SERIE1') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_SERIE1').AsString)) And
                (qryDados.FindField('GER_MODELO') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_MODELO').AsString)) And
                (qryDados.FindField('GER_CPFCNP') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_CPFCNP').AsString)) And
                (qryDados.FindField('GER_ESTADO') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_ESTADO').AsString)) And
                (qryDados.FindField('GER_MESANO') <> Nil)                  And
                (Not fEmptyStr(qryDados.FindField('GER_MESANO').AsString));

    End;

    function fExisteChaveCadFisDevolucaoGPE: Boolean;
    begin
      Result :=  (qryDados.FindField('DET_DOCDEV') <> Nil)         And
              (Not fEmptyStr(qryDados.FindField('DET_DOCDEV').AsString));
    end;

    function fDocumentoReposicaoClienteGarantiaPropriaEmpresa: Boolean;
    begin
      Result :=  (Not (qryDados.FindField('GER_OPCDOC') = Nil)
                       Or (fEmptyStr(qryDados.FindField('GER_OPCDOC').AsString)))
                  and (Pos(qryDados.FindField('GER_OPCDOC').AsString, '_GC_') > 0)
                  and FGarantiaPropriaEmpresa;
    end;

begin
  objChaveRefPrincipal := Nil;
  SetLength(dadosGerais.arrChavesReferenciadas, 0);
  blnPermitirGC := fDocumentoReposicaoClienteGarantiaPropriaEmpresa;
  {*********************************************************************************}
  {* SE FOR UM DOCUMENTO DE OUTRAS ENTRADAS COM CFOP DE DEVOLUÇÃO E ESTIVER USANDO *}
  {* A VERSÃO DA NFE 3.10, PEGA A CHAVE DE REFERENCIA QUE FOI SALVA NA AUXMOV.     *}
  {******************************************************************************FC*}
  {*********************************************************************************}
  {* ALTEREI PARA VERIFICAR APENAS OS CAMPOS DE CHAVE REF. OU CUPOM REF.           *}
  {******************************************************************************MV*}

  If fVersao310(Self, '55', strIntegradorCitel) And
     (((fExisteChaveNfeAuxMov) and (Not FDocNGComMultiplasChaves)) Or (fExisteCupomFiscalAuxMov) Or (fExisteModeloA1AuxMov))  Then
  Begin
    SetLength(dadosGerais.arrChavesReferenciadas, Length(dadosGerais.arrChavesReferenciadas) + 1);
    dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] := TChaveReferenciada.Create;

    With dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] Do
    Begin
      If fExisteChaveNfeAuxMov Then
      Begin
        {*********************************************************************************}
        {* NÃO TEM PROBLEMA USAR NF, TANTO PARA NFE QUANTO NFCE, POIS A TAG É A MESMA.   *}
        {******************************************************************************MV*}
        strTipoChave      := dadosGerais.fTipoChaveReferenciada('NF', qryDados.FindField('GER_CHVNFE').AsString);
        strChaveAcessoNfe := qryDados.FindField('GER_CHVNFE').AsString;
      End
      Else If fExisteCupomFiscalAuxMov Then
      Begin
        strTipoChave           := dadosGerais.fTipoChaveReferenciada('IF', '');
        strModeloDocFiscalIF   := '2D'; //"2D" - quando se tratar de Cupom Fiscal (emitido por ECF)
        strNumOrdSequencialECF := qryDados.FindField('GER_NUMUSU').AsString;
        strNumeroCOO           := qryDados.FindField('GER_NUMCOO').AsString;
        strNumeroSerieECF      := qryDados.FindField('GER_NUMSER').AsString;
      End
      Else If fExisteModeloA1AuxMov Then
      Begin
        strTipoChave         := dadosGerais.fTipoChaveReferenciada('NF', '');
        strChaveAcessoNfe    := '';
        strModeloDocFiscalNF := qryDados.FindField('GER_MODELO').AsString;
        strCnpjEmitente      := qryDados.FindField('GER_CPFCNP').AsString;
        strUfIbgeEmitente    := qryDados.FindField('GER_ESTADO').AsString;
        strSerieFiscal       := qryDados.FindField('GER_SERIE1').AsString;
        strDocumentoFiscal   := qryDados.FindField('GER_NUMERO').AsString;
        strAnoMesEmissao     := qryDados.FindField('GER_MESANO').AsString;
      End
      else if blnPermitirGC and fExisteChaveCadFisDevolucaoGPE then
      begin
        strTipoChave      := dadosGerais.fTipoChaveReferenciada('NF', qryDados.FindField('FIS_ACESSO').AsString);
        strChaveAcessoNfe := qryDados.FindField('FIS_ACESSO').AsString;
      end;
    End;
  End
  Else
  Begin
    //Preciso definir se o documento é proveniente de uma devolucao ou confirmacao de cupom fiscal
    If ((qryDados.FindField('GER_OPCDOC') = Nil) Or
        (fEmptyStr(qryDados.FindField('GER_OPCDOC').AsString)) Or
        (Pos(qryDados.FindField('GER_OPCDOC').AsString, 'DV_CI_OF_GF_OU_OE_EF_FE_NE_NG_BD_VN_EI_CP_CF_CR_CT_FC_CO_BF_DD_EM_ET_FD_') <= 0) Or
        (dadosGerais.blnNfComp And dadosGerais.blnComplementoIcms)) and (Not blnPermitirGC)  Then
    Begin
      Exit;
    End;

    If (qryDados.FindField('GER_OPCDOC') <> Nil) And (Pos(qryDados.FindField('GER_OPCDOC').AsString, 'VN_EI_CP_CF_') > 0) And
       (Pos(qryDados.FindField('GER_CLAFIS').AsString, fConfiguracao('CLASET')) <= 0) And (RightStr(qryDados.FindField('GER_CLAFIS').AsString, 3) <> fConfiguracao('RSICFO')) Then
    Begin
      Exit;
    End;

    If fConfirmacaoTransfEstoque And (Not fOperacaoRegimeEspecial) Then
      Exit;

    If (qryDados.FindField('GER_OPCDOC') <> Nil) And (Pos(qryDados.FindField('GER_OPCDOC').AsString, 'FC_CO_BF_DD_') > 0) And (not fTabelaExiste('CHVREF')) Then
      Exit;

    If (qryDados.FindField('GER_OPCDOC') <> Nil) And (qryDados.FindField('GER_OPCDOC').AsString = 'EI') And (RightStr(qryDados.FindField('GER_CLAFIS').AsString, 3) = fConfiguracao('RSICFO')) And (not fTabelaExiste('CHVREF')) Then
      Exit;

    If (Pos(qryDados.FindField('GER_OPCDOC').AsString, 'EM_ET_') > 0) And (fConfiguracao('REFVFE') <> 'S') Then
      Exit;

    If Not Assigned(qryChavesReferenciadas) Then
    Begin
      if fExisteChaveNfeAuxMov and FDocNGComMultiplasChaves then
      begin
        objChaveRefPrincipal := TChaveReferenciada.Create;
        objChaveRefPrincipal.strTipoChave      := dadosGerais.fTipoChaveReferenciada('NF', qryDados.FindField('GER_CHVNFE').AsString);
        objChaveRefPrincipal.strChaveAcessoNfe := qryDados.FindField('GER_CHVNFE').AsString;

        SetLength(dadosGerais.arrChavesReferenciadas, Length(dadosGerais.arrChavesReferenciadas) + 1);
        dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] := objChaveRefPrincipal;
      end;

      qryChavesReferenciadas := fCriaQuery(Nil);

      With qryChavesReferenciadas, SQL Do
      Begin
        Close;
        Clear;

        //Devolução de Venda
        If (qryDados.FieldByName('GER_OPCDOC').AsString = 'DV') Or
           (qryDados.FieldByName('GER_OPCDOC').AsString = 'OF') Or
           (qryDados.FieldByName('GER_OPCDOC').AsString = 'GF') Or
           ((qryDados.FieldByName('GER_OPCDOC').AsString = 'OU') And (Pos(qryDados.FindField('GER_CLAFIS').AsString, fConfiguracao('CLASET')) <= 0)) Or
           (qryDados.FieldByName('GER_OPCDOC').AsString = 'OE') Or
           (qryDados.FieldByName('GER_OPCDOC').AsString = 'EF') Or
           (qryDados.FieldByName('GER_OPCDOC').AsString = 'FE') Or
           (qryDados.FieldByName('GER_OPCDOC').AsString = 'NE') Or
           (qryDados.FieldByName('GER_OPCDOC').AsString = 'NG') Or
           (qryDados.FieldByName('GER_OPCDOC').AsString = 'BD') Or
           (blnPermitirGC) then
        Begin
          Add('SELECT DISTINCT                ');
          Add('  CADFIS.FIS_DTAENT AS DTAEMI, ');
          Add('  RIGHT(MOVDET.DET_DOCDEV, 9) AS NUMDOC, ');
          Add('  MOVDET.DET_ESPDEV AS ESPDOC, ');
          Add('  CADFIS.FIS_SERIE_ AS SERIE_, ');
          Add('  MOVDET.DET_EMPDEV AS CODEMP, ');
          Add('  MOVDET.DET_CODCLI AS CODCLI, ');
          Add('  CADEMP.EMP_C_G_C_ AS CGCEMI, ');
          Add('  CADEMP.EMP_CODCID AS CIDEMI, ');
          Add('  CADFIS.FIS_ACESSO AS CHAACE, ');
          Add('  CADFIS.FIS_NUMCOO AS NUMCOO, ');
          Add('  CADFIS.FIS_NUMSER AS NUMSER, ');
          Add('  IFNULL(CADECF.ECF_NUMUSU, "001") AS SEQECF ');
          Add('FROM                    ');
          Add('  MOVDET                ');

          Add('  INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = MOVDET.DET_CODEMP     ');

          Add('  INNER JOIN CADFIS ON CADFIS.FIS_NUMDOC = MOVDET.DET_DOCDEV AND ');
          Add('                       CADFIS.FIS_ESPDOC = MOVDET.DET_ESPDEV AND ');
          Add('                       CADFIS.FIS_CODEMP = MOVDET.DET_EMPDEV AND ');

          Add('                       CONDICAO_CLIENTE_MOVDET                   ');
          Add('                       CADFIS.FIS_TIP_FC = MOVDET.DET_TIP_FC     ');

          Add('  LEFT JOIN CADECF ON CADFIS.FIS_NUMSER = CADECF.ECF_NUMSER ');

          Add('WHERE                               ');
          Add('  MOVDET.DET_NUMDOC = :NUMDOC   AND ');
          Add('  MOVDET.DET_ESPDOC = :ESPDOC   AND ');
          Add('  MOVDET.DET_SERIE_ = :SERIE_   AND ');
          Add('  MOVDET.DET_CODEMP = :CODEMP   AND ');

          If (SameText(qryDados.FieldByName('GER_OPCDOC').AsString, 'DV')) Or
             (SameText(qryDados.FieldByName('GER_OPCDOC').AsString, 'BD')) Or
             (SameText(qryDados.FieldByName('GER_OPCDOC').AsString, 'NE')) Or
             (blnPermitirGC) Then
          Begin
            Add('  MOVDET.DET_CODCLI = :CODCLI   AND ');
            Add('  MOVDET.DET_TIP_FC = "C"       AND ');
          End
          Else
          Begin
            Add('  MOVDET.DET_CODFOR = :CODCLI   AND ');
            Add('  MOVDET.DET_TIP_FC = "F"       AND ');
          End;

          Add('  MOVDET.DET_DOCDEV IS NOT NULL AND ');
          Add('  MOVDET.DET_ESPDEV IN ("NF", "EL","IF") ');

          qryChavesReferenciadas.SQL.Add('UNION ALL ' + AnsiReplaceStr(qryChavesReferenciadas.SQL.Text, 'MOVDET', 'NOTDET'));

          If (fConfiguracao('HEFCOE') = 'S') And
             (Pos(qryDados.FieldByName('GER_OPCDOC').AsString, 'DV_BD_') > 0) And
             (Pos(qryDados.FieldByName('GER_ESPDOC').AsString, 'IF_NF_') > 0) And
             (fCampoExiste('MOVTRI', 'DET_INCDEV')) And
             (fCampoExiste('MOVTRI', 'DET_INCFUT')) And
             (qryDados.FindField('DET_ESPDEV') <> Nil) Then
          Begin
            If (qryDados.FieldByName('DET_ESPDEV').AsString = 'FF') Then
            Begin
              Add('UNION ALL ');
              Add('SELECT DISTINCT                ');
              Add('  CADFIS.FIS_DTAENT AS DTAEMI, ');
              Add('  RIGHT(DET_FUT.DET_NUMDOC, 9) AS NUMDOC, ');
              Add('  DET_FUT.DET_ESPDOC AS ESPDOC, ');
              Add('  CADFIS.FIS_SERIE_ AS SERIE_,  ');
              Add('  DET_FUT.DET_CODEMP AS CODEMP, ');
              Add('  MOVDET.DET_CODCLI AS CODCLI,  ');
              Add('  CADEMP.EMP_C_G_C_ AS CGCEMI,  ');
              Add('  CADEMP.EMP_CODCID AS CIDEMI,  ');
              Add('  CADFIS.FIS_ACESSO AS CHAACE,  ');
              Add('  CADFIS.FIS_NUMCOO AS NUMCOO,  ');
              Add('  CADFIS.FIS_NUMSER AS NUMSER,  ');
              Add('  IFNULL(CADECF.ECF_NUMUSU, "001") AS SEQECF ');
              Add('FROM                    ');
              Add('  MOVDET                ');
              Add('  INNER JOIN MOVTRI ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER  ');
              Add('  INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = MOVDET.DET_CODEMP  ');

              Add('  INNER JOIN MOVDET DET_DEV ON DET_DEV.AUTOINCREM = MOVTRI.DET_INCDEV  ');
              Add('  INNER JOIN MOVTRI TRI_DEV ON TRI_DEV.DET_SEQGER = DET_DEV.AUTOINCREM ');
              Add('  INNER JOIN MOVDET DET_FUT ON DET_FUT.AUTOINCREM = TRI_DEV.DET_INCFUT ');

              Add('  INNER JOIN CADFIS ON CADFIS.FIS_NUMDOC = DET_FUT.DET_NUMDOC AND ');
              Add('                       CADFIS.FIS_ESPDOC = DET_FUT.DET_ESPDOC AND ');
              Add('                       CADFIS.FIS_CODEMP = DET_FUT.DET_CODEMP AND ');

              Add('                       CONDICAO_CLIENTE_MOVDET                    ');
              Add('                       CADFIS.FIS_TIP_FC = DET_FUT.DET_TIP_FC     ');

              Add('  LEFT JOIN CADECF ON CADFIS.FIS_NUMSER = CADECF.ECF_NUMSER ');

              Add('WHERE                               ');
              Add('  MOVDET.DET_NUMDOC = :NUMDOC   AND ');
              Add('  MOVDET.DET_ESPDOC = :ESPDOC   AND ');
              Add('  MOVDET.DET_SERIE_ = :SERIE_   AND ');
              Add('  MOVDET.DET_CODEMP = :CODEMP   AND ');
              Add('  MOVDET.DET_CODCLI = :CODCLI   AND ');
              Add('  MOVDET.DET_TIP_FC = "C"       AND ');

              Add('  MOVTRI.DET_INCDEV IS NOT NULL AND ');
              Add('  LOCATE(DET_DEV.DET_CLAFIS, "5117_6117_") > 0 AND ');
              Add('  LOCATE(DET_FUT.DET_ESPDOC, "IF_NF_") > 0 AND ');
              Add('  DET_DEV.DET_ESPDOC IN ("FF") ');
            End;
          End;

          strSQL := qryChavesReferenciadas.SQL.Text;

          qryChavesReferenciadas.SQL.Text := AnsiReplaceStr(qryChavesReferenciadas.SQL.Text, 'CONDICAO_CLIENTE_MOVDET', 'CADFIS.FIS_FORCLI = IF(CADFIS.FIS_TIP_FC="C", MOVDET.DET_CODCLI, MOVDET.DET_CODFOR) AND');
          qryChavesReferenciadas.SQL.Text := AnsiReplaceStr(qryChavesReferenciadas.SQL.Text, 'CONDICAO_CLIENTE_NOTDET', 'CADFIS.FIS_FORCLI = IF(CADFIS.FIS_TIP_FC="C", NOTDET.DET_CODCLI, NOTDET.DET_CODFOR) AND');

          ParamByName('NUMDOC').AsString := qryDados.FieldByName('GER_NUMDOC').AsString;
          ParamByName('ESPDOC').AsString := qryDados.FieldByName('GER_ESPDOC').AsString;
          ParamByName('SERIE_').AsString := qryDados.FieldByName('GER_SERIE_').AsString;
          ParamByName('CODEMP').AsString := qryDados.FieldByName('GER_CODEMP').AsString;
          ParamByName('CODCLI').AsString := qryDados.FieldByName('GER_CODCLI').AsString;

          Open;

          //Devolucoes quando troca o cliente consumidor
          If IsEmpty And (Pos(qryDados.FieldByName('GER_OPCDOC').AsString, 'DV_BD_') > 0) Then
          Begin
            Close;

            qryChavesReferenciadas.SQL.Text := strSQL;
            qryChavesReferenciadas.SQL.Text := AnsiReplaceStr(qryChavesReferenciadas.SQL.Text, 'CONDICAO_CLIENTE_MOVDET', '');
            qryChavesReferenciadas.SQL.Text := AnsiReplaceStr(qryChavesReferenciadas.SQL.Text, 'CONDICAO_CLIENTE_NOTDET', '');

            ParamByName('NUMDOC').AsString := qryDados.FieldByName('GER_NUMDOC').AsString;
            ParamByName('ESPDOC').AsString := qryDados.FieldByName('GER_ESPDOC').AsString;
            ParamByName('SERIE_').AsString := qryDados.FieldByName('GER_SERIE_').AsString;
            ParamByName('CODEMP').AsString := qryDados.FieldByName('GER_CODEMP').AsString;
            ParamByName('CODCLI').AsString := qryDados.FieldByName('GER_CODCLI').AsString;

            Open;
          End;
        End
        //Confirmação de Cupom Fiscal
        Else If qryDados.FieldByName('GER_OPCDOC').AsString = 'CI' Then
        Begin
          Add('SELECT DISTINCT ');
          Add('  FIS_DTAENT AS DTAEMI, ');
          Add('  DET_NUMDOC AS NUMDOC, ');
          Add('  DET_ESPDOC AS ESPDOC, ');
          Add('  FIS_SERIE_ AS SERIE_, ');
          Add('  DET_CODEMP AS CODEMP, ');
          Add('  DET_CODCLI AS CODCLI, ');
          Add('  EMP_C_G_C_ AS CGCEMI, ');
          Add('  EMP_CODCID AS CIDEMI, ');
          Add('  FIS_ACESSO AS CHAACE, ');
          Add('  FIS_NUMCOO AS NUMCOO, ');
          Add('  FIS_NUMSER AS NUMSER, ');
          Add('  IFNULL(ECF_NUMUSU,"001") AS SEQECF  ');
          Add('FROM                    ');
          Add('  MOVDET                ');

          Add('  INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = MOVDET.DET_CODEMP ');

          Add('  INNER JOIN CADFIS ON CADFIS.FIS_NUMDOC = MOVDET.DET_NUMDOC AND ');
          Add('                       CADFIS.FIS_ESPDOC = MOVDET.DET_ESPDOC AND ');
          Add('                       CADFIS.FIS_SERIE_ = MOVDET.DET_SERIE_ AND ');
          Add('                       CADFIS.FIS_CODEMP = MOVDET.DET_CODEMP AND ');
          Add('                       CADFIS.FIS_FORCLI = MOVDET.DET_CODCLI AND ');
          Add('                       CADFIS.FIS_TIP_FC = MOVDET.DET_TIP_FC     ');

          Add('  LEFT JOIN CADECF ON CADFIS.FIS_NUMSER = CADECF.ECF_NUMSER ');

          Add('WHERE                        ');
          Add('  DET_NUMFAT = :NUMDOC   AND ');
          Add('  DET_TIPFAT = :ESPDOC   AND ');

          If fCampoExiste('MOVDET', 'DET_SERFAT') Then
            Add('  DET_SERFAT = :SERDOC AND ');

          Add('  DET_EMPFAT = :CODEMP   AND ');
          Add('  DET_CLIFAT = :CODCLI   AND ');
          Add('  DET_TIP_FC = "C"       AND ');
          Add('  DET_ESPDOC = :ESPREF   AND ');
          Add('  (FIS_NUMCOO IS NOT NULL OR FIS_ACESSO IS NOT NULL) ');

          Add(' UNION ALL ' + AnsiReplaceStr(Text, 'MOVDET','NOTDET'));

          Add('ORDER BY                     ');
          Add('  NUMDOC                     ');

          //Tenta por IF
          ParamByName('ESPREF').AsString := 'IF';
          ParamByName('NUMDOC').AsString := qryDados.FieldByName('GER_NUMDOC').AsString;
          ParamByName('ESPDOC').AsString := qryDados.FieldByName('GER_ESPDOC').AsString;
          If fCampoExiste('MOVDET', 'DET_SERFAT') Then
            ParamByName('SERDOC').AsString  := qryDados.FieldByName('GER_SERIE_').AsString;
          ParamByName('CODEMP').AsString := qryDados.FieldByName('GER_CODEMP').AsString;
          ParamByName('CODCLI').AsString := qryDados.FieldByName('GER_CODCLI').AsString;
          Open;

          If IsEmpty Then
          Begin
            //Tenta por IV
            Close;
            ParamByName('ESPREF').AsString := 'IV';
            ParamByName('NUMDOC').AsString := qryDados.FieldByName('GER_NUMDOC').AsString;
            ParamByName('ESPDOC').AsString := qryDados.FieldByName('GER_ESPDOC').AsString;
            If fCampoExiste('MOVDET', 'DET_SERFAT') Then
              ParamByName('SERDOC').AsString  := qryDados.FieldByName('GER_SERIE_').AsString;
            ParamByName('CODEMP').AsString := qryDados.FieldByName('GER_CODEMP').AsString;
            ParamByName('CODCLI').AsString := qryDados.FieldByName('GER_CODCLI').AsString;
            Open;
          End;
        End
        // Nota de exportação referenciada
        Else If (qryDados.FindField('GER_ESPDOC').AsString = 'NF') And (Pos(qryDados.FindField('GER_CLAFIS').AsString, fConfiguracao('CLASET')) > 0) Then
        Begin
           Add('SELECT T.DET_CHACES AS CHAACE,');
           Add('       D.DET_NUMDOC AS NUMDOC,');
           Add('       D.DET_ESPDOC AS ESPDOC,');
           Add('       F.FIS_SERIE_ AS SERIE_,');
           Add('       F.FIS_DTAENT AS DTAEMI,');
           Add('       E.EMP_C_G_C_ AS CGCEMI,');
           Add('       E.EMP_CODCID AS CIDEMI');

           if qryDados.FindField('GER_OPCDOC').AsString = 'CF' then
           begin
            Add('FROM NOTTRI T');
            Add('INNER JOIN NOTDET D');
           end
           else
           begin
            Add('FROM MOVTRI T');
            Add('INNER JOIN MOVDET D');
           end;
           Add('ON(T.DET_SEQGER = D.AUTOINCREM)');
           Add('INNER JOIN CADEMP E ');
           Add('ON (E.EMP_CODEMP = D.DET_CODEMP)');
           Add('INNER JOIN CADFIS F');
           Add('ON(F.FIS_NUMDOC = D.DET_NUMDOC AND');
           Add('   F.FIS_ESPDOC = D.DET_ESPDOC AND');
           Add('   F.FIS_SERIE_ = D.DET_SERIE_ and');
           Add('   F.FIS_CODEMP = D.DET_CODEMP AND');
           Add('   F.FIS_FORCLI = D.DET_CODCLI AND');
           Add('   F.FIS_TIP_FC = D.DET_TIP_FC)');
           Add('WHERE D.DET_CODEMP = :CODEMP');
           Add('AND D.DET_ESPDOC = :ESPDOC');
           Add('AND D.DET_NUMDOC = :NUMDOC');
           Add('GROUP BY CHAACE');

           ParamByName('CODEMP').AsString := qryDados.FieldByName('GER_CODEMP').AsString;
           ParamByName('ESPDOC').AsString := qryDados.FieldByName('GER_ESPDOC').AsString;
           ParamByName('NUMDOC').AsString := qryDados.FieldByName('GER_NUMDOC').AsString;

           Open;
        End
        Else If (Pos(qryDados.FindField('GER_OPCDOC').AsString, 'EM_ET_CR_') > 0) Then
        Begin
          blnFiltroRemessa := (fCampoExiste('MOVCON', 'CON_AUTICS')) And (Pos(qryDados.FindField('GER_OPCDOC').AsString, 'EM_ET_') > 0);

          Add(' SELECT DISTINCT FIS_DTAENT AS DTAEMI, ');
          Add('                 RIGHT(CON_NUMDOC, 9) AS NUMDOC, ');
          Add('                 CON_ESPDOC AS ESPDOC, ');
          Add('                 FIS_SERIE_ AS SERIE_, ');
          Add('                 CON_CODEMP AS CODEMP, ');
          Add('                 DET_CODCLI AS CODCLI, ');
          Add('                 EMP_C_G_C_ AS CGCEMI, ');
          Add('                 EMP_CODCID AS CIDEMI, ');
          Add('                 FIS_ACESSO AS CHAACE, ');
          Add('                 FIS_NUMCOO AS NUMCOO, ');
          Add('                 FIS_NUMSER AS NUMSER, ');
          If blnFiltroRemessa Then
            Add('               CON_AUTICS AS AUTICS, ');
          Add('                 IFNULL(ECF_NUMUSU,"001") AS SEQECF ');
          Add('        FROM MOVCON ');
          Add('        INNER JOIN MOVDET ON MOVDET.AUTOINCREM = MOVCON.CON_SEQGER      ');
          Add('        INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = MOVDET.DET_CODEMP      ');
          Add('        INNER JOIN CADFIS ON CADFIS.FIS_NUMDOC = MOVCON.CON_NUMDOC AND  ');
          Add('                             CADFIS.FIS_ESPDOC = MOVCON.CON_ESPDOC AND  ');
          Add('                             CADFIS.FIS_CODEMP = MOVCON.CON_CODEMP AND  ');
          If (qryDados.FindField('GER_OPCDOC').AsString = 'CR') Then
            Add('                             CADFIS.FIS_FORCLI = IF(CADFIS.FIS_TIP_FC="C", MOVDET.DET_CODCLI, MOVDET.DET_CODFOR) AND ');
          Add('                             CADFIS.FIS_TIP_FC = MOVDET.DET_TIP_FC ');
          Add('         LEFT JOIN CADECF ON CADFIS.FIS_NUMSER = CADECF.ECF_NUMSER ');
          Add('       WHERE MOVDET.DET_NUMDOC = :NUMDOC ');
          Add('         AND MOVDET.DET_ESPDOC = :ESPDOC ');
          Add('         AND MOVDET.DET_CODEMP = :CODEMP ');
          If blnFiltroRemessa Then
            Add('       AND CADFIS.FIS_FORCLI = (SELECT DET_CODCLI FROM MOVDET WHERE AUTOINCREM = MOVCON.CON_AUTICS) ');

          strSQL := qryChavesReferenciadas.SQL.Text;

          strSQL := AnsiReplaceStr(strSQL, 'MOVCON','NOTCON');
          strSQL := AnsiReplaceStr(strSQL, 'MOVDET','NOTDET');

          Add(' UNION ALL ' + strSQL);

          ParamByName('NUMDOC').AsString := qryDados.FieldByName('GER_NUMDOC').AsString;
          ParamByName('ESPDOC').AsString := qryDados.FieldByName('GER_ESPDOC').AsString;
          ParamByName('CODEMP').AsString := qryDados.FieldByName('GER_CODEMP').AsString;

          Open;

          If blnFiltroRemessa Then
          Begin
            If Not fEmptyStr(FieldByName('AUTICS').AsString) Then
            Begin
              First;
              While Not Eof Do
              Begin
                If fEmptyStr(strAutInc) Then
                  strAutInc := QuotedStr(FieldByName('AUTICS').AsString)
                Else
                  strAutInc := strAutInc + ', ' + QuotedStr(FieldByName('AUTICS').AsString);

                Next;
              End;

              qryRemessaFora := fCriaQuery(Nil);
              Try
                qryRemessaFora.Close;
                qryRemessaFora.SQL.Clear;
                qryRemessaFora.SQL.Add('SELECT CON_SEQGER AS SEQGER FROM MOVCON ');
                qryRemessaFora.SQL.Add('WHERE CON_AUTICS IN (' + strAutInc + ')');
                qryRemessaFora.Open;

                qryRemessaFora.First;
                While Not qryRemessaFora.Eof Do
                Begin
                  strAutInc := strAutInc + ', ' + QuotedStr(qryRemessaFora.FieldByName('SEQGER').AsString);

                  qryRemessaFora.Next;
                End;
              Finally
                FreeAndNil(qryRemessaFora);
              End;

              Close;
              Clear;

              Add('SELECT DISTINCT ');
              Add('  FIS_DTAENT AS DTAEMI, ');
              Add('  DET_NUMDOC AS NUMDOC, ');
              Add('  DET_ESPDOC AS ESPDOC, ');
              Add('  FIS_SERIE_ AS SERIE_, ');
              Add('  DET_CODEMP AS CODEMP, ');
              Add('  DET_CODCLI AS CODCLI, ');
              Add('  EMP_C_G_C_ AS CGCEMI, ');
              Add('  EMP_CODCID AS CIDEMI, ');
              Add('  FIS_ACESSO AS CHAACE, ');
              Add('  FIS_NUMCOO AS NUMCOO, ');
              Add('  FIS_NUMSER AS NUMSER, ');
              Add('  IFNULL(ECF_NUMUSU,"001") AS SEQECF  ');
              Add('FROM                    ');
              Add('  MOVDET                ');
              Add('  INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = MOVDET.DET_CODEMP ');
              Add('  INNER JOIN CADFIS ON CADFIS.FIS_NUMDOC = MOVDET.DET_NUMDOC AND ');
              Add('                       CADFIS.FIS_ESPDOC = MOVDET.DET_ESPDOC AND ');
              Add('                       CADFIS.FIS_SERIE_ = MOVDET.DET_SERIE_ AND ');
              Add('                       CADFIS.FIS_CODEMP = MOVDET.DET_CODEMP AND ');
              Add('                       CADFIS.FIS_FORCLI = IF(CADFIS.FIS_TIP_FC="C", MOVDET.DET_CODCLI, MOVDET.DET_CODFOR) AND ');
              Add('                       CADFIS.FIS_TIP_FC = MOVDET.DET_TIP_FC     ');
              Add('  LEFT JOIN CADECF ON CADFIS.FIS_NUMSER = CADECF.ECF_NUMSER ');
              Add('WHERE                        ');
              Add('  MOVDET.AUTOINCREM IN (' + strAutInc + ')');
              Add('AND (FIS_NUMCOO IS NOT NULL OR FIS_ACESSO IS NOT NULL) ');
              Add('AND NOT (MOVDET.DET_NUMDOC = :NUMDOC AND MOVDET.DET_CODEMP = :CODEMP AND MOVDET.DET_ESPDOC = :ESPDOC) ');
              Add(' UNION ALL ' + AnsiReplaceStr(Text, 'MOVDET', 'NOTDET'));
              Add('ORDER BY                     ');
              Add('  NUMDOC                     ');

              ParamByName('NUMDOC').AsString := qryDados.FieldByName('GER_NUMDOC').AsString;
              ParamByName('ESPDOC').AsString := qryDados.FieldByName('GER_ESPDOC').AsString;
              ParamByName('CODEMP').AsString := qryDados.FieldByName('GER_CODEMP').AsString;

              Open;
            End;
          End;
        End
        Else If fConfirmacaoTransfEstoque And fOperacaoRegimeEspecial Then
        Begin
          Add('SELECT FIS_ACESSO AS CHAACE,');
          Add('       DET_NUMDOC AS NUMDOC,');
          Add('       DET_ESPDOC AS ESPDOC,');
          Add('       FIS_SERIE_ AS SERIE_,');
          Add('       FIS_DTAENT AS DTAEMI,');
          Add('       EMP_C_G_C_ AS CGCEMI,');
          Add('       EMP_CODCID AS CIDEMI ');
          Add('FROM MOVDET');
          Add('JOIN CADEMP ON EMP_CODEMP = DET_CODEMP');
          Add('JOIN CADFIS ON FIS_NUMDOC = DET_NUMDOC');
          Add('           AND FIS_ESPDOC = DET_ESPDOC');
          Add('           AND FIS_CODEMP = DET_CODEMP');
          Add('           AND FIS_FORCLI = DET_CODFOR');
          Add('           AND FIS_TIP_FC = DET_TIP_FC');
          Add('           AND FIS_ENTSAI = "E"');
          Add('WHERE DET_TIP_FC = "F"');
          Add('  AND DET_CODFOR = :CODFOR');
          Add('  AND DET_CODEMP = :CODEMP');
          Add('  AND LOCATE(DET_CLAFIS, :CLACOM) > 0');
          Add('ORDER BY DET_DTAENT DESC, DET_HORENT DESC');
          Add('LIMIT 1');

          ParamByName('CODFOR').AsString := qryDados.FieldByName('GER_CODCLI').AsString;
          ParamByName('CODEMP').AsString := qryDados.FieldByName('GER_CODEMP').AsString;
          ParamByName('CLACOM').AsString := fTransform(fConfiguracao('CLACOM'), 4);

          Open;
        End
        Else If (Pos(qryDados.FindField('GER_OPCDOC').AsString, 'FC_CO_BF_DD_') > 0) Or
                ((qryDados.FindField('GER_OPCDOC').AsString = 'EI') And (RightStr(qryDados.FindField('GER_CLAFIS').AsString, 3) = fConfiguracao('RSICFO'))) Then
        Begin
          Add('SELECT FIS_CHVREF AS CHAACE FROM CHVREF ');
          Add('WHERE FIS_SEQFIS = :AUTINC ');
          ParamByName('AUTINC').AsString := qryDados.FieldByName('FIS_AUTOINCREM').AsString;
          Open;

          qryChavesReferenciadas.First;
          While not qryChavesReferenciadas.eof Do
          Begin
            if Assigned(objChaveRefPrincipal) then
            begin
              if objChaveRefPrincipal.strChaveAcessoNfe = qryChavesReferenciadas.FieldByName('CHAACE').AsString then
              begin
                qryChavesReferenciadas.Next;
                Continue;
              end;
            end;

            SetLength(dadosGerais.arrChavesReferenciadas, Length(dadosGerais.arrChavesReferenciadas) + 1);
            dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] := TChaveReferenciada.Create;
            dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1].strTipoChave      := DOCUMENTO_REF_NFe_Modelo_55;
            dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1].strChaveAcessoNfe := qryChavesReferenciadas.FieldByName('CHAACE').AsString;

            qryChavesReferenciadas.Next;
          End;

          Exit;

        End
        Else If (fConfiguracao('CFODVE') = 'D') And
                (Assigned(qryDados.FindField('GER_OPCDOC'))) And
                (qryDados.FieldByName('GER_OPCDOC').AsString = 'FD') And
                (Pos(qryDados.FieldByName('GER_CLAFIS').AsString, CFOP_DEVOLUCAO) > 0) Then
        Begin
          If fCarregouChavesReferenciadasRegimeEspecialDevolucao(dadosGerais) Then
            Exit;
        End;
      End;
    End;

    If (Not Assigned(qryChavesReferenciadas)) Then
      Exit;

    If (Not qryChavesReferenciadas.Active) Then
      Exit;

    With qryChavesReferenciadas Do
    Begin
      First;
      While Not Eof Do
      Begin
        pRetornaDadosIbge(FieldByName('CIDEMI').AsString, strCodIbge, strUfIbge, strEstado, strCidade);

        if Assigned(objChaveRefPrincipal) then
        begin
          if objChaveRefPrincipal.strChaveAcessoNfe = qryChavesReferenciadas.FieldByName('CHAACE').AsString then
          begin
            qryChavesReferenciadas.Next;
            Continue;
          end;
        end;

        SetLength(dadosGerais.arrChavesReferenciadas, Length(dadosGerais.arrChavesReferenciadas) + 1);
        dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] := TChaveReferenciada.Create;

        With dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] Do
        Begin
          strTipoChave := dadosGerais.fTipoChaveReferenciada(FieldByName('ESPDOC').AsString, FieldByName('CHAACE').AsString);

          If (FieldByName('ESPDOC').AsString <> 'IF') Or (strTipoChave = DOCUMENTO_REF_NFCE) Then
          Begin
            strChaveAcessoNfe    := FieldByName('CHAACE').AsString;
            strModeloDocFiscalNF := '01';
            strCnpjEmitente      := FieldByName('CGCEMI').AsString;

            If fVersao310(Self, '55', strIntegradorCitel) Then
              strUfIbgeEmitente    := strEstado
            Else
              strUfIbgeEmitente  := strUfIbge;

            strSerieFiscal       := FieldByName('SERIE_').AsString;
            strDocumentoFiscal   := FieldByName('NUMDOC').AsString;
            strAnoMesEmissao     := FormatDateTime('YYMM', FieldByName('DTAEMI').AsDateTime);
          End
          Else
          Begin
            strModeloDocFiscalIF   := '2D'; //"2D" - quando se tratar de Cupom Fiscal (emitido por ECF)
            strNumOrdSequencialECF := FieldByName('SEQECF').AsString;
            strNumeroCOO           := FieldByName('NUMCOO').AsString;
            strNumeroSerieECF      := FieldByName('NUMSER').AsString;
          End;
        End;
        Next;
      End;
    End;
  End;
end;

function TFonteDadosBD.fCarregouChavesReferenciadasRegimeEspecialDevolucao(dadosGerais: TDadosGerais) : Boolean;
  Var
    qryDocDev : {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    qryChaves : {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strIncDevs : String;
begin
  qryDocDev := fCriaQuery(Nil);
  qryChaves := fCriaQuery(Nil);
  Try
    Result := False;

    If (Not fCampoExiste('MOVTRI', 'DET_INCDEV')) Then
      Exit;

    If (Not fCampoExiste('AUXMOV', 'AUX_DOC_RE')) Then
      Exit;

    If (Not Assigned(qryDados)) Then
      Exit;

    If (Not qryDados.Active) Then
      Exit;

    If (qryDados.IsEmpty) Then
      Exit;

    qryDocDev.Close;
    qryDocDev.SQL.Clear;
    qryDocDev.SQL.Add(' SELECT AUX_DOC_RE, AUX_ESP_RE, AUX_EMP_RE, AUX_CLI_RE, DET_INCDEV ');
    qryDocDev.SQL.Add('   FROM MOVDET ');
    qryDocDev.SQL.Add('   JOIN MOVGER ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ');
    qryDocDev.SQL.Add('   JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ');
    qryDocDev.SQL.Add('   JOIN MOVTRI ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ');
    qryDocDev.SQL.Add('  WHERE MOVDET.DET_NUMDOC = :NUMDOC ');
    qryDocDev.SQL.Add('    AND MOVDET.DET_ESPDOC = :ESPDOC ');
    qryDocDev.SQL.Add('    AND MOVDET.DET_CODEMP = :CODEMP ');
    qryDocDev.SQL.Add('    AND MOVDET.DET_CODCLI = :CODCLI ');
    qryDocDev.ParamByName('NUMDOC').AsString := qryDados.FieldByName('GER_NUMDOC').AsString;
    qryDocDev.ParamByName('ESPDOC').AsString := qryDados.FieldByName('GER_ESPDOC').AsString;
    qryDocDev.ParamByName('CODEMP').AsString := qryDados.FieldByName('GER_CODEMP').AsString;
    qryDocDev.ParamByName('CODCLI').AsString := qryDados.FieldByName('GER_CODCLI').AsString;
    qryDocDev.Open;

    If (qryDocDev.IsEmpty) Then
      Exit;

    If (fEmptyStr(qryDocDev.FieldByName('AUX_DOC_RE').AsString)) Then
      Exit;

    strIncDevs := '';
    qryDocDev.First;
    While Not qryDocDev.Eof Do
    Begin
      If fEmptyStr(qryDocDev.FieldByName('DET_INCDEV').AsString) Then
      Begin
        qryDocDev.Next;
        Continue;
      End;
      If fEmptyStr(strIncDevs) Then
        strIncDevs := QuotedStr(qryDocDev.FieldByName('DET_INCDEV').AsString)
      Else
        strIncDevs := strIncDevs + ', ' + QuotedStr(qryDocDev.FieldByName('DET_INCDEV').AsString);
      qryDocDev.Next;
    End;

    If fEmptyStr(strIncDevs) Then
      Exit;

    qryChaves.Close;
    qryChaves.SQL.Clear;
    qryChaves.SQL.Add(' SELECT DISTINCT FIS_ACESSO ');
    qryChaves.SQL.Add('   FROM MOVDET ');
    qryChaves.SQL.Add('   JOIN CADFIS ON FIS_NUMDOC = DET_NUMDOC ');
    qryChaves.SQL.Add('              AND FIS_ESPDOC = DET_ESPDOC ');
    qryChaves.SQL.Add('              AND FIS_CODEMP = DET_CODEMP ');
    qryChaves.SQL.Add('              AND FIS_FORCLI = DET_CODCLI ');
    qryChaves.SQL.Add('              AND FIS_TIP_FC = DET_TIP_FC ');
    qryChaves.SQL.Add('              AND FIS_SERIE_ = DET_SERIE_ ');
    qryChaves.SQL.Add('              AND FIS_ORIDOC = DET_ORIDOC ');
    qryChaves.SQL.Add('            WHERE MOVDET.AUTOINCREM IN (' + strIncDevs + ') ');
    qryChaves.Open;

    If (qryChaves.IsEmpty) Then
      Exit;

    qryChaves.First;
    While Not qryChaves.Eof Do
    Begin
      SetLength(dadosGerais.arrChavesReferenciadas, Length(dadosGerais.arrChavesReferenciadas) + 1);
      dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] := TChaveReferenciada.Create;
      dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1].strTipoChave := DOCUMENTO_REF_NFe_Modelo_55;
      dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1].strChaveAcessoNfe := qryChaves.FieldByName('FIS_ACESSO').AsString;
      qryChaves.Next;
    End;

    Result := True;
  Finally
    FreeAndNil(qryDocDev);
    FreeAndNil(qryChaves);
  End;
end;

function TFonteDadosBD.fRetornaInscSubstitutoTributarioEmpresa(strEmpresa, strEstadoDestino: String): String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  EMP_INSSUB ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  EMPISB ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  EMP_CODEMP = :CODEMP AND  ');
    qryAux.SQL.Add('  EMP_ESTADO = :ESTADO      ');

    qryAux.ParamByName('CODEMP').AsString := strEmpresa;
    qryAux.ParamByName('ESTADO').AsString := strEstadoDestino;
    qryAux.Open;

    Result := qryAux.FieldByName('EMP_INSSUB').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fRetornaLoteUtilizandoMaisDeUmaLocFis(
  strSeqDet, strNumLot: String): String;
var
  qryLote: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := strNumLot;

  if fConfiguracao('NFELOT') <> 'S' then
    Exit;

  if fConfiguracao('UM1LFL') <> 'S' then
    Exit;

  if fEmptyStr(strSeqDet) then
    Exit;

  if UpperCase(Trim(Result)) <> 'A DEFINIR' then
    Exit;

  if not fTabelaExiste('DETLOC') then
    Exit;

  qryLote := fCriaQuery(Nil);

  try
    qryLote.Close;
    qryLote.SQL.Clear;
    qryLote.SQL.Add('SELECT TRIM(GROUP_CONCAT(DTL_NUMLOT)) AS NUMLOT');
    qryLote.SQL.Add('FROM DETLOC');
    qryLote.SQL.Add('WHERE DTL_INCDET = :INCDET');
    qryLote.ParamByName('INCDET').AsString := strSeqDet;
    qryLote.Open;

    if qryLote.IsEmpty then
      Exit;

    if fEmptyStr(qryLote.FieldByName('NUMLOT').AsString) then
      Exit;

    Result := qryLote.FieldByName('NUMLOT').AsString;
  finally
    FreeAndNil(qryLote);
  end;
end;

function TFonteDadosBD.fBuscaAlqIBPT(strNcm: String; blnImport: Boolean): Double;
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strSQL: String;
begin
  Try
    Result := 0;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  IBP_ALQNAC, ';
    strSQL := strSQL + '  IBP_ALQIMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADIBP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  IBP_N_C_M_ = :NCM';

    qryAux := fCriaQuery(Nil);
    qryAux.Close;
    qryAux.SQL.Text := strSQL;
    qryAux.ParamByName('NCM').AsString := strNcm;
    qryAux.Open;

    If qryAux.IsEmpty Then
    Begin
      qryAux.Close;
      qryAux.ParamByName('NCM').AsString := LeftStr(strNcm,4);
      qryAux.Open;
    End;

    If qryAux.IsEmpty Then
    Begin
      qryAux.Close;
      qryAux.ParamByName('NCM').AsString := LeftStr(strNcm,2);
      qryAux.Open;
    End;

    If Not qryAux.IsEmpty Then
    Begin
      If blnImport Then
        Result := qryAux.FieldByName('IBP_ALQIMP').AsFloat
      Else
        Result := qryAux.FieldByName('IBP_ALQNAC').AsFloat;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fRetornaPedidoDoDocumentoSeExistir(var strPedido: String;
  dadosGerais: TDadosGerais; blnModelo2: Boolean = False): Boolean;
var
  qryPedido: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryPedido := fCriaQuery(Nil);

  try
    Result := False;
    strPedido := '';

    qryPedido.Close;
    qryPedido.SQL.Clear;
    qryPedido.SQL.Add('SELECT DET_NUM_PD, DET_ESP_PD, DET_EMP_PD');
    qryPedido.SQL.Add('FROM MOVDET');
    qryPedido.SQL.Add('WHERE DET_NUMDOC = :NUMDOC');
    qryPedido.SQL.Add('AND DET_ESPDOC = :ESPDOC');
    qryPedido.SQL.Add('AND DET_CODEMP = :CODEMP');
    qryPedido.SQL.Add('AND DET_CODCLI = :CODCLI');
    qryPedido.SQL.Add('AND DET_SERIE_ = :SERIE_');
    qryPedido.SQL.Add('AND DET_NUM_PD IS NOT NULL');
    qryPedido.SQL.Add('AND DET_ESP_PD IS NOT NULL');
    qryPedido.SQL.Add('AND DET_EMP_PD IS NOT NULL');

    qryPedido.ParamByName('NUMDOC').AsString := dadosGerais.strNumDoc;
    qryPedido.ParamByName('ESPDOC').AsString := dadosGerais.strEspDoc;
    qryPedido.ParamByName('CODEMP').AsString := dadosGerais.strCodEmp;
    qryPedido.ParamByName('CODCLI').AsString := dadosGerais.strCodCli;
    qryPedido.ParamByName('SERIE_').AsString := dadosGerais.strSerie;

    qryPedido.Open;

    if qryPedido.IsEmpty then
      Exit;

    If blnModelo2 Then
      strPedido := '%' + qryPedido.FieldByName('DET_NUM_PD').AsString + 'A-' + qryPedido.FieldByName('DET_ESP_PD').AsString + '-' + qryPedido.FieldByName('DET_EMP_PD').AsString + '%'
    Else
      strPedido := qryPedido.FieldByName('DET_NUM_PD').AsString + '-A-' + qryPedido.FieldByName('DET_ESP_PD').AsString + '-' + qryPedido.FieldByName('DET_EMP_PD').AsString + '-000%';

    Result := True;
  finally
    FreeAndNil(qryPedido);
  end;
end;

function TFonteDadosBD.fRetornaPercetualDevolvido(qryDados: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Double;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    blnTemSerDev : Boolean;
    blnEnvioFornecedorDev: Boolean;
begin
  blnEnvioFornecedorDev := False;

  if Assigned(QryDados.FindField('GER_OPCDOC')) Then
    blnEnvioFornecedorDev := (QryDados.FindField('GER_OPCDOC').AsString = 'NG');

  qryAux := fCriaQuery(Nil);
  Try
    blnTemSerDev := fCampoExiste('MOVDET', 'DET_SERDEV');

    qryAux.SQL.Add(' SELECT SUM(DET_TOTITE-DET_DESESP) AS TOTAL ');
    qryAux.SQL.Add('   FROM MOVDET ');
    qryAux.SQL.Add('  WHERE DET_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('    AND DET_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('    AND DET_CODEMP = :CODEMP ');

    If (qryDados.FieldByName('FIS_TIP_FC').AsString = 'C') Then
      qryAux.SQL.Add('  AND DET_CODCLI = :CODCLI ')
    Else
      qryAux.SQL.Add('  AND DET_CODFOR = :CODCLI ');

    If (blnTemSerDev) Then
      qryAux.SQL.Add('  AND DET_SERIE_ = :SERIE_ ');

    qryAux.SQL.Add('    AND DET_TIP_FC = :TIP_FC ');
    qryAux.SQL.Add('    AND DET_CODITE = :CODITE ');
    qryAux.SQL.Add('    AND DET_ORIDOC = "" ');

    qryAux.ParamByName('NUMDOC').AsString := qryDados.FieldByName('DET_DOCDEV').AsString;
    qryAux.ParamByName('ESPDOC').AsString := qryDados.FieldByName('DET_ESPDEV').AsString;
    qryAux.ParamByName('CODEMP').AsString := qryDados.FieldByName('DET_EMPDEV').AsString;
    qryAux.ParamByName('CODCLI').AsString := qryDados.FieldByName('FIS_FORCLI').AsString;

    If (blnTemSerDev) Then
      qryAux.ParamByName('SERIE_').AsString := qryDados.FieldByName('DET_SERDEV').AsString;

    qryAux.ParamByName('TIP_FC').AsString := qryDados.FieldByName('FIS_TIP_FC').AsString;
    qryAux.ParamByName('CODITE').AsString := qryDados.FieldByName('DET_CODITE').AsString;

    qryAux.Open;

    Result := 0;

    If qryAux.FieldByName('TOTAL').AsFloat > 0 Then
    Begin
      Result := (qryDados.FieldByName('DET_TOTITE').AsFloat - qryDados.FieldByName('DET_DESESP').AsFloat) /
                qryAux.FieldByName('TOTAL').AsFloat;
      Result := fFormataFloat(Result * 100, 2);
      if (Result > 100) and blnEnvioFornecedorDev then
        Result := 100;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TFonteDadosBD.pCarregaDuplicatasCND(strTabela, strAutoincrem:String);
Var qryCND: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    intIndex: Integer;
Begin
  FillChar(arrDuplicataCND, SizeOf(arrDuplicataCND), #0);
  qryCND := fCriaQuery(Nil);
  Try
    With qryCND Do
    Begin
      SQL.Clear;

      If (Pos(strTabela, 'MOVGER_MOVDET_') > 0) Then
      Begin
        SQL.Add('SELECT GER_PARCEL, GER_VALPAR FROM GERCND INNER JOIN MOVGER ON GERCND.GER_SEQGER = MOVGER.AUTOINCREM');
        SQL.Add(' WHERE MOVGER.AUTOINCREM = :AUTOINCREM               ');
      End
      Else
      Begin
        SQL.Add('SELECT GER_PARCEL, GER_VALPAR FROM NOTCND INNER JOIN NOTGER ON NOTCND.GER_SEQGER = NOTGER.AUTOINCREM');
        SQL.Add(' WHERE NOTGER.AUTOINCREM = :AUTOINCREM               ');
      End;
      SQL.Add('ORDER BY GER_PARCEL');

      ParamByName('AUTOINCREM').AsString := strAutoincrem ;
      Open;
      First;

      blnTemDupCND := (Not IsEmpty);

      intIndex := 0;
      While Not Eof do
      Begin
        arrDuplicataCND[intIndex].strSequen := FieldByName('GER_PARCEL').AsString;
        arrDuplicataCND[intIndex].curValor  := fFormataFloat(FieldByName('GER_VALPAR').AsFloat, 2);
        Inc(intIndex);

        Next;
      End;
    End;
  Finally
    FreeAndNil(qryCND);
  End;
End;

procedure TFonteDadosBD.pModificaXMLNFeBD(AChaveAcesso, AXML: string);
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strSQLLog,
  LXML: String;
begin
  If Not (fCfgSisFonte(Self, 'NFSCIT') = 'S') Then
    Exit;

  If Pos('<XmlOriginal>', AXML) > 0 Then
    Exit;

  pLogImp('TFonteDadosBD.pModificaXMLNFeBD >');

  qryAux := fCriaQuery(Nil);
  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT NFE_ARQXML FROM XMLNFE ');
    qryAux.SQL.Add('WHERE NFE_ARQXML LIKE "%XML_ORIGINAL%" ');
    qryAux.SQL.Add('  AND NFE_ACESSO = :ACESSO ');
    qryAux.ParamByName('ACESSO').AsString := AChaveAcesso;

    pLogImp('<qryAux.Open;>');
    strSQLLog := qryAux.SQL.Text;
    strSQLLog := AnsiReplaceStr(strSQLLog, ':ACESSO', QuotedStr(AChaveAcesso));
    pLogImp(Trim(strSQLLog));

    qryAux.Open;

    pLogImp('</qryAux.Open;>');

    LXML := qryAux.FieldByName('NFE_ARQXML').AsString;

    If (Not fEmptyStr(LXML)) Then
    Begin
      LXML := AnsiReplaceStr(LXML, 'XML_ORIGINAL', AXML);

      pAtualizaXMLNFeBD(AChaveAcesso, LXML);
    End;

  Finally
    FreeAndNil(qryAux);
  End;
  pLogImp('TFonteDadosBD.pModificaXMLNFeBD <');
end;

procedure TFonteDadosBD.pAtualizaXMLNFeBD(AChaveAcesso, AXML: string);
  const strCampoChave: string = 'NFE_ACESSO';
  const strTabela: string = 'XMLNFE';
  const strCampo: string = 'NFE_ARQXML';

  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strSQLLog,
    strComando: string;
    blnInTransaction: Boolean;
begin
  blnInTransaction := False;

  pLogImp('TFonteDadosBD.pAtualizaXMLNFeBD >');

  qryAux := fCriaQuery(Nil);

  try
    try
      blnInTransaction := Database.InTransaction;

      if not blnInTransaction then
        Database.StartTransaction;

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE ' + strTabela );
      qryAux.SQL.Add(' SET ' + strCampo + ' = :XML ');
      qryAux.SQL.Add('WHERE ' + strCampoChave + ' = :CHAVE ');
      qryAux.ParamByName('CHAVE').AsString := AChaveAcesso;
      qryAux.ParamByName('XML').AsString := AnsiReplaceStr(AnsiReplaceStr(AXML, #13#10, ' '), #10, ' ');

      pLogImp('<qryAux.ExecSQL;>');
      strSQLLog := qryAux.SQL.Text;
      pLogImp(Trim(strSQLLog));

      qryAux.ExecSQL;

      pLogImp('</qryAux.ExecSQL;>');

      strComando := qryAux.SQL.Text;
      strComando := AnsiReplaceStr(strComando, ':CHAVE', QuotedStr(qryAux.ParamByName('CHAVE').AsString));
      strComando := AnsiReplaceStr(strComando, ':XML', QuotedStr(AXML));
      strComando := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strComando, #13#10, ' '), #10, ' '), #13, ' ');

      pLogImp('pGravaLogRep > '+strComando);
      pGravaLogRep(strComando, strTabela, 'N');

      if not blnInTransaction then
        Database.Commit;
    except
      on E: Exception do
      begin
        if not blnInTransaction then
          Database.Rollback;

        pLogImp(E.Message + ' [untUtilBD.fAtualizaXMLNFeBD]');
        Exception.Create(E.Message + ' [untUtilBD.fAtualizaXMLNFeBD]');
      end;
    end;

  finally
    FreeAndNil(qryAux);
  end;
  pLogImp('TFonteDadosBD.pAtualizaXMLNFeBD <');
end;

procedure TFonteDadosBD.pSalvarXMLNFeBD(AChaveAcesso, AXML: string; AXMLJaBaixado: String = '');
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strSQLLog,
    strComando: string;
    blnInTransaction: Boolean;
    blnSalvar: Boolean;
begin
  pLogImp('TFonteDadosBD.pSalvarXMLNFeBD >');

  If (Not fCampoExiste('XMLNFE', 'NFE_ACESSO')) Then
  Begin
    pLogImp('TFonteDadosBD.pSalvarXMLNFeBD < NÃO EXISTE XMLNFE-NFE_ACESSO');
    Exit;
  End;

  If (Not fCampoExiste('XMLNFE', 'NFE_ARQXML')) Then
  Begin
    pLogImp('TFonteDadosBD.pSalvarXMLNFeBD < NÃO EXISTE XMLNFE-NFE_ARQXML');
    Exit;
  End;

  If fEmptyStr(AChaveAcesso) Then
  Begin
    pLogImp('TFonteDadosBD.pSalvarXMLNFeBD < AChaveAcesso='' > Exit;');
    Exit;
  End;

  blnInTransaction := False;
  qryAux := fCriaQuery(Nil);
  Try
    blnSalvar := (AXMLJaBaixado <> 'S');

    If (AXMLJaBaixado = '') Then
    Begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT COUNT(1) AS QTD FROM XMLNFE ');
      qryAux.SQL.Add(' WHERE NFE_ACESSO = :CHV           ');
      qryAux.ParamByName('CHV').AsString := AChaveAcesso;

      pLogImp('<qryAux.Open;>');
      strSQLLog := qryAux.SQL.Text;
      strSQLLog := AnsiReplaceStr(strSQLLog, ':CHV', QuotedStr(AChaveAcesso));
      pLogImp(Trim(strSQLLog));

      qryAux.Open;
      pLogImp('</qryAux.Open;>');

      blnSalvar := (qryAux.FieldByName('QTD').AsInteger = 0);
    End;

    If (blnSalvar) Then
    Begin
      Try
        blnInTransaction := Database.InTransaction;

        If not blnInTransaction Then
          Database.StartTransaction;

        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add('INSERT INTO XMLNFE        ');
        qryAux.SQL.Add('   SET NFE_ARQXML = :XML, ');
        qryAux.SQL.Add('       NFE_ACESSO = :CHV; ');
        qryAux.ParamByName('CHV').AsString := AChaveAcesso;
        qryAux.ParamByName('XML').AsString := AnsiReplaceStr(AnsiReplaceStr(AXML, #13#10, ' '), #10, ' ');

        pLogImp('<qryAux.ExecSQL;>');
        strSQLLog := qryAux.SQL.Text;
        pLogImp(Trim(strSQLLog));

        qryAux.ExecSQL;

        pLogImp('</qryAux.ExecSQL;>');

        strComando := qryAux.SQL.Text;
        strComando := AnsiReplaceStr(strComando, ':CHV', QuotedStr(qryAux.ParamByName('CHV').AsString));
        strComando := AnsiReplaceStr(strComando, ':XML', QuotedStr(AXML));
        strComando := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strComando, #13#10, ' '), #10, ' '), #13, ' ');

        pLogImp('pGravaLogRep > '+strComando);
        pGravaLogRep(strComando, 'XMLNFE', 'N');

        If Not blnInTransaction Then
          Database.Commit;

        {$IF Defined(UNIDAC) Or Defined(LINUX)}
        dicXmlBai.AddOrSetValue(AChaveAcesso, 'S');
        {$IFEND}
      Except
        On E: Exception Do
        Begin
          If not blnInTransaction Then
            Database.Rollback;

          If (Pos('duplicada', LowerCase(E.Message)) > 0) Or
             (Pos('duplicate', LowerCase(E.Message)) > 0) Then
          Begin
            pLogImp('XML já gravado por outro processo ignorando duplicate key. '+E.Message);
            {$IF Defined(UNIDAC) Or Defined(LINUX)}
            dicXmlBai.AddOrSetValue(AChaveAcesso, 'S');
            {$IFEND}
            Exit;
          End;

          pLogImp(E.Message + ' [untUtilBD.pSalvarXMLNFeBD]');
          Exception.Create(E.Message + ' [untUtilBD.pSalvarXMLNFeBD]');
        End;
      End;
    End
    Else
    Begin
      pLogImp('XMLNFE JÁ SALVA');
      pModificaXMLNFeBD(AChaveAcesso, AXML);
    End;
  Finally
    FreeAndNil(qryAux);
  End;

  pLogImp('TFonteDadosBD.pSalvarXMLNFeBD <');
end;

function TFonteDadosBD.fRetornaXMLNFeBD(AChaveAcesso: string): String;
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strSQLLog: String ;
begin
  if not fTabelaExiste('XMLNFE') then
    Exit;

  pLogImp('TFonteDadosBD.fRetornaXMLNFeBD >');

  qryAux := fCriaQuery(Nil);
  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT NFE_ARQXML FROM XMLNFE ');
    qryAux.SQL.Add('WHERE NFE_ACESSO = :ACESSO ');
    qryAux.ParamByName('ACESSO').AsString := AChaveAcesso;

    pLogImp('<qryAux.Open;>');
    strSQLLog := qryAux.SQL.Text;
    strSQLLog := AnsiReplaceStr(strSQLLog, ':ACESSO', QuotedStr(AChaveAcesso));
    pLogImp(Trim(strSQLLog));

    qryAux.Open;

    pLogImp('</qryAux.Open;>');

    Result := qryAux.FieldByName('NFE_ARQXML').AsString;

  Finally
    FreeAndNil(qryAux);
  End;
  pLogImp('TFonteDadosBD.fRetornaXMLNFeBD <');
end;

procedure TFonteDadosBD.pSalvarPDFNFeBD(AChaveAcesso, APDF: string; APDFJaBaixado: String = '');
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strSQLLog: String;
    blnInTransaction: Boolean;
    blnSalvar: Boolean;
begin
  pLogImp('TFonteDadosBD.pSalvarPDFNFeBD >');

  If (Not fCampoExiste('PDFNFE', 'NFE_ACESSO')) Then
  Begin
    pLogImp('TFonteDadosBD.pSalvarPDFNFeBD < NÃO EXISTE PDFNFE-NFE_ACESSO');
    Exit;
  End;

  If (Not fCampoExiste('PDFNFE', 'NFE_ARQPDF')) Then
  Begin
    pLogImp('TFonteDadosBD.pSalvarPDFNFeBD < NÃO EXISTE PDFNFE-NFE_ARQPDF');
    Exit;
  End;

  If fEmptyStr(AChaveAcesso) Then
  Begin
    pLogImp('TFonteDadosBD.pSalvarPDFNFeBD < AChaveAcesso='' > Exit;');
    Exit;
  End;

  blnInTransaction := False;
  qryAux := fCriaQuery(Nil);
  Try
    blnSalvar := (APDFJaBaixado <> 'S');

    If (APDFJaBaixado = '') Then
    Begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT COUNT(1) AS QTD FROM PDFNFE ');
      qryAux.SQL.Add(' WHERE NFE_ACESSO = :CHV ');
      qryAux.ParamByName('CHV').AsString := AChaveAcesso;

      pLogImp('<qryAux.Open;>');
      strSQLLog := qryAux.SQL.Text;
      strSQLLog := AnsiReplaceStr(strSQLLog, ':CHV', QuotedStr(AChaveAcesso));
      pLogImp(Trim(strSQLLog));

      qryAux.Open;
      pLogImp('</qryAux.Open;>');

      blnSalvar := (qryAux.FieldByName('QTD').AsInteger = 0);
    End;

    If blnSalvar Then
    Begin
      try
        blnInTransaction := Database.InTransaction;

        If Not blnInTransaction Then
          Database.StartTransaction;

        pLogImp('fBase64Codifica(APDF) >');
        APDF := fBase64Codifica(APDF);
        pLogImp('fBase64Codifica(APDF) <');

        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add('INSERT INTO PDFNFE        ');
        qryAux.SQL.Add('   SET NFE_ARQPDF = :PDF, ');
        qryAux.SQL.Add('       NFE_ACESSO = :CHV; ');
        qryAux.ParamByName('CHV').AsString := AChaveAcesso;
        qryAux.ParamByName('PDF').AsString := APDF;

        pLogImp('<qryAux.ExecSQL;>');
        strSQLLog := qryAux.SQL.Text;
        pLogImp(Trim(strSQLLog));

        qryAux.ExecSQL;

        pLogImp('</qryAux.ExecSQL;>');

        If Not blnInTransaction Then
          Database.Commit;
      Except
        On E: Exception Do
        Begin
          If not blnInTransaction Then
            Database.Rollback;

          pLogImp(E.Message + ' [untUtilBD.pSalvarPDFNFeBD]');
          Exception.Create(E.Message + ' [untUtilBD.pSalvarPDFNFeBD]');
        End;
      End;
    End
    Else
    Begin
      pLogImp('PDFNFE JÁ SALVA');
    End;
  Finally
    FreeAndNil(qryAux);
  End;

  pLogImp('TFonteDadosBD.pSalvarPDFNFeBD <');
end;

function TFonteDadosBD.fUsaNotaServicoEletronicaEnotas: Boolean;
begin
  Result := (fCfgSisFonte(Self, 'NFSENO', FCodEmp) = 'S');
end;

function TFonteDadosBD.fUsaRotinaWMS: Boolean;
var strAuxCfg: string;
begin
  Result := False;

  if fConfiguracao('UTIWMS') <> 'S' then
    Exit;

  if fConfiguracao('CTLEST') <> '1' then
    Exit;

  if fConfiguracao('CADLOC') <> 'S' then
    Exit;

  if fConfiguracao('CONFME') <> '1' then
    Exit;

  if fConfiguracao('USACON') <> 'S' then
    Exit;

  strAuxCfg := fConfiguracao('TIPEXP');
  Result := (strAuxCfg = '3') or (strAuxCfg = '4') or (strAuxCfg = '5');
end;

function TFonteDadosBD.XMlJaBaixado(AChaveAcesso: string): Boolean;
var
  qryXML : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  if not fTabelaExiste('XMLNFE') then
  begin
    Result := False;
    Exit;
  end;

  {$IF Defined(UNIDAC) Or Defined(LINUX)}
  If dicXmlBai.ContainsKey(AChaveAcesso) Then
  Begin
    Result := True;
    Exit;
  End;
  {$IFEND}

  qryXML := fCriaQuery(nil);
  try
    qryXML.Close;
    qryXML.SQL.Clear;
    qryXML.SQL.Add('SELECT CAST(IF(TRIM(IFNULL(NFE_ARQXML,"")) = "", "N", "S") AS CHAR(1)) AS XML_EXI FROM XMLNFE WHERE NFE_ACESSO = :ACESSO');
    qryXML.ParamByName('ACESSO').AsString := AChaveAcesso;
    qryXML.Open;
    qryXML.First;

    if (qryXML.IsEmpty) or (qryXML.FieldByName('XML_EXI').AsString = 'N') then
      Result := False
    else
      Result := True;
  finally
    qryXML.free;
  end;
end;

function TFonteDadosBD.PDFJaBaixado(AChaveAcesso: string): Boolean;
var
  qryPDF : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  if not fTabelaExiste('PDFNFE') then
  begin
    Result := False;
    Exit;
  end;

  qryPDF := fCriaQuery(nil);
  try
    qryPDF.Close;
    qryPDF.SQL.Clear;
    qryPDF.SQL.Add('SELECT CAST(IF(TRIM(IFNULL(NFE_ARQPDF,"")) = "", "N", "S") AS CHAR(1)) AS PDF_EXI FROM PDFNFE WHERE NFE_ACESSO = :ACESSO');
    qryPDF.ParamByName('ACESSO').AsString := AChaveAcesso;
    qryPDF.Open;
    qryPDF.First;

    if (qryPDF.IsEmpty) or (qryPDF.FieldByName('PDF_EXI').AsString = 'N') then
      Result := False
    else
      Result := True;
  finally
    qryPDF.free;
  end;
end;

{$IFNDEF LINUX}
procedure TFonteDadosBD.AfterConnect(Sender: TObject);
begin
  pDefinirTimeZoneEmSessaoMySql;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFonteDadosBD.pDefinirTimeZoneEmSessaoMySql;
  Var
    qryConexao : {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strUSATMZ : String;
begin
  If fEmptyStr(Self.FCodEmp) Then
    Exit;
  Try
    strUSATMZ := fConfiguracao('USATMZ', Self.FCodEmp);
  Except
    Exit;
  End;
  If (fEmptyStr(strUSATMZ)) Or (strUSATMZ = 'N') Then
    Exit;
  qryConexao := fCriaQuery(Nil);
  Try
    qryConexao.SQL.Text := Format('SET time_zone = %s;', [QuotedStr(fCfgTmZoneToMySqlFormatTimeZone)]);
    qryConexao.ExecSQL;
  Finally
    FreeAndNil(qryConexao);
  End;
end;
{$ENDIF}

procedure TFonteDadosBD.pDestroiArrDuplicatas;
  Var
    intIdx: Integer;
begin
  If Assigned(Self.dadosGerais) Then
  Begin
    For intIdx := Low(Self.dadosGerais.arrDuplicatas) To High(Self.dadosGerais.arrDuplicatas) Do
    Begin
      If Assigned(Self.dadosGerais.arrDuplicatas[intIdx]) Then
        FreeAndNil(Self.dadosGerais.arrDuplicatas[intIdx]);
    End;
    SetLength(Self.dadosGerais.arrDuplicatas, 0);
  End;
end;

procedure TFonteDadosBD.pDestroiArrFormasPagamento;
  Var
    intIdx: Integer;
begin
  If Assigned(Self.dadosGerais) Then
  Begin
    For intIdx := Low(Self.dadosGerais.arrFormasPagamento) To High(Self.dadosGerais.arrFormasPagamento) Do
    Begin
      If Assigned(Self.dadosGerais.arrFormasPagamento[intIdx]) Then
        FreeAndNil(Self.dadosGerais.arrFormasPagamento[intIdx]);
    End;
    SetLength(Self.dadosGerais.arrFormasPagamento, 0);
  End;
end;

procedure TFonteDadosBD.pDestroiArrFormasPagamentoInterna;
  Var
    intIdx: Integer;
begin
  For intIdx := Low(arrFormasPagamentoInterna) To High(arrFormasPagamentoInterna) Do
  Begin
    If Assigned(arrFormasPagamentoInterna[intIdx]) Then
      FreeAndNil(arrFormasPagamentoInterna[intIdx]);
  End;
  SetLength(arrFormasPagamentoInterna, 0);
end;

{$IFNDEF LINUX}
function TFonteDadosBD.fCfgTmZoneToMySqlFormatTimeZone: String;
  Const
    arrTimeZonesPemrmitidos : Array [1..4] Of Integer = (-2, -3, -4, -5);
  Var
    strTimeZone : String;
    intTimeZone : Integer;
    intCnt : Integer;
begin
  Result := '-3:00';
  If fEmptyStr(Self.FCodEmp) Then
    Exit;
  Try
    strTimeZone := fConfiguracao('TMZONE', Self.FCodEmp);
  Except
    Exit;
  End;
  If fEmptyStr(strTimeZone) Then
    Exit;
  intTimeZone := StrToIntDef(strTimeZone, 0);
  For intCnt := Low(arrTimeZonesPemrmitidos) To High(arrTimeZonesPemrmitidos) Do
  Begin
    If (arrTimeZonesPemrmitidos[intCnt] = intTimeZone) Then
    Begin
      Result := Format('%d:00', [intTimeZone]);
      Exit;
    End;
  End;
end;
{$ENDIF}

function TFonteDadosBD.CarregarPDF(AChaveAcesso, ANomeArquivo: string; AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean): string;
var
  qryPDF : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LArquivoPDF: String;
  LConteudoPDF: TStringStream;
begin
  Result := EmptyStr;

  if not fTabelaExiste('PDFNFE') then
    Exit;

  qryPDF := fCriaQuery(nil);
  try
    qryPDF.Close;
    qryPDF.SQL.Clear;
    qryPDF.SQL.Add('SELECT * FROM PDFNFE WHERE NFE_ACESSO = :ACESSO ' + IIF(AIgnorarLayoutSimplificado, ' AND (NFE_NFESIM = "N" OR IFNULL(NFE_NFESIM, "") = "") ', ''));
    qryPDF.ParamByName('ACESSO').AsString := AChaveAcesso;
    qryPDF.Open;
    qryPDF.First;

    if qryPDF.IsEmpty then
      raise Exception.Create('Nenhum registro foi encontrado na tabela PDFNFE para carregar o PDF.');

    if qryPDF.FieldByName('NFE_ARQPDF').IsNull then
      raise Exception.Create('O PDF está vazio.');

    LArquivoPDF := ANomeArquivo;

    If AExtensao Then
    Begin
      pCriarDiretorioDanfeEnotasCasoNaoExista;
      LArquivoPDF := fDiretorioDanfeEnotas + LArquivoPDF + '.pdf';
    End;

    DeleteFile(PChar(LArquivoPDF));

    LConteudoPDF := TStringStream.Create(EmptyStr);

    Try
      TBlobField(qryPDF.FieldByName('NFE_ARQPDF')).SaveToStream(LConteudoPDF);
      pExportaPDF(LConteudoPDF.DataString, LArquivoPDF);
    Finally
      FreeAndNil(LConteudoPDF);
    End;

    Result := LArquivoPDF;
  finally
    qryPDF.free;
  end;
end;

function TFonteDadosBD.fNFCeEnderecoDeConsulta(strUF: String): String;
Begin
  Result := fCampoTabela('CNS_SITE', 'NFCCNS', ['CNS_UF'], [strUF]);
End;

function TFonteDadosBD.fRetornaCaminhoNFCeOffLine: String;
var
  LPathOffLine: String;
begin
  Result := 'C:'+ PATH_SEPARATOR + 'NFCe_OFFLINE';

  LPathOffLine := fConfiguracao('PATOFF');

  If fEmptyStr(LPathOffLine) Then
    Exit;

  Result := LPathOffLine;
end;

procedure TFonteDadosBD.pNFCeOffLineConfiguracoes(strCodEmp: String);
const
 CONF_FIT = 'configuracoes.properties';

var
 strSQL: String;
 strPath: String;
 strDiretorio: String;
 stlConfig: TStringList;
 qryGenEmp: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin
  Try
    stlConfig := TStringList.Create;
    qryGenEmp := fCriaQuery(nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_C_G_C_, ';
    strSQL := strSQL + '  EMP_NOMEMP, ';
    strSQL := strSQL + '  EMP_NOMFAN, ';
    strSQL := strSQL + '  EMP_I_E_S_, ';
    strSQL := strSQL + '  EMP_INSMUN, ';
    strSQL := strSQL + '  EMP_CNAEFI, ';
    strSQL := strSQL + '  EMP_ENDERE, ';
    strSQL := strSQL + '  EMP_ENDNUM, ';
    strSQL := strSQL + '  EMP_C_E_P_, ';
    strSQL := strSQL + '  EMP_ENDCMP, ';
    strSQL := strSQL + '  EMP_BAIRRO, ';
    strSQL := strSQL + '  CID_NOMCID  AS "EMP_NOMCID", ';
    strSQL := strSQL + '  CID_ESTADO  AS "EMP_ESTADO", ';
    strSQL := strSQL + '  CID_COIBGE  AS "EMP_CODIBGE", ';
    strSQL := strSQL + '  EMP_FONE01 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + '  JOIN CADCID ON EMP_CODCID = CID_CODCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If not isEmpty Then
      Begin
        With stlConfig do
        Begin
          Add('assinador.versao_aplicativo=FIT NF-e 5.0.001');
          Add('assinador.empresa.nr_licenca='              + Trim(fConfiguracao('CITLIC')));
          Add('assinador.empresa.id_empresa='              + Trim(fConfiguracao('EMP_ID')));
          Add('assinador.empresa.id_municipio='            + Trim(FieldByName('EMP_CODIBGE').AsString));
          Add('assinador.empresa.nr_cnpj='                 + Trim(FieldByName('EMP_C_G_C_').AsString));
          Add('assinador.empresa.cd_regime_tributario='    + fRegimeTributarioEmitente(fConfiguracao('SIMPAU'), fConfiguracao('SIMBRU')));
          Add('assinador.empresa.id_uf='                   + Trim(FieldByName('EMP_ESTADO').AsString));
          Add('assinador.empresa.nm_razao_social='         + Trim(FieldByName('EMP_NOMEMP').AsString));
          Add('assinador.empresa.nm_fantasia='             + Trim(FieldByName('EMP_NOMFAN').AsString));
          Add('assinador.empresa.nr_inscricao_estadual='   + Trim(FieldByName('EMP_I_E_S_').AsString));
          Add('assinador.empresa.nr_inscricao_municipal='  + Trim(FieldByName('EMP_INSMUN').AsString));
          Add('assinador.empresa.cnae='                    + Trim(FieldByName('EMP_CNAEFI').AsString));
          Add('assinador.empresa.ds_endereco='             + Trim(FieldByName('EMP_ENDERE').AsString));
          Add('assinador.empresa.nr_endereco='             + Trim(FieldByName('EMP_ENDNUM').AsString));
          Add('assinador.empresa.nr_cep='                  + Trim(FieldByName('EMP_C_E_P_').AsString));
          Add('assinador.empresa.ds_endereco_compl='       + Trim(FieldByName('EMP_ENDCMP').AsString));
          Add('assinador.empresa.ds_bairro='               + Trim(FieldByName('EMP_BAIRRO').AsString));
          Add('assinador.empresa.ds_municipio='            + Trim(FieldByName('EMP_NOMCID').AsString));
          Add('assinador.empresa.id_pais=1058');
          Add('assinador.empresa.nr_ddd=');
          Add('assinador.empresa.nr_telefone='             + Trim(FieldByName('EMP_FONE01').AsString));
          Add('assinador.url_qrcode='                      + fConfiguracao('QRCODE'));
          Add('assinador.responsavel_tecnico.gerar_tag=S');
          Add('assinador.responsavel_tecnico.id_csrt=');
          Add('assinador.responsavel_tecnico.cd_csrt=');
        End;

        strPath := ExtractFilePath(Application.ExeName);

        strDiretorio := fRetornaCaminhoNFCeOffLine;

        If not DirectoryExists(strDiretorio) Then
          CreateDir(strDiretorio);

        strDiretorio := strDiretorio + PATH_SEPARATOR + strCodEmp;

        If not DirectoryExists(strDiretorio) Then
        Begin
          If CreateDir(strDiretorio) Then
          Begin
           {$IFDEF LINUX}
            raise Exception.Create('ShellExecuteAndWait não possui implementação linux');
           {$ELSE}
            ShellExecuteAndWait('', 'cmd.exe', PChar('/C XCOPY /S /E "' + strPath + PATH_SEPARATOR + 'assinador' + PATH_SEPARATOR + 'Template' + PATH_SEPARATOR + '*.*" '+ '"'+strDiretorio+'"'),
                                               PChar(strPath + PATH_SEPARATOR +'assinador' + PATH_SEPARATOR +'Template'), SW_HIDE, True);
           {$ENDIF}
          End;
        End;

        If DirectoryExists(strDiretorio) Then
          stlConfig.SaveToFile(strDiretorio+PATH_SEPARATOR+CONF_FIT);
      End;

      Close;
    End;

  Finally
    FreeAndNil(stlConfig);
    FreeAndNil(qryGenEmp);
  End;
End;

procedure TFonteDadosBD.pCarregaInformacoesDoIntermediadorDaTransacao(var dadosGerais: TDadosGerais);
Var
  qryGen : {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

  function fGetSQL(ATabDet: String): String;
  begin
    Result := '';
    Result := Result + ' SELECT DISTINCT ';
    Result := Result + '   ORI_CODORI,   ';
    Result := Result + '   ORI_DESORI,   ';
    Result := Result + '   ORI_C_G_C_,   ';
    Result := Result + '   ORI_IDENTI    ';
    Result := Result + ' FROM            ';
    Result := Result + '   ' + ATabDet + '   ';
    Result := Result + '   INNER JOIN FATGOR ON DET_NUM_PD = FATGOR.FGO_NUMDOC        ';
    Result := Result + '                    AND DET_ESP_PD = FATGOR.FGO_ESPDOC        ';
    Result := Result + '                    AND DET_EMP_PD = FATGOR.FGO_CODEMP        ';
    Result := Result + '   INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
    Result := Result + '   INNER JOIN ORIFGO ON EXTGOR.FGO_CODORI = ORIFGO.ORI_CODORI ';
    Result := Result + ' WHERE TRUE ';
    Result := Result + '   AND ORI_DESORI <> "AUTCOM" ';
    Result := Result + '   AND DET_NUMDOC = :NUMDOC   ';
    Result := Result + '   AND DET_ESPDOC = :ESPDOC   ';
    Result := Result + '   AND DET_CODEMP = :CODEMP   ';
    Result := Result + '   AND DET_TIP_FC = :TIP_FC   ';
    Result := Result + '   AND DET_SERIE_ = :SERIE_   ';

    If (FTip_FC = 'C') Then
      Result := Result + '    AND DET_CODCLI = :CLIFOR '
    Else
      Result := Result + '    AND DET_CODFOR = :CLIFOR ';
  end;
begin
  dadosGerais.strCnpjIntermediadorTransacao := '';
  dadosGerais.strIdentificacaoIntermediadorTransacao := '';

  If Not fCampoExiste('ORIFGO', 'ORI_C_G_C_') Then
    Exit;

  If Not fCampoExiste('EXTGOR', 'FGO_CODORI') Then
    Exit;

  qryGen := fCriaQuery(Nil);
  Try
    If Pos(FChaTabela, 'MOVDET_NOTDET_') > 0 Then
      qryGen.SQL.Text := fGetSQL(FChaTabela)
    Else
      qryGen.SQL.Text := fGetSQL('MOVDET') + ' UNION ' + fGetSQL('NOTDET');

    qryGen.ParamByName('NUMDOC').AsString := FNumDoc;
    qryGen.ParamByName('ESPDOC').AsString := FEspDoc;
    qryGen.ParamByName('SERIE_').AsString := FSerie;
    qryGen.ParamByName('CODEMP').AsString := FCodEmp;
    qryGen.ParamByName('TIP_FC').AsString := FTip_FC;
    qryGen.ParamByName('CLIFOR').AsString := FCodCli;
    qryGen.Open;

    If fEmptyStr(qryGen.FieldByName('ORI_C_G_C_').AsString) Then
      Exit;

    dadosGerais.strCnpjIntermediadorTransacao := fTiraCaracEspeciais(qryGen.FieldByName('ORI_C_G_C_').AsString, True, True, True);
    dadosGerais.strIdentificacaoIntermediadorTransacao := fTiraCaracEspeciais(qryGen.FieldByName('ORI_IDENTI').AsString, True);
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TFonteDadosBD.pGeraTextoDocumentosVendedor(var strTexto: string; var qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
var
  strAntVen, strCodVen, strNomVen, strLblVen: string;
  blnConferente, blnExisteCampoConferente: Boolean;
  qryConf : {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

  function InsereConferente : boolean;
  Begin
    Result := True;
    If blnConferente And (dadosGerais.strOpcDoc = 'CI') And (dadosGerais.strClaFis = '5929') Then
      Result := False;
  End;

begin
  strTexto := '';
  strCodVen := '';
  strAntVen := '';
  strNomVen := '';
  strLblVen := '';

  blnExisteCampoConferente := fCampoExiste('MOVGER', 'GER_OPEEXP');
  blnConferente := False;

  while (not qryAux.Eof) do
  begin
    strCodVen := qryAux.FieldByName('CODVEN').AsString;
    strNomVen := qryAux.FieldByName('OPE_NOMOPE').AsString;

    if blnExisteCampoConferente then
    begin
      blnConferente := False;
      qryConf := fCriaQuery(nil);
      try
        qryConf.SQL.Add('SELECT GER_OPEEXP, OPE_NOMOPE FROM MOVGER   ');
        qryConf.SQL.Add('LEFT JOIN CADOPE ON OPE_CODOPE = GER_OPEEXP ');
        qryConf.SQL.Add('WHERE GER_NUMDOC = :NUMDOC                  ');
        qryConf.SQL.Add('  AND GER_ESPDOC = :ESPDOC                  ');
        qryConf.SQL.Add('  AND GER_CODEMP = :CODEMP                  ');

        qryConf.ParamByName('NUMDOC').AsString := qryAux.FieldByName('NUMFAT').AsString;
        qryConf.ParamByName('ESPDOC').AsString := qryAux.FieldByName('TIPFAT').AsString;
        qryConf.ParamByName('CODEMP').AsString := qryAux.FieldByName('EMPFAT').AsString;

        qryConf.Open;

        if qryConf.Recordcount > 0 then
        begin
          blnConferente := True;
          strCodVen := qryConf.FieldByName('GER_OPEEXP').AsString;
          strNomVen := qryConf.FieldByName('OPE_NOMOPE').AsString;
        end;

        qryConf.Close;
      finally
        FreeAndNil(qryConf);
      end;
    end;

    if blnConferente then
      strLblVen := 'Conferente: '
    else
      strLblVen := 'Vendedor: ';

    If InsereConferente Then
    Begin
      If (strAntVen <> strCodVen) Then
      Begin
        If not fEmptyStr(strTexto) Then
          strTexto := strTexto + '#';

        strTexto := strTexto + strLblVen + strCodVen + ' - ' + strNomVen + ' Documentos: ' +
                    qryAux.FieldByName('ESPDOC').AsString + '-' +
                    qryAux.FieldByName('NUMDOC').AsString;
      End
      Else
      Begin
        strTexto := strTexto + ',';
        strTexto := strTexto +
                    qryAux.FieldByName('ESPDOC').AsString + '-' +
                    qryAux.FieldByName('NUMDOC').AsString;
      End;
    End;

    strAntVen := strCodVen;
    qryAux.Next;
  end;
end;

procedure TFonteDadosBD.pGravaIcmsDesonerado(strTabela, strAutInc, strMtdIcm: String; fltIcmDes: Double);
Var
  qryAtu : {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

begin
  If Not fTabelaExiste(strTabela) Then
    Exit;

  If not fCampoExiste(strTabela, 'DET_MTDICM') Then
    Exit;

  If not fCampoExiste(strTabela, 'DET_VRDICM') Then
    Exit;

  Try
    qryAtu := fCriaQuery(Nil);

    Try
      qryAtu.Close;
      qryAtu.SQL.Clear;
      qryAtu.SQL.Add('UPDATE MOVTRI SET DET_MTDICM = :MTDICM, DET_VRDICM = :VRDICM ');
      qryAtu.SQL.Add('WHERE DET_SEQGER = :AUTINC ');
      qryAtu.ParamByName('AUTINC').AsString := strAutInc;
      qryAtu.ParamByName('MTDICM').AsString := strMtdIcm;
      qryAtu.ParamByName('VRDICM').AsFloat  := fltIcmDes;
      qryAtu.ExecSQL;

      qryAtu.Close;
      qryAtu.SQL.Clear;
      qryAtu.SQL.Add('UPDATE NOTTRI SET DET_MTDICM = :MTDICM, DET_VRDICM = :VRDICM ');
      qryAtu.SQL.Add('WHERE DET_SEQGER = :AUTINC ');
      qryAtu.ParamByName('AUTINC').AsString := strAutInc;
      qryAtu.ParamByName('MTDICM').AsString := strMtdIcm;
      qryAtu.ParamByName('VRDICM').AsFloat  := fltIcmDes;
      qryAtu.ExecSQL;

    Except
      On E: Exception Do
        Exception.Create(E.Message + ' [untUtilBD.pGravaIcmsDesonerado]');
    End;
  Finally
    FreeAndNil(qryAtu);
  End;
End;

procedure TFonteDadosBD.pGravaInfUsuarioReplicacao(intSeqReplicacao: Int64);
var
  qryUsuRep: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryUsuRep := fCriaQuery(Nil);
  Try
    qryUsuRep.SQL.Add('INSERT INTO USUREP (');
    qryUsuRep.SQL.Add('  LOG_SEQREP, ');
    qryUsuRep.SQL.Add('  LOG_NOMMAQ, ');
    qryUsuRep.SQL.Add('  LOG_NOMUSU, ');
    qryUsuRep.SQL.Add('  LOG_NUM_IP, ');
    qryUsuRep.SQL.Add('  LOG_CON_ID, ');
    qryUsuRep.SQL.Add('  LOG_MACADD) ');
    qryUsuRep.SQL.Add('VALUES (      ');
    qryUsuRep.SQL.Add('  :SEQREP,    ');
    qryUsuRep.SQL.Add('  :NOMMAQ,    ');
    qryUsuRep.SQL.Add('  :NOMUSU,    ');
    qryUsuRep.SQL.Add('  :NUM_IP,    ');
    qryUsuRep.SQL.Add('  :CON_ID,    ');
    qryUsuRep.SQL.Add('  :MACADD)    ');

    qryUsuRep.ParamByName('SEQREP').Value := intSeqReplicacao;
    qryUsuRep.ParamByName('NOMMAQ').Value := GetComputerNetName;
    qryUsuRep.ParamByName('NOMUSU').Value := GetUserFromWindows;
    qryUsuRep.ParamByName('NUM_IP').Value := GetIPAddressAsString;
    qryUsuRep.ParamByName('MACADD').Value := GetMacAddress;
    qryUsuRep.ParamByName('CON_ID').Value := VS_ConnectionID;

    qryUsuRep.ExecSQL;
  Finally
    FreeAndNil(qryUsuRep);
  End;
end;

function TFonteDadosBD.fBase64Codifica(ATexto: String): String;
var
  LEntrada:  TStringStream;
  LSaida: TStringStream;
begin
  LEntrada := TStringStream.Create(ATexto);
  LSaida   := TStringStream.Create(EmptyStr);

  Try
    EncdDecd.EncodeStream(LEntrada, LSaida);
    Result := LSaida.DataString;
  Finally
    FreeAndNil(LEntrada);
    FreeAndNil(LSaida);
  End;
end;

function TFonteDadosBD.fBase64Decodifica(ATexto: String): String;
var
  LEntrada:  TStringStream;
  LSaida: TStringStream;
begin
  LEntrada := TStringStream.Create(ATexto);
  LSaida   := TStringStream.Create(EmptyStr);

  Try
    EncdDecd.DecodeStream(LEntrada, LSaida);
    Result := LSaida.DataString;
  Finally
    FreeAndNil(LEntrada);
    FreeAndNil(LSaida);
  End;
end;

procedure TFonteDadosBD.pExportaPDF(ATexto: String; APath: String);
var
  LEntrada: TStringStream;
  LSaida: TFileStream;
  LTexto: String;
begin
  LTexto := fBase64Decodifica(ATexto);

  LSaida   := TFileStream.Create(APath, fmCreate);
  LEntrada := TStringStream.Create(LTexto);

  Try
    LSaida.CopyFrom(LEntrada, LEntrada.Size);
  Finally
    LSaida.Free;
    LEntrada.Free;
  End;
end;

function TFonteDadosBD.fCurrentDateTime: String;
begin
  Result := fCurrentDateTime(nOw());
end;

function TFonteDadosBD.fCurrentDateTime(Const Value: TDateTime): String;
begin
  Result := 'CAST("' + FormatDateTime('yyyy-mm-dd hh:mm:ss', Value) + '" AS DATETIME)';
end;

function TFonteDadosBD.fCarregarPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): String;
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := '';
  If Not fCampoExiste('LOGNFE', 'NFE_PONIMP') Then
  Begin
    Exit;
  End;

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Add('SELECT NFE_PONIMP FROM LOGNFE WHERE ');
    qryAux.SQL.Add('NFE_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('NFE_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('NFE_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('NFE_CODCLI = :CODCLI AND ');

    If fCampoExiste('LOGNFE', 'NFE_SERIE_') Then
      qryAux.SQL.Add('IFNULL(NFE_SERIE_,"") = :SERIE_ AND ');

    qryAux.SQL.Add('NFE_TIP_FC = :TIP_FC ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;

    If fCampoExiste('LOGNFE', 'NFE_SERIE_') Then
      qryAux.ParamByName('SERIE_').AsString := strSerie;

    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.Open;

    Result := qryAux.FieldByName('NFE_PONIMP').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fCarregarViaNfeGravado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): Integer;
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := -1;

  If ((Pos(strEspDoc, 'NF_IF_')) = 0) Then
    Exit;

  If (Not fCampoExiste('LOGNFE', 'NFE_VIANFE')) Then
    Exit;

  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT COALESCE(NFE_VIANFE, -1) ');
    qryAux.SQL.Add('  FROM LOGNFE                   ');
    qryAux.SQL.Add(' WHERE NFE_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('       NFE_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('       NFE_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('       NFE_CODCLI = :CODCLI AND ');

    If fCampoExiste('LOGNFE', 'NFE_SERIE_') Then
      qryAux.SQL.Add('     IFNULL(NFE_SERIE_,"") = :SERIE_ AND ');

    qryAux.SQL.Add('       NFE_TIP_FC = :TIP_FC ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;

    If fCampoExiste('LOGNFE', 'NFE_SERIE_') Then
      qryAux.ParamByName('SERIE_').AsString := strSerie;

    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.Open;

    If (Not qryAux.IsEmpty) Then
      Result := qryAux.Fields[0].AsInteger;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fDocumentoComRemessaContaOrdem(const strNumDoc, strEspDoc,
  strCodEmp: String): Boolean;
Var
  qryConsulta: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := False;

  If Not fCampoExiste('AUXMOV', 'AUX_AUTRCO') Then
    Exit;

  qryConsulta := fCriaQuery(Nil);
  Try
    If (qryDados.FieldByName('CHAVE_TABELA').AsString = 'MOVGER') Or
       (qryDados.FieldByName('CHAVE_TABELA').AsString = 'MOVDET') Then
    Begin
      qryConsulta.SQL.Text := 'SELECT '
                            + '       G.AUTOINCREM '
                            + '  FROM MOVGER G '
                            + ' INNER JOIN AUXMOV A ON A.AUX_SEQGER = G.AUTOINCREM '
                            + ' WHERE A.AUX_AUTRCO IN (SELECT M.AUTOINCREM FROM MOVGER M '
                            + '                         WHERE M.GER_NUMDOC = :NUMDOC '
                            + '                           AND M.GER_ESPDOC = :ESPDOC '
                            + '                           AND M.GER_CODEMP = :CODEMP) ';
    End
    Else
    Begin
      qryConsulta.SQL.Text := 'SELECT '
                          + '       N.AUTOINCREM '
                          + '  FROM NOTGER N '
                          + ' INNER JOIN MOVGER G ON G.GER_NUMFAT = N.GER_NUMDOC '
                          + '                    AND G.GER_TIPFAT = N.GER_ESPDOC '
                          + '                    AND G.GER_EMPFAT = N.GER_CODEMP '
                          + ' INNER JOIN AUXMOV A ON A.AUX_SEQGER = G.AUTOINCREM '
                          + ' WHERE A.AUX_AUTRCO IN (SELECT M.AUTOINCREM FROM NOTGER T '
                          + '                         INNER JOIN MOVGER M ON M.GER_NUMFAT = T.GER_NUMDOC '
                          + '                                            AND M.GER_TIPFAT = T.GER_ESPDOC '
                          + '                                            AND M.GER_EMPFAT = T.GER_CODEMP '
                          + '                         WHERE T.GER_NUMDOC = :NUMDOC '
                          + '                           AND T.GER_ESPDOC = :ESPDOC '
                          + '                           AND T.GER_CODEMP = :CODEMP) ';
    End;

    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;
    qryConsulta.Open;

    Result := Not qryConsulta.IsEmpty;

    qryConsulta.Close;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TFonteDadosBD.fGetTipOpeTransferencia(strEmpOri, strCliFil: String): String;
  Var
    qryConEmp: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := '';

  If Not fCampoExiste('CONEMP', 'CON_EMPORI') Then
  Begin
    Exit;
  End;

  If Not fCampoExiste('CONEMP', 'CON_EMPDES') Then
  Begin
    Exit;
  End;

  qryConEmp := fCriaQuery(Nil);
  Try
    With qryConEmp Do
    Begin
      SQL.Clear;
      SQL.Add(' SELECT IF(CON_TIPOPE=2, "T", "V") AS CON_TIPOPE ');
      SQL.Add('   FROM CADEMP INNER JOIN CONEMP ON CON_EMPORI = :EMPORI ');
      SQL.Add('                                AND CON_EMPDES = EMP_CODEMP ');
      SQL.Add('  WHERE EMP_CLIFIL = :CLIFIL ');
      ParamByName('EMPORI').AsString := strEmpOri;
      ParamByName('CLIFIL').AsString := strCliFil;
      Open;

      Result := FieldByName('CON_TIPOPE').AsString;

      Close;
    End;
  Finally
    FreeAndNil(qryConEmp);
  End;
end;

function TFonteDadosBD.fImprimeLoteNaDescricaoDoProduto(const strCodIte,
  strEspDoc: String): Boolean;
begin
  Result := False;

  if (fCfgSisFonte(Self, 'NFELOT') = 'N') and (fCfgSisFonte(Self, 'NFCLOT') = 'N') then
    Exit;

  if (fCfgSisFonte(Self, 'LIDPRO') = 'N') then
    Exit;

  if strEspDoc = 'IF' then
  begin
    if (fCampoExiste('CADITE', 'ITE_NFCIDP')) and (fCampoTabela('ITE_NFCIDP', 'CADITE', ['ITE_CODITE'], [strCodIte]) = 'S') then
      Result := True;
  end
  else if strEspDoc = 'NF' then
  begin
    if (fCampoExiste('CADITE', 'ITE_NFEIDP')) and (fCampoTabela('ITE_NFEIDP', 'CADITE', ['ITE_CODITE'], [strCodIte]) = 'S') then
      Result := True;
  end;
end;

function TFonteDadosBD.fRetornaClienteFilial(strCodEmp: String; strTipo_FC: String = 'C'): String;
begin
  Result := '';

  If fEmptyStr(strCodEmp) Then
  Begin
    Exit;
  End;

  If strTipo_FC = 'C' Then
  Begin
    If fCampoExiste('CADEMP', 'EMP_CLIFIL') Then
      Result := fCampoTabela('EMP_CLIFIL', 'CADEMP', ['EMP_CODEMP'], [strCodEmp])
  End
  Else
  Begin
    If fCampoExiste('CADEMP', 'EMP_FORFIL') Then
      Result := fCampoTabela('EMP_FORFIL', 'CADEMP', ['EMP_CODEMP'], [strCodEmp]);
  End;
end;

procedure TFonteDadosBD.pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
                                      strCodCli, strTip_FC, strStatus, strObserv: String;
                                      strChaAce: String=''; dtaDtaAut: TDateTime=0; strPonImp: String='');
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  intViaNfe: Integer;
  dtaDtaEmi : TDate;
begin
  If not (fCfgSisFonte(Self, 'USA_AF') = 'S') Then
    Exit;

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Add('REPLACE INTO LOGNFE (');
    qryAux.SQL.Add('  NFE_NUMDOC, ');
    qryAux.SQL.Add('  NFE_ESPDOC, ');
    qryAux.SQL.Add('  NFE_CODEMP, ');
    qryAux.SQL.Add('  NFE_CODCLI, ');

    If fCampoExiste('LOGNFE', 'NFE_DTAEMI') Then
      qryAux.SQL.Add('  NFE_DTAEMI, ');

    If fCampoExiste('LOGNFE', 'NFE_SERIE_') Then
      qryAux.SQL.Add('  NFE_SERIE_, ');

    qryAux.SQL.Add('  NFE_TIP_FC, ');
    qryAux.SQL.Add('  NFE_STATUS, ');
    qryAux.SQL.Add('  NFE_OBSERV, ');

    If fCampoExiste('LOGNFE', 'NFE_PONIMP') Then
      qryAux.SQL.Add('  NFE_PONIMP, ');

    If fCampoExiste('LOGNFE', 'NFE_VIANFE') Then
      qryAux.SQL.Add('  NFE_VIANFE, ');

    If Not fEmptyStr(strChaAce) Then
      qryAux.SQL.Add('  NFE_ACESSO, ');

    If dtaDtaAut <> 0 Then
      qryAux.SQL.Add('  NFE_DTAAUT, ');

    qryAux.SQL.Add('  NFE_HORINI) ');
    qryAux.SQL.Add('VALUES ( ');
    qryAux.SQL.Add('  :NUMDOC, ');
    qryAux.SQL.Add('  :ESPDOC, ');
    qryAux.SQL.Add('  :CODEMP, ');
    qryAux.SQL.Add('  :CODCLI, ');

    If fCampoExiste('LOGNFE', 'NFE_DTAEMI') Then
      qryAux.SQL.Add('  :DTAEMI, ');

    If fCampoExiste('LOGNFE', 'NFE_SERIE_') Then
      qryAux.SQL.Add('  :SERIE_, ');

    qryAux.SQL.Add('  :TIP_FC, ');
    qryAux.SQL.Add('  :STATUS, ');
    qryAux.SQL.Add('  :OBSERV, ');

    If fCampoExiste('LOGNFE', 'NFE_PONIMP') Then
      qryAux.SQL.Add('  :PONIMP, ');

    If fCampoExiste('LOGNFE', 'NFE_VIANFE') Then
      qryAux.SQL.Add('  :VIANFE, ');

    If Not fEmptyStr(strChaAce) Then
      qryAux.SQL.Add('  :ACESSO, ');

    If dtaDtaAut <> 0 Then
      qryAux.SQL.Add('  :DTAAUT, ');

    qryAux.SQL.Add('  '+fCurrentDateTime+' ) ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;

    If fCampoExiste('LOGNFE', 'NFE_SERIE_') Then
      qryAux.ParamByName('SERIE_').AsString := strSerie;

    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.ParamByName('STATUS').AsString := strStatus;

    If fCampoExiste('LOGNFE', 'NFE_PONIMP') Then
    Begin
      If Not fEmptyStr(strPonImp) Then
        qryAux.ParamByName('PONIMP').AsString := strPonImp
      Else
        qryAux.ParamByName('PONIMP').AsString := fCarregarPontoImpressaoGravado(strNumDoc,
          strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);
    End;

    If fCampoExiste('LOGNFE', 'NFE_VIANFE') Then
    Begin
      intViaNfe := fCarregarViaNfeGravado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);
      If (intViaNfe > -1) Then
        qryAux.ParamByName('VIANFE').AsInteger  := intViaNfe;
      If fCampoExiste('LOGNFE', 'NFE_PONIMP') Then
        If (intViaNfe = 0) And (qryAux.ParamByName('STATUS').AsString <> 'EE') And (qryAux.ParamByName('PONIMP').AsString = 'NENHUM') Then
          qryAux.ParamByName('PONIMP').AsString := '';
    End;

    If Not fEmptyStr(strChaAce) Then
      qryAux.ParamByName('ACESSO').AsString := strChaAce;

    If dtaDtaAut <> 0 Then
      qryAux.ParamByName('DTAAUT').AsDateTime := dtaDtaAut;

    qryAux.ParamByName('OBSERV').AsString := strObserv;

    If fCampoExiste('LOGNFE', 'NFE_DTAEMI') Then
    Begin
      dtaDtaEmi := fDataEmissaoDocumentoFiscal(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strTip_FC);
      If (dtaDtaEmi = 0) Then
        qryAux.ParamByName('DTAEMI').Value := Null
      Else
        qryAux.ParamByName('DTAEMI').AsDate := dtaDtaEmi;
    End;

    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fRetornaDocumentoImpresso(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): Boolean;
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := False;

  If fTabelaExiste('LOGPRT') Then
  Begin
    qryAux := fCriaQuery(Nil);
    Try
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM LOGPRT');
      qryAux.SQL.Add('WHERE PRT_NUMDOC = :NUMDOC ');
      qryAux.SQL.Add('  AND PRT_ESPDOC = :ESPDOC ');
      qryAux.SQL.Add('  AND PRT_CODEMP = :CODEMP ');
      qryAux.SQL.Add('  AND PRT_FORCLI = :CODCLI ');
      qryAux.SQL.Add('  AND PRT_TIP_FC = :TIP_FC ');
      qryAux.SQL.Add('  AND PRT_SERIE_ = :SERIE_ ');

      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
      qryAux.ParamByName('SERIE_').AsString := strSerie;

      qryAux.Open;

      If (Not qryAux.IsEmpty) Then
        Result := (qryAux.FieldByName('QTD').AsInteger > 0);

      qryAux.Close;
    Finally
      FreeAndNil(qryAux);
    End;
  End;
end;

procedure TFonteDadosBD.pGravaDocumentoImpresso(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strAutInc: String;
begin
  If fTabelaExiste('LOGPRT') Then
  Begin
    strAutInc := '';
    qryAux := fCriaQuery(Nil);
    Try
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT AUTOINCREM FROM CADFIS ');
      qryAux.SQL.Add('WHERE FIS_NUMDOC = :NUMDOC ');
      qryAux.SQL.Add('  AND FIS_ESPDOC = :ESPDOC ');
      qryAux.SQL.Add('  AND FIS_CODEMP = :CODEMP ');
      qryAux.SQL.Add('  AND FIS_FORCLI = :FORCLI ');
      qryAux.SQL.Add('  AND FIS_TIP_FC = :TIP_FC ');
      qryAux.SQL.Add('  AND FIS_SERIE_ = :SERIE_');

      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.ParamByName('FORCLI').AsString := strCodCli;
      qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
      qryAux.ParamByName('SERIE_').AsString := strSerie;

      qryAux.Open;

      If (Not qryAux.IsEmpty) Then
        strAutInc := qryAux.FieldByName('AUTOINCREM').AsString;

      qryAux.Close;

      If (Not fEmptyStr(strAutInc)) Then
      Begin
        qryAux.SQL.Clear;
        qryAux.SQL.Add('REPLACE INTO LOGPRT (');
        qryAux.SQL.Add('  PRT_SEQFIS,');
        qryAux.SQL.Add('  PRT_NUMDOC,');
        qryAux.SQL.Add('  PRT_ESPDOC,');
        qryAux.SQL.Add('  PRT_CODEMP,');
        qryAux.SQL.Add('  PRT_FORCLI,');
        qryAux.SQL.Add('  PRT_SERIE_,');
        qryAux.SQL.Add('  PRT_TIP_FC)');
        qryAux.SQL.Add('VALUES (');
        qryAux.SQL.Add('  :SEQFIS,');
        qryAux.SQL.Add('  :NUMDOC,');
        qryAux.SQL.Add('  :ESPDOC,');
        qryAux.SQL.Add('  :CODEMP,');
        qryAux.SQL.Add('  :FORCLI,');
        qryAux.SQL.Add('  :SERIE_,');
        qryAux.SQL.Add('  :TIP_FC)');

        qryAux.ParamByName('SEQFIS').AsString := strAutInc;
        qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
        qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
        qryAux.ParamByName('CODEMP').AsString := strCodEmp;
        qryAux.ParamByName('FORCLI').AsString := strCodCli;
        qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
        qryAux.ParamByName('SERIE_').AsString := strSerie;

        qryAux.ExecSQL;
      End;
    Finally
      FreeAndNil(qryAux);
    End;
  End;
end;

function TFonteDadosBD.fRetornaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc, strTipInt: String): Boolean;
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := False;

  If not fTabelaExiste('PCITEL') Then
    Exit;

  If fEmptyStr(fCfgSisFonte(Self, 'PUBKEY', strCodEmp)) Then
    Exit;

  qryAux := fCriaQuery(Nil);

  Try
    //QUERY...
    qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM PCITEL');
    qryAux.SQL.Add('WHERE NFE_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('  AND NFE_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('  AND NFE_CODEMP = :CODEMP ');
    qryAux.SQL.Add('  AND NFE_TIPINT = :TIPINT ');

    If (strEspDoc <> 'CT') Then
    Begin
      qryAux.SQL.Add('  AND NFE_FORCLI = :CODCLI ');
      qryAux.SQL.Add('  AND NFE_TIP_FC = :TIP_FC ');
      qryAux.SQL.Add('  AND NFE_SERIE_ = :SERIE_ ');
      qryAux.SQL.Add('  AND NFE_PROTOC = :PROTOC ');
    End;
    //...QUERY

    {***************************************************}

    //PARAMS...
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('TIPINT').AsString := strTipInt;

    If (strEspDoc <> 'CT') Then
    Begin
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
      qryAux.ParamByName('SERIE_').AsString := strSerie;
      qryAux.ParamByName('PROTOC').AsString := strProtoc;
    End;
    //...PARAMS

    qryAux.Open;

    If not qryAux.IsEmpty Then
      Result := (qryAux.FieldByName('QTD').AsInteger > 0);

  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TFonteDadosBD.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc, strTipInt: String);
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strAutInc: String;
begin

  If not fTabelaExiste('PCITEL') Then
    Exit;

  If fEmptyStr(fCfgSisFonte(Self, 'PUBKEY', strCodEmp)) Then
    Exit;

  If fEmptyStr(strProtoc) Then
  Begin
    strProtoc := 'ND';
  End;

  qryAux := fCriaQuery(Nil);

  Try
    If (strEspDoc = 'CT') Then
    Begin
      qryAux.SQL.Add('SELECT CADFIS.AUTOINCREM FROM MOVCTE ');
      qryAux.SQL.Add('INNER JOIN LOGNFE ON CTE_NUMCTE = NFE_NUMDOC ');
      qryAux.SQL.Add('                 AND NFE_ESPDOC = "CT" ');
      qryAux.SQL.Add('                 AND CTE_CODEMP = NFE_CODEMP ');
      qryAux.SQL.Add('INNER JOIN MOVGER ON CTE_SEQGER = MOVGER.AUTOINCREM ');
      qryAux.SQL.Add('INNER JOIN CADFIS ON GER_NUMDOC = FIS_NUMDOC ');
      qryAux.SQL.Add('                 AND GER_ESPDOC = FIS_ESPDOC ');
      qryAux.SQL.Add('                 AND GER_SERIE_ = FIS_SERIE_ ');
      qryAux.SQL.Add('                 AND GER_CODEMP = FIS_CODEMP ');
      qryAux.SQL.Add('                 AND GER_TIP_FC = FIS_TIP_FC ');
      qryAux.SQL.Add('                 AND IFNULL(GER_CODCLI, GER_CODFOR) = FIS_FORCLI ');
      qryAux.SQL.Add('WHERE CTE_NUMCTE = :NUMDOC ');
      qryAux.SQL.Add('  AND CTE_CODEMP = :CODEMP ');

      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    End
    Else
    Begin
      qryAux.SQL.Add('SELECT AUTOINCREM FROM CADFIS ');
      qryAux.SQL.Add('WHERE FIS_NUMDOC = :NUMDOC ');
      qryAux.SQL.Add('  AND FIS_ESPDOC = :ESPDOC ');
      qryAux.SQL.Add('  AND FIS_CODEMP = :CODEMP ');
      qryAux.SQL.Add('  AND FIS_FORCLI = :FORCLI ');
      qryAux.SQL.Add('  AND FIS_TIP_FC = :TIP_FC ');
      qryAux.SQL.Add('  AND FIS_SERIE_ = :SERIE_');

      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.ParamByName('FORCLI').AsString := strCodCli;
      qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
      qryAux.ParamByName('SERIE_').AsString := strSerie;
    End;

    qryAux.Open;

    If not qryAux.IsEmpty Then
    Begin
      strAutInc := qryAux.FieldByName('AUTOINCREM').AsString;
    End;

  Finally
    FreeAndNil(qryAux);
  End;

  If fEmptyStr(strAutInc) Then
    Exit;

  If fRetornaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc, strTipInt ) Then
    Exit;

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Add('INSERT INTO PCITEL (');
    qryAux.SQL.Add('  NFE_SEQFIS,');
    qryAux.SQL.Add('  NFE_NUMDOC,');
    qryAux.SQL.Add('  NFE_ESPDOC,');
    qryAux.SQL.Add('  NFE_CODEMP,');
    qryAux.SQL.Add('  NFE_FORCLI,');
    qryAux.SQL.Add('  NFE_SERIE_,');
    qryAux.SQL.Add('  NFE_TIP_FC,');
    qryAux.SQL.Add('  NFE_DTACAD,');
    qryAux.SQL.Add('  NFE_DTAENV,');
    qryAux.SQL.Add('  NFE_TIPINT,');
    qryAux.SQL.Add('  NFE_PROTOC,');
    qryAux.SQL.Add('  NFE_STATUS)');
    qryAux.SQL.Add('VALUES (');
    qryAux.SQL.Add('  :SEQFIS,');
    qryAux.SQL.Add('  :NUMDOC,');
    qryAux.SQL.Add('  :ESPDOC,');
    qryAux.SQL.Add('  :CODEMP,');
    qryAux.SQL.Add('  :FORCLI,');
    qryAux.SQL.Add('  :SERIE_,');
    qryAux.SQL.Add('  :TIP_FC,');
    qryAux.SQL.Add('  :DTACAD,');
    qryAux.SQL.Add('  :DTAENV,');
    qryAux.SQL.Add('  :TIPINT,');
    qryAux.SQL.Add('  :PROTOC,');
    qryAux.SQL.Add('  :STATUS)');

    qryAux.ParamByName('SEQFIS').AsString   := strAutInc;
    qryAux.ParamByName('NUMDOC').AsString   := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString   := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString   := strCodEmp;
    qryAux.ParamByName('FORCLI').AsString   := strCodCli;
    qryAux.ParamByName('TIP_FC').AsString   := strTip_FC;
    qryAux.ParamByName('SERIE_').AsString   := strSerie;
    qryAux.ParamByName('DTACAD').AsDateTime := nOw();
    qryAux.ParamByName('TIPINT').AsString   := strTipInt;
    qryAux.ParamByName('PROTOC').AsString   := strProtoc;
    qryAux.ParamByName('STATUS').AsString   := 'GE';

    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TFonteDadosBD.pSalvarXmlDfeBD(ATipDfe, AChaveAcesso, AProtocolo, AXml: string);
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strComando: string;
  blnInTransaction: Boolean;
begin
  blnInTransaction := False;
  qryAux := fCriaQuery(Nil);

  try
    If Not fTabelaExiste('XMLDFE') Then
      Exit;

    If (Not fCampoExiste('XMLDFE', 'NFE_TIPDFE')) Then
      Exit;

    If (Not fCampoExiste('XMLDFE', 'NFE_ACESSO')) Then
      Exit;

    If (Not fCampoExiste('XMLDFE', 'NFE_ARQXML')) Then
      Exit;

    If fEmptyStr(AProtocolo) Then
    Begin
      AProtocolo := 'ND';
    End;

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM XMLDFE ');
    qryAux.SQL.Add('WHERE NFE_TIPDFE = :TIPDFE ');
    qryAux.SQL.Add('  AND NFE_PROTOC = :PROTOC ');
    qryAux.SQL.Add('  AND NFE_ACESSO = :ACESSO ');
    qryAux.ParamByName('TIPDFE').AsString := ATipDfe;
    qryAux.ParamByName('PROTOC').AsString := AProtocolo;
    qryAux.ParamByName('ACESSO').AsString := AChaveAcesso;
    qryAux.Open;

    if qryAux.FieldByName('QTD').AsInteger = 0 then
    begin
      try
        blnInTransaction := Database.InTransaction;

        if not blnInTransaction then
          Database.StartTransaction;

        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add('INSERT INTO XMLDFE' );
        qryAux.SQL.Add(' SET NFE_TIPDFE = :TIPDFE, ');
        qryAux.SQL.Add('     NFE_PROTOC = :PROTOC, ');
        qryAux.SQL.Add('     NFE_ACESSO = :ACESSO, ');
        qryAux.SQL.Add('     NFE_ARQXML = :ARQXML ');
        qryAux.ParamByName('TIPDFE').AsString := ATipDfe;
        qryAux.ParamByName('PROTOC').AsString := AProtocolo;
        qryAux.ParamByName('ACESSO').AsString := AChaveAcesso;
        qryAux.ParamByName('ARQXML').AsString := AnsiReplaceStr(AnsiReplaceStr(AXML, #13#10, ' '), #10, ' ');
        qryAux.ExecSQL;

        strComando := qryAux.SQL.Text;
        strComando := AnsiReplaceStr(strComando, ':TIPDFE', QuotedStr(qryAux.ParamByName('TIPDFE').AsString));
        strComando := AnsiReplaceStr(strComando, ':PROTOC', QuotedStr(qryAux.ParamByName('PROTOC').AsString));
        strComando := AnsiReplaceStr(strComando, ':ACESSO', QuotedStr(qryAux.ParamByName('ACESSO').AsString));
        strComando := AnsiReplaceStr(strComando, ':ARQXML', QuotedStr(AXml));
        strComando := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strComando, #13#10, ' '), #10, ' '), #13, ' ');

        pGravaLogRep(strComando, 'XMLDFE', 'N');

        if not blnInTransaction then
          Database.Commit;
      except
        on E: Exception do
        begin
          if not blnInTransaction then
            Database.Rollback;

          Exception.Create(E.Message + ' [untUtilBD.pSalvarXmlDfeBD]');
        end;
      end;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TFonteDadosBD.pSetaPathSatCitel(const AstrPathSatCitel: String='');
begin
  strPathSatCitel := AstrPathSatCitel;
end;

procedure TFonteDadosBD.pTrataDiferencaEntreTotGerEModalidades(
  dadosGerais: TDadosGerais; const fltTotalModalidades: Double);
  Var
    fltDiferenca : Double;
    intContador : Integer;
begin
  fltDiferenca := dadosGerais.fltTotGer - fltTotalModalidades;
  If fltDiferenca < 0 Then
  Begin
    fltDiferenca := Abs(fltDiferenca);
    For intContador := Low(dadosGerais.arrFormasPagamento) To High(dadosGerais.arrFormasPagamento) Do
    Begin
      If dadosGerais.arrFormasPagamento[intContador].fltValor > fltDiferenca Then
      Begin
        dadosGerais.arrFormasPagamento[intContador].fltValor := dadosGerais.arrFormasPagamento[intContador].fltValor - fltDiferenca;
        Break;
      End;
    End;
  End
  Else
  Begin
    If fltDiferenca > 0 Then
    Begin
      If Length(dadosGerais.arrFormasPagamento) > 0 Then
      Begin
        If fCampoExiste('MOVMOD', 'MOD_VALPAG') Then
          dadosGerais.arrFormasPagamento[0].fltValPag := dadosGerais.arrFormasPagamento[0].fltValor + fltDiferenca;
        dadosGerais.arrFormasPagamento[0].fltValor := dadosGerais.arrFormasPagamento[0].fltValor + fltDiferenca;
      End
      Else
      Begin
        SetLength(dadosGerais.arrFormasPagamento, 1);
        dadosGerais.arrFormasPagamento[0] := TFormaPagamento.Create;
        dadosGerais.arrFormasPagamento[0].strCodigo := '01';
        dadosGerais.arrFormasPagamento[0].fltValor  := fltDiferenca;
      End;
    End;
  End;
end;

procedure TFonteDadosBD.pSetaIndicadorIntegracaoCitel(const AstrIntegradorCitel: String='S');
begin
  strIntegradorCitel := AstrIntegradorCitel;
end;

function TFonteDadosBD.fExisteCartaoNaMovMod: Boolean;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add(' SELECT MOD_CODMOD ');
    qryAux.SQL.Add('   FROM MOVMOD ');
    qryAux.SQL.Add('  WHERE MOD_CODMOD = :CODMOD  ');
    qryAux.SQL.Add('    AND MOD_NUMDOC = :NUMDOC  ');
    qryAux.SQL.Add('    AND MOD_ESPDOC = :ESPDOC  ');
    qryAux.SQL.Add('    AND MOD_CODEMP = :CODEMP  ');
    qryAux.SQL.Add('    AND MOD_CODCLI = :CODCLI  ');
    qryAux.SQL.Add('    AND MOD_SERIE_ = :SERIE_  ');
    qryAux.ParamByName('CODMOD').AsString := '007';
    qryAux.ParamByName('NUMDOC').AsString := dadosGerais.strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := dadosGerais.strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := dadosGerais.strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := dadosGerais.strCodCli;
    qryAux.ParamByName('SERIE_').AsString := dadosGerais.strSerie;
    qryAux.Open;
    Result := (qryAux.RecordCount > 0);
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fMovModGravaDadosDoCartao: Boolean;
begin
  Result := False;

  If not fCampoExiste('MOVMOD', 'MOD_PIXS_N') Then
    Exit;

  If not fCampoExiste('MOVMOD', 'MOD_CODRED') Then
    Exit;

  Result := True;
end;

procedure TFonteDadosBD.pCarregarFormaPagamentoNotaEspecial(dadosGerais: TDadosGerais);
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  fltTotalModalidades: Double;
  fltDiferenca: Double;
  intContador: Integer;
  strFpgAux: String;
  strCndPag: String;
  strTipCar: String;

begin
  strFpgAux := fConfiguracao('FPGAUX');
  strFpgAux := IIF(fEmptyStr(strFpgAux),'05',strFpgAux);

  strCndPag := IIF(fEmptyStr(dadosGerais.strCondPagamento), '01000', dadosGerais.strCondPagamento);
  strTipCar := IIF(strCndPag = '01000', '04', '03');

  SetLength(dadosGerais.arrFormasPagamento, 0);

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  CASE MOD_CODMOD ');
    qryAux.SQL.Add('    WHEN "001" THEN "01" ');
    qryAux.SQL.Add('    WHEN "002" THEN "02" ');
    qryAux.SQL.Add('    WHEN "006" THEN "02" ');
    qryAux.SQL.Add('    WHEN "012" THEN "16" ');
    if fCampoExiste('MOVMOD', 'MOD_TIPCAR') then
      qryAux.SQL.Add('    WHEN "007" THEN IF(((MOD_TIPCAR IS NULL) OR (MOD_TIPCAR = "")), '+ QuotedStr(strTipCar) +' , IF(MOD_TIPCAR="C","03","04")) ')
    else
      qryAux.SQL.Add('    WHEN "007" THEN ' + QuotedStr(strFpgAux) + ' ') ;

    if (not fEhCupomEletronicoSAT(dadosGerais)) then
      qryAux.SQL.Add('    WHEN "008" THEN "15" ');

    qryAux.SQL.Add('  ELSE '+ QuotedStr(strFpgAux));
    qryAux.SQL.Add('  END AS CODMOD, ');
    qryAux.SQL.Add('  MOD_CODMOD, ');
    qryAux.SQL.Add('  SUM(MOD_VALPAG) AS VALPAG, ');
    qryAux.SQL.Add('  SUM(MOD_VALMOD) AS VALMOD  ');
    qryAux.SQL.Add('FROM MOVMOD ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  MOD_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  MOD_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  MOD_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  MOD_CODCLI = :CODCLI AND ');
    qryAux.SQL.Add('  MOD_SERIE_ = :SERIE_     ');
    qryAux.SQL.Add('GROUP BY MOD_CODMOD ');

    qryAux.ParamByName('NUMDOC').AsString := dadosGerais.strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := dadosGerais.strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := dadosGerais.strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := dadosGerais.strCodCli;
    qryAux.ParamByName('SERIE_').AsString := dadosGerais.strSerie;
    qryAux.Open;

    If Not qryAux.IsEmpty Then
    Begin
      fltTotalModalidades := 0;
      While (Not qryAux.Eof) Do
      Begin
        If qryAux.FieldByName('VALMOD').AsFloat > 0 Then
        Begin
          SetLength(dadosGerais.arrFormasPagamento, Length(dadosGerais.arrFormasPagamento)+1);
          dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1] := TFormaPagamento.Create;
          dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCodigo    := qryAux.FieldByName('CODMOD').AsString;
          dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strModCodMod := qryAux.FieldByName('MOD_CODMOD').AsString;
          dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].fltValor     := qryAux.FieldByName('VALMOD').AsFloat;
          dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCndPag    := strCndPag;

          If fExisteRecebimentoEmPix(dadosGerais.strEndToEndIdPixRecebimento,
                                     dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strModCodMod,
                                     dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].fltValor,
                                     dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strEndToEndIdPix,
                                     dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].dtaDtaPag,
                                     dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCnpjFinanceira,
                                     dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCnpjBeneficiario) Then
          Begin
            dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCodigo := FORMA_PAGTO_PIX;

            If fEmptyStr(dadosGerais.strEndToEndIdPixRecebimento) Then
            Begin
              dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCodigo    := '01';
              dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strModCodMod := '001';
            End;
          End;

          dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].fltValPag := qryAux.FieldByName('VALPAG').AsFloat;

          if (qryAux.FieldByName('MOD_CODMOD').AsString = '007') Then
          Begin
            dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCodRed := fConfiguracao('COCPRD');
          End
          else
            dadosGerais.arrFormasPagamento[Length(dadosGerais.arrFormasPagamento)-1].strCodRed := '';

          fltTotalModalidades := fltTotalModalidades + qryAux.FieldByName('VALMOD').AsFloat;
        End;
        qryAux.Next;
      End;

      fltDiferenca := dadosGerais.fltTotGer - fltTotalModalidades;
      If fltDiferenca < 0 Then
      Begin
        fltDiferenca := Abs(fltDiferenca);
        For intContador := Low(dadosGerais.arrFormasPagamento) To High(dadosGerais.arrFormasPagamento) Do
        Begin
          If dadosGerais.arrFormasPagamento[intContador].fltValor > fltDiferenca Then
          Begin
            dadosGerais.arrFormasPagamento[intContador].fltValor := dadosGerais.arrFormasPagamento[intContador].fltValor - fltDiferenca;
            Break;
          End;
        End;
      End
      Else
      Begin
        If fltDiferenca > 0 Then
        Begin
          If Length(dadosGerais.arrFormasPagamento) > 0 Then
          Begin
            dadosGerais.arrFormasPagamento[0].fltValPag := dadosGerais.arrFormasPagamento[0].fltValor + fltDiferenca;
            dadosGerais.arrFormasPagamento[0].fltValor := dadosGerais.arrFormasPagamento[0].fltValor + fltDiferenca;
          End
          Else
          Begin
            SetLength(dadosGerais.arrFormasPagamento, 1);
            dadosGerais.arrFormasPagamento[0] := TFormaPagamento.Create;
            dadosGerais.arrFormasPagamento[0].strCodigo := '01';
            dadosGerais.arrFormasPagamento[0].fltValor  := fltDiferenca;
          End;
        End;
      End;
    End
    Else
    Begin
      SetLength(dadosGerais.arrFormasPagamento, 1);
      dadosGerais.arrFormasPagamento[0] := TFormaPagamento.Create;
      dadosGerais.arrFormasPagamento[0].strCodigo := IIF(dadosGerais.strFormaPagamento = '007', strTipCar, '01');
      dadosGerais.arrFormasPagamento[0].fltValor  := dadosGerais.fltTotGer;
    End;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fRetornaEmails: String;
var
  LEmail1: String;
  LEmail2: String;
  LEmail3: String;
begin
  If fCampoExiste('CADCLI', 'CLI_EMAIL_') Then
  Begin
    LEmail1  := fTiraPipeEnter(fGetCampoValor('CLI_EMAIL_', 'CLI_CODCLI', qryDados.FieldByName('FIS_FORCLI').AsString, 'CADCLI'));
  End;

  If fCampoExiste('CADCLI', 'CLI_EMAIL2') Then
  Begin
    LEmail2 := fTiraPipeEnter(fGetCampoValor('CLI_EMAIL2', 'CLI_CODCLI', qryDados.FieldByName('FIS_FORCLI').AsString, 'CADCLI'));
  End;

  If fCampoExiste('CADCLI', 'CLI_EMAIL3') Then
  Begin
    LEmail3 := fTiraPipeEnter(fGetCampoValor('CLI_EMAIL3', 'CLI_CODCLI', qryDados.FieldByName('FIS_FORCLI').AsString, 'CADCLI'));
  End;

  LEmail1 := AnsiReplaceStr(LEmail1, ';', '');
  LEmail2 := AnsiReplaceStr(LEmail2, ';', '');
  LEmail3 := AnsiReplaceStr(LEmail3, ';', '');

  Result := LEmail1;

  If not fEmptyStr(LEmail2) Then
    Result := Result  + IIF(fEmptyStr(Result), '', ';') +  LEmail2;

  If not fEmptyStr(LEmail3) Then
    Result := Result  + IIF(fEmptyStr(Result), '', ';') +  LEmail3;
end;

function TFonteDadosBD.fBuscaBeneficioFiscalDoCliente(strCodCli, strCodCst, strCdbFis: String): string;
var
  dataSet: TDataSet;
begin
  Result := '';

  If fEmptyStr(strCodCli) Then
    Exit;

  If fEmptyStr(strCodCst) Then
    Exit;

  if not fTabelaExiste('CLIBEN') then
    exit;

  dataSet := fExecutaQuery('SELECT BEN_CODBEN FROM CLIBEN WHERE BEN_CODCLI = :CODCLI AND BEN_CODCST = :CODCST', ['CODCLI', 'CODCST'], [strCodCli, strCodCst]);

  Result := dataSet.FieldByName('BEN_CODBEN').AsString;
  FreeAndNil(dataSet);

  If fEmptyStr(Result) Then
    Result := strCdbFis;
end;

function TFonteDadosBD.fRetornaNotasDeCupomComIPI(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := '';

  If not fCampoExiste('MOVTRI', 'DET_DOCIPI') Then
    Exit;

  qryAux := fCriaQuery(Nil);
  Try
    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT DISTINCT ');
      qryAux.SQL.Add('  (SELECT GROUP_CONCAT(DISTINCT CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP) SEPARATOR " " ) FROM NOTDET ');
      qryAux.SQL.Add('   INNER JOIN NOTTRI ON NOTTRI.DET_SEQGER = NOTDET.AUTOINCREM ');
      qryAux.SQL.Add('   WHERE NOTTRI.DET_DOCIPI = MOVDET.DET_DOCDEV ');
      qryAux.SQL.Add('     AND NOTTRI.DET_ESPIPI = MOVDET.DET_ESPDEV ');
      qryAux.SQL.Add('     AND NOTTRI.DET_EMPIPI = MOVDET.DET_EMPDEV) AS DOCUMENTOS ');
      qryAux.SQL.Add('FROM MOVDET ');
      qryAux.SQL.Add('WHERE DET_NUMDOC = :NUMDOC ');
      qryAux.SQL.Add('  AND DET_ESPDOC = :ESPDOC ');
      qryAux.SQL.Add('  AND DET_CODEMP = :CODEMP ');
      qryAux.SQL.Add('  AND DET_CODCLI = :CODCLI ');

      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.ParamByName('CODCLI').AsString := strCodCli;

      qryAux.Open;

      If qryAux.RecordCount > 0 Then
      Begin
        Result := qryAux.FieldByName('DOCUMENTOS').AsString;
      End;

      qryAux.Close;
    Except
      On E: Exception Do
        Exception.Create(E.Message + ' [TFonteDadosBD.fRetornaNotasDeCupomComIPI]');
    End;

  Finally
    FreeAndNil(qryAux);
  End;
End;

function TFonteDadosBD.fRetornaDeclaracaoDeImportacaoDaUltimaNotaDeCompra(strCodIte: String): String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strEmpresas: String;
begin

  If not (fConfiguracao('INF_DI') = 'S') Then
    Exit;

  if not fTabelaExiste('DOCIMP') then
    exit;

  If not fCampoExiste('DOCIMP', 'IMP_NUM_DI') Then
    Exit;

  If not fCampoExiste('ITEGER', 'ITE_NOTULT') Then
    Exit;

  strEmpresas := fConfiguracao('INFDIE');

  If fEmptyStr(strEmpresas) Then
    Exit;

  qryAux := fCriaQuery(Nil);
  Try
    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT IMP_NUM_DI FROM ITEGER ');
      qryAux.SQL.Add('INNER JOIN MOVDET ON DET_CODEMP = ITE_CODEMP AND ');
      qryAux.SQL.Add('                     DET_CODITE = ITE_CODITE AND ');
      qryAux.SQL.Add('                     DET_NUMDOC = LEFT(ITE_NOTULT,12) AND ');
      qryAux.SQL.Add('                     DET_CODFOR = RIGHT(ITE_NOTULT,8) ');
      qryAux.SQL.Add('INNER JOIN DOCIMP ON IMP_SQMVDT = MOVDET.AUTOINCREM ');
      qryAux.SQL.Add('WHERE LOCATE(ITE_CODEMP, :CODEMP) > 0 ');
      qryAux.SQL.Add('  AND ITE_CODITE = :CODITE ');
      qryAux.SQL.Add('  AND IFNULL(ITE_NOTULT,"") <> "" ');
      qryAux.ParamByName('CODITE').AsString := strCodIte;
      qryAux.ParamByName('CODEMP').AsString := fTransform(strEmpresas, 3);
      qryAux.Open;

      Result := qryAux.FieldByName('IMP_NUM_DI').AsString;
    Except
      On E: Exception Do
        Exception.Create(E.Message + ' [TFonteDadosBD.fRetornaDeclaracaoDeImportacaoDaUltimaNotaDeCompra]');
    End;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fZeraIBPT: Boolean;
begin
  Result := False;

  If not fConfiguracaoExiste('CLAVEN') Then
    Exit;

  If not fConfiguracaoExiste('ZEIBPT') Then
    Exit;

  If not (fConfiguracao('ZEIBPT') = 'S') Then
    Exit;

  If not (Pos(dadosGerais.strClaFis, fTransform(fConfiguracao('CLAVEN'), 4)) > 0) Then
  Begin
    Result := True;
    Exit;
  End;

end;

{$IF Defined(UNIDAC)}
function TFonteDadosBD.fRetDataBase: TUniConnection;
begin
  Result := Self.DataBase;
end;
{$IFEND}

procedure TFonteDadosBD.pCarregaNcmObrigatorioAnvisa;
 Var
   qryGen: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin
  If fCampoExiste('CADNCM', 'NCM_ANVOBR') Then
  Begin
    qryGen := fCriaQuery(Nil);
    Try
      Try
        qryGen.Close;
        qryGen.SQL.Text := 'SELECT NCM_CODNCM FROM CADNCM WHERE NCM_ANVOBR = "S";';
        qryGen.Open;

        SetLength(arrNcmObrAnvisa, Length(arrNcmObrAnvisa) + 1);
        arrNcmObrAnvisa[Length(arrNcmObrAnvisa)-1] := '--------_';

        qryGen.First;
        While Not qryGen.Eof Do
        Begin
          SetLength(arrNcmObrAnvisa, Length(arrNcmObrAnvisa) + 1);
          arrNcmObrAnvisa[Length(arrNcmObrAnvisa)-1] := qryGen.FieldByName('NCM_CODNCM').AsString;

          qryGen.Next;
        End;

        qryGen.Close;
      Except
        On E: Exception Do
        Begin
          pLogImp(E.Message + ' [TFonteDadosBD.pCarregaNcmObrigatorioAnvisa])');
          Exception.Create(E.Message + ' [TFonteDadosBD.pCarregaNcmObrigatorioAnvisa]');
        End;
      End;
    Finally
      FreeAndNil(qryGen);
    End
  End;
end;

procedure TFonteDadosBD.pGravarLogFit(strNumDoc, strEspDoc, strCodEmp, strSerie_, strForCli, strTip_FC, strTipArq, strArquiv: String);
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strMsgRetorno : String;
begin
  If not (fCfgSisFonte(Self, 'LOGFIT') = 'S') Then
    Exit;

  if not fTabelaExiste('LOGFIT') then
    Exit;

  If (strTipArq = 'RETORNO') Then
  Begin
    strMsgRetorno := Copy(strArquiv, 1, 30);
    If (Pos('HASH DO ARQUIVO TXT', UpperCase(strMsgRetorno)) > 0) Then
      Exit;
  End;

  pLogImp('pGravarLogFit >');
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('REPLACE INTO LOGFIT (');
    qryAux.SQL.Add('  NFE_NUMDOC, ');
    qryAux.SQL.Add('  NFE_ESPDOC, ');
    qryAux.SQL.Add('  NFE_CODEMP, ');
    qryAux.SQL.Add('  NFE_FORCLI, ');
    qryAux.SQL.Add('  NFE_SERIE_, ');
    qryAux.SQL.Add('  NFE_TIP_FC, ');
    qryAux.SQL.Add('  NFE_TIPARQ, ');
    qryAux.SQL.Add('  NFE_ARQUIV, ');
    qryAux.SQL.Add('  NFE_DTACAD) ');
    qryAux.SQL.Add('VALUES ( ');
    qryAux.SQL.Add('  :NUMDOC, ');
    qryAux.SQL.Add('  :ESPDOC, ');
    qryAux.SQL.Add('  :CODEMP, ');
    qryAux.SQL.Add('  :FORCLI, ');
    qryAux.SQL.Add('  :SERIE_, ');
    qryAux.SQL.Add('  :TIP_FC, ');
    qryAux.SQL.Add('  :TIPARQ, ');
    qryAux.SQL.Add('  :ARQUIV, ');
    qryAux.SQL.Add('  '+fCurrentDateTime+' ) ');
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('FORCLI').AsString := strForCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie_;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.ParamByName('TIPARQ').AsString := strTipArq;
    qryAux.ParamByName('ARQUIV').AsString := strArquiv;
    qryAux.ExecSQL;

  Finally
    FreeAndNil(qryAux);
  End;
  pLogImp('pGravarLogFit <');
end;

function TFonteDadosBD.fDataEmissaoDocumentoFiscal(const strNumDoc, strEspDoc, strCodEmp, strForCli, strSerie, strTipFc : String) : TDate;
  Var
    dtaDtaEnt : TDate;
begin
  dtaDtaEnt := fCampoTabela('FIS_DTAENT', 'CADFIS',
    ['FIS_NUMDOC', 'FIS_ESPDOC', 'FIS_CODEMP', 'FIS_FORCLI', 'FIS_SERIE_', 'FIS_TIP_FC', 'FIS_ORIDOC'],
    [strNumDoc, strEspDoc, strCodEmp, strForCli, strSerie, strTipFc, 'V']);
  If fDataValida(dtaDtaEnt) Then
    Result := dtaDtaEnt
  Else
    Result := 0;
end;

procedure TFonteDadosBD.pReformaTributariaConfiguracoes(const strClaFis: String;
                                                        var strCodCst, strClaTri, strTriReg: String;
                                                        var fltCBSALQ, fltCBSALD, fltCBSRLR,
                                                            fltIBSUFA, fltIBSUFD, fltIBSUFR,
                                                            fltIBSMNA, fltIBSMND, fltIBSMNR: Double);
Var
  qryTemp: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

begin

  strCodCst := '000';
  strClaTri := '000001';

  fltCBSALQ := 0;
  fltCBSALD := 0;
  fltCBSRLR := 0;

  fltIBSUFA := 0;
  fltIBSUFD := 0;
  fltIBSUFR := 0;

  fltIBSMNA := 0;
  fltIBSMND := 0;
  fltIBSMNR := 0;

  If not fTabelaExiste('CFGREF') Then
    Exit;

  qryTemp := fCriaQuery(Nil);

  Try
    qryTemp.Close;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT * FROM CFGREF ');
    qryTemp.SQL.Add('WHERE LOCATE(:CODCFO, REF_CODCFO) > 0 ');
    qryTemp.SQL.Add('  AND :DTANOW BETWEEN REF_VIGINI AND REF_VIGFIN ');
    qryTemp.ParamByName('DTANOW').AsDateTime := DateOf(nOw());
    qryTemp.ParamByName('CODCFO').AsString := strClaFis;
    qryTemp.Open;

    If not (qryTemp.RecordCount > 0) Then
      Exit;

    strCodCst := qryTemp.FieldByName('REF_CODCST').AsString;
    strClaTri := qryTemp.FieldByName('REF_CLATRI').AsString;

    fltCBSALQ := qryTemp.FieldByName('REF_CBSALQ').AsFloat;
    fltCBSALD := qryTemp.FieldByName('REF_CBSDIF').AsFloat;
    fltCBSRLR := qryTemp.FieldByName('REF_CBSRED').AsFloat;

    fltIBSUFA := qryTemp.FieldByName('REF_IBSUFA').AsFloat;
    fltIBSUFD := qryTemp.FieldByName('REF_IBSUFD').AsFloat;
    fltIBSUFR := qryTemp.FieldByName('REF_IBSUFR').AsFloat;

    fltIBSMNA := qryTemp.FieldByName('REF_IBSMNA').AsFloat;
    fltIBSMND := qryTemp.FieldByName('REF_IBSMND').AsFloat;
    fltIBSMNR := qryTemp.FieldByName('REF_IBSMNR').AsFloat;

    strTriReg := qryTemp.FieldByName('REF_TRIREG').AsString;

  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TFonteDadosBD.pReformaTributariaIBS_CBS(var Item: TDadosItem; blnPadrao: Boolean; strCodCst, strClaTri: String; fltBasCal, fltValOpe, fltValIBS: Double);
begin
  Item.ReformaTributaria.IBS_CBS := TIBS_CBS.Create;
  Item.ReformaTributaria.IBS_CBS.strCodigoCST := IIF(blnPadrao, strCodCst, qryDados.FieldByName('REF_CODCST').AsString);
  Item.ReformaTributaria.IBS_CBS.strClassTrib := IIF(blnPadrao, strClaTri, qryDados.FieldByName('REF_CLATRI').AsString);
  Item.ReformaTributaria.IBS_CBS.fltBase      := IIF(blnPadrao, fltBasCal, qryDados.FieldByName('REF_BASCAL').AsFloat);
  Item.ReformaTributaria.IBS_CBS.fltValor     := IIF(blnPadrao, fltValOpe, qryDados.FieldByName('REF_VALOPE').AsFloat);
  Item.ReformaTributaria.IBS_CBS.fltValIBS    := IIF(blnPadrao, fltValIBS, qryDados.FieldByName('REF_VALIBS').AsFloat);
end;

procedure TFonteDadosBD.pReformaTributariaSEL(var Item: TDadosItem; blnPadrao: Boolean; strSelCst, strSelCla: String; fltSelBas, fltSelAlq, fltSelVal: Double);
begin
  Item.ReformaTributaria.SEL := TIS.Create;
  Item.ReformaTributaria.SEL.strCodigoCST := IIF(blnPadrao, strSelCst, qryDados.FieldByName('REF_SELCST').AsString);
  Item.ReformaTributaria.SEL.strClassTrib := IIF(blnPadrao, strSelCla, qryDados.FieldByName('REF_SELCLA').AsString);
  Item.ReformaTributaria.SEL.fltBase      := IIF(blnPadrao, fltSelBas, qryDados.FieldByName('REF_SELBAS').AsFloat);
  Item.ReformaTributaria.SEL.fltAliquota  := IIF(blnPadrao, fltSelAlq, qryDados.FieldByName('REF_SELALQ').AsFloat);
  Item.ReformaTributaria.SEL.fltValor     := IIF(blnPadrao, fltSelVal, qryDados.FieldByName('REF_SELVAL').AsFloat);
end;

procedure TFonteDadosBD.pReformaTributariaCBS(var Item: TDadosItem; blnPadrao: Boolean; fltBasCal, fltCBSALQ, fltCBSALD, fltCBSRLR: Double);
var
  fltCBSVLD: Double;
  fltCBSVLT: Double;
  fltCBSALE: Double;
  fltCBSVAL: Double;
begin
  fltCBSVLD := 0;
  fltCBSVLT := 0;
  fltCBSALE := 0;

  fltCBSVAL := fFormataFloat((fltBasCal * fltCBSALQ) / 100, 2);

  If fltCBSALD > 0 Then
  Begin
    fltCBSVAL := fFormataFloat((fltBasCal * fltCBSALQ) / 100, 2);
    fltCBSVLD := fFormataFloat((fltCBSALD * fltBASCAL) / 100, 2);
    fltCBSVAL := fFormataFloat(fltCBSVAL - fltCBSVLD, 2);
  End;

  If fltCBSRLR > 0 Then
  Begin
    fltCBSALE := fFormataFloat( fltCBSALQ * ((100 - fltCBSRLR) / 100) , 4);
    fltCBSVAL := fFormataFloat((fltCBSALE * fltBASCAL) / 100, 2);
  End;

  fltCBSVAL := IIF(fltCBSVAL > 0, fltCBSVAL, 0);

  Item.ReformaTributaria.CBS := TCBS.Create;
  Item.ReformaTributaria.CBS.fltAliquota := IIF(blnPadrao, fltCBSALQ, qryDados.FieldByName('REF_CBSALQ').AsFloat);
  Item.ReformaTributaria.CBS.fltValor    := IIF(blnPadrao, fltCBSVAL, qryDados.FieldByName('REF_CBSVAL').AsFloat);
  Item.ReformaTributaria.CBS.fltPerDif   := IIF(blnPadrao, fltCBSALD, qryDados.FieldByName('REF_CBSALD').AsFloat);
  Item.ReformaTributaria.CBS.fltValDif   := IIF(blnPadrao, fltCBSVLD, qryDados.FieldByName('REF_CBSVLD').AsFloat);
  Item.ReformaTributaria.CBS.fltTriDev   := IIF(blnPadrao, fltCBSVLT, qryDados.FieldByName('REF_CBSVLT').AsFloat);
  Item.ReformaTributaria.CBS.fltPerRed   := IIF(blnPadrao, fltCBSRLR, qryDados.FieldByName('REF_CBSALR').AsFloat);
  Item.ReformaTributaria.CBS.fltAlqEfe   := IIF(blnPadrao, fltCBSALE, qryDados.FieldByName('REF_CBSALE').AsFloat);
end;

procedure TFonteDadosBD.pReformaTributariaIBS_UF(var Item: TDadosItem; blnPadrao: Boolean; fltBasCal, fltIBSUFA, fltIBSUFD, fltIBSUFR: Double);
var
  fltIBSUFV: Double;
  fltIBSUVD: Double;
  fltIBSUFT: Double;
  fltIBSUFE: Double;
begin
  fltIBSUVD := 0;
  fltIBSUFT := 0;
  fltIBSUFE := 0;

  fltIBSUFV := fFormataFloat((fltBasCal * fltIBSUFA) / 100, 2);

  If fltIBSUFD > 0 Then
  Begin
    fltIBSUFV := fFormataFloat((fltBasCal * fltIBSUFA) / 100, 2);
    fltIBSUVD := fFormataFloat((fltIBSUFD * fltBASCAL) / 100, 2);
    fltIBSUFV := fFormataFloat(fltIBSUFV - fltIBSUVD, 2);
  End;

  If fltIBSUFR > 0 Then
  Begin
    fltIBSUFE := fFormataFloat( fltIBSUFA * ((100 - fltIBSUFR) / 100) , 4);
    fltIBSUFV := fFormataFloat((fltIBSUFE * fltBASCAL) / 100, 2);
  End;

  fltIBSUFV := IIF(fltIBSUFV > 0, fltIBSUFV, 0);

  Item.ReformaTributaria.IBS_UF := TIBS_UF.Create;
  Item.ReformaTributaria.IBS_UF.fltAliquota := IIF(blnPadrao, fltIBSUFA, qryDados.FieldByName('REF_IBSUFA').AsFloat);
  Item.ReformaTributaria.IBS_UF.fltValor    := IIF(blnPadrao, fltIBSUFV, qryDados.FieldByName('REF_IBSUFV').AsFloat);
  Item.ReformaTributaria.IBS_UF.fltPerDif   := IIF(blnPadrao, fltIBSUFD, qryDados.FieldByName('REF_IBSUFD').AsFloat);
  Item.ReformaTributaria.IBS_UF.fltValDif   := IIF(blnPadrao, fltIBSUVD, qryDados.FieldByName('REF_IBSUVD').AsFloat);
  Item.ReformaTributaria.IBS_UF.fltTriDev   := IIF(blnPadrao, fltIBSUFT, qryDados.FieldByName('REF_IBSUFT').AsFloat);
  Item.ReformaTributaria.IBS_UF.fltPerRed   := IIF(blnPadrao, fltIBSUFR, qryDados.FieldByName('REF_IBSUFR').AsFloat);
  Item.ReformaTributaria.IBS_UF.fltAlqEfe   := IIF(blnPadrao, fltIBSUFE, qryDados.FieldByName('REF_IBSUFE').AsFloat);
end;

procedure TFonteDadosBD.pReformaTributariaIBS_MUN(var Item: TDadosItem; blnPadrao: Boolean; fltBasCal, fltIBSMNA, fltIBSMND, fltIBSMNR: Double);
var
  fltIBSMNV: Double;
  fltIBSMVD: Double;
  fltIBSMNT: Double;
  fltIBSMAE: Double;
begin
  fltIBSMVD := 0;
  fltIBSMNT := 0;
  fltIBSMAE := 0;

  fltIBSMNV := fFormataFloat((fltBasCal * fltIBSMNA) / 100, 2);

  If fltIBSMND > 0 Then
  Begin
    fltIBSMNV := fFormataFloat((fltBasCal * fltIBSMNA) / 100, 2);
    fltIBSMVD := fFormataFloat((fltIBSMND * fltBASCAL) / 100, 2);
    fltIBSMNV := fFormataFloat(fltIBSMNV - fltIBSMVD, 2);
  End;

  If fltIBSMNR > 0 Then
  Begin
    fltIBSMAE := fFormataFloat( fltIBSMNA * ((100 - fltIBSMNR) / 100) , 4);
    fltIBSMNV := fFormataFloat((fltIBSMAE * fltBASCAL) / 100, 2);
  End;

  fltIBSMNV := IIF(fltIBSMNV > 0, fltIBSMNV, 0);

  Item.ReformaTributaria.IBS_MUN := TIBS_MUN.Create;
  Item.ReformaTributaria.IBS_MUN.fltAliquota := IIF(blnPadrao, fltIBSMNA, qryDados.FieldByName('REF_IBSMNA').AsFloat);
  Item.ReformaTributaria.IBS_MUN.fltValor    := IIF(blnPadrao, fltIBSMNV, qryDados.FieldByName('REF_IBSMNV').AsFloat);
  Item.ReformaTributaria.IBS_MUN.fltPerDif   := IIF(blnPadrao, fltIBSMND, qryDados.FieldByName('REF_IBSMND').AsFloat);
  Item.ReformaTributaria.IBS_MUN.fltValDif   := IIF(blnPadrao, fltIBSMVD, qryDados.FieldByName('REF_IBSMVD').AsFloat);
  Item.ReformaTributaria.IBS_MUN.fltTriDev   := IIF(blnPadrao, fltIBSMNT, qryDados.FieldByName('REF_IBSMNT').AsFloat);
  Item.ReformaTributaria.IBS_MUN.fltPerRed   := IIF(blnPadrao, fltIBSMNR, qryDados.FieldByName('REF_IBSMNR').AsFloat);
  Item.ReformaTributaria.IBS_MUN.fltAlqEfe   := IIF(blnPadrao, fltIBSMAE, qryDados.FieldByName('REF_IBSMNE').AsFloat);
end;

procedure TFonteDadosBD.pReformaTributariaTRIB_REGULAR(var Item: TDadosItem; blnPadrao: Boolean; strTriReg, strCodCst, strClaTri: String; fltVlrBas: Double);
var
  fltBasCal: Double;
  fltCBSALQ: Double;
  fltIBSUFA: Double;
  fltIBSMNA: Double;

  fltCBSVAL: Double;
  fltIBSUFV: Double;
  fltIBSMNV: Double;

begin
  If not (strTriReg = 'S') Then
    Exit;

  fltBasCal := IIF(blnPadrao, fltVlrBas, qryDados.FieldByName('REF_BASCAL').AsFloat);

  fltCBSALQ := IIF(blnPadrao, 0.9, qryDados.FieldByName('REF_CBSALE').AsFloat);
  fltIBSUFA := IIF(blnPadrao, 0.1, qryDados.FieldByName('REF_IBSUFE').AsFloat);
  fltIBSMNA := IIF(blnPadrao, 0.0, qryDados.FieldByName('REF_IBSMNE').AsFloat);

  fltCBSALQ := IIF(fltCBSALQ > 0, fltCBSALQ, qryDados.FieldByName('REF_CBSALQ').AsFloat);
  fltIBSUFA := IIF(fltIBSUFA > 0, fltIBSUFA, qryDados.FieldByName('REF_IBSUFA').AsFloat);
  fltIBSMNA := IIF(fltIBSMNA > 0, fltIBSMNA, qryDados.FieldByName('REF_IBSMNA').AsFloat);

  fltCBSALQ := IIF(fltCBSALQ > 0, fltCBSALQ, 0.9);
  fltIBSUFA := IIF(fltIBSUFA > 0, fltIBSUFA, 0.1);
  fltIBSMNA := IIF(fltIBSMNA > 0, fltIBSMNA, 0.0);

  fltCBSVAL := fFormataFloat((fltBasCal * fltCBSALQ) / 100, 2);
  fltIBSUFV := fFormataFloat((fltBasCal * fltIBSUFA) / 100, 2);
  fltIBSMNV := fFormataFloat((fltBasCal * fltIBSMNA) / 100, 2);

  Item.ReformaTributaria.TRIB_REGULAR := TIBSCBS_TRIB_REGULAR.Create;
  Item.ReformaTributaria.TRIB_REGULAR.strCodigoCST   := strCodCst;
  Item.ReformaTributaria.TRIB_REGULAR.strClassTrib   := strClaTri;
  Item.ReformaTributaria.TRIB_REGULAR.fltCBS_Alq     := fltCBSALQ;
  Item.ReformaTributaria.TRIB_REGULAR.fltCBS_Val     := fltCBSVAL;
  Item.ReformaTributaria.TRIB_REGULAR.fltIBS_UF_Alq  := fltIBSUFA;
  Item.ReformaTributaria.TRIB_REGULAR.fltIBS_UF_Val  := fltIBSUFV;
  Item.ReformaTributaria.TRIB_REGULAR.fltIBS_MUN_Alq := fltIBSMNA;
  Item.ReformaTributaria.TRIB_REGULAR.fltIBS_NUM_Val := fltIBSMNV;
end;

procedure TFonteDadosBD.pReformaTributariaItens(var Item: TDadosItem);
var
  blnPadrao: Boolean;
  strTriReg: String;
  strCodCst: String;
  strClaTri: String;
  fltBasCal: Double;
  fltValOpe: Double;
  fltValIBS: Double;

  fltCBSALQ: Double; // CBS Alíquota
  fltCBSALD: Double; // CBS Alíquota de Diferimento
  fltCBSRLR: Double; // CBS Alíquota de Redução

  fltIBSUFA: Double; // IBS UF Alíquota
  fltIBSUFD: Double; // IBS UF Alíquota de Diferimento
  fltIBSUFR: Double; // IBS UF Alíquota de Redução


  fltIBSMNA: Double; // IBS MUN Alíquota
  fltIBSMND: Double; // IBS MUN Alíquota de Diferimento
  fltIBSMNR: Double; // IBS MUN Alíquota de Redução

  fltIpiDevol: Double;

  function fExisteRegistro: Boolean;
  begin
    Result := False ;

    If fEmptyStr(qryDados.FieldByName('REF_CODCST').AsString) Then
      Exit;

    Result := True ;
  end;

begin

  blnPadrao := True;

  If fExisteRegistro Then
    blnPadrao := False
  Else
    pReformaTributariaConfiguracoes(item.strClaFis,
                                    strCodCst, strClaTri, strTriReg,
                                    fltCBSALQ, fltCBSALD, fltCBSRLR, fltIBSUFA, fltIBSUFD, fltIBSUFR, fltIBSMNA, fltIBSMND, fltIBSMNR);

  strCodCst := IIF(blnPadrao, strCodCst, qryDados.FieldByName('REF_CODCST').AsString);
  strTriReg := IIF(blnPadrao, strTriReg, qryDados.FieldByName('REF_TRIREG').AsString);
  strClaTri := IIF(blnPadrao, strClaTri, qryDados.FieldByName('REF_CLATRI').AsString);
  fltIpiDevol := 0;
  If (fFormataFloat(item.fltPerDevolvido, 2) > 0) Then
    fltIpiDevol := item.fltValIpi + item.fltValIpiDadosAdicionais;
  If fFormataFloat(item.fltVlrCon, 2) = 0 Then
    fltValOpe := (item.fltTotIte + item.fltTotFre + item.fltDesAce + fltIpiDevol) - item.fltDesEsp
  Else
    fltValOpe := item.fltVlrCon;
  fltBasCal := IIF(strCodCst = '410', 0, fltValOpe);

  Item.ReformaTributaria := TDadosReformaTributaria.Create;

  pReformaTributariaSEL(Item, blnPadrao, '', '', 0, 0, 0);
  pReformaTributariaCBS(Item, blnPadrao, fltBasCal, fltCBSALQ, fltCBSALD, fltCBSRLR);
  pReformaTributariaIBS_UF(Item, blnPadrao, fltBasCal, fltIBSUFA, fltIBSUFD, fltIBSUFR);
  pReformaTributariaIBS_MUN(Item, blnPadrao, fltBasCal, fltIBSMNA, fltIBSMND, fltIBSMNR);
  pReformaTributariaTRIB_REGULAR(Item, blnPadrao, strTriReg, '000', '000001', fltBasCal);

  fltValIBS := Item.ReformaTributaria.IBS_UF.fltValor + Item.ReformaTributaria.IBS_MUN.fltValor;

  pReformaTributariaIBS_CBS(Item, blnPadrao, strCodCst, strClaTri, fltBasCal, fltValOpe, fltValIBS);
end;

procedure TFonteDadosBD.pReformaTributariaTotal;
Var
  item: TDadosItem;
  intContador: Integer;
  fltValorTotalBase,
  fltValorTotalIS,
  fltValorTotalCBS,
  fltValorTotalIBS_UF,
  fltValorTotalIBS_MUN,
  fltValorTotalDifCBS,
  fltValorTotalDifIBS_UF,
  fltValorTotalDifIBS_MUN,
  fltValorTotalGrupoIBS,
  fltValorTotalNFe: Double;
begin

  If dadosGerais.blnNfComp Then
    Exit;

  fltValorTotalNFe        := 0;
  fltValorTotalBase       := 0;
  fltValorTotalIS         := 0;
  fltValorTotalCBS        := 0;
  fltValorTotalIBS_UF     := 0;
  fltValorTotalIBS_MUN    := 0;
  fltValorTotalDifCBS     := 0;
  fltValorTotalDifIBS_UF  := 0;
  fltValorTotalDifIBS_MUN := 0;
  fltValorTotalGrupoIBS   := 0;

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    If not Assigned(Item.ReformaTributaria) Then
      Continue;

    If not Assigned(Item.ReformaTributaria.IBS_CBS) Then
      Continue;

    If not Assigned(Item.ReformaTributaria.SEL) Then
      Continue;

    If not Assigned(Item.ReformaTributaria.CBS) Then
      Continue;

    If not Assigned(Item.ReformaTributaria.IBS_UF) Then
      Continue;

    If not Assigned(Item.ReformaTributaria.IBS_MUN) Then
      Continue;

    Item.ReformaTributaria.IBS_CBS.fltTotal := Item.ReformaTributaria.IBS_CBS.fltValor{ +
                                               Item.ReformaTributaria.SEL.fltValor +
                                               Item.ReformaTributaria.CBS.fltValor +
                                               Item.ReformaTributaria.IBS_UF.fltValor +
                                               Item.ReformaTributaria.IBS_MUN.fltValor};

    fltValorTotalNFe        := fltValorTotalNFe        + Item.ReformaTributaria.IBS_CBS.fltTotal;
    fltValorTotalBase       := fltValorTotalBase       + Item.ReformaTributaria.IBS_CBS.fltBase;
    fltValorTotalIS         := fltValorTotalIS         + Item.ReformaTributaria.SEL.fltValor;
    fltValorTotalCBS        := fltValorTotalCBS        + Item.ReformaTributaria.CBS.fltValor;
    fltValorTotalIBS_UF     := fltValorTotalIBS_UF     + Item.ReformaTributaria.IBS_UF.fltValor;
    fltValorTotalIBS_MUN    := fltValorTotalIBS_MUN    + Item.ReformaTributaria.IBS_MUN.fltValor;
    fltValorTotalDifCBS     := fltValorTotalDifCBS     + Item.ReformaTributaria.CBS.fltValDif;
    fltValorTotalDifIBS_UF  := fltValorTotalDifIBS_UF  + Item.ReformaTributaria.IBS_UF.fltValDif;
    fltValorTotalDifIBS_MUN := fltValorTotalDifIBS_MUN + Item.ReformaTributaria.IBS_MUN.fltValDif;
    fltValorTotalGrupoIBS   := fltValorTotalGrupoIBS   + Item.ReformaTributaria.IBS_UF.fltValor +
                                                         Item.ReformaTributaria.IBS_MUN.fltValor;

  End;

  If Not Assigned(dadosGerais.ReformaTributariaTotal) Then
    dadosGerais.ReformaTributariaTotal := TIBS_CBS_SEL_TOTAL.Create;

  dadosGerais.ReformaTributariaTotal.fltValorTotalBase        := fltValorTotalBase;
  dadosGerais.ReformaTributariaTotal.fltValorTotalIS          := fltValorTotalIS;
  dadosGerais.ReformaTributariaTotal.fltValorTotalCBS         := fltValorTotalCBS;
  dadosGerais.ReformaTributariaTotal.fltValorTotalIBS_UF      := fltValorTotalIBS_UF;
  dadosGerais.ReformaTributariaTotal.fltValorTotalIBS_MUN     := fltValorTotalIBS_MUN;
  dadosGerais.ReformaTributariaTotal.fltValorTotalDifCBS      := fltValorTotalDifCBS;
  dadosGerais.ReformaTributariaTotal.fltValorTotalDifIBS_UF   := fltValorTotalDifIBS_UF;
  dadosGerais.ReformaTributariaTotal.fltValorTotalDifIBS_MUN  := fltValorTotalDifIBS_MUN;
  dadosGerais.ReformaTributariaTotal.fltValorTotalGrupoIBS    := fltValorTotalGrupoIBS;
  dadosGerais.ReformaTributariaTotal.fltValorTotalNFe         := fltValorTotalNFe;
end;

function TFonteDadosBD.fDeveConcatenarAsNaturezas: Boolean;
  Var
    strCNNOXM : String;
begin
  strCNNOXM := Trim(fCfgSisFonte(Self, 'CNNOXM'));
  Result := (fEmptyStr(strCNNOXM)) Or (strCNNOXM = 'S');
end;

function TFonteDadosBD.fReceberApenasUmaNaturezaDeOperacao(const strNat1,
  strNat2, strNat3, strNat4: String): String;
begin
  Result := strNat1;
  If fEmptyStr(Result) Then
    Result := strNat2;
  If fEmptyStr(Result) Then
    Result := strNat3;
  If fEmptyStr(Result) Then
    Result := strNat4;
end;

function TFonteDadosBD.fRetornaDataDeCompetenciaNFS(const strChaveAcesso: String): TDateTime;
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  dtaDtaEnt: TDateTime;
  intFusoHorario: Integer;
begin
  Result := nOw();

  If fEmptyStr(strChaveAcesso) Then
    Exit;

  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Text := 'SELECT FIS_DTAENT FROM CADFIS WHERE FIS_ACESSO = :ACESSO';
    qryAux.ParamByName('ACESSO').AsString := strChaveAcesso;
    qryAux.Open;

    If qryAux.RecordCount > 0 Then
    Begin
      If Not qryAux.FieldByName('FIS_DTAENT').IsNull Then
      Begin
        dtaDtaEnt := qryAux.FieldByName('FIS_DTAENT').AsDateTime;
        intFusoHorario := fRetornaFusoHorario;

        Result := IncHour(Int(dtaDtaEnt), Abs(intFusoHorario));
      End;
    End;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TFonteDadosBD.fEhDevolucaoTotal(AChaveAcesso: String): Boolean;
Var
  qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LNumDoc: String;
  LEspDoc: String;
  LCodEmp: String;
  LTotRef: Double;
  LTotDev: Double;

begin
  Result := False;

  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP, SUM(DET_TOTITE-DET_DESESP) AS TOTREF FROM CADFIS');
    qryAux.SQL.Add('INNER JOIN MOVDET ON MOVDET.DET_NUMDOC = CADFIS.FIS_NUMDOC AND');
    qryAux.SQL.Add('                     MOVDET.DET_ESPDOC = CADFIS.FIS_ESPDOC AND');
    qryAux.SQL.Add('                     MOVDET.DET_CODEMP = CADFIS.FIS_CODEMP AND');
    qryAux.SQL.Add('                     MOVDET.DET_TIP_FC = CADFIS.FIS_TIP_FC AND');
    qryAux.SQL.Add('                     IF(MOVDET.DET_TIP_FC = "C", MOVDET.DET_CODCLI = CADFIS.FIS_FORCLI,');
    qryAux.SQL.Add('                                                 MOVDET.DET_CODFOR = CADFIS.FIS_FORCLI)');
    qryAux.SQL.Add('WHERE FIS_ACESSO = :ACESSO');
    qryAux.SQL.Add('GROUP BY FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP');
    qryAux.ParamByName('ACESSO').AsString := AChaveAcesso;
    qryAux.Open;

    If not (qryAux.RecordCount > 0) Then
      Exit;

    LTotRef := qryAux.FieldByName('TOTREF').AsFloat;
    LNumDoc := qryAux.FieldByName('FIS_NUMDOC').AsString;
    LEspDoc := qryAux.FieldByName('FIS_ESPDOC').AsString;
    LCodEmp := qryAux.FieldByName('FIS_CODEMP').AsString;

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT SUM(DET_TOTITE-DET_DESESP) AS TOTDEV FROM MOVDET');
    qryAux.SQL.Add('WHERE DET_NUMDOC = :NUMDOC');
    qryAux.SQL.Add('  AND DET_ESPDOC = :ESPDOC');
    qryAux.SQL.Add('  AND DET_CODEMP = :CODEMP');

    If dadosGerais.strTip_FC = 'C' Then
      qryAux.SQL.Add('  AND DET_CODCLI = :CODCLI')
    Else
      qryAux.SQL.Add('  AND DET_CODFOR = :CODCLI');

    qryAux.SQL.Add('  AND DET_DOCDEV = :DOCDEV');
    qryAux.SQL.Add('  AND DET_ESPDEV = :ESPDEV');
    qryAux.SQL.Add('  AND DET_EMPDEV = :EMPDEV');
    qryAux.ParamByName('NUMDOC').AsString := dadosGerais.strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := dadosGerais.strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := dadosGerais.strCodemp;
    qryAux.ParamByName('CODCLI').AsString := dadosGerais.strCodCli;
    qryAux.ParamByName('DOCDEV').AsString := LNumDoc;
    qryAux.ParamByName('ESPDEV').AsString := LEspDoc;
    qryAux.ParamByName('EMPDEV').AsString := LCodEmp;
    qryAux.Open;

    If not (qryAux.RecordCount > 0) Then
      Exit;

    LTotDev := qryAux.FieldByName('TOTDEV').AsFloat;

    Result := (LTotDev >= LTotRef);
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TFonteDadosBD.pPreparaChavesReferenciadasDevolucao;
var
  docRef: TChaveReferenciada;
  intIndice: Integer;
  LXML: String;
begin

  If pos(dadosGerais.strFinalidade, '5_6_') > 0 Then
    Exit;

  If not (Pos(dadosGerais.strClaFis, CFOP_DEVOLUCAO) > 0) Then
    Exit;

  If not fEmptyStr(fChaveAcesso) Then
    Exit;

  If not (fCfgSisFonte(Self, 'USAINS') = 'S') Then
    Exit;

  if not FileExists(ExtractFilePath(Application.ExeName) + 'recusa.jpg') then
  begin
    pLogImp('pPreparaChavesReferenciadasDevolucao: recusa.jpg não encontrado em ' +
            ExtractFilePath(Application.ExeName) + ' — Insucesso desligado.');
    Exit;
  end;

  For intIndice := Low(dadosGerais.arrChavesReferenciadas) To High(dadosGerais.arrChavesReferenciadas) Do
  Begin
    docRef := dadosGerais.arrChavesReferenciadas[intIndice];

    Try
      If not fEhDevolucaoTotal(docRef.strChaveAcessoNfe) Then
        Continue;

      LXML := fRetornaXMLNFeBD(docRef.strChaveAcessoNfe);

      If fExigeInsucesso(LXML) Then
        docRef.strHashEntrega := fGerarHashEntrega(docRef.strChaveAcessoNfe, ExtractFilePath(Application.ExeName) + 'recusa.jpg');
    Except
      On E: Exception Do
        pLogImp(Format('pPreparaChavesReferenciadasDevolucao: falha ao processar NF-e %s ' +
                       '(%s: %s). Item ignorado, prosseguindo com os demais.',
                       [docRef.strChaveAcessoNfe, E.ClassName, E.Message]));
    End;
  End;
end;

function TFonteDadosBD.fRetornaFusoHorario: Integer;
Var
  qryTmp: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryTmp := fCriaQuery(Nil);

  Try
    qryTmp.SQL.Text := 'SELECT TIMESTAMPDIFF(HOUR, UTC_TIMESTAMP(), NOW()) AS FUSOHORARIO ';
    qryTmp.Open;

    Result := Abs(qryTmp.FieldByName('FUSOHORARIO').AsInteger);
  Finally
    FreeAndNil(qryTmp);
  End;
end;

initialization
  VS_GravaUsuRep  := '';
  VS_LogRepConId  := '';
  VS_LogRepCodOp  := '';
  VS_ConnectionID := '';

finalization

end.
