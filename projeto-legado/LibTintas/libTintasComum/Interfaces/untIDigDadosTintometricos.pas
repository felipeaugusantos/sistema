{*****************************************************************************************}
{* Interface que representa a implementação dos dados informados pelo usuario no momento *}
{* da venda                                                                              *}
{**************************************************************************************PH*}
unit untIDigDadosTintometricos;

interface

uses
  untIDataSet, untIDicionario, untISaldosColorantes;

type
  IDigDadosTintometricos = interface
    ['{9A121190-3492-4078-A003-CD48B91E9BFD}']
    function fDigDadosTintometricos(const dtsCadTin: IDataSet;
      dicRetorno: IDicionario; blnSemTela: Boolean = False; strEmbPro: String = ''; strModoVenda: String = ''; strCodDil: String = ''): Boolean;
    function GetDescricaoCor: String;
    function GetCodigoItem: String;
    function GetChaveIteTin: String;
    function GetUnidade: String;
    function GetPrecoVendaTinta: Double;
    function GetPrecoCustoTinta: Double;
    function GetSaldos: ISaldosColorantes;
    function GetChaForEspecifico(const dicRetorno: IDicionario; const dtsCadTin: IDataSet): String;

    function GetFatorTinta: Double;
    function GetItemEmbalagem: String;
    function GetTipoPreco: String;
    function GetTipoEmbalagem: String;
    function GetQuantidadeEmbalagem: Integer;
    function GetPrecoEmbalagem: Double;
    function GetEmbalagem: Double;
    function GetVolumeProduto: Double;
    function GetMontadadora: String;
    function GetA_n_o_: String;
    function GetUniversal: String;
    function GetChaFor: String;
    function GetPrecoCustoRealTinta: Double;
    function GetTipoTinta: String;
    function GetCatalisador: String;
    function GetBaseQtdZerada: String;
    function GetLinha: String;
    function GetUsaChapinha: String;
    function GetItemChapinha: String;

    property DescricaoCor: String read GetDescricaoCor;
    property CodigoItem: String read GetCodigoItem;
    property ChaveIteTin: String read GetChaveIteTin;
    property Unidade: String read GetUnidade;
    property PrecoVendaTinta: Double read GetPrecoVendaTinta;
    property PrecoCustoTinta: Double read GetPrecoCustoTinta;

    property FatorTinta: Double read GetFatorTinta;
    property ItemEmbalagem: String read GetItemEmbalagem;
    property TipoPreco: String read GetTipoPreco;
    property TipoEmbalagem: String read GetTipoEmbalagem;
    property QuantidadeEmbalagem: Integer read GetQuantidadeEmbalagem;
    property PrecoEmbalagem: Double read GetPrecoEmbalagem;
    property Embalagem: Double read GetEmbalagem;
    property VolumeProduto: Double read GetVolumeProduto;
    property Montadadora: String read GetMontadadora;
    property A_n_o_: String read GetA_n_o_;
    property Universal: String read GetUniversal;
    property ChaFor: String read GetChaFor;
    property PrecoCustoRealTinta: Double read GetPrecoCustoRealTinta;
    property TipoTinta: String read GetTipoTinta;
    property Catalisador: String read GetCatalisador;
    property BaseQtdZerada: String read GetBaseQtdZerada;
    property Linha: String read GetLinha;
    property ItemChapinha: String Read GetItemChapinha;
    Property UsaChapinha: String Read GetUsaChapinha;
  end;

implementation

end.
