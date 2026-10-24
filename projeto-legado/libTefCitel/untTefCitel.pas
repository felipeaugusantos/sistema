unit untTefCitel;

interface

uses
  Classes, SysUtils, DateUtils, Windows, Math,
  untInterfaceTefCitel, vcl.Forms,
  System.StrUtils, System.Generics.Collections, Uni, UniClientDataSet, Data.DB,AnsiStrings,
  vcl.ExtCtrls, vcl.AppEvnts, Winapi.Messages, untTefCitelComum, untTefcitelIntervalos;

Const
  TEFCliSiTef_Lib = 'CliSiTef32I.dll';
  SEPARADORLOG    = ' - ';

  strMsgAproximeCartao = 'Insira ou passe ou aproxime o cartao na leitora';
  strMsgPasseCartao    = 'Insira ou passe o cartao na leitora';
  strMsgDocInvalido    = 'Documento Invalido';
  strCarteiraPix       = '60110024';
  strMsgSemConexao     = 'Sem conexao Servidor';
  strMsgSemConexaoRet  = 'Sem conexão com o serviço de TEF, verifique sua internet!';
  strMsgSelTipoCancel  = 'Selecione o tipo de cancelamento';

type
   TLibHandle = THandle;
   TLogOcorrencia = class
     dtaMinima: TDateTime ;
     dtaMaxima: TDateTime ;
   end ;

type
  TTefCitel = class(TInterfacedObject, ITefCitel, ISubjectTEFCitel, ITefCitelV2)
  private
    FPathDLL: string;
    FInicializada: Boolean;
    FConfigurado: Boolean;
    FLista: TStringList;
    FObservers: TList<IObserverTEFCitel>;
    FRetorno : IRetornoTEFCitel;
    FProcessaRetorno: IProcessaRetornoTEFCitel;
    recCartao: TCartao;
    recInfoReq: TInfoRequisicao;
    FLog : TStringList;
    FLogSemLinhasDulicadas: TStringList;
    FContinua : Integer;
    blnVerTeclaEncerraTrans : Boolean;
    blnSaiu : boolean;
    blnPodeSair : Boolean;
    blnDocInvalido : Boolean;
    FAntesPassarCartao: TAntesTefCartaoEvent ;
    FDepoisPassarCartao: TDepoisTefCartaoEvent ;
    FDepoisFinalizarTransacao: TDepoisFinalizarTransacaoEvent ;
    FAntesCancelarTransacao: TAntesTefCartaoEvent ;
    FDepoisCancelarTransacao: TDepoisTefCartaoEvent ;
    FAntesReimpressao: TAntesTefCartaoEvent ;
    FDepoisReimpressao: TDepoisTefCartaoEvent ;
    FSucessoTefCartao: TSucessoTefCartaoEvent ;
    FblnSemConexaoServidor : Boolean;
    FblnPreDatado: Boolean ;
    FblnDebitoBanrisul: Boolean ;
    FobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra ;
    FRegistraIntervalos: TRegistraIntervalos;
    FProcLogErr: TprocGravaLogErr ;
    xVerificaPresencaPinPad : function(): integer; stdcall;
    FTefInfo: TTefInfo;

    xConfiguraIntSiTefInterativoEx : function (pEnderecoIP: PAnsiChar;
                                               pCodigoLoja: PAnsiChar;
                                               pNumeroTerminal: PAnsiChar;
                                               ConfiguraResultado: smallint;
                                               pParametrosAdicionais: PAnsiChar): integer; stdcall;

    xIniciaFuncaoSiTefInterativo : function (Modalidade: integer;
                                             pValor: PAnsiChar;
                                             pNumeroCuponFiscal: PAnsiChar;
                                             pDataFiscal: PAnsiChar;
                                             pHorario: PAnsiChar;
                                             pOperador: PAnsiChar;
                                             pRestricoes: PAnsiChar ): integer; stdcall;

    xContinuaFuncaoSiTefInterativo : function (var ProximoComando: SmallInt;
                                               var TipoCampo: LongInt;
                                               var TamanhoMinimo: SmallInt;
                                               var TamanhoMaximo: SmallInt;
                                               pBuffer: PAnsiChar;
                                               TamMaxBuffer: Integer;
                                               ContinuaNavegacao: Integer ): integer; stdcall;

    xFinalizaFuncaoSiTefInterativo : procedure (pConfirma: SmallInt;
                                                pCupomFiscal: PAnsiChar;
                                                pDataFiscal: PAnsiChar;
                                                pHoraFiscal: PAnsiChar;
                                                pParamAdic: PAnsiChar);stdcall;

    xObtemDadoPinPadDiretoEx : function(ChaveAcesso: PAnsiChar;
                                        Identificador: PAnsiChar;
                                        Entrada: PAnsiChar;
                                        Saida: PAnsiChar): Integer; stdcall;

    xObtemVersao: function(VersaoCliSiTef: PAnsiChar;
                           VersaoCliSiTefI: PAnsiChar): Integer; stdcall;

    xObtemInformacoesPinPad : function(Dados: PAnsiChar): Integer; stdcall;

    procedure pLoga(const AStrMsg: String);
    function FunctionDetect (const LibName, FuncName: String; var LibPointer: Pointer): boolean; overload ;
    function FunctionDetect (const LibName, FuncName: String; var LibPointer: Pointer;var LibHandle: TLibHandle ): boolean; overload ;
    function PathWithDelim(const APath : String) : String ;
    function FazerRequisicao(Funcao: Integer;
                             AHeader: AnsiString;
                             Valor: Double;
                             Documento: AnsiString;
                             ListaRestricoes: AnsiString;
                             strCodOperador: AnsiString): Integer;
    function ContinuarRequisicao(ImprimirComprovantes: Boolean): Integer;
    function fStrZero(Zeros:string;Quant:integer):String;
    function fCriaCdsTransPend : TUniClientDataSet;

    function fVerificaSair : Boolean;

    procedure LoadDLLFunctions ;
    function fVerificaDLLFunctionsCarregadas: Boolean ;
    procedure CliSiTefFunctionDetect( FuncName: AnsiString; var LibPointer: Pointer ) ;
    procedure fFinalizarTransacao(Confirma: Boolean;
                                  DataStr,
                                  HoraStr,
                                  DocumentoVinculado,
                                  ParamAdic: AnsiString);
    procedure pAddFieldDefs(AClient: TDataSet; AName: string; ADataType: TFieldType; ASize: Integer; ARequired: Boolean);
    procedure pMensagensUsuario(strMensagem, strBuffer : String);
    function fExtraiCodigoCarteiraDigital(const AstrValor: string): string ;
    function fEmptyStr(const AstrValue: String): Boolean;
    function fEscolheNsu(const ArecCartao: TCartao; AstrNsuFepas: string): string ;
    procedure pIncluiLinhaLog(const AstrValor: String) ;
    procedure pRetornoMensagemPix(const AstrConteudo: String) ;
    procedure pTrataDataPreDatadaCupomBanrisul(const AstrCupom: String) ;

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
    procedure pRemoveLinhasDuplicadasLog ;
    function fMensagemInfo: string;
  public
    function fConfiguraTefCitel(strEnderecoIp: PAnsiChar;
                                strCodigoLoja: PAnsiChar;
                                strNumTerminal: PAnsiChar;
                                strConfigResultado: Smallint;
                                strParametrosAdicionais: PAnsiChar;
                                blnSomenteCarregarLib: Boolean = False) : Integer;
    function fPassarCartao(intOperacao,
                           intQtdParcelas : Integer;
                           strModalidade: String;
                           strNumDoc: String;
                           fltValor: Double;
                           strCodOperador: String;
                           blnPagueFacil : Boolean;
                           strCodigoCarteiraDigital : string = '';
                           strJsonInfoAdicPix: String = '') : IRetornoTEFCitel;
    function IniciaFuncaoSiTefInterativo(Modalidade: integer;
                                         pValor: PAnsiChar;
                                         pNumeroCuponFiscal: PAnsiChar;
                                         pDataFiscal: PAnsiChar;
                                         pHorario: PAnsiChar;
                                         pOperador: PAnsiChar;
                                         pRestricoes: PAnsiChar ): integer;
    function ContinuaFuncaoSiTefInterativo(var ProximoComando: SmallInt;
                                           var TipoCampo: LongInt;
                                           var TamanhoMinimo: SmallInt;
                                           var TamanhoMaximo: SmallInt;
                                           pBuffer: PAnsiChar;
                                           TamMaxBuffer: Integer;
                                           ContinuaNavegacao: Integer ): integer;
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

    procedure FinalizaFuncaoSiTefInterativo(pConfirma: SmallInt;
                                            pCupomFiscal: PAnsiChar;
                                            pDataFiscal: PAnsiChar;
                                            pHoraFiscal: PAnsiChar;
                                            pParamAdic: PAnsiChar);

    function fObtemDadoPinPadDireto(AintTipoDocumento: Integer;
                                    AstrChaveAcesso: AnsiString;
                                    AstrIdentificador: AnsiString): AnsiString;

    function fObtemVersao: String;

    procedure pEncerraTransacao;

    procedure pSair(blnSair : Boolean);
    procedure pInfo34(fltValTra : Double);
    procedure pInfo21(strModalidade : String);
    procedure pInfo30(strNumDoc : String; dtaData : TDate; intQtdParc : Integer);
    procedure pInfo30DebitoPreDatado(const AdtaDataPre: TDate);
    procedure pInfo30DebitoCredito1Minuto(const AintParcelaCdc: Integer);
    procedure pInfo30DebitoParcelado(const AintQtdParc, AintIntervaloParc, AintPrimParcAvista: Integer; const AdtaPrimParcela: TDate) ;
    function fVerificaPresencaPinPad: TStatusPinPad;

    constructor Create;
    destructor Destroy; override;

    property PathDLL: string read FPathDLL write FPathDLL;
    property Inicializada: boolean read FInicializada write FInicializada;
    property Continua: Integer read FContinua write FContinua;

    property AntesPassarCartao: TAntesTefCartaoEvent read fGetValueAntesPassarCartao write pSetValueAntesPassarCartao ;
    property DepoisPassarCartao: TDepoisTefCartaoEvent read fGetValueDepoisPassarCartao write pSetValueDepoisPassarCartao ;
    property DepoisFinalizarTransacao: TDepoisFinalizarTransacaoEvent read fGetValueDepoisFinalizarTransacao write pSetValueDepoisFinalizarTransacao ;
    property AntesCancelarTransacao: TAntesTefCartaoEvent read fGetValueAntesCancelarTransacao write pSetValueAntesCancelarTransacao ;
    property DepoisCancelarTransacao: TDepoisTefCartaoEvent read fGetValueDepoisCancelarTransacao write pSetValueDepoisCancelarTransacao ;
    property AntesReimpressao: TAntesTefCartaoEvent read fGetValueAntesReimpressao write pSetValueAntesReimpressao ;
    property DepoisReimpressao: TDepoisTefCartaoEvent read fGetValueDepoisReimpressao write pSetValueDepoisReimpressao ;

    { ISubjectTEF }
    procedure AdicionaObserver(Observer: IObserverTEFCitel);
    procedure RemoveObserver(Observer: IObserverTEFCitel);
    procedure NotificaObservers();
    procedure pSetPath(const AstrPath: String) ;
    function pRetornaLog: TStringList ;
    function fConteudoLogErro: String;
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
    function fTraduzirErro(const AintSts: Integer): String;
    function fObtemInfoPinPad: String;
  end;

