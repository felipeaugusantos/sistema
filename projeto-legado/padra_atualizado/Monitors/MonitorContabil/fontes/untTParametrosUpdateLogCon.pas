unit untTParametrosUpdateLogCon;

interface

uses untIContabilidade;

type
  TParametrosUpdateLogCon = Class(TInterfacedObject, IParametrosUpdateLogCon)
  private
    FOrigem: string;
    FInconsistencia: string;
    FHistorico: string;
    FDescricaoValor: string;
    FNaturezaOperacao: string;
    FProcessado: integer;
    FStatus: string;
    FIncremento: int64;
    FReenvio: boolean;
  public
    function Origem: string; overload;
    function Inconsistencia: string; overload;
    function Historico: string; overload;
    function DescricaoValor: string; overload;
    function NaturezaOperacao: string; overload;
    function Processado: integer; overload;
    function Status: string; overload;
    function Incremento: int64; overload;
    function Reenvio: boolean; overload;
    function Origem(AValue: string): IParametrosUpdateLogCon; overload;
    function Inconsistencia(AValue: string): IParametrosUpdateLogCon; overload;
    function Historico(AValue: string): IParametrosUpdateLogCon; overload;
    function DescricaoValor(AValue: string): IParametrosUpdateLogCon; overload;
    function NaturezaOperacao(AValue: string): IParametrosUpdateLogCon; overload;
    function Processado(AValue: integer): IParametrosUpdateLogCon; overload;
    function Status(AValue: string): IParametrosUpdateLogCon; overload;
    function Incremento(AValue: int64): IParametrosUpdateLogCon; overload;
    function Reenvio(AValue: boolean): IParametrosUpdateLogCon; overload;
    class function New: IParametrosUpdateLogCon;
  end;

implementation

{ TParametrosUpdateLogCon }

function TParametrosUpdateLogCon.DescricaoValor(
  AValue: string): IParametrosUpdateLogCon;
begin
  Result := Self;
  FDescricaoValor := AValue;
end;

function TParametrosUpdateLogCon.DescricaoValor: string;
begin
  Result := FDescricaoValor;
end;

function TParametrosUpdateLogCon.Historico: string;
begin
  Result := FHistorico;
end;

function TParametrosUpdateLogCon.Historico(
  AValue: string): IParametrosUpdateLogCon;
begin
  Result := Self;
  FHistorico := AValue;
end;

function TParametrosUpdateLogCon.Inconsistencia: string;
begin
  Result := FInconsistencia;
end;

function TParametrosUpdateLogCon.Inconsistencia(
  AValue: string): IParametrosUpdateLogCon;
begin
  Result := Self;
  FInconsistencia := AValue;
end;

function TParametrosUpdateLogCon.Incremento: int64;
begin
  Result := FIncremento;
end;

function TParametrosUpdateLogCon.Incremento(
  AValue: int64): IParametrosUpdateLogCon;
begin
  Result := Self;
  FIncremento := AValue;
end;

function TParametrosUpdateLogCon.NaturezaOperacao(
  AValue: string): IParametrosUpdateLogCon;
begin
  Result := Self;
  FNaturezaOperacao := AValue;
end;

class function TParametrosUpdateLogCon.New: IParametrosUpdateLogCon;
begin
  Result := Self.Create;
end;

function TParametrosUpdateLogCon.NaturezaOperacao: string;
begin
  Result := FNaturezaOperacao;
end;

function TParametrosUpdateLogCon.Origem(
  AValue: string): IParametrosUpdateLogCon;
begin
  Result := Self;
  FOrigem := AValue;
end;

function TParametrosUpdateLogCon.Origem: string;
begin
  Result := FOrigem;
end;

function TParametrosUpdateLogCon.Processado: integer;
begin
  Result := FProcessado;
end;

function TParametrosUpdateLogCon.Processado(
  AValue: integer): IParametrosUpdateLogCon;
begin
  Result := Self;
  FProcessado := AValue;
end;

function TParametrosUpdateLogCon.Reenvio: boolean;
begin
  Result := FReenvio;
end;

function TParametrosUpdateLogCon.Reenvio(
  AValue: boolean): IParametrosUpdateLogCon;
begin
  Result := Self;
  FReenvio := AValue;
end;

function TParametrosUpdateLogCon.Status(
  AValue: string): IParametrosUpdateLogCon;
begin
  Result := Self;
  FStatus := AValue;
end;

function TParametrosUpdateLogCon.Status: string;
begin
  Result := FStatus;
end;

end.
