unit untTContasPagar;

interface

uses System.Generics.Collections,
     untTParticipante,
     untTCentroCusto,
     untTPortador,
     untTEvento,
     untTMovBan;

type
  TRateio = class
  private
    FCentroCusto: TCentroCusto;
    FFatorCalculo: double;
  public
    property centroCusto: TCentroCusto read FCentroCusto write FCentroCusto;
    property fltFatorCalculo: double read FFatorCalculo write FFatorCalculo;

    constructor create;
    destructor Destroy; override;
  end;

  TContasPagar = class(TObject)
    private
      FSerie: string;
      FNumero: string;
      FEmpresa: string;
      FParcela: string;
      FHistorico: string;
      FHistorico2: string;
      FHistoricoBaixa: string;
      FContaContabilDebito: string;
      FContaContabilCredito: string;
      FDataCadastro: TDateTime;
      FDataPagamento: TDateTime;
      FDataBaixa: TDateTime;
      FDataVencimento: TDateTime;
      FValorPagoChequePre: Double;
      FValorPagoChequeAvista: Double;
      FValorOriginal: Double;
      FValorPago: Double;
      FJuros: Double;
      FDesconto: Double;
      FParticipante: TParticipante;
      FCentroCustoCadastro: TCentroCusto;
      FCentroCustoBaixa: TCentroCusto;
      FPortadorCadastro: TPortador;
      FPortadorBaixa: TPortador;
      FEvento: TEvento;
      FMovBan: TMovBan;
      FVeioNota: boolean;
      FListaRateio: TObjectList<TRateio>;
    public
      procedure pAdicionarRateio(rateio: TRateio);

      property strNumero: String read FNumero;
      property strEmpresa: String read FEmpresa;
      property strParcela: string read FParcela write FParcela;
      property strSerie: String read FSerie;
      property strHistorico: String read FHistorico write FHistorico;
      property strHistorico2: String read FHistorico2 write FHistorico2;
      property strHistoricoBaixa: String read FHistoricoBaixa write FHistoricoBaixa;
      property dtaDataCadastro: TDateTime read FDataCadastro write FDataCadastro;
      property dtaDataPagamento: TDateTime read FDataPagamento write FDataPagamento;
      property dtaDataBaixa: TDateTime read FDataBaixa write FDataBaixa;
      property dtaDataVencimento: TDateTime read FDataVencimento write FDataVencimento;
      property fltValorPagoChequePre: Double read FValorPagoChequePre write FValorPagoChequePre;
      property fltValorPagoChequeAvista: Double read FValorPagoChequeAvista write FValorPagoChequeAvista;
      property fltValorOriginal: Double read FValorOriginal write FValorOriginal;
      property fltValorPago: Double read FValorPago write FValorPago;
      property fltJuros: Double read FJuros write FJuros;
      property fltDesconto: Double read FDesconto write FDesconto;
      property strContaContabilDebito: String read FContaContabilDebito write FContaContabilDebito;
      property strContaContabilCredito: String read FContaContabilCredito write FContaContabilCredito;
      property participante: TParticipante read FParticipante write FParticipante;
      property centroCustoCadastro: TCentroCusto read FCentroCustoCadastro write FCentroCustoCadastro;
      property centroCustoBaixa: TCentroCusto read FCentroCustoBaixa write FCentroCustoBaixa;
      property portadorCadastro: TPortador read FPortadorCadastro write FPortadorCadastro;
      property portadorBaixa: TPortador read FPortadorBaixa write FPortadorBaixa;
      property evento: TEvento read FEvento write FEvento;
      property movBan: TMovBan read FMovBan write FMovBan;
      property listaRateio: TObjectList<TRateio> read FListaRateio;
      property blnVeioNota: boolean read FVeioNota write FVeioNota;

      constructor Create(strNumero, strEmpresa, strSerie, strCodigoParticipante: String);
      destructor Destroy; override;
  end;

implementation

{ TContasPagar }

constructor TContasPagar.Create(strNumero, strEmpresa, strSerie, strCodigoParticipante: String);
begin
  inherited create;

  FParticipante := TParticipante.Create;
  FCentroCustoCadastro := TCentroCusto.Create;
  FCentroCustoBaixa := TCentroCusto.Create;
  FPortadorCadastro := TPortador.Create;
  FPortadorBaixa := TPortador.Create;

  FNumero := strNumero;
  FEmpresa := strEmpresa;
  FSerie := strSerie;
  FParticipante.strCodigo := strCodigoParticipante;
  FEvento := TEvento.Create;
  FMovBan := TMovBan.Create;

  FListaRateio := TObjectList<TRateio>.Create;
end;

destructor TContasPagar.Destroy;
begin
  FEvento.Free;
  FListaRateio.Free;
  FParticipante.Free;
  FCentroCustoCadastro.Free;
  FCentroCustoBaixa.Free;
  FPortadorCadastro.Free;
  FPortadorBaixa.Free;
  FMovBan.Free;

  inherited;
end;

procedure TContasPagar.pAdicionarRateio(rateio: TRateio);
begin
  FListaRateio.Add(rateio);
end;

{ TRateio }

constructor TRateio.create;
begin
  inherited create;
  FCentroCusto := TCentroCusto.Create;
end;

destructor TRateio.destroy;
begin
  FCentroCusto.Free;
  inherited;
end;

end.
