unit untModuloRelBancReceitasXDespesas;

interface

uses
  SysUtils, Classes, frxDesgn, frxExportRTF, frxExportXLS,
  frxExportHTML, frxExportPDF, frxClass, frxDMPExport, frxDBSet;

type
  TfrmModuloRelBancReceitasXDespesas = class(TDataModule)
    frxRelatorio: TfrxDBDataset;
    frxGen: TfrxUserDataSet;
    frxMatricial: TfrxDotMatrixExport;
    frxExpPDF: TfrxPDFExport;
    frxExpHtml: TfrxHTMLExport;
    frxExpXLS: TfrxXLSExport;
    frxExpRTF: TfrxRTFExport;
    frxDesigner: TfrxDesigner;
    frxComandos: TfrxUserDataSet;
    frxRelBancSintM: TfrxReport;
    frxRelBancDespJ: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModuloRelBancReceitasXDespesas: TfrmModuloRelBancReceitasXDespesas;

implementation

{$R *.dfm}

procedure TfrmModuloRelBancReceitasXDespesas.DataModuleCreate(Sender: TObject);
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
