unit untImpostoRegrasTributacao;

interface

uses Faturamento.Impostos.Interfaces.Tributacao,
     Faturamento.Impostos.Interfaces.Iva,
     Faturamento.Impostos.Interfaces.ST_Simulada,
     Shared.Functions.Core,
     Shared.Functions.Configuracoes,
     untTypesST,
     untTypesGenericosImpostos,
     Faturamento.Impostos.Interfaces.Model;

type
  TImpostoRegrasTributacao = class(TInterfacedObject, IFaturamentoImpostosRegrasTributacao, IImpostoRegrasTributacao)
  private
    FCalculouSTSimulada: Boolean;
    FModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
    FModelProduto: IResultadoFaturamentoImpostosModelProduto;
    FModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
    FModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
    FCore: IFunctionsCore;
    FConfiguracoes: IConfiguracoes;
    FParametros: TParametrosRegrasTributacao;
    FCodigoDaSubstituicaoTributariaDoItem: String;
    FAliquotaDeIcmsDoItem: Double;
    FPercentualDaBaseDeIcmsDoItem: Double;
    FAliquotaDaSubstituicaoTributariaDoItem: Double;
    FPercentualDaBaseDaSubstituicaoTributariaDoItem: Double;
    FReducaoRICMPR: String;
    FAliquotaDeIcmsDoItemAnterior: Double;
    FBaseDeCalculoIcmsDoItemAnterior: Double;
    FValorIcmsDoItemAnterior: Double;
    FResultadoCalculoIvaIcms: TResultadoCalculoIva;
    FResultadoCalculoIvaSt: TResultadoCalculoIva;
    FResultadoCalculoST_Simulado: TResultadoRegrasSTSimulada;
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
    function ValorIcmsDoItemAnterior: Double;
    function OrgaoPublicoTipoDeDescontoRateioDescEspecial: Boolean;
    function PercentualDeReducaoDaBaseDeCalculoDoIcms: Double;
    function ParametrosCalculoIva: TParametrosCalculoIva;
    function ParametroCalculoST_Simulado: TParametrosRegrasSTSimulada;
    function UsaPercentualReducaoPersonalizado: Boolean;

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
    function ResultadoTributacao: IResultadoRegrasTributacao; overload;
  public
    function IniciarAliquotasEPercentuais: IFaturamentoImpostosRegrasTributacao;
    function DentroOuForaDoEstado: IFaturamentoImpostosRegrasTributacao;
    function ResultadoTributacao(const NullParameter: String): TResultadoRegrasTributacao; overload;

    function AliquotaDeIcmsEfetivoDoItem : Double;

    constructor Create(AParametros: TParametrosRegrasTributacao;
      AConfiguracoes: IConfiguracoes;
      ACore: IFunctionsCore;
      AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
      AModelProduto: IResultadoFaturamentoImpostosModelProduto;
      AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
      AModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms); overload;

    class function New(AParametros: TParametrosRegrasTributacao;
      AConfiguracoes: IConfiguracoes;
      ACore: IFunctionsCore;
      AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
      AModelProduto: IResultadoFaturamentoImpostosModelProduto;
      AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
      AModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms): IFaturamentoImpostosRegrasTributacao;
  end;

implementation

uses Shared.Functions.Faturamento.Impostos.Regras, System.SysUtils,
     Faturamento.Impostos.Interfaces.DadosFiscais.Aliquota,
     untImpostoRegrasAliquota, Shared.Functions.Funcoes.Faturamento,
     Shared.Functions.Constantes, System.StrUtils, Shared.Functions.Types,
     untRegraCalculoIva, untRegraCalculoIvaIcms, untRegraCalculoIvaST,
     untCalculoImpostoSTSimulada;

{ TImpostoRegrasTributacao }

function TImpostoRegrasTributacao.CalcularUsaSatAliqEcf: Boolean;
begin
  Result := False;

  If Not FParametros.CalcularSatEcf Then
    Exit;

  If Not UtilizarSatOuAliquotaEcf Then
    Exit;

  Result := True;
end;

function TImpostoRegrasTributacao.ClientePossuiReducaoBaseIcmsParaProdutosTributados: Boolean;
begin
  Result :=
    TFunctionsRegrasImpostosFaturamento
      .ClientePossuiReducaoBaseIcmsParaProdutosTributados(FModelClienteFornecedor.ReducaoDeBaseDeIcmsTributados, FCodigoDaSubstituicaoTributariaDoItem);
end;

