unit Faturamento.Impostos.Tipos.ST_Simulada;

interface

uses Faturamento.Impostos.Interfaces.ST_Simulada, Faturamento.Impostos.Interfaces.Model;

type
  TParametrosRegrasSTSimulada = class(TInterfacedObject, IParametrosRegrasSTSimulada)
  private
    FModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
    FModelProduto: IResultadoFaturamentoImpostosModelProduto;
    FModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
    FTotalGeralDoItem: Double;
    FClienteConsumidorFinal: Boolean;
    FCodigoDaSubstituicaoTributaria: String;
    FTipoDaAbreviacaoFiscal: String;
    FValorDoIva: Double;
    FAliquotaDaSubstituicaoTributariaDoItem: Double;
    FPercentualDaBaseDaSubstituicaoTributariaDoItem: Double;
    FEspecieDoDocumento: String;
    FDentroDoEstado: Boolean;
    FDentroDoEstadoCFOP: Boolean;
    FAtividadeConstrutora: Boolean;
  public
    function ModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ModelClienteFornecedor(AValue: IResultadoFaturamentoImpostosModelClienteFornecedor): IParametrosRegrasSTSimulada; overload;

    function ModelProduto: IResultadoFaturamentoImpostosModelProduto; overload;
    function ModelProduto(AValue: IResultadoFaturamentoImpostosModelProduto): IParametrosRegrasSTSimulada; overload;

    function ModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; overload;
    function ModelEmpresa(AValue: IResultadoFaturamentoImpostosModelEmpresa): IParametrosRegrasSTSimulada; overload;

	  function TotalGeralDoItem: Double; overload;
    function TotalGeralDoItem(AValue: Double): IParametrosRegrasSTSimulada; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosRegrasSTSimulada; overload;

    function CodigoDaSubstituicaoTributaria: String; overload;
    function CodigoDaSubstituicaoTributaria(AValue : String): IParametrosRegrasSTSimulada; overload;

    function TipoDaAbreviacaoFiscal: String; overload;
    function TipoDaAbreviacaoFiscal(AValue: String): IParametrosRegrasSTSimulada; overload;

	  function ValorDoIva: Double; overload;
    function ValorDoIva(AValue: Double): IParametrosRegrasSTSimulada; overload;

    function AliquotaDaSubstituicaoTributariaDoItem: Double; overload;
    function AliquotaDaSubstituicaoTributariaDoItem(AValue : Double): IParametrosRegrasSTSimulada; overload;

    function PercentualDaBaseDaSubstituicaoTributariaDoItem: Double; overload;
    function PercentualDaBaseDaSubstituicaoTributariaDoItem(AValue : Double): IParametrosRegrasSTSimulada; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IParametrosRegrasSTSimulada; overload;

    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosRegrasSTSimulada; overload;

    function DentroDoEstadoCFOP: Boolean; overload;
    function DentroDoEstadoCFOP(AValue: Boolean): IParametrosRegrasSTSimulada; overload;

    function AtividadeConstrutora: Boolean; overload;
    function AtividadeConstrutora(AValue: Boolean): IParametrosRegrasSTSimulada; overload;

    class function New(): TParametrosRegrasSTSimulada;
  end;

type
  TResultadoRegrasSTSimulada = class(TInterfacedObject, IResultadoRegrasSTSimulada)
  private
    FBaseDaSubstituicaoTributariaSimulada: Double;
    FAliquotaDaSubstituicaoTributariaSimulada: Double;
    FValorDaSubstituicaoTributariaSimulada: Double;
  public
	  function BaseDaSubstituicaoTributariaSimulada: Double; overload;
    function BaseDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoRegrasSTSimulada; overload;

	  function AliquotaDaSubstituicaoTributariaSimulada: Double; overload;
    function AliquotaDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoRegrasSTSimulada; overload;

	  function ValorDaSubstituicaoTributariaSimulada: Double; overload;
    function ValorDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoRegrasSTSimulada; overload;

    class function New(): IResultadoRegrasSTSimulada;
  end;

implementation

{ TParametrosRegrasSTSimulada }

function TParametrosRegrasSTSimulada.AliquotaDaSubstituicaoTributariaDoItem(
  AValue: Double): IParametrosRegrasSTSimulada;
begin
  Result := Self;
  FAliquotaDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosRegrasSTSimulada.AtividadeConstrutora: Boolean;
begin
  Result := FAtividadeConstrutora;
end;

function TParametrosRegrasSTSimulada.AtividadeConstrutora(
  AValue: Boolean): IParametrosRegrasSTSimulada;
begin
  Result := Self;
  FAtividadeConstrutora := AValue;
end;

function TParametrosRegrasSTSimulada.AliquotaDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FAliquotaDaSubstituicaoTributariaDoItem;
end;

function TParametrosRegrasSTSimulada.ClienteConsumidorFinal(
  AValue: Boolean): IParametrosRegrasSTSimulada;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

function TParametrosRegrasSTSimulada.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosRegrasSTSimulada.CodigoDaSubstituicaoTributaria(
  AValue: String): IParametrosRegrasSTSimulada;
begin
  Result := Self;
  FCodigoDaSubstituicaoTributaria := AValue;
end;

function TParametrosRegrasSTSimulada.DentroDoEstadoCFOP: Boolean;
begin
  Result := FDentroDoEstadoCFOP;
end;

