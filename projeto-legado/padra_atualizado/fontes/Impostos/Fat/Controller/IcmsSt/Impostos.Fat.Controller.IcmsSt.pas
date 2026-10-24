unit Impostos.Fat.Controller.IcmsSt;

interface

uses untFuncFatTypes, Impostos.Fat.Controller.Interfaces.IcmsSt,
  Faturamento.Impostos.Interfaces.Icms,
  Shared.Functions.Types,
  Impostos.Fat.Parametros.Comum.Interfaces,
  untFatCalcularImpostosService,
  Faturamento.Impostos.Tipos.Icms,
  Faturamento.Impostos.Calculos.TesteUnitarioLog,
  Faturamento.Impostos.Interfaces.Model,
  Faturamento.Impostos.Tipos.Model,
  Faturamento.Impostos.Interfaces.IcmsSt,
  Faturamento.Impostos.Tipos.IcmsSt,
  Faturamento.Impostos.Interfaces.ST,
  Impostos.Fat.Controller.Tipos.IcmsSt;

type
  TImpostosFatControllerIcmsSt = class(TInterfacedObject, IImpostosFatControllerIcmsSt)
  private
    FMatItens: TMatrizFechamento;
    FPosicaoMat: Integer;
    FParametrosIcmsSt: IParametrosServicoIcmsSt;

    procedure SetarParametrosIcmsSt; Overload;

    procedure SetarParametrosIcmsSt(const AParametrosCalculoValorIcmsSt: IParametrosCalculoValorIcmsSt); Overload;


    procedure SetarValorFinalMatriz(const AResultadoServicosClasseIcmsSt: IResultadoServicosClasseIcmsSt);

    procedure GerarLogTesteUnitario(const AResultadoServicosClasseIcmsSt: IResultadoServicosClasseIcmsSt);

    function ResultadoValorIcmsStFinal(const AResultadoServicosClasseIcmsSt: IResultadoServicosClasseIcmsSt): IResultadoImpostosFatControllerIcmsSt;

    function ResultadoDoCalculoIcmsSt(const AResultadoServicosClasseIcmsSt: IResultadoServicosClasseIcmsSt): IResultadoCalculoIcmsSt;
  public
    function CalcularValorIcmsSt: IResultadoCalculoIcmsSt; Overload;

    function CalcularValorIcmsSt(const AParametrosCalculoValorIcmsSt: IParametrosCalculoValorIcmsSt): IResultadoCalculoIcmsSt; Overload;

    function CalcularValorIcmsStFinal: IResultadoImpostosFatControllerIcmsSt;

    procedure ZerarValorIcms;
    procedure ZerarDadosIcms(const AZerarPerBas: boolean);
    procedure ZerarDadosSt;
    procedure ZerarDadosDoOrgaoPublicoDeTodosOsItens;

    Function ItemReducaoRICMPR(Const ARICMPR : String) : String;

    constructor Create(var AMatItens: TMatrizFechamento; const APosicaoMat: Integer); overload;

    destructor Destroy; override;

    class function New(var AMatItens: TMatrizFechamento; const APosicaoMat: Integer): IImpostosFatControllerIcmsSt;
  end;

implementation

{ TImpostosFatControllerIcms }

function TImpostosFatControllerIcmsSt.CalcularValorIcmsSt(const AParametrosCalculoValorIcmsSt: IParametrosCalculoValorIcmsSt): IResultadoCalculoIcmsSt;
Var
  LResultadoServicosClasseIcmsSt : IResultadoServicosClasseIcmsSt;
begin
  SetarParametrosIcmsSt(AParametrosCalculoValorIcmsSt);

  LResultadoServicosClasseIcmsSt := GetFaturamentoImpostosService.IcmsSt.CalcularValorIcmsSt(FParametrosIcmsSt);

  GerarLogTesteUnitario(LResultadoServicosClasseIcmsSt);

  Result := ResultadoDoCalculoIcmsSt(LResultadoServicosClasseIcmsSt);
end;

function TImpostosFatControllerIcmsSt.CalcularValorIcmsSt: IResultadoCalculoIcmsSt;
var
  LResultadoServicosClasseIcmsSt: IResultadoServicosClasseIcmsSt;
