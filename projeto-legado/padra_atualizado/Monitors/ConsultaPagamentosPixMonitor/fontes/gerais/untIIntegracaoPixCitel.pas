unit untIIntegracaoPixCitel;

interface

uses
  untIDataset, untTiposPix, System.Classes;

Type
  IIntegracaoPixCitel = interface
    ['{F8E3DB7D-EE9D-41BC-A950-10AB7C8DF1B5}']
    function fGetDataSet: IDataSet;
    function fGetEmpresaLogada: String;
    function fICurrentDate: String;
    function fIMensagem(const strTitulo: String; const strTexto: String; arrOpcoes: Array Of String;
      intFocoBotao: Integer = 1; blnSaiComEsc: Boolean = False; intEstFon: Integer = 1; intWidBut: Integer = 0;
      blnAutoSize: Boolean = False; intSomarTop: Integer = 0): Integer;
    function fIRetAutoIncrem(const ATabela,
                                   AEmpresaLogada: String): String;
    function fIRetOperadorLogado: String;
  end;

  IIntegracaoPixCitelEx = interface(IIntegracaoPixCitel)
    ['{CC3999F9-9C55-466A-A363-015223982ABA}']
    function fICarregaImagemBanco(ANomeComponente, ANomeForm: String): TBytesStream;
  end;

Type
  IRequisicoesPix = interface
    ['{B8786509-E448-4A3F-82E9-FDD02EFE2550}']
    function CriarCobranca(ADadosRequisicao: String): String;
    function ConsultarPixPorTxId(ATxIdPix: String): TDadosRetornoPixConsulta; overload;
    function ConsultarPixPorTxId(ATxIdPix: String; AString: Boolean): String; overload;

    procedure VerificarToken;

    function GetChavePix: String;

    function AlterarCobranca(ADadosRequisicao, ATxIdPix: String): String;

    function SolicitarDevolucao(AIDPagamento, AIdDevolucao, ADadosDevolucao: String): String;

    function ConsultarDevolucao(AIDPagamento, AIdDevolucao: String): String;

    function ValidarDadosAutenticacao: String;

    function CancelarCobrancaShipay(AOrderId: String): String;

    function ConsultarPixPorTxId(ATxIdPix: String; AString: Boolean; ADadosRequisicao: String): String; overload;

    function GetRequisicaoPixAtualizadaShipay: String;

    function RemoverQRCodePixBaseCitel(ACNPJEmpresa, ACodigoEmpresa, AIxIdPix: String; AGravarLogErr: Boolean): Boolean;

    procedure SetExecutandoPeloRobo(AValor: String);

    function IncluirQRCodePixBoletoBaseCitel(ACodigoBanco, ATxIdPix, AQRCodePix, ADataCriacao, AExpiracao, AValorPix: String): String;

    function RetornaRefreshTokenGerado(ACodigoBanco, AAutoIncremChavePix: String): String;

    function GetCodigoDoBanco: String;

   {$IFDEF LINUX}
    function GetLastError: string;
   {$ENDIF}
    function CriarCobrancaTefScope(const ACorpoRequisicao: String;
                                   out   AJsonRequest,
                                         AJsonResponse,
                                         AJsonDados: String): boolean;

    procedure SetTxIdRemoverBancoBtg(ATxIdRemover: String);

    procedure SetIgnorarErro404Robo(AValor: String);
  end;

implementation

end.
