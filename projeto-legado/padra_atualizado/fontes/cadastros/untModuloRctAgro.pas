unit untModuloRctAgro;

interface

uses
  SysUtils, Classes, frxExportRTF, frxDesgn, frxExportXLS,
  frxExportHTML, frxExportPDF, frxClass, frxDMPExport, frxDBSet,
  Forms;

type
  TfrmModuloRctAgro = class(TForm)
    frxRelatorio: TfrxDBDataset;
    frxMatricial: TfrxDotMatrixExport;
    frxExpPDF: TfrxPDFExport;
    frxExpHtml: TfrxHTMLExport;
    frxExpXLS: TfrxXLSExport;
    frxDesigner: TfrxDesigner;
    frxExpRTF: TfrxRTFExport;
    frxReportM: TfrxReport;
    frxReportJ: TfrxReport;
    frxParametros: TfrxUserDataSet;
    frxServAgro: TfrxReport;
    procedure frxParametrosGetValue(const VarName: string; var Value: Variant);
    function frxReportJUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure DataModuleCreate(Sender: TObject);
    procedure frxReportJGetValue(const VarName: string; var Value: Variant);
  private
    { Private declarations }
    function fFormataFoneInterna(strFone: String): String;    
  public
    { Public declarations }
    strDirImg: String;
  end;

var
  frmModuloRctAgro: TfrmModuloRctAgro;

implementation

uses untFuncoesGenerica, untFuncoesSimples;

{$R *.dfm}

procedure TfrmModuloRctAgro.DataModuleCreate(Sender: TObject);
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

  frxReportJ.AddFunction('function fFormataFoneInterna(strFone: String): String');
end;

function TfrmModuloRctAgro.fFormataFoneInterna(strFone: String): String;
begin
  Result := fFormataFone(strFone);
end;

procedure TfrmModuloRctAgro.frxParametrosGetValue(const VarName: string;
  var Value: Variant);
begin

  If FileExists(fCfgSis('PATLOG')) Then
       strDirImg := fCfgSis('PATLOG')
  Else strDirImg := '';

  If SameText('IMAGEM',VarName) Then
    Value := strDirImg;
end;

procedure TfrmModuloRctAgro.frxReportJGetValue(const VarName: string;
  var Value: Variant);
begin
  If VarName = 'MaskCNPJ' Then
    Value := fRetMascaraC_G_C_(fSetaPais, C_G_C_);
end;

function TfrmModuloRctAgro.frxReportJUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  If (SameText(MethodName, 'fFormataFoneInterna')) Then
    Result := fFormataFoneInterna(Trim(Params[0]));
end;

end.
