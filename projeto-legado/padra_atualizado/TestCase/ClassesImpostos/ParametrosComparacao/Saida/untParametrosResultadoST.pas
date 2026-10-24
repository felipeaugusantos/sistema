unit untParametrosResultadoST;

interface

Uses
 Shared.Functions.Types;


type
  IParametrosResultadoST = interface
    ['{45B30447-1F13-453A-B58D-2FE108ACF9AB}']

    function BaseDeCalculoDaSubstituicaoTributariaDoItem: Double; overload;
    function BaseDeCalculoDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosResultadoST; overload;

    function ValorDaSubstituicaoTributariaDoItem: Double; overload;
    function ValorDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosResultadoST; overload;

    function PercentualDoFCPDoItem: Double; overload;
    function PercentualDoFCPDoItem(AValue: Double): IParametrosResultadoST; overload;

    function ValorDoFCPDoItem: Double; overload;
    function ValorDoFCPDoItem(AValue: Double): IParametrosResultadoST; overload;
  end;

type
  TParametrosResultadoST = class(TInterfacedObject, IParametrosResultadoST)
  private
    FBaseDeCalculoDaSubstituicaoTributariaDoItem: Double;
    FValorDaSubstituicaoTributariaDoItem: Double;
    FPercentualDoFCPDoItem: Double;
    FValorDoFCPDoItem: Double;
  public
    function BaseDeCalculoDaSubstituicaoTributariaDoItem: Double; overload;
    function BaseDeCalculoDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosResultadoST; overload;

    function ValorDaSubstituicaoTributariaDoItem: Double; overload;
    function ValorDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosResultadoST; overload;

    function PercentualDoFCPDoItem: Double; overload;
    function PercentualDoFCPDoItem(AValue: Double): IParametrosResultadoST; overload;

    function ValorDoFCPDoItem: Double; overload;
    function ValorDoFCPDoItem(AValue: Double): IParametrosResultadoST; overload;    

    class function New(): IParametrosResultadoST;
  end;

implementation

{ TParametrosResultadoST }

class function TParametrosResultadoST.New: IParametrosResultadoST;
begin
  Result := Self.Create;
end;

function TParametrosResultadoST.PercentualDoFCPDoItem(
  AValue: Double): IParametrosResultadoST;
begin
  Result := Self;
  FPercentualDoFCPDoItem := AValue;
end;

function TParametrosResultadoST.PercentualDoFCPDoItem: Double;
begin
  Result := FPercentualDoFCPDoItem;
end;

function TParametrosResultadoST.BaseDeCalculoDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FBaseDeCalculoDaSubstituicaoTributariaDoItem;
end;

function TParametrosResultadoST.ValorDoFCPDoItem: Double;
begin
  Result := FValorDoFCPDoItem;
end;

function TParametrosResultadoST.ValorDoFCPDoItem(
  AValue: Double): IParametrosResultadoST;
begin
  Result := Self;
  FValorDoFCPDoItem := AValue;
end;

function TParametrosResultadoST.BaseDeCalculoDaSubstituicaoTributariaDoItem(
  AValue: Double): IParametrosResultadoST;
begin
  Result := Self;
  FBaseDeCalculoDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosResultadoST.ValorDaSubstituicaoTributariaDoItem(
  AValue: Double): IParametrosResultadoST;
begin
  Result := Self;
  FValorDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosResultadoST.ValorDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FValorDaSubstituicaoTributariaDoItem;
end;

end.
