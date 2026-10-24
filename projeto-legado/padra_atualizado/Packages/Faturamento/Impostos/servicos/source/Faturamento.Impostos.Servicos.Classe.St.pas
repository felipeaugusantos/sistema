unit Faturamento.Impostos.Servicos.Classe.St;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Classe.St,
  Faturamento.Impostos.Tipos.Servicos.Classe.St, Faturamento.Impostos.Interfaces.ST,
  Faturamento.Impostos.Tipos.ST, Faturamento.Impostos.Calculos.ST,
  Shared.Functions.Faturamento.Impostos.Regras.ZerarImpostos;

type
  TServicosClasseSt = class(TInterfacedObject, IServicosClasseSt)
  private
    FParametros: IParametrosClasseSt;

    function ResultadoCalculoStFinal: IResultadoCalculoSt;
    function BaseDeCalculoDaSubstituicaoTributariaParaRegraDaAliquota: Double;
    function fZerarSTSetandoValorNoStConsignacao(AobjResultadoCalculoST: IResultadoCalculoST) : IResultadoCalculoSt;
  public
    function CalcularSt: IResultadoClasseSt;
    function CalcularStFinal(const AZerarValorDoSt: Boolean): IResultadoClasseSt;

    constructor Create(AParametros: IParametrosClasseSt);

    class function New(AParametros: IParametrosClasseSt): IServicosClasseSt;
  end;

implementation

{ TServicosClasseSt }

function TServicosClasseSt.BaseDeCalculoDaSubstituicaoTributariaParaRegraDaAliquota: Double;
begin
  Result := ResultadoCalculoStFinal.BaseDeCalculoDaSubstituicaoTributariaDoItem;
end;

function TServicosClasseSt.CalcularSt: IResultadoClasseSt;
var
  LResultadoCalculoSTFinal : IResultadoCalculoST;
begin
  LResultadoCalculoSTFinal := ResultadoCalculoStFinal;

  Result :=
    TResultadoClasseSt.New
      .ResultadoCalculoSt(LResultadoCalculoSTFinal)
      .ParametrosCalculoSt(FParametros.ParametrosCalculoSt)
      .BaseDeCalculoDaSubstituicaoTributariaParaRegraDaAliquota(LResultadoCalculoSTFinal.BaseDeCalculoDaSubstituicaoTributariaDoItem);
end;

function TServicosClasseSt.CalcularStFinal(
  const AZerarValorDoSt: Boolean): IResultadoClasseSt;
Var
  LResultadoCalculoSt: IResultadoCalculoSt;
begin
  If AZerarValorDoSt Then
  begin
    LResultadoCalculoSt :=
      TResultadoCalculoSt.New()
        .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
        .ValorDaSubstituicaoTributariaDoItem(0)
        .PercentualDoFCPDoItem(0)
        .ValorDoFCPDoItem(0)
        .PercentualDaSubstituicaoDaBase(FParametros.RegrasTributacaoIcmsSt.PercentualDaBaseDaSubstituicaoTributariaDoItem)
        .BaseDaSubstituicaoTributariaSimulada(FParametros.RegrasTributacaoIcmsSt.BaseDaSubstituicaoTributariaSimulada)
        .AliquotaDaSubstituicaoTributariaSimulada(FParametros.RegrasTributacaoIcmsSt.AliquotaDaSubstituicaoTributariaSimulada)
        .ValorDaSubstituicaoTributariaSimulada(FParametros.RegrasTributacaoIcmsSt.ValorDaSubstituicaoTributariaSimulada)
        .ValorDoIvaMatriz(FParametros.RegrasTributacaoIcmsSt.ValorDoIvaMatriz)
        .ValorDoIvaStMatriz(FParametros.RegrasTributacaoIcmsSt.ValorDoIvaStMatriz);

    Result :=
      TResultadoClasseSt.New
        .ResultadoCalculoSt(LResultadoCalculoSt)
        .ParametrosCalculoSt(FParametros.ParametrosCalculoSt)
        .BaseDeCalculoDaSubstituicaoTributariaParaRegraDaAliquota(BaseDeCalculoDaSubstituicaoTributariaParaRegraDaAliquota);

    Exit;
  end;

  Result := CalcularSt;
