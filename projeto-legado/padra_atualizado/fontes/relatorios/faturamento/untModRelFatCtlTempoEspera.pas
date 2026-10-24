unit untModRelFatCtlTempoEspera;

interface

uses
  SysUtils, Classes, frxExportXLS, frxClass, frxDBSet, frxExportHTML,
  frxExportPDF, frxDMPExport, frxDesgn, frxExportRTF, DB, UniClientDataSet,
  Datasnap.DBClient;

type
  TfrmModRelFatCtlTempoEspera = class(TDataModule)
    frxExpRTF: TfrxRTFExport;
    frxDesigner: TfrxDesigner;
    frxComandos: TfrxUserDataSet;
    frxMatricial: TfrxDotMatrixExport;
    frxExpPDF: TfrxPDFExport;
    frxExpHtml: TfrxHTMLExport;
    frxRelatorio: TfrxDBDataset;
    frxGen: TfrxUserDataSet;
    frxExpXLS: TfrxXLSExport;
    cdsRelatorio: TUniClientDataSet;
    frxRelatorioM: TfrxReport;
    frxRelatorioJ: TfrxReport;
    cdsRelatorioNUMPED: TStringField;
    cdsRelatorioCODCLI: TStringField;
    cdsRelatorioNOMCLI: TStringField;
    cdsRelatorioDOCVEN: TStringField;
    cdsRelatorioCODMOT: TStringField;
    cdsRelatorioNOMMOT: TStringField;
    cdsRelatorioESPER1: TStringField;
    cdsRelatorioESPER2: TStringField;
    cdsRelatorioESPER3: TStringField;
    cdsRelatorioDTAPED: TStringField;
    cdsRelatorioHORPED: TStringField;
    cdsRelatorioDTAFAT: TStringField;
    cdsRelatorioHORFAT: TStringField;
    cdsRelatorioDTAENT: TStringField;
    cdsRelatorioHORENT: TStringField;
    cdsRelatorioDTACHE: TStringField;
    cdsRelatorioHORCHE: TStringField;
    cdsRelatorioTOTESP: TStringField;
    cdsRelatorioCTRFAT: TStringField;
    cdsRelatorioCTRENT: TStringField;
    cdsRelatorioCTRCHE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModRelFatCtlTempoEspera: TfrmModRelFatCtlTempoEspera;

implementation

{$R *.dfm}

procedure TfrmModRelFatCtlTempoEspera.DataModuleCreate(Sender: TObject);
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
