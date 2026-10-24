unit untIDadosTinta;

interface

uses
  untIDadosTintasComponentes;

type
  IDadosTinta = interface(IInterface)
    ['{FF01F54E-1433-4837-8162-CB12341CF979}']
    function GetAno: string;
    function GetBase: string;
    function GetComponentes(const Index: Integer): IDadosTintasComponentes;
    function GetComponentesCount: Integer;
    function GetDescontoEspecial: Double;
    function GetEmbalagem: string;
    function GetEmpresa: string;
    function GetFatorAcerto: Double;
    function GetIdePro: string;
    function GetIteTin: string;
    function GetLinha: string;
    function GetMontadora: string;
    function GetQuantidade: Double;
    function GetQuantidadeEmbalagem: Double;
    function GetTabelaPreco: string;
    function GetTipoPreco: string;
    function GetVolume: Double;
    function GetDescricao: string;
    function GetRecNo: Integer;
    property Ano: string read GetAno;
    property Base: string read GetBase;
    property Componentes[const Index: Integer]: IDadosTintasComponentes read
        GetComponentes; default;
    property ComponentesCount: Integer read GetComponentesCount;
    property DescontoEspecial: Double read GetDescontoEspecial;
    property Embalagem: string read GetEmbalagem;
    property Empresa: string read GetEmpresa;
    property FatorAcerto: Double read GetFatorAcerto;
    property IdePro: string read GetIdePro;
    property IteTin: string read GetIteTin;
    property Linha: string read GetLinha;
    property Montadora: string read GetMontadora;
    property Quantidade: Double read GetQuantidade;
    property QuantidadeEmbalagem: Double read GetQuantidadeEmbalagem;
    property TabelaPreco: string read GetTabelaPreco;
    property TipoPreco: string read GetTipoPreco;
    property Volume: Double read GetVolume;
    property Descricao: string read GetDescricao;
    property RecNo: Integer read GetRecNo;
  end;

implementation

end.
