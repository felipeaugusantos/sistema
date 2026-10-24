unit ImportacaoDados.Interfaces;

interface

uses
  cxProgressBar, System.Generics.Collections, Data.DB, UniClientDataSet, untTypesSistema;

Type
  TTipoImportacaoArquivo = (tpCadastroProspecto, tpItensFatVenda, tpCadLocEqu);
  TTipoEstadoTela = (tpInsercao, tpEdicao, tpVisualizacao, tpExclusao);

  TCampoPlanilha = Record
    NomeCampo: String;
    DescricaoCampo: String;
    Coluna: String;
    Conteudo: String;
    Obrigatorio: String;
    MensagemRetorno: String;
    TipoCampo: TFieldType;
    Tamanho: Integer;
    Posicao: Integer;
    blnValidarTamanho: Boolean;
    blnTabela: Boolean;
    blnCmpLig: Boolean;
    blnPreAut: Boolean;
    blnExibirTextoPuro : Boolean;
  End;

  TRegInconsistencia = Record
    NumeroLinha: Integer;
    Coluna: String;
    Campo: String;
    Descricao: String;
  End;

  ICamposModeloArquivo = Interface;
  IValidaDados = Interface;

  IModeloArquivoImportacao = Interface ['{24915C4C-0B89-4FD9-A22A-271F8A52A6EC}']
    function GetCodigo: String;
    function GetDescricao: String;
    function GetAutoIncrem: String;
    function GetTipoImportacaoArquivo: TTipoImportacaoArquivo;
    procedure SetCodigo(Const aValue: String);
    procedure SetDescricao(Const aValue: String);
    procedure SetAutoIncrem(Const aValue: String);
    procedure SetTipoImportacaoArquivo(Const aValue: TTipoImportacaoArquivo);
    procedure SetCampos(Const aValue: TList<ICamposModeloArquivo>);
    function GetCampos: TList<ICamposModeloArquivo>;
    function GetEstadoTela : TTipoEstadoTela;
    procedure SetEstadoTela(Const AValue: TTipoEstadoTela);
    function GetCamposPadrao: TList<TCampoPlanilha>;
    procedure SetCamposPadrao(const AValue: TList<TCampoPlanilha>);
    function GetNomTab: String;
    procedure SetNomTab(const AValue: String);
    function GetBlnEdt: Boolean;
    procedure SetBlnEdt(const AValue: Boolean);

    property AutoIncrem: String read GetAutoIncrem write SetAutoIncrem;
    property Codigo: String read GetCodigo write SetCodigo;
    property Descricao: String read GetDescricao write SetDescricao;
    property Tipo: TTipoImportacaoArquivo read GetTipoImportacaoArquivo write SetTipoImportacaoArquivo;
    property EstadoTela: TTipoEstadoTela read GetEstadoTela write SetEstadoTela;

    function ModeloArquivoImportacao: IModeloArquivoImportacao;
    function Campo: ICamposModeloArquivo;
    function fInserir: IModeloArquivoImportacao;
    function fAlterar: IModeloArquivoImportacao;
    function fExcluir: IModeloArquivoImportacao;

    property Campos: TList<ICamposModeloArquivo> read GetCampos write SetCampos;
    function AddCampo: ICamposModeloArquivo;
    function fCarregarCampos: Boolean;
    function fCarregarCamposPadrao: Boolean;
    function fAtualizarModeloAtual: Boolean;
    function fAdicionarCampo(Const aNomeCampo, aTituloCampo, aColuna, aObrigatorio: String;
      Const aTipoCampo: TFieldType; Const aTamanhoCampo: Integer;
      const ablnTabela: Boolean = False; ablnCmpLig: Boolean = False; blnPreAut: Boolean = False) : TCampoPlanilha;
    procedure pLimparCampos;
    procedure pDefineCamposPadrao;
    function GetListaModeloTabelas: TList<IModeloArquivoImportacao>;
    function fAddModeloTabela(aModelo: IModeloArquivoImportacao): IModeloArquivoImportacao;

    property CamposPadrao: TList<TCampoPlanilha> read GetCamposPadrao write SetCamposPadrao;
    property strNomTabela: String read GetNomTab write SetNomTab;
    property ListaModeloTabelas: TList<IModeloArquivoImportacao> read GetListaModeloTabelas;
    property Editavel: Boolean read GetBlnEdt write SetBlnEdt;

  End;

  ICamposModeloArquivo = Interface ['{DC070E8B-8FA9-456C-BFAC-CFE645084F9C}']
    function GetCodigo: String;
    procedure SetCodigo(Const aValue: String);
    function GetDescricao: String;
    procedure SetDescricao(Const aValue: String);
    function GetObrigatorio: String;
    procedure SetObrigatorio(Const aValue: String);
    function GetColuna: String;
    procedure SetColuna(Const aValue: String);
    function GetPosicao: Integer;
    procedure SetPosicao(Const aValue: Integer);
    function GetNomeCampo: String;
    procedure SetNomeCampo(Const aValue: String);
    function GetFieldType: TFieldType;
    procedure SetFieldType(Const aValue: TFieldType);
    function GetTamanho: Integer;
    procedure SetTamanho(Const aValue: Integer);
    function GetCodModelo: String;
    procedure SetCodModelo(Const aValue: String);
    function GetAutInc: String;
    procedure SetAutInc(Const aValue: String);
    function GetBlnTab: Boolean;
    procedure SetBlnTab(Const aValue: Boolean);
    function GetCmpLig: Boolean;
    procedure SetCmpLig(Const aValue: Boolean);
    function GetBlnAut: Boolean;
    procedure SetBlnAut(Const aValue: Boolean);

    property AutInc: String read GetAutInc write SetAutInc;
    property CodModelo: String read GetCodModelo write SetCodModelo;
    property Codigo: String read GetCodigo write SetCodigo;
    property NomeCampo: String read GetNomeCampo write SetNomeCampo;
    property Descricao: String read GetDescricao write SetDescricao;
    property Obrigatorio: String read GetObrigatorio write SetObrigatorio;
    property Coluna: String read GetColuna write SetColuna;
    property Posicao: Integer read GetPosicao write SetPosicao;
    property TipoCampo: TFieldType read GetFieldType write SetFieldType;
    property Tamanho: Integer read GetTamanho write SetTamanho;
    property blnTabela: Boolean read GetBlnTab write SetBlnTab;
    property blnCmpLig: Boolean read GetCmpLig write SetCmpLig;
    property blnPreAut: Boolean read GetBlnAut write SetBlnAut;


    function ModeloArquivo : IModeloArquivoImportacao;
    function fInserir: ICamposModeloArquivo;
    function fAlterar: ICamposModeloArquivo;
    function fExcluir: ICamposModeloArquivo;
    function fRetPosColuna(Const aColuna: String): Integer;

    function GetBlnPuro: Boolean;
    procedure SetBlnPuro(Const aValue: Boolean);
    property blnExibirTextoPuro: Boolean read GetBlnPuro write SetBlnPuro;
  End;

  ICampoLinha = Interface;
  ILinha = Interface['{899AE631-E3BC-4E38-A78D-760D5E78524E}']
    function GetLinha: TList<ICampoLinha>;
    function GetNumeroLinha: Integer;
    procedure SetLinha(Const aValue: TList<ICampoLinha>);
    procedure SetNumeroLinha(Const aValue: Integer);
    function GetblnTabP: Boolean;
    procedure SetblnTabP(const aValue: Boolean);
    function GetNomTab: String;
    procedure SetNomTab(const aValue: String);

    property Campos: TList<ICampoLinha> read GetLinha  write SetLinha;
    property NumeroLinha: Integer read GetNumeroLinha write SetNumeroLinha;
    function AddCampo: ICampoLinha;
    property blnTabelaPrincipal: Boolean read GetblnTabP write SetblnTabP;
    property strNomeTabela: String read GetNomTab write SetNomTab;
  End;

  ICampoLinha = Interface['{E3F63E02-764D-4DED-B7D5-AB27BD3A6F9B}']
    function GetPropriedades: TCampoPlanilha;
    procedure SetPropriedades(Const aValue: TCampoPlanilha);
    property Propriedades: TCampoPlanilha read GetPropriedades write SetPropriedades;
  End;

  IInconsistencia = Interface['{D6006B38-138F-4411-AF1D-F314077D3702}']
    function GetLinha: TList<ILinha>;
    procedure SetLinha(const aValue: TList<ILinha>);
    function GetInconsistencias: TList<TRegInconsistencia>;
    procedure SetInconsistencias(const aValue: TList<TRegInconsistencia>);

    property Linhas: TList<ILinha> read GetLinha write SetLinha;
    property Inconsistencias: TList<TRegInconsistencia> read GetInconsistencias write SetInconsistencias;
    function AddLinha: ILinha;
  End;

  IImportaPlanilha = Interface ['{23490104-FC33-41F5-B79C-08889729E77D}']
    function GetCaminhoArquivo: String;
    procedure SetCaminhoArquivo(Const aValue: String);
    function GetEstadoTela: TTipoEstadoTela;
    procedure SetEstadoTela(Const aValue: TTipoEstadoTela);
    function GetLinha: TList<ILinha>;
    procedure SetLinha(const aValue: TList<ILinha>);
    function GetModelo: IModeloArquivoImportacao;
    function GetValida: IValidaDados;
    procedure SetValida(Const aValue: IValidaDados);
    function GetProgresso: TCxProgressBar;
    procedure SetProgresso(Const aValue: TCxProgressBar);

    function fProcessarArquivo(Const aCaminhoArquivo: String): Boolean; overload;
    function fInserirCadastros: Boolean;
    function fAtualizarDadosImportados(Const aCds: TUniClientDataSet): Boolean;
    function fReprocessarArquivo: Boolean;

    property CaminhoArquivo: string read GetCaminhoArquivo write SetCaminhoArquivo;
    property EstadoTela: TTipoEstadoTela read GetEstadoTela write SetEstadoTela;
    property LinhasImportadas: TList<ILinha> read GetLinha write SetLinha;
    property Modelo: IModeloArquivoImportacao read GetModelo;
    property Valida: IValidaDados read GetValida write SetValida;
    property cxProgresso: TCxProgressBar read GetProgresso write SetProgresso;
    function fProcessarArquivo(Const aCaminhoArquivo: String; const ACxProgresso: TCxProgressBar; const FncCancelouOperacao : TReferenceBooleanFunction): Boolean; overload;
  End;

  IValidaDados = Interface['{D58D72DF-4F49-4541-AA6E-B2B1AB275EC7}']
    function GetInconsistencias: IInconsistencia;
    procedure SetInconsistencias(const aValue: IInconsistencia);
    function GetArquivoImportacao: IImportaPlanilha;
    procedure SetArquivoImportacao(const aValue: IImportaPlanilha);
    function fValidar: Boolean;
    function fValidarLinha(Const aLinha: ILinha): Boolean;
    procedure pAtualizarParametrosValidacao;
    procedure pLimpar;
    procedure pAdicionaInconsistencia(Const aLinha: ILinha; Const Coluna, Campo, Mensagem: String);
    procedure pSetarLinhaPadraoModelo;
    function fRetornaCampoCodigo(const strCodTmp: String; intTamCampo: Integer): String;

    property Arquivo: IImportaPlanilha read GetArquivoImportacao write SetArquivoImportacao;
    property Inconsistencias: IInconsistencia read GetInconsistencias write SetInconsistencias;
  End;

