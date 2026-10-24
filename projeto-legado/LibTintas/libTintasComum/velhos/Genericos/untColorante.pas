{***********************************************************************************}
{* Classes que representa um colorante, com todos os atributos usados pelo sistema *}
{********************************************************************************PH*}
unit untColorante;

interface

uses
  Classes;

type
  TColorante = class(TCollectionItem)
  private
    strCodigoColorante: String;
    fltQuantidade: Double;
    fltOutrosValores: Double;
    fltIcmsSaida: Double;
    fltImpostosFederais: Double;
    fltDespesasOperacionais: Double;
    fltPrecoCusto: Double;
    fltPrecoCustoReal: Double;
    fltPrecoVenda: Double;
    fltEmbalagem: Double;
  public
    property CodigoColorante: String read strCodigoColorante write strCodigoColorante;
    property Quantidade: Double read fltQuantidade write fltQuantidade;
    property OutrosValores: Double read fltOutrosValores write fltOutrosValores;
    property IcmsSaida: Double read fltIcmsSaida write fltIcmsSaida;
    property ImpostosFederais: Double read fltImpostosFederais write fltImpostosFederais;
    property DespesasOperacionais: Double read fltDespesasOperacionais write fltDespesasOperacionais;
    property PrecoCusto: Double read fltPrecoCusto write fltPrecoCusto;
    property PrecoCustoReal: Double read fltPrecoCustoReal write fltPrecoCustoReal;
    property PrecoVenda: Double read fltPrecoVenda write fltPrecoVenda;
    property Embalagem: Double read fltEmbalagem write fltEmbalagem;
  end;

implementation

end.
