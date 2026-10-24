unit Controller.Faturamento.Impostos.FcpDifal;

interface

uses
  System.StrUtils,
  Shared.Functions.Configuracoes,
  Controller.Faturamento.Interfaces.Impostos.FcpDifal,
  untFuncFatTypes,
  Faturamento.Impostos.Interfaces.FcpDifal,
  Faturamento.Impostos.Tipos.FcpDifal,
  Controller.Faturamento.Interfaces.Impostos.Parametros.Comum,
  Core.Funcoes,
  untFatCalcularImpostosService,
  Faturamento.Impostos.Calculos.TesteUnitarioLog;

type
  TImpostosFatControllerFcpDifal = class(TInterfacedObject, IImpostosFatControllerFcpDifal)
  private
    FDadosFechamento: TDadosFechamento;
    FParametrosFcpDifal: IParametrosServicoFcpDifal;

    procedure SetarParametrosFcpDifal; Overload;
//    procedure SetarValorFinalMatriz(const AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal);
    procedure GerarLogTesteUnitario(const AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal);
    function GerarLogFcp(const AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal): Boolean;
    function GerarLogDifal(const AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal): Boolean;
    function GerarLogDifalFcp(const AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal): Boolean;

    function ResultadoValorFcpDifalFinal(const AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal): IResultadoCalculoFcpDifalFinal;
    function CalcularDifalParaCombustiveis_e_LubrificantesNaoTributados(const AItens : TDadosFechamento): Boolean;
    function RetornaBaseDeCalculoDoIcmsDoItemParaCalculoDoDifal(const AItens : TDadosFechamento): Double;
    function RetornaAliquotaDeIcmsDoItemParaCalculoDoDifal(const AItens : TDadosFechamento): Double;

  public
    function CalcularValorFcpDifalFinal: IResultadoCalculoFcpDifalFinal;

    constructor Create(var ADadosFechamento: TDadosFechamento); overload;

    destructor Destroy; override;

    class function New(var ADadosFechamento: TDadosFechamento): IImpostosFatControllerFcpDifal;
  end;

implementation

{ TImpostosFatControllerFcpDifal }

uses Controller.Faturamento.Interfaces.Cache;

function TImpostosFatControllerFcpDifal.CalcularValorFcpDifalFinal: IResultadoCalculoFcpDifalFinal;
var
  LResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal;
begin
  SetarParametrosFcpDifal;

  if not TControllerFaturamentoInterfacesCache.TryGetCache(FParametrosFcpDifal, LResultadoServicosClasseFcpDifal) then
  begin
    LResultadoServicosClasseFcpDifal := GetFaturamentoImpostosService.FcpDifal.CalcularValorFcpDifalFinal(FParametrosFcpDifal);
    TControllerFaturamentoInterfacesCache.AddOrSetCache(FParametrosFcpDifal, LResultadoServicosClasseFcpDifal);
  end;

  GerarLogTesteUnitario(LResultadoServicosClasseFcpDifal);

//  SetarValorFinalMatriz(LResultadoServicosClasseFcpDifal);

  Result := ResultadoValorFcpDifalFinal(LResultadoServicosClasseFcpDifal);
end;

constructor TImpostosFatControllerFcpDifal.Create(
  var ADadosFechamento: TDadosFechamento);
begin
  FDadosFechamento := ADadosFechamento;
end;

destructor TImpostosFatControllerFcpDifal.Destroy;
begin

  inherited;
end;

function TImpostosFatControllerFcpDifal.GerarLogDifal(
  const AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal): Boolean;
begin
  Result := False;

  If Not Assigned(AResultadoServicosClasseFcpDifal.ParametrosCalculoDifal) Then
    Exit;

  If Not Assigned(AResultadoServicosClasseFcpDifal.ResultadoCalculoDifal) Then
    Exit;

  Result := True;
end;

function TImpostosFatControllerFcpDifal.GerarLogDifalFcp(
  const AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal): Boolean;
begin
  Result := False;

  If Not Assigned(AResultadoServicosClasseFcpDifal.ParametrosCalculoDifalFcp) Then
    Exit;

  If Not Assigned(AResultadoServicosClasseFcpDifal.ResultadoCalculoDifalFcp) Then
    Exit;

  Result := True;
end;

function TImpostosFatControllerFcpDifal.GerarLogFcp(
  const AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal): Boolean;
begin
  Result := False;

  If Not Assigned(AResultadoServicosClasseFcpDifal.ParametrosCalculoFcp) Then
    Exit;

  If Not Assigned(AResultadoServicosClasseFcpDifal.ResultadoCalculoFcp) Then
    Exit;

  Result := True;
end;

procedure TImpostosFatControllerFcpDifal.GerarLogTesteUnitario(
  const AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal);
