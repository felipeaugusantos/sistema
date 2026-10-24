unit untQckConsultaSCPC;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxExportPDF, frxDBSet, Forms, Data.DB;

type
  TfrmQckConsultaSCPC = class(TForm)
    frxExpPDF: TfrxPDFExport;
    frxReport: TfrxReport;
    frxPainel: TfrxDBDataset;
    frxRestricoes: TfrxDBDataset;
    frxChqSemF: TfrxDBDataset;
    frxChqSust: TfrxDBDataset;
    frxChqDevol: TfrxDBDataset;
    frxProtestos: TfrxDBDataset;
    frxRestricoesOcor: TfrxDBDataset;
    frxChqSemFOcor: TfrxDBDataset;
    frxChqSustOcor: TfrxDBDataset;
    frxChqDevolOcor: TfrxDBDataset;
    frxProtestosOcor: TfrxDBDataset;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQckConsultaSCPC: TfrmQckConsultaSCPC;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
