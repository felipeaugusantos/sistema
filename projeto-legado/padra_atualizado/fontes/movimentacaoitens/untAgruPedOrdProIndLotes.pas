unit untAgruPedOrdProIndLotes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmAgruPedOrdProIndLotes = class(TfrmPaiConfirma)
    cxgLotesLevel: TcxGridLevel;
    cxgLotesTableView: TcxGridDBTableViewCitel;
    cxgLotes: TcxGridCitel;
    cxGridCitel1TableViewNUMLOT: TcxGridDBColumn;
    cxGridCitel1TableViewLOCFIS: TcxGridDBColumn;
    cxGridCitel1TableViewDESCRI: TcxGridDBColumn;
    cxGridCitel1TableViewDTAVAL: TcxGridDBColumn;
    cxGridCitel1TableViewSALDOS: TcxGridDBColumn;
    cxGridCitel1TableViewESTUTI: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmAgruPedOrdProIndLotes.btnConfirmaClick(Sender: TObject);
begin
  cxgLotesTableView.DataController.DataSource.DataSet.CheckBrowseMode;
  If Not (cxgLotesTableView.DataController.DataSource.DataSet.State in DsEditModes) Then
  Begin
    inherited;
    ModalResult := MrOk;
  End;

end;

procedure TfrmAgruPedOrdProIndLotes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And (cxGridCitel1TableViewESTUTI.Focused) Then
    cxgLotesTableView.DataController.DataSource.DataSet.CheckBrowseMode;
end;

procedure TfrmAgruPedOrdProIndLotes.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(cxgLotes);
end;

end.
