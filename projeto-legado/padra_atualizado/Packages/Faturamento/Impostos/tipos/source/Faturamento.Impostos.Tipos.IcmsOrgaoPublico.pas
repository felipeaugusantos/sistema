unit Faturamento.Impostos.Tipos.IcmsOrgaoPublico;

interface

uses Faturamento.Impostos.Interfaces.IcmsOrgaoPublico;

type
  TParametrosCalculoIcmsOrgaoPublico = class(TInterfacedObject, IParametrosCalculoIcmsOrgaoPublico)
  private
    FDentroDoEstado: Boolean;
    FSubstituicaoTributariaDoItem: Boolean;
    FOpcaoDeDocumento: String;
    FValorTotalDoItem: Double;
    FAliquotaDoPis: Double;
    FAliquotaDoCofins: Double;
    FCodigoDaSituacaoTributaria: String;
    FIsencaoDeIcmsVendasZonaFrancaProdutosNacionais: Boolean;
    FPercentualDaBaseDeCalculoDoItem: Double;
    FValorFreteDespesasAcessoriasItem: Double;
    FDescontoEspecialDoItem: Double;
    FAliquotaDeIcmsDoItem: Double;
    FClienteOrgaoPublico: Boolean;
    FClienteZonaFranca: Boolean;
    FClienteConsumidorFinal: Boolean;
    FAplicarDescontoPisCofinsOrgaoPublico: Boolean;
    FCalcularDescontoIcmsOrgaoPublico: Boolean;
    FValorDoIpiDoItem: Double;
    FEntraIPINaBaseIcms: Boolean;
    FConsideraDescontoNaBaseDeCalculo : Boolean;
    FOrgaoPublicoForaDoEstado: Boolean;
  public
    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico; overload;

    function SubstituicaoTributariaDoItem: Boolean; overload;
    function SubstituicaoTributariaDoItem(AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico; overload;

    function OpcaoDeDocumento: String; overload;
    function OpcaoDeDocumento(AValue: String): IParametrosCalculoIcmsOrgaoPublico; overload;

    function ValorTotalDoItem: Double; overload;
    function ValorTotalDoItem(AValue: Double): IParametrosCalculoIcmsOrgaoPublico; overload;

    function AliquotaDoPis: Double; overload;
    function AliquotaDoPis(AValue: Double): IParametrosCalculoIcmsOrgaoPublico; overload;

    function AliquotaDoCofins: Double; overload;
    function AliquotaDoCofins(AValue: Double): IParametrosCalculoIcmsOrgaoPublico; overload;

    function CodigoDaSituacaoTributaria: String; overload;
    function CodigoDaSituacaoTributaria(AValue: String): IParametrosCalculoIcmsOrgaoPublico; overload;

    function IsencaoDeIcmsVendasZonaFrancaProdutosNacionais: Boolean; overload;
    function IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico; overload;

    function PercentualDaBaseDeCalculoDoItem: Double; overload;
    function PercentualDaBaseDeCalculoDoItem(AValue: Double): IParametrosCalculoIcmsOrgaoPublico; overload;

    function ValorFreteDespesasAcessoriasItem: Double; overload;
    function ValorFreteDespesasAcessoriasItem(AValue: Double): IParametrosCalculoIcmsOrgaoPublico; overload;

    function DescontoEspecialDoItem: Double; overload;
    function DescontoEspecialDoItem(AValue: Double): IParametrosCalculoIcmsOrgaoPublico; overload;

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosCalculoIcmsOrgaoPublico; overload;

    function ClienteOrgaoPublico: Boolean; overload;
    function ClienteOrgaoPublico(AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico; overload;

    function ClienteZonaFranca: Boolean; overload;
    function ClienteZonaFranca(AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico; overload;

    function AplicarDescontoPisCofinsOrgaoPublico: Boolean; overload;
    function AplicarDescontoPisCofinsOrgaoPublico(AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico; overload;

    function CalcularDescontoIcmsOrgaoPublico: Boolean; overload;
    function CalcularDescontoIcmsOrgaoPublico(AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico; overload;

    function ValorDoIpiDoItem: Double; overload;
    function ValorDoIpiDoItem(AValue: Double): IParametrosCalculoIcmsOrgaoPublico; overload;

    function EntraIPINaBaseIcms: Boolean; overload;
    function EntraIPINaBaseIcms(AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico; overload;

    function ConsideraDescontoNaBaseDeCalculo : Boolean; overload;
    function ConsideraDescontoNaBaseDeCalculo(AValue : Boolean) : IParametrosCalculoIcmsOrgaoPublico; overload;

    function OrgaoPublicoForaDoEstado : Boolean; overload;
    function OrgaoPublicoForaDoEstado(AValue : Boolean) : IParametrosCalculoIcmsOrgaoPublico; overload;

    class function New(): IParametrosCalculoIcmsOrgaoPublico;
  end;

type
  TResultadoCalculoIcmsOrgaoPublico = class(TInterfacedObject, IResultadoCalculoIcmsOrgaoPublico)
  private
    FValorDoIcmsDeOrgaoPublicoDoItem: Double;
    FBaseDeIcmsDeOrgaoPublicoDoItem: Double;
    FTotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao: Double;
    FTotalDoValorDeIcmsDeOrgaoPublicoConfirmacao: Double;
    FValorSeparadoDoIcmsDeOrgaoPublicoDoItem: Double;
    FValorSeparadoDoPisDeOrgaoPublicoDoItem: Double;
    FValorSeparadoDoCofinsDeOrgaoPublicoDoItem: Double;
    FAliquotaDoIcmsDeOrgaoPublicoDoItem: Double;
    FAliquotaDoPisDeOrgaoPublicoDoItem: Double;
    FAliquotaDoCofinsDeOrgaoPublicoDoItem: Double;
  public
    function ValorDoIcmsDeOrgaoPublicoDoItem: Double; overload;
    function ValorDoIcmsDeOrgaoPublicoDoItem(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    function BaseDeIcmsDeOrgaoPublicoDoItem: Double; overload;
    function BaseDeIcmsDeOrgaoPublicoDoItem(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    function TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao: Double; overload;
    function TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    function TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao: Double; overload;
    function TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    function ValorSeparadoDoIcmsDeOrgaoPublicoDoItem: Double; overload;
    function ValorSeparadoDoIcmsDeOrgaoPublicoDoItem(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    function ValorSeparadoDoPisDeOrgaoPublicoDoItem: Double; overload;
    function ValorSeparadoDoPisDeOrgaoPublicoDoItem(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    function ValorSeparadoDoCofinsDeOrgaoPublicoDoItem: Double; overload;
    function ValorSeparadoDoCofinsDeOrgaoPublicoDoItem(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    function AliquotaDoIcmsDeOrgaoPublicoDoItem: Double; overload;
    function AliquotaDoIcmsDeOrgaoPublicoDoItem(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    function AliquotaDoPisDeOrgaoPublicoDoItem: Double; overload;
    function AliquotaDoPisDeOrgaoPublicoDoItem(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    function AliquotaDoCofinsDeOrgaoPublicoDoItem: Double; overload;
    function AliquotaDoCofinsDeOrgaoPublicoDoItem(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    class function New(): IResultadoCalculoIcmsOrgaoPublico;
  end;

implementation

{ TParametrosCalculoIcmsOrgaoPublico }

function TParametrosCalculoIcmsOrgaoPublico.AliquotaDeIcmsDoItem: Double;
begin
  Result := FAliquotaDeIcmsDoItem;
end;

function TParametrosCalculoIcmsOrgaoPublico.AliquotaDeIcmsDoItem(
  AValue: Double): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FAliquotaDeIcmsDoItem := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.AliquotaDoCofins(
  AValue: Double): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FAliquotaDoCofins := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.AliquotaDoCofins: Double;
begin
  Result := FAliquotaDoCofins;
end;

function TParametrosCalculoIcmsOrgaoPublico.AliquotaDoPis(
  AValue: Double): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FAliquotaDoPis := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.AplicarDescontoPisCofinsOrgaoPublico: Boolean;
begin
  Result := FAplicarDescontoPisCofinsOrgaoPublico;
end;

function TParametrosCalculoIcmsOrgaoPublico.AplicarDescontoPisCofinsOrgaoPublico(
  AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FAplicarDescontoPisCofinsOrgaoPublico := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.AliquotaDoPis: Double;
begin
  Result := FAliquotaDoPis;
end;

function TParametrosCalculoIcmsOrgaoPublico.CalcularDescontoIcmsOrgaoPublico: Boolean;
begin
  Result := FCalcularDescontoIcmsOrgaoPublico;
end;

function TParametrosCalculoIcmsOrgaoPublico.CalcularDescontoIcmsOrgaoPublico(
  AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FCalcularDescontoIcmsOrgaoPublico := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosCalculoIcmsOrgaoPublico.ClienteConsumidorFinal(
  AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.ClienteOrgaoPublico(
  AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FClienteOrgaoPublico := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.ClienteOrgaoPublico: Boolean;
begin
  Result := FClienteOrgaoPublico;
end;

function TParametrosCalculoIcmsOrgaoPublico.ClienteZonaFranca(
  AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FClienteZonaFranca := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.ClienteZonaFranca: Boolean;
begin
  Result := FClienteZonaFranca;
end;

function TParametrosCalculoIcmsOrgaoPublico.CodigoDaSituacaoTributaria(
  AValue: String): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FCodigoDaSituacaoTributaria := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.ConsideraDescontoNaBaseDeCalculo: Boolean;
begin
  Result := FConsideraDescontoNaBaseDeCalculo;
end;

function TParametrosCalculoIcmsOrgaoPublico.ConsideraDescontoNaBaseDeCalculo(
  AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FConsideraDescontoNaBaseDeCalculo := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.OrgaoPublicoForaDoEstado: Boolean;
begin
  Result := FOrgaoPublicoForaDoEstado;
end;

function TParametrosCalculoIcmsOrgaoPublico.OrgaoPublicoForaDoEstado(
  AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FOrgaoPublicoForaDoEstado := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.CodigoDaSituacaoTributaria: String;
begin
  Result := FCodigoDaSituacaoTributaria;
end;

function TParametrosCalculoIcmsOrgaoPublico.DentroDoEstado: Boolean;
begin
  Result := FDentroDoEstado;
end;

function TParametrosCalculoIcmsOrgaoPublico.DentroDoEstado(
  AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FDentroDoEstado := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.DescontoEspecialDoItem: Double;
begin
  Result := FDescontoEspecialDoItem;
end;

function TParametrosCalculoIcmsOrgaoPublico.DescontoEspecialDoItem(
  AValue: Double): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FDescontoEspecialDoItem := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(
  AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FIsencaoDeIcmsVendasZonaFrancaProdutosNacionais := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.IsencaoDeIcmsVendasZonaFrancaProdutosNacionais: Boolean;
begin
  Result := FIsencaoDeIcmsVendasZonaFrancaProdutosNacionais;
end;

class function TParametrosCalculoIcmsOrgaoPublico.New: IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self.Create;
end;

function TParametrosCalculoIcmsOrgaoPublico.OpcaoDeDocumento: String;
begin
  Result := FOpcaoDeDocumento;
end;

function TParametrosCalculoIcmsOrgaoPublico.OpcaoDeDocumento(
  AValue: String): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FOpcaoDeDocumento := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.PercentualDaBaseDeCalculoDoItem: Double;
begin
  Result := FPercentualDaBaseDeCalculoDoItem;
end;

function TParametrosCalculoIcmsOrgaoPublico.PercentualDaBaseDeCalculoDoItem(
  AValue: Double): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FPercentualDaBaseDeCalculoDoItem := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.SubstituicaoTributariaDoItem: Boolean;
begin
  Result := FSubstituicaoTributariaDoItem;
end;

function TParametrosCalculoIcmsOrgaoPublico.SubstituicaoTributariaDoItem(
  AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.ValorFreteDespesasAcessoriasItem: Double;
begin
  Result := FValorFreteDespesasAcessoriasItem;
end;

function TParametrosCalculoIcmsOrgaoPublico.ValorFreteDespesasAcessoriasItem(
  AValue: Double): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FValorFreteDespesasAcessoriasItem := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.ValorTotalDoItem(
  AValue: Double): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FValorTotalDoItem := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.ValorTotalDoItem: Double;
begin
  Result := FValorTotalDoItem;
end;

function TParametrosCalculoIcmsOrgaoPublico.ValorDoIpiDoItem(
  AValue: Double): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FValorDoIpiDoItem := AValue;
end;

function TParametrosCalculoIcmsOrgaoPublico.ValorDoIpiDoItem: Double;
begin
  Result := FValorDoIpiDoItem;
end;

function TParametrosCalculoIcmsOrgaoPublico.EntraIPINaBaseIcms: Boolean;
begin
  Result := FEntraIPINaBaseIcms;
end;

function TParametrosCalculoIcmsOrgaoPublico.EntraIPINaBaseIcms(
  AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FEntraIPINaBaseIcms := AValue;
end;

{ TResultadoCalculoIcmsOrgaoPublico }

function TResultadoCalculoIcmsOrgaoPublico.BaseDeIcmsDeOrgaoPublicoDoItem(
  AValue: Double): IResultadoCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FBaseDeIcmsDeOrgaoPublicoDoItem := AValue;
end;

function TResultadoCalculoIcmsOrgaoPublico.BaseDeIcmsDeOrgaoPublicoDoItem: Double;
begin
  Result := FBaseDeIcmsDeOrgaoPublicoDoItem;
end;

function TResultadoCalculoIcmsOrgaoPublico.ValorDoIcmsDeOrgaoPublicoDoItem: Double;
begin
  Result := FValorDoIcmsDeOrgaoPublicoDoItem;
end;

function TResultadoCalculoIcmsOrgaoPublico.ValorDoIcmsDeOrgaoPublicoDoItem(
  AValue: Double): IResultadoCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FValorDoIcmsDeOrgaoPublicoDoItem := AValue;
end;

class function TResultadoCalculoIcmsOrgaoPublico.New: IResultadoCalculoIcmsOrgaoPublico;
begin
  Result := Self.Create;
end;

function TResultadoCalculoIcmsOrgaoPublico.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao(
  AValue: Double): IResultadoCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FTotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao := AValue;
end;

function TResultadoCalculoIcmsOrgaoPublico.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao: Double;
begin
  Result := FTotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao;
end;

function TResultadoCalculoIcmsOrgaoPublico.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao(
  AValue: Double): IResultadoCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FTotalDoValorDeIcmsDeOrgaoPublicoConfirmacao := AValue;
end;

function TResultadoCalculoIcmsOrgaoPublico.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao: Double;
begin
  Result := FTotalDoValorDeIcmsDeOrgaoPublicoConfirmacao;
end;

function TResultadoCalculoIcmsOrgaoPublico.ValorSeparadoDoIcmsDeOrgaoPublicoDoItem(
  AValue: Double): IResultadoCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FValorSeparadoDoIcmsDeOrgaoPublicoDoItem := AValue;
end;

function TResultadoCalculoIcmsOrgaoPublico.ValorSeparadoDoIcmsDeOrgaoPublicoDoItem: Double;
begin
  Result := FValorSeparadoDoIcmsDeOrgaoPublicoDoItem;
end;

function TResultadoCalculoIcmsOrgaoPublico.ValorSeparadoDoPisDeOrgaoPublicoDoItem(
  AValue: Double): IResultadoCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FValorSeparadoDoPisDeOrgaoPublicoDoItem := AValue;
end;

function TResultadoCalculoIcmsOrgaoPublico.ValorSeparadoDoPisDeOrgaoPublicoDoItem: Double;
begin
  Result := FValorSeparadoDoPisDeOrgaoPublicoDoItem;
end;

function TResultadoCalculoIcmsOrgaoPublico.ValorSeparadoDoCofinsDeOrgaoPublicoDoItem(
  AValue: Double): IResultadoCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FValorSeparadoDoCofinsDeOrgaoPublicoDoItem := AValue;
end;

function TResultadoCalculoIcmsOrgaoPublico.ValorSeparadoDoCofinsDeOrgaoPublicoDoItem: Double;
begin
  Result := FValorSeparadoDoCofinsDeOrgaoPublicoDoItem;
end;

function TResultadoCalculoIcmsOrgaoPublico.AliquotaDoIcmsDeOrgaoPublicoDoItem(
  AValue: Double): IResultadoCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FAliquotaDoIcmsDeOrgaoPublicoDoItem := AValue;
end;

function TResultadoCalculoIcmsOrgaoPublico.AliquotaDoIcmsDeOrgaoPublicoDoItem: Double;
begin
  Result := FAliquotaDoIcmsDeOrgaoPublicoDoItem;
end;

function TResultadoCalculoIcmsOrgaoPublico.AliquotaDoPisDeOrgaoPublicoDoItem(
  AValue: Double): IResultadoCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FAliquotaDoPisDeOrgaoPublicoDoItem := AValue;
end;

function TResultadoCalculoIcmsOrgaoPublico.AliquotaDoPisDeOrgaoPublicoDoItem: Double;
begin
  Result := FAliquotaDoPisDeOrgaoPublicoDoItem;
end;

function TResultadoCalculoIcmsOrgaoPublico.AliquotaDoCofinsDeOrgaoPublicoDoItem(
  AValue: Double): IResultadoCalculoIcmsOrgaoPublico;
begin
  Result := Self;
  FAliquotaDoCofinsDeOrgaoPublicoDoItem := AValue;
end;

function TResultadoCalculoIcmsOrgaoPublico.AliquotaDoCofinsDeOrgaoPublicoDoItem: Double;
begin
  Result := FAliquotaDoCofinsDeOrgaoPublicoDoItem;
end;

end.
