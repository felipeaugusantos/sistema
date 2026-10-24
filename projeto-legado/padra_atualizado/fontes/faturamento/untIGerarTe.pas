unit untIGerarTe;

interface

uses
  untFuncFatTypes;

type
  IGerarTE = Interface
    function  fGetNumeroTE: String;
    procedure pSetaDadosCliente(strCodCli, strCodVen: String);
    procedure pSetaProdutos(arrMatrizItensParam : TMatrizFechamento);
    procedure pSetaDadosIniciais;
    function  fGeraTransferencia(strEspDoc: String = 'TE'): Boolean;
  end;

implementation

end.