implementation

uses System.Types, System.Hash, untFormatarMensagemErro;

type
  TCampoTLV = record
    Id: Integer;
    Valor: String;
    Valido: Boolean;
  end;

const
  // Tamanho maximo do buffer de saida de ObtemInformacoesPinPad (CliSiTef).
  // Referencia: Manual de Integracao CliSiTef, funcao ObtemInformacoesPinPad
  // (retorno TLV com 6 campos, formato 2+3+N; folga aplicada sobre o maior
  // conjunto de valores observado em teste/homologacao).
  TAM_BUFFER_INFO_PINPAD_SITEF = 256;

function fProximoCampoTLV(const AInfo: String; var AIntPos: Integer): TCampoTLV;
var
  LintTam: Integer;
begin
  Result.Valido := False;
  if AIntPos + 4 > Length(AInfo) then
    Exit;

  if not TryStrToInt(Copy(AInfo, AIntPos, 2), Result.Id) then
    Exit;

  if not TryStrToInt(Copy(AInfo, AIntPos + 2, 3), LintTam) or (LintTam <= 0) then
    Exit;

  Result.Valor  := Trim(Copy(AInfo, AIntPos + 5, LintTam));
  AIntPos       := AIntPos + 5 + LintTam;
  Result.Valido := True;
end;

{ TTefCitel }

function TTefCitel.fPassarCartao(intOperacao,
                                 intQtdParcelas : Integer;
                                 strModalidade : String;
                                 strNumDoc: String;
                                 fltValor: Double;
                                 strCodOperador: String;
                                 blnPagueFacil : Boolean;
                                 strCodigoCarteiraDigital : string = '';
                                 strJsonInfoAdicPix: String = '') : IRetornoTEFCitel;
var
  sts: Integer;
begin
  Result := nil;

  if Assigned(FAntesPassarCartao) then
  begin
    if not FAntesPassarCartao then
      Exit ;
  end ;

  try
    FillChar(recInfoReq,SizeOf(recInfoReq),#0);
    recInfoReq.intOperacaoTefTra := intOperacao ;

    recCartao := Default(TCartao);
    recCartao.intPrimeiroVencimento := -1;
    recCartao.intPeriodo := 0;
    recCartao.strTipDeb := DEBITO_AVISTA ;
    recCartao.strPrePago := 'N' ;
    recCartao.strParcAdm := 'N' ;
    recCartao.strXIdPix := EmptyStr;
    recCartao.strCampoReferenciaPix := EmptyStr;
    recCartao.strQrCodePix := EmptyStr;
    recCartao.strRequestPagamentoPix := EmptyStr;
    recCartao.strResponsePagamentoPix := EmptyStr;
    recCartao.strDadosPagamentoPix := EmptyStr;
    recCartao.strResponseDevolucaoPix := EmptyStr;
    FProcessaRetorno.LimparRetorno ;
    FblnPreDatado           := False ;
    FblnDebitoBanrisul      := False ;
    recCartao.strTipoOperacao := TRetornaTipoOperacao.fGet(intOperacao) ;
    if ((intOperacao = 2) or (blnPagueFacil)) then
    begin
      recInfoReq.strModalidade := strModalidade;
      recInfoReq.strNumDoc     := strNumDoc;
      recInfoReq.intQtdParc    := intQtdParcelas;
      recInfoReq.fltValor      := fltValor;
    end;

    if intOperacao = CARTEIRA_DIGITAL then
    begin
      recInfoReq.strModalidade := strModalidade;
    end ;

    recCartao.strCodigoCarteiraDigital := fExtraiCodigoCarteiraDigital(strCodigoCarteiraDigital) ;

    if not Assigned(FRetorno) then
      FRetorno := TRetornoTEFCitel.Create;

    Sts := FazerRequisicao( intOperacao, 'CRT', fltValor, AnsiString(strNumDoc), AnsiString(strCodigoCarteiraDigital), AnsiString(strCodOperador)) ;

    FContinua := 0;

    if sts = 10000 then
      Sts := ContinuarRequisicao(True);

    if Sts <> 0 then
    begin
      FProcessaRetorno.ProcessarStatus(IntToStr(Sts), fTraduzirErro(Sts));
      Self.NotificaObservers();
    end
    else
    begin
      Result := FRetorno;
    end ;
  finally
    if Assigned(FDepoisPassarCartao) then
      FDepoisPassarCartao(Result) ;
  end ;
end;

procedure TTefCitel.RemoveObserver(Observer: IObserverTEFCitel);
begin
  FObservers.Delete(FObservers.IndexOf(Observer));
end;

function TTefCitel.fConsultaTransacoesPendentesTerminal : TUniClientDataSet;
var
  intContinua: Integer;
  ProximoComando, TamanhoMinimo, TamanhoMaximo : SmallInt;
  Resposta : AnsiString;
  TipoCampo: LongInt;
  Buffer: array [0..20000] of AnsiChar;
  Msg: String;
  strConteudo: String;
  ValorStr, DataStr, HoraStr : AnsiString;
  DataHora : TDateTime ;
  resultado : integer;
  fltValor : Double;
begin
  ProximoComando := 0;
  TipoCampo      := 0;
  TamanhoMinimo  := 0;
  TamanhoMaximo  := 0;
  intContinua    := 0;

  DataHora := nOw ;
  DataStr  := AnsiString(FormatDateTime('YYYYMMDD', DataHora));
  HoraStr  := AnsiString(FormatDateTime('HHMMSS', DataHora ));
  ValorStr := AnsiString(FloatToStrF(0, ffNumber, 12,2));

  IniciaFuncaoSiTefInterativo(130,
                              '',
                              '',
                              '',
                              '',
                              '',
                              '');

  Result := fCriaCdsTransPend;

  repeat
    resultado := ContinuaFuncaoSiTefInterativo(ProximoComando,
                                               TipoCampo,
                                               TamanhoMinimo,
                                               TamanhoMaximo,
                                               Buffer, sizeof(Buffer),
                                               intContinua);

    Msg := TrimRight(String(Buffer));

    if resultado = 10000 then
    begin
      if TipoCampo > 0 then
        Resposta := AnsiString(FLista.Values[IntToStr(TipoCampo)]);
      case ProximoComando of
        0:
        begin
          strConteudo := TrimRight(String(Buffer));
          case TipoCampo of
            210: recCartao.strTipoTransacao           := strConteudo;
            160:
            begin
              result.Append;
              result.FieldByName('NUMCUPOM').Value    := strConteudo;
            end;
            161:  result.FieldByName('IDCUPOM').Value := strConteudo;
            163:  result.FieldByName('DATA').Value    := copy(strConteudo,7,2) + '/' + copy(strConteudo,5,2) + '/' + copy(strConteudo,1,4);
            164:  result.FieldByName('HORA').Value    := copy(strConteudo,1,2) + ':' + copy(strConteudo, 3,2) + ':' + copy(strConteudo,5,2);
            1319:
            begin
              fltValor := StrToFloat(strConteudo) / 100;
              ValorStr := AnsiString(FloatToStrF(fltValor, ffNumber, 12,2));
              result.FieldByName('VALOR').Value := ValorStr;
              result.Post;
            end;
          end;
        end;
      end;
    end;
  until resultado <> 10000 ;
end;

procedure TTefCitel.pAddFieldDefs(AClient: TDataSet; AName: string; ADataType: TFieldType; ASize: Integer; ARequired: Boolean);
  var
    intCount : Integer;
Begin
  AClient.FieldDefs.AddFieldDef;
  intCount := AClient.FieldDefs.Count -1;
  AClient.FieldDefs[intCount].Name        := AName;
  AClient.FieldDefs[intCount].DataType    := ADataType;
  if ASize <> 0 then
    AClient.FieldDefs[intCount].Size        := ASize;
  AClient.FieldDefs[intCount].Required    := ARequired;
end;

function TTefCitel.fCriaCdsTransPend: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);

  pAddFieldDefs(Result, 'NUMCUPOM', ftString, 20, False);
  pAddFieldDefs(Result, 'IDCUPOM',  ftString, 20, False);
  pAddFieldDefs(Result, 'DATA',     ftString, 20, False);
  pAddFieldDefs(Result, 'HORA',     ftString, 20, False);
  pAddFieldDefs(Result, 'VALOR',    ftString, 20, False);

  Result.CreateDataSet;
