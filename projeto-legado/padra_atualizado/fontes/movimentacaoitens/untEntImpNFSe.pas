unit untEntImpNFSe;

interface

uses  StrUtils, SysUtils, Uni, Db, Classes, Forms, UniClientDataSet, Math,
      untFuncoesSimples, StdCtrls, untZClient, Variants, untTypesSistema,
      untEntOutrasDespesas, untParCalculaPrecoCusto, cxProgressBar,untPesqAux,
      untEntIcmsAntecipado, Windows, XMLDoc, XMLIntf, ComCtrls,
      Generics.Collections, untPortadorFornecedor, Rtti, TypInfo,
      untGravando, untTypePesCte,
      untCadLivroFiscal,
      untNFSe,
      untLayXns,
      untLayDns,
      untEditorLayoutNFSe,
      DateUtils,
      untLancamentoRetencoes;

Type

  IImpNFSe = interface
    ['{F8EED523-C041-46A8-A059-EDC51CB0CA68}']
    function fAutIncCadFis(strAutIncCadFis: String): IImpNFSe;
    function fCodEmp(strCodEmp: String): IImpNFSe;
    function fImportado: Boolean;
    function fNFSe(objNFSe: INFSe): IImpNFSe;
    function fExecute: IImpNFSe;
  End;

  TImpNFSe = class(TInterfacedObject, IImpNFSe)
  private
    FobjNFSe: INFSe;
    FblnImportado: Boolean;
    FqryGeneric: TUniQuery;
    FstrAutIncCadFis: String;
    FstrCodEmp: String;
    function fGetSQL: String;
  public
    function fAutIncCadFis(strAutIncCadFis: String): IImpNFSe;
    function fCodEmp(strCodEmp: String): IImpNFSe;
    function fImportado: Boolean;
    function fNFSe(objNFSe: INFSe): IImpNFSe;
    function fExecute: IImpNFSe;

    class function New: IImpNFSe;
    destructor Destroy; override;
    constructor Create;

  End;


  TEntImpNFSe = Class(TComponent)
  Private
    FblnVisualizarEditor: Boolean;
    stlArquivo: TStringList;
    blnUSACND : Boolean;
    blnUtilizaContabilidade : Boolean;

    blnCtpBol: Boolean;
    blnImportaPeloBancoDados: Boolean;

    FAtulizarTabela: Boolean;

    FNotEnt: TUniQuery;
    cdsNotasFiscais: TZClient;

    FConsulta: TUniQuery;
    FEmpresas: TUniQuery;
    FCodigo,
    FAutInc,
    FCgcFor,
    FCGCDes,
    FForPag,
    FTomSer: String;
    FCreditaICMS: Boolean;
    FstrCndVaz: String;
    FstrPath: String;
    FNumDoc: String;    // Numero do Documento
    FTipoServico: String; // Tipo de Serviço
    FSerie_: String;    // Serie
    FEspDoc: String;    // Especie

    FVeioNF : String; // Veio NF
    FstrArquivoXML: String;
    FUsaChq : String; // Usa Cheque
    FPrevis : String; // Previsão
    FPagAnt : String; // Pagamento antecipado
    FUsoCon : String; // Uso e Consumo
    FTipDoc : String; // Tipo do documento
    FGuiTri : String; // Guia do Tributo
    FTipTri : String; // Tipo do Tributo

    FDeposi : String; // Deposito (S/N)
    FTRANSF: String;   // Transferencia (S/N)
    FBcoFor : String; // Conta Banco
    FBrinde : String; // Deposito (S/N)

    FModelo: String;    // Modelo Fical

    FModFre: String;    // Modalidade
    FCodFor: String;    // Forncedor
    FDescricaoServico: String;
    FNomFor: String;
    FCodMunicipioInicio: String;
    FMunicipioDescricaoInicio: String;
    FCodMunicipioFim: String;
    FMunicipioDescricaoFim: String;
    //FC_G_C_: String;    // CNPJ-CPF
    FDuplic: String;
    FLinDig: String;
    FCodBar: String;
    FEstFor: String;    // Estado da Transportadora;
    FHis001: String;    // Histórico
    FCndPag: String;    // Condição de Pagamento
    FstrCodCta: String;    // Plano de Contas a Pagar
    FCtaRec: String;    // Plano de Contas a Receber
    FstrCodEve: String;    // Evento
    FCompet: String;    // Competencia
    FCndXML: String;    // Condição de Pag encontrada no XML S/N
    FValDoc: Currency;
    FValTot: Currency;
    FBasISS: Currency;
    FAliISS: Currency;
    FValISS: Currency;

    FReIRRF: Currency;
    FRetPIS: Currency;
    FRetCOF: Currency;
    FReCSLL: Currency;
    FRETISS: Currency;
    FReINSS: Currency;
    FRiNSSP: Currency;
    FRetTot: Currency;
    FPisCofDefXML: Boolean; // Retencao PIS/COFINS definida pelo XML (Padrao Nacional)
    FValorPIS: Currency;      // PIS do XML nao retido = apuracao propria (Padrao Nacional)
    FValorCofins: Currency;      // COFINS do XML nao retido = apuracao propria (Padrao Nacional)
    FHisRet: String;    // Historico Retido
    FblnGravarPagamentoRetido: Boolean;

    FdtaDtaEnt: TDateTime; // Data de Entrada
    FDtaDoc: TDateTime; // Data de Documento
    FDtaCan: TDateTime; // Data de Cancelamento
    FVlServ: Currency;
    FVlLiqXML: Currency; // Valor liquido informado no XML, antes de trocar pelo valor dos servicos
    FClaFi1: String;    // Classificação Fiscal 1
    FClaFiXML: String;    // Classificação Fiscal 1
    FValCo1: Currency;    // Valor Contábil 1
    FBasIc1: Currency;    // Base de ICMS 1
    FAlqIc1: Double;    // Aliquota de ICMS 1
    FValIc1: Double;    // Valor de ICMS 1
    FValOu1: Double;    // Valor de Outras 1
    FValIs1: Double;    // Valor de Isento 1
    FValRe1: Double;    // Valor de Retido 1

    FClaFi2: String;    // Classificação Fiscal 2
    FValCo2: Double;    // Valor Contábil 2
    FBasIc2: Double;    // Base de ICMS 2
    FAlqIc2: Double;    // Aliquota de ICMS 2
    FValIc2: Double;    // Valor de ICMS 2
    FValOu2: Double;    // Valor de Outras 2
    FValIs2: Double;    // Valor de Isento 2
    FValRe2: Double;    // Valor de Retido 2
    FBasIp2: Double;    // Base de IPI 2
    FValIp2: Double;    // Valor de IPI 2
    FBasSu2: Double;    // Base de Substituição 2
    FDesAc2: Double;    // Valor de Despesa Acessária 2

    FClaFi3: String;    // Classificação Fiscal 3
    FValCo3: Double;    // Valor Contábil 3
    FBasIc3: Double;    // Base de ICMS 3
    FAlqIc3: Double;    // Aliquota de ICMS 3
    FValIc3: Double;    // Valor de ICMS 3
    FValOu3: Double;    // Valor de Outras 3
    FValIs3: Double;    // Valor de Isento 3
    FValRe3: Double;    // Valor de Retido 3
    FBasIp3: Double;    // Base de IPI 3
    FValIp3: Double;    // Valor de IPI 3
    FBasSu3: Double;    // Base de Substituição 3
    FDesAc3: Double;    // Valor de Despesa Acessária 3

    FClaFi4: String;    // Classificação Fiscal 4
    FValCo4: Double;    // Valor Contábil 4
    FBasIc4: Double;    // Base de ICMS 4
    FAlqIc4: Double;    // Aliquota de ICMS 4
    FValIc4: Double;    // Valor de ICMS 4
    FValOu4: Double;    // Valor de Outras 4
    FValIs4: Double;    // Valor de Isento 4
    FValRe4: Double;    // Valor de Retido 4
    FBasIp4: Double;    // Base de IPI 4
    FValIp4: Double;    // Valor de IPI 4
    FBasSu4: Double;    // Base de Substituição 4
    FDesAc4: Double;    // Valor de Despesa Acessária 4

    FPesoBruto: Double;  //Peso Bruto

    FClaFi5: String;    // Classificação Fiscal 5
    FValCo5: Double;    // Valor Contábil 5
    FBasIc5: Double;    // Base de ICMS 5
    FAlqIc5: Double;    // Aliquota de ICMS 5
    FValIc5: Double;    // Valor de ICMS 5
    FValOu5: Double;    // Valor de Outras 5
    FValIs5: Double;    // Valor de Isento 5
    FValRe5: Double;    // Valor de Retido 5
    FBasIp5: Double;    // Base de IPI 5
    FValIp5: Double;    // Valor de IPI 5
    FBasSu5: Double;    // Base de Substituição 5
    FDesAc5: Double;    // Valor de Despesa Acessária 5
    FblnGraCTP: Boolean;  // Verifica se ira gravar Contas a Pagar

    FstrPorBai: String;    // Portador da Baixa

    FAlqPis,
    FAlqCof,
    FPerBasPis,
    FPerBasCof : Double;

    FCstPis,
    FCstCof,
    FAutPis,
    FAutCof,

    FAcesso : String;
    FCodEmp: string;
    FstrTipoFJ: String;

    FMemLog: TStrings;
    FMemErr: TStrings;

    FImpFre: Boolean;
    FEmpresaPagadora: String;

    cpcParams: TParCalculaPrecoCusto;

    blnATPVMB: array[1..7] of Boolean;
    FLogImportacao : TStringList;

    FListaClaFis: TStringList;

    cdsAbrPis,
    cdsAbrCof: TZClient;

    FPortadorFornecedor : TPortadorFornecedor;

    qryCTes: TUniQuery;

    arrDuplicata: TarrDuplicata;

    FNumDPS: String;
    FSerDPS: String;
    function fGetSqlNotasFiscais: string;

    Function fCarregaAbrevPisCof(blnAtualizarTabela: Boolean = True): Boolean;
    Function fCarregaAbrevPisCofPrg(prgProgresso: TcxProgressBar): Boolean;
    Function fInformarPisCofins: Boolean;

    function fConfirmaImportacao(strNomArq: String; var strErroInt: String; blnRegistroCorrente: Boolean = False): Boolean;


    procedure pEscreveMensagemImportacao(memMsg: TStrings; strMensagem: String; intLinha: Integer = 0);

//    procedure pCarregaTXT(stlFrete : TStringList; memLog, memErr: TStrings);

    Procedure pBeforePost(dataSet: TDataSet);

    function fRetCNPJEmpresa(strCodEmp: String): String;
    function fVerificaTemCadPag(strCodEmp, strSequen: String): Boolean;

    function fLocalizarNota: Boolean;
    function fConsultarConta: Boolean;
    procedure pValidarArquivo(strArquivo: String);
    procedure pValidarDados;
    procedure pValidarCampos;
    function fConsultarAbreviacaoPIS: String;
    function fConsultarAbreviacaoCOFINS: String;
    function fGerarHistoricoCTP: String;
    procedure pCriaMovGerMovDet;
    procedure pMontaSQLMovDet(qryComand: TUniQuery; strMovGerAutInc: String);
    procedure pMontaSQLMovGer(qryComand: TUniQuery; strMovGerAutInc: String);
    function fRetAutoIncremNatCfo(AStrNatCfo: String): String;
    function fFormatarTipoServico(ATipoServico: String): String;
    function fCarregarLayDNS(AstrAutoIncrem, AstrSchema: String): String;
    function fCarregarLayXNS(AstrSchema, AstrSchemaMD5: String): String;
    procedure pCalcularRetencoes(ARetencoesNoFrame: TRetencoesNoFrame);
    procedure pAvisarValorLiquidoXML;
    procedure pAvisarRetencaoSemCadastro(ARetencoesNoFrame: TRetencoesNoFrame; AintTipo: Integer; AfltValor: Currency; AstrTributo: String);
    function fValorTotalLiquido(ARetencoesNoFrame: TRetencoesNoFrame): Currency;
    procedure pZerarValorComRetencao(ARetencoesNoFrame: TRetencoesNoFrame);
  Public
    blnVeioBoleto: Boolean;
    blnSimPau,
    blnUtiAbr: Boolean;
    tpNFSe  : TTipoFrete;
    FtpDocFrete: TTipoDocFrete;
    blnImpVariosXml: Boolean;


    blnDocumentoPago,
    blnDocumentoCancelado,
    blnArquivoComErro,
    blnErroGravarRegistro,
    blnDocumentoJaExiste,
    blnNfeAnexaNaoIdentificada,
    blnInformarAbreviacaoPISCOF: Boolean;

    fltVlrConNota,
    fltTotTodosFretes,


    fltCfgAlqPis,
    fltCfgAlqCof: Double;

    FComplemento: String;

    strCfgCstPis,
    strCfgCstCof: String;

    blnPerRep: Boolean;

    strEntDoc: String;
    strEntFor: String;
    strEntSer : String;

    blnImprCp: Boolean;
    strCodPor: String;
    objOutDes: TEntOutrasDespesas;

    strCodOpe: String;
    blnAltDup: Boolean;
    blnVarNot: Boolean;  // DIGITACAO DE VARIAS NOTAS PARA O CONHECIMENTO DE FRETES

    cdsRateioProdutos,

    qryTabela: TUniClientDataSet;
    dtsTabela: TDataSource;
    arrDupFre: Array[0..23] Of TArrDigDuplic;
    arrDupTmp: Array[0..23] Of TArrDigDuplic;

    objIteAnt: TIcmsAntecipado;
    FStatus: Integer;

    arrLinDigCodbar: TarrLinDigCodbar;
    FValDocBoleto: Double;
    FDtaDocBoleto: TDateTime;
    FCndPagBoleto: String;
    qryGeneric: TUniQuery;
    strFCEVEN,
    strFCEDEV,
    strFCECOM: String;

    FintindDest: Integer;       // indicador de destino (se precisar)
    FintfinNFSe: Integer;       // finalidade NFSe (se precisar)

    FstrCST: string;            // CST (REF_CODCST)
    FstrcClassTrib: string;     // Classificação Tributária (REF_CLATRI)
    FstrcIndOp: string;         // indicador da operação (se precisar)

    FcurvBC: Currency;          // Base de cálculo (REF_BASCAL)
    FcurvCBS: Currency;         // Valor CBS (REF_CBSVAL)
    FcurvIBSUF: Currency;       // Valor IBS UF (REF_IBSUFV)
    FcurvIBSMun: Currency;      // Valor IBS Mun (REF_IBSMNV)
    FcurvIBSTot: Currency;      // Valor IBS Total (REF_VALIBS)
    FcurvTotNF: Currency;       // Valor Total NF (REF_VALOPE)

    FfloFpCBS: Double;          // Alíquota CBS (REF_CBSALQ)
    FfloFpAliqEfetCBS: Double;  // Alíquota efetiva CBS (REF_CBSALE)
    FdobpIBSUF: Double;        // Alíquota IBS UF (REF_IBSUFA)
    FdobpAliqEfetUF: Double;   // Alíquota efetiva IBS UF (REF_IBSUFE)
    FdobpIBSMun: Double;       // Alíquota IBS Mun (REF_IBSMNA)
    FdobFpAliqEfetMun: Double;  // Alíquota efetiva IBS Mun (REF_IBSMNE)


    function fCarregarEditorLayout(strNomArq: String): Boolean;
    procedure pCarregaArquivoNFSeXML(strNomArq : String);
    procedure pFiltraLog;
    Procedure pCalculaPisCofins(Var fltBasPis,
                                    fltBasCof,
                                    fltAlqPis,
                                    fltAlqCof,
                                    fltTotPis,
                                    fltTotCof: Double);

    function fSimples(strFornecedor: String): Boolean;
    function fVerificaDocumento: Boolean;
    function fCarregaArquivoNFSe(const strArquivo: String): Boolean;
    Function  fDocumentoExiste(strNumDoc, strEspDoc, strSerie, strCodFor: String;
                               Var blnConFre: Boolean; Var fltOutDes: Double): Boolean;

    Procedure pMontaDuplicatasXMl;
    Procedure pSetDupicatas;
    Procedure pSetLinDig;

    Function fCarregaAbreviacaoPisCof(strClaFis: String): Boolean;

    procedure pAtualizaDados;
    function fDefineCndPag(cndDefault: String): string;
    procedure pEnviaDados;

    procedure pSetLinDigCodbar(value: TarrLinDigCodbar);

    procedure pLimpaDadosBoleto;

    procedure pControlaDigDuplicAtual(intOpc: Integer);

    Function fSelecionaAbreviacaoPis: Boolean;
    Function fSelecionaAbreviacaoCofins: Boolean;

    Constructor Create(Owner: TComponent; blnDigNot: Boolean = False); Reintroduce;
    Destructor Destroy; Override;
    Function fCarregaArquivos(strPath, strExtensao: String): Boolean; overload;

    Function fRetEstadoEmpresa(strCodEmp: String): String;
    Function fConfirmaImportacaoNFSe(prgProgresso: TProgressBar): Boolean;

    procedure pMarcaTodosArquivos(blnMarcar: Boolean = True);

    function fFormatCNPJ(strCNPJ: String): string;

    Procedure pReplicaAlqPis;
    Procedure pReplicaAlqCof;
    Function fReplicaAlqPisPrg(prgProgresso: TCxProgressBar): Boolean;
    Function fReplicaAlqCofPrg(prgProgresso: TCxProgressBar): Boolean;

    Function fSelecionaAbreviacaoPisEntrada(strClaFis: String): Boolean;
    Function fSelecionaAbreviacaoCofinsEntrada(strClaFis: String): Boolean;
    Function fVerificaAlqPisCofEntrada(strClaFis: String): Boolean;
    function fGraCTP(blnGraCTP: Boolean): TEntImpNFSe;
    function fPorBai(strPorBai: String): TEntImpNFSe;
    function fCodEve(strCodEve: String): TEntImpNFSe;
    function fCodCta(strCodCta: String): TEntImpNFSe;
    function fCndVaz(strCndVaz: String): TEntImpNFSe;
    function fDtaEnt(strDtaEnt: TDate): TEntImpNFSe;
    function fVisualizarEditor(blnVisualizarEditor: Boolean): TEntImpNFSe;
  Published
    Function fXmlToBanco(prgProgresso: TProgressBar): Boolean;


  End;

Const
  arrCampos: Array[0..166] Of String = ('NUMDOC', 'SERIE_', 'ESPDOC', 'CodFor', 'CNDPAG', 'CODCTA', 'VALDOC', 'DTAENT', 'DTADOC',
                                       'CLAFI1', 'CLAFIXML', 'VALCO1', 'BASIC1', 'ALQIC1', 'VALIC1', 'VALOU1', 'VALIS1', 'VALRE1', 'BASIP1',
                                       'VALIP1', 'BASSU1', 'DESAC1', 'CLAFI2', 'VALCO2', 'BASIC2', 'ALQIC2', 'VALIC2', 'VALOU2',
                                       'VALIS2', 'VALRE2', 'BASIP2', 'VALIP2', 'BASSU2', 'DESAC2', 'CLAFI3', 'VALCO3', 'BASIC3',
                                       'ALQIC3', 'VALIC3', 'VALOU3', 'VALIS3', 'VALRE3', 'BASIP3', 'VALIP3', 'BASSU3', 'DESAC3',
                                       'CLAFI4', 'VALCO4', 'BASIC4', 'ALQIC4', 'VALIC4', 'VALOU4', 'VALIS4', 'VALRE4', 'BASIP4',
                                       'VALIP4', 'BASSU4', 'DESAC4', 'CLAFI5', 'VALCO5', 'BASIC5', 'ALQIC5', 'VALIC5', 'VALOU5',
                                       'VALIS5', 'VALRE5', 'BASIP5', 'VALIP5', 'BASSU5', 'DESAC5', 'HIS001', 'MODFRE',
 {CAMPOS REFERENTES A ANTEC. ICMS ==>}  'AntIc1', 'BasAn1', 'AntIc2', 'BasAn2', 'AntIc3', 'BasAn3', 'AntIc4', 'BasAn4', 'AntIc5', 'BasAn5',
                                        'CODEVE',
 {CAMPOS REFERENTES AO CONTR. IMPORT}   'IMPORT', 'NOMARQ', 'STATUS', 'LOGIMP', 'NOMFOR', 'ACESSO', 'CGCFOR', 'DUPLIC', 'CODEMP',
 {VErifica se Gera CTP              }   'GRACTP',
 {alíquota de PIS}                      'ALQPIS',
 {%Base PIS}                            'BASPIS',
 {alíquota de COFINS}                   'ALQCOF',
 {%Base COFINS}                         'BASCOF',
                                        'AUTPIS',
                                        'AUTCOF',
 {Veio Boleeto}                         'VEIOBO',
                                        'CSTPIS',
                                        'CSTCOF',
                                        'CGCREM',
                                        'CGCDES',
                                        'TOMSER',
                                        'FORPAG',
                                        'CTAREC',
                                        'EMPPAG',
                                        'CODBAR',
                                        'LINDIG',
   {Credita ICMS}                       'CREICM',
                                        'MODELO',
                                        'COMPET',
                                        'CNDXML',
                                        'TIPCTE',
                                        'VEIONF', // Veio NF
                                        'USACHQ', // Usa Cheque
                                        'PREVIS', // Previsão
                                        'PAGANT', // Pagamento antecipado
                                        'USOCON', // Uso e Consumo
                                        'TIPDOC', // Tipo do Documento
                                        'Q_GUIA', // Guia do Tributo
                                        'CODREC', // Tipo do Tributo
                                        'DEPOSI', // Deposito
                                        'TRANSF', // Transferencia
                                        'BRINDE', //Brinde
                                        'PESBRU', // Peso Bruto

                                        'COMPLE',
                                        'ARQUIV',
                                        'BCOFOR', // Conta Banco
                                        'DTACAN',
                                        'AUTINC',
                                        'BASISS',
                                        'ALIISS',
                                        'VALISS',
                                        'CODIGO',
                                        'DESSRV',
                                        'TIPSRV',
                                        'CODCST',
                                        'CLATRI',
                                        'BASCAL',
                                        'CBSALQ',
                                        'CBSALE',
                                        'CBSVAL',
                                        'IBSUFA',
                                        'IBSUFE',
                                        'IBSUFV',
                                        'IBSMNA',
                                        'IBSMNE',
                                        'IBSMNV',
                                        'VALIBS',
                                        'VALOPE',
                                        'REIRRF',
                                        'RETPIS',
                                        'RETCOF',
                                        'RECSLL',
                                        'RETISS',
                                        'REINSS',
                                        'RINSSP',
                                        'RETTOT',
                                        'VLSERV',
                                        'NUMDPS',
                                        'SERDPS',
                                        'PCXMLD',
                                        'VALPIS',
                                        'VALCOF',
                                        'VLLIQX'
                                        );


  arrDataTypes: Array[0..166] Of TFieldType = (ftString, ftString, ftString, ftString, ftString, ftString, ftFloat, ftDate ,
                                              ftDate  , ftString, ftString, ftFloat , ftFloat , ftFloat , ftFloat , ftFloat, ftFloat,
                                              ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftString, ftFloat, ftFloat,
                                              ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftFloat, ftFloat,
                                              ftFloat , ftString, ftFloat , ftFloat , ftFloat , ftFloat , ftFloat, ftFloat,
                                              ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftString, ftFloat, ftFloat,
                                              ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftFloat, ftFloat,
                                              ftFloat , ftString, ftFloat , ftFloat , ftFloat , ftFloat , ftFloat, ftFloat,
                                              ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftString, ftString,
                                              ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftFloat,
                                              ftString,
                                              ftString, ftString, ftInteger, ftMemo, ftString, ftString, ftString, ftMemo, ftString, ftString,
                                              ftFloat , ftFloat, ftFloat, ftFloat, ftString, ftString, ftString, ftString, ftString, ftString,
                                              ftString, ftString, ftString, ftString, ftString, ftMemo, ftMemo, ftInteger, ftString, ftString,
                                              ftString,
                                              ftString,
                                              ftString,  // Veio NF
                                              ftString,  // Usa Cheque
                                              ftString,  // Previsão
                                              ftString,  // Pagamento antecipado
                                              ftString,  // Uso e Consumo
                                              ftString,  // Tipo do Documento
                                              ftString,  // Guia do Tributo
                                              ftString,  // Tipo do Tributo
                                              ftString,  // Deposito
                                              ftString,  // Traneferencia
                                              ftString, // Brinde
                                              ftFloat,  // Peso
                                              ftString, //Complemento
                                              ftString,
                                              ftString,// Conta Banco
                                              ftDate,
                                              ftString,
                                              ftCurrency,
                                              ftCurrency,
                                              ftCurrency,
                                              ftString,
                                              ftString,
                                              ftString,
                                              ftString,    // CODCST
                                              ftString,    // CLATRI
                                              ftCurrency,  // BASCAL
                                              ftFloat,     // CBSALQ
                                              ftFloat,     // CBSALE
                                              ftCurrency,  // CBSVAL
                                              ftFloat,     // IBSUFA
                                              ftFloat,     // IBSUFE
                                              ftCurrency,  // IBSUFV
                                              ftFloat,     // IBSMNA
                                              ftFloat,     // IBSMNE
                                              ftCurrency,  // IBSMNV
                                              ftCurrency,  // VALIBS
                                              ftCurrency,  // VALOPE
                                              ftCurrency,  //REIRRF
                                              ftCurrency,  //RETPIS
                                              ftCurrency,  //RETCOF
                                              ftCurrency,  //RECSLL
                                              ftCurrency,  //RETISS
                                              ftCurrency,  //REINSS
                                              ftCurrency,  //RINSSP
                                              ftCurrency,  //RETTOT
                                              ftCurrency,  //VLSERV
                                              ftString,
                                              ftString,
                                              ftString,    //PCXMLD
                                              ftCurrency,  //VALPIS
                                              ftCurrency,  //VALCOF
                                              ftCurrency   //VLLIQX
                                              );

  arrTamanhos: Array[0..166] Of Integer = (12,  //NUMDOC
                                           03,  //SERIE_
                                           02,  //ESPDOC
                                           08,  //CodFor
                                           50,  //CNDPAG
                                           10,  //CODCTA
                                           00,  //VALDOC
                                           00,  //DTAENT
                                           00,  //DTADOC
                                           04,  //CLAFI1
                                           04,  //CLAFIXML
                                           00,  //VALCO1
                                           00,  //BASIC1
                                           00,  //ALQIC1
                                           00,  //VALIC1
                                           00,  //VALOU1
                                           00,  //VALIS1
                                           00,  //VALRE1
                                           00,  //BASIP1
                                           00,  //VALIP1
                                           00,  //BASSU1
                                           00,  //DESAC1
                                           04,  //CLAFI2
                                           00,  //VALCO2
                                           00,  //BASIC2
                                           00,  //ALQIC2
                                           00,  //VALIC2
                                           00,  //VALOU2
                                           00,  //VALIS2
                                           00,  //VALRE2
                                           00,  //BASIP2
                                           00,  //VALIP2
                                           00,  //BASSU2
                                           00,  //DESAC2
                                           04,  //CLAFI3
                                           00,  //VALCO3
                                           00,  //BASIC3
                                           00,  //ALQIC3
                                           00,  //VALIC3
                                           00,  //VALOU3
                                           00,  //VALIS3
                                           00,  //VALRE3
                                           00,  //BASIP3
                                           00,  //VALIP3
                                           00,  //BASSU3
                                           00,  //DESAC3
                                           04,  //CLAFI4
                                           00,  //VALCO4
                                           00,  //BASIC4
                                           00,  //ALQIC4
                                           00,  //VALIC4
                                           00,  //VALOU4
                                           00,  //VALIS4
                                           00,  //VALRE4
                                           00,  //BASIP4
                                           00,  //VALIP4
                                           00,  //BASSU4
                                           00,  //DESAC4
                                           04,  //CLAFI5
                                           00,  //VALCO5
                                           00,  //BASIC5
                                           00,  //ALQIC5
                                           00,  //VALIC5
                                           00,  //VALOU5
                                           00,  //VALIS5
                                           00,  //VALRE5
                                           00,  //BASIP5
                                           00,  //VALIP5
                                           00,  //BASSU5
                                           00,  //DESAC5
                                           500, //HIS001
                                           01,  //MODFRE
                                           00,  //AntIc1
                                           00,  //BasAn1
                                           00,  //AntIc2
                                           00,  //BasAn2
                                           00,  //AntIc3
                                           00,  //BasAn3
                                           00,  //AntIc4
                                           00,  //BasAn4
                                           00,  //AntIc5
                                           00,  //BasAn5
                                           05,  //CODEVE
                                           01,  //IMPORT
                                           255, //NOMARQ
                                           00,  //STATUS
                                           00,  //LOGIMP
                                           255, //NOMFOR
                                           255, //ACESSO
                                           100, //CgcFor
                                           00,  //DUPLIC
                                           03,  //CODEMP
                                           01,  //GRACTP
                                           00,  //ALQPIS
                                           00,  //BASPIS
                                           00,  //ALQCOF
                                           00,  //BASCOF
                                           20,  //AUTPIS
                                           20,  //AUTCOF
                                           01,  //VEIOBO
                                           02,  //CSTPIS
                                           02,  //CSTCOF
                                           100, //CGCREM
                                           100, //CGCDES
                                           10,  //TOMSER
                                           10,  //FORPAG
                                           10,  //CTAREC
                                           03,  //EMPPAG
                                           100, //CODBAR
                                           100, //LINDIG
                                           00,  //CREICM
                                           02,  //MODELO
                                           07,  //COMPET
                                           01,  //CNDXML
                                           01,  //TIPCTE;
                                           01,  //VEIONF
                                           01,  //USACHQ
                                           01,  //PREVIS
                                           01,  //PAGANT
                                           01,  //USOCON
                                           11,  //TIPDOC
                                           02,  //Q_GUIA
                                           12,  //CODREC
                                           01,  //DEPOSI
                                           01,  //TRANSF
                                           01,  //Brinde
                                           00,  //Peso Bruto
                                           01,  //Complemento
                                          255,  //Complemento
                                           20,  //BCOFOR
                                           00, //Data de Cancelamento
                                           20, // AutoIncremento
                                           00, //Base ISS
                                           00, //Ali. ISS
                                           00, // Valor ISS
                                          100, //Codigo
                                          500,//Descricao Servico
                                           10, //Tipo de Serviço
                                           03,   // CODCST
                                           06,   // CLATRI
                                           00,   // BASCAL
                                           00,   // CBSALQ
                                           00,   // CBSALE
                                           00,   // CBSVAL
                                           00,   // IBSUFA
                                           00,   // IBSUFE
                                           00,   // IBSUFV
                                           00,   // IBSMNA
                                           00,   // IBSMNE
                                           00,   // IBSMNV
                                           00,   // VALIBS
                                           00,   // VALOPE
                                           00,  //REIRRF
                                           00,  //RETPIS
                                           00,  //RETCOF
                                           00,  //RECSLL
                                           00,  //RETISS
                                           00,  //REINSS
                                           00,  //RINSSP
                                           00,  //RETTOT
                                           00,   //VLSERV
                                           20,   //NUMDPS
                                           20,   //SERDPS
                                           01,   //PCXMLD
                                           00,   //VALPIS
                                           00,   //VALCOF
                                           00    //VLLIQX
                                           );
