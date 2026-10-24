unit untObsGarantia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Menus, Buttons, ExtCtrls, AppEvnts, MemoFocus,
  BitBtnLockedIncrem, EditFocus;

type
  TfrmObsGarantia = class(TfrmPai)
    lblMensagem: TLabel;
    edtObs1: TEditFocus;
    edtObs2: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    procedure memObsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmObsGarantia: TfrmObsGarantia;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmObsGarantia.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrok;
end;

procedure TfrmObsGarantia.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtObs1);
end;

procedure TfrmObsGarantia.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = Vk_F2 Then
  Begin
    Key := 0;
    btnConfirmar.Click;
  End;
end;

procedure TfrmObsGarantia.memObsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_ESCAPE Then
    pEscapePressed;

end;

end.
