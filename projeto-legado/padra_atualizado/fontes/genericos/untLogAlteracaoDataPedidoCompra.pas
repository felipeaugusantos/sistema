unit untLogAlteracaoDataPedidoCompra;

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
  TfrmLogAlteracaoDataPedidoCompra = class(TfrmPai)
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
    pnlAlteracaoPorProduto: TPanel;
    cxLogItens: TcxGrid;
    cxLogItensView: TcxGridDBTableView;
    cxLogItensCodItem: TcxGridDBColumn;
    cxLogItensDesItem: TcxGridDBColumn;
    cxLogItensDataAlteracao: TcxGridDBColumn;
    cxLogItensHoraAlteracao: TcxGridDBColumn;
    cxLogItensOperador: TcxGridDBColumn;
    cxLogItensDataAntiga: TcxGridDBColumn;
    cxLogItensDataNova: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    pnlAlteracaoPorProdutoTitulo: TPanel;
    pnlAlteracaoPorPedido: TPanel;
    pnlAlteracaoPorPedidoTitulo: TPanel;
    dtsDadosItens: TDataSource;
    procedure cxDadosViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxLogItensViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogAlteracaoDataPedidoCompra: TfrmLogAlteracaoDataPedidoCompra;

implementation

{$R *.dfm}

procedure TfrmLogAlteracaoDataPedidoCompra.cxDadosViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  mmoMotivo.DataSource := dtsDados;
end;

procedure TfrmLogAlteracaoDataPedidoCompra.cxLogItensViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  mmoMotivo.DataSource := dtsDadosItens;
end;

end.