end;

constructor TServicosClasseSt.Create(AParametros: IParametrosClasseSt);
begin
  FParametros := AParametros;
end;

class function TServicosClasseSt.New(
  AParametros: IParametrosClasseSt): IServicosClasseSt;
begin
  Result := Self.Create(AParametros);
end;

function TServicosClasseSt.fZerarSTSetandoValorNoStConsignacao(AobjResultadoCalculoST: IResultadoCalculoST) : IResultadoCalculoSt;
begin
  Result :=
    TResultadoCalculoST.New
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .ValorDaSubstituicaoTributariaDoItem(0)
      .PercentualDaSubstituicaoDaBase(0)
      .PercentualDoFCPDoItem(0)
      .ValorDoFCPDoItem(0)
      .BaseDaSubstituicaoTributariaSimulada(FParametros.RegrasTributacaoIcmsSt.BaseDaSubstituicaoTributariaSimulada)
      .AliquotaDaSubstituicaoTributariaSimulada(FParametros.RegrasTributacaoIcmsSt.AliquotaDaSubstituicaoTributariaSimulada)
      .ValorDaSubstituicaoTributariaSimulada(FParametros.RegrasTributacaoIcmsSt.ValorDaSubstituicaoTributariaSimulada)
      .ValorDoIvaMatriz(FParametros.RegrasTributacaoIcmsSt.ValorDoIvaMatriz)
      .ValorDoIvaStMatriz(FParametros.RegrasTributacaoIcmsSt.ValorDoIvaStMatriz)
      .ValorCalculadoSTConsignacao(AobjResultadoCalculoST.ValorDaSubstituicaoTributariaDoItem);
end;

function TServicosClasseSt.ResultadoCalculoStFinal: IResultadoCalculoSt;
var
  LResultadoCalculoST: IResultadoCalculoST;
begin
  LResultadoCalculoST  := TCalculoImpostosST.New.CalcularValorST(FParametros.ParametrosCalculoSt);

  if TFunctionsZerarImpostosRegrasImpostosFaturamento.fZerarSTFaturamentoConsignacao(FParametros.ParametrosCalculoST.ClassificacaoFiscalDoItem) then
  begin
    result := fZerarSTSetandoValorNoStConsignacao(LResultadoCalculoST);
    Exit;
  end;

  Result :=
    TResultadoCalculoST.New
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(LResultadoCalculoST.BaseDeCalculoDaSubstituicaoTributariaDoItem)
      .ValorDaSubstituicaoTributariaDoItem(LResultadoCalculoST.ValorDaSubstituicaoTributariaDoItem)
      .PercentualDaSubstituicaoDaBase(LResultadoCalculoST.PercentualDaSubstituicaoDaBase)
      .PercentualDoFCPDoItem(LResultadoCalculoST.PercentualDoFCPDoItem)
      .ValorDoFCPDoItem(LResultadoCalculoST.ValorDoFCPDoItem)
      .BaseDaSubstituicaoTributariaSimulada(FParametros.RegrasTributacaoIcmsSt.BaseDaSubstituicaoTributariaSimulada)
      .AliquotaDaSubstituicaoTributariaSimulada(FParametros.RegrasTributacaoIcmsSt.AliquotaDaSubstituicaoTributariaSimulada)
      .ValorDaSubstituicaoTributariaSimulada(FParametros.RegrasTributacaoIcmsSt.ValorDaSubstituicaoTributariaSimulada)
      .ValorDoIvaMatriz(FParametros.RegrasTributacaoIcmsSt.ValorDoIvaMatriz)
      .ValorDoIvaStMatriz(FParametros.RegrasTributacaoIcmsSt.ValorDoIvaStMatriz)
      .ValorDesoneradoDaSubstituicaoTributariaDoItem(LResultadoCalculoST.ValorDesoneradoDaSubstituicaoTributariaDoItem);
end;

end.
