unit Faturamento.Impostos.Tipos.Iva;

interface

uses Faturamento.Impostos.Interfaces.Iva, Faturamento.Impostos.Interfaces.Model;

type
  TParametrosCalculoIva = class(TInterfacedObject, IParametrosCalculoIva)
  private
    FPercentualDoIvaAbreviacao: Double;
    FModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
    FModelProduto: IResultadoFaturamentoImpostosModelProduto;
    FModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
    FCodigoDaSituacaoTributaria: String;
    FCodigoDaSubstituicaoTributaria: String;
    FTipoDaAbreviacaoFiscal: String;
    FDentroDoEstado: Boolean;
//    FClienteIVAEspMT: Double;
//    FClienteIVANacMT: Double;
//    FClienteIVASimMT: Double;
    FTotalGeralDoItem: Double;
    FValorDeIpiDoItem: Double;
    FAliquotaDeIcmsDoItem: Double;
    FAliquotaDaSubstituicaoTributariaDoItem: Double;
    FDocumentoParaFornecedor: Boolean;
    FExisteNaTabelaCEDEM: Boolean;
  public
    function PercentualDoIvaAbreviacao: Double; overload;
    function PercentualDoIvaAbreviacao(AValue: Double): IParametrosCalculoIva; overload;

    function ModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ModelClienteFornecedor(AValue: IResultadoFaturamentoImpostosModelClienteFornecedor): IParametrosCalculoIva; overload;

    function ModelProduto: IResultadoFaturamentoImpostosModelProduto; overload;
    function ModelProduto(AValue: IResultadoFaturamentoImpostosModelProduto): IParametrosCalculoIva; overload;

    function ModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; overload;
    function ModelEmpresa(AValue: IResultadoFaturamentoImpostosModelEmpresa): IParametrosCalculoIva; overload;

    function CodigoDaSituacaoTributaria: String; overload;
    function CodigoDaSituacaoTributaria(AValue: String): IParametrosCalculoIva; overload;

    function CodigoDaSubstituicaoTributaria: String; overload;
    function CodigoDaSubstituicaoTributaria(AValue: String): IParametrosCalculoIva; overload;

    function TipoDaAbreviacaoFiscal: String; overload;
    function TipoDaAbreviacaoFiscal(AValue: String): IParametrosCalculoIva; overload;

    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosCalculoIva; overload;

//    function ClienteIVAEspMT: Double; overload;
//    function ClienteIVAEspMT(AValue: Double): IParametrosCalculoIva; overload;
//
//    function ClienteIVANacMT: Double; overload;
//    function ClienteIVANacMT(AValue: Double): IParametrosCalculoIva; overload;
//
//    function ClienteIVASimMT: Double; overload;
//    function ClienteIVASimMT(AValue: Double): IParametrosCalculoIva; overload;

	  function TotalGeralDoItem: Double; overload;
    function TotalGeralDoItem(AValue: Double): IParametrosCalculoIva; overload;

    function ValorDeIpiDoItem: Double; overload;
    function ValorDeIpiDoItem(AValue: Double): IParametrosCalculoIva; overload;

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosCalculoIva; overload;

    function AliquotaDaSubstituicaoTributariaDoItem: Double; overload;
    function AliquotaDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosCalculoIva; overload;

    function DocumentoParaFornecedor: Boolean; overload;
    function DocumentoParaFornecedor(AValue: Boolean): IParametrosCalculoIva; overload;

    function ExisteNaTabelaCEDEM: Boolean; overload;
    function ExisteNaTabelaCEDEM(AValue: Boolean): IParametrosCalculoIva; overload;

    class function New(): IParametrosCalculoIva;
  end;

