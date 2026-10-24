unit Faturamento.Impostos.Regras.Tributacao;

interface

uses System.StrUtils, System.SysUtils, Faturamento.Impostos.Interfaces.Tributacao,
  Faturamento.Impostos.Tipos.Tributacao, Shared.Functions.Faturamento.Impostos.Regras,
  Shared.Functions.Funcoes.Faturamento, Shared.Functions.Core,
  Shared.Functions.Configuracoes,
  Faturamento.Impostos.Interfaces.DadosFiscais.Aliquota,
  Faturamento.Impostos.Tipos.DadosFiscais.Aliquota, Shared.Functions.Constantes,
  Faturamento.Impostos.Regras.DadosFiscais.Aliquota,
  Shared.Functions.Types, Faturamento.Impostos.Interfaces.Iva,
  Faturamento.Impostos.Tipos.Iva, Faturamento.Impostos.Regras.Tributacao.Iva.St,
  Faturamento.Impostos.Regras.Tributacao.Iva.Icms, Faturamento.Impostos.Interfaces.ST_Simulada,
  Faturamento.Impostos.Tipos.ST_Simulada, Faturamento.Impostos.Regras.Tributacao.ST_Simulada;

type
  TFaturamentoImpostosRegrasTributacao = class(TInterfacedObject, IFaturamentoImpostosRegrasTributacao)
  private
    FParametros: IParametrosRegrasTributacao;
    FCodigoDaSubstituicaoTributariaDoItem: String;
    FAliquotaDeIcmsDoItem: Double;
    FPercentualDaBaseDeIcmsDoItem: Double;
    FAliquotaDaSubstituicaoTributariaDoItem: Double;
    FPercentualDaBaseDaSubstituicaoTributariaDoItem: Double;
    FReducaoRICMPR: String;
    FAliquotaDeIcmsDoItemAnterior: Double;
    FBaseDeCalculoIcmsDoItemAnterior: Double;
    FValorIcmsDoItemAnterior: Double;
    FResultadoCalculoIvaIcms: IResultadoCalculoIva;
    FResultadoCalculoIvaSt: IResultadoCalculoIva;
    FResultadoCalculoST_Simulado: IResultadoRegrasSTSimulada;
    FValorIcmsEstado: Double;
    FBaseDaSubstituicaoTributariaSimulada: Double;
    FAliquotaDaSubstituicaoTributariaSimulada: Double;
    FValorDaSubstituicaoTributariaSimulada: Double;
    FAliquotaDeIcmsEfetivoDoItem : Double;
    FAliquotaDiferenciadaRICMPR : Double;
    FAtendeRegrasAtoDeclaratorioDF: Boolean;
    FAliquotaReduzidaDaSt: Double;
    FSTAtribuidaPorRegimeEspecial: Boolean;

    procedure VendaDentroDoEstado;
    procedure VendaForaDoEstado;

    function RetornarAliquotaDeIcmsInicial: Double;
    function RetornarCodigoDaSubstituicaoTributariaInicial: String;
    function RetornarPercentualDaBaseDeIcmsInicial: Double;
    function RetornarAliquotaDaSubstituicaoTributariaInicial: Double;
    function RetornarPercentualDaBaseDaSubstituicaoTributariaInicial: Double;
    function RetornarAliquotaReduzidaDaSt: Double;
    function RetornaAliquotaDeIcmsEfetivoDoItem: Double;

    function ItemPossuiReducaoBaseConfRICMPR: Boolean;
    function CupomFiscalPercentualDaBaseDeIcmsMaiorQueZeroNaoUtilizaNFCe: Boolean;
    function CalcularUsaSatAliqEcf: Boolean;
    function UtilizarSatOuAliquotaEcf: Boolean;
    function TemAliquotaDeEcf: Boolean;
    function ClientePossuiReducaoBaseIcmsParaProdutosTributados: Boolean;
    function EmpresaDistribuidoraVendaIndustrializacaoDiferimentoST: Boolean;
    function CupomFiscalPossuiAliquotaEcf: Boolean;
    function DadosFiscaisAliquota: Double;
    function EmpresaOptanteSimples: Boolean;
    function TributarNaAliquotaInternaDoEstado: Boolean;
    function EmissaoDeCupomFiscalSimplesNacionalNaoTributado: Boolean;
    function STAtribuidaPorRegimeEspecial: Boolean;
    function STAtribuidaPorAtoDeclaratorioDF: Boolean;

