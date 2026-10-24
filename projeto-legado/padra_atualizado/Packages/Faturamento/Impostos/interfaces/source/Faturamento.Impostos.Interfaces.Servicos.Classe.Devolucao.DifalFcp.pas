unit Faturamento.Impostos.Interfaces.Servicos.Classe.Devolucao.DifalFcp;

interface

type
  IParametrosClasseDevolucaoDifalFcp = interface
    ['{9BCD828C-2907-44E1-840C-E2BFB5754F4E}']

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
  end;

  IResultadoClasseDevolucaoDifalFcp = interface
    ['{0DB8CA8C-40E6-420C-8B1C-05FF27856795}']

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
  end;

  IServicoClasseDevolucaoDifalFcp = interface
    ['{D84F283C-2A33-4150-8825-665543573ADF}']

    function CarregarDocumentoDevolvido: IServicoClasseDevolucaoDifalFcp;
    function DocumentoExiste: Boolean;
    function CalcularProporcional: IServicoClasseDevolucaoDifalFcp;
    function RetornarResultado: IResultadoClasseDevolucaoDifalFcp;
  end;

implementation

end.