type
  TResultadoCalculoIva = class(TInterfacedObject, IResultadoCalculoIva)
  private
    FValorDoIva: Double;
    FValorDoIvaMatriz: Double;
    FValorDoIvaStMatriz: Double;
    FClienteIVAEspMT: Double;
  public
    function ValorDoIva: Double; overload;
    function ValorDoIva(AValue: Double): IResultadoCalculoIva; overload;

    function ValorDoIvaMatriz: Double; overload;
    function ValorDoIvaMatriz(AValue: Double): IResultadoCalculoIva; overload;

    function ValorDoIvaStMatriz: Double; overload;
    function ValorDoIvaStMatriz(AValue: Double): IResultadoCalculoIva; overload;

    function ClienteIVAEspMT: Double; overload;
    function ClienteIVAEspMT(AValue: Double): IResultadoCalculoIva; overload;

    class function New(): IResultadoCalculoIva;
  end;


implementation

{ TParametrosCalculoIva }

function TParametrosCalculoIva.AliquotaDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FAliquotaDaSubstituicaoTributariaDoItem;
end;

function TParametrosCalculoIva.AliquotaDaSubstituicaoTributariaDoItem(
  AValue: Double): IParametrosCalculoIva;
begin
  Result := Self;
  FAliquotaDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosCalculoIva.AliquotaDeIcmsDoItem(
  AValue: Double): IParametrosCalculoIva;
begin
  Result := Self;
  FAliquotaDeIcmsDoItem := AValue;
end;

function TParametrosCalculoIva.AliquotaDeIcmsDoItem: Double;
begin
  Result := FAliquotaDeIcmsDoItem;
end;

//function TParametrosCalculoIva.ClienteIVAEspMT: Double;
//begin
//  Result := FClienteIVAEspMT;
//end;

//function TParametrosCalculoIva.ClienteIVAEspMT(
//  AValue: Double): IParametrosCalculoIva;
//begin
//  Result := Self;
//  FClienteIVAEspMT := AValue;
//end;

//function TParametrosCalculoIva.ClienteIVANacMT: Double;
//begin
//  Result := FClienteIVANacMT;
//end;
//
//function TParametrosCalculoIva.ClienteIVANacMT(
//  AValue: Double): IParametrosCalculoIva;
//begin
//  Result := Self;
//  FClienteIVANacMT := AValue;
//end;

//function TParametrosCalculoIva.ClienteIVASimMT: Double;
//begin
//  Result := FClienteIVASimMT;
//end;
//
//function TParametrosCalculoIva.ClienteIVASimMT(
//  AValue: Double): IParametrosCalculoIva;
//begin
//  Result := Self;
//  FClienteIVASimMT := AValue;
//end;

function TParametrosCalculoIva.CodigoDaSituacaoTributaria: String;
begin
  Result := FCodigoDaSituacaoTributaria;
end;

function TParametrosCalculoIva.ExisteNaTabelaCEDEM: Boolean;
begin
  Result := FExisteNaTabelaCEDEM;
end;

function TParametrosCalculoIva.ExisteNaTabelaCEDEM(
  AValue: Boolean): IParametrosCalculoIva;
begin
  Result := Self;
  FExisteNaTabelaCEDEM := AValue;
end;

function TParametrosCalculoIva.CodigoDaSituacaoTributaria(
  AValue: String): IParametrosCalculoIva;
begin
  Result := Self;
  FCodigoDaSituacaoTributaria := AValue;
end;

function TParametrosCalculoIva.CodigoDaSubstituicaoTributaria: String;
begin
  Result := FCodigoDaSubstituicaoTributaria;
end;

function TParametrosCalculoIva.CodigoDaSubstituicaoTributaria(
  AValue: String): IParametrosCalculoIva;
begin
  Result := Self;
  FCodigoDaSubstituicaoTributaria := AValue;
end;

function TParametrosCalculoIva.DentroDoEstado: Boolean;
begin
  Result := FDentroDoEstado;
end;

function TParametrosCalculoIva.DentroDoEstado(
  AValue: Boolean): IParametrosCalculoIva;
begin
  Result := Self;
  FDentroDoEstado := AValue;
end;

function TParametrosCalculoIva.DocumentoParaFornecedor: Boolean;
begin
  Result := FDocumentoParaFornecedor;
end;

function TParametrosCalculoIva.DocumentoParaFornecedor(
  AValue: Boolean): IParametrosCalculoIva;
begin
  Result := Self;
  FDocumentoParaFornecedor := AValue;
