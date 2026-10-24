{********************************************************************************************}
{* Interface que representa um cadastro generico de uma dll de tinta, com isso é possivel   *}
{* realizar um cadastro de algum componente de dll de tinta sem ter que recompilar o auttin *}
{*****************************************************************************************PH*}
unit untICadLibTintas;

interface

uses
  untIConsulta, untILibTintaControleVisual, untIDataSet;

type
  TCadLibTintasStringArray = array of string;
  TCadLibTintasVariantArray = array of Variant;

  ICadLibTintas = interface
    ['{4CF0F762-F601-4F43-9F63-E337BA3DB52F}']
    function GetConsulta(): IConsulta;
    function GetNomeTabela: string;
    function GetNomeCampo: string;
    function GetClassName: string;

    function GetLibTintaControleVisual (const index: Integer): ILibTintaControleVisual;
    function GetLibTintaControleVisualCont(): Integer;

    function GetNomeCampoRelacionamento: string;

    function GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
    procedure pSetaEnableReadOnly(const tela: ITelaCadLibTintas; const strState: string);
    function fValidaCampos(const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: String; var strRetorno: String): Boolean;
    procedure CarregarDescricoes(const tela: ITelaCadLibTintas);

    procedure SetQueryCadastro(const dataSet: IDataSet);
    function GetQueryCadastro(): IDataSet;

    function GetTitulo: string;
    function GetIdePro: string;

    function fGetCountCamposChave: Integer;
    function fGetCampoChave(const index: Integer): string;
    procedure FormatarCampo(const strNomeCampo: string; var arrPropriedades: TCadLibTintasStringArray; var arrValores: TCadLibTintasVariantArray);
    procedure AjustarTela(const tela: ITelaCadLibTintas);

    procedure IncluirAntes(const tela: ITelaCadLibTintas; const strState: string);
    procedure IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
    procedure GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
    procedure GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
    procedure AlterarAntes(const tela: ITelaCadLibTintas; const strState: string);
    procedure AlterarDepois(const tela: ITelaCadLibTintas; const strState: string);
    procedure ExcluirAntes(const tela: ITelaCadLibTintas; const strState: string);
    procedure ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string);
    procedure CancelarAntes(const tela: ITelaCadLibTintas; const strState: string);
    procedure CancelarDepois(const tela: ITelaCadLibTintas; const strState: string);
    procedure PesquisarAntes(const tela: ITelaCadLibTintas; const strState: string);
    procedure PesquisarDepois(const tela: ITelaCadLibTintas; const strState: string);

    property Titulo: string read GetTitulo;
    property IdePro: string read GetIdePro;
    property NomeTabela: string read GetNomeTabela;
    property NomeCampo: string read GetNomeCampo;
    property ClassName: string read GetClassName;
    property NomeCampoRelacionamento: string read GetNomeCampoRelacionamento;
    property LibTintaControlesVisuais[const index: Integer]: ILibTintaControleVisual read GetLibTintaControleVisual;
    property LibTintaControlesVisuaisCont: Integer read GetLibTintaControleVisualCont;
    property QryCadastro: IDataSet read GetQueryCadastro write SetQueryCadastro;
  end;

implementation

end.
