unit untApplicationTitle;

interface

uses
  System.Classes, Vcl.Forms;

type
  TApplicationTitle = Class(TComponent)
  private
    class var strOriginalAppTitle : String;
  public
    class procedure pOnFormChange(AForm : TForm);
  end;

implementation

uses
  System.SysUtils;

{ TApplicationTitle }

class procedure TApplicationTitle.pOnFormChange(AForm : TForm);
var
  LstrCaption: String;
begin
  LstrCaption := AForm.Caption;

  if strOriginalAppTitle = '' then
    strOriginalAppTitle := Application.Title;

  if (LstrCaption = EmptyStr) then
    Exit;

  if (LstrCaption.ToLower.StartsWith('frm')) then
    Exit;


  Application.Title := strOriginalAppTitle + ' - ' + LstrCaption;
end;

end.
