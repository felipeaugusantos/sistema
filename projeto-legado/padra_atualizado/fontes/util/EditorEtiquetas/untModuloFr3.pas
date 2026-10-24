unit untModuloFr3;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet, DB, frxDMPExport,
  frxExportPDF, Forms;

Type
  TfrmModuloFr3 = class(TForm)
    frxRepor: TfrxReport;
    frxDBImpEti: TfrxDBDataset;
    frxReporM: TfrxReport;
    frxMatricial: TfrxDotMatrixExport;
    frxPDFExport: TfrxPDFExport;
    frxReportVias: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModuloFr3: TfrmModuloFr3;

implementation

{$R *.dfm}

procedure TfrmModuloFr3.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
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


