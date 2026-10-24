unit Impostos.Fat.Controller.Tipos.IcmsEfetivo;

interface

uses
  Impostos.Fat.Controller.Interfaces.IcmsEfetivo;

type
  TParametrosCalculoValorIcmsEfetivo = class(TInterfacedObject, IParametrosCalculoValorIcmsEfetivo)
  private
    FCodigoDaEmpresa        : String;
    FCodigoDoFornecedor     : String;
    FCodigoDoCliente        : String;
    FClienteConsumidorFinal : String;
    FClienteIndustria       : Boolean;
    FClienteComercializacao : Boolean;
    FopcaoDoDocumeto        : String;
  public
    function CodigoDaEmpresa : String; Overload;
    function CodigoDaEmpresa(AValue : String) : IParametrosCalculoValorIcmsEfetivo; Overload;

    function CodigoDoCliente : String; Overload;
    function CodigoDoCliente(AValue : String) : IParametrosCalculoValorIcmsEfetivo; Overload;

    function CodigoDoFornecedor : String; Overload;
    function CodigoDoFornecedor(AValue : String) : IParametrosCalculoValorIcmsEfetivo; Overload;

    function ClienteConsumidorFinal : String; Overload;
    function ClienteConsumidorFinal(AValue : String) : IParametrosCalculoValorIcmsEfetivo; Overload;

    function ClienteIndustria: Boolean; overload;
    function ClienteIndustria(AValue: Boolean): IParametrosCalculoValorIcmsEfetivo; overload;

    function ClienteComercializacao: Boolean; overload;
    function ClienteComercializacao(AValue: Boolean): IParametrosCalculoValorIcmsEfetivo; overload;

    function OpcaoDoDocumeto: String; overload;
    function OpcaoDoDocumeto(AValue: String): IParametrosCalculoValorIcmsEfetivo; overload;

    class function New: IParametrosCalculoValorIcmsEfetivo;
  end;

implementation

{ TCalcularValorIcmsEfetivo }


function TParametrosCalculoValorIcmsEfetivo.ClienteConsumidorFinal: String;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosCalculoValorIcmsEfetivo.ClienteComercializacao: Boolean;
begin
  Result := FClienteComercializacao;
end;

function TParametrosCalculoValorIcmsEfetivo.ClienteComercializacao(
  AValue: Boolean): IParametrosCalculoValorIcmsEfetivo;
begin
  Result := Self;
  FClienteComercializacao := AValue;
end;

function TParametrosCalculoValorIcmsEfetivo.ClienteConsumidorFinal(
  AValue: String): IParametrosCalculoValorIcmsEfetivo;
begin
  Result := Self;
  FClienteConsumidorFinal := Avalue;
end;

function TParametrosCalculoValorIcmsEfetivo.ClienteIndustria: Boolean;
begin
  result := FClienteIndustria;
end;

function TParametrosCalculoValorIcmsEfetivo.ClienteIndustria(
  AValue: Boolean): IParametrosCalculoValorIcmsEfetivo;
begin
  Result := Self;
  FClienteIndustria := AValue;
end;

function TParametrosCalculoValorIcmsEfetivo.CodigoDaEmpresa: String;
begin
  Result := FCodigoDaEmpresa;
end;

function TParametrosCalculoValorIcmsEfetivo.CodigoDaEmpresa(
  AValue: String): IParametrosCalculoValorIcmsEfetivo;
begin
  Result := Self;
  FCodigoDaEmpresa := AValue;
end;

function TParametrosCalculoValorIcmsEfetivo.CodigoDoCliente: String;
begin
  Result := FCodigoDoCliente;
end;

function TParametrosCalculoValorIcmsEfetivo.CodigoDoCliente(
  AValue: String): IParametrosCalculoValorIcmsEfetivo;
begin
  Result := Self;
  FCodigoDoCliente := AValue;
end;

function TParametrosCalculoValorIcmsEfetivo.CodigoDoFornecedor(
  AValue: String): IParametrosCalculoValorIcmsEfetivo;
begin
  Result := Self;
  FCodigoDoFornecedor := AValue;
end;

function TParametrosCalculoValorIcmsEfetivo.CodigoDoFornecedor: String;
begin
  Result := FCodigoDoFornecedor;
end;

class function TParametrosCalculoValorIcmsEfetivo.New: IParametrosCalculoValorIcmsEfetivo;
begin
  Result := Self.Create;
end;

function TParametrosCalculoValorIcmsEfetivo.OpcaoDoDocumeto: String;
begin
  Result := FOpcaoDoDocumeto;
end;

function TParametrosCalculoValorIcmsEfetivo.OpcaoDoDocumeto(
  AValue: String): IParametrosCalculoValorIcmsEfetivo;
begin
  Result := Self;
  FOpcaoDoDocumeto := Avalue;
end;

end.
