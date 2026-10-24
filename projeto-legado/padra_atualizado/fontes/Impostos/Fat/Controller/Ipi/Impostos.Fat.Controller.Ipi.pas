unit Impostos.Fat.Controller.Ipi;

interface

uses untFuncFatTypes, Impostos.Fat.Controller.Interfaces.Ipi,
  Faturamento.Impostos.Interfaces.Ipi,
  Shared.Functions.Types,
  Impostos.Fat.Parametros.Comum.Interfaces,
  untFatCalcularImpostosService,
  Faturamento.Impostos.Tipos.Ipi,
  Faturamento.Impostos.Interfaces.Model,
  Faturamento.Impostos.Tipos.Model,
  Faturamento.Impostos.Calculos.TesteUnitarioLog;

type
  TImpostosFatControllerIpi = class sealed(TInterfacedObject, IImpostosFatControllerIpi)
  private
    FMatItens: TMatrizFechamento;
    FPosicaoMat: Integer;
    FParametrosIpi: IParametrosServicoIPI;

    procedure SetarParametrosIpi; Overload;

    procedure SetarParametrosIpi(const AParametrosCalculoValorIpi: IParametrosCalculoValorIpi); Overload;

    procedure SetarValorFinalMatriz(AResultadoCalculoIPI: IResultadoCalculoIPI);
  public

    function CalcularValorIpi: IResultadoCalculoIPI; Overload;

    function CalcularValorIpi(const AParametrosCalculoValorIpi: IParametrosCalculoValorIpi): IResultadoCalculoIPI; Overload;

    function CalcularValorIpiFinal: Boolean;

    procedure ZerarDadosIpi(const AZerarAliquota: boolean);

    constructor Create(var AMatItens: TMatrizFechamento; const APosicaoMat: Integer); overload;
    destructor Destroy; override;
    class function New(var AMatItens: TMatrizFechamento; const APosicaoMat: Integer): IImpostosFatControllerIpi;
  end;

implementation

{ TImpostosFatControllerIpi }

function TImpostosFatControllerIpi.CalcularValorIpi: IResultadoCalculoIPI;
var
  LResultadoServicosClasseIpi: IResultadoServicosClasseIpi;
begin
  SetarParametrosIpi;

  LResultadoServicosClasseIpi := GetFaturamentoImpostosService.Ipi.CalcularValorIpi(FParametrosIpi);

  Result := LResultadoServicosClasseIpi.ResultadoCalculoIPI;

  pGerarLogTesteUnitario((LResultadoServicosClasseIpi.ParametrosCalculoIPI as TObject), (Result as TObject), Nil, 'CalcularValorIPI');
end;

function TImpostosFatControllerIpi.CalcularValorIpi(const AParametrosCalculoValorIpi: IParametrosCalculoValorIpi): IResultadoCalculoIPI;
var
  LResultadoServicosClasseIpi: IResultadoServicosClasseIpi;
begin
  SetarParametrosIpi(AParametrosCalculoValorIpi);

  LResultadoServicosClasseIpi := GetFaturamentoImpostosService.Ipi.CalcularValorIpiProduto(FParametrosIpi);

  Result := LResultadoServicosClasseIpi.ResultadoCalculoIPI;

  pGerarLogTesteUnitario((LResultadoServicosClasseIpi.ParametrosCalculoIPI as TObject), (Result as TObject), Nil, 'CalcularValorIPI');
end;

function TImpostosFatControllerIpi.CalcularValorIpiFinal: Boolean;
var
  LResultadoServicosClasseIpi: IResultadoServicosClasseIpi;
begin
  Result := True;

  SetarParametrosIpi;

  LResultadoServicosClasseIpi := GetFaturamentoImpostosService.Ipi.CalcularValorIpiFinal(FParametrosIpi);

  SetarValorFinalMatriz(LResultadoServicosClasseIpi.ResultadoCalculoIPI);

  pGerarLogTesteUnitario((LResultadoServicosClasseIpi.ParametrosCalculoIPI as TObject), (LResultadoServicosClasseIpi.ResultadoCalculoIPI as TObject), Nil, 'CalcularValorIPI');
end;

constructor TImpostosFatControllerIpi.Create(var AMatItens: TMatrizFechamento; const APosicaoMat: Integer);
begin
  FMatItens := AMatItens;
  FPosicaoMat := APosicaoMat;
//  SetarParametrosIpi;
end;

destructor TImpostosFatControllerIpi.Destroy;
begin
  FMatItens := Nil;
  inherited;
end;

class function TImpostosFatControllerIpi.New(var AMatItens: TMatrizFechamento; const APosicaoMat: Integer): IImpostosFatControllerIpi;
begin
  Result := Self.Create(AMatItens, APosicaoMat);
end;

