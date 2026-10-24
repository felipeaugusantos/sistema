unit untInterfaceTefCitel;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  UniClientDataSet,
{$ENDIF}
  System.Classes, System.Generics.Collections;

const
  CARTEIRA_DIGITAL_ESTORNO = 123;
  CARTEIRA_DIGITAL         = 122;
  OPCAO_CLISITEF           = 'S';
  OPCAO_NCR                = 'T';
  OPCAO_REDE_FLEX_POS      = 'R';
  SEPARADORBLOCONCR        = '.,.' ;
  DEBITO_AVISTA            = '0';
  DEBITO_PREDATADO         = '1';
  TRANSACAO_INICIADA       = 'TRN INICIADA' ;
  TRANSACAO_CANCELADA      = 'TRN CANCEL' ;
  CANCELAMENTO_INICIADO    = 'CNC INICIADO';
  CANCELAMENTO_CANCELADO   = 'CNC CANCEL';
  TRANSACAO_PENDENTE       = 'PENDENTE' ;
  CODIGO_VERO_SCOPE        = '00099' ;
  TELA_CLISITEF            = 'S';
  TELA_NCR                 = 'T';
  NCR_OPERACAO_CARTEIRA_DIGITAL_PIX = 122;

  INFO_20_CANCELAMENTO  = 20;
  INFO_21_CANCELAMENTO  = 21;
  INFO_23_CANCELAMENTO  = 23;
  INFO_30_CANCELAMENTO  = 30;
  INFO_34_CANCELAMENTO  = 34;
  INFO_131_CANCELAMENTO = 131;
  INFO_999_CANCELAMENTO = -999;

type
  TStatusPinPad = (sppOperacional, sppNaoExiste, sppBibliotecaDeAcessoNaoEncontrada, sppNull);

  TInfoTraDoc = record
    NumDoc: String ;
    DtaTra: TDateTime ;
    CodEmp: String ;
    NumDup: String ;
    EspDoc: String ;
    Parcel: String ;
    EmpDoc: String ;
  end ;

  TInfoRequestPagamentoPix = record
    calendario_expiracao: Integer;
    devedor_cnpj: String;
    devedor_nome: String;
    valor_original: Double;
    chave: String;
    solicitacaoPagador: String;
  end;

  TInfoResponsePagamentoPix = record
    calendario_criacao: String;
    calendario_expiracao: Integer;
    status: String;
    txid: String;
    revisao: Integer;
    location: String;
    valor_original: Double;
    valor_modalidadeAlteracao: Integer;
    chave: String;
    solicitacaoPagador: String;
    brcode: String;
  end;

  TInfoResponseDevolucaoPix = record
    id: String;
    rtrId: String;
    valor: String;
    horario_solicitacao: String;
    horario_liquidacao: String;
    status: String;
    motivo: String;
  end;

  TInfoDadosPagamentoPix = record
    endToEndId: String;
    txid: String;
    valor: Double;
    horario: String;
    nomePagador: String;
    pagador_cpf: String;
    controle: String;
  end;

  TArrayInfoTraDoc = array of TInfoTraDoc ;

  TInfoPix = record
    CodigoRede: String;
    NomeRede: String;
    CodigoBandeira: String;
    NomeBandeira: String;
  end;

  TArrayInfoPix = array of TInfoPix;

