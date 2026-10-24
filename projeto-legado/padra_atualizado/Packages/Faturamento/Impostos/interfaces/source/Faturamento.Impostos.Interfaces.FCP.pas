unit Faturamento.Impostos.Interfaces.FCP;

interface

uses Shared.Functions.Types;

type
  IParametrosCalculoFCP = interface
    ['{93646A49-1AC4-4983-8860-79E7F69B549B}']

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
  end;

  IResultadoCalculoFCP = interface
    ['{4C902A06-E7E8-48C8-861B-60FEAD736E13}']

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
  end;

  IParametrosCalculoDifalFCP = interface
    ['{68B03E98-8932-4BDA-BD27-667F32235FE8}']

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
  end;

  IResultadoCalculoDifalFcp = interface
    ['{45B2D0BE-F46F-43C8-BBBF-1458179E587B}']

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
  end;

  ICalculoImpostosFCP = interface
    ['{81765513-9E7A-43E9-BA5A-0C8B889EABC6}']

    function CalcularValorFCP(AParametros: IParametrosCalculoFCP): IResultadoCalculoFCP; overload;

//    function CalcularValorDifalFcp(AParametros: IParametrosCalculoDifalFcp): IResultadoCalculoDifalFcp; overload;
  end;

  ICalculoImpostosDifalFcp = interface
    ['{29308D2D-EFC0-45DC-B92D-F4095053562C}']

    function CalcularValorDifalFcp(AParametros: IParametrosCalculoDifalFcp): IResultadoCalculoDifalFcp; overload;
  end;

implementation

end.
