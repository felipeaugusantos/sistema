unit Faturamento.Impostos.Tipos.Difal;

interface

uses
  Faturamento.Impostos.Interfaces.Difal, Shared.Functions.Types;

type
  TParametrosCalculoDifal = class(TInterfacedObject, IParametrosCalculoDifal)
  private
    FValorIpiDoItem :Double;
    FValorFreteDoItem :Double;
    FAliquotaInterestadualCalc :Double;
    FValorIcmsBase :Double;
    FTotalDoItem :Double;
    FDescontoEspecialDoItem :Double;
    FPercentualProvisorioPartilha :Double;
    FDespesaAcessoriaDoItem :Double;
    FPercentualBaseOrigem :Double;
    FPercentualBaseDestino :Double;
    FPercentualBaseDifalOrigem :Double;
    FPercentualBaseDifalDestino :Double;
    FCalculaAliquotaInterestadual :Double;
    FCalculaAliquotaEfetivaOrigem :Double;
    FAliquotaInternaEstadoDestino :Double;
    FSituacaoReducaoBaseCalculo: Boolean;
    FCodigoSituacaoTributaria: String;
    FProdutoSt : Boolean;
    FSimplesNacional : Boolean;
    FAbreviacaoIcmsProduto : Boolean;
    FAbreviacaoIcmsProdutoUfEmpresa : Boolean;
    FHabilitarPercentualBase : Boolean;
    FCalculaTipoDeAbreviacaoFiscal : Boolean;
    FCalculaBaseReduzidaAliquotaEfetiva : Boolean;
    FCalculaDiferencialAliquotaProdutosSt : Boolean;    
    FRecordDifalFCP: TRecDifalFCP;
    FProdutoDeOrigemEstrangeira: Boolean;
    FConsiderarAliquotaEfetivaProdutosImportados: Boolean;
    FEntraIPInaBaseIcms: Boolean;
    FClassificacaoFiscalDoItem: String;
    FHabilitarNovoCalculoDifalComPercentualBase: Boolean;
    FCalculaDifalParaCombustiveis_e_LubrificantesNaoTributados: Boolean;
  public
    function ValorIpiDoItem :Double; overload;
    function ValorIpiDoItem(AValue: Double): IParametrosCalculoDifal; overload;

    function ValorFreteDoItem :Double; overload;
    function ValorFreteDoItem(AValue: Double): IParametrosCalculoDifal; overload;

    function AliquotaInterestadualCalc :Double; overload;
    function AliquotaInterestadualCalc(AValue: Double): IParametrosCalculoDifal; overload;

    function ValorIcmsBase:Double; overload;
    function ValorIcmsBase(AValue: Double): IParametrosCalculoDifal; overload;

    function TotalDoItem :Double; overload;
    function TotalDoItem(AValue: Double): IParametrosCalculoDifal; overload;

    function DescontoEspecialDoItem :Double; overload;
    function DescontoEspecialDoItem(AValue: Double): IParametrosCalculoDifal; overload;

    function DespesaAcessoriaDoItem :Double; overload;
    function DespesaAcessoriaDoItem(AValue: Double): IParametrosCalculoDifal; overload;

    function PercentualBaseOrigem :Double; overload;
    function PercentualBaseOrigem(AValue: Double): IParametrosCalculoDifal; overload;

    function PercentualBaseDestino :Double; overload;
    function PercentualBaseDestino(AValue: Double): IParametrosCalculoDifal; overload;

    function PercentualBaseDifalOrigem :Double; overload;
    function PercentualBaseDifalOrigem(AValue: Double): IParametrosCalculoDifal; overload;

    function PercentualBaseDifalDestino :Double; overload;
    function PercentualBaseDifalDestino(AValue: Double): IParametrosCalculoDifal; overload;

    function CalculaAliquotaInterestadual :Double; overload;
    function CalculaAliquotaInterestadual(AValue: Double): IParametrosCalculoDifal; overload;

    function CalculaAliquotaEfetivaOrigem :Double; overload;
    function CalculaAliquotaEfetivaOrigem(AValue: Double): IParametrosCalculoDifal; overload;

    function AliquotaInternaEstadoDestino :Double; overload;
    function AliquotaInternaEstadoDestino(AValue: Double): IParametrosCalculoDifal; overload;

    function ProdutoSt : Boolean; overload;
    function ProdutoSt(AValue: Boolean): IParametrosCalculoDifal; overload;

    function SimplesNacional : Boolean; overload;
    function SimplesNacional(AValue: Boolean): IParametrosCalculoDifal; overload;

    function AbreviacaoIcmsProduto : Boolean; overload;
    function AbreviacaoIcmsProduto(AValue: Boolean): IParametrosCalculoDifal; overload;

    function AbreviacaoIcmsProdutoUfEmpresa : Boolean; overload;
    function AbreviacaoIcmsProdutoUfEmpresa(AValue: Boolean): IParametrosCalculoDifal; overload;

    function HabilitarPercentualBase : Boolean; overload;
    function HabilitarPercentualBase(AValue: Boolean): IParametrosCalculoDifal; overload;

    function SituacaoReducaoBaseCalculo : Boolean; overload;
    function SituacaoReducaoBaseCalculo(AValue: Boolean): IParametrosCalculoDifal; overload;

    function CalculaBaseReduzidaAliquotaEfetiva : Boolean; overload;
    function CalculaBaseReduzidaAliquotaEfetiva(AValue: Boolean): IParametrosCalculoDifal; overload;

    function CalculaDiferencialAliquotaProdutosSt : Boolean; overload;
    function CalculaDiferencialAliquotaProdutosSt(AValue: Boolean): IParametrosCalculoDifal; overload;

    function CalculaTipoDeAbreviacaoFiscal:Boolean; overload;
    function CalculaTipoDeAbreviacaoFiscal(AValue: Boolean): IParametrosCalculoDifal; overload;

    function PercentualProvisorioPartilha :Double; overload;
    function PercentualProvisorioPartilha(AValue: Double): IParametrosCalculoDifal; overload;

    function CodigoSituacaoTributaria :String; overload;
    function CodigoSituacaoTributaria(AValue: String): IParametrosCalculoDifal; overload;

    function RecordDifalFCP: TRecDifalFCP; overload;
    function RecordDifalFCP(AValue: TRecDifalFCP): IParametrosCalculoDifal; overload;

    function ProdutoDeOrigemEstrangeira: Boolean; overload;
    function ProdutoDeOrigemEstrangeira(AValue: Boolean): IParametrosCalculoDifal; overload;

    function ConsiderarAliquotaEfetivaProdutosImportados: Boolean; overload;
    function ConsiderarAliquotaEfetivaProdutosImportados(AValue: Boolean): IParametrosCalculoDifal; overload;

    function EntraIPInaBaseIcms: Boolean; overload;
    function EntraIPInaBaseIcms(AValue: Boolean): IParametrosCalculoDifal; overload;

    function ClassificacaoFiscalDoItem : String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosCalculoDifal; overload;

    function HabilitarNovoCalculoDifalComPercentualBase : Boolean; overload;
    function HabilitarNovoCalculoDifalComPercentualBase(AValue: Boolean): IParametrosCalculoDifal; overload;

    function CalculaDifalParaCombustiveis_e_LubrificantesNaoTributados : Boolean; overload;
    function CalculaDifalParaCombustiveis_e_LubrificantesNaoTributados(AValue: Boolean): IParametrosCalculoDifal; overload;

    class function New(): IParametrosCalculoDifal;
  end;

