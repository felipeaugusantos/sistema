unit untTefCitelNCR;

interface

uses untInterfaceTefCitel, Uni, UniClientDataSet, Data.DB, Classes, SysUtils,
     System.Generics.Collections, untTefCitelComum, untScopeNCR,
     untTefCitelIntervalos, System.JSON;

type
  TTefCitelNCR = class(TInterfacedObject, ITefCitel, ISubjectTEFCitel, ITefCitelV2)
  private
    FblnEmTransacao: Boolean;
    FModalidadeInterno: String;
    FNumeroControleCancelamentoPix: String;
    FInicioCancelamentoPix: TDateTime;
    FintOperacao: Integer ;
    FstrControle: String ;
    FPathDLL: string;
    FObservers: TList<IObserverTEFCitel>;
    FRetorno : IRetornoTEFCitel;
    FProcessaRetorno: IProcessaRetornoTEFCitel;
    FAntesPassarCartao: TAntesTefCartaoEvent ;
    FDepoisPassarCartao: TDepoisTefCartaoEvent ;
    FDepoisFinalizarTransacao: TDepoisFinalizarTransacaoEvent ;
    FAntesCancelarTransacao: TAntesTefCartaoEvent ;
    FDepoisCancelarTransacao: TDepoisTefCartaoEvent ;
    FAntesReimpressao: TAntesTefCartaoEvent ;
    FDepoisReimpressao: TDepoisTefCartaoEvent ;
    FSucessoTefCartao: TSucessoTefCartaoEvent ;
    FrecCartao: TCartao;
    FrecInfoReq: TInfoRequisicao;
    FblnSaiu : boolean;
    FblnMultCartoes: Boolean;
    FintContinua : Integer ;
    FLog : TStringList;
    FblnDebitoBanrisul: Boolean ;
    FblnTemParcAdm: Boolean;
    FblnDllCarregada: Boolean;
    FlstControleMensagemOperador: TStringList ;
    FblnControleMensagemOperador: Boolean ;
    FlstMenuRetornado: TStringList ;
    FblnPreDatado: Boolean ;
    FobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra ;
    FstrMensagemOperadorAguardar: String ;
    FdictMensagensDePara: TDictionary<String, String> ;
    FdictValorMinimoAdquirente: TDictionary<Word, Double> ;
    FRegistraIntervalos: TRegistraIntervalos;
    FModoEntrada: String;
    FProcLogErr: TprocGravaLogErr;
    FTefInfo: TTefInfo;
    FSolicitacaoPagadorPix: String;
    FNomeDevedorPix: String;
    FCnpjDevedorPix: String;
    FValorPix: String;
    FstrMensagemErro: String;
    FstrInfoPinPad: String;
    FblnInfoPinPadJaConsultada: Boolean;

    function fIniciaTransacaoTEF(const AintOpcao: Integer; const AfltValor: Double; const AstrDocVinculado: String; const AInfoCarteiraDigitalPix: String): LongInt;
    function fValorNumericoNcr(const AfltValor: Double): String ;
    function fFinalizaTransacaoTEF: LongInt ;
    procedure pEncerraTransacao(const AintErro: LongInt);
    function fObtemCupons(PColeta: TParam_Coleta): Boolean;
    procedure pAtualizMsg(const AstrMensagem: String) ; overload ;
    procedure pAtualizMsg(AColeta: TColeta_Msg) ; overload ;
    procedure pNotificaQrCodePix(const AQrCode: String);
    function pAtualizaMsgOperadorCliente(AColeta: TParam_Coleta; const AintTipoColeta: Integer): String ;
    function fAnaliseParalela(bAction: Byte; pRet: PByte): string;
    procedure pUsuarioEncerraTransacao;
    function fMostraOpcoesCartaoCredito(const AintTipoColeta: Integer): Boolean ;
    function fTemParcelasCredito(const AintTipoColeta: Integer): Boolean ;
    function fApareceuPerguntaParaCancelarTransacao(const AintTipoColeta: Integer): Boolean ;
    function fTemParcelamentoAdmLoja(const AintTipoColeta: Integer): Boolean ;
    function fOpcaoAdmLojaSelecionada: String ;
    function fReimpressaoDocumentoSeleciona(const AintTipoColeta: Integer): String ;
    procedure pMsgOperadorEAguardar(const AintTipoColeta: Integer; AColeta: TParam_Coleta) ;
    function fOpcaoCartaoSelecionada: String ;
    function fCancelaOperacaoSelecionada: String ;
    function fParcelaCartaoSeleciona: String ;
    function fBuscaDadosTransacao: Boolean ;
    function fBuscaDadosTransacaoEmAndamento: Boolean ;
    function fTrataPrePago(const AValorScope: String): String ;
    Function fAjustaNSUVero(const AstrNsu, AstrRede: String): String ;
    function fRetornaTipoTransacao: String ;
    function fMontaAtributoAplicacao(const AstrValor: String): String ;
    function fEhOperacaoCancelamentoCartao: Boolean ;
    function fEhDebitoBanrisul(const AstrMensagem: String): Boolean ;
    function fEhDebito(AColeta: TParam_Coleta): Boolean ;
    function fEhOpcoesPagamentoBanrisul(const AintTipoColeta: Integer): Boolean ;
    function fOpcoesPagamentoBanrisulSelecionada(const AintTipoColeta: Integer): String ;
    function fDebitoBanrisul: String ;
    function fDebito(const AstrMensagem: String): String ;
    function fEhOperacaoReimpressaoCartao: Boolean ;
    function fCancelamentoDocumentoSeleciona(const AintTipoColeta: Integer): String ;
    procedure pIncluiLinhaLog(const AstrValor: String) ;

    function fEscolheuParcAdmMasTefNaoTem(const AintTipoColeta: Integer): Boolean ;

    procedure pAtribuiValorStringComCondicao(const AblnCondicao: Boolean; var AstrVariavel: String; const AstrValor: String);
    procedure pAvisaOkClient ;
    procedure pIniciaColetaCartao(var AbyteAux: Byte; var AintAux: Integer; var AstrBufEntrAux: String);
    procedure pTrataMensagemRetornadaScope(const AbyteAux: Byte;
                                           const AintRet: Integer;
                                           AColeta: TParam_Coleta;
                                           var AstrBufEntrAux: String;
                                           var AintAux: Integer ) ;
    procedure pColetaCartaoAndamento(const AstrBufEntrAux: String;
                                     var AbyteAux: Byte;
                                     var AintRet: Integer) ;
    function fFinalProcessamento(var AintRet, AintAux: Integer;
                                 AColetaMsg: TColeta_Msg;
                                 var AblnCancelado: Boolean;
                                 var AstrBufEntrAux: String): TEnumStatus ;
    procedure pDepoisEvento(FDepois: TDepoisTefCartaoEvent; FRetorno: IRetornoTEFCitel);
    procedure pTrataParametros(const AstrParametros: String; var AintComPort: integer; var AstrMsgPP: String) ;
    function fTrataPortaCom(const AstrComPort: String): Integer ;
    procedure pFechaSessaoMultCartao ;
    function fIntervaloDiasParcelasBanrisul: String ;
    procedure pForcaProcessoCancelamento(const AintTipoColeta: Integer);
    function fFormataMsgPP(const AstrMsg: String): String ;
    procedure pProcessamentoEmAndamento ;
    function fTrataDataBanrisul(const AdtaDataColeta: TDateTime): String ;
    function fAjustaMemsagemOperador(AColeta: TParam_Coleta): String ; overload ;
    function fAjustaMemsagemOperador(AColeta: TColeta_Msg): String ; overload ;
    function fAjustaMemsagemOperadorInterno(const AstrValorComparar, AstrValorTrocar: String): String ;
    function fEhMensagemInserirCartao(const AstrMensagem: String): Boolean ;
    function fTrataMensagemInserirCartao(const AstrMensagem: String): String ;
    function fEscolheNsu(const ArecCartao: TCartao; AstrNsuFepas: string): string ;
    function fTrataMenuRetornado(AColeta: TParam_Coleta; const AintTipoColeta: Integer): String ;
    function fTrataMenuDebitoNormal(): String ;
    function fEhMenuRetornado(const AintTipoColeta: Integer): Boolean ;
    function fVaiExtenderTempoPix(const AintTipoColeta: Integer): Boolean ;
    procedure pTrataDataPreDatadaCupomBanrisul(const AstrCupom: String) ;
    function fAjustaMensagemOperador(const AstrMensagem: String): String ;
    procedure pCarregaMensagensDePara ;
    procedure pCarregaValoresMinimosAdquirente ;
    function fEhValorAbaixoDoMinimoAdquirente(const ACodigoRede: Word;
                                              const AfltValor: Double;
                                              out AfltMinimo: Double): Boolean ;
    function fMsgRetira(AstrMsg: string): Boolean;
    function fAjustaMsgModoEntrada(AstrMsg: string): string;
    function fMensagemInfo: string;
    procedure pLoga(const AStrMsg: String);
    procedure pExtraiDadosCarteiraDigitalPix(const ADados: String; out ACodigoBandeira, ACodigoRede, ACodigoServico: Word);
    function fInfoPixCadastroInterno(out AListaInfo: TArrayInfoPix): Longint;
    function fGerarJsonRequestPagamentoPix(const ADados: TInfoRequestPagamentoPix): String;
    function fGerarJsonResponsePagamentoPix(const ADados: TInfoResponsePagamentoPix; const ADadosPgt: TInfoDadosPagamentoPix): String;
    function fGerarJsonDadosPagamentoPix(const ADados: TInfoDadosPagamentoPix): TJSONArray;
    function fGerarJsonResponseDevolucaoPix(const ADados: TInfoResponseDevolucaoPix): String;
    procedure pExtraiDadosAdicionaisPix(const AJson: String);
    function fValidaRetornoScopePPMMFileDelete(const AintRetorno: LongInt; Var AstrMensagem: String): Boolean ;
    function fDeletaArquivoNoPinPad(const AstrArquivo: AnsiString): Boolean;
    procedure pAbortarUltimoComando;
    function fConsultarInfoHardwarePinPad: String;
    function fFormataInfoPinPad(const ABuffer; const ABufferLen: Integer): String;
    function fAbrirPortaPinPad(var AblnFecharPortaPP: Boolean): Boolean;
    function fLerInfoHardware(var ABuffer: array of AnsiChar): Boolean;
    function fTamanhoMinimoBufferInfoHW: Integer;
  public
    procedure AdicionaObserver(AObserver: IObserverTEFCitel);
    procedure RemoveObserver(AObserver: IObserverTEFCitel);
    procedure NotificaObservers();

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
    function fObtemVersao: string;
    procedure pSetPath(const AstrPath: String) ;
    function pRetornaLog: TStringList;
    function fConteudoLogErro: String;
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

    constructor Create;
    destructor Destroy; override;

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
    function fGetValueSucessoTefCartao: TSucessoTefCartaoEvent ;
    procedure pSetValueSucessoTefCartao(const AValue: TSucessoTefCartaoEvent) ;
    property SucessoTefCartao: TSucessoTefCartaoEvent read fGetValueSucessoTefCartao write pSetValueSucessoTefCartao ;
    procedure pSetDadosAdicionaisTefTra(const aValue: IDadosAdicionaisTefTra) ;
    function fGetDadosAdicionaisTefTra: IDadosAdicionaisTefTra ;
    procedure pSetLogErr(AProc: TprocGravaLogErr) ;
    procedure AddInfo(const AMacAdress, AIPNumber, AUserName, AComputerName, ATerminalTEF: string);
    function fInfoPixCadastro(out AListaInfo: TArrayInfoPix): Longint;
    procedure pEnviarQrCode(const AstrDiretorio, AstrArquivo: String) ;
    procedure pLimpaQrCode(const AstrMensagem: AnsiString = '') ;
    function fTraduzirErro(const AintSts: Integer): String ;
    function fObtemInfoPinPad: String;
  end ;

implementation

uses Winapi.Windows, VCL.Forms, DateUtils, Math, strUtils, Types,
  System.AnsiStrings, untFormatarMensagemErro;

type
  TCampoPinPad = record
    IdComum: Integer;
    RotuloExclusivo: String;
    Offset, Tamanho: Integer;
  end;

const
  CAMPOS_INFO_HW_NCR: array[0..9] of TCampoPinPad = (
    (IdComum: 1; RotuloExclusivo: ''; Offset:   1; Tamanho: 20),
    (IdComum: 2; RotuloExclusivo: ''; Offset:  21; Tamanho: 20),
    (IdComum: 3; RotuloExclusivo: ''; Offset:  41; Tamanho: 20),
    (IdComum: 4; RotuloExclusivo: ''; Offset:  61; Tamanho:  4),
    (IdComum: 5; RotuloExclusivo: ''; Offset:  65; Tamanho: 16),
    (IdComum: 6; RotuloExclusivo: ''; Offset:  81; Tamanho: 20),
    (IdComum: 0; RotuloExclusivo: 'Capacidades do pinpad';                  Offset: 101; Tamanho: 10),
    (IdComum: 0; RotuloExclusivo: 'Visor texto (linhas x colunas)';         Offset: 111; Tamanho:  4),
    (IdComum: 0; RotuloExclusivo: 'Visor grafico (linhas x colunas)';       Offset: 115; Tamanho:  8),
    (IdComum: 0; RotuloExclusivo: 'Tipos de arquivo multimidia suportados'; Offset: 123; Tamanho: 20)
  );

  TAM_BUFFER_INFO_HW_NCR = 256;

function fRotuloCampoPinPad(const ACampo: TCampoPinPad): String;
begin
  if ACampo.IdComum > 0 then
    Result := ROTULOS_INFO_PINPAD_COMUM[ACampo.IdComum]
  else
    Result := ACampo.RotuloExclusivo;
end;

  { TTefCitelNCR }

procedure TTefCitelNCR.AddInfo(const AMacAdress, AIPNumber, AUserName, AComputerName, ATerminalTEF: string);
begin
  FTefInfo.MacAdress := AMacAdress;
  FTefInfo.IPNumber  := AIPNumber;
  FTefInfo.UserName  := AUserName;
  FTefInfo.ComputerName := AComputerName;
  FTefInfo.TerminalTEF := ATerminalTEF;
end;

procedure TTefCitelNCR.AdicionaObserver(AObserver: IObserverTEFCitel);
begin
  FObservers.Add(AObserver);
end;

constructor TTefCitelNCR.Create;
begin
  FblnEmTransacao := False;
  FdictMensagensDePara := TDictionary<String, String>.Create();
  pCarregaMensagensDePara ;

  FdictValorMinimoAdquirente := TDictionary<Word, Double>.Create();
  pCarregaValoresMinimosAdquirente;

  FstrMensagemOperadorAguardar := '' ;
  FblnPreDatado := False ;
  FlstMenuRetornado := TStringList.Create;
  FblnDesligaShowProcessamento := False ;
  FblnDllCarregada := False ;
  FblnTemParcAdm := False ;
  FblnDebitoBanrisul := False ;
  FblnMultCartoes := False ;
  FintOperacao := 0 ;
  FstrControle := '' ;
  FLog := TStringList.Create;

  FAntesPassarCartao        := Nil ;
  FDepoisPassarCartao       := Nil ;
  FDepoisFinalizarTransacao := Nil ;
  FAntesCancelarTransacao   := Nil ;
  FDepoisCancelarTransacao  := Nil ;
  FAntesReimpressao         := Nil ;
  FDepoisReimpressao        := Nil ;
  FSucessoTefCartao         := Nil ;
  FobjDadosAdicionaisTefTra := Nil ;
  FProcLogErr               := Nil ;

  FblnSaiu := False ;
  FintContinua := 0 ;

  FObservers                       := TList<IObserverTEFCitel>.Create;
  FRetorno                         := TRetornoTEFCitel.Create;
  FProcessaRetorno                 := TProcessaRetornoTefCitel.Create(FRetorno);

  FstrEmpresa := '' ;
  FstrFilial  := '' ;
  FstrPdv     := '' ;
  FstrInfoPinPad := '' ;
  FblnInfoPinPadJaConsultada := False;

  FintComPort   := 6 ;
  FstrMsgPinPad := '' ;
  FlstControleMensagemOperador := TStringList.Create ;
  FblnControleMensagemOperador := False ;

  FRegistraIntervalos := TRegistraIntervalos.Create;
  FModoEntrada := '';

  AddInfo(EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr);
  FSolicitacaoPagadorPix := EmptyStr;
  FNomeDevedorPix := EmptyStr;
  FCnpjDevedorPix := EmptyStr;
  FValorPix := EmptyStr;
  FModalidadeInterno := EmptyStr;
  FNumeroControleCancelamentoPix := EmptyStr;
  FInicioCancelamentoPix := 0;
  FstrMensagemErro := EmptyStr;
end;

destructor TTefCitelNCR.Destroy;
begin
  FreeAndNil(FdictMensagensDePara) ;
  FreeAndNil(FdictValorMinimoAdquirente) ;
  FreeAndNil(FLog) ;
  FreeAndNil(FlstMenuRetornado) ;

  if FblnDllCarregada then
    UnLoadDLLFunctions(FPathDLL);

  if Assigned(FObservers) then
    FreeAndNil(FObservers) ;

  if Assigned(FrecCartao.strCupom) then
    FreeAndNil(FrecCartao.strCupom);

  FreeAndNil(FlstControleMensagemOperador) ;

  FreeAndNil(FRegistraIntervalos);

  inherited;
end;

