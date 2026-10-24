unit Faturamento.Margem.Tipos.MargemBruta;

interface

uses Faturamento.Margem.Interfaces.MargemBruta,
     Shared.Functions.Types;

type
  TParametrosServicoMargemBruta = class(TInterfacedObject, IParametrosServicoMargemBruta)
  private
    FConfiguracaoMargemMarkup: String;
    FPrecoDeCusto            : Double;
    FPrecoDeVenda            : Double;
    FValorDaMargem           : Double;
    FIcmsDeSaida             : Double;
    FImpostosFederais        : Double;
    FDespesasOperacionais    : Double;
    FPrecoDeCompra           : Double;
    FValorIcmsSt             : Double;
    FCalcularST              : Boolean;
    FValorDifal              : Double;
    FValorFCP                : Double;
  public

    function ConfiguracaoMargemMarkup: String; overload;
    function ConfiguracaoMargemMarkup(AValue : String) : IParametrosServicoMargemBruta; overload;

    function PrecoDeCusto : Double; overload;
    function PrecoDeCusto(AValue : Double) : IParametrosServicoMargemBruta; overload;

    function PrecoDeVenda : Double; overload;
    function PrecoDeVenda(AValue : Double) : IParametrosServicoMargemBruta; overload;

    function ValorDaMargem: Double; overload;
    function ValorDaMargem(AValue : Double) : IParametrosServicoMargemBruta; overload;

    function IcmsDeSaida : Double; overload;
    function IcmsDeSaida(AValue : Double) : IParametrosServicoMargemBruta; overload;

    function ImpostosFederais : Double; overload;
    function ImpostosFederais(AValue : Double) : IParametrosServicoMargemBruta; overload;

    function DespesasOperacionais : Double; overload;
    function DespesasOperacionais(AValue : Double) : IParametrosServicoMargemBruta; overload;

    function PrecoDeCompra : Double; overload;
    function PrecoDeCompra(AValue : Double) : IParametrosServicoMargemBruta; overload;

    function ValorIcmsSt : Double; overload;
    function ValorIcmsSt(AValue : Double) : IParametrosServicoMargemBruta; overload;

    function CalcularST : Boolean; overload;
    function CalcularST(AValue : Boolean) : IParametrosServicoMargemBruta; overload;

    function ValorDifal : Double; overload;
    function ValorDifal(AValue : Double) : IParametrosServicoMargemBruta; overload;

    function ValorFCP: Double; overload;
    function ValorFCP(AValue: Double) : IParametrosServicoMargemBruta; overload;

    class function New(): IParametrosServicoMargemBruta;
  end;

type
  TParametrosServicoMargemParaMarkup = class(TInterfacedObject, IParametrosServicoMargemParaMarkup)
  private
    FValorDaMargem : Double;
  public
    function ValorDaMargem : Double; overload;
    function ValorDaMargem(AValue : Double) : IParametrosServicoMargemParaMarkup; overload;

    class function New(): IParametrosServicoMargemParaMarkup;
  end;


