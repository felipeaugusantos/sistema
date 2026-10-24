unit untModuloBaixaChequesTelecheque;

interface

uses
  SysUtils, Classes, frxClass, frxDesgn, frxExportRTF,
  frxExportXLS, frxExportHTML, frxExportPDF, frxDMPExport, frxDBSet,
  Uni, Forms;

type
  TfrmModuloBaixaChequesTelecheque = class(TForm)
    frxBordero: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    frxGen: TfrxUserDataSet;
    frxMatricial: TfrxDotMatrixExport;
    frxExpPDF: TfrxPDFExport;
    frxExpHtml: TfrxHTMLExport;
    frxExpXLS: TfrxXLSExport;
    frxExpRTF: TfrxRTFExport;
    frxDesigner: TfrxDesigner;
    frxComandos: TfrxUserDataSet;
    procedure frxGenGetValue(const VarName: string; var Value: Variant);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strImagem: String;
    strNomeEmp: String;
  end;

var
  frmModuloBaixaChequesTelecheque: TfrmModuloBaixaChequesTelecheque;

implementation

// Esta unit está sendo compartilhada entre Autcom e DLL de ChequePre

{$R *.dfm}

procedure TfrmModuloBaixaChequesTelecheque.DataModuleCreate(Sender: TObject);
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

procedure TfrmModuloBaixaChequesTelecheque.frxGenGetValue(const VarName: string;
  var Value: Variant);
begin
  inherited;
  If SameText('IMAGEM', VarName) Then
    Value := strImagem
  Else If VarName = 'EMP_NOMEMP' Then
    Value := strNomeEmp
  Else If VarName = 'REL_NOMREL' Then
    Value := Self.Name;
end;

end.
