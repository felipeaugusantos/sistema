unit Faturamento.Impostos.Interfaces.DadosFiscais.Aliquota;

interface

type
  IParametrosDadosFiscaisAliquota = interface
    ['{0E29DCD2-0E7A-46B9-8834-04E62212BD0B}']

    function ClienteEstado : String; overload;
    function ClienteEstado(AValue: String): IParametrosDadosFiscaisAliquota; overload;

    function InscricaoEstadual : String; overload;
    function InscricaoEstadual(AValue: String): IParametrosDadosFiscaisAliquota; overload;

    function MicroEmpreendedor : Boolean;  overload;
    function MicroEmpreendedor(AValue: Boolean): IParametrosDadosFiscaisAliquota; overload;

    function EmpresaEstado : String; overload;
    function EmpresaEstado(AValue: String): IParametrosDadosFiscaisAliquota; overload;

    function DocumentoDeVenda : Boolean;overload;
    function DocumentoDeVenda(AValue: Boolean): IParametrosDadosFiscaisAliquota; overload;

    function DentroDoEstadoCFOP : Boolean;overload;
    function DentroDoEstadoCFOP(AValue: Boolean): IParametrosDadosFiscaisAliquota; overload;

    function AtividadeConstrutora : Boolean;overload;
    function AtividadeConstrutora(AValue: Boolean): IParametrosDadosFiscaisAliquota; overload;

    function EspecieDocumento : String; overload;
    function EspecieDocumento(AValue: String): IParametrosDadosFiscaisAliquota; overload;
  end;

  IResultadoDadosFiscaisAliquota = interface
    ['{1A5FB75C-2B27-42FD-AA65-96CA22B4BC3C}']
    function AliquotaIcm: Double ; overload;
    function AliquotaIcm(AValue: Double): IResultadoDadosFiscaisAliquota; overload;

  end;

  IRegraImpostosDadosFiscaisAliquota = interface
    ['{1824362E-D914-4D5D-A340-1D7D2CCFB9B7}']

    function DadosFiscaisAliquotaDoItem(AParametros: IParametrosDadosFiscaisAliquota): IResultadoDadosFiscaisAliquota; overload;
  end;


implementation

end.
