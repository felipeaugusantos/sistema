unit Contabilidade.View.TotalPlanco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxDropDownEdit, Datasnap.DBClient,
  UniClientDataSet, cxCalc, cxMaskEdit;

type
  TfrmTotalPlanco = class(TfrmPaiContabilidade)
    cxGrid: TcxGridCitel;
    cxGridView: TcxGridDBTableViewCitel;
    cxGridLevel: TcxGridLevel;
    cxGridViewCODEMP: TcxGridDBColumn;
    cxGridViewEXERCI: TcxGridDBColumn;
    cxGridViewCODCON: TcxGridDBColumn;
    cxGridViewSALINI: TcxGridDBColumn;
    cxGridViewDEBCRE: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    src: TDataSource;
    procedure cxGridViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure cxGridViewSALINIPropertiesEditValueChanged(Sender: TObject);
    procedure cxGridViewEXERCIPropertiesEditValueChanged(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    FCdsTot: TUniClientDataset;
    FConfirmou: Boolean;
  public
    property CdsTot: TUniClientDataset read FCdsTot write FCdsTot ;
    property Confirmou: Boolean read FConfirmou;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmTotalPlanco.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  FConfirmou := True;
  Close;
end;

procedure TfrmTotalPlanco.cxGridViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;

  AAllow := (AItem = cxGridViewEXERCI) or (AItem = cxGridViewSALINI) or (AItem = cxGridViewDEBCRE);
end;

procedure TfrmTotalPlanco.cxGridViewEXERCIPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;

  if (TcxMaskEdit(Sender).Text <> '') and (String(TcxMaskEdit(Sender).Text).Length < 4) then
  begin
    fMensagem('ATENÇÃO!', 'Informe um ano válido (4 dígitos)', ['&Ok']);
    TcxMaskEdit(Sender).Undo ;
    exit;
  end;

  TcxMaskEdit(Sender).PostEditValue ;
end;

procedure TfrmTotalPlanco.cxGridViewSALINIPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;

  if fFormataFloat(TcxCalcEdit(Sender).Value, 2) < 0 then
  begin
    fMensagem('ATENÇÃO!', 'Informe valores positivos!', ['&Ok']);
    TcxCalcEdit(Sender).Undo;
    exit ;
  end;

  TcxCalcEdit(Sender).PostEditValue ;
end;

procedure TfrmTotalPlanco.FormShow(Sender: TObject);
begin
  inherited;
  FConfirmou := False;
  src.DataSet := FCdsTot;
end;

end.

