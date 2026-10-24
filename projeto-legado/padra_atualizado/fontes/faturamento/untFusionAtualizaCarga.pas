unit untFusionAtualizaCarga;

interface

uses
  REST.JSON, System.JSON, System.Generics.Collections, REST.Json.Types;

type
  TVeiculoClass = class
  private
    FTipo_combustivel: String;
  public
    property tipo_combustivel: String read FTipo_combustivel write FTipo_combustivel;
  end;

  TMotoristaClass = class
  private
    FCep: String;
    FCidade: String;
    FCpf: String;
    FEndereco: String;
    FNome: String;
    FNome_empresa_contrato: String;
    FTelefone: String;
    FTipo: String;
    FUf: String;
  public
    property cep: String read FCep write FCep;
    property cidade: String read FCidade write FCidade;
    property cpf: String read FCpf write FCpf;
    property endereco: String read FEndereco write FEndereco;
    property nome: String read FNome write FNome;
    property nome_empresa_contrato: String read FNome_empresa_contrato write FNome_empresa_contrato;
    property telefone: String read FTelefone write FTelefone;
    property tipo: String read FTipo write FTipo;
    property uf: String read FUf write FUf;
  end;

  TCargaClass = class
  private
    FCodigo_erp: String;
    FCodmotorista: String;
    FCodveiculo: String;
    FStatus: String;
  public
    property codigo_erp: String read FCodigo_erp write FCodigo_erp;
    property codmotorista: String read FCodmotorista write FCodmotorista;
    property codveiculo: String read FCodveiculo write FCodveiculo;
    property status: String read FStatus write FStatus;
  end;

  TFusionAtualizaCarga = class
  private
    FCarga: TCargaClass;
    FMotorista: TMotoristaClass;
    FVeiculo: TVeiculoClass;
  public
    property carga: TCargaClass read FCarga write FCarga;
    property motorista: TMotoristaClass read FMotorista write FMotorista;
    property veiculo: TVeiculoClass read FVeiculo write FVeiculo;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
  end;

implementation

constructor TFusionAtualizaCarga.Create;
begin
  inherited;
  FCarga := TCargaClass.Create();
  FMotorista := TMotoristaClass.Create();
  FVeiculo := TVeiculoClass.Create();
end;

destructor TFusionAtualizaCarga.Destroy;
begin
  FCarga.free;
  FMotorista.free;
  FVeiculo.free;
  inherited;
end;

function TFusionAtualizaCarga.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

end.
