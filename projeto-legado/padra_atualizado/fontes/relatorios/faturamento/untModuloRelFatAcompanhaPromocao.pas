unit untModuloRelFatAcompanhaPromocao;

interface

uses
  SysUtils, Classes, frxDMPExport, frxClass, frxExportXLS, frxDesgn,
  frxExportHTML, frxDBSet, frxExportPDF, frxExportRTF;

type
  TfrmModuloRelFatAcompanhaPromocao = class(TDataModule)
    frxExpRTF: TfrxRTFExport;
    frxExpPDF: TfrxPDFExport;
    frxRelatorio: TfrxDBDataset;
    frxExpHtml: TfrxHTMLExport;
    frxDesigner: TfrxDesigner;
    frxExpXLS: TfrxXLSExport;
    frxComandos: TfrxUserDataSet;
    frxMatricial: TfrxDotMatrixExport;
    frxReportM: TfrxReport;
    frxReportJ: TfrxReport;
    frxGen: TfrxUserDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModuloRelFatAcompanhaPromocao: TfrmModuloRelFatAcompanhaPromocao;

implementation

{$R *.dfm}

procedure TfrmModuloRelFatAcompanhaPromocao.DataModuleCreate(Sender: TObject);
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