type
  TParametrosCalculoMargemBruta = class(TInterfacedObject, IParametrosCalculoMargemBruta)
  strict private
    FConfiguracaoMargemMarkup: String;
    FPrecoDeCusto            : Double;
    FPrecoDeVenda            : Double;
    FValorDaMargem           : Double;
    FIcmsDeSaida             : Double;
    FImpostosFederais        : Double;
    FDespesasOperacionais    : Double;
    FPrecoDeCompra           : Double;
    FValorIcmsSt             : Double;
    FCalcularST              : Boolean;
    FValorDifal              : Double;
    FValorFCP                : Double;
  public

    function ConfiguracaoMargemMarkup: String; overload;
    function ConfiguracaoMargemMarkup(AValue : String) : IParametrosCalculoMargemBruta; overload;

    function PrecoDeCusto : Double; overload;
    function PrecoDeCusto(AValue : Double) : IParametrosCalculoMargemBruta; overload;

    function PrecoDeVenda : Double; overload;
    function PrecoDeVenda(AValue : Double) : IParametrosCalculoMargemBruta; overload;

    function ValorDaMargem : Double; overload;
    function ValorDaMargem(AValue : Double) : IParametrosCalculoMargemBruta; overload;

    function IcmsDeSaida : Double; overload;
    function IcmsDeSaida(AValue : Double) : IParametrosCalculoMargemBruta; overload;

    function ImpostosFederais : Double; overload;
    function ImpostosFederais(AValue : Double) : IParametrosCalculoMargemBruta; overload;

    function DespesasOperacionais : Double; overload;
    function DespesasOperacionais(AValue : Double) : IParametrosCalculoMargemBruta; overload;

    function PrecoDeCompra : Double; overload;
    function PrecoDeCompra(AValue : Double) : IParametrosCalculoMargemBruta; overload;

    function ValorIcmsSt : Double; overload;
    function ValorIcmsSt(AValue : Double) : IParametrosCalculoMargemBruta; overload;

    function CalcularST : Boolean; overload;
    function CalcularST(AValue : Boolean) : IParametrosCalculoMargemBruta; overload;

    function ValorDifal : Double; overload;
    function ValorDifal(AValue : Double) : IParametrosCalculoMargemBruta; overload;

    function ValorFCP: Double; overload;
    function ValorFCP(AValue: Double) : IParametrosCalculoMargemBruta; overload;

    class function New(): IParametrosCalculoMargemBruta;
  end;

Type
  TParametrosCalculoMargemParaMarkup = class(TInterfacedObject, IParametrosCalculoMargemParaMarkup)
  strict private
    FValorDaMargem : Double;
  public
    function ValorDaMargem : Double; overload;
    function ValorDaMargem(AValue : Double) : IParametrosCalculoMargemParaMarkup; overload;

    class function new(): IParametrosCalculoMargemParaMarkup;
  end;

type
  TResultadoCalculoMargemBruta = class(TInterfacedObject, IResultadoCalculoMargemBruta)
  strict private
    FValorMargemBruta : Double;
  public
    function ValorMargemBruta: Double; overload;
    function ValorMargemBruta(AValue: Double) : IResultadoCalculoMargemBruta; overload;

    class function New(): IResultadoCalculoMargemBruta;
  end;

Type
  TResultadoCalculoMargemParaMarkup  = class(TInterfacedObject, IResultadoCalculoMargemParaMarkup)
  strict private
    FValorMarkup: Double;
  public
    function ValorMarkup: Double; overload;
    function ValorMarkup(AValue: Double) : IResultadoCalculoMargemParaMarkup; overload;

    class function New(): IResultadoCalculoMargemParaMarkup;
  end;

type
  TResultadoServicosClasseMargemBruta = class(TInterfacedObject, IResultadoServicosClasseMargemBruta)
  strict private
    FParametrosCalculoMargemBruta     : IParametrosCalculoMargemBruta;
    FResultadoCalculoMargemBruta      : IResultadoCalculoMargemBruta;

    FParametrosCalculoMargemParaMarkup: IParametrosCalculoMargemParaMarkup;
    FResultadoCalculoMargemParaMarkup : IResultadoCalculoMargemParaMarkup;
  public
    function ParametrosCalculoMargemBruta  : IParametrosCalculoMargemBruta; overload;
    function ParametrosCalculoMargemBruta(AValue : IParametrosCalculoMargemBruta) : IResultadoServicosClasseMargemBruta; overload;

    function ParametrosCalculoMargemParaMarkup: IParametrosCalculoMargemParaMarkup; overload;
    function ParametrosCalculoMargemParaMarkup( AValue : IParametrosCalculoMargemParaMarkup) :IResultadoServicosClasseMargemBruta; overload;

    function ResultadoCalculoMargemBruta : IResultadoCalculoMargemBruta; overload;
    function ResultadoCalculoMargemBruta(AValue : IResultadoCalculoMargemBruta) :IResultadoServicosClasseMargemBruta; overload;

    function ResultadoCalculoMargemParaMarkup : IResultadoCalculoMargemParaMarkup; overload;
    function ResultadoCalculoMargemParaMarkup( AValue : IResultadoCalculoMargemParaMarkup) : IResultadoServicosClasseMargemBruta; overload;

    class function New(): IResultadoServicosClasseMargemBruta;
  end;

implementation

{ TParametrosCalculoMargemBruta }