//    function RetornarValorIVAEspecialClienteMT(const AParametros: IParametrosRegrasTributacao; const AliquotaDoIcmsDoItem : Double): Double;

    function ValorIcmsDoItemAnterior: Double;
    function OrgaoPublicoTipoDeDescontoRateioDescEspecial: Boolean;
    function PercentualDeReducaoDaBaseDeCalculoDoIcms: Double;
    function ParametrosCalculoIva: IParametrosCalculoIva;
    function ParametroCalculoST_Simulado: IParametrosRegrasSTSimulada;
    function UsaPercentualReducaoPersonalizado: Boolean;
    function UsaAliquotaDeIcmsDoSimplesNacional: Boolean;
    function EhFaturamentoPelaEmpresaComRegimeEspecialComReducaoDeBase: Boolean;

    procedure PrepararSubstituicaoTributariaSimulada;
    procedure ValorCalculadoIcmsAnterior;
    procedure ValorCalculadoIva;
    procedure ValorCalculadoST_Simulado;
    procedure AtribuirDadosCupomFiscalAliquotaEcfVendaForaDoEstado;
    procedure AtribuirDadosClientePossuiReducaoBaseIcmsParaProdutosTributadosVendaForaDoEstado;
    procedure AtribuirDadosEmpresaDistribuidoraVendaIndustrializacaoDiferimentoSTVendaForaDoEstado;
    procedure AtribuirDadosEmissaoDeCupomFiscalSimplesNacionalNaoTributadoVendaForaDoEstado;
    procedure AtribuirDadosEmpresaOptanteSimplesVendaForaDoEstado;
    procedure AtribuirDadosTributarNaAliquotaInternaDoEstadoVendaForaDoEstado;
    procedure AtribuirDadosSTAtribuidaPorRegimeEspecialVendaForaDoEstado;
    procedure AtribuirDadosItemPossuiReducaoBaseConfRICMPRVendaDentroDoEstado;
    procedure AtribuirDadosClientePossuiReducaoBaseIcmsParaProdutosTributadosVendaDentroDoEstado;
    procedure AtribuirDadosCupomFiscalPercentualDaBaseDeIcmsMaiorQueZeroNaoUtilizaNFCeVendaDentroDoEstado;
    procedure AtribuirDadosEmpresaDistribuidoraVendaIndustrializacaoDiferimentoSTVendaDentroDoEstado;
    procedure AtribuirDadosEmpresaOptanteSimplesVendaDentroDoEstado;
    procedure AtribuirDadosEmissaoDeCupomFiscalSimplesNacionalNaoTributadoVendaDentroDoEstado;
    procedure AtribuirDadosSTAtribuidaPorRegimeEspecialVendaDentroDoEstado;
    procedure AtribuirDadosSTAtribuidaPorAtoDeclaratorioDFVendaDentroDoEstado;
  public
    function IniciarAliquotasEPercentuais: IFaturamentoImpostosRegrasTributacao;
    function DentroOuForaDoEstado: IFaturamentoImpostosRegrasTributacao;
    function ResultadoTributacao: IResultadoRegrasTributacao;

    function AliquotaDeIcmsEfetivoDoItem : Double;

    constructor Create(AParametros: IParametrosRegrasTributacao); overload;

    class function New(AParametros: IParametrosRegrasTributacao): IFaturamentoImpostosRegrasTributacao;
  end;

implementation

{ TFaturamentoImpostosRegrasTributacao }

function TFaturamentoImpostosRegrasTributacao.CalcularUsaSatAliqEcf: Boolean;
begin
  Result := False;

  If Not FParametros.CalcularSatEcf Then
    Exit;

  If Not UtilizarSatOuAliquotaEcf Then
    Exit;

  Result := True;
end;

function TFaturamentoImpostosRegrasTributacao.ClientePossuiReducaoBaseIcmsParaProdutosTributados: Boolean;
begin
  Result :=
    TFunctionsRegrasImpostosFaturamento
      .ClientePossuiReducaoBaseIcmsParaProdutosTributados(FParametros.ModelClienteFornecedor.ReducaoDeBaseDeIcmsTributados, FCodigoDaSubstituicaoTributariaDoItem);
end;

constructor TFaturamentoImpostosRegrasTributacao.Create(
  AParametros: IParametrosRegrasTributacao);
begin
  FParametros := AParametros;
  FSTAtribuidaPorRegimeEspecial := False;
end;

function TFaturamentoImpostosRegrasTributacao.CupomFiscalPercentualDaBaseDeIcmsMaiorQueZeroNaoUtilizaNFCe: Boolean;
begin
  Result :=
    TFunctionsRegrasImpostosFaturamento
      .CupomFiscalPercentualDaBaseDeIcmsMaiorQueZeroNaoUtilizaNFCe(FParametros.EspecieDoDocumento, FPercentualDaBaseDeIcmsDoItem);
end;

function TFaturamentoImpostosRegrasTributacao.CupomFiscalPossuiAliquotaEcf: Boolean;
begin
  Result :=
    TFunctionsRegrasImpostosFaturamento
      .CupomFiscalPossuiAliquotaEcf(FParametros.EspecieDoDocumento, TemAliquotaDeEcf);
end;

function TFaturamentoImpostosRegrasTributacao.DadosFiscaisAliquota: Double;
var
  LParametros: IParametrosDadosFiscaisAliquota;
begin
  LParametros :=
    TParametrosDadosFiscaisAliquota.New
      .ClienteEstado(FParametros.ModelClienteFornecedor.ClienteEstado)
      .InscricaoEstadual(FParametros.ModelClienteFornecedor.ClienteInscricaoEstadual)
      .MicroEmpreendedor(FParametros.ModelClienteFornecedor.ClienteMicroEmpreendedor)
      .EmpresaEstado(FParametros.ModelEmpresa.EmpresaEstado)
      .DocumentoDeVenda(True)
      .DentroDoEstadoCFOP(FParametros.DentroDoEstadoCFOP)
      .AtividadeConstrutora(FParametros.AtividadeConstrutora)
      .EspecieDocumento(FParametros.EspecieDoDocumento);

  Result := TRegraImpostosDadosFiscaisAliquota.New.DadosFiscaisAliquotaDoItem(LParametros).AliquotaIcm;
end;


function TFaturamentoImpostosRegrasTributacao.DentroOuForaDoEstado: IFaturamentoImpostosRegrasTributacao;
begin
  Result := Self;

  If FParametros.DentroDoEstado Then
  Begin
    VendaDentroDoEstado;
    Exit;
  End;

  VendaForaDoEstado;
end;

function TFaturamentoImpostosRegrasTributacao.EmissaoDeCupomFiscalSimplesNacionalNaoTributado: Boolean;
begin
  Result :=
    TFunctionsRegrasImpostosFaturamento
      .EmissaoDeCupomFiscalSimplesNacionalNaoTributado(FParametros.EspecieDoDocumento, EmpresaOptanteSimples, FCodigoDaSubstituicaoTributariaDoItem);
end;

