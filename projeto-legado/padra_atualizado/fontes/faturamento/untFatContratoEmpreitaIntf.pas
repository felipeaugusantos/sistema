unit untFatContratoEmpreitaIntf;

interface

uses untBaseIntf, untBaseListIntf;

type
  IDadosCliente = interface(IBaseIntf)
    ['{14FCE707-33CE-4008-ABFF-765462D4A9C9}']
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
  ILocalObra = interface(IBaseIntf)
    ['{10EF3545-C174-447A-B25F-941AC0EEE2E8}']
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
    property Endereco    : String read GetEndereco     write SetEndereco;
    property Bairro      : String read GetBairro       write SetBairro;
    property Municipio   : String read GetMunicipio    write SetMunicipio;
    property Estado      : String read GetEstado       write SetEstado;
    property Cep         : String read GetCep          write SetCep;
    property NaturezaObra: String read GetNaturezaObra write SetNaturezaObra;
  end;

type
  IItensContrato = interface(IBaseIntf)
    ['{FE5F5FD6-0180-4534-9ABC-DC29A6B647BC}']
    function GetDescricaoItem: String;
    function GetValor: Double;
    function GetVolume: Double;
    procedure SetDescricaoItem(const Value: String);
    procedure SetValor(const Value: Double);
    procedure SetVolume(const Value: Double);
    property Volume       : Double read GetVolume        write SetVolume;
    property DescricaoItem: String read GetDescricaoItem write SetDescricaoItem;
    property Valor        : Double read GetValor         write SetValor;
  end;

type
  IDadosEmpresa = interface(IBaseIntf)
    ['{9CEBD7AB-4429-4909-8D88-718778C362E4}']
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
    property Nome     : String read GetNome      write SetNome;
    property Cnpj     : String read GetCnpj      write SetCnpj;
    property IE       : String read GetIE        write SetIE;
    property Municipio: String read GetMunicipio write SetMunicipio;
    property Endereco : String read GetEndereco  write SetEndereco;
    property Cep      : String read GetCep       write SetCep;
    property Estado   : String read GetEstado    write SetEstado;
  end;

type
  IContratoEmpreita = interface(IBaseIntf)
    ['{23E2A2FA-2791-42F6-80BA-C9FDF13455B4}']
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
    property NumeroContrato: String        read GetNumeroContrato write SetNumeroContrato;
    property DadosCliente  : IDadosCliente read GetDadosCliente   write SetDadosCliente;
    property LocalObra     : ILocalObra    read GetLocalObra      write SetLocalObra;
    property ItensContrato : IBaseList     read GetItensContrato  write SetItensContrato;
    property DadosEmpresa  : IDadosEmpresa read GetDadosEmpresa   write SetDadosEmpresa;
  end;

implementation

end.
