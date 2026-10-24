unit untParametrosComparacaoIcmsOrgaoPublico;


interface

Uses
 Shared.Functions.Types;

Type
  IParametrosComparacaoIcmsOrgaoPublico = interface
    ['{7FDDC900-E936-4748-8177-33656D77E91C}']

    function BaseDeIcmsDeOrgaoPublicoDoItem: Double; overload;
    function BaseDeIcmsDeOrgaoPublicoDoItem(AValue: Double): IParametrosComparacaoIcmsOrgaoPublico; overload;

    function ValorDoIcmsDeOrgaoPublicoDoItem: Double; overload;
    function ValorDoIcmsDeOrgaoPublicoDoItem(AValue: Double): IParametrosComparacaoIcmsOrgaoPublico; overload;

    function TotalDaBaseDeIcmsDeOrgaoPublico: Double; overload;
    function TotalDaBaseDeIcmsDeOrgaoPublico(AValue: Double): IParametrosComparacaoIcmsOrgaoPublico; overload;

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosComparacaoIcmsOrgaoPublico; overload;

    function BaseDeCalculoDoIcmsDoItem: Double; overload;
    function BaseDeCalculoDoIcmsDoItem(AValue: Double): IParametrosComparacaoIcmsOrgaoPublico; overload;

    function ValorDoIcmsDoItem: Double; overload;
    function ValorDoIcmsDoItem(AValue: Double): IParametrosComparacaoIcmsOrgaoPublico; overload;

    function TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao: Double; overload;
    function TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao(AValue: Double): IParametrosComparacaoIcmsOrgaoPublico; overload;

    function TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao: Double; overload;
    function TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao(AValue: Double): IParametrosComparacaoIcmsOrgaoPublico; overload;
  end;

Type
  TParametrosComparacaoIcmsOrgaoPublico = Class(TInterfacedObject, IParametrosComparacaoIcmsOrgaoPublico)
  Private
    FBaseDeIcmsDeOrgaoPublicoDoItem: Double;
    FValorDoIcmsDeOrgaoPublicoDoItem: Double;
    FTotalDaBaseDeIcmsDeOrgaoPublico: Double;
    FAliquotaDeIcmsDoItem: Double;
    FBaseDeCalculoDoIcmsDoItem: Double;
    FValorDoIcmsDoItem: Double;
    FTotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao: Double;
    FTotalDoValorDeIcmsDeOrgaoPublicoConfirmacao: Double;
  Public
    function BaseDeIcmsDeOrgaoPublicoDoItem: Double; overload;
    function BaseDeIcmsDeOrgaoPublicoDoItem(AValue: Double): IParametrosComparacaoIcmsOrgaoPublico; overload;

    function ValorDoIcmsDeOrgaoPublicoDoItem: Double; overload;
    function ValorDoIcmsDeOrgaoPublicoDoItem(AValue: Double): IParametrosComparacaoIcmsOrgaoPublico; overload;

    function TotalDaBaseDeIcmsDeOrgaoPublico: Double; overload;
    function TotalDaBaseDeIcmsDeOrgaoPublico(AValue: Double): IParametrosComparacaoIcmsOrgaoPublico; overload;

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosComparacaoIcmsOrgaoPublico; overload;

    function BaseDeCalculoDoIcmsDoItem: Double; overload;
    function BaseDeCalculoDoIcmsDoItem(AValue: Double): IParametrosComparacaoIcmsOrgaoPublico; overload;

    function ValorDoIcmsDoItem: Double; overload;
    function ValorDoIcmsDoItem(AValue: Double): IParametrosComparacaoIcmsOrgaoPublico; overload;

    function TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao: Double; overload;
    function TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao(AValue: Double): IParametrosComparacaoIcmsOrgaoPublico; overload;

    function TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao: Double; overload;
    function TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao(AValue: Double): IParametrosComparacaoIcmsOrgaoPublico; overload;

    Class Function New() : IParametrosComparacaoIcmsOrgaoPublico;
  End;


implementation

{ TParametrosComparacaoIcmsOrgaoPublico }

