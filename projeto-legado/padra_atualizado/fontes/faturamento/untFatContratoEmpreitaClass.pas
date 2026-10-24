unit untFatContratoEmpreitaClass;

interface

uses SysUtils, Classes, untBaseClass, untBaseListIntf, untFatContratoEmpreitaIntf;

type
  TDadosCliente = Class(TBaseClass, IDadosCliente)
  private
    FNome     : String;
    FFone     : String; //Formatado
    FFax      : String; //Formatado
    FEndereco : String;
    FEmail    : String;
    FMunicipio: String;
    FEstado   : String;
    FCep      : String; //Formatado
    FCnpjCpf  : String; //Formatado
    FIE       : String;
  protected
    function GetNome: String;
    function GetCep: String;
    function GetCnpjCpf: String;
    function GetEmail: String;
    function GetEndereco: String;
    function GetEstado: String;
    function GetFax: String;
    function GetFone: String;
    function GetIE: String;
    function GetMunicipio: String;
    procedure SetNome(const Value: String);
    procedure SetCep(const Value: String);
    procedure SetCnpjCpf(const Value: String);
    procedure SetEmail(const Value: String);
    procedure SetEndereco(const Value: String);
    procedure SetEstado(const Value: String);
    procedure SetFax(const Value: String);
    procedure SetFone(const Value: String);
    procedure SetIE(const Value: String);
    procedure SetMunicipio(const Value: String);
  public
  published
    property Nome     : String read GetNome      write SetNome;
    property Fone     : String read GetFone      write SetFone;
    property Fax      : String read GetFax       write SetFax;
    property Endereco : String read GetEndereco  write SetEndereco;
    property Email    : String read GetEmail     write SetEmail;
    property Municipio: String read GetMunicipio write SetMunicipio;
    property Estado   : String read GetEstado    write SetEstado;
    property Cep      : String read GetCep       write SetCep;
    property CnpjCpf  : String read GetCnpjCpf   write SetCnpjCpf;
    property IE       : String read GetIE        write SetIE;
  end;

type
  TLocalObra = Class(TBaseClass, ILocalObra)
  private
    FEndereco    : String;
    FBairro      : String;
    FMunicipio   : String;
    FEstado      : String;
    FCep         : String; //Formatado
    FNaturezaObra: String;
  protected
    function GetBairro: String;
    function GetCep: String;
    function GetEndereco: String;
    function GetEstado: String;
    function GetMunicipio: String;
    function GetNaturezaObra: String;
    procedure SetBairro(const Value: String);
    procedure SetCep(const Value: String);
    procedure SetEndereco(const Value: String);
    procedure SetEstado(const Value: String);
    procedure SetMunicipio(const Value: String);
    procedure SetNaturezaObra(const Value: String);
  public
  published
    property Endereco    : String read GetEndereco     write SetEndereco;
    property Bairro      : String read GetBairro       write SetBairro;
    property Municipio   : String read GetMunicipio    write SetMunicipio;
    property Estado      : String read GetEstado       write SetEstado;
    property Cep         : String read GetCep          write SetCep;
    property NaturezaObra: String read GetNaturezaObra write SetNaturezaObra;
  End;

type
  TItensContrato = Class(TBaseClass, IItensContrato)
  private
    FVolume       : Double;
    FDescricaoItem: String;
    FValor        : Double;
  protected
    function GetDescricaoItem: String;
    function GetValor: Double;
    function GetVolume: Double;
    procedure SetDescricaoItem(const Value: String);
    procedure SetValor(const Value: Double);
    procedure SetVolume(const Value: Double);
  public
  published
    property Volume       : Double read GetVolume        write SetVolume;
    property DescricaoItem: String read GetDescricaoItem write SetDescricaoItem;
    property Valor        : Double read GetValor         write SetValor;
  End;

