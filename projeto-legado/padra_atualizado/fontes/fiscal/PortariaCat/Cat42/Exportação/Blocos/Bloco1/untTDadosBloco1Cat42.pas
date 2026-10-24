unit untTDadosBloco1Cat42;

interface

uses System.Generics.Collections,
     untTParticipante;

type
  TNotaFiscalCat42 = class
  private
    FValorTotalIcmsSuportado: double;
    FSaidasParaOutrosEstados: Double;
    FCodigoEnquadramento: string;
    FParticipante: TParticipante;
    FIndicadorOperacao: integer;
    FValorConfronto: double;
    FDataEntrada: TDatetime;
    FCodigoProduto: string;
    FChaveAcesso: string;
    FQuantidade: double;
    FDocumento: string;
    FNumeroEcf: string;
    FModelo: string;
    FCampo14: double;
    FCampo18: double;
    FCampo21: double;
    FCampo25: double;
    FTipFc: string;
    FSerie: string;
    FCfop: string;
  public
    constructor create;
    destructor Destroy; override;

    property fltValorTotalIcmsSuportado: double read FValorTotalIcmsSuportado write FValorTotalIcmsSuportado;
    property fltSaidasParaOutrosEstados: double read FSaidasParaOutrosEstados write FSaidasParaOutrosEstados;
    property strCodigoEnquadramento: string read FCodigoEnquadramento write FCodigoEnquadramento;
    property participante: TParticipante read FParticipante write FParticipante;
    property intIndicadorOperacao: integer read FIndicadorOperacao write FIndicadorOperacao;
    property fltValorConfronto: double read FValorConfronto write FValorConfronto;
    property dtaDataEntrada: TDatetime read FDataEntrada write FDataEntrada;
    property strCodigoProduto: string read FCodigoProduto write FCodigoProduto;
    property strChaveAcesso: string read FChaveAcesso write FChaveAcesso;
    property fltQuantidade: double read FQuantidade write FQuantidade;
    property strDocumento: string read FDocumento write FDocumento;
    property strNumeroEcf: string read FNumeroEcf write FNumeroEcf;
    property strModelo: string read FModelo write FModelo;
    property fltCampo14: double read FCampo14 write FCampo14;
    property fltCampo18: double read FCampo18 write FCampo18;
    property fltCampo21: double read FCampo21 write FCampo21;
    property fltCampo25: double read FCampo25 write FCampo25;
    property strTipFc: string read FTipFc write FTipFc;
    property strSerie: string read FSerie write FSerie;
    property strCfop: string read FCfop write FCfop;
  end;

type
  TSaldoCat42 = class
  private
    FCodigoProduto: string;
    FQtdIni: double;
    FQtdFin: double;
    FSalIni: double;
    FSalFin: double;
  public
    property strCodigoProduto: string read FCodigoProduto write FCodigoProduto;
    property fltQtdIni: double read FQtdIni write FQtdIni;
    property fltQtdFin: double read FQtdFin write FQtdFin;
    property fltSalIni: double read FSalIni write FSalIni;
    property fltSalFin: double read FSalFin write FSalFin;
  end;

type
  TDadosBloco1Cat42 = class
  private
    FListaNotas: TObjectList<TNotaFiscalCat42>;
    FListaSaldo: TObjectList<TSaldoCat42>;
  public
    constructor create;
    destructor Destroy; override;

    property listaNotas: TObjectList<TNotaFiscalCat42> read FListaNotas write FListaNotas;
    property listaSaldo: TObjectList<TSaldoCat42> read FListaSaldo write FListaSaldo;
  end;

implementation

{ TDadosBloco1Cat42 }

constructor TDadosBloco1Cat42.create;
begin
  inherited create;

  FListaNotas := TObjectList<TNotaFiscalCat42>.Create;
  FListaSaldo := TObjectList<TSaldoCat42>.Create;
end;

destructor TDadosBloco1Cat42.Destroy;
begin
  FListaNotas.Free;
  FListaSaldo.Free;

  inherited;
end;

{ TNotaFiscalCat42 }

constructor TNotaFiscalCat42.create;
begin
  inherited;

  FParticipante := TParticipante.Create;
end;

destructor TNotaFiscalCat42.Destroy;
begin
  FParticipante.Free;

  inherited;
end;

end.
