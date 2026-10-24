unit untTPixTefBridgeAutcom;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  untInterfaceTefCitel,
  untInterfacePixTefBridge,
  untTObserverTefAdapter;

type
  TPixTefBridgeAutcom = class(TInterfacedObject, IPixTefBridge)
  private
    FobjTefCitel: ITefCitel;
    FAssigManual: Boolean;
    FMensagemErro: String;
    FLock: TObject;
    FAdapters: TList<IObserverTEFCitel>;  // adapters vivos, indexados por busca linear
    function fLocalizaAdapter(const AObserver: IPixTefStatusObserver): IObserverTEFCitel;
    function fInstanciaTefCitel(out AInstanciaManual: Boolean; out AMensagemErro: String): Boolean;
  public
    class var FBridgeAutcom: IPixTefBridge;
    class function GetInstance(const ATefCitel: ITefCitel): IPixTefBridge; static;
    class procedure InvalidarInstance; static;

    constructor Create(const ATefCitel: ITefCitel); reintroduce;
    destructor Destroy; override;

    function fIniciarTransacaoPix(const AValor: Double;
                                  const ACodigoOperador: AnsiString;
                                  const AChavePix: AnsiString;
                                  const AMensagemSolicitacao: AnsiString;
                                  const ACnpjDevedor: AnsiString;
                                  const ANomeDevedor: AnsiString;
                                  out ARetorno: TRetornoTransacaoPixTef): LongBool; stdcall;
    function fCancelarTransacaoPix(const AValor: Double;
                                   const AControle: AnsiString;
                                   const ACodigoOperador: AnsiString;
                                   out ARetorno: TRetornoTransacaoPixTef): LongBool; stdcall;
    procedure pSair(const ASair : Boolean); stdcall;
    procedure AdicionaObserverPix(const AObserver: IPixTefStatusObserver); stdcall;
    procedure RemoveObserverPix(const AObserver: IPixTefStatusObserver); stdcall;
    procedure pEnviarQrCode(const AQrCode, AValor: String); stdcall;
    procedure pLimpaQrCode; stdcall;
  end;


implementation

uses
  untTefCitelUtil, System.JSON, untFuncoesSimples,
  untFuncoesGenerica, System.DateUtils, Vcl.Forms;

{ TPixTefBridgeAutcom }

procedure TPixTefBridgeAutcom.AdicionaObserverPix(
  const AObserver: IPixTefStatusObserver);
var
  adp: TObserverTefAdapter;
begin
  if not Assigned(AObserver) then
    Exit;

  System.TMonitor.Enter(FLock);
  try
    // Idempotente: chamar duas vezes não duplica observer.
    if fLocalizaAdapter(AObserver) <> nil then
      Exit;

    adp := TObserverTefAdapter.Create(AObserver);
    FAdapters.Add(adp);

    if Assigned(FobjTefCitel) then
      FobjTefCitel.AdicionaObserver(adp as IObserverTEFCitel);
  finally
    System.TMonitor.Exit(FLock);
  end;
end;

constructor TPixTefBridgeAutcom.Create(const ATefCitel: ITefCitel);
begin
  inherited Create;
  FobjTefCitel := ATefCitel;
  FAssigManual := False;
  FMensagemErro := EmptyStr;
  FLock := TObject.Create;
  FAdapters := TList<IObserverTEFCitel>.Create;
  Self.fInstanciaTefCitel(FAssigManual, FMensagemErro);
end;

destructor TPixTefBridgeAutcom.Destroy;
var
  adp: IObserverTEFCitel;
begin
  System.TMonitor.Enter(FLock);
  try
    for adp in FAdapters do
    begin
      if Assigned(FobjTefCitel) then
        FobjTefCitel.RemoveObserver(adp);
    end;
    FAdapters.Free;
  finally
    System.TMonitor.Exit(FLock);
  end;
  FreeAndNil(FLock);

  if FAssigManual then
    FobjTefCitel := Nil;

  inherited;
end;