begin
  SetarParametrosIcmsSt;

  LResultadoServicosClasseIcmsSt := GetFaturamentoImpostosService.IcmsSt.CalcularValorIcmsSt(FParametrosIcmsSt);

  GerarLogTesteUnitario(LResultadoServicosClasseIcmsSt);

  Result := ResultadoDoCalculoIcmsSt(LResultadoServicosClasseIcmsSt);
end;

function TImpostosFatControllerIcmsSt.CalcularValorIcmsStFinal: IResultadoImpostosFatControllerIcmsSt;
var
  LResultadoServicosClasseIcmsSt: IResultadoServicosClasseIcmsSt;
begin
  SetarParametrosIcmsSt;

  LResultadoServicosClasseIcmsSt := GetFaturamentoImpostosService.IcmsSt.CalcularValorIcmsStFinal(FParametrosIcmsSt);

  GerarLogTesteUnitario(LResultadoServicosClasseIcmsSt);

  SetarValorFinalMatriz(LResultadoServicosClasseIcmsSt);

  Result := ResultadoValorIcmsStFinal(LResultadoServicosClasseIcmsSt);
end;

constructor TImpostosFatControllerIcmsSt.Create(var AMatItens: TMatrizFechamento;
  const APosicaoMat: Integer);
begin
  FMatItens := AMatItens;
  FPosicaoMat := APosicaoMat;
end;

destructor TImpostosFatControllerIcmsSt.Destroy;
begin
  FMatItens := Nil;
  inherited;
end;

procedure TImpostosFatControllerIcmsSt.GerarLogTesteUnitario(
  const AResultadoServicosClasseIcmsSt: IResultadoServicosClasseIcmsSt);
begin
  pGerarLogTesteUnitario((AResultadoServicosClasseIcmsSt.ParametrosCalculoIcms as TObject), (AResultadoServicosClasseIcmsSt.ResultadoCalculoIcms as TObject), Nil, 'CalcularValorIcms');
  pGerarLogTesteUnitario((AResultadoServicosClasseIcmsSt.ParametrosCalculoSt as TObject), (AResultadoServicosClasseIcmsSt.ResultadoCalculoSt as TObject), Nil, 'CalcularValorST');
  pGerarLogTesteUnitario((AResultadoServicosClasseIcmsSt.ParametrosCalculoIcmsOrgaoPublico as TObject), (AResultadoServicosClasseIcmsSt.ResultadoCalculoIcmsOrgaoPublico as TObject), Nil, 'CalcularValorIcmsOrgaoPublico');
  pGerarLogTesteUnitario((AResultadoServicosClasseIcmsSt.ParametrosCalculoStCustoAquisicao as TObject), (AResultadoServicosClasseIcmsSt.ResultadoCalculoStCustoAquisicao as TObject), Nil, 'CalcularValorSTCustoAquisicao');
end;

function TImpostosFatControllerIcmsSt.ItemReducaoRICMPR(
  const ARICMPR: String): String;
begin
  Result := ARICMPR;

  If ARICMPR = 'S' Then
    Exit;

  Result := FMatItens[FPosicaoMat].strRICMPR;
end;

class function TImpostosFatControllerIcmsSt.New(var AMatItens: TMatrizFechamento;
  const APosicaoMat: Integer): IImpostosFatControllerIcmsSt;
begin
  Result := Self.Create(AMatItens, APosicaoMat);
end;

function TImpostosFatControllerIcmsSt.ResultadoDoCalculoIcmsSt(
  const AResultadoServicosClasseIcmsSt: IResultadoServicosClasseIcmsSt): IResultadoCalculoIcmsSt;
begin
  Result :=
    TResultadoCalculoIcmsSt.New
      .ResultadoCalculoIcms(AResultadoServicosClasseIcmsSt.ResultadoCalculoIcms)
      .ResultadoCalculoSt(AResultadoServicosClasseIcmsSt.ResultadoCalculoSt)
      .ResultadoCalculoIcmsOrgaoPublico(AResultadoServicosClasseIcmsSt.ResultadoCalculoIcmsOrgaoPublico)
      .ResultadoCalculoBeneficioREIDI(AResultadoServicosClasseIcmsSt.ResultadoCalculoBeneficioREIDI)
      .ResultadoCalculoStCustoAquisicao(AResultadoServicosClasseIcmsSt.ResultadoCalculoStCustoAquisicao);
end;

