unit untParametrosComparacaoIcms;

interface

type
  IParametrosComparacaoIcms = interface
    ['{4533AC03-7AB3-4418-BB3C-6EFA7A8366FC}']

    function TipoOperacao: String; overload;
    function TipoOperacao(AValue: String): IParametrosComparacaoIcms; overload;

    function AliquotaDoIcms: Double; overload;
    function AliquotaDoIcms(AValue: Double): IParametrosComparacaoIcms; overload;

    function BaseDeCalculoDoIcms: Double; overload;
    function BaseDeCalculoDoIcms(AValue: Double): IParametrosComparacaoIcms; overload;

    function ValorCalculadoDoIcms: Double; overload;
    function ValorCalculadoDoIcms(AValue: Double): IParametrosComparacaoIcms; overload;

    function PercentualDaBaseDeIcms: Double; overload;
    function PercentualDaBaseDeIcms(AValue: Double): IParametrosComparacaoIcms; overload;

    function ValorDaDiferencaDeIcms: Double; overload;
    function ValorDaDiferencaDeIcms(AValue: Double): IParametrosComparacaoIcms; overload;

    function PercentualDeReducaoDaBaseDeIcms: Double; overload;
    function PercentualDeReducaoDaBaseDeIcms(AValue: Double): IParametrosComparacaoIcms; overload;

    function ReducaoRICMPR: String; overload;
    function ReducaoRICMPR(AValue: String): IParametrosComparacaoIcms; overload;
  end;

type
  TParametrosComparacaoIcms = class(TInterfacedObject, IParametrosComparacaoIcms)
  private
    FTipoOperacao: String;
    FAliquotaDoIcms: Double;
    FBaseDeCalculoDoIcms: Double;
    FValorCalculadoDoIcms: Double;
    FPercentualDaBaseDeIcms: Double;
    FValorDaDiferencaDeIcms: Double;
    FPercentualDeReducaoDaBaseDeIcms: Double;
    FReducaoRICMPR: String;
  public
    function TipoOperacao: String; overload;
    function TipoOperacao(AValue: String): IParametrosComparacaoIcms; overload;

    function AliquotaDoIcms: Double; overload;
    function AliquotaDoIcms(AValue: Double): IParametrosComparacaoIcms; overload;

    function BaseDeCalculoDoIcms: Double; overload;
    function BaseDeCalculoDoIcms(AValue: Double): IParametrosComparacaoIcms; overload;

    function ValorCalculadoDoIcms: Double; overload;
    function ValorCalculadoDoIcms(AValue: Double): IParametrosComparacaoIcms; overload;

    function PercentualDaBaseDeIcms: Double; overload;
    function PercentualDaBaseDeIcms(AValue: Double): IParametrosComparacaoIcms; overload;

    function ValorDaDiferencaDeIcms: Double; overload;
    function ValorDaDiferencaDeIcms(AValue: Double): IParametrosComparacaoIcms; overload;

    function PercentualDeReducaoDaBaseDeIcms: Double; overload;
    function PercentualDeReducaoDaBaseDeIcms(AValue: Double): IParametrosComparacaoIcms; overload;

    function ReducaoRICMPR: String; overload;
    function ReducaoRICMPR(AValue: String): IParametrosComparacaoIcms; overload;

    class function New(): IParametrosComparacaoIcms;
  end;


implementation

{ TParametrosComparacaoIcms }

function TParametrosComparacaoIcms.AliquotaDoIcms: Double;
begin
  Result := FAliquotaDoIcms;
end;

function TParametrosComparacaoIcms.AliquotaDoIcms(
  AValue: Double): IParametrosComparacaoIcms;
begin
  Result := Self;
  FAliquotaDoIcms := AValue;
end;

function TParametrosComparacaoIcms.BaseDeCalculoDoIcms: Double;
begin
  Result := FBaseDeCalculoDoIcms;
end;

function TParametrosComparacaoIcms.BaseDeCalculoDoIcms(
  AValue: Double): IParametrosComparacaoIcms;
begin
  Result := Self;
  FBaseDeCalculoDoIcms := AValue;
end;

class function TParametrosComparacaoIcms.New: IParametrosComparacaoIcms;
begin
  Result := Self.Create;
end;

function TParametrosComparacaoIcms.PercentualDaBaseDeIcms(
  AValue: Double): IParametrosComparacaoIcms;
begin
  Result := Self;
  FPercentualDaBaseDeIcms := AValue;
end;

function TParametrosComparacaoIcms.PercentualDeReducaoDaBaseDeIcms: Double;
begin
  Result := FPercentualDeReducaoDaBaseDeIcms;
end;

function TParametrosComparacaoIcms.PercentualDeReducaoDaBaseDeIcms(
  AValue: Double): IParametrosComparacaoIcms;
begin
  Result := Self;
  FPercentualDeReducaoDaBaseDeIcms := AValue;
end;

function TParametrosComparacaoIcms.ReducaoRICMPR: String;
begin
  Result := FReducaoRICMPR;
end;

function TParametrosComparacaoIcms.ReducaoRICMPR(
  AValue: String): IParametrosComparacaoIcms;
begin
  Result := Self;
  FReducaoRICMPR := AValue;
end;

function TParametrosComparacaoIcms.PercentualDaBaseDeIcms: Double;
begin
  Result := FPercentualDaBaseDeIcms;
end;

function TParametrosComparacaoIcms.TipoOperacao: String;
begin
  Result := FTipoOperacao;
end;

function TParametrosComparacaoIcms.TipoOperacao(
  AValue: String): IParametrosComparacaoIcms;
begin
  Result := Self;
  FTipoOperacao := AValue;
end;

function TParametrosComparacaoIcms.ValorCalculadoDoIcms: Double;
begin
  Result := FValorCalculadoDoIcms;
end;

function TParametrosComparacaoIcms.ValorCalculadoDoIcms(
  AValue: Double): IParametrosComparacaoIcms;
begin
  Result := Self;
  FValorCalculadoDoIcms := AValue;
end;

function TParametrosComparacaoIcms.ValorDaDiferencaDeIcms(
  AValue: Double): IParametrosComparacaoIcms;
begin
  Result := Self;
  FValorDaDiferencaDeIcms := AValue;
end;

function TParametrosComparacaoIcms.ValorDaDiferencaDeIcms: Double;
begin
  Result := FValorDaDiferencaDeIcms;
end;

end.
