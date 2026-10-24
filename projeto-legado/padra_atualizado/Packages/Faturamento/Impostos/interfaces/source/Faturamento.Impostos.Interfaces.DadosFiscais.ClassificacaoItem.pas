unit Faturamento.Impostos.Interfaces.DadosFiscais.ClassificacaoItem;

interface

type
  IParametrosDadosFiscaisClassificacaoItem = interface
    ['{0E29DCD2-0E7A-46B9-8834-04E62212BD0B}']
    function ClienteEstado : String; overload;
    function ClienteEstado(AValue: String): IParametrosDadosFiscaisClassificacaoItem; overload;

    function InscricaoEstadual: String; overload;
    function InscricaoEstadual(AValue: String): IParametrosDadosFiscaisClassificacaoItem; overload;

    function MicroEmpreendedor: Boolean;  overload;
    function MicroEmpreendedor(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function EmpresaEstado : String; overload;
    function EmpresaEstado(AValue: String): IParametrosDadosFiscaisClassificacaoItem; overload;

    function DocumentoDeVenda : Boolean; overload;
    function DocumentoDeVenda(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function DentroDoEstadoCFOP : Boolean; overload;
    function DentroDoEstadoCFOP(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function AtividadeConstrutora: Boolean; overload;
    function AtividadeConstrutora(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function NotaDevolucao: Boolean; overload;
    function NotaDevolucao(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function CfopDevolucao: String; overload;
    function CfopDevolucao(AValue: String): IParametrosDadosFiscaisClassificacaoItem; overload;

    function OpcaoDocumento : String; overload;
    function OpcaoDocumento(AValue: String): IParametrosDadosFiscaisClassificacaoItem; overload;

    function VendaPresencial : Boolean; overload;
    function VendaPresencial(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function ClassificacaoNotaEspiritoSanto : String; overload;
    function ClassificacaoNotaEspiritoSanto(AValue: String): IParametrosDadosFiscaisClassificacaoItem; overload;

    function ClassificacaoNfeComplemento : String;	overload;
    function ClassificacaoNfeComplemento(AValue: String): IParametrosDadosFiscaisClassificacaoItem; overload;

    function ConsertoDeEquipamento: Boolean; overload;
    function ConsertoDeEquipamento(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function ClassificacaoFiscal2: String;	overload;
    function ClassificacaoFiscal2(AValue: String): IParametrosDadosFiscaisClassificacaoItem; overload;

    function ClassificacaoFiscal3: String;	overload;
    function ClassificacaoFiscal3(AValue: String): IParametrosDadosFiscaisClassificacaoItem; overload;

    function DocumentoDeComplementoDeValores: Boolean; overload;
    function DocumentoDeComplementoDeValores(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function ClienteFilialEmpresaLogada: Boolean; overload;
    function ClienteFilialEmpresaLogada(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function NCFornecedor: Boolean; overload;
    function NCFornecedor(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function NfeComplementoMatrizPreenchida: Boolean; overload;
    function NfeComplementoMatrizPreenchida(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function NotaDeComplementoDeClienteComplementandoValor: Boolean; overload;
    function NotaDeComplementoDeClienteComplementandoValor(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

  end;

  IResultadoDadosFiscaisClassificacaoItem = interface
    ['{1A5FB75C-2B27-42FD-AA65-96CA22B4BC3C}']
    function ClassificacaoFiscal1: String; overload;
    function ClassificacaoFiscal1(AValue: String): IResultadoDadosFiscaisClassificacaoItem; overload;

    function ClassificacaoFiscal2: String; overload;
    function ClassificacaoFiscal2(AValue: String): IResultadoDadosFiscaisClassificacaoItem; overload;

    function ClassificacaoFiscal3: String; overload;
    function ClassificacaoFiscal3(AValue: String): IResultadoDadosFiscaisClassificacaoItem; overload;
  end;

  IRegraImpostosDadosFiscaisClassificacaoItem = interface
    ['{1824362E-D914-4D5D-A340-1D7D2CCFB9B7}']

    function DadosFiscaisClassificacaoDoItem(AParametros: IParametrosDadosFiscaisClassificacaoItem): IResultadoDadosFiscaisClassificacaoItem; overload;
  end;


implementation

end.
