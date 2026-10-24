unit Contabilidade.Model.ContasPagar;

interface

uses Contabilidade.Model.Participante, Contabilidade.Model.Portador,
     Contabilidade.Model.PlanoContas, Contabilidade.Model.Empresa;

type
  TContasPagar = class
  private
    FHistoricoBaixa: string;
    FHistorico2: string;
    FHistorico: string;
    FHist01: string;
    FParcela: string;
    FNumero: string;
    FNumeroAdt: string;
    FSerie: string;
    FDataPagamento: TDateTime;
    FDataCadastro: TDateTime;
    FEmpresaBaixa: TEmpresa;
    FEmpresaCadastro: TEmpresa;
    FEmpresaCtpDet: TEmpresa ;
    FValorPago: double;
    FValorDinheiro: double;
    FValorChequePre: double;
    FValorChequeVista: double;
    FValorCartao: double;
    FValorOrdemPagamento: double;
    FValorJuros: double;
    FValorMulta: double;
    FValorVendor: double;
    FValorDesconto: double;
    FValorPisRF: double;
    FValorCofinsRF: double;
    FParticipante: TParticipante;
    FPortador: TPortador;
    FPlanoContasCadastro: TPlanoContas;
    FPlanoContasBaixa: TPlanoContas;
    FTipoPagamento: String;
    FCodEve: String;
    FCompetencia: String;
    FNumChq: String;
    FAutoincrem : String;
    FValorOriginal: double;
    FDocumentoOriginal : string;
    FEspecieOriginal : string;
    FPagamentoAntecipado: boolean;
    FCodCtaResultado: string;
    FDataEntradaFiscal: TDateTime ;
    FTipCtp: string ;
    FblnIsCtpDet: boolean ;
    FblnDescJurAjustado: boolean ;
    FblnLancamentoDuploEmpDif: Boolean ;
  public
    constructor create;
    destructor Destroy; override;

    property strHistoricoBaixa: string read FHistoricoBaixa write FHistoricoBaixa;
    property strHistorico2: string read FHistorico2 write FHistorico2;
    property strHistorico: string read FHistorico write FHistorico;
    property strHist01: string read FHist01 write FHist01;
    property strParcela: string read FParcela write FParcela;
    property strNumero: string read FNumero write FNumero;
    property strSerie: string read FSerie write FSerie;
    property dtaDataPagamento: TDateTime read FDataPagamento write FDataPagamento;
    property dtaDataCadastro: TDateTime read FDataCadastro write FDataCadastro;
    property empresaCadastro: TEmpresa read FEmpresaCadastro write FEmpresaCadastro;
    property empresaBaixa: TEmpresa read FEmpresaBaixa write FEmpresaBaixa;
    property empresaCtpDet: TEmpresa read FEmpresaCtpDet write FEmpresaCtpDet;
    property fltValorPago: double read FValorPago write FValorPago;
    property fltValorDinheiro: double read FValorDinheiro write FValorDinheiro;
    property fltValorChequePre: double read FValorChequePre write FValorChequePre;
    property fltValorChequeVista: double read FValorChequeVista write FValorChequeVista;
    property fltValorCartao: double read FValorCartao write FValorCartao;
    property fltValorOrdemPagamento: double read FValorOrdemPagamento write FValorOrdemPagamento;
    property fltValorJuros: double read FValorJuros write FValorJuros;
    property fltValorMulta: double read FValorMulta write FValorMulta;
    property fltValorVendor: double read FValorVendor write FValorVendor;
    property fltValorDesconto: double read FValorDesconto write FValorDesconto;
    property fltValorPisRF: double read FValorPisRF write FValorPisRF;
    property fltValorCofinsRF: double read FValorCofinsRF write FValorCofinsRF;
    property participante: TParticipante read FParticipante write FParticipante;
    property portador: TPortador read FPortador write FPortador;
    property planoContasCadastro: TPlanoContas read FPlanoContasCadastro write FPlanoContasCadastro;
    property planoContasBaixa: TPlanoContas read FPlanoContasBaixa write FPlanoContasBaixa;
    property strTipoPagamento: String read FTipoPagamento write FTipoPagamento;
    property strCodEve: String read FCodEve write FCodEve;
    property strCompetencia: String read FCompetencia write FCompetencia;
    property strNumChq: String read FNumChq write FNumChq;
    property strAutoincrem: String read FAutoincrem write FAutoincrem;
    property fltValorOriginal: double read FValorOriginal write FValorOriginal;
    property strDocumentoOriginal: string read FDocumentoOriginal write FDocumentoOriginal;
    property strEspecieOriginal: string read FEspecieOriginal write FEspecieOriginal;
    property blnPagamentoAntecipado: boolean read FPagamentoAntecipado write FPagamentoAntecipado;
    property strCodCtaResultado: String read FCodCtaResultado write FCodCtaResultado;
    property dtaDataEntradaFiscal: TDateTime read FDataEntradaFiscal write FDataEntradaFiscal;
    property strNumeroAdt: string read FNumeroAdt write FNumeroAdt;
    property strTipCtp: string read FTipCtp write FTipCtp;
    property IsCtpDet: boolean read FblnIsCtpDet write FblnIsCtpDet;
    property blnDescJurAjustado: boolean read FblnDescJurAjustado write FblnDescJurAjustado ;
    property LancamentoDuploEmpDif: Boolean read FblnLancamentoDuploEmpDif write FblnLancamentoDuploEmpDif ;
  end;

implementation

uses SysUtils ;

{ TContasPagar }

constructor TContasPagar.create;
begin
  FEmpresaBaixa := TEmpresa.Create;
  FEmpresaCtpDet := TEmpresa.Create;
  FEmpresaCadastro := TEmpresa.Create;
  FParticipante := TParticipante.Create;
  FPortador := TPortador.Create;
  FPlanoContasCadastro := TPlanoContas.Create;
  FPlanoContasBaixa := TPlanoContas.Create;
  FblnDescJurAjustado := False ;
end;

destructor TContasPagar.Destroy;
var
  item : TPortador ;
begin
  for item in FPortador.PortadorFormaPagamento.Values do
  begin
    item.Free ;
  end;
  FreeAndNil(FEmpresaCadastro) ;
  FEmpresaBaixa.Free;
  FEmpresaCtpDet.Free;
  FParticipante.Free;
  FPortador.Free;
  FPlanoContasCadastro.Free;
  FPlanoContasBaixa.Free;

  inherited;
end;

end.
