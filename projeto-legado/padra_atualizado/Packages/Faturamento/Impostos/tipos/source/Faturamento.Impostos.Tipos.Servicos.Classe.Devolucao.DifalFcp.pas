unit Faturamento.Impostos.Tipos.Servicos.Classe.Devolucao.DifalFcp;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Classe.Devolucao.DifalFcp;

type
  TParametrosClasseDevolucaoDifalFcp = class(TInterfacedObject, IParametrosClasseDevolucaoDifalFcp)
  private
    FCodigoDoCliente: String;
    FCodigoDoItem: String;
    FNumeroDoDocumentoDeDevolucao: String;
    FEspecieDoDocumentoDeDevolucao: String;
    FEmpresaDoDocumentoDeDevolucao: String;
    FQuantidadeDoItem: Double;
    FProdutoST: Boolean;
    FHabilitarNovoCalculoDifalComPercentualBase: Boolean;
  public
    function CodigoDoCliente: String; overload;
    function CodigoDoCliente(AValue: String): IParametrosClasseDevolucaoDifalFcp; overload;

    function CodigoDoItem: String; overload;
    function CodigoDoItem(AValue: String): IParametrosClasseDevolucaoDifalFcp; overload;

    function NumeroDoDocumentoDeDevolucao: String; overload;
    function NumeroDoDocumentoDeDevolucao(AValue: String): IParametrosClasseDevolucaoDifalFcp; overload;

    function EspecieDoDocumentoDeDevolucao: String; overload;
    function EspecieDoDocumentoDeDevolucao(AValue: String): IParametrosClasseDevolucaoDifalFcp; overload;

    function EmpresaDoDocumentoDeDevolucao: String; overload;
    function EmpresaDoDocumentoDeDevolucao(AValue: String): IParametrosClasseDevolucaoDifalFcp; overload;

    function QuantidadeDoItem: Double; overload;
    function QuantidadeDoItem(AValue: Double): IParametrosClasseDevolucaoDifalFcp; overload;

    function ProdutoST: Boolean; overload;
    function ProdutoST(AValue: Boolean): IParametrosClasseDevolucaoDifalFcp; overload;

    function HabilitarNovoCalculoDifalComPercentualBase: Boolean; overload;
    function HabilitarNovoCalculoDifalComPercentualBase(AValue: Boolean): IParametrosClasseDevolucaoDifalFcp; overload;

    class function New(): IParametrosClasseDevolucaoDifalFcp;
  end;

type
  TResultadoClasseDevolucaoDifalFcp = class(TInterfacedObject, IResultadoClasseDevolucaoDifalFcp)
  private
    FBaseDestino: Double;
    FAliquotaFCP: Double;
    FAliquotaInternaEstadoDestino: Double;
    FPercentualProvisorioPartilha: Double;
    FValorFCP: Double;
    FAliquotaInterestadualCalc: Double;
    FIcmsDestino: Double;
    FIcmsOrigem: Double;
    FBaseFCP: Double;
    FBaseIcmsItemDevolucao: Double;
  public
    function BaseDestino: Double; overload;
    function BaseDestino(AValue: Double): IResultadoClasseDevolucaoDifalFcp; overload;

    function AliquotaFCP: Double; overload;
    function AliquotaFCP(AValue: Double): IResultadoClasseDevolucaoDifalFcp; overload;

    function AliquotaInternaEstadoDestino: Double; overload;
    function AliquotaInternaEstadoDestino(AValue: Double): IResultadoClasseDevolucaoDifalFcp; overload;

    function PercentualProvisorioPartilha: Double; overload;
    function PercentualProvisorioPartilha(AValue: Double): IResultadoClasseDevolucaoDifalFcp; overload;

    function ValorFCP: Double; overload;
    function ValorFCP(AValue: Double): IResultadoClasseDevolucaoDifalFcp; overload;

    function AliquotaInterestadualCalc: Double; overload;
    function AliquotaInterestadualCalc(AValue: Double): IResultadoClasseDevolucaoDifalFcp; overload;

    function IcmsDestino: Double; overload;
    function IcmsDestino(AValue: Double): IResultadoClasseDevolucaoDifalFcp; overload;

    function IcmsOrigem: Double; overload;
    function IcmsOrigem(AValue: Double): IResultadoClasseDevolucaoDifalFcp; overload;

    function BaseFCP: Double; overload;
    function BaseFCP(AValue: Double): IResultadoClasseDevolucaoDifalFcp; overload;

    function BaseIcmsItemDevolucao: Double; overload;
    function BaseIcmsItemDevolucao(AValue: Double): IResultadoClasseDevolucaoDifalFcp; overload;

    class function New(): IResultadoClasseDevolucaoDifalFcp;
  end;

