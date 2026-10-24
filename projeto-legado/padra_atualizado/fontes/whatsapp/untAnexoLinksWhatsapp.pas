unit untAnexoLinksWhatsapp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxExportPDF;

type
  TfrmAnexoLinksWhatsapp = class(TForm)
    frxPdfLinksWhatsapp: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAnexoLinksWhatsapp: TfrmAnexoLinksWhatsapp;

implementation

{$R *.dfm}

end.
