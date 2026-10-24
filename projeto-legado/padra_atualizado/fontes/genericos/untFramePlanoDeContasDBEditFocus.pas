unit untFramePlanoDeContasDBEditFocus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DBEditFocus, untPai,
  untTypesSistema, Vcl.Mask, Vcl.DBCtrls, EditFocus;

type
  {********************************************************************}
  {* apenas para acessar o método fValidaCampos do frmPai (protected) *}
  {*****************************************************************RP*}
  THackfrmPai = class(TfrmPai)
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

  TfraPlanoDeContasDBEditFocus = class(TFrame)
    edtDesCta: TEditFocus;
    dbeCodCta: TDBEditFocus;
    lblPlaContas: TLabel;
    procedure dbeCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodCtaExit(Sender: TObject);
    procedure dbeCodCtaEnter(Sender: TObject);
  private
    { Private declarations }
    arrPlaContas: TConsultasArray;
    blnTrocouOnKeyDown : Boolean;
    procedure OnKeyDownPlaCta(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    { Public declarations }
  end;

implementation

uses
  untConsultas, untFuncoesSimples,untFuncoesConsulta;

{$R *.dfm}


procedure TfraPlanoDeContasDBEditFocus.dbeCodCtaEnter(Sender: TObject);
begin
  dbeCodCta.Field.EditMask := '';
  If Not blnTrocouOnKeyDown Then
  Begin
    dbeCodCta.OnKeyDown := OnKeyDownPlaCta;
    blnTrocouOnKeyDown := True;
  End;
end;

procedure TfraPlanoDeContasDBEditFocus.dbeCodCtaExit(Sender: TObject);
begin
  If (Length(Trim(dbeCodCta.Text)) < 7) Then
    dbeCodCta.Field.EditMask := ''
  Else
    dbeCodCta.Field.EditMask := '99.99.999;0;_';
end;

procedure TfraPlanoDeContasDBEditFocus.dbeCodCtaKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqCentroCusto(TForm(Self.Owner), dbeCodCta, edtDesCta, Nil, Key, arrPlaContas, True) Then
  Begin
    If THackfrmPai(Self.Owner).fValidaCampos(dbeCodCta, True) Then
      Keybd_Event(VK_TAB, 0, 0, 0);
  End;
end;

{ THackfrmPai }

function THackfrmPai.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited;
end;

procedure TfraPlanoDeContasDBEditFocus.OnKeyDownPlaCta(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_RETURN) Then
  Begin
    dbeCodCta.Text := IIF(fEmptyStr(dbeCodCta.Text),dbeCodCta.Text,fGetPlanoDeContas(dbeCodCta.Text));
    If THackfrmPai(Self.Owner).fValidaCampos(dbeCodCta, True) Then
      Keybd_Event(VK_TAB, 0, 0, 0);
  End
  Else If (KEY = VK_ESCAPE) Then
    THackfrmPai(Self.Owner).btnSair.Click;
end;

end.
