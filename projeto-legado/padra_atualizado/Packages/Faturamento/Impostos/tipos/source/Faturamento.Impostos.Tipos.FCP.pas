unit Faturamento.Impostos.Tipos.FCP;

interface

uses Faturamento.Impostos.Interfaces.FCP, Shared.Functions.Types;

type
  TParametrosCalculoFCP = class(TInterfacedObject, IParametrosCalculoFCP)
  private
    FAtendeRegrasDIFAL: Boolean;
    FVendaPresencial: Boolean;
    FSubstituicaoTributariaDoItem: Boolean;
    FBaseDeCalculoDoIcmsDoItem: Double;
    FAliquotaFCPAbrevicaoIcms: Double;
    FDocumentoDeDevolucao: Boolean;
    FDiferencaFCPST: Boolean;
    FBaseDeCalculoDaSubstituicaoTributariaDoItem: Double;
    FAliquotaFCPST: Double;
    FCalcularBeneficioReducaoBaseIcmsST: Boolean;
    FClienteEstado: String;
    FOutrasSaidasParaFornecedores: Boolean;
    FRecordDifalFCP: TRecDifalFCP;
    FZerarFCP: Boolean;
    FProdutoIndustrializadoDentroDoEstado: Boolean;
    FSimplesNacional: Boolean;
    FBeneficioReducaoBaseIcmsSTBaseFcpStSemDeducaoDeBaseIcms : boolean;
    FDevolucaoInterestadualComProdutoSt: boolean;
    FCalculaFCPComReducaoBaseIcmsST: boolean;
    FProdutoRevendaDentroDoEstado: boolean;
    FProdutoEmbalagem: String;
    FBaseDeCalculoDoIcmsDoItemBenST: Double;
    FOpcaoDeDocumento: String;
    FEspecieDoDocumento: String;
  public
    function AtendeRegrasDIFAL: Boolean; overload;
    function AtendeRegrasDIFAL(AValue: Boolean): IParametrosCalculoFCP; overload;

    function VendaPresencial: Boolean; overload;
    function VendaPresencial(AValue: Boolean): IParametrosCalculoFCP; overload;

    function SubstituicaoTributariaDoItem: Boolean; overload;
    function SubstituicaoTributariaDoItem(AValue: Boolean): IParametrosCalculoFCP; overload;

    function BaseDeCalculoDoIcmsDoItem: Double; overload;
    function BaseDeCalculoDoIcmsDoItem(AValue: Double): IParametrosCalculoFCP; overload;

    function AliquotaFCPAbrevicaoIcms: Double; overload;
    function AliquotaFCPAbrevicaoIcms(AValue: Double): IParametrosCalculoFCP; overload;

    function DocumentoDeDevolucao: Boolean; overload;
    function DocumentoDeDevolucao(AValue: Boolean): IParametrosCalculoFCP; overload;

    function DiferencaFCPST: Boolean; overload;
    function DiferencaFCPST(AValue: Boolean): IParametrosCalculoFCP; overload;

    function BaseDeCalculoDaSubstituicaoTributariaDoItem: Double; overload;
    function BaseDeCalculoDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosCalculoFCP; overload;

    function AliquotaFCPST: Double; overload;
    function AliquotaFCPST(AValue: Double): IParametrosCalculoFCP; overload;

    function CalcularBeneficioReducaoBaseIcmsST: Boolean; overload;
    function CalcularBeneficioReducaoBaseIcmsST(AValue: Boolean): IParametrosCalculoFCP; overload;

    function ClienteEstado: String; overload;
    function ClienteEstado(AValue: String): IParametrosCalculoFCP; overload;

    function OutrasSaidasParaFornecedores: Boolean; overload;
    function OutrasSaidasParaFornecedores(AValue: Boolean): IParametrosCalculoFCP; overload;

    function RecordDifalFCP: TRecDifalFCP; overload;
    function RecordDifalFCP(AValue: TRecDifalFCP): IParametrosCalculoFCP; overload;

    function ZerarFCP: Boolean; overload;
    function ZerarFCP(AValue: Boolean): IParametrosCalculoFCP; overload;

    function ProdutoIndustrializadoDentroDoEstado: Boolean; overload;
    function ProdutoIndustrializadoDentroDoEstado(AValue: Boolean): IParametrosCalculoFCP; overload;

    function SimplesNacional: Boolean; overload;
    function SimplesNacional(AValue: Boolean): IParametrosCalculoFCP; overload;

    function BeneficioReducaoBaseIcmsSTBaseFcpStSemDeducaoDeBaseIcms: Boolean; overload;
    function BeneficioReducaoBaseIcmsSTBaseFcpStSemDeducaoDeBaseIcms(AValue: Boolean): IParametrosCalculoFCP; overload;

    function DevolucaoInterestadualComProdutoSt: Boolean; overload;
    function DevolucaoInterestadualComProdutoSt(AValue: Boolean): IParametrosCalculoFCP; overload;

    function CalculaFCPComReducaoBaseIcmsST: Boolean; overload;
    function CalculaFCPComReducaoBaseIcmsST(AValue: Boolean): IParametrosCalculoFCP; overload;

    function ProdutoRevendaDentroDoEstado: Boolean; overload;
    function ProdutoRevendaDentroDoEstado(AValue: Boolean): IParametrosCalculoFCP; overload;

    function ProdutoEmbalagem: String; overload;
    function ProdutoEmbalagem(const AValue: String): IParametrosCalculoFCP; overload;

    function BaseDeCalculoDoIcmsDoItemBenST: Double; overload;
    function BaseDeCalculoDoIcmsDoItemBenST(AValue: Double): IParametrosCalculoFCP; overload;

    function OpcaoDeDocumento: String; overload;
    function OpcaoDeDocumento(const AValue: String): IParametrosCalculoFCP; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(const AValue: String): IParametrosCalculoFCP; overload;

    class function New(): IParametrosCalculoFCP;
  end;

