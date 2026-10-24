unit untConsultaModelClienteFornecedorMemory;

interface

uses Faturamento.Impostos.Interfaces.Model;

type
  TConsultaClienteFornecedorMemory = class(TinterfacedObject, IResultadoFaturamentoImpostosModelClienteFornecedor)
  private
    FCodigo: String;
    FSituacaoDoIpi: String;
    FZonaFranca: Boolean;
    FOrgaoPublico: Boolean;
    FClienteExterior: Boolean;
    FClienteEstado: String;
    FClienteEstadoEntrega: String;
    FClienteAtividade: String;
    FClienteRegraFiscal: String;
    FSomarIpiBaseIcms: Boolean;
    FClienteInscricaoEstadual: String;
    FClienteMicroEmpreendedor: Boolean;
    FValorIVAEspecialClienteMT : Double;
    FValorIVASimClienteMT: Double;
    FCalcularDescontoIcmsOrgaoPublico: Boolean;
    FSujeitoPassivoSTRegimeEspecial: Boolean;
    FReducaoDeBaseDeIcmsTributados: Double;
    FUtilizarDiferimetoST: Boolean;
    FTipoDeDescontoRateioDescEspecial: String;
    FValorIVANacClienteMT: Double;
    FAplicarDescontoPisCofinsOrgaoPublico: Boolean;
    FBeneficioREIDI: Boolean;
    FDeduzirIcmsDoBeneficioREIDI: Boolean;
    FValorAliquotaIRF: Double;
    FValorAliquotaPIS: Double;
    FValorAliquotaCOF: Double;
    FClienteC_G_C_: String;
    FValorAliquotaCSL: Double;
    FRetencaoDeIRPF: String;
    FRetencaoDePisCofins: String;
    FClienteFisJur: String;
    FConsumidorFinal: Boolean;
    FClienteProdutorRural: String;
    FClienteNaoContribuinteDeIcms: String;
    FClienteOrgaoPublicoDifal: Boolean;
    FValorIVAEspecialClienteMTCedem: Double;
    FValorIVASimClienteMTCedem: Double;
    FValorIVANacClienteMTCedem: Double;
    FCodigoDaEmpresaTransferencia: String;
    FAtoDeclaratorioDF: Boolean;
    FClienteZonaFrancaComDescontoEspecial: Boolean;
    FClienteReducaoCargaLiquida: Boolean;
    FFornecedorSimples: Boolean;
    FSuframa: String;
    FClienteIbgeEntrega: String;
  public
    function Codigo: String; overload;
    function Codigo(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function SituacaoDoIpi: String; overload;
    function SituacaoDoIpi(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ZonaFranca: Boolean; overload;
    function ZonaFranca(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function OrgaoPublico: Boolean; overload;
    function OrgaoPublico(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ClienteExterior: Boolean; overload;
    function ClienteExterior(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ClienteEstado: String; overload;
    function ClienteEstado(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ClienteEstadoEntrega: String; overload;
    function ClienteEstadoEntrega(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ClienteAtividade: String;overload;
    function ClienteAtividade(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ClienteRegraFiscal: String;overload;
    function ClienteRegraFiscal(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function SomarIpiBaseIcms: Boolean; overload;
    function SomarIpiBaseIcms(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ClienteInscricaoEstadual: String;overload;
    function ClienteInscricaoEstadual(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ClienteMicroEmpreendedor: Boolean; overload;
    function ClienteMicroEmpreendedor(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ValorIVAEspecialClienteMT : Double; overload;
    function ValorIVAEspecialClienteMT(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ValorIVASimClienteMT: Double; overload;
    function ValorIVASimClienteMT(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function CalcularDescontoIcmsOrgaoPublico: Boolean; overload;
    function CalcularDescontoIcmsOrgaoPublico(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function SujeitoPassivoSTRegimeEspecial: Boolean; overload;
    function SujeitoPassivoSTRegimeEspecial(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ReducaoDeBaseDeIcmsTributados: Double; overload;
    function ReducaoDeBaseDeIcmsTributados(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function UtilizarDiferimetoST: Boolean; overload;
    function UtilizarDiferimetoST(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function TipoDeDescontoRateioDescEspecial: String; overload;
    function TipoDeDescontoRateioDescEspecial(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ValorIVANacClienteMT: Double; overload;
    function ValorIVANacClienteMT(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function AplicarDescontoPisCofinsOrgaoPublico: Boolean; overload;
    function AplicarDescontoPisCofinsOrgaoPublico(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function BeneficioREIDI: Boolean; overload;
    function BeneficioREIDI(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function DeduzirIcmsDoBeneficioREIDI: Boolean; overload;
    function DeduzirIcmsDoBeneficioREIDI(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ValorAliquotaIRF: Double;overload;
    function ValorAliquotaIRF(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ValorAliquotaPIS: Double;overload;
    function ValorAliquotaPIS(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ValorAliquotaCOF: Double;overload;
    function ValorAliquotaCOF(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ClienteC_G_C_: String;overload;
    function ClienteC_G_C_(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ValorAliquotaCSL: Double;overload;
    function ValorAliquotaCSL(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function RetencaoDeIRPF: String;overload;
    function RetencaoDeIRPF(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function RetencaoDePisCofins: String;overload;
    function RetencaoDePisCofins(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ClienteFisJur: String; overload;
    function ClienteFisJur(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ConsumidorFinal: Boolean; overload;
    function ConsumidorFinal(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ClienteProdutorRural: String; overload;
    function ClienteProdutorRural(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ClienteNaoContribuinteDeIcms: String; overload;
    function ClienteNaoContribuinteDeIcms(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ClienteOrgaoPublicoDifal: Boolean; overload;
    function ClienteOrgaoPublicoDifal(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ValorIVAEspecialClienteMTCedem: Double; overload;
    function ValorIVAEspecialClienteMTCedem(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ValorIVASimClienteMTCedem: Double; overload;
    function ValorIVASimClienteMTCedem(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ValorIVANacClienteMTCedem: Double; overload;
    function ValorIVANacClienteMTCedem(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function CodigoDaEmpresaTransferencia: String; overload;
    function CodigoDaEmpresaTransferencia(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function AtoDeclaratorioDF: Boolean; overload;
    function AtoDeclaratorioDF(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ClienteZonaFrancaComDescontoEspecial: Boolean; overload;
    function ClienteZonaFrancaComDescontoEspecial(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ClienteReducaoCargaLiquida: Boolean; overload;
    function ClienteReducaoCargaLiquida(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function FornecedorSimples: Boolean; overload;
    function FornecedorSimples(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function Suframa: String; overload;
    function Suframa(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ClienteIbgeEntrega: String; overload;
    function ClienteIbgeEntrega(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    class function New: IResultadoFaturamentoImpostosModelClienteFornecedor;
  end;

implementation

{ TConsultaClienteMemory }

function TConsultaClienteFornecedorMemory.AplicarDescontoPisCofinsOrgaoPublico(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FAplicarDescontoPisCofinsOrgaoPublico := AValue;
end;

function TConsultaClienteFornecedorMemory.AplicarDescontoPisCofinsOrgaoPublico: Boolean;
begin
  Result := FAplicarDescontoPisCofinsOrgaoPublico;
end;

function TConsultaClienteFornecedorMemory.AtoDeclaratorioDF: Boolean;
begin
  Result := FAtoDeclaratorioDF;
end;

function TConsultaClienteFornecedorMemory.AtoDeclaratorioDF(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FAtoDeclaratorioDF := AValue;
end;

function TConsultaClienteFornecedorMemory.BeneficioREIDI(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FBeneficioREIDI := AValue;
end;

function TConsultaClienteFornecedorMemory.BeneficioREIDI: Boolean;
begin
  Result := FBeneficioREIDI;
end;

function TConsultaClienteFornecedorMemory.CalcularDescontoIcmsOrgaoPublico(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FCalcularDescontoIcmsOrgaoPublico := AValue;
end;

function TConsultaClienteFornecedorMemory.CalcularDescontoIcmsOrgaoPublico: Boolean;
begin
  Result := FCalcularDescontoIcmsOrgaoPublico;
end;

function TConsultaClienteFornecedorMemory.ClienteAtividade: String;
begin
  Result := FClienteAtividade;
end;

function TConsultaClienteFornecedorMemory.ClienteAtividade(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteAtividade := AValue;
end;

function TConsultaClienteFornecedorMemory.ClienteC_G_C_(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteC_G_C_ := AValue;
end;

function TConsultaClienteFornecedorMemory.ClienteC_G_C_: String;
begin
  Result := FClienteC_G_C_;
end;

function TConsultaClienteFornecedorMemory.ClienteEstado(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteEstado := AValue;
end;

function TConsultaClienteFornecedorMemory.ClienteEstado: String;
begin
  Result := FClienteEstado;
end;

function TConsultaClienteFornecedorMemory.ClienteEstadoEntrega: String;
begin
  Result := FClienteEstadoEntrega;
end;

function TConsultaClienteFornecedorMemory.ClienteEstadoEntrega(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteEstadoEntrega := AValue;
end;

function TConsultaClienteFornecedorMemory.ClienteExterior(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteExterior := AValue;
end;

function TConsultaClienteFornecedorMemory.ClienteExterior: Boolean;
begin
  Result := FClienteExterior;
end;

function TConsultaClienteFornecedorMemory.ClienteFisJur(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteFisJur := AValue;
end;

function TConsultaClienteFornecedorMemory.ClienteFisJur: String;
begin
  Result := FClienteFisJur;
end;

function TConsultaClienteFornecedorMemory.ClienteInscricaoEstadual(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteInscricaoEstadual := AValue;
end;

function TConsultaClienteFornecedorMemory.ClienteInscricaoEstadual: String;
begin
  Result := FClienteInscricaoEstadual;
end;

function TConsultaClienteFornecedorMemory.ClienteMicroEmpreendedor: Boolean;
begin
  Result := FClienteMicroEmpreendedor;
end;

function TConsultaClienteFornecedorMemory.ClienteMicroEmpreendedor(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteMicroEmpreendedor := AValue;
end;

function TConsultaClienteFornecedorMemory.ClienteNaoContribuinteDeIcms(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteNaoContribuinteDeIcms := AValue;
end;

function TConsultaClienteFornecedorMemory.ClienteNaoContribuinteDeIcms: String;
begin
  Result := FClienteNaoContribuinteDeIcms;
end;

function TConsultaClienteFornecedorMemory.ClienteOrgaoPublicoDifal: Boolean;
begin
  Result := FClienteOrgaoPublicoDifal;
end;

function TConsultaClienteFornecedorMemory.ClienteOrgaoPublicoDifal(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteOrgaoPublicoDifal := AValue;
end;

function TConsultaClienteFornecedorMemory.ClienteProdutorRural(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteProdutorRural := AValue;
end;

function TConsultaClienteFornecedorMemory.ClienteProdutorRural: String;
begin
  Result := FClienteProdutorRural;
end;

function TConsultaClienteFornecedorMemory.ClienteReducaoCargaLiquida(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteReducaoCargaLiquida := AValue;
end;

function TConsultaClienteFornecedorMemory.ClienteReducaoCargaLiquida: Boolean;
begin
  Result := FClienteReducaoCargaLiquida;
end;

function TConsultaClienteFornecedorMemory.ClienteRegraFiscal(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteRegraFiscal := AValue;
end;

function TConsultaClienteFornecedorMemory.ClienteRegraFiscal: String;
begin
  Result := FClienteRegraFiscal;
end;

function TConsultaClienteFornecedorMemory.ClienteZonaFrancaComDescontoEspecial: Boolean;
begin
  Result := FClienteZonaFrancaComDescontoEspecial;
end;

function TConsultaClienteFornecedorMemory.ClienteZonaFrancaComDescontoEspecial(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteZonaFrancaComDescontoEspecial := AValue;
end;

function TConsultaClienteFornecedorMemory.Codigo: String;
begin
  Result := FCodigo;
end;

function TConsultaClienteFornecedorMemory.Codigo(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FCodigo := AValue;
end;

function TConsultaClienteFornecedorMemory.CodigoDaEmpresaTransferencia: String;
begin
  Result := FCodigoDaEmpresaTransferencia;
end;

function TConsultaClienteFornecedorMemory.CodigoDaEmpresaTransferencia(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FCodigoDaEmpresaTransferencia := AValue;
end;

function TConsultaClienteFornecedorMemory.ConsumidorFinal: Boolean;
begin
  Result := FConsumidorFinal;
end;

function TConsultaClienteFornecedorMemory.ConsumidorFinal(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FConsumidorFinal := AValue;
end;

function TConsultaClienteFornecedorMemory.DeduzirIcmsDoBeneficioREIDI: Boolean;
begin
  Result := FDeduzirIcmsDoBeneficioREIDI;
end;

function TConsultaClienteFornecedorMemory.DeduzirIcmsDoBeneficioREIDI(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FDeduzirIcmsDoBeneficioREIDI := AValue;
end;

function TConsultaClienteFornecedorMemory.FornecedorSimples: Boolean;
begin
  Result := FFornecedorSimples;
end;

function TConsultaClienteFornecedorMemory.FornecedorSimples(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FFornecedorSimples := AValue;
end;

function TConsultaClienteFornecedorMemory.Suframa: String;
begin
  Result := FSuframa;
end;

function TConsultaClienteFornecedorMemory.Suframa(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FSuframa := AValue;
end;

function TConsultaClienteFornecedorMemory.ClienteIbgeEntrega: String;
begin
  Result := FClienteIbgeEntrega;
end;

function TConsultaClienteFornecedorMemory.ClienteIbgeEntrega(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteIbgeEntrega := AValue;
end;

class function TConsultaClienteFornecedorMemory.New: IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self.Create;
end;

function TConsultaClienteFornecedorMemory.OrgaoPublico: Boolean;
begin
  Result := FOrgaoPublico;
end;

function TConsultaClienteFornecedorMemory.OrgaoPublico(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FOrgaoPublico := AValue;
end;

function TConsultaClienteFornecedorMemory.ReducaoDeBaseDeIcmsTributados: Double;
begin
  Result := FReducaoDeBaseDeIcmsTributados;
end;

function TConsultaClienteFornecedorMemory.ReducaoDeBaseDeIcmsTributados(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FReducaoDeBaseDeIcmsTributados := AValue;
end;

function TConsultaClienteFornecedorMemory.RetencaoDeIRPF(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FRetencaoDeIRPF := AValue;
end;

function TConsultaClienteFornecedorMemory.RetencaoDeIRPF: String;
begin
  Result := FRetencaoDeIRPF;
end;

function TConsultaClienteFornecedorMemory.RetencaoDePisCofins(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FRetencaoDePisCofins := AValue;
end;

function TConsultaClienteFornecedorMemory.RetencaoDePisCofins: String;
begin
  Result := FRetencaoDePisCofins;
end;

function TConsultaClienteFornecedorMemory.SituacaoDoIpi: String;
begin
  Result := FSituacaoDoIpi;
end;

function TConsultaClienteFornecedorMemory.SituacaoDoIpi(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FSituacaoDoIpi := AValue;
end;

function TConsultaClienteFornecedorMemory.SomarIpiBaseIcms: Boolean;
begin
  Result := FSomarIpiBaseIcms;
end;

function TConsultaClienteFornecedorMemory.SomarIpiBaseIcms(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FSomarIpiBaseIcms := AValue;
end;

function TConsultaClienteFornecedorMemory.SujeitoPassivoSTRegimeEspecial(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FSujeitoPassivoSTRegimeEspecial := AValue;
end;

function TConsultaClienteFornecedorMemory.SujeitoPassivoSTRegimeEspecial: Boolean;
begin
  Result := FSujeitoPassivoSTRegimeEspecial;
end;

function TConsultaClienteFornecedorMemory.TipoDeDescontoRateioDescEspecial(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FTipoDeDescontoRateioDescEspecial := AValue;
end;

function TConsultaClienteFornecedorMemory.TipoDeDescontoRateioDescEspecial: String;
begin
  Result := FTipoDeDescontoRateioDescEspecial;
end;

function TConsultaClienteFornecedorMemory.UtilizarDiferimetoST: Boolean;
begin
  Result := FUtilizarDiferimetoST;
end;

function TConsultaClienteFornecedorMemory.UtilizarDiferimetoST(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FUtilizarDiferimetoST := AValue;
end;

function TConsultaClienteFornecedorMemory.ValorAliquotaCOF(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorAliquotaCOF := AValue;
end;

function TConsultaClienteFornecedorMemory.ValorAliquotaCOF: Double;
begin
  Result := FValorAliquotaCOF;
end;

function TConsultaClienteFornecedorMemory.ValorAliquotaCSL: Double;
begin
  Result := FValorAliquotaCSL;
end;

function TConsultaClienteFornecedorMemory.ValorAliquotaCSL(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorAliquotaCSL := AValue;
end;

function TConsultaClienteFornecedorMemory.ValorAliquotaIRF: Double;
begin
  Result := FValorAliquotaIRF;
end;

function TConsultaClienteFornecedorMemory.ValorAliquotaIRF(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorAliquotaIRF := AValue;
end;

function TConsultaClienteFornecedorMemory.ValorAliquotaPIS(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorAliquotaPIS := AValue;
end;

function TConsultaClienteFornecedorMemory.ValorAliquotaPIS: Double;
begin
  Result := FValorAliquotaPIS;
end;

function TConsultaClienteFornecedorMemory.ValorIVAEspecialClienteMT: Double;
begin
  Result := FValorIVAEspecialClienteMT;
end;

function TConsultaClienteFornecedorMemory.ValorIVAEspecialClienteMT(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorIVAEspecialClienteMT := AValue;
end;

function TConsultaClienteFornecedorMemory.ValorIVAEspecialClienteMTCedem(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorIVAEspecialClienteMTCedem := AValue;
end;

function TConsultaClienteFornecedorMemory.ValorIVAEspecialClienteMTCedem: Double;
begin
  Result := FValorIVAEspecialClienteMTCedem;
end;

function TConsultaClienteFornecedorMemory.ValorIVANacClienteMT: Double;
begin
  Result := FValorIVANacClienteMT;
end;

function TConsultaClienteFornecedorMemory.ValorIVANacClienteMT(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorIVANacClienteMT := AValue;
end;

function TConsultaClienteFornecedorMemory.ValorIVANacClienteMTCedem: Double;
begin
  Result := FValorIVANacClienteMTCedem;
end;

function TConsultaClienteFornecedorMemory.ValorIVANacClienteMTCedem(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorIVANacClienteMTCedem := AValue;
end;

function TConsultaClienteFornecedorMemory.ValorIVASimClienteMT: Double;
begin
  Result := FValorIVASimClienteMT;
end;

function TConsultaClienteFornecedorMemory.ValorIVASimClienteMT(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorIVASimClienteMT := AValue;
end;

function TConsultaClienteFornecedorMemory.ValorIVASimClienteMTCedem: Double;
begin
  Result := FValorIVASimClienteMTCedem;
end;

function TConsultaClienteFornecedorMemory.ValorIVASimClienteMTCedem(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorIVASimClienteMTCedem := AValue;
end;

function TConsultaClienteFornecedorMemory.ZonaFranca(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FZonaFranca := AValue;
end;

function TConsultaClienteFornecedorMemory.ZonaFranca: Boolean;
begin
  Result := FZonaFranca;
end;

end.
