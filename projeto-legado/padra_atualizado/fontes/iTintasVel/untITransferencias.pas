unit untITransferencias;

interface

uses
  untFuncoesSimples;

type
  ITransferencias = Interface

    function fGetDicionario: TDicionario;
    function fGetNumeroTE: String;

    procedure pSetaDadosCliente(strCodCli, strCodVen: String);
    procedure pSetaProdutoAcabado(fltQtdIte: Double);
    procedure pSetaDadosIniciais;

    function fGeraTransferencia: Boolean;
    
  end;

implementation

end.