type
  TResultadoCalculoDifal = class(TInterfacedObject, IResultadoCalculoDifal)
  private
    FValorBaseDestino: Double;
    FValorIcmsDestino: Double;
    FValorIcmsOrigem: Double;
    FAliquotaInterestadualCalc: Double;
    FRecordDifalFCP: TRecDifalFCP;
  public
    function ValorBaseDestino: Double; overload;
    function ValorBaseDestino(AValue: Double): IResultadoCalculoDifal; overload;

    function ValorIcmsDestino: Double; overload;
    function ValorIcmsDestino(AValue: Double): IResultadoCalculoDifal; overload;

    function ValorIcmsOrigem: Double; overload;
    function ValorIcmsOrigem(AValue: Double): IResultadoCalculoDifal; overload;

    function AliquotaInterestadualCalc: Double; overload;
    function AliquotaInterestadualCalc(AValue: Double): IResultadoCalculoDifal; overload;

    function RecordDifalFCP: TRecDifalFCP; overload;
    function RecordDifalFCP(AValue: TRecDifalFCP): IResultadoCalculoDifal; overload;

    class function New(): IResultadoCalculoDifal;
  end;

implementation

{ TParametrosCalculoDifal }

function TParametrosCalculoDifal.AbreviacaoIcmsProduto(
  AValue: Boolean): IParametrosCalculoDifal;
begin
  Result := Self;
  FAbreviacaoIcmsProduto := AValue;
end;

function TParametrosCalculoDifal.AbreviacaoIcmsProduto: Boolean;
begin
  Result := FAbreviacaoIcmsProduto;
end;