type
  TResultadoCalculoFCP = class(TInterfacedObject, IResultadoCalculoFCP)
  private
    FZerarDifal: Boolean;
    FSairDoProcedimento: Boolean;
    FGravarOsRegistros: Boolean;
    FAliquotaDoFCPDoItem: Double;
    FBaseDestino: Double;
    FBaseFCP: Double;
    FValorFCP: Double;
    FAliquotaFCPST: Double;
    FRecordDifalFCP: TRecDifalFCP;
  public
    function ZerarDifal: Boolean; overload;
    function ZerarDifal(AValue: Boolean): IResultadoCalculoFCP; overload;

    function SairDoProcedimento: Boolean; overload;
    function SairDoProcedimento(AValue: Boolean): IResultadoCalculoFCP; overload;

    function GravarOsRegistros: Boolean; overload;
    function GravarOsRegistros(AValue: Boolean): IResultadoCalculoFCP; overload;

    function AliquotaDoFCPDoItem: Double; overload;
    function AliquotaDoFCPDoItem(AValue: Double): IResultadoCalculoFCP; overload;

    function BaseDestino: Double; overload;
    function BaseDestino(AValue: Double): IResultadoCalculoFCP; overload;

    function BaseFCP: Double; overload;
    function BaseFCP(AValue: Double): IResultadoCalculoFCP; overload;

    function ValorFCP: Double; overload;
    function ValorFCP(AValue: Double): IResultadoCalculoFCP; overload;

    function AliquotaFCPST: Double; overload;
    function AliquotaFCPST(AValue: Double): IResultadoCalculoFCP; overload;

    function RecordDifalFCP: TRecDifalFCP; overload;
    function RecordDifalFCP(AValue: TRecDifalFCP): IResultadoCalculoFCP; overload;

    class function New(): IResultadoCalculoFCP;
  end;