type
  IDadosValidaParcelas = interface
    ['{51657353-DE3F-4C9C-B5D9-C2F0373890C2}']
    function F11(const AValue: Boolean): IDadosValidaParcelas ; overload ;
    function F11: Boolean ; overload ;
    function QtdNeg(const AValue: Integer): IDadosValidaParcelas ; overload ;
    function QtdNeg: Integer ; Overload ;
    function CodFin(const AValue: String): IDadosValidaParcelas ; overload ;
    function CodFin: String ; overload ;
    function fTravouQtdParcelaInformada(const AParcInformada: Integer): Boolean ;
    function fTravarQuantidadeNegociada: Boolean ;
    function fObrigarQuantidadeNegociada: Boolean;
  end ;

  IDadosAdicionaisTefTra = interface
    ['{DD709A1F-EB27-4FAA-A2E5-BD93C2D926AA}']
    function PixS_N(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function PixS_N: String ; overload ;
    function OpcDoc(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function OpcDoc: String ; overload ;
    function ArrDocs(const AarrValor: TArrayInfoTraDoc): IDadosAdicionaisTefTra ; overload ;
    function ArrDocs: TArrayInfoTraDoc ; overload ;
    function OpeRcx(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function OpeRcx: String ; overload ;
    function NumDoc(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function NumDoc: String ; overload ;
    function Valor(const AfltValor: Double): IDadosAdicionaisTefTra ; overload ;
    function Valor: Double ; overload ;
    function Operacao(const AintValor: Integer): IDadosAdicionaisTefTra ; overload ;
    function Operacao: Integer ; overload ;
    function Modalidade(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function Modalidade: String ; overload ;
    function QtdParcelas(const AintValor: Integer): IDadosAdicionaisTefTra ; overload ;
    function QtdParcelas: Integer ; overload ;
    function Status(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function Status: String ; overload ;
    function PrePago(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function PrePago: String ; overload ;
    function ParcAdm(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function ParcAdm: String ; overload ;
  end ;

type
  TRecRespostaPassarCartao = record
    sts : integer;
  end;

type
  TStatusTEFCitel = Class(TInterfacedObject)
    strStatus: String;
    strMensagem: String;
  End;

type
  TDadosCartao = Class(TInterfacedObject)
    strCupom : TStringList;
    strValor : String;
    strBandeira : String;
    strNomeRede : String;
    strAutorizacao : String;
    strNSU : String;
    strTipoTransacao : String;
    strQuantidadeParcelas : String;
    strNumeroControle : String;
    strConteudoCupom: String;
    strConteudoViaCliente: String;
    strConteudoViaLojista: String;
    strDataHoraTrans: String;
    blnCancelado : Boolean;
    strChaPix : String;
    strPixS_N : String;
    strCodigoCarteiraDigital: String;
    intPrimeiroVencimento: Integer;
    intPeriodo: Integer;
    strControle: String;
    strTipDeb: Char ;
    strCodigoEstabeleci: String;
    strPrePago: String;
    strParcAdm: String;
    strModoEntrada: String;
    strTipoOperacao: String;
    strXIdPix: String;
    strCampoReferenciaPix: String;
    strQrCodePix: String;
    strRequestPagamentoPix: String;
    strResponsePagamentoPix: String;
    strDadosPagamentoPix: String;
    strResponseDevolucaoPix: String;
  End;

type
  TTipoIntervalo = (tiTransacao, tiAproximarInserir, tiAvistaPrazo, tiParcela, tiSenha, tiRetirarCartao);

type
  IIntervalo = interface
    ['{959CB460-FB2D-4D3C-8B9B-D8EA2A1244E5}']
    function Inicio: TDateTime; overload;
    function Inicio(AValue: TDateTime): IIntervalo; overload;
    function Fim: TDateTime; overload;
    function Fim(AValue: TDateTime): IIntervalo; overload;
    function Tipo: TTipoIntervalo; overload;
    function Tipo(AValue: TTipoIntervalo): IIntervalo; overload;
  end;

type
  IIntervalosTEF = interface
    ['{B294D232-2594-462A-A114-41755FB3CB43}']
    function Transacao: IIntervalo;
    function Espera: TList<IIntervalo>;
  End;

type
  IRetornoTEFCitel = Interface
    ['{CC8D410E-FE29-42F1-B3EE-F6991EB4556A}']
    function GetCupom(): TStringList;
    function GetDadosCartao(): TDadosCartao;
    function GetStatusTEF(): TStatusTEFCitel;
    property Cupom: TStringList read GetCupom;
    property DadosCartao: TDadosCartao read GetDadosCartao;
    property StatusTEF: TStatusTEFCitel read GetStatusTEF;
    function DadosAdicionaisTefTra(): IDadosAdicionaisTefTra ; overload ;
    function DadosAdicionaisTefTra(AValue: IDadosAdicionaisTefTra): IRetornoTEFCitel ; overload ;
    function Intervalos: IIntervalosTEF; overload;
    function Intervalos(AValue: IIntervalosTEF): IRetornoTEFCitel ; overload ;
  End;

type
  IProcessaRetornoTEFCitel = Interface
    ['{3104B988-F55A-4E12-B073-D79634ABF17A}']
    procedure ProcessarCartao(strCupom : TStringList;
                              strValor : String;
                              strBandeira : String;
                              strNomeRede : String;
                              strAutorizacao : String;
                              strNSU : String;
                              strTipoTransacao : String;
                              strQuantidadeParcelas : String;
                              strNumeroControle : String;
                              strConteudoViaCliente : String;
                              strConteudoViaLojista : String;
                              strDataHoraTrans: String;
                              strChaPix: String;
                              strPixS_N: String;
                              strCodigoCarteiraDigital: String;
                              intPrimeiroVencimento: Integer;
                              intPeriodo: Integer;
                              strControle: String;
                              strTipDeb: Char;
                              objDadosAdicionaisTefTra: IDadosAdicionaisTefTra;
                              strCodigoEstabeleci: string;
                              strPrePago: String;
                              objIntervalos: IIntervalosTEF;
                              strParcAdm: String;
                              strModoEntrada: String;
                              strTipoOperacao: String;
                              strXIdPix: String = '';
                              strCampoReferenciaPix: String = '';
                              strQrCodePix: String = '';
                              strRequestPagamentoPix: String = '';
                              strResponsePagamentoPix: String = '';
                              strDadosPagamentoPix: String = '';
                              strResponseDevolucaoPix: String = '');

    procedure ProcessarStatus(strStatus,
                              strMensagem : String);
    procedure ProcessarCupom(strConteudo: TStringList);
    procedure LimparRetorno;
  End;

type
  IObserverTEFCitel = interface
    ['{7E0D2664-5243-400B-AAFE-EDC8A2AA8B3F}']
    procedure AtualizaTefCitel(Resposta: IRetornoTEFCitel);
  End;

type
  ISubjectTEFCitel = interface
    ['{22BABCE4-84F4-4233-A3ED-EDF66CA3F1BE}']
    procedure AdicionaObserver(AObserver: IObserverTEFCitel);
    procedure RemoveObserver(AObserver: IObserverTEFCitel);
    procedure NotificaObservers();
  End;

type
  TAntesTefCartaoEvent = function: boolean of object ;
  TDepoisTefCartaoEvent = procedure(AobjRetorno: IRetornoTEFCitel) of object ;
  TDepoisFinalizarTransacaoEvent = procedure of object ;
  TSucessoTefCartaoEvent = procedure(var ADadosTransacao: IRetornoTEFCitel) of object ;
  TprocGravaLogErr = procedure(const AblnGravarErro:Boolean; AstrMensagemErro:String; AstrRelatorio: String=''; AstrUltSQL: String='') of object ;

type
  ITefCitel = interface(ISubjectTefCitel)
  ['{1A4638C2-80BB-4456-A4EB-9A921F983DF2}']
    function fConfiguraTefCitel(strEnderecoIp: PAnsiChar;
                                strCodigoLoja: PAnsiChar;
                                strNumTerminal: PAnsiChar;
                                strConfigResultado: Smallint;
                                strParametrosAdicionais: PAnsiChar;
                                blnSomenteCarregarLib: Boolean = False) : Integer;

    function fPassarCartao(intOperacao: Integer;
                           intQtdParcelas: Integer;
                           strModalidade: String;
                           strNumDoc: String;
                           fltValor: Double;
                           strCodOperador: String;
                           blnPagueFacil : Boolean;
                           strCodigoCarteiraDigital : string = '';
                           strJsonInfoAdicPix: String = '') : IRetornoTEFCitel;

    procedure fFinalizarTransacao(Confirma: Boolean;
                                  DataStr,
                                  HoraStr,
                                  DocumentoVinculado,
                                  ParamAdic: AnsiString);

    function fCancelaTransacaoTerminal(intFuncao: Integer;
                                       strCodOpe: AnsiString;
                                         dtaData: TDate;
                                         hraHora: TTime;
                                          numdoc: AnsiString;
                                        fltValor: Double;
                                   strModalidade: String;
                                   strCodigoCarteiraDigital : string;
                                   strModoEntrada: string) : IRetornoTEFCitel;

    function fConsultaTransacoesPendentesTerminal : TUniClientDataSet;

    function fReimpressao(intFuncao: Integer;
                          strNumDoc: AnsiString;
                          strDtaTra: TDate;
                          strCodOpe: AnsiString;
                          fltValTra: Double) : IRetornoTEFCitel;

    procedure pSair(blnSair : Boolean);

  	procedure pInfo34(fltValTra : Double);
    procedure pInfo21(strModalidade : String);
    procedure pInfo30(strNumDoc : String; dtaData : TDate; intQtdParc : Integer);
    function fObtemDadoPinPadDireto(AintTipoDocumento: Integer;
                                    AstrChaveAcesso: AnsiString;
                                    AstrIdentificador: AnsiString): AnsiString;
    procedure pSetPath(const AstrPath: String) ;
    function pRetornaLog: TStringList;
    procedure pInfo30DebitoPreDatado(const AdtaDataPre: TDate);
    procedure pInfo30DebitoCredito1Minuto(const AintParcelaCdc: Integer);
    procedure pInfo30DebitoParcelado(const AintQtdParc, AintIntervaloParc, AintPrimParcAvista: Integer; const AdtaPrimParcela: TDate) ;
    procedure pSetValueAntesPassarCartao(const AValue: TAntesTefCartaoEvent) ;
    procedure pSetValueDepoisPassarCartao(const AValue: TDepoisTefCartaoEvent) ;
    procedure pSetValueDepoisFinalizarTransacao(const AValue: TDepoisFinalizarTransacaoEvent) ;
    function fGetValueAntesPassarCartao: TAntesTefCartaoEvent ;
    function fGetValueDepoisPassarCartao: TDepoisTefCartaoEvent ;
    function fGetValueDepoisFinalizarTransacao: TDepoisFinalizarTransacaoEvent ;
    function fGetValueAntesCancelarTransacao: TAntesTefCartaoEvent ;
    function fGetValueDepoisCancelarTransacao: TDepoisTefCartaoEvent ;
    procedure pSetValueAntesCancelarTransacao(const AValue: TAntesTefCartaoEvent) ;
    procedure pSetValueDepoisCancelarTransacao(const AValue: TDepoisTefCartaoEvent) ;
    function fGetValueAntesReimpressao: TAntesTefCartaoEvent ;
    function fGetValueDepoisReimpressao: TDepoisTefCartaoEvent ;
    procedure pSetValueAntesReimpressao(const AValue: TAntesTefCartaoEvent) ;
    procedure pSetValueDepoisReimpressao(const AValue: TDepoisTefCartaoEvent) ;
    function fVerificaPresencaPinPad: TStatusPinPad;
    property AntesPassarCartao: TAntesTefCartaoEvent read fGetValueAntesPassarCartao write pSetValueAntesPassarCartao ;
    property DepoisPassarCartao: TDepoisTefCartaoEvent read fGetValueDepoisPassarCartao write pSetValueDepoisPassarCartao ;
    property DepoisFinalizarTransacao: TDepoisFinalizarTransacaoEvent read fGetValueDepoisFinalizarTransacao write pSetValueDepoisFinalizarTransacao ;
    property AntesCancelarTransacao: TAntesTefCartaoEvent read fGetValueAntesCancelarTransacao write pSetValueAntesCancelarTransacao ;
    property DepoisCancelarTransacao: TDepoisTefCartaoEvent read fGetValueDepoisCancelarTransacao write pSetValueDepoisCancelarTransacao ;
    property AntesReimpressao: TAntesTefCartaoEvent read fGetValueAntesReimpressao write pSetValueAntesReimpressao ;
    property DepoisReimpressao: TDepoisTefCartaoEvent read fGetValueDepoisReimpressao write pSetValueDepoisReimpressao ;
    procedure pSetValueSucessoTefCartao(const AValue: TSucessoTefCartaoEvent) ;
    procedure pSetDadosAdicionaisTefTra(const aValue: IDadosAdicionaisTefTra) ;
    function fGetDadosAdicionaisTefTra: IDadosAdicionaisTefTra ;
    function fGetValueSucessoTefCartao: TSucessoTefCartaoEvent ;
    property SucessoTefCartao: TSucessoTefCartaoEvent read fGetValueSucessoTefCartao write pSetValueSucessoTefCartao ;
    procedure pSetLogErr(AProc: TprocGravaLogErr) ;
    function fObtemVersao: string;
    procedure AddInfo(const AMacAdress, AIPNumber, AUserName, AComputerName, ATerminalTEF: string);
    function fInfoPixCadastro(out AListaInfo: TArrayInfoPix): Longint;
    procedure pEnviarQrCode(const AstrDiretorio, AstrArquivo: String) ;
    procedure pLimpaQrCode(const AstrMensagem: AnsiString = '') ;
    { Conteudo do libTefCitelErro.log de QUEM REALMENTE carregou a DLL do TEF
      (Req. 456190, 2026-09-20). Existe por causa do DVC: com CFG_TEFDVC='S'
      a DLL roda na ESTACAO e e la que o arquivo e escrito - lê-lo do
      diretorio do autcom.exe mostrava ao operador um arquivo velho, de outra
      maquina, ou nenhum. Nas implementacoes locais devolve o proprio
      arquivo; na TTefCitelDvc vira RPC. String vazia = nao ha log.

      DECLARADO NO FIM DA INTERFACE, E ISSO IMPORTA (apontamento do DelphAI,
      2026-09-22): metodo de interface ocupa slot ordinal na VMT. Inserir no
      meio desloca em +1 todos os posteriores, e um consumidor nao recompilado
      passaria a chamar a rotina errada SEM erro - o pior desfecho. Nesta base
      o risco nao e teorico: a Fase 6 envia libTefCitel.dll para a estacao como
      pacote PROPRIO, separado do TefEstacaoService.exe, entao os dois podem
      divergir por uma carga. Acrescentar no fim e ABI-seguro para tudo que ja
      existia. **Metodo novo em ITefCitel vai SEMPRE no fim.** }
    function fConteudoLogErro: String;
  end;

type
  ITefCitelV2 = interface(ITefCitel)
  ['{FA29CA12-96A8-48F6-BB58-AC90A477678C}']
    function fTraduzirErro(const AintSts: Integer): String;
    function fObtemInfoPinPad: String;
end;

type
  { Req. 470363 - so o TEF DVC implementa: no classico a confirmacao roda no
    proprio processo e nao tem como "nao chegar". Interface separada, e nao
    metodo novo em ITefCitel, para nao obrigar TTefCitelNCR/TTefCitel a
    implementar nada; quem nao a tem segue o caminho de sempre. }
  ITefCitelFinalizacao = interface
  ['{00CE5860-2A09-4D03-A906-B829D4D844D2}']
    { True = a ultima fFinalizarTransacao nao chegou a estacao que aprovou a
      transacao (canal caiu, ou o servico reiniciou desde a aprovacao). }
    function fUltimaFinalizacaoNaoRealizada: Boolean;
    { True = a DLL guardou a confirmacao e a reenvia antes da proxima chamada
      ao TEF, quando a conexao voltar (so na queda de canal, nunca no reinicio
      do servico). }
    function fUltimaFinalizacaoSeraReenviada: Boolean;
    { Valor e Controle da transacao guardada para reenvio, ditos ao operador
      se o reenvio for descartado (ex.: 'R$ 3,00 (Controle 10608693013)'). }
    procedure pDescreveFinalizacaoPendente(const AstrDescricao: String);
  end;

implementation

end.