function TFaturamentoImpostosRegrasTributacao.EmpresaDistribuidoraVendaIndustrializacaoDiferimentoST: Boolean;
begin
  Result :=
    TFunctionsRegrasImpostosFaturamento                                                                             
      .EmpresaDistribuidoraVendaIndustrializacaoDiferimentoST(FParametros.ModelClienteFornecedor.UtilizarDiferimetoST,Not FParametros.ClienteComercializacao);

end;

function TFaturamentoImpostosRegrasTributacao.EmpresaOptanteSimples: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento
      .EmpresaOptanteSimples(objConfiguracoes.fGetValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL));
end;

function TFaturamentoImpostosRegrasTributacao.IniciarAliquotasEPercentuais: IFaturamentoImpostosRegrasTributacao;
begin
  Result := Self;

  FBaseDaSubstituicaoTributariaSimulada := 0;
  FAliquotaDaSubstituicaoTributariaSimulada := 0;
  FValorDaSubstituicaoTributariaSimulada := 0;
  FAliquotaDeIcmsEfetivoDoItem := 0;
  FAtendeRegrasAtoDeclaratorioDF := False;

  FCodigoDaSubstituicaoTributariaDoItem := RetornarCodigoDaSubstituicaoTributariaInicial;
  FAliquotaDeIcmsDoItem := RetornarAliquotaDeIcmsInicial;
  FPercentualDaBaseDeIcmsDoItem := RetornarPercentualDaBaseDeIcmsInicial;
  FAliquotaDaSubstituicaoTributariaDoItem := RetornarAliquotaDaSubstituicaoTributariaInicial;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := RetornarPercentualDaBaseDaSubstituicaoTributariaInicial;
  FAliquotaReduzidaDaSt := RetornarAliquotaReduzidaDaSt;

  FReducaoRICMPR := 'N';
end;

function TFaturamentoImpostosRegrasTributacao.ItemPossuiReducaoBaseConfRICMPR: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.fItemPossuiReducaoBaseConfRICMPR(FParametros.DentroDoEstado,
                                                                 FParametros.ModelClienteFornecedor.ConsumidorFinal,
                                                                 FParametros.ModelClienteFornecedor.ClienteInscricaoEstadual,
                                                                 FParametros.ModelClienteFornecedor.ClienteMicroEmpreendedor,
                                                                 FCodigoDaSubstituicaoTributariaDoItem,
                                                                 FParametros.UtilizaDecretoReducaoRICMSdaAbreviacao,
                                                                 FParametros.TipoDaAbreviacaoFiscal); // precisa rever a regra desse parâmetro conforme revisão: 203525
end;

class function TFaturamentoImpostosRegrasTributacao.New(AParametros: IParametrosRegrasTributacao): IFaturamentoImpostosRegrasTributacao;
begin
  Result := Self.Create(AParametros);
end;

function TFaturamentoImpostosRegrasTributacao.OrgaoPublicoTipoDeDescontoRateioDescEspecial: Boolean;
begin
  Result := False;

  If Not FParametros.DentroDoEstado Then
    Exit;

  If Not FParametros.ModelClienteFornecedor.OrgaoPublico Then //(strCliOrg = 'S')
    Exit;

  If FParametros.ModelClienteFornecedor.TipoDeDescontoRateioDescEspecial <> 'R' Then //(strOrPuRD = 'R')
    Exit;

  Result := True;
end;

function TFaturamentoImpostosRegrasTributacao.ParametroCalculoST_Simulado: IParametrosRegrasSTSimulada;
begin
  Result :=
    TParametrosRegrasSTSimulada.New
      .ModelClienteFornecedor(FParametros.ModelClienteFornecedor)
      .ModelProduto(FParametros.ModelProduto)
      .ModelEmpresa(FParametros.ModelEmpresa)
      .TotalGeralDoItem(FParametros.TotalGeralDoItemST_Simulado)
      .ClienteConsumidorFinal(FParametros.ModelClienteFornecedor.ConsumidorFinal)
      .CodigoDaSubstituicaoTributaria(FCodigoDaSubstituicaoTributariaDoItem)
      .TipoDaAbreviacaoFiscal(FParametros.TipoDaAbreviacaoFiscal)
      .ValorDoIva(FResultadoCalculoIvaSt.ValorDoIva)
      .AliquotaDaSubstituicaoTributariaDoItem(FAliquotaDaSubstituicaoTributariaDoItem)
      .PercentualDaBaseDaSubstituicaoTributariaDoItem(FPercentualDaBaseDaSubstituicaoTributariaDoItem)
      .EspecieDoDocumento(FParametros.EspecieDoDocumento)
      .DentroDoEstado(FParametros.DentroDoEstado)
      .DentroDoEstadoCFOP(FParametros.DentroDoEstadoCFOP)
      .AtividadeConstrutora(FParametros.AtividadeConstrutora);
end;

function TFaturamentoImpostosRegrasTributacao.ParametrosCalculoIva: IParametrosCalculoIva;
begin
  Result :=
    TParametrosCalculoIva.New()
      .PercentualDoIvaAbreviacao(FParametros.ModelAbreviacaoIcms.PercentualDeIva)
      .ModelClienteFornecedor(FParametros.ModelClienteFornecedor)
      .ModelProduto(FParametros.ModelProduto)
      .ModelEmpresa(FParametros.ModelEmpresa)
      .CodigoDaSituacaoTributaria(FParametros.CodigoDaSituacaoTributaria)
      .CodigoDaSubstituicaoTributaria(FCodigoDaSubstituicaoTributariaDoItem)
      .TipoDaAbreviacaoFiscal(FParametros.TipoDaAbreviacaoFiscal)
      .DentroDoEstado(FParametros.DentroDoEstado)
      .TotalGeralDoItem(FParametros.TotalGeralDoItem)
      .ValorDeIpiDoItem(FParametros.ValorDeIpiDoItem)
      .AliquotaDeIcmsDoItem(FAliquotaDeIcmsDoItem)
      .AliquotaDaSubstituicaoTributariaDoItem(FAliquotaDaSubstituicaoTributariaDoItem)
      .DocumentoParaFornecedor(FParametros.DocumentoParaFornecedor)
      .ExisteNaTabelaCEDEM(FParametros.ExisteNaTabelaCEDEM);
