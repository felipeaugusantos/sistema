unit untSelOrdItens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, ExtCtrls, AppEvnts, Menus, Buttons,
  BitBtnLockedIncrem;

type
  TfrmSelOrdItens = class(TfrmPai)
    rdgOrdem: TRadioGroup;
    btnConfirma: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmSelOrdItens.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: Close;
    VK_F10   : btnConfirma.Click;
    VK_RETURN: If ActiveControl Is TRadioButton Then
                 SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmSelOrdItens.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(rdgOrdem.Controls[1] As TWinControl);
end;

end.
