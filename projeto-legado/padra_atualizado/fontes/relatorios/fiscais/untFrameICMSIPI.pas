unit untFrameICMSIPI;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ExtCtrls;
type
  TfrmFrameICMSIPI = class(TFrame)
    pnlDados: TPanel;
    grdIcms: TStringGrid;
    grdIpi: TStringGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    grdPis: TStringGrid;
    Panel5: TPanel;
    grdCofins: TStringGrid;
    procedure grdIcmsDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure grdIpiDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation


{$R *.dfm}

procedure TfrmFrameICMSIPI.grdIcmsDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  grdIcms.ColWidths[0] := 150;
  grdIcms.ColWidths[1] := 116;
  grdIcms.ColWidths[2] := 116;
  grdIcms.ColWidths[3] := 110;
  grdIcms.ColWidths[4] := 105;
  grdIcms.ColWidths[5] := 105;
end;

procedure TfrmFrameICMSIPI.grdIpiDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  grdIpi.ColWidths[0] := 156;
  grdIpi.ColWidths[1] := 126;
  grdIpi.ColWidths[2] := 126;
  grdIpi.ColWidths[3] := 126;
end;

end.


