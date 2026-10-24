unit Contabilidade.Model.Portador;

interface

uses System.Generics.Collections,
     System.Generics.Defaults ;

type
  TPortadorFormaPagamento = (pfpNaoEspecificado, pfpDinheiro, pfpChequeAVista, pfpOrdemPagamento, pfpChequePre) ;

  TPortador = class;

  TDicPortadorFormaPagamento = class(TDictionary<TPortadorFormaPagamento, TPortador>)
  public
    constructor Create;
  end;

  TPortador = class
  private
    FCodigo: string;
    FDescricao: string;
    FContaContabil: string;
    FExportarPeloAutsi: boolean;
    FPortadorFormaPagamento: TDicPortadorFormaPagamento;
  public
    constructor create;
    destructor Destroy; override;
    property strCodigo: string read FCodigo write FCodigo;
    property strDescricao: string read FDescricao write FDescricao;
    property strContaContabil: string read FContaContabil write FContaContabil;
    property blnExportarPeloAutsi: boolean read FExportarPeloAutsi write FExportarPeloAutsi;
    property PortadorFormaPagamento: TDicPortadorFormaPagamento read FPortadorFormaPagamento write FPortadorFormaPagamento ;
  end;

implementation

{ TPortador }

constructor TPortador.create;
begin
  FPortadorFormaPagamento := TDicPortadorFormaPagamento.Create;
end;

destructor TPortador.Destroy;
begin
  FPortadorFormaPagamento.Free ;
  inherited;
end;

{ TDicPortadorFormaPagamento }

constructor TDicPortadorFormaPagamento.Create;
begin
  inherited Create();
end;

end.
