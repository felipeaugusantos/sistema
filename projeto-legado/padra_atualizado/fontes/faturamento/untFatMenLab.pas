unit untFatMenLab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, untPai, MemoFocus, StrUtils, BitBtnLockedIncrem;

type
  TfrmFatMenLab = class(TfrmPai)
    memMensagem: TMemoFocus;
    lblMensagem: TLabel;
    btnConfirma: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure memMensagemKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFatMenLab: TfrmFatMenLab;

implementation

{$R *.dfm}

procedure TfrmFatMenLab.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirma.Click;
    VK_Escape: btnSair.Click;
  End;

end;

procedure TfrmFatMenLab.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  Close;
  ModalResult := mrOk;
end;

procedure TfrmFatMenLab.memMensagemKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strKey: String;
begin
  inherited;
  strKey := AnsiUpperCase(Key);
  Key    := strKey[1]
end;

end.
