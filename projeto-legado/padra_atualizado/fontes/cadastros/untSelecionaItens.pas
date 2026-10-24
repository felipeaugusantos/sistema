unit untSelecionaItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Uni,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmSelecionaItens = class(TfrmPaiEdit)
    cxgridItensDBTableView1: TcxGridDBTableView;
    cxgridItensLevel1: TcxGridLevel;
    cxgridItens: TcxGrid;
    cxgridItensDBTableView1Column1: TcxGridDBColumn;
    cxgridItensDBTableView1Column2: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    dsAux: TDataSource;
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgridItensDBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure cxgridItensDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FQueryAux: TUniQuery;
    FCodItem: String;
  public
    property strCodItem: String read FCodItem;
    property qryAux: TUniQuery read FQueryAux write FQueryAux;
  end;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmSelecionaItens.btnConfirmaClick(Sender: TObject);
begin
  FCodItem := FQueryAux.FieldByName('CODITE').AsString;

  Close;
end;

procedure TfrmSelecionaItens.cxgridItensDBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  btnConfirmaClick(Sender);
end;

procedure TfrmSelecionaItens.cxgridItensDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = Vk_Return) Then
    btnConfirmaClick(Sender);
end;

procedure TfrmSelecionaItens.FormShow(Sender: TObject);
begin
  inherited;
  dsAux.DataSet := FQueryAux;
  pSetFocus(cxgridItens);
end;

end.
