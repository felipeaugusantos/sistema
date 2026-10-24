unit Faturamento.Impostos.Tipos.Servicos.Classe.St;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Classe.St,
  Faturamento.Impostos.Interfaces.ST, Faturamento.Impostos.Interfaces.Tributacao;

type
  TParametrosClasseSt = class(TInterfacedObject, IParametrosClasseSt)
  private
    FParametrosCalculoSt: IParametrosCalculoST;
    FRegrasTributacaoIcmsSt: IResultadoRegrasTributacaoIcmsSt;
  public
    function ParametrosCalculoSt: IParametrosCalculoST; overload;
    function ParametrosCalculoSt(AValue: IParametrosCalculoST): IParametrosClasseSt; overload;

    function RegrasTributacaoIcmsSt: IResultadoRegrasTributacaoIcmsSt; overload;
    function RegrasTributacaoIcmsSt(AValue: IResultadoRegrasTributacaoIcmsSt): IParametrosClasseSt; overload;

    class function New(): IParametrosClasseSt;
  end;

type
  TResultadoClasseSt = class(TInterfacedObject, IResultadoClasseSt)
  private
    FResultadoCalculoSt: IResultadoCalculoST;
    FParametrosCalculoSt: IParametrosCalculoST;
    FBaseDeCalculoDaSubstituicaoTributariaParaRegraDaAliquota: Double;
  public
    function ResultadoCalculoSt: IResultadoCalculoST; overload;
    function ResultadoCalculoSt(AValue: IResultadoCalculoST): IResultadoClasseSt; overload;

    function ParametrosCalculoSt: IParametrosCalculoST; overload;
    function ParametrosCalculoSt(AValue: IParametrosCalculoST): IResultadoClasseSt; overload;

    function BaseDeCalculoDaSubstituicaoTributariaParaRegraDaAliquota: Double; overload;
    function BaseDeCalculoDaSubstituicaoTributariaParaRegraDaAliquota(AValue: Double): IResultadoClasseSt; overload;

    class function New(): IResultadoClasseSt;
  end;

implementation

{ TParametrosClasseSt }

class function TParametrosClasseSt.New: IParametrosClasseSt;
begin
  Result := Self.Create;
end;

function TParametrosClasseSt.ParametrosCalculoSt(
  AValue: IParametrosCalculoST): IParametrosClasseSt;
begin
  Result := Self;
  FParametrosCalculoSt := AValue;
end;

function TParametrosClasseSt.ParametrosCalculoSt: IParametrosCalculoST;
begin
  Result := FParametrosCalculoSt;
end;

function TParametrosClasseSt.RegrasTributacaoIcmsSt: IResultadoRegrasTributacaoIcmsSt;
begin
  Result := FRegrasTributacaoIcmsSt;
end;

function TParametrosClasseSt.RegrasTributacaoIcmsSt(
  AValue: IResultadoRegrasTributacaoIcmsSt): IParametrosClasseSt;
begin
  Result := Self;
  FRegrasTributacaoIcmsSt := AValue;
end;

{ TResultadoClasseSt }

function TResultadoClasseSt.BaseDeCalculoDaSubstituicaoTributariaParaRegraDaAliquota: Double;
begin
  Result := FBaseDeCalculoDaSubstituicaoTributariaParaRegraDaAliquota;
end;

function TResultadoClasseSt.BaseDeCalculoDaSubstituicaoTributariaParaRegraDaAliquota(
  AValue: Double): IResultadoClasseSt;
begin
  Result := Self;
  FBaseDeCalculoDaSubstituicaoTributariaParaRegraDaAliquota := AValue;
end;

class function TResultadoClasseSt.New: IResultadoClasseSt;
begin
  Result := Self.Create;
end;

function TResultadoClasseSt.ParametrosCalculoSt(
  AValue: IParametrosCalculoST): IResultadoClasseSt;
begin
  Result := Self;
  FParametrosCalculoSt := AValue;
end;

function TResultadoClasseSt.ParametrosCalculoSt: IParametrosCalculoST;
begin
  Result := FParametrosCalculoSt;
end;

function TResultadoClasseSt.ResultadoCalculoSt: IResultadoCalculoST;
begin
  Result := FResultadoCalculoSt;
end;

function TResultadoClasseSt.ResultadoCalculoSt(
  AValue: IResultadoCalculoST): IResultadoClasseSt;
begin
  Result := Self;
  FResultadoCalculoSt := AValue;
end;

end.
