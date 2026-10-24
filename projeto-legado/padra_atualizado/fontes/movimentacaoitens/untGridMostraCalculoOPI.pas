unit untGridMostraCalculoOPI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.Mask, Vcl.DBCtrls, DBEditFocus;

type
  TfrmGridMostraCalculoOPI = class(TfrmPai)
    btnOk: TBitBtnLocked;
    pnlTopo: TPanel;
    DBNumOpi: TDBEditFocus;
    Label1: TLabel;
    DBCustoFormula: TDBEditFocus;
    Label2: TLabel;
    Panel1: TPanel;
    cxgOrdCustoProdAca: TcxGrid;
    cxgOrdCustoProdAcaView: TcxGridDBTableView;
    cxgOrdCustoProdAcaViewColumn1: TcxGridDBColumn;
    cxgOrdCustoProdAcaViewColumn2: TcxGridDBColumn;
    cxgOrdCustoProdAcaViewColumn4: TcxGridDBColumn;
    cxgOrdCustoProdAcaViewColumn7: TcxGridDBColumn;
    cxgOrdCustoProdAcaViewColumn5: TcxGridDBColumn;
    cxgOrdCustoProdAcaViewColumn6: TcxGridDBColumn;
    cxgOrdCustoProdAcaViewColumn8: TcxGridDBColumn;
    cxgOrdCustoProdAcaViewColumn3: TcxGridDBColumn;
    cxgOrdCustoProdAcaViewColumn9: TcxGridDBColumn;
    cxgOrdCustoProdAcaLevel1: TcxGridLevel;
    procedure btnSairClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGridMostraCalculoOPI: TfrmGridMostraCalculoOPI;

implementation

{$R *.dfm}

procedure TfrmGridMostraCalculoOPI.btnOkClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TfrmGridMostraCalculoOPI.btnSairClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  inherited;

end;

end.
