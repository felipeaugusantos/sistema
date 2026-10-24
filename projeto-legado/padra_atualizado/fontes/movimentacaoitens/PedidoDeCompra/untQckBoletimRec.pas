unit untQckBoletimRec;

interface

uses
  Forms, SysUtils, Classes, frxClass, frxDBSet, frxDMPExport;

type
  TfrmQckBoletimRec = class(TForm)
    frxReport: TfrxReport;
    frxDBRel: TfrxDBDataset;
    frxMatricial: TfrxDotMatrixExport;
    frxReportA4Retrato: TfrxReport;
    frxReportA4Paisagem: TfrxReport;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQckBoletimRec: TfrmQckBoletimRec;

implementation

{$R *.dfm}

procedure TfrmQckBoletimRec.FormCreate(Sender: TObject);
  var
    intContador:integer;
begin
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;

end;

end.