type
  TParametrosCalculoDifalFcp = class(TInterfacedObject, IParametrosCalculoDifalFcp)
  private
    FAliquotaFCPDoItem: Double;
    FAliquotaDifalDoItem: Double;
    FSimplesNacional: Boolean;
    FEnviarIcmsDifalDoRemetenteNaPartilha: Boolean;
    FEnviarIcmsDifalDoDestinoNaPartilha: Boolean;
    FIcmsDeOrigem: Double;
    FIcmsDeDestino: Double;
    FBaseDeCalculoDaSubstituicaoTributariaDoItem: Double;
    FBaseDestino: Double;
    FZerarFCP: Boolean;
  public
    function AliquotaFCPDoItem: Double; overload;
    function AliquotaFCPDoItem(AValue: Double): IParametrosCalculoDifalFcp; overload;

    function AliquotaDifalDoItem: Double; overload;
    function AliquotaDifalDoItem(AValue: Double): IParametrosCalculoDifalFcp; overload;

    function SimplesNacional: Boolean; overload;
    function SimplesNacional(AValue: Boolean): IParametrosCalculoDifalFcp; overload;

    function EnviarIcmsDifalDoRemetenteNaPartilha: Boolean; overload;
    function EnviarIcmsDifalDoRemetenteNaPartilha(AValue: Boolean): IParametrosCalculoDifalFcp; overload;

    function EnviarIcmsDifalDoDestinoNaPartilha: Boolean; overload;
    function EnviarIcmsDifalDoDestinoNaPartilha(AValue: Boolean): IParametrosCalculoDifalFcp; overload;

    function IcmsDeOrigem: Double; overload;
    function IcmsDeOrigem(AValue: Double): IParametrosCalculoDifalFcp; overload;

    function IcmsDeDestino: Double; overload;
    function IcmsDeDestino(AValue: Double): IParametrosCalculoDifalFcp; overload;

    function BaseDeCalculoDaSubstituicaoTributariaDoItem: Double; overload;
    function BaseDeCalculoDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosCalculoDifalFcp; overload;

    function BaseDestino: Double; overload;
    function BaseDestino(AValue: Double): IParametrosCalculoDifalFcp; overload;

    function ZerarFCP: Boolean; overload;
    function ZerarFCP(AValue: Boolean): IParametrosCalculoDifalFcp; overload;

    class function New(): IParametrosCalculoDifalFcp;
  end;

type
  TResultadoCalculoDifalFcp = class(TInterfacedObject, IResultadoCalculoDifalFcp)
  private
   FAliquotaDifalDoItem: Double;
   FIcmsDeOrigem: Double;
   FIcmsDeDestino: Double;
   FBaseFCP: Double;
   FValorFCP: Double;
  public
    function AliquotaDifalDoItem: Double; overload;
    function AliquotaDifalDoItem(AValue: Double): IResultadoCalculoDifalFcp; overload;

    function IcmsDeOrigem: Double; overload;
    function IcmsDeOrigem(AValue: Double): IResultadoCalculoDifalFcp; overload;

    function IcmsDeDestino: Double; overload;
    function IcmsDeDestino(AValue: Double): IResultadoCalculoDifalFcp; overload;

    function BaseFCP: Double; overload;
    function BaseFCP(AValue: Double): IResultadoCalculoDifalFcp; overload;

    function ValorFCP: Double; overload;
    function ValorFCP(AValue: Double): IResultadoCalculoDifalFcp; overload;

    class function New(): IResultadoCalculoDifalFcp;
  end;

implementation

{ TParametrosCalculoFCP }

function TParametrosCalculoFCP.AliquotaFCPAbrevicaoIcms(
  AValue: Double): IParametrosCalculoFCP;
begin
  Result := Self;
  FAliquotaFCPAbrevicaoIcms := AValue;
end;

function TParametrosCalculoFCP.AliquotaFCPAbrevicaoIcms: Double;
begin
  Result := FAliquotaFCPAbrevicaoIcms;
end;

function TParametrosCalculoFCP.AliquotaFCPST(
  AValue: Double): IParametrosCalculoFCP;
begin
  Result := Self;
  FAliquotaFCPST := AValue;
end;

function TParametrosCalculoFCP.AliquotaFCPST: Double;
begin
  Result := FAliquotaFCPST;
end;

function TParametrosCalculoFCP.AtendeRegrasDIFAL: Boolean;
begin
  Result := FAtendeRegrasDIFAL;
end;

function TParametrosCalculoFCP.AtendeRegrasDIFAL(
  AValue: Boolean): IParametrosCalculoFCP;
begin
  Result := Self;
  FAtendeRegrasDIFAL := AValue;
end;

function TParametrosCalculoFCP.BaseDeCalculoDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FBaseDeCalculoDaSubstituicaoTributariaDoItem;
end;

