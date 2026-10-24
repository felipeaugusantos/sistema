unit untModelCarga;

interface

type
  TModelCarga = class;
  TModelItens = class;
  TModelClienteItem = class;
  TModelCliente = class;
  TModelEndereco = class;
  TModelFatura = class;
  TModelNota = class;

//  TArrayModelItens = Array of TModelItens;
  TArrayModelItens = TArray<TModelItens>;

  TModelCarga = class
  private
    Fitens: TArrayModelItens;
    Fid: String;
    FcpfMotorista: String;
    Fnumero: string;
    Fplaca: string;
    Ftipo: string;
    Fdata: TDateTime;
  public
    constructor Create;
    destructor Destroy; override;

    property cpfMotorista: String read FcpfMotorista write FcpfMotorista;
    property data: TDateTime read Fdata write Fdata;
    property id: String read Fid write Fid;
    property itens: TArrayModelItens read Fitens write Fitens;
    property numero: string read Fnumero write Fnumero;
    property placa: string read Fplaca write Fplaca;
    property tipo: string read Ftipo write Ftipo;

    procedure AddItem(AValue: TModelItens);
  end;

  TModelItens = class
  private
    FnomeTransportadora: string;
    FidEmpresa: string;
    FordemEntrega: integer;
    FdataPrevisaoEntrega: TDateTime;
    FcnpjTransportadora: string;
    Fcliente: TModelClienteItem;
    Fnota: TModelNota;
    Fid: string;
//    Ffatura: TModelFatura;
    Fstatus: string;
    Fcontato: string;
    FidCliente: string;
    Fendereco: TModelEndereco;
  public
    constructor Create;
    destructor Destroy; override;

    property cliente: TModelClienteItem read Fcliente write Fcliente;
    property cnpjTransportadora: string read FcnpjTransportadora write FcnpjTransportadora;
    property contato: string read Fcontato write Fcontato;
    property dataPrevisaoEntrega: TDateTime read FdataPrevisaoEntrega write FdataPrevisaoEntrega;
    property endereco: TModelEndereco read Fendereco write Fendereco;
//    property fatura: TModelFatura read Ffatura write Ffatura;
    property id: string read Fid write Fid;
    property idCliente: string read FidCliente write FidCliente;
    property idEmpresa: string read FidEmpresa write FidEmpresa;
    property nomeTransportadora: string read FnomeTransportadora write FnomeTransportadora;
    property nota: TModelNota read Fnota write Fnota;
    property ordemEntrega: integer read FordemEntrega write FordemEntrega;
    property status: string read Fstatus write Fstatus;
  end;

  TModelClienteItem = class
  private
    Femail: string;
    Fcliente: TModelCliente;
    FcodigoAuxiliar: string;
  public
    constructor Create;
    destructor Destroy; override;

    property cliente: TModelCliente read Fcliente write Fcliente;
    property codigoAuxiliar: string read FcodigoAuxiliar write FcodigoAuxiliar;
    property email: string read Femail write Femail;
  end;

  TModelCliente = class
  private
    FtipoPessoa: string;
    FidEmpresa: string;
    Femail: string;
    Fid: string;
    FcpfCnpj: string;
    FrazaoSocial: string;
    Fcontato: string;
    Ftelefone: string;
  public
    property contato: string read Fcontato write Fcontato;
    property cpfCnpj: string read FcpfCnpj write FcpfCnpj;
    property email: string read Femail write Femail;
    property id: string read Fid write Fid;
    property idEmpresa: string read FidEmpresa write FidEmpresa;
    property razaoSocial: string read FrazaoSocial write FrazaoSocial;
    property telefone: string read Ftelefone write Ftelefone;
    property tipoPessoa: string read FtipoPessoa write FtipoPessoa;
  end;

  TModelEndereco = class
  private
    Flogradouro: string;
    Fbairro: string;
    Fcep: string;
    Fnumero: string;
    Fcomplemento: string;
    Freferencia: string;
    Fcidade: string;
    Festado: string;
  public
    property bairro: string read Fbairro write Fbairro;
    property cep: string read Fcep write Fcep;
    property cidade: string read Fcidade write Fcidade;
    property complemento: string read Fcomplemento write Fcomplemento;
    property estado: string read Festado write Festado;
    property logradouro: string read Flogradouro write Flogradouro;
    property numero: string read Fnumero write Fnumero;
    property referencia: string read Freferencia write Freferencia;
  end;

  TModelFatura = class
  private
    Fvencimento: TDateTime;
    Fdata: TDateTime;
  public
    property data: TDateTime read Fdata write Fdata;
    property vencimento: TDateTime read Fvencimento write Fvencimento;
  end;

  TModelNota = class
  private
    Fserie: string;
    Fnumero: string;
    FchaveAcesso: string;
  public
    property chaveAcesso: string read FchaveAcesso write FchaveAcesso;
    property numero: string read Fnumero write Fnumero;
    property serie: string read Fserie write Fserie;
  end;

implementation

uses
  System.SysUtils;

{ TModelCarga }

procedure TModelCarga.AddItem(AValue: TModelItens);
begin
  SetLength(Fitens, Length(Fitens)+1);
  fItens[High(fItens)] := AValue;
end;

constructor TModelCarga.Create;
begin

end;

destructor TModelCarga.Destroy;
var
  ModelItens: TModelItens;
begin
  for ModelItens in Fitens do
    ModelItens.Free;

  SetLength(Fitens, 0);
  inherited;
end;

{ TModelItens }

constructor TModelItens.Create;
begin
  Fcliente := TModelClienteItem.Create;
  Fnota := TModelNota.Create;
//  Ffatura := TModelFatura.Create;
  Fendereco := TModelEndereco.Create;
end;

destructor TModelItens.Destroy;
begin
  FreeAndNil(Fcliente);
  FreeAndNil(Fnota);
//  FreeAndNil(Ffatura);
  FreeAndNil(Fendereco);

  inherited;
end;

{ TModelClienteItem }

constructor TModelClienteItem.Create;
begin
  Fcliente := TModelCliente.Create;
end;

destructor TModelClienteItem.Destroy;
begin
  FreeAndNil(Fcliente);
  inherited;
end;

end.
