unit untParametrosComparacaoIcmsEfetivo;


interface

Uses
 Shared.Functions.Types;

  Type
    IParametrosComparacaoIcmsEfetivo = interface
      ['{7FDDC900-E936-4748-8177-33656D77E91C}']
    function PercentualReducaoBaseCalcEfetivaItem: Double; overload;
    function PercentualReducaoBaseCalcEfetivaItem(AValue : Double): IParametrosComparacaoIcmsEfetivo; overload;

    function ValorBaseCalculoEfetivaItem: Double; overload;
    function ValorBaseCalculoEfetivaItem(AValue : Double): IParametrosComparacaoIcmsEfetivo; overload;

    function ValorIcmsEfetivaItem: Double; overload;
    function ValorIcmsEfetivaItem(AValue : Double): IParametrosComparacaoIcmsEfetivo; overload;

    function AliquotaIcmsEfetivaItem: Double; overload;
    function AliquotaIcmsEfetivaItem(AValue : Double): IParametrosComparacaoIcmsEfetivo; overload;

    function ValorBaseCalculoIcmsStRetidoItem: Double; overload;
    function ValorBaseCalculoIcmsStRetidoItem(AValue : Double): IParametrosComparacaoIcmsEfetivo; overload;

    function ValorIcmsStRetidoItem: Double; overload;
    function ValorIcmsStRetidoItem(AValue : Double): IParametrosComparacaoIcmsEfetivo; overload;	
	
  end;

  Type
    TParametrosComparacaoIcmsEfetivo = Class(TInterfacedObject, IParametrosComparacaoIcmsEfetivo)
    Private
	    FPercentualReducaoBaseCalcEfetivaItem : Double;
	    FValorBaseCalculoEfetivaItem          : Double;
	    FValorIcmsEfetivaItem                 : Double;
      FAliquotaIcmsEfetivaItem              : Double;
	    FValorBaseCalculoIcmsStRetidoItem     : Double;
	    FValorIcmsStRetidoItem                : Double;
    Public
      function PercentualReducaoBaseCalcEfetivaItem: Double; overload;
      function PercentualReducaoBaseCalcEfetivaItem(AValue : Double): IParametrosComparacaoIcmsEfetivo; overload;

      function ValorBaseCalculoEfetivaItem: Double; overload;
      function ValorBaseCalculoEfetivaItem(AValue : Double): IParametrosComparacaoIcmsEfetivo; overload;

      function ValorIcmsEfetivaItem: Double; overload;
      function ValorIcmsEfetivaItem(AValue : Double): IParametrosComparacaoIcmsEfetivo; overload; 

      function AliquotaIcmsEfetivaItem: Double; overload;
      function AliquotaIcmsEfetivaItem(AValue : Double): IParametrosComparacaoIcmsEfetivo; overload;

      function ValorBaseCalculoIcmsStRetidoItem: Double; overload;
      function ValorBaseCalculoIcmsStRetidoItem(AValue : Double): IParametrosComparacaoIcmsEfetivo; overload;

      function ValorIcmsStRetidoItem: Double; overload;
      function ValorIcmsStRetidoItem(AValue : Double): IParametrosComparacaoIcmsEfetivo; overload;	

      Class Function New() : IParametrosComparacaoIcmsEfetivo;
  End;

implementation

{ TParametrosComparacaoIcmsEfetivo }

class function TParametrosComparacaoIcmsEfetivo.New: IParametrosComparacaoIcmsEfetivo;
begin
  Result := Self.Create;
end;

function TParametrosComparacaoIcmsEfetivo.AliquotaIcmsEfetivaItem(
  AValue: Double): IParametrosComparacaoIcmsEfetivo;
begin
  Result := Self;
  FAliquotaIcmsEfetivaItem := AValue;
end;

function TParametrosComparacaoIcmsEfetivo.AliquotaIcmsEfetivaItem: Double;
begin
  Result := FAliquotaIcmsEfetivaItem;
end;

function TParametrosComparacaoIcmsEfetivo.PercentualReducaoBaseCalcEfetivaItem: Double;
begin
  Result := FPercentualReducaoBaseCalcEfetivaItem;
end;

function TParametrosComparacaoIcmsEfetivo.PercentualReducaoBaseCalcEfetivaItem(
  AValue: Double): IParametrosComparacaoIcmsEfetivo;
begin
  Result := Self;
  FPercentualReducaoBaseCalcEfetivaItem := AValue;
end;

function TParametrosComparacaoIcmsEfetivo.ValorBaseCalculoEfetivaItem(
  AValue: Double): IParametrosComparacaoIcmsEfetivo;
begin
  Result := Self;
  FValorBaseCalculoEfetivaItem := AValue;
end;

function TParametrosComparacaoIcmsEfetivo.ValorBaseCalculoEfetivaItem: Double;
begin
  Result := FValorBaseCalculoEfetivaItem;
end;

function TParametrosComparacaoIcmsEfetivo.ValorBaseCalculoIcmsStRetidoItem: Double;
begin
  Result := FValorBaseCalculoIcmsStRetidoItem;
end;

function TParametrosComparacaoIcmsEfetivo.ValorBaseCalculoIcmsStRetidoItem(
  AValue: Double): IParametrosComparacaoIcmsEfetivo;
begin
  Result := Self;
  FValorBaseCalculoIcmsStRetidoItem := AValue;

end;

function TParametrosComparacaoIcmsEfetivo.ValorIcmsEfetivaItem(
  AValue: Double): IParametrosComparacaoIcmsEfetivo;
begin
  Result := Self;
  FValorIcmsEfetivaItem := AValue;
end;

function TParametrosComparacaoIcmsEfetivo.ValorIcmsEfetivaItem: Double;
begin
  Result := FValorIcmsEfetivaItem;
end;

function TParametrosComparacaoIcmsEfetivo.ValorIcmsStRetidoItem(
  AValue: Double): IParametrosComparacaoIcmsEfetivo;
begin
  Result := Self;
  FValorIcmsStRetidoItem := AValue;
end;

function TParametrosComparacaoIcmsEfetivo.ValorIcmsStRetidoItem: Double;
begin
  Result := FValorIcmsStRetidoItem;
end;

end.