Const
  IMPORTADO_OK         = 0;
  IMPORTADO_COM_ERRO   = 1;
  COM_ERRO_GRAVACAO    = 2;
  DOCUMENTO_JA_EXISTE  = 3;


  ConsRemetente    = 0;
  ConsEmitente     = 1;
  ConsExpedidor    = 2;
  ConsRecebedor    = 3;
  ConsDestinatario = 4;
  ConsTomador      = 5;

  tomador_Remetente    = 0;
  tomador_Expedidor    = 1;
  tomador_Recebedor    = 2;
  tomador_Destinatario = 3;
  tomador_Outros       = 4;

  tag_tomador_normal   = 'toma3';
  tag_tomador_normal2  = 'toma03';
  tag_tomador_outros   = 'toma4';
  tag_tomador_outros2  = 'toma04';


implementation

uses Controls, untConstantes, untMovBan, untCadPag, untPcmGer, untCadFis,
     untFuncoes, untTConfiguracao, untTBanCtpRepository ,
     untEscolhePisCofinsFrete, untDuplicatas, untCadRec,
     untEntFreConGridIdentificaDocumento, untEntFreConLista, untXMLNFSePadrao;

{ TEntImpNFSe }

constructor TEntImpNFSe.Create(Owner: TComponent; blnDigNot: Boolean = False);
  Var
    intCont: Integer;
    blnEntMer : boolean;