function TParametrosCalculoMargemBruta.CalcularST(
  AValue: Boolean): IParametrosCalculoMargemBruta;
begin
  Result := self;
  FCalcularST := AValue;
end;

function TParametrosCalculoMargemBruta.CalcularST: Boolean;
begin
  Result := FCalcularST;
end;

function TParametrosCalculoMargemBruta.ConfiguracaoMargemMarkup: String;
begin
  Result := FConfiguracaoMargemMarkup;
end;

function TParametrosCalculoMargemBruta.ConfiguracaoMargemMarkup(
  AValue: String): IParametrosCalculoMargemBruta;
begin
  Result := Self;
  FConfiguracaoMargemMarkup := AValue;
end;

function TParametrosCalculoMargemBruta.DespesasOperacionais: Double;
begin
  Result := FDespesasOperacionais;
end;

function TParametrosCalculoMargemBruta.DespesasOperacionais(
  AValue: Double): IParametrosCalculoMargemBruta;
begin
  Result := Self;
  FDespesasOperacionais := Avalue;
end;

function TParametrosCalculoMargemBruta.IcmsDeSaida: Double;
begin
  result := FIcmsDeSaida;
end;

function TParametrosCalculoMargemBruta.IcmsDeSaida(
  AValue: Double): IParametrosCalculoMargemBruta;
begin
  Result := Self;
  FIcmsDeSaida := AValue;
end;

function TParametrosCalculoMargemBruta.ImpostosFederais: Double;
begin
  Result := FImpostosFederais;
end;

function TParametrosCalculoMargemBruta.ImpostosFederais(
  AValue: Double): IParametrosCalculoMargemBruta;
begin
  Result := Self;
  FImpostosFederais := AValue;
end;

class function TParametrosCalculoMargemBruta.New: IParametrosCalculoMargemBruta;
begin
  Result := Self.Create;
end;


function TParametrosCalculoMargemBruta.PrecoDeCompra: Double;
begin
  Result := FPrecoDeCompra;
end;

function TParametrosCalculoMargemBruta.PrecoDeCompra(
  AValue: Double): IParametrosCalculoMargemBruta;
begin
  Result := Self;
  FPrecoDeCompra := AValue;
end;

function TParametrosCalculoMargemBruta.PrecoDeCusto: Double;
begin
  Result := FPrecoDeCusto;
end;

function TParametrosCalculoMargemBruta.PrecoDeCusto(
  AValue: Double): IParametrosCalculoMargemBruta;
begin
  Result := Self;
  FPrecoDeCusto := AValue;
end;

function TParametrosCalculoMargemBruta.PrecoDeVenda(
  AValue: Double): IParametrosCalculoMargemBruta;
begin
  Result := Self;
  FPrecoDeVenda := AValue;
end;

function TParametrosCalculoMargemBruta.PrecoDeVenda: Double;
begin
  result := FPrecoDeVenda;
end;

function TParametrosCalculoMargemBruta.ValorDaMargem: Double;
begin
  Result := FValorDaMargem;
end;

function TParametrosCalculoMargemBruta.ValorDaMargem(
  AValue: Double): IParametrosCalculoMargemBruta;
begin
  Result := Self;
  FValorDaMargem := AValue;
end;

function TParametrosCalculoMargemBruta.ValorDifal: Double;
begin
  result := FValorDifal;
end;

function TParametrosCalculoMargemBruta.ValorDifal(
  AValue: Double): IParametrosCalculoMargemBruta;
begin
  Result := Self;
  FValorDifal := AValue;
end;

function TParametrosCalculoMargemBruta.ValorFCP: Double;
begin
  Result := FValorFCP;
end;

function TParametrosCalculoMargemBruta.ValorFCP(
  AValue: Double): IParametrosCalculoMargemBruta;
begin
  Result := Self;
  FValorFCP := Avalue;
end;

function TParametrosCalculoMargemBruta.ValorIcmsSt(
  AValue: Double): IParametrosCalculoMargemBruta;
begin
  Result := Self;
  FValorIcmsSt := AValue;
end;

function TParametrosCalculoMargemBruta.ValorIcmsSt: Double;
begin
  Result := FValorIcmsSt;
end;

{ TResultadoCalculoMargemBruta}