end;

function TFaturamentoImpostosRegrasTributacao.PercentualDeReducaoDaBaseDeCalculoDoIcms: Double;
begin
  If (FReducaoRICMPR = 'S') Then
  Begin
    Result := CONST_PERCENTUAL_DIFERIMENTO_RICMS;

    if FAliquotaDiferenciadaRICMPR > 0 then
      Result := FAliquotaDiferenciadaRICMPR;

    Exit;
  End;

  Result := 100 - FPercentualDaBaseDeIcmsDoItem;
end;

procedure TFaturamentoImpostosRegrasTributacao.PrepararSubstituicaoTributariaSimulada;
begin
  If Not Assigned(FResultadoCalculoST_Simulado) Then
    Exit;

  FBaseDaSubstituicaoTributariaSimulada := FResultadoCalculoST_Simulado.BaseDaSubstituicaoTributariaSimulada;
  FAliquotaDaSubstituicaoTributariaSimulada := FResultadoCalculoST_Simulado.AliquotaDaSubstituicaoTributariaSimulada;
  FValorDaSubstituicaoTributariaSimulada := FResultadoCalculoST_Simulado.ValorDaSubstituicaoTributariaSimulada;
end;

function TFaturamentoImpostosRegrasTributacao.ResultadoTributacao: IResultadoRegrasTributacao;
begin
  PrepararSubstituicaoTributariaSimulada;

  Result :=
    TResultadoRegrasTributacao.New
      .AliquotaDeIcms(FAliquotaDeIcmsDoItem)
      .AliquotaDeIcmsEfetivoDoItem(FAliquotaDeIcmsEfetivoDoItem)
      .PercentualDaBaseDeIcms(FPercentualDaBaseDeIcmsDoItem)
      .CodigoDaSubstituicaoTributaria(FCodigoDaSubstituicaoTributariaDoItem)
      .ValorIVAEspecialClienteMTIcms(FResultadoCalculoIvaIcms.ClienteIVAEspMT)
      .AliquotaDeIcmsAnterior(FAliquotaDeIcmsDoItemAnterior)
      .BaseDeCalculoDoIcmsAnterior(FBaseDeCalculoIcmsDoItemAnterior)
      .ValorDoIcmsAnterior(FValorIcmsDoItemAnterior)
      .PercentualDeReducaoDaBaseDeIcms(PercentualDeReducaoDaBaseDeCalculoDoIcms)
      .ReducaoRICMPR(FReducaoRICMPR)
      .AliquotaDaSubstituicaoTributaria(FAliquotaDaSubstituicaoTributariaDoItem)
      .ValorDoIva(FResultadoCalculoIvaSt.ValorDoIva)
      .ValorDoIvaMatriz(FResultadoCalculoIvaSt.ValorDoIvaMatriz)
      .ValorDoIvaStMatriz(FResultadoCalculoIvaSt.ValorDoIvaStMatriz)
      .ValorIVAEspecialClienteMTSt(FResultadoCalculoIvaSt.ClienteIVAEspMT)
      .ValorIcmsEstado(FValorIcmsEstado)
      .PercentualDaBaseDaSubstituicaoTributariaDoItem(FPercentualDaBaseDaSubstituicaoTributariaDoItem)
      .BaseDaSubstituicaoTributariaSimulada(FBaseDaSubstituicaoTributariaSimulada)
      .AliquotaDaSubstituicaoTributariaSimulada(FAliquotaDaSubstituicaoTributariaSimulada)
      .ValorDaSubstituicaoTributariaSimulada(FValorDaSubstituicaoTributariaSimulada)
      .AtendeRegrasAtoDeclaratorioDF(FAtendeRegrasAtoDeclaratorioDF)
      .AliquotaReduzidaDaSt(FAliquotaReduzidaDaSt)
      .STAtribuidaPorRegimeEspecial(FSTAtribuidaPorRegimeEspecial)
end;

function TFaturamentoImpostosRegrasTributacao.RetornarAliquotaDaSubstituicaoTributariaInicial: Double;
begin
  Result := FParametros.ModelAbreviacaoIcms.AliquotaDeSt;
end;

function TFaturamentoImpostosRegrasTributacao.AliquotaDeIcmsEfetivoDoItem: Double;
begin
  result := FAliquotaDeIcmsEfetivoDoItem;
end;

function TFaturamentoImpostosRegrasTributacao.RetornarAliquotaDeIcmsInicial: Double;
begin
  If FParametros.NotaDeImportacao Then
  Begin
    Result := FParametros.AliquotaDeIcmsDoItem;
    Exit;
  End;

  Result := FParametros.ModelAbreviacaoIcms.AliquotaDeIcms;
end;

function TFaturamentoImpostosRegrasTributacao.RetornarAliquotaReduzidaDaSt: Double;
begin
  Result := FParametros.ModelAbreviacaoIcms.AliquotaReduzidaDeSt;
end;

function TFaturamentoImpostosRegrasTributacao.RetornarCodigoDaSubstituicaoTributariaInicial: String;
begin
  If FParametros.NotaDeImportacao Then
  Begin
    Result := FParametros.CodigoDaSituacaoTributaria;
    Exit;
  End;

  Result := FParametros.ModelAbreviacaoIcms.CodigoDaSituacaoTributaria;
end;

function TFaturamentoImpostosRegrasTributacao.RetornarPercentualDaBaseDaSubstituicaoTributariaInicial: Double;
begin
  Result := FParametros.ModelAbreviacaoIcms.PercentualDaBaseDeSt;