type
  TDadosEmpresa = Class(TBaseClass, IDadosEmpresa)
  private
    FNome     : String;
    FCnpj     : String; //Formatado
    FIE       : String;
    FMunicipio: String;
    FEndereco : String;
    FCep      : String;
    FEstado   : String;
  protected
    function GetCep: String;
    function GetCnpj: String;
    function GetEndereco: String;
    function GetIE: String;
    function GetMunicipio: String;
    function GetNome: String;
    function GetEstado: String;
    procedure SetCep(const Value: String);
    procedure SetCnpj(const Value: String);
    procedure SetEndereco(const Value: String);
    procedure SetIE(const Value: String);
    procedure SetMunicipio(const Value: String);
    procedure SetNome(const Value: String);
    procedure SetEstado(const Value: String);
  public
  published
    property Nome     : String read GetNome      write SetNome;
    property Cnpj     : String read GetCnpj      write SetCnpj;
    property IE       : String read GetIE        write SetIE;
    property Municipio: String read GetMunicipio write SetMunicipio;
    property Endereco : String read GetEndereco  write SetEndereco;
    property Cep      : String read GetCep       write SetCep;
    property Estado   : String read GetEstado    write SetEstado;
  End;

type
  TContratoEmpreita = Class(TBaseClass, IContratoEmpreita)
  private
    FNumeroContrato   : String; //Número NF de Serviço + ESPDOC
    FDadosCliente     : IDadosCliente;
    FLocalObra        : ILocalObra;
    FItensContratoList: IBaseList;
    FDadosEmpresa     : IDadosEmpresa;
  protected
    function GetDadosCliente: IDadosCliente;
    function GetDadosEmpresa: IDadosEmpresa;
    function GetItensContrato: IBaseList;
    function GetLocalObra: ILocalObra;
    function GetNumeroContrato: String;
    procedure SetDadosCliente(const Value: IDadosCliente);
    procedure SetDadosEmpresa(const Value: IDadosEmpresa);
    procedure SetItensContrato(const Value: IBaseList);
    procedure SetLocalObra(const Value: ILocalObra);
    procedure SetNumeroContrato(const Value: String);
  public
  published
    property NumeroContrato: String        read GetNumeroContrato write SetNumeroContrato;
    property DadosCliente  : IDadosCliente read GetDadosCliente   write SetDadosCliente;
    property LocalObra     : ILocalObra    read GetLocalObra      write SetLocalObra;
    property ItensContrato : IBaseList     read GetItensContrato  write SetItensContrato;
    property DadosEmpresa  : IDadosEmpresa read GetDadosEmpresa   write SetDadosEmpresa;
  End;
  
implementation

uses untFactoryClass;

{ TDadosCliente }

function TDadosCliente.GetCep: String;
begin
  Result := FCep;
end;

function TDadosCliente.GetCnpjCpf: String;
begin
  Result := FCnpjCpf;
end;

function TDadosCliente.GetEmail: String;
begin
  Result := FEmail;
end;

function TDadosCliente.GetEndereco: String;
begin
  Result := FEndereco;
end;

function TDadosCliente.GetEstado: String;
begin
  Result := FEstado;
end;

function TDadosCliente.GetFax: String;
begin
  Result := FFax;
end;

function TDadosCliente.GetFone: String;
begin
  Result := FFone;
end;

function TDadosCliente.GetIE: String;
begin
  Result := FIE;
end;

function TDadosCliente.GetMunicipio: String;
begin
  Result := FMunicipio;
end;

function TDadosCliente.GetNome: String;
begin
  Result := FNome;
end;

procedure TDadosCliente.SetCep(const Value: String);
begin
  FCep := Value;
end;

procedure TDadosCliente.SetCnpjCpf(const Value: String);
begin
  FCnpjCpf := Value;
end;

procedure TDadosCliente.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TDadosCliente.SetEndereco(const Value: String);
begin
  FEndereco := Value;
end;

procedure TDadosCliente.SetEstado(const Value: String);
begin
  FEstado := Value;
end;

procedure TDadosCliente.SetFax(const Value: String);
begin
  FFax := Value;
end;

procedure TDadosCliente.SetFone(const Value: String);
begin
  FFone := Value;
end;

procedure TDadosCliente.SetIE(const Value: String);
begin
  FIE := Value;
end;

procedure TDadosCliente.SetMunicipio(const Value: String);
begin
  FMunicipio := Value;
end;

procedure TDadosCliente.SetNome(const Value: String);
begin
  FNome := Value;
end;

{ TLocalObra }

function TLocalObra.GetBairro: String;
begin
  Result := FBairro;
end;

function TLocalObra.GetCep: String;
begin
  Result := FCep;
end;

function TLocalObra.GetEndereco: String;
begin
  Result := FEndereco;
end;

function TLocalObra.GetEstado: String;
begin
  Result := FEstado;
end;

function TLocalObra.GetMunicipio: String;
begin
  Result := FMunicipio;
end;