end;

function TTefCitel.fEmptyStr(const AstrValue: String): Boolean;
begin
  result := trim(AstrValue) = '' ;
end;

function TTefCitel.fEscolheNsu(const ArecCartao: TCartao; AstrNsuFepas: string): string;
begin
  result := ArecCartao.strNSU ;

  if fEmptyStr(ArecCartao.strCodigoCarteiraDigital) then
    exit ;

  if fEmptyStr(AstrNsuFepas) then
    exit ;

  result := AstrNsuFepas ;
end;

function TTefCitel.fExtraiCodigoCarteiraDigital(
  const AstrValor: string): string;
var
  LintCnt: integer ;
  LstrRetorno: string ;
begin
  LstrRetorno := '' ;
  for LintCnt := 1 to Length(AstrValor) do
  begin
    if CharInSet(AstrValor[LintCnt], ['0'..'9']) then
    begin
      LstrRetorno := LstrRetorno + AstrValor[LintCnt] ;
    end ;
  end ;
  Result := LstrRetorno ;
end;

function TTefCitel.ContinuaFuncaoSiTefInterativo(var ProximoComando: SmallInt;
  var TipoCampo: Integer; var TamanhoMinimo, TamanhoMaximo: SmallInt;
  pBuffer: PAnsiChar; TamMaxBuffer, ContinuaNavegacao: Integer): integer;
begin
  LoadDLLFunctions;
  if Assigned(xContinuaFuncaoSiTefInterativo) then
    Result := xContinuaFuncaoSiTefInterativo( ProximoComando, TipoCampo, TamanhoMinimo,
                               TamanhoMaximo, pBuffer, TamMaxBuffer, ContinuaNavegacao)
  else
    Result := -1;
end;

