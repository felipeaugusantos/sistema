unit untRelNossoNum;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxTextEdit,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGridExportLink, untFuncoesSimples, ShellApi,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmRelNossoNum = class(TfrmPai)
    grdDetalheDBTableView1: TcxGridDBTableView;
    grdDetalheLevel1: TcxGridLevel;
    grdDetalhe: TcxGrid;
    dsRegistros: TDataSource;
    grdDetalheDBTableView1CTR_NUMDUP: TcxGridDBColumn;
    grdDetalheDBTableView1CTR_PARCEL: TcxGridDBColumn;
    grdDetalheDBTableView1CTR_CLIENTE: TcxGridDBColumn;
    grdDetalheDBTableView1CTR_ESPDOC: TcxGridDBColumn;
    grdDetalheDBTableView1CTR_CODEMP: TcxGridDBColumn;
    grdDetalheDBTableView1CTR_VALORI: TcxGridDBColumn;
    grdDetalheDBTableView1CTR_NOSNUM: TcxGridDBColumn;
    grdDetalheDBTableView1CTR_BANCO_: TcxGridDBColumn;
    grdDetalheDBTableView1CTR_NOSNU_: TcxGridDBColumn;
    grdDetalheDBTableView1CTR_LINDIG: TcxGridDBColumn;
    grdDetalheDBTableView1CTR_DTAVEN: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure pExportaExcel;
  end;

var
  frmRelNossoNum: TfrmRelNossoNum;

implementation

{$R *.dfm}

{ TfrmRelNossoNum }

procedure TfrmRelNossoNum.pExportaExcel;
var
 strNomeArquivo: String;
begin
  strNomeArquivo := ExtractFilePath(Application.ExeName) + '\PlanilhaNossoNumero_' + FormatDateTime('ddmmyyyyhhnnss', VS_Date + fTime()) + '.xlsx';
  ExportGridToXLSX (strNomeArquivo, grdDetalhe);
  ShellExecute(Handle,'open', pchar(strNomeArquivo),nil, nil, SW_SHOWMAXIMIZED);
end;

end.