function TParametrosCalculoFCP.BaseDeCalculoDaSubstituicaoTributariaDoItem(
  AValue: Double): IParametrosCalculoFCP;
begin
  Result := Self;
  FBaseDeCalculoDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosCalculoFCP.BaseDeCalculoDoIcmsDoItemBenST: Double;
begin
  Result := FBaseDeCalculoDoIcmsDoItemBenST;
end;

function TParametrosCalculoFCP.BaseDeCalculoDoIcmsDoItemBenST(
  AValue: Double): IParametrosCalculoFCP;
begin
  Result := Self;
  FBaseDeCalculoDoIcmsDoItemBenST := AValue;
end;

function TParametrosCalculoFCP.BaseDeCalculoDoIcmsDoItem: Double;
begin
  Result := FBaseDeCalculoDoIcmsDoItem;
end;

function TParametrosCalculoFCP.BaseDeCalculoDoIcmsDoItem(
  AValue: Double): IParametrosCalculoFCP;
begin
  Result := Self;
  FBaseDeCalculoDoIcmsDoItem := AValue;
end;

function TParametrosCalculoFCP.BeneficioReducaoBaseIcmsSTBaseFcpStSemDeducaoDeBaseIcms: Boolean;
begin
  Result := FBeneficioReducaoBaseIcmsSTBaseFcpStSemDeducaoDeBaseIcms;
end;

function TParametrosCalculoFCP.ProdutoRevendaDentroDoEstado(
  AValue: Boolean): IParametrosCalculoFCP;
begin
  Result := Self;
  FProdutoRevendaDentroDoEstado := AValue;
end;

function TParametrosCalculoFCP.ProdutoRevendaDentroDoEstado: Boolean;
begin
  Result := FProdutoRevendaDentroDoEstado;
end;

function TParametrosCalculoFCP.BeneficioReducaoBaseIcmsSTBaseFcpStSemDeducaoDeBaseIcms(
  AValue: Boolean): IParametrosCalculoFCP;
begin
  Result := Self;
  FBeneficioReducaoBaseIcmsSTBaseFcpStSemDeducaoDeBaseIcms := AValue;
end;

function TParametrosCalculoFCP.DevolucaoInterestadualComProdutoSt(
  AValue: Boolean): IParametrosCalculoFCP;
begin
  Result := Self;
  FDevolucaoInterestadualComProdutoSt := AValue;
end;

function TParametrosCalculoFCP.DevolucaoInterestadualComProdutoSt: Boolean;
begin
  Result := FDevolucaoInterestadualComProdutoSt;
end;

function TParametrosCalculoFCP.CalculaFCPComReducaoBaseIcmsST(
  AValue: Boolean): IParametrosCalculoFCP;
begin
  Result := Self;
  FCalculaFCPComReducaoBaseIcmsST := AValue;
end;

function TParametrosCalculoFCP.CalculaFCPComReducaoBaseIcmsST: Boolean;
begin
  Result := FCalculaFCPComReducaoBaseIcmsST;
end;

function TParametrosCalculoFCP.CalcularBeneficioReducaoBaseIcmsST(
  AValue: Boolean): IParametrosCalculoFCP;
begin
  Result := Self;
  FCalcularBeneficioReducaoBaseIcmsST := AValue;
end;

function TParametrosCalculoFCP.CalcularBeneficioReducaoBaseIcmsST: Boolean;
begin
  Result := FCalcularBeneficioReducaoBaseIcmsST;
end;

function TParametrosCalculoFCP.ClienteEstado(
  AValue: String): IParametrosCalculoFCP;
begin
  Result := Self;
  FClienteEstado := AValue;
end;

function TParametrosCalculoFCP.ClienteEstado: String;
begin
  Result := FClienteEstado;
end;

function TParametrosCalculoFCP.DiferencaFCPST(
  AValue: Boolean): IParametrosCalculoFCP;
begin
  Result := Self;
  FDiferencaFCPST := AValue;
end;

function TParametrosCalculoFCP.DiferencaFCPST: Boolean;
begin
  Result := FDiferencaFCPST;
end;

function TParametrosCalculoFCP.DocumentoDeDevolucao: Boolean;
begin
  Result := FDocumentoDeDevolucao;
end;

