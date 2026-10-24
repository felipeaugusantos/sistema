unit Impostos.Fat.Controller.IcmsEfetivo;

interface

uses
  untFuncFatTypes,
  Impostos.Fat.Controller.Interfaces.IcmsEfetivo,
  Faturamento.Impostos.Interfaces.IcmsEfetivo,
  Shared.Functions.Types,
  Shared.Functions.Constantes,
  Impostos.Fat.Parametros.Comum.Interfaces,
  untFatCalcularImpostosService,
  Shared.Functions.Funcoes.Faturamento,
  Faturamento.Impostos.Tipos.IcmsEfetivo,
  Faturamento.Impostos.Interfaces.Model,
  Faturamento.Impostos.Tipos.Model,
  Faturamento.Impostos.Calculos.TesteUnitarioLog;

type
  TImpostosFatControllerIcmsEfetivo = class sealed(TInterfacedObject, IImpostosFatControllerIcmsEfetivo)
  private
    FMatItens            : TMatrizFechamento;
    FMatItensIcmsEfetivo : TMatrizFechamentoIcmsEfetivo;

    FParametrosIcmsEfetivo: IParametrosServicoIcmsEfetivo;

    procedure SetarParametrosIcmsEfetivo; Overload;

    procedure SetarParametrosIcmsEfetivo(const AParametrosCalculoValorIcmsEfetivo: IParametrosCalculoValorIcmsEfetivo); Overload;

    procedure SetarValorFinalMatriz(AResultadoCalculoIcmsEfetivo: TMatrizFechamentoIcmsEfetivo);

    procedure PreencherVetorItens;
    procedure ZerarValoresMatriz;
    function CalculouIcmsEfetivo(Const AResultado : IResultadoServicosClasseIcmsEfetivo): Boolean;

  public
    function CalcularValorIcmsEfetivo: TMatrizFechamentoIcmsEfetivo; Overload;

    function CalcularValorIcmsEfetivo(const AParametrosCalculoValorIcmsEfetivo: IParametrosCalculoValorIcmsEfetivo): TMatrizFechamentoIcmsEfetivo; Overload;

    constructor Create(var AMatItens: TMatrizFechamento); overload;

    destructor Destroy; override;

    class function New(var AMatItens: TMatrizFechamento): IImpostosFatControllerIcmsEfetivo;
  end;

implementation

{ TImpostosFatControllerIcmsEfetivo }

function TImpostosFatControllerIcmsEfetivo.CalculouIcmsEfetivo(Const AResultado : IResultadoServicosClasseIcmsEfetivo) : Boolean;
begin
  Result := (AResultado <> Nil) ;
end;

function TImpostosFatControllerIcmsEfetivo.CalcularValorIcmsEfetivo: TMatrizFechamentoIcmsEfetivo;
var
  LResultadoMatrizIcmsEfetivo  : IResultadoServicosClasseIcmsEfetivo;
  LResultadoCalculoIcmsEfetivo : IResultadoCalculoIcmsEfetivo;
  LContador : Integer;
begin
  SetarParametrosIcmsEfetivo;

  LResultadoMatrizIcmsEfetivo:= GetFaturamentoImpostosService.IcmsEfetivo.CalcularValorIcmsEfetivo(FParametrosIcmsEfetivo);

  if Not CalculouIcmsEfetivo(LResultadoMatrizIcmsEfetivo) Then
    Exit;

  For LContador := Low(LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo) To High(LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo)Do
  begin
    SetLength(Result, Length(Result) + 1);

    Result[LContador].fltPICMEF := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltPICMEF;
    Result[LContador].fltBICMEF := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltBICMEF;
    Result[LContador].fltAICMEF := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltAICMEF;
    Result[LContador].fltVICMEF := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltVICMEF;
    Result[LContador].fltBSTANT := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltBSTANT;
    Result[LContador].fltVSTANT := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltVSTANT;
    Result[LContador].fltSICMEF := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltSICMEF;

    LResultadoCalculoIcmsEfetivo :=
      TResultadoCalculoIcmsEfetivo.New
        .PercentualReducaoBaseCalcEfetivaItem(Result[LContador].fltPICMEF)
        .ValorBaseCalculoEfetivaItem(Result[LContador].fltBICMEF)
        .ValorIcmsEfetivaItem(Result[LContador].fltVICMEF)
        .AliquotaIcmsEfetivaItem(Result[LContador].fltAICMEF)
        .ValorBaseCalculoIcmsStRetidoItem(Result[LContador].fltBSTANT)
        .ValorIcmsStRetidoItem(Result[LContador].fltVSTANT)
        .ValorIcmsSubstitutoItem(Result[LContador].fltSICMEF);

    SetarValorFinalMatriz(LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo);

    pGerarLogTesteUnitario((FParametrosIcmsEfetivo as TObject), (LResultadoCalculoIcmsEfetivo as TObject), Nil, 'CalcularValorIcmsEfetivo');
  end;
