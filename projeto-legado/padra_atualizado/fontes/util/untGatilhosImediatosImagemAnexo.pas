unit untGatilhosImediatosImagemAnexo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, Data.DB, Datasnap.DBClient,
  UniClientDataSet, frxDBSet, frxExportPDF, System.IOUtils;

type
  TfrmGatilhosImediatosImagemAnexo = class(TForm)
    frxPDFExport: TfrxPDFExport;
    frxNormal: TfrxReport;
    frxAlerta: TfrxReport;
  private
    { Private declarations }
  public
    { Public declarations }
    function fCriarPdf(intStatus: Integer; strCodGatilho, strCodOpe, strTitulo, strData, strInformacao: String): String;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TfrmGatilhosImediatosImagemAnexo }

function TfrmGatilhosImediatosImagemAnexo.fCriarPdf(intStatus: Integer; strCodGatilho, strCodOpe, strTitulo, strData, strInformacao: String): String;
var
  LFrx: TfrxReport;
begin
  Result := TPath.GetTempPath +
              strCodGatilho + '_' +
              FormatDateTime('yyyyMMdd', fNow) + '_' +
              FormatDateTime('hhmmss', fNow) + '_' +
              strCodOpe + '.pdf';

  frxPDFExport.FileName := Result;

  if intStatus = 1 then
    LFrx := frxNormal
  else
    LFrx := frxAlerta;

  LFrx.Script.Variables['strTitulo'] := strTitulo.ToUpper;
  LFrx.Script.Variables['strData']   := strData;
  LFrx.Script.Variables['strTexto']  := strInformacao;
  LFrx.Script.Variables['intCarac']  := strInformacao.Split([#13])[0].Length;

  LFrx.PrepareReport();
  LFrx.Export(frxPDFExport);
end;

end.
