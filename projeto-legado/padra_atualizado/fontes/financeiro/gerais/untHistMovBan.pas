unit untHistMovBan;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGrid, cxClasses, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Uni,
  cxButtons, System.ImageList, Vcl.ImgList,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageList;

type
  TfrmHistMovBan = class(TfrmPai)
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    grdHistBan: TcxGrid;
    grdHistBanDBTableView1: TcxGridDBTableView;
    grdHistBanDBTableView1Column1: TcxGridDBColumn;
    grdHistBanLevel1: TcxGridLevel;
    dsMovBan: TDataSource;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    grdHistBanDBTableView1Column2: TcxGridDBColumn;
    imglDiversas16: TcxImageList;
    cxButton5: TcxButton;
    Label2: TLabel;
    edtProcura: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdHistBanDBTableView1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdHistBanDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxButton5Click(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure edtProcuraKeyPress(Sender: TObject; var Key: Char);
    procedure grdHistBanDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    qryMovBan: TUniQuery;
    procedure pAbrirQuery;
  public
    { Public declarations }
    strDescri, strCodPor, strHisExt: String;
  end;

var
  frmHistMovBan: TfrmHistMovBan;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmHistMovBan.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  case Msg.Message of
    WM_KEYDOWN:
    begin
      if (Msg.wParam = VK_ESCAPE) then
      begin
        Msg.wParam := 0;
        Close;
      end;
    end;
  end;
end;

procedure TfrmHistMovBan.cxButton5Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmHistMovBan.edtProcuraKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if edtProcura.Text <> '' then
  begin
    qryMovBan.Filtered := False;
    qryMovBan.Filter   := 'CTB_HIST01 LIKE ' + QuotedStr('*' + edtProcura.Text + '*');
    qryMovBan.Filtered := True;
  end
  else
  begin
    qryMovBan.Filter   := '';
    qryMovBan.Filtered := False;
  end;
end;

procedure TfrmHistMovBan.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(qryMovBan) then
    FreeAndNil(qryMovBan);
end;

procedure TfrmHistMovBan.FormCreate(Sender: TObject);
begin
  inherited;
  qryMovBan := fCriaQuery;
  dsMovBan.DataSet := qryMovBan;
  strDescri := '';
end;

procedure TfrmHistMovBan.FormShow(Sender: TObject);
begin
  inherited;
  pAbrirQuery;
end;

procedure TfrmHistMovBan.grdHistBanDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strValor: String;
begin
  if AViewInfo.GridRecord.Selected then
     ACanvas.Brush.Color := clNavy;

  if AViewInfo.GridRecord.Index = -1 then
    Exit;

  strValor := VarAsType(grdHistBanDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ grdHistBanDBTableView1Column2.Index], varString);

  if (strValor <> '') and (not AViewInfo.GridRecord.Selected) then
    ACanvas.Brush.Color  := $00FFE4D5;
end;

procedure TfrmHistMovBan.grdHistBanDBTableView1DblClick(Sender: TObject);
begin
  inherited;
  strDescri := qryMovBan.FieldByName('CTB_HIST01').AsString;
  Close;
end;

procedure TfrmHistMovBan.grdHistBanDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = vk_Return then
  begin
    strDescri := qryMovBan.FieldByName('CTB_HIST01').AsString;
    Close;
  end;
end;

procedure TfrmHistMovBan.pAbrirQuery;
var
  strSql : String;
begin
  with qryMovBan do
  begin
    Sql.Clear;
    strSql   := ' SELECT DISTINCT  ' +
                '  E.EXT_HISTOR,   ' +
                '  M.CTB_HIST01,   ' +
                '  IF(E.EXT_CODPOR IS NOT NULL, E.EXT_CODPOR , "") AS EXT_CODPOR ' +
                ' FROM ' +
                '  MOVBAN M ' +
                ' LEFT JOIN EXTHIS E ON E.EXT_BANHIS = M.CTB_HIST01 ' +
                ' WHERE M.CTB_HIST01 <> "" AND M.CTB_HIST01 IS NOT NULL ';

    strSql := strSql + ' ORDER BY M.CTB_HIST01 ASC ';

    Sql.Text := strSql;

    Open;
    if (strCodPor <> '') and (strHisExt <> '') then
      Locate('EXT_HISTOR;EXT_CODPOR', VarArrayOf([strHisExt, strCodPor]), []);
  end;
end;

end.