function TImpostosFatControllerIcmsSt.ResultadoValorIcmsStFinal(
  const AResultadoServicosClasseIcmsSt: IResultadoServicosClasseIcmsSt): IResultadoImpostosFatControllerIcmsSt;
begin
  Result :=
    TResultadoImpostosFatControllerIcmsSt.New
      .BaseDaSubstituicaoTributariaSimulada(AResultadoServicosClasseIcmsSt.ResultadoCalculoSt.BaseDaSubstituicaoTributariaSimulada)
      .AliquotaDaSubstituicaoTributariaSimulada(AResultadoServicosClasseIcmsSt.ResultadoCalculoSt.AliquotaDaSubstituicaoTributariaSimulada)
      .ValorDaSubstituicaoTributariaSimulada(AResultadoServicosClasseIcmsSt.ResultadoCalculoSt.ValorDaSubstituicaoTributariaSimulada)
      .BaseDeIcmsDeOrgaoPublicoDoItem(AResultadoServicosClasseIcmsSt.ResultadoCalculoIcmsOrgaoPublico.BaseDeIcmsDeOrgaoPublicoDoItem)
      .ValorDoIcmsDeOrgaoPublicoDoItem(AResultadoServicosClasseIcmsSt.ResultadoCalculoIcmsOrgaoPublico.ValorDoIcmsDeOrgaoPublicoDoItem)
      .TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao(AResultadoServicosClasseIcmsSt.ResultadoCalculoIcmsOrgaoPublico.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao)
      .TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao(AResultadoServicosClasseIcmsSt.ResultadoCalculoIcmsOrgaoPublico.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao)
      .ValorDoDescontoBeneficioREIDI(AResultadoServicosClasseIcmsSt.ResultadoCalculoBeneficioREIDI.ValorDoDescontoBeneficioREIDI)
      .BaseDaSTCustoAquisicao(AResultadoServicosClasseIcmsSt.ResultadoCalculoStCustoAquisicao.BaseDaSTCustoAquisicao)
      .ValorDaSTCustoAquisicao(AResultadoServicosClasseIcmsSt.ResultadoCalculoStCustoAquisicao.ValorDaSTCustoAquisicao)
      .FatorPositivo(AResultadoServicosClasseIcmsSt.ResultadoCalculoStCustoAquisicao.FatorPositivo)
      .FatorNegativo(AResultadoServicosClasseIcmsSt.ResultadoCalculoStCustoAquisicao.FatorNegativo);
end;

procedure TImpostosFatControllerIcmsSt.SetarParametrosIcmsSt(const AParametrosCalculoValorIcmsSt: IParametrosCalculoValorIcmsSt);
Var
  FMetodoArredondamentoICMSECF: TMetodoArredondamentoICMSECF;
begin
  FMetodoArredondamentoICMSECF := Nil;

  FParametrosIcmsSt :=
    TParametrosServicoIcmsSt.New
      .CodigoDoCliente(AParametrosCalculoValorIcmsSt.CodigoDoCliente)
      .ClienteConsumidorFinal(AParametrosCalculoValorIcmsSt.ClienteConsumidorFinal)
      .CodigoDoProduto(AParametrosCalculoValorIcmsSt.CodigoDoProduto)
      .CodigoDaEmpresa(AParametrosCalculoValorIcmsSt.CodigoDaEmpresa)
      .TaxaBombeamentoPedidoOrcamento(false)
      .BaixaDeEntregaFutura(false)
      .OpcaoDeItemNfEspiritoSanto(opcVazio)
      .EntregaFuturaDoItem(false)
      .TotalGeralDoItem(AParametrosCalculoValorIcmsSt.TotalGeralDoItem)
      .ValorFreteDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .DescontoEspecial(0)
      .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF)
      .ClienteIndustria(AParametrosCalculoValorIcmsSt.ClienteIndustria)
      .ClienteComercializacao(AParametrosCalculoValorIcmsSt.ClienteComercializacao)
      .NotaComplementoFornecedor(false)
      .NotaEspecialFornecedor(false)
      .CodigoDoFornecedor('')
      .CodigoDoFornecedorDoItem('')
      .SequencialEnderecoEntrega('')
      .OpcaoDoDocumento('')
      .EspecieDocumento('')
      .ClassificacaoFiscalDoItem('')
      .VendaPresencial(true)
      .CodigoDaSituacaoTributaria('')
      .CodigoDaEmpresaTE('')
      .AliquotaDeIcmsDoItem(0)
      .TipoOperacaoPedidoVenda('')
      .UtilizaSat(False)
      .CalcularSatEcf(False)  // Esse parametro será utilizado quando não quiser verificar ecf
      .ValorUnitarioDoItem(0)
      .QuantidadeDoItem(0)
      .EspecieDeDevolucao('')
      .DesmembrarNotaProdutosServicos(False)
      .DesmembrarMeiaNotaComNotaNormal(False)
      .MeiaNotaFatorExpedicao(False)
      .PrecoDeCustoDoItem(0)
      .PrecoDeUltimaCompraDoItem(0)
      .PrecoEImpostosDeUltimaCompraDoItem(0)
      .PercentualDoFcpDoItem(0)
      .ValorDoFcpDoItem(0)
      .TipoDePedidoFaturamento('')
      .IdePro('NOR')
      .PrecoDeCompraDaTinta(0)
      .PrecoDeCustoDoItemSemImpostos(0)
      .OrigemF11(False)
      .CodigoDaEmpresaOriginal('')
      .NumeroDoOrcamento('');
