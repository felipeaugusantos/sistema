unit untTabelaPrecoInconsistencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, frxExportTXT,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, Buttons, BitBtnLockedIncrem;

type
  TfrmTabelaPrecoInconsistencia = class(TfrmPaiRelatorio)
    frxReport: TfrxReport;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmTabelaPrecoInconsistencia.FormCreate(Sender: TObject);
begin
  inherited;
  TfrxMemoView(frxReport.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');
end;

end.