class function TResultadoCalculoMargemBruta.New: IResultadoCalculoMargemBruta;
begin
  Result := Self.Create;
end;

class function TResultadoServicosClasseMargemBruta.New: IResultadoServicosClasseMargemBruta;
begin
  Result := Self.Create;
end;

function TParametrosServicoMargemBruta.CalcularST(
  AValue: Boolean): IParametrosServicoMargemBruta;
begin
  Result := Self;
  FCalcularST := Avalue;
end;

function TParametrosServicoMargemBruta.CalcularST: Boolean;
begin
  Result := FCalcularST;
end;

function TParametrosServicoMargemBruta.ConfiguracaoMargemMarkup: String;
begin
  Result := FConfiguracaoMargemMarkup;
end;

function TParametrosServicoMargemBruta.ConfiguracaoMargemMarkup(
  AValue: String): IParametrosServicoMargemBruta;
begin
  Result := Self;
  FConfiguracaoMargemMarkup := Avalue;
end;

function TParametrosServicoMargemBruta.DespesasOperacionais: Double;
begin
  Result := FDespesasOperacionais;
end;

function TParametrosServicoMargemBruta.DespesasOperacionais(
  AValue: Double): IParametrosServicoMargemBruta;
begin
  Result := Self;
  FDespesasOperacionais := Avalue;
end;

function TParametrosServicoMargemBruta.IcmsDeSaida: Double;
begin
  Result := FIcmsDeSaida;
end;

function TParametrosServicoMargemBruta.IcmsDeSaida(
  AValue: Double): IParametrosServicoMargemBruta;
begin
  Result := Self;
  FIcmsDeSaida := Avalue;
end;

function TParametrosServicoMargemBruta.ImpostosFederais: Double;
begin
  Result := FImpostosFederais;
end;

function TParametrosServicoMargemBruta.ImpostosFederais(
  AValue: Double): IParametrosServicoMargemBruta;
begin
  Result := Self;
  FImpostosFederais := Avalue;
end;

class function TParametrosServicoMargemBruta.New: IParametrosServicoMargemBruta;
begin
  Result := Self.Create;
end;

function TParametrosServicoMargemBruta.PrecoDeCompra: Double;
begin
  Result := FPrecoDeCompra;
end;

function TParametrosServicoMargemBruta.PrecoDeCompra(
  AValue: Double): IParametrosServicoMargemBruta;
begin
  Result := Self;
  FPrecoDeCompra := Avalue;
end;

function TParametrosServicoMargemBruta.PrecoDeCusto: Double;
begin
  Result := FPrecoDeCusto;
end;

function TParametrosServicoMargemBruta.PrecoDeCusto(
  AValue: Double): IParametrosServicoMargemBruta;
begin
  Result := Self;
  FPrecoDeCusto := Avalue;
end;

function TParametrosServicoMargemBruta.PrecoDeVenda(
  AValue: Double): IParametrosServicoMargemBruta;
begin
  Result := Self;
  FPrecoDeVenda := Avalue;
end;

function TParametrosServicoMargemBruta.PrecoDeVenda: Double;
begin
  Result := FPrecoDeVenda;
end;

function TParametrosServicoMargemBruta.ValorDaMargem: Double;
begin
  Result := FValorDaMargem;
end;

function TParametrosServicoMargemBruta.ValorDaMargem(
  AValue: Double): IParametrosServicoMargemBruta;
begin
  Result := Self;
  FValorDaMargem := Avalue;
end;

function TParametrosServicoMargemBruta.ValorDifal: Double;
begin
  Result := FValorDifal;
end;

function TParametrosServicoMargemBruta.ValorDifal(
  AValue: Double): IParametrosServicoMargemBruta;
begin
  Result := Self;
  FValorDifal := Avalue;
end;

function TParametrosServicoMargemBruta.ValorFCP: Double;
begin
  Result := FValorFCP;
end;

function TParametrosServicoMargemBruta.ValorFCP(
  AValue: Double): IParametrosServicoMargemBruta;
begin
  Result := Self;
  FValorFCP := Avalue;
end;

function TParametrosServicoMargemBruta.ValorIcmsSt(
  AValue: Double): IParametrosServicoMargemBruta;
