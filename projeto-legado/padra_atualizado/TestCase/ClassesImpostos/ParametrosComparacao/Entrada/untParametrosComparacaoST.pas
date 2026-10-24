unit untParametrosComparacaoST;


interface

Uses
 Shared.Functions.Types;

Type
  IParametrosComparacaoST = interface
    ['{7FDDC900-E936-4748-8177-33656D77E91C}']

    function BaseDeCalculoDaSubstituicaoTributariaDoItem: Double; overload;
    function BaseDeCalculoDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosComparacaoST; overload;

    function ValorDaSubstituicaoTributariaDoItem: Double; overload;
    function ValorDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosComparacaoST; overload;

    function PercentualDaSubstituicaoDaBase: Double; overload;
    function PercentualDaSubstituicaoDaBase(AValue: Double): IParametrosComparacaoST; overload;

    function PercentualDoFCPDoItem: Double; overload;
    function PercentualDoFCPDoItem(AValue: Double): IParametrosComparacaoST; overload;

    function ValorDoFCPDoItem: Double; overload;
    function ValorDoFCPDoItem(AValue: Double): IParametrosComparacaoST; overload;

    function BaseDaSubstituicaoTributariaSimulada: Double; overload;
    function BaseDaSubstituicaoTributariaSimulada(AValue: Double): IParametrosComparacaoST; overload;

    function ValorDoIvaMatriz: Double; overload;
    function ValorDoIvaMatriz(AValue: Double): IParametrosComparacaoST; overload;
  end;

Type
  TParametrosComparacaoST = Class(TInterfacedObject, IParametrosComparacaoST)
  Private
    FBaseDeCalculoDaSubstituicaoTributariaDoItem: Double;
    FValorDaSubstituicaoTributariaDoItem: Double;
    FPercentualDoFCPDoItem: Double;
    FValorDoFCPDoItem: Double;
    FBaseDaSubstituicaoTributariaSimulada : Double;
    FValorDoIvaMatriz: Double;
    FPercentualDaSubstituicaoDaBase: Double;
  Public
    function BaseDeCalculoDaSubstituicaoTributariaDoItem: Double; overload;
    function BaseDeCalculoDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosComparacaoST; overload;

    function ValorDaSubstituicaoTributariaDoItem: Double; overload;
    function ValorDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosComparacaoST; overload;

    function PercentualDaSubstituicaoDaBase: Double; overload;
    function PercentualDaSubstituicaoDaBase(AValue: Double): IParametrosComparacaoST; overload;

    function PercentualDoFCPDoItem: Double; overload;
    function PercentualDoFCPDoItem(AValue: Double): IParametrosComparacaoST; overload;

    function ValorDoFCPDoItem: Double; overload;
    function ValorDoFCPDoItem(AValue: Double): IParametrosComparacaoST; overload;

    function BaseDaSubstituicaoTributariaSimulada: Double; overload;
    function BaseDaSubstituicaoTributariaSimulada(AValue: Double): IParametrosComparacaoST; overload;

    function ValorDoIvaMatriz: Double; overload;
    function ValorDoIvaMatriz(AValue: Double): IParametrosComparacaoST; overload;

    Class Function New() : IParametrosComparacaoST;
  End;


implementation

{ TParametrosComparacaoST }

function TParametrosComparacaoST.ValorDoFCPDoItem(
  AValue: Double): IParametrosComparacaoST;
begin
  Result := Self;
  FValorDoFCPDoItem := AValue;
end;

function TParametrosComparacaoST.ValorDoIvaMatriz(
  AValue: Double): IParametrosComparacaoST;
begin
  Result := Self;
  FValorDoIvaMatriz := AValue;
end;

function TParametrosComparacaoST.ValorDoIvaMatriz: Double;
begin
  REsult := FValorDoIvaMatriz;
end;

function TParametrosComparacaoST.ValorDoFCPDoItem: Double;
begin
  Result := FValorDoFCPDoItem;
end;

function TParametrosComparacaoST.BaseDaSubstituicaoTributariaSimulada(
  AValue: Double): IParametrosComparacaoST;
begin
  Result := Self;
  FBaseDaSubstituicaoTributariaSimulada := AValue;
end;

function TParametrosComparacaoST.BaseDaSubstituicaoTributariaSimulada: Double;
begin
  Result := FBaseDaSubstituicaoTributariaSimulada;
end;

function TParametrosComparacaoST.BaseDeCalculoDaSubstituicaoTributariaDoItem(
  AValue: Double): IParametrosComparacaoST;
begin
  Result := Self;
  FBaseDeCalculoDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosComparacaoST.BaseDeCalculoDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FBaseDeCalculoDaSubstituicaoTributariaDoItem;
end;

function TParametrosComparacaoST.ValorDaSubstituicaoTributariaDoItem(
  AValue: Double): IParametrosComparacaoST;
begin
  Result := Self;
  FValorDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosComparacaoST.ValorDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FValorDaSubstituicaoTributariaDoItem;
end;

class function TParametrosComparacaoST.New: IParametrosComparacaoST;
begin
  Result := Self.Create;
end;

function TParametrosComparacaoST.PercentualDoFCPDoItem(
  AValue: Double): IParametrosComparacaoST;
begin
  Result := Self;
  FPercentualDoFCPDoItem := AValue;
end;

function TParametrosComparacaoST.PercentualDaSubstituicaoDaBase: Double;
begin
  Result := FPercentualDaSubstituicaoDaBase;
end;

function TParametrosComparacaoST.PercentualDaSubstituicaoDaBase(
  AValue: Double): IParametrosComparacaoST;
begin
  Result := Self;
  FPercentualDaSubstituicaoDaBase := AValue;
end;

function TParametrosComparacaoST.PercentualDoFCPDoItem: Double;
begin
  Result := FPercentualDoFCPDoItem;
end;

end.