function TPixTefBridgeAutcom.fCancelarTransacaoPix(const AValor: Double;
  const AControle, ACodigoOperador: AnsiString;
  out ARetorno: TRetornoTransacaoPixTef): LongBool;
var
  LNovoNumDoc : String;
  LArqViaCliente: String;
  LArqViaLojista: String;
  LstrDtaTra: String;
  LstrHraTra: String;
  LTipOpe : String;
  LModali : String;
  LSeqCon: String;
  LOperacao : Integer;
  LstrControle : String ;
  LstrAutoInc: String;
  LstrDataHora: String ;
  LValor: Double;
  LResult: IRetornoTEFCitel;
  LdtaDtaTra: TDate;
  LhraHraTra: TTime;
  LControle: AnsiString;
  LTipCar: String;
  LblnTefRetornouVazio: Boolean;
begin
  Result := False;
  ARetorno := Default(TRetornoTransacaoPixTef);
  LValor := AValor;
  LhraHraTra := fNow();
  LdtaDtaTra := DateOf(LhraHraTra);
  LControle := AControle;
  LTipCar := inttostr(CARTEIRA_DIGITAL_ESTORNO);
  LOperacao := 200; // estorno
  LNovoNumDoc := fRetNumDocTransacaoTef;
  LstrAutoInc   := fRetAutoIncrem('TEFTRA', VS_strCodEmp);

  if not fEmptyStr(FMensagemErro) then
  begin
    ARetorno.Status := 1;
    ARetorno.Mensagem := AnsiString(FMensagemErro);
    exit;
  end;

  LstrDataHora := Format('%.*d',[4, YearOf(LhraHraTra)]) + Format('%.*d',[2, MonthOf(LhraHraTra)]) + Format('%.*d',[2, DayOf(LhraHraTra)]) + Format('%.*d',[2, HourOf(LhraHraTra)]) + Format('%.*d',[2, MinuteOf(LhraHraTra)]) + Format('%.*d',[2, SecondOf(LhraHraTra)]) ;
  LstrDtaTra := copy(LstrDataHora,1,8);
  LstrHraTra := copy(LstrDataHora,9,6);

  //CNC INICIADO
  pGravaTransacaoCliSiTef(LNovoNumDoc,
                        LstrAutoInc,
                        '00000000000000',
                        LstrDtaTra,
                        LstrHraTra,
                        'N',
                        String(ACodigoOperador),
                        'DM',
                        LValor,
                        False,
                        False,
                        True,
                        EmptyStr,
                        EmptyStr,
                        EmptyStr,
                        EmptyStr,
                        EmptyStr,
                        EmptyStr,
                        EmptyStr,
                        0,
                        EmptyStr,
                        EmptyStr,
                        CANCELAMENTO_INICIADO,
                        EmptyStr,
                        True);

  { 9o parametro (strModoEntrada) exigido pela interface do modulo
    ^/libTefCitel. Esta linha e anterior ao recurso de modo de entrada e nao
    tem o fRetornaModoEntradaTransacao; vazio e o caminho suportado - o
    fAjustaMsgModoEntrada sai por 'if FModoEntrada.IsEmpty then Exit' e devolve
    a mensagem intacta, que e o comportamento de antes do recurso. }
  LResult := FobjTefCitel.fCancelaTransacaoTerminal(LOperacao,
                                                  ACodigoOperador,
                                                  LdtaDtaTra,
                                                  LhraHraTra,
                                                  AnsiString(LControle),
                                                  LValor,
                                                  LTipCar,
                                                  EmptyStr,
                                                  EmptyStr);

  if (not Assigned(LResult)) or fEmptyStr(LResult.DadosCartao.strConteudoViaCliente) then
  begin
    LblnTefRetornouVazio := Assigned(LResult) and fEmptyStr(LResult.DadosCartao.strConteudoViaCliente);
    LResult := nil;
    //CNC CANCEL
    pGravaTransacaoCliSiTef(LNovoNumDoc,
                          LstrAutoInc,
                          '00000000000000',
                          LstrDtaTra,
                          LstrHraTra,
                          'N',
                          String(ACodigoOperador),
                          'DM',
                          LValor,
                          False,
                          False,
                          True,
                          EmptyStr,
                          EmptyStr,
                          EmptyStr,
                          EmptyStr,
                          EmptyStr,
                          EmptyStr,
                          EmptyStr,
                          0,
                          EmptyStr,
                          EmptyStr,
                          CANCELAMENTO_CANCELADO,
                          EmptyStr,
                          True);

    if LblnTefRetornouVazio then
    begin
      ARetorno.Status := 2;
      ARetorno.Mensagem := AnsiString('Problema ao acessar rotina de cancelamento do Pix Scope!');
    end
    else
    begin
      ARetorno.Status := 3;
      ARetorno.Mensagem := AnsiString('Processo cancelado pelo operador!');
    end;
  end
  else
  begin
    LArqViaCliente := LResult.DadosCartao.strConteudoViaCliente;
    LArqViaLojista := LResult.DadosCartao.strConteudoViaLojista;
    LstrDtaTra        := copy(LResult.DadosCartao.strDataHoraTrans,1,8);
    LstrHraTra        := copy(LResult.DadosCartao.strDataHoraTrans,9,6);
    LstrControle     := LResult.DadosCartao.strControle;

    pGravaTransacaoCancelada(String(LControle), LdtaDtaTra, LTipOpe, LModali, LSeqCon);

    pGravaTransacaoCliSiTef(LNovoNumDoc,
                            LstrAutoInc,
                            fPadL(LResult.DadosCartao.strNSU, 14, '0'),
                            LstrDtaTra,
                            LstrHraTra,
                            'N',
                            String(ACodigoOperador),
                            'DM',
                            LValor,
                            True,
                            False,
                            True,
                            LResult.DadosCartao.strAutorizacao,
                            LArqViaCliente + #13 + LArqViaLojista,
                            LSeqCon,
                            LTipOpe,
                            LModali,
                            EmptyStr,
                            EmptyStr,
                            0,
                            EmptyStr,
                            LstrControle,
                            EmptyStr,
                            EmptyStr,
                            True);

    ARetorno.NSU := AnsiString(LResult.DadosCartao.strNSU);
    ARetorno.Autorizacao := AnsiString(LResult.DadosCartao.strAutorizacao);
    ARetorno.Controle := AnsiString(LResult.DadosCartao.strControle);
    ARetorno.DataHora := AnsiString(LResult.DadosCartao.strDataHoraTrans);
    ARetorno.Valor := LValor;
    ARetorno.JsonResponseDevolucaoPix := AnsiString(LResult.DadosCartao.strResponseDevolucaoPix);
    ARetorno.XId := AnsiString(LResult.DadosCartao.strXIdPix);
    ARetorno.End2EndId := AnsiString(LResult.DadosCartao.strCampoReferenciaPix);
    Result := True;
  end;

