unit Contabilidade.Model.Contabilizaveis;

interface

uses Contabilidade.Model.Participante, Contabilidade.Model.Portador,
  Contabilidade.Model.PlanoContas;

type
  TContabilizaveis = class
  private
    FCliente: TCliente;
    FFornecedor: TFornecedor;
    FPortador: TPortador;
    FPlanoContasCadastro: TPlanoContas;
    FPlanoContasBaixa: TPlanoContas;
    FPlanoContasTaxa: TPlanoContas;
    FIncDoc: string;
    FContaCredito: string;
    FContaDebito: string;
    FCodigoBandeira: string;
  public
    property IncDoc: string read FIncDoc write FIncDoc;
    property Cliente: TCliente read FCliente write FCliente;
    property Fornecedor: TFornecedor read FFornecedor write FFornecedor;
    property Portador: TPortador read FPortador write FPortador;
    property PlanoContasCadastro: TPlanoContas read FPlanoContasCadastro write FPlanoContasCadastro;
    property PlanoContasBaixa: TPlanoContas read FPlanoContasBaixa write FPlanoContasBaixa;
    property PlanoContasTaxa: TPlanoContas read FPlanoContasTaxa write FPlanoContasTaxa;
    property ContaCredito: string read FContaCredito write FContaCredito;
    property ContaDebito: string read FContaDebito write FContaDebito;
    property CodigoBandeira: string read FCodigoBandeira write FCodigoBandeira;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TContabilizaveis }

constructor TContabilizaveis.Create;
begin
  FCliente := TCliente.Create;
  FFornecedor := TFornecedor.Create;
  FPortador := TPortador.Create;
  FPlanoContasCadastro := TPlanoContas.Create;
  FPlanoContasBaixa := TPlanoContas.Create;
  FPlanoContasTaxa := TPlanoContas.Create;
end;

destructor TContabilizaveis.Destroy;
begin
  FCliente.Free;
  FFornecedor.Free;
  FPortador.Free;
  FPlanoContasCadastro.Free;
  FPlanoContasBaixa.Free;
  FPlanoContasTaxa.Free;
  inherited;
end;

end.
