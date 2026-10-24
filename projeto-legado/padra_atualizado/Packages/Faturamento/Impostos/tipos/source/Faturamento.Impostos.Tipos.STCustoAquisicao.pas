unit Faturamento.Impostos.Tipos.STCustoAquisicao;

interface

uses Faturamento.Impostos.Interfaces.STCustoAquisicao;

type
  TParametrosCalculoSTCustoAquisicao = class(TInterfacedObject, IParametrosCalculoSTCustoAquisicao)
  private
    FVendaDentroDoEstado: Boolean;
    FSubstituicaoTributaria: Boolean;
    FClienteConsumidorFinal: Boolean;
    FPrecoDeCompraComDescontos: Double;
    FModeloCalculoSubstituicaoDeOperacoesProprias: String;
    FPercetualBaseIcmsDoFornecedor: Double;
    FIvaDoFornecedor: Double;
    FPercetualBaseSTDoFornecedor: Double;
    FAliquotaDeSubstituicaoTributaria: Double;
    FAliquotaDeIcms: Double;
    FAliquotaDeOperacoesProprias: Double;
    FIpiDeEntrada: Double;
    FFreteDeEntrada: Double;
    FCalculaSTClienteConsumidorFinalNotaEspiritoSanto: Boolean;
  public
    function VendaDentroDoEstado: Boolean; overload;
    function VendaDentroDoEstado(AValue: Boolean): IParametrosCalculoSTCustoAquisicao; overload;

    function SubstituicaoTributaria: Boolean; overload;
    function SubstituicaoTributaria(AValue: Boolean): IParametrosCalculoSTCustoAquisicao; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosCalculoSTCustoAquisicao; overload;

    function PrecoDeCompraComDescontos: Double; overload;
    function PrecoDeCompraComDescontos(AValue: Double): IParametrosCalculoSTCustoAquisicao; overload;

    function ModeloCalculoSubstituicaoDeOperacoesProprias: String; overload;
    function ModeloCalculoSubstituicaoDeOperacoesProprias(AValue: String): IParametrosCalculoSTCustoAquisicao; overload;

    function PercetualBaseIcmsDoFornecedor: Double; overload;
    function PercetualBaseIcmsDoFornecedor(AValue: Double): IParametrosCalculoSTCustoAquisicao; overload;

    function IvaDoFornecedor: Double; overload;
    function IvaDoFornecedor(AValue: Double): IParametrosCalculoSTCustoAquisicao; overload;

    function PercetualBaseSTDoFornecedor: Double; overload;
    function PercetualBaseSTDoFornecedor(AValue: Double): IParametrosCalculoSTCustoAquisicao; overload;

    function AliquotaDeSubstituicaoTributaria: Double; overload;
    function AliquotaDeSubstituicaoTributaria(AValue: Double): IParametrosCalculoSTCustoAquisicao; overload;

    function AliquotaDeIcms: Double; overload;
    function AliquotaDeIcms(AValue: Double): IParametrosCalculoSTCustoAquisicao; overload;

    function AliquotaDeOperacoesProprias: Double; overload;
    function AliquotaDeOperacoesProprias(AValue: Double): IParametrosCalculoSTCustoAquisicao; overload;

    function IpiDeEntrada: Double; overload;
    function IpiDeEntrada(AValue: Double): IParametrosCalculoSTCustoAquisicao; overload;

    function FreteDeEntrada: Double; overload;
    function FreteDeEntrada(AValue: Double): IParametrosCalculoSTCustoAquisicao; overload;

    function CalculaSTClienteConsumidorFinalNotaEspiritoSanto: Boolean; overload;
    function CalculaSTClienteConsumidorFinalNotaEspiritoSanto(AValue: Boolean): IParametrosCalculoSTCustoAquisicao; overload;

    class function New: IParametrosCalculoSTCustoAquisicao;
  end;

type
  TResultadoCalculoSTCustoAquisicao = class(TInterfacedObject, IResultadoCalculoSTCustoAquisicao)
  private
    FValorDoIcmsOperacoesProprias: Double;
    FValorDaSTCustoAquisicao: Double;
    FBaseDaSTCustoAquisicao: Double;
    FFatorPositivo: Double;
    FFatorNegativo: Double;
  public
    function BaseDaSTCustoAquisicao: Double; overload;
    function BaseDaSTCustoAquisicao(AValue: Double): IResultadoCalculoSTCustoAquisicao; overload;

    function ValorDaSTCustoAquisicao: Double; overload;
    function ValorDaSTCustoAquisicao(AValue: Double): IResultadoCalculoSTCustoAquisicao; overload;

    function ValorDoIcmsOperacoesProprias: Double; overload;
    function ValorDoIcmsOperacoesProprias(AValue: Double): IResultadoCalculoSTCustoAquisicao; overload;

    function FatorPositivo: Double; overload;
    function FatorPositivo(AValue: Double): IResultadoCalculoSTCustoAquisicao; overload;

    function FatorNegativo: Double; overload;
    function FatorNegativo(AValue: Double): IResultadoCalculoSTCustoAquisicao; overload;

    class function New: IResultadoCalculoSTCustoAquisicao;
  end;