function TTefCitelNCR.fAjustaMemsagemOperador(AColeta: TParam_Coleta): String;
begin
  Result := fAjustaMemsagemOperadorInterno(String(fArrayToString(AColeta.MsgOp2)), String(fArrayToString(AColeta.MsgCl2))) ;
end;

function TTefCitelNCR.fAjustaMemsagemOperador(AColeta: TColeta_Msg): String ;
begin
  Result := fAjustaMemsagemOperadorInterno(String(fArrayToString(AColeta.Op2)), String(fArrayToString(AColeta.Cl2))) ;
end;

function TTefCitelNCR.fAjustaMemsagemOperadorInterno(const AstrValorComparar,
  AstrValorTrocar: String): String;
const
   IMPRIMINDO = 'imprimindo' ;
begin
  Result := AstrValorComparar ;
  if pos(IMPRIMINDO, lowercase(Result)) > 0 then
  begin
    Result := AstrValorTrocar ;
    exit ;
  end ;
  Result := fTrataMensagemInserirCartao(AstrValorComparar) ;
end;

function TTefCitelNCR.fAjustaMensagemOperador(
  const AstrMensagem: String): String;
var
  LstrMsgPara: String ;
  LblnAchou: Boolean ;
begin
  Result := AstrMensagem ;

  LblnAchou := FdictMensagensDePara.TryGetValue(AstrMensagem, LstrMsgPara) ;
  if LblnAchou then
    Result := LstrMsgPara ;

end;

function TTefCitelNCR.fAjustaMsgModoEntrada(AstrMsg: string): string;
begin
  Result := AstrMsg;

  if FModoEntrada.IsEmpty then
    Exit;

  if fTiraCaracEspeciais(Result).ToLower.Contains('aproxime, insira ou passe o cartao') then
  begin
    case FModoEntrada.ToCharArray[0] of
      'C': Result := 'Insira o mesmo cartão na leitora';
      'c': Result := 'Aproxime o mesmo cartão/dispositivo na leitora';
      'M': Result := 'Passe o mesmo cartão na leitora';
    end;
  end;
end;

function TTefCitelNCR.fAjustaNSUVero(const AstrNsu, AstrRede: String): String;
var
  LstrRede: String ;
begin
  Result := AstrNsu ;
  LstrRede := StringOfChar('0',5-Length(AstrRede))+AstrRede ;
  if LstrRede = CODIGO_VERO_SCOPE then
    Result := Copy(AstrNsu, 4, Length(AstrNsu)-3) ;
end;

function TTefCitelNCR.fAnaliseParalela(bAction: Byte; pRet: PByte): string;
var
  bRet: Byte;
begin
  Result := '' ;
  bRet := 0;
  if bAction = 1 then
    bRet := 1
  else
  begin
    //pega a tecla 9 da aplicação
    if (FintContinua = -1) and (FintOperacao<>NCR_OPERACAO_CARTEIRA_DIGITAL_PIX) then
    begin
      bRet := 1 ;
    end
    else
    begin
      bRet := 2;
    end ;
  end ;

  {$WARN UNSAFE_CODE OFF}
  if (pRet <> nil) then
    CopyMemory ( pRet, @bRet, SizeOf (Byte) );
  {$WARN UNSAFE_CODE ON}

end;

function TTefCitelNCR.fApareceuPerguntaParaCancelarTransacao(
  const AintTipoColeta: Integer): Boolean;
begin
  Result := False ;

  if (FintOperacao = NCR_OPERACAO_CARTAO_CREDITO) or
     (fEhOperacaoCancelamentoCartao) or
     (FintOperacao = NCR_OPERACAO_CARTEIRA_DIGITAL_PIX) then
    if AintTipoColeta = NCR_CODIGO_RETORNO_CANCELAR_TRANSACAO then
      Result := True ;

end;

function TTefCitelNCR.fCancelamentoDocumentoSeleciona(
  const AintTipoColeta: Integer): String;
begin
  Result := '' ;

  if AintTipoColeta = NCR_CODIGO_RETORNO_COLETAR_SCOPE then
  begin
    Result := FstrControle ;
  end ;

  if Result <> '' then
    FintSinc := FintSinc or ACAO_PROX ;
end;

function TTefCitelNCR.fCancelaOperacaoSelecionada: String;
begin
  FintSinc := FintSinc or ACAO_PROX;

  Result := '1' ;
end;

function TTefCitelNCR.fCancelaTransacaoTerminal(intFuncao: Integer;
  strCodOpe: AnsiString; dtaData: TDate; hraHora: TTime; numdoc: AnsiString;
  fltValor: Double; strModalidade,
  strCodigoCarteiraDigital: string;
  strModoEntrada: string): IRetornoTEFCitel;
var
  LintRet: LongInt;
  LMensagemErro: String;