implementation

{ TParametrosClasseDevolucaoDifalFcp }

function TParametrosClasseDevolucaoDifalFcp.CodigoDoCliente(
  AValue: String): IParametrosClasseDevolucaoDifalFcp;
begin
  Result := Self;
  FCodigoDoCliente := AValue;
end;

function TParametrosClasseDevolucaoDifalFcp.CodigoDoCliente: String;
begin
  Result := FCodigoDoCliente;
end;

function TParametrosClasseDevolucaoDifalFcp.CodigoDoItem: String;
begin
  Result := FCodigoDoItem;
end;

function TParametrosClasseDevolucaoDifalFcp.CodigoDoItem(
  AValue: String): IParametrosClasseDevolucaoDifalFcp;
begin
  Result := Self;
  FCodigoDoItem := AValue;
end;

function TParametrosClasseDevolucaoDifalFcp.EmpresaDoDocumentoDeDevolucao(
  AValue: String): IParametrosClasseDevolucaoDifalFcp;
begin
  Result := Self;
  FEmpresaDoDocumentoDeDevolucao := AValue;
end;

function TParametrosClasseDevolucaoDifalFcp.EmpresaDoDocumentoDeDevolucao: String;
begin
  Result := FEmpresaDoDocumentoDeDevolucao;
end;

function TParametrosClasseDevolucaoDifalFcp.EspecieDoDocumentoDeDevolucao: String;
begin
  Result := FEspecieDoDocumentoDeDevolucao;
end;

function TParametrosClasseDevolucaoDifalFcp.EspecieDoDocumentoDeDevolucao(
  AValue: String): IParametrosClasseDevolucaoDifalFcp;
begin
  Result := Self;
  FEspecieDoDocumentoDeDevolucao := AValue;
end;

class function TParametrosClasseDevolucaoDifalFcp.New: IParametrosClasseDevolucaoDifalFcp;
begin
  Result := Self.Create;
end;

function TParametrosClasseDevolucaoDifalFcp.NumeroDoDocumentoDeDevolucao: String;
begin
  Result := FNumeroDoDocumentoDeDevolucao;
end;

function TParametrosClasseDevolucaoDifalFcp.NumeroDoDocumentoDeDevolucao(
  AValue: String): IParametrosClasseDevolucaoDifalFcp;
begin
  Result := Self;
  FNumeroDoDocumentoDeDevolucao := AValue;
end;

function TParametrosClasseDevolucaoDifalFcp.ProdutoST: Boolean;
begin
  Result := FProdutoST;
end;

function TParametrosClasseDevolucaoDifalFcp.ProdutoST(
  AValue: Boolean): IParametrosClasseDevolucaoDifalFcp;
begin
  Result := Self;
  FProdutoST := AValue;
end;

function TParametrosClasseDevolucaoDifalFcp.QuantidadeDoItem: Double;
begin
  Result := FQuantidadeDoItem;
end;

function TParametrosClasseDevolucaoDifalFcp.QuantidadeDoItem(
  AValue: Double): IParametrosClasseDevolucaoDifalFcp;
begin
  Result := Self;
  FQuantidadeDoItem := AValue;
end;

function TParametrosClasseDevolucaoDifalFcp.HabilitarNovoCalculoDifalComPercentualBase: Boolean;
begin
  Result := FHabilitarNovoCalculoDifalComPercentualBase;
end;

function TParametrosClasseDevolucaoDifalFcp.HabilitarNovoCalculoDifalComPercentualBase(
  AValue: Boolean): IParametrosClasseDevolucaoDifalFcp;
begin
  Result := Self;
  FHabilitarNovoCalculoDifalComPercentualBase := AValue;