end;

procedure TImpostosFatControllerIcmsSt.SetarValorFinalMatriz(const AResultadoServicosClasseIcmsSt: IResultadoServicosClasseIcmsSt);
begin
  //Icms
  FMatItens[FPosicaoMat].fltAlqIcm := AResultadoServicosClasseIcmsSt.ResultadoCalculoIcms.AliquotaDoIcms;
  FMatItens[FPosicaoMat].fltBasIcm := AResultadoServicosClasseIcmsSt.ResultadoCalculoIcms.BaseDeCalculoDoIcms;
  FMatItens[FPosicaoMat].fltValIcm := AResultadoServicosClasseIcmsSt.ResultadoCalculoIcms.ValorCalculadoDoIcms;
  FMatItens[FPosicaoMat].fltPerBas := AResultadoServicosClasseIcmsSt.ResultadoCalculoIcms.PercentualDaBaseDeIcms;
  FMatItens[FPosicaoMat].fltValDif := AResultadoServicosClasseIcmsSt.ResultadoCalculoIcms.ValorDaDiferencaDeIcms;
  FMatItens[FPosicaoMat].fltAlqAnt := AResultadoServicosClasseIcmsSt.ResultadoCalculoIcms.AliquotaDeIcmsAnterior;
  FMatItens[FPosicaoMat].fltBIcAnt := AResultadoServicosClasseIcmsSt.ResultadoCalculoIcms.BaseDeCalculoDoIcmsAnterior;
  FMatItens[FPosicaoMat].fltIcmAnt := AResultadoServicosClasseIcmsSt.ResultadoCalculoIcms.ValorDoIcmsAnterior;
  FMatItens[FPosicaoMat].fltPerRed := AResultadoServicosClasseIcmsSt.ResultadoCalculoIcms.PercentualDeReducaoDaBaseDeIcms;
  FMatItens[FPosicaoMat].strRICMPR := AResultadoServicosClasseIcmsSt.ResultadoCalculoIcms.ReducaoRICMPR;
  //St
  FMatItens[FPosicaoMat].fltBasRet := AResultadoServicosClasseIcmsSt.ResultadoCalculoST.BaseDeCalculoDaSubstituicaoTributariaDoItem;
  FMatItens[FPosicaoMat].fltValRet := AResultadoServicosClasseIcmsSt.ResultadoCalculoST.ValorDaSubstituicaoTributariaDoItem;
  FMatItens[FPosicaoMat].recDifalFCP.fltPerFcp := AResultadoServicosClasseIcmsSt.ResultadoCalculoST.PercentualDoFCPDoItem;
  FMatItens[FPosicaoMat].recDifalFCP.fltValFcp := AResultadoServicosClasseIcmsSt.ResultadoCalculoST.ValorDoFCPDoItem;
  FMatItens[FPosicaoMat].fltValIva := AResultadoServicosClasseIcmsSt.ResultadoCalculoSt.ValorDoIvaMatriz;
  FMatItens[FPosicaoMat].fltIVA_ST := AResultadoServicosClasseIcmsSt.ResultadoCalculoSt.ValorDoIvaStMatriz;

  FMatItens[FPosicaoMat].fltAlqRet := AResultadoServicosClasseIcmsSt.ResultadoRegrasTributacaoDepoisDoCalculo.AliquotaDaSubstituicaoTributariaDoItem;
  FMatItens[FPosicaoMat].fltPeBaST := AResultadoServicosClasseIcmsSt.ResultadoRegrasTributacaoDepoisDoCalculo.PercentualDaBaseDaSubstituicaoTributariaDoItem;
  //Icms Orgao Publico
  FMatItens[FPosicaoMat].fltBasOrg := AResultadoServicosClasseIcmsSt.ResultadoCalculoIcmsOrgaoPublico.BaseDeIcmsDeOrgaoPublicoDoItem;
  FMatItens[FPosicaoMat].fltIcmOrg := AResultadoServicosClasseIcmsSt.ResultadoCalculoIcmsOrgaoPublico.ValorDoIcmsDeOrgaoPublicoDoItem;
  //CodFis
  FMatItens[FPosicaoMat].strCodFis := AResultadoServicosClasseIcmsSt.CodigoDaSubstituicaoTributariaDoItem;
  //St Custo Aquisicao
  FMatItens[FPosicaoMat].fltBaRtSp := AResultadoServicosClasseIcmsSt.ResultadoCalculoStCustoAquisicao.BaseDaSTCustoAquisicao;
  FMatItens[FPosicaoMat].fltVaRtSp := AResultadoServicosClasseIcmsSt.ResultadoCalculoStCustoAquisicao.ValorDaSTCustoAquisicao;
  FMatItens[FPosicaoMat].fltIcOpPr := AResultadoServicosClasseIcmsSt.ResultadoCalculoStCustoAquisicao.ValorDoIcmsOperacoesProprias;
