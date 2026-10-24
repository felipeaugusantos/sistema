unit ClubeDoPintor.Classes;

interface

uses
  untBaseIntegracaoJSON, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TItens = class
  private
    FCodigoProduto: string;
    FQtde: Double;
    FValor: Double;
    FValorUnitario: Double;
  published
    property CodigoProduto: string read FCodigoProduto write FCodigoProduto;
    property Qtde: Double read FQtde write FQtde;
    property Valor: Double read FValor write FValor;
    property ValorUnitario: Double read FValorUnitario write FValorUnitario;
  end;

  TPontuar = class(TBaseJSON)
  private
    FCnpjLoja: string;
    FCpfCliente: string;
    FIdentificadorVenda: string;
    [JSONName('itens'), JSONMarshalled(False)]
    FItensArray: TArray<TItens>;
    [GenericListReflect]
    FItens: TObjectList<TItens>;
    FNomeCliente: string;
    FTipoFiscal: string;
    function GetItens: TObjectList<TItens>;
  protected
    function GetAsJson: string; override;
  published
    property CnpjLoja: string read FCnpjLoja write FCnpjLoja;
    property CpfCliente: string read FCpfCliente write FCpfCliente;
    property IdentificadorVenda: string read FIdentificadorVenda write FIdentificadorVenda;
    property Itens: TObjectList<TItens> read GetItens;
    property NomeCliente: string read FNomeCliente write FNomeCliente;
    property TipoFiscal: string read FTipoFiscal write FTipoFiscal;
  public
    destructor Destroy; override;
  end;

  TResgatar = class(TBaseJSON)
  private
    FCodigoVoucher: string;
  published
    property CodigoVoucher: string read FCodigoVoucher write FCodigoVoucher;
  end;

const
   ARR_DOCUMENTOS_PONTUAR_CLUBE_DO_PINTOR   : Array[0..3] Of String = ('NF','CF','IF','FF');
   ARR_DOCUMENTOS_RESGATAR_CLUBE_DO_PINTOR  : Array[0..1] Of String = ('PD','BR');
   ARR_OPCDOC_GERAR_VOUCHER_CLUBE_DO_PINTOR : Array[0..5] Of String = ('PD','VN','NF','CF','IF','FF');


implementation

{ TPontuar }

destructor TPontuar.Destroy;
begin
  GetItens.Free;
  inherited;
end;

function TPontuar.GetItens: TObjectList<TItens>;
begin
  Result := ObjectList<TItens>(FItens, FItensArray);
end;

function TPontuar.GetAsJson: string;
begin
  RefreshArray<TItens>(FItens, FItensArray);
  Result := inherited;
end;

end.
