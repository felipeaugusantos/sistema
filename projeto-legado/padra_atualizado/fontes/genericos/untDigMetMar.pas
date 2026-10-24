unit untDigMetMar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Mask, MaskEditFocus, Menus, Buttons, ExtCtrls,
  AppEvnts, BitBtnLockedIncrem, EditFocus;

type
  TfrmDigMetMar = class(TfrmPai)
    pnlDados: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    lbl1: TLabel;
    edtTotMet: TEditFocus;
    lbl2: TLabel;
    edtMarMes: TEditFocus;
    pnlLitragem: TPanel;
    Label1: TLabel;
    edtTotLit: TEditFocus;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    blnConfirma : Boolean;
  end;

var
  frmDigMetMar: TfrmDigMetMar;

implementation

uses untfuncoesSimples;

{$R *.dfm}

procedure TfrmDigMetMar.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmDigMetMar.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmDigMetMar.FormShow(Sender: TObject);
begin
  inherited;

  pnlLitragem.Visible := (VS_strUsaTmq = 'S');

  If Not pnlLitragem.Visible Then
    Self.Height := Self.Height - pnlLitragem.Height;
end;

function TfrmDigMetMar.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtTotMet) Then
    Begin
      If fStrToFloat(edtTotMet.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Meta deve ser informada!', ['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtMarMes) Then
    Begin
      If fStrToFloat(edtMarMes.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Margem deve ser informada!', ['&OK']);
        Result := False;
      End
    End
    Else If (Sender = edtTotLit) And (pnlLitragem.Visible) Then
    Begin
      If fStrToFloat(edtTotLit.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Litragem deve ser informada!', ['&OK']);
        Result := False;
      End
    End;

    If Not Result Then
      pSetFocus(Sender);
      
  End;
end;

end.

