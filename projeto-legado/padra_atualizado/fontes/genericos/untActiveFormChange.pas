unit untActiveFormChange;

interface

uses
  System.Classes, Vcl.Forms;

type
  TActiveFormChange = Class(TComponent)
  public
    class procedure pOnActiveFormChange(Sender: TObject);
  end;

implementation

uses
  untApplicationTitle, untLogForm;

{ TActiveFormChange }

class procedure TActiveFormChange.pOnActiveFormChange(Sender: TObject);
Var
  LForm : TForm;
begin
  If Not Assigned(Screen) Then
    Exit;

  LForm := Screen.ActiveForm;

  If Not Assigned(LForm) Then
    Exit;

  TApplicationTitle.pOnFormChange(LForm);

  TLogForm.pOnFormChange(LForm);
end;

initialization
  Screen.OnActiveFormChange := TActiveFormChange.pOnActiveFormChange;

finalization
  Screen.OnActiveFormChange := Nil;

end.

