unit Faturamento.Impostos.Regras.Tributacao.ST_Simulada;

interface

uses Faturamento.Impostos.Interfaces.ST_Simulada, Faturamento.Impostos.Tipos.ST_Simulada,
  Shared.Functions.Funcoes.Faturamento, Shared.Functions.Core,
  Faturamento.Impostos.Tipos.DadosFiscais.Aliquota,
  Faturamento.Impostos.Regras.DadosFiscais.Aliquota;

type
  TCalculoSTSimulada = class(TInterfacedObject, ICalculoSTSimulada)
  private
    FBaseDaSubstituicaoTributariaSimulada: Double;
    FAliquotaDaSubstituicaoTributariaSimulada: Double;
    FValorDaSubstituicaoTributariaSimulada: Double;

    function BaseDaSubstituicaoTributariaSimulada(const AParametros: IParametrosRegrasSTSimulada): Double;
    function PercentualDaBaseSubstituicaoTributariaSimulada(const AParametros: IParametrosRegrasSTSimulada): Double;
    function CalculaSTClienteConsumidorNCOEspiritoSanto(const AParametros: IParametrosRegrasSTSimulada): Boolean;
    function AliquotaDeIcms(const AParametros: IParametrosRegrasSTSimulada): Double;
    function Resultado: IResultadoRegrasSTSimulada;
    procedure CalcularSTSimulada(AParametros: IParametrosRegrasSTSimulada);
  public
    function Calcular(const AParametros: IParametrosRegrasSTSimulada): IResultadoRegrasSTSimulada;

    class function New(): ICalculoSTSimulada;
  end;

implementation

{ TCalculoSTSimulada }

function TCalculoSTSimulada.AliquotaDeIcms(
  const AParametros: IParametrosRegrasSTSimulada): Double;
begin
  Result :=
    TRegraImpostosDadosFiscaisAliquota.New()
      .DadosFiscaisAliquotaDoItem(
        TParametrosDadosFiscaisAliquota.New()
          .ClienteEstado(AParametros.ModelClienteFornecedor.ClienteEstado)
          .InscricaoEstadual(AParametros.ModelClienteFornecedor.ClienteInscricaoEstadual)
          .MicroEmpreendedor(AParametros.ModelClienteFornecedor.ClienteMicroEmpreendedor)
          .EmpresaEstado(AParametros.ModelEmpresa.EmpresaEstado)
          .DocumentoDeVenda(True)
          .DentroDoEstadoCFOP(AParametros.DentroDoEstadoCFOP)
          .AtividadeConstrutora(AParametros.AtividadeConstrutora)
          .EspecieDocumento(AParametros.EspecieDoDocumento)
        ).AliquotaIcm;
end;

function TCalculoSTSimulada.BaseDaSubstituicaoTributariaSimulada(
  const AParametros: IParametrosRegrasSTSimulada): Double;
begin
  Result := objCore.fFormataFloat((((AParametros.TotalGeralDoItem * PercentualDaBaseSubstituicaoTributariaSimulada(AParametros)) * AParametros.PercentualDaBaseDaSubstituicaoTributariaDoItem) / 100), 2);
end;

function TCalculoSTSimulada.Calcular(
  const AParametros: IParametrosRegrasSTSimulada): IResultadoRegrasSTSimulada;
begin
  FBaseDaSubstituicaoTributariaSimulada := 0;
  FAliquotaDaSubstituicaoTributariaSimulada := 0;
  FValorDaSubstituicaoTributariaSimulada := 0;

  If Not AParametros.DentroDoEstado Then
  Begin
    Result := Resultado;
    Exit;
  End;

  If TFunctionFuncoesFaturamento.SubstituicaoTributaria(AParametros.CodigoDaSubstituicaoTributaria) Then
    CalcularSTSimulada(AParametros);

  Result := Resultado;
end;

procedure TCalculoSTSimulada.CalcularSTSimulada(
  AParametros: IParametrosRegrasSTSimulada);
begin
  FBaseDaSubstituicaoTributariaSimulada := BaseDaSubstituicaoTributariaSimulada(AParametros);

  FAliquotaDaSubstituicaoTributariaSimulada := AParametros.AliquotaDaSubstituicaoTributariaDoItem;

  FValorDaSubstituicaoTributariaSimulada := ((FBaseDaSubstituicaoTributariaSimulada * FAliquotaDaSubstituicaoTributariaSimulada / 100) - (AParametros.TotalGeralDoItem * AliquotaDeIcms(AParametros) / 100));

  If (FValorDaSubstituicaoTributariaSimulada <= 0) Then
    FValorDaSubstituicaoTributariaSimulada := 0;
end;

function TCalculoSTSimulada.CalculaSTClienteConsumidorNCOEspiritoSanto(
  const AParametros: IParametrosRegrasSTSimulada): Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      CalcSTCliConNCOEspSto(AParametros.ModelEmpresa.EmpresaEstado,
                            AParametros.TipoDaAbreviacaoFiscal,
                            AParametros.ClienteConsumidorFinal,
                            AParametros.DentroDoEstado,
                            AParametros.ModelProduto.ImportacaoDireta = 'S',
                            AParametros.CodigoDaSubstituicaoTributaria);
end;

class function TCalculoSTSimulada.New: ICalculoSTSimulada;
begin
  Result := Self.Create;
end;

function TCalculoSTSimulada.PercentualDaBaseSubstituicaoTributariaSimulada(
  const AParametros: IParametrosRegrasSTSimulada): Double;
begin
  Result := AParametros.ValorDoIva;

  If Not AParametros.ClienteConsumidorFinal Then
    Exit;

  If CalculaSTClienteConsumidorNCOEspiritoSanto(AParametros) Then
    Exit;

  Result := 1;
end;

function TCalculoSTSimulada.Resultado: IResultadoRegrasSTSimulada;
begin
  Result :=
    TResultadoRegrasSTSimulada.New
      .BaseDaSubstituicaoTributariaSimulada(FBaseDaSubstituicaoTributariaSimulada)
      .AliquotaDaSubstituicaoTributariaSimulada(FAliquotaDaSubstituicaoTributariaSimulada)
      .ValorDaSubstituicaoTributariaSimulada(FValorDaSubstituicaoTributariaSimulada);
end;

end.