end;

procedure TImpostosFatControllerIcmsSt.ZerarDadosIcms(const AZerarPerBas: boolean);
begin

  FMatItens[FPosicaoMat].fltAlqIcm := 0.0;
  FMatItens[FPosicaoMat].fltBasIcm := 0.0;
  FMatItens[FPosicaoMat].fltValIcm := 0.0;

  if (not AZerarPerBas) then
    Exit;

  FMatItens[FPosicaoMat].fltPerBas := 0.0;
end;

procedure TImpostosFatControllerIcmsSt.ZerarDadosDoOrgaoPublicoDeTodosOsItens;
var
  LContador: integer;
begin
  For LContador := 0 To Length(FMatItens) -1 Do
  Begin
    FMatItens[LContador].fltBasOrg := 0.00;
    FMatItens[LContador].fltIcmOrg := 0.00;
  End;
end;

procedure TImpostosFatControllerIcmsSt.ZerarDadosSt;
begin
  FMatItens[FPosicaoMat].fltBasRet := 0.0;
  FMatItens[FPosicaoMat].fltValRet := 0.0;
end;

procedure TImpostosFatControllerIcmsSt.ZerarValorIcms;
begin
  FMatItens[FPosicaoMat].fltValIcm := 0.0;
end;

procedure TImpostosFatControllerIcmsSt.SetarParametrosIcmsSt;
begin
  FParametrosIcmsSt :=
    TParametrosServicoIcmsSt.New
      .CodigoDoCliente(objImpostosFatParametrosComum.CodigoDoCliente)
      .ClienteConsumidorFinal(objImpostosFatParametrosComum.ClienteConsumidorFinal)
      .CodigoDoProduto(FMatItens[FPosicaoMat].strCodIte)
      .CodigoDaEmpresa(objImpostosFatParametrosComum.CodigoDaEmpresa)
      .TaxaBombeamentoPedidoOrcamento(objImpostosFatParametrosComum.TaxaBombeamentoPedidoOrcamento)
      .BaixaDeEntregaFutura(objImpostosFatParametrosComum.BaixaDeEntregaFutura)
      .OpcaoDeItemNfEspiritoSanto(FMatItens[FPosicaoMat].opcINFesp)
      .EntregaFuturaDoItem(FMatItens[FPosicaoMat].strEntFut = 'S')
      .TotalGeralDoItem(FMatItens[FPosicaoMat].fltTotIte)
      .ValorFreteDoItem(FMatItens[FPosicaoMat].fltValFre)
      .DespesaAcessoriaDoItem(FMatItens[FPosicaoMat].fltDesAce)
      .DescontoEspecial(FMatItens[FPosicaoMat].fltDesEsp)
      .MetodoArredondamentoICMSECF(objImpostosFatParametrosComum.MetodoArredondamentoICMSECF)
      .NotaComplementoFornecedor(objImpostosFatParametrosComum.NotaComplementoFornecedor)
      .NotaEspecialFornecedor(objImpostosFatParametrosComum.NotaEspecialFornecedor)
      .CodigoDoFornecedor(objImpostosFatParametrosComum.CodigoDoFornecedor)
      .CodigoDoFornecedorDoItem(FMatItens[FPosicaoMat].strCodFor)
      .SequencialEnderecoEntrega(objImpostosFatParametrosComum.SequencialEnderecoEntrega)
      .OpcaoDoDocumento(objImpostosFatParametrosComum.OpcaoDoDocumento)
      .EspecieDocumento(objImpostosFatParametrosComum.EspecieDoDocumento)
      .ClassificacaoFiscalDoItem(FMatItens[FPosicaoMat].strClaFis)
      .VendaPresencial(objImpostosFatParametrosComum.VendaPresencial)
      .CodigoDaSituacaoTributaria(FMatItens[FPosicaoMat].strCodSit)
      .CodigoDaEmpresaTE(objImpostosFatParametrosComum.CodigoDaEmpresaTE)
      .AliquotaDeIcmsDoItem(FMatItens[FPosicaoMat].fltAlq__S)
      .TipoOperacaoPedidoVenda(objImpostosFatParametrosComum.TipoOperacaoPedidoVenda)
      .ClienteIndustria(objImpostosFatParametrosComum.ClienteIndustria)
      .ClienteComercializacao(objImpostosFatParametrosComum.ClienteComercializacao)
      .UtilizaSat(objImpostosFatParametrosComum.UtilizaSat)
      .CalcularSatEcf(objImpostosFatParametrosComum.CalcularSatEcf)  // Esse parametro será utilizado quando não quiser verificar ecf
      .ValorUnitarioDoItem(FMatItens[FPosicaoMat].fltUniTar)
      .QuantidadeDoItem(FMatItens[FPosicaoMat].fltQtdIte)
      .EspecieDeDevolucao(FMatItens[FPosicaoMat].strEspDev)
      .DesmembrarNotaProdutosServicos(objImpostosFatParametrosComum.DesmembrarNotaProdutosServicos)
      .DesmembrarMeiaNotaComNotaNormal(objImpostosFatParametrosComum.DesmembrarMeiaNotaComNotaNormal)
      .MeiaNotaFatorExpedicao(FMatItens[FPosicaoMat].blnMeiaNotaFatorExpedicao)
      .PrecoDeCustoDoItem(FMatItens[FPosicaoMat].fltPreCus)
      .PrecoDeUltimaCompraDoItem(FMatItens[FPosicaoMat].fltPreUlt)
      .PrecoEImpostosDeUltimaCompraDoItem(FMatItens[FPosicaoMat].fltImpUlt)
      .PercentualDoFcpDoItem(FMatItens[FPosicaoMat].recDifalFCP.fltPerFcp)
      .ValorDoFcpDoItem(FMatItens[FPosicaoMat].recDifalFCP.fltValFcp)
      .TipoDePedidoFaturamento(objImpostosFatParametrosComum.TipoDePedidoFaturamento)
      .IdePro(FMatItens[FPosicaoMat].strIdePro)
      .PrecoDeCompraDaTinta(FMatItens[FPosicaoMat].fltPrcTin)
      .PrecoDeCustoDoItemSemImpostos(FMatItens[FPosicaoMat].fltCusIte)
      .OrigemF11(objImpostosFatParametrosComum.OrigemF11)
      .CodigoDaEmpresaOriginal(objImpostosFatParametrosComum.CodigoDaEmpresaOriginal)
      .NumeroDoOrcamento(objImpostosFatParametrosComum.NumeroDoOrcamento)
      .ParametrosClienteConsumidor(objImpostosFatParametrosComum.ParametrosClienteConsumidor)
      .ClassificacaoDeIpi(FMatItens[FPosicaoMat].strClaIpi);
end;


end.
