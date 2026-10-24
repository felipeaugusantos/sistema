unit untRTTIEngineProgress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untRttiLayout, untRttiEngine,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, Vcl.StdCtrls, cxClasses, dxGaugeCustomScale,
  dxGaugeQuantitativeScale, dxGaugeCircularScale, dxGaugeControl;

type
  TfrmRTTIEngineProgress = class(TForm)
    dxGaugeControl: TdxGaugeControl;
    CircularScale: TdxGaugeCircularScale;
    lblInform: TLabel;
    procedure FormShow(Sender: TObject);
  private
    FClass : TLayout;
    procedure pExporta;
    procedure pOnTerminate(Sender: TObject);
  public
    class procedure pStart(objClass : TLayout);
  end;

implementation

{$R *.dfm}

{ TfrmRTTIEngineProgress }

procedure TfrmRTTIEngineProgress.FormShow(Sender: TObject);
Begin
  pExporta;
end;

procedure TfrmRTTIEngineProgress.pExporta;
  Var
    objEngine : TRTTIEngine;
begin
  objEngine := TRTTIEngine.Create(FClass, lblInform);
  objEngine.OnTerminate := pOnTerminate;
  objEngine.FreeOnTerminate := True;
  objEngine.Start;
End;

procedure TfrmRTTIEngineProgress.pOnTerminate(Sender : TObject);
Begin
  Self.Close;
End;

class procedure TfrmRTTIEngineProgress.pStart(objClass: TLayout);
  var
    frmRTTIEngineProgress: TfrmRTTIEngineProgress;
begin
  frmRTTIEngineProgress := TfrmRTTIEngineProgress.Create(Application);
  Try
    frmRTTIEngineProgress.FClass := objClass;
    frmRTTIEngineProgress.ShowModal;
  Finally
    FreeAndNil(frmRTTIEngineProgress);
  End;
end;

end.