begin
  inherited Create(Owner);
  FblnVisualizarEditor := False;
  FmemLog := TStringList.Create;
  FmemErr := TStringList.Create;

  stlArquivo := TStringList.Create;
  qryGeneric := fCriaQuery;
  blnImpVariosXml := False;
  strFCEVEN := fCfgSis('FCEVEN');
  blnUSACND := fCfgSis('USACND', varBoolean);
  strFCEDEV := fCfgSis('FCEDEV');
  strFCECOM := fCfgSis('FCECOM');


  blnUtilizaContabilidade := (fCfgsis('UTICON', varBoolean));
  blnEntMer := False;
  if Assigned(Owner) and (Owner is TFreConLista) then
    blnEntMer := (Owner as TFreConLista).blnEntMer;


  FPortadorFornecedor := TPortadorFornecedor.Create( blnEntMer );

  blnCtpBol := fCfgSis('CTPBOL', varBoolean);

  blnImportaPeloBancoDados := False;

  fltVlrConNota := 0;
  fltTotTodosFretes := 0;

  cdsRateioProdutos := Nil;

  pLimpaDadosBoleto;

  FAtulizarTabela := True;

  FAutPis := '';
  FAutCof := '';
  FCstPis := '';
  FCstCof := '';

  FCodEmp := VS_strCodEmp;
  FstrCodEve := '';
  tpNFSe := tpfEntrada;
  blnUtiAbr := fCfgSis('UTIABR', varBoolean);
  blnPerRep := fCfgSis('PERCTE', varBoolean);

  FCodMunicipioInicio:= '';
  FMunicipioDescricaoInicio:= '';
  FCodMunicipioFim:= '';
  FMunicipioDescricaoFim:= '';

  blnSimPau := fCfgSis('SIMPAU', varBoolean);

  fltCfgAlqPis := fCfgSis('ALPISP', varDouble);
  fltCfgAlqCof := fCfgSis('ALCOFP', varDouble);

  strCfgCstPis := fCfgSis('CSTPIS');
  strCfgCstCof := fCfgSis('CSTCOF');

  FListaClaFis := TStringList.Create;
  FListaClaFis.Sorted := True;

  cdsAbrPis := TZClient.Create(Self);
  cdsAbrCof := TZClient.Create(Self);

  objIteAnt := Nil;

  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

  For intCont := 1 to 7 Do
    blnAtpVmb[intCont] := (fCfgSis( IIF( intCont = 1, 'ATPVMB', 'ATPVM' + IntToStr(intCont) )) = 'P');

  FNotEnt   := Nil;
  blnVarNot := blnDigNot;
  FConsulta := fCriaQuery;
  FEmpresas := fCriaQuery;
  FComplemento := '0';
  FBrinde:= '0';
  cdsNotasFiscais := TZClient.Create(nil, fGetSqlNotasFiscais);
  cdsNotasFiscais.fAbreClient(true, 'TEntImpNFSe.Create');


  If blnVarNot Then
  Begin
    FNotEnt    := fCriaQuery(Self);
    objOutDes  := TEntOutrasDespesas.Create(Self);
  End Else
  Begin
    FNotEnt    := Nil;
    objOutDes  := Nil;
  End;

  blnAltDup := False;

  Try

    FImpFre := False;

    qryTabela := TUniClientDataSet.Create(Self);
    dtsTabela := fCriaDataSource(qryTabela);

    {**************************************}
    {* ADICIONA OS FIELDS                 *}
    {***********************************AF*}
    Try
      For intCont := Low(arrCampos) To High(arrCampos) Do
        qryTabela.FieldDefs.Add(arrCampos[intCont], arrDataTypes[intCont], arrTamanhos[intCont]);
    Except
      on E:Exception do
        pMensagemOk(e.message);
    End;
    qryTabela.FieldDefs.Add('PRESTADOR', ftString, 400);
    qryTabela.FieldDefs.Add('DESTINATARIO', ftString, 400);

    qryTabela.CreateDataSet;
    qryTabela.LogChanges := False;

    (qryTabela.FieldByName('ALQPIS') As TFloatField).DisplayFormat := fMskDigitos(2);
    (qryTabela.FieldByName('ALQCOF') As TFloatField).DisplayFormat := fMskDigitos(2);

    FLogImportacao := TStringList.Create;
    FblnGraCTP := True;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('Ocorreu um erro ao criar o objeto FreCon!' + #13 + E.Message);
    End;
  End;

end;


procedure TEntImpNFSe.pSetLinDigCodbar(value: TarrLinDigCodbar);
Begin
  arrLinDigCodbar := value;

  FValDocBoleto := FValDoc;
  FDtaDocBoleto := FDtaDoc;
  FCndPagBoleto := FCndPag;

  pSetLinDig;
End;

Procedure TEntImpNFSe.pLimpaDadosBoleto;
Begin
  FillChar(arrLinDigCodbar, SizeOf(arrLinDigCodbar), #0);
End;



procedure TEntImpNFSe.pAtualizaDados;

begin
  FCgcFor := qryTabela.FieldByName('CGCFOR').AsString;
  FCGCDes := qryTabela.FieldByName('CGCDES').AsString;
  FTomSer := qryTabela.FieldByName('TOMSER').AsString;
  FForPag := qryTabela.FieldByName('FORPAG').AsString;

  FCodEmp := qryTabela.FieldByName('CODEMP').AsString;

  If fEmptyStr(FCodEmp) Then
    FCodEmp := VS_strCodEmp;

  FDuplic := qryTabela.FieldByName('DUPLIC').AsString;
  FLinDig := qryTabela.FieldByName('LINDIG').AsString;
  FCodBar := qryTabela.FieldByName('CODBAR').AsString;

  FNumDoc := qryTabela.FieldByName('NUMDOC').AsString;
  FSerie_ := qryTabela.FieldByName('SERIE_').AsString;
  FComplemento := qryTabela.FieldByName('COMPLE').AsString;
  FBrinde := qryTabela.FieldByName('BRINDE').AsString;

  FVeioNF := qryTabela.FieldByName('VEIONF').AsString;
  FstrArquivoXML := qryTabela.FieldByName('ARQUIV').AsString;
  FUsaChq := qryTabela.FieldByName('USACHQ').AsString;
  FPrevis := qryTabela.FieldByName('PREVIS').AsString;
  FPagAnt := qryTabela.FieldByName('PAGANT').AsString;
  FUsoCon := qryTabela.FieldByName('USOCON').AsString;

  FTipDoc := qryTabela.FieldByName('TIPDOC').AsString;
  FGuiTri := qryTabela.FieldByName('Q_GUIA').AsString;
  FTipTri := qryTabela.FieldByName('CODREC').AsString;

  FDeposi := qryTabela.FieldByName('DEPOSI').AsString;
  FTransf := qryTabela.FieldByName('TRANSF').AsString;
  FBcoFor := qryTabela.FieldByName('BCOFOR').AsString;

  FModFre := qryTabela.FieldByName('MODFRE').AsString;
  FEspDoc := qryTabela.FieldByName('ESPDOC').AsString;
  FCodFor := qryTabela.FieldByName('CODFOR').AsString;
  FNomFor := qryTabela.FieldByName('NOMFOR').AsString;

  FCndPag := qryTabela.FieldByName('CNDPAG').AsString;
  FAcesso := qryTabela.FieldByName('ACESSO').AsString;
  FEmpresaPagadora := qryTabela.FieldByName('EMPPAG').AsString;

  FModelo := qryTabela.FieldByName('MODELO').AsString;

  FBasISS := qryTabela.FieldByName('BASISS').AsCurrency;
  FAliISS := qryTabela.FieldByName('ALIISS').AsCurrency;
  FValISS := qryTabela.FieldByName('VALISS').AsCurrency;
  FCodigo := qryTabela.FieldByName('CODIGO').AsString;
  If fEmptyStr(FCodEmp) Then
    FCodEmp := VS_strCodEmp;

  If fEmptyStr(FCndPag ) Then
  begin
    If blnUSACND then
      FCndPag := fDefineCndPag(FstrCndVaz)
    Else
      FCndPag := FstrCndVaz;
  End;

  FstrCodCta := qryTabela.FieldByName('CODCTA').AsString;
  FCtaRec := qryTabela.FieldByName('CTAREC').AsString;

  FstrCodEve := qryTabela.FieldByName('CODEVE').AsString;
  FCompet := qryTabela.FieldByName('COMPET').AsString;
  FValDoc := qryTabela.FieldByName('VALDOC').AsFloat;
  FdtaDtaEnt := qryTabela.FieldByName('DTAENT').AsDateTime;
  FDtaDoc := qryTabela.FieldByName('DTADOC').AsDateTime;
  FHis001 := qryTabela.FieldByName('HIS001').AsString;

  FClaFi1 := qryTabela.FieldByName('CLAFI1').AsString;
  FClaFixml := qryTabela.FieldByName('CLAFIXML').AsString;
  FValCo1 := qryTabela.FieldByName('VALCO1').AsFloat;
  FBasIc1 := qryTabela.FieldByName('BASIC1').AsFloat;
  FAlqIc1 := qryTabela.FieldByName('ALQIC1').AsFloat;
  FValIc1 := qryTabela.FieldByName('VALIC1').AsFloat;
  FValOu1 := qryTabela.FieldByName('VALOU1').AsFloat;
  FValIs1 := qryTabela.FieldByName('VALIS1').AsFloat;
  FValRe1 := qryTabela.FieldByName('VALRE1').AsFloat;

  FClaFi2 := qryTabela.FieldByName('CLAFI2').AsString;
  FValCo2 := qryTabela.FieldByName('VALCO2').AsFloat;
  FBasIc2 := qryTabela.FieldByName('BASIC2').AsFloat;
  FAlqIc2 := qryTabela.FieldByName('ALQIC2').AsFloat;
  FValIc2 := qryTabela.FieldByName('VALIC2').AsFloat;
  FValOu2 := qryTabela.FieldByName('VALOU2').AsFloat;
  FValIs2 := qryTabela.FieldByName('VALIS2').AsFloat;
  FValRe2 := qryTabela.FieldByName('VALRE2').AsFloat;
  FBasIp2 := qryTabela.FieldByName('BASIP2').AsFloat;
  FValIp2 := qryTabela.FieldByName('VALIP2').AsFloat;
  FBasSu2 := qryTabela.FieldByName('BASSU2').AsFloat;
  FDesAc2 := qryTabela.FieldByName('DESAC2').AsFloat;

  FClaFi3 := qryTabela.FieldByName('CLAFI3').AsString;
  FValCo3 := qryTabela.FieldByName('VALCO3').AsFloat;
  FBasIc3 := qryTabela.FieldByName('BASIC3').AsFloat;
  FAlqIc3 := qryTabela.FieldByName('ALQIC3').AsFloat;
  FValIc3 := qryTabela.FieldByName('VALIC3').AsFloat;
  FValOu3 := qryTabela.FieldByName('VALOU3').AsFloat;
  FValIs3 := qryTabela.FieldByName('VALIS3').AsFloat;
  FValRe3 := qryTabela.FieldByName('VALRE3').AsFloat;
  FBasIp3 := qryTabela.FieldByName('BASIP3').AsFloat;
  FValIp3 := qryTabela.FieldByName('VALIP3').AsFloat;
  FBasSu3 := qryTabela.FieldByName('BASSU3').AsFloat;
  FDesAc3 := qryTabela.FieldByName('DESAC3').AsFloat;

  FClaFi4 := qryTabela.FieldByName('CLAFI4').AsString;
  FValCo4 := qryTabela.FieldByName('VALCO4').AsFloat;
  FBasIc4 := qryTabela.FieldByName('BASIC4').AsFloat;
  FAlqIc4 := qryTabela.FieldByName('ALQIC4').AsFloat;
  FValIc4 := qryTabela.FieldByName('VALIC4').AsFloat;
  FValOu4 := qryTabela.FieldByName('VALOU4').AsFloat;
  FValIs4 := qryTabela.FieldByName('VALIS4').AsFloat;
  FValRe4 := qryTabela.FieldByName('VALRE4').AsFloat;
  FBasIp4 := qryTabela.FieldByName('BASIP4').AsFloat;
  FValIp4 := qryTabela.FieldByName('VALIP4').AsFloat;
  FBasSu4 := qryTabela.FieldByName('BASSU4').AsFloat;
  FDesAc4 := qryTabela.FieldByName('DESAC4').AsFloat;

  FPesoBruto := qryTabela.FieldByName('PESBRU').AsFloat;

  FClaFi5 := qryTabela.FieldByName('CLAFI5').AsString;
  FValCo5 := qryTabela.FieldByName('VALCO5').AsFloat;
  FBasIc5 := qryTabela.FieldByName('BASIC5').AsFloat;
  FAlqIc5 := qryTabela.FieldByName('ALQIC5').AsFloat;
  FValIc5 := qryTabela.FieldByName('VALIC5').AsFloat;
  FValOu5 := qryTabela.FieldByName('VALOU5').AsFloat;
  FValIs5 := qryTabela.FieldByName('VALIS5').AsFloat;
  FValRe5 := qryTabela.FieldByName('VALRE5').AsFloat;
  FBasIp5 := qryTabela.FieldByName('BASIP5').AsFloat;
  FValIp5 := qryTabela.FieldByName('VALIP5').AsFloat;
  FBasSu5 := qryTabela.FieldByName('BASSU5').AsFloat;
  FDesAc5 := qryTabela.FieldByName('DESAC5').AsFloat;

  FAlqPis    := qryTabela.FieldByName('ALQPIS').AsFloat;
  FAlqCof    := qryTabela.FieldByName('ALQCOF').AsFloat;
  FPerBasPis := qryTabela.FieldByName('BASPIS').AsFloat;
  FPerBasCof := qryTabela.FieldByName('BASCOF').AsFloat;

  FAutPis    := qryTabela.FieldByName('AUTPIS').AsString;
  FAutCof    := qryTabela.FieldByName('AUTCOF').AsString;

  FCstPis    := qryTabela.FieldByName('CSTPIS').AsString;
  FCstCof    := qryTabela.FieldByName('CSTCOF').AsString;

  FblnGraCTP := IIf(qryTabela.FieldByName('GRACTP').AsString <> '',
                    qryTabela.FieldByName('GRACTP').AsString = 'S',
                    True);

  blnVeioBoleto := qryTabela.FieldByName('VEIOBO').AsString = 'S';

  FValTot := (FValCo1 + FValCo2 + FValCo3 + FValCo4 + FValCo5);

  FEstFor := fRetEstadoFornecedor(FCodFor);

  FCreditaICMS  := qryTabela.FieldByName('CREICM').AsInteger = 1;
  FDtaCan := qryTabela.FieldByName('DTACAN').AsDateTime;
  FAutInc := qryTabela.FieldByName('AUTINC').AsString;
  FDescricaoServico := qryTabela.FieldByName('DESSRV').AsString;
  FTipoServico := fFormatarTipoServico(qryTabela.FieldByName('TIPSRV').AsString );

  FstrCST             := qryTabela.FieldByName('CODCST').AsString;
  FstrcClassTrib      := qryTabela.FieldByName('CLATRI').AsString;
  FcurvBC             := qryTabela.FieldByName('BASCAL').AsFloat;
  FfloFpCBS           := qryTabela.FieldByName('CBSALQ').AsFloat;
  FfloFpAliqEfetCBS   := qryTabela.FieldByName('CBSALE').AsFloat;
  FcurvCBS            := qryTabela.FieldByName('CBSVAL').AsFloat;
  FdobpIBSUF          := qryTabela.FieldByName('IBSUFA').AsFloat;
  FdobpAliqEfetUF     := qryTabela.FieldByName('IBSUFE').AsFloat;
  FcurvIBSUF          := qryTabela.FieldByName('IBSUFV').AsFloat;
  FdobpIBSMun         := qryTabela.FieldByName('IBSMNA').AsFloat;
  FdobFpAliqEfetMun   := qryTabela.FieldByName('IBSMNE').AsFloat;
  FcurvIBSMun         := qryTabela.FieldByName('IBSMNV').AsFloat;
  FcurvIBSTot         := qryTabela.FieldByName('VALIBS').AsFloat;
  FcurvTotNF          := qryTabela.FieldByName('VALOPE').AsFloat;

  FReIRRF := qryTabela.FieldByName('REIRRF').AsFloat;
  FRetPIS := qryTabela.FieldByName('RETPIS').AsFloat;
  FRetCOF := qryTabela.FieldByName('RETCOF').AsFloat;
  FReCSLL := qryTabela.FieldByName('RECSLL').AsFloat;
  FRETISS := qryTabela.FieldByName('RETISS').AsFloat;
  FReINSS := qryTabela.FieldByName('REINSS').AsFloat;
  FRiNSSP := qryTabela.FieldByName('RINSSP').AsFloat;
  FRetTOT := qryTabela.FieldByName('RETTOT').AsFloat;
  FVlServ := qryTabela.FieldByName('VLSERV').AsFloat;

  FNumDPS             := qryTabela.FieldByName('NUMDPS').AsString;
  FSerDPS             := qryTabela.FieldByName('SERDPS').AsString;
  FPisCofDefXML := qryTabela.FieldByName('PCXMLD').AsString = 'S';
  FValorPIS := qryTabela.FieldByName('VALPIS').AsCurrency;
  FValorCOFINS := qryTabela.FieldByName('VALCOF').AsCurrency;
  FVlLiqXML := qryTabela.FieldByName('VLLIQX').AsCurrency;
end;

procedure TEntImpNFSe.pBeforePost(dataSet: TDataSet);
Begin
  If (dataSet.FieldByName('IMPORT').AsString = 'S') And
    (dataSet.FieldByName('STATUS').AsInteger <> IMPORTADO_OK) Then
   dataSet.FieldByName('IMPORT').AsString := 'N';
end;

function TEntImpNFSe.fVerificaTemCadPag(strCodEmp, strSequen: String): Boolean;
var
  qryCadPag: TUniQuery;
begin
  Result := False;

  if (not blnImportaPeloBancoDados) then
    Exit;

  qryCadPag := fCriaQuery;

  try
    qryCadPag.SQL.Add('SELECT * FROM CADPAG');
    qryCadPag.SQL.Add('WHERE CTP_NUMDUP = :NUMDUP AND ');
    qryCadPag.SQL.Add('    CTP_PARCEL = :PARCEL AND ');
    qryCadPag.SQL.Add('    CTP_CODFOR = :CODFOR AND ');
    qryCadPag.SQL.Add('    CTP_CODEMP = :CODEMP');

    qryCadPag.ParamByName('NUMDUP').AsString := FNumDoc;
    qryCadPag.ParamByName('PARCEL').AsString := strSequen;
    qryCadPag.ParamByName('CODFOR').AsString := FCodFor;
    qryCadPag.ParamByName('CODEMP').AsString := strCodEmp;

    qryCadPag.Open;

    Result := not qryCadPag.IsEmpty;
  finally
    FreeAndNil(qryCadPag);
  end;
end;

function TEntImpNFSe.fVisualizarEditor(
  blnVisualizarEditor: Boolean): TEntImpNFSe;
begin
  Result := Self;
  FblnVisualizarEditor := blnVisualizarEditor;
end;

procedure TEntImpNFSe.pEnviaDados;
begin
  qryTabela.Edit;
  qryTabela.FieldByName('CGCFOR').AsString   := FCgcFor;

  qryTabela.FieldByName('CGCDES').AsString   := FCgcDes;

  qryTabela.FieldByName('TOMSER').AsString   := FTomSer;
  qryTabela.FieldByName('FORPAG').AsString   := FForPag;

  If fEmptyStr(FCodEmp) Then
    FCodEmp := VS_strCodEmp;

  qryTabela.FieldByName('CODEMP').AsString   := FCodEmp;
  qryTabela.FieldByName('PESBRU').AsFloat    := FPesoBruto;

  qryTabela.FieldByName('DUPLIC').AsString   := FDuplic;
  qryTabela.FieldByName('LINDIG').AsString   := FLinDig;
  qryTabela.FieldByName('CODBAR').AsString   := FCodBar;

  qryTabela.FieldByName('ACESSO').AsString   := FAcesso;
  qryTabela.FieldByName('EMPPAG').AsString   := FEmpresaPagadora;
  qryTabela.FieldByName('NUMDOC').AsString   := FNumDoc;
  qryTabela.FieldByName('COMPLE').AsString  := FComplemento;
  qryTabela.FieldByName('BRINDE').AsString  := FBrinde;
  qryTabela.FieldByName('SERIE_').AsString   := FSerie_;

  qryTabela.FieldByName('VEIONF').AsString   := FVeioNF;
  qryTabela.FieldByName('ARQUIV').AsString  := FstrArquivoXML;

  qryTabela.FieldByName('USACHQ').AsString   := FUsaChq;
  qryTabela.FieldByName('PREVIS').AsString   := FPrevis;
  qryTabela.FieldByName('PAGANT').AsString   := FPagAnt;
  qryTabela.FieldByName('USOCON').AsString   := FUsoCon;

  qryTabela.FieldByName('TIPDOC').AsString   := FTipDoc;
  qryTabela.FieldByName('Q_GUIA').AsString   := FGuiTri;
  qryTabela.FieldByName('CODREC').AsString   := FTipTri;

  qryTabela.FieldByName('DEPOSI').AsString   := FDeposi;
  qryTabela.FieldByName('TRANSF').AsString   := FTransf;
  qryTabela.FieldByName('BCOFOR').AsString   := FBcoFor;

  qryTabela.FieldByName('MODFRE').AsString   := FModFre;
  qryTabela.FieldByName('ESPDOC').AsString   := FEspDoc;
  qryTabela.FieldByName('CODFOR').AsString   := FCodFor;
  qryTabela.FieldByName('NOMFOR').AsString   := FNomFor;
  qryTabela.FieldByName('CNDPAG').AsString   := FCndPag;

  qryTabela.FieldByName('BASISS').AsCurrency := FBasISS;
  qryTabela.FieldByName('ALIISS').AsCurrency := FAliISS;
  qryTabela.FieldByName('VALISS').AsCurrency := FValISS;
  qryTabela.FieldByName('CODIGO').AsString   := FCodigo;

  If fEmptyStr(FCndPag ) Then
  begin
    If blnUSACND then
      qryTabela.FieldByName('CNDPAG').AsString := fDefineCndPag(FstrCndVaz)
    Else
      qryTabela.FieldByName('CNDPAG').AsString := FstrCndVaz;
  End;

  qryTabela.FieldByName('CNDXML').AsString   := FCndXML;

  qryTabela.FieldByName('MODELO').AsString   := FModelo;

  qryTabela.FieldByName('CODCTA').AsString   := FstrCodCta;
  qryTabela.FieldByName('CTAREC').AsString   := FCtaRec;

  qryTabela.FieldByName('CODEVE').AsString   := FstrCodEve;
  qryTabela.FieldByName('COMPET').AsString   := FCompet;
  qryTabela.FieldByName('VALDOC').AsFloat    := FValDoc;
  qryTabela.FieldByName('DTAENT').AsDateTime := FdtaDtaEnt;
  qryTabela.FieldByName('DTADOC').AsDateTime := FDtaDoc;
  qryTabela.FieldByName('HIS001').AsString   := FHis001;

  qryTabela.FieldByName('CLAFI1').AsString   := FClaFi1;
  qryTabela.FieldByName('CLAFIXML').AsString   := FClaFiXML;
  qryTabela.FieldByName('VALCO1').AsFloat    := FValCo1;
  qryTabela.FieldByName('BASIC1').AsFloat    := FBasIc1;
  qryTabela.FieldByName('ALQIC1').AsFloat    := FAlqIc1;
  qryTabela.FieldByName('VALIC1').AsFloat    := FValIc1;
  qryTabela.FieldByName('VALOU1').AsFloat    := FValOu1;
  qryTabela.FieldByName('VALIS1').AsFloat    := FValIs1;
  qryTabela.FieldByName('VALRE1').AsFloat    := FValRe1;

  qryTabela.FieldByName('CLAFI2').AsString   := FClaFi2;
  qryTabela.FieldByName('VALCO2').AsFloat    := FValCo2;
  qryTabela.FieldByName('BASIC2').AsFloat    := FBasIc2;
  qryTabela.FieldByName('ALQIC2').AsFloat    := FAlqIc2;
  qryTabela.FieldByName('VALIC2').AsFloat    := FValIc2;
  qryTabela.FieldByName('VALOU2').AsFloat    := FValOu2;
  qryTabela.FieldByName('VALIS2').AsFloat    := FValIs2;
  qryTabela.FieldByName('VALRE2').AsFloat    := FValRe2;
  qryTabela.FieldByName('BASIP2').AsFloat    := FBasIp2;
  qryTabela.FieldByName('VALIP2').AsFloat    := FValIp2;
  qryTabela.FieldByName('BASSU2').AsFloat    := FBasSu2;
  qryTabela.FieldByName('DESAC2').AsFloat    := FDesAc2;

  qryTabela.FieldByName('CLAFI3').AsString   := FClaFi3;
  qryTabela.FieldByName('VALCO3').AsFloat    := FValCo3;
  qryTabela.FieldByName('BASIC3').AsFloat    := FBasIc3;
  qryTabela.FieldByName('ALQIC3').AsFloat    := FAlqIc3;
  qryTabela.FieldByName('VALIC3').AsFloat    := FValIc3;
  qryTabela.FieldByName('VALOU3').AsFloat    := FValOu3;
  qryTabela.FieldByName('VALIS3').AsFloat    := FValIs3;
  qryTabela.FieldByName('VALRE3').AsFloat    := FValRe3;
  qryTabela.FieldByName('BASIP3').AsFloat    := FBasIp3;
  qryTabela.FieldByName('VALIP3').AsFloat    := FValIp3;
  qryTabela.FieldByName('BASSU3').AsFloat    := FBasSu3;
  qryTabela.FieldByName('DESAC3').AsFloat    := FDesAc3;

  qryTabela.FieldByName('CLAFI4').AsString   := FClaFi4;
  qryTabela.FieldByName('VALCO4').AsFloat    := FValCo4;
  qryTabela.FieldByName('BASIC4').AsFloat    := FBasIc4;
  qryTabela.FieldByName('ALQIC4').AsFloat    := FAlqIc4;
  qryTabela.FieldByName('VALIC4').AsFloat    := FValIc4;
  qryTabela.FieldByName('VALOU4').AsFloat    := FValOu4;
  qryTabela.FieldByName('VALIS4').AsFloat    := FValIs4;
  qryTabela.FieldByName('VALRE4').AsFloat    := FValRe4;
  qryTabela.FieldByName('BASIP4').AsFloat    := FBasIp4;
  qryTabela.FieldByName('VALIP4').AsFloat    := FValIp4;
  qryTabela.FieldByName('BASSU4').AsFloat    := FBasSu4;
  qryTabela.FieldByName('DESAC4').AsFloat    := FDesAc4;

  qryTabela.FieldByName('CLAFI5').AsString   := FClaFi5;
  qryTabela.FieldByName('VALCO5').AsFloat    := FValCo5;
  qryTabela.FieldByName('BASIC5').AsFloat    := FBasIc5;
  qryTabela.FieldByName('ALQIC5').AsFloat    := FAlqIc5;
  qryTabela.FieldByName('VALIC5').AsFloat    := FValIc5;
  qryTabela.FieldByName('VALOU5').AsFloat    := FValOu5;
  qryTabela.FieldByName('VALIS5').AsFloat    := FValIs5;
  qryTabela.FieldByName('VALRE5').AsFloat    := FValRe5;
  qryTabela.FieldByName('BASIP5').AsFloat    := FBasIp5;
  qryTabela.FieldByName('VALIP5').AsFloat    := FValIp5;
  qryTabela.FieldByName('BASSU5').AsFloat    := FBasSu5;
  qryTabela.FieldByName('DESAC5').AsFloat    := FDesAc5;
  qryTabela.FieldByName('GRACTP').AsString   := IIf(FblnGraCTP, 'S', 'N');

  qryTabela.FieldByName('ALQPIS').AsFloat    := FAlqPis;
  qryTabela.FieldByName('ALQCOF').AsFloat    := FAlqCof;
  qryTabela.FieldByName('BASPIS').AsFloat    := FPerBasPis;
  qryTabela.FieldByName('BASCOF').AsFloat    := FPerBasCof;
  qryTabela.FieldByName('AUTPIS').AsString   := FAutPis;
  qryTabela.FieldByName('AUTCOF').AsString   := FAutCof;

  qryTabela.FieldByName('CSTPIS').AsString   := FCstPis;
  qryTabela.FieldByName('CSTCOF').AsString   := FCstCof;

  qryTabela.FieldByName('VEIOBO').AsString   := IIf(blnVeioBoleto, 'S', 'N');
  qryTabela.FieldByName('CREICM').AsInteger   := IIf(FCreditaICMS, 1, 0);


  qryTabela.FieldByName('DTACAN').AsDateTime:= FDtaCan;
  qryTabela.FieldByName('AUTINC').AsString:= FAutInc;
  qryTabela.FieldByName('DESSRV').AsString:= FDescricaoServico;
  qryTabela.FieldByName('TIPSRV').AsString:= fFormatarTipoServico(FTipoServico);

  qryTabela.FieldByName('CODCST').AsString   := FstrCST;
  qryTabela.FieldByName('CLATRI').AsString   := FstrcClassTrib;
  qryTabela.FieldByName('BASCAL').AsFloat    := FcurvBC;
  qryTabela.FieldByName('CBSALQ').AsFloat    := FfloFpCBS;
  qryTabela.FieldByName('CBSALE').AsFloat    := FfloFpAliqEfetCBS;
  qryTabela.FieldByName('CBSVAL').AsFloat    := FcurvCBS;
  qryTabela.FieldByName('IBSUFA').AsFloat    := FdobpIBSUF;
  qryTabela.FieldByName('IBSUFE').AsFloat    := FdobpAliqEfetUF;
  qryTabela.FieldByName('IBSUFV').AsFloat    := FcurvIBSUF;
  qryTabela.FieldByName('IBSMNA').AsFloat    := FdobpIBSMun;
  qryTabela.FieldByName('IBSMNE').AsFloat    := FdobFpAliqEfetMun;
  qryTabela.FieldByName('IBSMNV').AsFloat    := FcurvIBSMun;
  qryTabela.FieldByName('VALIBS').AsFloat    := FcurvIBSTot;
  qryTabela.FieldByName('VALOPE').AsFloat    := FcurvTotNF;

  qryTabela.FieldByName('REIRRF').AsFloat := FReIRRF;
  qryTabela.FieldByName('RETPIS').AsFloat := FRetPIS;
  qryTabela.FieldByName('RETCOF').AsFloat := FRetCOF;
  qryTabela.FieldByName('RECSLL').AsFloat := FReCSLL;
  qryTabela.FieldByName('RETISS').AsFloat := FRETISS;
  qryTabela.FieldByName('REINSS').AsFloat := FReINSS;
  qryTabela.FieldByName('RINSSP').AsFloat := FRiNSSP;
  qryTabela.FieldByName('RETTOT').AsFloat := FRetTot;
  qryTabela.FieldByName('VLSERV').AsFloat := FVlServ;

  qryTabela.FieldByName('NUMDPS').AsString   := FNumDPS;
  qryTabela.FieldByName('SERDPS').AsString   := FSerDPS;
  qryTabela.FieldByName('PCXMLD').AsString := IfThen(FPisCofDefXML, 'S', 'N');
  qryTabela.FieldByName('VALPIS').AsCurrency := FValorPIS;
  qryTabela.FieldByName('VALCOF').AsCurrency := FValorCOFINS;
  qryTabela.FieldByName('VLLIQX').AsCurrency := FVlLiqXML;
  qryTabela.Post;
end;


procedure TEntImpNFSe.pEscreveMensagemImportacao(memMsg: TStrings; strMensagem: String;
  intLinha: Integer);
  var
     strTexto: string;
begin
  If Assigned(memMsg) Then
  Begin
    strTexto := FormatDateTime('hh:mm:ss', fNow());
    strTexto := strTexto + ' - ';
    strTexto := strTexto + IIF(intLinha > 0, 'Linha ' + IntToStr(intLinha) + ' - ', '');
    memMsg.Add( strTexto + strMensagem);
    Application.ProcessMessages;
  End
  Else
   pMensagemOk(strMensagem);
end;


procedure TEntImpNFSe.pMarcaTodosArquivos(blnMarcar: Boolean);
begin
  qryTabela.DisableControls;
  qryTabela.First;
  While not qryTabela.Eof Do
  Begin
    qryTabela.Edit;
    qryTabela.FieldByName('IMPORT').AsString :=IfThen(blnMarcar, 'S', 'N');
    qryTabela.Post;
    qryTabela.Next;
  End;
 qryTabela.EnableControls;

end;

function TEntImpNFSe.fSimples(strFornecedor: String): Boolean;
Var qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.Close;
  qryAux.SQL.Text := 'SELECT FOR_SIMPAU FROM CADFOR WHERE FOR_CODFOR = :CODFOR';
  qryAux.ParamByName('CODFOR').AsString := strFornecedor;
  Try
    qryAux.Open;
    Result := qryAux.FieldByName('FOR_SIMPAU').AsString = 'S';
  Except
    Result := False;
  End;
  FreeAndNil(qryAux);
end;


Procedure TEntImpNFSe.pCalculaPisCofins(Var fltBasPis,
                                        fltBasCof,
                                        fltAlqPis,
                                        fltAlqCof,
                                        fltTotPis,
                                        fltTotCof: Double);
Begin
  If (fCfgsis('ZPCCON', varBoolean)) And (blnSimPau Or fSimples(FCodFor)) Then
  Begin
    fltBasPis := 0;
    fltBasCof := 0;
    fltAlqPis := 0;
    fltAlqCof := 0;
    fltTotPis := 0;
    fltTotCof := 0;
  End Else
  Begin
    If blnUtiAbr {And (tpNFSe = tpfEntrada)} Then
    Begin
      fltBasPis := FValDoc * FPerBasPis / 100;
      fltBasCof := FValDoc * FPerBasCof / 100;

      fltAlqPis := FAlqPis;
      fltAlqCof := FAlqCof;
    End Else
    Begin
      fltBasPis := FValDoc;
      fltBasCof := FValDoc;

      fltAlqPis := fltCfgAlqPis;
      fltAlqCof := fltCfgAlqCof;

      FCstPis := strCfgCstPis;
      FCstCof := strCfgCstCof;
    End;

    fltTotPis := fltBasPis * fltAlqPis / 100;
    fltTotCof := fltBasCof * fltAlqCof / 100;

    If FPisCofDefXML Then
    Begin
      If FValorPIS > 0 Then
      Begin
        If fltBasPis <= 0 Then
          fltBasPis := FValDoc;
        fltTotPis := FValorPIS;
        If fltBasPis > 0 Then
          fltAlqPis := RoundTo(fltTotPis / fltBasPis * 100, -2);
      End;
      If FValorCOFINS > 0 Then
      Begin
        If fltBasCof <= 0 Then
          fltBasCof := FValDoc;
        fltTotCof := FValorCOFINS;
        If fltBasCof > 0 Then
          fltAlqCof := RoundTo(fltTotCof / fltBasCof * 100, -2);
      End;
    End;
  End;
End;


{**********************************************}
{* CONFIRMA GRAVAÇÃO DO NFS *}
{*******************************************AF*}
function TEntImpNFSe.fConfirmaImportacao(strNomArq: String; var strErroInt: String; blnRegistroCorrente: Boolean = False): Boolean;
  Var
    intContador : Integer;
    strHistorico: String;
    strSeqLan   : String;
    strNotasRel : String;
    strHisBai   : String;
    strCtaBai   : String;
    strDocBai   : String;
    strOpeBai   : String;
    dtaDtaPag   : TDateTime;
    fltValPag   : Double;
    intCtpCon   : Longint;
    strAutIncCadFis: String;
    strAutPag   : String;
    lstBanCtp : TBanCtpRepository;
    lstMemLog, lstMemErr: TStringList;
    blnGravouCtp: Boolean; // Contas a pagar principal gravado no documento

    strEmpresaTransportadora,
    strFisCodEmp: String;

    fltBasPis,
    fltBasCof,
    fltAlqPis,
    fltAlqCof,
    fltTotPis,
    fltTotCof: Double;
    LRetencoesNoFrame: TRetencoesNoFrame;
Begin
  strEmpresaTransportadora := '';
  LRetencoesNoFrame := nil;
  lstMemLog := nil;
  lstMemErr := nil;

  Try
    Try
//      SetLength(FSeqPag, 0);

      Result := True;

      fStartTransaction;

        qryTabela.First;

        While (Not qryTabela.Eof) Do
        Begin
          pAtualizaDados; // PEGA O CLAFIS DO XML

          FreeAndNil(LRetencoesNoFrame);
          LRetencoesNoFrame := TRetencoesNoFrame.CreateClass(Self, FCodFor);
          blnGravouCtp := False;



          Begin
            pCalculaPisCofins(fltBasPis,
                              fltBasCof,
                              fltAlqPis,
                              fltAlqCof,
                              fltTotPis,
                              fltTotCof);

            strNotasRel := '';



            //Calcula as retencoes do fornecedor
            pCalcularRetencoes(LRetencoesNoFrame);

            Result := fGravaCadFis(strAutIncCadFis,
                                   FdtaDtaEnt, // Data de Entrada
                                   FNumDoc, // Número do Documento
                                   '',      // Número do Documento 2
                                   FEspDoc, // Espécie
                                   'E',     // Entrada / Saida
                                   FDtaDoc, // Data do Documento
                                   'F',     // Tipo (F)ornecedor / (C)liente
                                   FCodFor, // Código Fornecedor / Cliente
                                   FDescricaoServico,      // Histórico
                                   'N',     // Nfe-Complemento
                                   '',      // ???

                                   FClaFi1, // Classificação Fiscal 1
                                   FValCo1, // Valor Contábil 1
                                   0, // Base de ICMS 1
                                   0, // Aliquota de ICMS 1
                                   0, // Valor de ICMS 1
                                   FValCo1, // Valor de Outras 1
                                   FValIs1, // Valor de Isento 1
                                   FValRe1, // Valor de Retido 1
                                   0, // Base de IPI 1
                                   0, // Valor de IPI 1
                                   0, // Base de Substituição 1
                                   0, // Valor de Despesa Acessária 1
                                   FValISS, // Valor do ISS 1

                                   FClaFi2, // Classificação Fiscal 2
                                   FValCo2, // Valor Contábil 2
                                   FBasIc2, // Base de ICMS 2
                                   FAlqIc2, // Aliquota de ICMS 2
                                   FValIc2, // Valor de ICMS 2
                                   FValOu2, // Valor de Outras 2
                                   FValIs2, // Valor de Isento 2
                                   FValRe2, // Valor de Retido 2
                                   FBasIp2, // Base de IPI 2
                                   FValIp2, // Valor de IPI 2
                                   FBasSu2, // Base de Substituição 2
                                   FDesAc2, // Valor de Despesa Acessária 2
                                   FValIs2, // Valor do ISS 2

                                   FClaFi3, // Classificação Fiscal 3
                                   FValCo3, // Valor Contábil 3
                                   FBasIc3, // Base de ICMS 3
                                   FAlqIc3, // Aliquota de ICMS 3
                                   FValIc3, // Valor de ICMS 3
                                   FValOu3, // Valor de Outras 3
                                   FValIs3, // Valor de Isento 3
                                   FValRe3, // Valor de Retido 3
                                   FBasIp3, // Base de IPI 3
                                   FValIp3, // Valor de IPI 3
                                   FBasSu3, // Base de Substituição 3
                                   FDesAc3, // Valor de Despesa Acessária 3
                                   FValIs3, // Valor do ISS 3

                                   FClaFi4, // Classificação Fiscal 4
                                   FValCo4, // Valor Contábil 4
                                   FBasIc4, // Base de ICMS 4
                                   FAlqIc4, // Aliquota de ICMS 4
                                   FValIc4, // Valor de ICMS 4
                                   FValOu4, // Valor de Outras 4
                                   FValIs4, // Valor de Isento 4
                                   FValRe4, // Valor de Retido 4
                                   FBasIp4, // Base de IPI 4
                                   FValIp4, // Valor de IPI 4
                                   FBasSu4, // Base de Substituição 4
                                   FDesAc4, // Valor de Despesa Acessária 4
                                   FValIs4, // Valor do ISS 4

                                   FClaFi5, // Classificação Fiscal 5
                                   FValCo5, // Valor Contábil 5
                                   FBasIc5, // Base de ICMS 5
                                   FAlqIc5, // Aliquota de ICMS 5
                                   FValIc5, // Valor de ICMS 5
                                   FValOu5, // Valor de Outras 5
                                   FValIs5, // Valor de Isento 5
                                   FValRe5, // Valor de Retido 5
                                   FBasIp5, // Base de IPI 5
                                   FValIp5, // Valor de IPI 5
                                   FBasSu5, // Base de Substituição 5
                                   FDesAc5, // Valor de Despesa Acessária 5
                                   FValIs5, // Valor do ISS 5

                                   fltTotPis, // TOT PIS
                                   fltTotCof, // TOT COFINS
                                   fltBasPis, // BASE PIS
                                   fltBasCof, // BASE COFINS
                                   fltAlqPis, // ALIQ PIS
                                   fltAlqCof, // ALIQ COFINS

                                   IIf(fEmptyStr(strFisCodEmp), FCodEmp, strFisCodEmp),  // Empresa
                                   FSerie_,   // Série
                                   FEstFor,   // Estado do Cliente / Fornecedor
                                   '',        // Número de Série
                                   '',        // Número COO
                                   '',        // Conta Contábil
                                   '',        // Documento do Conhecimento de Frete
                                   FAcesso, // Chave de Acessod NF-e
                                   '',        // Numero Protocolo NF-e
                                   '',       // Origem do documento

                                   '',           //strEmpAut
                                   0,            //   fltImpMer
                                   0,            //   fltImpSeg
                                   0,            //   fltImpImp
                                   0,            //   fltImpPro
                                   0,            //   fltImpTax
                                   0,            //   fltImpPis
                                   0,            //   fltImpCof
                                   '',           //  strImpIC1
                                   '',           //  strImpIC2
                                   FModFre,      //  strModFre
                                   FBasISS,            //   fltBasIss
                                   FAliISS,            //   fltAlqIss
                                   FValIss,            //   fltValIss
                                   0,            // fltBaseII: Double = 0;
                                   0,            // fltDesAdu: Double = 0;
                                   0,            // fltValIOF: DOuble = 0;
                                   0,      // Base Antecipação 1
                                   0,      // Vr. Antecipação 1
                                   0,      // Base Antecipação 2
                                   0,      // Vr. Antecipação 2
                                   0,      // Base Antecipação 3
                                   0,      // Vr. Antecipação 3
                                   0,      // Base Antecipação 4
                                   0,      // Vr. Antecipação 4
                                   0,      // Base Antecipação 5
                                   0,      // Vr. Antecipação 5
                                   '',            // strCstEnt
                                   FblnGraCTP,  // Gravou Financeiro);
                                   0, // fltBaeRe1: Double = 0;
                                   0, // fltVaeRe1: Double = 0;
                                   0, // fltBaeRe2: Double = 0;
                                   0, // fltVaeRe2: Double = 0;
                                   0, // fltBaeRe3: Double = 0;
                                   0, // fltVaeRe3: Double = 0;
                                   0, // fltBaeRe4: Double = 0;
                                   0, // fltVaeRe4: Double = 0;
                                   0, // fltBaeRe5: Double = 0;
                                   0, // fltVaeRe5: Double = 0;
                                   0, // fltBaeIP1: Double = 0;
                                   0, // fltVaeIP1: Double = 0;
                                   0, // fltBaeIP2: Double = 0;
                                   0, // fltVaeIP2: Double = 0;
                                   0, // fltBaeIP3: Double = 0;
                                   0, // fltVaeIP3: Double = 0;
                                   0, // fltBaeIP4: Double = 0;
                                   0, // fltVaeIP4: Double = 0;
                                   0, // fltBaeIP5: Double = 0;
                                   0, // fltVaeIP5: Double = 0;
                                   FCstPis,
                                   FCstCof,
                                   FModelo,
                                   '',

                                    0,      //fltBFCPS1
                                    0,      //fltVFCPS1
                                    0,      //fltBFCPS2
                                    0,      //fltVFCPS2
                                    0,      //fltBFCPS3
                                    0,      //fltVFCPS3
                                    0,      //fltBFCPS4
                                    0,      //fltVFCPS4
                                    0,      //fltBFCPS5
                                    0,      //fltVFCPS5
                                    0,      //fltALQFCP
                                    0,      //fltTotRmm
                                    '',     //strCodFor

                                    FReIRRF,     //FIS_REIRRF
                                    FRetPIS,     //FIS_VREPIS
                                    FRetCOF,     //FIS_VRECOF
                                    FReCSLL,     //FIS_RECSLL
                                    FRETISS,     //FIS_RETISS
                                    FReINSS,     //FIS_REINSS
                                    0, // fltBAFCP1
                                    0, // fltVLFCP1
                                    0, // fltBAFCP2
                                    0, // fltVLFCP2
                                    0, // fltBAFCP3
                                    0, // fltVLFCP3
                                    0, // fltBAFCP4
                                    0, // fltVLFCP4
                                    0, // fltBAFCP5
                                    0, // fltVLFCP5
                                    '', // strTipFre
                                    0, // fltRFRBAS
                                    0, // fltRFRALQ
                                    0, // fltRFRVAL
                                    '', // strCstIPI
                                    'N', // strNfCIAP
                                    0, // fltPesCTE
                                    '', // strEstornoNotaFiscal
                                    '', // strEstornoNotaFiscalMotivo
                                    '', // strNatOpe
                                    '', // strTB01RE
                                    '', // strTB06RE
                                    '', // strBasFre
                                    False, // blnDevSim
                                    FTipoServico, // strCdsErv
                                    0, // fltQBCMO1
                                    0, // fltQBCMO2
                                    0, // fltQBCMO3
                                    0, // fltQBCMO4
                                    0, // fltQBCMO5
                                    0, // fltQBCMO6
                                    0, // fltQBCMO7
                                    0, // fltQBCMO8
                                    0, // fltADREM1
                                    0, // fltADREM2
                                    0, // fltADREM3
                                    0, // fltADREM4
                                    0, // fltADREM5
                                    0, // fltADREM6
                                    0, // fltADREM7
                                    0, // fltADREM8
                                    0, // fltVALMO1
                                    0, // fltVALMO2
                                    0, // fltVALMO3
                                    0, // fltVALMO4
                                    0, // fltVALMO5
                                    0, // fltVALMO6
                                    0, // fltVALMO7
                                    0, // fltVALMO8
                                    '', // strNfsSub
                                    '', // strMesAno
                                    '', // strFinNfe
                                    '', // strFinTip
                                    0, // fltTotIbs
                                    0, // fltTotCbs
                                    0, // fltTotIs
                                    0, // fltTotProIs
                                    0, // fltTotNf
                                    FNumDps, // strNumDPS
                                    FSerDps  // strSerDPS
                                    );

            If Not Result Then
              raise Exception.Create('Documento ' + FNumDoc + '-' + FEspDoc + ': Erro ao gravar o livro fiscal.');
          End;

          pCriaMovGerMovDet;
          If FblnGraCTP And ((FComplemento = '0') Or ((FComplemento = '1') And (FValCo1 > 0))) Then
          Begin

            fDigDuplic(arrDuplicata,
                       FCndPag,
                       0,
                       fValorTotalLiquido(LRetencoesNoFrame),
                       False,
                       True,
                       False,
                       FdtaDtaEnt,
                       True,
                       0,
                      'N');


            pMontaDuplicatasXMl;

            If
               (fCfgSis('ENTCTP', varBoolean))    And
               (fFornecedorGravaCtp(FCodFor))     Then
            Begin

              intContador := 0;

              intCtpCon := fRetCtpCon;
              {*****************************************}
              {* INICIA A GRAVAÇÃO DO CONTAS A PAGAR   *}
              {**************************************AF*}
              While (intContador <= 23)                          And
                    (ArrDuplicata[intContador].dtaDtaVen <> '')  And
                    (Result)                                     Do
              Begin
                strHistorico := fGerarHistoricoCTP;
                strHisBai := '';
                strCtaBai := '';
                strDocBai := '';
                strOpeBai := '';
                dtaDtaPag := 0;
                fltValPag := 0;
                strSeqLan := '';

                If (fCfgSis('CTPAVI', varBoolean))                            And
                   (StrToDate(ArrDuplicata[intContador].dtaDtaVen) = VS_Date) Then
                Begin
                  lstBanCtp := TBanCtpRepository.Create;
                  Try
                    lstBanCtp.fAdd(FNumDoc,
                                   'A',
                                   FSerie_,
                                   IIf(fEmptyStr(strFisCodEmp), FCodEmp, strFisCodEmp),
                                   FCodFor, // Fornecedor
                                   strHistorico,
                                   '',
                                   FstrCodCta,
                                   IIf(fEmptyStr(strFisCodEmp), FCodEmp, strFisCodEmp),
                                   0,
                                   ArrDuplicata[intContador].curValor,
                                   0,
                                   0,
                                   0,
                                   0);

                    strSeqLan := fGravaMovBan(FstrCodCta,                            // Centro de Custo
                                              FstrPorBai,                            // Portador da Baixa
                                              strCodOpe,                          // Operador da Baixa
                                              VS_Date,                            // Data do Lançamento
                                              fTime(),                            // Hora do Lançamento
                                              FNumDoc,                            // Numero do Documento
                                              'D',                                // Credito / Debito
                                              IIf(fEmptyStr(strFisCodEmp), FCodEmp, strFisCodEmp),
                                              ArrDuplicata[intContador].curValor, // Valor Do Lançamento
                                              strHistorico,                       // Histórico 1
                                              '',                                 // Histórico 2
                                              '',                                 // Cliente da Duplicata
                                              FCodFor,                            // Fornecedor da Duplicata
                                              FNumDoc,                            // Número da Duplicata
                                              0,                                  // Sequencial de Baixa
                                              'A',                                // Parcela da Duplicata
                                              IIf(fEmptyStr(strFisCodEmp), FCodEmp, strFisCodEmp),
                                              FSerie_,                            // Série
                                              FstrCodEve,                            // Código do Evento
                                              '',                                 // Documento da Baixa
                                              lstBanCtp.fGetList,                 // Log Bancário
                                              0,
                                              intCtpCon);

                    Result := Not fEmptyStr(strSeqLan);

                  Finally
                    FreeAndNil(lstBanCtp);
                  End;

                  strHisBai := fGerarHistoricoCTP;


                  strCtaBai := FstrCodCta;
                  strDocBai := strSeqLan;
                  strOpeBai := strLoginUsuarioLogado;
                  dtaDtaPag := VS_Date;
                  fltValPag := ArrDuplicata[intContador].curValor;

                End;

                if not fVerificaTemCadPag(IIf(fEmptyStr(FEmpresaPagadora),
                                          IIf(fEmptyStr(strFisCodEmp),FCodEmp ,strFisCodEmp),
                                          FEmpresaPagadora), ArrDuplicata[intContador].strSequen) then
                begin
                  strAutPag := fRetAutoIncrem('CADPAG', VS_strCodEmp);

//                SetLength(FSeqPag, Succ(Length(FSeqPag)));
//                FSeqPag[High(FSeqPag)] := strAutPag;

                  ArrDuplicata[intContador].strUsaChq := IfThen (Pos(ArrDuplicata[intContador].strUsaChq, 'S_N_') <= 0, 'N',
                  ArrDuplicata[intContador].strUsaChq);

                  Result := Result And
                          fGravaCadPag('frmEnTEntImpNFSeImportacao' + 'untEnTEntImpNFSe - fConfirmaImportacao', //Nome Form LOGCTP
                                       'BAIXA - NOTA FISCAL DE SERVICO',                //Descrição LOGCTP
                                       FCodFor,                                        // Fornecedor
                                       FNumDoc,                                        // Numero da Duplicata
                                       ArrDuplicata[intContador].strSequen,            // Parcela
                                       IIf(fEmptyStr(FEmpresaPagadora),
                                          IIf(fEmptyStr(strFisCodEmp),FCodEmp ,strFisCodEmp),
                                          FEmpresaPagadora),                           // Empresa
                                       FstrCodCta,                                        // Centro de Custo
                                       FSerie_,                                        // Serie do Documento
                                       0,                                              // Sequencial de Baixa
                                       FdtaDtaEnt,                                        // Data do lançamento
                                       StrToDate(ArrDuplicata[intContador].dtaDtaVen), // Data de Vencimento
                                       ArrDuplicata[intContador].curValor - fltValPag, // Valor da Duplicata
                                       ArrDuplicata[intContador].curValor,             // Valor Original
                                       'N',                                            // Previsão?
                                       Iif(blnVeioBoleto, 'S', 'N'),                   // Veio Boleto
                                       'N',                                            // Deposito
                                       strHistorico,                                   // Histórico 1
                                       '',                                             // Histórico 2
                                       strHisBai,                                      // Histórico da Baixa
                                       FstrPorBai,                                        // Portador da Baixa
                                       strCtaBai,                                      // Centro de Custo da Baixa
                                       strDocBai,                                      // Documento da Baixa
                                       strOpeBai,                                      // Operador da Baixa
                                       dtaDtaPag,                                      // Data do Pagamento
                                       fltValPag,                                      // Valor Pago
                                       0,                                              // Valor de Juros
                                       0,                                              // Valor Desconto
                                       IIf(fEmptyStr(strFisCodEmp), FCodEmp, strFisCodEmp), // Empresa
                                       FstrCodEve,                                        // Código do Evento
                                       ArrDuplicata[intContador].strUsaChq,            // Usa Cheque
                                       FstrPorBai,                                        // Cod do Portador
                                       FNumDoc,                                        // Numero do Documento
                                       0.0,                                            // fltJurSuj
                                       0.0,                                            // fltDesSuj
                                       intCtpCon,                                      // intSeqCon
                                       False,                                          // blnResCai
                                       0,                                              // intRcxCon
                                       '',                                             // strTipDoc
                                       0,                                              // fltVendor
                                       '',                                             // strVeioNF
                                       '',                                             // strNotEnt
                                       '',                                             // strNotTip
                                       '',                                             // strCTPCom
                                       strAutPag,                                      // strAutInc
                                       '',                                             // strDocTer
                                       '',                                             // strEspTer
                                       '',                                             // strEmpTer
                                       '',                                             // strCliTer
                                       'N',                                            // strUsoCon
                                       FComPet,                                        // strCompet
                                       '',                                             // strCodCliUC
                                       '',                                             // strNumDocUC
                                       '',                                             // strEspDocUC
                                       '',                                             // strCodEmpUC
                                       fltValPag,                                      // fltDinhei
                                       0,                                              // fltChqAvi: Double = 0;
                                       0,                                              // fltOrdPag: Double = 0;
                                       0,                                              // fltRepChq: Double = 0;
                                       '',                                             // strCodVen: String = '';
                                       0,                                              // fltJurAnt: Double = 0;
                                       0,                                              // fltDesAnt: Double = 0;
                                       IIF(blnVeioBoleto And (blnCtpBol), arrLinDigCodbar[intContador].strLinDig, ''),  // strLinDig: String = '';
                                       IIF(blnVeioBoleto And (blnCtpBol), arrLinDigCodbar[intContador].strCodBar, ''),  // strCodBar: String = '';
                                       '',
                                       '',
                                       '',
                                       '0',
                                       '',
                                       '',
                                       '',
                                       '',
                                       'N',
                                       '',
                                       '',
                                       '',
                                       '',
                                       0,
                                       '',
                                       0,
                                       '',
                                       0,
                                       0,
                                       0,
                                       '',
                                       '',
                                       strAutIncCadFis
                                       );

                  // Somente quando a parcela foi realmente gravada (nao em reimportacao de duplicata ja existente)
                  If Result Then
                    blnGravouCtp := True;
                end;

                If Not Result Then
                  Break;
                Inc(intContador);
              End;

              If Not Result Then
                raise Exception.Create('Documento ' + FNumDoc + '-' + FEspDoc + ': Erro ao gravar o contas a pagar.');
            End;
          End; {do If (fCfgSis('ENTCTP', varBoolean))    And
               (Pos(strClaFis, VS_strClaCom) > 0) And
               (fFornecedorGravaCtp(FCodFor))     Then...}


          //Grava o XML no banco de dados
          TImpNFSe
            .New
            .fNFSe(TNFSe
                     .fNovo
                     .fLoadFromFile(FstrPath + qryTabela.FieldByName('NOMARQ').AsString)

              )
            .fCodEmp(FCodEmp)
            .fAutIncCadFis(strAutIncCadFis)
            .fExecute;

          //Grava os titulos de retencao do fornecedor, somente quando o contas a pagar principal foi gravado
          If (FblnGravarPagamentoRetido) And (blnGravouCtp) And Assigned(LRetencoesNoFrame) Then
            If Not LRetencoesNoFrame.fCriarParcelasRetencoesFornecedor(strAutIncCadFis, True, 'TEntImpNFSe.fConfirmaImportacao - Imp. XML') Then
              raise Exception.Create('Documento ' + FNumDoc + '-' + FEspDoc + ': Erro ao gravar os títulos de retenção.');

          pEscreveMensagemImportacao(FMemLog, 'Documento ' + FNumDoc + '-' + FEspDoc + ': ' + 'Gravação efetuada com sucesso!');

          qryTabela.Next;
        End; {While (Not Eof) And Result Do}

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pEscreveMensagemImportacao(FMemErr, 'Ocorreu um erro: ' + E.Message);
        pMensagensErro(E.Message,'[TEntImpNFSe.fConfirmaImportacao]');
        Result := False;

        qryTabela.Edit;
        qryTabela.FieldByName('STATUS').AsInteger := COM_ERRO_GRAVACAO;
        qryTabela.FieldByName('IMPORT').AsString := 'N';
        qryTabela.FieldByName('LOGIMP').AsString := qryTabela.FieldByName('LOGIMP').AsString + ' ' + e.Message;
        qryTabela.Post;
      End;
    End;
  Finally
    FreeAndNil(LRetencoesNoFrame);
    If Assigned(lstMemErr) Then
    Begin
      FreeAndNil(lstMemErr);
      FMemErr := nil;
    End;
    If Assigned(lstMemLog) Then
    Begin
      FreeAndNil(lstMemLog);
      FMemLog := nil;
    End
  End;

End;


function TEntImpNFSe.fConfirmaImportacaoNFSe(prgProgresso: TProgressBar): Boolean;
  Var
    strNomArq: String;
    strErroInt: String;
    strMensagem: String;
Begin
  try
    Try
      Result := True;
      qryTabela.DisableControls;
      qryTabela.Filter   := 'IMPORT = ' + QuotedStr('S');
      qryTabela.Filtered := True;

      If blnUtiAbr And fInformarPisCofins Then
      Begin
        qryTabela.Filtered := False;
        qryTabela.EnableControls;
        Result   := False;
        Exit;
      End;

      qryTabela.First;
      Try
        If qryTabela.IsEmpty Then
        Begin
          Result := False;
          qryTabela.Filtered := False;
          qryTabela.EnableControls;
          pMensagemOk('Selecione os arquivos para importação!');
          Exit;
        End;

        If Not fPergunta('Confirma a importação dos arquivos selecionados?') Then
        Begin
          Result := False;
          qryTabela.Filtered := False;
          qryTabela.EnableControls;
          Exit;
        End;

        prgProgresso.Position := 0;
        prgProgresso.Max      := qryTabela.RecordCount;
        prgProgresso.Visible  := True;

        While Not qryTabela.Eof Do
        Begin
          strNomArq := FstrPath + qryTabela.FieldByName('NOMARQ').AsString;
          If fConfirmaImportacao(strNomArq, strErroInt, True) Then
          Begin
            RenameFile(strNomArq, AnsiLeftStr(strNomArq, Length(strNomArq) - 3) + 'old');
            qryTabela.Delete;
          End
          Else
          Begin
            Result := False;

            strNomArq := qryTabela.FieldByName('NOMARQ').AsString;

            qryTabela.Edit;
            qryTabela.FieldByName('STATUS').AsInteger := COM_ERRO_GRAVACAO;
            qryTabela.FieldByName('LOGIMP').AsString := qryTabela.FieldByName('LOGIMP').AsString + ' ' + strErroInt;
            qryTabela.Post;

            // ESTÁ COM FILTRO
            If SameText(strNomArq, qryTabela.FieldByName('NOMARQ').AsString) Then
              qryTabela.Next;
          End;

          prgProgresso.StepBy(1);
          Application.ProcessMessages;
        End;

        qryTabela.Filtered := False;

        strMensagem := 'Arquivos importados com sucesso!';
        If qryTabela.Locate('STATUS', VarArrayOf(['2']), []) Then
          strMensagem := 'Há arquivos com erro de gravação!';

        pMensagemOk(strMensagem);

        qryTabela.First;
      Finally
        qryTabela.Filtered := False;
        qryTabela.EnableControls;
        prgProgresso.Visible  := False;

      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TEntImpNFSe.fConfirmaImportacaoNFSe]');
      End;
    End;
  Finally
    pFiltraLog;
  End;
end;


destructor TEntImpNFSe.Destroy;
begin
  FreeAndNil(stlArquivo);
  FreeAndNil(qryGeneric);
  FreeAndNil(qryTabela);
  FreeAndNil(FLogImportacao);
  FreeAndNil(FConsulta);
  FreeAndNil(FEmpresas);
  FreeAndNil(FPortadorFornecedor);
  FreeAndNil(cdsNotasFiscais);

  if Assigned(qryCTes) then
    FreeAndNil(qryCTes);

  pFreeAndNil(cdsAbrPis);
  pFreeAndNil(cdsAbrCof);
  pFreeAndNil(FListaClaFis);
  pFreeAndNil(FLogImportacao);
  pFreeAndNil(FmemLog);
  pFreeAndNil(FmemErr);
  inherited Destroy;
end;

procedure TEntImpNFSe.pValidarArquivo(strArquivo: String);
Begin
  stlArquivo.LoadFromFile(strArquivo);
  Try
    If (stlArquivo.Count = 0) Then
      raise Exception.Create('O Arquivo informado está vazio!');

    If Not FileExists(strArquivo) Then
      raise Exception.Create('O Arquivo informado não existe!');
  Except
    On E: Exception Do
      FLogImportacao.Add(e.message);
  End;
End;

procedure TEntImpNFSe.pValidarDados;
Begin
  If fLocalizarNota Then
  Begin
    FStatus := DOCUMENTO_JA_EXISTE;
    raise Exception.Create('Documento ' + FNumDoc +'-'+ FEspDoc + ': Já foi importado.');
  End;

  If Not fEmptyStr(FTipoServico) Then
    If fEmptyStr(fCampoTabela('CDS_CDSERV', 'CADCDS', ['CDS_CDSERV'], [FTipoServico], False)) Then
      raise Exception.Create('Documento ' + FNumDoc +'-'+ FEspDoc + ': O tipo de serviço ' + FTipoServico + ' não cadastrado.');

  If FCgcDes <> fRetCNPJEmpresa(VS_strCodEmp) Then
    raise Exception.Create('Documento ' + FNumDoc +'-'+ FEspDoc + ': O destinatário deve ser a empresa logada.');

  If fEmptyStr(FCodFor) Then
    raise Exception.Create('Documento ' + FNumDoc +'-'+ FEspDoc + ': O prestador ' + FNomFor + ' não foi localizado.');

  If fConsultarConta Then
    raise Exception.Create('Documento ' + FNumDoc +'-'+ FEspDoc + ': Esse Plano de Contas: ' + FstrCodCta + ' não está cadastrado ou não está vinculado ao fornecedor: '+ FCodFor);
End;

function TEntImpNFSe.fCarregaArquivoNFSe(const strArquivo: String): Boolean;
begin


  Result := True;

  FValTot  := 0.0;
  FImpFre  := True;

  FmemLog.Clear;
  FmemErr.Clear;
  FLogImportacao.Clear;

  FStatus := IMPORTADO_OK;
  Try
    pValidarCampos;
    pValidarArquivo(strArquivo);
    pCarregaArquivoNFSeXML(strArquivo);
    pEnviaDados;
    pValidarDados;
    if FLogImportacao.Text <> '' Then
      raise Exception.Create(FLogImportacao.Text);
  Except
    On E: Exception Do
    Begin
      If FStatus =  IMPORTADO_OK Then
        FStatus := IMPORTADO_COM_ERRO;
      pEscreveMensagemImportacao(FmemErr, 'Erro: ' + E.Message, 0);
    End;
  End;
  qryTabela.Edit;
  qryTabela.FieldByName('NOMARQ').AsString;
  qryTabela.FieldByName('LOGIMP').AsString := FmemErr.Text;
  qryTabela.FieldByName('STATUS').AsInteger := FStatus;
  qryTabela.FieldByName('IMPORT').AsString  := IfThen(FStatus = IMPORTADO_OK,'S','N') ;
  qryTabela.Post;
end;

function TEntImpNFSe.fCarregarEditorLayout(strNomArq : String): Boolean;

Var
  objXmlNFSe: INFSe;
  strSchema: String;
  strSchemaMD5: String;
  strAutoIncrem: String;
begin
  //Carregar XML
  objXmlNFSe := TNFSe
    .fNovo
      .fLoadFromFile(strNomArq)
        .fXMLToSchema
      .fSchema(strSchema)
      .fSchemaMD5(strSchemaMD5);

  //Consultar Schema
  strAutoIncrem := TLayXNS
    .fNovo
    .fSchemaMD5(strSchemaMD5)
    .fConsultar
      .FieldByName('AUTOINCREM')
      .AsString;

  //Carregar Editor Layout se não existir o schema
  pCriarFormularios(TfrmEditorLayoutNFSe, frmEditorLayoutNFSe);
  Try
    Result := frmEditorLayoutNFSe
        .fTitulo('Arquivo:' + strNomArq)
        .fAutoIncrem(strAutoIncrem)
        .fSchemaMD5(strSchemaMD5)
        .fSchema(strSchema)
        .fCarregarTreeView
          .ShowModal = mrok;
  Finally
    FreeAndNil(frmEditorLayoutNFSe);
  End;
End;

function TEntImpNFSe.fCarregarLayXNS(AstrSchema, AstrSchemaMD5 : String): String;
Var
  LObjLayXNS: TLayXNS;
Begin
  LObjLayXNS := TLayXNS.fNovo;
  Try
    Result := LObjLayXNS
      .fSchema(AstrSchema)
      .fSchemaMD5(AstrSchemaMD5)
      .fInserir
        .FieldByName('AUTOINCREM')
        .AsString;
  Finally
    pFreeAndNil(LObjLayXNS);
  End;
End;

function TEntImpNFSe.fCarregarLayDNS(AstrAutoIncrem, AstrSchema: String): String;
Var
  LobjLayDNS: TLayDNS;
Begin
  LobjLayDNS := TLayDNS.fNovo;
  Try
    Result := LobjLayDNS
      .fSeqLay(AstrAutoIncrem)
      .fSchema(AstrSchema)
        .fInserir
        .fLayout
  Finally
    pFreeAndNil(LobjLayDNS);
  End;
End;


procedure TEntImpNFSe.pCarregaArquivoNFSeXML(strNomArq : String);

Var
  objXmlNFSe: INFSe;
  strSchema: String;
  strSchemaMD5: String;
  LstrLayout: String;
  strAutoIncrem: String;
  strUFEmp: String;
  strUFFor: String;
  LintRtISS: Integer;
  LintRtPisCof: Integer;
  LcurDescartado: Currency;
begin
  //Carregar XML
  objXmlNFSe := TNFSe
    .fNovo
    .fLoadFromFile(strNomArq)
      .fXMLToSChema
      .fSchema(strSchema)
      .fSchemaMD5(strSchemaMD5);

  //Consultar Schema
  If objXmlNFSe.LayoutTipo = ltConfigurado Then
  Begin
    strAutoIncrem := fCarregarLayXNS(strSchema, strSchemaMD5);
    If Not fEmptyStr(strAutoIncrem) Then
    Begin
      LstrLayout := fCarregarLayDNS(strAutoIncrem, strSchema);
      if fEmptyStr(LstrLayout) Then
        raise Exception.Create('Layout do XML não está cadastrado nos modelos disponíveis. Pressione [F4] para cadastrar o layout do XML.');
      objXmlNFSe.fLayout(LstrLayout);
    End;
  End;
  FCodFor := '';
  FTomSer := '';
  FForPag := '';
  FEspDoc := 'NS';
  FstrTipoFJ := 'J';
  FCodEmp := VS_strCodEmp;
  FAcesso := fRetSomenteNumeros(fTiraCaracEspeciaisPonto(objXmlNFSe.fCampo('FIS_ACESSO').fTexto));
  FCGCDes := fTiraCaracEspeciaisPonto(objXmlNFSe.fCampo('FIS_CGCDES').fTexto);
  FCgcFor := fTiraCaracEspeciaisPonto(objXmlNFSe.fCampo('FIS_FORCLI').fTexto);
  If fEmptyStr(FCGCFor) Then
    FCgcFor := fTiraCaracEspeciaisPonto(objXmlNFSe.fCampo('FIS_FORFIS').fTexto);
  If Not fEmptyStr(FCgcFor) Then
    FCodFor := fRetCodFornecedorPorCnpj(FCgcFor);

  FNomFor := fRetNomFornecedor(FCodFor);
  FSerie_ := objXmlNFSe.fCampo('FIS_SERIE_').fTexto;
  FNumDoc := fStrZero( objXmlNFSe.fCampo('FIS_NUMDOC').fTexto,12);
  FDtaDoc := objXmlNFSe.fCampo('FIS_DTAENT').fData;
  FModelo := '56';

  FCndPag := FstrCndVaz;
  If blnUSACND then
    FCndPag := fDefineCndPag(FstrCndVaz);

  FVlServ := objXmlNFSe.fCampo('FIS_VLSERV').fValor;
  FValDoc := objXmlNFSe.fCampo('FIS_VLCON1').fValor;
  FVlLiqXML := FValDoc;
  FValCo1 := FValDoc;
  If FVlServ > FValDoc Then
  Begin
    FValCo1 := FVlServ;
    FValDoc := FVlServ;
  End;

  strUFEmp := fRetUFEmpresa(FCodEmp);
  strUFFor := fEstadoFornecedor(FCodFor);

  FClaFi1 := IfThen(strUFEmp = strUFFor,'1933','2933');

  FBasISS := objXmlNFSe.fCampo('FIS_BASISS').fValor;
  FAliISS := objXmlNFSe.fCampo('FIS_ALQISS').fValor;
  FValISS := objXmlNFSe.fCampo('FIS_VALISS').fValor;

  FReIRRF := objXmlNFSe.fCampo('FIS_REIRRF').fValor;
  FRetPIS := objXmlNFSe.fCampo('FIS_RETPIS').fValor;
  FRetCOF := objXmlNFSe.fCampo('FIS_RETCOF').fValor;
  FReCSLL := objXmlNFSe.fCampo('FIS_RECSLL').fValor;
  FReINSS := objXmlNFSe.fCampo('FIS_REINSS').fValor;
  FRETISS := objXmlNFSe.fCampo('FIS_RETISS').fValor;
  FRiNSSP := objXmlNFSe.fCampo('FIS_RINSSP').fValor;
  FRetTOT := objXmlNFSe.fCampo('FIS_TOTRET').fValor;


  FAlqPis := objXmlNFSe.fCampo('FIS_ALQPIS').fValor;
  FPerBasPis := objXmlNFSe.fCampo('FIS_BASPIS').fValor;

  FAlqCof := objXmlNFSe.fCampo('FIS_ALQCOF').fValor;
  FPerBasCof := objXmlNFSe.fCampo('FIS_BASCOF').fValor;

  FDescricaoServico := objXmlNFSe.fCampo('FIS_HISTOR').fTexto;
  FTipoServico := fFormatarTipoServico(objXmlNFSe.fCampo('FIS_CDSERV').fTexto);


  FstrCST           := objXmlNFSe.fCampo('REF_CODCST').fTexto;
  FstrcClassTrib    := objXmlNFSe.fCampo('REF_CLATRI').fTexto;
  FcurvBC           := objXmlNFSe.fCampo('REF_BASCAL').fValor;
  FfloFpCBS         := objXmlNFSe.fCampo('REF_CBSALQ').fValor;
  FfloFpAliqEfetCBS := objXmlNFSe.fCampo('REF_CBSALE').fValor;
  FcurvCBS          := objXmlNFSe.fCampo('REF_CBSVAL').fValor;
  FdobpIBSUF       := objXmlNFSe.fCampo('REF_IBSUFA').fValor;
  FdobpAliqEfetUF  := objXmlNFSe.fCampo('REF_IBSUFE').fValor;
  FcurvIBSUF        := objXmlNFSe.fCampo('REF_IBSUFV').fValor;
  FdobpIBSMun      := objXmlNFSe.fCampo('REF_IBSMNA').fValor;
  FdobFpAliqEfetMun := objXmlNFSe.fCampo('REF_IBSMNE').fValor;
  FcurvIBSMun       := objXmlNFSe.fCampo('REF_IBSMNV').fValor;
  FcurvIBSTot       := objXmlNFSe.fCampo('REF_VALIBS').fValor;
  FcurvTotNF        := objXmlNFSe.fCampo('REF_VALOPE').fValor;

  LintRtISS := Round(objXmlNFSe.fCampo('FIS_TRISSQ').fValor);

  If FRetTOT > 0 Then
  Begin
    If (FRETISS = 0) And  (LintRtISS = 2) Then
    Begin
      FRETISS := FValISS;
      FValISS := 0;
    End;
  End;

  FNumDPS           := objXmlNFSe.fCampo('FIS_NUMDPS').fTexto;
  FSerDPS           := objXmlNFSe.fCampo('FIS_SERDPS').fTexto;

  //Padrao Nacional: vPis/vCofins sao o valor do tributo; so ha retencao
  //quando tpRetPisCofins indicar. Tag ausente (0) = nao retido.
  //  0-PIS/COFINS/CSLL nao retidos   1-Retido (legado)   2-Nao retido (legado)
  //  3-PIS/COFINS/CSLL retidos       4-PIS/COFINS retidos
  //  5-PIS retido                    6-COFINS retido
  //  7-COFINS/CSLL retidos           8-CSLL retido
  //  9-PIS/CSLL retidos
  FPisCofDefXML := objXmlNFSe.LayoutTipo In [ltNacional_V1, ltNacional_V1_1];
  FValorPIS := 0;
  FValorCOFINS := 0;
  If FPisCofDefXML Then
  Begin
    LintRtPisCof := StrToIntDef(Trim(objXmlNFSe.fCampo('FIS_TRPICO').fTexto), 0);
    LcurDescartado := 0;

    If Not (LintRtPisCof In [1, 3, 4, 5, 9]) Then
    Begin
      LcurDescartado := LcurDescartado + FRetPIS;
      FValorPIS := FRetPIS;
      FRetPIS := 0;
    End;

    If Not (LintRtPisCof In [1, 3, 4, 6, 7]) Then
    Begin
      LcurDescartado := LcurDescartado + FRetCOF;
      FValorCOFINS := FRetCOF;
      FRetCOF := 0;
    End;

    //vTotalRet do XML soma PIS/COFINS; retira o que nao e retencao
    FRetTOT := FRetTOT - LcurDescartado;
    If FRetTOT < 0 Then
      FRetTOT := 0;
  End;
end;

Function TEntImpNFSe.fConsultarConta: Boolean;
Var
  qryConNFS: TUniQuery;
Begin
  Try
    qryConNFS := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
    pPesquisaCadCta(qryConNFS, qryConNFS, FstrCodCta, True, FCodFor);
    Result := Not qryConNFS.FieldByName('CTA_CODCTA').IsNull;
  Finally
    FreeAndNil(qryConNFS);
  End;
End;

function TEntImpNFSe.fCarregaArquivos(strPath, strExtensao: String): Boolean;
  Var
    srcArquivo: TSearchRec;
    intAchou  : Integer;
Begin
  Result := True;
  If RightStr(strPath,1) <> '\' Then
    strPath := strPath + '\';

  qryTabela.EmptyDataSet;
  intAchou := FindFirst(strPath + '*.XML', faArchive, srcArquivo);
  FStrPath := strPath;
  cdsNotasFiscais.EmptyDataSet;
  Try
    If intAchou = 0 then
    Begin
      Repeat
        qryTabela.Append;
        qryTabela.FieldByName('IMPORT').AsString := 'S';
        qryTabela.FieldByName('NOMARQ').AsString := srcArquivo.Name;
        qryTabela.FieldByName('ARQUIV').AsString := strPath+srcArquivo.Name;
        FStrArquivoXml := strPath+srcArquivo.Name;
        qryTabela.Post;
      Until FindNext(srcArquivo) <> 0;
      Result := True;
    end;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEntImpNFSe.fCarregaArquivos]');
    End;
  End;

