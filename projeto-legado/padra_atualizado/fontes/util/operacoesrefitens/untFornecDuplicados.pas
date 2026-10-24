unit untFornecDuplicados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  cxDataControllerConditionalFormattingRulesManagerDialog, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmFornecDuplicados = class(TfrmPaiEdit)
    mmo1: TMemo;
    cxgItens: TcxGrid;
    cxvItensView: TcxGridDBTableView;
    cxgItensViewColumn1: TcxGridDBColumn;
    cxgItensViewColumn2: TcxGridDBColumn;
    cxgItensViewColumn3: TcxGridDBColumn;
    cxgItensViewColumn4: TcxGridDBColumn;
    cxlItensLevel1: TcxGridLevel;
    dtsItens: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFornecDuplicados: TfrmFornecDuplicados;

implementation

{$R *.dfm}

end.