end;

function TPixTefBridgeAutcom.fIniciarTransacaoPix(const AValor: Double;
  const ACodigoOperador, AChavePix, AMensagemSolicitacao, ACnpjDevedor,
  ANomeDevedor: AnsiString; out ARetorno: TRetornoTransacaoPixTef): LongBool;
var
  LobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra ;
  LarrDocCartoes: TArrayInfoTraDoc;
  LRetornoTEFCitel: IRetornoTEFCitel;
  LNumDoc: String;
  LNumNsu: String;
  LDtaTra, LHraTra: String;
  LValor: Double;
  LComImp: String;
  LControle: String;
  LInfoAdicionalPix: String;
  LJson: TJSONObject;
  LblnSeraReenviada: Boolean;
begin
  Result := False;
  ARetorno := Default(TRetornoTransacaoPixTef);

  if not fEmptyStr(FMensagemErro) then
  begin
    ARetorno.Status := 1;
    ARetorno.Mensagem := AnsiString(FMensagemErro);
    exit;
  end;

  LValor := AValor;

  LJson := TJSONObject.Create;
  try
    LJson.AddPair('solicitacaoPagador', TJSONString.Create(String(AMensagemSolicitacao)));
    LJson.AddPair('nomeDevedor', TJSONString.Create(String(ANomeDevedor)));
    LJson.AddPair('cnpjDevedor', TJSONString.Create(String(ACnpjDevedor)));
    LInfoAdicionalPix := LJson.ToJSON;
  finally
    FreeAndNil(LJson);
  end;

  SetLength(LarrDocCartoes, 0) ;

  LNumDoc := fRetNumDocTransacaoTef;

  LobjDadosAdicionaisTefTra := TDadosAdicionaisTefTra
                                         .New
                                         .PixS_N('S')
                                         .OpcDoc('PX')
                                         .OpeRcx(EmptyStr)
                                         .ArrDocs(LarrDocCartoes)
                                         .NumDoc(LNumDoc)
                                         .Valor(AValor) ;

  LRetornoTEFCitel := fPassaCartao(NCR_OPERACAO_CARTEIRA_DIGITAL_PIX, //pix
                                   0,
                                   '1',
                                   EmptyStr,
                                   LValor,
                                   EmptyStr,
                                   False,
                                   String(AChavePix),
                                   LobjDadosAdicionaisTefTra,
                                   LInfoAdicionalPix,
                                   FobjTefCitel
                                  ) ;

  if Assigned(LRetornoTEFCitel) then
  begin
    LNumNsu := LRetornoTEFCitel.DadosCartao.strNSU;
    LDtaTra := copy(LRetornoTEFCitel.DadosCartao.strDataHoraTrans,1,8);
    LHraTra := copy(LRetornoTEFCitel.DadosCartao.strDataHoraTrans,9,6);
    LComImp := LRetornoTEFCitel.DadosCartao.strConteudoViaCliente;
    LControle := LRetornoTEFCitel.DadosCartao.strControle;

    pFinalizaTranscacao(True, LDtaTra, LHraTra, LNumDoc, '', FobjTefCitel);
    { Req. 470363 - a confirmacao nao chegou a estacao (canal caiu, ou o
      servico reiniciou). O Pix foi pago: segue como sucesso e nunca se
      desfaz; a TEFTRA fica PENDENTE e o operador e avisado. FobjTefCitel
      e a instancia da ponte, nao a global. }
    if fFinalizacaoTefNaoRealizada(LblnSeraReenviada, FobjTefCitel) then
    begin
      if LblnSeraReenviada then
        pDescreveFinalizacaoTef('R$ ' + FormatFloat('#,##0.00', LValor) +
                                ' (Controle ' + LControle + ')', FobjTefCitel);
      pAvisaFinalizacaoTefNaoRealizada(LblnSeraReenviada, LValor, LControle);
    end
    else
      pGravaTransacaoFinalizada(LNumDoc,
                                fPadL(LNumNsu, 14, '0'),
                                LDtaTra,
                                LHraTra,
                                EmptyStr,
                                EmptyStr,
                                LValor,
                                LComImp,
                                EmptyStr, //strSeqCon,
                                LControle);

    ARetorno.NSU := AnsiString(LRetornoTEFCitel.DadosCartao.strNSU);
    ARetorno.Autorizacao := AnsiString(LRetornoTEFCitel.DadosCartao.strAutorizacao);
    ARetorno.Controle := AnsiString(LRetornoTEFCitel.DadosCartao.strControle);
    ARetorno.DataHora := AnsiString(LRetornoTEFCitel.DadosCartao.strDataHoraTrans);
    ARetorno.Bandeira := AnsiString(LRetornoTEFCitel.DadosCartao.strBandeira);
    ARetorno.Rede := AnsiString(LRetornoTEFCitel.DadosCartao.strNomeRede);
    ARetorno.ChavePix := AChavePix;
    ARetorno.Valor := LValor;
    ARetorno.JsonRequestPagamentoPix := AnsiString(LRetornoTEFCitel.DadosCartao.strRequestPagamentoPix);
    ARetorno.JsonResponsePagamentoPix := AnsiString(LRetornoTEFCitel.DadosCartao.strResponsePagamentoPix);
    ARetorno.JsonDadosPagamentoPix := AnsiString(LRetornoTEFCitel.DadosCartao.strDadosPagamentoPix);
    ARetorno.XId := AnsiString(LRetornoTEFCitel.DadosCartao.strXIdPix);
    ARetorno.End2EndId := AnsiString(LRetornoTEFCitel.DadosCartao.strCampoReferenciaPix);
    ARetorno.QrCode := AnsiString(LRetornoTEFCitel.DadosCartao.strQrCodePix);
    Result := True;
  end
  else
  begin
    ARetorno.Status := 2;
    ARetorno.Mensagem := AnsiString('Problema ao acessar rotina do Pix Scope!');
  end;