implementation

{ TParametrosCalculoSTCustoAquisicao }

function TParametrosCalculoSTCustoAquisicao.AliquotaDeIcms(
  AValue: Double): IParametrosCalculoSTCustoAquisicao;
begin
  Result := Self;
  FAliquotaDeIcms := AValue;
end;

function TParametrosCalculoSTCustoAquisicao.AliquotaDeOperacoesProprias: Double;
begin
  Result := FAliquotaDeOperacoesProprias;
end;

function TParametrosCalculoSTCustoAquisicao.AliquotaDeOperacoesProprias(
  AValue: Double): IParametrosCalculoSTCustoAquisicao;
begin
  Result := Self;
  FAliquotaDeOperacoesProprias := AValue;
end;

function TParametrosCalculoSTCustoAquisicao.AliquotaDeIcms: Double;
begin
  Result := FAliquotaDeIcms;
end;

function TParametrosCalculoSTCustoAquisicao.AliquotaDeSubstituicaoTributaria(
  AValue: Double): IParametrosCalculoSTCustoAquisicao;
begin
  Result := Self;
  FAliquotaDeSubstituicaoTributaria := AValue;
end;

function TParametrosCalculoSTCustoAquisicao.CalculaSTClienteConsumidorFinalNotaEspiritoSanto: Boolean;
begin
  Result := FCalculaSTClienteConsumidorFinalNotaEspiritoSanto;
end;

function TParametrosCalculoSTCustoAquisicao.CalculaSTClienteConsumidorFinalNotaEspiritoSanto(
  AValue: Boolean): IParametrosCalculoSTCustoAquisicao;
begin
  Result := Self;
  FCalculaSTClienteConsumidorFinalNotaEspiritoSanto := AValue;
end;

function TParametrosCalculoSTCustoAquisicao.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosCalculoSTCustoAquisicao.ClienteConsumidorFinal(
  AValue: Boolean): IParametrosCalculoSTCustoAquisicao;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

function TParametrosCalculoSTCustoAquisicao.FreteDeEntrada: Double;
begin
  Result := FFreteDeEntrada;
end;

function TParametrosCalculoSTCustoAquisicao.FreteDeEntrada(
  AValue: Double): IParametrosCalculoSTCustoAquisicao;
begin
  Result := Self;
  FFreteDeEntrada := AValue;
end;

function TParametrosCalculoSTCustoAquisicao.IvaDoFornecedor: Double;
begin
  Result := FIvaDoFornecedor;
end;

function TParametrosCalculoSTCustoAquisicao.IpiDeEntrada: Double;
begin
  Result := FIpiDeEntrada;
end;

function TParametrosCalculoSTCustoAquisicao.IpiDeEntrada(
  AValue: Double): IParametrosCalculoSTCustoAquisicao;
begin
  Result := Self;
  FIpiDeEntrada := AValue;
end;

function TParametrosCalculoSTCustoAquisicao.IvaDoFornecedor(
  AValue: Double): IParametrosCalculoSTCustoAquisicao;
begin
  Result := Self;
  FIvaDoFornecedor := AValue;
end;

function TParametrosCalculoSTCustoAquisicao.AliquotaDeSubstituicaoTributaria: Double;
begin
  Result := FAliquotaDeSubstituicaoTributaria;
end;

function TParametrosCalculoSTCustoAquisicao.ModeloCalculoSubstituicaoDeOperacoesProprias: String;
begin
  Result := FModeloCalculoSubstituicaoDeOperacoesProprias;
end;

function TParametrosCalculoSTCustoAquisicao.ModeloCalculoSubstituicaoDeOperacoesProprias(
  AValue: String): IParametrosCalculoSTCustoAquisicao;
begin
  Result := Self;
  FModeloCalculoSubstituicaoDeOperacoesProprias := AValue;
end;

