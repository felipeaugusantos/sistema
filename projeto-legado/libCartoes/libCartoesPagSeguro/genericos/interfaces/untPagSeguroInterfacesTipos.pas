unit untPagSeguroInterfacesTipos;

interface

Uses System.Classes, System.SysUtils,Winapi.Windows, Winapi.Messages,

     cxProgressBar;

Type
  TPrintBClick = procedure(Sender: TObject) of Object;
  TOnPreview = procedure(Sender: TObject) of Object;

  IReport = interface
    ['{CE47EE24-0DDF-4856-AB50-0CF90D412D5E}']
    procedure PrepareReport;
    procedure ShowReport;
    procedure Print;
    procedure SaveToFile(AFile: String);
    procedure ExportarParaPDF(ATitle: String);
    function Printer: String;
    function Copies: String;
    function Collate: String;
    function PageNumbers: String;
    function PrintMode: String;
    function PrintOnSheet: String;
    function PrintPages: String;
    function PagesCount: Integer;
    function GetPrintBClick: TPrintBClick;
    procedure SetPrintBClick(AProc: TPrintBClick);
    procedure SetOnPreview(AProc: TOnPreview);
  end;

  ExceptionAutCom = Exception;

  {untGravando}
  TFunctionFormGravando = function(pgbProgresso: TcxProgressBar): Boolean Of Object;
  TGenericProcedure = procedure of object;
  TReferenceProcedure = reference to procedure;
  TGenericFunctionWithoutParam = function: Boolean of object;
  TBooleanFunctionWithBooleanParam = function(blnCheck : Boolean = False) : Boolean;
  TReferenceFunctionProgresso = reference to function(pgbProgresso: TcxProgressBar): Boolean;

  TProcMensagemOK = procedure(strmensagem: string);

  TOnMensagem = reference to procedure(ATexto: String);

Const
  CM_AVISOS = WM_USER + 1;

Var
  VS_ExibirMensagemAoUsuario: Boolean;
  VS_ExibirMensagemDeErro: Boolean;
  VS_ExibirMensagemAguarde: Boolean;
  VS_ExibirMensagemStayOnTop: Boolean;

  VS_OnMensagemAoUsuario: TOnMensagem;
  VS_OnMensagemDeErro: TOnMensagem;
  VS_OnMensagemAguarde: TOnMensagem;

implementation

Initialization
  VS_ExibirMensagemAoUsuario := True;
  VS_ExibirMensagemDeErro    := True;
  VS_ExibirMensagemAguarde   := True;
  VS_ExibirMensagemStayOnTop := False;

  VS_OnMensagemAoUsuario := nil;
  VS_OnMensagemDeErro    := nil;
  VS_OnMensagemAguarde   := nil;

end.
