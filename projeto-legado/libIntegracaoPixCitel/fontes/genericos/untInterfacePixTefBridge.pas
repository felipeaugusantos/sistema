unit untInterfacePixTefBridge;

interface

type
  TRetornoTransacaoPixTef = record
    Status      : Integer;
    Mensagem    : AnsiString;
    NSU         : AnsiString;
    Autorizacao : AnsiString;
    Controle    : AnsiString;
    DataHora    : AnsiString;
    Bandeira    : AnsiString;
    Rede        : AnsiString;
    Valor       : Double;
    ChavePix    : AnsiString;
    JsonRequestPagamentoPix : AnsiString;
    JsonResponsePagamentoPix: AnsiString;
    JsonDadosPagamentoPix   : AnsiString;
    JsonResponseDevolucaoPix: AnsiString;
    XId         : AnsiString;
    End2EndId   : AnsiString;
    QrCode      : AnsiString;
    JsonExtra   : AnsiString;
  end;

  TPixTefStatusEvento = record
    Codigo      : Integer;
    Status      : AnsiString;
    Mensagem    : AnsiString;
    Finalizou   : LongBool;
    JsonExtra   : AnsiString;
  end;

  IPixTefStatusObserver = interface
    ['{B0249420-BF6E-4183-9004-ABC154C7958A}']
    procedure OnStatusTef(const AEvento: TPixTefStatusEvento); stdcall;
  end;

  IPixTefBridge = interface
    ['{A841CDDC-60FC-4555-A28C-CE1CB38F5A56}']
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

var
  objBridgeTef : IPixTefBridge = nil;

implementation

end.