end;

{***********************************************}
{* VERIFICA SE DOCUMENTO EXISTE NO LIVRO E CTP *}
{* RESULTA TRUE SE EXISTIR                     *}
{********************************************AF*}
function TEntImpNFSe.fVerificaDocumento: Boolean;
  Var
    qryGen: TUniQuery;
Begin

  Try
    Result := True;
    qryGen := fCriaQuery;
    If FNumDoc = '' Then
      Exit(False);
    If FEspDoc = '' Then
      Exit(False);
    If FCodEmp = '' Then
      Exit(False);
    If FSerie_ = '' Then
      Exit(False);
    If FCodFor = '' Then
      Exit(False);

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT       ');
    qryGen.SQL.Add('  FIS_NUMDOC ');
    qryGen.SQL.Add('FROM         ');
    qryGen.SQL.Add('  CADFIS     ');
    qryGen.SQL.Add('WHERE        ');
    qryGen.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
    qryGen.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
    qryGen.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
    qryGen.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ AND ');
    qryGen.SQL.Add('  FIS_FORCLI = :CODFOR AND ');
    qryGen.SQL.Add('  FIS_TIP_FC = "F"         ');

    qryGen.ParamByName('NUMDOC').AsString := FNumDoc;
    qryGen.ParamByName('ESPDOC').AsString := FEspDoc;
    qryGen.ParamByName('CODEMP').AsString := FCodEmp;
    qryGen.ParamByName('SERIE_').AsString := FSerie_;
    qryGen.ParamByName('CODFOR').AsString := FCodFor;
    qryGen.Open;

    If qryGen.IsEmpty Then
      Result := False;

    qryGen.Close;

    If Not Result Then
    Begin
      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add('SELECT       ');
      qryGen.SQL.Add('  CTP_NUMDUP ');
      qryGen.SQL.Add('FROM         ');
      qryGen.SQL.Add('  CADPAG     ');
      qryGen.SQL.Add('WHERE        ');
      qryGen.SQL.Add('  CTP_NUMDUP = :NUMDUP AND ');
      qryGen.SQL.Add('  CTP_CODEMP = :CODEMP AND ');
      qryGen.SQL.Add('  IFNULL(CTP_SERIE_, "") = :SERIE_ AND ');
      qryGen.SQL.Add('  CTP_CODFOR = :CODFOR     ');

      qryGen.ParamByName('NUMDUP').AsString := FNumDoc;
      qryGen.ParamByName('CODEMP').AsString := FCodEmp;
      qryGen.ParamByName('SERIE_').AsString := FSerie_;
      qryGen.ParamByName('CODFOR').AsString := FCodFor;
      qryGen.Open;

      If qryGen.IsEmpty Then
        Result := False;

      qryGen.Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