constructor TImpostoRegrasTributacao.Create(AParametros: TParametrosRegrasTributacao;
  AConfiguracoes: IConfiguracoes;
  ACore: IFunctionsCore;
  AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
  AModelProduto: IResultadoFaturamentoImpostosModelProduto;
  AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
  AModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms);
begin
  FCalculouSTSimulada := False;
  FCore := ACore;
  FParametros := AParametros;
  FConfiguracoes := AConfiguracoes;
  FSTAtribuidaPorRegimeEspecial := False;
  FModelClienteFornecedor := AModelClienteFornecedor;
  FModelProduto := AModelProduto;
  FModelEmpresa := AModelEmpresa;
  FModelAbreviacaoIcms := AModelAbreviacaoIcms;
end;

function TImpostoRegrasTributacao.CupomFiscalPercentualDaBaseDeIcmsMaiorQueZeroNaoUtilizaNFCe: Boolean;
begin
  Result :=
    TFunctionsRegrasImpostosFaturamento
      .CupomFiscalPercentualDaBaseDeIcmsMaiorQueZeroNaoUtilizaNFCe(FParametros.EspecieDoDocumento, FPercentualDaBaseDeIcmsDoItem);
end;

function TImpostoRegrasTributacao.CupomFiscalPossuiAliquotaEcf: Boolean;
begin
  Result :=
    TFunctionsRegrasImpostosFaturamento
      .CupomFiscalPossuiAliquotaEcf(FParametros.EspecieDoDocumento, TemAliquotaDeEcf);
end;

function TImpostoRegrasTributacao.DadosFiscaisAliquota: Double;
  Var
    LParametros : TParametrosDadosFiscaisAliquota;
begin
  FillChar(LParametros, SizeOf(LParametros), #0);
  LParametros.ClienteEstado := FModelClienteFornecedor.ClienteEstado;
  LParametros.InscricaoEstadual := FModelClienteFornecedor.ClienteInscricaoEstadual;
  LParametros.MicroEmpreendedor := FModelClienteFornecedor.ClienteMicroEmpreendedor;
  LParametros.EmpresaEstado := FModelEmpresa.EmpresaEstado;
  LParametros.DocumentoDeVenda := True;
  LParametros.DentroDoEstadoCFOP := FParametros.DentroDoEstadoCFOP;
  LParametros.AtividadeConstrutora := FParametros.AtividadeConstrutora;
  LParametros.EspecieDocumento := FParametros.EspecieDoDocumento;

  Result := TImpostoRegrasAliquota.New(FConfiguracoes).DadosFiscaisAliquotaDoItem(LParametros).AliquotaIcm;
end;

function TImpostoRegrasTributacao.DentroOuForaDoEstado: IFaturamentoImpostosRegrasTributacao;
begin
  Result := Self;

  If FParametros.DentroDoEstado Then
  Begin
    VendaDentroDoEstado;
    Exit;
  End;

  VendaForaDoEstado;
end;

function TImpostoRegrasTributacao.EmissaoDeCupomFiscalSimplesNacionalNaoTributado: Boolean;
begin
  Result :=
    TFunctionsRegrasImpostosFaturamento
      .EmissaoDeCupomFiscalSimplesNacionalNaoTributado(FParametros.EspecieDoDocumento, EmpresaOptanteSimples, FCodigoDaSubstituicaoTributariaDoItem);
end;

function TImpostoRegrasTributacao.EmpresaDistribuidoraVendaIndustrializacaoDiferimentoST: Boolean;
begin
  Result :=
    TFunctionsRegrasImpostosFaturamento
      .EmpresaDistribuidoraVendaIndustrializacaoDiferimentoST(FModelClienteFornecedor.UtilizarDiferimetoST,Not FParametros.ClienteComercializacao);

end;

function TImpostoRegrasTributacao.EmpresaOptanteSimples: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento
      .EmpresaOptanteSimples(FConfiguracoes.fGetValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL));
end;

function TImpostoRegrasTributacao.IniciarAliquotasEPercentuais: IFaturamentoImpostosRegrasTributacao;
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

function TImpostoRegrasTributacao.ItemPossuiReducaoBaseConfRICMPR: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.fItemPossuiReducaoBaseConfRICMPR(FParametros.DentroDoEstado,
                                                                 FModelClienteFornecedor.ConsumidorFinal,
                                                                 FModelClienteFornecedor.ClienteInscricaoEstadual,
                                                                 FModelClienteFornecedor.ClienteMicroEmpreendedor,
                                                                 FCodigoDaSubstituicaoTributariaDoItem,
                                                                 FParametros.UtilizaDecretoReducaoRICMSdaAbreviacao,
                                                                 FParametros.TipoDaAbreviacaoFiscal); // precisa rever a regra desse parâmetro conforme revisão: 203525