end;

function TPixTefBridgeAutcom.fInstanciaTefCitel(
  out AInstanciaManual: Boolean; out AMensagemErro: String): Boolean;
begin
  Result := True;
  AInstanciaManual := False;
  AMensagemErro := EmptyStr;

  if Assigned(FobjTefCitel) then
    Exit;

  try
    FobjTefCitel := fInstanciaPixTef(VS_TefPix_PXCEMP, VS_TefPix_PXCPDV, AMensagemErro);
  except
    on E: Exception do
    begin
      FobjTefCitel := nil;
      AMensagemErro := 'Falha ao instanciar TEF Scope para Pix: ' + E.Message;
      Exit(False);
    end;
  end;

  AInstanciaManual := Assigned(FobjTefCitel);

  if not fEmptyStr(AMensagemErro) then
  begin
    FobjTefCitel := nil;
    AInstanciaManual := False;
    Exit(False);
  end;
end;

function TPixTefBridgeAutcom.fLocalizaAdapter(
  const AObserver: IPixTefStatusObserver): IObserverTEFCitel;
var
  intf: IObserverTEFCitel;
begin
  Result := nil;
  for intf in FAdapters do
    if (intf as TObserverTefAdapter).Alvo = AObserver then
      Exit(intf);
end;

class function TPixTefBridgeAutcom.GetInstance(
  const ATefCitel: ITefCitel): IPixTefBridge;