procedure TImpostosFatControllerIpi.SetarParametrosIpi;
begin
  FParametrosIpi :=
    TParametrosServicoIPI.New
      .CodigoDoCliente(objImpostosFatParametrosComum.CodigoDoCliente)
      .ClienteConsumidorFinal(objImpostosFatParametrosComum.ClienteConsumidorFinal)
      .CodigoDoProduto(FMatItens[FPosicaoMat].strCodIte)
      .CodigoDaEmpresa(objImpostosFatParametrosComum.CodigoDaEmpresa)
      .SequencialEnderecoEntrega(objImpostosFatParametrosComum.SequencialEnderecoEntrega)
      .ClassificacaoFiscalDoItem(FMatItens[FPosicaoMat].strClaFis)
      .VendaPresencial(objImpostosFatParametrosComum.VendaPresencial)
      .EspecieDoDocumento(objImpostosFatParametrosComum.EspecieDoDocumento)
      .DesmembrarNotaProdutosServicos(objImpostosFatParametrosComum.DesmembrarNotaProdutosServicos)
      .OpcaoDoDocumento(objImpostosFatParametrosComum.OpcaoDoDocumento)
      .OpcaoDeItemNfEspiritoSanto(FMatItens[FPosicaoMat].opcINFesp)
      .DesmembrarMeiaNotaComNotaNormal(objImpostosFatParametrosComum.DesmembrarMeiaNotaComNotaNormal)
      .BaixaDeEntregaFutura(objImpostosFatParametrosComum.BaixaDeEntregaFutura)
      .EntregaFutura(objImpostosFatParametrosComum.EntregaFutura)
      .MeiaNotaFatorExpedicao(FMatItens[FPosicaoMat].blnMeiaNotaFatorExpedicao)
      .TotalGeralDoItem(FMatItens[FPosicaoMat].fltTotIte)
      .ValorFreteDoItem(FMatItens[FPosicaoMat].fltValFre)
      .DespesaAcessoriaDoItem(FMatItens[FPosicaoMat].fltDesAce)
      .DescontoEspecial(FMatItens[FPosicaoMat].fltDesEsp)
      .NotaComplementoFornecedor(objImpostosFatParametrosComum.NotaComplementoFornecedor)
      .NotaEspecialFornecedor(objImpostosFatParametrosComum.NotaEspecialFornecedor)
      .CodigoDoFornecedor(objImpostosFatParametrosComum.CodigoDoFornecedor)
      .EspecieDeDevolucao(FMatItens[FPosicaoMat].strEspDev)
      .ParametrosClienteConsumidor(objImpostosFatParametrosComum.ParametrosClienteConsumidor);
end;


procedure TImpostosFatControllerIpi.SetarParametrosIpi(const AParametrosCalculoValorIpi: IParametrosCalculoValorIpi);
begin
  FParametrosIpi :=
    TParametrosServicoIPI.New
      .CodigoDoCliente(AParametrosCalculoValorIpi.CodigoDoCliente)
      .ClienteConsumidorFinal(AParametrosCalculoValorIpi.ClienteConsumidorFinal)
      .CodigoDoProduto(AParametrosCalculoValorIpi.CodigoDoProduto)
      .CodigoDaEmpresa(AParametrosCalculoValorIpi.CodigoDaEmpresa)
      .ClassificacaoFiscalDoItem('')
      .VendaPresencial(false)
      .EspecieDoDocumento('')
      .DesmembrarNotaProdutosServicos(false)
      .OpcaoDoDocumento('')
      .OpcaoDeItemNfEspiritoSanto(opcVazio)
      .DesmembrarMeiaNotaComNotaNormal(false)
      .BaixaDeEntregaFutura(AParametrosCalculoValorIpi.BaixaDeEntregaFutura)
      .EntregaFutura(false)
      .MeiaNotaFatorExpedicao(false)
      .TotalGeralDoItem(AParametrosCalculoValorIpi.TotalGeralDoItem)
      .ValorFreteDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .DescontoEspecial(0)
      .SequencialEnderecoEntrega('')
      .NotaComplementoFornecedor(false)
      .NotaEspecialFornecedor(false)
      .CodigoDoFornecedor('');
end;

procedure TImpostosFatControllerIpi.SetarValorFinalMatriz(
  AResultadoCalculoIPI: IResultadoCalculoIPI);
begin
  FMatItens[FPosicaoMat].fltValIpi := AResultadoCalculoIPI.ValorCalculadoIPI;
  FMatItens[FPosicaoMat].fltBasIpi := AResultadoCalculoIPI.BaseDeCalculoIPI;
  FMatItens[FPosicaoMat].fltAlqIpi := AResultadoCalculoIPI.AliquotaDeCalculoIPI;
end;

procedure TImpostosFatControllerIpi.ZerarDadosIpi(const AZerarAliquota: boolean);
begin
  FMatItens[FPosicaoMat].fltValIpi := 0;
  FMatItens[FPosicaoMat].fltBasIpi := 0;

  if (not AZerarAliquota) then
    Exit;

  FMatItens[FPosicaoMat].fltAlqIpi := 0;
end;  

end.
