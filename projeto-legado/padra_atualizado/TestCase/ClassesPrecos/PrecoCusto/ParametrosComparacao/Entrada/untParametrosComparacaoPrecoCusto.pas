unit untParametrosComparacaoPrecoCusto;

interface

type
  IParametrosComparacaoPrecoCustoRealVenda = interface
    ['{01EDD774-0854-497F-AB43-B4E745EA2E58}']

	  function TotalDoPrecoCustoRealVenda: Double; overload;
	  function TotalDoPrecoCustoRealVenda(AValue: Double): IParametrosComparacaoPrecoCustoRealVenda; overload;
  end;

type
  TParametrosComparacaoPrecoCustoRealVenda = class(TInterfacedObject, IParametrosComparacaoPrecoCustoRealVenda)
  private
    FTotalDoPrecoCustoRealVenda: Double;
  public
	  function TotalDoPrecoCustoRealVenda: Double; overload;
	  function TotalDoPrecoCustoRealVenda(AValue: Double): IParametrosComparacaoPrecoCustoRealVenda; overload;

    class function New(): IParametrosComparacaoPrecoCustoRealVenda;
  end;

type
  IParametrosComparacaoPrecoCustoMargemMarkup = interface
    ['{BDDC25AA-DCD4-4A55-9F49-7D1A86B71E27}']

	  function TotalDoPrecoCusto: Double; overload;
	  function TotalDoPrecoCusto(AValue: Double): IParametrosComparacaoPrecoCustoMargemMarkup; overload;
  end;

type
  TParametrosComparacaoPrecoCustoMargemMarkup = class(TInterfacedObject, IParametrosComparacaoPrecoCustoMargemMarkup)
  private
    FTotalDoPrecoCusto: Double;
  public
	  function TotalDoPrecoCusto: Double; overload;
	  function TotalDoPrecoCusto(AValue: Double): IParametrosComparacaoPrecoCustoMargemMarkup; overload;

    class function New(): IParametrosComparacaoPrecoCustoMargemMarkup;
  end;

implementation

{ TParametrosComparacaoPrecoCusto }

class function TParametrosComparacaoPrecoCustoRealVenda.New: IParametrosComparacaoPrecoCustoRealVenda;
begin
  Result := Self.Create;
end;

function TParametrosComparacaoPrecoCustoRealVenda.TotalDoPrecoCustoRealVenda: Double;
begin
  Result := FTotalDoPrecoCustoRealVenda;
end;

function TParametrosComparacaoPrecoCustoRealVenda.TotalDoPrecoCustoRealVenda(
  AValue: Double): IParametrosComparacaoPrecoCustoRealVenda;
begin
  Result := Self;
  FTotalDoPrecoCustoRealVenda := AValue;
end;

{ TParametrosComparacaoPrecoCustoMargemMarkup }

class function TParametrosComparacaoPrecoCustoMargemMarkup.New: IParametrosComparacaoPrecoCustoMargemMarkup;
begin
  Result := Self.Create;
end;

function TParametrosComparacaoPrecoCustoMargemMarkup.TotalDoPrecoCusto: Double;
begin
  Result := FTotalDoPrecoCusto;
end;

function TParametrosComparacaoPrecoCustoMargemMarkup.TotalDoPrecoCusto(
  AValue: Double): IParametrosComparacaoPrecoCustoMargemMarkup;
begin
  Result := Self;
  FTotalDoPrecoCusto := AValue;
end;

end.
