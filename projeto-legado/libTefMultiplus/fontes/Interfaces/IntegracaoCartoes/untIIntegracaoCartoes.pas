unit untIIntegracaoCartoes;

interface

Uses
  untIDataset, ComCtrls;
  
Type
  IIntegracaoCartoes = Interface
    ['{D5FB47CE-294B-4D84-8B7C-7E8C5EE7A83D}']
    function fGetDataSet: IDataSet;
    function fICurrentDate: String;
    function fIMensagem(const strTitulo: String; const strTexto: String; arrOpcoes: Array Of String;
      intFocoBotao: Integer = 1; blnSaiComEsc: Boolean = False; intEstFon: Integer = 1; intWidBut: Integer = 0;
      blnAutoSize: Boolean = False; intSomarTop: Integer = 0): Integer;

  End;

  ICartoes = interface
    ['{565E1D87-F73C-4941-A1ED-6578469E383D}']
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);
  End;

implementation

end.
