unit untQckAcertoConta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLParser, RLReport, RLPreviewForm, DB, RLFilters,
  RLPDFFilter, frxClass, frxDBSet, untPaiRelatorio, frxDesgn, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel, ExtCtrls,
  BitBtnLockedIncrem, Buttons, frxExportCSVTestabilidade;

type
  TfrmQckAcertoConta = class(TfrmPaiRelatorio)
    dtsCtaRec: TDataSource;
    frxReportJ: TfrxReport;
    frxReportM: TfrxReport;
    frxPreviaNeg: TfrxReport;
    frxParcelas: TfrxDBDataset;
    dtsParcelas: TDataSource;
    frxPDFExport: TfrxPDFExport;
    procedure FormCreate(Sender: TObject);
    function frxReportJUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmQckAcertoConta.FormCreate(Sender: TObject);
begin
  inherited;
  frxReportJ.AddFunction('function fTime(AForceTime: Boolean) : TDateTime');
  frxReportM.AddFunction('function fTime(AForceTime: Boolean) : TDateTime');
  frxPreviaNeg.AddFunction('function fTime(AForceTime: Boolean) : TDateTime');
end;

function TfrmQckAcertoConta.frxReportJUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  inherited;
  If (SameText(MethodName, 'fTime')) Then
    Result := fTime(Params[0]);
end;

end.

