unit untIIntegracaoCartoes;

interface

Uses
  untIDataset, ComCtrls, frxClass,Forms,StdCtrls,EditFocus,Uni
  {$IF Defined(VER180)}
  {$ELSE}
  , System.Generics.Collections
  {$IFEND};
  
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

  TProcPreviewReport = procedure(const APrograma, ADescricao: String; AReport: IReport) of object;

  TFuncPesquisaEmpresa = function (ASelf     : TForm;                          {* Formulário                                   *}
                                   edtCodigo : TCustomEdit;                     {* Edit do Código                              *}
                                   edtNomEmp : TEditFocus;                      {* Edit do Nome da Empresa                     *}
                                   Var chrKey: Char): Boolean  of object;

  TFuncPesquisar = function (ASelf     : TForm;                          {* Formulário         *}
                             edtCodigo: TCustomEdit;                     {* Edit do Código     *}
                             edtDescri: TEditFocus;                      {* Edit Descrição     *}
                             Var chrKey: Char;
                             ACodPesquisa: String): Boolean of object;

  TFuncPedirLiberacao = Function (ADirAcesso:String; AMsgSenha:String;ATexto: String): Boolean of object;

  TFuncCriarQueryDLL = Function: TUniQuery of object;

  TFuncIncluirCartaoVenda = function (AAutoincremExtratoVenda: String): Boolean of object;

  TFuncAlterarCartaoVenda = function (AAutoincremCartao: String): Boolean of object;

  TProcChamaConciliacaoCartoes = procedure(ANomCon: String) of object;

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

  ITelasAbertas = interface
    ['{469E5741-FCD6-410E-B16D-8A42632BB767}']
   {$IFNDEF LINUX}
    function Forms : {$IF Defined(VER180)}TForm{$ELSE}TList<TForm>{$IFEND};
    function LastFormOpened : TForm;
    procedure AddFormAndSetPopupMode(FormOpened: TForm);
    procedure RemoveFormParent(FormClosing: TForm);
   {$ENDIF}
  end;

  {$IF Defined(VER180) OR Defined(VER270)}
  {$ELSE}
  ICartoesEditorRelatorios = interface
    ['{43E64C30-1D62-42D4-8E95-6C408A36EF6A}']
    {EDITOR RELATORIOS}
    procedure prcIExecutaRelatorio(intCodigoAtalho,
                                   intChaveDefault: integer;
                                   intChavesPossiveis: Array Of Integer;
                                   arrParametros: Array Of String;
                                   arrValores: Array Of String;
                                   SenderChamada: TObject;
                                   arrParametrosReadOnly: Array Of String;
                                   blnExecutarDireto: Boolean = False;
                                   blnExibirMensagem: Boolean = True;
                                   strDirAce: String = '';
                                   blnUsuarioLogadoDefaultVerdeVermelho: Boolean = False);
  End;
  {$IFEND}

implementation

end.