end;

class function TImpostoRegrasTributacao.New(AParametros: TParametrosRegrasTributacao;
  AConfiguracoes: IConfiguracoes;
  ACore: IFunctionsCore;
  AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
  AModelProduto: IResultadoFaturamentoImpostosModelProduto;
  AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
  AModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms): IFaturamentoImpostosRegrasTributacao;
begin
  Result := Self.Create(AParametros, AConfiguracoes, ACore, AModelClienteFornecedor, AModelProduto, AModelEmpresa, AModelAbreviacaoIcms);
end;

function TImpostoRegrasTributacao.OrgaoPublicoTipoDeDescontoRateioDescEspecial: Boolean;
begin
  Result := False;

  If Not FParametros.DentroDoEstado Then
    Exit;

  If Not FModelClienteFornecedor.OrgaoPublico Then
    Exit;

  If FModelClienteFornecedor.TipoDeDescontoRateioDescEspecial <> 'R' Then
    Exit;

  Result := True;
end;

function TImpostoRegrasTributacao.ParametroCalculoST_Simulado: TParametrosRegrasSTSimulada;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.TotalGeralDoItem := FParametros.TotalGeralDoItemST_Simulado;
  Result.ClienteConsumidorFinal := FModelClienteFornecedor.ConsumidorFinal;
  Result.CodigoDaSubstituicaoTributaria := FCodigoDaSubstituicaoTributariaDoItem;
  Result.TipoDaAbreviacaoFiscal := FParametros.TipoDaAbreviacaoFiscal;
  Result.ValorDoIva := FResultadoCalculoIvaSt.ValorDoIva;
  Result.AliquotaDaSubstituicaoTributariaDoItem := FAliquotaDaSubstituicaoTributariaDoItem;
  Result.PercentualDaBaseDaSubstituicaoTributariaDoItem := FPercentualDaBaseDaSubstituicaoTributariaDoItem;
  Result.EspecieDoDocumento := FParametros.EspecieDoDocumento;
  Result.DentroDoEstado := FParametros.DentroDoEstado;
  Result.DentroDoEstadoCFOP := FParametros.DentroDoEstadoCFOP;
  Result.AtividadeConstrutora := FParametros.AtividadeConstrutora;
//    TParametrosRegrasSTSimulada.New
//      .ModelClienteFornecedor(FParametros.ModelClienteFornecedor)
//      .ModelProduto(FParametros.ModelProduto)
//      .ModelEmpresa(FParametros.ModelEmpresa)
end;

function TImpostoRegrasTributacao.ParametrosCalculoIva: TParametrosCalculoIva;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.PercentualDoIvaAbreviacao := FModelAbreviacaoIcms.PercentualDeIva;
  Result.CodigoDaSituacaoTributaria := FParametros.CodigoDaSituacaoTributaria;
  Result.CodigoDaSubstituicaoTributaria := FCodigoDaSubstituicaoTributariaDoItem;
  Result.TipoDaAbreviacaoFiscal := FParametros.TipoDaAbreviacaoFiscal;
  Result.DentroDoEstado := FParametros.DentroDoEstado;
  Result.TotalGeralDoItem := FParametros.TotalGeralDoItem;
  Result.ValorDeIpiDoItem := FParametros.ValorDeIpiDoItem;
  Result.AliquotaDeIcmsDoItem := FAliquotaDeIcmsDoItem;
  Result.AliquotaDaSubstituicaoTributariaDoItem := FAliquotaDaSubstituicaoTributariaDoItem;
  Result.DocumentoParaFornecedor := FParametros.DocumentoParaFornecedor;
  Result.ExisteNaTabelaCEDEM := FParametros.ExisteNaTabelaCEDEM;
//      .ModelClienteFornecedor(FParametros.ModelClienteFornecedor)
//      .ModelProduto(FParametros.ModelProduto)
//      .ModelEmpresa(FParametros.ModelEmpresa)
end;

function TImpostoRegrasTributacao.PercentualDeReducaoDaBaseDeCalculoDoIcms: Double;
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

