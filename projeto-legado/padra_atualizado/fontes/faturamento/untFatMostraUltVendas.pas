unit untFatMostraUltVendas;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, UITypes,
  Grids, DBGridCitel, DBGrids, {Qt,} Menus, AppEvnts, Mask, DBCtrls, DBEditFocus, DB,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, DBMemoFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCurrencyEdit, cxMaskEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatMostraUltVendas = class(TfrmPaiSimples)
    pnlBotoesMostra: TPanel;
    btnFechar: TBitBtnLocked;
    pnlProduto: TPanel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dtsUltVen: TDataSource;
    pnlVenPer: TPanel;
    Label2: TLabel;
    dbeMotVpd: TDBEditFocus;
    chkExiVenPer: TCheckBox;
    Label3: TLabel;
    dbeObsVpd: TDBmEMOFocus;
    shp5: TShape;
    lbl5: TLabel;
    cxGrid1: TcxGrid;
    cxGrid1DBUltVendas: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1DBUltVendasDTAENT: TcxGridDBColumn;
    cxGrid1DBUltVendasCODEMP: TcxGridDBColumn;
    cxGrid1DBUltVendasNUMDOC: TcxGridDBColumn;
    cxGrid1DBUltVendasESPDOC: TcxGridDBColumn;
    cxGrid1DBUltVendasCLAFIS: TcxGridDBColumn;
    cxGrid1DBUltVendasCODVEN: TcxGridDBColumn;
    cxGrid1DBUltVendasQTDITE: TcxGridDBColumn;
    cxGrid1DBUltVendasUNIORI: TcxGridDBColumn;
    cxGrid1DBUltVendasUNILIQ: TcxGridDBColumn;
    cxGrid1DBUltVendasNOMCON: TcxGridDBColumn;
    cxGrid1DBUltVendasENDCON: TcxGridDBColumn;
    cxGrid1DBUltVendasCGCCON: TcxGridDBColumn;
    cxGrid1DBUltVendasNOMCID: TcxGridDBColumn;
    cxGrid1DBUltVendasESTCON: TcxGridDBColumn;
    cxGrid1DBUltVendasVENPER: TcxGridDBColumn;
    cxGrid1DBUltVendasDESITE: TcxGridDBColumn;
    cxGrid1DBUltVendasCFG_UNIORI: TcxGridDBColumn;
    cxGrid1DBUltVendasCFG_UNITAR: TcxGridDBColumn;
    cxGrid1DBUltVendasCFG_DESESP: TcxGridDBColumn;
    cxGrid1DBUltVendasDESCON: TcxGridDBColumn;
    cxGrid1DBUltVendasDET_VALIPI: TcxGridDBColumn;
    cxGrid1DBUltVendasDET_VALRET: TcxGridDBColumn;
    cxGrid1DBUltVendasDET_VFCPST: TcxGridDBColumn;
    cxGrid1DBUltVendasDET_TOTFRE: TcxGridDBColumn;
    cxGrid1DBUltVendasDET_VLRCON: TcxGridDBColumn;
    procedure btnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkExiVenPerClick(Sender: TObject);
    procedure cxGrid1DBUltVendasCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGrid1DBUltVendasEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmFatMostraUltVendas.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMostraUltVendas.chkExiVenPerClick(Sender: TObject);
begin
  inherited;

  If Not pnlVenPer.Visible Then
    Exit;

  With dtsUltVen.DataSet Do
  Begin
    Filtered := False;
    Filter   := '';

    If Not chkExiVenPer.Checked Then
    Begin
      Filter   := 'VENPER <> ' + QuotedStr('S');
      Filtered := True;
    End;
  End;

end;

procedure TfrmFatMostraUltVendas.cxGrid1DBUltVendasCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If Not cxGrid1DBUltVendas.DataController.DataSet.Active Then
    Exit;

  If cxGrid1DBUltVendas.DataController.DataSet.IsEmpty Then
    Exit;

  If (pnlVenPer.Visible) And
     (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxGrid1DBUltVendasVENPER.Index]) = 'S') Then
  Begin

    If ACanvas.Brush.Color <> clHighlight Then
      ACanvas.Brush.Color := clYellow
    Else
      ACanvas.Font.Color := clYellow;

  End;

end;

procedure TfrmFatMostraUltVendas.cxGrid1DBUltVendasEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
  Begin
    btnFechar.Click;
  End;
end;

procedure TfrmFatMostraUltVendas.FormCreate(Sender: TObject);
begin
  inherited;
  pnlVenPer.Visible := fCfgSis('EXVPF7', VarBoolean);
end;

end.
