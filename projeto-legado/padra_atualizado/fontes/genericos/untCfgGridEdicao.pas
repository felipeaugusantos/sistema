unit untCfgGridEdicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxCheckBox, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCfgGridEdicao = class(TfrmPaiConfirma)
    pnlTitulo: TPanel;
    cxvColunas: TcxGridDBTableView;
    cxgColunasLevel1: TcxGridLevel;
    cxgColunas: TcxGrid;
    cxvColunasNOMBAN: TcxGridDBColumn;
    cxvColunasNOMCOL: TcxGridDBColumn;
    cxvColunasVISIVE: TcxGridDBColumn;
    cxvColunasBANIND: TcxGridDBColumn;
    cxvColunasCOLIND: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCfgGridEdicao: TfrmCfgGridEdicao;

implementation

{$R *.dfm}

end.
