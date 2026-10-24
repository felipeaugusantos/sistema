{*******************************************************}
{ unit compartilhada entre o Autcom e a libCorreios.dll }
{*******************************************************}
unit Correios.Types;

interface

uses
  Generics.Collections;

type
  TDadosServico = class
  public
    id: Integer;
    codigo: String;
    descricao: String;
    constructor Create(const AId: Integer; const ACodigo, ADescri: String);
  end;

  TServicosCliente = TObjectList<TDadosServico>;

  TItemConteudo = class
  public
    descricao: String;
    quantidade: Double;
    valor: Double;
    constructor Create(const ADescri: String; const AQuant, AValor: Double);
  end;

  TPessoa = class
  public
    nome: String;
    telefone: String;
    email: String;
    cnpj: String;
    cep: String;
    endereco: String;
    numero: String;
    compl: String;
    bairro: String;
    cidade: String;
    uf: String;
  end;

  TDadosPostagem = class
  public
    remetente: TPessoa;
    destinatario: TPessoa;
    codigoServico: String;
    numeroNotaFiscal: String;
    chaveNFe: String;
    codigoServicoAdic: String;
    valorServicoAdic: Double;
    itensConteudo: TObjectList<TItemConteudo>;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TDadosServico }

constructor TDadosServico.Create(const AId: Integer; const ACodigo, ADescri: String);
begin
  Self.id        := AId;
  Self.codigo    := ACodigo;
  Self.descricao := ADescri;
end;

{ TItemConteudo }

constructor TItemConteudo.Create(const ADescri: String; const AQuant, AValor: Double);
begin
  Self.descricao  := ADescri;
  Self.quantidade := AQuant;
  Self.valor      := AValor;
end;

{ TDadosPostagem }

constructor TDadosPostagem.Create;
begin
  remetente     := TPessoa.Create;
  destinatario  := TPessoa.Create;
  itensConteudo := TObjectList<TItemConteudo>.Create;
end;

destructor TDadosPostagem.Destroy;
begin
  remetente.Free;
  destinatario.Free;
  itensConteudo.Free;
  inherited;
end;

end.
