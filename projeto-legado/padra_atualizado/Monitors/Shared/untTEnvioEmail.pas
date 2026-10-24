unit untTEnvioEmail;

interface

uses Classes, SysUtils, StrUtils, Generics.Collections,Data. DB, System.Generics.Defaults,
  untFuncoesSimples, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdAntiFreezeBase,
  Vcl.IdAntiFreeze, IdMessage, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdSMTPBase, IdSMTP,
  IdExplicitTLSClientServerBase, IdMessageClient, IdAttachmentFile, Vcl.Forms, IdEmailAddress, IdGlobal,
  Vcl.StdCtrls, Vcl.Controls, untTypesSistema, IdMessageBuilder, IdText, IdIMAP4, IdAttachment,
  IdReplyIMAP4, System.Zip, Vcl.ExtCtrls, UniClientDataSet, Uni, EditFocus, Types,
  Vcl.Graphics, CRAccess, untDisparaEmailAut, JPeg,untTDupEma, untMsgInterna, System.Variants,
  untTEnvioEmailAutenticacaoOAuth2, System.Json, System.NetEncoding;

Type
  TBasicSearchKey = (bskBcc, bskBody, bskCc, bskFrom, bskHeader, bskKeyword, bskSubject, bskText, bskTo);
  TThreadSincronizaEmails = class;

  TDadosAnexos = Record
    nomeArquivo: String;
    contentID: String;
  End;

  TArrayDadosAnexos = Array of TDadosAnexos;

  TAutenticacaoEmail = class
  Private
    FProvedor        : Integer;
    FPortaSmtp       : Integer;
    FPortaImap       : Integer;
    FSenha           : String;
    FUsuario         : String;
    FLogin           : String;
    FRemete          : String;
    FServidorSmtp    : String;
    FServidorImap    : String;
    FNomeOpe         : String;
    FCodOpe          : String;
    FLimiteArq       : Integer;
    FImagemAssinatura: TMemoryStream;
    FTextoAssinatura : TStringList;
    FImagemAssinaturaValida: Boolean;
    FSSLSai          : Boolean;
    FSSLEnt          : Boolean;
    FTipPrv          : String;
    FGravaPastaEnviados: String;
    FIncCon: String;
    FRemetente: String;

    FUsaAuthenticacaoOAuth2: Boolean;
    FClientId,
    FClientSecret,
    FTenantId,
    FEmailIdAzure: String;

    FDatasetProvedor: TUniClientDataset;

    FAutenticacaoOAuth2: TEnvioEmailAutenticacaoOAuth2;

    procedure SetProvedor(const Value: Integer);
    Procedure SetPortaSmtp(const Value: Integer);
    Procedure SetPortaImap(const Value: Integer);
    Procedure SetSenha(const Value: String);
    Procedure SetUsuario(const Value: String);
    Procedure SetServidorSmtp(const Value: String);
    Procedure SetServidorImap(const Value: String);
    Procedure SetLimiteArq(const Value: Integer);
    Procedure SetCodOpe(const Value: String);
    Procedure SetLogin(const Value: String);
    Procedure SetRemete(const Value: String);
    Procedure DefinirDadosAutenticacao(strCodUsuario, strNomOpe: String; blnEmailAut: Boolean); Overload;

    procedure CarregarStreamImagem(var AImageStream: TMemoryStream;
                                   AImagemBase64: String);

    class function AutenticarServidorSMTP(ADadosAutenticacao: TAutenticacaoEmail;
                                          var AIdSMTP: TIdSMTP;
                                          var AConexaoProvedor: Boolean;
                                          AAtualizarIDAzure: Boolean = False): Boolean;

    class procedure CarregaIDEmailAzure(var ADadosAutenticacao: TAutenticacaoEmail);
  Public
    Constructor Create(strCodUsuario, strNomOpe: String; blnEmailAut: Boolean); overload;
    Constructor Create(strCodOpe, strEmail, strLogin, strRemete, strSenha: String; intCodPrv: Integer; AValidaSenha: Boolean); overload;
    Constructor Create(strCodOpe, strUrlSmtp, strUrlImap: String; intProvedor, intPortaSmtp, intPortaImap: Integer; blnSSLEnt, blnSSLSai: Boolean); overload;
    Destructor  Destroy(); Override;

    function EhValido(): Boolean;
    function ImagemAssinaturaEhValida(): Boolean;
    Procedure DefinirDadosAutenticacao(ALimiteArq, AProvedor, APortaSmtp, APortaImap: Integer;
      ASenha, AUsuario, ALogin, ARemete, AServidorSmtp, AServidorImap, ACodOpe: String; ASSLEnt, ASSLSai: Boolean; AGravaPastaEnviados: String); Overload;

    procedure CarregaDadosDoProvedor(ACodigoProvedor: Integer);

    class function fValidarAutenticacaoSmtp(AOwner: TComponent; ADadosAutenticacao: TAutenticacaoEmail; out blnConexaoProvedor: Boolean; AAtualizarIDAzure: Boolean = False): Boolean; overload;
    class function fValidarAutenticacaoSmtp(AOwner: TComponent; ACodOpe, AUrlSmtp: String; APorta: Integer; ASSLSai: Boolean; AAtualizarIDAzure: Boolean = False): Boolean; overload;
    class function fValidarAutenticacaoImap(ADadosAutenticacao: TAutenticacaoEmail): Boolean; overload;
    class function fValidarAutenticacaoImap(AOwner: TComponent; ACodOpe, AUrlImap: String; APorta: Integer; ASSLEnt: Boolean): Boolean; overload;
    Class function ConnectIdIMAP(Var AIdIMAP: TIdIMAP4; AUsuario: String; ADadosAutorizacao: TAutenticacaoEmail):Boolean;


    property provedor        : Integer       Read FProvedor               Write SetProvedor;
    Property portaSmtp       : Integer       Read FPortaSmtp              Write SetPortaSmtp;
    Property portaImap       : Integer       Read FPortaImap              Write SetPortaImap;
    Property senha           : String        Read FSenha                  Write SetSenha;
    Property nomeOpe         : String        Read FNomeOpe;
    Property usuario         : String        Read FUsuario                Write SetUsuario;
    Property login           : String        Read FLogin                  Write SetLogin;
    Property remetente       : String        Read FRemete                 Write SetRemete;
    Property servidorSmtp    : String        Read FServidorSmtp           Write SetServidorSmtp;
    Property servidorImap    : String        Read FServidorImap           Write SetServidorImap;
    Property codOpe          : String        Read FCodOpe                 Write SetCodOpe;
    Property limiteArq       : Integer       Read FLimiteArq              Write SetLimiteArq;
    Property imagemAssinatura: TMemoryStream Read FImagemAssinatura       Write FImagemAssinatura;
    Property textoAssinatura : TStringList   Read FTextoAssinatura        Write FTextoAssinatura;
    Property imagemAssinaturaValida: Boolean Read ImagemAssinaturaEhValida;
    Property blnSSLEnt       : Boolean       Read FSSLEnt                 Write FSSLEnt;
    Property blnSSLSai       : Boolean       Read FSSLSai                 Write FSSLSai;
    Property strGravaPastaEnviados: String   Read FGravaPastaEnviados     Write FGravaPastaEnviados;
    Property strTipPrv       : String        Read FTipPrv                 Write FTipPrv;
    Property strIncCon       : String        Read FIncCon                 Write FIncCon;
    Property strRemetente    : String        Read FRemetente              Write FRemetente;

    Property UsaAuthenticacaoOAuth2: Boolean read FUsaAuthenticacaoOAuth2 write FUsaAuthenticacaoOAuth2;
    Property ClientId: String                read FClientId               write FClientId;
    Property ClientSecret: String            read FClientSecret           write FClientSecret;
    Property TenantId: String                read FTenantId               write FTenantId;
    Property EmailIdAzure: String            read FEmailIdAzure           write FEmailIdAzure;
    Property AutenticacaoOAuth2: TEnvioEmailAutenticacaoOAuth2 read FAutenticacaoOAuth2 write FAutenticacaoOAuth2;
  End;

  TAnexo = class
  Private
    FArquivo: String;
    FTamanho: Double;
    FDescricao: String;

    Procedure SetArquivo(const Value: String);
    Procedure SetTamanhoArquivo();
  Public
    Constructor Create(AArquivo: String);

    Property arquivo  : String Read FArquivo   Write SetArquivo;
    Property tamanho  : Double Read FTamanho;
    Property descricao: String Read FDescricao;
  End;

  TAnexos = class
  Private
    FLimiteAnexos  : Integer;
    FTotalTamAnexos: Double;
    FArquivosAnexados: TList<TAnexo>;

    Procedure SetLimiteAnexos(const Value: Integer);
  Public
    Constructor Create(ALimiteAnexos: Integer);

    Property limiteAnexos: Integer           Read FLimiteAnexos     Write SetLimiteAnexos;
    Property arquivosAnexados: TList<TAnexo> Read FArquivosAnexados Write FArquivosAnexados;
  End;

  TImagemCorpoHtml = class
  Private
    FCaminhoImagem: String;
  Public
    Constructor Create(ACaminhoImagem: String);

    Property caminhoImagem: String      Read FCaminhoImagem Write FCaminhoImagem;
  End;

  TMensagem = class
  Private
    FPara              : TStringList;
    FAnexos            : TAnexos;
    FAssunto           : String;
    FComCopia          : TStringList;
    FCorpoMensagem     : TStringList;
    FNomeSaudacao      : String;
    FComCopiaOculta    : TStringList;
    FCorpoHtml         : Boolean;
    FImagensCorpoHtml  : TList<TImagemCorpoHtml>;
    FMensagemAutomatica: Boolean;
    FblnGravarAnexosPath: Boolean;

    Procedure SetAssunto(const Value: String);
    Procedure SetNomeSaudacao(const Value: String);
  Public
    Constructor Create(ALimiteAnexos: Integer);
    Destructor  Destroy(); Override;

    Procedure AdicionarAnexo(const Value: TAnexo);
    Function AdicionarPara(const Value: String): Boolean;
    Function AdicionarAssunto(const Value: String): Boolean;
    Procedure AdicionarMensagem(const Value: String);
    Function AdicionarComCopia(const Value: String): Boolean;
    Function AdicionarComCopiaOculta(const Value: String): Boolean;
    Procedure AdicionarImagemCorpoHtml(caminhoArquivo: String);
    Procedure RemoverAnexo(const Value: String);
    Procedure RemoverTodosAnexos();
    Procedure Limpar();
    Procedure LimparPara;
    Procedure LimparComCopia;
    Procedure LimparComCopiaOculta;
    Procedure pGravarAnexos(const strAquivo: String);

    function  EhValida(): Boolean;

    Property para              : TStringList             Read FPara;
    Property anexos            : TAnexos                 Read FAnexos;
    Property assunto           : String                  Read FAssunto            Write SetAssunto;
    Property comCopia          : TStringList             Read FComCopia;
    Property corpoMensagem     : TStringList             Read FCorpoMensagem;
    Property nomeSaudacao      : String                  Read FNomeSaudacao       Write SetNomeSaudacao;
    Property comCopiaOculta    : TStringList             Read FComCopiaOculta;
    Property corpoHtml         : Boolean                 Read FCorpoHtml          Write FCorpoHtml;
    Property imagensCorpoHtml  : TList<TImagemCorpoHtml> Read FImagensCorpoHtml;
    Property mensagemAutomatica: Boolean                 Read FMensagemAutomatica Write FMensagemAutomatica;
    Property blnGravarAnexosPath: Boolean                Read FblnGravarAnexosPath Write FblnGravarAnexosPath;
  End;

  TEnvioEmail = class(TComponent)
  Private
    FIdSMTP           : TIdSMTP;
    FIdMessage        : TIdMessage;
    FSSLSocket        : TIdSSLIOHandlerSocketOpenSSL;
    FMensagem         : TMensagem;
    FDadosAutenticacao: TAutenticacaoEmail;
    FThreadSincEmail  : TThreadSincronizaEmails;

    FEnviado          : Boolean;
    FImportante       : Boolean;
    FAnexosCount      : Integer;

    FHoraEnvio        : TDateTime;
    FCodCli           : String;
    FNomeArquivoZip   : String;
    FDiretorioEmail   : String;
    blnEmailAut       : Boolean;
    FEnvAutCob        : Boolean;
    FAutInc: String;
    FCodEma: Int64;
    FIncCon: String;
    FDuplicatasEnvio  : TArrDupTabelaEmail;
    FblnGravarAnexosPath : Boolean;

    FValidarErros: Boolean;

    FChavesBloqueioEmails: TUniClientDataset;

    FEmailBloqueado: String;

    FNotFic: String;

    Procedure InicializarComponentes();
    Function  ValidarMensagem(): Boolean;
    Function  ValidarDllsSSL(): Boolean;
    Procedure LimparMensagem();
    Class procedure pMensagemErroEnviaEmail(strMsgErro: string);

    function GetDestinatario(AMsgErro: String = ''; APara: Integer = 0): String;

    procedure EnviarMensagemErroAosOperadores(AAutenticado: Boolean;
                                              ACodigoGrupoModelo,
                                              ACodigoModelo,
                                              AErroGerado: String);
    function DeveGravarErroEnvioAutomatico(AAutenticado: Boolean): Boolean;

    function AcertaVariaveisVensagemBloqueio(ATexto,
                                             ANomeGrupoModelo,
                                             ANomeModelo,
                                             AErroProvedor: String): String;
    procedure EnviarMensagemErroBloqueioAosOperadores(ACodigoGrupoModelo,
                                                      ACodigoModelo,
                                                      AErroGerado: String);

    function ReenviarEmailAutenticado(AEmailEnviado,
                                      AAutenticado: Boolean): Boolean;

    procedure IniciarDatasetChavesBloqueioEmails;
    function ErroReferenteARementeDestinatario(AMensagemErro: String): Boolean;

    procedure EnviarEmailOAuth2(AJsonEmail: TJsonObject);
  Public
    Constructor Create(AOwner: TComponent; blnEmailAut: Boolean; strNomOpe: String; intLimArq: Integer); Reintroduce;
    Destructor  Destroy; Override;

    class var FCodigoGrupoModelo: String;
    class var FCodigoModelo: String;

    procedure pLogErros(GravarErro:Boolean; MensagemErro:String; strRelatorio: String='');

    function DeveGravarEmailDoClienteNaBlackList(AMensagemErro: String): Boolean;

    Procedure EnviarMensagem();
    Procedure DefinirDadosAutenticacao(ALimiteArq, AProvedor, APortaSmtp, APortaImap: Integer;
     ASenha, AUsuario, ALogin, ARemete, AServidorSmtp, AServidorImap, ACodOpe: String; ASSLEnt, ASSLSai: Boolean; AGravaPastaEnviados: String);

    Class Function EnviarEmail(AOwner: TComponent; ACodOperador, AAssunto: String;
      APara, AComCopia, AComCopiaOculta, ACorpoMensagem, AAnexos: TStringArray;
      AAbrirEditor: Boolean = True; AImportante: Boolean = False; strAutInc: String = ''; strIncCon: String = ''; intCodEma: Int64 = 0; blnEmailAut: Boolean = False;
      strSenha : String = ''; strEmail : String = ''; strLogin : String = ''; strRemete : String = ''; intProvedor: Integer = 0; intPorSmt: Integer = 0; intPorIma: Integer = 0; strSerSmt: String = ''; strSerIma: String = '';
      intLimArq: Integer = 0; blnImgAss: Boolean = False; strTxtAss: String = ''; mmsImaAss: TMemoryStream = Nil; strNomOpe: String = ''; strImgCorpo: String = '';
      blnSSLSai: Boolean = False; blnSSLEnt: Boolean = False; strGravaPastaEnviados: String = 'S'; strEnvAutCob: String = 'N'; strCodCli : String = ''; strCodFor : String = '';
      blnAdicionaUmParagrafoPorLinha: Boolean = True; blnExibirMensagem: Boolean = True; blnExibeStatus: Boolean = True; ADuplicatasEnvio: TArrDupTabelaEmail = Nil;
      blnGravarAnexos: Boolean = False; AHabilitaDivisaoAnexoPorEmail: Boolean = False; ACodOco: String = ''; ANotFic: String = ''): Boolean; overload;

    Class function EnviarEmailSemMensagemConfirmacao(AOwner: TComponent; ACodOperador, AAssunto: String;
      APara, AComCopia, AComCopiaOculta, ACorpoMensagem, AAnexos: TStringArray;
      AAbrirEditor: Boolean = True; AThreadSincronizaEmail: TThreadSincronizaEmails = nil; blnImpressaoBoleto: Boolean = False;
      AImportante: Boolean = False; strAutInc: String = ''; strIncCon: String = ''; intCodEma: Int64 = 0; blnEmailAut: Boolean = False;
      strSenha : String = ''; strEmail : String = ''; strLogin : String = ''; strRemete : String = ''; intProvedor: Integer = 0; intPorSmt: Integer = 0; intPorIma: Integer = 0; strSerSmt: String = ''; strSerIma: String = '';
      intLimArq: Integer = 0; blnImgAss: Boolean = False; strTxtAss: String = ''; mmsImaAss: TMemoryStream = Nil; strNomOpe: String = ''; strImgCorpo: String = '';
      blnSSLSai: Boolean = False; blnSSLEnt: Boolean = False; strGravaPastaEnviados: String = 'S'; ADuplicatasEnvio: TArrDupTabelaEmail = Nil): Boolean; overload;

    Class Function EnviarEmail(AOwner: TComponent; ACodOperador: String;
      APara, AComCopia, AComCopiaOculta, ACorpoMensagem, AAnexos: TStringArray;
      AAbrirEditor: Boolean; AImportante: Boolean; strAutInc, strIncCon: String; intCodEma: Int64; blnEmailAut: Boolean;
      strSenha : String; strEmail : String; strLogin: String; strRemete: String; intProvedor: Integer; intPorSmt: Integer; intPorIma: Integer; strSerSmt: String; strSerIma: String;
      intLimArq: Integer; blnImgAss: Boolean; strTxtAss: String; mmsImaAss: TMemoryStream; strNomOpe, strImgCorpo: String;  Var AAssunto: String;
      blnSSLSai: Boolean; blnSSLEnt: Boolean; strGravaPastaEnviados: String; AExibirMensagemConfirmacaoEnvio: Boolean = True;
      AThreadSincronizaEmail: TThreadSincronizaEmails = nil; blnImpressaoBoleto: Boolean = False; blnEnvAutCob: Boolean = False; strCodCli : String = ''; strCodFor : String = '';
      AAdicionaUmParagrafoPorLinha: Boolean = True; blnExibeStatus: Boolean = True; ADuplicatasEnvio: TArrDupTabelaEmail = Nil;
      blnGravarAnexos: Boolean = False; AHabilitaDivisaoAnexoPorEmail: Boolean = False; ACodOco: String = ''; ANotFic: String = ''): Boolean; Overload;

    Class Function CriarAnexosZipMensagem(ANomeArquivoZip: String; AMensagem: TIdMessage): TArrayDadosAnexos;

    Class Procedure GravarZipMensagem(AIdMessage: TIdMessage; ADiretorioEmail, ANomeArquivoZip: String);

    Class Function ContruirArrayMensagem(ATexto: String): TStringArray;

    Property mensagem         : TMensagem          Read FMensagem          Write FMensagem;
    Property enviado          : Boolean            Read FEnviado           Write FEnviado;
    Property dadosAutenticacao: TAutenticacaoEmail Read FDadosAutenticacao;
    Property importante       : Boolean            Read FImportante        Write FImportante;
    Property horaEnvio        : TDateTime          Read FHoraEnvio         Write FHoraEnvio;
    Property strCodCli        : String             Read FCodCli            Write FCodCli;
   // Property envioAut         : Boolean            Read FEnvioAut          Write FEnvioAut;
    Property strAutInc        : String             Read FAutInc            Write FAutInc;
    Property strIncCon        : String             Read FIncCon            Write FIncCon;
    Property intCodEma        : Int64              Read FCodEma            Write FCodEma;
    Property ThreadSincEmail  : TThreadSincronizaEmails Read  FThreadSincEmail Write FThreadSincEmail;
    Property EnvAutCob        : Boolean            Read FEnvAutCob         Write FEnvAutCob;
    property DuplicatasEnvio  : TArrDupTabelaEmail Read FDuplicatasEnvio   Write FDuplicatasEnvio;
    Property blnGravarAnexosPath: Boolean          Read FblnGravarAnexosPath Write FblnGravarAnexosPath;
    property ValidarErros     : Boolean            Read FValidarErros      Write FValidarErros Default True;
    Property strNotFic        : String             Read FNotFic            Write FNotFic;
  End;

  TContatoEmail = Record
    intIndex : Integer;
    strAutInc: String;
    strCodOpe: String;
    strNomCon: String;
    strTelRes: String;
    strTelCom: String;
    strCelula: String;
    strEmail : String;
  End;

  TTipoOperacaoConsulta = (toMenuSuspenso, toConsultaContatos);

  TContatosEmail = Array of TContatoEmail;

  TContatoOperador = Record
    strCodOpe: String;
    strNomCon: String;
    strTelRes: String;
    strTelCom: String;
    strCelula: String;
    stlEmail : TStringList;
  End;

  TfValidaCampos = function (Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean of Object;

  TListaContatosEmail = class(TComponent)
  private
    FCodOpe: String;
    FFiltro: String;
    FContatosSelecionados: String;
    FTipoOperacao: TTipoOperacaoConsulta;

    FContatos: TContatosEmail;
    FPnlLista: TPanel;
    FListagem: TListBox;
    FEditFiltro: TEditFocus;
    FEditTexto: TEditFocus;
    FQryContatos: TUniQuery;
    FCdsContatos: TUniClientDataSet;

    procedure pInicializarListagemContatos;
    procedure pBuscarDadosContatos;
    procedure pAtualizarArrayListagem;
    procedure pAtualizarListboxListagem;
    procedure pCriarComponentesDados();
    procedure pOnKeyDownListagem(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pOnKeyUpListagem(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pOnDblClickListagem(Sender: TObject);
    procedure pOnFilterRecord(DataSet: TDataSet; var Accept: Boolean);

    class function fEmailExistente(AEmail: String; Out ASeqCon: String; bnlEnvAutCob: Boolean = False): Boolean;
  public
    Constructor Create(AOwner: TComponent; ACodOpe: String; ATipoOperacao: TTipoOperacaoConsulta); Reintroduce;
    Destructor  Destroy; Override;

    procedure pFiltrarContatos(AFiltro: String; Var AEditFiltro, AEditTexto: TEditFocus);
    procedure pExibirListagem(AExibir: Boolean; AParent: TComponent = nil);
    procedure pSelecionarContato(AItemIndex: Integer);
    function pSelecionarFiltroString(ATextoEditFiltro: String): String;
    procedure pAtualizarListaContatos;

    class procedure pGravarContato(AEmail, strIncCon: String; bnlEnvAutCob: Boolean); Overload;
    class procedure pGravarContato(AContato: TContatoOperador); Overload;

    property lsbContatos: TListBox       Read FListagem;
    property arrContatos: TContatosEmail Read FContatos Write FContatos;
    property pnlListagem: TPanel         Read FPnlLista;
  end;

  TEmailsSinc = class
  strict private
    FDadosAutenticacao: TAutenticacaoEmail;
    FDiretorioEmail   : String;
    FIdSMTP           : TIdSMTP;
    FIdMessage        : TIdMessage;
    FPara             : TStringArray;
    FNomeArquivoZip   : String;
    FSSLSocket        : TIdSSLIOHandlerSocketOpenSSL;
    FHoraEnvio        : TDateTime;

  public
    property DadosAutenticacao: TAutenticacaoEmail   Read FDadosAutenticacao Write FDadosAutenticacao;
    property DiretorioEmail: String                  Read FDiretorioEmail    Write FDiretorioEmail;
    property IdSMTP: TIdSMTP                         Read FIdSMTP            Write FIdSMTP;
    property IdMessage: TIdMessage                   Read FIdMessage         Write FIdMessage;
    property NomeArquivoZip: String                  Read FNomeArquivoZip    Write FNomeArquivoZip;
    property SSLSocket: TIdSSLIOHandlerSocketOpenSSL Read FSSLSocket         Write FSSLSocket;
    property Para: TStringArray                      Read FPara              Write FPara;
    property HoraEnvio: TDateTime                    Read FHoraEnvio         Write FHoraEnvio;
  end;

  TThreadSincronizaEmails = class(TThread)
  strict private
    FTerminou: Boolean;
    FErroNoEnvio: Boolean;
    FListaEmails: TObjectList<TEmailsSinc>;

    function fGetQuantidadeEmails: Integer;
  protected
    procedure Execute; override;
  public
    destructor Destroy; override;

    constructor Create;

    procedure pAdicionaEmailLista(AEmail: TEmailsSinc);

    property Terminou: Boolean Read FTerminou;
    property ErroNoEnvio: Boolean Read FErroNoEnvio;
    property QuantidadeEmails: Integer read fGetQuantidadeEmails;
  end;

  TListaThreadsSincronizaEmails = Class
  strict private
    FListaThreads: TObjectList<TThreadSincronizaEmails>;

    function fGetQuantidadeThreads: integer;

    class var FInstance: TListaThreadsSincronizaEmails;
    constructor Create;
  public
    class function GetInstance: TListaThreadsSincronizaEmails;

    procedure pAdicionar(AThreadSincronizaEmails: TThreadSincronizaEmails);

    function fConcluiuSincronizacao: Boolean;

    procedure pRemoveSincronizacoesConcluidas;

    property QuantidadeThreads: integer read fGetQuantidadeThreads;
  End;

  Const
    IMAPSearchKeys: array [TBasicSearchKey] of string = ('BCC', 'BODY', 'CC',
      'FROM', 'HEADER', 'KEYWORD', 'SUBJECT', 'TEXT', 'TO');

  Var
    FEmailsModelosAutenticados: String;
    FTrataReenvio: Boolean;

  Function CriptografarMensagemEmail(const S: WideString; Key: Word; CKey1, CKey2: Integer): String;
  Function DescriptografarMensagemEmail(const S: String; Key: Word; CKey1, CKey2: Integer): String;
  Function CriptografarSenhaEmail(strSenha: String): String;
  Function ValidarDiretorioEmail(out diretorio: String): Boolean;
  Function CompactarArquivos(diretorio, nomeArquivoZip: String; nomeArquivosComprimir: TStringArray; deletarArquivo: Boolean = True): Boolean;
  Function DescompactarArquivos(diretorio, nomeArquivoZip: String; deletarArquivoZip: Boolean = False): Boolean;
  Procedure InicializarComponentesIndy(AOwner: TComponent; Var AIdSMTP: TIdSMTP; Var AIdMessage: TIdMessage;
    Var ASSLSocket: TIdSSLIOHandlerSocketOpenSSL; ADadosAutenticacao: TAutenticacaoEmail);
  Function fRetVersaoTLSSSL: TIdSSLVersion;
  Function fRetModeSSL: TIdSSLMode;

implementation

uses untTCadastroProvedores, untGravando, untConstantes, untTEnvioEmailOutlookOAuth2,
  untModulo, System.IOUtils, untThreadUtils, Windows, untVersaoProg, untImagemBase64;

{ TAutenticacaoEmail }

constructor TAutenticacaoEmail.Create(strCodOpe, strEmail, strLogin, strRemete, strSenha: String;
  intCodPrv: Integer; AValidaSenha: Boolean);
begin
  if (fEmptyStr(strCodOpe)) then
    fMensagem('Alerta', 'Código do usuário logado deve ser informado.', ['&Ok'])
  else if (fEmptyStr(strEmail)) then
    fMensagem('Alerta', 'E-Mail de autenticação deve ser informado.', ['&Ok'])
  else if (fEmptyStr(strLogin)) then
    fMensagem('Alerta', 'Login de autenticação deve ser informado.', ['&Ok'])
  else if (fEmptyStr(strSenha) And AValidaSenha) then
    fMensagem('Alerta', 'Senha de conta de e-Mail de autenticação deve ser informado.', ['&Ok'])
  else if (intCodPrv <= 0) then
    fMensagem('Alerta', 'Provedor de e-Mail para autenticação deve ser informado.', ['&Ok'])
  else
  begin
    Try
      CarregaDadosDoProvedor(intCodPrv);

      if FDatasetProvedor.IsEmpty then
      begin
        fMensagem('Alerta', 'Provedor de e-mail para autenticação não encontrado.', ['&Ok']);
        Exit;
      End;

      DefinirDadosAutenticacao(FDatasetProvedor.FieldByName('PRV_LIMARQ').AsInteger,
                               FDatasetProvedor.FieldByName('PRV_CODPRV').AsInteger,
                               FDatasetProvedor.FieldByName('PRV_PORPRV').AsInteger,
                               FDatasetProvedor.FieldByName('PRV_PTIMAP').AsInteger,
                               strSenha,
                               strEmail,
                               strLogin,
                               strRemete,
                               FDatasetProvedor.FieldByName('PRV_URSMTP').AsString,
                               FDatasetProvedor.FieldByName('PRV_URIMAP').AsString,
                               strCodOpe,
                               blnSSLEnt,
                               blnSSLSai,
                               strGravaPastaEnviados);
    Except
      Raise;
    End;
  end;
end;

class function TAutenticacaoEmail.AutenticarServidorSMTP(ADadosAutenticacao: TAutenticacaoEmail;
  var AIdSMTP: TIdSMTP; var AConexaoProvedor: Boolean;
  AAtualizarIDAzure: Boolean = False): Boolean;
begin
  Try
    If Not ADadosAutenticacao.UsaAuthenticacaoOAuth2 Then
    Begin
      If (Not AIdSMTP.Connected) Then
      Begin
        AIdSMTP.Connect();

        AConexaoProvedor := AIdSMTP.Connected;

        If Not AConexaoProvedor Then
          Exit(False);
      End;

      AConexaoProvedor := True;
      Exit(AIdSMTP.Authenticate);
    End;

    AConexaoProvedor := True;

    If AAtualizarIDAzure Then
      CarregaIDEmailAzure(ADadosAutenticacao);

    Result := Not ADadosAutenticacao.AutenticacaoOAuth2.GetToken.IsEmpty;
  Except
    Raise;
  End;
end;

procedure TAutenticacaoEmail.CarregaDadosDoProvedor(ACodigoProvedor: Integer);
begin
  If Not Assigned(FDatasetProvedor) Then
  Begin
    FDatasetProvedor := fCriaClientDataSet('SELECT * FROM CADPRV WHERE FALSE');
    FDatasetProvedor.Open;
  End;

  If ACodigoProvedor <= 0 Then
    Exit;

  FDatasetProvedor := TCadastroProvedores.RetornaProvedorPorID(ACodigoProvedor);

  blnSSLSai := FDatasetProvedor.FieldByName('PRV_SSLSAI').AsString.Equals('S');
  blnSSLEnt := FDatasetProvedor.FieldByName('PRV_SSLENT').AsString.Equals('S');
  strGravaPastaEnviados := LeftStr(FDatasetProvedor.FieldByName('PRV_GRVENV').AsString, 1);

  SetLimiteArq(FDatasetProvedor.FieldByName('PRV_LIMARQ').AsInteger);

  FUsaAuthenticacaoOAuth2 := FDatasetProvedor.FieldByName('PRV_USAOA2').AsString.Equals('S');
  FClientId := FDatasetProvedor.FieldByName('PRV_CLI_ID').AsString;
  FClientSecret := FDatasetProvedor.FieldByName('PRV_CLISEC').AsString;
  FTenantId := FDatasetProvedor.FieldByName('PRV_TENAID').AsString;

  SetProvedor(ACodigoProvedor);
  SetPortaSmtp(FDatasetProvedor.FieldByName('PRV_PORPRV').AsInteger);
  SetPortaImap(FDatasetProvedor.FieldByName('PRV_PTIMAP').AsInteger);
  SetServidorSmtp(FDatasetProvedor.FieldByName('PRV_URSMTP').AsString);
  SetServidorImap(FDatasetProvedor.FieldByName('PRV_URIMAP').AsString);

  If FUsaAuthenticacaoOAuth2 Then
    FAutenticacaoOAuth2 := TEnvioEmailAutenticacaoOAuth2.Create(FUsuario,
                                                                ACodigoProvedor,
                                                                FClientId,
                                                                FClientSecret,
                                                                FTenantId);
end;

class procedure TAutenticacaoEmail.CarregaIDEmailAzure(
  var ADadosAutenticacao: TAutenticacaoEmail);
begin
  Try
    ADadosAutenticacao.EmailIdAzure :=
      ADadosAutenticacao.AutenticacaoOAuth2.RetornaIDEmailAzureOutlook(ADadosAutenticacao.FUsuario);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TAutenticacaoEmail.CarregarStreamImagem(
  var AImageStream: TMemoryStream; AImagemBase64: String);
  var
    LImagemByte: TBytesStream;
begin
  If Not AImagemBase64.isEmpty Then
  Begin
    LImagemByte := TBytesStream.Create(nil);
    fStreamFromBase64(AImagemBase64, LImagemByte);

    Try
      If (LImagemByte.Size > 0) Then
      Begin
        LImagemByte.SaveToStream(AImageStream);
        AImageStream.Position := 0;
      End;
    Finally
      LImagemByte.Free;
    End;
  End;
end;

class function TAutenticacaoEmail.ConnectIdIMAP(var AIdIMAP: TIdIMAP4;
  AUsuario: String; ADadosAutorizacao: TAutenticacaoEmail): Boolean;
begin

  Try
    If ADadosAutorizacao.UsaAuthenticacaoOAuth2 Then
      Exit(TEnvioEmailOutlookOAuth2.Create(ADadosAutorizacao.AutenticacaoOAuth2).ListaPastasImap.Count > 0);

    Result := AIdIMAP.Connect();
  Except
    On Ex: Exception Do
    Begin
      Try
        If ADadosAutorizacao.UsaAuthenticacaoOAuth2 Then
          Raise Ex;

        AIdIMAP.Username := AUsuario;
        Result := AIdIMAP.Connect();
      Except
        On E: Exception Do
        Begin
          Raise Exception.Create(E.Message);
        End;
      End;
    End;
  End;
end;

constructor TAutenticacaoEmail.Create(strCodOpe, strUrlSmtp, strUrlImap: String;
  intProvedor, intPortaSmtp, intPortaImap: Integer; blnSSLEnt, blnSSLSai: Boolean);
begin
  SetProvedor(intProvedor);

  CarregaDadosDoProvedor(intProvedor);

  If FDatasetProvedor.IsEmpty Then
  Begin
    SetPortaSmtp(intPortaSmtp);
    SetPortaImap(intPortaImap);
    SetServidorSmtp(strUrlSmtp);
    SetServidorImap(strUrlImap);
    FSSLSai := blnSSLSai;
    FSSLEnt := blnSSLEnt;
    FGravaPastaEnviados := 'S';
    SetLimiteArq(10);
  End;

  SetCodOpe(strCodOpe);
end;

Procedure TAutenticacaoEmail.DefinirDadosAutenticacao(ALimiteArq, AProvedor, APortaSmtp, APortaImap: Integer;
  ASenha, AUsuario, ALogin, ARemete, AServidorSmtp, AServidorImap, ACodOpe: String; ASSLEnt, ASSLSai: Boolean; AGravaPastaEnviados: String);
begin
  SetProvedor(AProvedor);
  SetPortaSmtp(APortaSmtp);
  SetPortaImap(APortaImap);
  SetSenha(ASenha);
  SetUsuario(AUsuario);
  SetLogin(ALogin);
  SetRemete(ARemete);
  SetServidorSmtp(AServidorSmtp);
  SetServidorImap(AServidorImap);
  SetLimiteArq(ALimiteArq);
  SetCodOpe(ACodOpe);
  FSSLSai := ASSLSai;
  FSSLEnt := ASSLEnt;
  FGravaPastaEnviados := AGravaPastaEnviados;

  FEmailIdAzure := EmptyStr;
  If Not ACodOpe.IsEmpty Then
    FEmailIdAzure := fCampoTabela('OPE_EMA_ID', 'CADOPE', ['OPE_CODOPE'], [ACodOpe]);
end;

destructor TAutenticacaoEmail.Destroy;
begin
  If (Assigned(FImagemAssinatura)) Then
    FImagemAssinatura.Free();

  FreeAndNil(FTextoAssinatura);

  If Assigned(FDatasetProvedor) Then
  Begin
    FDatasetProvedor.Close;
    FreeAndNil(FDatasetProvedor);
  End;

  If Assigned(FAutenticacaoOAuth2) Then
    FreeAndNil(FAutenticacaoOAuth2);

  inherited;
end;

constructor TAutenticacaoEmail.Create(strCodUsuario, strNomOpe: String; blnEmailAut: Boolean);
begin
  if (fEmptyStr(strCodUsuario)) then
    fMensagem('Alerta', 'Código do usuário logado deve ser informado.', ['&Ok'])
  else
    DefinirDadosAutenticacao(strCodUsuario, strNomOpe, blnEmailAut);
end;

procedure TAutenticacaoEmail.DefinirDadosAutenticacao(strCodUsuario, strNomOpe: String; blnEmailAut: Boolean);

  procedure InicializarAtributos(ACodigoOperador: String);
    var
      LConsulta: TUniQuery;
  begin
    LConsulta := fCriaQuery;

    Try
      LConsulta.SQL.Text := 'SELECT O.OPE_NOMOPE, ' +
                            '       O.OPE_E_NOME, ' +
                            '       O.OPE_E_MAIL, ' +
                            '       O.OPE_CODOPE, ' +
                            '       O.OPE_EMALOG, ' +
                            '       O.OPE_PRVSEN, ' +
                            '       O.OPE_CODPRV, ' +
                            '       O.OPE_EMA_ID, ' +
                            '       A.* ' +
                            'FROM CADOPE O ' +
                            'LEFT JOIN OPEASS A ON A.ASS_CODOPE=O.OPE_CODOPE ' +
                            'WHERE O.OPE_CODOPE=:CODOPE';

      LConsulta.ParamByName('CODOPE').AsString := ACodigoOperador;
      LConsulta.Open;

      If Not LConsulta.IsEmpty Then
      Begin
        FNomeOpe := LConsulta.FieldByName('OPE_NOMOPE').AsString;
        FRemetente := LConsulta.FieldByName('OPE_E_NOME').AsString;

        If Not MatchStr(LConsulta.FieldByName('OPE_CODPRV').AsString, [EmptyStr, '0']) Then
        Begin
          CarregaDadosDoProvedor(LConsulta.FieldByName('OPE_CODPRV').AsInteger);

          SetSenha(CriptografarSenhaEmail(LConsulta.FieldByName('OPE_PRVSEN').AsString));
          SetUsuario(LConsulta.FieldByName('OPE_E_MAIL').AsString);
          SetLogin(LConsulta.FieldByName('OPE_EMALOG').AsString);
          SetCodOpe(ACodigoOperador);
          FEmailIdAzure := LConsulta.FieldByName('OPE_EMA_ID').AsString;
        End;

        If  Not LConsulta.FieldByName('ASS_CODOPE').AsString.IsEmpty Then
        Begin
          FImagemAssinaturaValida := Not LConsulta.FieldByName('ASS_IMGB64').AsString.IsEmpty;

          FTextoAssinatura.Text := AnsiReplaceStr(LConsulta.FieldByName('ASS_TEXTO_').AsString, STRING_QUEBRA, STRING_ENTER);

          If FImagemAssinaturaValida Then
            CarregarStreamImagem(FImagemAssinatura,
                                 LConsulta.FieldByName('ASS_IMGB64').AsString)
          Else
            FImagemAssinatura := Nil;
        End;
      End;
    Finally
      LConsulta.Close;

      FreeAndNil(LConsulta);
    End;
  End;

begin
  FNomeOpe                := '';
  FImagemAssinatura       := TMemoryStream.Create();
  FImagemAssinaturaValida := False;
  FTextoAssinatura        := TStringList.Create();

  If (blnEmailAut) Then
    FNomeOpe := strNomOpe
  Else
    InicializarAtributos(strCodUsuario);
end;

function TAutenticacaoEmail.EhValido: Boolean;
begin
  Result := (FPortaSmtp > 0)          And  //valida o número da porta do servidor de e-Mail
            ((not fEmptyStr(FSenha)) Or FUsaAuthenticacaoOAuth2) And //valida a senha do usuário do servidor de e-Mail
            (not fEmptyStr(FUsuario)) And  //valida o e-Mail do usuário
            (not fEmptyStr(FLogin)) And  //valida o Login do usuário
            (not fEmptyStr(FServidorSmtp));    //valida a URL do servidor SMTP
end;

class function TAutenticacaoEmail.fValidarAutenticacaoImap(ADadosAutenticacao: TAutenticacaoEmail): Boolean;
  Var
    IdIMAP: TIdIMAP4;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
Begin
  Result := True;

  If (Not fEmptyStr(ADadosAutenticacao.servidorImap)) And (ADadosAutenticacao.portaImap > 0) Then Begin
    IdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create();

    Try
      IdSSLIOHandlerSocketOpenSSL.Destination := ADadosAutenticacao.servidorImap + ':' +
        IntToStr(ADadosAutenticacao.portaImap);
      IdSSLIOHandlerSocketOpenSSL.Host := ADadosAutenticacao.servidorImap;
      IdSSLIOHandlerSocketOpenSSL.Port := ADadosAutenticacao.portaImap;
      IdSSLIOHandlerSocketOpenSSL.DefaultPort := 0;
      IdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := fRetVersaoTLSSSL();
      IdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLversions := [fRetVersaoTLSSSL()];
      IdSSLIOHandlerSocketOpenSSL.SSLOptions.Mode := fRetModeSSL;
      IdSSLIOHandlerSocketOpenSSL.SSLOptions.VerifyMode := [];
      IdSSLIOHandlerSocketOpenSSL.SSLOptions.VerifyDepth := 0;

      IdIMAP := TIdIMAP4.Create();

      Try
        IdIMAP.IOHandler := IdSSLIOHandlerSocketOpenSSL;
        IdIMAP.Host      := ADadosAutenticacao.servidorImap;
        IdIMAP.Password  := ADadosAutenticacao.senha;
        IdIMAP.Port      := ADadosAutenticacao.portaImap;

        If (Not ADadosAutenticacao.blnSSLEnt) Then
          IdIMAP.UseTLS  := utUseExplicitTLS
        Else
          IdIMAP.UseTLS  := utUseImplicitTLS;

        IdIMAP.Username  := ADadosAutenticacao.login;

        Try
          If (Not ConnectIdIMAP(IdIMAP,ADadosAutenticacao.usuario, ADadosAutenticacao)) Then Begin
            Result := False;
          End;
        Except
          On E: Exception Do Begin
            Result := False;
          End;
        End;
      Finally
        FreeAndNil(IdIMAP);
      End;
    Finally
      FreeAndNil(IdSSLIOHandlerSocketOpenSSL);
    End;
  End;
end;

class function TAutenticacaoEmail.fValidarAutenticacaoImap(AOwner: TComponent;
  ACodOpe, AUrlImap: String; APorta: Integer; ASSLEnt: Boolean): Boolean;
  Var
    IdIMAP: TIdIMAP4;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
Begin
  Result := True;

  If (Not fEmptyStr(AUrlImap)) And (APorta > 0) Then Begin
    IdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create();

    Try
      IdSSLIOHandlerSocketOpenSSL.Destination := AUrlImap + ':' +
        IntToStr(APorta);
      IdSSLIOHandlerSocketOpenSSL.Host := AUrlImap;
      IdSSLIOHandlerSocketOpenSSL.Port := APorta;
      IdSSLIOHandlerSocketOpenSSL.DefaultPort := 0;
      IdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := fRetVersaoTLSSSL();
      IdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLversions := [fRetVersaoTLSSSL()];
      IdSSLIOHandlerSocketOpenSSL.SSLOptions.Mode := fRetModeSSL;
      IdSSLIOHandlerSocketOpenSSL.SSLOptions.VerifyMode := [];
      IdSSLIOHandlerSocketOpenSSL.SSLOptions.VerifyDepth := 0;

      IdIMAP := TIdIMAP4.Create();

      Try
        IdIMAP.IOHandler := IdSSLIOHandlerSocketOpenSSL;
        IdIMAP.Host      := AUrlImap;
        IdIMAP.Password  := '';
        IdIMAP.Port      := APorta;

        If (Not ASSLEnt) Then
          IdIMAP.UseTLS  := utUseExplicitTLS
        Else
          IdIMAP.UseTLS  := utUseImplicitTLS;

        IdIMAP.Username  := '';

        Try
          If (Not IdIMAP.Connect(False)) Then Begin
            Result := False;
          End;
        Except
          On E: Exception Do Begin
            Result := False;
            fMensagem('ALERTA!', 'Houve um erro ao validar a conexão IMAP do seu procedor de e-Mail.' +
                           #13#10 + 'Verifique os dados informados e tente novamente!', ['&OK']);
          End;
        End;
      Finally
        FreeAndNil(IdIMAP);
      End;
    Finally
      FreeAndNil(IdSSLIOHandlerSocketOpenSSL);
    End;
  End;
end;

class function TAutenticacaoEmail.fValidarAutenticacaoSmtp(AOwner: TComponent; ACodOpe, AUrlSmtp: String;
  APorta: Integer; ASSLSai: Boolean; AAtualizarIDAzure: Boolean = False): Boolean;
  Var
    FIdSMTP   : TIdSMTP;
    FIdMessage: TIdMessage;
    FSSLSocket: TIdSSLIOHandlerSocketOpenSSL;

    LintTentativasConexaoEmail: Integer;
begin
  LintTentativasConexaoEmail := 0;
  repeat

    Try
      Result := False;
      Inc(LintTentativasConexaoEmail);

      Try
        InicializarComponentesIndy(AOwner,
                                   FIdSMTP,
                                   FIdMessage,
                                   FSSLSocket,
                                   TAutenticacaoEmail.Create(ACodOpe, AUrlSmtp, '', 0, APorta, 0, False, ASSLSai));

        If (Not FIdSMTP.Connected) Then
        Begin
          FIdSMTP.Connect();

          Result := FIdSMTP.Connected;
          FIdSMTP.Disconnect();
        End;
      Except
        On E: Exception Do
        Begin
          if LintTentativasConexaoEmail >= 3 then
          begin
            fMensagem('ALERTA!', 'Houve um erro ao validar a conexão SMTP do seu provedor de e-mail.' + #13 +
                                 'Erro gerado: ' + E.Message +
                                 #13#10 + 'Verifique os dados informados e tente novamente!', ['&OK']);
          End
          Else
            Sleep(2000);
        End;
      End;
    Finally
      FreeAndNil(FIdSMTP);
      FreeAndNil(FIdMessage);
      FreeAndNil(FSSLSocket);
    End;

  until ((LintTentativasConexaoEmail >= 3) or (Result));
end;

class function TAutenticacaoEmail.fValidarAutenticacaoSmtp(AOwner: TComponent; ADadosAutenticacao:
  TAutenticacaoEmail; out blnConexaoProvedor: Boolean; AAtualizarIDAzure: Boolean = False): Boolean;
  Var
    FIdSMTP   : TIdSMTP;
    FIdMessage: TIdMessage;
    FSSLSocket: TIdSSLIOHandlerSocketOpenSSL;

    LintTentativasConexaoEmail: Integer;
begin
  LintTentativasConexaoEmail := 0;
  repeat

    Try
      Result := False;
      Inc(LintTentativasConexaoEmail);
      blnConexaoProvedor := False;

      Try
        InicializarComponentesIndy(AOwner,
                                   FIdSMTP,
                                   FIdMessage,
                                   FSSLSocket,
                                   ADadosAutenticacao);

        Result := AutenticarServidorSMTP(ADadosAutenticacao,
                                         FIdSMTP,
                                         blnConexaoProvedor,
                                         AAtualizarIDAzure);
        FIdSMTP.Disconnect();

        If blnConexaoProvedor Then
          Exit(True);

        fMensagem('AVISO!', 'Não foi possível conectar com o provedor de e-Mail.' +
                             #13#10 + 'Verifique os dados informados e tente novamente!', ['&Ok']);
      Except
        On E: Exception Do Begin
          if LintTentativasConexaoEmail >= 3 then
          begin
            If (Pos('username and password not accepted', LowerCase(E.Message)) <= 0) And
              (Pos('authentication failed', LowerCase(E.Message)) <= 0) And
              (Pos('incorrect username or password', LowerCase(E.Message)) <= 0) Then
              fMensagem('ALERTA!', 'Houve um erro ao validar os dados da conta de e-Mail.' +
                                   #13#10 + 'Verifique os dados informados e tente novamente!' + #13 +
                                   'Erro gerado: ' + E.Message, ['&Ok']);
          end
          else
            Sleep(2000);
        End;
      End;
    Finally
      FreeAndNil(FIdSMTP);
      FreeAndNil(FIdMessage);
      FreeAndNil(FSSLSocket);
    End;

  until ((LintTentativasConexaoEmail >= 3) or (Result));
end;

function TAutenticacaoEmail.ImagemAssinaturaEhValida: Boolean;
begin
  Result := FImagemAssinaturaValida;
end;

procedure TAutenticacaoEmail.SetCodOpe(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    fMensagem('Alerta', 'Código do Operador deve ser informado.', ['&Ok'])
  Else
    FCodOpe := Value;
end;

procedure TAutenticacaoEmail.SetLimiteArq(const Value: Integer);
begin
  If (Value <= 0) Then
    fMensagem('Alerta', 'Limite de anexos do servidor de e-Mail deve ser maior que 0 (zero). Informado nas Configurações do Sistema.', ['&Ok'])
  Else
    FLimiteArq := Value;
end;

procedure TAutenticacaoEmail.SetLogin(const Value: String);
begin
  FLogin := Value;
end;

procedure TAutenticacaoEmail.SetPortaImap(const Value: Integer);
begin
  If (Value < 0) Then
    fMensagem('Alerta', 'Porta do servidor de e-Mail deve ser maior que 0 (zero). Informado nas Configurações do Sistema.', ['&Ok'])
  Else
    FPortaImap := Value;
end;

procedure TAutenticacaoEmail.SetPortaSmtp(const Value: Integer);
begin
  If (Value <= 0) Then
  Begin
    If (FTipPrv = 'F') Then
      fMensagem('Alerta', 'Porta do servidor de e-Mail deve ser maior que 0 (zero) na configuração do gatilho do email(CFG_EMASAI).', ['&Ok'])
    Else
      fMensagem('Alerta', 'Porta do servidor de e-Mail deve ser maior que 0 (zero). Informado nas Configurações do Sistema.', ['&Ok'])
  End
  Else
    FPortaSmtp := Value;
end;

procedure TAutenticacaoEmail.SetRemete(const Value: String);
begin
  FRemete := Value;
end;

procedure TAutenticacaoEmail.SetSenha(const Value: String);
begin
  FSenha := Value;

  If (fEmptyStr(Value)) Then
  Begin
    If (FTipPrv = 'F') Then
      fMensagem('Alerta', 'Senha do provedor de e-Mail deve ser informada na configuração do gatilho do email(CFG_EMASAI).', ['&Ok'])
    Else If fCampoTabela('PRV_USAOA2', 'CADPRV', ['PRV_CODPRV'], [FProvedor]) <> 'S' Then
      fMensagem('Alerta', 'Senha do provedor de e-Mail deve ser informada no cadastro do Operador.', ['&Ok']);
  End;

end;

procedure TAutenticacaoEmail.SetServidorImap(const Value: String);
begin
  FServidorImap := Value;
end;

procedure TAutenticacaoEmail.SetServidorSmtp(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    fMensagem('Alerta', 'URL do servidor de e-Mail deve ser informada. Informado nas Configurações do Sistema.', ['&Ok'])
  Else
    FServidorSmtp := Value;
end;

procedure TAutenticacaoEmail.SetUsuario(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    fMensagem('Alerta', 'Usuário (e-Mail) do servidor de e-Mail deve ser informado no cadastro do Operador.', ['&Ok'])
  Else If (Pos('@', Value) = 0) Then
    fMensagem('Alerta', 'Usuário (e-Mail) informado é inválido.', ['&Ok'])
  Else
    FUsuario := Value;
end;

procedure TAutenticacaoEmail.SetProvedor(const Value: Integer);
begin
  FProvedor := Value;
end;

{ TAnexo }

constructor TAnexo.Create(AArquivo: String);
begin
  FDescricao := '';
  SetArquivo(AArquivo);
end;

procedure TAnexo.SetArquivo(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    fMensagem('Alerta', 'Caminho do anexo deve ser informado.', ['&Ok'])
  Else If (not FileExists(Value)) Then
    fMensagem('Alerta', 'Caminho do anexo informado não é válido ou arquivo não existe.', ['&Ok'])
  Else
  Begin
    FArquivo := Value;

    If (Not (Pos(UpperCase('.html'), UpperCase(FArquivo)) > 0)) Then
      SetTamanhoArquivo();
  End;
end;

procedure TAnexo.SetTamanhoArquivo;
  Var
    strTemp: String;
    LArquivo: TFileStream;
begin
  if fArquivoExisteNoDiretorio(FArquivo, 40, 2000) then
  Begin
    LArquivo := TFileStream.Create(FArquivo, fmOpenRead Or fmShareExclusive);
    try
      try
        strTemp := 'KB';
        FTamanho:= LArquivo.Size / 1024;

        If (FTamanho > 1024) Then
        Begin
          strTemp := 'MB';
          FTamanho:= FTamanho / 1024;
        End;

        FDescricao := FArquivo + ' (' + FormatFloat('#,##0.00', FTamanho) + ' ' + strTemp + ')';
      except
        On e: EFOpenError Do
          fMensagem('ALERTA!', 'Houve um erro ao anexar o arquivo ao e-Mail. Verifique!', ['&OK']);

        On E: Exception Do
          pMensagensErro(E.Message, '[TEnvioEmail.SetTamanhoArquivo]');
      End;
    finally
      FreeAndNil(LArquivo);
    end;
  End;
end;

{ TAnexos }

constructor TAnexos.Create(ALimiteAnexos: Integer);
begin
  FArquivosAnexados := TList<TAnexo>.Create();
  SetLimiteAnexos(ALimiteAnexos);
  FTotalTamAnexos := 0;
end;

procedure TAnexos.SetLimiteAnexos(const Value: Integer);
begin
  FLimiteAnexos := Value * 1024;  //validações serão feitas em MB
end;

{ TMensagem }

procedure TMensagem.AdicionarAnexo(const Value: TAnexo);
  Var
    tamanho: Double;
begin
  If (FAnexos.FArquivosAnexados.IndexOf(Value) = -1) Then
  Begin
    If (Pos(' MB)', Value.FDescricao) > 0) Then
      tamanho := Value.FTamanho * 1024
    Else
      tamanho := Value.FTamanho;

    If ((FAnexos.FTotalTamAnexos + tamanho) > FAnexos.FLimiteAnexos) Then
    Begin
      If FblnGravarAnexosPath Then
      Begin
        pGravarAnexos(Value.FArquivo);
      End
      Else
        fMensagem('Alerta', 'Limite permitido de arquivos em anexo foi atingido. Anexo não será adicionado a mensagem.', ['&Ok']);
    End
    Else
    Begin
      If (Not (Pos(UpperCase('.html'), UpperCase(Value.FArquivo)) > 0)) Then //não anexa arquivos '*.html'
      Begin
        FAnexos.FTotalTamAnexos := FAnexos.FTotalTamAnexos + Value.FTamanho;
        FAnexos.FArquivosAnexados.Add(Value);
      End
      Else
      Begin
        //se o anexo for '*.html' será usado no corpo da mensagem
        If (FAnexos.FArquivosAnexados.Count = 0) Then
        Begin
          FCorpoMensagem.Clear();
          FCorpoMensagem.LoadFromFile(Value.FArquivo);
          FCorpoHtml := True;
        End;
      End;
    End;
  End
  Else
    fMensagem('Alerta', 'Anexo duplicado. Verifique!', ['&Ok']);
end;

function TMensagem.AdicionarAssunto(const Value: String): Boolean;
begin
  SetAssunto(Value);
  Result := (not fEmptyStr(FAssunto));
end;

function TMensagem.AdicionarComCopia(const Value: String): Boolean;
begin
  Result := False;

  If (fEmptyStr(Value)) Then
    fMensagem('Alerta', 'Destinatário (Com Cópia) deve ser informado.', ['&Ok'])
  Else If (Pos('@', Value) = 0) Or (Pos(';', Value) > 0) Or (Pos(',', Value) > 0) Then
    fMensagem('Alerta', 'Destinatário (Com Cópia) é inválido.', ['&Ok'])
  Else If (Not fEnderecoEmailValido(Value)) Then
    fMensagem('Alerta', 'Destinatário (Com Cópia) é inválido.', ['&Ok'])
  Else
  Begin
    If (FComCopia.IndexOf(Value) = -1) Then
      FComCopia.Add(Value);

    Result := True;
  End;
end;

function TMensagem.AdicionarComCopiaOculta(const Value: String): Boolean;
begin
  Result := False;

  If (fEmptyStr(Value)) Then
    fMensagem('Alerta', 'Destinatário (Com Cópia Oculta) deve ser informado.', ['&Ok'])
  Else If (Pos('@', Value) = 0) Or (Pos(';', Value) > 0) Or (Pos(',', Value) > 0) Then
    fMensagem('Alerta', 'Destinatário (Com Cópia Oculta) é inválido.', ['&Ok'])
  Else If (Not fEnderecoEmailValido(Value)) Then
    fMensagem('Alerta', 'Destinatário (Com Cópia Oculta) é inválido.', ['&Ok'])
  Else
  Begin
    If (FComCopiaOculta.IndexOf(Value) = -1) Then
      FComCopiaOculta.Add(Value);

    Result := True;
  End;
end;

procedure TMensagem.AdicionarImagemCorpoHtml(caminhoArquivo: String);
begin
  If (fEmptyStr(caminhoArquivo)) Then
    fMensagem('Alerta', 'Caminho da imagem do corpo do HTML não pode ser vazio.', ['&Ok'])
  Else If (FImagensCorpoHtml.IndexOf(TImagemCorpoHtml.Create(caminhoArquivo)) = -1) Then
    FImagensCorpoHtml.Add(TImagemCorpoHtml.Create(caminhoArquivo));
end;

procedure TMensagem.AdicionarMensagem(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    fMensagem('Alerta', 'Mensagem deve ser informada.', ['&Ok'])
  Else
    FCorpoMensagem.Text := Value;
end;

function TMensagem.AdicionarPara(const Value: String): Boolean;
begin
  Result := False;

  If (fEmptyStr(Value)) Then
    fMensagem('Alerta', 'Destinatário (Para) deve ser informado.', ['&Ok'])
  Else If (Pos('@', Value) = 0) Or (Pos(';', Value) > 0) Or (Pos(',', Value) > 0) Then
    fMensagem('Alerta', 'Destinatário (Para) é inválido.', ['&Ok'])
  Else If (Not fEnderecoEmailValido(Value)) Then
    fMensagem('Alerta', 'Destinatário (Para) é inválido.', ['&Ok'])
  Else
  Begin
    If (FPara.IndexOf(Value) = -1) Then
      FPara.Add(Value);

    Result := True;
  End;
end;

constructor TMensagem.Create(ALimiteAnexos: Integer);
begin
  FAnexos           := TAnexos.Create(ALimiteAnexos);
  FAssunto          := '';
  FNomeSaudacao     := '';
  FCorpoMensagem    := TStringList.Create();
  FImagensCorpoHtml := TList<TImagemCorpoHtml>.Create();

  FPara           := TStringList.Create();
  FComCopia       := TStringList.Create();
  FComCopiaOculta := TStringList.Create();

  FMensagemAutomatica := False;
end;

destructor TMensagem.Destroy;
begin
  FreeAndNil(FPara);
  FreeAndNil(FAnexos);
  FreeAndNil(FComCopia);
  FreeAndNil(FCorpoMensagem);
  FreeAndNil(FComCopiaOculta);
  FreeAndNil(FImagensCorpoHtml);
end;

function TMensagem.EhValida: Boolean;
begin
  Result := (not fEmptyStr(FAssunto))            And  //valida o assunto da mensagem
            (not fEmptyStr(FNomeSaudacao))       And  //valida a saudacao da mensagem
            ((FPara.Count > 0)
              Or (FComCopia.Count > 0)
              Or (FComCopiaOculta.Count > 0))    And  //valida os destinatários da mensagem
            (FAnexos.FTotalTamAnexos <= FAnexos.FLimiteAnexos);  //valida o total de anexos da mensagem
end;

procedure TMensagem.Limpar;
begin
  FAssunto            := '';
  FCorpoHtml          := False;
  FMensagemAutomatica := False;

  FPara.Clear();
  FComCopia.Clear();
  FCorpoMensagem.Clear();
  FComCopiaOculta.Clear();
  FImagensCorpoHtml.Clear();
  FAnexos.FArquivosAnexados.Clear();
end;

procedure TMensagem.LimparComCopia;
begin
  FComCopia.Clear();
end;

procedure TMensagem.LimparComCopiaOculta;
begin
  FComCopiaOculta.Clear();
end;

procedure TMensagem.LimparPara;
begin
  FPara.Clear();
end;

procedure TMensagem.pGravarAnexos(const strAquivo: String);
var
  intCnt: Integer;
  strPath: String;
  strFileName: String;
begin
  strPath := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'EnvioEmail';
  If Not DirectoryExists(strPath)  Then
    CreateDir(strPath);

  strPath := IncludeTrailingPathDelimiter(strPath) + FormatDateTime('yyyymmdd_hhnnsszzz', fNow) ;
  If Not DirectoryExists(strPath)  Then
    CreateDir(strPath);

  For intCnt := 0 To FAnexos.FArquivosAnexados.Count - 1 Do
  Begin
    strFileName := ExtractFileName(FAnexos.FArquivosAnexados[intCnt].FArquivo);
    TFile.Copy(PChar(FAnexos.FArquivosAnexados[intCnt].FArquivo), PChar( strPath + strFileName), True);
  End;

  strFileName := IncludeTrailingPathDelimiter(strPath) + ExtractFileName(strAquivo);
  TFile.Copy(PChar(strAquivo), PChar(strFileName), True);

  fMensagem('Alerta', 'Limite permitido de arquivos em anexo foi atingido. Anexo não será adicionado a mensagem.' + #13#10 +
                      'Verifique os arquivos gerados na pasta "' + strPath + '" para envio manual.' , ['&Ok']);

end;

procedure TMensagem.RemoverAnexo(const Value: String);
  Var
    i: Integer;
    anexo: TAnexo;
begin
  anexo := nil;

  For i := 0 To FAnexos.FArquivosAnexados.Count - 1 Do
    If (FAnexos.FArquivosAnexados[i].FArquivo = Value) Then
      anexo := FAnexos.FArquivosAnexados[i];

  If (Assigned(anexo)) Then
  Begin
    FAnexos.FTotalTamAnexos := FAnexos.FTotalTamAnexos - anexo.tamanho;
    FAnexos.FArquivosAnexados.Remove(anexo);
  End
  Else
    fMensagem('Alerta', 'Anexo não pode ser removido.', ['&Ok'])
end;

procedure TMensagem.RemoverTodosAnexos;
begin
  FAnexos.FArquivosAnexados.Clear();
  FAnexos.FTotalTamAnexos := 0;
end;

procedure TMensagem.SetAssunto(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    fMensagem('Alerta', 'Assunto da mensagem deve ser informado.', ['&Ok'])
  Else
    FAssunto := Value;
end;

procedure TMensagem.SetNomeSaudacao(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    fMensagem('Alerta', 'Nome de Saudação da mensagem deve ser informado.', ['&Ok'])
  Else
    FNomeSaudacao := Value;
end;

{ TEnvioEmail }

function TEnvioEmail.AcertaVariaveisVensagemBloqueio(ATexto, ANomeGrupoModelo,
  ANomeModelo, AErroProvedor: String): String;
begin
  Result := ATexto.Replace('<<CODIGO_GRUPO>>', FCodigoGrupoModelo)
                  .Replace('<<NOME_GRUPO>>', ANomeGrupoModelo)
                  .Replace('<<CODIGO_MODELO>>', FCodigoModelo)
                  .Replace('<<NOME_MODELO>>', ANomeModelo)
                  .Replace('<<PROVEDOR>>', fCampoTabela('PRV_NOMPRV', 'CADPRV', ['PRV_CODPRV'], [FDadosAutenticacao.FProvedor]))
                  .Replace('<<EMAIL_REMETENTE>>', FDadosAutenticacao.login)
                  .Replace('<<EMPRESA_MODELO>>', VS_strCodEmp)
                  .Replace('<<ERRO_PROVEDOR>>', AErroProvedor)
                  .Replace('<<CODIGO_CLIENTE>>', FCodCli)
                  .Replace('<<NOME_CLIENTE>>', fRetNomCliente(FCodCli))
                  .Replace('<<EMAIL_DESTINATARIO>>', FEmailBloqueado);
end;

class function TEnvioEmail.ContruirArrayMensagem(ATexto: String): TStringArray;
  var
    i: Integer;
    arrTexto: TStringArray;
    stlTexto: TStringList;
begin
  Result := [];

  If (fEmptyStr(ATexto)) Then Exit;

  Try
    stlTexto := TStringList.Create();

    stlTexto.Text := ATexto;

    SetLength(arrTexto, stlTexto.Count);

    For i := 0 To stlTexto.Count - 1 Do
      arrTexto[i] := stlTexto[i];

    Result := arrTexto;
  Finally
    FreeAndNil(stlTexto);
  End;
end;

constructor TEnvioEmail.Create(AOwner: TComponent; blnEmailAut: Boolean; strNomOpe: String; intLimArq: Integer);
begin
  inherited Create(Owner);

  FDadosAutenticacao := TAutenticacaoEmail.Create(strLoginUsuarioLogado, strNomOpe, blnEmailAut);

  If (blnEmailAut) Then
    FMensagem := TMensagem.Create(intLimArq)
  Else
    FMensagem := TMensagem.Create(FDadosAutenticacao.FLimiteArq);

  If Not fEmptyStr(FDadosAutenticacao.FRemetente) Then
    FMensagem.SetNomeSaudacao(FDadosAutenticacao.FRemetente)
  Else
    FMensagem.SetNomeSaudacao(FDadosAutenticacao.FNomeOpe);

  FMensagem.FCorpoHtml := False;
  FEnviado     := False;
  FImportante  := False;
  FAnexosCount := 0;
  FHoraEnvio   := 0;
  FMensagem.blnGravarAnexosPath := FblnGravarAnexosPath;

  Self.blnEmailAut := blnEmailAut;

  FValidarErros := True;

  If (Not blnEmailAut) Then
    InicializarComponentes();
end;

procedure TEnvioEmail.pLogErros(GravarErro: Boolean; MensagemErro, strRelatorio: String);
begin
  If GravarErro Then
  Begin
    If fTipoErroGravaEmailErrosLog(MensagemErro) Then
      untFuncoesSimples.pGravarEmailErros('C', strCodCli, FMensagem.FAssunto, GetDestinatario(MensagemErro), MensagemErro)
    Else
      untFuncoesSimples.pGravarErro(GravarErro, MensagemErro, strRelatorio);
  End;
end;

class procedure TEnvioEmail.pMensagemErroEnviaEmail(strMsgErro: string);
begin
  if (Pos('Authentication failed', strMsgErro) > 0) Or
     (Pos('authentication failed', strMsgErro) > 0) then
  begin
    untFuncoesSimples.fMensagem('AVISO!', 'Falha na autenticação com o provedor. Favor rever configurações para este operador!', ['&OK']);
  end
  else if (Pos('Account IS temporarily unavailable', strMsgErro) > 0) then
  begin
    untFuncoesSimples.fMensagem('AVISO!', 'Provedor fora do ar. Verifique seu provedor de E-mail!', ['&OK']);
  end
  else if (Pos('Domain not found', strMsgErro) > 0) then
  begin
    untFuncoesSimples.fMensagem('AVISO!', 'Falha no envio do E-mail. Domínio informado não encontrado!', ['&OK']);
  end
  else if (Pos('Cannot open file', strMsgErro) > 0) then
  begin
    untFuncoesSimples.fMensagem('AVISO!', 'Falha no envio do E-mail. O sistema não conseguiu abrir o arquivo anexo!', ['&OK']);
  end
  else if (Pos('User unknown', strMsgErro) > 0) then
  begin
    untFuncoesSimples.fMensagem('AVISO!', 'Falha no envio do E-mail. Usuário de E-mail desconhecido!', ['&OK']);
  end
  else if (Pos('no mailbox here by that name', strMsgErro) > 0) then
  begin
    untFuncoesSimples.fMensagem('AVISO!', 'Falha no envio do E-mail. Não há nenhuma conta de e-mail com este nome!', ['&OK']);
  end
  else if (Pos('you are sending too many mails, slow down', strMsgErro) > 0) then
  begin
    untFuncoesSimples.fMensagem('AVISO!', 'Ultrapassada a quantidade por hora de envio/recebimento de mensagens!', ['&OK']);
  end
  else if fTipoErroGravaEmailErrosLog(strMsgErro) then
  begin
    untFuncoesSimples.fMensagem('', strMsgErro, ['&OK']);
  end
  else
  begin
    pMensagensErro(strMsgErro, '[TEnvioEmail.ConsultarMensagensRecebidas]');
  end;
end;

function TEnvioEmail.ReenviarEmailAutenticado(AEmailEnviado,
  AAutenticado: Boolean): Boolean;
begin
  Result := False;

  If AEmailEnviado Then
    Exit;

  If AAutenticado Then
    Exit;

  If Not FCodigoGrupoModelo.Equals('009') Then
    Exit;

  If Not FEmailsModelosAutenticados.Contains(Concat(FCodigoGrupoModelo, FCodigoModelo, '_')) Then
    Exit;

  If Not FValidarErros Then
    Exit(True);

  Try
    FValidarErros := False;

    Try
      If FIdSMTP.Connected Then
        FIdSMTP.Disconnect();

      Sleep(30000);
      EnviarMensagem;

      Result := FEnviado;
    Except
      Raise;
    End;
  Finally
    FValidarErros := True;
  End;
end;

class function TEnvioEmail.CriarAnexosZipMensagem(ANomeArquivoZip: String; AMensagem: TIdMessage): TArrayDadosAnexos;
  Var
    i: Integer;
    diretorioEmail, nomeArquivo, diretorioArquivo: String;
begin
  SetLength(Result, 0);

  If (Assigned(AMensagem)) Then Begin
    If (AMensagem.MessageParts.Count > 0)
      And ValidarDiretorioEmail(diretorioEmail) Then Begin

      nomeArquivo := StringReplace(ANomeArquivoZip, '.zip', '', [rfReplaceAll]);
      diretorioArquivo := diretorioEmail + nomeArquivo + '\';

      If (Not DirectoryExists(diretorioArquivo)) Then
        MkDir(diretorioArquivo);

      For i := 0 To AMensagem.MessageParts.Count - 1 Do Begin
        If (AMensagem.MessageParts[i] is TIdAttachment) Then Begin
          With TIdAttachment(AMensagem.MessageParts[i]) Do Begin
            SetLength(Result, Length(Result) + 1);
            Result[Length(Result) - 1].contentID   := ContentId;
            Result[Length(Result) - 1].nomeArquivo := ExtractFileName(FileName);

            If (Not FileExists(diretorioArquivo + Result[Length(Result) - 1].nomeArquivo)) Then
              SaveToFile(diretorioArquivo + Result[Length(Result) - 1].nomeArquivo);
          End;
        End;
      End;

      If (Length(Result) = 0) Then
        RemoveDir(diretorioArquivo);
    End;
  End;
end;

procedure TEnvioEmail.DefinirDadosAutenticacao(ALimiteArq, AProvedor, APortaSmtp, APortaImap: Integer;
  ASenha, AUsuario, ALogin, ARemete, AServidorSmtp, AServidorImap, ACodOpe: String; ASSLEnt, ASSLSai: Boolean; AGravaPastaEnviados: String);
begin
  If (Assigned(FIdSMTP)) Then
  Begin
    FDadosAutenticacao.DefinirDadosAutenticacao(ALimiteArq, AProvedor, APortaSmtp, APortaImap,
      ASenha, AUsuario, ALogin, ARemete, AServidorSmtp, AServidorImap, ACodOpe, ASSLEnt, ASSLSai, AGravaPastaEnviados);

    FIdSMTP.Host     := FDadosAutenticacao.servidorSmtp;
    FIdSMTP.Username := FDadosAutenticacao.login;
    FIdSMTP.Password := FDadosAutenticacao.senha;
    FIdSMTP.Port     := FDadosAutenticacao.portaSmtp;
  End Else
    untFuncoesSimples.fMensagem('Alerta', 'Dados de autenticação não puderam ser alterados.', ['&Ok']);
end;

destructor TEnvioEmail.Destroy;
begin
  if Not Assigned(ThreadSincEmail) then
  Begin
    FreeAndNil(FIdSMTP);
    FreeAndNil(FIdMessage);
    FreeAndNil(FSSLSocket);
  End;

  FreeAndNil(FMensagem);

  If Assigned(FChavesBloqueioEmails) Then
  Begin
    FChavesBloqueioEmails.Close;

    FreeAndNil(FChavesBloqueioEmails);
  End;

  inherited;
end;

function TEnvioEmail.DeveGravarEmailDoClienteNaBlackList(
  AMensagemErro: String): Boolean;
  Var
    LInserir: TUniQuery;

    LContador: Integer;

    LEmail: String;
begin
  Result := FChavesBloqueioEmails.FieldByName('CHA_GRALST').AsString.Equals('S');

  If Not Result Then
    Exit;

  LEmail := EmptyStr;
  For LContador := 0 To FMensagem.FPara.Count - 1 Do
  Begin
    If AMensagemErro.Contains(FMensagem.FPara[LContador]) Then
    Begin
      LEmail := FMensagem.FPara[LContador];
      Break;
    End;
  End;

  FEmailBloqueado := LEmail;

  LInserir := fCriaQuery;
  Try
    LInserir.SQL.Text := 'SELECT * FROM EMABLK WHERE FALSE';
    LInserir.Open;

    LInserir.Append;
    LInserir.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('EMABLK', VS_strCodEmp);
    LInserir.FieldByName('BLK_CODCLI').AsString := FCodCli;
    LInserir.FieldByName('BLK_EMAIL_').AsString := LEmail;
    LInserir.FieldByName('BLK_DTACAD').AsDateTime := fRetDataServidor;
    LInserir.FieldByName('BLK_HORCAD').AsDateTime := fRetHoraServidor;
    LInserir.FieldByName('BLK_CODOPE').AsString := strLoginUsuarioLogado;
    LInserir.FieldByName('BLK_GRUEMA').AsString := FCodigoGrupoModelo;
    LInserir.FieldByName('BLK_CODEMA').AsString := FCodigoModelo;
    LInserir.FieldByName('BLK_ERRPRV').AsString := AMensagemErro;
    LInserir.Post;
  Finally
    LInserir.Close;

    FreeAndNil(LInserir);
  End;
end;

function TEnvioEmail.DeveGravarErroEnvioAutomatico(
  AAutenticado: Boolean): Boolean;
begin
  Result := False;

  If AAutenticado Then
    Exit(Concat(FCodigoGrupoModelo, FCodigoModelo) <> VS_ModeloEmailNaoAutenticado);

  If Not MatchStr(FCodigoGrupoModelo, ['009', '025']) Then
    Exit(True);

  If Concat(FCodigoGrupoModelo, FCodigoModelo) <> VS_ModeloEmailNaoAutenticado Then
    Exit(True);
end;

class function TEnvioEmail.EnviarEmail(AOwner: TComponent; ACodOperador, AAssunto: String;
  APara, AComCopia, AComCopiaOculta, ACorpoMensagem, AAnexos: TStringArray;
  AAbrirEditor: Boolean = true; AImportante: Boolean = False; strAutInc: String = ''; strIncCon: String = ''; intCodEma: Int64 = 0; blnEmailAut: Boolean = False;
  strSenha : String = ''; strEmail : String = ''; strLogin : String = ''; strRemete : String = ''; intProvedor: Integer = 0; intPorSmt: Integer = 0; intPorIma: Integer = 0; strSerSmt: String = '';
  strSerIma: String = ''; intLimArq: Integer = 0; blnImgAss: Boolean = False; strTxtAss: String = ''; mmsImaAss: TMemoryStream = Nil; strNomOpe: String = '';
  strImgCorpo: String = ''; blnSSLSai: Boolean = False; blnSSLEnt: Boolean = False; strGravaPastaEnviados: String = 'S'; strEnvAutCob: String = 'N'; strCodCli : String = ''; strCodFor : String = '';
  blnAdicionaUmParagrafoPorLinha: Boolean = True; blnExibirMensagem: Boolean = True; blnExibeStatus: Boolean = True;ADuplicatasEnvio: TArrDupTabelaEmail = Nil;
  blnGravarAnexos: Boolean = False; AHabilitaDivisaoAnexoPorEmail: Boolean = False; ACodOco: String = ''; ANotFic: String = ''): Boolean;
  Var
    strAssunto : String;
Begin
  strAssunto := AAssunto;
  Result := EnviarEmail(AOwner, ACodOperador, APara, AComCopia, AComCopiaOculta,
                        ACorpoMensagem, AAnexos, AAbrirEditor, AImportante, strAutInc, strIncCon, intCodEma, blnEmailAut,
                        strSenha, strEmail, strLogin, strRemete, intProvedor, intPorSmt, intPorIma, strSerSmt, strSerIma, intLimArq,
                        blnImgAss, strTxtAss, mmsImaAss, strNomOpe, strImgCorpo, strAssunto, blnSSLSai, blnSSLEnt, strGravaPastaEnviados,
                        blnExibirMensagem, Nil, False, (strEnvAutCob='S'),strCodCli, strCodFor, blnAdicionaUmParagrafoPorLinha, blnExibeStatus,ADuplicatasEnvio,
                        blnGravarAnexos, AHabilitaDivisaoAnexoPorEmail, ACodOco, ANotFic);
End;

class function TEnvioEmail.EnviarEmail(AOwner: TComponent; ACodOperador: String;
  APara, AComCopia, AComCopiaOculta, ACorpoMensagem, AAnexos: TStringArray;
  AAbrirEditor, AImportante: Boolean; strAutInc, strIncCon: String; intCodEma: Int64; blnEmailAut: Boolean;
  strSenha : String; strEmail : String; strLogin: String; strRemete: String; intProvedor: Integer; intPorSmt: Integer; intPorIma: Integer; strSerSmt: String; strSerIma: String;
  intLimArq: Integer; blnImgAss: Boolean; strTxtAss: String; mmsImaAss: TMemoryStream; strNomOpe, strImgCorpo: String; var AAssunto: String;
  blnSSLSai: Boolean; blnSSLEnt: Boolean; strGravaPastaEnviados: String; AExibirMensagemConfirmacaoEnvio: Boolean=True;
  AThreadSincronizaEmail: TThreadSincronizaEmails = nil; blnImpressaoBoleto: Boolean = False; blnEnvAutCob: Boolean = False; strCodCli : String = ''; strCodFor : String = '';
  AAdicionaUmParagrafoPorLinha: Boolean = True; blnExibeStatus: Boolean = True; ADuplicatasEnvio: TArrDupTabelaEmail = Nil;
  blnGravarAnexos: Boolean = False; AHabilitaDivisaoAnexoPorEmail: Boolean = False; ACodOco: String = ''; ANotFic: String = ''): Boolean;

  Function EnviarEmailAutomatico(): Boolean;
    Var
      i: Integer;
      objEnvioEmail: TEnvioEmail;
      stlImgCorpo: TStringList;

    procedure pAjustaDadosAutenticacao;
    Begin
      objEnvioEmail.dadosAutenticacao.SetProvedor(intProvedor);

      objEnvioEmail.dadosAutenticacao.SetSenha(strSenha);
      objEnvioEmail.dadosAutenticacao.SetUsuario(strEmail);
      objEnvioEmail.dadosAutenticacao.SetLogin(strLogin);
      objEnvioEmail.dadosAutenticacao.SetRemete(strRemete);

      If intProvedor > 0 Then
        objEnvioEmail.dadosAutenticacao.CarregaDadosDoProvedor(intProvedor)
      Else
      Begin
        objEnvioEmail.dadosAutenticacao.SetPortaSmtp(intPorSmt);
        objEnvioEmail.dadosAutenticacao.SetPortaImap(intPorIma);
        objEnvioEmail.dadosAutenticacao.SetServidorSmtp(strSerSmt);
        objEnvioEmail.dadosAutenticacao.SetServidorImap(strSerIma);
        objEnvioEmail.dadosAutenticacao.SetLimiteArq(intLimArq);
        objEnvioEmail.dadosAutenticacao.blnSSLSai := blnSSLSai;
        objEnvioEmail.dadosAutenticacao.blnSSLEnt := blnSSLEnt;
        objEnvioEmail.dadosAutenticacao.strGravaPastaEnviados := strGravaPastaEnviados;
      End;

      objEnvioEmail.dadosAutenticacao.FTextoAssinatura.Text   := strTxtAss;
      objEnvioEmail.dadosAutenticacao.FImagemAssinaturaValida := blnImgAss;

      If (objEnvioEmail.dadosAutenticacao.FImagemAssinaturaValida) Then
        objEnvioEmail.dadosAutenticacao.FImagemAssinatura.LoadFromStream(mmsImaAss)
      Else
        objEnvioEmail.dadosAutenticacao.FImagemAssinatura := nil;
    End;

  Begin
    Result := False;

    try
      objEnvioEmail := TEnvioEmail.Create(AOwner, blnEmailAut, strNomOpe, intLimArq);

      If (blnEmailAut) Then
        pAjustaDadosAutenticacao;

      objEnvioEmail.InicializarComponentes();

      objEnvioEmail.strAutInc := strAutInc;
      objEnvioEmail.strIncCon := strIncCon;
      objEnvioEmail.intCodEma := intCodEma;
      objEnvioEmail.FDuplicatasEnvio := ADuplicatasEnvio;
      objEnvioEmail.strNotFic := ANotFic;

      If (objEnvioEmail.dadosAutenticacao.EhValido()) Then
      Begin

        objEnvioEmail.mensagem.assunto := AAssunto;
        objEnvioEmail.mensagem.blnGravarAnexosPath := blnGravarAnexos;

        for i := 0 to Length(APara) - 1 do
          if (not objEnvioEmail.mensagem.AdicionarPara(APara[i])) then
            Exit;

        for i := 0 to Length(AComCopia) - 1 do
          if (not objEnvioEmail.mensagem.AdicionarComCopia(AComCopia[i])) then
            Exit;

        for i := 0 to Length(AComCopiaOculta) - 1 do
          if (not objEnvioEmail.mensagem.AdicionarComCopiaOculta(AComCopiaOculta[i])) then
            Exit;

        for i := 0 to Length(ACorpoMensagem) - 1 do
          objEnvioEmail.mensagem.corpoMensagem.Add(ACorpoMensagem[i]);

        for i := 0 to Length(AAnexos) - 1 do
          objEnvioEmail.mensagem.AdicionarAnexo(TAnexo.Create(AAnexos[i]));

        Try
          stlImgCorpo := TStringList.Create;
          stlImgCorpo.Delimiter     := ';';
          stlImgCorpo.DelimitedText := strImgCorpo;

          for i := 0 to stlImgCorpo.Count - 1 do
          begin
            objEnvioEmail.mensagem.AdicionarImagemCorpoHtml(stlImgCorpo[i]);
          end;
        Finally
          FreeAndNil(stlImgCorpo);
        End;

        Try
          stlImgCorpo := TStringList.Create;
          stlImgCorpo.Delimiter     := ';';
          stlImgCorpo.DelimitedText := strImgCorpo;

          for i := 0 to stlImgCorpo.Count - 1 do
          begin
            objEnvioEmail.mensagem.AdicionarImagemCorpoHtml(stlImgCorpo[i]);
          end;
        Finally
          FreeAndNil(stlImgCorpo);
        End;

        objEnvioEmail.mensagem.mensagemAutomatica := True;

        objEnvioEmail.importante := AImportante;
        objEnvioEmail.horaEnvio  := fNow();
        objEnvioEmail.strCodCli  := strCodCli;
        objEnvioEmail.ThreadSincEmail := AThreadSincronizaEmail;
        objEnvioEmail.EnvAutCob  := blnEnvAutCob;

        If (blnEmailAut) Then
        Begin
          objEnvioEmail.EnviarMensagem;
          Result := objEnvioEmail.enviado;
        End
        Else
        Begin
          if (Length(APara) > 1) then
            TfrmGravando.fExecutarModal(objEnvioEmail.EnviarMensagem, 'Aguarde, enviando e-Mail para: ' + APara[0] + ' e outro(s) ...', '')
          else if (Length(APara) = 1) Then
            TfrmGravando.fExecutarModal(objEnvioEmail.EnviarMensagem, 'Aguarde, enviando e-Mail para: ' + APara[0] + ' ...', '')
          else
            untFuncoesSimples.fMensagem('Alerta', 'Nenhum destinatário foi definido na mensagem de e-mail, verifique o cadastro do cliente e tente novamente.', ['&OK']);

          if (objEnvioEmail.enviado) then
          begin
            if AExibirMensagemConfirmacaoEnvio then
              untFuncoesSimples.fMensagem('Enviado', 'Mensagem enviada com sucesso!', ['&Ok']);
            Result := True;
          End
          Else
          Begin
            untFuncoesSimples.fMensagem('Alerta', 'Dados de autenticação com o servidor de e-Mail são inválidos. Verifique a configuração ''CFG_PRVEMA - Provedores de e-mail''.'
            +#13#10+'Se o provedor estiver cadastrado corretamente, verifique o cadastro do Operador (aba ''e-Mail'') e tente novamente.', ['&OK']);
          End;
        End;
      End;
    finally
      FreeAndNil(objEnvioEmail);
    end;
  End;

begin
  Result := EnviarEmailAutomatico();
end;

procedure TEnvioEmail.EnviarEmailOAuth2(AJsonEmail: TJsonObject);
  Var
    LEnvioEmail: TEnvioEmailOutlookOAuth2;

    LTentativas: Integer;
begin
  LEnvioEmail := TEnvioEmailOutlookOAuth2.Create(FDadosAutenticacao.AutenticacaoOAuth2);

  Try
    For LTentativas := 1 To 3 Do
    Begin
      Try
        If LEnvioEmail.EnviarEmailOutlook(AJsonEmail, FDadosAutenticacao.FUsuario) Then
          Break;
      Except
        On E: Exception Do
        Begin
          If LTentativas >= 3 Then
            Raise Exception.Create(E.Message);
        End;
      End;
    End;
  Finally
    FreeAndNil(LEnvioEmail);
  End;
end;

class function TEnvioEmail.EnviarEmailSemMensagemConfirmacao(AOwner: TComponent;
                                                             ACodOperador,
                                                             AAssunto: String;
      APara, AComCopia, AComCopiaOculta, ACorpoMensagem, AAnexos: TStringArray;
      AAbrirEditor: Boolean = True; AThreadSincronizaEmail: TThreadSincronizaEmails = nil; blnImpressaoBoleto: Boolean = False;
      AImportante: Boolean = False; strAutInc: String = ''; strIncCon: String = ''; intCodEma: Int64 = 0; blnEmailAut: Boolean = False;
      strSenha : String = ''; strEmail : String = ''; strLogin : String = ''; strRemete : String = ''; intProvedor: Integer = 0; intPorSmt: Integer = 0; intPorIma: Integer = 0; strSerSmt: String = ''; strSerIma: String = '';
      intLimArq: Integer = 0; blnImgAss: Boolean = False; strTxtAss: String = ''; mmsImaAss: TMemoryStream = Nil; strNomOpe: String = ''; strImgCorpo: String = '';
      blnSSLSai: Boolean = False; blnSSLEnt: Boolean = False; strGravaPastaEnviados: String = 'S'; ADuplicatasEnvio: TArrDupTabelaEmail = Nil): Boolean;
  Var
    strAssunto : String;
Begin
  strAssunto := AAssunto;

  Result := EnviarEmail(AOwner, ACodOperador, APara, AComCopia, AComCopiaOculta,
                        ACorpoMensagem, AAnexos, AAbrirEditor, AImportante, strAutInc, strIncCon, intCodEma, blnEmailAut,
                        strSenha, strEmail, strLogin, strRemete, intProvedor, intPorSmt, intPorIma, strSerSmt, strSerIma, intLimArq,
                        blnImgAss, strTxtAss, mmsImaAss, strNomOpe, strImgCorpo, strAssunto, blnSSLSai, blnSSLEnt, strGravaPastaEnviados, False,
                        AThreadSincronizaEmail, blnImpressaoBoleto,False,'','',True,True,ADuplicatasEnvio);

end;

procedure TEnvioEmail.EnviarMensagem();
  Var
    destinatario : TIdEmailAddressItem;
    caminhoImagem: String;
    objEmailSinc :  TEmailsSinc;
    intCont      : Integer;
    staPara      : TStringArray;
    i: Integer;

    LConectado,
    LAutenticado: Boolean;

    LNomeGrupo,
    LNomeModelo: String;

    LJsonEmail: TJsonObject;

    LEnvioEmailOAuth2: TEnvioEmailOutlookOAuth2;

    LintTentativasConexaoEmail: Integer;
    blnTentarReconexaoEmail: Boolean;

  Procedure AdicionarAnexos();
    Var
      i: Integer;
  Begin
    For i := 0 To FMensagem.FAnexos.FArquivosAnexados.Count - 1 do
    Begin
      If (Not (Pos('.html', FMensagem.FAnexos.FArquivosAnexados[i].arquivo) > 0)) Then
      Begin
        With TIdAttachmentFile.Create(FIdMessage.MessageParts, FMensagem.FAnexos.FArquivosAnexados[i].arquivo) Do
        Begin
          ParentPart         := -1;
          ContentTransfer    := 'base64';
          ContentDisposition := 'attachment';
        End;
        FAnexosCount := FAnexosCount + 1;
      End;
    End;
  End;

  function fGetDominio: String; begin
    Result := Copy(FDadosAutenticacao.usuario, Pos('@', FDadosAutenticacao.usuario) + 1, Length(FDadosAutenticacao.usuario));
  end;

  Procedure PreencherMensagem();
    Var
      i: Integer;

    Function CriarImagemAssinatura(): String;
      Var
        assinatura: TFileStream;
    Begin
      caminhoImagem := '';
      Result        := caminhoImagem;

      If (ValidarDiretorioEmail(caminhoImagem)) Then
      Begin
        caminhoImagem := caminhoImagem + 'assinatura' + FormatDateTime('yyyymmdd_hhnnsszzz', FHoraEnvio) + '.jpeg';

        If (FDadosAutenticacao.imagemAssinaturaEhValida()) Then
        Begin
          assinatura := TFileStream.Create(caminhoImagem, fmCreate);

          Try
            If (FDadosAutenticacao.imagemAssinatura.size > 0) Then
              FDadosAutenticacao.imagemAssinatura.SaveToStream(assinatura);
          Finally
            assinatura.Free();
          End;
        End;

        Result := caminhoImagem;
      End;
    End;

  Begin
    FIdMessage.Subject      := FMensagem.FAssunto;

    If (blnEmailAut) And (Not fEmptyStr(FDadosAutenticacao.remetente)) Then
      FIdMessage.From.Name := FDadosAutenticacao.remetente
    Else
      FIdMessage.From.Name := FMensagem.FNomeSaudacao;

    FIdMessage.From.Address := FDadosAutenticacao.usuario;

    FIdMessage.ContentType := 'multipart/mixed';
    FIdMessage.ContentDisposition := 'inline';
    FIdMessage.CharSet     := 'UTF-8';

    FIdMessage.Headers.Values['Message-Id'] := '<' + FNomeArquivoZip + '@' + fGetDominio() + '>';
    FIdMessage.ExtraHeaders.Values['Message-Id'] := '<' + FNomeArquivoZip + '@' + fGetDominio() + '>';

    With TIdText.Create(FIdMessage.MessageParts, nil) Do
    Begin
      Body.Clear();
      ContentType := 'multipart/related; type="text/html"';
      CharSet     := 'UTF-8';
      ParentPart  := -1;
    End;

    With TIdText.Create(FIdMessage.MessageParts, nil) Do
    Begin
      Body.Clear();

      ParentPart      := 0;
      ContentType     := 'text/html';
      ContentTransfer := 'quoted-printable';
      CharSet         := 'UTF-8';

      If (FMensagem.FCorpoHtml) Then
      Begin
        Body.Add('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">');

        For i := 0 To FMensagem.FCorpoMensagem.Count - 1 do
          Body.Add(FMensagem.FCorpoMensagem[i]);

        Body.Text := StringReplace(Body.Text, 'iso-8859-1', 'UTF-8', [rfReplaceAll, rfIgnoreCase]);
      End
      Else
      Begin
        Body.Add('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">');
        Body.Add('<HTML><HEAD MIME-Version: 1.0>');
        Body.Add('<META content="text/html; charset=UTF-8" http-equiv="Content-Type" />');
        Body.Add('<STYLE>P {line-height: 0.5;} .P1 {line-height: 0.1; font-size:x-small;}</STYLE></HEAD>');
        Body.Add('<BODY>');

        For i := 0 To FMensagem.FCorpoMensagem.Count - 1 do
          Body.Add('<P>' + FMensagem.FCorpoMensagem[i] + '</P>');

        Body.Add('</BODY></HTML>');
      End;

      Body.Text := StringReplace(Body.Text,
           '<STYLE>P {line-height: 0.5;} .P1 {line-height: 0.1; font-size:x-small;}</STYLE>',
           '<STYLE>P {line-height: 1.0;} .P1 {line-height: 0.5; font-size:x-small;}</STYLE>',
           [rfReplaceAll]);

      Body.Text := StringReplace(Body.Text,
           '<BR><BR>',
           '<BR>',
           [rfReplaceAll]);

      Body.Text := StringReplace(Body.Text,
           '<HTML><HEAD MIME-Version:>',
           '<HTML><HEAD MIME-Version: 1.0>',
           [rfReplaceAll]);

      If (FMensagem.FImagensCorpoHtml.Count > 0) Then
      Begin
        For i := 0 To FMensagem.FImagensCorpoHtml.Count - 1 do
        Begin
          If (blnEmailAut) Then
            caminhoImagem := FMensagem.FImagensCorpoHtml[i].caminhoImagem
          Else
          Begin
            If (Pos('file:///', FMensagem.FImagensCorpoHtml[i].caminhoImagem) > 0) Then
              caminhoImagem := Copy(FMensagem.FImagensCorpoHtml[i].caminhoImagem,
                                    9,
                                    Length(FMensagem.FImagensCorpoHtml[i].caminhoImagem))
            Else
              caminhoImagem := Copy(FMensagem.FImagensCorpoHtml[i].caminhoImagem,
                                    6,
                                    Length(FMensagem.FImagensCorpoHtml[i].caminhoImagem));
          End;

          caminhoImagem := StringReplace(caminhoImagem, '/', '\', [rfReplaceAll]);

          If (Pos(caminhoImagem, FMensagem.FCorpoMensagem.Text) > 0) Then
          Begin

            If (Pos('assinatura' + FormatDateTime('yyyymmdd_hhnnsszzz', FHoraEnvio), caminhoImagem) > 0) Then
            Begin
              Body.Text :=
                StringReplace(
                  Body.Text,
                  'src="' + caminhoImagem + '"',
                  'src="cid:assinatura' + FormatDateTime('yyyymmdd_hhnnsszzz', FHoraEnvio) + '"',
                  [rfReplaceAll]);

              With TIdAttachmentFile.Create(FIdMessage.MessageParts, caminhoImagem) Do
              Begin
                ContentId          := '<assinatura' + FormatDateTime('yyyymmdd_hhnnsszzz', FHoraEnvio) + '>';
                ParentPart         := 0;
                ContentType        := 'image/jpeg';
                ContentTransfer    := 'base64';
                ContentDisposition := 'inline';
              End;
            End
            Else
            Begin
              Body.Text :=
                StringReplace(
                  Body.Text,
                  'src="' + caminhoImagem + '"',
                  'src="cid:imagemCorpoEmail_' + FormatFloat('###000', i) + '_' + FormatDateTime('yyyymmdd_hhnnsszzz', FHoraEnvio) + '"',
                  [rfReplaceAll]);

              With TIdAttachmentFile.Create(FIdMessage.MessageParts, caminhoImagem) Do
              Begin
                ContentId          := '<imagemCorpoEmail_' + FormatFloat('###000', i) + '_' + FormatDateTime('yyyymmdd_hhnnsszzz', FHoraEnvio) + '>';
                ParentPart         := 0;
                ContentType        := 'image/jpeg';
                ContentTransfer    := 'base64';
                ContentDisposition := 'inline';
              End;
            End;
          End;
        End;
      End;

      If (FMensagem.FMensagemAutomatica) Then
      Begin
        If (FDadosAutenticacao.FImagemAssinaturaValida) Or (FDadosAutenticacao.FTextoAssinatura.Count > 0) Then
          Body.Add('<HR><P><I><SMALL>');

        For i := 0 To FDadosAutenticacao.FTextoAssinatura.Count - 1 Do
          If (FDadosAutenticacao.FTextoAssinatura[i] = #13#10) Or
             (fEmptyStr(FDadosAutenticacao.FTextoAssinatura[i])) Then
            Body.Add('<BR>')
          Else
            Body.Add(FDadosAutenticacao.FTextoAssinatura[i] + '<BR>');

        Body.Add('</SMALL></I></P>');

        If (FDadosAutenticacao.FImagemAssinaturaValida) Then
        Begin
          Body.Add('<IMG src="cid:assinatura' + FormatDateTime('yyyymmdd_hhnnsszzz', FHoraEnvio) + '" />');

          With TIdAttachmentFile.Create(
                                   FIdMessage.MessageParts,
                                   CriarImagemAssinatura()) Do
          Begin
            ContentId          := '<assinatura' + FormatDateTime('yyyymmdd_hhnnsszzz', FHoraEnvio) + '>';
            ParentPart         := 0;
            ContentType        := 'image/jpeg';
            ContentTransfer    := 'base64';
            ContentDisposition := 'inline';
          End;
        End;
      End;
    End;

    destinatario := TIdEmailAddressItem.Create();

    FIdMessage.FromList.Clear();

    destinatario := FIdMessage.FromList.Add;
    destinatario.Address := FDadosAutenticacao.usuario;

    If (blnEmailAut) And (Not fEmptyStr(FDadosAutenticacao.remetente)) Then
      destinatario.Name := FDadosAutenticacao.remetente
    Else
      destinatario.Name := FMensagem.FNomeSaudacao;

    FIdMessage.Recipients.Clear();

    For i := 0 To FMensagem.FPara.Count - 1 do
    Begin
      destinatario := FIdMessage.Recipients.Add;
      destinatario.Address := FMensagem.FPara[i];
    End;

    FIdMessage.CCList.Clear();

    For i := 0 To FMensagem.FComCopia.Count - 1 do
    Begin
      destinatario := FIdMessage.CCList.Add;
      destinatario.Address := FMensagem.FComCopia[i];
    End;

    FIdMessage.BCCList.Clear();

    For i := 0 To FMensagem.FComCopiaOculta.Count - 1 do
    Begin
      destinatario := FIdMessage.BCCList.Add;
      destinatario.Address := FMensagem.FComCopiaOculta[i];
    End;
  End;

  Procedure GravarPastaEnviados();
    Var
      i: Integer;
      IdIMAP: TIdIMAP4;
      pastas: TStringList;
      confirmado, encontrada: Boolean;
      IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
  Begin
    If (Not fEmptyStr(FDadosAutenticacao.FServidorImap))
      And (FDadosAutenticacao.FPortaImap > 0)
      And (IfEmptyStr(FDadosAutenticacao.strGravaPastaEnviados, 'S') = 'S') Then
    Begin
      IdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create();

      Try
        IdSSLIOHandlerSocketOpenSSL.Destination := FDadosAutenticacao.FServidorImap + ':' + IntToStr(FDadosAutenticacao.FPortaImap);
        IdSSLIOHandlerSocketOpenSSL.Host := FDadosAutenticacao.FServidorImap;
        IdSSLIOHandlerSocketOpenSSL.Port := FDadosAutenticacao.FPortaImap;
        IdSSLIOHandlerSocketOpenSSL.DefaultPort := 0;
        IdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := fRetVersaoTLSSSL(){sslvSSLv3};
        IdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLversions := [fRetVersaoTLSSSL(){sslvSSLv3}];
        IdSSLIOHandlerSocketOpenSSL.SSLOptions.Mode := fRetModeSSL;
        IdSSLIOHandlerSocketOpenSSL.SSLOptions.VerifyMode := [];
        IdSSLIOHandlerSocketOpenSSL.SSLOptions.VerifyDepth := 0;

        IdIMAP := TIdIMAP4.Create();
        Try
          IdIMAP.IOHandler := IdSSLIOHandlerSocketOpenSSL;
          IdIMAP.Host      := FDadosAutenticacao.FServidorImap;
          IdIMAP.Password  := FDadosAutenticacao.FSenha;
          IdIMAP.Port      := FDadosAutenticacao.FPortaImap;

          If (Not FDadosAutenticacao.blnSSLEnt) Then
            IdIMAP.UseTLS  := utUseExplicitTLS
          Else
            IdIMAP.UseTLS  := utUseImplicitTLS;

          IdIMAP.Username  := FDadosAutenticacao.FLogin;

          If TAutenticacaoEmail.ConnectIdIMAP(IdIMAP,FDadosAutenticacao.usuario, FDadosAutenticacao) Then
          Begin
            pastas := TStringList.Create();

            Try
              confirmado := IdIMAP.ListMailBoxes(pastas);

              If (confirmado) then
              Begin
                encontrada := False;

                For i := 0 to pastas.Count - 1 Do
                Begin
                  If (Pos('ENVIAD', UpperCase(pastas[i])) > 0) or (Pos('SENT', UpperCase(pastas[i])) > 0) Then
                  Begin
                    encontrada := True;

                    If (IdIMAP.SelectMailbox(pastas[i])) Then
                    Begin
                      IdIMAP.AppendMsg(pastas[i], FIdMessage, nil, [mfSeen]);
                      IdIMAP.Disconnect;
                      Break;
                    End;
                  End;
                End;

                If (not encontrada) Then
                  untFuncoesSimples.fMensagem('Alerta', 'Não foi encontrada a pasta de mensagens ''Enviadas'' em sua conta de e-mail.' +
                    #13#10 + 'Verifique nas configurações do provedor para que futuramente este problema não ocorra.', ['&Ok']);
              End;
            Except
              On E: Exception Do
                pMensagensErro(E.Message, '[TEnvioEmail.GravarPastaEnviados]');
            End;
          End;
        Finally
          FreeAndNil(pastas);
          FreeAndNil(IdIMAP);
        End;
      Finally
        FreeAndNil(IdSSLIOHandlerSocketOpenSSL);
      End;
    End;
  End;

  Procedure SalvarMensagem;
    Var
      LInserir: TUniQuery;

      LDataExecutavel : TDateTime;
  Begin
    Try
      LInserir := fCriaQuery;

      LInserir.SQL.Text := 'SELECT * FROM EMAENV WHERE FALSE';
      LInserir.Open;

      LInserir.Append;
      LInserir.FieldByName('ENV_TIP_FC').AsString   := 'C';
      LInserir.FieldByName('ENV_FORCLI').AsString   := strCodCli;

      LInserir.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('EMAENV', VS_StrCodEmp);
      LInserir.FieldByName('ENV_EMACOD').AsLargeInt := StrToInt64(fAtualizaProCod('EMAENV'));
      LInserir.FieldByName('ENV_CODEMP').AsString   := VS_strCodEmp;

      LInserir.FieldByName('ENV_EMADTA').AsDateTime := Trunc(FHoraEnvio);
      LInserir.FieldByName('ENV_EMAHOR').AsDateTime := FHoraEnvio - LInserir.FieldByName('ENV_EMADTA').AsDateTime;

      LInserir.FieldByName('ENV_EMAIMP').AsInteger := 0;
      If FImportante Then
        LInserir.FieldByName('ENV_EMAIMP').AsInteger := 1;

      LInserir.FieldByName('ENV_ANEXOS').AsInteger := 0;
      If (FAnexosCount > 0) Then
        LInserir.FieldByName('ENV_ANEXOS').AsInteger := 1;

      If FDadosAutenticacao.provedor > 0 Then
        LInserir.FieldByName('ENV_CODPRV').AsInteger := FDadosAutenticacao.provedor;

      LInserir.FieldByName('ENV_EMAREM').AsString  := FDadosAutenticacao.usuario;
      LInserir.FieldByName('ENV_EMASTO').AsString  := FMensagem.FAssunto;
      LInserir.FieldByName('ENV_CODOPE').AsString  := Copy(FNomeArquivoZip, 15, 3);
      LInserir.FieldByName('ENV_ZIPNOM').AsString  := FNomeArquivoZip + '.zip';

      If (FMensagem.FPara.Count > 0) Then
        LInserir.FieldByName('ENV_EMADES').AsString := FMensagem.FPara[0]
      Else If (FMensagem.FComCopia.Count > 0) Then
        LInserir.FieldByName('ENV_EMADES').AsString := FMensagem.FComCopia[0]
      Else If (FMensagem.FComCopiaOculta.Count > 0) Then
        LInserir.FieldByName('ENV_EMADES').AsString := FMensagem.FComCopiaOculta[0];

      FileAge(Application.ExeName, LDataExecutavel);

      LInserir.FieldByName('ENV_PATEXE').AsString  := Application.ExeName;
      LInserir.FieldByName('ENV_VEREXE').AsString  := TVersaoExecutavel.GetVersaoProduto;
      LInserir.FieldByName('ENV_DTAEXE').AsDateTime := LDataExecutavel;

      LInserir.FieldByName('ENV_SEQNOT').AsString  := strNotFic;

      LInserir.Post;
    Except
      On E: Exception Do
      Begin
        fRollBack();
        pMensagensErro(E.Message, '[TEnvioEmail.EnviarMensagem.SalvarMensagemEnvioAutomatico]');
      End;
    End;
    FreeAndNil(LInserir);
  End;

  procedure GravarContatos(strAutInc: String);
    Var
      i: Integer;
  Begin
    For i := 0 To FMensagem.FPara.Count - 1 Do
      TListaContatosEmail.pGravarContato(FMensagem.FPara[i], strAutInc, FEnvAutCob);

    For i := 0 To FMensagem.FComCopia.Count - 1 Do
      TListaContatosEmail.pGravarContato(FMensagem.FComCopia[i], strAutInc, FEnvAutCob);

    For i := 0 To FMensagem.FComCopiaOculta.Count - 1 Do
      TListaContatosEmail.pGravarContato(FMensagem.FComCopiaOculta[i], strAutInc, FEnvAutCob);
  End;

  Procedure SalvarMensagemEnvioAutomatico(APara: Integer = 0);
  Var
    qryEmaEnv: TUniQuery;
    strSQL   : String;
    LAutoIncremEmaEnv: String;

    LDataExecutavel: TDateTime;
  Begin
    Try
      fStartTransaction;
      qryEmaEnv := fCriaQuery(Nil);

      strSQL := '';
      strSQL := strSQL + 'INSERT INTO          ';
      strSQL := strSQL + '  EMAENV(            ';
      strSQL := strSQL + '         AUTOINCREM, ';
      strSQL := strSQL + '         ENV_EMACOD, ';
      strSQL := strSQL + '         ENV_CODEMP, ';
      strSQL := strSQL + '         ENV_EMADTA, ';
      strSQL := strSQL + '         ENV_EMAHOR, ';
      strSQL := strSQL + '         ENV_EMAIMP, ';
      strSQL := strSQL + '         ENV_ANEXOS, ';
      strSQL := strSQL + '         ENV_CODPRV, ';
      strSQL := strSQL + '         ENV_EMAREM, ';
      strSQL := strSQL + '         ENV_EMASTO, ';
      strSQL := strSQL + '         ENV_CODOPE, ';
      strSQL := strSQL + '         ENV_ZIPNOM, ';
      strSQL := strSQL + '         ENV_EMADES, ';
      strSQL := strSQL + '         ENV_TIP_FC, ';
      strSQL := strSQL + '         ENV_FORCLI, ';
      strSQL := strSQL + '         ENV_PATEXE, ';
      strSQL := strSQL + '         ENV_DTAEXE, ';
      strSQL := strSQL + '         ENV_VEREXE, ';
      strSQL := strSQL + '         ENV_SEQNOT) ';
      strSQL := strSQL + '  VALUES(            ';
      strSQL := strSQL + '         :AUTINC,    ';
      strSQL := strSQL + '         :EMACOD,    ';
      strSQL := strSQL + '         :CODEMP,    ';
      strSQL := strSQL + '         :EMADTA,    ';
      strSQL := strSQL + '         :EMAHOR,    ';
      strSQL := strSQL + '         :EMAIMP,    ';
      strSQL := strSQL + '         :ANEXOS,    ';
      strSQL := strSQL + '         :CODPRV,    ';
      strSQL := strSQL + '         :EMAREM,    ';
      strSQL := strSQL + '         :EMASTO,    ';
      strSQL := strSQL + '         :CODOPE,    ';
      strSQL := strSQL + '         :ZIPNOM,    ';
      strSQL := strSQL + '         :EMADES,    ';
      strSQL := strSQL + '         :TIP_FC,    ';
      strSQL := strSQL + '         :FORCLI,    ';
      strSQL := strSQL + '         :PATEXE,    ';
      strSQL := strSQL + '         :DTAEXE,    ';
      strSQL := strSQL + '         :VEREXE,    ';
      strSQL := strSQL + '         :SEQNOT)    ';

      qryEmaEnv.Close;
      qryEmaEnv.SQL.Clear;
      qryEmaEnv.SQL.Add(strSQL);

      qryEmaEnv.ParamByName('TIP_FC').AsString   := 'C';
      qryEmaEnv.ParamByName('FORCLI').AsString   := strCodCli;

      LAutoIncremEmaEnv := IIF((APara = 0),strAutInc,fRetAutoIncrem('EMAENV', VS_strCodEmp));
      qryEmaEnv.ParamByName('AUTINC').AsString   := LAutoIncremEmaEnv;
      qryEmaEnv.ParamByName('EMACOD').AsLargeInt := IIF((APara = 0),intCodEma,StrToInt64(fAtualizaProCod('EMAENV')));
      qryEmaEnv.ParamByName('CODEMP').AsString   := VS_strCodEmp;

      qryEmaEnv.ParamByName('EMADTA').AsDateTime := Trunc(FHoraEnvio);
      qryEmaEnv.ParamByName('EMAHOR').AsDateTime := FHoraEnvio - qryEmaEnv.ParamByName('EMADTA').AsDateTime;

      qryEmaEnv.ParamByName('EMAIMP').AsInteger := 0;
      If (FImportante) Then
        qryEmaEnv.ParamByName('EMAIMP').AsInteger := 1;

      qryEmaEnv.ParamByName('ANEXOS').AsInteger := 0;
      If (FAnexosCount > 0) Then
        qryEmaEnv.ParamByName('ANEXOS').AsInteger := 1;

      If FDadosAutenticacao.provedor > 0 Then
        qryEmaEnv.ParamByName('CODPRV').AsInteger := FDadosAutenticacao.provedor;

      qryEmaEnv.ParamByName('EMAREM').AsString  := FDadosAutenticacao.usuario;
      qryEmaEnv.ParamByName('EMASTO').AsString  := FMensagem.FAssunto;
      qryEmaEnv.ParamByName('CODOPE').AsString  := Copy(FNomeArquivoZip, 15, 3);
      qryEmaEnv.ParamByName('ZIPNOM').AsString  := FNomeArquivoZip + '.zip';
      qryEmaEnv.ParamByName('EMADES').AsString  := GetDestinatario('',APara);

      FileAge(Application.ExeName, LDataExecutavel);

      qryEmaEnv.ParamByName('PATEXE').AsString  := Application.ExeName;
      qryEmaEnv.ParamByName('VEREXE').AsString  := TVersaoExecutavel.GetVersaoProduto;
      qryEmaEnv.ParamByName('DTAEXE').AsDateTime := LDataExecutavel;

      qryEmaEnv.ParamByName('SEQNOT').AsString  := strNotFic;

      qryEmaEnv.ExecSQL;
      TDupEma.GravarDupEma(LAutoIncremEmaEnv,FDuplicatasEnvio);
      fCommit();
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TEnvioEmail.EnviarMensagem.SalvarMensagemEnvioAutomatico]');
    End;
  End;

  procedure pSendMail;
  Var
    intTentativa: Integer;
  begin
    For intTentativa := 1 To 3 Do
    Begin
      If FDadosAutenticacao.UsaAuthenticacaoOAuth2 Then
      Begin
        EnviarEmailOAuth2(LJsonEmail);

        Exit;
      End;

      Try
        FIdSMTP.Send(FIdMessage);
        Break;
      Except
        Sleep(1000);
        If intTentativa = 3 Then
          Raise;
      End;
    End;
  end;

  procedure GravarHistoricoCobranca(ADuplicatasEnvio : TArrDupTabelaEmail);
  Var
    qryTemp   : TUniQuery;
    strAutInc : String;
    LInc,
    i         : Integer;
    blnGrava  : Boolean;
    strHtml,
    EndEmailEnviados   : String;
  begin

    Try

      If VS_blnGravaHistCob Then
      Begin

        blnGrava := False;
        For LInc := 0 To Length(ADuplicatasEnvio) -1 Do
        Begin

          If (ADuplicatasEnvio[LInc].dtaDtaVen < Date) Then
          Begin
             blnGrava := True;
             break;
          End;

        End;

        If blnGrava Then
        Begin

          Try

            strHtml := 'font-family:"arial"; font-size:70%';

            EndEmailEnviados := '';
            For i := 0 To FMensagem.FPara.Count - 1 Do
                EndEmailEnviados := EndEmailEnviados + FMensagem.FPara[i]+';';

            {Cria query}
            qryTemp := fCriaQuery(Nil);

            Try

              {Start transação}
              fStartTransaction();

              strAutInc := fRetAutoIncrem('CADCOB', VS_strCodEmp);

              qryTemp.Close();
              qryTemp.SQL.Clear();

              qryTemp.SQL.Add('INSERT INTO CADCOB (AUTOINCREM, '+
                                                  'COB_CODEMP, '+
                                                  'COB_DTALAN, '+
                                                  'COB_HORLAN, '+
                                                  'COB_DTAAGE, '+
                                                  'COB_BAIXAD, '+
                                                  'COB_CODOPE, '+
                                                  'COB_CODCLI, '+
                                                  'COB_HISCOB  '+
                                                  ')  VALUES  ('+
                                                  ':AUTOINCREM,'+
                                                  ':COB_CODEMP,'+
                                                  ':COB_DTALAN,'+
                                                  ':COB_HORLAN,'+
                                                  ':COB_DTAAGE,'+
                                                  ':COB_BAIXAD,'+
                                                  ':COB_CODOPE,'+
                                                  ':COB_CODCLI,'+
                                                  ':COB_HISCOB)');
              qryTemp.ParamByName('AUTOINCREM').AsString   := strAutInc;
              qryTemp.ParamByName('COB_CODEMP').AsString   := VS_strCodEmp;
              qryTemp.ParamByName('COB_DTALAN').AsDatetime := Date;
              qryTemp.ParamByName('COB_HORLAN').AsDatetime := Date + fTime();
              qryTemp.ParamByName('COB_DTAAGE').AsDatetime := Date;
              qryTemp.ParamByName('COB_BAIXAD').AsString   := 'N';
              qryTemp.ParamByName('COB_CODOPE').AsString   := strLoginUsuarioLogado;
              qryTemp.ParamByName('COB_CODCLI').AsString   := StrCodCli;
              qryTemp.ParamByName('COB_HISCOB').AsString   := '<P>'+'Enviado: '+ datetostr(Date) + '</P>' +
                                                              '<P>'+'Para: '+EndEmailEnviados + '</P>' +
                                                              AnsiReplaceStr(FMensagem.CorpoMensagem[0],
                                                                             '<TABLE ',
                                                                             '<TABLE style='+ #39 + strHtml + #39 );

              qryTemp.ExecSQL();

              {Commit transação}
              fCommit();

            Except
              On E: Exception Do
              Begin
                pMensagensErro(E.Message, 'TEnvioEmail.EnviarMensagem.GravarHistoricoConbrança');
                fRollback();
              End;
            End;

          Finally
            If assigned(qryTemp) Then
               FreeAndNil(qryTemp);
          End;

        End;

      End;
    Finally
    End;
  end;


begin
  FEnviado := False;
  LintTentativasConexaoEmail := 0;
  blnTentarReconexaoEmail := True;
  LAutenticado := False;

  If (ValidarMensagem()) Then
  Begin
    Try
      If Not VS_PermitidoEnviarEmail Then
        Raise ExceptionAutcom.Create('Não é permitido enviar e-mail nesse banco de dados!');

      LimparMensagem();

      FNomeArquivoZip := 'MensagemEmail_' + strLoginUsuarioLogado + '_' + FormatDateTime('yyyymmdd_hhnnsszzz', FHoraEnvio);

      If (ValidarDiretorioEmail(FDiretorioEmail)) Then
      Begin
        PreencherMensagem();
        AdicionarAnexos();

        If FDadosAutenticacao.UsaAuthenticacaoOAuth2 Then
        Begin
          LEnvioEmailOAuth2 := TEnvioEmailOutlookOAuth2.Create(FDadosAutenticacao.AutenticacaoOAuth2);

          FDadosAutenticacao.AutenticacaoOAuth2.CarregaEmailIDAzureDadosModeloOperador(FCodigoGrupoModelo,
                                                                                       FCodigoModelo,
                                                                                       strLoginUsuarioLogado);

          LJsonEmail := LEnvioEmailOAuth2.RetornaJsonMensagemMicrosoftOutlook(FIdMessage,
                                                                              FDadosAutenticacao.strGravaPastaEnviados.Equals('S'),
                                                                              FImportante);
        End;

        repeat
          Try
            Inc(LintTentativasConexaoEmail);

            If (FIdSMTP.Connected) Then
            Begin
              FIdSMTP.Disconnect();
              Sleep(2000);
            End;

            LAutenticado := FDadosAutenticacao.AutenticarServidorSMTP(FDadosAutenticacao, FIdSMTP, LConectado);

            If LConectado Then
            Begin
              If LAutenticado Then
              Begin
                LAutenticado := True;

                If Not FEmailsModelosAutenticados.Contains(Concat(FCodigoGrupoModelo, FCodigoModelo, '_')) Then
                  FEmailsModelosAutenticados := FEmailsModelosAutenticados +
                                                Concat(FCodigoGrupoModelo, FCodigoModelo, '_');

                Try
                  //REMOVER - APENAS PARA VALIDAÇÃO DE ERROS
                  {If FDadosAutenticacao.login = 'testecitelappmenosseguro@gmail.com' Then
                    Raise Exception.Create('Sender Address Blocked');

                  If FMensagem.FPara.IndexOf('email@email.com') >= 0 Then
                    Raise Exception.Create('<email@email.com>: Recipient address rejected: policy rejection: email@email.com: recipient is known to bounce; see https://www.hostnet.com.br/info/recipient-is-known-to-bounce/');}

                  pSendMail;

                  blnTentarReconexaoEmail := False;

                  FEnviado := True;
                Except
                  On E: Exception Do
                  Begin
                    VS_Error_you_are_sending_too_many_mails_slow_down :=
                      E.Message.ToLower.Contains('you are sending too many mails, slow down');
                    Raise;
                  End;
                End;

                FIdSMTP.Disconnect();

                if Not Assigned(ThreadSincEmail) then
                  GravarZipMensagem(FIdMessage, FDiretorioEmail, FNomeArquivoZip);

                If (blnEmailAut) Then
                Begin
                  for i := 0 to FMensagem.FPara.Count - 1 do
                  Begin
                    SalvarMensagemEnvioAutomatico(i);
                  End;
                End
                Else
                  SalvarMensagem();

                If Not FDadosAutenticacao.UsaAuthenticacaoOAuth2 Then
                Begin
                  if Not Assigned(ThreadSincEmail) then
                    GravarPastaEnviados()
                  Else
                  begin
                    objEmailSinc := TEmailsSinc.Create;
                    objEmailSinc.DadosAutenticacao := FDadosAutenticacao;
                    objEmailSinc.IdSMTP := FIdSMTP;
                    objEmailSinc.IdMessage := FIdMessage;
                    objEmailSinc.SSLSocket := FSSLSocket;
                    objEmailSinc.NomeArquivoZip := FNomeArquivoZip;
                    objEmailSinc.DiretorioEmail := FDiretorioEmail;

                    objEmailSinc.HoraEnvio := fNow;
                    SetLength(staPara, 0);
                    For intCont := 0 To FIdMessage.Recipients.Count - 1 Do
                    Begin
                      SetLength(staPara, intCont + 1);
                      staPara[intCont] := FIdMessage.Recipients.Items[0].Address;
                    End;
                    objEmailSinc.Para := staPara;

                    ThreadSincEmail.pAdicionaEmailLista(objEmailSinc);
                  end;
                End;

                GravarContatos(strIncCon);

                GravarHistoricoCobranca(FDuplicatasEnvio);

                FMensagem.Limpar();

                If (FMensagem.FMensagemAutomatica)
                  And (FDadosAutenticacao.FImagemAssinaturaValida)
                  And (FileExists(caminhoImagem)) Then
                  SysUtils.DeleteFile(caminhoImagem);

                FImportante := False;
              End;
            End;
          Except
            On E: Exception Do
            Begin
              if (LintTentativasConexaoEmail >= 3) or (FEnviado) then
              begin
                If ReenviarEmailAutenticado(FEnviado, LAutenticado) Then
                  Exit;

                E.Message := IIF(FEnviado,
                                 'O e-mail foi enviado com sucesso, porém ocorreu um erro após o envio. ' +
                                 'Verifique as configurações de IMAP do provedor utilizado. ' + E.Message,
                                 E.Message);

                If FEnvAutCob Then
                Begin
                  If DeveGravarErroEnvioAutomatico(LAutenticado) Then
                  Begin
                    If fTipoErroGravaEmailErrosLog(E.Message) Then
                      untFuncoesSimples.pGravarEmailErros('C', strCodCli, FMensagem.FAssunto, GetDestinatario(E.Message), E.Message);

                    pLogErros(True, E.Message + ' [TEnvioEmail.EnviarMensagem]', fRetornaStack);

                    IniciarDatasetChavesBloqueioEmails;

                    If ErroReferenteARementeDestinatario(E.Message) Then
                    Begin
                      DeveGravarEmailDoClienteNaBlackList(E.Message);
                      EnviarMensagemErroBloqueioAosOperadores(FCodigoGrupoModelo,
                                                              FCodigoModelo,
                                                              E.Message);
                    End
                    Else
                      EnviarMensagemErroAosOperadores(LAutenticado,
                                                      FCodigoGrupoModelo,
                                                      FCodigoModelo,
                                                      E.Message);
                  End;
                End
                Else
                Begin
                  If fTipoErroGravaEmailErrosLog(E.Message) Then
                    untFuncoesSimples.pGravarEmailErros('C', strCodCli, FMensagem.FAssunto, GetDestinatario(E.Message), E.Message);
                  pMensagemErroEnviaEmail(E.Message);
                End;
              end
              else
                Sleep(2000);
            End;
          End;

        until (LintTentativasConexaoEmail >= 3) or (not blnTentarReconexaoEmail);
      End;
    Finally
      Try
        If Assigned(destinatario) THen
          destinatario.Free;
      Except

      End;
    End;
  End
  Else
  Begin
    If Not MatchStr(FCodigoGrupoModelo, ['009', '025']) Then
      untFuncoesSimples.fMensagem('Alerta', 'Mensagem não pôde ser enviada. Verifique!', ['&Ok'])
    Else
    Begin
      LNomeGrupo := IIF(FCodigoGrupoModelo = '009',
                      'AVISOS DE COBRANÇA',
                      'AVISOS DE DÉBITOS');

      LNomeModelo := fCampoTabela('EMA_DESCRI',
                                  'EMASAI',
                                  ['EMA_CODGRU', 'EMA_CODIGO', 'EMA_CODEMP'],
                                  [FCodigoGrupoModelo, FCodigoModelo, VS_strCodEmp]);

      pLogErros(True, 'A mensagem do grupo ' + FCodigoGrupoModelo + '-' + LNomeGrupo +
                      ' - Modelo: ' + LNomeModelo + ' não pode ser enviada pois não é válida. Verifique! ' +
                      ' [TEnvioEmail.EnviarMensagem]', fRetornaStack);
    End;
  End;
end;

procedure TEnvioEmail.EnviarMensagemErroAosOperadores(AAutenticado: Boolean;
  ACodigoGrupoModelo, ACodigoModelo, AErroGerado: String);
  Var
    LConsultaOperadores: TUniQuery;

    LMensagemInterna: TMsgInterna;

    LNomeGrupo,
    LNomeModelo: String;
begin
  If AAutenticado Then
    Exit;

  If Not MatchStr(ACodigoGrupoModelo, ['009', '025']) Then
    Exit;

  LMensagemInterna := TMsgInterna.Create(Nil);
  LConsultaOperadores := fCriaQuery;

  Try
    LConsultaOperadores.SQL.Text := 'SELECT O.OPE_CODOPE, O.OPE_EMPACE ' +
                                    'FROM CADOPE O ' +
                                    'LEFT JOIN DIROPE D ON D.OPE_CODOPE=O.OPE_CODOPE ' +
                                    '                  AND D.DIR_NOMFRM="frmConfiguracoes" ' +
                                    '                  AND D.DIR_ACAOUS="IAE" ' +
                                    'LEFT JOIN OPEGPO P ON P.OPE_CODOPE=O.OPE_CODOPE ' +
                                    'LEFT JOIN DIRGPO G ON G.GPO_CODGPO=P.GPO_CODGPO ' +
                                    '                  AND G.DIR_NOMFRM="frmConfiguracoes" ' +
                                    '                  AND G.DIR_ACAOUS="IAE" ' +
                                    'WHERE D.DIR_NOMFRM IS NOT NULL ' +
                                    '   OR G.DIR_NOMFRM IS NOT NULL ' +
                                    'GROUP BY O.OPE_CODOPE ';

    LConsultaOperadores.Open;

    LNomeGrupo := IIF(ACodigoGrupoModelo = '009',
                      'AVISOS DE COBRANÇA',
                      'AVISOS DE DÉBITOS');

    LNomeModelo := fCampoTabela('EMA_DESCRI',
                                'EMASAI',
                                ['EMA_CODGRU', 'EMA_CODIGO', 'EMA_CODEMP'],
                                [ACodigoGrupoModelo, ACodigoModelo, VS_strCodEmp]);

    Try
      fStartTransaction;
      LConsultaOperadores.First;
      While Not LConsultaOperadores.Eof Do
      Begin
        If Pos(VS_strCodEmp, LConsultaOperadores.FieldByName('OPE_EMPACE').AsString) <= 0 Then
        Begin
          LConsultaOperadores.Next;
          Continue;
        End;

        LMensagemInterna.fEnviaMensagem('Dados de autorização do e-mail de ' + LNomeGrupo + ' inválidos.',
                                        'Ocorreu um erro de autorização no envio do email automático: ' +
                                            ACodigoGrupoModelo + '-' + LNomeGrupo +
                                            ' - Modelo: ' + LNomeModelo + '.' + #13 +
                                            'Acesse as Configurações do Autcom na empresa ' + VS_strCodEmp + ', altere a configuração ' +
                                            '[CFG_EMASAI] - "E-mails automáticos de saída", corrija e valide os dados do email ' +
                                            'referente ao Grupo e Modelo informado.' + #13 + #13 +
                                            'Email do remetente: ' + FIdMessage.From.Address + #13 +
                                            'Provedor: ' + fCampoTabela('PRV_NOMPRV', 'CADPRV', ['PRV_CODPRV'], [FDadosAutenticacao.FProvedor]) + #13 +  #13 +
                                            'Erro gerado: ' + AErroGerado,
                                        strLoginUsuarioLogado,
                                        LConsultaOperadores.FieldByName('OPE_CODOPE').AsString,
                                        'N',
                                        NullAsStringValue);

        LConsultaOperadores.Next;
      End;
      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;

        Raise Exception.Create('Ocorreu um erro ao enviar as mensagens de autorização dos emails aos operadores.' + #13 +
                               'Erro gerado: ' + E.Message);
      End;
    End;
  Finally
    LConsultaOperadores.Close;

    FreeAndNil(LConsultaOperadores);

    FreeAndNil(LMensagemInterna);

    VS_ModeloEmailNaoAutenticado := Concat(ACodigoGrupoModelo, ACodigoModelo);
  End;
end;

procedure TEnvioEmail.EnviarMensagemErroBloqueioAosOperadores(
  ACodigoGrupoModelo, ACodigoModelo, AErroGerado: String);
  Var
    LConsultaOperadores: TUniQuery;

    LMensagemInterna: TMsgInterna;

    LTitulo,
    LMensagem,
    LNomeGrupo,
    LNomeModelo: String;
begin
  If Not MatchStr(ACodigoGrupoModelo, ['009', '025']) Then
    Exit;

  LMensagemInterna := TMsgInterna.Create(Nil);
  LConsultaOperadores := fCriaQuery;

  Try
    LConsultaOperadores.SQL.Text := 'SELECT O.OPE_CODOPE, O.OPE_EMPACE ' +
                                    'FROM CADOPE O ' +
                                    'LEFT JOIN DIROPE D ON D.OPE_CODOPE=O.OPE_CODOPE ' +
                                    '                  AND D.DIR_NOMFRM="frmConfiguracoes" ' +
                                    '                  AND D.DIR_ACAOUS="IAE" ' +
                                    'LEFT JOIN OPEGPO P ON P.OPE_CODOPE=O.OPE_CODOPE ' +
                                    'LEFT JOIN DIRGPO G ON G.GPO_CODGPO=P.GPO_CODGPO ' +
                                    '                  AND G.DIR_NOMFRM="frmConfiguracoes" ' +
                                    '                  AND G.DIR_ACAOUS="IAE" ' +
                                    'WHERE D.DIR_NOMFRM IS NOT NULL ' +
                                    '   OR G.DIR_NOMFRM IS NOT NULL ' +
                                    'GROUP BY O.OPE_CODOPE ';

    LConsultaOperadores.Open;

    LNomeGrupo := IIF(ACodigoGrupoModelo = '009',
                      'AVISOS DE COBRANÇA',
                      'AVISOS DE DÉBITOS');

    LNomeModelo := fCampoTabela('EMA_DESCRI',
                                'EMASAI',
                                ['EMA_CODGRU', 'EMA_CODIGO', 'EMA_CODEMP'],
                                [ACodigoGrupoModelo, ACodigoModelo, VS_strCodEmp]);

    LTitulo := FChavesBloqueioEmails.FieldByName('CHA_TITMSG').AsString;
    LTitulo := AcertaVariaveisVensagemBloqueio(LTitulo,
                                               LNomeGrupo,
                                               LNomeModelo,
                                               AErroGerado);

    LMensagem := FChavesBloqueioEmails.FieldByName('CHA_MSGOPE').AsString;
    LMensagem := AcertaVariaveisVensagemBloqueio(LMensagem,
                                                 LNomeGrupo,
                                                 LNomeModelo,
                                                 AErroGerado);

    Try
      fStartTransaction;
      LConsultaOperadores.First;
      While Not LConsultaOperadores.Eof Do
      Begin
        If Pos(VS_strCodEmp, LConsultaOperadores.FieldByName('OPE_EMPACE').AsString) <= 0 Then
        Begin
          LConsultaOperadores.Next;
          Continue;
        End;

        LMensagemInterna.fEnviaMensagem(LTitulo,
                                        LMensagem,
                                        strLoginUsuarioLogado,
                                        LConsultaOperadores.FieldByName('OPE_CODOPE').AsString,
                                        'N',
                                        NullAsStringValue);

        LConsultaOperadores.Next;
      End;
      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;

        Raise Exception.Create('Ocorreu um erro ao enviar as mensagens de bloqueio dos emails aos operadores.' + #13 +
                               'Erro gerado: ' + E.Message);
      End;
    End;
  Finally
    LConsultaOperadores.Close;

    FreeAndNil(LConsultaOperadores);

    FreeAndNil(LMensagemInterna);

    If FChavesBloqueioEmails.FieldByName('CHA_PARAR_').AsString.Equals('S') Then
      VS_ModeloEmailNaoAutenticado := Concat(ACodigoGrupoModelo, ACodigoModelo);
  End;
end;

function TEnvioEmail.ErroReferenteARementeDestinatario(
  AMensagemErro: String): Boolean;
begin
  Result := False;

  If AMensagemErro.IsEmpty Then
    Exit;

  FChavesBloqueioEmails.First;
  While Not FChavesBloqueioEmails.Eof Do
  Begin
    If AMensagemErro.ToLowerInvariant.Contains(FChavesBloqueioEmails.FieldByName('CHA_CHAVE_').AsString.ToLowerInvariant) Then
      Exit(True);

    FChavesBloqueioEmails.Next;
  End;
end;

function TEnvioEmail.GetDestinatario(AMsgErro: String = '';APara: Integer = 0): String;
begin
  If AMsgErro.StartsWith('<') And AMsgErro.Contains('>') And AMsgErro.Contains('@') Then
  Begin
    Result := MidStr(AMsgErro, 2, Pos('>', AMsgErro) -2);
    If Result.Contains('@') Then
      Exit;
  End;

  Result := '';
  If (FMensagem.FPara.Count > 0) Then
    Result := FMensagem.FPara[APara]
  Else If (FMensagem.FComCopia.Count > 0) Then
    Result := FMensagem.FComCopia[0]
  Else If (FMensagem.FComCopiaOculta.Count > 0) Then
    Result := FMensagem.FComCopiaOculta[0];
end;

class procedure TEnvioEmail.GravarZipMensagem(AIdMessage: TIdMessage; ADiretorioEmail, ANomeArquivoZip: String);
  Var
    arquivo: TStringList;
Begin
  AIdMessage.SaveToFile(ADiretorioEmail + ANomeArquivoZip + '.mct');

  arquivo := TStringList.Create();
  Try
    arquivo.LoadFromFile(ADiretorioEmail + ANomeArquivoZip + '.mct');
    DeleteFile(PWideChar(ADiretorioEmail + ANomeArquivoZip + '.mct'));
    arquivo.Text := CriptografarMensagemEmail(arquivo.Text,
                                              Word.Parse(Copy(ANomeArquivoZip, 34, 3)),
                                              StrToInt(Copy(ANomeArquivoZip, 19, 5)),
                                              StrToInt(Copy(ANomeArquivoZip, 28, 5)));
    arquivo.SaveToFile(ADiretorioEmail + ANomeArquivoZip + '.mcc');
  Finally
    FreeAndNil(arquivo);
  End;

  CompactarArquivos(ADiretorioEmail, ANomeArquivoZip + '.zip', [ANomeArquivoZip + '.mcc']);
End;

procedure TEnvioEmail.InicializarComponentes();
begin
  InicializarComponentesIndy(Self.GetParentComponent(),
                             FIdSMTP,
                             FIdMessage,
                             FSSLSocket,
                             FDadosAutenticacao);
end;

procedure TEnvioEmail.IniciarDatasetChavesBloqueioEmails;
  Var
    LConsulta: TUniQuery;
begin
  If Assigned(FChavesBloqueioEmails) Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT * FROM EMACHA_BLK';
    LConsulta.Open;

    FChavesBloqueioEmails := fCriaClientDatset(LConsulta);
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

procedure TEnvioEmail.LimparMensagem;
begin
  if Not Assigned(ThreadSincEmail) then
  Begin
    FIdMessage.Clear();
    FIdMessage.MessageParts.Clear();
    FEnviado        := False;
    FAnexosCount    := 0;
    FNomeArquivoZip := '';
    FDiretorioEmail := '';
  End;
end;

Function TEnvioEmail.ValidarDllsSSL: Boolean;
  Var
    strPath: String;
begin
  strPath := ExtractFilePath(Application.ExeName);

  Result := (FileExists(strPath + '\libeay32.dll'))
              And (FileExists(strPath + '\ssleay32.dll'));

  If (not Result) Then
    untFuncoesSimples.fMensagem('Alerta', 'As bibliotecas SSL não foram encontradas, entre em contato com o Suporte Citel!', ['&Ok']);
end;

function TEnvioEmail.ValidarMensagem: Boolean;
begin
  Result := (ValidarDllsSSL())     And  //validando DLLs de autenticação SSL
            (FMensagem.EhValida()) And  //validando informações da mensagem
            (FDadosAutenticacao.EhValido());  //validando as informações de autenticação do provedor de e-Mail
end;

{ TImagemCorpoHtml }

constructor TImagemCorpoHtml.Create(ACaminhoImagem: String);
begin
  FCaminhoImagem := ACaminhoImagem;
end;

function CriptografarMensagemEmail(const S: WideString; Key: Word; CKey1, CKey2: Integer): String;
  var
    i    : Integer;
    RStr : RawByteString;
    RStrB: TBytes Absolute RStr;
begin
  Result:= '';
  RStr  := UTF8Encode(S);

  for i := 0 to Length(RStr)-1 do begin
    RStrB[i] := RStrB[i] xor (Key shr 8);
    Key := (RStrB[i] + Key) * CKEY1 + CKEY2;
  end;

  for i := 0 to Length(RStr)-1 do begin
    Result:= Result + IntToHex(RStrB[i], 2);
  end;
end;

function DescriptografarMensagemEmail(const S: String; Key: Word; CKey1, CKey2: Integer): String;
  var
    i, tmpKey: Integer;
    RStr     : RawByteString;
    RStrB    : TBytes Absolute RStr;
    tmpStr   : String;
begin
  tmpStr := UpperCase(S);
  SetLength(RStr, Length(tmpStr) div 2);
  i:= 1;

  try
    while (i < Length(tmpStr)) do begin
      if (tmpStr[i] <> #13) and (tmpStr[i+1] <> #10) then
        RStrB[i div 2]:= StrToInt('$' + tmpStr[i] + tmpStr[i+1]);

      Inc(i, 2);
    end;
  except
    Result:= '';
    Exit;
  end;

  for i := 0 to Length(RStr)-1 do begin
    tmpKey:= RStrB[i];
    RStrB[i] := RStrB[i] xor (Key shr 8);
    Key := (tmpKey + Key) * CKEY1 + CKEY2;
  end;

  Result:= UTF8ToWideString(RStr);
end;

function CriptografarSenhaEmail(strSenha: String): String;
  var
    i : Integer;
    Simbolos : Array [0..4] Of String;
begin
  Simbolos[1]:= 'ABCDEFGHIJLMNOPQRSTUVXZYWK ~!@#$%^&*()';
  Simbolos[2]:= 'ÂÀ©Øû×ƒçêùÿ5Üø£úñÑªº¿®¬¼ëèïÙýÄÅÉæÆôöò»Á';
  Simbolos[3]:= 'abcdefghijlmnopqrstuvxzywk1234567890';
  Simbolos[4]:= 'áâäàåíóÇüé¾¶§÷ÎÏ-+ÌÓß¸°¨·¹³²Õµþîì¡«½';

  for i := 1 to Length(Trim(strSenha)) do
  begin
    if (Pos(Copy(strSenha, i, 1), Simbolos[1]) > 0) then
      Result := Result + Copy(Simbolos[2], Pos(Copy(strSenha, i, 1), Simbolos[1]), 1)
    else if (Pos(Copy(strSenha, i, 1), Simbolos[2]) > 0) then
      Result := Result + Copy(Simbolos[1], Pos(Copy(strSenha, i, 1), Simbolos[2]), 1)
    else if (Pos(Copy(strSenha, i, 1), Simbolos[3]) > 0) then
      Result := Result + Copy(Simbolos[4], Pos(Copy(strSenha, i, 1), Simbolos[3]), 1)
    else if (Pos(Copy(strSenha, i, 1), Simbolos[4]) > 0) then
      Result := Result + Copy(Simbolos[3], Pos(Copy(strSenha, i, 1), Simbolos[4]), 1)
    else
      Result := Result + Copy(strSenha, i, 1);
  end;
end;

Function ValidarDiretorioEmail(out diretorio: String): Boolean;
Begin
  Result := True;

  Try
    If VS_PastaEmailsEnviados.IsEmpty Then
    Begin
      VS_PastaEmailsEnviados := fCfgSis('PASEMA', varString);
      If VS_PastaEmailsEnviados.IsEmpty Then
        VS_PastaEmailsEnviados := ExtractFilePath(Application.ExeName);
    End;

    If Not RightStr(VS_PastaEmailsEnviados, 1).Equals('\') Then
      VS_PastaEmailsEnviados := VS_PastaEmailsEnviados + '\';

    If (Not fEmptyStr(diretorio)) Then
      diretorio := '';

    diretorio := VS_PastaEmailsEnviados + 'EmailTemp\';

    If (Not DirectoryExists(diretorio)) Then
      MkDir(diretorio);

    diretorio := diretorio + strLoginUsuarioLogado + '\';

    If (Not DirectoryExists(diretorio)) Then
      MkDir(diretorio);
  Except
    On E: Exception Do
      Result := False;
  End;
End;

Function CompactarArquivos(diretorio, nomeArquivoZip: String; nomeArquivosComprimir: TStringArray; deletarArquivo: Boolean): Boolean;
  Var
    i: Integer;
    zip : TZipFile;
Begin
  Result := False;

  Try
    zip := TZipFile.Create();

    Try
      If (Not DirectoryExists(diretorio)) Then
        MkDir(diretorio);

      If FileExists(diretorio + nomeArquivoZip) Then
        DeleteFile(PWideChar(diretorio + nomeArquivoZip));

      zip.Open(diretorio + nomeArquivoZip, zmWrite);

      For i := 0 To Length(nomeArquivosComprimir) - 1 Do
        zip.Add(diretorio + nomeArquivosComprimir[i]);

      zip.Close();

      If (deletarArquivo) Then
        For i := 0 To Length(nomeArquivosComprimir) - 1 Do
          If (FileExists(diretorio + nomeArquivosComprimir[i])) Then
            DeleteFile(PWideChar(diretorio + nomeArquivosComprimir[i]));

      Result := True;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[untFuncoesSimples.CompactarArquivos]');
    End;
  Finally
    FreeAndNil(zip);
  End;
End;

Function DescompactarArquivos(diretorio, nomeArquivoZip: String; deletarArquivoZip: Boolean): Boolean;
  Var
    zip: TZipFile;
    tempDir: String;
Begin
  Result := False;

  Try
    zip     := TZipFile.Create();
    tempDir := diretorio + Copy(nomeArquivoZip, 1, Pos('.zip', nomeArquivoZip) - 1);

    Try
      If (Not DirectoryExists(diretorio)) Then
        MkDir(diretorio);

      zip.Open(diretorio + nomeArquivoZip, zmRead);

      If (Not DirectoryExists(tempDir)) Then
        MkDir(tempDir);

      zip.ExtractAll(tempDir);
      zip.Close();

      If (deletarArquivoZip) Then
        DeleteFile(PWideChar(diretorio + nomeArquivoZip));

      Result := True;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[untFuncoesSimples.DescompactarArquivos]');
    End;
  Finally
    FreeAndNil(zip);
  End;
End;

Procedure InicializarComponentesIndy(AOwner: TComponent; Var AIdSMTP: TIdSMTP; Var AIdMessage: TIdMessage;
    Var ASSLSocket: TIdSSLIOHandlerSocketOpenSSL; ADadosAutenticacao: TAutenticacaoEmail);
Begin
  AIdSMTP       := TIdSMTP.Create(AOwner);
  AIdMessage    := TIdMessage.Create(AOwner);
  ASSLSocket    := TIdSSLIOHandlerSocketOpenSSL.Create(AOwner);

  AIdMessage.Date               := VS_Date;
  AIdMessage.Priority           := mpNormal;
  AIdMessage.Encoding           := meDefault;
  AIdMessage.ConvertPreamble    := True;
  AIdMessage.AttachmentEncoding := 'MIME';

  AIdSMTP.IOHandler   := ASSLSocket;
  AIdSMTP.AuthType    := satDefault;

  If (Not ADadosAutenticacao.blnSSLSai) Then
    AIdSMTP.UseTLS    := utUseExplicitTLS
  Else
    AIdSMTP.UseTLS    := utUseImplicitTLS;

  AIdSMTP.ReadTimeout := 90000;
  AIdSMTP.ConnectTimeout := 90000;

  AIdSMTP.Host     := ADadosAutenticacao.servidorSmtp;
  AIdSMTP.Port     := ADadosAutenticacao.portaSmtp;
  AIdSMTP.Username := ADadosAutenticacao.login;
  AIdSMTP.Password := ADadosAutenticacao.senha;

  ASSLSocket.Port                   := AIdSMTP.Port;
  ASSLSocket.DefaultPort            := 0;
  ASSLSocket.Destination            := ':'+IntToStr(ASSLSocket.Port);
  ASSLSocket.MaxLineAction          := maException;
  ASSLSocket.SSLOptions.Mode        := fRetModeSSL;
  ASSLSocket.SSLOptions.Method      := fRetVersaoTLSSSL();
  ASSLSocket.SSLOptions.VerifyMode  := [];
  ASSLSocket.SSLOptions.SSLVersions := [fRetVersaoTLSSSL()];
  ASSLSocket.SSLOptions.VerifyDepth := 0;
  ASSLSocket.ConnectTimeout         := 90000;
End;

Function fRetVersaoTLSSSL: TIdSSLVersion;
begin
  If      (VS_VersaoTLSSSL = 'sslvSSLv2')   Then Result := sslvSSLv2
  Else If (VS_VersaoTLSSSL = 'sslvSSLv23')  Then Result := sslvSSLv23
  Else If (VS_VersaoTLSSSL = 'sslvSSLv3')   Then Result := sslvSSLv3
  Else If (VS_VersaoTLSSSL = 'sslvTLSv1')   Then Result := sslvTLSv1
  Else If (VS_VersaoTLSSSL = 'sslvTLSv1_1') Then Result := sslvTLSv1_1
  Else If (VS_VersaoTLSSSL = 'sslvTLSv1_2') Then Result := sslvTLSv1_2
  Else Result := sslvTLSv1;
end;

Function fRetModeSSL: TIdSSLMode;
begin
  If      (VS_ModeSSL = 'sslmUnassigned') Then Result := sslmUnassigned
  Else If (VS_ModeSSL = 'sslmClient')     Then Result := sslmClient
  Else If (VS_ModeSSL = 'sslmServer')     Then Result := sslmServer
  Else If (VS_ModeSSL = 'sslmBoth')       Then Result := sslmBoth
  Else Result := sslmUnassigned;
end;

{ TListaContatosEmail }

constructor TListaContatosEmail.Create(AOwner: TComponent; ACodOpe: String; ATipoOperacao: TTipoOperacaoConsulta);
begin
  If (fEmptyStr(ACodOpe)) Then
    Raise ExceptionAutCom.Create('Código do Operador não foi informado para a criação da listagem de contatos de e-mail. Operação cancelada!')
  Else
    FCodOpe := ACodOpe;

  FEditTexto  := nil;
  FEditFiltro := nil;

  FFiltro := '';
  FContatosSelecionados := '';

  FTipoOperacao := ATipoOperacao;

  FPnlLista := TPanel.Create(AOwner);
  FPnlLista.Parent  := TForm(AOwner);
  FPnlLista.Caption := '';
  FPnlLista.Visible := False;
  FPnlLista.Align   := alNone;

  FListagem := TListBox.Create(AOwner);
  FListagem.Parent       := FPnlLista;
  FListagem.Visible      := False;
  FListagem.Style        := lbOwnerDrawFixed;
  FListagem.OnKeyDown    := pOnKeyDownListagem;
  FListagem.OnKeyUp      := pOnKeyUpListagem;
  FListagem.OnDblClick   := pOnDblClickListagem;
  FListagem.AutoComplete := False;

  FPnlLista.InsertComponent(FListagem);
  FListagem.Align     := alClient;

  pCriarComponentesDados();

  pInicializarListagemContatos();
end;

destructor TListaContatosEmail.Destroy;
begin
  FreeAndNil(FPnlLista);
  FreeAndNil(FListagem);

  FreeAndNil(FQryContatos);
  FreeAndNil(FCdsContatos);

  SetLength(FContatos, 0);

  If (Assigned(FEditFiltro)) Then
    FreeAndNil(FEditFiltro);

  If (Assigned(FEditTexto)) Then
    FreeAndNil(FEditTexto);

  inherited;
end;

class function TListaContatosEmail.fEmailExistente(AEmail: String; Out ASeqCon: String; bnlEnvAutCob: Boolean = False): Boolean;
  Var
    qryTemp: TUniQuery;
begin
  Result := False;

  Try
    qryTemp := fCriaQuery(nil);

    Try
      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := 'SELECT EMA_SEQCON FROM CONOPE INNER JOIN EMACON ON AUTOINCREM = EMA_SEQCON WHERE CON_CODOPE = :CODOPE AND EMA_EMAIL_ = :EMAIL_';
      qryTemp.ParamByName('EMAIL_').AsString := AEmail;
      qryTemp.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      qryTemp.Open;

      Result  := (Not qryTemp.IsEmpty);
      ASeqCon := qryTemp.FieldByName('EMA_SEQCON').AsString;
    Except
      On E: Exception Do
        If bnlEnvAutCob Then
          pGravarErro(True, E.Message + ' [TListaContatosEmail.fEmailExistente]', fRetornaStack)
        Else
          pMensagensErro(E.Message, 'TListaContatosEmail.fEmailExistente');
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TListaContatosEmail.pAtualizarArrayListagem;
begin
  Try
    SetLength(FContatos, 0);

    SetLength(FContatos, FCdsContatos.RecordCount);
    FCdsContatos.First();

    While (Not FCdsContatos.Eof) Do Begin
      FContatos[FCdsContatos.RecNo - 1].intIndex  := FCdsContatos.RecNo - 1;
      FContatos[FCdsContatos.RecNo - 1].strCodOpe := FCdsContatos.FieldByName('CODOPE').AsString;
      FContatos[FCdsContatos.RecNo - 1].strNomCon := FCdsContatos.FieldByName('NOMCON').AsString;
      FContatos[FCdsContatos.RecNo - 1].strTelRes := FCdsContatos.FieldByName('TELRES').AsString;
      FContatos[FCdsContatos.RecNo - 1].strTelCom := FCdsContatos.FieldByName('TELCOM').AsString;
      FContatos[FCdsContatos.RecNo - 1].strCelula := FCdsContatos.FieldByName('CELULA').AsString;
      FContatos[FCdsContatos.RecNo - 1].strEmail  := Trim(FCdsContatos.FieldByName('EMAIL_').AsString);

      FCdsContatos.Next();
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TListaContatosEmail.pAtualizarArrayListagem]');
  End;
end;

procedure TListaContatosEmail.pAtualizarListaContatos;
begin
  pInicializarListagemContatos();
end;

procedure TListaContatosEmail.pAtualizarListboxListagem;
  Var
    i: Integer;
begin
  Try
    FListagem.Clear();

    For i := 0 To Length(FContatos) - 1 Do Begin
      If (Not fEmptyStr(FContatos[i].strNomCon)) Then
        FListagem.Items.Add('"' + FContatos[i].strNomCon + '" <' + FContatos[i].strEmail + '>')
      Else
        FListagem.Items.Add('<' + FContatos[i].strEmail + '>');
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TListaContatosEmail.pAtualizarListboxListagem]');
  End;
end;

procedure TListaContatosEmail.pBuscarDadosContatos;

  procedure pBuscarContatos(); begin
    FQryContatos.Close();
    FQryContatos.SQL.Clear();
    FQryContatos.SQl.Text := 'SELECT AUTOINCREM, ' +
                                    'CON_CODOPE AS CODOPE, ' +
                                    'CON_NOMCON AS NOMCON, ' +
                                    'CON_TELRES AS TELRES, ' +
                                    'CON_TELCOM AS TELCOM, ' +
                                    'CON_CELULA AS CELULA, ' +
                                    'EMA_EMAIL_ AS EMAIL_ ' +
                             '  FROM CONOPE INNER JOIN EMACON ON AUTOINCREM = EMA_SEQCON ' +
                             ' WHERE CON_CODOPE = :CODOPE ORDER BY EMA_EMAIL_';
    FQryContatos.ParamByName('CODOPE').AsString := FCodOpe;
    FQryContatos.Open();
    FQryContatos.First();
  end;

  procedure pReiniciarClientDataSet; begin
    FCdsContatos.Close();
    FCdsContatos.CreateDataSet();
    FCdsContatos.EmptyDataSet();

    FCdsContatos.Filtered := False;
    FCdsContatos.Filter   := '';
  end;

begin
  Try
    pBuscarContatos();
    pReiniciarClientDataSet();

    While (Not FQryContatos.Eof) Do Begin
      FCdsContatos.Append();

      FCdsContatos.FieldByName('AUTOINCREM').AsString := FQryContatos.FieldByName('AUTOINCREM').AsString;
      FCdsContatos.FieldByName('CODOPE').AsString := FQryContatos.FieldByName('CODOPE').AsString;
      FCdsContatos.FieldByName('NOMCON').AsString := FQryContatos.FieldByName('NOMCON').AsString;
      FCdsContatos.FieldByName('TELRES').AsString := FQryContatos.FieldByName('TELRES').AsString;
      FCdsContatos.FieldByName('TELCOM').AsString := FQryContatos.FieldByName('TELCOM').AsString;
      FCdsContatos.FieldByName('CELULA').AsString := FQryContatos.FieldByName('CELULA').AsString;
      FCdsContatos.FieldByName('EMAIL_').AsString := Trim(FQryContatos.FieldByName('EMAIL_').AsString);

      FCdsContatos.Post();
      FQryContatos.Next();
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TListaContatosEmail.pBuscarDadosContatos]');
  End;
end;

procedure TListaContatosEmail.pCriarComponentesDados();
begin
  FQryContatos := fCriaQuery(Self.GetParentComponent());

  FCdsContatos := TUniClientDataSet.Create(Self.GetParentComponent());

  With FCdsContatos.FieldDefs.AddFieldDef Do Begin
    Name     := 'AUTOINCREM';
    DataType := ftString;
    Size     := 20;
  End;

  With FCdsContatos.FieldDefs.AddFieldDef Do Begin
    Name     := 'CODOPE';
    DataType := ftString;
    Size     := 3;
  End;

  With FCdsContatos.FieldDefs.AddFieldDef Do Begin
    Name     := 'NOMCON';
    DataType := ftString;
    Size     := 120;
  End;

  With FCdsContatos.FieldDefs.AddFieldDef Do Begin
    Name     := 'TELRES';
    DataType := ftString;
    Size     := 15;
  End;

  With FCdsContatos.FieldDefs.AddFieldDef Do Begin
    Name     := 'TELCOM';
    DataType := ftString;
    Size     := 15;
  End;

  With FCdsContatos.FieldDefs.AddFieldDef Do Begin
    Name     := 'CELULA';
    DataType := ftString;
    Size     := 15;
  End;

  With FCdsContatos.FieldDefs.AddFieldDef Do Begin
    Name     := 'EMAIL_';
    DataType := ftString;
    Size     := 250;
  End;

  FCdsContatos.CreateDataSet();
  FCdsContatos.IndexFieldNames := 'NOMCON;EMAIL_';

  FCdsContatos.Open();

  FCdsContatos.OnFilterRecord := pOnFilterRecord;
end;

procedure TListaContatosEmail.pExibirListagem(AExibir: Boolean; AParent: TComponent);
  Var
    point: TPoint;
begin
  If (AExibir) Then Begin
    If (Not Assigned(AParent)) And (FTipoOperacao = toMenuSuspenso) Then Begin
      point := FEditFiltro.ClientOrigin;

      FPnlLista.Top  := point.Y - 3;
      FPnlLista.Left := point.X - 3;

      FPnlLista.Height := ((FListagem.ItemHeight + 2) * IIF(FCdsContatos.RecordCount > 20, 20, FCdsContatos.RecordCount)) + 3;
      FPnlLista.Width  := FEditFiltro.Width + 2;
    End Else Begin
      If (Assigned(AParent)) Then Begin
        If (FTipoOperacao = toMenuSuspenso) Then
          FPnlLista.Parent := TForm(AParent)
        Else If (FTipoOperacao = toConsultaContatos) Then Begin
          FPnlLista.Parent := TGroupBox(AParent);
          TGroupBox(AParent).InsertComponent(FPnlLista);
          FPnlLista.Align := alClient;
        End;
      End;
    End;

    FPnlLista.Visible := True;
    FListagem.Visible := True;
  End Else Begin
    FPnlLista.Visible := False;
    FListagem.Visible := False;

    pSetFocus(FEditFiltro);

    If (Length(FEditFiltro.Text) > 0) Then
      FEditFiltro.SelStart := Length(FEditFiltro.Text);
  End;
end;

procedure TListaContatosEmail.pFiltrarContatos(AFiltro: String; Var AEditFiltro, AEditTexto: TEditFocus);
begin
  Try
    If (Not Assigned(AEditFiltro)) Then
      Raise ExceptionAutCom.Create('Edit de filtro não foi informado para a criação da listagem de contatos de e-mail. Operação cancelada!')
    Else
      FEditFiltro := AEditFiltro;

    If (Not Assigned(AEditTexto)) Then
      Raise ExceptionAutCom.Create('Edit de filtro não foi informado para a criação da listagem de contatos de e-mail. Operação cancelada!')
    Else
      FEditTexto := AEditTexto;

    FFiltro := pSelecionarFiltroString(AFiltro);

    If (Not fEmptyStr(FFiltro)) Or (FTipoOperacao = toConsultaContatos) Then Begin
      FCdsContatos.Filtered := False;
      FCdsContatos.Filter   := '';
      FCdsContatos.Filtered := True;

      If (Not FCdsContatos.IsEmpty) Or (FPnlLista.Parent Is TGroupBox) Then Begin
        //atualizar array dos contatos
        pAtualizarArrayListagem();

        //atualizar o listbox
        pAtualizarListboxListagem();

        pExibirListagem(True);
      End Else Begin
        If (FTipoOperacao = toMenuSuspenso) Then
          pExibirListagem(False);
      End;
    End Else Begin
      If (FTipoOperacao = toMenuSuspenso) Then
        pExibirListagem(False);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TListaContatosEmail.pFiltrarContatos]');
  End;
end;

class procedure TListaContatosEmail.pGravarContato(AContato: TContatoOperador);
  Var
    i: Integer;
    qryTemp: TUniQuery;
    strAutInc, strNomCon: String;

  procedure pAtualizarNomeContato(ANomCon, ASeqCon: String); begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Add('UPDATE CONOPE SET CON_NOMCON = :NOMCON WHERE AUTOINCREM = :SEQCON');
    qryTemp.ParamByName('NOMCON').AsString := ANomCon;
    qryTemp.ParamByName('SEQCON').AsString := ASeqCon;

    qryTemp.ExecSQL();
  end;

  procedure pAdicionarEmailContato(AEmail, ASeqCon: String); begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Add('INSERT INTO EMACON (EMA_SEQCON, EMA_EMAIL_) VALUES (:SEQCON, :EMAIL)');
    qryTemp.ParamByName('EMAIL').AsString  := AEmail;
    qryTemp.ParamByName('SEQCON').AsString := ASeqCon;

    qryTemp.ExecSQL();
  end;

  procedure pAdicionarContato(ACodOpe, ANomCon, ATelRes, ATelCom, ACelula, AEmail, ASeqCon: String);
  Var
    strSQL: String;
  begin
    strSQL := '';
    strSQL := strSQL + 'INSERT INTO          ';
    strSQL := strSQL + '  CONOPE(            ';
    strSQL := strSQL + '         AUTOINCREM, ';
    strSQL := strSQL + '         CON_CODOPE, ';
    strSQL := strSQL + '         CON_NOMCON, ';
    strSQL := strSQL + '         CON_TELRES, ';
    strSQL := strSQL + '         CON_TELCOM, ';
    strSQL := strSQL + '         CON_CELULA) ';
    strSQL := strSQL + '  VALUES(            ';
    strSQL := strSQL + '         :AUTINC, ';
    strSQL := strSQL + '         :CODOPE, ';
    strSQL := strSQL + '         :NOMCON, ';
    strSQL := strSQL + '         :TELRES, ';
    strSQL := strSQL + '         :TELCOM, ';
    strSQL := strSQL + '         :CELULA) ';
    strSQL := strSQL;

    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Add(strSQL);
    qryTemp.ParamByName('AUTINC').AsString := ASeqCon;
    qryTemp.ParamByName('CODOPE').AsString := ACodOpe;
    qryTemp.ParamByName('NOMCON').AsString := ANomCon;
    qryTemp.ParamByName('TELRES').AsString := ATelRes;
    qryTemp.ParamByName('TELCOM').AsString := ATelCom;
    qryTemp.ParamByName('CELULA').AsString := ACelula;

    qryTemp.ExecSQL;

    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Add('INSERT INTO EMACON (EMA_SEQCON, EMA_EMAIL_) VALUES (:SEQCON, :EMAIL_)');
    qryTemp.ParamByName('SEQCON').AsString := ASeqCon;
    qryTemp.ParamByName('EMAIL_').AsString := Trim(AEmail);

    qryTemp.ExecSQL();
  end;
begin
  Try
    qryTemp := fCriaQuery(nil);

    Try
      strAutInc := '';

      If (Assigned(AContato.stlEmail)) And (AContato.stlEmail.Count > 0) Then Begin

        fStartTransaction();

        For i := 0 To AContato.stlEmail.Count - 1 Do Begin

          If (Not fEmptyStr(AContato.stlEmail[i])) Then Begin

            If (fEmailExistente(AContato.stlEmail[i], strAutInc)) Then Begin
              strNomCon := fCampoTabela('CON_NOMCON', 'CONOPE', ['AUTOINCREM'], [strAutInc]);

              If (fEmptyStr(strNomCon)) Then Begin
                pAtualizarNomeContato(AContato.strNomCon, strAutInc);
              End;
            End Else Begin
              strAutInc := fCampoTabela('AUTOINCREM', 'CONOPE', ['CON_NOMCON'], [AContato.strNomCon]);

              If (fEmptyStr(strAutInc)) Then Begin
                strAutInc := fRetAutoIncrem('CONOPE', VS_strCodEmp);

                pAdicionarContato(AContato.strCodOpe,
                                  AContato.strNomCon,
                                  AContato.strTelRes,
                                  AContato.strTelCom,
                                  AContato.strCelula,
                                  AContato.stlEmail[i],
                                  strAutInc);
              End Else Begin
                pAdicionarEmailContato(AContato.stlEmail[i], strAutInc);
              End;
            End;
          End;
        End;

        fCommit();
      End;
    Except
      On E: Exception Do Begin
        pMensagensErro(E.Message, 'TListaContatosEmail.pGravarContato');
        fRollback();
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

class procedure TListaContatosEmail.pGravarContato(AEmail, strIncCon: String; bnlEnvAutCob: Boolean);
Var
  qryTemp   : TUniQuery;
  strSQL,
  strSeqCon,
  strAutInc : String;

  {Req: 115080 - Verifica se já foi inserido o CONOPE, pois no disparo de e-mails
   automáticos podemos inserir até 3 e-mails diferentes para o mesmo CONOPE (Clientes).}
  function fJahGerou_ConOpe(strAutoincrem : String) : Boolean;
  var
    qryAux : TUniQuery;
  Begin

    Result := False;

    If fEmptyStr(strAutoincrem) Then
      Exit;

    qryAux := fCriaQuery(Nil);

    Try

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT * FROM CONOPE WHERE AUTOINCREM = :AUTINC ');
      qryAux.ParamByName('AUTINC').AsString := strAutoincrem;
      qryAux.Open;

      Result := Not qryAux.IsEmpty;

      qryAux.Close;

    Finally
      FreeAndNil(qryAux);
    End;

  End;

begin

  If (fEmptyStr(AEmail)) Or (TListaContatosEmail.fEmailExistente(AEmail, strSeqCon, bnlEnvAutCob)) Then
    Exit;

  Try

    {Cria query}
    qryTemp := fCriaQuery(Nil);

    Try

      {Start transação}
      fStartTransaction();

      If Not fEmptyStr(strIncCon) Then
        strAutInc := strIncCon
      Else
        strAutInc := fRetAutoIncrem('CONOPE', VS_strCodEmp);

      If (Not fJahGerou_ConOpe(strAutInc)) Then
      Begin

        strSQL := '';
        strSQL := strSQL + 'INSERT INTO          ';
        strSQL := strSQL + '  CONOPE(            ';
        strSQL := strSQL + '         AUTOINCREM, ';
        strSQL := strSQL + '         CON_CODOPE) ';
        strSQL := strSQL + '  VALUES(            ';
        strSQL := strSQL + '         :AUTINC,    ';
        strSQL := strSQL + '         :CODOPE)    ';
        strSQL := strSQL;

        qryTemp.Close();
        qryTemp.SQL.Clear();
        qryTemp.SQL.Add(strSQL);

        qryTemp.ParamByName('AUTINC').AsString := strAutInc;
        qryTemp.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
        qryTemp.ExecSQL;

      End;

      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Add('INSERT INTO EMACON (EMA_SEQCON, EMA_EMAIL_) VALUES (:SEQCON, :EMAIL_)');
      qryTemp.ParamByName('SEQCON').AsString := strAutInc;
      qryTemp.ParamByName('EMAIL_').AsString := Trim(AEmail);

      qryTemp.ExecSQL();

      {Commit transação}
      fCommit();

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TListaContatosEmail.pGravarContato');

        {Rollback transação}
        fRollback();
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TListaContatosEmail.pInicializarListagemContatos;
begin
  //atualizar dados do CDS e QRY
  pBuscarDadosContatos();

  //atualizar array dos contatos
  pAtualizarArrayListagem();

  //atualizar o listbox
  pAtualizarListboxListagem();
end;

procedure TListaContatosEmail.pOnDblClickListagem(Sender: TObject);
begin
//  If (FTipoOperacao = toConsultaContatos) Then
    pSelecionarFiltroString(FEditTexto.Text);

  pSelecionarContato(FListagem.ItemIndex);
end;

procedure TListaContatosEmail.pOnFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
  Var
    strFiltro, strNomCon, strEmail: String;
begin
  strFiltro := fTiraCaracEspeciais(AnsiLowerCase(FFiltro));
  strNomCon := fTiraCaracEspeciais(AnsiLowerCase(DataSet.FieldByName('NOMCON').AsString));
  strEmail  := AnsiLowerCase(DataSet.FieldByName('EMAIL_').AsString);

  pSelecionarFiltroString(FEditTexto.Text);

  Accept := (
              (Pos(strFiltro, strNomCon) > 0) Or
              (Pos(strFiltro, strEmail) > 0)
            ) And
            (
              (Pos(strEmail, FContatosSelecionados) <= 0)
            );

  If (FTipoOperacao = toConsultaContatos) And (fEmptyStr(strFiltro))Then
    Accept := True;
end;

procedure TListaContatosEmail.pOnKeyDownListagem(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = Word(13)) Then //VK_RETURN
    pSelecionarContato(FListagem.ItemIndex);
end;

procedure TListaContatosEmail.pOnKeyUpListagem(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = Word(38)) Then Begin  //VK_UP
    If (FListagem.ItemIndex = 0) Then Begin
      pSetFocus(FEditFiltro);

      If (Length(FEditFiltro.Text) > 0) Then
        FEditFiltro.SelStart := Length(FEditFiltro.Text);
    End;
  End
end;

procedure TListaContatosEmail.pSelecionarContato(AItemIndex: Integer);
begin
  If (Assigned(FEditTexto)) And (AItemIndex >= 0) Then Begin
    If (Pos(FContatos[AItemIndex].strEmail, FEditTexto.Text) = 0) Then
      FEditTexto.Text := FContatosSelecionados + FContatos[AItemIndex].strEmail + '; ';

    If (FTipoOperacao = toMenuSuspenso) Then
      pExibirListagem(False)
    Else Begin
      FListagem.ItemIndex := -1;
      FEditFiltro.Text    := '';

      pSetFocus(FEditFiltro);

      If (Length(FEditFiltro.Text) > 0) Then
        FEditFiltro.SelStart := Length(FEditFiltro.Text);
    End;
  End;
end;

function TListaContatosEmail.pSelecionarFiltroString(ATextoEditFiltro: String): String;
  Var
    strTemp, strSelecionado: String;
begin
  strTemp := StringReplace(ATextoEditFiltro, ',', ';', [rfReplaceAll]);
  strSelecionado := '';

  FContatosSelecionados := '';

  Repeat
    strSelecionado := Trim(Copy(strTemp, 1, Pos(';', strTemp) - 1));
    strTemp := Trim(Copy(strTemp, Pos(';', strTemp) + 1, Length(strTemp)));

    If (Pos('@', strSelecionado) > 0) Then
      FContatosSelecionados := FContatosSelecionados + strSelecionado + '; ';
  Until (Pos(';', strTemp) = 0);

  Result := Trim(strTemp);
end;

{ untThreadSincronizaEmails }

constructor TThreadSincronizaEmails.Create();
begin
  inherited Create(True);

  FListaEmails := TObjectList<TEmailsSinc>.Create;
  Priority  := tpLower;
end;

destructor TThreadSincronizaEmails.Destroy;
Var
  EmailSinc: TEmailsSinc;
begin
  For EmailSinc In FListaEmails Do
  begin
    if Assigned(EmailSinc.DadosAutenticacao) then
      EmailSinc.DadosAutenticacao.Free;

    if Assigned(EmailSinc.IdSMTP) then
      EmailSinc.IdSMTP.Free;

    if Assigned(EmailSinc.IdMessage) then
      EmailSinc.IdMessage.Free;

    if Assigned(EmailSinc.SSLSocket) then
      EmailSinc.SSLSocket.Free;
  end;

  FListaEmails.Clear;

  inherited;
end;

procedure TThreadSincronizaEmails.Execute;
var
  EmailSinc: TEmailsSinc;

  procedure GravarPastaEnviados(AEmailsSinc: TEmailsSinc);
    Var
      i,
      intCont: Integer;
      IdIMAP: TIdIMAP4;
      pastas: TStringList;
      confirmado, encontrada: Boolean;
      IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
  Begin
    If AEmailsSinc.HoraEnvio > 0 Then
      AEmailsSinc.IdMessage.Date := AEmailsSinc.HoraEnvio;
    If AEmailsSinc.IdMessage.Recipients.Count = 0 Then
    Begin
      For intCont := 0 To Length(AEmailsSinc.Para) - 1 Do
      Begin
        AEmailsSinc.IdMessage.Recipients.Add;
        AEmailsSinc.IdMessage.Recipients.Items[intCont].Address := AEmailsSinc.Para[intCont];
      End;
    End;

    If (Not fEmptyStr(AEmailsSinc.DadosAutenticacao.ServidorImap))
      And (AEmailsSinc.DadosAutenticacao.PortaImap > 0)
      And (IfEmptyStr(AEmailsSinc.DadosAutenticacao.strGravaPastaEnviados, 'S') = 'S') Then
    Begin
      IdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create();

      Try
        IdSSLIOHandlerSocketOpenSSL.Destination := AEmailsSinc.DadosAutenticacao.ServidorImap + ':' + IntToStr(AEmailsSinc.DadosAutenticacao.PortaImap);
        IdSSLIOHandlerSocketOpenSSL.Host := AEmailsSinc.DadosAutenticacao.ServidorImap;
        IdSSLIOHandlerSocketOpenSSL.Port := AEmailsSinc.DadosAutenticacao.PortaImap;
        IdSSLIOHandlerSocketOpenSSL.DefaultPort := 0;
        IdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := fRetVersaoTLSSSL(){sslvSSLv3};
        IdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLversions := [fRetVersaoTLSSSL(){sslvSSLv3}];
        IdSSLIOHandlerSocketOpenSSL.SSLOptions.Mode := fRetModeSSL;
        IdSSLIOHandlerSocketOpenSSL.SSLOptions.VerifyMode := [];
        IdSSLIOHandlerSocketOpenSSL.SSLOptions.VerifyDepth := 0;

        IdIMAP := TIdIMAP4.Create();
        Try
          IdIMAP.IOHandler := IdSSLIOHandlerSocketOpenSSL;
          IdIMAP.Host      := AEmailsSinc.DadosAutenticacao.ServidorImap;
          IdIMAP.Password  := AEmailsSinc.DadosAutenticacao.Senha;
          IdIMAP.Port      := AEmailsSinc.DadosAutenticacao.PortaImap;

          If (Not AEmailsSinc.DadosAutenticacao.blnSSLEnt) Then
            IdIMAP.UseTLS  := utUseExplicitTLS
          Else
            IdIMAP.UseTLS  := utUseImplicitTLS;

          IdIMAP.Username  := AEmailsSinc.DadosAutenticacao.Login;

          If TAutenticacaoEmail.ConnectIdIMAP(IdIMAP, AEmailsSinc.DadosAutenticacao.usuario, AEmailsSinc.DadosAutenticacao) Then
          Begin
            pastas := TStringList.Create();

            Try
              confirmado := IdIMAP.ListMailBoxes(pastas);

              If (confirmado) then
              Begin
                encontrada := False;

                For i := 0 to pastas.Count - 1 Do
                Begin
                  If (Pos('ENVIAD', UpperCase(pastas[i])) > 0) or (Pos('SENT', UpperCase(pastas[i])) > 0) Then
                  Begin
                    encontrada := True;

                    If (IdIMAP.SelectMailbox(pastas[i])) Then
                    Begin
                      IdIMAP.AppendMsg(pastas[i], AEmailsSinc.IdMessage, nil, [mfSeen]);
                      IdIMAP.Disconnect;
                      Break;
                    End;
                  End;
                End;

                If (not encontrada) Then
                  untFuncoesSimples.fMensagem('Alerta', 'Não foi encontrada a pasta de mensagens ''Enviadas'' em sua conta de e-mail.' +
                    #13#10 + 'Verifique nas configurações do provedor para que futuramente este problema não ocorra.', ['&Ok']);
              End;
            Except
              On E: Exception Do
                pMensagensErro(E.Message, '[TEnvioEmail.GravarPastaEnviados]');
            End;
          End;
        Finally
          FreeAndNil(pastas);
          FreeAndNil(IdIMAP);
        End;
      Finally
        FreeAndNil(IdSSLIOHandlerSocketOpenSSL);
      End;
    End;
  End;
begin
  FTerminou := False;
  For EmailSinc In FListaEmails Do
  begin
    FErroNoEnvio   := False;
    Try
      GravarPastaEnviados(EmailSinc);
      TEnvioEmail.GravarZipMensagem(EmailSinc.IdMessage, EmailSinc.DiretorioEmail, EmailSinc.NomeArquivoZip);
    Except
      FErroNoEnvio := True;
    end;
  end;
  FTerminou := True;
end;

function TThreadSincronizaEmails.fGetQuantidadeEmails: Integer;
begin
  Result := FListaEmails.Count;
end;

procedure TThreadSincronizaEmails.pAdicionaEmailLista(AEmail: TEmailsSinc);
begin
  FListaEmails.Add(AEmail);
end;

constructor TListaThreadsSincronizaEmails.Create;
begin
  inherited;
  FListaThreads := TObjectList<TThreadSincronizaEmails>.Create;
end;

class function TListaThreadsSincronizaEmails.GetInstance
  : TListaThreadsSincronizaEmails;
begin
  If FInstance = nil Then
  begin
    FInstance := untTEnvioEmail.
      TListaThreadsSincronizaEmails.Create();
  end;
  Result := FInstance;
end;

procedure TListaThreadsSincronizaEmails.pAdicionar(
  AThreadSincronizaEmails: TThreadSincronizaEmails);
begin
  FListaThreads.Add(AThreadSincronizaEmails);
end;

procedure TListaThreadsSincronizaEmails.pRemoveSincronizacoesConcluidas;
var
  thrSincEmails: TThreadSincronizaEmails;
begin
  for thrSincEmails in FListaThreads Do
  begin
    if thrSincEmails.Terminou then
    Begin
      if (Not thrSincEmails.ErroNoEnvio) then
        FListaThreads.Remove(thrSincEmails)
      Else
        thrSincEmails.Execute;
    End;
  end;
end;

function TListaThreadsSincronizaEmails.fConcluiuSincronizacao;
begin
  Result :=  FListaThreads.Count = 0;
end;

function TListaThreadsSincronizaEmails.fGetQuantidadeThreads: integer;
begin
  Result := FListaThreads.Count;
end;

end.
