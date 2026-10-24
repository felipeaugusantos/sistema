unit untCtrLiberacaoBusca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  MaskEditFocus, AppEvnts, BitBtnLockedIncrem;

type
  TfrmCtrLiberacaoBusca = class(TfrmPai)
    pnlGeral: TPanel;
    Label1: TLabel;
    edtNumPed: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCtrLiberacaoBusca: TfrmCtrLiberacaoBusca;

implementation

{$R *.dfm}

procedure TfrmCtrLiberacaoBusca.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  Close;
  ModalResult := mrOk;
end;

end.
