unit Contabilidade.View.ApuracaoLucroRealIrpjCsllManRecolhimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxCalc, cxCheckBox;

type
  TfrmApuracaoLucroRealIrpjCsllManRecolhimento = class(TfrmPaiConfirmaContabilidade)
    GridCitelTableView: TcxGridDBTableViewCitel;
    GridCitelLevel1: TcxGridLevel;
    GridCitel: TcxGridCitel;
    pnlInformativo: TPanel;
    dsDados: TDataSource;
    GridCitelTableViewSELECIONADO: TcxGridDBColumn;
    GridCitelTableViewAUTOINCREM: TcxGridDBColumn;
    GridCitelTableViewCON_DTALAN: TcxGridDBColumn;
    GridCitelTableViewCON_VALLAN: TcxGridDBColumn;
    GridCitelTableViewCON_HISTOR: TcxGridDBColumn;
    GridCitelTableViewTIPO: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples ;

{$R *.dfm}

end.