class function TParametrosCalculoSTCustoAquisicao.New: IParametrosCalculoSTCustoAquisicao;
begin
  Result := Self.Create;
end;

function TParametrosCalculoSTCustoAquisicao.PrecoDeCompraComDescontos: Double;
begin
  Result := FPrecoDeCompraComDescontos;
end;

function TParametrosCalculoSTCustoAquisicao.PercetualBaseIcmsDoFornecedor: Double;
begin
  Result := FPercetualBaseIcmsDoFornecedor;
end;

function TParametrosCalculoSTCustoAquisicao.PercetualBaseIcmsDoFornecedor(
  AValue: Double): IParametrosCalculoSTCustoAquisicao;
begin
  Result := Self;
  FPercetualBaseIcmsDoFornecedor := AValue;
end;

function TParametrosCalculoSTCustoAquisicao.PercetualBaseSTDoFornecedor: Double;
begin
  Result := FPercetualBaseSTDoFornecedor;
end;

function TParametrosCalculoSTCustoAquisicao.PercetualBaseSTDoFornecedor(
  AValue: Double): IParametrosCalculoSTCustoAquisicao;
begin
  Result := Self;
  FPercetualBaseSTDoFornecedor := AValue;
end;

function TParametrosCalculoSTCustoAquisicao.PrecoDeCompraComDescontos(
  AValue: Double): IParametrosCalculoSTCustoAquisicao;
begin
  Result := Self;
  FPrecoDeCompraComDescontos := AValue;
end;

function TParametrosCalculoSTCustoAquisicao.SubstituicaoTributaria: Boolean;
begin
  Result := FSubstituicaoTributaria;
end;

function TParametrosCalculoSTCustoAquisicao.SubstituicaoTributaria(
  AValue: Boolean): IParametrosCalculoSTCustoAquisicao;
begin
  Result := Self;
  FSubstituicaoTributaria := AValue;
end;

function TParametrosCalculoSTCustoAquisicao.VendaDentroDoEstado: Boolean;
begin
  Result := FVendaDentroDoEstado;
end;

function TParametrosCalculoSTCustoAquisicao.VendaDentroDoEstado(
  AValue: Boolean): IParametrosCalculoSTCustoAquisicao;
begin
  Result := Self;
  FVendaDentroDoEstado := AValue;
end;

{ TResultadoCalculoSTCustoAquisicao }

function TResultadoCalculoSTCustoAquisicao.BaseDaSTCustoAquisicao: Double;
begin
  Result := FBaseDaSTCustoAquisicao;
end;

function TResultadoCalculoSTCustoAquisicao.BaseDaSTCustoAquisicao(
  AValue: Double): IResultadoCalculoSTCustoAquisicao;
begin
  Result := Self;
  FBaseDaSTCustoAquisicao := AValue;
end;

function TResultadoCalculoSTCustoAquisicao.FatorNegativo(
  AValue: Double): IResultadoCalculoSTCustoAquisicao;
begin
  Result := Self;
  FFatorNegativo := AValue;
end;

function TResultadoCalculoSTCustoAquisicao.FatorNegativo: Double;
begin
  Result := FFatorNegativo;
end;

function TResultadoCalculoSTCustoAquisicao.FatorPositivo(
  AValue: Double): IResultadoCalculoSTCustoAquisicao;
begin
  Result := Self;
  FFatorPositivo := AValue;
end;

function TResultadoCalculoSTCustoAquisicao.FatorPositivo: Double;
begin
  Result := FFatorPositivo;
end;

class function TResultadoCalculoSTCustoAquisicao.New: IResultadoCalculoSTCustoAquisicao;
begin
  Result := Self.Create;
end;

function TResultadoCalculoSTCustoAquisicao.ValorDaSTCustoAquisicao(
  AValue: Double): IResultadoCalculoSTCustoAquisicao;
begin
  Result := Self;
  FValorDaSTCustoAquisicao := AValue;
end;

function TResultadoCalculoSTCustoAquisicao.ValorDaSTCustoAquisicao: Double;
begin
  Result := FValorDaSTCustoAquisicao;
end;

function TResultadoCalculoSTCustoAquisicao.ValorDoIcmsOperacoesProprias(
  AValue: Double): IResultadoCalculoSTCustoAquisicao;
begin
  Result := Self;
  FValorDoIcmsOperacoesProprias := AValue;
end;

function TResultadoCalculoSTCustoAquisicao.ValorDoIcmsOperacoesProprias: Double;
begin
  Result := FValorDoIcmsOperacoesProprias;
end;

end.