function TParametrosCalculoFCP.DocumentoDeDevolucao(
  AValue: Boolean): IParametrosCalculoFCP;
begin
  Result := Self;
  FDocumentoDeDevolucao := AValue;
end;

function TParametrosCalculoFCP.OpcaoDeDocumento: String;
begin
  Result := FOpcaoDeDocumento;
end;

function TParametrosCalculoFCP.OpcaoDeDocumento(
  const AValue: String): IParametrosCalculoFCP;
begin
  Result := Self;
  FOpcaoDeDocumento := AValue;
end;

function TParametrosCalculoFCP.EspecieDoDocumento: String;
begin
  Result := FEspecieDoDocumento
end;

function TParametrosCalculoFCP.EspecieDoDocumento(
  const AValue: String): IParametrosCalculoFCP;
begin
  Result := Self;
  FEspecieDoDocumento := AValue;
end;

class function TParametrosCalculoFCP.New: IParametrosCalculoFCP;
begin
  Result := Self.Create;
end;

function TParametrosCalculoFCP.OutrasSaidasParaFornecedores: Boolean;
begin
  Result := FOutrasSaidasParaFornecedores;
end;

function TParametrosCalculoFCP.OutrasSaidasParaFornecedores(
  AValue: Boolean): IParametrosCalculoFCP;
begin
  Result := Self;
  FOutrasSaidasParaFornecedores := AValue;
end;

function TParametrosCalculoFCP.RecordDifalFCP: TRecDifalFCP;
begin
  Result := FRecordDifalFCP;
end;

function TParametrosCalculoFCP.RecordDifalFCP(
  AValue: TRecDifalFCP): IParametrosCalculoFCP;
begin
  Result := Self;
  FRecordDifalFCP := AValue;
end;

function TParametrosCalculoFCP.SubstituicaoTributariaDoItem(
  AValue: Boolean): IParametrosCalculoFCP;
begin
  Result := Self;
  FSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosCalculoFCP.SubstituicaoTributariaDoItem: Boolean;
begin
  Result := FSubstituicaoTributariaDoItem;
end;

function TParametrosCalculoFCP.VendaPresencial: Boolean;
begin
  Result := FVendaPresencial;
end;

function TParametrosCalculoFCP.VendaPresencial(
  AValue: Boolean): IParametrosCalculoFCP;
begin
  Result := Self;
  FVendaPresencial := AValue;
end;

function TParametrosCalculoFCP.ZerarFCP: Boolean;
begin
  Result := FZerarFCP;
end;

function TParametrosCalculoFCP.ZerarFCP(AValue: Boolean): IParametrosCalculoFCP;
begin
  Result := Self;
  FZerarFCP := AValue;
end;

function TParametrosCalculoFCP.ProdutoIndustrializadoDentroDoEstado: Boolean;
begin
  Result := FProdutoIndustrializadoDentroDoEstado;
end;

function TParametrosCalculoFCP.ProdutoEmbalagem: String;
begin
  Result := FProdutoEmbalagem;
end;

function TParametrosCalculoFCP.ProdutoEmbalagem(
  const AValue: String): IParametrosCalculoFCP;
begin
  Result := Self;
  FProdutoEmbalagem := AValue;
end;

function TParametrosCalculoFCP.ProdutoIndustrializadoDentroDoEstado(
  AValue: Boolean): IParametrosCalculoFCP;
begin
  Result := Self;
  FProdutoIndustrializadoDentroDoEstado := AValue;
end;

function TParametrosCalculoFCP.SimplesNacional: Boolean;
begin
  Result := FSimplesNacional;
end;

function TParametrosCalculoFCP.SimplesNacional(
  AValue: Boolean): IParametrosCalculoFCP;
begin
  Result := Self;
  FSimplesNacional := AValue;
end;

{ TResultadoCalculoFCP }

function TResultadoCalculoFCP.AliquotaDoFCPDoItem(
  AValue: Double): IResultadoCalculoFCP;
begin
  Result := Self;
  FAliquotaDoFCPDoItem := AValue;
end;

function TResultadoCalculoFCP.AliquotaDoFCPDoItem: Double;
begin
  Result := FAliquotaDoFCPDoItem;
end;

function TResultadoCalculoFCP.AliquotaFCPST(
  AValue: Double): IResultadoCalculoFCP;