function TLocalObra.GetNaturezaObra: String;
begin
  Result := FNaturezaObra;
end;

procedure TLocalObra.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TLocalObra.SetCep(const Value: String);
begin
  FCep := Value;
end;

procedure TLocalObra.SetEndereco(const Value: String);
begin
  FEndereco := Value;
end;

procedure TLocalObra.SetEstado(const Value: String);
begin
  FEstado := Value;
end;

procedure TLocalObra.SetMunicipio(const Value: String);
begin
  FMunicipio := Value;
end;

procedure TLocalObra.SetNaturezaObra(const Value: String);
begin
  FNaturezaObra := Value;
end;

{ TItensContrato }

function TItensContrato.GetDescricaoItem: String;
begin
  Result := FDescricaoItem;
end;

function TItensContrato.GetValor: Double;
begin
  Result := FValor;
end;

function TItensContrato.GetVolume: Double;
begin
  Result := FVolume;
end;

procedure TItensContrato.SetDescricaoItem(const Value: String);
begin
  FDescricaoItem := Value;
end;

procedure TItensContrato.SetValor(const Value: Double);
begin
  FValor := Value;
end;

procedure TItensContrato.SetVolume(const Value: Double);
begin
  FVolume := Value;
end;

{ TDadosEmpresa }

function TDadosEmpresa.GetCep: String;
begin
  Result := FCep;
end;

function TDadosEmpresa.GetCnpj: String;
begin
  Result := FCnpj;
end;

function TDadosEmpresa.GetEndereco: String;
begin
  Result := FEndereco;
end;

function TDadosEmpresa.GetEstado: String;
begin
  Result := FEstado;
end;

function TDadosEmpresa.GetIE: String;
begin
  Result := FIE;
end;

function TDadosEmpresa.GetMunicipio: String;
begin
  Result := FMunicipio;
end;

function TDadosEmpresa.GetNome: String;
begin
  Result := FNome;
end;

procedure TDadosEmpresa.SetCep(const Value: String);
begin
  FCep := Value;
end;

procedure TDadosEmpresa.SetCnpj(const Value: String);
begin
  FCnpj := Value;
end;

procedure TDadosEmpresa.SetEndereco(const Value: String);
begin
  FEndereco := Value;
end;

procedure TDadosEmpresa.SetEstado(const Value: String);
begin
  FEstado := Value;
end;

procedure TDadosEmpresa.SetIE(const Value: String);
begin
  FIE := Value;
end;

procedure TDadosEmpresa.SetMunicipio(const Value: String);
begin
  FMunicipio := Value;
end;

procedure TDadosEmpresa.SetNome(const Value: String);
begin
  FNome := Value;
end;

{ TContratoEmpreita }

function TContratoEmpreita.GetDadosCliente: IDadosCliente;
begin
  Result := FDadosCliente;
end;

function TContratoEmpreita.GetDadosEmpresa: IDadosEmpresa;
begin
  Result := FDadosEmpresa;
end;

function TContratoEmpreita.GetItensContrato: IBaseList;
begin
  Result := FItensContratoList;
end;

function TContratoEmpreita.GetLocalObra: ILocalObra;
begin
  Result := FLocalObra;
end;

function TContratoEmpreita.GetNumeroContrato: String;
begin
  Result := FNumeroContrato;
end;

procedure TContratoEmpreita.SetDadosCliente(const Value: IDadosCliente);
begin
  FDadosCliente := Value;
end;

procedure TContratoEmpreita.SetDadosEmpresa(const Value: IDadosEmpresa);
begin
  FDadosEmpresa := Value;
end;

procedure TContratoEmpreita.SetItensContrato(const Value: IBaseList);
begin
  FItensContratoList := Value;
end;

procedure TContratoEmpreita.SetLocalObra(const Value: ILocalObra);
begin
  FLocalObra := Value;
end;

procedure TContratoEmpreita.SetNumeroContrato(const Value: String);
begin
  FNumeroContrato := Value;
end;

initialization
  Factory.RegisterClass(TDadosCliente,     'DadosCliente');
  Factory.RegisterClass(TDadosEmpresa,     'DadosEmpresa');
  Factory.RegisterClass(TItensContrato,    'ItensContrato');
  Factory.RegisterClass(TLocalObra,        'LocalObra');
  Factory.RegisterClass(TContratoEmpreita, 'ContratoEmpreita');

end.
