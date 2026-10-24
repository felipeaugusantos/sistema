unit untTProduto;

interface

uses untTMateriaPrima,
     System.Generics.Collections;

type
  TMensagemEstadoProdutoEstocado = class
    private
      FTipoMensagem: integer;
      FMensagem: string;
    public
      property intTipoMensagem: integer read FTipoMensagem write FTipoMensagem;
      property strMensagem: string read FMensagem write FMensagem;
  end;

  TGrupo = class
  private
    FCodigo: string;
    FDescricao: string;
  public
    property strCodigo: string read FCodigo write FCodigo;
    property strDescricao: string read FDescricao write FDescricao;
  end;

Type
  TUnidade = class
  private
    FDescricao: string;
    FCodigo: string;
    FSigla: string;
  public
    property strDescricao: string read FDescricao write FDescricao;
    property strCodigo: string read FCodigo write FCodigo;
    property strSigla: string read FSigla write FSigla;
  end;

Type
  TProduto = class(TObject)
    private
      FCodItem: String;
      FDescricaoItem: String;
      FReferencia: String;
      FCodigoUnidade: String;
      FDataCadastro: TDateTime;
      FCodigoNCM: String;
      FCodigoSituacaoTributaria: String;
      FBaseICMS: Double;
      FBaseICMS_ST: Double;
      FValorICMS_ST: double;
      FAliquotaICMS: Double;
      FAliquotaIPI: Double;
      FPreco: double;
      FPrecoCusto: Double;
      FPrecoMedio: Double;
      FPrecoCompra: double;
      FSaldo: Double;
      FCodFabricaItemForn: String;
      FQuantidade: Double;
      FProdutoProduzido: Boolean;
      FGrupo: TGrupo;
      FUnidade: TUnidade;
      FMateriaPrima: TObjectList<TMateriaPrima>;
      FCodBarra: String;
      FCodigoCEST: string;
      FGenero: string;
      FValor: double; //qtdade * preco
      FCfop: string;
      FIVA: double;
      FStCalculado: boolean;
      FDocumentoCompraAssociado: string;
      FMensagensEstadoProdutoEstocado: TObjectList<TMensagemEstadoProdutoEstocado>;
    public
      procedure pAdicionaMensagemEstadoProdutoEstocado(mensagem: TMensagemEstadoProdutoEstocado);
      procedure pAdicionaMateriaPrima(item: TMateriaPrima);

      property strCodItem: String read FCodItem write FCodItem;
      property strDescricaoItem: String read FDescricaoItem write FDescricaoItem;
      property strReferencia: String read FReferencia write FReferencia;
      property strCodigoUnidade: String read FCodigoUnidade write FCodigoUnidade;
      property dtaDataCadastro: TDateTime read FDataCadastro write FDataCadastro;
      property strCodigoNCM: String read FCodigoNCM write FCodigoNCM;
      property strCodigoSituacaoTributaria: String read FCodigoSituacaoTributaria write FCodigoSituacaoTributaria;
      property fltBaseICMS: Double read FBaseICMS write FBaseICMS;
      property fltBaseICMS_ST: Double read FBaseICMS_ST write FBaseICMS_ST;
      property fltValorICMS_ST: double read FValorICMS_ST write FValorICMS_ST;
      property fltAliquotaICMS: Double read FAliquotaICMS write FAliquotaICMS;
      property fltAliquotaIPI: Double read FAliquotaIPI write FAliquotaIPI;
      property fltPreco: double read FPreco write FPreco;
      property fltPrecoCusto: Double read FPrecoCusto write FPrecoCusto;
      property fltPrecoMedio: Double read FPrecoMedio write FPrecoMedio;
      property fltSaldo: Double read FSaldo write FSaldo;
      property strCodFabricaItemForn: String read FCodFabricaItemForn write FCodFabricaItemForn;
      property fltQuantidade: Double read FQuantidade write FQuantidade;
      property blnProdutoProduzido: Boolean read FProdutoProduzido write FProdutoProduzido;
      property grupo: TGrupo read FGrupo write FGrupo;
      property unidade: TUnidade read FUnidade write FUnidade;
      property materiaPrima: TObjectList<TMateriaPrima> read FMateriaPrima;
      property strCodBarra: String read FCodBarra write FCodBarra;
      property strCodigoCEST: string read FCodigoCEST write FCodigoCEST;
      property strGenero: string read FGenero write FGenero;
      property fltValor: double read FValor write FValor;
      property strCfop: string read FCfop write FCfop;
      property fltIVA: double read FIVA write FIVA;
      property fltPrecoCompra: double read FPrecoCompra write FPrecoCompra;
      property blnStCalculado: boolean read FStCalculado write FStCalculado;
      property strDocumentoCompraAssociado: string read FDocumentoCompraAssociado write FDocumentoCompraAssociado;
      property listaMensagensEstadoProdutoEstocado: TObjectList<TMensagemEstadoProdutoEstocado> read FMensagensEstadoProdutoEstocado write FMensagensEstadoProdutoEstocado;

      Constructor Create;
      Destructor Destroy; override;
  end;

implementation

{ TProduto }

constructor TProduto.Create;
begin
  FMensagensEstadoProdutoEstocado := TObjectList<TMensagemEstadoProdutoEstocado>.Create;
  FMateriaPrima := TObjectList<TMateriaPrima>.Create;
  FGrupo := TGrupo.Create;
  FUnidade := TUnidade.Create;
end;

destructor TProduto.Destroy;
begin
  FMensagensEstadoProdutoEstocado.Free;
  FMateriaPrima.Free;
  FGrupo.Free;
  FUnidade.Free;

  inherited;
end;

procedure TProduto.pAdicionaMateriaPrima(item: TMateriaPrima);
begin
  FMateriaPrima.Add(item);
end;

procedure TProduto.pAdicionaMensagemEstadoProdutoEstocado(mensagem: TMensagemEstadoProdutoEstocado);
begin
  FMensagensEstadoProdutoEstocado.Add(mensagem);
end;

end.
