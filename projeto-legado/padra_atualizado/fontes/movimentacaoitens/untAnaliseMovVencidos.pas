unit untAnaliseMovVencidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, EditFocus,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmAnaliseMovVencidos = class(TfrmPaiEdit)
    pnlCadAna: TPanel;
    cxgLotesView: TcxGridDBTableView;
    cxgLotesLevel1: TcxGridLevel;
    cxgLotes: TcxGrid;
    Label7: TLabel;
    edtCodAna: TEditFocus;
    Label1: TLabel;
    edtPeriod: TEditFocus;
    cxgLotesCODORD: TcxGridDBColumn;
    cxgLotesDTACAD: TcxGridDBColumn;
    mmoMsg: TMemo;
    dtsLotes: TDataSource;
    cxgLotesCODIGO: TcxGridDBColumn;
    cxgLotesDTABAI: TcxGridDBColumn;
    cxgLotesSITUACAO: TcxGridDBColumn;
    cxgLotesDTAACO: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

end.