Const
  strTipoImportacaoArquivo: array[TTipoImportacaoArquivo] of string = ('PROSPECTO','ITEMFATVENDA', 'CADLOCEQU');

  cstNomCli = 'PRO_NOMCLI';
  cst_C_G_C = 'PRO_C_G_C_';
  cstCodCid = 'PRO_CODCID';
  cstNomCid = 'CID_NOMCID';
  cstfone01 = 'PRO_FONE01';
  cstEMail1 = 'PRO_EMAIL_';
  cstEmail2 = 'PRO_EMAIL2';
  cstCodAti = 'PRO_CODATI';
  cstDesAti = 'ATI_DESATI';
  cstCodVen = 'PRO_CODVEN';
  cstNomVen = 'VEN_NOMVEN';
  cstStatus = 'PRO_STATUS';
  cstBairro = 'PRO_BAIRRO';
  cstCGCCPF = 'PRO_CGCCPF';
  cstContat = 'PRO_CONTAT';
  cstProCep = 'PRO_C_E_P_';
  cstEmail3 = 'PRO_EMAIL3';
  cstEndCom = 'PRO_ENDCOM';
  cstEndere = 'PRO_ENDERE';
  cstEndNum = 'PRO_ENDNUM';
  cstFanSob = 'PRO_FANSOB';
  cstFone02 = 'PRO_FONE02';
  cstNumFax = 'PRO_F_A_X_';
  cstHomPag = 'PRO_HOMEPA';
  cstInsEst = 'PRO_I_E_S_';
  cstDatNsc = 'PRO_NASCIM';
  cstNextel = 'PRO_NEXTEL';
  cstNumeRg = 'PRO_NUMR_G';
  cstObserv = 'PRO_OBSERV';
  cstNRgExp = 'PRO_RG_EXP';
  cstCodRed = 'PRO_CODRED';
  cstDesRed = 'RED_DESRED';
  cstCrmFai = 'PRO_CRMFAI';
  cstDesFai = 'CRF_DESCRI';
  cstCrmFre = 'PRO_CRMFRE';
  cstDesFre = 'CRM_FDESCR';
  cstCrmPor = 'PRO_CRMPOR';
  cstDesPor = 'CRP_DESCRI';
  cstCrmCat = 'PRO_CRMCAT';
  cstDesCat = 'CAT_DESCRI';
  cstCaiPos = 'PRO_CAIPOS';
  cstUFExRg = 'CID_ESTADO';
  cstCrmFor = 'PRF_CRMFOR';
  cstDesFor = 'CRF_NOMFOR';
  cstCelula = 'PRO_CELULA';
  cstCodRep = 'PRO_CODREP';
  cstNomRep = 'R.OPE_CODOPE';
  cstCodReg = 'PRO_CODREG';
  cstDesReg = 'REG_DESREG';


  arrCamposProspecto: array of string = [cstNomCli,
                                         cst_C_G_C,
                                         cstCodCid,
                                         cstNomCid,
                                         cstfone01,
                                         cstEMail1,
                                         cstEmail2,
                                         cstCodAti,
                                         cstDesAti,
                                         cstCodVen,
                                         cstNomVen,
                                         cstStatus,
                                         cstBairro,
                                         cstCGCCPF,
                                         cstContat,
                                         cstProCep,
                                         cstEmail3,
                                         cstEndCom,
                                         cstEndere,
                                         cstEndNum,
                                         cstFanSob,
                                         cstFone02,
                                         cstNumFax,
                                         cstHomPag,
                                         cstInsEst,
                                         cstDatNsc,
                                         cstNextel,
                                         cstNumeRg,
                                         cstObserv,
                                         cstNRgExp,
                                         cstCodRed,
                                         cstDesRed,
                                         cstCrmFai,
                                         cstDesFai,
                                         cstCrmFre,
                                         cstDesFre,
                                         cstCrmPor,
                                         cstDesPor,
                                         cstCrmCat,
                                         cstDesCat,
                                         cstCaiPos,
                                         cstUFExRg,
                                         cstCrmFor,
                                         cstDesFor,
                                         cstCelula,
                                         cstCodRep,
                                         cstNomRep,
                                         cstCodReg,
                                         cstDesReg];

  {TItemFatVenda}

  cstCodItem       = 'ITE_CODITE';
  cstQtdeItem      = 'ITE_QTDITE';
  cstDestinoItem   = 'ITE_ENTRET';
  cstVlrUnitItem   = 'ITE_UNIDIG';
  cstVlrComDescon  = 'ITE_UNITAR';
  cstDescontoItem  = 'ITE_DESCON';
  cstTabPreCad     = 'ITE_TABPRE';
  cstComplItem     = 'ITE_COMPLE';
  cstUnidadeItem   = 'ITE_CODUNI';
  cstEmpFat        = 'ITE_EMPFAT';
  cstLoteArm       = 'ITE_NUMLOT';
  cstLocRet        = 'ITE_LOCRET';
  cstTpEntrega     = 'ITE_ENTFUT';
  cstMotivo        = 'ITE_MOTFUT';
  cstCliRetira     = 'ITE_CLIBUS';
  cstDiasEntrega   = 'ITE_DIAFOR';
  cstDtaEntrega    = 'ITE_DTENTR';
  cstPegou         = 'ITE_PEGOU_';
  cstBrinde        = 'ITE_BRINDE';

  arrCamposIteFatVenda: array of string = [cstCodItem,
                                           cstQtdeItem,
                                           cstDestinoItem,
                                           cstVlrUnitItem,
                                           cstVlrComDescon,
                                           cstDescontoItem,
                                           cstTabPreCad,
                                           cstComplItem,
                                           cstUnidadeItem,
                                           cstEmpFat,
                                           cstLoteArm,
                                           cstLocRet,
                                           cstTpEntrega,
                                           cstMotivo,
                                           cstCliRetira,
                                           cstDiasEntrega,
                                           cstDtaEntrega,
                                           cstPegou,
                                           cstBrinde];

implementation

end.