end;

function TImpostosFatControllerIcmsEfetivo.CalcularValorIcmsEfetivo(const AParametrosCalculoValorIcmsEfetivo: IParametrosCalculoValorIcmsEfetivo): TMatrizFechamentoIcmsEfetivo;
var
  LResultadoMatrizIcmsEfetivo: IResultadoServicosClasseIcmsEfetivo;
  LResultadoCalculoIcmsEfetivo : IResultadoCalculoIcmsEfetivo;
  LContador : Integer;
begin
  SetarParametrosIcmsEfetivo(AParametrosCalculoValorIcmsEfetivo);

  LResultadoMatrizIcmsEfetivo := GetFaturamentoImpostosService.IcmsEfetivo.CalcularValorIcmsEfetivo(FParametrosIcmsEfetivo);

  if Not CalculouIcmsEfetivo(LResultadoMatrizIcmsEfetivo) Then
    Exit;

  For LContador := Low(LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo) To High(LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo)Do
  begin
    SetLength(Result, Length(Result) + 1);

    Result[LContador].fltPICMEF := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltPICMEF;
    Result[LContador].fltBICMEF := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltBICMEF;
    Result[LContador].fltAICMEF := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltAICMEF;
    Result[LContador].fltVICMEF := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltVICMEF;
    Result[LContador].fltBSTANT := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltBSTANT;
    Result[LContador].fltVSTANT := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltVSTANT;
    Result[LContador].fltSICMEF := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltSICMEF;


    LResultadoCalculoIcmsEfetivo :=
      TResultadoCalculoIcmsEfetivo.New
        .PercentualReducaoBaseCalcEfetivaItem(Result[LContador].fltPICMEF)
        .ValorBaseCalculoEfetivaItem(Result[LContador].fltBICMEF)
        .ValorIcmsEfetivaItem(Result[LContador].fltVICMEF)
        .AliquotaIcmsEfetivaItem(Result[LContador].fltAICMEF)
        .ValorBaseCalculoIcmsStRetidoItem(Result[LContador].fltBSTANT)
        .ValorIcmsStRetidoItem(Result[LContador].fltVSTANT)
        .ValorIcmsSubstitutoItem(Result[LContador].fltSICMEF);

    SetarValorFinalMatriz(LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo);

    pGerarLogTesteUnitario((AParametrosCalculoValorIcmsEfetivo as TObject), (LResultadoCalculoIcmsEfetivo as TObject), Nil, 'CalcularValorIcmsEfetivo');
  end;
end;

constructor TImpostosFatControllerIcmsEfetivo.Create(var AMatItens: TMatrizFechamento);
begin
  FMatItens := AMatItens;
end;

destructor TImpostosFatControllerIcmsEfetivo.Destroy;
begin
  FMatItens := Nil;
  inherited;
end;

class function TImpostosFatControllerIcmsEfetivo.New(var AMatItens: TMatrizFechamento): IImpostosFatControllerIcmsEfetivo;
begin
  Result := Self.Create(AMatItens);
end;

procedure TImpostosFatControllerIcmsEfetivo.PreencherVetorItens;
Var
  LContador : Integer;
