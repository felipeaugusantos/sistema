unit untParametrosResultadoIcmsOrgaoPublico;

interface

Uses
 Shared.Functions.Types;


type
  IParametrosResultadoIcmsOrgaoPublico = interface
    ['{45B30447-1F13-453A-B58D-2FE108ACF9AB}']

    function BaseDeIcmsDeOrgaoPublicoDoItem: Double; overload;
    function BaseDeIcmsDeOrgaoPublicoDoItem(AValue: Double): IParametrosResultadoIcmsOrgaoPublico; overload;

    function ValorDoIcmsDeOrgaoPublicoDoItem: Double; overload;
    function ValorDoIcmsDeOrgaoPublicoDoItem(AValue: Double): IParametrosResultadoIcmsOrgaoPublico; overload;

    function TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao: Double; overload;
    function TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao(AValue: Double): IParametrosResultadoIcmsOrgaoPublico; overload;

    function TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao: Double; overload;
    function TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao(AValue: Double): IParametrosResultadoIcmsOrgaoPublico; overload;
  end;

type
  TParametrosResultadoIcmsOrgaoPublico = class(TInterfacedObject, IParametrosResultadoIcmsOrgaoPublico)
  private
    FBaseDeIcmsDeOrgaoPublicoDoItem: Double;
    FValorDoIcmsDeOrgaoPublicoDoItem: Double;
    FTotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao: Double;
    FTotalDoValorDeIcmsDeOrgaoPublicoConfirmacao: Double;
  public
    function BaseDeIcmsDeOrgaoPublicoDoItem: Double; overload;
    function BaseDeIcmsDeOrgaoPublicoDoItem(AValue: Double): IParametrosResultadoIcmsOrgaoPublico; overload;

    function ValorDoIcmsDeOrgaoPublicoDoItem: Double; overload;
    function ValorDoIcmsDeOrgaoPublicoDoItem(AValue: Double): IParametrosResultadoIcmsOrgaoPublico; overload;

    function TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao: Double; overload;
    function TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao(AValue: Double): IParametrosResultadoIcmsOrgaoPublico; overload;

    function TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao: Double; overload;
    function TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao(AValue: Double): IParametrosResultadoIcmsOrgaoPublico; overload;

    class function New(): IParametrosResultadoIcmsOrgaoPublico;
  end;

implementation

{ TParametrosResultadoIcmsOrgaoPublico }

class function TParametrosResultadoIcmsOrgaoPublico.New: IParametrosResultadoIcmsOrgaoPublico;
begin
  Result := Self.Create;
end;

function TParametrosResultadoIcmsOrgaoPublico.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao(
  AValue: Double): IParametrosResultadoIcmsOrgaoPublico;
begin
  Result := Self;
  FTotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao := AValue;
end;

function TParametrosResultadoIcmsOrgaoPublico.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao: Double;
begin
  Result := FTotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao;
end;

function TParametrosResultadoIcmsOrgaoPublico.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao(
  AValue: Double): IParametrosResultadoIcmsOrgaoPublico;
begin
  Result := Self;
  FTotalDoValorDeIcmsDeOrgaoPublicoConfirmacao := AValue;
end;

function TParametrosResultadoIcmsOrgaoPublico.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao: Double;
begin
  Result := FTotalDoValorDeIcmsDeOrgaoPublicoConfirmacao;
end;

function TParametrosResultadoIcmsOrgaoPublico.BaseDeIcmsDeOrgaoPublicoDoItem: Double;
begin
  Result := FBaseDeIcmsDeOrgaoPublicoDoItem;
end;

function TParametrosResultadoIcmsOrgaoPublico.BaseDeIcmsDeOrgaoPublicoDoItem(
  AValue: Double): IParametrosResultadoIcmsOrgaoPublico;
begin
  Result := Self;
  FBaseDeIcmsDeOrgaoPublicoDoItem := AValue;
end;

function TParametrosResultadoIcmsOrgaoPublico.ValorDoIcmsDeOrgaoPublicoDoItem(
  AValue: Double): IParametrosResultadoIcmsOrgaoPublico;
begin
  Result := Self;
  FValorDoIcmsDeOrgaoPublicoDoItem := AValue;
end;

function TParametrosResultadoIcmsOrgaoPublico.ValorDoIcmsDeOrgaoPublicoDoItem: Double;
begin
  Result := FValorDoIcmsDeOrgaoPublicoDoItem;
end;

end.
