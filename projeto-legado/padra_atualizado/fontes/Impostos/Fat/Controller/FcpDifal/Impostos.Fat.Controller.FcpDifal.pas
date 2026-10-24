unit Impostos.Fat.Controller.FcpDifal;

interface

uses Impostos.Fat.Controller.Interfaces.FcpDifal, untFuncFatTypes,
  Faturamento.Impostos.Interfaces.FcpDifal, Faturamento.Impostos.Tipos.FcpDifal,
  Impostos.Fat.Parametros.Comum.Interfaces, Core.Funcoes, untFatCalcularImpostosService,
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
  public
    function CalcularValorFcpDifalFinal: IResultadoCalculoFcpDifalFinal;

    constructor Create(var ADadosFechamento: TDadosFechamento); overload;

    destructor Destroy; override;

    class function New(var ADadosFechamento: TDadosFechamento): IImpostosFatControllerFcpDifal;
  end;

implementation

{ TImpostosFatControllerFcpDifal }

function TImpostosFatControllerFcpDifal.CalcularValorFcpDifalFinal: IResultadoCalculoFcpDifalFinal;
var
  LResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal;
begin
  SetarParametrosFcpDifal;

  LResultadoServicosClasseFcpDifal := GetFaturamentoImpostosService.FcpDifal.CalcularValorFcpDifalFinal(FParametrosFcpDifal);

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
      .SequencialEnderecoEntrega(objImpostosFatParametrosComumFcpDifal.SequencialEnderecoEntrega)
      .TipoDaAbreviacaoFiscal(objImpostosFatParametrosComumFcpDifal.TipoDaAbreviacaoFiscal)
      .VendaPresencial(objImpostosFatParametrosComumFcpDifal.VendaPresencial)
      .ClienteConsumidorFinal(objImpostosFatParametrosComumFcpDifal.ClienteConsumidorFinal)
      .NotaComplementoFornecedor(objImpostosFatParametrosComumFcpDifal.NotaComplementoFornecedor)
      .NotaEspecialFornecedor(objImpostosFatParametrosComumFcpDifal.NotaEspecialFornecedor)
      .CodigoDoCliente(objImpostosFatParametrosComumFcpDifal.CodigoDoCliente)
      .CodigoDoFornecedor(objImpostosFatParametrosComumFcpDifal.CodigoDoFornecedor)
      .ClienteFilial(objImpostosFatParametrosComumFcpDifal.ClienteFilial)
      .OpcaoDeDocumento(objImpostosFatParametrosComumFcpDifal.OpcaoDoDocumento)
      .CodigoDaSituacaoTributaria(FDadosFechamento.strCodSit)
      .BaseDeCalculoDoIcmsDoItem(FDadosFechamento.fltBasIcm)
      .DocumentoDeDevolucao(Not TCoreFuncoes.fEmptyStr(FDadosFechamento.strDocDev))
      .DiferencaFCPST(objImpostosFatParametrosComumFcpDifal.DiferencaFCPST)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(FDadosFechamento.fltBasRet)
      .CodigoDaSubstituicaoTributariaDoItem(FDadosFechamento.strCodFis)
      .RecordDifalFCP(FDadosFechamento.recDifalFCP)
      .ProdutoIndustrializado(FDadosFechamento.strIndRev = 'I')
      .ParametrosClienteConsumidor(objImpostosFatParametrosComumFcpDifal.ParametrosClienteConsumidor)
      .CodigoDaEmpresa(objImpostosFatParametrosComumFcpDifal.CodigoDaEmpresa)
      .ClassificacaoFiscalDoItem(FDadosFechamento.strClaFis)
      .CodigoDaEmpresaTE(objImpostosFatParametrosComumFcpDifal.CodigoDaEmpresaTE)
      .AliquotaDeIcmsDoItem(FDadosFechamento.fltAlqIcm)
      .DataDoSistema(objImpostosFatParametrosComumFcpDifal.DataDoSistema)
      .ClienteIndustria(objImpostosFatParametrosComumFcpDifal.ClienteIndustria)
      .ClassificacaoFiscalRecebimentoGarantia(objImpostosFatParametrosComumFcpDifal.ClassificacaoFiscalRecebimentoGarantia)
      .AliquotaFCPST(objImpostosFatParametrosComumFcpDifal.AliquotaFCPST)
      .BaixaDeEntregaFutura(objImpostosFatParametrosComumFcpDifal.BaixaDeEntregaFutura)
      .EspecieDoDocumento(objImpostosFatParametrosComumFcpDifal.EspecieDoDocumento)
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
      .PercentualBaseDoIcmsDoItem(FDadosFechamento.fltBas__S);
end;

//procedure TImpostosFatControllerFcpDifal.SetarValorFinalMatriz(
//  const AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal);
//begin
//  //Fcp
//  FDadosFechamento.recDifalFCP := AResultadoServicosClasseFcpDifal.ResultadoCalculoFcp.RecordDifalFCP;
//end;

end.
