unit untCustomWizardControl;

interface

uses
  System.Classes,
  System.Types,
  Vcl.Graphics,
  cxGraphics,
  dxCustomWizardControl,
  dxWizardControl,
  dxWizardControlViewStyleWizard97;

type
  TCustomPainter = class(TdxWizardControlViewStyleWizard97Painter)
  public
    procedure DrawBackground(ACanvas: TcxCanvas; const ABounds: TRect); override;
  end;

  TCustomViewInfo = class(TdxWizardControlViewStyleWizard97ViewInfo)
  protected
    function CreatePainter: TdxWizardControlCustomPainter; override;
  end;

  TdxWizardControl = class(dxWizardControl.TdxWizardControl)
  private
    FContentColor: TColor;
    procedure SetContentColor(const Value: TColor);
  protected
    function CreateViewInfo(): TdxWizardControlViewInfo; override;
  public
    constructor Create(AComponent: TComponent); override;
    property ContentColor: TColor read FContentColor write SetContentColor;
  end;

implementation

{ TCustomPainter }

procedure TCustomPainter.DrawBackground(ACanvas: TcxCanvas; const ABounds: TRect);
var
  Control: TdxWizardControl;
  ContentColor: TColor;
begin
  Control := WizardControl as TdxWizardControl;
  if (not Assigned(Control)) then
    Exit;

  ContentColor := Control.ContentColor;
  if (ContentColor = clNone) then
  begin
    inherited DrawBackground(ACanvas, ABounds);
    Exit;
  end;

  ACanvas.FillRect(Control.ClientRect, ContentColor);
end;

{ TCustomViewInfo }

function TCustomViewInfo.CreatePainter: TdxWizardControlCustomPainter;
begin
  Result := TCustomPainter.Create(WizardControl);
end;

{ TdxWizardControl }

constructor TdxWizardControl.Create(AComponent: TComponent);
begin
  inherited;
  FContentColor := clNone;
end;

function TdxWizardControl.CreateViewInfo(): TdxWizardControlViewInfo;
begin
  Result := TCustomViewInfo.Create(Self);
end;

procedure TdxWizardControl.SetContentColor(const Value: TColor);
begin
  if (FContentColor <> Value) then
  begin
    FContentColor := Value;
    Invalidate();
    if (Assigned(ActivePage)) then
      ActivePage.Invalidate();
  end;
end;

end.
