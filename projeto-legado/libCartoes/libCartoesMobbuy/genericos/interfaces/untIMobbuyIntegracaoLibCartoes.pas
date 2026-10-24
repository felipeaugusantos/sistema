unit untIMobbuyIntegracaoLibCartoes;

interface

Uses
  Vcl.ComCtrls, Vcl.Forms, Vcl.StdCtrls, System.Generics.Collections,

  EditFocus, Uni, frxClass, cxProgressBar,

  untLibCartoesInterfacesTipos;

Type

  ICartoes = interface
    ['{565E1D87-F73C-4941-A1ED-6578469E383D}']
    procedure pAdicionaLinha(strString: String; pgbProg: TcxProgressBar);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);
  End;

implementation

end.
