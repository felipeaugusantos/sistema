unit untFatDigMensagemEP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, untFuncFat, BitBtnLockedIncrem;

type
  TfrmFatDigMensagemEP = class(TfrmPaiEdit)
    btnConfirmaDados: TBitBtnLocked;
    Label1: TLabel;
    edtMens01: TEditFocus;
    edtMens02: TEditFocus;
    edtMens03: TEditFocus;
    edtMens04: TEditFocus;
    edtMens05: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    fatVenda: TFatVenda;
  end;

var
  frmFatDigMensagemEP: TfrmFatDigMensagemEP;

implementation

{$R *.dfm}

procedure TfrmFatDigMensagemEP.FormShow(Sender: TObject);
begin
  inherited;

  With fatVenda Do
  Begin
    edtMens01.Text := strMen001; 
    edtMens02.Text := strMen002;
    edtMens03.Text := strMen003;
    edtMens04.Text := strMen004;
    edtMens05.Text := strMen005;
  End;
  
end;

procedure TfrmFatDigMensagemEP.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrok Then
    With fatVenda Do
    Begin
      strMen001 := edtMens01.Text;
      strMen002 := edtMens02.Text;
      strMen003 := edtMens03.Text;
      strMen004 := edtMens04.Text;
      strMen005 := edtMens05.Text;
    End;

end;

end.
