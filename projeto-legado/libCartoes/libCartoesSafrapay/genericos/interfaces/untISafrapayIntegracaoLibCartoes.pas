unit untISafrapayIntegracaoLibCartoes;

interface

Uses
  Vcl.ComCtrls, Vcl.Forms, Vcl.StdCtrls, System.Generics.Collections,

  EditFocus, Uni, frxClass, cxProgressBar,

  untLibCartoesInterfacesTipos;

Type


  TFuncPedirLiberacao = Function (ADirAcesso:String; AMsgSenha:String;ATexto: String): Boolean of object;

  TFuncCriarQueryDLL = Function: TUniQuery of object;

  TFuncIncluirCartaoVenda = function (AAutoincremExtratoVenda: String): Boolean of object;

  TFuncAlterarCartaoVenda = function (AAutoincremCartao: String): Boolean of object;

  TProcChamaConciliacaoCartoes = procedure(ANomCon: String) of object;


  ICartoes = interface
    ['{565E1D87-F73C-4941-A1ED-6578469E383D}']
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);
  End;

implementation

end.
