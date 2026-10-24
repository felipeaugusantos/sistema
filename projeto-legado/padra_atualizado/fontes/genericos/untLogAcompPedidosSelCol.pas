unit untLogAcompPedidosSelCol;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.CheckLst;

type
  TfrmLogAcompPedidosSelCol = class(TfrmPai)
    clbCamposTela: TCheckListBox;
    Label3: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmLogAcompPedidosSelCol.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key Of
    VK_ESCAPE: Close;
  else
    inherited;
  end;
end;

end.