procedure TEntImpNFSe.pControlaDigDuplicAtual(intOpc: Integer);
Var
  intContad: Integer;
begin

  If (intOpc = 1) Then
  Begin

    For intContad := 0 To Length(arrDuplicata) - 1 Do
    Begin
      arrDupTmp[intContad].intNumDup := ArrDuplicata[intContad].intNumDup;
      arrDupTmp[intContad].strSequen := ArrDuplicata[intContad].strSequen;
      arrDupTmp[intContad].curValor  := ArrDuplicata[intContad].curValor;
      arrDupTmp[intContad].dtaDtaVen := ArrDuplicata[intContad].dtaDtaVen;
      arrDupTmp[intContad].strUsaChq := ArrDuplicata[intContad].strUsaChq;
      arrDupTmp[intContad].strHist02 := ArrDuplicata[intContad].strHist02;
    End;

  End
  Else If (intOpc = 2) Then
  Begin

    For intContad := 0 To Length(arrDupTmp) - 1 Do
    Begin
      ArrDuplicata[intContad].intNumDup := ArrDupTmp[intContad].intNumDup;
      ArrDuplicata[intContad].strSequen := ArrDupTmp[intContad].strSequen;
      ArrDuplicata[intContad].curValor  := ArrDupTmp[intContad].curValor;
      ArrDuplicata[intContad].dtaDtaVen := ArrDupTmp[intContad].dtaDtaVen;
      ArrDuplicata[intContad].strUsaChq := ArrDupTmp[intContad].strUsaChq;
      ArrDuplicata[intContad].strHist02 := ArrDupTmp[intContad].strHist02;
    End;

  End
  Else If (intOpc = 3) Then
  Begin

    For intContad := 0 To Length(arrDupFre) - 1 Do
    Begin
      ArrDuplicata[intContad].intNumDup := ArrDupFre[intContad].intNumDup;
      ArrDuplicata[intContad].strSequen := ArrDupFre[intContad].strSequen;
      ArrDuplicata[intContad].curValor  := ArrDupFre[intContad].curValor;
      ArrDuplicata[intContad].dtaDtaVen := ArrDupFre[intContad].dtaDtaVen;
      ArrDuplicata[intContad].strUsaChq := ArrDupFre[intContad].strUsaChq;
      ArrDuplicata[intContad].strHist02 := ArrDupFre[intContad].strHist02;
    End;

  End

  Else If (intOpc = 4) Then
  Begin

    For intContad := 0 To Length(arrDuplicata) - 1 Do
    Begin
      arrDupFre[intContad].intNumDup := ArrDuplicata[intContad].intNumDup;
      arrDupFre[intContad].strSequen := ArrDuplicata[intContad].strSequen;
      arrDupFre[intContad].curValor  := ArrDuplicata[intContad].curValor;
      arrDupFre[intContad].dtaDtaVen := ArrDuplicata[intContad].dtaDtaVen;
      arrDupFre[intContad].strUsaChq := ArrDuplicata[intContad].strUsaChq;
      arrDupFre[intContad].strHist02 := ArrDuplicata[intContad].strHist02;
    End;

  End;
end;

function TEntImpNFSe.fDefineCndPag(cndDefault: String): String;
var qryConsulta: TUniQuery;
    strCndPag: String;
    strCodCnd: String;
begin
  Result := cndDefault;
  qryConsulta := fCriaQuery;
  Try
     qryConsulta.SQL.Add('SELECT FOR_CODCND, FOR_CNDPAG FROM CADFOR WHERE FOR_C_G_C_ = "'+FCgcFor+'"');
     qryConsulta.Open;
     If qryConsulta.FieldByName('FOR_CNDPAG').AsString <> '' then
     begin
       strCndPag := qryConsulta.FieldByName('FOR_CNDPAG').AsString;
       strCodCnd := qryConsulta.FieldByName('FOR_CODCND').AsString;
       If strCodCnd <> '' Then
       Begin
         qryConsulta.SQL.Clear;
         qryConsulta.SQL.Add('SELECT * FROM CADCND WHERE CND_CODIGO = "'+strCodCnd+'"');
         qryConsulta.Open;
         strCndPag := fRetCondicao(strCndPag,
                                   FDtaDoc,
                                   qryConsulta.FieldByName('CND_CODIGO').AsString,
                                   qryConsulta.FieldByName('CND_TIPFOR').AsString,
                                   qryConsulta.FieldByName('CND_CNDPAG').AsString,
                                   FDtaDoc,'','', True);
       End;
       Result := strCndPag;
     End;
  Finally
    FreeAndNil(qryConsulta);
  End;

end;

Function TEntImpNFSe.fDocumentoExiste(strNumDoc, strEspDoc, strSerie, strCodFor: String;
                                  Var blnConFre: Boolean;
                                  Var fltOutDes: Double): Boolean;
Begin
  fltOutDes := 0;

  FNotEnt.Close;
  FNotEnt.SQL.Clear;

  FNotEnt.SQL.Add('/* untEnTEntImpNFSe.fDocumentoExiste */');
  FNotEnt.SQL.Add('SELECT SQL_NO_CACHE');

  FNotEnt.SQL.Add('  G.AUTOINCREM AS AUTINC,');
  FNotEnt.SQL.Add('  GER_DTAENT   AS DTAENT,');
  FNotEnt.SQL.Add('  GER_VLRCON   AS VLRCON,');

  FNotEnt.SQL.Add('  0.00         AS PERREP,');

  FNotEnt.SQL.Add(' (  SELECT SUM(IFNULL(DET_OUTDES, 0)) FROM MOVDET D');
  FNotEnt.SQL.Add('    INNER JOIN MOVTRI T ON D.AUTOINCREM = T.DET_SEQGER');
  FNotEnt.SQL.Add('    WHERE D.DET_SEQGER = G.AUTOINCREM ');
  FNotEnt.SQL.Add(' ) AS OUTDES');

  FNotEnt.SQL.Add('FROM');
  FNotEnt.SQL.Add('MOVGER G');
  FNotEnt.SQL.Add('LEFT JOIN AUXMOV ON AUX_SEQGER = G.AUTOINCREM');
  FNotEnt.SQL.Add('WHERE');

  FNotEnt.SQL.Add('  GER_TIP_FC = "F" AND ');
  FNotEnt.SQL.Add('  IFNULL(GER_ORIDOC, "") = "" AND ');
  FNotEnt.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
  FNotEnt.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
  FNotEnt.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  FNotEnt.SQL.Add('  GER_CODFOR = :CODFOR AND ');
  FNotEnt.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');

  FNotEnt.ParamByName('NUMDOC').AsString  := strNumDoc;
  FNotEnt.ParamByName('ESPDOC').AsString  := strEspDoc;
  FNotEnt.ParamByName('SERIE_').AsString  := strSerie;
  FNotEnt.ParamByName('CODFOR').AsString  := strCodFor;
  FNotEnt.ParamByName('CODEMP').AsString  := FCodEmp;

  FNotEnt.Open;

  Result := Not FNotEnt.IsEmpty;

  blnConFre := Result;

  If Not FNotEnt.IsEmpty Then
    fltOutDes := FNotEnt.FieldByName('OUTDES').AsFloat;
End;

Procedure TEntImpNFSe.pSetDupicatas;
  Var
    stlVencimentos: TStringList;
    intContador: Integer;
Begin
  stlVencimentos := TStringList.Create;

  For intContador := Low(arrDuplicata) To High(arrDuplicata) Do
    If arrDuplicata[intContador].curValor > 0 Then
    Begin
      arrDuplicata[intContador].strSequen := String(arrLetras[intContador]);
      stlVencimentos.Add(arrDuplicata[intContador].dtaDtaVen + ' ' +
                         FormatFloat('#0.00', arrDuplicata[intContador].curValor))
    End Else
      Break;

  FDuplic := stlVencimentos.Text;

  FreeAndNil(stlVencimentos);

  pSetLinDig;
End;

Procedure TEntImpNFSe.pSetLinDig;
  Var
    stlVencimentos: TStringList;
    intContador: Integer;
Begin
  stlVencimentos := TStringList.Create;

  stlVencimentos.Clear;
  For intContador := Low(arrLinDigCodbar) To High(arrLinDigCodbar) Do
    stlVencimentos.Add(arrLinDigCodbar[intContador].strLinDig);
  FLinDig := stlVencimentos.Text;

  stlVencimentos.Clear;
  For intContador := Low(arrLinDigCodbar) To High(arrLinDigCodbar) Do
    stlVencimentos.Add(arrLinDigCodbar[intContador].strCodBar);
  FCodBar := stlVencimentos.Text;

  FreeAndNil(stlVencimentos);
End;

function TEntImpNFSe.fRetCNPJEmpresa(strCodEmp: String): String;
begin
  If FEmpresas.IsEmpty Then
  Begin
    FEmpresas.SQL.Text := 'SELECT EMP_CODEMP, EMP_C_G_C_ FROM CADEMP';
    FEmpresas.Open;
  End;
  FEmpresas.First;
  If FEmpresas.Locate('EMP_CODEMP', strCodEmp, []) Then
    Result := FEmpresas.FieldByName('EMP_C_G_C_').AsString
  Else
    Exit('');
end;

function TEntImpNFSe.fRetEstadoEmpresa(strCodEmp: String): String;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;
Begin
  Try

    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CID_ESTADO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + '  INNER JOIN CADCID ON CID_CODCID = EMP_CODCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    qryGenEmp.Close;
    qryGenEmp.SQL.Clear;
    qryGenEmp.SQL.Add(strSQL);
    qryGenEmp.ParamByName('CODEMP').AsString := strCodEmp;
    qryGenEmp.Open;
    If qryGenEmp.IsEmpty Then
      Result := ''
    Else
      Result := qryGenEmp.FieldByName('CID_ESTADO').AsString;
    qryGenEmp.Close;


  Finally
    FreeAndNil(qryGenEmp);
  End;

End;

procedure TEntImpNFSe.pMontaDuplicatasXMl;
  Var
    stlVencimentos: TStringList;
    intContador: Integer;
    strValor: String;
Begin
  If fEmptyStr(FDuplic) Then
    Exit;
  stlVencimentos := TStringList.Create;
  stlVencimentos.Text := FDuplic;

  FillChar(arrDuplicata, Sizeof(arrDuplicata), #0);
  FillChar(arrLinDigCodbar, Sizeof(arrLinDigCodbar), #0);

  For intContador := 0 To stlVencimentos.Count - 1 Do
  Begin
    strValor := stlVencimentos[intContador];

    If StrToDateDef(LeftStr(strValor, 10), 0) > 0 Then
      arrDuplicata[intContador].dtaDtaVen := LeftStr(strValor, 10);

    Delete(strValor, 1, 11);

    arrDuplicata[intContador].curValor  := fStrToFloat(strValor);
    arrDuplicata[intContador].strSequen := String(arrLetras[intContador]);
  End;

  stlVencimentos.Text := FLinDig;
  For intContador := 0 To stlVencimentos.Count - 1 Do
    If intContador <= High(arrLinDigCodbar) Then
      arrLinDigCodbar[intContador].strLinDig := stlVencimentos[intContador];

  stlVencimentos.Text := FCodBar;
  For intContador := 0 To stlVencimentos.Count - 1 Do
    If intContador <= High(arrLinDigCodbar) Then
      arrLinDigCodbar[intContador].strCodBar := stlVencimentos[intContador];

  FreeAndNil(stlVencimentos);
end;


function TEntImpNFSe.fXmlToBanco(prgProgresso: TProgressBar): Boolean;
Begin
  Try
    qryTabela.DisableControls;
    qryTabela.BeforePost := Nil;
    prgProgresso.Position := 0;
    prgProgresso.Max      := qryTabela.RecordCount;
    prgProgresso.Visible  := True;

    qryTabela.First;
    While Not qryTabela.Eof Do
    Begin
      FmemLog.Clear;
      FMemErr.Clear;
      fCarregaArquivoNFSe(FstrPath + qryTabela.FieldByName('NOMARQ').AsString);


      prgProgresso.StepBy(1);
      Application.ProcessMessages;
      qryTabela.Next;
    End;
    Result := fCarregaAbrevPisCof;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEntImpNFSe.fXmlToBanco]');
    End;
  End;

  qryTabela.BeforePost := pBeforePost;
  qryTabela.EnableControls;
  qryTabela.First;
  If Assigned(prgProgresso) Then
    prgProgresso.Visible := False;

end;

function TEntImpNFSe.fConsultarAbreviacaoCOFINS: String;
var
  intContador: Integer;
  strSQL: string;
begin
  If FListaClaFis.Count = 0 Then
  Begin
    If (tpNFSe = tpfSaida) Then
      strSQL := strSQL + 'SELECT AUTOINCREM, CONCAT(APC_CODAPC, "-", APC_DESCRI) AS DESCRI, APC_CSTSAI AS APC_CSTENT, APC_BASSAI AS APC_BASENT, APC_ALQSAI AS APC_ALQENT, "     " AS CLAFIS FROM COFSAI WHERE FALSE'
    Else
      strSQL := strSQL + 'SELECT AUTOINCREM, CONCAT(APC_CODAPC, "-", APC_DESCRI) AS DESCRI, APC_CSTENT, APC_BASENT, APC_ALQENT, "     " AS CLAFIS FROM COFENT WHERE FALSE';
  End Else
  Begin

    For intContador := 0 To FListaClaFis.Count - 1 Do
    Begin
      If Not fEmptyStr(strSQL) Then
        strSQL := strSQL + ' UNION ';
      If  Pos(LeftStr(FListaClaFis[intContador], 1), '1_2_') = 0 Then
        strSQL := strSQL + 'SELECT AUTOINCREM, CONCAT(APC_CODAPC, "-", APC_DESCRI) AS DESCRI, APC_CSTSAI AS APC_CSTENT, APC_BASSAI AS APC_BASENT, APC_ALQSAI AS APC_ALQENT, "' + FListaClaFis[intContador] + '" AS CLAFIS FROM COFSAI WHERE LOCATE("' + FListaClaFis[intContador] + '", APC_CFOSAI)'
      Else
        strSQL := strSQL + 'SELECT AUTOINCREM, CONCAT(APC_CODAPC, "-", APC_DESCRI) AS DESCRI, APC_CSTENT, APC_BASENT, APC_ALQENT, "' + FListaClaFis[intContador] + '" AS CLAFIS FROM COFENT WHERE LOCATE("' + FListaClaFis[intContador] + '", APC_CFOENT)';
    End;
  End;
  Result := strSQL;
End;

function TEntImpNFSe.fConsultarAbreviacaoPIS: String;
var
  intContador: Integer;
  strSQL: string;
begin
  if FListaClaFis.Count = 0 then
  begin
    if (tpNFSe = tpfSaida) then
      strSQL := strSQL + 'SELECT AUTOINCREM, CONCAT(APC_CODAPC, "-", APC_DESCRI) AS DESCRI, APC_CSTSAI AS APC_CSTENT, APC_BASSAI AS APC_BASENT , APC_ALQSAI APC_ALQENT, "     " AS CLAFIS FROM PISSAI WHERE FALSE'
    else
      strSQL := strSQL + 'SELECT AUTOINCREM, CONCAT(APC_CODAPC, "-", APC_DESCRI) AS DESCRI, APC_CSTENT, APC_BASENT, APC_ALQENT, "     " AS CLAFIS FROM PISENT WHERE FALSE';
  end
  else
  begin
    for intContador := 0 to FListaClaFis.Count - 1 do
    begin
      if not fEmptyStr(strSQL) then
        strSQL := strSQL + ' UNION ';
      if Pos(LeftStr(FListaClaFis[intContador], 1), '1_2_') = 0 then
        strSQL := strSQL + 'SELECT AUTOINCREM, CONCAT(APC_CODAPC, "-", APC_DESCRI) AS DESCRI, APC_CSTSAI AS APC_CSTENT, APC_BASSAI AS APC_BASENT, APC_ALQSAI AS APC_ALQENT, "' + FListaClaFis[intContador] + '" AS CLAFIS FROM PISSAI WHERE LOCATE("' + FListaClaFis[intContador] + '", APC_CFOSAI)'
      else
        strSQL := strSQL + 'SELECT AUTOINCREM, CONCAT(APC_CODAPC, "-", APC_DESCRI) AS DESCRI, APC_CSTENT, APC_BASENT, APC_ALQENT, "' + FListaClaFis[intContador] + '" AS CLAFIS FROM PISENT WHERE LOCATE("' + FListaClaFis[intContador] + '", APC_CFOENT)';
    end;
  end;
  Result := strSQL;
end;

procedure TEntImpNFSe.pValidarCampos;
begin
  if fEmptyStr(FstrPorBai) and fCfgSis('CTPAVI', varBoolean) and FblnGraCTP then
    FLogImportacao.Add('O portador deve ser informado!');
  if fEmptyStr(FstrCodCta) and FblnGraCTP then
    FLogImportacao.Add('O código da conta deve ser informado!');
end;

function TEntImpNFSe.fLocalizarNota: Boolean;
begin
  FConsulta.SQL.Clear;
  FConsulta.SQL.Add('SELECT 1 FROM CADFIS WHERE ');
  FConsulta.SQL.Add('FIS_CODEMP = :CODEMP AND');
  FConsulta.SQL.Add('FIS_FORCLI = :CODFOR AND');
  FConsulta.SQL.Add('FIS_SERIE_ = :SERIE AND');
  FConsulta.SQL.Add('FIS_NUMDOC = :NUMDOC');
  FConsulta.ParamByName('CODEMP').AsString := FCodEmp;
  FConsulta.ParamByName('CODFOR').AsString := FCodFor;
  FConsulta.ParamByName('SERIE').AsString := FSerie_;
  FConsulta.ParamByName('NUMDOC').AsString := FNumDoc;
  FConsulta.Open;
  Result := Not FConsulta.IsEmpty;
End;


function TEntImpNFSe.fGetSqlNotasFiscais: string;
Begin
  Result := '';
  Result := Result + 'SELECT CADFIS.FIS_ACESSO AS CTE_ACESSO,';
  Result := Result + '       CADFIS.FIS_CODEMP,';
  Result := Result + '       CADFIS.FIS_NUMDOC,';
  Result := Result + '       CADFIS.FIS_ESPDOC,';
  Result := Result + '       CADFIS.FIS_TIP_FC,';
  Result := Result + '       CADFIS.FIS_FORCLI,';
  Result := Result + '       CADFIS.FIS_SERIE_,';
  Result := Result + '       "N" AS LOC_IMPORT,';  // se o documento foi encontrado pela importacao ou digitado
  Result := Result + '       "N" AS ENT_DUPLIC,';  // se a a vinculação manual esta duplicada
  Result := Result + '       "N" AS DUP_RECTNF,';  // marca se a nota esta duplicada no banco

  Result := Result + '       CADFIS.FIS_NUMDOC AS OUT_NUMDOC, '; //Numero do documento pela chave da nota
  Result := Result + '       CAST("" AS CHAR(2)) AS OUT_TIPDOC, '; //Numero do documento pela chave da nota
  Result := Result + '       CAST("" AS CHAR(10)) AS OUT_DESCRI, '; //Numero do documento pela chave da nota

  Result := Result + '       CAST("" AS CHAR(14)) AS DESTINATARIO, ';

  Result := Result + '       CAST("" AS CHAR(70)) AS NFE_DESTINATARIO, ';
  Result := Result + '       CAST("" AS CHAR(1))  AS NOTGER, ';
  Result := Result + '       CADFIS.AUTOINCREM AS MOV_GERSEQ, ';
  Result := Result + '       CADFIS.FIS_ACESSO AS NFE_ACESSO, ';
  Result := Result + '       CADFIS.FIS_NUMDOC AS NFE_NUMDOC, '; //Numero do documento pela chave da nota
  Result := Result + '       CADFIS.FIS_SERIE_ AS NFE_SERIE_, '; //Serie do documento pela chave da nota
  Result := Result + '       "00.00.0000/0000-00"  AS NFE_CNPJ__, '; //Cnpj do documento pela chave da nota
  Result := Result + '       "N"               AS CTE_MARCAD  '; //marca se o cte esta selecionado para ser importado
  Result := Result + '  FROM CADFIS';
  Result := Result + ' WHERE FALSE';
End;


function TEntImpNFSe.fFormatCNPJ(strCNPJ: String): string;
Begin
  Insert('.', strCNPJ, 3);
  Insert('.', strCNPJ, 7);
  Insert('/', strCNPJ, 11);
  Insert('-', strCNPJ, 16);
  Result := strCNPJ;
End;

Function TEntImpNFSe.fCarregaAbrevPisCofPrg(prgProgresso: TcxProgressBar): Boolean;
begin

  if FListaClaFis.IndexOf('1933') = -1 then
    FListaClaFis.Add('1933');
  if FListaClaFis.IndexOf('2933') = -1 then
    FListaClaFis.Add('2933');

  cdsAbrPis.qryQuery.SQL.Text := fConsultarAbreviacaoPIS;
  cdsAbrPis.fAbreClient(True, 'TEntImpNFSe.fCarregaAbrevPisCofPrg');
  cdsAbrPis.IndexFieldNames := 'CLAFIS';

  cdsAbrCof.qryQuery.SQL.Text := fConsultarAbreviacaoCOFINS;
  cdsAbrCof.fAbreClient(True, 'TEntImpNFSe.fCarregaAbrevPisCofPrg');
  cdsAbrCof.IndexFieldNames := 'CLAFIS';

  cdsAbrCof.pAlinhaCampoCentro('CLAFIS');
  cdsAbrCof.pAlinhaCampoCentro('APC_CSTENT');


  If FAtulizarTabela Then
  Begin
    if Assigned(prgProgresso) then
    begin
      prgProgresso.Properties.Max := qryTabela.RecordCount;
      Application.ProcessMessages;
    end;

    cdsAbrPis.Filtered := True;
    cdsAbrCof.Filtered := True;

    qryTabela.First;

    While Not qryTabela.Eof Do
    Begin
      cdsAbrPis.Filter := 'CLAFIS = ' + QuotedStr(qryTabela.FieldByName('CLAFI1').AsString);
      cdsAbrCof.Filter := 'CLAFIS = ' + QuotedStr(qryTabela.FieldByName('CLAFI1').AsString);

      qryTabela.Edit;

      If cdsAbrPis.RecordCount = 1 Then
      Begin
        qryTabela.FieldByName('ALQPIS').AsFloat  := cdsAbrPis.FieldByName('APC_ALQENT').AsFloat;
        qryTabela.FieldByName('BASPIS').AsFloat  := cdsAbrPis.FieldByName('APC_BASENT').AsFloat;
        qryTabela.FieldByName('AUTPIS').AsString := cdsAbrPis.FieldByName('AUTOINCREM').AsString;
        qryTabela.FieldByName('CSTPIS').AsString := cdsAbrPis.FieldByName('APC_CSTENT').AsString;
      End

      Else qryTabela.FieldByName('AUTPIS').AsString := '';

      If cdsAbrCof.RecordCount = 1 Then
      Begin
        qryTabela.FieldByName('ALQCOF').AsFloat  := cdsAbrCof.FieldByName('APC_ALQENT').AsFloat;
        qryTabela.FieldByName('BASCOF').AsFloat  := cdsAbrCof.FieldByName('APC_BASENT').AsFloat;
        qryTabela.FieldByName('AUTCOF').AsString := cdsAbrCof.FieldByName('AUTOINCREM').AsString;
        qryTabela.FieldByName('CSTCOF').AsString := cdsAbrCof.FieldByName('APC_CSTENT').AsString;
      End
      Else
        qryTabela.FieldByName('AUTCOF').AsString := '';


      qryTabela.Post;

      qryTabela.Next;

      if Assigned(prgProgresso) then
      begin
        prgProgresso.Position := prgProgresso.Position + 1;
        Application.ProcessMessages;
      end;
    End;
  End;

  Result := True;
End;

Function TEntImpNFSe.fCarregaAbrevPisCof(blnAtualizarTabela: Boolean = True): Boolean;
Begin
  Try
    FAtulizarTabela := blnAtualizarTabela;

    If Not blnUtiAbr Then
    Begin
      Result := True;
      Exit;
    End;

    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.lblGravando.Caption := 'Carregando abreviação de PIS/COFINS, aguarde...';
    frmGravando.fExecutarAcao := fCarregaAbrevPisCofPrg;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;

    pFreeAndNil(frmGravando);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEntImpNFSe.fCarregaAbrevPisCof]');
    End;
  End;
