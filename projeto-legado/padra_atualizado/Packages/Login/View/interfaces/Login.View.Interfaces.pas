unit Login.View.Interfaces;

interface

uses
  System.SysUtils;

type
  ELoginUsuarioException = class(Exception);
  ELoginEmpresaException = class(Exception);

  ILogin = interface
    ['{03163C45-E977-4628-A626-D22CD8A3F802}']
    function SetUsuario(AUsuario: String): ILogin;
    function Usuario(AUsuario: String): String;

    function NomeUsuario(): String;

    function SetUtilizaModoClassico(AUser: String; AValue: Boolean): ILogin;
    function UtilizaModoClassico(AUser: String): Boolean;

    function RealizandoLogoff(): Boolean;

    function SetPassword(APassword: String): ILogin;

    function SetEmpresa(AEmpresa: String): ILogin;
    function Empresa(): String;
    function NomeEmpresa: String; overload;
    function NomeEmpresa(ACodigoEmpresa: String): String; overload;
    function NomeFantasia(ACodigoEmpresa: String): String;

    function EmpresaDefault(): String;
    function EmpresasLoginUsuario(): String;

    function SelecionarEmpresa(strCodOpe: String = ''): Boolean;
    function ListaEmpresas(strCodOpe: String = ''): TArray<String>;

    procedure ValidarUsuario();
    procedure ValidarEmpresa(AValidaUsuarioTambem: Boolean = True);

    function ExecutarLogin(): Boolean;

    function LoginRealizado(): Boolean;

    function UsuarioLogado: String;
  end;

  ISplashNotificacaoProgresso = interface
    ['{9675459C-EE96-468C-A884-A8FD2217A52C}']
    function SetMax(AValue: Integer): ISplashNotificacaoProgresso;
    function Max(): Integer;

    function SetProgresso(AValue: Integer): ISplashNotificacaoProgresso;
    function Progresso(): Integer;

    function SetMensagem(AValue: String): ISplashNotificacaoProgresso;
    function Mensagem(): String;

    function SetDetalhes(AValue: String): ISplashNotificacaoProgresso;
    function Detalhes(): String;
  end;

  ISplashView = interface
    ['{C2154589-F7FA-43E7-866A-7CFAE2F31A46}']
    procedure NotificarProgresso(ANotificacao: ISplashNotificacaoProgresso);
  end;

  ISplash = interface
    ['{D48B259E-D949-473B-8C6B-3A9AFA01EEBC}']
    function AddView(AView: ISplashView): ISplash;
    function RemoveView(AView: ISplashView): ISplash;
    procedure NotificarViews(ANotificacao: ISplashNotificacaoProgresso);
    function ExecutarSplash(): Boolean;
    function SplashRealizado(): Boolean;
  end;

implementation

end.
