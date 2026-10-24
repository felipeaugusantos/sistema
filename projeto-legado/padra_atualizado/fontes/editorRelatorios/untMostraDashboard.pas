unit untMostraDashboard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, VCL.TMSFNCTypes, VCL.TMSFNCUtils,
  VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes, VCL.TMSFNCCustomControl,
  VCL.TMSFNCWebBrowser, untGeraFR3;

type
  TfrmMostraDashboard = class(TfrmPaiEdit)
    TMSFNCWebBrowser: TTMSFNCWebBrowser;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    blnMontagem: Boolean;
    objGeraFr3: TGeraFR3;
  end;

var
  frmMostraDashboard: TfrmMostraDashboard;

implementation

{$R *.dfm}

procedure TfrmMostraDashboard.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  objGeraFr3.intAlturaGrafico  := Self.Height;
  objGeraFr3.intLarguraGrafico := Self.Width;
  objGeraFr3.blnMaximizado     := Self.WindowState = wsMaximized;
end;

procedure TfrmMostraDashboard.FormCreate(Sender: TObject);
begin
  inherited;

  objGeraFr3 := Nil;
  blnMontagem := True;
end;

procedure TfrmMostraDashboard.FormShow(Sender: TObject);
begin
  inherited;

  If objGeraFr3.intAlturaGrafico > 0 Then
  Begin
    Self.Height := objGeraFr3.intAlturaGrafico;
    Self.Width  := objGeraFr3.intLarguraGrafico;

    If objGeraFr3.blnMaximizado Then
      Self.WindowState := wsMaximized;
  End;

  If Not blnMontagem Then
    BorderStyle := bsDialog;
end;

end.