End;

Function TEntImpNFSe.fSelecionaAbreviacaoPis: Boolean;
Begin
  Try
    cdsAbrPis.Filter   := 'CLAFIS = ' + QuotedStr(qryTabela.FieldByName('CLAFI1').AsString);
    cdsAbrPis.Filtered := True;

    If cdsAbrPis.IsEmpty Then
    Begin
      pMensagemOk('Nenhuma Abreviação de PIS cadastrada para a CFOP ' + qryTabela.FieldByName('CLAFI1').AsString + '.' + #13#10 +
                  'Cadastre as Abreviações em Principal/ Manutenção de Cadastros/ Auxiliares/ Abreviação PIS !');
      Result := False;
      Exit;
    End;

    cdsAbrPis.Locate('AUTOINCREM',  qryTabela.FieldByName('AUTPIS').AsString, []);
    pCriarFormularios(TfrmEscolhePisCofinsFrete, frmEscolhePisCofinsFrete);
    frmEscolhePisCofinsFrete.Caption := 'Selecione a Alíquota de PIS';
    frmEscolhePisCofinsFrete.chkCopTodas.Caption := 'Copiar alíquota selecionada para todos os fretes com CFOP ' + qryTabela.FieldByName('CLAFI1').AsString;
    frmEscolhePisCofinsFrete.cxgConsulta.DataController.DataSource := cdsAbrPis.dtsSource;

    Result := frmEscolhePisCofinsFrete.ShowModal = mrOk;

    If Result Then
    Begin
      qryTabela.Edit;
      qryTabela.FieldByName('ALQPIS').AsFloat  := cdsAbrPis.FieldByName('APC_ALQENT').AsFloat;
      qryTabela.FieldByName('BASPIS').AsFloat  := cdsAbrPis.FieldByName('APC_BASENT').AsFloat;
      qryTabela.FieldByName('AUTPIS').AsString := cdsAbrPis.FieldByName('AUTOINCREM').AsString;
      qryTabela.FieldByName('CSTPIS').AsString := cdsAbrPis.FieldByName('APC_CSTENT').AsString;


      qryTabela.Post;

      If frmEscolhePisCofinsFrete.chkCopTodas.Checked Then
        pReplicaAlqPis;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEntImpNFSe.fSelecionaAbreviacaoPis]');
    End;
  End;

  pFreeAndNil(frmEscolhePisCofinsFrete);
End;

Function TEntImpNFSe.fSelecionaAbreviacaoPisEntrada(strClaFis: String): Boolean;
Begin
  Try
    cdsAbrPis.Filter   := 'CLAFIS = ' + QuotedStr(strClaFis);
    cdsAbrPis.Filtered := True;

    If cdsAbrPis.IsEmpty Then
    Begin
      pMensagemOk('Nenhuma Abreviação de PIS cadastrada para a CFOP ' + strClaFis + '.' + #13#10 +
                  'Cadastre as Abreviações em Principal/ Manutenção de Cadastros/ Auxiliares/ Abreviação PIS !');
      Result := False;
      Exit;
    End;

    cdsAbrPis.Locate('AUTOINCREM', FAutPis, []);
    pCriarFormularios(TfrmEscolhePisCofinsFrete, frmEscolhePisCofinsFrete);
    frmEscolhePisCofinsFrete.Caption := 'Selecione a Alíquota de PIS';
    frmEscolhePisCofinsFrete.chkCopTodas.Visible := False;
    frmEscolhePisCofinsFrete.cxgConsulta.DataController.DataSource := cdsAbrPis.dtsSource;
    Result := frmEscolhePisCofinsFrete.ShowModal = mrOk;

    If Result Then
    Begin
      FAlqPis    := cdsAbrPis.FieldByName('APC_ALQENT').AsFloat;
      FPerBasPis := cdsAbrPis.FieldByName('APC_BASENT').AsFloat;
      FAutPis    := cdsAbrPis.FieldByName('AUTOINCREM').AsString;
      FCstPis    := cdsAbrPis.FieldByName('APC_CSTENT').AsString;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEntImpNFSe.fSelecionaAbreviacaoPis]');
    End;
  End;

  pFreeAndNil(frmEscolhePisCofinsFrete);
End;

Function TEntImpNFSe.fSelecionaAbreviacaoCofins: Boolean;
Begin
  Try
    cdsAbrCof.Filter   := 'CLAFIS = ' + QuotedStr(qryTabela.FieldByName('CLAFI1').AsString);
    cdsAbrCof.Filtered := True;

    If cdsAbrCof.IsEmpty Then
    Begin
      pMensagemOk('Nenhuma Abreviação de COFINS cadastrada para a CFOP ' + qryTabela.FieldByName('CLAFI1').AsString + '.' + #13#10 +
                  'Cadastre as Abreviações em Principal/ Manutenção de Cadastros/ Auxiliares/ Abreviação COFINS !');
      Result := False;
      Exit;
    End;

    cdsAbrCof.Locate('AUTOINCREM',  qryTabela.FieldByName('AUTCOF').AsString, []);
    pCriarFormularios(TfrmEscolhePisCofinsFrete, frmEscolhePisCofinsFrete);
    frmEscolhePisCofinsFrete.Caption := 'Selecione a Alíquota de COFINS';
    frmEscolhePisCofinsFrete.chkCopTodas.Caption := 'Copiar alíquota selecionada para todos os fretes com CFOP ' + qryTabela.FieldByName('CLAFI1').AsString;
    frmEscolhePisCofinsFrete.cxgConsulta.DataController.DataSource := cdsAbrCof.dtsSource;

    Result := frmEscolhePisCofinsFrete.ShowModal = mrOk;

    If Result Then
    Begin
      qryTabela.Edit;
      qryTabela.FieldByName('ALQCOF').AsFloat  := cdsAbrCof.FieldByName('APC_ALQENT').AsFloat;
      qryTabela.FieldByName('BASCOF').AsFloat  := cdsAbrCof.FieldByName('APC_BASENT').AsFloat;
      qryTabela.FieldByName('AUTCOF').AsString := cdsAbrCof.FieldByName('AUTOINCREM').AsString;
      qryTabela.FieldByName('CSTCOF').AsString := cdsAbrCof.FieldByName('APC_CSTENT').AsString;
//      If qryTabela.FieldByName('STATUS').AsInteger =  IMPORTADO_SEM_PISCOF Then
//        If (qryTabela.FieldByName('AUTPIS').AsString <> '') And (qryTabela.FieldByName('AUTCOF').AsString <> '') Then
//          qryTabela.FieldByName('STATUS').AsInteger := IMPORTADO_OK;
      qryTabela.Post;

      If frmEscolhePisCofinsFrete.chkCopTodas.Checked Then
        pReplicaAlqCof;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEntImpNFSe.fSelecionaAbreviacaoCofins]');
    End;
  End;

  pFreeAndNil(frmEscolhePisCofinsFrete);
End;

Function TEntImpNFSe.fSelecionaAbreviacaoCofinsEntrada(strClaFis: String): Boolean;
Begin
  Try
    cdsAbrCof.Filter   := 'CLAFIS = ' + QuotedStr(strClaFis);
    cdsAbrCof.Filtered := True;

    If cdsAbrCof.IsEmpty Then
    Begin
      pMensagemOk('Nenhuma Abreviação de COFINS cadastrada para a CFOP ' + strClaFis + '.' + #13#10 +
                  'Cadastre as Abreviações em Principal/ Manutenção de Cadastros/ Auxiliares/ Abreviação COFINS !');
      Result := False;
      Exit;
    End;

    cdsAbrCof.Locate('AUTOINCREM', FAutCof, []);
    pCriarFormularios(TfrmEscolhePisCofinsFrete, frmEscolhePisCofinsFrete);
    frmEscolhePisCofinsFrete.Caption := 'Selecione a Alíquota de COFINS';
    frmEscolhePisCofinsFrete.chkCopTodas.Visible := False;
    frmEscolhePisCofinsFrete.cxgConsulta.DataController.DataSource := cdsAbrCof.dtsSource;

    Result := frmEscolhePisCofinsFrete.ShowModal = mrOk;

    If Result Then
    Begin
      FAlqCof    := cdsAbrCof.FieldByName('APC_ALQENT').AsFloat;
      FPerBasCof := cdsAbrCof.FieldByName('APC_BASENT').AsFloat;
      FAutCof    := cdsAbrCof.FieldByName('AUTOINCREM').AsString;
      FCstCof    := cdsAbrPis.FieldByName('APC_CSTENT').AsString;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEntImpNFSe.fSelecionaAbreviacaoCofins]');
    End;
  End;

  pFreeAndNil(frmEscolhePisCofinsFrete);
End;

Function TEntImpNFSe.fInformarPisCofins: Boolean;
Begin
  Result := False;

  If Not blnUtiAbr Then
    Exit;

  If qryTabela.Locate('AUTPIS',  '', []) Then
  Begin
    pMensagemOk('Informe a Alíquota de PIS!');
    fSelecionaAbreviacaoPis;
    Result := True;
    Exit;
  End;

  If qryTabela.Locate('AUTCOF',  '', []) Then
  Begin
    pMensagemOk('Informe a Alíquota de Cofins!');
    fSelecionaAbreviacaoCofins;
    Result := True;
    Exit;
  End;

End;

Procedure TEntImpNFSe.pReplicaAlqPis;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.lblGravando.Caption := 'Atualizando alíquota de PIS, aguarde...';
    frmGravando.fExecutarAcao := fReplicaAlqPisPrg;
    frmGravando.ShowModal;


    pFreeAndNil(frmGravando);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TEntImpNFSe.pReplicaAlqPis]');
    End;
  End;

End;


Procedure TEntImpNFSe.pReplicaAlqCof;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Atualizando alíquota de COFINS, aguarde...';
    frmGravando.fExecutarAcao := fReplicaAlqCofPrg;
    frmGravando.ShowModal;

    pFreeAndNil(frmGravando);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TEntImpNFSe.pReplicaAlqCof]');
    End;
  End;
End;

Function TEntImpNFSe.fReplicaAlqPisPrg(prgProgresso: TCxProgressBar): Boolean;
  Var
    intRecNo: Integer;
    strCSTPIS,
    strAutInc: String;
    fltAlqPis,
    fltBasPis: Double;
Begin
  intRecNo := qryTabela.RecNo;

  Try
    Result := True;


    Begin
      qryTabela.DisableControls;

      strCSTPIS := qryTabela.FieldByName('CSTPIS').AsString;
      strAutInc := qryTabela.FieldByName('AUTPIS').AsString;
      fltAlqPis := qryTabela.FieldByName('ALQPIS').AsFloat;
      fltBasPis := qryTabela.FieldByName('BASPIS').AsFloat;

      qryTabela.Filter   := 'CLAFI1 = ' + QuotedStr(qryTabela.FieldByName('CLAFI1').AsString);
      qryTabela.Filtered := True;

      prgProgresso.Properties.Max := qryTabela.RecordCount;

      qryTabela.First;
      While Not qryTabela.Eof Do
      Begin
        qryTabela.Edit;
        qryTabela.FieldByName('AUTPIS').AsString := strAutInc;
        qryTabela.FieldByName('CSTPIS').AsString := strCSTPIS;
        qryTabela.FieldByName('ALQPIS').AsFloat  := fltAlqPis;
        qryTabela.FieldByName('BASPIS').AsFloat  := fltBasPis;
        qryTabela.Post;

        qryTabela.Next;

        prgProgresso.Position := prgProgresso.Position + 1;
        Application.ProcessMessages;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEntImpNFSe.fReplicaAlqPisPrg]');
    End;
  End;

  qryTabela.Filter   := '';
  qryTabela.Filtered := False;
  qryTabela.RecNo    := intRecNo;
  qryTabela.EnableControls;

End;

Function TEntImpNFSe.fReplicaAlqCofPrg(prgProgresso: TCxProgressBar): Boolean;
  Var
    intRecNo: Integer;
    strCstCof,
    strAutInc: String;
    fltAlqCof,
    fltBasCof: Double;
Begin
  intRecNo := qryTabela.RecNo;

  Try
    Result := True;
    qryTabela.DisableControls;

    strAutInc := qryTabela.FieldByName('AUTCOF').AsString;
    strCstCof := qryTabela.FieldByName('CSTCOF').AsString;
    fltAlqCof := qryTabela.FieldByName('ALQCOF').AsFloat;
    fltBasCof := qryTabela.FieldByName('BASCOF').AsFloat;

    qryTabela.Filter   := 'CLAFI1 = ' + QuotedStr(qryTabela.FieldByName('CLAFI1').AsString);
    qryTabela.Filtered := True;

    prgProgresso.Properties.Max := qryTabela.RecordCount;

    qryTabela.First;
    While Not qryTabela.Eof Do
    Begin
      qryTabela.Edit;
      qryTabela.FieldByName('AUTCOF').AsString := strAutInc;
      qryTabela.FieldByName('CSTCOF').AsString := strCstCof;
      qryTabela.FieldByName('ALQCOF').AsFloat  := fltAlqCof;
      qryTabela.FieldByName('BASCOF').AsFloat  := fltBasCof;
      qryTabela.Post;

      qryTabela.Next;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEntImpNFSe.fReplicaAlqCofPrg]');
    End;
  End;

  qryTabela.Filter   := '';
  qryTabela.Filtered := False;
  qryTabela.RecNo    := intRecNo;
  qryTabela.EnableControls;
End;

Function TEntImpNFSe.fVerificaAlqPisCofEntrada(strClaFis: String): Boolean;
Begin
  Result := True;

  If Not blnUtiAbr Then
    Exit;

  If fEmptyStr(FAutPis) Then
  Begin
    pMensagemOk('Informe a alíquota de PIS!');
    Result := fSelecionaAbreviacaoPisEntrada(strClaFis);
  End;

  If Result And fEmptyStr(FAutCof) Then
  Begin
    pMensagemOk('Informe a alíquota de COFINS!');
    Result := fSelecionaAbreviacaoCofinsEntrada(strClaFis);
  End;

End;

Function TEntImpNFSe.fCarregaAbreviacaoPisCof(strClaFis: String): Boolean;
Begin
  If (FListaClaFis.Count = 0) Or (FListaClaFis[0] <> strClaFis) And (strClaFis <> '') Then
  Begin
    FListaClaFis.Clear;
    FListaClaFis.Add(strClaFis);

    Result := fCarregaAbrevPisCof(False);

    If cdsAbrPis.Active And (cdsAbrPis.RecordCount = 1) Then
    Begin
      FAlqPis    := cdsAbrPis.FieldByName('APC_ALQENT').AsFloat;
      FPerBasPis := cdsAbrPis.FieldByName('APC_BASENT').AsFloat;
      FAutPis    := cdsAbrPis.FieldByName('AUTOINCREM').AsString;
      FCstPis    := cdsAbrPis.FieldByName('APC_CSTENT').AsString;
    End

    Else FAutPis := '';

    If cdsAbrCof.Active And (cdsAbrCof.RecordCount = 1) Then
    Begin
      FAlqCof    := cdsAbrCof.FieldByName('APC_ALQENT').AsFloat;
      FPerBasCof := cdsAbrCof.FieldByName('APC_BASENT').AsFloat;
      FAutCof    := cdsAbrCof.FieldByName('AUTOINCREM').AsString;
      FCstCof    := cdsAbrCof.FieldByName('APC_CSTENT').AsString;
    End

    Else FAutCof := '';

    If Not Result Then
      FListaClaFis.Clear;
  End

  Else Result := True;
End;

procedure TEntImpNFSe.pFiltraLog;
var strFiltro: String;
begin
  strFiltro := '';

  if blnArquivoComErro Then
    strFiltro := 'STATUS = ' + IntToStr(IMPORTADO_COM_ERRO);
  if blnErroGravarRegistro Then
    strFiltro := Iif(strFiltro <> '', strFiltro + ' OR ', '') + 'STATUS = ' + IntToStr(COM_ERRO_GRAVACAO);
  if blnDocumentoJaExiste Then
    strFiltro := Iif(strFiltro <> '', strFiltro + ' OR ', '') + 'STATUS = ' + IntToStr(DOCUMENTO_JA_EXISTE);
  If strFiltro = '' then
    strFiltro :=  'STATUS = ' + IntToStr(IMPORTADO_OK);

  strFiltro := ' IMPORT = '+QuotedStr('S') + ' OR (' + strFiltro +')';

  if strFiltro <> '' Then
  Begin
    qryTabela.Filtered := False;
    qryTabela.Filter := strFiltro;
    qryTabela.Filtered := True;
  End;
end;





{ TImpNFSe }

constructor TImpNFSe.Create;
begin
  FqryGeneric := fCriaQuery();
end;

destructor TImpNFSe.Destroy;
begin
  FreeAndNilQuery(FqryGeneric);
  inherited;
end;

function TImpNFSe.fAutIncCadFis(strAutIncCadFis: String): IImpNFSe;
begin
  Result := Self;
  FstrAutIncCadFis := strAutIncCadFis;
end;

function TImpNFSe.fCodEmp(strCodEmp: String): IImpNFSe;
begin
  Result := Self;
  FstrCodEmp := strCodEmp;
end;

function TImpNFSe.fExecute: IImpNFSe;
begin
  Result := Self;
  FblnImportado := False;
  FqryGeneric.SQL.Add(fGetSQL);
  FqryGeneric.ParamByName('AUTOINCREM').Value := fRetAutoIncrem('CADNFS', FstrCodEmp);
  FqryGeneric.ParamByName('NFS_SEQGER').Value := FstrautincCadFis;
  FqryGeneric.ParamByName('NFS_CODEMP').Value := FstrCodEmp;
  FqryGeneric.ParamByName('NFS_ARQXML').Value := FobjNFSe.fXMLToText;
  FqryGeneric.ExecSQL;
  FblnImportado := True;
end;

function TImpNFSe.fImportado: Boolean;
begin
  Result := FblnImportado;
end;

function TImpNFSe.fNFSe(objNFSe: INFSe): IImpNFSe;
begin
  Result := Self;
  FObjNFSe := objNFSe;
end;

class function TImpNFSe.New: IImpNFSe;
begin
  Result := TImpNFSe.Create;
end;

function TImpNFSe.fGetSQL: String;
Var
  strSQL: TStringBuilder;
Begin
  strSQL := TStringBuilder.Create;
  Try
    strSQL
      .Append('')
      .Append('INSERT INTO CADNFS')
      .Append('(')
      .Append('  AUTOINCREM,')
      .Append('  NFS_SEQGER,')
      .Append('  NFS_CODEMP,')
      .Append('  NFS_PRECGC,')
      .Append('  NFS_PREPES,')
      .Append('  NFS_PREIES,')
      .Append('  NFS_PREIMN,')
      .Append('  NFS_PRENOM,')
      .Append('  NFS_PREEND,')
      .Append('  NFS_PREBAI,')
      .Append('  NFS_PRECEP,')
      .Append('  NFS_PRECID,')
      .Append('  NFS_PREUF_,')
      .Append('  NFS_PREEMA,')
      .Append('  NFS_DESEXT,')
      .Append('  NFS_DESCGC,')
      .Append('  NFS_DESPES,')
      .Append('  NFS_DESIES,')
      .Append('  NFS_DESIMN,')
      .Append('  NFS_DESNOM,')
      .Append('  NFS_DESEND,')
      .Append('  NFS_DESNUM,')
      .Append('  NFS_PRENUM,')
      .Append('  NFS_DESCPL,')
      .Append('  NFS_DESBAI,')
      .Append('  NFS_DESCEP,')
      .Append('  NFS_DESCID,')
      .Append('  NFS_DESUF_,')
      .Append('  NFS_DESPAI,')
      .Append('  NFS_DESFON,')
      .Append('  NFS_DESEMA,')
      .Append('  NFS_NUMDOC,')
      .Append('  NFS_SERIE_,')
      .Append('  NFS_VALDOC,')
      .Append('  NFS_VALDED,')
      .Append('  NFS_VALSRV,')
      .Append('  NFS_DTADOC,')
      .Append('  NFS_FORPAG,')
      .Append('  NFS_DESCRI,')
      .Append('  NFS_CODSRV,')
      .Append('  NFS_CANCEL,')
      .Append('  NFS_REGIME,')
      .Append('  NFS_ISSRET,')
      .Append('  NFS_ALIISS,')
      .Append('  NFS_VALISS,')
      .Append('  NFS_BASPIS,')
      .Append('  NFS_ALIPIS,')
      .Append('  NFS_VALPIS,')
      .Append('  NFS_BASCOF,')
      .Append('  NFS_ALICOF,')
      .Append('  NFS_VALCOF,')
      .Append('  NFS_BASIRR,')
      .Append('  NFS_ALIIRR,')
      .Append('  NFS_VALIRR,')
      .Append('  NFS_BASCSL,')
      .Append('  NFS_ALICSL,')
      .Append('  NFS_VALCSL,')
      .Append('  NFS_BASINS,')
      .Append('  NFS_ALIINS,')
      .Append('  NFS_VALINS,')
      .Append('  NFS_AVULSA,')
      .Append('  NFS_SISGER,')
      .Append('  NFS_SERRPS,')
      .Append('  NFS_NUMRPS,')
      .Append('  NFS_CODIGO,')
      .Append('  NFS_ARQXML')
      .Append(')')
      .Append('VALUES ')
      .Append('(')
      .Append('  :AUTOINCREM,')
      .Append('  :NFS_SEQGER,')
      .Append('  :NFS_CODEMP,')
      .Append('  :NFS_PRECGC,')
      .Append('  :NFS_PREPES,')
      .Append('  :NFS_PREIES,')
      .Append('  :NFS_PREIMN,')
      .Append('  :NFS_PRENOM,')
      .Append('  :NFS_PREEND,')
      .Append('  :NFS_PREBAI,')
      .Append('  :NFS_PRECEP,')
      .Append('  :NFS_PRECID,')
      .Append('  :NFS_PREUF_,')
      .Append('  :NFS_PREEMA,')
      .Append('  :NFS_DESEXT,')
      .Append('  :NFS_DESCGC,')
      .Append('  :NFS_DESPES,')
      .Append('  :NFS_DESIES,')
      .Append('  :NFS_DESIMN,')
      .Append('  :NFS_DESNOM,')
      .Append('  :NFS_DESEND,')
      .Append('  :NFS_DESNUM,')
      .Append('  :NFS_PRENUM,')
      .Append('  :NFS_DESCPL,')
      .Append('  :NFS_DESBAI,')
      .Append('  :NFS_DESCEP,')
      .Append('  :NFS_DESCID,')
      .Append('  :NFS_DESUF_,')
      .Append('  :NFS_DESPAI,')
      .Append('  :NFS_DESFON,')
      .Append('  :NFS_DESEMA,')
      .Append('  :NFS_NUMDOC,')
      .Append('  :NFS_SERIE_,')
      .Append('  :NFS_VALDOC,')
      .Append('  :NFS_VALDED,')
      .Append('  :NFS_VALSRV,')
      .Append('  :NFS_DTADOC,')
      .Append('  :NFS_FORPAG,')
      .Append('  :NFS_DESCRI,')
      .Append('  :NFS_CODSRV,')
      .Append('  :NFS_CANCEL,')
      .Append('  :NFS_REGIME,')
      .Append('  :NFS_ISSRET,')
      .Append('  :NFS_ALIISS,')
      .Append('  :NFS_VALISS,')
      .Append('  :NFS_BASPIS,')
      .Append('  :NFS_ALIPIS,')
      .Append('  :NFS_VALPIS,')
      .Append('  :NFS_BASCOF,')
      .Append('  :NFS_ALICOF,')
      .Append('  :NFS_VALCOF,')
      .Append('  :NFS_BASIRR,')
      .Append('  :NFS_ALIIRR,')
      .Append('  :NFS_VALIRR,')
      .Append('  :NFS_BASCSL,')
      .Append('  :NFS_ALICSL,')
      .Append('  :NFS_VALCSL,')
      .Append('  :NFS_BASINS,')
      .Append('  :NFS_ALIINS,')
      .Append('  :NFS_VALINS,')
      .Append('  :NFS_AVULSA,')
      .Append('  :NFS_SISGER,')
      .Append('  :NFS_SERRPS,')
      .Append('  :NFS_NUMRPS,')
      .Append('  :NFS_CODIGO,')
      .Append('  :NFS_ARQXML')
      .Append(');')
  Finally
    Result := strSQL.ToString;
    FreeAndNil(strSQL);
  End;
End;

function TEntImpNFSe.fGraCTP(blnGraCTP: Boolean): TEntImpNFSe;
Begin
  Result := Self;
  FblnGraCTP := blnGraCTP;
End;

function TEntImpNFSe.fPorBai(strPorBai: String): TEntImpNFSe;
Begin
  Result := Self;
  FstrPorBai := strPorBai;
End;

function TEntImpNFSe.fCodEve(strCodEve: String): TEntImpNFSe;
Begin
  Result := Self;
  FstrCodEve := strCodEve;
End;

function TEntImpNFSe.fCodCta(strCodCta: String): TEntImpNFSe;
Begin
  Result := Self;
  FstrCodCta := strCodCta;
End;

function TEntImpNFSe.fCndVaz(strCndVaz: String): TEntImpNFSe;
Begin
  Result := Self;
  FstrCndVaz := strCndVaz;
End;

function TEntImpNFSe.fDtaEnt(strDtaEnt: TDate): TEntImpNFSe;
Begin
  Result := Self;
  FdtaDtaEnt := strDtaEnt;
End;

function TEntImpNFSe.fGerarHistoricoCTP: String;
Begin
  Result := '';
  If (fCfgSis('HISCTP', varBoolean)) Then
  Begin
    Result := 'REF. LANCAMENTO DE NOTA FISCAL DE SERVIÇO ' + FNumDoc + '-' + FEspDoc;
    Result := Result + ' DTA. EMISSÃO: ' + DateToStr(FDtaDoc) +
                                   ' CLIENTE/FORNECEDOR: ' + FNomFor + ' - ' +
                                   ' DOCUMENTO: ' + FNumDoc +  ' - ' +
                                                   FEspDoc +  ' - ' +
                                                   FCodEmp;
  End;
End;

