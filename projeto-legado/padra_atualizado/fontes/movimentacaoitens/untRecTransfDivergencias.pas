unit untRecTransfDivergencias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmRecTransfDivergencias = class(TfrmPaiConfirma)
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGrid;
    cxgColCodIte: TcxGridDBColumn;
    cxgColDesIte: TcxGridDBColumn;
    cxgColQtdAbe: TcxGridDBColumn;
    cxgColQtdNot: TcxGridDBColumn;
    dtsItens: TDataSource;
    mmoInform: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRecTransfDivergencias: TfrmRecTransfDivergencias;

implementation

{$R *.dfm}

end.
