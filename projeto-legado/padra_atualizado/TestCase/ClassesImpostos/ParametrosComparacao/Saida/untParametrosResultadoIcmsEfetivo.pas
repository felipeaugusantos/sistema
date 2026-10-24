unit untParametrosResultadoIcmsEfetivo;

interface

Uses
 Shared.Functions.Types;

type
  IParametrosResultadoIcmsEfetivo = interface
    ['{45B30447-1F13-453A-B58D-2FE108ACF9AB}']
	
    function PercentualReducaoBaseCalcEfetivaItem: Double; overload;
    function PercentualReducaoBaseCalcEfetivaItem(AValue : Double): IParametrosResultadoIcmsEfetivo; overload;

    function ValorBaseCalculoEfetivaItem: Double; overload;
    function ValorBaseCalculoEfetivaItem(AValue : Double): IParametrosResultadoIcmsEfetivo; overload;

    function ValorIcmsEfetivaItem: Double; overload;
    function ValorIcmsEfetivaItem(AValue : Double): IParametrosResultadoIcmsEfetivo; overload;

    function AliquotaIcmsEfetivaItem: Double; overload;
    function AliquotaIcmsEfetivaItem(AValue : Double): IParametrosResultadoIcmsEfetivo; overload;

    function ValorBaseCalculoIcmsStRetidoItem: Double; overload;
    function ValorBaseCalculoIcmsStRetidoItem(AValue : Double): IParametrosResultadoIcmsEfetivo; overload;

    function ValorIcmsStRetidoItem: Double; overload;
    function ValorIcmsStRetidoItem(AValue : Double): IParametrosResultadoIcmsEfetivo; overload;	
  end;

type
  TParametrosResultadoIcmsEfetivo = class(TInterfacedObject, IParametrosResultadoIcmsEfetivo)
  private
    FPercentualReducaoBaseCalcEfetivaItem : Double;
    FValorBaseCalculoEfetivaItem          : Double;
    FValorIcmsEfetivaItem                 : Double;
    FAliquotaIcmsEfetivaItem              : Double;
    FValorBaseCalculoIcmsStRetidoItem     : Double;
    FValorIcmsStRetidoItem                : Double;
  public
    function PercentualReducaoBaseCalcEfetivaItem: Double; overload;
    function PercentualReducaoBaseCalcEfetivaItem(AValue : Double): IParametrosResultadoIcmsEfetivo; overload;

    function ValorBaseCalculoEfetivaItem: Double; overload;
    function ValorBaseCalculoEfetivaItem(AValue : Double): IParametrosResultadoIcmsEfetivo; overload;

    function ValorIcmsEfetivaItem: Double; overload;
    function ValorIcmsEfetivaItem(AValue : Double): IParametrosResultadoIcmsEfetivo; overload;

    function AliquotaIcmsEfetivaItem: Double; overload;
    function AliquotaIcmsEfetivaItem(AValue : Double): IParametrosResultadoIcmsEfetivo; overload;

    function ValorBaseCalculoIcmsStRetidoItem: Double; overload;
    function ValorBaseCalculoIcmsStRetidoItem(AValue : Double): IParametrosResultadoIcmsEfetivo; overload;

    function ValorIcmsStRetidoItem: Double; overload;
    function ValorIcmsStRetidoItem(AValue : Double): IParametrosResultadoIcmsEfetivo; overload;
	
    class function New(): IParametrosResultadoIcmsEfetivo;
  end;

implementation

{ TParametrosResultadoIcmsEfetivo}

function TParametrosResultadoIcmsEfetivo.AliquotaIcmsEfetivaItem(
  AValue: Double): IParametrosResultadoIcmsEfetivo;
begin
  Result := Self;
  FAliquotaIcmsEfetivaItem := AValue;
end;

function TParametrosResultadoIcmsEfetivo.AliquotaIcmsEfetivaItem: Double;
begin
  Result := FAliquotaIcmsEfetivaItem;
end;

class function TParametrosResultadoIcmsEfetivo.New: IParametrosResultadoIcmsEfetivo;
begin
  Result := Self.Create;
end;

function TParametrosResultadoIcmsEfetivo.PercentualReducaoBaseCalcEfetivaItem: Double;
begin
  Result := FPercentualReducaoBaseCalcEfetivaItem;
end;

function TParametrosResultadoIcmsEfetivo.PercentualReducaoBaseCalcEfetivaItem(
  AValue: Double): IParametrosResultadoIcmsEfetivo;
begin
  Result := Self;
  FPercentualReducaoBaseCalcEfetivaItem := AValue;
end;

function TParametrosResultadoIcmsEfetivo.ValorBaseCalculoEfetivaItem(
  AValue: Double): IParametrosResultadoIcmsEfetivo;
begin
  Result := Self;
  FValorBaseCalculoEfetivaItem := AValue;
end;

function TParametrosResultadoIcmsEfetivo.ValorBaseCalculoEfetivaItem: Double;
begin
  Result := FValorBaseCalculoEfetivaItem;
end;

function TParametrosResultadoIcmsEfetivo.ValorBaseCalculoIcmsStRetidoItem: Double;
begin
  Result := FValorBaseCalculoIcmsStRetidoItem;
end;

function TParametrosResultadoIcmsEfetivo.ValorBaseCalculoIcmsStRetidoItem(
  AValue: Double): IParametrosResultadoIcmsEfetivo;
begin
  Result := Self;
  FValorBaseCalculoIcmsStRetidoItem := AValue;
end;

function TParametrosResultadoIcmsEfetivo.ValorIcmsEfetivaItem(
  AValue: Double): IParametrosResultadoIcmsEfetivo;
begin
  Result := Self;
  FValorIcmsEfetivaItem := AValue;
end;

function TParametrosResultadoIcmsEfetivo.ValorIcmsEfetivaItem: Double;
begin
  Result := FValorIcmsEfetivaItem;
end;

function TParametrosResultadoIcmsEfetivo.ValorIcmsStRetidoItem(
  AValue: Double): IParametrosResultadoIcmsEfetivo;
begin
  Result := Self;
  FValorIcmsStRetidoItem := AValue;
end;

function TParametrosResultadoIcmsEfetivo.ValorIcmsStRetidoItem: Double;
begin
  Result := FValorIcmsStRetidoItem;
end;

end.
