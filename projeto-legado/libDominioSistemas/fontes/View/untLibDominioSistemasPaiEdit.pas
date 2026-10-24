unit untLibDominioSistemasPaiEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untLibDominioSistemasPai, Menus, StdCtrls, Buttons, ExtCtrls, CheckLst, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmPaiDominioSistemasEdit = class(TfrmPaiDominioSistemas)
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

var
  frmPaiDominioSistemasEdit: TfrmPaiDominioSistemasEdit;

implementation

{$R *.dfm}

procedure TfrmPaiDominioSistemasEdit.FormCreate(Sender: TObject);
begin
  inherited;

  blnPassarRadioButtonComEnter := True;
end;

procedure TfrmPaiDominioSistemasEdit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: If blnFecharComEscape Then
                 Close;


    VK_RETURN: If blnPassarRadioButtonComEnter And
                  ((ActiveControl Is TRadioButton)  Or
                   (ActiveControl Is TCheckListBox) Or
                   (ActiveControl Is TComboBox)     Or
                   (ActiveControl Is TListBox))     Then
                  SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmPaiDominioSistemasEdit.mnuConfigurarRelClick(Sender: TObject);
begin
  inherited;
  // nao remover este comentario, pois o evento deixara de funcionar
  // esta vinculado ao direito de acesso ao frmcadconfrelatorio
  // rl
end;

end.