procedure TImpostoRegrasTributacao.PrepararSubstituicaoTributariaSimulada;
begin
  If Not FCalculouSTSimulada Then // testar essa mudança
    Exit;

  FBaseDaSubstituicaoTributariaSimulada := FResultadoCalculoST_Simulado.BaseDaSubstituicaoTributariaSimulada;
  FAliquotaDaSubstituicaoTributariaSimulada := FResultadoCalculoST_Simulado.AliquotaDaSubstituicaoTributariaSimulada;
  FValorDaSubstituicaoTributariaSimulada := FResultadoCalculoST_Simulado.ValorDaSubstituicaoTributariaSimulada;
end;

function TImpostoRegrasTributacao.ResultadoTributacao(const NullParameter: String): TResultadoRegrasTributacao;
begin
  PrepararSubstituicaoTributariaSimulada;

  FillChar(Result, SizeOf(Result), #0);
  Result.AliquotaDeIcms := FAliquotaDeIcmsDoItem;
  Result.AliquotaDeIcmsEfetivoDoItem := FAliquotaDeIcmsEfetivoDoItem;
  Result.PercentualDaBaseDeIcms := FPercentualDaBaseDeIcmsDoItem;
  Result.CodigoDaSubstituicaoTributaria := FCodigoDaSubstituicaoTributariaDoItem;
  Result.ValorIVAEspecialClienteMTIcms := FResultadoCalculoIvaIcms.ClienteIVAEspMT;
  Result.AliquotaDeIcmsAnterior := FAliquotaDeIcmsDoItemAnterior;
  Result.BaseDeCalculoDoIcmsAnterior := FBaseDeCalculoIcmsDoItemAnterior;
  Result.ValorDoIcmsAnterior := FValorIcmsDoItemAnterior;
  Result.PercentualDeReducaoDaBaseDeIcms := PercentualDeReducaoDaBaseDeCalculoDoIcms;
  Result.ReducaoRICMPR := FReducaoRICMPR;
  Result.AliquotaDaSubstituicaoTributaria := FAliquotaDaSubstituicaoTributariaDoItem;
  Result.ValorDoIva := FResultadoCalculoIvaSt.ValorDoIva;
  Result.ValorDoIvaMatriz := FResultadoCalculoIvaSt.ValorDoIvaMatriz;
  Result.ValorDoIvaStMatriz := FResultadoCalculoIvaSt.ValorDoIvaStMatriz;
  Result.ValorIVAEspecialClienteMTSt := FResultadoCalculoIvaSt.ClienteIVAEspMT;
  Result.ValorIcmsEstado := FValorIcmsEstado;
  Result.PercentualDaBaseDaSubstituicaoTributariaDoItem := FPercentualDaBaseDaSubstituicaoTributariaDoItem;
  Result.BaseDaSubstituicaoTributariaSimulada := FBaseDaSubstituicaoTributariaSimulada;
  Result.AliquotaDaSubstituicaoTributariaSimulada := FAliquotaDaSubstituicaoTributariaSimulada;
  Result.ValorDaSubstituicaoTributariaSimulada := FValorDaSubstituicaoTributariaSimulada;
  Result.AtendeRegrasAtoDeclaratorioDF := FAtendeRegrasAtoDeclaratorioDF;
  Result.AliquotaReduzidaDaSt := FAliquotaReduzidaDaSt;
  Result.STAtribuidaPorRegimeEspecial := FSTAtribuidaPorRegimeEspecial;
end;

function TImpostoRegrasTributacao.ResultadoTributacao: IResultadoRegrasTributacao;
begin
  raise Exception.Create('Chamada de Método Inválido! [TImpostoRegrasTributacao.ResultadoTributacao]');
end;

function TImpostoRegrasTributacao.RetornarAliquotaDaSubstituicaoTributariaInicial: Double;
begin
  Result := FModelAbreviacaoIcms.AliquotaDeSt;
end;

function TImpostoRegrasTributacao.AliquotaDeIcmsEfetivoDoItem: Double;
begin
  result := FAliquotaDeIcmsEfetivoDoItem;
end;

function TImpostoRegrasTributacao.RetornarAliquotaDeIcmsInicial: Double;
begin
  If FParametros.NotaDeImportacao Then
  Begin
    Result := FParametros.AliquotaDeIcmsDoItem;
    Exit;
  End;

  Result := FModelAbreviacaoIcms.AliquotaDeIcms;
end;

function TImpostoRegrasTributacao.RetornarAliquotaReduzidaDaSt: Double;
begin
  Result := FModelAbreviacaoIcms.AliquotaReduzidaDeSt;
end;

function TImpostoRegrasTributacao.RetornarCodigoDaSubstituicaoTributariaInicial: String;
begin
  If FParametros.NotaDeImportacao Then
  Begin
    Result := FParametros.CodigoDaSituacaoTributaria;
    Exit;
  End;

  Result := FModelAbreviacaoIcms.CodigoDaSituacaoTributaria;
end;

function TImpostoRegrasTributacao.RetornarPercentualDaBaseDaSubstituicaoTributariaInicial: Double;
begin
  Result := FModelAbreviacaoIcms.PercentualDaBaseDeSt;
end;

function TImpostoRegrasTributacao.RetornarPercentualDaBaseDeIcmsInicial: Double;
begin
  Result := FModelAbreviacaoIcms.PercentualDaBaseDeIcms;
end;

function TImpostoRegrasTributacao.STAtribuidaPorAtoDeclaratorioDF: Boolean;
begin
  Result :=
    TFunctionsRegrasImpostosFaturamento.STAtribuidaPorAtoDeclaratorioDF(
      FCodigoDaSubstituicaoTributariaDoItem,
      FModelEmpresa.EmpresaEstado,
      IfThen(FModelClienteFornecedor.ClienteEstadoEntrega.Trim.IsEmpty,
             FModelClienteFornecedor.ClienteEstado,
             FModelClienteFornecedor.ClienteEstadoEntrega),
      FParametros.TipoDaAbreviacaoFiscal,
      FModelProduto.IndustrializacaoOuRevenda = OpcRevenda,
      FModelClienteFornecedor.AtoDeclaratorioDF,
      FModelProduto.AtoDeclaratorioDF
    );
end;

function TImpostoRegrasTributacao.STAtribuidaPorRegimeEspecial: Boolean;
begin
  Result :=
    TFunctionsRegrasImpostosFaturamento
      .STAtribuidaPorRegimeEspecial(FModelClienteFornecedor.SujeitoPassivoSTRegimeEspecial, FCodigoDaSubstituicaoTributariaDoItem);
end;

function TImpostoRegrasTributacao.TemAliquotaDeEcf: Boolean;
var
  LAliquota: Double;
  LPathInicial: String;
begin
  LAliquota    := FCore.fFormataFloat(FAliquotaDeIcmsDoItem * FPercentualDaBaseDeIcmsDoItem / 100, 2);
  LPathInicial := FConfiguracoes.fGetValorConfiguracao(CFG_DIRETORIO_PARA_OPCOES_FISCAIS_INI);

  Result := FCore.fTemAliqEcf(LAliquota, LPathInicial);
end;

function TImpostoRegrasTributacao.TributarNaAliquotaInternaDoEstado: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento
      .TributarNaAliquotaInternaDoEstado(FModelClienteFornecedor.ClienteEstado, FModelEmpresa.EmpresaEstado, FModelClienteFornecedor.ClienteInscricaoEstadual);
end;

function TImpostoRegrasTributacao.UtilizarSatOuAliquotaEcf: Boolean;
begin
  Result := True;

  If FParametros.UtilizaSat Then
    Exit;

  If TemAliquotaDeEcf Then
    Exit;

  Result := False;
end;

procedure TImpostoRegrasTributacao.ValorCalculadoIva;
var
  LParametrosCalculoIva: TParametrosCalculoIva;
begin
  FillChar(LParametrosCalculoIva, SizeOf(LParametrosCalculoIva), #0);
  FillChar(FResultadoCalculoIvaIcms, SizeOf(FResultadoCalculoIvaIcms), #0);
  FillChar(FResultadoCalculoIvaSt, SizeOf(FResultadoCalculoIvaSt), #0);
  LParametrosCalculoIva    := ParametrosCalculoIva;
  FResultadoCalculoIvaIcms := TRegraCalculoIvaIcms.New(LParametrosCalculoIva, FModelClienteFornecedor, FModelProduto, FModelEmpresa, FCore).CalcularValorIva('');
  FResultadoCalculoIvaSt   := TRegraCalculoIvaSt.New(LParametrosCalculoIva, FModelClienteFornecedor, FModelProduto, FModelEmpresa, FCore).CalcularValorIva('');
end;

procedure TImpostoRegrasTributacao.ValorCalculadoST_Simulado;
  var
    LCalculoImpostoSTSimulada : TCalculoImpostoSTSimulada;
begin
  FillChar(FResultadoCalculoST_Simulado, SizeOf(FResultadoCalculoST_Simulado), #0);

  LCalculoImpostoSTSimulada := TCalculoImpostoSTSimulada.Create(FCore, FConfiguracoes);
  Try
    FResultadoCalculoST_Simulado := LCalculoImpostoSTSimulada.Calcular(ParametroCalculoST_Simulado, FModelClienteFornecedor, FModelProduto, FModelEmpresa);
    FCalculouSTSimulada := True;
  Finally
    FreeAndNil(LCalculoImpostoSTSimulada);
  End;
end;

procedure TImpostoRegrasTributacao.ValorCalculadoIcmsAnterior;
begin
  FAliquotaDeIcmsDoItemAnterior    := FAliquotaDeIcmsDoItem;
  FBaseDeCalculoIcmsDoItemAnterior := FCore.fFormataFloat((FParametros.TotalGeralDoItem * FPercentualDaBaseDeIcmsDoItem) / 100, 2);
  FValorIcmsDoItemAnterior         := ValorIcmsDoItemAnterior;
end;

function TImpostoRegrasTributacao.ValorIcmsDoItemAnterior: Double;
var
  LValorIcmsDoItem: Double;
begin
  If OrgaoPublicoTipoDeDescontoRateioDescEspecial Then
  Begin
    LValorIcmsDoItem := FCore.fFormataFloat(FParametros.ValorUnitarioDoItem * FPercentualDaBaseDeIcmsDoItem * FAliquotaDeIcmsDoItem / 100 / 100, 2);
    Result := FParametros.QuantidadeDoItem * LValorIcmsDoItem;
    Exit;
  End;

  Result := FCore.fFormataFloat((((FParametros.TotalGeralDoItem * FPercentualDaBaseDeIcmsDoItem) / 100) * FAliquotaDeIcmsDoItem) / 100, 2);
end;

function TImpostoRegrasTributacao.UsaPercentualReducaoPersonalizado: Boolean;
begin
  Result := (FModelAbreviacaoIcms.AliquotaDiferenciadaRICMPR > 0);
end;

procedure TImpostoRegrasTributacao.AtribuirDadosItemPossuiReducaoBaseConfRICMPRVendaDentroDoEstado;
begin
  If not ItemPossuiReducaoBaseConfRICMPR Then
    Exit;

  FCodigoDaSubstituicaoTributariaDoItem := LeftStr(FCodigoDaSubstituicaoTributariaDoItem, 1) + '51';
  If (Not UsaPercentualReducaoPersonalizado) Then
    FAliquotaDeIcmsDoItem       := 18;
  FPercentualDaBaseDeIcmsDoItem := 100;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := 100;
  FReducaoRICMPR := 'S';
  FAliquotaDiferenciadaRICMPR := FModelAbreviacaoIcms.AliquotaDiferenciadaRICMPR;
end;

procedure TImpostoRegrasTributacao.AtribuirDadosCupomFiscalPercentualDaBaseDeIcmsMaiorQueZeroNaoUtilizaNFCeVendaDentroDoEstado;
begin
  If not CupomFiscalPercentualDaBaseDeIcmsMaiorQueZeroNaoUtilizaNFCe Then
    Exit;

  If CalcularUsaSatAliqEcf Then
    FAliquotaDeIcmsDoItem := FCore.fFormataFloat(FAliquotaDeIcmsDoItem * FPercentualDaBaseDeIcmsDoItem / 100, 2);

  FPercentualDaBaseDeIcmsDoItem := 100;
end;

procedure TImpostoRegrasTributacao.AtribuirDadosClientePossuiReducaoBaseIcmsParaProdutosTributadosVendaDentroDoEstado;
begin
  If not ClientePossuiReducaoBaseIcmsParaProdutosTributados Then
    Exit;

  FCodigoDaSubstituicaoTributariaDoItem := LeftStr(FCodigoDaSubstituicaoTributariaDoItem, 1) + '20';
  FPercentualDaBaseDeIcmsDoItem         := 100 - FModelClienteFornecedor.ReducaoDeBaseDeIcmsTributados;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := 100 - FModelClienteFornecedor.ReducaoDeBaseDeIcmsTributados;
end;

procedure TImpostoRegrasTributacao.AtribuirDadosEmpresaDistribuidoraVendaIndustrializacaoDiferimentoSTVendaDentroDoEstado;
begin
  If not EmpresaDistribuidoraVendaIndustrializacaoDiferimentoST Then
    Exit;

  FCodigoDaSubstituicaoTributariaDoItem := LeftStr(FCodigoDaSubstituicaoTributariaDoItem, 1) + '00';
  FPercentualDaBaseDeIcmsDoItem         := 100;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := 100;

  If (Not TFunctionFuncoesFaturamento.ProdutoComOrigemDaMercadoriaEstrangeira(FCodigoDaSubstituicaoTributariaDoItem)) Then
    FAliquotaDeIcmsDoItem := Self.DadosFiscaisAliquota;
end;

procedure TImpostoRegrasTributacao.AtribuirDadosEmpresaOptanteSimplesVendaDentroDoEstado;
var
  strPerICM: String;
begin
  If not EmpresaOptanteSimples Then
    Exit;

  strPerICM := CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL;

  If FConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean) Then
  Begin
    If FModelProduto.IndustrializacaoOuRevenda = OpcIndustrializacao Then
    Begin
      strPerICM := CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL_INDUSTRIALIZADO;
    End;
  End;

  FAliquotaDeIcmsDoItem := FConfiguracoes.fGetValorConfiguracao(strPerICM, varDouble);
end;

procedure TImpostoRegrasTributacao.AtribuirDadosEmissaoDeCupomFiscalSimplesNacionalNaoTributadoVendaDentroDoEstado;
begin
  If not EmissaoDeCupomFiscalSimplesNacionalNaoTributado Then
    Exit;

  FPercentualDaBaseDeIcmsDoItem := 100;
  FAliquotaDeIcmsDoItem         := FParametros.AlqIcmEstEmpFaturamento;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := 100;
end;

procedure TImpostoRegrasTributacao.AtribuirDadosSTAtribuidaPorAtoDeclaratorioDFVendaDentroDoEstado;
begin
  FAtendeRegrasAtoDeclaratorioDF := STAtribuidaPorAtoDeclaratorioDF;

  If Not FAtendeRegrasAtoDeclaratorioDF Then
    Exit;

  FCodigoDaSubstituicaoTributariaDoItem := LeftStr(FCodigoDaSubstituicaoTributariaDoItem, 1) + '00';
  FPercentualDaBaseDeIcmsDoItem         := 100;
  FAliquotaDeIcmsDoItem                 := RetornarAliquotaDeIcmsInicial;
end;

procedure TImpostoRegrasTributacao.AtribuirDadosSTAtribuidaPorRegimeEspecialVendaDentroDoEstado;
begin
  If not STAtribuidaPorRegimeEspecial Then
    Exit;

  FCodigoDaSubstituicaoTributariaDoItem := LeftStr(FCodigoDaSubstituicaoTributariaDoItem, 1) + '00';
  FPercentualDaBaseDeIcmsDoItem         := 100;
  FAliquotaDeIcmsDoItem                 := RetornarAliquotaDeIcmsInicial;
  FSTAtribuidaPorRegimeEspecial         := True;
end;

procedure TImpostoRegrasTributacao.VendaDentroDoEstado;
begin
  AtribuirDadosItemPossuiReducaoBaseConfRICMPRVendaDentroDoEstado;
  AtribuirDadosCupomFiscalPercentualDaBaseDeIcmsMaiorQueZeroNaoUtilizaNFCeVendaDentroDoEstado;
  AtribuirDadosClientePossuiReducaoBaseIcmsParaProdutosTributadosVendaDentroDoEstado;
  AtribuirDadosEmpresaDistribuidoraVendaIndustrializacaoDiferimentoSTVendaDentroDoEstado;

  FValorIcmsEstado := FCore.fFormataFloat((((FParametros.TotalGeralDoItem * FPercentualDaBaseDeIcmsDoItem) / 100) * FAliquotaDeIcmsDoItem) / 100, 2);

  AtribuirDadosEmpresaOptanteSimplesVendaDentroDoEstado;
  AtribuirDadosEmissaoDeCupomFiscalSimplesNacionalNaoTributadoVendaDentroDoEstado;
  AtribuirDadosSTAtribuidaPorRegimeEspecialVendaDentroDoEstado;
  AtribuirDadosSTAtribuidaPorAtoDeclaratorioDFVendaDentroDoEstado;

  FAliquotaDeIcmsEfetivoDoItem := FAliquotaDeIcmsDoItem;

  ValorCalculadoIcmsAnterior;
  ValorCalculadoIva;
  ValorCalculadoST_Simulado;
end;

procedure TImpostoRegrasTributacao.AtribuirDadosCupomFiscalAliquotaEcfVendaForaDoEstado;
begin
  If not CupomFiscalPossuiAliquotaEcf Then
    Exit;

  FAliquotaDeIcmsDoItem := FCore.fFormataFloat(FAliquotaDeIcmsDoItem * FPercentualDaBaseDeIcmsDoItem / 100, 2);

  If (FCore.fFormataFloat(FPercentualDaBaseDeIcmsDoItem,2) > 0.00) Then
    FPercentualDaBaseDeIcmsDoItem := 100;
end;

procedure TImpostoRegrasTributacao.AtribuirDadosClientePossuiReducaoBaseIcmsParaProdutosTributadosVendaForaDoEstado;
begin
  If not ClientePossuiReducaoBaseIcmsParaProdutosTributados Then
    Exit;

  FCodigoDaSubstituicaoTributariaDoItem := LeftStr(FCodigoDaSubstituicaoTributariaDoItem, 1) + '20';
  FPercentualDaBaseDeIcmsDoItem         := 100 - FModelClienteFornecedor.ReducaoDeBaseDeIcmsTributados;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := 100 - FModelClienteFornecedor.ReducaoDeBaseDeIcmsTributados;
end;

procedure TImpostoRegrasTributacao.AtribuirDadosEmpresaDistribuidoraVendaIndustrializacaoDiferimentoSTVendaForaDoEstado;
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
    FAliquotaDeIcmsDoItem := Self.DadosFiscaisAliquota;
end;

procedure TImpostoRegrasTributacao.AtribuirDadosTributarNaAliquotaInternaDoEstadoVendaForaDoEstado;
begin
  If not TributarNaAliquotaInternaDoEstado Then
    Exit;

  FCodigoDaSubstituicaoTributariaDoItem := '000';
  FPercentualDaBaseDeIcmsDoItem         := 100;
  FAliquotaDeIcmsDoItem                 := FParametros.AlqIcmEstEmpSimples;
end;

procedure TImpostoRegrasTributacao.AtribuirDadosEmpresaOptanteSimplesVendaForaDoEstado;
var
  strPerICM: String;
begin
  If not EmpresaOptanteSimples Then
    Exit;

  strPerICM := CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL;

  If FConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean) Then
  Begin
    If FModelProduto.IndustrializacaoOuRevenda = OpcIndustrializacao Then
    Begin
      strPerICM := CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL_INDUSTRIALIZADO;
    End;
  End;

  FAliquotaDeIcmsDoItem := FConfiguracoes.fGetValorConfiguracao(strPerICM, varDouble);
end;

procedure TImpostoRegrasTributacao.AtribuirDadosEmissaoDeCupomFiscalSimplesNacionalNaoTributadoVendaForaDoEstado;
begin
  If not EmissaoDeCupomFiscalSimplesNacionalNaoTributado Then
    Exit;

  FPercentualDaBaseDeIcmsDoItem := 100;
  FAliquotaDeIcmsDoItem         := FParametros.AlqIcmEstEmpFaturamento;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := 100;
end;

procedure TImpostoRegrasTributacao.AtribuirDadosSTAtribuidaPorRegimeEspecialVendaForaDoEstado;
begin
  If not STAtribuidaPorRegimeEspecial Then
    Exit;

  FCodigoDaSubstituicaoTributariaDoItem := LeftStr(FCodigoDaSubstituicaoTributariaDoItem, 1) + '00';
  FPercentualDaBaseDeIcmsDoItem         := 100;
  FAliquotaDeIcmsDoItem                 := RetornarAliquotaDeIcmsInicial;
  FSTAtribuidaPorRegimeEspecial         := True;
end;

procedure TImpostoRegrasTributacao.VendaForaDoEstado;
begin
  AtribuirDadosCupomFiscalAliquotaEcfVendaForaDoEstado;
  AtribuirDadosClientePossuiReducaoBaseIcmsParaProdutosTributadosVendaForaDoEstado;
  AtribuirDadosEmpresaDistribuidoraVendaIndustrializacaoDiferimentoSTVendaForaDoEstado;
  AtribuirDadosTributarNaAliquotaInternaDoEstadoVendaForaDoEstado;

  FValorIcmsEstado := FCore.fFormataFloat((((FParametros.TotalGeralDoItem * FPercentualDaBaseDeIcmsDoItem) / 100) * FAliquotaDeIcmsDoItem) / 100, 2);

  AtribuirDadosEmpresaOptanteSimplesVendaForaDoEstado;
  AtribuirDadosEmissaoDeCupomFiscalSimplesNacionalNaoTributadoVendaForaDoEstado;
  AtribuirDadosSTAtribuidaPorRegimeEspecialVendaForaDoEstado;

  ValorCalculadoIcmsAnterior;
  ValorCalculadoIva;
end;

end.
