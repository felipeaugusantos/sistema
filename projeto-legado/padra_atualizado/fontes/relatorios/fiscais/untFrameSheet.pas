unit untFrameSheet;

interface

uses ComCtrls, Forms;

Type
  TFrameSheet = class(TTabSheet)
    private
      FFrame: TFrame;
      procedure SetFrame(F: TFrame);
    public
      property Frame: TFrame Read FFrame Write SetFrame;
End;

implementation

{ TFrameSheet }

procedure TFrameSheet.SetFrame(F: TFrame);
begin
  FFrame := F;
  FFrame.Parent := Self;
end;

end.
