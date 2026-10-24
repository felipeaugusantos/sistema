unit untDigExpressao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, AppEvnts, Menus, Buttons, ExtCtrls,
  untComponentMovel, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigExpressao = class(TfrmPai)
    mmoExpressao: TMemo;
    btnGravar: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    objComMov: TComponentMovel;
  end;

var
  frmDigExpressao: TfrmDigExpressao;

implementation

{$R *.dfm}

procedure TfrmDigExpressao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = mrOk) And (Not objComMov.fAvaliaExpressao(mmoExpressao)) Then
    Action := caNone;
end;

procedure TfrmDigExpressao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
    Begin
      Close;
    End;
end;

end.
