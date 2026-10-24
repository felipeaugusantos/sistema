unit untCadReceitAgronomicoReimpressao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, untZClient, untCadReceitAgronomico,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadReceitAgronomicoReimpressao = class(TfrmPaiSimples)
    pnlButtons: TPanel;
    btnImprimir: TBitBtnLocked;
    btnFechar: TBitBtnLocked;
    dbgMovGro: TcxGrid;
    dbgMovGroDBTableView: TcxGridDBTableView;
    dbgMovGroLevel: TcxGridLevel;
    dbgMovGroDBTableViewNUMREC: TcxGridDBColumn;
    dbgMovGroDBTableViewCODITE: TcxGridDBColumn;
    dbgMovGroDBTableViewCULTUR: TcxGridDBColumn;
    dbgMovGroDBTableViewDESITE: TcxGridDBColumn;
    dbgMovGroDBTableViewARTIGO: TcxGridDBColumn;
    dbgMovGroDBTableViewDIAGNO: TcxGridDBColumn;
    dbgMovGroDBTableViewINTAPL: TcxGridDBColumn;
    dbgMovGroDBTableViewNOMCOM: TcxGridDBColumn;
    dbgMovGroDBTableViewGRUQUI: TcxGridDBColumn;
    dbgMovGroDBTableViewCLATOX: TcxGridDBColumn;
    dbgMovGroDBTableViewCONCEN: TcxGridDBColumn;
    dbgMovGroDBTableViewPRIATI: TcxGridDBColumn;
    dbgMovGroDBTableViewFORMUL: TcxGridDBColumn;
    dbgMovGroDBTableViewPERCAR: TcxGridDBColumn;
    dbgMovGroDBTableViewDOSAPL: TcxGridDBColumn;
    dbgMovGroDBTableViewDOSESP: TcxGridDBColumn;
    dbgMovGroDBTableViewNUMAPL: TcxGridDBColumn;
    dbgMovGroDBTableViewAREREC: TcxGridDBColumn;
    dbgMovGroDBTableViewTOTADQ: TcxGridDBColumn;
    dbgMovGroDBTableViewMODAPL: TcxGridDBColumn;
    dbgMovGroDBTableViewEPOAPL: TcxGridDBColumn;
    dbgMovGroDBTableViewMANPRA: TcxGridDBColumn;
    dbgMovGroDBTableViewALARME: TcxGridDBColumn;
    dbgMovGroDBTableViewANTIDO: TcxGridDBColumn;
    dbgMovGroDBTableViewOBSERV: TcxGridDBColumn;
    dbgMovGroDBTableViewNOTFIS: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure dbgMovGroDBTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure dbgMovGroDBTableViewMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure dbgMovGroDBTableViewMouseLeave(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    intRecNo : Integer;
    cdsDados : TZClient;
    procedure pAbreDados;
  public
    frmReimpressao : TfrmCadReceitAgronomico;
  end;

var
  frmCadReceitAgronomicoReimpressao: TfrmCadReceitAgronomicoReimpressao;

implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TfrmCadReceitAgronomicoReimpressao }

procedure TfrmCadReceitAgronomicoReimpressao.btnImprimirClick(Sender: TObject);
begin
  inherited;
  frmReimpressao.strNumRec := cdsDados.FieldByName('MGR_NUMREC').AsString;
  frmReimpressao.strNumArt := cdsDados.FieldByName('MGR_ARTIGO').AsString;
  frmReimpressao.btnImprimirClick(Sender);
end;

procedure TfrmCadReceitAgronomicoReimpressao.dbgMovGroDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (intRecNo = AViewInfo.GridRecord.RecordIndex) then
    ACanvas.Brush.Color := clGray
  Else If Odd(AViewInfo.GridRecord.RecordIndex) Then
    ACanvas.Brush.Color := clMoneyGreen;
end;

procedure TfrmCadReceitAgronomicoReimpressao.dbgMovGroDBTableViewMouseLeave(
  Sender: TObject);
begin
  inherited;
  intRecNo := -2;
  (Sender as TcxGridSite).Repaint;
end;

procedure TfrmCadReceitAgronomicoReimpressao.dbgMovGroDBTableViewMouseMove(
  Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  Site: TcxGridSite;
  HitTest: TcxCustomGridHitTest;
begin
  Site := Sender as TcxGridSite;
  HitTest := Site.GridView.ViewInfo.GetHitTest(X, Y);
  if HitTest is TcxGridRecordCellHitTest then
  begin
    If TcxGridRecordCellHitTest(HitTest).Item.Index = 0 Then
      Screen.Cursor := crHandPoint
    Else
      Screen.Cursor := crDefault;
    intRecNo := TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex;
    Site.Repaint;
  end;

end;

procedure TfrmCadReceitAgronomicoReimpressao.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados := TZClient.Create(Self);
end;

procedure TfrmCadReceitAgronomicoReimpressao.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsDados);
  inherited;
end;

procedure TfrmCadReceitAgronomicoReimpressao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F7 Then
    btnImprimir.Click;
end;

procedure TfrmCadReceitAgronomicoReimpressao.FormShow(Sender: TObject);
begin
  inherited;
  pAbreDados;
  pSetFocus(dbgMovGro);

end;

procedure TfrmCadReceitAgronomicoReimpressao.pAbreDados;
begin
  With cdsDados, qryQuery.SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT ');
    Add('  MOVGRO.*, ');
    Add('  CONCAT(MGR_CODCLI, "-", MGR_NOMCLI) AS CLINOM, ');
    Add('  CONCAT(MGR_CIDCLI, "-", MGR_ESTCLI) AS CLICID, ');
    Add('  CONCAT(MGR_CODRES, "-", MGR_NOMRES) AS CLIRES, ');
    Add('  ITE_DESITE AS DESITE                           ');
    Add('FROM MOVGRO ');
    Add('  INNER JOIN CADITE ON ITE_CODITE = MGR_CODITE   ');
    Add('ORDER BY MGR_NUMREC DESC  ');

    fAbreClient(True, 'TfrmCadReceitAgronomicoReimpressao.pAbreDados');

    dbgMovGroDBTableView.ApplyBestFit();

  End;

  dbgMovGroDBTableView.DataController.DataSource := cdsDados.dtsSource;

end;

end.
