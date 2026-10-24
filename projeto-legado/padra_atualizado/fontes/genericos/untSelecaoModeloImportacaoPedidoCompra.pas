unit untSelecaoModeloImportacaoPedidoCompra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untLayoutImportacaoPedidoCompra, cxGridCitel;

type
  TfrmSelecaoModeloImportacaoPedidoCompra = class(TfrmPaiConfirma)
    Panel1: TPanel;
    cxModelos: TcxGridCitel;
    cxModeloDB: TcxGridDBTableViewCitel;
    cxModeloslvl: TcxGridLevel;
    dtsModelos: TDataSource;
    Panel2: TPanel;
    btnDelete: TBitBtnLocked;
    btnEdit: TBitBtnLocked;
    btnNovo: TBitBtnLocked;
    cxModeloCodLay: TcxGridDBColumn;
    cxModeloDescri: TcxGridDBColumn;
    BitBtnLocked1: TBitBtnLocked;
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure BitBtnLocked1Click(Sender: TObject);
  private
    { Private declarations }
  public
     ObjImportaPlanilhaPedidoCompra: TImportaPlanilhaPedidoCompra;
    { Public declarations }
  end;

var
  frmSelecaoModeloImportacaoPedidoCompra: TfrmSelecaoModeloImportacaoPedidoCompra;

implementation

{$R *.dfm}

procedure TfrmSelecaoModeloImportacaoPedidoCompra.BitBtnLocked1Click(
  Sender: TObject);
begin
  inherited;
  ObjImportaPlanilhaPedidoCompra.pAbrirEditorDeLayout(tvVisualizacao);

end;

procedure TfrmSelecaoModeloImportacaoPedidoCompra.btnDeleteClick(
  Sender: TObject);
begin
  inherited;
  ObjImportaPlanilhaPedidoCompra.pRemoveModelo;
end;

procedure TfrmSelecaoModeloImportacaoPedidoCompra.btnEditClick(Sender: TObject);
begin
  inherited;
  ObjImportaPlanilhaPedidoCompra.pAbrirEditorDeLayout(tvEdicao);
end;

procedure TfrmSelecaoModeloImportacaoPedidoCompra.btnNovoClick(
  Sender: TObject);
begin
  inherited;

  ObjImportaPlanilhaPedidoCompra.pAbrirEditorDeLayout(tvInsercao);
end;

end.
