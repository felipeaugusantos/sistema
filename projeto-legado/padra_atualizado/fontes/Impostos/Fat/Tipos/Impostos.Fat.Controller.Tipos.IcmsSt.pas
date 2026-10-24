unit Impostos.Fat.Controller.Tipos.IcmsSt;

interface

uses Impostos.Fat.Controller.Interfaces.IcmsSt;

type
  TResultadoImpostosFatControllerIcmsSt = class(TInterfacedObject, IResultadoImpostosFatControllerIcmsSt)
  private
    FBaseDaSubstituicaoTributariaSimulada: Double;
    FAliquotaDaSubstituicaoTributariaSimulada: Double;
    FValorDaSubstituicaoTributariaSimulada: Double;
    FBaseDeIcmsDeOrgaoPublicoDoItem: Double;
    FValorDoIcmsDeOrgaoPublicoDoItem: Double;
    FTotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao: Double;
    FTotalDoValorDeIcmsDeOrgaoPublicoConfirmacao: Double;
    FValorDoDescontoBeneficioREIDI: Double;
    FBaseDaSTCustoAquisicao: Double;
    FValorDaSTCustoAquisicao: Double;
    FFatorPositivo: Double;
    FFatorNegativo: Double;
  public
    function BaseDaSubstituicaoTributariaSimulada: Double; overload;
    function BaseDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function AliquotaDaSubstituicaoTributariaSimulada: Double; overload;
    function AliquotaDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function ValorDaSubstituicaoTributariaSimulada: Double; overload;
    function ValorDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function BaseDeIcmsDeOrgaoPublicoDoItem: Double; overload;
    function BaseDeIcmsDeOrgaoPublicoDoItem(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function ValorDoIcmsDeOrgaoPublicoDoItem: Double; overload;
    function ValorDoIcmsDeOrgaoPublicoDoItem(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao: Double; overload;
    function TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao: Double; overload;
    function TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function ValorDoDescontoBeneficioREIDI: Double; overload;
    function ValorDoDescontoBeneficioREIDI(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function BaseDaSTCustoAquisicao: Double; overload;
    function BaseDaSTCustoAquisicao(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function ValorDaSTCustoAquisicao: Double; overload;
    function ValorDaSTCustoAquisicao(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function FatorPositivo: Double; overload;
    function FatorPositivo(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function FatorNegativo: Double; overload;
    function FatorNegativo(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    class function New(): IResultadoImpostosFatControllerIcmsSt;
  end;

type
  TParametrosCalculoValorIcmsSt = class(TInterfacedObject, IParametrosCalculoValorIcmsSt)
  private
    FCodigoDoCliente: String;
    FCodigoDoProduto: String;
    FCodigoDaEmpresa: String;
    FTotalGeralDoItem: Double;
    FClienteConsumidorFinal: Boolean;
    FClienteIndustria: Boolean;
    FClienteComercializacao: Boolean;
  public
    function CodigoDoCliente: String; overload;
    function CodigoDoCliente(AValue: String): IParametrosCalculoValorIcmsSt; overload;

    function CodigoDoProduto: String; overload;
    function CodigoDoProduto(AValue: String): IParametrosCalculoValorIcmsSt; overload;

    function CodigoDaEmpresa: String; overload;
    function CodigoDaEmpresa(AValue: String): IParametrosCalculoValorIcmsSt; overload;

    function TotalGeralDoItem: Double; overload;
    function TotalGeralDoItem(AValue: Double): IParametrosCalculoValorIcmsSt; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosCalculoValorIcmsSt; overload;

    function ClienteIndustria: Boolean; overload;
    function ClienteIndustria(AValue: Boolean): IParametrosCalculoValorIcmsSt; overload;

    function ClienteComercializacao: Boolean; overload;
    function ClienteComercializacao(AValue: Boolean): IParametrosCalculoValorIcmsSt; overload;

    class function New: IParametrosCalculoValorIcmsSt;
  end;

implementation

{ TResultadoImpostosFatControllerIcmsSt }

function TResultadoImpostosFatControllerIcmsSt.AliquotaDaSubstituicaoTributariaSimulada(
  AValue: Double): IResultadoImpostosFatControllerIcmsSt;
begin
  Result := Self;
  FAliquotaDaSubstituicaoTributariaSimulada := AValue;
end;

function TResultadoImpostosFatControllerIcmsSt.AliquotaDaSubstituicaoTributariaSimulada: Double;
begin
  Result := FAliquotaDaSubstituicaoTributariaSimulada;
end;

function TResultadoImpostosFatControllerIcmsSt.BaseDaSTCustoAquisicao: Double;
begin
  Result := FBaseDaSTCustoAquisicao;
end;

function TResultadoImpostosFatControllerIcmsSt.BaseDaSTCustoAquisicao(
  AValue: Double): IResultadoImpostosFatControllerIcmsSt;
begin
  Result := Self;
  FBaseDaSTCustoAquisicao := AValue;
end;

function TResultadoImpostosFatControllerIcmsSt.BaseDaSubstituicaoTributariaSimulada(
  AValue: Double): IResultadoImpostosFatControllerIcmsSt;
begin
  Result := Self;
  FBaseDaSubstituicaoTributariaSimulada := AValue;
end;

function TResultadoImpostosFatControllerIcmsSt.BaseDeIcmsDeOrgaoPublicoDoItem: Double;
begin
  Result := FBaseDeIcmsDeOrgaoPublicoDoItem;
end;

function TResultadoImpostosFatControllerIcmsSt.BaseDeIcmsDeOrgaoPublicoDoItem(
  AValue: Double): IResultadoImpostosFatControllerIcmsSt;
begin
  Result := Self;
  FBaseDeIcmsDeOrgaoPublicoDoItem := AValue;
end;

function TResultadoImpostosFatControllerIcmsSt.FatorNegativo(
  AValue: Double): IResultadoImpostosFatControllerIcmsSt;
begin
  Result := Self;
  FFatorNegativo := AValue;
end;

function TResultadoImpostosFatControllerIcmsSt.FatorNegativo: Double;
begin
  Result := FFatorNegativo;
end;

function TResultadoImpostosFatControllerIcmsSt.FatorPositivo: Double;
begin
  Result := FFatorPositivo;
end;

function TResultadoImpostosFatControllerIcmsSt.FatorPositivo(
  AValue: Double): IResultadoImpostosFatControllerIcmsSt;
begin
  Result := Self;
  FFatorPositivo := AValue;
end;

function TResultadoImpostosFatControllerIcmsSt.BaseDaSubstituicaoTributariaSimulada: Double;
begin
  Result := FBaseDaSubstituicaoTributariaSimulada;
end;

class function TResultadoImpostosFatControllerIcmsSt.New: IResultadoImpostosFatControllerIcmsSt;
begin
  Result := Self.Create;
end;

function TResultadoImpostosFatControllerIcmsSt.ValorDoDescontoBeneficioREIDI: Double;
begin
  Result := FValorDoDescontoBeneficioREIDI;
end;

function TResultadoImpostosFatControllerIcmsSt.ValorDoDescontoBeneficioREIDI(
  AValue: Double): IResultadoImpostosFatControllerIcmsSt;
begin
  Result := Self;
  FValorDoDescontoBeneficioREIDI := AValue;
end;

function TResultadoImpostosFatControllerIcmsSt.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao(
  AValue: Double): IResultadoImpostosFatControllerIcmsSt;
begin
  Result := Self;
  FTotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao := AValue;
end;

function TResultadoImpostosFatControllerIcmsSt.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao: Double;
begin
  Result := FTotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao;
end;

function TResultadoImpostosFatControllerIcmsSt.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao: Double;
begin
  Result := FTotalDoValorDeIcmsDeOrgaoPublicoConfirmacao;
end;

function TResultadoImpostosFatControllerIcmsSt.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao(
  AValue: Double): IResultadoImpostosFatControllerIcmsSt;
begin
  Result := Self;
  FTotalDoValorDeIcmsDeOrgaoPublicoConfirmacao := AValue;
end;

function TResultadoImpostosFatControllerIcmsSt.ValorDaSubstituicaoTributariaSimulada: Double;
begin
  Result := FValorDaSubstituicaoTributariaSimulada;
end;

function TResultadoImpostosFatControllerIcmsSt.ValorDaSTCustoAquisicao(
  AValue: Double): IResultadoImpostosFatControllerIcmsSt;
begin
  Result := Self;
  FValorDaSTCustoAquisicao := AValue;
end;

function TResultadoImpostosFatControllerIcmsSt.ValorDaSTCustoAquisicao: Double;
begin
  Result := FValorDaSTCustoAquisicao;
end;

function TResultadoImpostosFatControllerIcmsSt.ValorDaSubstituicaoTributariaSimulada(
  AValue: Double): IResultadoImpostosFatControllerIcmsSt;
begin
  Result := Self;
  FValorDaSubstituicaoTributariaSimulada := AValue;
end;

function TResultadoImpostosFatControllerIcmsSt.ValorDoIcmsDeOrgaoPublicoDoItem(
  AValue: Double): IResultadoImpostosFatControllerIcmsSt;
begin
  Result := Self;
  FValorDoIcmsDeOrgaoPublicoDoItem := AValue;
end;

function TResultadoImpostosFatControllerIcmsSt.ValorDoIcmsDeOrgaoPublicoDoItem: Double;
begin
  Result := FValorDoIcmsDeOrgaoPublicoDoItem;
end;

{ TParametrosCalculoValorIcmsSt }

function TParametrosCalculoValorIcmsSt.CodigoDoCliente(
  AValue: String): IParametrosCalculoValorIcmsSt;
begin
  Result := Self;
  FCodigoDoCliente := AValue;
end;

function TParametrosCalculoValorIcmsSt.ClienteComercializacao(
  AValue: Boolean): IParametrosCalculoValorIcmsSt;
begin
  Result := Self;
  FClienteComercializacao := AValue;
end;

function TParametrosCalculoValorIcmsSt.ClienteComercializacao: Boolean;
begin
  Result := FClienteComercializacao;
end;

function TParametrosCalculoValorIcmsSt.ClienteConsumidorFinal(
  AValue: Boolean): IParametrosCalculoValorIcmsSt;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

function TParametrosCalculoValorIcmsSt.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosCalculoValorIcmsSt.ClienteIndustria: Boolean;
begin
  Result := FClienteIndustria;
end;

function TParametrosCalculoValorIcmsSt.ClienteIndustria(
  AValue: Boolean): IParametrosCalculoValorIcmsSt;
begin
  Result := Self;
  FClienteIndustria := AValue;
end;

function TParametrosCalculoValorIcmsSt.CodigoDaEmpresa: String;
begin
  Result := FCodigoDaEmpresa;
end;

function TParametrosCalculoValorIcmsSt.CodigoDaEmpresa(
  AValue: String): IParametrosCalculoValorIcmsSt;
begin
  Result := Self;
  FCodigoDaEmpresa := AValue;
end;

function TParametrosCalculoValorIcmsSt.CodigoDoCliente: String;
begin
  Result := FCodigoDoCliente;
end;

function TParametrosCalculoValorIcmsSt.CodigoDoProduto: String;
begin
  Result := FCodigoDoProduto;
end;

function TParametrosCalculoValorIcmsSt.CodigoDoProduto(
  AValue: String): IParametrosCalculoValorIcmsSt;
begin
  Result := Self;
  FCodigoDoProduto := AValue;
end;

class function TParametrosCalculoValorIcmsSt.New: IParametrosCalculoValorIcmsSt;
begin
  Result := Self.Create;
end;

function TParametrosCalculoValorIcmsSt.TotalGeralDoItem(
  AValue: Double): IParametrosCalculoValorIcmsSt;
begin
  Result := Self;
  FTotalGeralDoItem := AValue;
end;

function TParametrosCalculoValorIcmsSt.TotalGeralDoItem: Double;
begin
  Result := FTotalGeralDoItem;
end;

end.