function TParametrosComparacaoIcmsOrgaoPublico.BaseDeCalculoDoIcmsDoItem(
  AValue: Double): IParametrosComparacaoIcmsOrgaoPublico;
begin
  Result := Self;
  FBaseDeCalculoDoIcmsDoItem := AValue;
end;

function TParametrosComparacaoIcmsOrgaoPublico.BaseDeCalculoDoIcmsDoItem: Double;
begin
  Result := FBaseDeCalculoDoIcmsDoItem;
end;

function TParametrosComparacaoIcmsOrgaoPublico.BaseDeIcmsDeOrgaoPublicoDoItem(
  AValue: Double): IParametrosComparacaoIcmsOrgaoPublico;
begin
  Result := Self;
  FBaseDeIcmsDeOrgaoPublicoDoItem := AValue;
end;

function TParametrosComparacaoIcmsOrgaoPublico.BaseDeIcmsDeOrgaoPublicoDoItem: Double;
begin
  Result := FBaseDeIcmsDeOrgaoPublicoDoItem;
end;

function TParametrosComparacaoIcmsOrgaoPublico.ValorDoIcmsDeOrgaoPublicoDoItem(
  AValue: Double): IParametrosComparacaoIcmsOrgaoPublico;
begin
  Result := Self;
  FValorDoIcmsDeOrgaoPublicoDoItem := AValue;
end;

function TParametrosComparacaoIcmsOrgaoPublico.ValorDoIcmsDoItem: Double;
begin
  Result := FValorDoIcmsDoItem;
end;

function TParametrosComparacaoIcmsOrgaoPublico.ValorDoIcmsDoItem(
  AValue: Double): IParametrosComparacaoIcmsOrgaoPublico;
begin
  Result := Self;
  FValorDoIcmsDoItem := AValue;
end;

function TParametrosComparacaoIcmsOrgaoPublico.ValorDoIcmsDeOrgaoPublicoDoItem: Double;
begin
  Result := FValorDoIcmsDeOrgaoPublicoDoItem;
end;

class function TParametrosComparacaoIcmsOrgaoPublico.New: IParametrosComparacaoIcmsOrgaoPublico;
begin
  Result := Self.Create;
end;

function TParametrosComparacaoIcmsOrgaoPublico.TotalDaBaseDeIcmsDeOrgaoPublico: Double;
begin
  Result := FTotalDaBaseDeIcmsDeOrgaoPublico;
end;

function TParametrosComparacaoIcmsOrgaoPublico.TotalDaBaseDeIcmsDeOrgaoPublico(
  AValue: Double): IParametrosComparacaoIcmsOrgaoPublico;
begin
  Result := Self;
  FTotalDaBaseDeIcmsDeOrgaoPublico := AValue;
end;

function TParametrosComparacaoIcmsOrgaoPublico.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao: Double;
begin
  Result := FTotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao;
end;

function TParametrosComparacaoIcmsOrgaoPublico.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao(
  AValue: Double): IParametrosComparacaoIcmsOrgaoPublico;
begin
  Result := Self;
  FTotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao := AValue;
end;

function TParametrosComparacaoIcmsOrgaoPublico.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao: Double;
begin
  Result := FTotalDoValorDeIcmsDeOrgaoPublicoConfirmacao;
end;

function TParametrosComparacaoIcmsOrgaoPublico.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao(
  AValue: Double): IParametrosComparacaoIcmsOrgaoPublico;
begin
  Result := Self;
  FTotalDoValorDeIcmsDeOrgaoPublicoConfirmacao := AValue;
end;

function TParametrosComparacaoIcmsOrgaoPublico.AliquotaDeIcmsDoItem(
  AValue: Double): IParametrosComparacaoIcmsOrgaoPublico;
begin
  Result := Self;
  FAliquotaDeIcmsDoItem := AValue;
end;

function TParametrosComparacaoIcmsOrgaoPublico.AliquotaDeIcmsDoItem: Double;
begin
  Result := FAliquotaDeIcmsDoItem;
end;

end.