end;

function TFaturamentoImpostosRegrasTributacao.RetornarPercentualDaBaseDeIcmsInicial: Double;
begin
  Result := FParametros.ModelAbreviacaoIcms.PercentualDaBaseDeIcms;
end;

function TFaturamentoImpostosRegrasTributacao.STAtribuidaPorAtoDeclaratorioDF: Boolean;
begin
  Result :=
    TFunctionsRegrasImpostosFaturamento.STAtribuidaPorAtoDeclaratorioDF(
      FCodigoDaSubstituicaoTributariaDoItem,
      FParametros.ModelEmpresa.EmpresaEstado,
      IfThen(FParametros.ModelClienteFornecedor.ClienteEstadoEntrega.Trim.IsEmpty,
             FParametros.ModelClienteFornecedor.ClienteEstado,
             FParametros.ModelClienteFornecedor.ClienteEstadoEntrega),
      FParametros.TipoDaAbreviacaoFiscal,
      FParametros.ModelProduto.IndustrializacaoOuRevenda = OpcRevenda,
      FParametros.ModelClienteFornecedor.AtoDeclaratorioDF,
      FParametros.ModelProduto.AtoDeclaratorioDF
    );
end;

function TFaturamentoImpostosRegrasTributacao.STAtribuidaPorRegimeEspecial: Boolean;
begin
  Result :=
    TFunctionsRegrasImpostosFaturamento
      .STAtribuidaPorRegimeEspecial(FParametros.ModelClienteFornecedor.SujeitoPassivoSTRegimeEspecial, FCodigoDaSubstituicaoTributariaDoItem);
end;

function TFaturamentoImpostosRegrasTributacao.TemAliquotaDeEcf: Boolean;
var
  LAliquota: Double;
  LPathInicial: String;
begin
  LAliquota    := objCore.fFormataFloat(FAliquotaDeIcmsDoItem * FPercentualDaBaseDeIcmsDoItem / 100, 2);
  LPathInicial := objConfiguracoes.fGetValorConfiguracao(CFG_DIRETORIO_PARA_OPCOES_FISCAIS_INI);

  Result := objCore.fTemAliqEcf(LAliquota, LPathInicial);
end;

function TFaturamentoImpostosRegrasTributacao.TributarNaAliquotaInternaDoEstado: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento
      .TributarNaAliquotaInternaDoEstado(FParametros.ModelClienteFornecedor.ClienteEstado, FParametros.ModelEmpresa.EmpresaEstado, FParametros.ModelClienteFornecedor.ClienteInscricaoEstadual);
end;

function TFaturamentoImpostosRegrasTributacao.UtilizarSatOuAliquotaEcf: Boolean;
begin
  Result := True;

  If FParametros.UtilizaSat Then
    Exit;

  If TemAliquotaDeEcf Then
    Exit;

  Result := False;
end;

procedure TFaturamentoImpostosRegrasTributacao.ValorCalculadoIva;
var
  LParametrosCalculoIva: IParametrosCalculoIva;
begin
  LParametrosCalculoIva    := ParametrosCalculoIva;
  FResultadoCalculoIvaIcms := TRegraCalculoIvaIcms.New(LParametrosCalculoIva).CalcularValorIva;
  FResultadoCalculoIvaSt   := TRegraCalculoIvaSt.New(LParametrosCalculoIva).CalcularValorIva;
end;

procedure TFaturamentoImpostosRegrasTributacao.ValorCalculadoST_Simulado;
begin
  FResultadoCalculoST_Simulado :=
    TCalculoSTSimulada.New
      .Calcular(ParametroCalculoST_Simulado);
end;

procedure TFaturamentoImpostosRegrasTributacao.ValorCalculadoIcmsAnterior;
begin
  FAliquotaDeIcmsDoItemAnterior    := FAliquotaDeIcmsDoItem;
  FBaseDeCalculoIcmsDoItemAnterior := objCore.fFormataFloat((FParametros.TotalGeralDoItem * FPercentualDaBaseDeIcmsDoItem) / 100, 2);
  FValorIcmsDoItemAnterior         := ValorIcmsDoItemAnterior;
end;

function TFaturamentoImpostosRegrasTributacao.ValorIcmsDoItemAnterior: Double;
var
  LValorIcmsDoItem: Double;
begin
  If OrgaoPublicoTipoDeDescontoRateioDescEspecial Then
  Begin
    LValorIcmsDoItem := objCore.fFormataFloat(FParametros.ValorUnitarioDoItem * FPercentualDaBaseDeIcmsDoItem * FAliquotaDeIcmsDoItem / 100 / 100, 2);
    Result := FParametros.QuantidadeDoItem * LValorIcmsDoItem;
    Exit;
  End;

  Result := objCore.fFormataFloat((((FParametros.TotalGeralDoItem * FPercentualDaBaseDeIcmsDoItem) / 100) * FAliquotaDeIcmsDoItem) / 100, 2);
end;

function TFaturamentoImpostosRegrasTributacao.UsaPercentualReducaoPersonalizado: Boolean;
begin
  Result := (FParametros.ModelAbreviacaoIcms.AliquotaDiferenciadaRICMPR > 0);
end;

procedure TFaturamentoImpostosRegrasTributacao.AtribuirDadosItemPossuiReducaoBaseConfRICMPRVendaDentroDoEstado;
begin
  If not ItemPossuiReducaoBaseConfRICMPR Then
    Exit;

  FCodigoDaSubstituicaoTributariaDoItem := LeftStr(FCodigoDaSubstituicaoTributariaDoItem, 1) + '51';
  If (Not UsaPercentualReducaoPersonalizado) Then
    FAliquotaDeIcmsDoItem       := 18;
  FPercentualDaBaseDeIcmsDoItem := 100;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := 100;
  FReducaoRICMPR := 'S';
  FAliquotaDiferenciadaRICMPR := FParametros.ModelAbreviacaoIcms.AliquotaDiferenciadaRICMPR;
