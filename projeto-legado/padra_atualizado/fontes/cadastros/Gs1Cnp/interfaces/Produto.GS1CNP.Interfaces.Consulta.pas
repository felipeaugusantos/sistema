unit Produto.GS1CNP.Interfaces.Consulta;

interface

uses untFuncoesSimples;

const

  PROD_DESCRICAO    = 'Descrição';
  PROD_MARCA        = 'Marca';
  PROD_PESO_BRUTO   = 'Peso Bruto';
  PROD_PESO_LIQUIDO = 'Peso Liquido';
  PROD_CODIGO_GPC   = 'Código GPC';
  PROD_IMAGEM       = 'Imagem';
  PROD_NCM          = 'NCM';

type
  IProdutoGS1CNPConsultaFactory = interface
    ['{1F0577C0-C791-44A4-8BB2-F52EB390339C}']

    procedure Consultar(dicValoresAtuais, dicResultado: TDicionario; const ACodBar: String; const AInsert: Boolean; const AAccessToken: String);
  end;

  IProdutoGS1CNPConsultaRetorno = interface
    ['{F8A227D9-F7A6-4C9E-B863-23AEE57901AF}']

    function GetDescricao: String; overload;
    function SetDescricao(const AValue: String): IProdutoGS1CNPConsultaRetorno; overload;

    function GetMarca: String; overload;
    function SetMarca(const AValue: String): IProdutoGS1CNPConsultaRetorno; overload;

    function GetPesoBruto: Double; overload;
    function SetPesoBruto(const AValue: Double): IProdutoGS1CNPConsultaRetorno; overload;

    function GetPesoLiquido: Double; overload;
    function SetPesoLiquido(const AValue: Double): IProdutoGS1CNPConsultaRetorno; overload;

    function GetCodigoGPC: String; overload;
    function SetCodigoGPC(const AValue: String): IProdutoGS1CNPConsultaRetorno; overload;

    function GetImagem: String; overload;
    function SetImagem(const AValue: String): IProdutoGS1CNPConsultaRetorno; overload;

    function GetStatus: String; overload;
    function SetStatus(const AValue: String): IProdutoGS1CNPConsultaRetorno; overload;

    function GetNcm: String; overload;
    function SetNcm(const AValue: String): IProdutoGS1CNPConsultaRetorno; overload;
  end;

implementation

end.
