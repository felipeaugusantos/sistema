unit untFatSelecProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, Grids, DBGridCitel, DBGrids, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, DB, DBCtrls, Uni, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid;

type
  TfrmFatSelecProduto = class(TfrmPaiSimples)
    pnlVariosEncontrados: TPanel;
    Label1: TLabel;
    cxvItens: TcxGridDBTableViewCitel;
    cxlItens: TcxGridLevel;
    cxgItens: TcxGridCitel;
    cxvItensCODITE: TcxGridDBColumn;
    cxvItensCODFAB: TcxGridDBColumn;
    cxvItensDESITE: TcxGridDBColumn;
    cxvItensDESMAR: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    dtsItens  : TDataSource;
    qryItens  : TUniQuery;
    { Public declarations }
  end;

var
  frmFatSelecProduto: TfrmFatSelecProduto;

implementation

{$R *.dfm}

procedure TfrmFatSelecProduto.FormShow(Sender: TObject);
begin
  inherited;
  dtsItens.DataSet := qryItens;
end;

procedure TfrmFatSelecProduto.FormCreate(Sender: TObject);
begin
  inherited;
  dtsItens := TDataSource.Create(Self);
  cxvItens.DataController.DataSource := dtsItens;
end;

procedure TfrmFatSelecProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    Close;
end;

end.
