unit untModuloCalculaComissaoProfissionais;

interface

uses
  SysUtils, Classes, frxClass, frxDesgn, frxExportRTF,
  frxExportXLS, frxExportHTML, frxExportPDF, frxDMPExport, frxDBSet,
  Forms;

type
  TfrmModuloCalculaComissaoProfissionais = class(TForm)
    frxRelatorio: TfrxDBDataset;
    frxGen: TfrxUserDataSet;
    frxMatricial: TfrxDotMatrixExport;
    frxExpPDF: TfrxPDFExport;
    frxExpHtml: TfrxHTMLExport;
    frxExpXLS: TfrxXLSExport;
    frxExpRTF: TfrxRTFExport;
    frxDesigner: TfrxDesigner;
    frxComandos: TfrxUserDataSet;
    frxUser: TfrxUserDataSet;
    frxReciboJ: TfrxReport;
    frxReciboM: TfrxReport;
    frxRPAJ: TfrxReport;
    frxRPAM: TfrxReport;
    frxReportsBaixas: TfrxDBDataset;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModuloCalculaComissaoProfissionais: TfrmModuloCalculaComissaoProfissionais;

implementation

{$R *.dfm}

procedure TfrmModuloCalculaComissaoProfissionais.DataModuleCreate(
  Sender: TObject);
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