procedure TEntImpNFSe.pMontaSQLMovDet(qryComand: TUniQuery; strMovGerAutInc: String);
var strAutIncMovDet: String;
begin
  strAutIncMovDet := fRetAutoIncrem('MOVDET',VS_StrCodEmp);
  qryComand.SQL.Clear;
  qryComand.SQL.Add('INSERT INTO MOVDET (');
  qryComand.SQL.Add('            DET_SEQGER,');
  qryComand.SQL.Add('            AUTOINCREM,');
  qryComand.SQL.Add('            DET_CODEMP,');
  qryComand.SQL.Add('            DET_CODVEN,');
  qryComand.SQL.Add('            DET_CODITE,');
  qryComand.SQL.Add('            DET_CODDIV,');
  qryComand.SQL.Add('            DET_CODMAR,');
  qryComand.SQL.Add('            DET_CODFOR,');
  qryComand.SQL.Add('            DET_CODCLI,');
  qryComand.SQL.Add('            DET_NUMDOC,');
  qryComand.SQL.Add('            DET_ESPDOC,');
  qryComand.SQL.Add('            DET_SERIE_,');
  qryComand.SQL.Add('            DET_DTAENT,');
  qryComand.SQL.Add('            DET_HORENT,');
  qryComand.SQL.Add('            DET_DTADOC,');
  qryComand.SQL.Add('            DET_CONPAG,');
  qryComand.SQL.Add('            DET_TIP_FC,');
  qryComand.SQL.Add('            DET_ESTADO,');
  qryComand.SQL.Add('            DET_DESCRI,');
  qryComand.SQL.Add('            DET_REFERE,');
  qryComand.SQL.Add('            DET_UNIDAD,');
  qryComand.SQL.Add('            DET_FORITE,');
  qryComand.SQL.Add('            DET_QTDITE,');
  qryComand.SQL.Add('            DET_UNITAR,');
  qryComand.SQL.Add('            DET_UNIORI,');
  qryComand.SQL.Add('            DET_UNIDIG,');
  qryComand.SQL.Add('            DET_TOTITE,');
  qryComand.SQL.Add('            DET_VLRCON,');
  qryComand.SQL.Add('            DET_TOTCUS,');
  qryComand.SQL.Add('            DET_TOTMED,');
  qryComand.SQL.Add('            DET_DESCON,');
  qryComand.SQL.Add('            DET_TOTFRE,');
  qryComand.SQL.Add('            DET_DESESP,');
  qryComand.SQL.Add('            DET_DESACE,');
  qryComand.SQL.Add('            DET_CODREP,');
  qryComand.SQL.Add('            DET_COMREP,');
  qryComand.SQL.Add('            DET_PERREP,');
  qryComand.SQL.Add('            DET_PERCOM,');
  qryComand.SQL.Add('            DET_TOTCOM,');
  qryComand.SQL.Add('            DET_CLAFIS,');
  qryComand.SQL.Add('            DET_CODFIS,');
  qryComand.SQL.Add('            DET_VALIPI,');
  qryComand.SQL.Add('            DET_ALQIPI,');
  qryComand.SQL.Add('            DET_BASIPI,');
  qryComand.SQL.Add('            DET_VALICM,');
  qryComand.SQL.Add('            DET_ALQICM,');
  qryComand.SQL.Add('            DET_BASICM,');
  qryComand.SQL.Add('            DET_VALRET,');
  qryComand.SQL.Add('            DET_ALQRET,');
  qryComand.SQL.Add('            DET_BASRET,');
  qryComand.SQL.Add('            DET_TOTPES,');
  qryComand.SQL.Add('            DET_PERBAS,');
  qryComand.SQL.Add('            DET_PERRED,');
  qryComand.SQL.Add('            DET_JAFATU,');
  qryComand.SQL.Add('            DET_TIPFAT,');
  qryComand.SQL.Add('            DET_NUMFAT,');
  qryComand.SQL.Add('            DET_DTAFAT,');
  qryComand.SQL.Add('            DET_VENFAT,');
  qryComand.SQL.Add('            DET_CNDFAT,');
  qryComand.SQL.Add('            DET_VALFAT,');
  qryComand.SQL.Add('            DET_IDEPRO,');
  qryComand.SQL.Add('            DET_INCPIS,');
  qryComand.SQL.Add('            DET_NOTESP,');
  qryComand.SQL.Add('            DET_DOCDEV,');
  qryComand.SQL.Add('            DET_ESPDEV,');
  qryComand.SQL.Add('            DET_EMPDEV,');
  qryComand.SQL.Add('            DET_ITETIN,');
  qryComand.SQL.Add('            DET_ITECHA,');
  qryComand.SQL.Add('            DET_DESCOR,');
  qryComand.SQL.Add('            DET_TIPEMB,');
  qryComand.SQL.Add('            DET_QTDEMB,');
  qryComand.SQL.Add('            DET_PREEMB,');
  qryComand.SQL.Add('            DET_TIPPRE,');
  qryComand.SQL.Add('            DET_PRVTIN,');
  qryComand.SQL.Add('            DET_PRCTIN,');
  qryComand.SQL.Add('            DET_FATTIN,');
  qryComand.SQL.Add('            DET_PROEMB,');
  qryComand.SQL.Add('            DET_CODDIG,');
  qryComand.SQL.Add('            DET_CODCND,');
  qryComand.SQL.Add('            DET_CODFPG,');
  qryComand.SQL.Add('            DET_ITEEMB,');
  qryComand.SQL.Add('            DET_LAZQUA,');
  qryComand.SQL.Add('            DET_PROMOC,');
  qryComand.SQL.Add('            DET_CODVE2,');
  qryComand.SQL.Add('            DET_TOTCO2,');
  qryComand.SQL.Add('            DET_SEQTIN,');
  qryComand.SQL.Add('            DET_QTDPUL,');
  qryComand.SQL.Add('            DET_PEDCOM,');
  qryComand.SQL.Add('            DET_ORIDOC,');
  qryComand.SQL.Add('            DET_IMPRES,');
  qryComand.SQL.Add('            DET_QTDROM,');
  qryComand.SQL.Add('            DET_NUM_PD,');
  qryComand.SQL.Add('            DET_ESP_PD,');
  qryComand.SQL.Add('            DET_EMP_PD,');
  qryComand.SQL.Add('            DET_IND_PD,');
  qryComand.SQL.Add('            DET_ORDPRO,');
  qryComand.SQL.Add('            DET_TMPGAR,');
  qryComand.SQL.Add('            DET_DESCFF,');
  qryComand.SQL.Add('            DET_DESNES,');
  qryComand.SQL.Add('            DET_CLIFAT,');
  qryComand.SQL.Add('            DET_EMPFAT,');
  qryComand.SQL.Add('            DET_BCAMIN,');
  qryComand.SQL.Add('            DET_BCACOM,');
  qryComand.SQL.Add('            DET_VOLPRO,');
  qryComand.SQL.Add('            DET_DTABCA,');
  qryComand.SQL.Add('            DET_CODACA,');
  qryComand.SQL.Add('            DET_EMPACA,');
  qryComand.SQL.Add('            DET_QTDENT,');
  qryComand.SQL.Add('            DET_DOCFUT,');
  qryComand.SQL.Add('            DET_ESPFUT,');
  qryComand.SQL.Add('            DET_EMPFUT,');
  qryComand.SQL.Add('            DET_FILKAR,');
  qryComand.SQL.Add('            DET_PROACA,');
  qryComand.SQL.Add('            DET_TABPRE,');
  qryComand.SQL.Add('            DET_EMPCOM,');
  qryComand.SQL.Add('            DET_SEGURO,');
  qryComand.SQL.Add('            DET_LINLIN,');
  qryComand.SQL.Add('            DET_CATALI,');
  qryComand.SQL.Add('            DET_CODDIL,');
  qryComand.SQL.Add('            DET_PORDIL,');
  qryComand.SQL.Add('            DET_DILCON,');
  qryComand.SQL.Add('            DET_PORCAT,');
  qryComand.SQL.Add('            DET_QTDPON,');
  qryComand.SQL.Add('            DET_ENTFUT,');
  qryComand.SQL.Add('            DET_MOTFUT,');
  qryComand.SQL.Add('            DET_DTAFUT,');
  qryComand.SQL.Add('            DET_QTDEFT,');
  qryComand.SQL.Add('            DET_DTAEFT,');
  qryComand.SQL.Add('            DET_TOTCU2,');
  qryComand.SQL.Add('            DET_BAIEMP,');
  qryComand.SQL.Add('            DET_KEY_EP,');
  qryComand.SQL.Add('            DET_NUMLOT,');
  qryComand.SQL.Add('            DET_FUNEXP,');
  qryComand.SQL.Add('            DET_PIGBAS,');
  qryComand.SQL.Add('            DET_BAEIPI,');
  qryComand.SQL.Add('            DET_ALEIPI,');
  qryComand.SQL.Add('            DET_VAEIPI,');
  qryComand.SQL.Add('            DET_EFBAIX,');
  qryComand.SQL.Add('            DET_ALQIVA,');
  qryComand.SQL.Add('            DET_VLIVA0,');
  qryComand.SQL.Add('            DET_VLIVA5,');
  qryComand.SQL.Add('            DET_VIVA10)');
  qryComand.SQL.Add('(SELECT ');
  qryComand.SQL.Add(' "' + strMovGerAutInc + '",  ');                           {DET_SEQGER}
  qryComand.SQL.Add(' "' + strAutIncMovDet + '",  ');                           {AUTOINCREM}
  qryComand.SQL.Add(' FIS_CODEMP,    ');                                        {DET_CODEMP}
  qryComand.SQL.Add(' "' + strLoginUsuarioLogado + '",');                       {DET_CODVEN}
  qryComand.SQL.Add(' ITE_CODITE, ');                                           {DET_CODITE}
  qryComand.SQL.Add(' NULL, ');                                                 {DET_CODDIV}
  qryComand.SQL.Add(' ITE_CODMAR, ');                                           {DET_CODMAR}
  qryComand.SQL.Add(' "'+FCodFor+'", ');                                 {DET_CODFOR}
  qryComand.SQL.Add(' NULL, ');                                                 {DET_CODCLI}
  qryComand.SQL.Add(' FIS_NUMDOC, ');                                           {DET_NUMDOC}
  qryComand.SQL.Add(' FIS_ESPDOC, ');                                           {DET_ESPDOC}
  qryComand.SQL.Add(' FIS_SERIE_, ');                                           {DET_SERIE_}
  qryComand.SQL.Add(' FIS_DTAENT, ');                                           {DET_DTAENT}
  qryComand.SQL.Add(' "' + FormatDateTime('hh:mm:ss', fNow) + '",');            {DET_HORENT}
  qryComand.SQL.Add(' FIS_DTADOC, ');                                           {DET_DTADOC}
  qryComand.SQL.Add(' "01000", ');                                              {DET_CONPAG}
  qryComand.SQL.Add(' "F", ');                                                  {DET_TIP_FC}
  qryComand.SQL.Add(' "",  ');                                                  {DET_ESTADO}
  qryComand.SQL.Add(' ITE_DESITE, ');                                           {DET_DESCRI}
  qryComand.SQL.Add(' IFNULL(ITE_REFERE, ""), ');                               {DET_REFERE}
  qryComand.SQL.Add(' ITE_CODUNI,  ');                                          {DET_UNIDAD}
  qryComand.SQL.Add(' ITE_CODFOR,  ');                                          {DET_FORITE}
  qryComand.SQL.Add(' 1.00, ');                                                 {DET_QTDITE}
  qryComand.SQL.Add(' FIS_VLCON1, ');                                           {DET_UNITAR}
  qryComand.SQL.Add(' FIS_VLCON1, ');                                           {DET_UNIORI}
  qryComand.SQL.Add(' FIS_VLCON1, ');                                           {DET_UNIDIG}
  qryComand.SQL.Add(' FIS_VLCON1, ');                                           {DET_TOTITE}
  qryComand.SQL.Add(' FIS_VLCON1, ');                                           {DET_VLRCON}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_TOTCUS}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_TOTMED}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_DESCON}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_TOTFRE}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_DESESP}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_DESACE}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_CODREP}
  qryComand.SQL.Add(' 0.00, ');                                                 {DET_COMREP}
  qryComand.SQL.Add(' 0.00, ');                                                 {DET_PERREP}
  qryComand.SQL.Add(' 0.00, ');                                                 {DET_PERCOM}
  qryComand.SQL.Add(' 0.00, ');                                                 {DET_TOTCOM}
  qryComand.SQL.Add(' FIS_CLFSC1, ');                                           {DET_CLAFIS}
  qryComand.SQL.Add(' "090",     ');                                            {DET_CODFIS}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_VALIPI}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_ALQIPI}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_BASIPI}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_VALICM}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_ALQICM}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_BASICM}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_VALRET}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_ALQRET}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_BASRET}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_TOTPES}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_PERBAS}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_PERRED}
  qryComand.SQL.Add(' 0,         ');                                            {DET_JAFATU}
  qryComand.SQL.Add(' "",        ');                                            {DET_TIPFAT}
  qryComand.SQL.Add(' "",        ');                                            {DET_NUMFAT}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_DTAFAT}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_VENFAT}
  qryComand.SQL.Add(' "",        ');                                            {DET_CNDFAT}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_VALFAT}
  qryComand.SQL.Add(' "NOR",     ');                                            {DET_IDEPRO}
  qryComand.SQL.Add(' "S",       ');                                            {DET_INCPIS}
  qryComand.SQL.Add(' "N",       ');                                            {DET_NOTESP}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_DOCDEV}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_ESPDEV}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_EMPDEV}
  qryComand.SQL.Add(' "",        ');                                            {DET_ITETIN}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_ITECHA}
  qryComand.SQL.Add(' "",        ');                                            {DET_DESCOR}
  qryComand.SQL.Add(' "",        ');                                            {DET_TIPEMB}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_QTDEMB}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_PREEMB}
  qryComand.SQL.Add(' "",        ');                                            {DET_TIPPRE}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_PRVTIN}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_PRCTIN}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_FATTIN}
  qryComand.SQL.Add(' "",        ');                                            {DET_PROEMB}
  qryComand.SQL.Add('  "'+strLoginUsuarioLogado+'",');                          {DET_CODDIG}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_CODCND}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_CODFPG}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_ITEEMB}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_LAZQUA}
  qryComand.SQL.Add(' "N",       ');                                            {DET_PROMOC}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_CODVE2}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_TOTCO2}
  qryComand.SQL.Add(' "",        ');                                            {DET_SEQTIN}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_QTDPUL}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_PEDCOM}
  qryComand.SQL.Add(' FIS_ORIDOC, ');                                           {DET_ORIDOC}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_IMPRES}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_QTDROM}
  qryComand.SQL.Add(' "",        ');                                            {DET_NUM_PD}
  qryComand.SQL.Add(' "",        ');                                            {DET_ESP_PD}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_EMP_PD}
  qryComand.SQL.Add(' 0,         ');                                            {DET_IND_PD}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_ORDPRO}
  qryComand.SQL.Add(' 0,         ');                                            {DET_TMPGAR}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_DESCFF}
  qryComand.SQL.Add(' "",        ');                                            {DET_DESNES}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_CLIFAT}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_EMPFAT}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_BCAMIN}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_BCACOM}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_VOLPRO}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_DTABCA}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_CODACA}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_EMPACA}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_QTDENT}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_DOCFUT}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_ESPFUT}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_EMPFUT}
  qryComand.SQL.Add(' 1   ,      ');                                            {DET_FILKAR}
  qryComand.SQL.Add(' "N",       ');                                            {DET_PROACA}
  qryComand.SQL.Add(' "",        ');                                            {DET_TABPRE}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_EMPCOM}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_SEGURO}
  qryComand.SQL.Add(' "",        ');                                            {DET_LINLIN}
  qryComand.SQL.Add(' "",        ');                                            {DET_CATALI}
  qryComand.SQL.Add(' "",        ');                                            {DET_CODDIL}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_PORDIL}
  qryComand.SQL.Add(' "",        ');                                            {DET_DILCON}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_PORCAT}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_QTDPON}
  qryComand.SQL.Add(' "N",       ');                                            {DET_ENTFUT}
  qryComand.SQL.Add(' "",        ');                                            {DET_MOTFUT}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_DTAFUT}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_QTDEFT}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_DTAEFT}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_TOTCU2}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_BAIEMP}
  qryComand.SQL.Add(' "",        ');                                            {DET_KEY_EP}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_NUMLOT}
  qryComand.SQL.Add(' "N",       ');                                            {DET_FUNEXP}
  qryComand.SQL.Add(' "N",       ');                                            {DET_PIGBAS}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_BAEIPI}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_ALEIPI}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_VAEIPI}
  qryComand.SQL.Add(' "N",       ');                                            {DET_EFBAIX}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_ALQIVA}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_VLIVA0}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_VLIVA5}
  qryComand.SQL.Add(' 0.00       ');                                            {DET_VIVA10}

  qryComand.SQL.Add('  FROM CADFIS ');
  qryComand.SQL.Add('  LEFT JOIN CADITE ON ITE_CODITE = "' + fCfgSis('ITESER') + '"');
  qryComand.SQL.Add('  WHERE CADFIS.FIS_NUMDOC = "'+FNumDoc+'" ');
  qryComand.SQL.Add('    AND CADFIS.FIS_ESPDOC = "'+FEspDoc+'" ');
  qryComand.SQL.Add('    AND CADFIS.FIS_CODEMP = "'+FCodEmp+'" ');
  qryComand.SQL.Add('    AND CADFIS.FIS_FORCLI = "'+FCodFor+'" ');
  qryComand.SQL.Add('    AND IFNULL(CADFIS.FIS_SERIE_, "") = "'+FSerie_+'");');
  qryComand.SQL.Add(' INSERT INTO MOVTRI ( ');
  qryComand.SQL.Add(' DET_SEQGER,  ');
  qryComand.SQL.Add(' DET_CSTPIS,  ');
  qryComand.SQL.Add(' DET_BASPIS,  ');
  qryComand.SQL.Add(' DET_ALQPIS,  ');
  qryComand.SQL.Add(' DET_VALPIS,  ');
  qryComand.SQL.Add(' DET_NR_PIS,  ');
  qryComand.SQL.Add(' DET_CSTCOF,  ');
  qryComand.SQL.Add(' DET_BASCOF,  ');
  qryComand.SQL.Add(' DET_ALQCOF,  ');
  qryComand.SQL.Add(' DET_VALCOF,  ');
  qryComand.SQL.Add(' DET_NR_COF,  ');
  qryComand.SQL.Add(' DET_NATOPE)  ');
  qryComand.SQL.Add(' (SELECT      ');
  qryComand.SQL.Add(' "' + strAutIncMovDet + '",  ');
  qryComand.SQL.Add(' FIS_CSTPIS, ');
  qryComand.SQL.Add(' FIS_BASPIS, ');
  qryComand.SQL.Add(' FIS_ALQPIS, ');
  qryComand.SQL.Add(' FIS_TOTPIS, ');
  qryComand.SQL.Add(' FIS_NR_PIS, ');
  qryComand.SQL.Add(' FIS_CSTCOF, ');
  qryComand.SQL.Add(' FIS_BASCOF, ');
  qryComand.SQL.Add(' FIS_ALQCOF, ');
  qryComand.SQL.Add(' FIS_TOTCOF, ');
  qryComand.SQL.Add(' FIS_NR_COF, ');
  qryComand.SQL.Add(' FIS_NATOPE  ');
  qryComand.SQL.Add('  FROM CADFIS ');
  qryComand.SQL.Add('  WHERE CADFIS.FIS_NUMDOC = "'+FNumDoc+'" ');
  qryComand.SQL.Add('    AND CADFIS.FIS_ESPDOC = "'+FEspDoc+'" ');
  qryComand.SQL.Add('    AND CADFIS.FIS_CODEMP = "'+FCodEmp+'" ');
  qryComand.SQL.Add('    AND CADFIS.FIS_FORCLI = "'+FCodFor+'" ');
  qryComand.SQL.Add('    AND IFNULL(CADFIS.FIS_SERIE_, "") = "'+FSerie_+'");');
  qryComand.ExecSQL;

  qryComand.SQL.Clear;
  qryComand.SQL.Add('INSERT INTO MOVREF (');
  qryComand.SQL.Add('REF_SEQGER,');
  qryComand.SQL.Add('REF_CODCST,');
  qryComand.SQL.Add('REF_CLATRI,');
  qryComand.SQL.Add('REF_BASCAL,');
  qryComand.SQL.Add('REF_CBSALQ,');
  qryComand.SQL.Add('REF_CBSALE,');
  qryComand.SQL.Add('REF_CBSVAL,');
  qryComand.SQL.Add('REF_IBSUFA,');
  qryComand.SQL.Add('REF_IBSUFE,');
  qryComand.SQL.Add('REF_IBSUFV,');
  qryComand.SQL.Add('REF_IBSMNA,');
  qryComand.SQL.Add('REF_IBSMNE,');
  qryComand.SQL.Add('REF_IBSMNV,');
  qryComand.SQL.Add('REF_VALIBS,');
  qryComand.SQL.Add('REF_VALOPE');
  qryComand.SQL.Add(') VALUES (');
  qryComand.SQL.Add(' "' + strAutIncMovDet + '",  ');
  qryComand.SQL.Add(' "' + FstrCST + '",');
  qryComand.SQL.Add(' "' +FstrcClassTrib + '",');
  qryComand.SQL.Add(' "' + fFloatToSQL(FcurvBC) + '",' );
  qryComand.SQL.Add(' "' + fFloatToSQL(FfloFpCBS) + '",');
  qryComand.SQL.Add(' "' + fFloatToSQL(FfloFpAliqEfetCBS) + '",');
  qryComand.SQL.Add(' "' + fFloatToSQL(FcurvCBS) + '",');
  qryComand.SQL.Add(' "' + fFloatToSQL(FdobpIBSUF) + '",');
  qryComand.SQL.Add(' "' + fFloatToSQL(FdobpAliqEfetUF) + '",');
  qryComand.SQL.Add(' "' + fFloatToSQL(FcurvIBSUF) + '",');
  qryComand.SQL.Add(' "' + fFloatToSQL(FdobpIBSMun) + '",');
  qryComand.SQL.Add(' "' + fFloatToSQL(FdobFpAliqEfetMun) + '",' );
  qryComand.SQL.Add(' "' + fFloatToSQL(FcurvIBSMun) + '",');
  qryComand.SQL.Add(' "' + FloatToStr(FcurvIBSTot) + '",');
  qryComand.SQL.Add(' "' + fFloatToSQL(FcurvTotNF) + '"');
  qryComand.SQL.Add(');');
  qryComand.ExecSQL;
End;

