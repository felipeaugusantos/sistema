unit untCalculoImpostoSTSimulada;

interface

uses Shared.Functions.Core, untTypesST, Faturamento.Impostos.Interfaces.Model,
  Shared.Functions.Configuracoes;

type
  TCalculoImpostoSTSimulada = class
  private
    FCore: IFunctionsCore;
    FConfiguracoes: IConfiguracoes;
    FBaseDaSubstituicaoTributariaSimulada: Double;
    FAliquotaDaSubstituicaoTributariaSimulada: Double;
    FValorDaSubstituicaoTributariaSimulada: Double;

    function BaseDaSubstituicaoTributariaSimulada(const AParametros: TParametrosRegrasSTSimulada;
                                                  AModelProduto: IResultadoFaturamentoImpostosModelProduto;
                                                  AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa): Double;
    function PercentualDaBaseSubstituicaoTributariaSimulada(const AParametros: TParametrosRegrasSTSimulada;
                                                            AModelProduto: IResultadoFaturamentoImpostosModelProduto;
                                                            AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa): Double;
    function CalculaSTClienteConsumidorNCOEspiritoSanto(const AParametros: TParametrosRegrasSTSimulada;
      AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelProduto: IResultadoFaturamentoImpostosModelProduto): Boolean;
    function AliquotaDeIcms(const AParametros: TParametrosRegrasSTSimulada;
      AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): Double;
    function Resultado: TResultadoRegrasSTSimulada;
    procedure CalcularSTSimulada(AParametros: TParametrosRegrasSTSimulada;
                                 AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
                                 AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
                                 AModelProduto: IResultadoFaturamentoImpostosModelProduto);
  public
    function Calcular(const AParametros: TParametrosRegrasSTSimulada;
                      AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
                      AModelProduto: IResultadoFaturamentoImpostosModelProduto;
                      AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa): TResultadoRegrasSTSimulada;
    constructor Create(ACore: IFunctionsCore; AConfiguracoes: IConfiguracoes);
  end;

implementation

uses untImpostoRegrasAliquota, untTypesGenericosImpostos, Shared.Functions.Funcoes.Faturamento;

{ TCalculoSTSimulada }

function TCalculoImpostoSTSimulada.AliquotaDeIcms(const AParametros: TParametrosRegrasSTSimulada;
  AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): Double;
  Var
    LParametrosDadosFiscaisAliquota: TParametrosDadosFiscaisAliquota;
    LResultadoDadosFiscaisAliquota: TResultadoDadosFiscaisAliquota;