function TParametrosRegrasSTSimulada.DentroDoEstado: Boolean;
begin
  Result := FDentroDoEstado;
end;

function TParametrosRegrasSTSimulada.DentroDoEstado(
  AValue: Boolean): IParametrosRegrasSTSimulada;
begin
  Result := Self;
  FDentroDoEstado := AValue;
end;

function TParametrosRegrasSTSimulada.DentroDoEstadoCFOP(
  AValue: Boolean): IParametrosRegrasSTSimulada;
begin
  Result := Self;
  FDentroDoEstadoCFOP := AValue;
end;

function TParametrosRegrasSTSimulada.CodigoDaSubstituicaoTributaria: String;
begin
  Result := FCodigoDaSubstituicaoTributaria;
end;

function TParametrosRegrasSTSimulada.EspecieDoDocumento: String;
begin
  Result := FEspecieDoDocumento;
end;

function TParametrosRegrasSTSimulada.EspecieDoDocumento(
  AValue: String): IParametrosRegrasSTSimulada;
begin
  Result := Self;
  FEspecieDoDocumento := AValue;
end;

function TParametrosRegrasSTSimulada.ModelClienteFornecedor(
  AValue: IResultadoFaturamentoImpostosModelClienteFornecedor): IParametrosRegrasSTSimulada;
begin
  Result := Self;
  FModelClienteFornecedor := AValue;
end;

function TParametrosRegrasSTSimulada.ModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := FModelClienteFornecedor;
end;

function TParametrosRegrasSTSimulada.ModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
begin
  Result := FModelEmpresa;
end;

function TParametrosRegrasSTSimulada.ModelEmpresa(
  AValue: IResultadoFaturamentoImpostosModelEmpresa): IParametrosRegrasSTSimulada;
begin
  Result := Self;
  FModelEmpresa := AValue;
end;

function TParametrosRegrasSTSimulada.ModelProduto: IResultadoFaturamentoImpostosModelProduto;
begin
  Result := FModelProduto;
end;

function TParametrosRegrasSTSimulada.ModelProduto(
  AValue: IResultadoFaturamentoImpostosModelProduto): IParametrosRegrasSTSimulada;
begin
  Result := Self;
  FModelProduto := AValue;
end;

class function TParametrosRegrasSTSimulada.New: TParametrosRegrasSTSimulada;
begin
  Result := Self.Create;
end;

function TParametrosRegrasSTSimulada.PercentualDaBaseDaSubstituicaoTributariaDoItem(
  AValue: Double): IParametrosRegrasSTSimulada;
begin
  Result := Self;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosRegrasSTSimulada.PercentualDaBaseDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FPercentualDaBaseDaSubstituicaoTributariaDoItem;
end;

function TParametrosRegrasSTSimulada.TipoDaAbreviacaoFiscal(
  AValue: String): IParametrosRegrasSTSimulada;
begin
  Result := Self;
  FTipoDaAbreviacaoFiscal := AValue;
end;

function TParametrosRegrasSTSimulada.TipoDaAbreviacaoFiscal: String;
begin
  Result := FTipoDaAbreviacaoFiscal;
end;

function TParametrosRegrasSTSimulada.TotalGeralDoItem: Double;
begin
  Result := FTotalGeralDoItem;
end;

function TParametrosRegrasSTSimulada.TotalGeralDoItem(
  AValue: Double): IParametrosRegrasSTSimulada;
begin
  Result := Self;
  FTotalGeralDoItem := AValue;
end;

function TParametrosRegrasSTSimulada.ValorDoIva(
  AValue: Double): IParametrosRegrasSTSimulada;
begin
  Result := Self;
  FValorDoIva := AValue;
end;

function TParametrosRegrasSTSimulada.ValorDoIva: Double;
begin
  Result := FValorDoIva;
end;

{ TResultadoRegrasSTSimulada }

function TResultadoRegrasSTSimulada.AliquotaDaSubstituicaoTributariaSimulada(
  AValue: Double): IResultadoRegrasSTSimulada;
begin
  Result := Self;
  FAliquotaDaSubstituicaoTributariaSimulada := AValue;
end;

function TResultadoRegrasSTSimulada.AliquotaDaSubstituicaoTributariaSimulada: Double;
begin
  Result := FAliquotaDaSubstituicaoTributariaSimulada;
end;

function TResultadoRegrasSTSimulada.BaseDaSubstituicaoTributariaSimulada(
  AValue: Double): IResultadoRegrasSTSimulada;
begin
  Result := Self;
  FBaseDaSubstituicaoTributariaSimulada := AValue;
end;

function TResultadoRegrasSTSimulada.BaseDaSubstituicaoTributariaSimulada: Double;
begin
  Result := FBaseDaSubstituicaoTributariaSimulada;
end;

class function TResultadoRegrasSTSimulada.New: IResultadoRegrasSTSimulada;
begin
  Result := Self.Create;
end;

function TResultadoRegrasSTSimulada.ValorDaSubstituicaoTributariaSimulada: Double;
begin
  Result := FValorDaSubstituicaoTributariaSimulada;
end;

function TResultadoRegrasSTSimulada.ValorDaSubstituicaoTributariaSimulada(
  AValue: Double): IResultadoRegrasSTSimulada;
begin
  Result := Self;
  FValorDaSubstituicaoTributariaSimulada := AValue;
end;

end.