begin
  ZerarValoresMatriz;

  For LContador := Low(FMatItens) To High(FMatItens) Do
  begin
    SetLength(FMatItensIcmsEfetivo, Length(FMatItensIcmsEfetivo) + 1);

    FMatItensIcmsEfetivo[LContador].strCodFis := FMatItens[LContador].strCodFis;
    FMatItensIcmsEfetivo[LContador].strCodSit := FMatItens[LContador].strCodSit;
    FMatItensIcmsEfetivo[LContador].strCodIte := FMatItens[LContador].strCodIte;
    FMatItensIcmsEfetivo[LContador].strNotUlt := FMatItens[LContador].strNotUlt;
    FMatItensIcmsEfetivo[LContador].fltPICMEF := FMatItens[LContador].fltPICMEF;
    FMatItensIcmsEfetivo[LContador].fltBICMEF := FMatItens[LContador].fltBICMEF;
    FMatItensIcmsEfetivo[LContador].fltAICMEF := FMatItens[LContador].fltAICMEF;
    FMatItensIcmsEfetivo[LContador].fltVICMEF := FMatItens[LContador].fltVICMEF;
    FMatItensIcmsEfetivo[LContador].fltSICMEF := FMatItens[LContador].fltSICMEF;
    FMatItensIcmsEfetivo[LContador].fltBSTANT := FMatItens[LContador].fltBSTANT;
    FMatItensIcmsEfetivo[LContador].fltVSTANT := FMatItens[LContador].fltVSTANT;
    FMatItensIcmsEfetivo[LContador].fltQtdIte := FMatItens[LContador].fltQtdIte;
    FMatItensIcmsEfetivo[LContador].strClaFis := FMatItens[LContador].strClaFis;
    FMatItensIcmsEfetivo[LContador].fltTotIte := FMatItens[LContador].fltTotIte;
    FMatItensIcmsEfetivo[LContador].fltAlqIcm := FMatItens[LContador].fltAlqIcm;
    FMatItensIcmsEfetivo[LContador].fltDesEsp := FMatItens[LContador].fltDesEsp;
    FMatItensIcmsEfetivo[LContador].fltValFre := FMatItens[LContador].fltValFre;
    FMatItensIcmsEfetivo[LContador].fltDesAce := FMatItens[LContador].fltDesAce;
    FMatItensIcmsEfetivo[LContador].opcINFesp := FMatItens[LContador].opcINFesp;
    FMatItensIcmsEfetivo[LContador].strIdePro := FMatItens[LContador].strIdePro;
    FMatItensIcmsEfetivo[LContador].strTipoTinta := FMatItens[LContador].strTipoTinta;
  end;
end;

procedure TImpostosFatControllerIcmsEfetivo.SetarParametrosIcmsEfetivo;
begin
  PreencherVetorItens;

  FParametrosIcmsEfetivo:=
    TParametrosServicoIcmsEfetivo.New
      .MatItensIcmsEfetivo(FMatItensIcmsEfetivo)
      .CodigoDoCliente(objImpostosFatParametrosComum.CodigoDoCliente)
      .OpcaoDoDocumento(objImpostosFatParametrosComum.OpcaoDoDocumento)
      .CodigoDaEmpresa(objImpostosFatParametrosComum.CodigoDaEmpresa)
      .CodigoDoFornecedor(objImpostosFatParametrosComum.CodigoDoFornecedor)
      .ClienteConsumidorFinal(objImpostosFatParametrosComum.ClienteConsumidorFinal)
      .ParametrosClienteConsumidor(objImpostosFatParametrosComum.ParametrosClienteConsumidor)
      .SequencialEnderecoEntrega(objImpostosFatParametrosComum.SequencialEnderecoEntrega)
      .NotaComplementoFornecedor(objImpostosFatParametrosComum.NotaComplementoFornecedor)
      .NotaEspecialFornecedor(objImpostosFatParametrosComum.NotaEspecialFornecedor)
      .VendaPresencial(objImpostosFatParametrosComum.VendaPresencial)
      .BaixaDeEntregaFutura(objImpostosFatParametrosComum.BaixaDeEntregaFutura)
      .ClienteIndustria(objImpostosFatParametrosComum.ClienteIndustria)
      .ClienteComercializacao(objImpostosFatParametrosComum.ClienteComercializacao)
      .EspecieDocumento(objImpostosFatParametrosComum.EspecieDoDocumento)
      .TipoOperacaoPedidoVenda(objImpostosFatParametrosComum.TipoOperacaoPedidoVenda)
      .CalcularSatEcf(objImpostosFatParametrosComum.CalcularSatEcf)
      .UtilizaSat(objImpostosFatParametrosComum.UtilizaSat);