begin
  FillChar(LParametrosDadosFiscaisAliquota, SizeOf(LParametrosDadosFiscaisAliquota), #0);
  FillChar(LResultadoDadosFiscaisAliquota, SizeOf(LResultadoDadosFiscaisAliquota), #0);
  LParametrosDadosFiscaisAliquota.ClienteEstado := AModelClienteFornecedor.ClienteEstado;
  LParametrosDadosFiscaisAliquota.InscricaoEstadual := AModelClienteFornecedor.ClienteInscricaoEstadual;
  LParametrosDadosFiscaisAliquota.MicroEmpreendedor := AModelClienteFornecedor.ClienteMicroEmpreendedor;
  LParametrosDadosFiscaisAliquota.EmpresaEstado := AModelEmpresa.EmpresaEstado;
  LParametrosDadosFiscaisAliquota.DocumentoDeVenda := True;
  LParametrosDadosFiscaisAliquota.DentroDoEstadoCFOP := AParametros.DentroDoEstadoCFOP;
  LParametrosDadosFiscaisAliquota.AtividadeConstrutora := AParametros.AtividadeConstrutora;
  LParametrosDadosFiscaisAliquota.EspecieDocumento := AParametros.EspecieDoDocumento;

  LResultadoDadosFiscaisAliquota := TImpostoRegrasAliquota.New(FConfiguracoes).DadosFiscaisAliquotaDoItem(LParametrosDadosFiscaisAliquota);
  Result := LResultadoDadosFiscaisAliquota.AliquotaIcm;
end;

function TCalculoImpostoSTSimulada.BaseDaSubstituicaoTributariaSimulada(const AParametros: TParametrosRegrasSTSimulada;
                                                                        AModelProduto: IResultadoFaturamentoImpostosModelProduto;
                                                                        AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa): Double;
begin
  Result := FCore.fFormataFloat((((AParametros.TotalGeralDoItem * PercentualDaBaseSubstituicaoTributariaSimulada(AParametros, AModelProduto, AModelEmpresa)) * AParametros.PercentualDaBaseDaSubstituicaoTributariaDoItem) / 100), 2);
end;

function TCalculoImpostoSTSimulada.Calcular(const AParametros: TParametrosRegrasSTSimulada;
                                            AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
                                            AModelProduto: IResultadoFaturamentoImpostosModelProduto;
                                            AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa): TResultadoRegrasSTSimulada;
begin
  FillChar(Result, SizeOf(Result), #0);
  FBaseDaSubstituicaoTributariaSimulada := 0;
  FAliquotaDaSubstituicaoTributariaSimulada := 0;
  FValorDaSubstituicaoTributariaSimulada := 0;

  If Not AParametros.DentroDoEstado Then
  Begin
    Result := Resultado;
    Exit;
  End;

  If TFunctionFuncoesFaturamento.SubstituicaoTributaria(AParametros.CodigoDaSubstituicaoTributaria) Then
    CalcularSTSimulada(AParametros, AModelClienteFornecedor, AModelEmpresa, AModelProduto);

  Result := Resultado;
end;

procedure TCalculoImpostoSTSimulada.CalcularSTSimulada(AParametros: TParametrosRegrasSTSimulada;
                                                       AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
                                                       AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
                                                       AModelProduto: IResultadoFaturamentoImpostosModelProduto);
begin
  FBaseDaSubstituicaoTributariaSimulada := BaseDaSubstituicaoTributariaSimulada(AParametros, AModelProduto, AModelEmpresa);

  FAliquotaDaSubstituicaoTributariaSimulada := AParametros.AliquotaDaSubstituicaoTributariaDoItem;

  FValorDaSubstituicaoTributariaSimulada := ((FBaseDaSubstituicaoTributariaSimulada * FAliquotaDaSubstituicaoTributariaSimulada / 100) - (AParametros.TotalGeralDoItem * AliquotaDeIcms(AParametros, AModelEmpresa, AModelClienteFornecedor) / 100));

  If (FValorDaSubstituicaoTributariaSimulada <= 0) Then
    FValorDaSubstituicaoTributariaSimulada := 0;
end;

function TCalculoImpostoSTSimulada.CalculaSTClienteConsumidorNCOEspiritoSanto(const AParametros: TParametrosRegrasSTSimulada;
      AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelProduto: IResultadoFaturamentoImpostosModelProduto): Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      CalcSTCliConNCOEspSto(AModelEmpresa.EmpresaEstado,
                            AParametros.TipoDaAbreviacaoFiscal,
                            AParametros.ClienteConsumidorFinal,
                            AParametros.DentroDoEstado,
                            AModelProduto.ImportacaoDireta = 'S',
                            AParametros.CodigoDaSubstituicaoTributaria);
end;

constructor TCalculoImpostoSTSimulada.Create(ACore: IFunctionsCore; AConfiguracoes: IConfiguracoes);
begin
  FCore := ACore;
  FConfiguracoes := AConfiguracoes;
end;

function TCalculoImpostoSTSimulada.PercentualDaBaseSubstituicaoTributariaSimulada(const AParametros: TParametrosRegrasSTSimulada;
                                                                                  AModelProduto: IResultadoFaturamentoImpostosModelProduto;
                                                                                  AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa): Double;
begin
  Result := AParametros.ValorDoIva;

  If Not AParametros.ClienteConsumidorFinal Then
    Exit;

  If CalculaSTClienteConsumidorNCOEspiritoSanto(AParametros, AModelEmpresa, AModelProduto) Then
    Exit;

  Result := 1;
end;

function TCalculoImpostoSTSimulada.Resultado: TResultadoRegrasSTSimulada;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.BaseDaSubstituicaoTributariaSimulada := FBaseDaSubstituicaoTributariaSimulada;
  Result.AliquotaDaSubstituicaoTributariaSimulada := FAliquotaDaSubstituicaoTributariaSimulada;
  Result.ValorDaSubstituicaoTributariaSimulada := FValorDaSubstituicaoTributariaSimulada;
end;

end.