begin
  Result := Nil ;
  FintOperacao := intFuncao ;
  FModalidadeInterno := strModalidade;
  FNumeroControleCancelamentoPix := String(numdoc);
  FInicioCancelamentoPix := dtaData + hraHora;
  FblnDesligaShowProcessamento := False ;

  if Assigned(FAntesCancelarTransacao) then
  begin
    if not FAntesCancelarTransacao then
      Exit ;
  end ;

  FlstControleMensagemOperador.Clear ;
  FblnControleMensagemOperador := False ;
  FlstMenuRetornado.Clear ;

  FblnEmTransacao := True;
  FintContinua := 0 ;
  try
    FobjDadosAdicionaisTefTra := Nil ;
    FillChar(FrecInfoReq,SizeOf(FrecInfoReq),#0);
    FrecCartao := Default(TCartao);
    FrecCartao.intPrimeiroVencimento := -1;
    FrecCartao.intPeriodo := 0;
    FrecCartao.strTipDeb := DEBITO_AVISTA ;
    FrecCartao.strPrePago := 'N' ;
    FrecCartao.strParcAdm := 'N' ;
    FrecCartao.strXIdPix := EmptyStr;
    FrecCartao.strCampoReferenciaPix := EmptyStr;
    FrecCartao.strQrCodePix := EmptyStr;
    FrecCartao.strRequestPagamentoPix := EmptyStr;
    FrecCartao.strResponsePagamentoPix := EmptyStr;
    FrecCartao.strDadosPagamentoPix := EmptyStr;
    FrecCartao.strResponseDevolucaoPix := EmptyStr;

    FProcessaRetorno.LimparRetorno ;

    FModoEntrada := strModoEntrada;

    LintRet := AbreSessaoTEF(False, StrToIntDef(strModalidade,0)=CARTEIRA_DIGITAL_ESTORNO) ;
    if LintRet <> SCO_SUCESSO then
    begin
      FechaSessaoTEF(SCO_DESFAZ_TEF);
      LMensagemErro := Concat('Problemas em [AbreSessaoTEF] retorno: ', fTraduzirErro(LintRet));
      pIncluiLinhaLog(LMensagemErro);
      pLoga(LMensagemErro);
      FProcessaRetorno.ProcessarStatus(IntToStr(LintRet), fTraduzirErro(LintRet));
      Self.NotificaObservers();
      Application.ProcessMessages ;
      Exit;
    end ;

    FintSinc := FintSinc and not (ACAO_PROX + ACAO_ANTER + ACAO_CANCELAR +
              BIT6_ON + BIT7_ON + BIT8_ON + BIT9_ON);

    if not Assigned(FRetorno) then
      FRetorno := TRetornoTEFCitel.Create;

    LintRet := fIniciaTransacaoTEF(FintOperacao, fltValor, '', '');

    if LintRet = SCO_SUCESSO then
    begin
      FstrControle := String(numdoc) ;
      LintRet := fFinalizaTransacaoTEF ;
    end
    else
    begin
      LMensagemErro := Concat('Problemas em [fIniciaTransacaoTEF] retorno: ', fTraduzirErro(LintRet));
      pIncluiLinhaLog(LMensagemErro);
      pLoga(LMensagemErro);
      FintSinc := FintSinc or ACAO_PROX;
      FechaSessaoTEF (SCO_CONFIRMA_TEF);
    end ;

    if LintRet <> SCO_SUCESSO then
    begin
      FProcessaRetorno.ProcessarStatus(IntToStr(LintRet), fTraduzirErro(LintRet));
      Self.NotificaObservers();
    end
    else
    begin
      FintSinc := FintSinc or ACAO_PROX;
      FechaSessaoTEF (SCO_CONFIRMA_TEF);
      Result := FRetorno ;
    end ;

  finally
    FModoEntrada := '';
    FblnEmTransacao := False;
    pDepoisEvento(FDepoisCancelarTransacao, Result) ;
  end ;

end;

function TTefCitelNCR.fMensagemInfo: string;
var
  LReturn: TStringList;
begin
  Result := '';
  LReturn := TStringList.Create;
  try
    if FTefInfo.MacAdress <> '' then
      LReturn.Add('MAC address: ' + FTefInfo.MacAdress);

    if FTefInfo.IPNumber <> '' then
      LReturn.Add('IP: ' + FTefInfo.IPNumber);

    if FTefInfo.UserName <> '' then
      LReturn.Add('Usuário: ' + FTefInfo.UserName);

    if FTefInfo.ComputerName <> '' then
      LReturn.Add('Computador: ' + FTefInfo.ComputerName);

    if FTefInfo.TerminalTEF <> '' then
      LReturn.Add('Term. TEF: ' + FTefInfo.TerminalTEF);

    if LReturn.Count > 0 then
      Result := LReturn.CommaText.Replace('"', '');

  finally
    FreeAndNil(LReturn);
  end;
end;

function TTefCitelNCR.fConfiguraTefCitel(strEnderecoIp, strCodigoLoja,
  strNumTerminal: PAnsiChar; strConfigResultado: Smallint;
  strParametrosAdicionais: PAnsiChar;
  blnSomenteCarregarLib: Boolean = False): Integer;
const
  CintMaxTentativasAbreSCOPE = 3;
var
  LstrDLL: String ;
  LstrPath: String ;
  LintTentativas: Integer;
begin
  FstrEmpresa := copy(String(AnsiString(strCodigoLoja)), 1, 4) ;
  FstrFilial  := copy(String(AnsiString(strCodigoLoja)), 5, 4) ;
  FstrPdv     := String(AnsiString(strNumTerminal)) ;

  pTrataParametros(String(AnsiString(strParametrosAdicionais)), FintComPort, FstrMsgPinPad) ;

  LstrPath := ExtractFileDir(Application.ExeName) ;

  if Trim(FPathDLL) = '' then
    FPathDLL := LstrPath ;

  SetDllDirectoryA(PAnsiChar(AnsiString(FPathDLL))) ;
  try
    if not fDLLsExiste(FPathDLL, LstrDLL) then
    begin
      pLoga('Falta DLLs do Scope no diretório da aplicação [' + LstrDLL + ']');
      Result := -3 ;
      exit ;
    end ;

    FblnDllCarregada := fLoadDLLFunctions(FProcLogErr, FPathDLL) ;
  finally
    SetDllDirectoryA(Nil) ;
  end ;

  if FintComPort = 0 then
    FintComPort := fGetPortaComAuto ;

  Result := SCO_SUCESSO ;
  if not blnSomenteCarregarLib then
  begin
    LintTentativas := 0;
    repeat
      Inc(LintTentativas);
      Result := AbreSessaoTEF(True);
      if Result = SCO_SUCESSO then
        Break;
      FechaSessaoTEF(SCO_DESFAZ_TEF);
      if Result <> SCO_ERRO_CARREGAR_PINPAD then
        Break;
    until LintTentativas >= CintMaxTentativasAbreSCOPE;

    if Result <> SCO_SUCESSO then
    begin
      if Result = SCO_ERRO_CARREGAR_PINPAD then
      begin
        Result := -4;
      end
      else
      begin
        pLoga(Concat('Problemas em [AbreSCOPE] retorno: ', fTraduzirErro(Result)));
        Result := -2 ;
      end;
      exit;
    end;

    // Captura as informacoes do pinpad AQUI porque e' a unica janela em que a
    // porta serial esta garantidamente aberta (AbrePINPad foi chamado dentro
    // de AbreSessaoTEF, linha acima). FechaSessaoTEF(1, 1), a seguir, fecha
    // a porta (via FechaSCOPE/FechaPINPad) — mover esta chamada para depois
    // exigiria reabrir a porta do zero. Cache (FblnInfoPinPadJaConsultada)
    // garante que isso roda uma unica vez por instancia.
    fObtemInfoPinPad;

    FechaSessaoTEF(1, 1) ;
  end ;

  FintSinc := 0;

end;

procedure TTefCitelNCR.pLimpaQrCode(const AstrMensagem: AnsiString);
begin
  pAbortarUltimoComando;
end;

procedure TTefCitelNCR.pLoga(const AStrMsg: String);
var
  LLogError: TextFile ;
  LstrPathLog: String ;
  LstrConteudoLog: String ;
  LMsgInfo: string;
  LMsgLog: string;
  LDataHoraFormatada: string;
  LEmTransacao: string;
begin
  LMsgLog := AStrMsg;
  LMsgInfo := self.fMensagemInfo;
  if Trim(LMsgInfo) <> '' then
    LMsgLog := LMsgInfo + ' - ' + AStrMsg;

  LstrPathLog := '' ;
  if trim(FPathDLL) <> '' then
    if DirectoryExists(FPathDLL) then
      LstrPathLog := PathWithDelim(FPathDLL);

  AssignFile(LLogError, LstrPathLog+TEFCitelErro_Log);
  try
    if FileExists(LstrPathLog+TEFCitelErro_Log) then
      Append(LLogError)
    else
      Rewrite(LLogError) ;

    LDataHoraFormatada := FormatDateTime('dd/mm/yyyy hh:mm:ss', Now());

    LEmTransacao := EmptyStr;
    if FblnEmTransacao then
      LEmTransacao := '[Em Transação] ';

    LstrConteudoLog := LEmTransacao + 'Data/Hora: ' + LDataHoraFormatada + ' --> ' + LMsgLog ;

    Writeln(LLogError, LstrConteudoLog);
    Flush(LLogError);

    if Assigned(FProcLogErr) then
    begin
      try
        FProcLogErr(True, TituloLogErr, LstrConteudoLog) ;
      except
        On E: Exception do
        begin
          //ignora o erro
        end ;
      end ;
    end ;

  finally
    CloseFile(LLogError);
  end ;
end;

function TTefCitelNCR.fConsultaTransacoesPendentesTerminal: TUniClientDataSet;
begin
  Result := Nil ;
end;

function TTefCitelNCR.fDebito(const AstrMensagem: String): String;
begin
  Result := AstrMensagem ;
  FProcessaRetorno.ProcessarStatus('131', '');
  Self.NotificaObservers();
  Application.ProcessMessages;

  Sleep(200);
end;

function TTefCitelNCR.fDebitoBanrisul: String;
begin
  Result := '' ;
  FProcessaRetorno.ProcessarStatus('131', NCR_BANRISUL_DEBITO_CODIGO);
  Self.NotificaObservers();
  Application.ProcessMessages;

  Sleep(300);

  FProcessaRetorno.ProcessarStatus('21', NCR_MEIOS_PAGAMENTO_DEBITO_BANRISUL_HABILITADOS);
  Self.NotificaObservers();
  Application.ProcessMessages;

end;

function TTefCitelNCR.fDeletaArquivoNoPinPad(
  const AstrArquivo: AnsiString): Boolean;
var
  LstrIdArquivoPinPad: AnsiString ;
  LintRet: Integer ;
  LstrMensagemValidacao: String ;
begin
  Result := False ;

  if not Assigned(ScopePPMMFileDelete) then
  begin
    FstrMensagemErro := FstrMensagemErro + '[ScopePPMMFileDelete] não foi possível carregar, verificar a versão da dll do Tef Scope' + #13#10 ;
    exit;
  end;

  LstrIdArquivoPinPad := AnsiString(AstrArquivo) ;
  LintRet := ScopePPMMFileDelete(PAnsiChar(LstrIdArquivoPinPad));
  if not fValidaRetornoScopePPMMFileDelete(LintRet, LstrMensagemValidacao) then
  begin
    FstrMensagemErro := LstrMensagemValidacao + '[' + Trim(String(AstrArquivo)) + ']' ;
    Exit ;
  end ;
  Result := True ;
end;

function TTefCitelNCR.fEhDebito(AColeta: TParam_Coleta): Boolean;
begin
  Result := False ;
  if FintOperacao <> NCR_OPERACAO_CARTAO_DEBITO then
    exit ;

  if FblnDebitoBanrisul then
    Exit ;

  if pos(NCR_DEBITO, lowercase(trim(String(fArrayToString(AColeta.MsgOp1))))) <= 0 then
    Exit ;

  Result := True ;
end;

function TTefCitelNCR.fEhDebitoBanrisul(const AstrMensagem: String): Boolean;
var
  LstrMensagem: String ;
begin
  Result := False ;
  if FintOperacao <> NCR_OPERACAO_CARTAO_DEBITO then
    exit ;

  if FblnDebitoBanrisul then
    exit ;

  LstrMensagem := Trim(LowerCase(AstrMensagem)) ;

  if Pos(NCR_BANRISUL_DEBITO, LstrMensagem) <= 0 then
    exit ;

  Result := True ;
end;

function TTefCitelNCR.fEhMensagemInserirCartao(
  const AstrMensagem: String): Boolean;
var
  LstrMensagem: String ;
begin
  LstrMensagem := LowerCase(AstrMensagem) ;
  Result := False ;

  if Pos('insira', LstrMensagem) = 0 then
    Exit ;

  if Pos('passe', LstrMensagem) = 0 then
    Exit ;

  if Pos('cartao', LstrMensagem) = 0 then
    Exit ;

  Result := True ;
end;

function TTefCitelNCR.fEhMenuRetornado(const AintTipoColeta: Integer): Boolean;
begin
  Result := False ;
  if AintTipoColeta = NCR_CODIGO_RETORNO_EXIBE_MENU then
    Exit(True) ;
end;

function TTefCitelNCR.fEhOpcoesPagamentoBanrisul(
  const AintTipoColeta: Integer): Boolean;
begin
  Result := False ;

  if not FblnDebitoBanrisul then
    Exit ;

  if AintTipoColeta = NCR_CODIGO_RETORNO_AVISTA_APRAZO then
    Exit(True) ;

  if AintTipoColeta = NCR_CODIGO_RETORNO_COLETAR_SE_PARC_AVISTA then
    Exit(True) ;

  if AintTipoColeta = NCR_CODIGO_RETORNO_PRE_DATADO then
    Exit(True) ;

  if AintTipoColeta = NCR_CODIGO_RETORNO_COLETAR_PARC_ADM_LOJA then
    Exit(True) ;

  if AintTipoColeta = NCR_CODIGO_RETORNO_COLETAR_QTD_PARCELAS then
    Exit(True) ;

  if AintTipoColeta = NCR_CODIGO_RETORNO_COLETAR_QTD_DIAS_ENTRE_PARC then
    Exit(True) ;

  if AintTipoColeta = NCR_CODIGO_RETORNO_COLETAR_QTD_DIAS_PRIMEIRA_PARC then
    Exit(True) ;

  if AintTipoColeta = NCR_CODIGO_RETORNO_COLETAR_DATA then
    Exit(True) ;

end;

function TTefCitelNCR.fEhOperacaoCancelamentoCartao: Boolean;
begin
  Result := True ;
  if FintOperacao = NCR_OPERACAO_CARTAO_CANCELAR then
    Exit ;

  if FintOperacao = NCR_OPERACAO_CARTAO_CANCELAR_2 then
    Exit ;

  Result := False ;
end;

function TTefCitelNCR.fEhOperacaoReimpressaoCartao: Boolean;
begin
  Result := True ;
  if FintOperacao = NCR_OPERACAO_IMPRESSAO_ULTIMO then
    Exit ;

  if FintOperacao = NCR_OPERACAO_IMPRESSAO_ESPECI then
    Exit ;

  Result := False ;
end;

function TTefCitelNCR.fEhValorAbaixoDoMinimoAdquirente(const ACodigoRede: Word;
  const AfltValor: Double; out AfltMinimo: Double): Boolean;
begin
  Result := False;
  AfltMinimo := 0 ;
  if FdictValorMinimoAdquirente.TryGetValue(ACodigoRede, AfltMinimo) then
    Result := AfltValor < AfltMinimo ;
end;

function TTefCitelNCR.fEscolheNsu(const ArecCartao: TCartao;
  AstrNsuFepas: string): string;
begin
  result := ArecCartao.strNSU ;

  if trim(ArecCartao.strNSU) <> '' then
    exit ;

  if trim(AstrNsuFepas) = '' then
    exit ;

  result := AstrNsuFepas ;
end;

function TTefCitelNCR.fEscolheuParcAdmMasTefNaoTem(const AintTipoColeta: Integer): Boolean;
begin
  Result := False ;
  if FintOperacao <> NCR_OPERACAO_CARTAO_CREDITO then
    exit ;

  if FrecInfoReq.strModalidade <> '3' then
    exit ;

  if AintTipoColeta = NCR_CODIGO_RETORNO_AVISTA_APRAZO then
    exit ;

  if AintTipoColeta = NCR_CODIGO_RETORNO_COLETAR_QTD_PARCELAS then
    Exit ;

  if FblnTemParcAdm then
    Exit ;

  Result := True ;
end;

procedure TTefCitelNCR.fFinalizarTransacao(Confirma: Boolean; DataStr, HoraStr,
  DocumentoVinculado, ParamAdic: AnsiString);
Var
  LintFinalizacao : SmallInt;
begin
  try
    if Confirma then
      LintFinalizacao := SCO_CONFIRMA_TEF
    else
      LintFinalizacao := SCO_DESFAZ_TEF;

    FintSinc := FintSinc or ACAO_PROX;

    FechaSessaoTEF(LintFinalizacao);
  finally
    if Assigned(FDepoisFinalizarTransacao) then
      FDepoisFinalizarTransacao() ;
  end ;
end;

function TTefCitelNCR.fFinalizaTransacaoTEF: LongInt;
var
  iRet,
  iAux:       LongInt;
  PColeta:    TParam_Coleta;
  PColetaMsg: TColeta_Msg;
  bAux:       Byte;
  sBufEntrAux: string;
  LblnCancelado: Boolean;

label
  fEnd;

begin
  LblnCancelado := False ;

  repeat
    bAux := 0;
    sBufEntrAux := '';
    {$WARN UNSAFE_CODE OFF}
    ZeroMemory(@PColeta, SizeOf(TParam_Coleta));
    {$WARN UNSAFE_CODE ON}

    // Enquanto a transacao estiver em andamento, aguarda
    repeat
      iRet := ScopeStatus;
      Sleep (200);

      case iRet of
        SCO_TRN_EM_ANDAMENTO:
        begin
          //verificar esse ponto
          if (FintSinc and ACAO_CANCELAR) <> 0 then
          begin
            pAtualizMsg('Transacao cancelada');
            ScopeResumeParam(iRet, '', SCO_NONE, COLETA_CANCELAR);
            LblnCancelado := True ;
            goto fEnd;
          end;

          pProcessamentoEmAndamento ;

        end;
        // Tratar a coleta de cartao manualmente, em paralelo c/ o PINPad
        SCO_COLETA_CARTAO_EM_ANDAMENTO:
        begin
          FRegistraIntervalos.pInicioEspera(tiAproximarInserir);

          PColeta.HabTeclas := BIT9_ON;
          // Vejamos se o usuario digitou o cartao manualm/te
          {$WARN UNSAFE_CODE OFF}
          sBufEntrAux := fAnaliseParalela(2, @bAux);
          {$WARN UNSAFE_CODE ON}

          pColetaCartaoAndamento(sBufEntrAux, bAux, iRet) ;

          pAtribuiValorStringComCondicao((Length (sBufEntrAux) = 0), sBufEntrAux, 'Digite o numero do cartao:') ;

          FRegistraIntervalos.pFimEspera(tiAproximarInserir);
        end ;
        // tratar quando o cliente aborta ao digitar senha
        NCR_CODIGO_RETORNO_COLETAR_ANULA_COLETA_SENHA:
        begin
          FstrMensagemOperadorAguardar := 'Operacao cancelada pelo cliente!' ;
        end ;
      end ;

      if (FintContinua = -1) and
         (FintOperacao=NCR_OPERACAO_CARTEIRA_DIGITAL_PIX) then
      begin
        FProcessaRetorno.ProcessarStatus('20', 'Aguarde cancelando operação pix com o banco...');
        Self.NotificaObservers();
      end;

      Application.ProcessMessages;
    until (iRet <> SCO_TRN_EM_ANDAMENTO);
    FblnDesligaShowProcessamento := True ;

    if ((iRet < SCO_PRIMEIRO_COLETA_DADOS) or
        (iRet > SCO_ULTIMO_COLETA_DADOS)) then
    begin
      pEncerraTransacao(iRet);
      break;
    end;

    // Guardar os bits q ligamos nos passos anteriores
    iAux := PColeta.HabTeclas;

    // Obtem dados do Scope e exibe as mensagens do cliente e operador
    {$WARN UNSAFE_CODE OFF}
    ScopeGetParam(iRet, @PColeta);
    {$WARN UNSAFE_CODE ON}

    // Restaurar os bits armazenados anteriorm/te
    PColeta.HabTeclas := PColeta.HabTeclas or iAux;

    // Tratamento dos estados
    case iRet of
      Integer(SCO_CARTAO), Integer(SCO_COLETA_AUT_OU_CARTAO) :
      begin
        sBufEntrAux := 'Digite o numero do cartao:';
      end;

      // imprime Cupom + Nota Promissoria + Cupom Promocional
      Integer(SCO_IMPRIME_CUPOM),
      Integer(SCO_IMPRIME_CUPOM_PARCIAL),
      Integer(SCO_IMPRIME_CONSULTA) :
      begin
        FRegistraIntervalos.pFimEspera(tiRetirarCartao);
        PColeta.HabTeclas := PColeta.HabTeclas or BIT7_ON;
        fObtemCupons(PColeta);
      end;

      // SCOPE aguardando o cartao que foi digitado
      Integer(SCO_CARTAO_DIGITADO):
      begin
        { MITIGACAO (Req. 456190, campo 2026-09-16) - cancelamento pedido tem
          precedencia sobre iniciar coleta de cartao digitado.

          O DEFEITO, que e da DLL do Scope e nao daqui: na versao nova, um
          COLETA_CANCELAR enviado durante a coleta pela leitora (0xFCFC) NAO
          aborta a transacao - o Scope passa a pedir 0xFC85 (cartao digitado)
          e fica repetindo esse pedido. Medido em 2026-09-16: 106 repeticoes
          ate o log acabar, a transacao presa dentro da DLL por mais de dois
          minutos, atravessando 33 pSair e a morte do proprio processo que a
          pediu. A versao anterior do Scope devolve RCS_NAO_EXISTE_TRN_SUSPENSA
          e encerra; nela o 0xFC85 nao aparece uma unica vez depois de um
          cancelamento, entao esta guarda e INERTE ali.

          POR QUE O LACO NAO SAIA SOZINHO, e esta parte E daqui: o
          pIniciaColetaCartao poe AbyteAux := 1 quando ha buffer, e o
          pTrataMensagemRetornadaScope (chamado logo abaixo) so executa o corpo
          quando AbyteAux <> 1. Ou seja: entrar na coleta digitada PULA a
          decisao de botao inteira - inclusive o "FintContinua = -1 =>
          ACAO_CANCELAR". O resultado media no trace era COLETA_PROXIMO_ESTADO
          com Digitos = 0, indefinidamente. Com a guarda, bAux fica em 0, o
          pTrataMensagemRetornadaScope roda e manda COLETA_CANCELAR.

          Nao e timeout: nao ha teto de tempo nenhum aqui, e por isso nao
          esbarra na regra do topo de IA\rules\tef-dvc.md. So devolve a
          precedencia a um cancelamento que o operador ja pediu.

          PROVISORIA: sai quando o suporte do Scope corrigir a versao nova.
          A evidencia de que atuou esta no proprio ScopeTrc.txt - no estado
          0xFC85 passa a aparecer "Botao Pressionado = Cancelar (C)" no lugar
          de "Proximo (P)". }
        if (FintContinua = -1) and
           (FintOperacao <> NCR_OPERACAO_CARTEIRA_DIGITAL_PIX) then
        begin
          { bAux ZERADO de proposito, e nao apenas "nao setado": ele vem por
            referencia do fAnaliseParalela do laco interno (SCO_COLETA_CARTAO_
            EM_ANDAMENTO) e pode chegar aqui ja em 1. Deixa-lo em 1 manteria o
            pTrataMensagemRetornadaScope calado e a guarda nao valeria nada. }
          bAux := 0 ;
          pAtribuiValorStringComCondicao((Length(sBufEntrAux) = 0),
            sBufEntrAux, 'Coleta:') ;
        end
        else
        begin
          // Vamos ver c o usr ja' digitou o texto
          {$WARN UNSAFE_CODE OFF}
          sBufEntrAux := fAnaliseParalela(2, @bAux);
          {$WARN UNSAFE_CODE ON}

          pIniciaColetaCartao(bAux, iAux, sBufEntrAux) ;
        end;
      end;

      // mostra informacao e aguarda confirmacao do usuario
      Integer(SCO_MOSTRA_INFO_RET_SCOPE):
      begin
        pAtribuiValorStringComCondicao((Length(sBufEntrAux) = 0), sBufEntrAux, 'Coleta:') ;
        PColeta.HabTeclas := BIT9_ON;
        iAux := 0; // Garantir o envio da acao PROXIMO ao SCOPE
      end;

      Integer(SCO_COLETA_EM_ANDAMENTO):
      begin
        bAux := 1;
        FRegistraIntervalos.pInicioEspera(tiSenha);
        FRegistraIntervalos.pFimEspera(tiSenha);
      end;

      Integer(SCO_COLETA_AVISTA_PRAZO):
      begin
        FRegistraIntervalos.pInicioEspera(tiAvistaPrazo);
        FRegistraIntervalos.pFimEspera(tiAvistaPrazo);
      end;

      Integer(SCO_COLETA_NUMPARC):
      begin
        FRegistraIntervalos.pInicioEspera(tiParcela);
        FRegistraIntervalos.pFimEspera(tiParcela);
      end;

      Integer(TC_OBTEM_QRCODE):
      begin
        fBuscaDadosTransacaoEmAndamento;
      end;

      else // Todos os outros estados nao tratados
      begin
        pAtribuiValorStringComCondicao((Length(sBufEntrAux) = 0), sBufEntrAux, 'Coleta:') ;
      end;
    end;

    // Exibe as msgs retornadas pelo SCOPE e direciona de acordo com a mensagem recebida
    pTrataMensagemRetornadaScope(bAux, iRet, PColeta, sBufEntrAux, iAux) ;

    pAtribuiValorStringComCondicao(( FintSinc and (ACAO_PROX + ACAO_ANTER + ACAO_CANCELAR) = 0 ), sBufEntrAux, '') ;

    case fFinalProcessamento(iRet, iAux, PColetaMsg, LblnCancelado, sBufEntrAux) of
      esExit:
      begin
        Result := iAux ;
        Exit ;
      end ;
      esBreak:
      begin
        break ;
      end ;
    end ;

  until ((iRet < SCO_PRIMEIRO_COLETA_DADOS) and
          (iRet > SCO_ULTIMO_COLETA_DADOS));

  FRegistraIntervalos.pFimTransacao;

  //busca os dados da transação
  if not fBuscaDadosTransacao then
  begin
    pFechaSessaoMultCartao ;
    Result := -2 ;
    Exit ;
  end ;

  fEnd:

  if LblnCancelado then
  begin
    pFechaSessaoMultCartao ;
    Result := -1 ;
    exit ;
  end ;

  FProcessaRetorno.ProcessarCartao(FrecCartao.strCupom,
                                   FrecCartao.strValor,
                                   FrecCartao.strBandeira,
                                   FrecCartao.strNomeRede,
                                   FrecCartao.strAutorizacao,
                                   FrecCartao.strNSU,
                                   FrecCartao.strTipoTransacao,
                                   IntToStr(FrecInfoReq.intQtdParc),
                                   FrecCartao.strNumeroControle,
                                   FrecCartao.strConteudoViaCliente,
                                   FrecCartao.strConteudoViaLojista,
                                   FrecCartao.strDataHora,
                                   FrecCartao.strChaPix,
                                   FrecCartao.strPixS_N,
                                   FrecCartao.strCodigoCarteiraDigital,
                                   FrecCartao.intPrimeiroVencimento,
                                   FrecCartao.intPeriodo,
                                   FrecCartao.strControle,
                                   FrecCartao.strTipDeb,
                                   Self.FobjDadosAdicionaisTefTra,
                                   FrecCartao.strCodigoEstabeleci,
                                   FrecCartao.strPrePago,
                                   FRegistraIntervalos.fObjIntervalos,
                                   FrecCartao.strParcAdm,
                                   FrecCartao.strModoEntrada,
                                   FrecCartao.strTipoOperacao,
                                   FrecCartao.strXIdPix,
                                   FrecCartao.strCampoReferenciaPix,
                                   FrecCartao.strQrCodePix,
                                   FrecCartao.strRequestPagamentoPix,
                                   FrecCartao.strResponsePagamentoPix,
                                   FrecCartao.strDadosPagamentoPix,
                                   FrecCartao.strResponseDevolucaoPix);

  pAvisaOkClient ;

  Result := SCO_SUCESSO ;
end;

function TTefCitelNCR.fFinalProcessamento(var AintRet, AintAux: Integer;
  AColetaMsg: TColeta_Msg; var AblnCancelado: Boolean;
  var AstrBufEntrAux: String): TEnumStatus;
var
  LintRetAnt: Integer ;
begin
  Result := esOk ;

  LintRetAnt := AintRet ;
  AintRet := ScopeResumeParam(AintRet, PAnsiChar(AnsiString(AstrBufEntrAux)), SCO_TECLADO, AintAux);

  if (AintRet <> SCO_SUCESSO) then
  begin
    {$WARN UNSAFE_CODE OFF}
    AintAux := ScopeGetLastMsg (@AColetaMsg);
    {$WARN UNSAFE_CODE ON}
    if (AintAux <> SCO_SUCESSO) then
    begin
      pIncluiLinhaLog(Concat('Problemas em [ScopeGetLastMsg] retorno: ', fTraduzirErro(AintAux)) ) ;
      FintSinc := FintSinc or ACAO_PROX;
      if not FblnMultCartoes then
        FechaSessaoTEF(SCO_DESFAZ_TEF);
      Result := esExit ;
      exit ;
    end;

    // Se o erro for de dado invalido, vamos permitir o usuario tentar novamente
    if (AintRet = SCO_DADO_INVALIDO) and (LintRetAnt = NCR_CODIGO_RETORNO_COLETAR_SCOPE) then
    begin
      pAtualizMsg(AColetaMsg);
      ScopeResumeParam(AintRet, '', SCO_NONE, COLETA_CANCELAR);
      AblnCancelado := True ;
      Result := esBreak ;
      exit ;
    end ;

  end ;

end;

function TTefCitelNCR.fFormataMsgPP(const AstrMsg: String): String;
const
  CHAR_QUEBRA_LINHA  = '|' ;
var
  LstrMsg: String ;
begin
  LstrMsg := StringReplace(AstrMsg, '|', #13, [rfReplaceAll]) ;
  Result := LstrMsg ;
end;

function TTefCitelNCR.fGerarJsonDadosPagamentoPix(
  const ADados: TInfoDadosPagamentoPix): TJSONArray;
var
  LArray: TJSONArray;
  LJson, LPagador: TJSONObject;
  LDevolucoes: TJSONArray;
  LFS: TFormatSettings;
begin
  LFS := TFormatSettings.Create;
  LFS.DecimalSeparator := '.';

  LArray := TJSONArray.Create;
  LJson := TJSONObject.Create;
  LArray.AddElement(LJson);

  LJson.AddPair('endToEndId', TJSONString.Create(ADados.endToEndId));
  LJson.AddPair('txid',       TJSONString.Create(ADados.txid));
  LJson.AddPair('valor',
    TJSONString.Create(FormatFloat('0.00', ADados.valor, LFS)));
  LJson.AddPair('horario',     TJSONString.Create(ADados.horario));
  LJson.AddPair('nomePagador', TJSONString.Create(ADados.nomePagador));

  LPagador := TJSONObject.Create;
  LPagador.AddPair('nome', TJSONString.Create(ADados.nomePagador));
  LPagador.AddPair('cpf',  TJSONString.Create(ADados.pagador_cpf));
  LJson.AddPair('pagador', LPagador);

  LDevolucoes := TJSONArray.Create;
  LJson.AddPair('devolucoes', LDevolucoes);

  Result := LArray;
end;

function TTefCitelNCR.fGerarJsonResponseDevolucaoPix(
  const ADados: TInfoResponseDevolucaoPix): String;
var
  LJson, LHorario: TJSONObject;
begin
  LJson := TJSONObject.Create;
  try
    LJson.AddPair('id', ADados.id);
    LJson.AddPair('rtrId', ADados.rtrId);
    LJson.AddPair('valor', ADados.valor);

    LHorario := TJSONObject.Create;
    LHorario.AddPair('solicitacao', ADados.horario_solicitacao);
    LHorario.AddPair('liquidacao', ADados.horario_liquidacao);
    LJson.AddPair('horario', LHorario);

    LJson.AddPair('status', ADados.status);
    LJson.AddPair('motivo', ADados.motivo);

    // Remove o escape de "/" que o ToJSON gera por padrão
    Result := StringReplace(LJson.ToJSON, '\/', '/', [rfReplaceAll]);
  finally
    FreeAndNil(LJson);
  end;
end;

function TTefCitelNCR.fGerarJsonResponsePagamentoPix(
  const ADados: TInfoResponsePagamentoPix; const ADadosPgt: TInfoDadosPagamentoPix): String;
var
  LJson, LCalendario, LValor: TJSONObject;
  LFS: TFormatSettings;
begin
  LFS := TFormatSettings.Create;
  LFS.DecimalSeparator := '.';

  LJson := TJSONObject.Create;
  try
    LCalendario := TJSONObject.Create;
    LCalendario.AddPair('criacao', ADados.calendario_criacao);
    LCalendario.AddPair('expiracao',
      TJSONNumber.Create(ADados.calendario_expiracao));
    LJson.AddPair('calendario', LCalendario);

    LJson.AddPair('status', ADados.status);
    LJson.AddPair('txid', ADados.txid);
    LJson.AddPair('revisao', TJSONNumber.Create(ADados.revisao));
    LJson.AddPair('location', ADados.location);

    LValor := TJSONObject.Create;
    LValor.AddPair('original',
      FormatFloat('0.00', ADados.valor_original, LFS));
    LValor.AddPair('modalidadeAlteracao',
      TJSONNumber.Create(ADados.valor_modalidadeAlteracao));
    LJson.AddPair('valor', LValor);

    LJson.AddPair('chave', ADados.chave);

    // FORÇA o pair mesmo com string vazia (usa overload com TJSONValue)
    LJson.AddPair('solicitacaoPagador',
      TJSONString.Create(ADados.solicitacaoPagador));

    LJson.AddPair('brcode', ADados.brcode);

    LJson.AddPair('pix', fGerarJsonDadosPagamentoPix(ADadosPgt));

    LJson.AddPair('tefscope', TJSONString.Create('S'));
    LJson.AddPair('controle', TJSONString.Create(ADadosPgt.controle));

    // Remove o escape de "/" que o ToJSON gera por padrão
    Result := StringReplace(LJson.ToJSON, '\/', '/', [rfReplaceAll]);
  finally
    FreeAndNil(LJson);
  end;
end;

function TTefCitelNCR.fGerarJsonRequestPagamentoPix(
  const ADados: TInfoRequestPagamentoPix): String;
var
  LJson, LCalendario, LDevedor, LValor: TJSONObject;
  LFS: TFormatSettings;
begin
  LFS := TFormatSettings.Create;
  LFS.DecimalSeparator := '.';

  LJson := TJSONObject.Create;
  try
    // calendario { expiracao } - expiracao como string ("86400") conforme exemplo original
    LCalendario := TJSONObject.Create;
    LCalendario.AddPair('expiracao',
      TJSONString.Create(IntToStr(ADados.calendario_expiracao)));
    LJson.AddPair('calendario', LCalendario);

    // devedor { cnpj, nome }
    LDevedor := TJSONObject.Create;
    LDevedor.AddPair('cnpj', TJSONString.Create(ADados.devedor_cnpj));
    LDevedor.AddPair('nome', TJSONString.Create(ADados.devedor_nome));
    LJson.AddPair('devedor', LDevedor);

    // valor { original } - string "0.00"
    LValor := TJSONObject.Create;
    LValor.AddPair('original',
      TJSONString.Create(FormatFloat('0.00', ADados.valor_original, LFS)));
    LJson.AddPair('valor', LValor);

    // chave / solicitacaoPagador
    LJson.AddPair('chave', TJSONString.Create(ADados.chave));
    LJson.AddPair('solicitacaoPagador',
      TJSONString.Create(ADados.solicitacaoPagador));

    // Remove o escape de "/" que o ToJSON gera por padrão
    Result := StringReplace(LJson.ToJSON, '\/', '/', [rfReplaceAll]);
  finally
    FreeAndNil(LJson);
  end;
end;

function TTefCitelNCR.fGetDadosAdicionaisTefTra: IDadosAdicionaisTefTra;
begin
  Result := FobjDadosAdicionaisTefTra ;
end;

function TTefCitelNCR.fGetValueAntesCancelarTransacao: TAntesTefCartaoEvent;
begin
  Result := FAntesCancelarTransacao ;
end;

function TTefCitelNCR.fGetValueAntesPassarCartao: TAntesTefCartaoEvent;
begin
  Result := FAntesPassarCartao ;
end;

function TTefCitelNCR.fGetValueAntesReimpressao: TAntesTefCartaoEvent;
begin
  Result := FAntesReimpressao ;
end;

function TTefCitelNCR.fGetValueDepoisCancelarTransacao: TDepoisTefCartaoEvent;
begin
  Result := FDepoisCancelarTransacao ;
end;

function TTefCitelNCR.fGetValueDepoisFinalizarTransacao: TDepoisFinalizarTransacaoEvent;
begin
  Result := FDepoisFinalizarTransacao ;
end;

function TTefCitelNCR.fGetValueDepoisPassarCartao: TDepoisTefCartaoEvent;
begin
  Result := FDepoisPassarCartao ;
end;

function TTefCitelNCR.fGetValueDepoisReimpressao: TDepoisTefCartaoEvent;
begin
  Result := FDepoisReimpressao ;
end;

function TTefCitelNCR.fGetValueSucessoTefCartao: TSucessoTefCartaoEvent;
begin
  Result := FSucessoTefCartao ;
end;

function TTefCitelNCR.fObtemCupons(PColeta: TParam_Coleta): Boolean;
var
  LintRetorno: LongInt;
  LstrCabec:      array [1..1024] of AnsiChar;
  LstrCpCliente,
  LstrCpLoja,
  LstrCpReduzido: array [1..2048] of AnsiChar;
  LintNumeroLinhasReduzido: Byte;
begin
  Result := False ;
  {$WARN UNSAFE_CODE OFF}
  ZeroMemory(@LstrCabec, SizeOf(LstrCabec));
  ZeroMemory(@LstrCpCliente, SizeOf(LstrCpCliente));
  ZeroMemory(@LstrCpLoja, SizeOf(LstrCpLoja));
  ZeroMemory(@LstrCpReduzido, SizeOf(LstrCpReduzido));
  LintRetorno := ScopeGetCupomEx(SizeOf (LstrCabec), @LstrCabec,
                    SizeOf(LstrCpCliente), @LstrCpCliente,
                    SizeOf(LstrCpLoja), @LstrCpLoja,
                    SizeOf(LstrCpReduzido), @LstrCpReduzido, @LintNumeroLinhasReduzido);
  {$WARN UNSAFE_CODE ON}

  if (LintRetorno = SCO_SUCESSO) then
  begin
    FrecCartao.strConteudoViaLojista := TrimRight(string(fArrayToString(LstrCabec))) + #10 + #10 + TrimRight(string(fArrayToString(LstrCpLoja))) ;
    FrecCartao.strConteudoViaCliente := TrimRight(string(fArrayToString(LstrCabec))) + #10 + #10 + TrimRight(string(fArrayToString(LstrCpCliente))) + SEPARADORBLOCONCR ;
    pTrataDataPreDatadaCupomBanrisul(FrecCartao.strConteudoViaCliente) ;

    LintNumeroLinhasReduzido := 0;
    Result := True ;
  end ;
end;

function TTefCitelNCR.fObtemDadoPinPadDireto(AintTipoDocumento: Integer;
  AstrChaveAcesso, AstrIdentificador: AnsiString): AnsiString;
var
  LintRet: LongInt ;
  LstrBuffer: array [0..32] of AnsiChar ;
  LblnFlagFecharPortaPP: Boolean ;
begin
  Result := '' ;
  LblnFlagFecharPortaPP := True ;

  LintRet := ScopePPOpenSecure(1, PAnsiChar(AnsiString(FintComPort.ToString)));

  if (LintRet = PC_ALREADYOPEN) then
    LblnFlagFecharPortaPP := False;

  ScopeSetAplColeta;

  try
    LintRet := ScopePPStartGetData(ifThen(AintTipoDocumento = 2, PC_GETDATA_CPF, PC_GETDATA_CNPJ), 0, ifThen(AintTipoDocumento = 2, 11, 14)) ;
    if LintRet = PC_OK then
    begin
      repeat
        {$WARN UNSAFE_CODE OFF}
        LintRet := ScopePPGetData(Length(LstrBuffer), PAnsiChar(@LstrBuffer)) ;
        {$WARN UNSAFE_CODE ON}

        if LintRet = PC_ANULA then
          Break ;

        if LintRet = PC_OK then
          Break ;

      until (LintRet = SCO_TRN_EM_ANDAMENTO) ;
    end ;
    Result := fArrayToString(LstrBuffer) ;
  finally
    if LblnFlagFecharPortaPP then
      FechaPINPad(FstrMsgPinPad) ;
  end ;
end;

function TTefCitelNCR.fObtemVersao: string;
var
  LstrVersao: array [0..63] of AnsiChar;
begin
  Result := '';

  if not Assigned(ScopeVersao) then
        Exit;

  {$WARN UNSAFE_CODE OFF}
  try
    try
      ZeroMemory(@LstrVersao, SizeOf(LstrVersao));
      ScopeVersao(@LstrVersao, SizeOf(LstrVersao));

      Result := Trim(String(fArrayToString(LstrVersao))) ;

      if Result = '' then
        raise LibTefDLLException.Create('Erro ao obter versão da DLL');
    except
      on LibE: LibTefDLLException do
        pLoga(LibE.Message);

      on E: Exception do
        pLoga('Erro ao obter versão DLL: ' +E.ClassName + '|' + E.Message);
    end;
  finally
    {$WARN UNSAFE_CODE ON}
  end ;
end;

function TTefCitelNCR.fObtemInfoPinPad: String;
begin
  Result := FstrInfoPinPad;

  if FblnInfoPinPadJaConsultada then
    Exit;

  FblnInfoPinPadJaConsultada := True;

  if not Assigned(ScopePPGetInfoEx) then
    Exit;

  try
    FstrInfoPinPad := fConsultarInfoHardwarePinPad;
  except
    on E: Exception do
    begin
      FstrInfoPinPad := '';
      pLoga(fFormataMsgExcecao('fObtemInfoPinPad', E));
    end;
  end;

  Result := FstrInfoPinPad;
end;

function TTefCitelNCR.fTamanhoMinimoBufferInfoHW: Integer;
var
  LintI: Integer;
  LintFim: Integer;
begin
  Result := 0;
  for LintI := Low(CAMPOS_INFO_HW_NCR) to High(CAMPOS_INFO_HW_NCR) do
  begin
    LintFim := CAMPOS_INFO_HW_NCR[LintI].Offset + CAMPOS_INFO_HW_NCR[LintI].Tamanho - 1;
    if LintFim > Result then
      Result := LintFim;
  end;
end;

function TTefCitelNCR.fConsultarInfoHardwarePinPad: String;
var
  LstrBuffer: array [0..TAM_BUFFER_INFO_HW_NCR - 1] of AnsiChar;
  LblnFecharPortaPP: Boolean;
begin
  Result := '';

  if fTamanhoMinimoBufferInfoHW > SizeOf(LstrBuffer) then
  begin
    pLoga('CAMPOS_INFO_HW_NCR excede o buffer configurado — abortando leitura.');
    Exit;
  end;

  LblnFecharPortaPP := True;
  try
    try
      if not fAbrirPortaPinPad(LblnFecharPortaPP) then
        Exit;

      {$WARN UNSAFE_CODE OFF}
      ZeroMemory(@LstrBuffer, SizeOf(LstrBuffer));
      {$WARN UNSAFE_CODE ON}

      if not fLerInfoHardware(LstrBuffer) then
        Exit;

      Result := fFormataInfoPinPad(LstrBuffer, SizeOf(LstrBuffer));
    except
      on E: Exception do
        pLoga(fFormataMsgExcecao('fConsultarInfoHardwarePinPad', E));
    end;
  finally
    if LblnFecharPortaPP then
    begin
      try
        FechaPINPad(FstrMsgPinPad);
      except
        on E: Exception do
          pLoga(fFormataMsgExcecao('fConsultarInfoHardwarePinPad.FechaPINPad', E));
      end;
    end;
  end;
end;

function TTefCitelNCR.fFormataInfoPinPad(const ABuffer; const ABufferLen: Integer): String;
var
  LintI: Integer;
  LintFim: Integer;
  LstrValor: AnsiString;
  LBuilder: TInfoPinPadBuilder;
  LpByte: PAnsiChar;
begin
  LBuilder.Reset;

  {$WARN UNSAFE_CODE OFF}
  LpByte := @ABuffer;
  {$WARN UNSAFE_CODE ON}

  for LintI := Low(CAMPOS_INFO_HW_NCR) to High(CAMPOS_INFO_HW_NCR) do
  begin
    LintFim := CAMPOS_INFO_HW_NCR[LintI].Offset + CAMPOS_INFO_HW_NCR[LintI].Tamanho - 1;

    if LintFim > ABufferLen then
    begin
      pLoga('fFormataInfoPinPad: campo ' + IntToStr(LintI) + ' excede ABufferLen — ignorado.');
      Continue;
    end;

    SetString(LstrValor, LpByte + CAMPOS_INFO_HW_NCR[LintI].Offset - 1,
              CAMPOS_INFO_HW_NCR[LintI].Tamanho);

    LBuilder.AddCampo(fRotuloCampoPinPad(CAMPOS_INFO_HW_NCR[LintI]),
                      Trim(String(LstrValor)));
  end;

  Result := LBuilder.ToString;
end;

function TTefCitelNCR.fAbrirPortaPinPad(var AblnFecharPortaPP: Boolean): Boolean;
var
  LintRet: LongInt;
  LstrComPort: AnsiString;
begin
  AblnFecharPortaPP := True;

  LstrComPort := AnsiString(FintComPort.ToString);
  LintRet     := ScopePPOpenSecure(1, PAnsiChar(LstrComPort));

  if (LintRet = PC_ALREADYOPEN) then
    AblnFecharPortaPP := False
  else if LintRet <> PC_OK then
  begin
    AblnFecharPortaPP := False;
    Result := False;
    Exit;
  end;

  ScopeSetAplColeta;
  Result := True;
end;

function TTefCitelNCR.fLerInfoHardware(var ABuffer: array of AnsiChar): Boolean;
var
  LintRet: LongInt;
begin
  Result := False;

  if Length(ABuffer) = 0 then
  begin
    pLoga('fLerInfoHardware: buffer vazio.');
    Exit;
  end;

  if Length(ABuffer) > High(Word) then
  begin
    pLoga('fLerInfoHardware: buffer excede o limite suportado por ScopePPGetInfoEx (Word).');
    Exit;
  end;

  {$WARN UNSAFE_CODE OFF}
  LintRet := ScopePPGetInfoEx(PC_GETINFO_HW, Word(Length(ABuffer)), PAnsiChar(@ABuffer[0]));
  {$WARN UNSAFE_CODE ON}

  Result := (LintRet = PC_OK);

  if not Result then
    pLoga('ScopePPGetInfoEx retornou: ' + IntToStr(LintRet));
end;

function TTefCitelNCR.fOpcaoAdmLojaSelecionada: String;
begin
  Result := '' ;
  if FintOperacao <> NCR_OPERACAO_CARTAO_CREDITO then
    exit ;

  if Trim(FrecInfoReq.strModalidade) = '' then
    Exit ;

  FintSinc := FintSinc or ACAO_PROX;

  if FrecInfoReq.strModalidade = '2' then
    Result := '2'
  else if FrecInfoReq.strModalidade = '3' then
    Result := '1' ;
end;

function TTefCitelNCR.fOpcaoCartaoSelecionada: String;
begin
  Result := '' ;
  if FintOperacao <> NCR_OPERACAO_CARTAO_CREDITO then
    exit ;

  if Trim(FrecInfoReq.strModalidade) = '' then
    Exit ;

  FintSinc := FintSinc or ACAO_PROX;

  if (FrecInfoReq.intQtdParc = 0) or (FrecInfoReq.intQtdParc = 1) then
    Result := '1'
  else
    Result := '0' ;

end;

function TTefCitelNCR.fOpcoesPagamentoBanrisulSelecionada(
  const AintTipoColeta: Integer): String;
var
  LintQtdDias: Integer ;
begin
  Result := '' ;
  if FrecInfoReq.strModalidade = NCR_BANRISUL_MODALIDADE_AVISTA then
  begin
    if AintTipoColeta = NCR_CODIGO_RETORNO_AVISTA_APRAZO then
    begin
      FintSinc := FintSinc or ACAO_PROX;
      Result := '1' ;
      exit ;
    end ;
  end
  else if FrecInfoReq.strModalidade = NCR_BANRISUL_MODALIDADE_PREDATADO then
  begin
    if AintTipoColeta = NCR_CODIGO_RETORNO_AVISTA_APRAZO then
    begin
      FintSinc := FintSinc or ACAO_PROX;
      Result := '0' ;
      exit ;
    end
    else if AintTipoColeta = NCR_CODIGO_RETORNO_COLETAR_DATA then
    begin
      FintSinc := FintSinc or ACAO_PROX;
      Result := fTrataDataBanrisul(FrecInfoReq.dtaDataPreDatado) ;
    end
    else if AintTipoColeta = NCR_CODIGO_RETORNO_PRE_DATADO then
    begin
      FintSinc := FintSinc or ACAO_PROX;
      Result := '1' ;
      exit ;
    end ;
  end
  else if FrecInfoReq.strModalidade = NCR_BANRISUL_MODALIDADE_PARCELADO then
  begin
    if AintTipoColeta = NCR_CODIGO_RETORNO_AVISTA_APRAZO then
    begin
      FintSinc := FintSinc or ACAO_PROX;
      Result := '0' ;
      exit ;
    end
    else if AintTipoColeta = NCR_CODIGO_RETORNO_PRE_DATADO then
    begin
      FintSinc := FintSinc or ACAO_PROX;
      Result := '0' ;
      exit ;
    end
    else if AintTipoColeta = NCR_CODIGO_RETORNO_COLETAR_PARC_ADM_LOJA then
    begin
      FintSinc := FintSinc or ACAO_PROX;
      Result := '2' ;
      exit ;
    end
    else if AintTipoColeta = NCR_CODIGO_RETORNO_COLETAR_SE_PARC_AVISTA then
    begin
      FintSinc := FintSinc or ACAO_PROX;
      if FrecInfoReq.intPrimParcAvista = NCR_BANRISUL_PARCELA_COM_ENTRADA then
        Result := '1'
      else if FrecInfoReq.intPrimParcAvista = NCR_BANRISUL_PARCELA_SEM_ENTRADA then
        Result := '0' ;
    end
    else if AintTipoColeta = NCR_CODIGO_RETORNO_COLETAR_QTD_PARCELAS then
    begin
      FintSinc := FintSinc or ACAO_PROX;
      Result := IntToStr(FrecInfoReq.intQtdParc) ;
    end
    else if AintTipoColeta = NCR_CODIGO_RETORNO_COLETAR_QTD_DIAS_PRIMEIRA_PARC then
    begin
      FintSinc := FintSinc or ACAO_PROX;
      LintQtdDias := DaysBetween(Date, FrecInfoReq.dtaPrimParcela) ;
      Result := IntToStr(LintQtdDias) ;
    end
    else if AintTipoColeta = NCR_CODIGO_RETORNO_COLETAR_QTD_DIAS_ENTRE_PARC then
    begin
      FintSinc := FintSinc or ACAO_PROX;
      Result := fIntervaloDiasParcelasBanrisul ;
    end ;

  end ;
end;

function TTefCitelNCR.fParcelaCartaoSeleciona: String;
begin
  Result := '' ;
  if FintOperacao <> NCR_OPERACAO_CARTAO_CREDITO then
    exit ;

  if Trim(FrecInfoReq.strModalidade) = '' then
    Exit ;

  if FrecInfoReq.intQtdParc = 0 then
    Exit ;

  FintSinc := FintSinc or ACAO_PROX;

  Result := IntToStr(FrecInfoReq.intQtdParc) ;
end;

function TTefCitelNCR.fPassarCartao(intOperacao, intQtdParcelas: Integer;
  strModalidade, strNumDoc: String; fltValor: Double; strCodOperador: String;
  blnPagueFacil: Boolean; strCodigoCarteiraDigital: string;
  strJsonInfoAdicPix: String): IRetornoTEFCitel;
var
  LintRet: LongInt;
  LintSincBkp: Integer ;
  LMensagemErro: String;
begin
  Result := Nil ;
  FlstMenuRetornado.Clear ;
  FrecCartao.strTipDeb := DEBITO_AVISTA ;
  FrecCartao.strPrePago := 'N' ;
  FrecCartao.strParcAdm := 'N' ;
  FrecCartao.strXIdPix := EmptyStr;
  FrecCartao.strCampoReferenciaPix := EmptyStr;
  FrecCartao.strQrCodePix := EmptyStr;
  FrecCartao.strRequestPagamentoPix := EmptyStr;
  FrecCartao.strResponsePagamentoPix := EmptyStr;
  FrecCartao.strDadosPagamentoPix := EmptyStr;
  FrecCartao.strResponseDevolucaoPix := EmptyStr;
  FblnDebitoBanrisul := False ;
  FblnPreDatado := False ;
  FblnTemParcAdm := False ;
  FintOperacao := intOperacao ;
  FblnDesligaShowProcessamento := False ;
  FstrMensagemOperadorAguardar := '' ;
  FValorPix := EmptyStr;

  if Assigned(FAntesPassarCartao) then
  begin
    if not FAntesPassarCartao then
      Exit ;
  end ;

  FlstControleMensagemOperador.Clear ;
  FblnControleMensagemOperador := False ;

  if RoundTo(fltValor, -2) = 0.00 then
  begin
    FProcessaRetorno.ProcessarStatus('999', 'Valor da transação precisa ser maior que zero!');
    Self.NotificaObservers();
    Application.ProcessMessages;
    Exit ;
  end ;

  pExtraiDadosAdicionaisPix(strJsonInfoAdicPix);
  FblnEmTransacao := True;
  FintContinua := 0 ;
  try
    FillChar(FrecInfoReq,SizeOf(FrecInfoReq),#0);
    FrecInfoReq.intOperacaoTefTra := intOperacao ;
    FrecCartao := Default(TCartao);
    FrecCartao.intPrimeiroVencimento := -1;
    FrecCartao.intPeriodo := 0;
    FrecCartao.strTipDeb := DEBITO_AVISTA ;
    FrecCartao.strPrePago := 'N' ;
    FrecCartao.strParcAdm := 'N' ;
    FProcessaRetorno.LimparRetorno ;
    FrecCartao.strTipoOperacao := TRetornaTipoOperacao.fGet(intOperacao) ;
    FrecCartao.strPixS_N := IfThen(FintOperacao=NCR_OPERACAO_CARTEIRA_DIGITAL_PIX, 'S', 'N');

    if ((intOperacao = 2) or (blnPagueFacil)) then
    begin
      FrecInfoReq.strModalidade := strModalidade;
      FrecInfoReq.strNumDoc     := strNumDoc;
      FrecInfoReq.intQtdParc    := ifthen(blnPagueFacil, ifthen(intQtdParcelas = 1, 0, intQtdParcelas), intQtdParcelas) ;
      FrecInfoReq.fltValor      := fltValor;
    end;

    FblnMultCartoes := not ((FintSinc and INI_SESSAO) = 0) ;

    LintSincBkp := FintSinc ;
    LintRet := AbreSessaoTEF(False, FintOperacao=NCR_OPERACAO_CARTEIRA_DIGITAL_PIX) ;
    if LintRet <> SCO_SUCESSO then
    begin
      FintSinc := LintSincBkp ;
      LMensagemErro := Concat('Problemas em [AbreSessaoTEF] retorno: ', fTraduzirErro(LintRet));
      pIncluiLinhaLog(LMensagemErro);
      pLoga(LMensagemErro);
      FProcessaRetorno.ProcessarStatus(IntToStr(LintRet), fTraduzirErro(LintRet));
      Self.NotificaObservers();
      Application.ProcessMessages ;
      Exit;
    end ;

    FintSinc := FintSinc and not (ACAO_PROX + ACAO_ANTER + ACAO_CANCELAR +
              BIT6_ON + BIT7_ON + BIT8_ON + BIT9_ON);

    if not Assigned(FRetorno) then
      FRetorno := TRetornoTEFCitel.Create;

    LintRet := fIniciaTransacaoTEF(intOperacao, fltValor, strNumDoc, strCodigoCarteiraDigital);

    if LintRet = SCO_SUCESSO then
      LintRet := fFinalizaTransacaoTEF
    else
    begin
      LMensagemErro := Concat('Problemas em [fIniciaTransacaoTEF] retorno: ', fTraduzirErro(LintRet)) ;
      pIncluiLinhaLog(LMensagemErro) ;
      pLoga(LMensagemErro);
      FintSinc := FintSinc or ACAO_PROX;
      if not FblnMultCartoes then
        FechaSessaoTEF(SCO_DESFAZ_TEF);
    end ;

    if LintRet <> SCO_SUCESSO then
    begin
      if Trim(FstrMensagemOperadorAguardar) <> '' then
      begin
        FProcessaRetorno.ProcessarStatus('500', FstrMensagemOperadorAguardar);
        Self.NotificaObservers();
        Application.ProcessMessages;
        FstrMensagemOperadorAguardar := '' ;
      end
      else
      begin
        FProcessaRetorno.ProcessarStatus(IntToStr(LintRet), fTraduzirErro(LintRet));
        Self.NotificaObservers();
      end ;
    end
    else
    begin
      Result := FRetorno ;
    end ;

  finally
    FblnEmTransacao := False;
    pDepoisEvento(FDepoisPassarCartao, Result) ;
  end ;

end;

function TTefCitelNCR.fReimpressao(intFuncao: Integer; strNumDoc: AnsiString;
  strDtaTra: TDate; strCodOpe: AnsiString; fltValTra: Double): IRetornoTEFCitel;
var
  LintRet: LongInt;
  LMensagemErro: String;
begin
  Result := Nil ;
  FblnDesligaShowProcessamento := False ;
  FintOperacao := intFuncao ;
  FstrControle := String(strNumDoc) ;

  if Assigned(FAntesReimpressao) then
  begin
    if not FAntesReimpressao then
      Exit ;
  end ;

  FintContinua := 0 ;
  FblnEmTransacao := True;
  try
    FillChar(FrecInfoReq,SizeOf(FrecInfoReq),#0);
    FrecCartao := Default(TCartao);
    FrecCartao.strTipDeb := DEBITO_AVISTA ;
    FrecCartao.strPrePago := 'N' ;
    FrecCartao.strParcAdm := 'N' ;
    FrecCartao.strXIdPix := EmptyStr;
    FrecCartao.strCampoReferenciaPix := EmptyStr;
    FrecCartao.strQrCodePix := EmptyStr;
    FrecCartao.strRequestPagamentoPix := EmptyStr;
    FrecCartao.strResponsePagamentoPix := EmptyStr;
    FrecCartao.strDadosPagamentoPix := EmptyStr;
    FrecCartao.strResponseDevolucaoPix := EmptyStr;

    LintRet := AbreSessaoTEF ;
    if LintRet <> SCO_SUCESSO then
    begin
      FechaSessaoTEF(SCO_DESFAZ_TEF);
      LMensagemErro := Concat('Problemas em [AbreSessaoTEF] retorno: ', fTraduzirErro(LintRet));
      pIncluiLinhaLog(LMensagemErro) ;
      pLoga(LMensagemErro);
      FProcessaRetorno.ProcessarStatus(IntToStr(LintRet), fTraduzirErro(LintRet));
      Self.NotificaObservers();
      Application.ProcessMessages ;
      Exit;
    end ;

    FintSinc := FintSinc and not (ACAO_PROX + ACAO_ANTER + ACAO_CANCELAR +
              BIT6_ON + BIT7_ON + BIT8_ON + BIT9_ON);

    if not Assigned(FRetorno) then
      FRetorno := TRetornoTEFCitel.Create;

    LintRet := fIniciaTransacaoTEF(fintOperacao, 0.00, '', '');

    if LintRet = SCO_SUCESSO then
      LintRet := fFinalizaTransacaoTEF
    else
    begin
      LMensagemErro := Concat('Problemas em [fIniciaTransacaoTEF] retorno: ', fTraduzirErro(LintRet));
      pIncluiLinhaLog(LMensagemErro);
      pLoga(LMensagemErro);
      FintSinc := FintSinc or ACAO_PROX;
      FechaSessaoTEF (SCO_CONFIRMA_TEF);
    end ;

    if LintRet <> SCO_SUCESSO then
    begin
      FProcessaRetorno.ProcessarStatus(IntToStr(LintRet), fTraduzirErro(LintRet));
      Self.NotificaObservers();
    end
    else
    begin
      FintSinc := FintSinc or ACAO_PROX;
      FechaSessaoTEF (SCO_CONFIRMA_TEF);
      Result := FRetorno ;
    end ;

  finally
    FblnEmTransacao := False;
    pDepoisEvento(FDepoisReimpressao, Result) ;
  end ;

end;

function TTefCitelNCR.fReimpressaoDocumentoSeleciona(const AintTipoColeta: Integer): String;
begin
  Result := '' ;
  if AintTipoColeta = NCR_CODIGO_RETORNO_REIMPRESSAO_DECIDE then
  begin
    if FintOperacao = NCR_OPERACAO_IMPRESSAO_ULTIMO then
      Result := '1'
    else
      Result := '0' ;
  end
  else if AintTipoColeta = NCR_CODIGO_RETORNO_COLETAR_SCOPE then
  begin
    Result := FstrControle ;
  end
  else if AintTipoColeta = NCR_CODIGO_RETORNO_TIPO_VIA_REIMPRESSAO then
  begin
    Result := '0' ;
  end
  else if AintTipoColeta = NCR_CODIGO_RETORNO_AGUARDA_OPERADOR then
  begin
    Result := '1' ;
  end ;

  if Result <> '' then
    FintSinc := FintSinc or ACAO_PROX ;
end;

function TTefCitelNCR.fRetornaTipoTransacao: String;
begin
  if FintOperacao = NCR_OPERACAO_CARTAO_CREDITO then
    Result := '01'
  else
    Result := '02' ;
end;

function TTefCitelNCR.fVaiExtenderTempoPix(
  const AintTipoColeta: Integer): Boolean;
begin
  Result := False ;
  if AintTipoColeta = NCR_CODIGO_RETORNO_AGUARDA_MAIS_TEMPO then
    Exit(True) ;
end;

function TTefCitelNCR.fValidaRetornoScopePPMMFileDelete(
  const AintRetorno: Integer; var AstrMensagem: String): Boolean;
begin
  AstrMensagem := '' ;
  if AintRetorno = PC_OK then
    Exit(True) ;

  Result := False ;
  if AintRetorno = RCS_ERRO_MODO_ABECS then
  begin
    AstrMensagem := 'Chamada válida somente para PINpads ABECS [' + inttostr(AintRetorno) + ']' ;
    Exit ;
  end ;

  if AintRetorno = PC_NAO_ABERTO_APP then
  begin
    AstrMensagem := 'PIN-Pad não foi aberto pela aplicação [' + inttostr(AintRetorno) + ']' ;
    Exit ;
  end ;

  AstrMensagem := 'Erro desconhecido [' + inttostr(AintRetorno) + ']' ;
end;

function TTefCitelNCR.fValorNumericoNcr(const AfltValor: Double): String;
var
  LstrValor: String ;
  LintCnt: Integer ;
begin
  LstrValor := FormatFloat('0.00', AfltValor) ;

  Result := '' ;
  for LintCnt := 1 to Length(LstrValor) do
    if CharInSet(LstrValor[LintCnt], ['0'..'9']) then
      Result := Result + LstrValor[LintCnt] ;

end;

function TTefCitelNCR.fVerificaPresencaPinPad: TStatusPinPad;
begin
  Result := FsppPinPad ;
  if Result <> sppOperacional then
  begin
    AbreSessaoTEF ;
    FechaSessaoTEF(SCO_CONFIRMA_TEF);
    Result := FsppPinPad ;
  end ;
end;

function TTefCitelNCR.fTemParcelamentoAdmLoja(
  const AintTipoColeta: Integer): Boolean;
begin
  Result := False ;

  if FintOperacao <> NCR_OPERACAO_CARTAO_CREDITO then
    exit ;

  if AintTipoColeta = NCR_CODIGO_RETORNO_COLETAR_PARC_ADM_LOJA then
    Result := True ;
end;

function TTefCitelNCR.fTemParcelasCredito(
  const AintTipoColeta: Integer): Boolean;
begin
  Result := False ;

  if FintOperacao <> NCR_OPERACAO_CARTAO_CREDITO then
    exit ;

  if AintTipoColeta = NCR_CODIGO_RETORNO_COLETAR_QTD_PARCELAS then
    Result := True ;

end;

function TTefCitelNCR.fTraduzirErro(const AintSts: Integer): String;
begin
  Result := TFormatarMensagemErro.fTraduzirErro(TParametroErro.CreateComContextoNCR(AintSts, FblnEmTransacao));
end;

function TTefCitelNCR.fTrataDataBanrisul(
  const AdtaDataColeta: TDateTime): String;
var
  LintDia, LintMes, LintAno: word ;
begin
  DecodeDate(AdtaDataColeta, LintAno, LintMes, LintDia);
  Result := Format('%2.2d',[LintDia]) + Format('%2.2d',[LintMes]) + copy(Format('%4.4d',[LintAno]), 3, 2) ;
end;

function TTefCitelNCR.fTrataMensagemInserirCartao(
  const AstrMensagem: String): String;
const
  ATUALIZATABELAS = 'atualizando tabelas' ;
var
  LstrUltima: String ;
  LintCnt: Integer ;
  LstrMensagem: String ;
begin
  LstrMensagem := fAjustaMensagemOperador(AstrMensagem) ;

  Result := LstrMensagem ;

  if pos(ATUALIZATABELAS, lowercase(LstrMensagem)) > 0 then
  begin
    FlstControleMensagemOperador.Clear ;
    FblnDesligaShowProcessamento := False ;
    Exit ;
  end ;

  if fEhMensagemInserirCartao(LstrMensagem) then
  begin
    FblnControleMensagemOperador := True ;
    LintCnt := FlstControleMensagemOperador.Count ;
    if LintCnt > 0 then
    begin
      LstrUltima := FlstControleMensagemOperador.Strings[pred(LintCnt)] ;
      if LstrUltima <> LstrMensagem then
      begin
        Result := 'Aguarde...' ;
        Exit ;
      end ;
    end ;
    FlstControleMensagemOperador.Add(LstrMensagem) ;
    Exit ;
  end ;

  if not FblnControleMensagemOperador then
    Exit ;

  FlstControleMensagemOperador.Add(LstrMensagem) ;
end;

function TTefCitelNCR.fTrataMenuDebitoNormal: String;
begin
  Result := '1' ;
  FintSinc := FintSinc or ACAO_PROX ;
end;

function TTefCitelNCR.fTrataMenuRetornado(AColeta: TParam_Coleta;
  const AintTipoColeta: Integer): String;
var
  LstrOpcao: String ;
  LintIndice: Integer ;
begin
  Result := '' ;

  LstrOpcao := lowercase(trim(String(fArrayToString(AColeta.MsgOp1)))) ;
  LintIndice := FlstMenuRetornado.IndexOf(LstrOpcao) ;
  if LintIndice < 0 then
  begin
    FlstMenuRetornado.Add(LstrOpcao) ;
    exit ;
  end ;

  // sempre a primeira opção será "S"
  if LintIndice = 0 then
    Result := '1'
  else
    Result := '0' ;

  FintSinc := FintSinc or ACAO_PROX;

end;

function TTefCitelNCR.fTrataPortaCom(const AstrComPort: String): Integer;
var
  LintCnt: Integer ;
  LstrAux: String ;
begin
  Result := 0 ;

  // se for automatico aborta
  if AstrComPort = 'AUTO' then
    exit ;

  LstrAux := '' ;
  for LintCnt := 1 to Length(AstrComPort) do
  begin
    if CharInSet(AstrComPort[LintCnt], ['0'..'9']) then
      LstrAux := LstrAux + AstrComPort[LintCnt] ;
  end ;
  if Trim(LstrAux) <> '' then
    Result := StrToInt(LstrAux) ;
end;

function TTefCitelNCR.fTrataPrePago(const AValorScope: String): String;
begin
  Result := 'N' ;
  if AValorScope = NCR_OPERACAO_CARTAO_CREDITO_PRE_PAGO then
    Result := 'S' ;
end;

function TTefCitelNCR.fInfoPixCadastro(out AListaInfo: TArrayInfoPix): Longint;
const
  MODO_PIX_SEM_INTERACAO_USUARIO = True;
begin
  Result := -1;
  SetLength(AListaInfo, 0);

  if Assigned(ScopeObtemListaCarteiraVirtualEx) then
  begin
    Result := AbreSessaoTEF(False, MODO_PIX_SEM_INTERACAO_USUARIO);
    if Result <> SCO_SUCESSO then
      Exit;
    try
      Result := fInfoPixCadastroInterno(AListaInfo);
    finally
      FechaSessaoTEF(1, 1, False) ;
    end;
  end;
end;

function TTefCitelNCR.fInfoPixCadastroInterno(
  out AListaInfo: TArrayInfoPix): Longint;
var
  LLista: stCV_ListaBandRede;
  LVersao: AnsiString;
  LServico: Word;
  LQtdStr: AnsiString;
  LQtd: Integer;
  LCnt: Integer;
  LCodBandeira: string;
  LNomeBandeira: string;
  LCodRede: string;
  LNomeRede: string;
  LItem: TInfoPix;
begin
  Result := -1;
  SetLength(AListaInfo, 0);

  if Assigned(ScopeObtemListaCarteiraVirtualEx) then
  begin
    {$WARN UNSAFE_CODE OFF}
    try
      LVersao := '01';
      LServico := 0;
      LLista := Default(stCV_ListaBandRede);
      LLista.Versao[0] := '0';
      LLista.Versao[1] := '1';
      LLista.QtdProdutos[0] := '2';
      LLista.QtdProdutos[1] := '4';

      Result := ScopeObtemListaCarteiraVirtualEx(
        PAnsiChar(LVersao),
        LServico,
        @LLista,
        SizeOf(LLista)
        );
      if Result = SCO_SUCESSO then
      begin
        SetString(LQtdStr, PAnsiChar(@LLista.QtdProdutos[0]), SizeOf(LLista.QtdProdutos));
        LQtd := StrToIntDef(Trim(string(LQtdStr)), 0);
        if LQtd > CARTVIRT_MAX_PRODUTOS then
          LQtd := CARTVIRT_MAX_PRODUTOS;
        for LCnt := 0 to LQtd - 1 do
        begin
          SetString(LQtdStr, PAnsiChar(@LLista.sProduto[LCnt].CodBandeira[0]),  SizeOf(LLista.sProduto[LCnt].CodBandeira));
          LCodBandeira := Trim(string(LQtdStr));

          SetString(LQtdStr, PAnsiChar(@LLista.sProduto[LCnt].szNomeBandeira[0]), SizeOf(LLista.sProduto[LCnt].szNomeBandeira));
          LNomeBandeira := Trim(string(LQtdStr));

          SetString(LQtdStr, PAnsiChar(@LLista.sProduto[LCnt].CodRede[0]), SizeOf(LLista.sProduto[LCnt].CodRede));
          LCodRede := Trim(string(LQtdStr));

          SetString(LQtdStr, PAnsiChar(@LLista.sProduto[LCnt].szNomeRede[0]), SizeOf(LLista.sProduto[LCnt].szNomeRede));
          LNomeRede := Trim(string(LQtdStr));

          LItem := Default(TInfoPix);
          LItem.CodigoRede := LCodRede;
          LItem.NomeRede := LNomeRede;
          LItem.CodigoBandeira := LCodBandeira;
          LItem.NomeBandeira := LNomeBandeira;

          SetLength(AListaInfo, Length(AListaInfo)+1);
          AListaInfo[High(AListaInfo)] := LItem;

        end;
      end;
    finally
      {$WARN UNSAFE_CODE ON}
    end;
  end;
end;

function TTefCitelNCR.fIniciaTransacaoTEF(const AintOpcao: Integer;
                                          const AfltValor: Double;
                                          const AstrDocVinculado: String;
                                          const AInfoCarteiraDigitalPix: String): LongInt;
var
  LstrValor: AnsiString ;
  LstrTaxa: AnsiString ;
  LintRet: LongInt ;
  LstrInfo: AnsiString;
  LCodigoBandeira: Word;
  LCodigoRede: Word;
  LCodigoServico: Word;
  LfltMinimo: Double;
  LstrMsgMinimo: String;
  LiFim: Cardinal;
begin
  FRegistraIntervalos.pInicioTransacao;

  LintRet := -1 ;
  if AintOpcao = NCR_OPERACAO_CARTAO_CREDITO then
  begin
    LstrValor := AnsiString(fValorNumericoNcr(AfltValor)) ;
    LstrTaxa  := AnsiString(fValorNumericoNcr(0)) ;

    if trim(AstrDocVinculado) <> '' then
    begin
      LstrInfo := AnsiString(fMontaAtributoAplicacao(AstrDocVinculado)) ;
      ScopeForneceCampo(SCOPE_DADO_ATRIBUTOS_APLIC, PAnsiChar(LstrInfo)) ;
    end ;
    LintRet := ScopeCompraCartaoCredito(PAnsiChar(AnsiString(LstrValor)), PAnsiChar(AnsiString(LstrTaxa)));
  end
  else if AintOpcao = NCR_OPERACAO_CARTAO_DEBITO then
  begin
    LstrValor := AnsiString(fValorNumericoNcr(AfltValor)) ;

    if trim(AstrDocVinculado) <> '' then
    begin
      LstrInfo := AnsiString(fMontaAtributoAplicacao(AstrDocVinculado)) ;
      ScopeForneceCampo(SCOPE_DADO_ATRIBUTOS_APLIC, PAnsiChar(LstrInfo)) ;
    end ;
    LintRet := ScopeCompraCartaoDebito(PAnsiChar(AnsiString(LstrValor)));
  end
  else if AintOpcao = NCR_OPERACAO_CARTEIRA_DIGITAL_PIX then
  begin
    LstrValor := AnsiString(fValorNumericoNcr(AfltValor)) ;
    FValorPix := fValorNumericoNcr(AfltValor);
    pExtraiDadosCarteiraDigitalPix(AInfoCarteiraDigitalPix,
                                   LCodigoBandeira,
                                   LCodigoRede,
                                   LCodigoServico);

    if fEhValorAbaixoDoMinimoAdquirente(LCodigoRede, AfltValor, LfltMinimo) then
    begin
      LstrMsgMinimo := Format(
        'Valor mínimo para PIX nesta adquirente é R$ %.2f. Informe um valor igual ou superior.',
        [LfltMinimo]) ;

      FstrMensagemErro := LstrMsgMinimo ;
      pLoga('[fIniciaTransacaoTEF] ' + FstrMensagemErro +
            ' | LCodigoRede=' + IntToStr(LCodigoRede) +
            ' | Valor=' + FloatToStr(AfltValor)) ;

      FProcessaRetorno.ProcessarStatus('999', LstrMsgMinimo) ;
      Self.NotificaObservers() ;
      Application.ProcessMessages ;

      LiFim := GetTickCount + 2000 ;
      while GetTickCount < LiFim do
      begin
        Sleep(50) ;
        Application.ProcessMessages ;
      end ;

      LintRet := -1 ;
      Result := LintRet ;
      Exit ;
    end;

    LintRet := ScopeCarteiraVirtualEx2(PAnsiChar(AnsiString(LstrValor)),
                                       LCodigoBandeira,
                                       LCodigoRede,
                                       LCodigoServico);
  end
  else if fEhOperacaoReimpressaoCartao then
  begin
    LintRet := ScopeReimpressaoComprovante ;
  end
  else if fEhOperacaoCancelamentoCartao then
  begin
    LstrValor := AnsiString(fValorNumericoNcr(AfltValor)) ;
    LstrTaxa  := AnsiString(fValorNumericoNcr(0)) ;
    LintRet := ScopeCancelamento(PAnsiChar(AnsiString(LstrValor)), PAnsiChar(AnsiString(LstrTaxa)))
  end ;

  Result := LintRet ;
end;

function TTefCitelNCR.fIntervaloDiasParcelasBanrisul: String;
begin
  Result := '' ;
  if FrecInfoReq.intPrimParcAvista = NCR_BANRISUL_PARCELA_COM_ENTRADA then
    Result := IntToStr(FrecInfoReq.intIntervaloParc)
  else if FrecInfoReq.intPrimParcAvista = NCR_BANRISUL_PARCELA_SEM_ENTRADA then
    Result := IntToStr(30) ;
end;

procedure TTefCitelNCR.NotificaObservers;
Var
  Observer : IObserverTEFCitel;
begin
  For Observer In FObservers Do
  begin
    Observer.AtualizaTefCitel(FRetorno);
  end;
end;

procedure TTefCitelNCR.pAbortarUltimoComando;
begin
  if not Assigned(ScopePPDisplay) then
  begin
    FstrMensagemErro := FstrMensagemErro + '[ScopePPDisplay] não foi possível carregar, verificar a versão da dll do Tef Scope' + #13#10 ;
    exit;
  end;

  try
    ScopePPDisplay(PAnsiChar(AnsiString(' '))) ;
  except
    On E: Exception do
    begin
      FstrMensagemErro := FstrMensagemErro + '[pAbortarUltimoComando] ' + E.Message + #13#10 ;
    end ;
  end;
end;

procedure TTefCitelNCR.pAtribuiValorStringComCondicao(
  const AblnCondicao: Boolean; var AstrVariavel: String; const AstrValor: String);
begin
  if AblnCondicao then
    AstrVariavel := AstrValor ;
end;

function TTefCitelNCR.pAtualizaMsgOperadorCliente(AColeta: TParam_Coleta; const AintTipoColeta: Integer): String;
var
  LstrMensagem: String ;
begin
  Result := '' ;
  LstrMensagem := '' ;

  if trim(String(fArrayToString(AColeta.MsgOp2))) <> '' then
    LstrMensagem := LstrMensagem + fAjustaMemsagemOperador(AColeta) ;

  if FRegistraIntervalos.fIntervaloEmRegistro then
  begin
    if fMsgRetira(LstrMensagem) then
      FRegistraIntervalos.pInicioEspera(tiRetirarCartao);
  end;

  if fMostraOpcoesCartaoCredito(AintTipoColeta) then
  begin
    Result := fOpcaoCartaoSelecionada ;
    LstrMensagem := 'Escolha uma Opção' ;
  end ;

  if fTemParcelamentoAdmLoja(AintTipoColeta) then
  begin
    Result := fOpcaoAdmLojaSelecionada ;
    if Result = '1' then
      FblnTemParcAdm := True ;
  end ;

  if fTemParcelasCredito(AintTipoColeta) then
    Result := fParcelaCartaoSeleciona ;

  if fApareceuPerguntaParaCancelarTransacao(AintTipoColeta) then
  begin
    Result := fCancelaOperacaoSelecionada ;
    Exit ;
  end ;

  if fEhOperacaoReimpressaoCartao then
    Result := fReimpressaoDocumentoSeleciona(AintTipoColeta) ;

  if fEhOperacaoCancelamentoCartao then
    Result := fCancelamentoDocumentoSeleciona(AintTipoColeta) ;

  if fEhDebitoBanrisul(LstrMensagem) then
  begin
    Result := fDebitoBanrisul ;
    FrecInfoReq.strModalidade := '' ;
    FblnDebitoBanrisul := True ;
  end ;

  if fEhDebito(AColeta) then
  begin
    if AintTipoColeta = NCR_CODIGO_RETORNO_AVISTA_APRAZO then
      Result := fTrataMenuDebitoNormal
    else
      Result := fDebito(LstrMensagem) ;
  end ;

  if fEhOpcoesPagamentoBanrisul(AintTipoColeta) then
  begin
    Result := fOpcoesPagamentoBanrisulSelecionada(AintTipoColeta) ;
    LstrMensagem := 'Escolha uma Opção' ;
  end ;

  pForcaProcessoCancelamento(AintTipoColeta) ;

  if fEhMenuRetornado(AintTipoColeta) then
  begin
    Result := fTrataMenuRetornado(AColeta, AintTipoColeta) ;
    LstrMensagem := '' ;
  end ;

  if fVaiExtenderTempoPix(AintTipoColeta) then
  begin
    Result := '0' ;
    FintSinc := FintSinc or ACAO_PROX;
    LstrMensagem := '' ;
  end;

  pMsgOperadorEAguardar(AintTipoColeta, AColeta) ;

  LstrMensagem := fAjustaMsgModoEntrada(LstrMensagem);

  FProcessaRetorno.ProcessarStatus('20', LstrMensagem);
  Self.NotificaObservers();
  Application.ProcessMessages;

end;

procedure TTefCitelNCR.pAtualizMsg(const AstrMensagem: String);
begin
  FProcessaRetorno.ProcessarStatus('20', AstrMensagem);
  Self.NotificaObservers();
  Application.ProcessMessages;
end;

procedure TTefCitelNCR.pAtualizMsg(AColeta: TColeta_Msg) ;
begin
  FProcessaRetorno.ProcessarStatus('20', fAjustaMemsagemOperador(AColeta));
  Self.NotificaObservers();
  Application.ProcessMessages;
end ;

procedure TTefCitelNCR.pAvisaOkClient;
begin
  if FrecCartao.strConteudoViaCliente <> '' then
    FProcessaRetorno.ProcessarStatus('OK', '');
end;

procedure TTefCitelNCR.pCarregaMensagensDePara;
begin
  FdictMensagensDePara.Add('NAO AUTORIZADAAUTORIZADA', 'NAO AUTORIZADA') ;
  FdictMensagensDePara.Add('NAO AUTORIZADO PSORIZADA', 'NAO AUTORIZADO') ;
  FdictMensagensDePara.Add('TENTE NOVAMENTEUTORIZADA', 'NAO AUTORIZADA') ;
  FdictMensagensDePara.Add('59CONTATE A CENT', '59 CONTATE A CENTRAL DO CARTAO') ;
end;

procedure TTefCitelNCR.pCarregaValoresMinimosAdquirente;
const
  CODIGO_REDE_PAGSEGURO = 160 ;
begin
  FdictValorMinimoAdquirente.Add(CODIGO_REDE_PAGSEGURO, 1.00) ;
end;

procedure TTefCitelNCR.pColetaCartaoAndamento(const AstrBufEntrAux: String;
  var AbyteAux: Byte; var AintRet: Integer);
begin
  if ( (AbyteAux = 2) or (AbyteAux = 0) ) then
  begin
    AbyteAux := 1;
    if Length (AstrBufEntrAux) <> 0 then
    begin
      // Vamos informar o SCOPE q o cartao foi digitado
      ScopeResumeParam(AintRet, '', SCO_NONE, COLETA_CANCELAR);
      Sleep (500);
    end;
  end
  else
    AbyteAux := 0;
end;

procedure TTefCitelNCR.pDepoisEvento(FDepois: TDepoisTefCartaoEvent; FRetorno: IRetornoTEFCitel);
begin
  if Assigned(FDepois) then
    FDepois(FRetorno) ;
end;

function TTefCitelNCR.fBuscaDadosTransacao: Boolean;
const
  Campo_TID        = $00004000;
  Campo_Referencia = $00008000;
  Campo_Cpf        = $00000200;
var
  LintRetorno: LongInt;
  LstrInfo:      array [1..128] of AnsiChar;
  LbtSeparador : Byte ;
  LstrData, LstrHora: String ;
  LstrNsuFepas: String ;
  LstrPrePago: String ;
  LstrXId: String;
  LstrCampoReferencia: String;
  LstrCampoCpf: String;
  LstrChavePixScope: String;
  LExpiracaoSegundos: Integer;
  LValorTrasacao: Double;
  LInfoReqPix: TInfoRequestPagamentoPix;
  LInfoResPix: TInfoResponsePagamentoPix;
  LInfoDatPix: TInfoDadosPagamentoPix;
  LIndoResDevPix: TInfoResponseDevolucaoPix;
  LInfoRequestPagamentoPix: String;
  LInfoResponsePagamentoPix: String;
  LInfoDadosPagamentoPix: String;
  LArr: TJsonArray;
  LValor: Double;
begin
  Result := False ;
  LstrNsuFepas := '' ;

  if fEhOperacaoReimpressaoCartao then
    Exit(True) ;

  LintRetorno := ScopeObtemHandle(0) ;
  if LintRetorno > $FFFF then
  begin
    LbtSeparador := ord(' ') ;
    {$WARN UNSAFE_CODE OFF}
    ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
    ScopeObtemCampoExt(LintRetorno, NCR_INFO_NSU_HOST, NCR_INFO_NADA_PARAMETRIZADO , LbtSeparador, @LstrInfo);
    FrecCartao.strNSU := Trim(String(fArrayToString(LstrInfo))) ;

    ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
    ScopeObtemCampoExt(LintRetorno, NCR_INFO_NSU, NCR_INFO_NADA_PARAMETRIZADO , LbtSeparador, @LstrInfo);
    LstrNsuFepas := Trim(String(fArrayToString(LstrInfo))) ;

    ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
    ScopeObtemCampoExt(LintRetorno, NCR_INFO_CODIGO_BANDEIRA, NCR_INFO_NADA_PARAMETRIZADO , LbtSeparador, @LstrInfo);
    FrecCartao.strBandeira := Trim(String(fArrayToString(LstrInfo))) ;

    ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
    ScopeObtemCampoExt(LintRetorno, NCR_INFO_CODIGO_REDE, NCR_INFO_NADA_PARAMETRIZADO , LbtSeparador, @LstrInfo);
    FrecCartao.strNomeRede := Trim(String(fArrayToString(LstrInfo))) ;

    FrecCartao.strNSU := fAjustaNSUVero(FrecCartao.strNSU, FrecCartao.strNomeRede) ;

    ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
    ScopeObtemCampoExt(LintRetorno, NCR_INFO_CODIGO_AUTORIZACAO, NCR_INFO_NADA_PARAMETRIZADO , LbtSeparador, @LstrInfo);
    FrecCartao.strAutorizacao := Trim(String(fArrayToString(LstrInfo))) ;

    ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
    ScopeObtemCampoExt(LintRetorno, NCR_INFO_VALOR_TRANSACAO, NCR_INFO_NADA_PARAMETRIZADO , LbtSeparador, @LstrInfo);
    FrecCartao.strValor := Trim(String(fArrayToString(LstrInfo))) ;

    ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
    ScopeObtemCampoExt(LintRetorno, NCR_INFO_DATA_LOCAL_TRANSACAO, NCR_INFO_NADA_PARAMETRIZADO , LbtSeparador, @LstrInfo);
    LstrData := Trim(String(fArrayToString(LstrInfo))) ;

    ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
    ScopeObtemCampoExt(LintRetorno, NCR_INFO_HORA_LOCAL_TRANSACAO, NCR_INFO_NADA_PARAMETRIZADO , LbtSeparador, @LstrInfo);
    LstrHora := Trim(String(fArrayToString(LstrInfo))) ;

    FrecCartao.strDataHora := Inttostr(YearOf(nOw)) + LstrData + LstrHora ;

    ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
    ScopeObtemCampoExt(LintRetorno, NCR_INFO_NUMERO_CARTAO, NCR_INFO_NADA_PARAMETRIZADO , LbtSeparador, @LstrInfo);
    FrecCartao.strEmbosso := Trim(String(fArrayToString(LstrInfo))) ;

    FrecCartao.strTipoTransacao := fRetornaTipoTransacao ;

    ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
    ScopeObtemCampoExt(LintRetorno, NCR_INFO_CONTROLE, NCR_INFO_NADA_PARAMETRIZADO , LbtSeparador, @LstrInfo);
    FrecCartao.strControle := Trim(String(fArrayToString(LstrInfo))) ;

    ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
    ScopeObtemCampoExt(LintRetorno, NCR_INFO_CONTROLE, NCR_INFO_NADA_PARAMETRIZADO , LbtSeparador, @LstrInfo);
    FrecCartao.strControle := Trim(String(fArrayToString(LstrInfo))) ;

    ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
    ScopeObtemCampoExt(LintRetorno, NCR_INFO_CODIGO_ESTABELECI, NCR_INFO_NADA_PARAMETRIZADO , LbtSeparador, @LstrInfo);
    FrecCartao.strCodigoEstabeleci := Trim(String(fArrayToString(LstrInfo))) ;

    FrecCartao.strNSU := fEscolheNsu(FrecCartao, LstrNsuFepas) ;

    ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
    ScopeObtemCampoExt2(LintRetorno, NCR_INFO_NADA_PARAMETRIZADO, NCR_INFO_NADA_PARAMETRIZADO, NCR_INFO_MODO_ENTRADA, LbtSeparador, @LstrInfo);
    FrecCartao.strModoEntrada := Trim(String(fArrayToString(LstrInfo))) ;

    if Assigned(ScopeObtemCampoExt3) then
    begin
      ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
      ScopeObtemCampoExt3(LintRetorno, NCR_INFO_NADA_PARAMETRIZADO, NCR_INFO_NADA_PARAMETRIZADO, NCR_INFO_NADA_PARAMETRIZADO, NCR_INFO_CARTAO_PRE_PAGO, LbtSeparador, @LstrInfo);
      LstrPrePago := Trim(String(fArrayToString(LstrInfo))) ;
      FrecCartao.strPrePago := fTrataPrePago(LstrPrePago) ;

      if FintOperacao = NCR_OPERACAO_CARTEIRA_DIGITAL_PIX then
      begin
        ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
        ScopeObtemCampoExt3(LintRetorno, NCR_INFO_NADA_PARAMETRIZADO, NCR_INFO_NADA_PARAMETRIZADO, NCR_INFO_NADA_PARAMETRIZADO, Campo_TID, NCR_INFO_NADA_PARAMETRIZADO, @LstrInfo);
        LstrXId := Trim(String(fArrayToString(LstrInfo))) ;
        FrecCartao.strXIdPix := LstrXId;

        ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
        ScopeObtemCampoExt3(LintRetorno, NCR_INFO_NADA_PARAMETRIZADO, NCR_INFO_NADA_PARAMETRIZADO, NCR_INFO_NADA_PARAMETRIZADO, Campo_Referencia, NCR_INFO_NADA_PARAMETRIZADO, @LstrInfo);
        LstrCampoReferencia := Trim(String(fArrayToString(LstrInfo))) ;
        FrecCartao.strCampoReferenciaPix := LstrCampoReferencia;

        ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
        ScopeObtemCampoExt3(LintRetorno, NCR_INFO_NADA_PARAMETRIZADO, NCR_INFO_NADA_PARAMETRIZADO, NCR_INFO_NADA_PARAMETRIZADO, Campo_Cpf, NCR_INFO_NADA_PARAMETRIZADO, @LstrInfo);
        LstrCampoCpf := Trim(String(fArrayToString(LstrInfo))) ;

        // monta os jsons de retorno do pix para manter a compatiblidade com o pix implementado na citel
        LstrChavePixScope := format('%s:%s', [FrecCartao.strBandeira, FrecCartao.strNomeRede]);
        LExpiracaoSegundos := 300; // 5 minutos
        LValorTrasacao := StrToIntDef(FrecCartao.strValor, 0)/100;

        LInfoReqPix := Default(TInfoRequestPagamentoPix);
        LInfoReqPix.calendario_expiracao := LExpiracaoSegundos;
        LInfoReqPix.devedor_cnpj := FCnpjDevedorPix;
        LInfoReqPix.devedor_nome := FNomeDevedorPix;
        LInfoReqPix.valor_original := LValorTrasacao;
        LInfoReqPix.chave := LstrChavePixScope;
        LInfoReqPix.solicitacaoPagador := FSolicitacaoPagadorPix;

        LInfoResPix := Default(TInfoResponsePagamentoPix);
        LInfoResPix.calendario_criacao := DateToISO8601(Now, False);
        LInfoResPix.calendario_expiracao := LExpiracaoSegundos;
        LInfoResPix.status := 'CONCLUIDA';
        LInfoResPix.txid := FrecCartao.strXIdPix;
        LInfoResPix.revisao := 0;
        LInfoResPix.location := FrecCartao.strQrCodePix;
        LInfoResPix.valor_original := LValorTrasacao;
        LInfoResPix.valor_modalidadeAlteracao := 0;
        LInfoResPix.chave := LstrChavePixScope;
        LInfoResPix.solicitacaoPagador := FSolicitacaoPagadorPix;
        LInfoResPix.brcode := FrecCartao.strQrCodePix;

        LInfoDatPix := Default(TInfoDadosPagamentoPix);
        LInfoDatPix.endToEndId := FrecCartao.strCampoReferenciaPix;
        LInfoDatPix.txid := FrecCartao.strXIdPix;
        LInfoDatPix.valor := LValorTrasacao;
        LInfoDatPix.horario := DateToISO8601(Now, False);
        LInfoDatPix.nomePagador := ''; // pix da scope não retorna o nome do pagador
        LInfoDatPix.pagador_cpf := LstrCampoCpf;
        LInfoDatPix.controle := FrecCartao.strControle;

        LInfoRequestPagamentoPix := fGerarJsonRequestPagamentoPix(LInfoReqPix);
        LInfoResponsePagamentoPix := fGerarJsonResponsePagamentoPix(LInfoResPix, LInfoDatPix);

        LArr := fGerarJsonDadosPagamentoPix(LInfoDatPix);
        try
          LInfoDadosPagamentoPix := StringReplace(LArr.ToJSON, '\/', '/', [rfReplaceAll]);
        finally
          FreeAndNil(LArr);
        end;

        FrecCartao.strRequestPagamentoPix := LInfoRequestPagamentoPix;
        FrecCartao.strResponsePagamentoPix := LInfoResponsePagamentoPix;
        FrecCartao.strDadosPagamentoPix := LInfoDadosPagamentoPix;
      end;
      if (FintOperacao = NCR_OPERACAO_CARTAO_CANCELAR) and
         (StrToIntDef(FModalidadeInterno,0)=CARTEIRA_DIGITAL_ESTORNO) then
      begin
        LIndoResDevPix := Default(TInfoResponseDevolucaoPix);
        LIndoResDevPix.id := FrecCartao.strControle;
        LIndoResDevPix.rtrId := FNumeroControleCancelamentoPix;
        LValor := StrToIntDef(FrecCartao.strValor, 0)/100;
        LIndoResDevPix.valor := FormatFloat('0.00', LValor, TFormatSettings.Invariant);
        LIndoResDevPix.horario_solicitacao := DateToISO8601(FInicioCancelamentoPix, False);
        LIndoResDevPix.horario_liquidacao := DateToISO8601(Now, False);
        LIndoResDevPix.status := 'DEVOLVIDO';
        LIndoResDevPix.motivo := 'Devolucao solicitada pelo cliente';
        FrecCartao.strResponseDevolucaoPix := fGerarJsonResponseDevolucaoPix(LIndoResDevPix);

        FrecCartao.strXIdPix := FrecCartao.strControle;

        ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
        ScopeObtemCampoExt3(LintRetorno, NCR_INFO_NADA_PARAMETRIZADO, NCR_INFO_NADA_PARAMETRIZADO, NCR_INFO_NADA_PARAMETRIZADO, Campo_Referencia, NCR_INFO_NADA_PARAMETRIZADO, @LstrInfo);
        LstrCampoReferencia := Trim(String(fArrayToString(LstrInfo))) ;
        FrecCartao.strCampoReferenciaPix := LstrCampoReferencia;
      end;

    end
    else
    begin
      FrecCartao.strPrePago := 'N' ;
      FrecCartao.strXIdPix := EmptyStr;
      FrecCartao.strCampoReferenciaPix := EmptyStr;
      FrecCartao.strRequestPagamentoPix := EmptyStr;
      FrecCartao.strResponsePagamentoPix := EmptyStr;
      FrecCartao.strDadosPagamentoPix := EmptyStr;
      FrecCartao.strResponseDevolucaoPix := EmptyStr;
    end;

    if Trim(FrecCartao.strConteudoViaCliente) = '' then
      Exit ;

    {$WARN UNSAFE_CODE ON}

    Result := True ;
  end ;
end;

function TTefCitelNCR.fBuscaDadosTransacaoEmAndamento: Boolean;
const
  String_QRCode	= $00000020;
var
  LintRetorno: LongInt;
  LstrInfo: array [1..512] of AnsiChar;
  LstrQrCode: String ;
begin
  Result := False ;
  LintRetorno := ScopeObtemHandle(HDL_TRANSACAO_EM_ANDAMENTO) ;
  if LintRetorno > $FFFF then
  begin
    if Assigned(ScopeObtemCampoExt3) then
    begin
      {$WARN UNSAFE_CODE OFF}
      ZeroMemory(@LstrInfo, SizeOf(LstrInfo));
      ScopeObtemCampoExt3(LintRetorno, NCR_INFO_NADA_PARAMETRIZADO, NCR_INFO_NADA_PARAMETRIZADO, NCR_INFO_NADA_PARAMETRIZADO, String_QRCode, NCR_INFO_NADA_PARAMETRIZADO, @LstrInfo);
      LstrQrCode := Trim(String(fArrayToString(LstrInfo))) ;
      pNotificaQrCodePix(LstrQrCode+'|'+FValorPix);
      FrecCartao.strQrCodePix := LstrQrCode;
      {$WARN UNSAFE_CODE ON}
    end;
    Result := True ;
  end;
end;

procedure TTefCitelNCR.pEncerraTransacao(const AintErro: LongInt);
begin
  if (AintErro = SCO_SUCESSO) then
    pAtualizMsg('Transacao completa');
end;

procedure TTefCitelNCR.pEnviarQrCode(const AstrDiretorio, AstrArquivo: String);
const
  ID_ARQUIVO_PINPAD: AnsiString = 'ARQ00001' ;
var
  LstrPathDiretorio: String ;
  LstrNomeArquivoImagem: String ;
  LInfoArquivo:  TAbecs_PPFile_Iinfo;
  LstrIdArquivoPinPad: AnsiString ;
  LstrNomeArquivo: AnsiString ;
  LstrDiretorio: AnsiString ;
begin
  if not Assigned(ScopePPMMFileLoad) then
  begin
    FstrMensagemErro := FstrMensagemErro + '[ScopePPMMFileLoad] não foi possível carregar, verificar a versão da dll do Tef Scope' + #13#10 ;
    exit;
  end;

  if not Assigned(ScopePPMMDisplayImage) then
  begin
    FstrMensagemErro := FstrMensagemErro + '[ScopePPMMDisplayImage] não foi possível carregar, verificar a versão da dll do Tef Scope' + #13#10 ;
    exit;
  end;

  LstrPathDiretorio := AstrDiretorio ;
  LstrNomeArquivoImagem := AstrArquivo ;
  {$WARN UNSAFE_CODE OFF}
  ZeroMemory(@LInfoArquivo, SizeOf(TAbecs_PPFile_Iinfo));

  LInfoArquivo.Version   := 1;
  LInfoArquivo.cFileType := AnsiChar(FILE_TYPE_PNG);

  LstrIdArquivoPinPad := AnsiString(ID_ARQUIVO_PINPAD);
  LstrNomeArquivo     := AnsiString(LstrNomeArquivoImagem);
  LstrDiretorio       := AnsiString(ReplaceStr(LstrPathDiretorio, '\', '\\'));

  // StrPLCopy: copia no máximo N chars e garante #0 final, sem ler além da fonte
  System.AnsiStrings.StrPLCopy(PAnsiChar(@LInfoArquivo.szFileNamePP), LstrIdArquivoPinPad,
            SizeOf(LInfoArquivo.szFileNamePP) - 1);
  System.AnsiStrings.StrPLCopy(PAnsiChar(@LInfoArquivo.szFileName), LstrNomeArquivo,
            SizeOf(LInfoArquivo.szFileName) - 1);
  System.AnsiStrings.StrPLCopy(PAnsiChar(@LInfoArquivo.szFilePath), LstrDiretorio,
            SizeOf(LInfoArquivo.szFilePath) - 1);

  ScopePPMMFileLoad(@LInfoArquivo) ;
  {$WARN UNSAFE_CODE ON}
  // apaga arquivo temporario da imagem
  if FileExists(LstrPathDiretorio + LstrNomeArquivoImagem) then
    DeleteFile(PWideChar(LstrPathDiretorio + LstrNomeArquivoImagem)) ;

  // mostra o arquivo no visor
  LstrIdArquivoPinPad := AnsiString(ID_ARQUIVO_PINPAD + #0) ;
  ScopePPMMDisplayImage(PAnsiChar(LstrIdArquivoPinPad));

  // deleta o arquivo do PinPad
  fDeletaArquivoNoPinPad(LstrIdArquivoPinPad) ;
end;

procedure TTefCitelNCR.pExtraiDadosAdicionaisPix(const AJson: String);
var
  LJsonValue: TJSONValue;
  LJsonObject: TJSONObject;
begin
  if Trim(AJson).IsEmpty then
    Exit;

  LJsonValue := TJSONObject.ParseJSONValue(AJson);
  try
    if not Assigned(LJsonValue) then
      Exit; // JSON inválido

    if LJsonValue is TJSONObject then
    begin
      LJsonObject := TJSONObject(LJsonValue);
      if not LJsonObject.TryGetValue<string>('solicitacaoPagador', FSolicitacaoPagadorPix) then
         FSolicitacaoPagadorPix := EmptyStr;

      if not LJsonObject.TryGetValue<string>('nomeDevedor', FNomeDevedorPix) then
         FNomeDevedorPix := EmptyStr;

      if not LJsonObject.TryGetValue<string>('cnpjDevedor', FCnpjDevedorPix) then
         FCnpjDevedorPix := EmptyStr;
    end;
  finally
    FreeAndNil(LJsonValue);
  end;

end;

procedure TTefCitelNCR.pExtraiDadosCarteiraDigitalPix(const ADados: String;
  out ACodigoBandeira, ACodigoRede, ACodigoServico: Word);
const
  PREFIXO = 'SCOPE:';
var
  LPartes: TArray<string>;
  LListaInfo: TArrayInfoPix;
  LRet: Integer;
  LDados: String;
begin
  ACodigoBandeira := 0;
  ACodigoRede := 0;
  ACodigoServico := 0;

  if (not Trim(ADados).IsEmpty) and (pos(PREFIXO, ADados) > 0) then
  begin
    LDados := ReplaceStr(ADados, PREFIXO, EmptyStr);
    LPartes := LDados.Split([':']);
    if Length(LPartes) >= 1 then
      ACodigoBandeira := StrToIntDef(LPartes[0], 0);
    if Length(LPartes) >= 2 then
      ACodigoRede := StrToIntDef(LPartes[1], 0);
    if Length(LPartes) >= 3 then
      ACodigoServico := StrToIntDef(LPartes[2], 0);
  end
  else
  begin
    // busca a primeira carteira digital
    LRet := fInfoPixCadastroInterno(LListaInfo);
    if LRet = SCO_SUCESSO then
    begin
      if Length(LListaInfo) >= 1 then
      begin
        ACodigoBandeira := StrToIntDef(LListaInfo[0].CodigoBandeira, 0);
        ACodigoRede := StrToIntDef(LListaInfo[0].CodigoRede, 0);
      end;
    end;
  end;

end;

procedure TTefCitelNCR.pFechaSessaoMultCartao;
begin
  if not FblnMultCartoes then
  begin
    FintSinc := FintSinc or ACAO_PROX;
    FechaSessaoTEF(SCO_DESFAZ_TEF);
  end
  else
  begin
    FintSinc := 6 ;
  end ;
end;

procedure TTefCitelNCR.pForcaProcessoCancelamento(
  const AintTipoColeta: Integer);
begin
  if AintTipoColeta = NCR_CODIGO_RETORNO_COLETAR_NUMERO_CARTAO then
    FintContinua := -1 ;

  if fEscolheuParcAdmMasTefNaoTem(AintTipoColeta) then
  begin
    FProcessaRetorno.ProcessarStatus('999', 'Adquirente Do Cartão Selecionado Não Possui Parc. ADM!');
    Self.NotificaObservers();
    Application.ProcessMessages;
    FintContinua := -1 ;
  end ;
end;

procedure TTefCitelNCR.pTrataDataPreDatadaCupomBanrisul(
  const AstrCupom: String);
const
  DEBITOEM = 'DEBITO EM:' ;
var
  LintPosicaoInicial: Integer ;
  LstrDataPre: String ;
  LarrData: TStringDynArray ;
  LstrAno, LstrMes, LstrDia: String ;
  LdtaDataPre: TDateTime ;
  LstrCupom: String ;
begin
  if not FblnDebitoBanrisul then
    Exit ;

  if not FblnPreDatado then
    Exit ;

  if trim(AstrCupom) = '' then
    Exit ;

  LstrCupom := AstrCupom ;

  LintPosicaoInicial := Pos(DEBITOEM, LstrCupom) ;

  if LintPosicaoInicial <= 0 then
    Exit ;

  LstrDataPre := trim(copy(LstrCupom, LintPosicaoInicial+Length(DEBITOEM), 13)) ;

  LarrData := SplitString(LstrDataPre, '/') ;

  if Length(LarrData) <> 3 then
    Exit ;

  LstrDia := fRetornaSomenteNumeros(LarrData[0]) ;
  LstrMes := fRetornaSomenteNumeros(LarrData[1]) ;
  LstrAno := fRetornaSomenteNumeros(LarrData[2]) ;
  LdtaDataPre := EncodeDate(strToInt(trim(LstrAno)), strToInt(trim(LstrMes)), strToInt(trim(LstrDia))) ;
  FrecCartao.intPrimeiroVencimento := trunc(LdtaDataPre-Date) ;
  FrecCartao.strTipDeb := DEBITO_PREDATADO ;
end;

procedure TTefCitelNCR.pTrataMensagemRetornadaScope(const AbyteAux: Byte;
  const AintRet: Integer; AColeta: TParam_Coleta;
  var AstrBufEntrAux: String; var AintAux: Integer);
begin
  if (AbyteAux <> 1) then
  begin
    FintSinc := FintSinc and not (ACAO_PROX + ACAO_ANTER + ACAO_CANCELAR);

    AstrBufEntrAux := pAtualizaMsgOperadorCliente(AColeta, AintRet) ;

    if (FintContinua = -1) and (FintOperacao<>NCR_OPERACAO_CARTEIRA_DIGITAL_PIX) then
      FintSinc := FintSinc or ACAO_CANCELAR ;

    // Proximo
    if (FintSinc and ACAO_PROX) <> 0 then
      AintAux := COLETA_PROXIMO_ESTADO
    // Anterior
    else if (FintSinc and ACAO_ANTER) <> 0 then
      AintAux := COLETA_ANTERIOR_ESTADO
    // Cancelar
    else if (FintSinc and ACAO_CANCELAR) <> 0 then
      AintAux := COLETA_CANCELAR;
  end;
end;

procedure TTefCitelNCR.pTrataParametros(const AstrParametros: String;
  var AintComPort: integer; var AstrMsgPP: String);
var
  LlstParametros: TStringList ;
  LstrComPort: String ;
  LstrMsgPP: String ;
begin
  LlstParametros := TStringList.Create ;
  try
    LlstParametros.Delimiter := ';' ;
    LlstParametros.StrictDelimiter := True ;
    LlstParametros.DelimitedText := AstrParametros ;
    LstrComPort := LlstParametros.Values['ComPort'] ;
    LstrMsgPP := LlstParametros.Values['MsgPP'] ;

    if Trim(LstrComPort) <> '' then
      AintComPort := fTrataPortaCom(LstrComPort) ;

    AstrMsgPP := fFormataMsgPP(LstrMsgPP) ;

  finally
    FreeAndNil(LlstParametros) ;
  end ;
end;

procedure TTefCitelNCR.pIncluiLinhaLog(const AstrValor: String);
begin
  FLog.Add(DateTimeToStr(NoW()) + ' - ' + AstrValor) ;
end;

procedure TTefCitelNCR.pInfo21(strModalidade: String);
begin
  FrecInfoReq.strModalidade := strModalidade;
  if FrecInfoReq.strModalidade = '3' then
    FrecCartao.strParcAdm := 'S' ;
end;

procedure TTefCitelNCR.pInfo30(strNumDoc: String; dtaData: TDate;
  intQtdParc: Integer);
begin
  FrecInfoReq.intQtdParc := intQtdParc;
end;

procedure TTefCitelNCR.pInfo30DebitoCredito1Minuto(
  const AintParcelaCdc: Integer);
begin

end;

procedure TTefCitelNCR.pInfo30DebitoParcelado(const AintQtdParc,
  AintIntervaloParc, AintPrimParcAvista: Integer; const AdtaPrimParcela: TDate);
begin
  FrecInfoReq.intQtdParc    := AintQtdParc;
  FrecInfoReq.intIntervaloParc := AintIntervaloParc;
  FrecInfoReq.intPrimParcAvista := AintPrimParcAvista;
  FrecInfoReq.dtaPrimParcela := AdtaPrimParcela;
end;

procedure TTefCitelNCR.pInfo30DebitoPreDatado(const AdtaDataPre: TDate);
begin
  FrecInfoReq.dtaDataPreDatado := AdtaDataPre ;
  FblnPreDatado := True ;
end;

procedure TTefCitelNCR.pInfo34(fltValTra: Double);
begin
  FrecInfoReq.fltValor := fltValTra;
end;

procedure TTefCitelNCR.pIniciaColetaCartao(var AbyteAux: Byte;
  var AintAux: Integer; var AstrBufEntrAux: String);
begin
  if AbyteAux = 0 then
  begin
    if Length (AstrBufEntrAux) <> 0 then
    begin
      AintAux := 0;  // Proximo estado
      AbyteAux := 1;
    end
    else
      AstrBufEntrAux := 'Coleta:';
  end;
end;

procedure TTefCitelNCR.pMsgOperadorEAguardar(const AintTipoColeta: Integer; AColeta: TParam_Coleta);
var
  LstrMsgOp1, LstrMsgOp2: String ;
begin
  if AintTipoColeta = NCR_CODIGO_RETORNO_AGUARDA_OPERADOR then
  begin
    LstrMsgOp1 := Trim(String(fArrayToString(AColeta.MsgOp1))) ;
    LstrMsgOp2 := Trim(String(fArrayToString(AColeta.MsgOp2))) ;
    if (LstrMsgOp1 <> '') or (LstrMsgOp2 <> '') then
    begin
      FstrMensagemOperadorAguardar := ifThen(LstrMsgOp1 <> '',  LstrMsgOp1 + #13+#10, '') ;
      FstrMensagemOperadorAguardar := FstrMensagemOperadorAguardar + fAjustaMensagemOperador(LstrMsgOp2) ;
    end ;
  end ;
end;

procedure TTefCitelNCR.pNotificaQrCodePix(const AQrCode: String);
begin
  FProcessaRetorno.ProcessarStatus('50', AQrCode);
  Self.NotificaObservers();
  Application.ProcessMessages;
end;

procedure TTefCitelNCR.pProcessamentoEmAndamento;
begin

  if FblnDesligaShowProcessamento then
    Exit ;

  FProcessaRetorno.ProcessarStatus('20', 'Aguarde... ' +  ifThen(FstrProcessandoChar = '*', '-', ifThen(FstrProcessandoChar = '.', '|',  FstrProcessandoChar ))  );
  Self.NotificaObservers();
  Application.ProcessMessages;

  case FstrProcessandoChar of
    '|' : FstrProcessandoChar := '/' ;
    '/' : FstrProcessandoChar := '-' ;
    '-' : FstrProcessandoChar := '.' ;
    '.' : FstrProcessandoChar := '*' ;
    '*' : FstrProcessandoChar := '\' ;
    '\' : FstrProcessandoChar := '|' ;
  end ;
end;

function TTefCitelNCR.fMontaAtributoAplicacao(const AstrValor: String): String;
var
  LintTamanho: Integer ;
begin
  LintTamanho := Length(AstrValor) ;
  Result := '0101'+Format('%3.3d',[LintTamanho])+AstrValor ;
end;

function TTefCitelNCR.fMostraOpcoesCartaoCredito(const AintTipoColeta: Integer): Boolean;
begin
  Result := False ;

  if FintOperacao <> NCR_OPERACAO_CARTAO_CREDITO then
    exit ;

  if AintTipoColeta = NCR_CODIGO_RETORNO_AVISTA_APRAZO then
  begin
    FProcessaRetorno.ProcessarStatus('21', NCR_MEIOS_PAGAMENTO_CREDITO_HABILITADOS);
    Self.NotificaObservers();
    Application.ProcessMessages;
    Result := True ;
  end ;

end;

function TTefCitelNCR.fMsgRetira(AstrMsg: string): Boolean;
begin
  AstrMsg := fTiraCaracEspeciais(AstrMsg).ToUpper;

  Result :=  AstrMsg.Contains('RETIR') and AstrMsg.Contains('CARTAO');
end;

function TTefCitelNCR.fConteudoLogErro: String;
var
  LstrPathLog: String;
  LlstConteudo: TStringList;
begin
  { Mesmo caminho que TTefCitelNCR usa para GRAVAR - ver pLogError nesta
    unit. Se os dois divergirem, o operador passa a ver um arquivo que nao
    e o que acabou de ser escrito. }
  Result := '';
  LstrPathLog := '';
  if Trim(FPathDLL) <> '' then
    if DirectoryExists(FPathDLL) then
      LstrPathLog := PathWithDelim(FPathDLL);

  if not FileExists(LstrPathLog + TEFCitelErro_Log) then
    Exit;

  LlstConteudo := TStringList.Create;
  try
    LlstConteudo.LoadFromFile(LstrPathLog + TEFCitelErro_Log);
    Result := LlstConteudo.Text;
  finally
    LlstConteudo.Free;
  end;
end;

function TTefCitelNCR.pRetornaLog: TStringList;
begin
  Result := FLog ;
end;

procedure TTefCitelNCR.pSair(blnSair: Boolean);
begin
  FblnSaiu := blnSair;

  pUsuarioEncerraTransacao;
end;

procedure TTefCitelNCR.pSetDadosAdicionaisTefTra(
  const aValue: IDadosAdicionaisTefTra);
begin
  FobjDadosAdicionaisTefTra := Nil ;
  FobjDadosAdicionaisTefTra := aValue ;
end;

procedure TTefCitelNCR.pSetLogErr(AProc: TprocGravaLogErr);
begin
  FProcLogErr := AProc ;
end;

procedure TTefCitelNCR.pSetPath(const AstrPath: String);
begin
  FPathDLL := AstrPath ;
end;

procedure TTefCitelNCR.pSetValueAntesCancelarTransacao(
  const AValue: TAntesTefCartaoEvent);
begin
  FAntesCancelarTransacao := AValue ;
end;

procedure TTefCitelNCR.pSetValueAntesPassarCartao(
  const AValue: TAntesTefCartaoEvent);
begin
  FAntesPassarCartao := AValue ;
end;

procedure TTefCitelNCR.pSetValueAntesReimpressao(
  const AValue: TAntesTefCartaoEvent);
begin
  FAntesReimpressao := AValue ;
end;

procedure TTefCitelNCR.pSetValueDepoisCancelarTransacao(
  const AValue: TDepoisTefCartaoEvent);
begin
  FDepoisCancelarTransacao := AValue ;
end;

procedure TTefCitelNCR.pSetValueDepoisFinalizarTransacao(
  const AValue: TDepoisFinalizarTransacaoEvent);
begin
  FDepoisFinalizarTransacao := AValue ;
end;

procedure TTefCitelNCR.pSetValueDepoisPassarCartao(
  const AValue: TDepoisTefCartaoEvent);
begin
  FDepoisPassarCartao := AValue ;
end;

procedure TTefCitelNCR.pSetValueDepoisReimpressao(
  const AValue: TDepoisTefCartaoEvent);
begin
  FDepoisReimpressao := AValue ;
end;

procedure TTefCitelNCR.pSetValueSucessoTefCartao(
  const AValue: TSucessoTefCartaoEvent);
begin
  FSucessoTefCartao := AValue ;
end;

procedure TTefCitelNCR.pUsuarioEncerraTransacao;
begin
  FintContinua := -1 ;
  FstrMensagemOperadorAguardar := '' ;
end;

procedure TTefCitelNCR.RemoveObserver(AObserver: IObserverTEFCitel);
begin
  FObservers.Delete(FObservers.IndexOf(AObserver));
end;

end.
