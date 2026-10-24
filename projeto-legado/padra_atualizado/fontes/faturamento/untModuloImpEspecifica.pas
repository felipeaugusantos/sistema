unit untModuloImpEspecifica;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet, frxDMPExport, frxExportODF,
  frxExportXLS, frxExportPDF;
  
type
  TfrmModuloImpEspecifica = class(TDataModule)
    frxCabecalho: TfrxDBDataset;
    frxRodape: TfrxDBDataset;
    frxImpressaoDelLama: TfrxReport;
    frxItens: TfrxDBDataset;
    frxImpressaoJvVidrosOR_PD_M: TfrxReport;
    frxMatricial: TfrxDotMatrixExport;
    frxImpressaoJvVidrosOR_PD_J: TfrxReport;
    frxExportaPDF: TfrxPDFExport;
    frxExportaXLS: TfrxXLSExport;
    frxExportaODS: TfrxODSExport;
    frxImpressaoJvVidrosRQ_M: TfrxReport;
    frxImpressaoJvVidrosRQ_J: TfrxReport;
    function frxImpressaoJvVidrosOR_PD_MUserFunction(const MethodName: string; var Params: Variant): Variant;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function fFormatFloat(fltValor: Double): String;
  public
    { Public declarations }
  end;

var
  frmModuloImpEspecifica: TfrmModuloImpEspecifica;

implementation

uses untFuncoesSimples;

{$R *.dfm}


procedure TfrmModuloImpEspecifica.DataModuleCreate(Sender: TObject);
begin
  frxImpressaoJvVidrosRQ_M.AddFunction('function fFormatFloat(fltValor: Double): String');
  frxImpressaoJvVidrosRQ_J.AddFunction('function fFormatFloat(fltValor: Double): String');
  frxImpressaoJvVidrosOR_PD_M.AddFunction('function fFormatFloat(fltValor: Double): String');
  frxImpressaoJvVidrosOR_PD_J.AddFunction('function fFormatFloat(fltValor: Double): String');
end;

function TfrmModuloImpEspecifica.fFormatFloat(fltValor: Double): String;
begin
  Result := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), fltValor);
end;

function TfrmModuloImpEspecifica.frxImpressaoJvVidrosOR_PD_MUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(MethodName, 'fFormatFloat') Then
    Result := fFormatFloat(Params[0]);
end;

end.
