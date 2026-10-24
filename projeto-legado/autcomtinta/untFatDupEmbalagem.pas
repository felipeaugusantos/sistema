unit untFatDupEmbalagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Menus, Buttons, ExtCtrls, EditFocus, AppEvnts,
  BitBtnLockedIncrem;

type
  TfrmFatDupEmbalagem = class(TfrmPai)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    chkDup1_8: TCheckBox;
    chkDup1_4: TCheckBox;
    chkDup1_2: TCheckBox;
    chkDupGal: TCheckBox;
    Label1: TLabel;
    edtQtdEmb: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    procedure chkDup1_8Click(Sender: TObject);
    procedure chkDup1_4Click(Sender: TObject);
    procedure chkDup1_2Click(Sender: TObject);
    procedure chkDupGalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strTipEmb: String;
  end;

var
  frmFatDupEmbalagem: TfrmFatDupEmbalagem;

implementation

uses  untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatDupEmbalagem.chkDup1_8Click(Sender: TObject);
begin
  inherited;
  If (chkDup1_8.Checked) Then
  Begin
    chkDup1_4.Checked := False;
    chkDup1_2.Checked := False;
    chkDupGal.Checked := False;
  End;
end;

procedure TfrmFatDupEmbalagem.chkDup1_4Click(Sender: TObject);
begin
  inherited;
  If (chkDup1_4.Checked) Then
  Begin
    chkDup1_8.Checked := False;
    chkDup1_2.Checked := False;
    chkDupGal.Checked := False;
  End;
end;

procedure TfrmFatDupEmbalagem.chkDup1_2Click(Sender: TObject);
begin
  inherited;
  If (chkDup1_2.Checked) Then
  Begin
    chkDup1_8.Checked := False;
    chkDup1_4.Checked := False;
    chkDupGal.Checked := False;
  End;
end;

procedure TfrmFatDupEmbalagem.chkDupGalClick(Sender: TObject);
begin
  inherited;
  If (chkDupGal.Checked) Then
  Begin
    chkDup1_8.Checked := False;
    chkDup1_4.Checked := False;
    chkDup1_2.Checked := False;
  End;
end;

procedure TfrmFatDupEmbalagem.FormCreate(Sender: TObject);
begin
  inherited;
  strTipEmb := '';
end;

procedure TfrmFatDupEmbalagem.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If (Not chkDup1_8.Checked) And
     (Not chkDup1_4.Checked) And
     (Not chkDup1_2.Checked) And
     (Not chkDupGal.Checked) Then
  Begin
    fMensagem('', 'É necessário escolher um volume!', ['&Ok']);
    Exit;
  End;

  If (chkDup1_8.Checked) Then
    strTipEmb := '1/8'
  Else If (chkDup1_4.Checked) Then
    strTipEmb := '1/4'
  Else If (chkDup1_2.Checked) Then
    strTipEmb := '1/2'
  Else If (chkDupGal.Checked) Then
    strTipEmb := 'GL';

  Close;
  ModalResult := mrOk;

end;

function TfrmFatDupEmbalagem.fValidaCampos(Sender: TWinControl;
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

  End;
end;

end.
