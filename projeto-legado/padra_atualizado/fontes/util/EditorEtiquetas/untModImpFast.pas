unit untModImpFast;

interface

uses
  SysUtils, Classes, frxClass, frxDMPExport, frxExportPDF,
  frxExportCSVTestabilidade, Forms;

type
  TfrmModImpFast = class(TForm)
    frxMatricial: TfrxDotMatrixExport;
    frxReportJ: TfrxReport;
    frxReportM: TfrxReport;
    frxPDFExport: TfrxPDFExport;
    frxCSVExportTestabilidade: TfrxCSVExportTestabilidade;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TfrmModImpFast }

procedure TfrmModImpFast.FormCreate(Sender: TObject);
var
  LReport: TfrxReport;
  i:integer;
begin
  For i := 0 To Self.ComponentCount -1 Do
  Begin
    If (Self.Components[i] Is TfrxReport) Then
    Begin
      LReport := TfrxReport(Self.Components[i]);
      LReport.PreviewOptions.Buttons := LReport.PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;
end;

end.