begin
  If GerarLogFcp(AResultadoServicosClasseFcpDifal) Then
  Begin
    pGerarLogTesteUnitario((AResultadoServicosClasseFcpDifal.ParametrosCalculoFcp as TObject), (AResultadoServicosClasseFcpDifal.ResultadoCalculoFcp as TObject), Nil, 'CalcularValorFCP');
    Exit;
  End;

  If GerarLogDifal(AResultadoServicosClasseFcpDifal) Then
  Begin
    pGerarLogTesteUnitario((AResultadoServicosClasseFcpDifal.ParametrosCalculoDifal as TObject), (AResultadoServicosClasseFcpDifal.ResultadoCalculoDifal as TObject), Nil, 'CalcularValorDifal');
  End;

  If GerarLogDifalFcp(AResultadoServicosClasseFcpDifal) Then
  Begin
    pGerarLogTesteUnitario((AResultadoServicosClasseFcpDifal.ParametrosCalculoDifalFcp as TObject), (AResultadoServicosClasseFcpDifal.ResultadoCalculoDifalFcp as TObject), Nil, 'CalcularValorFCPDifal');
  End;
end;

class function TImpostosFatControllerFcpDifal.New(var ADadosFechamento: TDadosFechamento): IImpostosFatControllerFcpDifal;
begin
  Result := Self.Create(ADadosFechamento);
end;

function TImpostosFatControllerFcpDifal.ResultadoValorFcpDifalFinal(
  const AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal): IResultadoCalculoFcpDifalFinal;
begin
  Result := AResultadoServicosClasseFcpDifal.ResultadoCalculoFcpDifalFinal;
end;

procedure TImpostosFatControllerFcpDifal.SetarParametrosFcpDifal;
begin
  FParametrosFcpDifal :=
    TParametrosServicoFcpDifal.New
      .CodigoDoItemDaAbreviacaoFiscal(FDadosFechamento.strIteAbf)
      .CodigoDaAbreviacaoFiscal(FDadosFechamento.strCodAbf)
      .SequencialEnderecoEntrega(GetImpostosFatParametrosComumFcpDifal.SequencialEnderecoEntrega)
      .TipoDaAbreviacaoFiscal(GetImpostosFatParametrosComumFcpDifal.TipoDaAbreviacaoFiscal)
      .VendaPresencial(GetImpostosFatParametrosComumFcpDifal.VendaPresencial)
      .ClienteConsumidorFinal(GetImpostosFatParametrosComumFcpDifal.ClienteConsumidorFinal)
      .NotaComplementoFornecedor(GetImpostosFatParametrosComumFcpDifal.NotaComplementoFornecedor)
      .NotaEspecialFornecedor(GetImpostosFatParametrosComumFcpDifal.NotaEspecialFornecedor)
      .CodigoDoCliente(GetImpostosFatParametrosComumFcpDifal.CodigoDoCliente)
      .CodigoDoFornecedor(GetImpostosFatParametrosComumFcpDifal.CodigoDoFornecedor)
      .ClienteFilial(GetImpostosFatParametrosComumFcpDifal.ClienteFilial)
      .OpcaoDeDocumento(GetImpostosFatParametrosComumFcpDifal.OpcaoDoDocumento)
      .CodigoDaSituacaoTributaria(FDadosFechamento.strCodSit)
      .BaseDeCalculoDoIcmsDoItem(RetornaBaseDeCalculoDoIcmsDoItemParaCalculoDoDifal(FDadosFechamento))
      .BaseDeCalculoDoIcmsDoItemBenST(FDadosFechamento.fltBasIcmBenST)
      .DocumentoDeDevolucao(Not TCoreFuncoes.fEmptyStr(FDadosFechamento.strDocDev))
      .DiferencaFCPST(GetImpostosFatParametrosComumFcpDifal.DiferencaFCPST)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(FDadosFechamento.fltBasRet)
      .CodigoDaSubstituicaoTributariaDoItem(FDadosFechamento.strCodFis)
      .RecordDifalFCP(FDadosFechamento.recDifalFCP)
      .ProdutoIndustrializado(FDadosFechamento.strIndRev = 'I')
      .ParametrosClienteConsumidor(GetImpostosFatParametrosComumFcpDifal.ParametrosClienteConsumidor)
      .CodigoDaEmpresa(GetImpostosFatParametrosComumFcpDifal.CodigoDaEmpresa)
      .ClassificacaoFiscalDoItem(FDadosFechamento.strClaFis)
      .CodigoDaEmpresaTE(GetImpostosFatParametrosComumFcpDifal.CodigoDaEmpresaTE)
      .AliquotaDeIcmsDoItem(RetornaAliquotaDeIcmsDoItemParaCalculoDoDifal(FDadosFechamento))
      .DataDoSistema(GetImpostosFatParametrosComumFcpDifal.DataDoSistema)
      .ClienteIndustria(GetImpostosFatParametrosComumFcpDifal.ClienteIndustria)
      .ClassificacaoFiscalRecebimentoGarantia(GetImpostosFatParametrosComumFcpDifal.ClassificacaoFiscalRecebimentoGarantia)
      .AliquotaFCPST(GetImpostosFatParametrosComumFcpDifal.AliquotaFCPST)
      .BaixaDeEntregaFutura(GetImpostosFatParametrosComumFcpDifal.BaixaDeEntregaFutura)
      .EspecieDoDocumento(GetImpostosFatParametrosComumFcpDifal.EspecieDoDocumento)
      .ValorDaSubstituicaoTributariaDoItem(FDadosFechamento.fltValRet)
      .EntregaFuturaDoItem(FDadosFechamento.strEntFut = 'S')
      .NumeroDoDocumentoDeDevolucao(FDadosFechamento.strDocDev)
      .EspecieDoDocumentoDeDevolucao(FDadosFechamento.strEspDev)
      .EmpresaDoDocumentoDeDevolucao(FDadosFechamento.strEmpDev)
      .CodigoDoItem(FDadosFechamento.strCodIte)
      .QuantidadeDoItem(FDadosFechamento.fltQtdIte)
      .OpcaoDeItemNfEspiritoSanto(FDadosFechamento.opcINFesp)
      .ValorDoIpi(FDadosFechamento.fltValIpi)
      .ValorDoFrete(FDadosFechamento.fltValFre)
      .ValorTotalDoItem(FDadosFechamento.fltTotIte)
      .DescontoEspecial(FDadosFechamento.fltDesEsp)
      .DespesasAcessorias(FDadosFechamento.fltDesAce)
      .PercentualBaseDoIcmsDoItem(FDadosFechamento.fltBas__S)
      .OpcaoDeDocumentoVerdadeira(GetImpostosFatParametrosComumFcpDifal.OpcaoDeDocumentoVerdadeira)
      .EntraIPInaBaseIcms(GetImpostosFatParametrosComumFcpDifal.EntraIPInaBaseIcms)
      .ValorDaSTDoItemNoFatuamentoConsignacao(FDadosFechamento.fltValorCalculadoSTConsignacao)
      .ClassificacaoFiscal(GetImpostosFatParametrosComumFcpDifal.ClassificacaoFiscal)
      .ProdutoEmbalagem(FDadosFechamento.strProEmb)
      .HabilitarNovoCalculoDifalComPercentualBase(GetImpostosFatParametrosComumFcpDifal.HabilitarNovoCalculoDifalComPercentualBase)  // Provisório feito para atender a necessidades dos clientes até o início da NT 2020.005
      .ProdutoRevenda(FDadosFechamento.strIndRev = 'R')
      .ProdutoImportacaoDireta(FDadosFechamento.strImpDir = 'S')
      .STAtribuidaPorRegimeEspecial(FDadosFechamento.blnSTAtribuidaPorRegimeEspecial)
      .CodigoDaEmpresaAbf(GetImpostosFatParametrosComumFcpDifal.CodigoDaEmpresaAbf)
      .CalculandoPrecoDeVendaComDifal(GetImpostosFatParametrosComumFcpDifal.CalculandoPrecoDeVendaComDifal)
      .CodigoDaFazenda(GetImpostosFatParametrosComumFcpDifal.CodigoDaFazenda)
      .CalculaDifalParaCombustiveis_e_LubrificantesNaoTributados(CalcularDifalParaCombustiveis_e_LubrificantesNaoTributados(FDadosFechamento));
