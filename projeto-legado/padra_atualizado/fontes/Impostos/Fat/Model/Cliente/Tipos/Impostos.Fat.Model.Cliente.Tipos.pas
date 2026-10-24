unit Impostos.Fat.Model.Cliente.Tipos;

interface

uses Impostos.Fat.Model.Cliente.Interfaces;

type
  TResultadoImpostosFatModelCliente = class sealed(TInterfacedObject, IResultadoImpostosFatModelCliente)
  private
    FSituacaoDoIpi: String;
    FZonaFranca: Boolean;
    FOrgaoPublico: Boolean;
    FClienteExterior: Boolean;
    FClienteEstado: String;
    FClienteConsumidor: Boolean;
  public
    function SituacaoDoIpi: String; overload;
    function SituacaoDoIpi(AValue: String): IResultadoImpostosFatModelCliente; overload;

    function ZonaFranca: Boolean; overload;
    function ZonaFranca(AValue: Boolean): IResultadoImpostosFatModelCliente; overload;

    function OrgaoPublico: Boolean; overload;
    function OrgaoPublico(AValue: Boolean): IResultadoImpostosFatModelCliente; overload;

    function ClienteExterior: Boolean; overload;
    function ClienteExterior(AValue: Boolean): IResultadoImpostosFatModelCliente; overload;

    function ClienteEstado: String; overload;
    function ClienteEstado(AValue: String): IResultadoImpostosFatModelCliente; overload;

    function ClienteConsumidor: Boolean; overload;
    function ClienteConsumidor(AValue: Boolean): IResultadoImpostosFatModelCliente; overload;

    class function New(): IResultadoImpostosFatModelCliente;
  end;

implementation

{ TResultadoImpostosFatModelCliente }

function TResultadoImpostosFatModelCliente.ClienteEstado: String;
begin
  Result := FClienteEstado;
end;

function TResultadoImpostosFatModelCliente.ClienteConsumidor: Boolean;
begin
  Result := FClienteConsumidor;
end;

function TResultadoImpostosFatModelCliente.ClienteConsumidor(
  AValue: Boolean): IResultadoImpostosFatModelCliente;
begin
  Result := Self;
  FClienteConsumidor := AValue;
end;

function TResultadoImpostosFatModelCliente.ClienteEstado(
  AValue: String): IResultadoImpostosFatModelCliente;
begin
  Result := Self;
  FClienteEstado := AValue;
end;

function TResultadoImpostosFatModelCliente.ClienteExterior(
  AValue: Boolean): IResultadoImpostosFatModelCliente;
begin
  Result := Self;
  FClienteExterior := AValue;
end;

function TResultadoImpostosFatModelCliente.ClienteExterior: Boolean;
begin
  Result := FClienteExterior;
end;

class function TResultadoImpostosFatModelCliente.New: IResultadoImpostosFatModelCliente;
begin
  Result := Self.Create;
end;

function TResultadoImpostosFatModelCliente.OrgaoPublico: Boolean;
begin
  Result := FOrgaoPublico;
end;

function TResultadoImpostosFatModelCliente.OrgaoPublico(
  AValue: Boolean): IResultadoImpostosFatModelCliente;
begin
  Result := Self;
  FOrgaoPublico := AValue;
end;

function TResultadoImpostosFatModelCliente.SituacaoDoIpi(
  AValue: String): IResultadoImpostosFatModelCliente;
begin
  Result := Self;
  FSituacaoDoIpi := AValue;
end;

function TResultadoImpostosFatModelCliente.SituacaoDoIpi: String;
begin
  Result := FSituacaoDoIpi;
end;

function TResultadoImpostosFatModelCliente.ZonaFranca(
  AValue: Boolean): IResultadoImpostosFatModelCliente;
begin
  Result := Self;
  FZonaFranca := AValue;
end;

function TResultadoImpostosFatModelCliente.ZonaFranca: Boolean;
begin
  Result := FZonaFranca;
end;

end.
