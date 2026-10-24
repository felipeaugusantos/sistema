unit untParametrosComparacaoIpi;


interface

Uses
 Shared.Functions.Types;

  Type
    IParametrosComparacaoIpi = interface
      ['{7FDDC900-E936-4748-8177-33656D77E91C}']
    function ValorCalculadoIPI: Double; overload;
    function ValorCalculadoIPI(AValue: Double): IParametrosComparacaoIpi; overload;

    function BaseDeCalculoIPI: Double; overload;
    function BaseDeCalculoIPI(AValue: Double): IParametrosComparacaoIpi; overload;

    function AliquotaDeCalculoIPI: Double; overload;
    function AliquotaDeCalculoIPI(AValue: Double): IParametrosComparacaoIpi; overload;
  end;

  Type
    TParametrosComparacaoIpi = Class(TInterfacedObject, IParametrosComparacaoIpi)
    Private
      FValorCalculadoIPI : Double;
      FBaseDeCalculoIPI  : Double;
      FAliquotaDeCalculoIPI: Double;
    Public
      function ValorCalculadoIPI: Double; overload;
      function ValorCalculadoIPI(AValue: Double): IParametrosComparacaoIpi ; overload;

      function BaseDeCalculoIPI: Double; overload;
      function BaseDeCalculoIPI(AValue: Double): IParametrosComparacaoIpi; overload;

      function AliquotaDeCalculoIPI: Double; overload;
      function AliquotaDeCalculoIPI(AValue: Double): IParametrosComparacaoIpi; overload;

      Class Function New() : IParametrosComparacaoIpi;
  End;


implementation

{ TParametrosComparacaoFcp }

function TParametrosComparacaoIpi.BaseDeCalculoIPI: Double;
begin
  Result := FBaseDeCalculoIPI;
end;

function TParametrosComparacaoIpi.AliquotaDeCalculoIPI: Double;
begin
  Result := FAliquotaDeCalculoIPI;
end;

function TParametrosComparacaoIpi.AliquotaDeCalculoIPI(
  AValue: Double): IParametrosComparacaoIpi;
begin
  Result := Self;
  FAliquotaDeCalculoIPI := AValue;
end;

function TParametrosComparacaoIpi.BaseDeCalculoIPI(
  AValue: Double): IParametrosComparacaoIpi;
begin
  Result := Self;
  FBaseDeCalculoIPI := AValue;
end;

class function TParametrosComparacaoIpi.New: IParametrosComparacaoIPI;
begin
  Result := Self.Create;
end;

function TParametrosComparacaoIpi.ValorCalculadoIPI: Double;
begin
  Result := FValorCalculadoIPI;
end;

function TParametrosComparacaoIpi.ValorCalculadoIPI(
  AValue: Double): IParametrosComparacaoIpi;
begin
  Result := Self;
  FValorCalculadoIPI := AValue;

end;

end.

