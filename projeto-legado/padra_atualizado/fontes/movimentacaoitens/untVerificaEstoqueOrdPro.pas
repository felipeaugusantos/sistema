unit untVerificaEstoqueOrdPro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiRelatorio,
  frxExportCSVTestabilidade, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, RLFilters,
  RLDraftFilter, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus, QColorLabel,
  Vcl.ExtCtrls, Vcl.Buttons, BitBtnLockedIncrem;

type
  TfrmVerificaEstoqueOrdPro = class(TfrmPaiRelatorio)
    frxReport: TfrxReport;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