end;

procedure TFaturamentoImpostosRegrasTributacao.AtribuirDadosCupomFiscalPercentualDaBaseDeIcmsMaiorQueZeroNaoUtilizaNFCeVendaDentroDoEstado;
begin
  If not CupomFiscalPercentualDaBaseDeIcmsMaiorQueZeroNaoUtilizaNFCe Then
    Exit;

  If CalcularUsaSatAliqEcf Then
    FAliquotaDeIcmsDoItem := objCore.fFormataFloat(FAliquotaDeIcmsDoItem * FPercentualDaBaseDeIcmsDoItem / 100, 2);

  FPercentualDaBaseDeIcmsDoItem := 100;
end;

procedure TFaturamentoImpostosRegrasTributacao.AtribuirDadosClientePossuiReducaoBaseIcmsParaProdutosTributadosVendaDentroDoEstado;
begin
  If not ClientePossuiReducaoBaseIcmsParaProdutosTributados Then
    Exit;

  FCodigoDaSubstituicaoTributariaDoItem := LeftStr(FCodigoDaSubstituicaoTributariaDoItem, 1) + '20';
  FPercentualDaBaseDeIcmsDoItem         := 100 - FParametros.ModelClienteFornecedor.ReducaoDeBaseDeIcmsTributados;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := 100 - FParametros.ModelClienteFornecedor.ReducaoDeBaseDeIcmsTributados;
end;

procedure TFaturamentoImpostosRegrasTributacao.AtribuirDadosEmpresaDistribuidoraVendaIndustrializacaoDiferimentoSTVendaDentroDoEstado;
begin
  If not EmpresaDistribuidoraVendaIndustrializacaoDiferimentoST Then
    Exit;

  FCodigoDaSubstituicaoTributariaDoItem := LeftStr(FCodigoDaSubstituicaoTributariaDoItem, 1) + '00';
  FPercentualDaBaseDeIcmsDoItem         := 100;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := 100;

  If (Not TFunctionFuncoesFaturamento.ProdutoComOrigemDaMercadoriaEstrangeira(FCodigoDaSubstituicaoTributariaDoItem)) Then
    FAliquotaDeIcmsDoItem := Self.DadosFiscaisAliquota;
end;

procedure TFaturamentoImpostosRegrasTributacao.AtribuirDadosEmpresaOptanteSimplesVendaDentroDoEstado;
var
  strPerICM: String;
begin
  If not EmpresaOptanteSimples Then
    Exit;

  If not UsaAliquotaDeIcmsDoSimplesNacional Then
    Exit;

  strPerICM := CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL;

  If objConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean) Then
  Begin
    If FParametros.ModelProduto.IndustrializacaoOuRevenda = OpcIndustrializacao Then
    Begin
      strPerICM := CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL_INDUSTRIALIZADO;
    End;
  End;

  FAliquotaDeIcmsDoItem := objConfiguracoes.fGetValorConfiguracao(strPerICM, varDouble);
end;

procedure TFaturamentoImpostosRegrasTributacao.AtribuirDadosEmissaoDeCupomFiscalSimplesNacionalNaoTributadoVendaDentroDoEstado;
begin
  If not EmissaoDeCupomFiscalSimplesNacionalNaoTributado Then
    Exit;

  FPercentualDaBaseDeIcmsDoItem := 100;
  FAliquotaDeIcmsDoItem         := FParametros.AlqIcmEstEmpFaturamento;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := 100;
end;

procedure TFaturamentoImpostosRegrasTributacao.AtribuirDadosSTAtribuidaPorAtoDeclaratorioDFVendaDentroDoEstado;
begin
  FAtendeRegrasAtoDeclaratorioDF := STAtribuidaPorAtoDeclaratorioDF;

  If Not FAtendeRegrasAtoDeclaratorioDF Then
    Exit;

  FCodigoDaSubstituicaoTributariaDoItem := LeftStr(FCodigoDaSubstituicaoTributariaDoItem, 1) + '00';
  FPercentualDaBaseDeIcmsDoItem         := 100;
  FAliquotaDeIcmsDoItem                 := RetornarAliquotaDeIcmsInicial;
end;

procedure TFaturamentoImpostosRegrasTributacao.AtribuirDadosSTAtribuidaPorRegimeEspecialVendaDentroDoEstado;
begin
  If not STAtribuidaPorRegimeEspecial Then
    Exit;

  If not EhFaturamentoPelaEmpresaComRegimeEspecialComReducaoDeBase then
  Begin
    FCodigoDaSubstituicaoTributariaDoItem := LeftStr(FCodigoDaSubstituicaoTributariaDoItem, 1) + '00';
    FPercentualDaBaseDeIcmsDoItem         := 100;
  End
  Else
  Begin
    FCodigoDaSubstituicaoTributariaDoItem := LeftStr(FCodigoDaSubstituicaoTributariaDoItem, 1) + '20';
  End;

  FAliquotaDeIcmsDoItem                 := RetornarAliquotaDeIcmsInicial;
  FSTAtribuidaPorRegimeEspecial         := True;
end;

function TFaturamentoImpostosRegrasTributacao.RetornaAliquotaDeIcmsEfetivoDoItem: Double;
begin
  Result := FAliquotaDeIcmsDoItem ;

  If not objConfiguracoes.fGetValorConfiguracao(CFG_QUANDO_OPTANTE_SIMPLES_NACIONAL_UTILIZAR_ALIQUOTA_DA_ABREVIACAO_PARA_ENVIAR_ICMS_EFETIVO, varBoolean) Then
    Exit;

  Result := RetornarAliquotaDeIcmsInicial;
