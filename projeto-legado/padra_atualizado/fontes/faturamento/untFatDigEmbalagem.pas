unit untFatDigEmbalagem;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, EditFocus, Menus, ComCtrls,
  Buttons, ExtCtrls, QColorLabel, StrUtils, AppEvnts, BitBtnLockedIncrem;

type
  TfrmFatDigEmbalagem = class(TfrmPaiSimples)
    pnlDados: TPanel;
    Label1: TLabel;
    edtQtdEmb: TEditFocus;
    Label2: TLabel;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    edtTipEmb: TEditFocus;
    ColorLabel1: TColorLabel;
    procedure edtQtdEmbKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }

    strTipEmb: String;
    blnConfirma: Boolean;
  end;

var
  frmFatDigEmbalagem: TfrmFatDigEmbalagem;

implementation

uses untfuncoesSimples;

{$R *.dfm}

procedure TfrmFatDigEmbalagem.edtQtdEmbKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If CharInSet(Key, [',', '.']) Then
  Begin
    Key := #0;
  End;
end;

function TfrmFatDigEmbalagem.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtQtdEmb) Then
    Begin
      If fEmptyStr(edtQtdEmb.Text) Then
      Begin
        fMensagem('', 'A quantidade de embalagem deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (StrToInt(edtQtdEmb.Text) <= 0) Then
      Begin
        fMensagem('', 'A quantidade de embalagem deve ser maior que Zero!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtTipEmb) Then
    Begin

      If (fEmptyStr(edtTipEmb.Text)) Then
      Begin
        Result := False;
      End
      Else If (Pos(edtTipEmb.Text, 'LG') <= 0) Then
      Begin
        Result := False;
      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmFatDigEmbalagem.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmFatDigEmbalagem.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    If (edtTipEmb.Text = 'L') Then
      strTipEmb := 'LT'
    Else
      strTipEmb := 'GL';

    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmFatDigEmbalagem.FormShow(Sender: TObject);
begin
  inherited;
  edtTipEmb.Text := LeftStr(strTipEmb, 1);
end;

end.

