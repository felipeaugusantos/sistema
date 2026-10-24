unit untRelatorioSerasaPowerCurve;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxDBSet, Data.DB,
  frxExportPDF;

type
  TfrmRelatorioSerasaPowerCurve = class(TForm)
    frxRelatorioPFConsultaSPC: TfrxReport;
    frxDBDatasetNovaProposta: TfrxDBDataset;
    DataSourceNovaProposta: TDataSource;
    frxPDFExportNovaProposta: TfrxPDFExport;
    frxRelatorioPJConsultaPCC: TfrxReport;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
