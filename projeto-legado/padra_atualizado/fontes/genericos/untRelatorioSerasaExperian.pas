unit untRelatorioSerasaExperian;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxDBSet, Data.DB,
  frxExportPDF, frxDesgn;

type
  TfrmRelatorioSerasaExperian = class(TForm)
    frxDBDataset_identificationReport: TfrxDBDataset;
    DataSource_identificationReport: TDataSource;
    frxPDFExportConsulta: TfrxPDFExport;
    frxRelatorioPJConsulta: TfrxReport;
    DataSource_Score: TDataSource;
    frxDBDataset_Score: TfrxDBDataset;
    DataSource_Negativedata_pefin: TDataSource;
    frxDBDataset_Negativedata_pefin: TfrxDBDataset;
    DataSource_Negativedata_refin: TDataSource;
    frxDBDataset_Negativedata_refin: TfrxDBDataset;
    DataSource_collectionRecords: TDataSource;
    frxDBDataset_collectionRecords: TfrxDBDataset;
    DataSource_check: TDataSource;
    frxDBDataset_check: TfrxDBDataset;
    DataSource_notary: TDataSource;
    frxDBDataset_notary: TfrxDBDataset;
    DataSource_judgementFilings: TDataSource;
    frxDBDataset_judgementFilings: TfrxDBDataset;
    DataSource_inquiryCompanyResponse: TDataSource;
    frxDBDataset_inquiryCompanyResponse: TfrxDBDataset;
    DataSource_QSAReport: TDataSource;
    frxDBDataset_QSAReport: TfrxDBDataset;
    DataSource_PartnerCompleteReport_Partners: TDataSource;
    frxDBDataset_PartnerCompleteReport_Partners: TfrxDBDataset;
    DataSource_DirectorCompleteReport_Directors: TDataSource;
    frxDBDataset_DirectorCompleteReport_Directors: TfrxDBDataset;
    DataSource_NegativeSummary: TDataSource;
    frxDBDataset_NegativeSummary: TfrxDBDataset;
    frxDesigner1: TfrxDesigner;
    DataSource_Bankrupts: TDataSource;
    frxDBDataset_Bankrupts: TfrxDBDataset;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
