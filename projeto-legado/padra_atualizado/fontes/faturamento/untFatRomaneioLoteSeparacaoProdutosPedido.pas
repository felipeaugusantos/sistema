unit untFatRomaneioLoteSeparacaoProdutosPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, UniClientDataSet,
  Vcl.Mask, Vcl.DBCtrls, EditFocus;

type
  TfrmFatRomaneioLoteSeparacaoProdutosPedido = class(TfrmPai)
    cxgProdutos: TcxGridCitel;
    cxgProdutosTableView: TcxGridDBTableViewCitel;
    cxgProdutosLevel: TcxGridLevel;
    cxgProdutosColCodigo: TcxGridDBColumn;
    cxgProdutosColCodigoFabrica: TcxGridDBColumn;
    cxgProdutosColCodigoBarras: TcxGridDBColumn;
    cxgProdutosColDescricao: TcxGridDBColumn;
    cxgProdutosColUnidade: TcxGridDBColumn;
    cxgProdutosColLote: TcxGridDBColumn;
    cxgProdutosColReferencia: TcxGridDBColumn;
    cxgProdutosColMarca: TcxGridDBColumn;
    cxgProdutosColQuantidade: TcxGridDBColumn;
    cxgProdutosColPeso: TcxGridDBColumn;
    cxgProdutosColVendedor: TcxGridDBColumn;
    cdsMovPedido: TUniClientDataSet;
    cdsProdutosPedido: TUniClientDataSet;
    dtsProdutosPedido: TDataSource;
    cdsProdutosPedidoTOTALPESO: TAggregateField;
    pnlTotalizador: TPanel;
    Label1: TLabel;
    lblQuantidadeProdutos: TLabel;
    cdsProdutosPedidoCODITE: TStringField;
    cdsProdutosPedidoFABRIC: TStringField;
    cdsProdutosPedidoCODBAR: TStringField;
    cdsProdutosPedidoDESCRI: TStringField;
    cdsProdutosPedidoUNIDAD: TStringField;
    cdsProdutosPedidoNUMLOT: TStringField;
    cdsProdutosPedidoREFERE: TStringField;
    cdsProdutosPedidoDESMAR: TStringField;
    cdsProdutosPedidoQTDITE: TIntegerField;
    cdsProdutosPedidoTOTPES: TFloatField;
    cdsProdutosPedidoVENDED: TStringField;
    edtPesoTotal: TDBEdit;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmFatRomaneioLoteSeparacaoProdutosPedido.FormShow(Sender: TObject);
begin
  inherited;
  lblQuantidadeProdutos.Caption := 'Total de Produtos nos Pedidos: '+IntToStr(cdsProdutosPedido.RecordCount);
  cdsProdutosPedidoTOTALPESO.DisplayFormat := fMskDigitos(2);
  cdsProdutosPedidoQTDITE.DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  cdsProdutosPedidoTOTPES.DisplayFormat := fMskDigitos(2);
end;

end.
