{******************************************************************************************}
{* Interface que representa um controle visual em uma tela do auttin, com isso é possivel *}
{* montar uma tela dinamicamente, sem ter que ter alteração no auttin                     *}
{***************************************************************************************PH*}
unit untILibTintaControleVisual;

interface

uses
  untILibTintaControleVisualPropriedade;

type
  ITelaCadLibTintas = interface;

  ILibTintaControleVisualEvento = interface;

  ILibTintaControleVisual = interface
    ['{034744D0-EAD8-408D-B16F-352834AC156A}']
    function GetNome: string;
    function GetClasse(): string;

    function GetImplementacao(): string;

    function GetPropriedade(const strNome: string): ILibTintaControleVisualPropriedade;
    function GetPropriedadeIndex(const index: Integer): ILibTintaControleVisualPropriedade;
    function GetPropriedadesCont(): Integer;

    function AdicionarPropriedade(const propriedade: ILibTintaControleVisualPropriedade): ILibTintaControleVisual;
    procedure RemoverPropriedade(const propriedade: ILibTintaControleVisualPropriedade);
    procedure RemoverPropriedadeIndex(const index: Integer);
    procedure RemoverPropriedadeNome(const strNome: string);

    function GetEvento(const strNome: string): ILibTintaControleVisualEvento;
    function GetEventoIndex(const index: Integer): ILibTintaControleVisualEvento;
    function GetEventosCont(): Integer;

    function AdicionarEvento(const evento: ILibTintaControleVisualEvento): ILibTintaControleVisual;
    procedure RemoverEvento(const evento: ILibTintaControleVisualEvento);
    procedure RemoverEventoIndex(const index: Integer);
    procedure RemoverEventoNome(const strNome: string);

    function GetControle(const index: Integer): ILibTintaControleVisual;
    function GetControleNome(const strNome: string): ILibTintaControleVisual;
    function GetControlesCont(): Integer;

    function AdicionarControle(const controle: ILibTintaControleVisual): ILibTintaControleVisual;
    procedure RemoverControle(const controle: ILibTintaControleVisual);
    procedure RemoverControleIndex(const index: Integer);
    procedure RemoverControleNome(const strNome: string);

    property Nome: string read GetNome;
    property Classe: string read GetClasse;

    property Implementacao: string read GetImplementacao;

    property Propriedade[const strNome: string]: ILibTintaControleVisualPropriedade read GetPropriedade; default;
    property PropriedadeIndex[const index: Integer]: ILibTintaControleVisualPropriedade read GetPropriedadeIndex;
    property PropriedadesCont: Integer read GetPropriedadesCont;

    property Controle[const index: Integer]: ILibTintaControleVisual read GetControle;
    property ControleNome[const strNome: string]: ILibTintaControleVisual read GetControleNome;
    property ControlesCont: Integer read GetControlesCont;

    property Evento[const strNome: string]: ILibTintaControleVisualEvento read GetEvento;
    property EventoIndex[const index: Integer]: ILibTintaControleVisualEvento read GetEventoIndex;
    property EventosCont: Integer read GetEventosCont;
  end;

  TInterfacedObjectHelper = class helper for TInterfacedObject
  public
    function GetImplementator: Pointer;
  end;

  ILibTintaControleVisualEvento = interface
    ['{2706980A-088B-4F73-8792-732A82886C44}']
    function GetNome: string;

    function GetLibTintaControleVisual: ILibTintaControleVisual;
    function GetTelaCadLibTintas: ITelaCadLibTintas;
    procedure SetLibTintaControleVisual(const value: ILibTintaControleVisual);
    procedure SetTelaCadLibTintas(const value: ITelaCadLibTintas);

    function GetImplementator: Pointer;
    function GetMethodAddress: Pointer;

    property LibTintaControleVisual: ILibTintaControleVisual read GetLibTintaControleVisual write SetLibTintaControleVisual;
    property TelaCadLibTintas: ITelaCadLibTintas read GetTelaCadLibTintas write SetTelaCadLibTintas;
    property Nome: string read GetNome;
  end;

  ITelaCadLibTintas = interface
    ['{1CFD96FA-CBC4-4B83-B2D7-E4C503E3470A}']
    function GetLibTintaControleVisualNome(const strNome: string): ILibTintaControleVisual;
    function GetSelf(): ILibTintaControleVisual;
    procedure SelectNext;
    procedure SelectFirst;

    function GetBlnExcluiu: Boolean;
    function GetBlnAlterou: Boolean;
    function GetBlnGravou: Boolean;
    procedure pSetarFocus;

    function GetTextDBComboBox: String;

    
    property Controle[const strNome: string]: ILibTintaControleVisual read GetLibTintaControleVisualNome; default;
  end;

implementation

{ TInterfacedObjectHelper }

function TInterfacedObjectHelper.GetImplementator: Pointer;
begin
  Result := Self;
end;

end.