end;

procedure TFaturamentoImpostosRegrasTributacao.VendaDentroDoEstado;
begin
  AtribuirDadosItemPossuiReducaoBaseConfRICMPRVendaDentroDoEstado;
  AtribuirDadosCupomFiscalPercentualDaBaseDeIcmsMaiorQueZeroNaoUtilizaNFCeVendaDentroDoEstado;
  AtribuirDadosClientePossuiReducaoBaseIcmsParaProdutosTributadosVendaDentroDoEstado;
  AtribuirDadosEmpresaDistribuidoraVendaIndustrializacaoDiferimentoSTVendaDentroDoEstado;

  FValorIcmsEstado := objCore.fFormataFloat((((FParametros.TotalGeralDoItem * FPercentualDaBaseDeIcmsDoItem) / 100) * FAliquotaDeIcmsDoItem) / 100, 2);

  AtribuirDadosEmpresaOptanteSimplesVendaDentroDoEstado;
  AtribuirDadosEmissaoDeCupomFiscalSimplesNacionalNaoTributadoVendaDentroDoEstado;
  AtribuirDadosSTAtribuidaPorRegimeEspecialVendaDentroDoEstado;
  AtribuirDadosSTAtribuidaPorAtoDeclaratorioDFVendaDentroDoEstado;

  FAliquotaDeIcmsEfetivoDoItem := RetornaAliquotaDeIcmsEfetivoDoItem;

  If FParametros.ModelEmpresa.EmpresaEstado = 'RJ' Then
    FAliquotaDeIcmsEfetivoDoItem := FAliquotaDeIcmsEfetivoDoItem + FParametros.ModelAbreviacaoIcms.AliquotaDeFcp;

  ValorCalculadoIcmsAnterior;
  ValorCalculadoIva;
  ValorCalculadoST_Simulado;
end;



//function TFaturamentoImpostosRegrasTributacao.RetornarValorIVAEspecialClienteMT
//(const AParametros: IParametrosRegrasTributacao;
//const AliquotaDoIcmsDoItem : Double): Double;
//  Var
//    LImportacaoDireta : Boolean;
//    LTotalGeralDoItem : Double;
//    LClienteIVASimMT  : Double;
//begin
//  Result :=
//    TFunctionFuncoesFaturamento.
//      GetCliIVAEspMT(AParametros.DocumentoParaFornecedor,
//                     AParametros.ModelClienteFornecedor.ClienteInscricaoEstadual,
//                     AParametros.ModelClienteFornecedor.ClienteEstado,
//                     AParametros.ModelClienteFornecedor.ValorIVAEspecialClienteMT);
//
//  If not AParametros.DentroDoEstado Then
//    Exit;
//
//  If not TFunctionFuncoesFaturamento.
//           ClienteZonaFrancaOrgaoPublico(AParametros.ModelClienteFornecedor.OrgaoPublico,
//                                         AParametros.ModelClienteFornecedor.CalcularDescontoIcmsOrgaoPublico,
//                                         AParametros.ModelClienteFornecedor.ZonaFranca,
//                                         AParametros.ClienteConsumidor) Then
//  Begin
//    Exit;
//  End;
//
//  If not AParametros.SubstituicaoTributariaDoItem Then
//    Exit;
//
//  LImportacaoDireta := TFunctionFuncoesFaturamento.ImportacaoDireta(AParametros.ImportacaoDiretaDoItem);
//  LTotalGeralDoItem := AParametros.TotalGeralDoItem;
//
//
//  LClienteIVASimMT :=
//    TFunctionFuncoesFaturamento.
//      GetCliIVASimMT(AParametros.DocumentoParaFornecedor,
//                     AParametros.ModelClienteFornecedor.ClienteInscricaoEstadual,
//                     AParametros.ModelClienteFornecedor.ClienteEstado,
//                     AParametros.ModelClienteFornecedor.ValorIVASimClienteMT);
//
//  If not TFunctionFuncoesFaturamento.ValidarImportacaoDiretaClienteIvaSimMT(LImportacaoDireta, LClienteIVASimMT, LTotalGeralDoItem) Then
//    Exit;
//
//  Result :=
//    TFunctionFuncoesFaturamento.
//      CalcularValorDoIVA(LTotalGeralDoItem,
//                         AliquotaDoIcmsDoItem,
//                         AParametros.ValorDeIpiDoItem ,
//                         LClienteIVASimMT,
//                         AParametros.ModelAbreviacaoIcms.AliquotaDeSt);
//end;

procedure TFaturamentoImpostosRegrasTributacao.AtribuirDadosCupomFiscalAliquotaEcfVendaForaDoEstado;
begin
  If not CupomFiscalPossuiAliquotaEcf Then
    Exit;

  FAliquotaDeIcmsDoItem := objCore.fFormataFloat(FAliquotaDeIcmsDoItem * FPercentualDaBaseDeIcmsDoItem / 100, 2);

  If (objCore.fFormataFloat(FPercentualDaBaseDeIcmsDoItem,2) > 0.00) Then
    FPercentualDaBaseDeIcmsDoItem := 100;
end;

procedure TFaturamentoImpostosRegrasTributacao.AtribuirDadosClientePossuiReducaoBaseIcmsParaProdutosTributadosVendaForaDoEstado;
begin
  If not ClientePossuiReducaoBaseIcmsParaProdutosTributados Then
    Exit;

  FCodigoDaSubstituicaoTributariaDoItem := LeftStr(FCodigoDaSubstituicaoTributariaDoItem, 1) + '20';
  FPercentualDaBaseDeIcmsDoItem         := 100 - FParametros.ModelClienteFornecedor.ReducaoDeBaseDeIcmsTributados;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := 100 - FParametros.ModelClienteFornecedor.ReducaoDeBaseDeIcmsTributados;
