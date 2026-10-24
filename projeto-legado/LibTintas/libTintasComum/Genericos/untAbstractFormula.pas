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
    FOpcDoc  : String;
    FQtdEmb  : Integer;
    strEmpEst: String;
    FEmpEst  : String;
  protected
    strTabPre: String;
    strTabPreTin: String;
    stlTextoInformativoCalculo: TStringList;
  protected
    function GetTextoInformativoCalculo(): String; virtual; abstract;
    procedure CalcularPrecos; virtual; abstract;
  protected
    function GetOutrosValores(): Double; virtual; abstract;
    function GetIcmsSaida(): Double; virtual; abstract;
    function GetImpostosFederais(): Double; virtual; abstract;
    function GetDespesasOperacionais(): Double; virtual; abstract;

    function GetPrecoMedio(): Double; virtual; abstract;
    function GetUltimoPrecoCompra(): Double; virtual; abstract;
    function GetUltimoPrecoCompraImpostos(): Double; virtual; abstract;
    function GetPrecoCompraLiquido(): Double; virtual; abstract;

    function GetPrecoCusto(): Double; virtual; abstract;
    function GetPrecoCustoReal(): Double; virtual; abstract;
    function GetPrecoVenda(): Double; virtual; abstract;

    procedure SetOpcDoc(const Value: String);
    procedure SetEmpEst(const Value: String);
  private
    FCodCli: String;
    FPrzMed: Integer;
    FCodCnd: String;
    FProPre: Boolean;
  protected
    procedure SetCodCli(const Value: String);
    procedure SetPrzMed(const Value: Integer);
    procedure SetCodCnd(const Value: String);
    procedure SetQtdEmb(const Value: Integer);
    procedure SetProPre(const Value: Boolean);
  public
    intQtdEmb: Integer;
    strCodCli: String;
    intPrzMed: Integer;
    FstrOpcDoc : String;
    strCodCnd: String;
    blnProPre: Boolean;
    procedure RecalcularTabelas(dicRetorno: IDicionario); virtual; abstract;
    function GetFatorEstoque(): Double; virtual; abstract;
    function GetIdePro: String; virtual; abstract;
    function GetPrefixoFormulacao(): String; virtual; abstract;
    function GetQuantidadeFormulacao(): Integer; virtual; abstract;
    function GetPrefixoQuantidade(const strModo: String): String; virtual; abstract;
    function GetChaveIteTin(const dtsCadTin: IDataSet): string; virtual; abstract;
    function GetCodNovaFormula(): String; Virtual;
  public
    constructor Create(const ItemClass: TCollectionItemClass); overload; virtual;
    constructor Create(); overload; virtual;
    destructor Destroy; override;
  public
    property TabPre: String read strTabPre Write strTabPre;
    property TabPreTin: String read strTabPreTin Write strTabPreTin;//Tabela de preco da tinta para recalculo de preco das tabelas(utilizado na promocao)
    property TextoInformativoCalculo: TStringList read stlTextoInformativoCalculo;
  public
    property OutrosValores: Double read GetOutrosValores;
    property IcmsSaida: Double read GetIcmsSaida;
    property ImpostosFederais: Double read GetImpostosFederais;
    property DespesasOperacionais: Double read GetDespesasOperacionais;

    property PrecoMedio: Double read GetPrecoMedio;
    property UltimoPrecoCompra: Double read GetUltimoPrecoCompra;
    property UltimoPrecoCompraImpostos: Double read GetUltimoPrecoCompraImpostos;
    property PrecoCompraLiquido: Double read GetPrecoCompraLiquido;

    property PrecoCusto: Double read GetPrecoCusto;
    property PrecoVenda: Double read GetPrecoVenda;
    property PrecoCustoReal: Double read GetPrecoCustoReal;

  public
    property FatorEstoque: Double read GetFatorEstoque;
    property OpcDoc: String read FOpcDoc write SetOpcDoc;
  public
    property CodCli: String read FCodCli write SetCodCli;
    property PrzMed: Integer read FPrzMed write SetPrzMed;
    property CodCnd: String read FCodCnd write SetCodCnd;
    property QtdEmb: Integer read FQtdEmb write SetQtdEmb;
    property EmpEst: String read FEmpEst write SetEmpEst;
    property ProPre: Boolean read FProPre write SetProPre;
  end;

implementation

uses
  untColorante, untBaseAutomotiva;

{ TAbstractFormula }

constructor TAbstractFormula.Create(const ItemClass: TCollectionItemClass);
begin
  inherited Create(ItemClass);
  stlTextoInformativoCalculo := TStringList.Create;
end;

constructor TAbstractFormula.Create;
begin
  //Create(TColorante);
  //Create(TBaseAutomotiva);
end;

destructor TAbstractFormula.Destroy;
begin
  if Assigned(stlTextoInformativoCalculo) then FreeAndNil(stlTextoInformativoCalculo);
  inherited Destroy;
end;

function TAbstractFormula.GetCodNovaFormula: String;
begin
  Result := '';
end;

procedure TAbstractFormula.SetCodCli(const Value: String);
begin
  strCodCli := Value;
  FCodCli := Value;
end;

procedure TAbstractFormula.SetCodCnd(const Value: String);
begin
  strCodCnd := Value;
  FCodCnd := Value;
end;

procedure TAbstractFormula.SetEmpEst(const Value: String);
begin
  strEmpEst := Value;
end;

procedure TAbstractFormula.SetOpcDoc(const Value: String);
begin
  If Pos(Value, '_OR_PD_TE_') > 0 Then
    strOpcDoc := Value
  Else
    strOpcDoc:= 'VN';

  FstrOpcDoc  := strOpcDoc;
end;


procedure TAbstractFormula.SetProPre(const Value: Boolean);
begin
  blnProPre := Value;
  FProPre   := Value;
end;

procedure TAbstractFormula.SetPrzMed(const Value: Integer);
begin
  intPrzMed := Value;
  FPrzMed := Value;
end;

procedure TAbstractFormula.SetQtdEmb(const Value: Integer);
begin
  intQtdEmb := Value;
end;

end.
