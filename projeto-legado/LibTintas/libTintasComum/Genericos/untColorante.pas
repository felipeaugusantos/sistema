{***********************************************************************************}
{* Classes que representa um colorante, com todos os atributos usados pelo sistema *}
{********************************************************************************PH*}
unit untColorante;

interface

uses
  Classes;

type
  TTipoComponenteIndustrial = (tciBase, tciCatalisador, tciColorante);

  TColorante = class(TCollectionItem)
  private
    strCodigoColorante: String;
    strDescricaoColorante: String;
    strCodIte: String;
    strImpDir: String;
    fltQuantidade: Double;
    fltQuantidadeOriginal:Double;
    fltOutrosValores: Double;
    fltIcmsSaida: Double;
    fltImpostosFederais: Double;
    fltDespesasOperacionais: Double;
    fltPrecoMedio: Double;
    fltUltimoPrecoCompra: Double;
    fltUltimoPrecoCompraImpostos: Double;
    fltPrecoCompraLiquido: Double;
    fltPrecoCusto: Double;
    fltPrecoCustoReal: Double;
    fltPrecoVenda: Double;
    fltEmbalagem: Double;
    fltPercentual: Double;
    fltPesoEspecifico: Double;
    tciTipo: TTipoComponenteIndustrial;
    procedure SetQuantidade(const value: Double);
  public
    procedure AplicarFator(const fltFator: Double);
    property CodigoColorante: String read strCodigoColorante write strCodigoColorante;
    property DescricaoColorante: String read strDescricaoColorante write strDescricaoColorante;
    property Quantidade: Double read fltQuantidade write SetQuantidade;
    property OutrosValores: Double read fltOutrosValores write fltOutrosValores;
    property IcmsSaida: Double read fltIcmsSaida write fltIcmsSaida;
    property ImpostosFederais: Double read fltImpostosFederais write fltImpostosFederais;
    property DespesasOperacionais: Double read fltDespesasOperacionais write fltDespesasOperacionais;

    property PrecoMedio: Double read fltPrecoMedio write fltPrecoMedio;
    property UltimoPrecoCompra: Double read fltUltimoPrecoCompra write fltUltimoPrecoCompra;
    property UltimoPrecoCompraImpostos: Double read fltUltimoPrecoCompraImpostos write fltUltimoPrecoCompraImpostos;
    property PrecoCompraLiquido: Double read fltPrecoCompraLiquido write fltPrecoCompraLiquido;

    property PrecoCusto: Double read fltPrecoCusto write fltPrecoCusto;
    property PrecoCustoReal: Double read fltPrecoCustoReal write fltPrecoCustoReal;
    property PrecoVenda: Double read fltPrecoVenda write fltPrecoVenda;
    property Embalagem: Double read fltEmbalagem write fltEmbalagem;
    property Percentual: Double read fltPercentual write fltPercentual;
    property PesoEspecifico: Double read fltPesoEspecifico write fltPesoEspecifico;
    property Tipo: TTipoComponenteIndustrial read tciTipo write tciTipo;

    property CodIte: String read strCodIte write strCodIte;
    property ImpDir: String read strImpDir write strImpDir;
  end;

implementation

{ TColorante }

procedure TColorante.AplicarFator(const fltFator: Double);
begin
  fltQuantidade := fltFator * fltQuantidadeOriginal;
end;

procedure TColorante.SetQuantidade(const value: Double);
begin
  if fltQuantidadeOriginal = 0 then
    fltQuantidadeOriginal := value;

  fltQuantidade := value;
end;

end.
