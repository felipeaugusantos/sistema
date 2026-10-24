unit untTObserverTefAdapter;

interface

uses
  System.SysUtils, System.Classes,
  untInterfaceTefCitel,
  untInterfacePixTefBridge;

type
  // Adapta IObserverTEFCitel (mundo do TEF, "rico") para
  // IPixTefStatusObserver (mundo da lib do PIX, estável).
  TObserverTefAdapter = class(TInterfacedObject, IObserverTEFCitel)
  private
    FAlvo: IPixTefStatusObserver;
    FUltimaMsgStatus: string;
    function fTraduzCodigo(const AstrStatus: string): Integer;
    function fEhStatusTerminal(const AstrStatus: string): LongBool;
    function fExtraJson(ARetorno: IRetornoTEFCitel; const AValorPix: String): AnsiString;
  public
    constructor Create(const AAlvo: IPixTefStatusObserver);
    destructor Destroy; override;
    // IObserverTEFCitel
    procedure AtualizaTefCitel(Resposta: IRetornoTEFCitel);
    // Acesso ao alvo para o bridge fazer lookup no RemoveObserverPix
    property Alvo: IPixTefStatusObserver read FAlvo;
  end;

implementation

uses
  System.JSON, untFuncoes, untFuncoesSimples;

{ TObserverTefAdapter }

procedure TObserverTefAdapter.AtualizaTefCitel(Resposta: IRetornoTEFCitel);
var
  Levt: TPixTefStatusEvento;
  LStatus, LMsg: string;
  LCodigo: Integer;
  LstrValor: String;
  LMensagem: String;
  LarrPartes : TArray<String>;
begin
  // Pressuposto: libTefCitel.dll dispara este callback na main thread
  // (verificado em ambiente de debug 2026-05-23, ThreadID=MainThreadID).
  // O caller na cadeia (OnStatusTef) faz acesso VCL direto e cria
  // TPanel/TdxBarCode em fGerarQrCodeImagemPinPad. Se uma atualização
  // futura da libTefCitel.dll passar a usar worker thread, envolver
  // o corpo deste método em TThread.Queue(nil, procedure...).
  try
    if (Resposta = nil) or (Resposta.StatusTEF = nil) then
      Exit;

    LStatus := Resposta.StatusTEF.strStatus;
    LMsg    := Resposta.StatusTEF.strMensagem;

    if LStatus = '' then
      Exit;

    // Dedup: o TEF dispara NotificaObservers repetidas vezes com o mesmo
    // status enquanto espera o PinPad. Sem isso, a tela do PIX redesenha
    // a cada poll e cintila.
    if (LMsg+LStatus = FUltimaMsgStatus) and not fEhStatusTerminal(LStatus) then
      Exit;

    FUltimaMsgStatus := LMsg+LStatus;

    LCodigo := fTraduzCodigo(LStatus);
    LstrValor := EmptyStr;
    LMensagem := LMsg;
    if LCodigo = 5 then
    begin
      // separa o valor do pix e qr-code
      LarrPartes := LMensagem.Split(['|']);
      LMensagem := LarrPartes[0];
      if Length(LarrPartes) > 1 then
        LstrValor := LarrPartes[1];
    end;
    FillChar(Levt, SizeOf(Levt), 0);
    Levt.Codigo    := LCodigo;
    Levt.Status    := AnsiString(LStatus);
    Levt.Mensagem  := AnsiString(LMensagem);
    Levt.Finalizou := fEhStatusTerminal(LStatus);
    Levt.JsonExtra := fExtraJson(Resposta, LstrValor);

    if Assigned(FAlvo) then
      FAlvo.OnStatusTef(Levt);
  except
    on E: Exception do
    begin
      pGravarErro(True, 'TObserverTefAdapter.AtualizaTefCitel', E.Message);
    end;
  end;
end;

constructor TObserverTefAdapter.Create(const AAlvo: IPixTefStatusObserver);
begin
  inherited Create;
  FAlvo := AAlvo;
  FUltimaMsgStatus := '';
end;

destructor TObserverTefAdapter.Destroy;
begin
  FAlvo := nil;
  inherited;
end;

function TObserverTefAdapter.fEhStatusTerminal(
  const AstrStatus: string): LongBool;
var
  LSts: Integer;
begin
  // Eventos que encerram a transação. Tudo o resto é intermediário.
  Result := False;
  if TryStrToInt(AstrStatus, LSts) then
    Result := ((LSts = 500) or (LSts = 999));
end;

function TObserverTefAdapter.fExtraJson(ARetorno: IRetornoTEFCitel; const AValorPix: String): AnsiString;
var
  obj: TJSONObject;
  LValorPix: Double;
begin
  // Espaço de manobra. Coloque aqui o que a tela do PIX pode querer mostrar
  // mas que não merece um campo formal no record (ainda).
  Result := '';
  LValorPix := StrToIntDef(AValorPix, 0)/100;
  obj := TJSONObject.Create;
  try
    if Assigned(ARetorno.DadosCartao) then
    begin
      obj.AddPair('bandeira',  ARetorno.DadosCartao.strBandeira);
      obj.AddPair('rede',      ARetorno.DadosCartao.strNomeRede);
      obj.AddPair('autorizacao', ARetorno.DadosCartao.strAutorizacao);
      obj.AddPair('nsu',       ARetorno.DadosCartao.strNSU);
      obj.AddPair('chave_pix', ARetorno.DadosCartao.strChaPix);
      obj.AddPair('qrcode', ARetorno.DadosCartao.strQrCodePix);
      obj.AddPair('valor', TJSONNumber.Create(LValorPix));
    end;
    Result := AnsiString(obj.ToJSON);
  finally
    obj.Free;
  end;
end;

function TObserverTefAdapter.fTraduzCodigo(const AstrStatus: string): Integer;
var
  intSts: Integer;
begin
  if not TryStrToInt(AstrStatus, intSts) then
    Exit(0);

  case intSts of
    4, 20, 23      : Result := 0;   // info / mensagem genérica
    21, 30, 34     : Result := 1;   // aguardando entrada no PinPad
    131            : Result := 2;   // processando (rede capturada)
    500            : Result := 3;   // aprovado (sucesso)
    50             : Result := 5;   // mostrar QR-Code
    999            : Result := 9;   // erro
  else
    Result := 0;
  end;
end;

end.
