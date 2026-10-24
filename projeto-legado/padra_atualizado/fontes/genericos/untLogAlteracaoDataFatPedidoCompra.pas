unit untLogAlteracaoDataFatPedidoCompra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCalendar, cxTimeEdit,
  Vcl.DBCtrls;

type
  TfrmLogAlteracaoDataFatPedidoCompra = class(TfrmPai)
    cxGrid1: TcxGrid;
    cxDadosView: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    dtsDados: TDataSource;
    cxDadosViewLogDta: TcxGridDBColumn;
    cxDadosViewLogHor: TcxGridDBColumn;
    cxDadosViewCodOpe: TcxGridDBColumn;
    cxDadosViewDtaAtu: TcxGridDBColumn;
    cxDadosViewDtaNov: TcxGridDBColumn;
    Panel1: TPanel;
    dbTxtPedido: TDBText;
    dbTxtFornecedor: TDBText;
    pnlMotivo: TPanel;
    mmoMotivo: TDBMemo;
    lblMotivo: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogAlteracaoDataFatPedidoCompra: TfrmLogAlteracaoDataFatPedidoCompra;

implementation

{$R *.dfm}

end.
