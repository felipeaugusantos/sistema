unit untTEnvioEmail;

interface

uses Classes, SysUtils, StrUtils, Generics.Collections, Data.DB, System.Generics.Defaults,
  untFuncoesSimples, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdAntiFreezeBase,
  Vcl.IdAntiFreeze, IdMessage, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdSMTPBase, IdSMTP,
  IdExplicitTLSClientServerBase, IdMessageClient, IdAttachmentFile, Vcl.Forms, IdEmailAddress, IdGlobal, IdReplySMTP,
  Vcl.StdCtrls, Vcl.Controls, untTypesSistema, IdMessageBuilder, IdText, IdIMAP4, IdAttachment,
  IdReplyIMAP4, System.Zip, Vcl.ExtCtrls, UniClientDataSet, Uni, EditFocus, Types,
  Vcl.Graphics, CRAccess, untDisparaEmailAut, JPeg,untTDupEma, Winapi.Windows, untMsgInterna,
  System.Variants, untThreadUtils, idMessageParts, untTEnvioEmailAutenticacaoOAuth2,
  System.Json, System.NetEncoding;

Const
  spEnviaEmailBoletoExeName  = 'EnviaEmailBoletoMonitor.exe';
  spIdMonitorEmail           = 'MONITOR_EMAIL_%s';
  spIdInactivityMonitorEmail = 'TEST_INACTIVITY_EMAIL_%s';
  spTimeLimitMonitorEmail    = 30;
  spAttemptsLockMonitorEmail = 30;
Var
   FContadorWork: Integer;

type
  TZipFileHelper = class helper for TZipFile
    procedure Delete(FileName: string);
  end;