end;

function TParametrosCalculoIva.ModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := FModelClienteFornecedor;
end;

function TParametrosCalculoIva.ModelClienteFornecedor(
  AValue: IResultadoFaturamentoImpostosModelClienteFornecedor): IParametrosCalculoIva;
begin
  Result := Self;
  FModelClienteFornecedor := AValue;
end;

function TParametrosCalculoIva.ModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
begin
  Result := FModelEmpresa;
end;

function TParametrosCalculoIva.ModelEmpresa(
  AValue: IResultadoFaturamentoImpostosModelEmpresa): IParametrosCalculoIva;
begin
  Result := Self;
  FModelEmpresa := AValue;
end;

function TParametrosCalculoIva.ModelProduto: IResultadoFaturamentoImpostosModelProduto;
begin
  Result := FModelProduto;
end;

function TParametrosCalculoIva.ModelProduto(
  AValue: IResultadoFaturamentoImpostosModelProduto): IParametrosCalculoIva;
begin
  Result := Self;
  FModelProduto := AValue;
end;

class function TParametrosCalculoIva.New: IParametrosCalculoIva;
begin
  Result := Self.Create;
end;

function TParametrosCalculoIva.PercentualDoIvaAbreviacao: Double;
begin
  Result := FPercentualDoIvaAbreviacao;
end;

function TParametrosCalculoIva.PercentualDoIvaAbreviacao(
  AValue: Double): IParametrosCalculoIva;
begin
  Result := Self;
  FPercentualDoIvaAbreviacao := AValue;
end;

function TParametrosCalculoIva.TipoDaAbreviacaoFiscal: String;
begin
  Result := FTipoDaAbreviacaoFiscal;
end;

function TParametrosCalculoIva.TipoDaAbreviacaoFiscal(
  AValue: String): IParametrosCalculoIva;
begin
  Result := Self;
  FTipoDaAbreviacaoFiscal := AValue;
end;

function TParametrosCalculoIva.TotalGeralDoItem: Double;
begin
  Result := FTotalGeralDoItem;
end;

function TParametrosCalculoIva.TotalGeralDoItem(
  AValue: Double): IParametrosCalculoIva;
begin
  Result := Self;
  FTotalGeralDoItem := AValue;
end;

function TParametrosCalculoIva.ValorDeIpiDoItem(
  AValue: Double): IParametrosCalculoIva;
begin
  Result := Self;
  FValorDeIpiDoItem := AValue;
end;

function TParametrosCalculoIva.ValorDeIpiDoItem: Double;
begin
  Result := FValorDeIpiDoItem;
end;

{ TResultadoCalculoIva }

function TResultadoCalculoIva.ClienteIVAEspMT(
  AValue: Double): IResultadoCalculoIva;
begin
  Result := Self;
  FClienteIVAEspMT := AValue;
end;

function TResultadoCalculoIva.ClienteIVAEspMT: Double;
begin
  Result := FClienteIVAEspMT;
end;

class function TResultadoCalculoIva.New: IResultadoCalculoIva;
begin
  Result := Self.Create;
end;

function TResultadoCalculoIva.ValorDoIva(AValue: Double): IResultadoCalculoIva;
begin
  Result := Self;
  FValorDoIva := AValue;
end;

function TResultadoCalculoIva.ValorDoIva: Double;
begin
  Result := FValorDoIva;
end;

function TResultadoCalculoIva.ValorDoIvaMatriz(
  AValue: Double): IResultadoCalculoIva;
begin
  Result := Self;
  FValorDoIvaMatriz := AValue;
end;

function TResultadoCalculoIva.ValorDoIvaStMatriz(
  AValue: Double): IResultadoCalculoIva;
begin
  Result := Self;
  FValorDoIvaStMatriz := AValue;
end;

function TResultadoCalculoIva.ValorDoIvaStMatriz: Double;
begin
  Result := FValorDoIvaStMatriz;
end;

function TResultadoCalculoIva.ValorDoIvaMatriz: Double;
begin
  Result := FValorDoIvaMatriz;
end;

end.
