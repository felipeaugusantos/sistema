unit untInfoExt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls, cxGroupBox,
  Vcl.AppEvnts, Vcl.Menus, cxButtons, System.ImageList, Vcl.ImgList, cxImageList;

type
  TfrmInfoExt = class(TForm)
    cxGroupBox1: TcxGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ApplicationEvents: TApplicationEvents;
    cxButton5: TcxButton;
    imglDiversas16: TcxImageList;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure cxButton5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInfoExt: TfrmInfoExt;

implementation

{$R *.dfm}

procedure TfrmInfoExt.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  case Msg.Message of
    WM_KEYDOWN:
    begin
      if (Msg.wParam = VK_ESCAPE) then
      begin
        Msg.wParam := 0;
        Close;
      end;
    end;
  end;
end;

procedure TfrmInfoExt.cxButton5Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmInfoExt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_Return then
    Close;
end;

procedure TfrmInfoExt.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
    Close;
end;

end.
