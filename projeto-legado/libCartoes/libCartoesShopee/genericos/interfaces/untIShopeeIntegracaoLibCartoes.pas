unit untIShopeeIntegracaoLibCartoes;

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

  ICartoesShopee = interface
    ['{058404C5-D346-490C-9B78-0762CBD1D5C8}']
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(var pgbProg: TcxProgressBar);
  End;

implementation

end.