begin
  Result := Self;
  FValorIcmsSt := Avalue;
end;

function TParametrosServicoMargemBruta.ValorIcmsSt: Double;
begin
  Result := FValorIcmsSt;
end;

function TResultadoCalculoMargemBruta.ValorMargemBruta: Double;
begin
  Result := FValorMargemBruta;
end;

function TResultadoCalculoMargemBruta.ValorMargemBruta(
  AValue: Double): IResultadoCalculoMargemBruta;
begin
  Result := Self;
  FValorMargemBruta := AValue;
end;

{ TParametrosServicoMargemParaMarkup }

class function TParametrosServicoMargemParaMarkup.New: IParametrosServicoMargemParaMarkup;
begin
  Result := Self.Create;
end;

function TParametrosServicoMargemParaMarkup.ValorDaMargem: Double;
begin
  Result := FValorDaMargem;
end;

function TParametrosServicoMargemParaMarkup.ValorDaMargem(
  AValue: Double): IParametrosServicoMargemParaMarkup;
begin
  Result := Self;
  FValorDaMargem := AValue;
end;

{ TParametrosCalculoMargemParaMarkup }

class function TParametrosCalculoMargemParaMarkup.new: IParametrosCalculoMargemParaMarkup;
begin
  result := Self.Create;
end;

function TParametrosCalculoMargemParaMarkup.ValorDaMargem: Double;
begin
  Result := FValorDaMargem;
end;

function TParametrosCalculoMargemParaMarkup.ValorDaMargem(
  AValue: Double): IParametrosCalculoMargemParaMarkup;
begin
  Result := Self;
  FValorDaMargem := AValue;
end;

{ TResultadoCalculoMargemParaMarkup }

class function TResultadoCalculoMargemParaMarkup.New: IResultadoCalculoMargemParaMarkup;
begin
  Result := Self.Create;
end;

function TResultadoCalculoMargemParaMarkup.ValorMarkup: Double;
begin
  Result := FValorMarkup;
end;

function TResultadoCalculoMargemParaMarkup.ValorMarkup(
  AValue: Double): IResultadoCalculoMargemParaMarkup;
begin
  Result := Self;
  FValorMarkup := AVAlue;
end;

function TResultadoServicosClasseMargemBruta.ParametrosCalculoMargemBruta(
  AValue: IParametrosCalculoMargemBruta): IResultadoServicosClasseMargemBruta;
begin
  Result := Self;
  FParametrosCalculoMargemBruta := AValue;
end;

function TResultadoServicosClasseMargemBruta.ParametrosCalculoMargemBruta: IParametrosCalculoMargemBruta;
begin
  Result := FParametrosCalculoMargemBruta;
end;

function TResultadoServicosClasseMargemBruta.ParametrosCalculoMargemParaMarkup(
  AValue: IParametrosCalculoMargemParaMarkup): IResultadoServicosClasseMargemBruta;
begin
  result := Self;
  FParametrosCalculoMargemParaMarkup := AValue;
end;

function TResultadoServicosClasseMargemBruta.ParametrosCalculoMargemParaMarkup: IParametrosCalculoMargemParaMarkup;
begin
  Result := FParametrosCalculoMargemParaMarkup;
end;

function TResultadoServicosClasseMargemBruta.ResultadoCalculoMargemBruta(
  AValue: IResultadoCalculoMargemBruta): IResultadoServicosClasseMargemBruta;
begin
  result := Self;
  FResultadoCalculoMargemBruta := AValue;
end;

function TResultadoServicosClasseMargemBruta.ResultadoCalculoMargemBruta: IResultadoCalculoMargemBruta;
begin
  Result := FResultadoCalculoMargemBruta;
end;

function TResultadoServicosClasseMargemBruta.ResultadoCalculoMargemParaMarkup(
  AValue: IResultadoCalculoMargemParaMarkup): IResultadoServicosClasseMargemBruta;
begin
  result := Self;
  FResultadoCalculoMargemParaMarkup := AValue;
end;

function TResultadoServicosClasseMargemBruta.ResultadoCalculoMargemParaMarkup: IResultadoCalculoMargemParaMarkup;
begin
  Result := FResultadoCalculoMargemParaMarkup;
end;

end.
