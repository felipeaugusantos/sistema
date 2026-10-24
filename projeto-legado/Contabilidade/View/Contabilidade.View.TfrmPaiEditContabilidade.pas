unit Contabilidade.View.TfrmPaiEditContabilidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Contabilidade.View.TfrmPaiContabilidade, Menus, StdCtrls, Buttons, ExtCtrls, CheckLst, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmPaiEditContabilidade = class(TfrmPaiContabilidade)
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnuConfigurarRelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    blnPassarRadioButtonComEnter: Boolean;
  end;

implementation

{$R *.dfm}

procedure TfrmPaiEditContabilidade.FormCreate(Sender: TObject);
begin
  inherited;

  blnPassarRadioButtonComEnter := True;
end;

procedure TfrmPaiEditContabilidade.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: If blnFecharComEscape Then
                 Close;


    VK_RETURN: If blnPassarRadioButtonComEnter And
                  ((ActiveControl Is TRadioButton)  Or
                   (ActiveControl Is TCheckListBox) Or
                   (ActiveControl Is TListBox))     Then
                  SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmPaiEditContabilidade.mnuConfigurarRelClick(Sender: TObject);
begin
  inherited;
  // nao remover este comentario, pois o evento deixara de funcionar
  // esta vinculado ao direito de acesso ao frmcadconfrelatorio
  // rl
end;

end.
