unit Faturamento.Impostos.Tipos.Servicos.Classe.Icms;

interface

uses Faturamento.Impostos.Interfaces.Icms, Faturamento.Impostos.Interfaces.Servicos.Classe.Icms,
  Faturamento.Impostos.Interfaces.Tributacao;

type
  TParametrosClasseIcms = class(TInterfacedObject, IParametrosClasseIcms)
  private
    FParametrosCalculoIcms: IParametrosCalculoIcms;
    FRegrasTributacaoIcmsSt: IResultadoRegrasTributacaoIcmsSt;
  public
    function ParametrosCalculoIcms: IParametrosCalculoIcms; overload;
    function ParametrosCalculoIcms(AValue: IParametrosCalculoIcms): IParametrosClasseIcms; overload;

    function RegrasTributacaoIcmsSt: IResultadoRegrasTributacaoIcmsSt; overload;
    function RegrasTributacaoIcmsSt(AValue: IResultadoRegrasTributacaoIcmsSt): IParametrosClasseIcms; overload;

    class function New(): IParametrosClasseIcms;
  end;

type
  TResultadoClasseIcms = class(TInterfacedObject, IResultadoClasseIcms)
  private
    FResultadoCalculoIcms: IResultadoCalculoIcms;
    FParametrosCalculoIcms: IParametrosCalculoIcms;
    FCalculouOValorDoIcms: Boolean;
  public
    function ResultadoCalculoIcms: IResultadoCalculoIcms; overload;
    function ResultadoCalculoIcms(AValue: IResultadoCalculoIcms): IResultadoClasseIcms; overload;

    function ParametrosCalculoIcms: IParametrosCalculoIcms; overload;
    function ParametrosCalculoIcms(AValue: IParametrosCalculoIcms): IResultadoClasseIcms; overload;

    function CalculouOValorDoIcms: Boolean; overload;
    function CalculouOValorDoIcms(AValue: Boolean): IResultadoClasseIcms; overload;

    class function New(): IResultadoClasseIcms;
  end;

implementation

{ TParametrosClasseIcms }

class function TParametrosClasseIcms.New: IParametrosClasseIcms;
begin
  Result := Self.Create;
end;

function TParametrosClasseIcms.ParametrosCalculoIcms: IParametrosCalculoIcms;
begin
  Result := FParametrosCalculoIcms;
end;

function TParametrosClasseIcms.ParametrosCalculoIcms(
  AValue: IParametrosCalculoIcms): IParametrosClasseIcms;
begin
  Result := Self;
  FParametrosCalculoIcms := AValue;
end;

function TParametrosClasseIcms.RegrasTributacaoIcmsSt: IResultadoRegrasTributacaoIcmsSt;
begin
  Result := FRegrasTributacaoIcmsSt;
end;

function TParametrosClasseIcms.RegrasTributacaoIcmsSt(
  AValue: IResultadoRegrasTributacaoIcmsSt): IParametrosClasseIcms;
begin
  Result := Self;
  FRegrasTributacaoIcmsSt := AValue;
end;

{ TResultadoClasseIcms }

function TResultadoClasseIcms.CalculouOValorDoIcms: Boolean;
begin
  Result := FCalculouOValorDoIcms;
end;

function TResultadoClasseIcms.CalculouOValorDoIcms(
  AValue: Boolean): IResultadoClasseIcms;
begin
  Result := Self;
  FCalculouOValorDoIcms := AValue;
end;

class function TResultadoClasseIcms.New: IResultadoClasseIcms;
begin
  Result := Self.Create;
end;

function TResultadoClasseIcms.ParametrosCalculoIcms(
  AValue: IParametrosCalculoIcms): IResultadoClasseIcms;
begin
  Result := Self;
  FParametrosCalculoIcms := AValue;
end;

function TResultadoClasseIcms.ParametrosCalculoIcms: IParametrosCalculoIcms;
begin
  Result := FParametrosCalculoIcms;
end;

function TResultadoClasseIcms.ResultadoCalculoIcms: IResultadoCalculoIcms;
begin
  Result := FResultadoCalculoIcms;
end;

function TResultadoClasseIcms.ResultadoCalculoIcms(
  AValue: IResultadoCalculoIcms): IResultadoClasseIcms;
begin
  Result := Self;
  FResultadoCalculoIcms := AValue;
end;

end.