begin
  if not Assigned(FBridgeAutcom) then
    FBridgeAutcom := TPixTefBridgeAutcom.Create(ATefCitel);
  Result := FBridgeAutcom;
end;

class procedure TPixTefBridgeAutcom.InvalidarInstance;
begin
  FBridgeAutcom := nil;
end;

procedure TPixTefBridgeAutcom.pEnviarQrCode(const AQrCode, AValor: String);
var
  LPathDiretorio: String;
  LNomeArquivo: String;
begin
  if not Assigned(FobjTefCitel) then
    Exit;
  fGerarQrCodeImagemPinPad(AQrCode,
                           AValor,
                           Application.MainForm,
                           LPathDiretorio,
                           LNomeArquivo);

  FobjTefCitel.pEnviarQrCode(LPathDiretorio, LNomeArquivo);
end;

procedure TPixTefBridgeAutcom.pLimpaQrCode;
begin
  if not Assigned(FobjTefCitel) then
    Exit;
  FobjTefCitel.pLimpaQrCode(AnsiString(EmptyStr));
end;

procedure TPixTefBridgeAutcom.pSair(const ASair: Boolean);
begin
  if not Assigned(FobjTefCitel) then
    Exit;
  FobjTefCitel.pSair(ASair);
end;

procedure TPixTefBridgeAutcom.RemoveObserverPix(
  const AObserver: IPixTefStatusObserver);
var
  adp: IObserverTEFCitel;
begin
  if not Assigned(AObserver) then
    Exit;

  System.TMonitor.Enter(FLock);
  try
    adp := fLocalizaAdapter(AObserver);
    if adp = nil then
      Exit;

    if Assigned(FobjTefCitel) then
      FobjTefCitel.RemoveObserver(adp);

    FAdapters.Remove(adp);
  finally
    System.TMonitor.Exit(FLock);
  end;
end;

initialization

finalization
  TPixTefBridgeAutcom.FBridgeAutcom := nil;

end.
