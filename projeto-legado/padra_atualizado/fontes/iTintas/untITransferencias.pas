unit untITransferencias;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'};
{$ELSE}
  untFuncoesSimples;
{$ENDIF}

type
  ITransferencias = Interface

    function fGetDicionario: TDicionario;
    function fGetNumeroTE: String;

    procedure pSetaDadosCliente(strCodCli, strCodVen: String);
    procedure pSetaProdutoAcabado(fltQtdIte: Double);
    procedure pSetaDadosIniciais(blnCriaTmp: Boolean = True);

    function fGeraTransferencia(strEspDoc: String = 'TE'; blnTEAutomatica: Boolean = False): Boolean;

  end;

implementation

end.
