unit untRadioGroupAvisoEmbarque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TfrmRadioGroupAvisoEmbarque = class(TfrmPai)
    rdgAvisoEmbarque: TRadioGroup;
    btnGravar: TBitBtnLocked;
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

procedure TfrmRadioGroupAvisoEmbarque.btnGravarClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

end.
