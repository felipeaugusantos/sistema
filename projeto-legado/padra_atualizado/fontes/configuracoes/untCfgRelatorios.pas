unit untCfgRelatorios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Mask, DBCtrls, DBEditFocus, QColorLabel,
  Menus, Buttons, ExtCtrls;

type
  TfrmCfgRelatorios = class(TfrmPai)
    pnlCentral: TPanel;
    Label8: TLabel;
    ColorLabel8: TColorLabel;
    Label148: TLabel;
    ColorLabel55: TColorLabel;
    dbeTipImp: TDBEditFocus;
    dbeFFFlux: TDBEditFocus;
    btnGravar: TBitBtn;
    Label1: TLabel;
    dbeZOOINI: TDBEditFocus;
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCfgRelatorios: TfrmCfgRelatorios;

implementation

uses untFuncoes, untfuncoesSimples;

{$R *.dfm}

{ TfrmCfgRelatorios }

function TfrmCfgRelatorios.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  {*****************************************}
  {* VALIDA O TIPO DE IMPRESSORA           *}
  {**************************************MV*}
  If (Sender = dbeTipImp) Then
  Begin
    If Not (dbeTipImp.Text[1] In ['J', 'M']) Then
    Begin
      Result := False;
    End;
  End

  {*****************************************}
  {* VALIDA O TIPO DE IMPRESSORA           *}
  {**************************************MV*}
  Else If (Sender = dbeFFFlux) Then
  Begin
    If Not (Pos(dbeFFFlux.Text,'S_N_') > 0) Then
    Begin
      Result := False;
    End;
  End

  {*****************************************}
  {* VALIDA O ZOOM INICIAL                 *}
  {**************************************MV*}
  Else If (Sender = dbeZOOINI) Then
  Begin

    If fEmptyStr(dbeZooIni.Text) Then
      Result := False
    Else If StrToInt(dbeZooIni.Text) <= 0 Then
      Result := False;

  End;

  If (Not Result) Then
    Sender.SetFocus;

end;

procedure TfrmCfgRelatorios.btnGravarClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) And (fMensagem('', 'Confirma alterações?', ['&Sim', '&Não']) = 1) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

initialization
  RegisterClass(TfrmCfgRelatorios);
finalization
  UnRegisterClass(TfrmCfgRelatorios);

end.

