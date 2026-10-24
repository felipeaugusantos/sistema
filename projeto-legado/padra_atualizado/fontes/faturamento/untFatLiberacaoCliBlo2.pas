unit untFatLiberacaoCliBlo2;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Menus, StrUtils, AppEvnts;

type
  TfrmFatLiberacaoCliBlo2 = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    edtNumLib: TEditFocus;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtn;
    btnCancelaDados: TBitBtn;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    intAcesso: Integer;    
  end;

var
  frmFatLiberacaoCliBlo2: TfrmFatLiberacaoCliBlo2;

implementation

uses untFuncoes, untfuncoesSimples, untFuncFat;

{$R *.dfm}

procedure TfrmFatLiberacaoCliBlo2.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatLiberacaoCliBlo2.btnConfirmaDadosClick(Sender: TObject);
  Var
    strTag  : String;
    strValor: String;
    strSenCli: String;
    strImagemIndex: Integer;
begin
  inherited;

  strValor := Copy(edtNumLib.Text,4,2);

  If StrToInt(strValor) > 0 Then
  Begin
    strTag := IntToStr(StrToInt(RightStr(edtNumLib.Text,Length(edtNumLib.Text) - 5)) Div strToInt(strValor));
  End
  Else
    strTag := RightStr(edtNumLib.Text,Length(edtNumLib.Text) - 5);

  {*******************************************}
  {* DIREITO DE ACESSO                       *}
  {****************************************AC*}
  strImagemIndex := fRetImagemIndexMenu(StrToInt(strTag));

  If intAcesso <> strImagemIndex Then
  Begin
    fMensagem('','Essa opção não é permitida para esse tipo de Liberação !', ['&O k']);
    Exit;
  End;    

  strSenCli := fRetornaSenCli(StrToInt(LeftStr(edtNumLib.Text,5)));

//  fRetCaptionMenu(StrToInt(strTag))
  fMensagem('', IIF(intAcesso = 3,'Senha de Liberação Preços','Senha de Liberação Geral') + #13 + 'Senha de Liberação: ' +
                strSenCli +
                fCriptografaOperador(strLoginUsuarioLogado, strSenCli), ['&O k']);
  Close;
end;

function TfrmFatLiberacaoCliBlo2.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumLib) Then
    Begin
      If fEmptyStr(edtNumLib.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O número de liberação deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    Sender.SetFocus;
end;

end.