begin
  Result := Self;
  FAliquotaFCPST := AValue;
end;

function TResultadoCalculoFCP.AliquotaFCPST: Double;
begin
  Result := FAliquotaFCPST;
end;

function TResultadoCalculoFCP.BaseDestino(AValue: Double): IResultadoCalculoFCP;
begin
  Result := Self;
  FBaseDestino := AValue;
end;

function TResultadoCalculoFCP.BaseDestino: Double;
begin
  Result := FBaseDestino;
end;

function TResultadoCalculoFCP.BaseFCP(AValue: Double): IResultadoCalculoFCP;
begin
  Result := Self;
  FBaseFCP := AValue;
end;

function TResultadoCalculoFCP.BaseFCP: Double;
begin
  Result := FBaseFCP;
end;

function TResultadoCalculoFCP.GravarOsRegistros(
  AValue: Boolean): IResultadoCalculoFCP;
begin
  Result := Self;
  FGravarOsRegistros := AValue;
end;

class function TResultadoCalculoFCP.New: IResultadoCalculoFCP;
begin
  Result := Self.Create;
end;

function TResultadoCalculoFCP.RecordDifalFCP: TRecDifalFCP;
begin
  Result := FRecordDifalFCP;
end;

function TResultadoCalculoFCP.RecordDifalFCP(
  AValue: TRecDifalFCP): IResultadoCalculoFCP;
begin
  Result := Self;
  FRecordDifalFCP := AValue;
end;

function TResultadoCalculoFCP.GravarOsRegistros: Boolean;
begin
  Result := FGravarOsRegistros;
end;

function TResultadoCalculoFCP.SairDoProcedimento: Boolean;
begin
  Result := FSairDoProcedimento;
end;

function TResultadoCalculoFCP.SairDoProcedimento(
  AValue: Boolean): IResultadoCalculoFCP;
begin
  Result := Self;
  FSairDoProcedimento := AValue;
end;

function TResultadoCalculoFCP.ValorFCP: Double;
begin
  Result := FValorFCP;
end;

function TResultadoCalculoFCP.ValorFCP(AValue: Double): IResultadoCalculoFCP;
begin
  Result := Self;
  FValorFCP := AValue;
end;

function TResultadoCalculoFCP.ZerarDifal: Boolean;
begin
  Result := FZerarDifal;
end;

function TResultadoCalculoFCP.ZerarDifal(
  AValue: Boolean): IResultadoCalculoFCP;
begin
  Result := Self;
  FZerarDifal := AValue;
end;

{ TParametrosCalculoDifalFcp }

function TParametrosCalculoDifalFcp.AliquotaDifalDoItem(
  AValue: Double): IParametrosCalculoDifalFcp;
begin
  Result := Self;
  FAliquotaDifalDoItem := AValue;
end;

function TParametrosCalculoDifalFcp.AliquotaDifalDoItem: Double;
begin
  Result := FAliquotaDifalDoItem;
end;

function TParametrosCalculoDifalFcp.AliquotaFCPDoItem: Double;
begin
  Result := FAliquotaFCPDoItem;
end;

function TParametrosCalculoDifalFcp.AliquotaFCPDoItem(
  AValue: Double): IParametrosCalculoDifalFcp;
begin
  Result := Self;
  FAliquotaFCPDoItem := AValue;
end;

function TParametrosCalculoDifalFcp.BaseDeCalculoDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FBaseDeCalculoDaSubstituicaoTributariaDoItem;
end;

function TParametrosCalculoDifalFcp.BaseDeCalculoDaSubstituicaoTributariaDoItem(
  AValue: Double): IParametrosCalculoDifalFcp;
begin
  Result := Self;
  FBaseDeCalculoDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosCalculoDifalFcp.BaseDestino: Double;
begin
  Result := FBaseDestino;
end;

function TParametrosCalculoDifalFcp.BaseDestino(
  AValue: Double): IParametrosCalculoDifalFcp;
begin
  Result := Self;
  FBaseDestino := AValue;
end;

function TParametrosCalculoDifalFcp.EnviarIcmsDifalDoDestinoNaPartilha: Boolean;
begin
  Result := FEnviarIcmsDifalDoDestinoNaPartilha;
