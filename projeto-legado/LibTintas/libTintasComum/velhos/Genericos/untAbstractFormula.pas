{*****************************************************************}
{* Classe abstrata que implementa o básico de todas as formulas. *}
{**************************************************************PH*}
unit untAbstractFormula;

interface

uses
  Classes, SysUtils, untIDicionario, untIDataSet, untISaldosColorantes;

type
  TAbstractFormula = class abstract(TCollection)
  private
    strOpcDoc: String;
    FOpcDoc: String;
  protected
    strTabPre: String;
    stlTextoInformativoCalculo: TStringList;
  protected
    function GetTextoInformativoCalculo(): String; virtual; abstract;
    procedure CalcularPrecos; virtual; abstract;
  protected
    function GetOutrosValores(): Double; virtual; abstract;
    function GetIcmsSaida(): Double; virtual; abstract;
    function GetImpostosFederais(): Double; virtual; abstract;
    function GetDespesasOperacionais(): Double; virtual; abstract;
    function GetPrecoCusto(): Double; virtual; abstract;
    function GetPrecoCustoReal(): Double; virtual; abstract;
    function GetPrecoVenda(): Double; virtual; abstract;
    procedure SetOpcDoc(const Value: String);
  public
    procedure RecalcularTabelas(const dicRetorno: IDicionario); virtual; abstract;
    function GetFatorEstoque(): Double; virtual; abstract;
    function GetIdePro: String; virtual; abstract;
    function GetPrefixoFormulacao(): String; virtual; abstract;
    function GetQuantidadeFormulacao(): Integer; virtual; abstract;
    function GetPrefixoQuantidade(const strModo: String): String; virtual; abstract;
    function GetChaveIteTin(const dtsCadTin: IDataSet): string; virtual; abstract;
    function GetSaldos: ISaldosColorantes; virtual; abstract;
  public
    constructor Create(const ItemClass: TCollectionItemClass); overload; virtual;
    constructor Create(); overload; virtual;
    destructor Destroy; override;
  public
    property TabPre: String read strTabPre;
    property TextoInformativoCalculo: TStringList read stlTextoInformativoCalculo;
  public
    property OutrosValores: Double read GetOutrosValores;
    property IcmsSaida: Double read GetIcmsSaida;
    property ImpostosFederais: Double read GetImpostosFederais;
    property DespesasOperacionais: Double read GetDespesasOperacionais;
    property PrecoCusto: Double read GetPrecoCusto;
    property PrecoVenda: Double read GetPrecoVenda;
    property PrecoCustoReal: Double read GetPrecoCustoReal;
  public
    property FatorEstoque: Double read GetFatorEstoque;
    property OpcDoc: String read FOpcDoc write SetOpcDoc;
  end;

implementation

uses
  untColorante;

{ TAbstractFormula }

constructor TAbstractFormula.Create(const ItemClass: TCollectionItemClass);
begin
  inherited Create(ItemClass);
  stlTextoInformativoCalculo := TStringList.Create;
end;

constructor TAbstractFormula.Create;
begin
  Create(TColorante);
end;

destructor TAbstractFormula.Destroy;
begin
  if Assigned(stlTextoInformativoCalculo) then FreeAndNil(stlTextoInformativoCalculo);
  inherited Destroy;
end;

procedure TAbstractFormula.SetOpcDoc(const Value: String);
begin
  If Pos('_OR_PD_', Value) > 0 Then
    strOpcDoc := Value
  Else
    strOpcDoc:= 'VN';
end;

end.