end;

{ TResultadoClasseDevolucaoDifalFcp }

function TResultadoClasseDevolucaoDifalFcp.AliquotaFCP: Double;
begin
  Result := FAliquotaFCP;
end;

function TResultadoClasseDevolucaoDifalFcp.AliquotaFCP(
  AValue: Double): IResultadoClasseDevolucaoDifalFcp;
begin
  Result := Self;
  FAliquotaFCP := AValue;
end;

function TResultadoClasseDevolucaoDifalFcp.AliquotaInterestadualCalc(
  AValue: Double): IResultadoClasseDevolucaoDifalFcp;
begin
  Result := Self;
  FAliquotaInterestadualCalc := AValue;
end;

function TResultadoClasseDevolucaoDifalFcp.AliquotaInterestadualCalc: Double;
begin
  Result := FAliquotaInterestadualCalc;
end;

function TResultadoClasseDevolucaoDifalFcp.AliquotaInternaEstadoDestino(
  AValue: Double): IResultadoClasseDevolucaoDifalFcp;
begin
  Result := Self;
  FAliquotaInternaEstadoDestino := AValue;
end;

function TResultadoClasseDevolucaoDifalFcp.AliquotaInternaEstadoDestino: Double;
begin
  Result := FAliquotaInternaEstadoDestino;
end;

function TResultadoClasseDevolucaoDifalFcp.BaseDestino(
  AValue: Double): IResultadoClasseDevolucaoDifalFcp;
begin
  Result := Self;
  FBaseDestino := AValue;
end;

function TResultadoClasseDevolucaoDifalFcp.BaseDestino: Double;
begin
  Result := FBaseDestino;
end;

function TResultadoClasseDevolucaoDifalFcp.BaseFCP(
  AValue: Double): IResultadoClasseDevolucaoDifalFcp;
begin
  Result := Self;
  FBaseFCP := AValue;
end;

function TResultadoClasseDevolucaoDifalFcp.BaseFCP: Double;
begin
  Result := FBaseFCP
end;

function TResultadoClasseDevolucaoDifalFcp.IcmsDestino: Double;
begin
  Result := FIcmsDestino;
end;

function TResultadoClasseDevolucaoDifalFcp.IcmsDestino(
  AValue: Double): IResultadoClasseDevolucaoDifalFcp;
begin
  Result := Self;
  FIcmsDestino := AValue;
end;

function TResultadoClasseDevolucaoDifalFcp.BaseIcmsItemDevolucao: Double;
begin
  Result := FBaseIcmsItemDevolucao;
end;

function TResultadoClasseDevolucaoDifalFcp.BaseIcmsItemDevolucao(
  AValue: Double): IResultadoClasseDevolucaoDifalFcp;
begin
  Result := Self;
  FBaseIcmsItemDevolucao := AValue;
end;

function TResultadoClasseDevolucaoDifalFcp.IcmsOrigem: Double;
begin
  Result := FIcmsOrigem;
end;

function TResultadoClasseDevolucaoDifalFcp.IcmsOrigem(
  AValue: Double): IResultadoClasseDevolucaoDifalFcp;
begin
  Result := Self;
  FIcmsOrigem := AValue;
end;

class function TResultadoClasseDevolucaoDifalFcp.New: IResultadoClasseDevolucaoDifalFcp;
begin
  Result := Self.Create;
end;

function TResultadoClasseDevolucaoDifalFcp.PercentualProvisorioPartilha: Double;
begin
  Result := FPercentualProvisorioPartilha;
end;

function TResultadoClasseDevolucaoDifalFcp.PercentualProvisorioPartilha(
  AValue: Double): IResultadoClasseDevolucaoDifalFcp;
begin
  Result := Self;
  FPercentualProvisorioPartilha := AValue;
end;

function TResultadoClasseDevolucaoDifalFcp.ValorFCP(
  AValue: Double): IResultadoClasseDevolucaoDifalFcp;
begin
  Result := Self;
  FValorFCP := AValue;
end;

function TResultadoClasseDevolucaoDifalFcp.ValorFCP: Double;
begin
  Result := FValorFCP;
end;

end.