constructor TTefCitel.Create;
begin
  FblnPreDatado           := False ;
  FblnDebitoBanrisul      := False ;
  xVerificaPresencaPinPad := nil;
  xConfiguraIntSiTefInterativoEx   := nil;
  xIniciaFuncaoSiTefInterativo     := Nil;
  xContinuaFuncaoSiTefInterativo   := nil;
  xFinalizaFuncaoSiTefInterativo   := Nil;
  xObtemDadoPinPadDiretoEx         := nil;
  xObtemVersao                     := nil;
  xObtemInformacoesPinPad          := nil;

  FLista                           := TStringList.Create;
  FLog                             := TStringList.Create;
  FLogSemLinhasDulicadas           := TStringList.Create;
  FObservers                       := TList<IObserverTEFCitel>.Create;
  FRetorno                         := TRetornoTEFCitel.Create;
  FProcessaRetorno                 := TProcessaRetornoTefCitel.Create(FRetorno);
  FRegistraIntervalos := TRegistraIntervalos.Create;
  FillChar(recInfoReq,SizeOf(recInfoReq),#0);
  blnSaiu                          := False;
  blnPodeSair                      := False;
  FAntesPassarCartao        := Nil ;
  FDepoisPassarCartao       := Nil ;
  FDepoisFinalizarTransacao := Nil ;
  FAntesCancelarTransacao   := Nil ;
  FDepoisCancelarTransacao  := Nil ;
  FAntesReimpressao         := Nil ;
  FDepoisReimpressao        := Nil ;
  FSucessoTefCartao         := Nil ;
  FblnSemConexaoServidor    := False;
  FobjDadosAdicionaisTefTra := Nil ;
  FProcLogErr               := Nil ;

  AddInfo(EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr);
end;

destructor TTefCitel.Destroy;
var
  LibHandle: TLibHandle ;
  LibName : WideString;
begin
  FreeAndNil(FLog) ;
  FreeAndNil(FLogSemLinhasDulicadas) ;
  if Assigned(recCartao.strCupom) then
    FreeAndNil(recCartao.strCupom);
  FreeAndNil(FRegistraIntervalos);
  LibName := ExtractFilePath(Application.ExeName);
  if Length(PathDLL) > 0 then
    LibName := PathWithDelim(PathDLL);

  LibHandle := LoadLibrary(PChar(LibName + TEFCliSiTef_Lib)) ;
  if LibHandle <> 0 then
    FreeLibrary(LibHandle) ;

  xVerificaPresencaPinPad := nil;
  xConfiguraIntSiTefInterativoEx      := Nil;
  xIniciaFuncaoSiTefInterativo     := Nil;
  xContinuaFuncaoSiTefInterativo   := Nil;
  xFinalizaFuncaoSiTefInterativo   := Nil;
  xObtemDadoPinPadDiretoEx         := nil;
  xObtemVersao                     := nil;
  xObtemInformacoesPinPad          := nil;

  inherited;
end;


procedure TTefCitel.AddInfo(const AMacAdress, AIPNumber, AUserName, AComputerName, ATerminalTEF: string);
begin
  FTefInfo.MacAdress := AMacAdress;
  FTefInfo.IPNumber  := AIPNumber;
  FTefInfo.UserName  := AUserName;
  FTefInfo.ComputerName := AComputerName;
  FTefInfo.TerminalTEF := ATerminalTEF;
end;

procedure TTefCitel.AdicionaObserver(Observer: IObserverTEFCitel);
begin
  FObservers.Add(Observer);
end;

procedure TTefCitel.CliSiTefFunctionDetect( FuncName: AnsiString; var LibPointer: Pointer ) ;
 var
   sLibName: string;
 begin
   if not Assigned( LibPointer )  then
   begin
     sLibName := '';
     if Length(PathDLL) > 0 then
       sLibName := PathWithDelim(PathDLL);

     sLibName := sLibName + TEFCliSiTef_Lib;

     if not FunctionDetect( sLibName, String(FuncName), LibPointer) then
     begin
       LibPointer := NIL ;
     end ;
   end ;
 end ;

function TTefCitel.FunctionDetect (const LibName, FuncName: String; var LibPointer: Pointer): boolean;
Var
  LibHandle: TLibHandle;
begin
  Result := FunctionDetect(LibName, FuncName, LibPointer, LibHandle);
end;

function TTefCitel.FunctionDetect(const LibName, FuncName: String; var LibPointer: Pointer;
  var LibHandle: TLibHandle): boolean;
begin
 Result := false;
 LibPointer := NIL;
 {$IFDEF FPC}
  LibHandle := dynlibs.LoadLibrary(LibName) ;
 {$ELSE}
  if LoadLibrary(PChar(LibName)) = 0 then
  begin
    try
      RaiseLastOSError ;
    except
      on e: EOSError do
      begin
        pLoga('DLL: [' + LibName + '] Função: [' + FuncName + '] Erro: [' + e.Message + ']!') ;
      end ;
    end ;
    exit;
  end ;

  LibHandle := GetModuleHandle(PChar(LibName));
 {$ENDIF}

 if LibHandle <> 0 then
  begin
     LibPointer := GetProcAddress(LibHandle, PChar(FuncName));
     if LibPointer <> NIL then
        Result := true;
  end;
end;

procedure TTefCitel.LoadDLLFunctions ;
begin
  if fInicializada then
    Exit;

  CliSiTefFunctionDetect('ConfiguraIntSiTefInterativoEx', @xConfiguraIntSiTefInterativoEx);
  CliSiTefFunctionDetect('IniciaFuncaoSiTefInterativo', @xIniciaFuncaoSiTefInterativo);
  CliSiTefFunctionDetect('ContinuaFuncaoSiTefInterativo', @xContinuaFuncaoSiTefInterativo);
  CliSiTefFunctionDetect('FinalizaFuncaoSiTefInterativo', @xFinalizaFuncaoSiTefInterativo);
  CliSiTefFunctionDetect('ObtemDadoPinPadDiretoEx', @xObtemDadoPinPadDiretoEx);
  CliSiTefFunctionDetect('VerificaPresencaPinPad', @xVerificaPresencaPinPad);
  CliSiTefFunctionDetect('ObtemVersao', @xObtemVersao);
  CliSiTefFunctionDetect('ObtemInformacoesPinPad', @xObtemInformacoesPinPad);
  fInicializada := True;
end ;


procedure TTefCitel.NotificaObservers;
Var
  Observer : IObserverTEFCitel;
begin
  For Observer In FObservers Do
  begin
    Observer.AtualizaTefCitel(FRetorno);
  end;

end;

function TTefCitel.fInfoPixCadastro(out AListaInfo: TArrayInfoPix): Longint;
begin
  Result := -1;
  SetLength(AListaInfo, 0);
end;

function TTefCitel.fMensagemInfo: string;
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

function TTefCitel.fObtemDadoPinPadDireto(AintTipoDocumento: Integer;
  AstrChaveAcesso, AstrIdentificador: AnsiString): AnsiString;
var
  LarrSaida: array [0..22] of AnsiChar;
  AintRetorno: Integer;
  AintDocLen: Integer;
const
  EntradaCelular  = '011111NUMERO CELULAR                  CONFIRME NUMERO |(xx) xxxxx-xxxx  ';
  EntradaCPF      = '011111Digite o Cpf                    Confirma o Cpf ? |xxx.xxx.xxx-xx  ';
  EntradaCNPJ    = '020808CNPJ Entre os 8 digitos iniciais Confirma os 8 ?|xx.xxx.xxx/     ' +
                     '0606CNPJ Entre os 6 digitos finais  Confirma os 6 ? |xxxx-xx         ';
begin
  Result := '';

  if Assigned(xObtemDadoPinPadDiretoEx) then
  begin
    case AintTipoDocumento of
      1: AintRetorno := xObtemDadoPinPadDiretoEx(PAnsiChar(AstrChaveAcesso), PAnsiChar(AstrIdentificador), PAnsiChar(EntradaCNPJ), LarrSaida);
      2: AintRetorno := xObtemDadoPinPadDiretoEx(PAnsiChar(AstrChaveAcesso), PAnsiChar(AstrIdentificador), PAnsiChar(EntradaCPF), LarrSaida);
      3: AintRetorno := xObtemDadoPinPadDiretoEx(PAnsiChar(AstrChaveAcesso), PAnsiChar(AstrIdentificador), PAnsiChar(EntradaCelular), LarrSaida);
    else
      AintRetorno := -1;
    end;

    if AintRetorno = 0 then
    begin
      if (AintTipoDocumento = 1) then
        AintDocLen := 19
      else
        AintDocLen := 14;

      Result := copy(TrimRight(LarrSaida), 5, AintDocLen);
      if (AintTipoDocumento = 1) then
        Delete(Result, 9, 2);
    end;
  end;
end;

function TTefCitel.fObtemVersao: String;
var
  LarrVersaoCliSiTef, LarrVersaoCliSiTefI: array [0..63] of AnsiChar;
  LintRet: Integer;
begin
  Result := '';

  if not Assigned(xObtemVersao) then
    Exit;

  try
    LintRet := xObtemVersao(LarrVersaoCliSiTef, LarrVersaoCliSiTefI);

    if LintRet = 0 then
      Result := Trim(String(LarrVersaoCliSiTef)) ;

    if (LintRet <> 0) or (Result = '') then
      raise LibTefDLLException.Create('Erro ao obter versão da DLL');
  except
    on LibE: LibTefDLLException do
      pLoga(LibE.Message);

    on E: Exception do
      pLoga('Erro ao obter versão DLL: ' +E.ClassName + '|' + E.Message);
  end;
end;

function TTefCitel.fObtemInfoPinPad: String;
var
  LarrSaida: array [0..TAM_BUFFER_INFO_PINPAD_SITEF - 1] of AnsiChar;
  LintRetorno: Integer;
  LstrInfo: String;
  LintPos: Integer;
  LCampo: TCampoTLV;
  LstrRotulo: String;
  LBuilder: TInfoPinPadBuilder;
begin
  Result := '';
  try
    if not Assigned(xObtemInformacoesPinPad) then
      Exit;

    {$WARN UNSAFE_CODE OFF}
    ZeroMemory(@LarrSaida, SizeOf(LarrSaida));
    {$WARN UNSAFE_CODE ON}

    LintRetorno := xObtemInformacoesPinPad(LarrSaida);

    if LintRetorno <> 0 then
    begin
      pLoga('ObtemInformacoesPinPad retornou: ' + IntToStr(LintRetorno));
      Exit;
    end;

    LstrInfo := String(TrimRight(LarrSaida));

    // Retorno TLV (Tipo-Tamanho-Valor) da CliSiTef:
    //   2 chars numericos = ID da informacao
    //   3 chars numericos = tamanho do valor
    //   N chars           = valor (largura variavel)
    LintPos := 1;
    LBuilder.Reset;

    LCampo := fProximoCampoTLV(LstrInfo, LintPos);
    while LCampo.Valido do
    begin
      if (LCampo.Id >= Low(ROTULOS_INFO_PINPAD_COMUM)) and (LCampo.Id <= High(ROTULOS_INFO_PINPAD_COMUM)) then
        LstrRotulo := ROTULOS_INFO_PINPAD_COMUM[LCampo.Id]
      else // resiliente a novos IDs futuros
        LstrRotulo := 'Campo ' + IntToStr(LCampo.Id);

      LBuilder.AddCampo(LstrRotulo, LCampo.Valor);

      LCampo := fProximoCampoTLV(LstrInfo, LintPos);
    end;

    Result := LBuilder.ToString;
  except
    on E: Exception do
    begin
      pLoga(fFormataMsgExcecao('fObtemInfoPinPad', E));
      Result := '';
    end;
  end;
end;

function TTefCitel.PathWithDelim(const APath : String) : String ;
begin
  Result := Trim(APath) ;
  if Result <> '' then
  begin
     {$IfDef FPC}
      Result := IncludeTrailingPathDelimiter(Result);
     {$Else}
      if RightStr(Result,1) <> PathDelim then
         Result := Result + PathDelim ;
     {$EndIf}
  end;
end ;

function TTefCitel.IniciaFuncaoSiTefInterativo(Modalidade: integer;
                                               pValor,
                                               pNumeroCuponFiscal,
                                               pDataFiscal,
                                               pHorario,
                                               pOperador,
                                               pRestricoes: PAnsiChar): integer;
begin
  LoadDLLFunctions;
  if Assigned(xIniciaFuncaoSiTefInterativo) then
    Result := xIniciaFuncaoSiTefInterativo( Modalidade, pValor, pNumeroCuponFiscal,
                               pDataFiscal, pHorario, pOperador, pRestricoes)
  else
    Result := -1;
end;

function TTefCitel.FazerRequisicao(Funcao: Integer;
                                   AHeader: AnsiString;
                                   Valor: Double;
                                   Documento: AnsiString;
                                   ListaRestricoes: AnsiString;
                                   strCodOperador: AnsiString): Integer;
Var
  ValorStr, DataStr, HoraStr : AnsiString;
  DataHora : TDateTime ;
begin
   if not Inicializada then
     Abort;

   FRegistraIntervalos.pInicioTransacao;

   DataHora := nOw ;
   DataStr  := AnsiString(FormatDateTime('YYYYMMDD', DataHora ));
   HoraStr  := AnsiString(FormatDateTime('HHMMSS', DataHora ));
   ValorStr := AnsiString(FloatToStrF(Valor, ffNumber, 12,2));

   Result := IniciaFuncaoSiTefInterativo( Funcao,
                                          PAnsiChar( ValorStr ),
                                          PAnsiChar( Documento ),
                                          PAnsiChar( DataStr ),
                                          PAnsiChar( HoraStr ),
                                          PAnsiChar( strCodOperador ),
                                          PAnsiChar( ListaRestricoes ) ) ;

   FLog.Clear;
   pIncluiLinhaLog(Format('IniciaFuncaoSiTefInterativo(Funcao=%s, Valor=%s, CupomFiscal=%s, DataFiscal=%s, HoraFiscal=%s, Operador=%s, ParamAdic=%s) --> %s', [
                                          inttostr(Funcao),
                                          ValorStr,
                                          Documento,
                                          DataStr,
                                          HoraStr,
                                          strCodOperador,
                                          ListaRestricoes,
                                          inttostr(Result)])) ;
end;

procedure TTefCitel.FinalizaFuncaoSiTefInterativo(pConfirma: SmallInt;
  pCupomFiscal, pDataFiscal, pHoraFiscal, pParamAdic: PAnsiChar);
begin
  LoadDLLFunctions;
 if Assigned(xFinalizaFuncaoSiTefInterativo) then
   xFinalizaFuncaoSiTefInterativo( pConfirma, pCupomFiscal, pDataFiscal,
                                   pHoraFiscal, pParamAdic);
end;

function TTefCitel.ContinuarRequisicao(ImprimirComprovantes: Boolean): Integer;
var
  ProximoComando, TamanhoMinimo, TamanhoMaximo : SmallInt;
  Resposta : AnsiString;
  TipoCampo: LongInt;
  Buffer: array [0..20000] of AnsiChar;
  Mensagem: String;
  strConteudo: String;
  nrDoc: String;
  strValor,
  strData,
  strHora : AnsiString;
  LstrNsuFepas : string;
  LstrDebitoDataPre: AnsiString ;
  LstrPrimeiraParc: AnsiString ;
  LstrAutNfce: string;
begin
  ProximoComando := 0;
  TipoCampo      := 0;
  TamanhoMinimo  := 0;
  TamanhoMaximo  := 0;
  blnVerTeclaEncerraTrans := False;
  FContinua      := 0;

  strData  := AnsiString(FormatDateTime('DDMMYYYY', recInfoReq.dtaData));
  strHora  := AnsiString(FormatDateTime('HHMMSS', recInfoReq.hraHora));
  //strValor := AnsiString(FloatToStrF(recInfoReq.fltValor, ffNumber, 12,2));

  LstrNsuFepas := '' ;
  LstrAutNfce := '' ;

  repeat
    Application.ProcessMessages;
    Result := ContinuaFuncaoSiTefInterativo(ProximoComando,
                                            TipoCampo,
                                            TamanhoMinimo,
                                            TamanhoMaximo,
                                            Buffer, sizeof(Buffer),
                                            FContinua);

    mensagem := TrimRight(String(Buffer));

    pIncluiLinhaLog(format('ContinuaFuncaoSiTefInterativo(Comando=%s, TipoCampo=%s, TamMinimo=%s, TamMaximo=%s, Buffer=%s, TamBuffer=%s, Continua=%s) --> %s ', [
                                            inttostr(ProximoComando),
                                            inttostr(TipoCampo),
                                            inttostr(TamanhoMinimo),
                                            inttostr(TamanhoMaximo),
                                            mensagem,
                                            inttostr(sizeof(Buffer)),
                                            inttostr(FContinua),
                                            inttostr(Result)]));

    if Result = 10000 then
    begin
      strConteudo := TrimRight(String(Buffer));

      blnPodeSair := ProximoComando = 23;
      case ProximoComando of
        0:
        begin
          case TipoCampo of
            100: recCartao.strTipoTransacao := IfThen(copy(strConteudo,3,2) <> '00', copy(strConteudo,3,2), copy(strConteudo,1,2));
            105: recCartao.strDataHora      := strConteudo;
            106: pRetornoMensagemPix(strConteudo) ;
            110: recCartao.blnCancelado     := True;
            121:
            begin
              if Assigned(recCartao.strCupom) then
                FreeAndNil(recCartao.strCupom);

              recCartao.strConteudoViaCliente := strConteudo;
              pTrataDataPreDatadaCupomBanrisul(recCartao.strConteudoViaCliente) ;
            end;
            122: recCartao.strConteudoViaLojista := strConteudo;
            131:
            begin
              FProcessaRetorno.ProcessarStatus('131', strConteudo);
              Self.NotificaObservers();
              Application.ProcessMessages;
              recCartao.strNomeRede           := strConteudo;
              FblnDebitoBanrisul := recCartao.strNomeRede = '00021' ;
            end;
            132: recCartao.strBandeira           := strConteudo;
            134: recCartao.strNSU                := strConteudo;
            135: recCartao.strAutorizacao        := strConteudo;
            138: recCartao.strValor              := strConteudo;
            157: recCartao.strCodigoEstabeleci   := strConteudo;
            160: nrDoc                           := strConteudo;
            952: LstrAutNfce                     := strConteudo;
            1190: recCartao.strEmbosso           := strConteudo;
            2333: FRegistraIntervalos.pFinalizaUltimaEspera;
            4077: LstrNsuFepas                   := strConteudo;
            4100: recCartao.strMotivoQuedaConexao := strConteudo;
            4221:
            begin
              if recInfoReq.intOperacaoTefTra = 3 then
                recCartao.strPrePago           := ifThen(StrToIntDef(strConteudo, 0) = 1, 'S', 'N') ;
            end ;
            5074: FRegistraIntervalos.pFinalizaUltimaEspera;
          end;
        end;
        1,2,3,4,22:
        begin
          if (ProximoComando = 3) and (TipoCampo = -1 ) then
          begin
            if strConteudo.ToUpper.Contains('APROX') and strConteudo.ToUpper.Contains('CARTAO') then
              FRegistraIntervalos.pInicioEspera(tiAproximarInserir);

            if strConteudo.ToUpper.Contains('SENHA') then
              FRegistraIntervalos.pInicioEspera(tiSenha);

            if strConteudo.ToUpper.Contains('RETIR') and strConteudo.ToUpper.Contains('CARTAO') then
              FRegistraIntervalos.pInicioEspera(tiRetirarCartao);
          end;

          if (ProximoComando = 1) and (TipoCampo = -1 ) then
          begin
            if strConteudo.ToUpper.Contains('SELECIONADO') then
              FRegistraIntervalos.pFimEspera(tiAproximarInserir, True);
          end;

          pMensagensUsuario(Mensagem, String(Buffer));
        end;
        20:
        begin
          Resposta := '0';
		  
          FProcessaRetorno.ProcessarStatus('20', Mensagem);
          Self.NotificaObservers();
          Application.ProcessMessages;

          case TipoCampo of
            507:
            begin
              Resposta := AnsiString(IntToStr(recInfoReq.intPrimParcAvista)) ;
              recCartao.intPrimeiroVencimento := 0 ; // 0 --> A vista
            end;
          end;

        end;
        21:
        begin
          if TipoCampo = -1 then
          begin
            if strConteudo.ToUpper.Contains('VISTA') and strConteudo.ToUpper.Contains('PARCELA') then
              FRegistraIntervalos.pInicioEspera(tiAvistaPrazo);
          end;

		      FProcessaRetorno.ProcessarStatus('21', Mensagem);
          Self.NotificaObservers();
          Application.ProcessMessages;							   								   									  
          Resposta := AnsiString(recInfoReq.strModalidade);
        end;
        23:
        begin
          FProcessaRetorno.ProcessarStatus('23', Mensagem);
          Self.NotificaObservers();
          Application.ProcessMessages;							   									  
        end;
        30:
        begin
		      FProcessaRetorno.ProcessarStatus('30', Mensagem);
          Self.NotificaObservers();
          Application.ProcessMessages;

          case TipoCampo of
            140:
            begin
              LstrPrimeiraParc := AnsiString(FormatDateTime('DDMMYYYY', recInfoReq.dtaPrimParcela));
              Resposta := LstrPrimeiraParc ;
              recCartao.intPrimeiroVencimento := trunc(recInfoReq.dtaPrimParcela-Date) ;
              recCartao.intPeriodo := DaysInMonth(recInfoReq.dtaPrimParcela) ;
            end ;
            505:
            begin
              FRegistraIntervalos.pInicioEspera(tiParcela);
              Resposta := AnsiString(IntToStr(recInfoReq.intQtdParc));
            end;
            506:
            begin
              LstrDebitoDataPre := AnsiString(FormatDateTime('DDMMYYYY', recInfoReq.dtaDataPreDatado));
              Resposta := LstrDebitoDataPre ;
              recCartao.intPrimeiroVencimento := trunc(recInfoReq.dtaDataPreDatado-Date) ;
            end ;
            508:
            begin
              Resposta := AnsiString(IntToStr(recInfoReq.intIntervaloParc)) ;
              recCartao.intPeriodo := recInfoReq.intIntervaloParc ;
            end ;
            511: Resposta := AnsiString(IntToStr(recInfoReq.intQtdParcCdc)) ;
            515: Resposta := strData;
            516: Resposta := AnsiString(recInfoReq.strNumDoc);
            1190: Resposta := AnsiString(recCartao.strEmbosso);
          end;
        end;
        34:
        begin
		      FProcessaRetorno.ProcessarStatus('34', Mensagem);
          Self.NotificaObservers();
          Application.ProcessMessages;
		  
          strValor := AnsiString(FloatToStrF(recInfoReq.fltValor, ffNumber, 12,2));			  
          Resposta := strValor;
        end;
        50:
        begin
          FProcessaRetorno.ProcessarStatus('50', Mensagem);
          Self.NotificaObservers();
          Application.ProcessMessages;
        end
        else
          blnPodeSair := False;
      end;

      Application.ProcessMessages;
    end;
    AnsiStrings.StrPCopy(Buffer, Resposta);
    Resposta := '' ;
  until Result <> 10000;

  FRegistraIntervalos.pFimTransacao;

  recCartao.strNSU := fEscolheNsu(recCartao, LstrNsuFepas) ;

  if trim(recCartao.strAutorizacao) = '' then
    recCartao.strAutorizacao := LstrAutNfce ;

  if trim(recCartao.strMotivoQuedaConexao) <> '' then
  begin
    if Pos(':10060:', recCartao.strMotivoQuedaConexao) > 0 then
      Result := -999 ;
    recCartao.strMotivoQuedaConexao := '' ;
  end ;

  FProcessaRetorno.ProcessarCartao(recCartao.strCupom,
                                   recCartao.strValor,
                                   recCartao.strBandeira,
                                   recCartao.strNomeRede,
                                   recCartao.strAutorizacao,
                                   recCartao.strNSU,
                                   recCartao.strTipoTransacao,
                                   IntToStr(recInfoReq.intQtdParc),
                                   recCartao.strNumeroControle,
                                   recCartao.strConteudoViaCliente,
                                   recCartao.strConteudoViaLojista,
                                   recCartao.strDataHora,
                                   recCartao.strChaPix,
                                   recCartao.strPixS_N,
                                   recCartao.strCodigoCarteiraDigital,
                                   recCartao.intPrimeiroVencimento,
                                   recCartao.intPeriodo,
                                   recCartao.strControle,
                                   recCartao.strTipDeb,
                                   Self.FobjDadosAdicionaisTefTra,
                                   recCartao.strCodigoEstabeleci,
                                   recCartao.strPrePago,
                                   FRegistraIntervalos.fObjIntervalos,
                                   recCartao.strParcAdm,
                                   recCartao.strModoEntrada,
                                   recCartao.strTipoOperacao,
                                   recCartao.strXIdPix,
                                   recCartao.strCampoReferenciaPix,
                                   recCartao.strQrCodePix,
                                   recCartao.strRequestPagamentoPix,
                                   recCartao.strResponsePagamentoPix,
                                   recCartao.strDadosPagamentoPix,
                                   recCartao.strResponseDevolucaoPix);

  if recCartao.strConteudoViaCliente <> '' then
    FProcessaRetorno.ProcessarStatus('OK', '');
end;

function TTefCitel.fStrZero(Zeros:string;Quant:integer):String;
Var
	I,Tamanho:integer;
	Aux: string;
begin
  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';
  For I := 1 To Tamanho Do
	If Aux[i] <> ',' Then
	  Zeros := Zeros + Aux[i];

  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';
  for I:=1 to Quant-Tamanho do
  Zeros:=Zeros + '0';
  Aux := Zeros + Aux;
  fStrZero := Aux;
end;

function TTefCitel.fConfiguraTefCitel(strEnderecoIp: PAnsiChar;
                                      strCodigoLoja: PAnsiChar;
                                      strNumTerminal: PAnsiChar;
                                      strConfigResultado: Smallint;
                                      strParametrosAdicionais: PAnsiChar;
                                      blnSomenteCarregarLib: Boolean = False) : Integer;
begin
  LoadDLLFunctions;
  if not fVerificaDLLFunctionsCarregadas then
  begin
    Result := -2;
    FConfigurado := False;
    exit ;
  end ;

  try
    if Assigned(xConfiguraIntSiTefInterativoEx) then
    begin
      Result := xConfiguraIntSiTefInterativoEx(strEnderecoIp,
                                               strCodigoLoja,
                                               strNumTerminal,
                                               strConfigResultado,
                                               strParametrosAdicionais);
    end
    else
      Result := -1;
  finally
    FConfigurado := True;
  end;
end;

procedure TTefCitel.fFinalizarTransacao(Confirma: Boolean;
                                        DataStr: AnsiString;
                                        HoraStr: AnsiString;
                                        DocumentoVinculado: AnsiString;
                                        ParamAdic: AnsiString);
Var
  Finalizacao : SmallInt;
begin
  try
    if Confirma then
      Finalizacao := 1
    else
      Finalizacao := 0;

    FinalizaFuncaoSiTefInterativo( Finalizacao,
                                   PAnsiChar( DocumentoVinculado ),
                                   PAnsiChar( DataStr ),
                                   PAnsiChar( HoraStr ),
                                   PAnsiChar( ParamAdic ) ) ;
  finally
    if Assigned(FDepoisFinalizarTransacao) then
      FDepoisFinalizarTransacao() ;
  end ;
end;

function TTefCitel.fGetDadosAdicionaisTefTra: IDadosAdicionaisTefTra;
begin
  Result := FobjDadosAdicionaisTefTra ;
end;

function TTefCitel.fGetValueAntesCancelarTransacao: TAntesTefCartaoEvent;
begin
  result := FAntesCancelarTransacao ;
end;

function TTefCitel.fGetValueAntesPassarCartao: TAntesTefCartaoEvent;
begin
  result := FAntesPassarCartao ;
end;

function TTefCitel.fGetValueAntesReimpressao: TAntesTefCartaoEvent;
begin
  result := FAntesReimpressao ;
end;

function TTefCitel.fGetValueDepoisCancelarTransacao: TDepoisTefCartaoEvent;
begin
  result := FDepoisCancelarTransacao ;
end;

function TTefCitel.fGetValueDepoisFinalizarTransacao: TDepoisFinalizarTransacaoEvent;
begin
  result := FDepoisFinalizarTransacao ;
end;

function TTefCitel.fGetValueDepoisPassarCartao: TDepoisTefCartaoEvent;
begin
  result := FDepoisPassarCartao ;
end;

function TTefCitel.fGetValueDepoisReimpressao: TDepoisTefCartaoEvent;
begin
  result := FDepoisReimpressao ;
end;

function TTefCitel.fGetValueSucessoTefCartao: TSucessoTefCartaoEvent;
begin
  result := FSucessoTefCartao ;
end;

function TTefCitel.fCancelaTransacaoTerminal(intFuncao: Integer;
                                             strCodOpe: AnsiString;
                                             dtaData: TDate;
                                             hraHora: TTime;
                                             numdoc: AnsiString;
                                             fltValor: Double;
                                             strModalidade: String;
                                             strCodigoCarteiraDigital : string;
                                             strModoEntrada: string) : IRetornoTEFCitel;//Boolean;
  var
  sts: Integer;
  strData : String;
  strHora : String;
begin
  Result := nil;

  if Assigned(FAntesCancelarTransacao) then
  begin
    if not FAntesCancelarTransacao then
      Exit ;
  end ;

  try
    FobjDadosAdicionaisTefTra := Nil ;
    FillChar(recInfoReq,SizeOf(recInfoReq),#0);
    recCartao := Default(TCartao);
    FProcessaRetorno.LimparRetorno ;
    recInfoReq.strModalidade := strModalidade;
    recInfoReq.strNumDoc     := String(numDoc);
    recInfoReq.dtaData       := dtaData;
    recInfoReq.hraHora       := hraHora;
    recInfoReq.fltValor      := fltValor;

    blnDocInvalido           := False;
    FblnSemConexaoServidor   := False;

    strData  := FormatDateTime('YYYYMMDD', dtaData);
    strHora  := FormatDateTime('HHMMSS', hraHora );

    recCartao.strCodigoCarteiraDigital := fExtraiCodigoCarteiraDigital(strCodigoCarteiraDigital) ;
    recCartao.strPrePago := 'N' ;
    recCartao.strParcAdm := 'N' ;
    recCartao.strXIdPix := EmptyStr;
    recCartao.strCampoReferenciaPix := EmptyStr;
    recCartao.strQrCodePix := EmptyStr;
    recCartao.strRequestPagamentoPix := EmptyStr;
    recCartao.strResponsePagamentoPix := EmptyStr;
    recCartao.strDadosPagamentoPix := EmptyStr;
    recCartao.strResponseDevolucaoPix := EmptyStr;

    if not Assigned(FRetorno) then
      FRetorno := TRetornoTEFCitel.Create;

    Sts := FazerRequisicao(intFuncao, 'CNC', fltValor, AnsiString(numdoc), AnsiString(strCodigoCarteiraDigital), strCodOpe) ;
    if sts = 10000 then
      Sts := ContinuarRequisicao(True);

    if Sts <> 0 then
    begin
      FProcessaRetorno.ProcessarStatus(IntToStr(Sts), fTraduzirErro(Sts));
      Self.NotificaObservers();
    end
    else
    begin
      fFinalizarTransacao(True, AnsiString(strData), AnsiString(strHora), AnsiString(numdoc), '');
      if Assigned(FSucessoTefCartao) then
        FSucessoTefCartao(FRetorno) ;
      Result := FRetorno;
    end;

  finally
    if Assigned(FDepoisCancelarTransacao) then
      FDepoisCancelarTransacao(Result) ;
  end ;
end;

function TTefCitel.fReimpressao(intFuncao: Integer;
                                strNumDoc: AnsiString;
                                strDtaTra: TDate;
                                strCodOpe: AnsiString;
                                fltValTra: Double) : IRetornoTEFCitel;
  var
    sts: Integer;
begin
  Result := nil;

  if Assigned(FAntesReimpressao) then
  begin
    if not FAntesReimpressao then
      Exit ;
  end ;

  try
    recInfoReq.strNumDoc     := String(strNumDoc);
    recInfoReq.dtaData       := strDtaTra;
    recInfoReq.fltValor      := fltValTra;
    recInfoReq.strModalidade := '3';

    recCartao := Default(TCartao);
    recCartao.strPrePago := 'N' ;
    recCartao.strParcAdm := 'N' ;
    recCartao.strXIdPix := EmptyStr;
    recCartao.strCampoReferenciaPix := EmptyStr;
    recCartao.strQrCodePix := EmptyStr;
    recCartao.strRequestPagamentoPix := EmptyStr;
    recCartao.strResponsePagamentoPix := EmptyStr;
    recCartao.strDadosPagamentoPix := EmptyStr;
    recCartao.strResponseDevolucaoPix := EmptyStr;

    if not Assigned(FRetorno) then
      FRetorno := TRetornoTEFCitel.Create;

    Sts := FazerRequisicao( intFuncao, '', fltValTra, AnsiString(strNumDoc), '', strCodOpe) ;
    if sts = 10000 then
      Sts := ContinuarRequisicao(True);

    if Sts <> 0 then
      fTraduzirErro(Sts)
    else
      Result := FRetorno;
  finally
    if Assigned(FDepoisReimpressao) then
      FDepoisReimpressao(Result) ;
  end ;
end;

function TTefCitel.fTraduzirErro(const AintSts: Integer): String;
begin
  Result := TFormatarMensagemErro.fTraduzirErro(TParametroErro.CreateComContextoTefCitel(AintSts,
    blnDocInvalido, FblnSemConexaoServidor));
end;

procedure TTefCitel.pIncluiLinhaLog(const AstrValor: String);
begin
  FLog.Add(DateTimeToStr(NoW()) + SEPARADORLOG + AstrValor) ;
end;

procedure TTefCitel.pEncerraTransacao;
begin
  FContinua := -1;
end;

procedure TTefCitel.pEnviarQrCode(const AstrDiretorio, AstrArquivo: String);
begin
  ///
end;

procedure TTefCitel.pSair(blnSair : Boolean);
begin
  blnSaiu := blnSair;

  if fVerificaSair then
    pEncerraTransacao;
end;

procedure TTefCitel.pTrataDataPreDatadaCupomBanrisul(const AstrCupom: String);
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
  recCartao.intPrimeiroVencimento := trunc(LdtaDataPre-Date) ;
  recCartao.strTipDeb := DEBITO_PREDATADO ;
end;

function TTefCitel.fVerificaDLLFunctionsCarregadas: Boolean;
begin
  Result := False ;
  if not Assigned(xConfiguraIntSiTefInterativoEx) then
    Exit ;
  if not Assigned(xIniciaFuncaoSiTefInterativo) then
    Exit ;
  if not Assigned(xContinuaFuncaoSiTefInterativo) then
    Exit ;
  if not Assigned(xFinalizaFuncaoSiTefInterativo) then
    Exit ;
  if not Assigned(xObtemDadoPinPadDiretoEx) then
    Exit ;
  Result := True ;
end;

function TTefCitel.fVerificaPresencaPinPad: TStatusPinPad;
  var
    intRetorno : Integer;
begin
  Result := sppNull;

  If Not Assigned(xVerificaPresencaPinPad) Then
    Exit;

  intRetorno := xVerificaPresencaPinPad;

  case intRetorno of
    0: Result := sppNaoExiste;
    1: Result := sppOperacional;
   -1: Result := sppBibliotecaDeAcessoNaoEncontrada;
  end;
end;

procedure TTefCitel.pSetDadosAdicionaisTefTra(
  const aValue: IDadosAdicionaisTefTra);
begin
  FobjDadosAdicionaisTefTra := Nil ;
  FobjDadosAdicionaisTefTra := AValue ;
end;

procedure TTefCitel.pSetLogErr(AProc: TprocGravaLogErr);
begin
  FProcLogErr := AProc ;
end;

procedure TTefCitel.pSetPath(const AstrPath: String);
begin
  FPathDLL := AstrPath ;
end;

procedure TTefCitel.pSetValueAntesCancelarTransacao(
  const AValue: TAntesTefCartaoEvent);
begin
  FAntesCancelarTransacao := AValue ;
end;

procedure TTefCitel.pSetValueAntesPassarCartao(
  const AValue: TAntesTefCartaoEvent);
begin
  FAntesPassarCartao := AValue ;
end;

procedure TTefCitel.pSetValueAntesReimpressao(
  const AValue: TAntesTefCartaoEvent);
begin
  FAntesReimpressao := AValue ;
end;

procedure TTefCitel.pSetValueDepoisCancelarTransacao(
  const AValue: TDepoisTefCartaoEvent);
begin
  FDepoisCancelarTransacao := AValue ;
end;

procedure TTefCitel.pSetValueDepoisFinalizarTransacao(
  const AValue: TDepoisFinalizarTransacaoEvent);
begin
  FDepoisFinalizarTransacao := AValue ;
end;

procedure TTefCitel.pSetValueDepoisPassarCartao(
  const AValue: TDepoisTefCartaoEvent);
begin
  FDepoisPassarCartao := AValue ;
end;

procedure TTefCitel.pSetValueDepoisReimpressao(
  const AValue: TDepoisTefCartaoEvent);
begin
  FDepoisReimpressao := AValue ;
end;

procedure TTefCitel.pSetValueSucessoTefCartao(
  const AValue: TSucessoTefCartaoEvent);
begin
  FSucessoTefCartao := AValue ;
end;

function TTefCitel.fVerificaSair : Boolean;
begin
  Result := False;

  if (blnSaiu) then
    Result := True;

  if (blnPodeSair) then
    Result := True;
end;

procedure TTefCitel.pMensagensUsuario(strMensagem, strBuffer : String);
begin
  if TrimRight(String(strBuffer)) <> '' then
  begin
    if (strMensagem = strMsgAproximeCartao) then
      strMensagem := strMsgAproximeCartao + '. Pressione 9 para CANCELAR.'
    else
    if (strMensagem = strMsgPasseCartao) then
      strMensagem := strMsgPasseCartao + '. Pressione 9 para CANCELAR.'
    else
    if (strMensagem = strMsgSelTipoCancel) then
      strMensagem := '';

    if strMensagem = strMsgDocInvalido then
    begin
      pEncerraTransacao;
      blnDocInvalido := True;
    end
    else if trim(lowercase(strMensagem)) = trim(lowercase(strMsgSemConexao)) then
    begin
      pEncerraTransacao;
      FblnSemConexaoServidor := True ;
    end
    else
    begin
      FProcessaRetorno.ProcessarStatus('20', strMensagem);
      Self.NotificaObservers();
      Application.ProcessMessages;
    end;

  end;
end;

procedure TTefCitel.pRemoveLinhasDuplicadasLog;
const
  DELIMITADOR = '|' ;
var
  LintCnt: Integer ;
  LarrLinha: TStringDynArray ;
  LstrLinha: String ;
  LstrAux: String ;
  LdictLogOcorrencias: TObjectDictionary<String,TLogOcorrencia> ;
  LlogOcorrencia: TLogOcorrencia ;
  LobjOcorrencia: TLogOcorrencia ;
  LstrHash: String ;
begin
  FLogSemLinhasDulicadas.Clear ;

  LdictLogOcorrencias := TObjectDictionary<String,TLogOcorrencia>.Create([doOwnsValues]);
  try
    for LintCnt := 0 to pred(FLog.Count) do
    begin
      LstrLinha := StringReplace(FLog.Strings[LintCnt], SEPARADORLOG, DELIMITADOR, []) ;
      LarrLinha := SplitString(LstrLinha, DELIMITADOR) ;
      LstrHash := THashMD5.GetHashString(LarrLinha[1]) ;

      if not LdictLogOcorrencias.ContainsKey(LstrHash) then
      begin
        LlogOcorrencia := TLogOcorrencia.Create ;
        LlogOcorrencia.dtaMinima := StrToDateTime(LarrLinha[0]) ;
        LlogOcorrencia.dtaMaxima := StrToDateTime(LarrLinha[0]) ;
        LdictLogOcorrencias.Add(LstrHash, LlogOcorrencia);
      end
      else
      begin
        LlogOcorrencia := LdictLogOcorrencias.Items[LstrHash] ;
        if StrToDateTime(LarrLinha[0]) > LlogOcorrencia.dtaMaxima then
        begin
          LlogOcorrencia.dtaMaxima := StrToDateTime(LarrLinha[0]) ;
        end ;
      end ;
    end ;

    LdictLogOcorrencias.TrimExcess;

    for LintCnt := 0 to pred(FLog.Count) do
    begin
      LstrLinha := StringReplace(FLog.Strings[LintCnt], SEPARADORLOG, DELIMITADOR, []) ;
      LarrLinha := SplitString(LstrLinha, DELIMITADOR) ;
      LstrHash := THashMD5.GetHashString(LarrLinha[1]) ;

      if LdictLogOcorrencias.ContainsKey(LstrHash) then
      begin
        LdictLogOcorrencias.TryGetValue(LstrHash, LobjOcorrencia) ;
        if (StrToDateTime(LarrLinha[0]) = LobjOcorrencia.dtaMinima ) or (StrToDateTime(LarrLinha[0]) = LobjOcorrencia.dtaMaxima) then
        begin
          LstrAux := LarrLinha[0] + SEPARADORLOG + LarrLinha[1] ;
          if FLogSemLinhasDulicadas.IndexOf(LstrAux) = -1 then
            FLogSemLinhasDulicadas.Add(LstrAux) ;
        end ;
      end
      else
        FLogSemLinhasDulicadas.Add(LarrLinha[0] + SEPARADORLOG + LarrLinha[1]) ;

    end ;

  finally
    FreeAndNil(LdictLogOcorrencias) ;
  end ;

end;

function TTefCitel.fConteudoLogErro: String;
var
  LstrPathLog: String;
  LlstConteudo: TStringList;
begin
  { Mesmo caminho que TTefCitel usa para GRAVAR - ver pLogError nesta
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

function TTefCitel.pRetornaLog: TStringList;
begin
  pRemoveLinhasDuplicadasLog ;
  Result := FLogSemLinhasDulicadas ;
end;

procedure TTefCitel.pRetornoMensagemPix(const AstrConteudo: String);
begin
  if AstrConteudo = strCarteiraPix then
  begin
    recCartao.strPixS_N := 'S';
    recCartao.strChaPix := 'TRANSACAO VIA DLL CLISITEF';
  end
  else
  begin
    recCartao.strPixS_N := 'N';
    recCartao.strChaPix := '';
  end ;
end;

procedure TTefCitel.pInfo34(fltValTra : Double);
begin
  recInfoReq.fltValor := fltValTra;
end;

procedure TTefCitel.pLimpaQrCode(const AstrMensagem: AnsiString);
begin
  //
end;

procedure TTefCitel.pLoga(const AStrMsg: String);
var
  LLogError: TextFile ;
  LstrPathLog: String ;
  LstrConteudoLog: String ;
  LMsgInfo: string;
  LMsgLog: string;
  LDataHoraFormatada: string;
begin
  LMsgLog := AStrMsg;
  LMsgInfo := self.fMensagemInfo;
  if Trim(LMsgInfo) <> '' then
    LMsgLog := LMsgInfo + ' - ' + AStrMsg;

  LstrPathLog := '' ;
  if trim(FPathDLL) <> '' then
    if DirectoryExists(FPathDLL) then
      LstrPathLog := PathWithDelim(FPathDLL) ;

  AssignFile(LLogError, LstrPathLog+TEFCitelErro_Log);
  try
    if FileExists(LstrPathLog+TEFCitelErro_Log) then
      Append(LLogError)
    else
      Rewrite(LLogError) ;

    LDataHoraFormatada := FormatDateTime('dd/mm/yyyy hh:mm:ss', Now());
    LstrConteudoLog := 'Data/Hora: ' + LDataHoraFormatada + ' --> ' + LMsgLog ;

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

procedure TTefCitel.pInfo21(strModalidade : String);
begin
  recInfoReq.strModalidade := strModalidade;
  if recInfoReq.strModalidade = '3' then
    recCartao.strParcAdm := 'S' ;
end;

procedure TTefCitel.pInfo30(strNumDoc : String; dtaData : TDate; intQtdParc : Integer);
begin
  recInfoReq.strNumDoc     := strNumDoc;
  recInfoReq.dtaData       := dtaData;
  recInfoReq.intQtdParc    := intQtdParc;
end;

procedure TTefCitel.pInfo30DebitoCredito1Minuto(const AintParcelaCdc: Integer);
begin
  recInfoReq.intQtdParcCdc := AintParcelaCdc ;
end;

procedure TTefCitel.pInfo30DebitoParcelado(const AintQtdParc,
  AintIntervaloParc, AintPrimParcAvista: Integer; const AdtaPrimParcela: TDate);
begin
  recInfoReq.intQtdParc    := AintQtdParc;
  recInfoReq.intIntervaloParc := AintIntervaloParc;
  recInfoReq.intPrimParcAvista := AintPrimParcAvista;
  recInfoReq.dtaPrimParcela := AdtaPrimParcela;
end;

procedure TTefCitel.pInfo30DebitoPreDatado(const AdtaDataPre: TDate);
begin
  recInfoReq.dtaDataPreDatado := AdtaDataPre ;
  FblnPreDatado := True ;
end;

end.
