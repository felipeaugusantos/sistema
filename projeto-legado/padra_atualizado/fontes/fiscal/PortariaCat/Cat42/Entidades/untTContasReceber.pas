unit untTContasReceber;

interface

uses untTNotaFiscal,
     untTCentroCusto,
     untTPortador,
     untTParticipante,
     untTEvento,
     untTMovBan;

type
  TContasReceber = class(TObject)
    private
      FNumero: String;
      FEmpresa: String;
      FEspecie: String;
      FParcela: String;
      FHistorico: String;
      FHistoricoBaixa: String;
      FSeqCon: string;
      FEmpBai: string;
      FDataCadastro: TDateTime;
      FDataRecebimento: TDateTime;
      FDataVencimento: TDateTime;
      FDataBaixa: TDateTime;
      FValorOriginal: Double;
      FValorRecebido: Double;
      FValorPagoDinheiro: Double;
      FValorPagoChequePre: Double;
      FValorPagoChequeAvista: Double;
      FValorPagoCartao: Double;
      FValorPagoOrdemPagamento: Double;
      FJuros: Double;
      FDesconto: Double;
      FTituloDevolucao: Boolean;
      FTituloPagoBoleto: Boolean;
      FContaContabilDebito: String;
      FContaContabilCredito: String;
      FParticipante: TParticipante;
      FCentroCustoCadastro: TCentroCusto;
      FCentroCustoBaixa: TCentroCusto;
      FPortadorCadastro: TPortador;
      FPortadorBaixa: TPortador;
      FNotaFiscal: TNotaFiscal;
      FEvento: TEvento;
      FMovBan: TMovBan;
    public
      property strNumero: String read FNumero;
      property strEmpresa: String read FEmpresa;
      property strEspecie: String read FEspecie;
      property strHistorico: String read FHistorico write FHistorico;
      property strHistoricoBaixa: String read FHistoricoBaixa write FHistoricoBaixa;
      property strSeqCon: string read FSeqCon write FSeqCon;
      property strEmpBai: string read FEmpBai write FEmpBai;
      property dtaDataCadastro: TDateTime read FDataCadastro write FDataCadastro;
      property dtaDataRecebimento: TDateTime read FDataRecebimento write FDataRecebimento;
      property dtaDataBaixa: TDateTime read FDataBaixa write FDataBaixa;
      property dtaDataVencimento: TDateTime read FDataVencimento write FDataVencimento;
      property fltValorOriginal: Double read FValorOriginal write FValorOriginal;
      property fltValorRecebido: Double read FValorRecebido write FValorRecebido;
      property fltValorPagoDinheiro: Double read FValorPagoDinheiro write FValorPagoDinheiro;
      property fltValorPagoChequePre: Double read FValorPagoChequePre write FValorPagoChequePre;
      property fltValorPagoChequeAvista: Double read FValorPagoChequeAvista write FValorPagoChequeAvista;
      property fltValorPagoCartao: Double read FValorPagoCartao write FValorPagoCartao;
      property fltValorPagoOrdemPagamento: Double read FValorPagoOrdemPagamento write FValorPagoOrdemPagamento;
      property fltJuros: Double read FJuros write FJuros;
      property fltDesconto: Double read FDesconto write FDesconto;
      property blnTituloDevolucao: Boolean read FTituloDevolucao write FTituloDevolucao;
      property blnTituloPagoBoleto: Boolean read FTituloPagoBoleto write FTituloPagoBoleto;
      property strContaContabilDebito: String read FContaContabilDebito write FContaContabilDebito;
      property strContaContabilCredito: String read FContaContabilCredito write FContaContabilCredito;
      property strParcela: String read FParcela write FParcela;
      property participante: TParticipante read FParticipante write FParticipante;
      property centroCustoCadastro: TCentroCusto read FCentroCustoCadastro write FCentroCustoCadastro;
      property centroCustoBaixa: TCentroCusto read FCentroCustoBaixa write FCentroCustoBaixa;
      property portadorCadastro: TPortador read FPortadorCadastro write FPortadorCadastro;
      property portadorBaixa: TPortador read FPortadorBaixa write FPortadorBaixa;
      property notaFiscal: TNotaFiscal read FNotaFiscal write FNotaFiscal;
      property evento: TEvento read FEvento write FEvento;
      property movBan: TMovBan read FMovBan write FMovBan;

      constructor Create(strNumero, strEmpresa, strEspecie, strCodigoParticipante: String);

      destructor Destroy; override;
  end;

implementation

{ TContasReceber }

constructor TContasReceber.Create(strNumero, strEmpresa, strEspecie, strCodigoParticipante: String);
begin
  inherited create;

  FParticipante := TParticipante.Create;
  FCentroCustoCadastro := TCentroCusto.Create;
  FCentroCustoBaixa := TCentroCusto.Create;
  FPortadorCadastro := TPortador.Create;
  FPortadorBaixa := TPortador.Create;
  FNotaFiscal := TNotaFiscal.Create;

  FNumero := strNumero;
  FEmpresa := strEmpresa;
  FEspecie := strEspecie;
  FParticipante.strCodigo := strCodigoParticipante;
  FEvento := TEvento.Create;
  FMovBan := TMovBan.Create;
end;

destructor TContasReceber.Destroy;
begin
  FParticipante.Free;
  FEvento.Free;
  FCentroCustoCadastro.Free;
  FCentroCustoBaixa.Free;
  FPortadorCadastro.Free;
  FPortadorBaixa.Free;
  FNotaFiscal.Free;
  FMovBan.Free;

  inherited;
end;

end.