function TParametrosCalculoDifal.AbreviacaoIcmsProdutoUfEmpresa(
  AValue: Boolean): IParametrosCalculoDifal;
begin
  Result := Self;
  FAbreviacaoIcmsProdutoUfEmpresa := AValue;
end;

function TParametrosCalculoDifal.AbreviacaoIcmsProdutoUfEmpresa: Boolean;
begin
  Result := FAbreviacaoIcmsProdutoUfEmpresa;
end;

function TParametrosCalculoDifal.AliquotaInternaEstadoDestino: Double;
begin
  Result := FAliquotaInternaEstadoDestino;
end;

function TParametrosCalculoDifal.AliquotaInternaEstadoDestino(
  AValue: Double): IParametrosCalculoDifal;
begin
  Result := Self;
  FAliquotaInternaEstadoDestino := AValue;
end;

function TParametrosCalculoDifal.CalculaAliquotaEfetivaOrigem: Double;
begin
  Result := FCalculaAliquotaEfetivaOrigem;
end;

function TParametrosCalculoDifal.CalculaAliquotaEfetivaOrigem(
  AValue: Double): IParametrosCalculoDifal;
begin
  Result := Self;
  FCalculaAliquotaEfetivaOrigem := AValue;
end;

function TParametrosCalculoDifal.CalculaAliquotaInterestadual(
  AValue: Double): IParametrosCalculoDifal;
begin
  Result := Self;
  FCalculaAliquotaInterestadual := AValue;
end;

function TParametrosCalculoDifal.CalculaAliquotaInterestadual: Double;
begin
  Result := FCalculaAliquotaInterestadual;
end;

function TParametrosCalculoDifal.CalculaBaseReduzidaAliquotaEfetiva(
  AValue: Boolean): IParametrosCalculoDifal;
begin
  Result := Self;
  FCalculaBaseReduzidaAliquotaEfetiva := AValue;
end;

function TParametrosCalculoDifal.CodigoSituacaoTributaria: String;
begin
  Result := FCodigoSituacaoTributaria;
end;

function TParametrosCalculoDifal.CodigoSituacaoTributaria(
  AValue: String): IParametrosCalculoDifal;
begin
  Result := Self;
  FCodigoSituacaoTributaria := AValue;
end;

function TParametrosCalculoDifal.ConsiderarAliquotaEfetivaProdutosImportados: Boolean;
begin
  Result := FConsiderarAliquotaEfetivaProdutosImportados;
end;

function TParametrosCalculoDifal.ConsiderarAliquotaEfetivaProdutosImportados(
  AValue: Boolean): IParametrosCalculoDifal;
begin
  Result := Self;
  FConsiderarAliquotaEfetivaProdutosImportados := AValue;
end;

function TParametrosCalculoDifal.CalculaBaseReduzidaAliquotaEfetiva: Boolean;
begin
  Result := FCalculaBaseReduzidaAliquotaEfetiva;
end;

function TParametrosCalculoDifal.CalculaDiferencialAliquotaProdutosSt: Boolean;
begin
  Result := FCalculaDiferencialAliquotaProdutosSt;
end;

function TParametrosCalculoDifal.CalculaDifalParaCombustiveis_e_LubrificantesNaoTributados: Boolean;
begin
  Result := FCalculaDifalParaCombustiveis_e_LubrificantesNaoTributados;
end;

function TParametrosCalculoDifal.CalculaDifalParaCombustiveis_e_LubrificantesNaoTributados(AValue: Boolean): IParametrosCalculoDifal;
begin
  Result := Self;
  FCalculaDifalParaCombustiveis_e_LubrificantesNaoTributados := AValue;
end;

function TParametrosCalculoDifal.CalculaDiferencialAliquotaProdutosSt(
  AValue: Boolean): IParametrosCalculoDifal;
begin
  Result := Self;
  FCalculaDiferencialAliquotaProdutosSt := AValue;
end;


function TParametrosCalculoDifal.CalculaTipoDeAbreviacaoFiscal: Boolean;
begin
  Result := FCalculaTipoDeAbreviacaoFiscal;
end;

function TParametrosCalculoDifal.CalculaTipoDeAbreviacaoFiscal(
  AValue: Boolean): IParametrosCalculoDifal;
begin
  Result := Self;
  FCalculaTipoDeAbreviacaoFiscal := AValue;
end;

function TParametrosCalculoDifal.DescontoEspecialDoItem: Double;
begin
  Result := FDescontoEspecialDoItem;
end;

function TParametrosCalculoDifal.DescontoEspecialDoItem(
  AValue: Double): IParametrosCalculoDifal;
