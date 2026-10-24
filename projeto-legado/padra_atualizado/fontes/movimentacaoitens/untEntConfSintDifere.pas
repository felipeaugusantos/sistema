unit untEntConfSintDifere;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmEntConfSintDifere = class(TfrmPaiEdit)
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxgItensViewColumn1: TcxGridDBColumn;
    cxgItensViewColumn2: TcxGridDBColumn;
    cxgItensViewColumn3: TcxGridDBColumn;
    cxgItensViewColumn4: TcxGridDBColumn;
    cxgItensViewColumn5: TcxGridDBColumn;
    dtsItens: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEntConfSintDifere: TfrmEntConfSintDifere;

implementation

{$R *.dfm}

end.