procedure TEntImpNFSe.pMontaSQLMovGer(qryComand: TUniQuery; strMovGerAutInc: String);
begin
    qryComand.SQL.Clear;
    qryComand.SQL.Add('INSERT INTO MOVGER (');
    qryComand.SQL.Add('            AUTOINCREM,');
    qryComand.SQL.Add('            GER_CODEMP,');
    qryComand.SQL.Add('            GER_NUMDOC,');
    qryComand.SQL.Add('            GER_ESPDOC,');
    qryComand.SQL.Add('            GER_CODVEN,');
    qryComand.SQL.Add('            GER_CODTRA,');
    qryComand.SQL.Add('            GER_CODFOR,');
    qryComand.SQL.Add('            GER_CODCLI,');
    qryComand.SQL.Add('            GER_TIP_FC,');
    qryComand.SQL.Add('            GER_SERIE_,');
    qryComand.SQL.Add('            GER_DTAENT,');
    qryComand.SQL.Add('            GER_HORENT,');
    qryComand.SQL.Add('            GER_DTADOC,');
    qryComand.SQL.Add('            GER_CONPAG,');
    qryComand.SQL.Add('            GER_ESTADO,');
    qryComand.SQL.Add('            GER_NOMCON,');
    qryComand.SQL.Add('            GER_ENDCON,');
    qryComand.SQL.Add('            GER_BAICON,');
    qryComand.SQL.Add('            GER_CEPCON,');
    qryComand.SQL.Add('            GER_CIDCON,');
    qryComand.SQL.Add('            GER_ESTCON,');
    qryComand.SQL.Add('            GER_TELCON,');
    qryComand.SQL.Add('            GER_CGCCPF,');
    qryComand.SQL.Add('            GER_CGCCON,');
    qryComand.SQL.Add('            GER_IESCON,');
    qryComand.SQL.Add('            GER_EMLCON,');
    qryComand.SQL.Add('            GER_CLAFIS,');
    qryComand.SQL.Add('            GER_BASSIM,');
    qryComand.SQL.Add('            GER_BASIPI,');
    qryComand.SQL.Add('            GER_ALQIPI,');
    qryComand.SQL.Add('            GER_TOTIPI,');
    qryComand.SQL.Add('            GER_BASICM,');
    qryComand.SQL.Add('            GER_ALQICM,');
    qryComand.SQL.Add('            GER_TOTICM,');
    qryComand.SQL.Add('            GER_TOTRET,');
    qryComand.SQL.Add('            GER_ALQRET,');
    qryComand.SQL.Add('            GER_BASRET,');
    qryComand.SQL.Add('            GER_DESESP,');
    qryComand.SQL.Add('            GER_VLRCON,');
    qryComand.SQL.Add('            GER_TOTPRO,');
    qryComand.SQL.Add('            GER_TOTCUS,');
    qryComand.SQL.Add('            GER_TOTMED,');
    qryComand.SQL.Add('            GER_TIPFRE,');
    qryComand.SQL.Add('            GER_TOTFRE,');
    qryComand.SQL.Add('            GER_PESBRU,');
    qryComand.SQL.Add('            GER_PESLIQ,');
    qryComand.SQL.Add('            GER_VOLUME,');
    qryComand.SQL.Add('            GER_ESPECI,');
    qryComand.SQL.Add('            GER_MARCA_,');
    qryComand.SQL.Add('            GER_MEN001,');
    qryComand.SQL.Add('            GER_MEN002,');
    qryComand.SQL.Add('            GER_JAFATU,');
    qryComand.SQL.Add('            GER_TIPFAT,');
    qryComand.SQL.Add('            GER_NUMFAT,');
    qryComand.SQL.Add('            GER_DTAFAT,');
    qryComand.SQL.Add('            GER_VENFAT,');
    qryComand.SQL.Add('            GER_CNDFAT,');
    qryComand.SQL.Add('            GER_VALFAT,');
    qryComand.SQL.Add('            GER_VPAR01,');
    qryComand.SQL.Add('            GER_VPAR02,');
    qryComand.SQL.Add('            GER_VPAR03,');
    qryComand.SQL.Add('            GER_VPAR04,');
    qryComand.SQL.Add('            GER_VPAR05,');
    qryComand.SQL.Add('            GER_VPAR06,');
    qryComand.SQL.Add('            GER_VPAR07,');
    qryComand.SQL.Add('            GER_VPAR08,');
    qryComand.SQL.Add('            GER_VPAR09,');
    qryComand.SQL.Add('            GER_VPAR10,');
    qryComand.SQL.Add('            GER_VPAR11,');
    qryComand.SQL.Add('            GER_VPAR12,');
    qryComand.SQL.Add('            GER_NOTESP,');
    qryComand.SQL.Add('            GER_CODDIG,');
    qryComand.SQL.Add('            GER_PORDES,');
    qryComand.SQL.Add('            GER_R_GCON,');
    qryComand.SQL.Add('            GER_CODCND,');
    qryComand.SQL.Add('            GER_CODFPG,');
    qryComand.SQL.Add('            GER_FATNOT,');
    qryComand.SQL.Add('            GER_CODS01,');
    qryComand.SQL.Add('            GER_CODS02,');
    qryComand.SQL.Add('            GER_CODS03,');
    qryComand.SQL.Add('            GER_CODS04,');
    qryComand.SQL.Add('            GER_CODS05,');
    qryComand.SQL.Add('            GER_CODS06,');
    qryComand.SQL.Add('            GER_DESS01,');
    qryComand.SQL.Add('            GER_DESS02,');
    qryComand.SQL.Add('            GER_DESS03,');
    qryComand.SQL.Add('            GER_DESS04,');
    qryComand.SQL.Add('            GER_DESS05,');
    qryComand.SQL.Add('            GER_DESS06,');
    qryComand.SQL.Add('            GER_VALS01,');
    qryComand.SQL.Add('            GER_VALS02,');
    qryComand.SQL.Add('            GER_VALS03,');
    qryComand.SQL.Add('            GER_VALS04,');
    qryComand.SQL.Add('            GER_VALS05,');
    qryComand.SQL.Add('            GER_VALS06,');
    qryComand.SQL.Add('            GER_PRAENT,');
    qryComand.SQL.Add('            GER_TOTSER,');
    qryComand.SQL.Add('            GER_PERISS,');
    qryComand.SQL.Add('            GER_VALISS,');
    qryComand.SQL.Add('            GER_CLAFI2,');
    qryComand.SQL.Add('            GER_CLAFI3,');
    qryComand.SQL.Add('            GER_NATOPE,');
    qryComand.SQL.Add('            GER_DESACE,');
    qryComand.SQL.Add('            GER_ORIDOC,');
    qryComand.SQL.Add('            GER_DTAROM,');
    qryComand.SQL.Add('            GER_HORROM,');
    qryComand.SQL.Add('            GER_OPEROM,');
    qryComand.SQL.Add('            GER_NUMROM,');
    qryComand.SQL.Add('            GER_CONENT,');
    qryComand.SQL.Add('            GER_IMPRES,');
    qryComand.SQL.Add('            GER_CODREP,');
    qryComand.SQL.Add('            GER_VALROM,');
    qryComand.SQL.Add('            GER_ALQIRF,');
    qryComand.SQL.Add('            GER_VALIRF,');
    qryComand.SQL.Add('            GER_ALQPIS,');
    qryComand.SQL.Add('            GER_VALPIS,');
    qryComand.SQL.Add('            GER_ALQCOF,');
    qryComand.SQL.Add('            GER_VALCOF,');
    qryComand.SQL.Add('            GER_ALQCSL,');
    qryComand.SQL.Add('            GER_VALCSL,');
    qryComand.SQL.Add('            GER_IRFRET,');
    qryComand.SQL.Add('            GER_PISRET,');
    qryComand.SQL.Add('            GER_COFRET,');
    qryComand.SQL.Add('            GER_CSLRET,');
    qryComand.SQL.Add('            GER_SERRET,');
    qryComand.SQL.Add('            GER_NOTRET,');
    qryComand.SQL.Add('            GER_NORESE,');
    qryComand.SQL.Add('            GER_ALIRFP,');
    qryComand.SQL.Add('            GER_ALPISP,');
    qryComand.SQL.Add('            GER_ALCOFP,');
    qryComand.SQL.Add('            GER_ALCSLP,');
    qryComand.SQL.Add('            GER_PESGSO,');
    qryComand.SQL.Add('            GER_VLSGSO,');
    qryComand.SQL.Add('            GER_IRPRRT,');
    qryComand.SQL.Add('            GER_IRPRDV,');
    qryComand.SQL.Add('            GER_IRSERT,');
    qryComand.SQL.Add('            GER_IRSEDV,');
    qryComand.SQL.Add('            GER_PIPRRT,');
    qryComand.SQL.Add('            GER_PIPRDV,');
    qryComand.SQL.Add('            GER_PISERT,');
    qryComand.SQL.Add('            GER_PISEDV,');
    qryComand.SQL.Add('            GER_COPRRT,');
    qryComand.SQL.Add('            GER_COPRDV,');
    qryComand.SQL.Add('            GER_COSERT,');
    qryComand.SQL.Add('            GER_COSEDV,');
    qryComand.SQL.Add('            GER_CSPRRT,');
    qryComand.SQL.Add('            GER_CSPRDV,');
    qryComand.SQL.Add('            GER_CSSERT,');
    qryComand.SQL.Add('            GER_CSSEDV,');
    qryComand.SQL.Add('            GER_ORDPRO,');
    qryComand.SQL.Add('            GER_ROMIMP,');
    qryComand.SQL.Add('            GER_BASORG,');
    qryComand.SQL.Add('            GER_ICMORG,');
    qryComand.SQL.Add('            GER_NCONHE,');
    qryComand.SQL.Add('            GER_DESCFF,');
    qryComand.SQL.Add('            GER_RET_SP,');
    qryComand.SQL.Add('            GER_CONSUM,');
    qryComand.SQL.Add('            GER_MEN003,');
    qryComand.SQL.Add('            GER_MEN004,');
    qryComand.SQL.Add('            GER_MEN005,');
    qryComand.SQL.Add('            GER_ENTFAT,');
    qryComand.SQL.Add('            GER_CLIFAT,');
    qryComand.SQL.Add('            GER_EMPFAT,');
    qryComand.SQL.Add('            GER_OPEEXP,');
    qryComand.SQL.Add('            GER_SEPEXP,');
    qryComand.SQL.Add('            GER_OPLBRC,');
    qryComand.SQL.Add('            GER_DTLBRC,');
    qryComand.SQL.Add('            GER_HRLBRC,');
    qryComand.SQL.Add('            GER_TABPRE,');
    qryComand.SQL.Add('            GER_OPLBEX,');
    qryComand.SQL.Add('            GER_DTLBEX,');
    qryComand.SQL.Add('            GER_HRLBEX,');
    qryComand.SQL.Add('            GER_ENTFUT,');
    qryComand.SQL.Add('            GER_NUM_PR,');
    qryComand.SQL.Add('            GER_EMPROM,');
    qryComand.SQL.Add('            GER_MARGEM,');
    qryComand.SQL.Add('            GER_EMPORI,');
    qryComand.SQL.Add('            GER_BARTSP,');
    qryComand.SQL.Add('            GER_VLRTSP,');
    qryComand.SQL.Add('            GER_OPRFLJ,');
    qryComand.SQL.Add('            GER_SEGURO,');
    qryComand.SQL.Add('            GER_DTALAN,');
    qryComand.SQL.Add('            GER_NUMREG,');
    qryComand.SQL.Add('            GER_AUTSER,');
    qryComand.SQL.Add('            GER_DTENTR,');
    qryComand.SQL.Add('            GER_NROCEI,');
    qryComand.SQL.Add('            GER_CLAFI4,');
    qryComand.SQL.Add('            GER_TOEIPI,');
    qryComand.SQL.Add('            GER_ALEIPI,');
    qryComand.SQL.Add('            GER_BAEIPI,');
    qryComand.SQL.Add('            GER_CODEVE,');
    qryComand.SQL.Add('            GER_CODOCO,');
    qryComand.SQL.Add('            GER_VLIVA0,');
    qryComand.SQL.Add('            GER_VLIVA5,');
    qryComand.SQL.Add('            GER_VIVA10,');
    qryComand.SQL.Add('            GER_MENEXP,');
    qryComand.SQL.Add('            GER_MENEX2,');
    qryComand.SQL.Add('            GER_MENEX3,');
    qryComand.SQL.Add('            GER_MENEX4,');
    qryComand.SQL.Add('            GER_PRVIMP,');
    qryComand.SQL.Add('            GER_NROBOX');
    qryComand.SQL.Add('            )');
    qryComand.SQL.Add('(SELECT "' + strMovGerAutInc + '",');                    // AUTOINCREM
    qryComand.SQL.Add('        FIS_CODEMP,');                                  // GER_CODEMP
    qryComand.SQL.Add('        FIS_NUMDOC,');                                  // GER_NUMDOC
    qryComand.SQL.Add('        FIS_ESPDOC,');                                  // GER_ESPDOC
    qryComand.SQL.Add('        "'+strLoginUsuarioLogado+'",');                 // GER_CODVEN
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODTRA
    qryComand.SQL.Add('        FIS_FORCLI,');                                  // GER_CODFOR
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODCLI
    qryComand.SQL.Add('        "F",       ');                                  // GER_TIP_FC
    qryComand.SQL.Add('        FIS_SERIE_,');                                  // GER_SERIE_
    qryComand.SQL.Add('        FIS_DTAENT,');                                  // GER_DTAENT
    qryComand.SQL.Add('        "' + FormatDateTime('hh:mm:ss', fNow) + '",');  // GER_HORENT
    qryComand.SQL.Add('        FIS_DTADOC,');                                  // GER_DTADOC
    qryComand.SQL.Add('        "01000",   ');                                  // GER_CONPAG
    qryComand.SQL.Add('        "",        ');                                  // GER_ESTADO
    qryComand.SQL.Add('        NULL,      ');                                  // GER_NOMCON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_ENDCON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_BAICON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CEPCON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CIDCON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_ESTCON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_TELCON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CGCCPF
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CGCCON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_IESCON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_EMLCON
    qryComand.SQL.Add('        FIS_CLFSC1,');                                  // GER_CLAFIS
    qryComand.SQL.Add('        0.00,      ');                                  // GER_BASSIM
    qryComand.SQL.Add('        0.00,      ');                                  // GER_BASIPI
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALQIPI
    qryComand.SQL.Add('        0.00,      ');                                  // GER_TOTIPI
    qryComand.SQL.Add('        0.00,      ');                                  // GER_BASICM
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALQICM
    qryComand.SQL.Add('        0.00,      ');                                  // GER_TOTICM
    qryComand.SQL.Add('        0.00,      ');                                  // GER_TOTRET
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALQRET
    qryComand.SQL.Add('        0.00,      ');                                  // GER_BASRET
    qryComand.SQL.Add('        0.00,      ');                                  // GER_DESESP
    qryComand.SQL.Add('        FIS_VLCON1,');                                  // GER_VLRCON
    qryComand.SQL.Add('        0.00,      ');                                  // GER_TOTPRO
    qryComand.SQL.Add('        0.00,      ');                                  // GER_TOTCUS
    qryComand.SQL.Add('        0.00,      ');                                  // GER_TOTMED
    qryComand.SQL.Add('        "",        ');                                  // GER_TIPFRE
    qryComand.SQL.Add('        0.00,      ');                                  // GER_TOTFRE
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PESBRU
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PESLIQ
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VOLUME
    qryComand.SQL.Add('        "",        ');                                  // GER_ESPECI
    qryComand.SQL.Add('        "",        ');                                  // GER_MARCA_
    qryComand.SQL.Add('        "NOTA DE SERVICO FORNECEDOR",');                // GER_MEN001
    qryComand.SQL.Add('        "",        ');                                  // GER_MEN002
    qryComand.SQL.Add('        "0",        ');                                 // GER_JAFATU
    qryComand.SQL.Add('        "",        ');                                  // GER_TIPFAT
    qryComand.SQL.Add('        "",        ');                                  // GER_NUMFAT
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DTAFAT
    qryComand.SQL.Add('        NULL,      ');                                  // GER_VENFAT
    qryComand.SQL.Add('        "",        ');                                  // GER_CNDFAT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALFAT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR01
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR02
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR03
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR04
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR05
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR06
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR07
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR08
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR09
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR10
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR11
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR12
    qryComand.SQL.Add('        "N",        ');                                 // GER_NOTESP
    qryComand.SQL.Add('        "'+strLoginUsuarioLogado+'",');                 // GER_CODDIG
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PORDES
    qryComand.SQL.Add('        NULL,      ');                                  // GER_R_GCON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODCND
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODFPG
    qryComand.SQL.Add('        0.00,      ');                                  // GER_FATNOT
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODS01
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODS02
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODS03
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODS04
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODS05
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODS06
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DESS01
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DESS02
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DESS03
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DESS04
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DESS05
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DESS06
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALS01
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALS02
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALS03
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALS04
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALS05
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALS06
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PRAENT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_TOTSER
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PERISS
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALISS
    qryComand.SQL.Add('        "",        ');                                  // GER_CLAFI2
    qryComand.SQL.Add('        "",        ');                                  // GER_CLAFI3
    qryComand.SQL.Add('        FIS_NATOPE,');                                  // GER_NATOPE
    qryComand.SQL.Add('        0.00,      ');                                  // GER_DESACE
    qryComand.SQL.Add('        "",        ');                                  // GER_ORIDOC
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DTAROM
    qryComand.SQL.Add('        NULL,      ');                                  // GER_HORROM
    qryComand.SQL.Add('        NULL,      ');                                  // GER_OPEROM
    qryComand.SQL.Add('        NULL,      ');                                  // GER_NUMROM
    qryComand.SQL.Add('        "N",       ');                                  // GER_CONENT
    qryComand.SQL.Add('        "1",       ');                                  // GER_IMPRES
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODREP
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALROM
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALQIRF
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALIRF
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALQPIS
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALPIS
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALQCOF
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALCOF
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALQCSL
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALCSL
    qryComand.SQL.Add('        0.00,      ');                                  // GER_IRFRET
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PISRET
    qryComand.SQL.Add('        0.00,      ');                                  // GER_COFRET
    qryComand.SQL.Add('        0.00,      ');                                  // GER_CSLRET
    qryComand.SQL.Add('        0.00,      ');                                  // GER_SERRET
    qryComand.SQL.Add('        "",        ');                                  // GER_NOTRET
    qryComand.SQL.Add('        "",        ');                                  // GER_NORESE
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALIRFP
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALPISP
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALCOFP
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALCSLP
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PESGSO
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VLSGSO
    qryComand.SQL.Add('        0.00,      ');                                  // GER_IRPRRT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_IRPRDV
    qryComand.SQL.Add('        0.00,      ');                                  // GER_IRSERT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_IRSEDV
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PIPRRT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PIPRDV
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PISERT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PISEDV
    qryComand.SQL.Add('        0.00,      ');                                  // GER_COPRRT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_COPRDV
    qryComand.SQL.Add('        0.00,      ');                                  // GER_COSERT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_COSEDV
    qryComand.SQL.Add('        0.00,      ');                                  // GER_CSPRRT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_CSPRDV
    qryComand.SQL.Add('        0.00,      ');                                  // GER_CSSERT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_CSSEDV
    qryComand.SQL.Add('        NULL,      ');                                  // GER_ORDPRO
    qryComand.SQL.Add('        NULL,      ');                                  // GER_ROMIMP
    qryComand.SQL.Add('        0.00,      ');                                  // GER_BASORG
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ICMORG
    qryComand.SQL.Add('        0.00,      ');                                  // GER_NCONHE
    qryComand.SQL.Add('        0.00,      ');                                  // GER_DESCFF
    qryComand.SQL.Add('        0.00,      ');                                  // GER_RET_SP
    qryComand.SQL.Add('        "",        ');                                  // GER_CONSUM
    qryComand.SQL.Add('        "",        ');                                  // GER_MEN003
    qryComand.SQL.Add('        "",        ');                                  // GER_MEN004
    qryComand.SQL.Add('        "",        ');                                  // GER_MEN005
    qryComand.SQL.Add('        "N",       ');                                  // GER_ENTFAT
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CLIFAT
    qryComand.SQL.Add('        NULL,      ');                                  // GER_EMPFAT
    qryComand.SQL.Add('        NULL,      ');                                  // GER_OPEEXP
    qryComand.SQL.Add('        NULL,      ');                                  // GER_SEPEXP
    qryComand.SQL.Add('        NULL,      ');                                  // GER_OPLBRC
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DTLBRC
    qryComand.SQL.Add('        NULL,      ');                                  // GER_HRLBRC
    qryComand.SQL.Add('        "",        ');                                  // GER_TABPRE
    qryComand.SQL.Add('        NULL,      ');                                  // GER_OPLBEX
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DTLBEX
    qryComand.SQL.Add('        NULL,      ');                                  // GER_HRLBEX
    qryComand.SQL.Add('        "N",       ');                                  // GER_ENTFUT
    qryComand.SQL.Add('        "",        ');                                  // GER_NUM_PR
    qryComand.SQL.Add('        NULL,      ');                                  // GER_EMPROM
    qryComand.SQL.Add('        0.00,      ');                                  // GER_MARGEM
    qryComand.SQL.Add('        "",        ');                                  // GER_EMPORI
    qryComand.SQL.Add('        0.00,      ');                                  // GER_BARTSP
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VLRTSP
    qryComand.SQL.Add('        "N",       ');                                  // GER_OPRFLJ
    qryComand.SQL.Add('        NULL,      ');                                  // GER_SEGURO
    qryComand.SQL.Add('        FIS_DTAENT,');                                  // GER_DTALAN
    qryComand.SQL.Add('        "",        ');                                  // GER_NUMREG
    qryComand.SQL.Add('        "N",       ');                                  // GER_AUTSER
    qryComand.SQL.Add('        FIS_DTAENT,');                                  // GER_DTENTR
    qryComand.SQL.Add('        "",        ');                                  // GER_NROCEI
    qryComand.SQL.Add('        "",        ');                                  // GER_CLAFI4
    qryComand.SQL.Add('        0.00,      ');                                  // GER_TOEIPI
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALEIPI
    qryComand.SQL.Add('        0.00,      ');                                  // GER_BAEIPI
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODEVE
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODOCO
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VLIVA0
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VLIVA5
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VIVA10
    qryComand.SQL.Add('        "",        ');                                  // GER_MENEXP
    qryComand.SQL.Add('        "",        ');                                  // GER_MENEX2
    qryComand.SQL.Add('        "",        ');                                  // GER_MENEX3
    qryComand.SQL.Add('        "",        ');                                  // GER_MENEX4
    qryComand.SQL.Add('        NULL,      ');                                  // GER_PRVIMP
    qryComand.SQL.Add('        NULL       ');                                  // GER_NROBOX
    qryComand.SQL.Add('   FROM CADFIS ');
    qryComand.SQL.Add('  WHERE CADFIS.FIS_NUMDOC = "'+FNumDoc+'" ');
    qryComand.SQL.Add('    AND CADFIS.FIS_ESPDOC = "'+FEspDoc+'" ');
    qryComand.SQL.Add('    AND CADFIS.FIS_CODEMP = "'+FCodEmp+'" ');
    qryComand.SQL.Add('    AND CADFIS.FIS_FORCLI = "'+FCodFor+'" ');
    qryComand.SQL.Add('    AND IFNULL(CADFIS.FIS_SERIE_, "") = "'+FSerie_+'");');
    qryComand.ExecSQL;

    qryComand.SQL.Clear;
    qryComand.SQL.Add('INSERT INTO AUXMOV (AUX_SEQGER, AUX_NATCFO) VALUES ("'+strMovGerAutInc+'", ' + QuotedStr(fRetAutoIncremNatCfo(FClaFi1)) + ' );');
    qryComand.ExecSQL;
End;

function TEntImpNFSe.fRetAutoIncremNatCfo(AStrNatCfo: String): String;
begin
  Result := fCampoTabela('AUTOINCREM', 'NATCFO', ['NAT_CODCFO'], [AStrNatCfo]);
end;

procedure TEntImpNFSe.pCriaMovGerMovDet;
var qryComand: TUniQuery;
    strMovGerAutInc: string;
begin
  qryComand := fCriaQuery;
  Try
    strMovGerAutInc := fRetAutoIncrem('MOVGER',VS_StrCodEmp);
    pMontaSQLMovGer(qryComand, strMovGerAutInc);
    pMontaSQLMovDet(qryComand, strMovGerAutInc);
  Finally
    FreeAndNil(qryComand);
  End;
end;

function TEntImpNFSe.fFormatarTipoServico(ATipoServico: String): String;
const
  LTamanhos: array[0..2] of Integer = (4, 6, 7);
var
  LContador: Integer;
  LCodigo: String;
begin
  Result := fRetSomenteNumeros(ATipoServico);

  if fEmptyStr(Result) then
    Exit;

  LCodigo := Result;

  for LContador := Low(LTamanhos) to High(LTamanhos) do
  begin
    if Length(LCodigo) <= LTamanhos[LContador] then
      LCodigo := fStrZero(Result, LTamanhos[LContador]);

    if not fEmptyStr(fCampoTabela('CDS_CDSERV', 'CADCDS', ['CDS_CDSERV'], [LCodigo], False)) then
    begin
      Result := LCodigo;
      Exit;
    end;
  end;

  Raise Exception.Create(Format('Documento %s-%s: O tipo de serviço %s não está cadastrado.',
    [FNumDoc, FEspDoc, Result]));
end;

procedure TEntImpNFSe.pCalcularRetencoes(ARetencoesNoFrame: TRetencoesNoFrame);
Begin
  FblnGravarPagamentoRetido := True;
  Try
    // Sem valor do servico nao ha base confiavel: bloqueia o documento (rollback e erro de importacao)
    If ARetencoesNoFrame.TemRetencoes And (FVlServ <= 0) Then
      raise Exception.Create('Documento ' + FNumDoc + '-' + FEspDoc +
        ': layout sem Valor do Serviço (FIS_VLSERV); não é possível calcular as retenções.');

    ARetencoesNoFrame.pSetCamposIdentificaDocumento(FNumDoc, FEspDoc, FSerie_, FCodEmp, FCodFor, fRetNomFornecedor(FCodFor), FDtaDoc, FdtaDtaEnt);
    ARetencoesNoFrame.pSetaValorBase(FValCo1);

    //Avisa no log quando o XML traz retencao de tributo sem cadastro na FORRET do fornecedor
    pAvisarRetencaoSemCadastro(ARetencoesNoFrame, TIPRET_IRFF, FReIRRF, 'IRRF');
    pAvisarRetencaoSemCadastro(ARetencoesNoFrame, TIPRET_PIS, FRetPIS, 'PIS');
    pAvisarRetencaoSemCadastro(ARetencoesNoFrame, TIPRET_COFINS, FRetCOF, 'COFINS');
    pAvisarRetencaoSemCadastro(ARetencoesNoFrame, TIPRET_CSLL, FReCSLL, 'CSLL');
    pAvisarRetencaoSemCadastro(ARetencoesNoFrame, TIPRET_ISS, FRETISS, 'ISS');
    pAvisarRetencaoSemCadastro(ARetencoesNoFrame, TIPRET_INSS, FReINSS, 'INSS');

    If (ARetencoesNoFrame.TemRetencoes) Then
    Begin
      If FReIRRF > 0 Then
        ARetencoesNoFrame.pAtualizarValorRetencao(TIPRET_IRFF, FReIRRF)
      Else
        FReIRRF := ARetencoesNoFrame.TotalREIRRF;

      If FPisCofDefXML Then
      Begin
        ARetencoesNoFrame.pAtualizarValorRetencao(TIPRET_PIS, FRetPIS);
        ARetencoesNoFrame.pAtualizarValorRetencao(TIPRET_COFINS, FRetCOF);
      End
      Else
      Begin
        If FRetPIS > 0 Then
          ARetencoesNoFrame.pAtualizarValorRetencao(TIPRET_PIS, FRetPIS)
        Else
          FRetPIS := ARetencoesNoFrame.TotalVREPIS;

        If FRetCOF > 0 Then
          ARetencoesNoFrame.pAtualizarValorRetencao(TIPRET_COFINS, FRetCOF)
        Else
          FRetCOF := ARetencoesNoFrame.TotalVRECOF;
      End;

      // Padrao Nacional: CSLL tambem segue o XML (tpRetPisCofins sem CSLL retida nao cai no calculo da FORRET)
      If FPisCofDefXML Then
        ARetencoesNoFrame.pAtualizarValorRetencao(TIPRET_CSLL, FReCSLL)
      Else If FReCSLL > 0 Then
        ARetencoesNoFrame.pAtualizarValorRetencao(TIPRET_CSLL, FReCSLL)
      Else
        FReCSLL := ARetencoesNoFrame.TotalRECSSL;

      If FRETISS > 0 Then
        ARetencoesNoFrame.pAtualizarValorRetencao(TIPRET_ISS, FRETISS)
      Else
        FRETISS := ARetencoesNoFrame.TotalRETISS;

      If FReINSS > 0 Then
        ARetencoesNoFrame.pAtualizarValorRetencao(TIPRET_INSS, FReINSS)
      Else
        FReINSS := ARetencoesNoFrame.TotalREINSS;

      If FRiNSSP > 0 Then
        ARetencoesNoFrame.pAtualizarValorRetencao(TIPRET_INSSP, FRiNSSP)
      Else
        FRiNSSP := ARetencoesNoFrame.TotalRINSSP;

      FRetTot := ARetencoesNoFrame.fRetTotalImpostos;
      FHisRet := ARetencoesNoFrame.fRetHistoricoRetencao(FValCo1, FValCo1- ARetencoesNoFrame.fRetTotalImpostos);
      FHis001 := FHisRet + FHis001;
    End
    Else
    Begin
      FblnGravarPagamentoRetido := False;
      pAvisarValorLiquidoXML;
    End;

    If (FRetTot > 0) Then
      pZerarValorComRetencao(ARetencoesNoFrame);

  Except
    On E: Exception Do
      raise;
  End;
End;

procedure TEntImpNFSe.pAvisarValorLiquidoXML;
Begin
  // Sem retencao na FORRET a duplicata sai pelo valor liquido do XML (fValorTotalLiquido); livro fiscal pelo valor dos servicos
  If (FVlLiqXML > 0) And (FVlServ > FVlLiqXML) Then
    pEscreveMensagemImportacao(FMemLog, 'Documento ' + FNumDoc + '-' + FEspDoc + ': XML traz valor líquido (' +
      FormatFloat('#,##0.00', FVlLiqXML) + ') menor que o valor dos serviços (' + FormatFloat('#,##0.00', FVlServ) +
      '); fornecedor sem retenção na FORRET, duplicata gravada pelo valor líquido do XML.');
End;

procedure TEntImpNFSe.pAvisarRetencaoSemCadastro(ARetencoesNoFrame: TRetencoesNoFrame; AintTipo: Integer;
  AfltValor: Currency; AstrTributo: String);
var
  LintContador: Integer;
  LblnCadastrado: Boolean;
Begin
  If AfltValor <= 0 Then
    Exit;

  LblnCadastrado := False;
  For LintContador := 0 To High(ARetencoesNoFrame.Retencoes) Do
    If ARetencoesNoFrame.Retencoes[LintContador].RET_TIPRET = AintTipo Then
    Begin
      LblnCadastrado := True;
      Break;
    End;

  If Not LblnCadastrado Then
    pEscreveMensagemImportacao(FMemLog, 'Documento ' + FNumDoc + '-' + FEspDoc + ': XML traz retenção de ' + AstrTributo +
      ' sem cadastro na FORRET do fornecedor.');
End;

function TEntImpNFSe.fValorTotalLiquido(ARetencoesNoFrame: TRetencoesNoFrame): Currency;
Begin
  Result := FValTot;
  If Assigned(ARetencoesNoFrame) And ARetencoesNoFrame.TemRetencoes Then
    Result := Result - ARetencoesNoFrame.fRetTotalImpostos
  Else If (FVlLiqXML > 0) And (FVlServ > FVlLiqXML) Then
    Result := FVlLiqXML; // sem FORRET: duplicata pelo valor liquido do XML, como antes
End;

procedure TEntImpNFSe.pZerarValorComRetencao(ARetencoesNoFrame: TRetencoesNoFrame);
Begin
  If (ARetencoesNoFrame.TotalRETISS > 0) Or (FRETISS > 0) Then
  Begin
    FBasISS := 0;
    FAliISS := 0;
    FValISS := 0;
  End;
End;

end.