begin
  Result := Self;
  FDescontoEspecialDoItem := AValue;
end;

function TParametrosCalculoDifal.DespesaAcessoriaDoItem(
  AValue: Double): IParametrosCalculoDifal;
begin
  Result := Self;
  FDespesaAcessoriaDoItem := AValue;
end;

function TParametrosCalculoDifal.DespesaAcessoriaDoItem: Double;
begin
  Result := FDespesaAcessoriaDoItem;
end;

function TParametrosCalculoDifal.HabilitarPercentualBase: Boolean;
begin
  Result := FHabilitarPercentualBase;
end;

function TParametrosCalculoDifal.HabilitarPercentualBase(
  AValue: Boolean): IParametrosCalculoDifal;
begin
  Result := Self;
  FHabilitarPercentualBase := AValue;
end;

class function TParametrosCalculoDifal.New: IParametrosCalculoDifal;
begin
  Result := Self.Create;
end;

function TParametrosCalculoDifal.PercentualBaseDestino(
  AValue: Double): IParametrosCalculoDifal;
begin
  Result := Self;
  FPercentualBaseDestino := AValue;
end;

function TParametrosCalculoDifal.PercentualBaseDestino: Double;
begin
  Result := FPercentualBaseDestino;
end;

function TParametrosCalculoDifal.PercentualBaseDifalDestino: Double;
begin
  Result := FPercentualBaseDifalDestino;
end;

function TParametrosCalculoDifal.PercentualBaseDifalDestino(
  AValue: Double): IParametrosCalculoDifal;
begin
  Result := Self;
  FPercentualBaseDifalDestino := AValue;
end;

function TParametrosCalculoDifal.PercentualBaseDifalOrigem: Double;
begin
  Result := FPercentualBaseDifalOrigem;
end;

function TParametrosCalculoDifal.PercentualBaseDifalOrigem(
  AValue: Double): IParametrosCalculoDifal;
begin
  Result := Self;
  FPercentualBaseDifalOrigem := AValue;
end;

function TParametrosCalculoDifal.PercentualBaseOrigem(
  AValue: Double): IParametrosCalculoDifal;
begin
  Result := Self;
  FPercentualBaseOrigem := AValue;
end;

function TParametrosCalculoDifal.PercentualBaseOrigem: Double;
begin
  Result := FPercentualBaseOrigem;
end;

function TParametrosCalculoDifal.ProdutoDeOrigemEstrangeira: Boolean;
begin
  Result := FProdutoDeOrigemEstrangeira;
end;

function TParametrosCalculoDifal.ProdutoDeOrigemEstrangeira(
  AValue: Boolean): IParametrosCalculoDifal;
begin
  Result := Self;
  FProdutoDeOrigemEstrangeira := AValue;
end;

function TParametrosCalculoDifal.ProdutoSt(
  AValue: Boolean): IParametrosCalculoDifal;
begin
  Result := Self;
  FProdutoSt := AValue;
end;

function TParametrosCalculoDifal.RecordDifalFCP: TRecDifalFCP;
begin
  Result := FRecordDifalFCP;
end;

function TParametrosCalculoDifal.RecordDifalFCP(
  AValue: TRecDifalFCP): IParametrosCalculoDifal;
begin
  Result := Self;
  FRecordDifalFCP := AValue;
end;

function TParametrosCalculoDifal.ProdutoSt: Boolean;
begin
  Result := FProdutoSt;
end;

function TParametrosCalculoDifal.SimplesNacional(
  AValue: Boolean): IParametrosCalculoDifal;
begin
  Result := Self;
  FSimplesNacional := AValue;
end;

function TParametrosCalculoDifal.SituacaoReducaoBaseCalculo: Boolean;
begin
  Result := FSituacaoReducaoBaseCalculo;
end;

function TParametrosCalculoDifal.SituacaoReducaoBaseCalculo(
  AValue: Boolean): IParametrosCalculoDifal;
begin
  Result := Self;
  FSituacaoReducaoBaseCalculo := AValue;
end;

function TParametrosCalculoDifal.SimplesNacional: Boolean;
begin
  Result := FSimplesNacional;
end;

function TParametrosCalculoDifal.TotalDoItem(
  AValue: Double): IParametrosCalculoDifal;
begin
  Result := Self;
  FTotalDoItem := AValue;
end;

function TParametrosCalculoDifal.TotalDoItem: Double;
begin
  Result := FTotalDoItem;
end;

function TParametrosCalculoDifal.ValorFreteDoItem: Double;
begin
  Result := FValorFreteDoItem;
end;