end;

function TImpostosFatControllerFcpDifal.CalcularDifalParaCombustiveis_e_LubrificantesNaoTributados(const AItens : TDadosFechamento): Boolean;
begin
  Result := False;

  If not objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_DIFAL_PARA_PRODUTOS_ISENTOS_E_NAO_TRIBUTADOS_NO_ICMS, VarBoolean) Then
    Exit;

  If not (pos(RightStr(AItens.strCodFis, 2), '30_40_41_') > 0) Then
    Exit;

  Result := True;
end;

function TImpostosFatControllerFcpDifal.RetornaBaseDeCalculoDoIcmsDoItemParaCalculoDoDifal(const AItens : TDadosFechamento): Double;
begin
  Result := AItens.fltBasIcm;

  If (AItens.fltBasIcm > 0) Then
    Exit;

  If not CalcularDifalParaCombustiveis_e_LubrificantesNaoTributados(AItens) Then
    Exit;

  Result := (AItens.fltTotIte - AItens.fltDesEsp + AItens.fltValFre + AItens.fltDesAce);
end;

function TImpostosFatControllerFcpDifal.RetornaAliquotaDeIcmsDoItemParaCalculoDoDifal(const AItens : TDadosFechamento): Double;
begin
  Result := AItens.fltAlqIcm;

  If (AItens.fltAlqIcm > 0) Then
    Exit;

  If not CalcularDifalParaCombustiveis_e_LubrificantesNaoTributados(AItens) Then
    Exit;

  Result := AItens.fltAlqOrS;
end;

//procedure TImpostosFatControllerFcpDifal.SetarValorFinalMatriz(
//  const AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal);
//begin
//  //Fcp
//  FDadosFechamento.recDifalFCP := AResultadoServicosClasseFcpDifal.ResultadoCalculoFcp.RecordDifalFCP;
//end;

end.
