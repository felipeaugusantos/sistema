unit Impostos.Fat.Model.Empresa.Interfaces;

interface

type
  IResultadoImpostosFatModelEmpresa = interface
    ['{88AEE6BE-B469-408D-8CDB-A020DD1CA2F9}']

    function EmpresaEstado: String; overload;
    function EmpresaEstado(AValue: String): IResultadoImpostosFatModelEmpresa; overload;
  end;

  IImpostosFatModelEmpresa = interface
    ['{EA1F1FFC-1490-40D3-A261-872FC7F18CBE}']

    function Consultar(const ACodigoDaEmpresa: String): IResultadoImpostosFatModelEmpresa;
  end;

implementation

end.
