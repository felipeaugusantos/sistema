unit untStepsBarPixFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, dxGDIPlusClasses, Vcl.StdCtrls;

type
  TfrmStepsBarPixFrame = class(TFrame)
    pnlFundo: TPanel;
    imgStep1: TImage;
    imgStep2: TImage;
    imgStep3: TImage;
    imgStep4: TImage;
    imgLine1: TImage;
    imgLine2: TImage;
    imgLine3: TImage;
    imgLineCheck: TImage;
    imgStepCheck: TImage;
    lblStep1: TLabel;
    lblStep2: TLabel;
    lblStep3: TLabel;
    lblStep4: TLabel;
    lblStepDesc1: TLabel;
    lblStepDesc2: TLabel;
    lblStepDesc3: TLabel;
    lblStepDesc4: TLabel;
  private
    { Private declarations }
  public
    procedure ConcluirStep(AStep: Integer);
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TfrmStepsBarPixFrame }

procedure TfrmStepsBarPixFrame.ConcluirStep(AStep: Integer);
begin
  case AStep of
    1: Begin
      imgStep1.Picture := imgStepCheck.Picture;
      lblStep1.Visible := False;
      imgLine1.Picture := imgLineCheck.Picture;
    End;
    2: Begin
      imgStep2.Picture := imgStepCheck.Picture;
      lblStep2.Visible := False;
      imgLine2.Picture := imgLineCheck.Picture;
    End;
    3: Begin
      imgStep3.Picture := imgStepCheck.Picture;
      lblStep3.Visible := False;
      imgLine3.Picture := imgLineCheck.Picture;
    End;
    4: Begin
      imgStep4.Picture := imgStepCheck.Picture;
      lblStep4.Visible := False;
    End;
  end;
end;

end.
