unit Faturamento.Impostos.Tipos.Servicos.Classe.IcmsOrgaoPublico;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Classe.IcmsOrgaoPublico,
  Faturamento.Impostos.Interfaces.Tributacao, Faturamento.Impostos.Interfaces.IcmsOrgaoPublico;

type
  TParametrosClasseIcmsOrgaoPublico = class(TInterfacedObject, IParametrosClasseIcmsOrgaoPublico)
  private
    FParametrosCalculoIcmsOrgaoPublico: IParametrosCalculoIcmsOrgaoPublico;
    FRegrasTributacaoIcmsSt: IResultadoRegrasTributacaoIcmsSt;
  public
    function ParametrosCalculoIcmsOrgaoPublico: IParametrosCalculoIcmsOrgaoPublico; overload;
    function ParametrosCalculoIcmsOrgaoPublico(AValue: IParametrosCalculoIcmsOrgaoPublico): IParametrosClasseIcmsOrgaoPublico; overload;

    function RegrasTributacaoIcmsSt: IResultadoRegrasTributacaoIcmsSt; overload;
    function RegrasTributacaoIcmsSt(AValue: IResultadoRegrasTributacaoIcmsSt): IParametrosClasseIcmsOrgaoPublico; overload;

    class function New(): IParametrosClasseIcmsOrgaoPublico;
  end;

type
  TResultadoClasseIcmsOrgaoPublico = class(TInterfacedObject, IResultadoClasseIcmsOrgaoPublico)
  private
    FResultadoCalculoIcmsOrgaoPublico: IResultadoCalculoIcmsOrgaoPublico;
    FParametrosCalculoIcmsOrgaoPublico: IParametrosCalculoIcmsOrgaoPublico;
  public
    function ResultadoCalculoIcmsOrgaoPublico: IResultadoCalculoIcmsOrgaoPublico; overload;
    function ResultadoCalculoIcmsOrgaoPublico(AValue: IResultadoCalculoIcmsOrgaoPublico): IResultadoClasseIcmsOrgaoPublico; overload;

    function ParametrosCalculoIcmsOrgaoPublico: IParametrosCalculoIcmsOrgaoPublico; overload;
    function ParametrosCalculoIcmsOrgaoPublico(AValue: IParametrosCalculoIcmsOrgaoPublico): IResultadoClasseIcmsOrgaoPublico; overload;

    class function New(): IResultadoClasseIcmsOrgaoPublico;
  end;

implementation

{ TParametrosClasseIcmsOrgaoPublico }

class function TParametrosClasseIcmsOrgaoPublico.New: IParametrosClasseIcmsOrgaoPublico;
begin
  Result := Self.Create;
end;

function TParametrosClasseIcmsOrgaoPublico.ParametrosCalculoIcmsOrgaoPublico: IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := FParametrosCalculoIcmsOrgaoPublico;
end;

function TParametrosClasseIcmsOrgaoPublico.ParametrosCalculoIcmsOrgaoPublico(
  AValue: IParametrosCalculoIcmsOrgaoPublico): IParametrosClasseIcmsOrgaoPublico;
begin
  Result := Self;
  FParametrosCalculoIcmsOrgaoPublico := AValue;
end;

function TParametrosClasseIcmsOrgaoPublico.RegrasTributacaoIcmsSt: IResultadoRegrasTributacaoIcmsSt;
begin
  Result := FRegrasTributacaoIcmsSt;
end;

function TParametrosClasseIcmsOrgaoPublico.RegrasTributacaoIcmsSt(
  AValue: IResultadoRegrasTributacaoIcmsSt): IParametrosClasseIcmsOrgaoPublico;
begin
  Result := Self;
  FRegrasTributacaoIcmsSt := AValue;
end;

{ TResultadoClasseIcmsOrgaoPublico }

class function TResultadoClasseIcmsOrgaoPublico.New: IResultadoClasseIcmsOrgaoPublico;
begin
  Result := Self.Create;
end;

function TResultadoClasseIcmsOrgaoPublico.ParametrosCalculoIcmsOrgaoPublico(
  AValue: IParametrosCalculoIcmsOrgaoPublico): IResultadoClasseIcmsOrgaoPublico;
begin
  Result := Self;
  FParametrosCalculoIcmsOrgaoPublico := AValue;
end;

function TResultadoClasseIcmsOrgaoPublico.ParametrosCalculoIcmsOrgaoPublico: IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := FParametrosCalculoIcmsOrgaoPublico;
end;

function TResultadoClasseIcmsOrgaoPublico.ResultadoCalculoIcmsOrgaoPublico: IResultadoCalculoIcmsOrgaoPublico;
begin
  Result := FResultadoCalculoIcmsOrgaoPublico;
end;

function TResultadoClasseIcmsOrgaoPublico.ResultadoCalculoIcmsOrgaoPublico(
  AValue: IResultadoCalculoIcmsOrgaoPublico): IResultadoClasseIcmsOrgaoPublico;
begin
  Result := Self;
  FResultadoCalculoIcmsOrgaoPublico := AValue;
end;

end.