end;

function TParametrosCalculoDifalFcp.EnviarIcmsDifalDoDestinoNaPartilha(
  AValue: Boolean): IParametrosCalculoDifalFcp;
begin
  Result := Self;
  FEnviarIcmsDifalDoDestinoNaPartilha := AValue;
end;

function TParametrosCalculoDifalFcp.EnviarIcmsDifalDoRemetenteNaPartilha: Boolean;
begin
  Result := FEnviarIcmsDifalDoRemetenteNaPartilha;
end;

function TParametrosCalculoDifalFcp.EnviarIcmsDifalDoRemetenteNaPartilha(
  AValue: Boolean): IParametrosCalculoDifalFcp;
begin
  Result := Self;
  FEnviarIcmsDifalDoRemetenteNaPartilha := AValue;
end;

function TParametrosCalculoDifalFcp.IcmsDeOrigem: Double;
begin
  Result := FIcmsDeOrigem;
end;

function TParametrosCalculoDifalFcp.IcmsDeDestino: Double;
begin
  Result := FIcmsDeDestino;
end;

function TParametrosCalculoDifalFcp.IcmsDeDestino(
  AValue: Double): IParametrosCalculoDifalFcp;
begin
  Result := Self;
  FIcmsDeDestino := AValue;
end;

function TParametrosCalculoDifalFcp.IcmsDeOrigem(
  AValue: Double): IParametrosCalculoDifalFcp;
begin
  Result := Self;
  FIcmsDeOrigem := AValue;
end;

class function TParametrosCalculoDifalFcp.New: IParametrosCalculoDifalFcp;
begin
  Result := Self.Create;
end;

function TParametrosCalculoDifalFcp.SimplesNacional(
  AValue: Boolean): IParametrosCalculoDifalFcp;
begin
  Result := Self;
  FSimplesNacional := AValue;
end;

function TParametrosCalculoDifalFcp.ZerarFCP: Boolean;
begin
  Result := FZerarFCP;
end;

function TParametrosCalculoDifalFcp.ZerarFCP(
  AValue: Boolean): IParametrosCalculoDifalFcp;
begin
  Result := Self;
  FZerarFCP := AValue;
end;

function TParametrosCalculoDifalFcp.SimplesNacional: Boolean;
begin
  Result := FSimplesNacional;
end;

{ TResultadoCalculoDifalFcp }

function TResultadoCalculoDifalFcp.AliquotaDifalDoItem(
  AValue: Double): IResultadoCalculoDifalFcp;
begin
  Result := Self;
  FAliquotaDifalDoItem := AValue;
end;

function TResultadoCalculoDifalFcp.AliquotaDifalDoItem: Double;
begin
  Result := FAliquotaDifalDoItem;
end;

function TResultadoCalculoDifalFcp.BaseFCP: Double;
begin
  Result := FBaseFCP;
end;

function TResultadoCalculoDifalFcp.BaseFCP(
  AValue: Double): IResultadoCalculoDifalFcp;
begin
  Result := Self;
  FBaseFCP := AValue;
end;

function TResultadoCalculoDifalFcp.IcmsDeDestino: Double;
begin
  Result := FIcmsDeDestino;
end;

function TResultadoCalculoDifalFcp.IcmsDeDestino(
  AValue: Double): IResultadoCalculoDifalFcp;
begin
  Result := Self;
  FIcmsDeDestino := AValue;
end;

function TResultadoCalculoDifalFcp.IcmsDeOrigem(
  AValue: Double): IResultadoCalculoDifalFcp;
begin
  Result := Self;
  FIcmsDeOrigem := AValue;
end;

function TResultadoCalculoDifalFcp.IcmsDeOrigem: Double;
begin
  Result := FIcmsDeOrigem;
end;

class function TResultadoCalculoDifalFcp.New: IResultadoCalculoDifalFcp;
begin
  Result := Self.Create;
end;

function TResultadoCalculoDifalFcp.ValorFCP: Double;
begin
  Result := FValorFCP;
end;

function TResultadoCalculoDifalFcp.ValorFCP(
  AValue: Double): IResultadoCalculoDifalFcp;
begin
  Result := Self;
  FValorFCP := AValue;
end;

end.
