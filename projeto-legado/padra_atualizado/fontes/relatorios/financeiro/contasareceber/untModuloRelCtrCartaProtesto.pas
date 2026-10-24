unit untModuloRelCtrCartaProtesto;

interface

uses
  SysUtils, Classes, frxClass, frxExportXLS, frxExportHTML, frxDMPExport,
  frxExportPDF, frxExportRTF, frxDBSet, RLFilters, RLDraftFilter,
  DB, Forms, UniClientDataSet;

type
  TfRemoveAcentoEspecificos = function (Str: String): String of Object;
  TfrmModuloRelCtrCartaProtesto = class(TForm)
    rldFiltro: TRLDraftFilter;
    frxRelatorio: TfrxDBDataset;
    frxGen: TfrxUserDataSet;
    frxExpRTF: TfrxRTFExport;
    frxExpPDF: TfrxPDFExport;
    frxMatricial: TfrxDotMatrixExport;
    frxExpHtml: TfrxHTMLExport;
    frxExpXLS: TfrxXLSExport;
    frxCarta_J: TfrxReport;
    frxCarta_M: TfrxReport;
    frxEmpresa: TfrxDBDataset;
    procedure DataModuleCreate(Sender: TObject);
    function frxCarta_MUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }
    function fFormataFonePaisInterna(strTelefo: String): String;    
  public
    { Public declarations }
    fRemoveAcentoEspecificos: TfRemoveAcentoEspecificos;
  end;

var
  frmModuloRelCtrCartaProtesto: TfrmModuloRelCtrCartaProtesto;

implementation

uses untFuncoesGenerica;

{$R *.dfm}

procedure TfrmModuloRelCtrCartaProtesto.DataModuleCreate(Sender: TObject);
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

  frxCarta_M.AddFunction('function fRemoveAcentoEspecificos(Str: String): String;');

  frxCarta_M.AddFunction('function fFormataFonePaisInterna(strTelefo: String): String');
  frxCarta_J.AddFunction('function fFormataFonePaisInterna(strTelefo: String): String');
end;

function TfrmModuloRelCtrCartaProtesto.fFormataFonePaisInterna(
  strTelefo: String): String;
begin
  Result := fFormataFone(strTelefo);
end;

function TfrmModuloRelCtrCartaProtesto.frxCarta_MUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
 If SameText(MethodName, 'fRemoveAcentoEspecificos') Then
    Result := fRemoveAcentoEspecificos(Params[0])
 Else If SameText(MethodName, 'fFormataFonePaisInterna') Then
    Result := fFormataFonePaisInterna(Params[0]);
end;

end.