end;

procedure TFaturamentoImpostosRegrasTributacao.AtribuirDadosEmpresaDistribuidoraVendaIndustrializacaoDiferimentoSTVendaForaDoEstado;
begin
  If not EmpresaDistribuidoraVendaIndustrializacaoDiferimentoST Then
    Exit;

  FCodigoDaSubstituicaoTributariaDoItem := LeftStr(FCodigoDaSubstituicaoTributariaDoItem, 1) + '00';
  FPercentualDaBaseDeIcmsDoItem         := 100;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := 100;

  {**********************************************************************}
  {* NAO SE APLICA A PRODUTOS COM ORIGEM DA MERCADORIA - ESTRANGEIRA    *}
  {******************************************************************JC**}
  If (Not TFunctionFuncoesFaturamento.ProdutoComOrigemDaMercadoriaEstrangeira(FCodigoDaSubstituicaoTributariaDoItem)) Then
    FAliquotaDeIcmsDoItem := Self.DadosFiscaisAliquota; //Self.fltAlqIcm;
end;

procedure TFaturamentoImpostosRegrasTributacao.AtribuirDadosTributarNaAliquotaInternaDoEstadoVendaForaDoEstado;
begin
  If not TributarNaAliquotaInternaDoEstado Then
    Exit;

  FCodigoDaSubstituicaoTributariaDoItem := '000';
  FPercentualDaBaseDeIcmsDoItem         := 100;
  FAliquotaDeIcmsDoItem                 := FParametros.AlqIcmEstEmpSimples;
end;

procedure TFaturamentoImpostosRegrasTributacao.AtribuirDadosEmpresaOptanteSimplesVendaForaDoEstado;
var
  strPerICM: String;
begin
  If not EmpresaOptanteSimples Then
    Exit;

  If not UsaAliquotaDeIcmsDoSimplesNacional Then
    Exit;

  strPerICM := CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL;

  If objConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean) Then
  Begin
    If FParametros.ModelProduto.IndustrializacaoOuRevenda = OpcIndustrializacao Then
    Begin
      strPerICM := CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL_INDUSTRIALIZADO;
    End;
  End;

  FAliquotaDeIcmsDoItem := objConfiguracoes.fGetValorConfiguracao(strPerICM, varDouble);
end;

procedure TFaturamentoImpostosRegrasTributacao.AtribuirDadosEmissaoDeCupomFiscalSimplesNacionalNaoTributadoVendaForaDoEstado;
begin
  If not EmissaoDeCupomFiscalSimplesNacionalNaoTributado Then
    Exit;

  FPercentualDaBaseDeIcmsDoItem := 100;
  FAliquotaDeIcmsDoItem         := FParametros.AlqIcmEstEmpFaturamento;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := 100;
end;

procedure TFaturamentoImpostosRegrasTributacao.AtribuirDadosSTAtribuidaPorRegimeEspecialVendaForaDoEstado;
begin
  If not STAtribuidaPorRegimeEspecial Then
    Exit;

  If not EhFaturamentoPelaEmpresaComRegimeEspecialComReducaoDeBase then
  Begin
    FCodigoDaSubstituicaoTributariaDoItem := LeftStr(FCodigoDaSubstituicaoTributariaDoItem, 1) + '00';
    FPercentualDaBaseDeIcmsDoItem         := 100;
  End
  Else
  Begin
    FCodigoDaSubstituicaoTributariaDoItem := LeftStr(FCodigoDaSubstituicaoTributariaDoItem, 1) + '20';
  End;

  FAliquotaDeIcmsDoItem                 := RetornarAliquotaDeIcmsInicial;
  FSTAtribuidaPorRegimeEspecial         := True;
end;

procedure TFaturamentoImpostosRegrasTributacao.VendaForaDoEstado;
begin
  AtribuirDadosCupomFiscalAliquotaEcfVendaForaDoEstado;
  AtribuirDadosClientePossuiReducaoBaseIcmsParaProdutosTributadosVendaForaDoEstado;
  AtribuirDadosEmpresaDistribuidoraVendaIndustrializacaoDiferimentoSTVendaForaDoEstado;
  AtribuirDadosTributarNaAliquotaInternaDoEstadoVendaForaDoEstado;

  FValorIcmsEstado := objCore.fFormataFloat((((FParametros.TotalGeralDoItem * FPercentualDaBaseDeIcmsDoItem) / 100) * FAliquotaDeIcmsDoItem) / 100, 2);

  AtribuirDadosEmpresaOptanteSimplesVendaForaDoEstado;
  AtribuirDadosEmissaoDeCupomFiscalSimplesNacionalNaoTributadoVendaForaDoEstado;
  AtribuirDadosSTAtribuidaPorRegimeEspecialVendaForaDoEstado;

  ValorCalculadoIcmsAnterior;
  ValorCalculadoIva;
end;

function TFaturamentoImpostosRegrasTributacao.UsaAliquotaDeIcmsDoSimplesNacional: Boolean;
begin
  Result := EmpresaOptanteSimples;

  If not Result Then
    Exit;

  If not FParametros.DocumentoParaFornecedor Then
    Exit;

  If not FParametros.ModelClienteFornecedor.FornecedorSimples Then
    Exit(False);
end;

function TFaturamentoImpostosRegrasTributacao.EhFaturamentoPelaEmpresaComRegimeEspecialComReducaoDeBase: Boolean;
begin
  Result := False;

  If not (objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_FATURAMENTO_PELA_EMPRESA_COM_REGIME_ESPECIAL, varBoolean)) then
    Exit;

  If not (FPercentualDaBaseDeIcmsDoItem < 100) Then
    Exit;

  Result := True;
end;

end.
