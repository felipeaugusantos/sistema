unit untParametrosResultadoIcms;

interface

type
  IParametrosResultadoIcms = interface
    ['{45B30447-1F13-453A-B58D-2FE108ACF9AB}']

    function AliquotaDoIcms: Double; overload;
    function AliquotaDoIcms(AValue: Double): IParametrosResultadoIcms; overload;

    function BaseDeCalculoDoIcms: Double; overload;
    function BaseDeCalculoDoIcms(AValue: Double): IParametrosResultadoIcms; overload;

    function ValorCalculadoDoIcms: Double; overload;
    function ValorCalculadoDoIcms(AValue: Double): IParametrosResultadoIcms; overload;

    function PercentualDaBaseDeIcms: Double; overload;
    function PercentualDaBaseDeIcms(AValue: Double): IParametrosResultadoIcms; overload;

    function ValorDaDiferencaDeIcms: Double; overload;
    function ValorDaDiferencaDeIcms(AValue: Double): IParametrosResultadoIcms; overload;
  end;

type
  TParametrosResultadoIcms = class(TInterfacedObject, IParametrosResultadoIcms)
  private
    FAliquotaDoIcms: Double;
    FBaseDeCalculoDoIcms: Double;
    FValorCalculadoDoIcms: Double;
    FPercentualDaBaseDeIcms: Double;
    FValorDaDiferencaDeIcms: Double;
  public
    function AliquotaDoIcms: Double; overload;
    function AliquotaDoIcms(AValue: Double): IParametrosResultadoIcms; overload;

    function BaseDeCalculoDoIcms: Double; overload;
    function BaseDeCalculoDoIcms(AValue: Double): IParametrosResultadoIcms; overload;

    function ValorCalculadoDoIcms: Double; overload;
    function ValorCalculadoDoIcms(AValue: Double): IParametrosResultadoIcms; overload;

    function PercentualDaBaseDeIcms: Double; overload;
    function PercentualDaBaseDeIcms(AValue: Double): IParametrosResultadoIcms; overload;

    function ValorDaDiferencaDeIcms: Double; overload;
    function ValorDaDiferencaDeIcms(AValue: Double): IParametrosResultadoIcms; overload;

    class function New(): IParametrosResultadoIcms;
  end;

implementation

{ TParametrosResultadoIcms }

function TParametrosResultadoIcms.AliquotaDoIcms: Double;
begin
  Result := FAliquotaDoIcms;
end;

function TParametrosResultadoIcms.AliquotaDoIcms(
  AValue: Double): IParametrosResultadoIcms;
begin
  Result := Self;
  FAliquotaDoIcms := AValue;
end;

function TParametrosResultadoIcms.BaseDeCalculoDoIcms: Double;
begin
  Result := FBaseDeCalculoDoIcms;
end;

function TParametrosResultadoIcms.BaseDeCalculoDoIcms(
  AValue: Double): IParametrosResultadoIcms;
begin
  Result := Self;
  FBaseDeCalculoDoIcms := AValue;
end;

class function TParametrosResultadoIcms.New: IParametrosResultadoIcms;
begin
  Result := Self.Create;
end;

function TParametrosResultadoIcms.PercentualDaBaseDeIcms(
  AValue: Double): IParametrosResultadoIcms;
begin
  Result := Self;
  FPercentualDaBaseDeIcms := AValue;
end;

function TParametrosResultadoIcms.PercentualDaBaseDeIcms: Double;
begin
  Result := FPercentualDaBaseDeIcms;
end;

function TParametrosResultadoIcms.ValorCalculadoDoIcms: Double;
begin
  Result := FValorCalculadoDoIcms;
end;

function TParametrosResultadoIcms.ValorCalculadoDoIcms(
  AValue: Double): IParametrosResultadoIcms;
begin
  Result := Self;
  FValorCalculadoDoIcms := AValue;
end;

function TParametrosResultadoIcms.ValorDaDiferencaDeIcms(
  AValue: Double): IParametrosResultadoIcms;
begin
  Result := Self;
  FValorDaDiferencaDeIcms := AValue;
end;

function TParametrosResultadoIcms.ValorDaDiferencaDeIcms: Double;
begin
  Result := FValorDaDiferencaDeIcms;
end;

end.