function TParametrosCalculoDifal.ValorFreteDoItem(
  AValue: Double): IParametrosCalculoDifal;
begin
  Result := Self;
  FValorFreteDoItem := AValue;
end;

function TParametrosCalculoDifal.ValorIpiDoItem: Double;
begin
  Result := FValorIpiDoItem;
end;

function TParametrosCalculoDifal.AliquotaInterestadualCalc: Double;
begin
  Result := FAliquotaInterestadualCalc;
end;

function TParametrosCalculoDifal.AliquotaInterestadualCalc(
  AValue: Double): IParametrosCalculoDifal;
begin
  Result := Self;
  FAliquotaInterestadualCalc := AValue;
end;

function TParametrosCalculoDifal.ValorIcmsBase: Double;
begin
  Result := FValorIcmsBase;
end;

function TParametrosCalculoDifal.ValorIcmsBase(
  AValue: Double): IParametrosCalculoDifal;
begin
  Result := Self;
  FValorIcmsBase := AValue;
end;

function TParametrosCalculoDifal.ValorIpiDoItem(
  AValue: Double): IParametrosCalculoDifal;
begin
  Result := Self;
  FValorIpiDoItem := AValue;
end;

function TParametrosCalculoDifal.PercentualProvisorioPartilha: Double;
begin
  Result := FPercentualProvisorioPartilha;
end;

function TParametrosCalculoDifal.PercentualProvisorioPartilha(
  AValue: Double): IParametrosCalculoDifal;
begin
  Result := Self;
  FPercentualProvisorioPartilha := AValue;
end;

function TParametrosCalculoDifal.EntraIPInaBaseIcms: Boolean;
begin
  Result := FEntraIPInaBaseIcms;
end;

function TParametrosCalculoDifal.EntraIPInaBaseIcms(
  AValue: Boolean): IParametrosCalculoDifal;
begin
  Result := Self;
  FEntraIPInaBaseIcms := AValue;
end;

function TParametrosCalculoDifal.ClassificacaoFiscalDoItem: String;
begin
  Result := FClassificacaoFiscalDoItem;
end;

function TParametrosCalculoDifal.ClassificacaoFiscalDoItem(
  AValue: String): IParametrosCalculoDifal;
begin
  Result := Self;
  FClassificacaoFiscalDoItem := AValue;
end;

function TParametrosCalculoDifal.HabilitarNovoCalculoDifalComPercentualBase: Boolean;
begin
  Result := FHabilitarNovoCalculoDifalComPercentualBase;
end;

function TParametrosCalculoDifal.HabilitarNovoCalculoDifalComPercentualBase(
  AValue: Boolean): IParametrosCalculoDifal;
begin
  Result := Self;
  FHabilitarNovoCalculoDifalComPercentualBase := AValue;
end;

{ TResultadoCalculoDifal }

function TResultadoCalculoDifal.AliquotaInterestadualCalc: Double;
begin
  Result := FAliquotaInterestadualCalc;
end;

function TResultadoCalculoDifal.AliquotaInterestadualCalc(
  AValue: Double): IResultadoCalculoDifal;
begin
  Result := Self;
  FAliquotaInterestadualCalc := AValue;
end;

class function TResultadoCalculoDifal.New: IResultadoCalculoDifal;
begin
  Result := Self.Create;
end;

function TResultadoCalculoDifal.RecordDifalFCP(
  AValue: TRecDifalFCP): IResultadoCalculoDifal;
begin
  Result := Self;
  FRecordDifalFCP := AValue;
end;

function TResultadoCalculoDifal.RecordDifalFCP: TRecDifalFCP;
begin
  Result := FRecordDifalFCP;
end;

function TResultadoCalculoDifal.ValorBaseDestino: Double;
begin
  Result := FValorBaseDestino;
end;

function TResultadoCalculoDifal.ValorBaseDestino(
  AValue: Double): IResultadoCalculoDifal;
begin
  Result := Self;
  FValorBaseDestino := AValue;
end;

function TResultadoCalculoDifal.ValorIcmsDestino: Double;
begin
  Result := FValorIcmsDestino;
end;

function TResultadoCalculoDifal.ValorIcmsDestino(
  AValue: Double): IResultadoCalculoDifal;
begin
  Result := Self;
  FValorIcmsDestino := AValue;
end;

function TResultadoCalculoDifal.ValorIcmsOrigem(
  AValue: Double): IResultadoCalculoDifal;
begin
  Result := Self;
  FValorIcmsOrigem := AValue;
end;

function TResultadoCalculoDifal.ValorIcmsOrigem: Double;
begin
  Result := FValorIcmsOrigem;
end;

end.
