unit untEntNfeXml;

interface

uses Windows,
     Classes,
     Controls,
     Variants,
     XMLDoc,
     XMLIntf,
     DB,
     UniClientDataSet,
     SysUtils,
     StrUtils,
     Uni,
     untZClient,
     Dialogs,
     untTValidaNFeCapa,
     untTypesSistema,
     untGravando,
     System.Character,
     System.Rtti,
     untLibNfe,
     untConstantesNFe,
     untTPerfilDespachanteAduaneiro;

Type
  TCalculoBaseSubstituicaoXML = (tcbsProdutosSemIPI, tcbsIPIComProdutos);

  type
  TRecItem = Record
    strCodIte: String;
    strDesIte: String;
    strCodFab: String;
    strClaIPI: String;
    strCodAbf: String;
    strDesAbf: String;
    strRefere: String;
    strAbfCof: String;
    strAbfPis: String;
    strSigUni: String;
    fltPFCPST: Double;
  End;

  TRecDiferencas = Record
    fltST_Cal,
    fltST_XML,
    fltValGnr: Double;
    strCodSit,

    strBasSub,
    strFatIVa,
    strValSub,

    strBasIcm,
    strAlqIcm,
    strValIcm,

    strBasIpi,
    strAlqIpi,
    strValIpi,

    strPISCST,
    strPISVBC,
    strPISPPIS,
    strPISVPIS,

    strpFCPST,
    strvFCPST,

    strCOFCST,
    strCOFVBC,
    strCOFPCOFINS,
    strCOFVCOFINS: String;
    strMemCalGNRE: String;
  End;

  TString5 = String[5];
  TString7 = String[7];
  TString8 = String[8];

  TRecGerEle = packed Record
    strAutInc:      String[20];
    GER_CODFOR:     TString8;
    GER_CODCLI:     TString8;
    GER_TIP_FC:     String[1];
    GER_TIPXML:     Integer;
    GER_CODEMP:     String[3];
    GER_CONPAG:     String[100];
    B02_CUF:        String[2];
    B03_CNF:        String[9];
    B04_NATOP:      String[60];
    B05_INDPAG:     String[1];
    B06_MOD:        String[2];
    B07_SERIE:      String[3];
    B11A_IDDEST:    integer;
    B08_NNF:        String[12];
    B09_DEMI:       TDate;
    B10_DSAIENT:    TDate;
    B11_TPNF:       String[1];
    B12_CMUNFG:     String[7];
    B21_TPIMP:      String[1];
    B22_TPEMIS:     String[1];
    B24_TPAMB:      String[1];
    B25_FINNFE:     String[1];
    NFeAjuste: Boolean;
    B25B_INDPRES:   Integer;
    B25B_INDFINAL:  Integer;
    B26_PROCEMI:    String[1];
    C02_CNPJ:       String[14];
    C02A_CPF:       String[11];
    C03_XNOME:      String[60];
    C04_XFANT:      String[60];
    C03_XLGR:       String[60];
    C07_NRO:        String[60];
    C08_XCPL:       String[60];
    C09_XBAIRRO:    String[60];
    C10_CMUN:       String[7];
    C11_XMUN:       String[60];
    C12_UF:         String[2];
    C13_CEP:        String[8];
    C14_CPAIS:      String[4];
    C15_XPAIS:      String[60];
    C16_FONE:       String[10];
    C17_IE:         String[14];
    C18_IEST:       String[24];
    C19_IM:         String[15];
    C20_CNAE:       String[7];
    C21_CRT:        String[1];
    E02_CNPJ:       String[14];
    E17_IE:         String[14];
    E03_XNOME:      String[60];
    E03_XLGR:       String[60];
    E07_NRO:        String[60];
    E09_XBAIRRO:    String[60];
    E10_CMUN:       String[7];
    E10_UF:         String[2];
    E13_CEP:        String[8];
    E16_FONE:       String[10];
    W03_VBC:        Double;
    W04_VICMS:      Double;
    W04A_VICMSDESON:Double;
    W04H_VFCP:      Double;
    W05_VBCST:      Double;
    W06_VST:        Double;
    W06A_VFCPST:    Double;
    W07_VPROD:      Double;
    W08_VFRETE:     Double;
    W09_VSEG:       Double;
    W10_VDESC:      Double;
    W11_VII:        Double;
    W12_VIPI:       Double;
    W12A_VIPIDEVOL: Double;
    W13_VPIS:       Double;
    W14_VCOFINS:    Double;
    W15_VOUTRO:     Double;
    W16_VNF:        Double;
    W15_VSERV:      Double;

    W18_VSERV:      Double;
    W19_VBC:        Double;
    W20_VISS:       Double;
    W21_VPIS:       Double;
    W22_VCOFINS:    Double;
    W22A_DCOMPET:   Double;
    W22B_VDEDUCAO:  Double;
    W22D_VDESCINCOND: Double;

    W24_VRETPIS:    Double;
    W25_VRETCOFINS: Double;
    W26_VRETCSLL:   Double;
    W27_VBCIRRF:    Double;
    W28_VIRRF:      Double;
    W29_VBCRETPREV: Double;
    W30_VRETPREV:   Double;
    W31_VICMSUFDEST:Double;

    B25_TPNFDEBITO:  String[2];
    B25_TPNFCREDITO: String[2];

    RT_VIS:             Double;
    RT_VBCIBSCBS:       Double;
    RT_VDIFIBSUF:       Double;
    RT_VDEVIBSUF:       Double;
    RT_VIBSUF:          Double;
    RT_VDIFMUN:         Double;
    RT_VDEVMUN:         Double;
    RT_VIBSMUN:         Double;
    RT_VIBS:            Double;
    RT_VCREDPRES:       Double;
    RT_VCREDPRECS:      Double;
    RT_VDIFCBS:         Double;
    RT_VDEVCBS:         Double;
    RT_VCBS:            Double;
    RT_VCREDPRESCBS:    Double;
    RT_VCREDPRECCBS:    Double;
    RT_VNFTOT:          Double;

    X27_QVOL:       Double;
    X28_ESP:        String;
    X31_PESOL:      Double;
    X32_PESOB:      Double;
    X33_MODFRETE:   String;
    X34_CNPJ    :   String;
    X35_MARCA   :   String;
    PR07_CHNFE  :   String;
    PR08_STATUS :   String;
    PR09_MOTIVO :   String;
    Z03_infCpl  : WideString;
    Z02_infAdFisco: WideString;

    strXTexto : String;
    vlrTotDupl  :   Double;
    strMatRev: String;
    procedure pGeraDados(var Lista: TStringList);

  End;

  TRecGerEle_Bco = packed Record
    strAutInc:      String;
    GER_CODFOR:     String;
    GER_CODCLI:     String;
    GER_TIP_FC:     String;
    GER_TIPXML:     Integer;
    GER_CODEMP:     String;
    GER_CONPAG:     String;
    B02_CUF:        String;
    B03_CNF:        String;
    B04_NATOP:      String;
    B05_INDPAG:     String;
    B06_MOD:        String;
    B07_SERIE:      String;
    B08_NNF:        String;
    B09_DEMI:       TDate;
    B10_DSAIENT:    TDate;
    B11_TPNF:       String;
    B11A_IDDEST:    Integer;
    B12_CMUNFG:     String;
    B21_TPIMP:      String;
    B22_TPEMIS:     String;
    B24_TPAMB:      String;
    B25_FINNFE:     String;
    NFeAjuste: Boolean;
    B25B_INDPRES:   Integer;
    B25B_INDFINAL:  Integer;
    B26_PROCEMI:    String;
    C02_CNPJ:       String;
    C02A_CPF:       String;
    C03_XNOME:      String;
    C04_XFANT:      String;
    C03_XLGR:       String;
    C07_NRO:        String;
    C08_XCPL:       String;
    C09_XBAIRRO:    String;
    C10_CMUN:       String;
    C11_XMUN:       String;
    C12_UF:         String;
    C13_CEP:        String;
    C14_CPAIS:      String;
    C15_XPAIS:      String;
    C16_FONE:       String;
    C17_IE:         String;
    C18_IEST:       String;
    C19_IM:         String;
    C20_CNAE:       String;
    E02_CNPJ:       String;
    E17_IE:         String;
    E03_XNOME:      String;
    E03_XLGR:       String;
    E07_NRO:        String;
    E09_XBAIRRO:    String;
    E10_CMUN:       String;
    E10_UF:         String;
    E13_CEP:        String;
    E16_FONE:       String;
    W03_VBC:        Double;
    W04_VICMS:      Double;
    W04A_VICMSDESON:Double;
    W04H_VFCP:      Double;
    W05_VBCST:      Double;
    W06_VST:        Double;
    W06A_VFCPST:    Double;
    W07_VPROD:      Double;
    W08_VFRETE:     Double;
    W09_VSEG:       Double;
    W10_VDESC:      Double;
    W11_VII:        Double;
    W12_VIPI:       Double;
    W12A_VIPIDEVOL: Double;
    W13_VPIS:       Double;
    W14_VCOFINS:    Double;
    W15_VOUTRO:     Double;
    W16_VNF:        Double;
    W15_VSERV:      Double;

    W18_VSERV:      Double;
    W19_VBC:        Double;
    W20_VISS:       Double;
    W21_VPIS:       Double;
    W22_VCOFINS:    Double;
    W22A_DCOMPET:   Double;
    W22B_VDEDUCAO:  Double;
    W22D_VDESCINCOND: Double;

    W24_VRETPIS:    Double;
    W25_VRETCOFINS: Double;
    W26_VRETCSLL:   Double;
    W27_VBCIRRF:    Double;
    W28_VIRRF:      Double;
    W29_VBCRETPREV: Double;
    W30_VRETPREV:   Double;
    W31_VICMSUFDEST:Double;

    X27_QVOL:       Double;
    X28_ESP:        String;
    X31_PESOL:      Double;
    X32_PESOB:      Double;
    X33_MODFRETE:   String;
    X34_CNPJ    :   String;
    X35_MARCA   :   String;
    PR07_CHNFE  :   String;
    PR08_STATUS :   String;
    PR09_MOTIVO :   String;
    Z03_infCpl  : WideString;
    Z02_infAdFisco: WideString;
    vlrTotDupl  :   Double;
    strMatRev: String;

  End;

  TRecDupEle = Record
    Y08_NumDup : String;
    Y09_DtaVen : TDate;
    Y10_VlrDup : Double;
  End;

  TRecTotais = Record
    fltTotIte_DI: Double;
    fltII_DI    : Double;
    fltIPI_DI   : Double;
    fltPIS_DI   : Double;
    fltCOFINS_DI: Double;
    fltSiscom_DI: Double;
    fltAFRMM_DI : Double;
    fltICMS_DI  : Double;

    fltTotIte_NF: Double;
    fltII_NF    : Double;
    fltIPI_NF   : Double;
    fltPIS_NF   : Double;
    fltCOFINS_NF: Double;
    fltSiscom_NF: Double;
    fltAFRMM_NF : Double;
    fltICMS_NF  : Double;
  End;


  TOnLogErro = procedure(strNumDoc, strSerie, strNomArq, strMensagem: String) of object;

  TOnNaoEncontrouItem = procedure(strNumDoc,
                                  strCodFor,
                                  strCodIteF,
                                  strDesIteF,
                                  strEanPro,
                                  strUnidade,
                                  strCLAIPI,
                                  strClaFis,
                                  strCodCST,
                                  strCdCEST,
                                  strNUMFCI,
                                  strEAN,
                                  strEANTrib: String;
                                  fltUnidadeFATUTR,
                                  fltPRECOM,
                                  fltFREENT,
                                  fltPER_CI,
                                  fltPerIPI,
                                  fltPerICM,
                                  fltSUBSTI: Double;
                                  strUF_For: String) of object;

  TOnGravando = procedure(strInformacao: String; intPosicao, intMaximo: Integer) of Object;

  TOnAlteraClaIPI = procedure(strCodIte, strCodFab, strClaIpiXml, strNFCIXML: String; fltPerCiXML: Double) of Object;

  TDoFornecedorNaoEncontrado = procedure (strCNPJ, strCPF, strXNOME, strXFANT, strXLGR, strNRO, strXCPL, strXBAIRRO, strCMUN, strXMUN, strUF, strCEP,
                                                strCPAIS, strXPAIS, strFONE, strIE, strIEST, strIM, strCNAE: String) of Object;

  TStatusNFeXml = (stXMLAutorizada, stXMLCancelada, stXMLIndefinido);

  TNFeXml = class(TComponent)
    private
      FDivCST,
      FValEle: Boolean;
      FErro: Boolean;
      FCdsErro: TUniClientDataSet;
      FCdsIncon: TZClient;
      FPatArq: String;
      FNomArq: String;
      FSeqGer: String;
      FGerEle: TRecGerEle;
      FArrDetEle: Array Of TRecDetEle;
      FArrRetEle: Array Of TRecRetEle;
      FArrDupEle: Array Of TRecDupEle;

      strFrmCus,
      strTipAbfCfg: string;
      strTipTPABPC: String;
      blnIFCPST: Boolean;

      blnAtuSub,
      blnValidaPisCofins,
      blnIGNSIM,
      blnTABPRF: Boolean;

      strEstEmp: String;
      fltRedAliCargaMediaEmp: Double;

      blnConsiderarDescontoDesonerado: boolean;

      FNotaImportacao: Boolean;
      FEmissaoImportacao: Boolean;
      FImportacaoDI: Boolean;

      blnVersao4: boolean;

      qryTribut: TUniQuery;
      qryCritica: TUniQuery;
      qrySQL: TUniQuery;

      FIteMatCon: TString7;

      fltTolerancia: Double;

      FCnvEmb: String;

      FCriarTagDestinatarioEmBrancoCasoInexistente: Boolean;
      FOnErro: TOnLogErro;
      FOnGravando: TOnGravando;
      FOnNaoEncontrouItem: TOnNaoEncontrouItem;
      FOnAlteraClaIPI: TOnAlteraClaIPI;

      FDoFornecedorNaoEncontrado: TDoFornecedorNaoEncontrado;

      FintTamNumDocGerEle : Integer;

      strEmpEst: String;
      blnContribuinteIPI: Boolean;
      blnFreTri,
      blnFreTIp,
      blnValidar: Boolean;
      blnSimPau: Boolean;
      FfinalidadeXML: tpeFinalidadeXML;
      blnFulFillment : Boolean;
      FblnPreGnre: Boolean;
      FblnIgnoraInativos: Boolean;
      qryNotGer: TUniQuery;
      strEmpSEL: String;
      FEmpresaNoDestinatario : Boolean;
      procedure processaCapa_x_Detalhes;
      Function fCalculaCSTXML(recDetEle: TRecDetEle; strCSTCad: String): String;
      Function fEhNotaImportacao(nodInfNFe: IXMLNode; blnEhEmissaoImportacao: Boolean = False; strCodFor: string = ''): Boolean;
      Function fExistNode(nodNo: IXMLNode; strNome: String): Boolean;
      function fGetCount: Integer;
      function fGetRetCount: Integer;
      function fGetItem(intIndex: Integer): TRecDetEle;
      function fGetRetornoReferencia(intIndex: Integer): TRecRetEle;
      procedure pGravaCriticas(cdsCriticas: TZClient = nil; strOperadorLiberacao: String = ''; horLiberacao: TTime = 0);
      function fGetIde(nodIde: IXMLNode): Boolean;
      function fGetEmit(nodEmit: IXMLNode): Boolean;
      Function fGetDest(nodDest: IXMLNode): Boolean;
      function fGetChaveStatus(nodChave: IXMLNode): Boolean;
      function fGetTotal(nodTotal: IXMLNode): Boolean;
      Function fGetTransp(nodTransp: IXMLNode): Boolean;

      function fRetPER_CI(strNFCI, strInfAdProd: String): Double;

      Function fImportaValoresDOCIMP(Var recDetEle: TRecDetEle): Boolean;
      function fGetDet(nodDet: IXMLNode; var recDetEle: TRecDetEle; var blnQtdComZero: Boolean): Boolean;
      function fGetRet(nodRet: IXMLNode; var recRetEle: TRecRetEle): Boolean;
      function fGetProd(nodProd: IXMLNode; var recDetEle: TRecDetEle; var blnEncontrou: boolean; var blnQtdComZero: Boolean): Boolean;
      function fGetVSegNotDet(AnItem: String): Double;
      Function fGetDI(nodDI: IXMLNode; Var recDetEle: TRecDetEle): Boolean;
      function fGetICMS(nodIcms: IXMLNode; var recDetEle: TRecDetEle): Boolean;
      Function fGetICMSDest(nodIcms: IXMLNode; Var recDetEle: TRecDetEle): Boolean;
      function fGetCOFINS(nodCOFINS: IXMLNode; var recDetEle: TRecDetEle): Boolean;
      function fGetISSQN(nodISSQN: IXMLNode; var recDetEle: TRecDetEle): Boolean;
      function fGetIPI(nodIPI: IXMLNode; var recDetEle: TRecDetEle): Boolean;
      function fGetII(nodII: IXMLNode; var recDetEle: TRecDetEle): Boolean;
      Function fGetImpostoDevol(nodImpostoDevol: IXMLNode; Var recDetEle: TRecDetEle): Boolean;
      function fGetPIS(nodPIS: IXMLNode; var recDetEle: TRecDetEle): Boolean;
      function fGetADI(nodADI: IXMLNode; var recDetEle: TRecDetEle): Boolean;

      function fNotaExiste(strNF, strSerie, strtpNF, strCNPJ, strCPF: String): Boolean;
      function fExisteFornecedor(strCGCCPF, strCGC: String; var strCodFor: TString8; Var strMatRev: String): Boolean;
      function fExisteFornecedorCitel(strCodCit: String; var strCodFor: TString8; Var strMatRev: String): Boolean;

      Function fExisteItemMatConsumo(strCodBar, strCodFab: String; Var strCodIte: TString7; Var blnAtivo: Boolean;
                                     Var recDetEle: TRecDetEle): Boolean;

      Function fExisteItemCodCitel(strCodCit: String; Var strCodIte: TString7; Var blnAtivo: Boolean): Boolean;
      Function fExisteItemCodVelCitel(strCodCit: String; Var strCodIte: TString7; Var blnAtivo: Boolean): Boolean;
      function fExisteItemCodBar(strCodBar: String; var strCodIte: TString7; Var blnAtivo: Boolean): Boolean;
      function fExisteItemCodBarSem(strCodBar: String; var strCodIte: TString7; Var blnAtivo: Boolean): Boolean;
      function fExisteItemCodEmb(strCodBar: String; var strCodIte: TString7; Var blnAtivo: Boolean): Boolean;
      function fExisteItemCodFab(strCodFab, strCodFor: String; var strCodIte: TString7; Var blnAtivo: Boolean): Boolean;
      function fExisteItemCodFabSem(strCodFab, strCodFor: String; var strCodIte: TString7; Var blnAtivo: Boolean): Boolean;
      function fExisteItemCodItemFornecedor(strCodItemF, strCodFor: String; var strCodIte: TString7; Var blnAtivo: Boolean): Boolean;
      Function fRetEmpresaCnpj(strCmpj: String; strEMP_I_E_S_: String = ''): String;
      function fExisteEmitenteCliente(strCGCCPF, strCGC: String; var strCodCli: TString8): Boolean;

      function fGravaGerEle(blnCSTCad: Boolean): Boolean;
      function fGravaGerEleAuditoria: Boolean;
      Function fLocalizaLivroFiscal(AChaveAcesso: String): Boolean;
      procedure pRemoveImportadoGERADT(AChaveAcesso: String);
      function CountDecimals(Value: Double): Integer;


      procedure pGravaNFEB2W;
      function fGravaDetEle(recDetEle: TRecDetEle; intIndexLst: integer; intIndexItem: integer): Boolean;
      function fGravaGerERT: Boolean;
      function fGravaDetERT(recDetEle: TRecDetEle; strAutoIncDetEle: string): Boolean;
      function fGravaNotaAjuste: Boolean;
      function fGravaRetEle(recRetEle: TRecRetEle): Boolean;

      procedure pLimparRecDetEle(var recDetEle: TRecDetEle);
      Procedure pIncluiErro(strMotivo: String; blnSemErro: Boolean = False);
      procedure pCriaCdsErros;

      Function fDescontoXML(recGerEle: TRecGerEle; recDetCal: TRecDetEle): Double;

      Function fCarregaDadosFornecedor(strCodFor: String): Boolean;

      procedure pCriaCdsInconsistencias;
      procedure pCalculaValoresNota(recDetEle: TRecDetEle; Var recDetCal: TRecDetEle; recGerEle: TrecGerEle);
      procedure pIncluiInconsistencia(recDetEle: TRecDetEle; strDetEle: String; recDiferencas: TRecDiferencas; intSequencia: integer; recItem: TRecItem);
      Procedure pMarcaMostrar(blnMostrar: Boolean);
      Procedure pMontaCondicaoPagamento;

      function fValidarCSTSimplesConversao(strCodFisNota, strCodFisCad: string): boolean;
      Function fN12_CSOSNToCodFis(strCSOSN, strOrig, strCstCad: String): String;
      Function fRetornaAbfIcm(strCodIte, strEstFor, strCodEmp: String): Boolean;
      Function fCarregaTributacao(strCodIte, strEstFor: String): Boolean;
      Function fSQLInconsitencias: String;
      Function fComparaValores(var recDetEle: TRecDetEle; Var recDetCal: TRecDetEle; Var recDiferencas: TRecDiferencas): Boolean;
      Function fSQLTributacao: String;
      function GetDuplicatasCount: integer;
      function GetRecDupEle(index: integer): TRecDupEle;
      procedure pRegistraItemParaGravacao(recGerEle: TRecGerEle; recDetEle: TRecDetEle);
      function fCarregaCadIte(strCodIte, strCodEmp, strCodFor, strCodCli: string): TRecItem;
      function fTipoCalculoBaseST(strCodFor: String): TCalculoBaseSubstituicaoXML;
      function fExiteItemCodItemCliente(strCodItemC, strCodCli: String; var strCodIte: TString7; Var blnAtivo: Boolean): boolean;
      function fPadroniza(strNUmPed: string): String;
      function fRetornoCodigoItemPelaReferenciaDaNotaImportacao(strCodReferencia: String): String;
      function fNotaExisteCadFis: Boolean;
      function fDadosFornec(const strFieldName: String): String;
      function fXmlCancelamento(xmlDoc: TXMLDocument): Boolean;
      function fXmlDevolucaoSemEntrada: Boolean;
      function fExisteNotaEntradaChaveNFE(strChaNFE: String; Var strDocume: String): Boolean;
      function fGetComb(nodComb: IXMLNode; var recDetEle: TRecDetEle): Boolean;
      Function fValidaSerie(var AStrSerie: String): Boolean;
      procedure pCarregaNotGer;

    public
      cdsXML: TZClient;
      blnImportaFrete : Boolean;
      blnValidarXMLVal : Boolean;
      blnValidaXMLSefaz: Boolean;
      cdsDadosFornec: TZClient;
      blnImportaNfeSpedCodVel: Boolean;
      CalculoBaseSubstituicaoXML: TCalculoBaseSubstituicaoXML;
      blnAuditoria: Boolean;

      blnXMLCancelado: Boolean;
      blnXMLIndefinido: Boolean;
      blnXMLCancelamento : Boolean;
      blnXMLCancelamentoSemNota : Boolean;
      strDocOriginalCanceladoXML : String;

      blnXmlDevolucaoSemEntrada : Boolean;
      strDocOriginalDevolucaoXML : String;

      cdsCodVel: TUniClientDataSet;
      cdsAbfIcm: TUniClientDataSet;
      lstDados: TStringList;
      PerfilDespachanteAduaneiro: TPerfilDespachanteAduaneiro;

      fLocalizarItemRetornoSimbolico: TFunctionLocalizarItemRetornoSimbolico;

      frmGravandoNotas: TfrmGravando;
      stlListaNotImp: TStringList;

      objValidaNFeCapa: TValidaNFeCapa;
      constructor Create(AOwner: TComponent);overload;override;
      constructor Create(AOwner: TComponent; blnValidar: Boolean; finalidadeXML : tpeFinalidadeXML = xmlEntradaMercadoria); reintroduce; overload;

      function fTamNumDocGerEle : Integer;

      procedure pLimpar;
      class var  Agrupador: string;
      procedure pAdicionarItem(objDetEle: TRecDetEle; objGerEle: TrecGerEle);
      procedure pAdicionarRetornoReferencia(objRetEle: TRecRetEle);
      procedure pAdicionarDup(objDupEle: TRecDupEle);

      Class Function fSQLDadosFornec: String;
      Class Function fGetStatusXML(strChave: String; strCodEmp: String): TStatusNFeXml;

      function fCarregarDoArquivo(strArquivo: String; Var cdsDiverg: TZClient; blnFulFillment: Boolean = False; blnEhEmissaoImportacao: Boolean = False; strCodFor: string = ''; blnEhImportacaoDI: Boolean = False): Boolean;
      function fGravarNotaFiscal(blnCSTCad: Boolean; intIndexList: integer; blnPreGnre: Boolean; cdsCriticas: TZClient = nil; strOperadorLiberacao: String = ''; horLib: TTime = 0): Boolean;
      destructor Destroy; override;

      function fRenomearArquivo(blnRenomearCancelados: Boolean = False; strNomArq: String = ''): Boolean;
      function fGravarXmlDivergente: Boolean;
      function fGravarXml: Boolean;

      property getQuantidadeItens: Integer read fGetCount;
      property recDadosNota: TRecGerEle read FGerEle;
      property getItemNota[index: Integer]: TRecDetEle read fGetItem; default;
      property getRetornoReferencia[index: Integer]: TRecRetEle read fGetRetornoReferencia;
      property blnCriarTagDestinatarioEmBrancoCasoInexistente: Boolean read FCriarTagDestinatarioEmBrancoCasoInexistente write FCriarTagDestinatarioEmBrancoCasoInexistente;
      property onLogErro: TOnLogErro read FOnErro write FOnErro;
      property OnGravando: TOnGravando read FOnGravando write FOnGravando;
      property OnNaoEncontrouItem: TOnNaoEncontrouItem read FOnNaoEncontrouItem write FOnNaoEncontrouItem;
      property OnAlteraClaIPI : TOnAlteraClaIPI read FOnAlteraClaIPI write FOnAlteraClaIPI;
      property OnFornecedorNaoEncontrado: TDoFornecedorNaoEncontrado read FDoFornecedorNaoEncontrado write FDoFornecedorNaoEncontrado;
      property blnDivCST: Boolean read FDivCST write FDivCST;
      property DuplicatasCount: integer read GetDuplicatasCount;
      property Duplicatas[index: integer]: TRecDupEle Read GetRecDupEle;
      property PatArq: string Read FPatArq;
      property blnIgnoraInativos: Boolean Read FblnIgnoraInativos Write FblnIgnoraInativos;
      property blnEmpresaNoDestinatario : Boolean read FEmpresaNoDestinatario write FEmpresaNoDestinatario;
  End;

implementation

uses Forms,
untFuncoes, untConstantes, untFuncoesSimples, Math, untListaProdutosFCIDivergenteNFE,
  untCalculoPisCofins, untSelecionaEmpresa, untCadPag, untMovGer, untCadFis;

{ TNFeXml }

function TNFeXml.fGetCount: Integer;
begin
  Result := Length(FArrDetEle);
end;

function TNFeXml.fGetItem(intIndex: Integer): TRecDetEle;
begin
  Result := FArrDetEle[IntIndex];
end;

procedure TNFeXml.pAdicionarDup(objDupEle: TRecDupEle);
begin
  SetLength(FArrDupEle, Length(FArrDupEle) + 1 );
  FArrDupEle[High(FArrDupEle) ] := objDupEle;
end;

Function TNFeXml.fSQLTributacao: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   A.* ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   ABFICM A ';

  If strTipAbfCfg = '1' Then
  Begin
    strSQL := strSQL + ' INNER JOIN CADITE ON ITE_CODITE = :CODITE ';
  End Else
  Begin
    strSQL := strSQL + ' INNER JOIN ITEGER ON ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '                      ITE_CODEMP = ' + QuotedStr(String(FGerEle.GER_CODEMP));
  End;

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   ABF_CODABF = ITE_CODABF AND ';
  strSQL := strSQL + '   ABF_ESTADO = :ESTADO ';

  Result := strSQL;
End;

Function TNFeXml.fCarregaTributacao(strCodIte, strEstFor: String): Boolean;
Begin
  If Assigned(cdsAbfIcm) Then
  Begin
    If fRetornaAbfIcm(strCodIte, strEstFor, QuotedStr(String(FGerEle.GER_CODEMP)) ) Then
      strCodIte := cdsAbfIcm.FieldByName('CODITE').AsString
    Else
      strCodIte := '';

    Result := Not fEmptyStr(strCodIte);
    Exit;
  End;

  If Not Assigned(qryTribut) Then
    qryTribut := fCriaQuery(Self);

  With qryTribut Do
  Begin
    SQL.Text := fSQLTributacao;
    Close;
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('ESTADO').AsString := strEstFor;
    Open;

    Result := (Not IsEmpty) And (Not fEmptyStr(strEstFor));
  End;

End;

function TNFeXml.fDadosFornec(const strFieldName: String): String;
begin
  Result := EmptyStr;

  If Not Assigned(cdsDadosFornec) Then
    Exit;

  If Not Assigned(cdsDadosFornec.FindField(strFieldName)) Then
    Exit;

  Result := cdsDadosFornec.FieldByName(strFieldName).AsString;
end;

Function TNFeXml.fDescontoXML(recGerEle: TRecGerEle; recDetCal: TRecDetEle): Double;
Begin
  With recDetCal, recGerEle Do
  If blnConsiderarDescontoDesonerado Then
    Result := I17_VDESC + IIF((W07_VPROD + W18_VSERV + W06_VST + W08_VFRETE + W09_VSEG +
                 W12_VIPI + W15_VOUTRO + N23D_FCPST - W10_VDESC) - W16_VNF > 0.5  , N27A_VICMSDESON, 0) {+ N23D_FCPST //req 303332 }
  Else
    Result := I17_VDESC;
End;

Class Function TNFeXml.fSQLDadosFornec: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   FOR_CODFOR AS CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR AS NOMFOR, ';
  strSQL := strSQL + '   FOR_SIMPAU AS SIMPAU, ';
  strSQL := strSQL + '   FOR_ZONFRA AS ZONFRA, ';
  strSQL := strSQL + '   FOR_I_E_S_ AS I_E_S_, ';
  strSQL := strSQL + '   FOR_MATREV AS MATREV, ';
  strSQL := strSQL + '   CID_ESTADO AS ESTFOR, ';
  strSQL := strSQL + '   CID_NOMCID AS NOMCID, ';
  strSQL := strSQL + '   FOR_SOMIPI AS SOMIPI, ';
  strSQL := strSQL + '   IF(FOR_CGCCPF = 1, "J", "F") AS FISJUR, ';
  strSQL := strSQL + '   CAST("" AS CHAR(30)) AS TIPABF, ';

  strSQL := strSQL + '   CAST("" AS CHAR(3)) AS PERFOR  ';


  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADFOR ';

  strSQL := strSQL + ' INNER JOIN CADCID ON CID_CODCID = FOR_CODCID ';

  strSQL := strSQL + ' WHERE FOR_CODFOR = :CODFOR ';

  Result := strSQL;
End;

Function TNFeXml.fCarregaDadosFornecedor(strCodFor: String): Boolean;
  Var
    intContador: Integer;
    qryCadFor: TUniQuery;
Begin
  Result := False;

  If Not Assigned(cdsDadosFornec) Then
    Exit;

  If Not cdsDadosFornec.FindKey([strCodFor]) Then
  Begin
    qryCadFor := fCriaQuery;
    qryCadFor.SQL.Text := fSQLDadosFornec;
    qryCadFor.ParamByName('CODFOR').AsString := strCodFor;
    qryCadFor.Open;

    cdsDadosFornec.Insert;

    For intContador := 0 To qryCadFor.FieldCount - 1 Do
      cdsDadosFornec.Fields[intContador].Value := qryCadFor.Fields[intContador].Value;

    cdsDadosFornec.FieldByName('TIPABF').AsString :=
                fGetTipoAbf('F',
                            cdsDadosFornec.FieldByName('FISJUR').AsString,
                            cdsDadosFornec.FieldByName('I_E_S_').AsString,
                            '', '', '', '',
                            cdsDadosFornec.FieldByName('SIMPAU').AsString,
                            cdsDadosFornec.FieldByName('MATREV').AsString,
                            '',
                            '');

    cdsDadosFornec.FieldByName('PERFOR').AsString := fRetDesTipoAbf('F', strCodFor);

    cdsDadosFornec.Post;

    FreeAndNil(qryCadFor);
  End;

  Result := cdsDadosFornec.FieldByName('CODFOR').AsString = strCodFor;
End;

procedure TNFeXml.pCalculaValoresNota(recDetEle: TRecDetEle; Var recDetCal: TRecDetEle; recGerEle: TrecGerEle);
  Var
    strClaFis,
    strCodFis,
    strEstFor,
    strCodAbf,
    strTipAbf: String;
    fltBasIcm,
    fltAlqIcm,
    fltAlqIcmRed,
    fltValIcm,
    fltPerBas,
    fltPeBaST,
    fltDesAce,
    fltDesEsp,
    fltABF_IVA_ST,
    fltValipi,
    fltAliFCP,
    fltAliSte,
    fltTotProduto: Double;
    CalcResult: TResultPisCofins;
    tmp: TCalculoPisCofins;
    strSitP_C: String;
    blnRedCargaMedia: Boolean;
    fltAliSteCargaMedia: Double;
    blnValidarApenasDescontoBaseST: Boolean;
    blnComLub: Boolean;
Begin
  recDetCal := recDetEle;
  With recDetCal Do
  Begin
    N11_ORIG    := '';
    N12_CST     := '';
    N12_CSOSN   := '';
    N19_PMVAST  := 0;

    N15_VBC     := 0;
    N16_PICMS   := 0;
    N17_VICMS   := 0;

    N21_VBCST                     := 0;
    N21_VBCST_IPIComDesconto      := 0;
    N21_VBCST_Produto             := 0;
    N21_VBCST_Produto_ComDesconto := 0;
    N21_VBCST_Produto_ComIPI      := 0;

    DET_BASSUB                      := 0;
    N23_VICMSST                     := 0;
    N23_VICMSST_IPIComDesconto      := 0;
    N23_VICMSST_Produto             := 0;
    N23_VICMSST_Produto_ComDesconto := 0;
    N23_VICMSST_Produto_ComIPI      := 0;
    N23_VICMSST_GARE                := 0;
    N23_VFCPST_GARE                 := 0;

    N28_QICMSMonoRet                := 0;
    N28_AdBCMonoRet                 := 0;
    N28_VRemICMSRet                 := 0;

    O10_VBC     := 0;
    O13_PIPI    := 0;
    O14_VIPI    := 0;
    O14_VIPI_ComDesconto := 0;

    If Not blnFulFillment Then
    Begin
      strEstFor  := fDadosFornec('ESTFOR');
      blnSimPau  := fDadosFornec('SIMPAU') = 'S';
      strTipAbf  := fDadosFornec('TIPABF');
    End;

    If blnImportaNfeSpedCodVel Then
      strCodAbf := cdsAbfIcm.FieldByName('ABF_CODABF').AsString
    Else
      strCodAbf := '';

    fltValipi := 0;
    If fDadosFornec('SOMIPI') = 'S' Then
    begin
      fltBasIPI   := I11_VPROD + I17A_VOUTRO + I16_VSEG;

      If blnFreTIp Then
        fltBasIPI := fltBasIPI + I15_VFRETE;

      If fDadosFornec('MATREV') = 'I' Then
        O13_PIPI    := fCampoTabela('ITE_IPIENT', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [DET_CODITE, FGerEle.GER_CODEMP])
      Else
        O13_PIPI    := 0;

      fltValipi   := RoundTo(fltBasIPI * (O13_PIPI / 100), -2);
    end;

    fltTotProduto :=  I11_VPROD + fltValipi - fDescontoXML(FGerEle, recDetCal) + I17A_VOUTRO + I16_VSEG;

    if blnFreTri Then
      fltTotProduto := fltTotProduto + I15_VFRETE;

    blnComLub := fCampotabela('ITE_COMLUB', 'CADITE', ['ITE_CODITE'], [String(DET_CODITE)]) = 'S';
    If fCarregaTributacao(String(DET_CODITE), strEstFor) And
       fRetornaDadosFiscais(strEmpEst,
                            blnContribuinteIPI,
                            False,
                            IIF(Not fEmptyStr(strCodAbf), strCodAbf, qryTribut.FieldByName('ABF_CODABF').AsString) ,
                            fltTotProduto,
                            fRetornaAlqFor(strEstFor, fDadosFornec('I_E_S_'), strEstEmp),
                            strEstFor,
                            String(FGerEle.GER_CODFOR),
                            fItemRevInd(String(DET_CODITE), String(FGerEle.GER_CODEMP)) = 'R',
                            strClaFis,
                            strCodFis,
                            fltBasIcm,
                            fltAlqIcm,
                            fltAlqIcmRed,
                            fltValIcm,
                            fltPerBas,
                            fltPeBaST,
                            fltAliSte,
                            fltAliFCP,
                            blnRedCargaMedia,
                            False,
                            True,
                            false,
                            false,
                            false,
                            string(recDetCal.I08_CFOP),
                            false,
                            false,
                            cdsAbfIcm,
                            False,
                            blnComLub,
                            FFinalidadeXML = xmlDevolucaoEntradaEmitidaFornecedor) Then

    Begin
      fValorTabelaCFOPEntrada(String(recDetEle.I08_CFOP),  String(recDetEle.N12_CST), fRetTipoProduto(string(recDetCal.DET_CODITE)), strClaFis);
      I08_CFOP := ShortString(strClaFis);

      N11_ORIG    := ShortString(LeftStr(strCodFis, 1));
      N12_CST     := ShortString(RightStr(strCodFis, 2));
      fltAliSteCargaMedia := fltAliSte;
      If blnRedCargaMedia Then
        fltAliSteCargaMedia := fltAliSte * (( 100 - fltRedAliCargaMediaEmp )/100);

      DET_CSTXML  := ShortString(strCodFis);

      If blnImportaNfeSpedCodVel Then
        fltABF_IVA_ST := cdsAbfIcm.FieldByName('ABF_IVA_ST' + strTipAbf).AsFloat
      Else
        fltABF_IVA_ST := qryTribut.FieldByName('ABF_IVA_ST' + strTipAbf).AsFloat;

      N19_PMVAST  := (fltABF_IVA_ST - 1) * 100;

      O10_VBC     := I11_VPROD - fDescontoXML(FGerEle, recDetCal) + I17A_VOUTRO + I16_VSEG;

      fltBasIPI   := I11_VPROD + I17A_VOUTRO + I16_VSEG;

      fltBasIPI_ComDesconto := fltBasIPI - fDescontoXML(FGerEle, recDetCal);

      If blnFreTri Then
        O10_VBC   := O10_VBC + recDetCal.I15_VFRETE;

      If blnFreTIp Then
      Begin
        fltBasIPI := fltBasIPI + I15_VFRETE;
        fltBasIPI_ComDesconto := fltBasIPI_ComDesconto + I15_VFRETE;
      End;

      If (fDadosFornec('MATREV') = 'I') Or (fDadosFornec('SOMIPI') = 'T') Then
        O13_PIPI    := fCampoTabela('ITE_IPIENT', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [DET_CODITE, FGerEle.GER_CODEMP])
      Else
        O13_PIPI    := 0;

      O14_VIPI    := RoundTo(fltBasIPI * (O13_PIPI / 100), -2);

      O14_VIPI_ComDesconto := RoundTo(fltBasIPI_ComDesconto * (O13_PIPI / 100), -2);

      CAL_ALQINT :=  fltAliSte;

      If Pos(strCodFis, CST_SUBSTITUICAO) > 0 Then
      Begin
        If (fDadosFornec('SOMIPI') = 'T') And (fCfgSis('URSTCL', varBoolean)) Then
        Begin
          N21_VBCST_Produto   := 0;
          N23_VICMSST_Produto := 0;
          N23_VICMSST_Produto_GARE := 0;
          N23_VFCPST_Produto_GARE := 0;

          N21_VBCST_Produto_ComDesconto   := 0;
          N23_VICMSST_Produto_ComDesconto := 0;
          N23_VICMSST_Produto_ComDesconto_GARE := 0;
          N23_VFCPST_Produto_ComDesconto_GARE := 0;

          recDetCal.strMemCalGNRE_IPIComDesconto_GARE := '';
          recDetCal.strMemCalGNRE_Produto_GARE := '';
          recDetCal.strMemCalGNRE_Produto_ComDesconto_GARE := '';
          recDetCal.strMemCalGNRE_Produto_ComIPI_GARE := '';
          recDetCal.strMemCalGNRE := '';

          If CalculoBaseSubstituicaoXML = tcbsProdutosSemIPI Then
            recDetCal.N21_VBCST   := fFormataFloat(((((recDetCal.O10_VBC * fltPeBaST) / 100) + recDetCal.O14_VIPI) * fltABF_IVA_ST), 2)
          Else
            recDetCal.N21_VBCST   := fFormataFloat(((((recDetCal.O14_VIPI + recDetCal.O10_VBC) * fltPeBaST) / 100) * fltABF_IVA_ST), 2);
          N23_VICMSST := fRetornaValRet(strEmpEst, N21_VBCST, fltValIcm, fltAliSte);
          N23_VICMSST_GARE := fRetornaValRet(strEmpEst, N21_VBCST, fltValIcm, fltAliSteCargaMedia);

          recDetCal.strMemCalGNRE := 'Valor GNRE = ((Base Calc. ICMS ST (' + FormatFloat('#,##0.00', recDetCal.N21_VBCST) + ') * Alíq. ST (' +
                            FormatFloat('#,##0.00', fltAliSteCargaMedia) + ') ) / 100) - Valor ICMS (' +
                            FormatFloat('#,##0.00', fltValIcm) + ') - Vr. Subst. XML (' +
                            FormatFloat('#,##0.00', recDetEle.N23_VICMSST) + ')';
          recDetCal.N23_VFCPST_GARE := fRetornaValFCPRet(N21_VBCST_IPIComDesconto, fltAliFCP);

          If CalculoBaseSubstituicaoXML = tcbsProdutosSemIPI Then
            N21_VBCST_IPIComDesconto   := fFormataFloat(((((O10_VBC * fltPeBaST) / 100) + O14_VIPI_ComDesconto) * fltABF_IVA_ST), 2)
          Else
            N21_VBCST_IPIComDesconto   := fFormataFloat(((((O14_VIPI_ComDesconto + O10_VBC) * fltPeBaST) / 100) * fltABF_IVA_ST), 2);

          N23_VICMSST_IPIComDesconto := fRetornaValRet(strEmpEst, N21_VBCST_IPIComDesconto, fltValIcm, fltAliSte);
          N23_VICMSST_IPIComDesconto_GARE := fRetornaValRet(strEmpEst, N21_VBCST_IPIComDesconto, fltValIcm, fltAliSteCargaMedia);

          recDetCal.strMemCalGNRE_IPIComDesconto_GARE := 'Valor GNRE = ((Base ST com IPI e Desconto (' + FormatFloat('#,##0.00', N21_VBCST_IPIComDesconto) +
                                   ') * Alíq. ST Carga Média (' + FormatFloat('#,##0.00', fltAliSteCargaMedia) + ') ) / 100) - Valor ICMS (' +
                                   FormatFloat('#,##0.00', fltValIcm) + ') - Vr. Subst. XML (' +
                                   FormatFloat('#,##0.00', recDetEle.N23_VICMSST) + ')';
          N23_VFCPST_IPIComDesconto_GARE := fRetornaValFCPRet(N21_VBCST_IPIComDesconto, fltAliFCP);

          // 3) BASE_ST = ( vr.produto + IPI ) x IVA                   ( ex: ( 1050,00 + 52,50 ) x 1.8337 = 2021,65 )
          If CalculoBaseSubstituicaoXML = tcbsProdutosSemIPI Then
            N21_VBCST_Produto_ComIPI   := fFormataFloat((((((O10_VBC + fDescontoXML(FGerEle, recDetCal)) * fltPeBaST) / 100) + O14_VIPI) * fltABF_IVA_ST), 2)
          Else
            N21_VBCST_Produto_ComIPI   := fFormataFloat(((((O14_VIPI + O10_VBC + fDescontoXML(FGerEle, recDetCal)) * fltPeBaST) / 100) * fltABF_IVA_ST), 2);
          N23_VICMSST_Produto_ComIPI := fRetornaValRet(strEmpEst, N21_VBCST_Produto_ComIPI, fltValIcm, fltAliSte);
          recDetCal.N23_VICMSST_Produto_ComIPI_GARE := fRetornaValRet(strEmpEst, N21_VBCST_IPIComDesconto, fltValIcm, fltAliSteCargaMedia);

          recDetCal.strMemCalGNRE_Produto_ComIPI_GARE := 'Valor GNRE = ((Base ST Produto + IPI (' + FormatFloat('#,##0.00', N21_VBCST_Produto_ComIPI) +
                                   ') * Alíq. ST Carga Média (' + FormatFloat('#,##0.00', fltAliSteCargaMedia) + ') ) / 100) - Valor ICMS (' +
                                   FormatFloat('#,##0.00', fltValIcm) + ') - Vr. Subst. XML (' +
                                   FormatFloat('#,##0.00', recDetEle.N23_VICMSST) + ')';
          recDetCal.N23_VFCPST_Produto_ComIPI_GARE := fRetornaValFCPRet(N21_VBCST_IPIComDesconto, fltAliFCP);
        End
        Else
        Begin

          If CalculoBaseSubstituicaoXML = tcbsProdutosSemIPI Then
            recDetCal.N21_VBCST   := fFormataFloat(((((recDetCal.O10_VBC * fltPeBaST) / 100) + recDetCal.O14_VIPI) * fltABF_IVA_ST), 2)
          Else
            recDetCal.N21_VBCST   := fFormataFloat(((((recDetCal.O14_VIPI + recDetCal.O10_VBC) * fltPeBaST) / 100) * fltABF_IVA_ST), 2);
          N23_VICMSST := fRetornaValRet(strEmpEst, N21_VBCST, fltValIcm, fltAliSte);
          N23_VICMSST_GARE := fRetornaValRet(strEmpEst, N21_VBCST, fltValIcm, fltAliSteCargaMedia);
          N23_VFCPST_GARE := fRetornaValFCPRet(N21_VBCST, fltAliFCP);

          recDetCal.strMemCalGNRE := 'Valor GNRE = ((Base Calc. ICMS ST (' + FormatFloat('#,##0.00', recDetCal.N21_VBCST) + ') * Alíq. ST (' +
                            FormatFloat('#,##0.00', fltAliSteCargaMedia) + ') ) / 100) - Valor ICMS (' +
                            FormatFloat('#,##0.00', fltValIcm) + ') - Vr. Subst. XML (' +
                            FormatFloat('#,##0.00', recDetEle.N23_VICMSST) + ')';
          blnValidarApenasDescontoBaseST := (fCfgSis('VALAPD', varBoolean) and blnSimPau);

          If Not blnValidarApenasDescontoBaseST Then
          Begin
            If CalculoBaseSubstituicaoXML = tcbsProdutosSemIPI Then
              N21_VBCST_IPIComDesconto   := fFormataFloat(((((O10_VBC * fltPeBaST) / 100) + O14_VIPI_ComDesconto) * fltABF_IVA_ST), 2)
            Else
              N21_VBCST_IPIComDesconto   := fFormataFloat(((((O14_VIPI_ComDesconto + O10_VBC) * fltPeBaST) / 100) * fltABF_IVA_ST), 2);
            N23_VICMSST_IPIComDesconto := fRetornaValRet(strEmpEst, N21_VBCST_IPIComDesconto, fltValIcm, fltAliSte);
            N23_VICMSST_IPIComDesconto_GARE := fRetornaValRet(strEmpEst, N21_VBCST_IPIComDesconto, fltValIcm, fltAliSteCargaMedia);

            recDetCal.strMemCalGNRE_IPIComDesconto_GARE := 'Valor GNRE = ((Base ST com IPI e Desconto (' + FormatFloat('#,##0.00', N21_VBCST_IPIComDesconto) +
                                   ') * Alíq. ST Carga Média (' + FormatFloat('#,##0.00', fltAliSteCargaMedia) + ') ) / 100) - Valor ICMS (' +
                                   FormatFloat('#,##0.00', fltValIcm) + ') - Vr. Subst. XML (' +
                                   FormatFloat('#,##0.00', recDetEle.N23_VICMSST) + ')';
            N23_VFCPST_IPIComDesconto_GARE := fRetornaValFCPRet(N21_VBCST_IPIComDesconto, fltAliFCP);

          // 1) BASE_ST = vr.produto x IVA                             ( ex: 1050,00 x 1.8337 = 1925,39 )
            N21_VBCST_Produto   := fFormataFloat(((((O10_VBC + fDescontoXML(FGerEle, recDetCal)) * fltPeBaST) / 100) *
                                      fltABF_IVA_ST), 2);
            N23_VICMSST_Produto := fRetornaValRet(strEmpEst, N21_VBCST_Produto, fltValIcm, fltAliSte);
            N23_VICMSST_Produto_GARE := fRetornaValRet(strEmpEst, N21_VBCST_IPIComDesconto, fltValIcm, fltAliSteCargaMedia);

            recDetCal.strMemCalGNRE_Produto_GARE := 'Valor GNRE = ((Base ST Produto s/ IPI (' + FormatFloat('#,##0.00', N21_VBCST_IPIComDesconto) +
                                ') * Alíq. ST Carga Média (' + FormatFloat('#,##0.00', fltAliSteCargaMedia) + ') ) / 100) - Valor ICMS (' +
                                FormatFloat('#,##0.00', fltValIcm) + ') - Vr. Subst. XML (' +
                                FormatFloat('#,##0.00', recDetEle.N23_VICMSST) + ')';

            N23_VFCPST_Produto_GARE := fRetornaValFCPRet(N21_VBCST_IPIComDesconto, fltAliFCP);

          // 2) BASE_ST = ( vr.produto - desconto ) x IVA              ( ex: 1050,00 - 52,50 = 997,50 x 1.8337 = 1829,12 )
            N21_VBCST_Produto_ComDesconto   := fFormataFloat(((((O10_VBC) * fltPeBaST) / 100) *
                                                    fltABF_IVA_ST), 2);
            N23_VICMSST_Produto_ComDesconto := fRetornaValRet(strEmpEst, N21_VBCST_Produto_ComDesconto, fltValIcm, fltAliSte);
            N23_VICMSST_Produto_ComDesconto_GARE := fRetornaValRet(strEmpEst, N21_VBCST_IPIComDesconto, fltValIcm, fltAliSteCargaMedia);

            recDetCal.strMemCalGNRE_Produto_ComDesconto_GARE := 'Valor GNRE = ((Base ST Produto com Desconto (' + FormatFloat('#,##0.00', N21_VBCST_Produto_ComDesconto) +
                                        ') * Alíq. ST Carga Média (' + FormatFloat('#,##0.00', fltAliSteCargaMedia) + ') ) / 100) - Valor ICMS (' +
                                        FormatFloat('#,##0.00', fltValIcm) + ') - Vr. Subst. XML (' +
                                        FormatFloat('#,##0.00', recDetEle.N23_VICMSST) + ')';

            N23_VFCPST_Produto_ComDesconto_GARE := fRetornaValFCPRet(N21_VBCST_IPIComDesconto, fltAliFCP);

          // 3) BASE_ST = ( vr.produto + IPI ) x IVA                   ( ex: ( 1050,00 + 52,50 ) x 1.8337 = 2021,65 )
            If CalculoBaseSubstituicaoXML = tcbsProdutosSemIPI Then
              N21_VBCST_Produto_ComIPI   := fFormataFloat((((((O10_VBC + fDescontoXML(FGerEle, recDetCal)) * fltPeBaST) / 100) + O14_VIPI) * fltABF_IVA_ST), 2)
            Else
              N21_VBCST_Produto_ComIPI   := fFormataFloat(((((O14_VIPI + O10_VBC + fDescontoXML(FGerEle, recDetCal)) * fltPeBaST) / 100) * fltABF_IVA_ST), 2);
            N23_VICMSST_Produto_ComIPI := fRetornaValRet(strEmpEst, N21_VBCST_Produto_ComIPI, fltValIcm, fltAliSte);
            recDetCal.N23_VICMSST_Produto_ComIPI_GARE := fRetornaValRet(strEmpEst, N21_VBCST_IPIComDesconto, fltValIcm, fltAliSteCargaMedia);

            recDetCal.strMemCalGNRE_Produto_ComIPI_GARE := 'Valor GNRE = ((Base ST Produto + IPI (' + FormatFloat('#,##0.00', N21_VBCST_Produto_ComIPI) +
                                   ') * Alíq. ST Carga Média (' + FormatFloat('#,##0.00', fltAliSteCargaMedia) + ') ) / 100) - Valor ICMS (' +
                                   FormatFloat('#,##0.00', fltValIcm) + ') - Vr. Subst. XML (' +
                                   FormatFloat('#,##0.00', recDetEle.N23_VICMSST) + ')';

            recDetCal.N23_VFCPST_Produto_ComIPI_GARE := fRetornaValRet(strEmpEst, N21_VBCST_IPIComDesconto, fltValIcm, fltAliFCP);
          End;
        End;
      End;

      If blnSimPau Then
      Begin
        fltBasIcm := 0.0;
        fltAlqIcm := 0.0;
        fltValIcm := 0.0;
      End;

      N15_VBC     := fltBasIcm;
      N16_PICMS   := fltAlqIcm;
      N17_VICMS   := fltValIcm;

      If blnValidaPisCofins {And (fDadosFornec('MATREV') = 'I') }Then
      Begin
        fltDesAce := recDetEle.I17A_VOUTRO + recDetEle.I16_VSEG;
        fltDesEsp := fDescontoXML(recGerEle, recDetEle);

        tmp := TCalculoPisCofins.Create;


        strSitP_C := fDefineSit_P_C(VS_strCodEmp, fDadosFornec('CODFOR'));

        CalcResult := tmp.fCalculoPisCofins(VS_strCodEmp,
                                            String(DET_CODITE),
                                            strClaFis,
                                            strCodFis,
                                            fDadosFornec('CODFOR'),
                                            IIf(blnSimPau and blnIGNSIM, 'S', 'N'),
                                            recGerEle.X28_ESP,
                                            I11_VPROD,
                                            fltDesEsp,
                                            O14_VIPI,
                                            N23_VICMSST,
                                            I15_VFRETE,
                                            fltDesAce,
                                            fltValIcm,
                                            0,
                                            'F',
                                            IIf(fIncidePis(String(DET_CODITE)), 'S', 'N'),
                                            strSitP_C,
                                            '' ,
                                            fNow,
                                            '',
                                            False,
                                            False,
                                            '',
                                            '',
                                            '',
                                            '',
                                            False,
                                            String(recDetEle.DET_CSTXML),
                                            recDetEle.N17_VICMS,
                                            String(recDetEle.Q06_CST),
                                            String(recDetEle.S06_CST),
                                            recDetEle.Q09_VPIS,
                                            recDetEle.S11_VCOFINS);

        Q06_CST     := ShortString(CalcResult.strCstPis);
        Q07_VBC     := CalcResult.dblBasePis;
        Q08_PPIS    := CalcResult.dblAlqPis;
        Q09_VPIS    := CalcResult.dblValorPis;

        S06_CST     := ShortString(CalcResult.strCstCof);
        S07_VBC     := CalcResult.dblBaseCof;
        S08_PCOFINS := CalcResult.dblAlqCof;
        S11_VCOFINS := CalcResult.dblValorCof;

        tmp.Destroy;
      End;
    End;
  End;
End;

procedure TNFeXml.pCarregaNotGer;
var intCont: integer;
begin
  qryNotGer := fCriaQuery;
  intCont := Length(fCfgSis('SERFSC', varString));
  qryNotGer.SQL.Add('SET @SEQ := 0;');
  qryNotGer.SQL.Add('SELECT @SEQ := @SEQ + 1 AS SEQ,  T.* FROM NOTGER G');
  qryNotGer.SQL.Add('INNER JOIN NOTDET D ON D.DET_SEQGER = G.AUTOINCREM');
  qryNotGer.SQL.Add('INNER JOIN NOTTRI T ON T.DET_SEQGER = D.AUTOINCREM');
  qryNotGer.SQL.Add(' WHERE GER_NUMDOC = "'+String(FGerEle.B08_NNF)+'"');
  qryNotGer.SQL.Add('   AND GER_ESPDOC = "NF"');
  qryNotGer.SQL.Add('   AND GER_CODEMP = "'+VS_StrCodEmp+'"');
  qryNotGer.SQL.Add('   AND GER_SERIE_ = "'+RightStr(fStrZero('0', intCont) + String(FGerEle.B07_SERIE), intCont)+'"');
  qryNotGer.SQL.Add('   AND  GER_CODFOR = "'+String(FGerEle.GER_CODFOR)+'"');
  qryNotGer.Open;
end;

Function TNFeXml.fComparaValores(var recDetEle: TRecDetEle; Var recDetCal: TRecDetEle; Var recDiferencas: TRecDiferencas): Boolean;
Var
  fltDifDados, fltFCPST: Double;
  recItem : TRecItem;
Begin
  Result := True;

  With recDiferencas Do
  Begin
    strCodSit := 'N';
    strBasSub := 'N';
    strFatIVa := 'N';
    strValSub := 'N';
    strBasIcm := 'N';
    strAlqIcm := 'N';
    strValIcm := 'N';
    strBasIpi := 'N';
    strAlqIpi := 'N';
    strValIpi := 'N';
    strPISCST := 'N';
    strPISVBC := 'N';
    strPISPPIS := 'N';
    strPISVPIS := 'N';

    strCOFCST := 'N';
    strCOFVBC := 'N';
    strCOFPCOFINS := 'N';
    strCOFVCOFINS := 'N';

    strpFCPST := 'N';
    strvFCPST := 'N';

    fltValGnr := 0;
    fltST_Cal := 0;
    fltST_XML := 0;

    If FGerEle.NfeAjuste then
      Exit;

    // BASE DE ICMS
    If RoundTo(recDetEle.N15_VBC, -2) <> RoundTo(recDetCal.N15_VBC, -2) Then
    Begin
      strBasIcm := 'S';

      If Abs(RoundTo(recDetEle.N15_VBC, -2) - RoundTo(recDetCal.N15_VBC, -2)) <= fltTolerancia Then
        strBasIcm := 'A';

      Result := False;
    End;

    // ALIQUOTA DE ICMS
    If RoundTo(recDetEle.N16_PICMS, -2) <> RoundTo(recDetCal.N16_PICMS, -2) Then
    Begin
      strAlqIcm := 'S';

      Result := False;
    End;

    // VALOR DE ICMS
    If RoundTo(recDetEle.N17_VICMS, -2) <> RoundTo(recDetCal.N17_VICMS, -2) Then
    Begin
      strValIcm := 'S';

      If Abs(RoundTo(recDetEle.N17_VICMS, -2) - RoundTo(recDetCal.N17_VICMS, -2)) <= fltTolerancia Then
        strValIcm := 'A';

      Result := False;
    End;

    If FValEle Then
    Begin
      recItem := fCarregaCadIte(String(recDetEle.DET_CODITE),
                                String(FGerEle.GER_CODEMP),
                                String(FGerEle.GER_CODFOR),
                                String(FGerEle.GER_CODCLI));

      fltFCPST := RoundTo(recDetEle.N23A_VBCFCPST * (recItem.fltPFCPST / 100), -2);
      // ALIQUOTA FCPST
      If RoundTo(recDetEle.N23B_PFCPST, -2) <> RoundTo(recItem.fltPFCPST, -2) Then
      Begin
        strpFCPST := 'S';

        Result := False;
      End;

      // VALOR FCPST
      If RoundTo(recDetEle.N23D_FCPST, -2) <> RoundTo(fltFCPST, -2) Then
      Begin
        strvFCPST := 'S';

        If Abs(RoundTo(recDetEle.N23D_FCPST, -2) - RoundTo(fltFCPST, -2)) <= fltTolerancia Then
          strvFCPST := 'A';

        Result := False;
      End;
    End;

    // VALOR DE IPI
    If RoundTo(recDetEle.O14_VIPI, -2) <> RoundTo(recDetCal.O14_VIPI, -2) Then
    Begin
       fltDifDados := Abs(RoundTo(recDetEle.O14_VIPI, -2) - RoundTo(recDetCal.O14_VIPI, -2));

       If RoundTo(recDetEle.O14_VIPI, -2) <> RoundTo(recDetCal.O14_VIPI_ComDesconto, -2) Then
       Begin

         If Abs(RoundTo(recDetEle.O14_VIPI, -2) - RoundTo(recDetCal.O14_VIPI_ComDesconto, -2)) < fltDifDados Then
         Begin
           recDetCal.fltBasIPI := recDetCal.fltBasIPI_ComDesconto;
           recDetCal.O14_VIPI  := recDetCal.O14_VIPI_ComDesconto;
         End;

         strValIpi := 'S';

         If Abs(RoundTo(recDetEle.O14_VIPI, -2) - RoundTo(recDetCal.O14_VIPI, -2)) <= fltTolerancia Then
           strValIpi := 'A';

         Result := False;
       End Else
       Begin
         recDetCal.fltBasIPI := recDetCal.fltBasIPI_ComDesconto;
         recDetCal.O14_VIPI  := recDetCal.O14_VIPI_ComDesconto;
       End;

    End;

    // BASE DE IPI
    If (RoundTo(recDetEle.O10_VBC, -2) <> RoundTo(recDetCal.fltBasIPI, -2)) And
       (RoundTo(recDetEle.O14_VIPI, -2) <> RoundTo(recDetCal.O14_VIPI, -2)) Then
    Begin
      strBasIpi := 'S';

      If Abs(RoundTo(recDetEle.O10_VBC, -2) - RoundTo(recDetCal.fltBasIPI, -2)) <= fltTolerancia Then
        strBasIpi := 'A';

      Result := False;
    End;

    // ALIQUOTA DE IPI
    If RoundTo(recDetEle.O13_PIPI, -2) <> RoundTo(recDetCal.O13_PIPI, -2) Then
    Begin
      strAlqIpi := 'S';

      If strValIpi = 'A'Then
        strAlqIpi := 'A';

      Result := False;
    End;

    // VALOR DE SUBSTITUICAO
    recDetCal.DET_CALSTU := TipoCalculoSTGareImportacaoXMLToInt(tcsgiPadrao);
    If RoundTo(recDetEle.N23_VICMSST, -2) <> RoundTo(recDetCal.N23_VICMSST, -2) Then
    Begin
      fltDifDados := Abs(RoundTo(recDetEle.N23_VICMSST, -2) - RoundTo(recDetCal.N23_VICMSST, -2));

      If (RoundTo(recDetEle.N23_VICMSST, -2) <> 0) And (RoundTo(recDetEle.N23_VICMSST, -2) <> RoundTo(recDetCal.N23_VICMSST_IPIComDesconto, -2)) Then
      Begin

        If Abs(RoundTo(recDetEle.N23_VICMSST, -2) - RoundTo(recDetCal.N23_VICMSST_IPIComDesconto, -2)) < fltDifDados Then
        Begin
          recDetCal.N23_VICMSST := recDetCal.N23_VICMSST_IPIComDesconto;
          recDetCal.DET_CALSTU := TipoCalculoSTGareImportacaoXMLToInt(tcsgiIPIComDesconto);
          recDetCal.N23_VICMSST_GARE := recDetCal.N23_VICMSST_IPIComDesconto_GARE;
          recDetCal.strMemCalGNRE := recDetCal.strMemCalGNRE_IPIComDesconto_GARE;
          recDetCal.N23_VFCPST_GARE := recDetCal.N23_VFCPST_IPIComDesconto_GARE;
          recDetCal.N21_VBCST   := recDetCal.N21_VBCST_IPIComDesconto;

          fltDifDados := Abs(RoundTo(recDetEle.N23_VICMSST, -2) - RoundTo(recDetCal.N23_VICMSST_IPIComDesconto, -2));
        End;

        If RoundTo(recDetEle.N23_VICMSST, -2) <> RoundTo(recDetCal.N23_VICMSST_Produto, -2) Then
        Begin

          If Abs(RoundTo(recDetEle.N23_VICMSST, -2) - RoundTo(recDetCal.N23_VICMSST_Produto, -2)) < fltDifDados Then
          Begin
            recDetCal.N23_VICMSST := recDetCal.N23_VICMSST_Produto;
            recDetCal.N23_VICMSST_GARE := recDetCal.N23_VICMSST_Produto_GARE;
            recDetCal.strMemCalGNRE := recDetCal.strMemCalGNRE_Produto_GARE;
            recDetCal.N23_VFCPST_GARE := recDetCal.N23_VFCPST_Produto_GARE;
            recDetCal.DET_CALSTU := TipoCalculoSTGareImportacaoXMLToInt(tcsgiProduto);

            recDetCal.N21_VBCST   := recDetCal.N21_VBCST_Produto;

            fltDifDados := Abs(RoundTo(recDetEle.N23_VICMSST, -2) - RoundTo(recDetCal.N23_VICMSST_Produto, -2));
          End;

          If RoundTo(recDetEle.N23_VICMSST, -2) <> RoundTo(recDetCal.N23_VICMSST_Produto_ComDesconto, -2) Then
          Begin

            If Abs(RoundTo(recDetEle.N23_VICMSST, -2) - RoundTo(recDetCal.N23_VICMSST_Produto_ComDesconto, -2)) < fltDifDados Then
            Begin
              recDetCal.N23_VICMSST := recDetCal.N23_VICMSST_Produto_ComDesconto;
              recDetCal.N23_VICMSST_GARE := recDetCal.N23_VICMSST_Produto_ComDesconto_GARE;
              recDetCal.strMemCalGNRE := recDetCal.strMemCalGNRE_Produto_ComDesconto_GARE;
              recDetCal.N23_VFCPST_GARE := recDetCal.N23_VFCPST_Produto_ComDesconto_GARE;
              recDetCal.DET_CALSTU := TipoCalculoSTGareImportacaoXMLToInt(tcsgiProduto_ComDesconto);
              recDetCal.N21_VBCST   := recDetCal.N21_VBCST_Produto_ComDesconto;

              fltDifDados := Abs(RoundTo(recDetEle.N23_VICMSST, -2) - RoundTo(recDetCal.N23_VICMSST_Produto_ComDesconto, -2));
            End;

            If RoundTo(recDetEle.N23_VICMSST, -2) <> RoundTo(recDetCal.N23_VICMSST_Produto_ComIPI, -2) Then
            Begin

              If Abs(RoundTo(recDetEle.N23_VICMSST, -2) - RoundTo(recDetCal.N23_VICMSST_Produto_ComIPI, -2)) < fltDifDados Then
              Begin
                recDetCal.N23_VICMSST := recDetCal.N23_VICMSST_Produto_ComIPI;
                recDetCal.N23_VICMSST_GARE := recDetCal.N23_VICMSST_Produto_ComIPI_GARE;
                recDetCal.strMemCalGNRE := recDetCal.strMemCalGNRE_Produto_ComIPI_GARE;
                recDetCal.N23_VFCPST_GARE := recDetCal.N23_VFCPST_Produto_ComIPI_GARE;
                recDetCal.DET_CALSTU := TipoCalculoSTGareImportacaoXMLToInt(tcsgiProduto_ComIPI);

                recDetCal.N21_VBCST   := recDetCal.N21_VBCST_Produto_ComIPI;
              End;

              strValSub := 'S';

              If Abs(RoundTo(recDetEle.N23_VICMSST, -2) - RoundTo(recDetCal.N23_VICMSST, -2)) <= fltTolerancia Then
                strValSub := 'A';

              Result := False;
            End Else
            Begin
              recDetCal.N23_VICMSST := recDetCal.N23_VICMSST_Produto_ComIPI;
              recDetCal.N23_VICMSST_GARE := recDetCal.N23_VICMSST_Produto_ComIPI_GARE;
              recDetCal.strMemCalGNRE := recDetCal.strMemCalGNRE_Produto_ComIPI_GARE;
              recDetCal.N23_VFCPST_GARE := recDetCal.N23_VFCPST_Produto_ComIPI_GARE;
              recDetCal.DET_CALSTU := TipoCalculoSTGareImportacaoXMLToInt(tcsgiProduto_ComIPI);
              recDetCal.N21_VBCST   := recDetCal.N21_VBCST_Produto_ComIPI;
            End;

          End Else
          Begin
            recDetCal.N23_VICMSST := recDetCal.N23_VICMSST_Produto_ComDesconto;
            recDetCal.N23_VICMSST_GARE := recDetCal.N23_VICMSST_Produto_ComDesconto_GARE;
            recDetCal.strMemCalGNRE := recDetCal.strMemCalGNRE_Produto_ComDesconto_GARE;
            recDetCal.N23_VFCPST_GARE := recDetCal.N23_VFCPST_Produto_ComDesconto_GARE;
            recDetCal.DET_CALSTU := TipoCalculoSTGareImportacaoXMLToInt(tcsgiProduto_ComDesconto);
            recDetCal.N21_VBCST   := recDetCal.N21_VBCST_Produto_ComDesconto;
          End;

        End Else
        Begin
          recDetCal.N23_VICMSST := recDetCal.N23_VICMSST_Produto;
          recDetCal.N23_VICMSST_GARE := recDetCal.N23_VICMSST_Produto_GARE;
          recDetCal.strMemCalGNRE := recDetCal.strMemCalGNRE_Produto_GARE;
          recDetCal.N23_VFCPST_GARE := recDetCal.N23_VFCPST_Produto_GARE;
          recDetCal.DET_CALSTU := TipoCalculoSTGareImportacaoXMLToInt(tcsgiProduto);
          recDetCal.N21_VBCST   := recDetCal.N21_VBCST_Produto;
        End;

      End Else
      Begin
        recDetCal.N23_VICMSST := recDetCal.N23_VICMSST_IPIComDesconto;
        recDetCal.N23_VICMSST_GARE := recDetCal.N23_VICMSST_IPIComDesconto_GARE;
        recDetCal.strMemCalGNRE := recDetCal.strMemCalGNRE_IPIComDesconto_GARE;
        recDetCal.N23_VFCPST_GARE := recDetCal.N23_VFCPST_IPIComDesconto_GARE;
        recDetCal.DET_CALSTU := TipoCalculoSTGareImportacaoXMLToInt(tcsgiIPIComDesconto);
        recDetCal.N21_VBCST   := recDetCal.N21_VBCST_IPIComDesconto;
      End;

      If recDetEle.N23_VICMSST <> recDetCal.N23_VICMSST Then
      Begin
        strValSub := 'S';
        If Abs(RoundTo(recDetEle.N23_VICMSST, -2) - RoundTo(recDetCal.N23_VICMSST, -2)) <= fltTolerancia Then
          strValSub := 'A';
      End;

      recDiferencas.fltValGnr := RoundTo(recDetCal.N23_VICMSST_GARE, -2) - RoundTo(recDetEle.N23_VICMSST, -2);

      If blnIFCPST Then
      Begin
        recDiferencas.fltValGnr := recDiferencas.fltValGnr +
          RoundTo(recDetCal.N23_VFCPST_GARE, -2) -
          RoundTo(recDetEle.N23D_FCPST, -2);
        recDetCal.strMemCalGNRE  := recDetCal.strMemCalGNRE +
                                ' + Vr. FCP ST (' +
                                  FormatFloat('#,##0.00', recDetCal.N23_VFCPST_GARE - recDetEle.N23D_FCPST) +
                                ')';
      End;

      If (Not fEmptyStr(recDetCal.strMemCalGNRE)) And (recDetCal.strMemCalGNRE <> MSG_VLR_GNR_MANUAL) Then
        recDetCal.strMemCalGNRE := recDetCal.strMemCalGNRE + ' = ' + FormatFloat('#,##0.00', recDiferencas.fltValGnr);

      recDiferencas.strMemCalGNRE := recDetCal.strMemCalGNRE;

      recDiferencas.fltST_Cal := RoundTo(recDetCal.N23_VICMSST_GARE, -2);
      recDiferencas.fltST_XML := RoundTo(recDetEle.N23_VICMSST, -2);
      If recDiferencas.fltValGnr < 0 Then
      Begin
        recDiferencas.fltValGnr := 0;
        recDetCal.strMemCalGNRE := '';
      End
      Else
        recDetEle.DET_BASSUB := recDetCal.N21_VBCST;
    End;

    // BASE DA SUBSTITUICAO
    If (RoundTo(recDetEle.N21_VBCST, -2) <> RoundTo(recDetCal.N21_VBCST, -2)) And
       (RoundTo(recDetEle.N23_VICMSST, -2) <> RoundTo(recDetCal.N23_VICMSST, -2)) Then
    Begin
      strBasSub := 'S';

      If Abs(RoundTo(recDetEle.N21_VBCST, -2) - RoundTo(recDetCal.N21_VBCST, -2)) <= fltTolerancia Then
        strBasSub := 'A';

      Result := False;
    End;

  // VALOR IVA
    If (RoundTo(recDetEle.N19_PMVAST, -4) <> RoundTo(recDetCal.N19_PMVAST, -4)) And
       (RoundTo(recDetEle.N23_VICMSST, -2) <> RoundTo(recDetCal.N23_VICMSST, -2)) Then
    Begin
      strFatIVa := 'S';

      Result := False;
    End;

    // CODIGO CST
    If recDetEle.DET_CSTXML <> recDetCal.DET_CSTXML Then
    Begin
      strCodSit := 'S';
      FDivCST   := True;
      Result    := False;
    End;


    If blnValidaPisCofins Then
    Begin
      //PIS
      If recDetEle.Q06_CST <> recDetCal.Q06_CST  Then
      Begin
        strPISCST := 'S';
        Result    := False;
      End;

      If RoundTo(recDetEle.Q07_VBC, -2) <> RoundTo(recDetCal.Q07_VBC, -2) Then
      Begin
        strPISVBC := 'S';
        If Abs(RoundTo(recDetEle.Q07_VBC, -2) - RoundTo(recDetCal.Q07_VBC, -2)) <= fltTolerancia Then
          strPISVBC := 'A';
        Result    := False;
      End;
      If recDetEle.Q08_PPIS <> recDetCal.Q08_PPIS Then
      Begin
        strPISPPIS := 'S';
        Result    := False;
      End;

      If RoundTo(recDetEle.Q09_VPIS, -2) <> RoundTo(recDetCal.Q09_VPIS, -2) Then
      Begin
        strPISVPIS := 'S';
        If Abs(RoundTo(recDetEle.Q09_VPIS, -2) - RoundTo(recDetCal.Q09_VPIS, -2)) <= fltTolerancia Then
          strPISVPIS := 'A';
        Result    := False;
      End;

      //COFINS}
      If recDetEle.S06_CST <> recDetCal.S06_CST Then
      begin
        strCOFCST := 'S';
        Result := False;
      End;
      If RoundTo(recDetEle.S07_VBC, -2) <> RoundTo(recDetCal.S07_VBC, -2) Then
      Begin
        strCOFVBC := 'S';
        If Abs(RoundTo(recDetEle.S07_VBC, -2) - RoundTo(recDetCal.S07_VBC, -2)) <= fltTolerancia Then
          strCOFVBC := 'A';
        Result := False;
      End;
      If recDetEle.S08_PCOFINS <> recDetCal.S08_PCOFINS Then
      Begin
        strCOFPCOFINS := 'S';
        Result := False;
      End;
      If RoundTo(recDetEle.S11_VCOFINS, -2) <> RoundTo(recDetCal.S11_VCOFINS, -2) Then
      Begin
        strCOFVCOFINS := 'S';
        If Abs(RoundTo(recDetEle.S11_VCOFINS, -2) - RoundTo(recDetCal.S11_VCOFINS, -2)) <= fltTolerancia Then
          strCOFVCOFINS := 'A';
        Result := False;
      End;
    End;
  End;

  recDetEle.CAL_VLICMS := recDetCal.N17_VICMS;
  recDetEle.CAL_BASICM := recDetCal.N15_VBC;
  recDetEle.CAL_ALQICM := recDetCal.N16_PICMS;

  recDetEle.CAL_BAS_ST := recDetCal.N21_VBCST;
  recDetEle.CAL_VR_IVA := 1 + recDetCal.N19_PMVAST / 100;
  recDetEle.CAL_VR_SUB := recDetCal.N23_VICMSST;
  recDetEle.CAL_ALQINT := recDetCal.CAL_ALQINT;
  recDetEle.DET_CALSTU := recDetCal.DET_CALSTU;
  recDetEle.N23_VFCPST_GARE := recDetCal.N23_VFCPST_GARE;
  recDetEle.strMemCalGNRE := recDetCal.strMemCalGNRE;
End;

Function TNFeXml.fCalculaCSTXML(recDetEle: TRecDetEle; strCSTCad: String): String;
Begin
  With recDetEle Do
  Begin
    If fEmptyStr(String(N12_CSOSN)) Then
      Result := String(N11_ORIG + N12_CST)
    Else
      Result := fN12_CSOSNToCodFis(String(N12_CSOSN), String(N11_ORIG), strCSTCad);
  End;
End;

function TNFeXml.fValidarCSTSimplesConversao(strCodFisNota, strCodFisCad: string): boolean;
Begin
  Result := False;

  strCodFisCad :=  RightStr(strCodFisCad, 2);

  If Pos(strCodFisNota, '_201_202_500') > 0 Then
    Result := Pos(strCodFisCad, '_60_10_70') > 0

  Else If Pos(strCodFisNota, '_101_102') >  0 Then
    Result := strCodFisCad = '00';
End;

function TNFeXml.fValidaSerie(var AStrSerie: String): Boolean;
var
  qryAux: TUniQuery;
  intCont: Integer;
begin
  qryAux := fCriaQuery;
  intCont := Length(fCfgSis('SERFSC', varString));
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT GER_SERIE_ FROM NOTGER ');
    qryAux.SQL.Add(' WHERE                        ');
    qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND    ');
    qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND    ');
    qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND    ');
    qryAux.SQL.Add('  GER_SERIE_ = :SERIE_ AND    ');
    qryAux.SQL.Add('  GER_CODFOR = :CODFOR        ');
    qryAux.ParamByName('NUMDOC').AsString := String(FGerEle.B08_NNF);
    qryAux.ParamByName('ESPDOC').AsString := 'NF';
    qryAux.ParamByName('CODEMP').AsString := VS_StrCodEmp;
    qryAux.ParamByName('SERIE_').AsString := RightStr(fStrZero('0', intCont) + String(FGerEle.B07_SERIE), intCont);
    qryAux.ParamByName('CODFOR').AsString := String(FGerEle.GER_CODFOR);
    qryAux.Open;

    Result := Not qryAux.isEmpty;

    If Result Then
      AStrSerie := qryAux.FieldByName('GER_SERIE_').AsString;

  Finally
    FreeAndNil(qryAux);
  End;
end;

Class Function TNFeXml.fGetStatusXML(strChave: String; strCodEmp: String): TStatusNFeXml;
var
  strStatus: String;
begin
  strStatus := fConsultaStatusDFe(strChave, '', '', strCodEmp, '', '', '');
  if strStatus = 'Autorizada' then
    Result := stXMLAutorizada
  else if strStatus <> '' then
    Result := stXMLCancelada
  else
    Result := stXMLIndefinido;
end;

function TNFeXml.fXmlCancelamento(xmlDoc: TXMLDocument): Boolean;
var
  nodProcEventoNFe,
  nodEvento,
  nodInfEvento,
  nodDetEvento : IXMLNode;
  strChaveCancelada,
  strTipoEvento: String;
begin
 {Códigos dos Eventos
  110111 – “Cancelamento”
  110112 – “Cancelamento por substituição”}
  With xmlDoc Do
  Begin
    Result := False;
    nodProcEventoNFe := Node.ChildNodes.FindNode('procEventoNFe');
    If Assigned(nodProcEventoNFe) Then
    Begin
      nodEvento := nodProcEventoNFe.ChildNodes.FindNode('evento');
      If Assigned(nodEvento) Then
      Begin
        nodInfEvento := nodEvento.ChildNodes.FindNode('infEvento');
        If Assigned(nodInfEvento) Then
        Begin
          nodDetEvento := nodInfEvento.ChildNodes.FindNode('detEvento');
          If Assigned(nodDetEvento) Then
          Begin
            strChaveCancelada := fGetValorXml(nodInfEvento, 'chNFe', varString);
            strTipoEvento := fGetValorXml(nodInfEvento, 'tpEvento', varString);

            If Pos(strTipoEvento, '110111_110112') > 0 Then
              Result := True;

            If Result And fExisteNotaEntradaChaveNFE(strChaveCancelada, strDocOriginalCanceladoXML) Then
              blnXMLCancelamento := True
            Else
            Begin
              If Result Then
                blnXMLCancelamentoSemNota := True;

              blnXMLCancelamento := False;
              Result := False;
            End;
          End;
        End;
      End;
    End;
  End;
End;

function TNFeXml.fXmlDevolucaoSemEntrada: Boolean;
var
  intIndex: Integer;
  strChaveDevolucao,
  strNumDoc,
  strSerie_,
  strCodFor,
  strNomFor: String;
begin

  If fGetRetCount > 0 Then
  For intIndex := 0 To fGetRetCount - 1 Do
  Begin
    strChaveDevolucao := getRetornoReferencia[intIndex].strReferenciaNFe
  End;

  If (Not fEmptyStr(strChaveDevolucao)) And (Not fExisteNotaEntradaChaveNFE(strChaveDevolucao, strDocOriginalDevolucaoXML)) Then
  Begin
    Result := True;
    strNumDoc := fStrZero(Copy(strChaveDevolucao, 26, 9), fTamNumDoc);
    strSerie_ := Copy(strChaveDevolucao, 23, 3);
    strCodFor := fRetCodFornecedorPorCnpj(Copy(strChaveDevolucao, 7, 14));
    strNomFor := fRetNomFornecedor(strCodFor);
    strDocOriginalDevolucaoXML := 'NOTA:' + strNumDoc + '-NF SERIE:' + strSerie_ +' FORNECEDOR:' + strCodFor + '-' + strNomFor;
  End
  Else
    Result := False;
end;

Function TNFeXml.fN12_CSOSNToCodFis(strCSOSN, strOrig, strCstCad: String): String;
Begin
  If (Not fEmptyStr(strCstCad)) And fValidarCSTSimplesConversao(strCSOSN, strCstCad) Then
     Result := strCstCad

  Else If Pos(strCSOSN, '201_202_500') > 0 Then
  Begin
    Result := strOrig + '60';
  End
  Else If Pos(strCSOSN, '101_102_900') > 0 Then
  Begin
    Result := strOrig + '00';
  End

  Else If (Pos(strCSOSN, '400_') > 0) And blnSimPau Then
  Begin
    Result := strOrig + '40';
  End

  Else
  Begin
    Result := strOrig + '00';
  End;
End;

procedure TNFeXml.pIncluiInconsistencia(recDetEle: TRecDetEle; strDetEle: String; recDiferencas: TRecDiferencas; intSequencia: integer; recItem: TRecItem);
var
  fltFCPST : Double;
Begin
  With FCdsIncon, recDetEle Do
  Begin
    Insert;

    FieldByName('MOSTRA').AsString := 'S';

    FieldByName('ELETRO').AsString := strDetEle;

    FieldByName('CODFOR').AsString := String(FGerEle.GER_CODFOR);
    FieldByName('NOMFOR').AsString := fDadosFornec('NOMFOR');
    FieldByName('NOMCID').AsString := fDadosFornec('NOMCID');
    FieldByName('ESTADO').AsString := fDadosFornec('ESTFOR');

    FieldByName('FORNEC').AsString := FieldByName('CODFOR').AsString + '-' + FieldByName('NOMFOR').AsString + '  ' +
                                      FieldByName('NOMCID').AsString + '-' + FieldByName('ESTADO').AsString;

    FieldByName('SEQUEN').AsInteger:= intSequencia;

    FieldByName('NUMDOC').AsString := String(FGerEle.B08_NNF);
    FieldByName('CODITE').AsString := String(DET_CODITE);

    recItem := fCarregaCadIte(String(DET_CODITE),
                              String(FGerEle.GER_CODEMP),
                              FieldByName('CODFOR').AsString,
                              '');

    FieldByName('DESITE').AsString := recItem.strDesIte;
    FieldByName('CODFAB').AsString := recItem.strCodFab;
    FieldByName('REFERE').AsString := recItem.strRefere;
    FieldByName('SIGUNI').AsString := recItem.strSigUni;
    FieldByName('CLAIPI').AsString := recItem.strClaIpi;
    FieldByName('CODABF').AsString := recItem.strCodAbf;
    FieldByName('DESABF').AsString := recItem.strDesAbf;

    FieldByName('ABFPIS').AsString := recItem.strAbfPis;
    FieldByName('ABFCOF').AsString := recItem.strAbfCof;

    FieldByName('CLAFIS').AsString := string(I08_CFOP);

    FieldByName('CODSIT').AsString := String(DET_CSTXML);

    FieldByName('FATMVA').AsFloat  := 1 + N19_PMVAST / 100;

    FieldByName('BASICM').AsFloat  := N15_VBC;
    FieldByName('ALQICM').AsFloat  := N16_PICMS;
    FieldByName('VALICM').AsFloat  := N17_VICMS;

    FieldByName('BASSUB').AsFloat  := N21_VBCST;
    FieldByName('VALSUB').AsFloat  := N23_VICMSST;

    FieldByName('PERFOR').AsString := fDadosFornec('PERFOR');
    FieldByName('ABFICM').AsString := recItem.strCodAbf;
    FieldByName('DESABF').AsString := recItem.strDesAbf;

    If O14_VIPI > 0 Then
    Begin
      If fltBasIpi <> 0 Then
        FieldByName('BASIPI').AsFloat  := fltBasIpi
      Else
        FieldByName('BASIPI').AsFloat  := O10_VBC;

      FieldByName('ALQIPI').AsFloat  := O13_PIPI;
      FieldByName('VALIPI').AsFloat  := O14_VIPI;
    End Else
    Begin
      FieldByName('BASIPI').AsFloat  := 0;
      FieldByName('ALQIPI').AsFloat  := 0;
      FieldByName('VALIPI').AsFloat  := 0;
    End;


    FieldByName('PISCST').AsString    := String(Q06_CST);
    FieldByName('PISVBC').ASFloat     := Q07_VBC;
    FieldByName('PISPPIS').ASFloat    := Q08_PPIS;
    FieldByName('PISVPIS').ASFloat    := Q09_VPIS;
    FieldByName('COFCST').AsString    := String(S06_CST);
    FieldByName('COFVBC').ASFloat     := S07_VBC;
    FieldByName('COFPCOFINS').ASFloat := S08_PCOFINS;
    FieldByName('COFVCOFINS').ASFloat := S11_VCOFINS;

    FieldByName('VBCFCPST').ASFloat   := N23A_VBCFCPST;

    fltFCPST := RoundTo(N23A_VBCFCPST * (recItem.fltPFCPST / 100), -2);

    FieldByName('PFCPST').ASFloat     := IIF(strDetEle = 'S', N23B_PFCPST, recItem.fltPFCPST);
    FieldByName('VFCPST').ASFloat     := IIF(strDetEle = 'S', N23D_FCPST, fltFCPST);

    With recDiferencas Do
    Begin
      FieldByName('DIF_CODSIT').AsString := strCodSit;

      FieldByName('DIF_BASICM').AsString := strBasIcm;
      FieldByName('DIF_ALQICM').AsString := strAlqIcm;
      FieldByName('DIF_VALICM').AsString := strValIcm;

      FieldByName('DIF_BASSUB').AsString := strBasSub;
      FieldByName('DIF_VALSUB').AsString := strValSub;
      FieldByName('DIF_FATMVA').AsString := strFatIVa;

      FieldByName('DIF_BASIPI').AsString := strBasIpi;
      FieldByName('DIF_ALQIPI').AsString := strAlqIpi;
      FieldByName('DIF_VALIPI').AsString := strValIpi;

      FieldByName('DIF_PISCST').AsString := strPISCST;
      FieldByName('DIF_PISVBC').AsString := strPISVBC;
      FieldByName('DIF_PISPPIS').AsString := strPISPPIS;
      FieldByName('DIF_PISVPIS').AsString := strPISVPIS;
      FieldByName('DIF_COFCST').AsString := strCOFCST;
      FieldByName('DIF_COFVBC').AsString := strCOFVBC;
      FieldByName('DIF_COFPCOFINS').AsString := strCOFPCOFINS;
      FieldByName('DIF_COFVCOFINS').AsString := strCOFVCOFINS;
      FieldByName('DIF_PFCPST').AsString := strpFCPST;
      FieldByName('DIF_VFCPST').AsString := strvFCPST;

      FieldByName('VALGNR').AsFloat := recDiferencas.fltValGnr;
      FieldByName('VALGNR_ORIGINAL').AsFloat := recDiferencas.fltValGnr;
      FieldByName('ENT_CALGNR').AsString := recDiferencas.strMemCalGNRE;
      FieldByName('VSTCAL').AsFloat := recDiferencas.fltST_Cal;
      FieldByName('VSTXML').AsFloat := recDiferencas.fltST_XML;
      FieldByName('PROXML').AsFloat := recDetEle.I11_VPROD;
      FieldByName('VSTFCP').AsFloat := recDetEle.N23D_FCPST;
      FieldByName('CAL_VFCPST').AsFloat := recDetEle.N23_VFCPST_GARE;
    End;
  End;
End;

procedure TNFeXml.pAdicionarItem(objDetEle: TRecDetEle; objGerEle: TrecGerEle);
  Var
    recDetEle: TRecDetEle;
    recDiferencas: TRecDiferencas;
    intPosicao: Integer;
    recItem: TRecItem;
begin
  SetLength(FArrDetEle, fGetCount + 1);

  intPosicao := fGetCount;

  FArrDetEle[intPosicao -1] := objDetEle;

  If blnAuditoria Then
    Exit;

  pCalculaValoresNota(FArrDetEle[intPosicao -1], recDetEle, objGerEle);

  FArrDetEle[intPosicao -1].DET_CSTXML := ShortString(fCalculaCSTXML(FArrDetEle[intPosicao -1], String(recDetEle.DET_CSTXML)));

  If FValEle And (Not blnFulFillment) And (FGerEle.strMatRev <> 'M') And (Not blnImportaNfeSpedCodVel) And (not FNotaImportacao) Then
  Begin

    If Not fComparaValores(FArrDetEle[intPosicao -1], recDetEle, recDiferencas) Then
    Begin
      pCriaCdsInconsistencias;

      recItem := fCarregaCadIte(String(recDetEle.DET_CODITE),
                                String(FGerEle.GER_CODEMP),
                                String(FGerEle.GER_CODFOR),
                                String(FGerEle.GER_CODCLI));

      pIncluiInconsistencia(FArrDetEle[intPosicao -1], 'S', recDiferencas, intPosicao -1, recItem);
      pIncluiInconsistencia(recDetEle, 'N', recDiferencas, intPosicao -1, recItem);
    End;

  End;

end;

procedure TNFeXml.pAdicionarRetornoReferencia(objRetEle: TRecRetEle);
var
  intI: Integer;
begin
  If fEmptyStr(objRetEle.strReferenciaNFe) Then
    Exit;
  For intI := 0 to fGetRetCount - 1 Do
    If FArrRetEle[intI].strReferenciaNFe = objRetEle.strReferenciaNFe Then
      Exit;
  SetLength(FArrRetEle, fGetRetCount + 1);
  FArrRetEle[fGetRetCount - 1] := objRetEle;
end;

function TNFeXml.fPadroniza(strNUmPed: string): String;
var i : integer;
begin
  Result := '';
  If strNUmPed = '' Then
    Exit('');

  For i := 0 To Length(strNumPed) Do
    If strNumPed[i].IsNumber Then
      Result := Result + strNumPed[i];

  If Result <> '' Then
    Result := fStrZero(Copy(Result, Length(Result) -11, 12), 12)
end;

procedure TNFeXml.pLimpar;
begin
  FillChar(FGerEle, SizeOf(FGerEle), #0);
  SetLength(FArrDetEle, 0);
  SetLength(FArrDupEle, 0);
end;

constructor TNFeXml.Create(AOwner: TComponent);
begin
  lstDados := TStringList.Create;
  stlListaNotImp := TStringList.Create;
  blnImportaFrete := True;
  blnValidarXMLVal := True;
  qrySQL := fCriaQuery;
  FEmpresaNoDestinatario := True;
  blnAuditoria := False;
  blnIFCPST := fCfgSis('IFCPST', varBoolean);
  strTipAbfCfg := fCfgSis('TIPABF');
  strTipTPABPC := fCfgSis('TPABPC');
  blnTABPRF    := fCfgSis('TABPRF', varBoolean);
  blnAtuSub    := fCfgSis('ATUSUB', varBoolean);
  strFrmCus    := fCfgSis('FRMCUS',varString );
  blnValidaPisCofins := fCfgSis('VAPICO', varBoolean);
  blnIGNSIM := fCfgSis('IGNSIM') = '1';
  blnValidaXMLSefaz := fCfgSis('VALXML', varBoolean);
  blnImportaNfeSpedCodVel := False;
  blnIgnoraInativos := False;
  blnXMLCancelamento := False;
  blnXMLCancelamentoSemNota := False;
  blnXmlDevolucaoSemEntrada := False;
  blnXMLCancelado := False;
  blnXMLIndefinido := False;

  inherited Create(AOwner);

  frmGravandoNotas := Nil;
  FCriarTagDestinatarioEmBrancoCasoInexistente := False;

  strEstEmp := fCadEmp('ESTADO');

  blnConsiderarDescontoDesonerado := fConsideraICMSDesoneradoComDesconto(strEstEmp);

  pCriaCdsErros;
  FintTamNumDocGerEle := fTamNumDocGerEle;

  qryTribut := fCriaQuery(Self);

  FIteMatCon         := ShortString(fCfgSis('PROMAT'));

  strEmpEst          := fCadEmp('ESTADO');
  blnContribuinteIPI := (fCfgSis('CONIPI', varBoolean));
  FValEle            := fCfgSis('VALELE', varBoolean);
  blnValidar         := True;
  FFinalidadeXML     := xmlEntradaMercadoria;
  FDivCST            := False;
  FNotaImportacao    := False;
  FEmissaoImportacao := False;
  FImportacaoDI      := False;

  blnFreTri := fCfgSis('FRETRI', varBoolean);
  blnFreTIp := fCfgSis('FRETIP', varBoolean);
  FCnvEmb   := fCfgSis('CNVEMB');

  fltTolerancia := fCfgSis('TOLNFE', varDouble);

end;

constructor TNFeXml.Create(AOwner: TComponent; blnValidar : Boolean; finalidadeXML : tpeFinalidadeXML);
begin
  lstDados := TStringList.Create;
  stlListaNotImp := TStringList.Create;

  qryCritica := fCriaQuery;
  qrySQL := fCriaQuery;
  blnImportaFrete := True;
  blnValidarXMLVal := True;
  blnIFCPST := fCfgSis('IFCPST', varBoolean);
  strTipAbfCfg := fCfgSis('TIPABF');
  strTipTPABPC := fCfgSis('TPABPC');
  blnTABPRF    := fCfgSis('TABPRF', varBoolean);
  blnAtuSub    := fCfgSis('ATUSUB', varBoolean);
  strFrmCus    := fCfgSis('FRMCUS',varString );
  blnValidaPisCofins := fCfgSis('VAPICO', varBoolean);
  blnValidaXMLSefaz := fCfgSis('VALXML', varBoolean);

  inherited Create(AOwner);

  pCriaCdsErros();
  FintTamNumDocGerEle := fTamNumDocGerEle;

  strEstEmp := fCadEmp('ESTADO');

  frmGravandoNotas := Nil;

  blnConsiderarDescontoDesonerado := fConsideraICMSDesoneradoComDesconto(strEstEmp);

  strTipAbfCfg := fCfgSis('TIPABF');

  qryTribut := fCriaQuery(Self);
  FEmpresaNoDestinatario := True;
  FIteMatCon         := ShortString(fCfgSis('PROMAT'));

  strEmpEst          := fCadEmp('ESTADO');
  blnContribuinteIPI := (fCfgSis('CONIPI', varBoolean));
  FValEle            := fCfgSis('VALELE', varBoolean);
  Self.blnValidar    := blnValidar;
  FDivCST            := False;
  FNotaImportacao    := False;
  FEmissaoImportacao := False;
  FImportacaoDI      := False;

  blnFreTri := fCfgSis('FRETRI', varBoolean);
  blnFreTIp := fCfgSis('FRETIP', varBoolean);
  FCnvEmb   := fCfgSis('CNVEMB');

  fltTolerancia := fCfgSis('TOLNFE', varDouble);

  Self.FfinalidadeXML := finalidadeXML;

end;

destructor TNFeXml.destroy;
begin
  inherited;
  FreeAndNil(stlListaNotImp);

  FreeAndNil(qryCritica);
  FreeAndNil(qrySQL);
end;

Function TNFeXml.fSQLInconsitencias: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';

  strSQL := strSQL + '   "S"            AS MOSTRA, ';

  strSQL := strSQL + '   "0"            AS ELETRO, ';
  strSQL := strSQL + '   FOR_CODFOR     AS CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR     AS NOMFOR, ';
  strSQL := strSQL + '   CID_NOMCID     AS NOMCID, ';
  strSQL := strSQL + '   CID_ESTADO     AS ESTADO, ';
  strSQL := strSQL + '   "000000000000" AS NUMDOC, ';

  strSQL := strSQL + '   CONCAT(FOR_CODFOR, "-", FOR_NOMFOR, "  ",  CID_NOMCID, "-", CID_ESTADO) AS FORNEC, ';

  strSQL := strSQL + '   ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '   ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '   UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '   UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '   ITE_CLAIPI AS CLAIPI, ';
  strSQL := strSQL + '   ITE_CODABF AS CODABF, ';

  strSQL := strSQL + '   ITE_ABFPIS AS ABFPIS, ';
  strSQL := strSQL + '   ITE_ABFCOF AS ABFCOF, ';

  strSQL := strSQL + '   CONVERT("", CHAR(60)) AS DESABF, ';
  strSQL := strSQL + '   "000"      AS CODSIT, ';
  strSQL := strSQL + '   0.00       AS BASICM, ';
  strSQL := strSQL + '   0.00       AS ALQICM, ';
  strSQL := strSQL + '   0.00       AS VALICM, ';
  strSQL := strSQL + '   0.00       AS BASSUB, ';
  strSQL := strSQL + '   0.0000     AS FATMVA, ';
  strSQL := strSQL + '   0.00       AS VALSUB, ';
  strSQL := strSQL + '   0.00       AS BASIPI, ';
  strSQL := strSQL + '   0.00       AS ALQIPI, ';
  strSQL := strSQL + '   0.00       AS VALIPI, ';
  strSQL := strSQL + '   "    "     AS CLAFIS, ';
  strSQL := strSQL + '   0          AS SEQUEN, ';
  strSQL := strSQL + '   0.00       AS VALGNR, ';
  strSQL := strSQL + '   0.00       AS VALGNR_ORIGINAL, ';
  strSQL := strSQL + '   0.00       AS VSTCAL,';
  strSQL := strSQL + '   0.00       AS VSTXML,';
  strSQL := strSQL + '   0.00       AS PROXML,';
  strSQL := strSQL + '   0.00       AS VSTFCP,';
  strSQL := strSQL + '   0.00       AS CAL_VFCPST,';
  strSQL := strSQL + '   CAST("000" AS CHAR(3)) AS PISCST, ';
  strSQL := strSQL + '   0.00       AS PISVBC, ';
  strSQL := strSQL + '   0.00       AS PISPPIS, ';
  strSQL := strSQL + '   0.00       AS PISVPIS, ';
  strSQL := strSQL + '   CAST("000" AS CHAR(3)) AS COFCST, ';
  strSQL := strSQL + '   0.00       AS COFVBC, ';
  strSQL := strSQL + '   0.00       AS COFPCOFINS, ';
  strSQL := strSQL + '   0.00       AS COFVCOFINS, ';

  strSQL := strSQL + '   0.00       AS VBCFCPST, ';
  strSQL := strSQL + '   0.00       AS PFCPST, ';
  strSQL := strSQL + '   0.00       AS VFCPST, ';

  strSQL := strSQL + '   "N"        AS DIF_CODSIT, ';
  strSQL := strSQL + '   "N"        AS DIF_BASICM, ';
  strSQL := strSQL + '   "N"        AS DIF_ALQICM, ';
  strSQL := strSQL + '   "N"        AS DIF_VALICM, ';
  strSQL := strSQL + '   "N"        AS DIF_BASSUB, ';
  strSQL := strSQL + '   "N"        AS DIF_FATMVA, ';
  strSQL := strSQL + '   "N"        AS DIF_VALSUB, ';
  strSQL := strSQL + '   "N"        AS DIF_BASIPI, ';
  strSQL := strSQL + '   "N"        AS DIF_ALQIPI, ';
  strSQL := strSQL + '   "N"        AS DIF_VALIPI,  ';

  strSQL := strSQL + '   "N"        AS DIF_PISCST, ';
  strSQL := strSQL + '   "N"        AS DIF_PISVBC, ';
  strSQL := strSQL + '   "N"        AS DIF_PISPPIS, ';
  strSQL := strSQL + '   "N"        AS DIF_PISVPIS, ';
  strSQL := strSQL + '   "N"        AS DIF_COFCST, ';
  strSQL := strSQL + '   "N"        AS DIF_COFVBC, ';
  strSQL := strSQL + '   "N"        AS DIF_COFPCOFINS, ';
  strSQL := strSQL + '   "N"        AS DIF_COFVCOFINS, ';
  strSQL := strSQL + '   "N"        AS DIF_PFCPST, ';
  strSQL := strSQL + '   "N"        AS DIF_VFCPST, ';

  strSQL := strSQL + '   CAST("" AS CHAR(3)) AS ABFICM,  ';
  strSQL := strSQL + '   CAST("" AS CHAR(3)) AS PERFOR,  ';
  strSQL := strSQL + '   CAST("" AS CHAR(100)) AS DESABF,  ';
  strSQL := strSQL + '   CAST("" AS CHAR(20)) AS AUTINC,  ';
  strSQL := strSQL + '   CAST("" AS CHAR(5000)) AS ENT_CALGNR ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADITE ';
  strSQL := strSQL + ' INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  strSQL := strSQL + ' INNER JOIN CADFOR ON FOR_CODFOR = ITE_CODFOR ';
  strSQL := strSQL + ' INNER JOIN CADCID ON CID_CODCID = FOR_CODCID ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   FALSE ';

  Result := strSQL;
End;

procedure TNFeXml.pCriaCdsInconsistencias;
Begin
  If FValEle And (Not blnImportaNfeSpedCodVel) Then
  Begin
    If (Not Assigned(FCdsIncon)) Then
    Begin
      FCdsIncon := TZClient.Create(Nil, fSQLInconsitencias);
      FCdsIncon.fAbreClient(True, 'TNFeXml.pCriaCdsInconsistencias');
    End;  
  End Else
  Begin
    FCdsIncon := Nil;
  End;
End;  

procedure TNFeXml.pLimparRecDetEle(var recDetEle: TRecDetEle);
begin
  With recDetEle Do
  Begin
    DET_CODITE    := '';
    I02_CPROD     := '';
    I03_CEAN      := ''; 
    I04_XPROD     := ''; 
    I05_NCM       := '';
    CODCEST       := '';
    I06_EXTIPI    := '';
    I07_GENERO    := '';
    I08_CFOP      := '';
    I09_UCOM      := '';
    I10_QCOM      := 0.0;
    I10A_VUNCOM   := 0.0;
    I11_VPROD     := 0.0;
    I12_CEANTRIB  := '';
    I13_UTRIB     := '';
    I14_QTRIB     := 0.0;
    I14A_VUNTRIB  := 0.0;
    I15_VFRETE    := 0.0;
    I16_VSEG      := 0.0;
    I17_VDESC     := 0.0;
    I17A_VOUTRO   := 0.0;
    I70_NFCI      := '';
    N11_ORIG      := '';
    N12_CST       := '';
    N12_CSOSN     := '';
    N13_MODBC     := '';
    N14_PREDBC    := 0.0;
    N16b_PDIF     := 0.0;
    N15_VBC       := 0.0;
    N16_PICMS     := 0.0;
    N17_VICMS     := 0.0;
    N27A_VICMSDESON := 0.0;
    N27A_MOTDESICMS := '';
    N18_MODBCST   := ''; 
    N19_PMVAST    := 0.0;
    N20_PREBCST   := 0.0;

    N21_VBCST     := 0.0;
    N21_VBCST_Produto := 0.0;
    N21_VBCST_Produto_ComDesconto := 0.0;
    N21_VBCST_Produto_ComIPI     := 0.0;

    N22_PICMSST   := 0.0;

    N23_VICMSST   := 0.0;
    N23_VICMSST_Produto := 0.0;
    N23_VICMSST_Produto_ComDesconto := 0.0;
    N23_VICMSST_Produto_ComIPI := 0.0;

    N23A_VBCFCPST := 0.0;
    N23B_PFCPST := 0.0;
    N23D_FCPST := 0.0;

    N24_CREDSN    := 0.0;
    N24_CREDICMSSN := 0.0;

    N28_QICMSMONORET := 0.0;
    N28_ADBCMONORET := 0.0;
    N28_VREMICMSRET := 0.0;

    O02_CLENQ     := '';
    O07_IPITRIB   := '';
    O09_CST       := '';
    O10_VBC       := 0.0;
    O11_QUNID     := 0.0;
    O12_VUNID     := 0.0;
    O13_PIPI      := 0.0;

    O14_VIPI      := 0.0;
    O14_VIPI_ComDesconto := 0.0;

    Q06_CST       := '';
    Q07_VBC       := 0.0;
    Q08_PPIS      := 0.0;
    Q09_VPIS      := 0.0;
    Q10_QBCPROD   := 0.0;
    Q11_VALIQPROD := 0.0;
    S06_CST       := '';
    S07_VBC       := 0.0;
    S08_PCOFINS   := 0.0;
    S09_QBCPROD   := 0.0;
    S10_VALIQPROD := 0.0;
    S11_VCOFINS   := 0.0;
    ITE_PER_CI    := 0;
    V01_infAdProd := '';
    XPED          := '';
    NITEMPED      := '';
    LA02_CPRODANP := '';
    RT_CSTIS      := '';
    RT_CLATRIAIS  := '';
    RT_VBCIS      := 0.0;
    RT_PAIS       := 0.0;
    RT_PAISESP    := 0.0;
    RT_UTRIB      := '';
    RT_QTRIB      := 0.0;
    RT_VIS        := 0.0;
    // IBS/CBS
    RT_CST        := '';
    RT_CLATRIB    := '';
    RT_VBC        := 0.0;
    // IBS UF
    RT_PIBSUF     := 0.0;
    RT_PDIFUF     := 0.0;
    RT_VDIFUF     := 0.0;
    RT_VDEVUF     := 0.0;
    RT_PREDUF     := 0.0;
    RT_PEFETUF    := 0.0;
    RT_VIBSUF     := 0.0;
    // IBS Municipio
    RT_PIBSMUN    := 0.0;
    RT_PDIFMUN    := 0.0;
    RT_VDIFMUN    := 0.0;
    RT_VDEVMUN    := 0.0;
    RT_PREDMUN    := 0.0;
    RT_PEFETMUN   := 0.0;
    RT_VIBSMUN    := 0.0;
    RT_VIBS := 0.0;
    // CBS
    RT_PCBS       := 0.0;
    RT_PDIFCBS    := 0.0;
    RT_VDIFCBS    := 0.0;
    RT_VDEVCBS    := 0.0;
    RT_PREDCBS    := 0.0;
    RT_PEFETCBS   := 0.0;
    RT_VCBS       := 0.0;
    // Tributacao regular
    RT_CSTREG     := '';
    RT_CLATRIREG  := '';
    RT_PEFIBSUF   := 0.0;
    RT_VTRIBUF    := 0.0;
    RT_PEFIBSMUN  := 0.0;
    RT_VTRIBMUN   := 0.0;
    RT_PEFCBS     := 0.0;
    RT_VTRIBCBS   := 0.0;
  End;
end;

procedure TNFeXml.pCriaCdsErros;
begin
  FCdsErro := TUniClientDataSet.Create(Self);

  With FCdsErro.FieldDefs.AddFieldDef Do
  Begin
    Name      := 'NOMARQ';
    DataType  := ftString;
    Size      := 200;
  End;

  With FCdsErro.FieldDefs.AddFieldDef Do
  Begin
    Name      := 'NUMDOC';
    DataType  := ftString;
    Size      := 10;
  End;

  With FCdsErro.FieldDefs.AddFieldDef Do
  Begin
    Name      := 'NSERIE';
    DataType  := ftString;
    Size      := 3;
  End;

  With FCdsErro.FieldDefs.AddFieldDef Do
  Begin
    Name      := 'MOTIVO';
    DataType  := ftString;
    Size      := 300;
  End;

  With FCdsErro.FieldDefs.AddFieldDef Do
  Begin
    Name      := 'CODITE';
    DataType  := ftString;
    Size      := 11;
  End;

  With FCdsErro.FieldDefs.AddFieldDef Do
  Begin
    Name      := 'CODBAR';
    DataType  := ftString;
    Size      := 13;
  End;

  With FCdsErro.FieldDefs.AddFieldDef Do
  Begin
    Name      := 'DESITE';
    DataType  := ftString;
    Size      := 60;
  End;

  FCdsErro.CreateDataSet;
end;

function TNFeXml.fExisteEmitenteCliente(strCGCCPF, strCGC: String; var strCodCli: TString8): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  strCodCli := '';

  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Add('SELECT CLI_CODCLI FROM CADCLI');
    Add('WHERE');
    Add('  CLI_CGCCPF = :CGCCPF AND ');
    Add('  REPLACE(REPLACE(REPLACE(CLI_C_G_C_, "/",""), ".",""), "-","") = :C_G_C_     ');
    Add('ORDER BY CLI_STATUS LIMIT 1');

    ParamByName('CGCCPF').AsString := strCGCCPF;
    ParamByName('C_G_C_').AsString := fTiraCaracEspeciais(strCGC);

    Open;
    Result := Not IsEmpty;

    If Result Then
      strCodCli := ShortString(FieldByName('CLI_CODCLI').AsString);

    Close;
  End;

  FreeAndNil(qryGen);
End;

function TNFeXml.fExisteFornecedor(strCGCCPF, strCGC: String; Var strCodFor: TString8; Var strMatRev: String): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  strCodFor := '';
  strMatRev := '';

  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Add('SELECT FOR_CODFOR, FOR_MATREV FROM CADFOR');
    Add('WHERE');
    Add('  FOR_CGCCPF = :CGCCPF AND ');
    Add('  REPLACE(REPLACE(REPLACE(FOR_C_G_C_, "/",""), ".",""), "-","") = :C_G_C_     ');
    Add('ORDER BY FOR_STATUS LIMIT 1');

    ParamByName('CGCCPF').AsString := strCGCCPF;
    ParamByName('C_G_C_').AsString := fTiraCaracEspeciais(strCGC);

    Open;
    Result := Not IsEmpty;

    If Result Then
    Begin
      strCodFor := ShortString(FieldByName('FOR_CODFOR').AsString);
      strMatRev := FieldByName('FOR_MATREV').AsString;

      fCarregaDadosFornecedor(String(strCodFor));
    End;

    Close;
  End;

  FreeAndNil(qryGen);
End;

Function TNFeXml.fExisteItemCodBar(strCodBar: String; Var strCodIte: TString7; Var blnAtivo: Boolean): Boolean;
  Var
    qryGen: TUniQuery;
    strIte: String;
    blnErrAnt: Boolean;
Begin
  strCodIte := '';

  If fEmptyStr(strCodBar) Then
  Begin
    Result := False;
    Exit;
  End;
  
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Add('SELECT ITE_CODITE, ITE_ITEATI, ITE_DESITE FROM CADITE');
    Add('WHERE');
    Add('  ITE_CODBAR = :CODBAR');

    ParamByName('CODBAR').AsString := strCodBar;

    Open;
    Result := Not IsEmpty;

    If Result Then
    Begin
      If RecordCount > 1 Then
      Begin
        strIte := 'COD.BAR. "' + strCodBar + '" REPETIDOS: ' + #13#10;

        While Not Eof Do
        Begin
          strIte := strIte + '  ' + FieldByName('ITE_CODITE').AsString + ' - ' +
                                    FieldByName('ITE_DESITE').AsString + ' - ';

          If RecNo < RecordCount Then
            strIte := strIte + #13#10;

          Next;
        End;

        {*****************************************}
        {* INSERE O RELATORIO MAS NÃO CONSIDERA  *}
        {* COMO ERRO                             *}
        {**************************************AF*}
        blnErrAnt := FErro;

        pIncluiErro(strIte);

        FErro := blnErrAnt;

        First;
      End;

      strCodIte := ShortString(FieldByName('ITE_CODITE').AsString);
    End;

    blnAtivo := (FieldByName('ITE_ITEATI').AsString = 'S');

    If blnIgnoraInativos Then
      blnAtivo := True;

    Close;
  End;

  FreeAndNil(qryGen);
End;

Function TNFeXml.fExisteItemCodBarSem(strCodBar: String; Var strCodIte: TString7; Var blnAtivo: Boolean): Boolean;
  Var
    qryGen: TUniQuery;
    strIte: String;
    blnErrAnt: Boolean;
Begin
  strCodIte := '';

  If fEmptyStr(strCodBar) Then
  Begin
    Result := False;
    Exit;
  End;
  
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Add('SELECT');
    Add('  ITE_CODITE,');
    Add('  ITE_ITEATI,');
    Add('  ITE_DESITE');
    Add('FROM');
    Add('  CADITE');
    Add('  JOIN CADSEM ON SEM_CODITE = ITE_CODITE');
    Add('WHERE');
    Add('  SEM_CODBAR = :CODBAR');
    
    ParamByName('CODBAR').AsString := strCodBar;

    Open;
    Result := Not IsEmpty;

    If Result Then
    Begin
      If RecordCount > 1 Then
      Begin
        strIte := 'COD.BAR. DA EMBALAGEM DO SEMELHANTE "' + strCodBar + '" REPETIDOS: ' + #13#10;

        While Not Eof Do
        Begin
          strIte := strIte + '  ' + FieldByName('ITE_CODITE').AsString + ' - ' +
                                    FieldByName('ITE_DESITE').AsString;

          If RecNo < RecordCount Then
            strIte := strIte + #13#10;

          Next;
        End;

        {*****************************************}
        {* INSERE O RELATORIO MAS NÃO CONSIDERA  *}
        {* COMO ERRO                             *}
        {**************************************AF*}
        blnErrAnt := FErro;

        pIncluiErro(strIte);

        FErro := blnErrAnt;

        First;
      End;

      strCodIte := ShortString(FieldByName('ITE_CODITE').AsString);
    End;

    blnAtivo := (FieldByName('ITE_ITEATI').AsString = 'S');

    If blnIgnoraInativos Then
      blnAtivo := True;

    Close;
  End;

  FreeAndNil(qryGen);
End;

Function TNFeXml.fExisteItemCodEmb(strCodBar: String; Var strCodIte: TString7; Var blnAtivo: Boolean): Boolean;
  Var
    qryGen: TUniQuery;
    strIte: String;
    blnErrAnt: Boolean;
Begin
  strCodIte := '';

  If fEmptyStr(strCodBar) Then
  Begin
    Result := False;
    Exit;
  End;

  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Add('SELECT ITE_CODITE, ITE_ITEATI, ITE_DESITE FROM CADITE');
    Add('WHERE');
    Add('  ITE_BAREMB = :CODBAR');

    ParamByName('CODBAR').AsString := strCodBar;

    Open;
    Result := Not IsEmpty;
    If Result Then
    Begin
      If RecordCount > 1 Then
      Begin

        strIte := 'COD.BAR. DA EMBALAGEM "' + strCodBar + '" REPETIDOS: ' + #13#10;
        While Not Eof Do
        Begin
          strIte := strIte + '  ' + FieldByName('ITE_CODITE').AsString + ' - ' +
                                    FieldByName('ITE_DESITE').AsString;

          If RecNo < RecordCount Then
            strIte := strIte + #13#10;

          Next;
        End;

        {*****************************************}
        {* INSERE O RELATORIO MAS NÃO CONSIDERA  *}
        {* COMO ERRO                             *}
        {**************************************AF*}
        blnErrAnt := FErro;

        pIncluiErro(strIte);

        FErro := blnErrAnt;

        First;
      End;

      strCodIte := ShortString(FieldByName('ITE_CODITE').AsString);
    End;

    blnAtivo := (FieldByName('ITE_ITEATI').AsString = 'S');

    If blnIgnoraInativos Then
      blnAtivo := True;

    Close;
  End;

  FreeAndNil(qryGen);
End;

function TNFeXml.fExiteItemCodItemCliente(strCodItemC, strCodCli : String; var strCodIte : TString7; Var blnAtivo: Boolean ) : boolean;
Var
  qryGen: TUniQuery;
Begin
  strCodIte := '';

  qryGen := fCriaQuery;

  try
    qryGen.SQL.Add('SELECT                                                     ');
    qryGen.SQL.Add('  CADITE.ITE_CODITE,                                       ');
    qryGen.SQL.Add('  CADITE.ITE_ITEATI                                        ');
    qryGen.SQL.Add('FROM                                                       ');
    qryGen.SQL.Add('  ITECLI                                                   ');
    qryGen.SQL.Add('INNER JOIN CADITE ON CADITE.ITE_CODITE = ITECLI.ITE_CODITE ');
    qryGen.SQL.Add('WHERE ITECLI.ITE_CODCLI = :CODCLI                          ');
    qryGen.SQL.Add('  AND ITECLI.ITE_CODITC = :CODITC                          ');

    qryGen.ParamByName('CODITC').AsString := strCodItemC;
    qryGen.ParamByName('CODCLI').AsString := strCodCli;

    qryGen.Open;
    Result := Not qryGen.IsEmpty;

    If Result Then
    Begin
      strCodIte := ShortString(qryGen.FieldByName('ITE_CODITE').AsString);
      blnAtivo  := qryGen.FieldByName('ITE_ITEATI').AsString = 'S';
    End;

    qryGen.Close;

  finally
    FreeAndNil(qryGen);
  end;
End;

Function TNFeXml.fExisteItemCodItemFornecedor(strCodItemF, strCodFor: String; Var strCodIte: TString7; Var blnAtivo: Boolean): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  strCodIte := '';
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Add('SELECT ');
    Add('  ITE_CODITE ');
    Add('FROM ');
    Add('  ITEFOR ');

    If  blnTABPRF Then
    Begin
      Add('INNER JOIN TABPRE ON ITE_CODTAB = TAB_CODTAB AND ');
      Add('                     TAB_ATICMP = "S"            ');
    End;

    Add('WHERE');
    Add('  ITE_CODFOR = :CODFOR AND ');

    If  blnTABPRF Then
      Add('  ITE_CODFAB = :CODITF     ')
    Else
      Add('  ITE_CODITF = :CODITF     ');

    ParamByName('CODITF').AsString := strCodItemF;
    ParamByName('CODFOR').AsString := strCodFor;

    Open;
    Result := Not IsEmpty;

    If Result Then
    Begin
      strCodIte := ShortString(FieldByName('ITE_CODITE').AsString);
      blnAtivo  := fCampoTabela('ITE_ITEATI', 'CADITE', ['ITE_CODITE'], [strCodIte]) = 'S';
      If blnIgnoraInativos Then
        blnAtivo := True;
    End;

    Close;
  End;

  FreeAndNil(qryGen);
End;

function TNFeXml.fExisteItemCodVelCitel(strCodCit: String;
  var strCodIte: TString7; var blnAtivo: Boolean): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  Result := False;
  If Assigned(cdsCodVel) Then
  Begin
    If cdsCodVel.FindKey([strCodCit]) Then
    Begin
      strCodIte := ShortString(cdsCodVel.FieldByName('CODITE').AsString);
      Result := True;
    End
    Else
      strCodIte := '';

    blnAtivo := Result;
    Exit;
  End;

  strCodIte := '';
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Add('SELECT ');
    Add('  ITE_CODITE, ');
    Add('  ITE_DESITE, ');
    Add('  ITE_ITEATI, ');
    Add('  UNI_SIGUNI  ');
    Add('FROM ');
    Add('  CADITE ');
    Add('  LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ');
    Add('WHERE');

    Add('  ITE_CODVEL = :CODVEL ');

    ParamByName('CODVEL').AsString := strCodCit;

    Open;
    Result := Not IsEmpty;
    If Result Then
    Begin
      strCodIte := ShortString(FieldByName('ITE_CODITE').AsString);
    End;

    blnAtivo := (FieldByName('ITE_ITEATI').AsString = 'S');

    If blnIgnoraInativos Then
      blnAtivo := True;

    Close;
  End;

  FreeAndNil(qryGen);
end;

Function TNFeXml.fExisteItemCodFab(strCodFab, strCodFor: String; Var strCodIte: TString7; Var blnAtivo: Boolean): Boolean;
  Var
    qryGen: TUniQuery;
    strIte: String;
    blnErrAnt: Boolean;
Begin
  strCodIte := '';
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Add('SELECT ');
    Add('  ITE_CODITE, ');
    Add('  ITE_DESITE, ');
    Add('  ITE_ITEATI, ');    
    Add('  UNI_SIGUNI  ');
    Add('FROM ');
    Add('  CADITE ');
    Add('  LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ');
    Add('WHERE');

    Add('  ITE_CODFAB = :CODFAB ');

    If Not fEmptyStr(strCodFor) Then
      Add('  AND ITE_CODFOR = :CODFOR ');

    ParamByName('CODFAB').AsString := strCodFab;

    If Not fEmptyStr(strCodFor) Then
      ParamByName('CODFOR').AsString := strCodFor;

    Open;
    Result := Not IsEmpty;
    If Result Then
    Begin

      If RecordCount > 1 Then
      Begin

        strIte := 'COD.FAB. "' + strCodFab + '" REPETIDOS: ' + #13#10;
        While Not Eof Do
        Begin
          strIte := strIte + '  ' + FieldByName('ITE_CODITE').AsString + ' - ' +
                                    FieldByName('ITE_DESITE').AsString + ' - ' +
                                    FieldByName('UNI_SIGUNI').AsString;

          If RecNo < RecordCount Then
            strIte := strIte + #13#10;

          Next;
        End;

        {*****************************************}
        {* INSERE O RELATORIO MAS NÃO CONSIDERA  *}
        {* COMO ERRO                             *}
        {**************************************AF*}
        blnErrAnt := FErro;

        pIncluiErro(strIte);

        FErro := blnErrAnt;

        First;
      End;

      strCodIte := ShortString(FieldByName('ITE_CODITE').AsString);
    End;

    blnAtivo := (FieldByName('ITE_ITEATI').AsString = 'S');        

    If blnIgnoraInativos Then
      blnAtivo := True;

    Close;
  End;

  FreeAndNil(qryGen);
End;

Function TNFeXml.fExisteItemCodFabSem(strCodFab, strCodFor: String; Var strCodIte: TString7; Var blnAtivo: Boolean): Boolean;
  Var
    qryGen: TUniQuery;
    strIte: String;
    blnErrAnt: Boolean;
Begin
  strCodIte := '';
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Add('SELECT');
    Add('  ITE_CODITE,');
    Add('  ITE_DESITE,');
    Add('  ITE_ITEATI');
    Add('FROM');
    Add('  CADITE');
    Add('  JOIN CADSEM ON SEM_CODITE = ITE_CODITE');
    Add('WHERE');
    Add('  SEM_CODSEM = :CODFAB');

    If Not fEmptyStr(strCodFor) Then
      Add('  AND ITE_CODFOR = :CODFOR ');

    ParamByName('CODFAB').AsString := strCodFab;

    If Not fEmptyStr(strCodFor) Then
      ParamByName('CODFOR').AsString := strCodFor;

    Open;
    Result := Not IsEmpty;
    If Result Then
    Begin

      If RecordCount > 1 Then
      Begin

        strIte := 'COD.FAB. DO SEMELHANTE "' + strCodFab + '" REPETIDOS: ' + #13#10;
        While Not Eof Do
        Begin
          strIte := strIte + '  ' + FieldByName('ITE_CODITE').AsString + ' - ' +
                                    FieldByName('ITE_DESITE').AsString;

          If RecNo < RecordCount Then
            strIte := strIte + #13#10;

          Next;
        End;

        {*****************************************}
        {* INSERE O RELATORIO MAS NÃO CONSIDERA  *}
        {* COMO ERRO                             *}
        {**************************************AF*}
        blnErrAnt := FErro;

        pIncluiErro(strIte);

        FErro := blnErrAnt;

        First;
      End;

      strCodIte := ShortString(FieldByName('ITE_CODITE').AsString);
    End;

    blnAtivo := (FieldByName('ITE_ITEATI').AsString = 'S');        

    If blnIgnoraInativos Then
      blnAtivo := True;

    Close;
  End;

  FreeAndNil(qryGen);
End;

procedure TNFeXml.pIncluiErro(strMotivo: String; blnSemErro: Boolean = False);
Begin
  FErro := Not blnSemErro;
  If FfinalidadeXML = xmlRetornoSimbolico Then
  Begin
    cdsXML.First;
    If cdsXML.Locate('ARQUIVO', FNomArq, []) Then
    Begin
      cdsXML.Edit;
      cdsXML.FieldByName('STATUS_XML').AsString := 'Houve um problema ao importar';
      If cdsXML.FieldByName('ERRO_STATUS_XML').AsString <> '' Then
        cdsXML.FieldByName('ERRO_STATUS_XML').AsString := cdsXML.FieldByName('ERRO_STATUS_XML').AsString +  #$D#$A;
      cdsXML.FieldByName('ERRO_STATUS_XML').AsString := cdsXML.FieldByName('ERRO_STATUS_XML').AsString +  strMotivo;
      cdsXML.Post;
    End;
  End;

  With FCdsErro Do
  Begin
    Insert;
    FieldByName('NOMARQ').AsString := FNomArq;
    FieldByName('NUMDOC').AsString := String(FGerEle.B08_NNF);
    FieldByName('NSERIE').AsString := String(FGerEle.B07_SERIE);
    FieldByName('MOTIVO').AsString := strMotivo;
    Post;
  End;

  If Assigned(FOnErro) Then
    FOnErro(String(FGerEle.B08_NNF), String(FGerEle.B07_SERIE), FNomArq, strMotivo);
End;

function TNFeXml.fExistNode(nodNo: IXMLNode; strNome: String): Boolean;
Begin
  With nodNo Do
  Begin
    Result := Assigned(nodNo) And Assigned(ChildNodes.FindNode(strNome));
  End;
End;

function TNFeXml.fGetIde(nodIde: IXMLNode): Boolean;
  var
    recRetEleTmp : TRecRetEle;
    nodNFref     : IXMLNode;
Begin
  Try
    With nodIde, FGerEle Do
    Begin
      B02_CUF     := ShortString(fGetValorXml(nodIde, 'cUF'));
      B03_CNF     := ShortString(fGetValorXml(nodIde, 'cNF'));
      B04_NATOP   := ShortString(fGetValorXml(nodIde, 'natOp'));
      B05_INDPAG  := ShortString(fGetValorXml(nodIde, 'indPag'));
      B06_MOD     := ShortString(fGetValorXml(nodIde, 'mod'));
      B07_SERIE   := ShortString(fGetValorXml(nodIde, 'serie'));
      B08_NNF     := ShortString(fStrZero(VarToStr(fGetValorXml(nodIde, 'nNF')), FintTamNumDocGerEle ));

      If fExistNode(nodIde, 'dhEmi') Then
        B09_DEMI    := fGetValorXml(nodIde, 'dhEmi', varDate, 'YYYY-MM-DD', '-', True)
      Else
        B09_DEMI    := fGetValorXml(nodIde, 'dEmi', varDate);

      If fExistNode(nodIde, 'dhSaiEnt') Then
        B10_DSAIENT := fGetValorXml(nodIde, 'dhSaiEnt', varDate, 'YYYY-MM-DD', '-', True)
      Else
        B10_DSAIENT := fGetValorXml(nodIde, 'dSaiEnt', varDate);

      B11_TPNF    := ShortString(fGetValorXml(nodIde, 'tpNF'));
      B11A_IDDEST := fGetValorXml(nodIde, 'idDest');
      B12_CMUNFG    := ShortString(fGetValorXml(nodIde, 'cMunFG'));
      B21_TPIMP   := ShortString(fGetValorXml(nodIde, 'tpImp'));
      B22_TPEMIS  := ShortString(fGetValorXml(nodIde, 'tpEmis'));
      B24_TPAMB   := ShortString(fGetValorXml(nodIde, 'tpAmb'));
      B25_FINNFE  := ShortString(fGetValorXml(nodIde, 'finNFe'));
      NFeAjuste := (B25_FINNFE = '5') or (B25_FINNFE = '6');
      B25_TPNFDEBITO  := ShortString(fGetValorXml(nodIde, 'tpNFDebito'));
      B25_TPNFCREDITO := ShortString(fGetValorXml(nodIde, 'tpNFCredito'));
      B25B_INDPRES:= fGetValorXml(nodIde, 'indPres');
      B25B_INDFINAL:= fGetValorXml(nodIde, 'indFinal');
      B26_PROCEMI := ShortString(fGetValorXml(nodIde, 'procEmi'));
      If (B25_FINNFE = '6') And (B25_TPNFDEBITO <> '04') Then
      Begin
        pIncluiErro('Nota ' + String(B08_NNF) + ': XML invalido. tpNFDebito <> 04. Esta rotina processa apenas Juros e Multas (04).');
        Exit(False);
      End;
      If (B25_FINNFE = '5') And (B25_TPNFCREDITO <> '04') Then
      Begin
        pIncluiErro('Nota ' + String(B08_NNF) + ': XML invalido. tpNFCredito <> 04. Esta rotina processa apenas Juros e Multas (04).');
        Exit(False);
      End;
    End;

    nodNFref := nodIde.ChildNodes.FindNode('NFref');
    While Assigned(nodNFref) And (nodNFref.GetNodeName = 'NFref') Do
    Begin
      recRetEleTmp.strReferenciaNFe := '';

      Result := fGetRet(nodNFref, recRetEleTmp);

      If Result Then
        pAdicionarRetornoReferencia(recRetEleTmp);

      nodNFref := nodNFref.NextSibling;
    End;

    Result := TRUE;

  Except
    Result := FALSE;
  End;

End;

function TNFeXml.fGetEmit(nodEmit: IXMLNode): Boolean;
  Var
    nodenderEmit: IXMLNode;
    blnNaoEncotradoFornec : Boolean;
Begin
  Try
    blnNaoEncotradoFornec := False;
    With FGerEle Do
    Begin
      C02_CNPJ   := ShortString(fGetValorXml(nodEmit, 'CNPJ'));
      C02A_CPF   := ShortString(fGetValorXml(nodEmit, 'CPF'));
      If Not FNotaImportacao Then
      Begin
        If (blnValidar) And (FfinalidadeXML in [xmlEntradaMercadoria, xmlCFG_IMPXGRGarantiaRetFornecedor, xmlGarantiaRetFornecedor ,xmlEntradaMercadoriasSistemaAnteriorDevolucao, xmlDevolucaoEntradaEmitidaFornecedor, xmlRetornoSimbolico] ) Then
        Begin
          If (Not fEmptyStr(String(C02_CNPJ))) And (Not fExisteFornecedor('1', String(C02_CNPJ), GER_CODFOR, strMatRev)) Then
          Begin
            If not blnAuditoria then
            Begin
              blnNaoEncotradoFornec:= True;
              pIncluiErro('FORNECEDOR COM CNPJ ' + String(C02_CNPJ) + ' NAO ENCONTRADO');
            End;
          End;

          If (fEmptyStr(String(C02_CNPJ))) And (Not fEmptyStr(String(C02A_CPF))) And (Not fExisteFornecedor('2', String(C02A_CPF), GER_CODFOR, strMatRev)) Then
          Begin
            blnNaoEncotradoFornec := True;
            pIncluiErro('FORNECEDOR COM CPF ' + String(C02A_CPF) + ' NAO ENCONTRADO');
          End;

          If SameText(strMatRev, 'M') And fEmptyStr(String(FIteMatCon)) Then
          Begin
            pIncluiErro('CADASTRAR A CONFIGURAÇÃO CFG_PROMAT - Produto material de consumo');
          End;

          If (Not fEmptyStr(String(GER_CODFOR))) And (fEmptyStr(strMatRev)) Then
          Begin
            pIncluiErro('FORNECEDOR CÓDIGO: ' + String(GER_CODFOR) + ' ESTÁ SEM INFORMAÇÃO NO CAMPO TIPO FORNEC. ');
          End;
        End;

        If (blnValidar) And (FfinalidadeXML in [xmlConsertoEquipamento, xmlGarantiaRecCliente, xmlConsignacaoDevolucaoCliente, xmlRetornoLocacao]) Then
        Begin
          If (Not fEmptyStr(String(C02_CNPJ))) And (Not fExisteEmitenteCliente('1', String(C02_CNPJ), GER_CODCLI)) Then
          Begin
            blnNaoEncotradoFornec:= True;
            pIncluiErro('CLIENTE COM CNPJ ' + String(C02_CNPJ) + ' NAO ENCONTRADO');
          End;

          If (fEmptyStr(String(C02_CNPJ))) And (Not fEmptyStr(String(C02A_CPF))) And (Not fExisteEmitenteCliente('2', String(C02A_CPF), GER_CODCLI)) Then
          Begin
            blnNaoEncotradoFornec := True;
            pIncluiErro('CLIENTE COM CPF ' + String(C02A_CPF) + ' NAO ENCONTRADO');
          End;
        End;

        If (Not fEmptyStr(String(GER_CODCLI))) Then
          GER_TIP_FC := 'C'
        Else If (Not fEmptyStr(String(GER_CODFOR))) Then
          GER_TIP_FC := 'F'
        Else
          GER_TIP_FC := '';

        GER_TIPXML := Ord(FfinalidadeXML);

      End;
      CalculoBaseSubstituicaoXML := fTipoCalculoBaseST(string(GER_CODFOR));

      C03_XNOME  := ShortString(fGetValorXml(nodEmit, 'xNome'));
      C04_XFANT  := ShortString(fGetValorXml(nodEmit, 'xFant'));

      nodenderEmit := nodEmit.ChildNodes.FindNode('enderEmit');

      If Assigned(nodenderEmit) Then
      Begin
        C03_XLGR   := ShortString(fGetValorXml(nodenderEmit, 'xLgr'));
        C07_NRO    := ShortString(fGetValorXml(nodenderEmit, 'nro'));
        C08_XCPL   := ShortString(fGetValorXml(nodenderEmit, 'xCpl'));
        C09_XBAIRRO:= ShortString(fGetValorXml(nodenderEmit, 'xBairro'));
        C10_CMUN   := RightStr(ShortString(fGetValorXml(nodenderEmit, 'cMun')), 7);
        C11_XMUN   := ShortString(fGetValorXml(nodenderEmit, 'xMun'));
        C12_UF     := ShortString(fGetValorXml(nodenderEmit, 'UF'));
        C13_CEP    := ShortString(fGetValorXml(nodenderEmit, 'CEP'));
        C14_CPAIS  := ShortString(fGetValorXml(nodenderEmit, 'cPais'));
        C15_XPAIS  := ShortString(fGetValorXml(nodenderEmit, 'xPais'));
        C16_FONE   := ShortString(fGetValorXml(nodenderEmit, 'fone'));
      End;

      C17_IE     := ShortString(fGetValorXml(nodEmit, 'IE'));
      C18_IEST   := ShortString(fGetValorXml(nodEmit, 'IEST'));
      C19_IM     := ShortString(fGetValorXml(nodEmit, 'IM'));
      C20_CNAE   := ShortString(fGetValorXml(nodEmit, 'CNAE'));
      C21_CRT    := ShortString(fGetValorXml(nodEmit, 'CRT'));

    End;

    Result := TRUE;

    If (blnNaoEncotradoFornec) And Assigned(FDoFornecedorNaoEncontrado) Then
      FDoFornecedorNaoEncontrado(string(FGerEle.C02_CNPJ),
                                 string(FGerEle.C02A_CPF),
                                 string(FGerEle.C03_XNOME),
                                 string(FGerEle.C04_XFANT),
                                 string(FGerEle.C03_XLGR),
                                 string(FGerEle.C07_NRO),
                                 string(FGerEle.C08_XCPL),
                                 string(FGerEle.C09_XBAIRRO),
                                 string(FGerEle.C10_CMUN),
                                 string(FGerEle.C11_XMUN),
                                 string(FGerEle.C12_UF),
                                 string(FGerEle.C13_CEP),
                                 string(FGerEle.C14_CPAIS),
                                 string(FGerEle.C15_XPAIS),
                                 string(FGerEle.C16_FONE),
                                 string(FGerEle.C17_IE),
                                 string(FGerEle.C18_IEST),
                                 string(FGerEle.C19_IM),
                                 string(FGerEle.C20_CNAE));
  Except
    Result := FALSE;
  End;

End;

function TNFeXml.fGetADI(nodADI: IXMLNode; var recDetEle: TRecDetEle): Boolean;
begin
  Try
    With recDetEle Do
    Begin
      I26_NADICAO := fGetValorXml(nodADI, 'nAdicao', varDouble);
    End;

    Result := TRUE;

  Except
    Result := FALSE;
  End;
end;

function TNFeXml.fGetChaveStatus(nodChave: IXMLNode): Boolean;
Begin
  Try
    With FGerEle Do
    Begin
      PR07_CHNFE  := fGetValorXml(nodChave, 'chNFe', varString);
      PR08_STATUS := fGetValorXml(nodChave, 'cStat', varString);
      PR09_MOTIVO := fGetValorXml(nodChave, 'xMotivo', varString);
    End;

    Result := True;
  Except
    Result := False;
  End;
end;

Function TNFeXml.fGetTransp(nodTransp: IXMLNode): Boolean;
  const
    TAG_VOL: String = 'vol';
  Var
    nodvol: IXMLNode;
    nodTransportadora: IXMLNode;
Begin
  Try
    FGerEle.X33_MODFRETE := IfNull(fGetValorXml(nodTransp, 'modFrete', varString), '9');


    nodTransportadora := nodTransp.ChildNodes.FindNode('transporta');

    If Assigned(nodTransportadora) Then
      FGerEle.X34_CNPJ := fGetValorXml(nodTransportadora, 'CNPJ', varString);

    if blnImportaFrete then
    begin
      nodTransp.ChildNodes.First;
      nodvol := nodTransp.ChildNodes.FindNode(TAG_VOL);
      If Assigned(nodvol) Then
      begin
        FGerEle.X27_QVOL      := 0;
        FGerEle.X28_ESP       := fGetValorXml(nodvol, 'esp',   varString);
        FGerEle.X35_MARCA     := fGetValorXml(nodvol, 'marca', varString);
        FGerEle.X31_PESOL     := 0;
        FGerEle.X32_PESOB     := 0;

        Repeat
          FGerEle.X27_QVOL      := FGerEle.X27_QVOL + fGetValorXml(nodvol, 'qVol',  varDouble);
          FGerEle.X31_PESOL     := FGerEle.X31_PESOL + fGetValorXml(nodvol, 'pesoL', varDouble);
          FGerEle.X32_PESOB     := FGerEle.X32_PESOB + fGetValorXml(nodvol, 'pesoB', varDouble);
          nodvol := nodvol.NextSibling;
        until (Not Assigned(nodvol)) or (nodvol.NodeName <> TAG_VOL) ;
      end;

    end;
    Result := TRUE;

  Except
    Result := FALSE;
  End;
End;

function TNFeXml.fGetVSegNotDet(AnItem: String): Double;
begin
 qryNotger.First;
 Result := 0;
 If qryNotGer.Locate('SEQ', AnItem, []) then
   result := qryNotGer.FieldByName('DET_VALSEG').AsFloat;
end;

function TNFeXml.fGetTotal(nodTotal: IXMLNode): Boolean;
  Var
    nodICMSTot: IXMLNode;
    nodISTot    : IXMLNode;
    nodIBSCBSTot: IXMLNode;
    nodGIBS     : IXMLNode;
    nodGIBSUF   : IXMLNode;
    nodGIBSMun  : IXMLNode;
    nodGCBS     : IXMLNode;
Begin
  Try
    nodICMSTot := nodTotal.ChildNodes.FindNode('ICMSTot');

    If Assigned(nodICMSTot) Then
    With FGerEle Do
    Begin
      W03_VBC         := fGetValorXml(nodICMSTot, 'vBC', varDouble);
      W04_VICMS       := fGetValorXml(nodICMSTot, 'vICMS', varDouble);
      W04A_VICMSDESON := fGetValorXml(nodICMSTot, 'vICMSDeson', varDouble);
      W05_VBCST       := fGetValorXml(nodICMSTot, 'vBCST', varDouble);
      W06_VST         := fGetValorXml(nodICMSTot, 'vST', varDouble);
      If blnVersao4 Then
      Begin
        FGerEle.W06A_VFCPST   := fGetValorXml(nodICMSTot, 'vFCPST', varDouble);
        FGerEle.W04H_VFCP     := fGetValorXml(nodICMSTot, 'vFCP', varDouble);
      End;
      W07_VPROD       := fGetValorXml(nodICMSTot, 'vProd', varDouble);
      if blnImportaFrete then
      begin
        W08_VFRETE      := fGetValorXml(nodICMSTot, 'vFrete', varDouble);
        W15_VOUTRO      := fGetValorXml(nodICMSTot, 'vOutro', varDouble);
      end;
      W09_VSEG        := fGetValorXml(nodICMSTot, 'vSeg', varDouble);
      W10_VDESC       := fGetValorXml(nodICMSTot, 'vDesc', varDouble);
      W11_VII         := fGetValorXml(nodICMSTot, 'vII', varDouble);
      W12_VIPI        := fGetValorXml(nodICMSTot, 'vIPI', varDouble);
      If blnFulFillment Then
      Begin
        W12A_VIPIDEVOL  := fGetValorXml(nodICMSTot, 'vIPIDevol', varDouble);
      End;
      W13_VPIS        := fGetValorXml(nodICMSTot, 'vPIS', varDouble);
      W14_VCOFINS     := fGetValorXml(nodICMSTot, 'vCOFINS', varDouble);
      W16_VNF         := fGetValorXml(nodICMSTot, 'vNF', varDouble);
      W15_VSERV       := fGetValorXml(nodICMSTot, 'vServ', varDouble);
      W24_VRETPIS     := fGetValorXml(nodICMSTot, 'vRetPIS', varDouble);
      W25_VRETCOFINS  := fGetValorXml(nodICMSTot, 'vRetCOFINS', varDouble);
      W26_VRETCSLL    := fGetValorXml(nodICMSTot, 'vRetCSLL', varDouble);
      W27_VBCIRRF     := fGetValorXml(nodICMSTot, 'vBCIRRF', varDouble);
      W28_VIRRF       := fGetValorXml(nodICMSTot, 'vIRRF', varDouble);
      W29_VBCRETPREV  := fGetValorXml(nodICMSTot, 'vBCRetPrev', varDouble);
      W30_VRETPREV    := fGetValorXml(nodICMSTot, 'vRetPrev', varDouble);
      W31_VICMSUFDEST := fGetValorXml(nodICMSTot, 'vICMSUFDest', varDouble);

      nodICMSTot := nodTotal.ChildNodes.FindNode('ISSQNtot');

      If Assigned(nodICMSTot) Then
      Begin
        W18_VSERV        := fGetValorXml(nodICMSTot, 'vServ', varDouble);
        W19_VBC          := fGetValorXml(nodICMSTot, 'vBC', varDouble);
        W20_VISS         := fGetValorXml(nodICMSTot, 'vISS', varDouble);
        W21_VPIS         := fGetValorXml(nodICMSTot, 'vPIS', varDouble);
        W22_VCOFINS      := fGetValorXml(nodICMSTot, 'vCOFINS', varDouble);
        W22A_DCOMPET     := fGetValorXml(nodICMSTot, 'dCompet', varDouble);
        W22B_VDEDUCAO    := fGetValorXml(nodICMSTot, 'vDeducao', varDouble);
        W22D_VDESCINCOND := fGetValorXml(nodICMSTot, 'vDescIncond', varDouble);
      End;
    End;

    // Reforma Tributaria - Totais (GERERT)
    If FGerEle.C14_CPAIS = '1058' Then
    Begin
      nodISTot     := nodTotal.ChildNodes.FindNode('ISTot');
      nodIBSCBSTot := nodTotal.ChildNodes.FindNode('IBSCBSTot');

      If Assigned(nodISTot) Then
        FGerEle.RT_VIS := fGetValorXml(nodISTot, 'vIS', varDouble);

      If Assigned(nodIBSCBSTot) Then
      Begin
        FGerEle.RT_VBCIBSCBS := fGetValorXml(nodIBSCBSTot, 'vBCIBSCBS', varDouble);

        nodGIBS := nodIBSCBSTot.ChildNodes.FindNode('gIBS');
        If Assigned(nodGIBS) Then
        Begin
          FGerEle.RT_VIBS      := fGetValorXml(nodGIBS, 'vIBS', varDouble);
          FGerEle.RT_VCREDPRES := fGetValorXml(nodGIBS, 'vCredPres', varDouble);
          FGerEle.RT_VCREDPRECS:= fGetValorXml(nodGIBS, 'vCredPresCondSus', varDouble);

          nodGIBSUF := nodGIBS.ChildNodes.FindNode('gIBSUF');
          If Assigned(nodGIBSUF) Then
          Begin
            FGerEle.RT_VDIFIBSUF := fGetValorXml(nodGIBSUF, 'vDif', varDouble);
            FGerEle.RT_VDEVIBSUF := fGetValorXml(nodGIBSUF, 'vDevTrib', varDouble);
            FGerEle.RT_VIBSUF    := fGetValorXml(nodGIBSUF, 'vIBSUF', varDouble);
          End;

          nodGIBSMun := nodGIBS.ChildNodes.FindNode('gIBSMun');
          If Assigned(nodGIBSMun) Then
          Begin
            FGerEle.RT_VDIFMUN := fGetValorXml(nodGIBSMun, 'vDif', varDouble);
            FGerEle.RT_VDEVMUN := fGetValorXml(nodGIBSMun, 'vDevTrib', varDouble);
            FGerEle.RT_VIBSMUN := fGetValorXml(nodGIBSMun, 'vIBSMun', varDouble);
          End;
        End;

        nodGCBS := nodIBSCBSTot.ChildNodes.FindNode('gCBS');
        If Assigned(nodGCBS) Then
        Begin
          FGerEle.RT_VDIFCBS      := fGetValorXml(nodGCBS, 'vDif', varDouble);
          FGerEle.RT_VDEVCBS      := fGetValorXml(nodGCBS, 'vDevTrib', varDouble);
          FGerEle.RT_VCBS         := fGetValorXml(nodGCBS, 'vCBS', varDouble);
          FGerEle.RT_VCREDPRESCBS := fGetValorXml(nodGCBS, 'vCredPres', varDouble);
          FGerEle.RT_VCREDPRECCBS := fGetValorXml(nodGCBS, 'vCredPresCondSus', varDouble);
        End;
      End;

      FGerEle.RT_VNFTOT := fGetValorXml(nodTotal, 'vNFTot', varDouble);
    End;

    Result := TRUE;

  Except
    Result := FALSE;
  End;

End;

Function TNFeXml.fNotaExiste(strNF, strSerie, strtpNF, strCNPJ, strCPF: String ): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Add('SELECT B08_NNF FROM GERELE');
    Add('WHERE');
    Add('  B08_NNF   = :B08_NNF   AND ');
    Add('  B07_SERIE = :B07_SERIE AND ');
    Add('  B11_TPNF  = :B11_TPNF      ');

    If Not fEmptyStr(strCNPJ) Then
      Add(' AND C02_CNPJ = :C02_CNPJ ')

    Else If Not fEmptyStr(strCPF) Then
      Add(' AND C02A_CPF = :C02A_CPF ');


    If (fCfgSis('XMLVAL', varInteger) = 2) And blnValidarXMLVal Then
    Begin
      Add(' UNION ALL           ');
      Add(' SELECT XML_NUMDOC   ');
      Add(' FROM XMLVAL X       ');
      Add(' INNER JOIN CADFOR ON FOR_CODFOR = XML_CODFOR ');
      Add('WHERE');
      Add('  XML_NUMDOC = :B08_NNF   AND ');
      Add('  XML_SERIE_ = :B07_SERIE      ');

      If Not fEmptyStr(strCNPJ) Then
        Add(' AND FOR_C_G_C_ = :C02_CNPJ ')

      Else If Not fEmptyStr(strCPF) Then
        Add(' AND FOR_C_G_C_ = :C02A_CPF ');
    End;

    ParamByName('B08_NNF').AsString   := strNF;
    ParamByName('B07_SERIE').AsString := strSerie;
    ParamByName('B11_TPNF').AsString  := strtpNF;

    If Not fEmptyStr(strCNPJ) Then
      ParamByName('C02_CNPJ').AsString  := strCNPJ

    Else If Not fEmptyStr(strCPF) Then
      ParamByName('C02A_CPF').AsString  := strCPF;

    Open;
    Result := Not IsEmpty;
    Close;
  End;

  FreeAndNil(qryGen);
End;


Function TNFeXml.fNotaExisteCadFis: Boolean;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Add('SELECT 1 FROM CADFIS');
    qryGen.SQL.Add('WHERE');
    qryGen.SQL.Add('FIS_CODEMP = :CODEMP AND ');
    qryGen.SQL.Add('FIS_ENTSAI = "E" AND ');
    qryGen.SQL.Add('FIS_ACESSO = :ACESSO');
    qryGen.ParamByName('CODEMP').AsString := String(FGerEle.GER_CODEMP);
    qryGen.ParamByName('ACESSO').AsString := FGerEle.PR07_CHNFE;
    qryGen.Open;
    Result := Not qryGen.IsEmpty;
  Finally
    FreeAndNil(qryGen);
  End;
End;


function TNFeXml.fGravaGerEleAuditoria: Boolean;
  var
    qryGerEle: TUniQuery;
Begin
  pRemoveImportadoGERADT(FGerEle.PR07_CHNFE);

  qryGerEle := fCriarQuery('SELECT * FROM GERADT WHERE FALSE', nil);
  Try
    Try
      qryGerEle.Open;
      qryGerEle.Insert;
      qryGerEle.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('GERADT', VS_StrCodEmp);
      qryGerEle.FieldByName('ADT_CHAVEA').AsString := FGerEle.PR07_CHNFE;
      qryGerEle.FieldByName('ADT_DTAEMI').AsDateTime := FGerEle.B09_DEMI;
      qryGerEle.FieldByName('ADT_C_G_C_').AsString := String(FGerEle.C02_CNPJ);
      qryGerEle.FieldByName('ADT_CODFOR').AsString := String(FGerEle.GER_CODFOR);
      If qryGerEle.FieldByName('ADT_CODFOR').AsString = '' then
        qryGerEle.FieldByName('ADT_CODFOR').Clear;
      qryGerEle.FieldByName('ADT_EMPDES').AsString := String(FGerEle.GER_CODEMP);
      qryGerEle.FieldByName('ADT_NUMDOC').AsString := String(FGerEle.B08_NNF);
      qryGerEle.FieldByName('ADT_SERIE_').AsString := String(FGerEle.B07_SERIE);
      qryGerEle.FieldByName('ADT_VLRCON').AsFloat   := FGerEle.W16_VNF;
      qryGerEle.FieldByName('ADT_TEMCAD').AsInteger := IIf(fLocalizaLivroFiscal(FGerEle.PR07_CHNFE), 1, 0);
      qryGerEle.FieldByName('ADT_AGRUPA').AsString := Agrupador;
      qryGerEle.FieldByName('ADT_STATUS').AsString := FGerEle.PR08_STATUS;
      qryGerEle.FieldByName('ADT_MOTIVO').AsString := FGerEle.PR09_motivo;

      qryGerEle.FieldByName('ADT_ARQUIV').AsString := FPatArq + FNomArq;
      TBlobField(qryGerEle.FieldByName('ADT_ARQXML')).LoadFromFile(FPatArq + FNomArq);
      qryGerEle.Post;
      Result := True;
    Finally
      FreeAndNil(qryGerEle);
    End;
  Except
    on e:exception do
    begin
      pMensagensErro(E.Message, '[TNFeXml.fGravaGerEleAuditoria]');
      Result := false;
    End;
  End
End;

Function TNFeXml.fLocalizaLivroFiscal(AChaveAcesso: String): Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Text := 'SELECT COUNT(1) AS QTD  FROM CADFIS WHERE FIS_ACESSO = "'+AChaveAcesso+'"';
    qryConsulta.Open;
    Result := qryConsulta.FieldByName('QTD').AsInteger > 0;

    If not result then
    Begin
      qryConsulta.Close;
      qryConsulta.SQL.Text := 'SELECT COUNT(1) AS QTD  FROM GERELE WHERE PR07_CHNFE = "'+AChaveAcesso+'"';
      qryConsulta.Open;
      Result := qryConsulta.FieldByName('QTD').AsInteger > 0;
    End;

  Finally
    FreeAndNil(qryConsulta);
  End;

End;

procedure TNFeXml.pRemoveImportadoGERADT(AChaveAcesso: String);
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Text := 'DELETE FROM GERADT WHERE ADT_CHAVEA = "'+AChaveAcesso+'"';
    qryConsulta.ExecSQL
  Finally
    FreeAndNil(qryConsulta);
  End;

End;


Function TNFeXml.fGravaGerEle(blnCSTCad: Boolean): Boolean;
  var
    qryGerEle: TUniQuery;
    qryDupEle: TUniQuery;
    qryInfEle: TUniQuery;
    intCorre : Integer;
    strCodEmp: String;
    strSerieNotGer: String;
Begin
  Try
    If FErro Then
    Begin
      Result := TRUE;
      Exit;
    End;

    qryGerEle := fCriarQuery('SELECT * FROM GERELE WHERE FALSE', Self);

    With qryGerEle, FGerEle Do
    Begin
      Open;

      If fNotaExiste(String(B08_NNF), String(B07_SERIE), String(B11_TPNF), String(C02_CNPJ), String(C02A_CPF)) Then
      Begin
        pIncluiErro('NOTA ' + String(B08_NNF) + ' JÁ EXISTE');
        Result := FALSE;
        Exit;
      End;
      strSerieNotGer  := '';
      If FNotaImportacao Then
      Begin
        If Not fValidaSerie(strSerieNotGer) Then
        Begin
          pIncluiErro('NOTA ' + String(B08_NNF) + '/SÉRIE:' + String(B07_SERIE) +  ' NÃO FOI ENCONTRADA PARA A SÉRIE CONFIGURADA EM [CFG_SERFSC] (Série: ' + fCfgSis('SERFSC', varString)+')');
          Result := FALSE;
          Exit;
        End;
      End;

      FSeqGer := fRetAutoIncrem('GERELE', VS_strCodEmp);

      strListIdGerEle.Add(FSeqGer);

      Insert;
      FieldByName('AUTOINCREM').AsString := FSeqGer;
      If FGerEle.NFeAjuste then
      begin
        FieldByName('GER_DOCENT').AsString := String(FGerEle.B08_NNF);
        FieldByName('GER_ESPENT').AsString := 'NF';
        FieldByName('GER_EMPENT').AsString := String(FGerEle.GER_CODEMP);
      end;

      If FCnvEmb <> 'N' Then
        FieldByName('GER_UNICOM').AsString := 'S'
      Else
        FieldByName('GER_UNICOM').AsString := 'N';

      If blnCSTCad Then
        FieldByName('GER_CSTCAD').AsString := 'S'
      Else
        FieldByName('GER_CSTCAD').AsString := 'N';

      strCodEmp := String(GER_CODEMP);
      FieldByName('GER_CODEMP').AsString := String(GER_CODEMP);
      If fEmptyStr(FieldByName('GER_CODEMP').AsString) Then
        FieldByName('GER_CODEMP').Clear;

      If (fEmptyStr(String(GER_CODFOR))) Then
        FieldByName('GER_CODFOR').Value := Null
      Else
      Begin
        FieldByName('GER_CODFOR').AsString := String(GER_CODFOR);
        FieldByName('GER_TIP_FC').AsString := 'F';
      End;

      If (fEmptyStr(String(GER_CODCLI))) Then
        FieldByName('GER_CODCLI').Value := Null
      Else Begin
        FieldByName('GER_CODCLI').AsString := String(GER_CODCLI);
        FieldByName('GER_TIP_FC').AsString := 'C';
      End;

      If FGerEle.NFeAjuste then
        FieldByName('GER_TIPXML').AsInteger := Ord(tpeFinalidadeXML.xmlNfeAjuste)
      Else
        FieldByName('GER_TIPXML').AsInteger := Ord(FfinalidadeXML);

      FieldByName('E02_CNPJ').AsString   := String(E02_CNPJ);
      FieldByName('E17_IE').AsString     := String(E17_IE);

      FieldByName('GER_CONPAG').AsString := String(GER_CONPAG);

      If FfinalidadeXML = xmlEntradaMercadoriasSistemaAnteriorDevolucao Then
        FieldByName('GER_ENTDIR').AsString := 'S'
      Else If FfinalidadeXML in [xmlDevolucaoEntradaEmitidaFornecedor] Then
      begin
        FieldByName('GER_ENTDIR').AsString := 'S';
        FieldByName('GER_HORLIB').Value := fTime();
        FieldByName('GER_OPELIB').Value := strLoginUsuarioLogado;
        FieldByName('GER_UNICOM').Value := 'N';
        FieldByName('GER_DTALIB').AsDateTime := VS_Date;
        FieldByName('GER_CONDIR').AsString := 'S';
        FieldByName('GER_DTACON').AsDateTime := VS_Date
      End

      Else If FfinalidadeXML in [xmlCFG_IMPXGRGarantiaRetFornecedor] Then
      begin
        FieldByName('GER_ENTDIR').AsString := 'S';
        FieldByName('GER_HORLIB').Value := fTime();
        FieldByName('GER_OPELIB').Value := strLoginUsuarioLogado;
        FieldByName('GER_UNICOM').Value := 'N';
        FieldByName('GER_DTALIB').AsDateTime := VS_Date;
        FieldByName('GER_CONDIR').AsString := 'S';
      end

      Else
      begin
        If fCampoTabela('FOR_MATREV', 'CADFOR', ['FOR_CODFOR'], [FGerEle.GER_CODFOR]) = 'M' Then
        Begin
          FieldByName('GER_ENTDIR').AsString := 'S';
          FieldByName('GER_HORLIB').Value := fTime();
          FieldByName('GER_OPELIB').Value := strLoginUsuarioLogado;
          FieldByName('GER_UNICOM').Value := 'N';

          if (fCfgSis('FLUPDC', varBoolean)) then
          begin
            FieldByName('GER_ENTDIR').AsString := 'N';
            FieldByName('GER_DTACON').AsDateTime := VS_Date
          end
          Else
          Begin
            FieldByName('GER_DTALIB').AsDateTime := VS_Date;
            FieldByName('GER_CONDIR').AsString := 'S';
          End;

        End
        Else
          FieldByName('GER_ENTDIR').AsString := 'N';
      end;

      FieldByName('B02_CUF').AsString       := String(B02_CUF);
      FieldByName('B03_CNF').AsString       := String(B03_CNF);
      FieldByName('B04_NATOP').AsString     := String(B04_NATOP);
      FieldByName('B05_INDPAG').AsString    := String(B05_INDPAG);
      FieldByName('B06_MOD').AsString       := String(B06_MOD);
      FieldByName('B07_SERIE').AsString     := String(B07_SERIE);
      If FNotaImportacao And (Not fEmptyStr(strSerieNotGer)) Then
        FieldByName('B07_SERIE').AsString     := strSerieNotGer;
      FieldByName('B08_NNF').AsString       := String(B08_NNF);
      FieldByName('B09_DEMI').AsDateTime    := B09_DEMI;
      FieldByName('B10_DSAIENT').AsDateTime := B10_DSAIENT;
      FieldByName('B11_TPNF').AsString      := String(B11_TPNF);
  	  FieldByName('GER_IDDEST').AsInteger    := FGerele.B11A_IDDEST;
      FieldByName('B12_CMUNFG').AsString    := String(B12_CMUNFG);
      FieldByName('B21_TPIMP').AsString     := String(B21_TPIMP);
      FieldByName('B22_TPEMIS').AsString    := String(B22_TPEMIS);
      FieldByName('B24_TPAMB').AsString     := String(B24_TPAMB);
      FieldByName('B25_FINNFE').AsString    := String(B25_FINNFE);
      FieldByName('B25B_INDPRES').AsInteger := FGerEle.B25B_INDPRES;
      FieldByName('B26_PROCEMI').AsString   := String(B26_PROCEMI);
      FieldByName('C02_CNPJ').AsString      := String(C02_CNPJ);
      FieldByName('C02A_CPF').AsString      := String(C02A_CPF);
      FieldByName('C03_XNOME').AsString     := String(C03_XNOME);
      FieldByName('C04_XFANT').AsString     := String(C04_XFANT);
      FieldByName('C03_XLGR').AsString      := String(C03_XLGR);
      FieldByName('C07_NRO').AsString       := String(C07_NRO);
      FieldByName('C08_XCPL').AsString      := String(C08_XCPL);
      FieldByName('C09_XBAIRRO').AsString   := String(C09_XBAIRRO);
      FieldByName('C10_CMUN').AsString      := String(C10_CMUN);
      FieldByName('C11_XMUN').AsString      := String(C11_XMUN);
      FieldByName('C12_UF').AsString        := String(C12_UF);
      FieldByName('C13_CEP').AsString       := String(C13_CEP);
      FieldByName('C14_CPAIS').AsString     := String(C14_CPAIS);
      FieldByName('C15_XPAIS').AsString     := String(C15_XPAIS);
      FieldByName('C16_FONE').AsString      := String(C16_FONE);
      FieldByName('C17_IE').AsString        := String(C17_IE);
      FieldByName('C18_IEST').AsString      := String(C18_IEST);
      FieldByName('C19_IM').AsString        := String(C19_IM);
      FieldByName('C20_CNAE').AsString      := String(C20_CNAE);
      FieldByName('W03_VBC').AsFloat        := W03_VBC;
      FieldByName('W04_VICMS').AsFloat      := W04_VICMS;
      FieldByName('W04A_VICMSDESON').AsFloat:= W04A_VICMSDESON;
      FieldByName('W04H_VFCP').AsFloat      := W04H_VFCP;
      FieldByName('W05_VBCST').AsFloat      := W05_VBCST;
      FieldByName('W06_VST').AsFloat        := W06_VST;
      FieldByName('W06A_VFCPST').AsFloat    := W06A_VFCPST;
      FieldByName('W07_VPROD').AsFloat      := W07_VPROD;
      FieldByName('W08_VFRETE').AsFloat     := W08_VFRETE;
      FieldByName('W09_VSEG').AsFloat       := W09_VSEG;
      FieldByName('W10_VDESC').AsFloat      := W10_VDESC;
      FieldByName('W11_VII').AsFloat        := W11_VII;
      FieldByName('W12_VIPI').AsFloat       := W12_VIPI;
      FieldByName('W13_VPIS').AsFloat       := W13_VPIS;
      FieldByName('W14_VCOFINS').AsFloat    := W14_VCOFINS;
      FieldByName('W15_VOUTRO').AsFloat     := W15_VOUTRO;
      FieldByName('W16_VNF').AsFloat        := W16_VNF;
      FieldByName('W15_VSERV').AsFloat      := W15_VSERV;

      FieldByName('W18_VSERV').AsFloat        := W18_VSERV;
      FieldByName('W19_VBC').AsFloat          := W19_VBC;
      FieldByName('W20_VISS').AsFloat         := W20_VISS;
      FieldByName('W21_VPIS').AsFloat         := W21_VPIS;
      FieldByName('W22_VCOFINS').AsFloat      := W22_VCOFINS;
      FieldByName('W22A_DCOMPET').AsFloat     := W22A_DCOMPET;
      FieldByName('W22B_VDEDUCAO').AsFloat    := W22B_VDEDUCAO;
      FieldByName('W22D_VDESCINCOND').AsFloat := W22D_VDESCINCOND;

      FieldByName('W24_VRETPIS').AsFloat    := W24_VRETPIS;
      FieldByName('W25_VRETCOFINS').AsFloat := W25_VRETCOFINS;
      FieldByName('W26_VRETCSLL').AsFloat   := W26_VRETCSLL;
      FieldByName('W27_VBCIRRF').AsFloat    := W27_VBCIRRF;
      FieldByName('W28_VIRRF').AsFloat      := W28_VIRRF;
      FieldByName('W29_VBCRETPREV').AsFloat := W29_VBCRETPREV;
      FieldByName('W30_VRETPREV').AsFloat   := W30_VRETPREV;
      FieldByName('PR07_CHNFE').AsString    := PR07_CHNFE;
      FieldByName('X27_QVOL').AsFloat       := X27_QVOL;
      FieldByName('X28_ESP').AsString       := X28_ESP;
      FieldByName('X31_PESOL').AsFloat      := X31_PESOL;
      FieldByName('X32_PESOB').AsFloat      := X32_PESOB;
      FieldByName('X33_MODFRETE').AsString  := X33_MODFRETE;
      FieldByName('X34_CNPJ').AsString      := X34_CNPJ;
      FieldByName('GER_DTAIMP').AsDateTime  := Date;
      FieldByName('GER_HORIMP').AsDateTime  := fTime();
      FieldByName('GER_PREGNR').AsString    := IIf(FblnPreGnre, 'S', 'N');
      FieldByName('GER_MATREV').AsString    := fCampoTabela('FOR_MATREV', 'CADFOR', ['FOR_CODFOR'], [FGerEle.GER_CODFOR]);
      Post;
    End;

    If (FfinalidadeXML = xmlRetornoSimbolico) Then
    begin
      If cdsXML.Locate('ARQUIVO', FNomArq, []) Then
      begin
        cdsXML.Edit;
        cdsXML.FieldByName('AUTOINCREM').AsString := FSeqGer;
        cdsXML.FieldByName('STATUS_ENT').AsString := 'Aguardando confirmação da entrada';
        (cdsXML.FieldByName('B2W_ARQUIV') as TBlobField).LoadFromFile(FPatArq + FNomArq);
        cdsXML.FieldByName('MARCADO').AsInteger := 0;
        cdsXML.FieldByName('GER_CODEMP').AsString := strCodEmp;
        cdsXML.FieldByName('NOVOREG').AsInteger := 0;
        If Not fEmptyStr(cdsXML.FieldByName('ERRO_STATUS_XML').AsString) Then
        Begin
          cdsXML.FieldByName('STATUS_XML').AsString := 'XML Importado Com Sucesso!';
          cdsXML.FieldByName('ERRO_STATUS_XML').AsString := '';
        End;

        cdsXML.Post;
        pGravaNFEB2W;
      End;
    End;
    FGerEle.strAutInc :=  ShortString(FSeqGer);
    FGerEle.pGeraDados(lstDados);

    FreeAndNil(qryGerEle);
    Result := True;
    With qryGerEle, FGerEle Do
    Begin
      If (Not fEmptyStr(String(Z03_infCpl))) Or
         (Not fEmptyStr(String(Z02_infAdFisco))) Then
      Begin
        Try
          qryInfEle := fCriarQuery('SELECT * FROM INFELE WHERE FALSE', Self);
          With qryInfEle Do
          Begin
            Open;
            Insert;
            FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('INFELE', VS_strCodEmp);
            FieldByName('ELE_SEQELE').AsString := FSeqGer;
            FieldByName('Z03_INFCPL').AsWideString     := Z03_infCpl;
            FieldByName('Z02_INFADFISCO').AsWideString := Z02_infAdFisco;
            Post;
          End;

        Except
          On E: Exception Do
          Begin
            Result := False;
            pMensagensErro(E.Message, '[fGravaGerEle]');
          End;
        End;
        FreeAndNil(qryInfEle);        
      End;
    End;

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaGerEle]');
    End;

  End;

  If Result Then
  Begin
    Try
      qryDupEle := fCriarQuery('SELECT * FROM DUPELE WHERE FALSE', Self);
      For intCorre := 0 To High(FArrDupEle) Do
      Begin
        With FArrDupEle[intCorre], qryDupEle Do
        Begin
          Open;
          Insert;

          FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('DUPELE', VS_strCodEmp);
          FieldByName('DUP_SEQELE').AsString   := FSeqGer;
          FieldByName('DUP_NUMDUP').AsString   := Y08_NumDup;
          FieldByName('DUP_DTAVEN').AsDateTime := Y09_DtaVen;
          FieldByName('DUP_VALDUP').AsFloat    := Y10_VlrDup;

          Post;
          Close;

        End;

      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fGravaGerEle(DUPELE)]');
      End;
    End;
    FreeAndNil(qryDupEle);

  End;

End;

function TNFeXml.fGravaRetEle(recRetEle: TRecRetEle): Boolean;
  var
    qryRetEle: TUniQuery;
Begin
  Try
    If FErro Then
    Begin
      Result := TRUE;
      Exit;
    End;

    qryRetEle := fCriarQuery('SELECT * FROM RETELE WHERE FALSE', Self);

    qryRetEle.Open;
    qryRetEle.Insert;
    qryRetEle.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('RETELE', VS_strCodEmp);
    qryRetEle.FieldByName('RET_SEQGER').AsString := FSeqGer;
    qryRetEle.FieldByName('RET_REFNFE').AsString := String(recRetEle.strReferenciaNFe);
    qryRetEle.Post;

    FreeAndNil(qryRetEle);

    Result := TRUE;

  Except

    On E: Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message, '[fGravaRetEle]');
    End;

  End;

end;

Function TNFeXml.fGravaDetEle(recDetEle: TRecDetEle; intIndexLst : integer; intIndexItem: integer): Boolean;
  var
    qryDetEle: TUniQuery;
Begin
  Try
    If FErro Then
    Begin
      Result := TRUE;
      Exit;
    End;

    If objValidaNFeCapa.blnTemDivergencia Then
      If objValidaNFeCapa.fNotaAtual_Eh_divergente(intIndexLst) Then
        objValidaNFeCapa.pSetaValoresCorrigidos(recDetEle, intIndexItem);

    qryDetEle := fCriarQuery('SELECT * FROM DETELE WHERE FALSE', Self);

    With qryDetEle, recDetEle Do
    Begin
      Open;
      Insert;
      qryDetEle.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DETELE', VS_strCodEmp);
      recDetEle.strAutInc := ShortString(FieldByName('AUTOINCREM').AsString);
      FArrDetEle[intIndexItem].strAutInc := recDetEle.strAutInc;

      FieldByName('DET_SEQGER').AsString := FSeqGer;
      FieldByName('I02_NITEM').AsString := I02_NITEM;
      FieldByName('DET_CODITE').AsString := String(DET_CODITE);
      FieldByName('DET_CSTXML').AsString := String(DET_CSTXML);

      FieldByName('N11_ORIG').AsString   := String(N11_ORIG);
      FieldByName('N12_CST').AsString    := String(N12_CST);
      FieldByName('N12_CSOSN').AsString  := String(N12_CSOSN);
      FieldByName('N13_MODBC').AsString  := String(N13_MODBC);
      FieldByName('N14_PREDBC').AsFloat  := N14_PREDBC;
      FieldByName('N16B_PDIF').AsFloat   := N16b_PDIF;
      FieldByName('N15_VBC').AsFloat     := N15_VBC;
      FieldByName('N16_PICMS').AsFloat   := N16_PICMS;
      FieldByName('N17_VICMS').AsFloat   := N17_VICMS;
      FieldByName('N18_MODBCST').AsString:= String(N18_MODBCST);
      FieldByName('N19_PMVAST').AsFloat  := N19_PMVAST;
      FieldByName('N20_PREBCST').AsFloat := N20_PREBCST;
      FieldByName('N21_VBCST').AsFloat   := N21_VBCST;
      FieldByName('N22_PICMSST').AsFloat := N22_PICMSST;
      FieldByName('N23_VICMSST').AsFloat := N23_VICMSST;
      If blnVersao4 Then
      Begin
        FieldByName('N23A_VBCFCPST').AsFloat := N23A_VBCFCPST;

        FieldByName('N23B_PFCPST').AsFloat := N23B_PFCPST;
        FieldByName('N23D_FCPST').AsFloat := N23D_FCPST;

        FieldByName('N17A_VBCFCP').AsFloat := N17A_VBCFCP;
        FieldByName('N17B_PFCP').AsFloat := N17B_PFCP;
        FieldByName('N17C_VFCP').AsFloat := recDetEle.N17C_VFCP;
      End
      Else
      Begin
        FieldByName('N23A_VBCFCPST').AsFloat := 0;
        FieldByName('N23B_PFCPST').AsFloat := 0;
        FieldByName('N23D_FCPST').AsFloat := 0;
        FieldByName('N17A_VBCFCP').AsFloat := 0;
        FieldByName('N17B_PFCP').AsFloat := 0;
        FieldByName('N17C_VFCP').AsFloat := 0;
      End;

      FieldByName('N24_CREDSN').AsFloat     := N24_CREDSN;
      FieldByName('N24_CREDICMSSN').AsFloat := N24_CREDICMSSN;

      FieldByName('N27A_VICMSDESON').AsFloat := N27A_VICMSDESON;
      FieldByName('N27A_MOTDESICMS').AsString := String(N27A_MOTDESICMS);
      FieldByName('I02_CPROD').AsString  := String(I02_CPROD);

      FieldByName('I03_CEAN').AsString := String(I03_CEAN);

      If fEmptyStr(String(I03_CEAN)) Then
        FieldByName('I03_CEAN').Clear;

      FieldByName('I04_XPROD').AsString    := String(I04_XPROD);
      FieldByName('I05_NCM').AsString      := String(I05_NCM);
      FieldByName('I70_NFCI').AsString     := String(I70_NFCI);
      FieldByName('I06_EXTIPI').AsString   := String(I06_EXTIPI);
      FieldByName('I07_GENERO').AsString   := String(I07_GENERO);
      FieldByName('I08_CFOP').AsString     := String(I08_CFOP);
      FieldByName('I09_UCOM').AsString     := String(I09_UCOM);
      FieldByName('I10_QCOM').AsFloat      := I10_QCOM;
      FieldByName('I10A_VUNCOM').AsFloat   := I10A_VUNCOM;
      FieldByName('I11_VPROD').AsFloat     := I11_VPROD;
      FieldByName('I12_CEANTRIB').AsString := String(I12_CEANTRIB);
      FieldByName('I13_UTRIB').AsString    := String(I13_UTRIB);
      FieldByName('I14_QTRIB').AsFloat     := I14_QTRIB;
      FieldByName('I14A_VUNTRIB').AsFloat  := I14A_VUNTRIB;
      FieldByName('I15_VFRETE').AsFloat    := I15_VFRETE;
      FieldByName('I16_VSEG').AsFloat      := I16_VSEG;
      FieldByName('I16_VSEGIMP').AsFloat   := I16_VSEGIMP;
      FieldByName('I17_VDESC').AsFloat     := I17_VDESC;
      FieldByName('I17A_VOUTRO').AsFloat   := I17A_VOUTRO;
      FieldByName('O02_CLENQ').AsString    := String(O02_CLENQ);
      FieldByName('O07_IPITRIB').AsString  := String(O07_IPITRIB);
      FieldByName('O09_CST').AsString      := String(O09_CST);
      FieldByName('O10_VBC').AsFloat       := O10_VBC;
      FieldByName('O11_QUNID').AsFloat     := O11_QUNID;
      FieldByName('O12_VUNID').AsFloat     := O12_VUNID;
      FieldByName('O13_PIPI').AsFloat      := O13_PIPI;
      FieldByName('O14_VIPI').AsFloat      := O14_VIPI;
      FieldByName('Q06_CST').AsString      := String(Q06_CST);
      FieldByName('Q07_VBC').AsFloat       := Q07_VBC;
      FieldByName('Q08_PPIS').AsFloat      := Q08_PPIS;
      FieldByName('Q09_VPIS').AsFloat      := Q09_VPIS;
      FieldByName('Q10_QBCPROD').AsFloat   := Q10_QBCPROD;
      FieldByName('Q11_VALIQPROD').AsFloat := Q11_VALIQPROD;
      FieldByName('S06_CST').AsString      := String(S06_CST);
      FieldByName('S07_VBC').AsFloat       := S07_VBC;
      FieldByName('S08_PCOFINS').AsFloat   := S08_PCOFINS;
      FieldByName('S11_VCOFINS').AsFloat   := S11_VCOFINS;
      FieldByName('S09_QBCPROD').AsFloat   := S09_QBCPROD;
      FieldByName('S10_VALIQPROD').AsFloat := S10_VALIQPROD;
      FieldByName('S11_VCOFINS').AsFloat   := S11_VCOFINS;

      If (Not fEmptyStr(String(LA02_CPRODANP))) Then
        FieldByName('LA02_CPRODANP').AsString := String(LA02_CPRODANP);

      FieldByName('U02_VBC').AsFloat           := U02_VBC;
      FieldByName('U03_VALIQ').AsFloat         := U03_VALIQ;
      FieldByName('U04_VISSQN').AsFloat        := U04_VISSQN;
      FieldByName('U05_CMUNFG').AsString       := String(U05_CMUNFG);
      FieldByName('U06_CLISTSERV').AsString    := String(U06_CLISTSERV);
      FieldByName('U07_VDEDUCAO').AsFloat      := U07_VDEDUCAO;
      FieldByName('U09_VDESCINCOND').AsFloat   := U09_VDESCINCOND;
      FieldByName('U12_INDSS').AsString        := String(U12_INDSS);
      FieldByName('U14_CMUN').AsString         := String(U14_CMUN);
      FieldByName('U15_CPAIS').AsString        := String(U15_CPAIS);
      FieldByName('U17_INDINCENTIVO').AsString := String(U17_INDINCENTIVO);

      FieldByName('P04_VII').AsFloat      := P04_VII;
      FieldByName('I23B_VAFRMM').AsFloat  := I23B_VAFRMM;
      FieldByName('P03_VDESPADU').AsFloat := P03_VDESPADU;
      FieldByName('P05_VIOF').AsFloat := P05_VIOF;


      FieldByName('DET_VALIMP').AsFloat   := DET_VALIMP;
      FieldByName('DET_VALSIS').AsFloat   := DET_VALSIS;
      FieldByName('DET_BASSUB').AsFloat   := DET_BASSUB;

      If Not fEmptyStr(DET_CODMCO) Then
        FieldByName('DET_CODMCO').AsString := String(DET_CODMCO);

      FieldByName('XPED').AsString        := XPED;
      FieldByName('NITEMPED').AsString    := NITEMPED;

      FieldByName('N26_VBCSTRET').AsFloat    := N26_VBCSTRET;
      FieldByName('N27_VICMSSTRET').AsFloat  := N27_VICMSSTRET;
      FieldByName('N27_vICMSSubstituto').AsFloat  := N27_vICMSSubstituto;

      FieldByName('N34_PREDBCEEFET').AsFloat := N34_PREDBCEEFET;   // Percentual de redução da base de cálculo efetiva
      FieldByName('N35_VBCEFET').AsFloat     := N35_VBCEFET;       // Valor da base de cálculo efetiva
      FieldByName('N36_PICMSEFET').AsFloat   := N36_PICMSEFET;     // Alíquota do ICMS efetiva
      FieldByName('N37_VICMSEFET').AsFloat   := N37_VICMSEFET;     // Valor do ICMS efetivo

      FieldByName('N24_VBCUFDEST').AsFloat      := N24_VBCUFDEST;
      FieldByName('N24_VBCFCPUFDEST').AsFloat   := N24_VBCFCPUFDEST;
      FieldByName('N24_PFCPUFDEST').AsFloat     := N24_PFCPUFDEST;
      FieldByName('N24_PICMSUFDEST').AsFloat    := N24_PICMSUFDEST;
      FieldByName('N24_PICMSINTER').AsFloat     := N24_PICMSINTER;
      FieldByName('N24_PICMSINTERPART').AsFloat := N24_PICMSINTERPART;
      FieldByName('N24_VFCPUFDEST').AsFloat     := N24_VFCPUFDEST;
      FieldByName('N24_VICMSUFDEST').AsFloat    := N24_VICMSUFDEST;
      FieldByName('N24_VICMSUFREMET').AsFloat   := N24_VICMSUFREMET;

      FieldByName('N28_QICMSMONORET').AsFloat   := N28_QICMSMONORET;
      FieldByName('N28_ADBCMONORET').AsFloat    := N28_ADBCMONORET;
      FieldByName('N28_VREMICMSRET').AsFloat    := N28_VREMICMSRET;

      FieldByName('CAL_VLICMS').AsFloat   := CAL_VLICMS;
      FieldByName('CAL_BASICM').AsFloat   := CAL_BASICM;
      FieldByName('CAL_ALQICM').AsFloat   := CAL_ALQICM;
      FieldByName('CAL_BAS_ST').AsFloat   := CAL_BAS_ST;
      FieldByName('CAL_VR_IVA').AsFloat   := CAL_VR_IVA;
      FieldByName('CAL_VR_SUB').AsFloat   := CAL_VR_SUB;
      FieldByName('CAL_ALQINT').AsFloat   := CAL_ALQINT;
      FieldByName('CAL_VFCPST').AsFloat   := N23_VFCPST_GARE;
      FieldByName('DET_CALSTU').AsInteger := DET_CALSTU;

      If Assigned(FCdsIncon) Then
      Begin
        If FblnPreGnre Then
          If FCdsIncon.Locate('NUMDOC;SEQUEN;ELETRO', varArrayof([FGerEle.B08_NNF, intIndexItem, 'S']), []) Then
          Begin
            FieldByName('DET_VLRGNR').AsFloat:= FCdsIncon.FieldByName('VALGNR').AsFloat;
            If (FCdsIncon.FieldByName('VALGNR').AsFloat = FCdsIncon.FieldByName('VALGNR_ORIGINAL').AsFloat) Then
              FieldByName('DET_CALGNR').AsString  := strMemCalGNRE
            Else
              FieldByName('DET_CALGNR').AsString  := MSG_VLR_GNR_MANUAL;
          End;

          FCdsIncon.Filtered := False;
          FCdsIncon.Filter := 'NUMDOC = ' + QuotedStr(String(FGerEle.B08_NNF)) + ' AND SEQUEN = ' + IntToStr(intIndexItem);
          FCdsIncon.Filtered := True;

          While Not FCdsIncon.Eof Do
          Begin
            FCdsIncon.Edit;
            FCdsIncon.FieldByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
            FCdsIncon.Post;

            FCdsIncon.Next;
          End;
          FCdsIncon.Filtered := False;
      End;

      recDetEle.pGeraDados(lstDados);

      Post;
    End;

    FreeAndNil(qryDetEle);

    Result := TRUE;

  Except

    On E: Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message, '[fGravaDetEle]');
    End;

  End;

End;

Function TNFeXml.fGravaGerERT: Boolean;
  var
    qryGerERT: TUniQuery;
Begin
  Try
    If FErro Or (FGerEle.C14_CPAIS <> '1058') Then
    Begin
      Result := TRUE;
      Exit;
    End;
    qryGerERT := nil;
    try
      qryGerERT := fCriarQuery('SELECT * FROM GERERT WHERE FALSE', Self);

      qryGerERT.Open;
      qryGerERT.Insert;
      qryGerERT.FieldByName('AUTOINCREM').AsString            := FSeqGer;
      qryGerERT.FieldByName('W33_VIS').AsFloat                := FGerEle.RT_VIS;
      qryGerERT.FieldByName('W35_VBCIBSCBS').AsFloat          := FGerEle.RT_VBCIBSCBS;
      qryGerERT.FieldByName('W38_VDIF').AsFloat               := FGerEle.RT_VDIFIBSUF;
      qryGerERT.FieldByName('W39_VDEVTRIB').AsFloat           := FGerEle.RT_VDEVIBSUF;
      qryGerERT.FieldByName('W41_VIBSUF').AsFloat             := FGerEle.RT_VIBSUF;
      qryGerERT.FieldByName('W43_VDIF').AsFloat               := FGerEle.RT_VDIFMUN;
      qryGerERT.FieldByName('W44_VDEVTRIB').AsFloat           := FGerEle.RT_VDEVMUN;
      qryGerERT.FieldByName('W46_VIBSMUN').AsFloat            := FGerEle.RT_VIBSMUN;
      qryGerERT.FieldByName('W47_VIBS').AsFloat               := FGerEle.RT_VIBS;
      qryGerERT.FieldByName('W48_VCREDPRES').AsFloat          := FGerEle.RT_VCREDPRES;
      qryGerERT.FieldByName('W49_VCREDPRESCONDSUS').AsFloat   := FGerEle.RT_VCREDPRECS;
      qryGerERT.FieldByName('W53_VDIF').AsFloat               := FGerEle.RT_VDIFCBS;
      qryGerERT.FieldByName('W54_VDEVTRIB').AsFloat           := FGerEle.RT_VDEVCBS;
      qryGerERT.FieldByName('W56_VCBS').AsFloat               := FGerEle.RT_VCBS;
      qryGerERT.FieldByName('W56A_VCREDPRES').AsFloat         := FGerEle.RT_VCREDPRESCBS;
      qryGerERT.FieldByName('W56B_VCREDPRESCONDSU').AsFloat   := FGerEle.RT_VCREDPRECCBS;
      qryGerERT.FieldByName('W58_VIBSMONO').AsFloat           := 0;
      qryGerERT.FieldByName('W59_VCBSMONO').AsFloat           := 0;
      qryGerERT.FieldByName('W59A_VIBSMONORETEN').AsFloat     := 0;
      qryGerERT.FieldByName('W59B_VCBSMONORETEN').AsFloat     := 0;
      qryGerERT.FieldByName('W59C_VIBSMONORET').AsFloat       := 0;
      qryGerERT.FieldByName('W59D_VCBSMONORET').AsFloat       := 0;
      qryGerERT.FieldByName('W16_VNFTOT').AsFloat             := FGerEle.RT_VNFTOT;
      qryGerERT.Post;
      Result := TRUE;
    finally
      If Assigned(qryGerERT) then
        FreeAndNil(qryGerERT);
    End;

  Except
    On E: Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message, '[fGravaGerERT]');
    End;
  End;
End;

Function TNFeXml.fGravaDetERT(recDetEle: TRecDetEle; strAutoIncDetEle: string): Boolean;
  var
    qryDetERT: TUniQuery;
Begin
  Try
    If FErro Or (FGerEle.C14_CPAIS <> '1058') Then
    Begin
      Result := TRUE;
      Exit;
    End;
    qryDetERT := nil;
    try
      qryDetERT := fCriarQuery('SELECT * FROM DETERT WHERE FALSE', Self);

      qryDetERT.Open;
      qryDetERT.Insert;
      qryDetERT.FieldByName('AUTOINCREM').AsString            := strAutoIncDetEle;
      qryDetERT.FieldByName('UB02_CSTIS').AsString            := String(recDetEle.RT_CSTIS);
      qryDetERT.FieldByName('UB03_CCLASSTRIBIS').AsString     := String(recDetEle.RT_CLATRIAIS);
      qryDetERT.FieldByName('UB05_VBCIS').AsFloat             := recDetEle.RT_VBCIS;
      qryDetERT.FieldByName('UB06_PIS').AsFloat               := recDetEle.RT_PAIS;
      qryDetERT.FieldByName('UB07_PISESPEC').AsFloat          := recDetEle.RT_PAISESP;
      qryDetERT.FieldByName('UB09_UTRIB').AsString            := String(recDetEle.RT_UTRIB);
      qryDetERT.FieldByName('UB10_QTRIB').AsFloat             := recDetEle.RT_QTRIB;
      qryDetERT.FieldByName('UB11_VIS').AsFloat               := recDetEle.RT_VIS;
      qryDetERT.FieldByName('UB13_CST').AsString              := String(recDetEle.RT_CST);
      qryDetERT.FieldByName('UB14_CCLASSTRIB').AsString       := String(recDetEle.RT_CLATRIB);
      qryDetERT.FieldByName('UB16_VBC').AsFloat               := recDetEle.RT_VBC;
      qryDetERT.FieldByName('UB18_PIBSUF').AsFloat            := recDetEle.RT_PIBSUF;
      qryDetERT.FieldByName('UB23_VDIF').AsFloat              := recDetEle.RT_VDIFUF;
      qryDetERT.FieldByName('UB22_PDIF').AsFloat              := recDetEle.RT_PDIFUF;
      qryDetERT.FieldByName('UB25_VDEVTRIB').AsFloat          := recDetEle.RT_VDEVUF;
      qryDetERT.FieldByName('UB27_PREDALIQ').AsFloat          := recDetEle.RT_PREDUF;
      qryDetERT.FieldByName('UB28_PALIQEFET').AsFloat         := recDetEle.RT_PEFETUF;
      qryDetERT.FieldByName('UB35_VIBSUF').AsFloat            := recDetEle.RT_VIBSUF;
      qryDetERT.FieldByName('UB37_PIBSMUN').AsFloat           := recDetEle.RT_PIBSMUN;
      qryDetERT.FieldByName('UB41_PDIF').AsFloat              := recDetEle.RT_PDIFMUN;
      qryDetERT.FieldByName('UB42_VDIF').AsFloat              := recDetEle.RT_VDIFMUN;
      qryDetERT.FieldByName('UB44_VDEVTRIB').AsFloat          := recDetEle.RT_VDEVMUN;
      qryDetERT.FieldByName('UB46_PREDALIQ').AsFloat          := recDetEle.RT_PREDMUN;
      qryDetERT.FieldByName('UB47_PALIQEFET').AsFloat         := recDetEle.RT_PEFETMUN;
      qryDetERT.FieldByName('UB54_VIBSMUN').AsFloat           := recDetEle.RT_VIBSMUN;
      qryDetERT.FieldByName('UB55_VIBS').AsFloat              := recDetEle.RT_VIBS;
      qryDetERT.FieldByName('UB56_PCBS').AsFloat              := recDetEle.RT_PCBS;
      qryDetERT.FieldByName('UB60_PDIF').AsFloat              := recDetEle.RT_PDIFCBS;
      qryDetERT.FieldByName('UB61_VDIF').AsFloat              := recDetEle.RT_VDIFCBS;
      qryDetERT.FieldByName('UB63_VDEVTRIB').AsFloat          := recDetEle.RT_VDEVCBS;
      qryDetERT.FieldByName('UB65_PREDALIQ').AsFloat          := recDetEle.RT_PREDCBS;
      qryDetERT.FieldByName('UB66_PALIQEFET').AsFloat         := recDetEle.RT_PEFETCBS;
      qryDetERT.FieldByName('UB67_VCBS').AsFloat              := recDetEle.RT_VCBS;
      qryDetERT.FieldByName('UB69_CSTREG').AsString           := String(recDetEle.RT_CSTREG);
      qryDetERT.FieldByName('UB70_CCLASSTRIBREG').AsString    := String(recDetEle.RT_CLATRIREG);
      qryDetERT.FieldByName('UB71_PALIQEFETREGIBS').AsFloat   := recDetEle.RT_PEFIBSUF;
      qryDetERT.FieldByName('UB72_VTRIBREGIBSUF').AsFloat     := recDetEle.RT_VTRIBUF;
      qryDetERT.FieldByName('UB72A_PALIQEFETREGIB').AsFloat   := recDetEle.RT_PEFIBSMUN;
      qryDetERT.FieldByName('UB72B_VTRIBREGIBSMUN').AsFloat   := recDetEle.RT_VTRIBMUN;
      qryDetERT.FieldByName('UB72C_PALIQEFETREGCB').AsFloat   := recDetEle.RT_PEFCBS;
      qryDetERT.FieldByName('UB72D_VTRIBREGCBS').AsFloat      := recDetEle.RT_VTRIBCBS;
      qryDetERT.Post;

      Result := TRUE;
    finally
      If Assigned(qryDetERT) then
        FreeAndNil(qryDetERT);
    End;

  Except
    On E: Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message, '[fGravaDetERT]');
    End;
  End;
End;

Function TNFeXml.fGravaNotaAjuste: Boolean;
  var
    qryEntMer       : TUniQuery;
    strAutIncMovGer : String;
    strAutIncMovDet : String;
    strAutIncCadFis : String;
    strCFOP         : String;
    strEmpUF        : String;
    strHist01       : String;
    strHist02       : String;
    strHistTipo     : String;
    arrDuplic       : TarrDuplicata;
    recServicos     : TDadosServicos;
    objDet          : TMovDetParams;
    objFis          : TCadFisParams;
    intI            : Integer;
    DataHora: TDateTime;
Begin
  Try
    If FErro Then
    Begin
      Result := TRUE;
      Exit;
    End;

    If not ((String(FGerEle.B25_FINNFE) = '5') And (String(FGerEle.B25_TPNFCREDITO) = '04') or
            (String(FGerEle.B25_FINNFE) = '6') And (String(FGerEle.B25_TPNFDEBITO) = '04')) then
      Exit(True);

    strEmpUF := fCampoTabela('CID_ESTADO',
      'CADEMP INNER JOIN CADCID ON CID_CODCID = EMP_CODCID',
      ['EMP_CODEMP'], [VS_strCodEmp]);

    If String(FGerEle.C12_UF) = strEmpUF Then
      strCFOP := '1949'
    Else
      strCFOP := '2949';

    If String(FGerEle.B25_FINNFE) = '6' Then
      strHistTipo := 'DEBITO'
    Else
      strHistTipo := 'CREDITO';

    strHist01 := 'NOTA AJUSTE ' + strHistTipo + ' NF ' + String(FGerEle.B08_NNF);

    strHist02 := 'REF NF ORIG:';
    For intI := 0 to fGetRetCount - 1 Do
      strHist02 := strHist02 + ' ' + getRetornoReferencia[intI].strReferenciaNFe;
    Result := False;
    if fCarregaItensNotaEletronica(String(FGerEle.strAutInc), VS_strCodEmp, xmlEntradaMercadoria) Then
    begin
      DataHora := fNow;
      Result := fGravaMovGer(strAutIncMovGer,                                     //strAutInc
                   String(FGerEle.B08_NNF),                            //strNumDoc
                   'NF',                                                //strEspDoc
                   VS_strCodEmp,                                        //strCodEmp
                   '',                                                  //strCodTra
                   strLoginUsuarioLogado,                               //strCodVen
                   String(FGerEle.GER_CODFOR),                         //strCodFor
                   '',                                                  //strCodCli
                   'F',                                                 //strTip_Fc
                   DataHora,                                            //dtaDtaEnt
                   DataHora,                                            //tmrHorEnt
                   FGerEle.B09_DEMI,                                    //dtaDtaDoc
                   '01000',                                             //strConPag
                   String(FGerEle.C12_UF),                             //strEstado
                   '',                                                  //strNomCon
                   '',                                                  //strEndCon
                   '',                                                  //strBaiCon
                   '',                                                  //strCepCon
                   '',                                                  //strCidCon
                   '',                                                  //strEstCon
                   '',                                                  //strTelCon
                   0,                                                   //dtaNasCon
                   '',                                                  //strCgcCpf
                   '',                                                  //strCgcCon
                   '',                                                  //strIesCon
                   '',                                                  //strCli_Rg
                   0,                                                   //fltBasSim
                   0,                                                   //fltBasIpi
                   0,                                                   //fltAlqIpi
                   0,                                                   //fltTotIpi
                   0,                                                   //fltBasIcm
                   0,                                                   //fltAlqIcm
                   0,                                                   //fltTotIcm
                   0,                                                   //fltTotRet
                   0,                                                   //fltAlqRet
                   0,                                                   //fltBasRet
                   0,                                                   //fltRet_SP
                   0,                                                   //fltDesEsp
                   FGerEle.W16_VNF,                                     //fltVlrCon
                   FGerEle.W16_VNF,                                     //fltTotPro
                   0,                                                   //fltTotCus
                   0,                                                   //fltTotMed
                   '1',                                                 //strTipFre
                   0,                                                   //fltTotFre
                   0,                                                   //fltPesBru
                   0,                                                   //fltPesLiq
                   0,                                                   //fltVolume
                   '',                                                  //strEspeci
                   '',                                                  //strMarca
                   strHist01,                                           //strMen001
                   strHist02,                                           //strMen002
                   '',                                                  //strMen003
                   '',                                                  //strMen004
                   '',                                                  //strMen005
                   False,                                               //blnJafatu
                   '',                                                  //strTipFat
                   '',                                                  //strNumFat
                   '',                                                  //strEmpFat
                   0,                                                   //dtaDtaFat
                   '',                                                  //strVenFat
                   '',                                                  //strCndFat
                   False,                                               //blnDevEsp
                   0,                                                   //fltValFat
                   0,                                                   //fltVPar01
                   0,                                                   //fltVPar02
                   0,                                                   //fltVPar03
                   0,                                                   //fltVPar04
                   0,                                                   //fltVPar05
                   0,                                                   //fltVPar06
                   0,                                                   //fltVPar07
                   0,                                                   //fltVPar08
                   0,                                                   //fltVPar09
                   0,                                                   //fltVPar10
                   0,                                                   //fltVPar11
                   0,                                                   //fltVPar12
                   arrDuplic,                                           //arrDuplic
                   String(FGerEle.B07_SERIE),                          //strSerie
                   'N',                                                 //strNotEsp
                   strCFOP,                                             //strClaFis
                   '',                                                  //strClaFi2
                   '',                                                  //strClaFi3
                   String(FGerEle.B04_NATOP),                          //strNatOpe
                   0,                                                   //fltPorDes
                   strLoginUsuarioLogado,                               //strCodDig
                   '',                                                  //strCodCnd
                   '001',                                               //strCodFpg
                   0,                                                   //fltFatNot
                   recServicos,                                         //recServicos
                   0,                                                   //fltDesAce
                   'C',                                                 //strOriDoc
                   '',                                                  //strConEnt
                   strLoginUsuarioLogado,                               //strCodRep
                   0,                                                   //fltAlqIrf
                   0,                                                   //fltValIrf
                   0,                                                   //fltAlqPis
                   0,                                                   //fltValPis
                   0,                                                   //fltAlqCof
                   0,                                                   //fltValCof
                   0,                                                   //fltAlqCsl
                   0,                                                   //fltValCsL
                   0,                                                   //fltIrfRet
                   0,                                                   //fltPisRet
                   0,                                                   //fltCofRet
                   0,                                                   //fltCslRet
                   '',                                                  //strNotRet
                   0,                                                   //fltAlIrfP
                   0,                                                   //fltAlPisP
                   0,                                                   //fltAlCofP
                   0,                                                   //fltAlCslP
                   0,                                                   //fltSerRet
                   '',                                                  //strNoReSe
                   0,                                                   //fltPeSgSo
                   0,                                                   //fltVlSgSo
                   0,                                                   //fltIrPrRt
                   0,                                                   //fltIrPrDv
                   0,                                                   //fltIrSeRt
                   0,                                                   //fltIrSeDv
                   0,                                                   //fltPiPrRt
                   0,                                                   //fltPiPrDv
                   0,                                                   //fltPiSeRt
                   0,                                                   //fltPiSeDv
                   0,                                                   //fltCoPrRt
                   0,                                                   //fltCoPrDv
                   0,                                                   //fltCoSeRt
                   0,                                                   //fltCoSeDv
                   0,                                                   //fltCsPrRt
                   0,                                                   //fltCsPrDv
                   0,                                                   //fltCsSeRt
                   0,                                                   //fltCsSeDv
                   '',                                                  //strOrdPro
                   0,                                                   //fltBasOrg
                   0,                                                   //fltIcmOrg
                   0,                                                   //intNConhe
                   'N',                                                 //strConsum
                   'N',                                                 //strEntFat
                   '',                                                  //strCliFat
                   '',                                                  //strOpeExp
                   '',                                                  //strSepExp
                   '1',                                                 //strTabPre
                   '',                                                  //strNum_Pr
                   'N',                                                 //strEntFut
                   False,                                               //blnBaiFut
                   0,                                                   //fltMargem
                   0,                                                   //fltBaRtSp
                   0,                                                   //fltVlRtSp
                   'N',                                                 //strOprFlj
                   '',                                                  //strNumReg
                   FGerEle.B09_DEMI,                                    //dtaDtEntr
                   '',                                                  //strClaFi4
                   '',                                                  //strClaFi5
                   '',                                                  //strClaFi6
                   '',                                                  //strClaFi7
                   '',                                                  //strClaFi8
                   '',                                                  //strCodOco
                   '',                                                  //strFasObr
                   False,                                               //blnIpDpNf
                   0,                                                   //fltValCre
                   0,                                                   //dtadtlBex
                   '',                                                  //strEmlCon
                   0,                                                   //dtaDtESNf
                   0,                                                   //tmrHrESNf
                   Nil,                                                 //objFinanc
                   '',                                                  //strDocCon
                   '',                                                  //strCodObr
                   '',                                                  //strCodArt
                   'N',                                                 //strPermut
                   '',                                                  //strRetIss
                   '',                                                  //strOpcDoc
                   0,                                                   //fltFreSug
                   '',                                                  //strNumAde
                   0,                                                   //fltBasAnt
                   0,                                                   //fltValAnt
                   '',                                                  //strNaoAtu
                   '',                                                  //strEntUrg
                   '',                                                  //strMenExp
                   '',                                                  //strMenEx2
                   '',                                                  //strMenEx3
                   '',                                                  //strMenEx4
                   0,                                                   //fltDupRec
                   0,                                                   //fltValAdt
                   0,                                                   //fltDeDVCf
                   '',                                                  //strPlaVei
                   '',                                                  //strKm_Vei
                   '',                                                  //strCliOri
                   '',                                                  //strCodMot
                   '',                                                  //strBetone
                   '',                                                  //strLacre_
                   '',                                                  //strTipMps
                   '',                                                  //strAbatim
                   '',                                                  //strBrita_
                   '',                                                  //strConBom
                   0,                                                   //intFckDia
                   0,                                                   //fltImpPag
                   0,                                                   //intPrzMed
                   False,                                               //blnImpPdv
                   False,                                               //blnDTEXREP
                   '',                                                  //strChvNfeDev
                   '',                                                  //strOpeSol
                   False,                                               //blnEst_Dv
                   '',                                                  //strNumCOODev
                   '',                                                  //strNumSerDev
                   '',                                                  //strNumUSUDev
                   '',                                                  //strTipDocDev
                   0,                                                   //fltTotDif
                   Nil,                                                 //objFazenda
                   0,                                                   //fltFedImp
                   0,                                                   //fltEstImp
                   0,                                                   //fltMunImp
                   0,                                                   //fltTroco_
                   '',                                                  //strObsNfeFis
                   'N',                                                 //strVenPre
                   '',                                                  //strSeqDocOri
                   False,                                               //blnConEqu
                   False,                                               //blnDescIncond
                   False,                                               //blnGraCTP -- CADPAG tratado por fGravaCadPag
                   '',                                                  //strNumera
                   'N',                                                 //strEdiPes
                   0,                                                   //fltTaxEnt
                   0,                                                   //fltVrdIcm
                   0,                                                   //fltBasVrd
                   0,                                                   //intNroBox
                   '',                                                  //strCodEmbarcacao
                   0,                                                   //fltTotBri
                   '',                                                  //strTraRdp
                   '',                                                  //strCliCtt
                   '',                                                  //strCodMod
                   '',                                                  //strNumGui
                   '',                                                  //strHisCom
                   '',                                                  //strCodPrj
                   '',                                                  //strNatCfo
                   '',                                                  //strTpOper
                   '',                                                  //strCupDes
                   'S',                                                 //strNotPau
                   0,                                                   //fltCotMoe
                   0,                                                   //fltFreMkp
                   0,                                                   //fltComMkp
                   '',                                                  //strPlaFat
                   False,                                               //blnDevWms
                   False,                                               //blnFulfillmentModoRobo
                   0,                                                   //fltFreCot
                   0,                                                   //fltFreRat
                   'N',                                                 //strEntSim
                   '',                                                  //strSeqDmp
                   '',                                                  //strEntFutOpc
                   0,                                                   //fltTotIpiEntFut
                   0,                                                   //fltTotRetEntFut
                   0,                                                   //fltTotFcpSTEntFut
                   0,                                                   //fltICMDes
                   0,                                                   //fltDesPis
                   '',                                                  //strOpFaEx
                   '',                                                  //strDocAba
                   '',                                                  //strEspAba
                   '',                                                  //strEmpAba
                   '',                                                  //strCliAba
                   False,                                               //blnColeta
                   '',                                                  //strNumeroRandomico
                   '',                                                  //strNumeroDrawback
                   '',                                                  //strCodFinalidadeAjuste
                   '',                                                  //strDoc_RE
                   '',                                                  //strEsp_RE
                   '',                                                  //strEmp_RE
                   '',                                                  //strCli_RE
                   '',                                                  //strDocRE2
                   '',                                                  //strEspRE2
                   '',                                                  //strEmpRE2
                   '',                                                  //strCliRE2
                   '',                                                  //strEmp_TE
                   '',                                                  //strAutIcv
                   '',                                                  //strEmp_PR
                   '',                                                  //strCliCEO
                   0,                                                   //fltVolSepExc
                   0,                                                   //fltVolSepNExc
                   '',                                                  //strSupGer
                   '',                                                  //strSupReg
                   '',                                                  //strCelCon
                   'N',                                                 //strAbaDep
                   '',                                                  //strEmpDep
                   '',                                                  //strAbf_Uf
                   '',                                                  //strEstornoNotaFiscal
                   '',                                                  //strCodTpA
                   '',                                                  //strMatRev
                   '',                                                  //strVchCdp
                   '',                                                  //strCodCno
                   FGerEle.RT_VIBS,                                     //fltTotIbs
                   FGerEle.RT_VCBS,                                     //fltTotCbs
                   FGerEle.RT_VIS,                                      //fltTotIs
                   0,                                                   //fltTotProIs
                   FGerEle.RT_VNFTOT                                    //fltTotNf
                  );
      If not Result then
        Exit;
      qryEntMer := fCriarQuery('SELECT * FROM TMP_ENTMER', Self);
      Try
        qryEntMer.Open;
        strAutIncMovDet := '';
        If not qryEntMer.IsEmpty then
          strAutIncMovDet  := fRetAutoincrem('MOVDET', VS_StrCodEmp, qryEntMer.RecordCount);

        While Not qryEntMer.Eof Do
        Begin
          If Not fEmptyStr(qryEntMer.FieldByName('ENT_CODITE').AsString) Then
          Begin
            objDet.Init;
            objDet.strRefCodCst  := qryEntMer.FieldByName('ENT_REFCST').AsString;
            objDet.strRefClaTri  := qryEntMer.FieldByName('ENT_REFCLA').AsString;
            objDet.fltRefValOpe  := qryEntMer.FieldByName('ENT_REFVBC').AsFloat;
            objDet.fltRefBasCal  := qryEntMer.FieldByName('ENT_REFVBC').AsFloat;
            objDet.fltRefCbsAlq  := qryEntMer.FieldByName('ENT_RFCALQ').AsFloat;
            objDet.fltRefCbsAlD  := qryEntMer.FieldByName('ENT_RFCALD').AsFloat;
            objDet.fltRefCbsVlD  := qryEntMer.FieldByName('ENT_RFCVLD').AsFloat;
            objDet.fltRefCbsAlR  := qryEntMer.FieldByName('ENT_RFCALR').AsFloat;
            objDet.fltRefCbsVlT  := qryEntMer.FieldByName('ENT_RFCVLT').AsFloat;
            objDet.fltRefCbsAlE  := qryEntMer.FieldByName('ENT_RFCALE').AsFloat;
            objDet.fltRefCbsVal  := qryEntMer.FieldByName('ENT_RFCVAL').AsFloat;
            objDet.fltRefIbsUfA  := qryEntMer.FieldByName('ENT_RFIUFA').AsFloat;
            objDet.fltRefIbsUfD  := qryEntMer.FieldByName('ENT_RFIUFD').AsFloat;
            objDet.fltRefIbsUvD  := qryEntMer.FieldByName('ENT_RFIUVD').AsFloat;
            objDet.fltRefIbsUfR  := qryEntMer.FieldByName('ENT_RFIUFR').AsFloat;
            objDet.fltRefIbsUfT  := qryEntMer.FieldByName('ENT_RFIUFT').AsFloat;
            objDet.fltRefIbsUfE  := qryEntMer.FieldByName('ENT_RFIUFE').AsFloat;
            objDet.fltRefIbsUfV  := qryEntMer.FieldByName('ENT_RFIUFV').AsFloat;
            objDet.fltRefIbsMnA  := qryEntMer.FieldByName('ENT_RFIMNA').AsFloat;
            objDet.fltRefIbsMnD  := qryEntMer.FieldByName('ENT_RFIMND').AsFloat;
            objDet.fltRefIbsMvD  := qryEntMer.FieldByName('ENT_RFIMVD').AsFloat;
            objDet.fltRefIbsMnR  := qryEntMer.FieldByName('ENT_RFIMNR').AsFloat;
            objDet.fltRefIbsMnT  := qryEntMer.FieldByName('ENT_RFIMNT').AsFloat;
            objDet.fltRefIbsMnE  := qryEntMer.FieldByName('ENT_RFIMNE').AsFloat;
            objDet.fltRefIbsMnV  := qryEntMer.FieldByName('ENT_RFIMNV').AsFloat;
            objDet.strRefSelCst  := qryEntMer.FieldByName('ENT_RFSCST').AsString;
            objDet.strRefSelCla  := qryEntMer.FieldByName('ENT_RFSCLA').AsString;
            objDet.fltRefSelBas  := qryEntMer.FieldByName('ENT_RFSBAS').AsFloat;
            objDet.fltRefSelAlq  := qryEntMer.FieldByName('ENT_RFSALQ').AsFloat;
            objDet.fltRefSelVal  := qryEntMer.FieldByName('ENT_RFSVLR').AsFloat;
            objDet.fltRefValIbs  := qryEntMer.FieldByName('ENT_RFIVAL').AsFloat;
            objDet.strRefCstReg  := qryEntMer.FieldByName('ENT_RFRCST').AsString;
            objDet.strRefClaReg  := qryEntMer.FieldByName('ENT_RFRCLA').AsString;
            objDet.fltRefAiuReg  := qryEntMer.FieldByName('ENT_RFRUFA').AsFloat;
            objDet.fltRefTiuReg  := qryEntMer.FieldByName('ENT_RFRUVT').AsFloat;
            objDet.fltRefAimReg  := qryEntMer.FieldByName('ENT_RFRUMA').AsFloat;
            objDet.fltRefTimReg  := qryEntMer.FieldByName('ENT_RFRUMT').AsFloat;
            objDet.fltRefCbsReg  := qryEntMer.FieldByName('ENT_RFRUCA').AsFloat;
            objDet.fltRefTcbReg  := qryEntMer.FieldByName('ENT_RFRUCB').AsFloat;
            Result := Result And fGravaMovDetSimplificada(strAutIncMovDet,                                         //strAutInc
                                     strAutIncMovGer,                                         //strSeqGer
                                     String(FGerEle.B08_NNF),                                //strNumDoc
                                     'NF',                                                    //strEspDoc
                                     VS_strCodEmp,                                            //strCodEmp
                                     qryEntMer.FieldByName('ENT_CODITE').AsString,            //strCodIte
                                     strLoginUsuarioLogado,                                   //strCodVen
                                     '',                                                      //strCodDiv
                                     '',                                                      //strCodMar
                                     String(FGerEle.GER_CODFOR),                             //strCodFor
                                     '',                                                      //strCodCli
                                     DataHora,                                                //dtaDtaEnt
                                     DataHora,                                                //dtaHorEnt
                                     FGerEle.B09_DEMI,                                        //dtaDtaDoc
                                     '01000',                                                 //strConPag
                                     'F',                                                     //strTip_Fc
                                     String(FGerEle.C12_UF),                                 //strEstado
                                     qryEntMer.FieldByName('ENT_DESITE').AsString,            //strDescri
                                     qryEntMer.FieldByName('ENT_REFERE').AsString,            //strRefere
                                     qryEntMer.FieldByName('ENT_CODUNI').AsString,            //strUnidad
                                     '',                                                      //strForIte
                                     qryEntMer.FieldByName('ENT_QTDITE').AsFloat,             //fltQtdIte
                                     qryEntMer.FieldByName('ENT_UNITAR').AsFloat,             //fltUnitar
                                     qryEntMer.FieldByName('ENT_UNITAR').AsFloat,             //fltUniOri
                                     qryEntMer.FieldByName('ENT_UNITAR').AsFloat,             //fltUniVis
                                     qryEntMer.FieldByName('ENT_TOTITE').AsFloat,             //fltTotIte
                                     qryEntMer.FieldByName('ENT_VLRCON').AsFloat,             //fltVlrCon
                                     0,                                                       //fltTotCus
                                     0,                                                       //fltTotMed
                                     0,                                                       //fltDesCon
                                     0,                                                       //fltTotFre
                                     0,                                                       //fltDesEsp
                                     strLoginUsuarioLogado,                                   //strCodRep
                                     strLoginUsuarioLogado,                                   //strCodVe2
                                     0,                                                       //fltPerCom
                                     0,                                                       //fltTotCom
                                     0,                                                       //fltTotCo2
                                     strCFOP,                                                 //strClaFis
                                     qryEntMer.FieldByName('ENT_CODFIS').AsString,            //strCodFis
                                     0,                                                       //fltValIpi
                                     0,                                                       //fltAlqIpi
                                     0,                                                       //fltBasIpi
                                     0,                                                       //fltValIcm
                                     0,                                                       //fltAlqIcm
                                     0,                                                       //fltBasIcm
                                     0,                                                       //fltValRet
                                     0,                                                       //fltAlqRet
                                     0,                                                       //fltBasRet
                                     0,                                                       //fltTotPes
                                     0,                                                       //fltPerBas
                                     0,                                                       //fltPerRed
                                     False,                                                   //blnJafatu
                                     '',                                                      //strTipFat
                                     '',                                                      //strNumFat
                                     '',                                                      //strEmpFat
                                     0,                                                       //dtaDtaFat
                                     '',                                                      //strVenFat
                                     '',                                                      //strCndFat
                                     0,                                                       //fltValFat
                                     'NOR',                                                   //strIdePro
                                     qryEntMer.FieldByName('ENT_INCPIS').AsString,            //strIncPis
                                     String(FGerEle.B07_SERIE),                              //strSerie
                                     0,                                                       //fltDesAce
                                     'N',                                                     //strNotEsp
                                     '',                                                      //strDocDev
                                     '',                                                      //strEspDev
                                     '',                                                      //strEmpDev
                                     '',                                                      //strIteCha
                                     '',                                                      //strIteTin
                                     '',                                                      //strDesCor
                                     '',                                                      //strTipEmb
                                     0,                                                       //fltQtdEmb
                                     0,                                                       //fltPreEmb
                                     '',                                                      //strTipPre
                                     0,                                                       //fltPrvTin
                                     0,                                                       //fltPrcTin
                                     0,                                                       //fltFatTin
                                     'N',                                                     //strProEmb
                                     strLoginUsuarioLogado,                                   //strCodDig
                                     '',                                                      //strCodCnd
                                     '001',                                                   //strCodFpg
                                     '',                                                      //strIteEmb
                                     '',                                                      //strGruEmb
                                     0,                                                       //intLazQua
                                     'N',                                                     //strPromoc
                                     '',                                                      //strSeqTin
                                     0,                                                       //fltQtdPul
                                     '',                                                      //strPedCom
                                     'C',                                                     //strOriDoc
                                     '',                                                      //strNum_Pd
                                     '',                                                      //strEsp_Pd
                                     '',                                                      //strEmp_Pd
                                     0,                                                       //intInd_Pd
                                     '',                                                      //strOrdPro
                                     '',                                                      //strDesNes
                                     '',                                                      //strCliFat
                                     0,                                                       //fltBcaMin
                                     0,                                                       //fltBcaCom
                                     0,                                                       //fltVolPro
                                     '',                                                      //strCodAca
                                     '',                                                      //strEmpAca
                                     False,                                                   //blnProAca
                                     True,                                                    //blnFilKar -- sem movimentacao de estoque
                                     '',                                                      //strEspFut
                                     '',                                                      //strDocFut
                                     '',                                                      //strEmpFut
                                     '1',                                                     //strTabPre
                                     '',                                                      //strEmpCom
                                     '',                                                      //strLinha
                                     '',                                                      //strCatali
                                     '',                                                      //strCodDil
                                     0,                                                       //fltPorDil
                                     '',                                                      //strDilCon
                                     0,                                                       //fltPorCat
                                     qryEntMer.FieldByName('ENT_UNITAR').AsFloat,             //fltUniDig
                                     0,                                                       //fltQtdPon
                                     'N',                                                     //strEntFut
                                     '',                                                      //strMotFut
                                     FGerEle.B09_DEMI,                                        //dtaDtaFut
                                     0,                                                       //fltTotCu2
                                     0,                                                       //fltComRep
                                     0,                                                       //fltPerRep
                                     '',                                                      //strKey_EP
                                     '',                                                      //strNumLot
                                     'N',                                                     //strPigBas
                                     0,                                                       //fltVaEIpi
                                     0,                                                       //fltAlEIpi
                                     0,                                                       //fltBaEIpi
                                     0,                                                       //fltTotUlt
                                     0,                                                       //fltImpUlt
                                     0,                                                       //fltBaRtSP
                                     0,                                                       //fltVaRtSP
                                     0,                                                       //fltIcOpPr
                                     0,                                                       //intSeqCcr
                                     0,                                                       //fltEmbala
                                     0,                                                       //fltAlqPis
                                     0,                                                       //fltBasPis
                                     0,                                                       //fltValPis
                                     '',                                                      //strCSTPis
                                     0,                                                       //fltAlqCof
                                     0,                                                       //fltBasCof
                                     0,                                                       //fltValCof
                                     '',                                                      //strCSTCof
                                     '',                                                      //strCSTIpi
                                     '',                                                      //strEnqIpi
                                     0,                                                       //fltVaERet
                                     0,                                                       //fltAlERet
                                     0,                                                       //fltBaERet
                                     0,                                                       //fltPesLiq
                                     objDet);
          End;
          strAutIncMovDet := fNextAutoIncrem(strAutIncMovDet);
          qryEntMer.Next;
        End;
      Finally
        FreeAndNil(qryEntMer);
      End;

      If not Result Then
        Exit;

      objFis.Init;
      objFis.fltTotIbs := FGerEle.RT_VIBS;
      objFis.fltTotCbs := FGerEle.RT_VCBS;
      objFis.fltTotIs  := FGerEle.RT_VIS;
      objFis.fltTotNf  := FGerEle.RT_VNFTOT;
      strAutIncCadFis := fRetAutoincrem('CADFIS', VS_StrCodEmp);
      Result :=  Result and fGravaCadFisSimplificada(strAutIncCadFis,                                     //strAutInc
                               FGerEle.B09_DEMI,                                    //dtaDtaEnt
                               String(FGerEle.B08_NNF),                            //strNumDoc
                               '',                                                  //strNumDo2
                               'NF',                                                //strEspDoc
                               'E',                                                 //strEntSai
                               FGerEle.B09_DEMI,                                    //dtaDtaDoc
                               'F',                                                 //strTip_Fc
                               String(FGerEle.GER_CODFOR),                         //strForCli
                               String(FGerEle.B04_NATOP),                          //strHistor
                               'N',                                                 //strNfComp
                               'N',                                                 //strNotEsp
                               strCFOP,                                             //strClfSc1
                               FGerEle.W16_VNF,                                     //fltVlCon1
                               0,                                                   //fltBasIc1
                               0,                                                   //fltAlqIc1
                               0,                                                   //fltVlrIc1
                               0,                                                   //fltOutra1
                               0,                                                   //fltIsent1
                               0,                                                   //fltRetid1
                               0,                                                   //fltBasIp1
                               0,                                                   //fltVlrIp1
                               0,                                                   //fltBcRet1
                               0,                                                   //fltDAces1
                               0,                                                   //fltValIs1
                               '',                                                  //strClfSc2
                               0,                                                   //fltVlCon2
                               0,                                                   //fltBasIc2
                               0,                                                   //fltAlqIc2
                               0,                                                   //fltVlrIc2
                               0,                                                   //fltOutra2
                               0,                                                   //fltIsent2
                               0,                                                   //fltRetid2
                               0,                                                   //fltBasIp2
                               0,                                                   //fltVlrIp2
                               0,                                                   //fltBcRet2
                               0,                                                   //fltDAces2
                               0,                                                   //fltValIs2
                               '',                                                  //strClfSc3
                               0,                                                   //fltVlCon3
                               0,                                                   //fltBasIc3
                               0,                                                   //fltAlqIc3
                               0,                                                   //fltVlrIc3
                               0,                                                   //fltOutra3
                               0,                                                   //fltIsent3
                               0,                                                   //fltRetid3
                               0,                                                   //fltBasIp3
                               0,                                                   //fltVlrIp3
                               0,                                                   //fltBcRet3
                               0,                                                   //fltDAces3
                               0,                                                   //fltValIs3
                               '',                                                  //strClfSc4
                               0,                                                   //fltVlCon4
                               0,                                                   //fltBasIc4
                               0,                                                   //fltAlqIc4
                               0,                                                   //fltVlrIc4
                               0,                                                   //fltOutra4
                               0,                                                   //fltIsent4
                               0,                                                   //fltRetid4
                               0,                                                   //fltBasIp4
                               0,                                                   //fltVlrIp4
                               0,                                                   //fltBcRet4
                               0,                                                   //fltDAces4
                               0,                                                   //fltValIs4
                               '',                                                  //strClfSc5
                               0,                                                   //fltVlCon5
                               0,                                                   //fltBasIc5
                               0,                                                   //fltAlqIc5
                               0,                                                   //fltVlrIc5
                               0,                                                   //fltOutra5
                               0,                                                   //fltIsent5
                               0,                                                   //fltRetid5
                               0,                                                   //fltBasIp5
                               0,                                                   //fltVlrIp5
                               0,                                                   //fltBcRet5
                               0,                                                   //fltDAces5
                               0,                                                   //fltValIs5
                               0,                                                   //fltTotPis
                               0,                                                   //fltTotCof
                               0,                                                   //fltBasPis
                               0,                                                   //fltBasCof
                               0,                                                   //fltAlqPis
                               0,                                                   //fltAlqCof
                               VS_strCodEmp,                                        //strCodEmp
                               String(FGerEle.B07_SERIE),                          //strSerie
                               String(FGerEle.C12_UF),                             //strEstado
                               '',                                                  //strNumSer
                               '',                                                  //strNumCoo
                               '',                                                  //strCodCon
                               '',                                                  //strDocCon
                               String(FGerEle.PR07_CHNFE),                         //strChaveAcesso
                               '',                                                  //strNumeroProtocolo
                               'C',                                                 //strOriDoc
                               objFis);

      Result :=  Result and fGravaFisRef(strAutIncCadFis,
                   VS_strCodEmp,
                   '',                   // strClatri
                   FGerEle.W16_VNF,      // fltVlrCon
                   0,                    // fltBasIs
                   // CBS
                   0,                    // fltCbsAlq
                   0,                    // fltCbsDif
                   0,                    // fltCbsRed
                   FGerEle.RT_VCBS,      // fltCbsVal
                   FGerEle.RT_VDIFCBS,   // fltCbsVld
                   FGerEle.RT_VDEVCBS,   // fltCbsVlr
                   FGerEle.RT_VBCIBSCBS, // fltCbsBas
                   0,                    // fltCbsBad
                   0,                    // fltCbsBar
                   // IBS UF
                   FGerEle.RT_VBCIBSCBS, // fltIbsUfb
                   0,                    // fltIbsUdb
                   0,                    // fltIbsUrb
                   0,                    // fltIbsUfa
                   0,                    // fltIbsUfd
                   0,                    // fltIbsUfr
                   FGerEle.RT_VIBSUF,    // fltIbsUfv
                   FGerEle.RT_VDIFIBSUF, // fltIbsUdv
                   FGerEle.RT_VDEVIBSUF, // fltIbsUrv
                   // IBS Mun
                   FGerEle.RT_VBCIBSCBS, // fltIbsMnb
                   0,                    // fltIbsMdb
                   0,                    // fltIbsMrb
                   0,                    // fltIbsMna
                   0,                    // fltIbsMnd
                   0,                    // fltIbsMnr
                   FGerEle.RT_VIBSMUN,   // fltIbsMnv
                   FGerEle.RT_VDIFMUN,   // fltIbsMdv
                   FGerEle.RT_VDEVMUN    // fltIbsMrv
                   );

    End;

  Except
    On E: Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message, '[fGravaNotaAjuste]');
    End;
  End;
End;

function TNFeXml.fGravarNotaFiscal(blnCSTCad: Boolean; intIndexList: integer; blnPreGnre: Boolean; cdsCriticas: TZClient = nil; strOperadorLiberacao: String = ''; horLib: TTime = 0): Boolean;
  var
    intIndex: Integer;
begin
  Try
    fStartTransaction;
    If blnAuditoria Then
    Begin
      If TNFeXml.Agrupador = '' Then
        TNFeXml.Agrupador := FormatDateTime('dd/mm/yyyy hh:nn:ss', fNow);
      Result := fGravaGerEleAuditoria;
    End
    Else
    begin
      FblnPreGnre := blnPreGnre;
      Result := getQuantidadeItens > 0;

      lstDados.Clear;


      Result := Result And fGravaGerEle(blnCSTCad);
      Result := Result And fGravaGerERT;

      For intIndex := 0 To getQuantidadeItens - 1 Do
      Begin
        Result := Result And fGravaDetEle(getItemNota[intIndex], intIndexList, intIndex);

        Result := Result And fGravaDetERT(getItemNota[intIndex], String(getItemNota[intIndex].strAutInc));

        If Assigned(FOnGravando) Then
          FOnGravando('Gravando NFe ' + String(recDadosNota.B08_NNF), Succ(intIndex), getQuantidadeItens);
      End;

      If Result and FGerEle.NFeAjuste Then
        Result := Result And fGravaNotaAjuste;

      For intIndex := 0 To fGetRetCount - 1 Do
      Begin
        Result := Result And fGravaRetEle(getRetornoReferencia[intIndex]);
      End;

      If Result And Assigned(cdsCriticas) Then
      Begin
        cdsCriticas.Filtered := False;
        cdsCriticas.Filter := 'NUMDOC = ' + QuotedStr(String(FGerEle.B08_NNF));
        cdsCriticas.Filtered := True;
        If cdsCriticas.RecordCount > 0 Then
          pGravaCriticas(cdsCriticas, strOperadorLiberacao, horLib);
        cdsCriticas.Filtered := False;
      End;
    End;
    If Result Then
      fCommit
    Else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '')
    End;
  End;
end;


function TNFeXml.fGravarXmlDivergente(): Boolean;
  var
    qryXmlVal : TUniQuery;
begin
  Try
    Result := fStartTransaction;
    Try
      qryXmlVal := fCriaQuery();

      qryXmlVal.SQL.Text := 'SELECT * FROM XMLVAL WHERE FALSE';

      qryXmlVal.Open;
      qryXmlVal.Append;
      qryXmlVal.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('XMLVAL', VS_strCodEmp);
      qryXmlVal.FieldByName('XML_DTAENI').AsDateTime := fNow();
      qryXmlVal.FieldByName('XML_SERIE_').AsString   := String(FGerEle.B07_SERIE);
      qryXmlVal.FieldByName('XML_NUMDOC').AsString   := String(FGerEle.B08_NNF);
      qryXmlVal.FieldByName('XML_VALTOT').AsFloat    := FGerEle.W16_VNF;
      qryXmlVal.FieldByName('XML_CODFOR').AsString   := String(FGerEle.GER_CODFOR);
      qryXmlVal.FieldByName('XML_CODEMP').AsString   := VS_strCodEmp;
      qryXmlVal.FieldByName('XML_TIPXML').AsInteger  := Ord(FfinalidadeXML);

      TBlobField(qryXmlVal.FieldByName('XML_ARQXML')).LoadFromFile(FPatArq + FNomArq);
      qryXmlVal.Post;
      qryXmlVal.Close;

      fCommit;

    Finally
      FreeAndNil(qryXmlVal);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '')
    End;
  End;
end;

function TNFeXml.fGravarXml: Boolean;
  var
    qryXmlVal : TUniQuery;
    Stream: TStringStream;
begin
  Try
    Result := fStartTransaction;
    Stream := TStringStream.Create;
    Try
      Stream.WriteString(lstDados.Text);
      qryXmlVal := fCriaQuery();
      qryXmlVal.SQL.Text := 'SELECT * FROM XMLIMP WHERE FALSE';

      qryXmlVal.Open;
      qryXmlVal.Append;
      qryXmlVal.FieldByName('IMP_SEQGER').AsString   := String(FGerEle.strAutInc);
      TBlobField(qryXmlVal.FieldByName('IMP_ARQXML')).LoadFromFile(FPatArq + FNomArq);
      TBlobField(qryXmlVal.FieldByName('IMP_RECORD')).LoadFromStream(Stream);
      qryXmlVal.Post;
      qryXmlVal.Close;

      fCommit;

    Finally
      FreeAndNil(Stream);
      FreeAndNil(qryXmlVal);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '')
    End;
  End;
end;


Function TNFeXml.fGetIPI(nodIPI: IXMLNode; var recDetEle: TRecDetEle): Boolean;
  Var
    nodIPITrib: IXMLNode;
Begin
  Try
    With recDetEle Do
    Begin
      O02_CLENQ   := ShortString(fGetValorXml(nodIPI, 'cEnq'));

      nodIPITrib := nodIPI.ChildNodes.FindNode('IPITrib');

      If Assigned(nodIPITrib) Then
      Begin
        O09_CST     := ShortString(fGetValorXml(nodIPITrib, 'CST'));
        O10_VBC     := fGetValorXml(nodIPITrib, 'vBC', varDouble);
        O11_QUNID   := fGetValorXml(nodIPITrib, 'qUnid', varDouble);
        O12_VUNID   := fGetValorXml(nodIPITrib, 'vUnid', varDouble);
        O13_PIPI    := fGetValorXml(nodIPITrib, 'pIPI', varDouble);
        O14_VIPI    := fGetValorXml(nodIPITrib, 'vIPI', varDouble);
      End
      Else
      Begin
        O09_CST   := ShortString(EmptyStr);
        O10_VBC   := 0.00;
        O11_QUNID := 0.00;
        O12_VUNID := 0.00;
        O13_PIPI  := 0.00;
        O14_VIPI  := 0.00;
      End;
        
    End;

    Result := TRUE;

  Except
    Result := FALSE;
  End;
End;

Function TNFeXml.fGetImpostoDevol(nodImpostoDevol: IXMLNode; Var recDetEle: TRecDetEle): Boolean;
  Var
    nodIpiDevol: IXMLNode;
Begin
  Try
    nodIpiDevol := nodImpostoDevol.ChildNodes.FindNode('IPI');
    If Assigned(nodIpiDevol) Then
    Begin
      recDetEle.U51_PERCDEVOL   := fGetValorXml(nodImpostoDevol, 'pDevol', varDouble);
      recDetEle.U61_VALIPIDEVOL := fGetValorXml(nodIpiDevol, 'vIPIDevol', varDouble);
    End;
    Result := True
  Except
    Result := False;
  End;
end;

Function TNFeXml.fGetPIS(nodPIS: IXMLNode; var recDetEle: TRecDetEle): Boolean;
  Var
    nodPISAliq: IXMLNode;
    nodPISNT: IXMLNode;
Begin
  Try
    nodPISAliq := nodPIS.ChildNodes.FindNode('PISAliq');
    With recDetEle Do
    Begin
      If Assigned(nodPISAliq) Then
      Begin
        With recDetEle Do
        Begin
          Q06_CST       := ShortString(fGetValorXml(nodPISAliq, 'CST'));
          Q07_VBC       := fGetValorXml(nodPISAliq, 'vBC', varDouble);
          Q08_PPIS      := fGetValorXml(nodPISAliq, 'pPIS', varDouble);
          Q09_VPIS      := fGetValorXml(nodPISAliq, 'vPIS', varDouble);
          Q10_QBCPROD   := fGetValorXml(nodPISAliq, 'qBCProd', varDouble);
          Q11_VALIQPROD := fGetValorXml(nodPISAliq, 'vAliqProd', varDouble);
        End;
      End
      Else
      Begin
        nodPISAliq := nodPIS.ChildNodes.FindNode('PISOutr');

        If Assigned(nodPISAliq) Then
        Begin
          Q06_CST  := ShortString(fGetValorXml(nodPISAliq, 'CST'));
          Q07_VBC  := fGetValorXml(nodPISAliq, 'vBC', varDouble);
          Q08_PPIS := fGetValorXml(nodPISAliq, 'pPIS', varDouble);
          Q09_VPIS := fGetValorXml(nodPISAliq, 'vPIS', varDouble);
        End
        Else
        Begin
          nodPISNT := nodPIS.ChildNodes.FindNode('PISNT');

          If Assigned(nodPISNT) Then
          Begin
            Q06_CST := ShortString(fGetValorXml(nodPISNT, 'CST'));
          End
        End;
      End;
    End;
    Result := True
  Except
    Result := FALSE;
  End;
End;

function TNFeXml.fGetISSQN(nodISSQN: IXMLNode; var recDetEle: TRecDetEle): Boolean;
Begin
  Try

    If Assigned(nodISSQN) Then
    With recDetEle Do
    Begin
      U02_VBC          := fGetValorXml(nodISSQN, 'vBC', varDouble);
      U03_VALIQ        := fGetValorXml(nodISSQN, 'vAliq', varDouble);
      U04_VISSQN       := fGetValorXml(nodISSQN, 'vISSQN', varDouble);
      U05_CMUNFG       := ShortString(fGetValorXml(nodISSQN, 'cMunFG'));
      U06_CLISTSERV    := ShortString(fGetValorXml(nodISSQN, 'cListServ'));
      U07_VDEDUCAO     := fGetValorXml(nodISSQN, 'vDeducao', varDouble);
      U09_VDESCINCOND  := fGetValorXml(nodISSQN, 'vDescIncond', varDouble);
      U12_INDSS        := ShortString(fGetValorXml(nodISSQN, 'indISS'));
      U14_CMUN         := RightStr(ShortString(fGetValorXml(nodISSQN, 'cMun')), 7);
      U15_CPAIS        := ShortString(fGetValorXml(nodISSQN, 'cPais'));
      U17_INDINCENTIVO := ShortString(fGetValorXml(nodISSQN, 'indIncentivo'));
    End;

    Result := True;

  Except
    Result := FALSE;
  End;
End;


Function TNFeXml.fGetCOFINS(nodCOFINS: IXMLNode; var recDetEle: TRecDetEle): Boolean;
  Var
    nodCOFINSAliq: IXMLNode;
    nodCOFINSNT: IXMLNode;
Begin
  Try
    nodCOFINSAliq := nodCOFINS.ChildNodes.FindNode('COFINSAliq');
    With recDetEle Do
    Begin
      If Assigned(nodCOFINSAliq) Then
      Begin
        With recDetEle Do
        Begin
          S06_CST       := ShortString(fGetValorXml(nodCOFINSAliq, 'CST'));
          S07_VBC       := fGetValorXml(nodCOFINSAliq, 'vBC', varDouble);
          S08_PCOFINS   := fGetValorXml(nodCOFINSAliq, 'pCOFINS', varDouble);
          S09_QBCPROD   := fGetValorXml(nodCOFINSAliq, 'qBCProd', varDouble);
          S10_VALIQPROD := fGetValorXml(nodCOFINSAliq, 'vAliqProd', varDouble);
          S11_VCOFINS   := fGetValorXml(nodCOFINSAliq, 'vCOFINS', varDouble);
        End;
      End
      Else
      Begin
        nodCOFINSAliq := nodCOFINS.ChildNodes.FindNode('COFINSOutr');
        If Assigned(nodCOFINSAliq) Then
        Begin
          S06_CST     :=  ShortString(fGetValorXml(nodCOFINSAliq, 'CST'));
          S07_VBC     := fGetValorXml(nodCOFINSAliq, 'vBC', varDouble);
          S08_PCOFINS := fGetValorXml(nodCOFINSAliq, 'pCOFINS', varDouble);
          S11_VCOFINS := fGetValorXml(nodCOFINSAliq, 'vCOFINS', varDouble);
        End
        Else
        Begin
          nodCOFINSNT := nodCOFINS.ChildNodes.FindNode('COFINSNT');

          If Assigned(nodCOFINSNT) Then
          Begin
            S06_CST :=  ShortString(fGetValorXml(nodCOFINSNT, 'CST'));
          End
        End;
      End;
    End;

    Result := TRUE;

  Except
    Result := FALSE;
  End;
End;

function TNFeXml.fRetPER_CI(strNFCI, strInfAdProd: String): Double;
  Var
    intPos: Integer;
begin
  intPos := Pos(UpperCase(strNFCI), UpperCase(strInfAdProd));
  strInfAdProd := RightStr(strInfAdProd, Length(strInfAdProd) - (intPos + Length(strNFCI)));

  strNFCI := 'CI';
  intPos := Pos(UpperCase(strNFCI), UpperCase(strInfAdProd));
  strInfAdProd := RightStr(strInfAdProd, Length(strInfAdProd) - (intPos + Length(strNFCI)));

  intPos := Pos('%', UpperCase(strInfAdProd));
  strInfAdProd := LeftStr(strInfAdProd, Pred(intPos));

  Result := fStrToFloat(Trim(strInfAdProd));
End;

function TNFeXml.fGetDet(nodDet: IXMLNode; var recDetEle: TRecDetEle; var blnQtdComZero: Boolean): Boolean;
  Var
    nodProd    : IXMLNode;
    nodImposto : IXMLNode;
    nodImpostoDevol : IXMLNode;
    nodICMS    : IXMLNode;
    nodICMSXX  : IXMLNode;
    nodIPI     : IXMLNode;
    nodPIS     : IXMLNode;
    nodCOFINS  : IXMLNode;
    nodII      : IXMLNode;
    nodIcmsDest: IXMLNode;
    nodISSQN   : IXMLNode;
    nodIS          : IXMLNode;
    nodIBSCBS      : IXMLNode;
    nodGIBSCBS     : IXMLNode;
    nodGIBSUF_Ite  : IXMLNode;
    nodGIBSMun_Ite : IXMLNode;
    nodGCBS_Ite    : IXMLNode;
    nodTribReg     : IXMLNode;
    nodRTTmp       : IXMLNode;
    nodDFeRef      : IXMLNode;

    recRetDFe      : TRecRetEle;
    blnEncontrou: Boolean;

Begin
  Try
    Result := True;

    Try
      recDetEle.V01_infAdProd := fGetValorXml(nodDet, 'infAdProd', varString);
    Except
      {}
    End;

    nodProd := nodDet.ChildNodes.FindNode('prod');

    nodImposto := nodDet.ChildNodes.FindNode('imposto');

    If blnFulFillment Then
    Begin
      recDetEle.U51_PERCDEVOL   := 0.00;
      recDetEle.U61_VALIPIDEVOL := 0.00;

      nodImpostoDevol := nodDet.ChildNodes.FindNode('impostoDevol');
      If Assigned(nodImpostoDevol) Then
      Begin
        Result := fGetImpostoDevol(nodImpostoDevol, recDetEle);
        If Not Result Then
          Exit;
      End;
    End;
    
    If Assigned(nodImposto) Then
    Begin
      nodIcms   := nodImposto.ChildNodes.FindNode('ICMS');

      If Assigned(nodICMS) Then
      Begin
        nodIcmsXX := nodIcms.ChildNodes.First;

        If Not Assigned(nodICMSXX) Then
        Begin
          Result := FALSE;
          Exit;
        End;

        Result  := fGetICMS(nodIcmsXX, recDetEle);
        If Not Result Then
          Exit;

        nodIcmsDest := nodImposto.ChildNodes.FindNode('ICMSUFDest');

        If Assigned(nodIcmsDest) Then
        Begin
          Result  := fGetICMSDest(nodIcmsDest, recDetEle);
          If Not Result Then
            Exit;
        End;
      End;

      nodIPI   := nodImposto.ChildNodes.FindNode('IPI');

      If Assigned(nodIPI) Then
      Begin
        Result  := fGetIPI(nodIPI, recDetEle);
        If Not Result Then
          Exit;
      End
      Else
      Begin
        recDetEle.O09_CST   := ShortString(EmptyStr);
        recDetEle.O10_VBC   := 0.00;
        recDetEle.O11_QUNID := 0.00;
        recDetEle.O12_VUNID := 0.00;
        recDetEle.O13_PIPI  := 0.00;
        recDetEle.O14_VIPI  := 0.00;
      End;

      nodPIS   := nodImposto.ChildNodes.FindNode('PIS');

      If Not Assigned(nodPIS) Then
      Begin
        recDetEle.Q06_CST  := '';
        recDetEle.Q07_VBC  := 0;
        recDetEle.Q08_PPIS := 0;
        recDetEle.Q09_VPIS := 0;
      End
      Else
        Result  := fGetPIS(nodPIS, recDetEle);

      If Not Result Then
        Exit;

      nodCOFINS := nodImposto.ChildNodes.FindNode('COFINS');

      If Not Assigned(nodCOFINS) Then
      Begin
        recDetEle.S06_CST     :=  '';
        recDetEle.S07_VBC     := 0;
        recDetEle.S08_PCOFINS := 0;
        recDetEle.S11_VCOFINS := 0;
      End
      Else
        Result  := fGetCOFINS(nodCOFINS, recDetEle);

      If Not Result Then
        Exit;

      nodII := nodImposto.ChildNodes.FindNode('II');

      If Assigned(nodII) Then
        fGetII(nodII, recDetEle);

      nodISSQN := nodImposto.ChildNodes.FindNode('ISSQN');
      If Assigned(nodISSQN) Then
        Result := fGetISSQN(nodISSQN, recDetEle);

      // Reforma Tributaria - por item (DETERT)
      If FGerEle.C14_CPAIS = '1058' Then
      Begin
        nodIS := nodImposto.ChildNodes.FindNode('IS');
        If Assigned(nodIS) Then
        Begin
          recDetEle.RT_CSTIS    := ShortString(fGetValorXml(nodIS, 'CSTIS'));
          recDetEle.RT_CLATRIAIS:= ShortString(fGetValorXml(nodIS, 'cClassTribIS'));
          recDetEle.RT_VBCIS    := fGetValorXml(nodIS, 'vBCIS', varDouble);
          recDetEle.RT_PAIS     := fGetValorXml(nodIS, 'pIS', varDouble);
          recDetEle.RT_PAISESP  := fGetValorXml(nodIS, 'pISEspec', varDouble);
          recDetEle.RT_UTRIB    := ShortString(fGetValorXml(nodIS, 'uTrib'));
          recDetEle.RT_QTRIB    := fGetValorXml(nodIS, 'qTrib', varDouble);
          recDetEle.RT_VIS      := fGetValorXml(nodIS, 'vIS', varDouble);
        End;

        nodIBSCBS := nodImposto.ChildNodes.FindNode('IBSCBS');
        If Assigned(nodIBSCBS) Then
        Begin
          recDetEle.RT_CST    := ShortString(fGetValorXml(nodIBSCBS, 'CST'));
          recDetEle.RT_CLATRIB:= ShortString(fGetValorXml(nodIBSCBS, 'cClassTrib'));

          nodGIBSCBS := nodIBSCBS.ChildNodes.FindNode('gIBSCBS');
          If Assigned(nodGIBSCBS) Then
          Begin
            recDetEle.RT_VBC := fGetValorXml(nodGIBSCBS, 'vBC', varDouble);

            nodGIBSUF_Ite := nodGIBSCBS.ChildNodes.FindNode('gIBSUF');
            If Assigned(nodGIBSUF_Ite) Then
            Begin
              recDetEle.RT_PIBSUF := fGetValorXml(nodGIBSUF_Ite, 'pIBSUF', varDouble);
              recDetEle.RT_VIBSUF := fGetValorXml(nodGIBSUF_Ite, 'vIBSUF', varDouble);
              nodRTTmp := nodGIBSUF_Ite.ChildNodes.FindNode('gDif');
              If Assigned(nodRTTmp) Then
              Begin
                recDetEle.RT_PDIFUF := fGetValorXml(nodRTTmp, 'pDif', varDouble);
                recDetEle.RT_VDIFUF := fGetValorXml(nodRTTmp, 'vDif', varDouble);
              End;
              nodRTTmp := nodGIBSUF_Ite.ChildNodes.FindNode('gDevTrib');
              If Assigned(nodRTTmp) Then
                recDetEle.RT_VDEVUF := fGetValorXml(nodRTTmp, 'vDevTrib', varDouble);
              nodRTTmp := nodGIBSUF_Ite.ChildNodes.FindNode('gRed');
              If Assigned(nodRTTmp) Then
              Begin
                recDetEle.RT_PREDUF  := fGetValorXml(nodRTTmp, 'pRedAliq', varDouble);
                recDetEle.RT_PEFETUF := fGetValorXml(nodRTTmp, 'pAliqEfet', varDouble);
              End;
            End;

            nodGIBSMun_Ite := nodGIBSCBS.ChildNodes.FindNode('gIBSMun');
            If Assigned(nodGIBSMun_Ite) Then
            Begin
              recDetEle.RT_PIBSMUN := fGetValorXml(nodGIBSMun_Ite, 'pIBSMun', varDouble);
              recDetEle.RT_VIBSMUN := fGetValorXml(nodGIBSMun_Ite, 'vIBSMun', varDouble);
              nodRTTmp := nodGIBSMun_Ite.ChildNodes.FindNode('gDif');
              If Assigned(nodRTTmp) Then
              Begin
                recDetEle.RT_PDIFMUN := fGetValorXml(nodRTTmp, 'pDif', varDouble);
                recDetEle.RT_VDIFMUN := fGetValorXml(nodRTTmp, 'vDif', varDouble);
              End;
              nodRTTmp := nodGIBSMun_Ite.ChildNodes.FindNode('gDevTrib');
              If Assigned(nodRTTmp) Then
                recDetEle.RT_VDEVMUN := fGetValorXml(nodRTTmp, 'vDevTrib', varDouble);
              nodRTTmp := nodGIBSMun_Ite.ChildNodes.FindNode('gRed');
              If Assigned(nodRTTmp) Then
              Begin
                recDetEle.RT_PREDMUN  := fGetValorXml(nodRTTmp, 'pRedAliq', varDouble);
                recDetEle.RT_PEFETMUN := fGetValorXml(nodRTTmp, 'pAliqEfet', varDouble);
              End;
            End;
            recDetEle.RT_VIBS := fGetValorXml(nodGIBSCBS, 'vIBS', varDouble);
            nodGCBS_Ite := nodGIBSCBS.ChildNodes.FindNode('gCBS');
            If Assigned(nodGCBS_Ite) Then
            Begin
              recDetEle.RT_PCBS := fGetValorXml(nodGCBS_Ite, 'pCBS', varDouble);
              recDetEle.RT_VCBS := fGetValorXml(nodGCBS_Ite, 'vCBS', varDouble);
              nodRTTmp := nodGCBS_Ite.ChildNodes.FindNode('gDif');
              If Assigned(nodRTTmp) Then
              Begin
                recDetEle.RT_PDIFCBS := fGetValorXml(nodRTTmp, 'pDif', varDouble);
                recDetEle.RT_VDIFCBS := fGetValorXml(nodRTTmp, 'vDif', varDouble);
              End;
              nodRTTmp := nodGCBS_Ite.ChildNodes.FindNode('gDevTrib');
              If Assigned(nodRTTmp) Then
                recDetEle.RT_VDEVCBS := fGetValorXml(nodRTTmp, 'vDevTrib', varDouble);
              nodRTTmp := nodGCBS_Ite.ChildNodes.FindNode('gRed');
              If Assigned(nodRTTmp) Then
              Begin
                recDetEle.RT_PREDCBS  := fGetValorXml(nodRTTmp, 'pRedAliq', varDouble);
                recDetEle.RT_PEFETCBS := fGetValorXml(nodRTTmp, 'pAliqEfet', varDouble);
              End;
            End;
          End;

          nodTribReg := nodIBSCBS.ChildNodes.FindNode('gTribRegular');
          If Assigned(nodTribReg) Then
          Begin
            recDetEle.RT_CSTREG    := ShortString(fGetValorXml(nodTribReg, 'CSTReg'));
            recDetEle.RT_CLATRIREG := ShortString(fGetValorXml(nodTribReg, 'cClassTribReg'));
            recDetEle.RT_PEFIBSUF  := fGetValorXml(nodTribReg, 'pAliqEfetRegIBSUF', varDouble);
            recDetEle.RT_VTRIBUF   := fGetValorXml(nodTribReg, 'vTribRegIBSUF', varDouble);
            recDetEle.RT_PEFIBSMUN := fGetValorXml(nodTribReg, 'pAliqEfetRegIBSMun', varDouble);
            recDetEle.RT_VTRIBMUN  := fGetValorXml(nodTribReg, 'vTribRegIBSMun', varDouble);
            recDetEle.RT_PEFCBS    := fGetValorXml(nodTribReg, 'pAliqEfetRegCBS', varDouble);
            recDetEle.RT_VTRIBCBS  := fGetValorXml(nodTribReg, 'vTribRegCBS', varDouble);
          End;
        End;
      End;

      If Not Result Then
        Exit;
    End;

    If FGerEle.NFeAjuste Then
    Begin
      nodDFeRef := nodDet.ChildNodes.FindNode('DFeReferenciado');
      If Assigned(nodDFeRef) Then
      Begin
        recRetDFe.strReferenciaNFe := fGetValorXml(nodDFeRef, 'chaveAcesso');
        pAdicionarRetornoReferencia(recRetDFe);
      End;
    End;

    If Assigned(nodProd) Then
      Result := fGetProd(nodProd, recDetEle, blnEncontrou, blnQtdComZero)
    Else
      Result := FALSE;

    If (Not blnEncontrou) And (Assigned(FOnNaoEncontrouItem)) Then
    Begin
      pRegistraItemParaGravacao(FGerEle, recDetEle);
      Result := blnEncontrou;
    End;

    If Not Result Then
      Exit;

  Except
    Result := FALSE;
  End;

End;

Function TNFeXml.fRetEmpresaCnpj(strCmpj: String; strEMP_I_E_S_: String = ''): String;
  Var
    qryCadEmp: TUniQuery;
Begin
  Result := '';
  qryCadEmp := fCriaQuery(Nil);
  Try
    If strCmpj <> '' then
    Begin
      With qryCadEmp, SQL Do
      Begin
        Add('SELECT ');
        Add('  EMP_CODEMP,');
        Add('  EMP_C_G_C_, EMP_I_E_S_ ');
        Add('FROM');
        Add('  CADEMP');
        Add('  WHERE CADEMP.EMP_C_G_C_ = "'+fTiraCaracEspeciaisPonto(strCmpj)+'"');
        Add('ORDER BY EMP_CODEMP');
        Open;
      End;
      If qryCadEmp.RecordCount > 1 Then
      Begin
        If strEmpSEL = '' Then
        Begin
          pCriarFormularios(TfrmSelecionaEmpresa, frmSelecionaEmpresa);
          Try
            frmSelecionaEmpresa.strCNPJ := fTiraCaracEspeciaisPonto(strCmpj);
            frmSelecionaEmpresa.Showmodal;
            strEmpSEL := frmSelecionaEmpresa.strCodEmpresa;
            If strEmpSEL = '' Then
              raise Exception.Create('Empresa não foi identificada!')
            Else
            begin
              Result := strEmpSEL;
              Exit;
            End;
          Finally
            FreeAndNil(frmSelecionaEmpresa);
          End;
        End;
      End;
    End;
    qryCadEmp.SQL.Clear;
    With qryCadEmp, SQL Do
    Begin
      Add('SELECT ');
      Add('  EMP_CODEMP,');
      Add('  EMP_C_G_C_, EMP_I_E_S_ ');
      Add('FROM');
      Add('  CADEMP');
      Add('ORDER BY EMP_CODEMP');

      Open;

      While Not Eof Do
      Begin
        If strEMP_I_E_S_ <> '' Then
        Begin
          If (fTiraCaracEspeciaisPonto(strEMP_I_E_S_) =
              fTiraCaracEspeciaisPonto(FieldByName('EMP_I_E_S_').AsString)) And
             (fTiraCaracEspeciaisPonto(strCmpj) =
              fTiraCaracEspeciaisPonto(FieldByName('EMP_C_G_C_').AsString)) Then
          Begin
            Result := FieldByName('EMP_CODEMP').AsString;
            Break;
          End;
        End
        Else
        Begin
          If fTiraCaracEspeciaisPonto(strCmpj) =
             fTiraCaracEspeciaisPonto(FieldByName('EMP_C_G_C_').AsString) Then
          Begin
            Result := FieldByName('EMP_CODEMP').AsString;
            Break;
          End;
        End;
        Next;
      End;
    End;
  Finally
    FreeAndNil(qryCadEmp);
  End;
End;

function TNFeXml.fRetornaAbfIcm(strCodIte, strEstFor,
  strCodEmp: String): Boolean;
begin
  If strTipAbfCfg = '1' Then
  Begin
    cdsAbfIcm.IndexFieldNames := 'CODITE;CODEST';
    Result := (cdsAbfIcm.Locate('CODITE;CODEST', VarArrayOf([strCodIte, strEstFor]), [])) OR
              (cdsAbfIcm.FindKey([strCodIte, strEstFor]));
  End
  Else
  Begin
    cdsAbfIcm.IndexFieldNames := 'CODITE;CODEST;CODEMP';
    Result := (cdsAbfIcm.Locate('CODITE;CODEST;CODEMP', VarArrayOf([strCodIte, strEstFor, strCodEmp]), [])) OR
              (cdsAbfIcm.FindKey([strCodIte, strEstFor, strCodEmp]));
  End;
end;

function TNFeXml.fRetornoCodigoItemPelaReferenciaDaNotaImportacao(
  strCodReferencia: String): String;
 Var
    qryNotDet: TUniquery;
 Begin

 try
  qryNotDet := fCriaQuery;
  With qryNotDet, SQL Do
  Begin
    Add('SELECT ');
    Add('  DET_CODITE');
    Add('FROM ');
    Add('  NOTDET N');
    Add('INNER JOIN DOCIMP D ON N.AUTOINCREM = D.IMP_SEQDET');
    Add('WHERE');
    Add('  ((IFNULL(DET_SERIE_, "") = :SERIE_)  OR ');
    Add('   (IFNULL(DET_SERIE_, "") = :SERIE2)) AND');
    Add('  DET_NUMDOC = :NUMDOC AND');
    Add('  DET_CODEMP = :CODEMP AND');
    Add('  DET_CODFOR = :CODFOR AND ');
    Add('  DET_REFERE = :REFERE  ');

    ParamByName('NUMDOC').AsString := RightStr(string(FGerEle.B08_NNF), FintTamNumDocGerEle);

    If fEmptyStr(string(FGerEle.B07_SERIE)) Then
      ParamByName('SERIE_').AsString := string(FGerEle.B07_SERIE)
    Else
      ParamByName('SERIE_').AsString := RightStr('000' + string(FGerEle.B07_SERIE), 3);

    ParamByName('SERIE2').AsString := string(FGerEle.B07_SERIE);

    ParamByName('CODEMP').AsString := string(FGerEle.GER_CODEMP);
    ParamByName('CODFOR').AsString := string(FGerEle.GER_CODFOR);

    ParamByName('REFERE').AsString := strCodReferencia;

    Open;

    Result := FieldByName('DET_CODITE').AsString;
  End;

 finally
   FreeAndNil(qryNotDet)
 End;

end;

function TNFeXml.fTamNumDocGerEle: Integer;
var qryAux: TUniQuery;
Begin
  Result := 6;
  qryAux := fCriaQuery();
  qryAux.SQL.Text := 'DESC GERELE';
  qryAux.Open;

  While (Not qryAux.Eof) Do
  Begin
    If qryAux.FieldByName('Field').AsString = 'B08_NNF' Then
    Begin
      {****************************************************}
      {* Se For o Tamanho Antigo(9) o Resultado é 6 mesmo *}
      {*        NÃO esta errado                           *}
      {*************************************************GB*}
      If UpperCase(qryAux.FieldByName('Type').AsString) = 'VARCHAR(9)' Then
        Result := 6
      Else
        Result := 12;
        
      Break;
    End;

    qryAux.Next;
  End;
  FreeAndNil(qryAux);
End;

function TNFeXml.GetDuplicatasCount: integer;
begin
  Result := Length(FArrDupEle);
end;

function TNFeXml.GetRecDupEle(index: integer): TRecDupEle;
begin
  If (index > -1) And (Index <= Length(FArrDupEle)) Then
    Result := FArrDupEle[index]
end;

Function TNFeXml.fGetDest(nodDest: IXMLNode): Boolean;
  Var
    nodenderDest: IXMLNode;
Begin
  Try
    With FGerEle Do
    Begin
      E02_CNPJ   := ShortString(IfNull(fGetValorXML(nodDest, 'CNPJ'), ''));
      If fEmptyStr(String(E02_CNPJ)) Then
        E02_CNPJ   := ShortString(IfNull(fGetValorXML(nodDest, 'CPF'), ''));

      E17_IE := ShortString(fGetValorXml(nodDest, 'IE'));
      If fCfgSis('VALIES', varBoolean) Then
        GER_CODEMP := ShortString(fRetEmpresaCnpj(String(E02_CNPJ), String(E17_IE)))
      Else
        GER_CODEMP := ShortString(fRetEmpresaCnpj(String(E02_CNPJ)));

      If (Not FCriarTagDestinatarioEmBrancoCasoInexistente) Then
        If (blnValidar) And (fEmptyStr(String(GER_CODEMP))) Then
          pIncluiErro('CNPJ DO DESTINATÁRIO ' + String(E02_CNPJ) + ' NÃO ENCONTRADO.', True);

      If (blnValidar) And (FEmpresaNoDestinatario) Then
      Begin
        If (fEmptyStr(String(GER_CODEMP))) Then
        Begin
          pIncluiErro('EMPRESA NÃO ENCONTRADA NO DESTINATÁRIO DO XML', True);
          Result := False;
          Exit;
        End;
        If (Not fEmpresaAtiva(String(GER_CODEMP))) Then
        Begin
          pIncluiErro('EMPRESA "' + String(GER_CODEMP) + '" INATIVA NO CADASTRO DE EMPRESAS', True);
          Result := False;
          Exit;
        End;
      End;

      E03_XNOME  := ShortString(fGetValorXml(nodDest, 'xNome'));

      nodenderDest := nodDest.ChildNodes.FindNode('enderDest');

      If Assigned(nodenderDest) Then
      Begin
        E03_XLGR   := ShortString(fGetValorXml(nodenderDest, 'xLgr'));
        E07_NRO    := ShortString(fGetValorXml(nodenderDest, 'nro'));
        E09_XBAIRRO:= ShortString(fGetValorXml(nodenderDest, 'xBairro'));
        E10_CMUN   := RightStr(ShortString(fGetValorXml(nodenderDest, 'cMun')), 7);
        E10_UF     := ShortString(fGetValorXml(nodenderDest, 'UF'));
        E13_CEP    := ShortString(fGetValorXml(nodenderDest, 'CEP'));
        E16_FONE   := ShortString(fGetValorXml(nodenderDest, 'fone'));
      End;

    End;

    Result := TRUE;

  Except
    Result := FALSE;
  End;

End;

function TNFeXml.CountDecimals(Value: Double): Integer;
var
  StrValue: string;
  DecimalPos: Integer;
begin
  StrValue := FloatToStr(Value);
  DecimalPos := Pos(',', StrValue);

  if DecimalPos > 0 then
    Result := Length(StrValue) - DecimalPos
  else
    Result := 0;
end;

Function TNFeXml.fGetProd(nodProd: IXMLNode; Var recDetEle: TRecDetEle; var blnEncontrou: boolean; var blnQtdComZero: Boolean): Boolean;
  Var
    strCodIteTmp : TString7;

    blnItemAtivoTmp,
    blnItemAtivo,
    blnCodEmb,
    blnCodBar,
    blnAtuNCM: Boolean;
    I02_CPROD_OLD: String;
    nodDI    : IXMLNode;
    nodADI   : IXMLNode;
    LCodIteOut: String;
   	recProdutoNota: TrecProdutoNota;
    nodComb    : IXMLNode;
    FstrCodFor: string;
    qtdDecimal: integer;

    Procedure pRelataItemNaoEncontrado;
    Begin
      With recDetEle Do
      Begin
        pIncluiErro('ITEM: ' + fPadR(String(I04_XPROD), 64)   + #13#10 +
                    'C\ COD. BARRAS: ' + String(I03_CEAN)     + #13#10 +
                    'C\ COD. FABRICA: ' + String(I02_CPROD) + ' NAO ENCONTRADO' +
                    IfThen(not fEmptyStr(String(FGerEle.GER_CODFOR)), ' PARA O FORNECEDOR ' +
                           String(FGerEle.GER_CODFOR) + ' - ' + fDadosFornec('NOMFOR'), ''));

        If Assigned(FOnNaoEncontrouItem) Then
          pRegistraItemParaGravacao(FGerEle, recDetEle);
      End;
    End;

Begin
  blnQtdComZero := False;
  Result := True;
  Try
    With recDetEle Do
    Begin
      I02_CPROD    := ShortString(fGetValorXml(nodProd, 'cProd'));
      I02_CPROD_OLD := String(I02_CPROD);

      If (Not fEmptyStr(String(I02_CPROD))) And (fCfgSis('NFEREF', varBoolean)) And FNotaImportacao And (Not FImportacaoDI) Then
      Begin
        I02_CPROD := ShortString(fRetornoCodigoItemPelaReferenciaDaNotaImportacao(String(I02_CPROD)));

        If (fEmptyStr(String(I02_CPROD))) Then
        Begin
          pIncluiErro('Cód. de produto ' + I02_CPROD_OLD + ' não encontrado pela referência da nota de importação!');
          Result := False;
          Exit;
        End;
      End;

      I03_CEAN     := ShortString(fGetValorXml(nodProd, 'cEAN'));

      If (Not fEmptyStr(String(I03_CEAN))) And (Not CharInSet(I03_CEAN[1], ['0'..'9'])) Then
        I03_CEAN := '';

      I04_XPROD    := ShortString(fGetValorXml(nodProd, 'xProd'));
      I09_UCOM     := ShortString(fGetValorXml(nodProd, 'uCom'));
      I10A_VUNCOM  := fGetValorXml(nodProd, 'vUnCom', varDouble);
      If Assigned(PerfilDespachanteAduaneiro) then
      begin
        qtdDecimal := CountDecimals(recDetEle.I10A_VUNCOM);
        If qtdDecimal > PerfilDespachanteAduaneiro.CasasDecimaisArquivo then
          PerfilDespachanteAduaneiro.CasasDecimaisArquivo := qtdDecimal;
      End;

      nodComb := nodProd.ChildNodes.FindNode('comb');
      If Assigned(nodComb) Then
        Result := fGetComb(nodComb, recDetEle);

      If Not fEmptyStr(String(I03_CEAN)) Then
      Begin
        If (LeftStr(I03_CEAN, 1) = '0') And (fStringRepetida(String(I03_CEAN))) Then
        Begin
          I03_CEAN := '';
        End;
      End;
      I05_NCM      := ShortString(fGetValorXml(nodProd, 'NCM'));
      CODCEST      := ShortString(fGetValorXml(nodProd, 'CEST'));

      I70_NFCI     := ShortString(fGetValorXml(nodProd, 'nFCI'));

      If blnFulFillment Then
        XPED       := fGetValorXml(nodProd, 'xPed')
      Else
        XPED       := fPadroniza(fGetValorXml(nodProd, 'xPed'));

      NITEMPED     := fGetValorXml(nodProd, 'nItemPed');

      I12_CEANTRIB := ShortString(fGetValorXml(nodProd, 'cEANTrib'));

      blnItemAtivo := True;
      blnAtuNCM    := FGerEle.strMatRev <> 'M';
      blnEncontrou := True;
      If (blnValidar) And (FfinalidadeXML <> xmlConsertoEquipamento) Then
      Begin

        If (FGerEle.strMatRev = 'M') And (Not (fCfgSis('FLUPDC', varBoolean))) Then
        Begin

          If Not fExisteItemMatConsumo(String(I03_CEAN), String(I02_CPROD), DET_CODITE, blnItemAtivo, recDetEle) Then
            pRelataItemNaoEncontrado;

        End Else
        Begin
          If (FfinalidadeXML = xmlRetornoSimbolico) And Assigned(fLocalizarItemRetornoSimbolico) Then
          Begin
            If fLocalizarItemRetornoSimbolico(String(I02_CPROD), String(I04_XPROD), String(I12_CEANTRIB), LCodIteOut, blnItemAtivo) Then
            Begin
              DET_CODITE := ShortString(LCodIteOut);
              blnCodEmb := False;
              blnCodBar := False;
              If blnIgnoraInativos Then
                blnItemAtivo := True;
            End
            Else
            Begin
              pIncluiErro('ITEM: ' + String(I04_XPROD) + ' / CÓD. BARRAS: ' + String(I12_CEANTRIB) + ' NÃO ENCONTRADO!');
              blnEncontrou := False;
              Result := False;
              Exit;
            End;
          End
          Else If (blnImportaNfeSpedCodVel) And (fExisteItemCodVelCitel(String(I02_CPROD), DET_CODITE, blnItemAtivo)) Then
          Begin
            blnCodEmb := False;
            blnCodBar := False;
          End Else
          If FNotaImportacao And fExisteItemCodCitel(String(I02_CPROD), DET_CODITE, blnItemAtivo) Then
          Begin
            blnCodEmb := False;
            blnCodBar := False;
          End
          Else
          Begin
            // 1 - Código de Barras da Embalagem do CadIte
            blnCodEmb := fExisteItemCodEmb(String(I03_CEAN), DET_CODITE, blnItemAtivo);

            // 2 - Código de Barras do CadIte
            If blnCodEmb Then
              blnCodBar := False
            Else
              blnCodBar := fExisteItemCodBar(String(I03_CEAN), DET_CODITE, blnItemAtivo);
          End;

          {Para que as funcões fExisteItemCodFab, fExisteItemCodItemFornecedor e fExisteItemCodFabSem devolvam false, quando não houver fornecedor informado}
          FstrCodFor := String(FGerEle.GER_CODFOR);
          If fEmptyStr(String(FGerEle.GER_CODFOR)) Then
            FstrCodFor := '-';

          If fEmptyStr(String(I03_CEAN)) Or ((Not blnCodBar) And (Not blnCodEmb)) Then
          Begin
            If fEmptyStr(string(DET_CODITE)) Then
            Begin
              // 3 - Código de Fábrica do Item + Fornecedor CadIte
              If Not fExisteItemCodFab(String(I02_CPROD), FstrCodFor, DET_CODITE, blnItemAtivo) Then
              Begin
                // 4 - Código de Fábrica do Item + Fornecedor IteFor
                If Not fExisteItemCodItemFornecedor(String(I02_CPROD), FstrCodFor, DET_CODITE, blnItemAtivo) Then
                Begin
                  // 5 - Código de Barras do Semelhante
                  If Not fExisteItemCodBarSem(String(I03_CEAN), DET_CODITE, blnItemAtivo) Then
                  Begin
                    // 6 - Código de Fábrica do Semelhante + Fornecedor Cad Ite
                    If Not fExisteItemCodFabSem(String(I02_CPROD), FstrCodFor, DET_CODITE, blnItemAtivo) Then
                    Begin
                      blnAtuNCM := False;
                      // 7 - Código de Fábrica Concatenado com Unidade de Compra
                      If Not fExisteItemCodFab(String(I02_CPROD) + fStrZero(String(I09_UCOM),2), '', DET_CODITE, blnItemAtivo) Then
                      Begin
                        // 8 - Para recebimento do cliente por garantia, Código do item no Cliente + Código do Cliente : ITECLI
                        if ((FfinalidadeXML <> xmlGarantiaRecCliente) and (FfinalidadeXML <> xmlConsignacaoDevolucaoCliente)  and (FfinalidadeXML <> xmlRetornoLocacao))
                           or ((not fExiteItemCodItemCliente(String(I02_CPROD), String(FGerEle.GER_CODCLI), DET_CODITE, blnItemAtivo) )) then
                        begin
                          If Not blnAuditoria Then
                          Begin
                           {DESATIVADO A PESQUISA SO PELO CODIGO DE FABRICA POIS PODE EXISTIR VARIOS PRODUTOS COM O MESMO
                            CODIGO DE FABRICA E O FORNECEDOR NÃO SER O MESMO DO XML. DESATIVADO A PEDIDO DO DANIEL REQ. 5176
                            #GB#
                            // 8 - Código de Fábrica do CadIte
                            If Not fExisteItemCodFab(I02_CPROD, '', DET_CODITE, blnItemAtivo) Then
                            Begin
                            End;

                            // 9 - Código de Fábrica do Semelhante
                            If Not fExisteItemCodFabSem(String(I02_CPROD), '', DET_CODITE, blnItemAtivo) Then
                            Begin  }
                            if FfinalidadeXML = xmlConsignacaoDevolucaoCliente then
                              pRelataItemNaoEncontrado
                            else
                            Begin
                              If Not  FEmissaoImportacao then
                              Begin
                                pIncluiErro('ITEM: ' + fPadR(String(I04_XPROD), 64)   + #13#10 +
                                            'C\ COD. BARRAS: ' + String(I03_CEAN)     + #13#10 +
                                            'C\ COD. FABRICA: '   + String(I02_CPROD) + ' NAO ENCONTRADO' +
                                            IfThen(not fEmptyStr(String(FGerEle.GER_CODFOR)), ' PARA O FORNECEDOR ' +
                                                   String(FGerEle.GER_CODFOR) + ' - ' + fDadosFornec('NOMFOR'), ''));

                                blnEncontrou := False;
                              end;
                            End;

                            // End;
                          end;
                        End;
                      End;
                    End;
                  End;
                End;
              End;
            End;
          End;
          If (blnAtuNCM) And (FfinalidadeXML <> xmlConsertoEquipamento) And (Not blnAuditoria) and (not FGerEle.Nfeajuste) Then
          Begin
            If (Not fEmptyStr(V01_infAdProd)) And
               (Pos(UpperCase(String(I70_NFCI)), UpperCase(String(V01_infAdProd))) > 0) Then
              ITE_PER_CI := fRetPER_CI(String(I70_NFCI), String(V01_infAdProd));

            If Assigned(frmListaProdutosFCIDivergenteNFE) Then
            Begin
              With recProdutoNota, FGerEle  do
              Begin
                strNumNfe := string(B08_NNF);
                strSerie  := string(B07_SERIE);
                strCodProdutoNota := string(DET_CODITE);
                strDescProdutoNota := string(I04_XPROD);
                strNumFCINota := string(I70_NFCI);
                intPorcentagemFCINota := ITE_PER_CI;
                strClassIPINota :=  string(I05_NCM);
                strCodBarNota := string(I03_CEAN);
                strCodForNota := string(FGerEle.GER_CODFOR);
                strCESTNota := string(CODCEST);
                recProdutoNota.strChaveAcesso := string(PR07_CHNFE);
                recProdutoNota.strDataEmissao := FormatDateTime('DD/MM/YYYY', B09_DEMI);

                strCodIteTmp := DET_CODITE;
                blnItemAtivoTmp := blnItemAtivo;
                If blnCodBar And (( Not fExisteItemCodFab(String(recDetEle.I02_CPROD), String(FGerEle.GER_CODFOR), strCodIteTmp, blnItemAtivoTmp)) And
                                  ( Not fExisteItemCodItemFornecedor(String(I02_CPROD), String(FGerEle.GER_CODFOR), strCodIteTmp, blnItemAtivoTmp))) Then
                  strCodFab := String(I02_CPROD);
              End;
              frmListaProdutosFCIDivergenteNFE.InserirItem(recProdutoNota);
            End;

          End;

        End; {Else do If FGerEle.strMatRev = 'M' Then}

      End

      Else If (FfinalidadeXML = xmlConsertoEquipamento) Then
      Begin
        If (fEmptyStr(fCfgSis('ITECON', varString))) Then
        Begin
          pIncluiErro('ITEM PARA REMESSA DE CONSERTO DE EQUIPAMENTO NÃO ESTÁ CONFIGURADO NO SISTEMA, VERIFIQUE A CONFIGURAÇÃO ' + QuotedStr('CFG_ITECON'));
          Result := False;
          Exit;
      End;

        DET_CODITE := TString7(fCfgSis('ITECON', varString));
      End;

      I06_EXTIPI   := ShortString(fGetValorXml(nodProd, 'EXTIPI'));
      I07_GENERO   := ShortString(fGetValorXml(nodProd, 'genero'));
      I08_CFOP     := ShortString(fGetValorXml(nodProd, 'CFOP'));

      If blnAuditoria Then
        Exit(True);

      I09_UCOM     := ShortString(fGetValorXml(nodProd, 'uCom'));
      I10_QCOM     := fGetValorXml(nodProd, 'qCom', varDouble);
      I11_VPROD    := fGetValorXml(nodProd, 'vProd', varDouble);
      I13_UTRIB    := ShortString(fGetValorXml(nodProd, 'uTrib'));
      I14_QTRIB    := fGetValorXml(nodProd, 'qTrib', varDouble);
      I14A_VUNTRIB := fGetValorXml(nodProd, 'vUnTrib', varDouble);
      if blnImportaFrete then
      begin
        I15_VFRETE   := fGetValorXml(nodProd, 'vFrete', varDouble);
        I17A_VOUTRO  := fGetValorXml(nodProd, 'vOutro', varDouble);
      end;
      If FNotaImportacao And (not FImportacaoDI) then
        recDetEle.I16_VSEGIMP := fGetVSegNotDet(I02_NITEM);

      I16_VSEG     := fGetValorXml(nodProd, 'vSeg', varDouble);
      I17_VDESC    := fGetValorXml(nodProd, 'vDesc', varDouble);

      If (FfinalidadeXML = xmlRetornoSimbolico) And (Pos(String(I08_CFOP), fCfgSis('CFOB2W', varString)) <= 0) Then
      Begin
        pIncluiErro('ITEM: ' + String(I04_XPROD) + ' (CLAS. FISCAL: ' + String(I08_CFOP) +
          '), NÃO POSSUI UMA CFOP DE RETORNO SIMBOLICO ' +
          'PARA ESTA OPERAÇÃO, VERIFIQUE A NOTA FISCAL E/OU AS CONFIGURAÇÕES DO SISTEMA ("CFG_CFOB2W")...');
        Result := False;
        Exit;
      End;

      If (FfinalidadeXML = xmlConsertoEquipamento) And (Pos(String(I08_CFOP), fCfgSis('CLASAI', varString)) <= 0) Then Begin
        pIncluiErro('ITEM: ' + String(I04_XPROD) + ' (CLAS. FISCAL: ' + String(I08_CFOP) +
          '), NÃO POSSUI UMA CFOP DE ENTRADA DE REMESSA DE EQUIPAMENTO PARA CONSERTO CONFIGURADA ' +
          'PARA ESTA OPERAÇÃO, VERIFIQUE A NOTA FISCAL E/OU AS CONFIGURAÇÕES DO SISTEMA ("CFG_CLASAI")...');
        Result := False;
        Exit;
      End;

      If (FfinalidadeXML = xmlConsignacaoDevolucaoCliente) And
         (Pos(Copy(String(recDetEle.I08_CFOP),2,3), fCfgSis('RETCON', varString)) <= 0) And
         (Pos(Copy(String(recDetEle.I08_CFOP),2,3), fCfgSis('CLADSC', varString)) <= 0) Then
      Begin
        pIncluiErro('ITEM: ' + String(I04_XPROD) + ' (CLAS. FISCAL: ' + String(I08_CFOP) +
          '), NÃO POSSUI UMA CFOP DE DEVOLUÇÃO DE CONSIGNAÇÃO CONFIGURADA PARA ESTA OPERAÇÃO, '+
          'VERIFIQUE A NOTA FISCAL E/OU AS CONFIGURAÇÕES DO SISTEMA ("CFG_RETCON\CFG_CLADSC")...');
        Result := False;
        Exit;
      End;

      If not FGerele.NFeAjuste then
      begin
        if I10_QCOM <= 0 then
        Begin
          If (Not fEmptyStr(String(DET_CODITE))) Then
            pIncluiErro('ITEM: ' + String(DET_CODITE) + ' ESTA COM QUANTIDADE IGUAL A ZERO, IMPOSSÍVEL IMPORTAR ESTA NOTA. POR FAVOR UTILIZE O CADASTRO DE LIVRO FISCAL!')
          Else
            pIncluiErro('O ARQUIVO POSSUI ITENS COM QUANTIDADE IGUAL A ZERO, IMPOSSÍVEL IMPORTAR ESTA NOTA. POR FAVOR UTILIZE O CADASTRO DE LIVRO FISCAL!');
          Result := False;
          blnQtdComZero := True;
          Exit;
        End;
      end;


      If (Not fEmptyStr(String(DET_CODITE))) And (Not blnItemAtivo) And (FfinalidadeXML <> xmlEntradaMercadoriasSistemaAnteriorDevolucao) Then
      Begin
        pIncluiErro('ITEM: ' + String(DET_CODITE) + ' NÃO ESTÁ ATIVO NO SISTEMA, VERIFIQUE O CADASTRO...');
        Result := False;
        Exit;
      End;

      nodDI := nodProd.ChildNodes.FindNode('DI');

      If Assigned(nodDI) Then
        Result := fGetDI(nodDI, recDetEle);

      If Assigned(nodDI) And (Not blnFulFillment) Then
      Begin
        nodADI := nodDI.ChildNodes.FindNode('adi');
        if Assigned(nodADI) then
          Result := fGetADI(nodADI, recDetEle);
      End;

      If Result And (Pos(String(recDetEle.I08_CFOP), CFOP_DEVOLUCAO) > 0) Then
        blnXmlDevolucaoSemEntrada := fXmlDevolucaoSemEntrada;
    End;

    If Result And FNotaImportacao and (not FEmissaoImportacao) Then
      Result := fImportaValoresDOCIMP(recDetEle);

  Except
    Result := FALSE;
  End;

End;

function TNFeXml.fGetRet(nodRet: IXMLNode; var recRetEle: TRecRetEle): Boolean;
begin
  Try
    recRetEle.strReferenciaNFe := String(fGetValorXml(nodRet, 'refNFe'));
    Result := True;
  Except
    Result := False;
  End;

end;

function TNFeXml.fGetRetCount: Integer;
begin
  Result := Length(FArrRetEle);
end;

function TNFeXml.fGetRetornoReferencia(intIndex: Integer): TRecRetEle;
begin
  Result := FArrRetEle[IntIndex];
end;

Function TNFeXml.fGetICMS(nodIcms: IXMLNode; Var recDetEle: TRecDetEle): Boolean;
Begin
  Try
    With recDetEle Do
    Begin
      N11_ORIG        := ShortString(fGetValorXml(nodIcms, 'orig'));
      N12_CST         := ShortString(fGetValorXml(nodIcms, 'CST'));
      N12_CSOSN       := ShortString(fGetValorXml(nodIcms, 'CSOSN'));
      N13_MODBC       := ShortString(fGetValorXml(nodIcms, 'modBC'));
      N14_PREDBC      := fGetValorXml(nodIcms, 'pRedBC', varDouble);
      N16b_PDIF       := fGetValorXml(nodIcms, 'pDif', varDouble);
      N15_VBC         := fGetValorXml(nodIcms, 'vBC', varDouble);
      N16_PICMS       := fGetValorXml(nodIcms, 'pICMS', varDouble);
      N17_VICMS       := fGetValorXml(nodIcms, 'vICMS', varDouble);
      N27A_VICMSDESON := fGetValorXml(nodIcms, 'vICMSDeson', varDouble);
      N27A_MOTDESICMS := ShortString(fGetValorXml(nodIcms, 'motDesICMS'));
      N18_MODBCST     := ShortString(fGetValorXml(nodIcms, 'modBCST'));
      N19_PMVAST      := fGetValorXml(nodIcms, 'pMVAST', varDouble);
      N20_PREBCST     := fGetValorXml(nodIcms, 'pRedBCST', varDouble);
      N21_VBCST       := fGetValorXml(nodIcms, 'vBCST', varDouble);
      N22_PICMSST     := fGetValorXml(nodIcms, 'pICMSST', varDouble);
      N23_VICMSST     := fGetValorXml(nodIcms, 'vICMSST', varDouble);
      N24_CREDSN      := fGetValorXml(nodIcms, 'pCredSN', varDouble);
      N24_CREDICMSSN  := fGetValorXml(nodIcms, 'vCredICMSSN', varDouble);
      N26_VBCSTRET    := fGetValorXml(nodIcms, 'vBCSTRet', varDouble);
      N27_VICMSSTRET  := fGetValorXml(nodIcms, 'vICMSSTRet', varDouble);
      N27_vICMSSubstituto := fGetValorXml(nodIcms, 'vICMSSubstituto', varDouble);

      N34_PREDBCEEFET := fGetValorXml(nodIcms, 'pRedBCEfet', varDouble);
      N35_VBCEFET     := fGetValorXml(nodIcms, 'vBCEfet', varDouble);
      N36_PICMSEFET   := fGetValorXml(nodIcms, 'pICMSEfet', varDouble);
      N37_VICMSEFET   := fGetValorXml(nodIcms, 'vBCEfet', varDouble);

      If blnVersao4 Then
      Begin
        N23A_VBCFCPST   := fGetValorXml(nodIcms, 'vBCFCPST', varDouble);
        N23B_PFCPST     := fGetValorXml(nodIcms, 'pFCPST', varDouble);
        N23D_FCPST      := fGetValorXml(nodIcms, 'vFCPST', varDouble);
        If (N23D_FCPST > 0) And (N23A_VBCFCPST = 0) Then
          N23A_VBCFCPST := N26_VBCSTRET;

        N17A_VBCFCP:= fGetValorXml(nodIcms, 'vBCFCP', varDouble);
        N17B_PFCP  := fGetValorXml(nodIcms, 'pFCP', varDouble);
        N17C_VFCP  := fGetValorXml(nodIcms, 'vFCP', varDouble);
        If (N17C_VFCP > 0) And (N17A_VBCFCP = 0) Then
          N17A_VBCFCP := N15_VBC;
      End;

      If N12_CST = '61' Then
      Begin
        N28_QICMSMONORET := fGetValorXml(nodIcms, 'qBCMonoRet', varDouble);
        N28_ADBCMONORET := fGetValorXml(nodIcms, 'adRemICMSRet',varDouble);
        N28_VREMICMSRET := fGetValorXml(nodIcms, 'vICMSMonoRet',varDouble);
      End;
    End;

    Result := TRUE;

  Except
    Result := FALSE;
  End;
End;

Function TNFeXml.fGetICMSDest(nodIcms: IXMLNode; Var recDetEle: TRecDetEle): Boolean;
Begin
  Try
    With recDetEle Do
    Begin
      N24_VBCUFDEST      := fGetValorXml(nodIcms, 'vBCUFDest', varDouble);
      N24_VBCFCPUFDEST   := fGetValorXml(nodIcms, 'vBCFCPUFDest', varDouble);
      N24_PFCPUFDEST     := fGetValorXml(nodIcms, 'pFCPUFDest', varDouble);
      N24_PICMSUFDEST    := fGetValorXml(nodIcms, 'pICMSUFDest', varDouble);
      N24_PICMSINTER     := fGetValorXml(nodIcms, 'pICMSInter', varDouble);
      N24_PICMSINTERPART := fGetValorXml(nodIcms, 'pICMSInterPart', varDouble);
      N24_VFCPUFDEST     := fGetValorXml(nodIcms, 'vFCPUFDest', varDouble);
      N24_VICMSUFDEST    := fGetValorXml(nodIcms, 'vICMSUFDest', varDouble);
      N24_VICMSUFREMET   := fGetValorXml(nodIcms, 'vICMSUFRemet', varDouble);
    End;

    Result := TRUE;

  Except
    Result := FALSE;
  End;
End;

function TNFeXml.fRenomearArquivo(blnRenomearCancelados: Boolean = False; strNomArq: String = ''): Boolean;
  Var
    strArquivo: String;
Begin

  Try
    If (Not blnRenomearCancelados) And (Not fEmptyStr(String(FGerEle.strAutInc))) Then
      fGravarXml;

    strArquivo := FPatArq + FNomArq;
    If blnAuditoria Then
      Result := RenameFile(strArquivo, LeftStr(strArquivo, Length(strArquivo) - 4) + '.AUD')
    Else If blnRenomearCancelados Then
    Begin
      strArquivo := FPatArq + strNomArq;
      Result := RenameFile(strArquivo, LeftStr(strArquivo, Length(strArquivo) - 4) + '.CANC')
    End
    Else
      Result := RenameFile(strArquivo, LeftStr(strArquivo, Length(strArquivo) - 4) + '.IMP');

    If Not Result Then
      pIncluiErro('NAO FOI POSSIVEL RENOMEAR O ARQUIVO ' + FNomArq);
  Except
    Result := FALSE;
    pIncluiErro('NAO FOI POSSIVEL RENOMEAR O ARQUIVO ' + FNomArq);
  End;
End;

Procedure TNFeXml.pMarcaMostrar(blnMostrar: Boolean);
Begin
  If Assigned(FCdsIncon) And FCdsIncon.Active Then
  Begin
     FCdsIncon.Filter   := 'NUMDOC = ' + QuotedStr(String(FGerEle.B08_NNF)) + ' AND CODFOR = ' + QuotedStr(String(FGerEle.GER_CODFOR));
     FCdsIncon.Filtered := True;
     FCdsIncon.First;

     While Not FCdsIncon.Eof Do
     Begin
       FCdsIncon.Edit;
       FCdsIncon.FieldByName('MOSTRA').AsString := IIF(blnMostrar, 'S', 'N');
       FCdsIncon.Post;

       FCdsIncon.Next;
     End;
     FCdsIncon.Filtered := False;
  End;
End;

Procedure TNFeXml.pMontaCondicaoPagamento;
  Var
    intContador : Integer;
    arrDatas    : TDateArray;
begin
  If Length(FArrDupEle) > 0 Then
  Begin
    SetLength(arrDatas, Length(FArrDupEle));

    For intContador := Low(FArrDupEle) To High(FArrDupEle) Do
    If (intContador <= 23) Then
    Begin
      arrDatas[intContador] := FArrDupEle[intContador].Y09_DtaVen;
    End;

    FGerEle.GER_CONPAG := ShortString(fRetornaCndPag(arrDatas, FGerEle.B09_DEMI));
  End

  Else FGerEle.GER_CONPAG := '';
End;

function TNFeXml.fCarregarDoArquivo(strArquivo: String;
                                    Var cdsDiverg: TZClient;
                                    blnFulFillment: Boolean = False;
                                    blnEhEmissaoImportacao: Boolean = False;
                                    strCodFor: string = '';
                                    blnEhImportacaoDI: Boolean = False): Boolean;
  Var
    xmlDoc: TXMLDocument;
    nodNFe,
    nodInfNFe,
    nodnfeProc,
    nodIde,
    nodEmit,
    nodDest,
    nodenderDest,
    nodTotal,
    nodTransp,
    nodDet,
    nodProtNfe,
    nodCobr,
    nodDup,
    nodInfProt,
    nodInfCpl,
    nodObsCont,
    enviNFe,
    nodXTexto : IXMLNode;
    recDetEleTmp: TRecDetEle;
    recDupEleTmp: TRecDupEle;
    blnQtdComZero: Boolean;
    intQtdItens: Integer;
    intI: Integer;
    enmStatusXML: TStatusNFeXml;
    strNaoEncontradas: String;

Begin
  Try
    Self.blnFulFillment := blnFulFillment;

    If Not blnFulFillment Then
    Begin
      Self.FPatArq   := ExtractFilePath(strArquivo);
      Self.FNomArq   := ExtractFileName(strArquivo);
    End
    Else
      blnValidar := False;

    FDivCST        := False;
    FGerEle.vlrTotDupl := 0;
    Self.FCdsIncon := cdsDiverg;

    FErro := False;

    Try
      FillChar(FGerEle, SizeOf(FGerEle), #0);

      xmlDoc := TXMLDocument.Create(Self);

      FEmissaoImportacao := blnEhEmissaoImportacao;
      FImportacaoDI := blnEhImportacaoDI;

      With xmlDoc Do
      Begin
        If blnFulFillment Then
          LoadFromXML(strArquivo)
        Else
          LoadFromFile(strArquivo);

        Active := TRUE;

        nodnfeProc := Node.ChildNodes.FindNode('nfeProc');

        If Assigned(nodnfeProc) Then
        Begin
          nodNFe     := nodnfeProc.ChildNodes.FindNode('NFe');
          nodProtNfe := nodnfeProc.ChildNodes.FindNode('protNFe');
        End
        Else
        Begin
          nodNFe     := Node.ChildNodes.FindNode('NFe');
          nodProtNfe := Node.ChildNodes.FindNode('protNFe');
        End;

        If not Assigned(nodNFe) Then
        Begin
          enviNFe := Node.ChildNodes.FindNode('enviNFe');
          If Assigned(enviNFe) then
            nodNFe     := enviNFe.ChildNodes.FindNode('NFe');
        End;

        If blnFulFillment And (Not Assigned(nodNFe)) Then
        Begin
          nodnfeProc := Node.ChildNodes.FindNode('NFeList');

          If Assigned(nodnfeProc) Then
          Begin
            nodNFe     := nodnfeProc.ChildNodes.FindNode('NFe');
            nodProtNfe := nodnfeProc.ChildNodes.FindNode('protNFe');
          End
        End;

        If Assigned(nodNFe) Then
        Begin
          nodInfNFe := nodNFe.ChildNodes.FindNode('infNFe');
          blnVersao4 := nodInfNFe.Attributes['versao'] = '4.00';
          FNotaImportacao := fEhNotaImportacao(nodInfNFe, blnEhEmissaoImportacao, strCodFor);

          If Assigned(nodInfNFe) Then
          Begin
            nodIde := nodInfNFe.ChildNodes.FindNode('ide');

            If Assigned(nodIde) Then
            Begin
              Result := fGetIde(nodIde);

              If Not Result Then
                Exit;

            End Else
            Begin
              pIncluiErro('ESTRUTURA DO ARQUIVO INCOMPATIVEL - (SEM Ide)');
              Result := FALSE;
              Exit;
            End;

            nodEmit := nodInfNFe.ChildNodes.FindNode('emit');

            If Assigned(nodEmit) Then
            Begin
              Result := fGetEmit(nodEmit);

              If FNotaImportacao Then
                Result := fGetDest(nodEmit);
              If blnAuditoria then
                Result := True;

              If Not Result Then
                Exit;

            End Else
            Begin
              pIncluiErro('ESTRUTURA DO ARQUIVO INCOMPATIVEL - (SEM Emit)');
              Result := FALSE;
              Exit;
            End;

            // DESTINATARIO
            nodDest := nodInfNFe.ChildNodes.FindNode('dest');

            If (Not FNotaImportacao) Then
            Begin
              If (FCriarTagDestinatarioEmBrancoCasoInexistente) Then
              Begin
                If Not Assigned(nodDest) Then
                Begin
                  nodDest := nodInfNFe.AddChild('dest');
                  nodDest.AddChild('CPF').NodeValue   := '';
                  nodDest.AddChild('xNome').NodeValue := '';

                  nodenderDest := nodDest.AddChild('enderDest');
                  nodenderDest.AddChild('xLgr').NodeValue    := '';
                  nodenderDest.AddChild('nro').NodeValue     := '';
                  nodenderDest.AddChild('xBairro').NodeValue := '';
                  nodenderDest.AddChild('cMun').NodeValue    := '';
                  nodenderDest.AddChild('UF').NodeValue      := '';
                  nodenderDest.AddChild('CEP').NodeValue     := '';
                  nodenderDest.AddChild('fone').NodeValue    := '';
                End;
              End;
            End;

            If Assigned(nodDest) Then
            Begin
              If Not FNotaImportacao Then
                Result := fGetDest(nodDest);

              If Not Result Then
                Exit;

            End Else
            Begin
              pIncluiErro('ESTRUTURA DO ARQUIVO INCOMPATIVEL - (SEM Dest)');
              Result := FALSE;
              Exit;
            End;

            If (blnValidar) And (fNotaExiste(String(FGerEle.B08_NNF), String(FGerEle.B07_SERIE), String(FGerEle.B11_TPNF), String(FGerEle.C02_CNPJ), String(FGerEle.C02A_CPF))) Then
            Begin
              If Not blnAuditoria then
              begin
                pIncluiErro('NOTA ' + String(FGerEle.B08_NNF) + ' JA EXISTE');
                Result := FALSE;
                Exit;
              End;
            End;

            If Assigned(nodProtNfe) Then
            Begin

              nodInfProt := nodProtNfe.ChildNodes.FindNode('infProt');

              If Assigned(nodInfProt) Then
              Begin
                Result := fGetChaveStatus(nodInfProt);

                If Not Result Then
                  Exit;

              End
              Else
              Begin
                pIncluiErro('ESTRUTURA DO ARQUIVO INCOMPATIVEL - (SEM infProt)');
                Result := FALSE;
                Exit;
              End;

              If (blnValidaXMLSefaz) And (Not fEmptyStr(FGerEle.PR07_CHNFE)) Then
              Begin
                enmStatusXML := fGetStatusXML(FGerEle.PR07_CHNFE, String(FGerEle.GER_CODEMP));
                If enmStatusXML = stXMLCancelada Then
                  blnXMLCancelado := True
                Else If enmStatusXML = stXMLIndefinido Then
                  blnXMLIndefinido := True;
              End;

              If fNotaExisteCadFis And (Not FNotaImportacao) Then
              Begin
                pIncluiErro('NOTA ' + String(FGerEle.B08_NNF) + ' JÁ EXISTE NO LIVRO FISCAL');
                Result := FALSE;
                Exit;
              End;

              nodTotal   := nodInfNFe.ChildNodes.FindNode('total');
              nodTransp  := nodInfNFe.ChildNodes.FindNode('transp');

              If Assigned(nodTotal) Then
              Begin
                Result := fGetTotal(nodTotal);

                If Not Result Then
                  Exit;

              End Else
              Begin
                pIncluiErro('ESTRUTURA DO ARQUIVO INCOMPATIVEL - (SEM Total)');
                Result := FALSE;
                Exit;
              End;

              If Assigned(nodTransp) Then
              Begin
                Result := fGetTransp(nodTransp);

                If Not Result Then
                  Exit;
              End;


              intQtdItens := 0;

              fltRedAliCargaMediaEmp := 0;
              If fCfgSis('URSTCL', varBoolean, String(FGerEle.GER_CODEMP)) Then
                fltRedAliCargaMediaEmp := fRetReducaoAliquotaCargaMediaEmpresa(String(FGerEle.GER_CODEMP));


              nodDet := nodInfNFe.ChildNodes.FindNode('det');
              If FNotaImportacao then
                pCarregaNotGer;

              If Not blnAuditoria Then
              Begin
                stlListaNotImp.Clear;
                While Assigned(nodDet) And (nodDet.GetNodeName = 'det') Do
                Begin
                  pLimparRecDetEle(recDetEleTmp);

                  recDetEleTmp.I02_NITEM := nodDet.Attributes['nItem'];

                  Result := fGetDet(nodDet, recDetEleTmp, blnQtdComZero);

                  If Result Then
                    pAdicionarItem(recDetEleTmp, FGerEle)
                  Else if blnQtdComZero then
                    Break;

                  nodDet := nodDet.NextSibling;

                  inc(intQtdItens);

                  If Assigned(frmGravandoNotas) Then
                  Begin
                    frmGravandoNotas.lblGravando.Caption := 'Carregando notas. Produtos: ' + IntToStr(intQtdItens);
                    Application.ProcessMessages;
                  End;
                End;
              End;

            End
            Else
            Begin

              FGerEle.PR07_CHNFE := Copy(nodInfNFe.Attributes['Id'], 4, Length(nodInfNFe.Attributes['Id']));

              If (blnValidaXMLSefaz) And (Not fEmptyStr(FGerEle.PR07_CHNFE)) Then
              Begin
                enmStatusXML := fGetStatusXML(FGerEle.PR07_CHNFE, String(FGerEle.GER_CODEMP));
                If enmStatusXML = stXMLCancelada Then
                  blnXMLCancelado := True
                Else If enmStatusXML = stXMLIndefinido Then
                  blnXMLIndefinido := True;
              End;

              If (fEmptyStr(FGerEle.PR07_CHNFE)) and (not blnEhEmissaoImportacao) Then
                Exit;

              nodTotal := nodInfNFe.ChildNodes.FindNode('total');
              nodTransp  := nodInfNFe.ChildNodes.FindNode('transp');

              If Assigned(nodTotal) Then
              Begin
                Result := fGetTotal(nodTotal);

                If Not Result Then
                  Exit;

              End Else
              Begin
                pIncluiErro('ESTRUTURA DO ARQUIVO INCOMPATIVEL - (SEM Total)');
                Result := FALSE;
                Exit;
              End;

              If Assigned(nodTransp) Then
              Begin
                Result := fGetTransp(nodTransp);

                If Not Result Then
                  Exit;
              End;

              intQtdItens := 0;
              If Not blnAuditoria Then
              Begin
                nodDet := nodInfNFe.ChildNodes.FindNode('det');
                While Assigned(nodDet) And (nodDet.GetNodeName = 'det') Do
                Begin
                  pLimparRecDetEle(recDetEleTmp);

                  Result := fGetDet(nodDet, recDetEleTmp, blnQtdComZero);

                  If Result Then
                    pAdicionarItem(recDetEleTmp, FGerEle)
                  Else if blnQtdComZero then
                    Break;

                  nodDet := nodDet.NextSibling;

                  inc(intQtdItens);

                  If Assigned(frmGravandoNotas) Then
                  Begin
                    frmGravandoNotas.lblGravando.Caption := 'Carregando notas. Produtos: ' + IntToStr(intQtdItens);
                    Application.ProcessMessages;
                  End;
                End;
              End;

            End;

            If (FGerEle.NFeAjuste) and (fGetRetCount = 0)then
            begin
              pIncluiErro('Nota ' + String(FGerEle.B08_NNF) + ' identificada como NF de Ajuste; porém, não foi identificado as tags de referencia!');
              Result := FALSE;
            end
            Else If FGerEle.NFeAjuste Then
            Begin
              strNaoEncontradas := '';
              For intI := 0 to fGetRetCount - 1 Do
                If fEmptyStr(fCampoTabela('AUTOINCREM', 'CADFIS', ['FIS_ACESSO', 'FIS_CODEMP'], [getRetornoReferencia[intI].strReferenciaNFe, FGerEle.GER_CODEMP])) Then
                  strNaoEncontradas := strNaoEncontradas + IIf(fEmptyStr(strNaoEncontradas), '', ', ') + getRetornoReferencia[intI].strReferenciaNFe;
              If Not fEmptyStr(strNaoEncontradas) Then
              Begin
                pIncluiErro('Nota de Ajuste ' + String(FGerEle.B08_NNF) + ': Não foi localizado os documentos referenciados no livro fiscal:' + char(13) + strNaoEncontradas);
                Result := FALSE;
              End;
            End;

            FGerEle.GER_CONPAG := '';
            If Not blnAuditoria Then
            Begin
              nodCobr := nodInfNFe.ChildNodes.FindNode('cobr');
              if Assigned(nodCobr) Then
              Begin
                nodDup := nodCobr.ChildNodes.FindNode('dup');
                While Assigned(nodDup) And (nodDup.GetNodeName = 'dup') Do
                Begin
                  recDupEleTmp.Y08_NumDup := fGetValorXml(nodDup, 'nDup', varString);
                  recDupEleTmp.Y09_DtaVen := fGetValorXml(nodDup, 'dVenc', varDate);
                  recDupEleTmp.Y10_VlrDup := fGetValorXml(nodDup, 'vDup', varDouble);
                  FGerEle.vlrTotDupl      := FGerEle.vlrTotDupl + recDupEleTmp.Y10_VlrDup;
                  pAdicionarDup(recDupEleTmp);
                  nodDup := nodDup.NextSibling;
                End;

                If Length(FArrDupEle) > 24 Then
                Begin
                  pIncluiErro('DOCUMENTO COM MAIS DE 24 PARCELAS. AS PARCELAS NÃO SERÃO IMPORTADAS', True);
                  SetLength(FArrDupEle, 0);
                End;

                pMontaCondicaoPagamento;
              End;

              nodInfCpl := nodInfNFe.ChildNodes.FindNode('infAdic');
              if Assigned(nodInfCpl) Then
              begin
                FGerEle.Z03_infCpl     := VarToWideStr(fGetValorXml(nodInfCpl, 'infCpl', varString));
                FGerEle.Z02_infAdFisco := VarToWideStr(fGetValorXml(nodInfCpl, 'infAdFisco', varString));

                nodObsCont := nodInfCpl.ChildNodes.FindNode('obsCont');
                if Assigned(nodObsCont) Then
                begin
                  nodXTexto := nodObsCont.ChildNodes.FindNode('xTexto');
                  if Assigned(nodXTexto) Then
                  begin
                    FGerEle.strXTexto := VarToStr(fGetValorXml(nodObsCont, 'xTexto', varString));
                  end;
                end;
              End;
            End;

          End Else
          Begin
            pIncluiErro('ESTRUTURA DO ARQUIVO INCOMPATIVEL - (SEM InfNFe)');
            Result := FALSE;
          End;

        End
        Else If fXMLCancelamento(xmlDoc) Then
        Begin
          Result := True;
        End
        Else
        Begin
          If blnXMLCancelamentoSemNota Then
            pIncluiErro('XML DE CANCELAMENTO SEM NOTA ENCONTRADA')
          Else
            pIncluiErro('ESTRUTURA DO ARQUIVO INCOMPATIVEL - (SEM NFe)');
          Result := FALSE;
        End;

      End;

      FreeAndNil(xmlDoc);

    Except
      On E: Exception Do
      Begin
        Result := FALSE;
        If (blnFulFillment) or (blnEhEmissaoImportacao) Then
          Raise Exception.Create(E.Message)
        Else
        pIncluiErro(E.Message);
      End;
    End;

    Result := Result And (Not FErro);
    If not blnAuditoria Then
      If Not(FfinalidadeXML = xmlRetornoSimbolico) Then
        If Result And Assigned(objValidaNFeCapa)Then
          processaCapa_x_Detalhes;

    If blnXMLCancelamento Or blnXmlDevolucaoSemEntrada Or blnXMLCancelado Or blnXMLIndefinido Then
      pMarcaMostrar(False)
    Else
      pMarcaMostrar(Result);

    cdsDiverg := Self.FCdsIncon;
  finally
    If Assigned(qryNotGer) Then
      FreeAndNIl(qryNotGer);
  End;

End;

function TNFeXml.fExisteFornecedorCitel(strCodCit: String; var strCodFor: TString8; Var strMatRev: String): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  strCodFor := '';

  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Add('SELECT FOR_CODFOR, FOR_MATREV FROM CADFOR');
    Add('WHERE');
    Add('  FOR_CODFOR = :CODFOR ');
    Add('  AND FOR_STATUS = "A" ');

    ParamByName('CODFOR').AsString := strCodCit;

    Open;
    Result := Not IsEmpty;

    If Result Then
    Begin
      strCodFor := ShortString(FieldByName('FOR_CODFOR').AsString);
      strMatRev := FieldByName('FOR_MATREV').AsString;

      fCarregaDadosFornecedor(String(strCodFor));
    End;

    Close;
  End;

  FreeAndNil(qryGen);
End;

Function TNFeXml.fExisteItemMatConsumo(strCodBar, strCodFab: String; Var strCodIte: TString7; Var blnAtivo: Boolean; Var recDetEle: TRecDetEle): Boolean;
  Var
    qryCadMco: TUniQuery;
Begin
  Try
    strCodIte := '';
    qryCadMco := fCriaQuery;

    With qryCadMco, SQL Do
    Begin
      //PESQUISA PELO CÓDIGO DE FÁBRICA
      Text := 'SELECT * FROM CADMCO WHERE MCO_CODFOR = :CODFOR AND MCO_CODFAB = :CODFAB';
      ParamByName('CODFOR').AsString := String(FGerEle.GER_CODFOR);
      ParamByName('CODFAB').AsString := strCodFab;
      Open;

      If IsEmpty and (strCodBar <> '') Then
      Begin
        //PESQUISA PELO CÓDIGO DE BARRAS
        Close;
        Text := 'SELECT * FROM CADMCO WHERE MCO_CODFOR = :CODFOR AND MCO_CODBAR = :CODBAR';
        ParamByName('CODFOR').AsString := String(FGerEle.GER_CODFOR);
        ParamByName('CODBAR').AsString := strCodBar;
        Open;
      End;

      If IsEmpty Then
      Begin
        //PESQUISA PELA DESCRIÇÃO
        Close;
        Text := 'SELECT * FROM CADMCO WHERE MCO_CODFOR = :CODFOR AND MCO_DESCRI = :DESCRI';
        ParamByName('CODFOR').AsString := String(FGerEle.GER_CODFOR);
        ParamByName('DESCRI').AsString := String(recDetEle.I04_XPROD);
        Open;
      End;

      If IsEmpty Then
      Begin
       // NÃO ENCONTROU, CADASTRA.
        qryCadMco.Insert;

        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADMCO', VS_strCodEmp);
        FieldByName('MCO_CODEMP').AsString := VS_strCodEmp;
        FieldByName('MCO_CODMCO').AsString := fAtualizaProCod('CADMCO', 'MCO_CODMCO');
        FieldByName('MCO_DESCRI').AsString := String(recDetEle.I04_XPROD);
        FieldByName('MCO_MCOATI').AsString := 'S';
        FieldByName('MCO_PRECOM').AsFloat  := recDetEle.I10A_VUNCOM;
        FieldByName('MCO_CODFOR').AsString := String(FGerEle.GER_CODFOR);
        FieldByName('MCO_CODFAB').AsString := strCodFab;
        FieldByName('MCO_CODBAR').AsString := strCodBar;
        Post;
      End;


      recDetEle.DET_CODMCO := FieldByName('MCO_CODMCO').AsString;
    End;

    strCodIte := FIteMatCon;

    Result := True;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TNFeXml.fExisteItemMatConsumo]');
      Result := False;
    End;
  End;

  FreeAndNil(qryCadMco);
End;

function TNFeXml.fExisteNotaEntradaChaveNFE(strChaNFE: String; var strDocume: String): Boolean;
  Var
    qryCadFis: TUniQuery;
Begin
  If fEmptyStr(strChaNFE) Then
  Begin
    Result := False;
    Exit;
  End;

  qryCadFis := fCriaQuery;
  With qryCadFis, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add(' CONCAT("LIVRO FISCAL - NOTA:",          ');
    Add('         FIS_NUMDOC, "-",                ');
    Add('         FIS_ESPDOC, " SERIE:",          ');
    Add('         IFNULL(FIS_SERIE_, ""),         ');
    Add('         " FORNECEDOR:", FIS_FORCLI, "-",');
    Add('         FOR_NOMFOR) AS DOCUMENTO        ');
    Add(' FROM CADFIS  INNER JOIN CADFOR          ');
    Add('              ON FIS_FORCLI = FOR_CODFOR ');
    Add('  WHERE                    ');
    Add('  FIS_ACESSO = :ACESSO AND ');
    Add('  FIS_CODEMP = :CODEMP     ');
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('ACESSO').AsString := strChaNFE;
    Open;

    Result := Not IsEmpty;

    If not result then
    Begin
      Close;
      Clear;
      Add('SELECT');
      Add(' CONCAT("IMPORTAÇÃO DE NOTA - NOTA:",    ');
      Add('         B08_NNF, "-",                   ');
      Add('         "NF", " SERIE:",                ');
      Add('         IFNULL(B07_SERIE, ""),          ');
      Add('         " FORNECEDOR:", GER_CODFOR, "-",');
      Add('         FOR_NOMFOR) AS DOCUMENTO        ');
      Add(' FROM GERELE  INNER JOIN CADFOR          ');
      Add('              ON GER_CODFOR = FOR_CODFOR ');
      Add('  WHERE                    ');
      Add('  PR07_CHNFE = :ACESSO AND ');
      Add('  GER_CODEMP = :CODEMP     ');
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('ACESSO').AsString := strChaNFE;

      Open;
      Result := Not IsEmpty;
    End;

    If Result Then
      strDocume := FieldByName('DOCUMENTO').AsString
    Else
      strDocume := '';
  End;
  FreeAndNil(qryCadFis);
end;

Function TNFeXml.fExisteItemCodCitel(strCodCit: String; Var strCodIte: TString7; Var blnAtivo: Boolean): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  strCodIte := '';
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Add('SELECT ');
    Add('  ITE_CODITE, ');
    Add('  ITE_DESITE, ');
    Add('  ITE_ITEATI, ');
    Add('  UNI_SIGUNI  ');
    Add('FROM ');
    Add('  CADITE ');
    Add('  LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ');
    Add('WHERE');

    Add('  ITE_CODITE = :CODITE ');

    ParamByName('CODITE').AsString := strCodCit;

    Open;
    Result := Not IsEmpty;
    If Result Then
    Begin
      strCodIte := ShortString(FieldByName('ITE_CODITE').AsString);
    End;

    blnAtivo := (FieldByName('ITE_ITEATI').AsString = 'S');

    If blnIgnoraInativos Then
      blnAtivo := True;

    Close;
  End;

  FreeAndNil(qryGen);
End;

function TNFeXml.fGetII(nodII: IXMLNode; var recDetEle: TRecDetEle): Boolean;
Begin
  Try

    With recDetEle Do
    Begin
      P02_VBC      := fGetValorXml(nodII, 'vBC', varDouble);
      P03_VDESPADU := fGetValorXml(nodII, 'vDespAdu', varDouble);
      P04_VII      := fGetValorXml(nodII, 'vII', varDouble);
      P05_VIOF     := fGetValorXml(nodII, 'vIOF', varDouble);
    End;

    Result := TRUE;

  Except
    Result := FALSE;
  End;
End;


Function TNFeXml.fImportaValoresDOCIMP(Var recDetEle: TRecDetEle): Boolean;
  Var
    qryNotDet: TUniquery;
 Begin
  qryNotDet := fCriaQuery;
  With qryNotDet, SQL Do
  Begin
    Add('SELECT ');
    Add('  IMP_VAL_II,');
    Add('  IMP_SISCOM, ');
    Add('  N.AUTOINCREM ');
    Add('FROM ');
    Add('  DOCIMP D');
    Add('INNER JOIN NOTDET N ON N.AUTOINCREM = D.IMP_SEQDET');
    Add('WHERE');
    Add('  ((IFNULL(DET_SERIE_, "") = :SERIE_)  OR ');
    Add('   (IFNULL(DET_SERIE_, "") = :SERIE2)) AND');
    Add('  DET_NUMDOC = :NUMDOC AND');
    Add('  DET_CODEMP = :CODEMP AND');
    Add('  DET_CODFOR = :CODFOR AND ');
    Add('  DET_CODITE = :CODITE AND ');
    Add('  DET_QTDITE = :QTDITE');
    If stlListaNotImp.Count > 0 then
      Add('  AND N.AUTOINCREM NOT IN ('+stlListaNotImp.CommaText+')');

    ParamByName('NUMDOC').AsString := RightStr(string(FGerEle.B08_NNF), FintTamNumDocGerEle);

    If fEmptyStr(string(FGerEle.B07_SERIE)) Then
      ParamByName('SERIE_').AsString := string(FGerEle.B07_SERIE)
    Else
      ParamByName('SERIE_').AsString := RightStr('000' + string(FGerEle.B07_SERIE), 3);

    ParamByName('SERIE2').AsString := string(FGerEle.B07_SERIE);

    ParamByName('CODEMP').AsString := string(FGerEle.GER_CODEMP);
    ParamByName('CODFOR').AsString := string(FGerEle.GER_CODFOR);

    ParamByName('QTDITE').AsFloat := recDetEle.I10_QCOM;
    ParamByName('CODITE').AsString := string(recDetEle.DET_CODITE);

    Open;

    With recDetEle Do
    If Isempty Then
    Begin
      Result := False;
      pIncluiErro('O código de fábrica do XML não foi localizado para nenhum item no sistema');
    End Else
    Begin
      DET_VALIMP := FieldByName('IMP_VAL_II').AsFloat;
      DET_VALSIS := qryNotDet.FieldByName('IMP_SISCOM').AsFloat;
      stlListaNotImp.Add(QuotedStr(qryNotDet.FieldByName('AUTOINCREM').AsString));
      Result := True;
    End;

    Close;

  End;
  FreeAndNil(qryNotDet);
End;

Function TNFeXml.fGetComb(nodComb: IXMLNode; Var recDetEle: TRecDetEle): Boolean;
Begin
  Try
    With recDetEle Do
    Begin
      LA02_CPRODANP := ShortString(fGetValorXml(nodComb, 'cProdANP'));
    End;
    Result := True;
  Except
    Result := False;
  End;
End;

Function TNFeXml.fGetDI(nodDI: IXMLNode; Var recDetEle: TRecDetEle): Boolean;
Begin
  Try
    With recDetEle Do
    Begin
      I23B_VAFRMM       := fGetValorXml(nodDI, 'vAFRMM', varDouble);
      I19_NDI           := ShortString(fGetValorXml(nodDI, 'nDI'));
      I21_XLOCDESEMB    := ShortString(fGetValorXml(nodDI, 'xLocDesemb'));
      I23E_UFTERCEIRO   := ShortString(fGetValorXml(nodDI, 'UFTerceiro'));
      I23D_CNPJ         := ShortString(fGetValorXml(nodDI, 'CNPJ'));
      I20_DDI           := ShortString(fGetValorXml(nodDI, 'dDI'));
      I23_DDESEMB       := ShortString(fGetValorXml(nodDI, 'dDesemb'));
      I22_UFDESEMB      := ShortString(fGetValorXml(nodDI, 'UFDesemb'));
      I23A_TPVIATRANSP  := ShortString(fGetValorXml(nodDI, 'tpViaTransp'));
      I23C_TPINTERMEDIO := ShortString(fGetValorXml(nodDI, 'tpIntermedio'));
    End;

    Result := TRUE;

  Except
    Result := FALSE;
  End;
End;

function TNFeXml.fEhNotaImportacao(nodInfNFe: IXMLNode; blnEhEmissaoImportacao: Boolean = False; strCodFor: string = ''): Boolean;
  Var
    nodDet,
    nodProd,
    nodDI: IXMLNode;
    strCFOP,
    strCodForImportacao: String;
Begin
  Result := False;

  nodDet := nodInfNFe.ChildNodes.FindNode('det');

  If Assigned(nodDet) And (nodDet.GetNodeName = 'det') Then
  Begin
    nodProd := nodDet.ChildNodes.FindNode('prod');

    If Assigned(nodProd) Then
    Begin
      strCFOP := fGetValorXml(nodProd, 'CFOP');

      Result := LeftStr(strCFOP, 1) = '3';

      If Result Then
      Begin
        nodDI := nodProd.ChildNodes.FindNode('DI');

        If Assigned(nodDI) Then
        Begin
          if (blnEhEmissaoImportacao) and (Trim(strCodFor) <> '') then
          begin
            strCodForImportacao := strCodFor;
          end
          else
          begin
            strCodForImportacao := fGetValorXml(nodDI, 'cExportador');
          end;
          If Not fExisteFornecedorCitel(strCodForImportacao, FGerEle.GER_CODFOR, FGerEle.strMatRev) Then
          begin
            if blnEhEmissaoImportacao then
            begin
              Raise Exception.Create('Fornecedor não encontrado.');
            end
            else
            begin
              pIncluiErro('CÓDIGO DO FORNECEDOR ' + strCodForImportacao + ' NÃO CADASTRADO OU INATIVO.');
            end;
          end;
        End;
      End;

    End;

  End;
End;

procedure TNFeXml.pRegistraItemParaGravacao(recGerEle: TRecGerEle; recDetEle: TRecDetEle);
  var
    fltPerFre,
    fltDesAce,
    fltDesEsp,
    fltSubsti: Double;
begin
  fltDesAce := recDetEle.I17A_VOUTRO + recDetEle.I16_VSEG;
  fltDesEsp := fDescontoXML(recGerEle, recDetEle);

  fltSubsti := 0;
  fltPerFre := 0;
  
  If (recDetEle.I11_VPROD - fltDesEsp) > 0 Then
  Begin
    //Calcula Frete
    If fRateioFreteValorContabil(trfIndefinido) Then
      fltPerFre := ((recDetEle.I15_VFRETE)/(recDetEle.I11_VPROD - fltDesEsp + recDetEle.O14_VIPI + (recDetEle.N23_VICMSST + fltDesAce))) * 100
    Else
      fltPerFre := ((recDetEle.I15_VFRETE)/(recDetEle.I11_VPROD - fltDesEsp)) * 100;

  	//Calcula Substituição Tributario
  	If blnATUSUB Then
  	Begin
      If strFRMCUS = '1' Then
      	fltSubsti := (((recDetEle.N23_VICMSST + recDetEle.N23D_FCPST)/(recDetEle.I11_VPROD - fltDesEsp + recDetEle.O14_VIPI + recDetEle.N23_VICMSST)) * 100 )
      Else
        fltSubsti := (((recDetEle.N23_VICMSST + recDetEle.N23D_FCPST)/(recDetEle.I11_VPROD - fltDesEsp)) * 100);
    End;
  End;

  If Assigned(FOnNaoEncontrouItem) Then
    FOnNaoEncontrouItem(String(FGerEle.B08_NNF),
                        IIF(FfinalidadeXML in [xmlGarantiaRecCliente, xmlConsignacaoDevolucaoCliente, xmlRetornoLocacao],  String(FGerEle.GER_CODCLI), String(FGerEle.GER_CODFOR)),
                        String(recDetEle.I02_CPROD),
                        String(recDetEle.I04_XPROD),
                        String(recDetEle.I03_CEAN),
                        String(recDetEle.I09_UCOM),
                        String(recDetEle.I05_NCM),
                        string(recDetEle.I08_CFOP),
                        fCalculaCSTXML(recDetEle, ''),
                        String(recDetEle.CODCEST),
                        String(recDetEle.I70_NFCI),
                        String(recDetEle.I03_CEAN),
                        String(recDetEle.I12_CEANTRIB),
                        recDetEle.I10_QCOM,
                        recDetEle.I10A_VUNCOM,
                        fltPerFre,
                        recDetEle.ITE_PER_CI,
                        recDetELE.O13_PIPI,
                        recDetELE.N16_PICMS,
                        fltSubsti,
                        String(FGerEle.C12_UF));
end;


procedure TNFeXml.processaCapa_x_Detalhes;
var recValoresItem: TValoresItem;
    recValoresCapa: TValoresCapa;
    recDetEle: TRecDetEle;
    intContador : integer;
begin;
  TValidaNFeCapa.fIniciaValoresCapa(recValoresCapa);
  recValoresCapa.strChave_ := FGerEle.PR07_CHNFE;
  recValoresCapa.fltTOTPRO := FGerEle.W07_VPROD + FGerEle.W18_VSERV;

  If blnConsiderarDescontoDesonerado Then
    recValoresCapa.fltVICMSDESON := FGerEle.W04A_VICMSDESON;

  recValoresCapa.fltVDESC := FGerEle.W10_VDESC;
  recValoresCapa.fltVOUTRO := FGerEle.W15_VOUTRO;
  recValoresCapa.fltVSEG := FGerEle.W09_VSEG;
  recValoresCapa.fltBASICM := FGerEle.W03_VBC;
  recValoresCapa.fltVALICM := FGerEle.W04_VICMS;
  recValoresCapa.fltBAS_ST := FGerEle.W05_VBCST;
  recValoresCapa.fltVAL_ST := FGerEle.W06_VST;
  recValoresCapa.fltBASIPI := 0;
  For recDetEle in FArrDetEle do
    recValoresCapa.fltBASIPI := recValoresCapa.fltBASIPI + recDetEle.O10_VBC;
  recValoresCapa.fltVALIPI := FGerEle.W12_VIPI;
  recValoresCapa.fltVALFRE := FGerEle.W08_VFRETE;

  recValoresCapa.strB08_NNF   := String(FGerEle. B08_NNF);
  recValoresCapa.strB07_SERIE := String(FGerEle. B07_SERIE);
  recValoresCapa.strB09_DEMI  := DateToStr(FGerEle. B09_DEMI);

  objValidaNFeCapa.pAddValoresCapa(recValoresCapa);
  intContador := 0;

  For recDetEle in FArrDetEle do
  Begin
    TValidaNFeCapa.fIniciaValoresItem(recValoresItem);
    recValoresItem.strCHAVE_ := recValoresCapa.strChave_;
    recValoresItem.strCODITE := String(recDetEle.DET_CODITE);
    recValoresItem.strDESITE := String(recDetEle.I04_XPROD);
    recValoresItem.fltTOTPRO := recDetEle.I11_VPROD;

    If blnConsiderarDescontoDesonerado Then
      recValoresItem.fltVICMSDESON := recDetEle.N27A_VICMSDESON;

    recValoresItem.fltVDESC := recDetEle.I17_VDESC;
    recValoresItem.fltVOUTRO := recDetEle.I17A_VOUTRO;
    recValoresItem.fltVSEG := recDetEle.I16_VSEG;
    recValoresItem.fltBASICM := recDetEle.N15_VBC;
    recValoresItem.fltVALICM := recDetEle.N17_VICMS;
    recValoresItem.fltBAS_ST := recDetEle.N21_VBCST;
    recValoresItem.fltVAL_ST := recDetEle.N23_VICMSST;
    recValoresItem.fltBASIPI := recDetEle.O10_VBC;
    recValoresItem.fltVALIPI := recDetEle.O14_VIPI;
    recValoresItem.fltVALFRE := recDetEle.I15_VFRETE;
    recValoresItem.fltALQICM := recDetEle.N16_PICMS;
    recValoresItem.fltALQIPI := recDetEle.O13_PIPI;
    recValoresItem.fltALQ_ST := recDetEle.N22_PICMSST;
    recValoresItem.strB08_NNF:= String(FGerEle.B08_NNF);

    objValidaNFeCapa.pAddValoresItem(recValoresItem, intContador);
    inc(intContador);
  End;
end;

function TNFeXml.fCarregaCadIte(strCodIte, strCodEmp, strCodFor, strCodCli: string): TRecItem;
  var
    qryGen: TUniQuery;
    strPerfil: String;
    strTipFor: String;
begin
  qryGen := fCriaQuery();

  strTipFor := '';
  If (FfinalidadeXML in [xmlConsertoEquipamento, xmlGarantiaRecCliente, xmlConsignacaoDevolucaoCliente, xmlRetornoLocacao]) Then
    strPerfil := fGetTipoAbfCliente(strCodCli)
  Else
    strPerfil := fGetTipoAbfFornecedor(strCodFor, strTipFor);

  Try
    Result.strCodIte := '';
    qryGen.SQL.Add('SELECT I.ITE_CODITE,');
    qryGen.SQL.Add('       I.ITE_DESITE,');

    If fCfgSis('TABPRF', varBoolean) Then
    Begin
      qryGen.SQL.Add('  IF(IFNULL(F.ITE_CODFAB, "") = "", I.ITE_CODFAB, F.ITE_CODFAB) AS ITE_CODFAB, ');
    End Else
    Begin
      qryGen.SQL.Add('  IF(IFNULL(F.ITE_CODITF, "") = "", I.ITE_CODFAB, F.ITE_CODITF) AS ITE_CODFAB, ');
    End;
    qryGen.SQL.Add('       I.ITE_CLAIPI,');
    qryGen.SQL.Add('       ABF_CODABF,');
    qryGen.SQL.Add('       ABF_DESABF,');
    qryGen.SQL.Add('       ABF_ALQFCP'+strPerfil+' AS ABF_ALQFCP,');
    qryGen.SQL.Add('       I.ITE_REFERE,');

    If fCfgSis('TPABPC') = '1' Then
    Begin
      qryGen.SQL.Add('     I.ITE_ABFPIS,');
      qryGen.SQL.Add('     I.ITE_ABFCOF,');
    end
    Else
    begin
      qryGen.SQL.Add('     G.ITE_ABFPIS,');
      qryGen.SQL.Add('     G.ITE_ABFCOF,');
    End;
    qryGen.SQL.Add('       ITE_CODUNI');

    qryGen.SQL.Add('  FROM CADITE I ');

    qryGen.SQL.Add(' INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE AND ');
    qryGen.SQL.Add('                        G.ITE_CODEMP = ' + QuotedStr(strCodEmp));
    qryGen.SQL.Add('  LEFT JOIN ITEFOR F ON F.ITE_CODITE = I.ITE_CODITE AND ');
    qryGen.SQL.Add('                        F.ITE_CODFOR = ' + QuotedStr(strCodFor));

    If fCfgSis('TABPRF', varBoolean) Then
    Begin
      qryGen.SQL.Add('  AND (SELECT COUNT(*) FROM TABPRE      ');
      qryGen.SQL.Add('        WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S" ) > 0 ');
    End Else
    Begin
      qryGen.SQL.Add('  AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF  ');
      qryGen.SQL.Add('                       WHERE FF.ITE_CODITE = I.ITE_CODITE AND   ');
      qryGen.SQL.Add('                             FF.ITE_CODFOR = ' + QuotedStr(strCodFor)+ ')');
    End;

    If strTipAbfCfg = '1' Then
      qryGen.SQL.Add(' LEFT JOIN ABFICM A ON A.ABF_CODABF = I.ITE_CODABF AND ')
    Else
      qryGen.SQL.Add(' LEFT JOIN ABFICM A ON A.ABF_CODABF = G.ITE_CODABF AND ');

    qryGen.SQL.Add('                           A.ABF_ESTADO = ' + QuotedStr(fDadosFornec('ESTFOR')));

    qryGen.SQL.Add('  WHERE I.ITE_CODITE =  ' + QuotedStr(strCodIte));

    qryGen.Open;

    If Not qryGen.IsEmpty Then
    Begin
      Result.strCodIte := qryGen.FieldByName('ITE_CODITE').AsString;
      Result.strDesIte := qryGen.FieldByName('ITE_DESITE').AsString;
      Result.strCodFab := qryGen.FieldByName('ITE_CODFAB').AsString;
      Result.strClaIPI := qryGen.FieldByName('ITE_CLAIPI').AsString;
      Result.strCodAbf := qryGen.FieldByName('ABF_CODABF').AsString;
      Result.strDesAbf := qryGen.FieldByName('ABF_CODABF').AsString +' '+ qryGen.FieldByName('ABF_DESABF').AsString;
      Result.strRefere := qryGen.FieldByName('ITE_REFERE').AsString;
      Result.strSigUni := qryGen.FieldByName('ITE_CODUNI').AsString;
      Result.strAbfCof := qryGen.FieldByName('ITE_ABFCOF').AsString;
      Result.strAbfPis := qryGen.FieldByName('ITE_ABFPIS').AsString;
      Result.fltPFCPST := qryGen.FieldByName('ABF_ALQFCP').AsFloat;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
End;

function TNFeXml.fTipoCalculoBaseST(strCodFor: String): TCalculoBaseSubstituicaoXML;
Begin
  If fEmptyStr(strCodFor) Then
    Exit(tcbsIPIComProdutos);

  If fCampoTabela('FOR_BSTXML', 'CADFOR', ['FOR_CODFOR'], [strCodFor]) = 1 Then
    Result := tcbsProdutosSemIPI
  Else
    Result := tcbsIPIComProdutos;
End;

procedure TNFeXml.pGravaCriticas(cdsCriticas: TZClient = nil; strOperadorLiberacao: String = ''; horLiberacao: TTime = 0);
const campos  = '(CRI_SEQDET, CRI_SEQGER, CRI_OPELIB, CRI_DTALIB, CRI_HORLIB, CRI_FORNEC, CRI_NUMDOC, CRI_ELETRO, CRI_SIGUNI, ' +
                ' CRI_CODABF, CRI_CLAFIS, CRI_CODSIT, CRI_BASICM, CRI_ALQICM, CRI_VALICM, CRI_BASSUB, CRI_VALSUB, CRI_BASIPI, ' +
                ' CRI_FATMVA, CRI_ALQIPI, CRI_VALIPI, CRI_DIF_BASICM, CRI_DIF_ALQICM, CRI_DIF_VALICM , CRI_DIF_BASIPI, CRI_DIF_ALQIPI, CRI_DIF_VALIPI, ' +
                ' CRI_DIF_BASSUB, CRI_DIF_FATMVA, CRI_DIF_VALSUB, CRI_DIF_CODSIT, CRI_PERFOR, CRI_ABFPIS, CRI_PISCST, CRI_PISVBC, ' +
                ' CRI_PISPPIS, CRI_PISVPIS, CRI_ABFCOF, CRI_COFCST, CRI_COFVBC, CRI_COFPCOFINS, CRI_COFVCOFINS, CRI_DIF_PISCST, CRI_DIF_PISVBC, ' +
                ' CRI_DIF_PISPPIS, CRI_DIF_PISVPIS, CRI_DIF_COFCST , CRI_DIF_COFVBC , CRI_DIF_COFPCOFINS, CRI_DIF_COFVCOFINS, '+
                ' CRI_VBCFCPST, CRI_PFCPST, CRI_VFCPST, CRI_DIF_PFCPST, CRI_DIF_VFCPST )';
      parametros = '(:SEQDET, :SEQGER, :OPELIB, :DTALIB, :HORLIB, :FORNEC, :NUMDOC, :ELETRO, :SIGUNI, :CODABF, :CLAFIS, :CODSIT, :BASICM, '+
                  ' :ALQICM, :VALICM, :BASSUB, :VALSUB, :BASIPI, :FATMVA, :ALQIPI, :VALIPI, :DIF_BASICM, :DIF_ALQICM, :DIF_VALICM , '+
                  ' :DIF_BASIPI, :DIF_ALQIPI, :DIF_VALIPI, :DIF_BASSUB, :DIF_FATMVA, :DIF_VALSUB, :DIF_CODSIT, :PERFOR, :ABFPIS, '+
                  ' :PISCST, :PISVBC, :PISPPIS, :PISVPIS, :ABFCOF, :COFCST, :COFVBC, :COFPCOFINS, :COFVCOFINS, :DIF_PISCST, :DIF_PISVBC, '+
                  ' :DIF_PISPPIS, :DIF_PISVPIS, :DIF_COFCST , :DIF_COFVBC , :DIF_COFPCOFINS, :DIF_COFVCOFINS, '+
                  ' :VBCFCPST, :PFCPST, :VFCPST, :DIF_PFCPST, :DIF_VFCPST )';
begin
  If strOperadorLiberacao = '' Then
    Exit;

  qryCritica.SQL.Clear;


  qryCritica.SQL.Add('INSERT INTO ELECRI ' + campos + ' VALUES ' + parametros);

  while not cdsCriticas.Eof Do
  Begin
    If FSeqGer = '' Then
    Begin
      cdsCriticas.Next;
      Continue;
    End;


    qryCritica.ParamByName('SEQDET').Value := cdsCriticas.FieldByName('AUTINC').Value;
    qryCritica.ParamByName('SEQGER').Value := FSeqGer;
    qryCritica.ParamByName('OPELIB').Value := strOperadorLiberacao;
    qryCritica.ParamByName('DTALIB').Value := fNow;
    qryCritica.ParamByName('HORLIB').AsDateTime := horLiberacao;
    if (fEmptyStr(cdsCriticas.FieldByName('FORNEC').AsString)) Or
       (cdsCriticas.FieldByName('FORNEC').AsString = '-  -') Then
      qryCritica.ParamByName('FORNEC').Value := Null
    Else
      qryCritica.ParamByName('FORNEC').Value := cdsCriticas.FieldByName('FORNEC').Value;
    qryCritica.ParamByName('NUMDOC').Value := cdsCriticas.FieldByName('NUMDOC').Value;
    qryCritica.ParamByName('ELETRO').Value := cdsCriticas.FieldByName('ELETRO').Value;
    qryCritica.ParamByName('SIGUNI').Value := cdsCriticas.FieldByName('SIGUNI').Value;
    qryCritica.ParamByName('CODABF').Value := cdsCriticas.FieldByName('CODABF').Value;
    qryCritica.ParamByName('CLAFIS').Value := cdsCriticas.FieldByName('CLAFIS').Value;
    qryCritica.ParamByName('CODSIT').Value := cdsCriticas.FieldByName('CODSIT').Value;
    qryCritica.ParamByName('BASICM').Value := cdsCriticas.FieldByName('BASICM').Value;
    qryCritica.ParamByName('ALQICM').Value := cdsCriticas.FieldByName('ALQICM').Value;
    qryCritica.ParamByName('VALICM').Value := cdsCriticas.FieldByName('VALICM').Value;
    qryCritica.ParamByName('BASSUB').Value := cdsCriticas.FieldByName('BASSUB').Value;
    qryCritica.ParamByName('VALSUB').Value := cdsCriticas.FieldByName('VALSUB').Value;
    qryCritica.ParamByName('BASIPI').Value := cdsCriticas.FieldByName('BASIPI').Value;
    qryCritica.ParamByName('FATMVA').Value := cdsCriticas.FieldByName('FATMVA').Value;
    qryCritica.ParamByName('ALQIPI').Value := cdsCriticas.FieldByName('ALQIPI').Value;
    qryCritica.ParamByName('VALIPI').Value := cdsCriticas.FieldByName('VALIPI').Value;
    qryCritica.ParamByName('DIF_BASICM').Value := cdsCriticas.FieldByName('DIF_BASICM').Value;
    qryCritica.ParamByName('DIF_ALQICM').Value := cdsCriticas.FieldByName('DIF_ALQICM').Value;
    qryCritica.ParamByName('DIF_VALICM').Value := cdsCriticas.FieldByName('DIF_VALICM').Value;
    qryCritica.ParamByName('DIF_BASIPI').Value := cdsCriticas.FieldByName('DIF_BASIPI').Value;
    qryCritica.ParamByName('DIF_ALQIPI').Value := cdsCriticas.FieldByName('DIF_ALQIPI').Value;
    qryCritica.ParamByName('DIF_VALIPI').Value := cdsCriticas.FieldByName('DIF_VALIPI').Value;
    qryCritica.ParamByName('DIF_BASSUB').Value := cdsCriticas.FieldByName('DIF_BASSUB').Value;
    qryCritica.ParamByName('DIF_FATMVA').Value := cdsCriticas.FieldByName('DIF_FATMVA').Value;
    qryCritica.ParamByName('DIF_VALSUB').Value := cdsCriticas.FieldByName('DIF_VALSUB').Value;
    qryCritica.ParamByName('DIF_CODSIT').Value := cdsCriticas.FieldByName('DIF_CODSIT').Value;
    qryCritica.ParamByName('PERFOR').Value := cdsCriticas.FieldByName('PERFOR').Value;
    qryCritica.ParamByName('ABFPIS').Value := cdsCriticas.FieldByName('ABFPIS').Value;
    qryCritica.ParamByName('PISCST').Value := cdsCriticas.FieldByName('PISCST').Value;
    qryCritica.ParamByName('PISVBC').Value := cdsCriticas.FieldByName('PISVBC').Value;
    qryCritica.ParamByName('PISPPIS').Value := cdsCriticas.FieldByName('PISPPIS').Value;
    qryCritica.ParamByName('PISVPIS').Value := cdsCriticas.FieldByName('PISVPIS').Value;
    qryCritica.ParamByName('ABFCOF').Value := cdsCriticas.FieldByName('ABFCOF').Value;
    qryCritica.ParamByName('COFCST').Value := cdsCriticas.FieldByName('COFCST').Value;
    qryCritica.ParamByName('COFVBC').Value := cdsCriticas.FieldByName('COFVBC').Value;
    qryCritica.ParamByName('COFPCOFINS').Value := cdsCriticas.FieldByName('COFPCOFINS').Value;
    qryCritica.ParamByName('COFVCOFINS').Value := cdsCriticas.FieldByName('COFVCOFINS').Value;
    qryCritica.ParamByName('DIF_PISCST').Value := cdsCriticas.FieldByName('DIF_PISCST').Value;
    qryCritica.ParamByName('DIF_PISVBC').Value := cdsCriticas.FieldByName('DIF_PISVBC').Value;
    qryCritica.ParamByName('DIF_PISPPIS').Value := cdsCriticas.FieldByName('DIF_PISPPIS').Value;
    qryCritica.ParamByName('DIF_PISVPIS').Value := cdsCriticas.FieldByName('DIF_PISVPIS').Value;
    qryCritica.ParamByName('DIF_COFCST').Value := cdsCriticas.FieldByName('DIF_COFCST').Value;
    qryCritica.ParamByName('DIF_COFVBC').Value := cdsCriticas.FieldByName('DIF_COFVBC').Value;
    qryCritica.ParamByName('DIF_COFPCOFINS').Value := cdsCriticas.FieldByName('DIF_COFPCOFINS').Value;
    qryCritica.ParamByName('DIF_COFVCOFINS').Value := cdsCriticas.FieldByName('DIF_COFVCOFINS').Value;
    qryCritica.ParamByName('VBCFCPST').Value := cdsCriticas.FieldByName('VBCFCPST').Value;
    qryCritica.ParamByName('PFCPST').Value := cdsCriticas.FieldByName('PFCPST').Value;
    qryCritica.ParamByName('VFCPST').Value := cdsCriticas.FieldByName('VFCPST').Value;
    qryCritica.ParamByName('DIF_PFCPST').Value := cdsCriticas.FieldByName('DIF_PFCPST').Value;
    qryCritica.ParamByName('DIF_VFCPST').Value := cdsCriticas.FieldByName('DIF_VFCPST').Value;
    qryCritica.ExecSQL;

    cdsCriticas.Next;
  End;


end;


procedure TNFeXml.pGravaNFEB2W;
begin

  qrySQL.SQL.Clear;
  qrySQL.SQL.Add('SELECT B2W_SEQGER, B2W_ARQUIV, B2W_ARQNAM  FROM NFEB2W WHERE FALSE');
  qrySQL.Open;
  qrySQL.Insert;
  qrySQL.FieldByName('B2W_ARQNAM').AsString := FNomArq;
  qrySQL.FieldByName('B2W_SEQGER').AsString := FSeqGer;
  (qrySQL.FieldByName('B2W_ARQUIV') as TBlobField).LoadFromFile(FPatArq + FNomArq);
  qrySQL.Post;
end;

{ TRecGerEle }

procedure TRecGerEle.pGeraDados(var Lista: TStringList);
var
  rtype: TRTTIType;
  fields: TArray<TRttiField>;
  i: Integer;
  RecGerEle_Bco : TRecGerEle_Bco;
begin
  RecGerEle_Bco.strAutInc        := String(Self.strAutInc);
  RecGerEle_Bco.GER_CODFOR       := String(Self.GER_CODFOR);
  RecGerEle_Bco.GER_CODCLI       := String(Self.GER_CODCLI);
  RecGerEle_Bco.GER_TIP_FC       := String(Self.GER_TIP_FC);
  RecGerEle_Bco.GER_TIPXML       := Self.GER_TIPXML;
  RecGerEle_Bco.GER_CODEMP       := String(Self.GER_CODEMP);
  RecGerEle_Bco.GER_CONPAG       := String(Self.GER_CONPAG);
  RecGerEle_Bco.B02_CUF          := String(Self.B02_CUF);
  RecGerEle_Bco.B03_CNF          := String(Self.B03_CNF);
  RecGerEle_Bco.B04_NATOP        := String(Self.B04_NATOP);
  RecGerEle_Bco.B05_INDPAG       := String(Self.B05_INDPAG);
  RecGerEle_Bco.B06_MOD          := String(Self.B06_MOD);
  RecGerEle_Bco.B07_SERIE        := String(Self.B07_SERIE);
  RecGerEle_Bco.B08_NNF          := String(Self.B08_NNF);
  RecGerEle_Bco.B09_DEMI         := Self.B09_DEMI;
  RecGerEle_Bco.B10_DSAIENT      := Self.B10_DSAIENT;
  RecGerEle_Bco.B11_TPNF         := String(Self.B11_TPNF);
  RecGerEle_Bco.B11A_IDDEST      := Self.B11A_IDDEST;
  RecGerEle_Bco.B12_CMUNFG       := String(Self.B12_CMUNFG);
  RecGerEle_Bco.B21_TPIMP        := String(Self.B21_TPIMP);
  RecGerEle_Bco.B22_TPEMIS       := String(Self.B22_TPEMIS);
  RecGerEle_Bco.B24_TPAMB        := String(Self.B24_TPAMB);
  RecGerEle_Bco.B25_FINNFE       := String(Self.B25_FINNFE);
  RecGerEle_Bco.NFeAjuste        := Self.NFeAjuste;
  RecGerEle_Bco.B25B_INDPRES     := Self.B25B_INDPRES;
  RecGerEle_Bco.B25B_INDFINAL    := Self.B25B_INDFINAL;
  RecGerEle_Bco.B26_PROCEMI      := String(Self.B26_PROCEMI);
  RecGerEle_Bco.C02_CNPJ         := String(Self.C02_CNPJ);
  RecGerEle_Bco.C02A_CPF         := String(Self.C02A_CPF);
  RecGerEle_Bco.C03_XNOME        := String(Self.C03_XNOME);
  RecGerEle_Bco.C04_XFANT        := String(Self.C04_XFANT);
  RecGerEle_Bco.C03_XLGR         := String(Self.C03_XLGR);
  RecGerEle_Bco.C07_NRO          := String(Self.C07_NRO);
  RecGerEle_Bco.C08_XCPL         := String(Self.C08_XCPL);
  RecGerEle_Bco.C09_XBAIRRO      := String(Self.C09_XBAIRRO);
  RecGerEle_Bco.C10_CMUN         := String(Self.C10_CMUN);
  RecGerEle_Bco.C11_XMUN         := String(Self.C11_XMUN);
  RecGerEle_Bco.C12_UF           := String(Self.C12_UF);
  RecGerEle_Bco.C13_CEP          := String(Self.C13_CEP);
  RecGerEle_Bco.C14_CPAIS        := String(Self.C14_CPAIS);
  RecGerEle_Bco.C15_XPAIS        := String(Self.C15_XPAIS);
  RecGerEle_Bco.C16_FONE         := String(Self.C16_FONE);
  RecGerEle_Bco.C17_IE           := String(Self.C17_IE);
  RecGerEle_Bco.C18_IEST         := String(Self.C18_IEST);
  RecGerEle_Bco.C19_IM           := String(Self.C19_IM);
  RecGerEle_Bco.C20_CNAE         := String(Self.C20_CNAE);
  RecGerEle_Bco.E02_CNPJ         := String(Self.E02_CNPJ);
  RecGerEle_Bco.E17_IE           := String(Self.E17_IE);
  RecGerEle_Bco.E03_XNOME        := String(Self.E03_XNOME);
  RecGerEle_Bco.E03_XLGR         := String(Self.E03_XLGR);
  RecGerEle_Bco.E07_NRO          := String(Self.E07_NRO);
  RecGerEle_Bco.E09_XBAIRRO      := String(Self.E09_XBAIRRO);
  RecGerEle_Bco.E10_CMUN         := String(Self.E10_CMUN);
  RecGerEle_Bco.E10_UF           := String(Self.E10_UF);
  RecGerEle_Bco.E13_CEP          := String(Self.E13_CEP);
  RecGerEle_Bco.E16_FONE         := String(Self.E16_FONE);
  RecGerEle_Bco.W03_VBC          := Self.W03_VBC;
  RecGerEle_Bco.W04_VICMS        := Self.W04_VICMS;
  RecGerEle_Bco.W04A_VICMSDESON  := Self.W04A_VICMSDESON;
  RecGerEle_Bco.W04H_VFCP        := Self.W04H_VFCP;
  RecGerEle_Bco.W05_VBCST        := Self.W05_VBCST;
  RecGerEle_Bco.W06_VST          := Self.W06_VST;
  RecGerEle_Bco.W06A_VFCPST      := Self.W06A_VFCPST;
  RecGerEle_Bco.W07_VPROD        := Self.W07_VPROD;
  RecGerEle_Bco.W08_VFRETE       := Self.W08_VFRETE;
  RecGerEle_Bco.W09_VSEG         := Self.W09_VSEG;
  RecGerEle_Bco.W10_VDESC        := Self.W10_VDESC;
  RecGerEle_Bco.W11_VII          := Self.W11_VII;
  RecGerEle_Bco.W12_VIPI         := Self.W12_VIPI;
  RecGerEle_Bco.W12A_VIPIDEVOL   := Self.W12A_VIPIDEVOL;
  RecGerEle_Bco.W13_VPIS         := Self.W13_VPIS;
  RecGerEle_Bco.W14_VCOFINS      := Self.W14_VCOFINS;
  RecGerEle_Bco.W15_VOUTRO       := Self.W15_VOUTRO;
  RecGerEle_Bco.W16_VNF          := Self.W16_VNF;
  RecGerEle_Bco.W15_VSERV        := Self.W15_VSERV;

  RecGerEle_Bco.W18_VSERV        := Self.W18_VSERV;
  RecGerEle_Bco.W19_VBC          := Self.W19_VBC;
  RecGerEle_Bco.W20_VISS         := Self.W20_VISS;
  RecGerEle_Bco.W21_VPIS         := Self.W21_VPIS;
  RecGerEle_Bco.W22_VCOFINS      := Self.W22_VCOFINS;
  RecGerEle_Bco.W22A_DCOMPET     := Self.W22A_DCOMPET;
  RecGerEle_Bco.W22B_VDEDUCAO    := Self.W22B_VDEDUCAO;
  RecGerEle_Bco.W22D_VDESCINCOND := Self.W22D_VDESCINCOND;

  RecGerEle_Bco.W24_VRETPIS      := Self.W24_VRETPIS;
  RecGerEle_Bco.W25_VRETCOFINS   := Self.W25_VRETCOFINS;
  RecGerEle_Bco.W26_VRETCSLL     := Self.W26_VRETCSLL;
  RecGerEle_Bco.W27_VBCIRRF      := Self.W27_VBCIRRF;
  RecGerEle_Bco.W28_VIRRF        := Self.W28_VIRRF;
  RecGerEle_Bco.W29_VBCRETPREV   := Self.W29_VBCRETPREV;
  RecGerEle_Bco.W30_VRETPREV     := Self.W30_VRETPREV;
  RecGerEle_Bco.W31_VICMSUFDEST  := Self.W31_VICMSUFDEST;

  RecGerEle_Bco.X27_QVOL         := Self.X27_QVOL;
  RecGerEle_Bco.X28_ESP          := Self.X28_ESP;
  RecGerEle_Bco.X31_PESOL        := Self.X31_PESOL;
  RecGerEle_Bco.X32_PESOB        := Self.X32_PESOB;
  RecGerEle_Bco.X33_MODFRETE     := Self.X33_MODFRETE;
  RecGerEle_Bco.X34_CNPJ         := Self.X34_CNPJ;
  RecGerEle_Bco.X35_MARCA        := Self.X35_MARCA;
  RecGerEle_Bco.PR07_CHNFE       := Self.PR07_CHNFE;
  RecGerEle_Bco.PR08_STATUS      := Self.PR08_STATUS;
  RecGerEle_Bco.PR09_MOTIVO      := Self.PR09_MOTIVO;
  RecGerEle_Bco.Z03_infCpl       := Self.Z03_infCpl;
  RecGerEle_Bco.Z02_infAdFisco   := Self.Z02_infAdFisco;
  RecGerEle_Bco.vlrTotDupl       := Self.vlrTotDupl;
  RecGerEle_Bco.strMatRev        := Self.strMatRev;

  rtype := TRTTIContext.Create.GetType(TypeInfo(TRecGerEle_Bco));
  Lista.Add(rtype.ToString);
  fields := rtype.GetFields;
  for i := 0 to High(fields) do
    Lista.Add(Format('%s: %s : %s', [
      fields[i].Name,
      fields[i].FieldType.ToString,
      fields[i].GetValue(@RecGerEle_Bco).ToString]));

end;


end.