end;

procedure TImpostosFatControllerIcmsEfetivo.SetarParametrosIcmsEfetivo(const AParametrosCalculoValorIcmsEfetivo: IParametrosCalculoValorIcmsEfetivo);
begin
  FParametrosIcmsEfetivo:=
    TParametrosServicoIcmsEfetivo.New
      .MatItensIcmsEfetivo(FMatItensIcmsEfetivo)
      .CodigoDoCliente(AParametrosCalculoValorIcmsEfetivo.CodigoDoCliente)
      .OpcaoDoDocumento('')
      .CodigoDaEmpresa(AParametrosCalculoValorIcmsEfetivo.CodigoDaEmpresa)
      .CodigoDoFornecedor(AParametrosCalculoValorIcmsEfetivo.CodigoDoFornecedor)
      .ClienteConsumidorFinal(AParametrosCalculoValorIcmsEfetivo.ClienteConsumidorFinal = 'S')
      .ParametrosClienteConsumidor(Nil)
      .SequencialEnderecoEntrega('')
      .NotaComplementoFornecedor(false)
      .NotaEspecialFornecedor(false)
      .VendaPresencial(false)
      .BaixaDeEntregaFutura(false)
      .ClienteIndustria(AParametrosCalculoValorIcmsEfetivo.ClienteIndustria)
      .ClienteComercializacao(AParametrosCalculoValorIcmsEfetivo.ClienteComercializacao)
      .EspecieDocumento('')
      .TipoOperacaoPedidoVenda('')
      .CalcularSatEcf(false)
      .UtilizaSat(false);

end;

procedure TImpostosFatControllerIcmsEfetivo.SetarValorFinalMatriz(
  AResultadoCalculoIcmsEfetivo: TMatrizFechamentoIcmsEfetivo);
Var
  LContador : Integer;
begin

  For LContador := Low(AResultadoCalculoIcmsEfetivo) To High(AResultadoCalculoIcmsEfetivo) Do
  begin
    FMatItens[LContador].strNotUlt := AResultadoCalculoIcmsEfetivo[LContador].strNotUlt;
    FMatItens[LContador].fltPICMEF := AResultadoCalculoIcmsEfetivo[LContador].fltPICMEF;
    FMatItens[LContador].fltBICMEF := AResultadoCalculoIcmsEfetivo[LContador].fltBICMEF;
    FMatItens[LContador].fltAICMEF := AResultadoCalculoIcmsEfetivo[LContador].fltAICMEF;
    FMatItens[LContador].fltVICMEF := AResultadoCalculoIcmsEfetivo[LContador].fltVICMEF;
    FMatItens[LContador].fltSICMEF := AResultadoCalculoIcmsEfetivo[LContador].fltSICMEF;
    FMatItens[LContador].fltBSTANT := AResultadoCalculoIcmsEfetivo[LContador].fltBSTANT;
    FMatItens[LContador].fltVSTANT := AResultadoCalculoIcmsEfetivo[LContador].fltVSTANT;

  end;
end;

procedure TImpostosFatControllerIcmsEfetivo.ZerarValoresMatriz;
Var
  LContador : Integer;
begin
  For LContador := Low(FMatItens) To High(FMatItens) Do
  Begin
    FMatItens[LContador].fltPICMEF := 0.00;
    FMatItens[LContador].fltBICMEF := 0.00;
    FMatItens[LContador].fltAICMEF := 0.00;
    FMatItens[LContador].fltVICMEF := 0.00;
    FMatItens[LContador].fltBSTANT := 0.00;
    FMatItens[LContador].fltVSTANT := 0.00;
    FMatItens[LContador].fltSICMEF := 0.00;
  End;
end;

end.
