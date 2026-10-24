unit untModuloRelEstatAbcVenRep;

interface

uses
  SysUtils, Classes, frxClass, frxExportRTF, frxExportHTML,
  frxExportXLS, frxExportPDF, frxDMPExport, frxDBSet;

type
  TfrmModuloRelEstatAbcVenRep = class(TDataModule)
    frxRelatorio: TfrxDBDataset;
    frxMatricial: TfrxDotMatrixExport;
    frxExpPDF: TfrxPDFExport;
    frxExpXLS: TfrxXLSExport;
    frxExpHtml: TfrxHTMLExport;
    frxExpRTF: TfrxRTFExport;
    frxRelatorioM: TfrxReport;
    frxRelatorioJ: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModuloRelEstatAbcVenRep: TfrmModuloRelEstatAbcVenRep;

implementation

{$R *.dfm}

procedure TfrmModuloRelEstatAbcVenRep.DataModuleCreate(Sender: TObject);
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