Type
  TIdSMTPLog = class(TIdSMTP)
  protected
    FEmailError: String;
  Public
    constructor Create(AOwner: TComponent); overload;
  published
    property EmailError : String read FEmailError write FEmailError;
  end;

  TBasicSearchKey = (bskBcc, bskBody, bskCc, bskFrom, bskHeader, bskKeyword, bskSubject, bskText, bskTo);
  TThreadSincronizaEmails = class;

  TDadosFalhaDomainEmails = Record
    endereco: String;
    razaoSocial: String;
    cliente: String;
  End;

  TArrStrEmails = Array of TDadosFalhaDomainEmails;

  TDadosAnexos = Record
    nomeArquivo: String;
    contentID: String;
  End;

  {Parâmetros da EnviaEmail by: 209098 MT}
  TDadosEnvioEmail = Class
    AOwner: TComponent;
    ACodOperador: String;
    APara,
    AComCopia,
    AComCopiaOculta,
    ACorpoMensagem,
    AAnexos: TStringArray;
    AAbrirEditor,
    AImportante: Boolean;
    strAutInc,
    strIncCon: String;
    intCodEma: Int64;
    blnEmailAut: Boolean;
    strSenha : String;
    strEmail : String;
    strLogin: String;
    strRemete: String;
    intProvedor: Integer;
    intPorSmt: Integer;
    intPorIma: Integer;
    strSerSmt: String;
    strSerIma: String;
    intLimArq: Integer;
    blnImgAss: Boolean;
    strTxtAss: String;
    mmsImaAss: TMemoryStream;
    strNomOpe,
    strImgCorpo: String;
    var AAssunto: String;
    blnSSLSai: Boolean;
    blnSSLEnt: Boolean;
    strGravaPastaEnviados: String;
    AExibirMensagemConfirmacaoEnvio: Boolean;
    AThreadSincronizaEmail: TThreadSincronizaEmails;
    blnImpressaoBoleto: Boolean ;
    blnEnvAutCob: Boolean;
    strCodCli : String;
    strCodFor : String;
    blnVizualizar: Boolean;
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

    function RetornaQuantidadeDestinaratios: Integer;

    class procedure OnWorkSMTPBegin(Sender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    class procedure OnWorkSMTP(Sender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    class procedure OnWorkSMTPEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure pCarregarImagem(var objImagem: TMemoryStream; strImgB64: String);
    procedure pPreencheAtributosEmpresa(strCodOpe: String);
    function fRetSQLEmailEmpresa: String;
    procedure pCarregaDadosEmail(var qryDados: TUniQuery; strCodOpe: String);
    procedure pPreencheDadosPessoais(const qryDados: TUniQuery);
    procedure pPreencheDadosProvedor(const qryDados: TUniQuery);
    procedure pPreencheDadosAssinatura(const qryDados: TUniQuery);

    class function AutenticarServidorSMTP(ADadosAutenticacao: TAutenticacaoEmail;
                                          var AIdSMTP: TIdSMTPLog;
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

    class function ValidarAutenticacaoSmtpTelaEnvioEmail(AOwner: TComponent; ADadosAutenticacao: TAutenticacaoEmail; out blnConexaoProvedor: Boolean): Boolean;

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
    Property imagemAssinaturaValida: Boolean Read ImagemAssinaturaEhValida Write FImagemAssinaturaValida;
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

    property QuantidadeDestinatarios: Integer Read RetornaQuantidadeDestinaratios;
  End;

  TAnexo = class
  Private
    FArquivo: String;
    FTamanho: Double;
    FDescricao: String;
    FTamanhoComparacao: Double;

    Procedure SetArquivo(const Value: String);
    Procedure SetTamanhoArquivo();
    procedure SetTamanhoComparacao(const Value: Double);
  Public
    Constructor Create(AArquivo: String);

    Property arquivo           : String  Read FArquivo           Write SetArquivo;
    Property tamanho           : Double  Read FTamanho;
    Property descricao         : String  Read FDescricao;
    Property tamanhoComparacao : Double  Read FTamanhoComparacao Write SetTamanhoComparacao;
  End;

  TAnexos = class
  Private
    FLimiteAnexos  : Integer;
    FTotalTamAnexos: Double;
    FArquivosAnexados: TList<TAnexo>;

    Procedure SetLimiteAnexos(const Value: Integer);
  Public
    Constructor Create(ALimiteAnexos: Integer);

    procedure OrdenarPorTamanho;

    Property limiteAnexos     : Integer       Read FLimiteAnexos     Write SetLimiteAnexos;
    Property arquivosAnexados : TList<TAnexo> Read FArquivosAnexados Write FArquivosAnexados;
    Property totalTamAnexos   : Double        Read FTotalTamAnexos;
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
    FblnIgnorarEmailsInvalidos: Boolean;

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
    Property blnIgnorarEmailsInvalidos: Boolean          Read FblnIgnorarEmailsInvalidos Write FblnIgnorarEmailsInvalidos;

  End;

  TEnvioEmail = class(TComponent)

    class procedure IdSMTPFailedRecipient(Sender: TObject; const AAddress, ACode,
      AText: string; var VContinue: Boolean);

  Private
    class var FBlnHabilitaDivisaoAnexoPorEmail: Boolean;
    class var FErroTooManyRecipients: Boolean;
  Private
    FIdSMTP           : TIdSMTPLog;
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
    FCodFor           : String;
    FCodOpe           : String;
    FNomeArquivoZip   : String;
    FDiretorioEmail   : String;
    blnEmailAut       : Boolean;
    FEnvAutCob        : Boolean;
    FAutInc: String;
    FCodEma: Int64;
    FIncCon: String;
    FDuplicatasEnvio  : TArrDupTabelaEmail;

    FUsarAntiFreeze: Boolean;
    FGravarAnexosPath : Boolean;

    FContadorWork: Int64;
    FblnLimparDados: Boolean;

    FNotFic: String;

    Procedure InicializarComponentes();
    Function  ValidarMensagem(): Boolean;
    Function  ValidarDllsSSL(): Boolean;
    Procedure LimparMensagem();

    procedure SetblnLimparDados(const Value: Boolean);

    function GetDestinatario(AMsgErro: String = ''): String;

    Class procedure pMensagemErroEnviaEmail(strMsgErro: string; strEmail: String = '');

    procedure OnWorkSMTPBegin(Sender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure OnWorkSMTP(Sender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure OnWorkSMTPEnd(Sender: TObject; AWorkMode: TWorkMode);

    procedure EnviarMensagemErroAosOperadores(AAutenticado: Boolean;
                                              ACodigoGrupoModelo,
                                              ACodigoModelo,
                                              AErroGerado: String);

    function RetornaMensagemOperadores(AEmailFixo: Boolean;
                                       AGrupoModelo,
                                       ANomeModelo,
                                       AErroGerado: String): String;

    function EmitirMensagemErroThreadTratada(AAutenticado: Boolean;
                                             ACodigoGrupoModelo,
                                             ACodigoModelo,
                                             AErroGerado: String): Boolean;

    function MensagemErroEmailTratada(AErroGerado: String): String;

    procedure EnviarEmailOAuth2(AJsonEmail: TJsonObject);

    class function RetornaDadosMensagemAtualOutlook(ADadosAutorizacao: TAutenticacaoEmail;
                                                    ANomeArquivoZip,
                                                    APara: String;
                                                    out APastaEnviadosEncontrada,
                                                        AEmailConfirmado: Boolean): TidMessage;
  Public
    Constructor Create(AOwner: TComponent; blnEmailAut: Boolean; strNomOpe: String; intLimArq: Integer); Reintroduce;
    Destructor  Destroy; Override;

    class var FCodigoGrupoModelo: String;
    class var FCodigoModelo: String;

    Procedure EnviarMensagem();
    Procedure DefinirDadosAutenticacao(ALimiteArq, AProvedor, APortaSmtp, APortaImap: Integer;
     ASenha, AUsuario, ALogin, ARemete, AServidorSmtp, AServidorImap, ACodOpe: String; ASSLEnt, ASSLSai: Boolean; AGravaPastaEnviados: String); overload;

    Procedure DefinirDadosAutenticacao(AProvedor: Integer;
                                       ALogin,
                                       AUsuario,
                                       ASenha,
                                       ARemete,
                                       ACodOpe: String); overload;

    function GetCaminhoImagemAssinaturaEmail: String;
    procedure CriarArquivoImagemAssinaturaEmail;
    procedure ApagarImagemAssinaturaEmail;

    function RetornaDadosCliente: String;

    function RetornaDadosAdicionaisErroMensagem(AMensagem: TidMessage; AMensagemCompleta: TMensagem): String;

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
      blnSSLSai: Boolean = False; blnSSLEnt: Boolean = False; strGravaPastaEnviados: String = 'S'; ADuplicatasEnvio: TArrDupTabelaEmail = Nil;
      ACodigoGrupoModelo: String = ''; ACodigoModelo: String = ''; ACodCli: String = ''; AProved: String = ''): Boolean; overload;

    Class Function EnviarEmail(AOwner: TComponent; ACodOperador: String;
      APara, AComCopia, AComCopiaOculta, ACorpoMensagem, AAnexos: TStringArray;
      AAbrirEditor: Boolean; AImportante: Boolean; strAutInc, strIncCon: String; intCodEma: Int64; blnEmailAut: Boolean;
      strSenha : String; strEmail : String; strLogin: String; strRemete: String; intProvedor: Integer; intPorSmt: Integer; intPorIma: Integer; strSerSmt: String; strSerIma: String;
      intLimArq: Integer; blnImgAss: Boolean; strTxtAss: String; mmsImaAss: TMemoryStream; strNomOpe, strImgCorpo: String;  Var AAssunto: String;
      blnSSLSai: Boolean; blnSSLEnt: Boolean; strGravaPastaEnviados: String; AExibirMensagemConfirmacaoEnvio: Boolean = True;
      AThreadSincronizaEmail: TThreadSincronizaEmails = nil; blnImpressaoBoleto: Boolean = False; blnEnvAutCob: Boolean = False; strCodCli : String = ''; strCodFor : String = '';
      AAdicionaUmParagrafoPorLinha: Boolean = True; blnExibeStatus: Boolean = True; ADuplicatasEnvio: TArrDupTabelaEmail = Nil;
      blnGravarAnexos: Boolean = False; blnIgnorarEmailsInvalidos: Boolean = False; ACodOco: String = ''; ANotFic: String = ''): Boolean; Overload;

    Class Function EnviarEmail(ADadosEnvioEmail: TDadosEnvioEmail): Boolean; Overload;

    Class Function BuscarZipMensagemServidor(AOwner: TComponent; ANomeArquivoZip: String; AOperador: String = ''): TIdMessage;

    Class Function CriarAnexosZipMensagem(ANomeArquivoZip: String; AMensagem: TIdMessage): TArrayDadosAnexos;

    Class Function BuscarMensagemProvedor(AOwner: TComponent; ADe, APara, AAssunto, ANomeArquivoZip: String;
                                      out AContaDiferente: Boolean; out AContaOperador: String; AAutenticacaoEmail: TAutenticacaoEmail = Nil): TIdMessage;

    Class Procedure GravarZipMensagem(AIdMessage: TIdMessage; ADiretorioEmail, ANomeArquivoZip: String);

    Class Function ContruirArrayMensagem(ATexto: String): TStringArray;

    Property mensagem         : TMensagem          Read FMensagem          Write FMensagem;
    Property enviado          : Boolean            Read FEnviado           Write FEnviado;
    Property dadosAutenticacao: TAutenticacaoEmail Read FDadosAutenticacao;
    Property importante       : Boolean            Read FImportante        Write FImportante;
    Property horaEnvio        : TDateTime          Read FHoraEnvio         Write FHoraEnvio;
    Property strCodCli        : String             Read FCodCli            Write FCodCli;
    Property strCodFor        : String             Read FCodFor            Write FCodFor;
    Property strCodOpe        : String             Read FCodOpe            Write FCodOpe;
   // Property envioAut         : Boolean            Read FEnvioAut          Write FEnvioAut;
    Property strAutInc        : String             Read FAutInc            Write FAutInc;
    Property strIncCon        : String             Read FIncCon            Write FIncCon;
    Property intCodEma        : Int64              Read FCodEma            Write FCodEma;
    Property ThreadSincEmail  : TThreadSincronizaEmails Read  FThreadSincEmail Write FThreadSincEmail;
    Property EnvAutCob        : Boolean            Read FEnvAutCob         Write FEnvAutCob;
    property UsarAntiFreeze   : Boolean            Read FUsarAntiFreeze    Write FUsarAntiFreeze;
    property DuplicatasEnvio  : TArrDupTabelaEmail Read FDuplicatasEnvio   Write FDuplicatasEnvio;
    property blnGravarAnexosPath : Boolean            Read FGravarAnexosPath  Write FGravarAnexosPath;
    property blnLimparDados   : Boolean                                     Write SetblnLimparDados;
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

    class function fEmailExistente(AEmail: String; Out ASeqCon: String): Boolean;
  public
    Constructor Create(AOwner: TComponent; ACodOpe: String; ATipoOperacao: TTipoOperacaoConsulta); Reintroduce;
    Destructor  Destroy; Override;

    procedure pFiltrarContatos(AFiltro: String; Var AEditFiltro, AEditTexto: TEditFocus);
    procedure pExibirListagem(AExibir: Boolean; AParent: TComponent = nil);
    procedure pSelecionarContato(AItemIndex: Integer);
    function pSelecionarFiltroString(ATextoEditFiltro: String): String;
    procedure pAtualizarListaContatos;

    class procedure pGravarContato(AEmail, strIncCon: String); Overload;
    class procedure pGravarContato(AContato: TContatoOperador); Overload;

    property lsbContatos: TListBox       Read FListagem;
    property arrContatos: TContatosEmail Read FContatos Write FContatos;
    property pnlListagem: TPanel         Read FPnlLista;
  end;

  TEmailsSinc = class
  strict private
    FDadosAutenticacao           : TAutenticacaoEmail;
    FDiretorioEmail              : String;
    FIdSMTP                      : TIdSMTPLog;
    FIdMessage                   : TIdMessage;
    FPara                        : TStringArray;
    FNomeArquivoZip              : String;
    FSSLSocket                   : TIdSSLIOHandlerSocketOpenSSL;
    FHoraEnvio                   : TDateTime;
    FCaminhoImagemAssinaturaEmail: String;
  public
    procedure CriarImagemAssinatura;
    procedure ApagarImagemAssinatura;

    property DadosAutenticacao: TAutenticacaoEmail   Read FDadosAutenticacao            Write FDadosAutenticacao;
    property DiretorioEmail: String                  Read FDiretorioEmail               Write FDiretorioEmail;
    property IdSMTP: TIdSMTPLog                      Read FIdSMTP                       Write FIdSMTP;
    property IdMessage: TIdMessage                   Read FIdMessage                    Write FIdMessage;
    property NomeArquivoZip: String                  Read FNomeArquivoZip               Write FNomeArquivoZip;
    property SSLSocket: TIdSSLIOHandlerSocketOpenSSL Read FSSLSocket                    Write FSSLSocket;
    property Para: TStringArray                      Read FPara                         Write FPara;
    property HoraEnvio: TDateTime                    Read FHoraEnvio                    Write FHoraEnvio;
    property CaminhoImagemAssinaturaEmail: String    Read FCaminhoImagemAssinaturaEmail Write FCaminhoImagemAssinaturaEmail;
  end;

  TThreadSincronizaEmails = class(TSafeThread)
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
  private
    FListaThreads: TObjectList<TThreadSincronizaEmails>;

    function fGetQuantidadeThreads: integer;

    class var FInstance: TListaThreadsSincronizaEmails;
    constructor Create;
  public
    destructor Destroy; override;

    class function GetInstance: TListaThreadsSincronizaEmails;

    procedure pAdicionar(AThreadSincronizaEmails: TThreadSincronizaEmails);

    function fConcluiuSincronizacao: Boolean;

    procedure pRemoveSincronizacoesConcluidas;

    property QuantidadeThreads: integer read fGetQuantidadeThreads;
  End;

  Const
    IMAPSearchKeys: array [TBasicSearchKey] of string = ('BCC', 'BODY', 'CC',
      'FROM', 'HEADER', 'KEYWORD', 'SUBJECT', 'TEXT', 'TO');

  Function CriptografarMensagemEmail(const S: WideString; Key: Word; CKey1, CKey2: Integer): String;
  Function DescriptografarMensagemEmail(const S: String; Key: Word; CKey1, CKey2: Integer): String;
  Function CriptografarSenhaEmail(strSenha: String): String;
  Function ValidarDiretorioEmail(out diretorio: String; AOperador: String = ''): Boolean;
  Function CompactarArquivos(diretorio, nomeArquivoZip: String;
    nomeArquivosComprimir: TStringArray; out strNomesArquivosCompactados: String;
    out strMensagemExcecao: String; deletarArquivo: Boolean = True;
    intTamanhoMaximoMB: Integer = 0): Boolean; overload;
  Function CompactarArquivos(diretorio, nomeArquivoZip: String;
    nomeArquivosComprimir: TStringArray; deletarArquivo: Boolean = True): Boolean; overload;
  Function DescompactarArquivos(diretorio, nomeArquivoZip: String; deletarArquivoZip: Boolean = False): Boolean;
  Procedure InicializarComponentesIndy(AOwner: TComponent; Var AIdSMTP: TIdSMTPLog; Var AIdMessage: TIdMessage;
    Var ASSLSocket: TIdSSLIOHandlerSocketOpenSSL; ADadosAutenticacao: TAutenticacaoEmail);
  Function fRetVersaoTLSSSL: TIdSSLVersion;
  Function fRetModeSSL: TIdSSLMode;

implementation

uses untGravando, untEnvioEmail, untConstantes, untTCadastroProvedores,
  untModulo, untListaEmail, System.IOUtils, untVersaoProg, untImagemBase64,
  untTEnvioEmailOutlookOAuth2, untDadosEnviaGatilhoEmail, untFuncoesGenerica,
  untDllGatIme;

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
  var AIdSMTP: TIdSMTPLog; var AConexaoProvedor: Boolean;
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
    FNomeOpe := IIF(fCfgSis('SAUEMA', varBoolean), strNomOpe, EmptyStr)
  Else
  Begin
    If (fCfgSis('EMLEMP', varBoolean)) Then
      pPreencheAtributosEmpresa(strCodUsuario)
    Else
      InicializarAtributos(strCodUsuario);
  End;
end;

procedure TAutenticacaoEmail.pPreencheAtributosEmpresa(strCodOpe: String);
  Var
    qryDados: TUniQuery;
begin
  qryDados := fCriaQuery;

  Try
    pCarregaDadosEmail(qryDados, strCodOpe);

    If (qryDados.IsEmpty) Then
      Exit;

    pPreencheDadosPessoais(qryDados);
    pPreencheDadosProvedor(qryDados);
    pPreencheDadosAssinatura(qryDados);
  Finally
    FreeAndNil(qryDados);
  End;
end;

procedure TAutenticacaoEmail.pCarregaDadosEmail(Var qryDados: TUniQuery; strCodOpe: String);
begin
  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Text := fRetSQLEmailEmpresa;
  qryDados.ParamByName('CODOPE').AsString := strCodOpe;
  qryDados.ParamByName('CODEMP').AsString := Vs_strCodEmp;
  qryDados.Open;
end;

function TAutenticacaoEmail.fRetSQLEmailEmpresa: String;
begin
  Result := ' SELECT * FROM OPEEML       '+
            ' INNER JOIN CADPRV ON       '+
            '   PRV_CODPRV = EML_CODPRV  '+
            ' INNER JOIN CADOPE ON       '+
            '   OPE_CODOPE = EML_CODOPE  '+
            ' WHERE EML_CODOPE = :CODOPE '+
            '   AND EML_CODEMP = :CODEMP ';
end;

procedure TAutenticacaoEmail.pPreencheDadosPessoais(Const qryDados: TUniQuery);
begin
  FNomeOpe := qryDados.FieldByName('OPE_NOMOPE').AsString;
  FRemetente := qryDados.FieldByName('EML_E_NOME').AsString;

  SetSenha(CriptografarSenhaEmail(qryDados.FieldByName('EML_PRVSEN').AsString));
  SetUsuario(qryDados.FieldByName('EML_E_MAIL').AsString);
  SetLogin(qryDados.FieldByName('EML_EMALOG').AsString);
  SetCodOpe(qryDados.FieldByName('OPE_CODOPE').AsString);

  FEmailIdAzure := qryDados.FieldByName('OPE_EMA_ID').AsString;
end;

procedure TAutenticacaoEmail.pPreencheDadosProvedor(Const qryDados: TUniQuery);
begin
  CarregaDadosDoProvedor(qryDados.FieldByName('PRV_CODPRV').AsInteger);
end;

procedure TAutenticacaoEmail.pPreencheDadosAssinatura(Const qryDados: TUniQuery);
begin
  FImagemAssinaturaValida := (Not fEmptyStr(qryDados.FieldByName('EML_IMGB64').AsString));
  FTextoAssinatura.Text := AnsiReplaceStr(qryDados.FieldByName('EML_TEXTO_').AsString, STRING_QUEBRA, STRING_ENTER);

  If (FImagemAssinaturaValida) Then
    pCarregarImagem(FImagemAssinatura, qryDados.FieldByName('EML_IMGB64').AsString)
  Else
    FImagemAssinatura := Nil;
end;

procedure TAutenticacaoEmail.pCarregarImagem(Var objImagem: TMemoryStream; strImgB64: String);
  Var
    objImgStr: TBytesStream;
begin
  If (Not strImgB64.isEmpty) Then
  Begin
    objImgStr := TBytesStream.Create(nil);
    fStreamFromBase64(strImgB64, objImgStr);

    Try
      If (objImgStr.Size > 0) Then
      Begin
        objImgStr.SaveToStream(objImagem);
        objImagem.Position := 0;
      End;
    Finally
      objImgStr.Free;
    End;
  End;
end;

function TAutenticacaoEmail.EhValido: Boolean;
begin
  Result := (FPortaSmtp > 0)          And  //valida o número da porta do servidor de e-Mail
            ((not fEmptyStr(FSenha)) Or FUsaAuthenticacaoOAuth2) And  //valida a senha do usuário do servidor de e-Mail
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

  If (Not fEmptyStr(ADadosAutenticacao.servidorImap)) And (ADadosAutenticacao.portaImap > 0) Then
  Begin
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
    FIdSMTP   : TIdSMTPLog;
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

class function TAutenticacaoEmail.ValidarAutenticacaoSmtpTelaEnvioEmail(AOwner: TComponent; ADadosAutenticacao:
  TAutenticacaoEmail; out blnConexaoProvedor: Boolean): Boolean;
  Var
    FIdSMTP   : TIdSMTPLog;
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

        FIdSMTP.OnWorkBegin := OnWorkSMTPBegin;
        FIdSMTP.OnWork      := OnWorkSMTP;
        FIdSMTP.OnWorkEnd   := OnWorkSMTPEnd;

        Result := AutenticarServidorSMTP(ADadosAutenticacao, FIdSMTP, blnConexaoProvedor);
        FIdSMTP.Disconnect();

        If Not blnConexaoProvedor Then
        Begin
          fMensagem('AVISO!', 'Não foi possível conectar com o provedor de e-Mail.' + #13#10 +
                              'Verifique os dados informados e tente novamente!', ['&Ok']);
          Exit;
        End;

      Except
        On E: Exception Do
        Begin
          if LintTentativasConexaoEmail >= 3 then
          begin
            If (Pos('username and password not accepted', LowerCase(E.Message)) <= 0) And
              (Pos('authentication failed', LowerCase(E.Message)) <= 0) And
              (Pos('incorrect username or password', LowerCase(E.Message)) <= 0) Then
              fMensagem('ALERTA!', 'Houve um erro ao validar os dados da conta de e-Mail.' +
                                 #13#10 + 'Verifique os dados informados e tente novamente!', ['&Ok']);
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

class function TAutenticacaoEmail.fValidarAutenticacaoSmtp(AOwner: TComponent; ADadosAutenticacao:
  TAutenticacaoEmail; out blnConexaoProvedor: Boolean; AAtualizarIDAzure: Boolean = False): Boolean;
  Var
    FIdSMTP   : TIdSMTPLog;
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
        On E: Exception Do
        Begin
          if LintTentativasConexaoEmail >= 3 then
          begin
            If (Pos('username and password not accepted', LowerCase(E.Message)) > 0) And
               (Pos('.gmail.com', ADadosAutenticacao.FServidorSmtp.ToLower) > 0) Then
            Begin
              fMensagem('ALERTA!', 'Houve um erro ao validar os dados da conta de e-mail. Os dados de autenticação (login e senha) não foram aceitos.' + #13 +
                                   'Verifique se sua conta do Gmail está com a "Verificação em duas etapas" ativada e se ' +
                                   'foi criada a senha para app!' + #13 +
                                   'Erro gerado: ' + E.Message, ['&Ok']);
              Exit;
            End;

            If (Pos('username and password not accepted', LowerCase(E.Message)) <= 0) And
              (Pos('authentication failed', LowerCase(E.Message)) <= 0) And
              (Pos('incorrect username or password', LowerCase(E.Message)) <= 0) Then
              fMensagem('ALERTA!', 'Houve um erro ao validar os dados da conta de e-Mail.' +
                                   #13#10 + 'Verifique os dados informados e tente novamente!'+ #13 +
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

class procedure TAutenticacaoEmail.OnWorkSMTP(Sender: TObject;
  AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  Inc(FContadorWork);

  If (FContadorWork = 0) Or (FContadorWork >= 50) Then
  Begin
     Application.ProcessMessages;
     FContadorWork := 0;
  End;
end;

class procedure TAutenticacaoEmail.OnWorkSMTPBegin(Sender: TObject;
  AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  FContadorWork := -1;
end;

class procedure TAutenticacaoEmail.OnWorkSMTPEnd(Sender: TObject;
  AWorkMode: TWorkMode);
begin
  Application.ProcessMessages;
end;

function TAutenticacaoEmail.RetornaQuantidadeDestinaratios: Integer;
begin
  Result := 0;

  Try
    If FProvedor > 0 Then
      Result := fCampoTabela('PRV_LIMDES', 'CADPRV', ['PRV_CODPRV'], [FProvedor]);
  Except

  End;
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

procedure TAutenticacaoEmail.SetProvedor(const Value: Integer);
begin
  FProvedor := Value;
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

{ TAnexo }

constructor TAnexo.Create(AArquivo: String);
begin
  FDescricao := '';
  SetArquivo(AArquivo);
end;

procedure TAnexo.SetArquivo(const Value: String);
begin
  If fEmptyStr(Value) Then
    fMensagem('Alerta', 'Caminho do anexo deve ser informado.', ['&Ok'])
  Else If not fArquivoExisteNoDiretorio(Value, 40, 2000) Then
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

procedure TAnexo.SetTamanhoComparacao(const Value: Double);
begin
  FTamanhoComparacao := Value;
end;

{ TAnexos }

constructor TAnexos.Create(ALimiteAnexos: Integer);
begin
  FArquivosAnexados := TList<TAnexo>.Create();
  SetLimiteAnexos(ALimiteAnexos);
  FTotalTamAnexos := 0;
end;

procedure TAnexos.OrdenarPorTamanho;
var
  comparison: TComparison<TAnexo>;
  delegateComparer: TDelegatedComparer<TAnexo>;
begin
  comparison := function (const A1, A2: TAnexo): Integer
    var
      Valor1 : Integer;
      Valor2 : Integer;
    begin
      Valor1 := Trunc(A1.tamanhoComparacao * 100);
      Valor2 := Trunc(A2.tamanhoComparacao * 100);

      If Valor1 > Valor2 Then
        Result := 1
      else
      If Valor1 < Valor2 Then
        Result := -1
      Else
        Result := 0;
    end;

  delegateComparer := TDelegatedComparer<TAnexo>.Create(comparison);
  try
    FArquivosAnexados.Sort(delegateComparer);
  finally
    delegateComparer.Free;
  end;
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
    fMensagem('Alerta', 'Destinatário (Com Cópia) é inválido.' + #13 +
                        'E-mail: ' + Value, ['&Ok'])
  Else If (Not fEnderecoEmailValido(Value)) Then
    fMensagem('Alerta', 'Destinatário (Com Cópia) é inválido.' + #13 +
                        'E-mail: ' + Value, ['&Ok'])
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
  Begin
    If Not FblnIgnorarEmailsInvalidos Then
      fMensagem('Alerta', 'Destinatário (Com Cópia Oculta) é inválido.' + #13 +
                          'E-mail: ' + Value, ['&Ok'])
  End
  Else If (Not fEnderecoEmailValido(Value)) Then
  Begin
    If Not FblnIgnorarEmailsInvalidos Then
      fMensagem('Alerta', 'Destinatário (Com Cópia Oculta) é inválido.'+ #13 +
                          'E-mail: ' + Value, ['&Ok'])
  End
  Else
  Begin
    If (FComCopiaOculta.IndexOf(Value) = -1) Then
      FComCopiaOculta.Add(Value);

    Result := True;
  End;

  IF FblnIgnorarEmailsInvalidos Then
    Result := True;
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
    fMensagem('Alerta', 'Destinatário (Para) é inválido.' + #13 +
                        'E-mail: ' + Value, ['&Ok'])
  Else If (Not fEnderecoEmailValido(Value)) Then
    fMensagem('Alerta', 'Destinatário (Para) é inválido.' + #13 +
                        'E-mail: ' + Value, ['&Ok'])
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
            (IIF(fCfgSis('SAUEMA', varBoolean), not fEmptyStr(FNomeSaudacao), fEmptyStr(FNomeSaudacao)))       And  //valida a saudacao da mensagem
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
  Begin
    FAssunto := Value;
    if FAssunto.EndsWith('- ') then
      FAssunto := Copy(FAssunto, 1, Length(FAssunto)-2);
  End;
end;

procedure TMensagem.SetNomeSaudacao(const Value: String);
begin
  If (fEmptyStr(Value)) and (fCfgSis('SAUEMA', varBoolean)) Then
    fMensagem('Alerta', 'Nome de Saudação da mensagem deve ser informado.', ['&Ok'])
  Else
    FNomeSaudacao := Value;
end;

{ TEnvioEmail }

procedure TEnvioEmail.ApagarImagemAssinaturaEmail;
begin
  if FileExists(Self.GetCaminhoImagemAssinaturaEmail) then
    SysUtils.DeleteFile(Self.GetCaminhoImagemAssinaturaEmail);
end;

class function TEnvioEmail.BuscarMensagemProvedor(AOwner: TComponent; ADe, APara, AAssunto, ANomeArquivoZip: String;
                                              out AContaDiferente: Boolean; out AContaOperador: String; AAutenticacaoEmail: TAutenticacaoEmail = Nil): TIdMessage;
  Var
    i, j: Integer;
    IdIMAP: TIdIMAP4;
    pastas: TStringList;
    confirmado, encontrada: Boolean;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    SearchInfo: TIdIMAP4SearchRecArray;
    dadosAutenticacao: TAutenticacaoEmail;
Begin

  dadosAutenticacao := AAutenticacaoEmail;

  If Not Assigned(dadosAutenticacao) Then
    dadosAutenticacao := TAutenticacaoEmail.Create(strLoginUsuarioLogado, '', False);

  Result := nil;

  If (Not fEmptyStr(dadosAutenticacao.servidorImap)) And (dadosAutenticacao.portaImap > 0) Then
  Begin
    AContaDiferente := (UpperCase(ADe) <> UpperCase(dadosAutenticacao.usuario));
    AContaOperador  := dadosAutenticacao.usuario;

    If (Not AContaDiferente) Then 
    Begin
      Result := TIdMessage.Create(AOwner);
      IdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create();

      Try
        IdSSLIOHandlerSocketOpenSSL.Destination := dadosAutenticacao.servidorImap + ':' + IntToStr(dadosAutenticacao.portaImap);
        IdSSLIOHandlerSocketOpenSSL.Host := dadosAutenticacao.servidorImap;
        IdSSLIOHandlerSocketOpenSSL.Port := dadosAutenticacao.portaImap;
        IdSSLIOHandlerSocketOpenSSL.DefaultPort := 0;
        IdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := fRetVersaoTLSSSL();
        IdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLversions := [fRetVersaoTLSSSL()];
        IdSSLIOHandlerSocketOpenSSL.SSLOptions.Mode := fRetModeSSL;
        IdSSLIOHandlerSocketOpenSSL.SSLOptions.VerifyMode := [];
        IdSSLIOHandlerSocketOpenSSL.SSLOptions.VerifyDepth := 0;

        IdIMAP := TIdIMAP4.Create();
        pastas := TStringList.Create();
        Try
          IdIMAP.IOHandler := IdSSLIOHandlerSocketOpenSSL;
          IdIMAP.Host      := dadosAutenticacao.servidorImap;
          IdIMAP.Password  := dadosAutenticacao.senha;
          IdIMAP.Port      := dadosAutenticacao.portaImap;

          If (Not dadosAutenticacao.blnSSLEnt) Then
            IdIMAP.UseTLS  := utUseExplicitTLS
          Else
            IdIMAP.UseTLS  := utUseImplicitTLS;

          IdIMAP.Username  := dadosAutenticacao.login;

          If TAutenticacaoEmail.ConnectIdIMAP(IdIMAP,dadosAutenticacao.usuario, dadosAutenticacao) Then
          Begin
            Try
              If dadosAutenticacao.UsaAuthenticacaoOAuth2 Then
                Result := RetornaDadosMensagemAtualOutlook(dadosAutenticacao, ANomeArquivoZip, APara, encontrada, confirmado)

              Else
              Begin

                confirmado := IdIMAP.ListMailBoxes(pastas);

                If (confirmado) then
                Begin
                  confirmado := False;
                  encontrada := False;

                  For i := 0 to pastas.Count - 1 Do 
                  Begin
                    If (Pos('ENVIAD', UpperCase(pastas[i])) > 0) or (Pos('SENT', UpperCase(pastas[i])) > 0) Then 
                    Begin
                      encontrada := True;

                      If (IdIMAP.SelectMailbox(pastas[i])) Then 
                      Begin
                        SetLength(SearchInfo, 2);

                        SearchInfo[0].SearchKey := skSince;
                        SearchInfo[0].Date      := EncodeDate(StrToInt(Copy(ANomeArquivoZip, 19, 4)),
                          StrToInt(Copy(ANomeArquivoZip, 23, 2)), StrToInt(Copy(ANomeArquivoZip, 25, 2)));

                        SearchInfo[1].SearchKey := skTo;
                        SearchInfo[1].Text      := String(UTF8Encode(APara));

                        If (IdIMAP.SearchMailBox(SearchInfo)) Then 
                        Begin
                          For j := 0 To Length(IdIMAP.MailBox.SearchResult) - 1 Do 
                          Begin
                            If (IdIMAP.Retrieve(IdIMAP.MailBox.SearchResult[j], Result)) Then 
                            Begin
                              If (Pos(ANomeArquivoZip, Result.MsgId) > 0) Then 
                              Begin
                                confirmado := True;
                                Break;
                              End;
                            End;
                          End;
                        End;
                      End;
                    End;

                    If (confirmado) Then
                      Break;
                  End;
                End;
              End;

              If (Not encontrada) Then
                untFuncoesSimples.fMensagem('Alerta', 'Não foi encontrada a pasta de mensagens ''Enviadas'' em sua conta de e-mail.' + #13#10 + 
                                                      'Verifique nas configurações do provedor para que futuramente este problema não ocorra.', ['&Ok']);

              If (Not confirmado) Then
                Result := nil;
            Except
              On E: Exception Do
                pMensagensErro(E.Message, '[TEnvioEmail.BuscarMensagemProvedor]');
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
End;

class function TEnvioEmail.BuscarZipMensagemServidor(AOwner: TComponent; ANomeArquivoZip: String; AOperador: String = ''): TIdMessage;
  Var
    arquivo: TStringList;
    diretorioEmail: String;

    LOperador: String;
begin
  Result := TIdMessage.Create(AOwner);

  LOperador := strLoginUsuarioLogado;
  If Not AOperador.IsEmpty Then
    LOperador := AOperador;

  If (Not fEmptyStr(ANomeArquivoZip))
    And (ValidarDiretorioEmail(diretorioEmail, LOperador)) Then
  Begin

    If (FileExists(diretorioEmail + ANomeArquivoZip + '.zip')) Then
    Begin
      DescompactarArquivos(diretorioEmail, ANomeArquivoZip + '.zip');
      arquivo := TStringList.Create();

      Try

        If Not FileExists(diretorioEmail + ANomeArquivoZip + '\' + ANomeArquivoZip + '.mcc') Then
        Begin
          DeleteFile(PWideChar(diretorioEmail + ANomeArquivoZip + '.zip'));
          Exit(Nil);
        End;

        arquivo.LoadFromFile(diretorioEmail + ANomeArquivoZip + '\' + ANomeArquivoZip + '.mcc');
        SysUtils.DeleteFile(diretorioEmail + ANomeArquivoZip + '\' + ANomeArquivoZip + '.mcc');
        arquivo.Text := DescriptografarMensagemEmail(arquivo.Text,
                                                     Word.parse(Copy(ANomeArquivoZip, 34, 3)),
                                                     StrToInt(Copy(ANomeArquivoZip, 19, 5)),
                                                     StrToInt(Copy(ANomeArquivoZip, 28, 5)));
        arquivo.SaveToFile(diretorioEmail + ANomeArquivoZip + '\' + ANomeArquivoZip + '.mcc');
        Result.LoadFromFile(diretorioEmail + ANomeArquivoZip + '\' + ANomeArquivoZip + '.mcc');
        SysUtils.DeleteFile(diretorioEmail + ANomeArquivoZip + '\' + ANomeArquivoZip + '.mcc');
        RemoveDir(diretorioEmail + ANomeArquivoZip + '\');
      Finally
        FreeAndNil(arquivo);
      End;
    End Else Begin
      Result := nil;
    End;
  End;
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
  Begin
    If (FDadosAutenticacao.FLimiteArq > 0) Then FMensagem := TMensagem.Create(FDadosAutenticacao.FLimiteArq)
    Else FMensagem := TMensagem.Create(intLimArq);
  End;

  If Not fEmptyStr(FDadosAutenticacao.FRemetente) Then
    FMensagem.SetNomeSaudacao(FDadosAutenticacao.FRemetente)
  Else
    FMensagem.SetNomeSaudacao(FDadosAutenticacao.FNomeOpe);

  FMensagem.FCorpoHtml := False;
  FEnviado     := False;
  FImportante  := False;
  FAnexosCount := 0;
  FHoraEnvio   := 0;
  FblnLimparDados := True;

  FMensagem.blnGravarAnexosPath := FGravarAnexosPath;

  Self.blnEmailAut := blnEmailAut;

  If (Not blnEmailAut) Then
    InicializarComponentes();

  FUsarAntiFreeze := False;
  FContadorWork   := 0;
end;

class procedure TEnvioEmail.pMensagemErroEnviaEmail(strMsgErro: string; strEmail: String = '');
var
  intQtdeChar: Integer;
begin
  if (Pos('Authentication failed', strMsgErro) > 0) Or
     (Pos('authentication failed', strMsgErro) > 0) Or
     (Pos('authentication data'  , strMsgErro) > 0) Or
     (Pos('Username and Password not accepted', strMsgErro) > 0) then
  begin
    untFuncoesSimples.fMensagem('AVISO!', 'Falha na autenticação com o provedor. Favor rever configurações para este operador!', ['&OK']);
  end
  else if (Pos('connection timed out', LowerCase(strMsgErro)) > 0) then
  begin
    untFuncoesSimples.fMensagem('AVISO!', 'Confira se o computador está conectado a internet ou se o anti-vírus está bloqueando a conexão!', ['&OK']);
  end
  else if (Pos('Account IS temporarily unavailable', strMsgErro) > 0) then
  begin
    untFuncoesSimples.fMensagem('AVISO!', 'Provedor fora do ar. Verifique seu provedor de E-mail!', ['&OK']);
  end
  else if (Pos('Domain not found', strMsgErro) > 0) then
  begin
    untFuncoesSimples.fMensagem('AVISO!', 'Falha no envio do e-mail, domínio não encontrado! ' + IIF(fEmptyStr(strEmail),'',strEmail), ['&OK']);
  end
  else if (Pos('Cannot open file', strMsgErro) > 0) then
  begin
    untFuncoesSimples.fMensagem('AVISO!', 'Falha no envio do e-mail, o sistema não pode abrir o arquivo especificado!', ['&OK']);
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
  else if (Pos('recipient address rejected: policy rejection', LowerCase(strMsgErro)) > 0) then
  begin
    untFuncoesSimples.fMensagem('AVISO!', 'o e-mail para quem está tentando enviar está na Black-List, ' + #13 +
                                    'para mais informações acesse: https://ajuda.hostnet.com.br/recipient-is-known-to-bounce/!', ['&OK']);
  end
  else if (Pos('username and password not accepted', LowerCase(strMsgErro)) > 0) and (Pos('support.google.com', LowerCase(strMsgErro)) > 0) then
  begin
    untFuncoesSimples.fMensagem('AVISO!', 'Nome de usuário e SENHA NÃO aceitos, ' + #13 +
                                    'para mais informações acesse: https://support.google.com/mail/?p=BadCredentials p10sm10929886qkg.74 - gsmtp', ['&OK']);
  end
  else if (Pos('the mail server could not deliver mail to', LowerCase(strMsgErro)) > 0) and
          (Pos('the account or domain may not exist, they may be blacklisted, or missing the proper dns entries', LowerCase(strMsgErro)) > 0) then
  begin
    intQtdeChar := Pos('the account or domain may not exist, they may be blacklisted, or missing the proper dns entries', LowerCase(strMsgErro)) - 44;
    untFuncoesSimples.fMensagem('AVISO!', 'O servidor não pôde entregar o e-mail para ' + Copy(strMsgErro, 43, intQtdeChar) +  #13 +
                                'A conta ou domínio pode não existir, eles podem estar na lista negra ou faltando as entradas dns adequadas. ' , ['&OK']);
  end
  else if (Pos('mailbox is full / blocks limit exceeded / inode limit exceeded', LowerCase(strMsgErro)) > 0) then
  begin
    untFuncoesSimples.fMensagem('ATENÇÃO!', 'O Provedor atingiu o limite de envio de e-mails por hora.', ['&OK']);
  end
  else if (Pos('mailbox full', LowerCase(strMsgErro)) > 0) then
  begin
    untFuncoesSimples.fMensagem('ATENÇÃO!', 'O Provedor atingiu o limite de envio de e-mails por hora.', ['&OK']);
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

function TEnvioEmail.RetornaDadosAdicionaisErroMensagem(
  AMensagem: TIdMessage; AMensagemCompleta: TMensagem): String;
  Var
    LAnexo: TAnexo;
begin
  Result := 'Quantidade anexos: ' + AMensagem.MessageParts.AttachmentCount.ToString + #13;

  Try
    If AMensagem.MessageParts.AttachmentCount > 0 Then
    Begin
      If AMensagemCompleta.anexos = nil Then
        Result := Result + 'Quantidade anexos incompatível.' + #13
      Else If AMensagemCompleta.anexos.arquivosAnexados = Nil Then
        Result := Result + 'Quantidade anexos incompatível.' + #13
      Else If AMensagemCompleta.anexos.arquivosAnexados.Count <> AMensagem.MessageParts.AttachmentCount Then
        Result := Result + 'Quantidade anexos incompatível.' + #13;

      For LAnexo In AMensagemCompleta.anexos.arquivosAnexados Do
        Result := Result + LAnexo.FArquivo + ' - Existe: ' + IIF(FileExists(LAnexo.FArquivo), 'Sim', 'Não') + #13;
    End;
  Except

  End;

  Result := Result + #13 + #13;
end;

function TEnvioEmail.RetornaDadosCliente: String;
begin
  Result := EmptyStr;

  If strCodCli.IsEmpty Then
    Exit;

  Result := #13 + 'Cliente: ' + strCodCli + '-' + fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
end;

class function TEnvioEmail.RetornaDadosMensagemAtualOutlook(
  ADadosAutorizacao: TAutenticacaoEmail; ANomeArquivoZip,
  APara: String; out APastaEnviadosEncontrada, AEmailConfirmado: Boolean): TidMessage;
  Var
    LPastas: TList<TPastasOutlook>;

    LPastaItem: TPastasOutlook;

    LPastaId: String;

    LEmail: TJsonObject;

    LJsonArray: TJsonArray;

    LEnvioEmailOutlook: TEnvioEmailOutlookOAuth2;
begin
  Result := Nil;

  APastaEnviadosEncontrada := False;
  AEmailConfirmado := False;

  LEnvioEmailOutlook := TEnvioEmailOutlookOAuth2.Create(ADadosAutorizacao.AutenticacaoOAuth2);

  Try
    LPastas := LEnvioEmailOutlook.ListaPastasImap;

    For LPastaItem In LPastas Do
    Begin
      APastaEnviadosEncontrada := LPastaItem.folderName.ToLowerInvariant.Contains('sent');
      If Not APastaEnviadosEncontrada Then
        APastaEnviadosEncontrada := LPastaItem.folderName.ToLowerInvariant.Contains('enviad');

      If APastaEnviadosEncontrada Then
      Begin
        LPastaId := LPastaItem.id;

        Break;
      End;
    End;

    If Not APastaEnviadosEncontrada Then
      Exit;

    LEmail := LEnvioEmailOutlook.BuscaEmailPorIdOutlook(LPastaId, ANomeArquivoZip);

    LJsonArray := TJSONObject.ParseJSONValue(LEmail.GetValue('value').ToJson) As TJsonArray;

    LEmail := LJsonArray.Items[0] As TJsonObject;

    Result := LEnvioEmailOutlook.ConverteEmailJsonParaidMessage(LEmail);

    AEmailConfirmado := True;
  Except
    Raise;
  End;

end;



function TEnvioEmail.RetornaMensagemOperadores(AEmailFixo: Boolean;
  AGrupoModelo, ANomeModelo, AErroGerado: String): String;
begin
  If Not MensagemErroEmailTratada(AErroGerado).IsEmpty Then
  Begin
    Result := 'Ocorreu um erro no envio do email: ' + #13 +
              MensagemErroEmailTratada(AErroGerado) + #13 + #13;

    If Not AGrupoModelo.Replace('-', EmptyStr).IsEmpty Then
      Result := Result + 'Grupo / Modelo: ' + AGrupoModelo + ' / ' + ANomeModelo + #13;

    Result := Result + 'Email do remetente: ' + FIdMessage.From.Address + #13 +
                       'Provedor: ' + fCampoTabela('PRV_NOMPRV', 'CADPRV', ['PRV_CODPRV'], [FDadosAutenticacao.FProvedor]) + #13 +  #13 +
                       'Erro gerado: ' + AErroGerado;

    Exit;
  End;

  If AEmailFixo Then
  Begin
    Result := 'Ocorreu um erro de autorização no envio do email automático: ' +
              AGrupoModelo +
              ' - Modelo: ' + ANomeModelo + '.' + #13 +
              'Acesse as Configurações do Autcom na empresa ' + VS_strCodEmp + ', altere a configuração ' +
              '[CFG_EMASAI] - "E-mails automáticos de saída", corrija e valide os dados do email ' +
              'referente ao Grupo e Modelo informado.' + #13 + #13 +
              'Email do remetente: ' + FIdMessage.From.Address + #13 +
              'Provedor: ' + fCampoTabela('PRV_NOMPRV', 'CADPRV', ['PRV_CODPRV'], [FDadosAutenticacao.FProvedor]) + #13 +  #13 +
              'Erro gerado: ' + AErroGerado;

    Exit;
  End;

  Result := 'Ocorreu um erro de autorização no envio do email automático.' + #13 +
            'Os dados de autorização de email do Operador ' + strLoginUsuarioLogado + '-' + fRetNomeOperador(strLoginUsuarioLogado) +
            ' estão inválidos. ' + #13 +
            'Acesse no Cadastro de Operadores do Autcom, o cadastro do operador ' + strLoginUsuarioLogado +
            ', corrija e valide os dados do email.' + #13 + #13 +
            'Email do operador: ' + FIdMessage.From.Address + #13 +
            'Provedor: ' + fCampoTabela('PRV_NOMPRV', 'CADPRV', ['PRV_CODPRV'], [FDadosAutenticacao.FProvedor]) + #13 +  #13 +
            'Erro gerado: ' + AErroGerado;
end;

procedure TEnvioEmail.SetblnLimparDados(const Value: Boolean);
begin
  FblnLimparDados := Value;
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

procedure TEnvioEmail.CriarArquivoImagemAssinaturaEmail;
var
  mmsImgAss: TFileStream;
begin
  mmsImgAss := TFileStream.Create(Self.GetCaminhoImagemAssinaturaEmail, fmCreate);

  try
    Self.dadosAutenticacao.imagemAssinatura.SaveToStream(mmsImgAss);
  finally
    mmsImgAss.Free();
  end;
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

procedure TEnvioEmail.DefinirDadosAutenticacao(AProvedor: Integer; ALogin,
  AUsuario, ASenha, ARemete, ACodOpe: String);
  Var
    LProvedor: TUNiQuery;
begin
  LProvedor := fCriaQuery;
  Try
    LProvedor.SQL.Text := 'SELECT * FROM CADPRV WHERE PRV_CODPRV=' + AProvedor.ToString;
    LProvedor.Open;

    If (Assigned(FIdSMTP)) And (Not LProvedor.IsEmpty) Then
    Begin
      FDadosAutenticacao.DefinirDadosAutenticacao(LProvedor.FieldByName('PRV_LIMARQ').AsInteger,
                                                  LProvedor.FieldByName('PRV_CODPRV').AsInteger,
                                                  LProvedor.FieldByName('PRV_PORPRV').AsInteger,
                                                  LProvedor.FieldByName('PRV_PTIMAP').AsInteger,
                                                  ASenha,
                                                  AUsuario,
                                                  ALogin,
                                                  ARemete,
                                                  LProvedor.FieldByName('PRV_URSMTP').AsString,
                                                  LProvedor.FieldByName('PRV_URIMAP').AsString,
                                                  ACodOpe,
                                                  LProvedor.FieldByName('PRV_SSLENT').AsString = 'S',
                                                  LProvedor.FieldByName('PRV_SSLSAI').AsString = 'S',
                                                  LProvedor.FieldByName('PRV_GRVENV').AsString);

      FIdSMTP.Host     := FDadosAutenticacao.servidorSmtp;
      FIdSMTP.Username := FDadosAutenticacao.login;
      FIdSMTP.Password := FDadosAutenticacao.senha;
      FIdSMTP.Port     := FDadosAutenticacao.portaSmtp;

      InicializarComponentes;
    End Else
      untFuncoesSimples.fMensagem('Alerta', 'Dados de autenticação não puderam ser alterados.', ['&Ok']);

  Finally
    FreeAndNil(LProvedor);
  End;
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

  inherited;
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
  strAssunto                       := AAssunto;
  FBlnHabilitaDivisaoAnexoPorEmail := AHabilitaDivisaoAnexoPorEmail;

  Result := EnviarEmail(AOwner, ACodOperador, APara, AComCopia, AComCopiaOculta,
                        ACorpoMensagem, AAnexos, AAbrirEditor, AImportante, strAutInc, strIncCon, intCodEma, blnEmailAut,
                        strSenha, strEmail, strLogin, strRemete, intProvedor, intPorSmt, intPorIma, strSerSmt, strSerIma, intLimArq,
                        blnImgAss, strTxtAss, mmsImaAss, strNomOpe, strImgCorpo, strAssunto, blnSSLSai, blnSSLEnt, strGravaPastaEnviados,
                        blnExibirMensagem, Nil, False, (strEnvAutCob='S'),strCodCli, strCodFor, blnAdicionaUmParagrafoPorLinha, blnExibeStatus,ADuplicatasEnvio,
                        blnGravarAnexos, False, ACodOco, ANotFic);
End;

class function TEnvioEmail.EnviarEmail(AOwner: TComponent; ACodOperador: String;
  APara, AComCopia, AComCopiaOculta, ACorpoMensagem, AAnexos: TStringArray;
  AAbrirEditor, AImportante: Boolean; strAutInc, strIncCon: String; intCodEma: Int64; blnEmailAut: Boolean;
  strSenha : String; strEmail : String; strLogin: String; strRemete: String; intProvedor: Integer; intPorSmt: Integer; intPorIma: Integer; strSerSmt: String; strSerIma: String;
  intLimArq: Integer; blnImgAss: Boolean; strTxtAss: String; mmsImaAss: TMemoryStream; strNomOpe, strImgCorpo: String; var AAssunto: String;
  blnSSLSai: Boolean; blnSSLEnt: Boolean; strGravaPastaEnviados: String; AExibirMensagemConfirmacaoEnvio: Boolean=True;
  AThreadSincronizaEmail: TThreadSincronizaEmails = nil; blnImpressaoBoleto: Boolean = False; blnEnvAutCob: Boolean = False; strCodCli : String = ''; strCodFor : String = '';
  AAdicionaUmParagrafoPorLinha: Boolean = True; blnExibeStatus: Boolean = True; ADuplicatasEnvio: TArrDupTabelaEmail = Nil;
  blnGravarAnexos: Boolean = False; blnIgnorarEmailsInvalidos: Boolean = False; ACodOco: String = ''; ANotFic: String = ''): Boolean;

  Var blnEmailValido: Boolean;

  Function EnviarEmailAutomatico(): Boolean;
    Var
      i: Integer;
      objEnvioEmail: TEnvioEmail;
      stlImgCorpo: TStringList;

      LMensagem: String;

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

      if not fEmptyStr(objEnvioEmail.dadosAutenticacao.FRemete) then
        objEnvioEmail.mensagem.SetNomeSaudacao(objEnvioEmail.dadosAutenticacao.FRemete);
      
      If (objEnvioEmail.dadosAutenticacao.FImagemAssinaturaValida) Then
      Begin
        objEnvioEmail.dadosAutenticacao.FImagemAssinatura := TMemoryStream.Create;

        If mmsImaAss <> Nil Then
        Begin
          mmsImaAss.SaveToStream(objEnvioEmail.dadosAutenticacao.FImagemAssinatura);
          objEnvioEmail.dadosAutenticacao.FImagemAssinatura.Seek(0,soFromBeginning);
        End;
      End
      Else
        objEnvioEmail.dadosAutenticacao.FImagemAssinatura := nil;
    End;

  Begin
    Result := False;

    try
      objEnvioEmail := TEnvioEmail.Create(AOwner, blnEmailAut, strNomOpe, intLimArq);

      If (blnEmailAut) Or (Not Concat(strEmail, strLogin, strSenha).Trim().IsEmpty) Then
        pAjustaDadosAutenticacao;

      objEnvioEmail.InicializarComponentes();

      objEnvioEmail.strAutInc := strAutInc;
      objEnvioEmail.strIncCon := strIncCon;
      objEnvioEmail.intCodEma := intCodEma;
      objEnvioEmail.FDuplicatasEnvio := ADuplicatasEnvio;
      objEnvioEmail.mensagem.blnIgnorarEmailsInvalidos := blnIgnorarEmailsInvalidos;
      objEnvioEmail.strNotFic := ANotFic;

      blnEmailValido := objEnvioEmail.dadosAutenticacao.EhValido();

      If blnEmailValido Then
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

        objEnvioEmail.mensagem.mensagemAutomatica := True;

        objEnvioEmail.importante := AImportante;
        objEnvioEmail.horaEnvio  := fNow();
        objEnvioEmail.strCodCli  := strCodCli;
        objEnvioEmail.strCodFor  := strCodFor;
        objEnvioEmail.ThreadSincEmail := AThreadSincronizaEmail;
        objEnvioEmail.strCodOpe  := ACodOperador;
        If (blnEmailAut) or (Not blnExibeStatus) Then
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
            If VS_PermitidoEnviarEmail Then
              untFuncoesSimples.fMensagem('Alerta', 'Dados de autenticação com o servidor de e-Mail são inválidos. Verifique a configuração ''CFG_PRVEMA - Provedores de e-mail''.'
              +#13#10+'Se o provedor estiver cadastrado corretamente, verifique o cadastro do Operador (aba ''e-Mail'') e tente novamente.', ['&OK']);
          End;
        End;
      End;
    finally
      FreeAndNil(objEnvioEmail);
    end;

    If (Not blnEmailValido) Then
    begin
      LMensagem := 'Configuração de e-mail do operador ' + fRetNomeOperador(ACodOperador) + ' está inválida!' + #13 +
                   'Entre no Cadastro de Operadores, selecione o operador ' + fRetNomeOperador(ACodOperador) + ', cadastre e valide as configurações na aba de e-mail.';

      If AExibirMensagemConfirmacaoEnvio Then
        untFuncoesSimples.fMensagem('Alerta', 'Erro no envio do e-mail: ' + LMensagem, ['&Ok'])
      Else
        Raise ExceptionAutCom.Create(LMensagem);
    end;
  End;

  Function EnviarEmailEditor(): Boolean;
  Var
    objDadosAutenticacao: TAutenticacaoEmail;
  Begin
    objDadosAutenticacao := TAutenticacaoEmail.Create(strLoginUsuarioLogado, '', False);
    Try
      If Not objDadosAutenticacao.EhValido() Then
      Begin
        untFuncoesSimples.fMensagem('Alerta', 'Dados de autenticação com o servidor de e-Mail são inválidos. Verifique a configuração ''CFG_PRVEMA - Provedores de e-mail''.'
        +#13#10+'Se o provedor estiver cadastrado corretamente, verifique o cadastro do Operador (aba ''e-Mail'') e tente novamente.', ['&Ok']);
        Exit(False);
      End;
    Finally
      FreeAndNil(objDadosAutenticacao);
    End;

    Try
      pCriarFormularios(TfrmEnvioEmail, frmEnvioEmail);

      If (Not strLogin.IsEmpty) And (intProvedor > 0) Then
      Begin
        frmEnvioEmail.Email := strEmail;
        frmEnvioEmail.Login := strLogin;
        frmEnvioEmail.Senha := strSenha;
        frmEnvioEmail.Provedor := intProvedor;
        frmEnvioEmail.Remetente := strRemete;
        frmEnvioEmail.TextoAssinatura := strTxtAss;
        frmEnvioEmail.ImagemAssinatura := mmsImaAss;
        frmEnvioEmail.ImagemAssinaturaValida := blnImgAss;
         If (blnImgAss) Then
        Begin
          frmEnvioEmail.ImagemAssinatura := TMemoryStream.Create;

          If mmsImaAss <> Nil Then
          Begin
            mmsImaAss.SaveToStream(frmEnvioEmail.ImagemAssinatura);
            frmEnvioEmail.ImagemAssinatura.Seek(0,soFromBeginning);
          End;
        End
        Else
          frmEnvioEmail.ImagemAssinatura := nil;
      End;

      frmEnvioEmail.strAssunto        := AAssunto;
      frmEnvioEmail.arrPara           := APara;
      frmEnvioEmail.arrComCopia       := AComCopia;
      frmEnvioEmail.arrComCopiaOculta := AComCopiaOculta;
      frmEnvioEmail.arrCorpoMensagem  := ACorpoMensagem;
      frmEnvioEmail.arrAnexos         := AAnexos;
      frmEnvioEmail.blnFinalizar      := True;
      frmEnvioEmail.blnImportante     := AImportante;
      frmEnvioEmail.blnAdicionaUmParagrafoPorLinha := AAdicionaUmParagrafoPorLinha;
      frmEnvioEmail.FDuplicatasEnvio  := ADuplicatasEnvio;
      frmEnvioEmail.blnGravarAnexos   := blnGravarAnexos;
      frmEnvioEmail.blnIgnorarEmailsInvalidos := blnIgnorarEmailsInvalidos;
      frmEnvioEmail.blnHabilitaDivisaoAnexoPorEmail := FBlnHabilitaDivisaoAnexoPorEmail;
      frmEnvioEmail.CodOco := ACodOco;
      If blnImpressaoBoleto Then
        frmEnvioEmail.AThreadEmail    := AThreadSincronizaEmail;

      frmEnvioEmail.ShowModal();

      Result := frmEnvioEmail.blnEnviado;
      AAssunto :=frmEnvioEmail.edtAssunto.Text;
    Finally
      FreeAndNil(frmEnvioEmail);
    End;
  End;

begin
  If (AAbrirEditor) Then
    Result := EnviarEmailEditor()
  Else
    Result := EnviarEmailAutomatico();
end;

class function TEnvioEmail.EnviarEmailSemMensagemConfirmacao(AOwner: TComponent;
                                                             ACodOperador,
                                                             AAssunto: String;
      APara, AComCopia, AComCopiaOculta, ACorpoMensagem, AAnexos: TStringArray;
      AAbrirEditor: Boolean = True; AThreadSincronizaEmail: TThreadSincronizaEmails = nil; blnImpressaoBoleto: Boolean = False;
      AImportante: Boolean = False; strAutInc: String = ''; strIncCon: String = ''; intCodEma: Int64 = 0; blnEmailAut: Boolean = False;
      strSenha : String = ''; strEmail : String = ''; strLogin : String = ''; strRemete : String = ''; intProvedor: Integer = 0; intPorSmt: Integer = 0; intPorIma: Integer = 0; strSerSmt: String = ''; strSerIma: String = '';
      intLimArq: Integer = 0; blnImgAss: Boolean = False; strTxtAss: String = ''; mmsImaAss: TMemoryStream = Nil; strNomOpe: String = ''; strImgCorpo: String = '';
      blnSSLSai: Boolean = False; blnSSLEnt: Boolean = False; strGravaPastaEnviados: String = 'S'; ADuplicatasEnvio: TArrDupTabelaEmail = Nil;
      ACodigoGrupoModelo: String = ''; ACodigoModelo: String = ''; ACodCli: String = ''; AProved: String = ''): Boolean;
  Var
    LAssunto : String;
    LImgCorpo : String;
    LDadosEnviaGatilhoEmail : TDadosEnviaGatilhoEmail;
    LArquivo : String;
    LCorpoEmail : String;
    arrImgCorpo : TArray<String>;
    arrArquivos : TArray<TRecArquivosGatilhos>;
Begin
  LAssunto := AAssunto;

  FCodigoGrupoModelo := ACodigoGrupoModelo;
  FCodigoModelo := ACodigoModelo;

  If (AAbrirEditor) Then
  Begin
    Result := EnviarEmail(AOwner, ACodOperador, APara, AComCopia, AComCopiaOculta,
                          ACorpoMensagem, AAnexos, AAbrirEditor, AImportante, strAutInc, strIncCon, intCodEma, blnEmailAut,
                          strSenha, strEmail, strLogin, strRemete, intProvedor, intPorSmt, intPorIma, strSerSmt, strSerIma, intLimArq,
                          blnImgAss, strTxtAss, mmsImaAss, strNomOpe, strImgCorpo, LAssunto, blnSSLSai, blnSSLEnt, strGravaPastaEnviados, False,
                          AThreadSincronizaEmail, blnImpressaoBoleto,False,'','',True,True,ADuplicatasEnvio);
    Exit();
  End;

  LDadosEnviaGatilhoEmail := TDadosEnviaGatilhoEmail.Create;
  Try
    Try
      LDadosEnviaGatilhoEmail.provedor.tipoProvedorEnvio := AProved;

      LDadosEnviaGatilhoEmail.operador.codigoOperador := ACodOperador;
      LDadosEnviaGatilhoEmail.operador.nomeOperador := fRetNomeOperador(ACodOperador);

      LDadosEnviaGatilhoEmail.cliente.codigoCliente := ACodCli;
      LDadosEnviaGatilhoEmail.email.copiaOculta := AComCopiaOculta;

      SetLength(arrArquivos, 0);
      for LArquivo in AAnexos do
      begin
        SetLength(arrArquivos, Length(arrArquivos) + 1);
        arrArquivos[High(arrArquivos)].Titulo      := ExtractFileName(LArquivo);
        arrArquivos[High(arrArquivos)].Arquivo     := LArquivo;
        arrArquivos[High(arrArquivos)].TipoArquivo := fGetTipoArquivo(LArquivo);
      end;

      If (Not fEmptyStr(strImgCorpo)) Then
      Begin
        arrImgCorpo := strImgCorpo.Split([';']);
        for LImgCorpo in arrImgCorpo do
          LDadosEnviaGatilhoEmail.email.pAddImagemCorpo(TDadosImagemCorpo
                                                         .fNew
                                                         .fPath(LImgCorpo)
                                                         .fBase64(fRetornarArquivoBase64(LImgCorpo))
                                                       );
      End;

      LDadosEnviaGatilhoEmail.email.envioAutomaticoCobranca := False;
      LDadosEnviaGatilhoEmail.email.duplicatas := ADuplicatasEnvio;
      LDadosEnviaGatilhoEmail.email.gravarAnexos := false;

      LDadosEnviaGatilhoEmail.gatilho.codigoGrupo   := ACodigoGrupoModelo;
      LDadosEnviaGatilhoEmail.gatilho.codigoGatilho := ACodigoModelo;

      If Length(ACorpoMensagem) = 0 then
        LCorpoEmail := ''
      Else
        LCorpoEmail := '<p>' + String.Join('</p>' + sLineBreak + '<p>', ACorpoMensagem) + '</p>';

      Result := TDllGatime
                  .fNew
                  .fGravarGatilhoImediato(TRecGatilhoImediato
                                            .Create(AAssunto,
                                                    LCorpoEmail,
                                                    arrArquivos,
                                                    LDadosEnviaGatilhoEmail.ToJsonString,
                                                    ACodOperador,
                                                    EmptyStr,
                                                    String.Join(';', APara)
                                          ));
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TEnvioEmail.EnviarEmailSemMensagemConfirmacao]');
      End;
    End;
  finally
    FreeAndNil(LDadosEnviaGatilhoEmail);
  end;

end;

procedure TEnvioEmail.EnviarMensagem();
  Var
    destinatario : TIdEmailAddressItem;
    caminhoImagem: String;
    objEmailSinc :  TEmailsSinc;
    intCont      : Integer;
    staPara      : TStringArray;
    blnException : Boolean;

    LConectado,
    LAutenticado,
    LModoRoboFaturamento : Boolean;

    i : Integer;

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
        Body.Add('<STYLE>P {line-height: 1.5+0.5vw;}</STYLE>');
        Body.Add('</HEAD>');
        Body.Add('<BODY>');
        For i := 0 To FMensagem.FCorpoMensagem.Count - 1 do
          Body.Add('<P>' + FMensagem.FCorpoMensagem[i] + '</P>');

        Body.Add('</BODY></HTML>');
      End;

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

          If (Pos(caminhoImagem, FMensagem.FCorpoMensagem.Text) > 0) Then Begin

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

  Procedure GravarPastaEnviados(AExecutandoModoRobo: Boolean = False);
    Var
      i: Integer;
      IdIMAP: TIdIMAP4;
      pastas: TStringList;
      confirmado, encontrada: Boolean;
      IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;

      LDadosMensagem: String;
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
              Begin
                If AExecutandoModoRobo Then
                Begin
                  If E.Message.ToUpperInvariant.Contains('CONNECTION RESET BY PEER') Then
                  Begin
                    LDadosMensagem := RetornaDadosAdicionaisErroMensagem(FIdMessage, FMensagem);

                    pGravarErro(True, E.Message, LDadosMensagem + fRetornaStack);
                    Exit;
                  End;
                End;

                pMensagensErro(E.Message, '[TEnvioEmail.GravarPastaEnviados]', '');
              End;

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

  Procedure SalvarMensagem(intDestino : Integer);
    Var
      LInserir: TUniQuery;

      LDataExecutavel : TDateTime;
  Begin
    Try
      LInserir := fCriaQuery;

      LInserir.SQL.Text := 'SELECT * FROM EMAENV WHERE FALSE';
      LInserir.Open;

      LInserir.Append;
      LInserir.FieldByName('ENV_TIP_FC').AsString   := IIF(fEmptyStr(strCodCli),'F','C');
      LInserir.FieldByName('ENV_FORCLI').AsString   := IIF(fEmptyStr(strCodCli),strCodFor,strCodCli);

      LInserir.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('EMAENV', VS_StrCodEmp);
      LInserir.FieldByName('ENV_EMACOD').AsLargeInt := StrToInt64(fAtualizaProCod('EMAENV', ''));
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
        LInserir.FieldByName('ENV_EMADES').AsString := FMensagem.FPara[intDestino]
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
      TDupEma.GravarDupEma(LInserir.FieldByName('AUTOINCREM').AsString,FDuplicatasEnvio);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TEnvioEmail.EnviarMensagem.SalvarMensagem]');
    End;
    FreeAndNil(LInserir);
  End;

  procedure GravarContatos(strAutInc: String);
    Var
      i: Integer;
  Begin
    For i := 0 To FMensagem.FPara.Count - 1 Do
      TListaContatosEmail.pGravarContato(FMensagem.FPara[i], strAutInc);

    For i := 0 To FMensagem.FComCopia.Count - 1 Do
      TListaContatosEmail.pGravarContato(FMensagem.FComCopia[i], strAutInc);

    For i := 0 To FMensagem.FComCopiaOculta.Count - 1 Do
      TListaContatosEmail.pGravarContato(FMensagem.FComCopiaOculta[i], strAutInc);
  End;

  Procedure SalvarMensagemEnvioAutomatico;
  Var
    qryEmaEnv: TUniQuery;
    strSQL   : String;
    intContador: Integer;
    strDestinatarios: String;

    LDataExecutavel : TDateTime;
  Begin
    qryEmaEnv := fCriaQuery(Nil);
    try
      Try
        fStartTransaction;

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
        {$IFDEF LINUX}
        strSQL := strSQL + '         ENV_ARQZIP, ';
        {$ENDIF}
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
        {$IFDEF LINUX}
        strSQL := strSQL + '         :ARQZIP,    ';
        {$ENDIF}
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

        qryEmaEnv.ParamByName('TIP_FC').AsString   := IIF(fEmptyStr(strCodCli),'F','C');
        qryEmaEnv.ParamByName('FORCLI').AsString   := IIF(fEmptyStr(strCodCli),strCodFor,strCodCli);

        qryEmaEnv.ParamByName('AUTINC').AsString   := strAutInc;
        qryEmaEnv.ParamByName('EMACOD').AsLargeInt := intCodEma;
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

        {$IFDEF LINUX}
        if FileExists(FDiretorioEmail + FNomeArquivoZip + '.zip') then
          qryEmaEnv.ParamByName('ARQZIP').LoadFromFile(FDiretorioEmail + FNomeArquivoZip + '.zip', ftBlob);
        {$ENDIF}

        If (FMensagem.FPara.Count > 0) Then
        Begin
          strDestinatarios := EmptyStr;
          For intContador := 0 To FMensagem.FPara.Count - 1 do
            strDestinatarios := strDestinatarios + FMensagem.FPara[intContador]+';';

          qryEmaEnv.ParamByName('EMADES').AsString := strDestinatarios;
        End
        Else If (FMensagem.FComCopia.Count > 0) Then
          qryEmaEnv.ParamByName('EMADES').AsString := FMensagem.FComCopia[0]
        Else If (FMensagem.FComCopiaOculta.Count > 0) Then
          qryEmaEnv.ParamByName('EMADES').AsString := FMensagem.FComCopiaOculta[0];

        FileAge(Application.ExeName, LDataExecutavel);

        qryEmaEnv.ParamByName('PATEXE').AsString  := Application.ExeName;
        qryEmaEnv.ParamByName('VEREXE').AsString  := TVersaoExecutavel.GetVersaoProduto;
        qryEmaEnv.ParamByName('DTAEXE').AsDateTime := LDataExecutavel;

        qryEmaEnv.ParamByName('SEQNOT').AsString  := strNotFic;

        qryEmaEnv.ExecSQL;
        TDupEma.GravarDupEma(strAutInc,FDuplicatasEnvio);
        fCommit();
      Except
        On E: Exception Do
        Begin
          fRollBack();
          pMensagensErro(E.Message, '[TEnvioEmail.EnviarMensagem.SalvarMensagemEnvioAutomatico]');
        End;
      End;
    finally
      FreeAndNil(qryEmaEnv);
    end;
  End;

  procedure pSendMail;
  Var
    intTentativa: Integer;
  begin
    FErroTooManyRecipients := False;
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
        If (intTentativa = 3) Or (FErroTooManyRecipients) Then
        Begin
          FErroTooManyRecipients := False;
          Raise;
        End;
      End;
    End;
  end;

begin
  FEnviado := False;
  blnException := False;
  LintTentativasConexaoEmail := 0;
  blnTentarReconexaoEmail := True;

  If OperadorCitelLogado Then
    Exit;

  If (ValidarMensagem()) Then
  Begin
    LAutenticado := False;
    LModoRoboFaturamento := SameText(ParamStr(1), 'DISP_EMASMS_BOLETO_AUTFAT');

    Try
      If (Not VS_PermitidoEnviarEmail) Then
        Raise ExceptionAutcom.Create('Não é permitido enviar e-mail nesse banco de dados!');

      LimparMensagem();

      FNomeArquivoZip := 'MensagemEmail_' + IIF(fEmptyStr(FCodOpe), strLoginUsuarioLogado, FCodOpe) + '_' + FormatDateTime('yyyymmdd_hhnnsszzz', FHoraEnvio);

      If (ValidarDiretorioEmail(FDiretorioEmail, FCodOpe)) Then
      Begin
        PreencherMensagem();
        AdicionarAnexos();

        If FDadosAutenticacao.UsaAuthenticacaoOAuth2 Then
        Begin
          LEnvioEmailOAuth2 := TEnvioEmailOutlookOAuth2.Create(FDadosAutenticacao.AutenticacaoOAuth2);

          FDadosAutenticacao.AutenticacaoOAuth2.CarregaEmailIDAzureDadosModeloOperador(FCodigoGrupoModelo,
                                                                                       FCodigoModelo,
                                                                                       IIF(fEmptyStr(FCodOpe), strLoginUsuarioLogado, FCodOpe));

          LJsonEmail := LEnvioEmailOAuth2.RetornaJsonMensagemMicrosoftOutlook(FIdMessage,
                                                                              FDadosAutenticacao.strGravaPastaEnviados.Equals('S'),
                                                                              FImportante);
        End;

        If FUsarAntiFreeze Then
        Begin
          FIdSMTP.OnWorkBegin := OnWorkSMTPBegin;
          FIdSMTP.OnWork      := OnWorkSMTP;
          FIdSMTP.OnWorkEnd   := OnWorkSMTPEnd;
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
                pSendMail;
                FEnviado := True;

                blnTentarReconexaoEmail := False;

                FIdSMTP.Disconnect();

                if Not Assigned(ThreadSincEmail) then
                  GravarZipMensagem(FIdMessage, FDiretorioEmail, FNomeArquivoZip);

                If (blnEmailAut) Then
                  SalvarMensagemEnvioAutomatico()
                Else
                Begin
                  for i := 0 to FMensagem.FPara.Count - 1 do
                    SalvarMensagem(i);
                End;

                If Not FDadosAutenticacao.UsaAuthenticacaoOAuth2 Then
                Begin
                  if Not Assigned(ThreadSincEmail) then
                    GravarPastaEnviados(LModoRoboFaturamento)
                  Else
                  begin
                    objEmailSinc := TEmailsSinc.Create;
                    objEmailSinc.DadosAutenticacao := FDadosAutenticacao;
                    objEmailSinc.IdSMTP := FIdSMTP;
                    objEmailSinc.IdMessage := FIdMessage;
                    objEmailSinc.SSLSocket := FSSLSocket;
                    objEmailSinc.NomeArquivoZip := FNomeArquivoZip;
                    objEmailSinc.DiretorioEmail := FDiretorioEmail;
                    objEmailSinc.CaminhoImagemAssinaturaEmail := Self.GetCaminhoImagemAssinaturaEmail;

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

                If FblnLimparDados Then
                  FMensagem.Limpar();

                If (FMensagem.FMensagemAutomatica)
                  And (FDadosAutenticacao.FImagemAssinaturaValida)
                  And (FileExists(caminhoImagem)) Then
                    SysUtils.DeleteFile(caminhoImagem);

                FImportante := False;
              End;
            End;
          Except

            On E: ExceptionAutcom Do
            begin
              if (LintTentativasConexaoEmail >= 3) or (FEnviado) then
              begin
                If fTipoErroGravaEmailErrosLog(E.Message) Then
                  untFuncoesSimples.pGravarEmailErros(IIF(fEmptyStr(strCodCli),'F','C'),
                                                      IIF(fEmptyStr(strCodCli),strCodFor,strCodCli),
                                                      FMensagem.FAssunto, GetDestinatario(E.Message), E.Message);

                If not blnEmailAut Then
                  untFuncoesSimples.fMensagem('ATENÇÃO', E.Message + RetornaDadosCliente, ['&Ok']);

                If (LModoRoboFaturamento) or (blnEmailAut) Then
                  EnviarMensagemErroAosOperadores(LAutenticado,
                                                  FCodigoGrupoModelo,
                                                  FCodigoModelo,
                                                  E.Message + RetornaDadosCliente);
              end
              else
                Sleep(2000);
            end;

            On E: EFOpenError Do
            begin
              if (LintTentativasConexaoEmail >= 3) or (FEnviado) then
              begin

                E.Message := E.Message + RetornaDadosCliente;

                If fTipoErroGravaEmailErrosLog(E.Message) Then
                  untFuncoesSimples.pGravarEmailErros(IIF(fEmptyStr(strCodCli),'F','C'),
                                                      IIF(fEmptyStr(strCodCli),strCodFor,strCodCli),
                                                      FMensagem.FAssunto, GetDestinatario(E.Message), E.Message)
                Else
                Begin
                  If Not EmitirMensagemErroThreadTratada(LAutenticado Or LModoRoboFaturamento,
                                                         FCodigoGrupoModelo,
                                                         FCodigoModelo,
                                                         E.Message + ' - ' + FIdSMTP.EmailError) Then
                  Begin
                    If (Not LModoRoboFaturamento) And (Not blnEmailAut) Then
                      pMensagensErro(E.Message + ' - ' + FIdSMTP.EmailError, '', '');
                  End;
                End;

                If not blnEmailAut Then
                  pMensagemErroEnviaEmail(E.Message);

                If (LModoRoboFaturamento) or (blnEmailAut) Then
                  EnviarMensagemErroAosOperadores(LAutenticado,
                                                  FCodigoGrupoModelo,
                                                  FCodigoModelo,
                                                  E.Message);
              end
              else
                Sleep(2000);
            end;

            On E: EIdSMTPReplyError do
            begin
              if (LintTentativasConexaoEmail >= 3) or (FEnviado) then
              begin

                blnException := True;

                E.Message := E.Message + RetornaDadosCliente;

                If fTipoErroGravaEmailErrosLog(E.Message) Then
                  untFuncoesSimples.pGravarEmailErros(IIF(fEmptyStr(strCodCli),'F','C'),
                                                      IIF(fEmptyStr(strCodCli),strCodFor,strCodCli),
                                                      FMensagem.FAssunto, GetDestinatario(E.Message), E.Message)
                Else
                Begin
                  If Not EmitirMensagemErroThreadTratada(LAutenticado Or LModoRoboFaturamento,
                                                         FCodigoGrupoModelo,
                                                         FCodigoModelo,
                                                         E.Message + ' - ' + FIdSMTP.EmailError) Then
                  Begin
                    If (Not LModoRoboFaturamento) And (Not blnEmailAut) Then
                      pMensagensErro(E.Message + ' - ' + FIdSMTP.EmailError, '', '');
                  End;
                End;


                If not blnEmailAut Then
                  pMensagemErroEnviaEmail(E.Message, FIdSMTP.EmailError);

                If (LModoRoboFaturamento) or (blnEmailAut) Then
                  EnviarMensagemErroAosOperadores(LAutenticado,
                                                  FCodigoGrupoModelo,
                                                  FCodigoModelo,
                                                  E.Message);
              end
              else
                Sleep(2000);
            end;

            On E: Exception Do
            begin
              if (LintTentativasConexaoEmail >= 3) or (FEnviado) then
              begin

                E.Message := IIF(FEnviado,
                                 'O e-mail foi enviado com sucesso, porém ocorreu um erro após o envio. ' +
                                 'Verifique as configurações de IMAP do provedor utilizado. ' + E.Message,
                                 E.Message);

                E.Message := E.Message + RetornaDadosCliente;

                If fTipoErroGravaEmailErrosLog(E.Message) Then
                  untFuncoesSimples.pGravarEmailErros(IIF(fEmptyStr(strCodCli),'F','C'),
                                                      IIF(fEmptyStr(strCodCli),strCodFor,strCodCli),
                                                      FMensagem.FAssunto, GetDestinatario(E.Message), E.Message)
                Else
                Begin
                  If Not EmitirMensagemErroThreadTratada(LAutenticado Or LModoRoboFaturamento,
                                                         FCodigoGrupoModelo,
                                                         FCodigoModelo,
                                                         E.Message + ' - ' + FIdSMTP.EmailError) Then
                  Begin
                    If (Not LModoRoboFaturamento) And (Not blnEmailAut) Then
                      pMensagensErro(E.Message + ' - ' + FIdSMTP.EmailError, '', '');
                  End;
                End;


                If not blnEmailAut Then
                  pMensagemErroEnviaEmail(E.Message);

                If (LModoRoboFaturamento) or (blnEmailAut) Then
                  EnviarMensagemErroAosOperadores(LAutenticado,
                                                  FCodigoGrupoModelo,
                                                  FCodigoModelo,
                                                  E.Message);
              end
              else
                Sleep(2000);
            end;

          End;

        until (LintTentativasConexaoEmail >= 3) or (not blnTentarReconexaoEmail);
      End;
    Finally
      FreeAndNil(destinatario);
      If (Assigned(frmEnvioEmail)) And
         (length(frmEnvioEmail.strEmail) > 0) Then
        TfrmListaEmail.pAtualizaValorConsulta(frmEnvioEmail.strEmail, (Not blnException) );
    End;
  End
  Else
    untFuncoesSimples.fMensagem('Alerta', 'Mensagem não pôde ser enviada. Verifique!', ['&Ok']);
end;

procedure TEnvioEmail.EnviarMensagemErroAosOperadores(AAutenticado: Boolean;
  ACodigoGrupoModelo, ACodigoModelo, AErroGerado: String);
  Var
    LConsultaOperadores: TUniQuery;

    LMensagemInterna: TMsgInterna;

    LEmailFixo: Boolean;

    LNomeGrupo,
    LNomeModelo: String;

    LMensagemEnviada: String;
begin
  If AAutenticado Then
    Exit;

  LEmailFixo := fCampoTabela('EMA_PROENV',
                             'EMASAI',
                             ['EMA_CODGRU', 'EMA_CODIGO', 'EMA_CODEMP'],
                             [ACodigoGrupoModelo, ACodigoModelo, VS_strCodEmp]) = 'F';

  If LEmailFixo Then
  Begin
    LConsultaOperadores := fCriaQuery;

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
  End;

  LMensagemInterna := TMsgInterna.Create(Nil);

  LNomeGrupo := fCampoTabela('GRU_DESGRU',
                             'GRUEMA',
                             ['GRU_CODGRU', 'GRU_CODEMP'],
                             [ACodigoGrupoModelo, VS_strCodEmp]);

  LNomeModelo := fCampoTabela('EMA_DESCRI',
                              'EMASAI',
                              ['EMA_CODGRU', 'EMA_CODIGO', 'EMA_CODEMP'],
                              [ACodigoGrupoModelo, ACodigoModelo, VS_strCodEmp]);

  LMensagemEnviada := RetornaMensagemOperadores(LEmailFixo,
                                                Concat(ACodigoGrupoModelo, '-', LNomeGrupo),
                                                LNomeModelo,
                                                AErroGerado);

  Try

    Try
      fStartTransaction;

      If LEmailFixo Then
      Begin
        LConsultaOperadores.Open;
        LConsultaOperadores.First;
        While Not LConsultaOperadores.Eof Do
        Begin
          If Pos(VS_strCodEmp, LConsultaOperadores.FieldByName('OPE_EMPACE').AsString) <= 0 Then
          Begin
            LConsultaOperadores.Next;
            Continue;
          End;

          LMensagemInterna.fEnviaMensagem('Dados de autorização do e-mail de ' + LNomeGrupo + ' inválidos.',
                                          LMensagemEnviada,
                                          strLoginUsuarioLogado,
                                          LConsultaOperadores.FieldByName('OPE_CODOPE').AsString,
                                          'N',
                                          NullAsStringValue);

          LConsultaOperadores.Next;
        End;
      End
      Else
      Begin
        LMensagemInterna.fEnviaMensagem('Dados de autorização de e-mail do Operador ' + strLoginUsuarioLogado + '-' + fRetNomeOperador(strLoginUsuarioLogado) + ' inválidos.',
                                        LMensagemEnviada,
                                        strLoginUsuarioLogado,
                                        strLoginUsuarioLogado,
                                        'N',
                                        NullAsStringValue);
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
    If Assigned(LConsultaOperadores) Then
    Begin
      LConsultaOperadores.Close;
      FreeAndNil(LConsultaOperadores);
    End;

    FreeAndNil(LMensagemInterna);
  End;
end;

function TEnvioEmail.GetCaminhoImagemAssinaturaEmail: String;
var
  strPathTmpEmail: String;
begin
  Result := EmptyStr;

  if ValidarDiretorioEmail(strPathTmpEmail) then
    Result := strPathTmpEmail + 'assinatura' + FormatDateTime('yyyymmdd_hhnnsszzz', Self.horaEnvio) + '.jpeg';
end;

function TEnvioEmail.GetDestinatario(AMsgErro: String): String;
begin
  If AMsgErro.StartsWith('<') And AMsgErro.Contains('>') And AMsgErro.Contains('@') Then
  Begin
    Result := MidStr(AMsgErro, 2, Pos('>', AMsgErro) -2);
    If Result.Contains('@') Then
      Exit;
  End;

  Result := '';
  If (FMensagem.FPara.Count > 0) Then
    Result := FMensagem.FPara[0]
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

  CompactarArquivos(ADiretorioEmail, ANomeArquivoZip + '.zip', [ANomeArquivoZip + '.mcc'], True);
End;


class procedure TEnvioEmail.IdSMTPFailedRecipient(Sender: TObject; const AAddress, ACode,
      AText: string; var VContinue: Boolean);
begin
  if Assigned(frmEnvioEmail) then
  begin
    If Pos('TOO MANY RECIPIENTS', AText.ToUpperInvariant) > 0 Then
    Begin
      VContinue := False;

      FErroTooManyRecipients := True;

      Raise ExceptionAutcom.Create('Foi selecionado um número de destinatários que o provedor não suporta.' + #13 +
                                   'Verifique com o provedor a quantidade máxima e faça a configuração no Cadastro de Provedores.' + #13 +
                                   'Operação cancelada.');
    End;

    setLength(frmEnvioEmail.strEmail, length(frmEnvioEmail.strEmail) + 1);
    frmEnvioEmail.strEmail[high(frmEnvioEmail.strEmail)].endereco    := AAddress;
    frmEnvioEmail.strEmail[high(frmEnvioEmail.strEmail)].razaoSocial := '';
    frmEnvioEmail.strEmail[high(frmEnvioEmail.strEmail)].cliente     := '';

    //Continua a enviar outros e-mails
    VContinue := True;
  end;
  TIdSMTPLog(Sender).EmailError := AAddress;
end;


procedure TEnvioEmail.InicializarComponentes();
begin
  InicializarComponentesIndy(Self.GetParentComponent(),
                             FIdSMTP,
                             FIdMessage,
                             FSSLSocket,
                             FDadosAutenticacao);
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

function TEnvioEmail.MensagemErroEmailTratada(AErroGerado: String): String;
begin
  Result := EmptyStr;
  If AErroGerado.ToUpperInvariant.Contains('RECIPIENT ADDRESS REJECTED: DOMAIN NOT FOUND') Then
    Result := 'O email <<DESTINATARIO>> cadastrado para o destinatário não existe.'.Replace('<<DESTINATARIO>>', FMensagem.FPara.Text) + #13 +
              'Altere para um endereço de email que seja válido.';
end;

procedure TEnvioEmail.OnWorkSMTP(Sender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  Inc(FContadorWork);

  If (FContadorWork = 0) Or (FContadorWork >= 50) Then
  Begin
     Application.ProcessMessages;
     FContadorWork := 0;
  End;
end;

procedure TEnvioEmail.OnWorkSMTPBegin(Sender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  FContadorWork := -1;
end;

procedure TEnvioEmail.OnWorkSMTPEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
  Application.ProcessMessages;
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

function TEnvioEmail.EmitirMensagemErroThreadTratada(AAutenticado: Boolean;
  ACodigoGrupoModelo, ACodigoModelo, AErroGerado: String): Boolean;
  Var
    LEmailFixo: Boolean;

    LNomeGrupo,
    LNomeModelo: String;

    LMensagemEnviada: String;
begin
  Result := True;

  If AAutenticado Then
  Begin
    If MensagemErroEmailTratada(AErroGerado).IsEmpty Then
      Exit(False);
  End;

  LEmailFixo := fCampoTabela('EMA_PROENV',
                             'EMASAI',
                             ['EMA_CODGRU', 'EMA_CODIGO', 'EMA_CODEMP'],
                             [ACodigoGrupoModelo, ACodigoModelo, VS_strCodEmp]) = 'F';

  LNomeGrupo := fCampoTabela('GRU_DESGRU',
                              'GRUEMA',
                              ['GRU_CODGRU', 'GRU_ENTSAI'],
                              [ACodigoGrupoModelo, 'S']);

  LNomeModelo := fCampoTabela('EMA_DESCRI',
                              'EMASAI',
                              ['EMA_CODGRU', 'EMA_CODIGO', 'EMA_CODEMP'],
                              [ACodigoGrupoModelo, ACodigoModelo, VS_strCodEmp]);

  LMensagemEnviada := RetornaMensagemOperadores(LEmailFixo,
                                                Concat(ACodigoGrupoModelo, '-', LNomeGrupo),
                                                LNomeModelo,
                                                AErroGerado);

  pGravarErro(True, AErroGerado, fRetornaStack);

  If Not blnEmailAut Then
    untFuncoesSimples.fMensagem('ATENÇÃO',
                                LMensagemEnviada,
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
                                320,
                                600);
end;

class function TEnvioEmail.EnviarEmail(ADadosEnvioEmail: TDadosEnvioEmail): Boolean;
  Var blnEmailValido: Boolean;

  Function EnviarEmailAutomatico(): Boolean;
    Var
      i: Integer;
      objEnvioEmail: TEnvioEmail;
      stlImgCorpo: TStringList;

    procedure pAjustaDadosAutenticacao;
    Begin
      objEnvioEmail.dadosAutenticacao.SetProvedor(ADadosEnvioEmail.intProvedor);
      objEnvioEmail.dadosAutenticacao.SetSenha(ADadosEnvioEmail.strSenha);
      objEnvioEmail.dadosAutenticacao.SetUsuario(ADadosEnvioEmail.strEmail);
      objEnvioEmail.dadosAutenticacao.SetLogin(ADadosEnvioEmail.strLogin);
      objEnvioEmail.dadosAutenticacao.SetRemete(ADadosEnvioEmail.strRemete);
      objEnvioEmail.dadosAutenticacao.SetPortaSmtp(ADadosEnvioEmail.intPorSmt);
      objEnvioEmail.dadosAutenticacao.SetPortaImap(ADadosEnvioEmail.intPorIma);
      objEnvioEmail.dadosAutenticacao.SetServidorSmtp(ADadosEnvioEmail.strSerSmt);
      objEnvioEmail.dadosAutenticacao.SetServidorImap(ADadosEnvioEmail.strSerIma);
      objEnvioEmail.dadosAutenticacao.SetLimiteArq(ADadosEnvioEmail.intLimArq);
      objEnvioEmail.dadosAutenticacao.blnSSLSai := ADadosEnvioEmail.blnSSLSai;
      objEnvioEmail.dadosAutenticacao.blnSSLEnt := ADadosEnvioEmail.blnSSLEnt;
      objEnvioEmail.dadosAutenticacao.strGravaPastaEnviados := ADadosEnvioEmail.strGravaPastaEnviados;
      objEnvioEmail.dadosAutenticacao.FTextoAssinatura.Text   := ADadosEnvioEmail.strTxtAss;
      objEnvioEmail.dadosAutenticacao.FImagemAssinaturaValida := ADadosEnvioEmail.blnImgAss;

      If (objEnvioEmail.dadosAutenticacao.FImagemAssinaturaValida) Then
        objEnvioEmail.dadosAutenticacao.FImagemAssinatura.LoadFromStream(ADadosEnvioEmail.mmsImaAss)
      Else
        objEnvioEmail.dadosAutenticacao.FImagemAssinatura := nil;
    End;

  Begin
    Result := False;

    try
      objEnvioEmail := TEnvioEmail.Create(ADadosEnvioEmail.AOwner, ADadosEnvioEmail.blnEmailAut, ADadosEnvioEmail.strNomOpe, ADadosEnvioEmail.intLimArq);

      If (ADadosEnvioEmail.blnEmailAut) Then
        pAjustaDadosAutenticacao;

      objEnvioEmail.InicializarComponentes();

      objEnvioEmail.strAutInc := ADadosEnvioEmail.strAutInc;
      objEnvioEmail.strIncCon := ADadosEnvioEmail.strIncCon;
      objEnvioEmail.intCodEma := ADadosEnvioEmail.intCodEma;

      blnEmailValido := objEnvioEmail.dadosAutenticacao.EhValido();

      If blnEmailValido Then
      Begin

        objEnvioEmail.mensagem.assunto := ADadosEnvioEmail.AAssunto;

        for i := 0 to Length(ADadosEnvioEmail.APara) - 1 do
          if (not objEnvioEmail.mensagem.AdicionarPara(ADadosEnvioEmail.APara[i])) then
            Exit;

        for i := 0 to Length(ADadosEnvioEmail.AComCopia) - 1 do
          if (not objEnvioEmail.mensagem.AdicionarComCopia(ADadosEnvioEmail.AComCopia[i])) then
            Exit;

        for i := 0 to Length(ADadosEnvioEmail.AComCopiaOculta) - 1 do
          if (not objEnvioEmail.mensagem.AdicionarComCopiaOculta(ADadosEnvioEmail.AComCopiaOculta[i])) then
            Exit;

        for i := 0 to Length(ADadosEnvioEmail.ACorpoMensagem) - 1 do
          objEnvioEmail.mensagem.corpoMensagem.Add(ADadosEnvioEmail.ACorpoMensagem[i]);

        for i := 0 to Length(ADadosEnvioEmail.AAnexos) - 1 do
          objEnvioEmail.mensagem.AdicionarAnexo(TAnexo.Create(ADadosEnvioEmail.AAnexos[i]));

        Try
          stlImgCorpo := TStringList.Create;
          stlImgCorpo.Delimiter     := ';';
          stlImgCorpo.DelimitedText := ADadosEnvioEmail.strImgCorpo;

          for i := 0 to stlImgCorpo.Count - 1 do
          begin
            objEnvioEmail.mensagem.AdicionarImagemCorpoHtml(stlImgCorpo[i]);
          end;
        Finally
          FreeAndNil(stlImgCorpo);
        End;

        objEnvioEmail.mensagem.mensagemAutomatica := True;

        objEnvioEmail.importante := ADadosEnvioEmail.AImportante;
        objEnvioEmail.horaEnvio  := fNow();
        objEnvioEmail.strCodCli  := ADadosEnvioEmail.strCodCli;
        objEnvioEmail.strCodFor  := ADadosEnvioEmail.strCodFor;
        objEnvioEmail.ThreadSincEmail := ADadosEnvioEmail.AThreadSincronizaEmail;
        objEnvioEmail.strCodOpe  := ADadosEnvioEmail.ACodOperador;

        If (ADadosEnvioEmail.blnEmailAut) Then
        Begin
          objEnvioEmail.EnviarMensagem;
          Result := objEnvioEmail.enviado;
        End
        Else
        Begin
          if (Length(ADadosEnvioEmail.APara) > 1) then
            TfrmGravando.fExecutarModal(objEnvioEmail.EnviarMensagem, 'Aguarde, enviando e-Mail para: ' + ADadosEnvioEmail.APara[0] + ' e outro(s) ...', '')
          else if (Length(ADadosEnvioEmail.APara) = 1) Then
            TfrmGravando.fExecutarModal(objEnvioEmail.EnviarMensagem, 'Aguarde, enviando e-Mail para: ' + ADadosEnvioEmail.APara[0] + ' ...', '')
          else
            untFuncoesSimples.fMensagem('Alerta', 'Nenhum destinatário foi definido na mensagem de e-mail, verifique o cadastro do cliente e tente novamente.', ['&OK']);

          if (objEnvioEmail.enviado) then
          begin
            if ADadosEnvioEmail.AExibirMensagemConfirmacaoEnvio then
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

    If (Not blnEmailValido) Then
    begin
      If ADadosEnvioEmail.AExibirMensagemConfirmacaoEnvio Then
        untFuncoesSimples.fMensagem('Alerta', 'Erro no envio do e-mail: Configuração inválida!', ['&Ok'])
      Else
        Raise ExceptionAutCom.Create('Configuração inválida!');
    end;
  End;

  Function EnviarEmailEditor(): Boolean;
  Begin
    Result := False;

    Try
      pCriarFormularios(TfrmEnvioEmail, frmEnvioEmail);

      If (frmEnvioEmail.blnVisualizar) Or (ADadosEnvioEmail.blnVizualizar) Then
      Begin
        frmEnvioEmail.strAssunto        := ADadosEnvioEmail.AAssunto;
        frmEnvioEmail.arrPara           := ADadosEnvioEmail.APara;
        frmEnvioEmail.arrComCopia       := ADadosEnvioEmail.AComCopia;
        frmEnvioEmail.arrComCopiaOculta := ADadosEnvioEmail.AComCopiaOculta;
        frmEnvioEmail.arrCorpoMensagem  := ADadosEnvioEmail.ACorpoMensagem;
        frmEnvioEmail.arrAnexos         := ADadosEnvioEmail.AAnexos;
        frmEnvioEmail.blnFinalizar      := True;
        frmEnvioEmail.blnImportante     := ADadosEnvioEmail.AImportante;

        If ADadosEnvioEmail.blnImpressaoBoleto Then
          frmEnvioEmail.AThreadEmail    := ADadosEnvioEmail.AThreadSincronizaEmail;

        frmEnvioEmail.ShowModal();

        Result := frmEnvioEmail.blnEnviado;
        ADadosEnvioEmail.AAssunto :=frmEnvioEmail.edtAssunto.Text;
      End;
    Finally
      FreeAndNil(frmEnvioEmail);
    End;
  End;

begin
  If (ADadosEnvioEmail.AAbrirEditor) Then
    Result := EnviarEmailEditor()
  Else
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

{ TImagemCorpoHtml }

constructor TImagemCorpoHtml.Create(ACaminhoImagem: String);
begin
  FCaminhoImagem := ACaminhoImagem;
end;

function CriptografarMensagemEmail(const S: WideString; Key: Word; CKey1, CKey2: Integer): String;
var
  i     : Integer;
  RStr  : RawByteString;
  RStrB : TBytes Absolute RStr;
  LKey  : Int64;
  LHex  : String;
begin
  Result := '';

  RStr := UTF8Encode(S);

  for i := 0 to Length(RStr) - 1 do
  begin
    RStrB[i] := RStrB[i] xor (Key shr 8);

    // Calcula em Int64 para evitar overflow.
    LKey := (Int64(RStrB[i]) + Int64(Key)) *
            Int64(CKey1) +
            Int64(CKey2);

    // Mantém somente os 16 bits da chave.
    Key := Word(LKey and $FFFF);
  end;

  SetLength(Result, Length(RStr) * 2);

  for i := 0 to Length(RStr) - 1 do
  begin
    LHex := IntToHex(RStrB[i], 2);

    Result[(i * 2) + 1] := LHex[1];
    Result[(i * 2) + 2] := LHex[2];
  end;
end;

function DescriptografarMensagemEmail(const S: String; Key: Word; CKey1, CKey2: Integer): String;
var
  i, tmpKey : Integer;
  RStr      : RawByteString;
  RStrB     : TBytes Absolute RStr;
  tmpStr    : String;
  LKey      : Int64;
begin
  Result := '';

  // Remove CR/LF que possam existir no conteúdo armazenado.
  tmpStr := UpperCase(S);
  tmpStr := StringReplace(tmpStr, #13, '', [rfReplaceAll]);
  tmpStr := StringReplace(tmpStr, #10, '', [rfReplaceAll]);

  // Cada byte corresponde a dois caracteres HEX.
  if Odd(Length(tmpStr)) then
    Exit;

  SetLength(RStr, Length(tmpStr) div 2);

  try
    i := 1;

    while i <= Length(tmpStr) - 1 do
    begin
      if not CharInSet(tmpStr[i], ['0'..'9', 'A'..'F']) or
         not CharInSet(tmpStr[i + 1], ['0'..'9', 'A'..'F']) then
      begin
        Result := '';
        Exit;
      end;

      RStrB[i div 2] :=
        StrToInt('$' + tmpStr[i] + tmpStr[i + 1]);

      Inc(i, 2);
    end;

  except
    Result := '';
    Exit;
  end;

  for i := 0 to Length(RStr) - 1 do
  begin
    tmpKey := RStrB[i];

    RStrB[i] := RStrB[i] xor (Key shr 8);

    // Calcula em Int64.
    LKey := (Int64(tmpKey) + Int64(Key)) *
            Int64(CKey1) +
            Int64(CKey2);

    // Mantém somente os 16 bits inferiores.
    // O AND garante que a conversão para Word
    // nunca ultrapasse o intervalo 0..65535.
    Key := Word(LKey and $FFFF);
  end;

  Result := UTF8ToWideString(RStr);
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

Function ValidarDiretorioEmail(out diretorio: String; AOperador: String = ''): Boolean;
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

    If AOperador.IsEmpty Then
      diretorio := diretorio + strLoginUsuarioLogado + '\'
    Else
      diretorio := diretorio + AOperador + '\';

    If (Not DirectoryExists(diretorio)) Then
      MkDir(diretorio);
  Except
    On E: Exception Do
      Result := False;
  End;
End;

Function CompactarArquivos(diretorio, nomeArquivoZip: String;
  nomeArquivosComprimir: TStringArray; deletarArquivo: Boolean = True): Boolean;
Var
  LstrArquivoZip      : String;
  LstrMensagemExcecao : String;
Begin
  Result := CompactarArquivos(diretorio, nomeArquivoZip, nomeArquivosComprimir,
    LstrArquivoZip, LstrMensagemExcecao, deletarArquivo, 0);
End;

Function CompactarArquivos(diretorio, nomeArquivoZip: String;
  nomeArquivosComprimir: TStringArray; out strNomesArquivosCompactados: String;
  out strMensagemExcecao: String; deletarArquivo: Boolean = True;
  intTamanhoMaximoMB: Integer = 0): Boolean;
  Var
    i                      : Integer;
    zip                    : TZipFile;
    totalSizeFilesCompress : Integer;
    sizeFileCompress       : Integer;
    countFiles             : Integer;
    strBaseNomeArquivoZip  : String;
Begin
  Result := False;

  //Convertendo para bytes
  intTamanhoMaximoMB     := intTamanhoMaximoMB
                          * 1024
                          * 1024;

  strBaseNomeArquivoZip  := 'Arquivo-%s-'+nomeArquivoZip;
  totalSizeFilesCompress := 0;
  countFiles             := 0;
  zip                    := nil;

  Try
    If (Not DirectoryExists(diretorio)) Then
      MkDir(diretorio);

    If intTamanhoMaximoMB = 0 Then
    Begin
      zip := TZipFile.Create();
      zip.Open(diretorio + nomeArquivoZip, zmWrite);
    End
    Else
      strNomesArquivosCompactados := EmptyStr;

    i := -1;
    While i < Length(nomeArquivosComprimir) - 1 do
    Begin
      Inc(i);

      If (totalSizeFilesCompress = 0) And
         (intTamanhoMaximoMB > 0) Then
      Begin
        If Assigned(zip) Then
        Begin
          zip.Close();
          FreeAndNil(zip);
        End;

        Inc(countFiles);
        nomeArquivoZip := Format(strBaseNomeArquivoZip,[FormatFloat('000',countFiles)]);

        If FileExists(diretorio + nomeArquivoZip) Then
          DeleteFile(PWideChar(diretorio + nomeArquivoZip));

        zip := TZipFile.Create();
        zip.Open(diretorio + nomeArquivoZip, zmWrite);

        If not fEmptyStr(strNomesArquivosCompactados) Then
          strNomesArquivosCompactados := strNomesArquivosCompactados
                                       + ';';

        strNomesArquivosCompactados := strNomesArquivosCompactados
                                     + diretorio + nomeArquivoZip;
      End;

      zip.Add(diretorio + nomeArquivosComprimir[i]);

      If (intTamanhoMaximoMB > 0) Then
      Begin
        sizeFileCompress       := zip.FileInfo[zip.FileCount-1].CompressedSize;
        totalSizeFilesCompress := totalSizeFilesCompress
                                + sizeFileCompress;

        If sizeFileCompress > intTamanhoMaximoMB Then
          raise Exception.Create(Format('O arquivo %s possui tamanho superior ao permitido pela configuração [CFG_TAMANX].', [nomeArquivosComprimir[i]]));

        If totalSizeFilesCompress > intTamanhoMaximoMB Then
        begin
          zip.Delete(nomeArquivosComprimir[i]);

          Dec(i);
          totalSizeFilesCompress := 0;
        end;
      End;
    End;

    If Assigned(zip) Then
    Begin
      zip.Close();
      FreeAndNil(zip);
    End;

    If (deletarArquivo) Then
      For i := 0 To Length(nomeArquivosComprimir) - 1 Do
        If (FileExists(diretorio + nomeArquivosComprimir[i])) Then
          DeleteFile(PWideChar(diretorio + nomeArquivosComprimir[i]));

    Result := True;
  Except
    On E: Exception Do
    Begin
      strMensagemExcecao := E.Message;

      pGravarErro(True,E.Message + '[untFuncoesSimples.CompactarArquivos]', fRetornaStack);

      If Assigned(Zip) Then
      Begin
        Zip.Close();
        FreeAndNil(zip);
      End;

      If FileExists(diretorio + nomeArquivoZip) Then  DeleteFile(PWideChar(diretorio + nomeArquivoZip));
    End;
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

Procedure InicializarComponentesIndy(AOwner: TComponent; Var AIdSMTP: TIdSMTPLog; Var AIdMessage: TIdMessage;
    Var ASSLSocket: TIdSSLIOHandlerSocketOpenSSL; ADadosAutenticacao: TAutenticacaoEmail);
Begin
  AIdSMTP       := TIdSMTPLog.Create(AOwner);
  AIdMessage    := TIdMessage.Create(AOwner);
  ASSLSocket    := TIdSSLIOHandlerSocketOpenSSL.Create(AOwner);

  AIdMessage.Date               := fNow();
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

  AIdSMTP.ReadTimeout := 180000;
  AIdSMTP.ConnectTimeout := 180000;

  AIdSMTP.Host     := ADadosAutenticacao.servidorSmtp;
  AIdSMTP.Port     := ADadosAutenticacao.portaSmtp;
  AIdSMTP.Username := ADadosAutenticacao.login;
  AIdSMTP.Password := ADadosAutenticacao.senha;

  AIdSMTP.OnFailedRecipient := TEnvioEmail.IdSMTPFailedRecipient;

  ASSLSocket.Port                   := AIdSMTP.Port;
  ASSLSocket.DefaultPort            := 0;
  ASSLSocket.Destination            := ':'+IntToStr(ASSLSocket.Port);
  ASSLSocket.MaxLineAction          := maException;
  ASSLSocket.SSLOptions.Mode        := fRetModeSSL;
  ASSLSocket.SSLOptions.Method      := fRetVersaoTLSSSL();
  ASSLSocket.SSLOptions.VerifyMode  := [];
  ASSLSocket.SSLOptions.SSLVersions := [fRetVersaoTLSSSL()];
  ASSLSocket.SSLOptions.VerifyDepth := 0;
  ASSLSocket.ConnectTimeout         := 180000;
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

class function TListaContatosEmail.fEmailExistente(AEmail: String; Out ASeqCon: String): Boolean;
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
    blnTransacaoInternaMetodo: boolean;

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

        blnTransacaoInternaMetodo := False;
        if not fInTransaction then
        begin
          blnTransacaoInternaMetodo := True;
          fStartTransaction;
        end;

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

        if blnTransacaoInternaMetodo and fInTransaction then
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

class procedure TListaContatosEmail.pGravarContato(AEmail, strIncCon: String);
Var
  qryTemp   : TUniQuery;
  strSQL,
  strSeqCon,
  strAutInc : String;
  blnTransacaoInternaMetodo : Boolean;
  
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

  If (fEmptyStr(AEmail)) Or (TListaContatosEmail.fEmailExistente(AEmail, strSeqCon)) Then
    Exit;

  Try
    qryTemp := fCriaQuery(Nil);
    Try
      blnTransacaoInternaMetodo := False;

      if not fInTransaction() then
      begin
        blnTransacaoInternaMetodo := True;
        fStartTransaction();
      End;

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

      if blnTransacaoInternaMetodo and fInTransaction then
         fCommit();

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TListaContatosEmail.pGravarContato', '');
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

  FreeAndNil(FListaEmails);
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

          If TAutenticacaoEmail.ConnectIdIMAP(IdIMAP,AEmailsSinc.DadosAutenticacao.usuario, AEmailsSinc.DadosAutenticacao) Then
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
  pLog('Start TThreadSincronizaEmails.Execute');
  FTerminou := False;
  For EmailSinc In FListaEmails Do
  begin
    FErroNoEnvio := False;

    EmailSinc.CriarImagemAssinatura;

    Try
      GravarPastaEnviados(EmailSinc);
      TEnvioEmail.GravarZipMensagem(EmailSinc.IdMessage, EmailSinc.DiretorioEmail, EmailSinc.NomeArquivoZip);
    Except
      FErroNoEnvio := True;
    end;

    EmailSinc.ApagarImagemAssinatura;
  end;

  FTerminou := True;
  pLog('End TThreadSincronizaEmails.Execute');
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

destructor TListaThreadsSincronizaEmails.Destroy;
begin
  FreeAndNil(FListaThreads);
  inherited;
end;

function TListaThreadsSincronizaEmails.fConcluiuSincronizacao;
begin
  Result :=  FListaThreads.Count = 0;
end;

function TListaThreadsSincronizaEmails.fGetQuantidadeThreads: integer;
begin
  Result := FListaThreads.Count;
end;

{ TEmailsSinc }

procedure TEmailsSinc.ApagarImagemAssinatura;
begin
  if FileExists(Self.FCaminhoImagemAssinaturaEmail) then
    SysUtils.DeleteFile(Self.FCaminhoImagemAssinaturaEmail);
end;

procedure TEmailsSinc.CriarImagemAssinatura;
var
  mmsImgAss: TFileStream;
begin
  if Assigned(Self.dadosAutenticacao.imagemAssinatura) then
  begin
    if not FileExists(FCaminhoImagemAssinaturaEmail) then
    begin
      mmsImgAss := TFileStream.Create(Self.FCaminhoImagemAssinaturaEmail, fmCreate);

      try
        Self.dadosAutenticacao.imagemAssinatura.SaveToStream(mmsImgAss);
      finally
        mmsImgAss.Free();
      end;
    end;
  end;
end;

{ TIdSMTPLog }

constructor TIdSMTPLog.Create(AOwner: TComponent);
begin
  inherited;
  FEmailError := '';
end;

{ TZipFileHelper }

procedure TZipFileHelper.Delete(FileName: string);
var
  i, j: Integer;
  StartOffset, EndOffset, Size: UInt32;
  Header: TZipHeader;
  Buf: TBytes;
begin
  i := IndexOf(FileName);
  if i <> -1 then begin
    // Find extents for existing file in the file stream
    StartOffset := Self.FFiles[i].LocalHeaderOffset;
    EndOffset := Self.FEndFileData;
    for j := 0 to Self.FFiles.Count - 1 do begin
      if (Self.FFiles[j].LocalHeaderOffset > StartOffset) and
         (Self.FFiles[j].LocalHeaderOffset <= EndOffset) then
        EndOffset := Self.FFiles[j].LocalHeaderOffset;
    end;
    Size := EndOffset - StartOffset;
    // Update central directory header data
    Self.FFiles.Delete(i);
    for j := 0 to Self.FFiles.Count - 1 do begin
      Header := Self.FFiles[j];
      if Header.LocalHeaderOffset > StartOffset then begin
        Header.LocalHeaderOffset := Header.LocalHeaderOffset - Size;
        Self.FFiles[j] := Header;
      end;
    end;
    // Remove existing file stream
    SetLength(Buf, Self.FEndFileData - EndOffset);
    Self.FStream.Position := EndOffset;
    if Length(Buf) > 0 then
      Self.FStream.Read(Buf[0], Length(Buf));
    Self.FStream.Size := StartOffset;
    if Length(Buf) > 0 then
      Self.FStream.Write(Buf[0], Length(Buf));
    Self.FEndFileData := Self.FStream.Position;
  end;
end;

initialization

finalization
  If Assigned(TListaThreadsSincronizaEmails.FInstance) Then
    FreeAndNil(TListaThreadsSincronizaEmails.FInstance)

end.
